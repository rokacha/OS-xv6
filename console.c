// Console input and output.
// Input is from the keyboard or serial port.
// Output is written to the screen and serial port.

#include "types.h"
#include "defs.h"
#include "param.h"
#include "traps.h"
#include "spinlock.h"
#include "fs.h"
#include "file.h"
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"
#include "x86.h"

static void consputc(int);

static int panicked = 0;

static struct {
  struct spinlock lock;
  int locking;
} cons;

static void
printint(int xx, int base, int sign)
{
  static char digits[] = "0123456789abcdef";
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
    x = -xx;
  else
    x = xx;

  i = 0;
  do{
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);

  if(sign)
    buf[i++] = '-';

  while(--i >= 0)
    consputc(buf[i]);
}
//PAGEBREAK: 50

// Print to the console. only understands %d, %x, %p, %s.
void
cprintf(char *fmt, ...)
{
  int i, c, locking;
  uint *argp;
  char *s;

  locking = cons.locking;
  if(locking)
    acquire(&cons.lock);

  if (fmt == 0)
    panic("null fmt");

  argp = (uint*)(void*)(&fmt + 1);
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
    if(c != '%'){
      consputc(c);
      continue;
    }
    c = fmt[++i] & 0xff;
    if(c == 0)
      break;
    switch(c){
    case 'd':
      printint(*argp++, 10, 1);
      break;
    case 'x':
    case 'p':
      printint(*argp++, 16, 0);
      break;
    case 's':
      if((s = (char*)*argp++) == 0)
        s = "(null)";
      for(; *s; s++)
        consputc(*s);
      break;
    case '%':
      consputc('%');
      break;
    default:
      // Print unknown % sequence to draw attention.
      consputc('%');
      consputc(c);
      break;
    }
  }

  if(locking)
    release(&cons.lock);
}

void
panic(char *s)
{
  int i;
  uint pcs[10];
  
  cli();
  cons.locking = 0;
  cprintf("cpu%d: panic: ", cpu->id);
  cprintf(s);
  cprintf("\n");
  getcallerpcs(&s, pcs);
  for(i=0; i<10; i++)
    cprintf(" %p", pcs[i]);
  panicked = 1; // freeze other CPU
  for(;;)
    ;
}

//PAGEBREAK: 50
#define BACKSPACE 0x100
#define KEY_UP    0xE2
#define KEY_DN    0xE3
#define KEY_LF    0xE4
#define KEY_RT    0xE5
#define CRTPORT 0x3d4

static ushort *crt = (ushort*)P2V(0xb8000);  // CGA memory

static void
cgaputc(int c)
{
  int pos;
  
  // Cursor position: col + 80*row.
  outb(CRTPORT, 14);
  pos = inb(CRTPORT+1) << 8;
  outb(CRTPORT, 15);
  pos |= inb(CRTPORT+1);

  if(c == '\n')
    pos += 80 - pos%80;
  else if(c == BACKSPACE){
    if(pos > 0) {
      --pos;
      crt[pos] = ' ' | 0x0700;
    }
  } else 
  if(c == KEY_LF){
    if(pos > 0){
      --pos;
    }
  }  else
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
  
  if((pos/80) >= 24){  // Scroll up.
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
    pos -= 80;
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
  }
  
  outb(CRTPORT, 14);
  outb(CRTPORT+1, pos>>8);
  outb(CRTPORT, 15);
  outb(CRTPORT+1, pos);
  //crt[pos] = ' ' | 0x0700;
}

void
consputc(int c)
{
  if(panicked){
    cli();
    for(;;)
      ;
  }
  else
  if(c == KEY_LF){
    uartputc('\b'); 
  } else
  if(c == BACKSPACE){
    uartputc('\b'); uartputc(' '); uartputc('\b');
  } else
    uartputc(c);
  cgaputc(c);
}

#define INPUT_BUF 128
#define MAX_HISTORY_LENGTH  20

struct {
  struct spinlock lock;
  char buf[INPUT_BUF];
  uint r;  // Read index
  uint w;  // Write index
  uint e;  // Edit index
  uint last;  // Edit index
  char history[INPUT_BUF][MAX_HISTORY_LENGTH];
  uint history_start;
  uint history_indx;
  uint history_end;
} input;

#define C(x)  ((x)-'@')  // Control-x

int 
replace_line_on_screen()
{
  int c;
  uint counter;

  while(input.e > input.w)
    {
      input.buf[input.e-- % INPUT_BUF] = 0;
      input.last--;
      consputc(BACKSPACE);
    }
    for(counter=0; c!=0 && c!='\n' && c!='\r' ;counter++)
    {
      c=input.history[input.history_indx % MAX_HISTORY_LENGTH ][counter];
      input.buf[input.e++ % INPUT_BUF] = c;
      input.last++;
      consputc(c);
    }
    return 0;
}

