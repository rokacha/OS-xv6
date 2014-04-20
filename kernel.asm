
kernel:     file format elf32-i386


Disassembly of section .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4 0f                	in     $0xf,%al

8010000c <entry>:

# Entering xv6 on boot processor, with paging off.
.globl entry
entry:
  # Turn on page size extension for 4Mbyte pages
  movl    %cr4, %eax
8010000c:	0f 20 e0             	mov    %cr4,%eax
  orl     $(CR4_PSE), %eax
8010000f:	83 c8 10             	or     $0x10,%eax
  movl    %eax, %cr4
80100012:	0f 22 e0             	mov    %eax,%cr4
  # Set page directory
  movl    $(V2P_WO(entrypgdir)), %eax
80100015:	b8 00 b0 10 00       	mov    $0x10b000,%eax
  movl    %eax, %cr3
8010001a:	0f 22 d8             	mov    %eax,%cr3
  # Turn on paging.
  movl    %cr0, %eax
8010001d:	0f 20 c0             	mov    %cr0,%eax
  orl     $(CR0_PG|CR0_WP), %eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
  movl    %eax, %cr0
80100025:	0f 22 c0             	mov    %eax,%cr0

  # Set up the stack pointer.
  movl $(stack + KSTACKSIZE), %esp
80100028:	bc 90 db 10 80       	mov    $0x8010db90,%esp

  # Jump to main(), and switch to executing at
  # high addresses. The indirect call is needed because
  # the assembler produces a PC-relative instruction
  # for a direct jump.
  mov $main, %eax
8010002d:	b8 5b 3b 10 80       	mov    $0x80103b5b,%eax
  jmp *%eax
80100032:	ff e0                	jmp    *%eax

80100034 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
80100034:	55                   	push   %ebp
80100035:	89 e5                	mov    %esp,%ebp
80100037:	83 ec 28             	sub    $0x28,%esp
  struct buf *b;

  initlock(&bcache.lock, "bcache");
8010003a:	c7 44 24 04 a8 93 10 	movl   $0x801093a8,0x4(%esp)
80100041:	80 
80100042:	c7 04 24 a0 db 10 80 	movl   $0x8010dba0,(%esp)
80100049:	e8 48 5a 00 00       	call   80105a96 <initlock>

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
8010004e:	c7 05 d0 f0 10 80 c4 	movl   $0x8010f0c4,0x8010f0d0
80100055:	f0 10 80 
  bcache.head.next = &bcache.head;
80100058:	c7 05 d4 f0 10 80 c4 	movl   $0x8010f0c4,0x8010f0d4
8010005f:	f0 10 80 
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100062:	c7 45 f4 d4 db 10 80 	movl   $0x8010dbd4,-0xc(%ebp)
80100069:	eb 3a                	jmp    801000a5 <binit+0x71>
    b->next = bcache.head.next;
8010006b:	8b 15 d4 f0 10 80    	mov    0x8010f0d4,%edx
80100071:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100074:	89 50 10             	mov    %edx,0x10(%eax)
    b->prev = &bcache.head;
80100077:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010007a:	c7 40 0c c4 f0 10 80 	movl   $0x8010f0c4,0xc(%eax)
    b->dev = -1;
80100081:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100084:	c7 40 04 ff ff ff ff 	movl   $0xffffffff,0x4(%eax)
    bcache.head.next->prev = b;
8010008b:	a1 d4 f0 10 80       	mov    0x8010f0d4,%eax
80100090:	8b 55 f4             	mov    -0xc(%ebp),%edx
80100093:	89 50 0c             	mov    %edx,0xc(%eax)
    bcache.head.next = b;
80100096:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100099:	a3 d4 f0 10 80       	mov    %eax,0x8010f0d4

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
8010009e:	81 45 f4 18 02 00 00 	addl   $0x218,-0xc(%ebp)
801000a5:	81 7d f4 c4 f0 10 80 	cmpl   $0x8010f0c4,-0xc(%ebp)
801000ac:	72 bd                	jb     8010006b <binit+0x37>
    b->prev = &bcache.head;
    b->dev = -1;
    bcache.head.next->prev = b;
    bcache.head.next = b;
  }
}
801000ae:	c9                   	leave  
801000af:	c3                   	ret    

801000b0 <bget>:
// Look through buffer cache for sector on device dev.
// If not found, allocate fresh block.
// In either case, return B_BUSY buffer.
static struct buf*
bget(uint dev, uint sector)
{
801000b0:	55                   	push   %ebp
801000b1:	89 e5                	mov    %esp,%ebp
801000b3:	83 ec 28             	sub    $0x28,%esp
  struct buf *b;

  acquire(&bcache.lock);
801000b6:	c7 04 24 a0 db 10 80 	movl   $0x8010dba0,(%esp)
801000bd:	e8 f5 59 00 00       	call   80105ab7 <acquire>

 loop:
  // Is the sector already cached?
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000c2:	a1 d4 f0 10 80       	mov    0x8010f0d4,%eax
801000c7:	89 45 f4             	mov    %eax,-0xc(%ebp)
801000ca:	eb 63                	jmp    8010012f <bget+0x7f>
    if(b->dev == dev && b->sector == sector){
801000cc:	8b 45 f4             	mov    -0xc(%ebp),%eax
801000cf:	8b 40 04             	mov    0x4(%eax),%eax
801000d2:	3b 45 08             	cmp    0x8(%ebp),%eax
801000d5:	75 4f                	jne    80100126 <bget+0x76>
801000d7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801000da:	8b 40 08             	mov    0x8(%eax),%eax
801000dd:	3b 45 0c             	cmp    0xc(%ebp),%eax
801000e0:	75 44                	jne    80100126 <bget+0x76>
      if(!(b->flags & B_BUSY)){
801000e2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801000e5:	8b 00                	mov    (%eax),%eax
801000e7:	83 e0 01             	and    $0x1,%eax
801000ea:	85 c0                	test   %eax,%eax
801000ec:	75 23                	jne    80100111 <bget+0x61>
        b->flags |= B_BUSY;
801000ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
801000f1:	8b 00                	mov    (%eax),%eax
801000f3:	89 c2                	mov    %eax,%edx
801000f5:	83 ca 01             	or     $0x1,%edx
801000f8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801000fb:	89 10                	mov    %edx,(%eax)
        release(&bcache.lock);
801000fd:	c7 04 24 a0 db 10 80 	movl   $0x8010dba0,(%esp)
80100104:	e8 10 5a 00 00       	call   80105b19 <release>
        return b;
80100109:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010010c:	e9 93 00 00 00       	jmp    801001a4 <bget+0xf4>
      }
      sleep(b, &bcache.lock);
80100111:	c7 44 24 04 a0 db 10 	movl   $0x8010dba0,0x4(%esp)
80100118:	80 
80100119:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010011c:	89 04 24             	mov    %eax,(%esp)
8010011f:	e8 05 55 00 00       	call   80105629 <sleep>
      goto loop;
80100124:	eb 9c                	jmp    801000c2 <bget+0x12>

  acquire(&bcache.lock);

 loop:
  // Is the sector already cached?
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
80100126:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100129:	8b 40 10             	mov    0x10(%eax),%eax
8010012c:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010012f:	81 7d f4 c4 f0 10 80 	cmpl   $0x8010f0c4,-0xc(%ebp)
80100136:	75 94                	jne    801000cc <bget+0x1c>
      goto loop;
    }
  }

  // Not cached; recycle some non-busy and clean buffer.
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100138:	a1 d0 f0 10 80       	mov    0x8010f0d0,%eax
8010013d:	89 45 f4             	mov    %eax,-0xc(%ebp)
80100140:	eb 4d                	jmp    8010018f <bget+0xdf>
    if((b->flags & B_BUSY) == 0 && (b->flags & B_DIRTY) == 0){
80100142:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100145:	8b 00                	mov    (%eax),%eax
80100147:	83 e0 01             	and    $0x1,%eax
8010014a:	85 c0                	test   %eax,%eax
8010014c:	75 38                	jne    80100186 <bget+0xd6>
8010014e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100151:	8b 00                	mov    (%eax),%eax
80100153:	83 e0 04             	and    $0x4,%eax
80100156:	85 c0                	test   %eax,%eax
80100158:	75 2c                	jne    80100186 <bget+0xd6>
      b->dev = dev;
8010015a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010015d:	8b 55 08             	mov    0x8(%ebp),%edx
80100160:	89 50 04             	mov    %edx,0x4(%eax)
      b->sector = sector;
80100163:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100166:	8b 55 0c             	mov    0xc(%ebp),%edx
80100169:	89 50 08             	mov    %edx,0x8(%eax)
      b->flags = B_BUSY;
8010016c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010016f:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
      release(&bcache.lock);
80100175:	c7 04 24 a0 db 10 80 	movl   $0x8010dba0,(%esp)
8010017c:	e8 98 59 00 00       	call   80105b19 <release>
      return b;
80100181:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100184:	eb 1e                	jmp    801001a4 <bget+0xf4>
      goto loop;
    }
  }

  // Not cached; recycle some non-busy and clean buffer.
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100186:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100189:	8b 40 0c             	mov    0xc(%eax),%eax
8010018c:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010018f:	81 7d f4 c4 f0 10 80 	cmpl   $0x8010f0c4,-0xc(%ebp)
80100196:	75 aa                	jne    80100142 <bget+0x92>
      b->flags = B_BUSY;
      release(&bcache.lock);
      return b;
    }
  }
  panic("bget: no buffers");
80100198:	c7 04 24 af 93 10 80 	movl   $0x801093af,(%esp)
8010019f:	e8 99 03 00 00       	call   8010053d <panic>
}
801001a4:	c9                   	leave  
801001a5:	c3                   	ret    

801001a6 <bread>:

// Return a B_BUSY buf with the contents of the indicated disk sector.
struct buf*
bread(uint dev, uint sector)
{
801001a6:	55                   	push   %ebp
801001a7:	89 e5                	mov    %esp,%ebp
801001a9:	83 ec 28             	sub    $0x28,%esp
  struct buf *b;

  b = bget(dev, sector);
801001ac:	8b 45 0c             	mov    0xc(%ebp),%eax
801001af:	89 44 24 04          	mov    %eax,0x4(%esp)
801001b3:	8b 45 08             	mov    0x8(%ebp),%eax
801001b6:	89 04 24             	mov    %eax,(%esp)
801001b9:	e8 f2 fe ff ff       	call   801000b0 <bget>
801001be:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(!(b->flags & B_VALID))
801001c1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801001c4:	8b 00                	mov    (%eax),%eax
801001c6:	83 e0 02             	and    $0x2,%eax
801001c9:	85 c0                	test   %eax,%eax
801001cb:	75 0b                	jne    801001d8 <bread+0x32>
    iderw(b);
801001cd:	8b 45 f4             	mov    -0xc(%ebp),%eax
801001d0:	89 04 24             	mov    %eax,(%esp)
801001d3:	e8 30 2d 00 00       	call   80102f08 <iderw>
  return b;
801001d8:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
801001db:	c9                   	leave  
801001dc:	c3                   	ret    

801001dd <bwrite>:

// Write b's contents to disk.  Must be B_BUSY.
void
bwrite(struct buf *b)
{
801001dd:	55                   	push   %ebp
801001de:	89 e5                	mov    %esp,%ebp
801001e0:	83 ec 18             	sub    $0x18,%esp
  if((b->flags & B_BUSY) == 0)
801001e3:	8b 45 08             	mov    0x8(%ebp),%eax
801001e6:	8b 00                	mov    (%eax),%eax
801001e8:	83 e0 01             	and    $0x1,%eax
801001eb:	85 c0                	test   %eax,%eax
801001ed:	75 0c                	jne    801001fb <bwrite+0x1e>
    panic("bwrite");
801001ef:	c7 04 24 c0 93 10 80 	movl   $0x801093c0,(%esp)
801001f6:	e8 42 03 00 00       	call   8010053d <panic>
  b->flags |= B_DIRTY;
801001fb:	8b 45 08             	mov    0x8(%ebp),%eax
801001fe:	8b 00                	mov    (%eax),%eax
80100200:	89 c2                	mov    %eax,%edx
80100202:	83 ca 04             	or     $0x4,%edx
80100205:	8b 45 08             	mov    0x8(%ebp),%eax
80100208:	89 10                	mov    %edx,(%eax)
  iderw(b);
8010020a:	8b 45 08             	mov    0x8(%ebp),%eax
8010020d:	89 04 24             	mov    %eax,(%esp)
80100210:	e8 f3 2c 00 00       	call   80102f08 <iderw>
}
80100215:	c9                   	leave  
80100216:	c3                   	ret    

80100217 <brelse>:

// Release a B_BUSY buffer.
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
80100217:	55                   	push   %ebp
80100218:	89 e5                	mov    %esp,%ebp
8010021a:	83 ec 18             	sub    $0x18,%esp
  if((b->flags & B_BUSY) == 0)
8010021d:	8b 45 08             	mov    0x8(%ebp),%eax
80100220:	8b 00                	mov    (%eax),%eax
80100222:	83 e0 01             	and    $0x1,%eax
80100225:	85 c0                	test   %eax,%eax
80100227:	75 0c                	jne    80100235 <brelse+0x1e>
    panic("brelse");
80100229:	c7 04 24 c7 93 10 80 	movl   $0x801093c7,(%esp)
80100230:	e8 08 03 00 00       	call   8010053d <panic>

  acquire(&bcache.lock);
80100235:	c7 04 24 a0 db 10 80 	movl   $0x8010dba0,(%esp)
8010023c:	e8 76 58 00 00       	call   80105ab7 <acquire>

  b->next->prev = b->prev;
80100241:	8b 45 08             	mov    0x8(%ebp),%eax
80100244:	8b 40 10             	mov    0x10(%eax),%eax
80100247:	8b 55 08             	mov    0x8(%ebp),%edx
8010024a:	8b 52 0c             	mov    0xc(%edx),%edx
8010024d:	89 50 0c             	mov    %edx,0xc(%eax)
  b->prev->next = b->next;
80100250:	8b 45 08             	mov    0x8(%ebp),%eax
80100253:	8b 40 0c             	mov    0xc(%eax),%eax
80100256:	8b 55 08             	mov    0x8(%ebp),%edx
80100259:	8b 52 10             	mov    0x10(%edx),%edx
8010025c:	89 50 10             	mov    %edx,0x10(%eax)
  b->next = bcache.head.next;
8010025f:	8b 15 d4 f0 10 80    	mov    0x8010f0d4,%edx
80100265:	8b 45 08             	mov    0x8(%ebp),%eax
80100268:	89 50 10             	mov    %edx,0x10(%eax)
  b->prev = &bcache.head;
8010026b:	8b 45 08             	mov    0x8(%ebp),%eax
8010026e:	c7 40 0c c4 f0 10 80 	movl   $0x8010f0c4,0xc(%eax)
  bcache.head.next->prev = b;
80100275:	a1 d4 f0 10 80       	mov    0x8010f0d4,%eax
8010027a:	8b 55 08             	mov    0x8(%ebp),%edx
8010027d:	89 50 0c             	mov    %edx,0xc(%eax)
  bcache.head.next = b;
80100280:	8b 45 08             	mov    0x8(%ebp),%eax
80100283:	a3 d4 f0 10 80       	mov    %eax,0x8010f0d4

  b->flags &= ~B_BUSY;
80100288:	8b 45 08             	mov    0x8(%ebp),%eax
8010028b:	8b 00                	mov    (%eax),%eax
8010028d:	89 c2                	mov    %eax,%edx
8010028f:	83 e2 fe             	and    $0xfffffffe,%edx
80100292:	8b 45 08             	mov    0x8(%ebp),%eax
80100295:	89 10                	mov    %edx,(%eax)
  wakeup(b);
80100297:	8b 45 08             	mov    0x8(%ebp),%eax
8010029a:	89 04 24             	mov    %eax,(%esp)
8010029d:	e8 75 54 00 00       	call   80105717 <wakeup>

  release(&bcache.lock);
801002a2:	c7 04 24 a0 db 10 80 	movl   $0x8010dba0,(%esp)
801002a9:	e8 6b 58 00 00       	call   80105b19 <release>
}
801002ae:	c9                   	leave  
801002af:	c3                   	ret    

801002b0 <inb>:
// Routines to let C code use special x86 instructions.

static inline uchar
inb(ushort port)
{
801002b0:	55                   	push   %ebp
801002b1:	89 e5                	mov    %esp,%ebp
801002b3:	53                   	push   %ebx
801002b4:	83 ec 14             	sub    $0x14,%esp
801002b7:	8b 45 08             	mov    0x8(%ebp),%eax
801002ba:	66 89 45 e8          	mov    %ax,-0x18(%ebp)
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801002be:	0f b7 55 e8          	movzwl -0x18(%ebp),%edx
801002c2:	66 89 55 ea          	mov    %dx,-0x16(%ebp)
801002c6:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
801002ca:	ec                   	in     (%dx),%al
801002cb:	89 c3                	mov    %eax,%ebx
801002cd:	88 5d fb             	mov    %bl,-0x5(%ebp)
  return data;
801002d0:	0f b6 45 fb          	movzbl -0x5(%ebp),%eax
}
801002d4:	83 c4 14             	add    $0x14,%esp
801002d7:	5b                   	pop    %ebx
801002d8:	5d                   	pop    %ebp
801002d9:	c3                   	ret    

801002da <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
801002da:	55                   	push   %ebp
801002db:	89 e5                	mov    %esp,%ebp
801002dd:	83 ec 08             	sub    $0x8,%esp
801002e0:	8b 55 08             	mov    0x8(%ebp),%edx
801002e3:	8b 45 0c             	mov    0xc(%ebp),%eax
801002e6:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
801002ea:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801002ed:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
801002f1:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
801002f5:	ee                   	out    %al,(%dx)
}
801002f6:	c9                   	leave  
801002f7:	c3                   	ret    

801002f8 <cli>:
  asm volatile("movw %0, %%gs" : : "r" (v));
}

static inline void
cli(void)
{
801002f8:	55                   	push   %ebp
801002f9:	89 e5                	mov    %esp,%ebp
  asm volatile("cli");
801002fb:	fa                   	cli    
}
801002fc:	5d                   	pop    %ebp
801002fd:	c3                   	ret    

801002fe <printint>:
  int locking;
} cons;

static void
printint(int xx, int base, int sign)
{
801002fe:	55                   	push   %ebp
801002ff:	89 e5                	mov    %esp,%ebp
80100301:	83 ec 48             	sub    $0x48,%esp
  static char digits[] = "0123456789abcdef";
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
80100304:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80100308:	74 19                	je     80100323 <printint+0x25>
8010030a:	8b 45 08             	mov    0x8(%ebp),%eax
8010030d:	c1 e8 1f             	shr    $0x1f,%eax
80100310:	89 45 10             	mov    %eax,0x10(%ebp)
80100313:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80100317:	74 0a                	je     80100323 <printint+0x25>
    x = -xx;
80100319:	8b 45 08             	mov    0x8(%ebp),%eax
8010031c:	f7 d8                	neg    %eax
8010031e:	89 45 f0             	mov    %eax,-0x10(%ebp)
80100321:	eb 06                	jmp    80100329 <printint+0x2b>
  else
    x = xx;
80100323:	8b 45 08             	mov    0x8(%ebp),%eax
80100326:	89 45 f0             	mov    %eax,-0x10(%ebp)

  i = 0;
80100329:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
80100330:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80100333:	8b 45 f0             	mov    -0x10(%ebp),%eax
80100336:	ba 00 00 00 00       	mov    $0x0,%edx
8010033b:	f7 f1                	div    %ecx
8010033d:	89 d0                	mov    %edx,%eax
8010033f:	0f b6 90 04 a0 10 80 	movzbl -0x7fef5ffc(%eax),%edx
80100346:	8d 45 e0             	lea    -0x20(%ebp),%eax
80100349:	03 45 f4             	add    -0xc(%ebp),%eax
8010034c:	88 10                	mov    %dl,(%eax)
8010034e:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  }while((x /= base) != 0);
80100352:	8b 55 0c             	mov    0xc(%ebp),%edx
80100355:	89 55 d4             	mov    %edx,-0x2c(%ebp)
80100358:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010035b:	ba 00 00 00 00       	mov    $0x0,%edx
80100360:	f7 75 d4             	divl   -0x2c(%ebp)
80100363:	89 45 f0             	mov    %eax,-0x10(%ebp)
80100366:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
8010036a:	75 c4                	jne    80100330 <printint+0x32>

  if(sign)
8010036c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80100370:	74 23                	je     80100395 <printint+0x97>
    buf[i++] = '-';
80100372:	8d 45 e0             	lea    -0x20(%ebp),%eax
80100375:	03 45 f4             	add    -0xc(%ebp),%eax
80100378:	c6 00 2d             	movb   $0x2d,(%eax)
8010037b:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)

  while(--i >= 0)
8010037f:	eb 14                	jmp    80100395 <printint+0x97>
    consputc(buf[i]);
80100381:	8d 45 e0             	lea    -0x20(%ebp),%eax
80100384:	03 45 f4             	add    -0xc(%ebp),%eax
80100387:	0f b6 00             	movzbl (%eax),%eax
8010038a:	0f be c0             	movsbl %al,%eax
8010038d:	89 04 24             	mov    %eax,(%esp)
80100390:	e8 d0 03 00 00       	call   80100765 <consputc>
  }while((x /= base) != 0);

  if(sign)
    buf[i++] = '-';

  while(--i >= 0)
80100395:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
80100399:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010039d:	79 e2                	jns    80100381 <printint+0x83>
    consputc(buf[i]);
}
8010039f:	c9                   	leave  
801003a0:	c3                   	ret    

801003a1 <cprintf>:
//PAGEBREAK: 50

// Print to the console. only understands %d, %x, %p, %s.
void
cprintf(char *fmt, ...)
{
801003a1:	55                   	push   %ebp
801003a2:	89 e5                	mov    %esp,%ebp
801003a4:	83 ec 38             	sub    $0x38,%esp
  int i, c, locking;
  uint *argp;
  char *s;

  locking = cons.locking;
801003a7:	a1 14 c6 10 80       	mov    0x8010c614,%eax
801003ac:	89 45 e8             	mov    %eax,-0x18(%ebp)
  if(locking)
801003af:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
801003b3:	74 0c                	je     801003c1 <cprintf+0x20>
    acquire(&cons.lock);
801003b5:	c7 04 24 e0 c5 10 80 	movl   $0x8010c5e0,(%esp)
801003bc:	e8 f6 56 00 00       	call   80105ab7 <acquire>

  if (fmt == 0)
801003c1:	8b 45 08             	mov    0x8(%ebp),%eax
801003c4:	85 c0                	test   %eax,%eax
801003c6:	75 0c                	jne    801003d4 <cprintf+0x33>
    panic("null fmt");
801003c8:	c7 04 24 ce 93 10 80 	movl   $0x801093ce,(%esp)
801003cf:	e8 69 01 00 00       	call   8010053d <panic>

  argp = (uint*)(void*)(&fmt + 1);
801003d4:	8d 45 0c             	lea    0xc(%ebp),%eax
801003d7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801003da:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801003e1:	e9 20 01 00 00       	jmp    80100506 <cprintf+0x165>
    if(c != '%'){
801003e6:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
801003ea:	74 10                	je     801003fc <cprintf+0x5b>
      consputc(c);
801003ec:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801003ef:	89 04 24             	mov    %eax,(%esp)
801003f2:	e8 6e 03 00 00       	call   80100765 <consputc>
      continue;
801003f7:	e9 06 01 00 00       	jmp    80100502 <cprintf+0x161>
    }
    c = fmt[++i] & 0xff;
801003fc:	8b 55 08             	mov    0x8(%ebp),%edx
801003ff:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80100403:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100406:	01 d0                	add    %edx,%eax
80100408:	0f b6 00             	movzbl (%eax),%eax
8010040b:	0f be c0             	movsbl %al,%eax
8010040e:	25 ff 00 00 00       	and    $0xff,%eax
80100413:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(c == 0)
80100416:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
8010041a:	0f 84 08 01 00 00    	je     80100528 <cprintf+0x187>
      break;
    switch(c){
80100420:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100423:	83 f8 70             	cmp    $0x70,%eax
80100426:	74 4d                	je     80100475 <cprintf+0xd4>
80100428:	83 f8 70             	cmp    $0x70,%eax
8010042b:	7f 13                	jg     80100440 <cprintf+0x9f>
8010042d:	83 f8 25             	cmp    $0x25,%eax
80100430:	0f 84 a6 00 00 00    	je     801004dc <cprintf+0x13b>
80100436:	83 f8 64             	cmp    $0x64,%eax
80100439:	74 14                	je     8010044f <cprintf+0xae>
8010043b:	e9 aa 00 00 00       	jmp    801004ea <cprintf+0x149>
80100440:	83 f8 73             	cmp    $0x73,%eax
80100443:	74 53                	je     80100498 <cprintf+0xf7>
80100445:	83 f8 78             	cmp    $0x78,%eax
80100448:	74 2b                	je     80100475 <cprintf+0xd4>
8010044a:	e9 9b 00 00 00       	jmp    801004ea <cprintf+0x149>
    case 'd':
      printint(*argp++, 10, 1);
8010044f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80100452:	8b 00                	mov    (%eax),%eax
80100454:	83 45 f0 04          	addl   $0x4,-0x10(%ebp)
80100458:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
8010045f:	00 
80100460:	c7 44 24 04 0a 00 00 	movl   $0xa,0x4(%esp)
80100467:	00 
80100468:	89 04 24             	mov    %eax,(%esp)
8010046b:	e8 8e fe ff ff       	call   801002fe <printint>
      break;
80100470:	e9 8d 00 00 00       	jmp    80100502 <cprintf+0x161>
    case 'x':
    case 'p':
      printint(*argp++, 16, 0);
80100475:	8b 45 f0             	mov    -0x10(%ebp),%eax
80100478:	8b 00                	mov    (%eax),%eax
8010047a:	83 45 f0 04          	addl   $0x4,-0x10(%ebp)
8010047e:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
80100485:	00 
80100486:	c7 44 24 04 10 00 00 	movl   $0x10,0x4(%esp)
8010048d:	00 
8010048e:	89 04 24             	mov    %eax,(%esp)
80100491:	e8 68 fe ff ff       	call   801002fe <printint>
      break;
80100496:	eb 6a                	jmp    80100502 <cprintf+0x161>
    case 's':
      if((s = (char*)*argp++) == 0)
80100498:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010049b:	8b 00                	mov    (%eax),%eax
8010049d:	89 45 ec             	mov    %eax,-0x14(%ebp)
801004a0:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
801004a4:	0f 94 c0             	sete   %al
801004a7:	83 45 f0 04          	addl   $0x4,-0x10(%ebp)
801004ab:	84 c0                	test   %al,%al
801004ad:	74 20                	je     801004cf <cprintf+0x12e>
        s = "(null)";
801004af:	c7 45 ec d7 93 10 80 	movl   $0x801093d7,-0x14(%ebp)
      for(; *s; s++)
801004b6:	eb 17                	jmp    801004cf <cprintf+0x12e>
        consputc(*s);
801004b8:	8b 45 ec             	mov    -0x14(%ebp),%eax
801004bb:	0f b6 00             	movzbl (%eax),%eax
801004be:	0f be c0             	movsbl %al,%eax
801004c1:	89 04 24             	mov    %eax,(%esp)
801004c4:	e8 9c 02 00 00       	call   80100765 <consputc>
      printint(*argp++, 16, 0);
      break;
    case 's':
      if((s = (char*)*argp++) == 0)
        s = "(null)";
      for(; *s; s++)
801004c9:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
801004cd:	eb 01                	jmp    801004d0 <cprintf+0x12f>
801004cf:	90                   	nop
801004d0:	8b 45 ec             	mov    -0x14(%ebp),%eax
801004d3:	0f b6 00             	movzbl (%eax),%eax
801004d6:	84 c0                	test   %al,%al
801004d8:	75 de                	jne    801004b8 <cprintf+0x117>
        consputc(*s);
      break;
801004da:	eb 26                	jmp    80100502 <cprintf+0x161>
    case '%':
      consputc('%');
801004dc:	c7 04 24 25 00 00 00 	movl   $0x25,(%esp)
801004e3:	e8 7d 02 00 00       	call   80100765 <consputc>
      break;
801004e8:	eb 18                	jmp    80100502 <cprintf+0x161>
    default:
      // Print unknown % sequence to draw attention.
      consputc('%');
801004ea:	c7 04 24 25 00 00 00 	movl   $0x25,(%esp)
801004f1:	e8 6f 02 00 00       	call   80100765 <consputc>
      consputc(c);
801004f6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801004f9:	89 04 24             	mov    %eax,(%esp)
801004fc:	e8 64 02 00 00       	call   80100765 <consputc>
      break;
80100501:	90                   	nop

  if (fmt == 0)
    panic("null fmt");

  argp = (uint*)(void*)(&fmt + 1);
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100502:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80100506:	8b 55 08             	mov    0x8(%ebp),%edx
80100509:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010050c:	01 d0                	add    %edx,%eax
8010050e:	0f b6 00             	movzbl (%eax),%eax
80100511:	0f be c0             	movsbl %al,%eax
80100514:	25 ff 00 00 00       	and    $0xff,%eax
80100519:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010051c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
80100520:	0f 85 c0 fe ff ff    	jne    801003e6 <cprintf+0x45>
80100526:	eb 01                	jmp    80100529 <cprintf+0x188>
      consputc(c);
      continue;
    }
    c = fmt[++i] & 0xff;
    if(c == 0)
      break;
80100528:	90                   	nop
      consputc(c);
      break;
    }
  }

  if(locking)
80100529:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
8010052d:	74 0c                	je     8010053b <cprintf+0x19a>
    release(&cons.lock);
8010052f:	c7 04 24 e0 c5 10 80 	movl   $0x8010c5e0,(%esp)
80100536:	e8 de 55 00 00       	call   80105b19 <release>
}
8010053b:	c9                   	leave  
8010053c:	c3                   	ret    

8010053d <panic>:

void
panic(char *s)
{
8010053d:	55                   	push   %ebp
8010053e:	89 e5                	mov    %esp,%ebp
80100540:	83 ec 48             	sub    $0x48,%esp
  int i;
  uint pcs[10];
  
  cli();
80100543:	e8 b0 fd ff ff       	call   801002f8 <cli>
  cons.locking = 0;
80100548:	c7 05 14 c6 10 80 00 	movl   $0x0,0x8010c614
8010054f:	00 00 00 
  cprintf("cpu%d: panic: ", cpu->id);
80100552:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80100558:	0f b6 00             	movzbl (%eax),%eax
8010055b:	0f b6 c0             	movzbl %al,%eax
8010055e:	89 44 24 04          	mov    %eax,0x4(%esp)
80100562:	c7 04 24 de 93 10 80 	movl   $0x801093de,(%esp)
80100569:	e8 33 fe ff ff       	call   801003a1 <cprintf>
  cprintf(s);
8010056e:	8b 45 08             	mov    0x8(%ebp),%eax
80100571:	89 04 24             	mov    %eax,(%esp)
80100574:	e8 28 fe ff ff       	call   801003a1 <cprintf>
  cprintf("\n");
80100579:	c7 04 24 ed 93 10 80 	movl   $0x801093ed,(%esp)
80100580:	e8 1c fe ff ff       	call   801003a1 <cprintf>
  getcallerpcs(&s, pcs);
80100585:	8d 45 cc             	lea    -0x34(%ebp),%eax
80100588:	89 44 24 04          	mov    %eax,0x4(%esp)
8010058c:	8d 45 08             	lea    0x8(%ebp),%eax
8010058f:	89 04 24             	mov    %eax,(%esp)
80100592:	e8 d1 55 00 00       	call   80105b68 <getcallerpcs>
  for(i=0; i<10; i++)
80100597:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010059e:	eb 1b                	jmp    801005bb <panic+0x7e>
    cprintf(" %p", pcs[i]);
801005a0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801005a3:	8b 44 85 cc          	mov    -0x34(%ebp,%eax,4),%eax
801005a7:	89 44 24 04          	mov    %eax,0x4(%esp)
801005ab:	c7 04 24 ef 93 10 80 	movl   $0x801093ef,(%esp)
801005b2:	e8 ea fd ff ff       	call   801003a1 <cprintf>
  cons.locking = 0;
  cprintf("cpu%d: panic: ", cpu->id);
  cprintf(s);
  cprintf("\n");
  getcallerpcs(&s, pcs);
  for(i=0; i<10; i++)
801005b7:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801005bb:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
801005bf:	7e df                	jle    801005a0 <panic+0x63>
    cprintf(" %p", pcs[i]);
  panicked = 1; // freeze other CPU
801005c1:	c7 05 c0 c5 10 80 01 	movl   $0x1,0x8010c5c0
801005c8:	00 00 00 
  for(;;)
    ;
801005cb:	eb fe                	jmp    801005cb <panic+0x8e>

801005cd <cgaputc>:

static ushort *crt = (ushort*)P2V(0xb8000);  // CGA memory

static void
cgaputc(int c)
{
801005cd:	55                   	push   %ebp
801005ce:	89 e5                	mov    %esp,%ebp
801005d0:	83 ec 28             	sub    $0x28,%esp
  int pos;
  
  // Cursor position: col + 80*row.
  outb(CRTPORT, 14);
801005d3:	c7 44 24 04 0e 00 00 	movl   $0xe,0x4(%esp)
801005da:	00 
801005db:	c7 04 24 d4 03 00 00 	movl   $0x3d4,(%esp)
801005e2:	e8 f3 fc ff ff       	call   801002da <outb>
  pos = inb(CRTPORT+1) << 8;
801005e7:	c7 04 24 d5 03 00 00 	movl   $0x3d5,(%esp)
801005ee:	e8 bd fc ff ff       	call   801002b0 <inb>
801005f3:	0f b6 c0             	movzbl %al,%eax
801005f6:	c1 e0 08             	shl    $0x8,%eax
801005f9:	89 45 f4             	mov    %eax,-0xc(%ebp)
  outb(CRTPORT, 15);
801005fc:	c7 44 24 04 0f 00 00 	movl   $0xf,0x4(%esp)
80100603:	00 
80100604:	c7 04 24 d4 03 00 00 	movl   $0x3d4,(%esp)
8010060b:	e8 ca fc ff ff       	call   801002da <outb>
  pos |= inb(CRTPORT+1);
80100610:	c7 04 24 d5 03 00 00 	movl   $0x3d5,(%esp)
80100617:	e8 94 fc ff ff       	call   801002b0 <inb>
8010061c:	0f b6 c0             	movzbl %al,%eax
8010061f:	09 45 f4             	or     %eax,-0xc(%ebp)

  if(c == '\n')
80100622:	83 7d 08 0a          	cmpl   $0xa,0x8(%ebp)
80100626:	75 30                	jne    80100658 <cgaputc+0x8b>
    pos += 80 - pos%80;
80100628:	8b 4d f4             	mov    -0xc(%ebp),%ecx
8010062b:	ba 67 66 66 66       	mov    $0x66666667,%edx
80100630:	89 c8                	mov    %ecx,%eax
80100632:	f7 ea                	imul   %edx
80100634:	c1 fa 05             	sar    $0x5,%edx
80100637:	89 c8                	mov    %ecx,%eax
80100639:	c1 f8 1f             	sar    $0x1f,%eax
8010063c:	29 c2                	sub    %eax,%edx
8010063e:	89 d0                	mov    %edx,%eax
80100640:	c1 e0 02             	shl    $0x2,%eax
80100643:	01 d0                	add    %edx,%eax
80100645:	c1 e0 04             	shl    $0x4,%eax
80100648:	89 ca                	mov    %ecx,%edx
8010064a:	29 c2                	sub    %eax,%edx
8010064c:	b8 50 00 00 00       	mov    $0x50,%eax
80100651:	29 d0                	sub    %edx,%eax
80100653:	01 45 f4             	add    %eax,-0xc(%ebp)
80100656:	eb 58                	jmp    801006b0 <cgaputc+0xe3>
  else if(c == BACKSPACE){
80100658:	81 7d 08 00 01 00 00 	cmpl   $0x100,0x8(%ebp)
8010065f:	75 1d                	jne    8010067e <cgaputc+0xb1>
    if(pos > 0) {
80100661:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80100665:	7e 49                	jle    801006b0 <cgaputc+0xe3>
      --pos;
80100667:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
      crt[pos] = ' ' | 0x0700;
8010066b:	a1 00 a0 10 80       	mov    0x8010a000,%eax
80100670:	8b 55 f4             	mov    -0xc(%ebp),%edx
80100673:	01 d2                	add    %edx,%edx
80100675:	01 d0                	add    %edx,%eax
80100677:	66 c7 00 20 07       	movw   $0x720,(%eax)
8010067c:	eb 32                	jmp    801006b0 <cgaputc+0xe3>
    }
  } else 
  if(c == KEY_LF){
8010067e:	81 7d 08 e4 00 00 00 	cmpl   $0xe4,0x8(%ebp)
80100685:	75 0c                	jne    80100693 <cgaputc+0xc6>
    if(pos > 0){
80100687:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010068b:	7e 23                	jle    801006b0 <cgaputc+0xe3>
      --pos;
8010068d:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
80100691:	eb 1d                	jmp    801006b0 <cgaputc+0xe3>
    }
  }  else
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
80100693:	a1 00 a0 10 80       	mov    0x8010a000,%eax
80100698:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010069b:	01 d2                	add    %edx,%edx
8010069d:	01 c2                	add    %eax,%edx
8010069f:	8b 45 08             	mov    0x8(%ebp),%eax
801006a2:	66 25 ff 00          	and    $0xff,%ax
801006a6:	80 cc 07             	or     $0x7,%ah
801006a9:	66 89 02             	mov    %ax,(%edx)
801006ac:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  
  if((pos/80) >= 24){  // Scroll up.
801006b0:	81 7d f4 7f 07 00 00 	cmpl   $0x77f,-0xc(%ebp)
801006b7:	7e 53                	jle    8010070c <cgaputc+0x13f>
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
801006b9:	a1 00 a0 10 80       	mov    0x8010a000,%eax
801006be:	8d 90 a0 00 00 00    	lea    0xa0(%eax),%edx
801006c4:	a1 00 a0 10 80       	mov    0x8010a000,%eax
801006c9:	c7 44 24 08 60 0e 00 	movl   $0xe60,0x8(%esp)
801006d0:	00 
801006d1:	89 54 24 04          	mov    %edx,0x4(%esp)
801006d5:	89 04 24             	mov    %eax,(%esp)
801006d8:	e8 fc 56 00 00       	call   80105dd9 <memmove>
    pos -= 80;
801006dd:	83 6d f4 50          	subl   $0x50,-0xc(%ebp)
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
801006e1:	b8 80 07 00 00       	mov    $0x780,%eax
801006e6:	2b 45 f4             	sub    -0xc(%ebp),%eax
801006e9:	01 c0                	add    %eax,%eax
801006eb:	8b 15 00 a0 10 80    	mov    0x8010a000,%edx
801006f1:	8b 4d f4             	mov    -0xc(%ebp),%ecx
801006f4:	01 c9                	add    %ecx,%ecx
801006f6:	01 ca                	add    %ecx,%edx
801006f8:	89 44 24 08          	mov    %eax,0x8(%esp)
801006fc:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80100703:	00 
80100704:	89 14 24             	mov    %edx,(%esp)
80100707:	e8 fa 55 00 00       	call   80105d06 <memset>
  }
  
  outb(CRTPORT, 14);
8010070c:	c7 44 24 04 0e 00 00 	movl   $0xe,0x4(%esp)
80100713:	00 
80100714:	c7 04 24 d4 03 00 00 	movl   $0x3d4,(%esp)
8010071b:	e8 ba fb ff ff       	call   801002da <outb>
  outb(CRTPORT+1, pos>>8);
80100720:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100723:	c1 f8 08             	sar    $0x8,%eax
80100726:	0f b6 c0             	movzbl %al,%eax
80100729:	89 44 24 04          	mov    %eax,0x4(%esp)
8010072d:	c7 04 24 d5 03 00 00 	movl   $0x3d5,(%esp)
80100734:	e8 a1 fb ff ff       	call   801002da <outb>
  outb(CRTPORT, 15);
80100739:	c7 44 24 04 0f 00 00 	movl   $0xf,0x4(%esp)
80100740:	00 
80100741:	c7 04 24 d4 03 00 00 	movl   $0x3d4,(%esp)
80100748:	e8 8d fb ff ff       	call   801002da <outb>
  outb(CRTPORT+1, pos);
8010074d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100750:	0f b6 c0             	movzbl %al,%eax
80100753:	89 44 24 04          	mov    %eax,0x4(%esp)
80100757:	c7 04 24 d5 03 00 00 	movl   $0x3d5,(%esp)
8010075e:	e8 77 fb ff ff       	call   801002da <outb>
  //crt[pos] = ' ' | 0x0700;
}
80100763:	c9                   	leave  
80100764:	c3                   	ret    

80100765 <consputc>:

void
consputc(int c)
{
80100765:	55                   	push   %ebp
80100766:	89 e5                	mov    %esp,%ebp
80100768:	83 ec 18             	sub    $0x18,%esp
  if(panicked){
8010076b:	a1 c0 c5 10 80       	mov    0x8010c5c0,%eax
80100770:	85 c0                	test   %eax,%eax
80100772:	74 07                	je     8010077b <consputc+0x16>
    cli();
80100774:	e8 7f fb ff ff       	call   801002f8 <cli>
    for(;;)
      ;
80100779:	eb fe                	jmp    80100779 <consputc+0x14>
  }
  else
  if(c == KEY_LF){
8010077b:	81 7d 08 e4 00 00 00 	cmpl   $0xe4,0x8(%ebp)
80100782:	75 0e                	jne    80100792 <consputc+0x2d>
    uartputc('\b'); 
80100784:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
8010078b:	e8 7d 72 00 00       	call   80107a0d <uartputc>
80100790:	eb 3a                	jmp    801007cc <consputc+0x67>
  } else
  if(c == BACKSPACE){
80100792:	81 7d 08 00 01 00 00 	cmpl   $0x100,0x8(%ebp)
80100799:	75 26                	jne    801007c1 <consputc+0x5c>
    uartputc('\b'); uartputc(' '); uartputc('\b');
8010079b:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
801007a2:	e8 66 72 00 00       	call   80107a0d <uartputc>
801007a7:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801007ae:	e8 5a 72 00 00       	call   80107a0d <uartputc>
801007b3:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
801007ba:	e8 4e 72 00 00       	call   80107a0d <uartputc>
801007bf:	eb 0b                	jmp    801007cc <consputc+0x67>
  } else
    uartputc(c);
801007c1:	8b 45 08             	mov    0x8(%ebp),%eax
801007c4:	89 04 24             	mov    %eax,(%esp)
801007c7:	e8 41 72 00 00       	call   80107a0d <uartputc>
  cgaputc(c);
801007cc:	8b 45 08             	mov    0x8(%ebp),%eax
801007cf:	89 04 24             	mov    %eax,(%esp)
801007d2:	e8 f6 fd ff ff       	call   801005cd <cgaputc>
}
801007d7:	c9                   	leave  
801007d8:	c3                   	ret    

801007d9 <replace_line_on_screen>:

#define C(x)  ((x)-'@')  // Control-x

int 
replace_line_on_screen()
{
801007d9:	55                   	push   %ebp
801007da:	89 e5                	mov    %esp,%ebp
801007dc:	83 ec 28             	sub    $0x28,%esp
  int c;
  uint counter;

  while(input.e > input.w)
801007df:	eb 32                	jmp    80100813 <replace_line_on_screen+0x3a>
    {
      input.buf[input.e-- % INPUT_BUF] = 0;
801007e1:	a1 9c f3 10 80       	mov    0x8010f39c,%eax
801007e6:	89 c2                	mov    %eax,%edx
801007e8:	83 e2 7f             	and    $0x7f,%edx
801007eb:	c6 82 14 f3 10 80 00 	movb   $0x0,-0x7fef0cec(%edx)
801007f2:	83 e8 01             	sub    $0x1,%eax
801007f5:	a3 9c f3 10 80       	mov    %eax,0x8010f39c
      input.last--;
801007fa:	a1 a0 f3 10 80       	mov    0x8010f3a0,%eax
801007ff:	83 e8 01             	sub    $0x1,%eax
80100802:	a3 a0 f3 10 80       	mov    %eax,0x8010f3a0
      consputc(BACKSPACE);
80100807:	c7 04 24 00 01 00 00 	movl   $0x100,(%esp)
8010080e:	e8 52 ff ff ff       	call   80100765 <consputc>
replace_line_on_screen()
{
  int c;
  uint counter;

  while(input.e > input.w)
80100813:	8b 15 9c f3 10 80    	mov    0x8010f39c,%edx
80100819:	a1 98 f3 10 80       	mov    0x8010f398,%eax
8010081e:	39 c2                	cmp    %eax,%edx
80100820:	77 bf                	ja     801007e1 <replace_line_on_screen+0x8>
    {
      input.buf[input.e-- % INPUT_BUF] = 0;
      input.last--;
      consputc(BACKSPACE);
    }
    for(counter=0; c!=0 && c!='\n' && c!='\r' ;counter++)
80100822:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
80100829:	eb 73                	jmp    8010089e <replace_line_on_screen+0xc5>
    {
      c=input.history[input.history_indx % MAX_HISTORY_LENGTH ][counter];
8010082b:	8b 0d a8 fd 10 80    	mov    0x8010fda8,%ecx
80100831:	ba cd cc cc cc       	mov    $0xcccccccd,%edx
80100836:	89 c8                	mov    %ecx,%eax
80100838:	f7 e2                	mul    %edx
8010083a:	c1 ea 04             	shr    $0x4,%edx
8010083d:	89 d0                	mov    %edx,%eax
8010083f:	c1 e0 02             	shl    $0x2,%eax
80100842:	01 d0                	add    %edx,%eax
80100844:	c1 e0 02             	shl    $0x2,%eax
80100847:	89 ca                	mov    %ecx,%edx
80100849:	29 c2                	sub    %eax,%edx
8010084b:	89 d0                	mov    %edx,%eax
8010084d:	c1 e0 02             	shl    $0x2,%eax
80100850:	01 d0                	add    %edx,%eax
80100852:	c1 e0 02             	shl    $0x2,%eax
80100855:	03 45 f0             	add    -0x10(%ebp),%eax
80100858:	05 a0 f3 10 80       	add    $0x8010f3a0,%eax
8010085d:	0f b6 40 04          	movzbl 0x4(%eax),%eax
80100861:	0f be c0             	movsbl %al,%eax
80100864:	89 45 f4             	mov    %eax,-0xc(%ebp)
      input.buf[input.e++ % INPUT_BUF] = c;
80100867:	a1 9c f3 10 80       	mov    0x8010f39c,%eax
8010086c:	89 c1                	mov    %eax,%ecx
8010086e:	83 e1 7f             	and    $0x7f,%ecx
80100871:	8b 55 f4             	mov    -0xc(%ebp),%edx
80100874:	88 91 14 f3 10 80    	mov    %dl,-0x7fef0cec(%ecx)
8010087a:	83 c0 01             	add    $0x1,%eax
8010087d:	a3 9c f3 10 80       	mov    %eax,0x8010f39c
      input.last++;
80100882:	a1 a0 f3 10 80       	mov    0x8010f3a0,%eax
80100887:	83 c0 01             	add    $0x1,%eax
8010088a:	a3 a0 f3 10 80       	mov    %eax,0x8010f3a0
      consputc(c);
8010088f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100892:	89 04 24             	mov    %eax,(%esp)
80100895:	e8 cb fe ff ff       	call   80100765 <consputc>
    {
      input.buf[input.e-- % INPUT_BUF] = 0;
      input.last--;
      consputc(BACKSPACE);
    }
    for(counter=0; c!=0 && c!='\n' && c!='\r' ;counter++)
8010089a:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
8010089e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801008a2:	74 10                	je     801008b4 <replace_line_on_screen+0xdb>
801008a4:	83 7d f4 0a          	cmpl   $0xa,-0xc(%ebp)
801008a8:	74 0a                	je     801008b4 <replace_line_on_screen+0xdb>
801008aa:	83 7d f4 0d          	cmpl   $0xd,-0xc(%ebp)
801008ae:	0f 85 77 ff ff ff    	jne    8010082b <replace_line_on_screen+0x52>
      c=input.history[input.history_indx % MAX_HISTORY_LENGTH ][counter];
      input.buf[input.e++ % INPUT_BUF] = c;
      input.last++;
      consputc(c);
    }
    return 0;
801008b4:	b8 00 00 00 00       	mov    $0x0,%eax
}
801008b9:	c9                   	leave  
801008ba:	c3                   	ret    

801008bb <consoleintr>:

void
consoleintr(int (*getc)(void))
{
801008bb:	55                   	push   %ebp
801008bc:	89 e5                	mov    %esp,%ebp
801008be:	56                   	push   %esi
801008bf:	53                   	push   %ebx
801008c0:	83 ec 20             	sub    $0x20,%esp
  int c;
  int i;
  acquire(&input.lock);
801008c3:	c7 04 24 e0 f2 10 80 	movl   $0x8010f2e0,(%esp)
801008ca:	e8 e8 51 00 00       	call   80105ab7 <acquire>
  while((c = getc()) >= 0){
801008cf:	e9 ab 06 00 00       	jmp    80100f7f <consoleintr+0x6c4>
    switch(c){
801008d4:	8b 45 f0             	mov    -0x10(%ebp),%eax
801008d7:	83 f8 7f             	cmp    $0x7f,%eax
801008da:	0f 84 bb 00 00 00    	je     8010099b <consoleintr+0xe0>
801008e0:	83 f8 7f             	cmp    $0x7f,%eax
801008e3:	7f 18                	jg     801008fd <consoleintr+0x42>
801008e5:	83 f8 10             	cmp    $0x10,%eax
801008e8:	74 50                	je     8010093a <consoleintr+0x7f>
801008ea:	83 f8 15             	cmp    $0x15,%eax
801008ed:	74 7d                	je     8010096c <consoleintr+0xb1>
801008ef:	83 f8 08             	cmp    $0x8,%eax
801008f2:	0f 84 a3 00 00 00    	je     8010099b <consoleintr+0xe0>
801008f8:	e9 db 03 00 00       	jmp    80100cd8 <consoleintr+0x41d>
801008fd:	3d e3 00 00 00       	cmp    $0xe3,%eax
80100902:	0f 84 78 02 00 00    	je     80100b80 <consoleintr+0x2c5>
80100908:	3d e3 00 00 00       	cmp    $0xe3,%eax
8010090d:	7f 10                	jg     8010091f <consoleintr+0x64>
8010090f:	3d e2 00 00 00       	cmp    $0xe2,%eax
80100914:	0f 84 13 03 00 00    	je     80100c2d <consoleintr+0x372>
8010091a:	e9 b9 03 00 00       	jmp    80100cd8 <consoleintr+0x41d>
8010091f:	3d e4 00 00 00       	cmp    $0xe4,%eax
80100924:	0f 84 e7 01 00 00    	je     80100b11 <consoleintr+0x256>
8010092a:	3d e5 00 00 00       	cmp    $0xe5,%eax
8010092f:	0f 84 0c 02 00 00    	je     80100b41 <consoleintr+0x286>
80100935:	e9 9e 03 00 00       	jmp    80100cd8 <consoleintr+0x41d>
    case C('P'):  // Process listing.
      procdump();
8010093a:	e8 11 4f 00 00       	call   80105850 <procdump>
      break;
8010093f:	e9 3b 06 00 00       	jmp    80100f7f <consoleintr+0x6c4>

    case C('U'):  // Kill line.
      while(input.e != input.w &&
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
        input.e--;
80100944:	a1 9c f3 10 80       	mov    0x8010f39c,%eax
80100949:	83 e8 01             	sub    $0x1,%eax
8010094c:	a3 9c f3 10 80       	mov    %eax,0x8010f39c
        input.last--;
80100951:	a1 a0 f3 10 80       	mov    0x8010f3a0,%eax
80100956:	83 e8 01             	sub    $0x1,%eax
80100959:	a3 a0 f3 10 80       	mov    %eax,0x8010f3a0
        consputc(BACKSPACE);
8010095e:	c7 04 24 00 01 00 00 	movl   $0x100,(%esp)
80100965:	e8 fb fd ff ff       	call   80100765 <consputc>
8010096a:	eb 01                	jmp    8010096d <consoleintr+0xb2>
    case C('P'):  // Process listing.
      procdump();
      break;

    case C('U'):  // Kill line.
      while(input.e != input.w &&
8010096c:	90                   	nop
8010096d:	8b 15 9c f3 10 80    	mov    0x8010f39c,%edx
80100973:	a1 98 f3 10 80       	mov    0x8010f398,%eax
80100978:	39 c2                	cmp    %eax,%edx
8010097a:	0f 84 ec 05 00 00    	je     80100f6c <consoleintr+0x6b1>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
80100980:	a1 9c f3 10 80       	mov    0x8010f39c,%eax
80100985:	83 e8 01             	sub    $0x1,%eax
80100988:	83 e0 7f             	and    $0x7f,%eax
8010098b:	0f b6 80 14 f3 10 80 	movzbl -0x7fef0cec(%eax),%eax
    case C('P'):  // Process listing.
      procdump();
      break;

    case C('U'):  // Kill line.
      while(input.e != input.w &&
80100992:	3c 0a                	cmp    $0xa,%al
80100994:	75 ae                	jne    80100944 <consoleintr+0x89>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
        input.e--;
        input.last--;
        consputc(BACKSPACE);
      }
      break;
80100996:	e9 d1 05 00 00       	jmp    80100f6c <consoleintr+0x6b1>

    case C('H'):    case '\x7f':  // Backspace
      if(input.e != input.w)
8010099b:	8b 15 9c f3 10 80    	mov    0x8010f39c,%edx
801009a1:	a1 98 f3 10 80       	mov    0x8010f398,%eax
801009a6:	39 c2                	cmp    %eax,%edx
801009a8:	0f 84 c1 05 00 00    	je     80100f6f <consoleintr+0x6b4>
      {
        if(input.e<input.last){
801009ae:	8b 15 9c f3 10 80    	mov    0x8010f39c,%edx
801009b4:	a1 a0 f3 10 80       	mov    0x8010f3a0,%eax
801009b9:	39 c2                	cmp    %eax,%edx
801009bb:	0f 83 20 01 00 00    	jae    80100ae1 <consoleintr+0x226>
          for (i =input.e;  i <= input.last;i++)
801009c1:	a1 9c f3 10 80       	mov    0x8010f39c,%eax
801009c6:	89 45 f4             	mov    %eax,-0xc(%ebp)
801009c9:	eb 3e                	jmp    80100a09 <consoleintr+0x14e>
          {
            input.buf[(i-1)%INPUT_BUF]=input.buf[i%INPUT_BUF];
801009cb:	8b 45 f4             	mov    -0xc(%ebp),%eax
801009ce:	8d 50 ff             	lea    -0x1(%eax),%edx
801009d1:	89 d0                	mov    %edx,%eax
801009d3:	c1 f8 1f             	sar    $0x1f,%eax
801009d6:	c1 e8 19             	shr    $0x19,%eax
801009d9:	01 c2                	add    %eax,%edx
801009db:	83 e2 7f             	and    $0x7f,%edx
801009de:	89 d1                	mov    %edx,%ecx
801009e0:	29 c1                	sub    %eax,%ecx
801009e2:	89 c8                	mov    %ecx,%eax
801009e4:	89 c1                	mov    %eax,%ecx
801009e6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801009e9:	89 c2                	mov    %eax,%edx
801009eb:	c1 fa 1f             	sar    $0x1f,%edx
801009ee:	c1 ea 19             	shr    $0x19,%edx
801009f1:	01 d0                	add    %edx,%eax
801009f3:	83 e0 7f             	and    $0x7f,%eax
801009f6:	29 d0                	sub    %edx,%eax
801009f8:	0f b6 80 14 f3 10 80 	movzbl -0x7fef0cec(%eax),%eax
801009ff:	88 81 14 f3 10 80    	mov    %al,-0x7fef0cec(%ecx)

    case C('H'):    case '\x7f':  // Backspace
      if(input.e != input.w)
      {
        if(input.e<input.last){
          for (i =input.e;  i <= input.last;i++)
80100a05:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80100a09:	8b 55 f4             	mov    -0xc(%ebp),%edx
80100a0c:	a1 a0 f3 10 80       	mov    0x8010f3a0,%eax
80100a11:	39 c2                	cmp    %eax,%edx
80100a13:	76 b6                	jbe    801009cb <consoleintr+0x110>
          {
            input.buf[(i-1)%INPUT_BUF]=input.buf[i%INPUT_BUF];
          }
          for (i = input.e; i < input.last; ++i)
80100a15:	a1 9c f3 10 80       	mov    0x8010f39c,%eax
80100a1a:	89 45 f4             	mov    %eax,-0xc(%ebp)
80100a1d:	eb 10                	jmp    80100a2f <consoleintr+0x174>
          {
            consputc(KEY_RT);
80100a1f:	c7 04 24 e5 00 00 00 	movl   $0xe5,(%esp)
80100a26:	e8 3a fd ff ff       	call   80100765 <consputc>
        if(input.e<input.last){
          for (i =input.e;  i <= input.last;i++)
          {
            input.buf[(i-1)%INPUT_BUF]=input.buf[i%INPUT_BUF];
          }
          for (i = input.e; i < input.last; ++i)
80100a2b:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80100a2f:	8b 55 f4             	mov    -0xc(%ebp),%edx
80100a32:	a1 a0 f3 10 80       	mov    0x8010f3a0,%eax
80100a37:	39 c2                	cmp    %eax,%edx
80100a39:	72 e4                	jb     80100a1f <consoleintr+0x164>
          {
            consputc(KEY_RT);
          }
          for (i = input.e; i <= input.last; ++i)
80100a3b:	a1 9c f3 10 80       	mov    0x8010f39c,%eax
80100a40:	89 45 f4             	mov    %eax,-0xc(%ebp)
80100a43:	eb 10                	jmp    80100a55 <consoleintr+0x19a>
          {
            consputc(BACKSPACE);
80100a45:	c7 04 24 00 01 00 00 	movl   $0x100,(%esp)
80100a4c:	e8 14 fd ff ff       	call   80100765 <consputc>
          }
          for (i = input.e; i < input.last; ++i)
          {
            consputc(KEY_RT);
          }
          for (i = input.e; i <= input.last; ++i)
80100a51:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80100a55:	8b 55 f4             	mov    -0xc(%ebp),%edx
80100a58:	a1 a0 f3 10 80       	mov    0x8010f3a0,%eax
80100a5d:	39 c2                	cmp    %eax,%edx
80100a5f:	76 e4                	jbe    80100a45 <consoleintr+0x18a>
          {
            consputc(BACKSPACE);
          }
          input.e--;
80100a61:	a1 9c f3 10 80       	mov    0x8010f39c,%eax
80100a66:	83 e8 01             	sub    $0x1,%eax
80100a69:	a3 9c f3 10 80       	mov    %eax,0x8010f39c
          input.last--;
80100a6e:	a1 a0 f3 10 80       	mov    0x8010f3a0,%eax
80100a73:	83 e8 01             	sub    $0x1,%eax
80100a76:	a3 a0 f3 10 80       	mov    %eax,0x8010f3a0
          for (i = input.e; i < input.last; ++i)
80100a7b:	a1 9c f3 10 80       	mov    0x8010f39c,%eax
80100a80:	89 45 f4             	mov    %eax,-0xc(%ebp)
80100a83:	eb 28                	jmp    80100aad <consoleintr+0x1f2>
          {
            consputc(input.buf[i%INPUT_BUF]);
80100a85:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100a88:	89 c2                	mov    %eax,%edx
80100a8a:	c1 fa 1f             	sar    $0x1f,%edx
80100a8d:	c1 ea 19             	shr    $0x19,%edx
80100a90:	01 d0                	add    %edx,%eax
80100a92:	83 e0 7f             	and    $0x7f,%eax
80100a95:	29 d0                	sub    %edx,%eax
80100a97:	0f b6 80 14 f3 10 80 	movzbl -0x7fef0cec(%eax),%eax
80100a9e:	0f be c0             	movsbl %al,%eax
80100aa1:	89 04 24             	mov    %eax,(%esp)
80100aa4:	e8 bc fc ff ff       	call   80100765 <consputc>
          {
            consputc(BACKSPACE);
          }
          input.e--;
          input.last--;
          for (i = input.e; i < input.last; ++i)
80100aa9:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80100aad:	8b 55 f4             	mov    -0xc(%ebp),%edx
80100ab0:	a1 a0 f3 10 80       	mov    0x8010f3a0,%eax
80100ab5:	39 c2                	cmp    %eax,%edx
80100ab7:	72 cc                	jb     80100a85 <consoleintr+0x1ca>
          {
            consputc(input.buf[i%INPUT_BUF]);
          }
          for (i = input.e; i < input.last; ++i)
80100ab9:	a1 9c f3 10 80       	mov    0x8010f39c,%eax
80100abe:	89 45 f4             	mov    %eax,-0xc(%ebp)
80100ac1:	eb 10                	jmp    80100ad3 <consoleintr+0x218>
          {
            consputc(KEY_LF);
80100ac3:	c7 04 24 e4 00 00 00 	movl   $0xe4,(%esp)
80100aca:	e8 96 fc ff ff       	call   80100765 <consputc>
          input.last--;
          for (i = input.e; i < input.last; ++i)
          {
            consputc(input.buf[i%INPUT_BUF]);
          }
          for (i = input.e; i < input.last; ++i)
80100acf:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80100ad3:	8b 55 f4             	mov    -0xc(%ebp),%edx
80100ad6:	a1 a0 f3 10 80       	mov    0x8010f3a0,%eax
80100adb:	39 c2                	cmp    %eax,%edx
80100add:	72 e4                	jb     80100ac3 <consoleintr+0x208>
80100adf:	eb 2b                	jmp    80100b0c <consoleintr+0x251>
            consputc(KEY_LF);
          }

        }
        else{
          input.e--;
80100ae1:	a1 9c f3 10 80       	mov    0x8010f39c,%eax
80100ae6:	83 e8 01             	sub    $0x1,%eax
80100ae9:	a3 9c f3 10 80       	mov    %eax,0x8010f39c
          input.last--;
80100aee:	a1 a0 f3 10 80       	mov    0x8010f3a0,%eax
80100af3:	83 e8 01             	sub    $0x1,%eax
80100af6:	a3 a0 f3 10 80       	mov    %eax,0x8010f3a0
          consputc(BACKSPACE);
80100afb:	c7 04 24 00 01 00 00 	movl   $0x100,(%esp)
80100b02:	e8 5e fc ff ff       	call   80100765 <consputc>
        }
      }
      break;
80100b07:	e9 63 04 00 00       	jmp    80100f6f <consoleintr+0x6b4>
80100b0c:	e9 5e 04 00 00       	jmp    80100f6f <consoleintr+0x6b4>

    case KEY_LF:  // left arrow
      if(input.e != input.w)
80100b11:	8b 15 9c f3 10 80    	mov    0x8010f39c,%edx
80100b17:	a1 98 f3 10 80       	mov    0x8010f398,%eax
80100b1c:	39 c2                	cmp    %eax,%edx
80100b1e:	0f 84 4e 04 00 00    	je     80100f72 <consoleintr+0x6b7>
      {
        input.e--;
80100b24:	a1 9c f3 10 80       	mov    0x8010f39c,%eax
80100b29:	83 e8 01             	sub    $0x1,%eax
80100b2c:	a3 9c f3 10 80       	mov    %eax,0x8010f39c
        consputc(c);
80100b31:	8b 45 f0             	mov    -0x10(%ebp),%eax
80100b34:	89 04 24             	mov    %eax,(%esp)
80100b37:	e8 29 fc ff ff       	call   80100765 <consputc>
      }
      break;
80100b3c:	e9 31 04 00 00       	jmp    80100f72 <consoleintr+0x6b7>

    case KEY_RT:  // right arrow
      if(input.e < input.last)
80100b41:	8b 15 9c f3 10 80    	mov    0x8010f39c,%edx
80100b47:	a1 a0 f3 10 80       	mov    0x8010f3a0,%eax
80100b4c:	39 c2                	cmp    %eax,%edx
80100b4e:	0f 83 21 04 00 00    	jae    80100f75 <consoleintr+0x6ba>
      {
        consputc(input.buf[input.e% INPUT_BUF]);
80100b54:	a1 9c f3 10 80       	mov    0x8010f39c,%eax
80100b59:	83 e0 7f             	and    $0x7f,%eax
80100b5c:	0f b6 80 14 f3 10 80 	movzbl -0x7fef0cec(%eax),%eax
80100b63:	0f be c0             	movsbl %al,%eax
80100b66:	89 04 24             	mov    %eax,(%esp)
80100b69:	e8 f7 fb ff ff       	call   80100765 <consputc>
        input.e++;
80100b6e:	a1 9c f3 10 80       	mov    0x8010f39c,%eax
80100b73:	83 c0 01             	add    $0x1,%eax
80100b76:	a3 9c f3 10 80       	mov    %eax,0x8010f39c
      }
      break;
80100b7b:	e9 f5 03 00 00       	jmp    80100f75 <consoleintr+0x6ba>

      case KEY_DN:  // down arrow
      
      if((input.history_end % MAX_HISTORY_LENGTH) != (input.history_start % MAX_HISTORY_LENGTH) 
80100b80:	8b 1d ac fd 10 80    	mov    0x8010fdac,%ebx
80100b86:	ba cd cc cc cc       	mov    $0xcccccccd,%edx
80100b8b:	89 d8                	mov    %ebx,%eax
80100b8d:	f7 e2                	mul    %edx
80100b8f:	89 d1                	mov    %edx,%ecx
80100b91:	c1 e9 04             	shr    $0x4,%ecx
80100b94:	89 c8                	mov    %ecx,%eax
80100b96:	c1 e0 02             	shl    $0x2,%eax
80100b99:	01 c8                	add    %ecx,%eax
80100b9b:	c1 e0 02             	shl    $0x2,%eax
80100b9e:	89 d9                	mov    %ebx,%ecx
80100ba0:	29 c1                	sub    %eax,%ecx
80100ba2:	8b 1d a4 fd 10 80    	mov    0x8010fda4,%ebx
80100ba8:	ba cd cc cc cc       	mov    $0xcccccccd,%edx
80100bad:	89 d8                	mov    %ebx,%eax
80100baf:	f7 e2                	mul    %edx
80100bb1:	c1 ea 04             	shr    $0x4,%edx
80100bb4:	89 d0                	mov    %edx,%eax
80100bb6:	c1 e0 02             	shl    $0x2,%eax
80100bb9:	01 d0                	add    %edx,%eax
80100bbb:	c1 e0 02             	shl    $0x2,%eax
80100bbe:	89 da                	mov    %ebx,%edx
80100bc0:	29 c2                	sub    %eax,%edx
80100bc2:	39 d1                	cmp    %edx,%ecx
80100bc4:	0f 84 ae 03 00 00    	je     80100f78 <consoleintr+0x6bd>
        && ((input.history_indx + 1) % MAX_HISTORY_LENGTH) != (input.history_end % MAX_HISTORY_LENGTH ))
80100bca:	a1 a8 fd 10 80       	mov    0x8010fda8,%eax
80100bcf:	8d 58 01             	lea    0x1(%eax),%ebx
80100bd2:	ba cd cc cc cc       	mov    $0xcccccccd,%edx
80100bd7:	89 d8                	mov    %ebx,%eax
80100bd9:	f7 e2                	mul    %edx
80100bdb:	89 d1                	mov    %edx,%ecx
80100bdd:	c1 e9 04             	shr    $0x4,%ecx
80100be0:	89 c8                	mov    %ecx,%eax
80100be2:	c1 e0 02             	shl    $0x2,%eax
80100be5:	01 c8                	add    %ecx,%eax
80100be7:	c1 e0 02             	shl    $0x2,%eax
80100bea:	89 d9                	mov    %ebx,%ecx
80100bec:	29 c1                	sub    %eax,%ecx
80100bee:	8b 1d ac fd 10 80    	mov    0x8010fdac,%ebx
80100bf4:	ba cd cc cc cc       	mov    $0xcccccccd,%edx
80100bf9:	89 d8                	mov    %ebx,%eax
80100bfb:	f7 e2                	mul    %edx
80100bfd:	c1 ea 04             	shr    $0x4,%edx
80100c00:	89 d0                	mov    %edx,%eax
80100c02:	c1 e0 02             	shl    $0x2,%eax
80100c05:	01 d0                	add    %edx,%eax
80100c07:	c1 e0 02             	shl    $0x2,%eax
80100c0a:	89 da                	mov    %ebx,%edx
80100c0c:	29 c2                	sub    %eax,%edx
80100c0e:	39 d1                	cmp    %edx,%ecx
80100c10:	0f 84 62 03 00 00    	je     80100f78 <consoleintr+0x6bd>
      {
        input.history_indx++;
80100c16:	a1 a8 fd 10 80       	mov    0x8010fda8,%eax
80100c1b:	83 c0 01             	add    $0x1,%eax
80100c1e:	a3 a8 fd 10 80       	mov    %eax,0x8010fda8
        replace_line_on_screen();
80100c23:	e8 b1 fb ff ff       	call   801007d9 <replace_line_on_screen>
      }
      break;
80100c28:	e9 4b 03 00 00       	jmp    80100f78 <consoleintr+0x6bd>

      case KEY_UP:  // up arrow
      
      if((input.history_end % MAX_HISTORY_LENGTH) != (input.history_start % MAX_HISTORY_LENGTH)
80100c2d:	8b 1d ac fd 10 80    	mov    0x8010fdac,%ebx
80100c33:	ba cd cc cc cc       	mov    $0xcccccccd,%edx
80100c38:	89 d8                	mov    %ebx,%eax
80100c3a:	f7 e2                	mul    %edx
80100c3c:	89 d1                	mov    %edx,%ecx
80100c3e:	c1 e9 04             	shr    $0x4,%ecx
80100c41:	89 c8                	mov    %ecx,%eax
80100c43:	c1 e0 02             	shl    $0x2,%eax
80100c46:	01 c8                	add    %ecx,%eax
80100c48:	c1 e0 02             	shl    $0x2,%eax
80100c4b:	89 d9                	mov    %ebx,%ecx
80100c4d:	29 c1                	sub    %eax,%ecx
80100c4f:	8b 1d a4 fd 10 80    	mov    0x8010fda4,%ebx
80100c55:	ba cd cc cc cc       	mov    $0xcccccccd,%edx
80100c5a:	89 d8                	mov    %ebx,%eax
80100c5c:	f7 e2                	mul    %edx
80100c5e:	c1 ea 04             	shr    $0x4,%edx
80100c61:	89 d0                	mov    %edx,%eax
80100c63:	c1 e0 02             	shl    $0x2,%eax
80100c66:	01 d0                	add    %edx,%eax
80100c68:	c1 e0 02             	shl    $0x2,%eax
80100c6b:	89 da                	mov    %ebx,%edx
80100c6d:	29 c2                	sub    %eax,%edx
80100c6f:	39 d1                	cmp    %edx,%ecx
80100c71:	0f 84 04 03 00 00    	je     80100f7b <consoleintr+0x6c0>
       && ((input.history_indx) % MAX_HISTORY_LENGTH) != (input.history_start % MAX_HISTORY_LENGTH) )
80100c77:	8b 1d a8 fd 10 80    	mov    0x8010fda8,%ebx
80100c7d:	ba cd cc cc cc       	mov    $0xcccccccd,%edx
80100c82:	89 d8                	mov    %ebx,%eax
80100c84:	f7 e2                	mul    %edx
80100c86:	89 d1                	mov    %edx,%ecx
80100c88:	c1 e9 04             	shr    $0x4,%ecx
80100c8b:	89 c8                	mov    %ecx,%eax
80100c8d:	c1 e0 02             	shl    $0x2,%eax
80100c90:	01 c8                	add    %ecx,%eax
80100c92:	c1 e0 02             	shl    $0x2,%eax
80100c95:	89 d9                	mov    %ebx,%ecx
80100c97:	29 c1                	sub    %eax,%ecx
80100c99:	8b 1d a4 fd 10 80    	mov    0x8010fda4,%ebx
80100c9f:	ba cd cc cc cc       	mov    $0xcccccccd,%edx
80100ca4:	89 d8                	mov    %ebx,%eax
80100ca6:	f7 e2                	mul    %edx
80100ca8:	c1 ea 04             	shr    $0x4,%edx
80100cab:	89 d0                	mov    %edx,%eax
80100cad:	c1 e0 02             	shl    $0x2,%eax
80100cb0:	01 d0                	add    %edx,%eax
80100cb2:	c1 e0 02             	shl    $0x2,%eax
80100cb5:	89 da                	mov    %ebx,%edx
80100cb7:	29 c2                	sub    %eax,%edx
80100cb9:	39 d1                	cmp    %edx,%ecx
80100cbb:	0f 84 ba 02 00 00    	je     80100f7b <consoleintr+0x6c0>
      {
        input.history_indx--;
80100cc1:	a1 a8 fd 10 80       	mov    0x8010fda8,%eax
80100cc6:	83 e8 01             	sub    $0x1,%eax
80100cc9:	a3 a8 fd 10 80       	mov    %eax,0x8010fda8
        replace_line_on_screen();
80100cce:	e8 06 fb ff ff       	call   801007d9 <replace_line_on_screen>
      }
      break;
80100cd3:	e9 a3 02 00 00       	jmp    80100f7b <consoleintr+0x6c0>

    default:
      if(c != 0 && input.e-input.r < INPUT_BUF)
80100cd8:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80100cdc:	0f 84 9c 02 00 00    	je     80100f7e <consoleintr+0x6c3>
80100ce2:	8b 15 9c f3 10 80    	mov    0x8010f39c,%edx
80100ce8:	a1 94 f3 10 80       	mov    0x8010f394,%eax
80100ced:	89 d1                	mov    %edx,%ecx
80100cef:	29 c1                	sub    %eax,%ecx
80100cf1:	89 c8                	mov    %ecx,%eax
80100cf3:	83 f8 7f             	cmp    $0x7f,%eax
80100cf6:	0f 87 82 02 00 00    	ja     80100f7e <consoleintr+0x6c3>
      {
        c = (c == '\r') ? '\n' : c;
80100cfc:	83 7d f0 0d          	cmpl   $0xd,-0x10(%ebp)
80100d00:	74 05                	je     80100d07 <consoleintr+0x44c>
80100d02:	8b 45 f0             	mov    -0x10(%ebp),%eax
80100d05:	eb 05                	jmp    80100d0c <consoleintr+0x451>
80100d07:	b8 0a 00 00 00       	mov    $0xa,%eax
80100d0c:	89 45 f0             	mov    %eax,-0x10(%ebp)
        if(input.e<input.last && c!='\n')
80100d0f:	8b 15 9c f3 10 80    	mov    0x8010f39c,%edx
80100d15:	a1 a0 f3 10 80       	mov    0x8010f3a0,%eax
80100d1a:	39 c2                	cmp    %eax,%edx
80100d1c:	0f 83 00 01 00 00    	jae    80100e22 <consoleintr+0x567>
80100d22:	83 7d f0 0a          	cmpl   $0xa,-0x10(%ebp)
80100d26:	0f 84 f6 00 00 00    	je     80100e22 <consoleintr+0x567>
        {
          for (i = input.last; i >= input.e; i--)
80100d2c:	a1 a0 f3 10 80       	mov    0x8010f3a0,%eax
80100d31:	89 45 f4             	mov    %eax,-0xc(%ebp)
80100d34:	eb 3e                	jmp    80100d74 <consoleintr+0x4b9>
          {
            input.buf[(i + 1)% INPUT_BUF]=input.buf[i% INPUT_BUF];
80100d36:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100d39:	8d 50 01             	lea    0x1(%eax),%edx
80100d3c:	89 d0                	mov    %edx,%eax
80100d3e:	c1 f8 1f             	sar    $0x1f,%eax
80100d41:	c1 e8 19             	shr    $0x19,%eax
80100d44:	01 c2                	add    %eax,%edx
80100d46:	83 e2 7f             	and    $0x7f,%edx
80100d49:	89 d3                	mov    %edx,%ebx
80100d4b:	29 c3                	sub    %eax,%ebx
80100d4d:	89 d8                	mov    %ebx,%eax
80100d4f:	89 c1                	mov    %eax,%ecx
80100d51:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100d54:	89 c2                	mov    %eax,%edx
80100d56:	c1 fa 1f             	sar    $0x1f,%edx
80100d59:	c1 ea 19             	shr    $0x19,%edx
80100d5c:	01 d0                	add    %edx,%eax
80100d5e:	83 e0 7f             	and    $0x7f,%eax
80100d61:	29 d0                	sub    %edx,%eax
80100d63:	0f b6 80 14 f3 10 80 	movzbl -0x7fef0cec(%eax),%eax
80100d6a:	88 81 14 f3 10 80    	mov    %al,-0x7fef0cec(%ecx)
      if(c != 0 && input.e-input.r < INPUT_BUF)
      {
        c = (c == '\r') ? '\n' : c;
        if(input.e<input.last && c!='\n')
        {
          for (i = input.last; i >= input.e; i--)
80100d70:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
80100d74:	8b 55 f4             	mov    -0xc(%ebp),%edx
80100d77:	a1 9c f3 10 80       	mov    0x8010f39c,%eax
80100d7c:	39 c2                	cmp    %eax,%edx
80100d7e:	73 b6                	jae    80100d36 <consoleintr+0x47b>
          {
            input.buf[(i + 1)% INPUT_BUF]=input.buf[i% INPUT_BUF];
          }
          input.buf[input.e % INPUT_BUF] = c;
80100d80:	a1 9c f3 10 80       	mov    0x8010f39c,%eax
80100d85:	89 c2                	mov    %eax,%edx
80100d87:	83 e2 7f             	and    $0x7f,%edx
80100d8a:	8b 45 f0             	mov    -0x10(%ebp),%eax
80100d8d:	88 82 14 f3 10 80    	mov    %al,-0x7fef0cec(%edx)
          input.last++;
80100d93:	a1 a0 f3 10 80       	mov    0x8010f3a0,%eax
80100d98:	83 c0 01             	add    $0x1,%eax
80100d9b:	a3 a0 f3 10 80       	mov    %eax,0x8010f3a0
          input.e++;
80100da0:	a1 9c f3 10 80       	mov    0x8010f39c,%eax
80100da5:	83 c0 01             	add    $0x1,%eax
80100da8:	a3 9c f3 10 80       	mov    %eax,0x8010f39c
          for (i =input.e-1 ; i <input.last ; i++)
80100dad:	a1 9c f3 10 80       	mov    0x8010f39c,%eax
80100db2:	83 e8 01             	sub    $0x1,%eax
80100db5:	89 45 f4             	mov    %eax,-0xc(%ebp)
80100db8:	eb 28                	jmp    80100de2 <consoleintr+0x527>
          {
            consputc(input.buf[i%INPUT_BUF]);
80100dba:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100dbd:	89 c2                	mov    %eax,%edx
80100dbf:	c1 fa 1f             	sar    $0x1f,%edx
80100dc2:	c1 ea 19             	shr    $0x19,%edx
80100dc5:	01 d0                	add    %edx,%eax
80100dc7:	83 e0 7f             	and    $0x7f,%eax
80100dca:	29 d0                	sub    %edx,%eax
80100dcc:	0f b6 80 14 f3 10 80 	movzbl -0x7fef0cec(%eax),%eax
80100dd3:	0f be c0             	movsbl %al,%eax
80100dd6:	89 04 24             	mov    %eax,(%esp)
80100dd9:	e8 87 f9 ff ff       	call   80100765 <consputc>
            input.buf[(i + 1)% INPUT_BUF]=input.buf[i% INPUT_BUF];
          }
          input.buf[input.e % INPUT_BUF] = c;
          input.last++;
          input.e++;
          for (i =input.e-1 ; i <input.last ; i++)
80100dde:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80100de2:	8b 55 f4             	mov    -0xc(%ebp),%edx
80100de5:	a1 a0 f3 10 80       	mov    0x8010f3a0,%eax
80100dea:	39 c2                	cmp    %eax,%edx
80100dec:	72 cc                	jb     80100dba <consoleintr+0x4ff>
          {
            consputc(input.buf[i%INPUT_BUF]);
          }
          for(i=0;i<(input.last-input.e);i++)
80100dee:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80100df5:	eb 10                	jmp    80100e07 <consoleintr+0x54c>
          {
            consputc(KEY_LF);
80100df7:	c7 04 24 e4 00 00 00 	movl   $0xe4,(%esp)
80100dfe:	e8 62 f9 ff ff       	call   80100765 <consputc>
          input.e++;
          for (i =input.e-1 ; i <input.last ; i++)
          {
            consputc(input.buf[i%INPUT_BUF]);
          }
          for(i=0;i<(input.last-input.e);i++)
80100e03:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80100e07:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100e0a:	8b 0d a0 f3 10 80    	mov    0x8010f3a0,%ecx
80100e10:	8b 15 9c f3 10 80    	mov    0x8010f39c,%edx
80100e16:	89 cb                	mov    %ecx,%ebx
80100e18:	29 d3                	sub    %edx,%ebx
80100e1a:	89 da                	mov    %ebx,%edx
80100e1c:	39 d0                	cmp    %edx,%eax
80100e1e:	72 d7                	jb     80100df7 <consoleintr+0x53c>

    default:
      if(c != 0 && input.e-input.r < INPUT_BUF)
      {
        c = (c == '\r') ? '\n' : c;
        if(input.e<input.last && c!='\n')
80100e20:	eb 43                	jmp    80100e65 <consoleintr+0x5aa>
            consputc(KEY_LF);
          }
        }
        else
        {
          if(c=='\n'){
80100e22:	83 7d f0 0a          	cmpl   $0xa,-0x10(%ebp)
80100e26:	75 0a                	jne    80100e32 <consoleintr+0x577>
            input.e=input.last;
80100e28:	a1 a0 f3 10 80       	mov    0x8010f3a0,%eax
80100e2d:	a3 9c f3 10 80       	mov    %eax,0x8010f39c
          }
          input.buf[input.e++ % INPUT_BUF] = c;
80100e32:	a1 9c f3 10 80       	mov    0x8010f39c,%eax
80100e37:	89 c1                	mov    %eax,%ecx
80100e39:	83 e1 7f             	and    $0x7f,%ecx
80100e3c:	8b 55 f0             	mov    -0x10(%ebp),%edx
80100e3f:	88 91 14 f3 10 80    	mov    %dl,-0x7fef0cec(%ecx)
80100e45:	83 c0 01             	add    $0x1,%eax
80100e48:	a3 9c f3 10 80       	mov    %eax,0x8010f39c
          input.last++;
80100e4d:	a1 a0 f3 10 80       	mov    0x8010f3a0,%eax
80100e52:	83 c0 01             	add    $0x1,%eax
80100e55:	a3 a0 f3 10 80       	mov    %eax,0x8010f3a0
          consputc(c);
80100e5a:	8b 45 f0             	mov    -0x10(%ebp),%eax
80100e5d:	89 04 24             	mov    %eax,(%esp)
80100e60:	e8 00 f9 ff ff       	call   80100765 <consputc>
        }
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF)
80100e65:	83 7d f0 0a          	cmpl   $0xa,-0x10(%ebp)
80100e69:	74 1c                	je     80100e87 <consoleintr+0x5cc>
80100e6b:	83 7d f0 04          	cmpl   $0x4,-0x10(%ebp)
80100e6f:	74 16                	je     80100e87 <consoleintr+0x5cc>
80100e71:	a1 9c f3 10 80       	mov    0x8010f39c,%eax
80100e76:	8b 15 94 f3 10 80    	mov    0x8010f394,%edx
80100e7c:	83 ea 80             	sub    $0xffffff80,%edx
80100e7f:	39 d0                	cmp    %edx,%eax
80100e81:	0f 85 f7 00 00 00    	jne    80100f7e <consoleintr+0x6c3>
        {
          strncpy(input.history[input.history_end % MAX_HISTORY_LENGTH]
            ,&input.buf[input.w% INPUT_BUF]
            ,input.last-input.w-1);
80100e87:	8b 15 a0 f3 10 80    	mov    0x8010f3a0,%edx
80100e8d:	a1 98 f3 10 80       	mov    0x8010f398,%eax
80100e92:	89 d1                	mov    %edx,%ecx
80100e94:	29 c1                	sub    %eax,%ecx
80100e96:	89 c8                	mov    %ecx,%eax
80100e98:	83 e8 01             	sub    $0x1,%eax
          input.last++;
          consputc(c);
        }
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF)
        {
          strncpy(input.history[input.history_end % MAX_HISTORY_LENGTH]
80100e9b:	89 c3                	mov    %eax,%ebx
            ,&input.buf[input.w% INPUT_BUF]
80100e9d:	a1 98 f3 10 80       	mov    0x8010f398,%eax
          input.last++;
          consputc(c);
        }
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF)
        {
          strncpy(input.history[input.history_end % MAX_HISTORY_LENGTH]
80100ea2:	83 e0 7f             	and    $0x7f,%eax
80100ea5:	8d b0 14 f3 10 80    	lea    -0x7fef0cec(%eax),%esi
80100eab:	8b 0d ac fd 10 80    	mov    0x8010fdac,%ecx
80100eb1:	ba cd cc cc cc       	mov    $0xcccccccd,%edx
80100eb6:	89 c8                	mov    %ecx,%eax
80100eb8:	f7 e2                	mul    %edx
80100eba:	c1 ea 04             	shr    $0x4,%edx
80100ebd:	89 d0                	mov    %edx,%eax
80100ebf:	c1 e0 02             	shl    $0x2,%eax
80100ec2:	01 d0                	add    %edx,%eax
80100ec4:	c1 e0 02             	shl    $0x2,%eax
80100ec7:	89 ca                	mov    %ecx,%edx
80100ec9:	29 c2                	sub    %eax,%edx
80100ecb:	89 d0                	mov    %edx,%eax
80100ecd:	c1 e0 02             	shl    $0x2,%eax
80100ed0:	01 d0                	add    %edx,%eax
80100ed2:	c1 e0 02             	shl    $0x2,%eax
80100ed5:	05 a4 f3 10 80       	add    $0x8010f3a4,%eax
80100eda:	89 5c 24 08          	mov    %ebx,0x8(%esp)
80100ede:	89 74 24 04          	mov    %esi,0x4(%esp)
80100ee2:	89 04 24             	mov    %eax,(%esp)
80100ee5:	e8 eb 4f 00 00       	call   80105ed5 <strncpy>
            ,&input.buf[input.w% INPUT_BUF]
            ,input.last-input.w-1);
          input.history_indx=++input.history_end;
80100eea:	a1 ac fd 10 80       	mov    0x8010fdac,%eax
80100eef:	83 c0 01             	add    $0x1,%eax
80100ef2:	a3 ac fd 10 80       	mov    %eax,0x8010fdac
80100ef7:	a1 ac fd 10 80       	mov    0x8010fdac,%eax
80100efc:	a3 a8 fd 10 80       	mov    %eax,0x8010fda8
          if ((input.history_end % MAX_HISTORY_LENGTH) == (input.history_start % MAX_HISTORY_LENGTH))
80100f01:	8b 1d ac fd 10 80    	mov    0x8010fdac,%ebx
80100f07:	ba cd cc cc cc       	mov    $0xcccccccd,%edx
80100f0c:	89 d8                	mov    %ebx,%eax
80100f0e:	f7 e2                	mul    %edx
80100f10:	89 d1                	mov    %edx,%ecx
80100f12:	c1 e9 04             	shr    $0x4,%ecx
80100f15:	89 c8                	mov    %ecx,%eax
80100f17:	c1 e0 02             	shl    $0x2,%eax
80100f1a:	01 c8                	add    %ecx,%eax
80100f1c:	c1 e0 02             	shl    $0x2,%eax
80100f1f:	89 d9                	mov    %ebx,%ecx
80100f21:	29 c1                	sub    %eax,%ecx
80100f23:	8b 1d a4 fd 10 80    	mov    0x8010fda4,%ebx
80100f29:	ba cd cc cc cc       	mov    $0xcccccccd,%edx
80100f2e:	89 d8                	mov    %ebx,%eax
80100f30:	f7 e2                	mul    %edx
80100f32:	c1 ea 04             	shr    $0x4,%edx
80100f35:	89 d0                	mov    %edx,%eax
80100f37:	c1 e0 02             	shl    $0x2,%eax
80100f3a:	01 d0                	add    %edx,%eax
80100f3c:	c1 e0 02             	shl    $0x2,%eax
80100f3f:	89 da                	mov    %ebx,%edx
80100f41:	29 c2                	sub    %eax,%edx
80100f43:	39 d1                	cmp    %edx,%ecx
80100f45:	75 0d                	jne    80100f54 <consoleintr+0x699>
          {
           input.history_start++;
80100f47:	a1 a4 fd 10 80       	mov    0x8010fda4,%eax
80100f4c:	83 c0 01             	add    $0x1,%eax
80100f4f:	a3 a4 fd 10 80       	mov    %eax,0x8010fda4
          }
          input.w = input.e;
80100f54:	a1 9c f3 10 80       	mov    0x8010f39c,%eax
80100f59:	a3 98 f3 10 80       	mov    %eax,0x8010f398
          wakeup(&input.r);
80100f5e:	c7 04 24 94 f3 10 80 	movl   $0x8010f394,(%esp)
80100f65:	e8 ad 47 00 00       	call   80105717 <wakeup>
        }
      }
      break;
80100f6a:	eb 12                	jmp    80100f7e <consoleintr+0x6c3>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
        input.e--;
        input.last--;
        consputc(BACKSPACE);
      }
      break;
80100f6c:	90                   	nop
80100f6d:	eb 10                	jmp    80100f7f <consoleintr+0x6c4>
          input.e--;
          input.last--;
          consputc(BACKSPACE);
        }
      }
      break;
80100f6f:	90                   	nop
80100f70:	eb 0d                	jmp    80100f7f <consoleintr+0x6c4>
      if(input.e != input.w)
      {
        input.e--;
        consputc(c);
      }
      break;
80100f72:	90                   	nop
80100f73:	eb 0a                	jmp    80100f7f <consoleintr+0x6c4>
      if(input.e < input.last)
      {
        consputc(input.buf[input.e% INPUT_BUF]);
        input.e++;
      }
      break;
80100f75:	90                   	nop
80100f76:	eb 07                	jmp    80100f7f <consoleintr+0x6c4>
        && ((input.history_indx + 1) % MAX_HISTORY_LENGTH) != (input.history_end % MAX_HISTORY_LENGTH ))
      {
        input.history_indx++;
        replace_line_on_screen();
      }
      break;
80100f78:	90                   	nop
80100f79:	eb 04                	jmp    80100f7f <consoleintr+0x6c4>
       && ((input.history_indx) % MAX_HISTORY_LENGTH) != (input.history_start % MAX_HISTORY_LENGTH) )
      {
        input.history_indx--;
        replace_line_on_screen();
      }
      break;
80100f7b:	90                   	nop
80100f7c:	eb 01                	jmp    80100f7f <consoleintr+0x6c4>
          }
          input.w = input.e;
          wakeup(&input.r);
        }
      }
      break;
80100f7e:	90                   	nop
consoleintr(int (*getc)(void))
{
  int c;
  int i;
  acquire(&input.lock);
  while((c = getc()) >= 0){
80100f7f:	8b 45 08             	mov    0x8(%ebp),%eax
80100f82:	ff d0                	call   *%eax
80100f84:	89 45 f0             	mov    %eax,-0x10(%ebp)
80100f87:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80100f8b:	0f 89 43 f9 ff ff    	jns    801008d4 <consoleintr+0x19>
        }
      }
      break;
    }
  }
  release(&input.lock);
80100f91:	c7 04 24 e0 f2 10 80 	movl   $0x8010f2e0,(%esp)
80100f98:	e8 7c 4b 00 00       	call   80105b19 <release>
}
80100f9d:	83 c4 20             	add    $0x20,%esp
80100fa0:	5b                   	pop    %ebx
80100fa1:	5e                   	pop    %esi
80100fa2:	5d                   	pop    %ebp
80100fa3:	c3                   	ret    

80100fa4 <consoleread>:



int
consoleread(struct inode *ip, char *dst, int n)
{
80100fa4:	55                   	push   %ebp
80100fa5:	89 e5                	mov    %esp,%ebp
80100fa7:	83 ec 28             	sub    $0x28,%esp
  uint target;
  int c;

  iunlock(ip);
80100faa:	8b 45 08             	mov    0x8(%ebp),%eax
80100fad:	89 04 24             	mov    %eax,(%esp)
80100fb0:	e8 55 11 00 00       	call   8010210a <iunlock>
  target = n;
80100fb5:	8b 45 10             	mov    0x10(%ebp),%eax
80100fb8:	89 45 f4             	mov    %eax,-0xc(%ebp)
  acquire(&input.lock);
80100fbb:	c7 04 24 e0 f2 10 80 	movl   $0x8010f2e0,(%esp)
80100fc2:	e8 f0 4a 00 00       	call   80105ab7 <acquire>
  while(n > 0){
80100fc7:	e9 a8 00 00 00       	jmp    80101074 <consoleread+0xd0>
    while(input.r == input.w){
      if(proc->killed){
80100fcc:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100fd2:	8b 40 24             	mov    0x24(%eax),%eax
80100fd5:	85 c0                	test   %eax,%eax
80100fd7:	74 21                	je     80100ffa <consoleread+0x56>
        release(&input.lock);
80100fd9:	c7 04 24 e0 f2 10 80 	movl   $0x8010f2e0,(%esp)
80100fe0:	e8 34 4b 00 00       	call   80105b19 <release>
        ilock(ip);
80100fe5:	8b 45 08             	mov    0x8(%ebp),%eax
80100fe8:	89 04 24             	mov    %eax,(%esp)
80100feb:	e8 cc 0f 00 00       	call   80101fbc <ilock>
        return -1;
80100ff0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100ff5:	e9 a9 00 00 00       	jmp    801010a3 <consoleread+0xff>
      }
      sleep(&input.r, &input.lock);
80100ffa:	c7 44 24 04 e0 f2 10 	movl   $0x8010f2e0,0x4(%esp)
80101001:	80 
80101002:	c7 04 24 94 f3 10 80 	movl   $0x8010f394,(%esp)
80101009:	e8 1b 46 00 00       	call   80105629 <sleep>
8010100e:	eb 01                	jmp    80101011 <consoleread+0x6d>

  iunlock(ip);
  target = n;
  acquire(&input.lock);
  while(n > 0){
    while(input.r == input.w){
80101010:	90                   	nop
80101011:	8b 15 94 f3 10 80    	mov    0x8010f394,%edx
80101017:	a1 98 f3 10 80       	mov    0x8010f398,%eax
8010101c:	39 c2                	cmp    %eax,%edx
8010101e:	74 ac                	je     80100fcc <consoleread+0x28>
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &input.lock);
    }
    c = input.buf[input.r++ % INPUT_BUF];
80101020:	a1 94 f3 10 80       	mov    0x8010f394,%eax
80101025:	89 c2                	mov    %eax,%edx
80101027:	83 e2 7f             	and    $0x7f,%edx
8010102a:	0f b6 92 14 f3 10 80 	movzbl -0x7fef0cec(%edx),%edx
80101031:	0f be d2             	movsbl %dl,%edx
80101034:	89 55 f0             	mov    %edx,-0x10(%ebp)
80101037:	83 c0 01             	add    $0x1,%eax
8010103a:	a3 94 f3 10 80       	mov    %eax,0x8010f394
    if(c == C('D')){  // EOF
8010103f:	83 7d f0 04          	cmpl   $0x4,-0x10(%ebp)
80101043:	75 17                	jne    8010105c <consoleread+0xb8>
      if(n < target){
80101045:	8b 45 10             	mov    0x10(%ebp),%eax
80101048:	3b 45 f4             	cmp    -0xc(%ebp),%eax
8010104b:	73 2f                	jae    8010107c <consoleread+0xd8>
        // Save ^D for next time, to make sure
        // caller gets a 0-byte result.
        input.r--;
8010104d:	a1 94 f3 10 80       	mov    0x8010f394,%eax
80101052:	83 e8 01             	sub    $0x1,%eax
80101055:	a3 94 f3 10 80       	mov    %eax,0x8010f394
      }
      break;
8010105a:	eb 20                	jmp    8010107c <consoleread+0xd8>
    }
    *dst++ = c;
8010105c:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010105f:	89 c2                	mov    %eax,%edx
80101061:	8b 45 0c             	mov    0xc(%ebp),%eax
80101064:	88 10                	mov    %dl,(%eax)
80101066:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
    --n;
8010106a:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
    if(c == '\n')
8010106e:	83 7d f0 0a          	cmpl   $0xa,-0x10(%ebp)
80101072:	74 0b                	je     8010107f <consoleread+0xdb>
  int c;

  iunlock(ip);
  target = n;
  acquire(&input.lock);
  while(n > 0){
80101074:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80101078:	7f 96                	jg     80101010 <consoleread+0x6c>
8010107a:	eb 04                	jmp    80101080 <consoleread+0xdc>
      if(n < target){
        // Save ^D for next time, to make sure
        // caller gets a 0-byte result.
        input.r--;
      }
      break;
8010107c:	90                   	nop
8010107d:	eb 01                	jmp    80101080 <consoleread+0xdc>
    }
    *dst++ = c;
    --n;
    if(c == '\n')
      break;
8010107f:	90                   	nop
  }
  release(&input.lock);
80101080:	c7 04 24 e0 f2 10 80 	movl   $0x8010f2e0,(%esp)
80101087:	e8 8d 4a 00 00       	call   80105b19 <release>
  ilock(ip);
8010108c:	8b 45 08             	mov    0x8(%ebp),%eax
8010108f:	89 04 24             	mov    %eax,(%esp)
80101092:	e8 25 0f 00 00       	call   80101fbc <ilock>

  return target - n;
80101097:	8b 45 10             	mov    0x10(%ebp),%eax
8010109a:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010109d:	89 d1                	mov    %edx,%ecx
8010109f:	29 c1                	sub    %eax,%ecx
801010a1:	89 c8                	mov    %ecx,%eax
}
801010a3:	c9                   	leave  
801010a4:	c3                   	ret    

801010a5 <consolewrite>:

int
consolewrite(struct inode *ip, char *buf, int n)
{
801010a5:	55                   	push   %ebp
801010a6:	89 e5                	mov    %esp,%ebp
801010a8:	83 ec 28             	sub    $0x28,%esp
  int i;

  iunlock(ip);
801010ab:	8b 45 08             	mov    0x8(%ebp),%eax
801010ae:	89 04 24             	mov    %eax,(%esp)
801010b1:	e8 54 10 00 00       	call   8010210a <iunlock>
  acquire(&cons.lock);
801010b6:	c7 04 24 e0 c5 10 80 	movl   $0x8010c5e0,(%esp)
801010bd:	e8 f5 49 00 00       	call   80105ab7 <acquire>
  for(i = 0; i < n; i++)
801010c2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801010c9:	eb 1d                	jmp    801010e8 <consolewrite+0x43>
    consputc(buf[i] & 0xff);
801010cb:	8b 45 f4             	mov    -0xc(%ebp),%eax
801010ce:	03 45 0c             	add    0xc(%ebp),%eax
801010d1:	0f b6 00             	movzbl (%eax),%eax
801010d4:	0f be c0             	movsbl %al,%eax
801010d7:	25 ff 00 00 00       	and    $0xff,%eax
801010dc:	89 04 24             	mov    %eax,(%esp)
801010df:	e8 81 f6 ff ff       	call   80100765 <consputc>
{
  int i;

  iunlock(ip);
  acquire(&cons.lock);
  for(i = 0; i < n; i++)
801010e4:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801010e8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801010eb:	3b 45 10             	cmp    0x10(%ebp),%eax
801010ee:	7c db                	jl     801010cb <consolewrite+0x26>
    consputc(buf[i] & 0xff);
  release(&cons.lock);
801010f0:	c7 04 24 e0 c5 10 80 	movl   $0x8010c5e0,(%esp)
801010f7:	e8 1d 4a 00 00       	call   80105b19 <release>
  ilock(ip);
801010fc:	8b 45 08             	mov    0x8(%ebp),%eax
801010ff:	89 04 24             	mov    %eax,(%esp)
80101102:	e8 b5 0e 00 00       	call   80101fbc <ilock>

  return n;
80101107:	8b 45 10             	mov    0x10(%ebp),%eax
}
8010110a:	c9                   	leave  
8010110b:	c3                   	ret    

8010110c <consoleinit>:

void
consoleinit(void)
{
8010110c:	55                   	push   %ebp
8010110d:	89 e5                	mov    %esp,%ebp
8010110f:	83 ec 18             	sub    $0x18,%esp
  initlock(&cons.lock, "console");
80101112:	c7 44 24 04 f3 93 10 	movl   $0x801093f3,0x4(%esp)
80101119:	80 
8010111a:	c7 04 24 e0 c5 10 80 	movl   $0x8010c5e0,(%esp)
80101121:	e8 70 49 00 00       	call   80105a96 <initlock>
  initlock(&input.lock, "input");
80101126:	c7 44 24 04 fb 93 10 	movl   $0x801093fb,0x4(%esp)
8010112d:	80 
8010112e:	c7 04 24 e0 f2 10 80 	movl   $0x8010f2e0,(%esp)
80101135:	e8 5c 49 00 00       	call   80105a96 <initlock>

  devsw[CONSOLE].write = consolewrite;
8010113a:	c7 05 6c 07 11 80 a5 	movl   $0x801010a5,0x8011076c
80101141:	10 10 80 
  devsw[CONSOLE].read = consoleread;
80101144:	c7 05 68 07 11 80 a4 	movl   $0x80100fa4,0x80110768
8010114b:	0f 10 80 
  cons.locking = 1;
8010114e:	c7 05 14 c6 10 80 01 	movl   $0x1,0x8010c614
80101155:	00 00 00 

  picenable(IRQ_KBD);
80101158:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
8010115f:	e8 b1 30 00 00       	call   80104215 <picenable>
  ioapicenable(IRQ_KBD, 0);
80101164:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
8010116b:	00 
8010116c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80101173:	e8 52 1f 00 00       	call   801030ca <ioapicenable>
}
80101178:	c9                   	leave  
80101179:	c3                   	ret    
	...

8010117c <exec>:
static char pathVariable[MAX_PATH_ENTRIES][INPUT_BUF]={};
static int place_to_add_path=0;

int
exec(char *path, char **argv)
{
8010117c:	55                   	push   %ebp
8010117d:	89 e5                	mov    %esp,%ebp
8010117f:	57                   	push   %edi
80101180:	53                   	push   %ebx
80101181:	81 ec 30 02 00 00    	sub    $0x230,%esp
  char *s, *last;
  char newPath[2*INPUT_BUF]={0};
80101187:	8d 9d d0 fe ff ff    	lea    -0x130(%ebp),%ebx
8010118d:	b8 00 00 00 00       	mov    $0x0,%eax
80101192:	ba 40 00 00 00       	mov    $0x40,%edx
80101197:	89 df                	mov    %ebx,%edi
80101199:	89 d1                	mov    %edx,%ecx
8010119b:	f3 ab                	rep stos %eax,%es:(%edi)
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;

  if((ip = namei(path)) == 0)
8010119d:	8b 45 08             	mov    0x8(%ebp),%eax
801011a0:	89 04 24             	mov    %eax,(%esp)
801011a3:	e8 b6 19 00 00       	call   80102b5e <namei>
801011a8:	89 45 d8             	mov    %eax,-0x28(%ebp)
801011ab:	83 7d d8 00          	cmpl   $0x0,-0x28(%ebp)
801011af:	75 64                	jne    80101215 <exec+0x99>
  {
    for( i=0;i<place_to_add_path;i++)
801011b1:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
801011b8:	eb 3a                	jmp    801011f4 <exec+0x78>
    {
      
      if((ip = namei(newstrcat(newPath,pathVariable[i],path))) != 0){
801011ba:	8b 45 ec             	mov    -0x14(%ebp),%eax
801011bd:	c1 e0 07             	shl    $0x7,%eax
801011c0:	8d 90 20 c6 10 80    	lea    -0x7fef39e0(%eax),%edx
801011c6:	8b 45 08             	mov    0x8(%ebp),%eax
801011c9:	89 44 24 08          	mov    %eax,0x8(%esp)
801011cd:	89 54 24 04          	mov    %edx,0x4(%esp)
801011d1:	8d 85 d0 fe ff ff    	lea    -0x130(%ebp),%eax
801011d7:	89 04 24             	mov    %eax,(%esp)
801011da:	e8 ca 4d 00 00       	call   80105fa9 <newstrcat>
801011df:	89 04 24             	mov    %eax,(%esp)
801011e2:	e8 77 19 00 00       	call   80102b5e <namei>
801011e7:	89 45 d8             	mov    %eax,-0x28(%ebp)
801011ea:	83 7d d8 00          	cmpl   $0x0,-0x28(%ebp)
801011ee:	75 10                	jne    80101200 <exec+0x84>
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;

  if((ip = namei(path)) == 0)
  {
    for( i=0;i<place_to_add_path;i++)
801011f0:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
801011f4:	a1 20 cb 10 80       	mov    0x8010cb20,%eax
801011f9:	39 45 ec             	cmp    %eax,-0x14(%ebp)
801011fc:	7c bc                	jl     801011ba <exec+0x3e>
801011fe:	eb 01                	jmp    80101201 <exec+0x85>
    {
      
      if((ip = namei(newstrcat(newPath,pathVariable[i],path))) != 0){
  	   break;
80101200:	90                   	nop
      }
    }
    if(i>=place_to_add_path)
80101201:	a1 20 cb 10 80       	mov    0x8010cb20,%eax
80101206:	39 45 ec             	cmp    %eax,-0x14(%ebp)
80101209:	7c 0a                	jl     80101215 <exec+0x99>
    return -1;
8010120b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101210:	e9 da 03 00 00       	jmp    801015ef <exec+0x473>
  }
  
  ilock(ip);
80101215:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101218:	89 04 24             	mov    %eax,(%esp)
8010121b:	e8 9c 0d 00 00       	call   80101fbc <ilock>
  pgdir = 0;
80101220:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) < sizeof(elf))
80101227:	c7 44 24 0c 34 00 00 	movl   $0x34,0xc(%esp)
8010122e:	00 
8010122f:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
80101236:	00 
80101237:	8d 85 0c fe ff ff    	lea    -0x1f4(%ebp),%eax
8010123d:	89 44 24 04          	mov    %eax,0x4(%esp)
80101241:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101244:	89 04 24             	mov    %eax,(%esp)
80101247:	e8 66 12 00 00       	call   801024b2 <readi>
8010124c:	83 f8 33             	cmp    $0x33,%eax
8010124f:	0f 86 54 03 00 00    	jbe    801015a9 <exec+0x42d>
    goto bad;
  if(elf.magic != ELF_MAGIC)
80101255:	8b 85 0c fe ff ff    	mov    -0x1f4(%ebp),%eax
8010125b:	3d 7f 45 4c 46       	cmp    $0x464c457f,%eax
80101260:	0f 85 46 03 00 00    	jne    801015ac <exec+0x430>
    goto bad;

  if((pgdir = setupkvm(kalloc)) == 0)
80101266:	c7 04 24 53 32 10 80 	movl   $0x80103253,(%esp)
8010126d:	e8 df 78 00 00       	call   80108b51 <setupkvm>
80101272:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80101275:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
80101279:	0f 84 30 03 00 00    	je     801015af <exec+0x433>
    goto bad;

  // Load program into memory.
  sz = 0;
8010127f:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80101286:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
8010128d:	8b 85 28 fe ff ff    	mov    -0x1d8(%ebp),%eax
80101293:	89 45 e8             	mov    %eax,-0x18(%ebp)
80101296:	e9 c5 00 00 00       	jmp    80101360 <exec+0x1e4>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
8010129b:	8b 45 e8             	mov    -0x18(%ebp),%eax
8010129e:	c7 44 24 0c 20 00 00 	movl   $0x20,0xc(%esp)
801012a5:	00 
801012a6:	89 44 24 08          	mov    %eax,0x8(%esp)
801012aa:	8d 85 ec fd ff ff    	lea    -0x214(%ebp),%eax
801012b0:	89 44 24 04          	mov    %eax,0x4(%esp)
801012b4:	8b 45 d8             	mov    -0x28(%ebp),%eax
801012b7:	89 04 24             	mov    %eax,(%esp)
801012ba:	e8 f3 11 00 00       	call   801024b2 <readi>
801012bf:	83 f8 20             	cmp    $0x20,%eax
801012c2:	0f 85 ea 02 00 00    	jne    801015b2 <exec+0x436>
      goto bad;
    if(ph.type != ELF_PROG_LOAD)
801012c8:	8b 85 ec fd ff ff    	mov    -0x214(%ebp),%eax
801012ce:	83 f8 01             	cmp    $0x1,%eax
801012d1:	75 7f                	jne    80101352 <exec+0x1d6>
      continue;
    if(ph.memsz < ph.filesz)
801012d3:	8b 95 00 fe ff ff    	mov    -0x200(%ebp),%edx
801012d9:	8b 85 fc fd ff ff    	mov    -0x204(%ebp),%eax
801012df:	39 c2                	cmp    %eax,%edx
801012e1:	0f 82 ce 02 00 00    	jb     801015b5 <exec+0x439>
      goto bad;
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
801012e7:	8b 95 f4 fd ff ff    	mov    -0x20c(%ebp),%edx
801012ed:	8b 85 00 fe ff ff    	mov    -0x200(%ebp),%eax
801012f3:	01 d0                	add    %edx,%eax
801012f5:	89 44 24 08          	mov    %eax,0x8(%esp)
801012f9:	8b 45 e0             	mov    -0x20(%ebp),%eax
801012fc:	89 44 24 04          	mov    %eax,0x4(%esp)
80101300:	8b 45 d4             	mov    -0x2c(%ebp),%eax
80101303:	89 04 24             	mov    %eax,(%esp)
80101306:	e8 18 7c 00 00       	call   80108f23 <allocuvm>
8010130b:	89 45 e0             	mov    %eax,-0x20(%ebp)
8010130e:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
80101312:	0f 84 a0 02 00 00    	je     801015b8 <exec+0x43c>
      goto bad;
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80101318:	8b 8d fc fd ff ff    	mov    -0x204(%ebp),%ecx
8010131e:	8b 95 f0 fd ff ff    	mov    -0x210(%ebp),%edx
80101324:	8b 85 f4 fd ff ff    	mov    -0x20c(%ebp),%eax
8010132a:	89 4c 24 10          	mov    %ecx,0x10(%esp)
8010132e:	89 54 24 0c          	mov    %edx,0xc(%esp)
80101332:	8b 55 d8             	mov    -0x28(%ebp),%edx
80101335:	89 54 24 08          	mov    %edx,0x8(%esp)
80101339:	89 44 24 04          	mov    %eax,0x4(%esp)
8010133d:	8b 45 d4             	mov    -0x2c(%ebp),%eax
80101340:	89 04 24             	mov    %eax,(%esp)
80101343:	e8 ec 7a 00 00       	call   80108e34 <loaduvm>
80101348:	85 c0                	test   %eax,%eax
8010134a:	0f 88 6b 02 00 00    	js     801015bb <exec+0x43f>
80101350:	eb 01                	jmp    80101353 <exec+0x1d7>
  sz = 0;
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
      goto bad;
    if(ph.type != ELF_PROG_LOAD)
      continue;
80101352:	90                   	nop
  if((pgdir = setupkvm(kalloc)) == 0)
    goto bad;

  // Load program into memory.
  sz = 0;
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80101353:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
80101357:	8b 45 e8             	mov    -0x18(%ebp),%eax
8010135a:	83 c0 20             	add    $0x20,%eax
8010135d:	89 45 e8             	mov    %eax,-0x18(%ebp)
80101360:	0f b7 85 38 fe ff ff 	movzwl -0x1c8(%ebp),%eax
80101367:	0f b7 c0             	movzwl %ax,%eax
8010136a:	3b 45 ec             	cmp    -0x14(%ebp),%eax
8010136d:	0f 8f 28 ff ff ff    	jg     8010129b <exec+0x11f>
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
      goto bad;
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
      goto bad;
  }
  iunlockput(ip);
80101373:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101376:	89 04 24             	mov    %eax,(%esp)
80101379:	e8 c2 0e 00 00       	call   80102240 <iunlockput>
  ip = 0;
8010137e:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)

  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
80101385:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101388:	05 ff 0f 00 00       	add    $0xfff,%eax
8010138d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80101392:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80101395:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101398:	05 00 20 00 00       	add    $0x2000,%eax
8010139d:	89 44 24 08          	mov    %eax,0x8(%esp)
801013a1:	8b 45 e0             	mov    -0x20(%ebp),%eax
801013a4:	89 44 24 04          	mov    %eax,0x4(%esp)
801013a8:	8b 45 d4             	mov    -0x2c(%ebp),%eax
801013ab:	89 04 24             	mov    %eax,(%esp)
801013ae:	e8 70 7b 00 00       	call   80108f23 <allocuvm>
801013b3:	89 45 e0             	mov    %eax,-0x20(%ebp)
801013b6:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
801013ba:	0f 84 fe 01 00 00    	je     801015be <exec+0x442>
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
801013c0:	8b 45 e0             	mov    -0x20(%ebp),%eax
801013c3:	2d 00 20 00 00       	sub    $0x2000,%eax
801013c8:	89 44 24 04          	mov    %eax,0x4(%esp)
801013cc:	8b 45 d4             	mov    -0x2c(%ebp),%eax
801013cf:	89 04 24             	mov    %eax,(%esp)
801013d2:	e8 70 7d 00 00       	call   80109147 <clearpteu>
  sp = sz;
801013d7:	8b 45 e0             	mov    -0x20(%ebp),%eax
801013da:	89 45 dc             	mov    %eax,-0x24(%ebp)

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
801013dd:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
801013e4:	e9 81 00 00 00       	jmp    8010146a <exec+0x2ee>
    if(argc >= MAXARG)
801013e9:	83 7d e4 1f          	cmpl   $0x1f,-0x1c(%ebp)
801013ed:	0f 87 ce 01 00 00    	ja     801015c1 <exec+0x445>
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
801013f3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801013f6:	c1 e0 02             	shl    $0x2,%eax
801013f9:	03 45 0c             	add    0xc(%ebp),%eax
801013fc:	8b 00                	mov    (%eax),%eax
801013fe:	89 04 24             	mov    %eax,(%esp)
80101401:	e8 7e 4b 00 00       	call   80105f84 <strlen>
80101406:	f7 d0                	not    %eax
80101408:	03 45 dc             	add    -0x24(%ebp),%eax
8010140b:	83 e0 fc             	and    $0xfffffffc,%eax
8010140e:	89 45 dc             	mov    %eax,-0x24(%ebp)
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80101411:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101414:	c1 e0 02             	shl    $0x2,%eax
80101417:	03 45 0c             	add    0xc(%ebp),%eax
8010141a:	8b 00                	mov    (%eax),%eax
8010141c:	89 04 24             	mov    %eax,(%esp)
8010141f:	e8 60 4b 00 00       	call   80105f84 <strlen>
80101424:	83 c0 01             	add    $0x1,%eax
80101427:	89 c2                	mov    %eax,%edx
80101429:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010142c:	c1 e0 02             	shl    $0x2,%eax
8010142f:	03 45 0c             	add    0xc(%ebp),%eax
80101432:	8b 00                	mov    (%eax),%eax
80101434:	89 54 24 0c          	mov    %edx,0xc(%esp)
80101438:	89 44 24 08          	mov    %eax,0x8(%esp)
8010143c:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010143f:	89 44 24 04          	mov    %eax,0x4(%esp)
80101443:	8b 45 d4             	mov    -0x2c(%ebp),%eax
80101446:	89 04 24             	mov    %eax,(%esp)
80101449:	e8 ad 7e 00 00       	call   801092fb <copyout>
8010144e:	85 c0                	test   %eax,%eax
80101450:	0f 88 6e 01 00 00    	js     801015c4 <exec+0x448>
      goto bad;
    ustack[3+argc] = sp;
80101456:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101459:	8d 50 03             	lea    0x3(%eax),%edx
8010145c:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010145f:	89 84 95 40 fe ff ff 	mov    %eax,-0x1c0(%ebp,%edx,4)
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80101466:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
8010146a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010146d:	c1 e0 02             	shl    $0x2,%eax
80101470:	03 45 0c             	add    0xc(%ebp),%eax
80101473:	8b 00                	mov    (%eax),%eax
80101475:	85 c0                	test   %eax,%eax
80101477:	0f 85 6c ff ff ff    	jne    801013e9 <exec+0x26d>
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
      goto bad;
    ustack[3+argc] = sp;
  }
  ustack[3+argc] = 0;
8010147d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101480:	83 c0 03             	add    $0x3,%eax
80101483:	c7 84 85 40 fe ff ff 	movl   $0x0,-0x1c0(%ebp,%eax,4)
8010148a:	00 00 00 00 

  ustack[0] = 0xffffffff;  // fake return PC
8010148e:	c7 85 40 fe ff ff ff 	movl   $0xffffffff,-0x1c0(%ebp)
80101495:	ff ff ff 
  ustack[1] = argc;
80101498:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010149b:	89 85 44 fe ff ff    	mov    %eax,-0x1bc(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
801014a1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801014a4:	83 c0 01             	add    $0x1,%eax
801014a7:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
801014ae:	8b 45 dc             	mov    -0x24(%ebp),%eax
801014b1:	29 d0                	sub    %edx,%eax
801014b3:	89 85 48 fe ff ff    	mov    %eax,-0x1b8(%ebp)

  sp -= (3+argc+1) * 4;
801014b9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801014bc:	83 c0 04             	add    $0x4,%eax
801014bf:	c1 e0 02             	shl    $0x2,%eax
801014c2:	29 45 dc             	sub    %eax,-0x24(%ebp)
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
801014c5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801014c8:	83 c0 04             	add    $0x4,%eax
801014cb:	c1 e0 02             	shl    $0x2,%eax
801014ce:	89 44 24 0c          	mov    %eax,0xc(%esp)
801014d2:	8d 85 40 fe ff ff    	lea    -0x1c0(%ebp),%eax
801014d8:	89 44 24 08          	mov    %eax,0x8(%esp)
801014dc:	8b 45 dc             	mov    -0x24(%ebp),%eax
801014df:	89 44 24 04          	mov    %eax,0x4(%esp)
801014e3:	8b 45 d4             	mov    -0x2c(%ebp),%eax
801014e6:	89 04 24             	mov    %eax,(%esp)
801014e9:	e8 0d 7e 00 00       	call   801092fb <copyout>
801014ee:	85 c0                	test   %eax,%eax
801014f0:	0f 88 d1 00 00 00    	js     801015c7 <exec+0x44b>
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
801014f6:	8b 45 08             	mov    0x8(%ebp),%eax
801014f9:	89 45 f4             	mov    %eax,-0xc(%ebp)
801014fc:	8b 45 f4             	mov    -0xc(%ebp),%eax
801014ff:	89 45 f0             	mov    %eax,-0x10(%ebp)
80101502:	eb 17                	jmp    8010151b <exec+0x39f>
    if(*s == '/')
80101504:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101507:	0f b6 00             	movzbl (%eax),%eax
8010150a:	3c 2f                	cmp    $0x2f,%al
8010150c:	75 09                	jne    80101517 <exec+0x39b>
      last = s+1;
8010150e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101511:	83 c0 01             	add    $0x1,%eax
80101514:	89 45 f0             	mov    %eax,-0x10(%ebp)
  sp -= (3+argc+1) * 4;
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
80101517:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
8010151b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010151e:	0f b6 00             	movzbl (%eax),%eax
80101521:	84 c0                	test   %al,%al
80101523:	75 df                	jne    80101504 <exec+0x388>
    if(*s == '/')
      last = s+1;
  safestrcpy(proc->name, last, sizeof(proc->name));
80101525:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010152b:	8d 50 6c             	lea    0x6c(%eax),%edx
8010152e:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
80101535:	00 
80101536:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101539:	89 44 24 04          	mov    %eax,0x4(%esp)
8010153d:	89 14 24             	mov    %edx,(%esp)
80101540:	e8 f1 49 00 00       	call   80105f36 <safestrcpy>

  // Commit to the user image.
  oldpgdir = proc->pgdir;
80101545:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010154b:	8b 40 04             	mov    0x4(%eax),%eax
8010154e:	89 45 d0             	mov    %eax,-0x30(%ebp)
  proc->pgdir = pgdir;
80101551:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80101557:	8b 55 d4             	mov    -0x2c(%ebp),%edx
8010155a:	89 50 04             	mov    %edx,0x4(%eax)
  proc->sz = sz;
8010155d:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80101563:	8b 55 e0             	mov    -0x20(%ebp),%edx
80101566:	89 10                	mov    %edx,(%eax)
  proc->tf->eip = elf.entry;  // main
80101568:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010156e:	8b 40 18             	mov    0x18(%eax),%eax
80101571:	8b 95 24 fe ff ff    	mov    -0x1dc(%ebp),%edx
80101577:	89 50 38             	mov    %edx,0x38(%eax)
  proc->tf->esp = sp;
8010157a:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80101580:	8b 40 18             	mov    0x18(%eax),%eax
80101583:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101586:	89 50 44             	mov    %edx,0x44(%eax)
  switchuvm(proc);
80101589:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010158f:	89 04 24             	mov    %eax,(%esp)
80101592:	e8 ab 76 00 00       	call   80108c42 <switchuvm>
  freevm(oldpgdir);
80101597:	8b 45 d0             	mov    -0x30(%ebp),%eax
8010159a:	89 04 24             	mov    %eax,(%esp)
8010159d:	e8 17 7b 00 00       	call   801090b9 <freevm>
  return 0;
801015a2:	b8 00 00 00 00       	mov    $0x0,%eax
801015a7:	eb 46                	jmp    801015ef <exec+0x473>
  ilock(ip);
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) < sizeof(elf))
    goto bad;
801015a9:	90                   	nop
801015aa:	eb 1c                	jmp    801015c8 <exec+0x44c>
  if(elf.magic != ELF_MAGIC)
    goto bad;
801015ac:	90                   	nop
801015ad:	eb 19                	jmp    801015c8 <exec+0x44c>

  if((pgdir = setupkvm(kalloc)) == 0)
    goto bad;
801015af:	90                   	nop
801015b0:	eb 16                	jmp    801015c8 <exec+0x44c>

  // Load program into memory.
  sz = 0;
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
      goto bad;
801015b2:	90                   	nop
801015b3:	eb 13                	jmp    801015c8 <exec+0x44c>
    if(ph.type != ELF_PROG_LOAD)
      continue;
    if(ph.memsz < ph.filesz)
      goto bad;
801015b5:	90                   	nop
801015b6:	eb 10                	jmp    801015c8 <exec+0x44c>
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
      goto bad;
801015b8:	90                   	nop
801015b9:	eb 0d                	jmp    801015c8 <exec+0x44c>
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
      goto bad;
801015bb:	90                   	nop
801015bc:	eb 0a                	jmp    801015c8 <exec+0x44c>

  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
    goto bad;
801015be:	90                   	nop
801015bf:	eb 07                	jmp    801015c8 <exec+0x44c>
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
    if(argc >= MAXARG)
      goto bad;
801015c1:	90                   	nop
801015c2:	eb 04                	jmp    801015c8 <exec+0x44c>
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
      goto bad;
801015c4:	90                   	nop
801015c5:	eb 01                	jmp    801015c8 <exec+0x44c>
  ustack[1] = argc;
  ustack[2] = sp - (argc+1)*4;  // argv pointer

  sp -= (3+argc+1) * 4;
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
    goto bad;
801015c7:	90                   	nop
  switchuvm(proc);
  freevm(oldpgdir);
  return 0;

 bad:
  if(pgdir)
801015c8:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
801015cc:	74 0b                	je     801015d9 <exec+0x45d>
    freevm(pgdir);
801015ce:	8b 45 d4             	mov    -0x2c(%ebp),%eax
801015d1:	89 04 24             	mov    %eax,(%esp)
801015d4:	e8 e0 7a 00 00       	call   801090b9 <freevm>
  if(ip)
801015d9:	83 7d d8 00          	cmpl   $0x0,-0x28(%ebp)
801015dd:	74 0b                	je     801015ea <exec+0x46e>
    iunlockput(ip);
801015df:	8b 45 d8             	mov    -0x28(%ebp),%eax
801015e2:	89 04 24             	mov    %eax,(%esp)
801015e5:	e8 56 0c 00 00       	call   80102240 <iunlockput>
  return -1;
801015ea:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801015ef:	81 c4 30 02 00 00    	add    $0x230,%esp
801015f5:	5b                   	pop    %ebx
801015f6:	5f                   	pop    %edi
801015f7:	5d                   	pop    %ebp
801015f8:	c3                   	ret    

801015f9 <definition_add_path>:

int
definition_add_path(char *path){
801015f9:	55                   	push   %ebp
801015fa:	89 e5                	mov    %esp,%ebp
801015fc:	83 ec 18             	sub    $0x18,%esp
  if(place_to_add_path>MAX_PATH_ENTRIES){
801015ff:	a1 20 cb 10 80       	mov    0x8010cb20,%eax
80101604:	83 f8 0a             	cmp    $0xa,%eax
80101607:	7e 07                	jle    80101610 <definition_add_path+0x17>
      return -1;
80101609:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010160e:	eb 42                	jmp    80101652 <definition_add_path+0x59>
  }
  safestrcpy(pathVariable[place_to_add_path],path,strlen(path)+1);
80101610:	8b 45 08             	mov    0x8(%ebp),%eax
80101613:	89 04 24             	mov    %eax,(%esp)
80101616:	e8 69 49 00 00       	call   80105f84 <strlen>
8010161b:	83 c0 01             	add    $0x1,%eax
8010161e:	8b 15 20 cb 10 80    	mov    0x8010cb20,%edx
80101624:	c1 e2 07             	shl    $0x7,%edx
80101627:	81 c2 20 c6 10 80    	add    $0x8010c620,%edx
8010162d:	89 44 24 08          	mov    %eax,0x8(%esp)
80101631:	8b 45 08             	mov    0x8(%ebp),%eax
80101634:	89 44 24 04          	mov    %eax,0x4(%esp)
80101638:	89 14 24             	mov    %edx,(%esp)
8010163b:	e8 f6 48 00 00       	call   80105f36 <safestrcpy>
  place_to_add_path++;
80101640:	a1 20 cb 10 80       	mov    0x8010cb20,%eax
80101645:	83 c0 01             	add    $0x1,%eax
80101648:	a3 20 cb 10 80       	mov    %eax,0x8010cb20
  return 0;
8010164d:	b8 00 00 00 00       	mov    $0x0,%eax
80101652:	c9                   	leave  
80101653:	c3                   	ret    

80101654 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80101654:	55                   	push   %ebp
80101655:	89 e5                	mov    %esp,%ebp
80101657:	83 ec 18             	sub    $0x18,%esp
  initlock(&ftable.lock, "ftable");
8010165a:	c7 44 24 04 01 94 10 	movl   $0x80109401,0x4(%esp)
80101661:	80 
80101662:	c7 04 24 c0 fd 10 80 	movl   $0x8010fdc0,(%esp)
80101669:	e8 28 44 00 00       	call   80105a96 <initlock>
}
8010166e:	c9                   	leave  
8010166f:	c3                   	ret    

80101670 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80101670:	55                   	push   %ebp
80101671:	89 e5                	mov    %esp,%ebp
80101673:	83 ec 28             	sub    $0x28,%esp
  struct file *f;

  acquire(&ftable.lock);
80101676:	c7 04 24 c0 fd 10 80 	movl   $0x8010fdc0,(%esp)
8010167d:	e8 35 44 00 00       	call   80105ab7 <acquire>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80101682:	c7 45 f4 f4 fd 10 80 	movl   $0x8010fdf4,-0xc(%ebp)
80101689:	eb 29                	jmp    801016b4 <filealloc+0x44>
    if(f->ref == 0){
8010168b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010168e:	8b 40 04             	mov    0x4(%eax),%eax
80101691:	85 c0                	test   %eax,%eax
80101693:	75 1b                	jne    801016b0 <filealloc+0x40>
      f->ref = 1;
80101695:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101698:	c7 40 04 01 00 00 00 	movl   $0x1,0x4(%eax)
      release(&ftable.lock);
8010169f:	c7 04 24 c0 fd 10 80 	movl   $0x8010fdc0,(%esp)
801016a6:	e8 6e 44 00 00       	call   80105b19 <release>
      return f;
801016ab:	8b 45 f4             	mov    -0xc(%ebp),%eax
801016ae:	eb 1e                	jmp    801016ce <filealloc+0x5e>
filealloc(void)
{
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
801016b0:	83 45 f4 18          	addl   $0x18,-0xc(%ebp)
801016b4:	81 7d f4 54 07 11 80 	cmpl   $0x80110754,-0xc(%ebp)
801016bb:	72 ce                	jb     8010168b <filealloc+0x1b>
      f->ref = 1;
      release(&ftable.lock);
      return f;
    }
  }
  release(&ftable.lock);
801016bd:	c7 04 24 c0 fd 10 80 	movl   $0x8010fdc0,(%esp)
801016c4:	e8 50 44 00 00       	call   80105b19 <release>
  return 0;
801016c9:	b8 00 00 00 00       	mov    $0x0,%eax
}
801016ce:	c9                   	leave  
801016cf:	c3                   	ret    

801016d0 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
801016d0:	55                   	push   %ebp
801016d1:	89 e5                	mov    %esp,%ebp
801016d3:	83 ec 18             	sub    $0x18,%esp
  acquire(&ftable.lock);
801016d6:	c7 04 24 c0 fd 10 80 	movl   $0x8010fdc0,(%esp)
801016dd:	e8 d5 43 00 00       	call   80105ab7 <acquire>
  if(f->ref < 1)
801016e2:	8b 45 08             	mov    0x8(%ebp),%eax
801016e5:	8b 40 04             	mov    0x4(%eax),%eax
801016e8:	85 c0                	test   %eax,%eax
801016ea:	7f 0c                	jg     801016f8 <filedup+0x28>
    panic("filedup");
801016ec:	c7 04 24 08 94 10 80 	movl   $0x80109408,(%esp)
801016f3:	e8 45 ee ff ff       	call   8010053d <panic>
  f->ref++;
801016f8:	8b 45 08             	mov    0x8(%ebp),%eax
801016fb:	8b 40 04             	mov    0x4(%eax),%eax
801016fe:	8d 50 01             	lea    0x1(%eax),%edx
80101701:	8b 45 08             	mov    0x8(%ebp),%eax
80101704:	89 50 04             	mov    %edx,0x4(%eax)
  release(&ftable.lock);
80101707:	c7 04 24 c0 fd 10 80 	movl   $0x8010fdc0,(%esp)
8010170e:	e8 06 44 00 00       	call   80105b19 <release>
  return f;
80101713:	8b 45 08             	mov    0x8(%ebp),%eax
}
80101716:	c9                   	leave  
80101717:	c3                   	ret    

80101718 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80101718:	55                   	push   %ebp
80101719:	89 e5                	mov    %esp,%ebp
8010171b:	83 ec 38             	sub    $0x38,%esp
  struct file ff;

  acquire(&ftable.lock);
8010171e:	c7 04 24 c0 fd 10 80 	movl   $0x8010fdc0,(%esp)
80101725:	e8 8d 43 00 00       	call   80105ab7 <acquire>
  if(f->ref < 1)
8010172a:	8b 45 08             	mov    0x8(%ebp),%eax
8010172d:	8b 40 04             	mov    0x4(%eax),%eax
80101730:	85 c0                	test   %eax,%eax
80101732:	7f 0c                	jg     80101740 <fileclose+0x28>
    panic("fileclose");
80101734:	c7 04 24 10 94 10 80 	movl   $0x80109410,(%esp)
8010173b:	e8 fd ed ff ff       	call   8010053d <panic>
  if(--f->ref > 0){
80101740:	8b 45 08             	mov    0x8(%ebp),%eax
80101743:	8b 40 04             	mov    0x4(%eax),%eax
80101746:	8d 50 ff             	lea    -0x1(%eax),%edx
80101749:	8b 45 08             	mov    0x8(%ebp),%eax
8010174c:	89 50 04             	mov    %edx,0x4(%eax)
8010174f:	8b 45 08             	mov    0x8(%ebp),%eax
80101752:	8b 40 04             	mov    0x4(%eax),%eax
80101755:	85 c0                	test   %eax,%eax
80101757:	7e 11                	jle    8010176a <fileclose+0x52>
    release(&ftable.lock);
80101759:	c7 04 24 c0 fd 10 80 	movl   $0x8010fdc0,(%esp)
80101760:	e8 b4 43 00 00       	call   80105b19 <release>
    return;
80101765:	e9 82 00 00 00       	jmp    801017ec <fileclose+0xd4>
  }
  ff = *f;
8010176a:	8b 45 08             	mov    0x8(%ebp),%eax
8010176d:	8b 10                	mov    (%eax),%edx
8010176f:	89 55 e0             	mov    %edx,-0x20(%ebp)
80101772:	8b 50 04             	mov    0x4(%eax),%edx
80101775:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80101778:	8b 50 08             	mov    0x8(%eax),%edx
8010177b:	89 55 e8             	mov    %edx,-0x18(%ebp)
8010177e:	8b 50 0c             	mov    0xc(%eax),%edx
80101781:	89 55 ec             	mov    %edx,-0x14(%ebp)
80101784:	8b 50 10             	mov    0x10(%eax),%edx
80101787:	89 55 f0             	mov    %edx,-0x10(%ebp)
8010178a:	8b 40 14             	mov    0x14(%eax),%eax
8010178d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  f->ref = 0;
80101790:	8b 45 08             	mov    0x8(%ebp),%eax
80101793:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
  f->type = FD_NONE;
8010179a:	8b 45 08             	mov    0x8(%ebp),%eax
8010179d:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  release(&ftable.lock);
801017a3:	c7 04 24 c0 fd 10 80 	movl   $0x8010fdc0,(%esp)
801017aa:	e8 6a 43 00 00       	call   80105b19 <release>
  
  if(ff.type == FD_PIPE)
801017af:	8b 45 e0             	mov    -0x20(%ebp),%eax
801017b2:	83 f8 01             	cmp    $0x1,%eax
801017b5:	75 18                	jne    801017cf <fileclose+0xb7>
    pipeclose(ff.pipe, ff.writable);
801017b7:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
801017bb:	0f be d0             	movsbl %al,%edx
801017be:	8b 45 ec             	mov    -0x14(%ebp),%eax
801017c1:	89 54 24 04          	mov    %edx,0x4(%esp)
801017c5:	89 04 24             	mov    %eax,(%esp)
801017c8:	e8 02 2d 00 00       	call   801044cf <pipeclose>
801017cd:	eb 1d                	jmp    801017ec <fileclose+0xd4>
  else if(ff.type == FD_INODE){
801017cf:	8b 45 e0             	mov    -0x20(%ebp),%eax
801017d2:	83 f8 02             	cmp    $0x2,%eax
801017d5:	75 15                	jne    801017ec <fileclose+0xd4>
    begin_trans();
801017d7:	e8 95 21 00 00       	call   80103971 <begin_trans>
    iput(ff.ip);
801017dc:	8b 45 f0             	mov    -0x10(%ebp),%eax
801017df:	89 04 24             	mov    %eax,(%esp)
801017e2:	e8 88 09 00 00       	call   8010216f <iput>
    commit_trans();
801017e7:	e8 ce 21 00 00       	call   801039ba <commit_trans>
  }
}
801017ec:	c9                   	leave  
801017ed:	c3                   	ret    

801017ee <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
801017ee:	55                   	push   %ebp
801017ef:	89 e5                	mov    %esp,%ebp
801017f1:	83 ec 18             	sub    $0x18,%esp
  if(f->type == FD_INODE){
801017f4:	8b 45 08             	mov    0x8(%ebp),%eax
801017f7:	8b 00                	mov    (%eax),%eax
801017f9:	83 f8 02             	cmp    $0x2,%eax
801017fc:	75 38                	jne    80101836 <filestat+0x48>
    ilock(f->ip);
801017fe:	8b 45 08             	mov    0x8(%ebp),%eax
80101801:	8b 40 10             	mov    0x10(%eax),%eax
80101804:	89 04 24             	mov    %eax,(%esp)
80101807:	e8 b0 07 00 00       	call   80101fbc <ilock>
    stati(f->ip, st);
8010180c:	8b 45 08             	mov    0x8(%ebp),%eax
8010180f:	8b 40 10             	mov    0x10(%eax),%eax
80101812:	8b 55 0c             	mov    0xc(%ebp),%edx
80101815:	89 54 24 04          	mov    %edx,0x4(%esp)
80101819:	89 04 24             	mov    %eax,(%esp)
8010181c:	e8 4c 0c 00 00       	call   8010246d <stati>
    iunlock(f->ip);
80101821:	8b 45 08             	mov    0x8(%ebp),%eax
80101824:	8b 40 10             	mov    0x10(%eax),%eax
80101827:	89 04 24             	mov    %eax,(%esp)
8010182a:	e8 db 08 00 00       	call   8010210a <iunlock>
    return 0;
8010182f:	b8 00 00 00 00       	mov    $0x0,%eax
80101834:	eb 05                	jmp    8010183b <filestat+0x4d>
  }
  return -1;
80101836:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010183b:	c9                   	leave  
8010183c:	c3                   	ret    

8010183d <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
8010183d:	55                   	push   %ebp
8010183e:	89 e5                	mov    %esp,%ebp
80101840:	83 ec 28             	sub    $0x28,%esp
  int r;

  if(f->readable == 0)
80101843:	8b 45 08             	mov    0x8(%ebp),%eax
80101846:	0f b6 40 08          	movzbl 0x8(%eax),%eax
8010184a:	84 c0                	test   %al,%al
8010184c:	75 0a                	jne    80101858 <fileread+0x1b>
    return -1;
8010184e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101853:	e9 9f 00 00 00       	jmp    801018f7 <fileread+0xba>
  if(f->type == FD_PIPE)
80101858:	8b 45 08             	mov    0x8(%ebp),%eax
8010185b:	8b 00                	mov    (%eax),%eax
8010185d:	83 f8 01             	cmp    $0x1,%eax
80101860:	75 1e                	jne    80101880 <fileread+0x43>
    return piperead(f->pipe, addr, n);
80101862:	8b 45 08             	mov    0x8(%ebp),%eax
80101865:	8b 40 0c             	mov    0xc(%eax),%eax
80101868:	8b 55 10             	mov    0x10(%ebp),%edx
8010186b:	89 54 24 08          	mov    %edx,0x8(%esp)
8010186f:	8b 55 0c             	mov    0xc(%ebp),%edx
80101872:	89 54 24 04          	mov    %edx,0x4(%esp)
80101876:	89 04 24             	mov    %eax,(%esp)
80101879:	e8 d3 2d 00 00       	call   80104651 <piperead>
8010187e:	eb 77                	jmp    801018f7 <fileread+0xba>
  if(f->type == FD_INODE){
80101880:	8b 45 08             	mov    0x8(%ebp),%eax
80101883:	8b 00                	mov    (%eax),%eax
80101885:	83 f8 02             	cmp    $0x2,%eax
80101888:	75 61                	jne    801018eb <fileread+0xae>
    ilock(f->ip);
8010188a:	8b 45 08             	mov    0x8(%ebp),%eax
8010188d:	8b 40 10             	mov    0x10(%eax),%eax
80101890:	89 04 24             	mov    %eax,(%esp)
80101893:	e8 24 07 00 00       	call   80101fbc <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
80101898:	8b 4d 10             	mov    0x10(%ebp),%ecx
8010189b:	8b 45 08             	mov    0x8(%ebp),%eax
8010189e:	8b 50 14             	mov    0x14(%eax),%edx
801018a1:	8b 45 08             	mov    0x8(%ebp),%eax
801018a4:	8b 40 10             	mov    0x10(%eax),%eax
801018a7:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
801018ab:	89 54 24 08          	mov    %edx,0x8(%esp)
801018af:	8b 55 0c             	mov    0xc(%ebp),%edx
801018b2:	89 54 24 04          	mov    %edx,0x4(%esp)
801018b6:	89 04 24             	mov    %eax,(%esp)
801018b9:	e8 f4 0b 00 00       	call   801024b2 <readi>
801018be:	89 45 f4             	mov    %eax,-0xc(%ebp)
801018c1:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801018c5:	7e 11                	jle    801018d8 <fileread+0x9b>
      f->off += r;
801018c7:	8b 45 08             	mov    0x8(%ebp),%eax
801018ca:	8b 50 14             	mov    0x14(%eax),%edx
801018cd:	8b 45 f4             	mov    -0xc(%ebp),%eax
801018d0:	01 c2                	add    %eax,%edx
801018d2:	8b 45 08             	mov    0x8(%ebp),%eax
801018d5:	89 50 14             	mov    %edx,0x14(%eax)
    iunlock(f->ip);
801018d8:	8b 45 08             	mov    0x8(%ebp),%eax
801018db:	8b 40 10             	mov    0x10(%eax),%eax
801018de:	89 04 24             	mov    %eax,(%esp)
801018e1:	e8 24 08 00 00       	call   8010210a <iunlock>
    return r;
801018e6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801018e9:	eb 0c                	jmp    801018f7 <fileread+0xba>
  }
  panic("fileread");
801018eb:	c7 04 24 1a 94 10 80 	movl   $0x8010941a,(%esp)
801018f2:	e8 46 ec ff ff       	call   8010053d <panic>
}
801018f7:	c9                   	leave  
801018f8:	c3                   	ret    

801018f9 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
801018f9:	55                   	push   %ebp
801018fa:	89 e5                	mov    %esp,%ebp
801018fc:	53                   	push   %ebx
801018fd:	83 ec 24             	sub    $0x24,%esp
  int r;

  if(f->writable == 0)
80101900:	8b 45 08             	mov    0x8(%ebp),%eax
80101903:	0f b6 40 09          	movzbl 0x9(%eax),%eax
80101907:	84 c0                	test   %al,%al
80101909:	75 0a                	jne    80101915 <filewrite+0x1c>
    return -1;
8010190b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101910:	e9 23 01 00 00       	jmp    80101a38 <filewrite+0x13f>
  if(f->type == FD_PIPE)
80101915:	8b 45 08             	mov    0x8(%ebp),%eax
80101918:	8b 00                	mov    (%eax),%eax
8010191a:	83 f8 01             	cmp    $0x1,%eax
8010191d:	75 21                	jne    80101940 <filewrite+0x47>
    return pipewrite(f->pipe, addr, n);
8010191f:	8b 45 08             	mov    0x8(%ebp),%eax
80101922:	8b 40 0c             	mov    0xc(%eax),%eax
80101925:	8b 55 10             	mov    0x10(%ebp),%edx
80101928:	89 54 24 08          	mov    %edx,0x8(%esp)
8010192c:	8b 55 0c             	mov    0xc(%ebp),%edx
8010192f:	89 54 24 04          	mov    %edx,0x4(%esp)
80101933:	89 04 24             	mov    %eax,(%esp)
80101936:	e8 26 2c 00 00       	call   80104561 <pipewrite>
8010193b:	e9 f8 00 00 00       	jmp    80101a38 <filewrite+0x13f>
  if(f->type == FD_INODE){
80101940:	8b 45 08             	mov    0x8(%ebp),%eax
80101943:	8b 00                	mov    (%eax),%eax
80101945:	83 f8 02             	cmp    $0x2,%eax
80101948:	0f 85 de 00 00 00    	jne    80101a2c <filewrite+0x133>
    // the maximum log transaction size, including
    // i-node, indirect block, allocation blocks,
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((LOGSIZE-1-1-2) / 2) * 512;
8010194e:	c7 45 ec 00 06 00 00 	movl   $0x600,-0x14(%ebp)
    int i = 0;
80101955:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    while(i < n){
8010195c:	e9 a8 00 00 00       	jmp    80101a09 <filewrite+0x110>
      int n1 = n - i;
80101961:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101964:	8b 55 10             	mov    0x10(%ebp),%edx
80101967:	89 d1                	mov    %edx,%ecx
80101969:	29 c1                	sub    %eax,%ecx
8010196b:	89 c8                	mov    %ecx,%eax
8010196d:	89 45 f0             	mov    %eax,-0x10(%ebp)
      if(n1 > max)
80101970:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101973:	3b 45 ec             	cmp    -0x14(%ebp),%eax
80101976:	7e 06                	jle    8010197e <filewrite+0x85>
        n1 = max;
80101978:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010197b:	89 45 f0             	mov    %eax,-0x10(%ebp)

      begin_trans();
8010197e:	e8 ee 1f 00 00       	call   80103971 <begin_trans>
      ilock(f->ip);
80101983:	8b 45 08             	mov    0x8(%ebp),%eax
80101986:	8b 40 10             	mov    0x10(%eax),%eax
80101989:	89 04 24             	mov    %eax,(%esp)
8010198c:	e8 2b 06 00 00       	call   80101fbc <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
80101991:	8b 5d f0             	mov    -0x10(%ebp),%ebx
80101994:	8b 45 08             	mov    0x8(%ebp),%eax
80101997:	8b 48 14             	mov    0x14(%eax),%ecx
8010199a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010199d:	89 c2                	mov    %eax,%edx
8010199f:	03 55 0c             	add    0xc(%ebp),%edx
801019a2:	8b 45 08             	mov    0x8(%ebp),%eax
801019a5:	8b 40 10             	mov    0x10(%eax),%eax
801019a8:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
801019ac:	89 4c 24 08          	mov    %ecx,0x8(%esp)
801019b0:	89 54 24 04          	mov    %edx,0x4(%esp)
801019b4:	89 04 24             	mov    %eax,(%esp)
801019b7:	e8 61 0c 00 00       	call   8010261d <writei>
801019bc:	89 45 e8             	mov    %eax,-0x18(%ebp)
801019bf:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
801019c3:	7e 11                	jle    801019d6 <filewrite+0xdd>
        f->off += r;
801019c5:	8b 45 08             	mov    0x8(%ebp),%eax
801019c8:	8b 50 14             	mov    0x14(%eax),%edx
801019cb:	8b 45 e8             	mov    -0x18(%ebp),%eax
801019ce:	01 c2                	add    %eax,%edx
801019d0:	8b 45 08             	mov    0x8(%ebp),%eax
801019d3:	89 50 14             	mov    %edx,0x14(%eax)
      iunlock(f->ip);
801019d6:	8b 45 08             	mov    0x8(%ebp),%eax
801019d9:	8b 40 10             	mov    0x10(%eax),%eax
801019dc:	89 04 24             	mov    %eax,(%esp)
801019df:	e8 26 07 00 00       	call   8010210a <iunlock>
      commit_trans();
801019e4:	e8 d1 1f 00 00       	call   801039ba <commit_trans>

      if(r < 0)
801019e9:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
801019ed:	78 28                	js     80101a17 <filewrite+0x11e>
        break;
      if(r != n1)
801019ef:	8b 45 e8             	mov    -0x18(%ebp),%eax
801019f2:	3b 45 f0             	cmp    -0x10(%ebp),%eax
801019f5:	74 0c                	je     80101a03 <filewrite+0x10a>
        panic("short filewrite");
801019f7:	c7 04 24 23 94 10 80 	movl   $0x80109423,(%esp)
801019fe:	e8 3a eb ff ff       	call   8010053d <panic>
      i += r;
80101a03:	8b 45 e8             	mov    -0x18(%ebp),%eax
80101a06:	01 45 f4             	add    %eax,-0xc(%ebp)
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((LOGSIZE-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
80101a09:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101a0c:	3b 45 10             	cmp    0x10(%ebp),%eax
80101a0f:	0f 8c 4c ff ff ff    	jl     80101961 <filewrite+0x68>
80101a15:	eb 01                	jmp    80101a18 <filewrite+0x11f>
        f->off += r;
      iunlock(f->ip);
      commit_trans();

      if(r < 0)
        break;
80101a17:	90                   	nop
      if(r != n1)
        panic("short filewrite");
      i += r;
    }
    return i == n ? n : -1;
80101a18:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101a1b:	3b 45 10             	cmp    0x10(%ebp),%eax
80101a1e:	75 05                	jne    80101a25 <filewrite+0x12c>
80101a20:	8b 45 10             	mov    0x10(%ebp),%eax
80101a23:	eb 05                	jmp    80101a2a <filewrite+0x131>
80101a25:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101a2a:	eb 0c                	jmp    80101a38 <filewrite+0x13f>
  }
  panic("filewrite");
80101a2c:	c7 04 24 33 94 10 80 	movl   $0x80109433,(%esp)
80101a33:	e8 05 eb ff ff       	call   8010053d <panic>
}
80101a38:	83 c4 24             	add    $0x24,%esp
80101a3b:	5b                   	pop    %ebx
80101a3c:	5d                   	pop    %ebp
80101a3d:	c3                   	ret    
	...

80101a40 <readsb>:
static void itrunc(struct inode*);

// Read the super block.
void
readsb(int dev, struct superblock *sb)
{
80101a40:	55                   	push   %ebp
80101a41:	89 e5                	mov    %esp,%ebp
80101a43:	83 ec 28             	sub    $0x28,%esp
  struct buf *bp;
  
  bp = bread(dev, 1);
80101a46:	8b 45 08             	mov    0x8(%ebp),%eax
80101a49:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
80101a50:	00 
80101a51:	89 04 24             	mov    %eax,(%esp)
80101a54:	e8 4d e7 ff ff       	call   801001a6 <bread>
80101a59:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memmove(sb, bp->data, sizeof(*sb));
80101a5c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101a5f:	83 c0 18             	add    $0x18,%eax
80101a62:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
80101a69:	00 
80101a6a:	89 44 24 04          	mov    %eax,0x4(%esp)
80101a6e:	8b 45 0c             	mov    0xc(%ebp),%eax
80101a71:	89 04 24             	mov    %eax,(%esp)
80101a74:	e8 60 43 00 00       	call   80105dd9 <memmove>
  brelse(bp);
80101a79:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101a7c:	89 04 24             	mov    %eax,(%esp)
80101a7f:	e8 93 e7 ff ff       	call   80100217 <brelse>
}
80101a84:	c9                   	leave  
80101a85:	c3                   	ret    

80101a86 <bzero>:

// Zero a block.
static void
bzero(int dev, int bno)
{
80101a86:	55                   	push   %ebp
80101a87:	89 e5                	mov    %esp,%ebp
80101a89:	83 ec 28             	sub    $0x28,%esp
  struct buf *bp;
  
  bp = bread(dev, bno);
80101a8c:	8b 55 0c             	mov    0xc(%ebp),%edx
80101a8f:	8b 45 08             	mov    0x8(%ebp),%eax
80101a92:	89 54 24 04          	mov    %edx,0x4(%esp)
80101a96:	89 04 24             	mov    %eax,(%esp)
80101a99:	e8 08 e7 ff ff       	call   801001a6 <bread>
80101a9e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(bp->data, 0, BSIZE);
80101aa1:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101aa4:	83 c0 18             	add    $0x18,%eax
80101aa7:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
80101aae:	00 
80101aaf:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80101ab6:	00 
80101ab7:	89 04 24             	mov    %eax,(%esp)
80101aba:	e8 47 42 00 00       	call   80105d06 <memset>
  log_write(bp);
80101abf:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101ac2:	89 04 24             	mov    %eax,(%esp)
80101ac5:	e8 48 1f 00 00       	call   80103a12 <log_write>
  brelse(bp);
80101aca:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101acd:	89 04 24             	mov    %eax,(%esp)
80101ad0:	e8 42 e7 ff ff       	call   80100217 <brelse>
}
80101ad5:	c9                   	leave  
80101ad6:	c3                   	ret    

80101ad7 <balloc>:
// Blocks. 

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
80101ad7:	55                   	push   %ebp
80101ad8:	89 e5                	mov    %esp,%ebp
80101ada:	53                   	push   %ebx
80101adb:	83 ec 34             	sub    $0x34,%esp
  int b, bi, m;
  struct buf *bp;
  struct superblock sb;

  bp = 0;
80101ade:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  readsb(dev, &sb);
80101ae5:	8b 45 08             	mov    0x8(%ebp),%eax
80101ae8:	8d 55 d8             	lea    -0x28(%ebp),%edx
80101aeb:	89 54 24 04          	mov    %edx,0x4(%esp)
80101aef:	89 04 24             	mov    %eax,(%esp)
80101af2:	e8 49 ff ff ff       	call   80101a40 <readsb>
  for(b = 0; b < sb.size; b += BPB){
80101af7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80101afe:	e9 11 01 00 00       	jmp    80101c14 <balloc+0x13d>
    bp = bread(dev, BBLOCK(b, sb.ninodes));
80101b03:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101b06:	8d 90 ff 0f 00 00    	lea    0xfff(%eax),%edx
80101b0c:	85 c0                	test   %eax,%eax
80101b0e:	0f 48 c2             	cmovs  %edx,%eax
80101b11:	c1 f8 0c             	sar    $0xc,%eax
80101b14:	8b 55 e0             	mov    -0x20(%ebp),%edx
80101b17:	c1 ea 03             	shr    $0x3,%edx
80101b1a:	01 d0                	add    %edx,%eax
80101b1c:	83 c0 03             	add    $0x3,%eax
80101b1f:	89 44 24 04          	mov    %eax,0x4(%esp)
80101b23:	8b 45 08             	mov    0x8(%ebp),%eax
80101b26:	89 04 24             	mov    %eax,(%esp)
80101b29:	e8 78 e6 ff ff       	call   801001a6 <bread>
80101b2e:	89 45 ec             	mov    %eax,-0x14(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
80101b31:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
80101b38:	e9 a7 00 00 00       	jmp    80101be4 <balloc+0x10d>
      m = 1 << (bi % 8);
80101b3d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101b40:	89 c2                	mov    %eax,%edx
80101b42:	c1 fa 1f             	sar    $0x1f,%edx
80101b45:	c1 ea 1d             	shr    $0x1d,%edx
80101b48:	01 d0                	add    %edx,%eax
80101b4a:	83 e0 07             	and    $0x7,%eax
80101b4d:	29 d0                	sub    %edx,%eax
80101b4f:	ba 01 00 00 00       	mov    $0x1,%edx
80101b54:	89 d3                	mov    %edx,%ebx
80101b56:	89 c1                	mov    %eax,%ecx
80101b58:	d3 e3                	shl    %cl,%ebx
80101b5a:	89 d8                	mov    %ebx,%eax
80101b5c:	89 45 e8             	mov    %eax,-0x18(%ebp)
      if((bp->data[bi/8] & m) == 0){  // Is block free?
80101b5f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101b62:	8d 50 07             	lea    0x7(%eax),%edx
80101b65:	85 c0                	test   %eax,%eax
80101b67:	0f 48 c2             	cmovs  %edx,%eax
80101b6a:	c1 f8 03             	sar    $0x3,%eax
80101b6d:	8b 55 ec             	mov    -0x14(%ebp),%edx
80101b70:	0f b6 44 02 18       	movzbl 0x18(%edx,%eax,1),%eax
80101b75:	0f b6 c0             	movzbl %al,%eax
80101b78:	23 45 e8             	and    -0x18(%ebp),%eax
80101b7b:	85 c0                	test   %eax,%eax
80101b7d:	75 61                	jne    80101be0 <balloc+0x109>
        bp->data[bi/8] |= m;  // Mark block in use.
80101b7f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101b82:	8d 50 07             	lea    0x7(%eax),%edx
80101b85:	85 c0                	test   %eax,%eax
80101b87:	0f 48 c2             	cmovs  %edx,%eax
80101b8a:	c1 f8 03             	sar    $0x3,%eax
80101b8d:	8b 55 ec             	mov    -0x14(%ebp),%edx
80101b90:	0f b6 54 02 18       	movzbl 0x18(%edx,%eax,1),%edx
80101b95:	89 d1                	mov    %edx,%ecx
80101b97:	8b 55 e8             	mov    -0x18(%ebp),%edx
80101b9a:	09 ca                	or     %ecx,%edx
80101b9c:	89 d1                	mov    %edx,%ecx
80101b9e:	8b 55 ec             	mov    -0x14(%ebp),%edx
80101ba1:	88 4c 02 18          	mov    %cl,0x18(%edx,%eax,1)
        log_write(bp);
80101ba5:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101ba8:	89 04 24             	mov    %eax,(%esp)
80101bab:	e8 62 1e 00 00       	call   80103a12 <log_write>
        brelse(bp);
80101bb0:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101bb3:	89 04 24             	mov    %eax,(%esp)
80101bb6:	e8 5c e6 ff ff       	call   80100217 <brelse>
        bzero(dev, b + bi);
80101bbb:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101bbe:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101bc1:	01 c2                	add    %eax,%edx
80101bc3:	8b 45 08             	mov    0x8(%ebp),%eax
80101bc6:	89 54 24 04          	mov    %edx,0x4(%esp)
80101bca:	89 04 24             	mov    %eax,(%esp)
80101bcd:	e8 b4 fe ff ff       	call   80101a86 <bzero>
        return b + bi;
80101bd2:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101bd5:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101bd8:	01 d0                	add    %edx,%eax
      }
    }
    brelse(bp);
  }
  panic("balloc: out of blocks");
}
80101bda:	83 c4 34             	add    $0x34,%esp
80101bdd:	5b                   	pop    %ebx
80101bde:	5d                   	pop    %ebp
80101bdf:	c3                   	ret    

  bp = 0;
  readsb(dev, &sb);
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb.ninodes));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
80101be0:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
80101be4:	81 7d f0 ff 0f 00 00 	cmpl   $0xfff,-0x10(%ebp)
80101beb:	7f 15                	jg     80101c02 <balloc+0x12b>
80101bed:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101bf0:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101bf3:	01 d0                	add    %edx,%eax
80101bf5:	89 c2                	mov    %eax,%edx
80101bf7:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101bfa:	39 c2                	cmp    %eax,%edx
80101bfc:	0f 82 3b ff ff ff    	jb     80101b3d <balloc+0x66>
        brelse(bp);
        bzero(dev, b + bi);
        return b + bi;
      }
    }
    brelse(bp);
80101c02:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101c05:	89 04 24             	mov    %eax,(%esp)
80101c08:	e8 0a e6 ff ff       	call   80100217 <brelse>
  struct buf *bp;
  struct superblock sb;

  bp = 0;
  readsb(dev, &sb);
  for(b = 0; b < sb.size; b += BPB){
80101c0d:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
80101c14:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101c17:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101c1a:	39 c2                	cmp    %eax,%edx
80101c1c:	0f 82 e1 fe ff ff    	jb     80101b03 <balloc+0x2c>
        return b + bi;
      }
    }
    brelse(bp);
  }
  panic("balloc: out of blocks");
80101c22:	c7 04 24 3d 94 10 80 	movl   $0x8010943d,(%esp)
80101c29:	e8 0f e9 ff ff       	call   8010053d <panic>

80101c2e <bfree>:
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
80101c2e:	55                   	push   %ebp
80101c2f:	89 e5                	mov    %esp,%ebp
80101c31:	53                   	push   %ebx
80101c32:	83 ec 34             	sub    $0x34,%esp
  struct buf *bp;
  struct superblock sb;
  int bi, m;

  readsb(dev, &sb);
80101c35:	8d 45 dc             	lea    -0x24(%ebp),%eax
80101c38:	89 44 24 04          	mov    %eax,0x4(%esp)
80101c3c:	8b 45 08             	mov    0x8(%ebp),%eax
80101c3f:	89 04 24             	mov    %eax,(%esp)
80101c42:	e8 f9 fd ff ff       	call   80101a40 <readsb>
  bp = bread(dev, BBLOCK(b, sb.ninodes));
80101c47:	8b 45 0c             	mov    0xc(%ebp),%eax
80101c4a:	89 c2                	mov    %eax,%edx
80101c4c:	c1 ea 0c             	shr    $0xc,%edx
80101c4f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101c52:	c1 e8 03             	shr    $0x3,%eax
80101c55:	01 d0                	add    %edx,%eax
80101c57:	8d 50 03             	lea    0x3(%eax),%edx
80101c5a:	8b 45 08             	mov    0x8(%ebp),%eax
80101c5d:	89 54 24 04          	mov    %edx,0x4(%esp)
80101c61:	89 04 24             	mov    %eax,(%esp)
80101c64:	e8 3d e5 ff ff       	call   801001a6 <bread>
80101c69:	89 45 f4             	mov    %eax,-0xc(%ebp)
  bi = b % BPB;
80101c6c:	8b 45 0c             	mov    0xc(%ebp),%eax
80101c6f:	25 ff 0f 00 00       	and    $0xfff,%eax
80101c74:	89 45 f0             	mov    %eax,-0x10(%ebp)
  m = 1 << (bi % 8);
80101c77:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101c7a:	89 c2                	mov    %eax,%edx
80101c7c:	c1 fa 1f             	sar    $0x1f,%edx
80101c7f:	c1 ea 1d             	shr    $0x1d,%edx
80101c82:	01 d0                	add    %edx,%eax
80101c84:	83 e0 07             	and    $0x7,%eax
80101c87:	29 d0                	sub    %edx,%eax
80101c89:	ba 01 00 00 00       	mov    $0x1,%edx
80101c8e:	89 d3                	mov    %edx,%ebx
80101c90:	89 c1                	mov    %eax,%ecx
80101c92:	d3 e3                	shl    %cl,%ebx
80101c94:	89 d8                	mov    %ebx,%eax
80101c96:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((bp->data[bi/8] & m) == 0)
80101c99:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101c9c:	8d 50 07             	lea    0x7(%eax),%edx
80101c9f:	85 c0                	test   %eax,%eax
80101ca1:	0f 48 c2             	cmovs  %edx,%eax
80101ca4:	c1 f8 03             	sar    $0x3,%eax
80101ca7:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101caa:	0f b6 44 02 18       	movzbl 0x18(%edx,%eax,1),%eax
80101caf:	0f b6 c0             	movzbl %al,%eax
80101cb2:	23 45 ec             	and    -0x14(%ebp),%eax
80101cb5:	85 c0                	test   %eax,%eax
80101cb7:	75 0c                	jne    80101cc5 <bfree+0x97>
    panic("freeing free block");
80101cb9:	c7 04 24 53 94 10 80 	movl   $0x80109453,(%esp)
80101cc0:	e8 78 e8 ff ff       	call   8010053d <panic>
  bp->data[bi/8] &= ~m;
80101cc5:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101cc8:	8d 50 07             	lea    0x7(%eax),%edx
80101ccb:	85 c0                	test   %eax,%eax
80101ccd:	0f 48 c2             	cmovs  %edx,%eax
80101cd0:	c1 f8 03             	sar    $0x3,%eax
80101cd3:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101cd6:	0f b6 54 02 18       	movzbl 0x18(%edx,%eax,1),%edx
80101cdb:	8b 4d ec             	mov    -0x14(%ebp),%ecx
80101cde:	f7 d1                	not    %ecx
80101ce0:	21 ca                	and    %ecx,%edx
80101ce2:	89 d1                	mov    %edx,%ecx
80101ce4:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101ce7:	88 4c 02 18          	mov    %cl,0x18(%edx,%eax,1)
  log_write(bp);
80101ceb:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101cee:	89 04 24             	mov    %eax,(%esp)
80101cf1:	e8 1c 1d 00 00       	call   80103a12 <log_write>
  brelse(bp);
80101cf6:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101cf9:	89 04 24             	mov    %eax,(%esp)
80101cfc:	e8 16 e5 ff ff       	call   80100217 <brelse>
}
80101d01:	83 c4 34             	add    $0x34,%esp
80101d04:	5b                   	pop    %ebx
80101d05:	5d                   	pop    %ebp
80101d06:	c3                   	ret    

80101d07 <iinit>:
  struct inode inode[NINODE];
} icache;

void
iinit(void)
{
80101d07:	55                   	push   %ebp
80101d08:	89 e5                	mov    %esp,%ebp
80101d0a:	83 ec 18             	sub    $0x18,%esp
  initlock(&icache.lock, "icache");
80101d0d:	c7 44 24 04 66 94 10 	movl   $0x80109466,0x4(%esp)
80101d14:	80 
80101d15:	c7 04 24 c0 07 11 80 	movl   $0x801107c0,(%esp)
80101d1c:	e8 75 3d 00 00       	call   80105a96 <initlock>
}
80101d21:	c9                   	leave  
80101d22:	c3                   	ret    

80101d23 <ialloc>:
//PAGEBREAK!
// Allocate a new inode with the given type on device dev.
// A free inode has a type of zero.
struct inode*
ialloc(uint dev, short type)
{
80101d23:	55                   	push   %ebp
80101d24:	89 e5                	mov    %esp,%ebp
80101d26:	83 ec 48             	sub    $0x48,%esp
80101d29:	8b 45 0c             	mov    0xc(%ebp),%eax
80101d2c:	66 89 45 d4          	mov    %ax,-0x2c(%ebp)
  int inum;
  struct buf *bp;
  struct dinode *dip;
  struct superblock sb;

  readsb(dev, &sb);
80101d30:	8b 45 08             	mov    0x8(%ebp),%eax
80101d33:	8d 55 dc             	lea    -0x24(%ebp),%edx
80101d36:	89 54 24 04          	mov    %edx,0x4(%esp)
80101d3a:	89 04 24             	mov    %eax,(%esp)
80101d3d:	e8 fe fc ff ff       	call   80101a40 <readsb>

  for(inum = 1; inum < sb.ninodes; inum++){
80101d42:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
80101d49:	e9 98 00 00 00       	jmp    80101de6 <ialloc+0xc3>
    bp = bread(dev, IBLOCK(inum));
80101d4e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101d51:	c1 e8 03             	shr    $0x3,%eax
80101d54:	83 c0 02             	add    $0x2,%eax
80101d57:	89 44 24 04          	mov    %eax,0x4(%esp)
80101d5b:	8b 45 08             	mov    0x8(%ebp),%eax
80101d5e:	89 04 24             	mov    %eax,(%esp)
80101d61:	e8 40 e4 ff ff       	call   801001a6 <bread>
80101d66:	89 45 f0             	mov    %eax,-0x10(%ebp)
    dip = (struct dinode*)bp->data + inum%IPB;
80101d69:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101d6c:	8d 50 18             	lea    0x18(%eax),%edx
80101d6f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101d72:	83 e0 07             	and    $0x7,%eax
80101d75:	c1 e0 06             	shl    $0x6,%eax
80101d78:	01 d0                	add    %edx,%eax
80101d7a:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(dip->type == 0){  // a free inode
80101d7d:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101d80:	0f b7 00             	movzwl (%eax),%eax
80101d83:	66 85 c0             	test   %ax,%ax
80101d86:	75 4f                	jne    80101dd7 <ialloc+0xb4>
      memset(dip, 0, sizeof(*dip));
80101d88:	c7 44 24 08 40 00 00 	movl   $0x40,0x8(%esp)
80101d8f:	00 
80101d90:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80101d97:	00 
80101d98:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101d9b:	89 04 24             	mov    %eax,(%esp)
80101d9e:	e8 63 3f 00 00       	call   80105d06 <memset>
      dip->type = type;
80101da3:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101da6:	0f b7 55 d4          	movzwl -0x2c(%ebp),%edx
80101daa:	66 89 10             	mov    %dx,(%eax)
      log_write(bp);   // mark it allocated on the disk
80101dad:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101db0:	89 04 24             	mov    %eax,(%esp)
80101db3:	e8 5a 1c 00 00       	call   80103a12 <log_write>
      brelse(bp);
80101db8:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101dbb:	89 04 24             	mov    %eax,(%esp)
80101dbe:	e8 54 e4 ff ff       	call   80100217 <brelse>
      return iget(dev, inum);
80101dc3:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101dc6:	89 44 24 04          	mov    %eax,0x4(%esp)
80101dca:	8b 45 08             	mov    0x8(%ebp),%eax
80101dcd:	89 04 24             	mov    %eax,(%esp)
80101dd0:	e8 e3 00 00 00       	call   80101eb8 <iget>
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
}
80101dd5:	c9                   	leave  
80101dd6:	c3                   	ret    
      dip->type = type;
      log_write(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
    }
    brelse(bp);
80101dd7:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101dda:	89 04 24             	mov    %eax,(%esp)
80101ddd:	e8 35 e4 ff ff       	call   80100217 <brelse>
  struct dinode *dip;
  struct superblock sb;

  readsb(dev, &sb);

  for(inum = 1; inum < sb.ninodes; inum++){
80101de2:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80101de6:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101de9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101dec:	39 c2                	cmp    %eax,%edx
80101dee:	0f 82 5a ff ff ff    	jb     80101d4e <ialloc+0x2b>
      brelse(bp);
      return iget(dev, inum);
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
80101df4:	c7 04 24 6d 94 10 80 	movl   $0x8010946d,(%esp)
80101dfb:	e8 3d e7 ff ff       	call   8010053d <panic>

80101e00 <iupdate>:
}

// Copy a modified in-memory inode to disk.
void
iupdate(struct inode *ip)
{
80101e00:	55                   	push   %ebp
80101e01:	89 e5                	mov    %esp,%ebp
80101e03:	83 ec 28             	sub    $0x28,%esp
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum));
80101e06:	8b 45 08             	mov    0x8(%ebp),%eax
80101e09:	8b 40 04             	mov    0x4(%eax),%eax
80101e0c:	c1 e8 03             	shr    $0x3,%eax
80101e0f:	8d 50 02             	lea    0x2(%eax),%edx
80101e12:	8b 45 08             	mov    0x8(%ebp),%eax
80101e15:	8b 00                	mov    (%eax),%eax
80101e17:	89 54 24 04          	mov    %edx,0x4(%esp)
80101e1b:	89 04 24             	mov    %eax,(%esp)
80101e1e:	e8 83 e3 ff ff       	call   801001a6 <bread>
80101e23:	89 45 f4             	mov    %eax,-0xc(%ebp)
  dip = (struct dinode*)bp->data + ip->inum%IPB;
80101e26:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101e29:	8d 50 18             	lea    0x18(%eax),%edx
80101e2c:	8b 45 08             	mov    0x8(%ebp),%eax
80101e2f:	8b 40 04             	mov    0x4(%eax),%eax
80101e32:	83 e0 07             	and    $0x7,%eax
80101e35:	c1 e0 06             	shl    $0x6,%eax
80101e38:	01 d0                	add    %edx,%eax
80101e3a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  dip->type = ip->type;
80101e3d:	8b 45 08             	mov    0x8(%ebp),%eax
80101e40:	0f b7 50 10          	movzwl 0x10(%eax),%edx
80101e44:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101e47:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
80101e4a:	8b 45 08             	mov    0x8(%ebp),%eax
80101e4d:	0f b7 50 12          	movzwl 0x12(%eax),%edx
80101e51:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101e54:	66 89 50 02          	mov    %dx,0x2(%eax)
  dip->minor = ip->minor;
80101e58:	8b 45 08             	mov    0x8(%ebp),%eax
80101e5b:	0f b7 50 14          	movzwl 0x14(%eax),%edx
80101e5f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101e62:	66 89 50 04          	mov    %dx,0x4(%eax)
  dip->nlink = ip->nlink;
80101e66:	8b 45 08             	mov    0x8(%ebp),%eax
80101e69:	0f b7 50 16          	movzwl 0x16(%eax),%edx
80101e6d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101e70:	66 89 50 06          	mov    %dx,0x6(%eax)
  dip->size = ip->size;
80101e74:	8b 45 08             	mov    0x8(%ebp),%eax
80101e77:	8b 50 18             	mov    0x18(%eax),%edx
80101e7a:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101e7d:	89 50 08             	mov    %edx,0x8(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101e80:	8b 45 08             	mov    0x8(%ebp),%eax
80101e83:	8d 50 1c             	lea    0x1c(%eax),%edx
80101e86:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101e89:	83 c0 0c             	add    $0xc,%eax
80101e8c:	c7 44 24 08 34 00 00 	movl   $0x34,0x8(%esp)
80101e93:	00 
80101e94:	89 54 24 04          	mov    %edx,0x4(%esp)
80101e98:	89 04 24             	mov    %eax,(%esp)
80101e9b:	e8 39 3f 00 00       	call   80105dd9 <memmove>
  log_write(bp);
80101ea0:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101ea3:	89 04 24             	mov    %eax,(%esp)
80101ea6:	e8 67 1b 00 00       	call   80103a12 <log_write>
  brelse(bp);
80101eab:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101eae:	89 04 24             	mov    %eax,(%esp)
80101eb1:	e8 61 e3 ff ff       	call   80100217 <brelse>
}
80101eb6:	c9                   	leave  
80101eb7:	c3                   	ret    

80101eb8 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
80101eb8:	55                   	push   %ebp
80101eb9:	89 e5                	mov    %esp,%ebp
80101ebb:	83 ec 28             	sub    $0x28,%esp
  struct inode *ip, *empty;

  acquire(&icache.lock);
80101ebe:	c7 04 24 c0 07 11 80 	movl   $0x801107c0,(%esp)
80101ec5:	e8 ed 3b 00 00       	call   80105ab7 <acquire>

  // Is the inode already cached?
  empty = 0;
80101eca:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101ed1:	c7 45 f4 f4 07 11 80 	movl   $0x801107f4,-0xc(%ebp)
80101ed8:	eb 59                	jmp    80101f33 <iget+0x7b>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101eda:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101edd:	8b 40 08             	mov    0x8(%eax),%eax
80101ee0:	85 c0                	test   %eax,%eax
80101ee2:	7e 35                	jle    80101f19 <iget+0x61>
80101ee4:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101ee7:	8b 00                	mov    (%eax),%eax
80101ee9:	3b 45 08             	cmp    0x8(%ebp),%eax
80101eec:	75 2b                	jne    80101f19 <iget+0x61>
80101eee:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101ef1:	8b 40 04             	mov    0x4(%eax),%eax
80101ef4:	3b 45 0c             	cmp    0xc(%ebp),%eax
80101ef7:	75 20                	jne    80101f19 <iget+0x61>
      ip->ref++;
80101ef9:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101efc:	8b 40 08             	mov    0x8(%eax),%eax
80101eff:	8d 50 01             	lea    0x1(%eax),%edx
80101f02:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101f05:	89 50 08             	mov    %edx,0x8(%eax)
      release(&icache.lock);
80101f08:	c7 04 24 c0 07 11 80 	movl   $0x801107c0,(%esp)
80101f0f:	e8 05 3c 00 00       	call   80105b19 <release>
      return ip;
80101f14:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101f17:	eb 6f                	jmp    80101f88 <iget+0xd0>
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
80101f19:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80101f1d:	75 10                	jne    80101f2f <iget+0x77>
80101f1f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101f22:	8b 40 08             	mov    0x8(%eax),%eax
80101f25:	85 c0                	test   %eax,%eax
80101f27:	75 06                	jne    80101f2f <iget+0x77>
      empty = ip;
80101f29:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101f2c:	89 45 f0             	mov    %eax,-0x10(%ebp)

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101f2f:	83 45 f4 50          	addl   $0x50,-0xc(%ebp)
80101f33:	81 7d f4 94 17 11 80 	cmpl   $0x80111794,-0xc(%ebp)
80101f3a:	72 9e                	jb     80101eda <iget+0x22>
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
80101f3c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80101f40:	75 0c                	jne    80101f4e <iget+0x96>
    panic("iget: no inodes");
80101f42:	c7 04 24 7f 94 10 80 	movl   $0x8010947f,(%esp)
80101f49:	e8 ef e5 ff ff       	call   8010053d <panic>

  ip = empty;
80101f4e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101f51:	89 45 f4             	mov    %eax,-0xc(%ebp)
  ip->dev = dev;
80101f54:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101f57:	8b 55 08             	mov    0x8(%ebp),%edx
80101f5a:	89 10                	mov    %edx,(%eax)
  ip->inum = inum;
80101f5c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101f5f:	8b 55 0c             	mov    0xc(%ebp),%edx
80101f62:	89 50 04             	mov    %edx,0x4(%eax)
  ip->ref = 1;
80101f65:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101f68:	c7 40 08 01 00 00 00 	movl   $0x1,0x8(%eax)
  ip->flags = 0;
80101f6f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101f72:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
  release(&icache.lock);
80101f79:	c7 04 24 c0 07 11 80 	movl   $0x801107c0,(%esp)
80101f80:	e8 94 3b 00 00       	call   80105b19 <release>

  return ip;
80101f85:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80101f88:	c9                   	leave  
80101f89:	c3                   	ret    

80101f8a <idup>:

// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
80101f8a:	55                   	push   %ebp
80101f8b:	89 e5                	mov    %esp,%ebp
80101f8d:	83 ec 18             	sub    $0x18,%esp
  acquire(&icache.lock);
80101f90:	c7 04 24 c0 07 11 80 	movl   $0x801107c0,(%esp)
80101f97:	e8 1b 3b 00 00       	call   80105ab7 <acquire>
  ip->ref++;
80101f9c:	8b 45 08             	mov    0x8(%ebp),%eax
80101f9f:	8b 40 08             	mov    0x8(%eax),%eax
80101fa2:	8d 50 01             	lea    0x1(%eax),%edx
80101fa5:	8b 45 08             	mov    0x8(%ebp),%eax
80101fa8:	89 50 08             	mov    %edx,0x8(%eax)
  release(&icache.lock);
80101fab:	c7 04 24 c0 07 11 80 	movl   $0x801107c0,(%esp)
80101fb2:	e8 62 3b 00 00       	call   80105b19 <release>
  return ip;
80101fb7:	8b 45 08             	mov    0x8(%ebp),%eax
}
80101fba:	c9                   	leave  
80101fbb:	c3                   	ret    

80101fbc <ilock>:

// Lock the given inode.
// Reads the inode from disk if necessary.
void
ilock(struct inode *ip)
{
80101fbc:	55                   	push   %ebp
80101fbd:	89 e5                	mov    %esp,%ebp
80101fbf:	83 ec 28             	sub    $0x28,%esp
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
80101fc2:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80101fc6:	74 0a                	je     80101fd2 <ilock+0x16>
80101fc8:	8b 45 08             	mov    0x8(%ebp),%eax
80101fcb:	8b 40 08             	mov    0x8(%eax),%eax
80101fce:	85 c0                	test   %eax,%eax
80101fd0:	7f 0c                	jg     80101fde <ilock+0x22>
    panic("ilock");
80101fd2:	c7 04 24 8f 94 10 80 	movl   $0x8010948f,(%esp)
80101fd9:	e8 5f e5 ff ff       	call   8010053d <panic>

  acquire(&icache.lock);
80101fde:	c7 04 24 c0 07 11 80 	movl   $0x801107c0,(%esp)
80101fe5:	e8 cd 3a 00 00       	call   80105ab7 <acquire>
  while(ip->flags & I_BUSY)
80101fea:	eb 13                	jmp    80101fff <ilock+0x43>
    sleep(ip, &icache.lock);
80101fec:	c7 44 24 04 c0 07 11 	movl   $0x801107c0,0x4(%esp)
80101ff3:	80 
80101ff4:	8b 45 08             	mov    0x8(%ebp),%eax
80101ff7:	89 04 24             	mov    %eax,(%esp)
80101ffa:	e8 2a 36 00 00       	call   80105629 <sleep>

  if(ip == 0 || ip->ref < 1)
    panic("ilock");

  acquire(&icache.lock);
  while(ip->flags & I_BUSY)
80101fff:	8b 45 08             	mov    0x8(%ebp),%eax
80102002:	8b 40 0c             	mov    0xc(%eax),%eax
80102005:	83 e0 01             	and    $0x1,%eax
80102008:	84 c0                	test   %al,%al
8010200a:	75 e0                	jne    80101fec <ilock+0x30>
    sleep(ip, &icache.lock);
  ip->flags |= I_BUSY;
8010200c:	8b 45 08             	mov    0x8(%ebp),%eax
8010200f:	8b 40 0c             	mov    0xc(%eax),%eax
80102012:	89 c2                	mov    %eax,%edx
80102014:	83 ca 01             	or     $0x1,%edx
80102017:	8b 45 08             	mov    0x8(%ebp),%eax
8010201a:	89 50 0c             	mov    %edx,0xc(%eax)
  release(&icache.lock);
8010201d:	c7 04 24 c0 07 11 80 	movl   $0x801107c0,(%esp)
80102024:	e8 f0 3a 00 00       	call   80105b19 <release>

  if(!(ip->flags & I_VALID)){
80102029:	8b 45 08             	mov    0x8(%ebp),%eax
8010202c:	8b 40 0c             	mov    0xc(%eax),%eax
8010202f:	83 e0 02             	and    $0x2,%eax
80102032:	85 c0                	test   %eax,%eax
80102034:	0f 85 ce 00 00 00    	jne    80102108 <ilock+0x14c>
    bp = bread(ip->dev, IBLOCK(ip->inum));
8010203a:	8b 45 08             	mov    0x8(%ebp),%eax
8010203d:	8b 40 04             	mov    0x4(%eax),%eax
80102040:	c1 e8 03             	shr    $0x3,%eax
80102043:	8d 50 02             	lea    0x2(%eax),%edx
80102046:	8b 45 08             	mov    0x8(%ebp),%eax
80102049:	8b 00                	mov    (%eax),%eax
8010204b:	89 54 24 04          	mov    %edx,0x4(%esp)
8010204f:	89 04 24             	mov    %eax,(%esp)
80102052:	e8 4f e1 ff ff       	call   801001a6 <bread>
80102057:	89 45 f4             	mov    %eax,-0xc(%ebp)
    dip = (struct dinode*)bp->data + ip->inum%IPB;
8010205a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010205d:	8d 50 18             	lea    0x18(%eax),%edx
80102060:	8b 45 08             	mov    0x8(%ebp),%eax
80102063:	8b 40 04             	mov    0x4(%eax),%eax
80102066:	83 e0 07             	and    $0x7,%eax
80102069:	c1 e0 06             	shl    $0x6,%eax
8010206c:	01 d0                	add    %edx,%eax
8010206e:	89 45 f0             	mov    %eax,-0x10(%ebp)
    ip->type = dip->type;
80102071:	8b 45 f0             	mov    -0x10(%ebp),%eax
80102074:	0f b7 10             	movzwl (%eax),%edx
80102077:	8b 45 08             	mov    0x8(%ebp),%eax
8010207a:	66 89 50 10          	mov    %dx,0x10(%eax)
    ip->major = dip->major;
8010207e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80102081:	0f b7 50 02          	movzwl 0x2(%eax),%edx
80102085:	8b 45 08             	mov    0x8(%ebp),%eax
80102088:	66 89 50 12          	mov    %dx,0x12(%eax)
    ip->minor = dip->minor;
8010208c:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010208f:	0f b7 50 04          	movzwl 0x4(%eax),%edx
80102093:	8b 45 08             	mov    0x8(%ebp),%eax
80102096:	66 89 50 14          	mov    %dx,0x14(%eax)
    ip->nlink = dip->nlink;
8010209a:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010209d:	0f b7 50 06          	movzwl 0x6(%eax),%edx
801020a1:	8b 45 08             	mov    0x8(%ebp),%eax
801020a4:	66 89 50 16          	mov    %dx,0x16(%eax)
    ip->size = dip->size;
801020a8:	8b 45 f0             	mov    -0x10(%ebp),%eax
801020ab:	8b 50 08             	mov    0x8(%eax),%edx
801020ae:	8b 45 08             	mov    0x8(%ebp),%eax
801020b1:	89 50 18             	mov    %edx,0x18(%eax)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801020b4:	8b 45 f0             	mov    -0x10(%ebp),%eax
801020b7:	8d 50 0c             	lea    0xc(%eax),%edx
801020ba:	8b 45 08             	mov    0x8(%ebp),%eax
801020bd:	83 c0 1c             	add    $0x1c,%eax
801020c0:	c7 44 24 08 34 00 00 	movl   $0x34,0x8(%esp)
801020c7:	00 
801020c8:	89 54 24 04          	mov    %edx,0x4(%esp)
801020cc:	89 04 24             	mov    %eax,(%esp)
801020cf:	e8 05 3d 00 00       	call   80105dd9 <memmove>
    brelse(bp);
801020d4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801020d7:	89 04 24             	mov    %eax,(%esp)
801020da:	e8 38 e1 ff ff       	call   80100217 <brelse>
    ip->flags |= I_VALID;
801020df:	8b 45 08             	mov    0x8(%ebp),%eax
801020e2:	8b 40 0c             	mov    0xc(%eax),%eax
801020e5:	89 c2                	mov    %eax,%edx
801020e7:	83 ca 02             	or     $0x2,%edx
801020ea:	8b 45 08             	mov    0x8(%ebp),%eax
801020ed:	89 50 0c             	mov    %edx,0xc(%eax)
    if(ip->type == 0)
801020f0:	8b 45 08             	mov    0x8(%ebp),%eax
801020f3:	0f b7 40 10          	movzwl 0x10(%eax),%eax
801020f7:	66 85 c0             	test   %ax,%ax
801020fa:	75 0c                	jne    80102108 <ilock+0x14c>
      panic("ilock: no type");
801020fc:	c7 04 24 95 94 10 80 	movl   $0x80109495,(%esp)
80102103:	e8 35 e4 ff ff       	call   8010053d <panic>
  }
}
80102108:	c9                   	leave  
80102109:	c3                   	ret    

8010210a <iunlock>:

// Unlock the given inode.
void
iunlock(struct inode *ip)
{
8010210a:	55                   	push   %ebp
8010210b:	89 e5                	mov    %esp,%ebp
8010210d:	83 ec 18             	sub    $0x18,%esp
  if(ip == 0 || !(ip->flags & I_BUSY) || ip->ref < 1)
80102110:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80102114:	74 17                	je     8010212d <iunlock+0x23>
80102116:	8b 45 08             	mov    0x8(%ebp),%eax
80102119:	8b 40 0c             	mov    0xc(%eax),%eax
8010211c:	83 e0 01             	and    $0x1,%eax
8010211f:	85 c0                	test   %eax,%eax
80102121:	74 0a                	je     8010212d <iunlock+0x23>
80102123:	8b 45 08             	mov    0x8(%ebp),%eax
80102126:	8b 40 08             	mov    0x8(%eax),%eax
80102129:	85 c0                	test   %eax,%eax
8010212b:	7f 0c                	jg     80102139 <iunlock+0x2f>
    panic("iunlock");
8010212d:	c7 04 24 a4 94 10 80 	movl   $0x801094a4,(%esp)
80102134:	e8 04 e4 ff ff       	call   8010053d <panic>

  acquire(&icache.lock);
80102139:	c7 04 24 c0 07 11 80 	movl   $0x801107c0,(%esp)
80102140:	e8 72 39 00 00       	call   80105ab7 <acquire>
  ip->flags &= ~I_BUSY;
80102145:	8b 45 08             	mov    0x8(%ebp),%eax
80102148:	8b 40 0c             	mov    0xc(%eax),%eax
8010214b:	89 c2                	mov    %eax,%edx
8010214d:	83 e2 fe             	and    $0xfffffffe,%edx
80102150:	8b 45 08             	mov    0x8(%ebp),%eax
80102153:	89 50 0c             	mov    %edx,0xc(%eax)
  wakeup(ip);
80102156:	8b 45 08             	mov    0x8(%ebp),%eax
80102159:	89 04 24             	mov    %eax,(%esp)
8010215c:	e8 b6 35 00 00       	call   80105717 <wakeup>
  release(&icache.lock);
80102161:	c7 04 24 c0 07 11 80 	movl   $0x801107c0,(%esp)
80102168:	e8 ac 39 00 00       	call   80105b19 <release>
}
8010216d:	c9                   	leave  
8010216e:	c3                   	ret    

8010216f <iput>:
// be recycled.
// If that was the last reference and the inode has no links
// to it, free the inode (and its content) on disk.
void
iput(struct inode *ip)
{
8010216f:	55                   	push   %ebp
80102170:	89 e5                	mov    %esp,%ebp
80102172:	83 ec 18             	sub    $0x18,%esp
  acquire(&icache.lock);
80102175:	c7 04 24 c0 07 11 80 	movl   $0x801107c0,(%esp)
8010217c:	e8 36 39 00 00       	call   80105ab7 <acquire>
  if(ip->ref == 1 && (ip->flags & I_VALID) && ip->nlink == 0){
80102181:	8b 45 08             	mov    0x8(%ebp),%eax
80102184:	8b 40 08             	mov    0x8(%eax),%eax
80102187:	83 f8 01             	cmp    $0x1,%eax
8010218a:	0f 85 93 00 00 00    	jne    80102223 <iput+0xb4>
80102190:	8b 45 08             	mov    0x8(%ebp),%eax
80102193:	8b 40 0c             	mov    0xc(%eax),%eax
80102196:	83 e0 02             	and    $0x2,%eax
80102199:	85 c0                	test   %eax,%eax
8010219b:	0f 84 82 00 00 00    	je     80102223 <iput+0xb4>
801021a1:	8b 45 08             	mov    0x8(%ebp),%eax
801021a4:	0f b7 40 16          	movzwl 0x16(%eax),%eax
801021a8:	66 85 c0             	test   %ax,%ax
801021ab:	75 76                	jne    80102223 <iput+0xb4>
    // inode has no links: truncate and free inode.
    if(ip->flags & I_BUSY)
801021ad:	8b 45 08             	mov    0x8(%ebp),%eax
801021b0:	8b 40 0c             	mov    0xc(%eax),%eax
801021b3:	83 e0 01             	and    $0x1,%eax
801021b6:	84 c0                	test   %al,%al
801021b8:	74 0c                	je     801021c6 <iput+0x57>
      panic("iput busy");
801021ba:	c7 04 24 ac 94 10 80 	movl   $0x801094ac,(%esp)
801021c1:	e8 77 e3 ff ff       	call   8010053d <panic>
    ip->flags |= I_BUSY;
801021c6:	8b 45 08             	mov    0x8(%ebp),%eax
801021c9:	8b 40 0c             	mov    0xc(%eax),%eax
801021cc:	89 c2                	mov    %eax,%edx
801021ce:	83 ca 01             	or     $0x1,%edx
801021d1:	8b 45 08             	mov    0x8(%ebp),%eax
801021d4:	89 50 0c             	mov    %edx,0xc(%eax)
    release(&icache.lock);
801021d7:	c7 04 24 c0 07 11 80 	movl   $0x801107c0,(%esp)
801021de:	e8 36 39 00 00       	call   80105b19 <release>
    itrunc(ip);
801021e3:	8b 45 08             	mov    0x8(%ebp),%eax
801021e6:	89 04 24             	mov    %eax,(%esp)
801021e9:	e8 72 01 00 00       	call   80102360 <itrunc>
    ip->type = 0;
801021ee:	8b 45 08             	mov    0x8(%ebp),%eax
801021f1:	66 c7 40 10 00 00    	movw   $0x0,0x10(%eax)
    iupdate(ip);
801021f7:	8b 45 08             	mov    0x8(%ebp),%eax
801021fa:	89 04 24             	mov    %eax,(%esp)
801021fd:	e8 fe fb ff ff       	call   80101e00 <iupdate>
    acquire(&icache.lock);
80102202:	c7 04 24 c0 07 11 80 	movl   $0x801107c0,(%esp)
80102209:	e8 a9 38 00 00       	call   80105ab7 <acquire>
    ip->flags = 0;
8010220e:	8b 45 08             	mov    0x8(%ebp),%eax
80102211:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    wakeup(ip);
80102218:	8b 45 08             	mov    0x8(%ebp),%eax
8010221b:	89 04 24             	mov    %eax,(%esp)
8010221e:	e8 f4 34 00 00       	call   80105717 <wakeup>
  }
  ip->ref--;
80102223:	8b 45 08             	mov    0x8(%ebp),%eax
80102226:	8b 40 08             	mov    0x8(%eax),%eax
80102229:	8d 50 ff             	lea    -0x1(%eax),%edx
8010222c:	8b 45 08             	mov    0x8(%ebp),%eax
8010222f:	89 50 08             	mov    %edx,0x8(%eax)
  release(&icache.lock);
80102232:	c7 04 24 c0 07 11 80 	movl   $0x801107c0,(%esp)
80102239:	e8 db 38 00 00       	call   80105b19 <release>
}
8010223e:	c9                   	leave  
8010223f:	c3                   	ret    

80102240 <iunlockput>:

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
80102240:	55                   	push   %ebp
80102241:	89 e5                	mov    %esp,%ebp
80102243:	83 ec 18             	sub    $0x18,%esp
  iunlock(ip);
80102246:	8b 45 08             	mov    0x8(%ebp),%eax
80102249:	89 04 24             	mov    %eax,(%esp)
8010224c:	e8 b9 fe ff ff       	call   8010210a <iunlock>
  iput(ip);
80102251:	8b 45 08             	mov    0x8(%ebp),%eax
80102254:	89 04 24             	mov    %eax,(%esp)
80102257:	e8 13 ff ff ff       	call   8010216f <iput>
}
8010225c:	c9                   	leave  
8010225d:	c3                   	ret    

8010225e <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
8010225e:	55                   	push   %ebp
8010225f:	89 e5                	mov    %esp,%ebp
80102261:	53                   	push   %ebx
80102262:	83 ec 24             	sub    $0x24,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
80102265:	83 7d 0c 0b          	cmpl   $0xb,0xc(%ebp)
80102269:	77 3e                	ja     801022a9 <bmap+0x4b>
    if((addr = ip->addrs[bn]) == 0)
8010226b:	8b 45 08             	mov    0x8(%ebp),%eax
8010226e:	8b 55 0c             	mov    0xc(%ebp),%edx
80102271:	83 c2 04             	add    $0x4,%edx
80102274:	8b 44 90 0c          	mov    0xc(%eax,%edx,4),%eax
80102278:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010227b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010227f:	75 20                	jne    801022a1 <bmap+0x43>
      ip->addrs[bn] = addr = balloc(ip->dev);
80102281:	8b 45 08             	mov    0x8(%ebp),%eax
80102284:	8b 00                	mov    (%eax),%eax
80102286:	89 04 24             	mov    %eax,(%esp)
80102289:	e8 49 f8 ff ff       	call   80101ad7 <balloc>
8010228e:	89 45 f4             	mov    %eax,-0xc(%ebp)
80102291:	8b 45 08             	mov    0x8(%ebp),%eax
80102294:	8b 55 0c             	mov    0xc(%ebp),%edx
80102297:	8d 4a 04             	lea    0x4(%edx),%ecx
8010229a:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010229d:	89 54 88 0c          	mov    %edx,0xc(%eax,%ecx,4)
    return addr;
801022a1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801022a4:	e9 b1 00 00 00       	jmp    8010235a <bmap+0xfc>
  }
  bn -= NDIRECT;
801022a9:	83 6d 0c 0c          	subl   $0xc,0xc(%ebp)

  if(bn < NINDIRECT){
801022ad:	83 7d 0c 7f          	cmpl   $0x7f,0xc(%ebp)
801022b1:	0f 87 97 00 00 00    	ja     8010234e <bmap+0xf0>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
801022b7:	8b 45 08             	mov    0x8(%ebp),%eax
801022ba:	8b 40 4c             	mov    0x4c(%eax),%eax
801022bd:	89 45 f4             	mov    %eax,-0xc(%ebp)
801022c0:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801022c4:	75 19                	jne    801022df <bmap+0x81>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
801022c6:	8b 45 08             	mov    0x8(%ebp),%eax
801022c9:	8b 00                	mov    (%eax),%eax
801022cb:	89 04 24             	mov    %eax,(%esp)
801022ce:	e8 04 f8 ff ff       	call   80101ad7 <balloc>
801022d3:	89 45 f4             	mov    %eax,-0xc(%ebp)
801022d6:	8b 45 08             	mov    0x8(%ebp),%eax
801022d9:	8b 55 f4             	mov    -0xc(%ebp),%edx
801022dc:	89 50 4c             	mov    %edx,0x4c(%eax)
    bp = bread(ip->dev, addr);
801022df:	8b 45 08             	mov    0x8(%ebp),%eax
801022e2:	8b 00                	mov    (%eax),%eax
801022e4:	8b 55 f4             	mov    -0xc(%ebp),%edx
801022e7:	89 54 24 04          	mov    %edx,0x4(%esp)
801022eb:	89 04 24             	mov    %eax,(%esp)
801022ee:	e8 b3 de ff ff       	call   801001a6 <bread>
801022f3:	89 45 f0             	mov    %eax,-0x10(%ebp)
    a = (uint*)bp->data;
801022f6:	8b 45 f0             	mov    -0x10(%ebp),%eax
801022f9:	83 c0 18             	add    $0x18,%eax
801022fc:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if((addr = a[bn]) == 0){
801022ff:	8b 45 0c             	mov    0xc(%ebp),%eax
80102302:	c1 e0 02             	shl    $0x2,%eax
80102305:	03 45 ec             	add    -0x14(%ebp),%eax
80102308:	8b 00                	mov    (%eax),%eax
8010230a:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010230d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80102311:	75 2b                	jne    8010233e <bmap+0xe0>
      a[bn] = addr = balloc(ip->dev);
80102313:	8b 45 0c             	mov    0xc(%ebp),%eax
80102316:	c1 e0 02             	shl    $0x2,%eax
80102319:	89 c3                	mov    %eax,%ebx
8010231b:	03 5d ec             	add    -0x14(%ebp),%ebx
8010231e:	8b 45 08             	mov    0x8(%ebp),%eax
80102321:	8b 00                	mov    (%eax),%eax
80102323:	89 04 24             	mov    %eax,(%esp)
80102326:	e8 ac f7 ff ff       	call   80101ad7 <balloc>
8010232b:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010232e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102331:	89 03                	mov    %eax,(%ebx)
      log_write(bp);
80102333:	8b 45 f0             	mov    -0x10(%ebp),%eax
80102336:	89 04 24             	mov    %eax,(%esp)
80102339:	e8 d4 16 00 00       	call   80103a12 <log_write>
    }
    brelse(bp);
8010233e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80102341:	89 04 24             	mov    %eax,(%esp)
80102344:	e8 ce de ff ff       	call   80100217 <brelse>
    return addr;
80102349:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010234c:	eb 0c                	jmp    8010235a <bmap+0xfc>
  }

  panic("bmap: out of range");
8010234e:	c7 04 24 b6 94 10 80 	movl   $0x801094b6,(%esp)
80102355:	e8 e3 e1 ff ff       	call   8010053d <panic>
}
8010235a:	83 c4 24             	add    $0x24,%esp
8010235d:	5b                   	pop    %ebx
8010235e:	5d                   	pop    %ebp
8010235f:	c3                   	ret    

80102360 <itrunc>:
// to it (no directory entries referring to it)
// and has no in-memory reference to it (is
// not an open file or current directory).
static void
itrunc(struct inode *ip)
{
80102360:	55                   	push   %ebp
80102361:	89 e5                	mov    %esp,%ebp
80102363:	83 ec 28             	sub    $0x28,%esp
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80102366:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010236d:	eb 44                	jmp    801023b3 <itrunc+0x53>
    if(ip->addrs[i]){
8010236f:	8b 45 08             	mov    0x8(%ebp),%eax
80102372:	8b 55 f4             	mov    -0xc(%ebp),%edx
80102375:	83 c2 04             	add    $0x4,%edx
80102378:	8b 44 90 0c          	mov    0xc(%eax,%edx,4),%eax
8010237c:	85 c0                	test   %eax,%eax
8010237e:	74 2f                	je     801023af <itrunc+0x4f>
      bfree(ip->dev, ip->addrs[i]);
80102380:	8b 45 08             	mov    0x8(%ebp),%eax
80102383:	8b 55 f4             	mov    -0xc(%ebp),%edx
80102386:	83 c2 04             	add    $0x4,%edx
80102389:	8b 54 90 0c          	mov    0xc(%eax,%edx,4),%edx
8010238d:	8b 45 08             	mov    0x8(%ebp),%eax
80102390:	8b 00                	mov    (%eax),%eax
80102392:	89 54 24 04          	mov    %edx,0x4(%esp)
80102396:	89 04 24             	mov    %eax,(%esp)
80102399:	e8 90 f8 ff ff       	call   80101c2e <bfree>
      ip->addrs[i] = 0;
8010239e:	8b 45 08             	mov    0x8(%ebp),%eax
801023a1:	8b 55 f4             	mov    -0xc(%ebp),%edx
801023a4:	83 c2 04             	add    $0x4,%edx
801023a7:	c7 44 90 0c 00 00 00 	movl   $0x0,0xc(%eax,%edx,4)
801023ae:	00 
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
801023af:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801023b3:	83 7d f4 0b          	cmpl   $0xb,-0xc(%ebp)
801023b7:	7e b6                	jle    8010236f <itrunc+0xf>
      bfree(ip->dev, ip->addrs[i]);
      ip->addrs[i] = 0;
    }
  }
  
  if(ip->addrs[NDIRECT]){
801023b9:	8b 45 08             	mov    0x8(%ebp),%eax
801023bc:	8b 40 4c             	mov    0x4c(%eax),%eax
801023bf:	85 c0                	test   %eax,%eax
801023c1:	0f 84 8f 00 00 00    	je     80102456 <itrunc+0xf6>
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
801023c7:	8b 45 08             	mov    0x8(%ebp),%eax
801023ca:	8b 50 4c             	mov    0x4c(%eax),%edx
801023cd:	8b 45 08             	mov    0x8(%ebp),%eax
801023d0:	8b 00                	mov    (%eax),%eax
801023d2:	89 54 24 04          	mov    %edx,0x4(%esp)
801023d6:	89 04 24             	mov    %eax,(%esp)
801023d9:	e8 c8 dd ff ff       	call   801001a6 <bread>
801023de:	89 45 ec             	mov    %eax,-0x14(%ebp)
    a = (uint*)bp->data;
801023e1:	8b 45 ec             	mov    -0x14(%ebp),%eax
801023e4:	83 c0 18             	add    $0x18,%eax
801023e7:	89 45 e8             	mov    %eax,-0x18(%ebp)
    for(j = 0; j < NINDIRECT; j++){
801023ea:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
801023f1:	eb 2f                	jmp    80102422 <itrunc+0xc2>
      if(a[j])
801023f3:	8b 45 f0             	mov    -0x10(%ebp),%eax
801023f6:	c1 e0 02             	shl    $0x2,%eax
801023f9:	03 45 e8             	add    -0x18(%ebp),%eax
801023fc:	8b 00                	mov    (%eax),%eax
801023fe:	85 c0                	test   %eax,%eax
80102400:	74 1c                	je     8010241e <itrunc+0xbe>
        bfree(ip->dev, a[j]);
80102402:	8b 45 f0             	mov    -0x10(%ebp),%eax
80102405:	c1 e0 02             	shl    $0x2,%eax
80102408:	03 45 e8             	add    -0x18(%ebp),%eax
8010240b:	8b 10                	mov    (%eax),%edx
8010240d:	8b 45 08             	mov    0x8(%ebp),%eax
80102410:	8b 00                	mov    (%eax),%eax
80102412:	89 54 24 04          	mov    %edx,0x4(%esp)
80102416:	89 04 24             	mov    %eax,(%esp)
80102419:	e8 10 f8 ff ff       	call   80101c2e <bfree>
  }
  
  if(ip->addrs[NDIRECT]){
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
    a = (uint*)bp->data;
    for(j = 0; j < NINDIRECT; j++){
8010241e:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
80102422:	8b 45 f0             	mov    -0x10(%ebp),%eax
80102425:	83 f8 7f             	cmp    $0x7f,%eax
80102428:	76 c9                	jbe    801023f3 <itrunc+0x93>
      if(a[j])
        bfree(ip->dev, a[j]);
    }
    brelse(bp);
8010242a:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010242d:	89 04 24             	mov    %eax,(%esp)
80102430:	e8 e2 dd ff ff       	call   80100217 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
80102435:	8b 45 08             	mov    0x8(%ebp),%eax
80102438:	8b 50 4c             	mov    0x4c(%eax),%edx
8010243b:	8b 45 08             	mov    0x8(%ebp),%eax
8010243e:	8b 00                	mov    (%eax),%eax
80102440:	89 54 24 04          	mov    %edx,0x4(%esp)
80102444:	89 04 24             	mov    %eax,(%esp)
80102447:	e8 e2 f7 ff ff       	call   80101c2e <bfree>
    ip->addrs[NDIRECT] = 0;
8010244c:	8b 45 08             	mov    0x8(%ebp),%eax
8010244f:	c7 40 4c 00 00 00 00 	movl   $0x0,0x4c(%eax)
  }

  ip->size = 0;
80102456:	8b 45 08             	mov    0x8(%ebp),%eax
80102459:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)
  iupdate(ip);
80102460:	8b 45 08             	mov    0x8(%ebp),%eax
80102463:	89 04 24             	mov    %eax,(%esp)
80102466:	e8 95 f9 ff ff       	call   80101e00 <iupdate>
}
8010246b:	c9                   	leave  
8010246c:	c3                   	ret    

8010246d <stati>:

// Copy stat information from inode.
void
stati(struct inode *ip, struct stat *st)
{
8010246d:	55                   	push   %ebp
8010246e:	89 e5                	mov    %esp,%ebp
  st->dev = ip->dev;
80102470:	8b 45 08             	mov    0x8(%ebp),%eax
80102473:	8b 00                	mov    (%eax),%eax
80102475:	89 c2                	mov    %eax,%edx
80102477:	8b 45 0c             	mov    0xc(%ebp),%eax
8010247a:	89 50 04             	mov    %edx,0x4(%eax)
  st->ino = ip->inum;
8010247d:	8b 45 08             	mov    0x8(%ebp),%eax
80102480:	8b 50 04             	mov    0x4(%eax),%edx
80102483:	8b 45 0c             	mov    0xc(%ebp),%eax
80102486:	89 50 08             	mov    %edx,0x8(%eax)
  st->type = ip->type;
80102489:	8b 45 08             	mov    0x8(%ebp),%eax
8010248c:	0f b7 50 10          	movzwl 0x10(%eax),%edx
80102490:	8b 45 0c             	mov    0xc(%ebp),%eax
80102493:	66 89 10             	mov    %dx,(%eax)
  st->nlink = ip->nlink;
80102496:	8b 45 08             	mov    0x8(%ebp),%eax
80102499:	0f b7 50 16          	movzwl 0x16(%eax),%edx
8010249d:	8b 45 0c             	mov    0xc(%ebp),%eax
801024a0:	66 89 50 0c          	mov    %dx,0xc(%eax)
  st->size = ip->size;
801024a4:	8b 45 08             	mov    0x8(%ebp),%eax
801024a7:	8b 50 18             	mov    0x18(%eax),%edx
801024aa:	8b 45 0c             	mov    0xc(%ebp),%eax
801024ad:	89 50 10             	mov    %edx,0x10(%eax)
}
801024b0:	5d                   	pop    %ebp
801024b1:	c3                   	ret    

801024b2 <readi>:

//PAGEBREAK!
// Read data from inode.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
801024b2:	55                   	push   %ebp
801024b3:	89 e5                	mov    %esp,%ebp
801024b5:	53                   	push   %ebx
801024b6:	83 ec 24             	sub    $0x24,%esp
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
801024b9:	8b 45 08             	mov    0x8(%ebp),%eax
801024bc:	0f b7 40 10          	movzwl 0x10(%eax),%eax
801024c0:	66 83 f8 03          	cmp    $0x3,%ax
801024c4:	75 60                	jne    80102526 <readi+0x74>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
801024c6:	8b 45 08             	mov    0x8(%ebp),%eax
801024c9:	0f b7 40 12          	movzwl 0x12(%eax),%eax
801024cd:	66 85 c0             	test   %ax,%ax
801024d0:	78 20                	js     801024f2 <readi+0x40>
801024d2:	8b 45 08             	mov    0x8(%ebp),%eax
801024d5:	0f b7 40 12          	movzwl 0x12(%eax),%eax
801024d9:	66 83 f8 09          	cmp    $0x9,%ax
801024dd:	7f 13                	jg     801024f2 <readi+0x40>
801024df:	8b 45 08             	mov    0x8(%ebp),%eax
801024e2:	0f b7 40 12          	movzwl 0x12(%eax),%eax
801024e6:	98                   	cwtl   
801024e7:	8b 04 c5 60 07 11 80 	mov    -0x7feef8a0(,%eax,8),%eax
801024ee:	85 c0                	test   %eax,%eax
801024f0:	75 0a                	jne    801024fc <readi+0x4a>
      return -1;
801024f2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801024f7:	e9 1b 01 00 00       	jmp    80102617 <readi+0x165>
    return devsw[ip->major].read(ip, dst, n);
801024fc:	8b 45 08             	mov    0x8(%ebp),%eax
801024ff:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80102503:	98                   	cwtl   
80102504:	8b 14 c5 60 07 11 80 	mov    -0x7feef8a0(,%eax,8),%edx
8010250b:	8b 45 14             	mov    0x14(%ebp),%eax
8010250e:	89 44 24 08          	mov    %eax,0x8(%esp)
80102512:	8b 45 0c             	mov    0xc(%ebp),%eax
80102515:	89 44 24 04          	mov    %eax,0x4(%esp)
80102519:	8b 45 08             	mov    0x8(%ebp),%eax
8010251c:	89 04 24             	mov    %eax,(%esp)
8010251f:	ff d2                	call   *%edx
80102521:	e9 f1 00 00 00       	jmp    80102617 <readi+0x165>
  }

  if(off > ip->size || off + n < off)
80102526:	8b 45 08             	mov    0x8(%ebp),%eax
80102529:	8b 40 18             	mov    0x18(%eax),%eax
8010252c:	3b 45 10             	cmp    0x10(%ebp),%eax
8010252f:	72 0d                	jb     8010253e <readi+0x8c>
80102531:	8b 45 14             	mov    0x14(%ebp),%eax
80102534:	8b 55 10             	mov    0x10(%ebp),%edx
80102537:	01 d0                	add    %edx,%eax
80102539:	3b 45 10             	cmp    0x10(%ebp),%eax
8010253c:	73 0a                	jae    80102548 <readi+0x96>
    return -1;
8010253e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102543:	e9 cf 00 00 00       	jmp    80102617 <readi+0x165>
  if(off + n > ip->size)
80102548:	8b 45 14             	mov    0x14(%ebp),%eax
8010254b:	8b 55 10             	mov    0x10(%ebp),%edx
8010254e:	01 c2                	add    %eax,%edx
80102550:	8b 45 08             	mov    0x8(%ebp),%eax
80102553:	8b 40 18             	mov    0x18(%eax),%eax
80102556:	39 c2                	cmp    %eax,%edx
80102558:	76 0c                	jbe    80102566 <readi+0xb4>
    n = ip->size - off;
8010255a:	8b 45 08             	mov    0x8(%ebp),%eax
8010255d:	8b 40 18             	mov    0x18(%eax),%eax
80102560:	2b 45 10             	sub    0x10(%ebp),%eax
80102563:	89 45 14             	mov    %eax,0x14(%ebp)

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80102566:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010256d:	e9 96 00 00 00       	jmp    80102608 <readi+0x156>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80102572:	8b 45 10             	mov    0x10(%ebp),%eax
80102575:	c1 e8 09             	shr    $0x9,%eax
80102578:	89 44 24 04          	mov    %eax,0x4(%esp)
8010257c:	8b 45 08             	mov    0x8(%ebp),%eax
8010257f:	89 04 24             	mov    %eax,(%esp)
80102582:	e8 d7 fc ff ff       	call   8010225e <bmap>
80102587:	8b 55 08             	mov    0x8(%ebp),%edx
8010258a:	8b 12                	mov    (%edx),%edx
8010258c:	89 44 24 04          	mov    %eax,0x4(%esp)
80102590:	89 14 24             	mov    %edx,(%esp)
80102593:	e8 0e dc ff ff       	call   801001a6 <bread>
80102598:	89 45 f0             	mov    %eax,-0x10(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
8010259b:	8b 45 10             	mov    0x10(%ebp),%eax
8010259e:	89 c2                	mov    %eax,%edx
801025a0:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
801025a6:	b8 00 02 00 00       	mov    $0x200,%eax
801025ab:	89 c1                	mov    %eax,%ecx
801025ad:	29 d1                	sub    %edx,%ecx
801025af:	89 ca                	mov    %ecx,%edx
801025b1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801025b4:	8b 4d 14             	mov    0x14(%ebp),%ecx
801025b7:	89 cb                	mov    %ecx,%ebx
801025b9:	29 c3                	sub    %eax,%ebx
801025bb:	89 d8                	mov    %ebx,%eax
801025bd:	39 c2                	cmp    %eax,%edx
801025bf:	0f 46 c2             	cmovbe %edx,%eax
801025c2:	89 45 ec             	mov    %eax,-0x14(%ebp)
    memmove(dst, bp->data + off%BSIZE, m);
801025c5:	8b 45 f0             	mov    -0x10(%ebp),%eax
801025c8:	8d 50 18             	lea    0x18(%eax),%edx
801025cb:	8b 45 10             	mov    0x10(%ebp),%eax
801025ce:	25 ff 01 00 00       	and    $0x1ff,%eax
801025d3:	01 c2                	add    %eax,%edx
801025d5:	8b 45 ec             	mov    -0x14(%ebp),%eax
801025d8:	89 44 24 08          	mov    %eax,0x8(%esp)
801025dc:	89 54 24 04          	mov    %edx,0x4(%esp)
801025e0:	8b 45 0c             	mov    0xc(%ebp),%eax
801025e3:	89 04 24             	mov    %eax,(%esp)
801025e6:	e8 ee 37 00 00       	call   80105dd9 <memmove>
    brelse(bp);
801025eb:	8b 45 f0             	mov    -0x10(%ebp),%eax
801025ee:	89 04 24             	mov    %eax,(%esp)
801025f1:	e8 21 dc ff ff       	call   80100217 <brelse>
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
801025f6:	8b 45 ec             	mov    -0x14(%ebp),%eax
801025f9:	01 45 f4             	add    %eax,-0xc(%ebp)
801025fc:	8b 45 ec             	mov    -0x14(%ebp),%eax
801025ff:	01 45 10             	add    %eax,0x10(%ebp)
80102602:	8b 45 ec             	mov    -0x14(%ebp),%eax
80102605:	01 45 0c             	add    %eax,0xc(%ebp)
80102608:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010260b:	3b 45 14             	cmp    0x14(%ebp),%eax
8010260e:	0f 82 5e ff ff ff    	jb     80102572 <readi+0xc0>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(dst, bp->data + off%BSIZE, m);
    brelse(bp);
  }
  return n;
80102614:	8b 45 14             	mov    0x14(%ebp),%eax
}
80102617:	83 c4 24             	add    $0x24,%esp
8010261a:	5b                   	pop    %ebx
8010261b:	5d                   	pop    %ebp
8010261c:	c3                   	ret    

8010261d <writei>:

// PAGEBREAK!
// Write data to inode.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
8010261d:	55                   	push   %ebp
8010261e:	89 e5                	mov    %esp,%ebp
80102620:	53                   	push   %ebx
80102621:	83 ec 24             	sub    $0x24,%esp
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80102624:	8b 45 08             	mov    0x8(%ebp),%eax
80102627:	0f b7 40 10          	movzwl 0x10(%eax),%eax
8010262b:	66 83 f8 03          	cmp    $0x3,%ax
8010262f:	75 60                	jne    80102691 <writei+0x74>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80102631:	8b 45 08             	mov    0x8(%ebp),%eax
80102634:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80102638:	66 85 c0             	test   %ax,%ax
8010263b:	78 20                	js     8010265d <writei+0x40>
8010263d:	8b 45 08             	mov    0x8(%ebp),%eax
80102640:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80102644:	66 83 f8 09          	cmp    $0x9,%ax
80102648:	7f 13                	jg     8010265d <writei+0x40>
8010264a:	8b 45 08             	mov    0x8(%ebp),%eax
8010264d:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80102651:	98                   	cwtl   
80102652:	8b 04 c5 64 07 11 80 	mov    -0x7feef89c(,%eax,8),%eax
80102659:	85 c0                	test   %eax,%eax
8010265b:	75 0a                	jne    80102667 <writei+0x4a>
      return -1;
8010265d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102662:	e9 46 01 00 00       	jmp    801027ad <writei+0x190>
    return devsw[ip->major].write(ip, src, n);
80102667:	8b 45 08             	mov    0x8(%ebp),%eax
8010266a:	0f b7 40 12          	movzwl 0x12(%eax),%eax
8010266e:	98                   	cwtl   
8010266f:	8b 14 c5 64 07 11 80 	mov    -0x7feef89c(,%eax,8),%edx
80102676:	8b 45 14             	mov    0x14(%ebp),%eax
80102679:	89 44 24 08          	mov    %eax,0x8(%esp)
8010267d:	8b 45 0c             	mov    0xc(%ebp),%eax
80102680:	89 44 24 04          	mov    %eax,0x4(%esp)
80102684:	8b 45 08             	mov    0x8(%ebp),%eax
80102687:	89 04 24             	mov    %eax,(%esp)
8010268a:	ff d2                	call   *%edx
8010268c:	e9 1c 01 00 00       	jmp    801027ad <writei+0x190>
  }

  if(off > ip->size || off + n < off)
80102691:	8b 45 08             	mov    0x8(%ebp),%eax
80102694:	8b 40 18             	mov    0x18(%eax),%eax
80102697:	3b 45 10             	cmp    0x10(%ebp),%eax
8010269a:	72 0d                	jb     801026a9 <writei+0x8c>
8010269c:	8b 45 14             	mov    0x14(%ebp),%eax
8010269f:	8b 55 10             	mov    0x10(%ebp),%edx
801026a2:	01 d0                	add    %edx,%eax
801026a4:	3b 45 10             	cmp    0x10(%ebp),%eax
801026a7:	73 0a                	jae    801026b3 <writei+0x96>
    return -1;
801026a9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801026ae:	e9 fa 00 00 00       	jmp    801027ad <writei+0x190>
  if(off + n > MAXFILE*BSIZE)
801026b3:	8b 45 14             	mov    0x14(%ebp),%eax
801026b6:	8b 55 10             	mov    0x10(%ebp),%edx
801026b9:	01 d0                	add    %edx,%eax
801026bb:	3d 00 18 01 00       	cmp    $0x11800,%eax
801026c0:	76 0a                	jbe    801026cc <writei+0xaf>
    return -1;
801026c2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801026c7:	e9 e1 00 00 00       	jmp    801027ad <writei+0x190>

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
801026cc:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801026d3:	e9 a1 00 00 00       	jmp    80102779 <writei+0x15c>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
801026d8:	8b 45 10             	mov    0x10(%ebp),%eax
801026db:	c1 e8 09             	shr    $0x9,%eax
801026de:	89 44 24 04          	mov    %eax,0x4(%esp)
801026e2:	8b 45 08             	mov    0x8(%ebp),%eax
801026e5:	89 04 24             	mov    %eax,(%esp)
801026e8:	e8 71 fb ff ff       	call   8010225e <bmap>
801026ed:	8b 55 08             	mov    0x8(%ebp),%edx
801026f0:	8b 12                	mov    (%edx),%edx
801026f2:	89 44 24 04          	mov    %eax,0x4(%esp)
801026f6:	89 14 24             	mov    %edx,(%esp)
801026f9:	e8 a8 da ff ff       	call   801001a6 <bread>
801026fe:	89 45 f0             	mov    %eax,-0x10(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
80102701:	8b 45 10             	mov    0x10(%ebp),%eax
80102704:	89 c2                	mov    %eax,%edx
80102706:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
8010270c:	b8 00 02 00 00       	mov    $0x200,%eax
80102711:	89 c1                	mov    %eax,%ecx
80102713:	29 d1                	sub    %edx,%ecx
80102715:	89 ca                	mov    %ecx,%edx
80102717:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010271a:	8b 4d 14             	mov    0x14(%ebp),%ecx
8010271d:	89 cb                	mov    %ecx,%ebx
8010271f:	29 c3                	sub    %eax,%ebx
80102721:	89 d8                	mov    %ebx,%eax
80102723:	39 c2                	cmp    %eax,%edx
80102725:	0f 46 c2             	cmovbe %edx,%eax
80102728:	89 45 ec             	mov    %eax,-0x14(%ebp)
    memmove(bp->data + off%BSIZE, src, m);
8010272b:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010272e:	8d 50 18             	lea    0x18(%eax),%edx
80102731:	8b 45 10             	mov    0x10(%ebp),%eax
80102734:	25 ff 01 00 00       	and    $0x1ff,%eax
80102739:	01 c2                	add    %eax,%edx
8010273b:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010273e:	89 44 24 08          	mov    %eax,0x8(%esp)
80102742:	8b 45 0c             	mov    0xc(%ebp),%eax
80102745:	89 44 24 04          	mov    %eax,0x4(%esp)
80102749:	89 14 24             	mov    %edx,(%esp)
8010274c:	e8 88 36 00 00       	call   80105dd9 <memmove>
    log_write(bp);
80102751:	8b 45 f0             	mov    -0x10(%ebp),%eax
80102754:	89 04 24             	mov    %eax,(%esp)
80102757:	e8 b6 12 00 00       	call   80103a12 <log_write>
    brelse(bp);
8010275c:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010275f:	89 04 24             	mov    %eax,(%esp)
80102762:	e8 b0 da ff ff       	call   80100217 <brelse>
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > MAXFILE*BSIZE)
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80102767:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010276a:	01 45 f4             	add    %eax,-0xc(%ebp)
8010276d:	8b 45 ec             	mov    -0x14(%ebp),%eax
80102770:	01 45 10             	add    %eax,0x10(%ebp)
80102773:	8b 45 ec             	mov    -0x14(%ebp),%eax
80102776:	01 45 0c             	add    %eax,0xc(%ebp)
80102779:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010277c:	3b 45 14             	cmp    0x14(%ebp),%eax
8010277f:	0f 82 53 ff ff ff    	jb     801026d8 <writei+0xbb>
    memmove(bp->data + off%BSIZE, src, m);
    log_write(bp);
    brelse(bp);
  }

  if(n > 0 && off > ip->size){
80102785:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
80102789:	74 1f                	je     801027aa <writei+0x18d>
8010278b:	8b 45 08             	mov    0x8(%ebp),%eax
8010278e:	8b 40 18             	mov    0x18(%eax),%eax
80102791:	3b 45 10             	cmp    0x10(%ebp),%eax
80102794:	73 14                	jae    801027aa <writei+0x18d>
    ip->size = off;
80102796:	8b 45 08             	mov    0x8(%ebp),%eax
80102799:	8b 55 10             	mov    0x10(%ebp),%edx
8010279c:	89 50 18             	mov    %edx,0x18(%eax)
    iupdate(ip);
8010279f:	8b 45 08             	mov    0x8(%ebp),%eax
801027a2:	89 04 24             	mov    %eax,(%esp)
801027a5:	e8 56 f6 ff ff       	call   80101e00 <iupdate>
  }
  return n;
801027aa:	8b 45 14             	mov    0x14(%ebp),%eax
}
801027ad:	83 c4 24             	add    $0x24,%esp
801027b0:	5b                   	pop    %ebx
801027b1:	5d                   	pop    %ebp
801027b2:	c3                   	ret    

801027b3 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
801027b3:	55                   	push   %ebp
801027b4:	89 e5                	mov    %esp,%ebp
801027b6:	83 ec 18             	sub    $0x18,%esp
  return strncmp(s, t, DIRSIZ);
801027b9:	c7 44 24 08 0e 00 00 	movl   $0xe,0x8(%esp)
801027c0:	00 
801027c1:	8b 45 0c             	mov    0xc(%ebp),%eax
801027c4:	89 44 24 04          	mov    %eax,0x4(%esp)
801027c8:	8b 45 08             	mov    0x8(%ebp),%eax
801027cb:	89 04 24             	mov    %eax,(%esp)
801027ce:	e8 aa 36 00 00       	call   80105e7d <strncmp>
}
801027d3:	c9                   	leave  
801027d4:	c3                   	ret    

801027d5 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
801027d5:	55                   	push   %ebp
801027d6:	89 e5                	mov    %esp,%ebp
801027d8:	83 ec 38             	sub    $0x38,%esp
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
801027db:	8b 45 08             	mov    0x8(%ebp),%eax
801027de:	0f b7 40 10          	movzwl 0x10(%eax),%eax
801027e2:	66 83 f8 01          	cmp    $0x1,%ax
801027e6:	74 0c                	je     801027f4 <dirlookup+0x1f>
    panic("dirlookup not DIR");
801027e8:	c7 04 24 c9 94 10 80 	movl   $0x801094c9,(%esp)
801027ef:	e8 49 dd ff ff       	call   8010053d <panic>

  for(off = 0; off < dp->size; off += sizeof(de)){
801027f4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801027fb:	e9 87 00 00 00       	jmp    80102887 <dirlookup+0xb2>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102800:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
80102807:	00 
80102808:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010280b:	89 44 24 08          	mov    %eax,0x8(%esp)
8010280f:	8d 45 e0             	lea    -0x20(%ebp),%eax
80102812:	89 44 24 04          	mov    %eax,0x4(%esp)
80102816:	8b 45 08             	mov    0x8(%ebp),%eax
80102819:	89 04 24             	mov    %eax,(%esp)
8010281c:	e8 91 fc ff ff       	call   801024b2 <readi>
80102821:	83 f8 10             	cmp    $0x10,%eax
80102824:	74 0c                	je     80102832 <dirlookup+0x5d>
      panic("dirlink read");
80102826:	c7 04 24 db 94 10 80 	movl   $0x801094db,(%esp)
8010282d:	e8 0b dd ff ff       	call   8010053d <panic>
    if(de.inum == 0)
80102832:	0f b7 45 e0          	movzwl -0x20(%ebp),%eax
80102836:	66 85 c0             	test   %ax,%ax
80102839:	74 47                	je     80102882 <dirlookup+0xad>
      continue;
    if(namecmp(name, de.name) == 0){
8010283b:	8d 45 e0             	lea    -0x20(%ebp),%eax
8010283e:	83 c0 02             	add    $0x2,%eax
80102841:	89 44 24 04          	mov    %eax,0x4(%esp)
80102845:	8b 45 0c             	mov    0xc(%ebp),%eax
80102848:	89 04 24             	mov    %eax,(%esp)
8010284b:	e8 63 ff ff ff       	call   801027b3 <namecmp>
80102850:	85 c0                	test   %eax,%eax
80102852:	75 2f                	jne    80102883 <dirlookup+0xae>
      // entry matches path element
      if(poff)
80102854:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80102858:	74 08                	je     80102862 <dirlookup+0x8d>
        *poff = off;
8010285a:	8b 45 10             	mov    0x10(%ebp),%eax
8010285d:	8b 55 f4             	mov    -0xc(%ebp),%edx
80102860:	89 10                	mov    %edx,(%eax)
      inum = de.inum;
80102862:	0f b7 45 e0          	movzwl -0x20(%ebp),%eax
80102866:	0f b7 c0             	movzwl %ax,%eax
80102869:	89 45 f0             	mov    %eax,-0x10(%ebp)
      return iget(dp->dev, inum);
8010286c:	8b 45 08             	mov    0x8(%ebp),%eax
8010286f:	8b 00                	mov    (%eax),%eax
80102871:	8b 55 f0             	mov    -0x10(%ebp),%edx
80102874:	89 54 24 04          	mov    %edx,0x4(%esp)
80102878:	89 04 24             	mov    %eax,(%esp)
8010287b:	e8 38 f6 ff ff       	call   80101eb8 <iget>
80102880:	eb 19                	jmp    8010289b <dirlookup+0xc6>

  for(off = 0; off < dp->size; off += sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("dirlink read");
    if(de.inum == 0)
      continue;
80102882:	90                   	nop
  struct dirent de;

  if(dp->type != T_DIR)
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
80102883:	83 45 f4 10          	addl   $0x10,-0xc(%ebp)
80102887:	8b 45 08             	mov    0x8(%ebp),%eax
8010288a:	8b 40 18             	mov    0x18(%eax),%eax
8010288d:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80102890:	0f 87 6a ff ff ff    	ja     80102800 <dirlookup+0x2b>
      inum = de.inum;
      return iget(dp->dev, inum);
    }
  }

  return 0;
80102896:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010289b:	c9                   	leave  
8010289c:	c3                   	ret    

8010289d <dirlink>:

// Write a new directory entry (name, inum) into the directory dp.
int
dirlink(struct inode *dp, char *name, uint inum)
{
8010289d:	55                   	push   %ebp
8010289e:	89 e5                	mov    %esp,%ebp
801028a0:	83 ec 38             	sub    $0x38,%esp
  int off;
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
801028a3:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
801028aa:	00 
801028ab:	8b 45 0c             	mov    0xc(%ebp),%eax
801028ae:	89 44 24 04          	mov    %eax,0x4(%esp)
801028b2:	8b 45 08             	mov    0x8(%ebp),%eax
801028b5:	89 04 24             	mov    %eax,(%esp)
801028b8:	e8 18 ff ff ff       	call   801027d5 <dirlookup>
801028bd:	89 45 f0             	mov    %eax,-0x10(%ebp)
801028c0:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801028c4:	74 15                	je     801028db <dirlink+0x3e>
    iput(ip);
801028c6:	8b 45 f0             	mov    -0x10(%ebp),%eax
801028c9:	89 04 24             	mov    %eax,(%esp)
801028cc:	e8 9e f8 ff ff       	call   8010216f <iput>
    return -1;
801028d1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801028d6:	e9 b8 00 00 00       	jmp    80102993 <dirlink+0xf6>
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
801028db:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801028e2:	eb 44                	jmp    80102928 <dirlink+0x8b>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801028e4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801028e7:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
801028ee:	00 
801028ef:	89 44 24 08          	mov    %eax,0x8(%esp)
801028f3:	8d 45 e0             	lea    -0x20(%ebp),%eax
801028f6:	89 44 24 04          	mov    %eax,0x4(%esp)
801028fa:	8b 45 08             	mov    0x8(%ebp),%eax
801028fd:	89 04 24             	mov    %eax,(%esp)
80102900:	e8 ad fb ff ff       	call   801024b2 <readi>
80102905:	83 f8 10             	cmp    $0x10,%eax
80102908:	74 0c                	je     80102916 <dirlink+0x79>
      panic("dirlink read");
8010290a:	c7 04 24 db 94 10 80 	movl   $0x801094db,(%esp)
80102911:	e8 27 dc ff ff       	call   8010053d <panic>
    if(de.inum == 0)
80102916:	0f b7 45 e0          	movzwl -0x20(%ebp),%eax
8010291a:	66 85 c0             	test   %ax,%ax
8010291d:	74 18                	je     80102937 <dirlink+0x9a>
    iput(ip);
    return -1;
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
8010291f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102922:	83 c0 10             	add    $0x10,%eax
80102925:	89 45 f4             	mov    %eax,-0xc(%ebp)
80102928:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010292b:	8b 45 08             	mov    0x8(%ebp),%eax
8010292e:	8b 40 18             	mov    0x18(%eax),%eax
80102931:	39 c2                	cmp    %eax,%edx
80102933:	72 af                	jb     801028e4 <dirlink+0x47>
80102935:	eb 01                	jmp    80102938 <dirlink+0x9b>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("dirlink read");
    if(de.inum == 0)
      break;
80102937:	90                   	nop
  }

  strncpy(de.name, name, DIRSIZ);
80102938:	c7 44 24 08 0e 00 00 	movl   $0xe,0x8(%esp)
8010293f:	00 
80102940:	8b 45 0c             	mov    0xc(%ebp),%eax
80102943:	89 44 24 04          	mov    %eax,0x4(%esp)
80102947:	8d 45 e0             	lea    -0x20(%ebp),%eax
8010294a:	83 c0 02             	add    $0x2,%eax
8010294d:	89 04 24             	mov    %eax,(%esp)
80102950:	e8 80 35 00 00       	call   80105ed5 <strncpy>
  de.inum = inum;
80102955:	8b 45 10             	mov    0x10(%ebp),%eax
80102958:	66 89 45 e0          	mov    %ax,-0x20(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
8010295c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010295f:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
80102966:	00 
80102967:	89 44 24 08          	mov    %eax,0x8(%esp)
8010296b:	8d 45 e0             	lea    -0x20(%ebp),%eax
8010296e:	89 44 24 04          	mov    %eax,0x4(%esp)
80102972:	8b 45 08             	mov    0x8(%ebp),%eax
80102975:	89 04 24             	mov    %eax,(%esp)
80102978:	e8 a0 fc ff ff       	call   8010261d <writei>
8010297d:	83 f8 10             	cmp    $0x10,%eax
80102980:	74 0c                	je     8010298e <dirlink+0xf1>
    panic("dirlink");
80102982:	c7 04 24 e8 94 10 80 	movl   $0x801094e8,(%esp)
80102989:	e8 af db ff ff       	call   8010053d <panic>
  
  return 0;
8010298e:	b8 00 00 00 00       	mov    $0x0,%eax
}
80102993:	c9                   	leave  
80102994:	c3                   	ret    

80102995 <skipelem>:
//   skipelem("a", name) = "", setting name = "a"
//   skipelem("", name) = skipelem("////", name) = 0
//
static char*
skipelem(char *path, char *name)
{
80102995:	55                   	push   %ebp
80102996:	89 e5                	mov    %esp,%ebp
80102998:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int len;

  while(*path == '/')
8010299b:	eb 04                	jmp    801029a1 <skipelem+0xc>
    path++;
8010299d:	83 45 08 01          	addl   $0x1,0x8(%ebp)
skipelem(char *path, char *name)
{
  char *s;
  int len;

  while(*path == '/')
801029a1:	8b 45 08             	mov    0x8(%ebp),%eax
801029a4:	0f b6 00             	movzbl (%eax),%eax
801029a7:	3c 2f                	cmp    $0x2f,%al
801029a9:	74 f2                	je     8010299d <skipelem+0x8>
    path++;
  if(*path == 0)
801029ab:	8b 45 08             	mov    0x8(%ebp),%eax
801029ae:	0f b6 00             	movzbl (%eax),%eax
801029b1:	84 c0                	test   %al,%al
801029b3:	75 0a                	jne    801029bf <skipelem+0x2a>
    return 0;
801029b5:	b8 00 00 00 00       	mov    $0x0,%eax
801029ba:	e9 86 00 00 00       	jmp    80102a45 <skipelem+0xb0>
  s = path;
801029bf:	8b 45 08             	mov    0x8(%ebp),%eax
801029c2:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(*path != '/' && *path != 0)
801029c5:	eb 04                	jmp    801029cb <skipelem+0x36>
    path++;
801029c7:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  while(*path == '/')
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
801029cb:	8b 45 08             	mov    0x8(%ebp),%eax
801029ce:	0f b6 00             	movzbl (%eax),%eax
801029d1:	3c 2f                	cmp    $0x2f,%al
801029d3:	74 0a                	je     801029df <skipelem+0x4a>
801029d5:	8b 45 08             	mov    0x8(%ebp),%eax
801029d8:	0f b6 00             	movzbl (%eax),%eax
801029db:	84 c0                	test   %al,%al
801029dd:	75 e8                	jne    801029c7 <skipelem+0x32>
    path++;
  len = path - s;
801029df:	8b 55 08             	mov    0x8(%ebp),%edx
801029e2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801029e5:	89 d1                	mov    %edx,%ecx
801029e7:	29 c1                	sub    %eax,%ecx
801029e9:	89 c8                	mov    %ecx,%eax
801029eb:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(len >= DIRSIZ)
801029ee:	83 7d f0 0d          	cmpl   $0xd,-0x10(%ebp)
801029f2:	7e 1c                	jle    80102a10 <skipelem+0x7b>
    memmove(name, s, DIRSIZ);
801029f4:	c7 44 24 08 0e 00 00 	movl   $0xe,0x8(%esp)
801029fb:	00 
801029fc:	8b 45 f4             	mov    -0xc(%ebp),%eax
801029ff:	89 44 24 04          	mov    %eax,0x4(%esp)
80102a03:	8b 45 0c             	mov    0xc(%ebp),%eax
80102a06:	89 04 24             	mov    %eax,(%esp)
80102a09:	e8 cb 33 00 00       	call   80105dd9 <memmove>
  else {
    memmove(name, s, len);
    name[len] = 0;
  }
  while(*path == '/')
80102a0e:	eb 28                	jmp    80102a38 <skipelem+0xa3>
    path++;
  len = path - s;
  if(len >= DIRSIZ)
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
80102a10:	8b 45 f0             	mov    -0x10(%ebp),%eax
80102a13:	89 44 24 08          	mov    %eax,0x8(%esp)
80102a17:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102a1a:	89 44 24 04          	mov    %eax,0x4(%esp)
80102a1e:	8b 45 0c             	mov    0xc(%ebp),%eax
80102a21:	89 04 24             	mov    %eax,(%esp)
80102a24:	e8 b0 33 00 00       	call   80105dd9 <memmove>
    name[len] = 0;
80102a29:	8b 45 f0             	mov    -0x10(%ebp),%eax
80102a2c:	03 45 0c             	add    0xc(%ebp),%eax
80102a2f:	c6 00 00             	movb   $0x0,(%eax)
  }
  while(*path == '/')
80102a32:	eb 04                	jmp    80102a38 <skipelem+0xa3>
    path++;
80102a34:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
    name[len] = 0;
  }
  while(*path == '/')
80102a38:	8b 45 08             	mov    0x8(%ebp),%eax
80102a3b:	0f b6 00             	movzbl (%eax),%eax
80102a3e:	3c 2f                	cmp    $0x2f,%al
80102a40:	74 f2                	je     80102a34 <skipelem+0x9f>
    path++;
  return path;
80102a42:	8b 45 08             	mov    0x8(%ebp),%eax
}
80102a45:	c9                   	leave  
80102a46:	c3                   	ret    

80102a47 <namex>:
// Look up and return the inode for a path name.
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80102a47:	55                   	push   %ebp
80102a48:	89 e5                	mov    %esp,%ebp
80102a4a:	83 ec 28             	sub    $0x28,%esp
  struct inode *ip, *next;

  if(*path == '/')
80102a4d:	8b 45 08             	mov    0x8(%ebp),%eax
80102a50:	0f b6 00             	movzbl (%eax),%eax
80102a53:	3c 2f                	cmp    $0x2f,%al
80102a55:	75 1c                	jne    80102a73 <namex+0x2c>
    ip = iget(ROOTDEV, ROOTINO);
80102a57:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
80102a5e:	00 
80102a5f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80102a66:	e8 4d f4 ff ff       	call   80101eb8 <iget>
80102a6b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  else
    ip = idup(proc->cwd);

  while((path = skipelem(path, name)) != 0){
80102a6e:	e9 af 00 00 00       	jmp    80102b22 <namex+0xdb>
  struct inode *ip, *next;

  if(*path == '/')
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(proc->cwd);
80102a73:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80102a79:	8b 40 68             	mov    0x68(%eax),%eax
80102a7c:	89 04 24             	mov    %eax,(%esp)
80102a7f:	e8 06 f5 ff ff       	call   80101f8a <idup>
80102a84:	89 45 f4             	mov    %eax,-0xc(%ebp)

  while((path = skipelem(path, name)) != 0){
80102a87:	e9 96 00 00 00       	jmp    80102b22 <namex+0xdb>
    ilock(ip);
80102a8c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102a8f:	89 04 24             	mov    %eax,(%esp)
80102a92:	e8 25 f5 ff ff       	call   80101fbc <ilock>
    if(ip->type != T_DIR){
80102a97:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102a9a:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80102a9e:	66 83 f8 01          	cmp    $0x1,%ax
80102aa2:	74 15                	je     80102ab9 <namex+0x72>
      iunlockput(ip);
80102aa4:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102aa7:	89 04 24             	mov    %eax,(%esp)
80102aaa:	e8 91 f7 ff ff       	call   80102240 <iunlockput>
      return 0;
80102aaf:	b8 00 00 00 00       	mov    $0x0,%eax
80102ab4:	e9 a3 00 00 00       	jmp    80102b5c <namex+0x115>
    }
    if(nameiparent && *path == '\0'){
80102ab9:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
80102abd:	74 1d                	je     80102adc <namex+0x95>
80102abf:	8b 45 08             	mov    0x8(%ebp),%eax
80102ac2:	0f b6 00             	movzbl (%eax),%eax
80102ac5:	84 c0                	test   %al,%al
80102ac7:	75 13                	jne    80102adc <namex+0x95>
      // Stop one level early.
      iunlock(ip);
80102ac9:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102acc:	89 04 24             	mov    %eax,(%esp)
80102acf:	e8 36 f6 ff ff       	call   8010210a <iunlock>
      return ip;
80102ad4:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102ad7:	e9 80 00 00 00       	jmp    80102b5c <namex+0x115>
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80102adc:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
80102ae3:	00 
80102ae4:	8b 45 10             	mov    0x10(%ebp),%eax
80102ae7:	89 44 24 04          	mov    %eax,0x4(%esp)
80102aeb:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102aee:	89 04 24             	mov    %eax,(%esp)
80102af1:	e8 df fc ff ff       	call   801027d5 <dirlookup>
80102af6:	89 45 f0             	mov    %eax,-0x10(%ebp)
80102af9:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80102afd:	75 12                	jne    80102b11 <namex+0xca>
      iunlockput(ip);
80102aff:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102b02:	89 04 24             	mov    %eax,(%esp)
80102b05:	e8 36 f7 ff ff       	call   80102240 <iunlockput>
      return 0;
80102b0a:	b8 00 00 00 00       	mov    $0x0,%eax
80102b0f:	eb 4b                	jmp    80102b5c <namex+0x115>
    }
    iunlockput(ip);
80102b11:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102b14:	89 04 24             	mov    %eax,(%esp)
80102b17:	e8 24 f7 ff ff       	call   80102240 <iunlockput>
    ip = next;
80102b1c:	8b 45 f0             	mov    -0x10(%ebp),%eax
80102b1f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(*path == '/')
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(proc->cwd);

  while((path = skipelem(path, name)) != 0){
80102b22:	8b 45 10             	mov    0x10(%ebp),%eax
80102b25:	89 44 24 04          	mov    %eax,0x4(%esp)
80102b29:	8b 45 08             	mov    0x8(%ebp),%eax
80102b2c:	89 04 24             	mov    %eax,(%esp)
80102b2f:	e8 61 fe ff ff       	call   80102995 <skipelem>
80102b34:	89 45 08             	mov    %eax,0x8(%ebp)
80102b37:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80102b3b:	0f 85 4b ff ff ff    	jne    80102a8c <namex+0x45>
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
80102b41:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
80102b45:	74 12                	je     80102b59 <namex+0x112>
    iput(ip);
80102b47:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102b4a:	89 04 24             	mov    %eax,(%esp)
80102b4d:	e8 1d f6 ff ff       	call   8010216f <iput>
    return 0;
80102b52:	b8 00 00 00 00       	mov    $0x0,%eax
80102b57:	eb 03                	jmp    80102b5c <namex+0x115>
  }
  return ip;
80102b59:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80102b5c:	c9                   	leave  
80102b5d:	c3                   	ret    

80102b5e <namei>:

struct inode*
namei(char *path)
{
80102b5e:	55                   	push   %ebp
80102b5f:	89 e5                	mov    %esp,%ebp
80102b61:	83 ec 28             	sub    $0x28,%esp
  char name[DIRSIZ];
  return namex(path, 0, name);
80102b64:	8d 45 ea             	lea    -0x16(%ebp),%eax
80102b67:	89 44 24 08          	mov    %eax,0x8(%esp)
80102b6b:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80102b72:	00 
80102b73:	8b 45 08             	mov    0x8(%ebp),%eax
80102b76:	89 04 24             	mov    %eax,(%esp)
80102b79:	e8 c9 fe ff ff       	call   80102a47 <namex>
}
80102b7e:	c9                   	leave  
80102b7f:	c3                   	ret    

80102b80 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
80102b80:	55                   	push   %ebp
80102b81:	89 e5                	mov    %esp,%ebp
80102b83:	83 ec 18             	sub    $0x18,%esp
  return namex(path, 1, name);
80102b86:	8b 45 0c             	mov    0xc(%ebp),%eax
80102b89:	89 44 24 08          	mov    %eax,0x8(%esp)
80102b8d:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
80102b94:	00 
80102b95:	8b 45 08             	mov    0x8(%ebp),%eax
80102b98:	89 04 24             	mov    %eax,(%esp)
80102b9b:	e8 a7 fe ff ff       	call   80102a47 <namex>
}
80102ba0:	c9                   	leave  
80102ba1:	c3                   	ret    
	...

80102ba4 <inb>:
// Routines to let C code use special x86 instructions.

static inline uchar
inb(ushort port)
{
80102ba4:	55                   	push   %ebp
80102ba5:	89 e5                	mov    %esp,%ebp
80102ba7:	53                   	push   %ebx
80102ba8:	83 ec 14             	sub    $0x14,%esp
80102bab:	8b 45 08             	mov    0x8(%ebp),%eax
80102bae:	66 89 45 e8          	mov    %ax,-0x18(%ebp)
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102bb2:	0f b7 55 e8          	movzwl -0x18(%ebp),%edx
80102bb6:	66 89 55 ea          	mov    %dx,-0x16(%ebp)
80102bba:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
80102bbe:	ec                   	in     (%dx),%al
80102bbf:	89 c3                	mov    %eax,%ebx
80102bc1:	88 5d fb             	mov    %bl,-0x5(%ebp)
  return data;
80102bc4:	0f b6 45 fb          	movzbl -0x5(%ebp),%eax
}
80102bc8:	83 c4 14             	add    $0x14,%esp
80102bcb:	5b                   	pop    %ebx
80102bcc:	5d                   	pop    %ebp
80102bcd:	c3                   	ret    

80102bce <insl>:

static inline void
insl(int port, void *addr, int cnt)
{
80102bce:	55                   	push   %ebp
80102bcf:	89 e5                	mov    %esp,%ebp
80102bd1:	57                   	push   %edi
80102bd2:	53                   	push   %ebx
  asm volatile("cld; rep insl" :
80102bd3:	8b 55 08             	mov    0x8(%ebp),%edx
80102bd6:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80102bd9:	8b 45 10             	mov    0x10(%ebp),%eax
80102bdc:	89 cb                	mov    %ecx,%ebx
80102bde:	89 df                	mov    %ebx,%edi
80102be0:	89 c1                	mov    %eax,%ecx
80102be2:	fc                   	cld    
80102be3:	f3 6d                	rep insl (%dx),%es:(%edi)
80102be5:	89 c8                	mov    %ecx,%eax
80102be7:	89 fb                	mov    %edi,%ebx
80102be9:	89 5d 0c             	mov    %ebx,0xc(%ebp)
80102bec:	89 45 10             	mov    %eax,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "d" (port), "0" (addr), "1" (cnt) :
               "memory", "cc");
}
80102bef:	5b                   	pop    %ebx
80102bf0:	5f                   	pop    %edi
80102bf1:	5d                   	pop    %ebp
80102bf2:	c3                   	ret    

80102bf3 <outb>:

static inline void
outb(ushort port, uchar data)
{
80102bf3:	55                   	push   %ebp
80102bf4:	89 e5                	mov    %esp,%ebp
80102bf6:	83 ec 08             	sub    $0x8,%esp
80102bf9:	8b 55 08             	mov    0x8(%ebp),%edx
80102bfc:	8b 45 0c             	mov    0xc(%ebp),%eax
80102bff:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
80102c03:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102c06:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80102c0a:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
80102c0e:	ee                   	out    %al,(%dx)
}
80102c0f:	c9                   	leave  
80102c10:	c3                   	ret    

80102c11 <outsl>:
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
}

static inline void
outsl(int port, const void *addr, int cnt)
{
80102c11:	55                   	push   %ebp
80102c12:	89 e5                	mov    %esp,%ebp
80102c14:	56                   	push   %esi
80102c15:	53                   	push   %ebx
  asm volatile("cld; rep outsl" :
80102c16:	8b 55 08             	mov    0x8(%ebp),%edx
80102c19:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80102c1c:	8b 45 10             	mov    0x10(%ebp),%eax
80102c1f:	89 cb                	mov    %ecx,%ebx
80102c21:	89 de                	mov    %ebx,%esi
80102c23:	89 c1                	mov    %eax,%ecx
80102c25:	fc                   	cld    
80102c26:	f3 6f                	rep outsl %ds:(%esi),(%dx)
80102c28:	89 c8                	mov    %ecx,%eax
80102c2a:	89 f3                	mov    %esi,%ebx
80102c2c:	89 5d 0c             	mov    %ebx,0xc(%ebp)
80102c2f:	89 45 10             	mov    %eax,0x10(%ebp)
               "=S" (addr), "=c" (cnt) :
               "d" (port), "0" (addr), "1" (cnt) :
               "cc");
}
80102c32:	5b                   	pop    %ebx
80102c33:	5e                   	pop    %esi
80102c34:	5d                   	pop    %ebp
80102c35:	c3                   	ret    

80102c36 <idewait>:
static void idestart(struct buf*);

// Wait for IDE disk to become ready.
static int
idewait(int checkerr)
{
80102c36:	55                   	push   %ebp
80102c37:	89 e5                	mov    %esp,%ebp
80102c39:	83 ec 14             	sub    $0x14,%esp
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY) 
80102c3c:	90                   	nop
80102c3d:	c7 04 24 f7 01 00 00 	movl   $0x1f7,(%esp)
80102c44:	e8 5b ff ff ff       	call   80102ba4 <inb>
80102c49:	0f b6 c0             	movzbl %al,%eax
80102c4c:	89 45 fc             	mov    %eax,-0x4(%ebp)
80102c4f:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102c52:	25 c0 00 00 00       	and    $0xc0,%eax
80102c57:	83 f8 40             	cmp    $0x40,%eax
80102c5a:	75 e1                	jne    80102c3d <idewait+0x7>
    ;
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
80102c5c:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80102c60:	74 11                	je     80102c73 <idewait+0x3d>
80102c62:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102c65:	83 e0 21             	and    $0x21,%eax
80102c68:	85 c0                	test   %eax,%eax
80102c6a:	74 07                	je     80102c73 <idewait+0x3d>
    return -1;
80102c6c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102c71:	eb 05                	jmp    80102c78 <idewait+0x42>
  return 0;
80102c73:	b8 00 00 00 00       	mov    $0x0,%eax
}
80102c78:	c9                   	leave  
80102c79:	c3                   	ret    

80102c7a <ideinit>:

void
ideinit(void)
{
80102c7a:	55                   	push   %ebp
80102c7b:	89 e5                	mov    %esp,%ebp
80102c7d:	83 ec 28             	sub    $0x28,%esp
  int i;

  initlock(&idelock, "ide");
80102c80:	c7 44 24 04 f0 94 10 	movl   $0x801094f0,0x4(%esp)
80102c87:	80 
80102c88:	c7 04 24 40 cb 10 80 	movl   $0x8010cb40,(%esp)
80102c8f:	e8 02 2e 00 00       	call   80105a96 <initlock>
  picenable(IRQ_IDE);
80102c94:	c7 04 24 0e 00 00 00 	movl   $0xe,(%esp)
80102c9b:	e8 75 15 00 00       	call   80104215 <picenable>
  ioapicenable(IRQ_IDE, ncpu - 1);
80102ca0:	a1 60 1e 11 80       	mov    0x80111e60,%eax
80102ca5:	83 e8 01             	sub    $0x1,%eax
80102ca8:	89 44 24 04          	mov    %eax,0x4(%esp)
80102cac:	c7 04 24 0e 00 00 00 	movl   $0xe,(%esp)
80102cb3:	e8 12 04 00 00       	call   801030ca <ioapicenable>
  idewait(0);
80102cb8:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80102cbf:	e8 72 ff ff ff       	call   80102c36 <idewait>
  
  // Check if disk 1 is present
  outb(0x1f6, 0xe0 | (1<<4));
80102cc4:	c7 44 24 04 f0 00 00 	movl   $0xf0,0x4(%esp)
80102ccb:	00 
80102ccc:	c7 04 24 f6 01 00 00 	movl   $0x1f6,(%esp)
80102cd3:	e8 1b ff ff ff       	call   80102bf3 <outb>
  for(i=0; i<1000; i++){
80102cd8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80102cdf:	eb 20                	jmp    80102d01 <ideinit+0x87>
    if(inb(0x1f7) != 0){
80102ce1:	c7 04 24 f7 01 00 00 	movl   $0x1f7,(%esp)
80102ce8:	e8 b7 fe ff ff       	call   80102ba4 <inb>
80102ced:	84 c0                	test   %al,%al
80102cef:	74 0c                	je     80102cfd <ideinit+0x83>
      havedisk1 = 1;
80102cf1:	c7 05 78 cb 10 80 01 	movl   $0x1,0x8010cb78
80102cf8:	00 00 00 
      break;
80102cfb:	eb 0d                	jmp    80102d0a <ideinit+0x90>
  ioapicenable(IRQ_IDE, ncpu - 1);
  idewait(0);
  
  // Check if disk 1 is present
  outb(0x1f6, 0xe0 | (1<<4));
  for(i=0; i<1000; i++){
80102cfd:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80102d01:	81 7d f4 e7 03 00 00 	cmpl   $0x3e7,-0xc(%ebp)
80102d08:	7e d7                	jle    80102ce1 <ideinit+0x67>
      break;
    }
  }
  
  // Switch back to disk 0.
  outb(0x1f6, 0xe0 | (0<<4));
80102d0a:	c7 44 24 04 e0 00 00 	movl   $0xe0,0x4(%esp)
80102d11:	00 
80102d12:	c7 04 24 f6 01 00 00 	movl   $0x1f6,(%esp)
80102d19:	e8 d5 fe ff ff       	call   80102bf3 <outb>
}
80102d1e:	c9                   	leave  
80102d1f:	c3                   	ret    

80102d20 <idestart>:

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80102d20:	55                   	push   %ebp
80102d21:	89 e5                	mov    %esp,%ebp
80102d23:	83 ec 18             	sub    $0x18,%esp
  if(b == 0)
80102d26:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80102d2a:	75 0c                	jne    80102d38 <idestart+0x18>
    panic("idestart");
80102d2c:	c7 04 24 f4 94 10 80 	movl   $0x801094f4,(%esp)
80102d33:	e8 05 d8 ff ff       	call   8010053d <panic>

  idewait(0);
80102d38:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80102d3f:	e8 f2 fe ff ff       	call   80102c36 <idewait>
  outb(0x3f6, 0);  // generate interrupt
80102d44:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80102d4b:	00 
80102d4c:	c7 04 24 f6 03 00 00 	movl   $0x3f6,(%esp)
80102d53:	e8 9b fe ff ff       	call   80102bf3 <outb>
  outb(0x1f2, 1);  // number of sectors
80102d58:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
80102d5f:	00 
80102d60:	c7 04 24 f2 01 00 00 	movl   $0x1f2,(%esp)
80102d67:	e8 87 fe ff ff       	call   80102bf3 <outb>
  outb(0x1f3, b->sector & 0xff);
80102d6c:	8b 45 08             	mov    0x8(%ebp),%eax
80102d6f:	8b 40 08             	mov    0x8(%eax),%eax
80102d72:	0f b6 c0             	movzbl %al,%eax
80102d75:	89 44 24 04          	mov    %eax,0x4(%esp)
80102d79:	c7 04 24 f3 01 00 00 	movl   $0x1f3,(%esp)
80102d80:	e8 6e fe ff ff       	call   80102bf3 <outb>
  outb(0x1f4, (b->sector >> 8) & 0xff);
80102d85:	8b 45 08             	mov    0x8(%ebp),%eax
80102d88:	8b 40 08             	mov    0x8(%eax),%eax
80102d8b:	c1 e8 08             	shr    $0x8,%eax
80102d8e:	0f b6 c0             	movzbl %al,%eax
80102d91:	89 44 24 04          	mov    %eax,0x4(%esp)
80102d95:	c7 04 24 f4 01 00 00 	movl   $0x1f4,(%esp)
80102d9c:	e8 52 fe ff ff       	call   80102bf3 <outb>
  outb(0x1f5, (b->sector >> 16) & 0xff);
80102da1:	8b 45 08             	mov    0x8(%ebp),%eax
80102da4:	8b 40 08             	mov    0x8(%eax),%eax
80102da7:	c1 e8 10             	shr    $0x10,%eax
80102daa:	0f b6 c0             	movzbl %al,%eax
80102dad:	89 44 24 04          	mov    %eax,0x4(%esp)
80102db1:	c7 04 24 f5 01 00 00 	movl   $0x1f5,(%esp)
80102db8:	e8 36 fe ff ff       	call   80102bf3 <outb>
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((b->sector>>24)&0x0f));
80102dbd:	8b 45 08             	mov    0x8(%ebp),%eax
80102dc0:	8b 40 04             	mov    0x4(%eax),%eax
80102dc3:	83 e0 01             	and    $0x1,%eax
80102dc6:	89 c2                	mov    %eax,%edx
80102dc8:	c1 e2 04             	shl    $0x4,%edx
80102dcb:	8b 45 08             	mov    0x8(%ebp),%eax
80102dce:	8b 40 08             	mov    0x8(%eax),%eax
80102dd1:	c1 e8 18             	shr    $0x18,%eax
80102dd4:	83 e0 0f             	and    $0xf,%eax
80102dd7:	09 d0                	or     %edx,%eax
80102dd9:	83 c8 e0             	or     $0xffffffe0,%eax
80102ddc:	0f b6 c0             	movzbl %al,%eax
80102ddf:	89 44 24 04          	mov    %eax,0x4(%esp)
80102de3:	c7 04 24 f6 01 00 00 	movl   $0x1f6,(%esp)
80102dea:	e8 04 fe ff ff       	call   80102bf3 <outb>
  if(b->flags & B_DIRTY){
80102def:	8b 45 08             	mov    0x8(%ebp),%eax
80102df2:	8b 00                	mov    (%eax),%eax
80102df4:	83 e0 04             	and    $0x4,%eax
80102df7:	85 c0                	test   %eax,%eax
80102df9:	74 34                	je     80102e2f <idestart+0x10f>
    outb(0x1f7, IDE_CMD_WRITE);
80102dfb:	c7 44 24 04 30 00 00 	movl   $0x30,0x4(%esp)
80102e02:	00 
80102e03:	c7 04 24 f7 01 00 00 	movl   $0x1f7,(%esp)
80102e0a:	e8 e4 fd ff ff       	call   80102bf3 <outb>
    outsl(0x1f0, b->data, 512/4);
80102e0f:	8b 45 08             	mov    0x8(%ebp),%eax
80102e12:	83 c0 18             	add    $0x18,%eax
80102e15:	c7 44 24 08 80 00 00 	movl   $0x80,0x8(%esp)
80102e1c:	00 
80102e1d:	89 44 24 04          	mov    %eax,0x4(%esp)
80102e21:	c7 04 24 f0 01 00 00 	movl   $0x1f0,(%esp)
80102e28:	e8 e4 fd ff ff       	call   80102c11 <outsl>
80102e2d:	eb 14                	jmp    80102e43 <idestart+0x123>
  } else {
    outb(0x1f7, IDE_CMD_READ);
80102e2f:	c7 44 24 04 20 00 00 	movl   $0x20,0x4(%esp)
80102e36:	00 
80102e37:	c7 04 24 f7 01 00 00 	movl   $0x1f7,(%esp)
80102e3e:	e8 b0 fd ff ff       	call   80102bf3 <outb>
  }
}
80102e43:	c9                   	leave  
80102e44:	c3                   	ret    

80102e45 <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
80102e45:	55                   	push   %ebp
80102e46:	89 e5                	mov    %esp,%ebp
80102e48:	83 ec 28             	sub    $0x28,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
80102e4b:	c7 04 24 40 cb 10 80 	movl   $0x8010cb40,(%esp)
80102e52:	e8 60 2c 00 00       	call   80105ab7 <acquire>
  if((b = idequeue) == 0){
80102e57:	a1 74 cb 10 80       	mov    0x8010cb74,%eax
80102e5c:	89 45 f4             	mov    %eax,-0xc(%ebp)
80102e5f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80102e63:	75 11                	jne    80102e76 <ideintr+0x31>
    release(&idelock);
80102e65:	c7 04 24 40 cb 10 80 	movl   $0x8010cb40,(%esp)
80102e6c:	e8 a8 2c 00 00       	call   80105b19 <release>
    // cprintf("spurious IDE interrupt\n");
    return;
80102e71:	e9 90 00 00 00       	jmp    80102f06 <ideintr+0xc1>
  }
  idequeue = b->qnext;
80102e76:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102e79:	8b 40 14             	mov    0x14(%eax),%eax
80102e7c:	a3 74 cb 10 80       	mov    %eax,0x8010cb74

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
80102e81:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102e84:	8b 00                	mov    (%eax),%eax
80102e86:	83 e0 04             	and    $0x4,%eax
80102e89:	85 c0                	test   %eax,%eax
80102e8b:	75 2e                	jne    80102ebb <ideintr+0x76>
80102e8d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80102e94:	e8 9d fd ff ff       	call   80102c36 <idewait>
80102e99:	85 c0                	test   %eax,%eax
80102e9b:	78 1e                	js     80102ebb <ideintr+0x76>
    insl(0x1f0, b->data, 512/4);
80102e9d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102ea0:	83 c0 18             	add    $0x18,%eax
80102ea3:	c7 44 24 08 80 00 00 	movl   $0x80,0x8(%esp)
80102eaa:	00 
80102eab:	89 44 24 04          	mov    %eax,0x4(%esp)
80102eaf:	c7 04 24 f0 01 00 00 	movl   $0x1f0,(%esp)
80102eb6:	e8 13 fd ff ff       	call   80102bce <insl>
  
  // Wake process waiting for this buf.
  b->flags |= B_VALID;
80102ebb:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102ebe:	8b 00                	mov    (%eax),%eax
80102ec0:	89 c2                	mov    %eax,%edx
80102ec2:	83 ca 02             	or     $0x2,%edx
80102ec5:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102ec8:	89 10                	mov    %edx,(%eax)
  b->flags &= ~B_DIRTY;
80102eca:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102ecd:	8b 00                	mov    (%eax),%eax
80102ecf:	89 c2                	mov    %eax,%edx
80102ed1:	83 e2 fb             	and    $0xfffffffb,%edx
80102ed4:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102ed7:	89 10                	mov    %edx,(%eax)
  wakeup(b);
80102ed9:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102edc:	89 04 24             	mov    %eax,(%esp)
80102edf:	e8 33 28 00 00       	call   80105717 <wakeup>
  
  // Start disk on next buf in queue.
  if(idequeue != 0)
80102ee4:	a1 74 cb 10 80       	mov    0x8010cb74,%eax
80102ee9:	85 c0                	test   %eax,%eax
80102eeb:	74 0d                	je     80102efa <ideintr+0xb5>
    idestart(idequeue);
80102eed:	a1 74 cb 10 80       	mov    0x8010cb74,%eax
80102ef2:	89 04 24             	mov    %eax,(%esp)
80102ef5:	e8 26 fe ff ff       	call   80102d20 <idestart>

  release(&idelock);
80102efa:	c7 04 24 40 cb 10 80 	movl   $0x8010cb40,(%esp)
80102f01:	e8 13 2c 00 00       	call   80105b19 <release>
}
80102f06:	c9                   	leave  
80102f07:	c3                   	ret    

80102f08 <iderw>:
// Sync buf with disk. 
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
80102f08:	55                   	push   %ebp
80102f09:	89 e5                	mov    %esp,%ebp
80102f0b:	83 ec 28             	sub    $0x28,%esp
  struct buf **pp;

  if(!(b->flags & B_BUSY))
80102f0e:	8b 45 08             	mov    0x8(%ebp),%eax
80102f11:	8b 00                	mov    (%eax),%eax
80102f13:	83 e0 01             	and    $0x1,%eax
80102f16:	85 c0                	test   %eax,%eax
80102f18:	75 0c                	jne    80102f26 <iderw+0x1e>
    panic("iderw: buf not busy");
80102f1a:	c7 04 24 fd 94 10 80 	movl   $0x801094fd,(%esp)
80102f21:	e8 17 d6 ff ff       	call   8010053d <panic>
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
80102f26:	8b 45 08             	mov    0x8(%ebp),%eax
80102f29:	8b 00                	mov    (%eax),%eax
80102f2b:	83 e0 06             	and    $0x6,%eax
80102f2e:	83 f8 02             	cmp    $0x2,%eax
80102f31:	75 0c                	jne    80102f3f <iderw+0x37>
    panic("iderw: nothing to do");
80102f33:	c7 04 24 11 95 10 80 	movl   $0x80109511,(%esp)
80102f3a:	e8 fe d5 ff ff       	call   8010053d <panic>
  if(b->dev != 0 && !havedisk1)
80102f3f:	8b 45 08             	mov    0x8(%ebp),%eax
80102f42:	8b 40 04             	mov    0x4(%eax),%eax
80102f45:	85 c0                	test   %eax,%eax
80102f47:	74 15                	je     80102f5e <iderw+0x56>
80102f49:	a1 78 cb 10 80       	mov    0x8010cb78,%eax
80102f4e:	85 c0                	test   %eax,%eax
80102f50:	75 0c                	jne    80102f5e <iderw+0x56>
    panic("iderw: ide disk 1 not present");
80102f52:	c7 04 24 26 95 10 80 	movl   $0x80109526,(%esp)
80102f59:	e8 df d5 ff ff       	call   8010053d <panic>

  acquire(&idelock);  //DOC: acquire-lock
80102f5e:	c7 04 24 40 cb 10 80 	movl   $0x8010cb40,(%esp)
80102f65:	e8 4d 2b 00 00       	call   80105ab7 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
80102f6a:	8b 45 08             	mov    0x8(%ebp),%eax
80102f6d:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC: insert-queue
80102f74:	c7 45 f4 74 cb 10 80 	movl   $0x8010cb74,-0xc(%ebp)
80102f7b:	eb 0b                	jmp    80102f88 <iderw+0x80>
80102f7d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102f80:	8b 00                	mov    (%eax),%eax
80102f82:	83 c0 14             	add    $0x14,%eax
80102f85:	89 45 f4             	mov    %eax,-0xc(%ebp)
80102f88:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102f8b:	8b 00                	mov    (%eax),%eax
80102f8d:	85 c0                	test   %eax,%eax
80102f8f:	75 ec                	jne    80102f7d <iderw+0x75>
    ;
  *pp = b;
80102f91:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102f94:	8b 55 08             	mov    0x8(%ebp),%edx
80102f97:	89 10                	mov    %edx,(%eax)
  
  // Start disk if necessary.
  if(idequeue == b)
80102f99:	a1 74 cb 10 80       	mov    0x8010cb74,%eax
80102f9e:	3b 45 08             	cmp    0x8(%ebp),%eax
80102fa1:	75 22                	jne    80102fc5 <iderw+0xbd>
    idestart(b);
80102fa3:	8b 45 08             	mov    0x8(%ebp),%eax
80102fa6:	89 04 24             	mov    %eax,(%esp)
80102fa9:	e8 72 fd ff ff       	call   80102d20 <idestart>
  
  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
80102fae:	eb 15                	jmp    80102fc5 <iderw+0xbd>
    sleep(b, &idelock);
80102fb0:	c7 44 24 04 40 cb 10 	movl   $0x8010cb40,0x4(%esp)
80102fb7:	80 
80102fb8:	8b 45 08             	mov    0x8(%ebp),%eax
80102fbb:	89 04 24             	mov    %eax,(%esp)
80102fbe:	e8 66 26 00 00       	call   80105629 <sleep>
80102fc3:	eb 01                	jmp    80102fc6 <iderw+0xbe>
  // Start disk if necessary.
  if(idequeue == b)
    idestart(b);
  
  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
80102fc5:	90                   	nop
80102fc6:	8b 45 08             	mov    0x8(%ebp),%eax
80102fc9:	8b 00                	mov    (%eax),%eax
80102fcb:	83 e0 06             	and    $0x6,%eax
80102fce:	83 f8 02             	cmp    $0x2,%eax
80102fd1:	75 dd                	jne    80102fb0 <iderw+0xa8>
    sleep(b, &idelock);
  }

  release(&idelock);
80102fd3:	c7 04 24 40 cb 10 80 	movl   $0x8010cb40,(%esp)
80102fda:	e8 3a 2b 00 00       	call   80105b19 <release>
}
80102fdf:	c9                   	leave  
80102fe0:	c3                   	ret    
80102fe1:	00 00                	add    %al,(%eax)
	...

80102fe4 <ioapicread>:
  uint data;
};

static uint
ioapicread(int reg)
{
80102fe4:	55                   	push   %ebp
80102fe5:	89 e5                	mov    %esp,%ebp
  ioapic->reg = reg;
80102fe7:	a1 94 17 11 80       	mov    0x80111794,%eax
80102fec:	8b 55 08             	mov    0x8(%ebp),%edx
80102fef:	89 10                	mov    %edx,(%eax)
  return ioapic->data;
80102ff1:	a1 94 17 11 80       	mov    0x80111794,%eax
80102ff6:	8b 40 10             	mov    0x10(%eax),%eax
}
80102ff9:	5d                   	pop    %ebp
80102ffa:	c3                   	ret    

80102ffb <ioapicwrite>:

static void
ioapicwrite(int reg, uint data)
{
80102ffb:	55                   	push   %ebp
80102ffc:	89 e5                	mov    %esp,%ebp
  ioapic->reg = reg;
80102ffe:	a1 94 17 11 80       	mov    0x80111794,%eax
80103003:	8b 55 08             	mov    0x8(%ebp),%edx
80103006:	89 10                	mov    %edx,(%eax)
  ioapic->data = data;
80103008:	a1 94 17 11 80       	mov    0x80111794,%eax
8010300d:	8b 55 0c             	mov    0xc(%ebp),%edx
80103010:	89 50 10             	mov    %edx,0x10(%eax)
}
80103013:	5d                   	pop    %ebp
80103014:	c3                   	ret    

80103015 <ioapicinit>:

void
ioapicinit(void)
{
80103015:	55                   	push   %ebp
80103016:	89 e5                	mov    %esp,%ebp
80103018:	83 ec 28             	sub    $0x28,%esp
  int i, id, maxintr;

  if(!ismp)
8010301b:	a1 64 18 11 80       	mov    0x80111864,%eax
80103020:	85 c0                	test   %eax,%eax
80103022:	0f 84 9f 00 00 00    	je     801030c7 <ioapicinit+0xb2>
    return;

  ioapic = (volatile struct ioapic*)IOAPIC;
80103028:	c7 05 94 17 11 80 00 	movl   $0xfec00000,0x80111794
8010302f:	00 c0 fe 
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
80103032:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80103039:	e8 a6 ff ff ff       	call   80102fe4 <ioapicread>
8010303e:	c1 e8 10             	shr    $0x10,%eax
80103041:	25 ff 00 00 00       	and    $0xff,%eax
80103046:	89 45 f0             	mov    %eax,-0x10(%ebp)
  id = ioapicread(REG_ID) >> 24;
80103049:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80103050:	e8 8f ff ff ff       	call   80102fe4 <ioapicread>
80103055:	c1 e8 18             	shr    $0x18,%eax
80103058:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if(id != ioapicid)
8010305b:	0f b6 05 60 18 11 80 	movzbl 0x80111860,%eax
80103062:	0f b6 c0             	movzbl %al,%eax
80103065:	3b 45 ec             	cmp    -0x14(%ebp),%eax
80103068:	74 0c                	je     80103076 <ioapicinit+0x61>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
8010306a:	c7 04 24 44 95 10 80 	movl   $0x80109544,(%esp)
80103071:	e8 2b d3 ff ff       	call   801003a1 <cprintf>

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
80103076:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010307d:	eb 3e                	jmp    801030bd <ioapicinit+0xa8>
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
8010307f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103082:	83 c0 20             	add    $0x20,%eax
80103085:	0d 00 00 01 00       	or     $0x10000,%eax
8010308a:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010308d:	83 c2 08             	add    $0x8,%edx
80103090:	01 d2                	add    %edx,%edx
80103092:	89 44 24 04          	mov    %eax,0x4(%esp)
80103096:	89 14 24             	mov    %edx,(%esp)
80103099:	e8 5d ff ff ff       	call   80102ffb <ioapicwrite>
    ioapicwrite(REG_TABLE+2*i+1, 0);
8010309e:	8b 45 f4             	mov    -0xc(%ebp),%eax
801030a1:	83 c0 08             	add    $0x8,%eax
801030a4:	01 c0                	add    %eax,%eax
801030a6:	83 c0 01             	add    $0x1,%eax
801030a9:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
801030b0:	00 
801030b1:	89 04 24             	mov    %eax,(%esp)
801030b4:	e8 42 ff ff ff       	call   80102ffb <ioapicwrite>
  if(id != ioapicid)
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
801030b9:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801030bd:	8b 45 f4             	mov    -0xc(%ebp),%eax
801030c0:	3b 45 f0             	cmp    -0x10(%ebp),%eax
801030c3:	7e ba                	jle    8010307f <ioapicinit+0x6a>
801030c5:	eb 01                	jmp    801030c8 <ioapicinit+0xb3>
ioapicinit(void)
{
  int i, id, maxintr;

  if(!ismp)
    return;
801030c7:	90                   	nop
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
801030c8:	c9                   	leave  
801030c9:	c3                   	ret    

801030ca <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
801030ca:	55                   	push   %ebp
801030cb:	89 e5                	mov    %esp,%ebp
801030cd:	83 ec 08             	sub    $0x8,%esp
  if(!ismp)
801030d0:	a1 64 18 11 80       	mov    0x80111864,%eax
801030d5:	85 c0                	test   %eax,%eax
801030d7:	74 39                	je     80103112 <ioapicenable+0x48>
    return;

  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
801030d9:	8b 45 08             	mov    0x8(%ebp),%eax
801030dc:	83 c0 20             	add    $0x20,%eax
801030df:	8b 55 08             	mov    0x8(%ebp),%edx
801030e2:	83 c2 08             	add    $0x8,%edx
801030e5:	01 d2                	add    %edx,%edx
801030e7:	89 44 24 04          	mov    %eax,0x4(%esp)
801030eb:	89 14 24             	mov    %edx,(%esp)
801030ee:	e8 08 ff ff ff       	call   80102ffb <ioapicwrite>
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801030f3:	8b 45 0c             	mov    0xc(%ebp),%eax
801030f6:	c1 e0 18             	shl    $0x18,%eax
801030f9:	8b 55 08             	mov    0x8(%ebp),%edx
801030fc:	83 c2 08             	add    $0x8,%edx
801030ff:	01 d2                	add    %edx,%edx
80103101:	83 c2 01             	add    $0x1,%edx
80103104:	89 44 24 04          	mov    %eax,0x4(%esp)
80103108:	89 14 24             	mov    %edx,(%esp)
8010310b:	e8 eb fe ff ff       	call   80102ffb <ioapicwrite>
80103110:	eb 01                	jmp    80103113 <ioapicenable+0x49>

void
ioapicenable(int irq, int cpunum)
{
  if(!ismp)
    return;
80103112:	90                   	nop
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
}
80103113:	c9                   	leave  
80103114:	c3                   	ret    
80103115:	00 00                	add    %al,(%eax)
	...

80103118 <v2p>:
#define KERNBASE 0x80000000         // First kernel virtual address
#define KERNLINK (KERNBASE+EXTMEM)  // Address where kernel is linked

#ifndef __ASSEMBLER__

static inline uint v2p(void *a) { return ((uint) (a))  - KERNBASE; }
80103118:	55                   	push   %ebp
80103119:	89 e5                	mov    %esp,%ebp
8010311b:	8b 45 08             	mov    0x8(%ebp),%eax
8010311e:	05 00 00 00 80       	add    $0x80000000,%eax
80103123:	5d                   	pop    %ebp
80103124:	c3                   	ret    

80103125 <kinit1>:
// the pages mapped by entrypgdir on free list.
// 2. main() calls kinit2() with the rest of the physical pages
// after installing a full page table that maps them on all cores.
void
kinit1(void *vstart, void *vend)
{
80103125:	55                   	push   %ebp
80103126:	89 e5                	mov    %esp,%ebp
80103128:	83 ec 18             	sub    $0x18,%esp
  initlock(&kmem.lock, "kmem");
8010312b:	c7 44 24 04 76 95 10 	movl   $0x80109576,0x4(%esp)
80103132:	80 
80103133:	c7 04 24 a0 17 11 80 	movl   $0x801117a0,(%esp)
8010313a:	e8 57 29 00 00       	call   80105a96 <initlock>
  kmem.use_lock = 0;
8010313f:	c7 05 d4 17 11 80 00 	movl   $0x0,0x801117d4
80103146:	00 00 00 
  freerange(vstart, vend);
80103149:	8b 45 0c             	mov    0xc(%ebp),%eax
8010314c:	89 44 24 04          	mov    %eax,0x4(%esp)
80103150:	8b 45 08             	mov    0x8(%ebp),%eax
80103153:	89 04 24             	mov    %eax,(%esp)
80103156:	e8 26 00 00 00       	call   80103181 <freerange>
}
8010315b:	c9                   	leave  
8010315c:	c3                   	ret    

8010315d <kinit2>:

void
kinit2(void *vstart, void *vend)
{
8010315d:	55                   	push   %ebp
8010315e:	89 e5                	mov    %esp,%ebp
80103160:	83 ec 18             	sub    $0x18,%esp
  freerange(vstart, vend);
80103163:	8b 45 0c             	mov    0xc(%ebp),%eax
80103166:	89 44 24 04          	mov    %eax,0x4(%esp)
8010316a:	8b 45 08             	mov    0x8(%ebp),%eax
8010316d:	89 04 24             	mov    %eax,(%esp)
80103170:	e8 0c 00 00 00       	call   80103181 <freerange>
  kmem.use_lock = 1;
80103175:	c7 05 d4 17 11 80 01 	movl   $0x1,0x801117d4
8010317c:	00 00 00 
}
8010317f:	c9                   	leave  
80103180:	c3                   	ret    

80103181 <freerange>:

void
freerange(void *vstart, void *vend)
{
80103181:	55                   	push   %ebp
80103182:	89 e5                	mov    %esp,%ebp
80103184:	83 ec 28             	sub    $0x28,%esp
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
80103187:	8b 45 08             	mov    0x8(%ebp),%eax
8010318a:	05 ff 0f 00 00       	add    $0xfff,%eax
8010318f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80103194:	89 45 f4             	mov    %eax,-0xc(%ebp)
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80103197:	eb 12                	jmp    801031ab <freerange+0x2a>
    kfree(p);
80103199:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010319c:	89 04 24             	mov    %eax,(%esp)
8010319f:	e8 16 00 00 00       	call   801031ba <kfree>
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801031a4:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
801031ab:	8b 45 f4             	mov    -0xc(%ebp),%eax
801031ae:	05 00 10 00 00       	add    $0x1000,%eax
801031b3:	3b 45 0c             	cmp    0xc(%ebp),%eax
801031b6:	76 e1                	jbe    80103199 <freerange+0x18>
    kfree(p);
}
801031b8:	c9                   	leave  
801031b9:	c3                   	ret    

801031ba <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
801031ba:	55                   	push   %ebp
801031bb:	89 e5                	mov    %esp,%ebp
801031bd:	83 ec 28             	sub    $0x28,%esp
  struct run *r;

  if((uint)v % PGSIZE || v < end || v2p(v) >= PHYSTOP)
801031c0:	8b 45 08             	mov    0x8(%ebp),%eax
801031c3:	25 ff 0f 00 00       	and    $0xfff,%eax
801031c8:	85 c0                	test   %eax,%eax
801031ca:	75 1b                	jne    801031e7 <kfree+0x2d>
801031cc:	81 7d 08 bc 72 11 80 	cmpl   $0x801172bc,0x8(%ebp)
801031d3:	72 12                	jb     801031e7 <kfree+0x2d>
801031d5:	8b 45 08             	mov    0x8(%ebp),%eax
801031d8:	89 04 24             	mov    %eax,(%esp)
801031db:	e8 38 ff ff ff       	call   80103118 <v2p>
801031e0:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
801031e5:	76 0c                	jbe    801031f3 <kfree+0x39>
    panic("kfree");
801031e7:	c7 04 24 7b 95 10 80 	movl   $0x8010957b,(%esp)
801031ee:	e8 4a d3 ff ff       	call   8010053d <panic>

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
801031f3:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
801031fa:	00 
801031fb:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
80103202:	00 
80103203:	8b 45 08             	mov    0x8(%ebp),%eax
80103206:	89 04 24             	mov    %eax,(%esp)
80103209:	e8 f8 2a 00 00       	call   80105d06 <memset>

  if(kmem.use_lock)
8010320e:	a1 d4 17 11 80       	mov    0x801117d4,%eax
80103213:	85 c0                	test   %eax,%eax
80103215:	74 0c                	je     80103223 <kfree+0x69>
    acquire(&kmem.lock);
80103217:	c7 04 24 a0 17 11 80 	movl   $0x801117a0,(%esp)
8010321e:	e8 94 28 00 00       	call   80105ab7 <acquire>
  r = (struct run*)v;
80103223:	8b 45 08             	mov    0x8(%ebp),%eax
80103226:	89 45 f4             	mov    %eax,-0xc(%ebp)
  r->next = kmem.freelist;
80103229:	8b 15 d8 17 11 80    	mov    0x801117d8,%edx
8010322f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103232:	89 10                	mov    %edx,(%eax)
  kmem.freelist = r;
80103234:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103237:	a3 d8 17 11 80       	mov    %eax,0x801117d8
  if(kmem.use_lock)
8010323c:	a1 d4 17 11 80       	mov    0x801117d4,%eax
80103241:	85 c0                	test   %eax,%eax
80103243:	74 0c                	je     80103251 <kfree+0x97>
    release(&kmem.lock);
80103245:	c7 04 24 a0 17 11 80 	movl   $0x801117a0,(%esp)
8010324c:	e8 c8 28 00 00       	call   80105b19 <release>
}
80103251:	c9                   	leave  
80103252:	c3                   	ret    

80103253 <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char*
kalloc(void)
{
80103253:	55                   	push   %ebp
80103254:	89 e5                	mov    %esp,%ebp
80103256:	83 ec 28             	sub    $0x28,%esp
  struct run *r;

  if(kmem.use_lock)
80103259:	a1 d4 17 11 80       	mov    0x801117d4,%eax
8010325e:	85 c0                	test   %eax,%eax
80103260:	74 0c                	je     8010326e <kalloc+0x1b>
    acquire(&kmem.lock);
80103262:	c7 04 24 a0 17 11 80 	movl   $0x801117a0,(%esp)
80103269:	e8 49 28 00 00       	call   80105ab7 <acquire>
  r = kmem.freelist;
8010326e:	a1 d8 17 11 80       	mov    0x801117d8,%eax
80103273:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(r)
80103276:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010327a:	74 0a                	je     80103286 <kalloc+0x33>
    kmem.freelist = r->next;
8010327c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010327f:	8b 00                	mov    (%eax),%eax
80103281:	a3 d8 17 11 80       	mov    %eax,0x801117d8
  if(kmem.use_lock)
80103286:	a1 d4 17 11 80       	mov    0x801117d4,%eax
8010328b:	85 c0                	test   %eax,%eax
8010328d:	74 0c                	je     8010329b <kalloc+0x48>
    release(&kmem.lock);
8010328f:	c7 04 24 a0 17 11 80 	movl   $0x801117a0,(%esp)
80103296:	e8 7e 28 00 00       	call   80105b19 <release>
  return (char*)r;
8010329b:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
8010329e:	c9                   	leave  
8010329f:	c3                   	ret    

801032a0 <inb>:
// Routines to let C code use special x86 instructions.

static inline uchar
inb(ushort port)
{
801032a0:	55                   	push   %ebp
801032a1:	89 e5                	mov    %esp,%ebp
801032a3:	53                   	push   %ebx
801032a4:	83 ec 14             	sub    $0x14,%esp
801032a7:	8b 45 08             	mov    0x8(%ebp),%eax
801032aa:	66 89 45 e8          	mov    %ax,-0x18(%ebp)
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801032ae:	0f b7 55 e8          	movzwl -0x18(%ebp),%edx
801032b2:	66 89 55 ea          	mov    %dx,-0x16(%ebp)
801032b6:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
801032ba:	ec                   	in     (%dx),%al
801032bb:	89 c3                	mov    %eax,%ebx
801032bd:	88 5d fb             	mov    %bl,-0x5(%ebp)
  return data;
801032c0:	0f b6 45 fb          	movzbl -0x5(%ebp),%eax
}
801032c4:	83 c4 14             	add    $0x14,%esp
801032c7:	5b                   	pop    %ebx
801032c8:	5d                   	pop    %ebp
801032c9:	c3                   	ret    

801032ca <kbdgetc>:
#include "defs.h"
#include "kbd.h"

int
kbdgetc(void)
{
801032ca:	55                   	push   %ebp
801032cb:	89 e5                	mov    %esp,%ebp
801032cd:	83 ec 14             	sub    $0x14,%esp
  static uchar *charcode[4] = {
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
801032d0:	c7 04 24 64 00 00 00 	movl   $0x64,(%esp)
801032d7:	e8 c4 ff ff ff       	call   801032a0 <inb>
801032dc:	0f b6 c0             	movzbl %al,%eax
801032df:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if((st & KBS_DIB) == 0)
801032e2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801032e5:	83 e0 01             	and    $0x1,%eax
801032e8:	85 c0                	test   %eax,%eax
801032ea:	75 0a                	jne    801032f6 <kbdgetc+0x2c>
    return -1;
801032ec:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801032f1:	e9 23 01 00 00       	jmp    80103419 <kbdgetc+0x14f>
  data = inb(KBDATAP);
801032f6:	c7 04 24 60 00 00 00 	movl   $0x60,(%esp)
801032fd:	e8 9e ff ff ff       	call   801032a0 <inb>
80103302:	0f b6 c0             	movzbl %al,%eax
80103305:	89 45 fc             	mov    %eax,-0x4(%ebp)

  if(data == 0xE0){
80103308:	81 7d fc e0 00 00 00 	cmpl   $0xe0,-0x4(%ebp)
8010330f:	75 17                	jne    80103328 <kbdgetc+0x5e>
    shift |= E0ESC;
80103311:	a1 7c cb 10 80       	mov    0x8010cb7c,%eax
80103316:	83 c8 40             	or     $0x40,%eax
80103319:	a3 7c cb 10 80       	mov    %eax,0x8010cb7c
    return 0;
8010331e:	b8 00 00 00 00       	mov    $0x0,%eax
80103323:	e9 f1 00 00 00       	jmp    80103419 <kbdgetc+0x14f>
  } else if(data & 0x80){
80103328:	8b 45 fc             	mov    -0x4(%ebp),%eax
8010332b:	25 80 00 00 00       	and    $0x80,%eax
80103330:	85 c0                	test   %eax,%eax
80103332:	74 45                	je     80103379 <kbdgetc+0xaf>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
80103334:	a1 7c cb 10 80       	mov    0x8010cb7c,%eax
80103339:	83 e0 40             	and    $0x40,%eax
8010333c:	85 c0                	test   %eax,%eax
8010333e:	75 08                	jne    80103348 <kbdgetc+0x7e>
80103340:	8b 45 fc             	mov    -0x4(%ebp),%eax
80103343:	83 e0 7f             	and    $0x7f,%eax
80103346:	eb 03                	jmp    8010334b <kbdgetc+0x81>
80103348:	8b 45 fc             	mov    -0x4(%ebp),%eax
8010334b:	89 45 fc             	mov    %eax,-0x4(%ebp)
    shift &= ~(shiftcode[data] | E0ESC);
8010334e:	8b 45 fc             	mov    -0x4(%ebp),%eax
80103351:	05 20 a0 10 80       	add    $0x8010a020,%eax
80103356:	0f b6 00             	movzbl (%eax),%eax
80103359:	83 c8 40             	or     $0x40,%eax
8010335c:	0f b6 c0             	movzbl %al,%eax
8010335f:	f7 d0                	not    %eax
80103361:	89 c2                	mov    %eax,%edx
80103363:	a1 7c cb 10 80       	mov    0x8010cb7c,%eax
80103368:	21 d0                	and    %edx,%eax
8010336a:	a3 7c cb 10 80       	mov    %eax,0x8010cb7c
    return 0;
8010336f:	b8 00 00 00 00       	mov    $0x0,%eax
80103374:	e9 a0 00 00 00       	jmp    80103419 <kbdgetc+0x14f>
  } else if(shift & E0ESC){
80103379:	a1 7c cb 10 80       	mov    0x8010cb7c,%eax
8010337e:	83 e0 40             	and    $0x40,%eax
80103381:	85 c0                	test   %eax,%eax
80103383:	74 14                	je     80103399 <kbdgetc+0xcf>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
80103385:	81 4d fc 80 00 00 00 	orl    $0x80,-0x4(%ebp)
    shift &= ~E0ESC;
8010338c:	a1 7c cb 10 80       	mov    0x8010cb7c,%eax
80103391:	83 e0 bf             	and    $0xffffffbf,%eax
80103394:	a3 7c cb 10 80       	mov    %eax,0x8010cb7c
  }

  shift |= shiftcode[data];
80103399:	8b 45 fc             	mov    -0x4(%ebp),%eax
8010339c:	05 20 a0 10 80       	add    $0x8010a020,%eax
801033a1:	0f b6 00             	movzbl (%eax),%eax
801033a4:	0f b6 d0             	movzbl %al,%edx
801033a7:	a1 7c cb 10 80       	mov    0x8010cb7c,%eax
801033ac:	09 d0                	or     %edx,%eax
801033ae:	a3 7c cb 10 80       	mov    %eax,0x8010cb7c
  shift ^= togglecode[data];
801033b3:	8b 45 fc             	mov    -0x4(%ebp),%eax
801033b6:	05 20 a1 10 80       	add    $0x8010a120,%eax
801033bb:	0f b6 00             	movzbl (%eax),%eax
801033be:	0f b6 d0             	movzbl %al,%edx
801033c1:	a1 7c cb 10 80       	mov    0x8010cb7c,%eax
801033c6:	31 d0                	xor    %edx,%eax
801033c8:	a3 7c cb 10 80       	mov    %eax,0x8010cb7c
  c = charcode[shift & (CTL | SHIFT)][data];
801033cd:	a1 7c cb 10 80       	mov    0x8010cb7c,%eax
801033d2:	83 e0 03             	and    $0x3,%eax
801033d5:	8b 04 85 20 a5 10 80 	mov    -0x7fef5ae0(,%eax,4),%eax
801033dc:	03 45 fc             	add    -0x4(%ebp),%eax
801033df:	0f b6 00             	movzbl (%eax),%eax
801033e2:	0f b6 c0             	movzbl %al,%eax
801033e5:	89 45 f8             	mov    %eax,-0x8(%ebp)
  if(shift & CAPSLOCK){
801033e8:	a1 7c cb 10 80       	mov    0x8010cb7c,%eax
801033ed:	83 e0 08             	and    $0x8,%eax
801033f0:	85 c0                	test   %eax,%eax
801033f2:	74 22                	je     80103416 <kbdgetc+0x14c>
    if('a' <= c && c <= 'z')
801033f4:	83 7d f8 60          	cmpl   $0x60,-0x8(%ebp)
801033f8:	76 0c                	jbe    80103406 <kbdgetc+0x13c>
801033fa:	83 7d f8 7a          	cmpl   $0x7a,-0x8(%ebp)
801033fe:	77 06                	ja     80103406 <kbdgetc+0x13c>
      c += 'A' - 'a';
80103400:	83 6d f8 20          	subl   $0x20,-0x8(%ebp)
80103404:	eb 10                	jmp    80103416 <kbdgetc+0x14c>
    else if('A' <= c && c <= 'Z')
80103406:	83 7d f8 40          	cmpl   $0x40,-0x8(%ebp)
8010340a:	76 0a                	jbe    80103416 <kbdgetc+0x14c>
8010340c:	83 7d f8 5a          	cmpl   $0x5a,-0x8(%ebp)
80103410:	77 04                	ja     80103416 <kbdgetc+0x14c>
      c += 'a' - 'A';
80103412:	83 45 f8 20          	addl   $0x20,-0x8(%ebp)
  }
  return c;
80103416:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
80103419:	c9                   	leave  
8010341a:	c3                   	ret    

8010341b <kbdintr>:

void
kbdintr(void)
{
8010341b:	55                   	push   %ebp
8010341c:	89 e5                	mov    %esp,%ebp
8010341e:	83 ec 18             	sub    $0x18,%esp
  consoleintr(kbdgetc);
80103421:	c7 04 24 ca 32 10 80 	movl   $0x801032ca,(%esp)
80103428:	e8 8e d4 ff ff       	call   801008bb <consoleintr>
}
8010342d:	c9                   	leave  
8010342e:	c3                   	ret    
	...

80103430 <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
80103430:	55                   	push   %ebp
80103431:	89 e5                	mov    %esp,%ebp
80103433:	83 ec 08             	sub    $0x8,%esp
80103436:	8b 55 08             	mov    0x8(%ebp),%edx
80103439:	8b 45 0c             	mov    0xc(%ebp),%eax
8010343c:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
80103440:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103443:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80103447:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
8010344b:	ee                   	out    %al,(%dx)
}
8010344c:	c9                   	leave  
8010344d:	c3                   	ret    

8010344e <readeflags>:
  asm volatile("ltr %0" : : "r" (sel));
}

static inline uint
readeflags(void)
{
8010344e:	55                   	push   %ebp
8010344f:	89 e5                	mov    %esp,%ebp
80103451:	53                   	push   %ebx
80103452:	83 ec 10             	sub    $0x10,%esp
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103455:	9c                   	pushf  
80103456:	5b                   	pop    %ebx
80103457:	89 5d f8             	mov    %ebx,-0x8(%ebp)
  return eflags;
8010345a:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
8010345d:	83 c4 10             	add    $0x10,%esp
80103460:	5b                   	pop    %ebx
80103461:	5d                   	pop    %ebp
80103462:	c3                   	ret    

80103463 <lapicw>:

volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
80103463:	55                   	push   %ebp
80103464:	89 e5                	mov    %esp,%ebp
  lapic[index] = value;
80103466:	a1 dc 17 11 80       	mov    0x801117dc,%eax
8010346b:	8b 55 08             	mov    0x8(%ebp),%edx
8010346e:	c1 e2 02             	shl    $0x2,%edx
80103471:	01 c2                	add    %eax,%edx
80103473:	8b 45 0c             	mov    0xc(%ebp),%eax
80103476:	89 02                	mov    %eax,(%edx)
  lapic[ID];  // wait for write to finish, by reading
80103478:	a1 dc 17 11 80       	mov    0x801117dc,%eax
8010347d:	83 c0 20             	add    $0x20,%eax
80103480:	8b 00                	mov    (%eax),%eax
}
80103482:	5d                   	pop    %ebp
80103483:	c3                   	ret    

80103484 <lapicinit>:
//PAGEBREAK!

void
lapicinit(int c)
{
80103484:	55                   	push   %ebp
80103485:	89 e5                	mov    %esp,%ebp
80103487:	83 ec 08             	sub    $0x8,%esp
  if(!lapic) 
8010348a:	a1 dc 17 11 80       	mov    0x801117dc,%eax
8010348f:	85 c0                	test   %eax,%eax
80103491:	0f 84 47 01 00 00    	je     801035de <lapicinit+0x15a>
    return;

  // Enable local APIC; set spurious interrupt vector.
  lapicw(SVR, ENABLE | (T_IRQ0 + IRQ_SPURIOUS));
80103497:	c7 44 24 04 3f 01 00 	movl   $0x13f,0x4(%esp)
8010349e:	00 
8010349f:	c7 04 24 3c 00 00 00 	movl   $0x3c,(%esp)
801034a6:	e8 b8 ff ff ff       	call   80103463 <lapicw>

  // The timer repeatedly counts down at bus frequency
  // from lapic[TICR] and then issues an interrupt.  
  // If xv6 cared more about precise timekeeping,
  // TICR would be calibrated using an external time source.
  lapicw(TDCR, X1);
801034ab:	c7 44 24 04 0b 00 00 	movl   $0xb,0x4(%esp)
801034b2:	00 
801034b3:	c7 04 24 f8 00 00 00 	movl   $0xf8,(%esp)
801034ba:	e8 a4 ff ff ff       	call   80103463 <lapicw>
  lapicw(TIMER, PERIODIC | (T_IRQ0 + IRQ_TIMER));
801034bf:	c7 44 24 04 20 00 02 	movl   $0x20020,0x4(%esp)
801034c6:	00 
801034c7:	c7 04 24 c8 00 00 00 	movl   $0xc8,(%esp)
801034ce:	e8 90 ff ff ff       	call   80103463 <lapicw>
  lapicw(TICR, 10000000); 
801034d3:	c7 44 24 04 80 96 98 	movl   $0x989680,0x4(%esp)
801034da:	00 
801034db:	c7 04 24 e0 00 00 00 	movl   $0xe0,(%esp)
801034e2:	e8 7c ff ff ff       	call   80103463 <lapicw>

  // Disable logical interrupt lines.
  lapicw(LINT0, MASKED);
801034e7:	c7 44 24 04 00 00 01 	movl   $0x10000,0x4(%esp)
801034ee:	00 
801034ef:	c7 04 24 d4 00 00 00 	movl   $0xd4,(%esp)
801034f6:	e8 68 ff ff ff       	call   80103463 <lapicw>
  lapicw(LINT1, MASKED);
801034fb:	c7 44 24 04 00 00 01 	movl   $0x10000,0x4(%esp)
80103502:	00 
80103503:	c7 04 24 d8 00 00 00 	movl   $0xd8,(%esp)
8010350a:	e8 54 ff ff ff       	call   80103463 <lapicw>

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
8010350f:	a1 dc 17 11 80       	mov    0x801117dc,%eax
80103514:	83 c0 30             	add    $0x30,%eax
80103517:	8b 00                	mov    (%eax),%eax
80103519:	c1 e8 10             	shr    $0x10,%eax
8010351c:	25 ff 00 00 00       	and    $0xff,%eax
80103521:	83 f8 03             	cmp    $0x3,%eax
80103524:	76 14                	jbe    8010353a <lapicinit+0xb6>
    lapicw(PCINT, MASKED);
80103526:	c7 44 24 04 00 00 01 	movl   $0x10000,0x4(%esp)
8010352d:	00 
8010352e:	c7 04 24 d0 00 00 00 	movl   $0xd0,(%esp)
80103535:	e8 29 ff ff ff       	call   80103463 <lapicw>

  // Map error interrupt to IRQ_ERROR.
  lapicw(ERROR, T_IRQ0 + IRQ_ERROR);
8010353a:	c7 44 24 04 33 00 00 	movl   $0x33,0x4(%esp)
80103541:	00 
80103542:	c7 04 24 dc 00 00 00 	movl   $0xdc,(%esp)
80103549:	e8 15 ff ff ff       	call   80103463 <lapicw>

  // Clear error status register (requires back-to-back writes).
  lapicw(ESR, 0);
8010354e:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80103555:	00 
80103556:	c7 04 24 a0 00 00 00 	movl   $0xa0,(%esp)
8010355d:	e8 01 ff ff ff       	call   80103463 <lapicw>
  lapicw(ESR, 0);
80103562:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80103569:	00 
8010356a:	c7 04 24 a0 00 00 00 	movl   $0xa0,(%esp)
80103571:	e8 ed fe ff ff       	call   80103463 <lapicw>

  // Ack any outstanding interrupts.
  lapicw(EOI, 0);
80103576:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
8010357d:	00 
8010357e:	c7 04 24 2c 00 00 00 	movl   $0x2c,(%esp)
80103585:	e8 d9 fe ff ff       	call   80103463 <lapicw>

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
8010358a:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80103591:	00 
80103592:	c7 04 24 c4 00 00 00 	movl   $0xc4,(%esp)
80103599:	e8 c5 fe ff ff       	call   80103463 <lapicw>
  lapicw(ICRLO, BCAST | INIT | LEVEL);
8010359e:	c7 44 24 04 00 85 08 	movl   $0x88500,0x4(%esp)
801035a5:	00 
801035a6:	c7 04 24 c0 00 00 00 	movl   $0xc0,(%esp)
801035ad:	e8 b1 fe ff ff       	call   80103463 <lapicw>
  while(lapic[ICRLO] & DELIVS)
801035b2:	90                   	nop
801035b3:	a1 dc 17 11 80       	mov    0x801117dc,%eax
801035b8:	05 00 03 00 00       	add    $0x300,%eax
801035bd:	8b 00                	mov    (%eax),%eax
801035bf:	25 00 10 00 00       	and    $0x1000,%eax
801035c4:	85 c0                	test   %eax,%eax
801035c6:	75 eb                	jne    801035b3 <lapicinit+0x12f>
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
801035c8:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
801035cf:	00 
801035d0:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801035d7:	e8 87 fe ff ff       	call   80103463 <lapicw>
801035dc:	eb 01                	jmp    801035df <lapicinit+0x15b>

void
lapicinit(int c)
{
  if(!lapic) 
    return;
801035de:	90                   	nop
  while(lapic[ICRLO] & DELIVS)
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
801035df:	c9                   	leave  
801035e0:	c3                   	ret    

801035e1 <cpunum>:

int
cpunum(void)
{
801035e1:	55                   	push   %ebp
801035e2:	89 e5                	mov    %esp,%ebp
801035e4:	83 ec 18             	sub    $0x18,%esp
  // Cannot call cpu when interrupts are enabled:
  // result not guaranteed to last long enough to be used!
  // Would prefer to panic but even printing is chancy here:
  // almost everything, including cprintf and panic, calls cpu,
  // often indirectly through acquire and release.
  if(readeflags()&FL_IF){
801035e7:	e8 62 fe ff ff       	call   8010344e <readeflags>
801035ec:	25 00 02 00 00       	and    $0x200,%eax
801035f1:	85 c0                	test   %eax,%eax
801035f3:	74 29                	je     8010361e <cpunum+0x3d>
    static int n;
    if(n++ == 0)
801035f5:	a1 80 cb 10 80       	mov    0x8010cb80,%eax
801035fa:	85 c0                	test   %eax,%eax
801035fc:	0f 94 c2             	sete   %dl
801035ff:	83 c0 01             	add    $0x1,%eax
80103602:	a3 80 cb 10 80       	mov    %eax,0x8010cb80
80103607:	84 d2                	test   %dl,%dl
80103609:	74 13                	je     8010361e <cpunum+0x3d>
      cprintf("cpu called from %x with interrupts enabled\n",
8010360b:	8b 45 04             	mov    0x4(%ebp),%eax
8010360e:	89 44 24 04          	mov    %eax,0x4(%esp)
80103612:	c7 04 24 84 95 10 80 	movl   $0x80109584,(%esp)
80103619:	e8 83 cd ff ff       	call   801003a1 <cprintf>
        __builtin_return_address(0));
  }

  if(lapic)
8010361e:	a1 dc 17 11 80       	mov    0x801117dc,%eax
80103623:	85 c0                	test   %eax,%eax
80103625:	74 0f                	je     80103636 <cpunum+0x55>
    return lapic[ID]>>24;
80103627:	a1 dc 17 11 80       	mov    0x801117dc,%eax
8010362c:	83 c0 20             	add    $0x20,%eax
8010362f:	8b 00                	mov    (%eax),%eax
80103631:	c1 e8 18             	shr    $0x18,%eax
80103634:	eb 05                	jmp    8010363b <cpunum+0x5a>
  return 0;
80103636:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010363b:	c9                   	leave  
8010363c:	c3                   	ret    

8010363d <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
8010363d:	55                   	push   %ebp
8010363e:	89 e5                	mov    %esp,%ebp
80103640:	83 ec 08             	sub    $0x8,%esp
  if(lapic)
80103643:	a1 dc 17 11 80       	mov    0x801117dc,%eax
80103648:	85 c0                	test   %eax,%eax
8010364a:	74 14                	je     80103660 <lapiceoi+0x23>
    lapicw(EOI, 0);
8010364c:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80103653:	00 
80103654:	c7 04 24 2c 00 00 00 	movl   $0x2c,(%esp)
8010365b:	e8 03 fe ff ff       	call   80103463 <lapicw>
}
80103660:	c9                   	leave  
80103661:	c3                   	ret    

80103662 <microdelay>:

// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
80103662:	55                   	push   %ebp
80103663:	89 e5                	mov    %esp,%ebp
}
80103665:	5d                   	pop    %ebp
80103666:	c3                   	ret    

80103667 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
80103667:	55                   	push   %ebp
80103668:	89 e5                	mov    %esp,%ebp
8010366a:	83 ec 1c             	sub    $0x1c,%esp
8010366d:	8b 45 08             	mov    0x8(%ebp),%eax
80103670:	88 45 ec             	mov    %al,-0x14(%ebp)
  ushort *wrv;
  
  // "The BSP must initialize CMOS shutdown code to 0AH
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(IO_RTC, 0xF);  // offset 0xF is shutdown code
80103673:	c7 44 24 04 0f 00 00 	movl   $0xf,0x4(%esp)
8010367a:	00 
8010367b:	c7 04 24 70 00 00 00 	movl   $0x70,(%esp)
80103682:	e8 a9 fd ff ff       	call   80103430 <outb>
  outb(IO_RTC+1, 0x0A);
80103687:	c7 44 24 04 0a 00 00 	movl   $0xa,0x4(%esp)
8010368e:	00 
8010368f:	c7 04 24 71 00 00 00 	movl   $0x71,(%esp)
80103696:	e8 95 fd ff ff       	call   80103430 <outb>
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
8010369b:	c7 45 f8 67 04 00 80 	movl   $0x80000467,-0x8(%ebp)
  wrv[0] = 0;
801036a2:	8b 45 f8             	mov    -0x8(%ebp),%eax
801036a5:	66 c7 00 00 00       	movw   $0x0,(%eax)
  wrv[1] = addr >> 4;
801036aa:	8b 45 f8             	mov    -0x8(%ebp),%eax
801036ad:	8d 50 02             	lea    0x2(%eax),%edx
801036b0:	8b 45 0c             	mov    0xc(%ebp),%eax
801036b3:	c1 e8 04             	shr    $0x4,%eax
801036b6:	66 89 02             	mov    %ax,(%edx)

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
801036b9:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
801036bd:	c1 e0 18             	shl    $0x18,%eax
801036c0:	89 44 24 04          	mov    %eax,0x4(%esp)
801036c4:	c7 04 24 c4 00 00 00 	movl   $0xc4,(%esp)
801036cb:	e8 93 fd ff ff       	call   80103463 <lapicw>
  lapicw(ICRLO, INIT | LEVEL | ASSERT);
801036d0:	c7 44 24 04 00 c5 00 	movl   $0xc500,0x4(%esp)
801036d7:	00 
801036d8:	c7 04 24 c0 00 00 00 	movl   $0xc0,(%esp)
801036df:	e8 7f fd ff ff       	call   80103463 <lapicw>
  microdelay(200);
801036e4:	c7 04 24 c8 00 00 00 	movl   $0xc8,(%esp)
801036eb:	e8 72 ff ff ff       	call   80103662 <microdelay>
  lapicw(ICRLO, INIT | LEVEL);
801036f0:	c7 44 24 04 00 85 00 	movl   $0x8500,0x4(%esp)
801036f7:	00 
801036f8:	c7 04 24 c0 00 00 00 	movl   $0xc0,(%esp)
801036ff:	e8 5f fd ff ff       	call   80103463 <lapicw>
  microdelay(100);    // should be 10ms, but too slow in Bochs!
80103704:	c7 04 24 64 00 00 00 	movl   $0x64,(%esp)
8010370b:	e8 52 ff ff ff       	call   80103662 <microdelay>
  // Send startup IPI (twice!) to enter code.
  // Regular hardware is supposed to only accept a STARTUP
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
80103710:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
80103717:	eb 40                	jmp    80103759 <lapicstartap+0xf2>
    lapicw(ICRHI, apicid<<24);
80103719:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
8010371d:	c1 e0 18             	shl    $0x18,%eax
80103720:	89 44 24 04          	mov    %eax,0x4(%esp)
80103724:	c7 04 24 c4 00 00 00 	movl   $0xc4,(%esp)
8010372b:	e8 33 fd ff ff       	call   80103463 <lapicw>
    lapicw(ICRLO, STARTUP | (addr>>12));
80103730:	8b 45 0c             	mov    0xc(%ebp),%eax
80103733:	c1 e8 0c             	shr    $0xc,%eax
80103736:	80 cc 06             	or     $0x6,%ah
80103739:	89 44 24 04          	mov    %eax,0x4(%esp)
8010373d:	c7 04 24 c0 00 00 00 	movl   $0xc0,(%esp)
80103744:	e8 1a fd ff ff       	call   80103463 <lapicw>
    microdelay(200);
80103749:	c7 04 24 c8 00 00 00 	movl   $0xc8,(%esp)
80103750:	e8 0d ff ff ff       	call   80103662 <microdelay>
  // Send startup IPI (twice!) to enter code.
  // Regular hardware is supposed to only accept a STARTUP
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
80103755:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
80103759:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
8010375d:	7e ba                	jle    80103719 <lapicstartap+0xb2>
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
    microdelay(200);
  }
}
8010375f:	c9                   	leave  
80103760:	c3                   	ret    
80103761:	00 00                	add    %al,(%eax)
	...

80103764 <initlog>:

static void recover_from_log(void);

void
initlog(void)
{
80103764:	55                   	push   %ebp
80103765:	89 e5                	mov    %esp,%ebp
80103767:	83 ec 28             	sub    $0x28,%esp
  if (sizeof(struct logheader) >= BSIZE)
    panic("initlog: too big logheader");

  struct superblock sb;
  initlock(&log.lock, "log");
8010376a:	c7 44 24 04 b0 95 10 	movl   $0x801095b0,0x4(%esp)
80103771:	80 
80103772:	c7 04 24 e0 17 11 80 	movl   $0x801117e0,(%esp)
80103779:	e8 18 23 00 00       	call   80105a96 <initlock>
  readsb(ROOTDEV, &sb);
8010377e:	8d 45 e8             	lea    -0x18(%ebp),%eax
80103781:	89 44 24 04          	mov    %eax,0x4(%esp)
80103785:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
8010378c:	e8 af e2 ff ff       	call   80101a40 <readsb>
  log.start = sb.size - sb.nlog;
80103791:	8b 55 e8             	mov    -0x18(%ebp),%edx
80103794:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103797:	89 d1                	mov    %edx,%ecx
80103799:	29 c1                	sub    %eax,%ecx
8010379b:	89 c8                	mov    %ecx,%eax
8010379d:	a3 14 18 11 80       	mov    %eax,0x80111814
  log.size = sb.nlog;
801037a2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801037a5:	a3 18 18 11 80       	mov    %eax,0x80111818
  log.dev = ROOTDEV;
801037aa:	c7 05 20 18 11 80 01 	movl   $0x1,0x80111820
801037b1:	00 00 00 
  recover_from_log();
801037b4:	e8 97 01 00 00       	call   80103950 <recover_from_log>
}
801037b9:	c9                   	leave  
801037ba:	c3                   	ret    

801037bb <install_trans>:

// Copy committed blocks from log to their home location
static void 
install_trans(void)
{
801037bb:	55                   	push   %ebp
801037bc:	89 e5                	mov    %esp,%ebp
801037be:	83 ec 28             	sub    $0x28,%esp
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
801037c1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801037c8:	e9 89 00 00 00       	jmp    80103856 <install_trans+0x9b>
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
801037cd:	a1 14 18 11 80       	mov    0x80111814,%eax
801037d2:	03 45 f4             	add    -0xc(%ebp),%eax
801037d5:	83 c0 01             	add    $0x1,%eax
801037d8:	89 c2                	mov    %eax,%edx
801037da:	a1 20 18 11 80       	mov    0x80111820,%eax
801037df:	89 54 24 04          	mov    %edx,0x4(%esp)
801037e3:	89 04 24             	mov    %eax,(%esp)
801037e6:	e8 bb c9 ff ff       	call   801001a6 <bread>
801037eb:	89 45 f0             	mov    %eax,-0x10(%ebp)
    struct buf *dbuf = bread(log.dev, log.lh.sector[tail]); // read dst
801037ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
801037f1:	83 c0 10             	add    $0x10,%eax
801037f4:	8b 04 85 e8 17 11 80 	mov    -0x7feee818(,%eax,4),%eax
801037fb:	89 c2                	mov    %eax,%edx
801037fd:	a1 20 18 11 80       	mov    0x80111820,%eax
80103802:	89 54 24 04          	mov    %edx,0x4(%esp)
80103806:	89 04 24             	mov    %eax,(%esp)
80103809:	e8 98 c9 ff ff       	call   801001a6 <bread>
8010380e:	89 45 ec             	mov    %eax,-0x14(%ebp)
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80103811:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103814:	8d 50 18             	lea    0x18(%eax),%edx
80103817:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010381a:	83 c0 18             	add    $0x18,%eax
8010381d:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
80103824:	00 
80103825:	89 54 24 04          	mov    %edx,0x4(%esp)
80103829:	89 04 24             	mov    %eax,(%esp)
8010382c:	e8 a8 25 00 00       	call   80105dd9 <memmove>
    bwrite(dbuf);  // write dst to disk
80103831:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103834:	89 04 24             	mov    %eax,(%esp)
80103837:	e8 a1 c9 ff ff       	call   801001dd <bwrite>
    brelse(lbuf); 
8010383c:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010383f:	89 04 24             	mov    %eax,(%esp)
80103842:	e8 d0 c9 ff ff       	call   80100217 <brelse>
    brelse(dbuf);
80103847:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010384a:	89 04 24             	mov    %eax,(%esp)
8010384d:	e8 c5 c9 ff ff       	call   80100217 <brelse>
static void 
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80103852:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80103856:	a1 24 18 11 80       	mov    0x80111824,%eax
8010385b:	3b 45 f4             	cmp    -0xc(%ebp),%eax
8010385e:	0f 8f 69 ff ff ff    	jg     801037cd <install_trans+0x12>
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
    bwrite(dbuf);  // write dst to disk
    brelse(lbuf); 
    brelse(dbuf);
  }
}
80103864:	c9                   	leave  
80103865:	c3                   	ret    

80103866 <read_head>:

// Read the log header from disk into the in-memory log header
static void
read_head(void)
{
80103866:	55                   	push   %ebp
80103867:	89 e5                	mov    %esp,%ebp
80103869:	83 ec 28             	sub    $0x28,%esp
  struct buf *buf = bread(log.dev, log.start);
8010386c:	a1 14 18 11 80       	mov    0x80111814,%eax
80103871:	89 c2                	mov    %eax,%edx
80103873:	a1 20 18 11 80       	mov    0x80111820,%eax
80103878:	89 54 24 04          	mov    %edx,0x4(%esp)
8010387c:	89 04 24             	mov    %eax,(%esp)
8010387f:	e8 22 c9 ff ff       	call   801001a6 <bread>
80103884:	89 45 f0             	mov    %eax,-0x10(%ebp)
  struct logheader *lh = (struct logheader *) (buf->data);
80103887:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010388a:	83 c0 18             	add    $0x18,%eax
8010388d:	89 45 ec             	mov    %eax,-0x14(%ebp)
  int i;
  log.lh.n = lh->n;
80103890:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103893:	8b 00                	mov    (%eax),%eax
80103895:	a3 24 18 11 80       	mov    %eax,0x80111824
  for (i = 0; i < log.lh.n; i++) {
8010389a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801038a1:	eb 1b                	jmp    801038be <read_head+0x58>
    log.lh.sector[i] = lh->sector[i];
801038a3:	8b 45 ec             	mov    -0x14(%ebp),%eax
801038a6:	8b 55 f4             	mov    -0xc(%ebp),%edx
801038a9:	8b 44 90 04          	mov    0x4(%eax,%edx,4),%eax
801038ad:	8b 55 f4             	mov    -0xc(%ebp),%edx
801038b0:	83 c2 10             	add    $0x10,%edx
801038b3:	89 04 95 e8 17 11 80 	mov    %eax,-0x7feee818(,%edx,4)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
  for (i = 0; i < log.lh.n; i++) {
801038ba:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801038be:	a1 24 18 11 80       	mov    0x80111824,%eax
801038c3:	3b 45 f4             	cmp    -0xc(%ebp),%eax
801038c6:	7f db                	jg     801038a3 <read_head+0x3d>
    log.lh.sector[i] = lh->sector[i];
  }
  brelse(buf);
801038c8:	8b 45 f0             	mov    -0x10(%ebp),%eax
801038cb:	89 04 24             	mov    %eax,(%esp)
801038ce:	e8 44 c9 ff ff       	call   80100217 <brelse>
}
801038d3:	c9                   	leave  
801038d4:	c3                   	ret    

801038d5 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
801038d5:	55                   	push   %ebp
801038d6:	89 e5                	mov    %esp,%ebp
801038d8:	83 ec 28             	sub    $0x28,%esp
  struct buf *buf = bread(log.dev, log.start);
801038db:	a1 14 18 11 80       	mov    0x80111814,%eax
801038e0:	89 c2                	mov    %eax,%edx
801038e2:	a1 20 18 11 80       	mov    0x80111820,%eax
801038e7:	89 54 24 04          	mov    %edx,0x4(%esp)
801038eb:	89 04 24             	mov    %eax,(%esp)
801038ee:	e8 b3 c8 ff ff       	call   801001a6 <bread>
801038f3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  struct logheader *hb = (struct logheader *) (buf->data);
801038f6:	8b 45 f0             	mov    -0x10(%ebp),%eax
801038f9:	83 c0 18             	add    $0x18,%eax
801038fc:	89 45 ec             	mov    %eax,-0x14(%ebp)
  int i;
  hb->n = log.lh.n;
801038ff:	8b 15 24 18 11 80    	mov    0x80111824,%edx
80103905:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103908:	89 10                	mov    %edx,(%eax)
  for (i = 0; i < log.lh.n; i++) {
8010390a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80103911:	eb 1b                	jmp    8010392e <write_head+0x59>
    hb->sector[i] = log.lh.sector[i];
80103913:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103916:	83 c0 10             	add    $0x10,%eax
80103919:	8b 0c 85 e8 17 11 80 	mov    -0x7feee818(,%eax,4),%ecx
80103920:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103923:	8b 55 f4             	mov    -0xc(%ebp),%edx
80103926:	89 4c 90 04          	mov    %ecx,0x4(%eax,%edx,4)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
8010392a:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
8010392e:	a1 24 18 11 80       	mov    0x80111824,%eax
80103933:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80103936:	7f db                	jg     80103913 <write_head+0x3e>
    hb->sector[i] = log.lh.sector[i];
  }
  bwrite(buf);
80103938:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010393b:	89 04 24             	mov    %eax,(%esp)
8010393e:	e8 9a c8 ff ff       	call   801001dd <bwrite>
  brelse(buf);
80103943:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103946:	89 04 24             	mov    %eax,(%esp)
80103949:	e8 c9 c8 ff ff       	call   80100217 <brelse>
}
8010394e:	c9                   	leave  
8010394f:	c3                   	ret    

80103950 <recover_from_log>:

static void
recover_from_log(void)
{
80103950:	55                   	push   %ebp
80103951:	89 e5                	mov    %esp,%ebp
80103953:	83 ec 08             	sub    $0x8,%esp
  read_head();      
80103956:	e8 0b ff ff ff       	call   80103866 <read_head>
  install_trans(); // if committed, copy from log to disk
8010395b:	e8 5b fe ff ff       	call   801037bb <install_trans>
  log.lh.n = 0;
80103960:	c7 05 24 18 11 80 00 	movl   $0x0,0x80111824
80103967:	00 00 00 
  write_head(); // clear the log
8010396a:	e8 66 ff ff ff       	call   801038d5 <write_head>
}
8010396f:	c9                   	leave  
80103970:	c3                   	ret    

80103971 <begin_trans>:

void
begin_trans(void)
{
80103971:	55                   	push   %ebp
80103972:	89 e5                	mov    %esp,%ebp
80103974:	83 ec 18             	sub    $0x18,%esp
  acquire(&log.lock);
80103977:	c7 04 24 e0 17 11 80 	movl   $0x801117e0,(%esp)
8010397e:	e8 34 21 00 00       	call   80105ab7 <acquire>
  while (log.busy) {
80103983:	eb 14                	jmp    80103999 <begin_trans+0x28>
    sleep(&log, &log.lock);
80103985:	c7 44 24 04 e0 17 11 	movl   $0x801117e0,0x4(%esp)
8010398c:	80 
8010398d:	c7 04 24 e0 17 11 80 	movl   $0x801117e0,(%esp)
80103994:	e8 90 1c 00 00       	call   80105629 <sleep>

void
begin_trans(void)
{
  acquire(&log.lock);
  while (log.busy) {
80103999:	a1 1c 18 11 80       	mov    0x8011181c,%eax
8010399e:	85 c0                	test   %eax,%eax
801039a0:	75 e3                	jne    80103985 <begin_trans+0x14>
    sleep(&log, &log.lock);
  }
  log.busy = 1;
801039a2:	c7 05 1c 18 11 80 01 	movl   $0x1,0x8011181c
801039a9:	00 00 00 
  release(&log.lock);
801039ac:	c7 04 24 e0 17 11 80 	movl   $0x801117e0,(%esp)
801039b3:	e8 61 21 00 00       	call   80105b19 <release>
}
801039b8:	c9                   	leave  
801039b9:	c3                   	ret    

801039ba <commit_trans>:

void
commit_trans(void)
{
801039ba:	55                   	push   %ebp
801039bb:	89 e5                	mov    %esp,%ebp
801039bd:	83 ec 18             	sub    $0x18,%esp
  if (log.lh.n > 0) {
801039c0:	a1 24 18 11 80       	mov    0x80111824,%eax
801039c5:	85 c0                	test   %eax,%eax
801039c7:	7e 19                	jle    801039e2 <commit_trans+0x28>
    write_head();    // Write header to disk -- the real commit
801039c9:	e8 07 ff ff ff       	call   801038d5 <write_head>
    install_trans(); // Now install writes to home locations
801039ce:	e8 e8 fd ff ff       	call   801037bb <install_trans>
    log.lh.n = 0; 
801039d3:	c7 05 24 18 11 80 00 	movl   $0x0,0x80111824
801039da:	00 00 00 
    write_head();    // Erase the transaction from the log
801039dd:	e8 f3 fe ff ff       	call   801038d5 <write_head>
  }
  
  acquire(&log.lock);
801039e2:	c7 04 24 e0 17 11 80 	movl   $0x801117e0,(%esp)
801039e9:	e8 c9 20 00 00       	call   80105ab7 <acquire>
  log.busy = 0;
801039ee:	c7 05 1c 18 11 80 00 	movl   $0x0,0x8011181c
801039f5:	00 00 00 
  wakeup(&log);
801039f8:	c7 04 24 e0 17 11 80 	movl   $0x801117e0,(%esp)
801039ff:	e8 13 1d 00 00       	call   80105717 <wakeup>
  release(&log.lock);
80103a04:	c7 04 24 e0 17 11 80 	movl   $0x801117e0,(%esp)
80103a0b:	e8 09 21 00 00       	call   80105b19 <release>
}
80103a10:	c9                   	leave  
80103a11:	c3                   	ret    

80103a12 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80103a12:	55                   	push   %ebp
80103a13:	89 e5                	mov    %esp,%ebp
80103a15:	83 ec 28             	sub    $0x28,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80103a18:	a1 24 18 11 80       	mov    0x80111824,%eax
80103a1d:	83 f8 09             	cmp    $0x9,%eax
80103a20:	7f 12                	jg     80103a34 <log_write+0x22>
80103a22:	a1 24 18 11 80       	mov    0x80111824,%eax
80103a27:	8b 15 18 18 11 80    	mov    0x80111818,%edx
80103a2d:	83 ea 01             	sub    $0x1,%edx
80103a30:	39 d0                	cmp    %edx,%eax
80103a32:	7c 0c                	jl     80103a40 <log_write+0x2e>
    panic("too big a transaction");
80103a34:	c7 04 24 b4 95 10 80 	movl   $0x801095b4,(%esp)
80103a3b:	e8 fd ca ff ff       	call   8010053d <panic>
  if (!log.busy)
80103a40:	a1 1c 18 11 80       	mov    0x8011181c,%eax
80103a45:	85 c0                	test   %eax,%eax
80103a47:	75 0c                	jne    80103a55 <log_write+0x43>
    panic("write outside of trans");
80103a49:	c7 04 24 ca 95 10 80 	movl   $0x801095ca,(%esp)
80103a50:	e8 e8 ca ff ff       	call   8010053d <panic>

  for (i = 0; i < log.lh.n; i++) {
80103a55:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80103a5c:	eb 1d                	jmp    80103a7b <log_write+0x69>
    if (log.lh.sector[i] == b->sector)   // log absorbtion?
80103a5e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103a61:	83 c0 10             	add    $0x10,%eax
80103a64:	8b 04 85 e8 17 11 80 	mov    -0x7feee818(,%eax,4),%eax
80103a6b:	89 c2                	mov    %eax,%edx
80103a6d:	8b 45 08             	mov    0x8(%ebp),%eax
80103a70:	8b 40 08             	mov    0x8(%eax),%eax
80103a73:	39 c2                	cmp    %eax,%edx
80103a75:	74 10                	je     80103a87 <log_write+0x75>
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
    panic("too big a transaction");
  if (!log.busy)
    panic("write outside of trans");

  for (i = 0; i < log.lh.n; i++) {
80103a77:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80103a7b:	a1 24 18 11 80       	mov    0x80111824,%eax
80103a80:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80103a83:	7f d9                	jg     80103a5e <log_write+0x4c>
80103a85:	eb 01                	jmp    80103a88 <log_write+0x76>
    if (log.lh.sector[i] == b->sector)   // log absorbtion?
      break;
80103a87:	90                   	nop
  }
  log.lh.sector[i] = b->sector;
80103a88:	8b 45 08             	mov    0x8(%ebp),%eax
80103a8b:	8b 40 08             	mov    0x8(%eax),%eax
80103a8e:	8b 55 f4             	mov    -0xc(%ebp),%edx
80103a91:	83 c2 10             	add    $0x10,%edx
80103a94:	89 04 95 e8 17 11 80 	mov    %eax,-0x7feee818(,%edx,4)
  struct buf *lbuf = bread(b->dev, log.start+i+1);
80103a9b:	a1 14 18 11 80       	mov    0x80111814,%eax
80103aa0:	03 45 f4             	add    -0xc(%ebp),%eax
80103aa3:	83 c0 01             	add    $0x1,%eax
80103aa6:	89 c2                	mov    %eax,%edx
80103aa8:	8b 45 08             	mov    0x8(%ebp),%eax
80103aab:	8b 40 04             	mov    0x4(%eax),%eax
80103aae:	89 54 24 04          	mov    %edx,0x4(%esp)
80103ab2:	89 04 24             	mov    %eax,(%esp)
80103ab5:	e8 ec c6 ff ff       	call   801001a6 <bread>
80103aba:	89 45 f0             	mov    %eax,-0x10(%ebp)
  memmove(lbuf->data, b->data, BSIZE);
80103abd:	8b 45 08             	mov    0x8(%ebp),%eax
80103ac0:	8d 50 18             	lea    0x18(%eax),%edx
80103ac3:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103ac6:	83 c0 18             	add    $0x18,%eax
80103ac9:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
80103ad0:	00 
80103ad1:	89 54 24 04          	mov    %edx,0x4(%esp)
80103ad5:	89 04 24             	mov    %eax,(%esp)
80103ad8:	e8 fc 22 00 00       	call   80105dd9 <memmove>
  bwrite(lbuf);
80103add:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103ae0:	89 04 24             	mov    %eax,(%esp)
80103ae3:	e8 f5 c6 ff ff       	call   801001dd <bwrite>
  brelse(lbuf);
80103ae8:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103aeb:	89 04 24             	mov    %eax,(%esp)
80103aee:	e8 24 c7 ff ff       	call   80100217 <brelse>
  if (i == log.lh.n)
80103af3:	a1 24 18 11 80       	mov    0x80111824,%eax
80103af8:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80103afb:	75 0d                	jne    80103b0a <log_write+0xf8>
    log.lh.n++;
80103afd:	a1 24 18 11 80       	mov    0x80111824,%eax
80103b02:	83 c0 01             	add    $0x1,%eax
80103b05:	a3 24 18 11 80       	mov    %eax,0x80111824
  b->flags |= B_DIRTY; // XXX prevent eviction
80103b0a:	8b 45 08             	mov    0x8(%ebp),%eax
80103b0d:	8b 00                	mov    (%eax),%eax
80103b0f:	89 c2                	mov    %eax,%edx
80103b11:	83 ca 04             	or     $0x4,%edx
80103b14:	8b 45 08             	mov    0x8(%ebp),%eax
80103b17:	89 10                	mov    %edx,(%eax)
}
80103b19:	c9                   	leave  
80103b1a:	c3                   	ret    
	...

80103b1c <v2p>:
80103b1c:	55                   	push   %ebp
80103b1d:	89 e5                	mov    %esp,%ebp
80103b1f:	8b 45 08             	mov    0x8(%ebp),%eax
80103b22:	05 00 00 00 80       	add    $0x80000000,%eax
80103b27:	5d                   	pop    %ebp
80103b28:	c3                   	ret    

80103b29 <p2v>:
static inline void *p2v(uint a) { return (void *) ((a) + KERNBASE); }
80103b29:	55                   	push   %ebp
80103b2a:	89 e5                	mov    %esp,%ebp
80103b2c:	8b 45 08             	mov    0x8(%ebp),%eax
80103b2f:	05 00 00 00 80       	add    $0x80000000,%eax
80103b34:	5d                   	pop    %ebp
80103b35:	c3                   	ret    

80103b36 <xchg>:
  asm volatile("sti");
}

static inline uint
xchg(volatile uint *addr, uint newval)
{
80103b36:	55                   	push   %ebp
80103b37:	89 e5                	mov    %esp,%ebp
80103b39:	53                   	push   %ebx
80103b3a:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
               "+m" (*addr), "=a" (result) :
80103b3d:	8b 55 08             	mov    0x8(%ebp),%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80103b40:	8b 45 0c             	mov    0xc(%ebp),%eax
               "+m" (*addr), "=a" (result) :
80103b43:	8b 4d 08             	mov    0x8(%ebp),%ecx
xchg(volatile uint *addr, uint newval)
{
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80103b46:	89 c3                	mov    %eax,%ebx
80103b48:	89 d8                	mov    %ebx,%eax
80103b4a:	f0 87 02             	lock xchg %eax,(%edx)
80103b4d:	89 c3                	mov    %eax,%ebx
80103b4f:	89 5d f8             	mov    %ebx,-0x8(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
80103b52:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
80103b55:	83 c4 10             	add    $0x10,%esp
80103b58:	5b                   	pop    %ebx
80103b59:	5d                   	pop    %ebp
80103b5a:	c3                   	ret    

80103b5b <main>:
// Bootstrap processor starts running C code here.
// Allocate a real stack and switch to it, first
// doing some setup required for memory allocator to work.
int
main(void)
{
80103b5b:	55                   	push   %ebp
80103b5c:	89 e5                	mov    %esp,%ebp
80103b5e:	83 e4 f0             	and    $0xfffffff0,%esp
80103b61:	83 ec 10             	sub    $0x10,%esp
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
80103b64:	c7 44 24 04 00 00 40 	movl   $0x80400000,0x4(%esp)
80103b6b:	80 
80103b6c:	c7 04 24 bc 72 11 80 	movl   $0x801172bc,(%esp)
80103b73:	e8 ad f5 ff ff       	call   80103125 <kinit1>
  kvmalloc();      // kernel page table
80103b78:	e8 91 50 00 00       	call   80108c0e <kvmalloc>
  mpinit();        // collect info about this machine
80103b7d:	e8 63 04 00 00       	call   80103fe5 <mpinit>
  lapicinit(mpbcpu());
80103b82:	e8 2e 02 00 00       	call   80103db5 <mpbcpu>
80103b87:	89 04 24             	mov    %eax,(%esp)
80103b8a:	e8 f5 f8 ff ff       	call   80103484 <lapicinit>
  seginit();       // set up segments
80103b8f:	e8 1d 4a 00 00       	call   801085b1 <seginit>
  cprintf("\ncpu%d: starting xv6\n\n", cpu->id);
80103b94:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80103b9a:	0f b6 00             	movzbl (%eax),%eax
80103b9d:	0f b6 c0             	movzbl %al,%eax
80103ba0:	89 44 24 04          	mov    %eax,0x4(%esp)
80103ba4:	c7 04 24 e1 95 10 80 	movl   $0x801095e1,(%esp)
80103bab:	e8 f1 c7 ff ff       	call   801003a1 <cprintf>
  picinit();       // interrupt controller
80103bb0:	e8 95 06 00 00       	call   8010424a <picinit>
  ioapicinit();    // another interrupt controller
80103bb5:	e8 5b f4 ff ff       	call   80103015 <ioapicinit>
  consoleinit();   // I/O devices & their interrupts
80103bba:	e8 4d d5 ff ff       	call   8010110c <consoleinit>
  uartinit();      // serial port
80103bbf:	e8 38 3d 00 00       	call   801078fc <uartinit>
  pinit();         // process table
80103bc4:	e8 01 0c 00 00       	call   801047ca <pinit>
  tvinit();        // trap vectors
80103bc9:	e8 c9 38 00 00       	call   80107497 <tvinit>
  binit();         // buffer cache
80103bce:	e8 61 c4 ff ff       	call   80100034 <binit>
  fileinit();      // file table
80103bd3:	e8 7c da ff ff       	call   80101654 <fileinit>
  iinit();         // inode cache
80103bd8:	e8 2a e1 ff ff       	call   80101d07 <iinit>
  ideinit();       // disk
80103bdd:	e8 98 f0 ff ff       	call   80102c7a <ideinit>
  if(!ismp)
80103be2:	a1 64 18 11 80       	mov    0x80111864,%eax
80103be7:	85 c0                	test   %eax,%eax
80103be9:	75 05                	jne    80103bf0 <main+0x95>
    timerinit();   // uniprocessor timer
80103beb:	e8 ea 37 00 00       	call   801073da <timerinit>
  startothers();   // start other processors
80103bf0:	e8 87 00 00 00       	call   80103c7c <startothers>
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80103bf5:	c7 44 24 04 00 00 00 	movl   $0x8e000000,0x4(%esp)
80103bfc:	8e 
80103bfd:	c7 04 24 00 00 40 80 	movl   $0x80400000,(%esp)
80103c04:	e8 54 f5 ff ff       	call   8010315d <kinit2>
  userinit();      // first user process
80103c09:	e8 a9 0f 00 00       	call   80104bb7 <userinit>
  // Finish setting up this processor in mpmain.
  mpmain();
80103c0e:	e8 22 00 00 00       	call   80103c35 <mpmain>

80103c13 <mpenter>:
}

// Other CPUs jump here from entryother.S.
static void
mpenter(void)
{
80103c13:	55                   	push   %ebp
80103c14:	89 e5                	mov    %esp,%ebp
80103c16:	83 ec 18             	sub    $0x18,%esp
  switchkvm(); 
80103c19:	e8 07 50 00 00       	call   80108c25 <switchkvm>
  seginit();
80103c1e:	e8 8e 49 00 00       	call   801085b1 <seginit>
  lapicinit(cpunum());
80103c23:	e8 b9 f9 ff ff       	call   801035e1 <cpunum>
80103c28:	89 04 24             	mov    %eax,(%esp)
80103c2b:	e8 54 f8 ff ff       	call   80103484 <lapicinit>
  mpmain();
80103c30:	e8 00 00 00 00       	call   80103c35 <mpmain>

80103c35 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
80103c35:	55                   	push   %ebp
80103c36:	89 e5                	mov    %esp,%ebp
80103c38:	83 ec 18             	sub    $0x18,%esp
  cprintf("cpu%d: starting\n", cpu->id);
80103c3b:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80103c41:	0f b6 00             	movzbl (%eax),%eax
80103c44:	0f b6 c0             	movzbl %al,%eax
80103c47:	89 44 24 04          	mov    %eax,0x4(%esp)
80103c4b:	c7 04 24 f8 95 10 80 	movl   $0x801095f8,(%esp)
80103c52:	e8 4a c7 ff ff       	call   801003a1 <cprintf>
  idtinit();       // load idt register
80103c57:	e8 af 39 00 00       	call   8010760b <idtinit>
  xchg(&cpu->started, 1); // tell startothers() we're up
80103c5c:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80103c62:	05 a8 00 00 00       	add    $0xa8,%eax
80103c67:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
80103c6e:	00 
80103c6f:	89 04 24             	mov    %eax,(%esp)
80103c72:	e8 bf fe ff ff       	call   80103b36 <xchg>
  scheduler();     // start running processes
80103c77:	e8 30 18 00 00       	call   801054ac <scheduler>

80103c7c <startothers>:
pde_t entrypgdir[];  // For entry.S

// Start the non-boot (AP) processors.
static void
startothers(void)
{
80103c7c:	55                   	push   %ebp
80103c7d:	89 e5                	mov    %esp,%ebp
80103c7f:	53                   	push   %ebx
80103c80:	83 ec 24             	sub    $0x24,%esp
  char *stack;

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = p2v(0x7000);
80103c83:	c7 04 24 00 70 00 00 	movl   $0x7000,(%esp)
80103c8a:	e8 9a fe ff ff       	call   80103b29 <p2v>
80103c8f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80103c92:	b8 8a 00 00 00       	mov    $0x8a,%eax
80103c97:	89 44 24 08          	mov    %eax,0x8(%esp)
80103c9b:	c7 44 24 04 2c c5 10 	movl   $0x8010c52c,0x4(%esp)
80103ca2:	80 
80103ca3:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103ca6:	89 04 24             	mov    %eax,(%esp)
80103ca9:	e8 2b 21 00 00       	call   80105dd9 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
80103cae:	c7 45 f4 80 18 11 80 	movl   $0x80111880,-0xc(%ebp)
80103cb5:	e9 86 00 00 00       	jmp    80103d40 <startothers+0xc4>
    if(c == cpus+cpunum())  // We've started already.
80103cba:	e8 22 f9 ff ff       	call   801035e1 <cpunum>
80103cbf:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
80103cc5:	05 80 18 11 80       	add    $0x80111880,%eax
80103cca:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80103ccd:	74 69                	je     80103d38 <startothers+0xbc>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what 
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
80103ccf:	e8 7f f5 ff ff       	call   80103253 <kalloc>
80103cd4:	89 45 ec             	mov    %eax,-0x14(%ebp)
    *(void**)(code-4) = stack + KSTACKSIZE;
80103cd7:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103cda:	83 e8 04             	sub    $0x4,%eax
80103cdd:	8b 55 ec             	mov    -0x14(%ebp),%edx
80103ce0:	81 c2 00 10 00 00    	add    $0x1000,%edx
80103ce6:	89 10                	mov    %edx,(%eax)
    *(void**)(code-8) = mpenter;
80103ce8:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103ceb:	83 e8 08             	sub    $0x8,%eax
80103cee:	c7 00 13 3c 10 80    	movl   $0x80103c13,(%eax)
    *(int**)(code-12) = (void *) v2p(entrypgdir);
80103cf4:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103cf7:	8d 58 f4             	lea    -0xc(%eax),%ebx
80103cfa:	c7 04 24 00 b0 10 80 	movl   $0x8010b000,(%esp)
80103d01:	e8 16 fe ff ff       	call   80103b1c <v2p>
80103d06:	89 03                	mov    %eax,(%ebx)

    lapicstartap(c->id, v2p(code));
80103d08:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103d0b:	89 04 24             	mov    %eax,(%esp)
80103d0e:	e8 09 fe ff ff       	call   80103b1c <v2p>
80103d13:	8b 55 f4             	mov    -0xc(%ebp),%edx
80103d16:	0f b6 12             	movzbl (%edx),%edx
80103d19:	0f b6 d2             	movzbl %dl,%edx
80103d1c:	89 44 24 04          	mov    %eax,0x4(%esp)
80103d20:	89 14 24             	mov    %edx,(%esp)
80103d23:	e8 3f f9 ff ff       	call   80103667 <lapicstartap>

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80103d28:	90                   	nop
80103d29:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103d2c:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
80103d32:	85 c0                	test   %eax,%eax
80103d34:	74 f3                	je     80103d29 <startothers+0xad>
80103d36:	eb 01                	jmp    80103d39 <startothers+0xbd>
  code = p2v(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);

  for(c = cpus; c < cpus+ncpu; c++){
    if(c == cpus+cpunum())  // We've started already.
      continue;
80103d38:	90                   	nop
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = p2v(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);

  for(c = cpus; c < cpus+ncpu; c++){
80103d39:	81 45 f4 bc 00 00 00 	addl   $0xbc,-0xc(%ebp)
80103d40:	a1 60 1e 11 80       	mov    0x80111e60,%eax
80103d45:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
80103d4b:	05 80 18 11 80       	add    $0x80111880,%eax
80103d50:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80103d53:	0f 87 61 ff ff ff    	ja     80103cba <startothers+0x3e>

    // wait for cpu to finish mpmain()
    while(c->started == 0)
      ;
  }
}
80103d59:	83 c4 24             	add    $0x24,%esp
80103d5c:	5b                   	pop    %ebx
80103d5d:	5d                   	pop    %ebp
80103d5e:	c3                   	ret    
	...

80103d60 <p2v>:
80103d60:	55                   	push   %ebp
80103d61:	89 e5                	mov    %esp,%ebp
80103d63:	8b 45 08             	mov    0x8(%ebp),%eax
80103d66:	05 00 00 00 80       	add    $0x80000000,%eax
80103d6b:	5d                   	pop    %ebp
80103d6c:	c3                   	ret    

80103d6d <inb>:
// Routines to let C code use special x86 instructions.

static inline uchar
inb(ushort port)
{
80103d6d:	55                   	push   %ebp
80103d6e:	89 e5                	mov    %esp,%ebp
80103d70:	53                   	push   %ebx
80103d71:	83 ec 14             	sub    $0x14,%esp
80103d74:	8b 45 08             	mov    0x8(%ebp),%eax
80103d77:	66 89 45 e8          	mov    %ax,-0x18(%ebp)
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103d7b:	0f b7 55 e8          	movzwl -0x18(%ebp),%edx
80103d7f:	66 89 55 ea          	mov    %dx,-0x16(%ebp)
80103d83:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
80103d87:	ec                   	in     (%dx),%al
80103d88:	89 c3                	mov    %eax,%ebx
80103d8a:	88 5d fb             	mov    %bl,-0x5(%ebp)
  return data;
80103d8d:	0f b6 45 fb          	movzbl -0x5(%ebp),%eax
}
80103d91:	83 c4 14             	add    $0x14,%esp
80103d94:	5b                   	pop    %ebx
80103d95:	5d                   	pop    %ebp
80103d96:	c3                   	ret    

80103d97 <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
80103d97:	55                   	push   %ebp
80103d98:	89 e5                	mov    %esp,%ebp
80103d9a:	83 ec 08             	sub    $0x8,%esp
80103d9d:	8b 55 08             	mov    0x8(%ebp),%edx
80103da0:	8b 45 0c             	mov    0xc(%ebp),%eax
80103da3:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
80103da7:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103daa:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80103dae:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
80103db2:	ee                   	out    %al,(%dx)
}
80103db3:	c9                   	leave  
80103db4:	c3                   	ret    

80103db5 <mpbcpu>:
int ncpu;
uchar ioapicid;

int
mpbcpu(void)
{
80103db5:	55                   	push   %ebp
80103db6:	89 e5                	mov    %esp,%ebp
  return bcpu-cpus;
80103db8:	a1 84 cb 10 80       	mov    0x8010cb84,%eax
80103dbd:	89 c2                	mov    %eax,%edx
80103dbf:	b8 80 18 11 80       	mov    $0x80111880,%eax
80103dc4:	89 d1                	mov    %edx,%ecx
80103dc6:	29 c1                	sub    %eax,%ecx
80103dc8:	89 c8                	mov    %ecx,%eax
80103dca:	c1 f8 02             	sar    $0x2,%eax
80103dcd:	69 c0 cf 46 7d 67    	imul   $0x677d46cf,%eax,%eax
}
80103dd3:	5d                   	pop    %ebp
80103dd4:	c3                   	ret    

80103dd5 <sum>:

static uchar
sum(uchar *addr, int len)
{
80103dd5:	55                   	push   %ebp
80103dd6:	89 e5                	mov    %esp,%ebp
80103dd8:	83 ec 10             	sub    $0x10,%esp
  int i, sum;
  
  sum = 0;
80103ddb:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  for(i=0; i<len; i++)
80103de2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
80103de9:	eb 13                	jmp    80103dfe <sum+0x29>
    sum += addr[i];
80103deb:	8b 45 fc             	mov    -0x4(%ebp),%eax
80103dee:	03 45 08             	add    0x8(%ebp),%eax
80103df1:	0f b6 00             	movzbl (%eax),%eax
80103df4:	0f b6 c0             	movzbl %al,%eax
80103df7:	01 45 f8             	add    %eax,-0x8(%ebp)
sum(uchar *addr, int len)
{
  int i, sum;
  
  sum = 0;
  for(i=0; i<len; i++)
80103dfa:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
80103dfe:	8b 45 fc             	mov    -0x4(%ebp),%eax
80103e01:	3b 45 0c             	cmp    0xc(%ebp),%eax
80103e04:	7c e5                	jl     80103deb <sum+0x16>
    sum += addr[i];
  return sum;
80103e06:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
80103e09:	c9                   	leave  
80103e0a:	c3                   	ret    

80103e0b <mpsearch1>:

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80103e0b:	55                   	push   %ebp
80103e0c:	89 e5                	mov    %esp,%ebp
80103e0e:	83 ec 28             	sub    $0x28,%esp
  uchar *e, *p, *addr;

  addr = p2v(a);
80103e11:	8b 45 08             	mov    0x8(%ebp),%eax
80103e14:	89 04 24             	mov    %eax,(%esp)
80103e17:	e8 44 ff ff ff       	call   80103d60 <p2v>
80103e1c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  e = addr+len;
80103e1f:	8b 45 0c             	mov    0xc(%ebp),%eax
80103e22:	03 45 f0             	add    -0x10(%ebp),%eax
80103e25:	89 45 ec             	mov    %eax,-0x14(%ebp)
  for(p = addr; p < e; p += sizeof(struct mp))
80103e28:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103e2b:	89 45 f4             	mov    %eax,-0xc(%ebp)
80103e2e:	eb 3f                	jmp    80103e6f <mpsearch1+0x64>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103e30:	c7 44 24 08 04 00 00 	movl   $0x4,0x8(%esp)
80103e37:	00 
80103e38:	c7 44 24 04 0c 96 10 	movl   $0x8010960c,0x4(%esp)
80103e3f:	80 
80103e40:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103e43:	89 04 24             	mov    %eax,(%esp)
80103e46:	e8 32 1f 00 00       	call   80105d7d <memcmp>
80103e4b:	85 c0                	test   %eax,%eax
80103e4d:	75 1c                	jne    80103e6b <mpsearch1+0x60>
80103e4f:	c7 44 24 04 10 00 00 	movl   $0x10,0x4(%esp)
80103e56:	00 
80103e57:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103e5a:	89 04 24             	mov    %eax,(%esp)
80103e5d:	e8 73 ff ff ff       	call   80103dd5 <sum>
80103e62:	84 c0                	test   %al,%al
80103e64:	75 05                	jne    80103e6b <mpsearch1+0x60>
      return (struct mp*)p;
80103e66:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103e69:	eb 11                	jmp    80103e7c <mpsearch1+0x71>
{
  uchar *e, *p, *addr;

  addr = p2v(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
80103e6b:	83 45 f4 10          	addl   $0x10,-0xc(%ebp)
80103e6f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103e72:	3b 45 ec             	cmp    -0x14(%ebp),%eax
80103e75:	72 b9                	jb     80103e30 <mpsearch1+0x25>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
      return (struct mp*)p;
  return 0;
80103e77:	b8 00 00 00 00       	mov    $0x0,%eax
}
80103e7c:	c9                   	leave  
80103e7d:	c3                   	ret    

80103e7e <mpsearch>:
// 1) in the first KB of the EBDA;
// 2) in the last KB of system base memory;
// 3) in the BIOS ROM between 0xE0000 and 0xFFFFF.
static struct mp*
mpsearch(void)
{
80103e7e:	55                   	push   %ebp
80103e7f:	89 e5                	mov    %esp,%ebp
80103e81:	83 ec 28             	sub    $0x28,%esp
  uchar *bda;
  uint p;
  struct mp *mp;

  bda = (uchar *) P2V(0x400);
80103e84:	c7 45 f4 00 04 00 80 	movl   $0x80000400,-0xc(%ebp)
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
80103e8b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103e8e:	83 c0 0f             	add    $0xf,%eax
80103e91:	0f b6 00             	movzbl (%eax),%eax
80103e94:	0f b6 c0             	movzbl %al,%eax
80103e97:	89 c2                	mov    %eax,%edx
80103e99:	c1 e2 08             	shl    $0x8,%edx
80103e9c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103e9f:	83 c0 0e             	add    $0xe,%eax
80103ea2:	0f b6 00             	movzbl (%eax),%eax
80103ea5:	0f b6 c0             	movzbl %al,%eax
80103ea8:	09 d0                	or     %edx,%eax
80103eaa:	c1 e0 04             	shl    $0x4,%eax
80103ead:	89 45 f0             	mov    %eax,-0x10(%ebp)
80103eb0:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80103eb4:	74 21                	je     80103ed7 <mpsearch+0x59>
    if((mp = mpsearch1(p, 1024)))
80103eb6:	c7 44 24 04 00 04 00 	movl   $0x400,0x4(%esp)
80103ebd:	00 
80103ebe:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103ec1:	89 04 24             	mov    %eax,(%esp)
80103ec4:	e8 42 ff ff ff       	call   80103e0b <mpsearch1>
80103ec9:	89 45 ec             	mov    %eax,-0x14(%ebp)
80103ecc:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80103ed0:	74 50                	je     80103f22 <mpsearch+0xa4>
      return mp;
80103ed2:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103ed5:	eb 5f                	jmp    80103f36 <mpsearch+0xb8>
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
80103ed7:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103eda:	83 c0 14             	add    $0x14,%eax
80103edd:	0f b6 00             	movzbl (%eax),%eax
80103ee0:	0f b6 c0             	movzbl %al,%eax
80103ee3:	89 c2                	mov    %eax,%edx
80103ee5:	c1 e2 08             	shl    $0x8,%edx
80103ee8:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103eeb:	83 c0 13             	add    $0x13,%eax
80103eee:	0f b6 00             	movzbl (%eax),%eax
80103ef1:	0f b6 c0             	movzbl %al,%eax
80103ef4:	09 d0                	or     %edx,%eax
80103ef6:	c1 e0 0a             	shl    $0xa,%eax
80103ef9:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if((mp = mpsearch1(p-1024, 1024)))
80103efc:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103eff:	2d 00 04 00 00       	sub    $0x400,%eax
80103f04:	c7 44 24 04 00 04 00 	movl   $0x400,0x4(%esp)
80103f0b:	00 
80103f0c:	89 04 24             	mov    %eax,(%esp)
80103f0f:	e8 f7 fe ff ff       	call   80103e0b <mpsearch1>
80103f14:	89 45 ec             	mov    %eax,-0x14(%ebp)
80103f17:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80103f1b:	74 05                	je     80103f22 <mpsearch+0xa4>
      return mp;
80103f1d:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103f20:	eb 14                	jmp    80103f36 <mpsearch+0xb8>
  }
  return mpsearch1(0xF0000, 0x10000);
80103f22:	c7 44 24 04 00 00 01 	movl   $0x10000,0x4(%esp)
80103f29:	00 
80103f2a:	c7 04 24 00 00 0f 00 	movl   $0xf0000,(%esp)
80103f31:	e8 d5 fe ff ff       	call   80103e0b <mpsearch1>
}
80103f36:	c9                   	leave  
80103f37:	c3                   	ret    

80103f38 <mpconfig>:
// Check for correct signature, calculate the checksum and,
// if correct, check the version.
// To do: check extended table checksum.
static struct mpconf*
mpconfig(struct mp **pmp)
{
80103f38:	55                   	push   %ebp
80103f39:	89 e5                	mov    %esp,%ebp
80103f3b:	83 ec 28             	sub    $0x28,%esp
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103f3e:	e8 3b ff ff ff       	call   80103e7e <mpsearch>
80103f43:	89 45 f4             	mov    %eax,-0xc(%ebp)
80103f46:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80103f4a:	74 0a                	je     80103f56 <mpconfig+0x1e>
80103f4c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103f4f:	8b 40 04             	mov    0x4(%eax),%eax
80103f52:	85 c0                	test   %eax,%eax
80103f54:	75 0a                	jne    80103f60 <mpconfig+0x28>
    return 0;
80103f56:	b8 00 00 00 00       	mov    $0x0,%eax
80103f5b:	e9 83 00 00 00       	jmp    80103fe3 <mpconfig+0xab>
  conf = (struct mpconf*) p2v((uint) mp->physaddr);
80103f60:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103f63:	8b 40 04             	mov    0x4(%eax),%eax
80103f66:	89 04 24             	mov    %eax,(%esp)
80103f69:	e8 f2 fd ff ff       	call   80103d60 <p2v>
80103f6e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(memcmp(conf, "PCMP", 4) != 0)
80103f71:	c7 44 24 08 04 00 00 	movl   $0x4,0x8(%esp)
80103f78:	00 
80103f79:	c7 44 24 04 11 96 10 	movl   $0x80109611,0x4(%esp)
80103f80:	80 
80103f81:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103f84:	89 04 24             	mov    %eax,(%esp)
80103f87:	e8 f1 1d 00 00       	call   80105d7d <memcmp>
80103f8c:	85 c0                	test   %eax,%eax
80103f8e:	74 07                	je     80103f97 <mpconfig+0x5f>
    return 0;
80103f90:	b8 00 00 00 00       	mov    $0x0,%eax
80103f95:	eb 4c                	jmp    80103fe3 <mpconfig+0xab>
  if(conf->version != 1 && conf->version != 4)
80103f97:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103f9a:	0f b6 40 06          	movzbl 0x6(%eax),%eax
80103f9e:	3c 01                	cmp    $0x1,%al
80103fa0:	74 12                	je     80103fb4 <mpconfig+0x7c>
80103fa2:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103fa5:	0f b6 40 06          	movzbl 0x6(%eax),%eax
80103fa9:	3c 04                	cmp    $0x4,%al
80103fab:	74 07                	je     80103fb4 <mpconfig+0x7c>
    return 0;
80103fad:	b8 00 00 00 00       	mov    $0x0,%eax
80103fb2:	eb 2f                	jmp    80103fe3 <mpconfig+0xab>
  if(sum((uchar*)conf, conf->length) != 0)
80103fb4:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103fb7:	0f b7 40 04          	movzwl 0x4(%eax),%eax
80103fbb:	0f b7 c0             	movzwl %ax,%eax
80103fbe:	89 44 24 04          	mov    %eax,0x4(%esp)
80103fc2:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103fc5:	89 04 24             	mov    %eax,(%esp)
80103fc8:	e8 08 fe ff ff       	call   80103dd5 <sum>
80103fcd:	84 c0                	test   %al,%al
80103fcf:	74 07                	je     80103fd8 <mpconfig+0xa0>
    return 0;
80103fd1:	b8 00 00 00 00       	mov    $0x0,%eax
80103fd6:	eb 0b                	jmp    80103fe3 <mpconfig+0xab>
  *pmp = mp;
80103fd8:	8b 45 08             	mov    0x8(%ebp),%eax
80103fdb:	8b 55 f4             	mov    -0xc(%ebp),%edx
80103fde:	89 10                	mov    %edx,(%eax)
  return conf;
80103fe0:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
80103fe3:	c9                   	leave  
80103fe4:	c3                   	ret    

80103fe5 <mpinit>:

void
mpinit(void)
{
80103fe5:	55                   	push   %ebp
80103fe6:	89 e5                	mov    %esp,%ebp
80103fe8:	83 ec 38             	sub    $0x38,%esp
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  bcpu = &cpus[0];
80103feb:	c7 05 84 cb 10 80 80 	movl   $0x80111880,0x8010cb84
80103ff2:	18 11 80 
  if((conf = mpconfig(&mp)) == 0)
80103ff5:	8d 45 e0             	lea    -0x20(%ebp),%eax
80103ff8:	89 04 24             	mov    %eax,(%esp)
80103ffb:	e8 38 ff ff ff       	call   80103f38 <mpconfig>
80104000:	89 45 f0             	mov    %eax,-0x10(%ebp)
80104003:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80104007:	0f 84 9c 01 00 00    	je     801041a9 <mpinit+0x1c4>
    return;
  ismp = 1;
8010400d:	c7 05 64 18 11 80 01 	movl   $0x1,0x80111864
80104014:	00 00 00 
  lapic = (uint*)conf->lapicaddr;
80104017:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010401a:	8b 40 24             	mov    0x24(%eax),%eax
8010401d:	a3 dc 17 11 80       	mov    %eax,0x801117dc
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80104022:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104025:	83 c0 2c             	add    $0x2c,%eax
80104028:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010402b:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010402e:	0f b7 40 04          	movzwl 0x4(%eax),%eax
80104032:	0f b7 c0             	movzwl %ax,%eax
80104035:	03 45 f0             	add    -0x10(%ebp),%eax
80104038:	89 45 ec             	mov    %eax,-0x14(%ebp)
8010403b:	e9 f4 00 00 00       	jmp    80104134 <mpinit+0x14f>
    switch(*p){
80104040:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104043:	0f b6 00             	movzbl (%eax),%eax
80104046:	0f b6 c0             	movzbl %al,%eax
80104049:	83 f8 04             	cmp    $0x4,%eax
8010404c:	0f 87 bf 00 00 00    	ja     80104111 <mpinit+0x12c>
80104052:	8b 04 85 54 96 10 80 	mov    -0x7fef69ac(,%eax,4),%eax
80104059:	ff e0                	jmp    *%eax
    case MPPROC:
      proc = (struct mpproc*)p;
8010405b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010405e:	89 45 e8             	mov    %eax,-0x18(%ebp)
      if(ncpu != proc->apicid){
80104061:	8b 45 e8             	mov    -0x18(%ebp),%eax
80104064:	0f b6 40 01          	movzbl 0x1(%eax),%eax
80104068:	0f b6 d0             	movzbl %al,%edx
8010406b:	a1 60 1e 11 80       	mov    0x80111e60,%eax
80104070:	39 c2                	cmp    %eax,%edx
80104072:	74 2d                	je     801040a1 <mpinit+0xbc>
        cprintf("mpinit: ncpu=%d apicid=%d\n", ncpu, proc->apicid);
80104074:	8b 45 e8             	mov    -0x18(%ebp),%eax
80104077:	0f b6 40 01          	movzbl 0x1(%eax),%eax
8010407b:	0f b6 d0             	movzbl %al,%edx
8010407e:	a1 60 1e 11 80       	mov    0x80111e60,%eax
80104083:	89 54 24 08          	mov    %edx,0x8(%esp)
80104087:	89 44 24 04          	mov    %eax,0x4(%esp)
8010408b:	c7 04 24 16 96 10 80 	movl   $0x80109616,(%esp)
80104092:	e8 0a c3 ff ff       	call   801003a1 <cprintf>
        ismp = 0;
80104097:	c7 05 64 18 11 80 00 	movl   $0x0,0x80111864
8010409e:	00 00 00 
      }
      if(proc->flags & MPBOOT)
801040a1:	8b 45 e8             	mov    -0x18(%ebp),%eax
801040a4:	0f b6 40 03          	movzbl 0x3(%eax),%eax
801040a8:	0f b6 c0             	movzbl %al,%eax
801040ab:	83 e0 02             	and    $0x2,%eax
801040ae:	85 c0                	test   %eax,%eax
801040b0:	74 15                	je     801040c7 <mpinit+0xe2>
        bcpu = &cpus[ncpu];
801040b2:	a1 60 1e 11 80       	mov    0x80111e60,%eax
801040b7:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
801040bd:	05 80 18 11 80       	add    $0x80111880,%eax
801040c2:	a3 84 cb 10 80       	mov    %eax,0x8010cb84
      cpus[ncpu].id = ncpu;
801040c7:	8b 15 60 1e 11 80    	mov    0x80111e60,%edx
801040cd:	a1 60 1e 11 80       	mov    0x80111e60,%eax
801040d2:	69 d2 bc 00 00 00    	imul   $0xbc,%edx,%edx
801040d8:	81 c2 80 18 11 80    	add    $0x80111880,%edx
801040de:	88 02                	mov    %al,(%edx)
      ncpu++;
801040e0:	a1 60 1e 11 80       	mov    0x80111e60,%eax
801040e5:	83 c0 01             	add    $0x1,%eax
801040e8:	a3 60 1e 11 80       	mov    %eax,0x80111e60
      p += sizeof(struct mpproc);
801040ed:	83 45 f4 14          	addl   $0x14,-0xc(%ebp)
      continue;
801040f1:	eb 41                	jmp    80104134 <mpinit+0x14f>
    case MPIOAPIC:
      ioapic = (struct mpioapic*)p;
801040f3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801040f6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      ioapicid = ioapic->apicno;
801040f9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801040fc:	0f b6 40 01          	movzbl 0x1(%eax),%eax
80104100:	a2 60 18 11 80       	mov    %al,0x80111860
      p += sizeof(struct mpioapic);
80104105:	83 45 f4 08          	addl   $0x8,-0xc(%ebp)
      continue;
80104109:	eb 29                	jmp    80104134 <mpinit+0x14f>
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
8010410b:	83 45 f4 08          	addl   $0x8,-0xc(%ebp)
      continue;
8010410f:	eb 23                	jmp    80104134 <mpinit+0x14f>
    default:
      cprintf("mpinit: unknown config type %x\n", *p);
80104111:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104114:	0f b6 00             	movzbl (%eax),%eax
80104117:	0f b6 c0             	movzbl %al,%eax
8010411a:	89 44 24 04          	mov    %eax,0x4(%esp)
8010411e:	c7 04 24 34 96 10 80 	movl   $0x80109634,(%esp)
80104125:	e8 77 c2 ff ff       	call   801003a1 <cprintf>
      ismp = 0;
8010412a:	c7 05 64 18 11 80 00 	movl   $0x0,0x80111864
80104131:	00 00 00 
  bcpu = &cpus[0];
  if((conf = mpconfig(&mp)) == 0)
    return;
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80104134:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104137:	3b 45 ec             	cmp    -0x14(%ebp),%eax
8010413a:	0f 82 00 ff ff ff    	jb     80104040 <mpinit+0x5b>
    default:
      cprintf("mpinit: unknown config type %x\n", *p);
      ismp = 0;
    }
  }
  if(!ismp){
80104140:	a1 64 18 11 80       	mov    0x80111864,%eax
80104145:	85 c0                	test   %eax,%eax
80104147:	75 1d                	jne    80104166 <mpinit+0x181>
    // Didn't like what we found; fall back to no MP.
    ncpu = 1;
80104149:	c7 05 60 1e 11 80 01 	movl   $0x1,0x80111e60
80104150:	00 00 00 
    lapic = 0;
80104153:	c7 05 dc 17 11 80 00 	movl   $0x0,0x801117dc
8010415a:	00 00 00 
    ioapicid = 0;
8010415d:	c6 05 60 18 11 80 00 	movb   $0x0,0x80111860
    return;
80104164:	eb 44                	jmp    801041aa <mpinit+0x1c5>
  }

  if(mp->imcrp){
80104166:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104169:	0f b6 40 0c          	movzbl 0xc(%eax),%eax
8010416d:	84 c0                	test   %al,%al
8010416f:	74 39                	je     801041aa <mpinit+0x1c5>
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
80104171:	c7 44 24 04 70 00 00 	movl   $0x70,0x4(%esp)
80104178:	00 
80104179:	c7 04 24 22 00 00 00 	movl   $0x22,(%esp)
80104180:	e8 12 fc ff ff       	call   80103d97 <outb>
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
80104185:	c7 04 24 23 00 00 00 	movl   $0x23,(%esp)
8010418c:	e8 dc fb ff ff       	call   80103d6d <inb>
80104191:	83 c8 01             	or     $0x1,%eax
80104194:	0f b6 c0             	movzbl %al,%eax
80104197:	89 44 24 04          	mov    %eax,0x4(%esp)
8010419b:	c7 04 24 23 00 00 00 	movl   $0x23,(%esp)
801041a2:	e8 f0 fb ff ff       	call   80103d97 <outb>
801041a7:	eb 01                	jmp    801041aa <mpinit+0x1c5>
  struct mpproc *proc;
  struct mpioapic *ioapic;

  bcpu = &cpus[0];
  if((conf = mpconfig(&mp)) == 0)
    return;
801041a9:	90                   	nop
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
  }
}
801041aa:	c9                   	leave  
801041ab:	c3                   	ret    

801041ac <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
801041ac:	55                   	push   %ebp
801041ad:	89 e5                	mov    %esp,%ebp
801041af:	83 ec 08             	sub    $0x8,%esp
801041b2:	8b 55 08             	mov    0x8(%ebp),%edx
801041b5:	8b 45 0c             	mov    0xc(%ebp),%eax
801041b8:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
801041bc:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801041bf:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
801041c3:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
801041c7:	ee                   	out    %al,(%dx)
}
801041c8:	c9                   	leave  
801041c9:	c3                   	ret    

801041ca <picsetmask>:
// Initial IRQ mask has interrupt 2 enabled (for slave 8259A).
static ushort irqmask = 0xFFFF & ~(1<<IRQ_SLAVE);

static void
picsetmask(ushort mask)
{
801041ca:	55                   	push   %ebp
801041cb:	89 e5                	mov    %esp,%ebp
801041cd:	83 ec 0c             	sub    $0xc,%esp
801041d0:	8b 45 08             	mov    0x8(%ebp),%eax
801041d3:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  irqmask = mask;
801041d7:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
801041db:	66 a3 00 c0 10 80    	mov    %ax,0x8010c000
  outb(IO_PIC1+1, mask);
801041e1:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
801041e5:	0f b6 c0             	movzbl %al,%eax
801041e8:	89 44 24 04          	mov    %eax,0x4(%esp)
801041ec:	c7 04 24 21 00 00 00 	movl   $0x21,(%esp)
801041f3:	e8 b4 ff ff ff       	call   801041ac <outb>
  outb(IO_PIC2+1, mask >> 8);
801041f8:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
801041fc:	66 c1 e8 08          	shr    $0x8,%ax
80104200:	0f b6 c0             	movzbl %al,%eax
80104203:	89 44 24 04          	mov    %eax,0x4(%esp)
80104207:	c7 04 24 a1 00 00 00 	movl   $0xa1,(%esp)
8010420e:	e8 99 ff ff ff       	call   801041ac <outb>
}
80104213:	c9                   	leave  
80104214:	c3                   	ret    

80104215 <picenable>:

void
picenable(int irq)
{
80104215:	55                   	push   %ebp
80104216:	89 e5                	mov    %esp,%ebp
80104218:	53                   	push   %ebx
80104219:	83 ec 04             	sub    $0x4,%esp
  picsetmask(irqmask & ~(1<<irq));
8010421c:	8b 45 08             	mov    0x8(%ebp),%eax
8010421f:	ba 01 00 00 00       	mov    $0x1,%edx
80104224:	89 d3                	mov    %edx,%ebx
80104226:	89 c1                	mov    %eax,%ecx
80104228:	d3 e3                	shl    %cl,%ebx
8010422a:	89 d8                	mov    %ebx,%eax
8010422c:	89 c2                	mov    %eax,%edx
8010422e:	f7 d2                	not    %edx
80104230:	0f b7 05 00 c0 10 80 	movzwl 0x8010c000,%eax
80104237:	21 d0                	and    %edx,%eax
80104239:	0f b7 c0             	movzwl %ax,%eax
8010423c:	89 04 24             	mov    %eax,(%esp)
8010423f:	e8 86 ff ff ff       	call   801041ca <picsetmask>
}
80104244:	83 c4 04             	add    $0x4,%esp
80104247:	5b                   	pop    %ebx
80104248:	5d                   	pop    %ebp
80104249:	c3                   	ret    

8010424a <picinit>:

// Initialize the 8259A interrupt controllers.
void
picinit(void)
{
8010424a:	55                   	push   %ebp
8010424b:	89 e5                	mov    %esp,%ebp
8010424d:	83 ec 08             	sub    $0x8,%esp
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
80104250:	c7 44 24 04 ff 00 00 	movl   $0xff,0x4(%esp)
80104257:	00 
80104258:	c7 04 24 21 00 00 00 	movl   $0x21,(%esp)
8010425f:	e8 48 ff ff ff       	call   801041ac <outb>
  outb(IO_PIC2+1, 0xFF);
80104264:	c7 44 24 04 ff 00 00 	movl   $0xff,0x4(%esp)
8010426b:	00 
8010426c:	c7 04 24 a1 00 00 00 	movl   $0xa1,(%esp)
80104273:	e8 34 ff ff ff       	call   801041ac <outb>

  // ICW1:  0001g0hi
  //    g:  0 = edge triggering, 1 = level triggering
  //    h:  0 = cascaded PICs, 1 = master only
  //    i:  0 = no ICW4, 1 = ICW4 required
  outb(IO_PIC1, 0x11);
80104278:	c7 44 24 04 11 00 00 	movl   $0x11,0x4(%esp)
8010427f:	00 
80104280:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80104287:	e8 20 ff ff ff       	call   801041ac <outb>

  // ICW2:  Vector offset
  outb(IO_PIC1+1, T_IRQ0);
8010428c:	c7 44 24 04 20 00 00 	movl   $0x20,0x4(%esp)
80104293:	00 
80104294:	c7 04 24 21 00 00 00 	movl   $0x21,(%esp)
8010429b:	e8 0c ff ff ff       	call   801041ac <outb>

  // ICW3:  (master PIC) bit mask of IR lines connected to slaves
  //        (slave PIC) 3-bit # of slave's connection to master
  outb(IO_PIC1+1, 1<<IRQ_SLAVE);
801042a0:	c7 44 24 04 04 00 00 	movl   $0x4,0x4(%esp)
801042a7:	00 
801042a8:	c7 04 24 21 00 00 00 	movl   $0x21,(%esp)
801042af:	e8 f8 fe ff ff       	call   801041ac <outb>
  //    m:  0 = slave PIC, 1 = master PIC
  //      (ignored when b is 0, as the master/slave role
  //      can be hardwired).
  //    a:  1 = Automatic EOI mode
  //    p:  0 = MCS-80/85 mode, 1 = intel x86 mode
  outb(IO_PIC1+1, 0x3);
801042b4:	c7 44 24 04 03 00 00 	movl   $0x3,0x4(%esp)
801042bb:	00 
801042bc:	c7 04 24 21 00 00 00 	movl   $0x21,(%esp)
801042c3:	e8 e4 fe ff ff       	call   801041ac <outb>

  // Set up slave (8259A-2)
  outb(IO_PIC2, 0x11);                  // ICW1
801042c8:	c7 44 24 04 11 00 00 	movl   $0x11,0x4(%esp)
801042cf:	00 
801042d0:	c7 04 24 a0 00 00 00 	movl   $0xa0,(%esp)
801042d7:	e8 d0 fe ff ff       	call   801041ac <outb>
  outb(IO_PIC2+1, T_IRQ0 + 8);      // ICW2
801042dc:	c7 44 24 04 28 00 00 	movl   $0x28,0x4(%esp)
801042e3:	00 
801042e4:	c7 04 24 a1 00 00 00 	movl   $0xa1,(%esp)
801042eb:	e8 bc fe ff ff       	call   801041ac <outb>
  outb(IO_PIC2+1, IRQ_SLAVE);           // ICW3
801042f0:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
801042f7:	00 
801042f8:	c7 04 24 a1 00 00 00 	movl   $0xa1,(%esp)
801042ff:	e8 a8 fe ff ff       	call   801041ac <outb>
  // NB Automatic EOI mode doesn't tend to work on the slave.
  // Linux source code says it's "to be investigated".
  outb(IO_PIC2+1, 0x3);                 // ICW4
80104304:	c7 44 24 04 03 00 00 	movl   $0x3,0x4(%esp)
8010430b:	00 
8010430c:	c7 04 24 a1 00 00 00 	movl   $0xa1,(%esp)
80104313:	e8 94 fe ff ff       	call   801041ac <outb>

  // OCW3:  0ef01prs
  //   ef:  0x = NOP, 10 = clear specific mask, 11 = set specific mask
  //    p:  0 = no polling, 1 = polling mode
  //   rs:  0x = NOP, 10 = read IRR, 11 = read ISR
  outb(IO_PIC1, 0x68);             // clear specific mask
80104318:	c7 44 24 04 68 00 00 	movl   $0x68,0x4(%esp)
8010431f:	00 
80104320:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80104327:	e8 80 fe ff ff       	call   801041ac <outb>
  outb(IO_PIC1, 0x0a);             // read IRR by default
8010432c:	c7 44 24 04 0a 00 00 	movl   $0xa,0x4(%esp)
80104333:	00 
80104334:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
8010433b:	e8 6c fe ff ff       	call   801041ac <outb>

  outb(IO_PIC2, 0x68);             // OCW3
80104340:	c7 44 24 04 68 00 00 	movl   $0x68,0x4(%esp)
80104347:	00 
80104348:	c7 04 24 a0 00 00 00 	movl   $0xa0,(%esp)
8010434f:	e8 58 fe ff ff       	call   801041ac <outb>
  outb(IO_PIC2, 0x0a);             // OCW3
80104354:	c7 44 24 04 0a 00 00 	movl   $0xa,0x4(%esp)
8010435b:	00 
8010435c:	c7 04 24 a0 00 00 00 	movl   $0xa0,(%esp)
80104363:	e8 44 fe ff ff       	call   801041ac <outb>

  if(irqmask != 0xFFFF)
80104368:	0f b7 05 00 c0 10 80 	movzwl 0x8010c000,%eax
8010436f:	66 83 f8 ff          	cmp    $0xffff,%ax
80104373:	74 12                	je     80104387 <picinit+0x13d>
    picsetmask(irqmask);
80104375:	0f b7 05 00 c0 10 80 	movzwl 0x8010c000,%eax
8010437c:	0f b7 c0             	movzwl %ax,%eax
8010437f:	89 04 24             	mov    %eax,(%esp)
80104382:	e8 43 fe ff ff       	call   801041ca <picsetmask>
}
80104387:	c9                   	leave  
80104388:	c3                   	ret    
80104389:	00 00                	add    %al,(%eax)
	...

8010438c <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
8010438c:	55                   	push   %ebp
8010438d:	89 e5                	mov    %esp,%ebp
8010438f:	83 ec 28             	sub    $0x28,%esp
  struct pipe *p;

  p = 0;
80104392:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  *f0 = *f1 = 0;
80104399:	8b 45 0c             	mov    0xc(%ebp),%eax
8010439c:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
801043a2:	8b 45 0c             	mov    0xc(%ebp),%eax
801043a5:	8b 10                	mov    (%eax),%edx
801043a7:	8b 45 08             	mov    0x8(%ebp),%eax
801043aa:	89 10                	mov    %edx,(%eax)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
801043ac:	e8 bf d2 ff ff       	call   80101670 <filealloc>
801043b1:	8b 55 08             	mov    0x8(%ebp),%edx
801043b4:	89 02                	mov    %eax,(%edx)
801043b6:	8b 45 08             	mov    0x8(%ebp),%eax
801043b9:	8b 00                	mov    (%eax),%eax
801043bb:	85 c0                	test   %eax,%eax
801043bd:	0f 84 c8 00 00 00    	je     8010448b <pipealloc+0xff>
801043c3:	e8 a8 d2 ff ff       	call   80101670 <filealloc>
801043c8:	8b 55 0c             	mov    0xc(%ebp),%edx
801043cb:	89 02                	mov    %eax,(%edx)
801043cd:	8b 45 0c             	mov    0xc(%ebp),%eax
801043d0:	8b 00                	mov    (%eax),%eax
801043d2:	85 c0                	test   %eax,%eax
801043d4:	0f 84 b1 00 00 00    	je     8010448b <pipealloc+0xff>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
801043da:	e8 74 ee ff ff       	call   80103253 <kalloc>
801043df:	89 45 f4             	mov    %eax,-0xc(%ebp)
801043e2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801043e6:	0f 84 9e 00 00 00    	je     8010448a <pipealloc+0xfe>
    goto bad;
  p->readopen = 1;
801043ec:	8b 45 f4             	mov    -0xc(%ebp),%eax
801043ef:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
801043f6:	00 00 00 
  p->writeopen = 1;
801043f9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801043fc:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
80104403:	00 00 00 
  p->nwrite = 0;
80104406:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104409:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
80104410:	00 00 00 
  p->nread = 0;
80104413:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104416:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
8010441d:	00 00 00 
  initlock(&p->lock, "pipe");
80104420:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104423:	c7 44 24 04 68 96 10 	movl   $0x80109668,0x4(%esp)
8010442a:	80 
8010442b:	89 04 24             	mov    %eax,(%esp)
8010442e:	e8 63 16 00 00       	call   80105a96 <initlock>
  (*f0)->type = FD_PIPE;
80104433:	8b 45 08             	mov    0x8(%ebp),%eax
80104436:	8b 00                	mov    (%eax),%eax
80104438:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
8010443e:	8b 45 08             	mov    0x8(%ebp),%eax
80104441:	8b 00                	mov    (%eax),%eax
80104443:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
80104447:	8b 45 08             	mov    0x8(%ebp),%eax
8010444a:	8b 00                	mov    (%eax),%eax
8010444c:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
80104450:	8b 45 08             	mov    0x8(%ebp),%eax
80104453:	8b 00                	mov    (%eax),%eax
80104455:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104458:	89 50 0c             	mov    %edx,0xc(%eax)
  (*f1)->type = FD_PIPE;
8010445b:	8b 45 0c             	mov    0xc(%ebp),%eax
8010445e:	8b 00                	mov    (%eax),%eax
80104460:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
80104466:	8b 45 0c             	mov    0xc(%ebp),%eax
80104469:	8b 00                	mov    (%eax),%eax
8010446b:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
8010446f:	8b 45 0c             	mov    0xc(%ebp),%eax
80104472:	8b 00                	mov    (%eax),%eax
80104474:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
80104478:	8b 45 0c             	mov    0xc(%ebp),%eax
8010447b:	8b 00                	mov    (%eax),%eax
8010447d:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104480:	89 50 0c             	mov    %edx,0xc(%eax)
  return 0;
80104483:	b8 00 00 00 00       	mov    $0x0,%eax
80104488:	eb 43                	jmp    801044cd <pipealloc+0x141>
  p = 0;
  *f0 = *f1 = 0;
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
    goto bad;
8010448a:	90                   	nop
  (*f1)->pipe = p;
  return 0;

//PAGEBREAK: 20
 bad:
  if(p)
8010448b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010448f:	74 0b                	je     8010449c <pipealloc+0x110>
    kfree((char*)p);
80104491:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104494:	89 04 24             	mov    %eax,(%esp)
80104497:	e8 1e ed ff ff       	call   801031ba <kfree>
  if(*f0)
8010449c:	8b 45 08             	mov    0x8(%ebp),%eax
8010449f:	8b 00                	mov    (%eax),%eax
801044a1:	85 c0                	test   %eax,%eax
801044a3:	74 0d                	je     801044b2 <pipealloc+0x126>
    fileclose(*f0);
801044a5:	8b 45 08             	mov    0x8(%ebp),%eax
801044a8:	8b 00                	mov    (%eax),%eax
801044aa:	89 04 24             	mov    %eax,(%esp)
801044ad:	e8 66 d2 ff ff       	call   80101718 <fileclose>
  if(*f1)
801044b2:	8b 45 0c             	mov    0xc(%ebp),%eax
801044b5:	8b 00                	mov    (%eax),%eax
801044b7:	85 c0                	test   %eax,%eax
801044b9:	74 0d                	je     801044c8 <pipealloc+0x13c>
    fileclose(*f1);
801044bb:	8b 45 0c             	mov    0xc(%ebp),%eax
801044be:	8b 00                	mov    (%eax),%eax
801044c0:	89 04 24             	mov    %eax,(%esp)
801044c3:	e8 50 d2 ff ff       	call   80101718 <fileclose>
  return -1;
801044c8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801044cd:	c9                   	leave  
801044ce:	c3                   	ret    

801044cf <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
801044cf:	55                   	push   %ebp
801044d0:	89 e5                	mov    %esp,%ebp
801044d2:	83 ec 18             	sub    $0x18,%esp
  acquire(&p->lock);
801044d5:	8b 45 08             	mov    0x8(%ebp),%eax
801044d8:	89 04 24             	mov    %eax,(%esp)
801044db:	e8 d7 15 00 00       	call   80105ab7 <acquire>
  if(writable){
801044e0:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
801044e4:	74 1f                	je     80104505 <pipeclose+0x36>
    p->writeopen = 0;
801044e6:	8b 45 08             	mov    0x8(%ebp),%eax
801044e9:	c7 80 40 02 00 00 00 	movl   $0x0,0x240(%eax)
801044f0:	00 00 00 
    wakeup(&p->nread);
801044f3:	8b 45 08             	mov    0x8(%ebp),%eax
801044f6:	05 34 02 00 00       	add    $0x234,%eax
801044fb:	89 04 24             	mov    %eax,(%esp)
801044fe:	e8 14 12 00 00       	call   80105717 <wakeup>
80104503:	eb 1d                	jmp    80104522 <pipeclose+0x53>
  } else {
    p->readopen = 0;
80104505:	8b 45 08             	mov    0x8(%ebp),%eax
80104508:	c7 80 3c 02 00 00 00 	movl   $0x0,0x23c(%eax)
8010450f:	00 00 00 
    wakeup(&p->nwrite);
80104512:	8b 45 08             	mov    0x8(%ebp),%eax
80104515:	05 38 02 00 00       	add    $0x238,%eax
8010451a:	89 04 24             	mov    %eax,(%esp)
8010451d:	e8 f5 11 00 00       	call   80105717 <wakeup>
  }
  if(p->readopen == 0 && p->writeopen == 0){
80104522:	8b 45 08             	mov    0x8(%ebp),%eax
80104525:	8b 80 3c 02 00 00    	mov    0x23c(%eax),%eax
8010452b:	85 c0                	test   %eax,%eax
8010452d:	75 25                	jne    80104554 <pipeclose+0x85>
8010452f:	8b 45 08             	mov    0x8(%ebp),%eax
80104532:	8b 80 40 02 00 00    	mov    0x240(%eax),%eax
80104538:	85 c0                	test   %eax,%eax
8010453a:	75 18                	jne    80104554 <pipeclose+0x85>
    release(&p->lock);
8010453c:	8b 45 08             	mov    0x8(%ebp),%eax
8010453f:	89 04 24             	mov    %eax,(%esp)
80104542:	e8 d2 15 00 00       	call   80105b19 <release>
    kfree((char*)p);
80104547:	8b 45 08             	mov    0x8(%ebp),%eax
8010454a:	89 04 24             	mov    %eax,(%esp)
8010454d:	e8 68 ec ff ff       	call   801031ba <kfree>
80104552:	eb 0b                	jmp    8010455f <pipeclose+0x90>
  } else
    release(&p->lock);
80104554:	8b 45 08             	mov    0x8(%ebp),%eax
80104557:	89 04 24             	mov    %eax,(%esp)
8010455a:	e8 ba 15 00 00       	call   80105b19 <release>
}
8010455f:	c9                   	leave  
80104560:	c3                   	ret    

80104561 <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
80104561:	55                   	push   %ebp
80104562:	89 e5                	mov    %esp,%ebp
80104564:	53                   	push   %ebx
80104565:	83 ec 24             	sub    $0x24,%esp
  int i;

  acquire(&p->lock);
80104568:	8b 45 08             	mov    0x8(%ebp),%eax
8010456b:	89 04 24             	mov    %eax,(%esp)
8010456e:	e8 44 15 00 00       	call   80105ab7 <acquire>
  for(i = 0; i < n; i++){
80104573:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010457a:	e9 a6 00 00 00       	jmp    80104625 <pipewrite+0xc4>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
      if(p->readopen == 0 || proc->killed){
8010457f:	8b 45 08             	mov    0x8(%ebp),%eax
80104582:	8b 80 3c 02 00 00    	mov    0x23c(%eax),%eax
80104588:	85 c0                	test   %eax,%eax
8010458a:	74 0d                	je     80104599 <pipewrite+0x38>
8010458c:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104592:	8b 40 24             	mov    0x24(%eax),%eax
80104595:	85 c0                	test   %eax,%eax
80104597:	74 15                	je     801045ae <pipewrite+0x4d>
        release(&p->lock);
80104599:	8b 45 08             	mov    0x8(%ebp),%eax
8010459c:	89 04 24             	mov    %eax,(%esp)
8010459f:	e8 75 15 00 00       	call   80105b19 <release>
        return -1;
801045a4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801045a9:	e9 9d 00 00 00       	jmp    8010464b <pipewrite+0xea>
      }
      wakeup(&p->nread);
801045ae:	8b 45 08             	mov    0x8(%ebp),%eax
801045b1:	05 34 02 00 00       	add    $0x234,%eax
801045b6:	89 04 24             	mov    %eax,(%esp)
801045b9:	e8 59 11 00 00       	call   80105717 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
801045be:	8b 45 08             	mov    0x8(%ebp),%eax
801045c1:	8b 55 08             	mov    0x8(%ebp),%edx
801045c4:	81 c2 38 02 00 00    	add    $0x238,%edx
801045ca:	89 44 24 04          	mov    %eax,0x4(%esp)
801045ce:	89 14 24             	mov    %edx,(%esp)
801045d1:	e8 53 10 00 00       	call   80105629 <sleep>
801045d6:	eb 01                	jmp    801045d9 <pipewrite+0x78>
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801045d8:	90                   	nop
801045d9:	8b 45 08             	mov    0x8(%ebp),%eax
801045dc:	8b 90 38 02 00 00    	mov    0x238(%eax),%edx
801045e2:	8b 45 08             	mov    0x8(%ebp),%eax
801045e5:	8b 80 34 02 00 00    	mov    0x234(%eax),%eax
801045eb:	05 00 02 00 00       	add    $0x200,%eax
801045f0:	39 c2                	cmp    %eax,%edx
801045f2:	74 8b                	je     8010457f <pipewrite+0x1e>
        return -1;
      }
      wakeup(&p->nread);
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
801045f4:	8b 45 08             	mov    0x8(%ebp),%eax
801045f7:	8b 80 38 02 00 00    	mov    0x238(%eax),%eax
801045fd:	89 c3                	mov    %eax,%ebx
801045ff:	81 e3 ff 01 00 00    	and    $0x1ff,%ebx
80104605:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104608:	03 55 0c             	add    0xc(%ebp),%edx
8010460b:	0f b6 0a             	movzbl (%edx),%ecx
8010460e:	8b 55 08             	mov    0x8(%ebp),%edx
80104611:	88 4c 1a 34          	mov    %cl,0x34(%edx,%ebx,1)
80104615:	8d 50 01             	lea    0x1(%eax),%edx
80104618:	8b 45 08             	mov    0x8(%ebp),%eax
8010461b:	89 90 38 02 00 00    	mov    %edx,0x238(%eax)
pipewrite(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
80104621:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80104625:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104628:	3b 45 10             	cmp    0x10(%ebp),%eax
8010462b:	7c ab                	jl     801045d8 <pipewrite+0x77>
      wakeup(&p->nread);
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
8010462d:	8b 45 08             	mov    0x8(%ebp),%eax
80104630:	05 34 02 00 00       	add    $0x234,%eax
80104635:	89 04 24             	mov    %eax,(%esp)
80104638:	e8 da 10 00 00       	call   80105717 <wakeup>
  release(&p->lock);
8010463d:	8b 45 08             	mov    0x8(%ebp),%eax
80104640:	89 04 24             	mov    %eax,(%esp)
80104643:	e8 d1 14 00 00       	call   80105b19 <release>
  return n;
80104648:	8b 45 10             	mov    0x10(%ebp),%eax
}
8010464b:	83 c4 24             	add    $0x24,%esp
8010464e:	5b                   	pop    %ebx
8010464f:	5d                   	pop    %ebp
80104650:	c3                   	ret    

80104651 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
80104651:	55                   	push   %ebp
80104652:	89 e5                	mov    %esp,%ebp
80104654:	53                   	push   %ebx
80104655:	83 ec 24             	sub    $0x24,%esp
  int i;

  acquire(&p->lock);
80104658:	8b 45 08             	mov    0x8(%ebp),%eax
8010465b:	89 04 24             	mov    %eax,(%esp)
8010465e:	e8 54 14 00 00       	call   80105ab7 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80104663:	eb 3a                	jmp    8010469f <piperead+0x4e>
    if(proc->killed){
80104665:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010466b:	8b 40 24             	mov    0x24(%eax),%eax
8010466e:	85 c0                	test   %eax,%eax
80104670:	74 15                	je     80104687 <piperead+0x36>
      release(&p->lock);
80104672:	8b 45 08             	mov    0x8(%ebp),%eax
80104675:	89 04 24             	mov    %eax,(%esp)
80104678:	e8 9c 14 00 00       	call   80105b19 <release>
      return -1;
8010467d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104682:	e9 b6 00 00 00       	jmp    8010473d <piperead+0xec>
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
80104687:	8b 45 08             	mov    0x8(%ebp),%eax
8010468a:	8b 55 08             	mov    0x8(%ebp),%edx
8010468d:	81 c2 34 02 00 00    	add    $0x234,%edx
80104693:	89 44 24 04          	mov    %eax,0x4(%esp)
80104697:	89 14 24             	mov    %edx,(%esp)
8010469a:	e8 8a 0f 00 00       	call   80105629 <sleep>
piperead(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
8010469f:	8b 45 08             	mov    0x8(%ebp),%eax
801046a2:	8b 90 34 02 00 00    	mov    0x234(%eax),%edx
801046a8:	8b 45 08             	mov    0x8(%ebp),%eax
801046ab:	8b 80 38 02 00 00    	mov    0x238(%eax),%eax
801046b1:	39 c2                	cmp    %eax,%edx
801046b3:	75 0d                	jne    801046c2 <piperead+0x71>
801046b5:	8b 45 08             	mov    0x8(%ebp),%eax
801046b8:	8b 80 40 02 00 00    	mov    0x240(%eax),%eax
801046be:	85 c0                	test   %eax,%eax
801046c0:	75 a3                	jne    80104665 <piperead+0x14>
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
801046c2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801046c9:	eb 49                	jmp    80104714 <piperead+0xc3>
    if(p->nread == p->nwrite)
801046cb:	8b 45 08             	mov    0x8(%ebp),%eax
801046ce:	8b 90 34 02 00 00    	mov    0x234(%eax),%edx
801046d4:	8b 45 08             	mov    0x8(%ebp),%eax
801046d7:	8b 80 38 02 00 00    	mov    0x238(%eax),%eax
801046dd:	39 c2                	cmp    %eax,%edx
801046df:	74 3d                	je     8010471e <piperead+0xcd>
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
801046e1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801046e4:	89 c2                	mov    %eax,%edx
801046e6:	03 55 0c             	add    0xc(%ebp),%edx
801046e9:	8b 45 08             	mov    0x8(%ebp),%eax
801046ec:	8b 80 34 02 00 00    	mov    0x234(%eax),%eax
801046f2:	89 c3                	mov    %eax,%ebx
801046f4:	81 e3 ff 01 00 00    	and    $0x1ff,%ebx
801046fa:	8b 4d 08             	mov    0x8(%ebp),%ecx
801046fd:	0f b6 4c 19 34       	movzbl 0x34(%ecx,%ebx,1),%ecx
80104702:	88 0a                	mov    %cl,(%edx)
80104704:	8d 50 01             	lea    0x1(%eax),%edx
80104707:	8b 45 08             	mov    0x8(%ebp),%eax
8010470a:	89 90 34 02 00 00    	mov    %edx,0x234(%eax)
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80104710:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80104714:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104717:	3b 45 10             	cmp    0x10(%ebp),%eax
8010471a:	7c af                	jl     801046cb <piperead+0x7a>
8010471c:	eb 01                	jmp    8010471f <piperead+0xce>
    if(p->nread == p->nwrite)
      break;
8010471e:	90                   	nop
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
8010471f:	8b 45 08             	mov    0x8(%ebp),%eax
80104722:	05 38 02 00 00       	add    $0x238,%eax
80104727:	89 04 24             	mov    %eax,(%esp)
8010472a:	e8 e8 0f 00 00       	call   80105717 <wakeup>
  release(&p->lock);
8010472f:	8b 45 08             	mov    0x8(%ebp),%eax
80104732:	89 04 24             	mov    %eax,(%esp)
80104735:	e8 df 13 00 00       	call   80105b19 <release>
  return i;
8010473a:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
8010473d:	83 c4 24             	add    $0x24,%esp
80104740:	5b                   	pop    %ebx
80104741:	5d                   	pop    %ebp
80104742:	c3                   	ret    
	...

80104744 <readeflags>:
  asm volatile("ltr %0" : : "r" (sel));
}

static inline uint
readeflags(void)
{
80104744:	55                   	push   %ebp
80104745:	89 e5                	mov    %esp,%ebp
80104747:	53                   	push   %ebx
80104748:	83 ec 10             	sub    $0x10,%esp
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
8010474b:	9c                   	pushf  
8010474c:	5b                   	pop    %ebx
8010474d:	89 5d f8             	mov    %ebx,-0x8(%ebp)
  return eflags;
80104750:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
80104753:	83 c4 10             	add    $0x10,%esp
80104756:	5b                   	pop    %ebx
80104757:	5d                   	pop    %ebp
80104758:	c3                   	ret    

80104759 <sti>:
  asm volatile("cli");
}

static inline void
sti(void)
{
80104759:	55                   	push   %ebp
8010475a:	89 e5                	mov    %esp,%ebp
  asm volatile("sti");
8010475c:	fb                   	sti    
}
8010475d:	5d                   	pop    %ebp
8010475e:	c3                   	ret    

8010475f <def_Handler>:
//all includes were already added before
void 
def_Handler()
{
8010475f:	55                   	push   %ebp
80104760:	89 e5                	mov    %esp,%ebp
80104762:	83 ec 18             	sub    $0x18,%esp
	cprintf("A signal was accepted by process %d\n",proc->pid);
80104765:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010476b:	8b 40 10             	mov    0x10(%eax),%eax
8010476e:	89 44 24 04          	mov    %eax,0x4(%esp)
80104772:	c7 04 24 70 96 10 80 	movl   $0x80109670,(%esp)
80104779:	e8 23 bc ff ff       	call   801003a1 <cprintf>
}
8010477e:	c9                   	leave  
8010477f:	c3                   	ret    

80104780 <get_time>:

static void wakeup1(void *chan);

  //used to get the number of ticks since the clock started
int
get_time(){
80104780:	55                   	push   %ebp
80104781:	89 e5                	mov    %esp,%ebp
80104783:	83 ec 28             	sub    $0x28,%esp
  uint rticks;

  acquire(&tickslock);
80104786:	c7 04 24 20 6a 11 80 	movl   $0x80116a20,(%esp)
8010478d:	e8 25 13 00 00       	call   80105ab7 <acquire>
  rticks=ticks;
80104792:	a1 60 72 11 80       	mov    0x80117260,%eax
80104797:	89 45 f4             	mov    %eax,-0xc(%ebp)
  release(&tickslock);
8010479a:	c7 04 24 20 6a 11 80 	movl   $0x80116a20,(%esp)
801047a1:	e8 73 13 00 00       	call   80105b19 <release>
return rticks;
801047a6:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
801047a9:	c9                   	leave  
801047aa:	c3                   	ret    

801047ab <getquanta>:

int 
getquanta()
{
801047ab:	55                   	push   %ebp
801047ac:	89 e5                	mov    %esp,%ebp
  return proc->quanta;
801047ae:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801047b4:	8b 80 94 00 00 00    	mov    0x94(%eax),%eax
}
801047ba:	5d                   	pop    %ebp
801047bb:	c3                   	ret    

801047bc <getqueue>:
int 
getqueue()
{
801047bc:	55                   	push   %ebp
801047bd:	89 e5                	mov    %esp,%ebp
  return proc->queue;
801047bf:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801047c5:	8b 40 7c             	mov    0x7c(%eax),%eax
}
801047c8:	5d                   	pop    %ebp
801047c9:	c3                   	ret    

801047ca <pinit>:


void
pinit(void)
{
801047ca:	55                   	push   %ebp
801047cb:	89 e5                	mov    %esp,%ebp
801047cd:	83 ec 28             	sub    $0x28,%esp
  int i;
  initlock(&ptable.lock, "ptable");
801047d0:	c7 44 24 04 95 96 10 	movl   $0x80109695,0x4(%esp)
801047d7:	80 
801047d8:	c7 04 24 e0 21 11 80 	movl   $0x801121e0,(%esp)
801047df:	e8 b2 12 00 00       	call   80105a96 <initlock>
  initlock(&queues.lock, "queue");
801047e4:	c7 44 24 04 9c 96 10 	movl   $0x8010969c,0x4(%esp)
801047eb:	80 
801047ec:	c7 04 24 80 1e 11 80 	movl   $0x80111e80,(%esp)
801047f3:	e8 9e 12 00 00       	call   80105a96 <initlock>
  for(i=0;i<NUMBER_OF_QUEUES*NPROC;i++)
801047f8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801047ff:	eb 15                	jmp    80104816 <pinit+0x4c>
    queues.list[i]=-1;
80104801:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104804:	83 c0 0c             	add    $0xc,%eax
80104807:	c7 04 85 84 1e 11 80 	movl   $0xffffffff,-0x7feee17c(,%eax,4)
8010480e:	ff ff ff ff 
pinit(void)
{
  int i;
  initlock(&ptable.lock, "ptable");
  initlock(&queues.lock, "queue");
  for(i=0;i<NUMBER_OF_QUEUES*NPROC;i++)
80104812:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80104816:	81 7d f4 bf 00 00 00 	cmpl   $0xbf,-0xc(%ebp)
8010481d:	7e e2                	jle    80104801 <pinit+0x37>
    queues.list[i]=-1;
  for(i=0;i<NUMBER_OF_QUEUES;i++){
8010481f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80104826:	eb 2a                	jmp    80104852 <pinit+0x88>
  queues.start[i]=0;
80104828:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010482b:	05 cc 00 00 00       	add    $0xcc,%eax
80104830:	c7 04 85 84 1e 11 80 	movl   $0x0,-0x7feee17c(,%eax,4)
80104837:	00 00 00 00 
  queues.end[i]=0;
8010483b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010483e:	05 d0 00 00 00       	add    $0xd0,%eax
80104843:	c7 04 85 80 1e 11 80 	movl   $0x0,-0x7feee180(,%eax,4)
8010484a:	00 00 00 00 
  int i;
  initlock(&ptable.lock, "ptable");
  initlock(&queues.lock, "queue");
  for(i=0;i<NUMBER_OF_QUEUES*NPROC;i++)
    queues.list[i]=-1;
  for(i=0;i<NUMBER_OF_QUEUES;i++){
8010484e:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80104852:	83 7d f4 02          	cmpl   $0x2,-0xc(%ebp)
80104856:	7e d0                	jle    80104828 <pinit+0x5e>
  queues.start[i]=0;
  queues.end[i]=0;
  }
}
80104858:	c9                   	leave  
80104859:	c3                   	ret    

8010485a <sleepingUpDate>:

void
sleepingUpDate(void)
{
8010485a:	55                   	push   %ebp
8010485b:	89 e5                	mov    %esp,%ebp
8010485d:	83 ec 28             	sub    $0x28,%esp
  struct proc *p;
  acquire(&ptable.lock);
80104860:	c7 04 24 e0 21 11 80 	movl   $0x801121e0,(%esp)
80104867:	e8 4b 12 00 00       	call   80105ab7 <acquire>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010486c:	c7 45 f4 14 22 11 80 	movl   $0x80112214,-0xc(%ebp)
80104873:	e9 a2 00 00 00       	jmp    8010491a <sleepingUpDate+0xc0>

    if(p->state == SLEEPING){
80104878:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010487b:	8b 40 0c             	mov    0xc(%eax),%eax
8010487e:	83 f8 02             	cmp    $0x2,%eax
80104881:	75 15                	jne    80104898 <sleepingUpDate+0x3e>
      p->iotime++;
80104883:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104886:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
8010488c:	8d 50 01             	lea    0x1(%eax),%edx
8010488f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104892:	89 90 8c 00 00 00    	mov    %edx,0x8c(%eax)
      
    }
    if(p->state == RUNNING){
80104898:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010489b:	8b 40 0c             	mov    0xc(%eax),%eax
8010489e:	83 f8 04             	cmp    $0x4,%eax
801048a1:	75 2a                	jne    801048cd <sleepingUpDate+0x73>
      p->rtime++;
801048a3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801048a6:	8b 80 90 00 00 00    	mov    0x90(%eax),%eax
801048ac:	8d 50 01             	lea    0x1(%eax),%edx
801048af:	8b 45 f4             	mov    -0xc(%ebp),%eax
801048b2:	89 90 90 00 00 00    	mov    %edx,0x90(%eax)
      p->quanta--;
801048b8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801048bb:	8b 80 94 00 00 00    	mov    0x94(%eax),%eax
801048c1:	8d 50 ff             	lea    -0x1(%eax),%edx
801048c4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801048c7:	89 90 94 00 00 00    	mov    %edx,0x94(%eax)
    }
    if(p->alarm>=0)
    {
      p->alarm--;
801048cd:	8b 45 f4             	mov    -0xc(%ebp),%eax
801048d0:	8b 80 1c 01 00 00    	mov    0x11c(%eax),%eax
801048d6:	8d 50 ff             	lea    -0x1(%eax),%edx
801048d9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801048dc:	89 90 1c 01 00 00    	mov    %edx,0x11c(%eax)
      if(p->alarm==0)
801048e2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801048e5:	8b 80 1c 01 00 00    	mov    0x11c(%eax),%eax
801048eb:	85 c0                	test   %eax,%eax
801048ed:	75 24                	jne    80104913 <sleepingUpDate+0xb9>
      {
        p->pending = p-> pending | (1 << (SIGALRM-1));
801048ef:	8b 45 f4             	mov    -0xc(%ebp),%eax
801048f2:	8b 80 98 00 00 00    	mov    0x98(%eax),%eax
801048f8:	89 c2                	mov    %eax,%edx
801048fa:	80 ce 20             	or     $0x20,%dh
801048fd:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104900:	89 90 98 00 00 00    	mov    %edx,0x98(%eax)
        p->alarm=-1; 
80104906:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104909:	c7 80 1c 01 00 00 ff 	movl   $0xffffffff,0x11c(%eax)
80104910:	ff ff ff 
void
sleepingUpDate(void)
{
  struct proc *p;
  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104913:	81 45 f4 20 01 00 00 	addl   $0x120,-0xc(%ebp)
8010491a:	81 7d f4 14 6a 11 80 	cmpl   $0x80116a14,-0xc(%ebp)
80104921:	0f 82 51 ff ff ff    	jb     80104878 <sleepingUpDate+0x1e>
      }

    }
    
  }
 release(&ptable.lock);
80104927:	c7 04 24 e0 21 11 80 	movl   $0x801121e0,(%esp)
8010492e:	e8 e6 11 00 00       	call   80105b19 <release>
}
80104933:	c9                   	leave  
80104934:	c3                   	ret    

80104935 <findIndxOfProc>:

int
findIndxOfProc(struct proc* np){
80104935:	55                   	push   %ebp
80104936:	89 e5                	mov    %esp,%ebp
80104938:	83 ec 10             	sub    $0x10,%esp
  int i;
  for(i=0; i < NPROC; i++)
8010493b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
80104942:	eb 28                	jmp    8010496c <findIndxOfProc+0x37>
  {
    if((&ptable.proc[i])->pid == np->pid){
80104944:	8b 55 fc             	mov    -0x4(%ebp),%edx
80104947:	89 d0                	mov    %edx,%eax
80104949:	c1 e0 03             	shl    $0x3,%eax
8010494c:	01 d0                	add    %edx,%eax
8010494e:	c1 e0 05             	shl    $0x5,%eax
80104951:	05 14 22 11 80       	add    $0x80112214,%eax
80104956:	8b 50 10             	mov    0x10(%eax),%edx
80104959:	8b 45 08             	mov    0x8(%ebp),%eax
8010495c:	8b 40 10             	mov    0x10(%eax),%eax
8010495f:	39 c2                	cmp    %eax,%edx
80104961:	75 05                	jne    80104968 <findIndxOfProc+0x33>
      return i;   
80104963:	8b 45 fc             	mov    -0x4(%ebp),%eax
80104966:	eb 0f                	jmp    80104977 <findIndxOfProc+0x42>
}

int
findIndxOfProc(struct proc* np){
  int i;
  for(i=0; i < NPROC; i++)
80104968:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
8010496c:	83 7d fc 3f          	cmpl   $0x3f,-0x4(%ebp)
80104970:	7e d2                	jle    80104944 <findIndxOfProc+0xf>
  {
    if((&ptable.proc[i])->pid == np->pid){
      return i;   
    }
  }
 return -1;
80104972:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104977:	c9                   	leave  
80104978:	c3                   	ret    

80104979 <queuesAboveEmpty>:

int
queuesAboveEmpty(int queue){
80104979:	55                   	push   %ebp
8010497a:	89 e5                	mov    %esp,%ebp
8010497c:	83 ec 10             	sub    $0x10,%esp
  int ans = 1;
8010497f:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
  int placer;
  if(queue==NUMBER_OF_QUEUES-1)
80104986:	83 7d 08 02          	cmpl   $0x2,0x8(%ebp)
8010498a:	75 07                	jne    80104993 <queuesAboveEmpty+0x1a>
    return 1;
8010498c:	b8 01 00 00 00       	mov    $0x1,%eax
80104991:	eb 43                	jmp    801049d6 <queuesAboveEmpty+0x5d>
  
  for(placer = (queue+1)*NPROC;placer<NUMBER_OF_QUEUES*NPROC;placer++)
80104993:	8b 45 08             	mov    0x8(%ebp),%eax
80104996:	83 c0 01             	add    $0x1,%eax
80104999:	c1 e0 06             	shl    $0x6,%eax
8010499c:	89 45 f8             	mov    %eax,-0x8(%ebp)
8010499f:	eb 29                	jmp    801049ca <queuesAboveEmpty+0x51>
  {
    ans = ans * (queues.list[placer]==-1)? 1 : 0;
801049a1:	8b 45 f8             	mov    -0x8(%ebp),%eax
801049a4:	83 c0 0c             	add    $0xc,%eax
801049a7:	8b 04 85 84 1e 11 80 	mov    -0x7feee17c(,%eax,4),%eax
801049ae:	83 f8 ff             	cmp    $0xffffffff,%eax
801049b1:	0f 94 c0             	sete   %al
801049b4:	0f b6 c0             	movzbl %al,%eax
801049b7:	0f af 45 fc          	imul   -0x4(%ebp),%eax
801049bb:	85 c0                	test   %eax,%eax
801049bd:	0f 95 c0             	setne  %al
801049c0:	0f b6 c0             	movzbl %al,%eax
801049c3:	89 45 fc             	mov    %eax,-0x4(%ebp)
  int ans = 1;
  int placer;
  if(queue==NUMBER_OF_QUEUES-1)
    return 1;
  
  for(placer = (queue+1)*NPROC;placer<NUMBER_OF_QUEUES*NPROC;placer++)
801049c6:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
801049ca:	81 7d f8 bf 00 00 00 	cmpl   $0xbf,-0x8(%ebp)
801049d1:	7e ce                	jle    801049a1 <queuesAboveEmpty+0x28>
  {
    ans = ans * (queues.list[placer]==-1)? 1 : 0;
  }

  return ans;
801049d3:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
801049d6:	c9                   	leave  
801049d7:	c3                   	ret    

801049d8 <changeStatus>:

void
changeStatus(enum procstate s,struct proc* p)
{
801049d8:	55                   	push   %ebp
801049d9:	89 e5                	mov    %esp,%ebp
801049db:	83 ec 28             	sub    $0x28,%esp
  
  int location = findIndxOfProc(p);
801049de:	8b 45 0c             	mov    0xc(%ebp),%eax
801049e1:	89 04 24             	mov    %eax,(%esp)
801049e4:	e8 4c ff ff ff       	call   80104935 <findIndxOfProc>
801049e9:	89 45 f4             	mov    %eax,-0xc(%ebp)
  
 enum procstate prevState = p->state; 
801049ec:	8b 45 0c             	mov    0xc(%ebp),%eax
801049ef:	8b 40 0c             	mov    0xc(%eax),%eax
801049f2:	89 45 f0             	mov    %eax,-0x10(%ebp)

  p->state=s;
801049f5:	8b 45 0c             	mov    0xc(%ebp),%eax
801049f8:	8b 55 08             	mov    0x8(%ebp),%edx
801049fb:	89 50 0c             	mov    %edx,0xc(%eax)

  if(location<0)
801049fe:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80104a02:	79 16                	jns    80104a1a <changeStatus+0x42>
    cprintf("Cant find any processes with pid %d\n",p->pid);
80104a04:	8b 45 0c             	mov    0xc(%ebp),%eax
80104a07:	8b 40 10             	mov    0x10(%eax),%eax
80104a0a:	89 44 24 04          	mov    %eax,0x4(%esp)
80104a0e:	c7 04 24 a4 96 10 80 	movl   $0x801096a4,(%esp)
80104a15:	e8 87 b9 ff ff       	call   801003a1 <cprintf>
          } 
        }
      break;

      default:
        if(s==RUNNING){
80104a1a:	83 7d 08 04          	cmpl   $0x4,0x8(%ebp)
80104a1e:	75 0d                	jne    80104a2d <changeStatus+0x55>
          p->quanta=QUANTA;
80104a20:	8b 45 0c             	mov    0xc(%ebp),%eax
80104a23:	c7 80 94 00 00 00 05 	movl   $0x5,0x94(%eax)
80104a2a:	00 00 00 
        }
      break;
80104a2d:	90                   	nop
    }
}
80104a2e:	c9                   	leave  
80104a2f:	c3                   	ret    

80104a30 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
80104a30:	55                   	push   %ebp
80104a31:	89 e5                	mov    %esp,%ebp
80104a33:	83 ec 28             	sub    $0x28,%esp
  struct proc *p;
  char *sp;
  int i;

  acquire(&ptable.lock);
80104a36:	c7 04 24 e0 21 11 80 	movl   $0x801121e0,(%esp)
80104a3d:	e8 75 10 00 00       	call   80105ab7 <acquire>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104a42:	c7 45 f4 14 22 11 80 	movl   $0x80112214,-0xc(%ebp)
80104a49:	eb 11                	jmp    80104a5c <allocproc+0x2c>
    if(p->state == UNUSED)
80104a4b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104a4e:	8b 40 0c             	mov    0xc(%eax),%eax
80104a51:	85 c0                	test   %eax,%eax
80104a53:	74 26                	je     80104a7b <allocproc+0x4b>
  struct proc *p;
  char *sp;
  int i;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104a55:	81 45 f4 20 01 00 00 	addl   $0x120,-0xc(%ebp)
80104a5c:	81 7d f4 14 6a 11 80 	cmpl   $0x80116a14,-0xc(%ebp)
80104a63:	72 e6                	jb     80104a4b <allocproc+0x1b>
    if(p->state == UNUSED)
      goto found;

  release(&ptable.lock);
80104a65:	c7 04 24 e0 21 11 80 	movl   $0x801121e0,(%esp)
80104a6c:	e8 a8 10 00 00       	call   80105b19 <release>
  return 0;
80104a71:	b8 00 00 00 00       	mov    $0x0,%eax
80104a76:	e9 3a 01 00 00       	jmp    80104bb5 <allocproc+0x185>
  int i;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    if(p->state == UNUSED)
      goto found;
80104a7b:	90                   	nop
  release(&ptable.lock);
  return 0;

found:

  p->queue=NORMAL_PRIORITY_QUEUE;
80104a7c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104a7f:	c7 40 7c 01 00 00 00 	movl   $0x1,0x7c(%eax)
    
  changeStatus(EMBRYO,p);
80104a86:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104a89:	89 44 24 04          	mov    %eax,0x4(%esp)
80104a8d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80104a94:	e8 3f ff ff ff       	call   801049d8 <changeStatus>

  p->pid = nextpid++;
80104a99:	a1 04 c0 10 80       	mov    0x8010c004,%eax
80104a9e:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104aa1:	89 42 10             	mov    %eax,0x10(%edx)
80104aa4:	83 c0 01             	add    $0x1,%eax
80104aa7:	a3 04 c0 10 80       	mov    %eax,0x8010c004

  //update time of creation
  p->ctime=get_time();
80104aac:	e8 cf fc ff ff       	call   80104780 <get_time>
80104ab1:	89 c2                	mov    %eax,%edx
80104ab3:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104ab6:	89 90 84 00 00 00    	mov    %edx,0x84(%eax)
  p->iotime=0;
80104abc:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104abf:	c7 80 8c 00 00 00 00 	movl   $0x0,0x8c(%eax)
80104ac6:	00 00 00 
  p->rtime=0;
80104ac9:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104acc:	c7 80 90 00 00 00 00 	movl   $0x0,0x90(%eax)
80104ad3:	00 00 00 
  p->pending=0;
80104ad6:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104ad9:	c7 80 98 00 00 00 00 	movl   $0x0,0x98(%eax)
80104ae0:	00 00 00 
  p->alarm=-1; //not set
80104ae3:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104ae6:	c7 80 1c 01 00 00 ff 	movl   $0xffffffff,0x11c(%eax)
80104aed:	ff ff ff 

  for(i=0;i<NUMSIG;i++)
80104af0:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
80104af7:	eb 16                	jmp    80104b0f <allocproc+0xdf>
  {
    p->handlers[i]=(sighandler_t)&def_Handler;
80104af9:	ba 5f 47 10 80       	mov    $0x8010475f,%edx
80104afe:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104b01:	8b 4d f0             	mov    -0x10(%ebp),%ecx
80104b04:	83 c1 24             	add    $0x24,%ecx
80104b07:	89 54 88 0c          	mov    %edx,0xc(%eax,%ecx,4)
  p->iotime=0;
  p->rtime=0;
  p->pending=0;
  p->alarm=-1; //not set

  for(i=0;i<NUMSIG;i++)
80104b0b:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
80104b0f:	83 7d f0 1f          	cmpl   $0x1f,-0x10(%ebp)
80104b13:	7e e4                	jle    80104af9 <allocproc+0xc9>
  {
    p->handlers[i]=(sighandler_t)&def_Handler;
  }

  release(&ptable.lock);
80104b15:	c7 04 24 e0 21 11 80 	movl   $0x801121e0,(%esp)
80104b1c:	e8 f8 0f 00 00       	call   80105b19 <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
80104b21:	e8 2d e7 ff ff       	call   80103253 <kalloc>
80104b26:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104b29:	89 42 08             	mov    %eax,0x8(%edx)
80104b2c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104b2f:	8b 40 08             	mov    0x8(%eax),%eax
80104b32:	85 c0                	test   %eax,%eax
80104b34:	75 1a                	jne    80104b50 <allocproc+0x120>
    changeStatus(UNUSED,p);
80104b36:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104b39:	89 44 24 04          	mov    %eax,0x4(%esp)
80104b3d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80104b44:	e8 8f fe ff ff       	call   801049d8 <changeStatus>
    return 0;
80104b49:	b8 00 00 00 00       	mov    $0x0,%eax
80104b4e:	eb 65                	jmp    80104bb5 <allocproc+0x185>
  }
  sp = p->kstack + KSTACKSIZE;
80104b50:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104b53:	8b 40 08             	mov    0x8(%eax),%eax
80104b56:	05 00 10 00 00       	add    $0x1000,%eax
80104b5b:	89 45 ec             	mov    %eax,-0x14(%ebp)
  
  // Leave room for trap frame.
  sp -= sizeof *p->tf;
80104b5e:	83 6d ec 4c          	subl   $0x4c,-0x14(%ebp)
  p->tf = (struct trapframe*)sp;
80104b62:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104b65:	8b 55 ec             	mov    -0x14(%ebp),%edx
80104b68:	89 50 18             	mov    %edx,0x18(%eax)
  
  // Set up new context to start executing at forkret,
  // which returns to trapret.
  sp -= 4;
80104b6b:	83 6d ec 04          	subl   $0x4,-0x14(%ebp)
  *(uint*)sp = (uint)trapret;
80104b6f:	ba 4c 74 10 80       	mov    $0x8010744c,%edx
80104b74:	8b 45 ec             	mov    -0x14(%ebp),%eax
80104b77:	89 10                	mov    %edx,(%eax)

  sp -= sizeof *p->context;
80104b79:	83 6d ec 14          	subl   $0x14,-0x14(%ebp)
  p->context = (struct context*)sp;
80104b7d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104b80:	8b 55 ec             	mov    -0x14(%ebp),%edx
80104b83:	89 50 1c             	mov    %edx,0x1c(%eax)
  memset(p->context, 0, sizeof *p->context);
80104b86:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104b89:	8b 40 1c             	mov    0x1c(%eax),%eax
80104b8c:	c7 44 24 08 14 00 00 	movl   $0x14,0x8(%esp)
80104b93:	00 
80104b94:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80104b9b:	00 
80104b9c:	89 04 24             	mov    %eax,(%esp)
80104b9f:	e8 62 11 00 00       	call   80105d06 <memset>
  p->context->eip = (uint)forkret;
80104ba4:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104ba7:	8b 40 1c             	mov    0x1c(%eax),%eax
80104baa:	ba fd 55 10 80       	mov    $0x801055fd,%edx
80104baf:	89 50 10             	mov    %edx,0x10(%eax)

  return p;
80104bb2:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80104bb5:	c9                   	leave  
80104bb6:	c3                   	ret    

80104bb7 <userinit>:

//PAGEBREAK: 32
// Set up first user process.
void
userinit(void)
{
80104bb7:	55                   	push   %ebp
80104bb8:	89 e5                	mov    %esp,%ebp
80104bba:	83 ec 28             	sub    $0x28,%esp
  struct proc *p;
  extern char _binary_initcode_start[], _binary_initcode_size[];
  
  p = allocproc();
80104bbd:	e8 6e fe ff ff       	call   80104a30 <allocproc>
80104bc2:	89 45 f4             	mov    %eax,-0xc(%ebp)

  initproc = p;
80104bc5:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104bc8:	a3 88 cb 10 80       	mov    %eax,0x8010cb88
  if((p->pgdir = setupkvm(kalloc)) == 0)
80104bcd:	c7 04 24 53 32 10 80 	movl   $0x80103253,(%esp)
80104bd4:	e8 78 3f 00 00       	call   80108b51 <setupkvm>
80104bd9:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104bdc:	89 42 04             	mov    %eax,0x4(%edx)
80104bdf:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104be2:	8b 40 04             	mov    0x4(%eax),%eax
80104be5:	85 c0                	test   %eax,%eax
80104be7:	75 0c                	jne    80104bf5 <userinit+0x3e>
    panic("userinit: out of memory?");
80104be9:	c7 04 24 c9 96 10 80 	movl   $0x801096c9,(%esp)
80104bf0:	e8 48 b9 ff ff       	call   8010053d <panic>

  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80104bf5:	ba 2c 00 00 00       	mov    $0x2c,%edx
80104bfa:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104bfd:	8b 40 04             	mov    0x4(%eax),%eax
80104c00:	89 54 24 08          	mov    %edx,0x8(%esp)
80104c04:	c7 44 24 04 00 c5 10 	movl   $0x8010c500,0x4(%esp)
80104c0b:	80 
80104c0c:	89 04 24             	mov    %eax,(%esp)
80104c0f:	e8 95 41 00 00       	call   80108da9 <inituvm>
  
  p->sz = PGSIZE;
80104c14:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104c17:	c7 00 00 10 00 00    	movl   $0x1000,(%eax)
  memset(p->tf, 0, sizeof(*p->tf));
80104c1d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104c20:	8b 40 18             	mov    0x18(%eax),%eax
80104c23:	c7 44 24 08 4c 00 00 	movl   $0x4c,0x8(%esp)
80104c2a:	00 
80104c2b:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80104c32:	00 
80104c33:	89 04 24             	mov    %eax,(%esp)
80104c36:	e8 cb 10 00 00       	call   80105d06 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80104c3b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104c3e:	8b 40 18             	mov    0x18(%eax),%eax
80104c41:	66 c7 40 3c 23 00    	movw   $0x23,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80104c47:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104c4a:	8b 40 18             	mov    0x18(%eax),%eax
80104c4d:	66 c7 40 2c 2b 00    	movw   $0x2b,0x2c(%eax)
  p->tf->es = p->tf->ds;
80104c53:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104c56:	8b 40 18             	mov    0x18(%eax),%eax
80104c59:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104c5c:	8b 52 18             	mov    0x18(%edx),%edx
80104c5f:	0f b7 52 2c          	movzwl 0x2c(%edx),%edx
80104c63:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
80104c67:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104c6a:	8b 40 18             	mov    0x18(%eax),%eax
80104c6d:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104c70:	8b 52 18             	mov    0x18(%edx),%edx
80104c73:	0f b7 52 2c          	movzwl 0x2c(%edx),%edx
80104c77:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
80104c7b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104c7e:	8b 40 18             	mov    0x18(%eax),%eax
80104c81:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
80104c88:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104c8b:	8b 40 18             	mov    0x18(%eax),%eax
80104c8e:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
80104c95:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104c98:	8b 40 18             	mov    0x18(%eax),%eax
80104c9b:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)

  safestrcpy(p->name, "initcode", sizeof(p->name));
80104ca2:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104ca5:	83 c0 6c             	add    $0x6c,%eax
80104ca8:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
80104caf:	00 
80104cb0:	c7 44 24 04 e2 96 10 	movl   $0x801096e2,0x4(%esp)
80104cb7:	80 
80104cb8:	89 04 24             	mov    %eax,(%esp)
80104cbb:	e8 76 12 00 00       	call   80105f36 <safestrcpy>
  p->cwd = namei("/");
80104cc0:	c7 04 24 eb 96 10 80 	movl   $0x801096eb,(%esp)
80104cc7:	e8 92 de ff ff       	call   80102b5e <namei>
80104ccc:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104ccf:	89 42 68             	mov    %eax,0x68(%edx)
  
  changeStatus(RUNNABLE,p);
80104cd2:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104cd5:	89 44 24 04          	mov    %eax,0x4(%esp)
80104cd9:	c7 04 24 03 00 00 00 	movl   $0x3,(%esp)
80104ce0:	e8 f3 fc ff ff       	call   801049d8 <changeStatus>
  
}
80104ce5:	c9                   	leave  
80104ce6:	c3                   	ret    

80104ce7 <growproc>:

// Grow current process's memory by n bytes.
// Return 0 on success, -1 on failure.
int
growproc(int n)
{
80104ce7:	55                   	push   %ebp
80104ce8:	89 e5                	mov    %esp,%ebp
80104cea:	83 ec 28             	sub    $0x28,%esp
  uint sz;
  
  sz = proc->sz;
80104ced:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104cf3:	8b 00                	mov    (%eax),%eax
80104cf5:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(n > 0){
80104cf8:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80104cfc:	7e 34                	jle    80104d32 <growproc+0x4b>
    if((sz = allocuvm(proc->pgdir, sz, sz + n)) == 0)
80104cfe:	8b 45 08             	mov    0x8(%ebp),%eax
80104d01:	89 c2                	mov    %eax,%edx
80104d03:	03 55 f4             	add    -0xc(%ebp),%edx
80104d06:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104d0c:	8b 40 04             	mov    0x4(%eax),%eax
80104d0f:	89 54 24 08          	mov    %edx,0x8(%esp)
80104d13:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104d16:	89 54 24 04          	mov    %edx,0x4(%esp)
80104d1a:	89 04 24             	mov    %eax,(%esp)
80104d1d:	e8 01 42 00 00       	call   80108f23 <allocuvm>
80104d22:	89 45 f4             	mov    %eax,-0xc(%ebp)
80104d25:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80104d29:	75 41                	jne    80104d6c <growproc+0x85>
      return -1;
80104d2b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104d30:	eb 58                	jmp    80104d8a <growproc+0xa3>
  } else if(n < 0){
80104d32:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80104d36:	79 34                	jns    80104d6c <growproc+0x85>
    if((sz = deallocuvm(proc->pgdir, sz, sz + n)) == 0)
80104d38:	8b 45 08             	mov    0x8(%ebp),%eax
80104d3b:	89 c2                	mov    %eax,%edx
80104d3d:	03 55 f4             	add    -0xc(%ebp),%edx
80104d40:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104d46:	8b 40 04             	mov    0x4(%eax),%eax
80104d49:	89 54 24 08          	mov    %edx,0x8(%esp)
80104d4d:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104d50:	89 54 24 04          	mov    %edx,0x4(%esp)
80104d54:	89 04 24             	mov    %eax,(%esp)
80104d57:	e8 a1 42 00 00       	call   80108ffd <deallocuvm>
80104d5c:	89 45 f4             	mov    %eax,-0xc(%ebp)
80104d5f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80104d63:	75 07                	jne    80104d6c <growproc+0x85>
      return -1;
80104d65:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104d6a:	eb 1e                	jmp    80104d8a <growproc+0xa3>
  }
  proc->sz = sz;
80104d6c:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104d72:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104d75:	89 10                	mov    %edx,(%eax)
  switchuvm(proc);
80104d77:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104d7d:	89 04 24             	mov    %eax,(%esp)
80104d80:	e8 bd 3e 00 00       	call   80108c42 <switchuvm>
  return 0;
80104d85:	b8 00 00 00 00       	mov    $0x0,%eax
}
80104d8a:	c9                   	leave  
80104d8b:	c3                   	ret    

80104d8c <fork>:
// Create a new process copying p as the parent.
// Sets up stack to return as if from system call.
// Caller must set state of returned proc to RUNNABLE.
int
fork(void)
{
80104d8c:	55                   	push   %ebp
80104d8d:	89 e5                	mov    %esp,%ebp
80104d8f:	57                   	push   %edi
80104d90:	56                   	push   %esi
80104d91:	53                   	push   %ebx
80104d92:	83 ec 2c             	sub    $0x2c,%esp
  int i, pid;
  struct proc *np;

  // Allocate process.
  if((np = allocproc()) == 0)
80104d95:	e8 96 fc ff ff       	call   80104a30 <allocproc>
80104d9a:	89 45 e0             	mov    %eax,-0x20(%ebp)
80104d9d:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
80104da1:	75 0a                	jne    80104dad <fork+0x21>
    return -1;
80104da3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104da8:	e9 7c 01 00 00       	jmp    80104f29 <fork+0x19d>

  // Copy process state from p.
  if((np->pgdir = copyuvm(proc->pgdir, proc->sz)) == 0){
80104dad:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104db3:	8b 10                	mov    (%eax),%edx
80104db5:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104dbb:	8b 40 04             	mov    0x4(%eax),%eax
80104dbe:	89 54 24 04          	mov    %edx,0x4(%esp)
80104dc2:	89 04 24             	mov    %eax,(%esp)
80104dc5:	e8 c3 43 00 00       	call   8010918d <copyuvm>
80104dca:	8b 55 e0             	mov    -0x20(%ebp),%edx
80104dcd:	89 42 04             	mov    %eax,0x4(%edx)
80104dd0:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104dd3:	8b 40 04             	mov    0x4(%eax),%eax
80104dd6:	85 c0                	test   %eax,%eax
80104dd8:	75 35                	jne    80104e0f <fork+0x83>
    kfree(np->kstack);
80104dda:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104ddd:	8b 40 08             	mov    0x8(%eax),%eax
80104de0:	89 04 24             	mov    %eax,(%esp)
80104de3:	e8 d2 e3 ff ff       	call   801031ba <kfree>
    np->kstack = 0;
80104de8:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104deb:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
    changeStatus(UNUSED,np);
80104df2:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104df5:	89 44 24 04          	mov    %eax,0x4(%esp)
80104df9:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80104e00:	e8 d3 fb ff ff       	call   801049d8 <changeStatus>
    return -1;
80104e05:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104e0a:	e9 1a 01 00 00       	jmp    80104f29 <fork+0x19d>
  }
  np->sz = proc->sz;
80104e0f:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104e15:	8b 10                	mov    (%eax),%edx
80104e17:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104e1a:	89 10                	mov    %edx,(%eax)
  np->parent = proc;
80104e1c:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80104e23:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104e26:	89 50 14             	mov    %edx,0x14(%eax)
  *np->tf = *proc->tf;
80104e29:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104e2c:	8b 50 18             	mov    0x18(%eax),%edx
80104e2f:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104e35:	8b 40 18             	mov    0x18(%eax),%eax
80104e38:	89 c3                	mov    %eax,%ebx
80104e3a:	b8 13 00 00 00       	mov    $0x13,%eax
80104e3f:	89 d7                	mov    %edx,%edi
80104e41:	89 de                	mov    %ebx,%esi
80104e43:	89 c1                	mov    %eax,%ecx
80104e45:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

  for (i =0 ; i<NUMSIG ; i++)
80104e47:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80104e4e:	eb 21                	jmp    80104e71 <fork+0xe5>
  {
    np->handlers[i]=proc->handlers[i];
80104e50:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104e56:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80104e59:	83 c2 24             	add    $0x24,%edx
80104e5c:	8b 54 90 0c          	mov    0xc(%eax,%edx,4),%edx
80104e60:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104e63:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80104e66:	83 c1 24             	add    $0x24,%ecx
80104e69:	89 54 88 0c          	mov    %edx,0xc(%eax,%ecx,4)
  }
  np->sz = proc->sz;
  np->parent = proc;
  *np->tf = *proc->tf;

  for (i =0 ; i<NUMSIG ; i++)
80104e6d:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
80104e71:	83 7d e4 1f          	cmpl   $0x1f,-0x1c(%ebp)
80104e75:	7e d9                	jle    80104e50 <fork+0xc4>
  {
    np->handlers[i]=proc->handlers[i];
  }

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;
80104e77:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104e7a:	8b 40 18             	mov    0x18(%eax),%eax
80104e7d:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)

  for(i = 0; i < NOFILE; i++)
80104e84:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80104e8b:	eb 3d                	jmp    80104eca <fork+0x13e>
    if(proc->ofile[i])
80104e8d:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104e93:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80104e96:	83 c2 08             	add    $0x8,%edx
80104e99:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
80104e9d:	85 c0                	test   %eax,%eax
80104e9f:	74 25                	je     80104ec6 <fork+0x13a>
      np->ofile[i] = filedup(proc->ofile[i]);
80104ea1:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104ea7:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80104eaa:	83 c2 08             	add    $0x8,%edx
80104ead:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
80104eb1:	89 04 24             	mov    %eax,(%esp)
80104eb4:	e8 17 c8 ff ff       	call   801016d0 <filedup>
80104eb9:	8b 55 e0             	mov    -0x20(%ebp),%edx
80104ebc:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80104ebf:	83 c1 08             	add    $0x8,%ecx
80104ec2:	89 44 8a 08          	mov    %eax,0x8(%edx,%ecx,4)
  }

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
80104ec6:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
80104eca:	83 7d e4 0f          	cmpl   $0xf,-0x1c(%ebp)
80104ece:	7e bd                	jle    80104e8d <fork+0x101>
    if(proc->ofile[i])
      np->ofile[i] = filedup(proc->ofile[i]);
  np->cwd = idup(proc->cwd);
80104ed0:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104ed6:	8b 40 68             	mov    0x68(%eax),%eax
80104ed9:	89 04 24             	mov    %eax,(%esp)
80104edc:	e8 a9 d0 ff ff       	call   80101f8a <idup>
80104ee1:	8b 55 e0             	mov    -0x20(%ebp),%edx
80104ee4:	89 42 68             	mov    %eax,0x68(%edx)
 
  pid = np->pid;
80104ee7:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104eea:	8b 40 10             	mov    0x10(%eax),%eax
80104eed:	89 45 dc             	mov    %eax,-0x24(%ebp)
  changeStatus(RUNNABLE,np);
80104ef0:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104ef3:	89 44 24 04          	mov    %eax,0x4(%esp)
80104ef7:	c7 04 24 03 00 00 00 	movl   $0x3,(%esp)
80104efe:	e8 d5 fa ff ff       	call   801049d8 <changeStatus>
  safestrcpy(np->name, proc->name, sizeof(proc->name));
80104f03:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104f09:	8d 50 6c             	lea    0x6c(%eax),%edx
80104f0c:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104f0f:	83 c0 6c             	add    $0x6c,%eax
80104f12:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
80104f19:	00 
80104f1a:	89 54 24 04          	mov    %edx,0x4(%esp)
80104f1e:	89 04 24             	mov    %eax,(%esp)
80104f21:	e8 10 10 00 00       	call   80105f36 <safestrcpy>
  return pid;
80104f26:	8b 45 dc             	mov    -0x24(%ebp),%eax
}
80104f29:	83 c4 2c             	add    $0x2c,%esp
80104f2c:	5b                   	pop    %ebx
80104f2d:	5e                   	pop    %esi
80104f2e:	5f                   	pop    %edi
80104f2f:	5d                   	pop    %ebp
80104f30:	c3                   	ret    

80104f31 <exit>:
// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait() to find out it exited.
void
exit(void)
{
80104f31:	55                   	push   %ebp
80104f32:	89 e5                	mov    %esp,%ebp
80104f34:	53                   	push   %ebx
80104f35:	83 ec 24             	sub    $0x24,%esp
  struct proc *p;
  int fd;

  if(proc == initproc)
80104f38:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80104f3f:	a1 88 cb 10 80       	mov    0x8010cb88,%eax
80104f44:	39 c2                	cmp    %eax,%edx
80104f46:	75 0c                	jne    80104f54 <exit+0x23>
    panic("init exiting");
80104f48:	c7 04 24 ed 96 10 80 	movl   $0x801096ed,(%esp)
80104f4f:	e8 e9 b5 ff ff       	call   8010053d <panic>

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
80104f54:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
80104f5b:	eb 44                	jmp    80104fa1 <exit+0x70>
    if(proc->ofile[fd]){
80104f5d:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104f63:	8b 55 f0             	mov    -0x10(%ebp),%edx
80104f66:	83 c2 08             	add    $0x8,%edx
80104f69:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
80104f6d:	85 c0                	test   %eax,%eax
80104f6f:	74 2c                	je     80104f9d <exit+0x6c>
      fileclose(proc->ofile[fd]);
80104f71:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104f77:	8b 55 f0             	mov    -0x10(%ebp),%edx
80104f7a:	83 c2 08             	add    $0x8,%edx
80104f7d:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
80104f81:	89 04 24             	mov    %eax,(%esp)
80104f84:	e8 8f c7 ff ff       	call   80101718 <fileclose>
      proc->ofile[fd] = 0;
80104f89:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104f8f:	8b 55 f0             	mov    -0x10(%ebp),%edx
80104f92:	83 c2 08             	add    $0x8,%edx
80104f95:	c7 44 90 08 00 00 00 	movl   $0x0,0x8(%eax,%edx,4)
80104f9c:	00 

  if(proc == initproc)
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
80104f9d:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
80104fa1:	83 7d f0 0f          	cmpl   $0xf,-0x10(%ebp)
80104fa5:	7e b6                	jle    80104f5d <exit+0x2c>
      fileclose(proc->ofile[fd]);
      proc->ofile[fd] = 0;
    }
  }

  iput(proc->cwd);
80104fa7:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104fad:	8b 40 68             	mov    0x68(%eax),%eax
80104fb0:	89 04 24             	mov    %eax,(%esp)
80104fb3:	e8 b7 d1 ff ff       	call   8010216f <iput>
  proc->cwd = 0;
80104fb8:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104fbe:	c7 40 68 00 00 00 00 	movl   $0x0,0x68(%eax)
  proc->etime=get_time();
80104fc5:	65 8b 1d 04 00 00 00 	mov    %gs:0x4,%ebx
80104fcc:	e8 af f7 ff ff       	call   80104780 <get_time>
80104fd1:	89 83 88 00 00 00    	mov    %eax,0x88(%ebx)
  proc->queue=0;
80104fd7:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104fdd:	c7 40 7c 00 00 00 00 	movl   $0x0,0x7c(%eax)

  acquire(&ptable.lock);
80104fe4:	c7 04 24 e0 21 11 80 	movl   $0x801121e0,(%esp)
80104feb:	e8 c7 0a 00 00       	call   80105ab7 <acquire>

  // Parent might be sleeping in wait().
  wakeup1(proc->parent);
80104ff0:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104ff6:	8b 40 14             	mov    0x14(%eax),%eax
80104ff9:	89 04 24             	mov    %eax,(%esp)
80104ffc:	e8 cc 06 00 00       	call   801056cd <wakeup1>

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80105001:	c7 45 f4 14 22 11 80 	movl   $0x80112214,-0xc(%ebp)
80105008:	eb 3b                	jmp    80105045 <exit+0x114>
    if(p->parent == proc){
8010500a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010500d:	8b 50 14             	mov    0x14(%eax),%edx
80105010:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105016:	39 c2                	cmp    %eax,%edx
80105018:	75 24                	jne    8010503e <exit+0x10d>
      p->parent = initproc;
8010501a:	8b 15 88 cb 10 80    	mov    0x8010cb88,%edx
80105020:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105023:	89 50 14             	mov    %edx,0x14(%eax)
      if(p->state == ZOMBIE)
80105026:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105029:	8b 40 0c             	mov    0xc(%eax),%eax
8010502c:	83 f8 05             	cmp    $0x5,%eax
8010502f:	75 0d                	jne    8010503e <exit+0x10d>
        wakeup1(initproc);
80105031:	a1 88 cb 10 80       	mov    0x8010cb88,%eax
80105036:	89 04 24             	mov    %eax,(%esp)
80105039:	e8 8f 06 00 00       	call   801056cd <wakeup1>

  // Parent might be sleeping in wait().
  wakeup1(proc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010503e:	81 45 f4 20 01 00 00 	addl   $0x120,-0xc(%ebp)
80105045:	81 7d f4 14 6a 11 80 	cmpl   $0x80116a14,-0xc(%ebp)
8010504c:	72 bc                	jb     8010500a <exit+0xd9>
        wakeup1(initproc);
    }
  }

  // Jump into the scheduler, never to return.
  changeStatus(ZOMBIE,proc);
8010504e:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105054:	89 44 24 04          	mov    %eax,0x4(%esp)
80105058:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
8010505f:	e8 74 f9 ff ff       	call   801049d8 <changeStatus>
  sched();
80105064:	e8 a7 04 00 00       	call   80105510 <sched>
  panic("zombie exit");
80105069:	c7 04 24 fa 96 10 80 	movl   $0x801096fa,(%esp)
80105070:	e8 c8 b4 ff ff       	call   8010053d <panic>

80105075 <wait>:

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait(void)
{
80105075:	55                   	push   %ebp
80105076:	89 e5                	mov    %esp,%ebp
80105078:	83 ec 28             	sub    $0x28,%esp
  struct proc *p;
  int havekids, pid;

  acquire(&ptable.lock);
8010507b:	c7 04 24 e0 21 11 80 	movl   $0x801121e0,(%esp)
80105082:	e8 30 0a 00 00       	call   80105ab7 <acquire>
  for(;;){
    // Scan through table looking for zombie children.
    havekids = 0;
80105087:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010508e:	c7 45 f4 14 22 11 80 	movl   $0x80112214,-0xc(%ebp)
80105095:	e9 b4 00 00 00       	jmp    8010514e <wait+0xd9>
      if(p->parent != proc)
8010509a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010509d:	8b 50 14             	mov    0x14(%eax),%edx
801050a0:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801050a6:	39 c2                	cmp    %eax,%edx
801050a8:	0f 85 98 00 00 00    	jne    80105146 <wait+0xd1>
        continue;
      havekids = 1;
801050ae:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
      if(p->state == ZOMBIE){
801050b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801050b8:	8b 40 0c             	mov    0xc(%eax),%eax
801050bb:	83 f8 05             	cmp    $0x5,%eax
801050be:	0f 85 83 00 00 00    	jne    80105147 <wait+0xd2>
        // Found one.
        pid = p->pid;
801050c4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801050c7:	8b 40 10             	mov    0x10(%eax),%eax
801050ca:	89 45 ec             	mov    %eax,-0x14(%ebp)
        kfree(p->kstack);
801050cd:	8b 45 f4             	mov    -0xc(%ebp),%eax
801050d0:	8b 40 08             	mov    0x8(%eax),%eax
801050d3:	89 04 24             	mov    %eax,(%esp)
801050d6:	e8 df e0 ff ff       	call   801031ba <kfree>
        p->kstack = 0;
801050db:	8b 45 f4             	mov    -0xc(%ebp),%eax
801050de:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
        freevm(p->pgdir);
801050e5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801050e8:	8b 40 04             	mov    0x4(%eax),%eax
801050eb:	89 04 24             	mov    %eax,(%esp)
801050ee:	e8 c6 3f 00 00       	call   801090b9 <freevm>
        changeStatus(UNUSED,p);
801050f3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801050f6:	89 44 24 04          	mov    %eax,0x4(%esp)
801050fa:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105101:	e8 d2 f8 ff ff       	call   801049d8 <changeStatus>
        p->pid = 0;
80105106:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105109:	c7 40 10 00 00 00 00 	movl   $0x0,0x10(%eax)
        p->parent = 0;
80105110:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105113:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
        p->name[0] = 0;
8010511a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010511d:	c6 40 6c 00          	movb   $0x0,0x6c(%eax)
        p->killed = 0;
80105121:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105124:	c7 40 24 00 00 00 00 	movl   $0x0,0x24(%eax)
        p->queue=0;
8010512b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010512e:	c7 40 7c 00 00 00 00 	movl   $0x0,0x7c(%eax)
       
        release(&ptable.lock);
80105135:	c7 04 24 e0 21 11 80 	movl   $0x801121e0,(%esp)
8010513c:	e8 d8 09 00 00       	call   80105b19 <release>
        return pid;
80105141:	8b 45 ec             	mov    -0x14(%ebp),%eax
80105144:	eb 56                	jmp    8010519c <wait+0x127>
  for(;;){
    // Scan through table looking for zombie children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
      if(p->parent != proc)
        continue;
80105146:	90                   	nop

  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for zombie children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80105147:	81 45 f4 20 01 00 00 	addl   $0x120,-0xc(%ebp)
8010514e:	81 7d f4 14 6a 11 80 	cmpl   $0x80116a14,-0xc(%ebp)
80105155:	0f 82 3f ff ff ff    	jb     8010509a <wait+0x25>
        return pid;
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || proc->killed){
8010515b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
8010515f:	74 0d                	je     8010516e <wait+0xf9>
80105161:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105167:	8b 40 24             	mov    0x24(%eax),%eax
8010516a:	85 c0                	test   %eax,%eax
8010516c:	74 13                	je     80105181 <wait+0x10c>
      release(&ptable.lock);
8010516e:	c7 04 24 e0 21 11 80 	movl   $0x801121e0,(%esp)
80105175:	e8 9f 09 00 00       	call   80105b19 <release>
      return -1;
8010517a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010517f:	eb 1b                	jmp    8010519c <wait+0x127>
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(proc, &ptable.lock);  //DOC: wait-sleep
80105181:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105187:	c7 44 24 04 e0 21 11 	movl   $0x801121e0,0x4(%esp)
8010518e:	80 
8010518f:	89 04 24             	mov    %eax,(%esp)
80105192:	e8 92 04 00 00       	call   80105629 <sleep>
  }
80105197:	e9 eb fe ff ff       	jmp    80105087 <wait+0x12>
}
8010519c:	c9                   	leave  
8010519d:	c3                   	ret    

8010519e <wait2>:


int 
wait2(int *wtime, int *rtime, int *iotime)
{
8010519e:	55                   	push   %ebp
8010519f:	89 e5                	mov    %esp,%ebp
801051a1:	83 ec 28             	sub    $0x28,%esp
struct proc *p;
  int havekids, pid;

  acquire(&ptable.lock);
801051a4:	c7 04 24 e0 21 11 80 	movl   $0x801121e0,(%esp)
801051ab:	e8 07 09 00 00       	call   80105ab7 <acquire>
  for(;;){
    // Scan through table looking for zombie children.
    havekids = 0;
801051b0:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801051b7:	c7 45 f4 14 22 11 80 	movl   $0x80112214,-0xc(%ebp)
801051be:	e9 09 01 00 00       	jmp    801052cc <wait2+0x12e>
      if(p->parent != proc)
801051c3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801051c6:	8b 50 14             	mov    0x14(%eax),%edx
801051c9:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801051cf:	39 c2                	cmp    %eax,%edx
801051d1:	0f 85 ed 00 00 00    	jne    801052c4 <wait2+0x126>
        continue;
      havekids = 1;
801051d7:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
      if(p->state == ZOMBIE){
801051de:	8b 45 f4             	mov    -0xc(%ebp),%eax
801051e1:	8b 40 0c             	mov    0xc(%eax),%eax
801051e4:	83 f8 05             	cmp    $0x5,%eax
801051e7:	0f 85 d8 00 00 00    	jne    801052c5 <wait2+0x127>
        // Found one.
        pid = p->pid;
801051ed:	8b 45 f4             	mov    -0xc(%ebp),%eax
801051f0:	8b 40 10             	mov    0x10(%eax),%eax
801051f3:	89 45 ec             	mov    %eax,-0x14(%ebp)
        kfree(p->kstack);
801051f6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801051f9:	8b 40 08             	mov    0x8(%eax),%eax
801051fc:	89 04 24             	mov    %eax,(%esp)
801051ff:	e8 b6 df ff ff       	call   801031ba <kfree>
        p->kstack = 0;
80105204:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105207:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
        freevm(p->pgdir);
8010520e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105211:	8b 40 04             	mov    0x4(%eax),%eax
80105214:	89 04 24             	mov    %eax,(%esp)
80105217:	e8 9d 3e 00 00       	call   801090b9 <freevm>
        changeStatus(UNUSED,p);
8010521c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010521f:	89 44 24 04          	mov    %eax,0x4(%esp)
80105223:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
8010522a:	e8 a9 f7 ff ff       	call   801049d8 <changeStatus>
        p->pid = 0;
8010522f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105232:	c7 40 10 00 00 00 00 	movl   $0x0,0x10(%eax)
        p->parent = 0;
80105239:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010523c:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
        p->name[0] = 0;
80105243:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105246:	c6 40 6c 00          	movb   $0x0,0x6c(%eax)
        p->killed = 0;
8010524a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010524d:	c7 40 24 00 00 00 00 	movl   $0x0,0x24(%eax)
        p->queue=0;
80105254:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105257:	c7 40 7c 00 00 00 00 	movl   $0x0,0x7c(%eax)
        *wtime=p->etime-p->ctime-p->rtime-p->iotime;
8010525e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105261:	8b 90 88 00 00 00    	mov    0x88(%eax),%edx
80105267:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010526a:	8b 80 84 00 00 00    	mov    0x84(%eax),%eax
80105270:	29 c2                	sub    %eax,%edx
80105272:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105275:	8b 80 90 00 00 00    	mov    0x90(%eax),%eax
8010527b:	29 c2                	sub    %eax,%edx
8010527d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105280:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
80105286:	89 d1                	mov    %edx,%ecx
80105288:	29 c1                	sub    %eax,%ecx
8010528a:	89 c8                	mov    %ecx,%eax
8010528c:	89 c2                	mov    %eax,%edx
8010528e:	8b 45 08             	mov    0x8(%ebp),%eax
80105291:	89 10                	mov    %edx,(%eax)
        *rtime=p->rtime;
80105293:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105296:	8b 80 90 00 00 00    	mov    0x90(%eax),%eax
8010529c:	89 c2                	mov    %eax,%edx
8010529e:	8b 45 0c             	mov    0xc(%ebp),%eax
801052a1:	89 10                	mov    %edx,(%eax)
        *iotime=p->iotime;
801052a3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801052a6:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
801052ac:	89 c2                	mov    %eax,%edx
801052ae:	8b 45 10             	mov    0x10(%ebp),%eax
801052b1:	89 10                	mov    %edx,(%eax)
        
        release(&ptable.lock);
801052b3:	c7 04 24 e0 21 11 80 	movl   $0x801121e0,(%esp)
801052ba:	e8 5a 08 00 00       	call   80105b19 <release>
        return pid;
801052bf:	8b 45 ec             	mov    -0x14(%ebp),%eax
801052c2:	eb 56                	jmp    8010531a <wait2+0x17c>
  for(;;){
    // Scan through table looking for zombie children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
      if(p->parent != proc)
        continue;
801052c4:	90                   	nop

  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for zombie children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801052c5:	81 45 f4 20 01 00 00 	addl   $0x120,-0xc(%ebp)
801052cc:	81 7d f4 14 6a 11 80 	cmpl   $0x80116a14,-0xc(%ebp)
801052d3:	0f 82 ea fe ff ff    	jb     801051c3 <wait2+0x25>
        return pid;
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || proc->killed){
801052d9:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801052dd:	74 0d                	je     801052ec <wait2+0x14e>
801052df:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801052e5:	8b 40 24             	mov    0x24(%eax),%eax
801052e8:	85 c0                	test   %eax,%eax
801052ea:	74 13                	je     801052ff <wait2+0x161>
      release(&ptable.lock);
801052ec:	c7 04 24 e0 21 11 80 	movl   $0x801121e0,(%esp)
801052f3:	e8 21 08 00 00       	call   80105b19 <release>
      return -1;
801052f8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801052fd:	eb 1b                	jmp    8010531a <wait2+0x17c>
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(proc, &ptable.lock);  //DOC: wait-sleep
801052ff:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105305:	c7 44 24 04 e0 21 11 	movl   $0x801121e0,0x4(%esp)
8010530c:	80 
8010530d:	89 04 24             	mov    %eax,(%esp)
80105310:	e8 14 03 00 00       	call   80105629 <sleep>
  }
80105315:	e9 96 fe ff ff       	jmp    801051b0 <wait2+0x12>
}
8010531a:	c9                   	leave  
8010531b:	c3                   	ret    

8010531c <register_handler>:


void
register_handler(sighandler_t sighandler)
{
8010531c:	55                   	push   %ebp
8010531d:	89 e5                	mov    %esp,%ebp
8010531f:	83 ec 28             	sub    $0x28,%esp
  char* addr = uva2ka(proc->pgdir, (char*)proc->tf->esp);
80105322:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105328:	8b 40 18             	mov    0x18(%eax),%eax
8010532b:	8b 40 44             	mov    0x44(%eax),%eax
8010532e:	89 c2                	mov    %eax,%edx
80105330:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105336:	8b 40 04             	mov    0x4(%eax),%eax
80105339:	89 54 24 04          	mov    %edx,0x4(%esp)
8010533d:	89 04 24             	mov    %eax,(%esp)
80105340:	e8 59 3f 00 00       	call   8010929e <uva2ka>
80105345:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if ((proc->tf->esp & 0xFFF) == 0)
80105348:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010534e:	8b 40 18             	mov    0x18(%eax),%eax
80105351:	8b 40 44             	mov    0x44(%eax),%eax
80105354:	25 ff 0f 00 00       	and    $0xfff,%eax
80105359:	85 c0                	test   %eax,%eax
8010535b:	75 0c                	jne    80105369 <register_handler+0x4d>
    panic("esp_offset == 0");
8010535d:	c7 04 24 06 97 10 80 	movl   $0x80109706,(%esp)
80105364:	e8 d4 b1 ff ff       	call   8010053d <panic>

    /* open a new frame */
  *(int*)(addr + ((proc->tf->esp - 4) & 0xFFF))
80105369:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010536f:	8b 40 18             	mov    0x18(%eax),%eax
80105372:	8b 40 44             	mov    0x44(%eax),%eax
80105375:	83 e8 04             	sub    $0x4,%eax
80105378:	25 ff 0f 00 00       	and    $0xfff,%eax
8010537d:	03 45 f4             	add    -0xc(%ebp),%eax
          = proc->tf->eip;
80105380:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80105387:	8b 52 18             	mov    0x18(%edx),%edx
8010538a:	8b 52 38             	mov    0x38(%edx),%edx
8010538d:	89 10                	mov    %edx,(%eax)
  proc->tf->esp -= 4;
8010538f:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105395:	8b 40 18             	mov    0x18(%eax),%eax
80105398:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
8010539f:	8b 52 18             	mov    0x18(%edx),%edx
801053a2:	8b 52 44             	mov    0x44(%edx),%edx
801053a5:	83 ea 04             	sub    $0x4,%edx
801053a8:	89 50 44             	mov    %edx,0x44(%eax)

    /* update eip */
  proc->tf->eip = (uint)sighandler;
801053ab:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801053b1:	8b 40 18             	mov    0x18(%eax),%eax
801053b4:	8b 55 08             	mov    0x8(%ebp),%edx
801053b7:	89 50 38             	mov    %edx,0x38(%eax)
}
801053ba:	c9                   	leave  
801053bb:	c3                   	ret    

801053bc <operateProcess>:


void
operateProcess(struct proc *p){
801053bc:	55                   	push   %ebp
801053bd:	89 e5                	mov    %esp,%ebp
801053bf:	83 ec 28             	sub    $0x28,%esp
  int i=0;
801053c2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  
  int bit=1;
801053c9:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
  while(p->pending!=0)
801053d0:	eb 7a                	jmp    8010544c <operateProcess+0x90>
  {
    if((p->pending & bit )>0)
801053d2:	8b 45 08             	mov    0x8(%ebp),%eax
801053d5:	8b 90 98 00 00 00    	mov    0x98(%eax),%edx
801053db:	8b 45 f0             	mov    -0x10(%ebp),%eax
801053de:	21 d0                	and    %edx,%eax
801053e0:	85 c0                	test   %eax,%eax
801053e2:	74 4d                	je     80105431 <operateProcess+0x75>
    {
      if(p->handlers[i] == &def_Handler)
801053e4:	8b 45 08             	mov    0x8(%ebp),%eax
801053e7:	8b 55 f4             	mov    -0xc(%ebp),%edx
801053ea:	83 c2 24             	add    $0x24,%edx
801053ed:	8b 54 90 0c          	mov    0xc(%eax,%edx,4),%edx
801053f1:	b8 5f 47 10 80       	mov    $0x8010475f,%eax
801053f6:	39 c2                	cmp    %eax,%edx
801053f8:	75 07                	jne    80105401 <operateProcess+0x45>
      {
	def_Handler();
801053fa:	e8 60 f3 ff ff       	call   8010475f <def_Handler>
801053ff:	eb 15                	jmp    80105416 <operateProcess+0x5a>
      }
      else
      {
	register_handler(p->handlers[i]);
80105401:	8b 45 08             	mov    0x8(%ebp),%eax
80105404:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105407:	83 c2 24             	add    $0x24,%edx
8010540a:	8b 44 90 0c          	mov    0xc(%eax,%edx,4),%eax
8010540e:	89 04 24             	mov    %eax,(%esp)
80105411:	e8 06 ff ff ff       	call   8010531c <register_handler>
      }
      p->pending = (p->pending) & ~bit ;
80105416:	8b 45 08             	mov    0x8(%ebp),%eax
80105419:	8b 90 98 00 00 00    	mov    0x98(%eax),%edx
8010541f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105422:	f7 d0                	not    %eax
80105424:	21 c2                	and    %eax,%edx
80105426:	8b 45 08             	mov    0x8(%ebp),%eax
80105429:	89 90 98 00 00 00    	mov    %edx,0x98(%eax)
      
      break;
8010542f:	eb 2c                	jmp    8010545d <operateProcess+0xa1>
    }
    bit = bit *2;
80105431:	d1 65 f0             	shll   -0x10(%ebp)
    i++;
80105434:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    if(i>=NUMSIG)
80105438:	83 7d f4 1f          	cmpl   $0x1f,-0xc(%ebp)
8010543c:	7e 0e                	jle    8010544c <operateProcess+0x90>
    {
      bit=1;
8010543e:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
      i=0;
80105445:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
void
operateProcess(struct proc *p){
  int i=0;
  
  int bit=1;
  while(p->pending!=0)
8010544c:	8b 45 08             	mov    0x8(%ebp),%eax
8010544f:	8b 80 98 00 00 00    	mov    0x98(%eax),%eax
80105455:	85 c0                	test   %eax,%eax
80105457:	0f 85 75 ff ff ff    	jne    801053d2 <operateProcess+0x16>
      bit=1;
      i=0;
    }
  }
  
  switchuvm(p);
8010545d:	8b 45 08             	mov    0x8(%ebp),%eax
80105460:	89 04 24             	mov    %eax,(%esp)
80105463:	e8 da 37 00 00       	call   80108c42 <switchuvm>
  changeStatus(RUNNING,p);
80105468:	8b 45 08             	mov    0x8(%ebp),%eax
8010546b:	89 44 24 04          	mov    %eax,0x4(%esp)
8010546f:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
80105476:	e8 5d f5 ff ff       	call   801049d8 <changeStatus>
  swtch(&cpu->scheduler, proc->context);
8010547b:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105481:	8b 40 1c             	mov    0x1c(%eax),%eax
80105484:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
8010548b:	83 c2 04             	add    $0x4,%edx
8010548e:	89 44 24 04          	mov    %eax,0x4(%esp)
80105492:	89 14 24             	mov    %edx,(%esp)
80105495:	e8 72 0b 00 00       	call   8010600c <swtch>
  switchkvm();
8010549a:	e8 86 37 00 00       	call   80108c25 <switchkvm>

  proc = 0;
8010549f:	65 c7 05 04 00 00 00 	movl   $0x0,%gs:0x4
801054a6:	00 00 00 00 
}
801054aa:	c9                   	leave  
801054ab:	c3                   	ret    

801054ac <scheduler>:
//  - swtch to start running that process
//  - eventually that process transfers control
//      via swtch back to the scheduler.
void
scheduler(void)
{
801054ac:	55                   	push   %ebp
801054ad:	89 e5                	mov    %esp,%ebp
801054af:	83 ec 28             	sub    $0x28,%esp
  struct proc *p;
  int current;
  int workingQueue;
  for(;;){
    // Enable interrupts on this processor.
    sti();
801054b2:	e8 a2 f2 ff ff       	call   80104759 <sti>

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
801054b7:	c7 04 24 e0 21 11 80 	movl   $0x801121e0,(%esp)
801054be:	e8 f4 05 00 00       	call   80105ab7 <acquire>
          }
        }
      break;
        
      default:
        for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801054c3:	c7 45 f4 14 22 11 80 	movl   $0x80112214,-0xc(%ebp)
801054ca:	eb 2c                	jmp    801054f8 <scheduler+0x4c>
          if(p->state != RUNNABLE)
801054cc:	8b 45 f4             	mov    -0xc(%ebp),%eax
801054cf:	8b 40 0c             	mov    0xc(%eax),%eax
801054d2:	83 f8 03             	cmp    $0x3,%eax
801054d5:	75 19                	jne    801054f0 <scheduler+0x44>
            continue;
        
          // Switch to chosen process.  It is the process's job
          // to release ptable.lock and then reacquire it
          // before jumping back to us.
          proc = p;
801054d7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801054da:	65 a3 04 00 00 00    	mov    %eax,%gs:0x4
          operateProcess(proc);
801054e0:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801054e6:	89 04 24             	mov    %eax,(%esp)
801054e9:	e8 ce fe ff ff       	call   801053bc <operateProcess>
801054ee:	eb 01                	jmp    801054f1 <scheduler+0x45>
      break;
        
      default:
        for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
          if(p->state != RUNNABLE)
            continue;
801054f0:	90                   	nop
          }
        }
      break;
        
      default:
        for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801054f1:	81 45 f4 20 01 00 00 	addl   $0x120,-0xc(%ebp)
801054f8:	81 7d f4 14 6a 11 80 	cmpl   $0x80116a14,-0xc(%ebp)
801054ff:	72 cb                	jb     801054cc <scheduler+0x20>
          // to release ptable.lock and then reacquire it
          // before jumping back to us.
          proc = p;
          operateProcess(proc);
        }
      break;
80105501:	90                   	nop
    }
        release(&ptable.lock);
80105502:	c7 04 24 e0 21 11 80 	movl   $0x801121e0,(%esp)
80105509:	e8 0b 06 00 00       	call   80105b19 <release>
  }
8010550e:	eb a2                	jmp    801054b2 <scheduler+0x6>

80105510 <sched>:

// Enter scheduler.  Must hold only ptable.lock
// and have changed proc->state.
void
sched(void)
{
80105510:	55                   	push   %ebp
80105511:	89 e5                	mov    %esp,%ebp
80105513:	83 ec 28             	sub    $0x28,%esp
  int intena;

  if(!holding(&ptable.lock))
80105516:	c7 04 24 e0 21 11 80 	movl   $0x801121e0,(%esp)
8010551d:	e8 b3 06 00 00       	call   80105bd5 <holding>
80105522:	85 c0                	test   %eax,%eax
80105524:	75 0c                	jne    80105532 <sched+0x22>
    panic("sched ptable.lock");
80105526:	c7 04 24 16 97 10 80 	movl   $0x80109716,(%esp)
8010552d:	e8 0b b0 ff ff       	call   8010053d <panic>
  if(cpu->ncli != 1)
80105532:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80105538:	8b 80 ac 00 00 00    	mov    0xac(%eax),%eax
8010553e:	83 f8 01             	cmp    $0x1,%eax
80105541:	74 0c                	je     8010554f <sched+0x3f>
    panic("sched locks");
80105543:	c7 04 24 28 97 10 80 	movl   $0x80109728,(%esp)
8010554a:	e8 ee af ff ff       	call   8010053d <panic>
  if(proc->state == RUNNING)
8010554f:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105555:	8b 40 0c             	mov    0xc(%eax),%eax
80105558:	83 f8 04             	cmp    $0x4,%eax
8010555b:	75 0c                	jne    80105569 <sched+0x59>
    panic("sched running");
8010555d:	c7 04 24 34 97 10 80 	movl   $0x80109734,(%esp)
80105564:	e8 d4 af ff ff       	call   8010053d <panic>
  if(readeflags()&FL_IF)
80105569:	e8 d6 f1 ff ff       	call   80104744 <readeflags>
8010556e:	25 00 02 00 00       	and    $0x200,%eax
80105573:	85 c0                	test   %eax,%eax
80105575:	74 0c                	je     80105583 <sched+0x73>
    panic("sched interruptible");
80105577:	c7 04 24 42 97 10 80 	movl   $0x80109742,(%esp)
8010557e:	e8 ba af ff ff       	call   8010053d <panic>
  intena = cpu->intena;
80105583:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80105589:	8b 80 b0 00 00 00    	mov    0xb0(%eax),%eax
8010558f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  swtch(&proc->context, cpu->scheduler);
80105592:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80105598:	8b 40 04             	mov    0x4(%eax),%eax
8010559b:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
801055a2:	83 c2 1c             	add    $0x1c,%edx
801055a5:	89 44 24 04          	mov    %eax,0x4(%esp)
801055a9:	89 14 24             	mov    %edx,(%esp)
801055ac:	e8 5b 0a 00 00       	call   8010600c <swtch>

  cpu->intena = intena;
801055b1:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801055b7:	8b 55 f4             	mov    -0xc(%ebp),%edx
801055ba:	89 90 b0 00 00 00    	mov    %edx,0xb0(%eax)
}
801055c0:	c9                   	leave  
801055c1:	c3                   	ret    

801055c2 <yield>:

// Give up the CPU for one scheduling round.
void
yield(void)
{
801055c2:	55                   	push   %ebp
801055c3:	89 e5                	mov    %esp,%ebp
801055c5:	83 ec 18             	sub    $0x18,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
801055c8:	c7 04 24 e0 21 11 80 	movl   $0x801121e0,(%esp)
801055cf:	e8 e3 04 00 00       	call   80105ab7 <acquire>
   changeStatus(RUNNABLE,proc);
801055d4:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801055da:	89 44 24 04          	mov    %eax,0x4(%esp)
801055de:	c7 04 24 03 00 00 00 	movl   $0x3,(%esp)
801055e5:	e8 ee f3 ff ff       	call   801049d8 <changeStatus>
  sched();
801055ea:	e8 21 ff ff ff       	call   80105510 <sched>
  release(&ptable.lock);
801055ef:	c7 04 24 e0 21 11 80 	movl   $0x801121e0,(%esp)
801055f6:	e8 1e 05 00 00       	call   80105b19 <release>
}
801055fb:	c9                   	leave  
801055fc:	c3                   	ret    

801055fd <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
801055fd:	55                   	push   %ebp
801055fe:	89 e5                	mov    %esp,%ebp
80105600:	83 ec 18             	sub    $0x18,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
80105603:	c7 04 24 e0 21 11 80 	movl   $0x801121e0,(%esp)
8010560a:	e8 0a 05 00 00       	call   80105b19 <release>

  if (first) {
8010560f:	a1 20 c0 10 80       	mov    0x8010c020,%eax
80105614:	85 c0                	test   %eax,%eax
80105616:	74 0f                	je     80105627 <forkret+0x2a>
    // Some initialization functions must be run in the context
    // of a regular process (e.g., they call sleep), and thus cannot 
    // be run from main().
    first = 0;
80105618:	c7 05 20 c0 10 80 00 	movl   $0x0,0x8010c020
8010561f:	00 00 00 
    initlog();
80105622:	e8 3d e1 ff ff       	call   80103764 <initlog>
  }
  
  // Return to "caller", actually trapret (see allocproc).
}
80105627:	c9                   	leave  
80105628:	c3                   	ret    

80105629 <sleep>:

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
80105629:	55                   	push   %ebp
8010562a:	89 e5                	mov    %esp,%ebp
8010562c:	83 ec 18             	sub    $0x18,%esp
  if(proc == 0)
8010562f:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105635:	85 c0                	test   %eax,%eax
80105637:	75 0c                	jne    80105645 <sleep+0x1c>
    panic("sleep");
80105639:	c7 04 24 56 97 10 80 	movl   $0x80109756,(%esp)
80105640:	e8 f8 ae ff ff       	call   8010053d <panic>

  if(lk == 0)
80105645:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
80105649:	75 0c                	jne    80105657 <sleep+0x2e>
    panic("sleep without lk");
8010564b:	c7 04 24 5c 97 10 80 	movl   $0x8010975c,(%esp)
80105652:	e8 e6 ae ff ff       	call   8010053d <panic>
  // change p->state and then call sched.
  // Once we hold ptable.lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup runs with ptable.lock locked),
  // so it's okay to release lk.
  if(lk != &ptable.lock){  //DOC: sleeplock0
80105657:	81 7d 0c e0 21 11 80 	cmpl   $0x801121e0,0xc(%ebp)
8010565e:	74 17                	je     80105677 <sleep+0x4e>
    acquire(&ptable.lock);  //DOC: sleeplock1
80105660:	c7 04 24 e0 21 11 80 	movl   $0x801121e0,(%esp)
80105667:	e8 4b 04 00 00       	call   80105ab7 <acquire>
    release(lk);
8010566c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010566f:	89 04 24             	mov    %eax,(%esp)
80105672:	e8 a2 04 00 00       	call   80105b19 <release>
  }

  // Go to sleep.
  proc->chan = chan;
80105677:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010567d:	8b 55 08             	mov    0x8(%ebp),%edx
80105680:	89 50 20             	mov    %edx,0x20(%eax)
   changeStatus(SLEEPING,proc);
80105683:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105689:	89 44 24 04          	mov    %eax,0x4(%esp)
8010568d:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
80105694:	e8 3f f3 ff ff       	call   801049d8 <changeStatus>
 
  sched();
80105699:	e8 72 fe ff ff       	call   80105510 <sched>

  // Tidy up.
  proc->chan = 0;
8010569e:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801056a4:	c7 40 20 00 00 00 00 	movl   $0x0,0x20(%eax)

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
801056ab:	81 7d 0c e0 21 11 80 	cmpl   $0x801121e0,0xc(%ebp)
801056b2:	74 17                	je     801056cb <sleep+0xa2>
    release(&ptable.lock);
801056b4:	c7 04 24 e0 21 11 80 	movl   $0x801121e0,(%esp)
801056bb:	e8 59 04 00 00       	call   80105b19 <release>
    acquire(lk);
801056c0:	8b 45 0c             	mov    0xc(%ebp),%eax
801056c3:	89 04 24             	mov    %eax,(%esp)
801056c6:	e8 ec 03 00 00       	call   80105ab7 <acquire>
  }
}
801056cb:	c9                   	leave  
801056cc:	c3                   	ret    

801056cd <wakeup1>:
//PAGEBREAK!
// Wake up all processes sleeping on chan.
// The ptable lock must be held.
static void
wakeup1(void *chan)
{
801056cd:	55                   	push   %ebp
801056ce:	89 e5                	mov    %esp,%ebp
801056d0:	83 ec 28             	sub    $0x28,%esp
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801056d3:	c7 45 f4 14 22 11 80 	movl   $0x80112214,-0xc(%ebp)
801056da:	eb 30                	jmp    8010570c <wakeup1+0x3f>
    if(p->state == SLEEPING && p->chan == chan)
801056dc:	8b 45 f4             	mov    -0xc(%ebp),%eax
801056df:	8b 40 0c             	mov    0xc(%eax),%eax
801056e2:	83 f8 02             	cmp    $0x2,%eax
801056e5:	75 1e                	jne    80105705 <wakeup1+0x38>
801056e7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801056ea:	8b 40 20             	mov    0x20(%eax),%eax
801056ed:	3b 45 08             	cmp    0x8(%ebp),%eax
801056f0:	75 13                	jne    80105705 <wakeup1+0x38>
    {
      changeStatus(RUNNABLE,p);
801056f2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801056f5:	89 44 24 04          	mov    %eax,0x4(%esp)
801056f9:	c7 04 24 03 00 00 00 	movl   $0x3,(%esp)
80105700:	e8 d3 f2 ff ff       	call   801049d8 <changeStatus>
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80105705:	81 45 f4 20 01 00 00 	addl   $0x120,-0xc(%ebp)
8010570c:	81 7d f4 14 6a 11 80 	cmpl   $0x80116a14,-0xc(%ebp)
80105713:	72 c7                	jb     801056dc <wakeup1+0xf>
    if(p->state == SLEEPING && p->chan == chan)
    {
      changeStatus(RUNNABLE,p);
    }
    
}
80105715:	c9                   	leave  
80105716:	c3                   	ret    

80105717 <wakeup>:

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
80105717:	55                   	push   %ebp
80105718:	89 e5                	mov    %esp,%ebp
8010571a:	83 ec 18             	sub    $0x18,%esp
  acquire(&ptable.lock);
8010571d:	c7 04 24 e0 21 11 80 	movl   $0x801121e0,(%esp)
80105724:	e8 8e 03 00 00       	call   80105ab7 <acquire>
  wakeup1(chan);
80105729:	8b 45 08             	mov    0x8(%ebp),%eax
8010572c:	89 04 24             	mov    %eax,(%esp)
8010572f:	e8 99 ff ff ff       	call   801056cd <wakeup1>
  release(&ptable.lock);
80105734:	c7 04 24 e0 21 11 80 	movl   $0x801121e0,(%esp)
8010573b:	e8 d9 03 00 00       	call   80105b19 <release>
}
80105740:	c9                   	leave  
80105741:	c3                   	ret    

80105742 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
80105742:	55                   	push   %ebp
80105743:	89 e5                	mov    %esp,%ebp
80105745:	83 ec 28             	sub    $0x28,%esp
  struct proc *p;

  acquire(&ptable.lock);
80105748:	c7 04 24 e0 21 11 80 	movl   $0x801121e0,(%esp)
8010574f:	e8 63 03 00 00       	call   80105ab7 <acquire>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80105754:	c7 45 f4 14 22 11 80 	movl   $0x80112214,-0xc(%ebp)
8010575b:	eb 4d                	jmp    801057aa <kill+0x68>
    if(p->pid == pid){
8010575d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105760:	8b 40 10             	mov    0x10(%eax),%eax
80105763:	3b 45 08             	cmp    0x8(%ebp),%eax
80105766:	75 3b                	jne    801057a3 <kill+0x61>
      p->killed = 1;
80105768:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010576b:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING){
80105772:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105775:	8b 40 0c             	mov    0xc(%eax),%eax
80105778:	83 f8 02             	cmp    $0x2,%eax
8010577b:	75 13                	jne    80105790 <kill+0x4e>
        changeStatus(RUNNABLE,p);
8010577d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105780:	89 44 24 04          	mov    %eax,0x4(%esp)
80105784:	c7 04 24 03 00 00 00 	movl   $0x3,(%esp)
8010578b:	e8 48 f2 ff ff       	call   801049d8 <changeStatus>
      }
      
      release(&ptable.lock);
80105790:	c7 04 24 e0 21 11 80 	movl   $0x801121e0,(%esp)
80105797:	e8 7d 03 00 00       	call   80105b19 <release>
      return 0;
8010579c:	b8 00 00 00 00       	mov    $0x0,%eax
801057a1:	eb 21                	jmp    801057c4 <kill+0x82>
kill(int pid)
{
  struct proc *p;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801057a3:	81 45 f4 20 01 00 00 	addl   $0x120,-0xc(%ebp)
801057aa:	81 7d f4 14 6a 11 80 	cmpl   $0x80116a14,-0xc(%ebp)
801057b1:	72 aa                	jb     8010575d <kill+0x1b>
      
      release(&ptable.lock);
      return 0;
    }
  }
  release(&ptable.lock);
801057b3:	c7 04 24 e0 21 11 80 	movl   $0x801121e0,(%esp)
801057ba:	e8 5a 03 00 00       	call   80105b19 <release>
  return -1;
801057bf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801057c4:	c9                   	leave  
801057c5:	c3                   	ret    

801057c6 <handle_sigsend>:

int
handle_sigsend(int pid, int signum)
{
801057c6:	55                   	push   %ebp
801057c7:	89 e5                	mov    %esp,%ebp
801057c9:	56                   	push   %esi
801057ca:	53                   	push   %ebx
801057cb:	83 ec 20             	sub    $0x20,%esp
  struct proc *p;

  acquire(&ptable.lock);
801057ce:	c7 04 24 e0 21 11 80 	movl   $0x801121e0,(%esp)
801057d5:	e8 dd 02 00 00       	call   80105ab7 <acquire>
      
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801057da:	c7 45 f4 14 22 11 80 	movl   $0x80112214,-0xc(%ebp)
801057e1:	eb 4c                	jmp    8010582f <handle_sigsend+0x69>
  {
    if(p->pid == pid)
801057e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801057e6:	8b 40 10             	mov    0x10(%eax),%eax
801057e9:	3b 45 08             	cmp    0x8(%ebp),%eax
801057ec:	75 3a                	jne    80105828 <handle_sigsend+0x62>
    {
      p->pending = p-> pending | (1 << (signum-1));
801057ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
801057f1:	8b 90 98 00 00 00    	mov    0x98(%eax),%edx
801057f7:	8b 45 0c             	mov    0xc(%ebp),%eax
801057fa:	83 e8 01             	sub    $0x1,%eax
801057fd:	bb 01 00 00 00       	mov    $0x1,%ebx
80105802:	89 de                	mov    %ebx,%esi
80105804:	89 c1                	mov    %eax,%ecx
80105806:	d3 e6                	shl    %cl,%esi
80105808:	89 f0                	mov    %esi,%eax
8010580a:	09 c2                	or     %eax,%edx
8010580c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010580f:	89 90 98 00 00 00    	mov    %edx,0x98(%eax)

      release(&ptable.lock);
80105815:	c7 04 24 e0 21 11 80 	movl   $0x801121e0,(%esp)
8010581c:	e8 f8 02 00 00       	call   80105b19 <release>
      return 0;
80105821:	b8 00 00 00 00       	mov    $0x0,%eax
80105826:	eb 21                	jmp    80105849 <handle_sigsend+0x83>
{
  struct proc *p;

  acquire(&ptable.lock);
      
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80105828:	81 45 f4 20 01 00 00 	addl   $0x120,-0xc(%ebp)
8010582f:	81 7d f4 14 6a 11 80 	cmpl   $0x80116a14,-0xc(%ebp)
80105836:	72 ab                	jb     801057e3 <handle_sigsend+0x1d>

      release(&ptable.lock);
      return 0;
    }
  }
  release(&ptable.lock);
80105838:	c7 04 24 e0 21 11 80 	movl   $0x801121e0,(%esp)
8010583f:	e8 d5 02 00 00       	call   80105b19 <release>
  return -1;
80105844:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105849:	83 c4 20             	add    $0x20,%esp
8010584c:	5b                   	pop    %ebx
8010584d:	5e                   	pop    %esi
8010584e:	5d                   	pop    %ebp
8010584f:	c3                   	ret    

80105850 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
80105850:	55                   	push   %ebp
80105851:	89 e5                	mov    %esp,%ebp
80105853:	53                   	push   %ebx
80105854:	83 ec 64             	sub    $0x64,%esp
  };
  int i;
  struct proc *p;
  char *state;
  uint pc[10];
  cprintf("Process List:\n");
80105857:	c7 04 24 6d 97 10 80 	movl   $0x8010976d,(%esp)
8010585e:	e8 3e ab ff ff       	call   801003a1 <cprintf>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80105863:	c7 45 f0 14 22 11 80 	movl   $0x80112214,-0x10(%ebp)
8010586a:	e9 3e 01 00 00       	jmp    801059ad <procdump+0x15d>
    if(p->state == UNUSED)
8010586f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105872:	8b 40 0c             	mov    0xc(%eax),%eax
80105875:	85 c0                	test   %eax,%eax
80105877:	0f 84 28 01 00 00    	je     801059a5 <procdump+0x155>
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
8010587d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105880:	8b 40 0c             	mov    0xc(%eax),%eax
80105883:	83 f8 05             	cmp    $0x5,%eax
80105886:	77 23                	ja     801058ab <procdump+0x5b>
80105888:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010588b:	8b 40 0c             	mov    0xc(%eax),%eax
8010588e:	8b 04 85 08 c0 10 80 	mov    -0x7fef3ff8(,%eax,4),%eax
80105895:	85 c0                	test   %eax,%eax
80105897:	74 12                	je     801058ab <procdump+0x5b>
      state = states[p->state];
80105899:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010589c:	8b 40 0c             	mov    0xc(%eax),%eax
8010589f:	8b 04 85 08 c0 10 80 	mov    -0x7fef3ff8(,%eax,4),%eax
801058a6:	89 45 ec             	mov    %eax,-0x14(%ebp)
801058a9:	eb 07                	jmp    801058b2 <procdump+0x62>
    else
      state = "???";
801058ab:	c7 45 ec 7c 97 10 80 	movl   $0x8010977c,-0x14(%ebp)
    cprintf("id:%d status:%s name:%s\n", p->pid, state, p->name);
801058b2:	8b 45 f0             	mov    -0x10(%ebp),%eax
801058b5:	8d 50 6c             	lea    0x6c(%eax),%edx
801058b8:	8b 45 f0             	mov    -0x10(%ebp),%eax
801058bb:	8b 40 10             	mov    0x10(%eax),%eax
801058be:	89 54 24 0c          	mov    %edx,0xc(%esp)
801058c2:	8b 55 ec             	mov    -0x14(%ebp),%edx
801058c5:	89 54 24 08          	mov    %edx,0x8(%esp)
801058c9:	89 44 24 04          	mov    %eax,0x4(%esp)
801058cd:	c7 04 24 80 97 10 80 	movl   $0x80109780,(%esp)
801058d4:	e8 c8 aa ff ff       	call   801003a1 <cprintf>
    cprintf("ctime:%d rtime:%d iotime:%d etime:%d\n", p->ctime, p->rtime, p->iotime,p->etime);
801058d9:	8b 45 f0             	mov    -0x10(%ebp),%eax
801058dc:	8b 98 88 00 00 00    	mov    0x88(%eax),%ebx
801058e2:	8b 45 f0             	mov    -0x10(%ebp),%eax
801058e5:	8b 88 8c 00 00 00    	mov    0x8c(%eax),%ecx
801058eb:	8b 45 f0             	mov    -0x10(%ebp),%eax
801058ee:	8b 90 90 00 00 00    	mov    0x90(%eax),%edx
801058f4:	8b 45 f0             	mov    -0x10(%ebp),%eax
801058f7:	8b 80 84 00 00 00    	mov    0x84(%eax),%eax
801058fd:	89 5c 24 10          	mov    %ebx,0x10(%esp)
80105901:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
80105905:	89 54 24 08          	mov    %edx,0x8(%esp)
80105909:	89 44 24 04          	mov    %eax,0x4(%esp)
8010590d:	c7 04 24 9c 97 10 80 	movl   $0x8010979c,(%esp)
80105914:	e8 88 aa ff ff       	call   801003a1 <cprintf>
        cprintf("quanta is:%d queue is:%d\n", p->quanta,p->queue);
80105919:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010591c:	8b 50 7c             	mov    0x7c(%eax),%edx
8010591f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105922:	8b 80 94 00 00 00    	mov    0x94(%eax),%eax
80105928:	89 54 24 08          	mov    %edx,0x8(%esp)
8010592c:	89 44 24 04          	mov    %eax,0x4(%esp)
80105930:	c7 04 24 c2 97 10 80 	movl   $0x801097c2,(%esp)
80105937:	e8 65 aa ff ff       	call   801003a1 <cprintf>
    if(p->state == SLEEPING){
8010593c:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010593f:	8b 40 0c             	mov    0xc(%eax),%eax
80105942:	83 f8 02             	cmp    $0x2,%eax
80105945:	75 50                	jne    80105997 <procdump+0x147>
      getcallerpcs((uint*)p->context->ebp+2, pc);
80105947:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010594a:	8b 40 1c             	mov    0x1c(%eax),%eax
8010594d:	8b 40 0c             	mov    0xc(%eax),%eax
80105950:	83 c0 08             	add    $0x8,%eax
80105953:	8d 55 c4             	lea    -0x3c(%ebp),%edx
80105956:	89 54 24 04          	mov    %edx,0x4(%esp)
8010595a:	89 04 24             	mov    %eax,(%esp)
8010595d:	e8 06 02 00 00       	call   80105b68 <getcallerpcs>
      for(i=0; i<10 && pc[i] != 0; i++)
80105962:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80105969:	eb 1b                	jmp    80105986 <procdump+0x136>
        cprintf("%p  ", pc[i]);
8010596b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010596e:	8b 44 85 c4          	mov    -0x3c(%ebp,%eax,4),%eax
80105972:	89 44 24 04          	mov    %eax,0x4(%esp)
80105976:	c7 04 24 dc 97 10 80 	movl   $0x801097dc,(%esp)
8010597d:	e8 1f aa ff ff       	call   801003a1 <cprintf>
    cprintf("id:%d status:%s name:%s\n", p->pid, state, p->name);
    cprintf("ctime:%d rtime:%d iotime:%d etime:%d\n", p->ctime, p->rtime, p->iotime,p->etime);
        cprintf("quanta is:%d queue is:%d\n", p->quanta,p->queue);
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
80105982:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80105986:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
8010598a:	7f 0b                	jg     80105997 <procdump+0x147>
8010598c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010598f:	8b 44 85 c4          	mov    -0x3c(%ebp,%eax,4),%eax
80105993:	85 c0                	test   %eax,%eax
80105995:	75 d4                	jne    8010596b <procdump+0x11b>
        cprintf("%p  ", pc[i]);
    }
    cprintf("\n");
80105997:	c7 04 24 e1 97 10 80 	movl   $0x801097e1,(%esp)
8010599e:	e8 fe a9 ff ff       	call   801003a1 <cprintf>
801059a3:	eb 01                	jmp    801059a6 <procdump+0x156>
  char *state;
  uint pc[10];
  cprintf("Process List:\n");
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->state == UNUSED)
      continue;
801059a5:	90                   	nop
  int i;
  struct proc *p;
  char *state;
  uint pc[10];
  cprintf("Process List:\n");
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801059a6:	81 45 f0 20 01 00 00 	addl   $0x120,-0x10(%ebp)
801059ad:	81 7d f0 14 6a 11 80 	cmpl   $0x80116a14,-0x10(%ebp)
801059b4:	0f 82 b5 fe ff ff    	jb     8010586f <procdump+0x1f>
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf("%p  ", pc[i]);
    }
    cprintf("\n");
  }
  cprintf("SCHEFLAG is : %d",SCHEDFLAG);
801059ba:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
801059c1:	00 
801059c2:	c7 04 24 e3 97 10 80 	movl   $0x801097e3,(%esp)
801059c9:	e8 d3 a9 ff ff       	call   801003a1 <cprintf>
  for (i=0;i<NUMBER_OF_QUEUES*NPROC;i++){
801059ce:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801059d5:	eb 5b                	jmp    80105a32 <procdump+0x1e2>
    if (i%NPROC==0)
801059d7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801059da:	83 e0 3f             	and    $0x3f,%eax
801059dd:	85 c0                	test   %eax,%eax
801059df:	75 1e                	jne    801059ff <procdump+0x1af>
    {
      cprintf("\n* Queue %d *",i/NPROC);  
801059e1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801059e4:	8d 50 3f             	lea    0x3f(%eax),%edx
801059e7:	85 c0                	test   %eax,%eax
801059e9:	0f 48 c2             	cmovs  %edx,%eax
801059ec:	c1 f8 06             	sar    $0x6,%eax
801059ef:	89 44 24 04          	mov    %eax,0x4(%esp)
801059f3:	c7 04 24 f4 97 10 80 	movl   $0x801097f4,(%esp)
801059fa:	e8 a2 a9 ff ff       	call   801003a1 <cprintf>
    }
    if(queues.list[i]!=-1)
801059ff:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105a02:	83 c0 0c             	add    $0xc,%eax
80105a05:	8b 04 85 84 1e 11 80 	mov    -0x7feee17c(,%eax,4),%eax
80105a0c:	83 f8 ff             	cmp    $0xffffffff,%eax
80105a0f:	74 1d                	je     80105a2e <procdump+0x1de>
      cprintf(" %d",queues.list[i]);
80105a11:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105a14:	83 c0 0c             	add    $0xc,%eax
80105a17:	8b 04 85 84 1e 11 80 	mov    -0x7feee17c(,%eax,4),%eax
80105a1e:	89 44 24 04          	mov    %eax,0x4(%esp)
80105a22:	c7 04 24 02 98 10 80 	movl   $0x80109802,(%esp)
80105a29:	e8 73 a9 ff ff       	call   801003a1 <cprintf>
        cprintf("%p  ", pc[i]);
    }
    cprintf("\n");
  }
  cprintf("SCHEFLAG is : %d",SCHEDFLAG);
  for (i=0;i<NUMBER_OF_QUEUES*NPROC;i++){
80105a2e:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80105a32:	81 7d f4 bf 00 00 00 	cmpl   $0xbf,-0xc(%ebp)
80105a39:	7e 9c                	jle    801059d7 <procdump+0x187>
      cprintf("\n* Queue %d *",i/NPROC);  
    }
    if(queues.list[i]!=-1)
      cprintf(" %d",queues.list[i]);
  }
  cprintf("\n");
80105a3b:	c7 04 24 e1 97 10 80 	movl   $0x801097e1,(%esp)
80105a42:	e8 5a a9 ff ff       	call   801003a1 <cprintf>
  
}
80105a47:	83 c4 64             	add    $0x64,%esp
80105a4a:	5b                   	pop    %ebx
80105a4b:	5d                   	pop    %ebp
80105a4c:	c3                   	ret    
80105a4d:	00 00                	add    %al,(%eax)
	...

80105a50 <readeflags>:
  asm volatile("ltr %0" : : "r" (sel));
}

static inline uint
readeflags(void)
{
80105a50:	55                   	push   %ebp
80105a51:	89 e5                	mov    %esp,%ebp
80105a53:	53                   	push   %ebx
80105a54:	83 ec 10             	sub    $0x10,%esp
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80105a57:	9c                   	pushf  
80105a58:	5b                   	pop    %ebx
80105a59:	89 5d f8             	mov    %ebx,-0x8(%ebp)
  return eflags;
80105a5c:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
80105a5f:	83 c4 10             	add    $0x10,%esp
80105a62:	5b                   	pop    %ebx
80105a63:	5d                   	pop    %ebp
80105a64:	c3                   	ret    

80105a65 <cli>:
  asm volatile("movw %0, %%gs" : : "r" (v));
}

static inline void
cli(void)
{
80105a65:	55                   	push   %ebp
80105a66:	89 e5                	mov    %esp,%ebp
  asm volatile("cli");
80105a68:	fa                   	cli    
}
80105a69:	5d                   	pop    %ebp
80105a6a:	c3                   	ret    

80105a6b <sti>:

static inline void
sti(void)
{
80105a6b:	55                   	push   %ebp
80105a6c:	89 e5                	mov    %esp,%ebp
  asm volatile("sti");
80105a6e:	fb                   	sti    
}
80105a6f:	5d                   	pop    %ebp
80105a70:	c3                   	ret    

80105a71 <xchg>:

static inline uint
xchg(volatile uint *addr, uint newval)
{
80105a71:	55                   	push   %ebp
80105a72:	89 e5                	mov    %esp,%ebp
80105a74:	53                   	push   %ebx
80105a75:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
               "+m" (*addr), "=a" (result) :
80105a78:	8b 55 08             	mov    0x8(%ebp),%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80105a7b:	8b 45 0c             	mov    0xc(%ebp),%eax
               "+m" (*addr), "=a" (result) :
80105a7e:	8b 4d 08             	mov    0x8(%ebp),%ecx
xchg(volatile uint *addr, uint newval)
{
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80105a81:	89 c3                	mov    %eax,%ebx
80105a83:	89 d8                	mov    %ebx,%eax
80105a85:	f0 87 02             	lock xchg %eax,(%edx)
80105a88:	89 c3                	mov    %eax,%ebx
80105a8a:	89 5d f8             	mov    %ebx,-0x8(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
80105a8d:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
80105a90:	83 c4 10             	add    $0x10,%esp
80105a93:	5b                   	pop    %ebx
80105a94:	5d                   	pop    %ebp
80105a95:	c3                   	ret    

80105a96 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80105a96:	55                   	push   %ebp
80105a97:	89 e5                	mov    %esp,%ebp
  lk->name = name;
80105a99:	8b 45 08             	mov    0x8(%ebp),%eax
80105a9c:	8b 55 0c             	mov    0xc(%ebp),%edx
80105a9f:	89 50 04             	mov    %edx,0x4(%eax)
  lk->locked = 0;
80105aa2:	8b 45 08             	mov    0x8(%ebp),%eax
80105aa5:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->cpu = 0;
80105aab:	8b 45 08             	mov    0x8(%ebp),%eax
80105aae:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80105ab5:	5d                   	pop    %ebp
80105ab6:	c3                   	ret    

80105ab7 <acquire>:
// Loops (spins) until the lock is acquired.
// Holding a lock for a long time may cause
// other CPUs to waste time spinning to acquire it.
void
acquire(struct spinlock *lk)
{
80105ab7:	55                   	push   %ebp
80105ab8:	89 e5                	mov    %esp,%ebp
80105aba:	83 ec 18             	sub    $0x18,%esp
  pushcli(); // disable interrupts to avoid deadlock.
80105abd:	e8 3d 01 00 00       	call   80105bff <pushcli>
  if(holding(lk))
80105ac2:	8b 45 08             	mov    0x8(%ebp),%eax
80105ac5:	89 04 24             	mov    %eax,(%esp)
80105ac8:	e8 08 01 00 00       	call   80105bd5 <holding>
80105acd:	85 c0                	test   %eax,%eax
80105acf:	74 0c                	je     80105add <acquire+0x26>
    panic("acquire");
80105ad1:	c7 04 24 30 98 10 80 	movl   $0x80109830,(%esp)
80105ad8:	e8 60 aa ff ff       	call   8010053d <panic>

  // The xchg is atomic.
  // It also serializes, so that reads after acquire are not
  // reordered before it. 
  while(xchg(&lk->locked, 1) != 0)
80105add:	90                   	nop
80105ade:	8b 45 08             	mov    0x8(%ebp),%eax
80105ae1:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
80105ae8:	00 
80105ae9:	89 04 24             	mov    %eax,(%esp)
80105aec:	e8 80 ff ff ff       	call   80105a71 <xchg>
80105af1:	85 c0                	test   %eax,%eax
80105af3:	75 e9                	jne    80105ade <acquire+0x27>
    ;

  // Record info about lock acquisition for debugging.
  lk->cpu = cpu;
80105af5:	8b 45 08             	mov    0x8(%ebp),%eax
80105af8:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80105aff:	89 50 08             	mov    %edx,0x8(%eax)
  getcallerpcs(&lk, lk->pcs);
80105b02:	8b 45 08             	mov    0x8(%ebp),%eax
80105b05:	83 c0 0c             	add    $0xc,%eax
80105b08:	89 44 24 04          	mov    %eax,0x4(%esp)
80105b0c:	8d 45 08             	lea    0x8(%ebp),%eax
80105b0f:	89 04 24             	mov    %eax,(%esp)
80105b12:	e8 51 00 00 00       	call   80105b68 <getcallerpcs>
}
80105b17:	c9                   	leave  
80105b18:	c3                   	ret    

80105b19 <release>:

// Release the lock.
void
release(struct spinlock *lk)
{
80105b19:	55                   	push   %ebp
80105b1a:	89 e5                	mov    %esp,%ebp
80105b1c:	83 ec 18             	sub    $0x18,%esp
  if(!holding(lk))
80105b1f:	8b 45 08             	mov    0x8(%ebp),%eax
80105b22:	89 04 24             	mov    %eax,(%esp)
80105b25:	e8 ab 00 00 00       	call   80105bd5 <holding>
80105b2a:	85 c0                	test   %eax,%eax
80105b2c:	75 0c                	jne    80105b3a <release+0x21>
    panic("release");
80105b2e:	c7 04 24 38 98 10 80 	movl   $0x80109838,(%esp)
80105b35:	e8 03 aa ff ff       	call   8010053d <panic>

  lk->pcs[0] = 0;
80105b3a:	8b 45 08             	mov    0x8(%ebp),%eax
80105b3d:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
  lk->cpu = 0;
80105b44:	8b 45 08             	mov    0x8(%ebp),%eax
80105b47:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
  // But the 2007 Intel 64 Architecture Memory Ordering White
  // Paper says that Intel 64 and IA-32 will not move a load
  // after a store. So lock->locked = 0 would work here.
  // The xchg being asm volatile ensures gcc emits it after
  // the above assignments (and after the critical section).
  xchg(&lk->locked, 0);
80105b4e:	8b 45 08             	mov    0x8(%ebp),%eax
80105b51:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80105b58:	00 
80105b59:	89 04 24             	mov    %eax,(%esp)
80105b5c:	e8 10 ff ff ff       	call   80105a71 <xchg>

  popcli();
80105b61:	e8 e1 00 00 00       	call   80105c47 <popcli>
}
80105b66:	c9                   	leave  
80105b67:	c3                   	ret    

80105b68 <getcallerpcs>:

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80105b68:	55                   	push   %ebp
80105b69:	89 e5                	mov    %esp,%ebp
80105b6b:	83 ec 10             	sub    $0x10,%esp
  uint *ebp;
  int i;
  
  ebp = (uint*)v - 2;
80105b6e:	8b 45 08             	mov    0x8(%ebp),%eax
80105b71:	83 e8 08             	sub    $0x8,%eax
80105b74:	89 45 fc             	mov    %eax,-0x4(%ebp)
  for(i = 0; i < 10; i++){
80105b77:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
80105b7e:	eb 32                	jmp    80105bb2 <getcallerpcs+0x4a>
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80105b80:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
80105b84:	74 47                	je     80105bcd <getcallerpcs+0x65>
80105b86:	81 7d fc ff ff ff 7f 	cmpl   $0x7fffffff,-0x4(%ebp)
80105b8d:	76 3e                	jbe    80105bcd <getcallerpcs+0x65>
80105b8f:	83 7d fc ff          	cmpl   $0xffffffff,-0x4(%ebp)
80105b93:	74 38                	je     80105bcd <getcallerpcs+0x65>
      break;
    pcs[i] = ebp[1];     // saved %eip
80105b95:	8b 45 f8             	mov    -0x8(%ebp),%eax
80105b98:	c1 e0 02             	shl    $0x2,%eax
80105b9b:	03 45 0c             	add    0xc(%ebp),%eax
80105b9e:	8b 55 fc             	mov    -0x4(%ebp),%edx
80105ba1:	8b 52 04             	mov    0x4(%edx),%edx
80105ba4:	89 10                	mov    %edx,(%eax)
    ebp = (uint*)ebp[0]; // saved %ebp
80105ba6:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105ba9:	8b 00                	mov    (%eax),%eax
80105bab:	89 45 fc             	mov    %eax,-0x4(%ebp)
{
  uint *ebp;
  int i;
  
  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80105bae:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
80105bb2:	83 7d f8 09          	cmpl   $0x9,-0x8(%ebp)
80105bb6:	7e c8                	jle    80105b80 <getcallerpcs+0x18>
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
80105bb8:	eb 13                	jmp    80105bcd <getcallerpcs+0x65>
    pcs[i] = 0;
80105bba:	8b 45 f8             	mov    -0x8(%ebp),%eax
80105bbd:	c1 e0 02             	shl    $0x2,%eax
80105bc0:	03 45 0c             	add    0xc(%ebp),%eax
80105bc3:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
80105bc9:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
80105bcd:	83 7d f8 09          	cmpl   $0x9,-0x8(%ebp)
80105bd1:	7e e7                	jle    80105bba <getcallerpcs+0x52>
    pcs[i] = 0;
}
80105bd3:	c9                   	leave  
80105bd4:	c3                   	ret    

80105bd5 <holding>:

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
80105bd5:	55                   	push   %ebp
80105bd6:	89 e5                	mov    %esp,%ebp
  return lock->locked && lock->cpu == cpu;
80105bd8:	8b 45 08             	mov    0x8(%ebp),%eax
80105bdb:	8b 00                	mov    (%eax),%eax
80105bdd:	85 c0                	test   %eax,%eax
80105bdf:	74 17                	je     80105bf8 <holding+0x23>
80105be1:	8b 45 08             	mov    0x8(%ebp),%eax
80105be4:	8b 50 08             	mov    0x8(%eax),%edx
80105be7:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80105bed:	39 c2                	cmp    %eax,%edx
80105bef:	75 07                	jne    80105bf8 <holding+0x23>
80105bf1:	b8 01 00 00 00       	mov    $0x1,%eax
80105bf6:	eb 05                	jmp    80105bfd <holding+0x28>
80105bf8:	b8 00 00 00 00       	mov    $0x0,%eax
}
80105bfd:	5d                   	pop    %ebp
80105bfe:	c3                   	ret    

80105bff <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80105bff:	55                   	push   %ebp
80105c00:	89 e5                	mov    %esp,%ebp
80105c02:	83 ec 10             	sub    $0x10,%esp
  int eflags;
  
  eflags = readeflags();
80105c05:	e8 46 fe ff ff       	call   80105a50 <readeflags>
80105c0a:	89 45 fc             	mov    %eax,-0x4(%ebp)
  cli();
80105c0d:	e8 53 fe ff ff       	call   80105a65 <cli>
  if(cpu->ncli++ == 0)
80105c12:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80105c18:	8b 90 ac 00 00 00    	mov    0xac(%eax),%edx
80105c1e:	85 d2                	test   %edx,%edx
80105c20:	0f 94 c1             	sete   %cl
80105c23:	83 c2 01             	add    $0x1,%edx
80105c26:	89 90 ac 00 00 00    	mov    %edx,0xac(%eax)
80105c2c:	84 c9                	test   %cl,%cl
80105c2e:	74 15                	je     80105c45 <pushcli+0x46>
    cpu->intena = eflags & FL_IF;
80105c30:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80105c36:	8b 55 fc             	mov    -0x4(%ebp),%edx
80105c39:	81 e2 00 02 00 00    	and    $0x200,%edx
80105c3f:	89 90 b0 00 00 00    	mov    %edx,0xb0(%eax)
}
80105c45:	c9                   	leave  
80105c46:	c3                   	ret    

80105c47 <popcli>:

void
popcli(void)
{
80105c47:	55                   	push   %ebp
80105c48:	89 e5                	mov    %esp,%ebp
80105c4a:	83 ec 18             	sub    $0x18,%esp
  if(readeflags()&FL_IF)
80105c4d:	e8 fe fd ff ff       	call   80105a50 <readeflags>
80105c52:	25 00 02 00 00       	and    $0x200,%eax
80105c57:	85 c0                	test   %eax,%eax
80105c59:	74 0c                	je     80105c67 <popcli+0x20>
    panic("popcli - interruptible");
80105c5b:	c7 04 24 40 98 10 80 	movl   $0x80109840,(%esp)
80105c62:	e8 d6 a8 ff ff       	call   8010053d <panic>
  if(--cpu->ncli < 0)
80105c67:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80105c6d:	8b 90 ac 00 00 00    	mov    0xac(%eax),%edx
80105c73:	83 ea 01             	sub    $0x1,%edx
80105c76:	89 90 ac 00 00 00    	mov    %edx,0xac(%eax)
80105c7c:	8b 80 ac 00 00 00    	mov    0xac(%eax),%eax
80105c82:	85 c0                	test   %eax,%eax
80105c84:	79 0c                	jns    80105c92 <popcli+0x4b>
    panic("popcli");
80105c86:	c7 04 24 57 98 10 80 	movl   $0x80109857,(%esp)
80105c8d:	e8 ab a8 ff ff       	call   8010053d <panic>
  if(cpu->ncli == 0 && cpu->intena)
80105c92:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80105c98:	8b 80 ac 00 00 00    	mov    0xac(%eax),%eax
80105c9e:	85 c0                	test   %eax,%eax
80105ca0:	75 15                	jne    80105cb7 <popcli+0x70>
80105ca2:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80105ca8:	8b 80 b0 00 00 00    	mov    0xb0(%eax),%eax
80105cae:	85 c0                	test   %eax,%eax
80105cb0:	74 05                	je     80105cb7 <popcli+0x70>
    sti();
80105cb2:	e8 b4 fd ff ff       	call   80105a6b <sti>
}
80105cb7:	c9                   	leave  
80105cb8:	c3                   	ret    
80105cb9:	00 00                	add    %al,(%eax)
	...

80105cbc <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
80105cbc:	55                   	push   %ebp
80105cbd:	89 e5                	mov    %esp,%ebp
80105cbf:	57                   	push   %edi
80105cc0:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
80105cc1:	8b 4d 08             	mov    0x8(%ebp),%ecx
80105cc4:	8b 55 10             	mov    0x10(%ebp),%edx
80105cc7:	8b 45 0c             	mov    0xc(%ebp),%eax
80105cca:	89 cb                	mov    %ecx,%ebx
80105ccc:	89 df                	mov    %ebx,%edi
80105cce:	89 d1                	mov    %edx,%ecx
80105cd0:	fc                   	cld    
80105cd1:	f3 aa                	rep stos %al,%es:(%edi)
80105cd3:	89 ca                	mov    %ecx,%edx
80105cd5:	89 fb                	mov    %edi,%ebx
80105cd7:	89 5d 08             	mov    %ebx,0x8(%ebp)
80105cda:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
80105cdd:	5b                   	pop    %ebx
80105cde:	5f                   	pop    %edi
80105cdf:	5d                   	pop    %ebp
80105ce0:	c3                   	ret    

80105ce1 <stosl>:

static inline void
stosl(void *addr, int data, int cnt)
{
80105ce1:	55                   	push   %ebp
80105ce2:	89 e5                	mov    %esp,%ebp
80105ce4:	57                   	push   %edi
80105ce5:	53                   	push   %ebx
  asm volatile("cld; rep stosl" :
80105ce6:	8b 4d 08             	mov    0x8(%ebp),%ecx
80105ce9:	8b 55 10             	mov    0x10(%ebp),%edx
80105cec:	8b 45 0c             	mov    0xc(%ebp),%eax
80105cef:	89 cb                	mov    %ecx,%ebx
80105cf1:	89 df                	mov    %ebx,%edi
80105cf3:	89 d1                	mov    %edx,%ecx
80105cf5:	fc                   	cld    
80105cf6:	f3 ab                	rep stos %eax,%es:(%edi)
80105cf8:	89 ca                	mov    %ecx,%edx
80105cfa:	89 fb                	mov    %edi,%ebx
80105cfc:	89 5d 08             	mov    %ebx,0x8(%ebp)
80105cff:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
80105d02:	5b                   	pop    %ebx
80105d03:	5f                   	pop    %edi
80105d04:	5d                   	pop    %ebp
80105d05:	c3                   	ret    

80105d06 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80105d06:	55                   	push   %ebp
80105d07:	89 e5                	mov    %esp,%ebp
80105d09:	83 ec 0c             	sub    $0xc,%esp
  if ((int)dst%4 == 0 && n%4 == 0){
80105d0c:	8b 45 08             	mov    0x8(%ebp),%eax
80105d0f:	83 e0 03             	and    $0x3,%eax
80105d12:	85 c0                	test   %eax,%eax
80105d14:	75 49                	jne    80105d5f <memset+0x59>
80105d16:	8b 45 10             	mov    0x10(%ebp),%eax
80105d19:	83 e0 03             	and    $0x3,%eax
80105d1c:	85 c0                	test   %eax,%eax
80105d1e:	75 3f                	jne    80105d5f <memset+0x59>
    c &= 0xFF;
80105d20:	81 65 0c ff 00 00 00 	andl   $0xff,0xc(%ebp)
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
80105d27:	8b 45 10             	mov    0x10(%ebp),%eax
80105d2a:	c1 e8 02             	shr    $0x2,%eax
80105d2d:	89 c2                	mov    %eax,%edx
80105d2f:	8b 45 0c             	mov    0xc(%ebp),%eax
80105d32:	89 c1                	mov    %eax,%ecx
80105d34:	c1 e1 18             	shl    $0x18,%ecx
80105d37:	8b 45 0c             	mov    0xc(%ebp),%eax
80105d3a:	c1 e0 10             	shl    $0x10,%eax
80105d3d:	09 c1                	or     %eax,%ecx
80105d3f:	8b 45 0c             	mov    0xc(%ebp),%eax
80105d42:	c1 e0 08             	shl    $0x8,%eax
80105d45:	09 c8                	or     %ecx,%eax
80105d47:	0b 45 0c             	or     0xc(%ebp),%eax
80105d4a:	89 54 24 08          	mov    %edx,0x8(%esp)
80105d4e:	89 44 24 04          	mov    %eax,0x4(%esp)
80105d52:	8b 45 08             	mov    0x8(%ebp),%eax
80105d55:	89 04 24             	mov    %eax,(%esp)
80105d58:	e8 84 ff ff ff       	call   80105ce1 <stosl>
80105d5d:	eb 19                	jmp    80105d78 <memset+0x72>
  } else
    stosb(dst, c, n);
80105d5f:	8b 45 10             	mov    0x10(%ebp),%eax
80105d62:	89 44 24 08          	mov    %eax,0x8(%esp)
80105d66:	8b 45 0c             	mov    0xc(%ebp),%eax
80105d69:	89 44 24 04          	mov    %eax,0x4(%esp)
80105d6d:	8b 45 08             	mov    0x8(%ebp),%eax
80105d70:	89 04 24             	mov    %eax,(%esp)
80105d73:	e8 44 ff ff ff       	call   80105cbc <stosb>
  return dst;
80105d78:	8b 45 08             	mov    0x8(%ebp),%eax
}
80105d7b:	c9                   	leave  
80105d7c:	c3                   	ret    

80105d7d <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
80105d7d:	55                   	push   %ebp
80105d7e:	89 e5                	mov    %esp,%ebp
80105d80:	83 ec 10             	sub    $0x10,%esp
  const uchar *s1, *s2;
  
  s1 = v1;
80105d83:	8b 45 08             	mov    0x8(%ebp),%eax
80105d86:	89 45 fc             	mov    %eax,-0x4(%ebp)
  s2 = v2;
80105d89:	8b 45 0c             	mov    0xc(%ebp),%eax
80105d8c:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0){
80105d8f:	eb 32                	jmp    80105dc3 <memcmp+0x46>
    if(*s1 != *s2)
80105d91:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105d94:	0f b6 10             	movzbl (%eax),%edx
80105d97:	8b 45 f8             	mov    -0x8(%ebp),%eax
80105d9a:	0f b6 00             	movzbl (%eax),%eax
80105d9d:	38 c2                	cmp    %al,%dl
80105d9f:	74 1a                	je     80105dbb <memcmp+0x3e>
      return *s1 - *s2;
80105da1:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105da4:	0f b6 00             	movzbl (%eax),%eax
80105da7:	0f b6 d0             	movzbl %al,%edx
80105daa:	8b 45 f8             	mov    -0x8(%ebp),%eax
80105dad:	0f b6 00             	movzbl (%eax),%eax
80105db0:	0f b6 c0             	movzbl %al,%eax
80105db3:	89 d1                	mov    %edx,%ecx
80105db5:	29 c1                	sub    %eax,%ecx
80105db7:	89 c8                	mov    %ecx,%eax
80105db9:	eb 1c                	jmp    80105dd7 <memcmp+0x5a>
    s1++, s2++;
80105dbb:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
80105dbf:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
{
  const uchar *s1, *s2;
  
  s1 = v1;
  s2 = v2;
  while(n-- > 0){
80105dc3:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80105dc7:	0f 95 c0             	setne  %al
80105dca:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
80105dce:	84 c0                	test   %al,%al
80105dd0:	75 bf                	jne    80105d91 <memcmp+0x14>
    if(*s1 != *s2)
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
80105dd2:	b8 00 00 00 00       	mov    $0x0,%eax
}
80105dd7:	c9                   	leave  
80105dd8:	c3                   	ret    

80105dd9 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80105dd9:	55                   	push   %ebp
80105dda:	89 e5                	mov    %esp,%ebp
80105ddc:	83 ec 10             	sub    $0x10,%esp
  const char *s;
  char *d;

  s = src;
80105ddf:	8b 45 0c             	mov    0xc(%ebp),%eax
80105de2:	89 45 fc             	mov    %eax,-0x4(%ebp)
  d = dst;
80105de5:	8b 45 08             	mov    0x8(%ebp),%eax
80105de8:	89 45 f8             	mov    %eax,-0x8(%ebp)
  if(s < d && s + n > d){
80105deb:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105dee:	3b 45 f8             	cmp    -0x8(%ebp),%eax
80105df1:	73 54                	jae    80105e47 <memmove+0x6e>
80105df3:	8b 45 10             	mov    0x10(%ebp),%eax
80105df6:	8b 55 fc             	mov    -0x4(%ebp),%edx
80105df9:	01 d0                	add    %edx,%eax
80105dfb:	3b 45 f8             	cmp    -0x8(%ebp),%eax
80105dfe:	76 47                	jbe    80105e47 <memmove+0x6e>
    s += n;
80105e00:	8b 45 10             	mov    0x10(%ebp),%eax
80105e03:	01 45 fc             	add    %eax,-0x4(%ebp)
    d += n;
80105e06:	8b 45 10             	mov    0x10(%ebp),%eax
80105e09:	01 45 f8             	add    %eax,-0x8(%ebp)
    while(n-- > 0)
80105e0c:	eb 13                	jmp    80105e21 <memmove+0x48>
      *--d = *--s;
80105e0e:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
80105e12:	83 6d fc 01          	subl   $0x1,-0x4(%ebp)
80105e16:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105e19:	0f b6 10             	movzbl (%eax),%edx
80105e1c:	8b 45 f8             	mov    -0x8(%ebp),%eax
80105e1f:	88 10                	mov    %dl,(%eax)
  s = src;
  d = dst;
  if(s < d && s + n > d){
    s += n;
    d += n;
    while(n-- > 0)
80105e21:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80105e25:	0f 95 c0             	setne  %al
80105e28:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
80105e2c:	84 c0                	test   %al,%al
80105e2e:	75 de                	jne    80105e0e <memmove+0x35>
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
80105e30:	eb 25                	jmp    80105e57 <memmove+0x7e>
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
      *d++ = *s++;
80105e32:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105e35:	0f b6 10             	movzbl (%eax),%edx
80105e38:	8b 45 f8             	mov    -0x8(%ebp),%eax
80105e3b:	88 10                	mov    %dl,(%eax)
80105e3d:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
80105e41:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
80105e45:	eb 01                	jmp    80105e48 <memmove+0x6f>
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
80105e47:	90                   	nop
80105e48:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80105e4c:	0f 95 c0             	setne  %al
80105e4f:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
80105e53:	84 c0                	test   %al,%al
80105e55:	75 db                	jne    80105e32 <memmove+0x59>
      *d++ = *s++;

  return dst;
80105e57:	8b 45 08             	mov    0x8(%ebp),%eax
}
80105e5a:	c9                   	leave  
80105e5b:	c3                   	ret    

80105e5c <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
80105e5c:	55                   	push   %ebp
80105e5d:	89 e5                	mov    %esp,%ebp
80105e5f:	83 ec 0c             	sub    $0xc,%esp
  return memmove(dst, src, n);
80105e62:	8b 45 10             	mov    0x10(%ebp),%eax
80105e65:	89 44 24 08          	mov    %eax,0x8(%esp)
80105e69:	8b 45 0c             	mov    0xc(%ebp),%eax
80105e6c:	89 44 24 04          	mov    %eax,0x4(%esp)
80105e70:	8b 45 08             	mov    0x8(%ebp),%eax
80105e73:	89 04 24             	mov    %eax,(%esp)
80105e76:	e8 5e ff ff ff       	call   80105dd9 <memmove>
}
80105e7b:	c9                   	leave  
80105e7c:	c3                   	ret    

80105e7d <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
80105e7d:	55                   	push   %ebp
80105e7e:	89 e5                	mov    %esp,%ebp
  while(n > 0 && *p && *p == *q)
80105e80:	eb 0c                	jmp    80105e8e <strncmp+0x11>
    n--, p++, q++;
80105e82:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
80105e86:	83 45 08 01          	addl   $0x1,0x8(%ebp)
80105e8a:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint n)
{
  while(n > 0 && *p && *p == *q)
80105e8e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80105e92:	74 1a                	je     80105eae <strncmp+0x31>
80105e94:	8b 45 08             	mov    0x8(%ebp),%eax
80105e97:	0f b6 00             	movzbl (%eax),%eax
80105e9a:	84 c0                	test   %al,%al
80105e9c:	74 10                	je     80105eae <strncmp+0x31>
80105e9e:	8b 45 08             	mov    0x8(%ebp),%eax
80105ea1:	0f b6 10             	movzbl (%eax),%edx
80105ea4:	8b 45 0c             	mov    0xc(%ebp),%eax
80105ea7:	0f b6 00             	movzbl (%eax),%eax
80105eaa:	38 c2                	cmp    %al,%dl
80105eac:	74 d4                	je     80105e82 <strncmp+0x5>
    n--, p++, q++;
  if(n == 0)
80105eae:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80105eb2:	75 07                	jne    80105ebb <strncmp+0x3e>
    return 0;
80105eb4:	b8 00 00 00 00       	mov    $0x0,%eax
80105eb9:	eb 18                	jmp    80105ed3 <strncmp+0x56>
  return (uchar)*p - (uchar)*q;
80105ebb:	8b 45 08             	mov    0x8(%ebp),%eax
80105ebe:	0f b6 00             	movzbl (%eax),%eax
80105ec1:	0f b6 d0             	movzbl %al,%edx
80105ec4:	8b 45 0c             	mov    0xc(%ebp),%eax
80105ec7:	0f b6 00             	movzbl (%eax),%eax
80105eca:	0f b6 c0             	movzbl %al,%eax
80105ecd:	89 d1                	mov    %edx,%ecx
80105ecf:	29 c1                	sub    %eax,%ecx
80105ed1:	89 c8                	mov    %ecx,%eax
}
80105ed3:	5d                   	pop    %ebp
80105ed4:	c3                   	ret    

80105ed5 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
80105ed5:	55                   	push   %ebp
80105ed6:	89 e5                	mov    %esp,%ebp
80105ed8:	83 ec 10             	sub    $0x10,%esp
  char *os;
  
  os = s;
80105edb:	8b 45 08             	mov    0x8(%ebp),%eax
80105ede:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while(n-- > 0 && (*s++ = *t++) != 0)
80105ee1:	90                   	nop
80105ee2:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80105ee6:	0f 9f c0             	setg   %al
80105ee9:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
80105eed:	84 c0                	test   %al,%al
80105eef:	74 30                	je     80105f21 <strncpy+0x4c>
80105ef1:	8b 45 0c             	mov    0xc(%ebp),%eax
80105ef4:	0f b6 10             	movzbl (%eax),%edx
80105ef7:	8b 45 08             	mov    0x8(%ebp),%eax
80105efa:	88 10                	mov    %dl,(%eax)
80105efc:	8b 45 08             	mov    0x8(%ebp),%eax
80105eff:	0f b6 00             	movzbl (%eax),%eax
80105f02:	84 c0                	test   %al,%al
80105f04:	0f 95 c0             	setne  %al
80105f07:	83 45 08 01          	addl   $0x1,0x8(%ebp)
80105f0b:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
80105f0f:	84 c0                	test   %al,%al
80105f11:	75 cf                	jne    80105ee2 <strncpy+0xd>
    ;
  while(n-- > 0)
80105f13:	eb 0c                	jmp    80105f21 <strncpy+0x4c>
    *s++ = 0;
80105f15:	8b 45 08             	mov    0x8(%ebp),%eax
80105f18:	c6 00 00             	movb   $0x0,(%eax)
80105f1b:	83 45 08 01          	addl   $0x1,0x8(%ebp)
80105f1f:	eb 01                	jmp    80105f22 <strncpy+0x4d>
  char *os;
  
  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
    ;
  while(n-- > 0)
80105f21:	90                   	nop
80105f22:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80105f26:	0f 9f c0             	setg   %al
80105f29:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
80105f2d:	84 c0                	test   %al,%al
80105f2f:	75 e4                	jne    80105f15 <strncpy+0x40>
    *s++ = 0;
  return os;
80105f31:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80105f34:	c9                   	leave  
80105f35:	c3                   	ret    

80105f36 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80105f36:	55                   	push   %ebp
80105f37:	89 e5                	mov    %esp,%ebp
80105f39:	83 ec 10             	sub    $0x10,%esp
  char *os;
  
  os = s;
80105f3c:	8b 45 08             	mov    0x8(%ebp),%eax
80105f3f:	89 45 fc             	mov    %eax,-0x4(%ebp)
  if(n <= 0)
80105f42:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80105f46:	7f 05                	jg     80105f4d <safestrcpy+0x17>
    return os;
80105f48:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105f4b:	eb 35                	jmp    80105f82 <safestrcpy+0x4c>
  while(--n > 0 && (*s++ = *t++) != 0)
80105f4d:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
80105f51:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80105f55:	7e 22                	jle    80105f79 <safestrcpy+0x43>
80105f57:	8b 45 0c             	mov    0xc(%ebp),%eax
80105f5a:	0f b6 10             	movzbl (%eax),%edx
80105f5d:	8b 45 08             	mov    0x8(%ebp),%eax
80105f60:	88 10                	mov    %dl,(%eax)
80105f62:	8b 45 08             	mov    0x8(%ebp),%eax
80105f65:	0f b6 00             	movzbl (%eax),%eax
80105f68:	84 c0                	test   %al,%al
80105f6a:	0f 95 c0             	setne  %al
80105f6d:	83 45 08 01          	addl   $0x1,0x8(%ebp)
80105f71:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
80105f75:	84 c0                	test   %al,%al
80105f77:	75 d4                	jne    80105f4d <safestrcpy+0x17>
    ;
  *s = 0;
80105f79:	8b 45 08             	mov    0x8(%ebp),%eax
80105f7c:	c6 00 00             	movb   $0x0,(%eax)
  return os;
80105f7f:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80105f82:	c9                   	leave  
80105f83:	c3                   	ret    

80105f84 <strlen>:

int
strlen(const char *s)
{
80105f84:	55                   	push   %ebp
80105f85:	89 e5                	mov    %esp,%ebp
80105f87:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
80105f8a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
80105f91:	eb 04                	jmp    80105f97 <strlen+0x13>
80105f93:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
80105f97:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105f9a:	03 45 08             	add    0x8(%ebp),%eax
80105f9d:	0f b6 00             	movzbl (%eax),%eax
80105fa0:	84 c0                	test   %al,%al
80105fa2:	75 ef                	jne    80105f93 <strlen+0xf>
    ;
  return n;
80105fa4:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80105fa7:	c9                   	leave  
80105fa8:	c3                   	ret    

80105fa9 <newstrcat>:

char* 
newstrcat(char *target, char* str1, char *str2)
{
80105fa9:	55                   	push   %ebp
80105faa:	89 e5                	mov    %esp,%ebp
80105fac:	83 ec 1c             	sub    $0x1c,%esp
  char *last;
  strncpy(target,str1,strlen(str1));
80105faf:	8b 45 0c             	mov    0xc(%ebp),%eax
80105fb2:	89 04 24             	mov    %eax,(%esp)
80105fb5:	e8 ca ff ff ff       	call   80105f84 <strlen>
80105fba:	89 44 24 08          	mov    %eax,0x8(%esp)
80105fbe:	8b 45 0c             	mov    0xc(%ebp),%eax
80105fc1:	89 44 24 04          	mov    %eax,0x4(%esp)
80105fc5:	8b 45 08             	mov    0x8(%ebp),%eax
80105fc8:	89 04 24             	mov    %eax,(%esp)
80105fcb:	e8 05 ff ff ff       	call   80105ed5 <strncpy>
  last=target+strlen(str1);
80105fd0:	8b 45 0c             	mov    0xc(%ebp),%eax
80105fd3:	89 04 24             	mov    %eax,(%esp)
80105fd6:	e8 a9 ff ff ff       	call   80105f84 <strlen>
80105fdb:	03 45 08             	add    0x8(%ebp),%eax
80105fde:	89 45 fc             	mov    %eax,-0x4(%ebp)
  safestrcpy(last,str2,strlen(str2)+1);
80105fe1:	8b 45 10             	mov    0x10(%ebp),%eax
80105fe4:	89 04 24             	mov    %eax,(%esp)
80105fe7:	e8 98 ff ff ff       	call   80105f84 <strlen>
80105fec:	83 c0 01             	add    $0x1,%eax
80105fef:	89 44 24 08          	mov    %eax,0x8(%esp)
80105ff3:	8b 45 10             	mov    0x10(%ebp),%eax
80105ff6:	89 44 24 04          	mov    %eax,0x4(%esp)
80105ffa:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105ffd:	89 04 24             	mov    %eax,(%esp)
80106000:	e8 31 ff ff ff       	call   80105f36 <safestrcpy>
  return target;
80106005:	8b 45 08             	mov    0x8(%ebp),%eax
}
80106008:	c9                   	leave  
80106009:	c3                   	ret    
	...

8010600c <swtch>:
# Save current register context in old
# and then load register context from new.

.globl swtch
swtch:
  movl 4(%esp), %eax
8010600c:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
80106010:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-save registers
  pushl %ebp
80106014:	55                   	push   %ebp
  pushl %ebx
80106015:	53                   	push   %ebx
  pushl %esi
80106016:	56                   	push   %esi
  pushl %edi
80106017:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
80106018:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
8010601a:	89 d4                	mov    %edx,%esp

  # Load new callee-save registers
  popl %edi
8010601c:	5f                   	pop    %edi
  popl %esi
8010601d:	5e                   	pop    %esi
  popl %ebx
8010601e:	5b                   	pop    %ebx
  popl %ebp
8010601f:	5d                   	pop    %ebp
  ret
80106020:	c3                   	ret    
80106021:	00 00                	add    %al,(%eax)
	...

80106024 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from process p.
int
fetchint(struct proc *p, uint addr, int *ip)
{
80106024:	55                   	push   %ebp
80106025:	89 e5                	mov    %esp,%ebp
  if(addr >= p->sz || addr+4 > p->sz)
80106027:	8b 45 08             	mov    0x8(%ebp),%eax
8010602a:	8b 00                	mov    (%eax),%eax
8010602c:	3b 45 0c             	cmp    0xc(%ebp),%eax
8010602f:	76 0f                	jbe    80106040 <fetchint+0x1c>
80106031:	8b 45 0c             	mov    0xc(%ebp),%eax
80106034:	8d 50 04             	lea    0x4(%eax),%edx
80106037:	8b 45 08             	mov    0x8(%ebp),%eax
8010603a:	8b 00                	mov    (%eax),%eax
8010603c:	39 c2                	cmp    %eax,%edx
8010603e:	76 07                	jbe    80106047 <fetchint+0x23>
    return -1;
80106040:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106045:	eb 0f                	jmp    80106056 <fetchint+0x32>
  *ip = *(int*)(addr);
80106047:	8b 45 0c             	mov    0xc(%ebp),%eax
8010604a:	8b 10                	mov    (%eax),%edx
8010604c:	8b 45 10             	mov    0x10(%ebp),%eax
8010604f:	89 10                	mov    %edx,(%eax)
  return 0;
80106051:	b8 00 00 00 00       	mov    $0x0,%eax
}
80106056:	5d                   	pop    %ebp
80106057:	c3                   	ret    

80106058 <fetchstr>:
// Fetch the nul-terminated string at addr from process p.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(struct proc *p, uint addr, char **pp)
{
80106058:	55                   	push   %ebp
80106059:	89 e5                	mov    %esp,%ebp
8010605b:	83 ec 10             	sub    $0x10,%esp
  char *s, *ep;

  if(addr >= p->sz)
8010605e:	8b 45 08             	mov    0x8(%ebp),%eax
80106061:	8b 00                	mov    (%eax),%eax
80106063:	3b 45 0c             	cmp    0xc(%ebp),%eax
80106066:	77 07                	ja     8010606f <fetchstr+0x17>
    return -1;
80106068:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010606d:	eb 45                	jmp    801060b4 <fetchstr+0x5c>
  *pp = (char*)addr;
8010606f:	8b 55 0c             	mov    0xc(%ebp),%edx
80106072:	8b 45 10             	mov    0x10(%ebp),%eax
80106075:	89 10                	mov    %edx,(%eax)
  ep = (char*)p->sz;
80106077:	8b 45 08             	mov    0x8(%ebp),%eax
8010607a:	8b 00                	mov    (%eax),%eax
8010607c:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(s = *pp; s < ep; s++)
8010607f:	8b 45 10             	mov    0x10(%ebp),%eax
80106082:	8b 00                	mov    (%eax),%eax
80106084:	89 45 fc             	mov    %eax,-0x4(%ebp)
80106087:	eb 1e                	jmp    801060a7 <fetchstr+0x4f>
    if(*s == 0)
80106089:	8b 45 fc             	mov    -0x4(%ebp),%eax
8010608c:	0f b6 00             	movzbl (%eax),%eax
8010608f:	84 c0                	test   %al,%al
80106091:	75 10                	jne    801060a3 <fetchstr+0x4b>
      return s - *pp;
80106093:	8b 55 fc             	mov    -0x4(%ebp),%edx
80106096:	8b 45 10             	mov    0x10(%ebp),%eax
80106099:	8b 00                	mov    (%eax),%eax
8010609b:	89 d1                	mov    %edx,%ecx
8010609d:	29 c1                	sub    %eax,%ecx
8010609f:	89 c8                	mov    %ecx,%eax
801060a1:	eb 11                	jmp    801060b4 <fetchstr+0x5c>

  if(addr >= p->sz)
    return -1;
  *pp = (char*)addr;
  ep = (char*)p->sz;
  for(s = *pp; s < ep; s++)
801060a3:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
801060a7:	8b 45 fc             	mov    -0x4(%ebp),%eax
801060aa:	3b 45 f8             	cmp    -0x8(%ebp),%eax
801060ad:	72 da                	jb     80106089 <fetchstr+0x31>
    if(*s == 0)
      return s - *pp;
  return -1;
801060af:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801060b4:	c9                   	leave  
801060b5:	c3                   	ret    

801060b6 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
801060b6:	55                   	push   %ebp
801060b7:	89 e5                	mov    %esp,%ebp
801060b9:	83 ec 0c             	sub    $0xc,%esp
  return fetchint(proc, proc->tf->esp + 4 + 4*n, ip);
801060bc:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801060c2:	8b 40 18             	mov    0x18(%eax),%eax
801060c5:	8b 50 44             	mov    0x44(%eax),%edx
801060c8:	8b 45 08             	mov    0x8(%ebp),%eax
801060cb:	c1 e0 02             	shl    $0x2,%eax
801060ce:	01 d0                	add    %edx,%eax
801060d0:	8d 48 04             	lea    0x4(%eax),%ecx
801060d3:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801060d9:	8b 55 0c             	mov    0xc(%ebp),%edx
801060dc:	89 54 24 08          	mov    %edx,0x8(%esp)
801060e0:	89 4c 24 04          	mov    %ecx,0x4(%esp)
801060e4:	89 04 24             	mov    %eax,(%esp)
801060e7:	e8 38 ff ff ff       	call   80106024 <fetchint>
}
801060ec:	c9                   	leave  
801060ed:	c3                   	ret    

801060ee <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size n bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
801060ee:	55                   	push   %ebp
801060ef:	89 e5                	mov    %esp,%ebp
801060f1:	83 ec 18             	sub    $0x18,%esp
  int i;
  
  if(argint(n, &i) < 0)
801060f4:	8d 45 fc             	lea    -0x4(%ebp),%eax
801060f7:	89 44 24 04          	mov    %eax,0x4(%esp)
801060fb:	8b 45 08             	mov    0x8(%ebp),%eax
801060fe:	89 04 24             	mov    %eax,(%esp)
80106101:	e8 b0 ff ff ff       	call   801060b6 <argint>
80106106:	85 c0                	test   %eax,%eax
80106108:	79 07                	jns    80106111 <argptr+0x23>
    return -1;
8010610a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010610f:	eb 3d                	jmp    8010614e <argptr+0x60>
  if((uint)i >= proc->sz || (uint)i+size > proc->sz)
80106111:	8b 45 fc             	mov    -0x4(%ebp),%eax
80106114:	89 c2                	mov    %eax,%edx
80106116:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010611c:	8b 00                	mov    (%eax),%eax
8010611e:	39 c2                	cmp    %eax,%edx
80106120:	73 16                	jae    80106138 <argptr+0x4a>
80106122:	8b 45 fc             	mov    -0x4(%ebp),%eax
80106125:	89 c2                	mov    %eax,%edx
80106127:	8b 45 10             	mov    0x10(%ebp),%eax
8010612a:	01 c2                	add    %eax,%edx
8010612c:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106132:	8b 00                	mov    (%eax),%eax
80106134:	39 c2                	cmp    %eax,%edx
80106136:	76 07                	jbe    8010613f <argptr+0x51>
    return -1;
80106138:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010613d:	eb 0f                	jmp    8010614e <argptr+0x60>
  *pp = (char*)i;
8010613f:	8b 45 fc             	mov    -0x4(%ebp),%eax
80106142:	89 c2                	mov    %eax,%edx
80106144:	8b 45 0c             	mov    0xc(%ebp),%eax
80106147:	89 10                	mov    %edx,(%eax)
  return 0;
80106149:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010614e:	c9                   	leave  
8010614f:	c3                   	ret    

80106150 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80106150:	55                   	push   %ebp
80106151:	89 e5                	mov    %esp,%ebp
80106153:	83 ec 1c             	sub    $0x1c,%esp
  int addr;
  if(argint(n, &addr) < 0)
80106156:	8d 45 fc             	lea    -0x4(%ebp),%eax
80106159:	89 44 24 04          	mov    %eax,0x4(%esp)
8010615d:	8b 45 08             	mov    0x8(%ebp),%eax
80106160:	89 04 24             	mov    %eax,(%esp)
80106163:	e8 4e ff ff ff       	call   801060b6 <argint>
80106168:	85 c0                	test   %eax,%eax
8010616a:	79 07                	jns    80106173 <argstr+0x23>
    return -1;
8010616c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106171:	eb 1e                	jmp    80106191 <argstr+0x41>
  return fetchstr(proc, addr, pp);
80106173:	8b 45 fc             	mov    -0x4(%ebp),%eax
80106176:	89 c2                	mov    %eax,%edx
80106178:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010617e:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80106181:	89 4c 24 08          	mov    %ecx,0x8(%esp)
80106185:	89 54 24 04          	mov    %edx,0x4(%esp)
80106189:	89 04 24             	mov    %eax,(%esp)
8010618c:	e8 c7 fe ff ff       	call   80106058 <fetchstr>
}
80106191:	c9                   	leave  
80106192:	c3                   	ret    

80106193 <syscall>:
[SYS_alarm] sys_alarm
};

void
syscall(void)
{
80106193:	55                   	push   %ebp
80106194:	89 e5                	mov    %esp,%ebp
80106196:	53                   	push   %ebx
80106197:	83 ec 24             	sub    $0x24,%esp
  int num;

  num = proc->tf->eax;
8010619a:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801061a0:	8b 40 18             	mov    0x18(%eax),%eax
801061a3:	8b 40 1c             	mov    0x1c(%eax),%eax
801061a6:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(num >= 0 && num < SYS_open && syscalls[num]) {
801061a9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801061ad:	78 2e                	js     801061dd <syscall+0x4a>
801061af:	83 7d f4 0e          	cmpl   $0xe,-0xc(%ebp)
801061b3:	7f 28                	jg     801061dd <syscall+0x4a>
801061b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801061b8:	8b 04 85 40 c0 10 80 	mov    -0x7fef3fc0(,%eax,4),%eax
801061bf:	85 c0                	test   %eax,%eax
801061c1:	74 1a                	je     801061dd <syscall+0x4a>
    proc->tf->eax = syscalls[num]();
801061c3:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801061c9:	8b 58 18             	mov    0x18(%eax),%ebx
801061cc:	8b 45 f4             	mov    -0xc(%ebp),%eax
801061cf:	8b 04 85 40 c0 10 80 	mov    -0x7fef3fc0(,%eax,4),%eax
801061d6:	ff d0                	call   *%eax
801061d8:	89 43 1c             	mov    %eax,0x1c(%ebx)
801061db:	eb 73                	jmp    80106250 <syscall+0xbd>
  } else if (num >= SYS_open && num < NELEM(syscalls) && syscalls[num]) {
801061dd:	83 7d f4 0e          	cmpl   $0xe,-0xc(%ebp)
801061e1:	7e 30                	jle    80106213 <syscall+0x80>
801061e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801061e6:	83 f8 1c             	cmp    $0x1c,%eax
801061e9:	77 28                	ja     80106213 <syscall+0x80>
801061eb:	8b 45 f4             	mov    -0xc(%ebp),%eax
801061ee:	8b 04 85 40 c0 10 80 	mov    -0x7fef3fc0(,%eax,4),%eax
801061f5:	85 c0                	test   %eax,%eax
801061f7:	74 1a                	je     80106213 <syscall+0x80>
    proc->tf->eax = syscalls[num]();
801061f9:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801061ff:	8b 58 18             	mov    0x18(%eax),%ebx
80106202:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106205:	8b 04 85 40 c0 10 80 	mov    -0x7fef3fc0(,%eax,4),%eax
8010620c:	ff d0                	call   *%eax
8010620e:	89 43 1c             	mov    %eax,0x1c(%ebx)
80106211:	eb 3d                	jmp    80106250 <syscall+0xbd>
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            proc->pid, proc->name, num);
80106213:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106219:	8d 48 6c             	lea    0x6c(%eax),%ecx
8010621c:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  if(num >= 0 && num < SYS_open && syscalls[num]) {
    proc->tf->eax = syscalls[num]();
  } else if (num >= SYS_open && num < NELEM(syscalls) && syscalls[num]) {
    proc->tf->eax = syscalls[num]();
  } else {
    cprintf("%d %s: unknown sys call %d\n",
80106222:	8b 40 10             	mov    0x10(%eax),%eax
80106225:	8b 55 f4             	mov    -0xc(%ebp),%edx
80106228:	89 54 24 0c          	mov    %edx,0xc(%esp)
8010622c:	89 4c 24 08          	mov    %ecx,0x8(%esp)
80106230:	89 44 24 04          	mov    %eax,0x4(%esp)
80106234:	c7 04 24 5e 98 10 80 	movl   $0x8010985e,(%esp)
8010623b:	e8 61 a1 ff ff       	call   801003a1 <cprintf>
            proc->pid, proc->name, num);
    proc->tf->eax = -1;
80106240:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106246:	8b 40 18             	mov    0x18(%eax),%eax
80106249:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
  }
}
80106250:	83 c4 24             	add    $0x24,%esp
80106253:	5b                   	pop    %ebx
80106254:	5d                   	pop    %ebp
80106255:	c3                   	ret    
	...

80106258 <argfd>:

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
{
80106258:	55                   	push   %ebp
80106259:	89 e5                	mov    %esp,%ebp
8010625b:	83 ec 28             	sub    $0x28,%esp
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
8010625e:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106261:	89 44 24 04          	mov    %eax,0x4(%esp)
80106265:	8b 45 08             	mov    0x8(%ebp),%eax
80106268:	89 04 24             	mov    %eax,(%esp)
8010626b:	e8 46 fe ff ff       	call   801060b6 <argint>
80106270:	85 c0                	test   %eax,%eax
80106272:	79 07                	jns    8010627b <argfd+0x23>
    return -1;
80106274:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106279:	eb 50                	jmp    801062cb <argfd+0x73>
  if(fd < 0 || fd >= NOFILE || (f=proc->ofile[fd]) == 0)
8010627b:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010627e:	85 c0                	test   %eax,%eax
80106280:	78 21                	js     801062a3 <argfd+0x4b>
80106282:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106285:	83 f8 0f             	cmp    $0xf,%eax
80106288:	7f 19                	jg     801062a3 <argfd+0x4b>
8010628a:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106290:	8b 55 f0             	mov    -0x10(%ebp),%edx
80106293:	83 c2 08             	add    $0x8,%edx
80106296:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
8010629a:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010629d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801062a1:	75 07                	jne    801062aa <argfd+0x52>
    return -1;
801062a3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801062a8:	eb 21                	jmp    801062cb <argfd+0x73>
  if(pfd)
801062aa:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
801062ae:	74 08                	je     801062b8 <argfd+0x60>
    *pfd = fd;
801062b0:	8b 55 f0             	mov    -0x10(%ebp),%edx
801062b3:	8b 45 0c             	mov    0xc(%ebp),%eax
801062b6:	89 10                	mov    %edx,(%eax)
  if(pf)
801062b8:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
801062bc:	74 08                	je     801062c6 <argfd+0x6e>
    *pf = f;
801062be:	8b 45 10             	mov    0x10(%ebp),%eax
801062c1:	8b 55 f4             	mov    -0xc(%ebp),%edx
801062c4:	89 10                	mov    %edx,(%eax)
  return 0;
801062c6:	b8 00 00 00 00       	mov    $0x0,%eax
}
801062cb:	c9                   	leave  
801062cc:	c3                   	ret    

801062cd <fdalloc>:

// Allocate a file descriptor for the given file.
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
801062cd:	55                   	push   %ebp
801062ce:	89 e5                	mov    %esp,%ebp
801062d0:	83 ec 10             	sub    $0x10,%esp
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
801062d3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
801062da:	eb 30                	jmp    8010630c <fdalloc+0x3f>
    if(proc->ofile[fd] == 0){
801062dc:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801062e2:	8b 55 fc             	mov    -0x4(%ebp),%edx
801062e5:	83 c2 08             	add    $0x8,%edx
801062e8:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
801062ec:	85 c0                	test   %eax,%eax
801062ee:	75 18                	jne    80106308 <fdalloc+0x3b>
      proc->ofile[fd] = f;
801062f0:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801062f6:	8b 55 fc             	mov    -0x4(%ebp),%edx
801062f9:	8d 4a 08             	lea    0x8(%edx),%ecx
801062fc:	8b 55 08             	mov    0x8(%ebp),%edx
801062ff:	89 54 88 08          	mov    %edx,0x8(%eax,%ecx,4)
      return fd;
80106303:	8b 45 fc             	mov    -0x4(%ebp),%eax
80106306:	eb 0f                	jmp    80106317 <fdalloc+0x4a>
static int
fdalloc(struct file *f)
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
80106308:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
8010630c:	83 7d fc 0f          	cmpl   $0xf,-0x4(%ebp)
80106310:	7e ca                	jle    801062dc <fdalloc+0xf>
    if(proc->ofile[fd] == 0){
      proc->ofile[fd] = f;
      return fd;
    }
  }
  return -1;
80106312:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106317:	c9                   	leave  
80106318:	c3                   	ret    

80106319 <sys_dup>:

int
sys_dup(void)
{
80106319:	55                   	push   %ebp
8010631a:	89 e5                	mov    %esp,%ebp
8010631c:	83 ec 28             	sub    $0x28,%esp
  struct file *f;
  int fd;
  
  if(argfd(0, 0, &f) < 0)
8010631f:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106322:	89 44 24 08          	mov    %eax,0x8(%esp)
80106326:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
8010632d:	00 
8010632e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106335:	e8 1e ff ff ff       	call   80106258 <argfd>
8010633a:	85 c0                	test   %eax,%eax
8010633c:	79 07                	jns    80106345 <sys_dup+0x2c>
    return -1;
8010633e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106343:	eb 29                	jmp    8010636e <sys_dup+0x55>
  if((fd=fdalloc(f)) < 0)
80106345:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106348:	89 04 24             	mov    %eax,(%esp)
8010634b:	e8 7d ff ff ff       	call   801062cd <fdalloc>
80106350:	89 45 f4             	mov    %eax,-0xc(%ebp)
80106353:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80106357:	79 07                	jns    80106360 <sys_dup+0x47>
    return -1;
80106359:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010635e:	eb 0e                	jmp    8010636e <sys_dup+0x55>
  filedup(f);
80106360:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106363:	89 04 24             	mov    %eax,(%esp)
80106366:	e8 65 b3 ff ff       	call   801016d0 <filedup>
  return fd;
8010636b:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
8010636e:	c9                   	leave  
8010636f:	c3                   	ret    

80106370 <sys_read>:

int
sys_read(void)
{
80106370:	55                   	push   %ebp
80106371:	89 e5                	mov    %esp,%ebp
80106373:	83 ec 28             	sub    $0x28,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80106376:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106379:	89 44 24 08          	mov    %eax,0x8(%esp)
8010637d:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80106384:	00 
80106385:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
8010638c:	e8 c7 fe ff ff       	call   80106258 <argfd>
80106391:	85 c0                	test   %eax,%eax
80106393:	78 35                	js     801063ca <sys_read+0x5a>
80106395:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106398:	89 44 24 04          	mov    %eax,0x4(%esp)
8010639c:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
801063a3:	e8 0e fd ff ff       	call   801060b6 <argint>
801063a8:	85 c0                	test   %eax,%eax
801063aa:	78 1e                	js     801063ca <sys_read+0x5a>
801063ac:	8b 45 f0             	mov    -0x10(%ebp),%eax
801063af:	89 44 24 08          	mov    %eax,0x8(%esp)
801063b3:	8d 45 ec             	lea    -0x14(%ebp),%eax
801063b6:	89 44 24 04          	mov    %eax,0x4(%esp)
801063ba:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801063c1:	e8 28 fd ff ff       	call   801060ee <argptr>
801063c6:	85 c0                	test   %eax,%eax
801063c8:	79 07                	jns    801063d1 <sys_read+0x61>
    return -1;
801063ca:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801063cf:	eb 19                	jmp    801063ea <sys_read+0x7a>
  return fileread(f, p, n);
801063d1:	8b 4d f0             	mov    -0x10(%ebp),%ecx
801063d4:	8b 55 ec             	mov    -0x14(%ebp),%edx
801063d7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801063da:	89 4c 24 08          	mov    %ecx,0x8(%esp)
801063de:	89 54 24 04          	mov    %edx,0x4(%esp)
801063e2:	89 04 24             	mov    %eax,(%esp)
801063e5:	e8 53 b4 ff ff       	call   8010183d <fileread>
}
801063ea:	c9                   	leave  
801063eb:	c3                   	ret    

801063ec <sys_write>:

int
sys_write(void)
{
801063ec:	55                   	push   %ebp
801063ed:	89 e5                	mov    %esp,%ebp
801063ef:	83 ec 28             	sub    $0x28,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
801063f2:	8d 45 f4             	lea    -0xc(%ebp),%eax
801063f5:	89 44 24 08          	mov    %eax,0x8(%esp)
801063f9:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80106400:	00 
80106401:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106408:	e8 4b fe ff ff       	call   80106258 <argfd>
8010640d:	85 c0                	test   %eax,%eax
8010640f:	78 35                	js     80106446 <sys_write+0x5a>
80106411:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106414:	89 44 24 04          	mov    %eax,0x4(%esp)
80106418:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
8010641f:	e8 92 fc ff ff       	call   801060b6 <argint>
80106424:	85 c0                	test   %eax,%eax
80106426:	78 1e                	js     80106446 <sys_write+0x5a>
80106428:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010642b:	89 44 24 08          	mov    %eax,0x8(%esp)
8010642f:	8d 45 ec             	lea    -0x14(%ebp),%eax
80106432:	89 44 24 04          	mov    %eax,0x4(%esp)
80106436:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
8010643d:	e8 ac fc ff ff       	call   801060ee <argptr>
80106442:	85 c0                	test   %eax,%eax
80106444:	79 07                	jns    8010644d <sys_write+0x61>
    return -1;
80106446:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010644b:	eb 19                	jmp    80106466 <sys_write+0x7a>
  return filewrite(f, p, n);
8010644d:	8b 4d f0             	mov    -0x10(%ebp),%ecx
80106450:	8b 55 ec             	mov    -0x14(%ebp),%edx
80106453:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106456:	89 4c 24 08          	mov    %ecx,0x8(%esp)
8010645a:	89 54 24 04          	mov    %edx,0x4(%esp)
8010645e:	89 04 24             	mov    %eax,(%esp)
80106461:	e8 93 b4 ff ff       	call   801018f9 <filewrite>
}
80106466:	c9                   	leave  
80106467:	c3                   	ret    

80106468 <sys_close>:

int
sys_close(void)
{
80106468:	55                   	push   %ebp
80106469:	89 e5                	mov    %esp,%ebp
8010646b:	83 ec 28             	sub    $0x28,%esp
  int fd;
  struct file *f;
  
  if(argfd(0, &fd, &f) < 0)
8010646e:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106471:	89 44 24 08          	mov    %eax,0x8(%esp)
80106475:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106478:	89 44 24 04          	mov    %eax,0x4(%esp)
8010647c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106483:	e8 d0 fd ff ff       	call   80106258 <argfd>
80106488:	85 c0                	test   %eax,%eax
8010648a:	79 07                	jns    80106493 <sys_close+0x2b>
    return -1;
8010648c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106491:	eb 24                	jmp    801064b7 <sys_close+0x4f>
  proc->ofile[fd] = 0;
80106493:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106499:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010649c:	83 c2 08             	add    $0x8,%edx
8010649f:	c7 44 90 08 00 00 00 	movl   $0x0,0x8(%eax,%edx,4)
801064a6:	00 
  fileclose(f);
801064a7:	8b 45 f0             	mov    -0x10(%ebp),%eax
801064aa:	89 04 24             	mov    %eax,(%esp)
801064ad:	e8 66 b2 ff ff       	call   80101718 <fileclose>
  return 0;
801064b2:	b8 00 00 00 00       	mov    $0x0,%eax
}
801064b7:	c9                   	leave  
801064b8:	c3                   	ret    

801064b9 <sys_fstat>:

int
sys_fstat(void)
{
801064b9:	55                   	push   %ebp
801064ba:	89 e5                	mov    %esp,%ebp
801064bc:	83 ec 28             	sub    $0x28,%esp
  struct file *f;
  struct stat *st;
  
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
801064bf:	8d 45 f4             	lea    -0xc(%ebp),%eax
801064c2:	89 44 24 08          	mov    %eax,0x8(%esp)
801064c6:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
801064cd:	00 
801064ce:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801064d5:	e8 7e fd ff ff       	call   80106258 <argfd>
801064da:	85 c0                	test   %eax,%eax
801064dc:	78 1f                	js     801064fd <sys_fstat+0x44>
801064de:	c7 44 24 08 14 00 00 	movl   $0x14,0x8(%esp)
801064e5:	00 
801064e6:	8d 45 f0             	lea    -0x10(%ebp),%eax
801064e9:	89 44 24 04          	mov    %eax,0x4(%esp)
801064ed:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801064f4:	e8 f5 fb ff ff       	call   801060ee <argptr>
801064f9:	85 c0                	test   %eax,%eax
801064fb:	79 07                	jns    80106504 <sys_fstat+0x4b>
    return -1;
801064fd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106502:	eb 12                	jmp    80106516 <sys_fstat+0x5d>
  return filestat(f, st);
80106504:	8b 55 f0             	mov    -0x10(%ebp),%edx
80106507:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010650a:	89 54 24 04          	mov    %edx,0x4(%esp)
8010650e:	89 04 24             	mov    %eax,(%esp)
80106511:	e8 d8 b2 ff ff       	call   801017ee <filestat>
}
80106516:	c9                   	leave  
80106517:	c3                   	ret    

80106518 <sys_link>:

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
80106518:	55                   	push   %ebp
80106519:	89 e5                	mov    %esp,%ebp
8010651b:	83 ec 38             	sub    $0x38,%esp
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
8010651e:	8d 45 d8             	lea    -0x28(%ebp),%eax
80106521:	89 44 24 04          	mov    %eax,0x4(%esp)
80106525:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
8010652c:	e8 1f fc ff ff       	call   80106150 <argstr>
80106531:	85 c0                	test   %eax,%eax
80106533:	78 17                	js     8010654c <sys_link+0x34>
80106535:	8d 45 dc             	lea    -0x24(%ebp),%eax
80106538:	89 44 24 04          	mov    %eax,0x4(%esp)
8010653c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80106543:	e8 08 fc ff ff       	call   80106150 <argstr>
80106548:	85 c0                	test   %eax,%eax
8010654a:	79 0a                	jns    80106556 <sys_link+0x3e>
    return -1;
8010654c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106551:	e9 3c 01 00 00       	jmp    80106692 <sys_link+0x17a>
  if((ip = namei(old)) == 0)
80106556:	8b 45 d8             	mov    -0x28(%ebp),%eax
80106559:	89 04 24             	mov    %eax,(%esp)
8010655c:	e8 fd c5 ff ff       	call   80102b5e <namei>
80106561:	89 45 f4             	mov    %eax,-0xc(%ebp)
80106564:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80106568:	75 0a                	jne    80106574 <sys_link+0x5c>
    return -1;
8010656a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010656f:	e9 1e 01 00 00       	jmp    80106692 <sys_link+0x17a>

  begin_trans();
80106574:	e8 f8 d3 ff ff       	call   80103971 <begin_trans>

  ilock(ip);
80106579:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010657c:	89 04 24             	mov    %eax,(%esp)
8010657f:	e8 38 ba ff ff       	call   80101fbc <ilock>
  if(ip->type == T_DIR){
80106584:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106587:	0f b7 40 10          	movzwl 0x10(%eax),%eax
8010658b:	66 83 f8 01          	cmp    $0x1,%ax
8010658f:	75 1a                	jne    801065ab <sys_link+0x93>
    iunlockput(ip);
80106591:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106594:	89 04 24             	mov    %eax,(%esp)
80106597:	e8 a4 bc ff ff       	call   80102240 <iunlockput>
    commit_trans();
8010659c:	e8 19 d4 ff ff       	call   801039ba <commit_trans>
    return -1;
801065a1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801065a6:	e9 e7 00 00 00       	jmp    80106692 <sys_link+0x17a>
  }

  ip->nlink++;
801065ab:	8b 45 f4             	mov    -0xc(%ebp),%eax
801065ae:	0f b7 40 16          	movzwl 0x16(%eax),%eax
801065b2:	8d 50 01             	lea    0x1(%eax),%edx
801065b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801065b8:	66 89 50 16          	mov    %dx,0x16(%eax)
  iupdate(ip);
801065bc:	8b 45 f4             	mov    -0xc(%ebp),%eax
801065bf:	89 04 24             	mov    %eax,(%esp)
801065c2:	e8 39 b8 ff ff       	call   80101e00 <iupdate>
  iunlock(ip);
801065c7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801065ca:	89 04 24             	mov    %eax,(%esp)
801065cd:	e8 38 bb ff ff       	call   8010210a <iunlock>

  if((dp = nameiparent(new, name)) == 0)
801065d2:	8b 45 dc             	mov    -0x24(%ebp),%eax
801065d5:	8d 55 e2             	lea    -0x1e(%ebp),%edx
801065d8:	89 54 24 04          	mov    %edx,0x4(%esp)
801065dc:	89 04 24             	mov    %eax,(%esp)
801065df:	e8 9c c5 ff ff       	call   80102b80 <nameiparent>
801065e4:	89 45 f0             	mov    %eax,-0x10(%ebp)
801065e7:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801065eb:	74 68                	je     80106655 <sys_link+0x13d>
    goto bad;
  ilock(dp);
801065ed:	8b 45 f0             	mov    -0x10(%ebp),%eax
801065f0:	89 04 24             	mov    %eax,(%esp)
801065f3:	e8 c4 b9 ff ff       	call   80101fbc <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
801065f8:	8b 45 f0             	mov    -0x10(%ebp),%eax
801065fb:	8b 10                	mov    (%eax),%edx
801065fd:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106600:	8b 00                	mov    (%eax),%eax
80106602:	39 c2                	cmp    %eax,%edx
80106604:	75 20                	jne    80106626 <sys_link+0x10e>
80106606:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106609:	8b 40 04             	mov    0x4(%eax),%eax
8010660c:	89 44 24 08          	mov    %eax,0x8(%esp)
80106610:	8d 45 e2             	lea    -0x1e(%ebp),%eax
80106613:	89 44 24 04          	mov    %eax,0x4(%esp)
80106617:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010661a:	89 04 24             	mov    %eax,(%esp)
8010661d:	e8 7b c2 ff ff       	call   8010289d <dirlink>
80106622:	85 c0                	test   %eax,%eax
80106624:	79 0d                	jns    80106633 <sys_link+0x11b>
    iunlockput(dp);
80106626:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106629:	89 04 24             	mov    %eax,(%esp)
8010662c:	e8 0f bc ff ff       	call   80102240 <iunlockput>
    goto bad;
80106631:	eb 23                	jmp    80106656 <sys_link+0x13e>
  }
  iunlockput(dp);
80106633:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106636:	89 04 24             	mov    %eax,(%esp)
80106639:	e8 02 bc ff ff       	call   80102240 <iunlockput>
  iput(ip);
8010663e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106641:	89 04 24             	mov    %eax,(%esp)
80106644:	e8 26 bb ff ff       	call   8010216f <iput>

  commit_trans();
80106649:	e8 6c d3 ff ff       	call   801039ba <commit_trans>

  return 0;
8010664e:	b8 00 00 00 00       	mov    $0x0,%eax
80106653:	eb 3d                	jmp    80106692 <sys_link+0x17a>
  ip->nlink++;
  iupdate(ip);
  iunlock(ip);

  if((dp = nameiparent(new, name)) == 0)
    goto bad;
80106655:	90                   	nop
  commit_trans();

  return 0;

bad:
  ilock(ip);
80106656:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106659:	89 04 24             	mov    %eax,(%esp)
8010665c:	e8 5b b9 ff ff       	call   80101fbc <ilock>
  ip->nlink--;
80106661:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106664:	0f b7 40 16          	movzwl 0x16(%eax),%eax
80106668:	8d 50 ff             	lea    -0x1(%eax),%edx
8010666b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010666e:	66 89 50 16          	mov    %dx,0x16(%eax)
  iupdate(ip);
80106672:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106675:	89 04 24             	mov    %eax,(%esp)
80106678:	e8 83 b7 ff ff       	call   80101e00 <iupdate>
  iunlockput(ip);
8010667d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106680:	89 04 24             	mov    %eax,(%esp)
80106683:	e8 b8 bb ff ff       	call   80102240 <iunlockput>
  commit_trans();
80106688:	e8 2d d3 ff ff       	call   801039ba <commit_trans>
  return -1;
8010668d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106692:	c9                   	leave  
80106693:	c3                   	ret    

80106694 <isdirempty>:

// Is the directory dp empty except for "." and ".." ?
static int
isdirempty(struct inode *dp)
{
80106694:	55                   	push   %ebp
80106695:	89 e5                	mov    %esp,%ebp
80106697:	83 ec 38             	sub    $0x38,%esp
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
8010669a:	c7 45 f4 20 00 00 00 	movl   $0x20,-0xc(%ebp)
801066a1:	eb 4b                	jmp    801066ee <isdirempty+0x5a>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801066a3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801066a6:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
801066ad:	00 
801066ae:	89 44 24 08          	mov    %eax,0x8(%esp)
801066b2:	8d 45 e4             	lea    -0x1c(%ebp),%eax
801066b5:	89 44 24 04          	mov    %eax,0x4(%esp)
801066b9:	8b 45 08             	mov    0x8(%ebp),%eax
801066bc:	89 04 24             	mov    %eax,(%esp)
801066bf:	e8 ee bd ff ff       	call   801024b2 <readi>
801066c4:	83 f8 10             	cmp    $0x10,%eax
801066c7:	74 0c                	je     801066d5 <isdirempty+0x41>
      panic("isdirempty: readi");
801066c9:	c7 04 24 7a 98 10 80 	movl   $0x8010987a,(%esp)
801066d0:	e8 68 9e ff ff       	call   8010053d <panic>
    if(de.inum != 0)
801066d5:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
801066d9:	66 85 c0             	test   %ax,%ax
801066dc:	74 07                	je     801066e5 <isdirempty+0x51>
      return 0;
801066de:	b8 00 00 00 00       	mov    $0x0,%eax
801066e3:	eb 1b                	jmp    80106700 <isdirempty+0x6c>
isdirempty(struct inode *dp)
{
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
801066e5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801066e8:	83 c0 10             	add    $0x10,%eax
801066eb:	89 45 f4             	mov    %eax,-0xc(%ebp)
801066ee:	8b 55 f4             	mov    -0xc(%ebp),%edx
801066f1:	8b 45 08             	mov    0x8(%ebp),%eax
801066f4:	8b 40 18             	mov    0x18(%eax),%eax
801066f7:	39 c2                	cmp    %eax,%edx
801066f9:	72 a8                	jb     801066a3 <isdirempty+0xf>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("isdirempty: readi");
    if(de.inum != 0)
      return 0;
  }
  return 1;
801066fb:	b8 01 00 00 00       	mov    $0x1,%eax
}
80106700:	c9                   	leave  
80106701:	c3                   	ret    

80106702 <sys_unlink>:

//PAGEBREAK!
int
sys_unlink(void)
{
80106702:	55                   	push   %ebp
80106703:	89 e5                	mov    %esp,%ebp
80106705:	83 ec 48             	sub    $0x48,%esp
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
80106708:	8d 45 cc             	lea    -0x34(%ebp),%eax
8010670b:	89 44 24 04          	mov    %eax,0x4(%esp)
8010670f:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106716:	e8 35 fa ff ff       	call   80106150 <argstr>
8010671b:	85 c0                	test   %eax,%eax
8010671d:	79 0a                	jns    80106729 <sys_unlink+0x27>
    return -1;
8010671f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106724:	e9 aa 01 00 00       	jmp    801068d3 <sys_unlink+0x1d1>
  if((dp = nameiparent(path, name)) == 0)
80106729:	8b 45 cc             	mov    -0x34(%ebp),%eax
8010672c:	8d 55 d2             	lea    -0x2e(%ebp),%edx
8010672f:	89 54 24 04          	mov    %edx,0x4(%esp)
80106733:	89 04 24             	mov    %eax,(%esp)
80106736:	e8 45 c4 ff ff       	call   80102b80 <nameiparent>
8010673b:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010673e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80106742:	75 0a                	jne    8010674e <sys_unlink+0x4c>
    return -1;
80106744:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106749:	e9 85 01 00 00       	jmp    801068d3 <sys_unlink+0x1d1>

  begin_trans();
8010674e:	e8 1e d2 ff ff       	call   80103971 <begin_trans>

  ilock(dp);
80106753:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106756:	89 04 24             	mov    %eax,(%esp)
80106759:	e8 5e b8 ff ff       	call   80101fbc <ilock>

  // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
8010675e:	c7 44 24 04 8c 98 10 	movl   $0x8010988c,0x4(%esp)
80106765:	80 
80106766:	8d 45 d2             	lea    -0x2e(%ebp),%eax
80106769:	89 04 24             	mov    %eax,(%esp)
8010676c:	e8 42 c0 ff ff       	call   801027b3 <namecmp>
80106771:	85 c0                	test   %eax,%eax
80106773:	0f 84 45 01 00 00    	je     801068be <sys_unlink+0x1bc>
80106779:	c7 44 24 04 8e 98 10 	movl   $0x8010988e,0x4(%esp)
80106780:	80 
80106781:	8d 45 d2             	lea    -0x2e(%ebp),%eax
80106784:	89 04 24             	mov    %eax,(%esp)
80106787:	e8 27 c0 ff ff       	call   801027b3 <namecmp>
8010678c:	85 c0                	test   %eax,%eax
8010678e:	0f 84 2a 01 00 00    	je     801068be <sys_unlink+0x1bc>
    goto bad;

  if((ip = dirlookup(dp, name, &off)) == 0)
80106794:	8d 45 c8             	lea    -0x38(%ebp),%eax
80106797:	89 44 24 08          	mov    %eax,0x8(%esp)
8010679b:	8d 45 d2             	lea    -0x2e(%ebp),%eax
8010679e:	89 44 24 04          	mov    %eax,0x4(%esp)
801067a2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801067a5:	89 04 24             	mov    %eax,(%esp)
801067a8:	e8 28 c0 ff ff       	call   801027d5 <dirlookup>
801067ad:	89 45 f0             	mov    %eax,-0x10(%ebp)
801067b0:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801067b4:	0f 84 03 01 00 00    	je     801068bd <sys_unlink+0x1bb>
    goto bad;
  ilock(ip);
801067ba:	8b 45 f0             	mov    -0x10(%ebp),%eax
801067bd:	89 04 24             	mov    %eax,(%esp)
801067c0:	e8 f7 b7 ff ff       	call   80101fbc <ilock>

  if(ip->nlink < 1)
801067c5:	8b 45 f0             	mov    -0x10(%ebp),%eax
801067c8:	0f b7 40 16          	movzwl 0x16(%eax),%eax
801067cc:	66 85 c0             	test   %ax,%ax
801067cf:	7f 0c                	jg     801067dd <sys_unlink+0xdb>
    panic("unlink: nlink < 1");
801067d1:	c7 04 24 91 98 10 80 	movl   $0x80109891,(%esp)
801067d8:	e8 60 9d ff ff       	call   8010053d <panic>
  if(ip->type == T_DIR && !isdirempty(ip)){
801067dd:	8b 45 f0             	mov    -0x10(%ebp),%eax
801067e0:	0f b7 40 10          	movzwl 0x10(%eax),%eax
801067e4:	66 83 f8 01          	cmp    $0x1,%ax
801067e8:	75 1f                	jne    80106809 <sys_unlink+0x107>
801067ea:	8b 45 f0             	mov    -0x10(%ebp),%eax
801067ed:	89 04 24             	mov    %eax,(%esp)
801067f0:	e8 9f fe ff ff       	call   80106694 <isdirempty>
801067f5:	85 c0                	test   %eax,%eax
801067f7:	75 10                	jne    80106809 <sys_unlink+0x107>
    iunlockput(ip);
801067f9:	8b 45 f0             	mov    -0x10(%ebp),%eax
801067fc:	89 04 24             	mov    %eax,(%esp)
801067ff:	e8 3c ba ff ff       	call   80102240 <iunlockput>
    goto bad;
80106804:	e9 b5 00 00 00       	jmp    801068be <sys_unlink+0x1bc>
  }

  memset(&de, 0, sizeof(de));
80106809:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
80106810:	00 
80106811:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80106818:	00 
80106819:	8d 45 e0             	lea    -0x20(%ebp),%eax
8010681c:	89 04 24             	mov    %eax,(%esp)
8010681f:	e8 e2 f4 ff ff       	call   80105d06 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80106824:	8b 45 c8             	mov    -0x38(%ebp),%eax
80106827:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
8010682e:	00 
8010682f:	89 44 24 08          	mov    %eax,0x8(%esp)
80106833:	8d 45 e0             	lea    -0x20(%ebp),%eax
80106836:	89 44 24 04          	mov    %eax,0x4(%esp)
8010683a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010683d:	89 04 24             	mov    %eax,(%esp)
80106840:	e8 d8 bd ff ff       	call   8010261d <writei>
80106845:	83 f8 10             	cmp    $0x10,%eax
80106848:	74 0c                	je     80106856 <sys_unlink+0x154>
    panic("unlink: writei");
8010684a:	c7 04 24 a3 98 10 80 	movl   $0x801098a3,(%esp)
80106851:	e8 e7 9c ff ff       	call   8010053d <panic>
  if(ip->type == T_DIR){
80106856:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106859:	0f b7 40 10          	movzwl 0x10(%eax),%eax
8010685d:	66 83 f8 01          	cmp    $0x1,%ax
80106861:	75 1c                	jne    8010687f <sys_unlink+0x17d>
    dp->nlink--;
80106863:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106866:	0f b7 40 16          	movzwl 0x16(%eax),%eax
8010686a:	8d 50 ff             	lea    -0x1(%eax),%edx
8010686d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106870:	66 89 50 16          	mov    %dx,0x16(%eax)
    iupdate(dp);
80106874:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106877:	89 04 24             	mov    %eax,(%esp)
8010687a:	e8 81 b5 ff ff       	call   80101e00 <iupdate>
  }
  iunlockput(dp);
8010687f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106882:	89 04 24             	mov    %eax,(%esp)
80106885:	e8 b6 b9 ff ff       	call   80102240 <iunlockput>

  ip->nlink--;
8010688a:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010688d:	0f b7 40 16          	movzwl 0x16(%eax),%eax
80106891:	8d 50 ff             	lea    -0x1(%eax),%edx
80106894:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106897:	66 89 50 16          	mov    %dx,0x16(%eax)
  iupdate(ip);
8010689b:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010689e:	89 04 24             	mov    %eax,(%esp)
801068a1:	e8 5a b5 ff ff       	call   80101e00 <iupdate>
  iunlockput(ip);
801068a6:	8b 45 f0             	mov    -0x10(%ebp),%eax
801068a9:	89 04 24             	mov    %eax,(%esp)
801068ac:	e8 8f b9 ff ff       	call   80102240 <iunlockput>

  commit_trans();
801068b1:	e8 04 d1 ff ff       	call   801039ba <commit_trans>

  return 0;
801068b6:	b8 00 00 00 00       	mov    $0x0,%eax
801068bb:	eb 16                	jmp    801068d3 <sys_unlink+0x1d1>
  // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
    goto bad;

  if((ip = dirlookup(dp, name, &off)) == 0)
    goto bad;
801068bd:	90                   	nop
  commit_trans();

  return 0;

bad:
  iunlockput(dp);
801068be:	8b 45 f4             	mov    -0xc(%ebp),%eax
801068c1:	89 04 24             	mov    %eax,(%esp)
801068c4:	e8 77 b9 ff ff       	call   80102240 <iunlockput>
  commit_trans();
801068c9:	e8 ec d0 ff ff       	call   801039ba <commit_trans>
  return -1;
801068ce:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801068d3:	c9                   	leave  
801068d4:	c3                   	ret    

801068d5 <create>:

static struct inode*
create(char *path, short type, short major, short minor)
{
801068d5:	55                   	push   %ebp
801068d6:	89 e5                	mov    %esp,%ebp
801068d8:	83 ec 48             	sub    $0x48,%esp
801068db:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801068de:	8b 55 10             	mov    0x10(%ebp),%edx
801068e1:	8b 45 14             	mov    0x14(%ebp),%eax
801068e4:	66 89 4d d4          	mov    %cx,-0x2c(%ebp)
801068e8:	66 89 55 d0          	mov    %dx,-0x30(%ebp)
801068ec:	66 89 45 cc          	mov    %ax,-0x34(%ebp)
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
801068f0:	8d 45 de             	lea    -0x22(%ebp),%eax
801068f3:	89 44 24 04          	mov    %eax,0x4(%esp)
801068f7:	8b 45 08             	mov    0x8(%ebp),%eax
801068fa:	89 04 24             	mov    %eax,(%esp)
801068fd:	e8 7e c2 ff ff       	call   80102b80 <nameiparent>
80106902:	89 45 f4             	mov    %eax,-0xc(%ebp)
80106905:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80106909:	75 0a                	jne    80106915 <create+0x40>
    return 0;
8010690b:	b8 00 00 00 00       	mov    $0x0,%eax
80106910:	e9 7e 01 00 00       	jmp    80106a93 <create+0x1be>
  ilock(dp);
80106915:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106918:	89 04 24             	mov    %eax,(%esp)
8010691b:	e8 9c b6 ff ff       	call   80101fbc <ilock>

  if((ip = dirlookup(dp, name, &off)) != 0){
80106920:	8d 45 ec             	lea    -0x14(%ebp),%eax
80106923:	89 44 24 08          	mov    %eax,0x8(%esp)
80106927:	8d 45 de             	lea    -0x22(%ebp),%eax
8010692a:	89 44 24 04          	mov    %eax,0x4(%esp)
8010692e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106931:	89 04 24             	mov    %eax,(%esp)
80106934:	e8 9c be ff ff       	call   801027d5 <dirlookup>
80106939:	89 45 f0             	mov    %eax,-0x10(%ebp)
8010693c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80106940:	74 47                	je     80106989 <create+0xb4>
    iunlockput(dp);
80106942:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106945:	89 04 24             	mov    %eax,(%esp)
80106948:	e8 f3 b8 ff ff       	call   80102240 <iunlockput>
    ilock(ip);
8010694d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106950:	89 04 24             	mov    %eax,(%esp)
80106953:	e8 64 b6 ff ff       	call   80101fbc <ilock>
    if(type == T_FILE && ip->type == T_FILE)
80106958:	66 83 7d d4 02       	cmpw   $0x2,-0x2c(%ebp)
8010695d:	75 15                	jne    80106974 <create+0x9f>
8010695f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106962:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80106966:	66 83 f8 02          	cmp    $0x2,%ax
8010696a:	75 08                	jne    80106974 <create+0x9f>
      return ip;
8010696c:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010696f:	e9 1f 01 00 00       	jmp    80106a93 <create+0x1be>
    iunlockput(ip);
80106974:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106977:	89 04 24             	mov    %eax,(%esp)
8010697a:	e8 c1 b8 ff ff       	call   80102240 <iunlockput>
    return 0;
8010697f:	b8 00 00 00 00       	mov    $0x0,%eax
80106984:	e9 0a 01 00 00       	jmp    80106a93 <create+0x1be>
  }

  if((ip = ialloc(dp->dev, type)) == 0)
80106989:	0f bf 55 d4          	movswl -0x2c(%ebp),%edx
8010698d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106990:	8b 00                	mov    (%eax),%eax
80106992:	89 54 24 04          	mov    %edx,0x4(%esp)
80106996:	89 04 24             	mov    %eax,(%esp)
80106999:	e8 85 b3 ff ff       	call   80101d23 <ialloc>
8010699e:	89 45 f0             	mov    %eax,-0x10(%ebp)
801069a1:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801069a5:	75 0c                	jne    801069b3 <create+0xde>
    panic("create: ialloc");
801069a7:	c7 04 24 b2 98 10 80 	movl   $0x801098b2,(%esp)
801069ae:	e8 8a 9b ff ff       	call   8010053d <panic>

  ilock(ip);
801069b3:	8b 45 f0             	mov    -0x10(%ebp),%eax
801069b6:	89 04 24             	mov    %eax,(%esp)
801069b9:	e8 fe b5 ff ff       	call   80101fbc <ilock>
  ip->major = major;
801069be:	8b 45 f0             	mov    -0x10(%ebp),%eax
801069c1:	0f b7 55 d0          	movzwl -0x30(%ebp),%edx
801069c5:	66 89 50 12          	mov    %dx,0x12(%eax)
  ip->minor = minor;
801069c9:	8b 45 f0             	mov    -0x10(%ebp),%eax
801069cc:	0f b7 55 cc          	movzwl -0x34(%ebp),%edx
801069d0:	66 89 50 14          	mov    %dx,0x14(%eax)
  ip->nlink = 1;
801069d4:	8b 45 f0             	mov    -0x10(%ebp),%eax
801069d7:	66 c7 40 16 01 00    	movw   $0x1,0x16(%eax)
  iupdate(ip);
801069dd:	8b 45 f0             	mov    -0x10(%ebp),%eax
801069e0:	89 04 24             	mov    %eax,(%esp)
801069e3:	e8 18 b4 ff ff       	call   80101e00 <iupdate>

  if(type == T_DIR){  // Create . and .. entries.
801069e8:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
801069ed:	75 6a                	jne    80106a59 <create+0x184>
    dp->nlink++;  // for ".."
801069ef:	8b 45 f4             	mov    -0xc(%ebp),%eax
801069f2:	0f b7 40 16          	movzwl 0x16(%eax),%eax
801069f6:	8d 50 01             	lea    0x1(%eax),%edx
801069f9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801069fc:	66 89 50 16          	mov    %dx,0x16(%eax)
    iupdate(dp);
80106a00:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106a03:	89 04 24             	mov    %eax,(%esp)
80106a06:	e8 f5 b3 ff ff       	call   80101e00 <iupdate>
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
80106a0b:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106a0e:	8b 40 04             	mov    0x4(%eax),%eax
80106a11:	89 44 24 08          	mov    %eax,0x8(%esp)
80106a15:	c7 44 24 04 8c 98 10 	movl   $0x8010988c,0x4(%esp)
80106a1c:	80 
80106a1d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106a20:	89 04 24             	mov    %eax,(%esp)
80106a23:	e8 75 be ff ff       	call   8010289d <dirlink>
80106a28:	85 c0                	test   %eax,%eax
80106a2a:	78 21                	js     80106a4d <create+0x178>
80106a2c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106a2f:	8b 40 04             	mov    0x4(%eax),%eax
80106a32:	89 44 24 08          	mov    %eax,0x8(%esp)
80106a36:	c7 44 24 04 8e 98 10 	movl   $0x8010988e,0x4(%esp)
80106a3d:	80 
80106a3e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106a41:	89 04 24             	mov    %eax,(%esp)
80106a44:	e8 54 be ff ff       	call   8010289d <dirlink>
80106a49:	85 c0                	test   %eax,%eax
80106a4b:	79 0c                	jns    80106a59 <create+0x184>
      panic("create dots");
80106a4d:	c7 04 24 c1 98 10 80 	movl   $0x801098c1,(%esp)
80106a54:	e8 e4 9a ff ff       	call   8010053d <panic>
  }

  if(dirlink(dp, name, ip->inum) < 0)
80106a59:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106a5c:	8b 40 04             	mov    0x4(%eax),%eax
80106a5f:	89 44 24 08          	mov    %eax,0x8(%esp)
80106a63:	8d 45 de             	lea    -0x22(%ebp),%eax
80106a66:	89 44 24 04          	mov    %eax,0x4(%esp)
80106a6a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106a6d:	89 04 24             	mov    %eax,(%esp)
80106a70:	e8 28 be ff ff       	call   8010289d <dirlink>
80106a75:	85 c0                	test   %eax,%eax
80106a77:	79 0c                	jns    80106a85 <create+0x1b0>
    panic("create: dirlink");
80106a79:	c7 04 24 cd 98 10 80 	movl   $0x801098cd,(%esp)
80106a80:	e8 b8 9a ff ff       	call   8010053d <panic>

  iunlockput(dp);
80106a85:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106a88:	89 04 24             	mov    %eax,(%esp)
80106a8b:	e8 b0 b7 ff ff       	call   80102240 <iunlockput>

  return ip;
80106a90:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
80106a93:	c9                   	leave  
80106a94:	c3                   	ret    

80106a95 <sys_open>:

int
sys_open(void)
{
80106a95:	55                   	push   %ebp
80106a96:	89 e5                	mov    %esp,%ebp
80106a98:	83 ec 38             	sub    $0x38,%esp
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80106a9b:	8d 45 e8             	lea    -0x18(%ebp),%eax
80106a9e:	89 44 24 04          	mov    %eax,0x4(%esp)
80106aa2:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106aa9:	e8 a2 f6 ff ff       	call   80106150 <argstr>
80106aae:	85 c0                	test   %eax,%eax
80106ab0:	78 17                	js     80106ac9 <sys_open+0x34>
80106ab2:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80106ab5:	89 44 24 04          	mov    %eax,0x4(%esp)
80106ab9:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80106ac0:	e8 f1 f5 ff ff       	call   801060b6 <argint>
80106ac5:	85 c0                	test   %eax,%eax
80106ac7:	79 0a                	jns    80106ad3 <sys_open+0x3e>
    return -1;
80106ac9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106ace:	e9 46 01 00 00       	jmp    80106c19 <sys_open+0x184>
  if(omode & O_CREATE){
80106ad3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106ad6:	25 00 02 00 00       	and    $0x200,%eax
80106adb:	85 c0                	test   %eax,%eax
80106add:	74 40                	je     80106b1f <sys_open+0x8a>
    begin_trans();
80106adf:	e8 8d ce ff ff       	call   80103971 <begin_trans>
    ip = create(path, T_FILE, 0, 0);
80106ae4:	8b 45 e8             	mov    -0x18(%ebp),%eax
80106ae7:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
80106aee:	00 
80106aef:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
80106af6:	00 
80106af7:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
80106afe:	00 
80106aff:	89 04 24             	mov    %eax,(%esp)
80106b02:	e8 ce fd ff ff       	call   801068d5 <create>
80106b07:	89 45 f4             	mov    %eax,-0xc(%ebp)
    commit_trans();
80106b0a:	e8 ab ce ff ff       	call   801039ba <commit_trans>
    if(ip == 0)
80106b0f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80106b13:	75 5c                	jne    80106b71 <sys_open+0xdc>
      return -1;
80106b15:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106b1a:	e9 fa 00 00 00       	jmp    80106c19 <sys_open+0x184>
  } else {
    if((ip = namei(path)) == 0)
80106b1f:	8b 45 e8             	mov    -0x18(%ebp),%eax
80106b22:	89 04 24             	mov    %eax,(%esp)
80106b25:	e8 34 c0 ff ff       	call   80102b5e <namei>
80106b2a:	89 45 f4             	mov    %eax,-0xc(%ebp)
80106b2d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80106b31:	75 0a                	jne    80106b3d <sys_open+0xa8>
      return -1;
80106b33:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106b38:	e9 dc 00 00 00       	jmp    80106c19 <sys_open+0x184>
    ilock(ip);
80106b3d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106b40:	89 04 24             	mov    %eax,(%esp)
80106b43:	e8 74 b4 ff ff       	call   80101fbc <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
80106b48:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106b4b:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80106b4f:	66 83 f8 01          	cmp    $0x1,%ax
80106b53:	75 1c                	jne    80106b71 <sys_open+0xdc>
80106b55:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106b58:	85 c0                	test   %eax,%eax
80106b5a:	74 15                	je     80106b71 <sys_open+0xdc>
      iunlockput(ip);
80106b5c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106b5f:	89 04 24             	mov    %eax,(%esp)
80106b62:	e8 d9 b6 ff ff       	call   80102240 <iunlockput>
      return -1;
80106b67:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106b6c:	e9 a8 00 00 00       	jmp    80106c19 <sys_open+0x184>
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
80106b71:	e8 fa aa ff ff       	call   80101670 <filealloc>
80106b76:	89 45 f0             	mov    %eax,-0x10(%ebp)
80106b79:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80106b7d:	74 14                	je     80106b93 <sys_open+0xfe>
80106b7f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106b82:	89 04 24             	mov    %eax,(%esp)
80106b85:	e8 43 f7 ff ff       	call   801062cd <fdalloc>
80106b8a:	89 45 ec             	mov    %eax,-0x14(%ebp)
80106b8d:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80106b91:	79 23                	jns    80106bb6 <sys_open+0x121>
    if(f)
80106b93:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80106b97:	74 0b                	je     80106ba4 <sys_open+0x10f>
      fileclose(f);
80106b99:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106b9c:	89 04 24             	mov    %eax,(%esp)
80106b9f:	e8 74 ab ff ff       	call   80101718 <fileclose>
    iunlockput(ip);
80106ba4:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106ba7:	89 04 24             	mov    %eax,(%esp)
80106baa:	e8 91 b6 ff ff       	call   80102240 <iunlockput>
    return -1;
80106baf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106bb4:	eb 63                	jmp    80106c19 <sys_open+0x184>
  }
  iunlock(ip);
80106bb6:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106bb9:	89 04 24             	mov    %eax,(%esp)
80106bbc:	e8 49 b5 ff ff       	call   8010210a <iunlock>

  f->type = FD_INODE;
80106bc1:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106bc4:	c7 00 02 00 00 00    	movl   $0x2,(%eax)
  f->ip = ip;
80106bca:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106bcd:	8b 55 f4             	mov    -0xc(%ebp),%edx
80106bd0:	89 50 10             	mov    %edx,0x10(%eax)
  f->off = 0;
80106bd3:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106bd6:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
  f->readable = !(omode & O_WRONLY);
80106bdd:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106be0:	83 e0 01             	and    $0x1,%eax
80106be3:	85 c0                	test   %eax,%eax
80106be5:	0f 94 c2             	sete   %dl
80106be8:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106beb:	88 50 08             	mov    %dl,0x8(%eax)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80106bee:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106bf1:	83 e0 01             	and    $0x1,%eax
80106bf4:	84 c0                	test   %al,%al
80106bf6:	75 0a                	jne    80106c02 <sys_open+0x16d>
80106bf8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106bfb:	83 e0 02             	and    $0x2,%eax
80106bfe:	85 c0                	test   %eax,%eax
80106c00:	74 07                	je     80106c09 <sys_open+0x174>
80106c02:	b8 01 00 00 00       	mov    $0x1,%eax
80106c07:	eb 05                	jmp    80106c0e <sys_open+0x179>
80106c09:	b8 00 00 00 00       	mov    $0x0,%eax
80106c0e:	89 c2                	mov    %eax,%edx
80106c10:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106c13:	88 50 09             	mov    %dl,0x9(%eax)
  return fd;
80106c16:	8b 45 ec             	mov    -0x14(%ebp),%eax
}
80106c19:	c9                   	leave  
80106c1a:	c3                   	ret    

80106c1b <sys_mkdir>:

int
sys_mkdir(void)
{
80106c1b:	55                   	push   %ebp
80106c1c:	89 e5                	mov    %esp,%ebp
80106c1e:	83 ec 28             	sub    $0x28,%esp
  char *path;
  struct inode *ip;

  begin_trans();
80106c21:	e8 4b cd ff ff       	call   80103971 <begin_trans>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
80106c26:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106c29:	89 44 24 04          	mov    %eax,0x4(%esp)
80106c2d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106c34:	e8 17 f5 ff ff       	call   80106150 <argstr>
80106c39:	85 c0                	test   %eax,%eax
80106c3b:	78 2c                	js     80106c69 <sys_mkdir+0x4e>
80106c3d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106c40:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
80106c47:	00 
80106c48:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
80106c4f:	00 
80106c50:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
80106c57:	00 
80106c58:	89 04 24             	mov    %eax,(%esp)
80106c5b:	e8 75 fc ff ff       	call   801068d5 <create>
80106c60:	89 45 f4             	mov    %eax,-0xc(%ebp)
80106c63:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80106c67:	75 0c                	jne    80106c75 <sys_mkdir+0x5a>
    commit_trans();
80106c69:	e8 4c cd ff ff       	call   801039ba <commit_trans>
    return -1;
80106c6e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106c73:	eb 15                	jmp    80106c8a <sys_mkdir+0x6f>
  }
  iunlockput(ip);
80106c75:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106c78:	89 04 24             	mov    %eax,(%esp)
80106c7b:	e8 c0 b5 ff ff       	call   80102240 <iunlockput>
  commit_trans();
80106c80:	e8 35 cd ff ff       	call   801039ba <commit_trans>
  return 0;
80106c85:	b8 00 00 00 00       	mov    $0x0,%eax
}
80106c8a:	c9                   	leave  
80106c8b:	c3                   	ret    

80106c8c <sys_mknod>:

int
sys_mknod(void)
{
80106c8c:	55                   	push   %ebp
80106c8d:	89 e5                	mov    %esp,%ebp
80106c8f:	83 ec 38             	sub    $0x38,%esp
  struct inode *ip;
  char *path;
  int len;
  int major, minor;
  
  begin_trans();
80106c92:	e8 da cc ff ff       	call   80103971 <begin_trans>
  if((len=argstr(0, &path)) < 0 ||
80106c97:	8d 45 ec             	lea    -0x14(%ebp),%eax
80106c9a:	89 44 24 04          	mov    %eax,0x4(%esp)
80106c9e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106ca5:	e8 a6 f4 ff ff       	call   80106150 <argstr>
80106caa:	89 45 f4             	mov    %eax,-0xc(%ebp)
80106cad:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80106cb1:	78 5e                	js     80106d11 <sys_mknod+0x85>
     argint(1, &major) < 0 ||
80106cb3:	8d 45 e8             	lea    -0x18(%ebp),%eax
80106cb6:	89 44 24 04          	mov    %eax,0x4(%esp)
80106cba:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80106cc1:	e8 f0 f3 ff ff       	call   801060b6 <argint>
  char *path;
  int len;
  int major, minor;
  
  begin_trans();
  if((len=argstr(0, &path)) < 0 ||
80106cc6:	85 c0                	test   %eax,%eax
80106cc8:	78 47                	js     80106d11 <sys_mknod+0x85>
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
80106cca:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80106ccd:	89 44 24 04          	mov    %eax,0x4(%esp)
80106cd1:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
80106cd8:	e8 d9 f3 ff ff       	call   801060b6 <argint>
  int len;
  int major, minor;
  
  begin_trans();
  if((len=argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
80106cdd:	85 c0                	test   %eax,%eax
80106cdf:	78 30                	js     80106d11 <sys_mknod+0x85>
     argint(2, &minor) < 0 ||
     (ip = create(path, T_DEV, major, minor)) == 0){
80106ce1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106ce4:	0f bf c8             	movswl %ax,%ecx
80106ce7:	8b 45 e8             	mov    -0x18(%ebp),%eax
80106cea:	0f bf d0             	movswl %ax,%edx
80106ced:	8b 45 ec             	mov    -0x14(%ebp),%eax
  int major, minor;
  
  begin_trans();
  if((len=argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
80106cf0:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
80106cf4:	89 54 24 08          	mov    %edx,0x8(%esp)
80106cf8:	c7 44 24 04 03 00 00 	movl   $0x3,0x4(%esp)
80106cff:	00 
80106d00:	89 04 24             	mov    %eax,(%esp)
80106d03:	e8 cd fb ff ff       	call   801068d5 <create>
80106d08:	89 45 f0             	mov    %eax,-0x10(%ebp)
80106d0b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80106d0f:	75 0c                	jne    80106d1d <sys_mknod+0x91>
     (ip = create(path, T_DEV, major, minor)) == 0){
    commit_trans();
80106d11:	e8 a4 cc ff ff       	call   801039ba <commit_trans>
    return -1;
80106d16:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106d1b:	eb 15                	jmp    80106d32 <sys_mknod+0xa6>
  }
  iunlockput(ip);
80106d1d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106d20:	89 04 24             	mov    %eax,(%esp)
80106d23:	e8 18 b5 ff ff       	call   80102240 <iunlockput>
  commit_trans();
80106d28:	e8 8d cc ff ff       	call   801039ba <commit_trans>
  return 0;
80106d2d:	b8 00 00 00 00       	mov    $0x0,%eax
}
80106d32:	c9                   	leave  
80106d33:	c3                   	ret    

80106d34 <sys_chdir>:

int
sys_chdir(void)
{
80106d34:	55                   	push   %ebp
80106d35:	89 e5                	mov    %esp,%ebp
80106d37:	83 ec 28             	sub    $0x28,%esp
  char *path;
  struct inode *ip;

  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0)
80106d3a:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106d3d:	89 44 24 04          	mov    %eax,0x4(%esp)
80106d41:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106d48:	e8 03 f4 ff ff       	call   80106150 <argstr>
80106d4d:	85 c0                	test   %eax,%eax
80106d4f:	78 14                	js     80106d65 <sys_chdir+0x31>
80106d51:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106d54:	89 04 24             	mov    %eax,(%esp)
80106d57:	e8 02 be ff ff       	call   80102b5e <namei>
80106d5c:	89 45 f4             	mov    %eax,-0xc(%ebp)
80106d5f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80106d63:	75 07                	jne    80106d6c <sys_chdir+0x38>
    return -1;
80106d65:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106d6a:	eb 57                	jmp    80106dc3 <sys_chdir+0x8f>
  ilock(ip);
80106d6c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106d6f:	89 04 24             	mov    %eax,(%esp)
80106d72:	e8 45 b2 ff ff       	call   80101fbc <ilock>
  if(ip->type != T_DIR){
80106d77:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106d7a:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80106d7e:	66 83 f8 01          	cmp    $0x1,%ax
80106d82:	74 12                	je     80106d96 <sys_chdir+0x62>
    iunlockput(ip);
80106d84:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106d87:	89 04 24             	mov    %eax,(%esp)
80106d8a:	e8 b1 b4 ff ff       	call   80102240 <iunlockput>
    return -1;
80106d8f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106d94:	eb 2d                	jmp    80106dc3 <sys_chdir+0x8f>
  }
  iunlock(ip);
80106d96:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106d99:	89 04 24             	mov    %eax,(%esp)
80106d9c:	e8 69 b3 ff ff       	call   8010210a <iunlock>
  iput(proc->cwd);
80106da1:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106da7:	8b 40 68             	mov    0x68(%eax),%eax
80106daa:	89 04 24             	mov    %eax,(%esp)
80106dad:	e8 bd b3 ff ff       	call   8010216f <iput>
  proc->cwd = ip;
80106db2:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106db8:	8b 55 f4             	mov    -0xc(%ebp),%edx
80106dbb:	89 50 68             	mov    %edx,0x68(%eax)
  return 0;
80106dbe:	b8 00 00 00 00       	mov    $0x0,%eax
}
80106dc3:	c9                   	leave  
80106dc4:	c3                   	ret    

80106dc5 <sys_exec>:

int
sys_exec(void)
{
80106dc5:	55                   	push   %ebp
80106dc6:	89 e5                	mov    %esp,%ebp
80106dc8:	81 ec a8 00 00 00    	sub    $0xa8,%esp
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80106dce:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106dd1:	89 44 24 04          	mov    %eax,0x4(%esp)
80106dd5:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106ddc:	e8 6f f3 ff ff       	call   80106150 <argstr>
80106de1:	85 c0                	test   %eax,%eax
80106de3:	78 1a                	js     80106dff <sys_exec+0x3a>
80106de5:	8d 85 6c ff ff ff    	lea    -0x94(%ebp),%eax
80106deb:	89 44 24 04          	mov    %eax,0x4(%esp)
80106def:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80106df6:	e8 bb f2 ff ff       	call   801060b6 <argint>
80106dfb:	85 c0                	test   %eax,%eax
80106dfd:	79 0a                	jns    80106e09 <sys_exec+0x44>
    return -1;
80106dff:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106e04:	e9 e2 00 00 00       	jmp    80106eeb <sys_exec+0x126>
  }
  memset(argv, 0, sizeof(argv));
80106e09:	c7 44 24 08 80 00 00 	movl   $0x80,0x8(%esp)
80106e10:	00 
80106e11:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80106e18:	00 
80106e19:	8d 85 70 ff ff ff    	lea    -0x90(%ebp),%eax
80106e1f:	89 04 24             	mov    %eax,(%esp)
80106e22:	e8 df ee ff ff       	call   80105d06 <memset>
  for(i=0;; i++){
80106e27:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(i >= NELEM(argv))
80106e2e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106e31:	83 f8 1f             	cmp    $0x1f,%eax
80106e34:	76 0a                	jbe    80106e40 <sys_exec+0x7b>
      return -1;
80106e36:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106e3b:	e9 ab 00 00 00       	jmp    80106eeb <sys_exec+0x126>
    if(fetchint(proc, uargv+4*i, (int*)&uarg) < 0)
80106e40:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106e43:	c1 e0 02             	shl    $0x2,%eax
80106e46:	89 c2                	mov    %eax,%edx
80106e48:	8b 85 6c ff ff ff    	mov    -0x94(%ebp),%eax
80106e4e:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
80106e51:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106e57:	8d 95 68 ff ff ff    	lea    -0x98(%ebp),%edx
80106e5d:	89 54 24 08          	mov    %edx,0x8(%esp)
80106e61:	89 4c 24 04          	mov    %ecx,0x4(%esp)
80106e65:	89 04 24             	mov    %eax,(%esp)
80106e68:	e8 b7 f1 ff ff       	call   80106024 <fetchint>
80106e6d:	85 c0                	test   %eax,%eax
80106e6f:	79 07                	jns    80106e78 <sys_exec+0xb3>
      return -1;
80106e71:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106e76:	eb 73                	jmp    80106eeb <sys_exec+0x126>
    if(uarg == 0){
80106e78:	8b 85 68 ff ff ff    	mov    -0x98(%ebp),%eax
80106e7e:	85 c0                	test   %eax,%eax
80106e80:	75 26                	jne    80106ea8 <sys_exec+0xe3>
      argv[i] = 0;
80106e82:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106e85:	c7 84 85 70 ff ff ff 	movl   $0x0,-0x90(%ebp,%eax,4)
80106e8c:	00 00 00 00 
      break;
80106e90:	90                   	nop
    }
    if(fetchstr(proc, uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
80106e91:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106e94:	8d 95 70 ff ff ff    	lea    -0x90(%ebp),%edx
80106e9a:	89 54 24 04          	mov    %edx,0x4(%esp)
80106e9e:	89 04 24             	mov    %eax,(%esp)
80106ea1:	e8 d6 a2 ff ff       	call   8010117c <exec>
80106ea6:	eb 43                	jmp    80106eeb <sys_exec+0x126>
      return -1;
    if(uarg == 0){
      argv[i] = 0;
      break;
    }
    if(fetchstr(proc, uarg, &argv[i]) < 0)
80106ea8:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106eab:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80106eb2:	8d 85 70 ff ff ff    	lea    -0x90(%ebp),%eax
80106eb8:	8d 0c 10             	lea    (%eax,%edx,1),%ecx
80106ebb:	8b 95 68 ff ff ff    	mov    -0x98(%ebp),%edx
80106ec1:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106ec7:	89 4c 24 08          	mov    %ecx,0x8(%esp)
80106ecb:	89 54 24 04          	mov    %edx,0x4(%esp)
80106ecf:	89 04 24             	mov    %eax,(%esp)
80106ed2:	e8 81 f1 ff ff       	call   80106058 <fetchstr>
80106ed7:	85 c0                	test   %eax,%eax
80106ed9:	79 07                	jns    80106ee2 <sys_exec+0x11d>
      return -1;
80106edb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106ee0:	eb 09                	jmp    80106eeb <sys_exec+0x126>

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
    return -1;
  }
  memset(argv, 0, sizeof(argv));
  for(i=0;; i++){
80106ee2:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      argv[i] = 0;
      break;
    }
    if(fetchstr(proc, uarg, &argv[i]) < 0)
      return -1;
  }
80106ee6:	e9 43 ff ff ff       	jmp    80106e2e <sys_exec+0x69>
  return exec(path, argv);
}
80106eeb:	c9                   	leave  
80106eec:	c3                   	ret    

80106eed <sys_pipe>:

int
sys_pipe(void)
{
80106eed:	55                   	push   %ebp
80106eee:	89 e5                	mov    %esp,%ebp
80106ef0:	83 ec 38             	sub    $0x38,%esp
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80106ef3:	c7 44 24 08 08 00 00 	movl   $0x8,0x8(%esp)
80106efa:	00 
80106efb:	8d 45 ec             	lea    -0x14(%ebp),%eax
80106efe:	89 44 24 04          	mov    %eax,0x4(%esp)
80106f02:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106f09:	e8 e0 f1 ff ff       	call   801060ee <argptr>
80106f0e:	85 c0                	test   %eax,%eax
80106f10:	79 0a                	jns    80106f1c <sys_pipe+0x2f>
    return -1;
80106f12:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106f17:	e9 9b 00 00 00       	jmp    80106fb7 <sys_pipe+0xca>
  if(pipealloc(&rf, &wf) < 0)
80106f1c:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80106f1f:	89 44 24 04          	mov    %eax,0x4(%esp)
80106f23:	8d 45 e8             	lea    -0x18(%ebp),%eax
80106f26:	89 04 24             	mov    %eax,(%esp)
80106f29:	e8 5e d4 ff ff       	call   8010438c <pipealloc>
80106f2e:	85 c0                	test   %eax,%eax
80106f30:	79 07                	jns    80106f39 <sys_pipe+0x4c>
    return -1;
80106f32:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106f37:	eb 7e                	jmp    80106fb7 <sys_pipe+0xca>
  fd0 = -1;
80106f39:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%ebp)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80106f40:	8b 45 e8             	mov    -0x18(%ebp),%eax
80106f43:	89 04 24             	mov    %eax,(%esp)
80106f46:	e8 82 f3 ff ff       	call   801062cd <fdalloc>
80106f4b:	89 45 f4             	mov    %eax,-0xc(%ebp)
80106f4e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80106f52:	78 14                	js     80106f68 <sys_pipe+0x7b>
80106f54:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106f57:	89 04 24             	mov    %eax,(%esp)
80106f5a:	e8 6e f3 ff ff       	call   801062cd <fdalloc>
80106f5f:	89 45 f0             	mov    %eax,-0x10(%ebp)
80106f62:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80106f66:	79 37                	jns    80106f9f <sys_pipe+0xb2>
    if(fd0 >= 0)
80106f68:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80106f6c:	78 14                	js     80106f82 <sys_pipe+0x95>
      proc->ofile[fd0] = 0;
80106f6e:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106f74:	8b 55 f4             	mov    -0xc(%ebp),%edx
80106f77:	83 c2 08             	add    $0x8,%edx
80106f7a:	c7 44 90 08 00 00 00 	movl   $0x0,0x8(%eax,%edx,4)
80106f81:	00 
    fileclose(rf);
80106f82:	8b 45 e8             	mov    -0x18(%ebp),%eax
80106f85:	89 04 24             	mov    %eax,(%esp)
80106f88:	e8 8b a7 ff ff       	call   80101718 <fileclose>
    fileclose(wf);
80106f8d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106f90:	89 04 24             	mov    %eax,(%esp)
80106f93:	e8 80 a7 ff ff       	call   80101718 <fileclose>
    return -1;
80106f98:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106f9d:	eb 18                	jmp    80106fb7 <sys_pipe+0xca>
  }
  fd[0] = fd0;
80106f9f:	8b 45 ec             	mov    -0x14(%ebp),%eax
80106fa2:	8b 55 f4             	mov    -0xc(%ebp),%edx
80106fa5:	89 10                	mov    %edx,(%eax)
  fd[1] = fd1;
80106fa7:	8b 45 ec             	mov    -0x14(%ebp),%eax
80106faa:	8d 50 04             	lea    0x4(%eax),%edx
80106fad:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106fb0:	89 02                	mov    %eax,(%edx)
  return 0;
80106fb2:	b8 00 00 00 00       	mov    $0x0,%eax
}
80106fb7:	c9                   	leave  
80106fb8:	c3                   	ret    
80106fb9:	00 00                	add    %al,(%eax)
	...

80106fbc <sys_fork>:
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
80106fbc:	55                   	push   %ebp
80106fbd:	89 e5                	mov    %esp,%ebp
80106fbf:	83 ec 08             	sub    $0x8,%esp
  return fork();
80106fc2:	e8 c5 dd ff ff       	call   80104d8c <fork>
}
80106fc7:	c9                   	leave  
80106fc8:	c3                   	ret    

80106fc9 <sys_exit>:

int
sys_exit(void)
{
80106fc9:	55                   	push   %ebp
80106fca:	89 e5                	mov    %esp,%ebp
80106fcc:	83 ec 08             	sub    $0x8,%esp
  exit();
80106fcf:	e8 5d df ff ff       	call   80104f31 <exit>
  return 0;  // not reached
80106fd4:	b8 00 00 00 00       	mov    $0x0,%eax
}
80106fd9:	c9                   	leave  
80106fda:	c3                   	ret    

80106fdb <sys_wait>:

int
sys_wait(void)
{
80106fdb:	55                   	push   %ebp
80106fdc:	89 e5                	mov    %esp,%ebp
80106fde:	83 ec 08             	sub    $0x8,%esp
  return wait();
80106fe1:	e8 8f e0 ff ff       	call   80105075 <wait>
}
80106fe6:	c9                   	leave  
80106fe7:	c3                   	ret    

80106fe8 <sys_kill>:

int
sys_kill(void)
{
80106fe8:	55                   	push   %ebp
80106fe9:	89 e5                	mov    %esp,%ebp
80106feb:	83 ec 28             	sub    $0x28,%esp
  int pid;

  if(argint(0, &pid) < 0)
80106fee:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106ff1:	89 44 24 04          	mov    %eax,0x4(%esp)
80106ff5:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106ffc:	e8 b5 f0 ff ff       	call   801060b6 <argint>
80107001:	85 c0                	test   %eax,%eax
80107003:	79 07                	jns    8010700c <sys_kill+0x24>
    return -1;
80107005:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010700a:	eb 0b                	jmp    80107017 <sys_kill+0x2f>
  return kill(pid);
8010700c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010700f:	89 04 24             	mov    %eax,(%esp)
80107012:	e8 2b e7 ff ff       	call   80105742 <kill>
}
80107017:	c9                   	leave  
80107018:	c3                   	ret    

80107019 <sys_getpid>:

int
sys_getpid(void)
{
80107019:	55                   	push   %ebp
8010701a:	89 e5                	mov    %esp,%ebp
  return proc->pid;
8010701c:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80107022:	8b 40 10             	mov    0x10(%eax),%eax
}
80107025:	5d                   	pop    %ebp
80107026:	c3                   	ret    

80107027 <sys_sbrk>:

int
sys_sbrk(void)
{
80107027:	55                   	push   %ebp
80107028:	89 e5                	mov    %esp,%ebp
8010702a:	83 ec 28             	sub    $0x28,%esp
  int addr;
  int n;

  if(argint(0, &n) < 0)
8010702d:	8d 45 f0             	lea    -0x10(%ebp),%eax
80107030:	89 44 24 04          	mov    %eax,0x4(%esp)
80107034:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
8010703b:	e8 76 f0 ff ff       	call   801060b6 <argint>
80107040:	85 c0                	test   %eax,%eax
80107042:	79 07                	jns    8010704b <sys_sbrk+0x24>
    return -1;
80107044:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107049:	eb 24                	jmp    8010706f <sys_sbrk+0x48>
  addr = proc->sz;
8010704b:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80107051:	8b 00                	mov    (%eax),%eax
80107053:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(growproc(n) < 0)
80107056:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107059:	89 04 24             	mov    %eax,(%esp)
8010705c:	e8 86 dc ff ff       	call   80104ce7 <growproc>
80107061:	85 c0                	test   %eax,%eax
80107063:	79 07                	jns    8010706c <sys_sbrk+0x45>
    return -1;
80107065:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010706a:	eb 03                	jmp    8010706f <sys_sbrk+0x48>
  return addr;
8010706c:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
8010706f:	c9                   	leave  
80107070:	c3                   	ret    

80107071 <sys_sleep>:

int
sys_sleep(void)
{
80107071:	55                   	push   %ebp
80107072:	89 e5                	mov    %esp,%ebp
80107074:	83 ec 28             	sub    $0x28,%esp
  int n;
  uint ticks0;
  
  if(argint(0, &n) < 0)
80107077:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010707a:	89 44 24 04          	mov    %eax,0x4(%esp)
8010707e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80107085:	e8 2c f0 ff ff       	call   801060b6 <argint>
8010708a:	85 c0                	test   %eax,%eax
8010708c:	79 07                	jns    80107095 <sys_sleep+0x24>
    return -1;
8010708e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107093:	eb 6c                	jmp    80107101 <sys_sleep+0x90>
  acquire(&tickslock);
80107095:	c7 04 24 20 6a 11 80 	movl   $0x80116a20,(%esp)
8010709c:	e8 16 ea ff ff       	call   80105ab7 <acquire>
  ticks0 = ticks;
801070a1:	a1 60 72 11 80       	mov    0x80117260,%eax
801070a6:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(ticks - ticks0 < n){
801070a9:	eb 34                	jmp    801070df <sys_sleep+0x6e>
    if(proc->killed){
801070ab:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801070b1:	8b 40 24             	mov    0x24(%eax),%eax
801070b4:	85 c0                	test   %eax,%eax
801070b6:	74 13                	je     801070cb <sys_sleep+0x5a>
      release(&tickslock);
801070b8:	c7 04 24 20 6a 11 80 	movl   $0x80116a20,(%esp)
801070bf:	e8 55 ea ff ff       	call   80105b19 <release>
      return -1;
801070c4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801070c9:	eb 36                	jmp    80107101 <sys_sleep+0x90>
    }
    sleep(&ticks, &tickslock);
801070cb:	c7 44 24 04 20 6a 11 	movl   $0x80116a20,0x4(%esp)
801070d2:	80 
801070d3:	c7 04 24 60 72 11 80 	movl   $0x80117260,(%esp)
801070da:	e8 4a e5 ff ff       	call   80105629 <sleep>
  
  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
801070df:	a1 60 72 11 80       	mov    0x80117260,%eax
801070e4:	89 c2                	mov    %eax,%edx
801070e6:	2b 55 f4             	sub    -0xc(%ebp),%edx
801070e9:	8b 45 f0             	mov    -0x10(%ebp),%eax
801070ec:	39 c2                	cmp    %eax,%edx
801070ee:	72 bb                	jb     801070ab <sys_sleep+0x3a>
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
801070f0:	c7 04 24 20 6a 11 80 	movl   $0x80116a20,(%esp)
801070f7:	e8 1d ea ff ff       	call   80105b19 <release>
  return 0;
801070fc:	b8 00 00 00 00       	mov    $0x0,%eax
}
80107101:	c9                   	leave  
80107102:	c3                   	ret    

80107103 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
80107103:	55                   	push   %ebp
80107104:	89 e5                	mov    %esp,%ebp
80107106:	83 ec 28             	sub    $0x28,%esp
  uint xticks;
  
  acquire(&tickslock);
80107109:	c7 04 24 20 6a 11 80 	movl   $0x80116a20,(%esp)
80107110:	e8 a2 e9 ff ff       	call   80105ab7 <acquire>
  xticks = ticks;
80107115:	a1 60 72 11 80       	mov    0x80117260,%eax
8010711a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  release(&tickslock);
8010711d:	c7 04 24 20 6a 11 80 	movl   $0x80116a20,(%esp)
80107124:	e8 f0 e9 ff ff       	call   80105b19 <release>
  return xticks;
80107129:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
8010712c:	c9                   	leave  
8010712d:	c3                   	ret    

8010712e <sys_add_path>:

// add a path to the pathvariable in exec.c
int
sys_add_path(void)
{
8010712e:	55                   	push   %ebp
8010712f:	89 e5                	mov    %esp,%ebp
80107131:	83 ec 28             	sub    $0x28,%esp
  char *path;
    if(argstr(0, &path) < 0){
80107134:	8d 45 f4             	lea    -0xc(%ebp),%eax
80107137:	89 44 24 04          	mov    %eax,0x4(%esp)
8010713b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80107142:	e8 09 f0 ff ff       	call   80106150 <argstr>
80107147:	85 c0                	test   %eax,%eax
80107149:	79 07                	jns    80107152 <sys_add_path+0x24>
      return -1;
8010714b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107150:	eb 10                	jmp    80107162 <sys_add_path+0x34>
    }
else{
  definition_add_path(path);
80107152:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107155:	89 04 24             	mov    %eax,(%esp)
80107158:	e8 9c a4 ff ff       	call   801015f9 <definition_add_path>
  }
  return 0;  
8010715d:	b8 00 00 00 00       	mov    $0x0,%eax
}
80107162:	c9                   	leave  
80107163:	c3                   	ret    

80107164 <sys_wait2>:
 
int
sys_wait2(void)
{
80107164:	55                   	push   %ebp
80107165:	89 e5                	mov    %esp,%ebp
80107167:	83 ec 28             	sub    $0x28,%esp
  int wtime;
  int rtime;
  int iotime;
  if(argint(0, &wtime) < 0){
8010716a:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010716d:	89 44 24 04          	mov    %eax,0x4(%esp)
80107171:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80107178:	e8 39 ef ff ff       	call   801060b6 <argint>
8010717d:	85 c0                	test   %eax,%eax
8010717f:	79 07                	jns    80107188 <sys_wait2+0x24>
      return -1;
80107181:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107186:	eb 59                	jmp    801071e1 <sys_wait2+0x7d>
    }
    if(argint(1, &rtime) < 0){
80107188:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010718b:	89 44 24 04          	mov    %eax,0x4(%esp)
8010718f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80107196:	e8 1b ef ff ff       	call   801060b6 <argint>
8010719b:	85 c0                	test   %eax,%eax
8010719d:	79 07                	jns    801071a6 <sys_wait2+0x42>
      return -1;
8010719f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801071a4:	eb 3b                	jmp    801071e1 <sys_wait2+0x7d>
    }
    if(argint(2, &iotime) < 0){
801071a6:	8d 45 ec             	lea    -0x14(%ebp),%eax
801071a9:	89 44 24 04          	mov    %eax,0x4(%esp)
801071ad:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
801071b4:	e8 fd ee ff ff       	call   801060b6 <argint>
801071b9:	85 c0                	test   %eax,%eax
801071bb:	79 07                	jns    801071c4 <sys_wait2+0x60>
      return -1;
801071bd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801071c2:	eb 1d                	jmp    801071e1 <sys_wait2+0x7d>
    }
return wait2((int *)wtime,(int *)rtime,(int *)iotime);
801071c4:	8b 45 ec             	mov    -0x14(%ebp),%eax
801071c7:	89 c1                	mov    %eax,%ecx
801071c9:	8b 45 f0             	mov    -0x10(%ebp),%eax
801071cc:	89 c2                	mov    %eax,%edx
801071ce:	8b 45 f4             	mov    -0xc(%ebp),%eax
801071d1:	89 4c 24 08          	mov    %ecx,0x8(%esp)
801071d5:	89 54 24 04          	mov    %edx,0x4(%esp)
801071d9:	89 04 24             	mov    %eax,(%esp)
801071dc:	e8 bd df ff ff       	call   8010519e <wait2>

}
801071e1:	c9                   	leave  
801071e2:	c3                   	ret    

801071e3 <sys_getquanta>:

int
sys_getquanta(void)
{
801071e3:	55                   	push   %ebp
801071e4:	89 e5                	mov    %esp,%ebp
801071e6:	83 ec 08             	sub    $0x8,%esp
return getquanta();
801071e9:	e8 bd d5 ff ff       	call   801047ab <getquanta>
}
801071ee:	c9                   	leave  
801071ef:	c3                   	ret    

801071f0 <sys_getqueue>:

int
sys_getqueue(void)
{ 
801071f0:	55                   	push   %ebp
801071f1:	89 e5                	mov    %esp,%ebp
801071f3:	83 ec 08             	sub    $0x8,%esp
return getqueue();
801071f6:	e8 c1 d5 ff ff       	call   801047bc <getqueue>
}
801071fb:	c9                   	leave  
801071fc:	c3                   	ret    

801071fd <sys_signal>:

int
sys_signal(void)
{
801071fd:	55                   	push   %ebp
801071fe:	89 e5                	mov    %esp,%ebp
80107200:	83 ec 28             	sub    $0x28,%esp
  int handler;
  int signum;
  
  if(argint(0, &signum) < 0){
80107203:	8d 45 f0             	lea    -0x10(%ebp),%eax
80107206:	89 44 24 04          	mov    %eax,0x4(%esp)
8010720a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80107211:	e8 a0 ee ff ff       	call   801060b6 <argint>
80107216:	85 c0                	test   %eax,%eax
80107218:	79 16                	jns    80107230 <sys_signal+0x33>
    cprintf("err1\n");
8010721a:	c7 04 24 e0 98 10 80 	movl   $0x801098e0,(%esp)
80107221:	e8 7b 91 ff ff       	call   801003a1 <cprintf>
    return -1;
80107226:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010722b:	e9 81 00 00 00       	jmp    801072b1 <sys_signal+0xb4>
  }
  if(argint(1, &handler) < 0){
80107230:	8d 45 f4             	lea    -0xc(%ebp),%eax
80107233:	89 44 24 04          	mov    %eax,0x4(%esp)
80107237:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
8010723e:	e8 73 ee ff ff       	call   801060b6 <argint>
80107243:	85 c0                	test   %eax,%eax
80107245:	79 13                	jns    8010725a <sys_signal+0x5d>
    cprintf("err2\n");
80107247:	c7 04 24 e6 98 10 80 	movl   $0x801098e6,(%esp)
8010724e:	e8 4e 91 ff ff       	call   801003a1 <cprintf>
    return -1;
80107253:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107258:	eb 57                	jmp    801072b1 <sys_signal+0xb4>
  }
  if(signum < 0 || signum >= NUMSIG)
8010725a:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010725d:	85 c0                	test   %eax,%eax
8010725f:	78 08                	js     80107269 <sys_signal+0x6c>
80107261:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107264:	83 f8 1f             	cmp    $0x1f,%eax
80107267:	7e 13                	jle    8010727c <sys_signal+0x7f>
  {
    cprintf("err3\n");
80107269:	c7 04 24 ec 98 10 80 	movl   $0x801098ec,(%esp)
80107270:	e8 2c 91 ff ff       	call   801003a1 <cprintf>
    return -1;
80107275:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010727a:	eb 35                	jmp    801072b1 <sys_signal+0xb4>
  }
  cprintf("registering signal %d as handler %d\n",signum,handler);
8010727c:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010727f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107282:	89 54 24 08          	mov    %edx,0x8(%esp)
80107286:	89 44 24 04          	mov    %eax,0x4(%esp)
8010728a:	c7 04 24 f4 98 10 80 	movl   $0x801098f4,(%esp)
80107291:	e8 0b 91 ff ff       	call   801003a1 <cprintf>
  
  proc->handlers[signum-1]=(sighandler_t)handler;
80107296:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010729c:	8b 55 f0             	mov    -0x10(%ebp),%edx
8010729f:	8d 4a ff             	lea    -0x1(%edx),%ecx
801072a2:	8b 55 f4             	mov    -0xc(%ebp),%edx
801072a5:	83 c1 24             	add    $0x24,%ecx
801072a8:	89 54 88 0c          	mov    %edx,0xc(%eax,%ecx,4)

  return 0;
801072ac:	b8 00 00 00 00       	mov    $0x0,%eax
}
801072b1:	c9                   	leave  
801072b2:	c3                   	ret    

801072b3 <sys_sigsend>:

int
sys_sigsend(void)
{
801072b3:	55                   	push   %ebp
801072b4:	89 e5                	mov    %esp,%ebp
801072b6:	83 ec 28             	sub    $0x28,%esp
  int pid;
  int signum;

  if(argint(0, &pid) < 0){
801072b9:	8d 45 f4             	lea    -0xc(%ebp),%eax
801072bc:	89 44 24 04          	mov    %eax,0x4(%esp)
801072c0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801072c7:	e8 ea ed ff ff       	call   801060b6 <argint>
801072cc:	85 c0                	test   %eax,%eax
801072ce:	79 13                	jns    801072e3 <sys_sigsend+0x30>
    cprintf("err1\n");
801072d0:	c7 04 24 e0 98 10 80 	movl   $0x801098e0,(%esp)
801072d7:	e8 c5 90 ff ff       	call   801003a1 <cprintf>
    return -1;
801072dc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801072e1:	eb 64                	jmp    80107347 <sys_sigsend+0x94>
  }
  if(argint(1, &signum) < 0){
801072e3:	8d 45 f0             	lea    -0x10(%ebp),%eax
801072e6:	89 44 24 04          	mov    %eax,0x4(%esp)
801072ea:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801072f1:	e8 c0 ed ff ff       	call   801060b6 <argint>
801072f6:	85 c0                	test   %eax,%eax
801072f8:	79 13                	jns    8010730d <sys_sigsend+0x5a>
    cprintf("err2\n");
801072fa:	c7 04 24 e6 98 10 80 	movl   $0x801098e6,(%esp)
80107301:	e8 9b 90 ff ff       	call   801003a1 <cprintf>
    return -1;
80107306:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010730b:	eb 3a                	jmp    80107347 <sys_sigsend+0x94>
  }
  if(signum < 0 || signum >= NUMSIG)
8010730d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107310:	85 c0                	test   %eax,%eax
80107312:	78 08                	js     8010731c <sys_sigsend+0x69>
80107314:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107317:	83 f8 1f             	cmp    $0x1f,%eax
8010731a:	7e 13                	jle    8010732f <sys_sigsend+0x7c>
  {
    cprintf("err3\n");
8010731c:	c7 04 24 ec 98 10 80 	movl   $0x801098ec,(%esp)
80107323:	e8 79 90 ff ff       	call   801003a1 <cprintf>
    return -1;
80107328:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010732d:	eb 18                	jmp    80107347 <sys_sigsend+0x94>
  }
pid = handle_sigsend(pid,signum);
8010732f:	8b 55 f0             	mov    -0x10(%ebp),%edx
80107332:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107335:	89 54 24 04          	mov    %edx,0x4(%esp)
80107339:	89 04 24             	mov    %eax,(%esp)
8010733c:	e8 85 e4 ff ff       	call   801057c6 <handle_sigsend>
80107341:	89 45 f4             	mov    %eax,-0xc(%ebp)
  return pid;
80107344:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80107347:	c9                   	leave  
80107348:	c3                   	ret    

80107349 <sys_alarm>:

int 
sys_alarm(void)
{
80107349:	55                   	push   %ebp
8010734a:	89 e5                	mov    %esp,%ebp
8010734c:	83 ec 28             	sub    $0x28,%esp
  int alarm_time;
  if(argint(0, &alarm_time) < 0){
8010734f:	8d 45 f4             	lea    -0xc(%ebp),%eax
80107352:	89 44 24 04          	mov    %eax,0x4(%esp)
80107356:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
8010735d:	e8 54 ed ff ff       	call   801060b6 <argint>
80107362:	85 c0                	test   %eax,%eax
80107364:	79 07                	jns    8010736d <sys_alarm+0x24>

    return -1;
80107366:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010736b:	eb 4c                	jmp    801073b9 <sys_alarm+0x70>
  }
  if (alarm_time<0)
8010736d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107370:	85 c0                	test   %eax,%eax
80107372:	79 07                	jns    8010737b <sys_alarm+0x32>
  {
    return -1;
80107374:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107379:	eb 3e                	jmp    801073b9 <sys_alarm+0x70>
  }
  if (alarm_time==0)
8010737b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010737e:	85 c0                	test   %eax,%eax
80107380:	75 23                	jne    801073a5 <sys_alarm+0x5c>
  {
    proc->pending = proc-> pending & ~(1 << (SIGALRM-1));
80107382:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80107388:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
8010738f:	8b 92 98 00 00 00    	mov    0x98(%edx),%edx
80107395:	80 e6 df             	and    $0xdf,%dh
80107398:	89 90 98 00 00 00    	mov    %edx,0x98(%eax)
    return -1;
8010739e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801073a3:	eb 14                	jmp    801073b9 <sys_alarm+0x70>
  }
  
  //proc->pending = proc-> pending | (1 << SIGALRM);
  proc->alarm = alarm_time;
801073a5:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801073ab:	8b 55 f4             	mov    -0xc(%ebp),%edx
801073ae:	89 90 1c 01 00 00    	mov    %edx,0x11c(%eax)
  return 0;
801073b4:	b8 00 00 00 00       	mov    $0x0,%eax

801073b9:	c9                   	leave  
801073ba:	c3                   	ret    
	...

801073bc <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
801073bc:	55                   	push   %ebp
801073bd:	89 e5                	mov    %esp,%ebp
801073bf:	83 ec 08             	sub    $0x8,%esp
801073c2:	8b 55 08             	mov    0x8(%ebp),%edx
801073c5:	8b 45 0c             	mov    0xc(%ebp),%eax
801073c8:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
801073cc:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801073cf:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
801073d3:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
801073d7:	ee                   	out    %al,(%dx)
}
801073d8:	c9                   	leave  
801073d9:	c3                   	ret    

801073da <timerinit>:
#define TIMER_RATEGEN   0x04    // mode 2, rate generator
#define TIMER_16BIT     0x30    // r/w counter 16 bits, LSB first

void
timerinit(void)
{
801073da:	55                   	push   %ebp
801073db:	89 e5                	mov    %esp,%ebp
801073dd:	83 ec 18             	sub    $0x18,%esp
  // Interrupt 100 times/sec.
  outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
801073e0:	c7 44 24 04 34 00 00 	movl   $0x34,0x4(%esp)
801073e7:	00 
801073e8:	c7 04 24 43 00 00 00 	movl   $0x43,(%esp)
801073ef:	e8 c8 ff ff ff       	call   801073bc <outb>
  outb(IO_TIMER1, TIMER_DIV(100) % 256);
801073f4:	c7 44 24 04 9c 00 00 	movl   $0x9c,0x4(%esp)
801073fb:	00 
801073fc:	c7 04 24 40 00 00 00 	movl   $0x40,(%esp)
80107403:	e8 b4 ff ff ff       	call   801073bc <outb>
  outb(IO_TIMER1, TIMER_DIV(100) / 256);
80107408:	c7 44 24 04 2e 00 00 	movl   $0x2e,0x4(%esp)
8010740f:	00 
80107410:	c7 04 24 40 00 00 00 	movl   $0x40,(%esp)
80107417:	e8 a0 ff ff ff       	call   801073bc <outb>
  picenable(IRQ_TIMER);
8010741c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80107423:	e8 ed cd ff ff       	call   80104215 <picenable>
}
80107428:	c9                   	leave  
80107429:	c3                   	ret    
	...

8010742c <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
8010742c:	1e                   	push   %ds
  pushl %es
8010742d:	06                   	push   %es
  pushl %fs
8010742e:	0f a0                	push   %fs
  pushl %gs
80107430:	0f a8                	push   %gs
  pushal
80107432:	60                   	pusha  
  
  # Set up data and per-cpu segments.
  movw $(SEG_KDATA<<3), %ax
80107433:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
80107437:	8e d8                	mov    %eax,%ds
  movw %ax, %es
80107439:	8e c0                	mov    %eax,%es
  movw $(SEG_KCPU<<3), %ax
8010743b:	66 b8 18 00          	mov    $0x18,%ax
  movw %ax, %fs
8010743f:	8e e0                	mov    %eax,%fs
  movw %ax, %gs
80107441:	8e e8                	mov    %eax,%gs

  # Call trap(tf), where tf=%esp
  pushl %esp
80107443:	54                   	push   %esp
  call trap
80107444:	e8 de 01 00 00       	call   80107627 <trap>
  addl $4, %esp
80107449:	83 c4 04             	add    $0x4,%esp

8010744c <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
8010744c:	61                   	popa   
  popl %gs
8010744d:	0f a9                	pop    %gs
  popl %fs
8010744f:	0f a1                	pop    %fs
  popl %es
80107451:	07                   	pop    %es
  popl %ds
80107452:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
80107453:	83 c4 08             	add    $0x8,%esp
  iret
80107456:	cf                   	iret   
	...

80107458 <lidt>:

struct gatedesc;

static inline void
lidt(struct gatedesc *p, int size)
{
80107458:	55                   	push   %ebp
80107459:	89 e5                	mov    %esp,%ebp
8010745b:	83 ec 10             	sub    $0x10,%esp
  volatile ushort pd[3];

  pd[0] = size-1;
8010745e:	8b 45 0c             	mov    0xc(%ebp),%eax
80107461:	83 e8 01             	sub    $0x1,%eax
80107464:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
80107468:	8b 45 08             	mov    0x8(%ebp),%eax
8010746b:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
8010746f:	8b 45 08             	mov    0x8(%ebp),%eax
80107472:	c1 e8 10             	shr    $0x10,%eax
80107475:	66 89 45 fe          	mov    %ax,-0x2(%ebp)

  asm volatile("lidt (%0)" : : "r" (pd));
80107479:	8d 45 fa             	lea    -0x6(%ebp),%eax
8010747c:	0f 01 18             	lidtl  (%eax)
}
8010747f:	c9                   	leave  
80107480:	c3                   	ret    

80107481 <rcr2>:
  return result;
}

static inline uint
rcr2(void)
{
80107481:	55                   	push   %ebp
80107482:	89 e5                	mov    %esp,%ebp
80107484:	53                   	push   %ebx
80107485:	83 ec 10             	sub    $0x10,%esp
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
80107488:	0f 20 d3             	mov    %cr2,%ebx
8010748b:	89 5d f8             	mov    %ebx,-0x8(%ebp)
  return val;
8010748e:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
80107491:	83 c4 10             	add    $0x10,%esp
80107494:	5b                   	pop    %ebx
80107495:	5d                   	pop    %ebp
80107496:	c3                   	ret    

80107497 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80107497:	55                   	push   %ebp
80107498:	89 e5                	mov    %esp,%ebp
8010749a:	83 ec 28             	sub    $0x28,%esp
  int i;

  for(i = 0; i < 256; i++)
8010749d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801074a4:	e9 c3 00 00 00       	jmp    8010756c <tvinit+0xd5>
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
801074a9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801074ac:	8b 04 85 b4 c0 10 80 	mov    -0x7fef3f4c(,%eax,4),%eax
801074b3:	89 c2                	mov    %eax,%edx
801074b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801074b8:	66 89 14 c5 60 6a 11 	mov    %dx,-0x7fee95a0(,%eax,8)
801074bf:	80 
801074c0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801074c3:	66 c7 04 c5 62 6a 11 	movw   $0x8,-0x7fee959e(,%eax,8)
801074ca:	80 08 00 
801074cd:	8b 45 f4             	mov    -0xc(%ebp),%eax
801074d0:	0f b6 14 c5 64 6a 11 	movzbl -0x7fee959c(,%eax,8),%edx
801074d7:	80 
801074d8:	83 e2 e0             	and    $0xffffffe0,%edx
801074db:	88 14 c5 64 6a 11 80 	mov    %dl,-0x7fee959c(,%eax,8)
801074e2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801074e5:	0f b6 14 c5 64 6a 11 	movzbl -0x7fee959c(,%eax,8),%edx
801074ec:	80 
801074ed:	83 e2 1f             	and    $0x1f,%edx
801074f0:	88 14 c5 64 6a 11 80 	mov    %dl,-0x7fee959c(,%eax,8)
801074f7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801074fa:	0f b6 14 c5 65 6a 11 	movzbl -0x7fee959b(,%eax,8),%edx
80107501:	80 
80107502:	83 e2 f0             	and    $0xfffffff0,%edx
80107505:	83 ca 0e             	or     $0xe,%edx
80107508:	88 14 c5 65 6a 11 80 	mov    %dl,-0x7fee959b(,%eax,8)
8010750f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107512:	0f b6 14 c5 65 6a 11 	movzbl -0x7fee959b(,%eax,8),%edx
80107519:	80 
8010751a:	83 e2 ef             	and    $0xffffffef,%edx
8010751d:	88 14 c5 65 6a 11 80 	mov    %dl,-0x7fee959b(,%eax,8)
80107524:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107527:	0f b6 14 c5 65 6a 11 	movzbl -0x7fee959b(,%eax,8),%edx
8010752e:	80 
8010752f:	83 e2 9f             	and    $0xffffff9f,%edx
80107532:	88 14 c5 65 6a 11 80 	mov    %dl,-0x7fee959b(,%eax,8)
80107539:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010753c:	0f b6 14 c5 65 6a 11 	movzbl -0x7fee959b(,%eax,8),%edx
80107543:	80 
80107544:	83 ca 80             	or     $0xffffff80,%edx
80107547:	88 14 c5 65 6a 11 80 	mov    %dl,-0x7fee959b(,%eax,8)
8010754e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107551:	8b 04 85 b4 c0 10 80 	mov    -0x7fef3f4c(,%eax,4),%eax
80107558:	c1 e8 10             	shr    $0x10,%eax
8010755b:	89 c2                	mov    %eax,%edx
8010755d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107560:	66 89 14 c5 66 6a 11 	mov    %dx,-0x7fee959a(,%eax,8)
80107567:	80 
void
tvinit(void)
{
  int i;

  for(i = 0; i < 256; i++)
80107568:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
8010756c:	81 7d f4 ff 00 00 00 	cmpl   $0xff,-0xc(%ebp)
80107573:	0f 8e 30 ff ff ff    	jle    801074a9 <tvinit+0x12>
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80107579:	a1 b4 c1 10 80       	mov    0x8010c1b4,%eax
8010757e:	66 a3 60 6c 11 80    	mov    %ax,0x80116c60
80107584:	66 c7 05 62 6c 11 80 	movw   $0x8,0x80116c62
8010758b:	08 00 
8010758d:	0f b6 05 64 6c 11 80 	movzbl 0x80116c64,%eax
80107594:	83 e0 e0             	and    $0xffffffe0,%eax
80107597:	a2 64 6c 11 80       	mov    %al,0x80116c64
8010759c:	0f b6 05 64 6c 11 80 	movzbl 0x80116c64,%eax
801075a3:	83 e0 1f             	and    $0x1f,%eax
801075a6:	a2 64 6c 11 80       	mov    %al,0x80116c64
801075ab:	0f b6 05 65 6c 11 80 	movzbl 0x80116c65,%eax
801075b2:	83 c8 0f             	or     $0xf,%eax
801075b5:	a2 65 6c 11 80       	mov    %al,0x80116c65
801075ba:	0f b6 05 65 6c 11 80 	movzbl 0x80116c65,%eax
801075c1:	83 e0 ef             	and    $0xffffffef,%eax
801075c4:	a2 65 6c 11 80       	mov    %al,0x80116c65
801075c9:	0f b6 05 65 6c 11 80 	movzbl 0x80116c65,%eax
801075d0:	83 c8 60             	or     $0x60,%eax
801075d3:	a2 65 6c 11 80       	mov    %al,0x80116c65
801075d8:	0f b6 05 65 6c 11 80 	movzbl 0x80116c65,%eax
801075df:	83 c8 80             	or     $0xffffff80,%eax
801075e2:	a2 65 6c 11 80       	mov    %al,0x80116c65
801075e7:	a1 b4 c1 10 80       	mov    0x8010c1b4,%eax
801075ec:	c1 e8 10             	shr    $0x10,%eax
801075ef:	66 a3 66 6c 11 80    	mov    %ax,0x80116c66
  
  initlock(&tickslock, "time");
801075f5:	c7 44 24 04 1c 99 10 	movl   $0x8010991c,0x4(%esp)
801075fc:	80 
801075fd:	c7 04 24 20 6a 11 80 	movl   $0x80116a20,(%esp)
80107604:	e8 8d e4 ff ff       	call   80105a96 <initlock>
}
80107609:	c9                   	leave  
8010760a:	c3                   	ret    

8010760b <idtinit>:

void
idtinit(void)
{
8010760b:	55                   	push   %ebp
8010760c:	89 e5                	mov    %esp,%ebp
8010760e:	83 ec 08             	sub    $0x8,%esp
  lidt(idt, sizeof(idt));
80107611:	c7 44 24 04 00 08 00 	movl   $0x800,0x4(%esp)
80107618:	00 
80107619:	c7 04 24 60 6a 11 80 	movl   $0x80116a60,(%esp)
80107620:	e8 33 fe ff ff       	call   80107458 <lidt>
}
80107625:	c9                   	leave  
80107626:	c3                   	ret    

80107627 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80107627:	55                   	push   %ebp
80107628:	89 e5                	mov    %esp,%ebp
8010762a:	57                   	push   %edi
8010762b:	56                   	push   %esi
8010762c:	53                   	push   %ebx
8010762d:	83 ec 3c             	sub    $0x3c,%esp
  
  if(tf->trapno == T_SYSCALL){
80107630:	8b 45 08             	mov    0x8(%ebp),%eax
80107633:	8b 40 30             	mov    0x30(%eax),%eax
80107636:	83 f8 40             	cmp    $0x40,%eax
80107639:	75 3e                	jne    80107679 <trap+0x52>
    if(proc->killed)
8010763b:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80107641:	8b 40 24             	mov    0x24(%eax),%eax
80107644:	85 c0                	test   %eax,%eax
80107646:	74 05                	je     8010764d <trap+0x26>
      exit();
80107648:	e8 e4 d8 ff ff       	call   80104f31 <exit>
    proc->tf = tf;
8010764d:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80107653:	8b 55 08             	mov    0x8(%ebp),%edx
80107656:	89 50 18             	mov    %edx,0x18(%eax)
    syscall();
80107659:	e8 35 eb ff ff       	call   80106193 <syscall>
    if(proc->killed)
8010765e:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80107664:	8b 40 24             	mov    0x24(%eax),%eax
80107667:	85 c0                	test   %eax,%eax
80107669:	0f 84 39 02 00 00    	je     801078a8 <trap+0x281>
      exit();
8010766f:	e8 bd d8 ff ff       	call   80104f31 <exit>
    return;
80107674:	e9 2f 02 00 00       	jmp    801078a8 <trap+0x281>
  }

  switch(tf->trapno){
80107679:	8b 45 08             	mov    0x8(%ebp),%eax
8010767c:	8b 40 30             	mov    0x30(%eax),%eax
8010767f:	83 e8 20             	sub    $0x20,%eax
80107682:	83 f8 1f             	cmp    $0x1f,%eax
80107685:	0f 87 c1 00 00 00    	ja     8010774c <trap+0x125>
8010768b:	8b 04 85 c4 99 10 80 	mov    -0x7fef663c(,%eax,4),%eax
80107692:	ff e0                	jmp    *%eax
  case T_IRQ0 + IRQ_TIMER:
    if(cpu->id == 0){
80107694:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
8010769a:	0f b6 00             	movzbl (%eax),%eax
8010769d:	84 c0                	test   %al,%al
8010769f:	75 36                	jne    801076d7 <trap+0xb0>
      acquire(&tickslock);
801076a1:	c7 04 24 20 6a 11 80 	movl   $0x80116a20,(%esp)
801076a8:	e8 0a e4 ff ff       	call   80105ab7 <acquire>

      ticks++;
801076ad:	a1 60 72 11 80       	mov    0x80117260,%eax
801076b2:	83 c0 01             	add    $0x1,%eax
801076b5:	a3 60 72 11 80       	mov    %eax,0x80117260
      sleepingUpDate();
801076ba:	e8 9b d1 ff ff       	call   8010485a <sleepingUpDate>
        

      wakeup(&ticks);
801076bf:	c7 04 24 60 72 11 80 	movl   $0x80117260,(%esp)
801076c6:	e8 4c e0 ff ff       	call   80105717 <wakeup>
      release(&tickslock);
801076cb:	c7 04 24 20 6a 11 80 	movl   $0x80116a20,(%esp)
801076d2:	e8 42 e4 ff ff       	call   80105b19 <release>
    }
    lapiceoi();
801076d7:	e8 61 bf ff ff       	call   8010363d <lapiceoi>
    break;
801076dc:	e9 41 01 00 00       	jmp    80107822 <trap+0x1fb>
  case T_IRQ0 + IRQ_IDE:
    ideintr();
801076e1:	e8 5f b7 ff ff       	call   80102e45 <ideintr>
    lapiceoi();
801076e6:	e8 52 bf ff ff       	call   8010363d <lapiceoi>
    break;
801076eb:	e9 32 01 00 00       	jmp    80107822 <trap+0x1fb>
  case T_IRQ0 + IRQ_IDE+1:
    // Bochs generates spurious IDE1 interrupts.
    break;
  case T_IRQ0 + IRQ_KBD:
    kbdintr();
801076f0:	e8 26 bd ff ff       	call   8010341b <kbdintr>
    lapiceoi();
801076f5:	e8 43 bf ff ff       	call   8010363d <lapiceoi>
    break;
801076fa:	e9 23 01 00 00       	jmp    80107822 <trap+0x1fb>
  case T_IRQ0 + IRQ_COM1:
    uartintr();
801076ff:	e8 ac 03 00 00       	call   80107ab0 <uartintr>
    lapiceoi();
80107704:	e8 34 bf ff ff       	call   8010363d <lapiceoi>
    break;
80107709:	e9 14 01 00 00       	jmp    80107822 <trap+0x1fb>
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
            cpu->id, tf->cs, tf->eip);
8010770e:	8b 45 08             	mov    0x8(%ebp),%eax
    uartintr();
    lapiceoi();
    break;
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80107711:	8b 48 38             	mov    0x38(%eax),%ecx
            cpu->id, tf->cs, tf->eip);
80107714:	8b 45 08             	mov    0x8(%ebp),%eax
80107717:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
    uartintr();
    lapiceoi();
    break;
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
8010771b:	0f b7 d0             	movzwl %ax,%edx
            cpu->id, tf->cs, tf->eip);
8010771e:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80107724:	0f b6 00             	movzbl (%eax),%eax
    uartintr();
    lapiceoi();
    break;
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80107727:	0f b6 c0             	movzbl %al,%eax
8010772a:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
8010772e:	89 54 24 08          	mov    %edx,0x8(%esp)
80107732:	89 44 24 04          	mov    %eax,0x4(%esp)
80107736:	c7 04 24 24 99 10 80 	movl   $0x80109924,(%esp)
8010773d:	e8 5f 8c ff ff       	call   801003a1 <cprintf>
            cpu->id, tf->cs, tf->eip);
    lapiceoi();
80107742:	e8 f6 be ff ff       	call   8010363d <lapiceoi>
    break;
80107747:	e9 d6 00 00 00       	jmp    80107822 <trap+0x1fb>
   
  //PAGEBREAK: 13
  default:
    if(proc == 0 || (tf->cs&3) == 0){
8010774c:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80107752:	85 c0                	test   %eax,%eax
80107754:	74 11                	je     80107767 <trap+0x140>
80107756:	8b 45 08             	mov    0x8(%ebp),%eax
80107759:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
8010775d:	0f b7 c0             	movzwl %ax,%eax
80107760:	83 e0 03             	and    $0x3,%eax
80107763:	85 c0                	test   %eax,%eax
80107765:	75 46                	jne    801077ad <trap+0x186>
      // In kernel, it must be our mistake.
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80107767:	e8 15 fd ff ff       	call   80107481 <rcr2>
              tf->trapno, cpu->id, tf->eip, rcr2());
8010776c:	8b 55 08             	mov    0x8(%ebp),%edx
   
  //PAGEBREAK: 13
  default:
    if(proc == 0 || (tf->cs&3) == 0){
      // In kernel, it must be our mistake.
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
8010776f:	8b 5a 38             	mov    0x38(%edx),%ebx
              tf->trapno, cpu->id, tf->eip, rcr2());
80107772:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80107779:	0f b6 12             	movzbl (%edx),%edx
   
  //PAGEBREAK: 13
  default:
    if(proc == 0 || (tf->cs&3) == 0){
      // In kernel, it must be our mistake.
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
8010777c:	0f b6 ca             	movzbl %dl,%ecx
              tf->trapno, cpu->id, tf->eip, rcr2());
8010777f:	8b 55 08             	mov    0x8(%ebp),%edx
   
  //PAGEBREAK: 13
  default:
    if(proc == 0 || (tf->cs&3) == 0){
      // In kernel, it must be our mistake.
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80107782:	8b 52 30             	mov    0x30(%edx),%edx
80107785:	89 44 24 10          	mov    %eax,0x10(%esp)
80107789:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
8010778d:	89 4c 24 08          	mov    %ecx,0x8(%esp)
80107791:	89 54 24 04          	mov    %edx,0x4(%esp)
80107795:	c7 04 24 48 99 10 80 	movl   $0x80109948,(%esp)
8010779c:	e8 00 8c ff ff       	call   801003a1 <cprintf>
              tf->trapno, cpu->id, tf->eip, rcr2());
      panic("trap");
801077a1:	c7 04 24 7a 99 10 80 	movl   $0x8010997a,(%esp)
801077a8:	e8 90 8d ff ff       	call   8010053d <panic>
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801077ad:	e8 cf fc ff ff       	call   80107481 <rcr2>
801077b2:	89 c2                	mov    %eax,%edx
            "eip 0x%x addr 0x%x--kill proc\n",
            proc->pid, proc->name, tf->trapno, tf->err, cpu->id, tf->eip, 
801077b4:	8b 45 08             	mov    0x8(%ebp),%eax
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpu->id, tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801077b7:	8b 78 38             	mov    0x38(%eax),%edi
            "eip 0x%x addr 0x%x--kill proc\n",
            proc->pid, proc->name, tf->trapno, tf->err, cpu->id, tf->eip, 
801077ba:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801077c0:	0f b6 00             	movzbl (%eax),%eax
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpu->id, tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801077c3:	0f b6 f0             	movzbl %al,%esi
            "eip 0x%x addr 0x%x--kill proc\n",
            proc->pid, proc->name, tf->trapno, tf->err, cpu->id, tf->eip, 
801077c6:	8b 45 08             	mov    0x8(%ebp),%eax
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpu->id, tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801077c9:	8b 58 34             	mov    0x34(%eax),%ebx
            "eip 0x%x addr 0x%x--kill proc\n",
            proc->pid, proc->name, tf->trapno, tf->err, cpu->id, tf->eip, 
801077cc:	8b 45 08             	mov    0x8(%ebp),%eax
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpu->id, tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801077cf:	8b 48 30             	mov    0x30(%eax),%ecx
            "eip 0x%x addr 0x%x--kill proc\n",
            proc->pid, proc->name, tf->trapno, tf->err, cpu->id, tf->eip, 
801077d2:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801077d8:	83 c0 6c             	add    $0x6c,%eax
801077db:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801077de:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpu->id, tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801077e4:	8b 40 10             	mov    0x10(%eax),%eax
801077e7:	89 54 24 1c          	mov    %edx,0x1c(%esp)
801077eb:	89 7c 24 18          	mov    %edi,0x18(%esp)
801077ef:	89 74 24 14          	mov    %esi,0x14(%esp)
801077f3:	89 5c 24 10          	mov    %ebx,0x10(%esp)
801077f7:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
801077fb:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801077fe:	89 54 24 08          	mov    %edx,0x8(%esp)
80107802:	89 44 24 04          	mov    %eax,0x4(%esp)
80107806:	c7 04 24 80 99 10 80 	movl   $0x80109980,(%esp)
8010780d:	e8 8f 8b ff ff       	call   801003a1 <cprintf>
            "eip 0x%x addr 0x%x--kill proc\n",
            proc->pid, proc->name, tf->trapno, tf->err, cpu->id, tf->eip, 
            rcr2());
    proc->killed = 1;
80107812:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80107818:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
8010781f:	eb 01                	jmp    80107822 <trap+0x1fb>
    ideintr();
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE+1:
    // Bochs generates spurious IDE1 interrupts.
    break;
80107821:	90                   	nop
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running 
  // until it gets to the regular system call return.)
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
80107822:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80107828:	85 c0                	test   %eax,%eax
8010782a:	74 24                	je     80107850 <trap+0x229>
8010782c:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80107832:	8b 40 24             	mov    0x24(%eax),%eax
80107835:	85 c0                	test   %eax,%eax
80107837:	74 17                	je     80107850 <trap+0x229>
80107839:	8b 45 08             	mov    0x8(%ebp),%eax
8010783c:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
80107840:	0f b7 c0             	movzwl %ax,%eax
80107843:	83 e0 03             	and    $0x3,%eax
80107846:	83 f8 03             	cmp    $0x3,%eax
80107849:	75 05                	jne    80107850 <trap+0x229>
    exit();
8010784b:	e8 e1 d6 ff ff       	call   80104f31 <exit>

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(proc && proc->state == RUNNING && tf->trapno == T_IRQ0+IRQ_TIMER )
80107850:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80107856:	85 c0                	test   %eax,%eax
80107858:	74 1e                	je     80107878 <trap+0x251>
8010785a:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80107860:	8b 40 0c             	mov    0xc(%eax),%eax
80107863:	83 f8 04             	cmp    $0x4,%eax
80107866:	75 10                	jne    80107878 <trap+0x251>
80107868:	8b 45 08             	mov    0x8(%ebp),%eax
8010786b:	8b 40 30             	mov    0x30(%eax),%eax
8010786e:	83 f8 20             	cmp    $0x20,%eax
80107871:	75 05                	jne    80107878 <trap+0x251>
  {
    if(SCHEDFLAG==SCHED_DEFAULT)
    {
      yield();
80107873:	e8 4a dd ff ff       	call   801055c2 <yield>
        yield();
    }
  }

  // Check if the process has been killed since we yielded
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
80107878:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010787e:	85 c0                	test   %eax,%eax
80107880:	74 27                	je     801078a9 <trap+0x282>
80107882:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80107888:	8b 40 24             	mov    0x24(%eax),%eax
8010788b:	85 c0                	test   %eax,%eax
8010788d:	74 1a                	je     801078a9 <trap+0x282>
8010788f:	8b 45 08             	mov    0x8(%ebp),%eax
80107892:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
80107896:	0f b7 c0             	movzwl %ax,%eax
80107899:	83 e0 03             	and    $0x3,%eax
8010789c:	83 f8 03             	cmp    $0x3,%eax
8010789f:	75 08                	jne    801078a9 <trap+0x282>
    exit();
801078a1:	e8 8b d6 ff ff       	call   80104f31 <exit>
801078a6:	eb 01                	jmp    801078a9 <trap+0x282>
      exit();
    proc->tf = tf;
    syscall();
    if(proc->killed)
      exit();
    return;
801078a8:	90                   	nop
  }

  // Check if the process has been killed since we yielded
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
    exit();
}
801078a9:	83 c4 3c             	add    $0x3c,%esp
801078ac:	5b                   	pop    %ebx
801078ad:	5e                   	pop    %esi
801078ae:	5f                   	pop    %edi
801078af:	5d                   	pop    %ebp
801078b0:	c3                   	ret    
801078b1:	00 00                	add    %al,(%eax)
	...

801078b4 <inb>:
// Routines to let C code use special x86 instructions.

static inline uchar
inb(ushort port)
{
801078b4:	55                   	push   %ebp
801078b5:	89 e5                	mov    %esp,%ebp
801078b7:	53                   	push   %ebx
801078b8:	83 ec 14             	sub    $0x14,%esp
801078bb:	8b 45 08             	mov    0x8(%ebp),%eax
801078be:	66 89 45 e8          	mov    %ax,-0x18(%ebp)
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801078c2:	0f b7 55 e8          	movzwl -0x18(%ebp),%edx
801078c6:	66 89 55 ea          	mov    %dx,-0x16(%ebp)
801078ca:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
801078ce:	ec                   	in     (%dx),%al
801078cf:	89 c3                	mov    %eax,%ebx
801078d1:	88 5d fb             	mov    %bl,-0x5(%ebp)
  return data;
801078d4:	0f b6 45 fb          	movzbl -0x5(%ebp),%eax
}
801078d8:	83 c4 14             	add    $0x14,%esp
801078db:	5b                   	pop    %ebx
801078dc:	5d                   	pop    %ebp
801078dd:	c3                   	ret    

801078de <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
801078de:	55                   	push   %ebp
801078df:	89 e5                	mov    %esp,%ebp
801078e1:	83 ec 08             	sub    $0x8,%esp
801078e4:	8b 55 08             	mov    0x8(%ebp),%edx
801078e7:	8b 45 0c             	mov    0xc(%ebp),%eax
801078ea:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
801078ee:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801078f1:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
801078f5:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
801078f9:	ee                   	out    %al,(%dx)
}
801078fa:	c9                   	leave  
801078fb:	c3                   	ret    

801078fc <uartinit>:

static int uart;    // is there a uart?

void
uartinit(void)
{
801078fc:	55                   	push   %ebp
801078fd:	89 e5                	mov    %esp,%ebp
801078ff:	83 ec 28             	sub    $0x28,%esp
  char *p;

  // Turn off the FIFO
  outb(COM1+2, 0);
80107902:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80107909:	00 
8010790a:	c7 04 24 fa 03 00 00 	movl   $0x3fa,(%esp)
80107911:	e8 c8 ff ff ff       	call   801078de <outb>
  
  // 9600 baud, 8 data bits, 1 stop bit, parity off.
  outb(COM1+3, 0x80);    // Unlock divisor
80107916:	c7 44 24 04 80 00 00 	movl   $0x80,0x4(%esp)
8010791d:	00 
8010791e:	c7 04 24 fb 03 00 00 	movl   $0x3fb,(%esp)
80107925:	e8 b4 ff ff ff       	call   801078de <outb>
  outb(COM1+0, 115200/9600);
8010792a:	c7 44 24 04 0c 00 00 	movl   $0xc,0x4(%esp)
80107931:	00 
80107932:	c7 04 24 f8 03 00 00 	movl   $0x3f8,(%esp)
80107939:	e8 a0 ff ff ff       	call   801078de <outb>
  outb(COM1+1, 0);
8010793e:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80107945:	00 
80107946:	c7 04 24 f9 03 00 00 	movl   $0x3f9,(%esp)
8010794d:	e8 8c ff ff ff       	call   801078de <outb>
  outb(COM1+3, 0x03);    // Lock divisor, 8 data bits.
80107952:	c7 44 24 04 03 00 00 	movl   $0x3,0x4(%esp)
80107959:	00 
8010795a:	c7 04 24 fb 03 00 00 	movl   $0x3fb,(%esp)
80107961:	e8 78 ff ff ff       	call   801078de <outb>
  outb(COM1+4, 0);
80107966:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
8010796d:	00 
8010796e:	c7 04 24 fc 03 00 00 	movl   $0x3fc,(%esp)
80107975:	e8 64 ff ff ff       	call   801078de <outb>
  outb(COM1+1, 0x01);    // Enable receive interrupts.
8010797a:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
80107981:	00 
80107982:	c7 04 24 f9 03 00 00 	movl   $0x3f9,(%esp)
80107989:	e8 50 ff ff ff       	call   801078de <outb>

  // If status is 0xFF, no serial port.
  if(inb(COM1+5) == 0xFF)
8010798e:	c7 04 24 fd 03 00 00 	movl   $0x3fd,(%esp)
80107995:	e8 1a ff ff ff       	call   801078b4 <inb>
8010799a:	3c ff                	cmp    $0xff,%al
8010799c:	74 6c                	je     80107a0a <uartinit+0x10e>
    return;
  uart = 1;
8010799e:	c7 05 8c cb 10 80 01 	movl   $0x1,0x8010cb8c
801079a5:	00 00 00 

  // Acknowledge pre-existing interrupt conditions;
  // enable interrupts.
  inb(COM1+2);
801079a8:	c7 04 24 fa 03 00 00 	movl   $0x3fa,(%esp)
801079af:	e8 00 ff ff ff       	call   801078b4 <inb>
  inb(COM1+0);
801079b4:	c7 04 24 f8 03 00 00 	movl   $0x3f8,(%esp)
801079bb:	e8 f4 fe ff ff       	call   801078b4 <inb>
  picenable(IRQ_COM1);
801079c0:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
801079c7:	e8 49 c8 ff ff       	call   80104215 <picenable>
  ioapicenable(IRQ_COM1, 0);
801079cc:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
801079d3:	00 
801079d4:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
801079db:	e8 ea b6 ff ff       	call   801030ca <ioapicenable>
  
  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
801079e0:	c7 45 f4 44 9a 10 80 	movl   $0x80109a44,-0xc(%ebp)
801079e7:	eb 15                	jmp    801079fe <uartinit+0x102>
    uartputc(*p);
801079e9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801079ec:	0f b6 00             	movzbl (%eax),%eax
801079ef:	0f be c0             	movsbl %al,%eax
801079f2:	89 04 24             	mov    %eax,(%esp)
801079f5:	e8 13 00 00 00       	call   80107a0d <uartputc>
  inb(COM1+0);
  picenable(IRQ_COM1);
  ioapicenable(IRQ_COM1, 0);
  
  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
801079fa:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801079fe:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107a01:	0f b6 00             	movzbl (%eax),%eax
80107a04:	84 c0                	test   %al,%al
80107a06:	75 e1                	jne    801079e9 <uartinit+0xed>
80107a08:	eb 01                	jmp    80107a0b <uartinit+0x10f>
  outb(COM1+4, 0);
  outb(COM1+1, 0x01);    // Enable receive interrupts.

  // If status is 0xFF, no serial port.
  if(inb(COM1+5) == 0xFF)
    return;
80107a0a:	90                   	nop
  ioapicenable(IRQ_COM1, 0);
  
  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
    uartputc(*p);
}
80107a0b:	c9                   	leave  
80107a0c:	c3                   	ret    

80107a0d <uartputc>:

void
uartputc(int c)
{
80107a0d:	55                   	push   %ebp
80107a0e:	89 e5                	mov    %esp,%ebp
80107a10:	83 ec 28             	sub    $0x28,%esp
  int i;

  if(!uart)
80107a13:	a1 8c cb 10 80       	mov    0x8010cb8c,%eax
80107a18:	85 c0                	test   %eax,%eax
80107a1a:	74 4d                	je     80107a69 <uartputc+0x5c>
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80107a1c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80107a23:	eb 10                	jmp    80107a35 <uartputc+0x28>
    microdelay(10);
80107a25:	c7 04 24 0a 00 00 00 	movl   $0xa,(%esp)
80107a2c:	e8 31 bc ff ff       	call   80103662 <microdelay>
{
  int i;

  if(!uart)
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80107a31:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80107a35:	83 7d f4 7f          	cmpl   $0x7f,-0xc(%ebp)
80107a39:	7f 16                	jg     80107a51 <uartputc+0x44>
80107a3b:	c7 04 24 fd 03 00 00 	movl   $0x3fd,(%esp)
80107a42:	e8 6d fe ff ff       	call   801078b4 <inb>
80107a47:	0f b6 c0             	movzbl %al,%eax
80107a4a:	83 e0 20             	and    $0x20,%eax
80107a4d:	85 c0                	test   %eax,%eax
80107a4f:	74 d4                	je     80107a25 <uartputc+0x18>
    microdelay(10);
  outb(COM1+0, c);
80107a51:	8b 45 08             	mov    0x8(%ebp),%eax
80107a54:	0f b6 c0             	movzbl %al,%eax
80107a57:	89 44 24 04          	mov    %eax,0x4(%esp)
80107a5b:	c7 04 24 f8 03 00 00 	movl   $0x3f8,(%esp)
80107a62:	e8 77 fe ff ff       	call   801078de <outb>
80107a67:	eb 01                	jmp    80107a6a <uartputc+0x5d>
uartputc(int c)
{
  int i;

  if(!uart)
    return;
80107a69:	90                   	nop
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
    microdelay(10);
  outb(COM1+0, c);
}
80107a6a:	c9                   	leave  
80107a6b:	c3                   	ret    

80107a6c <uartgetc>:

static int
uartgetc(void)
{
80107a6c:	55                   	push   %ebp
80107a6d:	89 e5                	mov    %esp,%ebp
80107a6f:	83 ec 04             	sub    $0x4,%esp
  if(!uart)
80107a72:	a1 8c cb 10 80       	mov    0x8010cb8c,%eax
80107a77:	85 c0                	test   %eax,%eax
80107a79:	75 07                	jne    80107a82 <uartgetc+0x16>
    return -1;
80107a7b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107a80:	eb 2c                	jmp    80107aae <uartgetc+0x42>
  if(!(inb(COM1+5) & 0x01))
80107a82:	c7 04 24 fd 03 00 00 	movl   $0x3fd,(%esp)
80107a89:	e8 26 fe ff ff       	call   801078b4 <inb>
80107a8e:	0f b6 c0             	movzbl %al,%eax
80107a91:	83 e0 01             	and    $0x1,%eax
80107a94:	85 c0                	test   %eax,%eax
80107a96:	75 07                	jne    80107a9f <uartgetc+0x33>
    return -1;
80107a98:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107a9d:	eb 0f                	jmp    80107aae <uartgetc+0x42>
  return inb(COM1+0);
80107a9f:	c7 04 24 f8 03 00 00 	movl   $0x3f8,(%esp)
80107aa6:	e8 09 fe ff ff       	call   801078b4 <inb>
80107aab:	0f b6 c0             	movzbl %al,%eax
}
80107aae:	c9                   	leave  
80107aaf:	c3                   	ret    

80107ab0 <uartintr>:

void
uartintr(void)
{
80107ab0:	55                   	push   %ebp
80107ab1:	89 e5                	mov    %esp,%ebp
80107ab3:	83 ec 18             	sub    $0x18,%esp
  consoleintr(uartgetc);
80107ab6:	c7 04 24 6c 7a 10 80 	movl   $0x80107a6c,(%esp)
80107abd:	e8 f9 8d ff ff       	call   801008bb <consoleintr>
}
80107ac2:	c9                   	leave  
80107ac3:	c3                   	ret    

80107ac4 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
80107ac4:	6a 00                	push   $0x0
  pushl $0
80107ac6:	6a 00                	push   $0x0
  jmp alltraps
80107ac8:	e9 5f f9 ff ff       	jmp    8010742c <alltraps>

80107acd <vector1>:
.globl vector1
vector1:
  pushl $0
80107acd:	6a 00                	push   $0x0
  pushl $1
80107acf:	6a 01                	push   $0x1
  jmp alltraps
80107ad1:	e9 56 f9 ff ff       	jmp    8010742c <alltraps>

80107ad6 <vector2>:
.globl vector2
vector2:
  pushl $0
80107ad6:	6a 00                	push   $0x0
  pushl $2
80107ad8:	6a 02                	push   $0x2
  jmp alltraps
80107ada:	e9 4d f9 ff ff       	jmp    8010742c <alltraps>

80107adf <vector3>:
.globl vector3
vector3:
  pushl $0
80107adf:	6a 00                	push   $0x0
  pushl $3
80107ae1:	6a 03                	push   $0x3
  jmp alltraps
80107ae3:	e9 44 f9 ff ff       	jmp    8010742c <alltraps>

80107ae8 <vector4>:
.globl vector4
vector4:
  pushl $0
80107ae8:	6a 00                	push   $0x0
  pushl $4
80107aea:	6a 04                	push   $0x4
  jmp alltraps
80107aec:	e9 3b f9 ff ff       	jmp    8010742c <alltraps>

80107af1 <vector5>:
.globl vector5
vector5:
  pushl $0
80107af1:	6a 00                	push   $0x0
  pushl $5
80107af3:	6a 05                	push   $0x5
  jmp alltraps
80107af5:	e9 32 f9 ff ff       	jmp    8010742c <alltraps>

80107afa <vector6>:
.globl vector6
vector6:
  pushl $0
80107afa:	6a 00                	push   $0x0
  pushl $6
80107afc:	6a 06                	push   $0x6
  jmp alltraps
80107afe:	e9 29 f9 ff ff       	jmp    8010742c <alltraps>

80107b03 <vector7>:
.globl vector7
vector7:
  pushl $0
80107b03:	6a 00                	push   $0x0
  pushl $7
80107b05:	6a 07                	push   $0x7
  jmp alltraps
80107b07:	e9 20 f9 ff ff       	jmp    8010742c <alltraps>

80107b0c <vector8>:
.globl vector8
vector8:
  pushl $8
80107b0c:	6a 08                	push   $0x8
  jmp alltraps
80107b0e:	e9 19 f9 ff ff       	jmp    8010742c <alltraps>

80107b13 <vector9>:
.globl vector9
vector9:
  pushl $0
80107b13:	6a 00                	push   $0x0
  pushl $9
80107b15:	6a 09                	push   $0x9
  jmp alltraps
80107b17:	e9 10 f9 ff ff       	jmp    8010742c <alltraps>

80107b1c <vector10>:
.globl vector10
vector10:
  pushl $10
80107b1c:	6a 0a                	push   $0xa
  jmp alltraps
80107b1e:	e9 09 f9 ff ff       	jmp    8010742c <alltraps>

80107b23 <vector11>:
.globl vector11
vector11:
  pushl $11
80107b23:	6a 0b                	push   $0xb
  jmp alltraps
80107b25:	e9 02 f9 ff ff       	jmp    8010742c <alltraps>

80107b2a <vector12>:
.globl vector12
vector12:
  pushl $12
80107b2a:	6a 0c                	push   $0xc
  jmp alltraps
80107b2c:	e9 fb f8 ff ff       	jmp    8010742c <alltraps>

80107b31 <vector13>:
.globl vector13
vector13:
  pushl $13
80107b31:	6a 0d                	push   $0xd
  jmp alltraps
80107b33:	e9 f4 f8 ff ff       	jmp    8010742c <alltraps>

80107b38 <vector14>:
.globl vector14
vector14:
  pushl $14
80107b38:	6a 0e                	push   $0xe
  jmp alltraps
80107b3a:	e9 ed f8 ff ff       	jmp    8010742c <alltraps>

80107b3f <vector15>:
.globl vector15
vector15:
  pushl $0
80107b3f:	6a 00                	push   $0x0
  pushl $15
80107b41:	6a 0f                	push   $0xf
  jmp alltraps
80107b43:	e9 e4 f8 ff ff       	jmp    8010742c <alltraps>

80107b48 <vector16>:
.globl vector16
vector16:
  pushl $0
80107b48:	6a 00                	push   $0x0
  pushl $16
80107b4a:	6a 10                	push   $0x10
  jmp alltraps
80107b4c:	e9 db f8 ff ff       	jmp    8010742c <alltraps>

80107b51 <vector17>:
.globl vector17
vector17:
  pushl $17
80107b51:	6a 11                	push   $0x11
  jmp alltraps
80107b53:	e9 d4 f8 ff ff       	jmp    8010742c <alltraps>

80107b58 <vector18>:
.globl vector18
vector18:
  pushl $0
80107b58:	6a 00                	push   $0x0
  pushl $18
80107b5a:	6a 12                	push   $0x12
  jmp alltraps
80107b5c:	e9 cb f8 ff ff       	jmp    8010742c <alltraps>

80107b61 <vector19>:
.globl vector19
vector19:
  pushl $0
80107b61:	6a 00                	push   $0x0
  pushl $19
80107b63:	6a 13                	push   $0x13
  jmp alltraps
80107b65:	e9 c2 f8 ff ff       	jmp    8010742c <alltraps>

80107b6a <vector20>:
.globl vector20
vector20:
  pushl $0
80107b6a:	6a 00                	push   $0x0
  pushl $20
80107b6c:	6a 14                	push   $0x14
  jmp alltraps
80107b6e:	e9 b9 f8 ff ff       	jmp    8010742c <alltraps>

80107b73 <vector21>:
.globl vector21
vector21:
  pushl $0
80107b73:	6a 00                	push   $0x0
  pushl $21
80107b75:	6a 15                	push   $0x15
  jmp alltraps
80107b77:	e9 b0 f8 ff ff       	jmp    8010742c <alltraps>

80107b7c <vector22>:
.globl vector22
vector22:
  pushl $0
80107b7c:	6a 00                	push   $0x0
  pushl $22
80107b7e:	6a 16                	push   $0x16
  jmp alltraps
80107b80:	e9 a7 f8 ff ff       	jmp    8010742c <alltraps>

80107b85 <vector23>:
.globl vector23
vector23:
  pushl $0
80107b85:	6a 00                	push   $0x0
  pushl $23
80107b87:	6a 17                	push   $0x17
  jmp alltraps
80107b89:	e9 9e f8 ff ff       	jmp    8010742c <alltraps>

80107b8e <vector24>:
.globl vector24
vector24:
  pushl $0
80107b8e:	6a 00                	push   $0x0
  pushl $24
80107b90:	6a 18                	push   $0x18
  jmp alltraps
80107b92:	e9 95 f8 ff ff       	jmp    8010742c <alltraps>

80107b97 <vector25>:
.globl vector25
vector25:
  pushl $0
80107b97:	6a 00                	push   $0x0
  pushl $25
80107b99:	6a 19                	push   $0x19
  jmp alltraps
80107b9b:	e9 8c f8 ff ff       	jmp    8010742c <alltraps>

80107ba0 <vector26>:
.globl vector26
vector26:
  pushl $0
80107ba0:	6a 00                	push   $0x0
  pushl $26
80107ba2:	6a 1a                	push   $0x1a
  jmp alltraps
80107ba4:	e9 83 f8 ff ff       	jmp    8010742c <alltraps>

80107ba9 <vector27>:
.globl vector27
vector27:
  pushl $0
80107ba9:	6a 00                	push   $0x0
  pushl $27
80107bab:	6a 1b                	push   $0x1b
  jmp alltraps
80107bad:	e9 7a f8 ff ff       	jmp    8010742c <alltraps>

80107bb2 <vector28>:
.globl vector28
vector28:
  pushl $0
80107bb2:	6a 00                	push   $0x0
  pushl $28
80107bb4:	6a 1c                	push   $0x1c
  jmp alltraps
80107bb6:	e9 71 f8 ff ff       	jmp    8010742c <alltraps>

80107bbb <vector29>:
.globl vector29
vector29:
  pushl $0
80107bbb:	6a 00                	push   $0x0
  pushl $29
80107bbd:	6a 1d                	push   $0x1d
  jmp alltraps
80107bbf:	e9 68 f8 ff ff       	jmp    8010742c <alltraps>

80107bc4 <vector30>:
.globl vector30
vector30:
  pushl $0
80107bc4:	6a 00                	push   $0x0
  pushl $30
80107bc6:	6a 1e                	push   $0x1e
  jmp alltraps
80107bc8:	e9 5f f8 ff ff       	jmp    8010742c <alltraps>

80107bcd <vector31>:
.globl vector31
vector31:
  pushl $0
80107bcd:	6a 00                	push   $0x0
  pushl $31
80107bcf:	6a 1f                	push   $0x1f
  jmp alltraps
80107bd1:	e9 56 f8 ff ff       	jmp    8010742c <alltraps>

80107bd6 <vector32>:
.globl vector32
vector32:
  pushl $0
80107bd6:	6a 00                	push   $0x0
  pushl $32
80107bd8:	6a 20                	push   $0x20
  jmp alltraps
80107bda:	e9 4d f8 ff ff       	jmp    8010742c <alltraps>

80107bdf <vector33>:
.globl vector33
vector33:
  pushl $0
80107bdf:	6a 00                	push   $0x0
  pushl $33
80107be1:	6a 21                	push   $0x21
  jmp alltraps
80107be3:	e9 44 f8 ff ff       	jmp    8010742c <alltraps>

80107be8 <vector34>:
.globl vector34
vector34:
  pushl $0
80107be8:	6a 00                	push   $0x0
  pushl $34
80107bea:	6a 22                	push   $0x22
  jmp alltraps
80107bec:	e9 3b f8 ff ff       	jmp    8010742c <alltraps>

80107bf1 <vector35>:
.globl vector35
vector35:
  pushl $0
80107bf1:	6a 00                	push   $0x0
  pushl $35
80107bf3:	6a 23                	push   $0x23
  jmp alltraps
80107bf5:	e9 32 f8 ff ff       	jmp    8010742c <alltraps>

80107bfa <vector36>:
.globl vector36
vector36:
  pushl $0
80107bfa:	6a 00                	push   $0x0
  pushl $36
80107bfc:	6a 24                	push   $0x24
  jmp alltraps
80107bfe:	e9 29 f8 ff ff       	jmp    8010742c <alltraps>

80107c03 <vector37>:
.globl vector37
vector37:
  pushl $0
80107c03:	6a 00                	push   $0x0
  pushl $37
80107c05:	6a 25                	push   $0x25
  jmp alltraps
80107c07:	e9 20 f8 ff ff       	jmp    8010742c <alltraps>

80107c0c <vector38>:
.globl vector38
vector38:
  pushl $0
80107c0c:	6a 00                	push   $0x0
  pushl $38
80107c0e:	6a 26                	push   $0x26
  jmp alltraps
80107c10:	e9 17 f8 ff ff       	jmp    8010742c <alltraps>

80107c15 <vector39>:
.globl vector39
vector39:
  pushl $0
80107c15:	6a 00                	push   $0x0
  pushl $39
80107c17:	6a 27                	push   $0x27
  jmp alltraps
80107c19:	e9 0e f8 ff ff       	jmp    8010742c <alltraps>

80107c1e <vector40>:
.globl vector40
vector40:
  pushl $0
80107c1e:	6a 00                	push   $0x0
  pushl $40
80107c20:	6a 28                	push   $0x28
  jmp alltraps
80107c22:	e9 05 f8 ff ff       	jmp    8010742c <alltraps>

80107c27 <vector41>:
.globl vector41
vector41:
  pushl $0
80107c27:	6a 00                	push   $0x0
  pushl $41
80107c29:	6a 29                	push   $0x29
  jmp alltraps
80107c2b:	e9 fc f7 ff ff       	jmp    8010742c <alltraps>

80107c30 <vector42>:
.globl vector42
vector42:
  pushl $0
80107c30:	6a 00                	push   $0x0
  pushl $42
80107c32:	6a 2a                	push   $0x2a
  jmp alltraps
80107c34:	e9 f3 f7 ff ff       	jmp    8010742c <alltraps>

80107c39 <vector43>:
.globl vector43
vector43:
  pushl $0
80107c39:	6a 00                	push   $0x0
  pushl $43
80107c3b:	6a 2b                	push   $0x2b
  jmp alltraps
80107c3d:	e9 ea f7 ff ff       	jmp    8010742c <alltraps>

80107c42 <vector44>:
.globl vector44
vector44:
  pushl $0
80107c42:	6a 00                	push   $0x0
  pushl $44
80107c44:	6a 2c                	push   $0x2c
  jmp alltraps
80107c46:	e9 e1 f7 ff ff       	jmp    8010742c <alltraps>

80107c4b <vector45>:
.globl vector45
vector45:
  pushl $0
80107c4b:	6a 00                	push   $0x0
  pushl $45
80107c4d:	6a 2d                	push   $0x2d
  jmp alltraps
80107c4f:	e9 d8 f7 ff ff       	jmp    8010742c <alltraps>

80107c54 <vector46>:
.globl vector46
vector46:
  pushl $0
80107c54:	6a 00                	push   $0x0
  pushl $46
80107c56:	6a 2e                	push   $0x2e
  jmp alltraps
80107c58:	e9 cf f7 ff ff       	jmp    8010742c <alltraps>

80107c5d <vector47>:
.globl vector47
vector47:
  pushl $0
80107c5d:	6a 00                	push   $0x0
  pushl $47
80107c5f:	6a 2f                	push   $0x2f
  jmp alltraps
80107c61:	e9 c6 f7 ff ff       	jmp    8010742c <alltraps>

80107c66 <vector48>:
.globl vector48
vector48:
  pushl $0
80107c66:	6a 00                	push   $0x0
  pushl $48
80107c68:	6a 30                	push   $0x30
  jmp alltraps
80107c6a:	e9 bd f7 ff ff       	jmp    8010742c <alltraps>

80107c6f <vector49>:
.globl vector49
vector49:
  pushl $0
80107c6f:	6a 00                	push   $0x0
  pushl $49
80107c71:	6a 31                	push   $0x31
  jmp alltraps
80107c73:	e9 b4 f7 ff ff       	jmp    8010742c <alltraps>

80107c78 <vector50>:
.globl vector50
vector50:
  pushl $0
80107c78:	6a 00                	push   $0x0
  pushl $50
80107c7a:	6a 32                	push   $0x32
  jmp alltraps
80107c7c:	e9 ab f7 ff ff       	jmp    8010742c <alltraps>

80107c81 <vector51>:
.globl vector51
vector51:
  pushl $0
80107c81:	6a 00                	push   $0x0
  pushl $51
80107c83:	6a 33                	push   $0x33
  jmp alltraps
80107c85:	e9 a2 f7 ff ff       	jmp    8010742c <alltraps>

80107c8a <vector52>:
.globl vector52
vector52:
  pushl $0
80107c8a:	6a 00                	push   $0x0
  pushl $52
80107c8c:	6a 34                	push   $0x34
  jmp alltraps
80107c8e:	e9 99 f7 ff ff       	jmp    8010742c <alltraps>

80107c93 <vector53>:
.globl vector53
vector53:
  pushl $0
80107c93:	6a 00                	push   $0x0
  pushl $53
80107c95:	6a 35                	push   $0x35
  jmp alltraps
80107c97:	e9 90 f7 ff ff       	jmp    8010742c <alltraps>

80107c9c <vector54>:
.globl vector54
vector54:
  pushl $0
80107c9c:	6a 00                	push   $0x0
  pushl $54
80107c9e:	6a 36                	push   $0x36
  jmp alltraps
80107ca0:	e9 87 f7 ff ff       	jmp    8010742c <alltraps>

80107ca5 <vector55>:
.globl vector55
vector55:
  pushl $0
80107ca5:	6a 00                	push   $0x0
  pushl $55
80107ca7:	6a 37                	push   $0x37
  jmp alltraps
80107ca9:	e9 7e f7 ff ff       	jmp    8010742c <alltraps>

80107cae <vector56>:
.globl vector56
vector56:
  pushl $0
80107cae:	6a 00                	push   $0x0
  pushl $56
80107cb0:	6a 38                	push   $0x38
  jmp alltraps
80107cb2:	e9 75 f7 ff ff       	jmp    8010742c <alltraps>

80107cb7 <vector57>:
.globl vector57
vector57:
  pushl $0
80107cb7:	6a 00                	push   $0x0
  pushl $57
80107cb9:	6a 39                	push   $0x39
  jmp alltraps
80107cbb:	e9 6c f7 ff ff       	jmp    8010742c <alltraps>

80107cc0 <vector58>:
.globl vector58
vector58:
  pushl $0
80107cc0:	6a 00                	push   $0x0
  pushl $58
80107cc2:	6a 3a                	push   $0x3a
  jmp alltraps
80107cc4:	e9 63 f7 ff ff       	jmp    8010742c <alltraps>

80107cc9 <vector59>:
.globl vector59
vector59:
  pushl $0
80107cc9:	6a 00                	push   $0x0
  pushl $59
80107ccb:	6a 3b                	push   $0x3b
  jmp alltraps
80107ccd:	e9 5a f7 ff ff       	jmp    8010742c <alltraps>

80107cd2 <vector60>:
.globl vector60
vector60:
  pushl $0
80107cd2:	6a 00                	push   $0x0
  pushl $60
80107cd4:	6a 3c                	push   $0x3c
  jmp alltraps
80107cd6:	e9 51 f7 ff ff       	jmp    8010742c <alltraps>

80107cdb <vector61>:
.globl vector61
vector61:
  pushl $0
80107cdb:	6a 00                	push   $0x0
  pushl $61
80107cdd:	6a 3d                	push   $0x3d
  jmp alltraps
80107cdf:	e9 48 f7 ff ff       	jmp    8010742c <alltraps>

80107ce4 <vector62>:
.globl vector62
vector62:
  pushl $0
80107ce4:	6a 00                	push   $0x0
  pushl $62
80107ce6:	6a 3e                	push   $0x3e
  jmp alltraps
80107ce8:	e9 3f f7 ff ff       	jmp    8010742c <alltraps>

80107ced <vector63>:
.globl vector63
vector63:
  pushl $0
80107ced:	6a 00                	push   $0x0
  pushl $63
80107cef:	6a 3f                	push   $0x3f
  jmp alltraps
80107cf1:	e9 36 f7 ff ff       	jmp    8010742c <alltraps>

80107cf6 <vector64>:
.globl vector64
vector64:
  pushl $0
80107cf6:	6a 00                	push   $0x0
  pushl $64
80107cf8:	6a 40                	push   $0x40
  jmp alltraps
80107cfa:	e9 2d f7 ff ff       	jmp    8010742c <alltraps>

80107cff <vector65>:
.globl vector65
vector65:
  pushl $0
80107cff:	6a 00                	push   $0x0
  pushl $65
80107d01:	6a 41                	push   $0x41
  jmp alltraps
80107d03:	e9 24 f7 ff ff       	jmp    8010742c <alltraps>

80107d08 <vector66>:
.globl vector66
vector66:
  pushl $0
80107d08:	6a 00                	push   $0x0
  pushl $66
80107d0a:	6a 42                	push   $0x42
  jmp alltraps
80107d0c:	e9 1b f7 ff ff       	jmp    8010742c <alltraps>

80107d11 <vector67>:
.globl vector67
vector67:
  pushl $0
80107d11:	6a 00                	push   $0x0
  pushl $67
80107d13:	6a 43                	push   $0x43
  jmp alltraps
80107d15:	e9 12 f7 ff ff       	jmp    8010742c <alltraps>

80107d1a <vector68>:
.globl vector68
vector68:
  pushl $0
80107d1a:	6a 00                	push   $0x0
  pushl $68
80107d1c:	6a 44                	push   $0x44
  jmp alltraps
80107d1e:	e9 09 f7 ff ff       	jmp    8010742c <alltraps>

80107d23 <vector69>:
.globl vector69
vector69:
  pushl $0
80107d23:	6a 00                	push   $0x0
  pushl $69
80107d25:	6a 45                	push   $0x45
  jmp alltraps
80107d27:	e9 00 f7 ff ff       	jmp    8010742c <alltraps>

80107d2c <vector70>:
.globl vector70
vector70:
  pushl $0
80107d2c:	6a 00                	push   $0x0
  pushl $70
80107d2e:	6a 46                	push   $0x46
  jmp alltraps
80107d30:	e9 f7 f6 ff ff       	jmp    8010742c <alltraps>

80107d35 <vector71>:
.globl vector71
vector71:
  pushl $0
80107d35:	6a 00                	push   $0x0
  pushl $71
80107d37:	6a 47                	push   $0x47
  jmp alltraps
80107d39:	e9 ee f6 ff ff       	jmp    8010742c <alltraps>

80107d3e <vector72>:
.globl vector72
vector72:
  pushl $0
80107d3e:	6a 00                	push   $0x0
  pushl $72
80107d40:	6a 48                	push   $0x48
  jmp alltraps
80107d42:	e9 e5 f6 ff ff       	jmp    8010742c <alltraps>

80107d47 <vector73>:
.globl vector73
vector73:
  pushl $0
80107d47:	6a 00                	push   $0x0
  pushl $73
80107d49:	6a 49                	push   $0x49
  jmp alltraps
80107d4b:	e9 dc f6 ff ff       	jmp    8010742c <alltraps>

80107d50 <vector74>:
.globl vector74
vector74:
  pushl $0
80107d50:	6a 00                	push   $0x0
  pushl $74
80107d52:	6a 4a                	push   $0x4a
  jmp alltraps
80107d54:	e9 d3 f6 ff ff       	jmp    8010742c <alltraps>

80107d59 <vector75>:
.globl vector75
vector75:
  pushl $0
80107d59:	6a 00                	push   $0x0
  pushl $75
80107d5b:	6a 4b                	push   $0x4b
  jmp alltraps
80107d5d:	e9 ca f6 ff ff       	jmp    8010742c <alltraps>

80107d62 <vector76>:
.globl vector76
vector76:
  pushl $0
80107d62:	6a 00                	push   $0x0
  pushl $76
80107d64:	6a 4c                	push   $0x4c
  jmp alltraps
80107d66:	e9 c1 f6 ff ff       	jmp    8010742c <alltraps>

80107d6b <vector77>:
.globl vector77
vector77:
  pushl $0
80107d6b:	6a 00                	push   $0x0
  pushl $77
80107d6d:	6a 4d                	push   $0x4d
  jmp alltraps
80107d6f:	e9 b8 f6 ff ff       	jmp    8010742c <alltraps>

80107d74 <vector78>:
.globl vector78
vector78:
  pushl $0
80107d74:	6a 00                	push   $0x0
  pushl $78
80107d76:	6a 4e                	push   $0x4e
  jmp alltraps
80107d78:	e9 af f6 ff ff       	jmp    8010742c <alltraps>

80107d7d <vector79>:
.globl vector79
vector79:
  pushl $0
80107d7d:	6a 00                	push   $0x0
  pushl $79
80107d7f:	6a 4f                	push   $0x4f
  jmp alltraps
80107d81:	e9 a6 f6 ff ff       	jmp    8010742c <alltraps>

80107d86 <vector80>:
.globl vector80
vector80:
  pushl $0
80107d86:	6a 00                	push   $0x0
  pushl $80
80107d88:	6a 50                	push   $0x50
  jmp alltraps
80107d8a:	e9 9d f6 ff ff       	jmp    8010742c <alltraps>

80107d8f <vector81>:
.globl vector81
vector81:
  pushl $0
80107d8f:	6a 00                	push   $0x0
  pushl $81
80107d91:	6a 51                	push   $0x51
  jmp alltraps
80107d93:	e9 94 f6 ff ff       	jmp    8010742c <alltraps>

80107d98 <vector82>:
.globl vector82
vector82:
  pushl $0
80107d98:	6a 00                	push   $0x0
  pushl $82
80107d9a:	6a 52                	push   $0x52
  jmp alltraps
80107d9c:	e9 8b f6 ff ff       	jmp    8010742c <alltraps>

80107da1 <vector83>:
.globl vector83
vector83:
  pushl $0
80107da1:	6a 00                	push   $0x0
  pushl $83
80107da3:	6a 53                	push   $0x53
  jmp alltraps
80107da5:	e9 82 f6 ff ff       	jmp    8010742c <alltraps>

80107daa <vector84>:
.globl vector84
vector84:
  pushl $0
80107daa:	6a 00                	push   $0x0
  pushl $84
80107dac:	6a 54                	push   $0x54
  jmp alltraps
80107dae:	e9 79 f6 ff ff       	jmp    8010742c <alltraps>

80107db3 <vector85>:
.globl vector85
vector85:
  pushl $0
80107db3:	6a 00                	push   $0x0
  pushl $85
80107db5:	6a 55                	push   $0x55
  jmp alltraps
80107db7:	e9 70 f6 ff ff       	jmp    8010742c <alltraps>

80107dbc <vector86>:
.globl vector86
vector86:
  pushl $0
80107dbc:	6a 00                	push   $0x0
  pushl $86
80107dbe:	6a 56                	push   $0x56
  jmp alltraps
80107dc0:	e9 67 f6 ff ff       	jmp    8010742c <alltraps>

80107dc5 <vector87>:
.globl vector87
vector87:
  pushl $0
80107dc5:	6a 00                	push   $0x0
  pushl $87
80107dc7:	6a 57                	push   $0x57
  jmp alltraps
80107dc9:	e9 5e f6 ff ff       	jmp    8010742c <alltraps>

80107dce <vector88>:
.globl vector88
vector88:
  pushl $0
80107dce:	6a 00                	push   $0x0
  pushl $88
80107dd0:	6a 58                	push   $0x58
  jmp alltraps
80107dd2:	e9 55 f6 ff ff       	jmp    8010742c <alltraps>

80107dd7 <vector89>:
.globl vector89
vector89:
  pushl $0
80107dd7:	6a 00                	push   $0x0
  pushl $89
80107dd9:	6a 59                	push   $0x59
  jmp alltraps
80107ddb:	e9 4c f6 ff ff       	jmp    8010742c <alltraps>

80107de0 <vector90>:
.globl vector90
vector90:
  pushl $0
80107de0:	6a 00                	push   $0x0
  pushl $90
80107de2:	6a 5a                	push   $0x5a
  jmp alltraps
80107de4:	e9 43 f6 ff ff       	jmp    8010742c <alltraps>

80107de9 <vector91>:
.globl vector91
vector91:
  pushl $0
80107de9:	6a 00                	push   $0x0
  pushl $91
80107deb:	6a 5b                	push   $0x5b
  jmp alltraps
80107ded:	e9 3a f6 ff ff       	jmp    8010742c <alltraps>

80107df2 <vector92>:
.globl vector92
vector92:
  pushl $0
80107df2:	6a 00                	push   $0x0
  pushl $92
80107df4:	6a 5c                	push   $0x5c
  jmp alltraps
80107df6:	e9 31 f6 ff ff       	jmp    8010742c <alltraps>

80107dfb <vector93>:
.globl vector93
vector93:
  pushl $0
80107dfb:	6a 00                	push   $0x0
  pushl $93
80107dfd:	6a 5d                	push   $0x5d
  jmp alltraps
80107dff:	e9 28 f6 ff ff       	jmp    8010742c <alltraps>

80107e04 <vector94>:
.globl vector94
vector94:
  pushl $0
80107e04:	6a 00                	push   $0x0
  pushl $94
80107e06:	6a 5e                	push   $0x5e
  jmp alltraps
80107e08:	e9 1f f6 ff ff       	jmp    8010742c <alltraps>

80107e0d <vector95>:
.globl vector95
vector95:
  pushl $0
80107e0d:	6a 00                	push   $0x0
  pushl $95
80107e0f:	6a 5f                	push   $0x5f
  jmp alltraps
80107e11:	e9 16 f6 ff ff       	jmp    8010742c <alltraps>

80107e16 <vector96>:
.globl vector96
vector96:
  pushl $0
80107e16:	6a 00                	push   $0x0
  pushl $96
80107e18:	6a 60                	push   $0x60
  jmp alltraps
80107e1a:	e9 0d f6 ff ff       	jmp    8010742c <alltraps>

80107e1f <vector97>:
.globl vector97
vector97:
  pushl $0
80107e1f:	6a 00                	push   $0x0
  pushl $97
80107e21:	6a 61                	push   $0x61
  jmp alltraps
80107e23:	e9 04 f6 ff ff       	jmp    8010742c <alltraps>

80107e28 <vector98>:
.globl vector98
vector98:
  pushl $0
80107e28:	6a 00                	push   $0x0
  pushl $98
80107e2a:	6a 62                	push   $0x62
  jmp alltraps
80107e2c:	e9 fb f5 ff ff       	jmp    8010742c <alltraps>

80107e31 <vector99>:
.globl vector99
vector99:
  pushl $0
80107e31:	6a 00                	push   $0x0
  pushl $99
80107e33:	6a 63                	push   $0x63
  jmp alltraps
80107e35:	e9 f2 f5 ff ff       	jmp    8010742c <alltraps>

80107e3a <vector100>:
.globl vector100
vector100:
  pushl $0
80107e3a:	6a 00                	push   $0x0
  pushl $100
80107e3c:	6a 64                	push   $0x64
  jmp alltraps
80107e3e:	e9 e9 f5 ff ff       	jmp    8010742c <alltraps>

80107e43 <vector101>:
.globl vector101
vector101:
  pushl $0
80107e43:	6a 00                	push   $0x0
  pushl $101
80107e45:	6a 65                	push   $0x65
  jmp alltraps
80107e47:	e9 e0 f5 ff ff       	jmp    8010742c <alltraps>

80107e4c <vector102>:
.globl vector102
vector102:
  pushl $0
80107e4c:	6a 00                	push   $0x0
  pushl $102
80107e4e:	6a 66                	push   $0x66
  jmp alltraps
80107e50:	e9 d7 f5 ff ff       	jmp    8010742c <alltraps>

80107e55 <vector103>:
.globl vector103
vector103:
  pushl $0
80107e55:	6a 00                	push   $0x0
  pushl $103
80107e57:	6a 67                	push   $0x67
  jmp alltraps
80107e59:	e9 ce f5 ff ff       	jmp    8010742c <alltraps>

80107e5e <vector104>:
.globl vector104
vector104:
  pushl $0
80107e5e:	6a 00                	push   $0x0
  pushl $104
80107e60:	6a 68                	push   $0x68
  jmp alltraps
80107e62:	e9 c5 f5 ff ff       	jmp    8010742c <alltraps>

80107e67 <vector105>:
.globl vector105
vector105:
  pushl $0
80107e67:	6a 00                	push   $0x0
  pushl $105
80107e69:	6a 69                	push   $0x69
  jmp alltraps
80107e6b:	e9 bc f5 ff ff       	jmp    8010742c <alltraps>

80107e70 <vector106>:
.globl vector106
vector106:
  pushl $0
80107e70:	6a 00                	push   $0x0
  pushl $106
80107e72:	6a 6a                	push   $0x6a
  jmp alltraps
80107e74:	e9 b3 f5 ff ff       	jmp    8010742c <alltraps>

80107e79 <vector107>:
.globl vector107
vector107:
  pushl $0
80107e79:	6a 00                	push   $0x0
  pushl $107
80107e7b:	6a 6b                	push   $0x6b
  jmp alltraps
80107e7d:	e9 aa f5 ff ff       	jmp    8010742c <alltraps>

80107e82 <vector108>:
.globl vector108
vector108:
  pushl $0
80107e82:	6a 00                	push   $0x0
  pushl $108
80107e84:	6a 6c                	push   $0x6c
  jmp alltraps
80107e86:	e9 a1 f5 ff ff       	jmp    8010742c <alltraps>

80107e8b <vector109>:
.globl vector109
vector109:
  pushl $0
80107e8b:	6a 00                	push   $0x0
  pushl $109
80107e8d:	6a 6d                	push   $0x6d
  jmp alltraps
80107e8f:	e9 98 f5 ff ff       	jmp    8010742c <alltraps>

80107e94 <vector110>:
.globl vector110
vector110:
  pushl $0
80107e94:	6a 00                	push   $0x0
  pushl $110
80107e96:	6a 6e                	push   $0x6e
  jmp alltraps
80107e98:	e9 8f f5 ff ff       	jmp    8010742c <alltraps>

80107e9d <vector111>:
.globl vector111
vector111:
  pushl $0
80107e9d:	6a 00                	push   $0x0
  pushl $111
80107e9f:	6a 6f                	push   $0x6f
  jmp alltraps
80107ea1:	e9 86 f5 ff ff       	jmp    8010742c <alltraps>

80107ea6 <vector112>:
.globl vector112
vector112:
  pushl $0
80107ea6:	6a 00                	push   $0x0
  pushl $112
80107ea8:	6a 70                	push   $0x70
  jmp alltraps
80107eaa:	e9 7d f5 ff ff       	jmp    8010742c <alltraps>

80107eaf <vector113>:
.globl vector113
vector113:
  pushl $0
80107eaf:	6a 00                	push   $0x0
  pushl $113
80107eb1:	6a 71                	push   $0x71
  jmp alltraps
80107eb3:	e9 74 f5 ff ff       	jmp    8010742c <alltraps>

80107eb8 <vector114>:
.globl vector114
vector114:
  pushl $0
80107eb8:	6a 00                	push   $0x0
  pushl $114
80107eba:	6a 72                	push   $0x72
  jmp alltraps
80107ebc:	e9 6b f5 ff ff       	jmp    8010742c <alltraps>

80107ec1 <vector115>:
.globl vector115
vector115:
  pushl $0
80107ec1:	6a 00                	push   $0x0
  pushl $115
80107ec3:	6a 73                	push   $0x73
  jmp alltraps
80107ec5:	e9 62 f5 ff ff       	jmp    8010742c <alltraps>

80107eca <vector116>:
.globl vector116
vector116:
  pushl $0
80107eca:	6a 00                	push   $0x0
  pushl $116
80107ecc:	6a 74                	push   $0x74
  jmp alltraps
80107ece:	e9 59 f5 ff ff       	jmp    8010742c <alltraps>

80107ed3 <vector117>:
.globl vector117
vector117:
  pushl $0
80107ed3:	6a 00                	push   $0x0
  pushl $117
80107ed5:	6a 75                	push   $0x75
  jmp alltraps
80107ed7:	e9 50 f5 ff ff       	jmp    8010742c <alltraps>

80107edc <vector118>:
.globl vector118
vector118:
  pushl $0
80107edc:	6a 00                	push   $0x0
  pushl $118
80107ede:	6a 76                	push   $0x76
  jmp alltraps
80107ee0:	e9 47 f5 ff ff       	jmp    8010742c <alltraps>

80107ee5 <vector119>:
.globl vector119
vector119:
  pushl $0
80107ee5:	6a 00                	push   $0x0
  pushl $119
80107ee7:	6a 77                	push   $0x77
  jmp alltraps
80107ee9:	e9 3e f5 ff ff       	jmp    8010742c <alltraps>

80107eee <vector120>:
.globl vector120
vector120:
  pushl $0
80107eee:	6a 00                	push   $0x0
  pushl $120
80107ef0:	6a 78                	push   $0x78
  jmp alltraps
80107ef2:	e9 35 f5 ff ff       	jmp    8010742c <alltraps>

80107ef7 <vector121>:
.globl vector121
vector121:
  pushl $0
80107ef7:	6a 00                	push   $0x0
  pushl $121
80107ef9:	6a 79                	push   $0x79
  jmp alltraps
80107efb:	e9 2c f5 ff ff       	jmp    8010742c <alltraps>

80107f00 <vector122>:
.globl vector122
vector122:
  pushl $0
80107f00:	6a 00                	push   $0x0
  pushl $122
80107f02:	6a 7a                	push   $0x7a
  jmp alltraps
80107f04:	e9 23 f5 ff ff       	jmp    8010742c <alltraps>

80107f09 <vector123>:
.globl vector123
vector123:
  pushl $0
80107f09:	6a 00                	push   $0x0
  pushl $123
80107f0b:	6a 7b                	push   $0x7b
  jmp alltraps
80107f0d:	e9 1a f5 ff ff       	jmp    8010742c <alltraps>

80107f12 <vector124>:
.globl vector124
vector124:
  pushl $0
80107f12:	6a 00                	push   $0x0
  pushl $124
80107f14:	6a 7c                	push   $0x7c
  jmp alltraps
80107f16:	e9 11 f5 ff ff       	jmp    8010742c <alltraps>

80107f1b <vector125>:
.globl vector125
vector125:
  pushl $0
80107f1b:	6a 00                	push   $0x0
  pushl $125
80107f1d:	6a 7d                	push   $0x7d
  jmp alltraps
80107f1f:	e9 08 f5 ff ff       	jmp    8010742c <alltraps>

80107f24 <vector126>:
.globl vector126
vector126:
  pushl $0
80107f24:	6a 00                	push   $0x0
  pushl $126
80107f26:	6a 7e                	push   $0x7e
  jmp alltraps
80107f28:	e9 ff f4 ff ff       	jmp    8010742c <alltraps>

80107f2d <vector127>:
.globl vector127
vector127:
  pushl $0
80107f2d:	6a 00                	push   $0x0
  pushl $127
80107f2f:	6a 7f                	push   $0x7f
  jmp alltraps
80107f31:	e9 f6 f4 ff ff       	jmp    8010742c <alltraps>

80107f36 <vector128>:
.globl vector128
vector128:
  pushl $0
80107f36:	6a 00                	push   $0x0
  pushl $128
80107f38:	68 80 00 00 00       	push   $0x80
  jmp alltraps
80107f3d:	e9 ea f4 ff ff       	jmp    8010742c <alltraps>

80107f42 <vector129>:
.globl vector129
vector129:
  pushl $0
80107f42:	6a 00                	push   $0x0
  pushl $129
80107f44:	68 81 00 00 00       	push   $0x81
  jmp alltraps
80107f49:	e9 de f4 ff ff       	jmp    8010742c <alltraps>

80107f4e <vector130>:
.globl vector130
vector130:
  pushl $0
80107f4e:	6a 00                	push   $0x0
  pushl $130
80107f50:	68 82 00 00 00       	push   $0x82
  jmp alltraps
80107f55:	e9 d2 f4 ff ff       	jmp    8010742c <alltraps>

80107f5a <vector131>:
.globl vector131
vector131:
  pushl $0
80107f5a:	6a 00                	push   $0x0
  pushl $131
80107f5c:	68 83 00 00 00       	push   $0x83
  jmp alltraps
80107f61:	e9 c6 f4 ff ff       	jmp    8010742c <alltraps>

80107f66 <vector132>:
.globl vector132
vector132:
  pushl $0
80107f66:	6a 00                	push   $0x0
  pushl $132
80107f68:	68 84 00 00 00       	push   $0x84
  jmp alltraps
80107f6d:	e9 ba f4 ff ff       	jmp    8010742c <alltraps>

80107f72 <vector133>:
.globl vector133
vector133:
  pushl $0
80107f72:	6a 00                	push   $0x0
  pushl $133
80107f74:	68 85 00 00 00       	push   $0x85
  jmp alltraps
80107f79:	e9 ae f4 ff ff       	jmp    8010742c <alltraps>

80107f7e <vector134>:
.globl vector134
vector134:
  pushl $0
80107f7e:	6a 00                	push   $0x0
  pushl $134
80107f80:	68 86 00 00 00       	push   $0x86
  jmp alltraps
80107f85:	e9 a2 f4 ff ff       	jmp    8010742c <alltraps>

80107f8a <vector135>:
.globl vector135
vector135:
  pushl $0
80107f8a:	6a 00                	push   $0x0
  pushl $135
80107f8c:	68 87 00 00 00       	push   $0x87
  jmp alltraps
80107f91:	e9 96 f4 ff ff       	jmp    8010742c <alltraps>

80107f96 <vector136>:
.globl vector136
vector136:
  pushl $0
80107f96:	6a 00                	push   $0x0
  pushl $136
80107f98:	68 88 00 00 00       	push   $0x88
  jmp alltraps
80107f9d:	e9 8a f4 ff ff       	jmp    8010742c <alltraps>

80107fa2 <vector137>:
.globl vector137
vector137:
  pushl $0
80107fa2:	6a 00                	push   $0x0
  pushl $137
80107fa4:	68 89 00 00 00       	push   $0x89
  jmp alltraps
80107fa9:	e9 7e f4 ff ff       	jmp    8010742c <alltraps>

80107fae <vector138>:
.globl vector138
vector138:
  pushl $0
80107fae:	6a 00                	push   $0x0
  pushl $138
80107fb0:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
80107fb5:	e9 72 f4 ff ff       	jmp    8010742c <alltraps>

80107fba <vector139>:
.globl vector139
vector139:
  pushl $0
80107fba:	6a 00                	push   $0x0
  pushl $139
80107fbc:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
80107fc1:	e9 66 f4 ff ff       	jmp    8010742c <alltraps>

80107fc6 <vector140>:
.globl vector140
vector140:
  pushl $0
80107fc6:	6a 00                	push   $0x0
  pushl $140
80107fc8:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
80107fcd:	e9 5a f4 ff ff       	jmp    8010742c <alltraps>

80107fd2 <vector141>:
.globl vector141
vector141:
  pushl $0
80107fd2:	6a 00                	push   $0x0
  pushl $141
80107fd4:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
80107fd9:	e9 4e f4 ff ff       	jmp    8010742c <alltraps>

80107fde <vector142>:
.globl vector142
vector142:
  pushl $0
80107fde:	6a 00                	push   $0x0
  pushl $142
80107fe0:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
80107fe5:	e9 42 f4 ff ff       	jmp    8010742c <alltraps>

80107fea <vector143>:
.globl vector143
vector143:
  pushl $0
80107fea:	6a 00                	push   $0x0
  pushl $143
80107fec:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
80107ff1:	e9 36 f4 ff ff       	jmp    8010742c <alltraps>

80107ff6 <vector144>:
.globl vector144
vector144:
  pushl $0
80107ff6:	6a 00                	push   $0x0
  pushl $144
80107ff8:	68 90 00 00 00       	push   $0x90
  jmp alltraps
80107ffd:	e9 2a f4 ff ff       	jmp    8010742c <alltraps>

80108002 <vector145>:
.globl vector145
vector145:
  pushl $0
80108002:	6a 00                	push   $0x0
  pushl $145
80108004:	68 91 00 00 00       	push   $0x91
  jmp alltraps
80108009:	e9 1e f4 ff ff       	jmp    8010742c <alltraps>

8010800e <vector146>:
.globl vector146
vector146:
  pushl $0
8010800e:	6a 00                	push   $0x0
  pushl $146
80108010:	68 92 00 00 00       	push   $0x92
  jmp alltraps
80108015:	e9 12 f4 ff ff       	jmp    8010742c <alltraps>

8010801a <vector147>:
.globl vector147
vector147:
  pushl $0
8010801a:	6a 00                	push   $0x0
  pushl $147
8010801c:	68 93 00 00 00       	push   $0x93
  jmp alltraps
80108021:	e9 06 f4 ff ff       	jmp    8010742c <alltraps>

80108026 <vector148>:
.globl vector148
vector148:
  pushl $0
80108026:	6a 00                	push   $0x0
  pushl $148
80108028:	68 94 00 00 00       	push   $0x94
  jmp alltraps
8010802d:	e9 fa f3 ff ff       	jmp    8010742c <alltraps>

80108032 <vector149>:
.globl vector149
vector149:
  pushl $0
80108032:	6a 00                	push   $0x0
  pushl $149
80108034:	68 95 00 00 00       	push   $0x95
  jmp alltraps
80108039:	e9 ee f3 ff ff       	jmp    8010742c <alltraps>

8010803e <vector150>:
.globl vector150
vector150:
  pushl $0
8010803e:	6a 00                	push   $0x0
  pushl $150
80108040:	68 96 00 00 00       	push   $0x96
  jmp alltraps
80108045:	e9 e2 f3 ff ff       	jmp    8010742c <alltraps>

8010804a <vector151>:
.globl vector151
vector151:
  pushl $0
8010804a:	6a 00                	push   $0x0
  pushl $151
8010804c:	68 97 00 00 00       	push   $0x97
  jmp alltraps
80108051:	e9 d6 f3 ff ff       	jmp    8010742c <alltraps>

80108056 <vector152>:
.globl vector152
vector152:
  pushl $0
80108056:	6a 00                	push   $0x0
  pushl $152
80108058:	68 98 00 00 00       	push   $0x98
  jmp alltraps
8010805d:	e9 ca f3 ff ff       	jmp    8010742c <alltraps>

80108062 <vector153>:
.globl vector153
vector153:
  pushl $0
80108062:	6a 00                	push   $0x0
  pushl $153
80108064:	68 99 00 00 00       	push   $0x99
  jmp alltraps
80108069:	e9 be f3 ff ff       	jmp    8010742c <alltraps>

8010806e <vector154>:
.globl vector154
vector154:
  pushl $0
8010806e:	6a 00                	push   $0x0
  pushl $154
80108070:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
80108075:	e9 b2 f3 ff ff       	jmp    8010742c <alltraps>

8010807a <vector155>:
.globl vector155
vector155:
  pushl $0
8010807a:	6a 00                	push   $0x0
  pushl $155
8010807c:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
80108081:	e9 a6 f3 ff ff       	jmp    8010742c <alltraps>

80108086 <vector156>:
.globl vector156
vector156:
  pushl $0
80108086:	6a 00                	push   $0x0
  pushl $156
80108088:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
8010808d:	e9 9a f3 ff ff       	jmp    8010742c <alltraps>

80108092 <vector157>:
.globl vector157
vector157:
  pushl $0
80108092:	6a 00                	push   $0x0
  pushl $157
80108094:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
80108099:	e9 8e f3 ff ff       	jmp    8010742c <alltraps>

8010809e <vector158>:
.globl vector158
vector158:
  pushl $0
8010809e:	6a 00                	push   $0x0
  pushl $158
801080a0:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
801080a5:	e9 82 f3 ff ff       	jmp    8010742c <alltraps>

801080aa <vector159>:
.globl vector159
vector159:
  pushl $0
801080aa:	6a 00                	push   $0x0
  pushl $159
801080ac:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
801080b1:	e9 76 f3 ff ff       	jmp    8010742c <alltraps>

801080b6 <vector160>:
.globl vector160
vector160:
  pushl $0
801080b6:	6a 00                	push   $0x0
  pushl $160
801080b8:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
801080bd:	e9 6a f3 ff ff       	jmp    8010742c <alltraps>

801080c2 <vector161>:
.globl vector161
vector161:
  pushl $0
801080c2:	6a 00                	push   $0x0
  pushl $161
801080c4:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
801080c9:	e9 5e f3 ff ff       	jmp    8010742c <alltraps>

801080ce <vector162>:
.globl vector162
vector162:
  pushl $0
801080ce:	6a 00                	push   $0x0
  pushl $162
801080d0:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
801080d5:	e9 52 f3 ff ff       	jmp    8010742c <alltraps>

801080da <vector163>:
.globl vector163
vector163:
  pushl $0
801080da:	6a 00                	push   $0x0
  pushl $163
801080dc:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
801080e1:	e9 46 f3 ff ff       	jmp    8010742c <alltraps>

801080e6 <vector164>:
.globl vector164
vector164:
  pushl $0
801080e6:	6a 00                	push   $0x0
  pushl $164
801080e8:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
801080ed:	e9 3a f3 ff ff       	jmp    8010742c <alltraps>

801080f2 <vector165>:
.globl vector165
vector165:
  pushl $0
801080f2:	6a 00                	push   $0x0
  pushl $165
801080f4:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
801080f9:	e9 2e f3 ff ff       	jmp    8010742c <alltraps>

801080fe <vector166>:
.globl vector166
vector166:
  pushl $0
801080fe:	6a 00                	push   $0x0
  pushl $166
80108100:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
80108105:	e9 22 f3 ff ff       	jmp    8010742c <alltraps>

8010810a <vector167>:
.globl vector167
vector167:
  pushl $0
8010810a:	6a 00                	push   $0x0
  pushl $167
8010810c:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
80108111:	e9 16 f3 ff ff       	jmp    8010742c <alltraps>

80108116 <vector168>:
.globl vector168
vector168:
  pushl $0
80108116:	6a 00                	push   $0x0
  pushl $168
80108118:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
8010811d:	e9 0a f3 ff ff       	jmp    8010742c <alltraps>

80108122 <vector169>:
.globl vector169
vector169:
  pushl $0
80108122:	6a 00                	push   $0x0
  pushl $169
80108124:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
80108129:	e9 fe f2 ff ff       	jmp    8010742c <alltraps>

8010812e <vector170>:
.globl vector170
vector170:
  pushl $0
8010812e:	6a 00                	push   $0x0
  pushl $170
80108130:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
80108135:	e9 f2 f2 ff ff       	jmp    8010742c <alltraps>

8010813a <vector171>:
.globl vector171
vector171:
  pushl $0
8010813a:	6a 00                	push   $0x0
  pushl $171
8010813c:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
80108141:	e9 e6 f2 ff ff       	jmp    8010742c <alltraps>

80108146 <vector172>:
.globl vector172
vector172:
  pushl $0
80108146:	6a 00                	push   $0x0
  pushl $172
80108148:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
8010814d:	e9 da f2 ff ff       	jmp    8010742c <alltraps>

80108152 <vector173>:
.globl vector173
vector173:
  pushl $0
80108152:	6a 00                	push   $0x0
  pushl $173
80108154:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
80108159:	e9 ce f2 ff ff       	jmp    8010742c <alltraps>

8010815e <vector174>:
.globl vector174
vector174:
  pushl $0
8010815e:	6a 00                	push   $0x0
  pushl $174
80108160:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
80108165:	e9 c2 f2 ff ff       	jmp    8010742c <alltraps>

8010816a <vector175>:
.globl vector175
vector175:
  pushl $0
8010816a:	6a 00                	push   $0x0
  pushl $175
8010816c:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
80108171:	e9 b6 f2 ff ff       	jmp    8010742c <alltraps>

80108176 <vector176>:
.globl vector176
vector176:
  pushl $0
80108176:	6a 00                	push   $0x0
  pushl $176
80108178:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
8010817d:	e9 aa f2 ff ff       	jmp    8010742c <alltraps>

80108182 <vector177>:
.globl vector177
vector177:
  pushl $0
80108182:	6a 00                	push   $0x0
  pushl $177
80108184:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
80108189:	e9 9e f2 ff ff       	jmp    8010742c <alltraps>

8010818e <vector178>:
.globl vector178
vector178:
  pushl $0
8010818e:	6a 00                	push   $0x0
  pushl $178
80108190:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
80108195:	e9 92 f2 ff ff       	jmp    8010742c <alltraps>

8010819a <vector179>:
.globl vector179
vector179:
  pushl $0
8010819a:	6a 00                	push   $0x0
  pushl $179
8010819c:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
801081a1:	e9 86 f2 ff ff       	jmp    8010742c <alltraps>

801081a6 <vector180>:
.globl vector180
vector180:
  pushl $0
801081a6:	6a 00                	push   $0x0
  pushl $180
801081a8:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
801081ad:	e9 7a f2 ff ff       	jmp    8010742c <alltraps>

801081b2 <vector181>:
.globl vector181
vector181:
  pushl $0
801081b2:	6a 00                	push   $0x0
  pushl $181
801081b4:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
801081b9:	e9 6e f2 ff ff       	jmp    8010742c <alltraps>

801081be <vector182>:
.globl vector182
vector182:
  pushl $0
801081be:	6a 00                	push   $0x0
  pushl $182
801081c0:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
801081c5:	e9 62 f2 ff ff       	jmp    8010742c <alltraps>

801081ca <vector183>:
.globl vector183
vector183:
  pushl $0
801081ca:	6a 00                	push   $0x0
  pushl $183
801081cc:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
801081d1:	e9 56 f2 ff ff       	jmp    8010742c <alltraps>

801081d6 <vector184>:
.globl vector184
vector184:
  pushl $0
801081d6:	6a 00                	push   $0x0
  pushl $184
801081d8:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
801081dd:	e9 4a f2 ff ff       	jmp    8010742c <alltraps>

801081e2 <vector185>:
.globl vector185
vector185:
  pushl $0
801081e2:	6a 00                	push   $0x0
  pushl $185
801081e4:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
801081e9:	e9 3e f2 ff ff       	jmp    8010742c <alltraps>

801081ee <vector186>:
.globl vector186
vector186:
  pushl $0
801081ee:	6a 00                	push   $0x0
  pushl $186
801081f0:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
801081f5:	e9 32 f2 ff ff       	jmp    8010742c <alltraps>

801081fa <vector187>:
.globl vector187
vector187:
  pushl $0
801081fa:	6a 00                	push   $0x0
  pushl $187
801081fc:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
80108201:	e9 26 f2 ff ff       	jmp    8010742c <alltraps>

80108206 <vector188>:
.globl vector188
vector188:
  pushl $0
80108206:	6a 00                	push   $0x0
  pushl $188
80108208:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
8010820d:	e9 1a f2 ff ff       	jmp    8010742c <alltraps>

80108212 <vector189>:
.globl vector189
vector189:
  pushl $0
80108212:	6a 00                	push   $0x0
  pushl $189
80108214:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
80108219:	e9 0e f2 ff ff       	jmp    8010742c <alltraps>

8010821e <vector190>:
.globl vector190
vector190:
  pushl $0
8010821e:	6a 00                	push   $0x0
  pushl $190
80108220:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
80108225:	e9 02 f2 ff ff       	jmp    8010742c <alltraps>

8010822a <vector191>:
.globl vector191
vector191:
  pushl $0
8010822a:	6a 00                	push   $0x0
  pushl $191
8010822c:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
80108231:	e9 f6 f1 ff ff       	jmp    8010742c <alltraps>

80108236 <vector192>:
.globl vector192
vector192:
  pushl $0
80108236:	6a 00                	push   $0x0
  pushl $192
80108238:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
8010823d:	e9 ea f1 ff ff       	jmp    8010742c <alltraps>

80108242 <vector193>:
.globl vector193
vector193:
  pushl $0
80108242:	6a 00                	push   $0x0
  pushl $193
80108244:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
80108249:	e9 de f1 ff ff       	jmp    8010742c <alltraps>

8010824e <vector194>:
.globl vector194
vector194:
  pushl $0
8010824e:	6a 00                	push   $0x0
  pushl $194
80108250:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
80108255:	e9 d2 f1 ff ff       	jmp    8010742c <alltraps>

8010825a <vector195>:
.globl vector195
vector195:
  pushl $0
8010825a:	6a 00                	push   $0x0
  pushl $195
8010825c:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
80108261:	e9 c6 f1 ff ff       	jmp    8010742c <alltraps>

80108266 <vector196>:
.globl vector196
vector196:
  pushl $0
80108266:	6a 00                	push   $0x0
  pushl $196
80108268:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
8010826d:	e9 ba f1 ff ff       	jmp    8010742c <alltraps>

80108272 <vector197>:
.globl vector197
vector197:
  pushl $0
80108272:	6a 00                	push   $0x0
  pushl $197
80108274:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
80108279:	e9 ae f1 ff ff       	jmp    8010742c <alltraps>

8010827e <vector198>:
.globl vector198
vector198:
  pushl $0
8010827e:	6a 00                	push   $0x0
  pushl $198
80108280:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
80108285:	e9 a2 f1 ff ff       	jmp    8010742c <alltraps>

8010828a <vector199>:
.globl vector199
vector199:
  pushl $0
8010828a:	6a 00                	push   $0x0
  pushl $199
8010828c:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
80108291:	e9 96 f1 ff ff       	jmp    8010742c <alltraps>

80108296 <vector200>:
.globl vector200
vector200:
  pushl $0
80108296:	6a 00                	push   $0x0
  pushl $200
80108298:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
8010829d:	e9 8a f1 ff ff       	jmp    8010742c <alltraps>

801082a2 <vector201>:
.globl vector201
vector201:
  pushl $0
801082a2:	6a 00                	push   $0x0
  pushl $201
801082a4:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
801082a9:	e9 7e f1 ff ff       	jmp    8010742c <alltraps>

801082ae <vector202>:
.globl vector202
vector202:
  pushl $0
801082ae:	6a 00                	push   $0x0
  pushl $202
801082b0:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
801082b5:	e9 72 f1 ff ff       	jmp    8010742c <alltraps>

801082ba <vector203>:
.globl vector203
vector203:
  pushl $0
801082ba:	6a 00                	push   $0x0
  pushl $203
801082bc:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
801082c1:	e9 66 f1 ff ff       	jmp    8010742c <alltraps>

801082c6 <vector204>:
.globl vector204
vector204:
  pushl $0
801082c6:	6a 00                	push   $0x0
  pushl $204
801082c8:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
801082cd:	e9 5a f1 ff ff       	jmp    8010742c <alltraps>

801082d2 <vector205>:
.globl vector205
vector205:
  pushl $0
801082d2:	6a 00                	push   $0x0
  pushl $205
801082d4:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
801082d9:	e9 4e f1 ff ff       	jmp    8010742c <alltraps>

801082de <vector206>:
.globl vector206
vector206:
  pushl $0
801082de:	6a 00                	push   $0x0
  pushl $206
801082e0:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
801082e5:	e9 42 f1 ff ff       	jmp    8010742c <alltraps>

801082ea <vector207>:
.globl vector207
vector207:
  pushl $0
801082ea:	6a 00                	push   $0x0
  pushl $207
801082ec:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
801082f1:	e9 36 f1 ff ff       	jmp    8010742c <alltraps>

801082f6 <vector208>:
.globl vector208
vector208:
  pushl $0
801082f6:	6a 00                	push   $0x0
  pushl $208
801082f8:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
801082fd:	e9 2a f1 ff ff       	jmp    8010742c <alltraps>

80108302 <vector209>:
.globl vector209
vector209:
  pushl $0
80108302:	6a 00                	push   $0x0
  pushl $209
80108304:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
80108309:	e9 1e f1 ff ff       	jmp    8010742c <alltraps>

8010830e <vector210>:
.globl vector210
vector210:
  pushl $0
8010830e:	6a 00                	push   $0x0
  pushl $210
80108310:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
80108315:	e9 12 f1 ff ff       	jmp    8010742c <alltraps>

8010831a <vector211>:
.globl vector211
vector211:
  pushl $0
8010831a:	6a 00                	push   $0x0
  pushl $211
8010831c:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
80108321:	e9 06 f1 ff ff       	jmp    8010742c <alltraps>

80108326 <vector212>:
.globl vector212
vector212:
  pushl $0
80108326:	6a 00                	push   $0x0
  pushl $212
80108328:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
8010832d:	e9 fa f0 ff ff       	jmp    8010742c <alltraps>

80108332 <vector213>:
.globl vector213
vector213:
  pushl $0
80108332:	6a 00                	push   $0x0
  pushl $213
80108334:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
80108339:	e9 ee f0 ff ff       	jmp    8010742c <alltraps>

8010833e <vector214>:
.globl vector214
vector214:
  pushl $0
8010833e:	6a 00                	push   $0x0
  pushl $214
80108340:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
80108345:	e9 e2 f0 ff ff       	jmp    8010742c <alltraps>

8010834a <vector215>:
.globl vector215
vector215:
  pushl $0
8010834a:	6a 00                	push   $0x0
  pushl $215
8010834c:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
80108351:	e9 d6 f0 ff ff       	jmp    8010742c <alltraps>

80108356 <vector216>:
.globl vector216
vector216:
  pushl $0
80108356:	6a 00                	push   $0x0
  pushl $216
80108358:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
8010835d:	e9 ca f0 ff ff       	jmp    8010742c <alltraps>

80108362 <vector217>:
.globl vector217
vector217:
  pushl $0
80108362:	6a 00                	push   $0x0
  pushl $217
80108364:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
80108369:	e9 be f0 ff ff       	jmp    8010742c <alltraps>

8010836e <vector218>:
.globl vector218
vector218:
  pushl $0
8010836e:	6a 00                	push   $0x0
  pushl $218
80108370:	68 da 00 00 00       	push   $0xda
  jmp alltraps
80108375:	e9 b2 f0 ff ff       	jmp    8010742c <alltraps>

8010837a <vector219>:
.globl vector219
vector219:
  pushl $0
8010837a:	6a 00                	push   $0x0
  pushl $219
8010837c:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
80108381:	e9 a6 f0 ff ff       	jmp    8010742c <alltraps>

80108386 <vector220>:
.globl vector220
vector220:
  pushl $0
80108386:	6a 00                	push   $0x0
  pushl $220
80108388:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
8010838d:	e9 9a f0 ff ff       	jmp    8010742c <alltraps>

80108392 <vector221>:
.globl vector221
vector221:
  pushl $0
80108392:	6a 00                	push   $0x0
  pushl $221
80108394:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
80108399:	e9 8e f0 ff ff       	jmp    8010742c <alltraps>

8010839e <vector222>:
.globl vector222
vector222:
  pushl $0
8010839e:	6a 00                	push   $0x0
  pushl $222
801083a0:	68 de 00 00 00       	push   $0xde
  jmp alltraps
801083a5:	e9 82 f0 ff ff       	jmp    8010742c <alltraps>

801083aa <vector223>:
.globl vector223
vector223:
  pushl $0
801083aa:	6a 00                	push   $0x0
  pushl $223
801083ac:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
801083b1:	e9 76 f0 ff ff       	jmp    8010742c <alltraps>

801083b6 <vector224>:
.globl vector224
vector224:
  pushl $0
801083b6:	6a 00                	push   $0x0
  pushl $224
801083b8:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
801083bd:	e9 6a f0 ff ff       	jmp    8010742c <alltraps>

801083c2 <vector225>:
.globl vector225
vector225:
  pushl $0
801083c2:	6a 00                	push   $0x0
  pushl $225
801083c4:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
801083c9:	e9 5e f0 ff ff       	jmp    8010742c <alltraps>

801083ce <vector226>:
.globl vector226
vector226:
  pushl $0
801083ce:	6a 00                	push   $0x0
  pushl $226
801083d0:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
801083d5:	e9 52 f0 ff ff       	jmp    8010742c <alltraps>

801083da <vector227>:
.globl vector227
vector227:
  pushl $0
801083da:	6a 00                	push   $0x0
  pushl $227
801083dc:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
801083e1:	e9 46 f0 ff ff       	jmp    8010742c <alltraps>

801083e6 <vector228>:
.globl vector228
vector228:
  pushl $0
801083e6:	6a 00                	push   $0x0
  pushl $228
801083e8:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
801083ed:	e9 3a f0 ff ff       	jmp    8010742c <alltraps>

801083f2 <vector229>:
.globl vector229
vector229:
  pushl $0
801083f2:	6a 00                	push   $0x0
  pushl $229
801083f4:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
801083f9:	e9 2e f0 ff ff       	jmp    8010742c <alltraps>

801083fe <vector230>:
.globl vector230
vector230:
  pushl $0
801083fe:	6a 00                	push   $0x0
  pushl $230
80108400:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
80108405:	e9 22 f0 ff ff       	jmp    8010742c <alltraps>

8010840a <vector231>:
.globl vector231
vector231:
  pushl $0
8010840a:	6a 00                	push   $0x0
  pushl $231
8010840c:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
80108411:	e9 16 f0 ff ff       	jmp    8010742c <alltraps>

80108416 <vector232>:
.globl vector232
vector232:
  pushl $0
80108416:	6a 00                	push   $0x0
  pushl $232
80108418:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
8010841d:	e9 0a f0 ff ff       	jmp    8010742c <alltraps>

80108422 <vector233>:
.globl vector233
vector233:
  pushl $0
80108422:	6a 00                	push   $0x0
  pushl $233
80108424:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
80108429:	e9 fe ef ff ff       	jmp    8010742c <alltraps>

8010842e <vector234>:
.globl vector234
vector234:
  pushl $0
8010842e:	6a 00                	push   $0x0
  pushl $234
80108430:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
80108435:	e9 f2 ef ff ff       	jmp    8010742c <alltraps>

8010843a <vector235>:
.globl vector235
vector235:
  pushl $0
8010843a:	6a 00                	push   $0x0
  pushl $235
8010843c:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
80108441:	e9 e6 ef ff ff       	jmp    8010742c <alltraps>

80108446 <vector236>:
.globl vector236
vector236:
  pushl $0
80108446:	6a 00                	push   $0x0
  pushl $236
80108448:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
8010844d:	e9 da ef ff ff       	jmp    8010742c <alltraps>

80108452 <vector237>:
.globl vector237
vector237:
  pushl $0
80108452:	6a 00                	push   $0x0
  pushl $237
80108454:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
80108459:	e9 ce ef ff ff       	jmp    8010742c <alltraps>

8010845e <vector238>:
.globl vector238
vector238:
  pushl $0
8010845e:	6a 00                	push   $0x0
  pushl $238
80108460:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
80108465:	e9 c2 ef ff ff       	jmp    8010742c <alltraps>

8010846a <vector239>:
.globl vector239
vector239:
  pushl $0
8010846a:	6a 00                	push   $0x0
  pushl $239
8010846c:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
80108471:	e9 b6 ef ff ff       	jmp    8010742c <alltraps>

80108476 <vector240>:
.globl vector240
vector240:
  pushl $0
80108476:	6a 00                	push   $0x0
  pushl $240
80108478:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
8010847d:	e9 aa ef ff ff       	jmp    8010742c <alltraps>

80108482 <vector241>:
.globl vector241
vector241:
  pushl $0
80108482:	6a 00                	push   $0x0
  pushl $241
80108484:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
80108489:	e9 9e ef ff ff       	jmp    8010742c <alltraps>

8010848e <vector242>:
.globl vector242
vector242:
  pushl $0
8010848e:	6a 00                	push   $0x0
  pushl $242
80108490:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
80108495:	e9 92 ef ff ff       	jmp    8010742c <alltraps>

8010849a <vector243>:
.globl vector243
vector243:
  pushl $0
8010849a:	6a 00                	push   $0x0
  pushl $243
8010849c:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
801084a1:	e9 86 ef ff ff       	jmp    8010742c <alltraps>

801084a6 <vector244>:
.globl vector244
vector244:
  pushl $0
801084a6:	6a 00                	push   $0x0
  pushl $244
801084a8:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
801084ad:	e9 7a ef ff ff       	jmp    8010742c <alltraps>

801084b2 <vector245>:
.globl vector245
vector245:
  pushl $0
801084b2:	6a 00                	push   $0x0
  pushl $245
801084b4:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
801084b9:	e9 6e ef ff ff       	jmp    8010742c <alltraps>

801084be <vector246>:
.globl vector246
vector246:
  pushl $0
801084be:	6a 00                	push   $0x0
  pushl $246
801084c0:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
801084c5:	e9 62 ef ff ff       	jmp    8010742c <alltraps>

801084ca <vector247>:
.globl vector247
vector247:
  pushl $0
801084ca:	6a 00                	push   $0x0
  pushl $247
801084cc:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
801084d1:	e9 56 ef ff ff       	jmp    8010742c <alltraps>

801084d6 <vector248>:
.globl vector248
vector248:
  pushl $0
801084d6:	6a 00                	push   $0x0
  pushl $248
801084d8:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
801084dd:	e9 4a ef ff ff       	jmp    8010742c <alltraps>

801084e2 <vector249>:
.globl vector249
vector249:
  pushl $0
801084e2:	6a 00                	push   $0x0
  pushl $249
801084e4:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
801084e9:	e9 3e ef ff ff       	jmp    8010742c <alltraps>

801084ee <vector250>:
.globl vector250
vector250:
  pushl $0
801084ee:	6a 00                	push   $0x0
  pushl $250
801084f0:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
801084f5:	e9 32 ef ff ff       	jmp    8010742c <alltraps>

801084fa <vector251>:
.globl vector251
vector251:
  pushl $0
801084fa:	6a 00                	push   $0x0
  pushl $251
801084fc:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
80108501:	e9 26 ef ff ff       	jmp    8010742c <alltraps>

80108506 <vector252>:
.globl vector252
vector252:
  pushl $0
80108506:	6a 00                	push   $0x0
  pushl $252
80108508:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
8010850d:	e9 1a ef ff ff       	jmp    8010742c <alltraps>

80108512 <vector253>:
.globl vector253
vector253:
  pushl $0
80108512:	6a 00                	push   $0x0
  pushl $253
80108514:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
80108519:	e9 0e ef ff ff       	jmp    8010742c <alltraps>

8010851e <vector254>:
.globl vector254
vector254:
  pushl $0
8010851e:	6a 00                	push   $0x0
  pushl $254
80108520:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
80108525:	e9 02 ef ff ff       	jmp    8010742c <alltraps>

8010852a <vector255>:
.globl vector255
vector255:
  pushl $0
8010852a:	6a 00                	push   $0x0
  pushl $255
8010852c:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
80108531:	e9 f6 ee ff ff       	jmp    8010742c <alltraps>
	...

80108538 <lgdt>:

struct segdesc;

static inline void
lgdt(struct segdesc *p, int size)
{
80108538:	55                   	push   %ebp
80108539:	89 e5                	mov    %esp,%ebp
8010853b:	83 ec 10             	sub    $0x10,%esp
  volatile ushort pd[3];

  pd[0] = size-1;
8010853e:	8b 45 0c             	mov    0xc(%ebp),%eax
80108541:	83 e8 01             	sub    $0x1,%eax
80108544:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
80108548:	8b 45 08             	mov    0x8(%ebp),%eax
8010854b:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
8010854f:	8b 45 08             	mov    0x8(%ebp),%eax
80108552:	c1 e8 10             	shr    $0x10,%eax
80108555:	66 89 45 fe          	mov    %ax,-0x2(%ebp)

  asm volatile("lgdt (%0)" : : "r" (pd));
80108559:	8d 45 fa             	lea    -0x6(%ebp),%eax
8010855c:	0f 01 10             	lgdtl  (%eax)
}
8010855f:	c9                   	leave  
80108560:	c3                   	ret    

80108561 <ltr>:
  asm volatile("lidt (%0)" : : "r" (pd));
}

static inline void
ltr(ushort sel)
{
80108561:	55                   	push   %ebp
80108562:	89 e5                	mov    %esp,%ebp
80108564:	83 ec 04             	sub    $0x4,%esp
80108567:	8b 45 08             	mov    0x8(%ebp),%eax
8010856a:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  asm volatile("ltr %0" : : "r" (sel));
8010856e:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
80108572:	0f 00 d8             	ltr    %ax
}
80108575:	c9                   	leave  
80108576:	c3                   	ret    

80108577 <loadgs>:
  return eflags;
}

static inline void
loadgs(ushort v)
{
80108577:	55                   	push   %ebp
80108578:	89 e5                	mov    %esp,%ebp
8010857a:	83 ec 04             	sub    $0x4,%esp
8010857d:	8b 45 08             	mov    0x8(%ebp),%eax
80108580:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  asm volatile("movw %0, %%gs" : : "r" (v));
80108584:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
80108588:	8e e8                	mov    %eax,%gs
}
8010858a:	c9                   	leave  
8010858b:	c3                   	ret    

8010858c <lcr3>:
  return val;
}

static inline void
lcr3(uint val) 
{
8010858c:	55                   	push   %ebp
8010858d:	89 e5                	mov    %esp,%ebp
  asm volatile("movl %0,%%cr3" : : "r" (val));
8010858f:	8b 45 08             	mov    0x8(%ebp),%eax
80108592:	0f 22 d8             	mov    %eax,%cr3
}
80108595:	5d                   	pop    %ebp
80108596:	c3                   	ret    

80108597 <v2p>:
#define KERNBASE 0x80000000         // First kernel virtual address
#define KERNLINK (KERNBASE+EXTMEM)  // Address where kernel is linked

#ifndef __ASSEMBLER__

static inline uint v2p(void *a) { return ((uint) (a))  - KERNBASE; }
80108597:	55                   	push   %ebp
80108598:	89 e5                	mov    %esp,%ebp
8010859a:	8b 45 08             	mov    0x8(%ebp),%eax
8010859d:	05 00 00 00 80       	add    $0x80000000,%eax
801085a2:	5d                   	pop    %ebp
801085a3:	c3                   	ret    

801085a4 <p2v>:
static inline void *p2v(uint a) { return (void *) ((a) + KERNBASE); }
801085a4:	55                   	push   %ebp
801085a5:	89 e5                	mov    %esp,%ebp
801085a7:	8b 45 08             	mov    0x8(%ebp),%eax
801085aa:	05 00 00 00 80       	add    $0x80000000,%eax
801085af:	5d                   	pop    %ebp
801085b0:	c3                   	ret    

801085b1 <seginit>:

// Set up CPU's kernel segment descriptors.
// Run once on entry on each CPU.
void
seginit(void)
{
801085b1:	55                   	push   %ebp
801085b2:	89 e5                	mov    %esp,%ebp
801085b4:	53                   	push   %ebx
801085b5:	83 ec 24             	sub    $0x24,%esp

  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpunum()];
801085b8:	e8 24 b0 ff ff       	call   801035e1 <cpunum>
801085bd:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
801085c3:	05 80 18 11 80       	add    $0x80111880,%eax
801085c8:	89 45 f4             	mov    %eax,-0xc(%ebp)
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
801085cb:	8b 45 f4             	mov    -0xc(%ebp),%eax
801085ce:	66 c7 40 78 ff ff    	movw   $0xffff,0x78(%eax)
801085d4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801085d7:	66 c7 40 7a 00 00    	movw   $0x0,0x7a(%eax)
801085dd:	8b 45 f4             	mov    -0xc(%ebp),%eax
801085e0:	c6 40 7c 00          	movb   $0x0,0x7c(%eax)
801085e4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801085e7:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
801085eb:	83 e2 f0             	and    $0xfffffff0,%edx
801085ee:	83 ca 0a             	or     $0xa,%edx
801085f1:	88 50 7d             	mov    %dl,0x7d(%eax)
801085f4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801085f7:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
801085fb:	83 ca 10             	or     $0x10,%edx
801085fe:	88 50 7d             	mov    %dl,0x7d(%eax)
80108601:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108604:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
80108608:	83 e2 9f             	and    $0xffffff9f,%edx
8010860b:	88 50 7d             	mov    %dl,0x7d(%eax)
8010860e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108611:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
80108615:	83 ca 80             	or     $0xffffff80,%edx
80108618:	88 50 7d             	mov    %dl,0x7d(%eax)
8010861b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010861e:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
80108622:	83 ca 0f             	or     $0xf,%edx
80108625:	88 50 7e             	mov    %dl,0x7e(%eax)
80108628:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010862b:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
8010862f:	83 e2 ef             	and    $0xffffffef,%edx
80108632:	88 50 7e             	mov    %dl,0x7e(%eax)
80108635:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108638:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
8010863c:	83 e2 df             	and    $0xffffffdf,%edx
8010863f:	88 50 7e             	mov    %dl,0x7e(%eax)
80108642:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108645:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
80108649:	83 ca 40             	or     $0x40,%edx
8010864c:	88 50 7e             	mov    %dl,0x7e(%eax)
8010864f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108652:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
80108656:	83 ca 80             	or     $0xffffff80,%edx
80108659:	88 50 7e             	mov    %dl,0x7e(%eax)
8010865c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010865f:	c6 40 7f 00          	movb   $0x0,0x7f(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80108663:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108666:	66 c7 80 80 00 00 00 	movw   $0xffff,0x80(%eax)
8010866d:	ff ff 
8010866f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108672:	66 c7 80 82 00 00 00 	movw   $0x0,0x82(%eax)
80108679:	00 00 
8010867b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010867e:	c6 80 84 00 00 00 00 	movb   $0x0,0x84(%eax)
80108685:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108688:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
8010868f:	83 e2 f0             	and    $0xfffffff0,%edx
80108692:	83 ca 02             	or     $0x2,%edx
80108695:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
8010869b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010869e:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
801086a5:	83 ca 10             	or     $0x10,%edx
801086a8:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
801086ae:	8b 45 f4             	mov    -0xc(%ebp),%eax
801086b1:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
801086b8:	83 e2 9f             	and    $0xffffff9f,%edx
801086bb:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
801086c1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801086c4:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
801086cb:	83 ca 80             	or     $0xffffff80,%edx
801086ce:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
801086d4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801086d7:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
801086de:	83 ca 0f             	or     $0xf,%edx
801086e1:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
801086e7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801086ea:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
801086f1:	83 e2 ef             	and    $0xffffffef,%edx
801086f4:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
801086fa:	8b 45 f4             	mov    -0xc(%ebp),%eax
801086fd:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
80108704:	83 e2 df             	and    $0xffffffdf,%edx
80108707:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
8010870d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108710:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
80108717:	83 ca 40             	or     $0x40,%edx
8010871a:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
80108720:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108723:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
8010872a:	83 ca 80             	or     $0xffffff80,%edx
8010872d:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
80108733:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108736:	c6 80 87 00 00 00 00 	movb   $0x0,0x87(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
8010873d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108740:	66 c7 80 90 00 00 00 	movw   $0xffff,0x90(%eax)
80108747:	ff ff 
80108749:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010874c:	66 c7 80 92 00 00 00 	movw   $0x0,0x92(%eax)
80108753:	00 00 
80108755:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108758:	c6 80 94 00 00 00 00 	movb   $0x0,0x94(%eax)
8010875f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108762:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
80108769:	83 e2 f0             	and    $0xfffffff0,%edx
8010876c:	83 ca 0a             	or     $0xa,%edx
8010876f:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
80108775:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108778:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
8010877f:	83 ca 10             	or     $0x10,%edx
80108782:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
80108788:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010878b:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
80108792:	83 ca 60             	or     $0x60,%edx
80108795:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
8010879b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010879e:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
801087a5:	83 ca 80             	or     $0xffffff80,%edx
801087a8:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
801087ae:	8b 45 f4             	mov    -0xc(%ebp),%eax
801087b1:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
801087b8:	83 ca 0f             	or     $0xf,%edx
801087bb:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
801087c1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801087c4:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
801087cb:	83 e2 ef             	and    $0xffffffef,%edx
801087ce:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
801087d4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801087d7:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
801087de:	83 e2 df             	and    $0xffffffdf,%edx
801087e1:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
801087e7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801087ea:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
801087f1:	83 ca 40             	or     $0x40,%edx
801087f4:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
801087fa:	8b 45 f4             	mov    -0xc(%ebp),%eax
801087fd:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
80108804:	83 ca 80             	or     $0xffffff80,%edx
80108807:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
8010880d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108810:	c6 80 97 00 00 00 00 	movb   $0x0,0x97(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80108817:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010881a:	66 c7 80 98 00 00 00 	movw   $0xffff,0x98(%eax)
80108821:	ff ff 
80108823:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108826:	66 c7 80 9a 00 00 00 	movw   $0x0,0x9a(%eax)
8010882d:	00 00 
8010882f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108832:	c6 80 9c 00 00 00 00 	movb   $0x0,0x9c(%eax)
80108839:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010883c:	0f b6 90 9d 00 00 00 	movzbl 0x9d(%eax),%edx
80108843:	83 e2 f0             	and    $0xfffffff0,%edx
80108846:	83 ca 02             	or     $0x2,%edx
80108849:	88 90 9d 00 00 00    	mov    %dl,0x9d(%eax)
8010884f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108852:	0f b6 90 9d 00 00 00 	movzbl 0x9d(%eax),%edx
80108859:	83 ca 10             	or     $0x10,%edx
8010885c:	88 90 9d 00 00 00    	mov    %dl,0x9d(%eax)
80108862:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108865:	0f b6 90 9d 00 00 00 	movzbl 0x9d(%eax),%edx
8010886c:	83 ca 60             	or     $0x60,%edx
8010886f:	88 90 9d 00 00 00    	mov    %dl,0x9d(%eax)
80108875:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108878:	0f b6 90 9d 00 00 00 	movzbl 0x9d(%eax),%edx
8010887f:	83 ca 80             	or     $0xffffff80,%edx
80108882:	88 90 9d 00 00 00    	mov    %dl,0x9d(%eax)
80108888:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010888b:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
80108892:	83 ca 0f             	or     $0xf,%edx
80108895:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
8010889b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010889e:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
801088a5:	83 e2 ef             	and    $0xffffffef,%edx
801088a8:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
801088ae:	8b 45 f4             	mov    -0xc(%ebp),%eax
801088b1:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
801088b8:	83 e2 df             	and    $0xffffffdf,%edx
801088bb:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
801088c1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801088c4:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
801088cb:	83 ca 40             	or     $0x40,%edx
801088ce:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
801088d4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801088d7:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
801088de:	83 ca 80             	or     $0xffffff80,%edx
801088e1:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
801088e7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801088ea:	c6 80 9f 00 00 00 00 	movb   $0x0,0x9f(%eax)

  // Map cpu, and curproc
  c->gdt[SEG_KCPU] = SEG(STA_W, &c->cpu, 8, 0);
801088f1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801088f4:	05 b4 00 00 00       	add    $0xb4,%eax
801088f9:	89 c3                	mov    %eax,%ebx
801088fb:	8b 45 f4             	mov    -0xc(%ebp),%eax
801088fe:	05 b4 00 00 00       	add    $0xb4,%eax
80108903:	c1 e8 10             	shr    $0x10,%eax
80108906:	89 c1                	mov    %eax,%ecx
80108908:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010890b:	05 b4 00 00 00       	add    $0xb4,%eax
80108910:	c1 e8 18             	shr    $0x18,%eax
80108913:	89 c2                	mov    %eax,%edx
80108915:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108918:	66 c7 80 88 00 00 00 	movw   $0x0,0x88(%eax)
8010891f:	00 00 
80108921:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108924:	66 89 98 8a 00 00 00 	mov    %bx,0x8a(%eax)
8010892b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010892e:	88 88 8c 00 00 00    	mov    %cl,0x8c(%eax)
80108934:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108937:	0f b6 88 8d 00 00 00 	movzbl 0x8d(%eax),%ecx
8010893e:	83 e1 f0             	and    $0xfffffff0,%ecx
80108941:	83 c9 02             	or     $0x2,%ecx
80108944:	88 88 8d 00 00 00    	mov    %cl,0x8d(%eax)
8010894a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010894d:	0f b6 88 8d 00 00 00 	movzbl 0x8d(%eax),%ecx
80108954:	83 c9 10             	or     $0x10,%ecx
80108957:	88 88 8d 00 00 00    	mov    %cl,0x8d(%eax)
8010895d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108960:	0f b6 88 8d 00 00 00 	movzbl 0x8d(%eax),%ecx
80108967:	83 e1 9f             	and    $0xffffff9f,%ecx
8010896a:	88 88 8d 00 00 00    	mov    %cl,0x8d(%eax)
80108970:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108973:	0f b6 88 8d 00 00 00 	movzbl 0x8d(%eax),%ecx
8010897a:	83 c9 80             	or     $0xffffff80,%ecx
8010897d:	88 88 8d 00 00 00    	mov    %cl,0x8d(%eax)
80108983:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108986:	0f b6 88 8e 00 00 00 	movzbl 0x8e(%eax),%ecx
8010898d:	83 e1 f0             	and    $0xfffffff0,%ecx
80108990:	88 88 8e 00 00 00    	mov    %cl,0x8e(%eax)
80108996:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108999:	0f b6 88 8e 00 00 00 	movzbl 0x8e(%eax),%ecx
801089a0:	83 e1 ef             	and    $0xffffffef,%ecx
801089a3:	88 88 8e 00 00 00    	mov    %cl,0x8e(%eax)
801089a9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801089ac:	0f b6 88 8e 00 00 00 	movzbl 0x8e(%eax),%ecx
801089b3:	83 e1 df             	and    $0xffffffdf,%ecx
801089b6:	88 88 8e 00 00 00    	mov    %cl,0x8e(%eax)
801089bc:	8b 45 f4             	mov    -0xc(%ebp),%eax
801089bf:	0f b6 88 8e 00 00 00 	movzbl 0x8e(%eax),%ecx
801089c6:	83 c9 40             	or     $0x40,%ecx
801089c9:	88 88 8e 00 00 00    	mov    %cl,0x8e(%eax)
801089cf:	8b 45 f4             	mov    -0xc(%ebp),%eax
801089d2:	0f b6 88 8e 00 00 00 	movzbl 0x8e(%eax),%ecx
801089d9:	83 c9 80             	or     $0xffffff80,%ecx
801089dc:	88 88 8e 00 00 00    	mov    %cl,0x8e(%eax)
801089e2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801089e5:	88 90 8f 00 00 00    	mov    %dl,0x8f(%eax)

  lgdt(c->gdt, sizeof(c->gdt));
801089eb:	8b 45 f4             	mov    -0xc(%ebp),%eax
801089ee:	83 c0 70             	add    $0x70,%eax
801089f1:	c7 44 24 04 38 00 00 	movl   $0x38,0x4(%esp)
801089f8:	00 
801089f9:	89 04 24             	mov    %eax,(%esp)
801089fc:	e8 37 fb ff ff       	call   80108538 <lgdt>
  loadgs(SEG_KCPU << 3);
80108a01:	c7 04 24 18 00 00 00 	movl   $0x18,(%esp)
80108a08:	e8 6a fb ff ff       	call   80108577 <loadgs>
  
  // Initialize cpu-local storage.
  cpu = c;
80108a0d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108a10:	65 a3 00 00 00 00    	mov    %eax,%gs:0x0
  proc = 0;
80108a16:	65 c7 05 04 00 00 00 	movl   $0x0,%gs:0x4
80108a1d:	00 00 00 00 
}
80108a21:	83 c4 24             	add    $0x24,%esp
80108a24:	5b                   	pop    %ebx
80108a25:	5d                   	pop    %ebp
80108a26:	c3                   	ret    

80108a27 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
80108a27:	55                   	push   %ebp
80108a28:	89 e5                	mov    %esp,%ebp
80108a2a:	83 ec 28             	sub    $0x28,%esp
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
80108a2d:	8b 45 0c             	mov    0xc(%ebp),%eax
80108a30:	c1 e8 16             	shr    $0x16,%eax
80108a33:	c1 e0 02             	shl    $0x2,%eax
80108a36:	03 45 08             	add    0x8(%ebp),%eax
80108a39:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(*pde & PTE_P){
80108a3c:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108a3f:	8b 00                	mov    (%eax),%eax
80108a41:	83 e0 01             	and    $0x1,%eax
80108a44:	84 c0                	test   %al,%al
80108a46:	74 17                	je     80108a5f <walkpgdir+0x38>
    pgtab = (pte_t*)p2v(PTE_ADDR(*pde));
80108a48:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108a4b:	8b 00                	mov    (%eax),%eax
80108a4d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108a52:	89 04 24             	mov    %eax,(%esp)
80108a55:	e8 4a fb ff ff       	call   801085a4 <p2v>
80108a5a:	89 45 f4             	mov    %eax,-0xc(%ebp)
80108a5d:	eb 4b                	jmp    80108aaa <walkpgdir+0x83>
  } else {
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80108a5f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80108a63:	74 0e                	je     80108a73 <walkpgdir+0x4c>
80108a65:	e8 e9 a7 ff ff       	call   80103253 <kalloc>
80108a6a:	89 45 f4             	mov    %eax,-0xc(%ebp)
80108a6d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80108a71:	75 07                	jne    80108a7a <walkpgdir+0x53>
      return 0;
80108a73:	b8 00 00 00 00       	mov    $0x0,%eax
80108a78:	eb 41                	jmp    80108abb <walkpgdir+0x94>
    // Make sure all those PTE_P bits are zero.
    memset(pgtab, 0, PGSIZE);
80108a7a:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
80108a81:	00 
80108a82:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80108a89:	00 
80108a8a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108a8d:	89 04 24             	mov    %eax,(%esp)
80108a90:	e8 71 d2 ff ff       	call   80105d06 <memset>
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table 
    // entries, if necessary.
    *pde = v2p(pgtab) | PTE_P | PTE_W | PTE_U;
80108a95:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108a98:	89 04 24             	mov    %eax,(%esp)
80108a9b:	e8 f7 fa ff ff       	call   80108597 <v2p>
80108aa0:	89 c2                	mov    %eax,%edx
80108aa2:	83 ca 07             	or     $0x7,%edx
80108aa5:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108aa8:	89 10                	mov    %edx,(%eax)
  }
  return &pgtab[PTX(va)];
80108aaa:	8b 45 0c             	mov    0xc(%ebp),%eax
80108aad:	c1 e8 0c             	shr    $0xc,%eax
80108ab0:	25 ff 03 00 00       	and    $0x3ff,%eax
80108ab5:	c1 e0 02             	shl    $0x2,%eax
80108ab8:	03 45 f4             	add    -0xc(%ebp),%eax
}
80108abb:	c9                   	leave  
80108abc:	c3                   	ret    

80108abd <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
80108abd:	55                   	push   %ebp
80108abe:	89 e5                	mov    %esp,%ebp
80108ac0:	83 ec 28             	sub    $0x28,%esp
  char *a, *last;
  pte_t *pte;
  
  a = (char*)PGROUNDDOWN((uint)va);
80108ac3:	8b 45 0c             	mov    0xc(%ebp),%eax
80108ac6:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108acb:	89 45 f4             	mov    %eax,-0xc(%ebp)
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80108ace:	8b 45 0c             	mov    0xc(%ebp),%eax
80108ad1:	03 45 10             	add    0x10(%ebp),%eax
80108ad4:	83 e8 01             	sub    $0x1,%eax
80108ad7:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108adc:	89 45 f0             	mov    %eax,-0x10(%ebp)
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80108adf:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
80108ae6:	00 
80108ae7:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108aea:	89 44 24 04          	mov    %eax,0x4(%esp)
80108aee:	8b 45 08             	mov    0x8(%ebp),%eax
80108af1:	89 04 24             	mov    %eax,(%esp)
80108af4:	e8 2e ff ff ff       	call   80108a27 <walkpgdir>
80108af9:	89 45 ec             	mov    %eax,-0x14(%ebp)
80108afc:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80108b00:	75 07                	jne    80108b09 <mappages+0x4c>
      return -1;
80108b02:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80108b07:	eb 46                	jmp    80108b4f <mappages+0x92>
    if(*pte & PTE_P)
80108b09:	8b 45 ec             	mov    -0x14(%ebp),%eax
80108b0c:	8b 00                	mov    (%eax),%eax
80108b0e:	83 e0 01             	and    $0x1,%eax
80108b11:	84 c0                	test   %al,%al
80108b13:	74 0c                	je     80108b21 <mappages+0x64>
      panic("remap");
80108b15:	c7 04 24 4c 9a 10 80 	movl   $0x80109a4c,(%esp)
80108b1c:	e8 1c 7a ff ff       	call   8010053d <panic>
    *pte = pa | perm | PTE_P;
80108b21:	8b 45 18             	mov    0x18(%ebp),%eax
80108b24:	0b 45 14             	or     0x14(%ebp),%eax
80108b27:	89 c2                	mov    %eax,%edx
80108b29:	83 ca 01             	or     $0x1,%edx
80108b2c:	8b 45 ec             	mov    -0x14(%ebp),%eax
80108b2f:	89 10                	mov    %edx,(%eax)
    if(a == last)
80108b31:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108b34:	3b 45 f0             	cmp    -0x10(%ebp),%eax
80108b37:	74 10                	je     80108b49 <mappages+0x8c>
      break;
    a += PGSIZE;
80108b39:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
    pa += PGSIZE;
80108b40:	81 45 14 00 10 00 00 	addl   $0x1000,0x14(%ebp)
  }
80108b47:	eb 96                	jmp    80108adf <mappages+0x22>
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
    if(a == last)
      break;
80108b49:	90                   	nop
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
80108b4a:	b8 00 00 00 00       	mov    $0x0,%eax
}
80108b4f:	c9                   	leave  
80108b50:	c3                   	ret    

80108b51 <setupkvm>:
};

// Set up kernel part of a page table.
pde_t*
setupkvm()
{
80108b51:	55                   	push   %ebp
80108b52:	89 e5                	mov    %esp,%ebp
80108b54:	53                   	push   %ebx
80108b55:	83 ec 34             	sub    $0x34,%esp
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
80108b58:	e8 f6 a6 ff ff       	call   80103253 <kalloc>
80108b5d:	89 45 f0             	mov    %eax,-0x10(%ebp)
80108b60:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80108b64:	75 0a                	jne    80108b70 <setupkvm+0x1f>
    return 0;
80108b66:	b8 00 00 00 00       	mov    $0x0,%eax
80108b6b:	e9 98 00 00 00       	jmp    80108c08 <setupkvm+0xb7>
  memset(pgdir, 0, PGSIZE);
80108b70:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
80108b77:	00 
80108b78:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80108b7f:	00 
80108b80:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108b83:	89 04 24             	mov    %eax,(%esp)
80108b86:	e8 7b d1 ff ff       	call   80105d06 <memset>
  if (p2v(PHYSTOP) > (void*)DEVSPACE)
80108b8b:	c7 04 24 00 00 00 0e 	movl   $0xe000000,(%esp)
80108b92:	e8 0d fa ff ff       	call   801085a4 <p2v>
80108b97:	3d 00 00 00 fe       	cmp    $0xfe000000,%eax
80108b9c:	76 0c                	jbe    80108baa <setupkvm+0x59>
    panic("PHYSTOP too high");
80108b9e:	c7 04 24 52 9a 10 80 	movl   $0x80109a52,(%esp)
80108ba5:	e8 93 79 ff ff       	call   8010053d <panic>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80108baa:	c7 45 f4 c0 c4 10 80 	movl   $0x8010c4c0,-0xc(%ebp)
80108bb1:	eb 49                	jmp    80108bfc <setupkvm+0xab>
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start, 
                (uint)k->phys_start, k->perm) < 0)
80108bb3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    return 0;
  memset(pgdir, 0, PGSIZE);
  if (p2v(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start, 
80108bb6:	8b 48 0c             	mov    0xc(%eax),%ecx
                (uint)k->phys_start, k->perm) < 0)
80108bb9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    return 0;
  memset(pgdir, 0, PGSIZE);
  if (p2v(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start, 
80108bbc:	8b 50 04             	mov    0x4(%eax),%edx
80108bbf:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108bc2:	8b 58 08             	mov    0x8(%eax),%ebx
80108bc5:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108bc8:	8b 40 04             	mov    0x4(%eax),%eax
80108bcb:	29 c3                	sub    %eax,%ebx
80108bcd:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108bd0:	8b 00                	mov    (%eax),%eax
80108bd2:	89 4c 24 10          	mov    %ecx,0x10(%esp)
80108bd6:	89 54 24 0c          	mov    %edx,0xc(%esp)
80108bda:	89 5c 24 08          	mov    %ebx,0x8(%esp)
80108bde:	89 44 24 04          	mov    %eax,0x4(%esp)
80108be2:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108be5:	89 04 24             	mov    %eax,(%esp)
80108be8:	e8 d0 fe ff ff       	call   80108abd <mappages>
80108bed:	85 c0                	test   %eax,%eax
80108bef:	79 07                	jns    80108bf8 <setupkvm+0xa7>
                (uint)k->phys_start, k->perm) < 0)
      return 0;
80108bf1:	b8 00 00 00 00       	mov    $0x0,%eax
80108bf6:	eb 10                	jmp    80108c08 <setupkvm+0xb7>
  if((pgdir = (pde_t*)kalloc()) == 0)
    return 0;
  memset(pgdir, 0, PGSIZE);
  if (p2v(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80108bf8:	83 45 f4 10          	addl   $0x10,-0xc(%ebp)
80108bfc:	81 7d f4 00 c5 10 80 	cmpl   $0x8010c500,-0xc(%ebp)
80108c03:	72 ae                	jb     80108bb3 <setupkvm+0x62>
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start, 
                (uint)k->phys_start, k->perm) < 0)
      return 0;
  return pgdir;
80108c05:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
80108c08:	83 c4 34             	add    $0x34,%esp
80108c0b:	5b                   	pop    %ebx
80108c0c:	5d                   	pop    %ebp
80108c0d:	c3                   	ret    

80108c0e <kvmalloc>:

// Allocate one page table for the machine for the kernel address
// space for scheduler processes.
void
kvmalloc(void)
{
80108c0e:	55                   	push   %ebp
80108c0f:	89 e5                	mov    %esp,%ebp
80108c11:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80108c14:	e8 38 ff ff ff       	call   80108b51 <setupkvm>
80108c19:	a3 b8 72 11 80       	mov    %eax,0x801172b8
  switchkvm();
80108c1e:	e8 02 00 00 00       	call   80108c25 <switchkvm>
}
80108c23:	c9                   	leave  
80108c24:	c3                   	ret    

80108c25 <switchkvm>:

// Switch h/w page table register to the kernel-only page table,
// for when no process is running.
void
switchkvm(void)
{
80108c25:	55                   	push   %ebp
80108c26:	89 e5                	mov    %esp,%ebp
80108c28:	83 ec 04             	sub    $0x4,%esp
  lcr3(v2p(kpgdir));   // switch to the kernel page table
80108c2b:	a1 b8 72 11 80       	mov    0x801172b8,%eax
80108c30:	89 04 24             	mov    %eax,(%esp)
80108c33:	e8 5f f9 ff ff       	call   80108597 <v2p>
80108c38:	89 04 24             	mov    %eax,(%esp)
80108c3b:	e8 4c f9 ff ff       	call   8010858c <lcr3>
}
80108c40:	c9                   	leave  
80108c41:	c3                   	ret    

80108c42 <switchuvm>:

// Switch TSS and h/w page table to correspond to process p.
void
switchuvm(struct proc *p)
{
80108c42:	55                   	push   %ebp
80108c43:	89 e5                	mov    %esp,%ebp
80108c45:	53                   	push   %ebx
80108c46:	83 ec 14             	sub    $0x14,%esp
  pushcli();
80108c49:	e8 b1 cf ff ff       	call   80105bff <pushcli>
  cpu->gdt[SEG_TSS] = SEG16(STS_T32A, &cpu->ts, sizeof(cpu->ts)-1, 0);
80108c4e:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80108c54:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80108c5b:	83 c2 08             	add    $0x8,%edx
80108c5e:	89 d3                	mov    %edx,%ebx
80108c60:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80108c67:	83 c2 08             	add    $0x8,%edx
80108c6a:	c1 ea 10             	shr    $0x10,%edx
80108c6d:	89 d1                	mov    %edx,%ecx
80108c6f:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80108c76:	83 c2 08             	add    $0x8,%edx
80108c79:	c1 ea 18             	shr    $0x18,%edx
80108c7c:	66 c7 80 a0 00 00 00 	movw   $0x67,0xa0(%eax)
80108c83:	67 00 
80108c85:	66 89 98 a2 00 00 00 	mov    %bx,0xa2(%eax)
80108c8c:	88 88 a4 00 00 00    	mov    %cl,0xa4(%eax)
80108c92:	0f b6 88 a5 00 00 00 	movzbl 0xa5(%eax),%ecx
80108c99:	83 e1 f0             	and    $0xfffffff0,%ecx
80108c9c:	83 c9 09             	or     $0x9,%ecx
80108c9f:	88 88 a5 00 00 00    	mov    %cl,0xa5(%eax)
80108ca5:	0f b6 88 a5 00 00 00 	movzbl 0xa5(%eax),%ecx
80108cac:	83 c9 10             	or     $0x10,%ecx
80108caf:	88 88 a5 00 00 00    	mov    %cl,0xa5(%eax)
80108cb5:	0f b6 88 a5 00 00 00 	movzbl 0xa5(%eax),%ecx
80108cbc:	83 e1 9f             	and    $0xffffff9f,%ecx
80108cbf:	88 88 a5 00 00 00    	mov    %cl,0xa5(%eax)
80108cc5:	0f b6 88 a5 00 00 00 	movzbl 0xa5(%eax),%ecx
80108ccc:	83 c9 80             	or     $0xffffff80,%ecx
80108ccf:	88 88 a5 00 00 00    	mov    %cl,0xa5(%eax)
80108cd5:	0f b6 88 a6 00 00 00 	movzbl 0xa6(%eax),%ecx
80108cdc:	83 e1 f0             	and    $0xfffffff0,%ecx
80108cdf:	88 88 a6 00 00 00    	mov    %cl,0xa6(%eax)
80108ce5:	0f b6 88 a6 00 00 00 	movzbl 0xa6(%eax),%ecx
80108cec:	83 e1 ef             	and    $0xffffffef,%ecx
80108cef:	88 88 a6 00 00 00    	mov    %cl,0xa6(%eax)
80108cf5:	0f b6 88 a6 00 00 00 	movzbl 0xa6(%eax),%ecx
80108cfc:	83 e1 df             	and    $0xffffffdf,%ecx
80108cff:	88 88 a6 00 00 00    	mov    %cl,0xa6(%eax)
80108d05:	0f b6 88 a6 00 00 00 	movzbl 0xa6(%eax),%ecx
80108d0c:	83 c9 40             	or     $0x40,%ecx
80108d0f:	88 88 a6 00 00 00    	mov    %cl,0xa6(%eax)
80108d15:	0f b6 88 a6 00 00 00 	movzbl 0xa6(%eax),%ecx
80108d1c:	83 e1 7f             	and    $0x7f,%ecx
80108d1f:	88 88 a6 00 00 00    	mov    %cl,0xa6(%eax)
80108d25:	88 90 a7 00 00 00    	mov    %dl,0xa7(%eax)
  cpu->gdt[SEG_TSS].s = 0;
80108d2b:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80108d31:	0f b6 90 a5 00 00 00 	movzbl 0xa5(%eax),%edx
80108d38:	83 e2 ef             	and    $0xffffffef,%edx
80108d3b:	88 90 a5 00 00 00    	mov    %dl,0xa5(%eax)
  cpu->ts.ss0 = SEG_KDATA << 3;
80108d41:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80108d47:	66 c7 40 10 10 00    	movw   $0x10,0x10(%eax)
  cpu->ts.esp0 = (uint)proc->kstack + KSTACKSIZE;
80108d4d:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80108d53:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80108d5a:	8b 52 08             	mov    0x8(%edx),%edx
80108d5d:	81 c2 00 10 00 00    	add    $0x1000,%edx
80108d63:	89 50 0c             	mov    %edx,0xc(%eax)
  ltr(SEG_TSS << 3);
80108d66:	c7 04 24 30 00 00 00 	movl   $0x30,(%esp)
80108d6d:	e8 ef f7 ff ff       	call   80108561 <ltr>
  if(p->pgdir == 0)
80108d72:	8b 45 08             	mov    0x8(%ebp),%eax
80108d75:	8b 40 04             	mov    0x4(%eax),%eax
80108d78:	85 c0                	test   %eax,%eax
80108d7a:	75 0c                	jne    80108d88 <switchuvm+0x146>
    panic("switchuvm: no pgdir");
80108d7c:	c7 04 24 63 9a 10 80 	movl   $0x80109a63,(%esp)
80108d83:	e8 b5 77 ff ff       	call   8010053d <panic>
  lcr3(v2p(p->pgdir));  // switch to new address space
80108d88:	8b 45 08             	mov    0x8(%ebp),%eax
80108d8b:	8b 40 04             	mov    0x4(%eax),%eax
80108d8e:	89 04 24             	mov    %eax,(%esp)
80108d91:	e8 01 f8 ff ff       	call   80108597 <v2p>
80108d96:	89 04 24             	mov    %eax,(%esp)
80108d99:	e8 ee f7 ff ff       	call   8010858c <lcr3>
  popcli();
80108d9e:	e8 a4 ce ff ff       	call   80105c47 <popcli>
}
80108da3:	83 c4 14             	add    $0x14,%esp
80108da6:	5b                   	pop    %ebx
80108da7:	5d                   	pop    %ebp
80108da8:	c3                   	ret    

80108da9 <inituvm>:

// Load the initcode into address 0 of pgdir.
// sz must be less than a page.
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
80108da9:	55                   	push   %ebp
80108daa:	89 e5                	mov    %esp,%ebp
80108dac:	83 ec 38             	sub    $0x38,%esp
  char *mem;
  
  if(sz >= PGSIZE)
80108daf:	81 7d 10 ff 0f 00 00 	cmpl   $0xfff,0x10(%ebp)
80108db6:	76 0c                	jbe    80108dc4 <inituvm+0x1b>
    panic("inituvm: more than a page");
80108db8:	c7 04 24 77 9a 10 80 	movl   $0x80109a77,(%esp)
80108dbf:	e8 79 77 ff ff       	call   8010053d <panic>
  mem = kalloc();
80108dc4:	e8 8a a4 ff ff       	call   80103253 <kalloc>
80108dc9:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(mem, 0, PGSIZE);
80108dcc:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
80108dd3:	00 
80108dd4:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80108ddb:	00 
80108ddc:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108ddf:	89 04 24             	mov    %eax,(%esp)
80108de2:	e8 1f cf ff ff       	call   80105d06 <memset>
  mappages(pgdir, 0, PGSIZE, v2p(mem), PTE_W|PTE_U);
80108de7:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108dea:	89 04 24             	mov    %eax,(%esp)
80108ded:	e8 a5 f7 ff ff       	call   80108597 <v2p>
80108df2:	c7 44 24 10 06 00 00 	movl   $0x6,0x10(%esp)
80108df9:	00 
80108dfa:	89 44 24 0c          	mov    %eax,0xc(%esp)
80108dfe:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
80108e05:	00 
80108e06:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80108e0d:	00 
80108e0e:	8b 45 08             	mov    0x8(%ebp),%eax
80108e11:	89 04 24             	mov    %eax,(%esp)
80108e14:	e8 a4 fc ff ff       	call   80108abd <mappages>
  memmove(mem, init, sz);
80108e19:	8b 45 10             	mov    0x10(%ebp),%eax
80108e1c:	89 44 24 08          	mov    %eax,0x8(%esp)
80108e20:	8b 45 0c             	mov    0xc(%ebp),%eax
80108e23:	89 44 24 04          	mov    %eax,0x4(%esp)
80108e27:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108e2a:	89 04 24             	mov    %eax,(%esp)
80108e2d:	e8 a7 cf ff ff       	call   80105dd9 <memmove>
}
80108e32:	c9                   	leave  
80108e33:	c3                   	ret    

80108e34 <loaduvm>:

// Load a program segment into pgdir.  addr must be page-aligned
// and the pages from addr to addr+sz must already be mapped.
int
loaduvm(pde_t *pgdir, char *addr, struct inode *ip, uint offset, uint sz)
{
80108e34:	55                   	push   %ebp
80108e35:	89 e5                	mov    %esp,%ebp
80108e37:	53                   	push   %ebx
80108e38:	83 ec 24             	sub    $0x24,%esp
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
80108e3b:	8b 45 0c             	mov    0xc(%ebp),%eax
80108e3e:	25 ff 0f 00 00       	and    $0xfff,%eax
80108e43:	85 c0                	test   %eax,%eax
80108e45:	74 0c                	je     80108e53 <loaduvm+0x1f>
    panic("loaduvm: addr must be page aligned");
80108e47:	c7 04 24 94 9a 10 80 	movl   $0x80109a94,(%esp)
80108e4e:	e8 ea 76 ff ff       	call   8010053d <panic>
  for(i = 0; i < sz; i += PGSIZE){
80108e53:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80108e5a:	e9 ad 00 00 00       	jmp    80108f0c <loaduvm+0xd8>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
80108e5f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108e62:	8b 55 0c             	mov    0xc(%ebp),%edx
80108e65:	01 d0                	add    %edx,%eax
80108e67:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
80108e6e:	00 
80108e6f:	89 44 24 04          	mov    %eax,0x4(%esp)
80108e73:	8b 45 08             	mov    0x8(%ebp),%eax
80108e76:	89 04 24             	mov    %eax,(%esp)
80108e79:	e8 a9 fb ff ff       	call   80108a27 <walkpgdir>
80108e7e:	89 45 ec             	mov    %eax,-0x14(%ebp)
80108e81:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80108e85:	75 0c                	jne    80108e93 <loaduvm+0x5f>
      panic("loaduvm: address should exist");
80108e87:	c7 04 24 b7 9a 10 80 	movl   $0x80109ab7,(%esp)
80108e8e:	e8 aa 76 ff ff       	call   8010053d <panic>
    pa = PTE_ADDR(*pte);
80108e93:	8b 45 ec             	mov    -0x14(%ebp),%eax
80108e96:	8b 00                	mov    (%eax),%eax
80108e98:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108e9d:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(sz - i < PGSIZE)
80108ea0:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108ea3:	8b 55 18             	mov    0x18(%ebp),%edx
80108ea6:	89 d1                	mov    %edx,%ecx
80108ea8:	29 c1                	sub    %eax,%ecx
80108eaa:	89 c8                	mov    %ecx,%eax
80108eac:	3d ff 0f 00 00       	cmp    $0xfff,%eax
80108eb1:	77 11                	ja     80108ec4 <loaduvm+0x90>
      n = sz - i;
80108eb3:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108eb6:	8b 55 18             	mov    0x18(%ebp),%edx
80108eb9:	89 d1                	mov    %edx,%ecx
80108ebb:	29 c1                	sub    %eax,%ecx
80108ebd:	89 c8                	mov    %ecx,%eax
80108ebf:	89 45 f0             	mov    %eax,-0x10(%ebp)
80108ec2:	eb 07                	jmp    80108ecb <loaduvm+0x97>
    else
      n = PGSIZE;
80108ec4:	c7 45 f0 00 10 00 00 	movl   $0x1000,-0x10(%ebp)
    if(readi(ip, p2v(pa), offset+i, n) != n)
80108ecb:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108ece:	8b 55 14             	mov    0x14(%ebp),%edx
80108ed1:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
80108ed4:	8b 45 e8             	mov    -0x18(%ebp),%eax
80108ed7:	89 04 24             	mov    %eax,(%esp)
80108eda:	e8 c5 f6 ff ff       	call   801085a4 <p2v>
80108edf:	8b 55 f0             	mov    -0x10(%ebp),%edx
80108ee2:	89 54 24 0c          	mov    %edx,0xc(%esp)
80108ee6:	89 5c 24 08          	mov    %ebx,0x8(%esp)
80108eea:	89 44 24 04          	mov    %eax,0x4(%esp)
80108eee:	8b 45 10             	mov    0x10(%ebp),%eax
80108ef1:	89 04 24             	mov    %eax,(%esp)
80108ef4:	e8 b9 95 ff ff       	call   801024b2 <readi>
80108ef9:	3b 45 f0             	cmp    -0x10(%ebp),%eax
80108efc:	74 07                	je     80108f05 <loaduvm+0xd1>
      return -1;
80108efe:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80108f03:	eb 18                	jmp    80108f1d <loaduvm+0xe9>
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
80108f05:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
80108f0c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108f0f:	3b 45 18             	cmp    0x18(%ebp),%eax
80108f12:	0f 82 47 ff ff ff    	jb     80108e5f <loaduvm+0x2b>
    else
      n = PGSIZE;
    if(readi(ip, p2v(pa), offset+i, n) != n)
      return -1;
  }
  return 0;
80108f18:	b8 00 00 00 00       	mov    $0x0,%eax
}
80108f1d:	83 c4 24             	add    $0x24,%esp
80108f20:	5b                   	pop    %ebx
80108f21:	5d                   	pop    %ebp
80108f22:	c3                   	ret    

80108f23 <allocuvm>:

// Allocate page tables and physical memory to grow process from oldsz to
// newsz, which need not be page aligned.  Returns new size or 0 on error.
int
allocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
80108f23:	55                   	push   %ebp
80108f24:	89 e5                	mov    %esp,%ebp
80108f26:	83 ec 38             	sub    $0x38,%esp
  char *mem;
  uint a;

  if(newsz >= KERNBASE)
80108f29:	8b 45 10             	mov    0x10(%ebp),%eax
80108f2c:	85 c0                	test   %eax,%eax
80108f2e:	79 0a                	jns    80108f3a <allocuvm+0x17>
    return 0;
80108f30:	b8 00 00 00 00       	mov    $0x0,%eax
80108f35:	e9 c1 00 00 00       	jmp    80108ffb <allocuvm+0xd8>
  if(newsz < oldsz)
80108f3a:	8b 45 10             	mov    0x10(%ebp),%eax
80108f3d:	3b 45 0c             	cmp    0xc(%ebp),%eax
80108f40:	73 08                	jae    80108f4a <allocuvm+0x27>
    return oldsz;
80108f42:	8b 45 0c             	mov    0xc(%ebp),%eax
80108f45:	e9 b1 00 00 00       	jmp    80108ffb <allocuvm+0xd8>

  a = PGROUNDUP(oldsz);
80108f4a:	8b 45 0c             	mov    0xc(%ebp),%eax
80108f4d:	05 ff 0f 00 00       	add    $0xfff,%eax
80108f52:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108f57:	89 45 f4             	mov    %eax,-0xc(%ebp)
  for(; a < newsz; a += PGSIZE){
80108f5a:	e9 8d 00 00 00       	jmp    80108fec <allocuvm+0xc9>
    mem = kalloc();
80108f5f:	e8 ef a2 ff ff       	call   80103253 <kalloc>
80108f64:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(mem == 0){
80108f67:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80108f6b:	75 2c                	jne    80108f99 <allocuvm+0x76>
      cprintf("allocuvm out of memory\n");
80108f6d:	c7 04 24 d5 9a 10 80 	movl   $0x80109ad5,(%esp)
80108f74:	e8 28 74 ff ff       	call   801003a1 <cprintf>
      deallocuvm(pgdir, newsz, oldsz);
80108f79:	8b 45 0c             	mov    0xc(%ebp),%eax
80108f7c:	89 44 24 08          	mov    %eax,0x8(%esp)
80108f80:	8b 45 10             	mov    0x10(%ebp),%eax
80108f83:	89 44 24 04          	mov    %eax,0x4(%esp)
80108f87:	8b 45 08             	mov    0x8(%ebp),%eax
80108f8a:	89 04 24             	mov    %eax,(%esp)
80108f8d:	e8 6b 00 00 00       	call   80108ffd <deallocuvm>
      return 0;
80108f92:	b8 00 00 00 00       	mov    $0x0,%eax
80108f97:	eb 62                	jmp    80108ffb <allocuvm+0xd8>
    }
    memset(mem, 0, PGSIZE);
80108f99:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
80108fa0:	00 
80108fa1:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80108fa8:	00 
80108fa9:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108fac:	89 04 24             	mov    %eax,(%esp)
80108faf:	e8 52 cd ff ff       	call   80105d06 <memset>
    mappages(pgdir, (char*)a, PGSIZE, v2p(mem), PTE_W|PTE_U);
80108fb4:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108fb7:	89 04 24             	mov    %eax,(%esp)
80108fba:	e8 d8 f5 ff ff       	call   80108597 <v2p>
80108fbf:	8b 55 f4             	mov    -0xc(%ebp),%edx
80108fc2:	c7 44 24 10 06 00 00 	movl   $0x6,0x10(%esp)
80108fc9:	00 
80108fca:	89 44 24 0c          	mov    %eax,0xc(%esp)
80108fce:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
80108fd5:	00 
80108fd6:	89 54 24 04          	mov    %edx,0x4(%esp)
80108fda:	8b 45 08             	mov    0x8(%ebp),%eax
80108fdd:	89 04 24             	mov    %eax,(%esp)
80108fe0:	e8 d8 fa ff ff       	call   80108abd <mappages>
    return 0;
  if(newsz < oldsz)
    return oldsz;

  a = PGROUNDUP(oldsz);
  for(; a < newsz; a += PGSIZE){
80108fe5:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
80108fec:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108fef:	3b 45 10             	cmp    0x10(%ebp),%eax
80108ff2:	0f 82 67 ff ff ff    	jb     80108f5f <allocuvm+0x3c>
      return 0;
    }
    memset(mem, 0, PGSIZE);
    mappages(pgdir, (char*)a, PGSIZE, v2p(mem), PTE_W|PTE_U);
  }
  return newsz;
80108ff8:	8b 45 10             	mov    0x10(%ebp),%eax
}
80108ffb:	c9                   	leave  
80108ffc:	c3                   	ret    

80108ffd <deallocuvm>:
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
80108ffd:	55                   	push   %ebp
80108ffe:	89 e5                	mov    %esp,%ebp
80109000:	83 ec 28             	sub    $0x28,%esp
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
80109003:	8b 45 10             	mov    0x10(%ebp),%eax
80109006:	3b 45 0c             	cmp    0xc(%ebp),%eax
80109009:	72 08                	jb     80109013 <deallocuvm+0x16>
    return oldsz;
8010900b:	8b 45 0c             	mov    0xc(%ebp),%eax
8010900e:	e9 a4 00 00 00       	jmp    801090b7 <deallocuvm+0xba>

  a = PGROUNDUP(newsz);
80109013:	8b 45 10             	mov    0x10(%ebp),%eax
80109016:	05 ff 0f 00 00       	add    $0xfff,%eax
8010901b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80109020:	89 45 f4             	mov    %eax,-0xc(%ebp)
  for(; a  < oldsz; a += PGSIZE){
80109023:	e9 80 00 00 00       	jmp    801090a8 <deallocuvm+0xab>
    pte = walkpgdir(pgdir, (char*)a, 0);
80109028:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010902b:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
80109032:	00 
80109033:	89 44 24 04          	mov    %eax,0x4(%esp)
80109037:	8b 45 08             	mov    0x8(%ebp),%eax
8010903a:	89 04 24             	mov    %eax,(%esp)
8010903d:	e8 e5 f9 ff ff       	call   80108a27 <walkpgdir>
80109042:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(!pte)
80109045:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80109049:	75 09                	jne    80109054 <deallocuvm+0x57>
      a += (NPTENTRIES - 1) * PGSIZE;
8010904b:	81 45 f4 00 f0 3f 00 	addl   $0x3ff000,-0xc(%ebp)
80109052:	eb 4d                	jmp    801090a1 <deallocuvm+0xa4>
    else if((*pte & PTE_P) != 0){
80109054:	8b 45 f0             	mov    -0x10(%ebp),%eax
80109057:	8b 00                	mov    (%eax),%eax
80109059:	83 e0 01             	and    $0x1,%eax
8010905c:	84 c0                	test   %al,%al
8010905e:	74 41                	je     801090a1 <deallocuvm+0xa4>
      pa = PTE_ADDR(*pte);
80109060:	8b 45 f0             	mov    -0x10(%ebp),%eax
80109063:	8b 00                	mov    (%eax),%eax
80109065:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010906a:	89 45 ec             	mov    %eax,-0x14(%ebp)
      if(pa == 0)
8010906d:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80109071:	75 0c                	jne    8010907f <deallocuvm+0x82>
        panic("kfree");
80109073:	c7 04 24 ed 9a 10 80 	movl   $0x80109aed,(%esp)
8010907a:	e8 be 74 ff ff       	call   8010053d <panic>
      char *v = p2v(pa);
8010907f:	8b 45 ec             	mov    -0x14(%ebp),%eax
80109082:	89 04 24             	mov    %eax,(%esp)
80109085:	e8 1a f5 ff ff       	call   801085a4 <p2v>
8010908a:	89 45 e8             	mov    %eax,-0x18(%ebp)
      kfree(v);
8010908d:	8b 45 e8             	mov    -0x18(%ebp),%eax
80109090:	89 04 24             	mov    %eax,(%esp)
80109093:	e8 22 a1 ff ff       	call   801031ba <kfree>
      *pte = 0;
80109098:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010909b:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
  for(; a  < oldsz; a += PGSIZE){
801090a1:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
801090a8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801090ab:	3b 45 0c             	cmp    0xc(%ebp),%eax
801090ae:	0f 82 74 ff ff ff    	jb     80109028 <deallocuvm+0x2b>
      char *v = p2v(pa);
      kfree(v);
      *pte = 0;
    }
  }
  return newsz;
801090b4:	8b 45 10             	mov    0x10(%ebp),%eax
}
801090b7:	c9                   	leave  
801090b8:	c3                   	ret    

801090b9 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
801090b9:	55                   	push   %ebp
801090ba:	89 e5                	mov    %esp,%ebp
801090bc:	83 ec 28             	sub    $0x28,%esp
  uint i;

  if(pgdir == 0)
801090bf:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
801090c3:	75 0c                	jne    801090d1 <freevm+0x18>
    panic("freevm: no pgdir");
801090c5:	c7 04 24 f3 9a 10 80 	movl   $0x80109af3,(%esp)
801090cc:	e8 6c 74 ff ff       	call   8010053d <panic>
  deallocuvm(pgdir, KERNBASE, 0);
801090d1:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
801090d8:	00 
801090d9:	c7 44 24 04 00 00 00 	movl   $0x80000000,0x4(%esp)
801090e0:	80 
801090e1:	8b 45 08             	mov    0x8(%ebp),%eax
801090e4:	89 04 24             	mov    %eax,(%esp)
801090e7:	e8 11 ff ff ff       	call   80108ffd <deallocuvm>
  for(i = 0; i < NPDENTRIES; i++){
801090ec:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801090f3:	eb 3c                	jmp    80109131 <freevm+0x78>
    if(pgdir[i] & PTE_P){
801090f5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801090f8:	c1 e0 02             	shl    $0x2,%eax
801090fb:	03 45 08             	add    0x8(%ebp),%eax
801090fe:	8b 00                	mov    (%eax),%eax
80109100:	83 e0 01             	and    $0x1,%eax
80109103:	84 c0                	test   %al,%al
80109105:	74 26                	je     8010912d <freevm+0x74>
      char * v = p2v(PTE_ADDR(pgdir[i]));
80109107:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010910a:	c1 e0 02             	shl    $0x2,%eax
8010910d:	03 45 08             	add    0x8(%ebp),%eax
80109110:	8b 00                	mov    (%eax),%eax
80109112:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80109117:	89 04 24             	mov    %eax,(%esp)
8010911a:	e8 85 f4 ff ff       	call   801085a4 <p2v>
8010911f:	89 45 f0             	mov    %eax,-0x10(%ebp)
      kfree(v);
80109122:	8b 45 f0             	mov    -0x10(%ebp),%eax
80109125:	89 04 24             	mov    %eax,(%esp)
80109128:	e8 8d a0 ff ff       	call   801031ba <kfree>
  uint i;

  if(pgdir == 0)
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
8010912d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80109131:	81 7d f4 ff 03 00 00 	cmpl   $0x3ff,-0xc(%ebp)
80109138:	76 bb                	jbe    801090f5 <freevm+0x3c>
    if(pgdir[i] & PTE_P){
      char * v = p2v(PTE_ADDR(pgdir[i]));
      kfree(v);
    }
  }
  kfree((char*)pgdir);
8010913a:	8b 45 08             	mov    0x8(%ebp),%eax
8010913d:	89 04 24             	mov    %eax,(%esp)
80109140:	e8 75 a0 ff ff       	call   801031ba <kfree>
}
80109145:	c9                   	leave  
80109146:	c3                   	ret    

80109147 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80109147:	55                   	push   %ebp
80109148:	89 e5                	mov    %esp,%ebp
8010914a:	83 ec 28             	sub    $0x28,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
8010914d:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
80109154:	00 
80109155:	8b 45 0c             	mov    0xc(%ebp),%eax
80109158:	89 44 24 04          	mov    %eax,0x4(%esp)
8010915c:	8b 45 08             	mov    0x8(%ebp),%eax
8010915f:	89 04 24             	mov    %eax,(%esp)
80109162:	e8 c0 f8 ff ff       	call   80108a27 <walkpgdir>
80109167:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(pte == 0)
8010916a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010916e:	75 0c                	jne    8010917c <clearpteu+0x35>
    panic("clearpteu");
80109170:	c7 04 24 04 9b 10 80 	movl   $0x80109b04,(%esp)
80109177:	e8 c1 73 ff ff       	call   8010053d <panic>
  *pte &= ~PTE_U;
8010917c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010917f:	8b 00                	mov    (%eax),%eax
80109181:	89 c2                	mov    %eax,%edx
80109183:	83 e2 fb             	and    $0xfffffffb,%edx
80109186:	8b 45 f4             	mov    -0xc(%ebp),%eax
80109189:	89 10                	mov    %edx,(%eax)
}
8010918b:	c9                   	leave  
8010918c:	c3                   	ret    

8010918d <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
8010918d:	55                   	push   %ebp
8010918e:	89 e5                	mov    %esp,%ebp
80109190:	83 ec 48             	sub    $0x48,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i;
  char *mem;

  if((d = setupkvm()) == 0)
80109193:	e8 b9 f9 ff ff       	call   80108b51 <setupkvm>
80109198:	89 45 f0             	mov    %eax,-0x10(%ebp)
8010919b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
8010919f:	75 0a                	jne    801091ab <copyuvm+0x1e>
    return 0;
801091a1:	b8 00 00 00 00       	mov    $0x0,%eax
801091a6:	e9 f1 00 00 00       	jmp    8010929c <copyuvm+0x10f>
  for(i = 0; i < sz; i += PGSIZE){
801091ab:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801091b2:	e9 c0 00 00 00       	jmp    80109277 <copyuvm+0xea>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
801091b7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801091ba:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
801091c1:	00 
801091c2:	89 44 24 04          	mov    %eax,0x4(%esp)
801091c6:	8b 45 08             	mov    0x8(%ebp),%eax
801091c9:	89 04 24             	mov    %eax,(%esp)
801091cc:	e8 56 f8 ff ff       	call   80108a27 <walkpgdir>
801091d1:	89 45 ec             	mov    %eax,-0x14(%ebp)
801091d4:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
801091d8:	75 0c                	jne    801091e6 <copyuvm+0x59>
      panic("copyuvm: pte should exist");
801091da:	c7 04 24 0e 9b 10 80 	movl   $0x80109b0e,(%esp)
801091e1:	e8 57 73 ff ff       	call   8010053d <panic>
    if(!(*pte & PTE_P))
801091e6:	8b 45 ec             	mov    -0x14(%ebp),%eax
801091e9:	8b 00                	mov    (%eax),%eax
801091eb:	83 e0 01             	and    $0x1,%eax
801091ee:	85 c0                	test   %eax,%eax
801091f0:	75 0c                	jne    801091fe <copyuvm+0x71>
      panic("copyuvm: page not present");
801091f2:	c7 04 24 28 9b 10 80 	movl   $0x80109b28,(%esp)
801091f9:	e8 3f 73 ff ff       	call   8010053d <panic>
    pa = PTE_ADDR(*pte);
801091fe:	8b 45 ec             	mov    -0x14(%ebp),%eax
80109201:	8b 00                	mov    (%eax),%eax
80109203:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80109208:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if((mem = kalloc()) == 0)
8010920b:	e8 43 a0 ff ff       	call   80103253 <kalloc>
80109210:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80109213:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
80109217:	74 6f                	je     80109288 <copyuvm+0xfb>
      goto bad;
    memmove(mem, (char*)p2v(pa), PGSIZE);
80109219:	8b 45 e8             	mov    -0x18(%ebp),%eax
8010921c:	89 04 24             	mov    %eax,(%esp)
8010921f:	e8 80 f3 ff ff       	call   801085a4 <p2v>
80109224:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
8010922b:	00 
8010922c:	89 44 24 04          	mov    %eax,0x4(%esp)
80109230:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80109233:	89 04 24             	mov    %eax,(%esp)
80109236:	e8 9e cb ff ff       	call   80105dd9 <memmove>
    if(mappages(d, (void*)i, PGSIZE, v2p(mem), PTE_W|PTE_U) < 0)
8010923b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010923e:	89 04 24             	mov    %eax,(%esp)
80109241:	e8 51 f3 ff ff       	call   80108597 <v2p>
80109246:	8b 55 f4             	mov    -0xc(%ebp),%edx
80109249:	c7 44 24 10 06 00 00 	movl   $0x6,0x10(%esp)
80109250:	00 
80109251:	89 44 24 0c          	mov    %eax,0xc(%esp)
80109255:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
8010925c:	00 
8010925d:	89 54 24 04          	mov    %edx,0x4(%esp)
80109261:	8b 45 f0             	mov    -0x10(%ebp),%eax
80109264:	89 04 24             	mov    %eax,(%esp)
80109267:	e8 51 f8 ff ff       	call   80108abd <mappages>
8010926c:	85 c0                	test   %eax,%eax
8010926e:	78 1b                	js     8010928b <copyuvm+0xfe>
  uint pa, i;
  char *mem;

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80109270:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
80109277:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010927a:	3b 45 0c             	cmp    0xc(%ebp),%eax
8010927d:	0f 82 34 ff ff ff    	jb     801091b7 <copyuvm+0x2a>
      goto bad;
    memmove(mem, (char*)p2v(pa), PGSIZE);
    if(mappages(d, (void*)i, PGSIZE, v2p(mem), PTE_W|PTE_U) < 0)
      goto bad;
  }
  return d;
80109283:	8b 45 f0             	mov    -0x10(%ebp),%eax
80109286:	eb 14                	jmp    8010929c <copyuvm+0x10f>
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P))
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
80109288:	90                   	nop
80109289:	eb 01                	jmp    8010928c <copyuvm+0xff>
    memmove(mem, (char*)p2v(pa), PGSIZE);
    if(mappages(d, (void*)i, PGSIZE, v2p(mem), PTE_W|PTE_U) < 0)
      goto bad;
8010928b:	90                   	nop
  }
  return d;

bad:
  freevm(d);
8010928c:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010928f:	89 04 24             	mov    %eax,(%esp)
80109292:	e8 22 fe ff ff       	call   801090b9 <freevm>
  return 0;
80109297:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010929c:	c9                   	leave  
8010929d:	c3                   	ret    

8010929e <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
8010929e:	55                   	push   %ebp
8010929f:	89 e5                	mov    %esp,%ebp
801092a1:	83 ec 28             	sub    $0x28,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
801092a4:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
801092ab:	00 
801092ac:	8b 45 0c             	mov    0xc(%ebp),%eax
801092af:	89 44 24 04          	mov    %eax,0x4(%esp)
801092b3:	8b 45 08             	mov    0x8(%ebp),%eax
801092b6:	89 04 24             	mov    %eax,(%esp)
801092b9:	e8 69 f7 ff ff       	call   80108a27 <walkpgdir>
801092be:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if((*pte & PTE_P) == 0)
801092c1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801092c4:	8b 00                	mov    (%eax),%eax
801092c6:	83 e0 01             	and    $0x1,%eax
801092c9:	85 c0                	test   %eax,%eax
801092cb:	75 07                	jne    801092d4 <uva2ka+0x36>
    return 0;
801092cd:	b8 00 00 00 00       	mov    $0x0,%eax
801092d2:	eb 25                	jmp    801092f9 <uva2ka+0x5b>
  if((*pte & PTE_U) == 0)
801092d4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801092d7:	8b 00                	mov    (%eax),%eax
801092d9:	83 e0 04             	and    $0x4,%eax
801092dc:	85 c0                	test   %eax,%eax
801092de:	75 07                	jne    801092e7 <uva2ka+0x49>
    return 0;
801092e0:	b8 00 00 00 00       	mov    $0x0,%eax
801092e5:	eb 12                	jmp    801092f9 <uva2ka+0x5b>
  return (char*)p2v(PTE_ADDR(*pte));
801092e7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801092ea:	8b 00                	mov    (%eax),%eax
801092ec:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801092f1:	89 04 24             	mov    %eax,(%esp)
801092f4:	e8 ab f2 ff ff       	call   801085a4 <p2v>
}
801092f9:	c9                   	leave  
801092fa:	c3                   	ret    

801092fb <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
801092fb:	55                   	push   %ebp
801092fc:	89 e5                	mov    %esp,%ebp
801092fe:	83 ec 28             	sub    $0x28,%esp
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
80109301:	8b 45 10             	mov    0x10(%ebp),%eax
80109304:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(len > 0){
80109307:	e9 8b 00 00 00       	jmp    80109397 <copyout+0x9c>
    va0 = (uint)PGROUNDDOWN(va);
8010930c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010930f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80109314:	89 45 ec             	mov    %eax,-0x14(%ebp)
    pa0 = uva2ka(pgdir, (char*)va0);
80109317:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010931a:	89 44 24 04          	mov    %eax,0x4(%esp)
8010931e:	8b 45 08             	mov    0x8(%ebp),%eax
80109321:	89 04 24             	mov    %eax,(%esp)
80109324:	e8 75 ff ff ff       	call   8010929e <uva2ka>
80109329:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(pa0 == 0)
8010932c:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
80109330:	75 07                	jne    80109339 <copyout+0x3e>
      return -1;
80109332:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80109337:	eb 6d                	jmp    801093a6 <copyout+0xab>
    n = PGSIZE - (va - va0);
80109339:	8b 45 0c             	mov    0xc(%ebp),%eax
8010933c:	8b 55 ec             	mov    -0x14(%ebp),%edx
8010933f:	89 d1                	mov    %edx,%ecx
80109341:	29 c1                	sub    %eax,%ecx
80109343:	89 c8                	mov    %ecx,%eax
80109345:	05 00 10 00 00       	add    $0x1000,%eax
8010934a:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(n > len)
8010934d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80109350:	3b 45 14             	cmp    0x14(%ebp),%eax
80109353:	76 06                	jbe    8010935b <copyout+0x60>
      n = len;
80109355:	8b 45 14             	mov    0x14(%ebp),%eax
80109358:	89 45 f0             	mov    %eax,-0x10(%ebp)
    memmove(pa0 + (va - va0), buf, n);
8010935b:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010935e:	8b 55 0c             	mov    0xc(%ebp),%edx
80109361:	89 d1                	mov    %edx,%ecx
80109363:	29 c1                	sub    %eax,%ecx
80109365:	89 c8                	mov    %ecx,%eax
80109367:	03 45 e8             	add    -0x18(%ebp),%eax
8010936a:	8b 55 f0             	mov    -0x10(%ebp),%edx
8010936d:	89 54 24 08          	mov    %edx,0x8(%esp)
80109371:	8b 55 f4             	mov    -0xc(%ebp),%edx
80109374:	89 54 24 04          	mov    %edx,0x4(%esp)
80109378:	89 04 24             	mov    %eax,(%esp)
8010937b:	e8 59 ca ff ff       	call   80105dd9 <memmove>
    len -= n;
80109380:	8b 45 f0             	mov    -0x10(%ebp),%eax
80109383:	29 45 14             	sub    %eax,0x14(%ebp)
    buf += n;
80109386:	8b 45 f0             	mov    -0x10(%ebp),%eax
80109389:	01 45 f4             	add    %eax,-0xc(%ebp)
    va = va0 + PGSIZE;
8010938c:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010938f:	05 00 10 00 00       	add    $0x1000,%eax
80109394:	89 45 0c             	mov    %eax,0xc(%ebp)
{
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80109397:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
8010939b:	0f 85 6b ff ff ff    	jne    8010930c <copyout+0x11>
    memmove(pa0 + (va - va0), buf, n);
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
801093a1:	b8 00 00 00 00       	mov    $0x0,%eax
}
801093a6:	c9                   	leave  
801093a7:	c3                   	ret    
