
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
  32:	05 80 58 00 00       	add    $0x5880,%eax
  37:	0f b6 00             	movzbl (%eax),%eax
  3a:	3c 0a                	cmp    $0xa,%al
  3c:	75 04                	jne    42 <wc+0x42>
        l++;
  3e:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
      if(strchr(" \r\t\n\v", buf[i]))
  42:	8b 45 f4             	mov    -0xc(%ebp),%eax
  45:	05 80 58 00 00       	add    $0x5880,%eax
  4a:	0f b6 00             	movzbl (%eax),%eax
  4d:	0f be c0             	movsbl %al,%eax
  50:	89 44 24 04          	mov    %eax,0x4(%esp)
  54:	c7 04 24 00 0e 00 00 	movl   $0xe00,(%esp)
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
  92:	c7 44 24 04 80 58 00 	movl   $0x5880,0x4(%esp)
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
  b8:	c7 44 24 04 06 0e 00 	movl   $0xe06,0x4(%esp)
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
  ed:	c7 44 24 04 16 0e 00 	movl   $0xe16,0x4(%esp)
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
 112:	c7 44 24 04 23 0e 00 	movl   $0xe23,0x4(%esp)
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
 16c:	c7 44 24 04 24 0e 00 	movl   $0xe24,0x4(%esp)
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
 56e:	0f b6 90 10 12 00 00 	movzbl 0x1210(%eax),%edx
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
 6cf:	c7 45 f4 39 0e 00 00 	movl   $0xe39,-0xc(%ebp)
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
 79b:	a1 48 12 00 00       	mov    0x1248,%eax
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
 85c:	a3 48 12 00 00       	mov    %eax,0x1248
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
 8b4:	a1 48 12 00 00       	mov    0x1248,%eax
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
 8d0:	a1 48 12 00 00       	mov    0x1248,%eax
 8d5:	89 45 f0             	mov    %eax,-0x10(%ebp)
 8d8:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 8dc:	75 23                	jne    901 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 8de:	c7 45 f0 40 12 00 00 	movl   $0x1240,-0x10(%ebp)
 8e5:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8e8:	a3 48 12 00 00       	mov    %eax,0x1248
 8ed:	a1 48 12 00 00       	mov    0x1248,%eax
 8f2:	a3 40 12 00 00       	mov    %eax,0x1240
    base.s.size = 0;
 8f7:	c7 05 44 12 00 00 00 	movl   $0x0,0x1244
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
 954:	a3 48 12 00 00       	mov    %eax,0x1248
      return (void*)(p + 1);
 959:	8b 45 f4             	mov    -0xc(%ebp),%eax
 95c:	83 c0 08             	add    $0x8,%eax
 95f:	eb 38                	jmp    999 <malloc+0xde>
    }
    if(p == freep)
 961:	a1 48 12 00 00       	mov    0x1248,%eax
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

0000099c <getNextThread>:
} tTable;


