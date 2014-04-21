
_FRRsanity:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "user.h"


int
main(int argc, char *argv[])
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	53                   	push   %ebx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	81 ec 00 01 00 00    	sub    $0x100,%esp
  uint i,j,k=1;
   d:	c7 84 24 f4 00 00 00 	movl   $0x1,0xf4(%esp)
  14:	01 00 00 00 
  int wtime[10],pid[10],rtime[10],iotime[10],ttime[10];
  for(i=0 ; i<10 ; i++)
  18:	c7 84 24 fc 00 00 00 	movl   $0x0,0xfc(%esp)
  1f:	00 00 00 00 
  23:	eb 28                	jmp    4d <main+0x4d>
  {
    if(k!=0)
  25:	83 bc 24 f4 00 00 00 	cmpl   $0x0,0xf4(%esp)
  2c:	00 
  2d:	74 0c                	je     3b <main+0x3b>
    {
      k=fork();
  2f:	e8 0c 04 00 00       	call   440 <fork>
  34:	89 84 24 f4 00 00 00 	mov    %eax,0xf4(%esp)
    
    }
    if(k==0)
  3b:	83 bc 24 f4 00 00 00 	cmpl   $0x0,0xf4(%esp)
  42:	00 
  43:	74 14                	je     59 <main+0x59>
int
main(int argc, char *argv[])
{
  uint i,j,k=1;
  int wtime[10],pid[10],rtime[10],iotime[10],ttime[10];
  for(i=0 ; i<10 ; i++)
  45:	83 84 24 fc 00 00 00 	addl   $0x1,0xfc(%esp)
  4c:	01 
  4d:	83 bc 24 fc 00 00 00 	cmpl   $0x9,0xfc(%esp)
  54:	09 
  55:	76 ce                	jbe    25 <main+0x25>
  57:	eb 01                	jmp    5a <main+0x5a>
      k=fork();
    
    }
    if(k==0)
    {
      break;
  59:	90                   	nop
    }
  }
if(k==0)
  5a:	83 bc 24 f4 00 00 00 	cmpl   $0x0,0xf4(%esp)
  61:	00 
  62:	75 4f                	jne    b3 <main+0xb3>
{
  for(j=1;j<1001;j++)
  64:	c7 84 24 f8 00 00 00 	movl   $0x1,0xf8(%esp)
  6b:	01 00 00 00 
  6f:	eb 30                	jmp    a1 <main+0xa1>
    {
      printf(1,"child:%d prints for the:%d time\n", getpid(), j);
  71:	e8 52 04 00 00       	call   4c8 <getpid>
  76:	8b 94 24 f8 00 00 00 	mov    0xf8(%esp),%edx
  7d:	89 54 24 0c          	mov    %edx,0xc(%esp)
  81:	89 44 24 08          	mov    %eax,0x8(%esp)
  85:	c7 44 24 04 20 0e 00 	movl   $0xe20,0x4(%esp)
  8c:	00 
  8d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  94:	e8 5e 05 00 00       	call   5f7 <printf>
      break;
    }
  }
