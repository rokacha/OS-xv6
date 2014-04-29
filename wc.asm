
_wc:     file format elf32-i386


Disassembly of section .text:

00000000 <wc>:

char buf[512];

void
wc(int fd, char *name)
{
       0:	55                   	push   %ebp
       1:	89 e5                	mov    %esp,%ebp
       3:	83 ec 48             	sub    $0x48,%esp
  int i, n;
  int l, w, c, inword;

  l = w = c = 0;
       6:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
       d:	8b 45 e8             	mov    -0x18(%ebp),%eax
      10:	89 45 ec             	mov    %eax,-0x14(%ebp)
      13:	8b 45 ec             	mov    -0x14(%ebp),%eax
      16:	89 45 f0             	mov    %eax,-0x10(%ebp)
  inword = 0;
      19:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  while((n = read(fd, buf, sizeof(buf))) > 0){
      20:	eb 68                	jmp    8a <wc+0x8a>
    for(i=0; i<n; i++){
      22:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
      29:	eb 57                	jmp    82 <wc+0x82>
      c++;
      2b:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
      if(buf[i] == '\n')
      2f:	8b 45 f4             	mov    -0xc(%ebp),%eax
      32:	05 80 5f 00 00       	add    $0x5f80,%eax
      37:	0f b6 00             	movzbl (%eax),%eax
      3a:	3c 0a                	cmp    $0xa,%al
      3c:	75 04                	jne    42 <wc+0x42>
        l++;
      3e:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
      if(strchr(" \r\t\n\v", buf[i]))
      42:	8b 45 f4             	mov    -0xc(%ebp),%eax
      45:	05 80 5f 00 00       	add    $0x5f80,%eax
      4a:	0f b6 00             	movzbl (%eax),%eax
      4d:	0f be c0             	movsbl %al,%eax
      50:	89 44 24 04          	mov    %eax,0x4(%esp)
      54:	c7 04 24 f0 10 00 00 	movl   $0x10f0,(%esp)
      5b:	e8 47 02 00 00       	call   2a7 <strchr>
      60:	85 c0                	test   %eax,%eax
      62:	74 09                	je     6d <wc+0x6d>
        inword = 0;
      64:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
      6b:	eb 11                	jmp    7e <wc+0x7e>
      else if(!inword){
      6d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
      71:	75 0b                	jne    7e <wc+0x7e>
        w++;
      73:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
        inword = 1;
      77:	c7 45 e4 01 00 00 00 	movl   $0x1,-0x1c(%ebp)
  int l, w, c, inword;

  l = w = c = 0;
  inword = 0;
  while((n = read(fd, buf, sizeof(buf))) > 0){
    for(i=0; i<n; i++){
      7e:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      82:	8b 45 f4             	mov    -0xc(%ebp),%eax
      85:	3b 45 e0             	cmp    -0x20(%ebp),%eax
      88:	7c a1                	jl     2b <wc+0x2b>
  int i, n;
  int l, w, c, inword;

  l = w = c = 0;
  inword = 0;
  while((n = read(fd, buf, sizeof(buf))) > 0){
      8a:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
      91:	00 
      92:	c7 44 24 04 80 5f 00 	movl   $0x5f80,0x4(%esp)
      99:	00 
      9a:	8b 45 08             	mov    0x8(%ebp),%eax
      9d:	89 04 24             	mov    %eax,(%esp)
      a0:	e8 9b 03 00 00       	call   440 <read>
      a5:	89 45 e0             	mov    %eax,-0x20(%ebp)
      a8:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
      ac:	0f 8f 70 ff ff ff    	jg     22 <wc+0x22>
        w++;
        inword = 1;
      }
    }
  }
  if(n < 0){
      b2:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
      b6:	79 19                	jns    d1 <wc+0xd1>
    printf(1, "wc: read error\n");
      b8:	c7 44 24 04 f6 10 00 	movl   $0x10f6,0x4(%esp)
      bf:	00 
      c0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
      c7:	e8 0b 05 00 00       	call   5d7 <printf>
    exit();
      cc:	e8 57 03 00 00       	call   428 <exit>
  }
  printf(1, "%d %d %d %s\n", l, w, c, name);
      d1:	8b 45 0c             	mov    0xc(%ebp),%eax
      d4:	89 44 24 14          	mov    %eax,0x14(%esp)
      d8:	8b 45 e8             	mov    -0x18(%ebp),%eax
      db:	89 44 24 10          	mov    %eax,0x10(%esp)
      df:	8b 45 ec             	mov    -0x14(%ebp),%eax
      e2:	89 44 24 0c          	mov    %eax,0xc(%esp)
      e6:	8b 45 f0             	mov    -0x10(%ebp),%eax
      e9:	89 44 24 08          	mov    %eax,0x8(%esp)
      ed:	c7 44 24 04 06 11 00 	movl   $0x1106,0x4(%esp)
      f4:	00 
      f5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
      fc:	e8 d6 04 00 00       	call   5d7 <printf>
}
     101:	c9                   	leave  
     102:	c3                   	ret    

00000103 <main>:

int
main(int argc, char *argv[])
{
     103:	55                   	push   %ebp
     104:	89 e5                	mov    %esp,%ebp
     106:	83 e4 f0             	and    $0xfffffff0,%esp
     109:	83 ec 20             	sub    $0x20,%esp
  int fd, i;

  if(argc <= 1){
     10c:	83 7d 08 01          	cmpl   $0x1,0x8(%ebp)
     110:	7f 19                	jg     12b <main+0x28>
    wc(0, "");
     112:	c7 44 24 04 13 11 00 	movl   $0x1113,0x4(%esp)
     119:	00 
     11a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     121:	e8 da fe ff ff       	call   0 <wc>
    exit();
     126:	e8 fd 02 00 00       	call   428 <exit>
  }

  for(i = 1; i < argc; i++){
     12b:	c7 44 24 1c 01 00 00 	movl   $0x1,0x1c(%esp)
     132:	00 
     133:	eb 7d                	jmp    1b2 <main+0xaf>
    if((fd = open(argv[i], 0)) < 0){
     135:	8b 44 24 1c          	mov    0x1c(%esp),%eax
     139:	c1 e0 02             	shl    $0x2,%eax
     13c:	03 45 0c             	add    0xc(%ebp),%eax
     13f:	8b 00                	mov    (%eax),%eax
     141:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     148:	00 
     149:	89 04 24             	mov    %eax,(%esp)
     14c:	e8 17 03 00 00       	call   468 <open>
     151:	89 44 24 18          	mov    %eax,0x18(%esp)
     155:	83 7c 24 18 00       	cmpl   $0x0,0x18(%esp)
     15a:	79 29                	jns    185 <main+0x82>
      printf(1, "cat: cannot open %s\n", argv[i]);
     15c:	8b 44 24 1c          	mov    0x1c(%esp),%eax
     160:	c1 e0 02             	shl    $0x2,%eax
     163:	03 45 0c             	add    0xc(%ebp),%eax
     166:	8b 00                	mov    (%eax),%eax
     168:	89 44 24 08          	mov    %eax,0x8(%esp)
     16c:	c7 44 24 04 14 11 00 	movl   $0x1114,0x4(%esp)
     173:	00 
     174:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     17b:	e8 57 04 00 00       	call   5d7 <printf>
      exit();
     180:	e8 a3 02 00 00       	call   428 <exit>
    }
    wc(fd, argv[i]);
     185:	8b 44 24 1c          	mov    0x1c(%esp),%eax
     189:	c1 e0 02             	shl    $0x2,%eax
     18c:	03 45 0c             	add    0xc(%ebp),%eax
     18f:	8b 00                	mov    (%eax),%eax
     191:	89 44 24 04          	mov    %eax,0x4(%esp)
     195:	8b 44 24 18          	mov    0x18(%esp),%eax
     199:	89 04 24             	mov    %eax,(%esp)
     19c:	e8 5f fe ff ff       	call   0 <wc>
    close(fd);
     1a1:	8b 44 24 18          	mov    0x18(%esp),%eax
     1a5:	89 04 24             	mov    %eax,(%esp)
     1a8:	e8 a3 02 00 00       	call   450 <close>
  if(argc <= 1){
    wc(0, "");
    exit();
  }

  for(i = 1; i < argc; i++){
     1ad:	83 44 24 1c 01       	addl   $0x1,0x1c(%esp)
     1b2:	8b 44 24 1c          	mov    0x1c(%esp),%eax
     1b6:	3b 45 08             	cmp    0x8(%ebp),%eax
     1b9:	0f 8c 76 ff ff ff    	jl     135 <main+0x32>
      exit();
    }
    wc(fd, argv[i]);
    close(fd);
  }
  exit();
     1bf:	e8 64 02 00 00       	call   428 <exit>

000001c4 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
     1c4:	55                   	push   %ebp
     1c5:	89 e5                	mov    %esp,%ebp
     1c7:	57                   	push   %edi
     1c8:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
     1c9:	8b 4d 08             	mov    0x8(%ebp),%ecx
     1cc:	8b 55 10             	mov    0x10(%ebp),%edx
     1cf:	8b 45 0c             	mov    0xc(%ebp),%eax
     1d2:	89 cb                	mov    %ecx,%ebx
     1d4:	89 df                	mov    %ebx,%edi
     1d6:	89 d1                	mov    %edx,%ecx
     1d8:	fc                   	cld    
     1d9:	f3 aa                	rep stos %al,%es:(%edi)
     1db:	89 ca                	mov    %ecx,%edx
     1dd:	89 fb                	mov    %edi,%ebx
     1df:	89 5d 08             	mov    %ebx,0x8(%ebp)
     1e2:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
     1e5:	5b                   	pop    %ebx
     1e6:	5f                   	pop    %edi
     1e7:	5d                   	pop    %ebp
     1e8:	c3                   	ret    

000001e9 <strcpy>:
#include "x86.h"


char*
strcpy(char *s, char *t)
{
     1e9:	55                   	push   %ebp
     1ea:	89 e5                	mov    %esp,%ebp
     1ec:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
     1ef:	8b 45 08             	mov    0x8(%ebp),%eax
     1f2:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
     1f5:	90                   	nop
     1f6:	8b 45 0c             	mov    0xc(%ebp),%eax
     1f9:	0f b6 10             	movzbl (%eax),%edx
     1fc:	8b 45 08             	mov    0x8(%ebp),%eax
     1ff:	88 10                	mov    %dl,(%eax)
     201:	8b 45 08             	mov    0x8(%ebp),%eax
     204:	0f b6 00             	movzbl (%eax),%eax
     207:	84 c0                	test   %al,%al
     209:	0f 95 c0             	setne  %al
     20c:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     210:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
     214:	84 c0                	test   %al,%al
     216:	75 de                	jne    1f6 <strcpy+0xd>
    ;
  return os;
     218:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     21b:	c9                   	leave  
     21c:	c3                   	ret    

0000021d <strcmp>:

int
strcmp(const char *p, const char *q)
{
     21d:	55                   	push   %ebp
     21e:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
     220:	eb 08                	jmp    22a <strcmp+0xd>
    p++, q++;
     222:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     226:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
     22a:	8b 45 08             	mov    0x8(%ebp),%eax
     22d:	0f b6 00             	movzbl (%eax),%eax
     230:	84 c0                	test   %al,%al
     232:	74 10                	je     244 <strcmp+0x27>
     234:	8b 45 08             	mov    0x8(%ebp),%eax
     237:	0f b6 10             	movzbl (%eax),%edx
     23a:	8b 45 0c             	mov    0xc(%ebp),%eax
     23d:	0f b6 00             	movzbl (%eax),%eax
     240:	38 c2                	cmp    %al,%dl
     242:	74 de                	je     222 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
     244:	8b 45 08             	mov    0x8(%ebp),%eax
     247:	0f b6 00             	movzbl (%eax),%eax
     24a:	0f b6 d0             	movzbl %al,%edx
     24d:	8b 45 0c             	mov    0xc(%ebp),%eax
     250:	0f b6 00             	movzbl (%eax),%eax
     253:	0f b6 c0             	movzbl %al,%eax
     256:	89 d1                	mov    %edx,%ecx
     258:	29 c1                	sub    %eax,%ecx
     25a:	89 c8                	mov    %ecx,%eax
}
     25c:	5d                   	pop    %ebp
     25d:	c3                   	ret    

0000025e <strlen>:

uint
strlen(char *s)
{
     25e:	55                   	push   %ebp
     25f:	89 e5                	mov    %esp,%ebp
     261:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
     264:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
     26b:	eb 04                	jmp    271 <strlen+0x13>
     26d:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     271:	8b 45 fc             	mov    -0x4(%ebp),%eax
     274:	03 45 08             	add    0x8(%ebp),%eax
     277:	0f b6 00             	movzbl (%eax),%eax
     27a:	84 c0                	test   %al,%al
     27c:	75 ef                	jne    26d <strlen+0xf>
    ;
  return n;
     27e:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     281:	c9                   	leave  
     282:	c3                   	ret    

00000283 <memset>:

void*
memset(void *dst, int c, uint n)
{
     283:	55                   	push   %ebp
     284:	89 e5                	mov    %esp,%ebp
     286:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
     289:	8b 45 10             	mov    0x10(%ebp),%eax
     28c:	89 44 24 08          	mov    %eax,0x8(%esp)
     290:	8b 45 0c             	mov    0xc(%ebp),%eax
     293:	89 44 24 04          	mov    %eax,0x4(%esp)
     297:	8b 45 08             	mov    0x8(%ebp),%eax
     29a:	89 04 24             	mov    %eax,(%esp)
     29d:	e8 22 ff ff ff       	call   1c4 <stosb>
  return dst;
     2a2:	8b 45 08             	mov    0x8(%ebp),%eax
}
     2a5:	c9                   	leave  
     2a6:	c3                   	ret    

000002a7 <strchr>:

char*
strchr(const char *s, char c)
{
     2a7:	55                   	push   %ebp
     2a8:	89 e5                	mov    %esp,%ebp
     2aa:	83 ec 04             	sub    $0x4,%esp
     2ad:	8b 45 0c             	mov    0xc(%ebp),%eax
     2b0:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
     2b3:	eb 14                	jmp    2c9 <strchr+0x22>
    if(*s == c)
     2b5:	8b 45 08             	mov    0x8(%ebp),%eax
     2b8:	0f b6 00             	movzbl (%eax),%eax
     2bb:	3a 45 fc             	cmp    -0x4(%ebp),%al
     2be:	75 05                	jne    2c5 <strchr+0x1e>
      return (char*)s;
     2c0:	8b 45 08             	mov    0x8(%ebp),%eax
     2c3:	eb 13                	jmp    2d8 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
     2c5:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     2c9:	8b 45 08             	mov    0x8(%ebp),%eax
     2cc:	0f b6 00             	movzbl (%eax),%eax
     2cf:	84 c0                	test   %al,%al
     2d1:	75 e2                	jne    2b5 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
     2d3:	b8 00 00 00 00       	mov    $0x0,%eax
}
     2d8:	c9                   	leave  
     2d9:	c3                   	ret    

000002da <gets>:

char*
gets(char *buf, int max)
{
     2da:	55                   	push   %ebp
     2db:	89 e5                	mov    %esp,%ebp
     2dd:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     2e0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     2e7:	eb 44                	jmp    32d <gets+0x53>
    cc = read(0, &c, 1);
     2e9:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
     2f0:	00 
     2f1:	8d 45 ef             	lea    -0x11(%ebp),%eax
     2f4:	89 44 24 04          	mov    %eax,0x4(%esp)
     2f8:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     2ff:	e8 3c 01 00 00       	call   440 <read>
     304:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
     307:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     30b:	7e 2d                	jle    33a <gets+0x60>
      break;
    buf[i++] = c;
     30d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     310:	03 45 08             	add    0x8(%ebp),%eax
     313:	0f b6 55 ef          	movzbl -0x11(%ebp),%edx
     317:	88 10                	mov    %dl,(%eax)
     319:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    if(c == '\n' || c == '\r')
     31d:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     321:	3c 0a                	cmp    $0xa,%al
     323:	74 16                	je     33b <gets+0x61>
     325:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     329:	3c 0d                	cmp    $0xd,%al
     32b:	74 0e                	je     33b <gets+0x61>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     32d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     330:	83 c0 01             	add    $0x1,%eax
     333:	3b 45 0c             	cmp    0xc(%ebp),%eax
     336:	7c b1                	jl     2e9 <gets+0xf>
     338:	eb 01                	jmp    33b <gets+0x61>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
     33a:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
     33b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     33e:	03 45 08             	add    0x8(%ebp),%eax
     341:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
     344:	8b 45 08             	mov    0x8(%ebp),%eax
}
     347:	c9                   	leave  
     348:	c3                   	ret    

00000349 <stat>:

int
stat(char *n, struct stat *st)
{
     349:	55                   	push   %ebp
     34a:	89 e5                	mov    %esp,%ebp
     34c:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     34f:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     356:	00 
     357:	8b 45 08             	mov    0x8(%ebp),%eax
     35a:	89 04 24             	mov    %eax,(%esp)
     35d:	e8 06 01 00 00       	call   468 <open>
     362:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
     365:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     369:	79 07                	jns    372 <stat+0x29>
    return -1;
     36b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     370:	eb 23                	jmp    395 <stat+0x4c>
  r = fstat(fd, st);
     372:	8b 45 0c             	mov    0xc(%ebp),%eax
     375:	89 44 24 04          	mov    %eax,0x4(%esp)
     379:	8b 45 f4             	mov    -0xc(%ebp),%eax
     37c:	89 04 24             	mov    %eax,(%esp)
     37f:	e8 fc 00 00 00       	call   480 <fstat>
     384:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
     387:	8b 45 f4             	mov    -0xc(%ebp),%eax
     38a:	89 04 24             	mov    %eax,(%esp)
     38d:	e8 be 00 00 00       	call   450 <close>
  return r;
     392:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     395:	c9                   	leave  
     396:	c3                   	ret    

00000397 <atoi>:

int
atoi(const char *s)
{
     397:	55                   	push   %ebp
     398:	89 e5                	mov    %esp,%ebp
     39a:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
     39d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
     3a4:	eb 23                	jmp    3c9 <atoi+0x32>
    n = n*10 + *s++ - '0';
     3a6:	8b 55 fc             	mov    -0x4(%ebp),%edx
     3a9:	89 d0                	mov    %edx,%eax
     3ab:	c1 e0 02             	shl    $0x2,%eax
     3ae:	01 d0                	add    %edx,%eax
     3b0:	01 c0                	add    %eax,%eax
     3b2:	89 c2                	mov    %eax,%edx
     3b4:	8b 45 08             	mov    0x8(%ebp),%eax
     3b7:	0f b6 00             	movzbl (%eax),%eax
     3ba:	0f be c0             	movsbl %al,%eax
     3bd:	01 d0                	add    %edx,%eax
     3bf:	83 e8 30             	sub    $0x30,%eax
     3c2:	89 45 fc             	mov    %eax,-0x4(%ebp)
     3c5:	83 45 08 01          	addl   $0x1,0x8(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     3c9:	8b 45 08             	mov    0x8(%ebp),%eax
     3cc:	0f b6 00             	movzbl (%eax),%eax
     3cf:	3c 2f                	cmp    $0x2f,%al
     3d1:	7e 0a                	jle    3dd <atoi+0x46>
     3d3:	8b 45 08             	mov    0x8(%ebp),%eax
     3d6:	0f b6 00             	movzbl (%eax),%eax
     3d9:	3c 39                	cmp    $0x39,%al
     3db:	7e c9                	jle    3a6 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
     3dd:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     3e0:	c9                   	leave  
     3e1:	c3                   	ret    

000003e2 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
     3e2:	55                   	push   %ebp
     3e3:	89 e5                	mov    %esp,%ebp
     3e5:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
     3e8:	8b 45 08             	mov    0x8(%ebp),%eax
     3eb:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
     3ee:	8b 45 0c             	mov    0xc(%ebp),%eax
     3f1:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
     3f4:	eb 13                	jmp    409 <memmove+0x27>
    *dst++ = *src++;
     3f6:	8b 45 f8             	mov    -0x8(%ebp),%eax
     3f9:	0f b6 10             	movzbl (%eax),%edx
     3fc:	8b 45 fc             	mov    -0x4(%ebp),%eax
     3ff:	88 10                	mov    %dl,(%eax)
     401:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     405:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
     409:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     40d:	0f 9f c0             	setg   %al
     410:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
     414:	84 c0                	test   %al,%al
     416:	75 de                	jne    3f6 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
     418:	8b 45 08             	mov    0x8(%ebp),%eax
}
     41b:	c9                   	leave  
     41c:	c3                   	ret    
     41d:	90                   	nop
     41e:	90                   	nop
     41f:	90                   	nop

00000420 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     420:	b8 01 00 00 00       	mov    $0x1,%eax
     425:	cd 40                	int    $0x40
     427:	c3                   	ret    

00000428 <exit>:
SYSCALL(exit)
     428:	b8 02 00 00 00       	mov    $0x2,%eax
     42d:	cd 40                	int    $0x40
     42f:	c3                   	ret    

00000430 <wait>:
SYSCALL(wait)
     430:	b8 03 00 00 00       	mov    $0x3,%eax
     435:	cd 40                	int    $0x40
     437:	c3                   	ret    

00000438 <pipe>:
SYSCALL(pipe)
     438:	b8 04 00 00 00       	mov    $0x4,%eax
     43d:	cd 40                	int    $0x40
     43f:	c3                   	ret    

00000440 <read>:
SYSCALL(read)
     440:	b8 05 00 00 00       	mov    $0x5,%eax
     445:	cd 40                	int    $0x40
     447:	c3                   	ret    

00000448 <write>:
SYSCALL(write)
     448:	b8 10 00 00 00       	mov    $0x10,%eax
     44d:	cd 40                	int    $0x40
     44f:	c3                   	ret    

00000450 <close>:
SYSCALL(close)
     450:	b8 15 00 00 00       	mov    $0x15,%eax
     455:	cd 40                	int    $0x40
     457:	c3                   	ret    

00000458 <kill>:
SYSCALL(kill)
     458:	b8 06 00 00 00       	mov    $0x6,%eax
     45d:	cd 40                	int    $0x40
     45f:	c3                   	ret    

00000460 <exec>:
SYSCALL(exec)
     460:	b8 07 00 00 00       	mov    $0x7,%eax
     465:	cd 40                	int    $0x40
     467:	c3                   	ret    

00000468 <open>:
SYSCALL(open)
     468:	b8 0f 00 00 00       	mov    $0xf,%eax
     46d:	cd 40                	int    $0x40
     46f:	c3                   	ret    

00000470 <mknod>:
SYSCALL(mknod)
     470:	b8 11 00 00 00       	mov    $0x11,%eax
     475:	cd 40                	int    $0x40
     477:	c3                   	ret    

00000478 <unlink>:
SYSCALL(unlink)
     478:	b8 12 00 00 00       	mov    $0x12,%eax
     47d:	cd 40                	int    $0x40
     47f:	c3                   	ret    

00000480 <fstat>:
SYSCALL(fstat)
     480:	b8 08 00 00 00       	mov    $0x8,%eax
     485:	cd 40                	int    $0x40
     487:	c3                   	ret    

00000488 <link>:
SYSCALL(link)
     488:	b8 13 00 00 00       	mov    $0x13,%eax
     48d:	cd 40                	int    $0x40
     48f:	c3                   	ret    

00000490 <mkdir>:
SYSCALL(mkdir)
     490:	b8 14 00 00 00       	mov    $0x14,%eax
     495:	cd 40                	int    $0x40
     497:	c3                   	ret    

00000498 <chdir>:
SYSCALL(chdir)
     498:	b8 09 00 00 00       	mov    $0x9,%eax
     49d:	cd 40                	int    $0x40
     49f:	c3                   	ret    

000004a0 <dup>:
SYSCALL(dup)
     4a0:	b8 0a 00 00 00       	mov    $0xa,%eax
     4a5:	cd 40                	int    $0x40
     4a7:	c3                   	ret    

000004a8 <getpid>:
SYSCALL(getpid)
     4a8:	b8 0b 00 00 00       	mov    $0xb,%eax
     4ad:	cd 40                	int    $0x40
     4af:	c3                   	ret    

000004b0 <sbrk>:
SYSCALL(sbrk)
     4b0:	b8 0c 00 00 00       	mov    $0xc,%eax
     4b5:	cd 40                	int    $0x40
     4b7:	c3                   	ret    

000004b8 <sleep>:
SYSCALL(sleep)
     4b8:	b8 0d 00 00 00       	mov    $0xd,%eax
     4bd:	cd 40                	int    $0x40
     4bf:	c3                   	ret    

000004c0 <uptime>:
SYSCALL(uptime)
     4c0:	b8 0e 00 00 00       	mov    $0xe,%eax
     4c5:	cd 40                	int    $0x40
     4c7:	c3                   	ret    

000004c8 <add_path>:
SYSCALL(add_path)
     4c8:	b8 16 00 00 00       	mov    $0x16,%eax
     4cd:	cd 40                	int    $0x40
     4cf:	c3                   	ret    

000004d0 <wait2>:
SYSCALL(wait2)
     4d0:	b8 17 00 00 00       	mov    $0x17,%eax
     4d5:	cd 40                	int    $0x40
     4d7:	c3                   	ret    

000004d8 <getquanta>:
SYSCALL(getquanta)
     4d8:	b8 18 00 00 00       	mov    $0x18,%eax
     4dd:	cd 40                	int    $0x40
     4df:	c3                   	ret    

000004e0 <getqueue>:
SYSCALL(getqueue)
     4e0:	b8 19 00 00 00       	mov    $0x19,%eax
     4e5:	cd 40                	int    $0x40
     4e7:	c3                   	ret    

000004e8 <signal>:
SYSCALL(signal)
     4e8:	b8 1a 00 00 00       	mov    $0x1a,%eax
     4ed:	cd 40                	int    $0x40
     4ef:	c3                   	ret    

000004f0 <sigsend>:
SYSCALL(sigsend)
     4f0:	b8 1b 00 00 00       	mov    $0x1b,%eax
     4f5:	cd 40                	int    $0x40
     4f7:	c3                   	ret    

000004f8 <alarm>:
SYSCALL(alarm)
     4f8:	b8 1c 00 00 00       	mov    $0x1c,%eax
     4fd:	cd 40                	int    $0x40
     4ff:	c3                   	ret    

00000500 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
     500:	55                   	push   %ebp
     501:	89 e5                	mov    %esp,%ebp
     503:	83 ec 28             	sub    $0x28,%esp
     506:	8b 45 0c             	mov    0xc(%ebp),%eax
     509:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
     50c:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
     513:	00 
     514:	8d 45 f4             	lea    -0xc(%ebp),%eax
     517:	89 44 24 04          	mov    %eax,0x4(%esp)
     51b:	8b 45 08             	mov    0x8(%ebp),%eax
     51e:	89 04 24             	mov    %eax,(%esp)
     521:	e8 22 ff ff ff       	call   448 <write>
}
     526:	c9                   	leave  
     527:	c3                   	ret    

00000528 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     528:	55                   	push   %ebp
     529:	89 e5                	mov    %esp,%ebp
     52b:	83 ec 48             	sub    $0x48,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     52e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
     535:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     539:	74 17                	je     552 <printint+0x2a>
     53b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     53f:	79 11                	jns    552 <printint+0x2a>
    neg = 1;
     541:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
     548:	8b 45 0c             	mov    0xc(%ebp),%eax
     54b:	f7 d8                	neg    %eax
     54d:	89 45 ec             	mov    %eax,-0x14(%ebp)
     550:	eb 06                	jmp    558 <printint+0x30>
  } else {
    x = xx;
     552:	8b 45 0c             	mov    0xc(%ebp),%eax
     555:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
     558:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
     55f:	8b 4d 10             	mov    0x10(%ebp),%ecx
     562:	8b 45 ec             	mov    -0x14(%ebp),%eax
     565:	ba 00 00 00 00       	mov    $0x0,%edx
     56a:	f7 f1                	div    %ecx
     56c:	89 d0                	mov    %edx,%eax
     56e:	0f b6 90 40 16 00 00 	movzbl 0x1640(%eax),%edx
     575:	8d 45 dc             	lea    -0x24(%ebp),%eax
     578:	03 45 f4             	add    -0xc(%ebp),%eax
     57b:	88 10                	mov    %dl,(%eax)
     57d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  }while((x /= base) != 0);
     581:	8b 55 10             	mov    0x10(%ebp),%edx
     584:	89 55 d4             	mov    %edx,-0x2c(%ebp)
     587:	8b 45 ec             	mov    -0x14(%ebp),%eax
     58a:	ba 00 00 00 00       	mov    $0x0,%edx
     58f:	f7 75 d4             	divl   -0x2c(%ebp)
     592:	89 45 ec             	mov    %eax,-0x14(%ebp)
     595:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     599:	75 c4                	jne    55f <printint+0x37>
  if(neg)
     59b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     59f:	74 2a                	je     5cb <printint+0xa3>
    buf[i++] = '-';
     5a1:	8d 45 dc             	lea    -0x24(%ebp),%eax
     5a4:	03 45 f4             	add    -0xc(%ebp),%eax
     5a7:	c6 00 2d             	movb   $0x2d,(%eax)
     5aa:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)

  while(--i >= 0)
     5ae:	eb 1b                	jmp    5cb <printint+0xa3>
    putc(fd, buf[i]);
     5b0:	8d 45 dc             	lea    -0x24(%ebp),%eax
     5b3:	03 45 f4             	add    -0xc(%ebp),%eax
     5b6:	0f b6 00             	movzbl (%eax),%eax
     5b9:	0f be c0             	movsbl %al,%eax
     5bc:	89 44 24 04          	mov    %eax,0x4(%esp)
     5c0:	8b 45 08             	mov    0x8(%ebp),%eax
     5c3:	89 04 24             	mov    %eax,(%esp)
     5c6:	e8 35 ff ff ff       	call   500 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
     5cb:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
     5cf:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     5d3:	79 db                	jns    5b0 <printint+0x88>
    putc(fd, buf[i]);
}
     5d5:	c9                   	leave  
     5d6:	c3                   	ret    

000005d7 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     5d7:	55                   	push   %ebp
     5d8:	89 e5                	mov    %esp,%ebp
     5da:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
     5dd:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
     5e4:	8d 45 0c             	lea    0xc(%ebp),%eax
     5e7:	83 c0 04             	add    $0x4,%eax
     5ea:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
     5ed:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     5f4:	e9 7d 01 00 00       	jmp    776 <printf+0x19f>
    c = fmt[i] & 0xff;
     5f9:	8b 55 0c             	mov    0xc(%ebp),%edx
     5fc:	8b 45 f0             	mov    -0x10(%ebp),%eax
     5ff:	01 d0                	add    %edx,%eax
     601:	0f b6 00             	movzbl (%eax),%eax
     604:	0f be c0             	movsbl %al,%eax
     607:	25 ff 00 00 00       	and    $0xff,%eax
     60c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
     60f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     613:	75 2c                	jne    641 <printf+0x6a>
      if(c == '%'){
     615:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     619:	75 0c                	jne    627 <printf+0x50>
        state = '%';
     61b:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
     622:	e9 4b 01 00 00       	jmp    772 <printf+0x19b>
      } else {
        putc(fd, c);
     627:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     62a:	0f be c0             	movsbl %al,%eax
     62d:	89 44 24 04          	mov    %eax,0x4(%esp)
     631:	8b 45 08             	mov    0x8(%ebp),%eax
     634:	89 04 24             	mov    %eax,(%esp)
     637:	e8 c4 fe ff ff       	call   500 <putc>
     63c:	e9 31 01 00 00       	jmp    772 <printf+0x19b>
      }
    } else if(state == '%'){
     641:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
     645:	0f 85 27 01 00 00    	jne    772 <printf+0x19b>
      if(c == 'd'){
     64b:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
     64f:	75 2d                	jne    67e <printf+0xa7>
        printint(fd, *ap, 10, 1);
     651:	8b 45 e8             	mov    -0x18(%ebp),%eax
     654:	8b 00                	mov    (%eax),%eax
     656:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
     65d:	00 
     65e:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
     665:	00 
     666:	89 44 24 04          	mov    %eax,0x4(%esp)
     66a:	8b 45 08             	mov    0x8(%ebp),%eax
     66d:	89 04 24             	mov    %eax,(%esp)
     670:	e8 b3 fe ff ff       	call   528 <printint>
        ap++;
     675:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     679:	e9 ed 00 00 00       	jmp    76b <printf+0x194>
      } else if(c == 'x' || c == 'p'){
     67e:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
     682:	74 06                	je     68a <printf+0xb3>
     684:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
     688:	75 2d                	jne    6b7 <printf+0xe0>
        printint(fd, *ap, 16, 0);
     68a:	8b 45 e8             	mov    -0x18(%ebp),%eax
     68d:	8b 00                	mov    (%eax),%eax
     68f:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
     696:	00 
     697:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
     69e:	00 
     69f:	89 44 24 04          	mov    %eax,0x4(%esp)
     6a3:	8b 45 08             	mov    0x8(%ebp),%eax
     6a6:	89 04 24             	mov    %eax,(%esp)
     6a9:	e8 7a fe ff ff       	call   528 <printint>
        ap++;
     6ae:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     6b2:	e9 b4 00 00 00       	jmp    76b <printf+0x194>
      } else if(c == 's'){
     6b7:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
     6bb:	75 46                	jne    703 <printf+0x12c>
        s = (char*)*ap;
     6bd:	8b 45 e8             	mov    -0x18(%ebp),%eax
     6c0:	8b 00                	mov    (%eax),%eax
     6c2:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
     6c5:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
     6c9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     6cd:	75 27                	jne    6f6 <printf+0x11f>
          s = "(null)";
     6cf:	c7 45 f4 29 11 00 00 	movl   $0x1129,-0xc(%ebp)
        while(*s != 0){
     6d6:	eb 1e                	jmp    6f6 <printf+0x11f>
          putc(fd, *s);
     6d8:	8b 45 f4             	mov    -0xc(%ebp),%eax
     6db:	0f b6 00             	movzbl (%eax),%eax
     6de:	0f be c0             	movsbl %al,%eax
     6e1:	89 44 24 04          	mov    %eax,0x4(%esp)
     6e5:	8b 45 08             	mov    0x8(%ebp),%eax
     6e8:	89 04 24             	mov    %eax,(%esp)
     6eb:	e8 10 fe ff ff       	call   500 <putc>
          s++;
     6f0:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     6f4:	eb 01                	jmp    6f7 <printf+0x120>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
     6f6:	90                   	nop
     6f7:	8b 45 f4             	mov    -0xc(%ebp),%eax
     6fa:	0f b6 00             	movzbl (%eax),%eax
     6fd:	84 c0                	test   %al,%al
     6ff:	75 d7                	jne    6d8 <printf+0x101>
     701:	eb 68                	jmp    76b <printf+0x194>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
     703:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
     707:	75 1d                	jne    726 <printf+0x14f>
        putc(fd, *ap);
     709:	8b 45 e8             	mov    -0x18(%ebp),%eax
     70c:	8b 00                	mov    (%eax),%eax
     70e:	0f be c0             	movsbl %al,%eax
     711:	89 44 24 04          	mov    %eax,0x4(%esp)
     715:	8b 45 08             	mov    0x8(%ebp),%eax
     718:	89 04 24             	mov    %eax,(%esp)
     71b:	e8 e0 fd ff ff       	call   500 <putc>
        ap++;
     720:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     724:	eb 45                	jmp    76b <printf+0x194>
      } else if(c == '%'){
     726:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     72a:	75 17                	jne    743 <printf+0x16c>
        putc(fd, c);
     72c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     72f:	0f be c0             	movsbl %al,%eax
     732:	89 44 24 04          	mov    %eax,0x4(%esp)
     736:	8b 45 08             	mov    0x8(%ebp),%eax
     739:	89 04 24             	mov    %eax,(%esp)
     73c:	e8 bf fd ff ff       	call   500 <putc>
     741:	eb 28                	jmp    76b <printf+0x194>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     743:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
     74a:	00 
     74b:	8b 45 08             	mov    0x8(%ebp),%eax
     74e:	89 04 24             	mov    %eax,(%esp)
     751:	e8 aa fd ff ff       	call   500 <putc>
        putc(fd, c);
     756:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     759:	0f be c0             	movsbl %al,%eax
     75c:	89 44 24 04          	mov    %eax,0x4(%esp)
     760:	8b 45 08             	mov    0x8(%ebp),%eax
     763:	89 04 24             	mov    %eax,(%esp)
     766:	e8 95 fd ff ff       	call   500 <putc>
      }
      state = 0;
     76b:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     772:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     776:	8b 55 0c             	mov    0xc(%ebp),%edx
     779:	8b 45 f0             	mov    -0x10(%ebp),%eax
     77c:	01 d0                	add    %edx,%eax
     77e:	0f b6 00             	movzbl (%eax),%eax
     781:	84 c0                	test   %al,%al
     783:	0f 85 70 fe ff ff    	jne    5f9 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
     789:	c9                   	leave  
     78a:	c3                   	ret    
     78b:	90                   	nop

0000078c <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     78c:	55                   	push   %ebp
     78d:	89 e5                	mov    %esp,%ebp
     78f:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
     792:	8b 45 08             	mov    0x8(%ebp),%eax
     795:	83 e8 08             	sub    $0x8,%eax
     798:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     79b:	a1 68 16 00 00       	mov    0x1668,%eax
     7a0:	89 45 fc             	mov    %eax,-0x4(%ebp)
     7a3:	eb 24                	jmp    7c9 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     7a5:	8b 45 fc             	mov    -0x4(%ebp),%eax
     7a8:	8b 00                	mov    (%eax),%eax
     7aa:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     7ad:	77 12                	ja     7c1 <free+0x35>
     7af:	8b 45 f8             	mov    -0x8(%ebp),%eax
     7b2:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     7b5:	77 24                	ja     7db <free+0x4f>
     7b7:	8b 45 fc             	mov    -0x4(%ebp),%eax
     7ba:	8b 00                	mov    (%eax),%eax
     7bc:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     7bf:	77 1a                	ja     7db <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     7c1:	8b 45 fc             	mov    -0x4(%ebp),%eax
     7c4:	8b 00                	mov    (%eax),%eax
     7c6:	89 45 fc             	mov    %eax,-0x4(%ebp)
     7c9:	8b 45 f8             	mov    -0x8(%ebp),%eax
     7cc:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     7cf:	76 d4                	jbe    7a5 <free+0x19>
     7d1:	8b 45 fc             	mov    -0x4(%ebp),%eax
     7d4:	8b 00                	mov    (%eax),%eax
     7d6:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     7d9:	76 ca                	jbe    7a5 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
     7db:	8b 45 f8             	mov    -0x8(%ebp),%eax
     7de:	8b 40 04             	mov    0x4(%eax),%eax
     7e1:	c1 e0 03             	shl    $0x3,%eax
     7e4:	89 c2                	mov    %eax,%edx
     7e6:	03 55 f8             	add    -0x8(%ebp),%edx
     7e9:	8b 45 fc             	mov    -0x4(%ebp),%eax
     7ec:	8b 00                	mov    (%eax),%eax
     7ee:	39 c2                	cmp    %eax,%edx
     7f0:	75 24                	jne    816 <free+0x8a>
    bp->s.size += p->s.ptr->s.size;
     7f2:	8b 45 f8             	mov    -0x8(%ebp),%eax
     7f5:	8b 50 04             	mov    0x4(%eax),%edx
     7f8:	8b 45 fc             	mov    -0x4(%ebp),%eax
     7fb:	8b 00                	mov    (%eax),%eax
     7fd:	8b 40 04             	mov    0x4(%eax),%eax
     800:	01 c2                	add    %eax,%edx
     802:	8b 45 f8             	mov    -0x8(%ebp),%eax
     805:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
     808:	8b 45 fc             	mov    -0x4(%ebp),%eax
     80b:	8b 00                	mov    (%eax),%eax
     80d:	8b 10                	mov    (%eax),%edx
     80f:	8b 45 f8             	mov    -0x8(%ebp),%eax
     812:	89 10                	mov    %edx,(%eax)
     814:	eb 0a                	jmp    820 <free+0x94>
  } else
    bp->s.ptr = p->s.ptr;
     816:	8b 45 fc             	mov    -0x4(%ebp),%eax
     819:	8b 10                	mov    (%eax),%edx
     81b:	8b 45 f8             	mov    -0x8(%ebp),%eax
     81e:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
     820:	8b 45 fc             	mov    -0x4(%ebp),%eax
     823:	8b 40 04             	mov    0x4(%eax),%eax
     826:	c1 e0 03             	shl    $0x3,%eax
     829:	03 45 fc             	add    -0x4(%ebp),%eax
     82c:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     82f:	75 20                	jne    851 <free+0xc5>
    p->s.size += bp->s.size;
     831:	8b 45 fc             	mov    -0x4(%ebp),%eax
     834:	8b 50 04             	mov    0x4(%eax),%edx
     837:	8b 45 f8             	mov    -0x8(%ebp),%eax
     83a:	8b 40 04             	mov    0x4(%eax),%eax
     83d:	01 c2                	add    %eax,%edx
     83f:	8b 45 fc             	mov    -0x4(%ebp),%eax
     842:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
     845:	8b 45 f8             	mov    -0x8(%ebp),%eax
     848:	8b 10                	mov    (%eax),%edx
     84a:	8b 45 fc             	mov    -0x4(%ebp),%eax
     84d:	89 10                	mov    %edx,(%eax)
     84f:	eb 08                	jmp    859 <free+0xcd>
  } else
    p->s.ptr = bp;
     851:	8b 45 fc             	mov    -0x4(%ebp),%eax
     854:	8b 55 f8             	mov    -0x8(%ebp),%edx
     857:	89 10                	mov    %edx,(%eax)
  freep = p;
     859:	8b 45 fc             	mov    -0x4(%ebp),%eax
     85c:	a3 68 16 00 00       	mov    %eax,0x1668
}
     861:	c9                   	leave  
     862:	c3                   	ret    

00000863 <morecore>:

static Header*
morecore(uint nu)
{
     863:	55                   	push   %ebp
     864:	89 e5                	mov    %esp,%ebp
     866:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
     869:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
     870:	77 07                	ja     879 <morecore+0x16>
    nu = 4096;
     872:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
     879:	8b 45 08             	mov    0x8(%ebp),%eax
     87c:	c1 e0 03             	shl    $0x3,%eax
     87f:	89 04 24             	mov    %eax,(%esp)
     882:	e8 29 fc ff ff       	call   4b0 <sbrk>
     887:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
     88a:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     88e:	75 07                	jne    897 <morecore+0x34>
    return 0;
     890:	b8 00 00 00 00       	mov    $0x0,%eax
     895:	eb 22                	jmp    8b9 <morecore+0x56>
  hp = (Header*)p;
     897:	8b 45 f4             	mov    -0xc(%ebp),%eax
     89a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
     89d:	8b 45 f0             	mov    -0x10(%ebp),%eax
     8a0:	8b 55 08             	mov    0x8(%ebp),%edx
     8a3:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
     8a6:	8b 45 f0             	mov    -0x10(%ebp),%eax
     8a9:	83 c0 08             	add    $0x8,%eax
     8ac:	89 04 24             	mov    %eax,(%esp)
     8af:	e8 d8 fe ff ff       	call   78c <free>
  return freep;
     8b4:	a1 68 16 00 00       	mov    0x1668,%eax
}
     8b9:	c9                   	leave  
     8ba:	c3                   	ret    

000008bb <malloc>:

void*
malloc(uint nbytes)
{
     8bb:	55                   	push   %ebp
     8bc:	89 e5                	mov    %esp,%ebp
     8be:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     8c1:	8b 45 08             	mov    0x8(%ebp),%eax
     8c4:	83 c0 07             	add    $0x7,%eax
     8c7:	c1 e8 03             	shr    $0x3,%eax
     8ca:	83 c0 01             	add    $0x1,%eax
     8cd:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
     8d0:	a1 68 16 00 00       	mov    0x1668,%eax
     8d5:	89 45 f0             	mov    %eax,-0x10(%ebp)
     8d8:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     8dc:	75 23                	jne    901 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     8de:	c7 45 f0 60 16 00 00 	movl   $0x1660,-0x10(%ebp)
     8e5:	8b 45 f0             	mov    -0x10(%ebp),%eax
     8e8:	a3 68 16 00 00       	mov    %eax,0x1668
     8ed:	a1 68 16 00 00       	mov    0x1668,%eax
     8f2:	a3 60 16 00 00       	mov    %eax,0x1660
    base.s.size = 0;
     8f7:	c7 05 64 16 00 00 00 	movl   $0x0,0x1664
     8fe:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     901:	8b 45 f0             	mov    -0x10(%ebp),%eax
     904:	8b 00                	mov    (%eax),%eax
     906:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
     909:	8b 45 f4             	mov    -0xc(%ebp),%eax
     90c:	8b 40 04             	mov    0x4(%eax),%eax
     90f:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     912:	72 4d                	jb     961 <malloc+0xa6>
      if(p->s.size == nunits)
     914:	8b 45 f4             	mov    -0xc(%ebp),%eax
     917:	8b 40 04             	mov    0x4(%eax),%eax
     91a:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     91d:	75 0c                	jne    92b <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
     91f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     922:	8b 10                	mov    (%eax),%edx
     924:	8b 45 f0             	mov    -0x10(%ebp),%eax
     927:	89 10                	mov    %edx,(%eax)
     929:	eb 26                	jmp    951 <malloc+0x96>
      else {
        p->s.size -= nunits;
     92b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     92e:	8b 40 04             	mov    0x4(%eax),%eax
     931:	89 c2                	mov    %eax,%edx
     933:	2b 55 ec             	sub    -0x14(%ebp),%edx
     936:	8b 45 f4             	mov    -0xc(%ebp),%eax
     939:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
     93c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     93f:	8b 40 04             	mov    0x4(%eax),%eax
     942:	c1 e0 03             	shl    $0x3,%eax
     945:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
     948:	8b 45 f4             	mov    -0xc(%ebp),%eax
     94b:	8b 55 ec             	mov    -0x14(%ebp),%edx
     94e:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
     951:	8b 45 f0             	mov    -0x10(%ebp),%eax
     954:	a3 68 16 00 00       	mov    %eax,0x1668
      return (void*)(p + 1);
     959:	8b 45 f4             	mov    -0xc(%ebp),%eax
     95c:	83 c0 08             	add    $0x8,%eax
     95f:	eb 38                	jmp    999 <malloc+0xde>
    }
    if(p == freep)
     961:	a1 68 16 00 00       	mov    0x1668,%eax
     966:	39 45 f4             	cmp    %eax,-0xc(%ebp)
     969:	75 1b                	jne    986 <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
     96b:	8b 45 ec             	mov    -0x14(%ebp),%eax
     96e:	89 04 24             	mov    %eax,(%esp)
     971:	e8 ed fe ff ff       	call   863 <morecore>
     976:	89 45 f4             	mov    %eax,-0xc(%ebp)
     979:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     97d:	75 07                	jne    986 <malloc+0xcb>
        return 0;
     97f:	b8 00 00 00 00       	mov    $0x0,%eax
     984:	eb 13                	jmp    999 <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     986:	8b 45 f4             	mov    -0xc(%ebp),%eax
     989:	89 45 f0             	mov    %eax,-0x10(%ebp)
     98c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     98f:	8b 00                	mov    (%eax),%eax
     991:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
     994:	e9 70 ff ff ff       	jmp    909 <malloc+0x4e>
}
     999:	c9                   	leave  
     99a:	c3                   	ret    
     99b:	90                   	nop

0000099c <print_stack>:
 * prints the stack of the currently running thread
 * DEBUGGING purposes
 */
void
print_stack()
{
     99c:	55                   	push   %ebp
     99d:	89 e5                	mov    %esp,%ebp
     99f:	83 ec 28             	sub    $0x28,%esp
  int *newesp = (int*)currentThread->esp;  
     9a2:	a1 80 61 00 00       	mov    0x6180,%eax
     9a7:	8b 40 04             	mov    0x4(%eax),%eax
     9aa:	89 45 f4             	mov    %eax,-0xc(%ebp)
  printf(1,"stack for thread %d \n",currentThread->tid);
     9ad:	a1 80 61 00 00       	mov    0x6180,%eax
     9b2:	8b 00                	mov    (%eax),%eax
     9b4:	89 44 24 08          	mov    %eax,0x8(%esp)
     9b8:	c7 44 24 04 30 11 00 	movl   $0x1130,0x4(%esp)
     9bf:	00 
     9c0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     9c7:	e8 0b fc ff ff       	call   5d7 <printf>
  while((newesp < (int *)currentThread->ebp))
     9cc:	eb 3c                	jmp    a0a <print_stack+0x6e>
  {
    printf(1,"add:%x ",newesp);
     9ce:	8b 45 f4             	mov    -0xc(%ebp),%eax
     9d1:	89 44 24 08          	mov    %eax,0x8(%esp)
     9d5:	c7 44 24 04 46 11 00 	movl   $0x1146,0x4(%esp)
     9dc:	00 
     9dd:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     9e4:	e8 ee fb ff ff       	call   5d7 <printf>
      printf(1,"val:%x\n",*newesp);
     9e9:	8b 45 f4             	mov    -0xc(%ebp),%eax
     9ec:	8b 00                	mov    (%eax),%eax
     9ee:	89 44 24 08          	mov    %eax,0x8(%esp)
     9f2:	c7 44 24 04 4e 11 00 	movl   $0x114e,0x4(%esp)
     9f9:	00 
     9fa:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     a01:	e8 d1 fb ff ff       	call   5d7 <printf>
    newesp++;
     a06:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
void
print_stack()
{
  int *newesp = (int*)currentThread->esp;  
  printf(1,"stack for thread %d \n",currentThread->tid);
  while((newesp < (int *)currentThread->ebp))
     a0a:	a1 80 61 00 00       	mov    0x6180,%eax
     a0f:	8b 40 08             	mov    0x8(%eax),%eax
     a12:	3b 45 f4             	cmp    -0xc(%ebp),%eax
     a15:	77 b7                	ja     9ce <print_stack+0x32>
    printf(1,"add:%x ",newesp);
      printf(1,"val:%x\n",*newesp);
    newesp++;
  }

}
     a17:	c9                   	leave  
     a18:	c3                   	ret    

00000a19 <getNextThread>:
 * returns the next thread in line to run
 * if none exists it returns -1
 */
int
getNextThread(int j)
{
     a19:	55                   	push   %ebp
     a1a:	89 e5                	mov    %esp,%ebp
     a1c:	83 ec 10             	sub    $0x10,%esp
  int i=j+1;
     a1f:	8b 45 08             	mov    0x8(%ebp),%eax
     a22:	83 c0 01             	add    $0x1,%eax
     a25:	89 45 fc             	mov    %eax,-0x4(%ebp)
  if(i==MAX_THREAD)
     a28:	83 7d fc 40          	cmpl   $0x40,-0x4(%ebp)
     a2c:	75 07                	jne    a35 <getNextThread+0x1c>
    i=0;
     a2e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  uthread_p t=&tTable.table[i];
     a35:	8b 45 fc             	mov    -0x4(%ebp),%eax
     a38:	69 c0 24 01 00 00    	imul   $0x124,%eax,%eax
     a3e:	05 80 16 00 00       	add    $0x1680,%eax
     a43:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(i!=j)
     a46:	eb 3b                	jmp    a83 <getNextThread+0x6a>
  {
    if(t->state==T_RUNNABLE)
     a48:	8b 45 f8             	mov    -0x8(%ebp),%eax
     a4b:	8b 40 10             	mov    0x10(%eax),%eax
     a4e:	83 f8 03             	cmp    $0x3,%eax
     a51:	75 05                	jne    a58 <getNextThread+0x3f>
      return i;
     a53:	8b 45 fc             	mov    -0x4(%ebp),%eax
     a56:	eb 38                	jmp    a90 <getNextThread+0x77>
    i++;
     a58:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    if(i==MAX_THREAD)
     a5c:	83 7d fc 40          	cmpl   $0x40,-0x4(%ebp)
     a60:	75 1a                	jne    a7c <getNextThread+0x63>
    {
     i=0;
     a62:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
     t=&tTable.table[i];
     a69:	8b 45 fc             	mov    -0x4(%ebp),%eax
     a6c:	69 c0 24 01 00 00    	imul   $0x124,%eax,%eax
     a72:	05 80 16 00 00       	add    $0x1680,%eax
     a77:	89 45 f8             	mov    %eax,-0x8(%ebp)
     a7a:	eb 07                	jmp    a83 <getNextThread+0x6a>
   }
   else
    t++;
     a7c:	81 45 f8 24 01 00 00 	addl   $0x124,-0x8(%ebp)
{
  int i=j+1;
  if(i==MAX_THREAD)
    i=0;
  uthread_p t=&tTable.table[i];
  while(i!=j)
     a83:	8b 45 fc             	mov    -0x4(%ebp),%eax
     a86:	3b 45 08             	cmp    0x8(%ebp),%eax
     a89:	75 bd                	jne    a48 <getNextThread+0x2f>
   }
   else
    t++;

}
return -1;
     a8b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
     a90:	c9                   	leave  
     a91:	c3                   	ret    

00000a92 <allocThread>:
 * allocates a spot for a new thread
 * if none exist it returns NULL
 */
static uthread_p
allocThread()
{
     a92:	55                   	push   %ebp
     a93:	89 e5                	mov    %esp,%ebp
     a95:	83 ec 28             	sub    $0x28,%esp
  int i,j;
  uthread_p t;
  
  for (t=tTable.table,i=0 ; t < &tTable.table[MAX_THREAD]; t++,i++)
     a98:	c7 45 ec 80 16 00 00 	movl   $0x1680,-0x14(%ebp)
     a9f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     aa6:	eb 15                	jmp    abd <allocThread+0x2b>
  {
    if(t->state==T_FREE)
     aa8:	8b 45 ec             	mov    -0x14(%ebp),%eax
     aab:	8b 40 10             	mov    0x10(%eax),%eax
     aae:	85 c0                	test   %eax,%eax
     ab0:	74 1e                	je     ad0 <allocThread+0x3e>
allocThread()
{
  int i,j;
  uthread_p t;
  
  for (t=tTable.table,i=0 ; t < &tTable.table[MAX_THREAD]; t++,i++)
     ab2:	81 45 ec 24 01 00 00 	addl   $0x124,-0x14(%ebp)
     ab9:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     abd:	81 7d ec 80 5f 00 00 	cmpl   $0x5f80,-0x14(%ebp)
     ac4:	72 e2                	jb     aa8 <allocThread+0x16>
  {
    if(t->state==T_FREE)
      goto found;
  }
  return 0;
     ac6:	b8 00 00 00 00       	mov    $0x0,%eax
     acb:	e9 a3 00 00 00       	jmp    b73 <allocThread+0xe1>
  uthread_p t;
  
  for (t=tTable.table,i=0 ; t < &tTable.table[MAX_THREAD]; t++,i++)
  {
    if(t->state==T_FREE)
      goto found;
     ad0:	90                   	nop
  }
  return 0;
  
  found:
  //Init all fields
  t->tid=i;
     ad1:	8b 45 ec             	mov    -0x14(%ebp),%eax
     ad4:	8b 55 f4             	mov    -0xc(%ebp),%edx
     ad7:	89 10                	mov    %edx,(%eax)
  if(i==0) //main thread init
     ad9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     add:	75 1c                	jne    afb <allocThread+0x69>
  {
    STORE_ESP(t->esp);
     adf:	89 e2                	mov    %esp,%edx
     ae1:	8b 45 ec             	mov    -0x14(%ebp),%eax
     ae4:	89 50 04             	mov    %edx,0x4(%eax)
    STORE_EBP(t->ebp);
     ae7:	89 ea                	mov    %ebp,%edx
     ae9:	8b 45 ec             	mov    -0x14(%ebp),%eax
     aec:	89 50 08             	mov    %edx,0x8(%eax)
    t->firstTime=0;
     aef:	8b 45 ec             	mov    -0x14(%ebp),%eax
     af2:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
     af9:	eb 3b                	jmp    b36 <allocThread+0xa4>
  }
  else
  {
    t->stack=(char*)malloc(STACK_SIZE);
     afb:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
     b02:	e8 b4 fd ff ff       	call   8bb <malloc>
     b07:	8b 55 ec             	mov    -0x14(%ebp),%edx
     b0a:	89 42 0c             	mov    %eax,0xc(%edx)
    t->ebp=(int)t->stack+STACK_SIZE;
     b0d:	8b 45 ec             	mov    -0x14(%ebp),%eax
     b10:	8b 40 0c             	mov    0xc(%eax),%eax
     b13:	05 00 10 00 00       	add    $0x1000,%eax
     b18:	89 c2                	mov    %eax,%edx
     b1a:	8b 45 ec             	mov    -0x14(%ebp),%eax
     b1d:	89 50 08             	mov    %edx,0x8(%eax)
    t->esp=t->ebp;
     b20:	8b 45 ec             	mov    -0x14(%ebp),%eax
     b23:	8b 50 08             	mov    0x8(%eax),%edx
     b26:	8b 45 ec             	mov    -0x14(%ebp),%eax
     b29:	89 50 04             	mov    %edx,0x4(%eax)
    t->firstTime=1;
     b2c:	8b 45 ec             	mov    -0x14(%ebp),%eax
     b2f:	c7 40 14 01 00 00 00 	movl   $0x1,0x14(%eax)
  }
  
  t->waitingFor=-1;
     b36:	8b 45 ec             	mov    -0x14(%ebp),%eax
     b39:	c7 80 20 01 00 00 ff 	movl   $0xffffffff,0x120(%eax)
     b40:	ff ff ff 
  
  for(j=0;j<MAX_THREAD;j++)
     b43:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     b4a:	eb 14                	jmp    b60 <allocThread+0xce>
  {
    t->waitedOn[j]=-1;
     b4c:	8b 45 ec             	mov    -0x14(%ebp),%eax
     b4f:	8b 55 f0             	mov    -0x10(%ebp),%edx
     b52:	83 c2 08             	add    $0x8,%edx
     b55:	c7 04 90 ff ff ff ff 	movl   $0xffffffff,(%eax,%edx,4)
    t->firstTime=1;
  }
  
  t->waitingFor=-1;
  
  for(j=0;j<MAX_THREAD;j++)
     b5c:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     b60:	83 7d f0 3f          	cmpl   $0x3f,-0x10(%ebp)
     b64:	7e e6                	jle    b4c <allocThread+0xba>
  {
    t->waitedOn[j]=-1;
  }
   
  t->state=T_UNINIT;
     b66:	8b 45 ec             	mov    -0x14(%ebp),%eax
     b69:	c7 40 10 01 00 00 00 	movl   $0x1,0x10(%eax)
  
    
  return t;
     b70:	8b 45 ec             	mov    -0x14(%ebp),%eax
}
     b73:	c9                   	leave  
     b74:	c3                   	ret    

00000b75 <uthread_init>:
/*
 * initializes all the uthread structures
 */
int
uthread_init()
{   
     b75:	55                   	push   %ebp
     b76:	89 e5                	mov    %esp,%ebp
     b78:	83 ec 28             	sub    $0x28,%esp
  //Initialize table
  int i;
  
  for(i=0;i<MAX_THREAD;i++)
     b7b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     b82:	eb 18                	jmp    b9c <uthread_init+0x27>
  {
    tTable.table[i].state=T_FREE;
     b84:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b87:	69 c0 24 01 00 00    	imul   $0x124,%eax,%eax
     b8d:	05 90 16 00 00       	add    $0x1690,%eax
     b92:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
uthread_init()
{   
  //Initialize table
  int i;
  
  for(i=0;i<MAX_THREAD;i++)
     b98:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     b9c:	83 7d f4 3f          	cmpl   $0x3f,-0xc(%ebp)
     ba0:	7e e2                	jle    b84 <uthread_init+0xf>
  {
    tTable.table[i].state=T_FREE;
  }
  
 //allocate the main thread
  currentThread = allocThread();
     ba2:	e8 eb fe ff ff       	call   a92 <allocThread>
     ba7:	a3 80 61 00 00       	mov    %eax,0x6180
  if(currentThread==0)
     bac:	a1 80 61 00 00       	mov    0x6180,%eax
     bb1:	85 c0                	test   %eax,%eax
     bb3:	75 07                	jne    bbc <uthread_init+0x47>
    return -1;
     bb5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     bba:	eb 6b                	jmp    c27 <uthread_init+0xb2>
  
  currentThread->state = T_RUNNING;
     bbc:	a1 80 61 00 00       	mov    0x6180,%eax
     bc1:	c7 40 10 02 00 00 00 	movl   $0x2,0x10(%eax)
  //register uthread_yield as signal handler for alarm
  if(signal(SIGALRM,uthread_yield)<0)
     bc8:	c7 44 24 04 af 0e 00 	movl   $0xeaf,0x4(%esp)
     bcf:	00 
     bd0:	c7 04 24 0e 00 00 00 	movl   $0xe,(%esp)
     bd7:	e8 0c f9 ff ff       	call   4e8 <signal>
     bdc:	85 c0                	test   %eax,%eax
     bde:	79 19                	jns    bf9 <uthread_init+0x84>
  {
    printf(1,"Cant register the alarm signal");
     be0:	c7 44 24 04 58 11 00 	movl   $0x1158,0x4(%esp)
     be7:	00 
     be8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     bef:	e8 e3 f9 ff ff       	call   5d7 <printf>
    exit();
     bf4:	e8 2f f8 ff ff       	call   428 <exit>
  }
  //set new alarm clock
  if(alarm(THREAD_QUANTA)<0)
     bf9:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
     c00:	e8 f3 f8 ff ff       	call   4f8 <alarm>
     c05:	85 c0                	test   %eax,%eax
     c07:	79 19                	jns    c22 <uthread_init+0xad>
  {
    printf(1,"Cant activate alarm system call");
     c09:	c7 44 24 04 78 11 00 	movl   $0x1178,0x4(%esp)
     c10:	00 
     c11:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     c18:	e8 ba f9 ff ff       	call   5d7 <printf>
    exit();
     c1d:	e8 06 f8 ff ff       	call   428 <exit>
  }
  return 0;
     c22:	b8 00 00 00 00       	mov    $0x0,%eax
}
     c27:	c9                   	leave  
     c28:	c3                   	ret    

00000c29 <wrap_func>:

void
wrap_func()
{
     c29:	55                   	push   %ebp
     c2a:	89 e5                	mov    %esp,%ebp
     c2c:	83 ec 18             	sub    $0x18,%esp
  currentThread->func(currentThread->arguments);
     c2f:	a1 80 61 00 00       	mov    0x6180,%eax
     c34:	8b 50 18             	mov    0x18(%eax),%edx
     c37:	a1 80 61 00 00       	mov    0x6180,%eax
     c3c:	8b 40 1c             	mov    0x1c(%eax),%eax
     c3f:	89 04 24             	mov    %eax,(%esp)
     c42:	ff d2                	call   *%edx
  uthread_exit();
     c44:	e8 6c 00 00 00       	call   cb5 <uthread_exit>
}
     c49:	c9                   	leave  
     c4a:	c3                   	ret    

00000c4b <uthread_create>:
 * to that function
 * if none can be created it returns -1;
 */
int  
uthread_create(void (*start_func)(void *), void* arg)
{
     c4b:	55                   	push   %ebp
     c4c:	89 e5                	mov    %esp,%ebp
     c4e:	53                   	push   %ebx
     c4f:	83 ec 14             	sub    $0x14,%esp
  uint local_esp;
  uthread_p t = allocThread();
     c52:	e8 3b fe ff ff       	call   a92 <allocThread>
     c57:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(t==0)
     c5a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     c5e:	75 07                	jne    c67 <uthread_create+0x1c>
    return -1;
     c60:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     c65:	eb 48                	jmp    caf <uthread_create+0x64>

  t->func=start_func;
     c67:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c6a:	8b 55 08             	mov    0x8(%ebp),%edx
     c6d:	89 50 18             	mov    %edx,0x18(%eax)
  t->arguments=arg;
     c70:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c73:	8b 55 0c             	mov    0xc(%ebp),%edx
     c76:	89 50 1c             	mov    %edx,0x1c(%eax)
  
  //push starting func and return value on the right stack
  STORE_ESP(local_esp);
     c79:	89 e3                	mov    %esp,%ebx
     c7b:	89 5d f0             	mov    %ebx,-0x10(%ebp)
  LOAD_ESP(t->esp);
     c7e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c81:	8b 40 04             	mov    0x4(%eax),%eax
     c84:	89 c4                	mov    %eax,%esp
  PUSH_FUNC(t->esp,t->ebp,wrap_func);
     c86:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c89:	8b 50 08             	mov    0x8(%eax),%edx
     c8c:	b8 29 0c 00 00       	mov    $0xc29,%eax
     c91:	50                   	push   %eax
     c92:	52                   	push   %edx
     c93:	89 e2                	mov    %esp,%edx
     c95:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c98:	89 50 04             	mov    %edx,0x4(%eax)
  LOAD_ESP(local_esp);
     c9b:	8b 45 f0             	mov    -0x10(%ebp),%eax
     c9e:	89 c4                	mov    %eax,%esp
  
  t->state = T_RUNNABLE;
     ca0:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ca3:	c7 40 10 03 00 00 00 	movl   $0x3,0x10(%eax)
  
  return t->tid;
     caa:	8b 45 f4             	mov    -0xc(%ebp),%eax
     cad:	8b 00                	mov    (%eax),%eax
}
     caf:	83 c4 14             	add    $0x14,%esp
     cb2:	5b                   	pop    %ebx
     cb3:	5d                   	pop    %ebp
     cb4:	c3                   	ret    

00000cb5 <uthread_exit>:
 * closes the running thread, wakes up all
 * the threads waiting for this one (if they require waking up)
 */
void 
uthread_exit()
{
     cb5:	55                   	push   %ebp
     cb6:	89 e5                	mov    %esp,%ebp
     cb8:	83 ec 28             	sub    $0x28,%esp
  alarm(0); //clear the alarm so as not to disturb running of function
     cbb:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     cc2:	e8 31 f8 ff ff       	call   4f8 <alarm>
  int new,i;
  //wakeup all threads waiting for this one
  for(i=0;i<MAX_THREAD;i++)
     cc7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     cce:	eb 51                	jmp    d21 <uthread_exit+0x6c>
  {
   if(currentThread->waitedOn[i]==1)
     cd0:	a1 80 61 00 00       	mov    0x6180,%eax
     cd5:	8b 55 f4             	mov    -0xc(%ebp),%edx
     cd8:	83 c2 08             	add    $0x8,%edx
     cdb:	8b 04 90             	mov    (%eax,%edx,4),%eax
     cde:	83 f8 01             	cmp    $0x1,%eax
     ce1:	75 3a                	jne    d1d <uthread_exit+0x68>
   {
     tTable.table[i].waitingFor=-1; //release thread i from waiting
     ce3:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ce6:	69 c0 24 01 00 00    	imul   $0x124,%eax,%eax
     cec:	05 a0 17 00 00       	add    $0x17a0,%eax
     cf1:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)
     currentThread->waitedOn[i]=0; //not necessary maybe   
     cf7:	a1 80 61 00 00       	mov    0x6180,%eax
     cfc:	8b 55 f4             	mov    -0xc(%ebp),%edx
     cff:	83 c2 08             	add    $0x8,%edx
     d02:	c7 04 90 00 00 00 00 	movl   $0x0,(%eax,%edx,4)
     tTable.table[i].state=T_RUNNABLE;
     d09:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d0c:	69 c0 24 01 00 00    	imul   $0x124,%eax,%eax
     d12:	05 90 16 00 00       	add    $0x1690,%eax
     d17:	c7 00 03 00 00 00    	movl   $0x3,(%eax)
uthread_exit()
{
  alarm(0); //clear the alarm so as not to disturb running of function
  int new,i;
  //wakeup all threads waiting for this one
  for(i=0;i<MAX_THREAD;i++)
     d1d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     d21:	83 7d f4 3f          	cmpl   $0x3f,-0xc(%ebp)
     d25:	7e a9                	jle    cd0 <uthread_exit+0x1b>
     tTable.table[i].state=T_RUNNABLE;
   }
  }
  
  //pick next thread
  new=getNextThread(currentThread->tid);
     d27:	a1 80 61 00 00       	mov    0x6180,%eax
     d2c:	8b 00                	mov    (%eax),%eax
     d2e:	89 04 24             	mov    %eax,(%esp)
     d31:	e8 e3 fc ff ff       	call   a19 <getNextThread>
     d36:	89 45 f0             	mov    %eax,-0x10(%ebp)
  
  //release all resources and zero all fields
  if(currentThread->tid!=0)
     d39:	a1 80 61 00 00       	mov    0x6180,%eax
     d3e:	8b 00                	mov    (%eax),%eax
     d40:	85 c0                	test   %eax,%eax
     d42:	74 10                	je     d54 <uthread_exit+0x9f>
    free(currentThread->stack);
     d44:	a1 80 61 00 00       	mov    0x6180,%eax
     d49:	8b 40 0c             	mov    0xc(%eax),%eax
     d4c:	89 04 24             	mov    %eax,(%esp)
     d4f:	e8 38 fa ff ff       	call   78c <free>
  currentThread->tid=-1;
     d54:	a1 80 61 00 00       	mov    0x6180,%eax
     d59:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)
  currentThread->esp=-1;
     d5f:	a1 80 61 00 00       	mov    0x6180,%eax
     d64:	c7 40 04 ff ff ff ff 	movl   $0xffffffff,0x4(%eax)
  currentThread->ebp=-1;
     d6b:	a1 80 61 00 00       	mov    0x6180,%eax
     d70:	c7 40 08 ff ff ff ff 	movl   $0xffffffff,0x8(%eax)
  currentThread->func=0;
     d77:	a1 80 61 00 00       	mov    0x6180,%eax
     d7c:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)
  currentThread->arguments=0;
     d83:	a1 80 61 00 00       	mov    0x6180,%eax
     d88:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
  currentThread->stack=0;
     d8f:	a1 80 61 00 00       	mov    0x6180,%eax
     d94:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
  currentThread->firstTime=1;
     d9b:	a1 80 61 00 00       	mov    0x6180,%eax
     da0:	c7 40 14 01 00 00 00 	movl   $0x1,0x14(%eax)
  currentThread->state=T_FREE;
     da7:	a1 80 61 00 00       	mov    0x6180,%eax
     dac:	c7 40 10 00 00 00 00 	movl   $0x0,0x10(%eax)
  
  //load new thread
  if(new>=0)
     db3:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     db7:	78 7a                	js     e33 <uthread_exit+0x17e>
  {
    currentThread=&tTable.table[new];
     db9:	8b 45 f0             	mov    -0x10(%ebp),%eax
     dbc:	69 c0 24 01 00 00    	imul   $0x124,%eax,%eax
     dc2:	05 80 16 00 00       	add    $0x1680,%eax
     dc7:	a3 80 61 00 00       	mov    %eax,0x6180
    currentThread->state=T_RUNNING;
     dcc:	a1 80 61 00 00       	mov    0x6180,%eax
     dd1:	c7 40 10 02 00 00 00 	movl   $0x2,0x10(%eax)
    LOAD_ESP(currentThread->esp);
     dd8:	a1 80 61 00 00       	mov    0x6180,%eax
     ddd:	8b 40 04             	mov    0x4(%eax),%eax
     de0:	89 c4                	mov    %eax,%esp
    LOAD_EBP(currentThread->ebp);
     de2:	a1 80 61 00 00       	mov    0x6180,%eax
     de7:	8b 40 08             	mov    0x8(%eax),%eax
     dea:	89 c5                	mov    %eax,%ebp
    
    //set new alarm clock
    if(alarm(THREAD_QUANTA)<0)
     dec:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
     df3:	e8 00 f7 ff ff       	call   4f8 <alarm>
     df8:	85 c0                	test   %eax,%eax
     dfa:	79 19                	jns    e15 <uthread_exit+0x160>
    {
      printf(1,"Cant activate alarm system call");
     dfc:	c7 44 24 04 78 11 00 	movl   $0x1178,0x4(%esp)
     e03:	00 
     e04:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     e0b:	e8 c7 f7 ff ff       	call   5d7 <printf>
      exit();
     e10:	e8 13 f6 ff ff       	call   428 <exit>
    }
    
    if(currentThread->firstTime==1)
     e15:	a1 80 61 00 00       	mov    0x6180,%eax
     e1a:	8b 40 14             	mov    0x14(%eax),%eax
     e1d:	83 f8 01             	cmp    $0x1,%eax
     e20:	75 10                	jne    e32 <uthread_exit+0x17d>
    {
      currentThread->firstTime=0;
     e22:	a1 80 61 00 00       	mov    0x6180,%eax
     e27:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
      POP_AND_RET();
     e2e:	5d                   	pop    %ebp
     e2f:	c3                   	ret    
     e30:	eb 01                	jmp    e33 <uthread_exit+0x17e>
    }
    else
    {  
    POP_ALL_REGISTERS();
     e32:	61                   	popa   
    }
  }
}
     e33:	c9                   	leave  
     e34:	c3                   	ret    

00000e35 <uthread_join>:
/*
 * causes this thread to wait for the finish of another thread
 */
int
uthread_join(int tid)
{
     e35:	55                   	push   %ebp
     e36:	89 e5                	mov    %esp,%ebp
     e38:	83 ec 18             	sub    $0x18,%esp
  if((&tTable.table[tid])->state==T_FREE)
     e3b:	8b 45 08             	mov    0x8(%ebp),%eax
     e3e:	69 c0 24 01 00 00    	imul   $0x124,%eax,%eax
     e44:	05 80 16 00 00       	add    $0x1680,%eax
     e49:	8b 40 10             	mov    0x10(%eax),%eax
     e4c:	85 c0                	test   %eax,%eax
     e4e:	75 07                	jne    e57 <uthread_join+0x22>
    return -1;
     e50:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     e55:	eb 56                	jmp    ead <uthread_join+0x78>
  else
  {
    alarm(0); //clear the alarm so as not to disturb running of function
     e57:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     e5e:	e8 95 f6 ff ff       	call   4f8 <alarm>
    currentThread->waitingFor=tid;
     e63:	a1 80 61 00 00       	mov    0x6180,%eax
     e68:	8b 55 08             	mov    0x8(%ebp),%edx
     e6b:	89 90 20 01 00 00    	mov    %edx,0x120(%eax)
    tTable.table[tid].waitedOn[currentThread->tid]=1;
     e71:	a1 80 61 00 00       	mov    0x6180,%eax
     e76:	8b 08                	mov    (%eax),%ecx
     e78:	8b 55 08             	mov    0x8(%ebp),%edx
     e7b:	89 d0                	mov    %edx,%eax
     e7d:	c1 e0 03             	shl    $0x3,%eax
     e80:	01 d0                	add    %edx,%eax
     e82:	c1 e0 03             	shl    $0x3,%eax
     e85:	01 d0                	add    %edx,%eax
     e87:	01 c8                	add    %ecx,%eax
     e89:	83 c0 08             	add    $0x8,%eax
     e8c:	c7 04 85 80 16 00 00 	movl   $0x1,0x1680(,%eax,4)
     e93:	01 00 00 00 
    currentThread->state=T_SLEEPING;
     e97:	a1 80 61 00 00       	mov    0x6180,%eax
     e9c:	c7 40 10 04 00 00 00 	movl   $0x4,0x10(%eax)
    uthread_yield();
     ea3:	e8 07 00 00 00       	call   eaf <uthread_yield>
    return 1;
     ea8:	b8 01 00 00 00       	mov    $0x1,%eax
  }
}
     ead:	c9                   	leave  
     eae:	c3                   	ret    

00000eaf <uthread_yield>:
/*
 * yields the run-time of the current thread to another thread
 */
void 
uthread_yield()
{
     eaf:	55                   	push   %ebp
     eb0:	89 e5                	mov    %esp,%ebp
     eb2:	83 ec 28             	sub    $0x28,%esp
  alarm(0); //clear the alarm so as not to disturb running of function
     eb5:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     ebc:	e8 37 f6 ff ff       	call   4f8 <alarm>
  int new=getNextThread(currentThread->tid);
     ec1:	a1 80 61 00 00       	mov    0x6180,%eax
     ec6:	8b 00                	mov    (%eax),%eax
     ec8:	89 04 24             	mov    %eax,(%esp)
     ecb:	e8 49 fb ff ff       	call   a19 <getNextThread>
     ed0:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(new==-1)
     ed3:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     ed7:	75 2d                	jne    f06 <uthread_yield+0x57>
  {
    if(alarm(THREAD_QUANTA)<0)
     ed9:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
     ee0:	e8 13 f6 ff ff       	call   4f8 <alarm>
     ee5:	85 c0                	test   %eax,%eax
     ee7:	0f 89 c1 00 00 00    	jns    fae <uthread_yield+0xff>
    {
      printf(1,"Cant activate alarm system call\n");
     eed:	c7 44 24 04 98 11 00 	movl   $0x1198,0x4(%esp)
     ef4:	00 
     ef5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     efc:	e8 d6 f6 ff ff       	call   5d7 <printf>
      exit();
     f01:	e8 22 f5 ff ff       	call   428 <exit>
    } 
  }
  else
  {
    //store all leaving thread registers and pointers
    PUSH_ALL_REGISTERS();
     f06:	60                   	pusha  
    STORE_ESP(currentThread->esp);
     f07:	a1 80 61 00 00       	mov    0x6180,%eax
     f0c:	89 e2                	mov    %esp,%edx
     f0e:	89 50 04             	mov    %edx,0x4(%eax)
    STORE_EBP(currentThread->ebp);
     f11:	a1 80 61 00 00       	mov    0x6180,%eax
     f16:	89 ea                	mov    %ebp,%edx
     f18:	89 50 08             	mov    %edx,0x8(%eax)
    
    //change thread state
    if(currentThread->state==T_RUNNING) //might be sleeping from join operation
     f1b:	a1 80 61 00 00       	mov    0x6180,%eax
     f20:	8b 40 10             	mov    0x10(%eax),%eax
     f23:	83 f8 02             	cmp    $0x2,%eax
     f26:	75 0c                	jne    f34 <uthread_yield+0x85>
      currentThread->state=T_RUNNABLE;
     f28:	a1 80 61 00 00       	mov    0x6180,%eax
     f2d:	c7 40 10 03 00 00 00 	movl   $0x3,0x10(%eax)

    currentThread=&tTable.table[new];
     f34:	8b 45 f4             	mov    -0xc(%ebp),%eax
     f37:	69 c0 24 01 00 00    	imul   $0x124,%eax,%eax
     f3d:	05 80 16 00 00       	add    $0x1680,%eax
     f42:	a3 80 61 00 00       	mov    %eax,0x6180

    //load all new thread registers and pointers
    LOAD_ESP(currentThread->esp);
     f47:	a1 80 61 00 00       	mov    0x6180,%eax
     f4c:	8b 40 04             	mov    0x4(%eax),%eax
     f4f:	89 c4                	mov    %eax,%esp
    LOAD_EBP(currentThread->ebp);
     f51:	a1 80 61 00 00       	mov    0x6180,%eax
     f56:	8b 40 08             	mov    0x8(%eax),%eax
     f59:	89 c5                	mov    %eax,%ebp
    //set new alram clock
    if(alarm(THREAD_QUANTA)<0)
     f5b:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
     f62:	e8 91 f5 ff ff       	call   4f8 <alarm>
     f67:	85 c0                	test   %eax,%eax
     f69:	79 19                	jns    f84 <uthread_yield+0xd5>
    {
      printf(1,"Cant activate alarm system call\n");
     f6b:	c7 44 24 04 98 11 00 	movl   $0x1198,0x4(%esp)
     f72:	00 
     f73:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     f7a:	e8 58 f6 ff ff       	call   5d7 <printf>
      exit();
     f7f:	e8 a4 f4 ff ff       	call   428 <exit>
    }  
    currentThread->state=T_RUNNING;
     f84:	a1 80 61 00 00       	mov    0x6180,%eax
     f89:	c7 40 10 02 00 00 00 	movl   $0x2,0x10(%eax)
    
    if(currentThread->firstTime==1)
     f90:	a1 80 61 00 00       	mov    0x6180,%eax
     f95:	8b 40 14             	mov    0x14(%eax),%eax
     f98:	83 f8 01             	cmp    $0x1,%eax
     f9b:	75 10                	jne    fad <uthread_yield+0xfe>
    {
    currentThread->firstTime=0;
     f9d:	a1 80 61 00 00       	mov    0x6180,%eax
     fa2:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
    POP_AND_RET();
     fa9:	5d                   	pop    %ebp
     faa:	c3                   	ret    
     fab:	eb 01                	jmp    fae <uthread_yield+0xff>
    }
    else
    {
      POP_ALL_REGISTERS();
     fad:	61                   	popa   
    }
  }
}
     fae:	c9                   	leave  
     faf:	c3                   	ret    

00000fb0 <uthread_self>:

int
uthread_self(void)
{
     fb0:	55                   	push   %ebp
     fb1:	89 e5                	mov    %esp,%ebp
  return currentThread->tid;
     fb3:	a1 80 61 00 00       	mov    0x6180,%eax
     fb8:	8b 00                	mov    (%eax),%eax
     fba:	5d                   	pop    %ebp
     fbb:	c3                   	ret    

00000fbc <xchg>:
#include "fs.h"
#include "uthread.h"

static inline uint
xchg(volatile uint *addr, uint newval)
{
     fbc:	55                   	push   %ebp
     fbd:	89 e5                	mov    %esp,%ebp
     fbf:	53                   	push   %ebx
     fc0:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
               "+m" (*addr), "=a" (result) :
     fc3:	8b 55 08             	mov    0x8(%ebp),%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
     fc6:	8b 45 0c             	mov    0xc(%ebp),%eax
               "+m" (*addr), "=a" (result) :
     fc9:	8b 4d 08             	mov    0x8(%ebp),%ecx
xchg(volatile uint *addr, uint newval)
{
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
     fcc:	89 c3                	mov    %eax,%ebx
     fce:	89 d8                	mov    %ebx,%eax
     fd0:	f0 87 02             	lock xchg %eax,(%edx)
     fd3:	89 c3                	mov    %eax,%ebx
     fd5:	89 5d f8             	mov    %ebx,-0x8(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
     fd8:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
     fdb:	83 c4 10             	add    $0x10,%esp
     fde:	5b                   	pop    %ebx
     fdf:	5d                   	pop    %ebp
     fe0:	c3                   	ret    

00000fe1 <binary_semaphore_init>:
semaphore->taken=0;
}*/

void
binary_semaphore_init(struct binary_semaphore* semaphore, int value)
{
     fe1:	55                   	push   %ebp
     fe2:	89 e5                	mov    %esp,%ebp
     fe4:	83 ec 08             	sub    $0x8,%esp
  semaphore->init=0;
     fe7:	8b 45 08             	mov    0x8(%ebp),%eax
     fea:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
  
  if(value!=0)
     ff1:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     ff5:	74 0c                	je     1003 <binary_semaphore_init+0x22>
    semaphore->thread=-1;
     ff7:	8b 45 08             	mov    0x8(%ebp),%eax
     ffa:	c7 40 04 ff ff ff ff 	movl   $0xffffffff,0x4(%eax)
    1001:	eb 0b                	jmp    100e <binary_semaphore_init+0x2d>
  else 
    semaphore->thread = uthread_self();
    1003:	e8 a8 ff ff ff       	call   fb0 <uthread_self>
    1008:	8b 55 08             	mov    0x8(%ebp),%edx
    100b:	89 42 04             	mov    %eax,0x4(%edx)
  
  semaphore->locked = value;
    100e:	8b 55 0c             	mov    0xc(%ebp),%edx
    1011:	8b 45 08             	mov    0x8(%ebp),%eax
    1014:	89 10                	mov    %edx,(%eax)
 // semaphore->taken=0;
  semaphore->init=1;
    1016:	8b 45 08             	mov    0x8(%ebp),%eax
    1019:	c7 40 08 01 00 00 00 	movl   $0x1,0x8(%eax)
  
}
    1020:	c9                   	leave  
    1021:	c3                   	ret    

00001022 <binary_semaphore_down>:

void 
binary_semaphore_down(struct binary_semaphore* semaphore)
{
    1022:	55                   	push   %ebp
    1023:	89 e5                	mov    %esp,%ebp
    1025:	83 ec 28             	sub    $0x28,%esp
  //semaphore_acquire(semaphore);
  if(semaphore->init==0)
    1028:	8b 45 08             	mov    0x8(%ebp),%eax
    102b:	8b 40 08             	mov    0x8(%eax),%eax
    102e:	85 c0                	test   %eax,%eax
    1030:	75 20                	jne    1052 <binary_semaphore_down+0x30>
  {
   printf(1,"(down)semaphore uninitialized yet (thread %d)\n",semaphore->thread);
    1032:	8b 45 08             	mov    0x8(%ebp),%eax
    1035:	8b 40 04             	mov    0x4(%eax),%eax
    1038:	89 44 24 08          	mov    %eax,0x8(%esp)
    103c:	c7 44 24 04 bc 11 00 	movl   $0x11bc,0x4(%esp)
    1043:	00 
    1044:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    104b:	e8 87 f5 ff ff       	call   5d7 <printf>
    return;
    1050:	eb 3a                	jmp    108c <binary_semaphore_down+0x6a>
  }
  
  
  int i= uthread_self();
    1052:	e8 59 ff ff ff       	call   fb0 <uthread_self>
    1057:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(semaphore->thread!=i)
    105a:	8b 45 08             	mov    0x8(%ebp),%eax
    105d:	8b 40 04             	mov    0x4(%eax),%eax
    1060:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1063:	74 27                	je     108c <binary_semaphore_down+0x6a>
  {
    while(xchg(&semaphore->locked, 0) == 0) //means the semaphore is taken allready
    1065:	eb 05                	jmp    106c <binary_semaphore_down+0x4a>
    {
      uthread_yield();
    1067:	e8 43 fe ff ff       	call   eaf <uthread_yield>
  
  
  int i= uthread_self();
  if(semaphore->thread!=i)
  {
    while(xchg(&semaphore->locked, 0) == 0) //means the semaphore is taken allready
    106c:	8b 45 08             	mov    0x8(%ebp),%eax
    106f:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1076:	00 
    1077:	89 04 24             	mov    %eax,(%esp)
    107a:	e8 3d ff ff ff       	call   fbc <xchg>
    107f:	85 c0                	test   %eax,%eax
    1081:	74 e4                	je     1067 <binary_semaphore_down+0x45>
    {
      uthread_yield();
    }
    semaphore->thread = i;
    1083:	8b 45 08             	mov    0x8(%ebp),%eax
    1086:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1089:	89 50 04             	mov    %edx,0x4(%eax)
  }
  //semaphore_release(semaphore);
}
    108c:	c9                   	leave  
    108d:	c3                   	ret    

0000108e <binary_semaphore_up>:

void 
binary_semaphore_up(struct binary_semaphore* semaphore)
{
    108e:	55                   	push   %ebp
    108f:	89 e5                	mov    %esp,%ebp
    1091:	83 ec 28             	sub    $0x28,%esp
  //semaphore_acquire(semaphore);
    if(semaphore->init==0)
    1094:	8b 45 08             	mov    0x8(%ebp),%eax
    1097:	8b 40 08             	mov    0x8(%eax),%eax
    109a:	85 c0                	test   %eax,%eax
    109c:	75 20                	jne    10be <binary_semaphore_up+0x30>
    {
    printf(1,"(up)semaphore uninitialized yet (thread %d)\n",semaphore->thread);
    109e:	8b 45 08             	mov    0x8(%ebp),%eax
    10a1:	8b 40 04             	mov    0x4(%eax),%eax
    10a4:	89 44 24 08          	mov    %eax,0x8(%esp)
    10a8:	c7 44 24 04 ec 11 00 	movl   $0x11ec,0x4(%esp)
    10af:	00 
    10b0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    10b7:	e8 1b f5 ff ff       	call   5d7 <printf>
    return;
    10bc:	eb 2f                	jmp    10ed <binary_semaphore_up+0x5f>
    }
  
  int i= uthread_self();
    10be:	e8 ed fe ff ff       	call   fb0 <uthread_self>
    10c3:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if( semaphore->locked == 0 && semaphore->thread == i)
    10c6:	8b 45 08             	mov    0x8(%ebp),%eax
    10c9:	8b 00                	mov    (%eax),%eax
    10cb:	85 c0                	test   %eax,%eax
    10cd:	75 1e                	jne    10ed <binary_semaphore_up+0x5f>
    10cf:	8b 45 08             	mov    0x8(%ebp),%eax
    10d2:	8b 40 04             	mov    0x4(%eax),%eax
    10d5:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    10d8:	75 13                	jne    10ed <binary_semaphore_up+0x5f>
  {
      semaphore->thread = -1;
    10da:	8b 45 08             	mov    0x8(%ebp),%eax
    10dd:	c7 40 04 ff ff ff ff 	movl   $0xffffffff,0x4(%eax)
      semaphore->locked = 1;
    10e4:	8b 45 08             	mov    0x8(%ebp),%eax
    10e7:	c7 00 01 00 00 00    	movl   $0x1,(%eax)

  }
//semaphore_release(semaphore);
    10ed:	c9                   	leave  
    10ee:	c3                   	ret    
