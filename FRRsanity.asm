
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
      85:	c7 44 24 04 10 11 00 	movl   $0x1110,0x4(%esp)
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
     1b9:	c7 44 24 04 34 11 00 	movl   $0x1134,0x4(%esp)
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
     58e:	0f b6 90 5c 16 00 00 	movzbl 0x165c(%eax),%edx
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
     6ef:	c7 45 f4 63 11 00 00 	movl   $0x1163,-0xc(%ebp)
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
     7bb:	a1 88 16 00 00       	mov    0x1688,%eax
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
     87c:	a3 88 16 00 00       	mov    %eax,0x1688
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
     8d4:	a1 88 16 00 00       	mov    0x1688,%eax
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
     8f0:	a1 88 16 00 00       	mov    0x1688,%eax
     8f5:	89 45 f0             	mov    %eax,-0x10(%ebp)
     8f8:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     8fc:	75 23                	jne    921 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     8fe:	c7 45 f0 80 16 00 00 	movl   $0x1680,-0x10(%ebp)
     905:	8b 45 f0             	mov    -0x10(%ebp),%eax
     908:	a3 88 16 00 00       	mov    %eax,0x1688
     90d:	a1 88 16 00 00       	mov    0x1688,%eax
     912:	a3 80 16 00 00       	mov    %eax,0x1680
    base.s.size = 0;
     917:	c7 05 84 16 00 00 00 	movl   $0x0,0x1684
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
     974:	a3 88 16 00 00       	mov    %eax,0x1688
      return (void*)(p + 1);
     979:	8b 45 f4             	mov    -0xc(%ebp),%eax
     97c:	83 c0 08             	add    $0x8,%eax
     97f:	eb 38                	jmp    9b9 <malloc+0xde>
    }
    if(p == freep)
     981:	a1 88 16 00 00       	mov    0x1688,%eax
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

000009bc <print_stack>:
 * prints the stack of the currently running thread
 * DEBUGGING purposes
 */
