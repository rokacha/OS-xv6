
_cat:     file format elf32-i386


Disassembly of section .text:

00000000 <cat>:

char buf[512];

void
cat(int fd)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 ec 28             	sub    $0x28,%esp
  int n;

  while((n = read(fd, buf, sizeof(buf))) > 0)
   6:	eb 1b                	jmp    23 <cat+0x23>
    write(1, buf, n);
   8:	8b 45 f4             	mov    -0xc(%ebp),%eax
   b:	89 44 24 08          	mov    %eax,0x8(%esp)
   f:	c7 44 24 04 a0 57 00 	movl   $0x57a0,0x4(%esp)
  16:	00 
  17:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  1e:	e8 71 03 00 00       	call   394 <write>
void
cat(int fd)
{
  int n;

  while((n = read(fd, buf, sizeof(buf))) > 0)
  23:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
  2a:	00 
  2b:	c7 44 24 04 a0 57 00 	movl   $0x57a0,0x4(%esp)
  32:	00 
  33:	8b 45 08             	mov    0x8(%ebp),%eax
  36:	89 04 24             	mov    %eax,(%esp)
  39:	e8 4e 03 00 00       	call   38c <read>
  3e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  41:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  45:	7f c1                	jg     8 <cat+0x8>
    write(1, buf, n);
  if(n < 0){
  47:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  4b:	79 19                	jns    66 <cat+0x66>
    printf(1, "cat: read error\n");
  4d:	c7 44 24 04 4c 0d 00 	movl   $0xd4c,0x4(%esp)
  54:	00 
  55:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  5c:	e8 c2 04 00 00       	call   523 <printf>
    exit();
  61:	e8 0e 03 00 00       	call   374 <exit>
  }
}
  66:	c9                   	leave  
  67:	c3                   	ret    

00000068 <main>:

int
main(int argc, char *argv[])
{
  68:	55                   	push   %ebp
  69:	89 e5                	mov    %esp,%ebp
  6b:	83 e4 f0             	and    $0xfffffff0,%esp
  6e:	83 ec 20             	sub    $0x20,%esp
  int fd, i;

  if(argc <= 1){
  71:	83 7d 08 01          	cmpl   $0x1,0x8(%ebp)
  75:	7f 11                	jg     88 <main+0x20>
    cat(0);
  77:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  7e:	e8 7d ff ff ff       	call   0 <cat>
    exit();
  83:	e8 ec 02 00 00       	call   374 <exit>
  }

  for(i = 1; i < argc; i++){
  88:	c7 44 24 1c 01 00 00 	movl   $0x1,0x1c(%esp)
  8f:	00 
  90:	eb 6d                	jmp    ff <main+0x97>
    if((fd = open(argv[i], 0)) < 0){
  92:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  96:	c1 e0 02             	shl    $0x2,%eax
  99:	03 45 0c             	add    0xc(%ebp),%eax
  9c:	8b 00                	mov    (%eax),%eax
  9e:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  a5:	00 
  a6:	89 04 24             	mov    %eax,(%esp)
  a9:	e8 06 03 00 00       	call   3b4 <open>
  ae:	89 44 24 18          	mov    %eax,0x18(%esp)
  b2:	83 7c 24 18 00       	cmpl   $0x0,0x18(%esp)
  b7:	79 29                	jns    e2 <main+0x7a>
      printf(1, "cat: cannot open %s\n", argv[i]);
  b9:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  bd:	c1 e0 02             	shl    $0x2,%eax
  c0:	03 45 0c             	add    0xc(%ebp),%eax
  c3:	8b 00                	mov    (%eax),%eax
  c5:	89 44 24 08          	mov    %eax,0x8(%esp)
  c9:	c7 44 24 04 5d 0d 00 	movl   $0xd5d,0x4(%esp)
  d0:	00 
  d1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  d8:	e8 46 04 00 00       	call   523 <printf>
      exit();
  dd:	e8 92 02 00 00       	call   374 <exit>
    }
    cat(fd);
  e2:	8b 44 24 18          	mov    0x18(%esp),%eax
  e6:	89 04 24             	mov    %eax,(%esp)
  e9:	e8 12 ff ff ff       	call   0 <cat>
    close(fd);
  ee:	8b 44 24 18          	mov    0x18(%esp),%eax
  f2:	89 04 24             	mov    %eax,(%esp)
  f5:	e8 a2 02 00 00       	call   39c <close>
  if(argc <= 1){
    cat(0);
    exit();
  }

  for(i = 1; i < argc; i++){
  fa:	83 44 24 1c 01       	addl   $0x1,0x1c(%esp)
  ff:	8b 44 24 1c          	mov    0x1c(%esp),%eax
 103:	3b 45 08             	cmp    0x8(%ebp),%eax
 106:	7c 8a                	jl     92 <main+0x2a>
      exit();
    }
    cat(fd);
    close(fd);
  }
  exit();
 108:	e8 67 02 00 00       	call   374 <exit>
 10d:	90                   	nop
 10e:	90                   	nop
 10f:	90                   	nop

00000110 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 110:	55                   	push   %ebp
 111:	89 e5                	mov    %esp,%ebp
 113:	57                   	push   %edi
 114:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
 115:	8b 4d 08             	mov    0x8(%ebp),%ecx
 118:	8b 55 10             	mov    0x10(%ebp),%edx
 11b:	8b 45 0c             	mov    0xc(%ebp),%eax
 11e:	89 cb                	mov    %ecx,%ebx
 120:	89 df                	mov    %ebx,%edi
 122:	89 d1                	mov    %edx,%ecx
 124:	fc                   	cld    
 125:	f3 aa                	rep stos %al,%es:(%edi)
 127:	89 ca                	mov    %ecx,%edx
 129:	89 fb                	mov    %edi,%ebx
 12b:	89 5d 08             	mov    %ebx,0x8(%ebp)
 12e:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 131:	5b                   	pop    %ebx
 132:	5f                   	pop    %edi
 133:	5d                   	pop    %ebp
 134:	c3                   	ret    

00000135 <strcpy>:
#include "x86.h"


char*
strcpy(char *s, char *t)
{
 135:	55                   	push   %ebp
 136:	89 e5                	mov    %esp,%ebp
 138:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
 13b:	8b 45 08             	mov    0x8(%ebp),%eax
 13e:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 141:	90                   	nop
 142:	8b 45 0c             	mov    0xc(%ebp),%eax
 145:	0f b6 10             	movzbl (%eax),%edx
 148:	8b 45 08             	mov    0x8(%ebp),%eax
 14b:	88 10                	mov    %dl,(%eax)
 14d:	8b 45 08             	mov    0x8(%ebp),%eax
 150:	0f b6 00             	movzbl (%eax),%eax
 153:	84 c0                	test   %al,%al
 155:	0f 95 c0             	setne  %al
 158:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 15c:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
 160:	84 c0                	test   %al,%al
 162:	75 de                	jne    142 <strcpy+0xd>
    ;
  return os;
 164:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 167:	c9                   	leave  
 168:	c3                   	ret    

00000169 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 169:	55                   	push   %ebp
 16a:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 16c:	eb 08                	jmp    176 <strcmp+0xd>
    p++, q++;
 16e:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 172:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 176:	8b 45 08             	mov    0x8(%ebp),%eax
 179:	0f b6 00             	movzbl (%eax),%eax
 17c:	84 c0                	test   %al,%al
 17e:	74 10                	je     190 <strcmp+0x27>
 180:	8b 45 08             	mov    0x8(%ebp),%eax
 183:	0f b6 10             	movzbl (%eax),%edx
 186:	8b 45 0c             	mov    0xc(%ebp),%eax
 189:	0f b6 00             	movzbl (%eax),%eax
 18c:	38 c2                	cmp    %al,%dl
 18e:	74 de                	je     16e <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 190:	8b 45 08             	mov    0x8(%ebp),%eax
 193:	0f b6 00             	movzbl (%eax),%eax
 196:	0f b6 d0             	movzbl %al,%edx
 199:	8b 45 0c             	mov    0xc(%ebp),%eax
 19c:	0f b6 00             	movzbl (%eax),%eax
 19f:	0f b6 c0             	movzbl %al,%eax
 1a2:	89 d1                	mov    %edx,%ecx
 1a4:	29 c1                	sub    %eax,%ecx
 1a6:	89 c8                	mov    %ecx,%eax
}
 1a8:	5d                   	pop    %ebp
 1a9:	c3                   	ret    

000001aa <strlen>:

uint
strlen(char *s)
{
 1aa:	55                   	push   %ebp
 1ab:	89 e5                	mov    %esp,%ebp
 1ad:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 1b0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 1b7:	eb 04                	jmp    1bd <strlen+0x13>
 1b9:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 1bd:	8b 45 fc             	mov    -0x4(%ebp),%eax
 1c0:	03 45 08             	add    0x8(%ebp),%eax
 1c3:	0f b6 00             	movzbl (%eax),%eax
 1c6:	84 c0                	test   %al,%al
 1c8:	75 ef                	jne    1b9 <strlen+0xf>
    ;
  return n;
 1ca:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 1cd:	c9                   	leave  
 1ce:	c3                   	ret    

000001cf <memset>:

void*
memset(void *dst, int c, uint n)
{
 1cf:	55                   	push   %ebp
 1d0:	89 e5                	mov    %esp,%ebp
 1d2:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
 1d5:	8b 45 10             	mov    0x10(%ebp),%eax
 1d8:	89 44 24 08          	mov    %eax,0x8(%esp)
 1dc:	8b 45 0c             	mov    0xc(%ebp),%eax
 1df:	89 44 24 04          	mov    %eax,0x4(%esp)
 1e3:	8b 45 08             	mov    0x8(%ebp),%eax
 1e6:	89 04 24             	mov    %eax,(%esp)
 1e9:	e8 22 ff ff ff       	call   110 <stosb>
  return dst;
 1ee:	8b 45 08             	mov    0x8(%ebp),%eax
}
 1f1:	c9                   	leave  
 1f2:	c3                   	ret    

000001f3 <strchr>:

char*
strchr(const char *s, char c)
{
 1f3:	55                   	push   %ebp
 1f4:	89 e5                	mov    %esp,%ebp
 1f6:	83 ec 04             	sub    $0x4,%esp
 1f9:	8b 45 0c             	mov    0xc(%ebp),%eax
 1fc:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 1ff:	eb 14                	jmp    215 <strchr+0x22>
    if(*s == c)
 201:	8b 45 08             	mov    0x8(%ebp),%eax
 204:	0f b6 00             	movzbl (%eax),%eax
 207:	3a 45 fc             	cmp    -0x4(%ebp),%al
 20a:	75 05                	jne    211 <strchr+0x1e>
      return (char*)s;
 20c:	8b 45 08             	mov    0x8(%ebp),%eax
 20f:	eb 13                	jmp    224 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 211:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 215:	8b 45 08             	mov    0x8(%ebp),%eax
 218:	0f b6 00             	movzbl (%eax),%eax
 21b:	84 c0                	test   %al,%al
 21d:	75 e2                	jne    201 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 21f:	b8 00 00 00 00       	mov    $0x0,%eax
}
 224:	c9                   	leave  
 225:	c3                   	ret    

00000226 <gets>:

char*
gets(char *buf, int max)
{
 226:	55                   	push   %ebp
 227:	89 e5                	mov    %esp,%ebp
 229:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 22c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 233:	eb 44                	jmp    279 <gets+0x53>
    cc = read(0, &c, 1);
 235:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 23c:	00 
 23d:	8d 45 ef             	lea    -0x11(%ebp),%eax
 240:	89 44 24 04          	mov    %eax,0x4(%esp)
 244:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 24b:	e8 3c 01 00 00       	call   38c <read>
 250:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 253:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 257:	7e 2d                	jle    286 <gets+0x60>
      break;
    buf[i++] = c;
 259:	8b 45 f4             	mov    -0xc(%ebp),%eax
 25c:	03 45 08             	add    0x8(%ebp),%eax
 25f:	0f b6 55 ef          	movzbl -0x11(%ebp),%edx
 263:	88 10                	mov    %dl,(%eax)
 265:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    if(c == '\n' || c == '\r')
 269:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 26d:	3c 0a                	cmp    $0xa,%al
 26f:	74 16                	je     287 <gets+0x61>
 271:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 275:	3c 0d                	cmp    $0xd,%al
 277:	74 0e                	je     287 <gets+0x61>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 279:	8b 45 f4             	mov    -0xc(%ebp),%eax
 27c:	83 c0 01             	add    $0x1,%eax
 27f:	3b 45 0c             	cmp    0xc(%ebp),%eax
 282:	7c b1                	jl     235 <gets+0xf>
 284:	eb 01                	jmp    287 <gets+0x61>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
 286:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 287:	8b 45 f4             	mov    -0xc(%ebp),%eax
 28a:	03 45 08             	add    0x8(%ebp),%eax
 28d:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 290:	8b 45 08             	mov    0x8(%ebp),%eax
}
 293:	c9                   	leave  
 294:	c3                   	ret    

00000295 <stat>:

int
stat(char *n, struct stat *st)
{
 295:	55                   	push   %ebp
 296:	89 e5                	mov    %esp,%ebp
 298:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 29b:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 2a2:	00 
 2a3:	8b 45 08             	mov    0x8(%ebp),%eax
 2a6:	89 04 24             	mov    %eax,(%esp)
 2a9:	e8 06 01 00 00       	call   3b4 <open>
 2ae:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 2b1:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 2b5:	79 07                	jns    2be <stat+0x29>
    return -1;
 2b7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 2bc:	eb 23                	jmp    2e1 <stat+0x4c>
  r = fstat(fd, st);
 2be:	8b 45 0c             	mov    0xc(%ebp),%eax
 2c1:	89 44 24 04          	mov    %eax,0x4(%esp)
 2c5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 2c8:	89 04 24             	mov    %eax,(%esp)
 2cb:	e8 fc 00 00 00       	call   3cc <fstat>
 2d0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 2d3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 2d6:	89 04 24             	mov    %eax,(%esp)
 2d9:	e8 be 00 00 00       	call   39c <close>
  return r;
 2de:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 2e1:	c9                   	leave  
 2e2:	c3                   	ret    

000002e3 <atoi>:

int
atoi(const char *s)
{
 2e3:	55                   	push   %ebp
 2e4:	89 e5                	mov    %esp,%ebp
 2e6:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 2e9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 2f0:	eb 23                	jmp    315 <atoi+0x32>
    n = n*10 + *s++ - '0';
 2f2:	8b 55 fc             	mov    -0x4(%ebp),%edx
 2f5:	89 d0                	mov    %edx,%eax
 2f7:	c1 e0 02             	shl    $0x2,%eax
 2fa:	01 d0                	add    %edx,%eax
 2fc:	01 c0                	add    %eax,%eax
 2fe:	89 c2                	mov    %eax,%edx
 300:	8b 45 08             	mov    0x8(%ebp),%eax
 303:	0f b6 00             	movzbl (%eax),%eax
 306:	0f be c0             	movsbl %al,%eax
 309:	01 d0                	add    %edx,%eax
 30b:	83 e8 30             	sub    $0x30,%eax
 30e:	89 45 fc             	mov    %eax,-0x4(%ebp)
 311:	83 45 08 01          	addl   $0x1,0x8(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 315:	8b 45 08             	mov    0x8(%ebp),%eax
 318:	0f b6 00             	movzbl (%eax),%eax
 31b:	3c 2f                	cmp    $0x2f,%al
 31d:	7e 0a                	jle    329 <atoi+0x46>
 31f:	8b 45 08             	mov    0x8(%ebp),%eax
 322:	0f b6 00             	movzbl (%eax),%eax
 325:	3c 39                	cmp    $0x39,%al
 327:	7e c9                	jle    2f2 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 329:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 32c:	c9                   	leave  
 32d:	c3                   	ret    

0000032e <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 32e:	55                   	push   %ebp
 32f:	89 e5                	mov    %esp,%ebp
 331:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 334:	8b 45 08             	mov    0x8(%ebp),%eax
 337:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 33a:	8b 45 0c             	mov    0xc(%ebp),%eax
 33d:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 340:	eb 13                	jmp    355 <memmove+0x27>
    *dst++ = *src++;
 342:	8b 45 f8             	mov    -0x8(%ebp),%eax
 345:	0f b6 10             	movzbl (%eax),%edx
 348:	8b 45 fc             	mov    -0x4(%ebp),%eax
 34b:	88 10                	mov    %dl,(%eax)
 34d:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 351:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 355:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
 359:	0f 9f c0             	setg   %al
 35c:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
 360:	84 c0                	test   %al,%al
 362:	75 de                	jne    342 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 364:	8b 45 08             	mov    0x8(%ebp),%eax
}
 367:	c9                   	leave  
 368:	c3                   	ret    
 369:	90                   	nop
 36a:	90                   	nop
 36b:	90                   	nop

0000036c <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 36c:	b8 01 00 00 00       	mov    $0x1,%eax
 371:	cd 40                	int    $0x40
 373:	c3                   	ret    

00000374 <exit>:
SYSCALL(exit)
 374:	b8 02 00 00 00       	mov    $0x2,%eax
 379:	cd 40                	int    $0x40
 37b:	c3                   	ret    

0000037c <wait>:
SYSCALL(wait)
 37c:	b8 03 00 00 00       	mov    $0x3,%eax
 381:	cd 40                	int    $0x40
 383:	c3                   	ret    

00000384 <pipe>:
SYSCALL(pipe)
 384:	b8 04 00 00 00       	mov    $0x4,%eax
 389:	cd 40                	int    $0x40
 38b:	c3                   	ret    

0000038c <read>:
SYSCALL(read)
 38c:	b8 05 00 00 00       	mov    $0x5,%eax
 391:	cd 40                	int    $0x40
 393:	c3                   	ret    

00000394 <write>:
SYSCALL(write)
 394:	b8 10 00 00 00       	mov    $0x10,%eax
 399:	cd 40                	int    $0x40
 39b:	c3                   	ret    

0000039c <close>:
SYSCALL(close)
 39c:	b8 15 00 00 00       	mov    $0x15,%eax
 3a1:	cd 40                	int    $0x40
 3a3:	c3                   	ret    

000003a4 <kill>:
SYSCALL(kill)
 3a4:	b8 06 00 00 00       	mov    $0x6,%eax
 3a9:	cd 40                	int    $0x40
 3ab:	c3                   	ret    

000003ac <exec>:
SYSCALL(exec)
 3ac:	b8 07 00 00 00       	mov    $0x7,%eax
 3b1:	cd 40                	int    $0x40
 3b3:	c3                   	ret    

000003b4 <open>:
SYSCALL(open)
 3b4:	b8 0f 00 00 00       	mov    $0xf,%eax
 3b9:	cd 40                	int    $0x40
 3bb:	c3                   	ret    

000003bc <mknod>:
SYSCALL(mknod)
 3bc:	b8 11 00 00 00       	mov    $0x11,%eax
 3c1:	cd 40                	int    $0x40
 3c3:	c3                   	ret    

000003c4 <unlink>:
SYSCALL(unlink)
 3c4:	b8 12 00 00 00       	mov    $0x12,%eax
 3c9:	cd 40                	int    $0x40
 3cb:	c3                   	ret    

000003cc <fstat>:
SYSCALL(fstat)
 3cc:	b8 08 00 00 00       	mov    $0x8,%eax
 3d1:	cd 40                	int    $0x40
 3d3:	c3                   	ret    

000003d4 <link>:
SYSCALL(link)
 3d4:	b8 13 00 00 00       	mov    $0x13,%eax
 3d9:	cd 40                	int    $0x40
 3db:	c3                   	ret    

000003dc <mkdir>:
SYSCALL(mkdir)
 3dc:	b8 14 00 00 00       	mov    $0x14,%eax
 3e1:	cd 40                	int    $0x40
 3e3:	c3                   	ret    

000003e4 <chdir>:
SYSCALL(chdir)
 3e4:	b8 09 00 00 00       	mov    $0x9,%eax
 3e9:	cd 40                	int    $0x40
 3eb:	c3                   	ret    

000003ec <dup>:
SYSCALL(dup)
 3ec:	b8 0a 00 00 00       	mov    $0xa,%eax
 3f1:	cd 40                	int    $0x40
 3f3:	c3                   	ret    

000003f4 <getpid>:
SYSCALL(getpid)
 3f4:	b8 0b 00 00 00       	mov    $0xb,%eax
 3f9:	cd 40                	int    $0x40
 3fb:	c3                   	ret    

000003fc <sbrk>:
SYSCALL(sbrk)
 3fc:	b8 0c 00 00 00       	mov    $0xc,%eax
 401:	cd 40                	int    $0x40
 403:	c3                   	ret    

00000404 <sleep>:
SYSCALL(sleep)
 404:	b8 0d 00 00 00       	mov    $0xd,%eax
 409:	cd 40                	int    $0x40
 40b:	c3                   	ret    

0000040c <uptime>:
SYSCALL(uptime)
 40c:	b8 0e 00 00 00       	mov    $0xe,%eax
 411:	cd 40                	int    $0x40
 413:	c3                   	ret    

00000414 <add_path>:
SYSCALL(add_path)
 414:	b8 16 00 00 00       	mov    $0x16,%eax
 419:	cd 40                	int    $0x40
 41b:	c3                   	ret    

0000041c <wait2>:
SYSCALL(wait2)
 41c:	b8 17 00 00 00       	mov    $0x17,%eax
 421:	cd 40                	int    $0x40
 423:	c3                   	ret    

00000424 <getquanta>:
SYSCALL(getquanta)
 424:	b8 18 00 00 00       	mov    $0x18,%eax
 429:	cd 40                	int    $0x40
 42b:	c3                   	ret    

0000042c <getqueue>:
SYSCALL(getqueue)
 42c:	b8 19 00 00 00       	mov    $0x19,%eax
 431:	cd 40                	int    $0x40
 433:	c3                   	ret    

00000434 <signal>:
SYSCALL(signal)
 434:	b8 1a 00 00 00       	mov    $0x1a,%eax
 439:	cd 40                	int    $0x40
 43b:	c3                   	ret    

0000043c <sigsend>:
SYSCALL(sigsend)
 43c:	b8 1b 00 00 00       	mov    $0x1b,%eax
 441:	cd 40                	int    $0x40
 443:	c3                   	ret    

00000444 <alarm>:
SYSCALL(alarm)
 444:	b8 1c 00 00 00       	mov    $0x1c,%eax
 449:	cd 40                	int    $0x40
 44b:	c3                   	ret    

0000044c <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 44c:	55                   	push   %ebp
 44d:	89 e5                	mov    %esp,%ebp
 44f:	83 ec 28             	sub    $0x28,%esp
 452:	8b 45 0c             	mov    0xc(%ebp),%eax
 455:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 458:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 45f:	00 
 460:	8d 45 f4             	lea    -0xc(%ebp),%eax
 463:	89 44 24 04          	mov    %eax,0x4(%esp)
 467:	8b 45 08             	mov    0x8(%ebp),%eax
 46a:	89 04 24             	mov    %eax,(%esp)
 46d:	e8 22 ff ff ff       	call   394 <write>
}
 472:	c9                   	leave  
 473:	c3                   	ret    

00000474 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 474:	55                   	push   %ebp
 475:	89 e5                	mov    %esp,%ebp
 477:	83 ec 48             	sub    $0x48,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 47a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 481:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 485:	74 17                	je     49e <printint+0x2a>
 487:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 48b:	79 11                	jns    49e <printint+0x2a>
    neg = 1;
 48d:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 494:	8b 45 0c             	mov    0xc(%ebp),%eax
 497:	f7 d8                	neg    %eax
 499:	89 45 ec             	mov    %eax,-0x14(%ebp)
 49c:	eb 06                	jmp    4a4 <printint+0x30>
  } else {
    x = xx;
 49e:	8b 45 0c             	mov    0xc(%ebp),%eax
 4a1:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 4a4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 4ab:	8b 4d 10             	mov    0x10(%ebp),%ecx
 4ae:	8b 45 ec             	mov    -0x14(%ebp),%eax
 4b1:	ba 00 00 00 00       	mov    $0x0,%edx
 4b6:	f7 f1                	div    %ecx
 4b8:	89 d0                	mov    %edx,%eax
 4ba:	0f b6 90 4c 11 00 00 	movzbl 0x114c(%eax),%edx
 4c1:	8d 45 dc             	lea    -0x24(%ebp),%eax
 4c4:	03 45 f4             	add    -0xc(%ebp),%eax
 4c7:	88 10                	mov    %dl,(%eax)
 4c9:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  }while((x /= base) != 0);
 4cd:	8b 55 10             	mov    0x10(%ebp),%edx
 4d0:	89 55 d4             	mov    %edx,-0x2c(%ebp)
 4d3:	8b 45 ec             	mov    -0x14(%ebp),%eax
 4d6:	ba 00 00 00 00       	mov    $0x0,%edx
 4db:	f7 75 d4             	divl   -0x2c(%ebp)
 4de:	89 45 ec             	mov    %eax,-0x14(%ebp)
 4e1:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 4e5:	75 c4                	jne    4ab <printint+0x37>
  if(neg)
 4e7:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 4eb:	74 2a                	je     517 <printint+0xa3>
    buf[i++] = '-';
 4ed:	8d 45 dc             	lea    -0x24(%ebp),%eax
 4f0:	03 45 f4             	add    -0xc(%ebp),%eax
 4f3:	c6 00 2d             	movb   $0x2d,(%eax)
 4f6:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)

  while(--i >= 0)
 4fa:	eb 1b                	jmp    517 <printint+0xa3>
    putc(fd, buf[i]);
 4fc:	8d 45 dc             	lea    -0x24(%ebp),%eax
 4ff:	03 45 f4             	add    -0xc(%ebp),%eax
 502:	0f b6 00             	movzbl (%eax),%eax
 505:	0f be c0             	movsbl %al,%eax
 508:	89 44 24 04          	mov    %eax,0x4(%esp)
 50c:	8b 45 08             	mov    0x8(%ebp),%eax
 50f:	89 04 24             	mov    %eax,(%esp)
 512:	e8 35 ff ff ff       	call   44c <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 517:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 51b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 51f:	79 db                	jns    4fc <printint+0x88>
    putc(fd, buf[i]);
}
 521:	c9                   	leave  
 522:	c3                   	ret    