if(k==0)
{
  for(j=1;j<1001;j++)
  99:	83 84 24 f8 00 00 00 	addl   $0x1,0xf8(%esp)
  a0:	01 
  a1:	81 bc 24 f8 00 00 00 	cmpl   $0x3e8,0xf8(%esp)
  a8:	e8 03 00 00 
  ac:	76 c3                	jbe    71 <main+0x71>
  ae:	e9 2c 01 00 00       	jmp    1df <main+0x1df>
     // printf(1,"time\n");
    }
}
else
{
  for(i=0;i<10;i++)
  b3:	c7 84 24 fc 00 00 00 	movl   $0x0,0xfc(%esp)
  ba:	00 00 00 00 
  be:	e9 99 00 00 00       	jmp    15c <main+0x15c>
  {
    pid[i]=wait2(&wtime[i],&rtime[i],&iotime[i]);
  c3:	8b 84 24 fc 00 00 00 	mov    0xfc(%esp),%eax
  ca:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  d1:	8d 44 24 54          	lea    0x54(%esp),%eax
  d5:	8d 0c 10             	lea    (%eax,%edx,1),%ecx
  d8:	8b 84 24 fc 00 00 00 	mov    0xfc(%esp),%eax
  df:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  e6:	8d 44 24 7c          	lea    0x7c(%esp),%eax
  ea:	01 c2                	add    %eax,%edx
  ec:	8b 84 24 fc 00 00 00 	mov    0xfc(%esp),%eax
  f3:	8d 1c 85 00 00 00 00 	lea    0x0(,%eax,4),%ebx
  fa:	8d 84 24 cc 00 00 00 	lea    0xcc(%esp),%eax
 101:	01 d8                	add    %ebx,%eax
 103:	89 4c 24 08          	mov    %ecx,0x8(%esp)
 107:	89 54 24 04          	mov    %edx,0x4(%esp)
 10b:	89 04 24             	mov    %eax,(%esp)
 10e:	e8 dd 03 00 00       	call   4f0 <wait2>
 113:	8b 94 24 fc 00 00 00 	mov    0xfc(%esp),%edx
 11a:	89 84 94 a4 00 00 00 	mov    %eax,0xa4(%esp,%edx,4)
    ttime[i]=wtime[i]+iotime[i]+rtime[i];
 121:	8b 84 24 fc 00 00 00 	mov    0xfc(%esp),%eax
 128:	8b 94 84 cc 00 00 00 	mov    0xcc(%esp,%eax,4),%edx
 12f:	8b 84 24 fc 00 00 00 	mov    0xfc(%esp),%eax
 136:	8b 44 84 54          	mov    0x54(%esp,%eax,4),%eax
 13a:	01 c2                	add    %eax,%edx
 13c:	8b 84 24 fc 00 00 00 	mov    0xfc(%esp),%eax
 143:	8b 44 84 7c          	mov    0x7c(%esp,%eax,4),%eax
 147:	01 c2                	add    %eax,%edx
 149:	8b 84 24 fc 00 00 00 	mov    0xfc(%esp),%eax
 150:	89 54 84 2c          	mov    %edx,0x2c(%esp,%eax,4)
     // printf(1,"time\n");
    }
}
else
{
  for(i=0;i<10;i++)
 154:	83 84 24 fc 00 00 00 	addl   $0x1,0xfc(%esp)
 15b:	01 
 15c:	83 bc 24 fc 00 00 00 	cmpl   $0x9,0xfc(%esp)
 163:	09 
 164:	0f 86 59 ff ff ff    	jbe    c3 <main+0xc3>
  {
    pid[i]=wait2(&wtime[i],&rtime[i],&iotime[i]);
    ttime[i]=wtime[i]+iotime[i]+rtime[i];
  }
  for(i=0;i<10;i++)
 16a:	c7 84 24 fc 00 00 00 	movl   $0x0,0xfc(%esp)
 171:	00 00 00 00 
 175:	eb 5e                	jmp    1d5 <main+0x1d5>
  {
    printf(1,"child:%d wtime:%d rtime:%d turnaround time:%d\n", pid[i], wtime[i], rtime[i], ttime[i]);
 177:	8b 84 24 fc 00 00 00 	mov    0xfc(%esp),%eax
 17e:	8b 5c 84 2c          	mov    0x2c(%esp,%eax,4),%ebx
 182:	8b 84 24 fc 00 00 00 	mov    0xfc(%esp),%eax
 189:	8b 4c 84 7c          	mov    0x7c(%esp,%eax,4),%ecx
 18d:	8b 84 24 fc 00 00 00 	mov    0xfc(%esp),%eax
 194:	8b 94 84 cc 00 00 00 	mov    0xcc(%esp,%eax,4),%edx
 19b:	8b 84 24 fc 00 00 00 	mov    0xfc(%esp),%eax
 1a2:	8b 84 84 a4 00 00 00 	mov    0xa4(%esp,%eax,4),%eax
 1a9:	89 5c 24 14          	mov    %ebx,0x14(%esp)
 1ad:	89 4c 24 10          	mov    %ecx,0x10(%esp)
 1b1:	89 54 24 0c          	mov    %edx,0xc(%esp)
 1b5:	89 44 24 08          	mov    %eax,0x8(%esp)
 1b9:	c7 44 24 04 44 0e 00 	movl   $0xe44,0x4(%esp)
 1c0:	00 
 1c1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 1c8:	e8 2a 04 00 00       	call   5f7 <printf>
  for(i=0;i<10;i++)
  {
    pid[i]=wait2(&wtime[i],&rtime[i],&iotime[i]);
    ttime[i]=wtime[i]+iotime[i]+rtime[i];
  }
  for(i=0;i<10;i++)
 1cd:	83 84 24 fc 00 00 00 	addl   $0x1,0xfc(%esp)
 1d4:	01 
 1d5:	83 bc 24 fc 00 00 00 	cmpl   $0x9,0xfc(%esp)
 1dc:	09 
 1dd:	76 98                	jbe    177 <main+0x177>
  {
    printf(1,"child:%d wtime:%d rtime:%d turnaround time:%d\n", pid[i], wtime[i], rtime[i], ttime[i]);
  }

}
  exit();
 1df:	e8 64 02 00 00       	call   448 <exit>

000001e4 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 1e4:	55                   	push   %ebp
 1e5:	89 e5                	mov    %esp,%ebp
 1e7:	57                   	push   %edi
 1e8:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
 1e9:	8b 4d 08             	mov    0x8(%ebp),%ecx
 1ec:	8b 55 10             	mov    0x10(%ebp),%edx
 1ef:	8b 45 0c             	mov    0xc(%ebp),%eax
 1f2:	89 cb                	mov    %ecx,%ebx
 1f4:	89 df                	mov    %ebx,%edi
 1f6:	89 d1                	mov    %edx,%ecx
 1f8:	fc                   	cld    
 1f9:	f3 aa                	rep stos %al,%es:(%edi)
 1fb:	89 ca                	mov    %ecx,%edx
 1fd:	89 fb                	mov    %edi,%ebx
 1ff:	89 5d 08             	mov    %ebx,0x8(%ebp)
 202:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 205:	5b                   	pop    %ebx
 206:	5f                   	pop    %edi
 207:	5d                   	pop    %ebp
 208:	c3                   	ret    

00000209 <strcpy>:
#include "x86.h"


char*
strcpy(char *s, char *t)
{
 209:	55                   	push   %ebp
 20a:	89 e5                	mov    %esp,%ebp
 20c:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
 20f:	8b 45 08             	mov    0x8(%ebp),%eax
 212:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 215:	90                   	nop
 216:	8b 45 0c             	mov    0xc(%ebp),%eax
 219:	0f b6 10             	movzbl (%eax),%edx
 21c:	8b 45 08             	mov    0x8(%ebp),%eax
 21f:	88 10                	mov    %dl,(%eax)
 221:	8b 45 08             	mov    0x8(%ebp),%eax
 224:	0f b6 00             	movzbl (%eax),%eax
 227:	84 c0                	test   %al,%al
 229:	0f 95 c0             	setne  %al
 22c:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 230:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
 234:	84 c0                	test   %al,%al
 236:	75 de                	jne    216 <strcpy+0xd>
    ;
  return os;
 238:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 23b:	c9                   	leave  
 23c:	c3                   	ret    

0000023d <strcmp>:

int
strcmp(const char *p, const char *q)
{
 23d:	55                   	push   %ebp
 23e:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 240:	eb 08                	jmp    24a <strcmp+0xd>
    p++, q++;
 242:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 246:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 24a:	8b 45 08             	mov    0x8(%ebp),%eax
 24d:	0f b6 00             	movzbl (%eax),%eax
 250:	84 c0                	test   %al,%al
 252:	74 10                	je     264 <strcmp+0x27>
 254:	8b 45 08             	mov    0x8(%ebp),%eax
 257:	0f b6 10             	movzbl (%eax),%edx
 25a:	8b 45 0c             	mov    0xc(%ebp),%eax
 25d:	0f b6 00             	movzbl (%eax),%eax
 260:	38 c2                	cmp    %al,%dl
 262:	74 de                	je     242 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 264:	8b 45 08             	mov    0x8(%ebp),%eax
 267:	0f b6 00             	movzbl (%eax),%eax
 26a:	0f b6 d0             	movzbl %al,%edx
 26d:	8b 45 0c             	mov    0xc(%ebp),%eax
 270:	0f b6 00             	movzbl (%eax),%eax
 273:	0f b6 c0             	movzbl %al,%eax
 276:	89 d1                	mov    %edx,%ecx
 278:	29 c1                	sub    %eax,%ecx
 27a:	89 c8                	mov    %ecx,%eax
}
 27c:	5d                   	pop    %ebp
 27d:	c3                   	ret    

0000027e <strlen>:

uint
strlen(char *s)
{
 27e:	55                   	push   %ebp
 27f:	89 e5                	mov    %esp,%ebp
 281:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 284:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 28b:	eb 04                	jmp    291 <strlen+0x13>
 28d:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 291:	8b 45 fc             	mov    -0x4(%ebp),%eax
 294:	03 45 08             	add    0x8(%ebp),%eax
 297:	0f b6 00             	movzbl (%eax),%eax
 29a:	84 c0                	test   %al,%al
 29c:	75 ef                	jne    28d <strlen+0xf>
    ;
  return n;
 29e:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 2a1:	c9                   	leave  
 2a2:	c3                   	ret    

000002a3 <memset>:

void*
memset(void *dst, int c, uint n)
{
 2a3:	55                   	push   %ebp
 2a4:	89 e5                	mov    %esp,%ebp
 2a6:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
 2a9:	8b 45 10             	mov    0x10(%ebp),%eax
 2ac:	89 44 24 08          	mov    %eax,0x8(%esp)
 2b0:	8b 45 0c             	mov    0xc(%ebp),%eax
 2b3:	89 44 24 04          	mov    %eax,0x4(%esp)
 2b7:	8b 45 08             	mov    0x8(%ebp),%eax
 2ba:	89 04 24             	mov    %eax,(%esp)
 2bd:	e8 22 ff ff ff       	call   1e4 <stosb>
  return dst;
 2c2:	8b 45 08             	mov    0x8(%ebp),%eax
}
 2c5:	c9                   	leave  
 2c6:	c3                   	ret    

000002c7 <strchr>:

char*
strchr(const char *s, char c)
{
 2c7:	55                   	push   %ebp
 2c8:	89 e5                	mov    %esp,%ebp
 2ca:	83 ec 04             	sub    $0x4,%esp
 2cd:	8b 45 0c             	mov    0xc(%ebp),%eax
 2d0:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 2d3:	eb 14                	jmp    2e9 <strchr+0x22>
    if(*s == c)
 2d5:	8b 45 08             	mov    0x8(%ebp),%eax
 2d8:	0f b6 00             	movzbl (%eax),%eax
 2db:	3a 45 fc             	cmp    -0x4(%ebp),%al
 2de:	75 05                	jne    2e5 <strchr+0x1e>
      return (char*)s;
 2e0:	8b 45 08             	mov    0x8(%ebp),%eax
 2e3:	eb 13                	jmp    2f8 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 2e5:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 2e9:	8b 45 08             	mov    0x8(%ebp),%eax
 2ec:	0f b6 00             	movzbl (%eax),%eax
 2ef:	84 c0                	test   %al,%al
 2f1:	75 e2                	jne    2d5 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 2f3:	b8 00 00 00 00       	mov    $0x0,%eax
}
 2f8:	c9                   	leave  
 2f9:	c3                   	ret    

000002fa <gets>:

char*
gets(char *buf, int max)
{
 2fa:	55                   	push   %ebp
 2fb:	89 e5                	mov    %esp,%ebp
 2fd:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 300:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 307:	eb 44                	jmp    34d <gets+0x53>
    cc = read(0, &c, 1);
 309:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 310:	00 
 311:	8d 45 ef             	lea    -0x11(%ebp),%eax
 314:	89 44 24 04          	mov    %eax,0x4(%esp)
 318:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 31f:	e8 3c 01 00 00       	call   460 <read>
 324:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 327:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 32b:	7e 2d                	jle    35a <gets+0x60>
      break;
    buf[i++] = c;
 32d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 330:	03 45 08             	add    0x8(%ebp),%eax
 333:	0f b6 55 ef          	movzbl -0x11(%ebp),%edx
 337:	88 10                	mov    %dl,(%eax)
 339:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    if(c == '\n' || c == '\r')
 33d:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 341:	3c 0a                	cmp    $0xa,%al
 343:	74 16                	je     35b <gets+0x61>
 345:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 349:	3c 0d                	cmp    $0xd,%al
 34b:	74 0e                	je     35b <gets+0x61>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 34d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 350:	83 c0 01             	add    $0x1,%eax
 353:	3b 45 0c             	cmp    0xc(%ebp),%eax
 356:	7c b1                	jl     309 <gets+0xf>
 358:	eb 01                	jmp    35b <gets+0x61>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
 35a:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 35b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 35e:	03 45 08             	add    0x8(%ebp),%eax
 361:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 364:	8b 45 08             	mov    0x8(%ebp),%eax
}
 367:	c9                   	leave  
 368:	c3                   	ret    

00000369 <stat>:

int
stat(char *n, struct stat *st)
{
 369:	55                   	push   %ebp
 36a:	89 e5                	mov    %esp,%ebp
 36c:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 36f:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 376:	00 
 377:	8b 45 08             	mov    0x8(%ebp),%eax
 37a:	89 04 24             	mov    %eax,(%esp)
 37d:	e8 06 01 00 00       	call   488 <open>
 382:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 385:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 389:	79 07                	jns    392 <stat+0x29>
    return -1;
 38b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 390:	eb 23                	jmp    3b5 <stat+0x4c>
  r = fstat(fd, st);
 392:	8b 45 0c             	mov    0xc(%ebp),%eax
 395:	89 44 24 04          	mov    %eax,0x4(%esp)
 399:	8b 45 f4             	mov    -0xc(%ebp),%eax
 39c:	89 04 24             	mov    %eax,(%esp)
 39f:	e8 fc 00 00 00       	call   4a0 <fstat>
 3a4:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 3a7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 3aa:	89 04 24             	mov    %eax,(%esp)
 3ad:	e8 be 00 00 00       	call   470 <close>
  return r;
 3b2:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 3b5:	c9                   	leave  
 3b6:	c3                   	ret    

000003b7 <atoi>:

int
atoi(const char *s)
{
 3b7:	55                   	push   %ebp
 3b8:	89 e5                	mov    %esp,%ebp
 3ba:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 3bd:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 3c4:	eb 23                	jmp    3e9 <atoi+0x32>
    n = n*10 + *s++ - '0';
 3c6:	8b 55 fc             	mov    -0x4(%ebp),%edx
 3c9:	89 d0                	mov    %edx,%eax
 3cb:	c1 e0 02             	shl    $0x2,%eax
 3ce:	01 d0                	add    %edx,%eax
 3d0:	01 c0                	add    %eax,%eax
 3d2:	89 c2                	mov    %eax,%edx
 3d4:	8b 45 08             	mov    0x8(%ebp),%eax
 3d7:	0f b6 00             	movzbl (%eax),%eax
 3da:	0f be c0             	movsbl %al,%eax
 3dd:	01 d0                	add    %edx,%eax
 3df:	83 e8 30             	sub    $0x30,%eax
 3e2:	89 45 fc             	mov    %eax,-0x4(%ebp)
 3e5:	83 45 08 01          	addl   $0x1,0x8(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 3e9:	8b 45 08             	mov    0x8(%ebp),%eax
 3ec:	0f b6 00             	movzbl (%eax),%eax
 3ef:	3c 2f                	cmp    $0x2f,%al
 3f1:	7e 0a                	jle    3fd <atoi+0x46>
 3f3:	8b 45 08             	mov    0x8(%ebp),%eax
 3f6:	0f b6 00             	movzbl (%eax),%eax
 3f9:	3c 39                	cmp    $0x39,%al
 3fb:	7e c9                	jle    3c6 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 3fd:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 400:	c9                   	leave  
 401:	c3                   	ret    

00000402 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 402:	55                   	push   %ebp
 403:	89 e5                	mov    %esp,%ebp
 405:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 408:	8b 45 08             	mov    0x8(%ebp),%eax
 40b:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 40e:	8b 45 0c             	mov    0xc(%ebp),%eax
 411:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 414:	eb 13                	jmp    429 <memmove+0x27>
    *dst++ = *src++;
 416:	8b 45 f8             	mov    -0x8(%ebp),%eax
 419:	0f b6 10             	movzbl (%eax),%edx
 41c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 41f:	88 10                	mov    %dl,(%eax)
 421:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 425:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 429:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
 42d:	0f 9f c0             	setg   %al
 430:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
 434:	84 c0                	test   %al,%al
 436:	75 de                	jne    416 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 438:	8b 45 08             	mov    0x8(%ebp),%eax
}
 43b:	c9                   	leave  
 43c:	c3                   	ret    
 43d:	90                   	nop
 43e:	90                   	nop
 43f:	90                   	nop

00000440 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 440:	b8 01 00 00 00       	mov    $0x1,%eax
 445:	cd 40                	int    $0x40
 447:	c3                   	ret    

00000448 <exit>:
SYSCALL(exit)
 448:	b8 02 00 00 00       	mov    $0x2,%eax
 44d:	cd 40                	int    $0x40
 44f:	c3                   	ret    

00000450 <wait>:
SYSCALL(wait)
 450:	b8 03 00 00 00       	mov    $0x3,%eax
 455:	cd 40                	int    $0x40
 457:	c3                   	ret    

00000458 <pipe>:
SYSCALL(pipe)
 458:	b8 04 00 00 00       	mov    $0x4,%eax
 45d:	cd 40                	int    $0x40
 45f:	c3                   	ret    

00000460 <read>:
SYSCALL(read)
 460:	b8 05 00 00 00       	mov    $0x5,%eax
 465:	cd 40                	int    $0x40
 467:	c3                   	ret    

00000468 <write>:
SYSCALL(write)
 468:	b8 10 00 00 00       	mov    $0x10,%eax
 46d:	cd 40                	int    $0x40
 46f:	c3                   	ret    

00000470 <close>:
SYSCALL(close)
 470:	b8 15 00 00 00       	mov    $0x15,%eax
 475:	cd 40                	int    $0x40
 477:	c3                   	ret    

00000478 <kill>:
SYSCALL(kill)
 478:	b8 06 00 00 00       	mov    $0x6,%eax
 47d:	cd 40                	int    $0x40
 47f:	c3                   	ret    

00000480 <exec>:
SYSCALL(exec)
 480:	b8 07 00 00 00       	mov    $0x7,%eax
 485:	cd 40                	int    $0x40
 487:	c3                   	ret    

00000488 <open>:
SYSCALL(open)
 488:	b8 0f 00 00 00       	mov    $0xf,%eax
 48d:	cd 40                	int    $0x40
 48f:	c3                   	ret    

00000490 <mknod>:
SYSCALL(mknod)
 490:	b8 11 00 00 00       	mov    $0x11,%eax
 495:	cd 40                	int    $0x40
 497:	c3                   	ret    

00000498 <unlink>:
SYSCALL(unlink)
 498:	b8 12 00 00 00       	mov    $0x12,%eax
 49d:	cd 40                	int    $0x40
 49f:	c3                   	ret    

000004a0 <fstat>:
SYSCALL(fstat)
 4a0:	b8 08 00 00 00       	mov    $0x8,%eax
 4a5:	cd 40                	int    $0x40
 4a7:	c3                   	ret    

000004a8 <link>:
SYSCALL(link)
 4a8:	b8 13 00 00 00       	mov    $0x13,%eax
 4ad:	cd 40                	int    $0x40
 4af:	c3                   	ret    

000004b0 <mkdir>:
SYSCALL(mkdir)
 4b0:	b8 14 00 00 00       	mov    $0x14,%eax
 4b5:	cd 40                	int    $0x40
 4b7:	c3                   	ret    

000004b8 <chdir>:
SYSCALL(chdir)
 4b8:	b8 09 00 00 00       	mov    $0x9,%eax
 4bd:	cd 40                	int    $0x40
 4bf:	c3                   	ret    

000004c0 <dup>:
SYSCALL(dup)
 4c0:	b8 0a 00 00 00       	mov    $0xa,%eax
 4c5:	cd 40                	int    $0x40
 4c7:	c3                   	ret    

000004c8 <getpid>:
SYSCALL(getpid)
 4c8:	b8 0b 00 00 00       	mov    $0xb,%eax
 4cd:	cd 40                	int    $0x40
 4cf:	c3                   	ret    

000004d0 <sbrk>:
SYSCALL(sbrk)
 4d0:	b8 0c 00 00 00       	mov    $0xc,%eax
 4d5:	cd 40                	int    $0x40
 4d7:	c3                   	ret    

000004d8 <sleep>:
SYSCALL(sleep)
 4d8:	b8 0d 00 00 00       	mov    $0xd,%eax
 4dd:	cd 40                	int    $0x40
 4df:	c3                   	ret    

000004e0 <uptime>:
SYSCALL(uptime)
 4e0:	b8 0e 00 00 00       	mov    $0xe,%eax
 4e5:	cd 40                	int    $0x40
 4e7:	c3                   	ret    

000004e8 <add_path>:
SYSCALL(add_path)
 4e8:	b8 16 00 00 00       	mov    $0x16,%eax
 4ed:	cd 40                	int    $0x40
 4ef:	c3                   	ret    

000004f0 <wait2>:
SYSCALL(wait2)
 4f0:	b8 17 00 00 00       	mov    $0x17,%eax
 4f5:	cd 40                	int    $0x40
 4f7:	c3                   	ret    

000004f8 <getquanta>:
SYSCALL(getquanta)
 4f8:	b8 18 00 00 00       	mov    $0x18,%eax
 4fd:	cd 40                	int    $0x40
 4ff:	c3                   	ret    

00000500 <getqueue>:
SYSCALL(getqueue)
 500:	b8 19 00 00 00       	mov    $0x19,%eax
 505:	cd 40                	int    $0x40
 507:	c3                   	ret    

00000508 <signal>:
SYSCALL(signal)
 508:	b8 1a 00 00 00       	mov    $0x1a,%eax
 50d:	cd 40                	int    $0x40
 50f:	c3                   	ret    

00000510 <sigsend>:
SYSCALL(sigsend)
 510:	b8 1b 00 00 00       	mov    $0x1b,%eax
 515:	cd 40                	int    $0x40
 517:	c3                   	ret    

00000518 <alarm>:
SYSCALL(alarm)
 518:	b8 1c 00 00 00       	mov    $0x1c,%eax
 51d:	cd 40                	int    $0x40
 51f:	c3                   	ret    

00000520 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 520:	55                   	push   %ebp
 521:	89 e5                	mov    %esp,%ebp
 523:	83 ec 28             	sub    $0x28,%esp
 526:	8b 45 0c             	mov    0xc(%ebp),%eax
 529:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 52c:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 533:	00 
 534:	8d 45 f4             	lea    -0xc(%ebp),%eax
 537:	89 44 24 04          	mov    %eax,0x4(%esp)
 53b:	8b 45 08             	mov    0x8(%ebp),%eax
 53e:	89 04 24             	mov    %eax,(%esp)
 541:	e8 22 ff ff ff       	call   468 <write>
}
 546:	c9                   	leave  
 547:	c3                   	ret    

00000548 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 548:	55                   	push   %ebp
 549:	89 e5                	mov    %esp,%ebp
 54b:	83 ec 48             	sub    $0x48,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 54e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 555:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 559:	74 17                	je     572 <printint+0x2a>
 55b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 55f:	79 11                	jns    572 <printint+0x2a>
    neg = 1;
 561:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 568:	8b 45 0c             	mov    0xc(%ebp),%eax
 56b:	f7 d8                	neg    %eax
 56d:	89 45 ec             	mov    %eax,-0x14(%ebp)
 570:	eb 06                	jmp    578 <printint+0x30>
  } else {
    x = xx;
 572:	8b 45 0c             	mov    0xc(%ebp),%eax
 575:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 578:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 57f:	8b 4d 10             	mov    0x10(%ebp),%ecx
 582:	8b 45 ec             	mov    -0x14(%ebp),%eax
 585:	ba 00 00 00 00       	mov    $0x0,%edx
 58a:	f7 f1                	div    %ecx
 58c:	89 d0                	mov    %edx,%eax
 58e:	0f b6 90 2c 12 00 00 	movzbl 0x122c(%eax),%edx
 595:	8d 45 dc             	lea    -0x24(%ebp),%eax
 598:	03 45 f4             	add    -0xc(%ebp),%eax
 59b:	88 10                	mov    %dl,(%eax)
 59d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  }while((x /= base) != 0);
 5a1:	8b 55 10             	mov    0x10(%ebp),%edx
 5a4:	89 55 d4             	mov    %edx,-0x2c(%ebp)
 5a7:	8b 45 ec             	mov    -0x14(%ebp),%eax
 5aa:	ba 00 00 00 00       	mov    $0x0,%edx
 5af:	f7 75 d4             	divl   -0x2c(%ebp)
 5b2:	89 45 ec             	mov    %eax,-0x14(%ebp)
 5b5:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 5b9:	75 c4                	jne    57f <printint+0x37>
  if(neg)
 5bb:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 5bf:	74 2a                	je     5eb <printint+0xa3>
    buf[i++] = '-';
 5c1:	8d 45 dc             	lea    -0x24(%ebp),%eax
 5c4:	03 45 f4             	add    -0xc(%ebp),%eax
 5c7:	c6 00 2d             	movb   $0x2d,(%eax)
 5ca:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)

  while(--i >= 0)
 5ce:	eb 1b                	jmp    5eb <printint+0xa3>
    putc(fd, buf[i]);
 5d0:	8d 45 dc             	lea    -0x24(%ebp),%eax
 5d3:	03 45 f4             	add    -0xc(%ebp),%eax
 5d6:	0f b6 00             	movzbl (%eax),%eax
 5d9:	0f be c0             	movsbl %al,%eax
 5dc:	89 44 24 04          	mov    %eax,0x4(%esp)
 5e0:	8b 45 08             	mov    0x8(%ebp),%eax
 5e3:	89 04 24             	mov    %eax,(%esp)
 5e6:	e8 35 ff ff ff       	call   520 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 5eb:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 5ef:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 5f3:	79 db                	jns    5d0 <printint+0x88>
    putc(fd, buf[i]);
}
 5f5:	c9                   	leave  
 5f6:	c3                   	ret    

000005f7 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 5f7:	55                   	push   %ebp
 5f8:	89 e5                	mov    %esp,%ebp
 5fa:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 5fd:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 604:	8d 45 0c             	lea    0xc(%ebp),%eax
 607:	83 c0 04             	add    $0x4,%eax
 60a:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 60d:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 614:	e9 7d 01 00 00       	jmp    796 <printf+0x19f>
    c = fmt[i] & 0xff;
 619:	8b 55 0c             	mov    0xc(%ebp),%edx
 61c:	8b 45 f0             	mov    -0x10(%ebp),%eax
 61f:	01 d0                	add    %edx,%eax
 621:	0f b6 00             	movzbl (%eax),%eax
 624:	0f be c0             	movsbl %al,%eax
 627:	25 ff 00 00 00       	and    $0xff,%eax
 62c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 62f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 633:	75 2c                	jne    661 <printf+0x6a>
      if(c == '%'){
 635:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 639:	75 0c                	jne    647 <printf+0x50>
        state = '%';
 63b:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 642:	e9 4b 01 00 00       	jmp    792 <printf+0x19b>
      } else {
        putc(fd, c);
 647:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 64a:	0f be c0             	movsbl %al,%eax
 64d:	89 44 24 04          	mov    %eax,0x4(%esp)
 651:	8b 45 08             	mov    0x8(%ebp),%eax
 654:	89 04 24             	mov    %eax,(%esp)
 657:	e8 c4 fe ff ff       	call   520 <putc>
 65c:	e9 31 01 00 00       	jmp    792 <printf+0x19b>
      }
    } else if(state == '%'){
 661:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 665:	0f 85 27 01 00 00    	jne    792 <printf+0x19b>
      if(c == 'd'){
 66b:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 66f:	75 2d                	jne    69e <printf+0xa7>
        printint(fd, *ap, 10, 1);
 671:	8b 45 e8             	mov    -0x18(%ebp),%eax
 674:	8b 00                	mov    (%eax),%eax
 676:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
 67d:	00 
 67e:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
 685:	00 
 686:	89 44 24 04          	mov    %eax,0x4(%esp)
 68a:	8b 45 08             	mov    0x8(%ebp),%eax
 68d:	89 04 24             	mov    %eax,(%esp)
 690:	e8 b3 fe ff ff       	call   548 <printint>
        ap++;
 695:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 699:	e9 ed 00 00 00       	jmp    78b <printf+0x194>
      } else if(c == 'x' || c == 'p'){
 69e:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 6a2:	74 06                	je     6aa <printf+0xb3>
 6a4:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 6a8:	75 2d                	jne    6d7 <printf+0xe0>
        printint(fd, *ap, 16, 0);
 6aa:	8b 45 e8             	mov    -0x18(%ebp),%eax
 6ad:	8b 00                	mov    (%eax),%eax
 6af:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 6b6:	00 
 6b7:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 6be:	00 
 6bf:	89 44 24 04          	mov    %eax,0x4(%esp)
 6c3:	8b 45 08             	mov    0x8(%ebp),%eax
 6c6:	89 04 24             	mov    %eax,(%esp)
 6c9:	e8 7a fe ff ff       	call   548 <printint>
        ap++;
 6ce:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 6d2:	e9 b4 00 00 00       	jmp    78b <printf+0x194>
      } else if(c == 's'){
 6d7:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 6db:	75 46                	jne    723 <printf+0x12c>
        s = (char*)*ap;
 6dd:	8b 45 e8             	mov    -0x18(%ebp),%eax
 6e0:	8b 00                	mov    (%eax),%eax
 6e2:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 6e5:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 6e9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 6ed:	75 27                	jne    716 <printf+0x11f>
          s = "(null)";
 6ef:	c7 45 f4 73 0e 00 00 	movl   $0xe73,-0xc(%ebp)
        while(*s != 0){
 6f6:	eb 1e                	jmp    716 <printf+0x11f>
          putc(fd, *s);
 6f8:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6fb:	0f b6 00             	movzbl (%eax),%eax
 6fe:	0f be c0             	movsbl %al,%eax
 701:	89 44 24 04          	mov    %eax,0x4(%esp)
 705:	8b 45 08             	mov    0x8(%ebp),%eax
 708:	89 04 24             	mov    %eax,(%esp)
 70b:	e8 10 fe ff ff       	call   520 <putc>
          s++;
 710:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 714:	eb 01                	jmp    717 <printf+0x120>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 716:	90                   	nop
 717:	8b 45 f4             	mov    -0xc(%ebp),%eax
 71a:	0f b6 00             	movzbl (%eax),%eax
 71d:	84 c0                	test   %al,%al
 71f:	75 d7                	jne    6f8 <printf+0x101>
 721:	eb 68                	jmp    78b <printf+0x194>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 723:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 727:	75 1d                	jne    746 <printf+0x14f>
        putc(fd, *ap);
 729:	8b 45 e8             	mov    -0x18(%ebp),%eax
 72c:	8b 00                	mov    (%eax),%eax
 72e:	0f be c0             	movsbl %al,%eax
 731:	89 44 24 04          	mov    %eax,0x4(%esp)
 735:	8b 45 08             	mov    0x8(%ebp),%eax
 738:	89 04 24             	mov    %eax,(%esp)
 73b:	e8 e0 fd ff ff       	call   520 <putc>
        ap++;
 740:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 744:	eb 45                	jmp    78b <printf+0x194>
      } else if(c == '%'){
 746:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 74a:	75 17                	jne    763 <printf+0x16c>
        putc(fd, c);
 74c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 74f:	0f be c0             	movsbl %al,%eax
 752:	89 44 24 04          	mov    %eax,0x4(%esp)
 756:	8b 45 08             	mov    0x8(%ebp),%eax
 759:	89 04 24             	mov    %eax,(%esp)
 75c:	e8 bf fd ff ff       	call   520 <putc>
 761:	eb 28                	jmp    78b <printf+0x194>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 763:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
 76a:	00 
 76b:	8b 45 08             	mov    0x8(%ebp),%eax
 76e:	89 04 24             	mov    %eax,(%esp)
 771:	e8 aa fd ff ff       	call   520 <putc>
        putc(fd, c);
 776:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 779:	0f be c0             	movsbl %al,%eax
 77c:	89 44 24 04          	mov    %eax,0x4(%esp)
 780:	8b 45 08             	mov    0x8(%ebp),%eax
 783:	89 04 24             	mov    %eax,(%esp)
 786:	e8 95 fd ff ff       	call   520 <putc>
      }
      state = 0;
 78b:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 792:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 796:	8b 55 0c             	mov    0xc(%ebp),%edx
 799:	8b 45 f0             	mov    -0x10(%ebp),%eax
 79c:	01 d0                	add    %edx,%eax
 79e:	0f b6 00             	movzbl (%eax),%eax
 7a1:	84 c0                	test   %al,%al
 7a3:	0f 85 70 fe ff ff    	jne    619 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 7a9:	c9                   	leave  
 7aa:	c3                   	ret    
 7ab:	90                   	nop

000007ac <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 7ac:	55                   	push   %ebp
 7ad:	89 e5                	mov    %esp,%ebp
 7af:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 7b2:	8b 45 08             	mov    0x8(%ebp),%eax
 7b5:	83 e8 08             	sub    $0x8,%eax
 7b8:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7bb:	a1 48 12 00 00       	mov    0x1248,%eax
 7c0:	89 45 fc             	mov    %eax,-0x4(%ebp)
 7c3:	eb 24                	jmp    7e9 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7c5:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7c8:	8b 00                	mov    (%eax),%eax
 7ca:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 7cd:	77 12                	ja     7e1 <free+0x35>
 7cf:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7d2:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 7d5:	77 24                	ja     7fb <free+0x4f>
 7d7:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7da:	8b 00                	mov    (%eax),%eax
 7dc:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 7df:	77 1a                	ja     7fb <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7e1:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7e4:	8b 00                	mov    (%eax),%eax
 7e6:	89 45 fc             	mov    %eax,-0x4(%ebp)
 7e9:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7ec:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 7ef:	76 d4                	jbe    7c5 <free+0x19>
 7f1:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7f4:	8b 00                	mov    (%eax),%eax
 7f6:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 7f9:	76 ca                	jbe    7c5 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 7fb:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7fe:	8b 40 04             	mov    0x4(%eax),%eax
 801:	c1 e0 03             	shl    $0x3,%eax
 804:	89 c2                	mov    %eax,%edx
 806:	03 55 f8             	add    -0x8(%ebp),%edx
 809:	8b 45 fc             	mov    -0x4(%ebp),%eax
 80c:	8b 00                	mov    (%eax),%eax
 80e:	39 c2                	cmp    %eax,%edx
 810:	75 24                	jne    836 <free+0x8a>
    bp->s.size += p->s.ptr->s.size;
 812:	8b 45 f8             	mov    -0x8(%ebp),%eax
 815:	8b 50 04             	mov    0x4(%eax),%edx
 818:	8b 45 fc             	mov    -0x4(%ebp),%eax
 81b:	8b 00                	mov    (%eax),%eax
 81d:	8b 40 04             	mov    0x4(%eax),%eax
 820:	01 c2                	add    %eax,%edx
 822:	8b 45 f8             	mov    -0x8(%ebp),%eax
 825:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 828:	8b 45 fc             	mov    -0x4(%ebp),%eax
 82b:	8b 00                	mov    (%eax),%eax
 82d:	8b 10                	mov    (%eax),%edx
 82f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 832:	89 10                	mov    %edx,(%eax)
 834:	eb 0a                	jmp    840 <free+0x94>
  } else
    bp->s.ptr = p->s.ptr;
 836:	8b 45 fc             	mov    -0x4(%ebp),%eax
 839:	8b 10                	mov    (%eax),%edx
 83b:	8b 45 f8             	mov    -0x8(%ebp),%eax
 83e:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 840:	8b 45 fc             	mov    -0x4(%ebp),%eax
 843:	8b 40 04             	mov    0x4(%eax),%eax
 846:	c1 e0 03             	shl    $0x3,%eax
 849:	03 45 fc             	add    -0x4(%ebp),%eax
 84c:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 84f:	75 20                	jne    871 <free+0xc5>
    p->s.size += bp->s.size;
 851:	8b 45 fc             	mov    -0x4(%ebp),%eax
 854:	8b 50 04             	mov    0x4(%eax),%edx
 857:	8b 45 f8             	mov    -0x8(%ebp),%eax
 85a:	8b 40 04             	mov    0x4(%eax),%eax
 85d:	01 c2                	add    %eax,%edx
 85f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 862:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 865:	8b 45 f8             	mov    -0x8(%ebp),%eax
 868:	8b 10                	mov    (%eax),%edx
 86a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 86d:	89 10                	mov    %edx,(%eax)
 86f:	eb 08                	jmp    879 <free+0xcd>
  } else
    p->s.ptr = bp;
 871:	8b 45 fc             	mov    -0x4(%ebp),%eax
 874:	8b 55 f8             	mov    -0x8(%ebp),%edx
 877:	89 10                	mov    %edx,(%eax)
  freep = p;
 879:	8b 45 fc             	mov    -0x4(%ebp),%eax
 87c:	a3 48 12 00 00       	mov    %eax,0x1248
}
 881:	c9                   	leave  
 882:	c3                   	ret    

