
_tTest:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
         29 , 31 , 37 , 41 , 43 , 47 , 53 , 59 , 61 , 67 , 71,
         73 , 79 , 83 , 89 , 97 , 101 , 103 , 107 , 109 , 113,
         127 , 131 , 137 , 139 , 149 , 151 , 157 , 163 , 167 , 173};

int main(int argc, char **argv)
{
       0:	55                   	push   %ebp
       1:	89 e5                	mov    %esp,%ebp
       3:	83 e4 f0             	and    $0xfffffff0,%esp
       6:	83 ec 20             	sub    $0x20,%esp
 int i;
 uthread_init();
       9:	e8 27 0b 00 00       	call   b35 <uthread_init>
 printf(1, "Creating threads\n");
       e:	c7 44 24 04 b0 10 00 	movl   $0x10b0,0x4(%esp)
      15:	00 
      16:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
      1d:	e8 75 05 00 00       	call   597 <printf>
 for (i = 0; i < NUM_SELLERS; i++)
      22:	c7 44 24 1c 00 00 00 	movl   $0x0,0x1c(%esp)
      29:	00 
      2a:	eb 21                	jmp    4d <main+0x4d>
    uthread_create(SellTickets, randomSleeps + i);
      2c:	8b 44 24 1c          	mov    0x1c(%esp),%eax
      30:	c1 e0 02             	shl    $0x2,%eax
      33:	05 a0 16 00 00       	add    $0x16a0,%eax
      38:	89 44 24 04          	mov    %eax,0x4(%esp)
      3c:	c7 04 24 c8 00 00 00 	movl   $0xc8,(%esp)
      43:	e8 c3 0b 00 00       	call   c0b <uthread_create>
int main(int argc, char **argv)
{
 int i;
 uthread_init();
 printf(1, "Creating threads\n");
 for (i = 0; i < NUM_SELLERS; i++)
      48:	83 44 24 1c 01       	addl   $0x1,0x1c(%esp)
      4d:	83 7c 24 1c 13       	cmpl   $0x13,0x1c(%esp)
      52:	7e d8                	jle    2c <main+0x2c>
    uthread_create(SellTickets, randomSleeps + i);
  
binary_semaphore_init(&ticketsLock, 1);
      54:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
      5b:	00 
      5c:	c7 04 24 60 17 00 00 	movl   $0x1760,(%esp)
      63:	e8 39 0f 00 00       	call   fa1 <binary_semaphore_init>
 printf(1, "Start selling\n");
      68:	c7 44 24 04 c2 10 00 	movl   $0x10c2,0x4(%esp)
      6f:	00 
      70:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
      77:	e8 1b 05 00 00       	call   597 <printf>
 uthread_yield(); // Let all threads loose
      7c:	e8 ee 0d 00 00       	call   e6f <uthread_yield>

 printf(1, "All done!\n");
      81:	c7 44 24 04 d1 10 00 	movl   $0x10d1,0x4(%esp)
      88:	00 
      89:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
      90:	e8 02 05 00 00       	call   597 <printf>

 uthread_exit();
      95:	e8 db 0b 00 00       	call   c75 <uthread_exit>
 exit(); // satisfy gcc
      9a:	e8 49 03 00 00       	call   3e8 <exit>

0000009f <delay>:
}

static void delay(int i) {
      9f:	55                   	push   %ebp
      a0:	89 e5                	mov    %esp,%ebp
      a2:	83 ec 28             	sub    $0x28,%esp
    int j;
    for (j=0; j<i; j++)
      a5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
      ac:	eb 10                	jmp    be <delay+0x1f>
        sleep(1);
      ae:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
      b5:	e8 be 03 00 00       	call   478 <sleep>
 exit(); // satisfy gcc
}

static void delay(int i) {
    int j;
    for (j=0; j<i; j++)
      ba:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      be:	8b 45 f4             	mov    -0xc(%ebp),%eax
      c1:	3b 45 08             	cmp    0x8(%ebp),%eax
      c4:	7c e8                	jl     ae <delay+0xf>
        sleep(1);
}
      c6:	c9                   	leave  
      c7:	c3                   	ret    

000000c8 <SellTickets>:
 * to sell. Before accessing the global numTickets variable,
 * it acquires the ticketsLock to ensure that our threads don't step
 * on one another and oversell on the number of tickets.
 */
void SellTickets(void* arg)
{
      c8:	55                   	push   %ebp
      c9:	89 e5                	mov    %esp,%ebp
      cb:	53                   	push   %ebx
      cc:	83 ec 24             	sub    $0x24,%esp
 int done = 0;
      cf:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 int numSoldByThisThread = 0; // local vars are unique to each thread
      d6:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 int sleepArg = *(int*)arg;
      dd:	8b 45 08             	mov    0x8(%ebp),%eax
      e0:	8b 00                	mov    (%eax),%eax
      e2:	89 45 ec             	mov    %eax,-0x14(%ebp)

 while (done == 0) {
      e5:	eb 6d                	jmp    154 <SellTickets+0x8c>
    delay(sleepArg);
      e7:	8b 45 ec             	mov    -0x14(%ebp),%eax
      ea:	89 04 24             	mov    %eax,(%esp)
      ed:	e8 ad ff ff ff       	call   9f <delay>
    binary_semaphore_down(&ticketsLock);
      f2:	c7 04 24 60 17 00 00 	movl   $0x1760,(%esp)
      f9:	e8 e4 0e 00 00       	call   fe2 <binary_semaphore_down>
    if (numTickets == 0) {
      fe:	a1 80 16 00 00       	mov    0x1680,%eax
     103:	85 c0                	test   %eax,%eax
     105:	75 09                	jne    110 <SellTickets+0x48>
        // here is safe to access numTickets
        done = 1;
     107:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
     10e:	eb 38                	jmp    148 <SellTickets+0x80>
    } else {
        numTickets--;
     110:	a1 80 16 00 00       	mov    0x1680,%eax
     115:	83 e8 01             	sub    $0x1,%eax
     118:	a3 80 16 00 00       	mov    %eax,0x1680
        numSoldByThisThread++;
     11d:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
        printf(1, "%d sold one (%d left)\n", uthread_self(), numTickets);
     121:	8b 1d 80 16 00 00    	mov    0x1680,%ebx
     127:	e8 44 0e 00 00       	call   f70 <uthread_self>
     12c:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
     130:	89 44 24 08          	mov    %eax,0x8(%esp)
     134:	c7 44 24 04 dc 10 00 	movl   $0x10dc,0x4(%esp)
     13b:	00 
     13c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     143:	e8 4f 04 00 00       	call   597 <printf>
    }

    binary_semaphore_up(&ticketsLock);
     148:	c7 04 24 60 17 00 00 	movl   $0x1760,(%esp)
     14f:	e8 fa 0e 00 00       	call   104e <binary_semaphore_up>
{
 int done = 0;
 int numSoldByThisThread = 0; // local vars are unique to each thread
 int sleepArg = *(int*)arg;

 while (done == 0) {
     154:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     158:	74 8d                	je     e7 <SellTickets+0x1f>
        printf(1, "%d sold one (%d left)\n", uthread_self(), numTickets);
    }

    binary_semaphore_up(&ticketsLock);
 }
 printf(1, "%d noticed all tickets sold! (I sold %d myself) \n", uthread_self(), numSoldByThisThread);
     15a:	e8 11 0e 00 00       	call   f70 <uthread_self>
     15f:	8b 55 f0             	mov    -0x10(%ebp),%edx
     162:	89 54 24 0c          	mov    %edx,0xc(%esp)
     166:	89 44 24 08          	mov    %eax,0x8(%esp)
     16a:	c7 44 24 04 f4 10 00 	movl   $0x10f4,0x4(%esp)
     171:	00 
     172:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     179:	e8 19 04 00 00       	call   597 <printf>
}
     17e:	83 c4 24             	add    $0x24,%esp
     181:	5b                   	pop    %ebx
     182:	5d                   	pop    %ebp
     183:	c3                   	ret    

00000184 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
     184:	55                   	push   %ebp
     185:	89 e5                	mov    %esp,%ebp
     187:	57                   	push   %edi
     188:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
     189:	8b 4d 08             	mov    0x8(%ebp),%ecx
     18c:	8b 55 10             	mov    0x10(%ebp),%edx
     18f:	8b 45 0c             	mov    0xc(%ebp),%eax
     192:	89 cb                	mov    %ecx,%ebx
     194:	89 df                	mov    %ebx,%edi
     196:	89 d1                	mov    %edx,%ecx
     198:	fc                   	cld    
     199:	f3 aa                	rep stos %al,%es:(%edi)
     19b:	89 ca                	mov    %ecx,%edx
     19d:	89 fb                	mov    %edi,%ebx
     19f:	89 5d 08             	mov    %ebx,0x8(%ebp)
     1a2:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
     1a5:	5b                   	pop    %ebx
     1a6:	5f                   	pop    %edi
     1a7:	5d                   	pop    %ebp
     1a8:	c3                   	ret    

000001a9 <strcpy>:
#include "x86.h"


char*
strcpy(char *s, char *t)
{
     1a9:	55                   	push   %ebp
     1aa:	89 e5                	mov    %esp,%ebp
     1ac:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
     1af:	8b 45 08             	mov    0x8(%ebp),%eax
     1b2:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
     1b5:	90                   	nop
     1b6:	8b 45 0c             	mov    0xc(%ebp),%eax
     1b9:	0f b6 10             	movzbl (%eax),%edx
     1bc:	8b 45 08             	mov    0x8(%ebp),%eax
     1bf:	88 10                	mov    %dl,(%eax)
     1c1:	8b 45 08             	mov    0x8(%ebp),%eax
     1c4:	0f b6 00             	movzbl (%eax),%eax
     1c7:	84 c0                	test   %al,%al
     1c9:	0f 95 c0             	setne  %al
     1cc:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     1d0:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
     1d4:	84 c0                	test   %al,%al
     1d6:	75 de                	jne    1b6 <strcpy+0xd>
    ;
  return os;
     1d8:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     1db:	c9                   	leave  
     1dc:	c3                   	ret    

000001dd <strcmp>:

int
strcmp(const char *p, const char *q)
{
     1dd:	55                   	push   %ebp
     1de:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
     1e0:	eb 08                	jmp    1ea <strcmp+0xd>
    p++, q++;
     1e2:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     1e6:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
     1ea:	8b 45 08             	mov    0x8(%ebp),%eax
     1ed:	0f b6 00             	movzbl (%eax),%eax
     1f0:	84 c0                	test   %al,%al
     1f2:	74 10                	je     204 <strcmp+0x27>
     1f4:	8b 45 08             	mov    0x8(%ebp),%eax
     1f7:	0f b6 10             	movzbl (%eax),%edx
     1fa:	8b 45 0c             	mov    0xc(%ebp),%eax
     1fd:	0f b6 00             	movzbl (%eax),%eax
     200:	38 c2                	cmp    %al,%dl
     202:	74 de                	je     1e2 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
     204:	8b 45 08             	mov    0x8(%ebp),%eax
     207:	0f b6 00             	movzbl (%eax),%eax
     20a:	0f b6 d0             	movzbl %al,%edx
     20d:	8b 45 0c             	mov    0xc(%ebp),%eax
     210:	0f b6 00             	movzbl (%eax),%eax
     213:	0f b6 c0             	movzbl %al,%eax
     216:	89 d1                	mov    %edx,%ecx
     218:	29 c1                	sub    %eax,%ecx
     21a:	89 c8                	mov    %ecx,%eax
}
     21c:	5d                   	pop    %ebp
     21d:	c3                   	ret    

0000021e <strlen>:

uint
strlen(char *s)
{
     21e:	55                   	push   %ebp
     21f:	89 e5                	mov    %esp,%ebp
     221:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
     224:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
     22b:	eb 04                	jmp    231 <strlen+0x13>
     22d:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     231:	8b 45 fc             	mov    -0x4(%ebp),%eax
     234:	03 45 08             	add    0x8(%ebp),%eax
     237:	0f b6 00             	movzbl (%eax),%eax
     23a:	84 c0                	test   %al,%al
     23c:	75 ef                	jne    22d <strlen+0xf>
    ;
  return n;
     23e:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     241:	c9                   	leave  
     242:	c3                   	ret    

00000243 <memset>:

void*
memset(void *dst, int c, uint n)
{
     243:	55                   	push   %ebp
     244:	89 e5                	mov    %esp,%ebp
     246:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
     249:	8b 45 10             	mov    0x10(%ebp),%eax
     24c:	89 44 24 08          	mov    %eax,0x8(%esp)
     250:	8b 45 0c             	mov    0xc(%ebp),%eax
     253:	89 44 24 04          	mov    %eax,0x4(%esp)
     257:	8b 45 08             	mov    0x8(%ebp),%eax
     25a:	89 04 24             	mov    %eax,(%esp)
     25d:	e8 22 ff ff ff       	call   184 <stosb>
  return dst;
     262:	8b 45 08             	mov    0x8(%ebp),%eax
}
     265:	c9                   	leave  
     266:	c3                   	ret    

00000267 <strchr>:

char*
strchr(const char *s, char c)
{
     267:	55                   	push   %ebp
     268:	89 e5                	mov    %esp,%ebp
     26a:	83 ec 04             	sub    $0x4,%esp
     26d:	8b 45 0c             	mov    0xc(%ebp),%eax
     270:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
     273:	eb 14                	jmp    289 <strchr+0x22>
    if(*s == c)
     275:	8b 45 08             	mov    0x8(%ebp),%eax
     278:	0f b6 00             	movzbl (%eax),%eax
     27b:	3a 45 fc             	cmp    -0x4(%ebp),%al
     27e:	75 05                	jne    285 <strchr+0x1e>
      return (char*)s;
     280:	8b 45 08             	mov    0x8(%ebp),%eax
     283:	eb 13                	jmp    298 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
     285:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     289:	8b 45 08             	mov    0x8(%ebp),%eax
     28c:	0f b6 00             	movzbl (%eax),%eax
     28f:	84 c0                	test   %al,%al
     291:	75 e2                	jne    275 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
     293:	b8 00 00 00 00       	mov    $0x0,%eax
}
     298:	c9                   	leave  
     299:	c3                   	ret    

0000029a <gets>:

char*
gets(char *buf, int max)
{
     29a:	55                   	push   %ebp
     29b:	89 e5                	mov    %esp,%ebp
     29d:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     2a0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     2a7:	eb 44                	jmp    2ed <gets+0x53>
    cc = read(0, &c, 1);
     2a9:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
     2b0:	00 
     2b1:	8d 45 ef             	lea    -0x11(%ebp),%eax
     2b4:	89 44 24 04          	mov    %eax,0x4(%esp)
     2b8:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     2bf:	e8 3c 01 00 00       	call   400 <read>
     2c4:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
     2c7:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     2cb:	7e 2d                	jle    2fa <gets+0x60>
      break;
    buf[i++] = c;
     2cd:	8b 45 f4             	mov    -0xc(%ebp),%eax
     2d0:	03 45 08             	add    0x8(%ebp),%eax
     2d3:	0f b6 55 ef          	movzbl -0x11(%ebp),%edx
     2d7:	88 10                	mov    %dl,(%eax)
     2d9:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    if(c == '\n' || c == '\r')
     2dd:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     2e1:	3c 0a                	cmp    $0xa,%al
     2e3:	74 16                	je     2fb <gets+0x61>
     2e5:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     2e9:	3c 0d                	cmp    $0xd,%al
     2eb:	74 0e                	je     2fb <gets+0x61>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     2ed:	8b 45 f4             	mov    -0xc(%ebp),%eax
     2f0:	83 c0 01             	add    $0x1,%eax
     2f3:	3b 45 0c             	cmp    0xc(%ebp),%eax
     2f6:	7c b1                	jl     2a9 <gets+0xf>
     2f8:	eb 01                	jmp    2fb <gets+0x61>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
     2fa:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
     2fb:	8b 45 f4             	mov    -0xc(%ebp),%eax
     2fe:	03 45 08             	add    0x8(%ebp),%eax
     301:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
     304:	8b 45 08             	mov    0x8(%ebp),%eax
}
     307:	c9                   	leave  
     308:	c3                   	ret    

00000309 <stat>:

int
stat(char *n, struct stat *st)
{
     309:	55                   	push   %ebp
     30a:	89 e5                	mov    %esp,%ebp
     30c:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     30f:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     316:	00 
     317:	8b 45 08             	mov    0x8(%ebp),%eax
     31a:	89 04 24             	mov    %eax,(%esp)
     31d:	e8 06 01 00 00       	call   428 <open>
     322:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
     325:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     329:	79 07                	jns    332 <stat+0x29>
    return -1;
     32b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     330:	eb 23                	jmp    355 <stat+0x4c>
  r = fstat(fd, st);
     332:	8b 45 0c             	mov    0xc(%ebp),%eax
     335:	89 44 24 04          	mov    %eax,0x4(%esp)
     339:	8b 45 f4             	mov    -0xc(%ebp),%eax
     33c:	89 04 24             	mov    %eax,(%esp)
     33f:	e8 fc 00 00 00       	call   440 <fstat>
     344:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
     347:	8b 45 f4             	mov    -0xc(%ebp),%eax
     34a:	89 04 24             	mov    %eax,(%esp)
     34d:	e8 be 00 00 00       	call   410 <close>
  return r;
     352:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     355:	c9                   	leave  
     356:	c3                   	ret    

00000357 <atoi>:

int
atoi(const char *s)
{
     357:	55                   	push   %ebp
     358:	89 e5                	mov    %esp,%ebp
     35a:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
     35d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
     364:	eb 23                	jmp    389 <atoi+0x32>
    n = n*10 + *s++ - '0';
     366:	8b 55 fc             	mov    -0x4(%ebp),%edx
     369:	89 d0                	mov    %edx,%eax
     36b:	c1 e0 02             	shl    $0x2,%eax
     36e:	01 d0                	add    %edx,%eax
     370:	01 c0                	add    %eax,%eax
     372:	89 c2                	mov    %eax,%edx
     374:	8b 45 08             	mov    0x8(%ebp),%eax
     377:	0f b6 00             	movzbl (%eax),%eax
     37a:	0f be c0             	movsbl %al,%eax
     37d:	01 d0                	add    %edx,%eax
     37f:	83 e8 30             	sub    $0x30,%eax
     382:	89 45 fc             	mov    %eax,-0x4(%ebp)
     385:	83 45 08 01          	addl   $0x1,0x8(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     389:	8b 45 08             	mov    0x8(%ebp),%eax
     38c:	0f b6 00             	movzbl (%eax),%eax
     38f:	3c 2f                	cmp    $0x2f,%al
     391:	7e 0a                	jle    39d <atoi+0x46>
     393:	8b 45 08             	mov    0x8(%ebp),%eax
     396:	0f b6 00             	movzbl (%eax),%eax
     399:	3c 39                	cmp    $0x39,%al
     39b:	7e c9                	jle    366 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
     39d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     3a0:	c9                   	leave  
     3a1:	c3                   	ret    

000003a2 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
     3a2:	55                   	push   %ebp
     3a3:	89 e5                	mov    %esp,%ebp
     3a5:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
     3a8:	8b 45 08             	mov    0x8(%ebp),%eax
     3ab:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
     3ae:	8b 45 0c             	mov    0xc(%ebp),%eax
     3b1:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
     3b4:	eb 13                	jmp    3c9 <memmove+0x27>
    *dst++ = *src++;
     3b6:	8b 45 f8             	mov    -0x8(%ebp),%eax
     3b9:	0f b6 10             	movzbl (%eax),%edx
     3bc:	8b 45 fc             	mov    -0x4(%ebp),%eax
     3bf:	88 10                	mov    %dl,(%eax)
     3c1:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     3c5:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
     3c9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     3cd:	0f 9f c0             	setg   %al
     3d0:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
     3d4:	84 c0                	test   %al,%al
     3d6:	75 de                	jne    3b6 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
     3d8:	8b 45 08             	mov    0x8(%ebp),%eax
}
     3db:	c9                   	leave  
     3dc:	c3                   	ret    
     3dd:	90                   	nop
     3de:	90                   	nop
     3df:	90                   	nop

000003e0 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     3e0:	b8 01 00 00 00       	mov    $0x1,%eax
     3e5:	cd 40                	int    $0x40
     3e7:	c3                   	ret    

000003e8 <exit>:
SYSCALL(exit)
     3e8:	b8 02 00 00 00       	mov    $0x2,%eax
     3ed:	cd 40                	int    $0x40
     3ef:	c3                   	ret    

000003f0 <wait>:
SYSCALL(wait)
     3f0:	b8 03 00 00 00       	mov    $0x3,%eax
     3f5:	cd 40                	int    $0x40
     3f7:	c3                   	ret    

000003f8 <pipe>:
SYSCALL(pipe)
     3f8:	b8 04 00 00 00       	mov    $0x4,%eax
     3fd:	cd 40                	int    $0x40
     3ff:	c3                   	ret    

00000400 <read>:
SYSCALL(read)
     400:	b8 05 00 00 00       	mov    $0x5,%eax
     405:	cd 40                	int    $0x40
     407:	c3                   	ret    

00000408 <write>:
SYSCALL(write)
     408:	b8 10 00 00 00       	mov    $0x10,%eax
     40d:	cd 40                	int    $0x40
     40f:	c3                   	ret    

00000410 <close>:
SYSCALL(close)
     410:	b8 15 00 00 00       	mov    $0x15,%eax
     415:	cd 40                	int    $0x40
     417:	c3                   	ret    

00000418 <kill>:
SYSCALL(kill)
     418:	b8 06 00 00 00       	mov    $0x6,%eax
     41d:	cd 40                	int    $0x40
     41f:	c3                   	ret    

00000420 <exec>:
SYSCALL(exec)
     420:	b8 07 00 00 00       	mov    $0x7,%eax
     425:	cd 40                	int    $0x40
     427:	c3                   	ret    

00000428 <open>:
SYSCALL(open)
     428:	b8 0f 00 00 00       	mov    $0xf,%eax
     42d:	cd 40                	int    $0x40
     42f:	c3                   	ret    

00000430 <mknod>:
SYSCALL(mknod)
     430:	b8 11 00 00 00       	mov    $0x11,%eax
     435:	cd 40                	int    $0x40
     437:	c3                   	ret    

00000438 <unlink>:
SYSCALL(unlink)
     438:	b8 12 00 00 00       	mov    $0x12,%eax
     43d:	cd 40                	int    $0x40
     43f:	c3                   	ret    

00000440 <fstat>:
SYSCALL(fstat)
     440:	b8 08 00 00 00       	mov    $0x8,%eax
     445:	cd 40                	int    $0x40
     447:	c3                   	ret    

00000448 <link>:
SYSCALL(link)
     448:	b8 13 00 00 00       	mov    $0x13,%eax
     44d:	cd 40                	int    $0x40
     44f:	c3                   	ret    

00000450 <mkdir>:
SYSCALL(mkdir)
     450:	b8 14 00 00 00       	mov    $0x14,%eax
     455:	cd 40                	int    $0x40
     457:	c3                   	ret    

00000458 <chdir>:
SYSCALL(chdir)
     458:	b8 09 00 00 00       	mov    $0x9,%eax
     45d:	cd 40                	int    $0x40
     45f:	c3                   	ret    

00000460 <dup>:
SYSCALL(dup)
     460:	b8 0a 00 00 00       	mov    $0xa,%eax
     465:	cd 40                	int    $0x40
     467:	c3                   	ret    

00000468 <getpid>:
SYSCALL(getpid)
     468:	b8 0b 00 00 00       	mov    $0xb,%eax
     46d:	cd 40                	int    $0x40
     46f:	c3                   	ret    

00000470 <sbrk>:
SYSCALL(sbrk)
     470:	b8 0c 00 00 00       	mov    $0xc,%eax
     475:	cd 40                	int    $0x40
     477:	c3                   	ret    

00000478 <sleep>:
SYSCALL(sleep)
     478:	b8 0d 00 00 00       	mov    $0xd,%eax
     47d:	cd 40                	int    $0x40
     47f:	c3                   	ret    

00000480 <uptime>:
SYSCALL(uptime)
     480:	b8 0e 00 00 00       	mov    $0xe,%eax
     485:	cd 40                	int    $0x40
     487:	c3                   	ret    

00000488 <add_path>:
SYSCALL(add_path)
     488:	b8 16 00 00 00       	mov    $0x16,%eax
     48d:	cd 40                	int    $0x40
     48f:	c3                   	ret    

00000490 <wait2>:
SYSCALL(wait2)
     490:	b8 17 00 00 00       	mov    $0x17,%eax
     495:	cd 40                	int    $0x40
     497:	c3                   	ret    

00000498 <getquanta>:
SYSCALL(getquanta)
     498:	b8 18 00 00 00       	mov    $0x18,%eax
     49d:	cd 40                	int    $0x40
     49f:	c3                   	ret    

000004a0 <getqueue>:
SYSCALL(getqueue)
     4a0:	b8 19 00 00 00       	mov    $0x19,%eax
     4a5:	cd 40                	int    $0x40
     4a7:	c3                   	ret    

000004a8 <signal>:
SYSCALL(signal)
     4a8:	b8 1a 00 00 00       	mov    $0x1a,%eax
     4ad:	cd 40                	int    $0x40
     4af:	c3                   	ret    

000004b0 <sigsend>:
SYSCALL(sigsend)
     4b0:	b8 1b 00 00 00       	mov    $0x1b,%eax
     4b5:	cd 40                	int    $0x40
     4b7:	c3                   	ret    

000004b8 <alarm>:
SYSCALL(alarm)
     4b8:	b8 1c 00 00 00       	mov    $0x1c,%eax
     4bd:	cd 40                	int    $0x40
     4bf:	c3                   	ret    

000004c0 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
     4c0:	55                   	push   %ebp
     4c1:	89 e5                	mov    %esp,%ebp
     4c3:	83 ec 28             	sub    $0x28,%esp
     4c6:	8b 45 0c             	mov    0xc(%ebp),%eax
     4c9:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
     4cc:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
     4d3:	00 
     4d4:	8d 45 f4             	lea    -0xc(%ebp),%eax
     4d7:	89 44 24 04          	mov    %eax,0x4(%esp)
     4db:	8b 45 08             	mov    0x8(%ebp),%eax
     4de:	89 04 24             	mov    %eax,(%esp)
     4e1:	e8 22 ff ff ff       	call   408 <write>
}
     4e6:	c9                   	leave  
     4e7:	c3                   	ret    

000004e8 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     4e8:	55                   	push   %ebp
     4e9:	89 e5                	mov    %esp,%ebp
     4eb:	83 ec 48             	sub    $0x48,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     4ee:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
     4f5:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     4f9:	74 17                	je     512 <printint+0x2a>
     4fb:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     4ff:	79 11                	jns    512 <printint+0x2a>
    neg = 1;
     501:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
     508:	8b 45 0c             	mov    0xc(%ebp),%eax
     50b:	f7 d8                	neg    %eax
     50d:	89 45 ec             	mov    %eax,-0x14(%ebp)
     510:	eb 06                	jmp    518 <printint+0x30>
  } else {
    x = xx;
     512:	8b 45 0c             	mov    0xc(%ebp),%eax
     515:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
     518:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
     51f:	8b 4d 10             	mov    0x10(%ebp),%ecx
     522:	8b 45 ec             	mov    -0x14(%ebp),%eax
     525:	ba 00 00 00 00       	mov    $0x0,%edx
     52a:	f7 f1                	div    %ecx
     52c:	89 d0                	mov    %edx,%eax
     52e:	0f b6 90 40 17 00 00 	movzbl 0x1740(%eax),%edx
     535:	8d 45 dc             	lea    -0x24(%ebp),%eax
     538:	03 45 f4             	add    -0xc(%ebp),%eax
     53b:	88 10                	mov    %dl,(%eax)
     53d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  }while((x /= base) != 0);
     541:	8b 55 10             	mov    0x10(%ebp),%edx
     544:	89 55 d4             	mov    %edx,-0x2c(%ebp)
     547:	8b 45 ec             	mov    -0x14(%ebp),%eax
     54a:	ba 00 00 00 00       	mov    $0x0,%edx
     54f:	f7 75 d4             	divl   -0x2c(%ebp)
     552:	89 45 ec             	mov    %eax,-0x14(%ebp)
     555:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     559:	75 c4                	jne    51f <printint+0x37>
  if(neg)
     55b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     55f:	74 2a                	je     58b <printint+0xa3>
    buf[i++] = '-';
     561:	8d 45 dc             	lea    -0x24(%ebp),%eax
     564:	03 45 f4             	add    -0xc(%ebp),%eax
     567:	c6 00 2d             	movb   $0x2d,(%eax)
     56a:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)

  while(--i >= 0)
     56e:	eb 1b                	jmp    58b <printint+0xa3>
    putc(fd, buf[i]);
     570:	8d 45 dc             	lea    -0x24(%ebp),%eax
     573:	03 45 f4             	add    -0xc(%ebp),%eax
     576:	0f b6 00             	movzbl (%eax),%eax
     579:	0f be c0             	movsbl %al,%eax
     57c:	89 44 24 04          	mov    %eax,0x4(%esp)
     580:	8b 45 08             	mov    0x8(%ebp),%eax
     583:	89 04 24             	mov    %eax,(%esp)
     586:	e8 35 ff ff ff       	call   4c0 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
     58b:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
     58f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     593:	79 db                	jns    570 <printint+0x88>
    putc(fd, buf[i]);
}
     595:	c9                   	leave  
     596:	c3                   	ret    

00000597 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     597:	55                   	push   %ebp
     598:	89 e5                	mov    %esp,%ebp
     59a:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
     59d:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
     5a4:	8d 45 0c             	lea    0xc(%ebp),%eax
     5a7:	83 c0 04             	add    $0x4,%eax
     5aa:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
     5ad:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     5b4:	e9 7d 01 00 00       	jmp    736 <printf+0x19f>
    c = fmt[i] & 0xff;
     5b9:	8b 55 0c             	mov    0xc(%ebp),%edx
     5bc:	8b 45 f0             	mov    -0x10(%ebp),%eax
     5bf:	01 d0                	add    %edx,%eax
     5c1:	0f b6 00             	movzbl (%eax),%eax
     5c4:	0f be c0             	movsbl %al,%eax
     5c7:	25 ff 00 00 00       	and    $0xff,%eax
     5cc:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
     5cf:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     5d3:	75 2c                	jne    601 <printf+0x6a>
      if(c == '%'){
     5d5:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     5d9:	75 0c                	jne    5e7 <printf+0x50>
        state = '%';
     5db:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
     5e2:	e9 4b 01 00 00       	jmp    732 <printf+0x19b>
      } else {
        putc(fd, c);
     5e7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     5ea:	0f be c0             	movsbl %al,%eax
     5ed:	89 44 24 04          	mov    %eax,0x4(%esp)
     5f1:	8b 45 08             	mov    0x8(%ebp),%eax
     5f4:	89 04 24             	mov    %eax,(%esp)
     5f7:	e8 c4 fe ff ff       	call   4c0 <putc>
     5fc:	e9 31 01 00 00       	jmp    732 <printf+0x19b>
      }
    } else if(state == '%'){
     601:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
     605:	0f 85 27 01 00 00    	jne    732 <printf+0x19b>
      if(c == 'd'){
     60b:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
     60f:	75 2d                	jne    63e <printf+0xa7>
        printint(fd, *ap, 10, 1);
     611:	8b 45 e8             	mov    -0x18(%ebp),%eax
     614:	8b 00                	mov    (%eax),%eax
     616:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
     61d:	00 
     61e:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
     625:	00 
     626:	89 44 24 04          	mov    %eax,0x4(%esp)
     62a:	8b 45 08             	mov    0x8(%ebp),%eax
     62d:	89 04 24             	mov    %eax,(%esp)
     630:	e8 b3 fe ff ff       	call   4e8 <printint>
        ap++;
     635:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     639:	e9 ed 00 00 00       	jmp    72b <printf+0x194>
      } else if(c == 'x' || c == 'p'){
     63e:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
     642:	74 06                	je     64a <printf+0xb3>
     644:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
     648:	75 2d                	jne    677 <printf+0xe0>
        printint(fd, *ap, 16, 0);
     64a:	8b 45 e8             	mov    -0x18(%ebp),%eax
     64d:	8b 00                	mov    (%eax),%eax
     64f:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
     656:	00 
     657:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
     65e:	00 
     65f:	89 44 24 04          	mov    %eax,0x4(%esp)
     663:	8b 45 08             	mov    0x8(%ebp),%eax
     666:	89 04 24             	mov    %eax,(%esp)
     669:	e8 7a fe ff ff       	call   4e8 <printint>
        ap++;
     66e:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     672:	e9 b4 00 00 00       	jmp    72b <printf+0x194>
      } else if(c == 's'){
     677:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
     67b:	75 46                	jne    6c3 <printf+0x12c>
        s = (char*)*ap;
     67d:	8b 45 e8             	mov    -0x18(%ebp),%eax
     680:	8b 00                	mov    (%eax),%eax
     682:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
     685:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
     689:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     68d:	75 27                	jne    6b6 <printf+0x11f>
          s = "(null)";
     68f:	c7 45 f4 26 11 00 00 	movl   $0x1126,-0xc(%ebp)
        while(*s != 0){
     696:	eb 1e                	jmp    6b6 <printf+0x11f>
          putc(fd, *s);
     698:	8b 45 f4             	mov    -0xc(%ebp),%eax
     69b:	0f b6 00             	movzbl (%eax),%eax
     69e:	0f be c0             	movsbl %al,%eax
     6a1:	89 44 24 04          	mov    %eax,0x4(%esp)
     6a5:	8b 45 08             	mov    0x8(%ebp),%eax
     6a8:	89 04 24             	mov    %eax,(%esp)
     6ab:	e8 10 fe ff ff       	call   4c0 <putc>
          s++;
     6b0:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     6b4:	eb 01                	jmp    6b7 <printf+0x120>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
     6b6:	90                   	nop
     6b7:	8b 45 f4             	mov    -0xc(%ebp),%eax
     6ba:	0f b6 00             	movzbl (%eax),%eax
     6bd:	84 c0                	test   %al,%al
     6bf:	75 d7                	jne    698 <printf+0x101>
     6c1:	eb 68                	jmp    72b <printf+0x194>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
     6c3:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
     6c7:	75 1d                	jne    6e6 <printf+0x14f>
        putc(fd, *ap);
     6c9:	8b 45 e8             	mov    -0x18(%ebp),%eax
     6cc:	8b 00                	mov    (%eax),%eax
     6ce:	0f be c0             	movsbl %al,%eax
     6d1:	89 44 24 04          	mov    %eax,0x4(%esp)
     6d5:	8b 45 08             	mov    0x8(%ebp),%eax
     6d8:	89 04 24             	mov    %eax,(%esp)
     6db:	e8 e0 fd ff ff       	call   4c0 <putc>
        ap++;
     6e0:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     6e4:	eb 45                	jmp    72b <printf+0x194>
      } else if(c == '%'){
     6e6:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     6ea:	75 17                	jne    703 <printf+0x16c>
        putc(fd, c);
     6ec:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     6ef:	0f be c0             	movsbl %al,%eax
     6f2:	89 44 24 04          	mov    %eax,0x4(%esp)
     6f6:	8b 45 08             	mov    0x8(%ebp),%eax
     6f9:	89 04 24             	mov    %eax,(%esp)
     6fc:	e8 bf fd ff ff       	call   4c0 <putc>
     701:	eb 28                	jmp    72b <printf+0x194>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     703:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
     70a:	00 
     70b:	8b 45 08             	mov    0x8(%ebp),%eax
     70e:	89 04 24             	mov    %eax,(%esp)
     711:	e8 aa fd ff ff       	call   4c0 <putc>
        putc(fd, c);
     716:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     719:	0f be c0             	movsbl %al,%eax
     71c:	89 44 24 04          	mov    %eax,0x4(%esp)
     720:	8b 45 08             	mov    0x8(%ebp),%eax
     723:	89 04 24             	mov    %eax,(%esp)
     726:	e8 95 fd ff ff       	call   4c0 <putc>
      }
      state = 0;
     72b:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     732:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     736:	8b 55 0c             	mov    0xc(%ebp),%edx
     739:	8b 45 f0             	mov    -0x10(%ebp),%eax
     73c:	01 d0                	add    %edx,%eax
     73e:	0f b6 00             	movzbl (%eax),%eax
     741:	84 c0                	test   %al,%al
     743:	0f 85 70 fe ff ff    	jne    5b9 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
     749:	c9                   	leave  
     74a:	c3                   	ret    
     74b:	90                   	nop

0000074c <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     74c:	55                   	push   %ebp
     74d:	89 e5                	mov    %esp,%ebp
     74f:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
     752:	8b 45 08             	mov    0x8(%ebp),%eax
     755:	83 e8 08             	sub    $0x8,%eax
     758:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     75b:	a1 74 17 00 00       	mov    0x1774,%eax
     760:	89 45 fc             	mov    %eax,-0x4(%ebp)
     763:	eb 24                	jmp    789 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     765:	8b 45 fc             	mov    -0x4(%ebp),%eax
     768:	8b 00                	mov    (%eax),%eax
     76a:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     76d:	77 12                	ja     781 <free+0x35>
     76f:	8b 45 f8             	mov    -0x8(%ebp),%eax
     772:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     775:	77 24                	ja     79b <free+0x4f>
     777:	8b 45 fc             	mov    -0x4(%ebp),%eax
     77a:	8b 00                	mov    (%eax),%eax
     77c:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     77f:	77 1a                	ja     79b <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     781:	8b 45 fc             	mov    -0x4(%ebp),%eax
     784:	8b 00                	mov    (%eax),%eax
     786:	89 45 fc             	mov    %eax,-0x4(%ebp)
     789:	8b 45 f8             	mov    -0x8(%ebp),%eax
     78c:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     78f:	76 d4                	jbe    765 <free+0x19>
     791:	8b 45 fc             	mov    -0x4(%ebp),%eax
     794:	8b 00                	mov    (%eax),%eax
     796:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     799:	76 ca                	jbe    765 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
     79b:	8b 45 f8             	mov    -0x8(%ebp),%eax
     79e:	8b 40 04             	mov    0x4(%eax),%eax
     7a1:	c1 e0 03             	shl    $0x3,%eax
     7a4:	89 c2                	mov    %eax,%edx
     7a6:	03 55 f8             	add    -0x8(%ebp),%edx
     7a9:	8b 45 fc             	mov    -0x4(%ebp),%eax
     7ac:	8b 00                	mov    (%eax),%eax
     7ae:	39 c2                	cmp    %eax,%edx
     7b0:	75 24                	jne    7d6 <free+0x8a>
    bp->s.size += p->s.ptr->s.size;
     7b2:	8b 45 f8             	mov    -0x8(%ebp),%eax
     7b5:	8b 50 04             	mov    0x4(%eax),%edx
     7b8:	8b 45 fc             	mov    -0x4(%ebp),%eax
     7bb:	8b 00                	mov    (%eax),%eax
     7bd:	8b 40 04             	mov    0x4(%eax),%eax
     7c0:	01 c2                	add    %eax,%edx
     7c2:	8b 45 f8             	mov    -0x8(%ebp),%eax
     7c5:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
     7c8:	8b 45 fc             	mov    -0x4(%ebp),%eax
     7cb:	8b 00                	mov    (%eax),%eax
     7cd:	8b 10                	mov    (%eax),%edx
     7cf:	8b 45 f8             	mov    -0x8(%ebp),%eax
     7d2:	89 10                	mov    %edx,(%eax)
     7d4:	eb 0a                	jmp    7e0 <free+0x94>
  } else
    bp->s.ptr = p->s.ptr;
     7d6:	8b 45 fc             	mov    -0x4(%ebp),%eax
     7d9:	8b 10                	mov    (%eax),%edx
     7db:	8b 45 f8             	mov    -0x8(%ebp),%eax
     7de:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
     7e0:	8b 45 fc             	mov    -0x4(%ebp),%eax
     7e3:	8b 40 04             	mov    0x4(%eax),%eax
     7e6:	c1 e0 03             	shl    $0x3,%eax
     7e9:	03 45 fc             	add    -0x4(%ebp),%eax
     7ec:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     7ef:	75 20                	jne    811 <free+0xc5>
    p->s.size += bp->s.size;
     7f1:	8b 45 fc             	mov    -0x4(%ebp),%eax
     7f4:	8b 50 04             	mov    0x4(%eax),%edx
     7f7:	8b 45 f8             	mov    -0x8(%ebp),%eax
     7fa:	8b 40 04             	mov    0x4(%eax),%eax
     7fd:	01 c2                	add    %eax,%edx
     7ff:	8b 45 fc             	mov    -0x4(%ebp),%eax
     802:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
     805:	8b 45 f8             	mov    -0x8(%ebp),%eax
     808:	8b 10                	mov    (%eax),%edx
     80a:	8b 45 fc             	mov    -0x4(%ebp),%eax
     80d:	89 10                	mov    %edx,(%eax)
     80f:	eb 08                	jmp    819 <free+0xcd>
  } else
    p->s.ptr = bp;
     811:	8b 45 fc             	mov    -0x4(%ebp),%eax
     814:	8b 55 f8             	mov    -0x8(%ebp),%edx
     817:	89 10                	mov    %edx,(%eax)
  freep = p;
     819:	8b 45 fc             	mov    -0x4(%ebp),%eax
     81c:	a3 74 17 00 00       	mov    %eax,0x1774
}
     821:	c9                   	leave  
     822:	c3                   	ret    