void
print_stack()
{
     9bc:	55                   	push   %ebp
     9bd:	89 e5                	mov    %esp,%ebp
     9bf:	83 ec 28             	sub    $0x28,%esp
  int *newesp = (int*)currentThread->esp;  
     9c2:	a1 a0 5f 00 00       	mov    0x5fa0,%eax
     9c7:	8b 40 04             	mov    0x4(%eax),%eax
     9ca:	89 45 f4             	mov    %eax,-0xc(%ebp)
  printf(1,"stack for thread %d \n",currentThread->tid);
     9cd:	a1 a0 5f 00 00       	mov    0x5fa0,%eax
     9d2:	8b 00                	mov    (%eax),%eax
     9d4:	89 44 24 08          	mov    %eax,0x8(%esp)
     9d8:	c7 44 24 04 6c 11 00 	movl   $0x116c,0x4(%esp)
     9df:	00 
     9e0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     9e7:	e8 0b fc ff ff       	call   5f7 <printf>
  while((newesp < (int *)currentThread->ebp))
     9ec:	eb 3c                	jmp    a2a <print_stack+0x6e>
  {
    printf(1,"add:%x ",newesp);
     9ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
     9f1:	89 44 24 08          	mov    %eax,0x8(%esp)
     9f5:	c7 44 24 04 82 11 00 	movl   $0x1182,0x4(%esp)
     9fc:	00 
     9fd:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     a04:	e8 ee fb ff ff       	call   5f7 <printf>
      printf(1,"val:%x\n",*newesp);
     a09:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a0c:	8b 00                	mov    (%eax),%eax
     a0e:	89 44 24 08          	mov    %eax,0x8(%esp)
     a12:	c7 44 24 04 8a 11 00 	movl   $0x118a,0x4(%esp)
     a19:	00 
     a1a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     a21:	e8 d1 fb ff ff       	call   5f7 <printf>
    newesp++;
     a26:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
void
print_stack()
{
  int *newesp = (int*)currentThread->esp;  
  printf(1,"stack for thread %d \n",currentThread->tid);
  while((newesp < (int *)currentThread->ebp))
     a2a:	a1 a0 5f 00 00       	mov    0x5fa0,%eax
     a2f:	8b 40 08             	mov    0x8(%eax),%eax
     a32:	3b 45 f4             	cmp    -0xc(%ebp),%eax
     a35:	77 b7                	ja     9ee <print_stack+0x32>
    printf(1,"add:%x ",newesp);
      printf(1,"val:%x\n",*newesp);
    newesp++;
  }

}
     a37:	c9                   	leave  
     a38:	c3                   	ret    

00000a39 <getNextThread>:
 * returns the next thread in line to run
 * if none exists it returns -1
 */
int
getNextThread(int j)
{
     a39:	55                   	push   %ebp
     a3a:	89 e5                	mov    %esp,%ebp
     a3c:	83 ec 10             	sub    $0x10,%esp
  int i=j+1;
     a3f:	8b 45 08             	mov    0x8(%ebp),%eax
     a42:	83 c0 01             	add    $0x1,%eax
     a45:	89 45 fc             	mov    %eax,-0x4(%ebp)
  if(i==MAX_THREAD)
     a48:	83 7d fc 40          	cmpl   $0x40,-0x4(%ebp)
     a4c:	75 07                	jne    a55 <getNextThread+0x1c>
    i=0;
     a4e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  uthread_p t=&tTable.table[i];
     a55:	8b 45 fc             	mov    -0x4(%ebp),%eax
     a58:	69 c0 24 01 00 00    	imul   $0x124,%eax,%eax
     a5e:	05 a0 16 00 00       	add    $0x16a0,%eax
     a63:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(i!=j)
     a66:	eb 3b                	jmp    aa3 <getNextThread+0x6a>
  {
    if(t->state==T_RUNNABLE)
     a68:	8b 45 f8             	mov    -0x8(%ebp),%eax
     a6b:	8b 40 10             	mov    0x10(%eax),%eax
     a6e:	83 f8 03             	cmp    $0x3,%eax
     a71:	75 05                	jne    a78 <getNextThread+0x3f>
      return i;
     a73:	8b 45 fc             	mov    -0x4(%ebp),%eax
     a76:	eb 38                	jmp    ab0 <getNextThread+0x77>
    i++;
     a78:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    if(i==MAX_THREAD)
     a7c:	83 7d fc 40          	cmpl   $0x40,-0x4(%ebp)
     a80:	75 1a                	jne    a9c <getNextThread+0x63>
    {
     i=0;
     a82:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
     t=&tTable.table[i];
     a89:	8b 45 fc             	mov    -0x4(%ebp),%eax
     a8c:	69 c0 24 01 00 00    	imul   $0x124,%eax,%eax
     a92:	05 a0 16 00 00       	add    $0x16a0,%eax
     a97:	89 45 f8             	mov    %eax,-0x8(%ebp)
     a9a:	eb 07                	jmp    aa3 <getNextThread+0x6a>
   }
   else
    t++;
     a9c:	81 45 f8 24 01 00 00 	addl   $0x124,-0x8(%ebp)
{
  int i=j+1;
  if(i==MAX_THREAD)
    i=0;
  uthread_p t=&tTable.table[i];
  while(i!=j)
     aa3:	8b 45 fc             	mov    -0x4(%ebp),%eax
     aa6:	3b 45 08             	cmp    0x8(%ebp),%eax
     aa9:	75 bd                	jne    a68 <getNextThread+0x2f>
   }
   else
    t++;

}
return -1;
     aab:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
     ab0:	c9                   	leave  
     ab1:	c3                   	ret    

00000ab2 <allocThread>:
 * allocates a spot for a new thread
 * if none exist it returns NULL
 */
static uthread_p
allocThread()
{
     ab2:	55                   	push   %ebp
     ab3:	89 e5                	mov    %esp,%ebp
     ab5:	83 ec 28             	sub    $0x28,%esp
  int i,j;
  uthread_p t;
  
  for (t=tTable.table,i=0 ; t < &tTable.table[MAX_THREAD]; t++,i++)
     ab8:	c7 45 ec a0 16 00 00 	movl   $0x16a0,-0x14(%ebp)
     abf:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     ac6:	eb 15                	jmp    add <allocThread+0x2b>
  {
    if(t->state==T_FREE)
     ac8:	8b 45 ec             	mov    -0x14(%ebp),%eax
     acb:	8b 40 10             	mov    0x10(%eax),%eax
     ace:	85 c0                	test   %eax,%eax
     ad0:	74 1e                	je     af0 <allocThread+0x3e>
allocThread()
{
  int i,j;
  uthread_p t;
  
  for (t=tTable.table,i=0 ; t < &tTable.table[MAX_THREAD]; t++,i++)
     ad2:	81 45 ec 24 01 00 00 	addl   $0x124,-0x14(%ebp)
     ad9:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     add:	81 7d ec a0 5f 00 00 	cmpl   $0x5fa0,-0x14(%ebp)
     ae4:	72 e2                	jb     ac8 <allocThread+0x16>
  {
    if(t->state==T_FREE)
      goto found;
  }
  return 0;
     ae6:	b8 00 00 00 00       	mov    $0x0,%eax
     aeb:	e9 a3 00 00 00       	jmp    b93 <allocThread+0xe1>
  uthread_p t;
  
  for (t=tTable.table,i=0 ; t < &tTable.table[MAX_THREAD]; t++,i++)
  {
    if(t->state==T_FREE)
      goto found;
     af0:	90                   	nop
  }
  return 0;
  
  found:
  //Init all fields
  t->tid=i;
     af1:	8b 45 ec             	mov    -0x14(%ebp),%eax
     af4:	8b 55 f4             	mov    -0xc(%ebp),%edx
     af7:	89 10                	mov    %edx,(%eax)
  if(i==0) //main thread init
     af9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     afd:	75 1c                	jne    b1b <allocThread+0x69>
  {
    STORE_ESP(t->esp);
     aff:	89 e2                	mov    %esp,%edx
     b01:	8b 45 ec             	mov    -0x14(%ebp),%eax
     b04:	89 50 04             	mov    %edx,0x4(%eax)
    STORE_EBP(t->ebp);
     b07:	89 ea                	mov    %ebp,%edx
     b09:	8b 45 ec             	mov    -0x14(%ebp),%eax
     b0c:	89 50 08             	mov    %edx,0x8(%eax)
    t->firstTime=0;
     b0f:	8b 45 ec             	mov    -0x14(%ebp),%eax
     b12:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
     b19:	eb 3b                	jmp    b56 <allocThread+0xa4>
  }
  else
  {
    t->stack=(char*)malloc(STACK_SIZE);
     b1b:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
     b22:	e8 b4 fd ff ff       	call   8db <malloc>
     b27:	8b 55 ec             	mov    -0x14(%ebp),%edx
     b2a:	89 42 0c             	mov    %eax,0xc(%edx)
    t->ebp=(int)t->stack+STACK_SIZE;
     b2d:	8b 45 ec             	mov    -0x14(%ebp),%eax
     b30:	8b 40 0c             	mov    0xc(%eax),%eax
     b33:	05 00 10 00 00       	add    $0x1000,%eax
     b38:	89 c2                	mov    %eax,%edx
     b3a:	8b 45 ec             	mov    -0x14(%ebp),%eax
     b3d:	89 50 08             	mov    %edx,0x8(%eax)
    t->esp=t->ebp;
     b40:	8b 45 ec             	mov    -0x14(%ebp),%eax
     b43:	8b 50 08             	mov    0x8(%eax),%edx
     b46:	8b 45 ec             	mov    -0x14(%ebp),%eax
     b49:	89 50 04             	mov    %edx,0x4(%eax)
    t->firstTime=1;
     b4c:	8b 45 ec             	mov    -0x14(%ebp),%eax
     b4f:	c7 40 14 01 00 00 00 	movl   $0x1,0x14(%eax)
  }
  
  t->waitingFor=-1;
     b56:	8b 45 ec             	mov    -0x14(%ebp),%eax
     b59:	c7 80 20 01 00 00 ff 	movl   $0xffffffff,0x120(%eax)
     b60:	ff ff ff 
  
  for(j=0;j<MAX_THREAD;j++)
     b63:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     b6a:	eb 14                	jmp    b80 <allocThread+0xce>
  {
    t->waitedOn[j]=-1;
     b6c:	8b 45 ec             	mov    -0x14(%ebp),%eax
     b6f:	8b 55 f0             	mov    -0x10(%ebp),%edx
     b72:	83 c2 08             	add    $0x8,%edx
     b75:	c7 04 90 ff ff ff ff 	movl   $0xffffffff,(%eax,%edx,4)
    t->firstTime=1;
  }
  
  t->waitingFor=-1;
  
  for(j=0;j<MAX_THREAD;j++)
     b7c:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     b80:	83 7d f0 3f          	cmpl   $0x3f,-0x10(%ebp)
     b84:	7e e6                	jle    b6c <allocThread+0xba>
  {
    t->waitedOn[j]=-1;
  }
   
  t->state=T_UNINIT;
     b86:	8b 45 ec             	mov    -0x14(%ebp),%eax
     b89:	c7 40 10 01 00 00 00 	movl   $0x1,0x10(%eax)
  
    
  return t;
     b90:	8b 45 ec             	mov    -0x14(%ebp),%eax
}
     b93:	c9                   	leave  
     b94:	c3                   	ret    

00000b95 <uthread_init>:
/*
 * initializes all the uthread structures
 */
int
uthread_init()
{   
     b95:	55                   	push   %ebp
     b96:	89 e5                	mov    %esp,%ebp
     b98:	83 ec 28             	sub    $0x28,%esp
  //Initialize table
  int i;
  
  for(i=0;i<MAX_THREAD;i++)
     b9b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     ba2:	eb 18                	jmp    bbc <uthread_init+0x27>
  {
    tTable.table[i].state=T_FREE;
     ba4:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ba7:	69 c0 24 01 00 00    	imul   $0x124,%eax,%eax
     bad:	05 b0 16 00 00       	add    $0x16b0,%eax
     bb2:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
uthread_init()
{   
  //Initialize table
  int i;
  
  for(i=0;i<MAX_THREAD;i++)
     bb8:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     bbc:	83 7d f4 3f          	cmpl   $0x3f,-0xc(%ebp)
     bc0:	7e e2                	jle    ba4 <uthread_init+0xf>
  {
    tTable.table[i].state=T_FREE;
  }
  
 //allocate the main thread
  currentThread = allocThread();
     bc2:	e8 eb fe ff ff       	call   ab2 <allocThread>
     bc7:	a3 a0 5f 00 00       	mov    %eax,0x5fa0
  if(currentThread==0)
     bcc:	a1 a0 5f 00 00       	mov    0x5fa0,%eax
     bd1:	85 c0                	test   %eax,%eax
     bd3:	75 07                	jne    bdc <uthread_init+0x47>
    return -1;
     bd5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     bda:	eb 6b                	jmp    c47 <uthread_init+0xb2>
  
  currentThread->state = T_RUNNING;
     bdc:	a1 a0 5f 00 00       	mov    0x5fa0,%eax
     be1:	c7 40 10 02 00 00 00 	movl   $0x2,0x10(%eax)
  //register uthread_yield as signal handler for alarm
  if(signal(SIGALRM,uthread_yield)<0)
     be8:	c7 44 24 04 cf 0e 00 	movl   $0xecf,0x4(%esp)
     bef:	00 
     bf0:	c7 04 24 0e 00 00 00 	movl   $0xe,(%esp)
     bf7:	e8 0c f9 ff ff       	call   508 <signal>
     bfc:	85 c0                	test   %eax,%eax
     bfe:	79 19                	jns    c19 <uthread_init+0x84>
  {
    printf(1,"Cant register the alarm signal");
     c00:	c7 44 24 04 94 11 00 	movl   $0x1194,0x4(%esp)
     c07:	00 
     c08:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     c0f:	e8 e3 f9 ff ff       	call   5f7 <printf>
    exit();
     c14:	e8 2f f8 ff ff       	call   448 <exit>
  }
  //set new alarm clock
  if(alarm(THREAD_QUANTA)<0)
     c19:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
     c20:	e8 f3 f8 ff ff       	call   518 <alarm>
     c25:	85 c0                	test   %eax,%eax
     c27:	79 19                	jns    c42 <uthread_init+0xad>
  {
    printf(1,"Cant activate alarm system call");
     c29:	c7 44 24 04 b4 11 00 	movl   $0x11b4,0x4(%esp)
     c30:	00 
     c31:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     c38:	e8 ba f9 ff ff       	call   5f7 <printf>
    exit();
     c3d:	e8 06 f8 ff ff       	call   448 <exit>
  }
  return 0;
     c42:	b8 00 00 00 00       	mov    $0x0,%eax
}
     c47:	c9                   	leave  
     c48:	c3                   	ret    

00000c49 <wrap_func>:

void
wrap_func()
{
     c49:	55                   	push   %ebp
     c4a:	89 e5                	mov    %esp,%ebp
     c4c:	83 ec 18             	sub    $0x18,%esp
  currentThread->func(currentThread->arguments);
     c4f:	a1 a0 5f 00 00       	mov    0x5fa0,%eax
     c54:	8b 50 18             	mov    0x18(%eax),%edx
     c57:	a1 a0 5f 00 00       	mov    0x5fa0,%eax
     c5c:	8b 40 1c             	mov    0x1c(%eax),%eax
     c5f:	89 04 24             	mov    %eax,(%esp)
     c62:	ff d2                	call   *%edx
  uthread_exit();
     c64:	e8 6c 00 00 00       	call   cd5 <uthread_exit>
}
     c69:	c9                   	leave  
     c6a:	c3                   	ret    

00000c6b <uthread_create>:
 * to that function
 * if none can be created it returns -1;
 */
int  
uthread_create(void (*start_func)(void *), void* arg)
{
     c6b:	55                   	push   %ebp
     c6c:	89 e5                	mov    %esp,%ebp
     c6e:	53                   	push   %ebx
     c6f:	83 ec 14             	sub    $0x14,%esp
  uint local_esp;
  uthread_p t = allocThread();
     c72:	e8 3b fe ff ff       	call   ab2 <allocThread>
     c77:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(t==0)
     c7a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     c7e:	75 07                	jne    c87 <uthread_create+0x1c>
    return -1;
     c80:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     c85:	eb 48                	jmp    ccf <uthread_create+0x64>

  t->func=start_func;
     c87:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c8a:	8b 55 08             	mov    0x8(%ebp),%edx
     c8d:	89 50 18             	mov    %edx,0x18(%eax)
  t->arguments=arg;
     c90:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c93:	8b 55 0c             	mov    0xc(%ebp),%edx
     c96:	89 50 1c             	mov    %edx,0x1c(%eax)
  
  //push starting func and return value on the right stack
  STORE_ESP(local_esp);
     c99:	89 e3                	mov    %esp,%ebx
     c9b:	89 5d f0             	mov    %ebx,-0x10(%ebp)
  LOAD_ESP(t->esp);
     c9e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ca1:	8b 40 04             	mov    0x4(%eax),%eax
     ca4:	89 c4                	mov    %eax,%esp
  PUSH_FUNC(t->esp,t->ebp,wrap_func);
     ca6:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ca9:	8b 50 08             	mov    0x8(%eax),%edx
     cac:	b8 49 0c 00 00       	mov    $0xc49,%eax
     cb1:	50                   	push   %eax
     cb2:	52                   	push   %edx
     cb3:	89 e2                	mov    %esp,%edx
     cb5:	8b 45 f4             	mov    -0xc(%ebp),%eax
     cb8:	89 50 04             	mov    %edx,0x4(%eax)
  LOAD_ESP(local_esp);
     cbb:	8b 45 f0             	mov    -0x10(%ebp),%eax
     cbe:	89 c4                	mov    %eax,%esp
  
  t->state = T_RUNNABLE;
     cc0:	8b 45 f4             	mov    -0xc(%ebp),%eax
     cc3:	c7 40 10 03 00 00 00 	movl   $0x3,0x10(%eax)
  
  return t->tid;
     cca:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ccd:	8b 00                	mov    (%eax),%eax
}
     ccf:	83 c4 14             	add    $0x14,%esp
     cd2:	5b                   	pop    %ebx
     cd3:	5d                   	pop    %ebp
     cd4:	c3                   	ret    

00000cd5 <uthread_exit>:
 * closes the running thread, wakes up all
 * the threads waiting for this one (if they require waking up)
 */
void 
uthread_exit()
{
     cd5:	55                   	push   %ebp
     cd6:	89 e5                	mov    %esp,%ebp
     cd8:	83 ec 28             	sub    $0x28,%esp
  alarm(0); //clear the alarm so as not to disturb running of function
     cdb:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     ce2:	e8 31 f8 ff ff       	call   518 <alarm>
  int new,i;
  //wakeup all threads waiting for this one
  for(i=0;i<MAX_THREAD;i++)
     ce7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     cee:	eb 51                	jmp    d41 <uthread_exit+0x6c>
  {
   if(currentThread->waitedOn[i]==1)
     cf0:	a1 a0 5f 00 00       	mov    0x5fa0,%eax
     cf5:	8b 55 f4             	mov    -0xc(%ebp),%edx
     cf8:	83 c2 08             	add    $0x8,%edx
     cfb:	8b 04 90             	mov    (%eax,%edx,4),%eax
     cfe:	83 f8 01             	cmp    $0x1,%eax
     d01:	75 3a                	jne    d3d <uthread_exit+0x68>
   {
     tTable.table[i].waitingFor=-1; //release thread i from waiting
     d03:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d06:	69 c0 24 01 00 00    	imul   $0x124,%eax,%eax
     d0c:	05 c0 17 00 00       	add    $0x17c0,%eax
     d11:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)
     currentThread->waitedOn[i]=0; //not necessary maybe   
     d17:	a1 a0 5f 00 00       	mov    0x5fa0,%eax
     d1c:	8b 55 f4             	mov    -0xc(%ebp),%edx
     d1f:	83 c2 08             	add    $0x8,%edx
     d22:	c7 04 90 00 00 00 00 	movl   $0x0,(%eax,%edx,4)
     tTable.table[i].state=T_RUNNABLE;
     d29:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d2c:	69 c0 24 01 00 00    	imul   $0x124,%eax,%eax
     d32:	05 b0 16 00 00       	add    $0x16b0,%eax
     d37:	c7 00 03 00 00 00    	movl   $0x3,(%eax)
uthread_exit()
{
  alarm(0); //clear the alarm so as not to disturb running of function
  int new,i;
  //wakeup all threads waiting for this one
  for(i=0;i<MAX_THREAD;i++)
     d3d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     d41:	83 7d f4 3f          	cmpl   $0x3f,-0xc(%ebp)
     d45:	7e a9                	jle    cf0 <uthread_exit+0x1b>
     tTable.table[i].state=T_RUNNABLE;
   }
  }
  
  //pick next thread
  new=getNextThread(currentThread->tid);
     d47:	a1 a0 5f 00 00       	mov    0x5fa0,%eax
     d4c:	8b 00                	mov    (%eax),%eax
     d4e:	89 04 24             	mov    %eax,(%esp)
     d51:	e8 e3 fc ff ff       	call   a39 <getNextThread>
     d56:	89 45 f0             	mov    %eax,-0x10(%ebp)
  
  //release all resources and zero all fields
  if(currentThread->tid!=0)
     d59:	a1 a0 5f 00 00       	mov    0x5fa0,%eax
     d5e:	8b 00                	mov    (%eax),%eax
     d60:	85 c0                	test   %eax,%eax
     d62:	74 10                	je     d74 <uthread_exit+0x9f>
    free(currentThread->stack);
     d64:	a1 a0 5f 00 00       	mov    0x5fa0,%eax
     d69:	8b 40 0c             	mov    0xc(%eax),%eax
     d6c:	89 04 24             	mov    %eax,(%esp)
     d6f:	e8 38 fa ff ff       	call   7ac <free>
  currentThread->tid=-1;
     d74:	a1 a0 5f 00 00       	mov    0x5fa0,%eax
     d79:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)
  currentThread->esp=-1;
     d7f:	a1 a0 5f 00 00       	mov    0x5fa0,%eax
     d84:	c7 40 04 ff ff ff ff 	movl   $0xffffffff,0x4(%eax)
  currentThread->ebp=-1;
     d8b:	a1 a0 5f 00 00       	mov    0x5fa0,%eax
     d90:	c7 40 08 ff ff ff ff 	movl   $0xffffffff,0x8(%eax)
  currentThread->func=0;
     d97:	a1 a0 5f 00 00       	mov    0x5fa0,%eax
     d9c:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)
  currentThread->arguments=0;
     da3:	a1 a0 5f 00 00       	mov    0x5fa0,%eax
     da8:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
  currentThread->stack=0;
     daf:	a1 a0 5f 00 00       	mov    0x5fa0,%eax
     db4:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
  currentThread->firstTime=1;
     dbb:	a1 a0 5f 00 00       	mov    0x5fa0,%eax
     dc0:	c7 40 14 01 00 00 00 	movl   $0x1,0x14(%eax)
  currentThread->state=T_FREE;
     dc7:	a1 a0 5f 00 00       	mov    0x5fa0,%eax
     dcc:	c7 40 10 00 00 00 00 	movl   $0x0,0x10(%eax)
  
  //load new thread
  if(new>=0)
     dd3:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     dd7:	78 7a                	js     e53 <uthread_exit+0x17e>
  {
    currentThread=&tTable.table[new];
     dd9:	8b 45 f0             	mov    -0x10(%ebp),%eax
     ddc:	69 c0 24 01 00 00    	imul   $0x124,%eax,%eax
     de2:	05 a0 16 00 00       	add    $0x16a0,%eax
     de7:	a3 a0 5f 00 00       	mov    %eax,0x5fa0
    currentThread->state=T_RUNNING;
     dec:	a1 a0 5f 00 00       	mov    0x5fa0,%eax
     df1:	c7 40 10 02 00 00 00 	movl   $0x2,0x10(%eax)
    LOAD_ESP(currentThread->esp);
     df8:	a1 a0 5f 00 00       	mov    0x5fa0,%eax
     dfd:	8b 40 04             	mov    0x4(%eax),%eax
     e00:	89 c4                	mov    %eax,%esp
    LOAD_EBP(currentThread->ebp);
     e02:	a1 a0 5f 00 00       	mov    0x5fa0,%eax
     e07:	8b 40 08             	mov    0x8(%eax),%eax
     e0a:	89 c5                	mov    %eax,%ebp
    
    //set new alarm clock
    if(alarm(THREAD_QUANTA)<0)
     e0c:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
     e13:	e8 00 f7 ff ff       	call   518 <alarm>
     e18:	85 c0                	test   %eax,%eax
     e1a:	79 19                	jns    e35 <uthread_exit+0x160>
    {
      printf(1,"Cant activate alarm system call");
     e1c:	c7 44 24 04 b4 11 00 	movl   $0x11b4,0x4(%esp)
     e23:	00 
     e24:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     e2b:	e8 c7 f7 ff ff       	call   5f7 <printf>
      exit();
     e30:	e8 13 f6 ff ff       	call   448 <exit>
    }
    
    if(currentThread->firstTime==1)
     e35:	a1 a0 5f 00 00       	mov    0x5fa0,%eax
     e3a:	8b 40 14             	mov    0x14(%eax),%eax
     e3d:	83 f8 01             	cmp    $0x1,%eax
     e40:	75 10                	jne    e52 <uthread_exit+0x17d>
    {
      currentThread->firstTime=0;
     e42:	a1 a0 5f 00 00       	mov    0x5fa0,%eax
     e47:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
      POP_AND_RET();
     e4e:	5d                   	pop    %ebp
     e4f:	c3                   	ret    
     e50:	eb 01                	jmp    e53 <uthread_exit+0x17e>
    }
    else
    {  
    POP_ALL_REGISTERS();
     e52:	61                   	popa   
    }
  }
}
     e53:	c9                   	leave  
     e54:	c3                   	ret    

00000e55 <uthread_join>:
/*
 * causes this thread to wait for the finish of another thread
 */
int
uthread_join(int tid)
{
     e55:	55                   	push   %ebp
     e56:	89 e5                	mov    %esp,%ebp
     e58:	83 ec 18             	sub    $0x18,%esp
  if((&tTable.table[tid])->state==T_FREE)
     e5b:	8b 45 08             	mov    0x8(%ebp),%eax
     e5e:	69 c0 24 01 00 00    	imul   $0x124,%eax,%eax
     e64:	05 a0 16 00 00       	add    $0x16a0,%eax
     e69:	8b 40 10             	mov    0x10(%eax),%eax
     e6c:	85 c0                	test   %eax,%eax
     e6e:	75 07                	jne    e77 <uthread_join+0x22>
    return -1;
     e70:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     e75:	eb 56                	jmp    ecd <uthread_join+0x78>
  else
  {
    alarm(0); //clear the alarm so as not to disturb running of function
     e77:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     e7e:	e8 95 f6 ff ff       	call   518 <alarm>
    currentThread->waitingFor=tid;
     e83:	a1 a0 5f 00 00       	mov    0x5fa0,%eax
     e88:	8b 55 08             	mov    0x8(%ebp),%edx
     e8b:	89 90 20 01 00 00    	mov    %edx,0x120(%eax)
    tTable.table[tid].waitedOn[currentThread->tid]=1;
     e91:	a1 a0 5f 00 00       	mov    0x5fa0,%eax
     e96:	8b 08                	mov    (%eax),%ecx
     e98:	8b 55 08             	mov    0x8(%ebp),%edx
     e9b:	89 d0                	mov    %edx,%eax
     e9d:	c1 e0 03             	shl    $0x3,%eax
     ea0:	01 d0                	add    %edx,%eax
     ea2:	c1 e0 03             	shl    $0x3,%eax
     ea5:	01 d0                	add    %edx,%eax
     ea7:	01 c8                	add    %ecx,%eax
     ea9:	83 c0 08             	add    $0x8,%eax
     eac:	c7 04 85 a0 16 00 00 	movl   $0x1,0x16a0(,%eax,4)
     eb3:	01 00 00 00 
    currentThread->state=T_SLEEPING;
     eb7:	a1 a0 5f 00 00       	mov    0x5fa0,%eax
     ebc:	c7 40 10 04 00 00 00 	movl   $0x4,0x10(%eax)
    uthread_yield();
     ec3:	e8 07 00 00 00       	call   ecf <uthread_yield>
    return 1;
     ec8:	b8 01 00 00 00       	mov    $0x1,%eax
  }
}
     ecd:	c9                   	leave  
     ece:	c3                   	ret    

00000ecf <uthread_yield>:
/*
 * yields the run-time of the current thread to another thread
 */
void 
uthread_yield()
{
     ecf:	55                   	push   %ebp
     ed0:	89 e5                	mov    %esp,%ebp
     ed2:	83 ec 28             	sub    $0x28,%esp
  alarm(0); //clear the alarm so as not to disturb running of function
     ed5:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     edc:	e8 37 f6 ff ff       	call   518 <alarm>
  int new=getNextThread(currentThread->tid);
     ee1:	a1 a0 5f 00 00       	mov    0x5fa0,%eax
     ee6:	8b 00                	mov    (%eax),%eax
     ee8:	89 04 24             	mov    %eax,(%esp)
     eeb:	e8 49 fb ff ff       	call   a39 <getNextThread>
     ef0:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(new==-1)
     ef3:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     ef7:	75 2d                	jne    f26 <uthread_yield+0x57>
  {
    if(alarm(THREAD_QUANTA)<0)
     ef9:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
     f00:	e8 13 f6 ff ff       	call   518 <alarm>
     f05:	85 c0                	test   %eax,%eax
     f07:	0f 89 c1 00 00 00    	jns    fce <uthread_yield+0xff>
    {
      printf(1,"Cant activate alarm system call\n");
     f0d:	c7 44 24 04 d4 11 00 	movl   $0x11d4,0x4(%esp)
     f14:	00 
     f15:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     f1c:	e8 d6 f6 ff ff       	call   5f7 <printf>
      exit();
     f21:	e8 22 f5 ff ff       	call   448 <exit>
    } 
  }
  else
  {
    //store all leaving thread registers and pointers
    PUSH_ALL_REGISTERS();
     f26:	60                   	pusha  
    STORE_ESP(currentThread->esp);
     f27:	a1 a0 5f 00 00       	mov    0x5fa0,%eax
     f2c:	89 e2                	mov    %esp,%edx
     f2e:	89 50 04             	mov    %edx,0x4(%eax)
    STORE_EBP(currentThread->ebp);
     f31:	a1 a0 5f 00 00       	mov    0x5fa0,%eax
     f36:	89 ea                	mov    %ebp,%edx
     f38:	89 50 08             	mov    %edx,0x8(%eax)
    
    //change thread state
    if(currentThread->state==T_RUNNING) //might be sleeping from join operation
     f3b:	a1 a0 5f 00 00       	mov    0x5fa0,%eax
     f40:	8b 40 10             	mov    0x10(%eax),%eax
     f43:	83 f8 02             	cmp    $0x2,%eax
     f46:	75 0c                	jne    f54 <uthread_yield+0x85>
      currentThread->state=T_RUNNABLE;
     f48:	a1 a0 5f 00 00       	mov    0x5fa0,%eax
     f4d:	c7 40 10 03 00 00 00 	movl   $0x3,0x10(%eax)

    currentThread=&tTable.table[new];
     f54:	8b 45 f4             	mov    -0xc(%ebp),%eax
     f57:	69 c0 24 01 00 00    	imul   $0x124,%eax,%eax
     f5d:	05 a0 16 00 00       	add    $0x16a0,%eax
     f62:	a3 a0 5f 00 00       	mov    %eax,0x5fa0

    //load all new thread registers and pointers
    LOAD_ESP(currentThread->esp);
     f67:	a1 a0 5f 00 00       	mov    0x5fa0,%eax
     f6c:	8b 40 04             	mov    0x4(%eax),%eax
     f6f:	89 c4                	mov    %eax,%esp
    LOAD_EBP(currentThread->ebp);
     f71:	a1 a0 5f 00 00       	mov    0x5fa0,%eax
     f76:	8b 40 08             	mov    0x8(%eax),%eax
     f79:	89 c5                	mov    %eax,%ebp
    //set new alram clock
    if(alarm(THREAD_QUANTA)<0)
     f7b:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
     f82:	e8 91 f5 ff ff       	call   518 <alarm>
     f87:	85 c0                	test   %eax,%eax
     f89:	79 19                	jns    fa4 <uthread_yield+0xd5>
    {
      printf(1,"Cant activate alarm system call\n");
     f8b:	c7 44 24 04 d4 11 00 	movl   $0x11d4,0x4(%esp)
     f92:	00 
     f93:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     f9a:	e8 58 f6 ff ff       	call   5f7 <printf>
      exit();
     f9f:	e8 a4 f4 ff ff       	call   448 <exit>
    }  
    currentThread->state=T_RUNNING;
     fa4:	a1 a0 5f 00 00       	mov    0x5fa0,%eax
     fa9:	c7 40 10 02 00 00 00 	movl   $0x2,0x10(%eax)
    
    if(currentThread->firstTime==1)
     fb0:	a1 a0 5f 00 00       	mov    0x5fa0,%eax
     fb5:	8b 40 14             	mov    0x14(%eax),%eax
     fb8:	83 f8 01             	cmp    $0x1,%eax
     fbb:	75 10                	jne    fcd <uthread_yield+0xfe>
    {
    currentThread->firstTime=0;
     fbd:	a1 a0 5f 00 00       	mov    0x5fa0,%eax
     fc2:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
    POP_AND_RET();
     fc9:	5d                   	pop    %ebp
     fca:	c3                   	ret    
     fcb:	eb 01                	jmp    fce <uthread_yield+0xff>
    }
    else
    {
      POP_ALL_REGISTERS();
     fcd:	61                   	popa   
    }
  }
}
     fce:	c9                   	leave  
     fcf:	c3                   	ret    

00000fd0 <uthread_self>:

int
uthread_self(void)
{
     fd0:	55                   	push   %ebp
     fd1:	89 e5                	mov    %esp,%ebp
  return currentThread->tid;
     fd3:	a1 a0 5f 00 00       	mov    0x5fa0,%eax
     fd8:	8b 00                	mov    (%eax),%eax
     fda:	5d                   	pop    %ebp
     fdb:	c3                   	ret    

00000fdc <xchg>:
#include "fs.h"
#include "uthread.h"

static inline uint
xchg(volatile uint *addr, uint newval)
{
     fdc:	55                   	push   %ebp
     fdd:	89 e5                	mov    %esp,%ebp
     fdf:	53                   	push   %ebx
     fe0:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
               "+m" (*addr), "=a" (result) :
     fe3:	8b 55 08             	mov    0x8(%ebp),%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
     fe6:	8b 45 0c             	mov    0xc(%ebp),%eax
               "+m" (*addr), "=a" (result) :
     fe9:	8b 4d 08             	mov    0x8(%ebp),%ecx
xchg(volatile uint *addr, uint newval)
{
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
     fec:	89 c3                	mov    %eax,%ebx
     fee:	89 d8                	mov    %ebx,%eax
     ff0:	f0 87 02             	lock xchg %eax,(%edx)
     ff3:	89 c3                	mov    %eax,%ebx
     ff5:	89 5d f8             	mov    %ebx,-0x8(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
     ff8:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
     ffb:	83 c4 10             	add    $0x10,%esp
     ffe:	5b                   	pop    %ebx
     fff:	5d                   	pop    %ebp
    1000:	c3                   	ret    

00001001 <binary_semaphore_init>:
semaphore->taken=0;
}*/

void
binary_semaphore_init(struct binary_semaphore* semaphore, int value)
{
    1001:	55                   	push   %ebp
    1002:	89 e5                	mov    %esp,%ebp
    1004:	83 ec 08             	sub    $0x8,%esp
  semaphore->init=0;
    1007:	8b 45 08             	mov    0x8(%ebp),%eax
    100a:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
  
  if(value!=0)
    1011:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1015:	74 0c                	je     1023 <binary_semaphore_init+0x22>
    semaphore->thread=-1;
    1017:	8b 45 08             	mov    0x8(%ebp),%eax
    101a:	c7 40 04 ff ff ff ff 	movl   $0xffffffff,0x4(%eax)
    1021:	eb 0b                	jmp    102e <binary_semaphore_init+0x2d>
  else 
    semaphore->thread = uthread_self();
    1023:	e8 a8 ff ff ff       	call   fd0 <uthread_self>
    1028:	8b 55 08             	mov    0x8(%ebp),%edx
    102b:	89 42 04             	mov    %eax,0x4(%edx)
  
  semaphore->locked = value;
    102e:	8b 55 0c             	mov    0xc(%ebp),%edx
    1031:	8b 45 08             	mov    0x8(%ebp),%eax
    1034:	89 10                	mov    %edx,(%eax)
 // semaphore->taken=0;
  semaphore->init=1;
    1036:	8b 45 08             	mov    0x8(%ebp),%eax
    1039:	c7 40 08 01 00 00 00 	movl   $0x1,0x8(%eax)
  
}
    1040:	c9                   	leave  
    1041:	c3                   	ret    

00001042 <binary_semaphore_down>:

void 
binary_semaphore_down(struct binary_semaphore* semaphore)
{
    1042:	55                   	push   %ebp
    1043:	89 e5                	mov    %esp,%ebp
    1045:	83 ec 28             	sub    $0x28,%esp
  //semaphore_acquire(semaphore);
  if(semaphore->init==0)
    1048:	8b 45 08             	mov    0x8(%ebp),%eax
    104b:	8b 40 08             	mov    0x8(%eax),%eax
    104e:	85 c0                	test   %eax,%eax
    1050:	75 20                	jne    1072 <binary_semaphore_down+0x30>
  {
   printf(1,"(down)semaphore uninitialized yet (thread %d)\n",semaphore->thread);
    1052:	8b 45 08             	mov    0x8(%ebp),%eax
    1055:	8b 40 04             	mov    0x4(%eax),%eax
    1058:	89 44 24 08          	mov    %eax,0x8(%esp)
    105c:	c7 44 24 04 f8 11 00 	movl   $0x11f8,0x4(%esp)
    1063:	00 
    1064:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    106b:	e8 87 f5 ff ff       	call   5f7 <printf>
    return;
    1070:	eb 3a                	jmp    10ac <binary_semaphore_down+0x6a>
  }
  
  
  int i= uthread_self();
    1072:	e8 59 ff ff ff       	call   fd0 <uthread_self>
    1077:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(semaphore->thread!=i)
    107a:	8b 45 08             	mov    0x8(%ebp),%eax
    107d:	8b 40 04             	mov    0x4(%eax),%eax
    1080:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1083:	74 27                	je     10ac <binary_semaphore_down+0x6a>
  {
    while(xchg(&semaphore->locked, 0) == 0) //means the semaphore is taken allready
    1085:	eb 05                	jmp    108c <binary_semaphore_down+0x4a>
    {
      uthread_yield();
    1087:	e8 43 fe ff ff       	call   ecf <uthread_yield>
  
  
  int i= uthread_self();
  if(semaphore->thread!=i)
  {
    while(xchg(&semaphore->locked, 0) == 0) //means the semaphore is taken allready
    108c:	8b 45 08             	mov    0x8(%ebp),%eax
    108f:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1096:	00 
    1097:	89 04 24             	mov    %eax,(%esp)
    109a:	e8 3d ff ff ff       	call   fdc <xchg>
    109f:	85 c0                	test   %eax,%eax
    10a1:	74 e4                	je     1087 <binary_semaphore_down+0x45>
    {
      uthread_yield();
    }
    semaphore->thread = i;
    10a3:	8b 45 08             	mov    0x8(%ebp),%eax
    10a6:	8b 55 f4             	mov    -0xc(%ebp),%edx
    10a9:	89 50 04             	mov    %edx,0x4(%eax)
  }
  //semaphore_release(semaphore);
}
    10ac:	c9                   	leave  
    10ad:	c3                   	ret    

000010ae <binary_semaphore_up>:

void 
binary_semaphore_up(struct binary_semaphore* semaphore)
{
    10ae:	55                   	push   %ebp
    10af:	89 e5                	mov    %esp,%ebp
    10b1:	83 ec 28             	sub    $0x28,%esp
  //semaphore_acquire(semaphore);
    if(semaphore->init==0)
    10b4:	8b 45 08             	mov    0x8(%ebp),%eax
    10b7:	8b 40 08             	mov    0x8(%eax),%eax
    10ba:	85 c0                	test   %eax,%eax
    10bc:	75 20                	jne    10de <binary_semaphore_up+0x30>
    {
    printf(1,"(up)semaphore uninitialized yet (thread %d)\n",semaphore->thread);
    10be:	8b 45 08             	mov    0x8(%ebp),%eax
    10c1:	8b 40 04             	mov    0x4(%eax),%eax
    10c4:	89 44 24 08          	mov    %eax,0x8(%esp)
    10c8:	c7 44 24 04 28 12 00 	movl   $0x1228,0x4(%esp)
    10cf:	00 
    10d0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    10d7:	e8 1b f5 ff ff       	call   5f7 <printf>
    return;
    10dc:	eb 2f                	jmp    110d <binary_semaphore_up+0x5f>
    }
  
  int i= uthread_self();
    10de:	e8 ed fe ff ff       	call   fd0 <uthread_self>
    10e3:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if( semaphore->locked == 0 && semaphore->thread == i)
    10e6:	8b 45 08             	mov    0x8(%ebp),%eax
    10e9:	8b 00                	mov    (%eax),%eax
    10eb:	85 c0                	test   %eax,%eax
    10ed:	75 1e                	jne    110d <binary_semaphore_up+0x5f>
    10ef:	8b 45 08             	mov    0x8(%ebp),%eax
    10f2:	8b 40 04             	mov    0x4(%eax),%eax
    10f5:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    10f8:	75 13                	jne    110d <binary_semaphore_up+0x5f>
  {
      semaphore->thread = -1;
    10fa:	8b 45 08             	mov    0x8(%ebp),%eax
    10fd:	c7 40 04 ff ff ff ff 	movl   $0xffffffff,0x4(%eax)
      semaphore->locked = 1;
    1104:	8b 45 08             	mov    0x8(%ebp),%eax
    1107:	c7 00 01 00 00 00    	movl   $0x1,(%eax)

  }
//semaphore_release(semaphore);
    110d:	c9                   	leave  
    110e:	c3                   	ret    