00000523 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 523:	55                   	push   %ebp
 524:	89 e5                	mov    %esp,%ebp
 526:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 529:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 530:	8d 45 0c             	lea    0xc(%ebp),%eax
 533:	83 c0 04             	add    $0x4,%eax
 536:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 539:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 540:	e9 7d 01 00 00       	jmp    6c2 <printf+0x19f>
    c = fmt[i] & 0xff;
 545:	8b 55 0c             	mov    0xc(%ebp),%edx
 548:	8b 45 f0             	mov    -0x10(%ebp),%eax
 54b:	01 d0                	add    %edx,%eax
 54d:	0f b6 00             	movzbl (%eax),%eax
 550:	0f be c0             	movsbl %al,%eax
 553:	25 ff 00 00 00       	and    $0xff,%eax
 558:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 55b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 55f:	75 2c                	jne    58d <printf+0x6a>
      if(c == '%'){
 561:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 565:	75 0c                	jne    573 <printf+0x50>
        state = '%';
 567:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 56e:	e9 4b 01 00 00       	jmp    6be <printf+0x19b>
      } else {
        putc(fd, c);
 573:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 576:	0f be c0             	movsbl %al,%eax
 579:	89 44 24 04          	mov    %eax,0x4(%esp)
 57d:	8b 45 08             	mov    0x8(%ebp),%eax
 580:	89 04 24             	mov    %eax,(%esp)
 583:	e8 c4 fe ff ff       	call   44c <putc>
 588:	e9 31 01 00 00       	jmp    6be <printf+0x19b>
      }
    } else if(state == '%'){
 58d:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 591:	0f 85 27 01 00 00    	jne    6be <printf+0x19b>
      if(c == 'd'){
 597:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 59b:	75 2d                	jne    5ca <printf+0xa7>
        printint(fd, *ap, 10, 1);
 59d:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5a0:	8b 00                	mov    (%eax),%eax
 5a2:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
 5a9:	00 
 5aa:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
 5b1:	00 
 5b2:	89 44 24 04          	mov    %eax,0x4(%esp)
 5b6:	8b 45 08             	mov    0x8(%ebp),%eax
 5b9:	89 04 24             	mov    %eax,(%esp)
 5bc:	e8 b3 fe ff ff       	call   474 <printint>
        ap++;
 5c1:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 5c5:	e9 ed 00 00 00       	jmp    6b7 <printf+0x194>
      } else if(c == 'x' || c == 'p'){
 5ca:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 5ce:	74 06                	je     5d6 <printf+0xb3>
 5d0:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 5d4:	75 2d                	jne    603 <printf+0xe0>
        printint(fd, *ap, 16, 0);
 5d6:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5d9:	8b 00                	mov    (%eax),%eax
 5db:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 5e2:	00 
 5e3:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 5ea:	00 
 5eb:	89 44 24 04          	mov    %eax,0x4(%esp)
 5ef:	8b 45 08             	mov    0x8(%ebp),%eax
 5f2:	89 04 24             	mov    %eax,(%esp)
 5f5:	e8 7a fe ff ff       	call   474 <printint>
        ap++;
 5fa:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 5fe:	e9 b4 00 00 00       	jmp    6b7 <printf+0x194>
      } else if(c == 's'){
 603:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 607:	75 46                	jne    64f <printf+0x12c>
        s = (char*)*ap;
 609:	8b 45 e8             	mov    -0x18(%ebp),%eax
 60c:	8b 00                	mov    (%eax),%eax
 60e:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 611:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 615:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 619:	75 27                	jne    642 <printf+0x11f>
          s = "(null)";
 61b:	c7 45 f4 72 0d 00 00 	movl   $0xd72,-0xc(%ebp)
        while(*s != 0){
 622:	eb 1e                	jmp    642 <printf+0x11f>
          putc(fd, *s);
 624:	8b 45 f4             	mov    -0xc(%ebp),%eax
 627:	0f b6 00             	movzbl (%eax),%eax
 62a:	0f be c0             	movsbl %al,%eax
 62d:	89 44 24 04          	mov    %eax,0x4(%esp)
 631:	8b 45 08             	mov    0x8(%ebp),%eax
 634:	89 04 24             	mov    %eax,(%esp)
 637:	e8 10 fe ff ff       	call   44c <putc>
          s++;
 63c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 640:	eb 01                	jmp    643 <printf+0x120>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 642:	90                   	nop
 643:	8b 45 f4             	mov    -0xc(%ebp),%eax
 646:	0f b6 00             	movzbl (%eax),%eax
 649:	84 c0                	test   %al,%al
 64b:	75 d7                	jne    624 <printf+0x101>
 64d:	eb 68                	jmp    6b7 <printf+0x194>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 64f:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 653:	75 1d                	jne    672 <printf+0x14f>
        putc(fd, *ap);
 655:	8b 45 e8             	mov    -0x18(%ebp),%eax
 658:	8b 00                	mov    (%eax),%eax
 65a:	0f be c0             	movsbl %al,%eax
 65d:	89 44 24 04          	mov    %eax,0x4(%esp)
 661:	8b 45 08             	mov    0x8(%ebp),%eax
 664:	89 04 24             	mov    %eax,(%esp)
 667:	e8 e0 fd ff ff       	call   44c <putc>
        ap++;
 66c:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 670:	eb 45                	jmp    6b7 <printf+0x194>
      } else if(c == '%'){
 672:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 676:	75 17                	jne    68f <printf+0x16c>
        putc(fd, c);
 678:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 67b:	0f be c0             	movsbl %al,%eax
 67e:	89 44 24 04          	mov    %eax,0x4(%esp)
 682:	8b 45 08             	mov    0x8(%ebp),%eax
 685:	89 04 24             	mov    %eax,(%esp)
 688:	e8 bf fd ff ff       	call   44c <putc>
 68d:	eb 28                	jmp    6b7 <printf+0x194>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 68f:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
 696:	00 
 697:	8b 45 08             	mov    0x8(%ebp),%eax
 69a:	89 04 24             	mov    %eax,(%esp)
 69d:	e8 aa fd ff ff       	call   44c <putc>
        putc(fd, c);
 6a2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 6a5:	0f be c0             	movsbl %al,%eax
 6a8:	89 44 24 04          	mov    %eax,0x4(%esp)
 6ac:	8b 45 08             	mov    0x8(%ebp),%eax
 6af:	89 04 24             	mov    %eax,(%esp)
 6b2:	e8 95 fd ff ff       	call   44c <putc>
      }
      state = 0;
 6b7:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 6be:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 6c2:	8b 55 0c             	mov    0xc(%ebp),%edx
 6c5:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6c8:	01 d0                	add    %edx,%eax
 6ca:	0f b6 00             	movzbl (%eax),%eax
 6cd:	84 c0                	test   %al,%al
 6cf:	0f 85 70 fe ff ff    	jne    545 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 6d5:	c9                   	leave  
 6d6:	c3                   	ret    
 6d7:	90                   	nop

000006d8 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 6d8:	55                   	push   %ebp
 6d9:	89 e5                	mov    %esp,%ebp
 6db:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 6de:	8b 45 08             	mov    0x8(%ebp),%eax
 6e1:	83 e8 08             	sub    $0x8,%eax
 6e4:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6e7:	a1 68 11 00 00       	mov    0x1168,%eax
 6ec:	89 45 fc             	mov    %eax,-0x4(%ebp)
 6ef:	eb 24                	jmp    715 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6f1:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6f4:	8b 00                	mov    (%eax),%eax
 6f6:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 6f9:	77 12                	ja     70d <free+0x35>
 6fb:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6fe:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 701:	77 24                	ja     727 <free+0x4f>
 703:	8b 45 fc             	mov    -0x4(%ebp),%eax
 706:	8b 00                	mov    (%eax),%eax
 708:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 70b:	77 1a                	ja     727 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 70d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 710:	8b 00                	mov    (%eax),%eax
 712:	89 45 fc             	mov    %eax,-0x4(%ebp)
 715:	8b 45 f8             	mov    -0x8(%ebp),%eax
 718:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 71b:	76 d4                	jbe    6f1 <free+0x19>
 71d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 720:	8b 00                	mov    (%eax),%eax
 722:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 725:	76 ca                	jbe    6f1 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 727:	8b 45 f8             	mov    -0x8(%ebp),%eax
 72a:	8b 40 04             	mov    0x4(%eax),%eax
 72d:	c1 e0 03             	shl    $0x3,%eax
 730:	89 c2                	mov    %eax,%edx
 732:	03 55 f8             	add    -0x8(%ebp),%edx
 735:	8b 45 fc             	mov    -0x4(%ebp),%eax
 738:	8b 00                	mov    (%eax),%eax
 73a:	39 c2                	cmp    %eax,%edx
 73c:	75 24                	jne    762 <free+0x8a>
    bp->s.size += p->s.ptr->s.size;
 73e:	8b 45 f8             	mov    -0x8(%ebp),%eax
 741:	8b 50 04             	mov    0x4(%eax),%edx
 744:	8b 45 fc             	mov    -0x4(%ebp),%eax
 747:	8b 00                	mov    (%eax),%eax
 749:	8b 40 04             	mov    0x4(%eax),%eax
 74c:	01 c2                	add    %eax,%edx
 74e:	8b 45 f8             	mov    -0x8(%ebp),%eax
 751:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 754:	8b 45 fc             	mov    -0x4(%ebp),%eax
 757:	8b 00                	mov    (%eax),%eax
 759:	8b 10                	mov    (%eax),%edx
 75b:	8b 45 f8             	mov    -0x8(%ebp),%eax
 75e:	89 10                	mov    %edx,(%eax)
 760:	eb 0a                	jmp    76c <free+0x94>
  } else
    bp->s.ptr = p->s.ptr;
 762:	8b 45 fc             	mov    -0x4(%ebp),%eax
 765:	8b 10                	mov    (%eax),%edx
 767:	8b 45 f8             	mov    -0x8(%ebp),%eax
 76a:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 76c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 76f:	8b 40 04             	mov    0x4(%eax),%eax
 772:	c1 e0 03             	shl    $0x3,%eax
 775:	03 45 fc             	add    -0x4(%ebp),%eax
 778:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 77b:	75 20                	jne    79d <free+0xc5>
    p->s.size += bp->s.size;
 77d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 780:	8b 50 04             	mov    0x4(%eax),%edx
 783:	8b 45 f8             	mov    -0x8(%ebp),%eax
 786:	8b 40 04             	mov    0x4(%eax),%eax
 789:	01 c2                	add    %eax,%edx
 78b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 78e:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 791:	8b 45 f8             	mov    -0x8(%ebp),%eax
 794:	8b 10                	mov    (%eax),%edx
 796:	8b 45 fc             	mov    -0x4(%ebp),%eax
 799:	89 10                	mov    %edx,(%eax)
 79b:	eb 08                	jmp    7a5 <free+0xcd>
  } else
    p->s.ptr = bp;
 79d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7a0:	8b 55 f8             	mov    -0x8(%ebp),%edx
 7a3:	89 10                	mov    %edx,(%eax)
  freep = p;
 7a5:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7a8:	a3 68 11 00 00       	mov    %eax,0x1168
}
 7ad:	c9                   	leave  
 7ae:	c3                   	ret    

