
_sigsend_test:     file format elf32-i386


Disassembly of section .text:

00000000 <print_handler>:
#include "user.h"
#include "fs.h"

void
print_handler()
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 ec 18             	sub    $0x18,%esp
  printf(1,"printing from user space\n");
   6:	c7 44 24 04 18 0d 00 	movl   $0xd18,0x4(%esp)
   d:	00 
   e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  15:	e8 d5 04 00 00       	call   4ef <printf>
}
  1a:	c9                   	leave  
  1b:	c3                   	ret    

0000001c <main>:
  

int
main(int argc, char *argv[])
{
  1c:	55                   	push   %ebp
  1d:	89 e5                	mov    %esp,%ebp
  1f:	83 e4 f0             	and    $0xfffffff0,%esp
  22:	83 ec 20             	sub    $0x20,%esp
  int i;
  //int a;

  if(argc < 2 || argc > 3){
  25:	83 7d 08 01          	cmpl   $0x1,0x8(%ebp)
  29:	7e 06                	jle    31 <main+0x15>
  2b:	83 7d 08 03          	cmpl   $0x3,0x8(%ebp)
  2f:	7e 19                	jle    4a <main+0x2e>
    printf(1,"cant use sigsend_test that way.. use:\nsigsend_test [SIGNAL]\n");
  31:	c7 44 24 04 34 0d 00 	movl   $0xd34,0x4(%esp)
  38:	00 
  39:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  40:	e8 aa 04 00 00       	call   4ef <printf>
    exit();
  45:	e8 f6 02 00 00       	call   340 <exit>
  }

  if((i=fork()) <0)
  4a:	e8 e9 02 00 00       	call   338 <fork>
  4f:	89 44 24 1c          	mov    %eax,0x1c(%esp)
  53:	83 7c 24 1c 00       	cmpl   $0x0,0x1c(%esp)
  58:	79 19                	jns    73 <main+0x57>
  {
    printf(1,"failed forking for some reason\n");
  5a:	c7 44 24 04 74 0d 00 	movl   $0xd74,0x4(%esp)
  61:	00 
  62:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  69:	e8 81 04 00 00       	call   4ef <printf>
    exit();
  6e:	e8 cd 02 00 00       	call   340 <exit>
  }
   if(i!=0){
  73:	83 7c 24 1c 00       	cmpl   $0x0,0x1c(%esp)
  78:	74 0a                	je     84 <main+0x68>
//     {
//           
//       printf(1,"sigsend return -1\n");
//       exit();
//     }
    wait();
  7a:	e8 c9 02 00 00       	call   348 <wait>
    alarm(atoi(argv[1]));

    while(1){
    }
  } 
  exit();
  7f:	e8 bc 02 00 00       	call   340 <exit>
    
  }
  else
  {

    signal(14,(sighandler_t)print_handler); //14 is the number of SYGALARM
  84:	b8 00 00 00 00       	mov    $0x0,%eax
  89:	89 44 24 04          	mov    %eax,0x4(%esp)
  8d:	c7 04 24 0e 00 00 00 	movl   $0xe,(%esp)
  94:	e8 67 03 00 00       	call   400 <signal>
    printf(1,"an alarm system call was executed with %d parameter\n",atoi(argv[1]));
  99:	8b 45 0c             	mov    0xc(%ebp),%eax
  9c:	83 c0 04             	add    $0x4,%eax
  9f:	8b 00                	mov    (%eax),%eax
  a1:	89 04 24             	mov    %eax,(%esp)
  a4:	e8 06 02 00 00       	call   2af <atoi>
  a9:	89 44 24 08          	mov    %eax,0x8(%esp)
  ad:	c7 44 24 04 94 0d 00 	movl   $0xd94,0x4(%esp)
  b4:	00 
  b5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  bc:	e8 2e 04 00 00       	call   4ef <printf>
    alarm(atoi(argv[1]));
  c1:	8b 45 0c             	mov    0xc(%ebp),%eax
  c4:	83 c0 04             	add    $0x4,%eax
  c7:	8b 00                	mov    (%eax),%eax
  c9:	89 04 24             	mov    %eax,(%esp)
  cc:	e8 de 01 00 00       	call   2af <atoi>
  d1:	89 04 24             	mov    %eax,(%esp)
  d4:	e8 37 03 00 00       	call   410 <alarm>

    while(1){
    }
  d9:	eb fe                	jmp    d9 <main+0xbd>
  db:	90                   	nop

000000dc <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  dc:	55                   	push   %ebp
  dd:	89 e5                	mov    %esp,%ebp
  df:	57                   	push   %edi
  e0:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
  e1:	8b 4d 08             	mov    0x8(%ebp),%ecx
  e4:	8b 55 10             	mov    0x10(%ebp),%edx
  e7:	8b 45 0c             	mov    0xc(%ebp),%eax
  ea:	89 cb                	mov    %ecx,%ebx
  ec:	89 df                	mov    %ebx,%edi
  ee:	89 d1                	mov    %edx,%ecx
  f0:	fc                   	cld    
  f1:	f3 aa                	rep stos %al,%es:(%edi)
  f3:	89 ca                	mov    %ecx,%edx
  f5:	89 fb                	mov    %edi,%ebx
  f7:	89 5d 08             	mov    %ebx,0x8(%ebp)
  fa:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  fd:	5b                   	pop    %ebx
  fe:	5f                   	pop    %edi
  ff:	5d                   	pop    %ebp
 100:	c3                   	ret    

00000101 <strcpy>:
#include "x86.h"


char*
strcpy(char *s, char *t)
{
 101:	55                   	push   %ebp
 102:	89 e5                	mov    %esp,%ebp
 104:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
 107:	8b 45 08             	mov    0x8(%ebp),%eax
 10a:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 10d:	90                   	nop
 10e:	8b 45 0c             	mov    0xc(%ebp),%eax
 111:	0f b6 10             	movzbl (%eax),%edx
 114:	8b 45 08             	mov    0x8(%ebp),%eax
 117:	88 10                	mov    %dl,(%eax)
 119:	8b 45 08             	mov    0x8(%ebp),%eax
 11c:	0f b6 00             	movzbl (%eax),%eax
 11f:	84 c0                	test   %al,%al
 121:	0f 95 c0             	setne  %al
 124:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 128:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
 12c:	84 c0                	test   %al,%al
 12e:	75 de                	jne    10e <strcpy+0xd>
    ;
  return os;
 130:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 133:	c9                   	leave  
 134:	c3                   	ret    

00000135 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 135:	55                   	push   %ebp
 136:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 138:	eb 08                	jmp    142 <strcmp+0xd>
    p++, q++;
 13a:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 13e:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 142:	8b 45 08             	mov    0x8(%ebp),%eax
 145:	0f b6 00             	movzbl (%eax),%eax
 148:	84 c0                	test   %al,%al
 14a:	74 10                	je     15c <strcmp+0x27>
 14c:	8b 45 08             	mov    0x8(%ebp),%eax
 14f:	0f b6 10             	movzbl (%eax),%edx
 152:	8b 45 0c             	mov    0xc(%ebp),%eax
 155:	0f b6 00             	movzbl (%eax),%eax
 158:	38 c2                	cmp    %al,%dl
 15a:	74 de                	je     13a <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 15c:	8b 45 08             	mov    0x8(%ebp),%eax
 15f:	0f b6 00             	movzbl (%eax),%eax
 162:	0f b6 d0             	movzbl %al,%edx
 165:	8b 45 0c             	mov    0xc(%ebp),%eax
 168:	0f b6 00             	movzbl (%eax),%eax
 16b:	0f b6 c0             	movzbl %al,%eax
 16e:	89 d1                	mov    %edx,%ecx
 170:	29 c1                	sub    %eax,%ecx
 172:	89 c8                	mov    %ecx,%eax
}
 174:	5d                   	pop    %ebp
 175:	c3                   	ret    

00000176 <strlen>:

uint
strlen(char *s)
{
 176:	55                   	push   %ebp
 177:	89 e5                	mov    %esp,%ebp
 179:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 17c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 183:	eb 04                	jmp    189 <strlen+0x13>
 185:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 189:	8b 45 fc             	mov    -0x4(%ebp),%eax
 18c:	03 45 08             	add    0x8(%ebp),%eax
 18f:	0f b6 00             	movzbl (%eax),%eax
 192:	84 c0                	test   %al,%al
 194:	75 ef                	jne    185 <strlen+0xf>
    ;
  return n;
 196:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 199:	c9                   	leave  
 19a:	c3                   	ret    

0000019b <memset>:

void*
memset(void *dst, int c, uint n)
{
 19b:	55                   	push   %ebp
 19c:	89 e5                	mov    %esp,%ebp
 19e:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
 1a1:	8b 45 10             	mov    0x10(%ebp),%eax
 1a4:	89 44 24 08          	mov    %eax,0x8(%esp)
 1a8:	8b 45 0c             	mov    0xc(%ebp),%eax
 1ab:	89 44 24 04          	mov    %eax,0x4(%esp)
 1af:	8b 45 08             	mov    0x8(%ebp),%eax
 1b2:	89 04 24             	mov    %eax,(%esp)
 1b5:	e8 22 ff ff ff       	call   dc <stosb>
  return dst;
 1ba:	8b 45 08             	mov    0x8(%ebp),%eax
}
 1bd:	c9                   	leave  
 1be:	c3                   	ret    

000001bf <strchr>:

char*
strchr(const char *s, char c)
{
 1bf:	55                   	push   %ebp
 1c0:	89 e5                	mov    %esp,%ebp
 1c2:	83 ec 04             	sub    $0x4,%esp
 1c5:	8b 45 0c             	mov    0xc(%ebp),%eax
 1c8:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 1cb:	eb 14                	jmp    1e1 <strchr+0x22>
    if(*s == c)
 1cd:	8b 45 08             	mov    0x8(%ebp),%eax
 1d0:	0f b6 00             	movzbl (%eax),%eax
 1d3:	3a 45 fc             	cmp    -0x4(%ebp),%al
 1d6:	75 05                	jne    1dd <strchr+0x1e>
      return (char*)s;
 1d8:	8b 45 08             	mov    0x8(%ebp),%eax
 1db:	eb 13                	jmp    1f0 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 1dd:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 1e1:	8b 45 08             	mov    0x8(%ebp),%eax
 1e4:	0f b6 00             	movzbl (%eax),%eax
 1e7:	84 c0                	test   %al,%al
 1e9:	75 e2                	jne    1cd <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 1eb:	b8 00 00 00 00       	mov    $0x0,%eax
}
 1f0:	c9                   	leave  
 1f1:	c3                   	ret    

000001f2 <gets>:

char*
gets(char *buf, int max)
{
 1f2:	55                   	push   %ebp
 1f3:	89 e5                	mov    %esp,%ebp
 1f5:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1f8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 1ff:	eb 44                	jmp    245 <gets+0x53>
    cc = read(0, &c, 1);
 201:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 208:	00 
 209:	8d 45 ef             	lea    -0x11(%ebp),%eax
 20c:	89 44 24 04          	mov    %eax,0x4(%esp)
 210:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 217:	e8 3c 01 00 00       	call   358 <read>
 21c:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 21f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 223:	7e 2d                	jle    252 <gets+0x60>
      break;
    buf[i++] = c;
 225:	8b 45 f4             	mov    -0xc(%ebp),%eax
 228:	03 45 08             	add    0x8(%ebp),%eax
 22b:	0f b6 55 ef          	movzbl -0x11(%ebp),%edx
 22f:	88 10                	mov    %dl,(%eax)
 231:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    if(c == '\n' || c == '\r')
 235:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 239:	3c 0a                	cmp    $0xa,%al
 23b:	74 16                	je     253 <gets+0x61>
 23d:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 241:	3c 0d                	cmp    $0xd,%al
 243:	74 0e                	je     253 <gets+0x61>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 245:	8b 45 f4             	mov    -0xc(%ebp),%eax
 248:	83 c0 01             	add    $0x1,%eax
 24b:	3b 45 0c             	cmp    0xc(%ebp),%eax
 24e:	7c b1                	jl     201 <gets+0xf>
 250:	eb 01                	jmp    253 <gets+0x61>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
 252:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 253:	8b 45 f4             	mov    -0xc(%ebp),%eax
 256:	03 45 08             	add    0x8(%ebp),%eax
 259:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 25c:	8b 45 08             	mov    0x8(%ebp),%eax
}
 25f:	c9                   	leave  
 260:	c3                   	ret    

00000261 <stat>:

int
stat(char *n, struct stat *st)
{
 261:	55                   	push   %ebp
 262:	89 e5                	mov    %esp,%ebp
 264:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 267:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 26e:	00 
 26f:	8b 45 08             	mov    0x8(%ebp),%eax
 272:	89 04 24             	mov    %eax,(%esp)
 275:	e8 06 01 00 00       	call   380 <open>
 27a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 27d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 281:	79 07                	jns    28a <stat+0x29>
    return -1;
 283:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 288:	eb 23                	jmp    2ad <stat+0x4c>
  r = fstat(fd, st);
 28a:	8b 45 0c             	mov    0xc(%ebp),%eax
 28d:	89 44 24 04          	mov    %eax,0x4(%esp)
 291:	8b 45 f4             	mov    -0xc(%ebp),%eax
 294:	89 04 24             	mov    %eax,(%esp)
 297:	e8 fc 00 00 00       	call   398 <fstat>
 29c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 29f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 2a2:	89 04 24             	mov    %eax,(%esp)
 2a5:	e8 be 00 00 00       	call   368 <close>
  return r;
 2aa:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 2ad:	c9                   	leave  
 2ae:	c3                   	ret    

000002af <atoi>:

int
atoi(const char *s)
{
 2af:	55                   	push   %ebp
 2b0:	89 e5                	mov    %esp,%ebp
 2b2:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 2b5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 2bc:	eb 23                	jmp    2e1 <atoi+0x32>
    n = n*10 + *s++ - '0';
 2be:	8b 55 fc             	mov    -0x4(%ebp),%edx
 2c1:	89 d0                	mov    %edx,%eax
 2c3:	c1 e0 02             	shl    $0x2,%eax
 2c6:	01 d0                	add    %edx,%eax
 2c8:	01 c0                	add    %eax,%eax
 2ca:	89 c2                	mov    %eax,%edx
 2cc:	8b 45 08             	mov    0x8(%ebp),%eax
 2cf:	0f b6 00             	movzbl (%eax),%eax
 2d2:	0f be c0             	movsbl %al,%eax
 2d5:	01 d0                	add    %edx,%eax
 2d7:	83 e8 30             	sub    $0x30,%eax
 2da:	89 45 fc             	mov    %eax,-0x4(%ebp)
 2dd:	83 45 08 01          	addl   $0x1,0x8(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2e1:	8b 45 08             	mov    0x8(%ebp),%eax
 2e4:	0f b6 00             	movzbl (%eax),%eax
 2e7:	3c 2f                	cmp    $0x2f,%al
 2e9:	7e 0a                	jle    2f5 <atoi+0x46>
 2eb:	8b 45 08             	mov    0x8(%ebp),%eax
 2ee:	0f b6 00             	movzbl (%eax),%eax
 2f1:	3c 39                	cmp    $0x39,%al
 2f3:	7e c9                	jle    2be <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 2f5:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 2f8:	c9                   	leave  
 2f9:	c3                   	ret    

000002fa <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 2fa:	55                   	push   %ebp
 2fb:	89 e5                	mov    %esp,%ebp
 2fd:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 300:	8b 45 08             	mov    0x8(%ebp),%eax
 303:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 306:	8b 45 0c             	mov    0xc(%ebp),%eax
 309:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 30c:	eb 13                	jmp    321 <memmove+0x27>
    *dst++ = *src++;
 30e:	8b 45 f8             	mov    -0x8(%ebp),%eax
 311:	0f b6 10             	movzbl (%eax),%edx
 314:	8b 45 fc             	mov    -0x4(%ebp),%eax
 317:	88 10                	mov    %dl,(%eax)
 319:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 31d:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 321:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
 325:	0f 9f c0             	setg   %al
 328:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
 32c:	84 c0                	test   %al,%al
 32e:	75 de                	jne    30e <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 330:	8b 45 08             	mov    0x8(%ebp),%eax
}
 333:	c9                   	leave  
 334:	c3                   	ret    
 335:	90                   	nop
 336:	90                   	nop
 337:	90                   	nop

00000338 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 338:	b8 01 00 00 00       	mov    $0x1,%eax
 33d:	cd 40                	int    $0x40
 33f:	c3                   	ret    

00000340 <exit>:
SYSCALL(exit)
 340:	b8 02 00 00 00       	mov    $0x2,%eax
 345:	cd 40                	int    $0x40
 347:	c3                   	ret    

00000348 <wait>:
SYSCALL(wait)
 348:	b8 03 00 00 00       	mov    $0x3,%eax
 34d:	cd 40                	int    $0x40
 34f:	c3                   	ret    

00000350 <pipe>:
SYSCALL(pipe)
 350:	b8 04 00 00 00       	mov    $0x4,%eax
 355:	cd 40                	int    $0x40
 357:	c3                   	ret    

00000358 <read>:
SYSCALL(read)
 358:	b8 05 00 00 00       	mov    $0x5,%eax
 35d:	cd 40                	int    $0x40
 35f:	c3                   	ret    

00000360 <write>:
SYSCALL(write)
 360:	b8 10 00 00 00       	mov    $0x10,%eax
 365:	cd 40                	int    $0x40
 367:	c3                   	ret    

00000368 <close>:
SYSCALL(close)
 368:	b8 15 00 00 00       	mov    $0x15,%eax
 36d:	cd 40                	int    $0x40
 36f:	c3                   	ret    

00000370 <kill>:
SYSCALL(kill)
 370:	b8 06 00 00 00       	mov    $0x6,%eax
 375:	cd 40                	int    $0x40
 377:	c3                   	ret    

00000378 <exec>:
SYSCALL(exec)
 378:	b8 07 00 00 00       	mov    $0x7,%eax
 37d:	cd 40                	int    $0x40
 37f:	c3                   	ret    

00000380 <open>:
SYSCALL(open)
 380:	b8 0f 00 00 00       	mov    $0xf,%eax
 385:	cd 40                	int    $0x40
 387:	c3                   	ret    

00000388 <mknod>:
SYSCALL(mknod)
 388:	b8 11 00 00 00       	mov    $0x11,%eax
 38d:	cd 40                	int    $0x40
 38f:	c3                   	ret    

00000390 <unlink>:
SYSCALL(unlink)
 390:	b8 12 00 00 00       	mov    $0x12,%eax
 395:	cd 40                	int    $0x40
 397:	c3                   	ret    

00000398 <fstat>:
SYSCALL(fstat)
 398:	b8 08 00 00 00       	mov    $0x8,%eax
 39d:	cd 40                	int    $0x40
 39f:	c3                   	ret    

000003a0 <link>:
SYSCALL(link)
 3a0:	b8 13 00 00 00       	mov    $0x13,%eax
 3a5:	cd 40                	int    $0x40
 3a7:	c3                   	ret    

000003a8 <mkdir>:
SYSCALL(mkdir)
 3a8:	b8 14 00 00 00       	mov    $0x14,%eax
 3ad:	cd 40                	int    $0x40
 3af:	c3                   	ret    

000003b0 <chdir>:
SYSCALL(chdir)
 3b0:	b8 09 00 00 00       	mov    $0x9,%eax
 3b5:	cd 40                	int    $0x40
 3b7:	c3                   	ret    

000003b8 <dup>:
SYSCALL(dup)
 3b8:	b8 0a 00 00 00       	mov    $0xa,%eax
 3bd:	cd 40                	int    $0x40
 3bf:	c3                   	ret    

000003c0 <getpid>:
SYSCALL(getpid)
 3c0:	b8 0b 00 00 00       	mov    $0xb,%eax
 3c5:	cd 40                	int    $0x40
 3c7:	c3                   	ret    

000003c8 <sbrk>:
SYSCALL(sbrk)
 3c8:	b8 0c 00 00 00       	mov    $0xc,%eax
 3cd:	cd 40                	int    $0x40
 3cf:	c3                   	ret    

000003d0 <sleep>:
SYSCALL(sleep)
 3d0:	b8 0d 00 00 00       	mov    $0xd,%eax
 3d5:	cd 40                	int    $0x40
 3d7:	c3                   	ret    

000003d8 <uptime>:
SYSCALL(uptime)
 3d8:	b8 0e 00 00 00       	mov    $0xe,%eax
 3dd:	cd 40                	int    $0x40
 3df:	c3                   	ret    

000003e0 <add_path>:
SYSCALL(add_path)
 3e0:	b8 16 00 00 00       	mov    $0x16,%eax
 3e5:	cd 40                	int    $0x40
 3e7:	c3                   	ret    

000003e8 <wait2>:
SYSCALL(wait2)
 3e8:	b8 17 00 00 00       	mov    $0x17,%eax
 3ed:	cd 40                	int    $0x40
 3ef:	c3                   	ret    

000003f0 <getquanta>:
SYSCALL(getquanta)
 3f0:	b8 18 00 00 00       	mov    $0x18,%eax
 3f5:	cd 40                	int    $0x40
 3f7:	c3                   	ret    

000003f8 <getqueue>:
SYSCALL(getqueue)
 3f8:	b8 19 00 00 00       	mov    $0x19,%eax
 3fd:	cd 40                	int    $0x40
 3ff:	c3                   	ret    

00000400 <signal>:
SYSCALL(signal)
 400:	b8 1a 00 00 00       	mov    $0x1a,%eax
 405:	cd 40                	int    $0x40
 407:	c3                   	ret    

00000408 <sigsend>:
SYSCALL(sigsend)
 408:	b8 1b 00 00 00       	mov    $0x1b,%eax
 40d:	cd 40                	int    $0x40
 40f:	c3                   	ret    

00000410 <alarm>:
SYSCALL(alarm)
 410:	b8 1c 00 00 00       	mov    $0x1c,%eax
 415:	cd 40                	int    $0x40
 417:	c3                   	ret    

00000418 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 418:	55                   	push   %ebp
 419:	89 e5                	mov    %esp,%ebp
 41b:	83 ec 28             	sub    $0x28,%esp
 41e:	8b 45 0c             	mov    0xc(%ebp),%eax
 421:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 424:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 42b:	00 
 42c:	8d 45 f4             	lea    -0xc(%ebp),%eax
 42f:	89 44 24 04          	mov    %eax,0x4(%esp)
 433:	8b 45 08             	mov    0x8(%ebp),%eax
 436:	89 04 24             	mov    %eax,(%esp)
 439:	e8 22 ff ff ff       	call   360 <write>
}
 43e:	c9                   	leave  
 43f:	c3                   	ret    

00000440 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 440:	55                   	push   %ebp
 441:	89 e5                	mov    %esp,%ebp
 443:	83 ec 48             	sub    $0x48,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 446:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 44d:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 451:	74 17                	je     46a <printint+0x2a>
 453:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 457:	79 11                	jns    46a <printint+0x2a>
    neg = 1;
 459:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 460:	8b 45 0c             	mov    0xc(%ebp),%eax
 463:	f7 d8                	neg    %eax
 465:	89 45 ec             	mov    %eax,-0x14(%ebp)
 468:	eb 06                	jmp    470 <printint+0x30>
  } else {
    x = xx;
 46a:	8b 45 0c             	mov    0xc(%ebp),%eax
 46d:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 470:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 477:	8b 4d 10             	mov    0x10(%ebp),%ecx
 47a:	8b 45 ec             	mov    -0x14(%ebp),%eax
 47d:	ba 00 00 00 00       	mov    $0x0,%edx
 482:	f7 f1                	div    %ecx
 484:	89 d0                	mov    %edx,%eax
 486:	0f b6 90 a0 11 00 00 	movzbl 0x11a0(%eax),%edx
 48d:	8d 45 dc             	lea    -0x24(%ebp),%eax
 490:	03 45 f4             	add    -0xc(%ebp),%eax
 493:	88 10                	mov    %dl,(%eax)
 495:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  }while((x /= base) != 0);
 499:	8b 55 10             	mov    0x10(%ebp),%edx
 49c:	89 55 d4             	mov    %edx,-0x2c(%ebp)
 49f:	8b 45 ec             	mov    -0x14(%ebp),%eax
 4a2:	ba 00 00 00 00       	mov    $0x0,%edx
 4a7:	f7 75 d4             	divl   -0x2c(%ebp)
 4aa:	89 45 ec             	mov    %eax,-0x14(%ebp)
 4ad:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 4b1:	75 c4                	jne    477 <printint+0x37>
  if(neg)
 4b3:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 4b7:	74 2a                	je     4e3 <printint+0xa3>
    buf[i++] = '-';
 4b9:	8d 45 dc             	lea    -0x24(%ebp),%eax
 4bc:	03 45 f4             	add    -0xc(%ebp),%eax
 4bf:	c6 00 2d             	movb   $0x2d,(%eax)
 4c2:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)

  while(--i >= 0)
 4c6:	eb 1b                	jmp    4e3 <printint+0xa3>
    putc(fd, buf[i]);
 4c8:	8d 45 dc             	lea    -0x24(%ebp),%eax
 4cb:	03 45 f4             	add    -0xc(%ebp),%eax
 4ce:	0f b6 00             	movzbl (%eax),%eax
 4d1:	0f be c0             	movsbl %al,%eax
 4d4:	89 44 24 04          	mov    %eax,0x4(%esp)
 4d8:	8b 45 08             	mov    0x8(%ebp),%eax
 4db:	89 04 24             	mov    %eax,(%esp)
 4de:	e8 35 ff ff ff       	call   418 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 4e3:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 4e7:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 4eb:	79 db                	jns    4c8 <printint+0x88>
    putc(fd, buf[i]);
}
 4ed:	c9                   	leave  
 4ee:	c3                   	ret    