00000883 <morecore>:

static Header*
morecore(uint nu)
{
 883:	55                   	push   %ebp
 884:	89 e5                	mov    %esp,%ebp
 886:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 889:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 890:	77 07                	ja     899 <morecore+0x16>
    nu = 4096;
 892:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 899:	8b 45 08             	mov    0x8(%ebp),%eax
 89c:	c1 e0 03             	shl    $0x3,%eax
 89f:	89 04 24             	mov    %eax,(%esp)
 8a2:	e8 29 fc ff ff       	call   4d0 <sbrk>
 8a7:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 8aa:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 8ae:	75 07                	jne    8b7 <morecore+0x34>
    return 0;
 8b0:	b8 00 00 00 00       	mov    $0x0,%eax
 8b5:	eb 22                	jmp    8d9 <morecore+0x56>
  hp = (Header*)p;
 8b7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8ba:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 8bd:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8c0:	8b 55 08             	mov    0x8(%ebp),%edx
 8c3:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 8c6:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8c9:	83 c0 08             	add    $0x8,%eax
 8cc:	89 04 24             	mov    %eax,(%esp)
 8cf:	e8 d8 fe ff ff       	call   7ac <free>
  return freep;
 8d4:	a1 48 12 00 00       	mov    0x1248,%eax
}
 8d9:	c9                   	leave  
 8da:	c3                   	ret    