000007af <morecore>:

static Header*
morecore(uint nu)
{
 7af:	55                   	push   %ebp
 7b0:	89 e5                	mov    %esp,%ebp
 7b2:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 7b5:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 7bc:	77 07                	ja     7c5 <morecore+0x16>
    nu = 4096;
 7be:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 7c5:	8b 45 08             	mov    0x8(%ebp),%eax
 7c8:	c1 e0 03             	shl    $0x3,%eax
 7cb:	89 04 24             	mov    %eax,(%esp)
 7ce:	e8 29 fc ff ff       	call   3fc <sbrk>
 7d3:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 7d6:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 7da:	75 07                	jne    7e3 <morecore+0x34>
    return 0;
 7dc:	b8 00 00 00 00       	mov    $0x0,%eax
 7e1:	eb 22                	jmp    805 <morecore+0x56>
  hp = (Header*)p;
 7e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7e6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 7e9:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7ec:	8b 55 08             	mov    0x8(%ebp),%edx
 7ef:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 7f2:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7f5:	83 c0 08             	add    $0x8,%eax
 7f8:	89 04 24             	mov    %eax,(%esp)
 7fb:	e8 d8 fe ff ff       	call   6d8 <free>
  return freep;
 800:	a1 68 11 00 00       	mov    0x1168,%eax
}
 805:	c9                   	leave  
 806:	c3                   	ret    