void
consoleintr(int (*getc)(void))
{
  int c;
  int i;
  acquire(&input.lock);
  while((c = getc()) >= 0){
    switch(c){
    case C('P'):  // Process listing.
      procdump();
      break;

    case C('U'):  // Kill line.
      while(input.e != input.w &&
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
        input.e--;
        input.last--;
        consputc(BACKSPACE);
      }
      break;

    case C('H'):    case '\x7f':  // Backspace
      if(input.e != input.w)
      {
        if(input.e<input.last){
          for (i =input.e;  i <= input.last;i++)
          {
            input.buf[(i-1)%INPUT_BUF]=input.buf[i%INPUT_BUF];
          }
          for (i = input.e; i < input.last; ++i)
          {
            consputc(KEY_RT);
          }
          for (i = input.e; i <= input.last; ++i)
          {
            consputc(BACKSPACE);
          }
          input.e--;
          input.last--;
          for (i = input.e; i < input.last; ++i)
          {
            consputc(input.buf[i%INPUT_BUF]);
          }
          for (i = input.e; i < input.last; ++i)
          {
            consputc(KEY_LF);
          }

        }
        else{
          input.e--;
          input.last--;
          consputc(BACKSPACE);
        }
      }
      break;

    case KEY_LF:  // left arrow
      if(input.e != input.w)
      {
        input.e--;
        consputc(c);
      }
      break;

    case KEY_RT:  // right arrow
      if(input.e < input.last)
      {
        consputc(input.buf[input.e% INPUT_BUF]);
        input.e++;
      }
      break;

      case KEY_DN:  // down arrow
      
      if((input.history_end % MAX_HISTORY_LENGTH) != (input.history_start % MAX_HISTORY_LENGTH) 
        && ((input.history_indx + 1) % MAX_HISTORY_LENGTH) != (input.history_end % MAX_HISTORY_LENGTH ))
      {
        input.history_indx++;
        replace_line_on_screen();
      }
      break;

      case KEY_UP:  // up arrow

      if((input.history_end % MAX_HISTORY_LENGTH) != (input.history_start % MAX_HISTORY_LENGTH)
       && ((input.history_indx) % MAX_HISTORY_LENGTH) != (input.history_start % MAX_HISTORY_LENGTH) )
      {
        input.history_indx--;
        replace_line_on_screen();
      }
      break;

    default:
      if(c != 0 && input.e-input.r < INPUT_BUF)
      {
        c = (c == '\r') ? '\n' : c;
        if(input.e<input.last && c!='\n')
        {
          for (i = input.last; i >= input.e; i--)
          {
            input.buf[(i + 1)% INPUT_BUF]=input.buf[i% INPUT_BUF];
          }
          input.buf[input.e % INPUT_BUF] = c;
          input.last++;
          input.e++;
          for (i =input.e-1 ; i <input.last ; i++)
          {
            consputc(input.buf[i%INPUT_BUF]);
          }
          for(i=0;i<(input.last-input.e);i++)
          {
            consputc(KEY_LF);
          }
        }
        else
        {
          if(c=='\n'){
            input.e=input.last;
          }
          input.buf[input.e++ % INPUT_BUF] = c;
          input.last++;
          consputc(c);
        }
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF)
        {
          strncpy(input.history[input.history_end % MAX_HISTORY_LENGTH]
            ,&input.buf[input.w% INPUT_BUF]
            ,input.last-input.w-1);
          input.history_indx=++input.history_end;
          if ((input.history_end % MAX_HISTORY_LENGTH) == (input.history_start % MAX_HISTORY_LENGTH))
          {
           input.history_start++;
          }
          input.w = input.e;
          wakeup(&input.r);
        }
      }
      break;
    }
  }
  release(&input.lock);
}



int
consoleread(struct inode *ip, char *dst, int n)
{
  uint target;
  int c;

  iunlock(ip);
  target = n;
  acquire(&input.lock);
  while(n > 0){
    while(input.r == input.w){
      if(proc->killed){
        release(&input.lock);
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &input.lock);
    }
    c = input.buf[input.r++ % INPUT_BUF];
    if(c == C('D')){  // EOF
      if(n < target){
        // Save ^D for next time, to make sure
        // caller gets a 0-byte result.
        input.r--;
      }
      break;
    }
    *dst++ = c;
    --n;
    if(c == '\n')
      break;
  }
  release(&input.lock);
  ilock(ip);

  return target - n;
}

int
consolewrite(struct inode *ip, char *buf, int n)
{
  int i;

  iunlock(ip);
  acquire(&cons.lock);
  for(i = 0; i < n; i++)
    consputc(buf[i] & 0xff);
  release(&cons.lock);
  ilock(ip);

  return n;
}

void
consoleinit(void)
{
  initlock(&cons.lock, "console");
  initlock(&input.lock, "input");

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;

  picenable(IRQ_KBD);
  ioapicenable(IRQ_KBD, 0);
}