000008db <malloc>:

void*
malloc(uint nbytes)
{
 8db:	55                   	push   %ebp
 8dc:	89 e5                	mov    %esp,%ebp
 8de:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8e1:	8b 45 08             	mov    0x8(%ebp),%eax
 8e4:	83 c0 07             	add    $0x7,%eax
 8e7:	c1 e8 03             	shr    $0x3,%eax
 8ea:	83 c0 01             	add    $0x1,%eax
 8ed:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 8f0:	a1 48 12 00 00       	mov    0x1248,%eax
 8f5:	89 45 f0             	mov    %eax,-0x10(%ebp)
 8f8:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 8fc:	75 23                	jne    921 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 8fe:	c7 45 f0 40 12 00 00 	movl   $0x1240,-0x10(%ebp)
 905:	8b 45 f0             	mov    -0x10(%ebp),%eax
 908:	a3 48 12 00 00       	mov    %eax,0x1248
 90d:	a1 48 12 00 00       	mov    0x1248,%eax
 912:	a3 40 12 00 00       	mov    %eax,0x1240
    base.s.size = 0;
 917:	c7 05 44 12 00 00 00 	movl   $0x0,0x1244
 91e:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 921:	8b 45 f0             	mov    -0x10(%ebp),%eax
 924:	8b 00                	mov    (%eax),%eax
 926:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 929:	8b 45 f4             	mov    -0xc(%ebp),%eax
 92c:	8b 40 04             	mov    0x4(%eax),%eax
 92f:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 932:	72 4d                	jb     981 <malloc+0xa6>
      if(p->s.size == nunits)
 934:	8b 45 f4             	mov    -0xc(%ebp),%eax
 937:	8b 40 04             	mov    0x4(%eax),%eax
 93a:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 93d:	75 0c                	jne    94b <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 93f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 942:	8b 10                	mov    (%eax),%edx
 944:	8b 45 f0             	mov    -0x10(%ebp),%eax
 947:	89 10                	mov    %edx,(%eax)
 949:	eb 26                	jmp    971 <malloc+0x96>
      else {
        p->s.size -= nunits;
 94b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 94e:	8b 40 04             	mov    0x4(%eax),%eax
 951:	89 c2                	mov    %eax,%edx
 953:	2b 55 ec             	sub    -0x14(%ebp),%edx
 956:	8b 45 f4             	mov    -0xc(%ebp),%eax
 959:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 95c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 95f:	8b 40 04             	mov    0x4(%eax),%eax
 962:	c1 e0 03             	shl    $0x3,%eax
 965:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 968:	8b 45 f4             	mov    -0xc(%ebp),%eax
 96b:	8b 55 ec             	mov    -0x14(%ebp),%edx
 96e:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 971:	8b 45 f0             	mov    -0x10(%ebp),%eax
 974:	a3 48 12 00 00       	mov    %eax,0x1248
      return (void*)(p + 1);
 979:	8b 45 f4             	mov    -0xc(%ebp),%eax
 97c:	83 c0 08             	add    $0x8,%eax
 97f:	eb 38                	jmp    9b9 <malloc+0xde>
    }
    if(p == freep)
 981:	a1 48 12 00 00       	mov    0x1248,%eax
 986:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 989:	75 1b                	jne    9a6 <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
 98b:	8b 45 ec             	mov    -0x14(%ebp),%eax
 98e:	89 04 24             	mov    %eax,(%esp)
 991:	e8 ed fe ff ff       	call   883 <morecore>
 996:	89 45 f4             	mov    %eax,-0xc(%ebp)
 999:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 99d:	75 07                	jne    9a6 <malloc+0xcb>
        return 0;
 99f:	b8 00 00 00 00       	mov    $0x0,%eax
 9a4:	eb 13                	jmp    9b9 <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9a6:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9a9:	89 45 f0             	mov    %eax,-0x10(%ebp)
 9ac:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9af:	8b 00                	mov    (%eax),%eax
 9b1:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 9b4:	e9 70 ff ff ff       	jmp    929 <malloc+0x4e>
}
 9b9:	c9                   	leave  
 9ba:	c3                   	ret    
 9bb:	90                   	nop

