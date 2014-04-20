
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
  85:	c7 44 24 04 a4 09 00 	movl   $0x9a4,0x4(%esp)
  8c:	00 
  8d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  94:	e8 46 05 00 00       	call   5df <printf>
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
 1b9:	c7 44 24 04 c8 09 00 	movl   $0x9c8,0x4(%esp)
 1c0:	00 
 1c1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 1c8:	e8 12 04 00 00       	call   5df <printf>
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

00000508 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 508:	55                   	push   %ebp
 509:	89 e5                	mov    %esp,%ebp
 50b:	83 ec 28             	sub    $0x28,%esp
 50e:	8b 45 0c             	mov    0xc(%ebp),%eax
 511:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 514:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 51b:	00 
 51c:	8d 45 f4             	lea    -0xc(%ebp),%eax
 51f:	89 44 24 04          	mov    %eax,0x4(%esp)
 523:	8b 45 08             	mov    0x8(%ebp),%eax
 526:	89 04 24             	mov    %eax,(%esp)
 529:	e8 3a ff ff ff       	call   468 <write>
}
 52e:	c9                   	leave  
 52f:	c3                   	ret    

00000530 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 530:	55                   	push   %ebp
 531:	89 e5                	mov    %esp,%ebp
 533:	83 ec 48             	sub    $0x48,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 536:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 53d:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 541:	74 17                	je     55a <printint+0x2a>
 543:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 547:	79 11                	jns    55a <printint+0x2a>
    neg = 1;
 549:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 550:	8b 45 0c             	mov    0xc(%ebp),%eax
 553:	f7 d8                	neg    %eax
 555:	89 45 ec             	mov    %eax,-0x14(%ebp)
 558:	eb 06                	jmp    560 <printint+0x30>
  } else {
    x = xx;
 55a:	8b 45 0c             	mov    0xc(%ebp),%eax
 55d:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 560:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 567:	8b 4d 10             	mov    0x10(%ebp),%ecx
 56a:	8b 45 ec             	mov    -0x14(%ebp),%eax
 56d:	ba 00 00 00 00       	mov    $0x0,%edx
 572:	f7 f1                	div    %ecx
 574:	89 d0                	mov    %edx,%eax
 576:	0f b6 90 3c 0c 00 00 	movzbl 0xc3c(%eax),%edx
 57d:	8d 45 dc             	lea    -0x24(%ebp),%eax
 580:	03 45 f4             	add    -0xc(%ebp),%eax
 583:	88 10                	mov    %dl,(%eax)
 585:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  }while((x /= base) != 0);
 589:	8b 55 10             	mov    0x10(%ebp),%edx
 58c:	89 55 d4             	mov    %edx,-0x2c(%ebp)
 58f:	8b 45 ec             	mov    -0x14(%ebp),%eax
 592:	ba 00 00 00 00       	mov    $0x0,%edx
 597:	f7 75 d4             	divl   -0x2c(%ebp)
 59a:	89 45 ec             	mov    %eax,-0x14(%ebp)
 59d:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 5a1:	75 c4                	jne    567 <printint+0x37>
  if(neg)
 5a3:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 5a7:	74 2a                	je     5d3 <printint+0xa3>
    buf[i++] = '-';
 5a9:	8d 45 dc             	lea    -0x24(%ebp),%eax
 5ac:	03 45 f4             	add    -0xc(%ebp),%eax
 5af:	c6 00 2d             	movb   $0x2d,(%eax)
 5b2:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)

  while(--i >= 0)
 5b6:	eb 1b                	jmp    5d3 <printint+0xa3>
    putc(fd, buf[i]);
 5b8:	8d 45 dc             	lea    -0x24(%ebp),%eax
 5bb:	03 45 f4             	add    -0xc(%ebp),%eax
 5be:	0f b6 00             	movzbl (%eax),%eax
 5c1:	0f be c0             	movsbl %al,%eax
 5c4:	89 44 24 04          	mov    %eax,0x4(%esp)
 5c8:	8b 45 08             	mov    0x8(%ebp),%eax
 5cb:	89 04 24             	mov    %eax,(%esp)
 5ce:	e8 35 ff ff ff       	call   508 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 5d3:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 5d7:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 5db:	79 db                	jns    5b8 <printint+0x88>
    putc(fd, buf[i]);
}
 5dd:	c9                   	leave  
 5de:	c3                   	ret    