000004ef <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 4ef:	55                   	push   %ebp
 4f0:	89 e5                	mov    %esp,%ebp
 4f2:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 4f5:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 4fc:	8d 45 0c             	lea    0xc(%ebp),%eax
 4ff:	83 c0 04             	add    $0x4,%eax
 502:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 505:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 50c:	e9 7d 01 00 00       	jmp    68e <printf+0x19f>
    c = fmt[i] & 0xff;
 511:	8b 55 0c             	mov    0xc(%ebp),%edx
 514:	8b 45 f0             	mov    -0x10(%ebp),%eax
 517:	01 d0                	add    %edx,%eax
 519:	0f b6 00             	movzbl (%eax),%eax
 51c:	0f be c0             	movsbl %al,%eax
 51f:	25 ff 00 00 00       	and    $0xff,%eax
 524:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 527:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 52b:	75 2c                	jne    559 <printf+0x6a>
      if(c == '%'){
 52d:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 531:	75 0c                	jne    53f <printf+0x50>
        state = '%';
 533:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 53a:	e9 4b 01 00 00       	jmp    68a <printf+0x19b>
      } else {
        putc(fd, c);
 53f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 542:	0f be c0             	movsbl %al,%eax
 545:	89 44 24 04          	mov    %eax,0x4(%esp)
 549:	8b 45 08             	mov    0x8(%ebp),%eax
 54c:	89 04 24             	mov    %eax,(%esp)
 54f:	e8 c4 fe ff ff       	call   418 <putc>
 554:	e9 31 01 00 00       	jmp    68a <printf+0x19b>
      }
    } else if(state == '%'){
 559:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 55d:	0f 85 27 01 00 00    	jne    68a <printf+0x19b>
      if(c == 'd'){
 563:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 567:	75 2d                	jne    596 <printf+0xa7>
        printint(fd, *ap, 10, 1);
 569:	8b 45 e8             	mov    -0x18(%ebp),%eax
 56c:	8b 00                	mov    (%eax),%eax
 56e:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
 575:	00 
 576:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
 57d:	00 
 57e:	89 44 24 04          	mov    %eax,0x4(%esp)
 582:	8b 45 08             	mov    0x8(%ebp),%eax
 585:	89 04 24             	mov    %eax,(%esp)
 588:	e8 b3 fe ff ff       	call   440 <printint>
        ap++;
 58d:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 591:	e9 ed 00 00 00       	jmp    683 <printf+0x194>
      } else if(c == 'x' || c == 'p'){
 596:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 59a:	74 06                	je     5a2 <printf+0xb3>
 59c:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 5a0:	75 2d                	jne    5cf <printf+0xe0>
        printint(fd, *ap, 16, 0);
 5a2:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5a5:	8b 00                	mov    (%eax),%eax
 5a7:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 5ae:	00 
 5af:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 5b6:	00 
 5b7:	89 44 24 04          	mov    %eax,0x4(%esp)
 5bb:	8b 45 08             	mov    0x8(%ebp),%eax
 5be:	89 04 24             	mov    %eax,(%esp)
 5c1:	e8 7a fe ff ff       	call   440 <printint>
        ap++;
 5c6:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 5ca:	e9 b4 00 00 00       	jmp    683 <printf+0x194>
      } else if(c == 's'){
 5cf:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 5d3:	75 46                	jne    61b <printf+0x12c>
        s = (char*)*ap;
 5d5:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5d8:	8b 00                	mov    (%eax),%eax
 5da:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 5dd:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 5e1:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 5e5:	75 27                	jne    60e <printf+0x11f>
          s = "(null)";
 5e7:	c7 45 f4 c9 0d 00 00 	movl   $0xdc9,-0xc(%ebp)
        while(*s != 0){
 5ee:	eb 1e                	jmp    60e <printf+0x11f>
          putc(fd, *s);
 5f0:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5f3:	0f b6 00             	movzbl (%eax),%eax
 5f6:	0f be c0             	movsbl %al,%eax
 5f9:	89 44 24 04          	mov    %eax,0x4(%esp)
 5fd:	8b 45 08             	mov    0x8(%ebp),%eax
 600:	89 04 24             	mov    %eax,(%esp)
 603:	e8 10 fe ff ff       	call   418 <putc>
          s++;
 608:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 60c:	eb 01                	jmp    60f <printf+0x120>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 60e:	90                   	nop
 60f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 612:	0f b6 00             	movzbl (%eax),%eax
 615:	84 c0                	test   %al,%al
 617:	75 d7                	jne    5f0 <printf+0x101>
 619:	eb 68                	jmp    683 <printf+0x194>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 61b:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 61f:	75 1d                	jne    63e <printf+0x14f>
        putc(fd, *ap);
 621:	8b 45 e8             	mov    -0x18(%ebp),%eax
 624:	8b 00                	mov    (%eax),%eax
 626:	0f be c0             	movsbl %al,%eax
 629:	89 44 24 04          	mov    %eax,0x4(%esp)
 62d:	8b 45 08             	mov    0x8(%ebp),%eax
 630:	89 04 24             	mov    %eax,(%esp)
 633:	e8 e0 fd ff ff       	call   418 <putc>
        ap++;
 638:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 63c:	eb 45                	jmp    683 <printf+0x194>
      } else if(c == '%'){
 63e:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 642:	75 17                	jne    65b <printf+0x16c>
        putc(fd, c);
 644:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 647:	0f be c0             	movsbl %al,%eax
 64a:	89 44 24 04          	mov    %eax,0x4(%esp)
 64e:	8b 45 08             	mov    0x8(%ebp),%eax
 651:	89 04 24             	mov    %eax,(%esp)
 654:	e8 bf fd ff ff       	call   418 <putc>
 659:	eb 28                	jmp    683 <printf+0x194>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 65b:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
 662:	00 
 663:	8b 45 08             	mov    0x8(%ebp),%eax
 666:	89 04 24             	mov    %eax,(%esp)
 669:	e8 aa fd ff ff       	call   418 <putc>
        putc(fd, c);
 66e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 671:	0f be c0             	movsbl %al,%eax
 674:	89 44 24 04          	mov    %eax,0x4(%esp)
 678:	8b 45 08             	mov    0x8(%ebp),%eax
 67b:	89 04 24             	mov    %eax,(%esp)
 67e:	e8 95 fd ff ff       	call   418 <putc>
      }
      state = 0;
 683:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 68a:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 68e:	8b 55 0c             	mov    0xc(%ebp),%edx
 691:	8b 45 f0             	mov    -0x10(%ebp),%eax
 694:	01 d0                	add    %edx,%eax
 696:	0f b6 00             	movzbl (%eax),%eax
 699:	84 c0                	test   %al,%al
 69b:	0f 85 70 fe ff ff    	jne    511 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 6a1:	c9                   	leave  
 6a2:	c3                   	ret    
 6a3:	90                   	nop

000006a4 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 6a4:	55                   	push   %ebp
 6a5:	89 e5                	mov    %esp,%ebp
 6a7:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 6aa:	8b 45 08             	mov    0x8(%ebp),%eax
 6ad:	83 e8 08             	sub    $0x8,%eax
 6b0:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6b3:	a1 c8 11 00 00       	mov    0x11c8,%eax
 6b8:	89 45 fc             	mov    %eax,-0x4(%ebp)
 6bb:	eb 24                	jmp    6e1 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6bd:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6c0:	8b 00                	mov    (%eax),%eax
 6c2:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 6c5:	77 12                	ja     6d9 <free+0x35>
 6c7:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6ca:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 6cd:	77 24                	ja     6f3 <free+0x4f>
 6cf:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6d2:	8b 00                	mov    (%eax),%eax
 6d4:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 6d7:	77 1a                	ja     6f3 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6d9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6dc:	8b 00                	mov    (%eax),%eax
 6de:	89 45 fc             	mov    %eax,-0x4(%ebp)
 6e1:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6e4:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 6e7:	76 d4                	jbe    6bd <free+0x19>
 6e9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6ec:	8b 00                	mov    (%eax),%eax
 6ee:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 6f1:	76 ca                	jbe    6bd <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 6f3:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6f6:	8b 40 04             	mov    0x4(%eax),%eax
 6f9:	c1 e0 03             	shl    $0x3,%eax
 6fc:	89 c2                	mov    %eax,%edx
 6fe:	03 55 f8             	add    -0x8(%ebp),%edx
 701:	8b 45 fc             	mov    -0x4(%ebp),%eax
 704:	8b 00                	mov    (%eax),%eax
 706:	39 c2                	cmp    %eax,%edx
 708:	75 24                	jne    72e <free+0x8a>
    bp->s.size += p->s.ptr->s.size;
 70a:	8b 45 f8             	mov    -0x8(%ebp),%eax
 70d:	8b 50 04             	mov    0x4(%eax),%edx
 710:	8b 45 fc             	mov    -0x4(%ebp),%eax
 713:	8b 00                	mov    (%eax),%eax
 715:	8b 40 04             	mov    0x4(%eax),%eax
 718:	01 c2                	add    %eax,%edx
 71a:	8b 45 f8             	mov    -0x8(%ebp),%eax
 71d:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 720:	8b 45 fc             	mov    -0x4(%ebp),%eax
 723:	8b 00                	mov    (%eax),%eax
 725:	8b 10                	mov    (%eax),%edx
 727:	8b 45 f8             	mov    -0x8(%ebp),%eax
 72a:	89 10                	mov    %edx,(%eax)
 72c:	eb 0a                	jmp    738 <free+0x94>
  } else
    bp->s.ptr = p->s.ptr;
 72e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 731:	8b 10                	mov    (%eax),%edx
 733:	8b 45 f8             	mov    -0x8(%ebp),%eax
 736:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 738:	8b 45 fc             	mov    -0x4(%ebp),%eax
 73b:	8b 40 04             	mov    0x4(%eax),%eax
 73e:	c1 e0 03             	shl    $0x3,%eax
 741:	03 45 fc             	add    -0x4(%ebp),%eax
 744:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 747:	75 20                	jne    769 <free+0xc5>
    p->s.size += bp->s.size;
 749:	8b 45 fc             	mov    -0x4(%ebp),%eax
 74c:	8b 50 04             	mov    0x4(%eax),%edx
 74f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 752:	8b 40 04             	mov    0x4(%eax),%eax
 755:	01 c2                	add    %eax,%edx
 757:	8b 45 fc             	mov    -0x4(%ebp),%eax
 75a:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 75d:	8b 45 f8             	mov    -0x8(%ebp),%eax
 760:	8b 10                	mov    (%eax),%edx
 762:	8b 45 fc             	mov    -0x4(%ebp),%eax
 765:	89 10                	mov    %edx,(%eax)
 767:	eb 08                	jmp    771 <free+0xcd>
  } else
    p->s.ptr = bp;
 769:	8b 45 fc             	mov    -0x4(%ebp),%eax
 76c:	8b 55 f8             	mov    -0x8(%ebp),%edx
 76f:	89 10                	mov    %edx,(%eax)
  freep = p;
 771:	8b 45 fc             	mov    -0x4(%ebp),%eax
 774:	a3 c8 11 00 00       	mov    %eax,0x11c8
}
 779:	c9                   	leave  
 77a:	c3                   	ret    

