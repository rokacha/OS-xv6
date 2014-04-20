
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
80100028:	bc b0 de 10 80       	mov    $0x8010deb0,%esp

  # Jump to main(), and switch to executing at
  # high addresses. The indirect call is needed because
  # the assembler produces a PC-relative instruction
  # for a direct jump.
  mov $main, %eax
8010002d:	b8 ff 38 10 80       	mov    $0x801038ff,%eax
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
8010003a:	c7 44 24 04 48 8e 10 	movl   $0x80108e48,0x4(%esp)
80100041:	80 
80100042:	c7 04 24 c0 de 10 80 	movl   $0x8010dec0,(%esp)
80100049:	e8 94 56 00 00       	call   801056e2 <initlock>

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
8010004e:	c7 05 f0 f3 10 80 e4 	movl   $0x8010f3e4,0x8010f3f0
80100055:	f3 10 80 
  bcache.head.next = &bcache.head;
80100058:	c7 05 f4 f3 10 80 e4 	movl   $0x8010f3e4,0x8010f3f4
8010005f:	f3 10 80 
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100062:	c7 45 f4 f4 de 10 80 	movl   $0x8010def4,-0xc(%ebp)
80100069:	eb 3a                	jmp    801000a5 <binit+0x71>
    b->next = bcache.head.next;
8010006b:	8b 15 f4 f3 10 80    	mov    0x8010f3f4,%edx
80100071:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100074:	89 50 10             	mov    %edx,0x10(%eax)
    b->prev = &bcache.head;
80100077:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010007a:	c7 40 0c e4 f3 10 80 	movl   $0x8010f3e4,0xc(%eax)
    b->dev = -1;
80100081:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100084:	c7 40 04 ff ff ff ff 	movl   $0xffffffff,0x4(%eax)
    bcache.head.next->prev = b;
8010008b:	a1 f4 f3 10 80       	mov    0x8010f3f4,%eax
80100090:	8b 55 f4             	mov    -0xc(%ebp),%edx
80100093:	89 50 0c             	mov    %edx,0xc(%eax)
    bcache.head.next = b;
80100096:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100099:	a3 f4 f3 10 80       	mov    %eax,0x8010f3f4

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
8010009e:	81 45 f4 18 02 00 00 	addl   $0x218,-0xc(%ebp)
801000a5:	81 7d f4 e4 f3 10 80 	cmpl   $0x8010f3e4,-0xc(%ebp)
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
801000b6:	c7 04 24 c0 de 10 80 	movl   $0x8010dec0,(%esp)
801000bd:	e8 41 56 00 00       	call   80105703 <acquire>

 loop:
  // Is the sector already cached?
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000c2:	a1 f4 f3 10 80       	mov    0x8010f3f4,%eax
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
801000fd:	c7 04 24 c0 de 10 80 	movl   $0x8010dec0,(%esp)
80100104:	e8 5c 56 00 00       	call   80105765 <release>
        return b;
80100109:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010010c:	e9 93 00 00 00       	jmp    801001a4 <bget+0xf4>
      }
      sleep(b, &bcache.lock);
80100111:	c7 44 24 04 c0 de 10 	movl   $0x8010dec0,0x4(%esp)
80100118:	80 
80100119:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010011c:	89 04 24             	mov    %eax,(%esp)
8010011f:	e8 e3 51 00 00       	call   80105307 <sleep>
      goto loop;
80100124:	eb 9c                	jmp    801000c2 <bget+0x12>

  acquire(&bcache.lock);

 loop:
  // Is the sector already cached?
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
80100126:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100129:	8b 40 10             	mov    0x10(%eax),%eax
8010012c:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010012f:	81 7d f4 e4 f3 10 80 	cmpl   $0x8010f3e4,-0xc(%ebp)
80100136:	75 94                	jne    801000cc <bget+0x1c>
      goto loop;
    }
  }

  // Not cached; recycle some non-busy and clean buffer.
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100138:	a1 f0 f3 10 80       	mov    0x8010f3f0,%eax
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
80100175:	c7 04 24 c0 de 10 80 	movl   $0x8010dec0,(%esp)
8010017c:	e8 e4 55 00 00       	call   80105765 <release>
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
8010018f:	81 7d f4 e4 f3 10 80 	cmpl   $0x8010f3e4,-0xc(%ebp)
80100196:	75 aa                	jne    80100142 <bget+0x92>
      b->flags = B_BUSY;
      release(&bcache.lock);
      return b;
    }
  }
  panic("bget: no buffers");
80100198:	c7 04 24 4f 8e 10 80 	movl   $0x80108e4f,(%esp)
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
801001d3:	e8 d4 2a 00 00       	call   80102cac <iderw>
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
801001ef:	c7 04 24 60 8e 10 80 	movl   $0x80108e60,(%esp)
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
80100210:	e8 97 2a 00 00       	call   80102cac <iderw>
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
80100229:	c7 04 24 67 8e 10 80 	movl   $0x80108e67,(%esp)
80100230:	e8 08 03 00 00       	call   8010053d <panic>

  acquire(&bcache.lock);
80100235:	c7 04 24 c0 de 10 80 	movl   $0x8010dec0,(%esp)
8010023c:	e8 c2 54 00 00       	call   80105703 <acquire>

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
8010025f:	8b 15 f4 f3 10 80    	mov    0x8010f3f4,%edx
80100265:	8b 45 08             	mov    0x8(%ebp),%eax
80100268:	89 50 10             	mov    %edx,0x10(%eax)
  b->prev = &bcache.head;
8010026b:	8b 45 08             	mov    0x8(%ebp),%eax
8010026e:	c7 40 0c e4 f3 10 80 	movl   $0x8010f3e4,0xc(%eax)
  bcache.head.next->prev = b;
80100275:	a1 f4 f3 10 80       	mov    0x8010f3f4,%eax
8010027a:	8b 55 08             	mov    0x8(%ebp),%edx
8010027d:	89 50 0c             	mov    %edx,0xc(%eax)
  bcache.head.next = b;
80100280:	8b 45 08             	mov    0x8(%ebp),%eax
80100283:	a3 f4 f3 10 80       	mov    %eax,0x8010f3f4

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
8010029d:	e8 53 51 00 00       	call   801053f5 <wakeup>

  release(&bcache.lock);
801002a2:	c7 04 24 c0 de 10 80 	movl   $0x8010dec0,(%esp)
801002a9:	e8 b7 54 00 00       	call   80105765 <release>
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
801003a7:	a1 14 c9 10 80       	mov    0x8010c914,%eax
801003ac:	89 45 e8             	mov    %eax,-0x18(%ebp)
  if(locking)
801003af:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
801003b3:	74 0c                	je     801003c1 <cprintf+0x20>
    acquire(&cons.lock);
801003b5:	c7 04 24 e0 c8 10 80 	movl   $0x8010c8e0,(%esp)
801003bc:	e8 42 53 00 00       	call   80105703 <acquire>

  if (fmt == 0)
801003c1:	8b 45 08             	mov    0x8(%ebp),%eax
801003c4:	85 c0                	test   %eax,%eax
801003c6:	75 0c                	jne    801003d4 <cprintf+0x33>
    panic("null fmt");
801003c8:	c7 04 24 6e 8e 10 80 	movl   $0x80108e6e,(%esp)
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
801004af:	c7 45 ec 77 8e 10 80 	movl   $0x80108e77,-0x14(%ebp)
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
8010052f:	c7 04 24 e0 c8 10 80 	movl   $0x8010c8e0,(%esp)
80100536:	e8 2a 52 00 00       	call   80105765 <release>
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
80100548:	c7 05 14 c9 10 80 00 	movl   $0x0,0x8010c914
8010054f:	00 00 00 
  cprintf("cpu%d: panic: ", cpu->id);
80100552:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80100558:	0f b6 00             	movzbl (%eax),%eax
8010055b:	0f b6 c0             	movzbl %al,%eax
8010055e:	89 44 24 04          	mov    %eax,0x4(%esp)
80100562:	c7 04 24 7e 8e 10 80 	movl   $0x80108e7e,(%esp)
80100569:	e8 33 fe ff ff       	call   801003a1 <cprintf>
  cprintf(s);
8010056e:	8b 45 08             	mov    0x8(%ebp),%eax
80100571:	89 04 24             	mov    %eax,(%esp)
80100574:	e8 28 fe ff ff       	call   801003a1 <cprintf>
  cprintf("\n");
80100579:	c7 04 24 8d 8e 10 80 	movl   $0x80108e8d,(%esp)
80100580:	e8 1c fe ff ff       	call   801003a1 <cprintf>
  getcallerpcs(&s, pcs);
80100585:	8d 45 cc             	lea    -0x34(%ebp),%eax
80100588:	89 44 24 04          	mov    %eax,0x4(%esp)
8010058c:	8d 45 08             	lea    0x8(%ebp),%eax
8010058f:	89 04 24             	mov    %eax,(%esp)
80100592:	e8 1d 52 00 00       	call   801057b4 <getcallerpcs>
  for(i=0; i<10; i++)
80100597:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010059e:	eb 1b                	jmp    801005bb <panic+0x7e>
    cprintf(" %p", pcs[i]);
801005a0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801005a3:	8b 44 85 cc          	mov    -0x34(%ebp,%eax,4),%eax
801005a7:	89 44 24 04          	mov    %eax,0x4(%esp)
801005ab:	c7 04 24 8f 8e 10 80 	movl   $0x80108e8f,(%esp)
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
801005c1:	c7 05 c0 c8 10 80 01 	movl   $0x1,0x8010c8c0
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
801006d8:	e8 48 53 00 00       	call   80105a25 <memmove>
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
80100707:	e8 46 52 00 00       	call   80105952 <memset>
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
8010076b:	a1 c0 c8 10 80       	mov    0x8010c8c0,%eax
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
8010078b:	e8 1d 6d 00 00       	call   801074ad <uartputc>
80100790:	eb 3a                	jmp    801007cc <consputc+0x67>
  } else
  if(c == BACKSPACE){
80100792:	81 7d 08 00 01 00 00 	cmpl   $0x100,0x8(%ebp)
80100799:	75 26                	jne    801007c1 <consputc+0x5c>
    uartputc('\b'); uartputc(' '); uartputc('\b');
8010079b:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
801007a2:	e8 06 6d 00 00       	call   801074ad <uartputc>
801007a7:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801007ae:	e8 fa 6c 00 00       	call   801074ad <uartputc>
801007b3:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
801007ba:	e8 ee 6c 00 00       	call   801074ad <uartputc>
801007bf:	eb 0b                	jmp    801007cc <consputc+0x67>
  } else
    uartputc(c);
801007c1:	8b 45 08             	mov    0x8(%ebp),%eax
801007c4:	89 04 24             	mov    %eax,(%esp)
801007c7:	e8 e1 6c 00 00       	call   801074ad <uartputc>
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
801007e1:	a1 bc f6 10 80       	mov    0x8010f6bc,%eax
801007e6:	89 c2                	mov    %eax,%edx
801007e8:	83 e2 7f             	and    $0x7f,%edx
801007eb:	c6 82 34 f6 10 80 00 	movb   $0x0,-0x7fef09cc(%edx)
801007f2:	83 e8 01             	sub    $0x1,%eax
801007f5:	a3 bc f6 10 80       	mov    %eax,0x8010f6bc
      input.last--;
801007fa:	a1 c0 f6 10 80       	mov    0x8010f6c0,%eax
801007ff:	83 e8 01             	sub    $0x1,%eax
80100802:	a3 c0 f6 10 80       	mov    %eax,0x8010f6c0
      consputc(BACKSPACE);
80100807:	c7 04 24 00 01 00 00 	movl   $0x100,(%esp)
8010080e:	e8 52 ff ff ff       	call   80100765 <consputc>
replace_line_on_screen()
{
  int c;
  uint counter;

  while(input.e > input.w)
80100813:	8b 15 bc f6 10 80    	mov    0x8010f6bc,%edx
80100819:	a1 b8 f6 10 80       	mov    0x8010f6b8,%eax
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
8010082b:	8b 0d c8 00 11 80    	mov    0x801100c8,%ecx
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
80100858:	05 c0 f6 10 80       	add    $0x8010f6c0,%eax
8010085d:	0f b6 40 04          	movzbl 0x4(%eax),%eax
80100861:	0f be c0             	movsbl %al,%eax
80100864:	89 45 f4             	mov    %eax,-0xc(%ebp)
      input.buf[input.e++ % INPUT_BUF] = c;
80100867:	a1 bc f6 10 80       	mov    0x8010f6bc,%eax
8010086c:	89 c1                	mov    %eax,%ecx
8010086e:	83 e1 7f             	and    $0x7f,%ecx
80100871:	8b 55 f4             	mov    -0xc(%ebp),%edx
80100874:	88 91 34 f6 10 80    	mov    %dl,-0x7fef09cc(%ecx)
8010087a:	83 c0 01             	add    $0x1,%eax
8010087d:	a3 bc f6 10 80       	mov    %eax,0x8010f6bc
      input.last++;
80100882:	a1 c0 f6 10 80       	mov    0x8010f6c0,%eax
80100887:	83 c0 01             	add    $0x1,%eax
8010088a:	a3 c0 f6 10 80       	mov    %eax,0x8010f6c0
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
  
  acquire(&input.lock);
801008c3:	c7 04 24 00 f6 10 80 	movl   $0x8010f600,(%esp)
801008ca:	e8 34 4e 00 00       	call   80105703 <acquire>
  while((c = getc()) >= 0){
801008cf:	e9 50 04 00 00       	jmp    80100d24 <consoleintr+0x469>
    switch(c){
801008d4:	8b 45 f4             	mov    -0xc(%ebp),%eax
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
801008f8:	e9 a3 02 00 00       	jmp    80100ba0 <consoleintr+0x2e5>
801008fd:	3d e3 00 00 00       	cmp    $0xe3,%eax
80100902:	0f 84 40 01 00 00    	je     80100a48 <consoleintr+0x18d>
80100908:	3d e3 00 00 00       	cmp    $0xe3,%eax
8010090d:	7f 10                	jg     8010091f <consoleintr+0x64>
8010090f:	3d e2 00 00 00       	cmp    $0xe2,%eax
80100914:	0f 84 db 01 00 00    	je     80100af5 <consoleintr+0x23a>
8010091a:	e9 81 02 00 00       	jmp    80100ba0 <consoleintr+0x2e5>
8010091f:	3d e4 00 00 00       	cmp    $0xe4,%eax
80100924:	0f 84 af 00 00 00    	je     801009d9 <consoleintr+0x11e>
8010092a:	3d e5 00 00 00       	cmp    $0xe5,%eax
8010092f:	0f 84 d4 00 00 00    	je     80100a09 <consoleintr+0x14e>
80100935:	e9 66 02 00 00       	jmp    80100ba0 <consoleintr+0x2e5>
    case C('P'):  // Process listing.
      procdump();
8010093a:	e8 65 4b 00 00       	call   801054a4 <procdump>
      break;
8010093f:	e9 e0 03 00 00       	jmp    80100d24 <consoleintr+0x469>

    case C('U'):  // Kill line.
      while(input.e != input.w &&
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
        input.e--;
80100944:	a1 bc f6 10 80       	mov    0x8010f6bc,%eax
80100949:	83 e8 01             	sub    $0x1,%eax
8010094c:	a3 bc f6 10 80       	mov    %eax,0x8010f6bc
        input.last--;
80100951:	a1 c0 f6 10 80       	mov    0x8010f6c0,%eax
80100956:	83 e8 01             	sub    $0x1,%eax
80100959:	a3 c0 f6 10 80       	mov    %eax,0x8010f6c0
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
8010096d:	8b 15 bc f6 10 80    	mov    0x8010f6bc,%edx
80100973:	a1 b8 f6 10 80       	mov    0x8010f6b8,%eax
80100978:	39 c2                	cmp    %eax,%edx
8010097a:	0f 84 91 03 00 00    	je     80100d11 <consoleintr+0x456>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
80100980:	a1 bc f6 10 80       	mov    0x8010f6bc,%eax
80100985:	83 e8 01             	sub    $0x1,%eax
80100988:	83 e0 7f             	and    $0x7f,%eax
8010098b:	0f b6 80 34 f6 10 80 	movzbl -0x7fef09cc(%eax),%eax
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
80100996:	e9 76 03 00 00       	jmp    80100d11 <consoleintr+0x456>

    case C('H'):    case '\x7f':  // Backspace
      if(input.e != input.w)
8010099b:	8b 15 bc f6 10 80    	mov    0x8010f6bc,%edx
801009a1:	a1 b8 f6 10 80       	mov    0x8010f6b8,%eax
801009a6:	39 c2                	cmp    %eax,%edx
801009a8:	0f 84 66 03 00 00    	je     80100d14 <consoleintr+0x459>
      {
        input.e--;
801009ae:	a1 bc f6 10 80       	mov    0x8010f6bc,%eax
801009b3:	83 e8 01             	sub    $0x1,%eax
801009b6:	a3 bc f6 10 80       	mov    %eax,0x8010f6bc
        input.last--;
801009bb:	a1 c0 f6 10 80       	mov    0x8010f6c0,%eax
801009c0:	83 e8 01             	sub    $0x1,%eax
801009c3:	a3 c0 f6 10 80       	mov    %eax,0x8010f6c0
        consputc(BACKSPACE);
801009c8:	c7 04 24 00 01 00 00 	movl   $0x100,(%esp)
801009cf:	e8 91 fd ff ff       	call   80100765 <consputc>
      }
      break;
801009d4:	e9 3b 03 00 00       	jmp    80100d14 <consoleintr+0x459>

    case KEY_LF:  // left arrow
      if(input.e != input.w)
801009d9:	8b 15 bc f6 10 80    	mov    0x8010f6bc,%edx
801009df:	a1 b8 f6 10 80       	mov    0x8010f6b8,%eax
801009e4:	39 c2                	cmp    %eax,%edx
801009e6:	0f 84 2b 03 00 00    	je     80100d17 <consoleintr+0x45c>
      {
        input.e--;
801009ec:	a1 bc f6 10 80       	mov    0x8010f6bc,%eax
801009f1:	83 e8 01             	sub    $0x1,%eax
801009f4:	a3 bc f6 10 80       	mov    %eax,0x8010f6bc
        consputc(c);
801009f9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801009fc:	89 04 24             	mov    %eax,(%esp)
801009ff:	e8 61 fd ff ff       	call   80100765 <consputc>
      }
      break;
80100a04:	e9 0e 03 00 00       	jmp    80100d17 <consoleintr+0x45c>

    case KEY_RT:  // right arrow
      if(input.e < input.last)
80100a09:	8b 15 bc f6 10 80    	mov    0x8010f6bc,%edx
80100a0f:	a1 c0 f6 10 80       	mov    0x8010f6c0,%eax
80100a14:	39 c2                	cmp    %eax,%edx
80100a16:	0f 83 fe 02 00 00    	jae    80100d1a <consoleintr+0x45f>
      {
        consputc(input.buf[input.e% INPUT_BUF]);
80100a1c:	a1 bc f6 10 80       	mov    0x8010f6bc,%eax
80100a21:	83 e0 7f             	and    $0x7f,%eax
80100a24:	0f b6 80 34 f6 10 80 	movzbl -0x7fef09cc(%eax),%eax
80100a2b:	0f be c0             	movsbl %al,%eax
80100a2e:	89 04 24             	mov    %eax,(%esp)
80100a31:	e8 2f fd ff ff       	call   80100765 <consputc>
        input.e++;
80100a36:	a1 bc f6 10 80       	mov    0x8010f6bc,%eax
80100a3b:	83 c0 01             	add    $0x1,%eax
80100a3e:	a3 bc f6 10 80       	mov    %eax,0x8010f6bc
      }
      break;
80100a43:	e9 d2 02 00 00       	jmp    80100d1a <consoleintr+0x45f>

      case KEY_DN:  // down arrow
      
      if((input.history_end % MAX_HISTORY_LENGTH) != (input.history_start % MAX_HISTORY_LENGTH) 
80100a48:	8b 1d cc 00 11 80    	mov    0x801100cc,%ebx
80100a4e:	ba cd cc cc cc       	mov    $0xcccccccd,%edx
80100a53:	89 d8                	mov    %ebx,%eax
80100a55:	f7 e2                	mul    %edx
80100a57:	89 d1                	mov    %edx,%ecx
80100a59:	c1 e9 04             	shr    $0x4,%ecx
80100a5c:	89 c8                	mov    %ecx,%eax
80100a5e:	c1 e0 02             	shl    $0x2,%eax
80100a61:	01 c8                	add    %ecx,%eax
80100a63:	c1 e0 02             	shl    $0x2,%eax
80100a66:	89 d9                	mov    %ebx,%ecx
80100a68:	29 c1                	sub    %eax,%ecx
80100a6a:	8b 1d c4 00 11 80    	mov    0x801100c4,%ebx
80100a70:	ba cd cc cc cc       	mov    $0xcccccccd,%edx
80100a75:	89 d8                	mov    %ebx,%eax
80100a77:	f7 e2                	mul    %edx
80100a79:	c1 ea 04             	shr    $0x4,%edx
80100a7c:	89 d0                	mov    %edx,%eax
80100a7e:	c1 e0 02             	shl    $0x2,%eax
80100a81:	01 d0                	add    %edx,%eax
80100a83:	c1 e0 02             	shl    $0x2,%eax
80100a86:	89 da                	mov    %ebx,%edx
80100a88:	29 c2                	sub    %eax,%edx
80100a8a:	39 d1                	cmp    %edx,%ecx
80100a8c:	0f 84 8b 02 00 00    	je     80100d1d <consoleintr+0x462>
        && ((input.history_indx + 1) % MAX_HISTORY_LENGTH) != (input.history_end % MAX_HISTORY_LENGTH ))
80100a92:	a1 c8 00 11 80       	mov    0x801100c8,%eax
80100a97:	8d 58 01             	lea    0x1(%eax),%ebx
80100a9a:	ba cd cc cc cc       	mov    $0xcccccccd,%edx
80100a9f:	89 d8                	mov    %ebx,%eax
80100aa1:	f7 e2                	mul    %edx
80100aa3:	89 d1                	mov    %edx,%ecx
80100aa5:	c1 e9 04             	shr    $0x4,%ecx
80100aa8:	89 c8                	mov    %ecx,%eax
80100aaa:	c1 e0 02             	shl    $0x2,%eax
80100aad:	01 c8                	add    %ecx,%eax
80100aaf:	c1 e0 02             	shl    $0x2,%eax
80100ab2:	89 d9                	mov    %ebx,%ecx
80100ab4:	29 c1                	sub    %eax,%ecx
80100ab6:	8b 1d cc 00 11 80    	mov    0x801100cc,%ebx
80100abc:	ba cd cc cc cc       	mov    $0xcccccccd,%edx
80100ac1:	89 d8                	mov    %ebx,%eax
80100ac3:	f7 e2                	mul    %edx
80100ac5:	c1 ea 04             	shr    $0x4,%edx
80100ac8:	89 d0                	mov    %edx,%eax
80100aca:	c1 e0 02             	shl    $0x2,%eax
80100acd:	01 d0                	add    %edx,%eax
80100acf:	c1 e0 02             	shl    $0x2,%eax
80100ad2:	89 da                	mov    %ebx,%edx
80100ad4:	29 c2                	sub    %eax,%edx
80100ad6:	39 d1                	cmp    %edx,%ecx
80100ad8:	0f 84 3f 02 00 00    	je     80100d1d <consoleintr+0x462>
      {
        input.history_indx++;
80100ade:	a1 c8 00 11 80       	mov    0x801100c8,%eax
80100ae3:	83 c0 01             	add    $0x1,%eax
80100ae6:	a3 c8 00 11 80       	mov    %eax,0x801100c8
        replace_line_on_screen();
80100aeb:	e8 e9 fc ff ff       	call   801007d9 <replace_line_on_screen>
      }
      break;
80100af0:	e9 28 02 00 00       	jmp    80100d1d <consoleintr+0x462>

      case KEY_UP:  // up arrow
      
      if((input.history_end % MAX_HISTORY_LENGTH) != (input.history_start % MAX_HISTORY_LENGTH)
80100af5:	8b 1d cc 00 11 80    	mov    0x801100cc,%ebx
80100afb:	ba cd cc cc cc       	mov    $0xcccccccd,%edx
80100b00:	89 d8                	mov    %ebx,%eax
80100b02:	f7 e2                	mul    %edx
80100b04:	89 d1                	mov    %edx,%ecx
80100b06:	c1 e9 04             	shr    $0x4,%ecx
80100b09:	89 c8                	mov    %ecx,%eax
80100b0b:	c1 e0 02             	shl    $0x2,%eax
80100b0e:	01 c8                	add    %ecx,%eax
80100b10:	c1 e0 02             	shl    $0x2,%eax
80100b13:	89 d9                	mov    %ebx,%ecx
80100b15:	29 c1                	sub    %eax,%ecx
80100b17:	8b 1d c4 00 11 80    	mov    0x801100c4,%ebx
80100b1d:	ba cd cc cc cc       	mov    $0xcccccccd,%edx
80100b22:	89 d8                	mov    %ebx,%eax
80100b24:	f7 e2                	mul    %edx
80100b26:	c1 ea 04             	shr    $0x4,%edx
80100b29:	89 d0                	mov    %edx,%eax
80100b2b:	c1 e0 02             	shl    $0x2,%eax
80100b2e:	01 d0                	add    %edx,%eax
80100b30:	c1 e0 02             	shl    $0x2,%eax
80100b33:	89 da                	mov    %ebx,%edx
80100b35:	29 c2                	sub    %eax,%edx
80100b37:	39 d1                	cmp    %edx,%ecx
80100b39:	0f 84 e1 01 00 00    	je     80100d20 <consoleintr+0x465>
       && ((input.history_indx) % MAX_HISTORY_LENGTH) != (input.history_start % MAX_HISTORY_LENGTH) )
80100b3f:	8b 1d c8 00 11 80    	mov    0x801100c8,%ebx
80100b45:	ba cd cc cc cc       	mov    $0xcccccccd,%edx
80100b4a:	89 d8                	mov    %ebx,%eax
80100b4c:	f7 e2                	mul    %edx
80100b4e:	89 d1                	mov    %edx,%ecx
80100b50:	c1 e9 04             	shr    $0x4,%ecx
80100b53:	89 c8                	mov    %ecx,%eax
80100b55:	c1 e0 02             	shl    $0x2,%eax
80100b58:	01 c8                	add    %ecx,%eax
80100b5a:	c1 e0 02             	shl    $0x2,%eax
80100b5d:	89 d9                	mov    %ebx,%ecx
80100b5f:	29 c1                	sub    %eax,%ecx
80100b61:	8b 1d c4 00 11 80    	mov    0x801100c4,%ebx
80100b67:	ba cd cc cc cc       	mov    $0xcccccccd,%edx
80100b6c:	89 d8                	mov    %ebx,%eax
80100b6e:	f7 e2                	mul    %edx
80100b70:	c1 ea 04             	shr    $0x4,%edx
80100b73:	89 d0                	mov    %edx,%eax
80100b75:	c1 e0 02             	shl    $0x2,%eax
80100b78:	01 d0                	add    %edx,%eax
80100b7a:	c1 e0 02             	shl    $0x2,%eax
80100b7d:	89 da                	mov    %ebx,%edx
80100b7f:	29 c2                	sub    %eax,%edx
80100b81:	39 d1                	cmp    %edx,%ecx
80100b83:	0f 84 97 01 00 00    	je     80100d20 <consoleintr+0x465>
      {
        input.history_indx--;
80100b89:	a1 c8 00 11 80       	mov    0x801100c8,%eax
80100b8e:	83 e8 01             	sub    $0x1,%eax
80100b91:	a3 c8 00 11 80       	mov    %eax,0x801100c8
        replace_line_on_screen();
80100b96:	e8 3e fc ff ff       	call   801007d9 <replace_line_on_screen>
      }
      break;
80100b9b:	e9 80 01 00 00       	jmp    80100d20 <consoleintr+0x465>

    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
80100ba0:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80100ba4:	0f 84 79 01 00 00    	je     80100d23 <consoleintr+0x468>
80100baa:	8b 15 bc f6 10 80    	mov    0x8010f6bc,%edx
80100bb0:	a1 b4 f6 10 80       	mov    0x8010f6b4,%eax
80100bb5:	89 d1                	mov    %edx,%ecx
80100bb7:	29 c1                	sub    %eax,%ecx
80100bb9:	89 c8                	mov    %ecx,%eax
80100bbb:	83 f8 7f             	cmp    $0x7f,%eax
80100bbe:	0f 87 5f 01 00 00    	ja     80100d23 <consoleintr+0x468>
        c = (c == '\r') ? '\n' : c;
80100bc4:	83 7d f4 0d          	cmpl   $0xd,-0xc(%ebp)
80100bc8:	74 05                	je     80100bcf <consoleintr+0x314>
80100bca:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100bcd:	eb 05                	jmp    80100bd4 <consoleintr+0x319>
80100bcf:	b8 0a 00 00 00       	mov    $0xa,%eax
80100bd4:	89 45 f4             	mov    %eax,-0xc(%ebp)
        input.buf[input.e++ % INPUT_BUF] = c;
80100bd7:	a1 bc f6 10 80       	mov    0x8010f6bc,%eax
80100bdc:	89 c1                	mov    %eax,%ecx
80100bde:	83 e1 7f             	and    $0x7f,%ecx
80100be1:	8b 55 f4             	mov    -0xc(%ebp),%edx
80100be4:	88 91 34 f6 10 80    	mov    %dl,-0x7fef09cc(%ecx)
80100bea:	83 c0 01             	add    $0x1,%eax
80100bed:	a3 bc f6 10 80       	mov    %eax,0x8010f6bc
        input.last++;
80100bf2:	a1 c0 f6 10 80       	mov    0x8010f6c0,%eax
80100bf7:	83 c0 01             	add    $0x1,%eax
80100bfa:	a3 c0 f6 10 80       	mov    %eax,0x8010f6c0
        consputc(c);  
80100bff:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100c02:	89 04 24             	mov    %eax,(%esp)
80100c05:	e8 5b fb ff ff       	call   80100765 <consputc>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF)
80100c0a:	83 7d f4 0a          	cmpl   $0xa,-0xc(%ebp)
80100c0e:	74 1c                	je     80100c2c <consoleintr+0x371>
80100c10:	83 7d f4 04          	cmpl   $0x4,-0xc(%ebp)
80100c14:	74 16                	je     80100c2c <consoleintr+0x371>
80100c16:	a1 bc f6 10 80       	mov    0x8010f6bc,%eax
80100c1b:	8b 15 b4 f6 10 80    	mov    0x8010f6b4,%edx
80100c21:	83 ea 80             	sub    $0xffffff80,%edx
80100c24:	39 d0                	cmp    %edx,%eax
80100c26:	0f 85 f7 00 00 00    	jne    80100d23 <consoleintr+0x468>
        {
          strncpy(input.history[input.history_end % MAX_HISTORY_LENGTH]
            ,&input.buf[input.w% INPUT_BUF]
            ,input.last-input.w-1);
80100c2c:	8b 15 c0 f6 10 80    	mov    0x8010f6c0,%edx
80100c32:	a1 b8 f6 10 80       	mov    0x8010f6b8,%eax
80100c37:	89 d1                	mov    %edx,%ecx
80100c39:	29 c1                	sub    %eax,%ecx
80100c3b:	89 c8                	mov    %ecx,%eax
80100c3d:	83 e8 01             	sub    $0x1,%eax
        input.buf[input.e++ % INPUT_BUF] = c;
        input.last++;
        consputc(c);  
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF)
        {
          strncpy(input.history[input.history_end % MAX_HISTORY_LENGTH]
80100c40:	89 c3                	mov    %eax,%ebx
            ,&input.buf[input.w% INPUT_BUF]
80100c42:	a1 b8 f6 10 80       	mov    0x8010f6b8,%eax
        input.buf[input.e++ % INPUT_BUF] = c;
        input.last++;
        consputc(c);  
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF)
        {
          strncpy(input.history[input.history_end % MAX_HISTORY_LENGTH]
80100c47:	83 e0 7f             	and    $0x7f,%eax
80100c4a:	8d b0 34 f6 10 80    	lea    -0x7fef09cc(%eax),%esi
80100c50:	8b 0d cc 00 11 80    	mov    0x801100cc,%ecx
80100c56:	ba cd cc cc cc       	mov    $0xcccccccd,%edx
80100c5b:	89 c8                	mov    %ecx,%eax
80100c5d:	f7 e2                	mul    %edx
80100c5f:	c1 ea 04             	shr    $0x4,%edx
80100c62:	89 d0                	mov    %edx,%eax
80100c64:	c1 e0 02             	shl    $0x2,%eax
80100c67:	01 d0                	add    %edx,%eax
80100c69:	c1 e0 02             	shl    $0x2,%eax
80100c6c:	89 ca                	mov    %ecx,%edx
80100c6e:	29 c2                	sub    %eax,%edx
80100c70:	89 d0                	mov    %edx,%eax
80100c72:	c1 e0 02             	shl    $0x2,%eax
80100c75:	01 d0                	add    %edx,%eax
80100c77:	c1 e0 02             	shl    $0x2,%eax
80100c7a:	05 c4 f6 10 80       	add    $0x8010f6c4,%eax
80100c7f:	89 5c 24 08          	mov    %ebx,0x8(%esp)
80100c83:	89 74 24 04          	mov    %esi,0x4(%esp)
80100c87:	89 04 24             	mov    %eax,(%esp)
80100c8a:	e8 92 4e 00 00       	call   80105b21 <strncpy>
            ,&input.buf[input.w% INPUT_BUF]
            ,input.last-input.w-1);
          input.history_indx=++input.history_end;
80100c8f:	a1 cc 00 11 80       	mov    0x801100cc,%eax
80100c94:	83 c0 01             	add    $0x1,%eax
80100c97:	a3 cc 00 11 80       	mov    %eax,0x801100cc
80100c9c:	a1 cc 00 11 80       	mov    0x801100cc,%eax
80100ca1:	a3 c8 00 11 80       	mov    %eax,0x801100c8
          if ((input.history_end % MAX_HISTORY_LENGTH) == (input.history_start % MAX_HISTORY_LENGTH))
80100ca6:	8b 1d cc 00 11 80    	mov    0x801100cc,%ebx
80100cac:	ba cd cc cc cc       	mov    $0xcccccccd,%edx
80100cb1:	89 d8                	mov    %ebx,%eax
80100cb3:	f7 e2                	mul    %edx
80100cb5:	89 d1                	mov    %edx,%ecx
80100cb7:	c1 e9 04             	shr    $0x4,%ecx
80100cba:	89 c8                	mov    %ecx,%eax
80100cbc:	c1 e0 02             	shl    $0x2,%eax
80100cbf:	01 c8                	add    %ecx,%eax
80100cc1:	c1 e0 02             	shl    $0x2,%eax
80100cc4:	89 d9                	mov    %ebx,%ecx
80100cc6:	29 c1                	sub    %eax,%ecx
80100cc8:	8b 1d c4 00 11 80    	mov    0x801100c4,%ebx
80100cce:	ba cd cc cc cc       	mov    $0xcccccccd,%edx
80100cd3:	89 d8                	mov    %ebx,%eax
80100cd5:	f7 e2                	mul    %edx
80100cd7:	c1 ea 04             	shr    $0x4,%edx
80100cda:	89 d0                	mov    %edx,%eax
80100cdc:	c1 e0 02             	shl    $0x2,%eax
80100cdf:	01 d0                	add    %edx,%eax
80100ce1:	c1 e0 02             	shl    $0x2,%eax
80100ce4:	89 da                	mov    %ebx,%edx
80100ce6:	29 c2                	sub    %eax,%edx
80100ce8:	39 d1                	cmp    %edx,%ecx
80100cea:	75 0d                	jne    80100cf9 <consoleintr+0x43e>
          {
           input.history_start++;
80100cec:	a1 c4 00 11 80       	mov    0x801100c4,%eax
80100cf1:	83 c0 01             	add    $0x1,%eax
80100cf4:	a3 c4 00 11 80       	mov    %eax,0x801100c4
          }
          input.w = input.e;
80100cf9:	a1 bc f6 10 80       	mov    0x8010f6bc,%eax
80100cfe:	a3 b8 f6 10 80       	mov    %eax,0x8010f6b8
          wakeup(&input.r);
80100d03:	c7 04 24 b4 f6 10 80 	movl   $0x8010f6b4,(%esp)
80100d0a:	e8 e6 46 00 00       	call   801053f5 <wakeup>
        }
      }
      break;
80100d0f:	eb 12                	jmp    80100d23 <consoleintr+0x468>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
        input.e--;
        input.last--;
        consputc(BACKSPACE);
      }
      break;
80100d11:	90                   	nop
80100d12:	eb 10                	jmp    80100d24 <consoleintr+0x469>
      {
        input.e--;
        input.last--;
        consputc(BACKSPACE);
      }
      break;
80100d14:	90                   	nop
80100d15:	eb 0d                	jmp    80100d24 <consoleintr+0x469>
      if(input.e != input.w)
      {
        input.e--;
        consputc(c);
      }
      break;
80100d17:	90                   	nop
80100d18:	eb 0a                	jmp    80100d24 <consoleintr+0x469>
      if(input.e < input.last)
      {
        consputc(input.buf[input.e% INPUT_BUF]);
        input.e++;
      }
      break;
80100d1a:	90                   	nop
80100d1b:	eb 07                	jmp    80100d24 <consoleintr+0x469>
        && ((input.history_indx + 1) % MAX_HISTORY_LENGTH) != (input.history_end % MAX_HISTORY_LENGTH ))
      {
        input.history_indx++;
        replace_line_on_screen();
      }
      break;
80100d1d:	90                   	nop
80100d1e:	eb 04                	jmp    80100d24 <consoleintr+0x469>
       && ((input.history_indx) % MAX_HISTORY_LENGTH) != (input.history_start % MAX_HISTORY_LENGTH) )
      {
        input.history_indx--;
        replace_line_on_screen();
      }
      break;
80100d20:	90                   	nop
80100d21:	eb 01                	jmp    80100d24 <consoleintr+0x469>
          }
          input.w = input.e;
          wakeup(&input.r);
        }
      }
      break;
80100d23:	90                   	nop
consoleintr(int (*getc)(void))
{
  int c;
  
  acquire(&input.lock);
  while((c = getc()) >= 0){
80100d24:	8b 45 08             	mov    0x8(%ebp),%eax
80100d27:	ff d0                	call   *%eax
80100d29:	89 45 f4             	mov    %eax,-0xc(%ebp)
80100d2c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80100d30:	0f 89 9e fb ff ff    	jns    801008d4 <consoleintr+0x19>
        }
      }
      break;
    }
  }
  release(&input.lock);
80100d36:	c7 04 24 00 f6 10 80 	movl   $0x8010f600,(%esp)
80100d3d:	e8 23 4a 00 00       	call   80105765 <release>
}
80100d42:	83 c4 20             	add    $0x20,%esp
80100d45:	5b                   	pop    %ebx
80100d46:	5e                   	pop    %esi
80100d47:	5d                   	pop    %ebp
80100d48:	c3                   	ret    

80100d49 <consoleread>:



int
consoleread(struct inode *ip, char *dst, int n)
{
80100d49:	55                   	push   %ebp
80100d4a:	89 e5                	mov    %esp,%ebp
80100d4c:	83 ec 28             	sub    $0x28,%esp
  uint target;
  int c;

  iunlock(ip);
80100d4f:	8b 45 08             	mov    0x8(%ebp),%eax
80100d52:	89 04 24             	mov    %eax,(%esp)
80100d55:	e8 54 11 00 00       	call   80101eae <iunlock>
  target = n;
80100d5a:	8b 45 10             	mov    0x10(%ebp),%eax
80100d5d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  acquire(&input.lock);
80100d60:	c7 04 24 00 f6 10 80 	movl   $0x8010f600,(%esp)
80100d67:	e8 97 49 00 00       	call   80105703 <acquire>
  while(n > 0){
80100d6c:	e9 a8 00 00 00       	jmp    80100e19 <consoleread+0xd0>
    while(input.r == input.w){
      if(proc->killed){
80100d71:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100d77:	8b 40 24             	mov    0x24(%eax),%eax
80100d7a:	85 c0                	test   %eax,%eax
80100d7c:	74 21                	je     80100d9f <consoleread+0x56>
        release(&input.lock);
80100d7e:	c7 04 24 00 f6 10 80 	movl   $0x8010f600,(%esp)
80100d85:	e8 db 49 00 00       	call   80105765 <release>
        ilock(ip);
80100d8a:	8b 45 08             	mov    0x8(%ebp),%eax
80100d8d:	89 04 24             	mov    %eax,(%esp)
80100d90:	e8 cb 0f 00 00       	call   80101d60 <ilock>
        return -1;
80100d95:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100d9a:	e9 a9 00 00 00       	jmp    80100e48 <consoleread+0xff>
      }
      sleep(&input.r, &input.lock);
80100d9f:	c7 44 24 04 00 f6 10 	movl   $0x8010f600,0x4(%esp)
80100da6:	80 
80100da7:	c7 04 24 b4 f6 10 80 	movl   $0x8010f6b4,(%esp)
80100dae:	e8 54 45 00 00       	call   80105307 <sleep>
80100db3:	eb 01                	jmp    80100db6 <consoleread+0x6d>

  iunlock(ip);
  target = n;
  acquire(&input.lock);
  while(n > 0){
    while(input.r == input.w){
80100db5:	90                   	nop
80100db6:	8b 15 b4 f6 10 80    	mov    0x8010f6b4,%edx
80100dbc:	a1 b8 f6 10 80       	mov    0x8010f6b8,%eax
80100dc1:	39 c2                	cmp    %eax,%edx
80100dc3:	74 ac                	je     80100d71 <consoleread+0x28>
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &input.lock);
    }
    c = input.buf[input.r++ % INPUT_BUF];
80100dc5:	a1 b4 f6 10 80       	mov    0x8010f6b4,%eax
80100dca:	89 c2                	mov    %eax,%edx
80100dcc:	83 e2 7f             	and    $0x7f,%edx
80100dcf:	0f b6 92 34 f6 10 80 	movzbl -0x7fef09cc(%edx),%edx
80100dd6:	0f be d2             	movsbl %dl,%edx
80100dd9:	89 55 f0             	mov    %edx,-0x10(%ebp)
80100ddc:	83 c0 01             	add    $0x1,%eax
80100ddf:	a3 b4 f6 10 80       	mov    %eax,0x8010f6b4
    if(c == C('D')){  // EOF
80100de4:	83 7d f0 04          	cmpl   $0x4,-0x10(%ebp)
80100de8:	75 17                	jne    80100e01 <consoleread+0xb8>
      if(n < target){
80100dea:	8b 45 10             	mov    0x10(%ebp),%eax
80100ded:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80100df0:	73 2f                	jae    80100e21 <consoleread+0xd8>
        // Save ^D for next time, to make sure
        // caller gets a 0-byte result.
        input.r--;
80100df2:	a1 b4 f6 10 80       	mov    0x8010f6b4,%eax
80100df7:	83 e8 01             	sub    $0x1,%eax
80100dfa:	a3 b4 f6 10 80       	mov    %eax,0x8010f6b4
      }
      break;
80100dff:	eb 20                	jmp    80100e21 <consoleread+0xd8>
    }
    *dst++ = c;
80100e01:	8b 45 f0             	mov    -0x10(%ebp),%eax
80100e04:	89 c2                	mov    %eax,%edx
80100e06:	8b 45 0c             	mov    0xc(%ebp),%eax
80100e09:	88 10                	mov    %dl,(%eax)
80100e0b:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
    --n;
80100e0f:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
    if(c == '\n')
80100e13:	83 7d f0 0a          	cmpl   $0xa,-0x10(%ebp)
80100e17:	74 0b                	je     80100e24 <consoleread+0xdb>
  int c;

  iunlock(ip);
  target = n;
  acquire(&input.lock);
  while(n > 0){
80100e19:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80100e1d:	7f 96                	jg     80100db5 <consoleread+0x6c>
80100e1f:	eb 04                	jmp    80100e25 <consoleread+0xdc>
      if(n < target){
        // Save ^D for next time, to make sure
        // caller gets a 0-byte result.
        input.r--;
      }
      break;
80100e21:	90                   	nop
80100e22:	eb 01                	jmp    80100e25 <consoleread+0xdc>
    }
    *dst++ = c;
    --n;
    if(c == '\n')
      break;
80100e24:	90                   	nop
  }
  release(&input.lock);
80100e25:	c7 04 24 00 f6 10 80 	movl   $0x8010f600,(%esp)
80100e2c:	e8 34 49 00 00       	call   80105765 <release>
  ilock(ip);
80100e31:	8b 45 08             	mov    0x8(%ebp),%eax
80100e34:	89 04 24             	mov    %eax,(%esp)
80100e37:	e8 24 0f 00 00       	call   80101d60 <ilock>

  return target - n;
80100e3c:	8b 45 10             	mov    0x10(%ebp),%eax
80100e3f:	8b 55 f4             	mov    -0xc(%ebp),%edx
80100e42:	89 d1                	mov    %edx,%ecx
80100e44:	29 c1                	sub    %eax,%ecx
80100e46:	89 c8                	mov    %ecx,%eax
}
80100e48:	c9                   	leave  
80100e49:	c3                   	ret    

80100e4a <consolewrite>:

int
consolewrite(struct inode *ip, char *buf, int n)
{
80100e4a:	55                   	push   %ebp
80100e4b:	89 e5                	mov    %esp,%ebp
80100e4d:	83 ec 28             	sub    $0x28,%esp
  int i;

  iunlock(ip);
80100e50:	8b 45 08             	mov    0x8(%ebp),%eax
80100e53:	89 04 24             	mov    %eax,(%esp)
80100e56:	e8 53 10 00 00       	call   80101eae <iunlock>
  acquire(&cons.lock);
80100e5b:	c7 04 24 e0 c8 10 80 	movl   $0x8010c8e0,(%esp)
80100e62:	e8 9c 48 00 00       	call   80105703 <acquire>
  for(i = 0; i < n; i++)
80100e67:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80100e6e:	eb 1d                	jmp    80100e8d <consolewrite+0x43>
    consputc(buf[i] & 0xff);
80100e70:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100e73:	03 45 0c             	add    0xc(%ebp),%eax
80100e76:	0f b6 00             	movzbl (%eax),%eax
80100e79:	0f be c0             	movsbl %al,%eax
80100e7c:	25 ff 00 00 00       	and    $0xff,%eax
80100e81:	89 04 24             	mov    %eax,(%esp)
80100e84:	e8 dc f8 ff ff       	call   80100765 <consputc>
{
  int i;

  iunlock(ip);
  acquire(&cons.lock);
  for(i = 0; i < n; i++)
80100e89:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80100e8d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100e90:	3b 45 10             	cmp    0x10(%ebp),%eax
80100e93:	7c db                	jl     80100e70 <consolewrite+0x26>
    consputc(buf[i] & 0xff);
  release(&cons.lock);
80100e95:	c7 04 24 e0 c8 10 80 	movl   $0x8010c8e0,(%esp)
80100e9c:	e8 c4 48 00 00       	call   80105765 <release>
  ilock(ip);
80100ea1:	8b 45 08             	mov    0x8(%ebp),%eax
80100ea4:	89 04 24             	mov    %eax,(%esp)
80100ea7:	e8 b4 0e 00 00       	call   80101d60 <ilock>

  return n;
80100eac:	8b 45 10             	mov    0x10(%ebp),%eax
}
80100eaf:	c9                   	leave  
80100eb0:	c3                   	ret    

80100eb1 <consoleinit>:

void
consoleinit(void)
{
80100eb1:	55                   	push   %ebp
80100eb2:	89 e5                	mov    %esp,%ebp
80100eb4:	83 ec 18             	sub    $0x18,%esp
  initlock(&cons.lock, "console");
80100eb7:	c7 44 24 04 93 8e 10 	movl   $0x80108e93,0x4(%esp)
80100ebe:	80 
80100ebf:	c7 04 24 e0 c8 10 80 	movl   $0x8010c8e0,(%esp)
80100ec6:	e8 17 48 00 00       	call   801056e2 <initlock>
  initlock(&input.lock, "input");
80100ecb:	c7 44 24 04 9b 8e 10 	movl   $0x80108e9b,0x4(%esp)
80100ed2:	80 
80100ed3:	c7 04 24 00 f6 10 80 	movl   $0x8010f600,(%esp)
80100eda:	e8 03 48 00 00       	call   801056e2 <initlock>

  devsw[CONSOLE].write = consolewrite;
80100edf:	c7 05 8c 0a 11 80 4a 	movl   $0x80100e4a,0x80110a8c
80100ee6:	0e 10 80 
  devsw[CONSOLE].read = consoleread;
80100ee9:	c7 05 88 0a 11 80 49 	movl   $0x80100d49,0x80110a88
80100ef0:	0d 10 80 
  cons.locking = 1;
80100ef3:	c7 05 14 c9 10 80 01 	movl   $0x1,0x8010c914
80100efa:	00 00 00 

  picenable(IRQ_KBD);
80100efd:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80100f04:	e8 b0 30 00 00       	call   80103fb9 <picenable>
  ioapicenable(IRQ_KBD, 0);
80100f09:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80100f10:	00 
80100f11:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80100f18:	e8 51 1f 00 00       	call   80102e6e <ioapicenable>
}
80100f1d:	c9                   	leave  
80100f1e:	c3                   	ret    
	...

80100f20 <exec>:
static char pathVariable[MAX_PATH_ENTRIES][INPUT_BUF]={};
static int place_to_add_path=0;

int
exec(char *path, char **argv)
{
80100f20:	55                   	push   %ebp
80100f21:	89 e5                	mov    %esp,%ebp
80100f23:	57                   	push   %edi
80100f24:	53                   	push   %ebx
80100f25:	81 ec 30 02 00 00    	sub    $0x230,%esp
  char *s, *last;
  char newPath[2*INPUT_BUF]={0};
80100f2b:	8d 9d d0 fe ff ff    	lea    -0x130(%ebp),%ebx
80100f31:	b8 00 00 00 00       	mov    $0x0,%eax
80100f36:	ba 40 00 00 00       	mov    $0x40,%edx
80100f3b:	89 df                	mov    %ebx,%edi
80100f3d:	89 d1                	mov    %edx,%ecx
80100f3f:	f3 ab                	rep stos %eax,%es:(%edi)
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;

  if((ip = namei(path)) == 0)
80100f41:	8b 45 08             	mov    0x8(%ebp),%eax
80100f44:	89 04 24             	mov    %eax,(%esp)
80100f47:	e8 b6 19 00 00       	call   80102902 <namei>
80100f4c:	89 45 d8             	mov    %eax,-0x28(%ebp)
80100f4f:	83 7d d8 00          	cmpl   $0x0,-0x28(%ebp)
80100f53:	75 64                	jne    80100fb9 <exec+0x99>
  {
    for( i=0;i<place_to_add_path;i++)
80100f55:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
80100f5c:	eb 3a                	jmp    80100f98 <exec+0x78>
    {
      
      if((ip = namei(newstrcat(newPath,pathVariable[i],path))) != 0){
80100f5e:	8b 45 ec             	mov    -0x14(%ebp),%eax
80100f61:	c1 e0 07             	shl    $0x7,%eax
80100f64:	8d 90 20 c9 10 80    	lea    -0x7fef36e0(%eax),%edx
80100f6a:	8b 45 08             	mov    0x8(%ebp),%eax
80100f6d:	89 44 24 08          	mov    %eax,0x8(%esp)
80100f71:	89 54 24 04          	mov    %edx,0x4(%esp)
80100f75:	8d 85 d0 fe ff ff    	lea    -0x130(%ebp),%eax
80100f7b:	89 04 24             	mov    %eax,(%esp)
80100f7e:	e8 72 4c 00 00       	call   80105bf5 <newstrcat>
80100f83:	89 04 24             	mov    %eax,(%esp)
80100f86:	e8 77 19 00 00       	call   80102902 <namei>
80100f8b:	89 45 d8             	mov    %eax,-0x28(%ebp)
80100f8e:	83 7d d8 00          	cmpl   $0x0,-0x28(%ebp)
80100f92:	75 10                	jne    80100fa4 <exec+0x84>
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;

  if((ip = namei(path)) == 0)
  {
    for( i=0;i<place_to_add_path;i++)
80100f94:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
80100f98:	a1 20 ce 10 80       	mov    0x8010ce20,%eax
80100f9d:	39 45 ec             	cmp    %eax,-0x14(%ebp)
80100fa0:	7c bc                	jl     80100f5e <exec+0x3e>
80100fa2:	eb 01                	jmp    80100fa5 <exec+0x85>
    {
      
      if((ip = namei(newstrcat(newPath,pathVariable[i],path))) != 0){
  	   break;
80100fa4:	90                   	nop
      }
    }
    if(i>=place_to_add_path)
80100fa5:	a1 20 ce 10 80       	mov    0x8010ce20,%eax
80100faa:	39 45 ec             	cmp    %eax,-0x14(%ebp)
80100fad:	7c 0a                	jl     80100fb9 <exec+0x99>
    return -1;
80100faf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100fb4:	e9 da 03 00 00       	jmp    80101393 <exec+0x473>
  }
  
  ilock(ip);
80100fb9:	8b 45 d8             	mov    -0x28(%ebp),%eax
80100fbc:	89 04 24             	mov    %eax,(%esp)
80100fbf:	e8 9c 0d 00 00       	call   80101d60 <ilock>
  pgdir = 0;
80100fc4:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) < sizeof(elf))
80100fcb:	c7 44 24 0c 34 00 00 	movl   $0x34,0xc(%esp)
80100fd2:	00 
80100fd3:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
80100fda:	00 
80100fdb:	8d 85 0c fe ff ff    	lea    -0x1f4(%ebp),%eax
80100fe1:	89 44 24 04          	mov    %eax,0x4(%esp)
80100fe5:	8b 45 d8             	mov    -0x28(%ebp),%eax
80100fe8:	89 04 24             	mov    %eax,(%esp)
80100feb:	e8 66 12 00 00       	call   80102256 <readi>
80100ff0:	83 f8 33             	cmp    $0x33,%eax
80100ff3:	0f 86 54 03 00 00    	jbe    8010134d <exec+0x42d>
    goto bad;
  if(elf.magic != ELF_MAGIC)
80100ff9:	8b 85 0c fe ff ff    	mov    -0x1f4(%ebp),%eax
80100fff:	3d 7f 45 4c 46       	cmp    $0x464c457f,%eax
80101004:	0f 85 46 03 00 00    	jne    80101350 <exec+0x430>
    goto bad;

  if((pgdir = setupkvm(kalloc)) == 0)
8010100a:	c7 04 24 f7 2f 10 80 	movl   $0x80102ff7,(%esp)
80101011:	e8 db 75 00 00       	call   801085f1 <setupkvm>
80101016:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80101019:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
8010101d:	0f 84 30 03 00 00    	je     80101353 <exec+0x433>
    goto bad;

  // Load program into memory.
  sz = 0;
80101023:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
8010102a:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
80101031:	8b 85 28 fe ff ff    	mov    -0x1d8(%ebp),%eax
80101037:	89 45 e8             	mov    %eax,-0x18(%ebp)
8010103a:	e9 c5 00 00 00       	jmp    80101104 <exec+0x1e4>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
8010103f:	8b 45 e8             	mov    -0x18(%ebp),%eax
80101042:	c7 44 24 0c 20 00 00 	movl   $0x20,0xc(%esp)
80101049:	00 
8010104a:	89 44 24 08          	mov    %eax,0x8(%esp)
8010104e:	8d 85 ec fd ff ff    	lea    -0x214(%ebp),%eax
80101054:	89 44 24 04          	mov    %eax,0x4(%esp)
80101058:	8b 45 d8             	mov    -0x28(%ebp),%eax
8010105b:	89 04 24             	mov    %eax,(%esp)
8010105e:	e8 f3 11 00 00       	call   80102256 <readi>
80101063:	83 f8 20             	cmp    $0x20,%eax
80101066:	0f 85 ea 02 00 00    	jne    80101356 <exec+0x436>
      goto bad;
    if(ph.type != ELF_PROG_LOAD)
8010106c:	8b 85 ec fd ff ff    	mov    -0x214(%ebp),%eax
80101072:	83 f8 01             	cmp    $0x1,%eax
80101075:	75 7f                	jne    801010f6 <exec+0x1d6>
      continue;
    if(ph.memsz < ph.filesz)
80101077:	8b 95 00 fe ff ff    	mov    -0x200(%ebp),%edx
8010107d:	8b 85 fc fd ff ff    	mov    -0x204(%ebp),%eax
80101083:	39 c2                	cmp    %eax,%edx
80101085:	0f 82 ce 02 00 00    	jb     80101359 <exec+0x439>
      goto bad;
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
8010108b:	8b 95 f4 fd ff ff    	mov    -0x20c(%ebp),%edx
80101091:	8b 85 00 fe ff ff    	mov    -0x200(%ebp),%eax
80101097:	01 d0                	add    %edx,%eax
80101099:	89 44 24 08          	mov    %eax,0x8(%esp)
8010109d:	8b 45 e0             	mov    -0x20(%ebp),%eax
801010a0:	89 44 24 04          	mov    %eax,0x4(%esp)
801010a4:	8b 45 d4             	mov    -0x2c(%ebp),%eax
801010a7:	89 04 24             	mov    %eax,(%esp)
801010aa:	e8 14 79 00 00       	call   801089c3 <allocuvm>
801010af:	89 45 e0             	mov    %eax,-0x20(%ebp)
801010b2:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
801010b6:	0f 84 a0 02 00 00    	je     8010135c <exec+0x43c>
      goto bad;
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
801010bc:	8b 8d fc fd ff ff    	mov    -0x204(%ebp),%ecx
801010c2:	8b 95 f0 fd ff ff    	mov    -0x210(%ebp),%edx
801010c8:	8b 85 f4 fd ff ff    	mov    -0x20c(%ebp),%eax
801010ce:	89 4c 24 10          	mov    %ecx,0x10(%esp)
801010d2:	89 54 24 0c          	mov    %edx,0xc(%esp)
801010d6:	8b 55 d8             	mov    -0x28(%ebp),%edx
801010d9:	89 54 24 08          	mov    %edx,0x8(%esp)
801010dd:	89 44 24 04          	mov    %eax,0x4(%esp)
801010e1:	8b 45 d4             	mov    -0x2c(%ebp),%eax
801010e4:	89 04 24             	mov    %eax,(%esp)
801010e7:	e8 e8 77 00 00       	call   801088d4 <loaduvm>
801010ec:	85 c0                	test   %eax,%eax
801010ee:	0f 88 6b 02 00 00    	js     8010135f <exec+0x43f>
801010f4:	eb 01                	jmp    801010f7 <exec+0x1d7>
  sz = 0;
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
      goto bad;
    if(ph.type != ELF_PROG_LOAD)
      continue;
801010f6:	90                   	nop
  if((pgdir = setupkvm(kalloc)) == 0)
    goto bad;

  // Load program into memory.
  sz = 0;
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
801010f7:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
801010fb:	8b 45 e8             	mov    -0x18(%ebp),%eax
801010fe:	83 c0 20             	add    $0x20,%eax
80101101:	89 45 e8             	mov    %eax,-0x18(%ebp)
80101104:	0f b7 85 38 fe ff ff 	movzwl -0x1c8(%ebp),%eax
8010110b:	0f b7 c0             	movzwl %ax,%eax
8010110e:	3b 45 ec             	cmp    -0x14(%ebp),%eax
80101111:	0f 8f 28 ff ff ff    	jg     8010103f <exec+0x11f>
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
      goto bad;
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
      goto bad;
  }
  iunlockput(ip);
80101117:	8b 45 d8             	mov    -0x28(%ebp),%eax
8010111a:	89 04 24             	mov    %eax,(%esp)
8010111d:	e8 c2 0e 00 00       	call   80101fe4 <iunlockput>
  ip = 0;
80101122:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)

  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
80101129:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010112c:	05 ff 0f 00 00       	add    $0xfff,%eax
80101131:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80101136:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80101139:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010113c:	05 00 20 00 00       	add    $0x2000,%eax
80101141:	89 44 24 08          	mov    %eax,0x8(%esp)
80101145:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101148:	89 44 24 04          	mov    %eax,0x4(%esp)
8010114c:	8b 45 d4             	mov    -0x2c(%ebp),%eax
8010114f:	89 04 24             	mov    %eax,(%esp)
80101152:	e8 6c 78 00 00       	call   801089c3 <allocuvm>
80101157:	89 45 e0             	mov    %eax,-0x20(%ebp)
8010115a:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
8010115e:	0f 84 fe 01 00 00    	je     80101362 <exec+0x442>
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80101164:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101167:	2d 00 20 00 00       	sub    $0x2000,%eax
8010116c:	89 44 24 04          	mov    %eax,0x4(%esp)
80101170:	8b 45 d4             	mov    -0x2c(%ebp),%eax
80101173:	89 04 24             	mov    %eax,(%esp)
80101176:	e8 6c 7a 00 00       	call   80108be7 <clearpteu>
  sp = sz;
8010117b:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010117e:	89 45 dc             	mov    %eax,-0x24(%ebp)

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80101181:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80101188:	e9 81 00 00 00       	jmp    8010120e <exec+0x2ee>
    if(argc >= MAXARG)
8010118d:	83 7d e4 1f          	cmpl   $0x1f,-0x1c(%ebp)
80101191:	0f 87 ce 01 00 00    	ja     80101365 <exec+0x445>
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80101197:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010119a:	c1 e0 02             	shl    $0x2,%eax
8010119d:	03 45 0c             	add    0xc(%ebp),%eax
801011a0:	8b 00                	mov    (%eax),%eax
801011a2:	89 04 24             	mov    %eax,(%esp)
801011a5:	e8 26 4a 00 00       	call   80105bd0 <strlen>
801011aa:	f7 d0                	not    %eax
801011ac:	03 45 dc             	add    -0x24(%ebp),%eax
801011af:	83 e0 fc             	and    $0xfffffffc,%eax
801011b2:	89 45 dc             	mov    %eax,-0x24(%ebp)
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
801011b5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801011b8:	c1 e0 02             	shl    $0x2,%eax
801011bb:	03 45 0c             	add    0xc(%ebp),%eax
801011be:	8b 00                	mov    (%eax),%eax
801011c0:	89 04 24             	mov    %eax,(%esp)
801011c3:	e8 08 4a 00 00       	call   80105bd0 <strlen>
801011c8:	83 c0 01             	add    $0x1,%eax
801011cb:	89 c2                	mov    %eax,%edx
801011cd:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801011d0:	c1 e0 02             	shl    $0x2,%eax
801011d3:	03 45 0c             	add    0xc(%ebp),%eax
801011d6:	8b 00                	mov    (%eax),%eax
801011d8:	89 54 24 0c          	mov    %edx,0xc(%esp)
801011dc:	89 44 24 08          	mov    %eax,0x8(%esp)
801011e0:	8b 45 dc             	mov    -0x24(%ebp),%eax
801011e3:	89 44 24 04          	mov    %eax,0x4(%esp)
801011e7:	8b 45 d4             	mov    -0x2c(%ebp),%eax
801011ea:	89 04 24             	mov    %eax,(%esp)
801011ed:	e8 a9 7b 00 00       	call   80108d9b <copyout>
801011f2:	85 c0                	test   %eax,%eax
801011f4:	0f 88 6e 01 00 00    	js     80101368 <exec+0x448>
      goto bad;
    ustack[3+argc] = sp;
801011fa:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801011fd:	8d 50 03             	lea    0x3(%eax),%edx
80101200:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101203:	89 84 95 40 fe ff ff 	mov    %eax,-0x1c0(%ebp,%edx,4)
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
8010120a:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
8010120e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101211:	c1 e0 02             	shl    $0x2,%eax
80101214:	03 45 0c             	add    0xc(%ebp),%eax
80101217:	8b 00                	mov    (%eax),%eax
80101219:	85 c0                	test   %eax,%eax
8010121b:	0f 85 6c ff ff ff    	jne    8010118d <exec+0x26d>
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
      goto bad;
    ustack[3+argc] = sp;
  }
  ustack[3+argc] = 0;
80101221:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101224:	83 c0 03             	add    $0x3,%eax
80101227:	c7 84 85 40 fe ff ff 	movl   $0x0,-0x1c0(%ebp,%eax,4)
8010122e:	00 00 00 00 

  ustack[0] = 0xffffffff;  // fake return PC
80101232:	c7 85 40 fe ff ff ff 	movl   $0xffffffff,-0x1c0(%ebp)
80101239:	ff ff ff 
  ustack[1] = argc;
8010123c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010123f:	89 85 44 fe ff ff    	mov    %eax,-0x1bc(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80101245:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101248:	83 c0 01             	add    $0x1,%eax
8010124b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80101252:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101255:	29 d0                	sub    %edx,%eax
80101257:	89 85 48 fe ff ff    	mov    %eax,-0x1b8(%ebp)

  sp -= (3+argc+1) * 4;
8010125d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101260:	83 c0 04             	add    $0x4,%eax
80101263:	c1 e0 02             	shl    $0x2,%eax
80101266:	29 45 dc             	sub    %eax,-0x24(%ebp)
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80101269:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010126c:	83 c0 04             	add    $0x4,%eax
8010126f:	c1 e0 02             	shl    $0x2,%eax
80101272:	89 44 24 0c          	mov    %eax,0xc(%esp)
80101276:	8d 85 40 fe ff ff    	lea    -0x1c0(%ebp),%eax
8010127c:	89 44 24 08          	mov    %eax,0x8(%esp)
80101280:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101283:	89 44 24 04          	mov    %eax,0x4(%esp)
80101287:	8b 45 d4             	mov    -0x2c(%ebp),%eax
8010128a:	89 04 24             	mov    %eax,(%esp)
8010128d:	e8 09 7b 00 00       	call   80108d9b <copyout>
80101292:	85 c0                	test   %eax,%eax
80101294:	0f 88 d1 00 00 00    	js     8010136b <exec+0x44b>
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
8010129a:	8b 45 08             	mov    0x8(%ebp),%eax
8010129d:	89 45 f4             	mov    %eax,-0xc(%ebp)
801012a0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801012a3:	89 45 f0             	mov    %eax,-0x10(%ebp)
801012a6:	eb 17                	jmp    801012bf <exec+0x39f>
    if(*s == '/')
801012a8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801012ab:	0f b6 00             	movzbl (%eax),%eax
801012ae:	3c 2f                	cmp    $0x2f,%al
801012b0:	75 09                	jne    801012bb <exec+0x39b>
      last = s+1;
801012b2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801012b5:	83 c0 01             	add    $0x1,%eax
801012b8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  sp -= (3+argc+1) * 4;
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
801012bb:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801012bf:	8b 45 f4             	mov    -0xc(%ebp),%eax
801012c2:	0f b6 00             	movzbl (%eax),%eax
801012c5:	84 c0                	test   %al,%al
801012c7:	75 df                	jne    801012a8 <exec+0x388>
    if(*s == '/')
      last = s+1;
  safestrcpy(proc->name, last, sizeof(proc->name));
801012c9:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801012cf:	8d 50 6c             	lea    0x6c(%eax),%edx
801012d2:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
801012d9:	00 
801012da:	8b 45 f0             	mov    -0x10(%ebp),%eax
801012dd:	89 44 24 04          	mov    %eax,0x4(%esp)
801012e1:	89 14 24             	mov    %edx,(%esp)
801012e4:	e8 99 48 00 00       	call   80105b82 <safestrcpy>

  // Commit to the user image.
  oldpgdir = proc->pgdir;
801012e9:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801012ef:	8b 40 04             	mov    0x4(%eax),%eax
801012f2:	89 45 d0             	mov    %eax,-0x30(%ebp)
  proc->pgdir = pgdir;
801012f5:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801012fb:	8b 55 d4             	mov    -0x2c(%ebp),%edx
801012fe:	89 50 04             	mov    %edx,0x4(%eax)
  proc->sz = sz;
80101301:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80101307:	8b 55 e0             	mov    -0x20(%ebp),%edx
8010130a:	89 10                	mov    %edx,(%eax)
  proc->tf->eip = elf.entry;  // main
8010130c:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80101312:	8b 40 18             	mov    0x18(%eax),%eax
80101315:	8b 95 24 fe ff ff    	mov    -0x1dc(%ebp),%edx
8010131b:	89 50 38             	mov    %edx,0x38(%eax)
  proc->tf->esp = sp;
8010131e:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80101324:	8b 40 18             	mov    0x18(%eax),%eax
80101327:	8b 55 dc             	mov    -0x24(%ebp),%edx
8010132a:	89 50 44             	mov    %edx,0x44(%eax)
  switchuvm(proc);
8010132d:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80101333:	89 04 24             	mov    %eax,(%esp)
80101336:	e8 a7 73 00 00       	call   801086e2 <switchuvm>
  freevm(oldpgdir);
8010133b:	8b 45 d0             	mov    -0x30(%ebp),%eax
8010133e:	89 04 24             	mov    %eax,(%esp)
80101341:	e8 13 78 00 00       	call   80108b59 <freevm>
  return 0;
80101346:	b8 00 00 00 00       	mov    $0x0,%eax
8010134b:	eb 46                	jmp    80101393 <exec+0x473>
  ilock(ip);
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) < sizeof(elf))
    goto bad;
8010134d:	90                   	nop
8010134e:	eb 1c                	jmp    8010136c <exec+0x44c>
  if(elf.magic != ELF_MAGIC)
    goto bad;
80101350:	90                   	nop
80101351:	eb 19                	jmp    8010136c <exec+0x44c>

  if((pgdir = setupkvm(kalloc)) == 0)
    goto bad;
80101353:	90                   	nop
80101354:	eb 16                	jmp    8010136c <exec+0x44c>

  // Load program into memory.
  sz = 0;
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
      goto bad;
80101356:	90                   	nop
80101357:	eb 13                	jmp    8010136c <exec+0x44c>
    if(ph.type != ELF_PROG_LOAD)
      continue;
    if(ph.memsz < ph.filesz)
      goto bad;
80101359:	90                   	nop
8010135a:	eb 10                	jmp    8010136c <exec+0x44c>
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
      goto bad;
8010135c:	90                   	nop
8010135d:	eb 0d                	jmp    8010136c <exec+0x44c>
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
      goto bad;
8010135f:	90                   	nop
80101360:	eb 0a                	jmp    8010136c <exec+0x44c>

  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
    goto bad;
80101362:	90                   	nop
80101363:	eb 07                	jmp    8010136c <exec+0x44c>
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
    if(argc >= MAXARG)
      goto bad;
80101365:	90                   	nop
80101366:	eb 04                	jmp    8010136c <exec+0x44c>
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
      goto bad;
80101368:	90                   	nop
80101369:	eb 01                	jmp    8010136c <exec+0x44c>
  ustack[1] = argc;
  ustack[2] = sp - (argc+1)*4;  // argv pointer

  sp -= (3+argc+1) * 4;
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
    goto bad;
8010136b:	90                   	nop
  switchuvm(proc);
  freevm(oldpgdir);
  return 0;

 bad:
  if(pgdir)
8010136c:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
80101370:	74 0b                	je     8010137d <exec+0x45d>
    freevm(pgdir);
80101372:	8b 45 d4             	mov    -0x2c(%ebp),%eax
80101375:	89 04 24             	mov    %eax,(%esp)
80101378:	e8 dc 77 00 00       	call   80108b59 <freevm>
  if(ip)
8010137d:	83 7d d8 00          	cmpl   $0x0,-0x28(%ebp)
80101381:	74 0b                	je     8010138e <exec+0x46e>
    iunlockput(ip);
80101383:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101386:	89 04 24             	mov    %eax,(%esp)
80101389:	e8 56 0c 00 00       	call   80101fe4 <iunlockput>
  return -1;
8010138e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80101393:	81 c4 30 02 00 00    	add    $0x230,%esp
80101399:	5b                   	pop    %ebx
8010139a:	5f                   	pop    %edi
8010139b:	5d                   	pop    %ebp
8010139c:	c3                   	ret    

8010139d <definition_add_path>:

int
definition_add_path(char *path){
8010139d:	55                   	push   %ebp
8010139e:	89 e5                	mov    %esp,%ebp
801013a0:	83 ec 18             	sub    $0x18,%esp
  if(place_to_add_path>MAX_PATH_ENTRIES){
801013a3:	a1 20 ce 10 80       	mov    0x8010ce20,%eax
801013a8:	83 f8 0a             	cmp    $0xa,%eax
801013ab:	7e 07                	jle    801013b4 <definition_add_path+0x17>
      return -1;
801013ad:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801013b2:	eb 42                	jmp    801013f6 <definition_add_path+0x59>
  }
  safestrcpy(pathVariable[place_to_add_path],path,strlen(path)+1);
801013b4:	8b 45 08             	mov    0x8(%ebp),%eax
801013b7:	89 04 24             	mov    %eax,(%esp)
801013ba:	e8 11 48 00 00       	call   80105bd0 <strlen>
801013bf:	83 c0 01             	add    $0x1,%eax
801013c2:	8b 15 20 ce 10 80    	mov    0x8010ce20,%edx
801013c8:	c1 e2 07             	shl    $0x7,%edx
801013cb:	81 c2 20 c9 10 80    	add    $0x8010c920,%edx
801013d1:	89 44 24 08          	mov    %eax,0x8(%esp)
801013d5:	8b 45 08             	mov    0x8(%ebp),%eax
801013d8:	89 44 24 04          	mov    %eax,0x4(%esp)
801013dc:	89 14 24             	mov    %edx,(%esp)
801013df:	e8 9e 47 00 00       	call   80105b82 <safestrcpy>
  place_to_add_path++;
801013e4:	a1 20 ce 10 80       	mov    0x8010ce20,%eax
801013e9:	83 c0 01             	add    $0x1,%eax
801013ec:	a3 20 ce 10 80       	mov    %eax,0x8010ce20
  return 0;
801013f1:	b8 00 00 00 00       	mov    $0x0,%eax
801013f6:	c9                   	leave  
801013f7:	c3                   	ret    

801013f8 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
801013f8:	55                   	push   %ebp
801013f9:	89 e5                	mov    %esp,%ebp
801013fb:	83 ec 18             	sub    $0x18,%esp
  initlock(&ftable.lock, "ftable");
801013fe:	c7 44 24 04 a1 8e 10 	movl   $0x80108ea1,0x4(%esp)
80101405:	80 
80101406:	c7 04 24 e0 00 11 80 	movl   $0x801100e0,(%esp)
8010140d:	e8 d0 42 00 00       	call   801056e2 <initlock>
}
80101412:	c9                   	leave  
80101413:	c3                   	ret    

80101414 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80101414:	55                   	push   %ebp
80101415:	89 e5                	mov    %esp,%ebp
80101417:	83 ec 28             	sub    $0x28,%esp
  struct file *f;

  acquire(&ftable.lock);
8010141a:	c7 04 24 e0 00 11 80 	movl   $0x801100e0,(%esp)
80101421:	e8 dd 42 00 00       	call   80105703 <acquire>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80101426:	c7 45 f4 14 01 11 80 	movl   $0x80110114,-0xc(%ebp)
8010142d:	eb 29                	jmp    80101458 <filealloc+0x44>
    if(f->ref == 0){
8010142f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101432:	8b 40 04             	mov    0x4(%eax),%eax
80101435:	85 c0                	test   %eax,%eax
80101437:	75 1b                	jne    80101454 <filealloc+0x40>
      f->ref = 1;
80101439:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010143c:	c7 40 04 01 00 00 00 	movl   $0x1,0x4(%eax)
      release(&ftable.lock);
80101443:	c7 04 24 e0 00 11 80 	movl   $0x801100e0,(%esp)
8010144a:	e8 16 43 00 00       	call   80105765 <release>
      return f;
8010144f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101452:	eb 1e                	jmp    80101472 <filealloc+0x5e>
filealloc(void)
{
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80101454:	83 45 f4 18          	addl   $0x18,-0xc(%ebp)
80101458:	81 7d f4 74 0a 11 80 	cmpl   $0x80110a74,-0xc(%ebp)
8010145f:	72 ce                	jb     8010142f <filealloc+0x1b>
      f->ref = 1;
      release(&ftable.lock);
      return f;
    }
  }
  release(&ftable.lock);
80101461:	c7 04 24 e0 00 11 80 	movl   $0x801100e0,(%esp)
80101468:	e8 f8 42 00 00       	call   80105765 <release>
  return 0;
8010146d:	b8 00 00 00 00       	mov    $0x0,%eax
}
80101472:	c9                   	leave  
80101473:	c3                   	ret    

80101474 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80101474:	55                   	push   %ebp
80101475:	89 e5                	mov    %esp,%ebp
80101477:	83 ec 18             	sub    $0x18,%esp
  acquire(&ftable.lock);
8010147a:	c7 04 24 e0 00 11 80 	movl   $0x801100e0,(%esp)
80101481:	e8 7d 42 00 00       	call   80105703 <acquire>
  if(f->ref < 1)
80101486:	8b 45 08             	mov    0x8(%ebp),%eax
80101489:	8b 40 04             	mov    0x4(%eax),%eax
8010148c:	85 c0                	test   %eax,%eax
8010148e:	7f 0c                	jg     8010149c <filedup+0x28>
    panic("filedup");
80101490:	c7 04 24 a8 8e 10 80 	movl   $0x80108ea8,(%esp)
80101497:	e8 a1 f0 ff ff       	call   8010053d <panic>
  f->ref++;
8010149c:	8b 45 08             	mov    0x8(%ebp),%eax
8010149f:	8b 40 04             	mov    0x4(%eax),%eax
801014a2:	8d 50 01             	lea    0x1(%eax),%edx
801014a5:	8b 45 08             	mov    0x8(%ebp),%eax
801014a8:	89 50 04             	mov    %edx,0x4(%eax)
  release(&ftable.lock);
801014ab:	c7 04 24 e0 00 11 80 	movl   $0x801100e0,(%esp)
801014b2:	e8 ae 42 00 00       	call   80105765 <release>
  return f;
801014b7:	8b 45 08             	mov    0x8(%ebp),%eax
}
801014ba:	c9                   	leave  
801014bb:	c3                   	ret    

801014bc <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
801014bc:	55                   	push   %ebp
801014bd:	89 e5                	mov    %esp,%ebp
801014bf:	83 ec 38             	sub    $0x38,%esp
  struct file ff;

  acquire(&ftable.lock);
801014c2:	c7 04 24 e0 00 11 80 	movl   $0x801100e0,(%esp)
801014c9:	e8 35 42 00 00       	call   80105703 <acquire>
  if(f->ref < 1)
801014ce:	8b 45 08             	mov    0x8(%ebp),%eax
801014d1:	8b 40 04             	mov    0x4(%eax),%eax
801014d4:	85 c0                	test   %eax,%eax
801014d6:	7f 0c                	jg     801014e4 <fileclose+0x28>
    panic("fileclose");
801014d8:	c7 04 24 b0 8e 10 80 	movl   $0x80108eb0,(%esp)
801014df:	e8 59 f0 ff ff       	call   8010053d <panic>
  if(--f->ref > 0){
801014e4:	8b 45 08             	mov    0x8(%ebp),%eax
801014e7:	8b 40 04             	mov    0x4(%eax),%eax
801014ea:	8d 50 ff             	lea    -0x1(%eax),%edx
801014ed:	8b 45 08             	mov    0x8(%ebp),%eax
801014f0:	89 50 04             	mov    %edx,0x4(%eax)
801014f3:	8b 45 08             	mov    0x8(%ebp),%eax
801014f6:	8b 40 04             	mov    0x4(%eax),%eax
801014f9:	85 c0                	test   %eax,%eax
801014fb:	7e 11                	jle    8010150e <fileclose+0x52>
    release(&ftable.lock);
801014fd:	c7 04 24 e0 00 11 80 	movl   $0x801100e0,(%esp)
80101504:	e8 5c 42 00 00       	call   80105765 <release>
    return;
80101509:	e9 82 00 00 00       	jmp    80101590 <fileclose+0xd4>
  }
  ff = *f;
8010150e:	8b 45 08             	mov    0x8(%ebp),%eax
80101511:	8b 10                	mov    (%eax),%edx
80101513:	89 55 e0             	mov    %edx,-0x20(%ebp)
80101516:	8b 50 04             	mov    0x4(%eax),%edx
80101519:	89 55 e4             	mov    %edx,-0x1c(%ebp)
8010151c:	8b 50 08             	mov    0x8(%eax),%edx
8010151f:	89 55 e8             	mov    %edx,-0x18(%ebp)
80101522:	8b 50 0c             	mov    0xc(%eax),%edx
80101525:	89 55 ec             	mov    %edx,-0x14(%ebp)
80101528:	8b 50 10             	mov    0x10(%eax),%edx
8010152b:	89 55 f0             	mov    %edx,-0x10(%ebp)
8010152e:	8b 40 14             	mov    0x14(%eax),%eax
80101531:	89 45 f4             	mov    %eax,-0xc(%ebp)
  f->ref = 0;
80101534:	8b 45 08             	mov    0x8(%ebp),%eax
80101537:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
  f->type = FD_NONE;
8010153e:	8b 45 08             	mov    0x8(%ebp),%eax
80101541:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  release(&ftable.lock);
80101547:	c7 04 24 e0 00 11 80 	movl   $0x801100e0,(%esp)
8010154e:	e8 12 42 00 00       	call   80105765 <release>
  
  if(ff.type == FD_PIPE)
80101553:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101556:	83 f8 01             	cmp    $0x1,%eax
80101559:	75 18                	jne    80101573 <fileclose+0xb7>
    pipeclose(ff.pipe, ff.writable);
8010155b:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
8010155f:	0f be d0             	movsbl %al,%edx
80101562:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101565:	89 54 24 04          	mov    %edx,0x4(%esp)
80101569:	89 04 24             	mov    %eax,(%esp)
8010156c:	e8 02 2d 00 00       	call   80104273 <pipeclose>
80101571:	eb 1d                	jmp    80101590 <fileclose+0xd4>
  else if(ff.type == FD_INODE){
80101573:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101576:	83 f8 02             	cmp    $0x2,%eax
80101579:	75 15                	jne    80101590 <fileclose+0xd4>
    begin_trans();
8010157b:	e8 95 21 00 00       	call   80103715 <begin_trans>
    iput(ff.ip);
80101580:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101583:	89 04 24             	mov    %eax,(%esp)
80101586:	e8 88 09 00 00       	call   80101f13 <iput>
    commit_trans();
8010158b:	e8 ce 21 00 00       	call   8010375e <commit_trans>
  }
}
80101590:	c9                   	leave  
80101591:	c3                   	ret    

80101592 <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
80101592:	55                   	push   %ebp
80101593:	89 e5                	mov    %esp,%ebp
80101595:	83 ec 18             	sub    $0x18,%esp
  if(f->type == FD_INODE){
80101598:	8b 45 08             	mov    0x8(%ebp),%eax
8010159b:	8b 00                	mov    (%eax),%eax
8010159d:	83 f8 02             	cmp    $0x2,%eax
801015a0:	75 38                	jne    801015da <filestat+0x48>
    ilock(f->ip);
801015a2:	8b 45 08             	mov    0x8(%ebp),%eax
801015a5:	8b 40 10             	mov    0x10(%eax),%eax
801015a8:	89 04 24             	mov    %eax,(%esp)
801015ab:	e8 b0 07 00 00       	call   80101d60 <ilock>
    stati(f->ip, st);
801015b0:	8b 45 08             	mov    0x8(%ebp),%eax
801015b3:	8b 40 10             	mov    0x10(%eax),%eax
801015b6:	8b 55 0c             	mov    0xc(%ebp),%edx
801015b9:	89 54 24 04          	mov    %edx,0x4(%esp)
801015bd:	89 04 24             	mov    %eax,(%esp)
801015c0:	e8 4c 0c 00 00       	call   80102211 <stati>
    iunlock(f->ip);
801015c5:	8b 45 08             	mov    0x8(%ebp),%eax
801015c8:	8b 40 10             	mov    0x10(%eax),%eax
801015cb:	89 04 24             	mov    %eax,(%esp)
801015ce:	e8 db 08 00 00       	call   80101eae <iunlock>
    return 0;
801015d3:	b8 00 00 00 00       	mov    $0x0,%eax
801015d8:	eb 05                	jmp    801015df <filestat+0x4d>
  }
  return -1;
801015da:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801015df:	c9                   	leave  
801015e0:	c3                   	ret    

801015e1 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
801015e1:	55                   	push   %ebp
801015e2:	89 e5                	mov    %esp,%ebp
801015e4:	83 ec 28             	sub    $0x28,%esp
  int r;

  if(f->readable == 0)
801015e7:	8b 45 08             	mov    0x8(%ebp),%eax
801015ea:	0f b6 40 08          	movzbl 0x8(%eax),%eax
801015ee:	84 c0                	test   %al,%al
801015f0:	75 0a                	jne    801015fc <fileread+0x1b>
    return -1;
801015f2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801015f7:	e9 9f 00 00 00       	jmp    8010169b <fileread+0xba>
  if(f->type == FD_PIPE)
801015fc:	8b 45 08             	mov    0x8(%ebp),%eax
801015ff:	8b 00                	mov    (%eax),%eax
80101601:	83 f8 01             	cmp    $0x1,%eax
80101604:	75 1e                	jne    80101624 <fileread+0x43>
    return piperead(f->pipe, addr, n);
80101606:	8b 45 08             	mov    0x8(%ebp),%eax
80101609:	8b 40 0c             	mov    0xc(%eax),%eax
8010160c:	8b 55 10             	mov    0x10(%ebp),%edx
8010160f:	89 54 24 08          	mov    %edx,0x8(%esp)
80101613:	8b 55 0c             	mov    0xc(%ebp),%edx
80101616:	89 54 24 04          	mov    %edx,0x4(%esp)
8010161a:	89 04 24             	mov    %eax,(%esp)
8010161d:	e8 d3 2d 00 00       	call   801043f5 <piperead>
80101622:	eb 77                	jmp    8010169b <fileread+0xba>
  if(f->type == FD_INODE){
80101624:	8b 45 08             	mov    0x8(%ebp),%eax
80101627:	8b 00                	mov    (%eax),%eax
80101629:	83 f8 02             	cmp    $0x2,%eax
8010162c:	75 61                	jne    8010168f <fileread+0xae>
    ilock(f->ip);
8010162e:	8b 45 08             	mov    0x8(%ebp),%eax
80101631:	8b 40 10             	mov    0x10(%eax),%eax
80101634:	89 04 24             	mov    %eax,(%esp)
80101637:	e8 24 07 00 00       	call   80101d60 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
8010163c:	8b 4d 10             	mov    0x10(%ebp),%ecx
8010163f:	8b 45 08             	mov    0x8(%ebp),%eax
80101642:	8b 50 14             	mov    0x14(%eax),%edx
80101645:	8b 45 08             	mov    0x8(%ebp),%eax
80101648:	8b 40 10             	mov    0x10(%eax),%eax
8010164b:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
8010164f:	89 54 24 08          	mov    %edx,0x8(%esp)
80101653:	8b 55 0c             	mov    0xc(%ebp),%edx
80101656:	89 54 24 04          	mov    %edx,0x4(%esp)
8010165a:	89 04 24             	mov    %eax,(%esp)
8010165d:	e8 f4 0b 00 00       	call   80102256 <readi>
80101662:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101665:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80101669:	7e 11                	jle    8010167c <fileread+0x9b>
      f->off += r;
8010166b:	8b 45 08             	mov    0x8(%ebp),%eax
8010166e:	8b 50 14             	mov    0x14(%eax),%edx
80101671:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101674:	01 c2                	add    %eax,%edx
80101676:	8b 45 08             	mov    0x8(%ebp),%eax
80101679:	89 50 14             	mov    %edx,0x14(%eax)
    iunlock(f->ip);
8010167c:	8b 45 08             	mov    0x8(%ebp),%eax
8010167f:	8b 40 10             	mov    0x10(%eax),%eax
80101682:	89 04 24             	mov    %eax,(%esp)
80101685:	e8 24 08 00 00       	call   80101eae <iunlock>
    return r;
8010168a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010168d:	eb 0c                	jmp    8010169b <fileread+0xba>
  }
  panic("fileread");
8010168f:	c7 04 24 ba 8e 10 80 	movl   $0x80108eba,(%esp)
80101696:	e8 a2 ee ff ff       	call   8010053d <panic>
}
8010169b:	c9                   	leave  
8010169c:	c3                   	ret    

8010169d <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
8010169d:	55                   	push   %ebp
8010169e:	89 e5                	mov    %esp,%ebp
801016a0:	53                   	push   %ebx
801016a1:	83 ec 24             	sub    $0x24,%esp
  int r;

  if(f->writable == 0)
801016a4:	8b 45 08             	mov    0x8(%ebp),%eax
801016a7:	0f b6 40 09          	movzbl 0x9(%eax),%eax
801016ab:	84 c0                	test   %al,%al
801016ad:	75 0a                	jne    801016b9 <filewrite+0x1c>
    return -1;
801016af:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801016b4:	e9 23 01 00 00       	jmp    801017dc <filewrite+0x13f>
  if(f->type == FD_PIPE)
801016b9:	8b 45 08             	mov    0x8(%ebp),%eax
801016bc:	8b 00                	mov    (%eax),%eax
801016be:	83 f8 01             	cmp    $0x1,%eax
801016c1:	75 21                	jne    801016e4 <filewrite+0x47>
    return pipewrite(f->pipe, addr, n);
801016c3:	8b 45 08             	mov    0x8(%ebp),%eax
801016c6:	8b 40 0c             	mov    0xc(%eax),%eax
801016c9:	8b 55 10             	mov    0x10(%ebp),%edx
801016cc:	89 54 24 08          	mov    %edx,0x8(%esp)
801016d0:	8b 55 0c             	mov    0xc(%ebp),%edx
801016d3:	89 54 24 04          	mov    %edx,0x4(%esp)
801016d7:	89 04 24             	mov    %eax,(%esp)
801016da:	e8 26 2c 00 00       	call   80104305 <pipewrite>
801016df:	e9 f8 00 00 00       	jmp    801017dc <filewrite+0x13f>
  if(f->type == FD_INODE){
801016e4:	8b 45 08             	mov    0x8(%ebp),%eax
801016e7:	8b 00                	mov    (%eax),%eax
801016e9:	83 f8 02             	cmp    $0x2,%eax
801016ec:	0f 85 de 00 00 00    	jne    801017d0 <filewrite+0x133>
    // the maximum log transaction size, including
    // i-node, indirect block, allocation blocks,
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((LOGSIZE-1-1-2) / 2) * 512;
801016f2:	c7 45 ec 00 06 00 00 	movl   $0x600,-0x14(%ebp)
    int i = 0;
801016f9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    while(i < n){
80101700:	e9 a8 00 00 00       	jmp    801017ad <filewrite+0x110>
      int n1 = n - i;
80101705:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101708:	8b 55 10             	mov    0x10(%ebp),%edx
8010170b:	89 d1                	mov    %edx,%ecx
8010170d:	29 c1                	sub    %eax,%ecx
8010170f:	89 c8                	mov    %ecx,%eax
80101711:	89 45 f0             	mov    %eax,-0x10(%ebp)
      if(n1 > max)
80101714:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101717:	3b 45 ec             	cmp    -0x14(%ebp),%eax
8010171a:	7e 06                	jle    80101722 <filewrite+0x85>
        n1 = max;
8010171c:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010171f:	89 45 f0             	mov    %eax,-0x10(%ebp)

      begin_trans();
80101722:	e8 ee 1f 00 00       	call   80103715 <begin_trans>
      ilock(f->ip);
80101727:	8b 45 08             	mov    0x8(%ebp),%eax
8010172a:	8b 40 10             	mov    0x10(%eax),%eax
8010172d:	89 04 24             	mov    %eax,(%esp)
80101730:	e8 2b 06 00 00       	call   80101d60 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
80101735:	8b 5d f0             	mov    -0x10(%ebp),%ebx
80101738:	8b 45 08             	mov    0x8(%ebp),%eax
8010173b:	8b 48 14             	mov    0x14(%eax),%ecx
8010173e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101741:	89 c2                	mov    %eax,%edx
80101743:	03 55 0c             	add    0xc(%ebp),%edx
80101746:	8b 45 08             	mov    0x8(%ebp),%eax
80101749:	8b 40 10             	mov    0x10(%eax),%eax
8010174c:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
80101750:	89 4c 24 08          	mov    %ecx,0x8(%esp)
80101754:	89 54 24 04          	mov    %edx,0x4(%esp)
80101758:	89 04 24             	mov    %eax,(%esp)
8010175b:	e8 61 0c 00 00       	call   801023c1 <writei>
80101760:	89 45 e8             	mov    %eax,-0x18(%ebp)
80101763:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
80101767:	7e 11                	jle    8010177a <filewrite+0xdd>
        f->off += r;
80101769:	8b 45 08             	mov    0x8(%ebp),%eax
8010176c:	8b 50 14             	mov    0x14(%eax),%edx
8010176f:	8b 45 e8             	mov    -0x18(%ebp),%eax
80101772:	01 c2                	add    %eax,%edx
80101774:	8b 45 08             	mov    0x8(%ebp),%eax
80101777:	89 50 14             	mov    %edx,0x14(%eax)
      iunlock(f->ip);
8010177a:	8b 45 08             	mov    0x8(%ebp),%eax
8010177d:	8b 40 10             	mov    0x10(%eax),%eax
80101780:	89 04 24             	mov    %eax,(%esp)
80101783:	e8 26 07 00 00       	call   80101eae <iunlock>
      commit_trans();
80101788:	e8 d1 1f 00 00       	call   8010375e <commit_trans>

      if(r < 0)
8010178d:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
80101791:	78 28                	js     801017bb <filewrite+0x11e>
        break;
      if(r != n1)
80101793:	8b 45 e8             	mov    -0x18(%ebp),%eax
80101796:	3b 45 f0             	cmp    -0x10(%ebp),%eax
80101799:	74 0c                	je     801017a7 <filewrite+0x10a>
        panic("short filewrite");
8010179b:	c7 04 24 c3 8e 10 80 	movl   $0x80108ec3,(%esp)
801017a2:	e8 96 ed ff ff       	call   8010053d <panic>
      i += r;
801017a7:	8b 45 e8             	mov    -0x18(%ebp),%eax
801017aa:	01 45 f4             	add    %eax,-0xc(%ebp)
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((LOGSIZE-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
801017ad:	8b 45 f4             	mov    -0xc(%ebp),%eax
801017b0:	3b 45 10             	cmp    0x10(%ebp),%eax
801017b3:	0f 8c 4c ff ff ff    	jl     80101705 <filewrite+0x68>
801017b9:	eb 01                	jmp    801017bc <filewrite+0x11f>
        f->off += r;
      iunlock(f->ip);
      commit_trans();

      if(r < 0)
        break;
801017bb:	90                   	nop
      if(r != n1)
        panic("short filewrite");
      i += r;
    }
    return i == n ? n : -1;
801017bc:	8b 45 f4             	mov    -0xc(%ebp),%eax
801017bf:	3b 45 10             	cmp    0x10(%ebp),%eax
801017c2:	75 05                	jne    801017c9 <filewrite+0x12c>
801017c4:	8b 45 10             	mov    0x10(%ebp),%eax
801017c7:	eb 05                	jmp    801017ce <filewrite+0x131>
801017c9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801017ce:	eb 0c                	jmp    801017dc <filewrite+0x13f>
  }
  panic("filewrite");
801017d0:	c7 04 24 d3 8e 10 80 	movl   $0x80108ed3,(%esp)
801017d7:	e8 61 ed ff ff       	call   8010053d <panic>
}
801017dc:	83 c4 24             	add    $0x24,%esp
801017df:	5b                   	pop    %ebx
801017e0:	5d                   	pop    %ebp
801017e1:	c3                   	ret    
	...

801017e4 <readsb>:
static void itrunc(struct inode*);

// Read the super block.
void
readsb(int dev, struct superblock *sb)
{
801017e4:	55                   	push   %ebp
801017e5:	89 e5                	mov    %esp,%ebp
801017e7:	83 ec 28             	sub    $0x28,%esp
  struct buf *bp;
  
  bp = bread(dev, 1);
801017ea:	8b 45 08             	mov    0x8(%ebp),%eax
801017ed:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
801017f4:	00 
801017f5:	89 04 24             	mov    %eax,(%esp)
801017f8:	e8 a9 e9 ff ff       	call   801001a6 <bread>
801017fd:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memmove(sb, bp->data, sizeof(*sb));
80101800:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101803:	83 c0 18             	add    $0x18,%eax
80101806:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
8010180d:	00 
8010180e:	89 44 24 04          	mov    %eax,0x4(%esp)
80101812:	8b 45 0c             	mov    0xc(%ebp),%eax
80101815:	89 04 24             	mov    %eax,(%esp)
80101818:	e8 08 42 00 00       	call   80105a25 <memmove>
  brelse(bp);
8010181d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101820:	89 04 24             	mov    %eax,(%esp)
80101823:	e8 ef e9 ff ff       	call   80100217 <brelse>
}
80101828:	c9                   	leave  
80101829:	c3                   	ret    

8010182a <bzero>:

// Zero a block.
static void
bzero(int dev, int bno)
{
8010182a:	55                   	push   %ebp
8010182b:	89 e5                	mov    %esp,%ebp
8010182d:	83 ec 28             	sub    $0x28,%esp
  struct buf *bp;
  
  bp = bread(dev, bno);
80101830:	8b 55 0c             	mov    0xc(%ebp),%edx
80101833:	8b 45 08             	mov    0x8(%ebp),%eax
80101836:	89 54 24 04          	mov    %edx,0x4(%esp)
8010183a:	89 04 24             	mov    %eax,(%esp)
8010183d:	e8 64 e9 ff ff       	call   801001a6 <bread>
80101842:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(bp->data, 0, BSIZE);
80101845:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101848:	83 c0 18             	add    $0x18,%eax
8010184b:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
80101852:	00 
80101853:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
8010185a:	00 
8010185b:	89 04 24             	mov    %eax,(%esp)
8010185e:	e8 ef 40 00 00       	call   80105952 <memset>
  log_write(bp);
80101863:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101866:	89 04 24             	mov    %eax,(%esp)
80101869:	e8 48 1f 00 00       	call   801037b6 <log_write>
  brelse(bp);
8010186e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101871:	89 04 24             	mov    %eax,(%esp)
80101874:	e8 9e e9 ff ff       	call   80100217 <brelse>
}
80101879:	c9                   	leave  
8010187a:	c3                   	ret    

8010187b <balloc>:
// Blocks. 

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
8010187b:	55                   	push   %ebp
8010187c:	89 e5                	mov    %esp,%ebp
8010187e:	53                   	push   %ebx
8010187f:	83 ec 34             	sub    $0x34,%esp
  int b, bi, m;
  struct buf *bp;
  struct superblock sb;

  bp = 0;
80101882:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  readsb(dev, &sb);
80101889:	8b 45 08             	mov    0x8(%ebp),%eax
8010188c:	8d 55 d8             	lea    -0x28(%ebp),%edx
8010188f:	89 54 24 04          	mov    %edx,0x4(%esp)
80101893:	89 04 24             	mov    %eax,(%esp)
80101896:	e8 49 ff ff ff       	call   801017e4 <readsb>
  for(b = 0; b < sb.size; b += BPB){
8010189b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801018a2:	e9 11 01 00 00       	jmp    801019b8 <balloc+0x13d>
    bp = bread(dev, BBLOCK(b, sb.ninodes));
801018a7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801018aa:	8d 90 ff 0f 00 00    	lea    0xfff(%eax),%edx
801018b0:	85 c0                	test   %eax,%eax
801018b2:	0f 48 c2             	cmovs  %edx,%eax
801018b5:	c1 f8 0c             	sar    $0xc,%eax
801018b8:	8b 55 e0             	mov    -0x20(%ebp),%edx
801018bb:	c1 ea 03             	shr    $0x3,%edx
801018be:	01 d0                	add    %edx,%eax
801018c0:	83 c0 03             	add    $0x3,%eax
801018c3:	89 44 24 04          	mov    %eax,0x4(%esp)
801018c7:	8b 45 08             	mov    0x8(%ebp),%eax
801018ca:	89 04 24             	mov    %eax,(%esp)
801018cd:	e8 d4 e8 ff ff       	call   801001a6 <bread>
801018d2:	89 45 ec             	mov    %eax,-0x14(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
801018d5:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
801018dc:	e9 a7 00 00 00       	jmp    80101988 <balloc+0x10d>
      m = 1 << (bi % 8);
801018e1:	8b 45 f0             	mov    -0x10(%ebp),%eax
801018e4:	89 c2                	mov    %eax,%edx
801018e6:	c1 fa 1f             	sar    $0x1f,%edx
801018e9:	c1 ea 1d             	shr    $0x1d,%edx
801018ec:	01 d0                	add    %edx,%eax
801018ee:	83 e0 07             	and    $0x7,%eax
801018f1:	29 d0                	sub    %edx,%eax
801018f3:	ba 01 00 00 00       	mov    $0x1,%edx
801018f8:	89 d3                	mov    %edx,%ebx
801018fa:	89 c1                	mov    %eax,%ecx
801018fc:	d3 e3                	shl    %cl,%ebx
801018fe:	89 d8                	mov    %ebx,%eax
80101900:	89 45 e8             	mov    %eax,-0x18(%ebp)
      if((bp->data[bi/8] & m) == 0){  // Is block free?
80101903:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101906:	8d 50 07             	lea    0x7(%eax),%edx
80101909:	85 c0                	test   %eax,%eax
8010190b:	0f 48 c2             	cmovs  %edx,%eax
8010190e:	c1 f8 03             	sar    $0x3,%eax
80101911:	8b 55 ec             	mov    -0x14(%ebp),%edx
80101914:	0f b6 44 02 18       	movzbl 0x18(%edx,%eax,1),%eax
80101919:	0f b6 c0             	movzbl %al,%eax
8010191c:	23 45 e8             	and    -0x18(%ebp),%eax
8010191f:	85 c0                	test   %eax,%eax
80101921:	75 61                	jne    80101984 <balloc+0x109>
        bp->data[bi/8] |= m;  // Mark block in use.
80101923:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101926:	8d 50 07             	lea    0x7(%eax),%edx
80101929:	85 c0                	test   %eax,%eax
8010192b:	0f 48 c2             	cmovs  %edx,%eax
8010192e:	c1 f8 03             	sar    $0x3,%eax
80101931:	8b 55 ec             	mov    -0x14(%ebp),%edx
80101934:	0f b6 54 02 18       	movzbl 0x18(%edx,%eax,1),%edx
80101939:	89 d1                	mov    %edx,%ecx
8010193b:	8b 55 e8             	mov    -0x18(%ebp),%edx
8010193e:	09 ca                	or     %ecx,%edx
80101940:	89 d1                	mov    %edx,%ecx
80101942:	8b 55 ec             	mov    -0x14(%ebp),%edx
80101945:	88 4c 02 18          	mov    %cl,0x18(%edx,%eax,1)
        log_write(bp);
80101949:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010194c:	89 04 24             	mov    %eax,(%esp)
8010194f:	e8 62 1e 00 00       	call   801037b6 <log_write>
        brelse(bp);
80101954:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101957:	89 04 24             	mov    %eax,(%esp)
8010195a:	e8 b8 e8 ff ff       	call   80100217 <brelse>
        bzero(dev, b + bi);
8010195f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101962:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101965:	01 c2                	add    %eax,%edx
80101967:	8b 45 08             	mov    0x8(%ebp),%eax
8010196a:	89 54 24 04          	mov    %edx,0x4(%esp)
8010196e:	89 04 24             	mov    %eax,(%esp)
80101971:	e8 b4 fe ff ff       	call   8010182a <bzero>
        return b + bi;
80101976:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101979:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010197c:	01 d0                	add    %edx,%eax
      }
    }
    brelse(bp);
  }
  panic("balloc: out of blocks");
}
8010197e:	83 c4 34             	add    $0x34,%esp
80101981:	5b                   	pop    %ebx
80101982:	5d                   	pop    %ebp
80101983:	c3                   	ret    

  bp = 0;
  readsb(dev, &sb);
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb.ninodes));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
80101984:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
80101988:	81 7d f0 ff 0f 00 00 	cmpl   $0xfff,-0x10(%ebp)
8010198f:	7f 15                	jg     801019a6 <balloc+0x12b>
80101991:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101994:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101997:	01 d0                	add    %edx,%eax
80101999:	89 c2                	mov    %eax,%edx
8010199b:	8b 45 d8             	mov    -0x28(%ebp),%eax
8010199e:	39 c2                	cmp    %eax,%edx
801019a0:	0f 82 3b ff ff ff    	jb     801018e1 <balloc+0x66>
        brelse(bp);
        bzero(dev, b + bi);
        return b + bi;
      }
    }
    brelse(bp);
801019a6:	8b 45 ec             	mov    -0x14(%ebp),%eax
801019a9:	89 04 24             	mov    %eax,(%esp)
801019ac:	e8 66 e8 ff ff       	call   80100217 <brelse>
  struct buf *bp;
  struct superblock sb;

  bp = 0;
  readsb(dev, &sb);
  for(b = 0; b < sb.size; b += BPB){
801019b1:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
801019b8:	8b 55 f4             	mov    -0xc(%ebp),%edx
801019bb:	8b 45 d8             	mov    -0x28(%ebp),%eax
801019be:	39 c2                	cmp    %eax,%edx
801019c0:	0f 82 e1 fe ff ff    	jb     801018a7 <balloc+0x2c>
        return b + bi;
      }
    }
    brelse(bp);
  }
  panic("balloc: out of blocks");
801019c6:	c7 04 24 dd 8e 10 80 	movl   $0x80108edd,(%esp)
801019cd:	e8 6b eb ff ff       	call   8010053d <panic>

801019d2 <bfree>:
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
801019d2:	55                   	push   %ebp
801019d3:	89 e5                	mov    %esp,%ebp
801019d5:	53                   	push   %ebx
801019d6:	83 ec 34             	sub    $0x34,%esp
  struct buf *bp;
  struct superblock sb;
  int bi, m;

  readsb(dev, &sb);
801019d9:	8d 45 dc             	lea    -0x24(%ebp),%eax
801019dc:	89 44 24 04          	mov    %eax,0x4(%esp)
801019e0:	8b 45 08             	mov    0x8(%ebp),%eax
801019e3:	89 04 24             	mov    %eax,(%esp)
801019e6:	e8 f9 fd ff ff       	call   801017e4 <readsb>
  bp = bread(dev, BBLOCK(b, sb.ninodes));
801019eb:	8b 45 0c             	mov    0xc(%ebp),%eax
801019ee:	89 c2                	mov    %eax,%edx
801019f0:	c1 ea 0c             	shr    $0xc,%edx
801019f3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801019f6:	c1 e8 03             	shr    $0x3,%eax
801019f9:	01 d0                	add    %edx,%eax
801019fb:	8d 50 03             	lea    0x3(%eax),%edx
801019fe:	8b 45 08             	mov    0x8(%ebp),%eax
80101a01:	89 54 24 04          	mov    %edx,0x4(%esp)
80101a05:	89 04 24             	mov    %eax,(%esp)
80101a08:	e8 99 e7 ff ff       	call   801001a6 <bread>
80101a0d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  bi = b % BPB;
80101a10:	8b 45 0c             	mov    0xc(%ebp),%eax
80101a13:	25 ff 0f 00 00       	and    $0xfff,%eax
80101a18:	89 45 f0             	mov    %eax,-0x10(%ebp)
  m = 1 << (bi % 8);
80101a1b:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101a1e:	89 c2                	mov    %eax,%edx
80101a20:	c1 fa 1f             	sar    $0x1f,%edx
80101a23:	c1 ea 1d             	shr    $0x1d,%edx
80101a26:	01 d0                	add    %edx,%eax
80101a28:	83 e0 07             	and    $0x7,%eax
80101a2b:	29 d0                	sub    %edx,%eax
80101a2d:	ba 01 00 00 00       	mov    $0x1,%edx
80101a32:	89 d3                	mov    %edx,%ebx
80101a34:	89 c1                	mov    %eax,%ecx
80101a36:	d3 e3                	shl    %cl,%ebx
80101a38:	89 d8                	mov    %ebx,%eax
80101a3a:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((bp->data[bi/8] & m) == 0)
80101a3d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101a40:	8d 50 07             	lea    0x7(%eax),%edx
80101a43:	85 c0                	test   %eax,%eax
80101a45:	0f 48 c2             	cmovs  %edx,%eax
80101a48:	c1 f8 03             	sar    $0x3,%eax
80101a4b:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101a4e:	0f b6 44 02 18       	movzbl 0x18(%edx,%eax,1),%eax
80101a53:	0f b6 c0             	movzbl %al,%eax
80101a56:	23 45 ec             	and    -0x14(%ebp),%eax
80101a59:	85 c0                	test   %eax,%eax
80101a5b:	75 0c                	jne    80101a69 <bfree+0x97>
    panic("freeing free block");
80101a5d:	c7 04 24 f3 8e 10 80 	movl   $0x80108ef3,(%esp)
80101a64:	e8 d4 ea ff ff       	call   8010053d <panic>
  bp->data[bi/8] &= ~m;
80101a69:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101a6c:	8d 50 07             	lea    0x7(%eax),%edx
80101a6f:	85 c0                	test   %eax,%eax
80101a71:	0f 48 c2             	cmovs  %edx,%eax
80101a74:	c1 f8 03             	sar    $0x3,%eax
80101a77:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101a7a:	0f b6 54 02 18       	movzbl 0x18(%edx,%eax,1),%edx
80101a7f:	8b 4d ec             	mov    -0x14(%ebp),%ecx
80101a82:	f7 d1                	not    %ecx
80101a84:	21 ca                	and    %ecx,%edx
80101a86:	89 d1                	mov    %edx,%ecx
80101a88:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101a8b:	88 4c 02 18          	mov    %cl,0x18(%edx,%eax,1)
  log_write(bp);
80101a8f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101a92:	89 04 24             	mov    %eax,(%esp)
80101a95:	e8 1c 1d 00 00       	call   801037b6 <log_write>
  brelse(bp);
80101a9a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101a9d:	89 04 24             	mov    %eax,(%esp)
80101aa0:	e8 72 e7 ff ff       	call   80100217 <brelse>
}
80101aa5:	83 c4 34             	add    $0x34,%esp
80101aa8:	5b                   	pop    %ebx
80101aa9:	5d                   	pop    %ebp
80101aaa:	c3                   	ret    

80101aab <iinit>:
  struct inode inode[NINODE];
} icache;

void
iinit(void)
{
80101aab:	55                   	push   %ebp
80101aac:	89 e5                	mov    %esp,%ebp
80101aae:	83 ec 18             	sub    $0x18,%esp
  initlock(&icache.lock, "icache");
80101ab1:	c7 44 24 04 06 8f 10 	movl   $0x80108f06,0x4(%esp)
80101ab8:	80 
80101ab9:	c7 04 24 e0 0a 11 80 	movl   $0x80110ae0,(%esp)
80101ac0:	e8 1d 3c 00 00       	call   801056e2 <initlock>
}
80101ac5:	c9                   	leave  
80101ac6:	c3                   	ret    

80101ac7 <ialloc>:
//PAGEBREAK!
// Allocate a new inode with the given type on device dev.
// A free inode has a type of zero.
struct inode*
ialloc(uint dev, short type)
{
80101ac7:	55                   	push   %ebp
80101ac8:	89 e5                	mov    %esp,%ebp
80101aca:	83 ec 48             	sub    $0x48,%esp
80101acd:	8b 45 0c             	mov    0xc(%ebp),%eax
80101ad0:	66 89 45 d4          	mov    %ax,-0x2c(%ebp)
  int inum;
  struct buf *bp;
  struct dinode *dip;
  struct superblock sb;

  readsb(dev, &sb);
80101ad4:	8b 45 08             	mov    0x8(%ebp),%eax
80101ad7:	8d 55 dc             	lea    -0x24(%ebp),%edx
80101ada:	89 54 24 04          	mov    %edx,0x4(%esp)
80101ade:	89 04 24             	mov    %eax,(%esp)
80101ae1:	e8 fe fc ff ff       	call   801017e4 <readsb>

  for(inum = 1; inum < sb.ninodes; inum++){
80101ae6:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
80101aed:	e9 98 00 00 00       	jmp    80101b8a <ialloc+0xc3>
    bp = bread(dev, IBLOCK(inum));
80101af2:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101af5:	c1 e8 03             	shr    $0x3,%eax
80101af8:	83 c0 02             	add    $0x2,%eax
80101afb:	89 44 24 04          	mov    %eax,0x4(%esp)
80101aff:	8b 45 08             	mov    0x8(%ebp),%eax
80101b02:	89 04 24             	mov    %eax,(%esp)
80101b05:	e8 9c e6 ff ff       	call   801001a6 <bread>
80101b0a:	89 45 f0             	mov    %eax,-0x10(%ebp)
    dip = (struct dinode*)bp->data + inum%IPB;
80101b0d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101b10:	8d 50 18             	lea    0x18(%eax),%edx
80101b13:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101b16:	83 e0 07             	and    $0x7,%eax
80101b19:	c1 e0 06             	shl    $0x6,%eax
80101b1c:	01 d0                	add    %edx,%eax
80101b1e:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(dip->type == 0){  // a free inode
80101b21:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101b24:	0f b7 00             	movzwl (%eax),%eax
80101b27:	66 85 c0             	test   %ax,%ax
80101b2a:	75 4f                	jne    80101b7b <ialloc+0xb4>
      memset(dip, 0, sizeof(*dip));
80101b2c:	c7 44 24 08 40 00 00 	movl   $0x40,0x8(%esp)
80101b33:	00 
80101b34:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80101b3b:	00 
80101b3c:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101b3f:	89 04 24             	mov    %eax,(%esp)
80101b42:	e8 0b 3e 00 00       	call   80105952 <memset>
      dip->type = type;
80101b47:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101b4a:	0f b7 55 d4          	movzwl -0x2c(%ebp),%edx
80101b4e:	66 89 10             	mov    %dx,(%eax)
      log_write(bp);   // mark it allocated on the disk
80101b51:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101b54:	89 04 24             	mov    %eax,(%esp)
80101b57:	e8 5a 1c 00 00       	call   801037b6 <log_write>
      brelse(bp);
80101b5c:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101b5f:	89 04 24             	mov    %eax,(%esp)
80101b62:	e8 b0 e6 ff ff       	call   80100217 <brelse>
      return iget(dev, inum);
80101b67:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101b6a:	89 44 24 04          	mov    %eax,0x4(%esp)
80101b6e:	8b 45 08             	mov    0x8(%ebp),%eax
80101b71:	89 04 24             	mov    %eax,(%esp)
80101b74:	e8 e3 00 00 00       	call   80101c5c <iget>
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
}
80101b79:	c9                   	leave  
80101b7a:	c3                   	ret    
      dip->type = type;
      log_write(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
    }
    brelse(bp);
80101b7b:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101b7e:	89 04 24             	mov    %eax,(%esp)
80101b81:	e8 91 e6 ff ff       	call   80100217 <brelse>
  struct dinode *dip;
  struct superblock sb;

  readsb(dev, &sb);

  for(inum = 1; inum < sb.ninodes; inum++){
80101b86:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80101b8a:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101b8d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101b90:	39 c2                	cmp    %eax,%edx
80101b92:	0f 82 5a ff ff ff    	jb     80101af2 <ialloc+0x2b>
      brelse(bp);
      return iget(dev, inum);
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
80101b98:	c7 04 24 0d 8f 10 80 	movl   $0x80108f0d,(%esp)
80101b9f:	e8 99 e9 ff ff       	call   8010053d <panic>

80101ba4 <iupdate>:
}

// Copy a modified in-memory inode to disk.
void
iupdate(struct inode *ip)
{
80101ba4:	55                   	push   %ebp
80101ba5:	89 e5                	mov    %esp,%ebp
80101ba7:	83 ec 28             	sub    $0x28,%esp
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum));
80101baa:	8b 45 08             	mov    0x8(%ebp),%eax
80101bad:	8b 40 04             	mov    0x4(%eax),%eax
80101bb0:	c1 e8 03             	shr    $0x3,%eax
80101bb3:	8d 50 02             	lea    0x2(%eax),%edx
80101bb6:	8b 45 08             	mov    0x8(%ebp),%eax
80101bb9:	8b 00                	mov    (%eax),%eax
80101bbb:	89 54 24 04          	mov    %edx,0x4(%esp)
80101bbf:	89 04 24             	mov    %eax,(%esp)
80101bc2:	e8 df e5 ff ff       	call   801001a6 <bread>
80101bc7:	89 45 f4             	mov    %eax,-0xc(%ebp)
  dip = (struct dinode*)bp->data + ip->inum%IPB;
80101bca:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101bcd:	8d 50 18             	lea    0x18(%eax),%edx
80101bd0:	8b 45 08             	mov    0x8(%ebp),%eax
80101bd3:	8b 40 04             	mov    0x4(%eax),%eax
80101bd6:	83 e0 07             	and    $0x7,%eax
80101bd9:	c1 e0 06             	shl    $0x6,%eax
80101bdc:	01 d0                	add    %edx,%eax
80101bde:	89 45 f0             	mov    %eax,-0x10(%ebp)
  dip->type = ip->type;
80101be1:	8b 45 08             	mov    0x8(%ebp),%eax
80101be4:	0f b7 50 10          	movzwl 0x10(%eax),%edx
80101be8:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101beb:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
80101bee:	8b 45 08             	mov    0x8(%ebp),%eax
80101bf1:	0f b7 50 12          	movzwl 0x12(%eax),%edx
80101bf5:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101bf8:	66 89 50 02          	mov    %dx,0x2(%eax)
  dip->minor = ip->minor;
80101bfc:	8b 45 08             	mov    0x8(%ebp),%eax
80101bff:	0f b7 50 14          	movzwl 0x14(%eax),%edx
80101c03:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101c06:	66 89 50 04          	mov    %dx,0x4(%eax)
  dip->nlink = ip->nlink;
80101c0a:	8b 45 08             	mov    0x8(%ebp),%eax
80101c0d:	0f b7 50 16          	movzwl 0x16(%eax),%edx
80101c11:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101c14:	66 89 50 06          	mov    %dx,0x6(%eax)
  dip->size = ip->size;
80101c18:	8b 45 08             	mov    0x8(%ebp),%eax
80101c1b:	8b 50 18             	mov    0x18(%eax),%edx
80101c1e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101c21:	89 50 08             	mov    %edx,0x8(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101c24:	8b 45 08             	mov    0x8(%ebp),%eax
80101c27:	8d 50 1c             	lea    0x1c(%eax),%edx
80101c2a:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101c2d:	83 c0 0c             	add    $0xc,%eax
80101c30:	c7 44 24 08 34 00 00 	movl   $0x34,0x8(%esp)
80101c37:	00 
80101c38:	89 54 24 04          	mov    %edx,0x4(%esp)
80101c3c:	89 04 24             	mov    %eax,(%esp)
80101c3f:	e8 e1 3d 00 00       	call   80105a25 <memmove>
  log_write(bp);
80101c44:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101c47:	89 04 24             	mov    %eax,(%esp)
80101c4a:	e8 67 1b 00 00       	call   801037b6 <log_write>
  brelse(bp);
80101c4f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101c52:	89 04 24             	mov    %eax,(%esp)
80101c55:	e8 bd e5 ff ff       	call   80100217 <brelse>
}
80101c5a:	c9                   	leave  
80101c5b:	c3                   	ret    

80101c5c <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
80101c5c:	55                   	push   %ebp
80101c5d:	89 e5                	mov    %esp,%ebp
80101c5f:	83 ec 28             	sub    $0x28,%esp
  struct inode *ip, *empty;

  acquire(&icache.lock);
80101c62:	c7 04 24 e0 0a 11 80 	movl   $0x80110ae0,(%esp)
80101c69:	e8 95 3a 00 00       	call   80105703 <acquire>

  // Is the inode already cached?
  empty = 0;
80101c6e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101c75:	c7 45 f4 14 0b 11 80 	movl   $0x80110b14,-0xc(%ebp)
80101c7c:	eb 59                	jmp    80101cd7 <iget+0x7b>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101c7e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101c81:	8b 40 08             	mov    0x8(%eax),%eax
80101c84:	85 c0                	test   %eax,%eax
80101c86:	7e 35                	jle    80101cbd <iget+0x61>
80101c88:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101c8b:	8b 00                	mov    (%eax),%eax
80101c8d:	3b 45 08             	cmp    0x8(%ebp),%eax
80101c90:	75 2b                	jne    80101cbd <iget+0x61>
80101c92:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101c95:	8b 40 04             	mov    0x4(%eax),%eax
80101c98:	3b 45 0c             	cmp    0xc(%ebp),%eax
80101c9b:	75 20                	jne    80101cbd <iget+0x61>
      ip->ref++;
80101c9d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101ca0:	8b 40 08             	mov    0x8(%eax),%eax
80101ca3:	8d 50 01             	lea    0x1(%eax),%edx
80101ca6:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101ca9:	89 50 08             	mov    %edx,0x8(%eax)
      release(&icache.lock);
80101cac:	c7 04 24 e0 0a 11 80 	movl   $0x80110ae0,(%esp)
80101cb3:	e8 ad 3a 00 00       	call   80105765 <release>
      return ip;
80101cb8:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101cbb:	eb 6f                	jmp    80101d2c <iget+0xd0>
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
80101cbd:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80101cc1:	75 10                	jne    80101cd3 <iget+0x77>
80101cc3:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101cc6:	8b 40 08             	mov    0x8(%eax),%eax
80101cc9:	85 c0                	test   %eax,%eax
80101ccb:	75 06                	jne    80101cd3 <iget+0x77>
      empty = ip;
80101ccd:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101cd0:	89 45 f0             	mov    %eax,-0x10(%ebp)

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101cd3:	83 45 f4 50          	addl   $0x50,-0xc(%ebp)
80101cd7:	81 7d f4 b4 1a 11 80 	cmpl   $0x80111ab4,-0xc(%ebp)
80101cde:	72 9e                	jb     80101c7e <iget+0x22>
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
80101ce0:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80101ce4:	75 0c                	jne    80101cf2 <iget+0x96>
    panic("iget: no inodes");
80101ce6:	c7 04 24 1f 8f 10 80 	movl   $0x80108f1f,(%esp)
80101ced:	e8 4b e8 ff ff       	call   8010053d <panic>

  ip = empty;
80101cf2:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101cf5:	89 45 f4             	mov    %eax,-0xc(%ebp)
  ip->dev = dev;
80101cf8:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101cfb:	8b 55 08             	mov    0x8(%ebp),%edx
80101cfe:	89 10                	mov    %edx,(%eax)
  ip->inum = inum;
80101d00:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101d03:	8b 55 0c             	mov    0xc(%ebp),%edx
80101d06:	89 50 04             	mov    %edx,0x4(%eax)
  ip->ref = 1;
80101d09:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101d0c:	c7 40 08 01 00 00 00 	movl   $0x1,0x8(%eax)
  ip->flags = 0;
80101d13:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101d16:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
  release(&icache.lock);
80101d1d:	c7 04 24 e0 0a 11 80 	movl   $0x80110ae0,(%esp)
80101d24:	e8 3c 3a 00 00       	call   80105765 <release>

  return ip;
80101d29:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80101d2c:	c9                   	leave  
80101d2d:	c3                   	ret    

80101d2e <idup>:

// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
80101d2e:	55                   	push   %ebp
80101d2f:	89 e5                	mov    %esp,%ebp
80101d31:	83 ec 18             	sub    $0x18,%esp
  acquire(&icache.lock);
80101d34:	c7 04 24 e0 0a 11 80 	movl   $0x80110ae0,(%esp)
80101d3b:	e8 c3 39 00 00       	call   80105703 <acquire>
  ip->ref++;
80101d40:	8b 45 08             	mov    0x8(%ebp),%eax
80101d43:	8b 40 08             	mov    0x8(%eax),%eax
80101d46:	8d 50 01             	lea    0x1(%eax),%edx
80101d49:	8b 45 08             	mov    0x8(%ebp),%eax
80101d4c:	89 50 08             	mov    %edx,0x8(%eax)
  release(&icache.lock);
80101d4f:	c7 04 24 e0 0a 11 80 	movl   $0x80110ae0,(%esp)
80101d56:	e8 0a 3a 00 00       	call   80105765 <release>
  return ip;
80101d5b:	8b 45 08             	mov    0x8(%ebp),%eax
}
80101d5e:	c9                   	leave  
80101d5f:	c3                   	ret    

80101d60 <ilock>:

// Lock the given inode.
// Reads the inode from disk if necessary.
void
ilock(struct inode *ip)
{
80101d60:	55                   	push   %ebp
80101d61:	89 e5                	mov    %esp,%ebp
80101d63:	83 ec 28             	sub    $0x28,%esp
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
80101d66:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80101d6a:	74 0a                	je     80101d76 <ilock+0x16>
80101d6c:	8b 45 08             	mov    0x8(%ebp),%eax
80101d6f:	8b 40 08             	mov    0x8(%eax),%eax
80101d72:	85 c0                	test   %eax,%eax
80101d74:	7f 0c                	jg     80101d82 <ilock+0x22>
    panic("ilock");
80101d76:	c7 04 24 2f 8f 10 80 	movl   $0x80108f2f,(%esp)
80101d7d:	e8 bb e7 ff ff       	call   8010053d <panic>

  acquire(&icache.lock);
80101d82:	c7 04 24 e0 0a 11 80 	movl   $0x80110ae0,(%esp)
80101d89:	e8 75 39 00 00       	call   80105703 <acquire>
  while(ip->flags & I_BUSY)
80101d8e:	eb 13                	jmp    80101da3 <ilock+0x43>
    sleep(ip, &icache.lock);
80101d90:	c7 44 24 04 e0 0a 11 	movl   $0x80110ae0,0x4(%esp)
80101d97:	80 
80101d98:	8b 45 08             	mov    0x8(%ebp),%eax
80101d9b:	89 04 24             	mov    %eax,(%esp)
80101d9e:	e8 64 35 00 00       	call   80105307 <sleep>

  if(ip == 0 || ip->ref < 1)
    panic("ilock");

  acquire(&icache.lock);
  while(ip->flags & I_BUSY)
80101da3:	8b 45 08             	mov    0x8(%ebp),%eax
80101da6:	8b 40 0c             	mov    0xc(%eax),%eax
80101da9:	83 e0 01             	and    $0x1,%eax
80101dac:	84 c0                	test   %al,%al
80101dae:	75 e0                	jne    80101d90 <ilock+0x30>
    sleep(ip, &icache.lock);
  ip->flags |= I_BUSY;
80101db0:	8b 45 08             	mov    0x8(%ebp),%eax
80101db3:	8b 40 0c             	mov    0xc(%eax),%eax
80101db6:	89 c2                	mov    %eax,%edx
80101db8:	83 ca 01             	or     $0x1,%edx
80101dbb:	8b 45 08             	mov    0x8(%ebp),%eax
80101dbe:	89 50 0c             	mov    %edx,0xc(%eax)
  release(&icache.lock);
80101dc1:	c7 04 24 e0 0a 11 80 	movl   $0x80110ae0,(%esp)
80101dc8:	e8 98 39 00 00       	call   80105765 <release>

  if(!(ip->flags & I_VALID)){
80101dcd:	8b 45 08             	mov    0x8(%ebp),%eax
80101dd0:	8b 40 0c             	mov    0xc(%eax),%eax
80101dd3:	83 e0 02             	and    $0x2,%eax
80101dd6:	85 c0                	test   %eax,%eax
80101dd8:	0f 85 ce 00 00 00    	jne    80101eac <ilock+0x14c>
    bp = bread(ip->dev, IBLOCK(ip->inum));
80101dde:	8b 45 08             	mov    0x8(%ebp),%eax
80101de1:	8b 40 04             	mov    0x4(%eax),%eax
80101de4:	c1 e8 03             	shr    $0x3,%eax
80101de7:	8d 50 02             	lea    0x2(%eax),%edx
80101dea:	8b 45 08             	mov    0x8(%ebp),%eax
80101ded:	8b 00                	mov    (%eax),%eax
80101def:	89 54 24 04          	mov    %edx,0x4(%esp)
80101df3:	89 04 24             	mov    %eax,(%esp)
80101df6:	e8 ab e3 ff ff       	call   801001a6 <bread>
80101dfb:	89 45 f4             	mov    %eax,-0xc(%ebp)
    dip = (struct dinode*)bp->data + ip->inum%IPB;
80101dfe:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101e01:	8d 50 18             	lea    0x18(%eax),%edx
80101e04:	8b 45 08             	mov    0x8(%ebp),%eax
80101e07:	8b 40 04             	mov    0x4(%eax),%eax
80101e0a:	83 e0 07             	and    $0x7,%eax
80101e0d:	c1 e0 06             	shl    $0x6,%eax
80101e10:	01 d0                	add    %edx,%eax
80101e12:	89 45 f0             	mov    %eax,-0x10(%ebp)
    ip->type = dip->type;
80101e15:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101e18:	0f b7 10             	movzwl (%eax),%edx
80101e1b:	8b 45 08             	mov    0x8(%ebp),%eax
80101e1e:	66 89 50 10          	mov    %dx,0x10(%eax)
    ip->major = dip->major;
80101e22:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101e25:	0f b7 50 02          	movzwl 0x2(%eax),%edx
80101e29:	8b 45 08             	mov    0x8(%ebp),%eax
80101e2c:	66 89 50 12          	mov    %dx,0x12(%eax)
    ip->minor = dip->minor;
80101e30:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101e33:	0f b7 50 04          	movzwl 0x4(%eax),%edx
80101e37:	8b 45 08             	mov    0x8(%ebp),%eax
80101e3a:	66 89 50 14          	mov    %dx,0x14(%eax)
    ip->nlink = dip->nlink;
80101e3e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101e41:	0f b7 50 06          	movzwl 0x6(%eax),%edx
80101e45:	8b 45 08             	mov    0x8(%ebp),%eax
80101e48:	66 89 50 16          	mov    %dx,0x16(%eax)
    ip->size = dip->size;
80101e4c:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101e4f:	8b 50 08             	mov    0x8(%eax),%edx
80101e52:	8b 45 08             	mov    0x8(%ebp),%eax
80101e55:	89 50 18             	mov    %edx,0x18(%eax)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101e58:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101e5b:	8d 50 0c             	lea    0xc(%eax),%edx
80101e5e:	8b 45 08             	mov    0x8(%ebp),%eax
80101e61:	83 c0 1c             	add    $0x1c,%eax
80101e64:	c7 44 24 08 34 00 00 	movl   $0x34,0x8(%esp)
80101e6b:	00 
80101e6c:	89 54 24 04          	mov    %edx,0x4(%esp)
80101e70:	89 04 24             	mov    %eax,(%esp)
80101e73:	e8 ad 3b 00 00       	call   80105a25 <memmove>
    brelse(bp);
80101e78:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101e7b:	89 04 24             	mov    %eax,(%esp)
80101e7e:	e8 94 e3 ff ff       	call   80100217 <brelse>
    ip->flags |= I_VALID;
80101e83:	8b 45 08             	mov    0x8(%ebp),%eax
80101e86:	8b 40 0c             	mov    0xc(%eax),%eax
80101e89:	89 c2                	mov    %eax,%edx
80101e8b:	83 ca 02             	or     $0x2,%edx
80101e8e:	8b 45 08             	mov    0x8(%ebp),%eax
80101e91:	89 50 0c             	mov    %edx,0xc(%eax)
    if(ip->type == 0)
80101e94:	8b 45 08             	mov    0x8(%ebp),%eax
80101e97:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80101e9b:	66 85 c0             	test   %ax,%ax
80101e9e:	75 0c                	jne    80101eac <ilock+0x14c>
      panic("ilock: no type");
80101ea0:	c7 04 24 35 8f 10 80 	movl   $0x80108f35,(%esp)
80101ea7:	e8 91 e6 ff ff       	call   8010053d <panic>
  }
}
80101eac:	c9                   	leave  
80101ead:	c3                   	ret    

80101eae <iunlock>:

// Unlock the given inode.
void
iunlock(struct inode *ip)
{
80101eae:	55                   	push   %ebp
80101eaf:	89 e5                	mov    %esp,%ebp
80101eb1:	83 ec 18             	sub    $0x18,%esp
  if(ip == 0 || !(ip->flags & I_BUSY) || ip->ref < 1)
80101eb4:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80101eb8:	74 17                	je     80101ed1 <iunlock+0x23>
80101eba:	8b 45 08             	mov    0x8(%ebp),%eax
80101ebd:	8b 40 0c             	mov    0xc(%eax),%eax
80101ec0:	83 e0 01             	and    $0x1,%eax
80101ec3:	85 c0                	test   %eax,%eax
80101ec5:	74 0a                	je     80101ed1 <iunlock+0x23>
80101ec7:	8b 45 08             	mov    0x8(%ebp),%eax
80101eca:	8b 40 08             	mov    0x8(%eax),%eax
80101ecd:	85 c0                	test   %eax,%eax
80101ecf:	7f 0c                	jg     80101edd <iunlock+0x2f>
    panic("iunlock");
80101ed1:	c7 04 24 44 8f 10 80 	movl   $0x80108f44,(%esp)
80101ed8:	e8 60 e6 ff ff       	call   8010053d <panic>

  acquire(&icache.lock);
80101edd:	c7 04 24 e0 0a 11 80 	movl   $0x80110ae0,(%esp)
80101ee4:	e8 1a 38 00 00       	call   80105703 <acquire>
  ip->flags &= ~I_BUSY;
80101ee9:	8b 45 08             	mov    0x8(%ebp),%eax
80101eec:	8b 40 0c             	mov    0xc(%eax),%eax
80101eef:	89 c2                	mov    %eax,%edx
80101ef1:	83 e2 fe             	and    $0xfffffffe,%edx
80101ef4:	8b 45 08             	mov    0x8(%ebp),%eax
80101ef7:	89 50 0c             	mov    %edx,0xc(%eax)
  wakeup(ip);
80101efa:	8b 45 08             	mov    0x8(%ebp),%eax
80101efd:	89 04 24             	mov    %eax,(%esp)
80101f00:	e8 f0 34 00 00       	call   801053f5 <wakeup>
  release(&icache.lock);
80101f05:	c7 04 24 e0 0a 11 80 	movl   $0x80110ae0,(%esp)
80101f0c:	e8 54 38 00 00       	call   80105765 <release>
}
80101f11:	c9                   	leave  
80101f12:	c3                   	ret    

80101f13 <iput>:
// be recycled.
// If that was the last reference and the inode has no links
// to it, free the inode (and its content) on disk.
void
iput(struct inode *ip)
{
80101f13:	55                   	push   %ebp
80101f14:	89 e5                	mov    %esp,%ebp
80101f16:	83 ec 18             	sub    $0x18,%esp
  acquire(&icache.lock);
80101f19:	c7 04 24 e0 0a 11 80 	movl   $0x80110ae0,(%esp)
80101f20:	e8 de 37 00 00       	call   80105703 <acquire>
  if(ip->ref == 1 && (ip->flags & I_VALID) && ip->nlink == 0){
80101f25:	8b 45 08             	mov    0x8(%ebp),%eax
80101f28:	8b 40 08             	mov    0x8(%eax),%eax
80101f2b:	83 f8 01             	cmp    $0x1,%eax
80101f2e:	0f 85 93 00 00 00    	jne    80101fc7 <iput+0xb4>
80101f34:	8b 45 08             	mov    0x8(%ebp),%eax
80101f37:	8b 40 0c             	mov    0xc(%eax),%eax
80101f3a:	83 e0 02             	and    $0x2,%eax
80101f3d:	85 c0                	test   %eax,%eax
80101f3f:	0f 84 82 00 00 00    	je     80101fc7 <iput+0xb4>
80101f45:	8b 45 08             	mov    0x8(%ebp),%eax
80101f48:	0f b7 40 16          	movzwl 0x16(%eax),%eax
80101f4c:	66 85 c0             	test   %ax,%ax
80101f4f:	75 76                	jne    80101fc7 <iput+0xb4>
    // inode has no links: truncate and free inode.
    if(ip->flags & I_BUSY)
80101f51:	8b 45 08             	mov    0x8(%ebp),%eax
80101f54:	8b 40 0c             	mov    0xc(%eax),%eax
80101f57:	83 e0 01             	and    $0x1,%eax
80101f5a:	84 c0                	test   %al,%al
80101f5c:	74 0c                	je     80101f6a <iput+0x57>
      panic("iput busy");
80101f5e:	c7 04 24 4c 8f 10 80 	movl   $0x80108f4c,(%esp)
80101f65:	e8 d3 e5 ff ff       	call   8010053d <panic>
    ip->flags |= I_BUSY;
80101f6a:	8b 45 08             	mov    0x8(%ebp),%eax
80101f6d:	8b 40 0c             	mov    0xc(%eax),%eax
80101f70:	89 c2                	mov    %eax,%edx
80101f72:	83 ca 01             	or     $0x1,%edx
80101f75:	8b 45 08             	mov    0x8(%ebp),%eax
80101f78:	89 50 0c             	mov    %edx,0xc(%eax)
    release(&icache.lock);
80101f7b:	c7 04 24 e0 0a 11 80 	movl   $0x80110ae0,(%esp)
80101f82:	e8 de 37 00 00       	call   80105765 <release>
    itrunc(ip);
80101f87:	8b 45 08             	mov    0x8(%ebp),%eax
80101f8a:	89 04 24             	mov    %eax,(%esp)
80101f8d:	e8 72 01 00 00       	call   80102104 <itrunc>
    ip->type = 0;
80101f92:	8b 45 08             	mov    0x8(%ebp),%eax
80101f95:	66 c7 40 10 00 00    	movw   $0x0,0x10(%eax)
    iupdate(ip);
80101f9b:	8b 45 08             	mov    0x8(%ebp),%eax
80101f9e:	89 04 24             	mov    %eax,(%esp)
80101fa1:	e8 fe fb ff ff       	call   80101ba4 <iupdate>
    acquire(&icache.lock);
80101fa6:	c7 04 24 e0 0a 11 80 	movl   $0x80110ae0,(%esp)
80101fad:	e8 51 37 00 00       	call   80105703 <acquire>
    ip->flags = 0;
80101fb2:	8b 45 08             	mov    0x8(%ebp),%eax
80101fb5:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    wakeup(ip);
80101fbc:	8b 45 08             	mov    0x8(%ebp),%eax
80101fbf:	89 04 24             	mov    %eax,(%esp)
80101fc2:	e8 2e 34 00 00       	call   801053f5 <wakeup>
  }
  ip->ref--;
80101fc7:	8b 45 08             	mov    0x8(%ebp),%eax
80101fca:	8b 40 08             	mov    0x8(%eax),%eax
80101fcd:	8d 50 ff             	lea    -0x1(%eax),%edx
80101fd0:	8b 45 08             	mov    0x8(%ebp),%eax
80101fd3:	89 50 08             	mov    %edx,0x8(%eax)
  release(&icache.lock);
80101fd6:	c7 04 24 e0 0a 11 80 	movl   $0x80110ae0,(%esp)
80101fdd:	e8 83 37 00 00       	call   80105765 <release>
}
80101fe2:	c9                   	leave  
80101fe3:	c3                   	ret    

80101fe4 <iunlockput>:

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
80101fe4:	55                   	push   %ebp
80101fe5:	89 e5                	mov    %esp,%ebp
80101fe7:	83 ec 18             	sub    $0x18,%esp
  iunlock(ip);
80101fea:	8b 45 08             	mov    0x8(%ebp),%eax
80101fed:	89 04 24             	mov    %eax,(%esp)
80101ff0:	e8 b9 fe ff ff       	call   80101eae <iunlock>
  iput(ip);
80101ff5:	8b 45 08             	mov    0x8(%ebp),%eax
80101ff8:	89 04 24             	mov    %eax,(%esp)
80101ffb:	e8 13 ff ff ff       	call   80101f13 <iput>
}
80102000:	c9                   	leave  
80102001:	c3                   	ret    

80102002 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
80102002:	55                   	push   %ebp
80102003:	89 e5                	mov    %esp,%ebp
80102005:	53                   	push   %ebx
80102006:	83 ec 24             	sub    $0x24,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
80102009:	83 7d 0c 0b          	cmpl   $0xb,0xc(%ebp)
8010200d:	77 3e                	ja     8010204d <bmap+0x4b>
    if((addr = ip->addrs[bn]) == 0)
8010200f:	8b 45 08             	mov    0x8(%ebp),%eax
80102012:	8b 55 0c             	mov    0xc(%ebp),%edx
80102015:	83 c2 04             	add    $0x4,%edx
80102018:	8b 44 90 0c          	mov    0xc(%eax,%edx,4),%eax
8010201c:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010201f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80102023:	75 20                	jne    80102045 <bmap+0x43>
      ip->addrs[bn] = addr = balloc(ip->dev);
80102025:	8b 45 08             	mov    0x8(%ebp),%eax
80102028:	8b 00                	mov    (%eax),%eax
8010202a:	89 04 24             	mov    %eax,(%esp)
8010202d:	e8 49 f8 ff ff       	call   8010187b <balloc>
80102032:	89 45 f4             	mov    %eax,-0xc(%ebp)
80102035:	8b 45 08             	mov    0x8(%ebp),%eax
80102038:	8b 55 0c             	mov    0xc(%ebp),%edx
8010203b:	8d 4a 04             	lea    0x4(%edx),%ecx
8010203e:	8b 55 f4             	mov    -0xc(%ebp),%edx
80102041:	89 54 88 0c          	mov    %edx,0xc(%eax,%ecx,4)
    return addr;
80102045:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102048:	e9 b1 00 00 00       	jmp    801020fe <bmap+0xfc>
  }
  bn -= NDIRECT;
8010204d:	83 6d 0c 0c          	subl   $0xc,0xc(%ebp)

  if(bn < NINDIRECT){
80102051:	83 7d 0c 7f          	cmpl   $0x7f,0xc(%ebp)
80102055:	0f 87 97 00 00 00    	ja     801020f2 <bmap+0xf0>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
8010205b:	8b 45 08             	mov    0x8(%ebp),%eax
8010205e:	8b 40 4c             	mov    0x4c(%eax),%eax
80102061:	89 45 f4             	mov    %eax,-0xc(%ebp)
80102064:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80102068:	75 19                	jne    80102083 <bmap+0x81>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
8010206a:	8b 45 08             	mov    0x8(%ebp),%eax
8010206d:	8b 00                	mov    (%eax),%eax
8010206f:	89 04 24             	mov    %eax,(%esp)
80102072:	e8 04 f8 ff ff       	call   8010187b <balloc>
80102077:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010207a:	8b 45 08             	mov    0x8(%ebp),%eax
8010207d:	8b 55 f4             	mov    -0xc(%ebp),%edx
80102080:	89 50 4c             	mov    %edx,0x4c(%eax)
    bp = bread(ip->dev, addr);
80102083:	8b 45 08             	mov    0x8(%ebp),%eax
80102086:	8b 00                	mov    (%eax),%eax
80102088:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010208b:	89 54 24 04          	mov    %edx,0x4(%esp)
8010208f:	89 04 24             	mov    %eax,(%esp)
80102092:	e8 0f e1 ff ff       	call   801001a6 <bread>
80102097:	89 45 f0             	mov    %eax,-0x10(%ebp)
    a = (uint*)bp->data;
8010209a:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010209d:	83 c0 18             	add    $0x18,%eax
801020a0:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if((addr = a[bn]) == 0){
801020a3:	8b 45 0c             	mov    0xc(%ebp),%eax
801020a6:	c1 e0 02             	shl    $0x2,%eax
801020a9:	03 45 ec             	add    -0x14(%ebp),%eax
801020ac:	8b 00                	mov    (%eax),%eax
801020ae:	89 45 f4             	mov    %eax,-0xc(%ebp)
801020b1:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801020b5:	75 2b                	jne    801020e2 <bmap+0xe0>
      a[bn] = addr = balloc(ip->dev);
801020b7:	8b 45 0c             	mov    0xc(%ebp),%eax
801020ba:	c1 e0 02             	shl    $0x2,%eax
801020bd:	89 c3                	mov    %eax,%ebx
801020bf:	03 5d ec             	add    -0x14(%ebp),%ebx
801020c2:	8b 45 08             	mov    0x8(%ebp),%eax
801020c5:	8b 00                	mov    (%eax),%eax
801020c7:	89 04 24             	mov    %eax,(%esp)
801020ca:	e8 ac f7 ff ff       	call   8010187b <balloc>
801020cf:	89 45 f4             	mov    %eax,-0xc(%ebp)
801020d2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801020d5:	89 03                	mov    %eax,(%ebx)
      log_write(bp);
801020d7:	8b 45 f0             	mov    -0x10(%ebp),%eax
801020da:	89 04 24             	mov    %eax,(%esp)
801020dd:	e8 d4 16 00 00       	call   801037b6 <log_write>
    }
    brelse(bp);
801020e2:	8b 45 f0             	mov    -0x10(%ebp),%eax
801020e5:	89 04 24             	mov    %eax,(%esp)
801020e8:	e8 2a e1 ff ff       	call   80100217 <brelse>
    return addr;
801020ed:	8b 45 f4             	mov    -0xc(%ebp),%eax
801020f0:	eb 0c                	jmp    801020fe <bmap+0xfc>
  }

  panic("bmap: out of range");
801020f2:	c7 04 24 56 8f 10 80 	movl   $0x80108f56,(%esp)
801020f9:	e8 3f e4 ff ff       	call   8010053d <panic>
}
801020fe:	83 c4 24             	add    $0x24,%esp
80102101:	5b                   	pop    %ebx
80102102:	5d                   	pop    %ebp
80102103:	c3                   	ret    

80102104 <itrunc>:
// to it (no directory entries referring to it)
// and has no in-memory reference to it (is
// not an open file or current directory).
static void
itrunc(struct inode *ip)
{
80102104:	55                   	push   %ebp
80102105:	89 e5                	mov    %esp,%ebp
80102107:	83 ec 28             	sub    $0x28,%esp
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
8010210a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80102111:	eb 44                	jmp    80102157 <itrunc+0x53>
    if(ip->addrs[i]){
80102113:	8b 45 08             	mov    0x8(%ebp),%eax
80102116:	8b 55 f4             	mov    -0xc(%ebp),%edx
80102119:	83 c2 04             	add    $0x4,%edx
8010211c:	8b 44 90 0c          	mov    0xc(%eax,%edx,4),%eax
80102120:	85 c0                	test   %eax,%eax
80102122:	74 2f                	je     80102153 <itrunc+0x4f>
      bfree(ip->dev, ip->addrs[i]);
80102124:	8b 45 08             	mov    0x8(%ebp),%eax
80102127:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010212a:	83 c2 04             	add    $0x4,%edx
8010212d:	8b 54 90 0c          	mov    0xc(%eax,%edx,4),%edx
80102131:	8b 45 08             	mov    0x8(%ebp),%eax
80102134:	8b 00                	mov    (%eax),%eax
80102136:	89 54 24 04          	mov    %edx,0x4(%esp)
8010213a:	89 04 24             	mov    %eax,(%esp)
8010213d:	e8 90 f8 ff ff       	call   801019d2 <bfree>
      ip->addrs[i] = 0;
80102142:	8b 45 08             	mov    0x8(%ebp),%eax
80102145:	8b 55 f4             	mov    -0xc(%ebp),%edx
80102148:	83 c2 04             	add    $0x4,%edx
8010214b:	c7 44 90 0c 00 00 00 	movl   $0x0,0xc(%eax,%edx,4)
80102152:	00 
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80102153:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80102157:	83 7d f4 0b          	cmpl   $0xb,-0xc(%ebp)
8010215b:	7e b6                	jle    80102113 <itrunc+0xf>
      bfree(ip->dev, ip->addrs[i]);
      ip->addrs[i] = 0;
    }
  }
  
  if(ip->addrs[NDIRECT]){
8010215d:	8b 45 08             	mov    0x8(%ebp),%eax
80102160:	8b 40 4c             	mov    0x4c(%eax),%eax
80102163:	85 c0                	test   %eax,%eax
80102165:	0f 84 8f 00 00 00    	je     801021fa <itrunc+0xf6>
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
8010216b:	8b 45 08             	mov    0x8(%ebp),%eax
8010216e:	8b 50 4c             	mov    0x4c(%eax),%edx
80102171:	8b 45 08             	mov    0x8(%ebp),%eax
80102174:	8b 00                	mov    (%eax),%eax
80102176:	89 54 24 04          	mov    %edx,0x4(%esp)
8010217a:	89 04 24             	mov    %eax,(%esp)
8010217d:	e8 24 e0 ff ff       	call   801001a6 <bread>
80102182:	89 45 ec             	mov    %eax,-0x14(%ebp)
    a = (uint*)bp->data;
80102185:	8b 45 ec             	mov    -0x14(%ebp),%eax
80102188:	83 c0 18             	add    $0x18,%eax
8010218b:	89 45 e8             	mov    %eax,-0x18(%ebp)
    for(j = 0; j < NINDIRECT; j++){
8010218e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
80102195:	eb 2f                	jmp    801021c6 <itrunc+0xc2>
      if(a[j])
80102197:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010219a:	c1 e0 02             	shl    $0x2,%eax
8010219d:	03 45 e8             	add    -0x18(%ebp),%eax
801021a0:	8b 00                	mov    (%eax),%eax
801021a2:	85 c0                	test   %eax,%eax
801021a4:	74 1c                	je     801021c2 <itrunc+0xbe>
        bfree(ip->dev, a[j]);
801021a6:	8b 45 f0             	mov    -0x10(%ebp),%eax
801021a9:	c1 e0 02             	shl    $0x2,%eax
801021ac:	03 45 e8             	add    -0x18(%ebp),%eax
801021af:	8b 10                	mov    (%eax),%edx
801021b1:	8b 45 08             	mov    0x8(%ebp),%eax
801021b4:	8b 00                	mov    (%eax),%eax
801021b6:	89 54 24 04          	mov    %edx,0x4(%esp)
801021ba:	89 04 24             	mov    %eax,(%esp)
801021bd:	e8 10 f8 ff ff       	call   801019d2 <bfree>
  }
  
  if(ip->addrs[NDIRECT]){
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
    a = (uint*)bp->data;
    for(j = 0; j < NINDIRECT; j++){
801021c2:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
801021c6:	8b 45 f0             	mov    -0x10(%ebp),%eax
801021c9:	83 f8 7f             	cmp    $0x7f,%eax
801021cc:	76 c9                	jbe    80102197 <itrunc+0x93>
      if(a[j])
        bfree(ip->dev, a[j]);
    }
    brelse(bp);
801021ce:	8b 45 ec             	mov    -0x14(%ebp),%eax
801021d1:	89 04 24             	mov    %eax,(%esp)
801021d4:	e8 3e e0 ff ff       	call   80100217 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
801021d9:	8b 45 08             	mov    0x8(%ebp),%eax
801021dc:	8b 50 4c             	mov    0x4c(%eax),%edx
801021df:	8b 45 08             	mov    0x8(%ebp),%eax
801021e2:	8b 00                	mov    (%eax),%eax
801021e4:	89 54 24 04          	mov    %edx,0x4(%esp)
801021e8:	89 04 24             	mov    %eax,(%esp)
801021eb:	e8 e2 f7 ff ff       	call   801019d2 <bfree>
    ip->addrs[NDIRECT] = 0;
801021f0:	8b 45 08             	mov    0x8(%ebp),%eax
801021f3:	c7 40 4c 00 00 00 00 	movl   $0x0,0x4c(%eax)
  }

  ip->size = 0;
801021fa:	8b 45 08             	mov    0x8(%ebp),%eax
801021fd:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)
  iupdate(ip);
80102204:	8b 45 08             	mov    0x8(%ebp),%eax
80102207:	89 04 24             	mov    %eax,(%esp)
8010220a:	e8 95 f9 ff ff       	call   80101ba4 <iupdate>
}
8010220f:	c9                   	leave  
80102210:	c3                   	ret    

80102211 <stati>:

// Copy stat information from inode.
void
stati(struct inode *ip, struct stat *st)
{
80102211:	55                   	push   %ebp
80102212:	89 e5                	mov    %esp,%ebp
  st->dev = ip->dev;
80102214:	8b 45 08             	mov    0x8(%ebp),%eax
80102217:	8b 00                	mov    (%eax),%eax
80102219:	89 c2                	mov    %eax,%edx
8010221b:	8b 45 0c             	mov    0xc(%ebp),%eax
8010221e:	89 50 04             	mov    %edx,0x4(%eax)
  st->ino = ip->inum;
80102221:	8b 45 08             	mov    0x8(%ebp),%eax
80102224:	8b 50 04             	mov    0x4(%eax),%edx
80102227:	8b 45 0c             	mov    0xc(%ebp),%eax
8010222a:	89 50 08             	mov    %edx,0x8(%eax)
  st->type = ip->type;
8010222d:	8b 45 08             	mov    0x8(%ebp),%eax
80102230:	0f b7 50 10          	movzwl 0x10(%eax),%edx
80102234:	8b 45 0c             	mov    0xc(%ebp),%eax
80102237:	66 89 10             	mov    %dx,(%eax)
  st->nlink = ip->nlink;
8010223a:	8b 45 08             	mov    0x8(%ebp),%eax
8010223d:	0f b7 50 16          	movzwl 0x16(%eax),%edx
80102241:	8b 45 0c             	mov    0xc(%ebp),%eax
80102244:	66 89 50 0c          	mov    %dx,0xc(%eax)
  st->size = ip->size;
80102248:	8b 45 08             	mov    0x8(%ebp),%eax
8010224b:	8b 50 18             	mov    0x18(%eax),%edx
8010224e:	8b 45 0c             	mov    0xc(%ebp),%eax
80102251:	89 50 10             	mov    %edx,0x10(%eax)
}
80102254:	5d                   	pop    %ebp
80102255:	c3                   	ret    

80102256 <readi>:

//PAGEBREAK!
// Read data from inode.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80102256:	55                   	push   %ebp
80102257:	89 e5                	mov    %esp,%ebp
80102259:	53                   	push   %ebx
8010225a:	83 ec 24             	sub    $0x24,%esp
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
8010225d:	8b 45 08             	mov    0x8(%ebp),%eax
80102260:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80102264:	66 83 f8 03          	cmp    $0x3,%ax
80102268:	75 60                	jne    801022ca <readi+0x74>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
8010226a:	8b 45 08             	mov    0x8(%ebp),%eax
8010226d:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80102271:	66 85 c0             	test   %ax,%ax
80102274:	78 20                	js     80102296 <readi+0x40>
80102276:	8b 45 08             	mov    0x8(%ebp),%eax
80102279:	0f b7 40 12          	movzwl 0x12(%eax),%eax
8010227d:	66 83 f8 09          	cmp    $0x9,%ax
80102281:	7f 13                	jg     80102296 <readi+0x40>
80102283:	8b 45 08             	mov    0x8(%ebp),%eax
80102286:	0f b7 40 12          	movzwl 0x12(%eax),%eax
8010228a:	98                   	cwtl   
8010228b:	8b 04 c5 80 0a 11 80 	mov    -0x7feef580(,%eax,8),%eax
80102292:	85 c0                	test   %eax,%eax
80102294:	75 0a                	jne    801022a0 <readi+0x4a>
      return -1;
80102296:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010229b:	e9 1b 01 00 00       	jmp    801023bb <readi+0x165>
    return devsw[ip->major].read(ip, dst, n);
801022a0:	8b 45 08             	mov    0x8(%ebp),%eax
801022a3:	0f b7 40 12          	movzwl 0x12(%eax),%eax
801022a7:	98                   	cwtl   
801022a8:	8b 14 c5 80 0a 11 80 	mov    -0x7feef580(,%eax,8),%edx
801022af:	8b 45 14             	mov    0x14(%ebp),%eax
801022b2:	89 44 24 08          	mov    %eax,0x8(%esp)
801022b6:	8b 45 0c             	mov    0xc(%ebp),%eax
801022b9:	89 44 24 04          	mov    %eax,0x4(%esp)
801022bd:	8b 45 08             	mov    0x8(%ebp),%eax
801022c0:	89 04 24             	mov    %eax,(%esp)
801022c3:	ff d2                	call   *%edx
801022c5:	e9 f1 00 00 00       	jmp    801023bb <readi+0x165>
  }

  if(off > ip->size || off + n < off)
801022ca:	8b 45 08             	mov    0x8(%ebp),%eax
801022cd:	8b 40 18             	mov    0x18(%eax),%eax
801022d0:	3b 45 10             	cmp    0x10(%ebp),%eax
801022d3:	72 0d                	jb     801022e2 <readi+0x8c>
801022d5:	8b 45 14             	mov    0x14(%ebp),%eax
801022d8:	8b 55 10             	mov    0x10(%ebp),%edx
801022db:	01 d0                	add    %edx,%eax
801022dd:	3b 45 10             	cmp    0x10(%ebp),%eax
801022e0:	73 0a                	jae    801022ec <readi+0x96>
    return -1;
801022e2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801022e7:	e9 cf 00 00 00       	jmp    801023bb <readi+0x165>
  if(off + n > ip->size)
801022ec:	8b 45 14             	mov    0x14(%ebp),%eax
801022ef:	8b 55 10             	mov    0x10(%ebp),%edx
801022f2:	01 c2                	add    %eax,%edx
801022f4:	8b 45 08             	mov    0x8(%ebp),%eax
801022f7:	8b 40 18             	mov    0x18(%eax),%eax
801022fa:	39 c2                	cmp    %eax,%edx
801022fc:	76 0c                	jbe    8010230a <readi+0xb4>
    n = ip->size - off;
801022fe:	8b 45 08             	mov    0x8(%ebp),%eax
80102301:	8b 40 18             	mov    0x18(%eax),%eax
80102304:	2b 45 10             	sub    0x10(%ebp),%eax
80102307:	89 45 14             	mov    %eax,0x14(%ebp)

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
8010230a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80102311:	e9 96 00 00 00       	jmp    801023ac <readi+0x156>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80102316:	8b 45 10             	mov    0x10(%ebp),%eax
80102319:	c1 e8 09             	shr    $0x9,%eax
8010231c:	89 44 24 04          	mov    %eax,0x4(%esp)
80102320:	8b 45 08             	mov    0x8(%ebp),%eax
80102323:	89 04 24             	mov    %eax,(%esp)
80102326:	e8 d7 fc ff ff       	call   80102002 <bmap>
8010232b:	8b 55 08             	mov    0x8(%ebp),%edx
8010232e:	8b 12                	mov    (%edx),%edx
80102330:	89 44 24 04          	mov    %eax,0x4(%esp)
80102334:	89 14 24             	mov    %edx,(%esp)
80102337:	e8 6a de ff ff       	call   801001a6 <bread>
8010233c:	89 45 f0             	mov    %eax,-0x10(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
8010233f:	8b 45 10             	mov    0x10(%ebp),%eax
80102342:	89 c2                	mov    %eax,%edx
80102344:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
8010234a:	b8 00 02 00 00       	mov    $0x200,%eax
8010234f:	89 c1                	mov    %eax,%ecx
80102351:	29 d1                	sub    %edx,%ecx
80102353:	89 ca                	mov    %ecx,%edx
80102355:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102358:	8b 4d 14             	mov    0x14(%ebp),%ecx
8010235b:	89 cb                	mov    %ecx,%ebx
8010235d:	29 c3                	sub    %eax,%ebx
8010235f:	89 d8                	mov    %ebx,%eax
80102361:	39 c2                	cmp    %eax,%edx
80102363:	0f 46 c2             	cmovbe %edx,%eax
80102366:	89 45 ec             	mov    %eax,-0x14(%ebp)
    memmove(dst, bp->data + off%BSIZE, m);
80102369:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010236c:	8d 50 18             	lea    0x18(%eax),%edx
8010236f:	8b 45 10             	mov    0x10(%ebp),%eax
80102372:	25 ff 01 00 00       	and    $0x1ff,%eax
80102377:	01 c2                	add    %eax,%edx
80102379:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010237c:	89 44 24 08          	mov    %eax,0x8(%esp)
80102380:	89 54 24 04          	mov    %edx,0x4(%esp)
80102384:	8b 45 0c             	mov    0xc(%ebp),%eax
80102387:	89 04 24             	mov    %eax,(%esp)
8010238a:	e8 96 36 00 00       	call   80105a25 <memmove>
    brelse(bp);
8010238f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80102392:	89 04 24             	mov    %eax,(%esp)
80102395:	e8 7d de ff ff       	call   80100217 <brelse>
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
8010239a:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010239d:	01 45 f4             	add    %eax,-0xc(%ebp)
801023a0:	8b 45 ec             	mov    -0x14(%ebp),%eax
801023a3:	01 45 10             	add    %eax,0x10(%ebp)
801023a6:	8b 45 ec             	mov    -0x14(%ebp),%eax
801023a9:	01 45 0c             	add    %eax,0xc(%ebp)
801023ac:	8b 45 f4             	mov    -0xc(%ebp),%eax
801023af:	3b 45 14             	cmp    0x14(%ebp),%eax
801023b2:	0f 82 5e ff ff ff    	jb     80102316 <readi+0xc0>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(dst, bp->data + off%BSIZE, m);
    brelse(bp);
  }
  return n;
801023b8:	8b 45 14             	mov    0x14(%ebp),%eax
}
801023bb:	83 c4 24             	add    $0x24,%esp
801023be:	5b                   	pop    %ebx
801023bf:	5d                   	pop    %ebp
801023c0:	c3                   	ret    

801023c1 <writei>:

// PAGEBREAK!
// Write data to inode.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
801023c1:	55                   	push   %ebp
801023c2:	89 e5                	mov    %esp,%ebp
801023c4:	53                   	push   %ebx
801023c5:	83 ec 24             	sub    $0x24,%esp
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
801023c8:	8b 45 08             	mov    0x8(%ebp),%eax
801023cb:	0f b7 40 10          	movzwl 0x10(%eax),%eax
801023cf:	66 83 f8 03          	cmp    $0x3,%ax
801023d3:	75 60                	jne    80102435 <writei+0x74>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
801023d5:	8b 45 08             	mov    0x8(%ebp),%eax
801023d8:	0f b7 40 12          	movzwl 0x12(%eax),%eax
801023dc:	66 85 c0             	test   %ax,%ax
801023df:	78 20                	js     80102401 <writei+0x40>
801023e1:	8b 45 08             	mov    0x8(%ebp),%eax
801023e4:	0f b7 40 12          	movzwl 0x12(%eax),%eax
801023e8:	66 83 f8 09          	cmp    $0x9,%ax
801023ec:	7f 13                	jg     80102401 <writei+0x40>
801023ee:	8b 45 08             	mov    0x8(%ebp),%eax
801023f1:	0f b7 40 12          	movzwl 0x12(%eax),%eax
801023f5:	98                   	cwtl   
801023f6:	8b 04 c5 84 0a 11 80 	mov    -0x7feef57c(,%eax,8),%eax
801023fd:	85 c0                	test   %eax,%eax
801023ff:	75 0a                	jne    8010240b <writei+0x4a>
      return -1;
80102401:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102406:	e9 46 01 00 00       	jmp    80102551 <writei+0x190>
    return devsw[ip->major].write(ip, src, n);
8010240b:	8b 45 08             	mov    0x8(%ebp),%eax
8010240e:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80102412:	98                   	cwtl   
80102413:	8b 14 c5 84 0a 11 80 	mov    -0x7feef57c(,%eax,8),%edx
8010241a:	8b 45 14             	mov    0x14(%ebp),%eax
8010241d:	89 44 24 08          	mov    %eax,0x8(%esp)
80102421:	8b 45 0c             	mov    0xc(%ebp),%eax
80102424:	89 44 24 04          	mov    %eax,0x4(%esp)
80102428:	8b 45 08             	mov    0x8(%ebp),%eax
8010242b:	89 04 24             	mov    %eax,(%esp)
8010242e:	ff d2                	call   *%edx
80102430:	e9 1c 01 00 00       	jmp    80102551 <writei+0x190>
  }

  if(off > ip->size || off + n < off)
80102435:	8b 45 08             	mov    0x8(%ebp),%eax
80102438:	8b 40 18             	mov    0x18(%eax),%eax
8010243b:	3b 45 10             	cmp    0x10(%ebp),%eax
8010243e:	72 0d                	jb     8010244d <writei+0x8c>
80102440:	8b 45 14             	mov    0x14(%ebp),%eax
80102443:	8b 55 10             	mov    0x10(%ebp),%edx
80102446:	01 d0                	add    %edx,%eax
80102448:	3b 45 10             	cmp    0x10(%ebp),%eax
8010244b:	73 0a                	jae    80102457 <writei+0x96>
    return -1;
8010244d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102452:	e9 fa 00 00 00       	jmp    80102551 <writei+0x190>
  if(off + n > MAXFILE*BSIZE)
80102457:	8b 45 14             	mov    0x14(%ebp),%eax
8010245a:	8b 55 10             	mov    0x10(%ebp),%edx
8010245d:	01 d0                	add    %edx,%eax
8010245f:	3d 00 18 01 00       	cmp    $0x11800,%eax
80102464:	76 0a                	jbe    80102470 <writei+0xaf>
    return -1;
80102466:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010246b:	e9 e1 00 00 00       	jmp    80102551 <writei+0x190>

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80102470:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80102477:	e9 a1 00 00 00       	jmp    8010251d <writei+0x15c>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
8010247c:	8b 45 10             	mov    0x10(%ebp),%eax
8010247f:	c1 e8 09             	shr    $0x9,%eax
80102482:	89 44 24 04          	mov    %eax,0x4(%esp)
80102486:	8b 45 08             	mov    0x8(%ebp),%eax
80102489:	89 04 24             	mov    %eax,(%esp)
8010248c:	e8 71 fb ff ff       	call   80102002 <bmap>
80102491:	8b 55 08             	mov    0x8(%ebp),%edx
80102494:	8b 12                	mov    (%edx),%edx
80102496:	89 44 24 04          	mov    %eax,0x4(%esp)
8010249a:	89 14 24             	mov    %edx,(%esp)
8010249d:	e8 04 dd ff ff       	call   801001a6 <bread>
801024a2:	89 45 f0             	mov    %eax,-0x10(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
801024a5:	8b 45 10             	mov    0x10(%ebp),%eax
801024a8:	89 c2                	mov    %eax,%edx
801024aa:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
801024b0:	b8 00 02 00 00       	mov    $0x200,%eax
801024b5:	89 c1                	mov    %eax,%ecx
801024b7:	29 d1                	sub    %edx,%ecx
801024b9:	89 ca                	mov    %ecx,%edx
801024bb:	8b 45 f4             	mov    -0xc(%ebp),%eax
801024be:	8b 4d 14             	mov    0x14(%ebp),%ecx
801024c1:	89 cb                	mov    %ecx,%ebx
801024c3:	29 c3                	sub    %eax,%ebx
801024c5:	89 d8                	mov    %ebx,%eax
801024c7:	39 c2                	cmp    %eax,%edx
801024c9:	0f 46 c2             	cmovbe %edx,%eax
801024cc:	89 45 ec             	mov    %eax,-0x14(%ebp)
    memmove(bp->data + off%BSIZE, src, m);
801024cf:	8b 45 f0             	mov    -0x10(%ebp),%eax
801024d2:	8d 50 18             	lea    0x18(%eax),%edx
801024d5:	8b 45 10             	mov    0x10(%ebp),%eax
801024d8:	25 ff 01 00 00       	and    $0x1ff,%eax
801024dd:	01 c2                	add    %eax,%edx
801024df:	8b 45 ec             	mov    -0x14(%ebp),%eax
801024e2:	89 44 24 08          	mov    %eax,0x8(%esp)
801024e6:	8b 45 0c             	mov    0xc(%ebp),%eax
801024e9:	89 44 24 04          	mov    %eax,0x4(%esp)
801024ed:	89 14 24             	mov    %edx,(%esp)
801024f0:	e8 30 35 00 00       	call   80105a25 <memmove>
    log_write(bp);
801024f5:	8b 45 f0             	mov    -0x10(%ebp),%eax
801024f8:	89 04 24             	mov    %eax,(%esp)
801024fb:	e8 b6 12 00 00       	call   801037b6 <log_write>
    brelse(bp);
80102500:	8b 45 f0             	mov    -0x10(%ebp),%eax
80102503:	89 04 24             	mov    %eax,(%esp)
80102506:	e8 0c dd ff ff       	call   80100217 <brelse>
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > MAXFILE*BSIZE)
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
8010250b:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010250e:	01 45 f4             	add    %eax,-0xc(%ebp)
80102511:	8b 45 ec             	mov    -0x14(%ebp),%eax
80102514:	01 45 10             	add    %eax,0x10(%ebp)
80102517:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010251a:	01 45 0c             	add    %eax,0xc(%ebp)
8010251d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102520:	3b 45 14             	cmp    0x14(%ebp),%eax
80102523:	0f 82 53 ff ff ff    	jb     8010247c <writei+0xbb>
    memmove(bp->data + off%BSIZE, src, m);
    log_write(bp);
    brelse(bp);
  }

  if(n > 0 && off > ip->size){
80102529:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
8010252d:	74 1f                	je     8010254e <writei+0x18d>
8010252f:	8b 45 08             	mov    0x8(%ebp),%eax
80102532:	8b 40 18             	mov    0x18(%eax),%eax
80102535:	3b 45 10             	cmp    0x10(%ebp),%eax
80102538:	73 14                	jae    8010254e <writei+0x18d>
    ip->size = off;
8010253a:	8b 45 08             	mov    0x8(%ebp),%eax
8010253d:	8b 55 10             	mov    0x10(%ebp),%edx
80102540:	89 50 18             	mov    %edx,0x18(%eax)
    iupdate(ip);
80102543:	8b 45 08             	mov    0x8(%ebp),%eax
80102546:	89 04 24             	mov    %eax,(%esp)
80102549:	e8 56 f6 ff ff       	call   80101ba4 <iupdate>
  }
  return n;
8010254e:	8b 45 14             	mov    0x14(%ebp),%eax
}
80102551:	83 c4 24             	add    $0x24,%esp
80102554:	5b                   	pop    %ebx
80102555:	5d                   	pop    %ebp
80102556:	c3                   	ret    

80102557 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80102557:	55                   	push   %ebp
80102558:	89 e5                	mov    %esp,%ebp
8010255a:	83 ec 18             	sub    $0x18,%esp
  return strncmp(s, t, DIRSIZ);
8010255d:	c7 44 24 08 0e 00 00 	movl   $0xe,0x8(%esp)
80102564:	00 
80102565:	8b 45 0c             	mov    0xc(%ebp),%eax
80102568:	89 44 24 04          	mov    %eax,0x4(%esp)
8010256c:	8b 45 08             	mov    0x8(%ebp),%eax
8010256f:	89 04 24             	mov    %eax,(%esp)
80102572:	e8 52 35 00 00       	call   80105ac9 <strncmp>
}
80102577:	c9                   	leave  
80102578:	c3                   	ret    

80102579 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80102579:	55                   	push   %ebp
8010257a:	89 e5                	mov    %esp,%ebp
8010257c:	83 ec 38             	sub    $0x38,%esp
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
8010257f:	8b 45 08             	mov    0x8(%ebp),%eax
80102582:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80102586:	66 83 f8 01          	cmp    $0x1,%ax
8010258a:	74 0c                	je     80102598 <dirlookup+0x1f>
    panic("dirlookup not DIR");
8010258c:	c7 04 24 69 8f 10 80 	movl   $0x80108f69,(%esp)
80102593:	e8 a5 df ff ff       	call   8010053d <panic>

  for(off = 0; off < dp->size; off += sizeof(de)){
80102598:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010259f:	e9 87 00 00 00       	jmp    8010262b <dirlookup+0xb2>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801025a4:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
801025ab:	00 
801025ac:	8b 45 f4             	mov    -0xc(%ebp),%eax
801025af:	89 44 24 08          	mov    %eax,0x8(%esp)
801025b3:	8d 45 e0             	lea    -0x20(%ebp),%eax
801025b6:	89 44 24 04          	mov    %eax,0x4(%esp)
801025ba:	8b 45 08             	mov    0x8(%ebp),%eax
801025bd:	89 04 24             	mov    %eax,(%esp)
801025c0:	e8 91 fc ff ff       	call   80102256 <readi>
801025c5:	83 f8 10             	cmp    $0x10,%eax
801025c8:	74 0c                	je     801025d6 <dirlookup+0x5d>
      panic("dirlink read");
801025ca:	c7 04 24 7b 8f 10 80 	movl   $0x80108f7b,(%esp)
801025d1:	e8 67 df ff ff       	call   8010053d <panic>
    if(de.inum == 0)
801025d6:	0f b7 45 e0          	movzwl -0x20(%ebp),%eax
801025da:	66 85 c0             	test   %ax,%ax
801025dd:	74 47                	je     80102626 <dirlookup+0xad>
      continue;
    if(namecmp(name, de.name) == 0){
801025df:	8d 45 e0             	lea    -0x20(%ebp),%eax
801025e2:	83 c0 02             	add    $0x2,%eax
801025e5:	89 44 24 04          	mov    %eax,0x4(%esp)
801025e9:	8b 45 0c             	mov    0xc(%ebp),%eax
801025ec:	89 04 24             	mov    %eax,(%esp)
801025ef:	e8 63 ff ff ff       	call   80102557 <namecmp>
801025f4:	85 c0                	test   %eax,%eax
801025f6:	75 2f                	jne    80102627 <dirlookup+0xae>
      // entry matches path element
      if(poff)
801025f8:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
801025fc:	74 08                	je     80102606 <dirlookup+0x8d>
        *poff = off;
801025fe:	8b 45 10             	mov    0x10(%ebp),%eax
80102601:	8b 55 f4             	mov    -0xc(%ebp),%edx
80102604:	89 10                	mov    %edx,(%eax)
      inum = de.inum;
80102606:	0f b7 45 e0          	movzwl -0x20(%ebp),%eax
8010260a:	0f b7 c0             	movzwl %ax,%eax
8010260d:	89 45 f0             	mov    %eax,-0x10(%ebp)
      return iget(dp->dev, inum);
80102610:	8b 45 08             	mov    0x8(%ebp),%eax
80102613:	8b 00                	mov    (%eax),%eax
80102615:	8b 55 f0             	mov    -0x10(%ebp),%edx
80102618:	89 54 24 04          	mov    %edx,0x4(%esp)
8010261c:	89 04 24             	mov    %eax,(%esp)
8010261f:	e8 38 f6 ff ff       	call   80101c5c <iget>
80102624:	eb 19                	jmp    8010263f <dirlookup+0xc6>

  for(off = 0; off < dp->size; off += sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("dirlink read");
    if(de.inum == 0)
      continue;
80102626:	90                   	nop
  struct dirent de;

  if(dp->type != T_DIR)
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
80102627:	83 45 f4 10          	addl   $0x10,-0xc(%ebp)
8010262b:	8b 45 08             	mov    0x8(%ebp),%eax
8010262e:	8b 40 18             	mov    0x18(%eax),%eax
80102631:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80102634:	0f 87 6a ff ff ff    	ja     801025a4 <dirlookup+0x2b>
      inum = de.inum;
      return iget(dp->dev, inum);
    }
  }

  return 0;
8010263a:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010263f:	c9                   	leave  
80102640:	c3                   	ret    

80102641 <dirlink>:

// Write a new directory entry (name, inum) into the directory dp.
int
dirlink(struct inode *dp, char *name, uint inum)
{
80102641:	55                   	push   %ebp
80102642:	89 e5                	mov    %esp,%ebp
80102644:	83 ec 38             	sub    $0x38,%esp
  int off;
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
80102647:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
8010264e:	00 
8010264f:	8b 45 0c             	mov    0xc(%ebp),%eax
80102652:	89 44 24 04          	mov    %eax,0x4(%esp)
80102656:	8b 45 08             	mov    0x8(%ebp),%eax
80102659:	89 04 24             	mov    %eax,(%esp)
8010265c:	e8 18 ff ff ff       	call   80102579 <dirlookup>
80102661:	89 45 f0             	mov    %eax,-0x10(%ebp)
80102664:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80102668:	74 15                	je     8010267f <dirlink+0x3e>
    iput(ip);
8010266a:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010266d:	89 04 24             	mov    %eax,(%esp)
80102670:	e8 9e f8 ff ff       	call   80101f13 <iput>
    return -1;
80102675:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010267a:	e9 b8 00 00 00       	jmp    80102737 <dirlink+0xf6>
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
8010267f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80102686:	eb 44                	jmp    801026cc <dirlink+0x8b>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102688:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010268b:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
80102692:	00 
80102693:	89 44 24 08          	mov    %eax,0x8(%esp)
80102697:	8d 45 e0             	lea    -0x20(%ebp),%eax
8010269a:	89 44 24 04          	mov    %eax,0x4(%esp)
8010269e:	8b 45 08             	mov    0x8(%ebp),%eax
801026a1:	89 04 24             	mov    %eax,(%esp)
801026a4:	e8 ad fb ff ff       	call   80102256 <readi>
801026a9:	83 f8 10             	cmp    $0x10,%eax
801026ac:	74 0c                	je     801026ba <dirlink+0x79>
      panic("dirlink read");
801026ae:	c7 04 24 7b 8f 10 80 	movl   $0x80108f7b,(%esp)
801026b5:	e8 83 de ff ff       	call   8010053d <panic>
    if(de.inum == 0)
801026ba:	0f b7 45 e0          	movzwl -0x20(%ebp),%eax
801026be:	66 85 c0             	test   %ax,%ax
801026c1:	74 18                	je     801026db <dirlink+0x9a>
    iput(ip);
    return -1;
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
801026c3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801026c6:	83 c0 10             	add    $0x10,%eax
801026c9:	89 45 f4             	mov    %eax,-0xc(%ebp)
801026cc:	8b 55 f4             	mov    -0xc(%ebp),%edx
801026cf:	8b 45 08             	mov    0x8(%ebp),%eax
801026d2:	8b 40 18             	mov    0x18(%eax),%eax
801026d5:	39 c2                	cmp    %eax,%edx
801026d7:	72 af                	jb     80102688 <dirlink+0x47>
801026d9:	eb 01                	jmp    801026dc <dirlink+0x9b>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("dirlink read");
    if(de.inum == 0)
      break;
801026db:	90                   	nop
  }

  strncpy(de.name, name, DIRSIZ);
801026dc:	c7 44 24 08 0e 00 00 	movl   $0xe,0x8(%esp)
801026e3:	00 
801026e4:	8b 45 0c             	mov    0xc(%ebp),%eax
801026e7:	89 44 24 04          	mov    %eax,0x4(%esp)
801026eb:	8d 45 e0             	lea    -0x20(%ebp),%eax
801026ee:	83 c0 02             	add    $0x2,%eax
801026f1:	89 04 24             	mov    %eax,(%esp)
801026f4:	e8 28 34 00 00       	call   80105b21 <strncpy>
  de.inum = inum;
801026f9:	8b 45 10             	mov    0x10(%ebp),%eax
801026fc:	66 89 45 e0          	mov    %ax,-0x20(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102700:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102703:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
8010270a:	00 
8010270b:	89 44 24 08          	mov    %eax,0x8(%esp)
8010270f:	8d 45 e0             	lea    -0x20(%ebp),%eax
80102712:	89 44 24 04          	mov    %eax,0x4(%esp)
80102716:	8b 45 08             	mov    0x8(%ebp),%eax
80102719:	89 04 24             	mov    %eax,(%esp)
8010271c:	e8 a0 fc ff ff       	call   801023c1 <writei>
80102721:	83 f8 10             	cmp    $0x10,%eax
80102724:	74 0c                	je     80102732 <dirlink+0xf1>
    panic("dirlink");
80102726:	c7 04 24 88 8f 10 80 	movl   $0x80108f88,(%esp)
8010272d:	e8 0b de ff ff       	call   8010053d <panic>
  
  return 0;
80102732:	b8 00 00 00 00       	mov    $0x0,%eax
}
80102737:	c9                   	leave  
80102738:	c3                   	ret    

80102739 <skipelem>:
//   skipelem("a", name) = "", setting name = "a"
//   skipelem("", name) = skipelem("////", name) = 0
//
static char*
skipelem(char *path, char *name)
{
80102739:	55                   	push   %ebp
8010273a:	89 e5                	mov    %esp,%ebp
8010273c:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int len;

  while(*path == '/')
8010273f:	eb 04                	jmp    80102745 <skipelem+0xc>
    path++;
80102741:	83 45 08 01          	addl   $0x1,0x8(%ebp)
skipelem(char *path, char *name)
{
  char *s;
  int len;

  while(*path == '/')
80102745:	8b 45 08             	mov    0x8(%ebp),%eax
80102748:	0f b6 00             	movzbl (%eax),%eax
8010274b:	3c 2f                	cmp    $0x2f,%al
8010274d:	74 f2                	je     80102741 <skipelem+0x8>
    path++;
  if(*path == 0)
8010274f:	8b 45 08             	mov    0x8(%ebp),%eax
80102752:	0f b6 00             	movzbl (%eax),%eax
80102755:	84 c0                	test   %al,%al
80102757:	75 0a                	jne    80102763 <skipelem+0x2a>
    return 0;
80102759:	b8 00 00 00 00       	mov    $0x0,%eax
8010275e:	e9 86 00 00 00       	jmp    801027e9 <skipelem+0xb0>
  s = path;
80102763:	8b 45 08             	mov    0x8(%ebp),%eax
80102766:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(*path != '/' && *path != 0)
80102769:	eb 04                	jmp    8010276f <skipelem+0x36>
    path++;
8010276b:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  while(*path == '/')
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
8010276f:	8b 45 08             	mov    0x8(%ebp),%eax
80102772:	0f b6 00             	movzbl (%eax),%eax
80102775:	3c 2f                	cmp    $0x2f,%al
80102777:	74 0a                	je     80102783 <skipelem+0x4a>
80102779:	8b 45 08             	mov    0x8(%ebp),%eax
8010277c:	0f b6 00             	movzbl (%eax),%eax
8010277f:	84 c0                	test   %al,%al
80102781:	75 e8                	jne    8010276b <skipelem+0x32>
    path++;
  len = path - s;
80102783:	8b 55 08             	mov    0x8(%ebp),%edx
80102786:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102789:	89 d1                	mov    %edx,%ecx
8010278b:	29 c1                	sub    %eax,%ecx
8010278d:	89 c8                	mov    %ecx,%eax
8010278f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(len >= DIRSIZ)
80102792:	83 7d f0 0d          	cmpl   $0xd,-0x10(%ebp)
80102796:	7e 1c                	jle    801027b4 <skipelem+0x7b>
    memmove(name, s, DIRSIZ);
80102798:	c7 44 24 08 0e 00 00 	movl   $0xe,0x8(%esp)
8010279f:	00 
801027a0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801027a3:	89 44 24 04          	mov    %eax,0x4(%esp)
801027a7:	8b 45 0c             	mov    0xc(%ebp),%eax
801027aa:	89 04 24             	mov    %eax,(%esp)
801027ad:	e8 73 32 00 00       	call   80105a25 <memmove>
  else {
    memmove(name, s, len);
    name[len] = 0;
  }
  while(*path == '/')
801027b2:	eb 28                	jmp    801027dc <skipelem+0xa3>
    path++;
  len = path - s;
  if(len >= DIRSIZ)
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
801027b4:	8b 45 f0             	mov    -0x10(%ebp),%eax
801027b7:	89 44 24 08          	mov    %eax,0x8(%esp)
801027bb:	8b 45 f4             	mov    -0xc(%ebp),%eax
801027be:	89 44 24 04          	mov    %eax,0x4(%esp)
801027c2:	8b 45 0c             	mov    0xc(%ebp),%eax
801027c5:	89 04 24             	mov    %eax,(%esp)
801027c8:	e8 58 32 00 00       	call   80105a25 <memmove>
    name[len] = 0;
801027cd:	8b 45 f0             	mov    -0x10(%ebp),%eax
801027d0:	03 45 0c             	add    0xc(%ebp),%eax
801027d3:	c6 00 00             	movb   $0x0,(%eax)
  }
  while(*path == '/')
801027d6:	eb 04                	jmp    801027dc <skipelem+0xa3>
    path++;
801027d8:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
    name[len] = 0;
  }
  while(*path == '/')
801027dc:	8b 45 08             	mov    0x8(%ebp),%eax
801027df:	0f b6 00             	movzbl (%eax),%eax
801027e2:	3c 2f                	cmp    $0x2f,%al
801027e4:	74 f2                	je     801027d8 <skipelem+0x9f>
    path++;
  return path;
801027e6:	8b 45 08             	mov    0x8(%ebp),%eax
}
801027e9:	c9                   	leave  
801027ea:	c3                   	ret    

801027eb <namex>:
// Look up and return the inode for a path name.
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
static struct inode*
namex(char *path, int nameiparent, char *name)
{
801027eb:	55                   	push   %ebp
801027ec:	89 e5                	mov    %esp,%ebp
801027ee:	83 ec 28             	sub    $0x28,%esp
  struct inode *ip, *next;

  if(*path == '/')
801027f1:	8b 45 08             	mov    0x8(%ebp),%eax
801027f4:	0f b6 00             	movzbl (%eax),%eax
801027f7:	3c 2f                	cmp    $0x2f,%al
801027f9:	75 1c                	jne    80102817 <namex+0x2c>
    ip = iget(ROOTDEV, ROOTINO);
801027fb:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
80102802:	00 
80102803:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
8010280a:	e8 4d f4 ff ff       	call   80101c5c <iget>
8010280f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  else
    ip = idup(proc->cwd);

  while((path = skipelem(path, name)) != 0){
80102812:	e9 af 00 00 00       	jmp    801028c6 <namex+0xdb>
  struct inode *ip, *next;

  if(*path == '/')
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(proc->cwd);
80102817:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010281d:	8b 40 68             	mov    0x68(%eax),%eax
80102820:	89 04 24             	mov    %eax,(%esp)
80102823:	e8 06 f5 ff ff       	call   80101d2e <idup>
80102828:	89 45 f4             	mov    %eax,-0xc(%ebp)

  while((path = skipelem(path, name)) != 0){
8010282b:	e9 96 00 00 00       	jmp    801028c6 <namex+0xdb>
    ilock(ip);
80102830:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102833:	89 04 24             	mov    %eax,(%esp)
80102836:	e8 25 f5 ff ff       	call   80101d60 <ilock>
    if(ip->type != T_DIR){
8010283b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010283e:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80102842:	66 83 f8 01          	cmp    $0x1,%ax
80102846:	74 15                	je     8010285d <namex+0x72>
      iunlockput(ip);
80102848:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010284b:	89 04 24             	mov    %eax,(%esp)
8010284e:	e8 91 f7 ff ff       	call   80101fe4 <iunlockput>
      return 0;
80102853:	b8 00 00 00 00       	mov    $0x0,%eax
80102858:	e9 a3 00 00 00       	jmp    80102900 <namex+0x115>
    }
    if(nameiparent && *path == '\0'){
8010285d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
80102861:	74 1d                	je     80102880 <namex+0x95>
80102863:	8b 45 08             	mov    0x8(%ebp),%eax
80102866:	0f b6 00             	movzbl (%eax),%eax
80102869:	84 c0                	test   %al,%al
8010286b:	75 13                	jne    80102880 <namex+0x95>
      // Stop one level early.
      iunlock(ip);
8010286d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102870:	89 04 24             	mov    %eax,(%esp)
80102873:	e8 36 f6 ff ff       	call   80101eae <iunlock>
      return ip;
80102878:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010287b:	e9 80 00 00 00       	jmp    80102900 <namex+0x115>
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80102880:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
80102887:	00 
80102888:	8b 45 10             	mov    0x10(%ebp),%eax
8010288b:	89 44 24 04          	mov    %eax,0x4(%esp)
8010288f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102892:	89 04 24             	mov    %eax,(%esp)
80102895:	e8 df fc ff ff       	call   80102579 <dirlookup>
8010289a:	89 45 f0             	mov    %eax,-0x10(%ebp)
8010289d:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801028a1:	75 12                	jne    801028b5 <namex+0xca>
      iunlockput(ip);
801028a3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801028a6:	89 04 24             	mov    %eax,(%esp)
801028a9:	e8 36 f7 ff ff       	call   80101fe4 <iunlockput>
      return 0;
801028ae:	b8 00 00 00 00       	mov    $0x0,%eax
801028b3:	eb 4b                	jmp    80102900 <namex+0x115>
    }
    iunlockput(ip);
801028b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801028b8:	89 04 24             	mov    %eax,(%esp)
801028bb:	e8 24 f7 ff ff       	call   80101fe4 <iunlockput>
    ip = next;
801028c0:	8b 45 f0             	mov    -0x10(%ebp),%eax
801028c3:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(*path == '/')
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(proc->cwd);

  while((path = skipelem(path, name)) != 0){
801028c6:	8b 45 10             	mov    0x10(%ebp),%eax
801028c9:	89 44 24 04          	mov    %eax,0x4(%esp)
801028cd:	8b 45 08             	mov    0x8(%ebp),%eax
801028d0:	89 04 24             	mov    %eax,(%esp)
801028d3:	e8 61 fe ff ff       	call   80102739 <skipelem>
801028d8:	89 45 08             	mov    %eax,0x8(%ebp)
801028db:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
801028df:	0f 85 4b ff ff ff    	jne    80102830 <namex+0x45>
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
801028e5:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
801028e9:	74 12                	je     801028fd <namex+0x112>
    iput(ip);
801028eb:	8b 45 f4             	mov    -0xc(%ebp),%eax
801028ee:	89 04 24             	mov    %eax,(%esp)
801028f1:	e8 1d f6 ff ff       	call   80101f13 <iput>
    return 0;
801028f6:	b8 00 00 00 00       	mov    $0x0,%eax
801028fb:	eb 03                	jmp    80102900 <namex+0x115>
  }
  return ip;
801028fd:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80102900:	c9                   	leave  
80102901:	c3                   	ret    

80102902 <namei>:

struct inode*
namei(char *path)
{
80102902:	55                   	push   %ebp
80102903:	89 e5                	mov    %esp,%ebp
80102905:	83 ec 28             	sub    $0x28,%esp
  char name[DIRSIZ];
  return namex(path, 0, name);
80102908:	8d 45 ea             	lea    -0x16(%ebp),%eax
8010290b:	89 44 24 08          	mov    %eax,0x8(%esp)
8010290f:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80102916:	00 
80102917:	8b 45 08             	mov    0x8(%ebp),%eax
8010291a:	89 04 24             	mov    %eax,(%esp)
8010291d:	e8 c9 fe ff ff       	call   801027eb <namex>
}
80102922:	c9                   	leave  
80102923:	c3                   	ret    

80102924 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
80102924:	55                   	push   %ebp
80102925:	89 e5                	mov    %esp,%ebp
80102927:	83 ec 18             	sub    $0x18,%esp
  return namex(path, 1, name);
8010292a:	8b 45 0c             	mov    0xc(%ebp),%eax
8010292d:	89 44 24 08          	mov    %eax,0x8(%esp)
80102931:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
80102938:	00 
80102939:	8b 45 08             	mov    0x8(%ebp),%eax
8010293c:	89 04 24             	mov    %eax,(%esp)
8010293f:	e8 a7 fe ff ff       	call   801027eb <namex>
}
80102944:	c9                   	leave  
80102945:	c3                   	ret    
	...

80102948 <inb>:
// Routines to let C code use special x86 instructions.

static inline uchar
inb(ushort port)
{
80102948:	55                   	push   %ebp
80102949:	89 e5                	mov    %esp,%ebp
8010294b:	53                   	push   %ebx
8010294c:	83 ec 14             	sub    $0x14,%esp
8010294f:	8b 45 08             	mov    0x8(%ebp),%eax
80102952:	66 89 45 e8          	mov    %ax,-0x18(%ebp)
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102956:	0f b7 55 e8          	movzwl -0x18(%ebp),%edx
8010295a:	66 89 55 ea          	mov    %dx,-0x16(%ebp)
8010295e:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
80102962:	ec                   	in     (%dx),%al
80102963:	89 c3                	mov    %eax,%ebx
80102965:	88 5d fb             	mov    %bl,-0x5(%ebp)
  return data;
80102968:	0f b6 45 fb          	movzbl -0x5(%ebp),%eax
}
8010296c:	83 c4 14             	add    $0x14,%esp
8010296f:	5b                   	pop    %ebx
80102970:	5d                   	pop    %ebp
80102971:	c3                   	ret    

80102972 <insl>:

static inline void
insl(int port, void *addr, int cnt)
{
80102972:	55                   	push   %ebp
80102973:	89 e5                	mov    %esp,%ebp
80102975:	57                   	push   %edi
80102976:	53                   	push   %ebx
  asm volatile("cld; rep insl" :
80102977:	8b 55 08             	mov    0x8(%ebp),%edx
8010297a:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010297d:	8b 45 10             	mov    0x10(%ebp),%eax
80102980:	89 cb                	mov    %ecx,%ebx
80102982:	89 df                	mov    %ebx,%edi
80102984:	89 c1                	mov    %eax,%ecx
80102986:	fc                   	cld    
80102987:	f3 6d                	rep insl (%dx),%es:(%edi)
80102989:	89 c8                	mov    %ecx,%eax
8010298b:	89 fb                	mov    %edi,%ebx
8010298d:	89 5d 0c             	mov    %ebx,0xc(%ebp)
80102990:	89 45 10             	mov    %eax,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "d" (port), "0" (addr), "1" (cnt) :
               "memory", "cc");
}
80102993:	5b                   	pop    %ebx
80102994:	5f                   	pop    %edi
80102995:	5d                   	pop    %ebp
80102996:	c3                   	ret    

80102997 <outb>:

static inline void
outb(ushort port, uchar data)
{
80102997:	55                   	push   %ebp
80102998:	89 e5                	mov    %esp,%ebp
8010299a:	83 ec 08             	sub    $0x8,%esp
8010299d:	8b 55 08             	mov    0x8(%ebp),%edx
801029a0:	8b 45 0c             	mov    0xc(%ebp),%eax
801029a3:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
801029a7:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801029aa:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
801029ae:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
801029b2:	ee                   	out    %al,(%dx)
}
801029b3:	c9                   	leave  
801029b4:	c3                   	ret    

801029b5 <outsl>:
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
}

static inline void
outsl(int port, const void *addr, int cnt)
{
801029b5:	55                   	push   %ebp
801029b6:	89 e5                	mov    %esp,%ebp
801029b8:	56                   	push   %esi
801029b9:	53                   	push   %ebx
  asm volatile("cld; rep outsl" :
801029ba:	8b 55 08             	mov    0x8(%ebp),%edx
801029bd:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801029c0:	8b 45 10             	mov    0x10(%ebp),%eax
801029c3:	89 cb                	mov    %ecx,%ebx
801029c5:	89 de                	mov    %ebx,%esi
801029c7:	89 c1                	mov    %eax,%ecx
801029c9:	fc                   	cld    
801029ca:	f3 6f                	rep outsl %ds:(%esi),(%dx)
801029cc:	89 c8                	mov    %ecx,%eax
801029ce:	89 f3                	mov    %esi,%ebx
801029d0:	89 5d 0c             	mov    %ebx,0xc(%ebp)
801029d3:	89 45 10             	mov    %eax,0x10(%ebp)
               "=S" (addr), "=c" (cnt) :
               "d" (port), "0" (addr), "1" (cnt) :
               "cc");
}
801029d6:	5b                   	pop    %ebx
801029d7:	5e                   	pop    %esi
801029d8:	5d                   	pop    %ebp
801029d9:	c3                   	ret    

801029da <idewait>:
static void idestart(struct buf*);

// Wait for IDE disk to become ready.
static int
idewait(int checkerr)
{
801029da:	55                   	push   %ebp
801029db:	89 e5                	mov    %esp,%ebp
801029dd:	83 ec 14             	sub    $0x14,%esp
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY) 
801029e0:	90                   	nop
801029e1:	c7 04 24 f7 01 00 00 	movl   $0x1f7,(%esp)
801029e8:	e8 5b ff ff ff       	call   80102948 <inb>
801029ed:	0f b6 c0             	movzbl %al,%eax
801029f0:	89 45 fc             	mov    %eax,-0x4(%ebp)
801029f3:	8b 45 fc             	mov    -0x4(%ebp),%eax
801029f6:	25 c0 00 00 00       	and    $0xc0,%eax
801029fb:	83 f8 40             	cmp    $0x40,%eax
801029fe:	75 e1                	jne    801029e1 <idewait+0x7>
    ;
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
80102a00:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80102a04:	74 11                	je     80102a17 <idewait+0x3d>
80102a06:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102a09:	83 e0 21             	and    $0x21,%eax
80102a0c:	85 c0                	test   %eax,%eax
80102a0e:	74 07                	je     80102a17 <idewait+0x3d>
    return -1;
80102a10:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102a15:	eb 05                	jmp    80102a1c <idewait+0x42>
  return 0;
80102a17:	b8 00 00 00 00       	mov    $0x0,%eax
}
80102a1c:	c9                   	leave  
80102a1d:	c3                   	ret    

80102a1e <ideinit>:

void
ideinit(void)
{
80102a1e:	55                   	push   %ebp
80102a1f:	89 e5                	mov    %esp,%ebp
80102a21:	83 ec 28             	sub    $0x28,%esp
  int i;

  initlock(&idelock, "ide");
80102a24:	c7 44 24 04 90 8f 10 	movl   $0x80108f90,0x4(%esp)
80102a2b:	80 
80102a2c:	c7 04 24 40 ce 10 80 	movl   $0x8010ce40,(%esp)
80102a33:	e8 aa 2c 00 00       	call   801056e2 <initlock>
  picenable(IRQ_IDE);
80102a38:	c7 04 24 0e 00 00 00 	movl   $0xe,(%esp)
80102a3f:	e8 75 15 00 00       	call   80103fb9 <picenable>
  ioapicenable(IRQ_IDE, ncpu - 1);
80102a44:	a1 80 21 11 80       	mov    0x80112180,%eax
80102a49:	83 e8 01             	sub    $0x1,%eax
80102a4c:	89 44 24 04          	mov    %eax,0x4(%esp)
80102a50:	c7 04 24 0e 00 00 00 	movl   $0xe,(%esp)
80102a57:	e8 12 04 00 00       	call   80102e6e <ioapicenable>
  idewait(0);
80102a5c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80102a63:	e8 72 ff ff ff       	call   801029da <idewait>
  
  // Check if disk 1 is present
  outb(0x1f6, 0xe0 | (1<<4));
80102a68:	c7 44 24 04 f0 00 00 	movl   $0xf0,0x4(%esp)
80102a6f:	00 
80102a70:	c7 04 24 f6 01 00 00 	movl   $0x1f6,(%esp)
80102a77:	e8 1b ff ff ff       	call   80102997 <outb>
  for(i=0; i<1000; i++){
80102a7c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80102a83:	eb 20                	jmp    80102aa5 <ideinit+0x87>
    if(inb(0x1f7) != 0){
80102a85:	c7 04 24 f7 01 00 00 	movl   $0x1f7,(%esp)
80102a8c:	e8 b7 fe ff ff       	call   80102948 <inb>
80102a91:	84 c0                	test   %al,%al
80102a93:	74 0c                	je     80102aa1 <ideinit+0x83>
      havedisk1 = 1;
80102a95:	c7 05 78 ce 10 80 01 	movl   $0x1,0x8010ce78
80102a9c:	00 00 00 
      break;
80102a9f:	eb 0d                	jmp    80102aae <ideinit+0x90>
  ioapicenable(IRQ_IDE, ncpu - 1);
  idewait(0);
  
  // Check if disk 1 is present
  outb(0x1f6, 0xe0 | (1<<4));
  for(i=0; i<1000; i++){
80102aa1:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80102aa5:	81 7d f4 e7 03 00 00 	cmpl   $0x3e7,-0xc(%ebp)
80102aac:	7e d7                	jle    80102a85 <ideinit+0x67>
      break;
    }
  }
  
  // Switch back to disk 0.
  outb(0x1f6, 0xe0 | (0<<4));
80102aae:	c7 44 24 04 e0 00 00 	movl   $0xe0,0x4(%esp)
80102ab5:	00 
80102ab6:	c7 04 24 f6 01 00 00 	movl   $0x1f6,(%esp)
80102abd:	e8 d5 fe ff ff       	call   80102997 <outb>
}
80102ac2:	c9                   	leave  
80102ac3:	c3                   	ret    

80102ac4 <idestart>:

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80102ac4:	55                   	push   %ebp
80102ac5:	89 e5                	mov    %esp,%ebp
80102ac7:	83 ec 18             	sub    $0x18,%esp
  if(b == 0)
80102aca:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80102ace:	75 0c                	jne    80102adc <idestart+0x18>
    panic("idestart");
80102ad0:	c7 04 24 94 8f 10 80 	movl   $0x80108f94,(%esp)
80102ad7:	e8 61 da ff ff       	call   8010053d <panic>

  idewait(0);
80102adc:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80102ae3:	e8 f2 fe ff ff       	call   801029da <idewait>
  outb(0x3f6, 0);  // generate interrupt
80102ae8:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80102aef:	00 
80102af0:	c7 04 24 f6 03 00 00 	movl   $0x3f6,(%esp)
80102af7:	e8 9b fe ff ff       	call   80102997 <outb>
  outb(0x1f2, 1);  // number of sectors
80102afc:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
80102b03:	00 
80102b04:	c7 04 24 f2 01 00 00 	movl   $0x1f2,(%esp)
80102b0b:	e8 87 fe ff ff       	call   80102997 <outb>
  outb(0x1f3, b->sector & 0xff);
80102b10:	8b 45 08             	mov    0x8(%ebp),%eax
80102b13:	8b 40 08             	mov    0x8(%eax),%eax
80102b16:	0f b6 c0             	movzbl %al,%eax
80102b19:	89 44 24 04          	mov    %eax,0x4(%esp)
80102b1d:	c7 04 24 f3 01 00 00 	movl   $0x1f3,(%esp)
80102b24:	e8 6e fe ff ff       	call   80102997 <outb>
  outb(0x1f4, (b->sector >> 8) & 0xff);
80102b29:	8b 45 08             	mov    0x8(%ebp),%eax
80102b2c:	8b 40 08             	mov    0x8(%eax),%eax
80102b2f:	c1 e8 08             	shr    $0x8,%eax
80102b32:	0f b6 c0             	movzbl %al,%eax
80102b35:	89 44 24 04          	mov    %eax,0x4(%esp)
80102b39:	c7 04 24 f4 01 00 00 	movl   $0x1f4,(%esp)
80102b40:	e8 52 fe ff ff       	call   80102997 <outb>
  outb(0x1f5, (b->sector >> 16) & 0xff);
80102b45:	8b 45 08             	mov    0x8(%ebp),%eax
80102b48:	8b 40 08             	mov    0x8(%eax),%eax
80102b4b:	c1 e8 10             	shr    $0x10,%eax
80102b4e:	0f b6 c0             	movzbl %al,%eax
80102b51:	89 44 24 04          	mov    %eax,0x4(%esp)
80102b55:	c7 04 24 f5 01 00 00 	movl   $0x1f5,(%esp)
80102b5c:	e8 36 fe ff ff       	call   80102997 <outb>
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((b->sector>>24)&0x0f));
80102b61:	8b 45 08             	mov    0x8(%ebp),%eax
80102b64:	8b 40 04             	mov    0x4(%eax),%eax
80102b67:	83 e0 01             	and    $0x1,%eax
80102b6a:	89 c2                	mov    %eax,%edx
80102b6c:	c1 e2 04             	shl    $0x4,%edx
80102b6f:	8b 45 08             	mov    0x8(%ebp),%eax
80102b72:	8b 40 08             	mov    0x8(%eax),%eax
80102b75:	c1 e8 18             	shr    $0x18,%eax
80102b78:	83 e0 0f             	and    $0xf,%eax
80102b7b:	09 d0                	or     %edx,%eax
80102b7d:	83 c8 e0             	or     $0xffffffe0,%eax
80102b80:	0f b6 c0             	movzbl %al,%eax
80102b83:	89 44 24 04          	mov    %eax,0x4(%esp)
80102b87:	c7 04 24 f6 01 00 00 	movl   $0x1f6,(%esp)
80102b8e:	e8 04 fe ff ff       	call   80102997 <outb>
  if(b->flags & B_DIRTY){
80102b93:	8b 45 08             	mov    0x8(%ebp),%eax
80102b96:	8b 00                	mov    (%eax),%eax
80102b98:	83 e0 04             	and    $0x4,%eax
80102b9b:	85 c0                	test   %eax,%eax
80102b9d:	74 34                	je     80102bd3 <idestart+0x10f>
    outb(0x1f7, IDE_CMD_WRITE);
80102b9f:	c7 44 24 04 30 00 00 	movl   $0x30,0x4(%esp)
80102ba6:	00 
80102ba7:	c7 04 24 f7 01 00 00 	movl   $0x1f7,(%esp)
80102bae:	e8 e4 fd ff ff       	call   80102997 <outb>
    outsl(0x1f0, b->data, 512/4);
80102bb3:	8b 45 08             	mov    0x8(%ebp),%eax
80102bb6:	83 c0 18             	add    $0x18,%eax
80102bb9:	c7 44 24 08 80 00 00 	movl   $0x80,0x8(%esp)
80102bc0:	00 
80102bc1:	89 44 24 04          	mov    %eax,0x4(%esp)
80102bc5:	c7 04 24 f0 01 00 00 	movl   $0x1f0,(%esp)
80102bcc:	e8 e4 fd ff ff       	call   801029b5 <outsl>
80102bd1:	eb 14                	jmp    80102be7 <idestart+0x123>
  } else {
    outb(0x1f7, IDE_CMD_READ);
80102bd3:	c7 44 24 04 20 00 00 	movl   $0x20,0x4(%esp)
80102bda:	00 
80102bdb:	c7 04 24 f7 01 00 00 	movl   $0x1f7,(%esp)
80102be2:	e8 b0 fd ff ff       	call   80102997 <outb>
  }
}
80102be7:	c9                   	leave  
80102be8:	c3                   	ret    

80102be9 <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
80102be9:	55                   	push   %ebp
80102bea:	89 e5                	mov    %esp,%ebp
80102bec:	83 ec 28             	sub    $0x28,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
80102bef:	c7 04 24 40 ce 10 80 	movl   $0x8010ce40,(%esp)
80102bf6:	e8 08 2b 00 00       	call   80105703 <acquire>
  if((b = idequeue) == 0){
80102bfb:	a1 74 ce 10 80       	mov    0x8010ce74,%eax
80102c00:	89 45 f4             	mov    %eax,-0xc(%ebp)
80102c03:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80102c07:	75 11                	jne    80102c1a <ideintr+0x31>
    release(&idelock);
80102c09:	c7 04 24 40 ce 10 80 	movl   $0x8010ce40,(%esp)
80102c10:	e8 50 2b 00 00       	call   80105765 <release>
    // cprintf("spurious IDE interrupt\n");
    return;
80102c15:	e9 90 00 00 00       	jmp    80102caa <ideintr+0xc1>
  }
  idequeue = b->qnext;
80102c1a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102c1d:	8b 40 14             	mov    0x14(%eax),%eax
80102c20:	a3 74 ce 10 80       	mov    %eax,0x8010ce74

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
80102c25:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102c28:	8b 00                	mov    (%eax),%eax
80102c2a:	83 e0 04             	and    $0x4,%eax
80102c2d:	85 c0                	test   %eax,%eax
80102c2f:	75 2e                	jne    80102c5f <ideintr+0x76>
80102c31:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80102c38:	e8 9d fd ff ff       	call   801029da <idewait>
80102c3d:	85 c0                	test   %eax,%eax
80102c3f:	78 1e                	js     80102c5f <ideintr+0x76>
    insl(0x1f0, b->data, 512/4);
80102c41:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102c44:	83 c0 18             	add    $0x18,%eax
80102c47:	c7 44 24 08 80 00 00 	movl   $0x80,0x8(%esp)
80102c4e:	00 
80102c4f:	89 44 24 04          	mov    %eax,0x4(%esp)
80102c53:	c7 04 24 f0 01 00 00 	movl   $0x1f0,(%esp)
80102c5a:	e8 13 fd ff ff       	call   80102972 <insl>
  
  // Wake process waiting for this buf.
  b->flags |= B_VALID;
80102c5f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102c62:	8b 00                	mov    (%eax),%eax
80102c64:	89 c2                	mov    %eax,%edx
80102c66:	83 ca 02             	or     $0x2,%edx
80102c69:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102c6c:	89 10                	mov    %edx,(%eax)
  b->flags &= ~B_DIRTY;
80102c6e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102c71:	8b 00                	mov    (%eax),%eax
80102c73:	89 c2                	mov    %eax,%edx
80102c75:	83 e2 fb             	and    $0xfffffffb,%edx
80102c78:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102c7b:	89 10                	mov    %edx,(%eax)
  wakeup(b);
80102c7d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102c80:	89 04 24             	mov    %eax,(%esp)
80102c83:	e8 6d 27 00 00       	call   801053f5 <wakeup>
  
  // Start disk on next buf in queue.
  if(idequeue != 0)
80102c88:	a1 74 ce 10 80       	mov    0x8010ce74,%eax
80102c8d:	85 c0                	test   %eax,%eax
80102c8f:	74 0d                	je     80102c9e <ideintr+0xb5>
    idestart(idequeue);
80102c91:	a1 74 ce 10 80       	mov    0x8010ce74,%eax
80102c96:	89 04 24             	mov    %eax,(%esp)
80102c99:	e8 26 fe ff ff       	call   80102ac4 <idestart>

  release(&idelock);
80102c9e:	c7 04 24 40 ce 10 80 	movl   $0x8010ce40,(%esp)
80102ca5:	e8 bb 2a 00 00       	call   80105765 <release>
}
80102caa:	c9                   	leave  
80102cab:	c3                   	ret    

80102cac <iderw>:
// Sync buf with disk. 
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
80102cac:	55                   	push   %ebp
80102cad:	89 e5                	mov    %esp,%ebp
80102caf:	83 ec 28             	sub    $0x28,%esp
  struct buf **pp;

  if(!(b->flags & B_BUSY))
80102cb2:	8b 45 08             	mov    0x8(%ebp),%eax
80102cb5:	8b 00                	mov    (%eax),%eax
80102cb7:	83 e0 01             	and    $0x1,%eax
80102cba:	85 c0                	test   %eax,%eax
80102cbc:	75 0c                	jne    80102cca <iderw+0x1e>
    panic("iderw: buf not busy");
80102cbe:	c7 04 24 9d 8f 10 80 	movl   $0x80108f9d,(%esp)
80102cc5:	e8 73 d8 ff ff       	call   8010053d <panic>
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
80102cca:	8b 45 08             	mov    0x8(%ebp),%eax
80102ccd:	8b 00                	mov    (%eax),%eax
80102ccf:	83 e0 06             	and    $0x6,%eax
80102cd2:	83 f8 02             	cmp    $0x2,%eax
80102cd5:	75 0c                	jne    80102ce3 <iderw+0x37>
    panic("iderw: nothing to do");
80102cd7:	c7 04 24 b1 8f 10 80 	movl   $0x80108fb1,(%esp)
80102cde:	e8 5a d8 ff ff       	call   8010053d <panic>
  if(b->dev != 0 && !havedisk1)
80102ce3:	8b 45 08             	mov    0x8(%ebp),%eax
80102ce6:	8b 40 04             	mov    0x4(%eax),%eax
80102ce9:	85 c0                	test   %eax,%eax
80102ceb:	74 15                	je     80102d02 <iderw+0x56>
80102ced:	a1 78 ce 10 80       	mov    0x8010ce78,%eax
80102cf2:	85 c0                	test   %eax,%eax
80102cf4:	75 0c                	jne    80102d02 <iderw+0x56>
    panic("iderw: ide disk 1 not present");
80102cf6:	c7 04 24 c6 8f 10 80 	movl   $0x80108fc6,(%esp)
80102cfd:	e8 3b d8 ff ff       	call   8010053d <panic>

  acquire(&idelock);  //DOC: acquire-lock
80102d02:	c7 04 24 40 ce 10 80 	movl   $0x8010ce40,(%esp)
80102d09:	e8 f5 29 00 00       	call   80105703 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
80102d0e:	8b 45 08             	mov    0x8(%ebp),%eax
80102d11:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC: insert-queue
80102d18:	c7 45 f4 74 ce 10 80 	movl   $0x8010ce74,-0xc(%ebp)
80102d1f:	eb 0b                	jmp    80102d2c <iderw+0x80>
80102d21:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102d24:	8b 00                	mov    (%eax),%eax
80102d26:	83 c0 14             	add    $0x14,%eax
80102d29:	89 45 f4             	mov    %eax,-0xc(%ebp)
80102d2c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102d2f:	8b 00                	mov    (%eax),%eax
80102d31:	85 c0                	test   %eax,%eax
80102d33:	75 ec                	jne    80102d21 <iderw+0x75>
    ;
  *pp = b;
80102d35:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102d38:	8b 55 08             	mov    0x8(%ebp),%edx
80102d3b:	89 10                	mov    %edx,(%eax)
  
  // Start disk if necessary.
  if(idequeue == b)
80102d3d:	a1 74 ce 10 80       	mov    0x8010ce74,%eax
80102d42:	3b 45 08             	cmp    0x8(%ebp),%eax
80102d45:	75 22                	jne    80102d69 <iderw+0xbd>
    idestart(b);
80102d47:	8b 45 08             	mov    0x8(%ebp),%eax
80102d4a:	89 04 24             	mov    %eax,(%esp)
80102d4d:	e8 72 fd ff ff       	call   80102ac4 <idestart>
  
  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
80102d52:	eb 15                	jmp    80102d69 <iderw+0xbd>
    sleep(b, &idelock);
80102d54:	c7 44 24 04 40 ce 10 	movl   $0x8010ce40,0x4(%esp)
80102d5b:	80 
80102d5c:	8b 45 08             	mov    0x8(%ebp),%eax
80102d5f:	89 04 24             	mov    %eax,(%esp)
80102d62:	e8 a0 25 00 00       	call   80105307 <sleep>
80102d67:	eb 01                	jmp    80102d6a <iderw+0xbe>
  // Start disk if necessary.
  if(idequeue == b)
    idestart(b);
  
  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
80102d69:	90                   	nop
80102d6a:	8b 45 08             	mov    0x8(%ebp),%eax
80102d6d:	8b 00                	mov    (%eax),%eax
80102d6f:	83 e0 06             	and    $0x6,%eax
80102d72:	83 f8 02             	cmp    $0x2,%eax
80102d75:	75 dd                	jne    80102d54 <iderw+0xa8>
    sleep(b, &idelock);
  }

  release(&idelock);
80102d77:	c7 04 24 40 ce 10 80 	movl   $0x8010ce40,(%esp)
80102d7e:	e8 e2 29 00 00       	call   80105765 <release>
}
80102d83:	c9                   	leave  
80102d84:	c3                   	ret    
80102d85:	00 00                	add    %al,(%eax)
	...

80102d88 <ioapicread>:
  uint data;
};

static uint
ioapicread(int reg)
{
80102d88:	55                   	push   %ebp
80102d89:	89 e5                	mov    %esp,%ebp
  ioapic->reg = reg;
80102d8b:	a1 b4 1a 11 80       	mov    0x80111ab4,%eax
80102d90:	8b 55 08             	mov    0x8(%ebp),%edx
80102d93:	89 10                	mov    %edx,(%eax)
  return ioapic->data;
80102d95:	a1 b4 1a 11 80       	mov    0x80111ab4,%eax
80102d9a:	8b 40 10             	mov    0x10(%eax),%eax
}
80102d9d:	5d                   	pop    %ebp
80102d9e:	c3                   	ret    

80102d9f <ioapicwrite>:

static void
ioapicwrite(int reg, uint data)
{
80102d9f:	55                   	push   %ebp
80102da0:	89 e5                	mov    %esp,%ebp
  ioapic->reg = reg;
80102da2:	a1 b4 1a 11 80       	mov    0x80111ab4,%eax
80102da7:	8b 55 08             	mov    0x8(%ebp),%edx
80102daa:	89 10                	mov    %edx,(%eax)
  ioapic->data = data;
80102dac:	a1 b4 1a 11 80       	mov    0x80111ab4,%eax
80102db1:	8b 55 0c             	mov    0xc(%ebp),%edx
80102db4:	89 50 10             	mov    %edx,0x10(%eax)
}
80102db7:	5d                   	pop    %ebp
80102db8:	c3                   	ret    

80102db9 <ioapicinit>:

void
ioapicinit(void)
{
80102db9:	55                   	push   %ebp
80102dba:	89 e5                	mov    %esp,%ebp
80102dbc:	83 ec 28             	sub    $0x28,%esp
  int i, id, maxintr;

  if(!ismp)
80102dbf:	a1 84 1b 11 80       	mov    0x80111b84,%eax
80102dc4:	85 c0                	test   %eax,%eax
80102dc6:	0f 84 9f 00 00 00    	je     80102e6b <ioapicinit+0xb2>
    return;

  ioapic = (volatile struct ioapic*)IOAPIC;
80102dcc:	c7 05 b4 1a 11 80 00 	movl   $0xfec00000,0x80111ab4
80102dd3:	00 c0 fe 
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
80102dd6:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80102ddd:	e8 a6 ff ff ff       	call   80102d88 <ioapicread>
80102de2:	c1 e8 10             	shr    $0x10,%eax
80102de5:	25 ff 00 00 00       	and    $0xff,%eax
80102dea:	89 45 f0             	mov    %eax,-0x10(%ebp)
  id = ioapicread(REG_ID) >> 24;
80102ded:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80102df4:	e8 8f ff ff ff       	call   80102d88 <ioapicread>
80102df9:	c1 e8 18             	shr    $0x18,%eax
80102dfc:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if(id != ioapicid)
80102dff:	0f b6 05 80 1b 11 80 	movzbl 0x80111b80,%eax
80102e06:	0f b6 c0             	movzbl %al,%eax
80102e09:	3b 45 ec             	cmp    -0x14(%ebp),%eax
80102e0c:	74 0c                	je     80102e1a <ioapicinit+0x61>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
80102e0e:	c7 04 24 e4 8f 10 80 	movl   $0x80108fe4,(%esp)
80102e15:	e8 87 d5 ff ff       	call   801003a1 <cprintf>

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
80102e1a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80102e21:	eb 3e                	jmp    80102e61 <ioapicinit+0xa8>
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
80102e23:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102e26:	83 c0 20             	add    $0x20,%eax
80102e29:	0d 00 00 01 00       	or     $0x10000,%eax
80102e2e:	8b 55 f4             	mov    -0xc(%ebp),%edx
80102e31:	83 c2 08             	add    $0x8,%edx
80102e34:	01 d2                	add    %edx,%edx
80102e36:	89 44 24 04          	mov    %eax,0x4(%esp)
80102e3a:	89 14 24             	mov    %edx,(%esp)
80102e3d:	e8 5d ff ff ff       	call   80102d9f <ioapicwrite>
    ioapicwrite(REG_TABLE+2*i+1, 0);
80102e42:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102e45:	83 c0 08             	add    $0x8,%eax
80102e48:	01 c0                	add    %eax,%eax
80102e4a:	83 c0 01             	add    $0x1,%eax
80102e4d:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80102e54:	00 
80102e55:	89 04 24             	mov    %eax,(%esp)
80102e58:	e8 42 ff ff ff       	call   80102d9f <ioapicwrite>
  if(id != ioapicid)
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
80102e5d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80102e61:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102e64:	3b 45 f0             	cmp    -0x10(%ebp),%eax
80102e67:	7e ba                	jle    80102e23 <ioapicinit+0x6a>
80102e69:	eb 01                	jmp    80102e6c <ioapicinit+0xb3>
ioapicinit(void)
{
  int i, id, maxintr;

  if(!ismp)
    return;
80102e6b:	90                   	nop
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
80102e6c:	c9                   	leave  
80102e6d:	c3                   	ret    

80102e6e <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
80102e6e:	55                   	push   %ebp
80102e6f:	89 e5                	mov    %esp,%ebp
80102e71:	83 ec 08             	sub    $0x8,%esp
  if(!ismp)
80102e74:	a1 84 1b 11 80       	mov    0x80111b84,%eax
80102e79:	85 c0                	test   %eax,%eax
80102e7b:	74 39                	je     80102eb6 <ioapicenable+0x48>
    return;

  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
80102e7d:	8b 45 08             	mov    0x8(%ebp),%eax
80102e80:	83 c0 20             	add    $0x20,%eax
80102e83:	8b 55 08             	mov    0x8(%ebp),%edx
80102e86:	83 c2 08             	add    $0x8,%edx
80102e89:	01 d2                	add    %edx,%edx
80102e8b:	89 44 24 04          	mov    %eax,0x4(%esp)
80102e8f:	89 14 24             	mov    %edx,(%esp)
80102e92:	e8 08 ff ff ff       	call   80102d9f <ioapicwrite>
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
80102e97:	8b 45 0c             	mov    0xc(%ebp),%eax
80102e9a:	c1 e0 18             	shl    $0x18,%eax
80102e9d:	8b 55 08             	mov    0x8(%ebp),%edx
80102ea0:	83 c2 08             	add    $0x8,%edx
80102ea3:	01 d2                	add    %edx,%edx
80102ea5:	83 c2 01             	add    $0x1,%edx
80102ea8:	89 44 24 04          	mov    %eax,0x4(%esp)
80102eac:	89 14 24             	mov    %edx,(%esp)
80102eaf:	e8 eb fe ff ff       	call   80102d9f <ioapicwrite>
80102eb4:	eb 01                	jmp    80102eb7 <ioapicenable+0x49>

void
ioapicenable(int irq, int cpunum)
{
  if(!ismp)
    return;
80102eb6:	90                   	nop
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
}
80102eb7:	c9                   	leave  
80102eb8:	c3                   	ret    
80102eb9:	00 00                	add    %al,(%eax)
	...

80102ebc <v2p>:
#define KERNBASE 0x80000000         // First kernel virtual address
#define KERNLINK (KERNBASE+EXTMEM)  // Address where kernel is linked

#ifndef __ASSEMBLER__

static inline uint v2p(void *a) { return ((uint) (a))  - KERNBASE; }
80102ebc:	55                   	push   %ebp
80102ebd:	89 e5                	mov    %esp,%ebp
80102ebf:	8b 45 08             	mov    0x8(%ebp),%eax
80102ec2:	05 00 00 00 80       	add    $0x80000000,%eax
80102ec7:	5d                   	pop    %ebp
80102ec8:	c3                   	ret    

80102ec9 <kinit1>:
// the pages mapped by entrypgdir on free list.
// 2. main() calls kinit2() with the rest of the physical pages
// after installing a full page table that maps them on all cores.
void
kinit1(void *vstart, void *vend)
{
80102ec9:	55                   	push   %ebp
80102eca:	89 e5                	mov    %esp,%ebp
80102ecc:	83 ec 18             	sub    $0x18,%esp
  initlock(&kmem.lock, "kmem");
80102ecf:	c7 44 24 04 16 90 10 	movl   $0x80109016,0x4(%esp)
80102ed6:	80 
80102ed7:	c7 04 24 c0 1a 11 80 	movl   $0x80111ac0,(%esp)
80102ede:	e8 ff 27 00 00       	call   801056e2 <initlock>
  kmem.use_lock = 0;
80102ee3:	c7 05 f4 1a 11 80 00 	movl   $0x0,0x80111af4
80102eea:	00 00 00 
  freerange(vstart, vend);
80102eed:	8b 45 0c             	mov    0xc(%ebp),%eax
80102ef0:	89 44 24 04          	mov    %eax,0x4(%esp)
80102ef4:	8b 45 08             	mov    0x8(%ebp),%eax
80102ef7:	89 04 24             	mov    %eax,(%esp)
80102efa:	e8 26 00 00 00       	call   80102f25 <freerange>
}
80102eff:	c9                   	leave  
80102f00:	c3                   	ret    

80102f01 <kinit2>:

void
kinit2(void *vstart, void *vend)
{
80102f01:	55                   	push   %ebp
80102f02:	89 e5                	mov    %esp,%ebp
80102f04:	83 ec 18             	sub    $0x18,%esp
  freerange(vstart, vend);
80102f07:	8b 45 0c             	mov    0xc(%ebp),%eax
80102f0a:	89 44 24 04          	mov    %eax,0x4(%esp)
80102f0e:	8b 45 08             	mov    0x8(%ebp),%eax
80102f11:	89 04 24             	mov    %eax,(%esp)
80102f14:	e8 0c 00 00 00       	call   80102f25 <freerange>
  kmem.use_lock = 1;
80102f19:	c7 05 f4 1a 11 80 01 	movl   $0x1,0x80111af4
80102f20:	00 00 00 
}
80102f23:	c9                   	leave  
80102f24:	c3                   	ret    

80102f25 <freerange>:

void
freerange(void *vstart, void *vend)
{
80102f25:	55                   	push   %ebp
80102f26:	89 e5                	mov    %esp,%ebp
80102f28:	83 ec 28             	sub    $0x28,%esp
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
80102f2b:	8b 45 08             	mov    0x8(%ebp),%eax
80102f2e:	05 ff 0f 00 00       	add    $0xfff,%eax
80102f33:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80102f38:	89 45 f4             	mov    %eax,-0xc(%ebp)
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102f3b:	eb 12                	jmp    80102f4f <freerange+0x2a>
    kfree(p);
80102f3d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102f40:	89 04 24             	mov    %eax,(%esp)
80102f43:	e8 16 00 00 00       	call   80102f5e <kfree>
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102f48:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
80102f4f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102f52:	05 00 10 00 00       	add    $0x1000,%eax
80102f57:	3b 45 0c             	cmp    0xc(%ebp),%eax
80102f5a:	76 e1                	jbe    80102f3d <freerange+0x18>
    kfree(p);
}
80102f5c:	c9                   	leave  
80102f5d:	c3                   	ret    

80102f5e <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
80102f5e:	55                   	push   %ebp
80102f5f:	89 e5                	mov    %esp,%ebp
80102f61:	83 ec 28             	sub    $0x28,%esp
  struct run *r;

  if((uint)v % PGSIZE || v < end || v2p(v) >= PHYSTOP)
80102f64:	8b 45 08             	mov    0x8(%ebp),%eax
80102f67:	25 ff 0f 00 00       	and    $0xfff,%eax
80102f6c:	85 c0                	test   %eax,%eax
80102f6e:	75 1b                	jne    80102f8b <kfree+0x2d>
80102f70:	81 7d 08 7c 50 11 80 	cmpl   $0x8011507c,0x8(%ebp)
80102f77:	72 12                	jb     80102f8b <kfree+0x2d>
80102f79:	8b 45 08             	mov    0x8(%ebp),%eax
80102f7c:	89 04 24             	mov    %eax,(%esp)
80102f7f:	e8 38 ff ff ff       	call   80102ebc <v2p>
80102f84:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
80102f89:	76 0c                	jbe    80102f97 <kfree+0x39>
    panic("kfree");
80102f8b:	c7 04 24 1b 90 10 80 	movl   $0x8010901b,(%esp)
80102f92:	e8 a6 d5 ff ff       	call   8010053d <panic>

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
80102f97:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
80102f9e:	00 
80102f9f:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
80102fa6:	00 
80102fa7:	8b 45 08             	mov    0x8(%ebp),%eax
80102faa:	89 04 24             	mov    %eax,(%esp)
80102fad:	e8 a0 29 00 00       	call   80105952 <memset>

  if(kmem.use_lock)
80102fb2:	a1 f4 1a 11 80       	mov    0x80111af4,%eax
80102fb7:	85 c0                	test   %eax,%eax
80102fb9:	74 0c                	je     80102fc7 <kfree+0x69>
    acquire(&kmem.lock);
80102fbb:	c7 04 24 c0 1a 11 80 	movl   $0x80111ac0,(%esp)
80102fc2:	e8 3c 27 00 00       	call   80105703 <acquire>
  r = (struct run*)v;
80102fc7:	8b 45 08             	mov    0x8(%ebp),%eax
80102fca:	89 45 f4             	mov    %eax,-0xc(%ebp)
  r->next = kmem.freelist;
80102fcd:	8b 15 f8 1a 11 80    	mov    0x80111af8,%edx
80102fd3:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102fd6:	89 10                	mov    %edx,(%eax)
  kmem.freelist = r;
80102fd8:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102fdb:	a3 f8 1a 11 80       	mov    %eax,0x80111af8
  if(kmem.use_lock)
80102fe0:	a1 f4 1a 11 80       	mov    0x80111af4,%eax
80102fe5:	85 c0                	test   %eax,%eax
80102fe7:	74 0c                	je     80102ff5 <kfree+0x97>
    release(&kmem.lock);
80102fe9:	c7 04 24 c0 1a 11 80 	movl   $0x80111ac0,(%esp)
80102ff0:	e8 70 27 00 00       	call   80105765 <release>
}
80102ff5:	c9                   	leave  
80102ff6:	c3                   	ret    

80102ff7 <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char*
kalloc(void)
{
80102ff7:	55                   	push   %ebp
80102ff8:	89 e5                	mov    %esp,%ebp
80102ffa:	83 ec 28             	sub    $0x28,%esp
  struct run *r;

  if(kmem.use_lock)
80102ffd:	a1 f4 1a 11 80       	mov    0x80111af4,%eax
80103002:	85 c0                	test   %eax,%eax
80103004:	74 0c                	je     80103012 <kalloc+0x1b>
    acquire(&kmem.lock);
80103006:	c7 04 24 c0 1a 11 80 	movl   $0x80111ac0,(%esp)
8010300d:	e8 f1 26 00 00       	call   80105703 <acquire>
  r = kmem.freelist;
80103012:	a1 f8 1a 11 80       	mov    0x80111af8,%eax
80103017:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(r)
8010301a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010301e:	74 0a                	je     8010302a <kalloc+0x33>
    kmem.freelist = r->next;
80103020:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103023:	8b 00                	mov    (%eax),%eax
80103025:	a3 f8 1a 11 80       	mov    %eax,0x80111af8
  if(kmem.use_lock)
8010302a:	a1 f4 1a 11 80       	mov    0x80111af4,%eax
8010302f:	85 c0                	test   %eax,%eax
80103031:	74 0c                	je     8010303f <kalloc+0x48>
    release(&kmem.lock);
80103033:	c7 04 24 c0 1a 11 80 	movl   $0x80111ac0,(%esp)
8010303a:	e8 26 27 00 00       	call   80105765 <release>
  return (char*)r;
8010303f:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80103042:	c9                   	leave  
80103043:	c3                   	ret    

80103044 <inb>:
// Routines to let C code use special x86 instructions.

static inline uchar
inb(ushort port)
{
80103044:	55                   	push   %ebp
80103045:	89 e5                	mov    %esp,%ebp
80103047:	53                   	push   %ebx
80103048:	83 ec 14             	sub    $0x14,%esp
8010304b:	8b 45 08             	mov    0x8(%ebp),%eax
8010304e:	66 89 45 e8          	mov    %ax,-0x18(%ebp)
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103052:	0f b7 55 e8          	movzwl -0x18(%ebp),%edx
80103056:	66 89 55 ea          	mov    %dx,-0x16(%ebp)
8010305a:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
8010305e:	ec                   	in     (%dx),%al
8010305f:	89 c3                	mov    %eax,%ebx
80103061:	88 5d fb             	mov    %bl,-0x5(%ebp)
  return data;
80103064:	0f b6 45 fb          	movzbl -0x5(%ebp),%eax
}
80103068:	83 c4 14             	add    $0x14,%esp
8010306b:	5b                   	pop    %ebx
8010306c:	5d                   	pop    %ebp
8010306d:	c3                   	ret    

8010306e <kbdgetc>:
#include "defs.h"
#include "kbd.h"

int
kbdgetc(void)
{
8010306e:	55                   	push   %ebp
8010306f:	89 e5                	mov    %esp,%ebp
80103071:	83 ec 14             	sub    $0x14,%esp
  static uchar *charcode[4] = {
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
80103074:	c7 04 24 64 00 00 00 	movl   $0x64,(%esp)
8010307b:	e8 c4 ff ff ff       	call   80103044 <inb>
80103080:	0f b6 c0             	movzbl %al,%eax
80103083:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if((st & KBS_DIB) == 0)
80103086:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103089:	83 e0 01             	and    $0x1,%eax
8010308c:	85 c0                	test   %eax,%eax
8010308e:	75 0a                	jne    8010309a <kbdgetc+0x2c>
    return -1;
80103090:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103095:	e9 23 01 00 00       	jmp    801031bd <kbdgetc+0x14f>
  data = inb(KBDATAP);
8010309a:	c7 04 24 60 00 00 00 	movl   $0x60,(%esp)
801030a1:	e8 9e ff ff ff       	call   80103044 <inb>
801030a6:	0f b6 c0             	movzbl %al,%eax
801030a9:	89 45 fc             	mov    %eax,-0x4(%ebp)

  if(data == 0xE0){
801030ac:	81 7d fc e0 00 00 00 	cmpl   $0xe0,-0x4(%ebp)
801030b3:	75 17                	jne    801030cc <kbdgetc+0x5e>
    shift |= E0ESC;
801030b5:	a1 7c ce 10 80       	mov    0x8010ce7c,%eax
801030ba:	83 c8 40             	or     $0x40,%eax
801030bd:	a3 7c ce 10 80       	mov    %eax,0x8010ce7c
    return 0;
801030c2:	b8 00 00 00 00       	mov    $0x0,%eax
801030c7:	e9 f1 00 00 00       	jmp    801031bd <kbdgetc+0x14f>
  } else if(data & 0x80){
801030cc:	8b 45 fc             	mov    -0x4(%ebp),%eax
801030cf:	25 80 00 00 00       	and    $0x80,%eax
801030d4:	85 c0                	test   %eax,%eax
801030d6:	74 45                	je     8010311d <kbdgetc+0xaf>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
801030d8:	a1 7c ce 10 80       	mov    0x8010ce7c,%eax
801030dd:	83 e0 40             	and    $0x40,%eax
801030e0:	85 c0                	test   %eax,%eax
801030e2:	75 08                	jne    801030ec <kbdgetc+0x7e>
801030e4:	8b 45 fc             	mov    -0x4(%ebp),%eax
801030e7:	83 e0 7f             	and    $0x7f,%eax
801030ea:	eb 03                	jmp    801030ef <kbdgetc+0x81>
801030ec:	8b 45 fc             	mov    -0x4(%ebp),%eax
801030ef:	89 45 fc             	mov    %eax,-0x4(%ebp)
    shift &= ~(shiftcode[data] | E0ESC);
801030f2:	8b 45 fc             	mov    -0x4(%ebp),%eax
801030f5:	05 20 a0 10 80       	add    $0x8010a020,%eax
801030fa:	0f b6 00             	movzbl (%eax),%eax
801030fd:	83 c8 40             	or     $0x40,%eax
80103100:	0f b6 c0             	movzbl %al,%eax
80103103:	f7 d0                	not    %eax
80103105:	89 c2                	mov    %eax,%edx
80103107:	a1 7c ce 10 80       	mov    0x8010ce7c,%eax
8010310c:	21 d0                	and    %edx,%eax
8010310e:	a3 7c ce 10 80       	mov    %eax,0x8010ce7c
    return 0;
80103113:	b8 00 00 00 00       	mov    $0x0,%eax
80103118:	e9 a0 00 00 00       	jmp    801031bd <kbdgetc+0x14f>
  } else if(shift & E0ESC){
8010311d:	a1 7c ce 10 80       	mov    0x8010ce7c,%eax
80103122:	83 e0 40             	and    $0x40,%eax
80103125:	85 c0                	test   %eax,%eax
80103127:	74 14                	je     8010313d <kbdgetc+0xcf>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
80103129:	81 4d fc 80 00 00 00 	orl    $0x80,-0x4(%ebp)
    shift &= ~E0ESC;
80103130:	a1 7c ce 10 80       	mov    0x8010ce7c,%eax
80103135:	83 e0 bf             	and    $0xffffffbf,%eax
80103138:	a3 7c ce 10 80       	mov    %eax,0x8010ce7c
  }

  shift |= shiftcode[data];
8010313d:	8b 45 fc             	mov    -0x4(%ebp),%eax
80103140:	05 20 a0 10 80       	add    $0x8010a020,%eax
80103145:	0f b6 00             	movzbl (%eax),%eax
80103148:	0f b6 d0             	movzbl %al,%edx
8010314b:	a1 7c ce 10 80       	mov    0x8010ce7c,%eax
80103150:	09 d0                	or     %edx,%eax
80103152:	a3 7c ce 10 80       	mov    %eax,0x8010ce7c
  shift ^= togglecode[data];
80103157:	8b 45 fc             	mov    -0x4(%ebp),%eax
8010315a:	05 20 a1 10 80       	add    $0x8010a120,%eax
8010315f:	0f b6 00             	movzbl (%eax),%eax
80103162:	0f b6 d0             	movzbl %al,%edx
80103165:	a1 7c ce 10 80       	mov    0x8010ce7c,%eax
8010316a:	31 d0                	xor    %edx,%eax
8010316c:	a3 7c ce 10 80       	mov    %eax,0x8010ce7c
  c = charcode[shift & (CTL | SHIFT)][data];
80103171:	a1 7c ce 10 80       	mov    0x8010ce7c,%eax
80103176:	83 e0 03             	and    $0x3,%eax
80103179:	8b 04 85 20 a5 10 80 	mov    -0x7fef5ae0(,%eax,4),%eax
80103180:	03 45 fc             	add    -0x4(%ebp),%eax
80103183:	0f b6 00             	movzbl (%eax),%eax
80103186:	0f b6 c0             	movzbl %al,%eax
80103189:	89 45 f8             	mov    %eax,-0x8(%ebp)
  if(shift & CAPSLOCK){
8010318c:	a1 7c ce 10 80       	mov    0x8010ce7c,%eax
80103191:	83 e0 08             	and    $0x8,%eax
80103194:	85 c0                	test   %eax,%eax
80103196:	74 22                	je     801031ba <kbdgetc+0x14c>
    if('a' <= c && c <= 'z')
80103198:	83 7d f8 60          	cmpl   $0x60,-0x8(%ebp)
8010319c:	76 0c                	jbe    801031aa <kbdgetc+0x13c>
8010319e:	83 7d f8 7a          	cmpl   $0x7a,-0x8(%ebp)
801031a2:	77 06                	ja     801031aa <kbdgetc+0x13c>
      c += 'A' - 'a';
801031a4:	83 6d f8 20          	subl   $0x20,-0x8(%ebp)
801031a8:	eb 10                	jmp    801031ba <kbdgetc+0x14c>
    else if('A' <= c && c <= 'Z')
801031aa:	83 7d f8 40          	cmpl   $0x40,-0x8(%ebp)
801031ae:	76 0a                	jbe    801031ba <kbdgetc+0x14c>
801031b0:	83 7d f8 5a          	cmpl   $0x5a,-0x8(%ebp)
801031b4:	77 04                	ja     801031ba <kbdgetc+0x14c>
      c += 'a' - 'A';
801031b6:	83 45 f8 20          	addl   $0x20,-0x8(%ebp)
  }
  return c;
801031ba:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
801031bd:	c9                   	leave  
801031be:	c3                   	ret    

801031bf <kbdintr>:

void
kbdintr(void)
{
801031bf:	55                   	push   %ebp
801031c0:	89 e5                	mov    %esp,%ebp
801031c2:	83 ec 18             	sub    $0x18,%esp
  consoleintr(kbdgetc);
801031c5:	c7 04 24 6e 30 10 80 	movl   $0x8010306e,(%esp)
801031cc:	e8 ea d6 ff ff       	call   801008bb <consoleintr>
}
801031d1:	c9                   	leave  
801031d2:	c3                   	ret    
	...

801031d4 <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
801031d4:	55                   	push   %ebp
801031d5:	89 e5                	mov    %esp,%ebp
801031d7:	83 ec 08             	sub    $0x8,%esp
801031da:	8b 55 08             	mov    0x8(%ebp),%edx
801031dd:	8b 45 0c             	mov    0xc(%ebp),%eax
801031e0:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
801031e4:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801031e7:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
801031eb:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
801031ef:	ee                   	out    %al,(%dx)
}
801031f0:	c9                   	leave  
801031f1:	c3                   	ret    

801031f2 <readeflags>:
  asm volatile("ltr %0" : : "r" (sel));
}

static inline uint
readeflags(void)
{
801031f2:	55                   	push   %ebp
801031f3:	89 e5                	mov    %esp,%ebp
801031f5:	53                   	push   %ebx
801031f6:	83 ec 10             	sub    $0x10,%esp
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801031f9:	9c                   	pushf  
801031fa:	5b                   	pop    %ebx
801031fb:	89 5d f8             	mov    %ebx,-0x8(%ebp)
  return eflags;
801031fe:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
80103201:	83 c4 10             	add    $0x10,%esp
80103204:	5b                   	pop    %ebx
80103205:	5d                   	pop    %ebp
80103206:	c3                   	ret    

80103207 <lapicw>:

volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
80103207:	55                   	push   %ebp
80103208:	89 e5                	mov    %esp,%ebp
  lapic[index] = value;
8010320a:	a1 fc 1a 11 80       	mov    0x80111afc,%eax
8010320f:	8b 55 08             	mov    0x8(%ebp),%edx
80103212:	c1 e2 02             	shl    $0x2,%edx
80103215:	01 c2                	add    %eax,%edx
80103217:	8b 45 0c             	mov    0xc(%ebp),%eax
8010321a:	89 02                	mov    %eax,(%edx)
  lapic[ID];  // wait for write to finish, by reading
8010321c:	a1 fc 1a 11 80       	mov    0x80111afc,%eax
80103221:	83 c0 20             	add    $0x20,%eax
80103224:	8b 00                	mov    (%eax),%eax
}
80103226:	5d                   	pop    %ebp
80103227:	c3                   	ret    

80103228 <lapicinit>:
//PAGEBREAK!

void
lapicinit(int c)
{
80103228:	55                   	push   %ebp
80103229:	89 e5                	mov    %esp,%ebp
8010322b:	83 ec 08             	sub    $0x8,%esp
  if(!lapic) 
8010322e:	a1 fc 1a 11 80       	mov    0x80111afc,%eax
80103233:	85 c0                	test   %eax,%eax
80103235:	0f 84 47 01 00 00    	je     80103382 <lapicinit+0x15a>
    return;

  // Enable local APIC; set spurious interrupt vector.
  lapicw(SVR, ENABLE | (T_IRQ0 + IRQ_SPURIOUS));
8010323b:	c7 44 24 04 3f 01 00 	movl   $0x13f,0x4(%esp)
80103242:	00 
80103243:	c7 04 24 3c 00 00 00 	movl   $0x3c,(%esp)
8010324a:	e8 b8 ff ff ff       	call   80103207 <lapicw>

  // The timer repeatedly counts down at bus frequency
  // from lapic[TICR] and then issues an interrupt.  
  // If xv6 cared more about precise timekeeping,
  // TICR would be calibrated using an external time source.
  lapicw(TDCR, X1);
8010324f:	c7 44 24 04 0b 00 00 	movl   $0xb,0x4(%esp)
80103256:	00 
80103257:	c7 04 24 f8 00 00 00 	movl   $0xf8,(%esp)
8010325e:	e8 a4 ff ff ff       	call   80103207 <lapicw>
  lapicw(TIMER, PERIODIC | (T_IRQ0 + IRQ_TIMER));
80103263:	c7 44 24 04 20 00 02 	movl   $0x20020,0x4(%esp)
8010326a:	00 
8010326b:	c7 04 24 c8 00 00 00 	movl   $0xc8,(%esp)
80103272:	e8 90 ff ff ff       	call   80103207 <lapicw>
  lapicw(TICR, 10000000); 
80103277:	c7 44 24 04 80 96 98 	movl   $0x989680,0x4(%esp)
8010327e:	00 
8010327f:	c7 04 24 e0 00 00 00 	movl   $0xe0,(%esp)
80103286:	e8 7c ff ff ff       	call   80103207 <lapicw>

  // Disable logical interrupt lines.
  lapicw(LINT0, MASKED);
8010328b:	c7 44 24 04 00 00 01 	movl   $0x10000,0x4(%esp)
80103292:	00 
80103293:	c7 04 24 d4 00 00 00 	movl   $0xd4,(%esp)
8010329a:	e8 68 ff ff ff       	call   80103207 <lapicw>
  lapicw(LINT1, MASKED);
8010329f:	c7 44 24 04 00 00 01 	movl   $0x10000,0x4(%esp)
801032a6:	00 
801032a7:	c7 04 24 d8 00 00 00 	movl   $0xd8,(%esp)
801032ae:	e8 54 ff ff ff       	call   80103207 <lapicw>

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
801032b3:	a1 fc 1a 11 80       	mov    0x80111afc,%eax
801032b8:	83 c0 30             	add    $0x30,%eax
801032bb:	8b 00                	mov    (%eax),%eax
801032bd:	c1 e8 10             	shr    $0x10,%eax
801032c0:	25 ff 00 00 00       	and    $0xff,%eax
801032c5:	83 f8 03             	cmp    $0x3,%eax
801032c8:	76 14                	jbe    801032de <lapicinit+0xb6>
    lapicw(PCINT, MASKED);
801032ca:	c7 44 24 04 00 00 01 	movl   $0x10000,0x4(%esp)
801032d1:	00 
801032d2:	c7 04 24 d0 00 00 00 	movl   $0xd0,(%esp)
801032d9:	e8 29 ff ff ff       	call   80103207 <lapicw>

  // Map error interrupt to IRQ_ERROR.
  lapicw(ERROR, T_IRQ0 + IRQ_ERROR);
801032de:	c7 44 24 04 33 00 00 	movl   $0x33,0x4(%esp)
801032e5:	00 
801032e6:	c7 04 24 dc 00 00 00 	movl   $0xdc,(%esp)
801032ed:	e8 15 ff ff ff       	call   80103207 <lapicw>

  // Clear error status register (requires back-to-back writes).
  lapicw(ESR, 0);
801032f2:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
801032f9:	00 
801032fa:	c7 04 24 a0 00 00 00 	movl   $0xa0,(%esp)
80103301:	e8 01 ff ff ff       	call   80103207 <lapicw>
  lapicw(ESR, 0);
80103306:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
8010330d:	00 
8010330e:	c7 04 24 a0 00 00 00 	movl   $0xa0,(%esp)
80103315:	e8 ed fe ff ff       	call   80103207 <lapicw>

  // Ack any outstanding interrupts.
  lapicw(EOI, 0);
8010331a:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80103321:	00 
80103322:	c7 04 24 2c 00 00 00 	movl   $0x2c,(%esp)
80103329:	e8 d9 fe ff ff       	call   80103207 <lapicw>

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
8010332e:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80103335:	00 
80103336:	c7 04 24 c4 00 00 00 	movl   $0xc4,(%esp)
8010333d:	e8 c5 fe ff ff       	call   80103207 <lapicw>
  lapicw(ICRLO, BCAST | INIT | LEVEL);
80103342:	c7 44 24 04 00 85 08 	movl   $0x88500,0x4(%esp)
80103349:	00 
8010334a:	c7 04 24 c0 00 00 00 	movl   $0xc0,(%esp)
80103351:	e8 b1 fe ff ff       	call   80103207 <lapicw>
  while(lapic[ICRLO] & DELIVS)
80103356:	90                   	nop
80103357:	a1 fc 1a 11 80       	mov    0x80111afc,%eax
8010335c:	05 00 03 00 00       	add    $0x300,%eax
80103361:	8b 00                	mov    (%eax),%eax
80103363:	25 00 10 00 00       	and    $0x1000,%eax
80103368:	85 c0                	test   %eax,%eax
8010336a:	75 eb                	jne    80103357 <lapicinit+0x12f>
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
8010336c:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80103373:	00 
80103374:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
8010337b:	e8 87 fe ff ff       	call   80103207 <lapicw>
80103380:	eb 01                	jmp    80103383 <lapicinit+0x15b>

void
lapicinit(int c)
{
  if(!lapic) 
    return;
80103382:	90                   	nop
  while(lapic[ICRLO] & DELIVS)
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
80103383:	c9                   	leave  
80103384:	c3                   	ret    

80103385 <cpunum>:

int
cpunum(void)
{
80103385:	55                   	push   %ebp
80103386:	89 e5                	mov    %esp,%ebp
80103388:	83 ec 18             	sub    $0x18,%esp
  // Cannot call cpu when interrupts are enabled:
  // result not guaranteed to last long enough to be used!
  // Would prefer to panic but even printing is chancy here:
  // almost everything, including cprintf and panic, calls cpu,
  // often indirectly through acquire and release.
  if(readeflags()&FL_IF){
8010338b:	e8 62 fe ff ff       	call   801031f2 <readeflags>
80103390:	25 00 02 00 00       	and    $0x200,%eax
80103395:	85 c0                	test   %eax,%eax
80103397:	74 29                	je     801033c2 <cpunum+0x3d>
    static int n;
    if(n++ == 0)
80103399:	a1 80 ce 10 80       	mov    0x8010ce80,%eax
8010339e:	85 c0                	test   %eax,%eax
801033a0:	0f 94 c2             	sete   %dl
801033a3:	83 c0 01             	add    $0x1,%eax
801033a6:	a3 80 ce 10 80       	mov    %eax,0x8010ce80
801033ab:	84 d2                	test   %dl,%dl
801033ad:	74 13                	je     801033c2 <cpunum+0x3d>
      cprintf("cpu called from %x with interrupts enabled\n",
801033af:	8b 45 04             	mov    0x4(%ebp),%eax
801033b2:	89 44 24 04          	mov    %eax,0x4(%esp)
801033b6:	c7 04 24 24 90 10 80 	movl   $0x80109024,(%esp)
801033bd:	e8 df cf ff ff       	call   801003a1 <cprintf>
        __builtin_return_address(0));
  }

  if(lapic)
801033c2:	a1 fc 1a 11 80       	mov    0x80111afc,%eax
801033c7:	85 c0                	test   %eax,%eax
801033c9:	74 0f                	je     801033da <cpunum+0x55>
    return lapic[ID]>>24;
801033cb:	a1 fc 1a 11 80       	mov    0x80111afc,%eax
801033d0:	83 c0 20             	add    $0x20,%eax
801033d3:	8b 00                	mov    (%eax),%eax
801033d5:	c1 e8 18             	shr    $0x18,%eax
801033d8:	eb 05                	jmp    801033df <cpunum+0x5a>
  return 0;
801033da:	b8 00 00 00 00       	mov    $0x0,%eax
}
801033df:	c9                   	leave  
801033e0:	c3                   	ret    

801033e1 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
801033e1:	55                   	push   %ebp
801033e2:	89 e5                	mov    %esp,%ebp
801033e4:	83 ec 08             	sub    $0x8,%esp
  if(lapic)
801033e7:	a1 fc 1a 11 80       	mov    0x80111afc,%eax
801033ec:	85 c0                	test   %eax,%eax
801033ee:	74 14                	je     80103404 <lapiceoi+0x23>
    lapicw(EOI, 0);
801033f0:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
801033f7:	00 
801033f8:	c7 04 24 2c 00 00 00 	movl   $0x2c,(%esp)
801033ff:	e8 03 fe ff ff       	call   80103207 <lapicw>
}
80103404:	c9                   	leave  
80103405:	c3                   	ret    

80103406 <microdelay>:

// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
80103406:	55                   	push   %ebp
80103407:	89 e5                	mov    %esp,%ebp
}
80103409:	5d                   	pop    %ebp
8010340a:	c3                   	ret    

8010340b <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
8010340b:	55                   	push   %ebp
8010340c:	89 e5                	mov    %esp,%ebp
8010340e:	83 ec 1c             	sub    $0x1c,%esp
80103411:	8b 45 08             	mov    0x8(%ebp),%eax
80103414:	88 45 ec             	mov    %al,-0x14(%ebp)
  ushort *wrv;
  
  // "The BSP must initialize CMOS shutdown code to 0AH
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(IO_RTC, 0xF);  // offset 0xF is shutdown code
80103417:	c7 44 24 04 0f 00 00 	movl   $0xf,0x4(%esp)
8010341e:	00 
8010341f:	c7 04 24 70 00 00 00 	movl   $0x70,(%esp)
80103426:	e8 a9 fd ff ff       	call   801031d4 <outb>
  outb(IO_RTC+1, 0x0A);
8010342b:	c7 44 24 04 0a 00 00 	movl   $0xa,0x4(%esp)
80103432:	00 
80103433:	c7 04 24 71 00 00 00 	movl   $0x71,(%esp)
8010343a:	e8 95 fd ff ff       	call   801031d4 <outb>
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
8010343f:	c7 45 f8 67 04 00 80 	movl   $0x80000467,-0x8(%ebp)
  wrv[0] = 0;
80103446:	8b 45 f8             	mov    -0x8(%ebp),%eax
80103449:	66 c7 00 00 00       	movw   $0x0,(%eax)
  wrv[1] = addr >> 4;
8010344e:	8b 45 f8             	mov    -0x8(%ebp),%eax
80103451:	8d 50 02             	lea    0x2(%eax),%edx
80103454:	8b 45 0c             	mov    0xc(%ebp),%eax
80103457:	c1 e8 04             	shr    $0x4,%eax
8010345a:	66 89 02             	mov    %ax,(%edx)

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
8010345d:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
80103461:	c1 e0 18             	shl    $0x18,%eax
80103464:	89 44 24 04          	mov    %eax,0x4(%esp)
80103468:	c7 04 24 c4 00 00 00 	movl   $0xc4,(%esp)
8010346f:	e8 93 fd ff ff       	call   80103207 <lapicw>
  lapicw(ICRLO, INIT | LEVEL | ASSERT);
80103474:	c7 44 24 04 00 c5 00 	movl   $0xc500,0x4(%esp)
8010347b:	00 
8010347c:	c7 04 24 c0 00 00 00 	movl   $0xc0,(%esp)
80103483:	e8 7f fd ff ff       	call   80103207 <lapicw>
  microdelay(200);
80103488:	c7 04 24 c8 00 00 00 	movl   $0xc8,(%esp)
8010348f:	e8 72 ff ff ff       	call   80103406 <microdelay>
  lapicw(ICRLO, INIT | LEVEL);
80103494:	c7 44 24 04 00 85 00 	movl   $0x8500,0x4(%esp)
8010349b:	00 
8010349c:	c7 04 24 c0 00 00 00 	movl   $0xc0,(%esp)
801034a3:	e8 5f fd ff ff       	call   80103207 <lapicw>
  microdelay(100);    // should be 10ms, but too slow in Bochs!
801034a8:	c7 04 24 64 00 00 00 	movl   $0x64,(%esp)
801034af:	e8 52 ff ff ff       	call   80103406 <microdelay>
  // Send startup IPI (twice!) to enter code.
  // Regular hardware is supposed to only accept a STARTUP
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
801034b4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
801034bb:	eb 40                	jmp    801034fd <lapicstartap+0xf2>
    lapicw(ICRHI, apicid<<24);
801034bd:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
801034c1:	c1 e0 18             	shl    $0x18,%eax
801034c4:	89 44 24 04          	mov    %eax,0x4(%esp)
801034c8:	c7 04 24 c4 00 00 00 	movl   $0xc4,(%esp)
801034cf:	e8 33 fd ff ff       	call   80103207 <lapicw>
    lapicw(ICRLO, STARTUP | (addr>>12));
801034d4:	8b 45 0c             	mov    0xc(%ebp),%eax
801034d7:	c1 e8 0c             	shr    $0xc,%eax
801034da:	80 cc 06             	or     $0x6,%ah
801034dd:	89 44 24 04          	mov    %eax,0x4(%esp)
801034e1:	c7 04 24 c0 00 00 00 	movl   $0xc0,(%esp)
801034e8:	e8 1a fd ff ff       	call   80103207 <lapicw>
    microdelay(200);
801034ed:	c7 04 24 c8 00 00 00 	movl   $0xc8,(%esp)
801034f4:	e8 0d ff ff ff       	call   80103406 <microdelay>
  // Send startup IPI (twice!) to enter code.
  // Regular hardware is supposed to only accept a STARTUP
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
801034f9:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
801034fd:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
80103501:	7e ba                	jle    801034bd <lapicstartap+0xb2>
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
    microdelay(200);
  }
}
80103503:	c9                   	leave  
80103504:	c3                   	ret    
80103505:	00 00                	add    %al,(%eax)
	...

80103508 <initlog>:

static void recover_from_log(void);

void
initlog(void)
{
80103508:	55                   	push   %ebp
80103509:	89 e5                	mov    %esp,%ebp
8010350b:	83 ec 28             	sub    $0x28,%esp
  if (sizeof(struct logheader) >= BSIZE)
    panic("initlog: too big logheader");

  struct superblock sb;
  initlock(&log.lock, "log");
8010350e:	c7 44 24 04 50 90 10 	movl   $0x80109050,0x4(%esp)
80103515:	80 
80103516:	c7 04 24 00 1b 11 80 	movl   $0x80111b00,(%esp)
8010351d:	e8 c0 21 00 00       	call   801056e2 <initlock>
  readsb(ROOTDEV, &sb);
80103522:	8d 45 e8             	lea    -0x18(%ebp),%eax
80103525:	89 44 24 04          	mov    %eax,0x4(%esp)
80103529:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80103530:	e8 af e2 ff ff       	call   801017e4 <readsb>
  log.start = sb.size - sb.nlog;
80103535:	8b 55 e8             	mov    -0x18(%ebp),%edx
80103538:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010353b:	89 d1                	mov    %edx,%ecx
8010353d:	29 c1                	sub    %eax,%ecx
8010353f:	89 c8                	mov    %ecx,%eax
80103541:	a3 34 1b 11 80       	mov    %eax,0x80111b34
  log.size = sb.nlog;
80103546:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103549:	a3 38 1b 11 80       	mov    %eax,0x80111b38
  log.dev = ROOTDEV;
8010354e:	c7 05 40 1b 11 80 01 	movl   $0x1,0x80111b40
80103555:	00 00 00 
  recover_from_log();
80103558:	e8 97 01 00 00       	call   801036f4 <recover_from_log>
}
8010355d:	c9                   	leave  
8010355e:	c3                   	ret    

8010355f <install_trans>:

// Copy committed blocks from log to their home location
static void 
install_trans(void)
{
8010355f:	55                   	push   %ebp
80103560:	89 e5                	mov    %esp,%ebp
80103562:	83 ec 28             	sub    $0x28,%esp
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80103565:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010356c:	e9 89 00 00 00       	jmp    801035fa <install_trans+0x9b>
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
80103571:	a1 34 1b 11 80       	mov    0x80111b34,%eax
80103576:	03 45 f4             	add    -0xc(%ebp),%eax
80103579:	83 c0 01             	add    $0x1,%eax
8010357c:	89 c2                	mov    %eax,%edx
8010357e:	a1 40 1b 11 80       	mov    0x80111b40,%eax
80103583:	89 54 24 04          	mov    %edx,0x4(%esp)
80103587:	89 04 24             	mov    %eax,(%esp)
8010358a:	e8 17 cc ff ff       	call   801001a6 <bread>
8010358f:	89 45 f0             	mov    %eax,-0x10(%ebp)
    struct buf *dbuf = bread(log.dev, log.lh.sector[tail]); // read dst
80103592:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103595:	83 c0 10             	add    $0x10,%eax
80103598:	8b 04 85 08 1b 11 80 	mov    -0x7feee4f8(,%eax,4),%eax
8010359f:	89 c2                	mov    %eax,%edx
801035a1:	a1 40 1b 11 80       	mov    0x80111b40,%eax
801035a6:	89 54 24 04          	mov    %edx,0x4(%esp)
801035aa:	89 04 24             	mov    %eax,(%esp)
801035ad:	e8 f4 cb ff ff       	call   801001a6 <bread>
801035b2:	89 45 ec             	mov    %eax,-0x14(%ebp)
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
801035b5:	8b 45 f0             	mov    -0x10(%ebp),%eax
801035b8:	8d 50 18             	lea    0x18(%eax),%edx
801035bb:	8b 45 ec             	mov    -0x14(%ebp),%eax
801035be:	83 c0 18             	add    $0x18,%eax
801035c1:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
801035c8:	00 
801035c9:	89 54 24 04          	mov    %edx,0x4(%esp)
801035cd:	89 04 24             	mov    %eax,(%esp)
801035d0:	e8 50 24 00 00       	call   80105a25 <memmove>
    bwrite(dbuf);  // write dst to disk
801035d5:	8b 45 ec             	mov    -0x14(%ebp),%eax
801035d8:	89 04 24             	mov    %eax,(%esp)
801035db:	e8 fd cb ff ff       	call   801001dd <bwrite>
    brelse(lbuf); 
801035e0:	8b 45 f0             	mov    -0x10(%ebp),%eax
801035e3:	89 04 24             	mov    %eax,(%esp)
801035e6:	e8 2c cc ff ff       	call   80100217 <brelse>
    brelse(dbuf);
801035eb:	8b 45 ec             	mov    -0x14(%ebp),%eax
801035ee:	89 04 24             	mov    %eax,(%esp)
801035f1:	e8 21 cc ff ff       	call   80100217 <brelse>
static void 
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
801035f6:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801035fa:	a1 44 1b 11 80       	mov    0x80111b44,%eax
801035ff:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80103602:	0f 8f 69 ff ff ff    	jg     80103571 <install_trans+0x12>
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
    bwrite(dbuf);  // write dst to disk
    brelse(lbuf); 
    brelse(dbuf);
  }
}
80103608:	c9                   	leave  
80103609:	c3                   	ret    

8010360a <read_head>:

// Read the log header from disk into the in-memory log header
static void
read_head(void)
{
8010360a:	55                   	push   %ebp
8010360b:	89 e5                	mov    %esp,%ebp
8010360d:	83 ec 28             	sub    $0x28,%esp
  struct buf *buf = bread(log.dev, log.start);
80103610:	a1 34 1b 11 80       	mov    0x80111b34,%eax
80103615:	89 c2                	mov    %eax,%edx
80103617:	a1 40 1b 11 80       	mov    0x80111b40,%eax
8010361c:	89 54 24 04          	mov    %edx,0x4(%esp)
80103620:	89 04 24             	mov    %eax,(%esp)
80103623:	e8 7e cb ff ff       	call   801001a6 <bread>
80103628:	89 45 f0             	mov    %eax,-0x10(%ebp)
  struct logheader *lh = (struct logheader *) (buf->data);
8010362b:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010362e:	83 c0 18             	add    $0x18,%eax
80103631:	89 45 ec             	mov    %eax,-0x14(%ebp)
  int i;
  log.lh.n = lh->n;
80103634:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103637:	8b 00                	mov    (%eax),%eax
80103639:	a3 44 1b 11 80       	mov    %eax,0x80111b44
  for (i = 0; i < log.lh.n; i++) {
8010363e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80103645:	eb 1b                	jmp    80103662 <read_head+0x58>
    log.lh.sector[i] = lh->sector[i];
80103647:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010364a:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010364d:	8b 44 90 04          	mov    0x4(%eax,%edx,4),%eax
80103651:	8b 55 f4             	mov    -0xc(%ebp),%edx
80103654:	83 c2 10             	add    $0x10,%edx
80103657:	89 04 95 08 1b 11 80 	mov    %eax,-0x7feee4f8(,%edx,4)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
  for (i = 0; i < log.lh.n; i++) {
8010365e:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80103662:	a1 44 1b 11 80       	mov    0x80111b44,%eax
80103667:	3b 45 f4             	cmp    -0xc(%ebp),%eax
8010366a:	7f db                	jg     80103647 <read_head+0x3d>
    log.lh.sector[i] = lh->sector[i];
  }
  brelse(buf);
8010366c:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010366f:	89 04 24             	mov    %eax,(%esp)
80103672:	e8 a0 cb ff ff       	call   80100217 <brelse>
}
80103677:	c9                   	leave  
80103678:	c3                   	ret    

80103679 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80103679:	55                   	push   %ebp
8010367a:	89 e5                	mov    %esp,%ebp
8010367c:	83 ec 28             	sub    $0x28,%esp
  struct buf *buf = bread(log.dev, log.start);
8010367f:	a1 34 1b 11 80       	mov    0x80111b34,%eax
80103684:	89 c2                	mov    %eax,%edx
80103686:	a1 40 1b 11 80       	mov    0x80111b40,%eax
8010368b:	89 54 24 04          	mov    %edx,0x4(%esp)
8010368f:	89 04 24             	mov    %eax,(%esp)
80103692:	e8 0f cb ff ff       	call   801001a6 <bread>
80103697:	89 45 f0             	mov    %eax,-0x10(%ebp)
  struct logheader *hb = (struct logheader *) (buf->data);
8010369a:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010369d:	83 c0 18             	add    $0x18,%eax
801036a0:	89 45 ec             	mov    %eax,-0x14(%ebp)
  int i;
  hb->n = log.lh.n;
801036a3:	8b 15 44 1b 11 80    	mov    0x80111b44,%edx
801036a9:	8b 45 ec             	mov    -0x14(%ebp),%eax
801036ac:	89 10                	mov    %edx,(%eax)
  for (i = 0; i < log.lh.n; i++) {
801036ae:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801036b5:	eb 1b                	jmp    801036d2 <write_head+0x59>
    hb->sector[i] = log.lh.sector[i];
801036b7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801036ba:	83 c0 10             	add    $0x10,%eax
801036bd:	8b 0c 85 08 1b 11 80 	mov    -0x7feee4f8(,%eax,4),%ecx
801036c4:	8b 45 ec             	mov    -0x14(%ebp),%eax
801036c7:	8b 55 f4             	mov    -0xc(%ebp),%edx
801036ca:	89 4c 90 04          	mov    %ecx,0x4(%eax,%edx,4)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
801036ce:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801036d2:	a1 44 1b 11 80       	mov    0x80111b44,%eax
801036d7:	3b 45 f4             	cmp    -0xc(%ebp),%eax
801036da:	7f db                	jg     801036b7 <write_head+0x3e>
    hb->sector[i] = log.lh.sector[i];
  }
  bwrite(buf);
801036dc:	8b 45 f0             	mov    -0x10(%ebp),%eax
801036df:	89 04 24             	mov    %eax,(%esp)
801036e2:	e8 f6 ca ff ff       	call   801001dd <bwrite>
  brelse(buf);
801036e7:	8b 45 f0             	mov    -0x10(%ebp),%eax
801036ea:	89 04 24             	mov    %eax,(%esp)
801036ed:	e8 25 cb ff ff       	call   80100217 <brelse>
}
801036f2:	c9                   	leave  
801036f3:	c3                   	ret    

801036f4 <recover_from_log>:

static void
recover_from_log(void)
{
801036f4:	55                   	push   %ebp
801036f5:	89 e5                	mov    %esp,%ebp
801036f7:	83 ec 08             	sub    $0x8,%esp
  read_head();      
801036fa:	e8 0b ff ff ff       	call   8010360a <read_head>
  install_trans(); // if committed, copy from log to disk
801036ff:	e8 5b fe ff ff       	call   8010355f <install_trans>
  log.lh.n = 0;
80103704:	c7 05 44 1b 11 80 00 	movl   $0x0,0x80111b44
8010370b:	00 00 00 
  write_head(); // clear the log
8010370e:	e8 66 ff ff ff       	call   80103679 <write_head>
}
80103713:	c9                   	leave  
80103714:	c3                   	ret    

80103715 <begin_trans>:

void
begin_trans(void)
{
80103715:	55                   	push   %ebp
80103716:	89 e5                	mov    %esp,%ebp
80103718:	83 ec 18             	sub    $0x18,%esp
  acquire(&log.lock);
8010371b:	c7 04 24 00 1b 11 80 	movl   $0x80111b00,(%esp)
80103722:	e8 dc 1f 00 00       	call   80105703 <acquire>
  while (log.busy) {
80103727:	eb 14                	jmp    8010373d <begin_trans+0x28>
    sleep(&log, &log.lock);
80103729:	c7 44 24 04 00 1b 11 	movl   $0x80111b00,0x4(%esp)
80103730:	80 
80103731:	c7 04 24 00 1b 11 80 	movl   $0x80111b00,(%esp)
80103738:	e8 ca 1b 00 00       	call   80105307 <sleep>

void
begin_trans(void)
{
  acquire(&log.lock);
  while (log.busy) {
8010373d:	a1 3c 1b 11 80       	mov    0x80111b3c,%eax
80103742:	85 c0                	test   %eax,%eax
80103744:	75 e3                	jne    80103729 <begin_trans+0x14>
    sleep(&log, &log.lock);
  }
  log.busy = 1;
80103746:	c7 05 3c 1b 11 80 01 	movl   $0x1,0x80111b3c
8010374d:	00 00 00 
  release(&log.lock);
80103750:	c7 04 24 00 1b 11 80 	movl   $0x80111b00,(%esp)
80103757:	e8 09 20 00 00       	call   80105765 <release>
}
8010375c:	c9                   	leave  
8010375d:	c3                   	ret    

8010375e <commit_trans>:

void
commit_trans(void)
{
8010375e:	55                   	push   %ebp
8010375f:	89 e5                	mov    %esp,%ebp
80103761:	83 ec 18             	sub    $0x18,%esp
  if (log.lh.n > 0) {
80103764:	a1 44 1b 11 80       	mov    0x80111b44,%eax
80103769:	85 c0                	test   %eax,%eax
8010376b:	7e 19                	jle    80103786 <commit_trans+0x28>
    write_head();    // Write header to disk -- the real commit
8010376d:	e8 07 ff ff ff       	call   80103679 <write_head>
    install_trans(); // Now install writes to home locations
80103772:	e8 e8 fd ff ff       	call   8010355f <install_trans>
    log.lh.n = 0; 
80103777:	c7 05 44 1b 11 80 00 	movl   $0x0,0x80111b44
8010377e:	00 00 00 
    write_head();    // Erase the transaction from the log
80103781:	e8 f3 fe ff ff       	call   80103679 <write_head>
  }
  
  acquire(&log.lock);
80103786:	c7 04 24 00 1b 11 80 	movl   $0x80111b00,(%esp)
8010378d:	e8 71 1f 00 00       	call   80105703 <acquire>
  log.busy = 0;
80103792:	c7 05 3c 1b 11 80 00 	movl   $0x0,0x80111b3c
80103799:	00 00 00 
  wakeup(&log);
8010379c:	c7 04 24 00 1b 11 80 	movl   $0x80111b00,(%esp)
801037a3:	e8 4d 1c 00 00       	call   801053f5 <wakeup>
  release(&log.lock);
801037a8:	c7 04 24 00 1b 11 80 	movl   $0x80111b00,(%esp)
801037af:	e8 b1 1f 00 00       	call   80105765 <release>
}
801037b4:	c9                   	leave  
801037b5:	c3                   	ret    

801037b6 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
801037b6:	55                   	push   %ebp
801037b7:	89 e5                	mov    %esp,%ebp
801037b9:	83 ec 28             	sub    $0x28,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
801037bc:	a1 44 1b 11 80       	mov    0x80111b44,%eax
801037c1:	83 f8 09             	cmp    $0x9,%eax
801037c4:	7f 12                	jg     801037d8 <log_write+0x22>
801037c6:	a1 44 1b 11 80       	mov    0x80111b44,%eax
801037cb:	8b 15 38 1b 11 80    	mov    0x80111b38,%edx
801037d1:	83 ea 01             	sub    $0x1,%edx
801037d4:	39 d0                	cmp    %edx,%eax
801037d6:	7c 0c                	jl     801037e4 <log_write+0x2e>
    panic("too big a transaction");
801037d8:	c7 04 24 54 90 10 80 	movl   $0x80109054,(%esp)
801037df:	e8 59 cd ff ff       	call   8010053d <panic>
  if (!log.busy)
801037e4:	a1 3c 1b 11 80       	mov    0x80111b3c,%eax
801037e9:	85 c0                	test   %eax,%eax
801037eb:	75 0c                	jne    801037f9 <log_write+0x43>
    panic("write outside of trans");
801037ed:	c7 04 24 6a 90 10 80 	movl   $0x8010906a,(%esp)
801037f4:	e8 44 cd ff ff       	call   8010053d <panic>

  for (i = 0; i < log.lh.n; i++) {
801037f9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80103800:	eb 1d                	jmp    8010381f <log_write+0x69>
    if (log.lh.sector[i] == b->sector)   // log absorbtion?
80103802:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103805:	83 c0 10             	add    $0x10,%eax
80103808:	8b 04 85 08 1b 11 80 	mov    -0x7feee4f8(,%eax,4),%eax
8010380f:	89 c2                	mov    %eax,%edx
80103811:	8b 45 08             	mov    0x8(%ebp),%eax
80103814:	8b 40 08             	mov    0x8(%eax),%eax
80103817:	39 c2                	cmp    %eax,%edx
80103819:	74 10                	je     8010382b <log_write+0x75>
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
    panic("too big a transaction");
  if (!log.busy)
    panic("write outside of trans");

  for (i = 0; i < log.lh.n; i++) {
8010381b:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
8010381f:	a1 44 1b 11 80       	mov    0x80111b44,%eax
80103824:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80103827:	7f d9                	jg     80103802 <log_write+0x4c>
80103829:	eb 01                	jmp    8010382c <log_write+0x76>
    if (log.lh.sector[i] == b->sector)   // log absorbtion?
      break;
8010382b:	90                   	nop
  }
  log.lh.sector[i] = b->sector;
8010382c:	8b 45 08             	mov    0x8(%ebp),%eax
8010382f:	8b 40 08             	mov    0x8(%eax),%eax
80103832:	8b 55 f4             	mov    -0xc(%ebp),%edx
80103835:	83 c2 10             	add    $0x10,%edx
80103838:	89 04 95 08 1b 11 80 	mov    %eax,-0x7feee4f8(,%edx,4)
  struct buf *lbuf = bread(b->dev, log.start+i+1);
8010383f:	a1 34 1b 11 80       	mov    0x80111b34,%eax
80103844:	03 45 f4             	add    -0xc(%ebp),%eax
80103847:	83 c0 01             	add    $0x1,%eax
8010384a:	89 c2                	mov    %eax,%edx
8010384c:	8b 45 08             	mov    0x8(%ebp),%eax
8010384f:	8b 40 04             	mov    0x4(%eax),%eax
80103852:	89 54 24 04          	mov    %edx,0x4(%esp)
80103856:	89 04 24             	mov    %eax,(%esp)
80103859:	e8 48 c9 ff ff       	call   801001a6 <bread>
8010385e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  memmove(lbuf->data, b->data, BSIZE);
80103861:	8b 45 08             	mov    0x8(%ebp),%eax
80103864:	8d 50 18             	lea    0x18(%eax),%edx
80103867:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010386a:	83 c0 18             	add    $0x18,%eax
8010386d:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
80103874:	00 
80103875:	89 54 24 04          	mov    %edx,0x4(%esp)
80103879:	89 04 24             	mov    %eax,(%esp)
8010387c:	e8 a4 21 00 00       	call   80105a25 <memmove>
  bwrite(lbuf);
80103881:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103884:	89 04 24             	mov    %eax,(%esp)
80103887:	e8 51 c9 ff ff       	call   801001dd <bwrite>
  brelse(lbuf);
8010388c:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010388f:	89 04 24             	mov    %eax,(%esp)
80103892:	e8 80 c9 ff ff       	call   80100217 <brelse>
  if (i == log.lh.n)
80103897:	a1 44 1b 11 80       	mov    0x80111b44,%eax
8010389c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
8010389f:	75 0d                	jne    801038ae <log_write+0xf8>
    log.lh.n++;
801038a1:	a1 44 1b 11 80       	mov    0x80111b44,%eax
801038a6:	83 c0 01             	add    $0x1,%eax
801038a9:	a3 44 1b 11 80       	mov    %eax,0x80111b44
  b->flags |= B_DIRTY; // XXX prevent eviction
801038ae:	8b 45 08             	mov    0x8(%ebp),%eax
801038b1:	8b 00                	mov    (%eax),%eax
801038b3:	89 c2                	mov    %eax,%edx
801038b5:	83 ca 04             	or     $0x4,%edx
801038b8:	8b 45 08             	mov    0x8(%ebp),%eax
801038bb:	89 10                	mov    %edx,(%eax)
}
801038bd:	c9                   	leave  
801038be:	c3                   	ret    
	...

801038c0 <v2p>:
801038c0:	55                   	push   %ebp
801038c1:	89 e5                	mov    %esp,%ebp
801038c3:	8b 45 08             	mov    0x8(%ebp),%eax
801038c6:	05 00 00 00 80       	add    $0x80000000,%eax
801038cb:	5d                   	pop    %ebp
801038cc:	c3                   	ret    

801038cd <p2v>:
static inline void *p2v(uint a) { return (void *) ((a) + KERNBASE); }
801038cd:	55                   	push   %ebp
801038ce:	89 e5                	mov    %esp,%ebp
801038d0:	8b 45 08             	mov    0x8(%ebp),%eax
801038d3:	05 00 00 00 80       	add    $0x80000000,%eax
801038d8:	5d                   	pop    %ebp
801038d9:	c3                   	ret    

801038da <xchg>:
  asm volatile("sti");
}

static inline uint
xchg(volatile uint *addr, uint newval)
{
801038da:	55                   	push   %ebp
801038db:	89 e5                	mov    %esp,%ebp
801038dd:	53                   	push   %ebx
801038de:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
               "+m" (*addr), "=a" (result) :
801038e1:	8b 55 08             	mov    0x8(%ebp),%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
801038e4:	8b 45 0c             	mov    0xc(%ebp),%eax
               "+m" (*addr), "=a" (result) :
801038e7:	8b 4d 08             	mov    0x8(%ebp),%ecx
xchg(volatile uint *addr, uint newval)
{
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
801038ea:	89 c3                	mov    %eax,%ebx
801038ec:	89 d8                	mov    %ebx,%eax
801038ee:	f0 87 02             	lock xchg %eax,(%edx)
801038f1:	89 c3                	mov    %eax,%ebx
801038f3:	89 5d f8             	mov    %ebx,-0x8(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
801038f6:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
801038f9:	83 c4 10             	add    $0x10,%esp
801038fc:	5b                   	pop    %ebx
801038fd:	5d                   	pop    %ebp
801038fe:	c3                   	ret    

801038ff <main>:
// Bootstrap processor starts running C code here.
// Allocate a real stack and switch to it, first
// doing some setup required for memory allocator to work.
int
main(void)
{
801038ff:	55                   	push   %ebp
80103900:	89 e5                	mov    %esp,%ebp
80103902:	83 e4 f0             	and    $0xfffffff0,%esp
80103905:	83 ec 10             	sub    $0x10,%esp
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
80103908:	c7 44 24 04 00 00 40 	movl   $0x80400000,0x4(%esp)
8010390f:	80 
80103910:	c7 04 24 7c 50 11 80 	movl   $0x8011507c,(%esp)
80103917:	e8 ad f5 ff ff       	call   80102ec9 <kinit1>
  kvmalloc();      // kernel page table
8010391c:	e8 8d 4d 00 00       	call   801086ae <kvmalloc>
  mpinit();        // collect info about this machine
80103921:	e8 63 04 00 00       	call   80103d89 <mpinit>
  lapicinit(mpbcpu());
80103926:	e8 2e 02 00 00       	call   80103b59 <mpbcpu>
8010392b:	89 04 24             	mov    %eax,(%esp)
8010392e:	e8 f5 f8 ff ff       	call   80103228 <lapicinit>
  seginit();       // set up segments
80103933:	e8 19 47 00 00       	call   80108051 <seginit>
  cprintf("\ncpu%d: starting xv6\n\n", cpu->id);
80103938:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
8010393e:	0f b6 00             	movzbl (%eax),%eax
80103941:	0f b6 c0             	movzbl %al,%eax
80103944:	89 44 24 04          	mov    %eax,0x4(%esp)
80103948:	c7 04 24 81 90 10 80 	movl   $0x80109081,(%esp)
8010394f:	e8 4d ca ff ff       	call   801003a1 <cprintf>
  picinit();       // interrupt controller
80103954:	e8 95 06 00 00       	call   80103fee <picinit>
  ioapicinit();    // another interrupt controller
80103959:	e8 5b f4 ff ff       	call   80102db9 <ioapicinit>
  consoleinit();   // I/O devices & their interrupts
8010395e:	e8 4e d5 ff ff       	call   80100eb1 <consoleinit>
  uartinit();      // serial port
80103963:	e8 34 3a 00 00       	call   8010739c <uartinit>
  pinit();         // process table
80103968:	e8 c1 0b 00 00       	call   8010452e <pinit>
  tvinit();        // trap vectors
8010396d:	e8 b5 35 00 00       	call   80106f27 <tvinit>
  binit();         // buffer cache
80103972:	e8 bd c6 ff ff       	call   80100034 <binit>
  fileinit();      // file table
80103977:	e8 7c da ff ff       	call   801013f8 <fileinit>
  iinit();         // inode cache
8010397c:	e8 2a e1 ff ff       	call   80101aab <iinit>
  ideinit();       // disk
80103981:	e8 98 f0 ff ff       	call   80102a1e <ideinit>
  if(!ismp)
80103986:	a1 84 1b 11 80       	mov    0x80111b84,%eax
8010398b:	85 c0                	test   %eax,%eax
8010398d:	75 05                	jne    80103994 <main+0x95>
    timerinit();   // uniprocessor timer
8010398f:	e8 d6 34 00 00       	call   80106e6a <timerinit>
  startothers();   // start other processors
80103994:	e8 87 00 00 00       	call   80103a20 <startothers>
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80103999:	c7 44 24 04 00 00 00 	movl   $0x8e000000,0x4(%esp)
801039a0:	8e 
801039a1:	c7 04 24 00 00 40 80 	movl   $0x80400000,(%esp)
801039a8:	e8 54 f5 ff ff       	call   80102f01 <kinit2>
  userinit();      // first user process
801039ad:	e8 ae 0f 00 00       	call   80104960 <userinit>
  // Finish setting up this processor in mpmain.
  mpmain();
801039b2:	e8 22 00 00 00       	call   801039d9 <mpmain>

801039b7 <mpenter>:
}

// Other CPUs jump here from entryother.S.
static void
mpenter(void)
{
801039b7:	55                   	push   %ebp
801039b8:	89 e5                	mov    %esp,%ebp
801039ba:	83 ec 18             	sub    $0x18,%esp
  switchkvm(); 
801039bd:	e8 03 4d 00 00       	call   801086c5 <switchkvm>
  seginit();
801039c2:	e8 8a 46 00 00       	call   80108051 <seginit>
  lapicinit(cpunum());
801039c7:	e8 b9 f9 ff ff       	call   80103385 <cpunum>
801039cc:	89 04 24             	mov    %eax,(%esp)
801039cf:	e8 54 f8 ff ff       	call   80103228 <lapicinit>
  mpmain();
801039d4:	e8 00 00 00 00       	call   801039d9 <mpmain>

801039d9 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
801039d9:	55                   	push   %ebp
801039da:	89 e5                	mov    %esp,%ebp
801039dc:	83 ec 18             	sub    $0x18,%esp
  cprintf("cpu%d: starting\n", cpu->id);
801039df:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801039e5:	0f b6 00             	movzbl (%eax),%eax
801039e8:	0f b6 c0             	movzbl %al,%eax
801039eb:	89 44 24 04          	mov    %eax,0x4(%esp)
801039ef:	c7 04 24 98 90 10 80 	movl   $0x80109098,(%esp)
801039f6:	e8 a6 c9 ff ff       	call   801003a1 <cprintf>
  idtinit();       // load idt register
801039fb:	e8 9b 36 00 00       	call   8010709b <idtinit>
  xchg(&cpu->started, 1); // tell startothers() we're up
80103a00:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80103a06:	05 a8 00 00 00       	add    $0xa8,%eax
80103a0b:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
80103a12:	00 
80103a13:	89 04 24             	mov    %eax,(%esp)
80103a16:	e8 bf fe ff ff       	call   801038da <xchg>
  scheduler();     // start running processes
80103a1b:	e8 6a 17 00 00       	call   8010518a <scheduler>

80103a20 <startothers>:
pde_t entrypgdir[];  // For entry.S

// Start the non-boot (AP) processors.
static void
startothers(void)
{
80103a20:	55                   	push   %ebp
80103a21:	89 e5                	mov    %esp,%ebp
80103a23:	53                   	push   %ebx
80103a24:	83 ec 24             	sub    $0x24,%esp
  char *stack;

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = p2v(0x7000);
80103a27:	c7 04 24 00 70 00 00 	movl   $0x7000,(%esp)
80103a2e:	e8 9a fe ff ff       	call   801038cd <p2v>
80103a33:	89 45 f0             	mov    %eax,-0x10(%ebp)
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80103a36:	b8 8a 00 00 00       	mov    $0x8a,%eax
80103a3b:	89 44 24 08          	mov    %eax,0x8(%esp)
80103a3f:	c7 44 24 04 2c c8 10 	movl   $0x8010c82c,0x4(%esp)
80103a46:	80 
80103a47:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103a4a:	89 04 24             	mov    %eax,(%esp)
80103a4d:	e8 d3 1f 00 00       	call   80105a25 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
80103a52:	c7 45 f4 a0 1b 11 80 	movl   $0x80111ba0,-0xc(%ebp)
80103a59:	e9 86 00 00 00       	jmp    80103ae4 <startothers+0xc4>
    if(c == cpus+cpunum())  // We've started already.
80103a5e:	e8 22 f9 ff ff       	call   80103385 <cpunum>
80103a63:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
80103a69:	05 a0 1b 11 80       	add    $0x80111ba0,%eax
80103a6e:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80103a71:	74 69                	je     80103adc <startothers+0xbc>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what 
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
80103a73:	e8 7f f5 ff ff       	call   80102ff7 <kalloc>
80103a78:	89 45 ec             	mov    %eax,-0x14(%ebp)
    *(void**)(code-4) = stack + KSTACKSIZE;
80103a7b:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103a7e:	83 e8 04             	sub    $0x4,%eax
80103a81:	8b 55 ec             	mov    -0x14(%ebp),%edx
80103a84:	81 c2 00 10 00 00    	add    $0x1000,%edx
80103a8a:	89 10                	mov    %edx,(%eax)
    *(void**)(code-8) = mpenter;
80103a8c:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103a8f:	83 e8 08             	sub    $0x8,%eax
80103a92:	c7 00 b7 39 10 80    	movl   $0x801039b7,(%eax)
    *(int**)(code-12) = (void *) v2p(entrypgdir);
80103a98:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103a9b:	8d 58 f4             	lea    -0xc(%eax),%ebx
80103a9e:	c7 04 24 00 b0 10 80 	movl   $0x8010b000,(%esp)
80103aa5:	e8 16 fe ff ff       	call   801038c0 <v2p>
80103aaa:	89 03                	mov    %eax,(%ebx)

    lapicstartap(c->id, v2p(code));
80103aac:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103aaf:	89 04 24             	mov    %eax,(%esp)
80103ab2:	e8 09 fe ff ff       	call   801038c0 <v2p>
80103ab7:	8b 55 f4             	mov    -0xc(%ebp),%edx
80103aba:	0f b6 12             	movzbl (%edx),%edx
80103abd:	0f b6 d2             	movzbl %dl,%edx
80103ac0:	89 44 24 04          	mov    %eax,0x4(%esp)
80103ac4:	89 14 24             	mov    %edx,(%esp)
80103ac7:	e8 3f f9 ff ff       	call   8010340b <lapicstartap>

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80103acc:	90                   	nop
80103acd:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103ad0:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
80103ad6:	85 c0                	test   %eax,%eax
80103ad8:	74 f3                	je     80103acd <startothers+0xad>
80103ada:	eb 01                	jmp    80103add <startothers+0xbd>
  code = p2v(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);

  for(c = cpus; c < cpus+ncpu; c++){
    if(c == cpus+cpunum())  // We've started already.
      continue;
80103adc:	90                   	nop
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = p2v(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);

  for(c = cpus; c < cpus+ncpu; c++){
80103add:	81 45 f4 bc 00 00 00 	addl   $0xbc,-0xc(%ebp)
80103ae4:	a1 80 21 11 80       	mov    0x80112180,%eax
80103ae9:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
80103aef:	05 a0 1b 11 80       	add    $0x80111ba0,%eax
80103af4:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80103af7:	0f 87 61 ff ff ff    	ja     80103a5e <startothers+0x3e>

    // wait for cpu to finish mpmain()
    while(c->started == 0)
      ;
  }
}
80103afd:	83 c4 24             	add    $0x24,%esp
80103b00:	5b                   	pop    %ebx
80103b01:	5d                   	pop    %ebp
80103b02:	c3                   	ret    
	...

80103b04 <p2v>:
80103b04:	55                   	push   %ebp
80103b05:	89 e5                	mov    %esp,%ebp
80103b07:	8b 45 08             	mov    0x8(%ebp),%eax
80103b0a:	05 00 00 00 80       	add    $0x80000000,%eax
80103b0f:	5d                   	pop    %ebp
80103b10:	c3                   	ret    

80103b11 <inb>:
// Routines to let C code use special x86 instructions.

static inline uchar
inb(ushort port)
{
80103b11:	55                   	push   %ebp
80103b12:	89 e5                	mov    %esp,%ebp
80103b14:	53                   	push   %ebx
80103b15:	83 ec 14             	sub    $0x14,%esp
80103b18:	8b 45 08             	mov    0x8(%ebp),%eax
80103b1b:	66 89 45 e8          	mov    %ax,-0x18(%ebp)
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103b1f:	0f b7 55 e8          	movzwl -0x18(%ebp),%edx
80103b23:	66 89 55 ea          	mov    %dx,-0x16(%ebp)
80103b27:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
80103b2b:	ec                   	in     (%dx),%al
80103b2c:	89 c3                	mov    %eax,%ebx
80103b2e:	88 5d fb             	mov    %bl,-0x5(%ebp)
  return data;
80103b31:	0f b6 45 fb          	movzbl -0x5(%ebp),%eax
}
80103b35:	83 c4 14             	add    $0x14,%esp
80103b38:	5b                   	pop    %ebx
80103b39:	5d                   	pop    %ebp
80103b3a:	c3                   	ret    

80103b3b <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
80103b3b:	55                   	push   %ebp
80103b3c:	89 e5                	mov    %esp,%ebp
80103b3e:	83 ec 08             	sub    $0x8,%esp
80103b41:	8b 55 08             	mov    0x8(%ebp),%edx
80103b44:	8b 45 0c             	mov    0xc(%ebp),%eax
80103b47:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
80103b4b:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103b4e:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80103b52:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
80103b56:	ee                   	out    %al,(%dx)
}
80103b57:	c9                   	leave  
80103b58:	c3                   	ret    

80103b59 <mpbcpu>:
int ncpu;
uchar ioapicid;

int
mpbcpu(void)
{
80103b59:	55                   	push   %ebp
80103b5a:	89 e5                	mov    %esp,%ebp
  return bcpu-cpus;
80103b5c:	a1 84 ce 10 80       	mov    0x8010ce84,%eax
80103b61:	89 c2                	mov    %eax,%edx
80103b63:	b8 a0 1b 11 80       	mov    $0x80111ba0,%eax
80103b68:	89 d1                	mov    %edx,%ecx
80103b6a:	29 c1                	sub    %eax,%ecx
80103b6c:	89 c8                	mov    %ecx,%eax
80103b6e:	c1 f8 02             	sar    $0x2,%eax
80103b71:	69 c0 cf 46 7d 67    	imul   $0x677d46cf,%eax,%eax
}
80103b77:	5d                   	pop    %ebp
80103b78:	c3                   	ret    

80103b79 <sum>:

static uchar
sum(uchar *addr, int len)
{
80103b79:	55                   	push   %ebp
80103b7a:	89 e5                	mov    %esp,%ebp
80103b7c:	83 ec 10             	sub    $0x10,%esp
  int i, sum;
  
  sum = 0;
80103b7f:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  for(i=0; i<len; i++)
80103b86:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
80103b8d:	eb 13                	jmp    80103ba2 <sum+0x29>
    sum += addr[i];
80103b8f:	8b 45 fc             	mov    -0x4(%ebp),%eax
80103b92:	03 45 08             	add    0x8(%ebp),%eax
80103b95:	0f b6 00             	movzbl (%eax),%eax
80103b98:	0f b6 c0             	movzbl %al,%eax
80103b9b:	01 45 f8             	add    %eax,-0x8(%ebp)
sum(uchar *addr, int len)
{
  int i, sum;
  
  sum = 0;
  for(i=0; i<len; i++)
80103b9e:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
80103ba2:	8b 45 fc             	mov    -0x4(%ebp),%eax
80103ba5:	3b 45 0c             	cmp    0xc(%ebp),%eax
80103ba8:	7c e5                	jl     80103b8f <sum+0x16>
    sum += addr[i];
  return sum;
80103baa:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
80103bad:	c9                   	leave  
80103bae:	c3                   	ret    

80103baf <mpsearch1>:

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80103baf:	55                   	push   %ebp
80103bb0:	89 e5                	mov    %esp,%ebp
80103bb2:	83 ec 28             	sub    $0x28,%esp
  uchar *e, *p, *addr;

  addr = p2v(a);
80103bb5:	8b 45 08             	mov    0x8(%ebp),%eax
80103bb8:	89 04 24             	mov    %eax,(%esp)
80103bbb:	e8 44 ff ff ff       	call   80103b04 <p2v>
80103bc0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  e = addr+len;
80103bc3:	8b 45 0c             	mov    0xc(%ebp),%eax
80103bc6:	03 45 f0             	add    -0x10(%ebp),%eax
80103bc9:	89 45 ec             	mov    %eax,-0x14(%ebp)
  for(p = addr; p < e; p += sizeof(struct mp))
80103bcc:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103bcf:	89 45 f4             	mov    %eax,-0xc(%ebp)
80103bd2:	eb 3f                	jmp    80103c13 <mpsearch1+0x64>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103bd4:	c7 44 24 08 04 00 00 	movl   $0x4,0x8(%esp)
80103bdb:	00 
80103bdc:	c7 44 24 04 ac 90 10 	movl   $0x801090ac,0x4(%esp)
80103be3:	80 
80103be4:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103be7:	89 04 24             	mov    %eax,(%esp)
80103bea:	e8 da 1d 00 00       	call   801059c9 <memcmp>
80103bef:	85 c0                	test   %eax,%eax
80103bf1:	75 1c                	jne    80103c0f <mpsearch1+0x60>
80103bf3:	c7 44 24 04 10 00 00 	movl   $0x10,0x4(%esp)
80103bfa:	00 
80103bfb:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103bfe:	89 04 24             	mov    %eax,(%esp)
80103c01:	e8 73 ff ff ff       	call   80103b79 <sum>
80103c06:	84 c0                	test   %al,%al
80103c08:	75 05                	jne    80103c0f <mpsearch1+0x60>
      return (struct mp*)p;
80103c0a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103c0d:	eb 11                	jmp    80103c20 <mpsearch1+0x71>
{
  uchar *e, *p, *addr;

  addr = p2v(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
80103c0f:	83 45 f4 10          	addl   $0x10,-0xc(%ebp)
80103c13:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103c16:	3b 45 ec             	cmp    -0x14(%ebp),%eax
80103c19:	72 b9                	jb     80103bd4 <mpsearch1+0x25>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
      return (struct mp*)p;
  return 0;
80103c1b:	b8 00 00 00 00       	mov    $0x0,%eax
}
80103c20:	c9                   	leave  
80103c21:	c3                   	ret    

80103c22 <mpsearch>:
// 1) in the first KB of the EBDA;
// 2) in the last KB of system base memory;
// 3) in the BIOS ROM between 0xE0000 and 0xFFFFF.
static struct mp*
mpsearch(void)
{
80103c22:	55                   	push   %ebp
80103c23:	89 e5                	mov    %esp,%ebp
80103c25:	83 ec 28             	sub    $0x28,%esp
  uchar *bda;
  uint p;
  struct mp *mp;

  bda = (uchar *) P2V(0x400);
80103c28:	c7 45 f4 00 04 00 80 	movl   $0x80000400,-0xc(%ebp)
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
80103c2f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103c32:	83 c0 0f             	add    $0xf,%eax
80103c35:	0f b6 00             	movzbl (%eax),%eax
80103c38:	0f b6 c0             	movzbl %al,%eax
80103c3b:	89 c2                	mov    %eax,%edx
80103c3d:	c1 e2 08             	shl    $0x8,%edx
80103c40:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103c43:	83 c0 0e             	add    $0xe,%eax
80103c46:	0f b6 00             	movzbl (%eax),%eax
80103c49:	0f b6 c0             	movzbl %al,%eax
80103c4c:	09 d0                	or     %edx,%eax
80103c4e:	c1 e0 04             	shl    $0x4,%eax
80103c51:	89 45 f0             	mov    %eax,-0x10(%ebp)
80103c54:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80103c58:	74 21                	je     80103c7b <mpsearch+0x59>
    if((mp = mpsearch1(p, 1024)))
80103c5a:	c7 44 24 04 00 04 00 	movl   $0x400,0x4(%esp)
80103c61:	00 
80103c62:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103c65:	89 04 24             	mov    %eax,(%esp)
80103c68:	e8 42 ff ff ff       	call   80103baf <mpsearch1>
80103c6d:	89 45 ec             	mov    %eax,-0x14(%ebp)
80103c70:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80103c74:	74 50                	je     80103cc6 <mpsearch+0xa4>
      return mp;
80103c76:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103c79:	eb 5f                	jmp    80103cda <mpsearch+0xb8>
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
80103c7b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103c7e:	83 c0 14             	add    $0x14,%eax
80103c81:	0f b6 00             	movzbl (%eax),%eax
80103c84:	0f b6 c0             	movzbl %al,%eax
80103c87:	89 c2                	mov    %eax,%edx
80103c89:	c1 e2 08             	shl    $0x8,%edx
80103c8c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103c8f:	83 c0 13             	add    $0x13,%eax
80103c92:	0f b6 00             	movzbl (%eax),%eax
80103c95:	0f b6 c0             	movzbl %al,%eax
80103c98:	09 d0                	or     %edx,%eax
80103c9a:	c1 e0 0a             	shl    $0xa,%eax
80103c9d:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if((mp = mpsearch1(p-1024, 1024)))
80103ca0:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103ca3:	2d 00 04 00 00       	sub    $0x400,%eax
80103ca8:	c7 44 24 04 00 04 00 	movl   $0x400,0x4(%esp)
80103caf:	00 
80103cb0:	89 04 24             	mov    %eax,(%esp)
80103cb3:	e8 f7 fe ff ff       	call   80103baf <mpsearch1>
80103cb8:	89 45 ec             	mov    %eax,-0x14(%ebp)
80103cbb:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80103cbf:	74 05                	je     80103cc6 <mpsearch+0xa4>
      return mp;
80103cc1:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103cc4:	eb 14                	jmp    80103cda <mpsearch+0xb8>
  }
  return mpsearch1(0xF0000, 0x10000);
80103cc6:	c7 44 24 04 00 00 01 	movl   $0x10000,0x4(%esp)
80103ccd:	00 
80103cce:	c7 04 24 00 00 0f 00 	movl   $0xf0000,(%esp)
80103cd5:	e8 d5 fe ff ff       	call   80103baf <mpsearch1>
}
80103cda:	c9                   	leave  
80103cdb:	c3                   	ret    

80103cdc <mpconfig>:
// Check for correct signature, calculate the checksum and,
// if correct, check the version.
// To do: check extended table checksum.
static struct mpconf*
mpconfig(struct mp **pmp)
{
80103cdc:	55                   	push   %ebp
80103cdd:	89 e5                	mov    %esp,%ebp
80103cdf:	83 ec 28             	sub    $0x28,%esp
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103ce2:	e8 3b ff ff ff       	call   80103c22 <mpsearch>
80103ce7:	89 45 f4             	mov    %eax,-0xc(%ebp)
80103cea:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80103cee:	74 0a                	je     80103cfa <mpconfig+0x1e>
80103cf0:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103cf3:	8b 40 04             	mov    0x4(%eax),%eax
80103cf6:	85 c0                	test   %eax,%eax
80103cf8:	75 0a                	jne    80103d04 <mpconfig+0x28>
    return 0;
80103cfa:	b8 00 00 00 00       	mov    $0x0,%eax
80103cff:	e9 83 00 00 00       	jmp    80103d87 <mpconfig+0xab>
  conf = (struct mpconf*) p2v((uint) mp->physaddr);
80103d04:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103d07:	8b 40 04             	mov    0x4(%eax),%eax
80103d0a:	89 04 24             	mov    %eax,(%esp)
80103d0d:	e8 f2 fd ff ff       	call   80103b04 <p2v>
80103d12:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(memcmp(conf, "PCMP", 4) != 0)
80103d15:	c7 44 24 08 04 00 00 	movl   $0x4,0x8(%esp)
80103d1c:	00 
80103d1d:	c7 44 24 04 b1 90 10 	movl   $0x801090b1,0x4(%esp)
80103d24:	80 
80103d25:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103d28:	89 04 24             	mov    %eax,(%esp)
80103d2b:	e8 99 1c 00 00       	call   801059c9 <memcmp>
80103d30:	85 c0                	test   %eax,%eax
80103d32:	74 07                	je     80103d3b <mpconfig+0x5f>
    return 0;
80103d34:	b8 00 00 00 00       	mov    $0x0,%eax
80103d39:	eb 4c                	jmp    80103d87 <mpconfig+0xab>
  if(conf->version != 1 && conf->version != 4)
80103d3b:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103d3e:	0f b6 40 06          	movzbl 0x6(%eax),%eax
80103d42:	3c 01                	cmp    $0x1,%al
80103d44:	74 12                	je     80103d58 <mpconfig+0x7c>
80103d46:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103d49:	0f b6 40 06          	movzbl 0x6(%eax),%eax
80103d4d:	3c 04                	cmp    $0x4,%al
80103d4f:	74 07                	je     80103d58 <mpconfig+0x7c>
    return 0;
80103d51:	b8 00 00 00 00       	mov    $0x0,%eax
80103d56:	eb 2f                	jmp    80103d87 <mpconfig+0xab>
  if(sum((uchar*)conf, conf->length) != 0)
80103d58:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103d5b:	0f b7 40 04          	movzwl 0x4(%eax),%eax
80103d5f:	0f b7 c0             	movzwl %ax,%eax
80103d62:	89 44 24 04          	mov    %eax,0x4(%esp)
80103d66:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103d69:	89 04 24             	mov    %eax,(%esp)
80103d6c:	e8 08 fe ff ff       	call   80103b79 <sum>
80103d71:	84 c0                	test   %al,%al
80103d73:	74 07                	je     80103d7c <mpconfig+0xa0>
    return 0;
80103d75:	b8 00 00 00 00       	mov    $0x0,%eax
80103d7a:	eb 0b                	jmp    80103d87 <mpconfig+0xab>
  *pmp = mp;
80103d7c:	8b 45 08             	mov    0x8(%ebp),%eax
80103d7f:	8b 55 f4             	mov    -0xc(%ebp),%edx
80103d82:	89 10                	mov    %edx,(%eax)
  return conf;
80103d84:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
80103d87:	c9                   	leave  
80103d88:	c3                   	ret    

80103d89 <mpinit>:

void
mpinit(void)
{
80103d89:	55                   	push   %ebp
80103d8a:	89 e5                	mov    %esp,%ebp
80103d8c:	83 ec 38             	sub    $0x38,%esp
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  bcpu = &cpus[0];
80103d8f:	c7 05 84 ce 10 80 a0 	movl   $0x80111ba0,0x8010ce84
80103d96:	1b 11 80 
  if((conf = mpconfig(&mp)) == 0)
80103d99:	8d 45 e0             	lea    -0x20(%ebp),%eax
80103d9c:	89 04 24             	mov    %eax,(%esp)
80103d9f:	e8 38 ff ff ff       	call   80103cdc <mpconfig>
80103da4:	89 45 f0             	mov    %eax,-0x10(%ebp)
80103da7:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80103dab:	0f 84 9c 01 00 00    	je     80103f4d <mpinit+0x1c4>
    return;
  ismp = 1;
80103db1:	c7 05 84 1b 11 80 01 	movl   $0x1,0x80111b84
80103db8:	00 00 00 
  lapic = (uint*)conf->lapicaddr;
80103dbb:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103dbe:	8b 40 24             	mov    0x24(%eax),%eax
80103dc1:	a3 fc 1a 11 80       	mov    %eax,0x80111afc
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103dc6:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103dc9:	83 c0 2c             	add    $0x2c,%eax
80103dcc:	89 45 f4             	mov    %eax,-0xc(%ebp)
80103dcf:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103dd2:	0f b7 40 04          	movzwl 0x4(%eax),%eax
80103dd6:	0f b7 c0             	movzwl %ax,%eax
80103dd9:	03 45 f0             	add    -0x10(%ebp),%eax
80103ddc:	89 45 ec             	mov    %eax,-0x14(%ebp)
80103ddf:	e9 f4 00 00 00       	jmp    80103ed8 <mpinit+0x14f>
    switch(*p){
80103de4:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103de7:	0f b6 00             	movzbl (%eax),%eax
80103dea:	0f b6 c0             	movzbl %al,%eax
80103ded:	83 f8 04             	cmp    $0x4,%eax
80103df0:	0f 87 bf 00 00 00    	ja     80103eb5 <mpinit+0x12c>
80103df6:	8b 04 85 f4 90 10 80 	mov    -0x7fef6f0c(,%eax,4),%eax
80103dfd:	ff e0                	jmp    *%eax
    case MPPROC:
      proc = (struct mpproc*)p;
80103dff:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103e02:	89 45 e8             	mov    %eax,-0x18(%ebp)
      if(ncpu != proc->apicid){
80103e05:	8b 45 e8             	mov    -0x18(%ebp),%eax
80103e08:	0f b6 40 01          	movzbl 0x1(%eax),%eax
80103e0c:	0f b6 d0             	movzbl %al,%edx
80103e0f:	a1 80 21 11 80       	mov    0x80112180,%eax
80103e14:	39 c2                	cmp    %eax,%edx
80103e16:	74 2d                	je     80103e45 <mpinit+0xbc>
        cprintf("mpinit: ncpu=%d apicid=%d\n", ncpu, proc->apicid);
80103e18:	8b 45 e8             	mov    -0x18(%ebp),%eax
80103e1b:	0f b6 40 01          	movzbl 0x1(%eax),%eax
80103e1f:	0f b6 d0             	movzbl %al,%edx
80103e22:	a1 80 21 11 80       	mov    0x80112180,%eax
80103e27:	89 54 24 08          	mov    %edx,0x8(%esp)
80103e2b:	89 44 24 04          	mov    %eax,0x4(%esp)
80103e2f:	c7 04 24 b6 90 10 80 	movl   $0x801090b6,(%esp)
80103e36:	e8 66 c5 ff ff       	call   801003a1 <cprintf>
        ismp = 0;
80103e3b:	c7 05 84 1b 11 80 00 	movl   $0x0,0x80111b84
80103e42:	00 00 00 
      }
      if(proc->flags & MPBOOT)
80103e45:	8b 45 e8             	mov    -0x18(%ebp),%eax
80103e48:	0f b6 40 03          	movzbl 0x3(%eax),%eax
80103e4c:	0f b6 c0             	movzbl %al,%eax
80103e4f:	83 e0 02             	and    $0x2,%eax
80103e52:	85 c0                	test   %eax,%eax
80103e54:	74 15                	je     80103e6b <mpinit+0xe2>
        bcpu = &cpus[ncpu];
80103e56:	a1 80 21 11 80       	mov    0x80112180,%eax
80103e5b:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
80103e61:	05 a0 1b 11 80       	add    $0x80111ba0,%eax
80103e66:	a3 84 ce 10 80       	mov    %eax,0x8010ce84
      cpus[ncpu].id = ncpu;
80103e6b:	8b 15 80 21 11 80    	mov    0x80112180,%edx
80103e71:	a1 80 21 11 80       	mov    0x80112180,%eax
80103e76:	69 d2 bc 00 00 00    	imul   $0xbc,%edx,%edx
80103e7c:	81 c2 a0 1b 11 80    	add    $0x80111ba0,%edx
80103e82:	88 02                	mov    %al,(%edx)
      ncpu++;
80103e84:	a1 80 21 11 80       	mov    0x80112180,%eax
80103e89:	83 c0 01             	add    $0x1,%eax
80103e8c:	a3 80 21 11 80       	mov    %eax,0x80112180
      p += sizeof(struct mpproc);
80103e91:	83 45 f4 14          	addl   $0x14,-0xc(%ebp)
      continue;
80103e95:	eb 41                	jmp    80103ed8 <mpinit+0x14f>
    case MPIOAPIC:
      ioapic = (struct mpioapic*)p;
80103e97:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103e9a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      ioapicid = ioapic->apicno;
80103e9d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103ea0:	0f b6 40 01          	movzbl 0x1(%eax),%eax
80103ea4:	a2 80 1b 11 80       	mov    %al,0x80111b80
      p += sizeof(struct mpioapic);
80103ea9:	83 45 f4 08          	addl   $0x8,-0xc(%ebp)
      continue;
80103ead:	eb 29                	jmp    80103ed8 <mpinit+0x14f>
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
80103eaf:	83 45 f4 08          	addl   $0x8,-0xc(%ebp)
      continue;
80103eb3:	eb 23                	jmp    80103ed8 <mpinit+0x14f>
    default:
      cprintf("mpinit: unknown config type %x\n", *p);
80103eb5:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103eb8:	0f b6 00             	movzbl (%eax),%eax
80103ebb:	0f b6 c0             	movzbl %al,%eax
80103ebe:	89 44 24 04          	mov    %eax,0x4(%esp)
80103ec2:	c7 04 24 d4 90 10 80 	movl   $0x801090d4,(%esp)
80103ec9:	e8 d3 c4 ff ff       	call   801003a1 <cprintf>
      ismp = 0;
80103ece:	c7 05 84 1b 11 80 00 	movl   $0x0,0x80111b84
80103ed5:	00 00 00 
  bcpu = &cpus[0];
  if((conf = mpconfig(&mp)) == 0)
    return;
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103ed8:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103edb:	3b 45 ec             	cmp    -0x14(%ebp),%eax
80103ede:	0f 82 00 ff ff ff    	jb     80103de4 <mpinit+0x5b>
    default:
      cprintf("mpinit: unknown config type %x\n", *p);
      ismp = 0;
    }
  }
  if(!ismp){
80103ee4:	a1 84 1b 11 80       	mov    0x80111b84,%eax
80103ee9:	85 c0                	test   %eax,%eax
80103eeb:	75 1d                	jne    80103f0a <mpinit+0x181>
    // Didn't like what we found; fall back to no MP.
    ncpu = 1;
80103eed:	c7 05 80 21 11 80 01 	movl   $0x1,0x80112180
80103ef4:	00 00 00 
    lapic = 0;
80103ef7:	c7 05 fc 1a 11 80 00 	movl   $0x0,0x80111afc
80103efe:	00 00 00 
    ioapicid = 0;
80103f01:	c6 05 80 1b 11 80 00 	movb   $0x0,0x80111b80
    return;
80103f08:	eb 44                	jmp    80103f4e <mpinit+0x1c5>
  }

  if(mp->imcrp){
80103f0a:	8b 45 e0             	mov    -0x20(%ebp),%eax
80103f0d:	0f b6 40 0c          	movzbl 0xc(%eax),%eax
80103f11:	84 c0                	test   %al,%al
80103f13:	74 39                	je     80103f4e <mpinit+0x1c5>
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
80103f15:	c7 44 24 04 70 00 00 	movl   $0x70,0x4(%esp)
80103f1c:	00 
80103f1d:	c7 04 24 22 00 00 00 	movl   $0x22,(%esp)
80103f24:	e8 12 fc ff ff       	call   80103b3b <outb>
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
80103f29:	c7 04 24 23 00 00 00 	movl   $0x23,(%esp)
80103f30:	e8 dc fb ff ff       	call   80103b11 <inb>
80103f35:	83 c8 01             	or     $0x1,%eax
80103f38:	0f b6 c0             	movzbl %al,%eax
80103f3b:	89 44 24 04          	mov    %eax,0x4(%esp)
80103f3f:	c7 04 24 23 00 00 00 	movl   $0x23,(%esp)
80103f46:	e8 f0 fb ff ff       	call   80103b3b <outb>
80103f4b:	eb 01                	jmp    80103f4e <mpinit+0x1c5>
  struct mpproc *proc;
  struct mpioapic *ioapic;

  bcpu = &cpus[0];
  if((conf = mpconfig(&mp)) == 0)
    return;
80103f4d:	90                   	nop
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
  }
}
80103f4e:	c9                   	leave  
80103f4f:	c3                   	ret    

80103f50 <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
80103f50:	55                   	push   %ebp
80103f51:	89 e5                	mov    %esp,%ebp
80103f53:	83 ec 08             	sub    $0x8,%esp
80103f56:	8b 55 08             	mov    0x8(%ebp),%edx
80103f59:	8b 45 0c             	mov    0xc(%ebp),%eax
80103f5c:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
80103f60:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103f63:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80103f67:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
80103f6b:	ee                   	out    %al,(%dx)
}
80103f6c:	c9                   	leave  
80103f6d:	c3                   	ret    

80103f6e <picsetmask>:
// Initial IRQ mask has interrupt 2 enabled (for slave 8259A).
static ushort irqmask = 0xFFFF & ~(1<<IRQ_SLAVE);

static void
picsetmask(ushort mask)
{
80103f6e:	55                   	push   %ebp
80103f6f:	89 e5                	mov    %esp,%ebp
80103f71:	83 ec 0c             	sub    $0xc,%esp
80103f74:	8b 45 08             	mov    0x8(%ebp),%eax
80103f77:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  irqmask = mask;
80103f7b:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
80103f7f:	66 a3 00 c0 10 80    	mov    %ax,0x8010c000
  outb(IO_PIC1+1, mask);
80103f85:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
80103f89:	0f b6 c0             	movzbl %al,%eax
80103f8c:	89 44 24 04          	mov    %eax,0x4(%esp)
80103f90:	c7 04 24 21 00 00 00 	movl   $0x21,(%esp)
80103f97:	e8 b4 ff ff ff       	call   80103f50 <outb>
  outb(IO_PIC2+1, mask >> 8);
80103f9c:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
80103fa0:	66 c1 e8 08          	shr    $0x8,%ax
80103fa4:	0f b6 c0             	movzbl %al,%eax
80103fa7:	89 44 24 04          	mov    %eax,0x4(%esp)
80103fab:	c7 04 24 a1 00 00 00 	movl   $0xa1,(%esp)
80103fb2:	e8 99 ff ff ff       	call   80103f50 <outb>
}
80103fb7:	c9                   	leave  
80103fb8:	c3                   	ret    

80103fb9 <picenable>:

void
picenable(int irq)
{
80103fb9:	55                   	push   %ebp
80103fba:	89 e5                	mov    %esp,%ebp
80103fbc:	53                   	push   %ebx
80103fbd:	83 ec 04             	sub    $0x4,%esp
  picsetmask(irqmask & ~(1<<irq));
80103fc0:	8b 45 08             	mov    0x8(%ebp),%eax
80103fc3:	ba 01 00 00 00       	mov    $0x1,%edx
80103fc8:	89 d3                	mov    %edx,%ebx
80103fca:	89 c1                	mov    %eax,%ecx
80103fcc:	d3 e3                	shl    %cl,%ebx
80103fce:	89 d8                	mov    %ebx,%eax
80103fd0:	89 c2                	mov    %eax,%edx
80103fd2:	f7 d2                	not    %edx
80103fd4:	0f b7 05 00 c0 10 80 	movzwl 0x8010c000,%eax
80103fdb:	21 d0                	and    %edx,%eax
80103fdd:	0f b7 c0             	movzwl %ax,%eax
80103fe0:	89 04 24             	mov    %eax,(%esp)
80103fe3:	e8 86 ff ff ff       	call   80103f6e <picsetmask>
}
80103fe8:	83 c4 04             	add    $0x4,%esp
80103feb:	5b                   	pop    %ebx
80103fec:	5d                   	pop    %ebp
80103fed:	c3                   	ret    

80103fee <picinit>:

// Initialize the 8259A interrupt controllers.
void
picinit(void)
{
80103fee:	55                   	push   %ebp
80103fef:	89 e5                	mov    %esp,%ebp
80103ff1:	83 ec 08             	sub    $0x8,%esp
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
80103ff4:	c7 44 24 04 ff 00 00 	movl   $0xff,0x4(%esp)
80103ffb:	00 
80103ffc:	c7 04 24 21 00 00 00 	movl   $0x21,(%esp)
80104003:	e8 48 ff ff ff       	call   80103f50 <outb>
  outb(IO_PIC2+1, 0xFF);
80104008:	c7 44 24 04 ff 00 00 	movl   $0xff,0x4(%esp)
8010400f:	00 
80104010:	c7 04 24 a1 00 00 00 	movl   $0xa1,(%esp)
80104017:	e8 34 ff ff ff       	call   80103f50 <outb>

  // ICW1:  0001g0hi
  //    g:  0 = edge triggering, 1 = level triggering
  //    h:  0 = cascaded PICs, 1 = master only
  //    i:  0 = no ICW4, 1 = ICW4 required
  outb(IO_PIC1, 0x11);
8010401c:	c7 44 24 04 11 00 00 	movl   $0x11,0x4(%esp)
80104023:	00 
80104024:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
8010402b:	e8 20 ff ff ff       	call   80103f50 <outb>

  // ICW2:  Vector offset
  outb(IO_PIC1+1, T_IRQ0);
80104030:	c7 44 24 04 20 00 00 	movl   $0x20,0x4(%esp)
80104037:	00 
80104038:	c7 04 24 21 00 00 00 	movl   $0x21,(%esp)
8010403f:	e8 0c ff ff ff       	call   80103f50 <outb>

  // ICW3:  (master PIC) bit mask of IR lines connected to slaves
  //        (slave PIC) 3-bit # of slave's connection to master
  outb(IO_PIC1+1, 1<<IRQ_SLAVE);
80104044:	c7 44 24 04 04 00 00 	movl   $0x4,0x4(%esp)
8010404b:	00 
8010404c:	c7 04 24 21 00 00 00 	movl   $0x21,(%esp)
80104053:	e8 f8 fe ff ff       	call   80103f50 <outb>
  //    m:  0 = slave PIC, 1 = master PIC
  //      (ignored when b is 0, as the master/slave role
  //      can be hardwired).
  //    a:  1 = Automatic EOI mode
  //    p:  0 = MCS-80/85 mode, 1 = intel x86 mode
  outb(IO_PIC1+1, 0x3);
80104058:	c7 44 24 04 03 00 00 	movl   $0x3,0x4(%esp)
8010405f:	00 
80104060:	c7 04 24 21 00 00 00 	movl   $0x21,(%esp)
80104067:	e8 e4 fe ff ff       	call   80103f50 <outb>

  // Set up slave (8259A-2)
  outb(IO_PIC2, 0x11);                  // ICW1
8010406c:	c7 44 24 04 11 00 00 	movl   $0x11,0x4(%esp)
80104073:	00 
80104074:	c7 04 24 a0 00 00 00 	movl   $0xa0,(%esp)
8010407b:	e8 d0 fe ff ff       	call   80103f50 <outb>
  outb(IO_PIC2+1, T_IRQ0 + 8);      // ICW2
80104080:	c7 44 24 04 28 00 00 	movl   $0x28,0x4(%esp)
80104087:	00 
80104088:	c7 04 24 a1 00 00 00 	movl   $0xa1,(%esp)
8010408f:	e8 bc fe ff ff       	call   80103f50 <outb>
  outb(IO_PIC2+1, IRQ_SLAVE);           // ICW3
80104094:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
8010409b:	00 
8010409c:	c7 04 24 a1 00 00 00 	movl   $0xa1,(%esp)
801040a3:	e8 a8 fe ff ff       	call   80103f50 <outb>
  // NB Automatic EOI mode doesn't tend to work on the slave.
  // Linux source code says it's "to be investigated".
  outb(IO_PIC2+1, 0x3);                 // ICW4
801040a8:	c7 44 24 04 03 00 00 	movl   $0x3,0x4(%esp)
801040af:	00 
801040b0:	c7 04 24 a1 00 00 00 	movl   $0xa1,(%esp)
801040b7:	e8 94 fe ff ff       	call   80103f50 <outb>

  // OCW3:  0ef01prs
  //   ef:  0x = NOP, 10 = clear specific mask, 11 = set specific mask
  //    p:  0 = no polling, 1 = polling mode
  //   rs:  0x = NOP, 10 = read IRR, 11 = read ISR
  outb(IO_PIC1, 0x68);             // clear specific mask
801040bc:	c7 44 24 04 68 00 00 	movl   $0x68,0x4(%esp)
801040c3:	00 
801040c4:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801040cb:	e8 80 fe ff ff       	call   80103f50 <outb>
  outb(IO_PIC1, 0x0a);             // read IRR by default
801040d0:	c7 44 24 04 0a 00 00 	movl   $0xa,0x4(%esp)
801040d7:	00 
801040d8:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801040df:	e8 6c fe ff ff       	call   80103f50 <outb>

  outb(IO_PIC2, 0x68);             // OCW3
801040e4:	c7 44 24 04 68 00 00 	movl   $0x68,0x4(%esp)
801040eb:	00 
801040ec:	c7 04 24 a0 00 00 00 	movl   $0xa0,(%esp)
801040f3:	e8 58 fe ff ff       	call   80103f50 <outb>
  outb(IO_PIC2, 0x0a);             // OCW3
801040f8:	c7 44 24 04 0a 00 00 	movl   $0xa,0x4(%esp)
801040ff:	00 
80104100:	c7 04 24 a0 00 00 00 	movl   $0xa0,(%esp)
80104107:	e8 44 fe ff ff       	call   80103f50 <outb>

  if(irqmask != 0xFFFF)
8010410c:	0f b7 05 00 c0 10 80 	movzwl 0x8010c000,%eax
80104113:	66 83 f8 ff          	cmp    $0xffff,%ax
80104117:	74 12                	je     8010412b <picinit+0x13d>
    picsetmask(irqmask);
80104119:	0f b7 05 00 c0 10 80 	movzwl 0x8010c000,%eax
80104120:	0f b7 c0             	movzwl %ax,%eax
80104123:	89 04 24             	mov    %eax,(%esp)
80104126:	e8 43 fe ff ff       	call   80103f6e <picsetmask>
}
8010412b:	c9                   	leave  
8010412c:	c3                   	ret    
8010412d:	00 00                	add    %al,(%eax)
	...

80104130 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
80104130:	55                   	push   %ebp
80104131:	89 e5                	mov    %esp,%ebp
80104133:	83 ec 28             	sub    $0x28,%esp
  struct pipe *p;

  p = 0;
80104136:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  *f0 = *f1 = 0;
8010413d:	8b 45 0c             	mov    0xc(%ebp),%eax
80104140:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80104146:	8b 45 0c             	mov    0xc(%ebp),%eax
80104149:	8b 10                	mov    (%eax),%edx
8010414b:	8b 45 08             	mov    0x8(%ebp),%eax
8010414e:	89 10                	mov    %edx,(%eax)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
80104150:	e8 bf d2 ff ff       	call   80101414 <filealloc>
80104155:	8b 55 08             	mov    0x8(%ebp),%edx
80104158:	89 02                	mov    %eax,(%edx)
8010415a:	8b 45 08             	mov    0x8(%ebp),%eax
8010415d:	8b 00                	mov    (%eax),%eax
8010415f:	85 c0                	test   %eax,%eax
80104161:	0f 84 c8 00 00 00    	je     8010422f <pipealloc+0xff>
80104167:	e8 a8 d2 ff ff       	call   80101414 <filealloc>
8010416c:	8b 55 0c             	mov    0xc(%ebp),%edx
8010416f:	89 02                	mov    %eax,(%edx)
80104171:	8b 45 0c             	mov    0xc(%ebp),%eax
80104174:	8b 00                	mov    (%eax),%eax
80104176:	85 c0                	test   %eax,%eax
80104178:	0f 84 b1 00 00 00    	je     8010422f <pipealloc+0xff>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
8010417e:	e8 74 ee ff ff       	call   80102ff7 <kalloc>
80104183:	89 45 f4             	mov    %eax,-0xc(%ebp)
80104186:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010418a:	0f 84 9e 00 00 00    	je     8010422e <pipealloc+0xfe>
    goto bad;
  p->readopen = 1;
80104190:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104193:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
8010419a:	00 00 00 
  p->writeopen = 1;
8010419d:	8b 45 f4             	mov    -0xc(%ebp),%eax
801041a0:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
801041a7:	00 00 00 
  p->nwrite = 0;
801041aa:	8b 45 f4             	mov    -0xc(%ebp),%eax
801041ad:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
801041b4:	00 00 00 
  p->nread = 0;
801041b7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801041ba:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
801041c1:	00 00 00 
  initlock(&p->lock, "pipe");
801041c4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801041c7:	c7 44 24 04 08 91 10 	movl   $0x80109108,0x4(%esp)
801041ce:	80 
801041cf:	89 04 24             	mov    %eax,(%esp)
801041d2:	e8 0b 15 00 00       	call   801056e2 <initlock>
  (*f0)->type = FD_PIPE;
801041d7:	8b 45 08             	mov    0x8(%ebp),%eax
801041da:	8b 00                	mov    (%eax),%eax
801041dc:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
801041e2:	8b 45 08             	mov    0x8(%ebp),%eax
801041e5:	8b 00                	mov    (%eax),%eax
801041e7:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
801041eb:	8b 45 08             	mov    0x8(%ebp),%eax
801041ee:	8b 00                	mov    (%eax),%eax
801041f0:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
801041f4:	8b 45 08             	mov    0x8(%ebp),%eax
801041f7:	8b 00                	mov    (%eax),%eax
801041f9:	8b 55 f4             	mov    -0xc(%ebp),%edx
801041fc:	89 50 0c             	mov    %edx,0xc(%eax)
  (*f1)->type = FD_PIPE;
801041ff:	8b 45 0c             	mov    0xc(%ebp),%eax
80104202:	8b 00                	mov    (%eax),%eax
80104204:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
8010420a:	8b 45 0c             	mov    0xc(%ebp),%eax
8010420d:	8b 00                	mov    (%eax),%eax
8010420f:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
80104213:	8b 45 0c             	mov    0xc(%ebp),%eax
80104216:	8b 00                	mov    (%eax),%eax
80104218:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
8010421c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010421f:	8b 00                	mov    (%eax),%eax
80104221:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104224:	89 50 0c             	mov    %edx,0xc(%eax)
  return 0;
80104227:	b8 00 00 00 00       	mov    $0x0,%eax
8010422c:	eb 43                	jmp    80104271 <pipealloc+0x141>
  p = 0;
  *f0 = *f1 = 0;
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
    goto bad;
8010422e:	90                   	nop
  (*f1)->pipe = p;
  return 0;

//PAGEBREAK: 20
 bad:
  if(p)
8010422f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80104233:	74 0b                	je     80104240 <pipealloc+0x110>
    kfree((char*)p);
80104235:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104238:	89 04 24             	mov    %eax,(%esp)
8010423b:	e8 1e ed ff ff       	call   80102f5e <kfree>
  if(*f0)
80104240:	8b 45 08             	mov    0x8(%ebp),%eax
80104243:	8b 00                	mov    (%eax),%eax
80104245:	85 c0                	test   %eax,%eax
80104247:	74 0d                	je     80104256 <pipealloc+0x126>
    fileclose(*f0);
80104249:	8b 45 08             	mov    0x8(%ebp),%eax
8010424c:	8b 00                	mov    (%eax),%eax
8010424e:	89 04 24             	mov    %eax,(%esp)
80104251:	e8 66 d2 ff ff       	call   801014bc <fileclose>
  if(*f1)
80104256:	8b 45 0c             	mov    0xc(%ebp),%eax
80104259:	8b 00                	mov    (%eax),%eax
8010425b:	85 c0                	test   %eax,%eax
8010425d:	74 0d                	je     8010426c <pipealloc+0x13c>
    fileclose(*f1);
8010425f:	8b 45 0c             	mov    0xc(%ebp),%eax
80104262:	8b 00                	mov    (%eax),%eax
80104264:	89 04 24             	mov    %eax,(%esp)
80104267:	e8 50 d2 ff ff       	call   801014bc <fileclose>
  return -1;
8010426c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104271:	c9                   	leave  
80104272:	c3                   	ret    

80104273 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
80104273:	55                   	push   %ebp
80104274:	89 e5                	mov    %esp,%ebp
80104276:	83 ec 18             	sub    $0x18,%esp
  acquire(&p->lock);
80104279:	8b 45 08             	mov    0x8(%ebp),%eax
8010427c:	89 04 24             	mov    %eax,(%esp)
8010427f:	e8 7f 14 00 00       	call   80105703 <acquire>
  if(writable){
80104284:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
80104288:	74 1f                	je     801042a9 <pipeclose+0x36>
    p->writeopen = 0;
8010428a:	8b 45 08             	mov    0x8(%ebp),%eax
8010428d:	c7 80 40 02 00 00 00 	movl   $0x0,0x240(%eax)
80104294:	00 00 00 
    wakeup(&p->nread);
80104297:	8b 45 08             	mov    0x8(%ebp),%eax
8010429a:	05 34 02 00 00       	add    $0x234,%eax
8010429f:	89 04 24             	mov    %eax,(%esp)
801042a2:	e8 4e 11 00 00       	call   801053f5 <wakeup>
801042a7:	eb 1d                	jmp    801042c6 <pipeclose+0x53>
  } else {
    p->readopen = 0;
801042a9:	8b 45 08             	mov    0x8(%ebp),%eax
801042ac:	c7 80 3c 02 00 00 00 	movl   $0x0,0x23c(%eax)
801042b3:	00 00 00 
    wakeup(&p->nwrite);
801042b6:	8b 45 08             	mov    0x8(%ebp),%eax
801042b9:	05 38 02 00 00       	add    $0x238,%eax
801042be:	89 04 24             	mov    %eax,(%esp)
801042c1:	e8 2f 11 00 00       	call   801053f5 <wakeup>
  }
  if(p->readopen == 0 && p->writeopen == 0){
801042c6:	8b 45 08             	mov    0x8(%ebp),%eax
801042c9:	8b 80 3c 02 00 00    	mov    0x23c(%eax),%eax
801042cf:	85 c0                	test   %eax,%eax
801042d1:	75 25                	jne    801042f8 <pipeclose+0x85>
801042d3:	8b 45 08             	mov    0x8(%ebp),%eax
801042d6:	8b 80 40 02 00 00    	mov    0x240(%eax),%eax
801042dc:	85 c0                	test   %eax,%eax
801042de:	75 18                	jne    801042f8 <pipeclose+0x85>
    release(&p->lock);
801042e0:	8b 45 08             	mov    0x8(%ebp),%eax
801042e3:	89 04 24             	mov    %eax,(%esp)
801042e6:	e8 7a 14 00 00       	call   80105765 <release>
    kfree((char*)p);
801042eb:	8b 45 08             	mov    0x8(%ebp),%eax
801042ee:	89 04 24             	mov    %eax,(%esp)
801042f1:	e8 68 ec ff ff       	call   80102f5e <kfree>
801042f6:	eb 0b                	jmp    80104303 <pipeclose+0x90>
  } else
    release(&p->lock);
801042f8:	8b 45 08             	mov    0x8(%ebp),%eax
801042fb:	89 04 24             	mov    %eax,(%esp)
801042fe:	e8 62 14 00 00       	call   80105765 <release>
}
80104303:	c9                   	leave  
80104304:	c3                   	ret    

80104305 <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
80104305:	55                   	push   %ebp
80104306:	89 e5                	mov    %esp,%ebp
80104308:	53                   	push   %ebx
80104309:	83 ec 24             	sub    $0x24,%esp
  int i;

  acquire(&p->lock);
8010430c:	8b 45 08             	mov    0x8(%ebp),%eax
8010430f:	89 04 24             	mov    %eax,(%esp)
80104312:	e8 ec 13 00 00       	call   80105703 <acquire>
  for(i = 0; i < n; i++){
80104317:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010431e:	e9 a6 00 00 00       	jmp    801043c9 <pipewrite+0xc4>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
      if(p->readopen == 0 || proc->killed){
80104323:	8b 45 08             	mov    0x8(%ebp),%eax
80104326:	8b 80 3c 02 00 00    	mov    0x23c(%eax),%eax
8010432c:	85 c0                	test   %eax,%eax
8010432e:	74 0d                	je     8010433d <pipewrite+0x38>
80104330:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104336:	8b 40 24             	mov    0x24(%eax),%eax
80104339:	85 c0                	test   %eax,%eax
8010433b:	74 15                	je     80104352 <pipewrite+0x4d>
        release(&p->lock);
8010433d:	8b 45 08             	mov    0x8(%ebp),%eax
80104340:	89 04 24             	mov    %eax,(%esp)
80104343:	e8 1d 14 00 00       	call   80105765 <release>
        return -1;
80104348:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010434d:	e9 9d 00 00 00       	jmp    801043ef <pipewrite+0xea>
      }
      wakeup(&p->nread);
80104352:	8b 45 08             	mov    0x8(%ebp),%eax
80104355:	05 34 02 00 00       	add    $0x234,%eax
8010435a:	89 04 24             	mov    %eax,(%esp)
8010435d:	e8 93 10 00 00       	call   801053f5 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80104362:	8b 45 08             	mov    0x8(%ebp),%eax
80104365:	8b 55 08             	mov    0x8(%ebp),%edx
80104368:	81 c2 38 02 00 00    	add    $0x238,%edx
8010436e:	89 44 24 04          	mov    %eax,0x4(%esp)
80104372:	89 14 24             	mov    %edx,(%esp)
80104375:	e8 8d 0f 00 00       	call   80105307 <sleep>
8010437a:	eb 01                	jmp    8010437d <pipewrite+0x78>
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
8010437c:	90                   	nop
8010437d:	8b 45 08             	mov    0x8(%ebp),%eax
80104380:	8b 90 38 02 00 00    	mov    0x238(%eax),%edx
80104386:	8b 45 08             	mov    0x8(%ebp),%eax
80104389:	8b 80 34 02 00 00    	mov    0x234(%eax),%eax
8010438f:	05 00 02 00 00       	add    $0x200,%eax
80104394:	39 c2                	cmp    %eax,%edx
80104396:	74 8b                	je     80104323 <pipewrite+0x1e>
        return -1;
      }
      wakeup(&p->nread);
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
80104398:	8b 45 08             	mov    0x8(%ebp),%eax
8010439b:	8b 80 38 02 00 00    	mov    0x238(%eax),%eax
801043a1:	89 c3                	mov    %eax,%ebx
801043a3:	81 e3 ff 01 00 00    	and    $0x1ff,%ebx
801043a9:	8b 55 f4             	mov    -0xc(%ebp),%edx
801043ac:	03 55 0c             	add    0xc(%ebp),%edx
801043af:	0f b6 0a             	movzbl (%edx),%ecx
801043b2:	8b 55 08             	mov    0x8(%ebp),%edx
801043b5:	88 4c 1a 34          	mov    %cl,0x34(%edx,%ebx,1)
801043b9:	8d 50 01             	lea    0x1(%eax),%edx
801043bc:	8b 45 08             	mov    0x8(%ebp),%eax
801043bf:	89 90 38 02 00 00    	mov    %edx,0x238(%eax)
pipewrite(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
801043c5:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801043c9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801043cc:	3b 45 10             	cmp    0x10(%ebp),%eax
801043cf:	7c ab                	jl     8010437c <pipewrite+0x77>
      wakeup(&p->nread);
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
801043d1:	8b 45 08             	mov    0x8(%ebp),%eax
801043d4:	05 34 02 00 00       	add    $0x234,%eax
801043d9:	89 04 24             	mov    %eax,(%esp)
801043dc:	e8 14 10 00 00       	call   801053f5 <wakeup>
  release(&p->lock);
801043e1:	8b 45 08             	mov    0x8(%ebp),%eax
801043e4:	89 04 24             	mov    %eax,(%esp)
801043e7:	e8 79 13 00 00       	call   80105765 <release>
  return n;
801043ec:	8b 45 10             	mov    0x10(%ebp),%eax
}
801043ef:	83 c4 24             	add    $0x24,%esp
801043f2:	5b                   	pop    %ebx
801043f3:	5d                   	pop    %ebp
801043f4:	c3                   	ret    

801043f5 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
801043f5:	55                   	push   %ebp
801043f6:	89 e5                	mov    %esp,%ebp
801043f8:	53                   	push   %ebx
801043f9:	83 ec 24             	sub    $0x24,%esp
  int i;

  acquire(&p->lock);
801043fc:	8b 45 08             	mov    0x8(%ebp),%eax
801043ff:	89 04 24             	mov    %eax,(%esp)
80104402:	e8 fc 12 00 00       	call   80105703 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80104407:	eb 3a                	jmp    80104443 <piperead+0x4e>
    if(proc->killed){
80104409:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010440f:	8b 40 24             	mov    0x24(%eax),%eax
80104412:	85 c0                	test   %eax,%eax
80104414:	74 15                	je     8010442b <piperead+0x36>
      release(&p->lock);
80104416:	8b 45 08             	mov    0x8(%ebp),%eax
80104419:	89 04 24             	mov    %eax,(%esp)
8010441c:	e8 44 13 00 00       	call   80105765 <release>
      return -1;
80104421:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104426:	e9 b6 00 00 00       	jmp    801044e1 <piperead+0xec>
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
8010442b:	8b 45 08             	mov    0x8(%ebp),%eax
8010442e:	8b 55 08             	mov    0x8(%ebp),%edx
80104431:	81 c2 34 02 00 00    	add    $0x234,%edx
80104437:	89 44 24 04          	mov    %eax,0x4(%esp)
8010443b:	89 14 24             	mov    %edx,(%esp)
8010443e:	e8 c4 0e 00 00       	call   80105307 <sleep>
piperead(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80104443:	8b 45 08             	mov    0x8(%ebp),%eax
80104446:	8b 90 34 02 00 00    	mov    0x234(%eax),%edx
8010444c:	8b 45 08             	mov    0x8(%ebp),%eax
8010444f:	8b 80 38 02 00 00    	mov    0x238(%eax),%eax
80104455:	39 c2                	cmp    %eax,%edx
80104457:	75 0d                	jne    80104466 <piperead+0x71>
80104459:	8b 45 08             	mov    0x8(%ebp),%eax
8010445c:	8b 80 40 02 00 00    	mov    0x240(%eax),%eax
80104462:	85 c0                	test   %eax,%eax
80104464:	75 a3                	jne    80104409 <piperead+0x14>
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80104466:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010446d:	eb 49                	jmp    801044b8 <piperead+0xc3>
    if(p->nread == p->nwrite)
8010446f:	8b 45 08             	mov    0x8(%ebp),%eax
80104472:	8b 90 34 02 00 00    	mov    0x234(%eax),%edx
80104478:	8b 45 08             	mov    0x8(%ebp),%eax
8010447b:	8b 80 38 02 00 00    	mov    0x238(%eax),%eax
80104481:	39 c2                	cmp    %eax,%edx
80104483:	74 3d                	je     801044c2 <piperead+0xcd>
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
80104485:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104488:	89 c2                	mov    %eax,%edx
8010448a:	03 55 0c             	add    0xc(%ebp),%edx
8010448d:	8b 45 08             	mov    0x8(%ebp),%eax
80104490:	8b 80 34 02 00 00    	mov    0x234(%eax),%eax
80104496:	89 c3                	mov    %eax,%ebx
80104498:	81 e3 ff 01 00 00    	and    $0x1ff,%ebx
8010449e:	8b 4d 08             	mov    0x8(%ebp),%ecx
801044a1:	0f b6 4c 19 34       	movzbl 0x34(%ecx,%ebx,1),%ecx
801044a6:	88 0a                	mov    %cl,(%edx)
801044a8:	8d 50 01             	lea    0x1(%eax),%edx
801044ab:	8b 45 08             	mov    0x8(%ebp),%eax
801044ae:	89 90 34 02 00 00    	mov    %edx,0x234(%eax)
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
801044b4:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801044b8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801044bb:	3b 45 10             	cmp    0x10(%ebp),%eax
801044be:	7c af                	jl     8010446f <piperead+0x7a>
801044c0:	eb 01                	jmp    801044c3 <piperead+0xce>
    if(p->nread == p->nwrite)
      break;
801044c2:	90                   	nop
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
801044c3:	8b 45 08             	mov    0x8(%ebp),%eax
801044c6:	05 38 02 00 00       	add    $0x238,%eax
801044cb:	89 04 24             	mov    %eax,(%esp)
801044ce:	e8 22 0f 00 00       	call   801053f5 <wakeup>
  release(&p->lock);
801044d3:	8b 45 08             	mov    0x8(%ebp),%eax
801044d6:	89 04 24             	mov    %eax,(%esp)
801044d9:	e8 87 12 00 00       	call   80105765 <release>
  return i;
801044de:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
801044e1:	83 c4 24             	add    $0x24,%esp
801044e4:	5b                   	pop    %ebx
801044e5:	5d                   	pop    %ebp
801044e6:	c3                   	ret    
	...

801044e8 <readeflags>:
  asm volatile("ltr %0" : : "r" (sel));
}

static inline uint
readeflags(void)
{
801044e8:	55                   	push   %ebp
801044e9:	89 e5                	mov    %esp,%ebp
801044eb:	53                   	push   %ebx
801044ec:	83 ec 10             	sub    $0x10,%esp
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801044ef:	9c                   	pushf  
801044f0:	5b                   	pop    %ebx
801044f1:	89 5d f8             	mov    %ebx,-0x8(%ebp)
  return eflags;
801044f4:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
801044f7:	83 c4 10             	add    $0x10,%esp
801044fa:	5b                   	pop    %ebx
801044fb:	5d                   	pop    %ebp
801044fc:	c3                   	ret    

801044fd <sti>:
  asm volatile("cli");
}

static inline void
sti(void)
{
801044fd:	55                   	push   %ebp
801044fe:	89 e5                	mov    %esp,%ebp
  asm volatile("sti");
80104500:	fb                   	sti    
}
80104501:	5d                   	pop    %ebp
80104502:	c3                   	ret    

80104503 <get_time>:

static void wakeup1(void *chan);

  //used to get the number of ticks since the clock started
int
get_time(){
80104503:	55                   	push   %ebp
80104504:	89 e5                	mov    %esp,%ebp
80104506:	83 ec 28             	sub    $0x28,%esp
  uint rticks;

  acquire(&tickslock);
80104509:	c7 04 24 e0 47 11 80 	movl   $0x801147e0,(%esp)
80104510:	e8 ee 11 00 00       	call   80105703 <acquire>
  rticks=ticks;
80104515:	a1 20 50 11 80       	mov    0x80115020,%eax
8010451a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  release(&tickslock);
8010451d:	c7 04 24 e0 47 11 80 	movl   $0x801147e0,(%esp)
80104524:	e8 3c 12 00 00       	call   80105765 <release>
return rticks;
80104529:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
8010452c:	c9                   	leave  
8010452d:	c3                   	ret    

8010452e <pinit>:


void
pinit(void)
{
8010452e:	55                   	push   %ebp
8010452f:	89 e5                	mov    %esp,%ebp
80104531:	83 ec 28             	sub    $0x28,%esp
  int i;
  initlock(&ptable.lock, "ptable");
80104534:	c7 44 24 04 10 91 10 	movl   $0x80109110,0x4(%esp)
8010453b:	80 
8010453c:	c7 04 24 a0 21 11 80 	movl   $0x801121a0,(%esp)
80104543:	e8 9a 11 00 00       	call   801056e2 <initlock>
  for(i=0;i<NUMBER_OF_QUEUES*NPROC;i++)
80104548:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010454f:	eb 12                	jmp    80104563 <pinit+0x35>
    pidQueue[i]=-1;
80104551:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104554:	c7 04 85 20 c0 10 80 	movl   $0xffffffff,-0x7fef3fe0(,%eax,4)
8010455b:	ff ff ff ff 
void
pinit(void)
{
  int i;
  initlock(&ptable.lock, "ptable");
  for(i=0;i<NUMBER_OF_QUEUES*NPROC;i++)
8010455f:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80104563:	81 7d f4 bf 00 00 00 	cmpl   $0xbf,-0xc(%ebp)
8010456a:	7e e5                	jle    80104551 <pinit+0x23>
    pidQueue[i]=-1;
  for(i=0;i<NUMBER_OF_QUEUES;i++){
8010456c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80104573:	eb 28                	jmp    8010459d <pinit+0x6f>
  queueCurrent[i]=i*NPROC;
80104575:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104578:	89 c2                	mov    %eax,%edx
8010457a:	c1 e2 06             	shl    $0x6,%edx
8010457d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104580:	89 14 85 8c ce 10 80 	mov    %edx,-0x7fef3174(,%eax,4)
  queueEnd[i]=i*NPROC;
80104587:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010458a:	89 c2                	mov    %eax,%edx
8010458c:	c1 e2 06             	shl    $0x6,%edx
8010458f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104592:	89 14 85 98 ce 10 80 	mov    %edx,-0x7fef3168(,%eax,4)
{
  int i;
  initlock(&ptable.lock, "ptable");
  for(i=0;i<NUMBER_OF_QUEUES*NPROC;i++)
    pidQueue[i]=-1;
  for(i=0;i<NUMBER_OF_QUEUES;i++){
80104599:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
8010459d:	83 7d f4 02          	cmpl   $0x2,-0xc(%ebp)
801045a1:	7e d2                	jle    80104575 <pinit+0x47>
  queueCurrent[i]=i*NPROC;
  queueEnd[i]=i*NPROC;
}

}
801045a3:	c9                   	leave  
801045a4:	c3                   	ret    

801045a5 <sleepingUpDate>:


void
sleepingUpDate(void)
{
801045a5:	55                   	push   %ebp
801045a6:	89 e5                	mov    %esp,%ebp
801045a8:	83 ec 28             	sub    $0x28,%esp
  struct proc *p;
  acquire(&ptable.lock);
801045ab:	c7 04 24 a0 21 11 80 	movl   $0x801121a0,(%esp)
801045b2:	e8 4c 11 00 00       	call   80105703 <acquire>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801045b7:	c7 45 f4 d4 21 11 80 	movl   $0x801121d4,-0xc(%ebp)
801045be:	eb 5c                	jmp    8010461c <sleepingUpDate+0x77>
    if(p->state == SLEEPING){
801045c0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801045c3:	8b 40 0c             	mov    0xc(%eax),%eax
801045c6:	83 f8 02             	cmp    $0x2,%eax
801045c9:	75 15                	jne    801045e0 <sleepingUpDate+0x3b>
      p->iotime++;
801045cb:	8b 45 f4             	mov    -0xc(%ebp),%eax
801045ce:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
801045d4:	8d 50 01             	lea    0x1(%eax),%edx
801045d7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801045da:	89 90 8c 00 00 00    	mov    %edx,0x8c(%eax)
      
    }
    if(p->state == RUNNING){
801045e0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801045e3:	8b 40 0c             	mov    0xc(%eax),%eax
801045e6:	83 f8 04             	cmp    $0x4,%eax
801045e9:	75 2a                	jne    80104615 <sleepingUpDate+0x70>
      p->rtime++;
801045eb:	8b 45 f4             	mov    -0xc(%ebp),%eax
801045ee:	8b 80 90 00 00 00    	mov    0x90(%eax),%eax
801045f4:	8d 50 01             	lea    0x1(%eax),%edx
801045f7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801045fa:	89 90 90 00 00 00    	mov    %edx,0x90(%eax)
      p->quanta--;
80104600:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104603:	8b 80 94 00 00 00    	mov    0x94(%eax),%eax
80104609:	8d 50 ff             	lea    -0x1(%eax),%edx
8010460c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010460f:	89 90 94 00 00 00    	mov    %edx,0x94(%eax)
void
sleepingUpDate(void)
{
  struct proc *p;
  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104615:	81 45 f4 98 00 00 00 	addl   $0x98,-0xc(%ebp)
8010461c:	81 7d f4 d4 47 11 80 	cmpl   $0x801147d4,-0xc(%ebp)
80104623:	72 9b                	jb     801045c0 <sleepingUpDate+0x1b>
    if(p->state == RUNNING){
      p->rtime++;
      p->quanta--;
    }
  }
 release(&ptable.lock);
80104625:	c7 04 24 a0 21 11 80 	movl   $0x801121a0,(%esp)
8010462c:	e8 34 11 00 00       	call   80105765 <release>
}
80104631:	c9                   	leave  
80104632:	c3                   	ret    

80104633 <findIndxOfProc>:

int
findIndxOfProc(struct proc* np){
80104633:	55                   	push   %ebp
80104634:	89 e5                	mov    %esp,%ebp
80104636:	83 ec 10             	sub    $0x10,%esp
  int i;
  for(i=0; i < NPROC; i++)
80104639:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
80104640:	eb 24                	jmp    80104666 <findIndxOfProc+0x33>
  {
    if((&ptable.proc[i])->pid == np->pid){
80104642:	8b 45 fc             	mov    -0x4(%ebp),%eax
80104645:	69 c0 98 00 00 00    	imul   $0x98,%eax,%eax
8010464b:	05 d4 21 11 80       	add    $0x801121d4,%eax
80104650:	8b 50 10             	mov    0x10(%eax),%edx
80104653:	8b 45 08             	mov    0x8(%ebp),%eax
80104656:	8b 40 10             	mov    0x10(%eax),%eax
80104659:	39 c2                	cmp    %eax,%edx
8010465b:	75 05                	jne    80104662 <findIndxOfProc+0x2f>
      return i;   
8010465d:	8b 45 fc             	mov    -0x4(%ebp),%eax
80104660:	eb 0f                	jmp    80104671 <findIndxOfProc+0x3e>
}

int
findIndxOfProc(struct proc* np){
  int i;
  for(i=0; i < NPROC; i++)
80104662:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
80104666:	83 7d fc 3f          	cmpl   $0x3f,-0x4(%ebp)
8010466a:	7e d6                	jle    80104642 <findIndxOfProc+0xf>
  {
    if((&ptable.proc[i])->pid == np->pid){
      return i;   
    }
  }
 return -1;
8010466c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104671:	c9                   	leave  
80104672:	c3                   	ret    

80104673 <fixQueue>:

void
fixQueue(int queue){
80104673:	55                   	push   %ebp
80104674:	89 e5                	mov    %esp,%ebp
80104676:	83 ec 10             	sub    $0x10,%esp
  int i;
  
  for(i=queue*NPROC;i<queueEnd[queue];i++)
80104679:	8b 45 08             	mov    0x8(%ebp),%eax
8010467c:	c1 e0 06             	shl    $0x6,%eax
8010467f:	89 45 fc             	mov    %eax,-0x4(%ebp)
80104682:	eb 3b                	jmp    801046bf <fixQueue+0x4c>
  {
    if(pidQueue[i]==-1){
80104684:	8b 45 fc             	mov    -0x4(%ebp),%eax
80104687:	8b 04 85 20 c0 10 80 	mov    -0x7fef3fe0(,%eax,4),%eax
8010468e:	83 f8 ff             	cmp    $0xffffffff,%eax
80104691:	75 28                	jne    801046bb <fixQueue+0x48>
       pidQueue[i]=pidQueue[i+1];
80104693:	8b 45 fc             	mov    -0x4(%ebp),%eax
80104696:	83 c0 01             	add    $0x1,%eax
80104699:	8b 14 85 20 c0 10 80 	mov    -0x7fef3fe0(,%eax,4),%edx
801046a0:	8b 45 fc             	mov    -0x4(%ebp),%eax
801046a3:	89 14 85 20 c0 10 80 	mov    %edx,-0x7fef3fe0(,%eax,4)
       pidQueue[i+1]=-1;
801046aa:	8b 45 fc             	mov    -0x4(%ebp),%eax
801046ad:	83 c0 01             	add    $0x1,%eax
801046b0:	c7 04 85 20 c0 10 80 	movl   $0xffffffff,-0x7fef3fe0(,%eax,4)
801046b7:	ff ff ff ff 

void
fixQueue(int queue){
  int i;
  
  for(i=queue*NPROC;i<queueEnd[queue];i++)
801046bb:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
801046bf:	8b 45 08             	mov    0x8(%ebp),%eax
801046c2:	8b 04 85 98 ce 10 80 	mov    -0x7fef3168(,%eax,4),%eax
801046c9:	3b 45 fc             	cmp    -0x4(%ebp),%eax
801046cc:	7f b6                	jg     80104684 <fixQueue+0x11>
    if(pidQueue[i]==-1){
       pidQueue[i]=pidQueue[i+1];
       pidQueue[i+1]=-1;
    }
  }
  while(queueEnd[queue]>queue*NPROC && pidQueue[queueEnd[queue]-1]==-1){  
801046ce:	eb 46                	jmp    80104716 <fixQueue+0xa3>
    queueEnd[queue]--;
801046d0:	8b 45 08             	mov    0x8(%ebp),%eax
801046d3:	8b 04 85 98 ce 10 80 	mov    -0x7fef3168(,%eax,4),%eax
801046da:	8d 50 ff             	lea    -0x1(%eax),%edx
801046dd:	8b 45 08             	mov    0x8(%ebp),%eax
801046e0:	89 14 85 98 ce 10 80 	mov    %edx,-0x7fef3168(,%eax,4)
    if(queueCurrent[queue]>queueEnd[queue])
801046e7:	8b 45 08             	mov    0x8(%ebp),%eax
801046ea:	8b 14 85 8c ce 10 80 	mov    -0x7fef3174(,%eax,4),%edx
801046f1:	8b 45 08             	mov    0x8(%ebp),%eax
801046f4:	8b 04 85 98 ce 10 80 	mov    -0x7fef3168(,%eax,4),%eax
801046fb:	39 c2                	cmp    %eax,%edx
801046fd:	7e 17                	jle    80104716 <fixQueue+0xa3>
      queueCurrent[queue]--;
801046ff:	8b 45 08             	mov    0x8(%ebp),%eax
80104702:	8b 04 85 8c ce 10 80 	mov    -0x7fef3174(,%eax,4),%eax
80104709:	8d 50 ff             	lea    -0x1(%eax),%edx
8010470c:	8b 45 08             	mov    0x8(%ebp),%eax
8010470f:	89 14 85 8c ce 10 80 	mov    %edx,-0x7fef3174(,%eax,4)
    if(pidQueue[i]==-1){
       pidQueue[i]=pidQueue[i+1];
       pidQueue[i+1]=-1;
    }
  }
  while(queueEnd[queue]>queue*NPROC && pidQueue[queueEnd[queue]-1]==-1){  
80104716:	8b 45 08             	mov    0x8(%ebp),%eax
80104719:	8b 04 85 98 ce 10 80 	mov    -0x7fef3168(,%eax,4),%eax
80104720:	8b 55 08             	mov    0x8(%ebp),%edx
80104723:	c1 e2 06             	shl    $0x6,%edx
80104726:	39 d0                	cmp    %edx,%eax
80104728:	7e 19                	jle    80104743 <fixQueue+0xd0>
8010472a:	8b 45 08             	mov    0x8(%ebp),%eax
8010472d:	8b 04 85 98 ce 10 80 	mov    -0x7fef3168(,%eax,4),%eax
80104734:	83 e8 01             	sub    $0x1,%eax
80104737:	8b 04 85 20 c0 10 80 	mov    -0x7fef3fe0(,%eax,4),%eax
8010473e:	83 f8 ff             	cmp    $0xffffffff,%eax
80104741:	74 8d                	je     801046d0 <fixQueue+0x5d>
    queueEnd[queue]--;
    if(queueCurrent[queue]>queueEnd[queue])
      queueCurrent[queue]--;
  }
}
80104743:	c9                   	leave  
80104744:	c3                   	ret    

80104745 <queuesAboveEmpty>:

int
queuesAboveEmpty(int queue){
80104745:	55                   	push   %ebp
80104746:	89 e5                	mov    %esp,%ebp
80104748:	83 ec 10             	sub    $0x10,%esp
  int ans = 1;
8010474b:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
  int placer;
  if(queue==NUMBER_OF_QUEUES-1)
80104752:	83 7d 08 02          	cmpl   $0x2,0x8(%ebp)
80104756:	75 07                	jne    8010475f <queuesAboveEmpty+0x1a>
    return 1;
80104758:	b8 01 00 00 00       	mov    $0x1,%eax
8010475d:	eb 40                	jmp    8010479f <queuesAboveEmpty+0x5a>
  
  for(placer = (queue+1)*NPROC;placer<NUMBER_OF_QUEUES*NPROC;placer++)
8010475f:	8b 45 08             	mov    0x8(%ebp),%eax
80104762:	83 c0 01             	add    $0x1,%eax
80104765:	c1 e0 06             	shl    $0x6,%eax
80104768:	89 45 f8             	mov    %eax,-0x8(%ebp)
8010476b:	eb 26                	jmp    80104793 <queuesAboveEmpty+0x4e>
  {
    ans = ans * (pidQueue[placer]==-1)? 1 : 0;
8010476d:	8b 45 f8             	mov    -0x8(%ebp),%eax
80104770:	8b 04 85 20 c0 10 80 	mov    -0x7fef3fe0(,%eax,4),%eax
80104777:	83 f8 ff             	cmp    $0xffffffff,%eax
8010477a:	0f 94 c0             	sete   %al
8010477d:	0f b6 c0             	movzbl %al,%eax
80104780:	0f af 45 fc          	imul   -0x4(%ebp),%eax
80104784:	85 c0                	test   %eax,%eax
80104786:	0f 95 c0             	setne  %al
80104789:	0f b6 c0             	movzbl %al,%eax
8010478c:	89 45 fc             	mov    %eax,-0x4(%ebp)
  int ans = 1;
  int placer;
  if(queue==NUMBER_OF_QUEUES-1)
    return 1;
  
  for(placer = (queue+1)*NPROC;placer<NUMBER_OF_QUEUES*NPROC;placer++)
8010478f:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
80104793:	81 7d f8 bf 00 00 00 	cmpl   $0xbf,-0x8(%ebp)
8010479a:	7e d1                	jle    8010476d <queuesAboveEmpty+0x28>
  {
    ans = ans * (pidQueue[placer]==-1)? 1 : 0;
  }

  return ans;
8010479c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
8010479f:	c9                   	leave  
801047a0:	c3                   	ret    

801047a1 <changeStatus>:

void
changeStatus(enum procstate s,struct proc* p)
{
801047a1:	55                   	push   %ebp
801047a2:	89 e5                	mov    %esp,%ebp
801047a4:	83 ec 28             	sub    $0x28,%esp
  
  int location = findIndxOfProc(p);
801047a7:	8b 45 0c             	mov    0xc(%ebp),%eax
801047aa:	89 04 24             	mov    %eax,(%esp)
801047ad:	e8 81 fe ff ff       	call   80104633 <findIndxOfProc>
801047b2:	89 45 f4             	mov    %eax,-0xc(%ebp)
  
  enum procstate prevState = p->state; 
801047b5:	8b 45 0c             	mov    0xc(%ebp),%eax
801047b8:	8b 40 0c             	mov    0xc(%eax),%eax
801047bb:	89 45 f0             	mov    %eax,-0x10(%ebp)

  p->state=s;
801047be:	8b 45 0c             	mov    0xc(%ebp),%eax
801047c1:	8b 55 08             	mov    0x8(%ebp),%edx
801047c4:	89 50 0c             	mov    %edx,0xc(%eax)

  if(location<0)
801047c7:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801047cb:	79 16                	jns    801047e3 <changeStatus+0x42>
    cprintf("Cant find any processes with pid %d\n",p->pid);
801047cd:	8b 45 0c             	mov    0xc(%ebp),%eax
801047d0:	8b 40 10             	mov    0x10(%eax),%eax
801047d3:	89 44 24 04          	mov    %eax,0x4(%esp)
801047d7:	c7 04 24 18 91 10 80 	movl   $0x80109118,(%esp)
801047de:	e8 be bb ff ff       	call   801003a1 <cprintf>
          pidQueue[p->placeInQueue]=-1;
          p->placeInQueue=-1;
        }
      break;
      default:
        if(s==RUNNING){
801047e3:	83 7d 08 04          	cmpl   $0x4,0x8(%ebp)
801047e7:	75 0d                	jne    801047f6 <changeStatus+0x55>
          p->quanta=QUANTA;
801047e9:	8b 45 0c             	mov    0xc(%ebp),%eax
801047ec:	c7 80 94 00 00 00 05 	movl   $0x5,0x94(%eax)
801047f3:	00 00 00 
        }
      break;
801047f6:	90                   	nop
    }
}
801047f7:	c9                   	leave  
801047f8:	c3                   	ret    

801047f9 <getquanta>:



int 
getquanta()
{
801047f9:	55                   	push   %ebp
801047fa:	89 e5                	mov    %esp,%ebp
  return proc->quanta;
801047fc:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104802:	8b 80 94 00 00 00    	mov    0x94(%eax),%eax
}
80104808:	5d                   	pop    %ebp
80104809:	c3                   	ret    

8010480a <getqueue>:
int 
getqueue()
{
8010480a:	55                   	push   %ebp
8010480b:	89 e5                	mov    %esp,%ebp
  return proc->queue;
8010480d:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104813:	8b 40 7c             	mov    0x7c(%eax),%eax
}
80104816:	5d                   	pop    %ebp
80104817:	c3                   	ret    

80104818 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
80104818:	55                   	push   %ebp
80104819:	89 e5                	mov    %esp,%ebp
8010481b:	83 ec 28             	sub    $0x28,%esp
  struct proc *p;
  char *sp;
  
  acquire(&ptable.lock);
8010481e:	c7 04 24 a0 21 11 80 	movl   $0x801121a0,(%esp)
80104825:	e8 d9 0e 00 00       	call   80105703 <acquire>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010482a:	c7 45 f4 d4 21 11 80 	movl   $0x801121d4,-0xc(%ebp)
80104831:	eb 11                	jmp    80104844 <allocproc+0x2c>
    if(p->state == UNUSED)
80104833:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104836:	8b 40 0c             	mov    0xc(%eax),%eax
80104839:	85 c0                	test   %eax,%eax
8010483b:	74 26                	je     80104863 <allocproc+0x4b>
{
  struct proc *p;
  char *sp;
  
  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010483d:	81 45 f4 98 00 00 00 	addl   $0x98,-0xc(%ebp)
80104844:	81 7d f4 d4 47 11 80 	cmpl   $0x801147d4,-0xc(%ebp)
8010484b:	72 e6                	jb     80104833 <allocproc+0x1b>
    if(p->state == UNUSED)
      goto found;

  release(&ptable.lock);
8010484d:	c7 04 24 a0 21 11 80 	movl   $0x801121a0,(%esp)
80104854:	e8 0c 0f 00 00       	call   80105765 <release>
  return 0;
80104859:	b8 00 00 00 00       	mov    $0x0,%eax
8010485e:	e9 fb 00 00 00       	jmp    8010495e <allocproc+0x146>
  char *sp;
  
  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    if(p->state == UNUSED)
      goto found;
80104863:	90                   	nop
  release(&ptable.lock);
  return 0;

found:

  p->queue=NORMAL_PRIORITY_QUEUE;
80104864:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104867:	c7 40 7c 01 00 00 00 	movl   $0x1,0x7c(%eax)
  
  
  changeStatus(EMBRYO,p);
8010486e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104871:	89 44 24 04          	mov    %eax,0x4(%esp)
80104875:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
8010487c:	e8 20 ff ff ff       	call   801047a1 <changeStatus>

  p->pid = nextpid++;
80104881:	a1 20 c3 10 80       	mov    0x8010c320,%eax
80104886:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104889:	89 42 10             	mov    %eax,0x10(%edx)
8010488c:	83 c0 01             	add    $0x1,%eax
8010488f:	a3 20 c3 10 80       	mov    %eax,0x8010c320

  //update time of creation
  p->ctime=get_time();
80104894:	e8 6a fc ff ff       	call   80104503 <get_time>
80104899:	89 c2                	mov    %eax,%edx
8010489b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010489e:	89 90 84 00 00 00    	mov    %edx,0x84(%eax)
  p->iotime=0;
801048a4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801048a7:	c7 80 8c 00 00 00 00 	movl   $0x0,0x8c(%eax)
801048ae:	00 00 00 
  p->rtime=0;
801048b1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801048b4:	c7 80 90 00 00 00 00 	movl   $0x0,0x90(%eax)
801048bb:	00 00 00 

  release(&ptable.lock);
801048be:	c7 04 24 a0 21 11 80 	movl   $0x801121a0,(%esp)
801048c5:	e8 9b 0e 00 00       	call   80105765 <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
801048ca:	e8 28 e7 ff ff       	call   80102ff7 <kalloc>
801048cf:	8b 55 f4             	mov    -0xc(%ebp),%edx
801048d2:	89 42 08             	mov    %eax,0x8(%edx)
801048d5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801048d8:	8b 40 08             	mov    0x8(%eax),%eax
801048db:	85 c0                	test   %eax,%eax
801048dd:	75 1a                	jne    801048f9 <allocproc+0xe1>
    changeStatus(UNUSED,p);
801048df:	8b 45 f4             	mov    -0xc(%ebp),%eax
801048e2:	89 44 24 04          	mov    %eax,0x4(%esp)
801048e6:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801048ed:	e8 af fe ff ff       	call   801047a1 <changeStatus>
    return 0;
801048f2:	b8 00 00 00 00       	mov    $0x0,%eax
801048f7:	eb 65                	jmp    8010495e <allocproc+0x146>
  }
  sp = p->kstack + KSTACKSIZE;
801048f9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801048fc:	8b 40 08             	mov    0x8(%eax),%eax
801048ff:	05 00 10 00 00       	add    $0x1000,%eax
80104904:	89 45 f0             	mov    %eax,-0x10(%ebp)
  
  // Leave room for trap frame.
  sp -= sizeof *p->tf;
80104907:	83 6d f0 4c          	subl   $0x4c,-0x10(%ebp)
  p->tf = (struct trapframe*)sp;
8010490b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010490e:	8b 55 f0             	mov    -0x10(%ebp),%edx
80104911:	89 50 18             	mov    %edx,0x18(%eax)
  
  // Set up new context to start executing at forkret,
  // which returns to trapret.
  sp -= 4;
80104914:	83 6d f0 04          	subl   $0x4,-0x10(%ebp)
  *(uint*)sp = (uint)trapret;
80104918:	ba dc 6e 10 80       	mov    $0x80106edc,%edx
8010491d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104920:	89 10                	mov    %edx,(%eax)

  sp -= sizeof *p->context;
80104922:	83 6d f0 14          	subl   $0x14,-0x10(%ebp)
  p->context = (struct context*)sp;
80104926:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104929:	8b 55 f0             	mov    -0x10(%ebp),%edx
8010492c:	89 50 1c             	mov    %edx,0x1c(%eax)
  memset(p->context, 0, sizeof *p->context);
8010492f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104932:	8b 40 1c             	mov    0x1c(%eax),%eax
80104935:	c7 44 24 08 14 00 00 	movl   $0x14,0x8(%esp)
8010493c:	00 
8010493d:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80104944:	00 
80104945:	89 04 24             	mov    %eax,(%esp)
80104948:	e8 05 10 00 00       	call   80105952 <memset>
  p->context->eip = (uint)forkret;
8010494d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104950:	8b 40 1c             	mov    0x1c(%eax),%eax
80104953:	ba db 52 10 80       	mov    $0x801052db,%edx
80104958:	89 50 10             	mov    %edx,0x10(%eax)

  return p;
8010495b:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
8010495e:	c9                   	leave  
8010495f:	c3                   	ret    

80104960 <userinit>:

//PAGEBREAK: 32
// Set up first user process.
void
userinit(void)
{
80104960:	55                   	push   %ebp
80104961:	89 e5                	mov    %esp,%ebp
80104963:	83 ec 28             	sub    $0x28,%esp
  struct proc *p;
  extern char _binary_initcode_start[], _binary_initcode_size[];
  
  p = allocproc();
80104966:	e8 ad fe ff ff       	call   80104818 <allocproc>
8010496b:	89 45 f4             	mov    %eax,-0xc(%ebp)

  initproc = p;
8010496e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104971:	a3 88 ce 10 80       	mov    %eax,0x8010ce88
  if((p->pgdir = setupkvm(kalloc)) == 0)
80104976:	c7 04 24 f7 2f 10 80 	movl   $0x80102ff7,(%esp)
8010497d:	e8 6f 3c 00 00       	call   801085f1 <setupkvm>
80104982:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104985:	89 42 04             	mov    %eax,0x4(%edx)
80104988:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010498b:	8b 40 04             	mov    0x4(%eax),%eax
8010498e:	85 c0                	test   %eax,%eax
80104990:	75 0c                	jne    8010499e <userinit+0x3e>
    panic("userinit: out of memory?");
80104992:	c7 04 24 3d 91 10 80 	movl   $0x8010913d,(%esp)
80104999:	e8 9f bb ff ff       	call   8010053d <panic>

  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
8010499e:	ba 2c 00 00 00       	mov    $0x2c,%edx
801049a3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801049a6:	8b 40 04             	mov    0x4(%eax),%eax
801049a9:	89 54 24 08          	mov    %edx,0x8(%esp)
801049ad:	c7 44 24 04 00 c8 10 	movl   $0x8010c800,0x4(%esp)
801049b4:	80 
801049b5:	89 04 24             	mov    %eax,(%esp)
801049b8:	e8 8c 3e 00 00       	call   80108849 <inituvm>
  
  p->sz = PGSIZE;
801049bd:	8b 45 f4             	mov    -0xc(%ebp),%eax
801049c0:	c7 00 00 10 00 00    	movl   $0x1000,(%eax)
  memset(p->tf, 0, sizeof(*p->tf));
801049c6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801049c9:	8b 40 18             	mov    0x18(%eax),%eax
801049cc:	c7 44 24 08 4c 00 00 	movl   $0x4c,0x8(%esp)
801049d3:	00 
801049d4:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
801049db:	00 
801049dc:	89 04 24             	mov    %eax,(%esp)
801049df:	e8 6e 0f 00 00       	call   80105952 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
801049e4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801049e7:	8b 40 18             	mov    0x18(%eax),%eax
801049ea:	66 c7 40 3c 23 00    	movw   $0x23,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
801049f0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801049f3:	8b 40 18             	mov    0x18(%eax),%eax
801049f6:	66 c7 40 2c 2b 00    	movw   $0x2b,0x2c(%eax)
  p->tf->es = p->tf->ds;
801049fc:	8b 45 f4             	mov    -0xc(%ebp),%eax
801049ff:	8b 40 18             	mov    0x18(%eax),%eax
80104a02:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104a05:	8b 52 18             	mov    0x18(%edx),%edx
80104a08:	0f b7 52 2c          	movzwl 0x2c(%edx),%edx
80104a0c:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
80104a10:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104a13:	8b 40 18             	mov    0x18(%eax),%eax
80104a16:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104a19:	8b 52 18             	mov    0x18(%edx),%edx
80104a1c:	0f b7 52 2c          	movzwl 0x2c(%edx),%edx
80104a20:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
80104a24:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104a27:	8b 40 18             	mov    0x18(%eax),%eax
80104a2a:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
80104a31:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104a34:	8b 40 18             	mov    0x18(%eax),%eax
80104a37:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
80104a3e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104a41:	8b 40 18             	mov    0x18(%eax),%eax
80104a44:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)

  safestrcpy(p->name, "initcode", sizeof(p->name));
80104a4b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104a4e:	83 c0 6c             	add    $0x6c,%eax
80104a51:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
80104a58:	00 
80104a59:	c7 44 24 04 56 91 10 	movl   $0x80109156,0x4(%esp)
80104a60:	80 
80104a61:	89 04 24             	mov    %eax,(%esp)
80104a64:	e8 19 11 00 00       	call   80105b82 <safestrcpy>
  p->cwd = namei("/");
80104a69:	c7 04 24 5f 91 10 80 	movl   $0x8010915f,(%esp)
80104a70:	e8 8d de ff ff       	call   80102902 <namei>
80104a75:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104a78:	89 42 68             	mov    %eax,0x68(%edx)
  
  changeStatus(RUNNABLE,p);
80104a7b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104a7e:	89 44 24 04          	mov    %eax,0x4(%esp)
80104a82:	c7 04 24 03 00 00 00 	movl   $0x3,(%esp)
80104a89:	e8 13 fd ff ff       	call   801047a1 <changeStatus>
  
}
80104a8e:	c9                   	leave  
80104a8f:	c3                   	ret    

80104a90 <growproc>:

// Grow current process's memory by n bytes.
// Return 0 on success, -1 on failure.
int
growproc(int n)
{
80104a90:	55                   	push   %ebp
80104a91:	89 e5                	mov    %esp,%ebp
80104a93:	83 ec 28             	sub    $0x28,%esp
  uint sz;
  
  sz = proc->sz;
80104a96:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104a9c:	8b 00                	mov    (%eax),%eax
80104a9e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(n > 0){
80104aa1:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80104aa5:	7e 34                	jle    80104adb <growproc+0x4b>
    if((sz = allocuvm(proc->pgdir, sz, sz + n)) == 0)
80104aa7:	8b 45 08             	mov    0x8(%ebp),%eax
80104aaa:	89 c2                	mov    %eax,%edx
80104aac:	03 55 f4             	add    -0xc(%ebp),%edx
80104aaf:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104ab5:	8b 40 04             	mov    0x4(%eax),%eax
80104ab8:	89 54 24 08          	mov    %edx,0x8(%esp)
80104abc:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104abf:	89 54 24 04          	mov    %edx,0x4(%esp)
80104ac3:	89 04 24             	mov    %eax,(%esp)
80104ac6:	e8 f8 3e 00 00       	call   801089c3 <allocuvm>
80104acb:	89 45 f4             	mov    %eax,-0xc(%ebp)
80104ace:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80104ad2:	75 41                	jne    80104b15 <growproc+0x85>
      return -1;
80104ad4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104ad9:	eb 58                	jmp    80104b33 <growproc+0xa3>
  } else if(n < 0){
80104adb:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80104adf:	79 34                	jns    80104b15 <growproc+0x85>
    if((sz = deallocuvm(proc->pgdir, sz, sz + n)) == 0)
80104ae1:	8b 45 08             	mov    0x8(%ebp),%eax
80104ae4:	89 c2                	mov    %eax,%edx
80104ae6:	03 55 f4             	add    -0xc(%ebp),%edx
80104ae9:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104aef:	8b 40 04             	mov    0x4(%eax),%eax
80104af2:	89 54 24 08          	mov    %edx,0x8(%esp)
80104af6:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104af9:	89 54 24 04          	mov    %edx,0x4(%esp)
80104afd:	89 04 24             	mov    %eax,(%esp)
80104b00:	e8 98 3f 00 00       	call   80108a9d <deallocuvm>
80104b05:	89 45 f4             	mov    %eax,-0xc(%ebp)
80104b08:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80104b0c:	75 07                	jne    80104b15 <growproc+0x85>
      return -1;
80104b0e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104b13:	eb 1e                	jmp    80104b33 <growproc+0xa3>
  }
  proc->sz = sz;
80104b15:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104b1b:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104b1e:	89 10                	mov    %edx,(%eax)
  switchuvm(proc);
80104b20:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104b26:	89 04 24             	mov    %eax,(%esp)
80104b29:	e8 b4 3b 00 00       	call   801086e2 <switchuvm>
  return 0;
80104b2e:	b8 00 00 00 00       	mov    $0x0,%eax
}
80104b33:	c9                   	leave  
80104b34:	c3                   	ret    

80104b35 <fork>:
// Create a new process copying p as the parent.
// Sets up stack to return as if from system call.
// Caller must set state of returned proc to RUNNABLE.
int
fork(void)
{
80104b35:	55                   	push   %ebp
80104b36:	89 e5                	mov    %esp,%ebp
80104b38:	57                   	push   %edi
80104b39:	56                   	push   %esi
80104b3a:	53                   	push   %ebx
80104b3b:	83 ec 2c             	sub    $0x2c,%esp
  int i, pid;
  struct proc *np;

  // Allocate process.
  if((np = allocproc()) == 0)
80104b3e:	e8 d5 fc ff ff       	call   80104818 <allocproc>
80104b43:	89 45 e0             	mov    %eax,-0x20(%ebp)
80104b46:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
80104b4a:	75 0a                	jne    80104b56 <fork+0x21>
    return -1;
80104b4c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104b51:	e9 4c 01 00 00       	jmp    80104ca2 <fork+0x16d>

  // Copy process state from p.
  if((np->pgdir = copyuvm(proc->pgdir, proc->sz)) == 0){
80104b56:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104b5c:	8b 10                	mov    (%eax),%edx
80104b5e:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104b64:	8b 40 04             	mov    0x4(%eax),%eax
80104b67:	89 54 24 04          	mov    %edx,0x4(%esp)
80104b6b:	89 04 24             	mov    %eax,(%esp)
80104b6e:	e8 ba 40 00 00       	call   80108c2d <copyuvm>
80104b73:	8b 55 e0             	mov    -0x20(%ebp),%edx
80104b76:	89 42 04             	mov    %eax,0x4(%edx)
80104b79:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104b7c:	8b 40 04             	mov    0x4(%eax),%eax
80104b7f:	85 c0                	test   %eax,%eax
80104b81:	75 35                	jne    80104bb8 <fork+0x83>
    kfree(np->kstack);
80104b83:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104b86:	8b 40 08             	mov    0x8(%eax),%eax
80104b89:	89 04 24             	mov    %eax,(%esp)
80104b8c:	e8 cd e3 ff ff       	call   80102f5e <kfree>
    np->kstack = 0;
80104b91:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104b94:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
    changeStatus(UNUSED,np);
80104b9b:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104b9e:	89 44 24 04          	mov    %eax,0x4(%esp)
80104ba2:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80104ba9:	e8 f3 fb ff ff       	call   801047a1 <changeStatus>
    return -1;
80104bae:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104bb3:	e9 ea 00 00 00       	jmp    80104ca2 <fork+0x16d>
  }
  np->sz = proc->sz;
80104bb8:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104bbe:	8b 10                	mov    (%eax),%edx
80104bc0:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104bc3:	89 10                	mov    %edx,(%eax)
  np->parent = proc;
80104bc5:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80104bcc:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104bcf:	89 50 14             	mov    %edx,0x14(%eax)
  *np->tf = *proc->tf;
80104bd2:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104bd5:	8b 50 18             	mov    0x18(%eax),%edx
80104bd8:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104bde:	8b 40 18             	mov    0x18(%eax),%eax
80104be1:	89 c3                	mov    %eax,%ebx
80104be3:	b8 13 00 00 00       	mov    $0x13,%eax
80104be8:	89 d7                	mov    %edx,%edi
80104bea:	89 de                	mov    %ebx,%esi
80104bec:	89 c1                	mov    %eax,%ecx
80104bee:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;
80104bf0:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104bf3:	8b 40 18             	mov    0x18(%eax),%eax
80104bf6:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)

  for(i = 0; i < NOFILE; i++)
80104bfd:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80104c04:	eb 3d                	jmp    80104c43 <fork+0x10e>
    if(proc->ofile[i])
80104c06:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104c0c:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80104c0f:	83 c2 08             	add    $0x8,%edx
80104c12:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
80104c16:	85 c0                	test   %eax,%eax
80104c18:	74 25                	je     80104c3f <fork+0x10a>
      np->ofile[i] = filedup(proc->ofile[i]);
80104c1a:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104c20:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80104c23:	83 c2 08             	add    $0x8,%edx
80104c26:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
80104c2a:	89 04 24             	mov    %eax,(%esp)
80104c2d:	e8 42 c8 ff ff       	call   80101474 <filedup>
80104c32:	8b 55 e0             	mov    -0x20(%ebp),%edx
80104c35:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80104c38:	83 c1 08             	add    $0x8,%ecx
80104c3b:	89 44 8a 08          	mov    %eax,0x8(%edx,%ecx,4)
  *np->tf = *proc->tf;

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
80104c3f:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
80104c43:	83 7d e4 0f          	cmpl   $0xf,-0x1c(%ebp)
80104c47:	7e bd                	jle    80104c06 <fork+0xd1>
    if(proc->ofile[i])
      np->ofile[i] = filedup(proc->ofile[i]);
  np->cwd = idup(proc->cwd);
80104c49:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104c4f:	8b 40 68             	mov    0x68(%eax),%eax
80104c52:	89 04 24             	mov    %eax,(%esp)
80104c55:	e8 d4 d0 ff ff       	call   80101d2e <idup>
80104c5a:	8b 55 e0             	mov    -0x20(%ebp),%edx
80104c5d:	89 42 68             	mov    %eax,0x68(%edx)
 
  pid = np->pid;
80104c60:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104c63:	8b 40 10             	mov    0x10(%eax),%eax
80104c66:	89 45 dc             	mov    %eax,-0x24(%ebp)
  changeStatus(RUNNABLE,np);
80104c69:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104c6c:	89 44 24 04          	mov    %eax,0x4(%esp)
80104c70:	c7 04 24 03 00 00 00 	movl   $0x3,(%esp)
80104c77:	e8 25 fb ff ff       	call   801047a1 <changeStatus>
  safestrcpy(np->name, proc->name, sizeof(proc->name));
80104c7c:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104c82:	8d 50 6c             	lea    0x6c(%eax),%edx
80104c85:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104c88:	83 c0 6c             	add    $0x6c,%eax
80104c8b:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
80104c92:	00 
80104c93:	89 54 24 04          	mov    %edx,0x4(%esp)
80104c97:	89 04 24             	mov    %eax,(%esp)
80104c9a:	e8 e3 0e 00 00       	call   80105b82 <safestrcpy>
  return pid;
80104c9f:	8b 45 dc             	mov    -0x24(%ebp),%eax
}
80104ca2:	83 c4 2c             	add    $0x2c,%esp
80104ca5:	5b                   	pop    %ebx
80104ca6:	5e                   	pop    %esi
80104ca7:	5f                   	pop    %edi
80104ca8:	5d                   	pop    %ebp
80104ca9:	c3                   	ret    

80104caa <exit>:
// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait() to find out it exited.
void
exit(void)
{
80104caa:	55                   	push   %ebp
80104cab:	89 e5                	mov    %esp,%ebp
80104cad:	53                   	push   %ebx
80104cae:	83 ec 24             	sub    $0x24,%esp
  struct proc *p;
  int fd;

  if(proc == initproc)
80104cb1:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80104cb8:	a1 88 ce 10 80       	mov    0x8010ce88,%eax
80104cbd:	39 c2                	cmp    %eax,%edx
80104cbf:	75 0c                	jne    80104ccd <exit+0x23>
    panic("init exiting");
80104cc1:	c7 04 24 61 91 10 80 	movl   $0x80109161,(%esp)
80104cc8:	e8 70 b8 ff ff       	call   8010053d <panic>

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
80104ccd:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
80104cd4:	eb 44                	jmp    80104d1a <exit+0x70>
    if(proc->ofile[fd]){
80104cd6:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104cdc:	8b 55 f0             	mov    -0x10(%ebp),%edx
80104cdf:	83 c2 08             	add    $0x8,%edx
80104ce2:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
80104ce6:	85 c0                	test   %eax,%eax
80104ce8:	74 2c                	je     80104d16 <exit+0x6c>
      fileclose(proc->ofile[fd]);
80104cea:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104cf0:	8b 55 f0             	mov    -0x10(%ebp),%edx
80104cf3:	83 c2 08             	add    $0x8,%edx
80104cf6:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
80104cfa:	89 04 24             	mov    %eax,(%esp)
80104cfd:	e8 ba c7 ff ff       	call   801014bc <fileclose>
      proc->ofile[fd] = 0;
80104d02:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104d08:	8b 55 f0             	mov    -0x10(%ebp),%edx
80104d0b:	83 c2 08             	add    $0x8,%edx
80104d0e:	c7 44 90 08 00 00 00 	movl   $0x0,0x8(%eax,%edx,4)
80104d15:	00 

  if(proc == initproc)
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
80104d16:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
80104d1a:	83 7d f0 0f          	cmpl   $0xf,-0x10(%ebp)
80104d1e:	7e b6                	jle    80104cd6 <exit+0x2c>
      fileclose(proc->ofile[fd]);
      proc->ofile[fd] = 0;
    }
  }

  iput(proc->cwd);
80104d20:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104d26:	8b 40 68             	mov    0x68(%eax),%eax
80104d29:	89 04 24             	mov    %eax,(%esp)
80104d2c:	e8 e2 d1 ff ff       	call   80101f13 <iput>
  proc->cwd = 0;
80104d31:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104d37:	c7 40 68 00 00 00 00 	movl   $0x0,0x68(%eax)
  proc->etime=get_time();
80104d3e:	65 8b 1d 04 00 00 00 	mov    %gs:0x4,%ebx
80104d45:	e8 b9 f7 ff ff       	call   80104503 <get_time>
80104d4a:	89 83 88 00 00 00    	mov    %eax,0x88(%ebx)
  proc->queue=0;
80104d50:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104d56:	c7 40 7c 00 00 00 00 	movl   $0x0,0x7c(%eax)

  acquire(&ptable.lock);
80104d5d:	c7 04 24 a0 21 11 80 	movl   $0x801121a0,(%esp)
80104d64:	e8 9a 09 00 00       	call   80105703 <acquire>

  // Parent might be sleeping in wait().
  wakeup1(proc->parent);
80104d69:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104d6f:	8b 40 14             	mov    0x14(%eax),%eax
80104d72:	89 04 24             	mov    %eax,(%esp)
80104d75:	e8 31 06 00 00       	call   801053ab <wakeup1>

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104d7a:	c7 45 f4 d4 21 11 80 	movl   $0x801121d4,-0xc(%ebp)
80104d81:	eb 3b                	jmp    80104dbe <exit+0x114>
    if(p->parent == proc){
80104d83:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104d86:	8b 50 14             	mov    0x14(%eax),%edx
80104d89:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104d8f:	39 c2                	cmp    %eax,%edx
80104d91:	75 24                	jne    80104db7 <exit+0x10d>
      p->parent = initproc;
80104d93:	8b 15 88 ce 10 80    	mov    0x8010ce88,%edx
80104d99:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104d9c:	89 50 14             	mov    %edx,0x14(%eax)
      if(p->state == ZOMBIE)
80104d9f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104da2:	8b 40 0c             	mov    0xc(%eax),%eax
80104da5:	83 f8 05             	cmp    $0x5,%eax
80104da8:	75 0d                	jne    80104db7 <exit+0x10d>
        wakeup1(initproc);
80104daa:	a1 88 ce 10 80       	mov    0x8010ce88,%eax
80104daf:	89 04 24             	mov    %eax,(%esp)
80104db2:	e8 f4 05 00 00       	call   801053ab <wakeup1>

  // Parent might be sleeping in wait().
  wakeup1(proc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104db7:	81 45 f4 98 00 00 00 	addl   $0x98,-0xc(%ebp)
80104dbe:	81 7d f4 d4 47 11 80 	cmpl   $0x801147d4,-0xc(%ebp)
80104dc5:	72 bc                	jb     80104d83 <exit+0xd9>
        wakeup1(initproc);
    }
  }

  // Jump into the scheduler, never to return.
  changeStatus(ZOMBIE,proc);
80104dc7:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104dcd:	89 44 24 04          	mov    %eax,0x4(%esp)
80104dd1:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
80104dd8:	e8 c4 f9 ff ff       	call   801047a1 <changeStatus>
  sched();
80104ddd:	e8 0c 04 00 00       	call   801051ee <sched>
  panic("zombie exit");
80104de2:	c7 04 24 6e 91 10 80 	movl   $0x8010916e,(%esp)
80104de9:	e8 4f b7 ff ff       	call   8010053d <panic>

80104dee <wait>:

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait(void)
{
80104dee:	55                   	push   %ebp
80104def:	89 e5                	mov    %esp,%ebp
80104df1:	83 ec 28             	sub    $0x28,%esp
  struct proc *p;
  int havekids, pid;

  acquire(&ptable.lock);
80104df4:	c7 04 24 a0 21 11 80 	movl   $0x801121a0,(%esp)
80104dfb:	e8 03 09 00 00       	call   80105703 <acquire>
  for(;;){
    // Scan through table looking for zombie children.
    havekids = 0;
80104e00:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104e07:	c7 45 f4 d4 21 11 80 	movl   $0x801121d4,-0xc(%ebp)
80104e0e:	e9 b4 00 00 00       	jmp    80104ec7 <wait+0xd9>
      if(p->parent != proc)
80104e13:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104e16:	8b 50 14             	mov    0x14(%eax),%edx
80104e19:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104e1f:	39 c2                	cmp    %eax,%edx
80104e21:	0f 85 98 00 00 00    	jne    80104ebf <wait+0xd1>
        continue;
      havekids = 1;
80104e27:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
      if(p->state == ZOMBIE){
80104e2e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104e31:	8b 40 0c             	mov    0xc(%eax),%eax
80104e34:	83 f8 05             	cmp    $0x5,%eax
80104e37:	0f 85 83 00 00 00    	jne    80104ec0 <wait+0xd2>
        // Found one.
        pid = p->pid;
80104e3d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104e40:	8b 40 10             	mov    0x10(%eax),%eax
80104e43:	89 45 ec             	mov    %eax,-0x14(%ebp)
        kfree(p->kstack);
80104e46:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104e49:	8b 40 08             	mov    0x8(%eax),%eax
80104e4c:	89 04 24             	mov    %eax,(%esp)
80104e4f:	e8 0a e1 ff ff       	call   80102f5e <kfree>
        p->kstack = 0;
80104e54:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104e57:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
        freevm(p->pgdir);
80104e5e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104e61:	8b 40 04             	mov    0x4(%eax),%eax
80104e64:	89 04 24             	mov    %eax,(%esp)
80104e67:	e8 ed 3c 00 00       	call   80108b59 <freevm>
        changeStatus(UNUSED,p);
80104e6c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104e6f:	89 44 24 04          	mov    %eax,0x4(%esp)
80104e73:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80104e7a:	e8 22 f9 ff ff       	call   801047a1 <changeStatus>
        p->pid = 0;
80104e7f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104e82:	c7 40 10 00 00 00 00 	movl   $0x0,0x10(%eax)
        p->parent = 0;
80104e89:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104e8c:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
        p->name[0] = 0;
80104e93:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104e96:	c6 40 6c 00          	movb   $0x0,0x6c(%eax)
        p->killed = 0;
80104e9a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104e9d:	c7 40 24 00 00 00 00 	movl   $0x0,0x24(%eax)
        p->queue=0;
80104ea4:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104ea7:	c7 40 7c 00 00 00 00 	movl   $0x0,0x7c(%eax)
       
        release(&ptable.lock);
80104eae:	c7 04 24 a0 21 11 80 	movl   $0x801121a0,(%esp)
80104eb5:	e8 ab 08 00 00       	call   80105765 <release>
        return pid;
80104eba:	8b 45 ec             	mov    -0x14(%ebp),%eax
80104ebd:	eb 56                	jmp    80104f15 <wait+0x127>
  for(;;){
    // Scan through table looking for zombie children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
      if(p->parent != proc)
        continue;
80104ebf:	90                   	nop

  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for zombie children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104ec0:	81 45 f4 98 00 00 00 	addl   $0x98,-0xc(%ebp)
80104ec7:	81 7d f4 d4 47 11 80 	cmpl   $0x801147d4,-0xc(%ebp)
80104ece:	0f 82 3f ff ff ff    	jb     80104e13 <wait+0x25>
        return pid;
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || proc->killed){
80104ed4:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80104ed8:	74 0d                	je     80104ee7 <wait+0xf9>
80104eda:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104ee0:	8b 40 24             	mov    0x24(%eax),%eax
80104ee3:	85 c0                	test   %eax,%eax
80104ee5:	74 13                	je     80104efa <wait+0x10c>
      release(&ptable.lock);
80104ee7:	c7 04 24 a0 21 11 80 	movl   $0x801121a0,(%esp)
80104eee:	e8 72 08 00 00       	call   80105765 <release>
      return -1;
80104ef3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104ef8:	eb 1b                	jmp    80104f15 <wait+0x127>
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(proc, &ptable.lock);  //DOC: wait-sleep
80104efa:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104f00:	c7 44 24 04 a0 21 11 	movl   $0x801121a0,0x4(%esp)
80104f07:	80 
80104f08:	89 04 24             	mov    %eax,(%esp)
80104f0b:	e8 f7 03 00 00       	call   80105307 <sleep>
  }
80104f10:	e9 eb fe ff ff       	jmp    80104e00 <wait+0x12>
}
80104f15:	c9                   	leave  
80104f16:	c3                   	ret    

80104f17 <wait2>:


int 
wait2(int *wtime, int *rtime, int *iotime)
{
80104f17:	55                   	push   %ebp
80104f18:	89 e5                	mov    %esp,%ebp
80104f1a:	83 ec 28             	sub    $0x28,%esp
struct proc *p;
  int havekids, pid;

  acquire(&ptable.lock);
80104f1d:	c7 04 24 a0 21 11 80 	movl   $0x801121a0,(%esp)
80104f24:	e8 da 07 00 00       	call   80105703 <acquire>
  for(;;){
    // Scan through table looking for zombie children.
    havekids = 0;
80104f29:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104f30:	c7 45 f4 d4 21 11 80 	movl   $0x801121d4,-0xc(%ebp)
80104f37:	e9 09 01 00 00       	jmp    80105045 <wait2+0x12e>
      if(p->parent != proc)
80104f3c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104f3f:	8b 50 14             	mov    0x14(%eax),%edx
80104f42:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104f48:	39 c2                	cmp    %eax,%edx
80104f4a:	0f 85 ed 00 00 00    	jne    8010503d <wait2+0x126>
        continue;
      havekids = 1;
80104f50:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
      if(p->state == ZOMBIE){
80104f57:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104f5a:	8b 40 0c             	mov    0xc(%eax),%eax
80104f5d:	83 f8 05             	cmp    $0x5,%eax
80104f60:	0f 85 d8 00 00 00    	jne    8010503e <wait2+0x127>
        // Found one.
        pid = p->pid;
80104f66:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104f69:	8b 40 10             	mov    0x10(%eax),%eax
80104f6c:	89 45 ec             	mov    %eax,-0x14(%ebp)
        kfree(p->kstack);
80104f6f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104f72:	8b 40 08             	mov    0x8(%eax),%eax
80104f75:	89 04 24             	mov    %eax,(%esp)
80104f78:	e8 e1 df ff ff       	call   80102f5e <kfree>
        p->kstack = 0;
80104f7d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104f80:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
        freevm(p->pgdir);
80104f87:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104f8a:	8b 40 04             	mov    0x4(%eax),%eax
80104f8d:	89 04 24             	mov    %eax,(%esp)
80104f90:	e8 c4 3b 00 00       	call   80108b59 <freevm>
        changeStatus(UNUSED,p);
80104f95:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104f98:	89 44 24 04          	mov    %eax,0x4(%esp)
80104f9c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80104fa3:	e8 f9 f7 ff ff       	call   801047a1 <changeStatus>
        p->pid = 0;
80104fa8:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104fab:	c7 40 10 00 00 00 00 	movl   $0x0,0x10(%eax)
        p->parent = 0;
80104fb2:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104fb5:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
        p->name[0] = 0;
80104fbc:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104fbf:	c6 40 6c 00          	movb   $0x0,0x6c(%eax)
        p->killed = 0;
80104fc3:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104fc6:	c7 40 24 00 00 00 00 	movl   $0x0,0x24(%eax)
        p->queue=0;
80104fcd:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104fd0:	c7 40 7c 00 00 00 00 	movl   $0x0,0x7c(%eax)
        *wtime=p->etime-p->ctime-p->rtime-p->iotime;
80104fd7:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104fda:	8b 90 88 00 00 00    	mov    0x88(%eax),%edx
80104fe0:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104fe3:	8b 80 84 00 00 00    	mov    0x84(%eax),%eax
80104fe9:	29 c2                	sub    %eax,%edx
80104feb:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104fee:	8b 80 90 00 00 00    	mov    0x90(%eax),%eax
80104ff4:	29 c2                	sub    %eax,%edx
80104ff6:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104ff9:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
80104fff:	89 d1                	mov    %edx,%ecx
80105001:	29 c1                	sub    %eax,%ecx
80105003:	89 c8                	mov    %ecx,%eax
80105005:	89 c2                	mov    %eax,%edx
80105007:	8b 45 08             	mov    0x8(%ebp),%eax
8010500a:	89 10                	mov    %edx,(%eax)
        *rtime=p->rtime;
8010500c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010500f:	8b 80 90 00 00 00    	mov    0x90(%eax),%eax
80105015:	89 c2                	mov    %eax,%edx
80105017:	8b 45 0c             	mov    0xc(%ebp),%eax
8010501a:	89 10                	mov    %edx,(%eax)
        *iotime=p->iotime;
8010501c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010501f:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
80105025:	89 c2                	mov    %eax,%edx
80105027:	8b 45 10             	mov    0x10(%ebp),%eax
8010502a:	89 10                	mov    %edx,(%eax)
        
        release(&ptable.lock);
8010502c:	c7 04 24 a0 21 11 80 	movl   $0x801121a0,(%esp)
80105033:	e8 2d 07 00 00       	call   80105765 <release>
        return pid;
80105038:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010503b:	eb 56                	jmp    80105093 <wait2+0x17c>
  for(;;){
    // Scan through table looking for zombie children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
      if(p->parent != proc)
        continue;
8010503d:	90                   	nop

  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for zombie children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010503e:	81 45 f4 98 00 00 00 	addl   $0x98,-0xc(%ebp)
80105045:	81 7d f4 d4 47 11 80 	cmpl   $0x801147d4,-0xc(%ebp)
8010504c:	0f 82 ea fe ff ff    	jb     80104f3c <wait2+0x25>
        return pid;
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || proc->killed){
80105052:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80105056:	74 0d                	je     80105065 <wait2+0x14e>
80105058:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010505e:	8b 40 24             	mov    0x24(%eax),%eax
80105061:	85 c0                	test   %eax,%eax
80105063:	74 13                	je     80105078 <wait2+0x161>
      release(&ptable.lock);
80105065:	c7 04 24 a0 21 11 80 	movl   $0x801121a0,(%esp)
8010506c:	e8 f4 06 00 00       	call   80105765 <release>
      return -1;
80105071:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105076:	eb 1b                	jmp    80105093 <wait2+0x17c>
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(proc, &ptable.lock);  //DOC: wait-sleep
80105078:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010507e:	c7 44 24 04 a0 21 11 	movl   $0x801121a0,0x4(%esp)
80105085:	80 
80105086:	89 04 24             	mov    %eax,(%esp)
80105089:	e8 79 02 00 00       	call   80105307 <sleep>
  }
8010508e:	e9 96 fe ff ff       	jmp    80104f29 <wait2+0x12>
}
80105093:	c9                   	leave  
80105094:	c3                   	ret    

80105095 <register_handler>:


void
register_handler(sighandler_t sighandler)
{
80105095:	55                   	push   %ebp
80105096:	89 e5                	mov    %esp,%ebp
80105098:	83 ec 28             	sub    $0x28,%esp
  char* addr = uva2ka(proc->pgdir, (char*)proc->tf->esp);
8010509b:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801050a1:	8b 40 18             	mov    0x18(%eax),%eax
801050a4:	8b 40 44             	mov    0x44(%eax),%eax
801050a7:	89 c2                	mov    %eax,%edx
801050a9:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801050af:	8b 40 04             	mov    0x4(%eax),%eax
801050b2:	89 54 24 04          	mov    %edx,0x4(%esp)
801050b6:	89 04 24             	mov    %eax,(%esp)
801050b9:	e8 80 3c 00 00       	call   80108d3e <uva2ka>
801050be:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if ((proc->tf->esp & 0xFFF) == 0)
801050c1:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801050c7:	8b 40 18             	mov    0x18(%eax),%eax
801050ca:	8b 40 44             	mov    0x44(%eax),%eax
801050cd:	25 ff 0f 00 00       	and    $0xfff,%eax
801050d2:	85 c0                	test   %eax,%eax
801050d4:	75 0c                	jne    801050e2 <register_handler+0x4d>
    panic("esp_offset == 0");
801050d6:	c7 04 24 7a 91 10 80 	movl   $0x8010917a,(%esp)
801050dd:	e8 5b b4 ff ff       	call   8010053d <panic>

    /* open a new frame */
  *(int*)(addr + ((proc->tf->esp - 4) & 0xFFF))
801050e2:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801050e8:	8b 40 18             	mov    0x18(%eax),%eax
801050eb:	8b 40 44             	mov    0x44(%eax),%eax
801050ee:	83 e8 04             	sub    $0x4,%eax
801050f1:	25 ff 0f 00 00       	and    $0xfff,%eax
801050f6:	03 45 f4             	add    -0xc(%ebp),%eax
          = proc->tf->eip;
801050f9:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80105100:	8b 52 18             	mov    0x18(%edx),%edx
80105103:	8b 52 38             	mov    0x38(%edx),%edx
80105106:	89 10                	mov    %edx,(%eax)
  proc->tf->esp -= 4;
80105108:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010510e:	8b 40 18             	mov    0x18(%eax),%eax
80105111:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80105118:	8b 52 18             	mov    0x18(%edx),%edx
8010511b:	8b 52 44             	mov    0x44(%edx),%edx
8010511e:	83 ea 04             	sub    $0x4,%edx
80105121:	89 50 44             	mov    %edx,0x44(%eax)

    /* update eip */
  proc->tf->eip = (uint)sighandler;
80105124:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010512a:	8b 40 18             	mov    0x18(%eax),%eax
8010512d:	8b 55 08             	mov    0x8(%ebp),%edx
80105130:	89 50 38             	mov    %edx,0x38(%eax)
}
80105133:	c9                   	leave  
80105134:	c3                   	ret    

80105135 <operateProcess>:


void
operateProcess(struct proc *p){
80105135:	55                   	push   %ebp
80105136:	89 e5                	mov    %esp,%ebp
80105138:	83 ec 18             	sub    $0x18,%esp
  switchuvm(p);
8010513b:	8b 45 08             	mov    0x8(%ebp),%eax
8010513e:	89 04 24             	mov    %eax,(%esp)
80105141:	e8 9c 35 00 00       	call   801086e2 <switchuvm>
  changeStatus(RUNNING,p);
80105146:	8b 45 08             	mov    0x8(%ebp),%eax
80105149:	89 44 24 04          	mov    %eax,0x4(%esp)
8010514d:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
80105154:	e8 48 f6 ff ff       	call   801047a1 <changeStatus>
  swtch(&cpu->scheduler, proc->context);
80105159:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010515f:	8b 40 1c             	mov    0x1c(%eax),%eax
80105162:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80105169:	83 c2 04             	add    $0x4,%edx
8010516c:	89 44 24 04          	mov    %eax,0x4(%esp)
80105170:	89 14 24             	mov    %edx,(%esp)
80105173:	e8 e0 0a 00 00       	call   80105c58 <swtch>
  switchkvm();
80105178:	e8 48 35 00 00       	call   801086c5 <switchkvm>

  proc = 0;
8010517d:	65 c7 05 04 00 00 00 	movl   $0x0,%gs:0x4
80105184:	00 00 00 00 
}
80105188:	c9                   	leave  
80105189:	c3                   	ret    

8010518a <scheduler>:
//  - swtch to start running that process
//  - eventually that process transfers control
//      via swtch back to the scheduler.
void
scheduler(void)
{
8010518a:	55                   	push   %ebp
8010518b:	89 e5                	mov    %esp,%ebp
8010518d:	83 ec 28             	sub    $0x28,%esp
  struct proc *p;
  int workingQueue;
    //int i;
  for(;;){
    // Enable interrupts on this processor.
    sti();
80105190:	e8 68 f3 ff ff       	call   801044fd <sti>

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
80105195:	c7 04 24 a0 21 11 80 	movl   $0x801121a0,(%esp)
8010519c:	e8 62 05 00 00       	call   80105703 <acquire>
        }
        fixQueue(NORMAL_PRIORITY_QUEUE);
    break;
      
    default:
      for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801051a1:	c7 45 f4 d4 21 11 80 	movl   $0x801121d4,-0xc(%ebp)
801051a8:	eb 2c                	jmp    801051d6 <scheduler+0x4c>
        if(p->state != RUNNABLE)
801051aa:	8b 45 f4             	mov    -0xc(%ebp),%eax
801051ad:	8b 40 0c             	mov    0xc(%eax),%eax
801051b0:	83 f8 03             	cmp    $0x3,%eax
801051b3:	75 19                	jne    801051ce <scheduler+0x44>
          continue;
      
        // Switch to chosen process.  It is the process's job
        // to release ptable.lock and then reacquire it
        // before jumping back to us.
        proc = p;
801051b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801051b8:	65 a3 04 00 00 00    	mov    %eax,%gs:0x4
        operateProcess(proc);
801051be:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801051c4:	89 04 24             	mov    %eax,(%esp)
801051c7:	e8 69 ff ff ff       	call   80105135 <operateProcess>
801051cc:	eb 01                	jmp    801051cf <scheduler+0x45>
    break;
      
    default:
      for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
        if(p->state != RUNNABLE)
          continue;
801051ce:	90                   	nop
        }
        fixQueue(NORMAL_PRIORITY_QUEUE);
    break;
      
    default:
      for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801051cf:	81 45 f4 98 00 00 00 	addl   $0x98,-0xc(%ebp)
801051d6:	81 7d f4 d4 47 11 80 	cmpl   $0x801147d4,-0xc(%ebp)
801051dd:	72 cb                	jb     801051aa <scheduler+0x20>
        // to release ptable.lock and then reacquire it
        // before jumping back to us.
        proc = p;
        operateProcess(proc);
      }
    break;
801051df:	90                   	nop
    }
        release(&ptable.lock);
801051e0:	c7 04 24 a0 21 11 80 	movl   $0x801121a0,(%esp)
801051e7:	e8 79 05 00 00       	call   80105765 <release>
  }
801051ec:	eb a2                	jmp    80105190 <scheduler+0x6>

801051ee <sched>:

// Enter scheduler.  Must hold only ptable.lock
// and have changed proc->state.
void
sched(void)
{
801051ee:	55                   	push   %ebp
801051ef:	89 e5                	mov    %esp,%ebp
801051f1:	83 ec 28             	sub    $0x28,%esp
  int intena;

  if(!holding(&ptable.lock))
801051f4:	c7 04 24 a0 21 11 80 	movl   $0x801121a0,(%esp)
801051fb:	e8 21 06 00 00       	call   80105821 <holding>
80105200:	85 c0                	test   %eax,%eax
80105202:	75 0c                	jne    80105210 <sched+0x22>
    panic("sched ptable.lock");
80105204:	c7 04 24 8a 91 10 80 	movl   $0x8010918a,(%esp)
8010520b:	e8 2d b3 ff ff       	call   8010053d <panic>
  if(cpu->ncli != 1)
80105210:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80105216:	8b 80 ac 00 00 00    	mov    0xac(%eax),%eax
8010521c:	83 f8 01             	cmp    $0x1,%eax
8010521f:	74 0c                	je     8010522d <sched+0x3f>
    panic("sched locks");
80105221:	c7 04 24 9c 91 10 80 	movl   $0x8010919c,(%esp)
80105228:	e8 10 b3 ff ff       	call   8010053d <panic>
  if(proc->state == RUNNING)
8010522d:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105233:	8b 40 0c             	mov    0xc(%eax),%eax
80105236:	83 f8 04             	cmp    $0x4,%eax
80105239:	75 0c                	jne    80105247 <sched+0x59>
    panic("sched running");
8010523b:	c7 04 24 a8 91 10 80 	movl   $0x801091a8,(%esp)
80105242:	e8 f6 b2 ff ff       	call   8010053d <panic>
  if(readeflags()&FL_IF)
80105247:	e8 9c f2 ff ff       	call   801044e8 <readeflags>
8010524c:	25 00 02 00 00       	and    $0x200,%eax
80105251:	85 c0                	test   %eax,%eax
80105253:	74 0c                	je     80105261 <sched+0x73>
    panic("sched interruptible");
80105255:	c7 04 24 b6 91 10 80 	movl   $0x801091b6,(%esp)
8010525c:	e8 dc b2 ff ff       	call   8010053d <panic>
  intena = cpu->intena;
80105261:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80105267:	8b 80 b0 00 00 00    	mov    0xb0(%eax),%eax
8010526d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  swtch(&proc->context, cpu->scheduler);
80105270:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80105276:	8b 40 04             	mov    0x4(%eax),%eax
80105279:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80105280:	83 c2 1c             	add    $0x1c,%edx
80105283:	89 44 24 04          	mov    %eax,0x4(%esp)
80105287:	89 14 24             	mov    %edx,(%esp)
8010528a:	e8 c9 09 00 00       	call   80105c58 <swtch>

  cpu->intena = intena;
8010528f:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80105295:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105298:	89 90 b0 00 00 00    	mov    %edx,0xb0(%eax)
}
8010529e:	c9                   	leave  
8010529f:	c3                   	ret    

801052a0 <yield>:

// Give up the CPU for one scheduling round.
void
yield(void)
{
801052a0:	55                   	push   %ebp
801052a1:	89 e5                	mov    %esp,%ebp
801052a3:	83 ec 18             	sub    $0x18,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
801052a6:	c7 04 24 a0 21 11 80 	movl   $0x801121a0,(%esp)
801052ad:	e8 51 04 00 00       	call   80105703 <acquire>
   changeStatus(RUNNABLE,proc);
801052b2:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801052b8:	89 44 24 04          	mov    %eax,0x4(%esp)
801052bc:	c7 04 24 03 00 00 00 	movl   $0x3,(%esp)
801052c3:	e8 d9 f4 ff ff       	call   801047a1 <changeStatus>
  sched();
801052c8:	e8 21 ff ff ff       	call   801051ee <sched>
  release(&ptable.lock);
801052cd:	c7 04 24 a0 21 11 80 	movl   $0x801121a0,(%esp)
801052d4:	e8 8c 04 00 00       	call   80105765 <release>
}
801052d9:	c9                   	leave  
801052da:	c3                   	ret    

801052db <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
801052db:	55                   	push   %ebp
801052dc:	89 e5                	mov    %esp,%ebp
801052de:	83 ec 18             	sub    $0x18,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
801052e1:	c7 04 24 a0 21 11 80 	movl   $0x801121a0,(%esp)
801052e8:	e8 78 04 00 00       	call   80105765 <release>

  if (first) {
801052ed:	a1 3c c3 10 80       	mov    0x8010c33c,%eax
801052f2:	85 c0                	test   %eax,%eax
801052f4:	74 0f                	je     80105305 <forkret+0x2a>
    // Some initialization functions must be run in the context
    // of a regular process (e.g., they call sleep), and thus cannot 
    // be run from main().
    first = 0;
801052f6:	c7 05 3c c3 10 80 00 	movl   $0x0,0x8010c33c
801052fd:	00 00 00 
    initlog();
80105300:	e8 03 e2 ff ff       	call   80103508 <initlog>
  }
  
  // Return to "caller", actually trapret (see allocproc).
}
80105305:	c9                   	leave  
80105306:	c3                   	ret    

80105307 <sleep>:

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
80105307:	55                   	push   %ebp
80105308:	89 e5                	mov    %esp,%ebp
8010530a:	83 ec 18             	sub    $0x18,%esp
  if(proc == 0)
8010530d:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105313:	85 c0                	test   %eax,%eax
80105315:	75 0c                	jne    80105323 <sleep+0x1c>
    panic("sleep");
80105317:	c7 04 24 ca 91 10 80 	movl   $0x801091ca,(%esp)
8010531e:	e8 1a b2 ff ff       	call   8010053d <panic>

  if(lk == 0)
80105323:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
80105327:	75 0c                	jne    80105335 <sleep+0x2e>
    panic("sleep without lk");
80105329:	c7 04 24 d0 91 10 80 	movl   $0x801091d0,(%esp)
80105330:	e8 08 b2 ff ff       	call   8010053d <panic>
  // change p->state and then call sched.
  // Once we hold ptable.lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup runs with ptable.lock locked),
  // so it's okay to release lk.
  if(lk != &ptable.lock){  //DOC: sleeplock0
80105335:	81 7d 0c a0 21 11 80 	cmpl   $0x801121a0,0xc(%ebp)
8010533c:	74 17                	je     80105355 <sleep+0x4e>
    acquire(&ptable.lock);  //DOC: sleeplock1
8010533e:	c7 04 24 a0 21 11 80 	movl   $0x801121a0,(%esp)
80105345:	e8 b9 03 00 00       	call   80105703 <acquire>
    release(lk);
8010534a:	8b 45 0c             	mov    0xc(%ebp),%eax
8010534d:	89 04 24             	mov    %eax,(%esp)
80105350:	e8 10 04 00 00       	call   80105765 <release>
  }

  // Go to sleep.
  proc->chan = chan;
80105355:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010535b:	8b 55 08             	mov    0x8(%ebp),%edx
8010535e:	89 50 20             	mov    %edx,0x20(%eax)
   changeStatus(SLEEPING,proc);
80105361:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105367:	89 44 24 04          	mov    %eax,0x4(%esp)
8010536b:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
80105372:	e8 2a f4 ff ff       	call   801047a1 <changeStatus>
 
  sched();
80105377:	e8 72 fe ff ff       	call   801051ee <sched>

  // Tidy up.
  proc->chan = 0;
8010537c:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105382:	c7 40 20 00 00 00 00 	movl   $0x0,0x20(%eax)

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
80105389:	81 7d 0c a0 21 11 80 	cmpl   $0x801121a0,0xc(%ebp)
80105390:	74 17                	je     801053a9 <sleep+0xa2>
    release(&ptable.lock);
80105392:	c7 04 24 a0 21 11 80 	movl   $0x801121a0,(%esp)
80105399:	e8 c7 03 00 00       	call   80105765 <release>
    acquire(lk);
8010539e:	8b 45 0c             	mov    0xc(%ebp),%eax
801053a1:	89 04 24             	mov    %eax,(%esp)
801053a4:	e8 5a 03 00 00       	call   80105703 <acquire>
  }
}
801053a9:	c9                   	leave  
801053aa:	c3                   	ret    

801053ab <wakeup1>:
//PAGEBREAK!
// Wake up all processes sleeping on chan.
// The ptable lock must be held.
static void
wakeup1(void *chan)
{
801053ab:	55                   	push   %ebp
801053ac:	89 e5                	mov    %esp,%ebp
801053ae:	83 ec 28             	sub    $0x28,%esp
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801053b1:	c7 45 f4 d4 21 11 80 	movl   $0x801121d4,-0xc(%ebp)
801053b8:	eb 30                	jmp    801053ea <wakeup1+0x3f>
    if(p->state == SLEEPING && p->chan == chan)
801053ba:	8b 45 f4             	mov    -0xc(%ebp),%eax
801053bd:	8b 40 0c             	mov    0xc(%eax),%eax
801053c0:	83 f8 02             	cmp    $0x2,%eax
801053c3:	75 1e                	jne    801053e3 <wakeup1+0x38>
801053c5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801053c8:	8b 40 20             	mov    0x20(%eax),%eax
801053cb:	3b 45 08             	cmp    0x8(%ebp),%eax
801053ce:	75 13                	jne    801053e3 <wakeup1+0x38>
    {
      changeStatus(RUNNABLE,p);
801053d0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801053d3:	89 44 24 04          	mov    %eax,0x4(%esp)
801053d7:	c7 04 24 03 00 00 00 	movl   $0x3,(%esp)
801053de:	e8 be f3 ff ff       	call   801047a1 <changeStatus>
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801053e3:	81 45 f4 98 00 00 00 	addl   $0x98,-0xc(%ebp)
801053ea:	81 7d f4 d4 47 11 80 	cmpl   $0x801147d4,-0xc(%ebp)
801053f1:	72 c7                	jb     801053ba <wakeup1+0xf>
    if(p->state == SLEEPING && p->chan == chan)
    {
      changeStatus(RUNNABLE,p);
    }
    
}
801053f3:	c9                   	leave  
801053f4:	c3                   	ret    

801053f5 <wakeup>:

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
801053f5:	55                   	push   %ebp
801053f6:	89 e5                	mov    %esp,%ebp
801053f8:	83 ec 18             	sub    $0x18,%esp
  acquire(&ptable.lock);
801053fb:	c7 04 24 a0 21 11 80 	movl   $0x801121a0,(%esp)
80105402:	e8 fc 02 00 00       	call   80105703 <acquire>
  wakeup1(chan);
80105407:	8b 45 08             	mov    0x8(%ebp),%eax
8010540a:	89 04 24             	mov    %eax,(%esp)
8010540d:	e8 99 ff ff ff       	call   801053ab <wakeup1>
  release(&ptable.lock);
80105412:	c7 04 24 a0 21 11 80 	movl   $0x801121a0,(%esp)
80105419:	e8 47 03 00 00       	call   80105765 <release>
}
8010541e:	c9                   	leave  
8010541f:	c3                   	ret    

80105420 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
80105420:	55                   	push   %ebp
80105421:	89 e5                	mov    %esp,%ebp
80105423:	83 ec 28             	sub    $0x28,%esp
  struct proc *p;

  acquire(&ptable.lock);
80105426:	c7 04 24 a0 21 11 80 	movl   $0x801121a0,(%esp)
8010542d:	e8 d1 02 00 00       	call   80105703 <acquire>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80105432:	c7 45 f4 d4 21 11 80 	movl   $0x801121d4,-0xc(%ebp)
80105439:	eb 4d                	jmp    80105488 <kill+0x68>
    if(p->pid == pid){
8010543b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010543e:	8b 40 10             	mov    0x10(%eax),%eax
80105441:	3b 45 08             	cmp    0x8(%ebp),%eax
80105444:	75 3b                	jne    80105481 <kill+0x61>
      p->killed = 1;
80105446:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105449:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING){
80105450:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105453:	8b 40 0c             	mov    0xc(%eax),%eax
80105456:	83 f8 02             	cmp    $0x2,%eax
80105459:	75 13                	jne    8010546e <kill+0x4e>
        changeStatus(RUNNABLE,p);
8010545b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010545e:	89 44 24 04          	mov    %eax,0x4(%esp)
80105462:	c7 04 24 03 00 00 00 	movl   $0x3,(%esp)
80105469:	e8 33 f3 ff ff       	call   801047a1 <changeStatus>
      }
      
      release(&ptable.lock);
8010546e:	c7 04 24 a0 21 11 80 	movl   $0x801121a0,(%esp)
80105475:	e8 eb 02 00 00       	call   80105765 <release>
      return 0;
8010547a:	b8 00 00 00 00       	mov    $0x0,%eax
8010547f:	eb 21                	jmp    801054a2 <kill+0x82>
kill(int pid)
{
  struct proc *p;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80105481:	81 45 f4 98 00 00 00 	addl   $0x98,-0xc(%ebp)
80105488:	81 7d f4 d4 47 11 80 	cmpl   $0x801147d4,-0xc(%ebp)
8010548f:	72 aa                	jb     8010543b <kill+0x1b>
      
      release(&ptable.lock);
      return 0;
    }
  }
  release(&ptable.lock);
80105491:	c7 04 24 a0 21 11 80 	movl   $0x801121a0,(%esp)
80105498:	e8 c8 02 00 00       	call   80105765 <release>
  return -1;
8010549d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801054a2:	c9                   	leave  
801054a3:	c3                   	ret    

801054a4 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
801054a4:	55                   	push   %ebp
801054a5:	89 e5                	mov    %esp,%ebp
801054a7:	53                   	push   %ebx
801054a8:	83 ec 64             	sub    $0x64,%esp
  };
  int i;
  struct proc *p;
  char *state;
  uint pc[10];
  cprintf("Process List:\n");
801054ab:	c7 04 24 e1 91 10 80 	movl   $0x801091e1,(%esp)
801054b2:	e8 ea ae ff ff       	call   801003a1 <cprintf>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801054b7:	c7 45 f0 d4 21 11 80 	movl   $0x801121d4,-0x10(%ebp)
801054be:	e9 3e 01 00 00       	jmp    80105601 <procdump+0x15d>
    if(p->state == UNUSED)
801054c3:	8b 45 f0             	mov    -0x10(%ebp),%eax
801054c6:	8b 40 0c             	mov    0xc(%eax),%eax
801054c9:	85 c0                	test   %eax,%eax
801054cb:	0f 84 28 01 00 00    	je     801055f9 <procdump+0x155>
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
801054d1:	8b 45 f0             	mov    -0x10(%ebp),%eax
801054d4:	8b 40 0c             	mov    0xc(%eax),%eax
801054d7:	83 f8 05             	cmp    $0x5,%eax
801054da:	77 23                	ja     801054ff <procdump+0x5b>
801054dc:	8b 45 f0             	mov    -0x10(%ebp),%eax
801054df:	8b 40 0c             	mov    0xc(%eax),%eax
801054e2:	8b 04 85 24 c3 10 80 	mov    -0x7fef3cdc(,%eax,4),%eax
801054e9:	85 c0                	test   %eax,%eax
801054eb:	74 12                	je     801054ff <procdump+0x5b>
      state = states[p->state];
801054ed:	8b 45 f0             	mov    -0x10(%ebp),%eax
801054f0:	8b 40 0c             	mov    0xc(%eax),%eax
801054f3:	8b 04 85 24 c3 10 80 	mov    -0x7fef3cdc(,%eax,4),%eax
801054fa:	89 45 ec             	mov    %eax,-0x14(%ebp)
801054fd:	eb 07                	jmp    80105506 <procdump+0x62>
    else
      state = "???";
801054ff:	c7 45 ec f0 91 10 80 	movl   $0x801091f0,-0x14(%ebp)
    cprintf("id:%d status:%s name:%s\n", p->pid, state, p->name);
80105506:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105509:	8d 50 6c             	lea    0x6c(%eax),%edx
8010550c:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010550f:	8b 40 10             	mov    0x10(%eax),%eax
80105512:	89 54 24 0c          	mov    %edx,0xc(%esp)
80105516:	8b 55 ec             	mov    -0x14(%ebp),%edx
80105519:	89 54 24 08          	mov    %edx,0x8(%esp)
8010551d:	89 44 24 04          	mov    %eax,0x4(%esp)
80105521:	c7 04 24 f4 91 10 80 	movl   $0x801091f4,(%esp)
80105528:	e8 74 ae ff ff       	call   801003a1 <cprintf>
    cprintf("ctime:%d rtime:%d iotime:%d etime:%d\n", p->ctime, p->rtime, p->iotime,p->etime);
8010552d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105530:	8b 98 88 00 00 00    	mov    0x88(%eax),%ebx
80105536:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105539:	8b 88 8c 00 00 00    	mov    0x8c(%eax),%ecx
8010553f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105542:	8b 90 90 00 00 00    	mov    0x90(%eax),%edx
80105548:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010554b:	8b 80 84 00 00 00    	mov    0x84(%eax),%eax
80105551:	89 5c 24 10          	mov    %ebx,0x10(%esp)
80105555:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
80105559:	89 54 24 08          	mov    %edx,0x8(%esp)
8010555d:	89 44 24 04          	mov    %eax,0x4(%esp)
80105561:	c7 04 24 10 92 10 80 	movl   $0x80109210,(%esp)
80105568:	e8 34 ae ff ff       	call   801003a1 <cprintf>
        cprintf("quanta is:%d queue is:%d\n", p->quanta,p->queue);
8010556d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105570:	8b 50 7c             	mov    0x7c(%eax),%edx
80105573:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105576:	8b 80 94 00 00 00    	mov    0x94(%eax),%eax
8010557c:	89 54 24 08          	mov    %edx,0x8(%esp)
80105580:	89 44 24 04          	mov    %eax,0x4(%esp)
80105584:	c7 04 24 36 92 10 80 	movl   $0x80109236,(%esp)
8010558b:	e8 11 ae ff ff       	call   801003a1 <cprintf>
    if(p->state == SLEEPING){
80105590:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105593:	8b 40 0c             	mov    0xc(%eax),%eax
80105596:	83 f8 02             	cmp    $0x2,%eax
80105599:	75 50                	jne    801055eb <procdump+0x147>
      getcallerpcs((uint*)p->context->ebp+2, pc);
8010559b:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010559e:	8b 40 1c             	mov    0x1c(%eax),%eax
801055a1:	8b 40 0c             	mov    0xc(%eax),%eax
801055a4:	83 c0 08             	add    $0x8,%eax
801055a7:	8d 55 c4             	lea    -0x3c(%ebp),%edx
801055aa:	89 54 24 04          	mov    %edx,0x4(%esp)
801055ae:	89 04 24             	mov    %eax,(%esp)
801055b1:	e8 fe 01 00 00       	call   801057b4 <getcallerpcs>
      for(i=0; i<10 && pc[i] != 0; i++)
801055b6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801055bd:	eb 1b                	jmp    801055da <procdump+0x136>
        cprintf("%p  ", pc[i]);
801055bf:	8b 45 f4             	mov    -0xc(%ebp),%eax
801055c2:	8b 44 85 c4          	mov    -0x3c(%ebp,%eax,4),%eax
801055c6:	89 44 24 04          	mov    %eax,0x4(%esp)
801055ca:	c7 04 24 50 92 10 80 	movl   $0x80109250,(%esp)
801055d1:	e8 cb ad ff ff       	call   801003a1 <cprintf>
    cprintf("id:%d status:%s name:%s\n", p->pid, state, p->name);
    cprintf("ctime:%d rtime:%d iotime:%d etime:%d\n", p->ctime, p->rtime, p->iotime,p->etime);
        cprintf("quanta is:%d queue is:%d\n", p->quanta,p->queue);
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
801055d6:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801055da:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
801055de:	7f 0b                	jg     801055eb <procdump+0x147>
801055e0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801055e3:	8b 44 85 c4          	mov    -0x3c(%ebp,%eax,4),%eax
801055e7:	85 c0                	test   %eax,%eax
801055e9:	75 d4                	jne    801055bf <procdump+0x11b>
        cprintf("%p  ", pc[i]);
    }
    cprintf("\n");
801055eb:	c7 04 24 55 92 10 80 	movl   $0x80109255,(%esp)
801055f2:	e8 aa ad ff ff       	call   801003a1 <cprintf>
801055f7:	eb 01                	jmp    801055fa <procdump+0x156>
  char *state;
  uint pc[10];
  cprintf("Process List:\n");
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->state == UNUSED)
      continue;
801055f9:	90                   	nop
  int i;
  struct proc *p;
  char *state;
  uint pc[10];
  cprintf("Process List:\n");
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801055fa:	81 45 f0 98 00 00 00 	addl   $0x98,-0x10(%ebp)
80105601:	81 7d f0 d4 47 11 80 	cmpl   $0x801147d4,-0x10(%ebp)
80105608:	0f 82 b5 fe ff ff    	jb     801054c3 <procdump+0x1f>
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf("%p  ", pc[i]);
    }
    cprintf("\n");
  }
  cprintf("SCHEFLAG is : %d",SCHEDFLAG);
8010560e:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
80105615:	00 
80105616:	c7 04 24 57 92 10 80 	movl   $0x80109257,(%esp)
8010561d:	e8 7f ad ff ff       	call   801003a1 <cprintf>
  for (i=0;i<NUMBER_OF_QUEUES*NPROC;i++){
80105622:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80105629:	eb 55                	jmp    80105680 <procdump+0x1dc>
    if (i%NPROC==0)
8010562b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010562e:	83 e0 3f             	and    $0x3f,%eax
80105631:	85 c0                	test   %eax,%eax
80105633:	75 1e                	jne    80105653 <procdump+0x1af>
    {
      cprintf("\n* Queue %d *",i/NPROC);  
80105635:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105638:	8d 50 3f             	lea    0x3f(%eax),%edx
8010563b:	85 c0                	test   %eax,%eax
8010563d:	0f 48 c2             	cmovs  %edx,%eax
80105640:	c1 f8 06             	sar    $0x6,%eax
80105643:	89 44 24 04          	mov    %eax,0x4(%esp)
80105647:	c7 04 24 68 92 10 80 	movl   $0x80109268,(%esp)
8010564e:	e8 4e ad ff ff       	call   801003a1 <cprintf>
    }
    if(pidQueue[i]!=-1)
80105653:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105656:	8b 04 85 20 c0 10 80 	mov    -0x7fef3fe0(,%eax,4),%eax
8010565d:	83 f8 ff             	cmp    $0xffffffff,%eax
80105660:	74 1a                	je     8010567c <procdump+0x1d8>
      cprintf(" %d",pidQueue[i]);
80105662:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105665:	8b 04 85 20 c0 10 80 	mov    -0x7fef3fe0(,%eax,4),%eax
8010566c:	89 44 24 04          	mov    %eax,0x4(%esp)
80105670:	c7 04 24 76 92 10 80 	movl   $0x80109276,(%esp)
80105677:	e8 25 ad ff ff       	call   801003a1 <cprintf>
        cprintf("%p  ", pc[i]);
    }
    cprintf("\n");
  }
  cprintf("SCHEFLAG is : %d",SCHEDFLAG);
  for (i=0;i<NUMBER_OF_QUEUES*NPROC;i++){
8010567c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80105680:	81 7d f4 bf 00 00 00 	cmpl   $0xbf,-0xc(%ebp)
80105687:	7e a2                	jle    8010562b <procdump+0x187>
      cprintf("\n* Queue %d *",i/NPROC);  
    }
    if(pidQueue[i]!=-1)
      cprintf(" %d",pidQueue[i]);
  }
  cprintf("\n");
80105689:	c7 04 24 55 92 10 80 	movl   $0x80109255,(%esp)
80105690:	e8 0c ad ff ff       	call   801003a1 <cprintf>
  
}
80105695:	83 c4 64             	add    $0x64,%esp
80105698:	5b                   	pop    %ebx
80105699:	5d                   	pop    %ebp
8010569a:	c3                   	ret    
	...

8010569c <readeflags>:
  asm volatile("ltr %0" : : "r" (sel));
}

static inline uint
readeflags(void)
{
8010569c:	55                   	push   %ebp
8010569d:	89 e5                	mov    %esp,%ebp
8010569f:	53                   	push   %ebx
801056a0:	83 ec 10             	sub    $0x10,%esp
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801056a3:	9c                   	pushf  
801056a4:	5b                   	pop    %ebx
801056a5:	89 5d f8             	mov    %ebx,-0x8(%ebp)
  return eflags;
801056a8:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
801056ab:	83 c4 10             	add    $0x10,%esp
801056ae:	5b                   	pop    %ebx
801056af:	5d                   	pop    %ebp
801056b0:	c3                   	ret    

801056b1 <cli>:
  asm volatile("movw %0, %%gs" : : "r" (v));
}

static inline void
cli(void)
{
801056b1:	55                   	push   %ebp
801056b2:	89 e5                	mov    %esp,%ebp
  asm volatile("cli");
801056b4:	fa                   	cli    
}
801056b5:	5d                   	pop    %ebp
801056b6:	c3                   	ret    

801056b7 <sti>:

static inline void
sti(void)
{
801056b7:	55                   	push   %ebp
801056b8:	89 e5                	mov    %esp,%ebp
  asm volatile("sti");
801056ba:	fb                   	sti    
}
801056bb:	5d                   	pop    %ebp
801056bc:	c3                   	ret    

801056bd <xchg>:

static inline uint
xchg(volatile uint *addr, uint newval)
{
801056bd:	55                   	push   %ebp
801056be:	89 e5                	mov    %esp,%ebp
801056c0:	53                   	push   %ebx
801056c1:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
               "+m" (*addr), "=a" (result) :
801056c4:	8b 55 08             	mov    0x8(%ebp),%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
801056c7:	8b 45 0c             	mov    0xc(%ebp),%eax
               "+m" (*addr), "=a" (result) :
801056ca:	8b 4d 08             	mov    0x8(%ebp),%ecx
xchg(volatile uint *addr, uint newval)
{
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
801056cd:	89 c3                	mov    %eax,%ebx
801056cf:	89 d8                	mov    %ebx,%eax
801056d1:	f0 87 02             	lock xchg %eax,(%edx)
801056d4:	89 c3                	mov    %eax,%ebx
801056d6:	89 5d f8             	mov    %ebx,-0x8(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
801056d9:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
801056dc:	83 c4 10             	add    $0x10,%esp
801056df:	5b                   	pop    %ebx
801056e0:	5d                   	pop    %ebp
801056e1:	c3                   	ret    

801056e2 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
801056e2:	55                   	push   %ebp
801056e3:	89 e5                	mov    %esp,%ebp
  lk->name = name;
801056e5:	8b 45 08             	mov    0x8(%ebp),%eax
801056e8:	8b 55 0c             	mov    0xc(%ebp),%edx
801056eb:	89 50 04             	mov    %edx,0x4(%eax)
  lk->locked = 0;
801056ee:	8b 45 08             	mov    0x8(%ebp),%eax
801056f1:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->cpu = 0;
801056f7:	8b 45 08             	mov    0x8(%ebp),%eax
801056fa:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80105701:	5d                   	pop    %ebp
80105702:	c3                   	ret    

80105703 <acquire>:
// Loops (spins) until the lock is acquired.
// Holding a lock for a long time may cause
// other CPUs to waste time spinning to acquire it.
void
acquire(struct spinlock *lk)
{
80105703:	55                   	push   %ebp
80105704:	89 e5                	mov    %esp,%ebp
80105706:	83 ec 18             	sub    $0x18,%esp
  pushcli(); // disable interrupts to avoid deadlock.
80105709:	e8 3d 01 00 00       	call   8010584b <pushcli>
  if(holding(lk))
8010570e:	8b 45 08             	mov    0x8(%ebp),%eax
80105711:	89 04 24             	mov    %eax,(%esp)
80105714:	e8 08 01 00 00       	call   80105821 <holding>
80105719:	85 c0                	test   %eax,%eax
8010571b:	74 0c                	je     80105729 <acquire+0x26>
    panic("acquire");
8010571d:	c7 04 24 a4 92 10 80 	movl   $0x801092a4,(%esp)
80105724:	e8 14 ae ff ff       	call   8010053d <panic>

  // The xchg is atomic.
  // It also serializes, so that reads after acquire are not
  // reordered before it. 
  while(xchg(&lk->locked, 1) != 0)
80105729:	90                   	nop
8010572a:	8b 45 08             	mov    0x8(%ebp),%eax
8010572d:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
80105734:	00 
80105735:	89 04 24             	mov    %eax,(%esp)
80105738:	e8 80 ff ff ff       	call   801056bd <xchg>
8010573d:	85 c0                	test   %eax,%eax
8010573f:	75 e9                	jne    8010572a <acquire+0x27>
    ;

  // Record info about lock acquisition for debugging.
  lk->cpu = cpu;
80105741:	8b 45 08             	mov    0x8(%ebp),%eax
80105744:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
8010574b:	89 50 08             	mov    %edx,0x8(%eax)
  getcallerpcs(&lk, lk->pcs);
8010574e:	8b 45 08             	mov    0x8(%ebp),%eax
80105751:	83 c0 0c             	add    $0xc,%eax
80105754:	89 44 24 04          	mov    %eax,0x4(%esp)
80105758:	8d 45 08             	lea    0x8(%ebp),%eax
8010575b:	89 04 24             	mov    %eax,(%esp)
8010575e:	e8 51 00 00 00       	call   801057b4 <getcallerpcs>
}
80105763:	c9                   	leave  
80105764:	c3                   	ret    

80105765 <release>:

// Release the lock.
void
release(struct spinlock *lk)
{
80105765:	55                   	push   %ebp
80105766:	89 e5                	mov    %esp,%ebp
80105768:	83 ec 18             	sub    $0x18,%esp
  if(!holding(lk))
8010576b:	8b 45 08             	mov    0x8(%ebp),%eax
8010576e:	89 04 24             	mov    %eax,(%esp)
80105771:	e8 ab 00 00 00       	call   80105821 <holding>
80105776:	85 c0                	test   %eax,%eax
80105778:	75 0c                	jne    80105786 <release+0x21>
    panic("release");
8010577a:	c7 04 24 ac 92 10 80 	movl   $0x801092ac,(%esp)
80105781:	e8 b7 ad ff ff       	call   8010053d <panic>

  lk->pcs[0] = 0;
80105786:	8b 45 08             	mov    0x8(%ebp),%eax
80105789:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
  lk->cpu = 0;
80105790:	8b 45 08             	mov    0x8(%ebp),%eax
80105793:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
  // But the 2007 Intel 64 Architecture Memory Ordering White
  // Paper says that Intel 64 and IA-32 will not move a load
  // after a store. So lock->locked = 0 would work here.
  // The xchg being asm volatile ensures gcc emits it after
  // the above assignments (and after the critical section).
  xchg(&lk->locked, 0);
8010579a:	8b 45 08             	mov    0x8(%ebp),%eax
8010579d:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
801057a4:	00 
801057a5:	89 04 24             	mov    %eax,(%esp)
801057a8:	e8 10 ff ff ff       	call   801056bd <xchg>

  popcli();
801057ad:	e8 e1 00 00 00       	call   80105893 <popcli>
}
801057b2:	c9                   	leave  
801057b3:	c3                   	ret    

801057b4 <getcallerpcs>:

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
801057b4:	55                   	push   %ebp
801057b5:	89 e5                	mov    %esp,%ebp
801057b7:	83 ec 10             	sub    $0x10,%esp
  uint *ebp;
  int i;
  
  ebp = (uint*)v - 2;
801057ba:	8b 45 08             	mov    0x8(%ebp),%eax
801057bd:	83 e8 08             	sub    $0x8,%eax
801057c0:	89 45 fc             	mov    %eax,-0x4(%ebp)
  for(i = 0; i < 10; i++){
801057c3:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
801057ca:	eb 32                	jmp    801057fe <getcallerpcs+0x4a>
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
801057cc:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
801057d0:	74 47                	je     80105819 <getcallerpcs+0x65>
801057d2:	81 7d fc ff ff ff 7f 	cmpl   $0x7fffffff,-0x4(%ebp)
801057d9:	76 3e                	jbe    80105819 <getcallerpcs+0x65>
801057db:	83 7d fc ff          	cmpl   $0xffffffff,-0x4(%ebp)
801057df:	74 38                	je     80105819 <getcallerpcs+0x65>
      break;
    pcs[i] = ebp[1];     // saved %eip
801057e1:	8b 45 f8             	mov    -0x8(%ebp),%eax
801057e4:	c1 e0 02             	shl    $0x2,%eax
801057e7:	03 45 0c             	add    0xc(%ebp),%eax
801057ea:	8b 55 fc             	mov    -0x4(%ebp),%edx
801057ed:	8b 52 04             	mov    0x4(%edx),%edx
801057f0:	89 10                	mov    %edx,(%eax)
    ebp = (uint*)ebp[0]; // saved %ebp
801057f2:	8b 45 fc             	mov    -0x4(%ebp),%eax
801057f5:	8b 00                	mov    (%eax),%eax
801057f7:	89 45 fc             	mov    %eax,-0x4(%ebp)
{
  uint *ebp;
  int i;
  
  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
801057fa:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
801057fe:	83 7d f8 09          	cmpl   $0x9,-0x8(%ebp)
80105802:	7e c8                	jle    801057cc <getcallerpcs+0x18>
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
80105804:	eb 13                	jmp    80105819 <getcallerpcs+0x65>
    pcs[i] = 0;
80105806:	8b 45 f8             	mov    -0x8(%ebp),%eax
80105809:	c1 e0 02             	shl    $0x2,%eax
8010580c:	03 45 0c             	add    0xc(%ebp),%eax
8010580f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
80105815:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
80105819:	83 7d f8 09          	cmpl   $0x9,-0x8(%ebp)
8010581d:	7e e7                	jle    80105806 <getcallerpcs+0x52>
    pcs[i] = 0;
}
8010581f:	c9                   	leave  
80105820:	c3                   	ret    

80105821 <holding>:

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
80105821:	55                   	push   %ebp
80105822:	89 e5                	mov    %esp,%ebp
  return lock->locked && lock->cpu == cpu;
80105824:	8b 45 08             	mov    0x8(%ebp),%eax
80105827:	8b 00                	mov    (%eax),%eax
80105829:	85 c0                	test   %eax,%eax
8010582b:	74 17                	je     80105844 <holding+0x23>
8010582d:	8b 45 08             	mov    0x8(%ebp),%eax
80105830:	8b 50 08             	mov    0x8(%eax),%edx
80105833:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80105839:	39 c2                	cmp    %eax,%edx
8010583b:	75 07                	jne    80105844 <holding+0x23>
8010583d:	b8 01 00 00 00       	mov    $0x1,%eax
80105842:	eb 05                	jmp    80105849 <holding+0x28>
80105844:	b8 00 00 00 00       	mov    $0x0,%eax
}
80105849:	5d                   	pop    %ebp
8010584a:	c3                   	ret    

8010584b <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
8010584b:	55                   	push   %ebp
8010584c:	89 e5                	mov    %esp,%ebp
8010584e:	83 ec 10             	sub    $0x10,%esp
  int eflags;
  
  eflags = readeflags();
80105851:	e8 46 fe ff ff       	call   8010569c <readeflags>
80105856:	89 45 fc             	mov    %eax,-0x4(%ebp)
  cli();
80105859:	e8 53 fe ff ff       	call   801056b1 <cli>
  if(cpu->ncli++ == 0)
8010585e:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80105864:	8b 90 ac 00 00 00    	mov    0xac(%eax),%edx
8010586a:	85 d2                	test   %edx,%edx
8010586c:	0f 94 c1             	sete   %cl
8010586f:	83 c2 01             	add    $0x1,%edx
80105872:	89 90 ac 00 00 00    	mov    %edx,0xac(%eax)
80105878:	84 c9                	test   %cl,%cl
8010587a:	74 15                	je     80105891 <pushcli+0x46>
    cpu->intena = eflags & FL_IF;
8010587c:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80105882:	8b 55 fc             	mov    -0x4(%ebp),%edx
80105885:	81 e2 00 02 00 00    	and    $0x200,%edx
8010588b:	89 90 b0 00 00 00    	mov    %edx,0xb0(%eax)
}
80105891:	c9                   	leave  
80105892:	c3                   	ret    

80105893 <popcli>:

void
popcli(void)
{
80105893:	55                   	push   %ebp
80105894:	89 e5                	mov    %esp,%ebp
80105896:	83 ec 18             	sub    $0x18,%esp
  if(readeflags()&FL_IF)
80105899:	e8 fe fd ff ff       	call   8010569c <readeflags>
8010589e:	25 00 02 00 00       	and    $0x200,%eax
801058a3:	85 c0                	test   %eax,%eax
801058a5:	74 0c                	je     801058b3 <popcli+0x20>
    panic("popcli - interruptible");
801058a7:	c7 04 24 b4 92 10 80 	movl   $0x801092b4,(%esp)
801058ae:	e8 8a ac ff ff       	call   8010053d <panic>
  if(--cpu->ncli < 0)
801058b3:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801058b9:	8b 90 ac 00 00 00    	mov    0xac(%eax),%edx
801058bf:	83 ea 01             	sub    $0x1,%edx
801058c2:	89 90 ac 00 00 00    	mov    %edx,0xac(%eax)
801058c8:	8b 80 ac 00 00 00    	mov    0xac(%eax),%eax
801058ce:	85 c0                	test   %eax,%eax
801058d0:	79 0c                	jns    801058de <popcli+0x4b>
    panic("popcli");
801058d2:	c7 04 24 cb 92 10 80 	movl   $0x801092cb,(%esp)
801058d9:	e8 5f ac ff ff       	call   8010053d <panic>
  if(cpu->ncli == 0 && cpu->intena)
801058de:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801058e4:	8b 80 ac 00 00 00    	mov    0xac(%eax),%eax
801058ea:	85 c0                	test   %eax,%eax
801058ec:	75 15                	jne    80105903 <popcli+0x70>
801058ee:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801058f4:	8b 80 b0 00 00 00    	mov    0xb0(%eax),%eax
801058fa:	85 c0                	test   %eax,%eax
801058fc:	74 05                	je     80105903 <popcli+0x70>
    sti();
801058fe:	e8 b4 fd ff ff       	call   801056b7 <sti>
}
80105903:	c9                   	leave  
80105904:	c3                   	ret    
80105905:	00 00                	add    %al,(%eax)
	...

80105908 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
80105908:	55                   	push   %ebp
80105909:	89 e5                	mov    %esp,%ebp
8010590b:	57                   	push   %edi
8010590c:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
8010590d:	8b 4d 08             	mov    0x8(%ebp),%ecx
80105910:	8b 55 10             	mov    0x10(%ebp),%edx
80105913:	8b 45 0c             	mov    0xc(%ebp),%eax
80105916:	89 cb                	mov    %ecx,%ebx
80105918:	89 df                	mov    %ebx,%edi
8010591a:	89 d1                	mov    %edx,%ecx
8010591c:	fc                   	cld    
8010591d:	f3 aa                	rep stos %al,%es:(%edi)
8010591f:	89 ca                	mov    %ecx,%edx
80105921:	89 fb                	mov    %edi,%ebx
80105923:	89 5d 08             	mov    %ebx,0x8(%ebp)
80105926:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
80105929:	5b                   	pop    %ebx
8010592a:	5f                   	pop    %edi
8010592b:	5d                   	pop    %ebp
8010592c:	c3                   	ret    

8010592d <stosl>:

static inline void
stosl(void *addr, int data, int cnt)
{
8010592d:	55                   	push   %ebp
8010592e:	89 e5                	mov    %esp,%ebp
80105930:	57                   	push   %edi
80105931:	53                   	push   %ebx
  asm volatile("cld; rep stosl" :
80105932:	8b 4d 08             	mov    0x8(%ebp),%ecx
80105935:	8b 55 10             	mov    0x10(%ebp),%edx
80105938:	8b 45 0c             	mov    0xc(%ebp),%eax
8010593b:	89 cb                	mov    %ecx,%ebx
8010593d:	89 df                	mov    %ebx,%edi
8010593f:	89 d1                	mov    %edx,%ecx
80105941:	fc                   	cld    
80105942:	f3 ab                	rep stos %eax,%es:(%edi)
80105944:	89 ca                	mov    %ecx,%edx
80105946:	89 fb                	mov    %edi,%ebx
80105948:	89 5d 08             	mov    %ebx,0x8(%ebp)
8010594b:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
8010594e:	5b                   	pop    %ebx
8010594f:	5f                   	pop    %edi
80105950:	5d                   	pop    %ebp
80105951:	c3                   	ret    

80105952 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80105952:	55                   	push   %ebp
80105953:	89 e5                	mov    %esp,%ebp
80105955:	83 ec 0c             	sub    $0xc,%esp
  if ((int)dst%4 == 0 && n%4 == 0){
80105958:	8b 45 08             	mov    0x8(%ebp),%eax
8010595b:	83 e0 03             	and    $0x3,%eax
8010595e:	85 c0                	test   %eax,%eax
80105960:	75 49                	jne    801059ab <memset+0x59>
80105962:	8b 45 10             	mov    0x10(%ebp),%eax
80105965:	83 e0 03             	and    $0x3,%eax
80105968:	85 c0                	test   %eax,%eax
8010596a:	75 3f                	jne    801059ab <memset+0x59>
    c &= 0xFF;
8010596c:	81 65 0c ff 00 00 00 	andl   $0xff,0xc(%ebp)
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
80105973:	8b 45 10             	mov    0x10(%ebp),%eax
80105976:	c1 e8 02             	shr    $0x2,%eax
80105979:	89 c2                	mov    %eax,%edx
8010597b:	8b 45 0c             	mov    0xc(%ebp),%eax
8010597e:	89 c1                	mov    %eax,%ecx
80105980:	c1 e1 18             	shl    $0x18,%ecx
80105983:	8b 45 0c             	mov    0xc(%ebp),%eax
80105986:	c1 e0 10             	shl    $0x10,%eax
80105989:	09 c1                	or     %eax,%ecx
8010598b:	8b 45 0c             	mov    0xc(%ebp),%eax
8010598e:	c1 e0 08             	shl    $0x8,%eax
80105991:	09 c8                	or     %ecx,%eax
80105993:	0b 45 0c             	or     0xc(%ebp),%eax
80105996:	89 54 24 08          	mov    %edx,0x8(%esp)
8010599a:	89 44 24 04          	mov    %eax,0x4(%esp)
8010599e:	8b 45 08             	mov    0x8(%ebp),%eax
801059a1:	89 04 24             	mov    %eax,(%esp)
801059a4:	e8 84 ff ff ff       	call   8010592d <stosl>
801059a9:	eb 19                	jmp    801059c4 <memset+0x72>
  } else
    stosb(dst, c, n);
801059ab:	8b 45 10             	mov    0x10(%ebp),%eax
801059ae:	89 44 24 08          	mov    %eax,0x8(%esp)
801059b2:	8b 45 0c             	mov    0xc(%ebp),%eax
801059b5:	89 44 24 04          	mov    %eax,0x4(%esp)
801059b9:	8b 45 08             	mov    0x8(%ebp),%eax
801059bc:	89 04 24             	mov    %eax,(%esp)
801059bf:	e8 44 ff ff ff       	call   80105908 <stosb>
  return dst;
801059c4:	8b 45 08             	mov    0x8(%ebp),%eax
}
801059c7:	c9                   	leave  
801059c8:	c3                   	ret    

801059c9 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
801059c9:	55                   	push   %ebp
801059ca:	89 e5                	mov    %esp,%ebp
801059cc:	83 ec 10             	sub    $0x10,%esp
  const uchar *s1, *s2;
  
  s1 = v1;
801059cf:	8b 45 08             	mov    0x8(%ebp),%eax
801059d2:	89 45 fc             	mov    %eax,-0x4(%ebp)
  s2 = v2;
801059d5:	8b 45 0c             	mov    0xc(%ebp),%eax
801059d8:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0){
801059db:	eb 32                	jmp    80105a0f <memcmp+0x46>
    if(*s1 != *s2)
801059dd:	8b 45 fc             	mov    -0x4(%ebp),%eax
801059e0:	0f b6 10             	movzbl (%eax),%edx
801059e3:	8b 45 f8             	mov    -0x8(%ebp),%eax
801059e6:	0f b6 00             	movzbl (%eax),%eax
801059e9:	38 c2                	cmp    %al,%dl
801059eb:	74 1a                	je     80105a07 <memcmp+0x3e>
      return *s1 - *s2;
801059ed:	8b 45 fc             	mov    -0x4(%ebp),%eax
801059f0:	0f b6 00             	movzbl (%eax),%eax
801059f3:	0f b6 d0             	movzbl %al,%edx
801059f6:	8b 45 f8             	mov    -0x8(%ebp),%eax
801059f9:	0f b6 00             	movzbl (%eax),%eax
801059fc:	0f b6 c0             	movzbl %al,%eax
801059ff:	89 d1                	mov    %edx,%ecx
80105a01:	29 c1                	sub    %eax,%ecx
80105a03:	89 c8                	mov    %ecx,%eax
80105a05:	eb 1c                	jmp    80105a23 <memcmp+0x5a>
    s1++, s2++;
80105a07:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
80105a0b:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
{
  const uchar *s1, *s2;
  
  s1 = v1;
  s2 = v2;
  while(n-- > 0){
80105a0f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80105a13:	0f 95 c0             	setne  %al
80105a16:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
80105a1a:	84 c0                	test   %al,%al
80105a1c:	75 bf                	jne    801059dd <memcmp+0x14>
    if(*s1 != *s2)
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
80105a1e:	b8 00 00 00 00       	mov    $0x0,%eax
}
80105a23:	c9                   	leave  
80105a24:	c3                   	ret    

80105a25 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80105a25:	55                   	push   %ebp
80105a26:	89 e5                	mov    %esp,%ebp
80105a28:	83 ec 10             	sub    $0x10,%esp
  const char *s;
  char *d;

  s = src;
80105a2b:	8b 45 0c             	mov    0xc(%ebp),%eax
80105a2e:	89 45 fc             	mov    %eax,-0x4(%ebp)
  d = dst;
80105a31:	8b 45 08             	mov    0x8(%ebp),%eax
80105a34:	89 45 f8             	mov    %eax,-0x8(%ebp)
  if(s < d && s + n > d){
80105a37:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105a3a:	3b 45 f8             	cmp    -0x8(%ebp),%eax
80105a3d:	73 54                	jae    80105a93 <memmove+0x6e>
80105a3f:	8b 45 10             	mov    0x10(%ebp),%eax
80105a42:	8b 55 fc             	mov    -0x4(%ebp),%edx
80105a45:	01 d0                	add    %edx,%eax
80105a47:	3b 45 f8             	cmp    -0x8(%ebp),%eax
80105a4a:	76 47                	jbe    80105a93 <memmove+0x6e>
    s += n;
80105a4c:	8b 45 10             	mov    0x10(%ebp),%eax
80105a4f:	01 45 fc             	add    %eax,-0x4(%ebp)
    d += n;
80105a52:	8b 45 10             	mov    0x10(%ebp),%eax
80105a55:	01 45 f8             	add    %eax,-0x8(%ebp)
    while(n-- > 0)
80105a58:	eb 13                	jmp    80105a6d <memmove+0x48>
      *--d = *--s;
80105a5a:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
80105a5e:	83 6d fc 01          	subl   $0x1,-0x4(%ebp)
80105a62:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105a65:	0f b6 10             	movzbl (%eax),%edx
80105a68:	8b 45 f8             	mov    -0x8(%ebp),%eax
80105a6b:	88 10                	mov    %dl,(%eax)
  s = src;
  d = dst;
  if(s < d && s + n > d){
    s += n;
    d += n;
    while(n-- > 0)
80105a6d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80105a71:	0f 95 c0             	setne  %al
80105a74:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
80105a78:	84 c0                	test   %al,%al
80105a7a:	75 de                	jne    80105a5a <memmove+0x35>
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
80105a7c:	eb 25                	jmp    80105aa3 <memmove+0x7e>
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
      *d++ = *s++;
80105a7e:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105a81:	0f b6 10             	movzbl (%eax),%edx
80105a84:	8b 45 f8             	mov    -0x8(%ebp),%eax
80105a87:	88 10                	mov    %dl,(%eax)
80105a89:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
80105a8d:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
80105a91:	eb 01                	jmp    80105a94 <memmove+0x6f>
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
80105a93:	90                   	nop
80105a94:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80105a98:	0f 95 c0             	setne  %al
80105a9b:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
80105a9f:	84 c0                	test   %al,%al
80105aa1:	75 db                	jne    80105a7e <memmove+0x59>
      *d++ = *s++;

  return dst;
80105aa3:	8b 45 08             	mov    0x8(%ebp),%eax
}
80105aa6:	c9                   	leave  
80105aa7:	c3                   	ret    

80105aa8 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
80105aa8:	55                   	push   %ebp
80105aa9:	89 e5                	mov    %esp,%ebp
80105aab:	83 ec 0c             	sub    $0xc,%esp
  return memmove(dst, src, n);
80105aae:	8b 45 10             	mov    0x10(%ebp),%eax
80105ab1:	89 44 24 08          	mov    %eax,0x8(%esp)
80105ab5:	8b 45 0c             	mov    0xc(%ebp),%eax
80105ab8:	89 44 24 04          	mov    %eax,0x4(%esp)
80105abc:	8b 45 08             	mov    0x8(%ebp),%eax
80105abf:	89 04 24             	mov    %eax,(%esp)
80105ac2:	e8 5e ff ff ff       	call   80105a25 <memmove>
}
80105ac7:	c9                   	leave  
80105ac8:	c3                   	ret    

80105ac9 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
80105ac9:	55                   	push   %ebp
80105aca:	89 e5                	mov    %esp,%ebp
  while(n > 0 && *p && *p == *q)
80105acc:	eb 0c                	jmp    80105ada <strncmp+0x11>
    n--, p++, q++;
80105ace:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
80105ad2:	83 45 08 01          	addl   $0x1,0x8(%ebp)
80105ad6:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint n)
{
  while(n > 0 && *p && *p == *q)
80105ada:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80105ade:	74 1a                	je     80105afa <strncmp+0x31>
80105ae0:	8b 45 08             	mov    0x8(%ebp),%eax
80105ae3:	0f b6 00             	movzbl (%eax),%eax
80105ae6:	84 c0                	test   %al,%al
80105ae8:	74 10                	je     80105afa <strncmp+0x31>
80105aea:	8b 45 08             	mov    0x8(%ebp),%eax
80105aed:	0f b6 10             	movzbl (%eax),%edx
80105af0:	8b 45 0c             	mov    0xc(%ebp),%eax
80105af3:	0f b6 00             	movzbl (%eax),%eax
80105af6:	38 c2                	cmp    %al,%dl
80105af8:	74 d4                	je     80105ace <strncmp+0x5>
    n--, p++, q++;
  if(n == 0)
80105afa:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80105afe:	75 07                	jne    80105b07 <strncmp+0x3e>
    return 0;
80105b00:	b8 00 00 00 00       	mov    $0x0,%eax
80105b05:	eb 18                	jmp    80105b1f <strncmp+0x56>
  return (uchar)*p - (uchar)*q;
80105b07:	8b 45 08             	mov    0x8(%ebp),%eax
80105b0a:	0f b6 00             	movzbl (%eax),%eax
80105b0d:	0f b6 d0             	movzbl %al,%edx
80105b10:	8b 45 0c             	mov    0xc(%ebp),%eax
80105b13:	0f b6 00             	movzbl (%eax),%eax
80105b16:	0f b6 c0             	movzbl %al,%eax
80105b19:	89 d1                	mov    %edx,%ecx
80105b1b:	29 c1                	sub    %eax,%ecx
80105b1d:	89 c8                	mov    %ecx,%eax
}
80105b1f:	5d                   	pop    %ebp
80105b20:	c3                   	ret    

80105b21 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
80105b21:	55                   	push   %ebp
80105b22:	89 e5                	mov    %esp,%ebp
80105b24:	83 ec 10             	sub    $0x10,%esp
  char *os;
  
  os = s;
80105b27:	8b 45 08             	mov    0x8(%ebp),%eax
80105b2a:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while(n-- > 0 && (*s++ = *t++) != 0)
80105b2d:	90                   	nop
80105b2e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80105b32:	0f 9f c0             	setg   %al
80105b35:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
80105b39:	84 c0                	test   %al,%al
80105b3b:	74 30                	je     80105b6d <strncpy+0x4c>
80105b3d:	8b 45 0c             	mov    0xc(%ebp),%eax
80105b40:	0f b6 10             	movzbl (%eax),%edx
80105b43:	8b 45 08             	mov    0x8(%ebp),%eax
80105b46:	88 10                	mov    %dl,(%eax)
80105b48:	8b 45 08             	mov    0x8(%ebp),%eax
80105b4b:	0f b6 00             	movzbl (%eax),%eax
80105b4e:	84 c0                	test   %al,%al
80105b50:	0f 95 c0             	setne  %al
80105b53:	83 45 08 01          	addl   $0x1,0x8(%ebp)
80105b57:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
80105b5b:	84 c0                	test   %al,%al
80105b5d:	75 cf                	jne    80105b2e <strncpy+0xd>
    ;
  while(n-- > 0)
80105b5f:	eb 0c                	jmp    80105b6d <strncpy+0x4c>
    *s++ = 0;
80105b61:	8b 45 08             	mov    0x8(%ebp),%eax
80105b64:	c6 00 00             	movb   $0x0,(%eax)
80105b67:	83 45 08 01          	addl   $0x1,0x8(%ebp)
80105b6b:	eb 01                	jmp    80105b6e <strncpy+0x4d>
  char *os;
  
  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
    ;
  while(n-- > 0)
80105b6d:	90                   	nop
80105b6e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80105b72:	0f 9f c0             	setg   %al
80105b75:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
80105b79:	84 c0                	test   %al,%al
80105b7b:	75 e4                	jne    80105b61 <strncpy+0x40>
    *s++ = 0;
  return os;
80105b7d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80105b80:	c9                   	leave  
80105b81:	c3                   	ret    

80105b82 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80105b82:	55                   	push   %ebp
80105b83:	89 e5                	mov    %esp,%ebp
80105b85:	83 ec 10             	sub    $0x10,%esp
  char *os;
  
  os = s;
80105b88:	8b 45 08             	mov    0x8(%ebp),%eax
80105b8b:	89 45 fc             	mov    %eax,-0x4(%ebp)
  if(n <= 0)
80105b8e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80105b92:	7f 05                	jg     80105b99 <safestrcpy+0x17>
    return os;
80105b94:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105b97:	eb 35                	jmp    80105bce <safestrcpy+0x4c>
  while(--n > 0 && (*s++ = *t++) != 0)
80105b99:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
80105b9d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80105ba1:	7e 22                	jle    80105bc5 <safestrcpy+0x43>
80105ba3:	8b 45 0c             	mov    0xc(%ebp),%eax
80105ba6:	0f b6 10             	movzbl (%eax),%edx
80105ba9:	8b 45 08             	mov    0x8(%ebp),%eax
80105bac:	88 10                	mov    %dl,(%eax)
80105bae:	8b 45 08             	mov    0x8(%ebp),%eax
80105bb1:	0f b6 00             	movzbl (%eax),%eax
80105bb4:	84 c0                	test   %al,%al
80105bb6:	0f 95 c0             	setne  %al
80105bb9:	83 45 08 01          	addl   $0x1,0x8(%ebp)
80105bbd:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
80105bc1:	84 c0                	test   %al,%al
80105bc3:	75 d4                	jne    80105b99 <safestrcpy+0x17>
    ;
  *s = 0;
80105bc5:	8b 45 08             	mov    0x8(%ebp),%eax
80105bc8:	c6 00 00             	movb   $0x0,(%eax)
  return os;
80105bcb:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80105bce:	c9                   	leave  
80105bcf:	c3                   	ret    

80105bd0 <strlen>:

int
strlen(const char *s)
{
80105bd0:	55                   	push   %ebp
80105bd1:	89 e5                	mov    %esp,%ebp
80105bd3:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
80105bd6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
80105bdd:	eb 04                	jmp    80105be3 <strlen+0x13>
80105bdf:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
80105be3:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105be6:	03 45 08             	add    0x8(%ebp),%eax
80105be9:	0f b6 00             	movzbl (%eax),%eax
80105bec:	84 c0                	test   %al,%al
80105bee:	75 ef                	jne    80105bdf <strlen+0xf>
    ;
  return n;
80105bf0:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80105bf3:	c9                   	leave  
80105bf4:	c3                   	ret    

80105bf5 <newstrcat>:

char* 
newstrcat(char *target, char* str1, char *str2)
{
80105bf5:	55                   	push   %ebp
80105bf6:	89 e5                	mov    %esp,%ebp
80105bf8:	83 ec 1c             	sub    $0x1c,%esp
  char *last;
  strncpy(target,str1,strlen(str1));
80105bfb:	8b 45 0c             	mov    0xc(%ebp),%eax
80105bfe:	89 04 24             	mov    %eax,(%esp)
80105c01:	e8 ca ff ff ff       	call   80105bd0 <strlen>
80105c06:	89 44 24 08          	mov    %eax,0x8(%esp)
80105c0a:	8b 45 0c             	mov    0xc(%ebp),%eax
80105c0d:	89 44 24 04          	mov    %eax,0x4(%esp)
80105c11:	8b 45 08             	mov    0x8(%ebp),%eax
80105c14:	89 04 24             	mov    %eax,(%esp)
80105c17:	e8 05 ff ff ff       	call   80105b21 <strncpy>
  last=target+strlen(str1);
80105c1c:	8b 45 0c             	mov    0xc(%ebp),%eax
80105c1f:	89 04 24             	mov    %eax,(%esp)
80105c22:	e8 a9 ff ff ff       	call   80105bd0 <strlen>
80105c27:	03 45 08             	add    0x8(%ebp),%eax
80105c2a:	89 45 fc             	mov    %eax,-0x4(%ebp)
  safestrcpy(last,str2,strlen(str2)+1);
80105c2d:	8b 45 10             	mov    0x10(%ebp),%eax
80105c30:	89 04 24             	mov    %eax,(%esp)
80105c33:	e8 98 ff ff ff       	call   80105bd0 <strlen>
80105c38:	83 c0 01             	add    $0x1,%eax
80105c3b:	89 44 24 08          	mov    %eax,0x8(%esp)
80105c3f:	8b 45 10             	mov    0x10(%ebp),%eax
80105c42:	89 44 24 04          	mov    %eax,0x4(%esp)
80105c46:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105c49:	89 04 24             	mov    %eax,(%esp)
80105c4c:	e8 31 ff ff ff       	call   80105b82 <safestrcpy>
  return target;
80105c51:	8b 45 08             	mov    0x8(%ebp),%eax
}
80105c54:	c9                   	leave  
80105c55:	c3                   	ret    
	...

80105c58 <swtch>:
# Save current register context in old
# and then load register context from new.

.globl swtch
swtch:
  movl 4(%esp), %eax
80105c58:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
80105c5c:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-save registers
  pushl %ebp
80105c60:	55                   	push   %ebp
  pushl %ebx
80105c61:	53                   	push   %ebx
  pushl %esi
80105c62:	56                   	push   %esi
  pushl %edi
80105c63:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
80105c64:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
80105c66:	89 d4                	mov    %edx,%esp

  # Load new callee-save registers
  popl %edi
80105c68:	5f                   	pop    %edi
  popl %esi
80105c69:	5e                   	pop    %esi
  popl %ebx
80105c6a:	5b                   	pop    %ebx
  popl %ebp
80105c6b:	5d                   	pop    %ebp
  ret
80105c6c:	c3                   	ret    
80105c6d:	00 00                	add    %al,(%eax)
	...

80105c70 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from process p.
int
fetchint(struct proc *p, uint addr, int *ip)
{
80105c70:	55                   	push   %ebp
80105c71:	89 e5                	mov    %esp,%ebp
  if(addr >= p->sz || addr+4 > p->sz)
80105c73:	8b 45 08             	mov    0x8(%ebp),%eax
80105c76:	8b 00                	mov    (%eax),%eax
80105c78:	3b 45 0c             	cmp    0xc(%ebp),%eax
80105c7b:	76 0f                	jbe    80105c8c <fetchint+0x1c>
80105c7d:	8b 45 0c             	mov    0xc(%ebp),%eax
80105c80:	8d 50 04             	lea    0x4(%eax),%edx
80105c83:	8b 45 08             	mov    0x8(%ebp),%eax
80105c86:	8b 00                	mov    (%eax),%eax
80105c88:	39 c2                	cmp    %eax,%edx
80105c8a:	76 07                	jbe    80105c93 <fetchint+0x23>
    return -1;
80105c8c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105c91:	eb 0f                	jmp    80105ca2 <fetchint+0x32>
  *ip = *(int*)(addr);
80105c93:	8b 45 0c             	mov    0xc(%ebp),%eax
80105c96:	8b 10                	mov    (%eax),%edx
80105c98:	8b 45 10             	mov    0x10(%ebp),%eax
80105c9b:	89 10                	mov    %edx,(%eax)
  return 0;
80105c9d:	b8 00 00 00 00       	mov    $0x0,%eax
}
80105ca2:	5d                   	pop    %ebp
80105ca3:	c3                   	ret    

80105ca4 <fetchstr>:
// Fetch the nul-terminated string at addr from process p.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(struct proc *p, uint addr, char **pp)
{
80105ca4:	55                   	push   %ebp
80105ca5:	89 e5                	mov    %esp,%ebp
80105ca7:	83 ec 10             	sub    $0x10,%esp
  char *s, *ep;

  if(addr >= p->sz)
80105caa:	8b 45 08             	mov    0x8(%ebp),%eax
80105cad:	8b 00                	mov    (%eax),%eax
80105caf:	3b 45 0c             	cmp    0xc(%ebp),%eax
80105cb2:	77 07                	ja     80105cbb <fetchstr+0x17>
    return -1;
80105cb4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105cb9:	eb 45                	jmp    80105d00 <fetchstr+0x5c>
  *pp = (char*)addr;
80105cbb:	8b 55 0c             	mov    0xc(%ebp),%edx
80105cbe:	8b 45 10             	mov    0x10(%ebp),%eax
80105cc1:	89 10                	mov    %edx,(%eax)
  ep = (char*)p->sz;
80105cc3:	8b 45 08             	mov    0x8(%ebp),%eax
80105cc6:	8b 00                	mov    (%eax),%eax
80105cc8:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(s = *pp; s < ep; s++)
80105ccb:	8b 45 10             	mov    0x10(%ebp),%eax
80105cce:	8b 00                	mov    (%eax),%eax
80105cd0:	89 45 fc             	mov    %eax,-0x4(%ebp)
80105cd3:	eb 1e                	jmp    80105cf3 <fetchstr+0x4f>
    if(*s == 0)
80105cd5:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105cd8:	0f b6 00             	movzbl (%eax),%eax
80105cdb:	84 c0                	test   %al,%al
80105cdd:	75 10                	jne    80105cef <fetchstr+0x4b>
      return s - *pp;
80105cdf:	8b 55 fc             	mov    -0x4(%ebp),%edx
80105ce2:	8b 45 10             	mov    0x10(%ebp),%eax
80105ce5:	8b 00                	mov    (%eax),%eax
80105ce7:	89 d1                	mov    %edx,%ecx
80105ce9:	29 c1                	sub    %eax,%ecx
80105ceb:	89 c8                	mov    %ecx,%eax
80105ced:	eb 11                	jmp    80105d00 <fetchstr+0x5c>

  if(addr >= p->sz)
    return -1;
  *pp = (char*)addr;
  ep = (char*)p->sz;
  for(s = *pp; s < ep; s++)
80105cef:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
80105cf3:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105cf6:	3b 45 f8             	cmp    -0x8(%ebp),%eax
80105cf9:	72 da                	jb     80105cd5 <fetchstr+0x31>
    if(*s == 0)
      return s - *pp;
  return -1;
80105cfb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105d00:	c9                   	leave  
80105d01:	c3                   	ret    

80105d02 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80105d02:	55                   	push   %ebp
80105d03:	89 e5                	mov    %esp,%ebp
80105d05:	83 ec 0c             	sub    $0xc,%esp
  return fetchint(proc, proc->tf->esp + 4 + 4*n, ip);
80105d08:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105d0e:	8b 40 18             	mov    0x18(%eax),%eax
80105d11:	8b 50 44             	mov    0x44(%eax),%edx
80105d14:	8b 45 08             	mov    0x8(%ebp),%eax
80105d17:	c1 e0 02             	shl    $0x2,%eax
80105d1a:	01 d0                	add    %edx,%eax
80105d1c:	8d 48 04             	lea    0x4(%eax),%ecx
80105d1f:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105d25:	8b 55 0c             	mov    0xc(%ebp),%edx
80105d28:	89 54 24 08          	mov    %edx,0x8(%esp)
80105d2c:	89 4c 24 04          	mov    %ecx,0x4(%esp)
80105d30:	89 04 24             	mov    %eax,(%esp)
80105d33:	e8 38 ff ff ff       	call   80105c70 <fetchint>
}
80105d38:	c9                   	leave  
80105d39:	c3                   	ret    

80105d3a <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size n bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80105d3a:	55                   	push   %ebp
80105d3b:	89 e5                	mov    %esp,%ebp
80105d3d:	83 ec 18             	sub    $0x18,%esp
  int i;
  
  if(argint(n, &i) < 0)
80105d40:	8d 45 fc             	lea    -0x4(%ebp),%eax
80105d43:	89 44 24 04          	mov    %eax,0x4(%esp)
80105d47:	8b 45 08             	mov    0x8(%ebp),%eax
80105d4a:	89 04 24             	mov    %eax,(%esp)
80105d4d:	e8 b0 ff ff ff       	call   80105d02 <argint>
80105d52:	85 c0                	test   %eax,%eax
80105d54:	79 07                	jns    80105d5d <argptr+0x23>
    return -1;
80105d56:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105d5b:	eb 3d                	jmp    80105d9a <argptr+0x60>
  if((uint)i >= proc->sz || (uint)i+size > proc->sz)
80105d5d:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105d60:	89 c2                	mov    %eax,%edx
80105d62:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105d68:	8b 00                	mov    (%eax),%eax
80105d6a:	39 c2                	cmp    %eax,%edx
80105d6c:	73 16                	jae    80105d84 <argptr+0x4a>
80105d6e:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105d71:	89 c2                	mov    %eax,%edx
80105d73:	8b 45 10             	mov    0x10(%ebp),%eax
80105d76:	01 c2                	add    %eax,%edx
80105d78:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105d7e:	8b 00                	mov    (%eax),%eax
80105d80:	39 c2                	cmp    %eax,%edx
80105d82:	76 07                	jbe    80105d8b <argptr+0x51>
    return -1;
80105d84:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105d89:	eb 0f                	jmp    80105d9a <argptr+0x60>
  *pp = (char*)i;
80105d8b:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105d8e:	89 c2                	mov    %eax,%edx
80105d90:	8b 45 0c             	mov    0xc(%ebp),%eax
80105d93:	89 10                	mov    %edx,(%eax)
  return 0;
80105d95:	b8 00 00 00 00       	mov    $0x0,%eax
}
80105d9a:	c9                   	leave  
80105d9b:	c3                   	ret    

80105d9c <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80105d9c:	55                   	push   %ebp
80105d9d:	89 e5                	mov    %esp,%ebp
80105d9f:	83 ec 1c             	sub    $0x1c,%esp
  int addr;
  if(argint(n, &addr) < 0)
80105da2:	8d 45 fc             	lea    -0x4(%ebp),%eax
80105da5:	89 44 24 04          	mov    %eax,0x4(%esp)
80105da9:	8b 45 08             	mov    0x8(%ebp),%eax
80105dac:	89 04 24             	mov    %eax,(%esp)
80105daf:	e8 4e ff ff ff       	call   80105d02 <argint>
80105db4:	85 c0                	test   %eax,%eax
80105db6:	79 07                	jns    80105dbf <argstr+0x23>
    return -1;
80105db8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105dbd:	eb 1e                	jmp    80105ddd <argstr+0x41>
  return fetchstr(proc, addr, pp);
80105dbf:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105dc2:	89 c2                	mov    %eax,%edx
80105dc4:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105dca:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80105dcd:	89 4c 24 08          	mov    %ecx,0x8(%esp)
80105dd1:	89 54 24 04          	mov    %edx,0x4(%esp)
80105dd5:	89 04 24             	mov    %eax,(%esp)
80105dd8:	e8 c7 fe ff ff       	call   80105ca4 <fetchstr>
}
80105ddd:	c9                   	leave  
80105dde:	c3                   	ret    

80105ddf <syscall>:
[SYS_getqueue]  sys_getqueue
};

void
syscall(void)
{
80105ddf:	55                   	push   %ebp
80105de0:	89 e5                	mov    %esp,%ebp
80105de2:	53                   	push   %ebx
80105de3:	83 ec 24             	sub    $0x24,%esp
  int num;

  num = proc->tf->eax;
80105de6:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105dec:	8b 40 18             	mov    0x18(%eax),%eax
80105def:	8b 40 1c             	mov    0x1c(%eax),%eax
80105df2:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(num >= 0 && num < SYS_open && syscalls[num]) {
80105df5:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105df9:	78 2e                	js     80105e29 <syscall+0x4a>
80105dfb:	83 7d f4 0e          	cmpl   $0xe,-0xc(%ebp)
80105dff:	7f 28                	jg     80105e29 <syscall+0x4a>
80105e01:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105e04:	8b 04 85 40 c3 10 80 	mov    -0x7fef3cc0(,%eax,4),%eax
80105e0b:	85 c0                	test   %eax,%eax
80105e0d:	74 1a                	je     80105e29 <syscall+0x4a>
    proc->tf->eax = syscalls[num]();
80105e0f:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105e15:	8b 58 18             	mov    0x18(%eax),%ebx
80105e18:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105e1b:	8b 04 85 40 c3 10 80 	mov    -0x7fef3cc0(,%eax,4),%eax
80105e22:	ff d0                	call   *%eax
80105e24:	89 43 1c             	mov    %eax,0x1c(%ebx)
80105e27:	eb 73                	jmp    80105e9c <syscall+0xbd>
  } else if (num >= SYS_open && num < NELEM(syscalls) && syscalls[num]) {
80105e29:	83 7d f4 0e          	cmpl   $0xe,-0xc(%ebp)
80105e2d:	7e 30                	jle    80105e5f <syscall+0x80>
80105e2f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105e32:	83 f8 19             	cmp    $0x19,%eax
80105e35:	77 28                	ja     80105e5f <syscall+0x80>
80105e37:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105e3a:	8b 04 85 40 c3 10 80 	mov    -0x7fef3cc0(,%eax,4),%eax
80105e41:	85 c0                	test   %eax,%eax
80105e43:	74 1a                	je     80105e5f <syscall+0x80>
    proc->tf->eax = syscalls[num]();
80105e45:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105e4b:	8b 58 18             	mov    0x18(%eax),%ebx
80105e4e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105e51:	8b 04 85 40 c3 10 80 	mov    -0x7fef3cc0(,%eax,4),%eax
80105e58:	ff d0                	call   *%eax
80105e5a:	89 43 1c             	mov    %eax,0x1c(%ebx)
80105e5d:	eb 3d                	jmp    80105e9c <syscall+0xbd>
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            proc->pid, proc->name, num);
80105e5f:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105e65:	8d 48 6c             	lea    0x6c(%eax),%ecx
80105e68:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  if(num >= 0 && num < SYS_open && syscalls[num]) {
    proc->tf->eax = syscalls[num]();
  } else if (num >= SYS_open && num < NELEM(syscalls) && syscalls[num]) {
    proc->tf->eax = syscalls[num]();
  } else {
    cprintf("%d %s: unknown sys call %d\n",
80105e6e:	8b 40 10             	mov    0x10(%eax),%eax
80105e71:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105e74:	89 54 24 0c          	mov    %edx,0xc(%esp)
80105e78:	89 4c 24 08          	mov    %ecx,0x8(%esp)
80105e7c:	89 44 24 04          	mov    %eax,0x4(%esp)
80105e80:	c7 04 24 d2 92 10 80 	movl   $0x801092d2,(%esp)
80105e87:	e8 15 a5 ff ff       	call   801003a1 <cprintf>
            proc->pid, proc->name, num);
    proc->tf->eax = -1;
80105e8c:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105e92:	8b 40 18             	mov    0x18(%eax),%eax
80105e95:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
  }
}
80105e9c:	83 c4 24             	add    $0x24,%esp
80105e9f:	5b                   	pop    %ebx
80105ea0:	5d                   	pop    %ebp
80105ea1:	c3                   	ret    
	...

80105ea4 <argfd>:

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
{
80105ea4:	55                   	push   %ebp
80105ea5:	89 e5                	mov    %esp,%ebp
80105ea7:	83 ec 28             	sub    $0x28,%esp
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
80105eaa:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105ead:	89 44 24 04          	mov    %eax,0x4(%esp)
80105eb1:	8b 45 08             	mov    0x8(%ebp),%eax
80105eb4:	89 04 24             	mov    %eax,(%esp)
80105eb7:	e8 46 fe ff ff       	call   80105d02 <argint>
80105ebc:	85 c0                	test   %eax,%eax
80105ebe:	79 07                	jns    80105ec7 <argfd+0x23>
    return -1;
80105ec0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105ec5:	eb 50                	jmp    80105f17 <argfd+0x73>
  if(fd < 0 || fd >= NOFILE || (f=proc->ofile[fd]) == 0)
80105ec7:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105eca:	85 c0                	test   %eax,%eax
80105ecc:	78 21                	js     80105eef <argfd+0x4b>
80105ece:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105ed1:	83 f8 0f             	cmp    $0xf,%eax
80105ed4:	7f 19                	jg     80105eef <argfd+0x4b>
80105ed6:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105edc:	8b 55 f0             	mov    -0x10(%ebp),%edx
80105edf:	83 c2 08             	add    $0x8,%edx
80105ee2:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
80105ee6:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105ee9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105eed:	75 07                	jne    80105ef6 <argfd+0x52>
    return -1;
80105eef:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105ef4:	eb 21                	jmp    80105f17 <argfd+0x73>
  if(pfd)
80105ef6:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
80105efa:	74 08                	je     80105f04 <argfd+0x60>
    *pfd = fd;
80105efc:	8b 55 f0             	mov    -0x10(%ebp),%edx
80105eff:	8b 45 0c             	mov    0xc(%ebp),%eax
80105f02:	89 10                	mov    %edx,(%eax)
  if(pf)
80105f04:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80105f08:	74 08                	je     80105f12 <argfd+0x6e>
    *pf = f;
80105f0a:	8b 45 10             	mov    0x10(%ebp),%eax
80105f0d:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105f10:	89 10                	mov    %edx,(%eax)
  return 0;
80105f12:	b8 00 00 00 00       	mov    $0x0,%eax
}
80105f17:	c9                   	leave  
80105f18:	c3                   	ret    

80105f19 <fdalloc>:

// Allocate a file descriptor for the given file.
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
80105f19:	55                   	push   %ebp
80105f1a:	89 e5                	mov    %esp,%ebp
80105f1c:	83 ec 10             	sub    $0x10,%esp
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
80105f1f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
80105f26:	eb 30                	jmp    80105f58 <fdalloc+0x3f>
    if(proc->ofile[fd] == 0){
80105f28:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105f2e:	8b 55 fc             	mov    -0x4(%ebp),%edx
80105f31:	83 c2 08             	add    $0x8,%edx
80105f34:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
80105f38:	85 c0                	test   %eax,%eax
80105f3a:	75 18                	jne    80105f54 <fdalloc+0x3b>
      proc->ofile[fd] = f;
80105f3c:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105f42:	8b 55 fc             	mov    -0x4(%ebp),%edx
80105f45:	8d 4a 08             	lea    0x8(%edx),%ecx
80105f48:	8b 55 08             	mov    0x8(%ebp),%edx
80105f4b:	89 54 88 08          	mov    %edx,0x8(%eax,%ecx,4)
      return fd;
80105f4f:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105f52:	eb 0f                	jmp    80105f63 <fdalloc+0x4a>
static int
fdalloc(struct file *f)
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
80105f54:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
80105f58:	83 7d fc 0f          	cmpl   $0xf,-0x4(%ebp)
80105f5c:	7e ca                	jle    80105f28 <fdalloc+0xf>
    if(proc->ofile[fd] == 0){
      proc->ofile[fd] = f;
      return fd;
    }
  }
  return -1;
80105f5e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105f63:	c9                   	leave  
80105f64:	c3                   	ret    

80105f65 <sys_dup>:

int
sys_dup(void)
{
80105f65:	55                   	push   %ebp
80105f66:	89 e5                	mov    %esp,%ebp
80105f68:	83 ec 28             	sub    $0x28,%esp
  struct file *f;
  int fd;
  
  if(argfd(0, 0, &f) < 0)
80105f6b:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105f6e:	89 44 24 08          	mov    %eax,0x8(%esp)
80105f72:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80105f79:	00 
80105f7a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105f81:	e8 1e ff ff ff       	call   80105ea4 <argfd>
80105f86:	85 c0                	test   %eax,%eax
80105f88:	79 07                	jns    80105f91 <sys_dup+0x2c>
    return -1;
80105f8a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105f8f:	eb 29                	jmp    80105fba <sys_dup+0x55>
  if((fd=fdalloc(f)) < 0)
80105f91:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105f94:	89 04 24             	mov    %eax,(%esp)
80105f97:	e8 7d ff ff ff       	call   80105f19 <fdalloc>
80105f9c:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105f9f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105fa3:	79 07                	jns    80105fac <sys_dup+0x47>
    return -1;
80105fa5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105faa:	eb 0e                	jmp    80105fba <sys_dup+0x55>
  filedup(f);
80105fac:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105faf:	89 04 24             	mov    %eax,(%esp)
80105fb2:	e8 bd b4 ff ff       	call   80101474 <filedup>
  return fd;
80105fb7:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80105fba:	c9                   	leave  
80105fbb:	c3                   	ret    

80105fbc <sys_read>:

int
sys_read(void)
{
80105fbc:	55                   	push   %ebp
80105fbd:	89 e5                	mov    %esp,%ebp
80105fbf:	83 ec 28             	sub    $0x28,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105fc2:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105fc5:	89 44 24 08          	mov    %eax,0x8(%esp)
80105fc9:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80105fd0:	00 
80105fd1:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105fd8:	e8 c7 fe ff ff       	call   80105ea4 <argfd>
80105fdd:	85 c0                	test   %eax,%eax
80105fdf:	78 35                	js     80106016 <sys_read+0x5a>
80105fe1:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105fe4:	89 44 24 04          	mov    %eax,0x4(%esp)
80105fe8:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
80105fef:	e8 0e fd ff ff       	call   80105d02 <argint>
80105ff4:	85 c0                	test   %eax,%eax
80105ff6:	78 1e                	js     80106016 <sys_read+0x5a>
80105ff8:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105ffb:	89 44 24 08          	mov    %eax,0x8(%esp)
80105fff:	8d 45 ec             	lea    -0x14(%ebp),%eax
80106002:	89 44 24 04          	mov    %eax,0x4(%esp)
80106006:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
8010600d:	e8 28 fd ff ff       	call   80105d3a <argptr>
80106012:	85 c0                	test   %eax,%eax
80106014:	79 07                	jns    8010601d <sys_read+0x61>
    return -1;
80106016:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010601b:	eb 19                	jmp    80106036 <sys_read+0x7a>
  return fileread(f, p, n);
8010601d:	8b 4d f0             	mov    -0x10(%ebp),%ecx
80106020:	8b 55 ec             	mov    -0x14(%ebp),%edx
80106023:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106026:	89 4c 24 08          	mov    %ecx,0x8(%esp)
8010602a:	89 54 24 04          	mov    %edx,0x4(%esp)
8010602e:	89 04 24             	mov    %eax,(%esp)
80106031:	e8 ab b5 ff ff       	call   801015e1 <fileread>
}
80106036:	c9                   	leave  
80106037:	c3                   	ret    

80106038 <sys_write>:

int
sys_write(void)
{
80106038:	55                   	push   %ebp
80106039:	89 e5                	mov    %esp,%ebp
8010603b:	83 ec 28             	sub    $0x28,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
8010603e:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106041:	89 44 24 08          	mov    %eax,0x8(%esp)
80106045:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
8010604c:	00 
8010604d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106054:	e8 4b fe ff ff       	call   80105ea4 <argfd>
80106059:	85 c0                	test   %eax,%eax
8010605b:	78 35                	js     80106092 <sys_write+0x5a>
8010605d:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106060:	89 44 24 04          	mov    %eax,0x4(%esp)
80106064:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
8010606b:	e8 92 fc ff ff       	call   80105d02 <argint>
80106070:	85 c0                	test   %eax,%eax
80106072:	78 1e                	js     80106092 <sys_write+0x5a>
80106074:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106077:	89 44 24 08          	mov    %eax,0x8(%esp)
8010607b:	8d 45 ec             	lea    -0x14(%ebp),%eax
8010607e:	89 44 24 04          	mov    %eax,0x4(%esp)
80106082:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80106089:	e8 ac fc ff ff       	call   80105d3a <argptr>
8010608e:	85 c0                	test   %eax,%eax
80106090:	79 07                	jns    80106099 <sys_write+0x61>
    return -1;
80106092:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106097:	eb 19                	jmp    801060b2 <sys_write+0x7a>
  return filewrite(f, p, n);
80106099:	8b 4d f0             	mov    -0x10(%ebp),%ecx
8010609c:	8b 55 ec             	mov    -0x14(%ebp),%edx
8010609f:	8b 45 f4             	mov    -0xc(%ebp),%eax
801060a2:	89 4c 24 08          	mov    %ecx,0x8(%esp)
801060a6:	89 54 24 04          	mov    %edx,0x4(%esp)
801060aa:	89 04 24             	mov    %eax,(%esp)
801060ad:	e8 eb b5 ff ff       	call   8010169d <filewrite>
}
801060b2:	c9                   	leave  
801060b3:	c3                   	ret    

801060b4 <sys_close>:

int
sys_close(void)
{
801060b4:	55                   	push   %ebp
801060b5:	89 e5                	mov    %esp,%ebp
801060b7:	83 ec 28             	sub    $0x28,%esp
  int fd;
  struct file *f;
  
  if(argfd(0, &fd, &f) < 0)
801060ba:	8d 45 f0             	lea    -0x10(%ebp),%eax
801060bd:	89 44 24 08          	mov    %eax,0x8(%esp)
801060c1:	8d 45 f4             	lea    -0xc(%ebp),%eax
801060c4:	89 44 24 04          	mov    %eax,0x4(%esp)
801060c8:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801060cf:	e8 d0 fd ff ff       	call   80105ea4 <argfd>
801060d4:	85 c0                	test   %eax,%eax
801060d6:	79 07                	jns    801060df <sys_close+0x2b>
    return -1;
801060d8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801060dd:	eb 24                	jmp    80106103 <sys_close+0x4f>
  proc->ofile[fd] = 0;
801060df:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801060e5:	8b 55 f4             	mov    -0xc(%ebp),%edx
801060e8:	83 c2 08             	add    $0x8,%edx
801060eb:	c7 44 90 08 00 00 00 	movl   $0x0,0x8(%eax,%edx,4)
801060f2:	00 
  fileclose(f);
801060f3:	8b 45 f0             	mov    -0x10(%ebp),%eax
801060f6:	89 04 24             	mov    %eax,(%esp)
801060f9:	e8 be b3 ff ff       	call   801014bc <fileclose>
  return 0;
801060fe:	b8 00 00 00 00       	mov    $0x0,%eax
}
80106103:	c9                   	leave  
80106104:	c3                   	ret    

80106105 <sys_fstat>:

int
sys_fstat(void)
{
80106105:	55                   	push   %ebp
80106106:	89 e5                	mov    %esp,%ebp
80106108:	83 ec 28             	sub    $0x28,%esp
  struct file *f;
  struct stat *st;
  
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
8010610b:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010610e:	89 44 24 08          	mov    %eax,0x8(%esp)
80106112:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80106119:	00 
8010611a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106121:	e8 7e fd ff ff       	call   80105ea4 <argfd>
80106126:	85 c0                	test   %eax,%eax
80106128:	78 1f                	js     80106149 <sys_fstat+0x44>
8010612a:	c7 44 24 08 14 00 00 	movl   $0x14,0x8(%esp)
80106131:	00 
80106132:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106135:	89 44 24 04          	mov    %eax,0x4(%esp)
80106139:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80106140:	e8 f5 fb ff ff       	call   80105d3a <argptr>
80106145:	85 c0                	test   %eax,%eax
80106147:	79 07                	jns    80106150 <sys_fstat+0x4b>
    return -1;
80106149:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010614e:	eb 12                	jmp    80106162 <sys_fstat+0x5d>
  return filestat(f, st);
80106150:	8b 55 f0             	mov    -0x10(%ebp),%edx
80106153:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106156:	89 54 24 04          	mov    %edx,0x4(%esp)
8010615a:	89 04 24             	mov    %eax,(%esp)
8010615d:	e8 30 b4 ff ff       	call   80101592 <filestat>
}
80106162:	c9                   	leave  
80106163:	c3                   	ret    

80106164 <sys_link>:

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
80106164:	55                   	push   %ebp
80106165:	89 e5                	mov    %esp,%ebp
80106167:	83 ec 38             	sub    $0x38,%esp
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
8010616a:	8d 45 d8             	lea    -0x28(%ebp),%eax
8010616d:	89 44 24 04          	mov    %eax,0x4(%esp)
80106171:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106178:	e8 1f fc ff ff       	call   80105d9c <argstr>
8010617d:	85 c0                	test   %eax,%eax
8010617f:	78 17                	js     80106198 <sys_link+0x34>
80106181:	8d 45 dc             	lea    -0x24(%ebp),%eax
80106184:	89 44 24 04          	mov    %eax,0x4(%esp)
80106188:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
8010618f:	e8 08 fc ff ff       	call   80105d9c <argstr>
80106194:	85 c0                	test   %eax,%eax
80106196:	79 0a                	jns    801061a2 <sys_link+0x3e>
    return -1;
80106198:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010619d:	e9 3c 01 00 00       	jmp    801062de <sys_link+0x17a>
  if((ip = namei(old)) == 0)
801061a2:	8b 45 d8             	mov    -0x28(%ebp),%eax
801061a5:	89 04 24             	mov    %eax,(%esp)
801061a8:	e8 55 c7 ff ff       	call   80102902 <namei>
801061ad:	89 45 f4             	mov    %eax,-0xc(%ebp)
801061b0:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801061b4:	75 0a                	jne    801061c0 <sys_link+0x5c>
    return -1;
801061b6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801061bb:	e9 1e 01 00 00       	jmp    801062de <sys_link+0x17a>

  begin_trans();
801061c0:	e8 50 d5 ff ff       	call   80103715 <begin_trans>

  ilock(ip);
801061c5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801061c8:	89 04 24             	mov    %eax,(%esp)
801061cb:	e8 90 bb ff ff       	call   80101d60 <ilock>
  if(ip->type == T_DIR){
801061d0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801061d3:	0f b7 40 10          	movzwl 0x10(%eax),%eax
801061d7:	66 83 f8 01          	cmp    $0x1,%ax
801061db:	75 1a                	jne    801061f7 <sys_link+0x93>
    iunlockput(ip);
801061dd:	8b 45 f4             	mov    -0xc(%ebp),%eax
801061e0:	89 04 24             	mov    %eax,(%esp)
801061e3:	e8 fc bd ff ff       	call   80101fe4 <iunlockput>
    commit_trans();
801061e8:	e8 71 d5 ff ff       	call   8010375e <commit_trans>
    return -1;
801061ed:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801061f2:	e9 e7 00 00 00       	jmp    801062de <sys_link+0x17a>
  }

  ip->nlink++;
801061f7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801061fa:	0f b7 40 16          	movzwl 0x16(%eax),%eax
801061fe:	8d 50 01             	lea    0x1(%eax),%edx
80106201:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106204:	66 89 50 16          	mov    %dx,0x16(%eax)
  iupdate(ip);
80106208:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010620b:	89 04 24             	mov    %eax,(%esp)
8010620e:	e8 91 b9 ff ff       	call   80101ba4 <iupdate>
  iunlock(ip);
80106213:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106216:	89 04 24             	mov    %eax,(%esp)
80106219:	e8 90 bc ff ff       	call   80101eae <iunlock>

  if((dp = nameiparent(new, name)) == 0)
8010621e:	8b 45 dc             	mov    -0x24(%ebp),%eax
80106221:	8d 55 e2             	lea    -0x1e(%ebp),%edx
80106224:	89 54 24 04          	mov    %edx,0x4(%esp)
80106228:	89 04 24             	mov    %eax,(%esp)
8010622b:	e8 f4 c6 ff ff       	call   80102924 <nameiparent>
80106230:	89 45 f0             	mov    %eax,-0x10(%ebp)
80106233:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80106237:	74 68                	je     801062a1 <sys_link+0x13d>
    goto bad;
  ilock(dp);
80106239:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010623c:	89 04 24             	mov    %eax,(%esp)
8010623f:	e8 1c bb ff ff       	call   80101d60 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80106244:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106247:	8b 10                	mov    (%eax),%edx
80106249:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010624c:	8b 00                	mov    (%eax),%eax
8010624e:	39 c2                	cmp    %eax,%edx
80106250:	75 20                	jne    80106272 <sys_link+0x10e>
80106252:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106255:	8b 40 04             	mov    0x4(%eax),%eax
80106258:	89 44 24 08          	mov    %eax,0x8(%esp)
8010625c:	8d 45 e2             	lea    -0x1e(%ebp),%eax
8010625f:	89 44 24 04          	mov    %eax,0x4(%esp)
80106263:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106266:	89 04 24             	mov    %eax,(%esp)
80106269:	e8 d3 c3 ff ff       	call   80102641 <dirlink>
8010626e:	85 c0                	test   %eax,%eax
80106270:	79 0d                	jns    8010627f <sys_link+0x11b>
    iunlockput(dp);
80106272:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106275:	89 04 24             	mov    %eax,(%esp)
80106278:	e8 67 bd ff ff       	call   80101fe4 <iunlockput>
    goto bad;
8010627d:	eb 23                	jmp    801062a2 <sys_link+0x13e>
  }
  iunlockput(dp);
8010627f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106282:	89 04 24             	mov    %eax,(%esp)
80106285:	e8 5a bd ff ff       	call   80101fe4 <iunlockput>
  iput(ip);
8010628a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010628d:	89 04 24             	mov    %eax,(%esp)
80106290:	e8 7e bc ff ff       	call   80101f13 <iput>

  commit_trans();
80106295:	e8 c4 d4 ff ff       	call   8010375e <commit_trans>

  return 0;
8010629a:	b8 00 00 00 00       	mov    $0x0,%eax
8010629f:	eb 3d                	jmp    801062de <sys_link+0x17a>
  ip->nlink++;
  iupdate(ip);
  iunlock(ip);

  if((dp = nameiparent(new, name)) == 0)
    goto bad;
801062a1:	90                   	nop
  commit_trans();

  return 0;

bad:
  ilock(ip);
801062a2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801062a5:	89 04 24             	mov    %eax,(%esp)
801062a8:	e8 b3 ba ff ff       	call   80101d60 <ilock>
  ip->nlink--;
801062ad:	8b 45 f4             	mov    -0xc(%ebp),%eax
801062b0:	0f b7 40 16          	movzwl 0x16(%eax),%eax
801062b4:	8d 50 ff             	lea    -0x1(%eax),%edx
801062b7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801062ba:	66 89 50 16          	mov    %dx,0x16(%eax)
  iupdate(ip);
801062be:	8b 45 f4             	mov    -0xc(%ebp),%eax
801062c1:	89 04 24             	mov    %eax,(%esp)
801062c4:	e8 db b8 ff ff       	call   80101ba4 <iupdate>
  iunlockput(ip);
801062c9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801062cc:	89 04 24             	mov    %eax,(%esp)
801062cf:	e8 10 bd ff ff       	call   80101fe4 <iunlockput>
  commit_trans();
801062d4:	e8 85 d4 ff ff       	call   8010375e <commit_trans>
  return -1;
801062d9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801062de:	c9                   	leave  
801062df:	c3                   	ret    

801062e0 <isdirempty>:

// Is the directory dp empty except for "." and ".." ?
static int
isdirempty(struct inode *dp)
{
801062e0:	55                   	push   %ebp
801062e1:	89 e5                	mov    %esp,%ebp
801062e3:	83 ec 38             	sub    $0x38,%esp
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
801062e6:	c7 45 f4 20 00 00 00 	movl   $0x20,-0xc(%ebp)
801062ed:	eb 4b                	jmp    8010633a <isdirempty+0x5a>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801062ef:	8b 45 f4             	mov    -0xc(%ebp),%eax
801062f2:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
801062f9:	00 
801062fa:	89 44 24 08          	mov    %eax,0x8(%esp)
801062fe:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80106301:	89 44 24 04          	mov    %eax,0x4(%esp)
80106305:	8b 45 08             	mov    0x8(%ebp),%eax
80106308:	89 04 24             	mov    %eax,(%esp)
8010630b:	e8 46 bf ff ff       	call   80102256 <readi>
80106310:	83 f8 10             	cmp    $0x10,%eax
80106313:	74 0c                	je     80106321 <isdirempty+0x41>
      panic("isdirempty: readi");
80106315:	c7 04 24 ee 92 10 80 	movl   $0x801092ee,(%esp)
8010631c:	e8 1c a2 ff ff       	call   8010053d <panic>
    if(de.inum != 0)
80106321:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
80106325:	66 85 c0             	test   %ax,%ax
80106328:	74 07                	je     80106331 <isdirempty+0x51>
      return 0;
8010632a:	b8 00 00 00 00       	mov    $0x0,%eax
8010632f:	eb 1b                	jmp    8010634c <isdirempty+0x6c>
isdirempty(struct inode *dp)
{
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80106331:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106334:	83 c0 10             	add    $0x10,%eax
80106337:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010633a:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010633d:	8b 45 08             	mov    0x8(%ebp),%eax
80106340:	8b 40 18             	mov    0x18(%eax),%eax
80106343:	39 c2                	cmp    %eax,%edx
80106345:	72 a8                	jb     801062ef <isdirempty+0xf>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("isdirempty: readi");
    if(de.inum != 0)
      return 0;
  }
  return 1;
80106347:	b8 01 00 00 00       	mov    $0x1,%eax
}
8010634c:	c9                   	leave  
8010634d:	c3                   	ret    

8010634e <sys_unlink>:

//PAGEBREAK!
int
sys_unlink(void)
{
8010634e:	55                   	push   %ebp
8010634f:	89 e5                	mov    %esp,%ebp
80106351:	83 ec 48             	sub    $0x48,%esp
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
80106354:	8d 45 cc             	lea    -0x34(%ebp),%eax
80106357:	89 44 24 04          	mov    %eax,0x4(%esp)
8010635b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106362:	e8 35 fa ff ff       	call   80105d9c <argstr>
80106367:	85 c0                	test   %eax,%eax
80106369:	79 0a                	jns    80106375 <sys_unlink+0x27>
    return -1;
8010636b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106370:	e9 aa 01 00 00       	jmp    8010651f <sys_unlink+0x1d1>
  if((dp = nameiparent(path, name)) == 0)
80106375:	8b 45 cc             	mov    -0x34(%ebp),%eax
80106378:	8d 55 d2             	lea    -0x2e(%ebp),%edx
8010637b:	89 54 24 04          	mov    %edx,0x4(%esp)
8010637f:	89 04 24             	mov    %eax,(%esp)
80106382:	e8 9d c5 ff ff       	call   80102924 <nameiparent>
80106387:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010638a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010638e:	75 0a                	jne    8010639a <sys_unlink+0x4c>
    return -1;
80106390:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106395:	e9 85 01 00 00       	jmp    8010651f <sys_unlink+0x1d1>

  begin_trans();
8010639a:	e8 76 d3 ff ff       	call   80103715 <begin_trans>

  ilock(dp);
8010639f:	8b 45 f4             	mov    -0xc(%ebp),%eax
801063a2:	89 04 24             	mov    %eax,(%esp)
801063a5:	e8 b6 b9 ff ff       	call   80101d60 <ilock>

  // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
801063aa:	c7 44 24 04 00 93 10 	movl   $0x80109300,0x4(%esp)
801063b1:	80 
801063b2:	8d 45 d2             	lea    -0x2e(%ebp),%eax
801063b5:	89 04 24             	mov    %eax,(%esp)
801063b8:	e8 9a c1 ff ff       	call   80102557 <namecmp>
801063bd:	85 c0                	test   %eax,%eax
801063bf:	0f 84 45 01 00 00    	je     8010650a <sys_unlink+0x1bc>
801063c5:	c7 44 24 04 02 93 10 	movl   $0x80109302,0x4(%esp)
801063cc:	80 
801063cd:	8d 45 d2             	lea    -0x2e(%ebp),%eax
801063d0:	89 04 24             	mov    %eax,(%esp)
801063d3:	e8 7f c1 ff ff       	call   80102557 <namecmp>
801063d8:	85 c0                	test   %eax,%eax
801063da:	0f 84 2a 01 00 00    	je     8010650a <sys_unlink+0x1bc>
    goto bad;

  if((ip = dirlookup(dp, name, &off)) == 0)
801063e0:	8d 45 c8             	lea    -0x38(%ebp),%eax
801063e3:	89 44 24 08          	mov    %eax,0x8(%esp)
801063e7:	8d 45 d2             	lea    -0x2e(%ebp),%eax
801063ea:	89 44 24 04          	mov    %eax,0x4(%esp)
801063ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
801063f1:	89 04 24             	mov    %eax,(%esp)
801063f4:	e8 80 c1 ff ff       	call   80102579 <dirlookup>
801063f9:	89 45 f0             	mov    %eax,-0x10(%ebp)
801063fc:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80106400:	0f 84 03 01 00 00    	je     80106509 <sys_unlink+0x1bb>
    goto bad;
  ilock(ip);
80106406:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106409:	89 04 24             	mov    %eax,(%esp)
8010640c:	e8 4f b9 ff ff       	call   80101d60 <ilock>

  if(ip->nlink < 1)
80106411:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106414:	0f b7 40 16          	movzwl 0x16(%eax),%eax
80106418:	66 85 c0             	test   %ax,%ax
8010641b:	7f 0c                	jg     80106429 <sys_unlink+0xdb>
    panic("unlink: nlink < 1");
8010641d:	c7 04 24 05 93 10 80 	movl   $0x80109305,(%esp)
80106424:	e8 14 a1 ff ff       	call   8010053d <panic>
  if(ip->type == T_DIR && !isdirempty(ip)){
80106429:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010642c:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80106430:	66 83 f8 01          	cmp    $0x1,%ax
80106434:	75 1f                	jne    80106455 <sys_unlink+0x107>
80106436:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106439:	89 04 24             	mov    %eax,(%esp)
8010643c:	e8 9f fe ff ff       	call   801062e0 <isdirempty>
80106441:	85 c0                	test   %eax,%eax
80106443:	75 10                	jne    80106455 <sys_unlink+0x107>
    iunlockput(ip);
80106445:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106448:	89 04 24             	mov    %eax,(%esp)
8010644b:	e8 94 bb ff ff       	call   80101fe4 <iunlockput>
    goto bad;
80106450:	e9 b5 00 00 00       	jmp    8010650a <sys_unlink+0x1bc>
  }

  memset(&de, 0, sizeof(de));
80106455:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
8010645c:	00 
8010645d:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80106464:	00 
80106465:	8d 45 e0             	lea    -0x20(%ebp),%eax
80106468:	89 04 24             	mov    %eax,(%esp)
8010646b:	e8 e2 f4 ff ff       	call   80105952 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80106470:	8b 45 c8             	mov    -0x38(%ebp),%eax
80106473:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
8010647a:	00 
8010647b:	89 44 24 08          	mov    %eax,0x8(%esp)
8010647f:	8d 45 e0             	lea    -0x20(%ebp),%eax
80106482:	89 44 24 04          	mov    %eax,0x4(%esp)
80106486:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106489:	89 04 24             	mov    %eax,(%esp)
8010648c:	e8 30 bf ff ff       	call   801023c1 <writei>
80106491:	83 f8 10             	cmp    $0x10,%eax
80106494:	74 0c                	je     801064a2 <sys_unlink+0x154>
    panic("unlink: writei");
80106496:	c7 04 24 17 93 10 80 	movl   $0x80109317,(%esp)
8010649d:	e8 9b a0 ff ff       	call   8010053d <panic>
  if(ip->type == T_DIR){
801064a2:	8b 45 f0             	mov    -0x10(%ebp),%eax
801064a5:	0f b7 40 10          	movzwl 0x10(%eax),%eax
801064a9:	66 83 f8 01          	cmp    $0x1,%ax
801064ad:	75 1c                	jne    801064cb <sys_unlink+0x17d>
    dp->nlink--;
801064af:	8b 45 f4             	mov    -0xc(%ebp),%eax
801064b2:	0f b7 40 16          	movzwl 0x16(%eax),%eax
801064b6:	8d 50 ff             	lea    -0x1(%eax),%edx
801064b9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801064bc:	66 89 50 16          	mov    %dx,0x16(%eax)
    iupdate(dp);
801064c0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801064c3:	89 04 24             	mov    %eax,(%esp)
801064c6:	e8 d9 b6 ff ff       	call   80101ba4 <iupdate>
  }
  iunlockput(dp);
801064cb:	8b 45 f4             	mov    -0xc(%ebp),%eax
801064ce:	89 04 24             	mov    %eax,(%esp)
801064d1:	e8 0e bb ff ff       	call   80101fe4 <iunlockput>

  ip->nlink--;
801064d6:	8b 45 f0             	mov    -0x10(%ebp),%eax
801064d9:	0f b7 40 16          	movzwl 0x16(%eax),%eax
801064dd:	8d 50 ff             	lea    -0x1(%eax),%edx
801064e0:	8b 45 f0             	mov    -0x10(%ebp),%eax
801064e3:	66 89 50 16          	mov    %dx,0x16(%eax)
  iupdate(ip);
801064e7:	8b 45 f0             	mov    -0x10(%ebp),%eax
801064ea:	89 04 24             	mov    %eax,(%esp)
801064ed:	e8 b2 b6 ff ff       	call   80101ba4 <iupdate>
  iunlockput(ip);
801064f2:	8b 45 f0             	mov    -0x10(%ebp),%eax
801064f5:	89 04 24             	mov    %eax,(%esp)
801064f8:	e8 e7 ba ff ff       	call   80101fe4 <iunlockput>

  commit_trans();
801064fd:	e8 5c d2 ff ff       	call   8010375e <commit_trans>

  return 0;
80106502:	b8 00 00 00 00       	mov    $0x0,%eax
80106507:	eb 16                	jmp    8010651f <sys_unlink+0x1d1>
  // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
    goto bad;

  if((ip = dirlookup(dp, name, &off)) == 0)
    goto bad;
80106509:	90                   	nop
  commit_trans();

  return 0;

bad:
  iunlockput(dp);
8010650a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010650d:	89 04 24             	mov    %eax,(%esp)
80106510:	e8 cf ba ff ff       	call   80101fe4 <iunlockput>
  commit_trans();
80106515:	e8 44 d2 ff ff       	call   8010375e <commit_trans>
  return -1;
8010651a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010651f:	c9                   	leave  
80106520:	c3                   	ret    

80106521 <create>:

static struct inode*
create(char *path, short type, short major, short minor)
{
80106521:	55                   	push   %ebp
80106522:	89 e5                	mov    %esp,%ebp
80106524:	83 ec 48             	sub    $0x48,%esp
80106527:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010652a:	8b 55 10             	mov    0x10(%ebp),%edx
8010652d:	8b 45 14             	mov    0x14(%ebp),%eax
80106530:	66 89 4d d4          	mov    %cx,-0x2c(%ebp)
80106534:	66 89 55 d0          	mov    %dx,-0x30(%ebp)
80106538:	66 89 45 cc          	mov    %ax,-0x34(%ebp)
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
8010653c:	8d 45 de             	lea    -0x22(%ebp),%eax
8010653f:	89 44 24 04          	mov    %eax,0x4(%esp)
80106543:	8b 45 08             	mov    0x8(%ebp),%eax
80106546:	89 04 24             	mov    %eax,(%esp)
80106549:	e8 d6 c3 ff ff       	call   80102924 <nameiparent>
8010654e:	89 45 f4             	mov    %eax,-0xc(%ebp)
80106551:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80106555:	75 0a                	jne    80106561 <create+0x40>
    return 0;
80106557:	b8 00 00 00 00       	mov    $0x0,%eax
8010655c:	e9 7e 01 00 00       	jmp    801066df <create+0x1be>
  ilock(dp);
80106561:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106564:	89 04 24             	mov    %eax,(%esp)
80106567:	e8 f4 b7 ff ff       	call   80101d60 <ilock>

  if((ip = dirlookup(dp, name, &off)) != 0){
8010656c:	8d 45 ec             	lea    -0x14(%ebp),%eax
8010656f:	89 44 24 08          	mov    %eax,0x8(%esp)
80106573:	8d 45 de             	lea    -0x22(%ebp),%eax
80106576:	89 44 24 04          	mov    %eax,0x4(%esp)
8010657a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010657d:	89 04 24             	mov    %eax,(%esp)
80106580:	e8 f4 bf ff ff       	call   80102579 <dirlookup>
80106585:	89 45 f0             	mov    %eax,-0x10(%ebp)
80106588:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
8010658c:	74 47                	je     801065d5 <create+0xb4>
    iunlockput(dp);
8010658e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106591:	89 04 24             	mov    %eax,(%esp)
80106594:	e8 4b ba ff ff       	call   80101fe4 <iunlockput>
    ilock(ip);
80106599:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010659c:	89 04 24             	mov    %eax,(%esp)
8010659f:	e8 bc b7 ff ff       	call   80101d60 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
801065a4:	66 83 7d d4 02       	cmpw   $0x2,-0x2c(%ebp)
801065a9:	75 15                	jne    801065c0 <create+0x9f>
801065ab:	8b 45 f0             	mov    -0x10(%ebp),%eax
801065ae:	0f b7 40 10          	movzwl 0x10(%eax),%eax
801065b2:	66 83 f8 02          	cmp    $0x2,%ax
801065b6:	75 08                	jne    801065c0 <create+0x9f>
      return ip;
801065b8:	8b 45 f0             	mov    -0x10(%ebp),%eax
801065bb:	e9 1f 01 00 00       	jmp    801066df <create+0x1be>
    iunlockput(ip);
801065c0:	8b 45 f0             	mov    -0x10(%ebp),%eax
801065c3:	89 04 24             	mov    %eax,(%esp)
801065c6:	e8 19 ba ff ff       	call   80101fe4 <iunlockput>
    return 0;
801065cb:	b8 00 00 00 00       	mov    $0x0,%eax
801065d0:	e9 0a 01 00 00       	jmp    801066df <create+0x1be>
  }

  if((ip = ialloc(dp->dev, type)) == 0)
801065d5:	0f bf 55 d4          	movswl -0x2c(%ebp),%edx
801065d9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801065dc:	8b 00                	mov    (%eax),%eax
801065de:	89 54 24 04          	mov    %edx,0x4(%esp)
801065e2:	89 04 24             	mov    %eax,(%esp)
801065e5:	e8 dd b4 ff ff       	call   80101ac7 <ialloc>
801065ea:	89 45 f0             	mov    %eax,-0x10(%ebp)
801065ed:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801065f1:	75 0c                	jne    801065ff <create+0xde>
    panic("create: ialloc");
801065f3:	c7 04 24 26 93 10 80 	movl   $0x80109326,(%esp)
801065fa:	e8 3e 9f ff ff       	call   8010053d <panic>

  ilock(ip);
801065ff:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106602:	89 04 24             	mov    %eax,(%esp)
80106605:	e8 56 b7 ff ff       	call   80101d60 <ilock>
  ip->major = major;
8010660a:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010660d:	0f b7 55 d0          	movzwl -0x30(%ebp),%edx
80106611:	66 89 50 12          	mov    %dx,0x12(%eax)
  ip->minor = minor;
80106615:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106618:	0f b7 55 cc          	movzwl -0x34(%ebp),%edx
8010661c:	66 89 50 14          	mov    %dx,0x14(%eax)
  ip->nlink = 1;
80106620:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106623:	66 c7 40 16 01 00    	movw   $0x1,0x16(%eax)
  iupdate(ip);
80106629:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010662c:	89 04 24             	mov    %eax,(%esp)
8010662f:	e8 70 b5 ff ff       	call   80101ba4 <iupdate>

  if(type == T_DIR){  // Create . and .. entries.
80106634:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
80106639:	75 6a                	jne    801066a5 <create+0x184>
    dp->nlink++;  // for ".."
8010663b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010663e:	0f b7 40 16          	movzwl 0x16(%eax),%eax
80106642:	8d 50 01             	lea    0x1(%eax),%edx
80106645:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106648:	66 89 50 16          	mov    %dx,0x16(%eax)
    iupdate(dp);
8010664c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010664f:	89 04 24             	mov    %eax,(%esp)
80106652:	e8 4d b5 ff ff       	call   80101ba4 <iupdate>
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
80106657:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010665a:	8b 40 04             	mov    0x4(%eax),%eax
8010665d:	89 44 24 08          	mov    %eax,0x8(%esp)
80106661:	c7 44 24 04 00 93 10 	movl   $0x80109300,0x4(%esp)
80106668:	80 
80106669:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010666c:	89 04 24             	mov    %eax,(%esp)
8010666f:	e8 cd bf ff ff       	call   80102641 <dirlink>
80106674:	85 c0                	test   %eax,%eax
80106676:	78 21                	js     80106699 <create+0x178>
80106678:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010667b:	8b 40 04             	mov    0x4(%eax),%eax
8010667e:	89 44 24 08          	mov    %eax,0x8(%esp)
80106682:	c7 44 24 04 02 93 10 	movl   $0x80109302,0x4(%esp)
80106689:	80 
8010668a:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010668d:	89 04 24             	mov    %eax,(%esp)
80106690:	e8 ac bf ff ff       	call   80102641 <dirlink>
80106695:	85 c0                	test   %eax,%eax
80106697:	79 0c                	jns    801066a5 <create+0x184>
      panic("create dots");
80106699:	c7 04 24 35 93 10 80 	movl   $0x80109335,(%esp)
801066a0:	e8 98 9e ff ff       	call   8010053d <panic>
  }

  if(dirlink(dp, name, ip->inum) < 0)
801066a5:	8b 45 f0             	mov    -0x10(%ebp),%eax
801066a8:	8b 40 04             	mov    0x4(%eax),%eax
801066ab:	89 44 24 08          	mov    %eax,0x8(%esp)
801066af:	8d 45 de             	lea    -0x22(%ebp),%eax
801066b2:	89 44 24 04          	mov    %eax,0x4(%esp)
801066b6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801066b9:	89 04 24             	mov    %eax,(%esp)
801066bc:	e8 80 bf ff ff       	call   80102641 <dirlink>
801066c1:	85 c0                	test   %eax,%eax
801066c3:	79 0c                	jns    801066d1 <create+0x1b0>
    panic("create: dirlink");
801066c5:	c7 04 24 41 93 10 80 	movl   $0x80109341,(%esp)
801066cc:	e8 6c 9e ff ff       	call   8010053d <panic>

  iunlockput(dp);
801066d1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801066d4:	89 04 24             	mov    %eax,(%esp)
801066d7:	e8 08 b9 ff ff       	call   80101fe4 <iunlockput>

  return ip;
801066dc:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
801066df:	c9                   	leave  
801066e0:	c3                   	ret    

801066e1 <sys_open>:

int
sys_open(void)
{
801066e1:	55                   	push   %ebp
801066e2:	89 e5                	mov    %esp,%ebp
801066e4:	83 ec 38             	sub    $0x38,%esp
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
801066e7:	8d 45 e8             	lea    -0x18(%ebp),%eax
801066ea:	89 44 24 04          	mov    %eax,0x4(%esp)
801066ee:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801066f5:	e8 a2 f6 ff ff       	call   80105d9c <argstr>
801066fa:	85 c0                	test   %eax,%eax
801066fc:	78 17                	js     80106715 <sys_open+0x34>
801066fe:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80106701:	89 44 24 04          	mov    %eax,0x4(%esp)
80106705:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
8010670c:	e8 f1 f5 ff ff       	call   80105d02 <argint>
80106711:	85 c0                	test   %eax,%eax
80106713:	79 0a                	jns    8010671f <sys_open+0x3e>
    return -1;
80106715:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010671a:	e9 46 01 00 00       	jmp    80106865 <sys_open+0x184>
  if(omode & O_CREATE){
8010671f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106722:	25 00 02 00 00       	and    $0x200,%eax
80106727:	85 c0                	test   %eax,%eax
80106729:	74 40                	je     8010676b <sys_open+0x8a>
    begin_trans();
8010672b:	e8 e5 cf ff ff       	call   80103715 <begin_trans>
    ip = create(path, T_FILE, 0, 0);
80106730:	8b 45 e8             	mov    -0x18(%ebp),%eax
80106733:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
8010673a:	00 
8010673b:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
80106742:	00 
80106743:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
8010674a:	00 
8010674b:	89 04 24             	mov    %eax,(%esp)
8010674e:	e8 ce fd ff ff       	call   80106521 <create>
80106753:	89 45 f4             	mov    %eax,-0xc(%ebp)
    commit_trans();
80106756:	e8 03 d0 ff ff       	call   8010375e <commit_trans>
    if(ip == 0)
8010675b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010675f:	75 5c                	jne    801067bd <sys_open+0xdc>
      return -1;
80106761:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106766:	e9 fa 00 00 00       	jmp    80106865 <sys_open+0x184>
  } else {
    if((ip = namei(path)) == 0)
8010676b:	8b 45 e8             	mov    -0x18(%ebp),%eax
8010676e:	89 04 24             	mov    %eax,(%esp)
80106771:	e8 8c c1 ff ff       	call   80102902 <namei>
80106776:	89 45 f4             	mov    %eax,-0xc(%ebp)
80106779:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010677d:	75 0a                	jne    80106789 <sys_open+0xa8>
      return -1;
8010677f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106784:	e9 dc 00 00 00       	jmp    80106865 <sys_open+0x184>
    ilock(ip);
80106789:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010678c:	89 04 24             	mov    %eax,(%esp)
8010678f:	e8 cc b5 ff ff       	call   80101d60 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
80106794:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106797:	0f b7 40 10          	movzwl 0x10(%eax),%eax
8010679b:	66 83 f8 01          	cmp    $0x1,%ax
8010679f:	75 1c                	jne    801067bd <sys_open+0xdc>
801067a1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801067a4:	85 c0                	test   %eax,%eax
801067a6:	74 15                	je     801067bd <sys_open+0xdc>
      iunlockput(ip);
801067a8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801067ab:	89 04 24             	mov    %eax,(%esp)
801067ae:	e8 31 b8 ff ff       	call   80101fe4 <iunlockput>
      return -1;
801067b3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801067b8:	e9 a8 00 00 00       	jmp    80106865 <sys_open+0x184>
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
801067bd:	e8 52 ac ff ff       	call   80101414 <filealloc>
801067c2:	89 45 f0             	mov    %eax,-0x10(%ebp)
801067c5:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801067c9:	74 14                	je     801067df <sys_open+0xfe>
801067cb:	8b 45 f0             	mov    -0x10(%ebp),%eax
801067ce:	89 04 24             	mov    %eax,(%esp)
801067d1:	e8 43 f7 ff ff       	call   80105f19 <fdalloc>
801067d6:	89 45 ec             	mov    %eax,-0x14(%ebp)
801067d9:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
801067dd:	79 23                	jns    80106802 <sys_open+0x121>
    if(f)
801067df:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801067e3:	74 0b                	je     801067f0 <sys_open+0x10f>
      fileclose(f);
801067e5:	8b 45 f0             	mov    -0x10(%ebp),%eax
801067e8:	89 04 24             	mov    %eax,(%esp)
801067eb:	e8 cc ac ff ff       	call   801014bc <fileclose>
    iunlockput(ip);
801067f0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801067f3:	89 04 24             	mov    %eax,(%esp)
801067f6:	e8 e9 b7 ff ff       	call   80101fe4 <iunlockput>
    return -1;
801067fb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106800:	eb 63                	jmp    80106865 <sys_open+0x184>
  }
  iunlock(ip);
80106802:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106805:	89 04 24             	mov    %eax,(%esp)
80106808:	e8 a1 b6 ff ff       	call   80101eae <iunlock>

  f->type = FD_INODE;
8010680d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106810:	c7 00 02 00 00 00    	movl   $0x2,(%eax)
  f->ip = ip;
80106816:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106819:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010681c:	89 50 10             	mov    %edx,0x10(%eax)
  f->off = 0;
8010681f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106822:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
  f->readable = !(omode & O_WRONLY);
80106829:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010682c:	83 e0 01             	and    $0x1,%eax
8010682f:	85 c0                	test   %eax,%eax
80106831:	0f 94 c2             	sete   %dl
80106834:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106837:	88 50 08             	mov    %dl,0x8(%eax)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
8010683a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010683d:	83 e0 01             	and    $0x1,%eax
80106840:	84 c0                	test   %al,%al
80106842:	75 0a                	jne    8010684e <sys_open+0x16d>
80106844:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106847:	83 e0 02             	and    $0x2,%eax
8010684a:	85 c0                	test   %eax,%eax
8010684c:	74 07                	je     80106855 <sys_open+0x174>
8010684e:	b8 01 00 00 00       	mov    $0x1,%eax
80106853:	eb 05                	jmp    8010685a <sys_open+0x179>
80106855:	b8 00 00 00 00       	mov    $0x0,%eax
8010685a:	89 c2                	mov    %eax,%edx
8010685c:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010685f:	88 50 09             	mov    %dl,0x9(%eax)
  return fd;
80106862:	8b 45 ec             	mov    -0x14(%ebp),%eax
}
80106865:	c9                   	leave  
80106866:	c3                   	ret    

80106867 <sys_mkdir>:

int
sys_mkdir(void)
{
80106867:	55                   	push   %ebp
80106868:	89 e5                	mov    %esp,%ebp
8010686a:	83 ec 28             	sub    $0x28,%esp
  char *path;
  struct inode *ip;

  begin_trans();
8010686d:	e8 a3 ce ff ff       	call   80103715 <begin_trans>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
80106872:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106875:	89 44 24 04          	mov    %eax,0x4(%esp)
80106879:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106880:	e8 17 f5 ff ff       	call   80105d9c <argstr>
80106885:	85 c0                	test   %eax,%eax
80106887:	78 2c                	js     801068b5 <sys_mkdir+0x4e>
80106889:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010688c:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
80106893:	00 
80106894:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
8010689b:	00 
8010689c:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
801068a3:	00 
801068a4:	89 04 24             	mov    %eax,(%esp)
801068a7:	e8 75 fc ff ff       	call   80106521 <create>
801068ac:	89 45 f4             	mov    %eax,-0xc(%ebp)
801068af:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801068b3:	75 0c                	jne    801068c1 <sys_mkdir+0x5a>
    commit_trans();
801068b5:	e8 a4 ce ff ff       	call   8010375e <commit_trans>
    return -1;
801068ba:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801068bf:	eb 15                	jmp    801068d6 <sys_mkdir+0x6f>
  }
  iunlockput(ip);
801068c1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801068c4:	89 04 24             	mov    %eax,(%esp)
801068c7:	e8 18 b7 ff ff       	call   80101fe4 <iunlockput>
  commit_trans();
801068cc:	e8 8d ce ff ff       	call   8010375e <commit_trans>
  return 0;
801068d1:	b8 00 00 00 00       	mov    $0x0,%eax
}
801068d6:	c9                   	leave  
801068d7:	c3                   	ret    

801068d8 <sys_mknod>:

int
sys_mknod(void)
{
801068d8:	55                   	push   %ebp
801068d9:	89 e5                	mov    %esp,%ebp
801068db:	83 ec 38             	sub    $0x38,%esp
  struct inode *ip;
  char *path;
  int len;
  int major, minor;
  
  begin_trans();
801068de:	e8 32 ce ff ff       	call   80103715 <begin_trans>
  if((len=argstr(0, &path)) < 0 ||
801068e3:	8d 45 ec             	lea    -0x14(%ebp),%eax
801068e6:	89 44 24 04          	mov    %eax,0x4(%esp)
801068ea:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801068f1:	e8 a6 f4 ff ff       	call   80105d9c <argstr>
801068f6:	89 45 f4             	mov    %eax,-0xc(%ebp)
801068f9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801068fd:	78 5e                	js     8010695d <sys_mknod+0x85>
     argint(1, &major) < 0 ||
801068ff:	8d 45 e8             	lea    -0x18(%ebp),%eax
80106902:	89 44 24 04          	mov    %eax,0x4(%esp)
80106906:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
8010690d:	e8 f0 f3 ff ff       	call   80105d02 <argint>
  char *path;
  int len;
  int major, minor;
  
  begin_trans();
  if((len=argstr(0, &path)) < 0 ||
80106912:	85 c0                	test   %eax,%eax
80106914:	78 47                	js     8010695d <sys_mknod+0x85>
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
80106916:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80106919:	89 44 24 04          	mov    %eax,0x4(%esp)
8010691d:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
80106924:	e8 d9 f3 ff ff       	call   80105d02 <argint>
  int len;
  int major, minor;
  
  begin_trans();
  if((len=argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
80106929:	85 c0                	test   %eax,%eax
8010692b:	78 30                	js     8010695d <sys_mknod+0x85>
     argint(2, &minor) < 0 ||
     (ip = create(path, T_DEV, major, minor)) == 0){
8010692d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106930:	0f bf c8             	movswl %ax,%ecx
80106933:	8b 45 e8             	mov    -0x18(%ebp),%eax
80106936:	0f bf d0             	movswl %ax,%edx
80106939:	8b 45 ec             	mov    -0x14(%ebp),%eax
  int major, minor;
  
  begin_trans();
  if((len=argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
8010693c:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
80106940:	89 54 24 08          	mov    %edx,0x8(%esp)
80106944:	c7 44 24 04 03 00 00 	movl   $0x3,0x4(%esp)
8010694b:	00 
8010694c:	89 04 24             	mov    %eax,(%esp)
8010694f:	e8 cd fb ff ff       	call   80106521 <create>
80106954:	89 45 f0             	mov    %eax,-0x10(%ebp)
80106957:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
8010695b:	75 0c                	jne    80106969 <sys_mknod+0x91>
     (ip = create(path, T_DEV, major, minor)) == 0){
    commit_trans();
8010695d:	e8 fc cd ff ff       	call   8010375e <commit_trans>
    return -1;
80106962:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106967:	eb 15                	jmp    8010697e <sys_mknod+0xa6>
  }
  iunlockput(ip);
80106969:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010696c:	89 04 24             	mov    %eax,(%esp)
8010696f:	e8 70 b6 ff ff       	call   80101fe4 <iunlockput>
  commit_trans();
80106974:	e8 e5 cd ff ff       	call   8010375e <commit_trans>
  return 0;
80106979:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010697e:	c9                   	leave  
8010697f:	c3                   	ret    

80106980 <sys_chdir>:

int
sys_chdir(void)
{
80106980:	55                   	push   %ebp
80106981:	89 e5                	mov    %esp,%ebp
80106983:	83 ec 28             	sub    $0x28,%esp
  char *path;
  struct inode *ip;

  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0)
80106986:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106989:	89 44 24 04          	mov    %eax,0x4(%esp)
8010698d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106994:	e8 03 f4 ff ff       	call   80105d9c <argstr>
80106999:	85 c0                	test   %eax,%eax
8010699b:	78 14                	js     801069b1 <sys_chdir+0x31>
8010699d:	8b 45 f0             	mov    -0x10(%ebp),%eax
801069a0:	89 04 24             	mov    %eax,(%esp)
801069a3:	e8 5a bf ff ff       	call   80102902 <namei>
801069a8:	89 45 f4             	mov    %eax,-0xc(%ebp)
801069ab:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801069af:	75 07                	jne    801069b8 <sys_chdir+0x38>
    return -1;
801069b1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801069b6:	eb 57                	jmp    80106a0f <sys_chdir+0x8f>
  ilock(ip);
801069b8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801069bb:	89 04 24             	mov    %eax,(%esp)
801069be:	e8 9d b3 ff ff       	call   80101d60 <ilock>
  if(ip->type != T_DIR){
801069c3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801069c6:	0f b7 40 10          	movzwl 0x10(%eax),%eax
801069ca:	66 83 f8 01          	cmp    $0x1,%ax
801069ce:	74 12                	je     801069e2 <sys_chdir+0x62>
    iunlockput(ip);
801069d0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801069d3:	89 04 24             	mov    %eax,(%esp)
801069d6:	e8 09 b6 ff ff       	call   80101fe4 <iunlockput>
    return -1;
801069db:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801069e0:	eb 2d                	jmp    80106a0f <sys_chdir+0x8f>
  }
  iunlock(ip);
801069e2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801069e5:	89 04 24             	mov    %eax,(%esp)
801069e8:	e8 c1 b4 ff ff       	call   80101eae <iunlock>
  iput(proc->cwd);
801069ed:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801069f3:	8b 40 68             	mov    0x68(%eax),%eax
801069f6:	89 04 24             	mov    %eax,(%esp)
801069f9:	e8 15 b5 ff ff       	call   80101f13 <iput>
  proc->cwd = ip;
801069fe:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106a04:	8b 55 f4             	mov    -0xc(%ebp),%edx
80106a07:	89 50 68             	mov    %edx,0x68(%eax)
  return 0;
80106a0a:	b8 00 00 00 00       	mov    $0x0,%eax
}
80106a0f:	c9                   	leave  
80106a10:	c3                   	ret    

80106a11 <sys_exec>:

int
sys_exec(void)
{
80106a11:	55                   	push   %ebp
80106a12:	89 e5                	mov    %esp,%ebp
80106a14:	81 ec a8 00 00 00    	sub    $0xa8,%esp
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80106a1a:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106a1d:	89 44 24 04          	mov    %eax,0x4(%esp)
80106a21:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106a28:	e8 6f f3 ff ff       	call   80105d9c <argstr>
80106a2d:	85 c0                	test   %eax,%eax
80106a2f:	78 1a                	js     80106a4b <sys_exec+0x3a>
80106a31:	8d 85 6c ff ff ff    	lea    -0x94(%ebp),%eax
80106a37:	89 44 24 04          	mov    %eax,0x4(%esp)
80106a3b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80106a42:	e8 bb f2 ff ff       	call   80105d02 <argint>
80106a47:	85 c0                	test   %eax,%eax
80106a49:	79 0a                	jns    80106a55 <sys_exec+0x44>
    return -1;
80106a4b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106a50:	e9 e2 00 00 00       	jmp    80106b37 <sys_exec+0x126>
  }
  memset(argv, 0, sizeof(argv));
80106a55:	c7 44 24 08 80 00 00 	movl   $0x80,0x8(%esp)
80106a5c:	00 
80106a5d:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80106a64:	00 
80106a65:	8d 85 70 ff ff ff    	lea    -0x90(%ebp),%eax
80106a6b:	89 04 24             	mov    %eax,(%esp)
80106a6e:	e8 df ee ff ff       	call   80105952 <memset>
  for(i=0;; i++){
80106a73:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(i >= NELEM(argv))
80106a7a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106a7d:	83 f8 1f             	cmp    $0x1f,%eax
80106a80:	76 0a                	jbe    80106a8c <sys_exec+0x7b>
      return -1;
80106a82:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106a87:	e9 ab 00 00 00       	jmp    80106b37 <sys_exec+0x126>
    if(fetchint(proc, uargv+4*i, (int*)&uarg) < 0)
80106a8c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106a8f:	c1 e0 02             	shl    $0x2,%eax
80106a92:	89 c2                	mov    %eax,%edx
80106a94:	8b 85 6c ff ff ff    	mov    -0x94(%ebp),%eax
80106a9a:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
80106a9d:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106aa3:	8d 95 68 ff ff ff    	lea    -0x98(%ebp),%edx
80106aa9:	89 54 24 08          	mov    %edx,0x8(%esp)
80106aad:	89 4c 24 04          	mov    %ecx,0x4(%esp)
80106ab1:	89 04 24             	mov    %eax,(%esp)
80106ab4:	e8 b7 f1 ff ff       	call   80105c70 <fetchint>
80106ab9:	85 c0                	test   %eax,%eax
80106abb:	79 07                	jns    80106ac4 <sys_exec+0xb3>
      return -1;
80106abd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106ac2:	eb 73                	jmp    80106b37 <sys_exec+0x126>
    if(uarg == 0){
80106ac4:	8b 85 68 ff ff ff    	mov    -0x98(%ebp),%eax
80106aca:	85 c0                	test   %eax,%eax
80106acc:	75 26                	jne    80106af4 <sys_exec+0xe3>
      argv[i] = 0;
80106ace:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106ad1:	c7 84 85 70 ff ff ff 	movl   $0x0,-0x90(%ebp,%eax,4)
80106ad8:	00 00 00 00 
      break;
80106adc:	90                   	nop
    }
    if(fetchstr(proc, uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
80106add:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106ae0:	8d 95 70 ff ff ff    	lea    -0x90(%ebp),%edx
80106ae6:	89 54 24 04          	mov    %edx,0x4(%esp)
80106aea:	89 04 24             	mov    %eax,(%esp)
80106aed:	e8 2e a4 ff ff       	call   80100f20 <exec>
80106af2:	eb 43                	jmp    80106b37 <sys_exec+0x126>
      return -1;
    if(uarg == 0){
      argv[i] = 0;
      break;
    }
    if(fetchstr(proc, uarg, &argv[i]) < 0)
80106af4:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106af7:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80106afe:	8d 85 70 ff ff ff    	lea    -0x90(%ebp),%eax
80106b04:	8d 0c 10             	lea    (%eax,%edx,1),%ecx
80106b07:	8b 95 68 ff ff ff    	mov    -0x98(%ebp),%edx
80106b0d:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106b13:	89 4c 24 08          	mov    %ecx,0x8(%esp)
80106b17:	89 54 24 04          	mov    %edx,0x4(%esp)
80106b1b:	89 04 24             	mov    %eax,(%esp)
80106b1e:	e8 81 f1 ff ff       	call   80105ca4 <fetchstr>
80106b23:	85 c0                	test   %eax,%eax
80106b25:	79 07                	jns    80106b2e <sys_exec+0x11d>
      return -1;
80106b27:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106b2c:	eb 09                	jmp    80106b37 <sys_exec+0x126>

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
    return -1;
  }
  memset(argv, 0, sizeof(argv));
  for(i=0;; i++){
80106b2e:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      argv[i] = 0;
      break;
    }
    if(fetchstr(proc, uarg, &argv[i]) < 0)
      return -1;
  }
80106b32:	e9 43 ff ff ff       	jmp    80106a7a <sys_exec+0x69>
  return exec(path, argv);
}
80106b37:	c9                   	leave  
80106b38:	c3                   	ret    

80106b39 <sys_pipe>:

int
sys_pipe(void)
{
80106b39:	55                   	push   %ebp
80106b3a:	89 e5                	mov    %esp,%ebp
80106b3c:	83 ec 38             	sub    $0x38,%esp
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80106b3f:	c7 44 24 08 08 00 00 	movl   $0x8,0x8(%esp)
80106b46:	00 
80106b47:	8d 45 ec             	lea    -0x14(%ebp),%eax
80106b4a:	89 44 24 04          	mov    %eax,0x4(%esp)
80106b4e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106b55:	e8 e0 f1 ff ff       	call   80105d3a <argptr>
80106b5a:	85 c0                	test   %eax,%eax
80106b5c:	79 0a                	jns    80106b68 <sys_pipe+0x2f>
    return -1;
80106b5e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106b63:	e9 9b 00 00 00       	jmp    80106c03 <sys_pipe+0xca>
  if(pipealloc(&rf, &wf) < 0)
80106b68:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80106b6b:	89 44 24 04          	mov    %eax,0x4(%esp)
80106b6f:	8d 45 e8             	lea    -0x18(%ebp),%eax
80106b72:	89 04 24             	mov    %eax,(%esp)
80106b75:	e8 b6 d5 ff ff       	call   80104130 <pipealloc>
80106b7a:	85 c0                	test   %eax,%eax
80106b7c:	79 07                	jns    80106b85 <sys_pipe+0x4c>
    return -1;
80106b7e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106b83:	eb 7e                	jmp    80106c03 <sys_pipe+0xca>
  fd0 = -1;
80106b85:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%ebp)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80106b8c:	8b 45 e8             	mov    -0x18(%ebp),%eax
80106b8f:	89 04 24             	mov    %eax,(%esp)
80106b92:	e8 82 f3 ff ff       	call   80105f19 <fdalloc>
80106b97:	89 45 f4             	mov    %eax,-0xc(%ebp)
80106b9a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80106b9e:	78 14                	js     80106bb4 <sys_pipe+0x7b>
80106ba0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106ba3:	89 04 24             	mov    %eax,(%esp)
80106ba6:	e8 6e f3 ff ff       	call   80105f19 <fdalloc>
80106bab:	89 45 f0             	mov    %eax,-0x10(%ebp)
80106bae:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80106bb2:	79 37                	jns    80106beb <sys_pipe+0xb2>
    if(fd0 >= 0)
80106bb4:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80106bb8:	78 14                	js     80106bce <sys_pipe+0x95>
      proc->ofile[fd0] = 0;
80106bba:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106bc0:	8b 55 f4             	mov    -0xc(%ebp),%edx
80106bc3:	83 c2 08             	add    $0x8,%edx
80106bc6:	c7 44 90 08 00 00 00 	movl   $0x0,0x8(%eax,%edx,4)
80106bcd:	00 
    fileclose(rf);
80106bce:	8b 45 e8             	mov    -0x18(%ebp),%eax
80106bd1:	89 04 24             	mov    %eax,(%esp)
80106bd4:	e8 e3 a8 ff ff       	call   801014bc <fileclose>
    fileclose(wf);
80106bd9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106bdc:	89 04 24             	mov    %eax,(%esp)
80106bdf:	e8 d8 a8 ff ff       	call   801014bc <fileclose>
    return -1;
80106be4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106be9:	eb 18                	jmp    80106c03 <sys_pipe+0xca>
  }
  fd[0] = fd0;
80106beb:	8b 45 ec             	mov    -0x14(%ebp),%eax
80106bee:	8b 55 f4             	mov    -0xc(%ebp),%edx
80106bf1:	89 10                	mov    %edx,(%eax)
  fd[1] = fd1;
80106bf3:	8b 45 ec             	mov    -0x14(%ebp),%eax
80106bf6:	8d 50 04             	lea    0x4(%eax),%edx
80106bf9:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106bfc:	89 02                	mov    %eax,(%edx)
  return 0;
80106bfe:	b8 00 00 00 00       	mov    $0x0,%eax
}
80106c03:	c9                   	leave  
80106c04:	c3                   	ret    
80106c05:	00 00                	add    %al,(%eax)
	...

80106c08 <sys_fork>:
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
80106c08:	55                   	push   %ebp
80106c09:	89 e5                	mov    %esp,%ebp
80106c0b:	83 ec 08             	sub    $0x8,%esp
  return fork();
80106c0e:	e8 22 df ff ff       	call   80104b35 <fork>
}
80106c13:	c9                   	leave  
80106c14:	c3                   	ret    

80106c15 <sys_exit>:

int
sys_exit(void)
{
80106c15:	55                   	push   %ebp
80106c16:	89 e5                	mov    %esp,%ebp
80106c18:	83 ec 08             	sub    $0x8,%esp
  exit();
80106c1b:	e8 8a e0 ff ff       	call   80104caa <exit>
  return 0;  // not reached
80106c20:	b8 00 00 00 00       	mov    $0x0,%eax
}
80106c25:	c9                   	leave  
80106c26:	c3                   	ret    

80106c27 <sys_wait>:

int
sys_wait(void)
{
80106c27:	55                   	push   %ebp
80106c28:	89 e5                	mov    %esp,%ebp
80106c2a:	83 ec 08             	sub    $0x8,%esp
  return wait();
80106c2d:	e8 bc e1 ff ff       	call   80104dee <wait>
}
80106c32:	c9                   	leave  
80106c33:	c3                   	ret    

80106c34 <sys_kill>:

int
sys_kill(void)
{
80106c34:	55                   	push   %ebp
80106c35:	89 e5                	mov    %esp,%ebp
80106c37:	83 ec 28             	sub    $0x28,%esp
  int pid;

  if(argint(0, &pid) < 0)
80106c3a:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106c3d:	89 44 24 04          	mov    %eax,0x4(%esp)
80106c41:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106c48:	e8 b5 f0 ff ff       	call   80105d02 <argint>
80106c4d:	85 c0                	test   %eax,%eax
80106c4f:	79 07                	jns    80106c58 <sys_kill+0x24>
    return -1;
80106c51:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106c56:	eb 0b                	jmp    80106c63 <sys_kill+0x2f>
  return kill(pid);
80106c58:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106c5b:	89 04 24             	mov    %eax,(%esp)
80106c5e:	e8 bd e7 ff ff       	call   80105420 <kill>
}
80106c63:	c9                   	leave  
80106c64:	c3                   	ret    

80106c65 <sys_getpid>:

int
sys_getpid(void)
{
80106c65:	55                   	push   %ebp
80106c66:	89 e5                	mov    %esp,%ebp
  return proc->pid;
80106c68:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106c6e:	8b 40 10             	mov    0x10(%eax),%eax
}
80106c71:	5d                   	pop    %ebp
80106c72:	c3                   	ret    

80106c73 <sys_sbrk>:

int
sys_sbrk(void)
{
80106c73:	55                   	push   %ebp
80106c74:	89 e5                	mov    %esp,%ebp
80106c76:	83 ec 28             	sub    $0x28,%esp
  int addr;
  int n;

  if(argint(0, &n) < 0)
80106c79:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106c7c:	89 44 24 04          	mov    %eax,0x4(%esp)
80106c80:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106c87:	e8 76 f0 ff ff       	call   80105d02 <argint>
80106c8c:	85 c0                	test   %eax,%eax
80106c8e:	79 07                	jns    80106c97 <sys_sbrk+0x24>
    return -1;
80106c90:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106c95:	eb 24                	jmp    80106cbb <sys_sbrk+0x48>
  addr = proc->sz;
80106c97:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106c9d:	8b 00                	mov    (%eax),%eax
80106c9f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(growproc(n) < 0)
80106ca2:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106ca5:	89 04 24             	mov    %eax,(%esp)
80106ca8:	e8 e3 dd ff ff       	call   80104a90 <growproc>
80106cad:	85 c0                	test   %eax,%eax
80106caf:	79 07                	jns    80106cb8 <sys_sbrk+0x45>
    return -1;
80106cb1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106cb6:	eb 03                	jmp    80106cbb <sys_sbrk+0x48>
  return addr;
80106cb8:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80106cbb:	c9                   	leave  
80106cbc:	c3                   	ret    

80106cbd <sys_sleep>:

int
sys_sleep(void)
{
80106cbd:	55                   	push   %ebp
80106cbe:	89 e5                	mov    %esp,%ebp
80106cc0:	83 ec 28             	sub    $0x28,%esp
  int n;
  uint ticks0;
  
  if(argint(0, &n) < 0)
80106cc3:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106cc6:	89 44 24 04          	mov    %eax,0x4(%esp)
80106cca:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106cd1:	e8 2c f0 ff ff       	call   80105d02 <argint>
80106cd6:	85 c0                	test   %eax,%eax
80106cd8:	79 07                	jns    80106ce1 <sys_sleep+0x24>
    return -1;
80106cda:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106cdf:	eb 6c                	jmp    80106d4d <sys_sleep+0x90>
  acquire(&tickslock);
80106ce1:	c7 04 24 e0 47 11 80 	movl   $0x801147e0,(%esp)
80106ce8:	e8 16 ea ff ff       	call   80105703 <acquire>
  ticks0 = ticks;
80106ced:	a1 20 50 11 80       	mov    0x80115020,%eax
80106cf2:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(ticks - ticks0 < n){
80106cf5:	eb 34                	jmp    80106d2b <sys_sleep+0x6e>
    if(proc->killed){
80106cf7:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106cfd:	8b 40 24             	mov    0x24(%eax),%eax
80106d00:	85 c0                	test   %eax,%eax
80106d02:	74 13                	je     80106d17 <sys_sleep+0x5a>
      release(&tickslock);
80106d04:	c7 04 24 e0 47 11 80 	movl   $0x801147e0,(%esp)
80106d0b:	e8 55 ea ff ff       	call   80105765 <release>
      return -1;
80106d10:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106d15:	eb 36                	jmp    80106d4d <sys_sleep+0x90>
    }
    sleep(&ticks, &tickslock);
80106d17:	c7 44 24 04 e0 47 11 	movl   $0x801147e0,0x4(%esp)
80106d1e:	80 
80106d1f:	c7 04 24 20 50 11 80 	movl   $0x80115020,(%esp)
80106d26:	e8 dc e5 ff ff       	call   80105307 <sleep>
  
  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
80106d2b:	a1 20 50 11 80       	mov    0x80115020,%eax
80106d30:	89 c2                	mov    %eax,%edx
80106d32:	2b 55 f4             	sub    -0xc(%ebp),%edx
80106d35:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106d38:	39 c2                	cmp    %eax,%edx
80106d3a:	72 bb                	jb     80106cf7 <sys_sleep+0x3a>
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
80106d3c:	c7 04 24 e0 47 11 80 	movl   $0x801147e0,(%esp)
80106d43:	e8 1d ea ff ff       	call   80105765 <release>
  return 0;
80106d48:	b8 00 00 00 00       	mov    $0x0,%eax
}
80106d4d:	c9                   	leave  
80106d4e:	c3                   	ret    

80106d4f <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
80106d4f:	55                   	push   %ebp
80106d50:	89 e5                	mov    %esp,%ebp
80106d52:	83 ec 28             	sub    $0x28,%esp
  uint xticks;
  
  acquire(&tickslock);
80106d55:	c7 04 24 e0 47 11 80 	movl   $0x801147e0,(%esp)
80106d5c:	e8 a2 e9 ff ff       	call   80105703 <acquire>
  xticks = ticks;
80106d61:	a1 20 50 11 80       	mov    0x80115020,%eax
80106d66:	89 45 f4             	mov    %eax,-0xc(%ebp)
  release(&tickslock);
80106d69:	c7 04 24 e0 47 11 80 	movl   $0x801147e0,(%esp)
80106d70:	e8 f0 e9 ff ff       	call   80105765 <release>
  return xticks;
80106d75:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80106d78:	c9                   	leave  
80106d79:	c3                   	ret    

80106d7a <sys_add_path>:

// add a path to the pathvariable in exec.c
int
sys_add_path(void)
{
80106d7a:	55                   	push   %ebp
80106d7b:	89 e5                	mov    %esp,%ebp
80106d7d:	83 ec 28             	sub    $0x28,%esp
  char *path;
    if(argstr(0, &path) < 0){
80106d80:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106d83:	89 44 24 04          	mov    %eax,0x4(%esp)
80106d87:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106d8e:	e8 09 f0 ff ff       	call   80105d9c <argstr>
80106d93:	85 c0                	test   %eax,%eax
80106d95:	79 07                	jns    80106d9e <sys_add_path+0x24>
      return -1;
80106d97:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106d9c:	eb 10                	jmp    80106dae <sys_add_path+0x34>
    }
else{
  definition_add_path(path);
80106d9e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106da1:	89 04 24             	mov    %eax,(%esp)
80106da4:	e8 f4 a5 ff ff       	call   8010139d <definition_add_path>
  }
  return 0;  
80106da9:	b8 00 00 00 00       	mov    $0x0,%eax
}
80106dae:	c9                   	leave  
80106daf:	c3                   	ret    

80106db0 <sys_wait2>:
 
int
sys_wait2(void)
{
80106db0:	55                   	push   %ebp
80106db1:	89 e5                	mov    %esp,%ebp
80106db3:	83 ec 28             	sub    $0x28,%esp
  int wtime;
  int rtime;
  int iotime;
  if(argint(0, &wtime) < 0){
80106db6:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106db9:	89 44 24 04          	mov    %eax,0x4(%esp)
80106dbd:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106dc4:	e8 39 ef ff ff       	call   80105d02 <argint>
80106dc9:	85 c0                	test   %eax,%eax
80106dcb:	79 07                	jns    80106dd4 <sys_wait2+0x24>
      return -1;
80106dcd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106dd2:	eb 59                	jmp    80106e2d <sys_wait2+0x7d>
    }
    if(argint(1, &rtime) < 0){
80106dd4:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106dd7:	89 44 24 04          	mov    %eax,0x4(%esp)
80106ddb:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80106de2:	e8 1b ef ff ff       	call   80105d02 <argint>
80106de7:	85 c0                	test   %eax,%eax
80106de9:	79 07                	jns    80106df2 <sys_wait2+0x42>
      return -1;
80106deb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106df0:	eb 3b                	jmp    80106e2d <sys_wait2+0x7d>
    }
    if(argint(2, &iotime) < 0){
80106df2:	8d 45 ec             	lea    -0x14(%ebp),%eax
80106df5:	89 44 24 04          	mov    %eax,0x4(%esp)
80106df9:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
80106e00:	e8 fd ee ff ff       	call   80105d02 <argint>
80106e05:	85 c0                	test   %eax,%eax
80106e07:	79 07                	jns    80106e10 <sys_wait2+0x60>
      return -1;
80106e09:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106e0e:	eb 1d                	jmp    80106e2d <sys_wait2+0x7d>
    }
return wait2((int *)wtime,(int *)rtime,(int *)iotime);
80106e10:	8b 45 ec             	mov    -0x14(%ebp),%eax
80106e13:	89 c1                	mov    %eax,%ecx
80106e15:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106e18:	89 c2                	mov    %eax,%edx
80106e1a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106e1d:	89 4c 24 08          	mov    %ecx,0x8(%esp)
80106e21:	89 54 24 04          	mov    %edx,0x4(%esp)
80106e25:	89 04 24             	mov    %eax,(%esp)
80106e28:	e8 ea e0 ff ff       	call   80104f17 <wait2>

}
80106e2d:	c9                   	leave  
80106e2e:	c3                   	ret    

80106e2f <sys_getquanta>:
int
sys_getquanta(void)
{
80106e2f:	55                   	push   %ebp
80106e30:	89 e5                	mov    %esp,%ebp
80106e32:	83 ec 08             	sub    $0x8,%esp
  
return getquanta();
80106e35:	e8 bf d9 ff ff       	call   801047f9 <getquanta>

}
80106e3a:	c9                   	leave  
80106e3b:	c3                   	ret    

80106e3c <sys_getqueue>:
int
sys_getqueue(void)
{
80106e3c:	55                   	push   %ebp
80106e3d:	89 e5                	mov    %esp,%ebp
80106e3f:	83 ec 08             	sub    $0x8,%esp
  
return getqueue();
80106e42:	e8 c3 d9 ff ff       	call   8010480a <getqueue>

}
80106e47:	c9                   	leave  
80106e48:	c3                   	ret    
80106e49:	00 00                	add    %al,(%eax)
	...

80106e4c <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
80106e4c:	55                   	push   %ebp
80106e4d:	89 e5                	mov    %esp,%ebp
80106e4f:	83 ec 08             	sub    $0x8,%esp
80106e52:	8b 55 08             	mov    0x8(%ebp),%edx
80106e55:	8b 45 0c             	mov    0xc(%ebp),%eax
80106e58:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
80106e5c:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80106e5f:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80106e63:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
80106e67:	ee                   	out    %al,(%dx)
}
80106e68:	c9                   	leave  
80106e69:	c3                   	ret    

80106e6a <timerinit>:
#define TIMER_RATEGEN   0x04    // mode 2, rate generator
#define TIMER_16BIT     0x30    // r/w counter 16 bits, LSB first

void
timerinit(void)
{
80106e6a:	55                   	push   %ebp
80106e6b:	89 e5                	mov    %esp,%ebp
80106e6d:	83 ec 18             	sub    $0x18,%esp
  // Interrupt 100 times/sec.
  outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
80106e70:	c7 44 24 04 34 00 00 	movl   $0x34,0x4(%esp)
80106e77:	00 
80106e78:	c7 04 24 43 00 00 00 	movl   $0x43,(%esp)
80106e7f:	e8 c8 ff ff ff       	call   80106e4c <outb>
  outb(IO_TIMER1, TIMER_DIV(100) % 256);
80106e84:	c7 44 24 04 9c 00 00 	movl   $0x9c,0x4(%esp)
80106e8b:	00 
80106e8c:	c7 04 24 40 00 00 00 	movl   $0x40,(%esp)
80106e93:	e8 b4 ff ff ff       	call   80106e4c <outb>
  outb(IO_TIMER1, TIMER_DIV(100) / 256);
80106e98:	c7 44 24 04 2e 00 00 	movl   $0x2e,0x4(%esp)
80106e9f:	00 
80106ea0:	c7 04 24 40 00 00 00 	movl   $0x40,(%esp)
80106ea7:	e8 a0 ff ff ff       	call   80106e4c <outb>
  picenable(IRQ_TIMER);
80106eac:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106eb3:	e8 01 d1 ff ff       	call   80103fb9 <picenable>
}
80106eb8:	c9                   	leave  
80106eb9:	c3                   	ret    
	...

80106ebc <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
80106ebc:	1e                   	push   %ds
  pushl %es
80106ebd:	06                   	push   %es
  pushl %fs
80106ebe:	0f a0                	push   %fs
  pushl %gs
80106ec0:	0f a8                	push   %gs
  pushal
80106ec2:	60                   	pusha  
  
  # Set up data and per-cpu segments.
  movw $(SEG_KDATA<<3), %ax
80106ec3:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
80106ec7:	8e d8                	mov    %eax,%ds
  movw %ax, %es
80106ec9:	8e c0                	mov    %eax,%es
  movw $(SEG_KCPU<<3), %ax
80106ecb:	66 b8 18 00          	mov    $0x18,%ax
  movw %ax, %fs
80106ecf:	8e e0                	mov    %eax,%fs
  movw %ax, %gs
80106ed1:	8e e8                	mov    %eax,%gs

  # Call trap(tf), where tf=%esp
  pushl %esp
80106ed3:	54                   	push   %esp
  call trap
80106ed4:	e8 de 01 00 00       	call   801070b7 <trap>
  addl $4, %esp
80106ed9:	83 c4 04             	add    $0x4,%esp

80106edc <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
80106edc:	61                   	popa   
  popl %gs
80106edd:	0f a9                	pop    %gs
  popl %fs
80106edf:	0f a1                	pop    %fs
  popl %es
80106ee1:	07                   	pop    %es
  popl %ds
80106ee2:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
80106ee3:	83 c4 08             	add    $0x8,%esp
  iret
80106ee6:	cf                   	iret   
	...

80106ee8 <lidt>:

struct gatedesc;

static inline void
lidt(struct gatedesc *p, int size)
{
80106ee8:	55                   	push   %ebp
80106ee9:	89 e5                	mov    %esp,%ebp
80106eeb:	83 ec 10             	sub    $0x10,%esp
  volatile ushort pd[3];

  pd[0] = size-1;
80106eee:	8b 45 0c             	mov    0xc(%ebp),%eax
80106ef1:	83 e8 01             	sub    $0x1,%eax
80106ef4:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
80106ef8:	8b 45 08             	mov    0x8(%ebp),%eax
80106efb:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80106eff:	8b 45 08             	mov    0x8(%ebp),%eax
80106f02:	c1 e8 10             	shr    $0x10,%eax
80106f05:	66 89 45 fe          	mov    %ax,-0x2(%ebp)

  asm volatile("lidt (%0)" : : "r" (pd));
80106f09:	8d 45 fa             	lea    -0x6(%ebp),%eax
80106f0c:	0f 01 18             	lidtl  (%eax)
}
80106f0f:	c9                   	leave  
80106f10:	c3                   	ret    

80106f11 <rcr2>:
  return result;
}

static inline uint
rcr2(void)
{
80106f11:	55                   	push   %ebp
80106f12:	89 e5                	mov    %esp,%ebp
80106f14:	53                   	push   %ebx
80106f15:	83 ec 10             	sub    $0x10,%esp
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
80106f18:	0f 20 d3             	mov    %cr2,%ebx
80106f1b:	89 5d f8             	mov    %ebx,-0x8(%ebp)
  return val;
80106f1e:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
80106f21:	83 c4 10             	add    $0x10,%esp
80106f24:	5b                   	pop    %ebx
80106f25:	5d                   	pop    %ebp
80106f26:	c3                   	ret    

80106f27 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80106f27:	55                   	push   %ebp
80106f28:	89 e5                	mov    %esp,%ebp
80106f2a:	83 ec 28             	sub    $0x28,%esp
  int i;

  for(i = 0; i < 256; i++)
80106f2d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80106f34:	e9 c3 00 00 00       	jmp    80106ffc <tvinit+0xd5>
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80106f39:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106f3c:	8b 04 85 a8 c3 10 80 	mov    -0x7fef3c58(,%eax,4),%eax
80106f43:	89 c2                	mov    %eax,%edx
80106f45:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106f48:	66 89 14 c5 20 48 11 	mov    %dx,-0x7feeb7e0(,%eax,8)
80106f4f:	80 
80106f50:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106f53:	66 c7 04 c5 22 48 11 	movw   $0x8,-0x7feeb7de(,%eax,8)
80106f5a:	80 08 00 
80106f5d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106f60:	0f b6 14 c5 24 48 11 	movzbl -0x7feeb7dc(,%eax,8),%edx
80106f67:	80 
80106f68:	83 e2 e0             	and    $0xffffffe0,%edx
80106f6b:	88 14 c5 24 48 11 80 	mov    %dl,-0x7feeb7dc(,%eax,8)
80106f72:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106f75:	0f b6 14 c5 24 48 11 	movzbl -0x7feeb7dc(,%eax,8),%edx
80106f7c:	80 
80106f7d:	83 e2 1f             	and    $0x1f,%edx
80106f80:	88 14 c5 24 48 11 80 	mov    %dl,-0x7feeb7dc(,%eax,8)
80106f87:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106f8a:	0f b6 14 c5 25 48 11 	movzbl -0x7feeb7db(,%eax,8),%edx
80106f91:	80 
80106f92:	83 e2 f0             	and    $0xfffffff0,%edx
80106f95:	83 ca 0e             	or     $0xe,%edx
80106f98:	88 14 c5 25 48 11 80 	mov    %dl,-0x7feeb7db(,%eax,8)
80106f9f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106fa2:	0f b6 14 c5 25 48 11 	movzbl -0x7feeb7db(,%eax,8),%edx
80106fa9:	80 
80106faa:	83 e2 ef             	and    $0xffffffef,%edx
80106fad:	88 14 c5 25 48 11 80 	mov    %dl,-0x7feeb7db(,%eax,8)
80106fb4:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106fb7:	0f b6 14 c5 25 48 11 	movzbl -0x7feeb7db(,%eax,8),%edx
80106fbe:	80 
80106fbf:	83 e2 9f             	and    $0xffffff9f,%edx
80106fc2:	88 14 c5 25 48 11 80 	mov    %dl,-0x7feeb7db(,%eax,8)
80106fc9:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106fcc:	0f b6 14 c5 25 48 11 	movzbl -0x7feeb7db(,%eax,8),%edx
80106fd3:	80 
80106fd4:	83 ca 80             	or     $0xffffff80,%edx
80106fd7:	88 14 c5 25 48 11 80 	mov    %dl,-0x7feeb7db(,%eax,8)
80106fde:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106fe1:	8b 04 85 a8 c3 10 80 	mov    -0x7fef3c58(,%eax,4),%eax
80106fe8:	c1 e8 10             	shr    $0x10,%eax
80106feb:	89 c2                	mov    %eax,%edx
80106fed:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106ff0:	66 89 14 c5 26 48 11 	mov    %dx,-0x7feeb7da(,%eax,8)
80106ff7:	80 
void
tvinit(void)
{
  int i;

  for(i = 0; i < 256; i++)
80106ff8:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80106ffc:	81 7d f4 ff 00 00 00 	cmpl   $0xff,-0xc(%ebp)
80107003:	0f 8e 30 ff ff ff    	jle    80106f39 <tvinit+0x12>
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80107009:	a1 a8 c4 10 80       	mov    0x8010c4a8,%eax
8010700e:	66 a3 20 4a 11 80    	mov    %ax,0x80114a20
80107014:	66 c7 05 22 4a 11 80 	movw   $0x8,0x80114a22
8010701b:	08 00 
8010701d:	0f b6 05 24 4a 11 80 	movzbl 0x80114a24,%eax
80107024:	83 e0 e0             	and    $0xffffffe0,%eax
80107027:	a2 24 4a 11 80       	mov    %al,0x80114a24
8010702c:	0f b6 05 24 4a 11 80 	movzbl 0x80114a24,%eax
80107033:	83 e0 1f             	and    $0x1f,%eax
80107036:	a2 24 4a 11 80       	mov    %al,0x80114a24
8010703b:	0f b6 05 25 4a 11 80 	movzbl 0x80114a25,%eax
80107042:	83 c8 0f             	or     $0xf,%eax
80107045:	a2 25 4a 11 80       	mov    %al,0x80114a25
8010704a:	0f b6 05 25 4a 11 80 	movzbl 0x80114a25,%eax
80107051:	83 e0 ef             	and    $0xffffffef,%eax
80107054:	a2 25 4a 11 80       	mov    %al,0x80114a25
80107059:	0f b6 05 25 4a 11 80 	movzbl 0x80114a25,%eax
80107060:	83 c8 60             	or     $0x60,%eax
80107063:	a2 25 4a 11 80       	mov    %al,0x80114a25
80107068:	0f b6 05 25 4a 11 80 	movzbl 0x80114a25,%eax
8010706f:	83 c8 80             	or     $0xffffff80,%eax
80107072:	a2 25 4a 11 80       	mov    %al,0x80114a25
80107077:	a1 a8 c4 10 80       	mov    0x8010c4a8,%eax
8010707c:	c1 e8 10             	shr    $0x10,%eax
8010707f:	66 a3 26 4a 11 80    	mov    %ax,0x80114a26
  
  initlock(&tickslock, "time");
80107085:	c7 44 24 04 54 93 10 	movl   $0x80109354,0x4(%esp)
8010708c:	80 
8010708d:	c7 04 24 e0 47 11 80 	movl   $0x801147e0,(%esp)
80107094:	e8 49 e6 ff ff       	call   801056e2 <initlock>
}
80107099:	c9                   	leave  
8010709a:	c3                   	ret    

8010709b <idtinit>:

void
idtinit(void)
{
8010709b:	55                   	push   %ebp
8010709c:	89 e5                	mov    %esp,%ebp
8010709e:	83 ec 08             	sub    $0x8,%esp
  lidt(idt, sizeof(idt));
801070a1:	c7 44 24 04 00 08 00 	movl   $0x800,0x4(%esp)
801070a8:	00 
801070a9:	c7 04 24 20 48 11 80 	movl   $0x80114820,(%esp)
801070b0:	e8 33 fe ff ff       	call   80106ee8 <lidt>
}
801070b5:	c9                   	leave  
801070b6:	c3                   	ret    

801070b7 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
801070b7:	55                   	push   %ebp
801070b8:	89 e5                	mov    %esp,%ebp
801070ba:	57                   	push   %edi
801070bb:	56                   	push   %esi
801070bc:	53                   	push   %ebx
801070bd:	83 ec 3c             	sub    $0x3c,%esp
  
  if(tf->trapno == T_SYSCALL){
801070c0:	8b 45 08             	mov    0x8(%ebp),%eax
801070c3:	8b 40 30             	mov    0x30(%eax),%eax
801070c6:	83 f8 40             	cmp    $0x40,%eax
801070c9:	75 3e                	jne    80107109 <trap+0x52>
    if(proc->killed)
801070cb:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801070d1:	8b 40 24             	mov    0x24(%eax),%eax
801070d4:	85 c0                	test   %eax,%eax
801070d6:	74 05                	je     801070dd <trap+0x26>
      exit();
801070d8:	e8 cd db ff ff       	call   80104caa <exit>
    proc->tf = tf;
801070dd:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801070e3:	8b 55 08             	mov    0x8(%ebp),%edx
801070e6:	89 50 18             	mov    %edx,0x18(%eax)
    syscall();
801070e9:	e8 f1 ec ff ff       	call   80105ddf <syscall>
    if(proc->killed)
801070ee:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801070f4:	8b 40 24             	mov    0x24(%eax),%eax
801070f7:	85 c0                	test   %eax,%eax
801070f9:	0f 84 49 02 00 00    	je     80107348 <trap+0x291>
      exit();
801070ff:	e8 a6 db ff ff       	call   80104caa <exit>
    return;
80107104:	e9 3f 02 00 00       	jmp    80107348 <trap+0x291>
  }

  switch(tf->trapno){
80107109:	8b 45 08             	mov    0x8(%ebp),%eax
8010710c:	8b 40 30             	mov    0x30(%eax),%eax
8010710f:	83 e8 20             	sub    $0x20,%eax
80107112:	83 f8 1f             	cmp    $0x1f,%eax
80107115:	0f 87 c1 00 00 00    	ja     801071dc <trap+0x125>
8010711b:	8b 04 85 fc 93 10 80 	mov    -0x7fef6c04(,%eax,4),%eax
80107122:	ff e0                	jmp    *%eax
  case T_IRQ0 + IRQ_TIMER:
    if(cpu->id == 0){
80107124:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
8010712a:	0f b6 00             	movzbl (%eax),%eax
8010712d:	84 c0                	test   %al,%al
8010712f:	75 36                	jne    80107167 <trap+0xb0>
      acquire(&tickslock);
80107131:	c7 04 24 e0 47 11 80 	movl   $0x801147e0,(%esp)
80107138:	e8 c6 e5 ff ff       	call   80105703 <acquire>

      ticks++;
8010713d:	a1 20 50 11 80       	mov    0x80115020,%eax
80107142:	83 c0 01             	add    $0x1,%eax
80107145:	a3 20 50 11 80       	mov    %eax,0x80115020
      sleepingUpDate();
8010714a:	e8 56 d4 ff ff       	call   801045a5 <sleepingUpDate>
        

      wakeup(&ticks);
8010714f:	c7 04 24 20 50 11 80 	movl   $0x80115020,(%esp)
80107156:	e8 9a e2 ff ff       	call   801053f5 <wakeup>
      release(&tickslock);
8010715b:	c7 04 24 e0 47 11 80 	movl   $0x801147e0,(%esp)
80107162:	e8 fe e5 ff ff       	call   80105765 <release>
    }
    lapiceoi();
80107167:	e8 75 c2 ff ff       	call   801033e1 <lapiceoi>
    break;
8010716c:	e9 41 01 00 00       	jmp    801072b2 <trap+0x1fb>
  case T_IRQ0 + IRQ_IDE:
    ideintr();
80107171:	e8 73 ba ff ff       	call   80102be9 <ideintr>
    lapiceoi();
80107176:	e8 66 c2 ff ff       	call   801033e1 <lapiceoi>
    break;
8010717b:	e9 32 01 00 00       	jmp    801072b2 <trap+0x1fb>
  case T_IRQ0 + IRQ_IDE+1:
    // Bochs generates spurious IDE1 interrupts.
    break;
  case T_IRQ0 + IRQ_KBD:
    kbdintr();
80107180:	e8 3a c0 ff ff       	call   801031bf <kbdintr>
    lapiceoi();
80107185:	e8 57 c2 ff ff       	call   801033e1 <lapiceoi>
    break;
8010718a:	e9 23 01 00 00       	jmp    801072b2 <trap+0x1fb>
  case T_IRQ0 + IRQ_COM1:
    uartintr();
8010718f:	e8 bc 03 00 00       	call   80107550 <uartintr>
    lapiceoi();
80107194:	e8 48 c2 ff ff       	call   801033e1 <lapiceoi>
    break;
80107199:	e9 14 01 00 00       	jmp    801072b2 <trap+0x1fb>
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
            cpu->id, tf->cs, tf->eip);
8010719e:	8b 45 08             	mov    0x8(%ebp),%eax
    uartintr();
    lapiceoi();
    break;
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
801071a1:	8b 48 38             	mov    0x38(%eax),%ecx
            cpu->id, tf->cs, tf->eip);
801071a4:	8b 45 08             	mov    0x8(%ebp),%eax
801071a7:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
    uartintr();
    lapiceoi();
    break;
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
801071ab:	0f b7 d0             	movzwl %ax,%edx
            cpu->id, tf->cs, tf->eip);
801071ae:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801071b4:	0f b6 00             	movzbl (%eax),%eax
    uartintr();
    lapiceoi();
    break;
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
801071b7:	0f b6 c0             	movzbl %al,%eax
801071ba:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
801071be:	89 54 24 08          	mov    %edx,0x8(%esp)
801071c2:	89 44 24 04          	mov    %eax,0x4(%esp)
801071c6:	c7 04 24 5c 93 10 80 	movl   $0x8010935c,(%esp)
801071cd:	e8 cf 91 ff ff       	call   801003a1 <cprintf>
            cpu->id, tf->cs, tf->eip);
    lapiceoi();
801071d2:	e8 0a c2 ff ff       	call   801033e1 <lapiceoi>
    break;
801071d7:	e9 d6 00 00 00       	jmp    801072b2 <trap+0x1fb>
   
  //PAGEBREAK: 13
  default:
    if(proc == 0 || (tf->cs&3) == 0){
801071dc:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801071e2:	85 c0                	test   %eax,%eax
801071e4:	74 11                	je     801071f7 <trap+0x140>
801071e6:	8b 45 08             	mov    0x8(%ebp),%eax
801071e9:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
801071ed:	0f b7 c0             	movzwl %ax,%eax
801071f0:	83 e0 03             	and    $0x3,%eax
801071f3:	85 c0                	test   %eax,%eax
801071f5:	75 46                	jne    8010723d <trap+0x186>
      // In kernel, it must be our mistake.
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
801071f7:	e8 15 fd ff ff       	call   80106f11 <rcr2>
              tf->trapno, cpu->id, tf->eip, rcr2());
801071fc:	8b 55 08             	mov    0x8(%ebp),%edx
   
  //PAGEBREAK: 13
  default:
    if(proc == 0 || (tf->cs&3) == 0){
      // In kernel, it must be our mistake.
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
801071ff:	8b 5a 38             	mov    0x38(%edx),%ebx
              tf->trapno, cpu->id, tf->eip, rcr2());
80107202:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80107209:	0f b6 12             	movzbl (%edx),%edx
   
  //PAGEBREAK: 13
  default:
    if(proc == 0 || (tf->cs&3) == 0){
      // In kernel, it must be our mistake.
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
8010720c:	0f b6 ca             	movzbl %dl,%ecx
              tf->trapno, cpu->id, tf->eip, rcr2());
8010720f:	8b 55 08             	mov    0x8(%ebp),%edx
   
  //PAGEBREAK: 13
  default:
    if(proc == 0 || (tf->cs&3) == 0){
      // In kernel, it must be our mistake.
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80107212:	8b 52 30             	mov    0x30(%edx),%edx
80107215:	89 44 24 10          	mov    %eax,0x10(%esp)
80107219:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
8010721d:	89 4c 24 08          	mov    %ecx,0x8(%esp)
80107221:	89 54 24 04          	mov    %edx,0x4(%esp)
80107225:	c7 04 24 80 93 10 80 	movl   $0x80109380,(%esp)
8010722c:	e8 70 91 ff ff       	call   801003a1 <cprintf>
              tf->trapno, cpu->id, tf->eip, rcr2());
      panic("trap");
80107231:	c7 04 24 b2 93 10 80 	movl   $0x801093b2,(%esp)
80107238:	e8 00 93 ff ff       	call   8010053d <panic>
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
8010723d:	e8 cf fc ff ff       	call   80106f11 <rcr2>
80107242:	89 c2                	mov    %eax,%edx
            "eip 0x%x addr 0x%x--kill proc\n",
            proc->pid, proc->name, tf->trapno, tf->err, cpu->id, tf->eip, 
80107244:	8b 45 08             	mov    0x8(%ebp),%eax
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpu->id, tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80107247:	8b 78 38             	mov    0x38(%eax),%edi
            "eip 0x%x addr 0x%x--kill proc\n",
            proc->pid, proc->name, tf->trapno, tf->err, cpu->id, tf->eip, 
8010724a:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80107250:	0f b6 00             	movzbl (%eax),%eax
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpu->id, tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80107253:	0f b6 f0             	movzbl %al,%esi
            "eip 0x%x addr 0x%x--kill proc\n",
            proc->pid, proc->name, tf->trapno, tf->err, cpu->id, tf->eip, 
80107256:	8b 45 08             	mov    0x8(%ebp),%eax
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpu->id, tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80107259:	8b 58 34             	mov    0x34(%eax),%ebx
            "eip 0x%x addr 0x%x--kill proc\n",
            proc->pid, proc->name, tf->trapno, tf->err, cpu->id, tf->eip, 
8010725c:	8b 45 08             	mov    0x8(%ebp),%eax
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpu->id, tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
8010725f:	8b 48 30             	mov    0x30(%eax),%ecx
            "eip 0x%x addr 0x%x--kill proc\n",
            proc->pid, proc->name, tf->trapno, tf->err, cpu->id, tf->eip, 
80107262:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80107268:	83 c0 6c             	add    $0x6c,%eax
8010726b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010726e:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpu->id, tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80107274:	8b 40 10             	mov    0x10(%eax),%eax
80107277:	89 54 24 1c          	mov    %edx,0x1c(%esp)
8010727b:	89 7c 24 18          	mov    %edi,0x18(%esp)
8010727f:	89 74 24 14          	mov    %esi,0x14(%esp)
80107283:	89 5c 24 10          	mov    %ebx,0x10(%esp)
80107287:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
8010728b:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010728e:	89 54 24 08          	mov    %edx,0x8(%esp)
80107292:	89 44 24 04          	mov    %eax,0x4(%esp)
80107296:	c7 04 24 b8 93 10 80 	movl   $0x801093b8,(%esp)
8010729d:	e8 ff 90 ff ff       	call   801003a1 <cprintf>
            "eip 0x%x addr 0x%x--kill proc\n",
            proc->pid, proc->name, tf->trapno, tf->err, cpu->id, tf->eip, 
            rcr2());
    proc->killed = 1;
801072a2:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801072a8:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
801072af:	eb 01                	jmp    801072b2 <trap+0x1fb>
    ideintr();
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE+1:
    // Bochs generates spurious IDE1 interrupts.
    break;
801072b1:	90                   	nop
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running 
  // until it gets to the regular system call return.)
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
801072b2:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801072b8:	85 c0                	test   %eax,%eax
801072ba:	74 24                	je     801072e0 <trap+0x229>
801072bc:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801072c2:	8b 40 24             	mov    0x24(%eax),%eax
801072c5:	85 c0                	test   %eax,%eax
801072c7:	74 17                	je     801072e0 <trap+0x229>
801072c9:	8b 45 08             	mov    0x8(%ebp),%eax
801072cc:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
801072d0:	0f b7 c0             	movzwl %ax,%eax
801072d3:	83 e0 03             	and    $0x3,%eax
801072d6:	83 f8 03             	cmp    $0x3,%eax
801072d9:	75 05                	jne    801072e0 <trap+0x229>
    exit();
801072db:	e8 ca d9 ff ff       	call   80104caa <exit>

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(proc && proc->state == RUNNING && tf->trapno == T_IRQ0+IRQ_TIMER ){
801072e0:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801072e6:	85 c0                	test   %eax,%eax
801072e8:	74 2e                	je     80107318 <trap+0x261>
801072ea:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801072f0:	8b 40 0c             	mov    0xc(%eax),%eax
801072f3:	83 f8 04             	cmp    $0x4,%eax
801072f6:	75 20                	jne    80107318 <trap+0x261>
801072f8:	8b 45 08             	mov    0x8(%ebp),%eax
801072fb:	8b 40 30             	mov    0x30(%eax),%eax
801072fe:	83 f8 20             	cmp    $0x20,%eax
80107301:	75 15                	jne    80107318 <trap+0x261>
    {
      yield();
    }
    else
    {
      if(proc->quanta==0)
80107303:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80107309:	8b 80 94 00 00 00    	mov    0x94(%eax),%eax
8010730f:	85 c0                	test   %eax,%eax
80107311:	75 05                	jne    80107318 <trap+0x261>
        yield();
80107313:	e8 88 df ff ff       	call   801052a0 <yield>
    }
    }

  // Check if the process has been killed since we yielded
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
80107318:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010731e:	85 c0                	test   %eax,%eax
80107320:	74 27                	je     80107349 <trap+0x292>
80107322:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80107328:	8b 40 24             	mov    0x24(%eax),%eax
8010732b:	85 c0                	test   %eax,%eax
8010732d:	74 1a                	je     80107349 <trap+0x292>
8010732f:	8b 45 08             	mov    0x8(%ebp),%eax
80107332:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
80107336:	0f b7 c0             	movzwl %ax,%eax
80107339:	83 e0 03             	and    $0x3,%eax
8010733c:	83 f8 03             	cmp    $0x3,%eax
8010733f:	75 08                	jne    80107349 <trap+0x292>
    exit();
80107341:	e8 64 d9 ff ff       	call   80104caa <exit>
80107346:	eb 01                	jmp    80107349 <trap+0x292>
      exit();
    proc->tf = tf;
    syscall();
    if(proc->killed)
      exit();
    return;
80107348:	90                   	nop
    }

  // Check if the process has been killed since we yielded
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
    exit();
}
80107349:	83 c4 3c             	add    $0x3c,%esp
8010734c:	5b                   	pop    %ebx
8010734d:	5e                   	pop    %esi
8010734e:	5f                   	pop    %edi
8010734f:	5d                   	pop    %ebp
80107350:	c3                   	ret    
80107351:	00 00                	add    %al,(%eax)
	...

80107354 <inb>:
// Routines to let C code use special x86 instructions.

static inline uchar
inb(ushort port)
{
80107354:	55                   	push   %ebp
80107355:	89 e5                	mov    %esp,%ebp
80107357:	53                   	push   %ebx
80107358:	83 ec 14             	sub    $0x14,%esp
8010735b:	8b 45 08             	mov    0x8(%ebp),%eax
8010735e:	66 89 45 e8          	mov    %ax,-0x18(%ebp)
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80107362:	0f b7 55 e8          	movzwl -0x18(%ebp),%edx
80107366:	66 89 55 ea          	mov    %dx,-0x16(%ebp)
8010736a:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
8010736e:	ec                   	in     (%dx),%al
8010736f:	89 c3                	mov    %eax,%ebx
80107371:	88 5d fb             	mov    %bl,-0x5(%ebp)
  return data;
80107374:	0f b6 45 fb          	movzbl -0x5(%ebp),%eax
}
80107378:	83 c4 14             	add    $0x14,%esp
8010737b:	5b                   	pop    %ebx
8010737c:	5d                   	pop    %ebp
8010737d:	c3                   	ret    

8010737e <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
8010737e:	55                   	push   %ebp
8010737f:	89 e5                	mov    %esp,%ebp
80107381:	83 ec 08             	sub    $0x8,%esp
80107384:	8b 55 08             	mov    0x8(%ebp),%edx
80107387:	8b 45 0c             	mov    0xc(%ebp),%eax
8010738a:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
8010738e:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80107391:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80107395:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
80107399:	ee                   	out    %al,(%dx)
}
8010739a:	c9                   	leave  
8010739b:	c3                   	ret    

8010739c <uartinit>:

static int uart;    // is there a uart?

void
uartinit(void)
{
8010739c:	55                   	push   %ebp
8010739d:	89 e5                	mov    %esp,%ebp
8010739f:	83 ec 28             	sub    $0x28,%esp
  char *p;

  // Turn off the FIFO
  outb(COM1+2, 0);
801073a2:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
801073a9:	00 
801073aa:	c7 04 24 fa 03 00 00 	movl   $0x3fa,(%esp)
801073b1:	e8 c8 ff ff ff       	call   8010737e <outb>
  
  // 9600 baud, 8 data bits, 1 stop bit, parity off.
  outb(COM1+3, 0x80);    // Unlock divisor
801073b6:	c7 44 24 04 80 00 00 	movl   $0x80,0x4(%esp)
801073bd:	00 
801073be:	c7 04 24 fb 03 00 00 	movl   $0x3fb,(%esp)
801073c5:	e8 b4 ff ff ff       	call   8010737e <outb>
  outb(COM1+0, 115200/9600);
801073ca:	c7 44 24 04 0c 00 00 	movl   $0xc,0x4(%esp)
801073d1:	00 
801073d2:	c7 04 24 f8 03 00 00 	movl   $0x3f8,(%esp)
801073d9:	e8 a0 ff ff ff       	call   8010737e <outb>
  outb(COM1+1, 0);
801073de:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
801073e5:	00 
801073e6:	c7 04 24 f9 03 00 00 	movl   $0x3f9,(%esp)
801073ed:	e8 8c ff ff ff       	call   8010737e <outb>
  outb(COM1+3, 0x03);    // Lock divisor, 8 data bits.
801073f2:	c7 44 24 04 03 00 00 	movl   $0x3,0x4(%esp)
801073f9:	00 
801073fa:	c7 04 24 fb 03 00 00 	movl   $0x3fb,(%esp)
80107401:	e8 78 ff ff ff       	call   8010737e <outb>
  outb(COM1+4, 0);
80107406:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
8010740d:	00 
8010740e:	c7 04 24 fc 03 00 00 	movl   $0x3fc,(%esp)
80107415:	e8 64 ff ff ff       	call   8010737e <outb>
  outb(COM1+1, 0x01);    // Enable receive interrupts.
8010741a:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
80107421:	00 
80107422:	c7 04 24 f9 03 00 00 	movl   $0x3f9,(%esp)
80107429:	e8 50 ff ff ff       	call   8010737e <outb>

  // If status is 0xFF, no serial port.
  if(inb(COM1+5) == 0xFF)
8010742e:	c7 04 24 fd 03 00 00 	movl   $0x3fd,(%esp)
80107435:	e8 1a ff ff ff       	call   80107354 <inb>
8010743a:	3c ff                	cmp    $0xff,%al
8010743c:	74 6c                	je     801074aa <uartinit+0x10e>
    return;
  uart = 1;
8010743e:	c7 05 a4 ce 10 80 01 	movl   $0x1,0x8010cea4
80107445:	00 00 00 

  // Acknowledge pre-existing interrupt conditions;
  // enable interrupts.
  inb(COM1+2);
80107448:	c7 04 24 fa 03 00 00 	movl   $0x3fa,(%esp)
8010744f:	e8 00 ff ff ff       	call   80107354 <inb>
  inb(COM1+0);
80107454:	c7 04 24 f8 03 00 00 	movl   $0x3f8,(%esp)
8010745b:	e8 f4 fe ff ff       	call   80107354 <inb>
  picenable(IRQ_COM1);
80107460:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
80107467:	e8 4d cb ff ff       	call   80103fb9 <picenable>
  ioapicenable(IRQ_COM1, 0);
8010746c:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80107473:	00 
80107474:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
8010747b:	e8 ee b9 ff ff       	call   80102e6e <ioapicenable>
  
  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
80107480:	c7 45 f4 7c 94 10 80 	movl   $0x8010947c,-0xc(%ebp)
80107487:	eb 15                	jmp    8010749e <uartinit+0x102>
    uartputc(*p);
80107489:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010748c:	0f b6 00             	movzbl (%eax),%eax
8010748f:	0f be c0             	movsbl %al,%eax
80107492:	89 04 24             	mov    %eax,(%esp)
80107495:	e8 13 00 00 00       	call   801074ad <uartputc>
  inb(COM1+0);
  picenable(IRQ_COM1);
  ioapicenable(IRQ_COM1, 0);
  
  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
8010749a:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
8010749e:	8b 45 f4             	mov    -0xc(%ebp),%eax
801074a1:	0f b6 00             	movzbl (%eax),%eax
801074a4:	84 c0                	test   %al,%al
801074a6:	75 e1                	jne    80107489 <uartinit+0xed>
801074a8:	eb 01                	jmp    801074ab <uartinit+0x10f>
  outb(COM1+4, 0);
  outb(COM1+1, 0x01);    // Enable receive interrupts.

  // If status is 0xFF, no serial port.
  if(inb(COM1+5) == 0xFF)
    return;
801074aa:	90                   	nop
  ioapicenable(IRQ_COM1, 0);
  
  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
    uartputc(*p);
}
801074ab:	c9                   	leave  
801074ac:	c3                   	ret    

801074ad <uartputc>:

void
uartputc(int c)
{
801074ad:	55                   	push   %ebp
801074ae:	89 e5                	mov    %esp,%ebp
801074b0:	83 ec 28             	sub    $0x28,%esp
  int i;

  if(!uart)
801074b3:	a1 a4 ce 10 80       	mov    0x8010cea4,%eax
801074b8:	85 c0                	test   %eax,%eax
801074ba:	74 4d                	je     80107509 <uartputc+0x5c>
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
801074bc:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801074c3:	eb 10                	jmp    801074d5 <uartputc+0x28>
    microdelay(10);
801074c5:	c7 04 24 0a 00 00 00 	movl   $0xa,(%esp)
801074cc:	e8 35 bf ff ff       	call   80103406 <microdelay>
{
  int i;

  if(!uart)
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
801074d1:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801074d5:	83 7d f4 7f          	cmpl   $0x7f,-0xc(%ebp)
801074d9:	7f 16                	jg     801074f1 <uartputc+0x44>
801074db:	c7 04 24 fd 03 00 00 	movl   $0x3fd,(%esp)
801074e2:	e8 6d fe ff ff       	call   80107354 <inb>
801074e7:	0f b6 c0             	movzbl %al,%eax
801074ea:	83 e0 20             	and    $0x20,%eax
801074ed:	85 c0                	test   %eax,%eax
801074ef:	74 d4                	je     801074c5 <uartputc+0x18>
    microdelay(10);
  outb(COM1+0, c);
801074f1:	8b 45 08             	mov    0x8(%ebp),%eax
801074f4:	0f b6 c0             	movzbl %al,%eax
801074f7:	89 44 24 04          	mov    %eax,0x4(%esp)
801074fb:	c7 04 24 f8 03 00 00 	movl   $0x3f8,(%esp)
80107502:	e8 77 fe ff ff       	call   8010737e <outb>
80107507:	eb 01                	jmp    8010750a <uartputc+0x5d>
uartputc(int c)
{
  int i;

  if(!uart)
    return;
80107509:	90                   	nop
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
    microdelay(10);
  outb(COM1+0, c);
}
8010750a:	c9                   	leave  
8010750b:	c3                   	ret    

8010750c <uartgetc>:

static int
uartgetc(void)
{
8010750c:	55                   	push   %ebp
8010750d:	89 e5                	mov    %esp,%ebp
8010750f:	83 ec 04             	sub    $0x4,%esp
  if(!uart)
80107512:	a1 a4 ce 10 80       	mov    0x8010cea4,%eax
80107517:	85 c0                	test   %eax,%eax
80107519:	75 07                	jne    80107522 <uartgetc+0x16>
    return -1;
8010751b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107520:	eb 2c                	jmp    8010754e <uartgetc+0x42>
  if(!(inb(COM1+5) & 0x01))
80107522:	c7 04 24 fd 03 00 00 	movl   $0x3fd,(%esp)
80107529:	e8 26 fe ff ff       	call   80107354 <inb>
8010752e:	0f b6 c0             	movzbl %al,%eax
80107531:	83 e0 01             	and    $0x1,%eax
80107534:	85 c0                	test   %eax,%eax
80107536:	75 07                	jne    8010753f <uartgetc+0x33>
    return -1;
80107538:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010753d:	eb 0f                	jmp    8010754e <uartgetc+0x42>
  return inb(COM1+0);
8010753f:	c7 04 24 f8 03 00 00 	movl   $0x3f8,(%esp)
80107546:	e8 09 fe ff ff       	call   80107354 <inb>
8010754b:	0f b6 c0             	movzbl %al,%eax
}
8010754e:	c9                   	leave  
8010754f:	c3                   	ret    

80107550 <uartintr>:

void
uartintr(void)
{
80107550:	55                   	push   %ebp
80107551:	89 e5                	mov    %esp,%ebp
80107553:	83 ec 18             	sub    $0x18,%esp
  consoleintr(uartgetc);
80107556:	c7 04 24 0c 75 10 80 	movl   $0x8010750c,(%esp)
8010755d:	e8 59 93 ff ff       	call   801008bb <consoleintr>
}
80107562:	c9                   	leave  
80107563:	c3                   	ret    

80107564 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
80107564:	6a 00                	push   $0x0
  pushl $0
80107566:	6a 00                	push   $0x0
  jmp alltraps
80107568:	e9 4f f9 ff ff       	jmp    80106ebc <alltraps>

8010756d <vector1>:
.globl vector1
vector1:
  pushl $0
8010756d:	6a 00                	push   $0x0
  pushl $1
8010756f:	6a 01                	push   $0x1
  jmp alltraps
80107571:	e9 46 f9 ff ff       	jmp    80106ebc <alltraps>

80107576 <vector2>:
.globl vector2
vector2:
  pushl $0
80107576:	6a 00                	push   $0x0
  pushl $2
80107578:	6a 02                	push   $0x2
  jmp alltraps
8010757a:	e9 3d f9 ff ff       	jmp    80106ebc <alltraps>

8010757f <vector3>:
.globl vector3
vector3:
  pushl $0
8010757f:	6a 00                	push   $0x0
  pushl $3
80107581:	6a 03                	push   $0x3
  jmp alltraps
80107583:	e9 34 f9 ff ff       	jmp    80106ebc <alltraps>

80107588 <vector4>:
.globl vector4
vector4:
  pushl $0
80107588:	6a 00                	push   $0x0
  pushl $4
8010758a:	6a 04                	push   $0x4
  jmp alltraps
8010758c:	e9 2b f9 ff ff       	jmp    80106ebc <alltraps>

80107591 <vector5>:
.globl vector5
vector5:
  pushl $0
80107591:	6a 00                	push   $0x0
  pushl $5
80107593:	6a 05                	push   $0x5
  jmp alltraps
80107595:	e9 22 f9 ff ff       	jmp    80106ebc <alltraps>

8010759a <vector6>:
.globl vector6
vector6:
  pushl $0
8010759a:	6a 00                	push   $0x0
  pushl $6
8010759c:	6a 06                	push   $0x6
  jmp alltraps
8010759e:	e9 19 f9 ff ff       	jmp    80106ebc <alltraps>

801075a3 <vector7>:
.globl vector7
vector7:
  pushl $0
801075a3:	6a 00                	push   $0x0
  pushl $7
801075a5:	6a 07                	push   $0x7
  jmp alltraps
801075a7:	e9 10 f9 ff ff       	jmp    80106ebc <alltraps>

801075ac <vector8>:
.globl vector8
vector8:
  pushl $8
801075ac:	6a 08                	push   $0x8
  jmp alltraps
801075ae:	e9 09 f9 ff ff       	jmp    80106ebc <alltraps>

801075b3 <vector9>:
.globl vector9
vector9:
  pushl $0
801075b3:	6a 00                	push   $0x0
  pushl $9
801075b5:	6a 09                	push   $0x9
  jmp alltraps
801075b7:	e9 00 f9 ff ff       	jmp    80106ebc <alltraps>

801075bc <vector10>:
.globl vector10
vector10:
  pushl $10
801075bc:	6a 0a                	push   $0xa
  jmp alltraps
801075be:	e9 f9 f8 ff ff       	jmp    80106ebc <alltraps>

801075c3 <vector11>:
.globl vector11
vector11:
  pushl $11
801075c3:	6a 0b                	push   $0xb
  jmp alltraps
801075c5:	e9 f2 f8 ff ff       	jmp    80106ebc <alltraps>

801075ca <vector12>:
.globl vector12
vector12:
  pushl $12
801075ca:	6a 0c                	push   $0xc
  jmp alltraps
801075cc:	e9 eb f8 ff ff       	jmp    80106ebc <alltraps>

801075d1 <vector13>:
.globl vector13
vector13:
  pushl $13
801075d1:	6a 0d                	push   $0xd
  jmp alltraps
801075d3:	e9 e4 f8 ff ff       	jmp    80106ebc <alltraps>

801075d8 <vector14>:
.globl vector14
vector14:
  pushl $14
801075d8:	6a 0e                	push   $0xe
  jmp alltraps
801075da:	e9 dd f8 ff ff       	jmp    80106ebc <alltraps>

801075df <vector15>:
.globl vector15
vector15:
  pushl $0
801075df:	6a 00                	push   $0x0
  pushl $15
801075e1:	6a 0f                	push   $0xf
  jmp alltraps
801075e3:	e9 d4 f8 ff ff       	jmp    80106ebc <alltraps>

801075e8 <vector16>:
.globl vector16
vector16:
  pushl $0
801075e8:	6a 00                	push   $0x0
  pushl $16
801075ea:	6a 10                	push   $0x10
  jmp alltraps
801075ec:	e9 cb f8 ff ff       	jmp    80106ebc <alltraps>

801075f1 <vector17>:
.globl vector17
vector17:
  pushl $17
801075f1:	6a 11                	push   $0x11
  jmp alltraps
801075f3:	e9 c4 f8 ff ff       	jmp    80106ebc <alltraps>

801075f8 <vector18>:
.globl vector18
vector18:
  pushl $0
801075f8:	6a 00                	push   $0x0
  pushl $18
801075fa:	6a 12                	push   $0x12
  jmp alltraps
801075fc:	e9 bb f8 ff ff       	jmp    80106ebc <alltraps>

80107601 <vector19>:
.globl vector19
vector19:
  pushl $0
80107601:	6a 00                	push   $0x0
  pushl $19
80107603:	6a 13                	push   $0x13
  jmp alltraps
80107605:	e9 b2 f8 ff ff       	jmp    80106ebc <alltraps>

8010760a <vector20>:
.globl vector20
vector20:
  pushl $0
8010760a:	6a 00                	push   $0x0
  pushl $20
8010760c:	6a 14                	push   $0x14
  jmp alltraps
8010760e:	e9 a9 f8 ff ff       	jmp    80106ebc <alltraps>

80107613 <vector21>:
.globl vector21
vector21:
  pushl $0
80107613:	6a 00                	push   $0x0
  pushl $21
80107615:	6a 15                	push   $0x15
  jmp alltraps
80107617:	e9 a0 f8 ff ff       	jmp    80106ebc <alltraps>

8010761c <vector22>:
.globl vector22
vector22:
  pushl $0
8010761c:	6a 00                	push   $0x0
  pushl $22
8010761e:	6a 16                	push   $0x16
  jmp alltraps
80107620:	e9 97 f8 ff ff       	jmp    80106ebc <alltraps>

80107625 <vector23>:
.globl vector23
vector23:
  pushl $0
80107625:	6a 00                	push   $0x0
  pushl $23
80107627:	6a 17                	push   $0x17
  jmp alltraps
80107629:	e9 8e f8 ff ff       	jmp    80106ebc <alltraps>

8010762e <vector24>:
.globl vector24
vector24:
  pushl $0
8010762e:	6a 00                	push   $0x0
  pushl $24
80107630:	6a 18                	push   $0x18
  jmp alltraps
80107632:	e9 85 f8 ff ff       	jmp    80106ebc <alltraps>

80107637 <vector25>:
.globl vector25
vector25:
  pushl $0
80107637:	6a 00                	push   $0x0
  pushl $25
80107639:	6a 19                	push   $0x19
  jmp alltraps
8010763b:	e9 7c f8 ff ff       	jmp    80106ebc <alltraps>

80107640 <vector26>:
.globl vector26
vector26:
  pushl $0
80107640:	6a 00                	push   $0x0
  pushl $26
80107642:	6a 1a                	push   $0x1a
  jmp alltraps
80107644:	e9 73 f8 ff ff       	jmp    80106ebc <alltraps>

80107649 <vector27>:
.globl vector27
vector27:
  pushl $0
80107649:	6a 00                	push   $0x0
  pushl $27
8010764b:	6a 1b                	push   $0x1b
  jmp alltraps
8010764d:	e9 6a f8 ff ff       	jmp    80106ebc <alltraps>

80107652 <vector28>:
.globl vector28
vector28:
  pushl $0
80107652:	6a 00                	push   $0x0
  pushl $28
80107654:	6a 1c                	push   $0x1c
  jmp alltraps
80107656:	e9 61 f8 ff ff       	jmp    80106ebc <alltraps>

8010765b <vector29>:
.globl vector29
vector29:
  pushl $0
8010765b:	6a 00                	push   $0x0
  pushl $29
8010765d:	6a 1d                	push   $0x1d
  jmp alltraps
8010765f:	e9 58 f8 ff ff       	jmp    80106ebc <alltraps>

80107664 <vector30>:
.globl vector30
vector30:
  pushl $0
80107664:	6a 00                	push   $0x0
  pushl $30
80107666:	6a 1e                	push   $0x1e
  jmp alltraps
80107668:	e9 4f f8 ff ff       	jmp    80106ebc <alltraps>

8010766d <vector31>:
.globl vector31
vector31:
  pushl $0
8010766d:	6a 00                	push   $0x0
  pushl $31
8010766f:	6a 1f                	push   $0x1f
  jmp alltraps
80107671:	e9 46 f8 ff ff       	jmp    80106ebc <alltraps>

80107676 <vector32>:
.globl vector32
vector32:
  pushl $0
80107676:	6a 00                	push   $0x0
  pushl $32
80107678:	6a 20                	push   $0x20
  jmp alltraps
8010767a:	e9 3d f8 ff ff       	jmp    80106ebc <alltraps>

8010767f <vector33>:
.globl vector33
vector33:
  pushl $0
8010767f:	6a 00                	push   $0x0
  pushl $33
80107681:	6a 21                	push   $0x21
  jmp alltraps
80107683:	e9 34 f8 ff ff       	jmp    80106ebc <alltraps>

80107688 <vector34>:
.globl vector34
vector34:
  pushl $0
80107688:	6a 00                	push   $0x0
  pushl $34
8010768a:	6a 22                	push   $0x22
  jmp alltraps
8010768c:	e9 2b f8 ff ff       	jmp    80106ebc <alltraps>

80107691 <vector35>:
.globl vector35
vector35:
  pushl $0
80107691:	6a 00                	push   $0x0
  pushl $35
80107693:	6a 23                	push   $0x23
  jmp alltraps
80107695:	e9 22 f8 ff ff       	jmp    80106ebc <alltraps>

8010769a <vector36>:
.globl vector36
vector36:
  pushl $0
8010769a:	6a 00                	push   $0x0
  pushl $36
8010769c:	6a 24                	push   $0x24
  jmp alltraps
8010769e:	e9 19 f8 ff ff       	jmp    80106ebc <alltraps>

801076a3 <vector37>:
.globl vector37
vector37:
  pushl $0
801076a3:	6a 00                	push   $0x0
  pushl $37
801076a5:	6a 25                	push   $0x25
  jmp alltraps
801076a7:	e9 10 f8 ff ff       	jmp    80106ebc <alltraps>

801076ac <vector38>:
.globl vector38
vector38:
  pushl $0
801076ac:	6a 00                	push   $0x0
  pushl $38
801076ae:	6a 26                	push   $0x26
  jmp alltraps
801076b0:	e9 07 f8 ff ff       	jmp    80106ebc <alltraps>

801076b5 <vector39>:
.globl vector39
vector39:
  pushl $0
801076b5:	6a 00                	push   $0x0
  pushl $39
801076b7:	6a 27                	push   $0x27
  jmp alltraps
801076b9:	e9 fe f7 ff ff       	jmp    80106ebc <alltraps>

801076be <vector40>:
.globl vector40
vector40:
  pushl $0
801076be:	6a 00                	push   $0x0
  pushl $40
801076c0:	6a 28                	push   $0x28
  jmp alltraps
801076c2:	e9 f5 f7 ff ff       	jmp    80106ebc <alltraps>

801076c7 <vector41>:
.globl vector41
vector41:
  pushl $0
801076c7:	6a 00                	push   $0x0
  pushl $41
801076c9:	6a 29                	push   $0x29
  jmp alltraps
801076cb:	e9 ec f7 ff ff       	jmp    80106ebc <alltraps>

801076d0 <vector42>:
.globl vector42
vector42:
  pushl $0
801076d0:	6a 00                	push   $0x0
  pushl $42
801076d2:	6a 2a                	push   $0x2a
  jmp alltraps
801076d4:	e9 e3 f7 ff ff       	jmp    80106ebc <alltraps>

801076d9 <vector43>:
.globl vector43
vector43:
  pushl $0
801076d9:	6a 00                	push   $0x0
  pushl $43
801076db:	6a 2b                	push   $0x2b
  jmp alltraps
801076dd:	e9 da f7 ff ff       	jmp    80106ebc <alltraps>

801076e2 <vector44>:
.globl vector44
vector44:
  pushl $0
801076e2:	6a 00                	push   $0x0
  pushl $44
801076e4:	6a 2c                	push   $0x2c
  jmp alltraps
801076e6:	e9 d1 f7 ff ff       	jmp    80106ebc <alltraps>

801076eb <vector45>:
.globl vector45
vector45:
  pushl $0
801076eb:	6a 00                	push   $0x0
  pushl $45
801076ed:	6a 2d                	push   $0x2d
  jmp alltraps
801076ef:	e9 c8 f7 ff ff       	jmp    80106ebc <alltraps>

801076f4 <vector46>:
.globl vector46
vector46:
  pushl $0
801076f4:	6a 00                	push   $0x0
  pushl $46
801076f6:	6a 2e                	push   $0x2e
  jmp alltraps
801076f8:	e9 bf f7 ff ff       	jmp    80106ebc <alltraps>

801076fd <vector47>:
.globl vector47
vector47:
  pushl $0
801076fd:	6a 00                	push   $0x0
  pushl $47
801076ff:	6a 2f                	push   $0x2f
  jmp alltraps
80107701:	e9 b6 f7 ff ff       	jmp    80106ebc <alltraps>

80107706 <vector48>:
.globl vector48
vector48:
  pushl $0
80107706:	6a 00                	push   $0x0
  pushl $48
80107708:	6a 30                	push   $0x30
  jmp alltraps
8010770a:	e9 ad f7 ff ff       	jmp    80106ebc <alltraps>

8010770f <vector49>:
.globl vector49
vector49:
  pushl $0
8010770f:	6a 00                	push   $0x0
  pushl $49
80107711:	6a 31                	push   $0x31
  jmp alltraps
80107713:	e9 a4 f7 ff ff       	jmp    80106ebc <alltraps>

80107718 <vector50>:
.globl vector50
vector50:
  pushl $0
80107718:	6a 00                	push   $0x0
  pushl $50
8010771a:	6a 32                	push   $0x32
  jmp alltraps
8010771c:	e9 9b f7 ff ff       	jmp    80106ebc <alltraps>

80107721 <vector51>:
.globl vector51
vector51:
  pushl $0
80107721:	6a 00                	push   $0x0
  pushl $51
80107723:	6a 33                	push   $0x33
  jmp alltraps
80107725:	e9 92 f7 ff ff       	jmp    80106ebc <alltraps>

8010772a <vector52>:
.globl vector52
vector52:
  pushl $0
8010772a:	6a 00                	push   $0x0
  pushl $52
8010772c:	6a 34                	push   $0x34
  jmp alltraps
8010772e:	e9 89 f7 ff ff       	jmp    80106ebc <alltraps>

80107733 <vector53>:
.globl vector53
vector53:
  pushl $0
80107733:	6a 00                	push   $0x0
  pushl $53
80107735:	6a 35                	push   $0x35
  jmp alltraps
80107737:	e9 80 f7 ff ff       	jmp    80106ebc <alltraps>

8010773c <vector54>:
.globl vector54
vector54:
  pushl $0
8010773c:	6a 00                	push   $0x0
  pushl $54
8010773e:	6a 36                	push   $0x36
  jmp alltraps
80107740:	e9 77 f7 ff ff       	jmp    80106ebc <alltraps>

80107745 <vector55>:
.globl vector55
vector55:
  pushl $0
80107745:	6a 00                	push   $0x0
  pushl $55
80107747:	6a 37                	push   $0x37
  jmp alltraps
80107749:	e9 6e f7 ff ff       	jmp    80106ebc <alltraps>

8010774e <vector56>:
.globl vector56
vector56:
  pushl $0
8010774e:	6a 00                	push   $0x0
  pushl $56
80107750:	6a 38                	push   $0x38
  jmp alltraps
80107752:	e9 65 f7 ff ff       	jmp    80106ebc <alltraps>

80107757 <vector57>:
.globl vector57
vector57:
  pushl $0
80107757:	6a 00                	push   $0x0
  pushl $57
80107759:	6a 39                	push   $0x39
  jmp alltraps
8010775b:	e9 5c f7 ff ff       	jmp    80106ebc <alltraps>

80107760 <vector58>:
.globl vector58
vector58:
  pushl $0
80107760:	6a 00                	push   $0x0
  pushl $58
80107762:	6a 3a                	push   $0x3a
  jmp alltraps
80107764:	e9 53 f7 ff ff       	jmp    80106ebc <alltraps>

80107769 <vector59>:
.globl vector59
vector59:
  pushl $0
80107769:	6a 00                	push   $0x0
  pushl $59
8010776b:	6a 3b                	push   $0x3b
  jmp alltraps
8010776d:	e9 4a f7 ff ff       	jmp    80106ebc <alltraps>

80107772 <vector60>:
.globl vector60
vector60:
  pushl $0
80107772:	6a 00                	push   $0x0
  pushl $60
80107774:	6a 3c                	push   $0x3c
  jmp alltraps
80107776:	e9 41 f7 ff ff       	jmp    80106ebc <alltraps>

8010777b <vector61>:
.globl vector61
vector61:
  pushl $0
8010777b:	6a 00                	push   $0x0
  pushl $61
8010777d:	6a 3d                	push   $0x3d
  jmp alltraps
8010777f:	e9 38 f7 ff ff       	jmp    80106ebc <alltraps>

80107784 <vector62>:
.globl vector62
vector62:
  pushl $0
80107784:	6a 00                	push   $0x0
  pushl $62
80107786:	6a 3e                	push   $0x3e
  jmp alltraps
80107788:	e9 2f f7 ff ff       	jmp    80106ebc <alltraps>

8010778d <vector63>:
.globl vector63
vector63:
  pushl $0
8010778d:	6a 00                	push   $0x0
  pushl $63
8010778f:	6a 3f                	push   $0x3f
  jmp alltraps
80107791:	e9 26 f7 ff ff       	jmp    80106ebc <alltraps>

80107796 <vector64>:
.globl vector64
vector64:
  pushl $0
80107796:	6a 00                	push   $0x0
  pushl $64
80107798:	6a 40                	push   $0x40
  jmp alltraps
8010779a:	e9 1d f7 ff ff       	jmp    80106ebc <alltraps>

8010779f <vector65>:
.globl vector65
vector65:
  pushl $0
8010779f:	6a 00                	push   $0x0
  pushl $65
801077a1:	6a 41                	push   $0x41
  jmp alltraps
801077a3:	e9 14 f7 ff ff       	jmp    80106ebc <alltraps>

801077a8 <vector66>:
.globl vector66
vector66:
  pushl $0
801077a8:	6a 00                	push   $0x0
  pushl $66
801077aa:	6a 42                	push   $0x42
  jmp alltraps
801077ac:	e9 0b f7 ff ff       	jmp    80106ebc <alltraps>

801077b1 <vector67>:
.globl vector67
vector67:
  pushl $0
801077b1:	6a 00                	push   $0x0
  pushl $67
801077b3:	6a 43                	push   $0x43
  jmp alltraps
801077b5:	e9 02 f7 ff ff       	jmp    80106ebc <alltraps>

801077ba <vector68>:
.globl vector68
vector68:
  pushl $0
801077ba:	6a 00                	push   $0x0
  pushl $68
801077bc:	6a 44                	push   $0x44
  jmp alltraps
801077be:	e9 f9 f6 ff ff       	jmp    80106ebc <alltraps>

801077c3 <vector69>:
.globl vector69
vector69:
  pushl $0
801077c3:	6a 00                	push   $0x0
  pushl $69
801077c5:	6a 45                	push   $0x45
  jmp alltraps
801077c7:	e9 f0 f6 ff ff       	jmp    80106ebc <alltraps>

801077cc <vector70>:
.globl vector70
vector70:
  pushl $0
801077cc:	6a 00                	push   $0x0
  pushl $70
801077ce:	6a 46                	push   $0x46
  jmp alltraps
801077d0:	e9 e7 f6 ff ff       	jmp    80106ebc <alltraps>

801077d5 <vector71>:
.globl vector71
vector71:
  pushl $0
801077d5:	6a 00                	push   $0x0
  pushl $71
801077d7:	6a 47                	push   $0x47
  jmp alltraps
801077d9:	e9 de f6 ff ff       	jmp    80106ebc <alltraps>

801077de <vector72>:
.globl vector72
vector72:
  pushl $0
801077de:	6a 00                	push   $0x0
  pushl $72
801077e0:	6a 48                	push   $0x48
  jmp alltraps
801077e2:	e9 d5 f6 ff ff       	jmp    80106ebc <alltraps>

801077e7 <vector73>:
.globl vector73
vector73:
  pushl $0
801077e7:	6a 00                	push   $0x0
  pushl $73
801077e9:	6a 49                	push   $0x49
  jmp alltraps
801077eb:	e9 cc f6 ff ff       	jmp    80106ebc <alltraps>

801077f0 <vector74>:
.globl vector74
vector74:
  pushl $0
801077f0:	6a 00                	push   $0x0
  pushl $74
801077f2:	6a 4a                	push   $0x4a
  jmp alltraps
801077f4:	e9 c3 f6 ff ff       	jmp    80106ebc <alltraps>

801077f9 <vector75>:
.globl vector75
vector75:
  pushl $0
801077f9:	6a 00                	push   $0x0
  pushl $75
801077fb:	6a 4b                	push   $0x4b
  jmp alltraps
801077fd:	e9 ba f6 ff ff       	jmp    80106ebc <alltraps>

80107802 <vector76>:
.globl vector76
vector76:
  pushl $0
80107802:	6a 00                	push   $0x0
  pushl $76
80107804:	6a 4c                	push   $0x4c
  jmp alltraps
80107806:	e9 b1 f6 ff ff       	jmp    80106ebc <alltraps>

8010780b <vector77>:
.globl vector77
vector77:
  pushl $0
8010780b:	6a 00                	push   $0x0
  pushl $77
8010780d:	6a 4d                	push   $0x4d
  jmp alltraps
8010780f:	e9 a8 f6 ff ff       	jmp    80106ebc <alltraps>

80107814 <vector78>:
.globl vector78
vector78:
  pushl $0
80107814:	6a 00                	push   $0x0
  pushl $78
80107816:	6a 4e                	push   $0x4e
  jmp alltraps
80107818:	e9 9f f6 ff ff       	jmp    80106ebc <alltraps>

8010781d <vector79>:
.globl vector79
vector79:
  pushl $0
8010781d:	6a 00                	push   $0x0
  pushl $79
8010781f:	6a 4f                	push   $0x4f
  jmp alltraps
80107821:	e9 96 f6 ff ff       	jmp    80106ebc <alltraps>

80107826 <vector80>:
.globl vector80
vector80:
  pushl $0
80107826:	6a 00                	push   $0x0
  pushl $80
80107828:	6a 50                	push   $0x50
  jmp alltraps
8010782a:	e9 8d f6 ff ff       	jmp    80106ebc <alltraps>

8010782f <vector81>:
.globl vector81
vector81:
  pushl $0
8010782f:	6a 00                	push   $0x0
  pushl $81
80107831:	6a 51                	push   $0x51
  jmp alltraps
80107833:	e9 84 f6 ff ff       	jmp    80106ebc <alltraps>

80107838 <vector82>:
.globl vector82
vector82:
  pushl $0
80107838:	6a 00                	push   $0x0
  pushl $82
8010783a:	6a 52                	push   $0x52
  jmp alltraps
8010783c:	e9 7b f6 ff ff       	jmp    80106ebc <alltraps>

80107841 <vector83>:
.globl vector83
vector83:
  pushl $0
80107841:	6a 00                	push   $0x0
  pushl $83
80107843:	6a 53                	push   $0x53
  jmp alltraps
80107845:	e9 72 f6 ff ff       	jmp    80106ebc <alltraps>

8010784a <vector84>:
.globl vector84
vector84:
  pushl $0
8010784a:	6a 00                	push   $0x0
  pushl $84
8010784c:	6a 54                	push   $0x54
  jmp alltraps
8010784e:	e9 69 f6 ff ff       	jmp    80106ebc <alltraps>

80107853 <vector85>:
.globl vector85
vector85:
  pushl $0
80107853:	6a 00                	push   $0x0
  pushl $85
80107855:	6a 55                	push   $0x55
  jmp alltraps
80107857:	e9 60 f6 ff ff       	jmp    80106ebc <alltraps>

8010785c <vector86>:
.globl vector86
vector86:
  pushl $0
8010785c:	6a 00                	push   $0x0
  pushl $86
8010785e:	6a 56                	push   $0x56
  jmp alltraps
80107860:	e9 57 f6 ff ff       	jmp    80106ebc <alltraps>

80107865 <vector87>:
.globl vector87
vector87:
  pushl $0
80107865:	6a 00                	push   $0x0
  pushl $87
80107867:	6a 57                	push   $0x57
  jmp alltraps
80107869:	e9 4e f6 ff ff       	jmp    80106ebc <alltraps>

8010786e <vector88>:
.globl vector88
vector88:
  pushl $0
8010786e:	6a 00                	push   $0x0
  pushl $88
80107870:	6a 58                	push   $0x58
  jmp alltraps
80107872:	e9 45 f6 ff ff       	jmp    80106ebc <alltraps>

80107877 <vector89>:
.globl vector89
vector89:
  pushl $0
80107877:	6a 00                	push   $0x0
  pushl $89
80107879:	6a 59                	push   $0x59
  jmp alltraps
8010787b:	e9 3c f6 ff ff       	jmp    80106ebc <alltraps>

80107880 <vector90>:
.globl vector90
vector90:
  pushl $0
80107880:	6a 00                	push   $0x0
  pushl $90
80107882:	6a 5a                	push   $0x5a
  jmp alltraps
80107884:	e9 33 f6 ff ff       	jmp    80106ebc <alltraps>

80107889 <vector91>:
.globl vector91
vector91:
  pushl $0
80107889:	6a 00                	push   $0x0
  pushl $91
8010788b:	6a 5b                	push   $0x5b
  jmp alltraps
8010788d:	e9 2a f6 ff ff       	jmp    80106ebc <alltraps>

80107892 <vector92>:
.globl vector92
vector92:
  pushl $0
80107892:	6a 00                	push   $0x0
  pushl $92
80107894:	6a 5c                	push   $0x5c
  jmp alltraps
80107896:	e9 21 f6 ff ff       	jmp    80106ebc <alltraps>

8010789b <vector93>:
.globl vector93
vector93:
  pushl $0
8010789b:	6a 00                	push   $0x0
  pushl $93
8010789d:	6a 5d                	push   $0x5d
  jmp alltraps
8010789f:	e9 18 f6 ff ff       	jmp    80106ebc <alltraps>

801078a4 <vector94>:
.globl vector94
vector94:
  pushl $0
801078a4:	6a 00                	push   $0x0
  pushl $94
801078a6:	6a 5e                	push   $0x5e
  jmp alltraps
801078a8:	e9 0f f6 ff ff       	jmp    80106ebc <alltraps>

801078ad <vector95>:
.globl vector95
vector95:
  pushl $0
801078ad:	6a 00                	push   $0x0
  pushl $95
801078af:	6a 5f                	push   $0x5f
  jmp alltraps
801078b1:	e9 06 f6 ff ff       	jmp    80106ebc <alltraps>

801078b6 <vector96>:
.globl vector96
vector96:
  pushl $0
801078b6:	6a 00                	push   $0x0
  pushl $96
801078b8:	6a 60                	push   $0x60
  jmp alltraps
801078ba:	e9 fd f5 ff ff       	jmp    80106ebc <alltraps>

801078bf <vector97>:
.globl vector97
vector97:
  pushl $0
801078bf:	6a 00                	push   $0x0
  pushl $97
801078c1:	6a 61                	push   $0x61
  jmp alltraps
801078c3:	e9 f4 f5 ff ff       	jmp    80106ebc <alltraps>

801078c8 <vector98>:
.globl vector98
vector98:
  pushl $0
801078c8:	6a 00                	push   $0x0
  pushl $98
801078ca:	6a 62                	push   $0x62
  jmp alltraps
801078cc:	e9 eb f5 ff ff       	jmp    80106ebc <alltraps>

801078d1 <vector99>:
.globl vector99
vector99:
  pushl $0
801078d1:	6a 00                	push   $0x0
  pushl $99
801078d3:	6a 63                	push   $0x63
  jmp alltraps
801078d5:	e9 e2 f5 ff ff       	jmp    80106ebc <alltraps>

801078da <vector100>:
.globl vector100
vector100:
  pushl $0
801078da:	6a 00                	push   $0x0
  pushl $100
801078dc:	6a 64                	push   $0x64
  jmp alltraps
801078de:	e9 d9 f5 ff ff       	jmp    80106ebc <alltraps>

801078e3 <vector101>:
.globl vector101
vector101:
  pushl $0
801078e3:	6a 00                	push   $0x0
  pushl $101
801078e5:	6a 65                	push   $0x65
  jmp alltraps
801078e7:	e9 d0 f5 ff ff       	jmp    80106ebc <alltraps>

801078ec <vector102>:
.globl vector102
vector102:
  pushl $0
801078ec:	6a 00                	push   $0x0
  pushl $102
801078ee:	6a 66                	push   $0x66
  jmp alltraps
801078f0:	e9 c7 f5 ff ff       	jmp    80106ebc <alltraps>

801078f5 <vector103>:
.globl vector103
vector103:
  pushl $0
801078f5:	6a 00                	push   $0x0
  pushl $103
801078f7:	6a 67                	push   $0x67
  jmp alltraps
801078f9:	e9 be f5 ff ff       	jmp    80106ebc <alltraps>

801078fe <vector104>:
.globl vector104
vector104:
  pushl $0
801078fe:	6a 00                	push   $0x0
  pushl $104
80107900:	6a 68                	push   $0x68
  jmp alltraps
80107902:	e9 b5 f5 ff ff       	jmp    80106ebc <alltraps>

80107907 <vector105>:
.globl vector105
vector105:
  pushl $0
80107907:	6a 00                	push   $0x0
  pushl $105
80107909:	6a 69                	push   $0x69
  jmp alltraps
8010790b:	e9 ac f5 ff ff       	jmp    80106ebc <alltraps>

80107910 <vector106>:
.globl vector106
vector106:
  pushl $0
80107910:	6a 00                	push   $0x0
  pushl $106
80107912:	6a 6a                	push   $0x6a
  jmp alltraps
80107914:	e9 a3 f5 ff ff       	jmp    80106ebc <alltraps>

80107919 <vector107>:
.globl vector107
vector107:
  pushl $0
80107919:	6a 00                	push   $0x0
  pushl $107
8010791b:	6a 6b                	push   $0x6b
  jmp alltraps
8010791d:	e9 9a f5 ff ff       	jmp    80106ebc <alltraps>

80107922 <vector108>:
.globl vector108
vector108:
  pushl $0
80107922:	6a 00                	push   $0x0
  pushl $108
80107924:	6a 6c                	push   $0x6c
  jmp alltraps
80107926:	e9 91 f5 ff ff       	jmp    80106ebc <alltraps>

8010792b <vector109>:
.globl vector109
vector109:
  pushl $0
8010792b:	6a 00                	push   $0x0
  pushl $109
8010792d:	6a 6d                	push   $0x6d
  jmp alltraps
8010792f:	e9 88 f5 ff ff       	jmp    80106ebc <alltraps>

80107934 <vector110>:
.globl vector110
vector110:
  pushl $0
80107934:	6a 00                	push   $0x0
  pushl $110
80107936:	6a 6e                	push   $0x6e
  jmp alltraps
80107938:	e9 7f f5 ff ff       	jmp    80106ebc <alltraps>

8010793d <vector111>:
.globl vector111
vector111:
  pushl $0
8010793d:	6a 00                	push   $0x0
  pushl $111
8010793f:	6a 6f                	push   $0x6f
  jmp alltraps
80107941:	e9 76 f5 ff ff       	jmp    80106ebc <alltraps>

80107946 <vector112>:
.globl vector112
vector112:
  pushl $0
80107946:	6a 00                	push   $0x0
  pushl $112
80107948:	6a 70                	push   $0x70
  jmp alltraps
8010794a:	e9 6d f5 ff ff       	jmp    80106ebc <alltraps>

8010794f <vector113>:
.globl vector113
vector113:
  pushl $0
8010794f:	6a 00                	push   $0x0
  pushl $113
80107951:	6a 71                	push   $0x71
  jmp alltraps
80107953:	e9 64 f5 ff ff       	jmp    80106ebc <alltraps>

80107958 <vector114>:
.globl vector114
vector114:
  pushl $0
80107958:	6a 00                	push   $0x0
  pushl $114
8010795a:	6a 72                	push   $0x72
  jmp alltraps
8010795c:	e9 5b f5 ff ff       	jmp    80106ebc <alltraps>

80107961 <vector115>:
.globl vector115
vector115:
  pushl $0
80107961:	6a 00                	push   $0x0
  pushl $115
80107963:	6a 73                	push   $0x73
  jmp alltraps
80107965:	e9 52 f5 ff ff       	jmp    80106ebc <alltraps>

8010796a <vector116>:
.globl vector116
vector116:
  pushl $0
8010796a:	6a 00                	push   $0x0
  pushl $116
8010796c:	6a 74                	push   $0x74
  jmp alltraps
8010796e:	e9 49 f5 ff ff       	jmp    80106ebc <alltraps>

80107973 <vector117>:
.globl vector117
vector117:
  pushl $0
80107973:	6a 00                	push   $0x0
  pushl $117
80107975:	6a 75                	push   $0x75
  jmp alltraps
80107977:	e9 40 f5 ff ff       	jmp    80106ebc <alltraps>

8010797c <vector118>:
.globl vector118
vector118:
  pushl $0
8010797c:	6a 00                	push   $0x0
  pushl $118
8010797e:	6a 76                	push   $0x76
  jmp alltraps
80107980:	e9 37 f5 ff ff       	jmp    80106ebc <alltraps>

80107985 <vector119>:
.globl vector119
vector119:
  pushl $0
80107985:	6a 00                	push   $0x0
  pushl $119
80107987:	6a 77                	push   $0x77
  jmp alltraps
80107989:	e9 2e f5 ff ff       	jmp    80106ebc <alltraps>

8010798e <vector120>:
.globl vector120
vector120:
  pushl $0
8010798e:	6a 00                	push   $0x0
  pushl $120
80107990:	6a 78                	push   $0x78
  jmp alltraps
80107992:	e9 25 f5 ff ff       	jmp    80106ebc <alltraps>

80107997 <vector121>:
.globl vector121
vector121:
  pushl $0
80107997:	6a 00                	push   $0x0
  pushl $121
80107999:	6a 79                	push   $0x79
  jmp alltraps
8010799b:	e9 1c f5 ff ff       	jmp    80106ebc <alltraps>

801079a0 <vector122>:
.globl vector122
vector122:
  pushl $0
801079a0:	6a 00                	push   $0x0
  pushl $122
801079a2:	6a 7a                	push   $0x7a
  jmp alltraps
801079a4:	e9 13 f5 ff ff       	jmp    80106ebc <alltraps>

801079a9 <vector123>:
.globl vector123
vector123:
  pushl $0
801079a9:	6a 00                	push   $0x0
  pushl $123
801079ab:	6a 7b                	push   $0x7b
  jmp alltraps
801079ad:	e9 0a f5 ff ff       	jmp    80106ebc <alltraps>

801079b2 <vector124>:
.globl vector124
vector124:
  pushl $0
801079b2:	6a 00                	push   $0x0
  pushl $124
801079b4:	6a 7c                	push   $0x7c
  jmp alltraps
801079b6:	e9 01 f5 ff ff       	jmp    80106ebc <alltraps>

801079bb <vector125>:
.globl vector125
vector125:
  pushl $0
801079bb:	6a 00                	push   $0x0
  pushl $125
801079bd:	6a 7d                	push   $0x7d
  jmp alltraps
801079bf:	e9 f8 f4 ff ff       	jmp    80106ebc <alltraps>

801079c4 <vector126>:
.globl vector126
vector126:
  pushl $0
801079c4:	6a 00                	push   $0x0
  pushl $126
801079c6:	6a 7e                	push   $0x7e
  jmp alltraps
801079c8:	e9 ef f4 ff ff       	jmp    80106ebc <alltraps>

801079cd <vector127>:
.globl vector127
vector127:
  pushl $0
801079cd:	6a 00                	push   $0x0
  pushl $127
801079cf:	6a 7f                	push   $0x7f
  jmp alltraps
801079d1:	e9 e6 f4 ff ff       	jmp    80106ebc <alltraps>

801079d6 <vector128>:
.globl vector128
vector128:
  pushl $0
801079d6:	6a 00                	push   $0x0
  pushl $128
801079d8:	68 80 00 00 00       	push   $0x80
  jmp alltraps
801079dd:	e9 da f4 ff ff       	jmp    80106ebc <alltraps>

801079e2 <vector129>:
.globl vector129
vector129:
  pushl $0
801079e2:	6a 00                	push   $0x0
  pushl $129
801079e4:	68 81 00 00 00       	push   $0x81
  jmp alltraps
801079e9:	e9 ce f4 ff ff       	jmp    80106ebc <alltraps>

801079ee <vector130>:
.globl vector130
vector130:
  pushl $0
801079ee:	6a 00                	push   $0x0
  pushl $130
801079f0:	68 82 00 00 00       	push   $0x82
  jmp alltraps
801079f5:	e9 c2 f4 ff ff       	jmp    80106ebc <alltraps>

801079fa <vector131>:
.globl vector131
vector131:
  pushl $0
801079fa:	6a 00                	push   $0x0
  pushl $131
801079fc:	68 83 00 00 00       	push   $0x83
  jmp alltraps
80107a01:	e9 b6 f4 ff ff       	jmp    80106ebc <alltraps>

80107a06 <vector132>:
.globl vector132
vector132:
  pushl $0
80107a06:	6a 00                	push   $0x0
  pushl $132
80107a08:	68 84 00 00 00       	push   $0x84
  jmp alltraps
80107a0d:	e9 aa f4 ff ff       	jmp    80106ebc <alltraps>

80107a12 <vector133>:
.globl vector133
vector133:
  pushl $0
80107a12:	6a 00                	push   $0x0
  pushl $133
80107a14:	68 85 00 00 00       	push   $0x85
  jmp alltraps
80107a19:	e9 9e f4 ff ff       	jmp    80106ebc <alltraps>

80107a1e <vector134>:
.globl vector134
vector134:
  pushl $0
80107a1e:	6a 00                	push   $0x0
  pushl $134
80107a20:	68 86 00 00 00       	push   $0x86
  jmp alltraps
80107a25:	e9 92 f4 ff ff       	jmp    80106ebc <alltraps>

80107a2a <vector135>:
.globl vector135
vector135:
  pushl $0
80107a2a:	6a 00                	push   $0x0
  pushl $135
80107a2c:	68 87 00 00 00       	push   $0x87
  jmp alltraps
80107a31:	e9 86 f4 ff ff       	jmp    80106ebc <alltraps>

80107a36 <vector136>:
.globl vector136
vector136:
  pushl $0
80107a36:	6a 00                	push   $0x0
  pushl $136
80107a38:	68 88 00 00 00       	push   $0x88
  jmp alltraps
80107a3d:	e9 7a f4 ff ff       	jmp    80106ebc <alltraps>

80107a42 <vector137>:
.globl vector137
vector137:
  pushl $0
80107a42:	6a 00                	push   $0x0
  pushl $137
80107a44:	68 89 00 00 00       	push   $0x89
  jmp alltraps
80107a49:	e9 6e f4 ff ff       	jmp    80106ebc <alltraps>

80107a4e <vector138>:
.globl vector138
vector138:
  pushl $0
80107a4e:	6a 00                	push   $0x0
  pushl $138
80107a50:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
80107a55:	e9 62 f4 ff ff       	jmp    80106ebc <alltraps>

80107a5a <vector139>:
.globl vector139
vector139:
  pushl $0
80107a5a:	6a 00                	push   $0x0
  pushl $139
80107a5c:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
80107a61:	e9 56 f4 ff ff       	jmp    80106ebc <alltraps>

80107a66 <vector140>:
.globl vector140
vector140:
  pushl $0
80107a66:	6a 00                	push   $0x0
  pushl $140
80107a68:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
80107a6d:	e9 4a f4 ff ff       	jmp    80106ebc <alltraps>

80107a72 <vector141>:
.globl vector141
vector141:
  pushl $0
80107a72:	6a 00                	push   $0x0
  pushl $141
80107a74:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
80107a79:	e9 3e f4 ff ff       	jmp    80106ebc <alltraps>

80107a7e <vector142>:
.globl vector142
vector142:
  pushl $0
80107a7e:	6a 00                	push   $0x0
  pushl $142
80107a80:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
80107a85:	e9 32 f4 ff ff       	jmp    80106ebc <alltraps>

80107a8a <vector143>:
.globl vector143
vector143:
  pushl $0
80107a8a:	6a 00                	push   $0x0
  pushl $143
80107a8c:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
80107a91:	e9 26 f4 ff ff       	jmp    80106ebc <alltraps>

80107a96 <vector144>:
.globl vector144
vector144:
  pushl $0
80107a96:	6a 00                	push   $0x0
  pushl $144
80107a98:	68 90 00 00 00       	push   $0x90
  jmp alltraps
80107a9d:	e9 1a f4 ff ff       	jmp    80106ebc <alltraps>

80107aa2 <vector145>:
.globl vector145
vector145:
  pushl $0
80107aa2:	6a 00                	push   $0x0
  pushl $145
80107aa4:	68 91 00 00 00       	push   $0x91
  jmp alltraps
80107aa9:	e9 0e f4 ff ff       	jmp    80106ebc <alltraps>

80107aae <vector146>:
.globl vector146
vector146:
  pushl $0
80107aae:	6a 00                	push   $0x0
  pushl $146
80107ab0:	68 92 00 00 00       	push   $0x92
  jmp alltraps
80107ab5:	e9 02 f4 ff ff       	jmp    80106ebc <alltraps>

80107aba <vector147>:
.globl vector147
vector147:
  pushl $0
80107aba:	6a 00                	push   $0x0
  pushl $147
80107abc:	68 93 00 00 00       	push   $0x93
  jmp alltraps
80107ac1:	e9 f6 f3 ff ff       	jmp    80106ebc <alltraps>

80107ac6 <vector148>:
.globl vector148
vector148:
  pushl $0
80107ac6:	6a 00                	push   $0x0
  pushl $148
80107ac8:	68 94 00 00 00       	push   $0x94
  jmp alltraps
80107acd:	e9 ea f3 ff ff       	jmp    80106ebc <alltraps>

80107ad2 <vector149>:
.globl vector149
vector149:
  pushl $0
80107ad2:	6a 00                	push   $0x0
  pushl $149
80107ad4:	68 95 00 00 00       	push   $0x95
  jmp alltraps
80107ad9:	e9 de f3 ff ff       	jmp    80106ebc <alltraps>

80107ade <vector150>:
.globl vector150
vector150:
  pushl $0
80107ade:	6a 00                	push   $0x0
  pushl $150
80107ae0:	68 96 00 00 00       	push   $0x96
  jmp alltraps
80107ae5:	e9 d2 f3 ff ff       	jmp    80106ebc <alltraps>

80107aea <vector151>:
.globl vector151
vector151:
  pushl $0
80107aea:	6a 00                	push   $0x0
  pushl $151
80107aec:	68 97 00 00 00       	push   $0x97
  jmp alltraps
80107af1:	e9 c6 f3 ff ff       	jmp    80106ebc <alltraps>

80107af6 <vector152>:
.globl vector152
vector152:
  pushl $0
80107af6:	6a 00                	push   $0x0
  pushl $152
80107af8:	68 98 00 00 00       	push   $0x98
  jmp alltraps
80107afd:	e9 ba f3 ff ff       	jmp    80106ebc <alltraps>

80107b02 <vector153>:
.globl vector153
vector153:
  pushl $0
80107b02:	6a 00                	push   $0x0
  pushl $153
80107b04:	68 99 00 00 00       	push   $0x99
  jmp alltraps
80107b09:	e9 ae f3 ff ff       	jmp    80106ebc <alltraps>

80107b0e <vector154>:
.globl vector154
vector154:
  pushl $0
80107b0e:	6a 00                	push   $0x0
  pushl $154
80107b10:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
80107b15:	e9 a2 f3 ff ff       	jmp    80106ebc <alltraps>

80107b1a <vector155>:
.globl vector155
vector155:
  pushl $0
80107b1a:	6a 00                	push   $0x0
  pushl $155
80107b1c:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
80107b21:	e9 96 f3 ff ff       	jmp    80106ebc <alltraps>

80107b26 <vector156>:
.globl vector156
vector156:
  pushl $0
80107b26:	6a 00                	push   $0x0
  pushl $156
80107b28:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
80107b2d:	e9 8a f3 ff ff       	jmp    80106ebc <alltraps>

80107b32 <vector157>:
.globl vector157
vector157:
  pushl $0
80107b32:	6a 00                	push   $0x0
  pushl $157
80107b34:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
80107b39:	e9 7e f3 ff ff       	jmp    80106ebc <alltraps>

80107b3e <vector158>:
.globl vector158
vector158:
  pushl $0
80107b3e:	6a 00                	push   $0x0
  pushl $158
80107b40:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
80107b45:	e9 72 f3 ff ff       	jmp    80106ebc <alltraps>

80107b4a <vector159>:
.globl vector159
vector159:
  pushl $0
80107b4a:	6a 00                	push   $0x0
  pushl $159
80107b4c:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
80107b51:	e9 66 f3 ff ff       	jmp    80106ebc <alltraps>

80107b56 <vector160>:
.globl vector160
vector160:
  pushl $0
80107b56:	6a 00                	push   $0x0
  pushl $160
80107b58:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
80107b5d:	e9 5a f3 ff ff       	jmp    80106ebc <alltraps>

80107b62 <vector161>:
.globl vector161
vector161:
  pushl $0
80107b62:	6a 00                	push   $0x0
  pushl $161
80107b64:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
80107b69:	e9 4e f3 ff ff       	jmp    80106ebc <alltraps>

80107b6e <vector162>:
.globl vector162
vector162:
  pushl $0
80107b6e:	6a 00                	push   $0x0
  pushl $162
80107b70:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
80107b75:	e9 42 f3 ff ff       	jmp    80106ebc <alltraps>

80107b7a <vector163>:
.globl vector163
vector163:
  pushl $0
80107b7a:	6a 00                	push   $0x0
  pushl $163
80107b7c:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
80107b81:	e9 36 f3 ff ff       	jmp    80106ebc <alltraps>

80107b86 <vector164>:
.globl vector164
vector164:
  pushl $0
80107b86:	6a 00                	push   $0x0
  pushl $164
80107b88:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
80107b8d:	e9 2a f3 ff ff       	jmp    80106ebc <alltraps>

80107b92 <vector165>:
.globl vector165
vector165:
  pushl $0
80107b92:	6a 00                	push   $0x0
  pushl $165
80107b94:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
80107b99:	e9 1e f3 ff ff       	jmp    80106ebc <alltraps>

80107b9e <vector166>:
.globl vector166
vector166:
  pushl $0
80107b9e:	6a 00                	push   $0x0
  pushl $166
80107ba0:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
80107ba5:	e9 12 f3 ff ff       	jmp    80106ebc <alltraps>

80107baa <vector167>:
.globl vector167
vector167:
  pushl $0
80107baa:	6a 00                	push   $0x0
  pushl $167
80107bac:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
80107bb1:	e9 06 f3 ff ff       	jmp    80106ebc <alltraps>

80107bb6 <vector168>:
.globl vector168
vector168:
  pushl $0
80107bb6:	6a 00                	push   $0x0
  pushl $168
80107bb8:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
80107bbd:	e9 fa f2 ff ff       	jmp    80106ebc <alltraps>

80107bc2 <vector169>:
.globl vector169
vector169:
  pushl $0
80107bc2:	6a 00                	push   $0x0
  pushl $169
80107bc4:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
80107bc9:	e9 ee f2 ff ff       	jmp    80106ebc <alltraps>

80107bce <vector170>:
.globl vector170
vector170:
  pushl $0
80107bce:	6a 00                	push   $0x0
  pushl $170
80107bd0:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
80107bd5:	e9 e2 f2 ff ff       	jmp    80106ebc <alltraps>

80107bda <vector171>:
.globl vector171
vector171:
  pushl $0
80107bda:	6a 00                	push   $0x0
  pushl $171
80107bdc:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
80107be1:	e9 d6 f2 ff ff       	jmp    80106ebc <alltraps>

80107be6 <vector172>:
.globl vector172
vector172:
  pushl $0
80107be6:	6a 00                	push   $0x0
  pushl $172
80107be8:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
80107bed:	e9 ca f2 ff ff       	jmp    80106ebc <alltraps>

80107bf2 <vector173>:
.globl vector173
vector173:
  pushl $0
80107bf2:	6a 00                	push   $0x0
  pushl $173
80107bf4:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
80107bf9:	e9 be f2 ff ff       	jmp    80106ebc <alltraps>

80107bfe <vector174>:
.globl vector174
vector174:
  pushl $0
80107bfe:	6a 00                	push   $0x0
  pushl $174
80107c00:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
80107c05:	e9 b2 f2 ff ff       	jmp    80106ebc <alltraps>

80107c0a <vector175>:
.globl vector175
vector175:
  pushl $0
80107c0a:	6a 00                	push   $0x0
  pushl $175
80107c0c:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
80107c11:	e9 a6 f2 ff ff       	jmp    80106ebc <alltraps>

80107c16 <vector176>:
.globl vector176
vector176:
  pushl $0
80107c16:	6a 00                	push   $0x0
  pushl $176
80107c18:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
80107c1d:	e9 9a f2 ff ff       	jmp    80106ebc <alltraps>

80107c22 <vector177>:
.globl vector177
vector177:
  pushl $0
80107c22:	6a 00                	push   $0x0
  pushl $177
80107c24:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
80107c29:	e9 8e f2 ff ff       	jmp    80106ebc <alltraps>

80107c2e <vector178>:
.globl vector178
vector178:
  pushl $0
80107c2e:	6a 00                	push   $0x0
  pushl $178
80107c30:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
80107c35:	e9 82 f2 ff ff       	jmp    80106ebc <alltraps>

80107c3a <vector179>:
.globl vector179
vector179:
  pushl $0
80107c3a:	6a 00                	push   $0x0
  pushl $179
80107c3c:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
80107c41:	e9 76 f2 ff ff       	jmp    80106ebc <alltraps>

80107c46 <vector180>:
.globl vector180
vector180:
  pushl $0
80107c46:	6a 00                	push   $0x0
  pushl $180
80107c48:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
80107c4d:	e9 6a f2 ff ff       	jmp    80106ebc <alltraps>

80107c52 <vector181>:
.globl vector181
vector181:
  pushl $0
80107c52:	6a 00                	push   $0x0
  pushl $181
80107c54:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
80107c59:	e9 5e f2 ff ff       	jmp    80106ebc <alltraps>

80107c5e <vector182>:
.globl vector182
vector182:
  pushl $0
80107c5e:	6a 00                	push   $0x0
  pushl $182
80107c60:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
80107c65:	e9 52 f2 ff ff       	jmp    80106ebc <alltraps>

80107c6a <vector183>:
.globl vector183
vector183:
  pushl $0
80107c6a:	6a 00                	push   $0x0
  pushl $183
80107c6c:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
80107c71:	e9 46 f2 ff ff       	jmp    80106ebc <alltraps>

80107c76 <vector184>:
.globl vector184
vector184:
  pushl $0
80107c76:	6a 00                	push   $0x0
  pushl $184
80107c78:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
80107c7d:	e9 3a f2 ff ff       	jmp    80106ebc <alltraps>

80107c82 <vector185>:
.globl vector185
vector185:
  pushl $0
80107c82:	6a 00                	push   $0x0
  pushl $185
80107c84:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
80107c89:	e9 2e f2 ff ff       	jmp    80106ebc <alltraps>

80107c8e <vector186>:
.globl vector186
vector186:
  pushl $0
80107c8e:	6a 00                	push   $0x0
  pushl $186
80107c90:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
80107c95:	e9 22 f2 ff ff       	jmp    80106ebc <alltraps>

80107c9a <vector187>:
.globl vector187
vector187:
  pushl $0
80107c9a:	6a 00                	push   $0x0
  pushl $187
80107c9c:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
80107ca1:	e9 16 f2 ff ff       	jmp    80106ebc <alltraps>

80107ca6 <vector188>:
.globl vector188
vector188:
  pushl $0
80107ca6:	6a 00                	push   $0x0
  pushl $188
80107ca8:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
80107cad:	e9 0a f2 ff ff       	jmp    80106ebc <alltraps>

80107cb2 <vector189>:
.globl vector189
vector189:
  pushl $0
80107cb2:	6a 00                	push   $0x0
  pushl $189
80107cb4:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
80107cb9:	e9 fe f1 ff ff       	jmp    80106ebc <alltraps>

80107cbe <vector190>:
.globl vector190
vector190:
  pushl $0
80107cbe:	6a 00                	push   $0x0
  pushl $190
80107cc0:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
80107cc5:	e9 f2 f1 ff ff       	jmp    80106ebc <alltraps>

80107cca <vector191>:
.globl vector191
vector191:
  pushl $0
80107cca:	6a 00                	push   $0x0
  pushl $191
80107ccc:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
80107cd1:	e9 e6 f1 ff ff       	jmp    80106ebc <alltraps>

80107cd6 <vector192>:
.globl vector192
vector192:
  pushl $0
80107cd6:	6a 00                	push   $0x0
  pushl $192
80107cd8:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
80107cdd:	e9 da f1 ff ff       	jmp    80106ebc <alltraps>

80107ce2 <vector193>:
.globl vector193
vector193:
  pushl $0
80107ce2:	6a 00                	push   $0x0
  pushl $193
80107ce4:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
80107ce9:	e9 ce f1 ff ff       	jmp    80106ebc <alltraps>

80107cee <vector194>:
.globl vector194
vector194:
  pushl $0
80107cee:	6a 00                	push   $0x0
  pushl $194
80107cf0:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
80107cf5:	e9 c2 f1 ff ff       	jmp    80106ebc <alltraps>

80107cfa <vector195>:
.globl vector195
vector195:
  pushl $0
80107cfa:	6a 00                	push   $0x0
  pushl $195
80107cfc:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
80107d01:	e9 b6 f1 ff ff       	jmp    80106ebc <alltraps>

80107d06 <vector196>:
.globl vector196
vector196:
  pushl $0
80107d06:	6a 00                	push   $0x0
  pushl $196
80107d08:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
80107d0d:	e9 aa f1 ff ff       	jmp    80106ebc <alltraps>

80107d12 <vector197>:
.globl vector197
vector197:
  pushl $0
80107d12:	6a 00                	push   $0x0
  pushl $197
80107d14:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
80107d19:	e9 9e f1 ff ff       	jmp    80106ebc <alltraps>

80107d1e <vector198>:
.globl vector198
vector198:
  pushl $0
80107d1e:	6a 00                	push   $0x0
  pushl $198
80107d20:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
80107d25:	e9 92 f1 ff ff       	jmp    80106ebc <alltraps>

80107d2a <vector199>:
.globl vector199
vector199:
  pushl $0
80107d2a:	6a 00                	push   $0x0
  pushl $199
80107d2c:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
80107d31:	e9 86 f1 ff ff       	jmp    80106ebc <alltraps>

80107d36 <vector200>:
.globl vector200
vector200:
  pushl $0
80107d36:	6a 00                	push   $0x0
  pushl $200
80107d38:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
80107d3d:	e9 7a f1 ff ff       	jmp    80106ebc <alltraps>

80107d42 <vector201>:
.globl vector201
vector201:
  pushl $0
80107d42:	6a 00                	push   $0x0
  pushl $201
80107d44:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
80107d49:	e9 6e f1 ff ff       	jmp    80106ebc <alltraps>

80107d4e <vector202>:
.globl vector202
vector202:
  pushl $0
80107d4e:	6a 00                	push   $0x0
  pushl $202
80107d50:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
80107d55:	e9 62 f1 ff ff       	jmp    80106ebc <alltraps>

80107d5a <vector203>:
.globl vector203
vector203:
  pushl $0
80107d5a:	6a 00                	push   $0x0
  pushl $203
80107d5c:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
80107d61:	e9 56 f1 ff ff       	jmp    80106ebc <alltraps>

80107d66 <vector204>:
.globl vector204
vector204:
  pushl $0
80107d66:	6a 00                	push   $0x0
  pushl $204
80107d68:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
80107d6d:	e9 4a f1 ff ff       	jmp    80106ebc <alltraps>

80107d72 <vector205>:
.globl vector205
vector205:
  pushl $0
80107d72:	6a 00                	push   $0x0
  pushl $205
80107d74:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
80107d79:	e9 3e f1 ff ff       	jmp    80106ebc <alltraps>

80107d7e <vector206>:
.globl vector206
vector206:
  pushl $0
80107d7e:	6a 00                	push   $0x0
  pushl $206
80107d80:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
80107d85:	e9 32 f1 ff ff       	jmp    80106ebc <alltraps>

80107d8a <vector207>:
.globl vector207
vector207:
  pushl $0
80107d8a:	6a 00                	push   $0x0
  pushl $207
80107d8c:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
80107d91:	e9 26 f1 ff ff       	jmp    80106ebc <alltraps>

80107d96 <vector208>:
.globl vector208
vector208:
  pushl $0
80107d96:	6a 00                	push   $0x0
  pushl $208
80107d98:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
80107d9d:	e9 1a f1 ff ff       	jmp    80106ebc <alltraps>

80107da2 <vector209>:
.globl vector209
vector209:
  pushl $0
80107da2:	6a 00                	push   $0x0
  pushl $209
80107da4:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
80107da9:	e9 0e f1 ff ff       	jmp    80106ebc <alltraps>

80107dae <vector210>:
.globl vector210
vector210:
  pushl $0
80107dae:	6a 00                	push   $0x0
  pushl $210
80107db0:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
80107db5:	e9 02 f1 ff ff       	jmp    80106ebc <alltraps>

80107dba <vector211>:
.globl vector211
vector211:
  pushl $0
80107dba:	6a 00                	push   $0x0
  pushl $211
80107dbc:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
80107dc1:	e9 f6 f0 ff ff       	jmp    80106ebc <alltraps>

80107dc6 <vector212>:
.globl vector212
vector212:
  pushl $0
80107dc6:	6a 00                	push   $0x0
  pushl $212
80107dc8:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
80107dcd:	e9 ea f0 ff ff       	jmp    80106ebc <alltraps>

80107dd2 <vector213>:
.globl vector213
vector213:
  pushl $0
80107dd2:	6a 00                	push   $0x0
  pushl $213
80107dd4:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
80107dd9:	e9 de f0 ff ff       	jmp    80106ebc <alltraps>

80107dde <vector214>:
.globl vector214
vector214:
  pushl $0
80107dde:	6a 00                	push   $0x0
  pushl $214
80107de0:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
80107de5:	e9 d2 f0 ff ff       	jmp    80106ebc <alltraps>

80107dea <vector215>:
.globl vector215
vector215:
  pushl $0
80107dea:	6a 00                	push   $0x0
  pushl $215
80107dec:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
80107df1:	e9 c6 f0 ff ff       	jmp    80106ebc <alltraps>

80107df6 <vector216>:
.globl vector216
vector216:
  pushl $0
80107df6:	6a 00                	push   $0x0
  pushl $216
80107df8:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
80107dfd:	e9 ba f0 ff ff       	jmp    80106ebc <alltraps>

80107e02 <vector217>:
.globl vector217
vector217:
  pushl $0
80107e02:	6a 00                	push   $0x0
  pushl $217
80107e04:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
80107e09:	e9 ae f0 ff ff       	jmp    80106ebc <alltraps>

80107e0e <vector218>:
.globl vector218
vector218:
  pushl $0
80107e0e:	6a 00                	push   $0x0
  pushl $218
80107e10:	68 da 00 00 00       	push   $0xda
  jmp alltraps
80107e15:	e9 a2 f0 ff ff       	jmp    80106ebc <alltraps>

80107e1a <vector219>:
.globl vector219
vector219:
  pushl $0
80107e1a:	6a 00                	push   $0x0
  pushl $219
80107e1c:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
80107e21:	e9 96 f0 ff ff       	jmp    80106ebc <alltraps>

80107e26 <vector220>:
.globl vector220
vector220:
  pushl $0
80107e26:	6a 00                	push   $0x0
  pushl $220
80107e28:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
80107e2d:	e9 8a f0 ff ff       	jmp    80106ebc <alltraps>

80107e32 <vector221>:
.globl vector221
vector221:
  pushl $0
80107e32:	6a 00                	push   $0x0
  pushl $221
80107e34:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
80107e39:	e9 7e f0 ff ff       	jmp    80106ebc <alltraps>

80107e3e <vector222>:
.globl vector222
vector222:
  pushl $0
80107e3e:	6a 00                	push   $0x0
  pushl $222
80107e40:	68 de 00 00 00       	push   $0xde
  jmp alltraps
80107e45:	e9 72 f0 ff ff       	jmp    80106ebc <alltraps>

80107e4a <vector223>:
.globl vector223
vector223:
  pushl $0
80107e4a:	6a 00                	push   $0x0
  pushl $223
80107e4c:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
80107e51:	e9 66 f0 ff ff       	jmp    80106ebc <alltraps>

80107e56 <vector224>:
.globl vector224
vector224:
  pushl $0
80107e56:	6a 00                	push   $0x0
  pushl $224
80107e58:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
80107e5d:	e9 5a f0 ff ff       	jmp    80106ebc <alltraps>

80107e62 <vector225>:
.globl vector225
vector225:
  pushl $0
80107e62:	6a 00                	push   $0x0
  pushl $225
80107e64:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
80107e69:	e9 4e f0 ff ff       	jmp    80106ebc <alltraps>

80107e6e <vector226>:
.globl vector226
vector226:
  pushl $0
80107e6e:	6a 00                	push   $0x0
  pushl $226
80107e70:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
80107e75:	e9 42 f0 ff ff       	jmp    80106ebc <alltraps>

80107e7a <vector227>:
.globl vector227
vector227:
  pushl $0
80107e7a:	6a 00                	push   $0x0
  pushl $227
80107e7c:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
80107e81:	e9 36 f0 ff ff       	jmp    80106ebc <alltraps>

80107e86 <vector228>:
.globl vector228
vector228:
  pushl $0
80107e86:	6a 00                	push   $0x0
  pushl $228
80107e88:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
80107e8d:	e9 2a f0 ff ff       	jmp    80106ebc <alltraps>

80107e92 <vector229>:
.globl vector229
vector229:
  pushl $0
80107e92:	6a 00                	push   $0x0
  pushl $229
80107e94:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
80107e99:	e9 1e f0 ff ff       	jmp    80106ebc <alltraps>

80107e9e <vector230>:
.globl vector230
vector230:
  pushl $0
80107e9e:	6a 00                	push   $0x0
  pushl $230
80107ea0:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
80107ea5:	e9 12 f0 ff ff       	jmp    80106ebc <alltraps>

80107eaa <vector231>:
.globl vector231
vector231:
  pushl $0
80107eaa:	6a 00                	push   $0x0
  pushl $231
80107eac:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
80107eb1:	e9 06 f0 ff ff       	jmp    80106ebc <alltraps>

80107eb6 <vector232>:
.globl vector232
vector232:
  pushl $0
80107eb6:	6a 00                	push   $0x0
  pushl $232
80107eb8:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
80107ebd:	e9 fa ef ff ff       	jmp    80106ebc <alltraps>

80107ec2 <vector233>:
.globl vector233
vector233:
  pushl $0
80107ec2:	6a 00                	push   $0x0
  pushl $233
80107ec4:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
80107ec9:	e9 ee ef ff ff       	jmp    80106ebc <alltraps>

80107ece <vector234>:
.globl vector234
vector234:
  pushl $0
80107ece:	6a 00                	push   $0x0
  pushl $234
80107ed0:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
80107ed5:	e9 e2 ef ff ff       	jmp    80106ebc <alltraps>

80107eda <vector235>:
.globl vector235
vector235:
  pushl $0
80107eda:	6a 00                	push   $0x0
  pushl $235
80107edc:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
80107ee1:	e9 d6 ef ff ff       	jmp    80106ebc <alltraps>

80107ee6 <vector236>:
.globl vector236
vector236:
  pushl $0
80107ee6:	6a 00                	push   $0x0
  pushl $236
80107ee8:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
80107eed:	e9 ca ef ff ff       	jmp    80106ebc <alltraps>

80107ef2 <vector237>:
.globl vector237
vector237:
  pushl $0
80107ef2:	6a 00                	push   $0x0
  pushl $237
80107ef4:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
80107ef9:	e9 be ef ff ff       	jmp    80106ebc <alltraps>

80107efe <vector238>:
.globl vector238
vector238:
  pushl $0
80107efe:	6a 00                	push   $0x0
  pushl $238
80107f00:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
80107f05:	e9 b2 ef ff ff       	jmp    80106ebc <alltraps>

80107f0a <vector239>:
.globl vector239
vector239:
  pushl $0
80107f0a:	6a 00                	push   $0x0
  pushl $239
80107f0c:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
80107f11:	e9 a6 ef ff ff       	jmp    80106ebc <alltraps>

80107f16 <vector240>:
.globl vector240
vector240:
  pushl $0
80107f16:	6a 00                	push   $0x0
  pushl $240
80107f18:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
80107f1d:	e9 9a ef ff ff       	jmp    80106ebc <alltraps>

80107f22 <vector241>:
.globl vector241
vector241:
  pushl $0
80107f22:	6a 00                	push   $0x0
  pushl $241
80107f24:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
80107f29:	e9 8e ef ff ff       	jmp    80106ebc <alltraps>

80107f2e <vector242>:
.globl vector242
vector242:
  pushl $0
80107f2e:	6a 00                	push   $0x0
  pushl $242
80107f30:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
80107f35:	e9 82 ef ff ff       	jmp    80106ebc <alltraps>

80107f3a <vector243>:
.globl vector243
vector243:
  pushl $0
80107f3a:	6a 00                	push   $0x0
  pushl $243
80107f3c:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
80107f41:	e9 76 ef ff ff       	jmp    80106ebc <alltraps>

80107f46 <vector244>:
.globl vector244
vector244:
  pushl $0
80107f46:	6a 00                	push   $0x0
  pushl $244
80107f48:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
80107f4d:	e9 6a ef ff ff       	jmp    80106ebc <alltraps>

80107f52 <vector245>:
.globl vector245
vector245:
  pushl $0
80107f52:	6a 00                	push   $0x0
  pushl $245
80107f54:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
80107f59:	e9 5e ef ff ff       	jmp    80106ebc <alltraps>

80107f5e <vector246>:
.globl vector246
vector246:
  pushl $0
80107f5e:	6a 00                	push   $0x0
  pushl $246
80107f60:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
80107f65:	e9 52 ef ff ff       	jmp    80106ebc <alltraps>

80107f6a <vector247>:
.globl vector247
vector247:
  pushl $0
80107f6a:	6a 00                	push   $0x0
  pushl $247
80107f6c:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
80107f71:	e9 46 ef ff ff       	jmp    80106ebc <alltraps>

80107f76 <vector248>:
.globl vector248
vector248:
  pushl $0
80107f76:	6a 00                	push   $0x0
  pushl $248
80107f78:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
80107f7d:	e9 3a ef ff ff       	jmp    80106ebc <alltraps>

80107f82 <vector249>:
.globl vector249
vector249:
  pushl $0
80107f82:	6a 00                	push   $0x0
  pushl $249
80107f84:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
80107f89:	e9 2e ef ff ff       	jmp    80106ebc <alltraps>

80107f8e <vector250>:
.globl vector250
vector250:
  pushl $0
80107f8e:	6a 00                	push   $0x0
  pushl $250
80107f90:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
80107f95:	e9 22 ef ff ff       	jmp    80106ebc <alltraps>

80107f9a <vector251>:
.globl vector251
vector251:
  pushl $0
80107f9a:	6a 00                	push   $0x0
  pushl $251
80107f9c:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
80107fa1:	e9 16 ef ff ff       	jmp    80106ebc <alltraps>

80107fa6 <vector252>:
.globl vector252
vector252:
  pushl $0
80107fa6:	6a 00                	push   $0x0
  pushl $252
80107fa8:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
80107fad:	e9 0a ef ff ff       	jmp    80106ebc <alltraps>

80107fb2 <vector253>:
.globl vector253
vector253:
  pushl $0
80107fb2:	6a 00                	push   $0x0
  pushl $253
80107fb4:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
80107fb9:	e9 fe ee ff ff       	jmp    80106ebc <alltraps>

80107fbe <vector254>:
.globl vector254
vector254:
  pushl $0
80107fbe:	6a 00                	push   $0x0
  pushl $254
80107fc0:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
80107fc5:	e9 f2 ee ff ff       	jmp    80106ebc <alltraps>

80107fca <vector255>:
.globl vector255
vector255:
  pushl $0
80107fca:	6a 00                	push   $0x0
  pushl $255
80107fcc:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
80107fd1:	e9 e6 ee ff ff       	jmp    80106ebc <alltraps>
	...

80107fd8 <lgdt>:

struct segdesc;

static inline void
lgdt(struct segdesc *p, int size)
{
80107fd8:	55                   	push   %ebp
80107fd9:	89 e5                	mov    %esp,%ebp
80107fdb:	83 ec 10             	sub    $0x10,%esp
  volatile ushort pd[3];

  pd[0] = size-1;
80107fde:	8b 45 0c             	mov    0xc(%ebp),%eax
80107fe1:	83 e8 01             	sub    $0x1,%eax
80107fe4:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
80107fe8:	8b 45 08             	mov    0x8(%ebp),%eax
80107feb:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80107fef:	8b 45 08             	mov    0x8(%ebp),%eax
80107ff2:	c1 e8 10             	shr    $0x10,%eax
80107ff5:	66 89 45 fe          	mov    %ax,-0x2(%ebp)

  asm volatile("lgdt (%0)" : : "r" (pd));
80107ff9:	8d 45 fa             	lea    -0x6(%ebp),%eax
80107ffc:	0f 01 10             	lgdtl  (%eax)
}
80107fff:	c9                   	leave  
80108000:	c3                   	ret    

80108001 <ltr>:
  asm volatile("lidt (%0)" : : "r" (pd));
}

static inline void
ltr(ushort sel)
{
80108001:	55                   	push   %ebp
80108002:	89 e5                	mov    %esp,%ebp
80108004:	83 ec 04             	sub    $0x4,%esp
80108007:	8b 45 08             	mov    0x8(%ebp),%eax
8010800a:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  asm volatile("ltr %0" : : "r" (sel));
8010800e:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
80108012:	0f 00 d8             	ltr    %ax
}
80108015:	c9                   	leave  
80108016:	c3                   	ret    

80108017 <loadgs>:
  return eflags;
}

static inline void
loadgs(ushort v)
{
80108017:	55                   	push   %ebp
80108018:	89 e5                	mov    %esp,%ebp
8010801a:	83 ec 04             	sub    $0x4,%esp
8010801d:	8b 45 08             	mov    0x8(%ebp),%eax
80108020:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  asm volatile("movw %0, %%gs" : : "r" (v));
80108024:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
80108028:	8e e8                	mov    %eax,%gs
}
8010802a:	c9                   	leave  
8010802b:	c3                   	ret    

8010802c <lcr3>:
  return val;
}

static inline void
lcr3(uint val) 
{
8010802c:	55                   	push   %ebp
8010802d:	89 e5                	mov    %esp,%ebp
  asm volatile("movl %0,%%cr3" : : "r" (val));
8010802f:	8b 45 08             	mov    0x8(%ebp),%eax
80108032:	0f 22 d8             	mov    %eax,%cr3
}
80108035:	5d                   	pop    %ebp
80108036:	c3                   	ret    

80108037 <v2p>:
#define KERNBASE 0x80000000         // First kernel virtual address
#define KERNLINK (KERNBASE+EXTMEM)  // Address where kernel is linked

#ifndef __ASSEMBLER__

static inline uint v2p(void *a) { return ((uint) (a))  - KERNBASE; }
80108037:	55                   	push   %ebp
80108038:	89 e5                	mov    %esp,%ebp
8010803a:	8b 45 08             	mov    0x8(%ebp),%eax
8010803d:	05 00 00 00 80       	add    $0x80000000,%eax
80108042:	5d                   	pop    %ebp
80108043:	c3                   	ret    

80108044 <p2v>:
static inline void *p2v(uint a) { return (void *) ((a) + KERNBASE); }
80108044:	55                   	push   %ebp
80108045:	89 e5                	mov    %esp,%ebp
80108047:	8b 45 08             	mov    0x8(%ebp),%eax
8010804a:	05 00 00 00 80       	add    $0x80000000,%eax
8010804f:	5d                   	pop    %ebp
80108050:	c3                   	ret    

80108051 <seginit>:

// Set up CPU's kernel segment descriptors.
// Run once on entry on each CPU.
void
seginit(void)
{
80108051:	55                   	push   %ebp
80108052:	89 e5                	mov    %esp,%ebp
80108054:	53                   	push   %ebx
80108055:	83 ec 24             	sub    $0x24,%esp

  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpunum()];
80108058:	e8 28 b3 ff ff       	call   80103385 <cpunum>
8010805d:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
80108063:	05 a0 1b 11 80       	add    $0x80111ba0,%eax
80108068:	89 45 f4             	mov    %eax,-0xc(%ebp)
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
8010806b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010806e:	66 c7 40 78 ff ff    	movw   $0xffff,0x78(%eax)
80108074:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108077:	66 c7 40 7a 00 00    	movw   $0x0,0x7a(%eax)
8010807d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108080:	c6 40 7c 00          	movb   $0x0,0x7c(%eax)
80108084:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108087:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
8010808b:	83 e2 f0             	and    $0xfffffff0,%edx
8010808e:	83 ca 0a             	or     $0xa,%edx
80108091:	88 50 7d             	mov    %dl,0x7d(%eax)
80108094:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108097:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
8010809b:	83 ca 10             	or     $0x10,%edx
8010809e:	88 50 7d             	mov    %dl,0x7d(%eax)
801080a1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801080a4:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
801080a8:	83 e2 9f             	and    $0xffffff9f,%edx
801080ab:	88 50 7d             	mov    %dl,0x7d(%eax)
801080ae:	8b 45 f4             	mov    -0xc(%ebp),%eax
801080b1:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
801080b5:	83 ca 80             	or     $0xffffff80,%edx
801080b8:	88 50 7d             	mov    %dl,0x7d(%eax)
801080bb:	8b 45 f4             	mov    -0xc(%ebp),%eax
801080be:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
801080c2:	83 ca 0f             	or     $0xf,%edx
801080c5:	88 50 7e             	mov    %dl,0x7e(%eax)
801080c8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801080cb:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
801080cf:	83 e2 ef             	and    $0xffffffef,%edx
801080d2:	88 50 7e             	mov    %dl,0x7e(%eax)
801080d5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801080d8:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
801080dc:	83 e2 df             	and    $0xffffffdf,%edx
801080df:	88 50 7e             	mov    %dl,0x7e(%eax)
801080e2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801080e5:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
801080e9:	83 ca 40             	or     $0x40,%edx
801080ec:	88 50 7e             	mov    %dl,0x7e(%eax)
801080ef:	8b 45 f4             	mov    -0xc(%ebp),%eax
801080f2:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
801080f6:	83 ca 80             	or     $0xffffff80,%edx
801080f9:	88 50 7e             	mov    %dl,0x7e(%eax)
801080fc:	8b 45 f4             	mov    -0xc(%ebp),%eax
801080ff:	c6 40 7f 00          	movb   $0x0,0x7f(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80108103:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108106:	66 c7 80 80 00 00 00 	movw   $0xffff,0x80(%eax)
8010810d:	ff ff 
8010810f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108112:	66 c7 80 82 00 00 00 	movw   $0x0,0x82(%eax)
80108119:	00 00 
8010811b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010811e:	c6 80 84 00 00 00 00 	movb   $0x0,0x84(%eax)
80108125:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108128:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
8010812f:	83 e2 f0             	and    $0xfffffff0,%edx
80108132:	83 ca 02             	or     $0x2,%edx
80108135:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
8010813b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010813e:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
80108145:	83 ca 10             	or     $0x10,%edx
80108148:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
8010814e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108151:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
80108158:	83 e2 9f             	and    $0xffffff9f,%edx
8010815b:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
80108161:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108164:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
8010816b:	83 ca 80             	or     $0xffffff80,%edx
8010816e:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
80108174:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108177:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
8010817e:	83 ca 0f             	or     $0xf,%edx
80108181:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
80108187:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010818a:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
80108191:	83 e2 ef             	and    $0xffffffef,%edx
80108194:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
8010819a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010819d:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
801081a4:	83 e2 df             	and    $0xffffffdf,%edx
801081a7:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
801081ad:	8b 45 f4             	mov    -0xc(%ebp),%eax
801081b0:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
801081b7:	83 ca 40             	or     $0x40,%edx
801081ba:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
801081c0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801081c3:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
801081ca:	83 ca 80             	or     $0xffffff80,%edx
801081cd:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
801081d3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801081d6:	c6 80 87 00 00 00 00 	movb   $0x0,0x87(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
801081dd:	8b 45 f4             	mov    -0xc(%ebp),%eax
801081e0:	66 c7 80 90 00 00 00 	movw   $0xffff,0x90(%eax)
801081e7:	ff ff 
801081e9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801081ec:	66 c7 80 92 00 00 00 	movw   $0x0,0x92(%eax)
801081f3:	00 00 
801081f5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801081f8:	c6 80 94 00 00 00 00 	movb   $0x0,0x94(%eax)
801081ff:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108202:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
80108209:	83 e2 f0             	and    $0xfffffff0,%edx
8010820c:	83 ca 0a             	or     $0xa,%edx
8010820f:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
80108215:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108218:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
8010821f:	83 ca 10             	or     $0x10,%edx
80108222:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
80108228:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010822b:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
80108232:	83 ca 60             	or     $0x60,%edx
80108235:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
8010823b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010823e:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
80108245:	83 ca 80             	or     $0xffffff80,%edx
80108248:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
8010824e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108251:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
80108258:	83 ca 0f             	or     $0xf,%edx
8010825b:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
80108261:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108264:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
8010826b:	83 e2 ef             	and    $0xffffffef,%edx
8010826e:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
80108274:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108277:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
8010827e:	83 e2 df             	and    $0xffffffdf,%edx
80108281:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
80108287:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010828a:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
80108291:	83 ca 40             	or     $0x40,%edx
80108294:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
8010829a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010829d:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
801082a4:	83 ca 80             	or     $0xffffff80,%edx
801082a7:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
801082ad:	8b 45 f4             	mov    -0xc(%ebp),%eax
801082b0:	c6 80 97 00 00 00 00 	movb   $0x0,0x97(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
801082b7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801082ba:	66 c7 80 98 00 00 00 	movw   $0xffff,0x98(%eax)
801082c1:	ff ff 
801082c3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801082c6:	66 c7 80 9a 00 00 00 	movw   $0x0,0x9a(%eax)
801082cd:	00 00 
801082cf:	8b 45 f4             	mov    -0xc(%ebp),%eax
801082d2:	c6 80 9c 00 00 00 00 	movb   $0x0,0x9c(%eax)
801082d9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801082dc:	0f b6 90 9d 00 00 00 	movzbl 0x9d(%eax),%edx
801082e3:	83 e2 f0             	and    $0xfffffff0,%edx
801082e6:	83 ca 02             	or     $0x2,%edx
801082e9:	88 90 9d 00 00 00    	mov    %dl,0x9d(%eax)
801082ef:	8b 45 f4             	mov    -0xc(%ebp),%eax
801082f2:	0f b6 90 9d 00 00 00 	movzbl 0x9d(%eax),%edx
801082f9:	83 ca 10             	or     $0x10,%edx
801082fc:	88 90 9d 00 00 00    	mov    %dl,0x9d(%eax)
80108302:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108305:	0f b6 90 9d 00 00 00 	movzbl 0x9d(%eax),%edx
8010830c:	83 ca 60             	or     $0x60,%edx
8010830f:	88 90 9d 00 00 00    	mov    %dl,0x9d(%eax)
80108315:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108318:	0f b6 90 9d 00 00 00 	movzbl 0x9d(%eax),%edx
8010831f:	83 ca 80             	or     $0xffffff80,%edx
80108322:	88 90 9d 00 00 00    	mov    %dl,0x9d(%eax)
80108328:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010832b:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
80108332:	83 ca 0f             	or     $0xf,%edx
80108335:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
8010833b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010833e:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
80108345:	83 e2 ef             	and    $0xffffffef,%edx
80108348:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
8010834e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108351:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
80108358:	83 e2 df             	and    $0xffffffdf,%edx
8010835b:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
80108361:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108364:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
8010836b:	83 ca 40             	or     $0x40,%edx
8010836e:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
80108374:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108377:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
8010837e:	83 ca 80             	or     $0xffffff80,%edx
80108381:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
80108387:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010838a:	c6 80 9f 00 00 00 00 	movb   $0x0,0x9f(%eax)

  // Map cpu, and curproc
  c->gdt[SEG_KCPU] = SEG(STA_W, &c->cpu, 8, 0);
80108391:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108394:	05 b4 00 00 00       	add    $0xb4,%eax
80108399:	89 c3                	mov    %eax,%ebx
8010839b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010839e:	05 b4 00 00 00       	add    $0xb4,%eax
801083a3:	c1 e8 10             	shr    $0x10,%eax
801083a6:	89 c1                	mov    %eax,%ecx
801083a8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801083ab:	05 b4 00 00 00       	add    $0xb4,%eax
801083b0:	c1 e8 18             	shr    $0x18,%eax
801083b3:	89 c2                	mov    %eax,%edx
801083b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801083b8:	66 c7 80 88 00 00 00 	movw   $0x0,0x88(%eax)
801083bf:	00 00 
801083c1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801083c4:	66 89 98 8a 00 00 00 	mov    %bx,0x8a(%eax)
801083cb:	8b 45 f4             	mov    -0xc(%ebp),%eax
801083ce:	88 88 8c 00 00 00    	mov    %cl,0x8c(%eax)
801083d4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801083d7:	0f b6 88 8d 00 00 00 	movzbl 0x8d(%eax),%ecx
801083de:	83 e1 f0             	and    $0xfffffff0,%ecx
801083e1:	83 c9 02             	or     $0x2,%ecx
801083e4:	88 88 8d 00 00 00    	mov    %cl,0x8d(%eax)
801083ea:	8b 45 f4             	mov    -0xc(%ebp),%eax
801083ed:	0f b6 88 8d 00 00 00 	movzbl 0x8d(%eax),%ecx
801083f4:	83 c9 10             	or     $0x10,%ecx
801083f7:	88 88 8d 00 00 00    	mov    %cl,0x8d(%eax)
801083fd:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108400:	0f b6 88 8d 00 00 00 	movzbl 0x8d(%eax),%ecx
80108407:	83 e1 9f             	and    $0xffffff9f,%ecx
8010840a:	88 88 8d 00 00 00    	mov    %cl,0x8d(%eax)
80108410:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108413:	0f b6 88 8d 00 00 00 	movzbl 0x8d(%eax),%ecx
8010841a:	83 c9 80             	or     $0xffffff80,%ecx
8010841d:	88 88 8d 00 00 00    	mov    %cl,0x8d(%eax)
80108423:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108426:	0f b6 88 8e 00 00 00 	movzbl 0x8e(%eax),%ecx
8010842d:	83 e1 f0             	and    $0xfffffff0,%ecx
80108430:	88 88 8e 00 00 00    	mov    %cl,0x8e(%eax)
80108436:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108439:	0f b6 88 8e 00 00 00 	movzbl 0x8e(%eax),%ecx
80108440:	83 e1 ef             	and    $0xffffffef,%ecx
80108443:	88 88 8e 00 00 00    	mov    %cl,0x8e(%eax)
80108449:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010844c:	0f b6 88 8e 00 00 00 	movzbl 0x8e(%eax),%ecx
80108453:	83 e1 df             	and    $0xffffffdf,%ecx
80108456:	88 88 8e 00 00 00    	mov    %cl,0x8e(%eax)
8010845c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010845f:	0f b6 88 8e 00 00 00 	movzbl 0x8e(%eax),%ecx
80108466:	83 c9 40             	or     $0x40,%ecx
80108469:	88 88 8e 00 00 00    	mov    %cl,0x8e(%eax)
8010846f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108472:	0f b6 88 8e 00 00 00 	movzbl 0x8e(%eax),%ecx
80108479:	83 c9 80             	or     $0xffffff80,%ecx
8010847c:	88 88 8e 00 00 00    	mov    %cl,0x8e(%eax)
80108482:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108485:	88 90 8f 00 00 00    	mov    %dl,0x8f(%eax)

  lgdt(c->gdt, sizeof(c->gdt));
8010848b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010848e:	83 c0 70             	add    $0x70,%eax
80108491:	c7 44 24 04 38 00 00 	movl   $0x38,0x4(%esp)
80108498:	00 
80108499:	89 04 24             	mov    %eax,(%esp)
8010849c:	e8 37 fb ff ff       	call   80107fd8 <lgdt>
  loadgs(SEG_KCPU << 3);
801084a1:	c7 04 24 18 00 00 00 	movl   $0x18,(%esp)
801084a8:	e8 6a fb ff ff       	call   80108017 <loadgs>
  
  // Initialize cpu-local storage.
  cpu = c;
801084ad:	8b 45 f4             	mov    -0xc(%ebp),%eax
801084b0:	65 a3 00 00 00 00    	mov    %eax,%gs:0x0
  proc = 0;
801084b6:	65 c7 05 04 00 00 00 	movl   $0x0,%gs:0x4
801084bd:	00 00 00 00 
}
801084c1:	83 c4 24             	add    $0x24,%esp
801084c4:	5b                   	pop    %ebx
801084c5:	5d                   	pop    %ebp
801084c6:	c3                   	ret    

801084c7 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
801084c7:	55                   	push   %ebp
801084c8:	89 e5                	mov    %esp,%ebp
801084ca:	83 ec 28             	sub    $0x28,%esp
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
801084cd:	8b 45 0c             	mov    0xc(%ebp),%eax
801084d0:	c1 e8 16             	shr    $0x16,%eax
801084d3:	c1 e0 02             	shl    $0x2,%eax
801084d6:	03 45 08             	add    0x8(%ebp),%eax
801084d9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(*pde & PTE_P){
801084dc:	8b 45 f0             	mov    -0x10(%ebp),%eax
801084df:	8b 00                	mov    (%eax),%eax
801084e1:	83 e0 01             	and    $0x1,%eax
801084e4:	84 c0                	test   %al,%al
801084e6:	74 17                	je     801084ff <walkpgdir+0x38>
    pgtab = (pte_t*)p2v(PTE_ADDR(*pde));
801084e8:	8b 45 f0             	mov    -0x10(%ebp),%eax
801084eb:	8b 00                	mov    (%eax),%eax
801084ed:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801084f2:	89 04 24             	mov    %eax,(%esp)
801084f5:	e8 4a fb ff ff       	call   80108044 <p2v>
801084fa:	89 45 f4             	mov    %eax,-0xc(%ebp)
801084fd:	eb 4b                	jmp    8010854a <walkpgdir+0x83>
  } else {
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
801084ff:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80108503:	74 0e                	je     80108513 <walkpgdir+0x4c>
80108505:	e8 ed aa ff ff       	call   80102ff7 <kalloc>
8010850a:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010850d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80108511:	75 07                	jne    8010851a <walkpgdir+0x53>
      return 0;
80108513:	b8 00 00 00 00       	mov    $0x0,%eax
80108518:	eb 41                	jmp    8010855b <walkpgdir+0x94>
    // Make sure all those PTE_P bits are zero.
    memset(pgtab, 0, PGSIZE);
8010851a:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
80108521:	00 
80108522:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80108529:	00 
8010852a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010852d:	89 04 24             	mov    %eax,(%esp)
80108530:	e8 1d d4 ff ff       	call   80105952 <memset>
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table 
    // entries, if necessary.
    *pde = v2p(pgtab) | PTE_P | PTE_W | PTE_U;
80108535:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108538:	89 04 24             	mov    %eax,(%esp)
8010853b:	e8 f7 fa ff ff       	call   80108037 <v2p>
80108540:	89 c2                	mov    %eax,%edx
80108542:	83 ca 07             	or     $0x7,%edx
80108545:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108548:	89 10                	mov    %edx,(%eax)
  }
  return &pgtab[PTX(va)];
8010854a:	8b 45 0c             	mov    0xc(%ebp),%eax
8010854d:	c1 e8 0c             	shr    $0xc,%eax
80108550:	25 ff 03 00 00       	and    $0x3ff,%eax
80108555:	c1 e0 02             	shl    $0x2,%eax
80108558:	03 45 f4             	add    -0xc(%ebp),%eax
}
8010855b:	c9                   	leave  
8010855c:	c3                   	ret    

8010855d <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
8010855d:	55                   	push   %ebp
8010855e:	89 e5                	mov    %esp,%ebp
80108560:	83 ec 28             	sub    $0x28,%esp
  char *a, *last;
  pte_t *pte;
  
  a = (char*)PGROUNDDOWN((uint)va);
80108563:	8b 45 0c             	mov    0xc(%ebp),%eax
80108566:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010856b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
8010856e:	8b 45 0c             	mov    0xc(%ebp),%eax
80108571:	03 45 10             	add    0x10(%ebp),%eax
80108574:	83 e8 01             	sub    $0x1,%eax
80108577:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010857c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
8010857f:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
80108586:	00 
80108587:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010858a:	89 44 24 04          	mov    %eax,0x4(%esp)
8010858e:	8b 45 08             	mov    0x8(%ebp),%eax
80108591:	89 04 24             	mov    %eax,(%esp)
80108594:	e8 2e ff ff ff       	call   801084c7 <walkpgdir>
80108599:	89 45 ec             	mov    %eax,-0x14(%ebp)
8010859c:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
801085a0:	75 07                	jne    801085a9 <mappages+0x4c>
      return -1;
801085a2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801085a7:	eb 46                	jmp    801085ef <mappages+0x92>
    if(*pte & PTE_P)
801085a9:	8b 45 ec             	mov    -0x14(%ebp),%eax
801085ac:	8b 00                	mov    (%eax),%eax
801085ae:	83 e0 01             	and    $0x1,%eax
801085b1:	84 c0                	test   %al,%al
801085b3:	74 0c                	je     801085c1 <mappages+0x64>
      panic("remap");
801085b5:	c7 04 24 84 94 10 80 	movl   $0x80109484,(%esp)
801085bc:	e8 7c 7f ff ff       	call   8010053d <panic>
    *pte = pa | perm | PTE_P;
801085c1:	8b 45 18             	mov    0x18(%ebp),%eax
801085c4:	0b 45 14             	or     0x14(%ebp),%eax
801085c7:	89 c2                	mov    %eax,%edx
801085c9:	83 ca 01             	or     $0x1,%edx
801085cc:	8b 45 ec             	mov    -0x14(%ebp),%eax
801085cf:	89 10                	mov    %edx,(%eax)
    if(a == last)
801085d1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801085d4:	3b 45 f0             	cmp    -0x10(%ebp),%eax
801085d7:	74 10                	je     801085e9 <mappages+0x8c>
      break;
    a += PGSIZE;
801085d9:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
    pa += PGSIZE;
801085e0:	81 45 14 00 10 00 00 	addl   $0x1000,0x14(%ebp)
  }
801085e7:	eb 96                	jmp    8010857f <mappages+0x22>
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
    if(a == last)
      break;
801085e9:	90                   	nop
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
801085ea:	b8 00 00 00 00       	mov    $0x0,%eax
}
801085ef:	c9                   	leave  
801085f0:	c3                   	ret    

801085f1 <setupkvm>:
};

// Set up kernel part of a page table.
pde_t*
setupkvm()
{
801085f1:	55                   	push   %ebp
801085f2:	89 e5                	mov    %esp,%ebp
801085f4:	53                   	push   %ebx
801085f5:	83 ec 34             	sub    $0x34,%esp
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
801085f8:	e8 fa a9 ff ff       	call   80102ff7 <kalloc>
801085fd:	89 45 f0             	mov    %eax,-0x10(%ebp)
80108600:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80108604:	75 0a                	jne    80108610 <setupkvm+0x1f>
    return 0;
80108606:	b8 00 00 00 00       	mov    $0x0,%eax
8010860b:	e9 98 00 00 00       	jmp    801086a8 <setupkvm+0xb7>
  memset(pgdir, 0, PGSIZE);
80108610:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
80108617:	00 
80108618:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
8010861f:	00 
80108620:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108623:	89 04 24             	mov    %eax,(%esp)
80108626:	e8 27 d3 ff ff       	call   80105952 <memset>
  if (p2v(PHYSTOP) > (void*)DEVSPACE)
8010862b:	c7 04 24 00 00 00 0e 	movl   $0xe000000,(%esp)
80108632:	e8 0d fa ff ff       	call   80108044 <p2v>
80108637:	3d 00 00 00 fe       	cmp    $0xfe000000,%eax
8010863c:	76 0c                	jbe    8010864a <setupkvm+0x59>
    panic("PHYSTOP too high");
8010863e:	c7 04 24 8a 94 10 80 	movl   $0x8010948a,(%esp)
80108645:	e8 f3 7e ff ff       	call   8010053d <panic>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
8010864a:	c7 45 f4 c0 c7 10 80 	movl   $0x8010c7c0,-0xc(%ebp)
80108651:	eb 49                	jmp    8010869c <setupkvm+0xab>
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start, 
                (uint)k->phys_start, k->perm) < 0)
80108653:	8b 45 f4             	mov    -0xc(%ebp),%eax
    return 0;
  memset(pgdir, 0, PGSIZE);
  if (p2v(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start, 
80108656:	8b 48 0c             	mov    0xc(%eax),%ecx
                (uint)k->phys_start, k->perm) < 0)
80108659:	8b 45 f4             	mov    -0xc(%ebp),%eax
    return 0;
  memset(pgdir, 0, PGSIZE);
  if (p2v(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start, 
8010865c:	8b 50 04             	mov    0x4(%eax),%edx
8010865f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108662:	8b 58 08             	mov    0x8(%eax),%ebx
80108665:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108668:	8b 40 04             	mov    0x4(%eax),%eax
8010866b:	29 c3                	sub    %eax,%ebx
8010866d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108670:	8b 00                	mov    (%eax),%eax
80108672:	89 4c 24 10          	mov    %ecx,0x10(%esp)
80108676:	89 54 24 0c          	mov    %edx,0xc(%esp)
8010867a:	89 5c 24 08          	mov    %ebx,0x8(%esp)
8010867e:	89 44 24 04          	mov    %eax,0x4(%esp)
80108682:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108685:	89 04 24             	mov    %eax,(%esp)
80108688:	e8 d0 fe ff ff       	call   8010855d <mappages>
8010868d:	85 c0                	test   %eax,%eax
8010868f:	79 07                	jns    80108698 <setupkvm+0xa7>
                (uint)k->phys_start, k->perm) < 0)
      return 0;
80108691:	b8 00 00 00 00       	mov    $0x0,%eax
80108696:	eb 10                	jmp    801086a8 <setupkvm+0xb7>
  if((pgdir = (pde_t*)kalloc()) == 0)
    return 0;
  memset(pgdir, 0, PGSIZE);
  if (p2v(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80108698:	83 45 f4 10          	addl   $0x10,-0xc(%ebp)
8010869c:	81 7d f4 00 c8 10 80 	cmpl   $0x8010c800,-0xc(%ebp)
801086a3:	72 ae                	jb     80108653 <setupkvm+0x62>
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start, 
                (uint)k->phys_start, k->perm) < 0)
      return 0;
  return pgdir;
801086a5:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
801086a8:	83 c4 34             	add    $0x34,%esp
801086ab:	5b                   	pop    %ebx
801086ac:	5d                   	pop    %ebp
801086ad:	c3                   	ret    

801086ae <kvmalloc>:

// Allocate one page table for the machine for the kernel address
// space for scheduler processes.
void
kvmalloc(void)
{
801086ae:	55                   	push   %ebp
801086af:	89 e5                	mov    %esp,%ebp
801086b1:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
801086b4:	e8 38 ff ff ff       	call   801085f1 <setupkvm>
801086b9:	a3 78 50 11 80       	mov    %eax,0x80115078
  switchkvm();
801086be:	e8 02 00 00 00       	call   801086c5 <switchkvm>
}
801086c3:	c9                   	leave  
801086c4:	c3                   	ret    

801086c5 <switchkvm>:

// Switch h/w page table register to the kernel-only page table,
// for when no process is running.
void
switchkvm(void)
{
801086c5:	55                   	push   %ebp
801086c6:	89 e5                	mov    %esp,%ebp
801086c8:	83 ec 04             	sub    $0x4,%esp
  lcr3(v2p(kpgdir));   // switch to the kernel page table
801086cb:	a1 78 50 11 80       	mov    0x80115078,%eax
801086d0:	89 04 24             	mov    %eax,(%esp)
801086d3:	e8 5f f9 ff ff       	call   80108037 <v2p>
801086d8:	89 04 24             	mov    %eax,(%esp)
801086db:	e8 4c f9 ff ff       	call   8010802c <lcr3>
}
801086e0:	c9                   	leave  
801086e1:	c3                   	ret    

801086e2 <switchuvm>:

// Switch TSS and h/w page table to correspond to process p.
void
switchuvm(struct proc *p)
{
801086e2:	55                   	push   %ebp
801086e3:	89 e5                	mov    %esp,%ebp
801086e5:	53                   	push   %ebx
801086e6:	83 ec 14             	sub    $0x14,%esp
  pushcli();
801086e9:	e8 5d d1 ff ff       	call   8010584b <pushcli>
  cpu->gdt[SEG_TSS] = SEG16(STS_T32A, &cpu->ts, sizeof(cpu->ts)-1, 0);
801086ee:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801086f4:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
801086fb:	83 c2 08             	add    $0x8,%edx
801086fe:	89 d3                	mov    %edx,%ebx
80108700:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80108707:	83 c2 08             	add    $0x8,%edx
8010870a:	c1 ea 10             	shr    $0x10,%edx
8010870d:	89 d1                	mov    %edx,%ecx
8010870f:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80108716:	83 c2 08             	add    $0x8,%edx
80108719:	c1 ea 18             	shr    $0x18,%edx
8010871c:	66 c7 80 a0 00 00 00 	movw   $0x67,0xa0(%eax)
80108723:	67 00 
80108725:	66 89 98 a2 00 00 00 	mov    %bx,0xa2(%eax)
8010872c:	88 88 a4 00 00 00    	mov    %cl,0xa4(%eax)
80108732:	0f b6 88 a5 00 00 00 	movzbl 0xa5(%eax),%ecx
80108739:	83 e1 f0             	and    $0xfffffff0,%ecx
8010873c:	83 c9 09             	or     $0x9,%ecx
8010873f:	88 88 a5 00 00 00    	mov    %cl,0xa5(%eax)
80108745:	0f b6 88 a5 00 00 00 	movzbl 0xa5(%eax),%ecx
8010874c:	83 c9 10             	or     $0x10,%ecx
8010874f:	88 88 a5 00 00 00    	mov    %cl,0xa5(%eax)
80108755:	0f b6 88 a5 00 00 00 	movzbl 0xa5(%eax),%ecx
8010875c:	83 e1 9f             	and    $0xffffff9f,%ecx
8010875f:	88 88 a5 00 00 00    	mov    %cl,0xa5(%eax)
80108765:	0f b6 88 a5 00 00 00 	movzbl 0xa5(%eax),%ecx
8010876c:	83 c9 80             	or     $0xffffff80,%ecx
8010876f:	88 88 a5 00 00 00    	mov    %cl,0xa5(%eax)
80108775:	0f b6 88 a6 00 00 00 	movzbl 0xa6(%eax),%ecx
8010877c:	83 e1 f0             	and    $0xfffffff0,%ecx
8010877f:	88 88 a6 00 00 00    	mov    %cl,0xa6(%eax)
80108785:	0f b6 88 a6 00 00 00 	movzbl 0xa6(%eax),%ecx
8010878c:	83 e1 ef             	and    $0xffffffef,%ecx
8010878f:	88 88 a6 00 00 00    	mov    %cl,0xa6(%eax)
80108795:	0f b6 88 a6 00 00 00 	movzbl 0xa6(%eax),%ecx
8010879c:	83 e1 df             	and    $0xffffffdf,%ecx
8010879f:	88 88 a6 00 00 00    	mov    %cl,0xa6(%eax)
801087a5:	0f b6 88 a6 00 00 00 	movzbl 0xa6(%eax),%ecx
801087ac:	83 c9 40             	or     $0x40,%ecx
801087af:	88 88 a6 00 00 00    	mov    %cl,0xa6(%eax)
801087b5:	0f b6 88 a6 00 00 00 	movzbl 0xa6(%eax),%ecx
801087bc:	83 e1 7f             	and    $0x7f,%ecx
801087bf:	88 88 a6 00 00 00    	mov    %cl,0xa6(%eax)
801087c5:	88 90 a7 00 00 00    	mov    %dl,0xa7(%eax)
  cpu->gdt[SEG_TSS].s = 0;
801087cb:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801087d1:	0f b6 90 a5 00 00 00 	movzbl 0xa5(%eax),%edx
801087d8:	83 e2 ef             	and    $0xffffffef,%edx
801087db:	88 90 a5 00 00 00    	mov    %dl,0xa5(%eax)
  cpu->ts.ss0 = SEG_KDATA << 3;
801087e1:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801087e7:	66 c7 40 10 10 00    	movw   $0x10,0x10(%eax)
  cpu->ts.esp0 = (uint)proc->kstack + KSTACKSIZE;
801087ed:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801087f3:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
801087fa:	8b 52 08             	mov    0x8(%edx),%edx
801087fd:	81 c2 00 10 00 00    	add    $0x1000,%edx
80108803:	89 50 0c             	mov    %edx,0xc(%eax)
  ltr(SEG_TSS << 3);
80108806:	c7 04 24 30 00 00 00 	movl   $0x30,(%esp)
8010880d:	e8 ef f7 ff ff       	call   80108001 <ltr>
  if(p->pgdir == 0)
80108812:	8b 45 08             	mov    0x8(%ebp),%eax
80108815:	8b 40 04             	mov    0x4(%eax),%eax
80108818:	85 c0                	test   %eax,%eax
8010881a:	75 0c                	jne    80108828 <switchuvm+0x146>
    panic("switchuvm: no pgdir");
8010881c:	c7 04 24 9b 94 10 80 	movl   $0x8010949b,(%esp)
80108823:	e8 15 7d ff ff       	call   8010053d <panic>
  lcr3(v2p(p->pgdir));  // switch to new address space
80108828:	8b 45 08             	mov    0x8(%ebp),%eax
8010882b:	8b 40 04             	mov    0x4(%eax),%eax
8010882e:	89 04 24             	mov    %eax,(%esp)
80108831:	e8 01 f8 ff ff       	call   80108037 <v2p>
80108836:	89 04 24             	mov    %eax,(%esp)
80108839:	e8 ee f7 ff ff       	call   8010802c <lcr3>
  popcli();
8010883e:	e8 50 d0 ff ff       	call   80105893 <popcli>
}
80108843:	83 c4 14             	add    $0x14,%esp
80108846:	5b                   	pop    %ebx
80108847:	5d                   	pop    %ebp
80108848:	c3                   	ret    

80108849 <inituvm>:

// Load the initcode into address 0 of pgdir.
// sz must be less than a page.
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
80108849:	55                   	push   %ebp
8010884a:	89 e5                	mov    %esp,%ebp
8010884c:	83 ec 38             	sub    $0x38,%esp
  char *mem;
  
  if(sz >= PGSIZE)
8010884f:	81 7d 10 ff 0f 00 00 	cmpl   $0xfff,0x10(%ebp)
80108856:	76 0c                	jbe    80108864 <inituvm+0x1b>
    panic("inituvm: more than a page");
80108858:	c7 04 24 af 94 10 80 	movl   $0x801094af,(%esp)
8010885f:	e8 d9 7c ff ff       	call   8010053d <panic>
  mem = kalloc();
80108864:	e8 8e a7 ff ff       	call   80102ff7 <kalloc>
80108869:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(mem, 0, PGSIZE);
8010886c:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
80108873:	00 
80108874:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
8010887b:	00 
8010887c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010887f:	89 04 24             	mov    %eax,(%esp)
80108882:	e8 cb d0 ff ff       	call   80105952 <memset>
  mappages(pgdir, 0, PGSIZE, v2p(mem), PTE_W|PTE_U);
80108887:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010888a:	89 04 24             	mov    %eax,(%esp)
8010888d:	e8 a5 f7 ff ff       	call   80108037 <v2p>
80108892:	c7 44 24 10 06 00 00 	movl   $0x6,0x10(%esp)
80108899:	00 
8010889a:	89 44 24 0c          	mov    %eax,0xc(%esp)
8010889e:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
801088a5:	00 
801088a6:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
801088ad:	00 
801088ae:	8b 45 08             	mov    0x8(%ebp),%eax
801088b1:	89 04 24             	mov    %eax,(%esp)
801088b4:	e8 a4 fc ff ff       	call   8010855d <mappages>
  memmove(mem, init, sz);
801088b9:	8b 45 10             	mov    0x10(%ebp),%eax
801088bc:	89 44 24 08          	mov    %eax,0x8(%esp)
801088c0:	8b 45 0c             	mov    0xc(%ebp),%eax
801088c3:	89 44 24 04          	mov    %eax,0x4(%esp)
801088c7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801088ca:	89 04 24             	mov    %eax,(%esp)
801088cd:	e8 53 d1 ff ff       	call   80105a25 <memmove>
}
801088d2:	c9                   	leave  
801088d3:	c3                   	ret    

801088d4 <loaduvm>:

// Load a program segment into pgdir.  addr must be page-aligned
// and the pages from addr to addr+sz must already be mapped.
int
loaduvm(pde_t *pgdir, char *addr, struct inode *ip, uint offset, uint sz)
{
801088d4:	55                   	push   %ebp
801088d5:	89 e5                	mov    %esp,%ebp
801088d7:	53                   	push   %ebx
801088d8:	83 ec 24             	sub    $0x24,%esp
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
801088db:	8b 45 0c             	mov    0xc(%ebp),%eax
801088de:	25 ff 0f 00 00       	and    $0xfff,%eax
801088e3:	85 c0                	test   %eax,%eax
801088e5:	74 0c                	je     801088f3 <loaduvm+0x1f>
    panic("loaduvm: addr must be page aligned");
801088e7:	c7 04 24 cc 94 10 80 	movl   $0x801094cc,(%esp)
801088ee:	e8 4a 7c ff ff       	call   8010053d <panic>
  for(i = 0; i < sz; i += PGSIZE){
801088f3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801088fa:	e9 ad 00 00 00       	jmp    801089ac <loaduvm+0xd8>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
801088ff:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108902:	8b 55 0c             	mov    0xc(%ebp),%edx
80108905:	01 d0                	add    %edx,%eax
80108907:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
8010890e:	00 
8010890f:	89 44 24 04          	mov    %eax,0x4(%esp)
80108913:	8b 45 08             	mov    0x8(%ebp),%eax
80108916:	89 04 24             	mov    %eax,(%esp)
80108919:	e8 a9 fb ff ff       	call   801084c7 <walkpgdir>
8010891e:	89 45 ec             	mov    %eax,-0x14(%ebp)
80108921:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80108925:	75 0c                	jne    80108933 <loaduvm+0x5f>
      panic("loaduvm: address should exist");
80108927:	c7 04 24 ef 94 10 80 	movl   $0x801094ef,(%esp)
8010892e:	e8 0a 7c ff ff       	call   8010053d <panic>
    pa = PTE_ADDR(*pte);
80108933:	8b 45 ec             	mov    -0x14(%ebp),%eax
80108936:	8b 00                	mov    (%eax),%eax
80108938:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010893d:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(sz - i < PGSIZE)
80108940:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108943:	8b 55 18             	mov    0x18(%ebp),%edx
80108946:	89 d1                	mov    %edx,%ecx
80108948:	29 c1                	sub    %eax,%ecx
8010894a:	89 c8                	mov    %ecx,%eax
8010894c:	3d ff 0f 00 00       	cmp    $0xfff,%eax
80108951:	77 11                	ja     80108964 <loaduvm+0x90>
      n = sz - i;
80108953:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108956:	8b 55 18             	mov    0x18(%ebp),%edx
80108959:	89 d1                	mov    %edx,%ecx
8010895b:	29 c1                	sub    %eax,%ecx
8010895d:	89 c8                	mov    %ecx,%eax
8010895f:	89 45 f0             	mov    %eax,-0x10(%ebp)
80108962:	eb 07                	jmp    8010896b <loaduvm+0x97>
    else
      n = PGSIZE;
80108964:	c7 45 f0 00 10 00 00 	movl   $0x1000,-0x10(%ebp)
    if(readi(ip, p2v(pa), offset+i, n) != n)
8010896b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010896e:	8b 55 14             	mov    0x14(%ebp),%edx
80108971:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
80108974:	8b 45 e8             	mov    -0x18(%ebp),%eax
80108977:	89 04 24             	mov    %eax,(%esp)
8010897a:	e8 c5 f6 ff ff       	call   80108044 <p2v>
8010897f:	8b 55 f0             	mov    -0x10(%ebp),%edx
80108982:	89 54 24 0c          	mov    %edx,0xc(%esp)
80108986:	89 5c 24 08          	mov    %ebx,0x8(%esp)
8010898a:	89 44 24 04          	mov    %eax,0x4(%esp)
8010898e:	8b 45 10             	mov    0x10(%ebp),%eax
80108991:	89 04 24             	mov    %eax,(%esp)
80108994:	e8 bd 98 ff ff       	call   80102256 <readi>
80108999:	3b 45 f0             	cmp    -0x10(%ebp),%eax
8010899c:	74 07                	je     801089a5 <loaduvm+0xd1>
      return -1;
8010899e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801089a3:	eb 18                	jmp    801089bd <loaduvm+0xe9>
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
801089a5:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
801089ac:	8b 45 f4             	mov    -0xc(%ebp),%eax
801089af:	3b 45 18             	cmp    0x18(%ebp),%eax
801089b2:	0f 82 47 ff ff ff    	jb     801088ff <loaduvm+0x2b>
    else
      n = PGSIZE;
    if(readi(ip, p2v(pa), offset+i, n) != n)
      return -1;
  }
  return 0;
801089b8:	b8 00 00 00 00       	mov    $0x0,%eax
}
801089bd:	83 c4 24             	add    $0x24,%esp
801089c0:	5b                   	pop    %ebx
801089c1:	5d                   	pop    %ebp
801089c2:	c3                   	ret    

801089c3 <allocuvm>:

// Allocate page tables and physical memory to grow process from oldsz to
// newsz, which need not be page aligned.  Returns new size or 0 on error.
int
allocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
801089c3:	55                   	push   %ebp
801089c4:	89 e5                	mov    %esp,%ebp
801089c6:	83 ec 38             	sub    $0x38,%esp
  char *mem;
  uint a;

  if(newsz >= KERNBASE)
801089c9:	8b 45 10             	mov    0x10(%ebp),%eax
801089cc:	85 c0                	test   %eax,%eax
801089ce:	79 0a                	jns    801089da <allocuvm+0x17>
    return 0;
801089d0:	b8 00 00 00 00       	mov    $0x0,%eax
801089d5:	e9 c1 00 00 00       	jmp    80108a9b <allocuvm+0xd8>
  if(newsz < oldsz)
801089da:	8b 45 10             	mov    0x10(%ebp),%eax
801089dd:	3b 45 0c             	cmp    0xc(%ebp),%eax
801089e0:	73 08                	jae    801089ea <allocuvm+0x27>
    return oldsz;
801089e2:	8b 45 0c             	mov    0xc(%ebp),%eax
801089e5:	e9 b1 00 00 00       	jmp    80108a9b <allocuvm+0xd8>

  a = PGROUNDUP(oldsz);
801089ea:	8b 45 0c             	mov    0xc(%ebp),%eax
801089ed:	05 ff 0f 00 00       	add    $0xfff,%eax
801089f2:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801089f7:	89 45 f4             	mov    %eax,-0xc(%ebp)
  for(; a < newsz; a += PGSIZE){
801089fa:	e9 8d 00 00 00       	jmp    80108a8c <allocuvm+0xc9>
    mem = kalloc();
801089ff:	e8 f3 a5 ff ff       	call   80102ff7 <kalloc>
80108a04:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(mem == 0){
80108a07:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80108a0b:	75 2c                	jne    80108a39 <allocuvm+0x76>
      cprintf("allocuvm out of memory\n");
80108a0d:	c7 04 24 0d 95 10 80 	movl   $0x8010950d,(%esp)
80108a14:	e8 88 79 ff ff       	call   801003a1 <cprintf>
      deallocuvm(pgdir, newsz, oldsz);
80108a19:	8b 45 0c             	mov    0xc(%ebp),%eax
80108a1c:	89 44 24 08          	mov    %eax,0x8(%esp)
80108a20:	8b 45 10             	mov    0x10(%ebp),%eax
80108a23:	89 44 24 04          	mov    %eax,0x4(%esp)
80108a27:	8b 45 08             	mov    0x8(%ebp),%eax
80108a2a:	89 04 24             	mov    %eax,(%esp)
80108a2d:	e8 6b 00 00 00       	call   80108a9d <deallocuvm>
      return 0;
80108a32:	b8 00 00 00 00       	mov    $0x0,%eax
80108a37:	eb 62                	jmp    80108a9b <allocuvm+0xd8>
    }
    memset(mem, 0, PGSIZE);
80108a39:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
80108a40:	00 
80108a41:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80108a48:	00 
80108a49:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108a4c:	89 04 24             	mov    %eax,(%esp)
80108a4f:	e8 fe ce ff ff       	call   80105952 <memset>
    mappages(pgdir, (char*)a, PGSIZE, v2p(mem), PTE_W|PTE_U);
80108a54:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108a57:	89 04 24             	mov    %eax,(%esp)
80108a5a:	e8 d8 f5 ff ff       	call   80108037 <v2p>
80108a5f:	8b 55 f4             	mov    -0xc(%ebp),%edx
80108a62:	c7 44 24 10 06 00 00 	movl   $0x6,0x10(%esp)
80108a69:	00 
80108a6a:	89 44 24 0c          	mov    %eax,0xc(%esp)
80108a6e:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
80108a75:	00 
80108a76:	89 54 24 04          	mov    %edx,0x4(%esp)
80108a7a:	8b 45 08             	mov    0x8(%ebp),%eax
80108a7d:	89 04 24             	mov    %eax,(%esp)
80108a80:	e8 d8 fa ff ff       	call   8010855d <mappages>
    return 0;
  if(newsz < oldsz)
    return oldsz;

  a = PGROUNDUP(oldsz);
  for(; a < newsz; a += PGSIZE){
80108a85:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
80108a8c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108a8f:	3b 45 10             	cmp    0x10(%ebp),%eax
80108a92:	0f 82 67 ff ff ff    	jb     801089ff <allocuvm+0x3c>
      return 0;
    }
    memset(mem, 0, PGSIZE);
    mappages(pgdir, (char*)a, PGSIZE, v2p(mem), PTE_W|PTE_U);
  }
  return newsz;
80108a98:	8b 45 10             	mov    0x10(%ebp),%eax
}
80108a9b:	c9                   	leave  
80108a9c:	c3                   	ret    

80108a9d <deallocuvm>:
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
80108a9d:	55                   	push   %ebp
80108a9e:	89 e5                	mov    %esp,%ebp
80108aa0:	83 ec 28             	sub    $0x28,%esp
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
80108aa3:	8b 45 10             	mov    0x10(%ebp),%eax
80108aa6:	3b 45 0c             	cmp    0xc(%ebp),%eax
80108aa9:	72 08                	jb     80108ab3 <deallocuvm+0x16>
    return oldsz;
80108aab:	8b 45 0c             	mov    0xc(%ebp),%eax
80108aae:	e9 a4 00 00 00       	jmp    80108b57 <deallocuvm+0xba>

  a = PGROUNDUP(newsz);
80108ab3:	8b 45 10             	mov    0x10(%ebp),%eax
80108ab6:	05 ff 0f 00 00       	add    $0xfff,%eax
80108abb:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108ac0:	89 45 f4             	mov    %eax,-0xc(%ebp)
  for(; a  < oldsz; a += PGSIZE){
80108ac3:	e9 80 00 00 00       	jmp    80108b48 <deallocuvm+0xab>
    pte = walkpgdir(pgdir, (char*)a, 0);
80108ac8:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108acb:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
80108ad2:	00 
80108ad3:	89 44 24 04          	mov    %eax,0x4(%esp)
80108ad7:	8b 45 08             	mov    0x8(%ebp),%eax
80108ada:	89 04 24             	mov    %eax,(%esp)
80108add:	e8 e5 f9 ff ff       	call   801084c7 <walkpgdir>
80108ae2:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(!pte)
80108ae5:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80108ae9:	75 09                	jne    80108af4 <deallocuvm+0x57>
      a += (NPTENTRIES - 1) * PGSIZE;
80108aeb:	81 45 f4 00 f0 3f 00 	addl   $0x3ff000,-0xc(%ebp)
80108af2:	eb 4d                	jmp    80108b41 <deallocuvm+0xa4>
    else if((*pte & PTE_P) != 0){
80108af4:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108af7:	8b 00                	mov    (%eax),%eax
80108af9:	83 e0 01             	and    $0x1,%eax
80108afc:	84 c0                	test   %al,%al
80108afe:	74 41                	je     80108b41 <deallocuvm+0xa4>
      pa = PTE_ADDR(*pte);
80108b00:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108b03:	8b 00                	mov    (%eax),%eax
80108b05:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108b0a:	89 45 ec             	mov    %eax,-0x14(%ebp)
      if(pa == 0)
80108b0d:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80108b11:	75 0c                	jne    80108b1f <deallocuvm+0x82>
        panic("kfree");
80108b13:	c7 04 24 25 95 10 80 	movl   $0x80109525,(%esp)
80108b1a:	e8 1e 7a ff ff       	call   8010053d <panic>
      char *v = p2v(pa);
80108b1f:	8b 45 ec             	mov    -0x14(%ebp),%eax
80108b22:	89 04 24             	mov    %eax,(%esp)
80108b25:	e8 1a f5 ff ff       	call   80108044 <p2v>
80108b2a:	89 45 e8             	mov    %eax,-0x18(%ebp)
      kfree(v);
80108b2d:	8b 45 e8             	mov    -0x18(%ebp),%eax
80108b30:	89 04 24             	mov    %eax,(%esp)
80108b33:	e8 26 a4 ff ff       	call   80102f5e <kfree>
      *pte = 0;
80108b38:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108b3b:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
  for(; a  < oldsz; a += PGSIZE){
80108b41:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
80108b48:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108b4b:	3b 45 0c             	cmp    0xc(%ebp),%eax
80108b4e:	0f 82 74 ff ff ff    	jb     80108ac8 <deallocuvm+0x2b>
      char *v = p2v(pa);
      kfree(v);
      *pte = 0;
    }
  }
  return newsz;
80108b54:	8b 45 10             	mov    0x10(%ebp),%eax
}
80108b57:	c9                   	leave  
80108b58:	c3                   	ret    

80108b59 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80108b59:	55                   	push   %ebp
80108b5a:	89 e5                	mov    %esp,%ebp
80108b5c:	83 ec 28             	sub    $0x28,%esp
  uint i;

  if(pgdir == 0)
80108b5f:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80108b63:	75 0c                	jne    80108b71 <freevm+0x18>
    panic("freevm: no pgdir");
80108b65:	c7 04 24 2b 95 10 80 	movl   $0x8010952b,(%esp)
80108b6c:	e8 cc 79 ff ff       	call   8010053d <panic>
  deallocuvm(pgdir, KERNBASE, 0);
80108b71:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
80108b78:	00 
80108b79:	c7 44 24 04 00 00 00 	movl   $0x80000000,0x4(%esp)
80108b80:	80 
80108b81:	8b 45 08             	mov    0x8(%ebp),%eax
80108b84:	89 04 24             	mov    %eax,(%esp)
80108b87:	e8 11 ff ff ff       	call   80108a9d <deallocuvm>
  for(i = 0; i < NPDENTRIES; i++){
80108b8c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80108b93:	eb 3c                	jmp    80108bd1 <freevm+0x78>
    if(pgdir[i] & PTE_P){
80108b95:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108b98:	c1 e0 02             	shl    $0x2,%eax
80108b9b:	03 45 08             	add    0x8(%ebp),%eax
80108b9e:	8b 00                	mov    (%eax),%eax
80108ba0:	83 e0 01             	and    $0x1,%eax
80108ba3:	84 c0                	test   %al,%al
80108ba5:	74 26                	je     80108bcd <freevm+0x74>
      char * v = p2v(PTE_ADDR(pgdir[i]));
80108ba7:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108baa:	c1 e0 02             	shl    $0x2,%eax
80108bad:	03 45 08             	add    0x8(%ebp),%eax
80108bb0:	8b 00                	mov    (%eax),%eax
80108bb2:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108bb7:	89 04 24             	mov    %eax,(%esp)
80108bba:	e8 85 f4 ff ff       	call   80108044 <p2v>
80108bbf:	89 45 f0             	mov    %eax,-0x10(%ebp)
      kfree(v);
80108bc2:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108bc5:	89 04 24             	mov    %eax,(%esp)
80108bc8:	e8 91 a3 ff ff       	call   80102f5e <kfree>
  uint i;

  if(pgdir == 0)
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80108bcd:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80108bd1:	81 7d f4 ff 03 00 00 	cmpl   $0x3ff,-0xc(%ebp)
80108bd8:	76 bb                	jbe    80108b95 <freevm+0x3c>
    if(pgdir[i] & PTE_P){
      char * v = p2v(PTE_ADDR(pgdir[i]));
      kfree(v);
    }
  }
  kfree((char*)pgdir);
80108bda:	8b 45 08             	mov    0x8(%ebp),%eax
80108bdd:	89 04 24             	mov    %eax,(%esp)
80108be0:	e8 79 a3 ff ff       	call   80102f5e <kfree>
}
80108be5:	c9                   	leave  
80108be6:	c3                   	ret    

80108be7 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80108be7:	55                   	push   %ebp
80108be8:	89 e5                	mov    %esp,%ebp
80108bea:	83 ec 28             	sub    $0x28,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80108bed:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
80108bf4:	00 
80108bf5:	8b 45 0c             	mov    0xc(%ebp),%eax
80108bf8:	89 44 24 04          	mov    %eax,0x4(%esp)
80108bfc:	8b 45 08             	mov    0x8(%ebp),%eax
80108bff:	89 04 24             	mov    %eax,(%esp)
80108c02:	e8 c0 f8 ff ff       	call   801084c7 <walkpgdir>
80108c07:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(pte == 0)
80108c0a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80108c0e:	75 0c                	jne    80108c1c <clearpteu+0x35>
    panic("clearpteu");
80108c10:	c7 04 24 3c 95 10 80 	movl   $0x8010953c,(%esp)
80108c17:	e8 21 79 ff ff       	call   8010053d <panic>
  *pte &= ~PTE_U;
80108c1c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108c1f:	8b 00                	mov    (%eax),%eax
80108c21:	89 c2                	mov    %eax,%edx
80108c23:	83 e2 fb             	and    $0xfffffffb,%edx
80108c26:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108c29:	89 10                	mov    %edx,(%eax)
}
80108c2b:	c9                   	leave  
80108c2c:	c3                   	ret    

80108c2d <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80108c2d:	55                   	push   %ebp
80108c2e:	89 e5                	mov    %esp,%ebp
80108c30:	83 ec 48             	sub    $0x48,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i;
  char *mem;

  if((d = setupkvm()) == 0)
80108c33:	e8 b9 f9 ff ff       	call   801085f1 <setupkvm>
80108c38:	89 45 f0             	mov    %eax,-0x10(%ebp)
80108c3b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80108c3f:	75 0a                	jne    80108c4b <copyuvm+0x1e>
    return 0;
80108c41:	b8 00 00 00 00       	mov    $0x0,%eax
80108c46:	e9 f1 00 00 00       	jmp    80108d3c <copyuvm+0x10f>
  for(i = 0; i < sz; i += PGSIZE){
80108c4b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80108c52:	e9 c0 00 00 00       	jmp    80108d17 <copyuvm+0xea>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80108c57:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108c5a:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
80108c61:	00 
80108c62:	89 44 24 04          	mov    %eax,0x4(%esp)
80108c66:	8b 45 08             	mov    0x8(%ebp),%eax
80108c69:	89 04 24             	mov    %eax,(%esp)
80108c6c:	e8 56 f8 ff ff       	call   801084c7 <walkpgdir>
80108c71:	89 45 ec             	mov    %eax,-0x14(%ebp)
80108c74:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80108c78:	75 0c                	jne    80108c86 <copyuvm+0x59>
      panic("copyuvm: pte should exist");
80108c7a:	c7 04 24 46 95 10 80 	movl   $0x80109546,(%esp)
80108c81:	e8 b7 78 ff ff       	call   8010053d <panic>
    if(!(*pte & PTE_P))
80108c86:	8b 45 ec             	mov    -0x14(%ebp),%eax
80108c89:	8b 00                	mov    (%eax),%eax
80108c8b:	83 e0 01             	and    $0x1,%eax
80108c8e:	85 c0                	test   %eax,%eax
80108c90:	75 0c                	jne    80108c9e <copyuvm+0x71>
      panic("copyuvm: page not present");
80108c92:	c7 04 24 60 95 10 80 	movl   $0x80109560,(%esp)
80108c99:	e8 9f 78 ff ff       	call   8010053d <panic>
    pa = PTE_ADDR(*pte);
80108c9e:	8b 45 ec             	mov    -0x14(%ebp),%eax
80108ca1:	8b 00                	mov    (%eax),%eax
80108ca3:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108ca8:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if((mem = kalloc()) == 0)
80108cab:	e8 47 a3 ff ff       	call   80102ff7 <kalloc>
80108cb0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80108cb3:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
80108cb7:	74 6f                	je     80108d28 <copyuvm+0xfb>
      goto bad;
    memmove(mem, (char*)p2v(pa), PGSIZE);
80108cb9:	8b 45 e8             	mov    -0x18(%ebp),%eax
80108cbc:	89 04 24             	mov    %eax,(%esp)
80108cbf:	e8 80 f3 ff ff       	call   80108044 <p2v>
80108cc4:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
80108ccb:	00 
80108ccc:	89 44 24 04          	mov    %eax,0x4(%esp)
80108cd0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80108cd3:	89 04 24             	mov    %eax,(%esp)
80108cd6:	e8 4a cd ff ff       	call   80105a25 <memmove>
    if(mappages(d, (void*)i, PGSIZE, v2p(mem), PTE_W|PTE_U) < 0)
80108cdb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80108cde:	89 04 24             	mov    %eax,(%esp)
80108ce1:	e8 51 f3 ff ff       	call   80108037 <v2p>
80108ce6:	8b 55 f4             	mov    -0xc(%ebp),%edx
80108ce9:	c7 44 24 10 06 00 00 	movl   $0x6,0x10(%esp)
80108cf0:	00 
80108cf1:	89 44 24 0c          	mov    %eax,0xc(%esp)
80108cf5:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
80108cfc:	00 
80108cfd:	89 54 24 04          	mov    %edx,0x4(%esp)
80108d01:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108d04:	89 04 24             	mov    %eax,(%esp)
80108d07:	e8 51 f8 ff ff       	call   8010855d <mappages>
80108d0c:	85 c0                	test   %eax,%eax
80108d0e:	78 1b                	js     80108d2b <copyuvm+0xfe>
  uint pa, i;
  char *mem;

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80108d10:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
80108d17:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108d1a:	3b 45 0c             	cmp    0xc(%ebp),%eax
80108d1d:	0f 82 34 ff ff ff    	jb     80108c57 <copyuvm+0x2a>
      goto bad;
    memmove(mem, (char*)p2v(pa), PGSIZE);
    if(mappages(d, (void*)i, PGSIZE, v2p(mem), PTE_W|PTE_U) < 0)
      goto bad;
  }
  return d;
80108d23:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108d26:	eb 14                	jmp    80108d3c <copyuvm+0x10f>
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P))
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
80108d28:	90                   	nop
80108d29:	eb 01                	jmp    80108d2c <copyuvm+0xff>
    memmove(mem, (char*)p2v(pa), PGSIZE);
    if(mappages(d, (void*)i, PGSIZE, v2p(mem), PTE_W|PTE_U) < 0)
      goto bad;
80108d2b:	90                   	nop
  }
  return d;

bad:
  freevm(d);
80108d2c:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108d2f:	89 04 24             	mov    %eax,(%esp)
80108d32:	e8 22 fe ff ff       	call   80108b59 <freevm>
  return 0;
80108d37:	b8 00 00 00 00       	mov    $0x0,%eax
}
80108d3c:	c9                   	leave  
80108d3d:	c3                   	ret    

80108d3e <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80108d3e:	55                   	push   %ebp
80108d3f:	89 e5                	mov    %esp,%ebp
80108d41:	83 ec 28             	sub    $0x28,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80108d44:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
80108d4b:	00 
80108d4c:	8b 45 0c             	mov    0xc(%ebp),%eax
80108d4f:	89 44 24 04          	mov    %eax,0x4(%esp)
80108d53:	8b 45 08             	mov    0x8(%ebp),%eax
80108d56:	89 04 24             	mov    %eax,(%esp)
80108d59:	e8 69 f7 ff ff       	call   801084c7 <walkpgdir>
80108d5e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if((*pte & PTE_P) == 0)
80108d61:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108d64:	8b 00                	mov    (%eax),%eax
80108d66:	83 e0 01             	and    $0x1,%eax
80108d69:	85 c0                	test   %eax,%eax
80108d6b:	75 07                	jne    80108d74 <uva2ka+0x36>
    return 0;
80108d6d:	b8 00 00 00 00       	mov    $0x0,%eax
80108d72:	eb 25                	jmp    80108d99 <uva2ka+0x5b>
  if((*pte & PTE_U) == 0)
80108d74:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108d77:	8b 00                	mov    (%eax),%eax
80108d79:	83 e0 04             	and    $0x4,%eax
80108d7c:	85 c0                	test   %eax,%eax
80108d7e:	75 07                	jne    80108d87 <uva2ka+0x49>
    return 0;
80108d80:	b8 00 00 00 00       	mov    $0x0,%eax
80108d85:	eb 12                	jmp    80108d99 <uva2ka+0x5b>
  return (char*)p2v(PTE_ADDR(*pte));
80108d87:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108d8a:	8b 00                	mov    (%eax),%eax
80108d8c:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108d91:	89 04 24             	mov    %eax,(%esp)
80108d94:	e8 ab f2 ff ff       	call   80108044 <p2v>
}
80108d99:	c9                   	leave  
80108d9a:	c3                   	ret    

80108d9b <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80108d9b:	55                   	push   %ebp
80108d9c:	89 e5                	mov    %esp,%ebp
80108d9e:	83 ec 28             	sub    $0x28,%esp
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
80108da1:	8b 45 10             	mov    0x10(%ebp),%eax
80108da4:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(len > 0){
80108da7:	e9 8b 00 00 00       	jmp    80108e37 <copyout+0x9c>
    va0 = (uint)PGROUNDDOWN(va);
80108dac:	8b 45 0c             	mov    0xc(%ebp),%eax
80108daf:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108db4:	89 45 ec             	mov    %eax,-0x14(%ebp)
    pa0 = uva2ka(pgdir, (char*)va0);
80108db7:	8b 45 ec             	mov    -0x14(%ebp),%eax
80108dba:	89 44 24 04          	mov    %eax,0x4(%esp)
80108dbe:	8b 45 08             	mov    0x8(%ebp),%eax
80108dc1:	89 04 24             	mov    %eax,(%esp)
80108dc4:	e8 75 ff ff ff       	call   80108d3e <uva2ka>
80108dc9:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(pa0 == 0)
80108dcc:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
80108dd0:	75 07                	jne    80108dd9 <copyout+0x3e>
      return -1;
80108dd2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80108dd7:	eb 6d                	jmp    80108e46 <copyout+0xab>
    n = PGSIZE - (va - va0);
80108dd9:	8b 45 0c             	mov    0xc(%ebp),%eax
80108ddc:	8b 55 ec             	mov    -0x14(%ebp),%edx
80108ddf:	89 d1                	mov    %edx,%ecx
80108de1:	29 c1                	sub    %eax,%ecx
80108de3:	89 c8                	mov    %ecx,%eax
80108de5:	05 00 10 00 00       	add    $0x1000,%eax
80108dea:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(n > len)
80108ded:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108df0:	3b 45 14             	cmp    0x14(%ebp),%eax
80108df3:	76 06                	jbe    80108dfb <copyout+0x60>
      n = len;
80108df5:	8b 45 14             	mov    0x14(%ebp),%eax
80108df8:	89 45 f0             	mov    %eax,-0x10(%ebp)
    memmove(pa0 + (va - va0), buf, n);
80108dfb:	8b 45 ec             	mov    -0x14(%ebp),%eax
80108dfe:	8b 55 0c             	mov    0xc(%ebp),%edx
80108e01:	89 d1                	mov    %edx,%ecx
80108e03:	29 c1                	sub    %eax,%ecx
80108e05:	89 c8                	mov    %ecx,%eax
80108e07:	03 45 e8             	add    -0x18(%ebp),%eax
80108e0a:	8b 55 f0             	mov    -0x10(%ebp),%edx
80108e0d:	89 54 24 08          	mov    %edx,0x8(%esp)
80108e11:	8b 55 f4             	mov    -0xc(%ebp),%edx
80108e14:	89 54 24 04          	mov    %edx,0x4(%esp)
80108e18:	89 04 24             	mov    %eax,(%esp)
80108e1b:	e8 05 cc ff ff       	call   80105a25 <memmove>
    len -= n;
80108e20:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108e23:	29 45 14             	sub    %eax,0x14(%ebp)
    buf += n;
80108e26:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108e29:	01 45 f4             	add    %eax,-0xc(%ebp)
    va = va0 + PGSIZE;
80108e2c:	8b 45 ec             	mov    -0x14(%ebp),%eax
80108e2f:	05 00 10 00 00       	add    $0x1000,%eax
80108e34:	89 45 0c             	mov    %eax,0xc(%ebp)
{
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80108e37:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
80108e3b:	0f 85 6b ff ff ff    	jne    80108dac <copyout+0x11>
    memmove(pa0 + (va - va0), buf, n);
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
80108e41:	b8 00 00 00 00       	mov    $0x0,%eax
}
80108e46:	c9                   	leave  
80108e47:	c3                   	ret    