00000807 <malloc>:

void*
malloc(uint nbytes)
{
 807:	55                   	push   %ebp
 808:	89 e5                	mov    %esp,%ebp
 80a:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 80d:	8b 45 08             	mov    0x8(%ebp),%eax
 810:	83 c0 07             	add    $0x7,%eax
 813:	c1 e8 03             	shr    $0x3,%eax
 816:	83 c0 01             	add    $0x1,%eax
 819:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 81c:	a1 68 11 00 00       	mov    0x1168,%eax
 821:	89 45 f0             	mov    %eax,-0x10(%ebp)
 824:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 828:	75 23                	jne    84d <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 82a:	c7 45 f0 60 11 00 00 	movl   $0x1160,-0x10(%ebp)
 831:	8b 45 f0             	mov    -0x10(%ebp),%eax
 834:	a3 68 11 00 00       	mov    %eax,0x1168
 839:	a1 68 11 00 00       	mov    0x1168,%eax
 83e:	a3 60 11 00 00       	mov    %eax,0x1160
    base.s.size = 0;
 843:	c7 05 64 11 00 00 00 	movl   $0x0,0x1164
 84a:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 84d:	8b 45 f0             	mov    -0x10(%ebp),%eax
 850:	8b 00                	mov    (%eax),%eax
 852:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 855:	8b 45 f4             	mov    -0xc(%ebp),%eax
 858:	8b 40 04             	mov    0x4(%eax),%eax
 85b:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 85e:	72 4d                	jb     8ad <malloc+0xa6>
      if(p->s.size == nunits)
 860:	8b 45 f4             	mov    -0xc(%ebp),%eax
 863:	8b 40 04             	mov    0x4(%eax),%eax
 866:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 869:	75 0c                	jne    877 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 86b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 86e:	8b 10                	mov    (%eax),%edx
 870:	8b 45 f0             	mov    -0x10(%ebp),%eax
 873:	89 10                	mov    %edx,(%eax)
 875:	eb 26                	jmp    89d <malloc+0x96>
      else {
        p->s.size -= nunits;
 877:	8b 45 f4             	mov    -0xc(%ebp),%eax
 87a:	8b 40 04             	mov    0x4(%eax),%eax
 87d:	89 c2                	mov    %eax,%edx
 87f:	2b 55 ec             	sub    -0x14(%ebp),%edx
 882:	8b 45 f4             	mov    -0xc(%ebp),%eax
 885:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 888:	8b 45 f4             	mov    -0xc(%ebp),%eax
 88b:	8b 40 04             	mov    0x4(%eax),%eax
 88e:	c1 e0 03             	shl    $0x3,%eax
 891:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 894:	8b 45 f4             	mov    -0xc(%ebp),%eax
 897:	8b 55 ec             	mov    -0x14(%ebp),%edx
 89a:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 89d:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8a0:	a3 68 11 00 00       	mov    %eax,0x1168
      return (void*)(p + 1);
 8a5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8a8:	83 c0 08             	add    $0x8,%eax
 8ab:	eb 38                	jmp    8e5 <malloc+0xde>
    }
    if(p == freep)
 8ad:	a1 68 11 00 00       	mov    0x1168,%eax
 8b2:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 8b5:	75 1b                	jne    8d2 <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
 8b7:	8b 45 ec             	mov    -0x14(%ebp),%eax
 8ba:	89 04 24             	mov    %eax,(%esp)
 8bd:	e8 ed fe ff ff       	call   7af <morecore>
 8c2:	89 45 f4             	mov    %eax,-0xc(%ebp)
 8c5:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 8c9:	75 07                	jne    8d2 <malloc+0xcb>
        return 0;
 8cb:	b8 00 00 00 00       	mov    $0x0,%eax
 8d0:	eb 13                	jmp    8e5 <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8d2:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8d5:	89 45 f0             	mov    %eax,-0x10(%ebp)
 8d8:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8db:	8b 00                	mov    (%eax),%eax
 8dd:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 8e0:	e9 70 ff ff ff       	jmp    855 <malloc+0x4e>
}
 8e5:	c9                   	leave  
 8e6:	c3                   	ret    
 8e7:	90                   	nop

000008e8 <getNextThread>:
} tTable;