0000077b <morecore>:

static Header*
morecore(uint nu)
{
 77b:	55                   	push   %ebp
 77c:	89 e5                	mov    %esp,%ebp
 77e:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 781:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 788:	77 07                	ja     791 <morecore+0x16>
    nu = 4096;
 78a:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 791:	8b 45 08             	mov    0x8(%ebp),%eax
 794:	c1 e0 03             	shl    $0x3,%eax
 797:	89 04 24             	mov    %eax,(%esp)
 79a:	e8 29 fc ff ff       	call   3c8 <sbrk>
 79f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 7a2:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 7a6:	75 07                	jne    7af <morecore+0x34>
    return 0;
 7a8:	b8 00 00 00 00       	mov    $0x0,%eax
 7ad:	eb 22                	jmp    7d1 <morecore+0x56>
  hp = (Header*)p;
 7af:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7b2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 7b5:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7b8:	8b 55 08             	mov    0x8(%ebp),%edx
 7bb:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 7be:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7c1:	83 c0 08             	add    $0x8,%eax
 7c4:	89 04 24             	mov    %eax,(%esp)
 7c7:	e8 d8 fe ff ff       	call   6a4 <free>
  return freep;
 7cc:	a1 c8 11 00 00       	mov    0x11c8,%eax
}
 7d1:	c9                   	leave  
 7d2:	c3                   	ret    