000005df <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 5df:	55                   	push   %ebp
 5e0:	89 e5                	mov    %esp,%ebp
 5e2:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 5e5:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 5ec:	8d 45 0c             	lea    0xc(%ebp),%eax
 5ef:	83 c0 04             	add    $0x4,%eax
 5f2:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 5f5:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 5fc:	e9 7d 01 00 00       	jmp    77e <printf+0x19f>
    c = fmt[i] & 0xff;
 601:	8b 55 0c             	mov    0xc(%ebp),%edx
 604:	8b 45 f0             	mov    -0x10(%ebp),%eax
 607:	01 d0                	add    %edx,%eax
 609:	0f b6 00             	movzbl (%eax),%eax
 60c:	0f be c0             	movsbl %al,%eax
 60f:	25 ff 00 00 00       	and    $0xff,%eax
 614:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 617:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 61b:	75 2c                	jne    649 <printf+0x6a>
      if(c == '%'){
 61d:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 621:	75 0c                	jne    62f <printf+0x50>
        state = '%';
 623:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 62a:	e9 4b 01 00 00       	jmp    77a <printf+0x19b>
      } else {
        putc(fd, c);
 62f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 632:	0f be c0             	movsbl %al,%eax
 635:	89 44 24 04          	mov    %eax,0x4(%esp)
 639:	8b 45 08             	mov    0x8(%ebp),%eax
 63c:	89 04 24             	mov    %eax,(%esp)
 63f:	e8 c4 fe ff ff       	call   508 <putc>
 644:	e9 31 01 00 00       	jmp    77a <printf+0x19b>
      }
    } else if(state == '%'){
 649:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 64d:	0f 85 27 01 00 00    	jne    77a <printf+0x19b>
      if(c == 'd'){
 653:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 657:	75 2d                	jne    686 <printf+0xa7>
        printint(fd, *ap, 10, 1);
 659:	8b 45 e8             	mov    -0x18(%ebp),%eax
 65c:	8b 00                	mov    (%eax),%eax
 65e:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
 665:	00 
 666:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
 66d:	00 
 66e:	89 44 24 04          	mov    %eax,0x4(%esp)
 672:	8b 45 08             	mov    0x8(%ebp),%eax
 675:	89 04 24             	mov    %eax,(%esp)
 678:	e8 b3 fe ff ff       	call   530 <printint>
        ap++;
 67d:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 681:	e9 ed 00 00 00       	jmp    773 <printf+0x194>
      } else if(c == 'x' || c == 'p'){
 686:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 68a:	74 06                	je     692 <printf+0xb3>
 68c:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 690:	75 2d                	jne    6bf <printf+0xe0>
        printint(fd, *ap, 16, 0);
 692:	8b 45 e8             	mov    -0x18(%ebp),%eax
 695:	8b 00                	mov    (%eax),%eax
 697:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 69e:	00 
 69f:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 6a6:	00 
 6a7:	89 44 24 04          	mov    %eax,0x4(%esp)
 6ab:	8b 45 08             	mov    0x8(%ebp),%eax
 6ae:	89 04 24             	mov    %eax,(%esp)
 6b1:	e8 7a fe ff ff       	call   530 <printint>
        ap++;
 6b6:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 6ba:	e9 b4 00 00 00       	jmp    773 <printf+0x194>
      } else if(c == 's'){
 6bf:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 6c3:	75 46                	jne    70b <printf+0x12c>
        s = (char*)*ap;
 6c5:	8b 45 e8             	mov    -0x18(%ebp),%eax
 6c8:	8b 00                	mov    (%eax),%eax
 6ca:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 6cd:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 6d1:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 6d5:	75 27                	jne    6fe <printf+0x11f>
          s = "(null)";
 6d7:	c7 45 f4 f7 09 00 00 	movl   $0x9f7,-0xc(%ebp)
        while(*s != 0){
 6de:	eb 1e                	jmp    6fe <printf+0x11f>
          putc(fd, *s);
 6e0:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6e3:	0f b6 00             	movzbl (%eax),%eax
 6e6:	0f be c0             	movsbl %al,%eax
 6e9:	89 44 24 04          	mov    %eax,0x4(%esp)
 6ed:	8b 45 08             	mov    0x8(%ebp),%eax
 6f0:	89 04 24             	mov    %eax,(%esp)
 6f3:	e8 10 fe ff ff       	call   508 <putc>
          s++;
 6f8:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 6fc:	eb 01                	jmp    6ff <printf+0x120>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 6fe:	90                   	nop
 6ff:	8b 45 f4             	mov    -0xc(%ebp),%eax
 702:	0f b6 00             	movzbl (%eax),%eax
 705:	84 c0                	test   %al,%al
 707:	75 d7                	jne    6e0 <printf+0x101>
 709:	eb 68                	jmp    773 <printf+0x194>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 70b:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 70f:	75 1d                	jne    72e <printf+0x14f>
        putc(fd, *ap);
 711:	8b 45 e8             	mov    -0x18(%ebp),%eax
 714:	8b 00                	mov    (%eax),%eax
 716:	0f be c0             	movsbl %al,%eax
 719:	89 44 24 04          	mov    %eax,0x4(%esp)
 71d:	8b 45 08             	mov    0x8(%ebp),%eax
 720:	89 04 24             	mov    %eax,(%esp)
 723:	e8 e0 fd ff ff       	call   508 <putc>
        ap++;
 728:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 72c:	eb 45                	jmp    773 <printf+0x194>
      } else if(c == '%'){
 72e:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 732:	75 17                	jne    74b <printf+0x16c>
        putc(fd, c);
 734:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 737:	0f be c0             	movsbl %al,%eax
 73a:	89 44 24 04          	mov    %eax,0x4(%esp)
 73e:	8b 45 08             	mov    0x8(%ebp),%eax
 741:	89 04 24             	mov    %eax,(%esp)
 744:	e8 bf fd ff ff       	call   508 <putc>
 749:	eb 28                	jmp    773 <printf+0x194>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 74b:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
 752:	00 
 753:	8b 45 08             	mov    0x8(%ebp),%eax
 756:	89 04 24             	mov    %eax,(%esp)
 759:	e8 aa fd ff ff       	call   508 <putc>
        putc(fd, c);
 75e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 761:	0f be c0             	movsbl %al,%eax
 764:	89 44 24 04          	mov    %eax,0x4(%esp)
 768:	8b 45 08             	mov    0x8(%ebp),%eax
 76b:	89 04 24             	mov    %eax,(%esp)
 76e:	e8 95 fd ff ff       	call   508 <putc>
      }
      state = 0;
 773:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 77a:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 77e:	8b 55 0c             	mov    0xc(%ebp),%edx
 781:	8b 45 f0             	mov    -0x10(%ebp),%eax
 784:	01 d0                	add    %edx,%eax
 786:	0f b6 00             	movzbl (%eax),%eax
 789:	84 c0                	test   %al,%al
 78b:	0f 85 70 fe ff ff    	jne    601 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 791:	c9                   	leave  
 792:	c3                   	ret    
 793:	90                   	nop

00000794 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 794:	55                   	push   %ebp
 795:	89 e5                	mov    %esp,%ebp
 797:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 79a:	8b 45 08             	mov    0x8(%ebp),%eax
 79d:	83 e8 08             	sub    $0x8,%eax
 7a0:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7a3:	a1 58 0c 00 00       	mov    0xc58,%eax
 7a8:	89 45 fc             	mov    %eax,-0x4(%ebp)
 7ab:	eb 24                	jmp    7d1 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7ad:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7b0:	8b 00                	mov    (%eax),%eax
 7b2:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 7b5:	77 12                	ja     7c9 <free+0x35>
 7b7:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7ba:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 7bd:	77 24                	ja     7e3 <free+0x4f>
 7bf:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7c2:	8b 00                	mov    (%eax),%eax
 7c4:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 7c7:	77 1a                	ja     7e3 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7c9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7cc:	8b 00                	mov    (%eax),%eax
 7ce:	89 45 fc             	mov    %eax,-0x4(%ebp)
 7d1:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7d4:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 7d7:	76 d4                	jbe    7ad <free+0x19>
 7d9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7dc:	8b 00                	mov    (%eax),%eax
 7de:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 7e1:	76 ca                	jbe    7ad <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 7e3:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7e6:	8b 40 04             	mov    0x4(%eax),%eax
 7e9:	c1 e0 03             	shl    $0x3,%eax
 7ec:	89 c2                	mov    %eax,%edx
 7ee:	03 55 f8             	add    -0x8(%ebp),%edx
 7f1:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7f4:	8b 00                	mov    (%eax),%eax
 7f6:	39 c2                	cmp    %eax,%edx
 7f8:	75 24                	jne    81e <free+0x8a>
    bp->s.size += p->s.ptr->s.size;
 7fa:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7fd:	8b 50 04             	mov    0x4(%eax),%edx
 800:	8b 45 fc             	mov    -0x4(%ebp),%eax
 803:	8b 00                	mov    (%eax),%eax
 805:	8b 40 04             	mov    0x4(%eax),%eax
 808:	01 c2                	add    %eax,%edx
 80a:	8b 45 f8             	mov    -0x8(%ebp),%eax
 80d:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 810:	8b 45 fc             	mov    -0x4(%ebp),%eax
 813:	8b 00                	mov    (%eax),%eax
 815:	8b 10                	mov    (%eax),%edx
 817:	8b 45 f8             	mov    -0x8(%ebp),%eax
 81a:	89 10                	mov    %edx,(%eax)
 81c:	eb 0a                	jmp    828 <free+0x94>
  } else
    bp->s.ptr = p->s.ptr;
 81e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 821:	8b 10                	mov    (%eax),%edx
 823:	8b 45 f8             	mov    -0x8(%ebp),%eax
 826:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 828:	8b 45 fc             	mov    -0x4(%ebp),%eax
 82b:	8b 40 04             	mov    0x4(%eax),%eax
 82e:	c1 e0 03             	shl    $0x3,%eax
 831:	03 45 fc             	add    -0x4(%ebp),%eax
 834:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 837:	75 20                	jne    859 <free+0xc5>
    p->s.size += bp->s.size;
 839:	8b 45 fc             	mov    -0x4(%ebp),%eax
 83c:	8b 50 04             	mov    0x4(%eax),%edx
 83f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 842:	8b 40 04             	mov    0x4(%eax),%eax
 845:	01 c2                	add    %eax,%edx
 847:	8b 45 fc             	mov    -0x4(%ebp),%eax
 84a:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 84d:	8b 45 f8             	mov    -0x8(%ebp),%eax
 850:	8b 10                	mov    (%eax),%edx
 852:	8b 45 fc             	mov    -0x4(%ebp),%eax
 855:	89 10                	mov    %edx,(%eax)
 857:	eb 08                	jmp    861 <free+0xcd>
  } else
    p->s.ptr = bp;
 859:	8b 45 fc             	mov    -0x4(%ebp),%eax
 85c:	8b 55 f8             	mov    -0x8(%ebp),%edx
 85f:	89 10                	mov    %edx,(%eax)
  freep = p;
 861:	8b 45 fc             	mov    -0x4(%ebp),%eax
 864:	a3 58 0c 00 00       	mov    %eax,0xc58
}
 869:	c9                   	leave  
 86a:	c3                   	ret    