00000823 <morecore>:

static Header*
morecore(uint nu)
{
     823:	55                   	push   %ebp
     824:	89 e5                	mov    %esp,%ebp
     826:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
     829:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
     830:	77 07                	ja     839 <morecore+0x16>
    nu = 4096;
     832:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
     839:	8b 45 08             	mov    0x8(%ebp),%eax
     83c:	c1 e0 03             	shl    $0x3,%eax
     83f:	89 04 24             	mov    %eax,(%esp)
     842:	e8 29 fc ff ff       	call   470 <sbrk>
     847:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
     84a:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     84e:	75 07                	jne    857 <morecore+0x34>
    return 0;
     850:	b8 00 00 00 00       	mov    $0x0,%eax
     855:	eb 22                	jmp    879 <morecore+0x56>
  hp = (Header*)p;
     857:	8b 45 f4             	mov    -0xc(%ebp),%eax
     85a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
     85d:	8b 45 f0             	mov    -0x10(%ebp),%eax
     860:	8b 55 08             	mov    0x8(%ebp),%edx
     863:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
     866:	8b 45 f0             	mov    -0x10(%ebp),%eax
     869:	83 c0 08             	add    $0x8,%eax
     86c:	89 04 24             	mov    %eax,(%esp)
     86f:	e8 d8 fe ff ff       	call   74c <free>
  return freep;
     874:	a1 74 17 00 00       	mov    0x1774,%eax
}
     879:	c9                   	leave  
     87a:	c3                   	ret    