000007d3 <malloc>:

void*
malloc(uint nbytes)
{
 7d3:	55                   	push   %ebp
 7d4:	89 e5                	mov    %esp,%ebp
 7d6:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7d9:	8b 45 08             	mov    0x8(%ebp),%eax
 7dc:	83 c0 07             	add    $0x7,%eax
 7df:	c1 e8 03             	shr    $0x3,%eax
 7e2:	83 c0 01             	add    $0x1,%eax
 7e5:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 7e8:	a1 c8 11 00 00       	mov    0x11c8,%eax
 7ed:	89 45 f0             	mov    %eax,-0x10(%ebp)
 7f0:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 7f4:	75 23                	jne    819 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 7f6:	c7 45 f0 c0 11 00 00 	movl   $0x11c0,-0x10(%ebp)
 7fd:	8b 45 f0             	mov    -0x10(%ebp),%eax
 800:	a3 c8 11 00 00       	mov    %eax,0x11c8
 805:	a1 c8 11 00 00       	mov    0x11c8,%eax
 80a:	a3 c0 11 00 00       	mov    %eax,0x11c0
    base.s.size = 0;
 80f:	c7 05 c4 11 00 00 00 	movl   $0x0,0x11c4
 816:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 819:	8b 45 f0             	mov    -0x10(%ebp),%eax
 81c:	8b 00                	mov    (%eax),%eax
 81e:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 821:	8b 45 f4             	mov    -0xc(%ebp),%eax
 824:	8b 40 04             	mov    0x4(%eax),%eax
 827:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 82a:	72 4d                	jb     879 <malloc+0xa6>
      if(p->s.size == nunits)
 82c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 82f:	8b 40 04             	mov    0x4(%eax),%eax
 832:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 835:	75 0c                	jne    843 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 837:	8b 45 f4             	mov    -0xc(%ebp),%eax
 83a:	8b 10                	mov    (%eax),%edx
 83c:	8b 45 f0             	mov    -0x10(%ebp),%eax
 83f:	89 10                	mov    %edx,(%eax)
 841:	eb 26                	jmp    869 <malloc+0x96>
      else {
        p->s.size -= nunits;
 843:	8b 45 f4             	mov    -0xc(%ebp),%eax
 846:	8b 40 04             	mov    0x4(%eax),%eax
 849:	89 c2                	mov    %eax,%edx
 84b:	2b 55 ec             	sub    -0x14(%ebp),%edx
 84e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 851:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 854:	8b 45 f4             	mov    -0xc(%ebp),%eax
 857:	8b 40 04             	mov    0x4(%eax),%eax
 85a:	c1 e0 03             	shl    $0x3,%eax
 85d:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 860:	8b 45 f4             	mov    -0xc(%ebp),%eax
 863:	8b 55 ec             	mov    -0x14(%ebp),%edx
 866:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 869:	8b 45 f0             	mov    -0x10(%ebp),%eax
 86c:	a3 c8 11 00 00       	mov    %eax,0x11c8
      return (void*)(p + 1);
 871:	8b 45 f4             	mov    -0xc(%ebp),%eax
 874:	83 c0 08             	add    $0x8,%eax
 877:	eb 38                	jmp    8b1 <malloc+0xde>
    }
    if(p == freep)
 879:	a1 c8 11 00 00       	mov    0x11c8,%eax
 87e:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 881:	75 1b                	jne    89e <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
 883:	8b 45 ec             	mov    -0x14(%ebp),%eax
 886:	89 04 24             	mov    %eax,(%esp)
 889:	e8 ed fe ff ff       	call   77b <morecore>
 88e:	89 45 f4             	mov    %eax,-0xc(%ebp)
 891:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 895:	75 07                	jne    89e <malloc+0xcb>
        return 0;
 897:	b8 00 00 00 00       	mov    $0x0,%eax
 89c:	eb 13                	jmp    8b1 <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 89e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8a1:	89 45 f0             	mov    %eax,-0x10(%ebp)
 8a4:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8a7:	8b 00                	mov    (%eax),%eax
 8a9:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 8ac:	e9 70 ff ff ff       	jmp    821 <malloc+0x4e>
}
 8b1:	c9                   	leave  
 8b2:	c3                   	ret    
 8b3:	90                   	nop