0000086b <morecore>:

static Header*
morecore(uint nu)
{
 86b:	55                   	push   %ebp
 86c:	89 e5                	mov    %esp,%ebp
 86e:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 871:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 878:	77 07                	ja     881 <morecore+0x16>
    nu = 4096;
 87a:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 881:	8b 45 08             	mov    0x8(%ebp),%eax
 884:	c1 e0 03             	shl    $0x3,%eax
 887:	89 04 24             	mov    %eax,(%esp)
 88a:	e8 41 fc ff ff       	call   4d0 <sbrk>
 88f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 892:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 896:	75 07                	jne    89f <morecore+0x34>
    return 0;
 898:	b8 00 00 00 00       	mov    $0x0,%eax
 89d:	eb 22                	jmp    8c1 <morecore+0x56>
  hp = (Header*)p;
 89f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8a2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 8a5:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8a8:	8b 55 08             	mov    0x8(%ebp),%edx
 8ab:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 8ae:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8b1:	83 c0 08             	add    $0x8,%eax
 8b4:	89 04 24             	mov    %eax,(%esp)
 8b7:	e8 d8 fe ff ff       	call   794 <free>
  return freep;
 8bc:	a1 58 0c 00 00       	mov    0xc58,%eax
}
 8c1:	c9                   	leave  
 8c2:	c3                   	ret    