0000087b <malloc>:

void*
malloc(uint nbytes)
{
     87b:	55                   	push   %ebp
     87c:	89 e5                	mov    %esp,%ebp
     87e:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     881:	8b 45 08             	mov    0x8(%ebp),%eax
     884:	83 c0 07             	add    $0x7,%eax
     887:	c1 e8 03             	shr    $0x3,%eax
     88a:	83 c0 01             	add    $0x1,%eax
     88d:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
     890:	a1 74 17 00 00       	mov    0x1774,%eax
     895:	89 45 f0             	mov    %eax,-0x10(%ebp)
     898:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     89c:	75 23                	jne    8c1 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     89e:	c7 45 f0 6c 17 00 00 	movl   $0x176c,-0x10(%ebp)
     8a5:	8b 45 f0             	mov    -0x10(%ebp),%eax
     8a8:	a3 74 17 00 00       	mov    %eax,0x1774
     8ad:	a1 74 17 00 00       	mov    0x1774,%eax
     8b2:	a3 6c 17 00 00       	mov    %eax,0x176c
    base.s.size = 0;
     8b7:	c7 05 70 17 00 00 00 	movl   $0x0,0x1770
     8be:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     8c1:	8b 45 f0             	mov    -0x10(%ebp),%eax
     8c4:	8b 00                	mov    (%eax),%eax
     8c6:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
     8c9:	8b 45 f4             	mov    -0xc(%ebp),%eax
     8cc:	8b 40 04             	mov    0x4(%eax),%eax
     8cf:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     8d2:	72 4d                	jb     921 <malloc+0xa6>
      if(p->s.size == nunits)
     8d4:	8b 45 f4             	mov    -0xc(%ebp),%eax
     8d7:	8b 40 04             	mov    0x4(%eax),%eax
     8da:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     8dd:	75 0c                	jne    8eb <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
     8df:	8b 45 f4             	mov    -0xc(%ebp),%eax
     8e2:	8b 10                	mov    (%eax),%edx
     8e4:	8b 45 f0             	mov    -0x10(%ebp),%eax
     8e7:	89 10                	mov    %edx,(%eax)
     8e9:	eb 26                	jmp    911 <malloc+0x96>
      else {
        p->s.size -= nunits;
     8eb:	8b 45 f4             	mov    -0xc(%ebp),%eax
     8ee:	8b 40 04             	mov    0x4(%eax),%eax
     8f1:	89 c2                	mov    %eax,%edx
     8f3:	2b 55 ec             	sub    -0x14(%ebp),%edx
     8f6:	8b 45 f4             	mov    -0xc(%ebp),%eax
     8f9:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
     8fc:	8b 45 f4             	mov    -0xc(%ebp),%eax
     8ff:	8b 40 04             	mov    0x4(%eax),%eax
     902:	c1 e0 03             	shl    $0x3,%eax
     905:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
     908:	8b 45 f4             	mov    -0xc(%ebp),%eax
     90b:	8b 55 ec             	mov    -0x14(%ebp),%edx
     90e:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
     911:	8b 45 f0             	mov    -0x10(%ebp),%eax
     914:	a3 74 17 00 00       	mov    %eax,0x1774
      return (void*)(p + 1);
     919:	8b 45 f4             	mov    -0xc(%ebp),%eax
     91c:	83 c0 08             	add    $0x8,%eax
     91f:	eb 38                	jmp    959 <malloc+0xde>
    }
    if(p == freep)
     921:	a1 74 17 00 00       	mov    0x1774,%eax
     926:	39 45 f4             	cmp    %eax,-0xc(%ebp)
     929:	75 1b                	jne    946 <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
     92b:	8b 45 ec             	mov    -0x14(%ebp),%eax
     92e:	89 04 24             	mov    %eax,(%esp)
     931:	e8 ed fe ff ff       	call   823 <morecore>
     936:	89 45 f4             	mov    %eax,-0xc(%ebp)
     939:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     93d:	75 07                	jne    946 <malloc+0xcb>
        return 0;
     93f:	b8 00 00 00 00       	mov    $0x0,%eax
     944:	eb 13                	jmp    959 <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     946:	8b 45 f4             	mov    -0xc(%ebp),%eax
     949:	89 45 f0             	mov    %eax,-0x10(%ebp)
     94c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     94f:	8b 00                	mov    (%eax),%eax
     951:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
     954:	e9 70 ff ff ff       	jmp    8c9 <malloc+0x4e>
}
     959:	c9                   	leave  
     95a:	c3                   	ret    
     95b:	90                   	nop