int
getNextThread(int j)
{
 8e8:	55                   	push   %ebp
 8e9:	89 e5                	mov    %esp,%ebp
 8eb:	83 ec 10             	sub    $0x10,%esp
  int i=j+1;
 8ee:	8b 45 08             	mov    0x8(%ebp),%eax
 8f1:	83 c0 01             	add    $0x1,%eax
 8f4:	89 45 fc             	mov    %eax,-0x4(%ebp)
  if(i==MAX_THREAD)
 8f7:	83 7d fc 40          	cmpl   $0x40,-0x4(%ebp)
 8fb:	75 07                	jne    904 <getNextThread+0x1c>
    i=0;
 8fd:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  uthread_p t=&tTable.table[i];
 904:	8b 45 fc             	mov    -0x4(%ebp),%eax
 907:	69 c0 18 01 00 00    	imul   $0x118,%eax,%eax
 90d:	05 80 11 00 00       	add    $0x1180,%eax
 912:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(i!=j)
 915:	eb 3b                	jmp    952 <getNextThread+0x6a>
  {
    if(t->state==T_RUNNABLE)
 917:	8b 45 f8             	mov    -0x8(%ebp),%eax
 91a:	8b 40 10             	mov    0x10(%eax),%eax
 91d:	83 f8 03             	cmp    $0x3,%eax
 920:	75 05                	jne    927 <getNextThread+0x3f>
      return i;
 922:	8b 45 fc             	mov    -0x4(%ebp),%eax
 925:	eb 38                	jmp    95f <getNextThread+0x77>
    i++;
 927:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    if(i==MAX_THREAD)
 92b:	83 7d fc 40          	cmpl   $0x40,-0x4(%ebp)
 92f:	75 1a                	jne    94b <getNextThread+0x63>
    {
       i=0;
 931:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
       t=&tTable.table[i];
 938:	8b 45 fc             	mov    -0x4(%ebp),%eax
 93b:	69 c0 18 01 00 00    	imul   $0x118,%eax,%eax
 941:	05 80 11 00 00       	add    $0x1180,%eax
 946:	89 45 f8             	mov    %eax,-0x8(%ebp)
 949:	eb 07                	jmp    952 <getNextThread+0x6a>
    }
    else
      t++;
 94b:	81 45 f8 18 01 00 00 	addl   $0x118,-0x8(%ebp)
{
  int i=j+1;
  if(i==MAX_THREAD)
    i=0;
  uthread_p t=&tTable.table[i];
  while(i!=j)
 952:	8b 45 fc             	mov    -0x4(%ebp),%eax
 955:	3b 45 08             	cmp    0x8(%ebp),%eax
 958:	75 bd                	jne    917 <getNextThread+0x2f>
    }
    else
      t++;
    
  }
  return -1;
 95a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
 95f:	c9                   	leave  
 960:	c3                   	ret    

00000961 <allocThread>:


static uthread_p
allocThread()
{
 961:	55                   	push   %ebp
 962:	89 e5                	mov    %esp,%ebp
 964:	83 ec 28             	sub    $0x28,%esp
  int i,j;
  uthread_p t;
  
  for (t=tTable.table,i=0 ; t <= &tTable.table[MAX_THREAD]; t++,i++)// <= should be < ??
 967:	c7 45 ec 80 11 00 00 	movl   $0x1180,-0x14(%ebp)
 96e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 975:	eb 15                	jmp    98c <allocThread+0x2b>
  {
    if(t->state==T_FREE)
 977:	8b 45 ec             	mov    -0x14(%ebp),%eax
 97a:	8b 40 10             	mov    0x10(%eax),%eax
 97d:	85 c0                	test   %eax,%eax
 97f:	74 1e                	je     99f <allocThread+0x3e>
allocThread()
{
  int i,j;
  uthread_p t;
  
  for (t=tTable.table,i=0 ; t <= &tTable.table[MAX_THREAD]; t++,i++)// <= should be < ??
 981:	81 45 ec 18 01 00 00 	addl   $0x118,-0x14(%ebp)
 988:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 98c:	81 7d ec 80 57 00 00 	cmpl   $0x5780,-0x14(%ebp)
 993:	76 e2                	jbe    977 <allocThread+0x16>
  {
    if(t->state==T_FREE)
      goto found;
  }
  return 0;
 995:	b8 00 00 00 00       	mov    $0x0,%eax
 99a:	e9 88 00 00 00       	jmp    a27 <allocThread+0xc6>
  uthread_p t;
  
  for (t=tTable.table,i=0 ; t <= &tTable.table[MAX_THREAD]; t++,i++)// <= should be < ??
  {
    if(t->state==T_FREE)
      goto found;
 99f:	90                   	nop
  }
  return 0;
  
  found:
  
  t->tid=i;
 9a0:	8b 45 ec             	mov    -0x14(%ebp),%eax
 9a3:	8b 55 f4             	mov    -0xc(%ebp),%edx
 9a6:	89 10                	mov    %edx,(%eax)
  t->stack=(char*)malloc(STACK_SIZE);
 9a8:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
 9af:	e8 53 fe ff ff       	call   807 <malloc>
 9b4:	8b 55 ec             	mov    -0x14(%ebp),%edx
 9b7:	89 42 0c             	mov    %eax,0xc(%edx)
  t->esp=(int)t->stack;
 9ba:	8b 45 ec             	mov    -0x14(%ebp),%eax
 9bd:	8b 40 0c             	mov    0xc(%eax),%eax
 9c0:	89 c2                	mov    %eax,%edx
 9c2:	8b 45 ec             	mov    -0x14(%ebp),%eax
 9c5:	89 50 04             	mov    %edx,0x4(%eax)
  t->ebp=(int)t->stack;
 9c8:	8b 45 ec             	mov    -0x14(%ebp),%eax
 9cb:	8b 40 0c             	mov    0xc(%eax),%eax
 9ce:	89 c2                	mov    %eax,%edx
 9d0:	8b 45 ec             	mov    -0x14(%ebp),%eax
 9d3:	89 50 08             	mov    %edx,0x8(%eax)
  t->firstTime=0;
 9d6:	8b 45 ec             	mov    -0x14(%ebp),%eax
 9d9:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
  for(j=0;j<64;j++)
 9e0:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 9e7:	eb 15                	jmp    9fe <allocThread+0x9d>
  {
    t->waiting[j]=-1;
 9e9:	8b 45 ec             	mov    -0x14(%ebp),%eax
 9ec:	8b 55 f0             	mov    -0x10(%ebp),%edx
 9ef:	83 c2 04             	add    $0x4,%edx
 9f2:	c7 44 90 08 ff ff ff 	movl   $0xffffffff,0x8(%eax,%edx,4)
 9f9:	ff 
  t->tid=i;
  t->stack=(char*)malloc(STACK_SIZE);
  t->esp=(int)t->stack;
  t->ebp=(int)t->stack;
  t->firstTime=0;
  for(j=0;j<64;j++)
 9fa:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 9fe:	83 7d f0 3f          	cmpl   $0x3f,-0x10(%ebp)
 a02:	7e e5                	jle    9e9 <allocThread+0x88>
  {
    t->waiting[j]=-1;
  }
  asm("movl %1,%%esp;" "push %2;" "movl %%esp,%0;" //pushes the uthread_exit func as return address
    : "=r" (t->esp) 
    : "r" (t->ebp) , "r"(uthread_exit)
 a04:	8b 45 ec             	mov    -0x14(%ebp),%eax
 a07:	8b 40 08             	mov    0x8(%eax),%eax
  t->firstTime=0;
  for(j=0;j<64;j++)
  {
    t->waiting[j]=-1;
  }
  asm("movl %1,%%esp;" "push %2;" "movl %%esp,%0;" //pushes the uthread_exit func as return address
 a0a:	ba 26 0b 00 00       	mov    $0xb26,%edx
 a0f:	89 c4                	mov    %eax,%esp
 a11:	52                   	push   %edx
 a12:	89 e2                	mov    %esp,%edx
    : "=r" (t->esp) 
 a14:	8b 45 ec             	mov    -0x14(%ebp),%eax
  t->firstTime=0;
  for(j=0;j<64;j++)
  {
    t->waiting[j]=-1;
  }
  asm("movl %1,%%esp;" "push %2;" "movl %%esp,%0;" //pushes the uthread_exit func as return address
 a17:	89 50 04             	mov    %edx,0x4(%eax)
    : "=r" (t->esp) 
    : "r" (t->ebp) , "r"(uthread_exit)
  );
  t->state=T_UNINIT;
 a1a:	8b 45 ec             	mov    -0x14(%ebp),%eax
 a1d:	c7 40 10 01 00 00 00 	movl   $0x1,0x10(%eax)
  return t;
 a24:	8b 45 ec             	mov    -0x14(%ebp),%eax
}
 a27:	c9                   	leave  
 a28:	c3                   	ret    

00000a29 <uthread_init>:

void 
uthread_init()
{  
 a29:	55                   	push   %ebp
 a2a:	89 e5                	mov    %esp,%ebp
 a2c:	83 ec 28             	sub    $0x28,%esp
  tTable.length=0;
 a2f:	c7 05 80 57 00 00 00 	movl   $0x0,0x5780
 a36:	00 00 00 
  tTable.current=0;
 a39:	c7 05 84 57 00 00 00 	movl   $0x0,0x5784
 a40:	00 00 00 
  uthread_p mainT = allocThread(); //needed to allocate the main thread !!!!!!
 a43:	e8 19 ff ff ff       	call   961 <allocThread>
 a48:	89 45 f4             	mov    %eax,-0xc(%ebp)
  asm("movl %%ebp,%0;" "movl %%esp,%1;" //get current thread ebp and esp
 a4b:	89 e9                	mov    %ebp,%ecx
 a4d:	89 e2                	mov    %esp,%edx
    : "=r" (mainT->ebp) ,"=r"(mainT->esp)    
 a4f:	8b 45 f4             	mov    -0xc(%ebp),%eax
uthread_init()
{  
  tTable.length=0;
  tTable.current=0;
  uthread_p mainT = allocThread(); //needed to allocate the main thread !!!!!!
  asm("movl %%ebp,%0;" "movl %%esp,%1;" //get current thread ebp and esp
 a52:	89 48 08             	mov    %ecx,0x8(%eax)
    : "=r" (mainT->ebp) ,"=r"(mainT->esp)    
 a55:	8b 45 f4             	mov    -0xc(%ebp),%eax
uthread_init()
{  
  tTable.length=0;
  tTable.current=0;
  uthread_p mainT = allocThread(); //needed to allocate the main thread !!!!!!
  asm("movl %%ebp,%0;" "movl %%esp,%1;" //get current thread ebp and esp
 a58:	89 50 04             	mov    %edx,0x4(%eax)
    : "=r" (mainT->ebp) ,"=r"(mainT->esp)    
  );
  /*moves stack to mainT's stack
  /stacks grow backwards so we start from esp and finsh at ebp*/
  memmove(mainT->stack , (void*)mainT->esp , mainT->ebp - mainT->esp);
 a5b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a5e:	8b 50 08             	mov    0x8(%eax),%edx
 a61:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a64:	8b 40 04             	mov    0x4(%eax),%eax
 a67:	89 d1                	mov    %edx,%ecx
 a69:	29 c1                	sub    %eax,%ecx
 a6b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a6e:	8b 40 04             	mov    0x4(%eax),%eax
 a71:	89 c2                	mov    %eax,%edx
 a73:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a76:	8b 40 0c             	mov    0xc(%eax),%eax
 a79:	89 4c 24 08          	mov    %ecx,0x8(%esp)
 a7d:	89 54 24 04          	mov    %edx,0x4(%esp)
 a81:	89 04 24             	mov    %eax,(%esp)
 a84:	e8 a5 f8 ff ff       	call   32e <memmove>
  mainT->state = T_RUNNABLE;
 a89:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a8c:	c7 40 10 03 00 00 00 	movl   $0x3,0x10(%eax)
  currentThread=mainT;
 a93:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a96:	a3 a0 59 00 00       	mov    %eax,0x59a0
  if(signal(SIGALRM,uthread_yield)<0)
 a9b:	c7 44 24 04 96 0c 00 	movl   $0xc96,0x4(%esp)
 aa2:	00 
 aa3:	c7 04 24 0e 00 00 00 	movl   $0xe,(%esp)
 aaa:	e8 85 f9 ff ff       	call   434 <signal>
 aaf:	85 c0                	test   %eax,%eax
 ab1:	79 19                	jns    acc <uthread_init+0xa3>
  {
    printf(1,"Cant register the alarm signal");
 ab3:	c7 44 24 04 7c 0d 00 	movl   $0xd7c,0x4(%esp)
 aba:	00 
 abb:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 ac2:	e8 5c fa ff ff       	call   523 <printf>
    exit();
 ac7:	e8 a8 f8 ff ff       	call   374 <exit>
  }
  if(alarm(THREAD_QUANTA)<0)
 acc:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
 ad3:	e8 6c f9 ff ff       	call   444 <alarm>
 ad8:	85 c0                	test   %eax,%eax
 ada:	79 19                	jns    af5 <uthread_init+0xcc>
  {
    printf(1,"Cant activate alarm system call");
 adc:	c7 44 24 04 9c 0d 00 	movl   $0xd9c,0x4(%esp)
 ae3:	00 
 ae4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 aeb:	e8 33 fa ff ff       	call   523 <printf>
    exit();
 af0:	e8 7f f8 ff ff       	call   374 <exit>
  }
  
}
 af5:	c9                   	leave  
 af6:	c3                   	ret    

00000af7 <uthread_create>:

int  
uthread_create(void (*start_func)(void *), void* arg)
{
 af7:	55                   	push   %ebp
 af8:	89 e5                	mov    %esp,%ebp
 afa:	83 ec 18             	sub    $0x18,%esp
  uthread_p t = allocThread();
 afd:	e8 5f fe ff ff       	call   961 <allocThread>
 b02:	89 45 f4             	mov    %eax,-0xc(%ebp)
  
  asm("push %1;"  //stores the arguments to be used
 b05:	8b 45 0c             	mov    0xc(%ebp),%eax
 b08:	8b 55 08             	mov    0x8(%ebp),%edx
 b0b:	50                   	push   %eax
 b0c:	52                   	push   %edx
 b0d:	89 e2                	mov    %esp,%edx
      "push %2;"  //stores the start_func location
      "movl %%esp,%0;"
      : "=r" (t->esp)
 b0f:	8b 45 f4             	mov    -0xc(%ebp),%eax
int  
uthread_create(void (*start_func)(void *), void* arg)
{
  uthread_p t = allocThread();
  
  asm("push %1;"  //stores the arguments to be used
 b12:	89 50 04             	mov    %edx,0x4(%eax)
      "push %2;"  //stores the start_func location
      "movl %%esp,%0;"
      : "=r" (t->esp)
      : "r" (arg) , "r"(start_func)
  );
  t->state= T_RUNNABLE;
 b15:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b18:	c7 40 10 03 00 00 00 	movl   $0x3,0x10(%eax)
  
  return t->tid;
 b1f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b22:	8b 00                	mov    (%eax),%eax
}
 b24:	c9                   	leave  
 b25:	c3                   	ret    

00000b26 <uthread_exit>:

void 
uthread_exit()
{
 b26:	55                   	push   %ebp
 b27:	89 e5                	mov    %esp,%ebp
 b29:	83 ec 28             	sub    $0x28,%esp
  uthread_p newt;
  int old=currentThread->tid;
 b2c:	a1 a0 59 00 00       	mov    0x59a0,%eax
 b31:	8b 00                	mov    (%eax),%eax
 b33:	89 45 f0             	mov    %eax,-0x10(%ebp)
  
  int i=0;
 b36:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  while(currentThread->waiting[i]!=-1)
 b3d:	eb 25                	jmp    b64 <uthread_exit+0x3e>
  {
    (&tTable.table[currentThread->waiting[i]])->state=T_RUNNABLE;
 b3f:	a1 a0 59 00 00       	mov    0x59a0,%eax
 b44:	8b 55 f4             	mov    -0xc(%ebp),%edx
 b47:	83 c2 04             	add    $0x4,%edx
 b4a:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
 b4e:	69 c0 18 01 00 00    	imul   $0x118,%eax,%eax
 b54:	05 80 11 00 00       	add    $0x1180,%eax
 b59:	c7 40 10 03 00 00 00 	movl   $0x3,0x10(%eax)
    i++;
 b60:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
{
  uthread_p newt;
  int old=currentThread->tid;
  
  int i=0;
  while(currentThread->waiting[i]!=-1)
 b64:	a1 a0 59 00 00       	mov    0x59a0,%eax
 b69:	8b 55 f4             	mov    -0xc(%ebp),%edx
 b6c:	83 c2 04             	add    $0x4,%edx
 b6f:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
 b73:	83 f8 ff             	cmp    $0xffffffff,%eax
 b76:	75 c7                	jne    b3f <uthread_exit+0x19>
  {
    (&tTable.table[currentThread->waiting[i]])->state=T_RUNNABLE;
    i++;
  }
  currentThread->tid=-1;
 b78:	a1 a0 59 00 00       	mov    0x59a0,%eax
 b7d:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)
  currentThread->esp=-1;
 b83:	a1 a0 59 00 00       	mov    0x59a0,%eax
 b88:	c7 40 04 ff ff ff ff 	movl   $0xffffffff,0x4(%eax)
  currentThread->ebp=-1;
 b8f:	a1 a0 59 00 00       	mov    0x59a0,%eax
 b94:	c7 40 08 ff ff ff ff 	movl   $0xffffffff,0x8(%eax)
  free(currentThread->stack);
 b9b:	a1 a0 59 00 00       	mov    0x59a0,%eax
 ba0:	8b 40 0c             	mov    0xc(%eax),%eax
 ba3:	89 04 24             	mov    %eax,(%esp)
 ba6:	e8 2d fb ff ff       	call   6d8 <free>
  currentThread->state=T_FREE;
 bab:	a1 a0 59 00 00       	mov    0x59a0,%eax
 bb0:	c7 40 10 00 00 00 00 	movl   $0x0,0x10(%eax)
  currentThread->firstTime=0;
 bb7:	a1 a0 59 00 00       	mov    0x59a0,%eax
 bbc:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
  int new=getNextThread(old);
 bc3:	8b 45 f0             	mov    -0x10(%ebp),%eax
 bc6:	89 04 24             	mov    %eax,(%esp)
 bc9:	e8 1a fd ff ff       	call   8e8 <getNextThread>
 bce:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if(new>=0)
 bd1:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 bd5:	78 36                	js     c0d <uthread_exit+0xe7>
          {
             newt=&tTable.table[new];
 bd7:	8b 45 ec             	mov    -0x14(%ebp),%eax
 bda:	69 c0 18 01 00 00    	imul   $0x118,%eax,%eax
 be0:	05 80 11 00 00       	add    $0x1180,%eax
 be5:	89 45 e8             	mov    %eax,-0x18(%ebp)
             newt->state=T_RUNNING;
 be8:	8b 45 e8             	mov    -0x18(%ebp),%eax
 beb:	c7 40 10 02 00 00 00 	movl   $0x2,0x10(%eax)
             LOAD_ESP(newt->esp);
 bf2:	8b 45 e8             	mov    -0x18(%ebp),%eax
 bf5:	8b 40 04             	mov    0x4(%eax),%eax
 bf8:	89 c4                	mov    %eax,%esp
             LOAD_EBP(newt->ebp);
 bfa:	8b 45 e8             	mov    -0x18(%ebp),%eax
 bfd:	8b 40 08             	mov    0x8(%eax),%eax
 c00:	89 c5                	mov    %eax,%ebp
             asm("popa");
 c02:	61                   	popa   
             currentThread=newt;
 c03:	8b 45 e8             	mov    -0x18(%ebp),%eax
 c06:	a3 a0 59 00 00       	mov    %eax,0x59a0
        {/////what if some thread state is sleeping?
             
             exit();
        }
     
}
 c0b:	c9                   	leave  
 c0c:	c3                   	ret    
             currentThread=newt;
          }
        else
        {/////what if some thread state is sleeping?
             
             exit();
 c0d:	e8 62 f7 ff ff       	call   374 <exit>

00000c12 <uthred_join>:
}


int
uthred_join(int tid)
{
 c12:	55                   	push   %ebp
 c13:	89 e5                	mov    %esp,%ebp
 c15:	83 ec 18             	sub    $0x18,%esp
  if((&tTable.table[tid])->state==T_FREE)
 c18:	8b 45 08             	mov    0x8(%ebp),%eax
 c1b:	69 c0 18 01 00 00    	imul   $0x118,%eax,%eax
 c21:	05 80 11 00 00       	add    $0x1180,%eax
 c26:	8b 40 10             	mov    0x10(%eax),%eax
 c29:	85 c0                	test   %eax,%eax
 c2b:	75 07                	jne    c34 <uthred_join+0x22>
    return -1;
 c2d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 c32:	eb 60                	jmp    c94 <uthred_join+0x82>
  else
  {
      int i=0;
 c34:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
      while((&tTable.table[tid])->waiting[i]!=-1)
 c3b:	eb 04                	jmp    c41 <uthred_join+0x2f>
        i++;
 c3d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  if((&tTable.table[tid])->state==T_FREE)
    return -1;
  else
  {
      int i=0;
      while((&tTable.table[tid])->waiting[i]!=-1)
 c41:	8b 45 08             	mov    0x8(%ebp),%eax
 c44:	69 c0 18 01 00 00    	imul   $0x118,%eax,%eax
 c4a:	05 80 11 00 00       	add    $0x1180,%eax
 c4f:	8b 55 f4             	mov    -0xc(%ebp),%edx
 c52:	83 c2 04             	add    $0x4,%edx
 c55:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
 c59:	83 f8 ff             	cmp    $0xffffffff,%eax
 c5c:	75 df                	jne    c3d <uthred_join+0x2b>
        i++;
      (&tTable.table[tid])->waiting[i]=currentThread->tid;
 c5e:	8b 45 08             	mov    0x8(%ebp),%eax
 c61:	69 c0 18 01 00 00    	imul   $0x118,%eax,%eax
 c67:	8d 90 80 11 00 00    	lea    0x1180(%eax),%edx
 c6d:	a1 a0 59 00 00       	mov    0x59a0,%eax
 c72:	8b 00                	mov    (%eax),%eax
 c74:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 c77:	83 c1 04             	add    $0x4,%ecx
 c7a:	89 44 8a 08          	mov    %eax,0x8(%edx,%ecx,4)
      currentThread->state=T_SLEEPING;
 c7e:	a1 a0 59 00 00       	mov    0x59a0,%eax
 c83:	c7 40 10 04 00 00 00 	movl   $0x4,0x10(%eax)
      uthread_yield();
 c8a:	e8 07 00 00 00       	call   c96 <uthread_yield>
      return 1;
 c8f:	b8 01 00 00 00       	mov    $0x1,%eax
  }
}
 c94:	c9                   	leave  
 c95:	c3                   	ret    

00000c96 <uthread_yield>:

void 
uthread_yield()
{
 c96:	55                   	push   %ebp
 c97:	89 e5                	mov    %esp,%ebp
 c99:	83 ec 28             	sub    $0x28,%esp
  uthread_p newt;
  int old=currentThread->tid;
 c9c:	a1 a0 59 00 00       	mov    0x59a0,%eax
 ca1:	8b 00                	mov    (%eax),%eax
 ca3:	89 45 f4             	mov    %eax,-0xc(%ebp)
  int new=getNextThread(old);
 ca6:	8b 45 f4             	mov    -0xc(%ebp),%eax
 ca9:	89 04 24             	mov    %eax,(%esp)
 cac:	e8 37 fc ff ff       	call   8e8 <getNextThread>
 cb1:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(new<0)
 cb4:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 cb8:	79 19                	jns    cd3 <uthread_yield+0x3d>
  {
     printf(1,"(fun uthread_yield)Cant find runnable thread");
 cba:	c7 44 24 04 bc 0d 00 	movl   $0xdbc,0x4(%esp)
 cc1:	00 
 cc2:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 cc9:	e8 55 f8 ff ff       	call   523 <printf>
    exit();
 cce:	e8 a1 f6 ff ff       	call   374 <exit>
  }
newt=&tTable.table[new];
 cd3:	8b 45 f0             	mov    -0x10(%ebp),%eax
 cd6:	69 c0 18 01 00 00    	imul   $0x118,%eax,%eax
 cdc:	05 80 11 00 00       	add    $0x1180,%eax
 ce1:	89 45 ec             	mov    %eax,-0x14(%ebp)
  
    asm("pusha");
 ce4:	60                   	pusha  
    STORE_ESP(currentThread->esp);
 ce5:	a1 a0 59 00 00       	mov    0x59a0,%eax
 cea:	89 e2                	mov    %esp,%edx
 cec:	89 50 04             	mov    %edx,0x4(%eax)
    if(currentThread->state==T_RUNNING)
 cef:	a1 a0 59 00 00       	mov    0x59a0,%eax
 cf4:	8b 40 10             	mov    0x10(%eax),%eax
 cf7:	83 f8 02             	cmp    $0x2,%eax
 cfa:	75 0c                	jne    d08 <uthread_yield+0x72>
      currentThread->state=T_RUNNABLE;
 cfc:	a1 a0 59 00 00       	mov    0x59a0,%eax
 d01:	c7 40 10 03 00 00 00 	movl   $0x3,0x10(%eax)
    LOAD_ESP(newt->esp);
 d08:	8b 45 ec             	mov    -0x14(%ebp),%eax
 d0b:	8b 40 04             	mov    0x4(%eax),%eax
 d0e:	89 c4                	mov    %eax,%esp
    
  
    newt->state=T_RUNNING;
 d10:	8b 45 ec             	mov    -0x14(%ebp),%eax
 d13:	c7 40 10 02 00 00 00 	movl   $0x2,0x10(%eax)

    asm("popa");
 d1a:	61                   	popa   
    if(currentThread->firstTime==0)
 d1b:	a1 a0 59 00 00       	mov    0x59a0,%eax
 d20:	8b 40 14             	mov    0x14(%eax),%eax
 d23:	85 c0                	test   %eax,%eax
 d25:	75 0d                	jne    d34 <uthread_yield+0x9e>
    {
       asm("ret");////only firest time
 d27:	c3                   	ret    
       currentThread->firstTime=1;
 d28:	a1 a0 59 00 00       	mov    0x59a0,%eax
 d2d:	c7 40 14 01 00 00 00 	movl   $0x1,0x14(%eax)
    }
   
currentThread=newt;
 d34:	8b 45 ec             	mov    -0x14(%ebp),%eax
 d37:	a3 a0 59 00 00       	mov    %eax,0x59a0

}
 d3c:	c9                   	leave  
 d3d:	c3                   	ret    

00000d3e <uthred_self>:

int  uthred_self(void)
{
 d3e:	55                   	push   %ebp
 d3f:	89 e5                	mov    %esp,%ebp
  return currentThread->tid;
 d41:	a1 a0 59 00 00       	mov    0x59a0,%eax
 d46:	8b 00                	mov    (%eax),%eax
}
 d48:	5d                   	pop    %ebp
 d49:	c3                   	ret    