000008c3 <malloc>:

void*
malloc(uint nbytes)
{
 8c3:	55                   	push   %ebp
 8c4:	89 e5                	mov    %esp,%ebp
 8c6:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8c9:	8b 45 08             	mov    0x8(%ebp),%eax
 8cc:	83 c0 07             	add    $0x7,%eax
 8cf:	c1 e8 03             	shr    $0x3,%eax
 8d2:	83 c0 01             	add    $0x1,%eax
 8d5:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 8d8:	a1 58 0c 00 00       	mov    0xc58,%eax
 8dd:	89 45 f0             	mov    %eax,-0x10(%ebp)
 8e0:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 8e4:	75 23                	jne    909 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 8e6:	c7 45 f0 50 0c 00 00 	movl   $0xc50,-0x10(%ebp)
 8ed:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8f0:	a3 58 0c 00 00       	mov    %eax,0xc58
 8f5:	a1 58 0c 00 00       	mov    0xc58,%eax
 8fa:	a3 50 0c 00 00       	mov    %eax,0xc50
    base.s.size = 0;
 8ff:	c7 05 54 0c 00 00 00 	movl   $0x0,0xc54
 906:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 909:	8b 45 f0             	mov    -0x10(%ebp),%eax
 90c:	8b 00                	mov    (%eax),%eax
 90e:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 911:	8b 45 f4             	mov    -0xc(%ebp),%eax
 914:	8b 40 04             	mov    0x4(%eax),%eax
 917:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 91a:	72 4d                	jb     969 <malloc+0xa6>
      if(p->s.size == nunits)
 91c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 91f:	8b 40 04             	mov    0x4(%eax),%eax
 922:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 925:	75 0c                	jne    933 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 927:	8b 45 f4             	mov    -0xc(%ebp),%eax
 92a:	8b 10                	mov    (%eax),%edx
 92c:	8b 45 f0             	mov    -0x10(%ebp),%eax
 92f:	89 10                	mov    %edx,(%eax)
 931:	eb 26                	jmp    959 <malloc+0x96>
      else {
        p->s.size -= nunits;
 933:	8b 45 f4             	mov    -0xc(%ebp),%eax
 936:	8b 40 04             	mov    0x4(%eax),%eax
 939:	89 c2                	mov    %eax,%edx
 93b:	2b 55 ec             	sub    -0x14(%ebp),%edx
 93e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 941:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 944:	8b 45 f4             	mov    -0xc(%ebp),%eax
 947:	8b 40 04             	mov    0x4(%eax),%eax
 94a:	c1 e0 03             	shl    $0x3,%eax
 94d:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 950:	8b 45 f4             	mov    -0xc(%ebp),%eax
 953:	8b 55 ec             	mov    -0x14(%ebp),%edx
 956:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 959:	8b 45 f0             	mov    -0x10(%ebp),%eax
 95c:	a3 58 0c 00 00       	mov    %eax,0xc58
      return (void*)(p + 1);
 961:	8b 45 f4             	mov    -0xc(%ebp),%eax
 964:	83 c0 08             	add    $0x8,%eax
 967:	eb 38                	jmp    9a1 <malloc+0xde>
    }
    if(p == freep)
 969:	a1 58 0c 00 00       	mov    0xc58,%eax
 96e:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 971:	75 1b                	jne    98e <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
 973:	8b 45 ec             	mov    -0x14(%ebp),%eax
 976:	89 04 24             	mov    %eax,(%esp)
 979:	e8 ed fe ff ff       	call   86b <morecore>
 97e:	89 45 f4             	mov    %eax,-0xc(%ebp)
 981:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 985:	75 07                	jne    98e <malloc+0xcb>
        return 0;
 987:	b8 00 00 00 00       	mov    $0x0,%eax
 98c:	eb 13                	jmp    9a1 <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 98e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 991:	89 45 f0             	mov    %eax,-0x10(%ebp)
 994:	8b 45 f4             	mov    -0xc(%ebp),%eax
 997:	8b 00                	mov    (%eax),%eax
 999:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 99c:	e9 70 ff ff ff       	jmp    911 <malloc+0x4e>
}
 9a1:	c9                   	leave  
 9a2:	c3                   	ret    