int
getNextThread(int j)
{
 99c:	55                   	push   %ebp
 99d:	89 e5                	mov    %esp,%ebp
 99f:	83 ec 10             	sub    $0x10,%esp
  int i=j+1;
 9a2:	8b 45 08             	mov    0x8(%ebp),%eax
 9a5:	83 c0 01             	add    $0x1,%eax
 9a8:	89 45 fc             	mov    %eax,-0x4(%ebp)
  if(i==MAX_THREAD)
 9ab:	83 7d fc 40          	cmpl   $0x40,-0x4(%ebp)
 9af:	75 07                	jne    9b8 <getNextThread+0x1c>
    i=0;
 9b1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  uthread_p t=&tTable.table[i];
 9b8:	8b 45 fc             	mov    -0x4(%ebp),%eax
 9bb:	69 c0 18 01 00 00    	imul   $0x118,%eax,%eax
 9c1:	05 60 12 00 00       	add    $0x1260,%eax
 9c6:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(i!=j)
 9c9:	eb 3b                	jmp    a06 <getNextThread+0x6a>
  {
    if(t->state==T_RUNNABLE)
 9cb:	8b 45 f8             	mov    -0x8(%ebp),%eax
 9ce:	8b 40 10             	mov    0x10(%eax),%eax
 9d1:	83 f8 03             	cmp    $0x3,%eax
 9d4:	75 05                	jne    9db <getNextThread+0x3f>
      return i;
 9d6:	8b 45 fc             	mov    -0x4(%ebp),%eax
 9d9:	eb 38                	jmp    a13 <getNextThread+0x77>
    i++;
 9db:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    if(i==MAX_THREAD)
 9df:	83 7d fc 40          	cmpl   $0x40,-0x4(%ebp)
 9e3:	75 1a                	jne    9ff <getNextThread+0x63>
    {
       i=0;
 9e5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
       t=&tTable.table[i];
 9ec:	8b 45 fc             	mov    -0x4(%ebp),%eax
 9ef:	69 c0 18 01 00 00    	imul   $0x118,%eax,%eax
 9f5:	05 60 12 00 00       	add    $0x1260,%eax
 9fa:	89 45 f8             	mov    %eax,-0x8(%ebp)
 9fd:	eb 07                	jmp    a06 <getNextThread+0x6a>
    }
    else
      t++;
 9ff:	81 45 f8 18 01 00 00 	addl   $0x118,-0x8(%ebp)
{
  int i=j+1;
  if(i==MAX_THREAD)
    i=0;
  uthread_p t=&tTable.table[i];
  while(i!=j)
 a06:	8b 45 fc             	mov    -0x4(%ebp),%eax
 a09:	3b 45 08             	cmp    0x8(%ebp),%eax
 a0c:	75 bd                	jne    9cb <getNextThread+0x2f>
    }
    else
      t++;
    
  }
  return -1;
 a0e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
 a13:	c9                   	leave  
 a14:	c3                   	ret    

00000a15 <allocThread>:


static uthread_p
allocThread()
{
 a15:	55                   	push   %ebp
 a16:	89 e5                	mov    %esp,%ebp
 a18:	83 ec 28             	sub    $0x28,%esp
  int i,j;
  uthread_p t;
  
  for (t=tTable.table,i=0 ; t <= &tTable.table[MAX_THREAD]; t++,i++)// <= should be < ??
 a1b:	c7 45 ec 60 12 00 00 	movl   $0x1260,-0x14(%ebp)
 a22:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 a29:	eb 15                	jmp    a40 <allocThread+0x2b>
  {
    if(t->state==T_FREE)
 a2b:	8b 45 ec             	mov    -0x14(%ebp),%eax
 a2e:	8b 40 10             	mov    0x10(%eax),%eax
 a31:	85 c0                	test   %eax,%eax
 a33:	74 1e                	je     a53 <allocThread+0x3e>
allocThread()
{
  int i,j;
  uthread_p t;
  
  for (t=tTable.table,i=0 ; t <= &tTable.table[MAX_THREAD]; t++,i++)// <= should be < ??
 a35:	81 45 ec 18 01 00 00 	addl   $0x118,-0x14(%ebp)
 a3c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 a40:	81 7d ec 60 58 00 00 	cmpl   $0x5860,-0x14(%ebp)
 a47:	76 e2                	jbe    a2b <allocThread+0x16>
  {
    if(t->state==T_FREE)
      goto found;
  }
  return 0;
 a49:	b8 00 00 00 00       	mov    $0x0,%eax
 a4e:	e9 88 00 00 00       	jmp    adb <allocThread+0xc6>
  uthread_p t;
  
  for (t=tTable.table,i=0 ; t <= &tTable.table[MAX_THREAD]; t++,i++)// <= should be < ??
  {
    if(t->state==T_FREE)
      goto found;
 a53:	90                   	nop
  }
  return 0;
  
  found:
  
  t->tid=i;
 a54:	8b 45 ec             	mov    -0x14(%ebp),%eax
 a57:	8b 55 f4             	mov    -0xc(%ebp),%edx
 a5a:	89 10                	mov    %edx,(%eax)
  t->stack=(char*)malloc(STACK_SIZE);
 a5c:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
 a63:	e8 53 fe ff ff       	call   8bb <malloc>
 a68:	8b 55 ec             	mov    -0x14(%ebp),%edx
 a6b:	89 42 0c             	mov    %eax,0xc(%edx)
  t->esp=(int)t->stack;
 a6e:	8b 45 ec             	mov    -0x14(%ebp),%eax
 a71:	8b 40 0c             	mov    0xc(%eax),%eax
 a74:	89 c2                	mov    %eax,%edx
 a76:	8b 45 ec             	mov    -0x14(%ebp),%eax
 a79:	89 50 04             	mov    %edx,0x4(%eax)
  t->ebp=(int)t->stack;
 a7c:	8b 45 ec             	mov    -0x14(%ebp),%eax
 a7f:	8b 40 0c             	mov    0xc(%eax),%eax
 a82:	89 c2                	mov    %eax,%edx
 a84:	8b 45 ec             	mov    -0x14(%ebp),%eax
 a87:	89 50 08             	mov    %edx,0x8(%eax)
  t->firstTime=0;
 a8a:	8b 45 ec             	mov    -0x14(%ebp),%eax
 a8d:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
  for(j=0;j<64;j++)
 a94:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 a9b:	eb 15                	jmp    ab2 <allocThread+0x9d>
  {
    t->waiting[j]=-1;
 a9d:	8b 45 ec             	mov    -0x14(%ebp),%eax
 aa0:	8b 55 f0             	mov    -0x10(%ebp),%edx
 aa3:	83 c2 04             	add    $0x4,%edx
 aa6:	c7 44 90 08 ff ff ff 	movl   $0xffffffff,0x8(%eax,%edx,4)
 aad:	ff 
  t->tid=i;
  t->stack=(char*)malloc(STACK_SIZE);
  t->esp=(int)t->stack;
  t->ebp=(int)t->stack;
  t->firstTime=0;
  for(j=0;j<64;j++)
 aae:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 ab2:	83 7d f0 3f          	cmpl   $0x3f,-0x10(%ebp)
 ab6:	7e e5                	jle    a9d <allocThread+0x88>
  {
    t->waiting[j]=-1;
  }
  asm("movl %1,%%esp;" "push %2;" "movl %%esp,%0;" //pushes the uthread_exit func as return address
    : "=r" (t->esp) 
    : "r" (t->ebp) , "r"(uthread_exit)
 ab8:	8b 45 ec             	mov    -0x14(%ebp),%eax
 abb:	8b 40 08             	mov    0x8(%eax),%eax
  t->firstTime=0;
  for(j=0;j<64;j++)
  {
    t->waiting[j]=-1;
  }
  asm("movl %1,%%esp;" "push %2;" "movl %%esp,%0;" //pushes the uthread_exit func as return address
 abe:	ba da 0b 00 00       	mov    $0xbda,%edx
 ac3:	89 c4                	mov    %eax,%esp
 ac5:	52                   	push   %edx
 ac6:	89 e2                	mov    %esp,%edx
    : "=r" (t->esp) 
 ac8:	8b 45 ec             	mov    -0x14(%ebp),%eax
  t->firstTime=0;
  for(j=0;j<64;j++)
  {
    t->waiting[j]=-1;
  }
  asm("movl %1,%%esp;" "push %2;" "movl %%esp,%0;" //pushes the uthread_exit func as return address
 acb:	89 50 04             	mov    %edx,0x4(%eax)
    : "=r" (t->esp) 
    : "r" (t->ebp) , "r"(uthread_exit)
  );
  t->state=T_UNINIT;
 ace:	8b 45 ec             	mov    -0x14(%ebp),%eax
 ad1:	c7 40 10 01 00 00 00 	movl   $0x1,0x10(%eax)
  return t;
 ad8:	8b 45 ec             	mov    -0x14(%ebp),%eax
}
 adb:	c9                   	leave  
 adc:	c3                   	ret    

00000add <uthread_init>:

void 
uthread_init()
{  
 add:	55                   	push   %ebp
 ade:	89 e5                	mov    %esp,%ebp
 ae0:	83 ec 28             	sub    $0x28,%esp
  tTable.length=0;
 ae3:	c7 05 60 58 00 00 00 	movl   $0x0,0x5860
 aea:	00 00 00 
  tTable.current=0;
 aed:	c7 05 64 58 00 00 00 	movl   $0x0,0x5864
 af4:	00 00 00 
  uthread_p mainT = allocThread(); //needed to allocate the main thread !!!!!!
 af7:	e8 19 ff ff ff       	call   a15 <allocThread>
 afc:	89 45 f4             	mov    %eax,-0xc(%ebp)
  asm("movl %%ebp,%0;" "movl %%esp,%1;" //get current thread ebp and esp
 aff:	89 e9                	mov    %ebp,%ecx
 b01:	89 e2                	mov    %esp,%edx
    : "=r" (mainT->ebp) ,"=r"(mainT->esp)    
 b03:	8b 45 f4             	mov    -0xc(%ebp),%eax
uthread_init()
{  
  tTable.length=0;
  tTable.current=0;
  uthread_p mainT = allocThread(); //needed to allocate the main thread !!!!!!
  asm("movl %%ebp,%0;" "movl %%esp,%1;" //get current thread ebp and esp
 b06:	89 48 08             	mov    %ecx,0x8(%eax)
    : "=r" (mainT->ebp) ,"=r"(mainT->esp)    
 b09:	8b 45 f4             	mov    -0xc(%ebp),%eax
uthread_init()
{  
  tTable.length=0;
  tTable.current=0;
  uthread_p mainT = allocThread(); //needed to allocate the main thread !!!!!!
  asm("movl %%ebp,%0;" "movl %%esp,%1;" //get current thread ebp and esp
 b0c:	89 50 04             	mov    %edx,0x4(%eax)
    : "=r" (mainT->ebp) ,"=r"(mainT->esp)    
  );
  /*moves stack to mainT's stack
  /stacks grow backwards so we start from esp and finsh at ebp*/
  memmove(mainT->stack , (void*)mainT->esp , mainT->ebp - mainT->esp);
 b0f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b12:	8b 50 08             	mov    0x8(%eax),%edx
 b15:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b18:	8b 40 04             	mov    0x4(%eax),%eax
 b1b:	89 d1                	mov    %edx,%ecx
 b1d:	29 c1                	sub    %eax,%ecx
 b1f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b22:	8b 40 04             	mov    0x4(%eax),%eax
 b25:	89 c2                	mov    %eax,%edx
 b27:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b2a:	8b 40 0c             	mov    0xc(%eax),%eax
 b2d:	89 4c 24 08          	mov    %ecx,0x8(%esp)
 b31:	89 54 24 04          	mov    %edx,0x4(%esp)
 b35:	89 04 24             	mov    %eax,(%esp)
 b38:	e8 a5 f8 ff ff       	call   3e2 <memmove>
  mainT->state = T_RUNNABLE;
 b3d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b40:	c7 40 10 03 00 00 00 	movl   $0x3,0x10(%eax)
  currentThread=mainT;
 b47:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b4a:	a3 80 5a 00 00       	mov    %eax,0x5a80
  if(signal(SIGALRM,uthread_yield)<0)
 b4f:	c7 44 24 04 4a 0d 00 	movl   $0xd4a,0x4(%esp)
 b56:	00 
 b57:	c7 04 24 0e 00 00 00 	movl   $0xe,(%esp)
 b5e:	e8 85 f9 ff ff       	call   4e8 <signal>
 b63:	85 c0                	test   %eax,%eax
 b65:	79 19                	jns    b80 <uthread_init+0xa3>
  {
    printf(1,"Cant register the alarm signal");
 b67:	c7 44 24 04 40 0e 00 	movl   $0xe40,0x4(%esp)
 b6e:	00 
 b6f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 b76:	e8 5c fa ff ff       	call   5d7 <printf>
    exit();
 b7b:	e8 a8 f8 ff ff       	call   428 <exit>
  }
  if(alarm(THREAD_QUANTA)<0)
 b80:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
 b87:	e8 6c f9 ff ff       	call   4f8 <alarm>
 b8c:	85 c0                	test   %eax,%eax
 b8e:	79 19                	jns    ba9 <uthread_init+0xcc>
  {
    printf(1,"Cant activate alarm system call");
 b90:	c7 44 24 04 60 0e 00 	movl   $0xe60,0x4(%esp)
 b97:	00 
 b98:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 b9f:	e8 33 fa ff ff       	call   5d7 <printf>
    exit();
 ba4:	e8 7f f8 ff ff       	call   428 <exit>
  }
  
}
 ba9:	c9                   	leave  
 baa:	c3                   	ret    

00000bab <uthread_create>:

int  
uthread_create(void (*start_func)(void *), void* arg)
{
 bab:	55                   	push   %ebp
 bac:	89 e5                	mov    %esp,%ebp
 bae:	83 ec 18             	sub    $0x18,%esp
  uthread_p t = allocThread();
 bb1:	e8 5f fe ff ff       	call   a15 <allocThread>
 bb6:	89 45 f4             	mov    %eax,-0xc(%ebp)
  
  asm("push %1;"  //stores the arguments to be used
 bb9:	8b 45 0c             	mov    0xc(%ebp),%eax
 bbc:	8b 55 08             	mov    0x8(%ebp),%edx
 bbf:	50                   	push   %eax
 bc0:	52                   	push   %edx
 bc1:	89 e2                	mov    %esp,%edx
      "push %2;"  //stores the start_func location
      "movl %%esp,%0;"
      : "=r" (t->esp)
 bc3:	8b 45 f4             	mov    -0xc(%ebp),%eax
int  
uthread_create(void (*start_func)(void *), void* arg)
{
  uthread_p t = allocThread();
  
  asm("push %1;"  //stores the arguments to be used
 bc6:	89 50 04             	mov    %edx,0x4(%eax)
      "push %2;"  //stores the start_func location
      "movl %%esp,%0;"
      : "=r" (t->esp)
      : "r" (arg) , "r"(start_func)
  );
  t->state= T_RUNNABLE;
 bc9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 bcc:	c7 40 10 03 00 00 00 	movl   $0x3,0x10(%eax)
  
  return t->tid;
 bd3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 bd6:	8b 00                	mov    (%eax),%eax
}
 bd8:	c9                   	leave  
 bd9:	c3                   	ret    

00000bda <uthread_exit>:

void 
uthread_exit()
{
 bda:	55                   	push   %ebp
 bdb:	89 e5                	mov    %esp,%ebp
 bdd:	83 ec 28             	sub    $0x28,%esp
  uthread_p newt;
  int old=currentThread->tid;
 be0:	a1 80 5a 00 00       	mov    0x5a80,%eax
 be5:	8b 00                	mov    (%eax),%eax
 be7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  
  int i=0;
 bea:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  while(currentThread->waiting[i]!=-1)
 bf1:	eb 25                	jmp    c18 <uthread_exit+0x3e>
  {
    (&tTable.table[currentThread->waiting[i]])->state=T_RUNNABLE;
 bf3:	a1 80 5a 00 00       	mov    0x5a80,%eax
 bf8:	8b 55 f4             	mov    -0xc(%ebp),%edx
 bfb:	83 c2 04             	add    $0x4,%edx
 bfe:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
 c02:	69 c0 18 01 00 00    	imul   $0x118,%eax,%eax
 c08:	05 60 12 00 00       	add    $0x1260,%eax
 c0d:	c7 40 10 03 00 00 00 	movl   $0x3,0x10(%eax)
    i++;
 c14:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
{
  uthread_p newt;
  int old=currentThread->tid;
  
  int i=0;
  while(currentThread->waiting[i]!=-1)
 c18:	a1 80 5a 00 00       	mov    0x5a80,%eax
 c1d:	8b 55 f4             	mov    -0xc(%ebp),%edx
 c20:	83 c2 04             	add    $0x4,%edx
 c23:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
 c27:	83 f8 ff             	cmp    $0xffffffff,%eax
 c2a:	75 c7                	jne    bf3 <uthread_exit+0x19>
  {
    (&tTable.table[currentThread->waiting[i]])->state=T_RUNNABLE;
    i++;
  }
  currentThread->tid=-1;
 c2c:	a1 80 5a 00 00       	mov    0x5a80,%eax
 c31:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)
  currentThread->esp=-1;
 c37:	a1 80 5a 00 00       	mov    0x5a80,%eax
 c3c:	c7 40 04 ff ff ff ff 	movl   $0xffffffff,0x4(%eax)
  currentThread->ebp=-1;
 c43:	a1 80 5a 00 00       	mov    0x5a80,%eax
 c48:	c7 40 08 ff ff ff ff 	movl   $0xffffffff,0x8(%eax)
  free(currentThread->stack);
 c4f:	a1 80 5a 00 00       	mov    0x5a80,%eax
 c54:	8b 40 0c             	mov    0xc(%eax),%eax
 c57:	89 04 24             	mov    %eax,(%esp)
 c5a:	e8 2d fb ff ff       	call   78c <free>
  currentThread->state=T_FREE;
 c5f:	a1 80 5a 00 00       	mov    0x5a80,%eax
 c64:	c7 40 10 00 00 00 00 	movl   $0x0,0x10(%eax)
  currentThread->firstTime=0;
 c6b:	a1 80 5a 00 00       	mov    0x5a80,%eax
 c70:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
  int new=getNextThread(old);
 c77:	8b 45 f0             	mov    -0x10(%ebp),%eax
 c7a:	89 04 24             	mov    %eax,(%esp)
 c7d:	e8 1a fd ff ff       	call   99c <getNextThread>
 c82:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if(new>=0)
 c85:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 c89:	78 36                	js     cc1 <uthread_exit+0xe7>
          {
             newt=&tTable.table[new];
 c8b:	8b 45 ec             	mov    -0x14(%ebp),%eax
 c8e:	69 c0 18 01 00 00    	imul   $0x118,%eax,%eax
 c94:	05 60 12 00 00       	add    $0x1260,%eax
 c99:	89 45 e8             	mov    %eax,-0x18(%ebp)
             newt->state=T_RUNNING;
 c9c:	8b 45 e8             	mov    -0x18(%ebp),%eax
 c9f:	c7 40 10 02 00 00 00 	movl   $0x2,0x10(%eax)
             LOAD_ESP(newt->esp);
 ca6:	8b 45 e8             	mov    -0x18(%ebp),%eax
 ca9:	8b 40 04             	mov    0x4(%eax),%eax
 cac:	89 c4                	mov    %eax,%esp
             LOAD_EBP(newt->ebp);
 cae:	8b 45 e8             	mov    -0x18(%ebp),%eax
 cb1:	8b 40 08             	mov    0x8(%eax),%eax
 cb4:	89 c5                	mov    %eax,%ebp
             asm("popa");
 cb6:	61                   	popa   
             currentThread=newt;
 cb7:	8b 45 e8             	mov    -0x18(%ebp),%eax
 cba:	a3 80 5a 00 00       	mov    %eax,0x5a80
        {/////what if some thread state is sleeping?
             
             exit();
        }
     
}
 cbf:	c9                   	leave  
 cc0:	c3                   	ret    
             currentThread=newt;
          }
        else
        {/////what if some thread state is sleeping?
             
             exit();
 cc1:	e8 62 f7 ff ff       	call   428 <exit>

00000cc6 <uthred_join>:
}


int
uthred_join(int tid)
{
 cc6:	55                   	push   %ebp
 cc7:	89 e5                	mov    %esp,%ebp
 cc9:	83 ec 18             	sub    $0x18,%esp
  if((&tTable.table[tid])->state==T_FREE)
 ccc:	8b 45 08             	mov    0x8(%ebp),%eax
 ccf:	69 c0 18 01 00 00    	imul   $0x118,%eax,%eax
 cd5:	05 60 12 00 00       	add    $0x1260,%eax
 cda:	8b 40 10             	mov    0x10(%eax),%eax
 cdd:	85 c0                	test   %eax,%eax
 cdf:	75 07                	jne    ce8 <uthred_join+0x22>
    return -1;
 ce1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 ce6:	eb 60                	jmp    d48 <uthred_join+0x82>
  else
  {
      int i=0;
 ce8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
      while((&tTable.table[tid])->waiting[i]!=-1)
 cef:	eb 04                	jmp    cf5 <uthred_join+0x2f>
        i++;
 cf1:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  if((&tTable.table[tid])->state==T_FREE)
    return -1;
  else
  {
      int i=0;
      while((&tTable.table[tid])->waiting[i]!=-1)
 cf5:	8b 45 08             	mov    0x8(%ebp),%eax
 cf8:	69 c0 18 01 00 00    	imul   $0x118,%eax,%eax
 cfe:	05 60 12 00 00       	add    $0x1260,%eax
 d03:	8b 55 f4             	mov    -0xc(%ebp),%edx
 d06:	83 c2 04             	add    $0x4,%edx
 d09:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
 d0d:	83 f8 ff             	cmp    $0xffffffff,%eax
 d10:	75 df                	jne    cf1 <uthred_join+0x2b>
        i++;
      (&tTable.table[tid])->waiting[i]=currentThread->tid;
 d12:	8b 45 08             	mov    0x8(%ebp),%eax
 d15:	69 c0 18 01 00 00    	imul   $0x118,%eax,%eax
 d1b:	8d 90 60 12 00 00    	lea    0x1260(%eax),%edx
 d21:	a1 80 5a 00 00       	mov    0x5a80,%eax
 d26:	8b 00                	mov    (%eax),%eax
 d28:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 d2b:	83 c1 04             	add    $0x4,%ecx
 d2e:	89 44 8a 08          	mov    %eax,0x8(%edx,%ecx,4)
      currentThread->state=T_SLEEPING;
 d32:	a1 80 5a 00 00       	mov    0x5a80,%eax
 d37:	c7 40 10 04 00 00 00 	movl   $0x4,0x10(%eax)
      uthread_yield();
 d3e:	e8 07 00 00 00       	call   d4a <uthread_yield>
      return 1;
 d43:	b8 01 00 00 00       	mov    $0x1,%eax
  }
}
 d48:	c9                   	leave  
 d49:	c3                   	ret    

00000d4a <uthread_yield>:

void 
uthread_yield()
{
 d4a:	55                   	push   %ebp
 d4b:	89 e5                	mov    %esp,%ebp
 d4d:	83 ec 28             	sub    $0x28,%esp
  uthread_p newt;
  int old=currentThread->tid;
 d50:	a1 80 5a 00 00       	mov    0x5a80,%eax
 d55:	8b 00                	mov    (%eax),%eax
 d57:	89 45 f4             	mov    %eax,-0xc(%ebp)
  int new=getNextThread(old);
 d5a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 d5d:	89 04 24             	mov    %eax,(%esp)
 d60:	e8 37 fc ff ff       	call   99c <getNextThread>
 d65:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(new<0)
 d68:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 d6c:	79 19                	jns    d87 <uthread_yield+0x3d>
  {
     printf(1,"(fun uthread_yield)Cant find runnable thread");
 d6e:	c7 44 24 04 80 0e 00 	movl   $0xe80,0x4(%esp)
 d75:	00 
 d76:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 d7d:	e8 55 f8 ff ff       	call   5d7 <printf>
    exit();
 d82:	e8 a1 f6 ff ff       	call   428 <exit>
  }
newt=&tTable.table[new];
 d87:	8b 45 f0             	mov    -0x10(%ebp),%eax
 d8a:	69 c0 18 01 00 00    	imul   $0x118,%eax,%eax
 d90:	05 60 12 00 00       	add    $0x1260,%eax
 d95:	89 45 ec             	mov    %eax,-0x14(%ebp)
  
    asm("pusha");
 d98:	60                   	pusha  
    STORE_ESP(currentThread->esp);
 d99:	a1 80 5a 00 00       	mov    0x5a80,%eax
 d9e:	89 e2                	mov    %esp,%edx
 da0:	89 50 04             	mov    %edx,0x4(%eax)
    if(currentThread->state==T_RUNNING)
 da3:	a1 80 5a 00 00       	mov    0x5a80,%eax
 da8:	8b 40 10             	mov    0x10(%eax),%eax
 dab:	83 f8 02             	cmp    $0x2,%eax
 dae:	75 0c                	jne    dbc <uthread_yield+0x72>
      currentThread->state=T_RUNNABLE;
 db0:	a1 80 5a 00 00       	mov    0x5a80,%eax
 db5:	c7 40 10 03 00 00 00 	movl   $0x3,0x10(%eax)
    LOAD_ESP(newt->esp);
 dbc:	8b 45 ec             	mov    -0x14(%ebp),%eax
 dbf:	8b 40 04             	mov    0x4(%eax),%eax
 dc2:	89 c4                	mov    %eax,%esp
    
  
    newt->state=T_RUNNING;
 dc4:	8b 45 ec             	mov    -0x14(%ebp),%eax
 dc7:	c7 40 10 02 00 00 00 	movl   $0x2,0x10(%eax)

    asm("popa");
 dce:	61                   	popa   
    if(currentThread->firstTime==0)
 dcf:	a1 80 5a 00 00       	mov    0x5a80,%eax
 dd4:	8b 40 14             	mov    0x14(%eax),%eax
 dd7:	85 c0                	test   %eax,%eax
 dd9:	75 0d                	jne    de8 <uthread_yield+0x9e>
    {
       asm("ret");////only firest time
 ddb:	c3                   	ret    
       currentThread->firstTime=1;
 ddc:	a1 80 5a 00 00       	mov    0x5a80,%eax
 de1:	c7 40 14 01 00 00 00 	movl   $0x1,0x14(%eax)
    }
   
currentThread=newt;
 de8:	8b 45 ec             	mov    -0x14(%ebp),%eax
 deb:	a3 80 5a 00 00       	mov    %eax,0x5a80

}
 df0:	c9                   	leave  
 df1:	c3                   	ret    

00000df2 <uthred_self>:

int  uthred_self(void)
{
 df2:	55                   	push   %ebp
 df3:	89 e5                	mov    %esp,%ebp
  return currentThread->tid;
 df5:	a1 80 5a 00 00       	mov    0x5a80,%eax
 dfa:	8b 00                	mov    (%eax),%eax
}
 dfc:	5d                   	pop    %ebp
 dfd:	c3                   	ret    