000009bc <getNextThread>:
} tTable;


int
getNextThread(int j)
{
 9bc:	55                   	push   %ebp
 9bd:	89 e5                	mov    %esp,%ebp
 9bf:	83 ec 10             	sub    $0x10,%esp
  int i=j+1;
 9c2:	8b 45 08             	mov    0x8(%ebp),%eax
 9c5:	83 c0 01             	add    $0x1,%eax
 9c8:	89 45 fc             	mov    %eax,-0x4(%ebp)
  if(i==MAX_THREAD)
 9cb:	83 7d fc 40          	cmpl   $0x40,-0x4(%ebp)
 9cf:	75 07                	jne    9d8 <getNextThread+0x1c>
    i=0;
 9d1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  uthread_p t=&tTable.table[i];
 9d8:	8b 45 fc             	mov    -0x4(%ebp),%eax
 9db:	69 c0 18 01 00 00    	imul   $0x118,%eax,%eax
 9e1:	05 60 12 00 00       	add    $0x1260,%eax
 9e6:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(i!=j)
 9e9:	eb 3b                	jmp    a26 <getNextThread+0x6a>
  {
    if(t->state==T_RUNNABLE)
 9eb:	8b 45 f8             	mov    -0x8(%ebp),%eax
 9ee:	8b 40 10             	mov    0x10(%eax),%eax
 9f1:	83 f8 03             	cmp    $0x3,%eax
 9f4:	75 05                	jne    9fb <getNextThread+0x3f>
      return i;
 9f6:	8b 45 fc             	mov    -0x4(%ebp),%eax
 9f9:	eb 38                	jmp    a33 <getNextThread+0x77>
    i++;
 9fb:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    if(i==MAX_THREAD)
 9ff:	83 7d fc 40          	cmpl   $0x40,-0x4(%ebp)
 a03:	75 1a                	jne    a1f <getNextThread+0x63>
    {
       i=0;
 a05:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
       t=&tTable.table[i];
 a0c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 a0f:	69 c0 18 01 00 00    	imul   $0x118,%eax,%eax
 a15:	05 60 12 00 00       	add    $0x1260,%eax
 a1a:	89 45 f8             	mov    %eax,-0x8(%ebp)
 a1d:	eb 07                	jmp    a26 <getNextThread+0x6a>
    }
    else
      t++;
 a1f:	81 45 f8 18 01 00 00 	addl   $0x118,-0x8(%ebp)
{
  int i=j+1;
  if(i==MAX_THREAD)
    i=0;
  uthread_p t=&tTable.table[i];
  while(i!=j)
 a26:	8b 45 fc             	mov    -0x4(%ebp),%eax
 a29:	3b 45 08             	cmp    0x8(%ebp),%eax
 a2c:	75 bd                	jne    9eb <getNextThread+0x2f>
    }
    else
      t++;
    
  }
  return -1;
 a2e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
 a33:	c9                   	leave  
 a34:	c3                   	ret    

00000a35 <allocThread>:


static uthread_p
allocThread()
{
 a35:	55                   	push   %ebp
 a36:	89 e5                	mov    %esp,%ebp
 a38:	83 ec 28             	sub    $0x28,%esp
  int i,j;
  uthread_p t;
  
  for (t=tTable.table,i=0 ; t <= &tTable.table[MAX_THREAD]; t++,i++)// <= should be < ??
 a3b:	c7 45 ec 60 12 00 00 	movl   $0x1260,-0x14(%ebp)
 a42:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 a49:	eb 15                	jmp    a60 <allocThread+0x2b>
  {
    if(t->state==T_FREE)
 a4b:	8b 45 ec             	mov    -0x14(%ebp),%eax
 a4e:	8b 40 10             	mov    0x10(%eax),%eax
 a51:	85 c0                	test   %eax,%eax
 a53:	74 1e                	je     a73 <allocThread+0x3e>
allocThread()
{
  int i,j;
  uthread_p t;
  
  for (t=tTable.table,i=0 ; t <= &tTable.table[MAX_THREAD]; t++,i++)// <= should be < ??
 a55:	81 45 ec 18 01 00 00 	addl   $0x118,-0x14(%ebp)
 a5c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 a60:	81 7d ec 60 58 00 00 	cmpl   $0x5860,-0x14(%ebp)
 a67:	76 e2                	jbe    a4b <allocThread+0x16>
  {
    if(t->state==T_FREE)
      goto found;
  }
  return 0;
 a69:	b8 00 00 00 00       	mov    $0x0,%eax
 a6e:	e9 88 00 00 00       	jmp    afb <allocThread+0xc6>
  uthread_p t;
  
  for (t=tTable.table,i=0 ; t <= &tTable.table[MAX_THREAD]; t++,i++)// <= should be < ??
  {
    if(t->state==T_FREE)
      goto found;
 a73:	90                   	nop
  }
  return 0;
  
  found:
  
  t->tid=i;
 a74:	8b 45 ec             	mov    -0x14(%ebp),%eax
 a77:	8b 55 f4             	mov    -0xc(%ebp),%edx
 a7a:	89 10                	mov    %edx,(%eax)
  t->stack=(char*)malloc(STACK_SIZE);
 a7c:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
 a83:	e8 53 fe ff ff       	call   8db <malloc>
 a88:	8b 55 ec             	mov    -0x14(%ebp),%edx
 a8b:	89 42 0c             	mov    %eax,0xc(%edx)
  t->esp=(int)t->stack;
 a8e:	8b 45 ec             	mov    -0x14(%ebp),%eax
 a91:	8b 40 0c             	mov    0xc(%eax),%eax
 a94:	89 c2                	mov    %eax,%edx
 a96:	8b 45 ec             	mov    -0x14(%ebp),%eax
 a99:	89 50 04             	mov    %edx,0x4(%eax)
  t->ebp=(int)t->stack;
 a9c:	8b 45 ec             	mov    -0x14(%ebp),%eax
 a9f:	8b 40 0c             	mov    0xc(%eax),%eax
 aa2:	89 c2                	mov    %eax,%edx
 aa4:	8b 45 ec             	mov    -0x14(%ebp),%eax
 aa7:	89 50 08             	mov    %edx,0x8(%eax)
  t->firstTime=0;
 aaa:	8b 45 ec             	mov    -0x14(%ebp),%eax
 aad:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
  for(j=0;j<64;j++)
 ab4:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 abb:	eb 15                	jmp    ad2 <allocThread+0x9d>
  {
    t->waiting[j]=-1;
 abd:	8b 45 ec             	mov    -0x14(%ebp),%eax
 ac0:	8b 55 f0             	mov    -0x10(%ebp),%edx
 ac3:	83 c2 04             	add    $0x4,%edx
 ac6:	c7 44 90 08 ff ff ff 	movl   $0xffffffff,0x8(%eax,%edx,4)
 acd:	ff 
  t->tid=i;
  t->stack=(char*)malloc(STACK_SIZE);
  t->esp=(int)t->stack;
  t->ebp=(int)t->stack;
  t->firstTime=0;
  for(j=0;j<64;j++)
 ace:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 ad2:	83 7d f0 3f          	cmpl   $0x3f,-0x10(%ebp)
 ad6:	7e e5                	jle    abd <allocThread+0x88>
  {
    t->waiting[j]=-1;
  }
  asm("movl %1,%%esp;" "push %2;" "movl %%esp,%0;" //pushes the uthread_exit func as return address
    : "=r" (t->esp) 
    : "r" (t->ebp) , "r"(uthread_exit)
 ad8:	8b 45 ec             	mov    -0x14(%ebp),%eax
 adb:	8b 40 08             	mov    0x8(%eax),%eax
  t->firstTime=0;
  for(j=0;j<64;j++)
  {
    t->waiting[j]=-1;
  }
  asm("movl %1,%%esp;" "push %2;" "movl %%esp,%0;" //pushes the uthread_exit func as return address
 ade:	ba fa 0b 00 00       	mov    $0xbfa,%edx
 ae3:	89 c4                	mov    %eax,%esp
 ae5:	52                   	push   %edx
 ae6:	89 e2                	mov    %esp,%edx
    : "=r" (t->esp) 
 ae8:	8b 45 ec             	mov    -0x14(%ebp),%eax
  t->firstTime=0;
  for(j=0;j<64;j++)
  {
    t->waiting[j]=-1;
  }
  asm("movl %1,%%esp;" "push %2;" "movl %%esp,%0;" //pushes the uthread_exit func as return address
 aeb:	89 50 04             	mov    %edx,0x4(%eax)
    : "=r" (t->esp) 
    : "r" (t->ebp) , "r"(uthread_exit)
  );
  t->state=T_UNINIT;
 aee:	8b 45 ec             	mov    -0x14(%ebp),%eax
 af1:	c7 40 10 01 00 00 00 	movl   $0x1,0x10(%eax)
  return t;
 af8:	8b 45 ec             	mov    -0x14(%ebp),%eax
}
 afb:	c9                   	leave  
 afc:	c3                   	ret    

00000afd <uthread_init>:

void 
uthread_init()
{  
 afd:	55                   	push   %ebp
 afe:	89 e5                	mov    %esp,%ebp
 b00:	83 ec 28             	sub    $0x28,%esp
  tTable.length=0;
 b03:	c7 05 60 58 00 00 00 	movl   $0x0,0x5860
 b0a:	00 00 00 
  tTable.current=0;
 b0d:	c7 05 64 58 00 00 00 	movl   $0x0,0x5864
 b14:	00 00 00 
  uthread_p mainT = allocThread(); //needed to allocate the main thread !!!!!!
 b17:	e8 19 ff ff ff       	call   a35 <allocThread>
 b1c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  asm("movl %%ebp,%0;" "movl %%esp,%1;" //get current thread ebp and esp
 b1f:	89 e9                	mov    %ebp,%ecx
 b21:	89 e2                	mov    %esp,%edx
    : "=r" (mainT->ebp) ,"=r"(mainT->esp)    
 b23:	8b 45 f4             	mov    -0xc(%ebp),%eax
uthread_init()
{  
  tTable.length=0;
  tTable.current=0;
  uthread_p mainT = allocThread(); //needed to allocate the main thread !!!!!!
  asm("movl %%ebp,%0;" "movl %%esp,%1;" //get current thread ebp and esp
 b26:	89 48 08             	mov    %ecx,0x8(%eax)
    : "=r" (mainT->ebp) ,"=r"(mainT->esp)    
 b29:	8b 45 f4             	mov    -0xc(%ebp),%eax
uthread_init()
{  
  tTable.length=0;
  tTable.current=0;
  uthread_p mainT = allocThread(); //needed to allocate the main thread !!!!!!
  asm("movl %%ebp,%0;" "movl %%esp,%1;" //get current thread ebp and esp
 b2c:	89 50 04             	mov    %edx,0x4(%eax)
    : "=r" (mainT->ebp) ,"=r"(mainT->esp)    
  );
  /*moves stack to mainT's stack
  /stacks grow backwards so we start from esp and finsh at ebp*/
  memmove(mainT->stack , (void*)mainT->esp , mainT->ebp - mainT->esp);
 b2f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b32:	8b 50 08             	mov    0x8(%eax),%edx
 b35:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b38:	8b 40 04             	mov    0x4(%eax),%eax
 b3b:	89 d1                	mov    %edx,%ecx
 b3d:	29 c1                	sub    %eax,%ecx
 b3f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b42:	8b 40 04             	mov    0x4(%eax),%eax
 b45:	89 c2                	mov    %eax,%edx
 b47:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b4a:	8b 40 0c             	mov    0xc(%eax),%eax
 b4d:	89 4c 24 08          	mov    %ecx,0x8(%esp)
 b51:	89 54 24 04          	mov    %edx,0x4(%esp)
 b55:	89 04 24             	mov    %eax,(%esp)
 b58:	e8 a5 f8 ff ff       	call   402 <memmove>
  mainT->state = T_RUNNABLE;
 b5d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b60:	c7 40 10 03 00 00 00 	movl   $0x3,0x10(%eax)
  currentThread=mainT;
 b67:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b6a:	a3 68 58 00 00       	mov    %eax,0x5868
  if(signal(SIGALRM,uthread_yield)<0)
 b6f:	c7 44 24 04 6a 0d 00 	movl   $0xd6a,0x4(%esp)
 b76:	00 
 b77:	c7 04 24 0e 00 00 00 	movl   $0xe,(%esp)
 b7e:	e8 85 f9 ff ff       	call   508 <signal>
 b83:	85 c0                	test   %eax,%eax
 b85:	79 19                	jns    ba0 <uthread_init+0xa3>
  {
    printf(1,"Cant register the alarm signal");
 b87:	c7 44 24 04 7c 0e 00 	movl   $0xe7c,0x4(%esp)
 b8e:	00 
 b8f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 b96:	e8 5c fa ff ff       	call   5f7 <printf>
    exit();
 b9b:	e8 a8 f8 ff ff       	call   448 <exit>
  }
  if(alarm(THREAD_QUANTA)<0)
 ba0:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
 ba7:	e8 6c f9 ff ff       	call   518 <alarm>
 bac:	85 c0                	test   %eax,%eax
 bae:	79 19                	jns    bc9 <uthread_init+0xcc>
  {
    printf(1,"Cant activate alarm system call");
 bb0:	c7 44 24 04 9c 0e 00 	movl   $0xe9c,0x4(%esp)
 bb7:	00 
 bb8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 bbf:	e8 33 fa ff ff       	call   5f7 <printf>
    exit();
 bc4:	e8 7f f8 ff ff       	call   448 <exit>
  }
  
}
 bc9:	c9                   	leave  
 bca:	c3                   	ret    

00000bcb <uthread_create>:

int  
uthread_create(void (*start_func)(void *), void* arg)
{
 bcb:	55                   	push   %ebp
 bcc:	89 e5                	mov    %esp,%ebp
 bce:	83 ec 18             	sub    $0x18,%esp
  uthread_p t = allocThread();
 bd1:	e8 5f fe ff ff       	call   a35 <allocThread>
 bd6:	89 45 f4             	mov    %eax,-0xc(%ebp)
  
  asm("push %1;"  //stores the arguments to be used
 bd9:	8b 45 0c             	mov    0xc(%ebp),%eax
 bdc:	8b 55 08             	mov    0x8(%ebp),%edx
 bdf:	50                   	push   %eax
 be0:	52                   	push   %edx
 be1:	89 e2                	mov    %esp,%edx
      "push %2;"  //stores the start_func location
      "movl %%esp,%0;"
      : "=r" (t->esp)
 be3:	8b 45 f4             	mov    -0xc(%ebp),%eax
int  
uthread_create(void (*start_func)(void *), void* arg)
{
  uthread_p t = allocThread();
  
  asm("push %1;"  //stores the arguments to be used
 be6:	89 50 04             	mov    %edx,0x4(%eax)
      "push %2;"  //stores the start_func location
      "movl %%esp,%0;"
      : "=r" (t->esp)
      : "r" (arg) , "r"(start_func)
  );
  t->state= T_RUNNABLE;
 be9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 bec:	c7 40 10 03 00 00 00 	movl   $0x3,0x10(%eax)
  
  return t->tid;
 bf3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 bf6:	8b 00                	mov    (%eax),%eax
}
 bf8:	c9                   	leave  
 bf9:	c3                   	ret    

00000bfa <uthread_exit>:

void 
uthread_exit()
{
 bfa:	55                   	push   %ebp
 bfb:	89 e5                	mov    %esp,%ebp
 bfd:	83 ec 28             	sub    $0x28,%esp
  uthread_p newt;
  int old=currentThread->tid;
 c00:	a1 68 58 00 00       	mov    0x5868,%eax
 c05:	8b 00                	mov    (%eax),%eax
 c07:	89 45 f0             	mov    %eax,-0x10(%ebp)
  
  int i=0;
 c0a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  while(currentThread->waiting[i]!=-1)
 c11:	eb 25                	jmp    c38 <uthread_exit+0x3e>
  {
    (&tTable.table[currentThread->waiting[i]])->state=T_RUNNABLE;
 c13:	a1 68 58 00 00       	mov    0x5868,%eax
 c18:	8b 55 f4             	mov    -0xc(%ebp),%edx
 c1b:	83 c2 04             	add    $0x4,%edx
 c1e:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
 c22:	69 c0 18 01 00 00    	imul   $0x118,%eax,%eax
 c28:	05 60 12 00 00       	add    $0x1260,%eax
 c2d:	c7 40 10 03 00 00 00 	movl   $0x3,0x10(%eax)
    i++;
 c34:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
{
  uthread_p newt;
  int old=currentThread->tid;
  
  int i=0;
  while(currentThread->waiting[i]!=-1)
 c38:	a1 68 58 00 00       	mov    0x5868,%eax
 c3d:	8b 55 f4             	mov    -0xc(%ebp),%edx
 c40:	83 c2 04             	add    $0x4,%edx
 c43:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
 c47:	83 f8 ff             	cmp    $0xffffffff,%eax
 c4a:	75 c7                	jne    c13 <uthread_exit+0x19>
  {
    (&tTable.table[currentThread->waiting[i]])->state=T_RUNNABLE;
    i++;
  }
  currentThread->tid=-1;
 c4c:	a1 68 58 00 00       	mov    0x5868,%eax
 c51:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)
  currentThread->esp=-1;
 c57:	a1 68 58 00 00       	mov    0x5868,%eax
 c5c:	c7 40 04 ff ff ff ff 	movl   $0xffffffff,0x4(%eax)
  currentThread->ebp=-1;
 c63:	a1 68 58 00 00       	mov    0x5868,%eax
 c68:	c7 40 08 ff ff ff ff 	movl   $0xffffffff,0x8(%eax)
  free(currentThread->stack);
 c6f:	a1 68 58 00 00       	mov    0x5868,%eax
 c74:	8b 40 0c             	mov    0xc(%eax),%eax
 c77:	89 04 24             	mov    %eax,(%esp)
 c7a:	e8 2d fb ff ff       	call   7ac <free>
  currentThread->state=T_FREE;
 c7f:	a1 68 58 00 00       	mov    0x5868,%eax
 c84:	c7 40 10 00 00 00 00 	movl   $0x0,0x10(%eax)
  currentThread->firstTime=0;
 c8b:	a1 68 58 00 00       	mov    0x5868,%eax
 c90:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
  int new=getNextThread(old);
 c97:	8b 45 f0             	mov    -0x10(%ebp),%eax
 c9a:	89 04 24             	mov    %eax,(%esp)
 c9d:	e8 1a fd ff ff       	call   9bc <getNextThread>
 ca2:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if(new>=0)
 ca5:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 ca9:	78 36                	js     ce1 <uthread_exit+0xe7>
          {
             newt=&tTable.table[new];
 cab:	8b 45 ec             	mov    -0x14(%ebp),%eax
 cae:	69 c0 18 01 00 00    	imul   $0x118,%eax,%eax
 cb4:	05 60 12 00 00       	add    $0x1260,%eax
 cb9:	89 45 e8             	mov    %eax,-0x18(%ebp)
             newt->state=T_RUNNING;
 cbc:	8b 45 e8             	mov    -0x18(%ebp),%eax
 cbf:	c7 40 10 02 00 00 00 	movl   $0x2,0x10(%eax)
             LOAD_ESP(newt->esp);
 cc6:	8b 45 e8             	mov    -0x18(%ebp),%eax
 cc9:	8b 40 04             	mov    0x4(%eax),%eax
 ccc:	89 c4                	mov    %eax,%esp
             LOAD_EBP(newt->ebp);
 cce:	8b 45 e8             	mov    -0x18(%ebp),%eax
 cd1:	8b 40 08             	mov    0x8(%eax),%eax
 cd4:	89 c5                	mov    %eax,%ebp
             asm("popa");
 cd6:	61                   	popa   
             currentThread=newt;
 cd7:	8b 45 e8             	mov    -0x18(%ebp),%eax
 cda:	a3 68 58 00 00       	mov    %eax,0x5868
        {/////what if some thread state is sleeping?
             
             exit();
        }
     
}
 cdf:	c9                   	leave  
 ce0:	c3                   	ret    
             currentThread=newt;
          }
        else
        {/////what if some thread state is sleeping?
             
             exit();
 ce1:	e8 62 f7 ff ff       	call   448 <exit>

00000ce6 <uthred_join>:
}


int
uthred_join(int tid)
{
 ce6:	55                   	push   %ebp
 ce7:	89 e5                	mov    %esp,%ebp
 ce9:	83 ec 18             	sub    $0x18,%esp
  if((&tTable.table[tid])->state==T_FREE)
 cec:	8b 45 08             	mov    0x8(%ebp),%eax
 cef:	69 c0 18 01 00 00    	imul   $0x118,%eax,%eax
 cf5:	05 60 12 00 00       	add    $0x1260,%eax
 cfa:	8b 40 10             	mov    0x10(%eax),%eax
 cfd:	85 c0                	test   %eax,%eax
 cff:	75 07                	jne    d08 <uthred_join+0x22>
    return -1;
 d01:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 d06:	eb 60                	jmp    d68 <uthred_join+0x82>
  else
  {
      int i=0;
 d08:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
      while((&tTable.table[tid])->waiting[i]!=-1)
 d0f:	eb 04                	jmp    d15 <uthred_join+0x2f>
        i++;
 d11:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  if((&tTable.table[tid])->state==T_FREE)
    return -1;
  else
  {
      int i=0;
      while((&tTable.table[tid])->waiting[i]!=-1)
 d15:	8b 45 08             	mov    0x8(%ebp),%eax
 d18:	69 c0 18 01 00 00    	imul   $0x118,%eax,%eax
 d1e:	05 60 12 00 00       	add    $0x1260,%eax
 d23:	8b 55 f4             	mov    -0xc(%ebp),%edx
 d26:	83 c2 04             	add    $0x4,%edx
 d29:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
 d2d:	83 f8 ff             	cmp    $0xffffffff,%eax
 d30:	75 df                	jne    d11 <uthred_join+0x2b>
        i++;
      (&tTable.table[tid])->waiting[i]=currentThread->tid;
 d32:	8b 45 08             	mov    0x8(%ebp),%eax
 d35:	69 c0 18 01 00 00    	imul   $0x118,%eax,%eax
 d3b:	8d 90 60 12 00 00    	lea    0x1260(%eax),%edx
 d41:	a1 68 58 00 00       	mov    0x5868,%eax
 d46:	8b 00                	mov    (%eax),%eax
 d48:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 d4b:	83 c1 04             	add    $0x4,%ecx
 d4e:	89 44 8a 08          	mov    %eax,0x8(%edx,%ecx,4)
      currentThread->state=T_SLEEPING;
 d52:	a1 68 58 00 00       	mov    0x5868,%eax
 d57:	c7 40 10 04 00 00 00 	movl   $0x4,0x10(%eax)
      uthread_yield();
 d5e:	e8 07 00 00 00       	call   d6a <uthread_yield>
      return 1;
 d63:	b8 01 00 00 00       	mov    $0x1,%eax
  }
}
 d68:	c9                   	leave  
 d69:	c3                   	ret    

00000d6a <uthread_yield>:

void 
uthread_yield()
{
 d6a:	55                   	push   %ebp
 d6b:	89 e5                	mov    %esp,%ebp
 d6d:	83 ec 28             	sub    $0x28,%esp
  uthread_p newt;
  int old=currentThread->tid;
 d70:	a1 68 58 00 00       	mov    0x5868,%eax
 d75:	8b 00                	mov    (%eax),%eax
 d77:	89 45 f4             	mov    %eax,-0xc(%ebp)
  int new=getNextThread(old);
 d7a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 d7d:	89 04 24             	mov    %eax,(%esp)
 d80:	e8 37 fc ff ff       	call   9bc <getNextThread>
 d85:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(new<0)
 d88:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 d8c:	79 19                	jns    da7 <uthread_yield+0x3d>
  {
     printf(1,"(fun uthread_yield)Cant find runnable thread");
 d8e:	c7 44 24 04 bc 0e 00 	movl   $0xebc,0x4(%esp)
 d95:	00 
 d96:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 d9d:	e8 55 f8 ff ff       	call   5f7 <printf>
    exit();
 da2:	e8 a1 f6 ff ff       	call   448 <exit>
  }
newt=&tTable.table[new];
 da7:	8b 45 f0             	mov    -0x10(%ebp),%eax
 daa:	69 c0 18 01 00 00    	imul   $0x118,%eax,%eax
 db0:	05 60 12 00 00       	add    $0x1260,%eax
 db5:	89 45 ec             	mov    %eax,-0x14(%ebp)
  
    asm("pusha");
 db8:	60                   	pusha  
    STORE_ESP(currentThread->esp);
 db9:	a1 68 58 00 00       	mov    0x5868,%eax
 dbe:	89 e2                	mov    %esp,%edx
 dc0:	89 50 04             	mov    %edx,0x4(%eax)
    if(currentThread->state==T_RUNNING)
 dc3:	a1 68 58 00 00       	mov    0x5868,%eax
 dc8:	8b 40 10             	mov    0x10(%eax),%eax
 dcb:	83 f8 02             	cmp    $0x2,%eax
 dce:	75 0c                	jne    ddc <uthread_yield+0x72>
      currentThread->state=T_RUNNABLE;
 dd0:	a1 68 58 00 00       	mov    0x5868,%eax
 dd5:	c7 40 10 03 00 00 00 	movl   $0x3,0x10(%eax)
    LOAD_ESP(newt->esp);
 ddc:	8b 45 ec             	mov    -0x14(%ebp),%eax
 ddf:	8b 40 04             	mov    0x4(%eax),%eax
 de2:	89 c4                	mov    %eax,%esp
    
  
    newt->state=T_RUNNING;
 de4:	8b 45 ec             	mov    -0x14(%ebp),%eax
 de7:	c7 40 10 02 00 00 00 	movl   $0x2,0x10(%eax)

    asm("popa");
 dee:	61                   	popa   
    if(currentThread->firstTime==0)
 def:	a1 68 58 00 00       	mov    0x5868,%eax
 df4:	8b 40 14             	mov    0x14(%eax),%eax
 df7:	85 c0                	test   %eax,%eax
 df9:	75 0d                	jne    e08 <uthread_yield+0x9e>
    {
       asm("ret");////only firest time
 dfb:	c3                   	ret    
       currentThread->firstTime=1;
 dfc:	a1 68 58 00 00       	mov    0x5868,%eax
 e01:	c7 40 14 01 00 00 00 	movl   $0x1,0x14(%eax)
    }
   
currentThread=newt;
 e08:	8b 45 ec             	mov    -0x14(%ebp),%eax
 e0b:	a3 68 58 00 00       	mov    %eax,0x5868

}
 e10:	c9                   	leave  
 e11:	c3                   	ret    

00000e12 <uthred_self>:

int  uthred_self(void)
{
 e12:	55                   	push   %ebp
 e13:	89 e5                	mov    %esp,%ebp
  return currentThread->tid;
 e15:	a1 68 58 00 00       	mov    0x5868,%eax
 e1a:	8b 00                	mov    (%eax),%eax
}
 e1c:	5d                   	pop    %ebp
 e1d:	c3                   	ret    