0000095c <print_stack>:
 * prints the stack of the currently running thread
 * DEBUGGING purposes
 */
void
print_stack()
{
     95c:	55                   	push   %ebp
     95d:	89 e5                	mov    %esp,%ebp
     95f:	83 ec 28             	sub    $0x28,%esp
  int *newesp = (int*)currentThread->esp;  
     962:	a1 80 60 00 00       	mov    0x6080,%eax
     967:	8b 40 04             	mov    0x4(%eax),%eax
     96a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  printf(1,"stack for thread %d \n",currentThread->tid);
     96d:	a1 80 60 00 00       	mov    0x6080,%eax
     972:	8b 00                	mov    (%eax),%eax
     974:	89 44 24 08          	mov    %eax,0x8(%esp)
     978:	c7 44 24 04 30 11 00 	movl   $0x1130,0x4(%esp)
     97f:	00 
     980:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     987:	e8 0b fc ff ff       	call   597 <printf>
  while((newesp < (int *)currentThread->ebp))
     98c:	eb 3c                	jmp    9ca <print_stack+0x6e>
  {
    printf(1,"add:%x ",newesp);
     98e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     991:	89 44 24 08          	mov    %eax,0x8(%esp)
     995:	c7 44 24 04 46 11 00 	movl   $0x1146,0x4(%esp)
     99c:	00 
     99d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     9a4:	e8 ee fb ff ff       	call   597 <printf>
      printf(1,"val:%x\n",*newesp);
     9a9:	8b 45 f4             	mov    -0xc(%ebp),%eax
     9ac:	8b 00                	mov    (%eax),%eax
     9ae:	89 44 24 08          	mov    %eax,0x8(%esp)
     9b2:	c7 44 24 04 4e 11 00 	movl   $0x114e,0x4(%esp)
     9b9:	00 
     9ba:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     9c1:	e8 d1 fb ff ff       	call   597 <printf>
    newesp++;
     9c6:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
void
print_stack()
{
  int *newesp = (int*)currentThread->esp;  
  printf(1,"stack for thread %d \n",currentThread->tid);
  while((newesp < (int *)currentThread->ebp))
     9ca:	a1 80 60 00 00       	mov    0x6080,%eax
     9cf:	8b 40 08             	mov    0x8(%eax),%eax
     9d2:	3b 45 f4             	cmp    -0xc(%ebp),%eax
     9d5:	77 b7                	ja     98e <print_stack+0x32>
    printf(1,"add:%x ",newesp);
      printf(1,"val:%x\n",*newesp);
    newesp++;
  }

}
     9d7:	c9                   	leave  
     9d8:	c3                   	ret    

000009d9 <getNextThread>:
 * returns the next thread in line to run
 * if none exists it returns -1
 */
int
getNextThread(int j)
{
     9d9:	55                   	push   %ebp
     9da:	89 e5                	mov    %esp,%ebp
     9dc:	83 ec 10             	sub    $0x10,%esp
  int i=j+1;
     9df:	8b 45 08             	mov    0x8(%ebp),%eax
     9e2:	83 c0 01             	add    $0x1,%eax
     9e5:	89 45 fc             	mov    %eax,-0x4(%ebp)
  if(i==MAX_THREAD)
     9e8:	83 7d fc 40          	cmpl   $0x40,-0x4(%ebp)
     9ec:	75 07                	jne    9f5 <getNextThread+0x1c>
    i=0;
     9ee:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  uthread_p t=&tTable.table[i];
     9f5:	8b 45 fc             	mov    -0x4(%ebp),%eax
     9f8:	69 c0 24 01 00 00    	imul   $0x124,%eax,%eax
     9fe:	05 80 17 00 00       	add    $0x1780,%eax
     a03:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(i!=j)
     a06:	eb 3b                	jmp    a43 <getNextThread+0x6a>
  {
    if(t->state==T_RUNNABLE)
     a08:	8b 45 f8             	mov    -0x8(%ebp),%eax
     a0b:	8b 40 10             	mov    0x10(%eax),%eax
     a0e:	83 f8 03             	cmp    $0x3,%eax
     a11:	75 05                	jne    a18 <getNextThread+0x3f>
      return i;
     a13:	8b 45 fc             	mov    -0x4(%ebp),%eax
     a16:	eb 38                	jmp    a50 <getNextThread+0x77>
    i++;
     a18:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    if(i==MAX_THREAD)
     a1c:	83 7d fc 40          	cmpl   $0x40,-0x4(%ebp)
     a20:	75 1a                	jne    a3c <getNextThread+0x63>
    {
     i=0;
     a22:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
     t=&tTable.table[i];
     a29:	8b 45 fc             	mov    -0x4(%ebp),%eax
     a2c:	69 c0 24 01 00 00    	imul   $0x124,%eax,%eax
     a32:	05 80 17 00 00       	add    $0x1780,%eax
     a37:	89 45 f8             	mov    %eax,-0x8(%ebp)
     a3a:	eb 07                	jmp    a43 <getNextThread+0x6a>
   }
   else
    t++;
     a3c:	81 45 f8 24 01 00 00 	addl   $0x124,-0x8(%ebp)
{
  int i=j+1;
  if(i==MAX_THREAD)
    i=0;
  uthread_p t=&tTable.table[i];
  while(i!=j)
     a43:	8b 45 fc             	mov    -0x4(%ebp),%eax
     a46:	3b 45 08             	cmp    0x8(%ebp),%eax
     a49:	75 bd                	jne    a08 <getNextThread+0x2f>
   }
   else
    t++;

}
return -1;
     a4b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
     a50:	c9                   	leave  
     a51:	c3                   	ret    

00000a52 <allocThread>:
 * allocates a spot for a new thread
 * if none exist it returns NULL
 */
static uthread_p
allocThread()
{
     a52:	55                   	push   %ebp
     a53:	89 e5                	mov    %esp,%ebp
     a55:	83 ec 28             	sub    $0x28,%esp
  int i,j;
  uthread_p t;
  
  for (t=tTable.table,i=0 ; t < &tTable.table[MAX_THREAD]; t++,i++)
     a58:	c7 45 ec 80 17 00 00 	movl   $0x1780,-0x14(%ebp)
     a5f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     a66:	eb 15                	jmp    a7d <allocThread+0x2b>
  {
    if(t->state==T_FREE)
     a68:	8b 45 ec             	mov    -0x14(%ebp),%eax
     a6b:	8b 40 10             	mov    0x10(%eax),%eax
     a6e:	85 c0                	test   %eax,%eax
     a70:	74 1e                	je     a90 <allocThread+0x3e>
allocThread()
{
  int i,j;
  uthread_p t;
  
  for (t=tTable.table,i=0 ; t < &tTable.table[MAX_THREAD]; t++,i++)
     a72:	81 45 ec 24 01 00 00 	addl   $0x124,-0x14(%ebp)
     a79:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     a7d:	81 7d ec 80 60 00 00 	cmpl   $0x6080,-0x14(%ebp)
     a84:	72 e2                	jb     a68 <allocThread+0x16>
  {
    if(t->state==T_FREE)
      goto found;
  }
  return 0;
     a86:	b8 00 00 00 00       	mov    $0x0,%eax
     a8b:	e9 a3 00 00 00       	jmp    b33 <allocThread+0xe1>
  uthread_p t;
  
  for (t=tTable.table,i=0 ; t < &tTable.table[MAX_THREAD]; t++,i++)
  {
    if(t->state==T_FREE)
      goto found;
     a90:	90                   	nop
  }
  return 0;
  
  found:
  //Init all fields
  t->tid=i;
     a91:	8b 45 ec             	mov    -0x14(%ebp),%eax
     a94:	8b 55 f4             	mov    -0xc(%ebp),%edx
     a97:	89 10                	mov    %edx,(%eax)
  if(i==0) //main thread init
     a99:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     a9d:	75 1c                	jne    abb <allocThread+0x69>
  {
    STORE_ESP(t->esp);
     a9f:	89 e2                	mov    %esp,%edx
     aa1:	8b 45 ec             	mov    -0x14(%ebp),%eax
     aa4:	89 50 04             	mov    %edx,0x4(%eax)
    STORE_EBP(t->ebp);
     aa7:	89 ea                	mov    %ebp,%edx
     aa9:	8b 45 ec             	mov    -0x14(%ebp),%eax
     aac:	89 50 08             	mov    %edx,0x8(%eax)
    t->firstTime=0;
     aaf:	8b 45 ec             	mov    -0x14(%ebp),%eax
     ab2:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
     ab9:	eb 3b                	jmp    af6 <allocThread+0xa4>
  }
  else
  {
    t->stack=(char*)malloc(STACK_SIZE);
     abb:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
     ac2:	e8 b4 fd ff ff       	call   87b <malloc>
     ac7:	8b 55 ec             	mov    -0x14(%ebp),%edx
     aca:	89 42 0c             	mov    %eax,0xc(%edx)
    t->ebp=(int)t->stack+STACK_SIZE;
     acd:	8b 45 ec             	mov    -0x14(%ebp),%eax
     ad0:	8b 40 0c             	mov    0xc(%eax),%eax
     ad3:	05 00 10 00 00       	add    $0x1000,%eax
     ad8:	89 c2                	mov    %eax,%edx
     ada:	8b 45 ec             	mov    -0x14(%ebp),%eax
     add:	89 50 08             	mov    %edx,0x8(%eax)
    t->esp=t->ebp;
     ae0:	8b 45 ec             	mov    -0x14(%ebp),%eax
     ae3:	8b 50 08             	mov    0x8(%eax),%edx
     ae6:	8b 45 ec             	mov    -0x14(%ebp),%eax
     ae9:	89 50 04             	mov    %edx,0x4(%eax)
    t->firstTime=1;
     aec:	8b 45 ec             	mov    -0x14(%ebp),%eax
     aef:	c7 40 14 01 00 00 00 	movl   $0x1,0x14(%eax)
  }
  
  t->waitingFor=-1;
     af6:	8b 45 ec             	mov    -0x14(%ebp),%eax
     af9:	c7 80 20 01 00 00 ff 	movl   $0xffffffff,0x120(%eax)
     b00:	ff ff ff 
  
  for(j=0;j<MAX_THREAD;j++)
     b03:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     b0a:	eb 14                	jmp    b20 <allocThread+0xce>
  {
    t->waitedOn[j]=-1;
     b0c:	8b 45 ec             	mov    -0x14(%ebp),%eax
     b0f:	8b 55 f0             	mov    -0x10(%ebp),%edx
     b12:	83 c2 08             	add    $0x8,%edx
     b15:	c7 04 90 ff ff ff ff 	movl   $0xffffffff,(%eax,%edx,4)
    t->firstTime=1;
  }
  
  t->waitingFor=-1;
  
  for(j=0;j<MAX_THREAD;j++)
     b1c:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     b20:	83 7d f0 3f          	cmpl   $0x3f,-0x10(%ebp)
     b24:	7e e6                	jle    b0c <allocThread+0xba>
  {
    t->waitedOn[j]=-1;
  }
   
  t->state=T_UNINIT;
     b26:	8b 45 ec             	mov    -0x14(%ebp),%eax
     b29:	c7 40 10 01 00 00 00 	movl   $0x1,0x10(%eax)
  
    
  return t;
     b30:	8b 45 ec             	mov    -0x14(%ebp),%eax
}
     b33:	c9                   	leave  
     b34:	c3                   	ret    

00000b35 <uthread_init>:
/*
 * initializes all the uthread structures
 */
int
uthread_init()
{   
     b35:	55                   	push   %ebp
     b36:	89 e5                	mov    %esp,%ebp
     b38:	83 ec 28             	sub    $0x28,%esp
  //Initialize table
  int i;
  
  for(i=0;i<MAX_THREAD;i++)
     b3b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     b42:	eb 18                	jmp    b5c <uthread_init+0x27>
  {
    tTable.table[i].state=T_FREE;
     b44:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b47:	69 c0 24 01 00 00    	imul   $0x124,%eax,%eax
     b4d:	05 90 17 00 00       	add    $0x1790,%eax
     b52:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
uthread_init()
{   
  //Initialize table
  int i;
  
  for(i=0;i<MAX_THREAD;i++)
     b58:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     b5c:	83 7d f4 3f          	cmpl   $0x3f,-0xc(%ebp)
     b60:	7e e2                	jle    b44 <uthread_init+0xf>
  {
    tTable.table[i].state=T_FREE;
  }
  
 //allocate the main thread
  currentThread = allocThread();
     b62:	e8 eb fe ff ff       	call   a52 <allocThread>
     b67:	a3 80 60 00 00       	mov    %eax,0x6080
  if(currentThread==0)
     b6c:	a1 80 60 00 00       	mov    0x6080,%eax
     b71:	85 c0                	test   %eax,%eax
     b73:	75 07                	jne    b7c <uthread_init+0x47>
    return -1;
     b75:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     b7a:	eb 6b                	jmp    be7 <uthread_init+0xb2>
  
  currentThread->state = T_RUNNING;
     b7c:	a1 80 60 00 00       	mov    0x6080,%eax
     b81:	c7 40 10 02 00 00 00 	movl   $0x2,0x10(%eax)
  //register uthread_yield as signal handler for alarm
  if(signal(SIGALRM,uthread_yield)<0)
     b88:	c7 44 24 04 6f 0e 00 	movl   $0xe6f,0x4(%esp)
     b8f:	00 
     b90:	c7 04 24 0e 00 00 00 	movl   $0xe,(%esp)
     b97:	e8 0c f9 ff ff       	call   4a8 <signal>
     b9c:	85 c0                	test   %eax,%eax
     b9e:	79 19                	jns    bb9 <uthread_init+0x84>
  {
    printf(1,"Cant register the alarm signal");
     ba0:	c7 44 24 04 58 11 00 	movl   $0x1158,0x4(%esp)
     ba7:	00 
     ba8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     baf:	e8 e3 f9 ff ff       	call   597 <printf>
    exit();
     bb4:	e8 2f f8 ff ff       	call   3e8 <exit>
  }
  //set new alarm clock
  if(alarm(THREAD_QUANTA)<0)
     bb9:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
     bc0:	e8 f3 f8 ff ff       	call   4b8 <alarm>
     bc5:	85 c0                	test   %eax,%eax
     bc7:	79 19                	jns    be2 <uthread_init+0xad>
  {
    printf(1,"Cant activate alarm system call");
     bc9:	c7 44 24 04 78 11 00 	movl   $0x1178,0x4(%esp)
     bd0:	00 
     bd1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     bd8:	e8 ba f9 ff ff       	call   597 <printf>
    exit();
     bdd:	e8 06 f8 ff ff       	call   3e8 <exit>
  }
  return 0;
     be2:	b8 00 00 00 00       	mov    $0x0,%eax
}
     be7:	c9                   	leave  
     be8:	c3                   	ret    

00000be9 <wrap_func>:

void
wrap_func()
{
     be9:	55                   	push   %ebp
     bea:	89 e5                	mov    %esp,%ebp
     bec:	83 ec 18             	sub    $0x18,%esp
  currentThread->func(currentThread->arguments);
     bef:	a1 80 60 00 00       	mov    0x6080,%eax
     bf4:	8b 50 18             	mov    0x18(%eax),%edx
     bf7:	a1 80 60 00 00       	mov    0x6080,%eax
     bfc:	8b 40 1c             	mov    0x1c(%eax),%eax
     bff:	89 04 24             	mov    %eax,(%esp)
     c02:	ff d2                	call   *%edx
  uthread_exit();
     c04:	e8 6c 00 00 00       	call   c75 <uthread_exit>
}
     c09:	c9                   	leave  
     c0a:	c3                   	ret    

00000c0b <uthread_create>:
 * to that function
 * if none can be created it returns -1;
 */
int  
uthread_create(void (*start_func)(void *), void* arg)
{
     c0b:	55                   	push   %ebp
     c0c:	89 e5                	mov    %esp,%ebp
     c0e:	53                   	push   %ebx
     c0f:	83 ec 14             	sub    $0x14,%esp
  uint local_esp;
  uthread_p t = allocThread();
     c12:	e8 3b fe ff ff       	call   a52 <allocThread>
     c17:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(t==0)
     c1a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     c1e:	75 07                	jne    c27 <uthread_create+0x1c>
    return -1;
     c20:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     c25:	eb 48                	jmp    c6f <uthread_create+0x64>

  t->func=start_func;
     c27:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c2a:	8b 55 08             	mov    0x8(%ebp),%edx
     c2d:	89 50 18             	mov    %edx,0x18(%eax)
  t->arguments=arg;
     c30:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c33:	8b 55 0c             	mov    0xc(%ebp),%edx
     c36:	89 50 1c             	mov    %edx,0x1c(%eax)
  
  //push starting func and return value on the right stack
  STORE_ESP(local_esp);
     c39:	89 e3                	mov    %esp,%ebx
     c3b:	89 5d f0             	mov    %ebx,-0x10(%ebp)
  LOAD_ESP(t->esp);
     c3e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c41:	8b 40 04             	mov    0x4(%eax),%eax
     c44:	89 c4                	mov    %eax,%esp
  PUSH_FUNC(t->esp,t->ebp,wrap_func);
     c46:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c49:	8b 50 08             	mov    0x8(%eax),%edx
     c4c:	b8 e9 0b 00 00       	mov    $0xbe9,%eax
     c51:	50                   	push   %eax
     c52:	52                   	push   %edx
     c53:	89 e2                	mov    %esp,%edx
     c55:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c58:	89 50 04             	mov    %edx,0x4(%eax)
  LOAD_ESP(local_esp);
     c5b:	8b 45 f0             	mov    -0x10(%ebp),%eax
     c5e:	89 c4                	mov    %eax,%esp
  
  t->state = T_RUNNABLE;
     c60:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c63:	c7 40 10 03 00 00 00 	movl   $0x3,0x10(%eax)
  
  return t->tid;
     c6a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c6d:	8b 00                	mov    (%eax),%eax
}
     c6f:	83 c4 14             	add    $0x14,%esp
     c72:	5b                   	pop    %ebx
     c73:	5d                   	pop    %ebp
     c74:	c3                   	ret    

00000c75 <uthread_exit>:
 * closes the running thread, wakes up all
 * the threads waiting for this one (if they require waking up)
 */
void 
uthread_exit()
{
     c75:	55                   	push   %ebp
     c76:	89 e5                	mov    %esp,%ebp
     c78:	83 ec 28             	sub    $0x28,%esp
  alarm(0); //clear the alarm so as not to disturb running of function
     c7b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     c82:	e8 31 f8 ff ff       	call   4b8 <alarm>
  int new,i;
  //wakeup all threads waiting for this one
  for(i=0;i<MAX_THREAD;i++)
     c87:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     c8e:	eb 51                	jmp    ce1 <uthread_exit+0x6c>
  {
   if(currentThread->waitedOn[i]==1)
     c90:	a1 80 60 00 00       	mov    0x6080,%eax
     c95:	8b 55 f4             	mov    -0xc(%ebp),%edx
     c98:	83 c2 08             	add    $0x8,%edx
     c9b:	8b 04 90             	mov    (%eax,%edx,4),%eax
     c9e:	83 f8 01             	cmp    $0x1,%eax
     ca1:	75 3a                	jne    cdd <uthread_exit+0x68>
   {
     tTable.table[i].waitingFor=-1; //release thread i from waiting
     ca3:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ca6:	69 c0 24 01 00 00    	imul   $0x124,%eax,%eax
     cac:	05 a0 18 00 00       	add    $0x18a0,%eax
     cb1:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)
     currentThread->waitedOn[i]=0; //not necessary maybe   
     cb7:	a1 80 60 00 00       	mov    0x6080,%eax
     cbc:	8b 55 f4             	mov    -0xc(%ebp),%edx
     cbf:	83 c2 08             	add    $0x8,%edx
     cc2:	c7 04 90 00 00 00 00 	movl   $0x0,(%eax,%edx,4)
     tTable.table[i].state=T_RUNNABLE;
     cc9:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ccc:	69 c0 24 01 00 00    	imul   $0x124,%eax,%eax
     cd2:	05 90 17 00 00       	add    $0x1790,%eax
     cd7:	c7 00 03 00 00 00    	movl   $0x3,(%eax)
uthread_exit()
{
  alarm(0); //clear the alarm so as not to disturb running of function
  int new,i;
  //wakeup all threads waiting for this one
  for(i=0;i<MAX_THREAD;i++)
     cdd:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     ce1:	83 7d f4 3f          	cmpl   $0x3f,-0xc(%ebp)
     ce5:	7e a9                	jle    c90 <uthread_exit+0x1b>
     tTable.table[i].state=T_RUNNABLE;
   }
  }
  
  //pick next thread
  new=getNextThread(currentThread->tid);
     ce7:	a1 80 60 00 00       	mov    0x6080,%eax
     cec:	8b 00                	mov    (%eax),%eax
     cee:	89 04 24             	mov    %eax,(%esp)
     cf1:	e8 e3 fc ff ff       	call   9d9 <getNextThread>
     cf6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  
  //release all resources and zero all fields
  if(currentThread->tid!=0)
     cf9:	a1 80 60 00 00       	mov    0x6080,%eax
     cfe:	8b 00                	mov    (%eax),%eax
     d00:	85 c0                	test   %eax,%eax
     d02:	74 10                	je     d14 <uthread_exit+0x9f>
    free(currentThread->stack);
     d04:	a1 80 60 00 00       	mov    0x6080,%eax
     d09:	8b 40 0c             	mov    0xc(%eax),%eax
     d0c:	89 04 24             	mov    %eax,(%esp)
     d0f:	e8 38 fa ff ff       	call   74c <free>
  currentThread->tid=-1;
     d14:	a1 80 60 00 00       	mov    0x6080,%eax
     d19:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)
  currentThread->esp=-1;
     d1f:	a1 80 60 00 00       	mov    0x6080,%eax
     d24:	c7 40 04 ff ff ff ff 	movl   $0xffffffff,0x4(%eax)
  currentThread->ebp=-1;
     d2b:	a1 80 60 00 00       	mov    0x6080,%eax
     d30:	c7 40 08 ff ff ff ff 	movl   $0xffffffff,0x8(%eax)
  currentThread->func=0;
     d37:	a1 80 60 00 00       	mov    0x6080,%eax
     d3c:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)
  currentThread->arguments=0;
     d43:	a1 80 60 00 00       	mov    0x6080,%eax
     d48:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
  currentThread->stack=0;
     d4f:	a1 80 60 00 00       	mov    0x6080,%eax
     d54:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
  currentThread->firstTime=1;
     d5b:	a1 80 60 00 00       	mov    0x6080,%eax
     d60:	c7 40 14 01 00 00 00 	movl   $0x1,0x14(%eax)
  currentThread->state=T_FREE;
     d67:	a1 80 60 00 00       	mov    0x6080,%eax
     d6c:	c7 40 10 00 00 00 00 	movl   $0x0,0x10(%eax)
  
  //load new thread
  if(new>=0)
     d73:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     d77:	78 7a                	js     df3 <uthread_exit+0x17e>
  {
    currentThread=&tTable.table[new];
     d79:	8b 45 f0             	mov    -0x10(%ebp),%eax
     d7c:	69 c0 24 01 00 00    	imul   $0x124,%eax,%eax
     d82:	05 80 17 00 00       	add    $0x1780,%eax
     d87:	a3 80 60 00 00       	mov    %eax,0x6080
    currentThread->state=T_RUNNING;
     d8c:	a1 80 60 00 00       	mov    0x6080,%eax
     d91:	c7 40 10 02 00 00 00 	movl   $0x2,0x10(%eax)
    LOAD_ESP(currentThread->esp);
     d98:	a1 80 60 00 00       	mov    0x6080,%eax
     d9d:	8b 40 04             	mov    0x4(%eax),%eax
     da0:	89 c4                	mov    %eax,%esp
    LOAD_EBP(currentThread->ebp);
     da2:	a1 80 60 00 00       	mov    0x6080,%eax
     da7:	8b 40 08             	mov    0x8(%eax),%eax
     daa:	89 c5                	mov    %eax,%ebp
    
    //set new alarm clock
    if(alarm(THREAD_QUANTA)<0)
     dac:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
     db3:	e8 00 f7 ff ff       	call   4b8 <alarm>
     db8:	85 c0                	test   %eax,%eax
     dba:	79 19                	jns    dd5 <uthread_exit+0x160>
    {
      printf(1,"Cant activate alarm system call");
     dbc:	c7 44 24 04 78 11 00 	movl   $0x1178,0x4(%esp)
     dc3:	00 
     dc4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     dcb:	e8 c7 f7 ff ff       	call   597 <printf>
      exit();
     dd0:	e8 13 f6 ff ff       	call   3e8 <exit>
    }
    
    if(currentThread->firstTime==1)
     dd5:	a1 80 60 00 00       	mov    0x6080,%eax
     dda:	8b 40 14             	mov    0x14(%eax),%eax
     ddd:	83 f8 01             	cmp    $0x1,%eax
     de0:	75 10                	jne    df2 <uthread_exit+0x17d>
    {
      currentThread->firstTime=0;
     de2:	a1 80 60 00 00       	mov    0x6080,%eax
     de7:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
      POP_AND_RET();
     dee:	5d                   	pop    %ebp
     def:	c3                   	ret    
     df0:	eb 01                	jmp    df3 <uthread_exit+0x17e>
    }
    else
    {  
    POP_ALL_REGISTERS();
     df2:	61                   	popa   
    }
  }
}
     df3:	c9                   	leave  
     df4:	c3                   	ret    

00000df5 <uthread_join>:
/*
 * causes this thread to wait for the finish of another thread
 */
int
uthread_join(int tid)
{
     df5:	55                   	push   %ebp
     df6:	89 e5                	mov    %esp,%ebp
     df8:	83 ec 18             	sub    $0x18,%esp
  if((&tTable.table[tid])->state==T_FREE)
     dfb:	8b 45 08             	mov    0x8(%ebp),%eax
     dfe:	69 c0 24 01 00 00    	imul   $0x124,%eax,%eax
     e04:	05 80 17 00 00       	add    $0x1780,%eax
     e09:	8b 40 10             	mov    0x10(%eax),%eax
     e0c:	85 c0                	test   %eax,%eax
     e0e:	75 07                	jne    e17 <uthread_join+0x22>
    return -1;
     e10:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     e15:	eb 56                	jmp    e6d <uthread_join+0x78>
  else
  {
    alarm(0); //clear the alarm so as not to disturb running of function
     e17:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     e1e:	e8 95 f6 ff ff       	call   4b8 <alarm>
    currentThread->waitingFor=tid;
     e23:	a1 80 60 00 00       	mov    0x6080,%eax
     e28:	8b 55 08             	mov    0x8(%ebp),%edx
     e2b:	89 90 20 01 00 00    	mov    %edx,0x120(%eax)
    tTable.table[tid].waitedOn[currentThread->tid]=1;
     e31:	a1 80 60 00 00       	mov    0x6080,%eax
     e36:	8b 08                	mov    (%eax),%ecx
     e38:	8b 55 08             	mov    0x8(%ebp),%edx
     e3b:	89 d0                	mov    %edx,%eax
     e3d:	c1 e0 03             	shl    $0x3,%eax
     e40:	01 d0                	add    %edx,%eax
     e42:	c1 e0 03             	shl    $0x3,%eax
     e45:	01 d0                	add    %edx,%eax
     e47:	01 c8                	add    %ecx,%eax
     e49:	83 c0 08             	add    $0x8,%eax
     e4c:	c7 04 85 80 17 00 00 	movl   $0x1,0x1780(,%eax,4)
     e53:	01 00 00 00 
    currentThread->state=T_SLEEPING;
     e57:	a1 80 60 00 00       	mov    0x6080,%eax
     e5c:	c7 40 10 04 00 00 00 	movl   $0x4,0x10(%eax)
    uthread_yield();
     e63:	e8 07 00 00 00       	call   e6f <uthread_yield>
    return 1;
     e68:	b8 01 00 00 00       	mov    $0x1,%eax
  }
}
     e6d:	c9                   	leave  
     e6e:	c3                   	ret    

00000e6f <uthread_yield>:
/*
 * yields the run-time of the current thread to another thread
 */
void 
uthread_yield()
{
     e6f:	55                   	push   %ebp
     e70:	89 e5                	mov    %esp,%ebp
     e72:	83 ec 28             	sub    $0x28,%esp
  alarm(0); //clear the alarm so as not to disturb running of function
     e75:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     e7c:	e8 37 f6 ff ff       	call   4b8 <alarm>
  int new=getNextThread(currentThread->tid);
     e81:	a1 80 60 00 00       	mov    0x6080,%eax
     e86:	8b 00                	mov    (%eax),%eax
     e88:	89 04 24             	mov    %eax,(%esp)
     e8b:	e8 49 fb ff ff       	call   9d9 <getNextThread>
     e90:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(new==-1)
     e93:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     e97:	75 2d                	jne    ec6 <uthread_yield+0x57>
  {
    if(alarm(THREAD_QUANTA)<0)
     e99:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
     ea0:	e8 13 f6 ff ff       	call   4b8 <alarm>
     ea5:	85 c0                	test   %eax,%eax
     ea7:	0f 89 c1 00 00 00    	jns    f6e <uthread_yield+0xff>
    {
      printf(1,"Cant activate alarm system call\n");
     ead:	c7 44 24 04 98 11 00 	movl   $0x1198,0x4(%esp)
     eb4:	00 
     eb5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     ebc:	e8 d6 f6 ff ff       	call   597 <printf>
      exit();
     ec1:	e8 22 f5 ff ff       	call   3e8 <exit>
    } 
  }
  else
  {
    //store all leaving thread registers and pointers
    PUSH_ALL_REGISTERS();
     ec6:	60                   	pusha  
    STORE_ESP(currentThread->esp);
     ec7:	a1 80 60 00 00       	mov    0x6080,%eax
     ecc:	89 e2                	mov    %esp,%edx
     ece:	89 50 04             	mov    %edx,0x4(%eax)
    STORE_EBP(currentThread->ebp);
     ed1:	a1 80 60 00 00       	mov    0x6080,%eax
     ed6:	89 ea                	mov    %ebp,%edx
     ed8:	89 50 08             	mov    %edx,0x8(%eax)
    
    //change thread state
    if(currentThread->state==T_RUNNING) //might be sleeping from join operation
     edb:	a1 80 60 00 00       	mov    0x6080,%eax
     ee0:	8b 40 10             	mov    0x10(%eax),%eax
     ee3:	83 f8 02             	cmp    $0x2,%eax
     ee6:	75 0c                	jne    ef4 <uthread_yield+0x85>
      currentThread->state=T_RUNNABLE;
     ee8:	a1 80 60 00 00       	mov    0x6080,%eax
     eed:	c7 40 10 03 00 00 00 	movl   $0x3,0x10(%eax)

    currentThread=&tTable.table[new];
     ef4:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ef7:	69 c0 24 01 00 00    	imul   $0x124,%eax,%eax
     efd:	05 80 17 00 00       	add    $0x1780,%eax
     f02:	a3 80 60 00 00       	mov    %eax,0x6080

    //load all new thread registers and pointers
    LOAD_ESP(currentThread->esp);
     f07:	a1 80 60 00 00       	mov    0x6080,%eax
     f0c:	8b 40 04             	mov    0x4(%eax),%eax
     f0f:	89 c4                	mov    %eax,%esp
    LOAD_EBP(currentThread->ebp);
     f11:	a1 80 60 00 00       	mov    0x6080,%eax
     f16:	8b 40 08             	mov    0x8(%eax),%eax
     f19:	89 c5                	mov    %eax,%ebp
    //set new alram clock
    if(alarm(THREAD_QUANTA)<0)
     f1b:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
     f22:	e8 91 f5 ff ff       	call   4b8 <alarm>
     f27:	85 c0                	test   %eax,%eax
     f29:	79 19                	jns    f44 <uthread_yield+0xd5>
    {
      printf(1,"Cant activate alarm system call\n");
     f2b:	c7 44 24 04 98 11 00 	movl   $0x1198,0x4(%esp)
     f32:	00 
     f33:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     f3a:	e8 58 f6 ff ff       	call   597 <printf>
      exit();
     f3f:	e8 a4 f4 ff ff       	call   3e8 <exit>
    }  
    currentThread->state=T_RUNNING;
     f44:	a1 80 60 00 00       	mov    0x6080,%eax
     f49:	c7 40 10 02 00 00 00 	movl   $0x2,0x10(%eax)
    
    if(currentThread->firstTime==1)
     f50:	a1 80 60 00 00       	mov    0x6080,%eax
     f55:	8b 40 14             	mov    0x14(%eax),%eax
     f58:	83 f8 01             	cmp    $0x1,%eax
     f5b:	75 10                	jne    f6d <uthread_yield+0xfe>
    {
    currentThread->firstTime=0;
     f5d:	a1 80 60 00 00       	mov    0x6080,%eax
     f62:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
    POP_AND_RET();
     f69:	5d                   	pop    %ebp
     f6a:	c3                   	ret    
     f6b:	eb 01                	jmp    f6e <uthread_yield+0xff>
    }
    else
    {
      POP_ALL_REGISTERS();
     f6d:	61                   	popa   
    }
  }
}
     f6e:	c9                   	leave  
     f6f:	c3                   	ret    

00000f70 <uthread_self>:

int
uthread_self(void)
{
     f70:	55                   	push   %ebp
     f71:	89 e5                	mov    %esp,%ebp
  return currentThread->tid;
     f73:	a1 80 60 00 00       	mov    0x6080,%eax
     f78:	8b 00                	mov    (%eax),%eax
     f7a:	5d                   	pop    %ebp
     f7b:	c3                   	ret    

00000f7c <xchg>:
#include "fs.h"
#include "uthread.h"

static inline uint
xchg(volatile uint *addr, uint newval)
{
     f7c:	55                   	push   %ebp
     f7d:	89 e5                	mov    %esp,%ebp
     f7f:	53                   	push   %ebx
     f80:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
               "+m" (*addr), "=a" (result) :
     f83:	8b 55 08             	mov    0x8(%ebp),%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
     f86:	8b 45 0c             	mov    0xc(%ebp),%eax
               "+m" (*addr), "=a" (result) :
     f89:	8b 4d 08             	mov    0x8(%ebp),%ecx
xchg(volatile uint *addr, uint newval)
{
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
     f8c:	89 c3                	mov    %eax,%ebx
     f8e:	89 d8                	mov    %ebx,%eax
     f90:	f0 87 02             	lock xchg %eax,(%edx)
     f93:	89 c3                	mov    %eax,%ebx
     f95:	89 5d f8             	mov    %ebx,-0x8(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
     f98:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
     f9b:	83 c4 10             	add    $0x10,%esp
     f9e:	5b                   	pop    %ebx
     f9f:	5d                   	pop    %ebp
     fa0:	c3                   	ret    

00000fa1 <binary_semaphore_init>:
semaphore->taken=0;
}*/

void
binary_semaphore_init(struct binary_semaphore* semaphore, int value)
{
     fa1:	55                   	push   %ebp
     fa2:	89 e5                	mov    %esp,%ebp
     fa4:	83 ec 08             	sub    $0x8,%esp
  semaphore->init=0;
     fa7:	8b 45 08             	mov    0x8(%ebp),%eax
     faa:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
  
  if(value!=0)
     fb1:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     fb5:	74 0c                	je     fc3 <binary_semaphore_init+0x22>
    semaphore->thread=-1;
     fb7:	8b 45 08             	mov    0x8(%ebp),%eax
     fba:	c7 40 04 ff ff ff ff 	movl   $0xffffffff,0x4(%eax)
     fc1:	eb 0b                	jmp    fce <binary_semaphore_init+0x2d>
  else 
    semaphore->thread = uthread_self();
     fc3:	e8 a8 ff ff ff       	call   f70 <uthread_self>
     fc8:	8b 55 08             	mov    0x8(%ebp),%edx
     fcb:	89 42 04             	mov    %eax,0x4(%edx)
  
  semaphore->locked = value;
     fce:	8b 55 0c             	mov    0xc(%ebp),%edx
     fd1:	8b 45 08             	mov    0x8(%ebp),%eax
     fd4:	89 10                	mov    %edx,(%eax)
 // semaphore->taken=0;
  semaphore->init=1;
     fd6:	8b 45 08             	mov    0x8(%ebp),%eax
     fd9:	c7 40 08 01 00 00 00 	movl   $0x1,0x8(%eax)
  
}
     fe0:	c9                   	leave  
     fe1:	c3                   	ret    

00000fe2 <binary_semaphore_down>:

void 
binary_semaphore_down(struct binary_semaphore* semaphore)
{
     fe2:	55                   	push   %ebp
     fe3:	89 e5                	mov    %esp,%ebp
     fe5:	83 ec 28             	sub    $0x28,%esp
  //semaphore_acquire(semaphore);
  if(semaphore->init==0)
     fe8:	8b 45 08             	mov    0x8(%ebp),%eax
     feb:	8b 40 08             	mov    0x8(%eax),%eax
     fee:	85 c0                	test   %eax,%eax
     ff0:	75 20                	jne    1012 <binary_semaphore_down+0x30>
  {
   printf(1,"(down)semaphore uninitialized yet (thread %d)\n",semaphore->thread);
     ff2:	8b 45 08             	mov    0x8(%ebp),%eax
     ff5:	8b 40 04             	mov    0x4(%eax),%eax
     ff8:	89 44 24 08          	mov    %eax,0x8(%esp)
     ffc:	c7 44 24 04 bc 11 00 	movl   $0x11bc,0x4(%esp)
    1003:	00 
    1004:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    100b:	e8 87 f5 ff ff       	call   597 <printf>
    return;
    1010:	eb 3a                	jmp    104c <binary_semaphore_down+0x6a>
  }
  
  
  int i= uthread_self();
    1012:	e8 59 ff ff ff       	call   f70 <uthread_self>
    1017:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(semaphore->thread!=i)
    101a:	8b 45 08             	mov    0x8(%ebp),%eax
    101d:	8b 40 04             	mov    0x4(%eax),%eax
    1020:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1023:	74 27                	je     104c <binary_semaphore_down+0x6a>
  {
    while(xchg(&semaphore->locked, 0) == 0) //means the semaphore is taken allready
    1025:	eb 05                	jmp    102c <binary_semaphore_down+0x4a>
    {
      uthread_yield();
    1027:	e8 43 fe ff ff       	call   e6f <uthread_yield>
  
  
  int i= uthread_self();
  if(semaphore->thread!=i)
  {
    while(xchg(&semaphore->locked, 0) == 0) //means the semaphore is taken allready
    102c:	8b 45 08             	mov    0x8(%ebp),%eax
    102f:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1036:	00 
    1037:	89 04 24             	mov    %eax,(%esp)
    103a:	e8 3d ff ff ff       	call   f7c <xchg>
    103f:	85 c0                	test   %eax,%eax
    1041:	74 e4                	je     1027 <binary_semaphore_down+0x45>
    {
      uthread_yield();
    }
    semaphore->thread = i;
    1043:	8b 45 08             	mov    0x8(%ebp),%eax
    1046:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1049:	89 50 04             	mov    %edx,0x4(%eax)
  }
  //semaphore_release(semaphore);
}
    104c:	c9                   	leave  
    104d:	c3                   	ret    

0000104e <binary_semaphore_up>:

void 
binary_semaphore_up(struct binary_semaphore* semaphore)
{
    104e:	55                   	push   %ebp
    104f:	89 e5                	mov    %esp,%ebp
    1051:	83 ec 28             	sub    $0x28,%esp
  //semaphore_acquire(semaphore);
    if(semaphore->init==0)
    1054:	8b 45 08             	mov    0x8(%ebp),%eax
    1057:	8b 40 08             	mov    0x8(%eax),%eax
    105a:	85 c0                	test   %eax,%eax
    105c:	75 20                	jne    107e <binary_semaphore_up+0x30>
    {
    printf(1,"(up)semaphore uninitialized yet (thread %d)\n",semaphore->thread);
    105e:	8b 45 08             	mov    0x8(%ebp),%eax
    1061:	8b 40 04             	mov    0x4(%eax),%eax
    1064:	89 44 24 08          	mov    %eax,0x8(%esp)
    1068:	c7 44 24 04 ec 11 00 	movl   $0x11ec,0x4(%esp)
    106f:	00 
    1070:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1077:	e8 1b f5 ff ff       	call   597 <printf>
    return;
    107c:	eb 2f                	jmp    10ad <binary_semaphore_up+0x5f>
    }
  
  int i= uthread_self();
    107e:	e8 ed fe ff ff       	call   f70 <uthread_self>
    1083:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if( semaphore->locked == 0 && semaphore->thread == i)
    1086:	8b 45 08             	mov    0x8(%ebp),%eax
    1089:	8b 00                	mov    (%eax),%eax
    108b:	85 c0                	test   %eax,%eax
    108d:	75 1e                	jne    10ad <binary_semaphore_up+0x5f>
    108f:	8b 45 08             	mov    0x8(%ebp),%eax
    1092:	8b 40 04             	mov    0x4(%eax),%eax
    1095:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1098:	75 13                	jne    10ad <binary_semaphore_up+0x5f>
  {
      semaphore->thread = -1;
    109a:	8b 45 08             	mov    0x8(%ebp),%eax
    109d:	c7 40 04 ff ff ff ff 	movl   $0xffffffff,0x4(%eax)
      semaphore->locked = 1;
    10a4:	8b 45 08             	mov    0x8(%ebp),%eax
    10a7:	c7 00 01 00 00 00    	movl   $0x1,(%eax)

  }
//semaphore_release(semaphore);
    10ad:	c9                   	leave  
    10ae:	c3                   	ret    