000008b4 <getNextThread>:
} tTable;


int
getNextThread(int j)
{
 8b4:	55                   	push   %ebp
 8b5:	89 e5                	mov    %esp,%ebp
 8b7:	83 ec 10             	sub    $0x10,%esp
  int i=j+1;
 8ba:	8b 45 08             	mov    0x8(%ebp),%eax
 8bd:	83 c0 01             	add    $0x1,%eax
 8c0:	89 45 fc             	mov    %eax,-0x4(%ebp)
  if(i==MAX_THREAD)
 8c3:	83 7d fc 40          	cmpl   $0x40,-0x4(%ebp)
 8c7:	75 07                	jne    8d0 <getNextThread+0x1c>
    i=0;
 8c9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  uthread_p t=&tTable.table[i];
 8d0:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8d3:	69 c0 18 01 00 00    	imul   $0x118,%eax,%eax
 8d9:	05 e0 11 00 00       	add    $0x11e0,%eax
 8de:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(i!=j)
 8e1:	eb 3b                	jmp    91e <getNextThread+0x6a>
  {
    if(t->state==T_RUNNABLE)
 8e3:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8e6:	8b 40 10             	mov    0x10(%eax),%eax
 8e9:	83 f8 03             	cmp    $0x3,%eax
 8ec:	75 05                	jne    8f3 <getNextThread+0x3f>
      return i;
 8ee:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8f1:	eb 38                	jmp    92b <getNextThread+0x77>
    i++;
 8f3:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    if(i==MAX_THREAD)
 8f7:	83 7d fc 40          	cmpl   $0x40,-0x4(%ebp)
 8fb:	75 1a                	jne    917 <getNextThread+0x63>
    {
       i=0;
 8fd:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
       t=&tTable.table[i];
 904:	8b 45 fc             	mov    -0x4(%ebp),%eax
 907:	69 c0 18 01 00 00    	imul   $0x118,%eax,%eax
 90d:	05 e0 11 00 00       	add    $0x11e0,%eax
 912:	89 45 f8             	mov    %eax,-0x8(%ebp)
 915:	eb 07                	jmp    91e <getNextThread+0x6a>
    }
    else
      t++;
 917:	81 45 f8 18 01 00 00 	addl   $0x118,-0x8(%ebp)
{
  int i=j+1;
  if(i==MAX_THREAD)
    i=0;
  uthread_p t=&tTable.table[i];
  while(i!=j)
 91e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 921:	3b 45 08             	cmp    0x8(%ebp),%eax
 924:	75 bd                	jne    8e3 <getNextThread+0x2f>
    }
    else
      t++;
    
  }
  return -1;
 926:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
 92b:	c9                   	leave  
 92c:	c3                   	ret    

0000092d <allocThread>:


static uthread_p
allocThread()
{
 92d:	55                   	push   %ebp
 92e:	89 e5                	mov    %esp,%ebp
 930:	83 ec 28             	sub    $0x28,%esp
  int i,j;
  uthread_p t;
  
  for (t=tTable.table,i=0 ; t <= &tTable.table[MAX_THREAD]; t++,i++)// <= should be < ??
 933:	c7 45 ec e0 11 00 00 	movl   $0x11e0,-0x14(%ebp)
 93a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 941:	eb 15                	jmp    958 <allocThread+0x2b>
  {
    if(t->state==T_FREE)
 943:	8b 45 ec             	mov    -0x14(%ebp),%eax
 946:	8b 40 10             	mov    0x10(%eax),%eax
 949:	85 c0                	test   %eax,%eax
 94b:	74 1e                	je     96b <allocThread+0x3e>
allocThread()
{
  int i,j;
  uthread_p t;
  
  for (t=tTable.table,i=0 ; t <= &tTable.table[MAX_THREAD]; t++,i++)// <= should be < ??
 94d:	81 45 ec 18 01 00 00 	addl   $0x118,-0x14(%ebp)
 954:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 958:	81 7d ec e0 57 00 00 	cmpl   $0x57e0,-0x14(%ebp)
 95f:	76 e2                	jbe    943 <allocThread+0x16>
  {
    if(t->state==T_FREE)
      goto found;
  }
  return 0;
 961:	b8 00 00 00 00       	mov    $0x0,%eax
 966:	e9 88 00 00 00       	jmp    9f3 <allocThread+0xc6>
  uthread_p t;
  
  for (t=tTable.table,i=0 ; t <= &tTable.table[MAX_THREAD]; t++,i++)// <= should be < ??
  {
    if(t->state==T_FREE)
      goto found;
 96b:	90                   	nop
  }
  return 0;
  
  found:
  
  t->tid=i;
 96c:	8b 45 ec             	mov    -0x14(%ebp),%eax
 96f:	8b 55 f4             	mov    -0xc(%ebp),%edx
 972:	89 10                	mov    %edx,(%eax)
  t->stack=(char*)malloc(STACK_SIZE);
 974:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
 97b:	e8 53 fe ff ff       	call   7d3 <malloc>
 980:	8b 55 ec             	mov    -0x14(%ebp),%edx
 983:	89 42 0c             	mov    %eax,0xc(%edx)
  t->esp=(int)t->stack;
 986:	8b 45 ec             	mov    -0x14(%ebp),%eax
 989:	8b 40 0c             	mov    0xc(%eax),%eax
 98c:	89 c2                	mov    %eax,%edx
 98e:	8b 45 ec             	mov    -0x14(%ebp),%eax
 991:	89 50 04             	mov    %edx,0x4(%eax)
  t->ebp=(int)t->stack;
 994:	8b 45 ec             	mov    -0x14(%ebp),%eax
 997:	8b 40 0c             	mov    0xc(%eax),%eax
 99a:	89 c2                	mov    %eax,%edx
 99c:	8b 45 ec             	mov    -0x14(%ebp),%eax
 99f:	89 50 08             	mov    %edx,0x8(%eax)
  t->firstTime=0;
 9a2:	8b 45 ec             	mov    -0x14(%ebp),%eax
 9a5:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
  for(j=0;j<64;j++)
 9ac:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 9b3:	eb 15                	jmp    9ca <allocThread+0x9d>
  {
    t->waiting[j]=-1;
 9b5:	8b 45 ec             	mov    -0x14(%ebp),%eax
 9b8:	8b 55 f0             	mov    -0x10(%ebp),%edx
 9bb:	83 c2 04             	add    $0x4,%edx
 9be:	c7 44 90 08 ff ff ff 	movl   $0xffffffff,0x8(%eax,%edx,4)
 9c5:	ff 
  t->tid=i;
  t->stack=(char*)malloc(STACK_SIZE);
  t->esp=(int)t->stack;
  t->ebp=(int)t->stack;
  t->firstTime=0;
  for(j=0;j<64;j++)
 9c6:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 9ca:	83 7d f0 3f          	cmpl   $0x3f,-0x10(%ebp)
 9ce:	7e e5                	jle    9b5 <allocThread+0x88>
  {
    t->waiting[j]=-1;
  }
  asm("movl %1,%%esp;" "push %2;" "movl %%esp,%0;" //pushes the uthread_exit func as return address
    : "=r" (t->esp) 
    : "r" (t->ebp) , "r"(uthread_exit)
 9d0:	8b 45 ec             	mov    -0x14(%ebp),%eax
 9d3:	8b 40 08             	mov    0x8(%eax),%eax
  t->firstTime=0;
  for(j=0;j<64;j++)
  {
    t->waiting[j]=-1;
  }
  asm("movl %1,%%esp;" "push %2;" "movl %%esp,%0;" //pushes the uthread_exit func as return address
 9d6:	ba f2 0a 00 00       	mov    $0xaf2,%edx
 9db:	89 c4                	mov    %eax,%esp
 9dd:	52                   	push   %edx
 9de:	89 e2                	mov    %esp,%edx
    : "=r" (t->esp) 
 9e0:	8b 45 ec             	mov    -0x14(%ebp),%eax
  t->firstTime=0;
  for(j=0;j<64;j++)
  {
    t->waiting[j]=-1;
  }
  asm("movl %1,%%esp;" "push %2;" "movl %%esp,%0;" //pushes the uthread_exit func as return address
 9e3:	89 50 04             	mov    %edx,0x4(%eax)
    : "=r" (t->esp) 
    : "r" (t->ebp) , "r"(uthread_exit)
  );
  t->state=T_UNINIT;
 9e6:	8b 45 ec             	mov    -0x14(%ebp),%eax
 9e9:	c7 40 10 01 00 00 00 	movl   $0x1,0x10(%eax)
  return t;
 9f0:	8b 45 ec             	mov    -0x14(%ebp),%eax
}
 9f3:	c9                   	leave  
 9f4:	c3                   	ret    

000009f5 <uthread_init>:

void 
uthread_init()
{  
 9f5:	55                   	push   %ebp
 9f6:	89 e5                	mov    %esp,%ebp
 9f8:	83 ec 28             	sub    $0x28,%esp
  tTable.length=0;
 9fb:	c7 05 e0 57 00 00 00 	movl   $0x0,0x57e0
 a02:	00 00 00 
  tTable.current=0;
 a05:	c7 05 e4 57 00 00 00 	movl   $0x0,0x57e4
 a0c:	00 00 00 
  uthread_p mainT = allocThread(); //needed to allocate the main thread !!!!!!
 a0f:	e8 19 ff ff ff       	call   92d <allocThread>
 a14:	89 45 f4             	mov    %eax,-0xc(%ebp)
  asm("movl %%ebp,%0;" "movl %%esp,%1;" //get current thread ebp and esp
 a17:	89 e9                	mov    %ebp,%ecx
 a19:	89 e2                	mov    %esp,%edx
    : "=r" (mainT->ebp) ,"=r"(mainT->esp)    
 a1b:	8b 45 f4             	mov    -0xc(%ebp),%eax
uthread_init()
{  
  tTable.length=0;
  tTable.current=0;
  uthread_p mainT = allocThread(); //needed to allocate the main thread !!!!!!
  asm("movl %%ebp,%0;" "movl %%esp,%1;" //get current thread ebp and esp
 a1e:	89 48 08             	mov    %ecx,0x8(%eax)
    : "=r" (mainT->ebp) ,"=r"(mainT->esp)    
 a21:	8b 45 f4             	mov    -0xc(%ebp),%eax
uthread_init()
{  
  tTable.length=0;
  tTable.current=0;
  uthread_p mainT = allocThread(); //needed to allocate the main thread !!!!!!
  asm("movl %%ebp,%0;" "movl %%esp,%1;" //get current thread ebp and esp
 a24:	89 50 04             	mov    %edx,0x4(%eax)
    : "=r" (mainT->ebp) ,"=r"(mainT->esp)    
  );
  /*moves stack to mainT's stack
  /stacks grow backwards so we start from esp and finsh at ebp*/
  memmove(mainT->stack , (void*)mainT->esp , mainT->ebp - mainT->esp);
 a27:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a2a:	8b 50 08             	mov    0x8(%eax),%edx
 a2d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a30:	8b 40 04             	mov    0x4(%eax),%eax
 a33:	89 d1                	mov    %edx,%ecx
 a35:	29 c1                	sub    %eax,%ecx
 a37:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a3a:	8b 40 04             	mov    0x4(%eax),%eax
 a3d:	89 c2                	mov    %eax,%edx
 a3f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a42:	8b 40 0c             	mov    0xc(%eax),%eax
 a45:	89 4c 24 08          	mov    %ecx,0x8(%esp)
 a49:	89 54 24 04          	mov    %edx,0x4(%esp)
 a4d:	89 04 24             	mov    %eax,(%esp)
 a50:	e8 a5 f8 ff ff       	call   2fa <memmove>
  mainT->state = T_RUNNABLE;
 a55:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a58:	c7 40 10 03 00 00 00 	movl   $0x3,0x10(%eax)
  currentThread=mainT;
 a5f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a62:	a3 e8 57 00 00       	mov    %eax,0x57e8
  if(signal(SIGALRM,uthread_yield)<0)
 a67:	c7 44 24 04 62 0c 00 	movl   $0xc62,0x4(%esp)
 a6e:	00 
 a6f:	c7 04 24 0e 00 00 00 	movl   $0xe,(%esp)
 a76:	e8 85 f9 ff ff       	call   400 <signal>
 a7b:	85 c0                	test   %eax,%eax
 a7d:	79 19                	jns    a98 <uthread_init+0xa3>
  {
    printf(1,"Cant register the alarm signal");
 a7f:	c7 44 24 04 d0 0d 00 	movl   $0xdd0,0x4(%esp)
 a86:	00 
 a87:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 a8e:	e8 5c fa ff ff       	call   4ef <printf>
    exit();
 a93:	e8 a8 f8 ff ff       	call   340 <exit>
  }
  if(alarm(THREAD_QUANTA)<0)
 a98:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
 a9f:	e8 6c f9 ff ff       	call   410 <alarm>
 aa4:	85 c0                	test   %eax,%eax
 aa6:	79 19                	jns    ac1 <uthread_init+0xcc>
  {
    printf(1,"Cant activate alarm system call");
 aa8:	c7 44 24 04 f0 0d 00 	movl   $0xdf0,0x4(%esp)
 aaf:	00 
 ab0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 ab7:	e8 33 fa ff ff       	call   4ef <printf>
    exit();
 abc:	e8 7f f8 ff ff       	call   340 <exit>
  }
  
}
 ac1:	c9                   	leave  
 ac2:	c3                   	ret    

00000ac3 <uthread_create>:

int  
uthread_create(void (*start_func)(void *), void* arg)
{
 ac3:	55                   	push   %ebp
 ac4:	89 e5                	mov    %esp,%ebp
 ac6:	83 ec 18             	sub    $0x18,%esp
  uthread_p t = allocThread();
 ac9:	e8 5f fe ff ff       	call   92d <allocThread>
 ace:	89 45 f4             	mov    %eax,-0xc(%ebp)
  
  asm("push %1;"  //stores the arguments to be used
 ad1:	8b 45 0c             	mov    0xc(%ebp),%eax
 ad4:	8b 55 08             	mov    0x8(%ebp),%edx
 ad7:	50                   	push   %eax
 ad8:	52                   	push   %edx
 ad9:	89 e2                	mov    %esp,%edx
      "push %2;"  //stores the start_func location
      "movl %%esp,%0;"
      : "=r" (t->esp)
 adb:	8b 45 f4             	mov    -0xc(%ebp),%eax
int  
uthread_create(void (*start_func)(void *), void* arg)
{
  uthread_p t = allocThread();
  
  asm("push %1;"  //stores the arguments to be used
 ade:	89 50 04             	mov    %edx,0x4(%eax)
      "push %2;"  //stores the start_func location
      "movl %%esp,%0;"
      : "=r" (t->esp)
      : "r" (arg) , "r"(start_func)
  );
  t->state= T_RUNNABLE;
 ae1:	8b 45 f4             	mov    -0xc(%ebp),%eax
 ae4:	c7 40 10 03 00 00 00 	movl   $0x3,0x10(%eax)
  
  return t->tid;
 aeb:	8b 45 f4             	mov    -0xc(%ebp),%eax
 aee:	8b 00                	mov    (%eax),%eax
}
 af0:	c9                   	leave  
 af1:	c3                   	ret    

00000af2 <uthread_exit>:

void 
uthread_exit()
{
 af2:	55                   	push   %ebp
 af3:	89 e5                	mov    %esp,%ebp
 af5:	83 ec 28             	sub    $0x28,%esp
  uthread_p newt;
  int old=currentThread->tid;
 af8:	a1 e8 57 00 00       	mov    0x57e8,%eax
 afd:	8b 00                	mov    (%eax),%eax
 aff:	89 45 f0             	mov    %eax,-0x10(%ebp)
  
  int i=0;
 b02:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  while(currentThread->waiting[i]!=-1)
 b09:	eb 25                	jmp    b30 <uthread_exit+0x3e>
  {
    (&tTable.table[currentThread->waiting[i]])->state=T_RUNNABLE;
 b0b:	a1 e8 57 00 00       	mov    0x57e8,%eax
 b10:	8b 55 f4             	mov    -0xc(%ebp),%edx
 b13:	83 c2 04             	add    $0x4,%edx
 b16:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
 b1a:	69 c0 18 01 00 00    	imul   $0x118,%eax,%eax
 b20:	05 e0 11 00 00       	add    $0x11e0,%eax
 b25:	c7 40 10 03 00 00 00 	movl   $0x3,0x10(%eax)
    i++;
 b2c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
{
  uthread_p newt;
  int old=currentThread->tid;
  
  int i=0;
  while(currentThread->waiting[i]!=-1)
 b30:	a1 e8 57 00 00       	mov    0x57e8,%eax
 b35:	8b 55 f4             	mov    -0xc(%ebp),%edx
 b38:	83 c2 04             	add    $0x4,%edx
 b3b:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
 b3f:	83 f8 ff             	cmp    $0xffffffff,%eax
 b42:	75 c7                	jne    b0b <uthread_exit+0x19>
  {
    (&tTable.table[currentThread->waiting[i]])->state=T_RUNNABLE;
    i++;
  }
  currentThread->tid=-1;
 b44:	a1 e8 57 00 00       	mov    0x57e8,%eax
 b49:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)
  currentThread->esp=-1;
 b4f:	a1 e8 57 00 00       	mov    0x57e8,%eax
 b54:	c7 40 04 ff ff ff ff 	movl   $0xffffffff,0x4(%eax)
  currentThread->ebp=-1;
 b5b:	a1 e8 57 00 00       	mov    0x57e8,%eax
 b60:	c7 40 08 ff ff ff ff 	movl   $0xffffffff,0x8(%eax)
  free(currentThread->stack);
 b67:	a1 e8 57 00 00       	mov    0x57e8,%eax
 b6c:	8b 40 0c             	mov    0xc(%eax),%eax
 b6f:	89 04 24             	mov    %eax,(%esp)
 b72:	e8 2d fb ff ff       	call   6a4 <free>
  currentThread->state=T_FREE;
 b77:	a1 e8 57 00 00       	mov    0x57e8,%eax
 b7c:	c7 40 10 00 00 00 00 	movl   $0x0,0x10(%eax)
  currentThread->firstTime=0;
 b83:	a1 e8 57 00 00       	mov    0x57e8,%eax
 b88:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
  int new=getNextThread(old);
 b8f:	8b 45 f0             	mov    -0x10(%ebp),%eax
 b92:	89 04 24             	mov    %eax,(%esp)
 b95:	e8 1a fd ff ff       	call   8b4 <getNextThread>
 b9a:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if(new>=0)
 b9d:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 ba1:	78 36                	js     bd9 <uthread_exit+0xe7>
          {
             newt=&tTable.table[new];
 ba3:	8b 45 ec             	mov    -0x14(%ebp),%eax
 ba6:	69 c0 18 01 00 00    	imul   $0x118,%eax,%eax
 bac:	05 e0 11 00 00       	add    $0x11e0,%eax
 bb1:	89 45 e8             	mov    %eax,-0x18(%ebp)
             newt->state=T_RUNNING;
 bb4:	8b 45 e8             	mov    -0x18(%ebp),%eax
 bb7:	c7 40 10 02 00 00 00 	movl   $0x2,0x10(%eax)
             LOAD_ESP(newt->esp);
 bbe:	8b 45 e8             	mov    -0x18(%ebp),%eax
 bc1:	8b 40 04             	mov    0x4(%eax),%eax
 bc4:	89 c4                	mov    %eax,%esp
             LOAD_EBP(newt->ebp);
 bc6:	8b 45 e8             	mov    -0x18(%ebp),%eax
 bc9:	8b 40 08             	mov    0x8(%eax),%eax
 bcc:	89 c5                	mov    %eax,%ebp
             asm("popa");
 bce:	61                   	popa   
             currentThread=newt;
 bcf:	8b 45 e8             	mov    -0x18(%ebp),%eax
 bd2:	a3 e8 57 00 00       	mov    %eax,0x57e8
        {/////what if some thread state is sleeping?
             
             exit();
        }
     
}
 bd7:	c9                   	leave  
 bd8:	c3                   	ret    
             currentThread=newt;
          }
        else
        {/////what if some thread state is sleeping?
             
             exit();
 bd9:	e8 62 f7 ff ff       	call   340 <exit>

00000bde <uthred_join>:
}


int
uthred_join(int tid)
{
 bde:	55                   	push   %ebp
 bdf:	89 e5                	mov    %esp,%ebp
 be1:	83 ec 18             	sub    $0x18,%esp
  if((&tTable.table[tid])->state==T_FREE)
 be4:	8b 45 08             	mov    0x8(%ebp),%eax
 be7:	69 c0 18 01 00 00    	imul   $0x118,%eax,%eax
 bed:	05 e0 11 00 00       	add    $0x11e0,%eax
 bf2:	8b 40 10             	mov    0x10(%eax),%eax
 bf5:	85 c0                	test   %eax,%eax
 bf7:	75 07                	jne    c00 <uthred_join+0x22>
    return -1;
 bf9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 bfe:	eb 60                	jmp    c60 <uthred_join+0x82>
  else
  {
      int i=0;
 c00:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
      while((&tTable.table[tid])->waiting[i]!=-1)
 c07:	eb 04                	jmp    c0d <uthred_join+0x2f>
        i++;
 c09:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  if((&tTable.table[tid])->state==T_FREE)
    return -1;
  else
  {
      int i=0;
      while((&tTable.table[tid])->waiting[i]!=-1)
 c0d:	8b 45 08             	mov    0x8(%ebp),%eax
 c10:	69 c0 18 01 00 00    	imul   $0x118,%eax,%eax
 c16:	05 e0 11 00 00       	add    $0x11e0,%eax
 c1b:	8b 55 f4             	mov    -0xc(%ebp),%edx
 c1e:	83 c2 04             	add    $0x4,%edx
 c21:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
 c25:	83 f8 ff             	cmp    $0xffffffff,%eax
 c28:	75 df                	jne    c09 <uthred_join+0x2b>
        i++;
      (&tTable.table[tid])->waiting[i]=currentThread->tid;
 c2a:	8b 45 08             	mov    0x8(%ebp),%eax
 c2d:	69 c0 18 01 00 00    	imul   $0x118,%eax,%eax
 c33:	8d 90 e0 11 00 00    	lea    0x11e0(%eax),%edx
 c39:	a1 e8 57 00 00       	mov    0x57e8,%eax
 c3e:	8b 00                	mov    (%eax),%eax
 c40:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 c43:	83 c1 04             	add    $0x4,%ecx
 c46:	89 44 8a 08          	mov    %eax,0x8(%edx,%ecx,4)
      currentThread->state=T_SLEEPING;
 c4a:	a1 e8 57 00 00       	mov    0x57e8,%eax
 c4f:	c7 40 10 04 00 00 00 	movl   $0x4,0x10(%eax)
      uthread_yield();
 c56:	e8 07 00 00 00       	call   c62 <uthread_yield>
      return 1;
 c5b:	b8 01 00 00 00       	mov    $0x1,%eax
  }
}
 c60:	c9                   	leave  
 c61:	c3                   	ret    

00000c62 <uthread_yield>:

void 
uthread_yield()
{
 c62:	55                   	push   %ebp
 c63:	89 e5                	mov    %esp,%ebp
 c65:	83 ec 28             	sub    $0x28,%esp
  uthread_p newt;
  int old=currentThread->tid;
 c68:	a1 e8 57 00 00       	mov    0x57e8,%eax
 c6d:	8b 00                	mov    (%eax),%eax
 c6f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  int new=getNextThread(old);
 c72:	8b 45 f4             	mov    -0xc(%ebp),%eax
 c75:	89 04 24             	mov    %eax,(%esp)
 c78:	e8 37 fc ff ff       	call   8b4 <getNextThread>
 c7d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(new<0)
 c80:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 c84:	79 19                	jns    c9f <uthread_yield+0x3d>
  {
     printf(1,"(fun uthread_yield)Cant find runnable thread");
 c86:	c7 44 24 04 10 0e 00 	movl   $0xe10,0x4(%esp)
 c8d:	00 
 c8e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 c95:	e8 55 f8 ff ff       	call   4ef <printf>
    exit();
 c9a:	e8 a1 f6 ff ff       	call   340 <exit>
  }
newt=&tTable.table[new];
 c9f:	8b 45 f0             	mov    -0x10(%ebp),%eax
 ca2:	69 c0 18 01 00 00    	imul   $0x118,%eax,%eax
 ca8:	05 e0 11 00 00       	add    $0x11e0,%eax
 cad:	89 45 ec             	mov    %eax,-0x14(%ebp)
  
    asm("pusha");
 cb0:	60                   	pusha  
    STORE_ESP(currentThread->esp);
 cb1:	a1 e8 57 00 00       	mov    0x57e8,%eax
 cb6:	89 e2                	mov    %esp,%edx
 cb8:	89 50 04             	mov    %edx,0x4(%eax)
    if(currentThread->state==T_RUNNING)
 cbb:	a1 e8 57 00 00       	mov    0x57e8,%eax
 cc0:	8b 40 10             	mov    0x10(%eax),%eax
 cc3:	83 f8 02             	cmp    $0x2,%eax
 cc6:	75 0c                	jne    cd4 <uthread_yield+0x72>
      currentThread->state=T_RUNNABLE;
 cc8:	a1 e8 57 00 00       	mov    0x57e8,%eax
 ccd:	c7 40 10 03 00 00 00 	movl   $0x3,0x10(%eax)
    LOAD_ESP(newt->esp);
 cd4:	8b 45 ec             	mov    -0x14(%ebp),%eax
 cd7:	8b 40 04             	mov    0x4(%eax),%eax
 cda:	89 c4                	mov    %eax,%esp
    
  
    newt->state=T_RUNNING;
 cdc:	8b 45 ec             	mov    -0x14(%ebp),%eax
 cdf:	c7 40 10 02 00 00 00 	movl   $0x2,0x10(%eax)

    asm("popa");
 ce6:	61                   	popa   
    if(currentThread->firstTime==0)
 ce7:	a1 e8 57 00 00       	mov    0x57e8,%eax
 cec:	8b 40 14             	mov    0x14(%eax),%eax
 cef:	85 c0                	test   %eax,%eax
 cf1:	75 0d                	jne    d00 <uthread_yield+0x9e>
    {
       asm("ret");////only firest time
 cf3:	c3                   	ret    
       currentThread->firstTime=1;
 cf4:	a1 e8 57 00 00       	mov    0x57e8,%eax
 cf9:	c7 40 14 01 00 00 00 	movl   $0x1,0x14(%eax)
    }
   
currentThread=newt;
 d00:	8b 45 ec             	mov    -0x14(%ebp),%eax
 d03:	a3 e8 57 00 00       	mov    %eax,0x57e8

}
 d08:	c9                   	leave  
 d09:	c3                   	ret    

00000d0a <uthred_self>:

int  uthred_self(void)
{
 d0a:	55                   	push   %ebp
 d0b:	89 e5                	mov    %esp,%ebp
  return currentThread->tid;
 d0d:	a1 e8 57 00 00       	mov    0x57e8,%eax
 d12:	8b 00                	mov    (%eax),%eax
}
 d14:	5d                   	pop    %ebp
 d15:	c3                   	ret    
