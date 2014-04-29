
_init:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:

char *argv[] = { "sh", 0 };

int
main(void)
{
       0:	55                   	push   %ebp
       1:	89 e5                	mov    %esp,%ebp
       3:	83 e4 f0             	and    $0xfffffff0,%esp
       6:	83 ec 20             	sub    $0x20,%esp
  int pid, wpid;

  if(open("console", O_RDWR) < 0){
       9:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
      10:	00 
      11:	c7 04 24 43 10 00 00 	movl   $0x1043,(%esp)
      18:	e8 9b 03 00 00       	call   3b8 <open>
      1d:	85 c0                	test   %eax,%eax
      1f:	79 30                	jns    51 <main+0x51>
    mknod("console", 1, 1);
      21:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
      28:	00 
      29:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
      30:	00 
      31:	c7 04 24 43 10 00 00 	movl   $0x1043,(%esp)
      38:	e8 83 03 00 00       	call   3c0 <mknod>
    open("console", O_RDWR);
      3d:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
      44:	00 
      45:	c7 04 24 43 10 00 00 	movl   $0x1043,(%esp)
      4c:	e8 67 03 00 00       	call   3b8 <open>
  }
  dup(0);  // stdout
      51:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
      58:	e8 93 03 00 00       	call   3f0 <dup>
  dup(0);  // stderr
      5d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
      64:	e8 87 03 00 00       	call   3f0 <dup>
      69:	eb 01                	jmp    6c <main+0x6c>
      printf(1, "init: exec sh failed\n");
      exit();
    }
    while((wpid=wait()) >= 0 && wpid != pid)
      printf(1, "zombie!\n");
  }
      6b:	90                   	nop
  }
  dup(0);  // stdout
  dup(0);  // stderr

  for(;;){
    printf(1, "init: starting sh\n");
      6c:	c7 44 24 04 4b 10 00 	movl   $0x104b,0x4(%esp)
      73:	00 
      74:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
      7b:	e8 a7 04 00 00       	call   527 <printf>
    pid = fork();
      80:	e8 eb 02 00 00       	call   370 <fork>
      85:	89 44 24 1c          	mov    %eax,0x1c(%esp)
    if(pid < 0){
      89:	83 7c 24 1c 00       	cmpl   $0x0,0x1c(%esp)
      8e:	79 19                	jns    a9 <main+0xa9>
      printf(1, "init: fork failed\n");
      90:	c7 44 24 04 5e 10 00 	movl   $0x105e,0x4(%esp)
      97:	00 
      98:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
      9f:	e8 83 04 00 00       	call   527 <printf>
      exit();
      a4:	e8 cf 02 00 00       	call   378 <exit>
    }
    if(pid == 0){
      a9:	83 7c 24 1c 00       	cmpl   $0x0,0x1c(%esp)
      ae:	75 41                	jne    f1 <main+0xf1>
      exec("sh", argv);
      b0:	c7 44 24 04 88 15 00 	movl   $0x1588,0x4(%esp)
      b7:	00 
      b8:	c7 04 24 40 10 00 00 	movl   $0x1040,(%esp)
      bf:	e8 ec 02 00 00       	call   3b0 <exec>
      printf(1, "init: exec sh failed\n");
      c4:	c7 44 24 04 71 10 00 	movl   $0x1071,0x4(%esp)
      cb:	00 
      cc:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
      d3:	e8 4f 04 00 00       	call   527 <printf>
      exit();
      d8:	e8 9b 02 00 00       	call   378 <exit>
    }
    while((wpid=wait()) >= 0 && wpid != pid)
      printf(1, "zombie!\n");
      dd:	c7 44 24 04 87 10 00 	movl   $0x1087,0x4(%esp)
      e4:	00 
      e5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
      ec:	e8 36 04 00 00       	call   527 <printf>
    if(pid == 0){
      exec("sh", argv);
      printf(1, "init: exec sh failed\n");
      exit();
    }
    while((wpid=wait()) >= 0 && wpid != pid)
      f1:	e8 8a 02 00 00       	call   380 <wait>
      f6:	89 44 24 18          	mov    %eax,0x18(%esp)
      fa:	83 7c 24 18 00       	cmpl   $0x0,0x18(%esp)
      ff:	0f 88 66 ff ff ff    	js     6b <main+0x6b>
     105:	8b 44 24 18          	mov    0x18(%esp),%eax
     109:	3b 44 24 1c          	cmp    0x1c(%esp),%eax
     10d:	75 ce                	jne    dd <main+0xdd>
      printf(1, "zombie!\n");
  }
     10f:	e9 57 ff ff ff       	jmp    6b <main+0x6b>

00000114 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
     114:	55                   	push   %ebp
     115:	89 e5                	mov    %esp,%ebp
     117:	57                   	push   %edi
     118:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
     119:	8b 4d 08             	mov    0x8(%ebp),%ecx
     11c:	8b 55 10             	mov    0x10(%ebp),%edx
     11f:	8b 45 0c             	mov    0xc(%ebp),%eax
     122:	89 cb                	mov    %ecx,%ebx
     124:	89 df                	mov    %ebx,%edi
     126:	89 d1                	mov    %edx,%ecx
     128:	fc                   	cld    
     129:	f3 aa                	rep stos %al,%es:(%edi)
     12b:	89 ca                	mov    %ecx,%edx
     12d:	89 fb                	mov    %edi,%ebx
     12f:	89 5d 08             	mov    %ebx,0x8(%ebp)
     132:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
     135:	5b                   	pop    %ebx
     136:	5f                   	pop    %edi
     137:	5d                   	pop    %ebp
     138:	c3                   	ret    

00000139 <strcpy>:
#include "x86.h"


char*
strcpy(char *s, char *t)
{
     139:	55                   	push   %ebp
     13a:	89 e5                	mov    %esp,%ebp
     13c:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
     13f:	8b 45 08             	mov    0x8(%ebp),%eax
     142:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
     145:	90                   	nop
     146:	8b 45 0c             	mov    0xc(%ebp),%eax
     149:	0f b6 10             	movzbl (%eax),%edx
     14c:	8b 45 08             	mov    0x8(%ebp),%eax
     14f:	88 10                	mov    %dl,(%eax)
     151:	8b 45 08             	mov    0x8(%ebp),%eax
     154:	0f b6 00             	movzbl (%eax),%eax
     157:	84 c0                	test   %al,%al
     159:	0f 95 c0             	setne  %al
     15c:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     160:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
     164:	84 c0                	test   %al,%al
     166:	75 de                	jne    146 <strcpy+0xd>
    ;
  return os;
     168:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     16b:	c9                   	leave  
     16c:	c3                   	ret    

0000016d <strcmp>:

int
strcmp(const char *p, const char *q)
{
     16d:	55                   	push   %ebp
     16e:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
     170:	eb 08                	jmp    17a <strcmp+0xd>
    p++, q++;
     172:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     176:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
     17a:	8b 45 08             	mov    0x8(%ebp),%eax
     17d:	0f b6 00             	movzbl (%eax),%eax
     180:	84 c0                	test   %al,%al
     182:	74 10                	je     194 <strcmp+0x27>
     184:	8b 45 08             	mov    0x8(%ebp),%eax
     187:	0f b6 10             	movzbl (%eax),%edx
     18a:	8b 45 0c             	mov    0xc(%ebp),%eax
     18d:	0f b6 00             	movzbl (%eax),%eax
     190:	38 c2                	cmp    %al,%dl
     192:	74 de                	je     172 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
     194:	8b 45 08             	mov    0x8(%ebp),%eax
     197:	0f b6 00             	movzbl (%eax),%eax
     19a:	0f b6 d0             	movzbl %al,%edx
     19d:	8b 45 0c             	mov    0xc(%ebp),%eax
     1a0:	0f b6 00             	movzbl (%eax),%eax
     1a3:	0f b6 c0             	movzbl %al,%eax
     1a6:	89 d1                	mov    %edx,%ecx
     1a8:	29 c1                	sub    %eax,%ecx
     1aa:	89 c8                	mov    %ecx,%eax
}
     1ac:	5d                   	pop    %ebp
     1ad:	c3                   	ret    

000001ae <strlen>:

uint
strlen(char *s)
{
     1ae:	55                   	push   %ebp
     1af:	89 e5                	mov    %esp,%ebp
     1b1:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
     1b4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
     1bb:	eb 04                	jmp    1c1 <strlen+0x13>
     1bd:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     1c1:	8b 45 fc             	mov    -0x4(%ebp),%eax
     1c4:	03 45 08             	add    0x8(%ebp),%eax
     1c7:	0f b6 00             	movzbl (%eax),%eax
     1ca:	84 c0                	test   %al,%al
     1cc:	75 ef                	jne    1bd <strlen+0xf>
    ;
  return n;
     1ce:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     1d1:	c9                   	leave  
     1d2:	c3                   	ret    

000001d3 <memset>:

void*
memset(void *dst, int c, uint n)
{
     1d3:	55                   	push   %ebp
     1d4:	89 e5                	mov    %esp,%ebp
     1d6:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
     1d9:	8b 45 10             	mov    0x10(%ebp),%eax
     1dc:	89 44 24 08          	mov    %eax,0x8(%esp)
     1e0:	8b 45 0c             	mov    0xc(%ebp),%eax
     1e3:	89 44 24 04          	mov    %eax,0x4(%esp)
     1e7:	8b 45 08             	mov    0x8(%ebp),%eax
     1ea:	89 04 24             	mov    %eax,(%esp)
     1ed:	e8 22 ff ff ff       	call   114 <stosb>
  return dst;
     1f2:	8b 45 08             	mov    0x8(%ebp),%eax
}
     1f5:	c9                   	leave  
     1f6:	c3                   	ret    

000001f7 <strchr>:

char*
strchr(const char *s, char c)
{
     1f7:	55                   	push   %ebp
     1f8:	89 e5                	mov    %esp,%ebp
     1fa:	83 ec 04             	sub    $0x4,%esp
     1fd:	8b 45 0c             	mov    0xc(%ebp),%eax
     200:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
     203:	eb 14                	jmp    219 <strchr+0x22>
    if(*s == c)
     205:	8b 45 08             	mov    0x8(%ebp),%eax
     208:	0f b6 00             	movzbl (%eax),%eax
     20b:	3a 45 fc             	cmp    -0x4(%ebp),%al
     20e:	75 05                	jne    215 <strchr+0x1e>
      return (char*)s;
     210:	8b 45 08             	mov    0x8(%ebp),%eax
     213:	eb 13                	jmp    228 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
     215:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     219:	8b 45 08             	mov    0x8(%ebp),%eax
     21c:	0f b6 00             	movzbl (%eax),%eax
     21f:	84 c0                	test   %al,%al
     221:	75 e2                	jne    205 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
     223:	b8 00 00 00 00       	mov    $0x0,%eax
}
     228:	c9                   	leave  
     229:	c3                   	ret    

0000022a <gets>:

char*
gets(char *buf, int max)
{
     22a:	55                   	push   %ebp
     22b:	89 e5                	mov    %esp,%ebp
     22d:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     230:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     237:	eb 44                	jmp    27d <gets+0x53>
    cc = read(0, &c, 1);
     239:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
     240:	00 
     241:	8d 45 ef             	lea    -0x11(%ebp),%eax
     244:	89 44 24 04          	mov    %eax,0x4(%esp)
     248:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     24f:	e8 3c 01 00 00       	call   390 <read>
     254:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
     257:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     25b:	7e 2d                	jle    28a <gets+0x60>
      break;
    buf[i++] = c;
     25d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     260:	03 45 08             	add    0x8(%ebp),%eax
     263:	0f b6 55 ef          	movzbl -0x11(%ebp),%edx
     267:	88 10                	mov    %dl,(%eax)
     269:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    if(c == '\n' || c == '\r')
     26d:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     271:	3c 0a                	cmp    $0xa,%al
     273:	74 16                	je     28b <gets+0x61>
     275:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     279:	3c 0d                	cmp    $0xd,%al
     27b:	74 0e                	je     28b <gets+0x61>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     27d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     280:	83 c0 01             	add    $0x1,%eax
     283:	3b 45 0c             	cmp    0xc(%ebp),%eax
     286:	7c b1                	jl     239 <gets+0xf>
     288:	eb 01                	jmp    28b <gets+0x61>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
     28a:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
     28b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     28e:	03 45 08             	add    0x8(%ebp),%eax
     291:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
     294:	8b 45 08             	mov    0x8(%ebp),%eax
}
     297:	c9                   	leave  
     298:	c3                   	ret    

00000299 <stat>:

int
stat(char *n, struct stat *st)
{
     299:	55                   	push   %ebp
     29a:	89 e5                	mov    %esp,%ebp
     29c:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     29f:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     2a6:	00 
     2a7:	8b 45 08             	mov    0x8(%ebp),%eax
     2aa:	89 04 24             	mov    %eax,(%esp)
     2ad:	e8 06 01 00 00       	call   3b8 <open>
     2b2:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
     2b5:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     2b9:	79 07                	jns    2c2 <stat+0x29>
    return -1;
     2bb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     2c0:	eb 23                	jmp    2e5 <stat+0x4c>
  r = fstat(fd, st);
     2c2:	8b 45 0c             	mov    0xc(%ebp),%eax
     2c5:	89 44 24 04          	mov    %eax,0x4(%esp)
     2c9:	8b 45 f4             	mov    -0xc(%ebp),%eax
     2cc:	89 04 24             	mov    %eax,(%esp)
     2cf:	e8 fc 00 00 00       	call   3d0 <fstat>
     2d4:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
     2d7:	8b 45 f4             	mov    -0xc(%ebp),%eax
     2da:	89 04 24             	mov    %eax,(%esp)
     2dd:	e8 be 00 00 00       	call   3a0 <close>
  return r;
     2e2:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     2e5:	c9                   	leave  
     2e6:	c3                   	ret    

000002e7 <atoi>:

int
atoi(const char *s)
{
     2e7:	55                   	push   %ebp
     2e8:	89 e5                	mov    %esp,%ebp
     2ea:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
     2ed:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
     2f4:	eb 23                	jmp    319 <atoi+0x32>
    n = n*10 + *s++ - '0';
     2f6:	8b 55 fc             	mov    -0x4(%ebp),%edx
     2f9:	89 d0                	mov    %edx,%eax
     2fb:	c1 e0 02             	shl    $0x2,%eax
     2fe:	01 d0                	add    %edx,%eax
     300:	01 c0                	add    %eax,%eax
     302:	89 c2                	mov    %eax,%edx
     304:	8b 45 08             	mov    0x8(%ebp),%eax
     307:	0f b6 00             	movzbl (%eax),%eax
     30a:	0f be c0             	movsbl %al,%eax
     30d:	01 d0                	add    %edx,%eax
     30f:	83 e8 30             	sub    $0x30,%eax
     312:	89 45 fc             	mov    %eax,-0x4(%ebp)
     315:	83 45 08 01          	addl   $0x1,0x8(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     319:	8b 45 08             	mov    0x8(%ebp),%eax
     31c:	0f b6 00             	movzbl (%eax),%eax
     31f:	3c 2f                	cmp    $0x2f,%al
     321:	7e 0a                	jle    32d <atoi+0x46>
     323:	8b 45 08             	mov    0x8(%ebp),%eax
     326:	0f b6 00             	movzbl (%eax),%eax
     329:	3c 39                	cmp    $0x39,%al
     32b:	7e c9                	jle    2f6 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
     32d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     330:	c9                   	leave  
     331:	c3                   	ret    

00000332 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
     332:	55                   	push   %ebp
     333:	89 e5                	mov    %esp,%ebp
     335:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
     338:	8b 45 08             	mov    0x8(%ebp),%eax
     33b:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
     33e:	8b 45 0c             	mov    0xc(%ebp),%eax
     341:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
     344:	eb 13                	jmp    359 <memmove+0x27>
    *dst++ = *src++;
     346:	8b 45 f8             	mov    -0x8(%ebp),%eax
     349:	0f b6 10             	movzbl (%eax),%edx
     34c:	8b 45 fc             	mov    -0x4(%ebp),%eax
     34f:	88 10                	mov    %dl,(%eax)
     351:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     355:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
     359:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     35d:	0f 9f c0             	setg   %al
     360:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
     364:	84 c0                	test   %al,%al
     366:	75 de                	jne    346 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
     368:	8b 45 08             	mov    0x8(%ebp),%eax
}
     36b:	c9                   	leave  
     36c:	c3                   	ret    
     36d:	90                   	nop
     36e:	90                   	nop
     36f:	90                   	nop

00000370 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     370:	b8 01 00 00 00       	mov    $0x1,%eax
     375:	cd 40                	int    $0x40
     377:	c3                   	ret    

00000378 <exit>:
SYSCALL(exit)
     378:	b8 02 00 00 00       	mov    $0x2,%eax
     37d:	cd 40                	int    $0x40
     37f:	c3                   	ret    

00000380 <wait>:
SYSCALL(wait)
     380:	b8 03 00 00 00       	mov    $0x3,%eax
     385:	cd 40                	int    $0x40
     387:	c3                   	ret    

00000388 <pipe>:
SYSCALL(pipe)
     388:	b8 04 00 00 00       	mov    $0x4,%eax
     38d:	cd 40                	int    $0x40
     38f:	c3                   	ret    

00000390 <read>:
SYSCALL(read)
     390:	b8 05 00 00 00       	mov    $0x5,%eax
     395:	cd 40                	int    $0x40
     397:	c3                   	ret    

00000398 <write>:
SYSCALL(write)
     398:	b8 10 00 00 00       	mov    $0x10,%eax
     39d:	cd 40                	int    $0x40
     39f:	c3                   	ret    

000003a0 <close>:
SYSCALL(close)
     3a0:	b8 15 00 00 00       	mov    $0x15,%eax
     3a5:	cd 40                	int    $0x40
     3a7:	c3                   	ret    

000003a8 <kill>:
SYSCALL(kill)
     3a8:	b8 06 00 00 00       	mov    $0x6,%eax
     3ad:	cd 40                	int    $0x40
     3af:	c3                   	ret    

000003b0 <exec>:
SYSCALL(exec)
     3b0:	b8 07 00 00 00       	mov    $0x7,%eax
     3b5:	cd 40                	int    $0x40
     3b7:	c3                   	ret    

000003b8 <open>:
SYSCALL(open)
     3b8:	b8 0f 00 00 00       	mov    $0xf,%eax
     3bd:	cd 40                	int    $0x40
     3bf:	c3                   	ret    

000003c0 <mknod>:
SYSCALL(mknod)
     3c0:	b8 11 00 00 00       	mov    $0x11,%eax
     3c5:	cd 40                	int    $0x40
     3c7:	c3                   	ret    

000003c8 <unlink>:
SYSCALL(unlink)
     3c8:	b8 12 00 00 00       	mov    $0x12,%eax
     3cd:	cd 40                	int    $0x40
     3cf:	c3                   	ret    

000003d0 <fstat>:
SYSCALL(fstat)
     3d0:	b8 08 00 00 00       	mov    $0x8,%eax
     3d5:	cd 40                	int    $0x40
     3d7:	c3                   	ret    

000003d8 <link>:
SYSCALL(link)
     3d8:	b8 13 00 00 00       	mov    $0x13,%eax
     3dd:	cd 40                	int    $0x40
     3df:	c3                   	ret    

000003e0 <mkdir>:
SYSCALL(mkdir)
     3e0:	b8 14 00 00 00       	mov    $0x14,%eax
     3e5:	cd 40                	int    $0x40
     3e7:	c3                   	ret    

000003e8 <chdir>:
SYSCALL(chdir)
     3e8:	b8 09 00 00 00       	mov    $0x9,%eax
     3ed:	cd 40                	int    $0x40
     3ef:	c3                   	ret    

000003f0 <dup>:
SYSCALL(dup)
     3f0:	b8 0a 00 00 00       	mov    $0xa,%eax
     3f5:	cd 40                	int    $0x40
     3f7:	c3                   	ret    

000003f8 <getpid>:
SYSCALL(getpid)
     3f8:	b8 0b 00 00 00       	mov    $0xb,%eax
     3fd:	cd 40                	int    $0x40
     3ff:	c3                   	ret    

00000400 <sbrk>:
SYSCALL(sbrk)
     400:	b8 0c 00 00 00       	mov    $0xc,%eax
     405:	cd 40                	int    $0x40
     407:	c3                   	ret    

00000408 <sleep>:
SYSCALL(sleep)
     408:	b8 0d 00 00 00       	mov    $0xd,%eax
     40d:	cd 40                	int    $0x40
     40f:	c3                   	ret    

00000410 <uptime>:
SYSCALL(uptime)
     410:	b8 0e 00 00 00       	mov    $0xe,%eax
     415:	cd 40                	int    $0x40
     417:	c3                   	ret    

00000418 <add_path>:
SYSCALL(add_path)
     418:	b8 16 00 00 00       	mov    $0x16,%eax
     41d:	cd 40                	int    $0x40
     41f:	c3                   	ret    

00000420 <wait2>:
SYSCALL(wait2)
     420:	b8 17 00 00 00       	mov    $0x17,%eax
     425:	cd 40                	int    $0x40
     427:	c3                   	ret    

00000428 <getquanta>:
SYSCALL(getquanta)
     428:	b8 18 00 00 00       	mov    $0x18,%eax
     42d:	cd 40                	int    $0x40
     42f:	c3                   	ret    

00000430 <getqueue>:
SYSCALL(getqueue)
     430:	b8 19 00 00 00       	mov    $0x19,%eax
     435:	cd 40                	int    $0x40
     437:	c3                   	ret    

00000438 <signal>:
SYSCALL(signal)
     438:	b8 1a 00 00 00       	mov    $0x1a,%eax
     43d:	cd 40                	int    $0x40
     43f:	c3                   	ret    

00000440 <sigsend>:
SYSCALL(sigsend)
     440:	b8 1b 00 00 00       	mov    $0x1b,%eax
     445:	cd 40                	int    $0x40
     447:	c3                   	ret    

00000448 <alarm>:
SYSCALL(alarm)
     448:	b8 1c 00 00 00       	mov    $0x1c,%eax
     44d:	cd 40                	int    $0x40
     44f:	c3                   	ret    

00000450 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
     450:	55                   	push   %ebp
     451:	89 e5                	mov    %esp,%ebp
     453:	83 ec 28             	sub    $0x28,%esp
     456:	8b 45 0c             	mov    0xc(%ebp),%eax
     459:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
     45c:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
     463:	00 
     464:	8d 45 f4             	lea    -0xc(%ebp),%eax
     467:	89 44 24 04          	mov    %eax,0x4(%esp)
     46b:	8b 45 08             	mov    0x8(%ebp),%eax
     46e:	89 04 24             	mov    %eax,(%esp)
     471:	e8 22 ff ff ff       	call   398 <write>
}
     476:	c9                   	leave  
     477:	c3                   	ret    

00000478 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     478:	55                   	push   %ebp
     479:	89 e5                	mov    %esp,%ebp
     47b:	83 ec 48             	sub    $0x48,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     47e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
     485:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     489:	74 17                	je     4a2 <printint+0x2a>
     48b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     48f:	79 11                	jns    4a2 <printint+0x2a>
    neg = 1;
     491:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
     498:	8b 45 0c             	mov    0xc(%ebp),%eax
     49b:	f7 d8                	neg    %eax
     49d:	89 45 ec             	mov    %eax,-0x14(%ebp)
     4a0:	eb 06                	jmp    4a8 <printint+0x30>
  } else {
    x = xx;
     4a2:	8b 45 0c             	mov    0xc(%ebp),%eax
     4a5:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
     4a8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
     4af:	8b 4d 10             	mov    0x10(%ebp),%ecx
     4b2:	8b 45 ec             	mov    -0x14(%ebp),%eax
     4b5:	ba 00 00 00 00       	mov    $0x0,%edx
     4ba:	f7 f1                	div    %ecx
     4bc:	89 d0                	mov    %edx,%eax
     4be:	0f b6 90 90 15 00 00 	movzbl 0x1590(%eax),%edx
     4c5:	8d 45 dc             	lea    -0x24(%ebp),%eax
     4c8:	03 45 f4             	add    -0xc(%ebp),%eax
     4cb:	88 10                	mov    %dl,(%eax)
     4cd:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  }while((x /= base) != 0);
     4d1:	8b 55 10             	mov    0x10(%ebp),%edx
     4d4:	89 55 d4             	mov    %edx,-0x2c(%ebp)
     4d7:	8b 45 ec             	mov    -0x14(%ebp),%eax
     4da:	ba 00 00 00 00       	mov    $0x0,%edx
     4df:	f7 75 d4             	divl   -0x2c(%ebp)
     4e2:	89 45 ec             	mov    %eax,-0x14(%ebp)
     4e5:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     4e9:	75 c4                	jne    4af <printint+0x37>
  if(neg)
     4eb:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     4ef:	74 2a                	je     51b <printint+0xa3>
    buf[i++] = '-';
     4f1:	8d 45 dc             	lea    -0x24(%ebp),%eax
     4f4:	03 45 f4             	add    -0xc(%ebp),%eax
     4f7:	c6 00 2d             	movb   $0x2d,(%eax)
     4fa:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)

  while(--i >= 0)
     4fe:	eb 1b                	jmp    51b <printint+0xa3>
    putc(fd, buf[i]);
     500:	8d 45 dc             	lea    -0x24(%ebp),%eax
     503:	03 45 f4             	add    -0xc(%ebp),%eax
     506:	0f b6 00             	movzbl (%eax),%eax
     509:	0f be c0             	movsbl %al,%eax
     50c:	89 44 24 04          	mov    %eax,0x4(%esp)
     510:	8b 45 08             	mov    0x8(%ebp),%eax
     513:	89 04 24             	mov    %eax,(%esp)
     516:	e8 35 ff ff ff       	call   450 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
     51b:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
     51f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     523:	79 db                	jns    500 <printint+0x88>
    putc(fd, buf[i]);
}
     525:	c9                   	leave  
     526:	c3                   	ret    

00000527 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     527:	55                   	push   %ebp
     528:	89 e5                	mov    %esp,%ebp
     52a:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
     52d:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
     534:	8d 45 0c             	lea    0xc(%ebp),%eax
     537:	83 c0 04             	add    $0x4,%eax
     53a:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
     53d:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     544:	e9 7d 01 00 00       	jmp    6c6 <printf+0x19f>
    c = fmt[i] & 0xff;
     549:	8b 55 0c             	mov    0xc(%ebp),%edx
     54c:	8b 45 f0             	mov    -0x10(%ebp),%eax
     54f:	01 d0                	add    %edx,%eax
     551:	0f b6 00             	movzbl (%eax),%eax
     554:	0f be c0             	movsbl %al,%eax
     557:	25 ff 00 00 00       	and    $0xff,%eax
     55c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
     55f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     563:	75 2c                	jne    591 <printf+0x6a>
      if(c == '%'){
     565:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     569:	75 0c                	jne    577 <printf+0x50>
        state = '%';
     56b:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
     572:	e9 4b 01 00 00       	jmp    6c2 <printf+0x19b>
      } else {
        putc(fd, c);
     577:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     57a:	0f be c0             	movsbl %al,%eax
     57d:	89 44 24 04          	mov    %eax,0x4(%esp)
     581:	8b 45 08             	mov    0x8(%ebp),%eax
     584:	89 04 24             	mov    %eax,(%esp)
     587:	e8 c4 fe ff ff       	call   450 <putc>
     58c:	e9 31 01 00 00       	jmp    6c2 <printf+0x19b>
      }
    } else if(state == '%'){
     591:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
     595:	0f 85 27 01 00 00    	jne    6c2 <printf+0x19b>
      if(c == 'd'){
     59b:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
     59f:	75 2d                	jne    5ce <printf+0xa7>
        printint(fd, *ap, 10, 1);
     5a1:	8b 45 e8             	mov    -0x18(%ebp),%eax
     5a4:	8b 00                	mov    (%eax),%eax
     5a6:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
     5ad:	00 
     5ae:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
     5b5:	00 
     5b6:	89 44 24 04          	mov    %eax,0x4(%esp)
     5ba:	8b 45 08             	mov    0x8(%ebp),%eax
     5bd:	89 04 24             	mov    %eax,(%esp)
     5c0:	e8 b3 fe ff ff       	call   478 <printint>
        ap++;
     5c5:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     5c9:	e9 ed 00 00 00       	jmp    6bb <printf+0x194>
      } else if(c == 'x' || c == 'p'){
     5ce:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
     5d2:	74 06                	je     5da <printf+0xb3>
     5d4:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
     5d8:	75 2d                	jne    607 <printf+0xe0>
        printint(fd, *ap, 16, 0);
     5da:	8b 45 e8             	mov    -0x18(%ebp),%eax
     5dd:	8b 00                	mov    (%eax),%eax
     5df:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
     5e6:	00 
     5e7:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
     5ee:	00 
     5ef:	89 44 24 04          	mov    %eax,0x4(%esp)
     5f3:	8b 45 08             	mov    0x8(%ebp),%eax
     5f6:	89 04 24             	mov    %eax,(%esp)
     5f9:	e8 7a fe ff ff       	call   478 <printint>
        ap++;
     5fe:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     602:	e9 b4 00 00 00       	jmp    6bb <printf+0x194>
      } else if(c == 's'){
     607:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
     60b:	75 46                	jne    653 <printf+0x12c>
        s = (char*)*ap;
     60d:	8b 45 e8             	mov    -0x18(%ebp),%eax
     610:	8b 00                	mov    (%eax),%eax
     612:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
     615:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
     619:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     61d:	75 27                	jne    646 <printf+0x11f>
          s = "(null)";
     61f:	c7 45 f4 90 10 00 00 	movl   $0x1090,-0xc(%ebp)
        while(*s != 0){
     626:	eb 1e                	jmp    646 <printf+0x11f>
          putc(fd, *s);
     628:	8b 45 f4             	mov    -0xc(%ebp),%eax
     62b:	0f b6 00             	movzbl (%eax),%eax
     62e:	0f be c0             	movsbl %al,%eax
     631:	89 44 24 04          	mov    %eax,0x4(%esp)
     635:	8b 45 08             	mov    0x8(%ebp),%eax
     638:	89 04 24             	mov    %eax,(%esp)
     63b:	e8 10 fe ff ff       	call   450 <putc>
          s++;
     640:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     644:	eb 01                	jmp    647 <printf+0x120>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
     646:	90                   	nop
     647:	8b 45 f4             	mov    -0xc(%ebp),%eax
     64a:	0f b6 00             	movzbl (%eax),%eax
     64d:	84 c0                	test   %al,%al
     64f:	75 d7                	jne    628 <printf+0x101>
     651:	eb 68                	jmp    6bb <printf+0x194>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
     653:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
     657:	75 1d                	jne    676 <printf+0x14f>
        putc(fd, *ap);
     659:	8b 45 e8             	mov    -0x18(%ebp),%eax
     65c:	8b 00                	mov    (%eax),%eax
     65e:	0f be c0             	movsbl %al,%eax
     661:	89 44 24 04          	mov    %eax,0x4(%esp)
     665:	8b 45 08             	mov    0x8(%ebp),%eax
     668:	89 04 24             	mov    %eax,(%esp)
     66b:	e8 e0 fd ff ff       	call   450 <putc>
        ap++;
     670:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     674:	eb 45                	jmp    6bb <printf+0x194>
      } else if(c == '%'){
     676:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     67a:	75 17                	jne    693 <printf+0x16c>
        putc(fd, c);
     67c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     67f:	0f be c0             	movsbl %al,%eax
     682:	89 44 24 04          	mov    %eax,0x4(%esp)
     686:	8b 45 08             	mov    0x8(%ebp),%eax
     689:	89 04 24             	mov    %eax,(%esp)
     68c:	e8 bf fd ff ff       	call   450 <putc>
     691:	eb 28                	jmp    6bb <printf+0x194>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     693:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
     69a:	00 
     69b:	8b 45 08             	mov    0x8(%ebp),%eax
     69e:	89 04 24             	mov    %eax,(%esp)
     6a1:	e8 aa fd ff ff       	call   450 <putc>
        putc(fd, c);
     6a6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     6a9:	0f be c0             	movsbl %al,%eax
     6ac:	89 44 24 04          	mov    %eax,0x4(%esp)
     6b0:	8b 45 08             	mov    0x8(%ebp),%eax
     6b3:	89 04 24             	mov    %eax,(%esp)
     6b6:	e8 95 fd ff ff       	call   450 <putc>
      }
      state = 0;
     6bb:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     6c2:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     6c6:	8b 55 0c             	mov    0xc(%ebp),%edx
     6c9:	8b 45 f0             	mov    -0x10(%ebp),%eax
     6cc:	01 d0                	add    %edx,%eax
     6ce:	0f b6 00             	movzbl (%eax),%eax
     6d1:	84 c0                	test   %al,%al
     6d3:	0f 85 70 fe ff ff    	jne    549 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
     6d9:	c9                   	leave  
     6da:	c3                   	ret    
     6db:	90                   	nop

000006dc <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     6dc:	55                   	push   %ebp
     6dd:	89 e5                	mov    %esp,%ebp
     6df:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
     6e2:	8b 45 08             	mov    0x8(%ebp),%eax
     6e5:	83 e8 08             	sub    $0x8,%eax
     6e8:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     6eb:	a1 c8 15 00 00       	mov    0x15c8,%eax
     6f0:	89 45 fc             	mov    %eax,-0x4(%ebp)
     6f3:	eb 24                	jmp    719 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     6f5:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6f8:	8b 00                	mov    (%eax),%eax
     6fa:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     6fd:	77 12                	ja     711 <free+0x35>
     6ff:	8b 45 f8             	mov    -0x8(%ebp),%eax
     702:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     705:	77 24                	ja     72b <free+0x4f>
     707:	8b 45 fc             	mov    -0x4(%ebp),%eax
     70a:	8b 00                	mov    (%eax),%eax
     70c:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     70f:	77 1a                	ja     72b <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     711:	8b 45 fc             	mov    -0x4(%ebp),%eax
     714:	8b 00                	mov    (%eax),%eax
     716:	89 45 fc             	mov    %eax,-0x4(%ebp)
     719:	8b 45 f8             	mov    -0x8(%ebp),%eax
     71c:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     71f:	76 d4                	jbe    6f5 <free+0x19>
     721:	8b 45 fc             	mov    -0x4(%ebp),%eax
     724:	8b 00                	mov    (%eax),%eax
     726:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     729:	76 ca                	jbe    6f5 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
     72b:	8b 45 f8             	mov    -0x8(%ebp),%eax
     72e:	8b 40 04             	mov    0x4(%eax),%eax
     731:	c1 e0 03             	shl    $0x3,%eax
     734:	89 c2                	mov    %eax,%edx
     736:	03 55 f8             	add    -0x8(%ebp),%edx
     739:	8b 45 fc             	mov    -0x4(%ebp),%eax
     73c:	8b 00                	mov    (%eax),%eax
     73e:	39 c2                	cmp    %eax,%edx
     740:	75 24                	jne    766 <free+0x8a>
    bp->s.size += p->s.ptr->s.size;
     742:	8b 45 f8             	mov    -0x8(%ebp),%eax
     745:	8b 50 04             	mov    0x4(%eax),%edx
     748:	8b 45 fc             	mov    -0x4(%ebp),%eax
     74b:	8b 00                	mov    (%eax),%eax
     74d:	8b 40 04             	mov    0x4(%eax),%eax
     750:	01 c2                	add    %eax,%edx
     752:	8b 45 f8             	mov    -0x8(%ebp),%eax
     755:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
     758:	8b 45 fc             	mov    -0x4(%ebp),%eax
     75b:	8b 00                	mov    (%eax),%eax
     75d:	8b 10                	mov    (%eax),%edx
     75f:	8b 45 f8             	mov    -0x8(%ebp),%eax
     762:	89 10                	mov    %edx,(%eax)
     764:	eb 0a                	jmp    770 <free+0x94>
  } else
    bp->s.ptr = p->s.ptr;
     766:	8b 45 fc             	mov    -0x4(%ebp),%eax
     769:	8b 10                	mov    (%eax),%edx
     76b:	8b 45 f8             	mov    -0x8(%ebp),%eax
     76e:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
     770:	8b 45 fc             	mov    -0x4(%ebp),%eax
     773:	8b 40 04             	mov    0x4(%eax),%eax
     776:	c1 e0 03             	shl    $0x3,%eax
     779:	03 45 fc             	add    -0x4(%ebp),%eax
     77c:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     77f:	75 20                	jne    7a1 <free+0xc5>
    p->s.size += bp->s.size;
     781:	8b 45 fc             	mov    -0x4(%ebp),%eax
     784:	8b 50 04             	mov    0x4(%eax),%edx
     787:	8b 45 f8             	mov    -0x8(%ebp),%eax
     78a:	8b 40 04             	mov    0x4(%eax),%eax
     78d:	01 c2                	add    %eax,%edx
     78f:	8b 45 fc             	mov    -0x4(%ebp),%eax
     792:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
     795:	8b 45 f8             	mov    -0x8(%ebp),%eax
     798:	8b 10                	mov    (%eax),%edx
     79a:	8b 45 fc             	mov    -0x4(%ebp),%eax
     79d:	89 10                	mov    %edx,(%eax)
     79f:	eb 08                	jmp    7a9 <free+0xcd>
  } else
    p->s.ptr = bp;
     7a1:	8b 45 fc             	mov    -0x4(%ebp),%eax
     7a4:	8b 55 f8             	mov    -0x8(%ebp),%edx
     7a7:	89 10                	mov    %edx,(%eax)
  freep = p;
     7a9:	8b 45 fc             	mov    -0x4(%ebp),%eax
     7ac:	a3 c8 15 00 00       	mov    %eax,0x15c8
}
     7b1:	c9                   	leave  
     7b2:	c3                   	ret    

000007b3 <morecore>:

static Header*
morecore(uint nu)
{
     7b3:	55                   	push   %ebp
     7b4:	89 e5                	mov    %esp,%ebp
     7b6:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
     7b9:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
     7c0:	77 07                	ja     7c9 <morecore+0x16>
    nu = 4096;
     7c2:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
     7c9:	8b 45 08             	mov    0x8(%ebp),%eax
     7cc:	c1 e0 03             	shl    $0x3,%eax
     7cf:	89 04 24             	mov    %eax,(%esp)
     7d2:	e8 29 fc ff ff       	call   400 <sbrk>
     7d7:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
     7da:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     7de:	75 07                	jne    7e7 <morecore+0x34>
    return 0;
     7e0:	b8 00 00 00 00       	mov    $0x0,%eax
     7e5:	eb 22                	jmp    809 <morecore+0x56>
  hp = (Header*)p;
     7e7:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7ea:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
     7ed:	8b 45 f0             	mov    -0x10(%ebp),%eax
     7f0:	8b 55 08             	mov    0x8(%ebp),%edx
     7f3:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
     7f6:	8b 45 f0             	mov    -0x10(%ebp),%eax
     7f9:	83 c0 08             	add    $0x8,%eax
     7fc:	89 04 24             	mov    %eax,(%esp)
     7ff:	e8 d8 fe ff ff       	call   6dc <free>
  return freep;
     804:	a1 c8 15 00 00       	mov    0x15c8,%eax
}
     809:	c9                   	leave  
     80a:	c3                   	ret    

0000080b <malloc>:

void*
malloc(uint nbytes)
{
     80b:	55                   	push   %ebp
     80c:	89 e5                	mov    %esp,%ebp
     80e:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     811:	8b 45 08             	mov    0x8(%ebp),%eax
     814:	83 c0 07             	add    $0x7,%eax
     817:	c1 e8 03             	shr    $0x3,%eax
     81a:	83 c0 01             	add    $0x1,%eax
     81d:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
     820:	a1 c8 15 00 00       	mov    0x15c8,%eax
     825:	89 45 f0             	mov    %eax,-0x10(%ebp)
     828:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     82c:	75 23                	jne    851 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     82e:	c7 45 f0 c0 15 00 00 	movl   $0x15c0,-0x10(%ebp)
     835:	8b 45 f0             	mov    -0x10(%ebp),%eax
     838:	a3 c8 15 00 00       	mov    %eax,0x15c8
     83d:	a1 c8 15 00 00       	mov    0x15c8,%eax
     842:	a3 c0 15 00 00       	mov    %eax,0x15c0
    base.s.size = 0;
     847:	c7 05 c4 15 00 00 00 	movl   $0x0,0x15c4
     84e:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     851:	8b 45 f0             	mov    -0x10(%ebp),%eax
     854:	8b 00                	mov    (%eax),%eax
     856:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
     859:	8b 45 f4             	mov    -0xc(%ebp),%eax
     85c:	8b 40 04             	mov    0x4(%eax),%eax
     85f:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     862:	72 4d                	jb     8b1 <malloc+0xa6>
      if(p->s.size == nunits)
     864:	8b 45 f4             	mov    -0xc(%ebp),%eax
     867:	8b 40 04             	mov    0x4(%eax),%eax
     86a:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     86d:	75 0c                	jne    87b <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
     86f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     872:	8b 10                	mov    (%eax),%edx
     874:	8b 45 f0             	mov    -0x10(%ebp),%eax
     877:	89 10                	mov    %edx,(%eax)
     879:	eb 26                	jmp    8a1 <malloc+0x96>
      else {
        p->s.size -= nunits;
     87b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     87e:	8b 40 04             	mov    0x4(%eax),%eax
     881:	89 c2                	mov    %eax,%edx
     883:	2b 55 ec             	sub    -0x14(%ebp),%edx
     886:	8b 45 f4             	mov    -0xc(%ebp),%eax
     889:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
     88c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     88f:	8b 40 04             	mov    0x4(%eax),%eax
     892:	c1 e0 03             	shl    $0x3,%eax
     895:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
     898:	8b 45 f4             	mov    -0xc(%ebp),%eax
     89b:	8b 55 ec             	mov    -0x14(%ebp),%edx
     89e:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
     8a1:	8b 45 f0             	mov    -0x10(%ebp),%eax
     8a4:	a3 c8 15 00 00       	mov    %eax,0x15c8
      return (void*)(p + 1);
     8a9:	8b 45 f4             	mov    -0xc(%ebp),%eax
     8ac:	83 c0 08             	add    $0x8,%eax
     8af:	eb 38                	jmp    8e9 <malloc+0xde>
    }
    if(p == freep)
     8b1:	a1 c8 15 00 00       	mov    0x15c8,%eax
     8b6:	39 45 f4             	cmp    %eax,-0xc(%ebp)
     8b9:	75 1b                	jne    8d6 <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
     8bb:	8b 45 ec             	mov    -0x14(%ebp),%eax
     8be:	89 04 24             	mov    %eax,(%esp)
     8c1:	e8 ed fe ff ff       	call   7b3 <morecore>
     8c6:	89 45 f4             	mov    %eax,-0xc(%ebp)
     8c9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     8cd:	75 07                	jne    8d6 <malloc+0xcb>
        return 0;
     8cf:	b8 00 00 00 00       	mov    $0x0,%eax
     8d4:	eb 13                	jmp    8e9 <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     8d6:	8b 45 f4             	mov    -0xc(%ebp),%eax
     8d9:	89 45 f0             	mov    %eax,-0x10(%ebp)
     8dc:	8b 45 f4             	mov    -0xc(%ebp),%eax
     8df:	8b 00                	mov    (%eax),%eax
     8e1:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
     8e4:	e9 70 ff ff ff       	jmp    859 <malloc+0x4e>
}
     8e9:	c9                   	leave  
     8ea:	c3                   	ret    
     8eb:	90                   	nop

000008ec <print_stack>:
 * prints the stack of the currently running thread
 * DEBUGGING purposes
 */
void
print_stack()
{
     8ec:	55                   	push   %ebp
     8ed:	89 e5                	mov    %esp,%ebp
     8ef:	83 ec 28             	sub    $0x28,%esp
  int *newesp = (int*)currentThread->esp;  
     8f2:	a1 e0 5e 00 00       	mov    0x5ee0,%eax
     8f7:	8b 40 04             	mov    0x4(%eax),%eax
     8fa:	89 45 f4             	mov    %eax,-0xc(%ebp)
  printf(1,"stack for thread %d \n",currentThread->tid);
     8fd:	a1 e0 5e 00 00       	mov    0x5ee0,%eax
     902:	8b 00                	mov    (%eax),%eax
     904:	89 44 24 08          	mov    %eax,0x8(%esp)
     908:	c7 44 24 04 98 10 00 	movl   $0x1098,0x4(%esp)
     90f:	00 
     910:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     917:	e8 0b fc ff ff       	call   527 <printf>
  while((newesp < (int *)currentThread->ebp))
     91c:	eb 3c                	jmp    95a <print_stack+0x6e>
  {
    printf(1,"add:%x ",newesp);
     91e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     921:	89 44 24 08          	mov    %eax,0x8(%esp)
     925:	c7 44 24 04 ae 10 00 	movl   $0x10ae,0x4(%esp)
     92c:	00 
     92d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     934:	e8 ee fb ff ff       	call   527 <printf>
      printf(1,"val:%x\n",*newesp);
     939:	8b 45 f4             	mov    -0xc(%ebp),%eax
     93c:	8b 00                	mov    (%eax),%eax
     93e:	89 44 24 08          	mov    %eax,0x8(%esp)
     942:	c7 44 24 04 b6 10 00 	movl   $0x10b6,0x4(%esp)
     949:	00 
     94a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     951:	e8 d1 fb ff ff       	call   527 <printf>
    newesp++;
     956:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
void
print_stack()
{
  int *newesp = (int*)currentThread->esp;  
  printf(1,"stack for thread %d \n",currentThread->tid);
  while((newesp < (int *)currentThread->ebp))
     95a:	a1 e0 5e 00 00       	mov    0x5ee0,%eax
     95f:	8b 40 08             	mov    0x8(%eax),%eax
     962:	3b 45 f4             	cmp    -0xc(%ebp),%eax
     965:	77 b7                	ja     91e <print_stack+0x32>
    printf(1,"add:%x ",newesp);
      printf(1,"val:%x\n",*newesp);
    newesp++;
  }

}
     967:	c9                   	leave  
     968:	c3                   	ret    

00000969 <getNextThread>:
 * returns the next thread in line to run
 * if none exists it returns -1
 */
int
getNextThread(int j)
{
     969:	55                   	push   %ebp
     96a:	89 e5                	mov    %esp,%ebp
     96c:	83 ec 10             	sub    $0x10,%esp
  int i=j+1;
     96f:	8b 45 08             	mov    0x8(%ebp),%eax
     972:	83 c0 01             	add    $0x1,%eax
     975:	89 45 fc             	mov    %eax,-0x4(%ebp)
  if(i==MAX_THREAD)
     978:	83 7d fc 40          	cmpl   $0x40,-0x4(%ebp)
     97c:	75 07                	jne    985 <getNextThread+0x1c>
    i=0;
     97e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  uthread_p t=&tTable.table[i];
     985:	8b 45 fc             	mov    -0x4(%ebp),%eax
     988:	69 c0 24 01 00 00    	imul   $0x124,%eax,%eax
     98e:	05 e0 15 00 00       	add    $0x15e0,%eax
     993:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(i!=j)
     996:	eb 3b                	jmp    9d3 <getNextThread+0x6a>
  {
    if(t->state==T_RUNNABLE)
     998:	8b 45 f8             	mov    -0x8(%ebp),%eax
     99b:	8b 40 10             	mov    0x10(%eax),%eax
     99e:	83 f8 03             	cmp    $0x3,%eax
     9a1:	75 05                	jne    9a8 <getNextThread+0x3f>
      return i;
     9a3:	8b 45 fc             	mov    -0x4(%ebp),%eax
     9a6:	eb 38                	jmp    9e0 <getNextThread+0x77>
    i++;
     9a8:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    if(i==MAX_THREAD)
     9ac:	83 7d fc 40          	cmpl   $0x40,-0x4(%ebp)
     9b0:	75 1a                	jne    9cc <getNextThread+0x63>
    {
     i=0;
     9b2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
     t=&tTable.table[i];
     9b9:	8b 45 fc             	mov    -0x4(%ebp),%eax
     9bc:	69 c0 24 01 00 00    	imul   $0x124,%eax,%eax
     9c2:	05 e0 15 00 00       	add    $0x15e0,%eax
     9c7:	89 45 f8             	mov    %eax,-0x8(%ebp)
     9ca:	eb 07                	jmp    9d3 <getNextThread+0x6a>
   }
   else
    t++;
     9cc:	81 45 f8 24 01 00 00 	addl   $0x124,-0x8(%ebp)
{
  int i=j+1;
  if(i==MAX_THREAD)
    i=0;
  uthread_p t=&tTable.table[i];
  while(i!=j)
     9d3:	8b 45 fc             	mov    -0x4(%ebp),%eax
     9d6:	3b 45 08             	cmp    0x8(%ebp),%eax
     9d9:	75 bd                	jne    998 <getNextThread+0x2f>
   }
   else
    t++;

}
return -1;
     9db:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
     9e0:	c9                   	leave  
     9e1:	c3                   	ret    

000009e2 <allocThread>:
 * allocates a spot for a new thread
 * if none exist it returns NULL
 */
static uthread_p
allocThread()
{
     9e2:	55                   	push   %ebp
     9e3:	89 e5                	mov    %esp,%ebp
     9e5:	83 ec 28             	sub    $0x28,%esp
  int i,j;
  uthread_p t;
  
  for (t=tTable.table,i=0 ; t < &tTable.table[MAX_THREAD]; t++,i++)
     9e8:	c7 45 ec e0 15 00 00 	movl   $0x15e0,-0x14(%ebp)
     9ef:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     9f6:	eb 15                	jmp    a0d <allocThread+0x2b>
  {
    if(t->state==T_FREE)
     9f8:	8b 45 ec             	mov    -0x14(%ebp),%eax
     9fb:	8b 40 10             	mov    0x10(%eax),%eax
     9fe:	85 c0                	test   %eax,%eax
     a00:	74 1e                	je     a20 <allocThread+0x3e>
allocThread()
{
  int i,j;
  uthread_p t;
  
  for (t=tTable.table,i=0 ; t < &tTable.table[MAX_THREAD]; t++,i++)
     a02:	81 45 ec 24 01 00 00 	addl   $0x124,-0x14(%ebp)
     a09:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     a0d:	81 7d ec e0 5e 00 00 	cmpl   $0x5ee0,-0x14(%ebp)
     a14:	72 e2                	jb     9f8 <allocThread+0x16>
  {
    if(t->state==T_FREE)
      goto found;
  }
  return 0;
     a16:	b8 00 00 00 00       	mov    $0x0,%eax
     a1b:	e9 a3 00 00 00       	jmp    ac3 <allocThread+0xe1>
  uthread_p t;
  
  for (t=tTable.table,i=0 ; t < &tTable.table[MAX_THREAD]; t++,i++)
  {
    if(t->state==T_FREE)
      goto found;
     a20:	90                   	nop
  }
  return 0;
  
  found:
  //Init all fields
  t->tid=i;
     a21:	8b 45 ec             	mov    -0x14(%ebp),%eax
     a24:	8b 55 f4             	mov    -0xc(%ebp),%edx
     a27:	89 10                	mov    %edx,(%eax)
  if(i==0) //main thread init
     a29:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     a2d:	75 1c                	jne    a4b <allocThread+0x69>
  {
    STORE_ESP(t->esp);
     a2f:	89 e2                	mov    %esp,%edx
     a31:	8b 45 ec             	mov    -0x14(%ebp),%eax
     a34:	89 50 04             	mov    %edx,0x4(%eax)
    STORE_EBP(t->ebp);
     a37:	89 ea                	mov    %ebp,%edx
     a39:	8b 45 ec             	mov    -0x14(%ebp),%eax
     a3c:	89 50 08             	mov    %edx,0x8(%eax)
    t->firstTime=0;
     a3f:	8b 45 ec             	mov    -0x14(%ebp),%eax
     a42:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
     a49:	eb 3b                	jmp    a86 <allocThread+0xa4>
  }
  else
  {
    t->stack=(char*)malloc(STACK_SIZE);
     a4b:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
     a52:	e8 b4 fd ff ff       	call   80b <malloc>
     a57:	8b 55 ec             	mov    -0x14(%ebp),%edx
     a5a:	89 42 0c             	mov    %eax,0xc(%edx)
    t->ebp=(int)t->stack+STACK_SIZE;
     a5d:	8b 45 ec             	mov    -0x14(%ebp),%eax
     a60:	8b 40 0c             	mov    0xc(%eax),%eax
     a63:	05 00 10 00 00       	add    $0x1000,%eax
     a68:	89 c2                	mov    %eax,%edx
     a6a:	8b 45 ec             	mov    -0x14(%ebp),%eax
     a6d:	89 50 08             	mov    %edx,0x8(%eax)
    t->esp=t->ebp;
     a70:	8b 45 ec             	mov    -0x14(%ebp),%eax
     a73:	8b 50 08             	mov    0x8(%eax),%edx
     a76:	8b 45 ec             	mov    -0x14(%ebp),%eax
     a79:	89 50 04             	mov    %edx,0x4(%eax)
    t->firstTime=1;
     a7c:	8b 45 ec             	mov    -0x14(%ebp),%eax
     a7f:	c7 40 14 01 00 00 00 	movl   $0x1,0x14(%eax)
  }
  
  t->waitingFor=-1;
     a86:	8b 45 ec             	mov    -0x14(%ebp),%eax
     a89:	c7 80 20 01 00 00 ff 	movl   $0xffffffff,0x120(%eax)
     a90:	ff ff ff 
  
  for(j=0;j<MAX_THREAD;j++)
     a93:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     a9a:	eb 14                	jmp    ab0 <allocThread+0xce>
  {
    t->waitedOn[j]=-1;
     a9c:	8b 45 ec             	mov    -0x14(%ebp),%eax
     a9f:	8b 55 f0             	mov    -0x10(%ebp),%edx
     aa2:	83 c2 08             	add    $0x8,%edx
     aa5:	c7 04 90 ff ff ff ff 	movl   $0xffffffff,(%eax,%edx,4)
    t->firstTime=1;
  }
  
  t->waitingFor=-1;
  
  for(j=0;j<MAX_THREAD;j++)
     aac:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     ab0:	83 7d f0 3f          	cmpl   $0x3f,-0x10(%ebp)
     ab4:	7e e6                	jle    a9c <allocThread+0xba>
  {
    t->waitedOn[j]=-1;
  }
   
  t->state=T_UNINIT;
     ab6:	8b 45 ec             	mov    -0x14(%ebp),%eax
     ab9:	c7 40 10 01 00 00 00 	movl   $0x1,0x10(%eax)
  
    
  return t;
     ac0:	8b 45 ec             	mov    -0x14(%ebp),%eax
}
     ac3:	c9                   	leave  
     ac4:	c3                   	ret    

00000ac5 <uthread_init>:
/*
 * initializes all the uthread structures
 */
int
uthread_init()
{   
     ac5:	55                   	push   %ebp
     ac6:	89 e5                	mov    %esp,%ebp
     ac8:	83 ec 28             	sub    $0x28,%esp
  //Initialize table
  int i;
  
  for(i=0;i<MAX_THREAD;i++)
     acb:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     ad2:	eb 18                	jmp    aec <uthread_init+0x27>
  {
    tTable.table[i].state=T_FREE;
     ad4:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ad7:	69 c0 24 01 00 00    	imul   $0x124,%eax,%eax
     add:	05 f0 15 00 00       	add    $0x15f0,%eax
     ae2:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
uthread_init()
{   
  //Initialize table
  int i;
  
  for(i=0;i<MAX_THREAD;i++)
     ae8:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     aec:	83 7d f4 3f          	cmpl   $0x3f,-0xc(%ebp)
     af0:	7e e2                	jle    ad4 <uthread_init+0xf>
  {
    tTable.table[i].state=T_FREE;
  }
  
 //allocate the main thread
  currentThread = allocThread();
     af2:	e8 eb fe ff ff       	call   9e2 <allocThread>
     af7:	a3 e0 5e 00 00       	mov    %eax,0x5ee0
  if(currentThread==0)
     afc:	a1 e0 5e 00 00       	mov    0x5ee0,%eax
     b01:	85 c0                	test   %eax,%eax
     b03:	75 07                	jne    b0c <uthread_init+0x47>
    return -1;
     b05:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     b0a:	eb 6b                	jmp    b77 <uthread_init+0xb2>
  
  currentThread->state = T_RUNNING;
     b0c:	a1 e0 5e 00 00       	mov    0x5ee0,%eax
     b11:	c7 40 10 02 00 00 00 	movl   $0x2,0x10(%eax)
  //register uthread_yield as signal handler for alarm
  if(signal(SIGALRM,uthread_yield)<0)
     b18:	c7 44 24 04 ff 0d 00 	movl   $0xdff,0x4(%esp)
     b1f:	00 
     b20:	c7 04 24 0e 00 00 00 	movl   $0xe,(%esp)
     b27:	e8 0c f9 ff ff       	call   438 <signal>
     b2c:	85 c0                	test   %eax,%eax
     b2e:	79 19                	jns    b49 <uthread_init+0x84>
  {
    printf(1,"Cant register the alarm signal");
     b30:	c7 44 24 04 c0 10 00 	movl   $0x10c0,0x4(%esp)
     b37:	00 
     b38:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     b3f:	e8 e3 f9 ff ff       	call   527 <printf>
    exit();
     b44:	e8 2f f8 ff ff       	call   378 <exit>
  }
  //set new alarm clock
  if(alarm(THREAD_QUANTA)<0)
     b49:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
     b50:	e8 f3 f8 ff ff       	call   448 <alarm>
     b55:	85 c0                	test   %eax,%eax
     b57:	79 19                	jns    b72 <uthread_init+0xad>
  {
    printf(1,"Cant activate alarm system call");
     b59:	c7 44 24 04 e0 10 00 	movl   $0x10e0,0x4(%esp)
     b60:	00 
     b61:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     b68:	e8 ba f9 ff ff       	call   527 <printf>
    exit();
     b6d:	e8 06 f8 ff ff       	call   378 <exit>
  }
  return 0;
     b72:	b8 00 00 00 00       	mov    $0x0,%eax
}
     b77:	c9                   	leave  
     b78:	c3                   	ret    

00000b79 <wrap_func>:

void
wrap_func()
{
     b79:	55                   	push   %ebp
     b7a:	89 e5                	mov    %esp,%ebp
     b7c:	83 ec 18             	sub    $0x18,%esp
  currentThread->func(currentThread->arguments);
     b7f:	a1 e0 5e 00 00       	mov    0x5ee0,%eax
     b84:	8b 50 18             	mov    0x18(%eax),%edx
     b87:	a1 e0 5e 00 00       	mov    0x5ee0,%eax
     b8c:	8b 40 1c             	mov    0x1c(%eax),%eax
     b8f:	89 04 24             	mov    %eax,(%esp)
     b92:	ff d2                	call   *%edx
  uthread_exit();
     b94:	e8 6c 00 00 00       	call   c05 <uthread_exit>
}
     b99:	c9                   	leave  
     b9a:	c3                   	ret    

00000b9b <uthread_create>:
 * to that function
 * if none can be created it returns -1;
 */
int  
uthread_create(void (*start_func)(void *), void* arg)
{
     b9b:	55                   	push   %ebp
     b9c:	89 e5                	mov    %esp,%ebp
     b9e:	53                   	push   %ebx
     b9f:	83 ec 14             	sub    $0x14,%esp
  uint local_esp;
  uthread_p t = allocThread();
     ba2:	e8 3b fe ff ff       	call   9e2 <allocThread>
     ba7:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(t==0)
     baa:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     bae:	75 07                	jne    bb7 <uthread_create+0x1c>
    return -1;
     bb0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     bb5:	eb 48                	jmp    bff <uthread_create+0x64>

  t->func=start_func;
     bb7:	8b 45 f4             	mov    -0xc(%ebp),%eax
     bba:	8b 55 08             	mov    0x8(%ebp),%edx
     bbd:	89 50 18             	mov    %edx,0x18(%eax)
  t->arguments=arg;
     bc0:	8b 45 f4             	mov    -0xc(%ebp),%eax
     bc3:	8b 55 0c             	mov    0xc(%ebp),%edx
     bc6:	89 50 1c             	mov    %edx,0x1c(%eax)
  
  //push starting func and return value on the right stack
  STORE_ESP(local_esp);
     bc9:	89 e3                	mov    %esp,%ebx
     bcb:	89 5d f0             	mov    %ebx,-0x10(%ebp)
  LOAD_ESP(t->esp);
     bce:	8b 45 f4             	mov    -0xc(%ebp),%eax
     bd1:	8b 40 04             	mov    0x4(%eax),%eax
     bd4:	89 c4                	mov    %eax,%esp
  PUSH_FUNC(t->esp,t->ebp,wrap_func);
     bd6:	8b 45 f4             	mov    -0xc(%ebp),%eax
     bd9:	8b 50 08             	mov    0x8(%eax),%edx
     bdc:	b8 79 0b 00 00       	mov    $0xb79,%eax
     be1:	50                   	push   %eax
     be2:	52                   	push   %edx
     be3:	89 e2                	mov    %esp,%edx
     be5:	8b 45 f4             	mov    -0xc(%ebp),%eax
     be8:	89 50 04             	mov    %edx,0x4(%eax)
  LOAD_ESP(local_esp);
     beb:	8b 45 f0             	mov    -0x10(%ebp),%eax
     bee:	89 c4                	mov    %eax,%esp
  
  t->state = T_RUNNABLE;
     bf0:	8b 45 f4             	mov    -0xc(%ebp),%eax
     bf3:	c7 40 10 03 00 00 00 	movl   $0x3,0x10(%eax)
  
  return t->tid;
     bfa:	8b 45 f4             	mov    -0xc(%ebp),%eax
     bfd:	8b 00                	mov    (%eax),%eax
}
     bff:	83 c4 14             	add    $0x14,%esp
     c02:	5b                   	pop    %ebx
     c03:	5d                   	pop    %ebp
     c04:	c3                   	ret    

00000c05 <uthread_exit>:
 * closes the running thread, wakes up all
 * the threads waiting for this one (if they require waking up)
 */
void 
uthread_exit()
{
     c05:	55                   	push   %ebp
     c06:	89 e5                	mov    %esp,%ebp
     c08:	83 ec 28             	sub    $0x28,%esp
  alarm(0); //clear the alarm so as not to disturb running of function
     c0b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     c12:	e8 31 f8 ff ff       	call   448 <alarm>
  int new,i;
  //wakeup all threads waiting for this one
  for(i=0;i<MAX_THREAD;i++)
     c17:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     c1e:	eb 51                	jmp    c71 <uthread_exit+0x6c>
  {
   if(currentThread->waitedOn[i]==1)
     c20:	a1 e0 5e 00 00       	mov    0x5ee0,%eax
     c25:	8b 55 f4             	mov    -0xc(%ebp),%edx
     c28:	83 c2 08             	add    $0x8,%edx
     c2b:	8b 04 90             	mov    (%eax,%edx,4),%eax
     c2e:	83 f8 01             	cmp    $0x1,%eax
     c31:	75 3a                	jne    c6d <uthread_exit+0x68>
   {
     tTable.table[i].waitingFor=-1; //release thread i from waiting
     c33:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c36:	69 c0 24 01 00 00    	imul   $0x124,%eax,%eax
     c3c:	05 00 17 00 00       	add    $0x1700,%eax
     c41:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)
     currentThread->waitedOn[i]=0; //not necessary maybe   
     c47:	a1 e0 5e 00 00       	mov    0x5ee0,%eax
     c4c:	8b 55 f4             	mov    -0xc(%ebp),%edx
     c4f:	83 c2 08             	add    $0x8,%edx
     c52:	c7 04 90 00 00 00 00 	movl   $0x0,(%eax,%edx,4)
     tTable.table[i].state=T_RUNNABLE;
     c59:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c5c:	69 c0 24 01 00 00    	imul   $0x124,%eax,%eax
     c62:	05 f0 15 00 00       	add    $0x15f0,%eax
     c67:	c7 00 03 00 00 00    	movl   $0x3,(%eax)
uthread_exit()
{
  alarm(0); //clear the alarm so as not to disturb running of function
  int new,i;
  //wakeup all threads waiting for this one
  for(i=0;i<MAX_THREAD;i++)
     c6d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     c71:	83 7d f4 3f          	cmpl   $0x3f,-0xc(%ebp)
     c75:	7e a9                	jle    c20 <uthread_exit+0x1b>
     tTable.table[i].state=T_RUNNABLE;
   }
  }
  
  //pick next thread
  new=getNextThread(currentThread->tid);
     c77:	a1 e0 5e 00 00       	mov    0x5ee0,%eax
     c7c:	8b 00                	mov    (%eax),%eax
     c7e:	89 04 24             	mov    %eax,(%esp)
     c81:	e8 e3 fc ff ff       	call   969 <getNextThread>
     c86:	89 45 f0             	mov    %eax,-0x10(%ebp)
  
  //release all resources and zero all fields
  if(currentThread->tid!=0)
     c89:	a1 e0 5e 00 00       	mov    0x5ee0,%eax
     c8e:	8b 00                	mov    (%eax),%eax
     c90:	85 c0                	test   %eax,%eax
     c92:	74 10                	je     ca4 <uthread_exit+0x9f>
    free(currentThread->stack);
     c94:	a1 e0 5e 00 00       	mov    0x5ee0,%eax
     c99:	8b 40 0c             	mov    0xc(%eax),%eax
     c9c:	89 04 24             	mov    %eax,(%esp)
     c9f:	e8 38 fa ff ff       	call   6dc <free>
  currentThread->tid=-1;
     ca4:	a1 e0 5e 00 00       	mov    0x5ee0,%eax
     ca9:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)
  currentThread->esp=-1;
     caf:	a1 e0 5e 00 00       	mov    0x5ee0,%eax
     cb4:	c7 40 04 ff ff ff ff 	movl   $0xffffffff,0x4(%eax)
  currentThread->ebp=-1;
     cbb:	a1 e0 5e 00 00       	mov    0x5ee0,%eax
     cc0:	c7 40 08 ff ff ff ff 	movl   $0xffffffff,0x8(%eax)
  currentThread->func=0;
     cc7:	a1 e0 5e 00 00       	mov    0x5ee0,%eax
     ccc:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)
  currentThread->arguments=0;
     cd3:	a1 e0 5e 00 00       	mov    0x5ee0,%eax
     cd8:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
  currentThread->stack=0;
     cdf:	a1 e0 5e 00 00       	mov    0x5ee0,%eax
     ce4:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
  currentThread->firstTime=1;
     ceb:	a1 e0 5e 00 00       	mov    0x5ee0,%eax
     cf0:	c7 40 14 01 00 00 00 	movl   $0x1,0x14(%eax)
  currentThread->state=T_FREE;
     cf7:	a1 e0 5e 00 00       	mov    0x5ee0,%eax
     cfc:	c7 40 10 00 00 00 00 	movl   $0x0,0x10(%eax)
  
  //load new thread
  if(new>=0)
     d03:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     d07:	78 7a                	js     d83 <uthread_exit+0x17e>
  {
    currentThread=&tTable.table[new];
     d09:	8b 45 f0             	mov    -0x10(%ebp),%eax
     d0c:	69 c0 24 01 00 00    	imul   $0x124,%eax,%eax
     d12:	05 e0 15 00 00       	add    $0x15e0,%eax
     d17:	a3 e0 5e 00 00       	mov    %eax,0x5ee0
    currentThread->state=T_RUNNING;
     d1c:	a1 e0 5e 00 00       	mov    0x5ee0,%eax
     d21:	c7 40 10 02 00 00 00 	movl   $0x2,0x10(%eax)
    LOAD_ESP(currentThread->esp);
     d28:	a1 e0 5e 00 00       	mov    0x5ee0,%eax
     d2d:	8b 40 04             	mov    0x4(%eax),%eax
     d30:	89 c4                	mov    %eax,%esp
    LOAD_EBP(currentThread->ebp);
     d32:	a1 e0 5e 00 00       	mov    0x5ee0,%eax
     d37:	8b 40 08             	mov    0x8(%eax),%eax
     d3a:	89 c5                	mov    %eax,%ebp
    
    //set new alarm clock
    if(alarm(THREAD_QUANTA)<0)
     d3c:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
     d43:	e8 00 f7 ff ff       	call   448 <alarm>
     d48:	85 c0                	test   %eax,%eax
     d4a:	79 19                	jns    d65 <uthread_exit+0x160>
    {
      printf(1,"Cant activate alarm system call");
     d4c:	c7 44 24 04 e0 10 00 	movl   $0x10e0,0x4(%esp)
     d53:	00 
     d54:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     d5b:	e8 c7 f7 ff ff       	call   527 <printf>
      exit();
     d60:	e8 13 f6 ff ff       	call   378 <exit>
    }
    
    if(currentThread->firstTime==1)
     d65:	a1 e0 5e 00 00       	mov    0x5ee0,%eax
     d6a:	8b 40 14             	mov    0x14(%eax),%eax
     d6d:	83 f8 01             	cmp    $0x1,%eax
     d70:	75 10                	jne    d82 <uthread_exit+0x17d>
    {
      currentThread->firstTime=0;
     d72:	a1 e0 5e 00 00       	mov    0x5ee0,%eax
     d77:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
      POP_AND_RET();
     d7e:	5d                   	pop    %ebp
     d7f:	c3                   	ret    
     d80:	eb 01                	jmp    d83 <uthread_exit+0x17e>
    }
    else
    {  
    POP_ALL_REGISTERS();
     d82:	61                   	popa   
    }
  }
}
     d83:	c9                   	leave  
     d84:	c3                   	ret    

00000d85 <uthread_join>:
/*
 * causes this thread to wait for the finish of another thread
 */
int
uthread_join(int tid)
{
     d85:	55                   	push   %ebp
     d86:	89 e5                	mov    %esp,%ebp
     d88:	83 ec 18             	sub    $0x18,%esp
  if((&tTable.table[tid])->state==T_FREE)
     d8b:	8b 45 08             	mov    0x8(%ebp),%eax
     d8e:	69 c0 24 01 00 00    	imul   $0x124,%eax,%eax
     d94:	05 e0 15 00 00       	add    $0x15e0,%eax
     d99:	8b 40 10             	mov    0x10(%eax),%eax
     d9c:	85 c0                	test   %eax,%eax
     d9e:	75 07                	jne    da7 <uthread_join+0x22>
    return -1;
     da0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     da5:	eb 56                	jmp    dfd <uthread_join+0x78>
  else
  {
    alarm(0); //clear the alarm so as not to disturb running of function
     da7:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     dae:	e8 95 f6 ff ff       	call   448 <alarm>
    currentThread->waitingFor=tid;
     db3:	a1 e0 5e 00 00       	mov    0x5ee0,%eax
     db8:	8b 55 08             	mov    0x8(%ebp),%edx
     dbb:	89 90 20 01 00 00    	mov    %edx,0x120(%eax)
    tTable.table[tid].waitedOn[currentThread->tid]=1;
     dc1:	a1 e0 5e 00 00       	mov    0x5ee0,%eax
     dc6:	8b 08                	mov    (%eax),%ecx
     dc8:	8b 55 08             	mov    0x8(%ebp),%edx
     dcb:	89 d0                	mov    %edx,%eax
     dcd:	c1 e0 03             	shl    $0x3,%eax
     dd0:	01 d0                	add    %edx,%eax
     dd2:	c1 e0 03             	shl    $0x3,%eax
     dd5:	01 d0                	add    %edx,%eax
     dd7:	01 c8                	add    %ecx,%eax
     dd9:	83 c0 08             	add    $0x8,%eax
     ddc:	c7 04 85 e0 15 00 00 	movl   $0x1,0x15e0(,%eax,4)
     de3:	01 00 00 00 
    currentThread->state=T_SLEEPING;
     de7:	a1 e0 5e 00 00       	mov    0x5ee0,%eax
     dec:	c7 40 10 04 00 00 00 	movl   $0x4,0x10(%eax)
    uthread_yield();
     df3:	e8 07 00 00 00       	call   dff <uthread_yield>
    return 1;
     df8:	b8 01 00 00 00       	mov    $0x1,%eax
  }
}
     dfd:	c9                   	leave  
     dfe:	c3                   	ret    

00000dff <uthread_yield>:
/*
 * yields the run-time of the current thread to another thread
 */
void 
uthread_yield()
{
     dff:	55                   	push   %ebp
     e00:	89 e5                	mov    %esp,%ebp
     e02:	83 ec 28             	sub    $0x28,%esp
  alarm(0); //clear the alarm so as not to disturb running of function
     e05:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     e0c:	e8 37 f6 ff ff       	call   448 <alarm>
  int new=getNextThread(currentThread->tid);
     e11:	a1 e0 5e 00 00       	mov    0x5ee0,%eax
     e16:	8b 00                	mov    (%eax),%eax
     e18:	89 04 24             	mov    %eax,(%esp)
     e1b:	e8 49 fb ff ff       	call   969 <getNextThread>
     e20:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(new==-1)
     e23:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     e27:	75 2d                	jne    e56 <uthread_yield+0x57>
  {
    if(alarm(THREAD_QUANTA)<0)
     e29:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
     e30:	e8 13 f6 ff ff       	call   448 <alarm>
     e35:	85 c0                	test   %eax,%eax
     e37:	0f 89 c1 00 00 00    	jns    efe <uthread_yield+0xff>
    {
      printf(1,"Cant activate alarm system call\n");
     e3d:	c7 44 24 04 00 11 00 	movl   $0x1100,0x4(%esp)
     e44:	00 
     e45:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     e4c:	e8 d6 f6 ff ff       	call   527 <printf>
      exit();
     e51:	e8 22 f5 ff ff       	call   378 <exit>
    } 
  }
  else
  {
    //store all leaving thread registers and pointers
    PUSH_ALL_REGISTERS();
     e56:	60                   	pusha  
    STORE_ESP(currentThread->esp);
     e57:	a1 e0 5e 00 00       	mov    0x5ee0,%eax
     e5c:	89 e2                	mov    %esp,%edx
     e5e:	89 50 04             	mov    %edx,0x4(%eax)
    STORE_EBP(currentThread->ebp);
     e61:	a1 e0 5e 00 00       	mov    0x5ee0,%eax
     e66:	89 ea                	mov    %ebp,%edx
     e68:	89 50 08             	mov    %edx,0x8(%eax)
    
    //change thread state
    if(currentThread->state==T_RUNNING) //might be sleeping from join operation
     e6b:	a1 e0 5e 00 00       	mov    0x5ee0,%eax
     e70:	8b 40 10             	mov    0x10(%eax),%eax
     e73:	83 f8 02             	cmp    $0x2,%eax
     e76:	75 0c                	jne    e84 <uthread_yield+0x85>
      currentThread->state=T_RUNNABLE;
     e78:	a1 e0 5e 00 00       	mov    0x5ee0,%eax
     e7d:	c7 40 10 03 00 00 00 	movl   $0x3,0x10(%eax)

    currentThread=&tTable.table[new];
     e84:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e87:	69 c0 24 01 00 00    	imul   $0x124,%eax,%eax
     e8d:	05 e0 15 00 00       	add    $0x15e0,%eax
     e92:	a3 e0 5e 00 00       	mov    %eax,0x5ee0

    //load all new thread registers and pointers
    LOAD_ESP(currentThread->esp);
     e97:	a1 e0 5e 00 00       	mov    0x5ee0,%eax
     e9c:	8b 40 04             	mov    0x4(%eax),%eax
     e9f:	89 c4                	mov    %eax,%esp
    LOAD_EBP(currentThread->ebp);
     ea1:	a1 e0 5e 00 00       	mov    0x5ee0,%eax
     ea6:	8b 40 08             	mov    0x8(%eax),%eax
     ea9:	89 c5                	mov    %eax,%ebp
    //set new alram clock
    if(alarm(THREAD_QUANTA)<0)
     eab:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
     eb2:	e8 91 f5 ff ff       	call   448 <alarm>
     eb7:	85 c0                	test   %eax,%eax
     eb9:	79 19                	jns    ed4 <uthread_yield+0xd5>
    {
      printf(1,"Cant activate alarm system call\n");
     ebb:	c7 44 24 04 00 11 00 	movl   $0x1100,0x4(%esp)
     ec2:	00 
     ec3:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     eca:	e8 58 f6 ff ff       	call   527 <printf>
      exit();
     ecf:	e8 a4 f4 ff ff       	call   378 <exit>
    }  
    currentThread->state=T_RUNNING;
     ed4:	a1 e0 5e 00 00       	mov    0x5ee0,%eax
     ed9:	c7 40 10 02 00 00 00 	movl   $0x2,0x10(%eax)
    
    if(currentThread->firstTime==1)
     ee0:	a1 e0 5e 00 00       	mov    0x5ee0,%eax
     ee5:	8b 40 14             	mov    0x14(%eax),%eax
     ee8:	83 f8 01             	cmp    $0x1,%eax
     eeb:	75 10                	jne    efd <uthread_yield+0xfe>
    {
    currentThread->firstTime=0;
     eed:	a1 e0 5e 00 00       	mov    0x5ee0,%eax
     ef2:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
    POP_AND_RET();
     ef9:	5d                   	pop    %ebp
     efa:	c3                   	ret    
     efb:	eb 01                	jmp    efe <uthread_yield+0xff>
    }
    else
    {
      POP_ALL_REGISTERS();
     efd:	61                   	popa   
    }
  }
}
     efe:	c9                   	leave  
     eff:	c3                   	ret    

00000f00 <uthread_self>:

int
uthread_self(void)
{
     f00:	55                   	push   %ebp
     f01:	89 e5                	mov    %esp,%ebp
  return currentThread->tid;
     f03:	a1 e0 5e 00 00       	mov    0x5ee0,%eax
     f08:	8b 00                	mov    (%eax),%eax
     f0a:	5d                   	pop    %ebp
     f0b:	c3                   	ret    

00000f0c <xchg>:
#include "fs.h"
#include "uthread.h"

static inline uint
xchg(volatile uint *addr, uint newval)
{
     f0c:	55                   	push   %ebp
     f0d:	89 e5                	mov    %esp,%ebp
     f0f:	53                   	push   %ebx
     f10:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
               "+m" (*addr), "=a" (result) :
     f13:	8b 55 08             	mov    0x8(%ebp),%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
     f16:	8b 45 0c             	mov    0xc(%ebp),%eax
               "+m" (*addr), "=a" (result) :
     f19:	8b 4d 08             	mov    0x8(%ebp),%ecx
xchg(volatile uint *addr, uint newval)
{
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
     f1c:	89 c3                	mov    %eax,%ebx
     f1e:	89 d8                	mov    %ebx,%eax
     f20:	f0 87 02             	lock xchg %eax,(%edx)
     f23:	89 c3                	mov    %eax,%ebx
     f25:	89 5d f8             	mov    %ebx,-0x8(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
     f28:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
     f2b:	83 c4 10             	add    $0x10,%esp
     f2e:	5b                   	pop    %ebx
     f2f:	5d                   	pop    %ebp
     f30:	c3                   	ret    

00000f31 <binary_semaphore_init>:
semaphore->taken=0;
}*/

void
binary_semaphore_init(struct binary_semaphore* semaphore, int value)
{
     f31:	55                   	push   %ebp
     f32:	89 e5                	mov    %esp,%ebp
     f34:	83 ec 08             	sub    $0x8,%esp
  semaphore->init=0;
     f37:	8b 45 08             	mov    0x8(%ebp),%eax
     f3a:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
  
  if(value!=0)
     f41:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     f45:	74 0c                	je     f53 <binary_semaphore_init+0x22>
    semaphore->thread=-1;
     f47:	8b 45 08             	mov    0x8(%ebp),%eax
     f4a:	c7 40 04 ff ff ff ff 	movl   $0xffffffff,0x4(%eax)
     f51:	eb 0b                	jmp    f5e <binary_semaphore_init+0x2d>
  else 
    semaphore->thread = uthread_self();
     f53:	e8 a8 ff ff ff       	call   f00 <uthread_self>
     f58:	8b 55 08             	mov    0x8(%ebp),%edx
     f5b:	89 42 04             	mov    %eax,0x4(%edx)
  
  semaphore->locked = value;
     f5e:	8b 55 0c             	mov    0xc(%ebp),%edx
     f61:	8b 45 08             	mov    0x8(%ebp),%eax
     f64:	89 10                	mov    %edx,(%eax)
 // semaphore->taken=0;
  semaphore->init=1;
     f66:	8b 45 08             	mov    0x8(%ebp),%eax
     f69:	c7 40 08 01 00 00 00 	movl   $0x1,0x8(%eax)
  
}
     f70:	c9                   	leave  
     f71:	c3                   	ret    

00000f72 <binary_semaphore_down>:

void 
binary_semaphore_down(struct binary_semaphore* semaphore)
{
     f72:	55                   	push   %ebp
     f73:	89 e5                	mov    %esp,%ebp
     f75:	83 ec 28             	sub    $0x28,%esp
  //semaphore_acquire(semaphore);
  if(semaphore->init==0)
     f78:	8b 45 08             	mov    0x8(%ebp),%eax
     f7b:	8b 40 08             	mov    0x8(%eax),%eax
     f7e:	85 c0                	test   %eax,%eax
     f80:	75 20                	jne    fa2 <binary_semaphore_down+0x30>
  {
   printf(1,"(down)semaphore uninitialized yet (thread %d)\n",semaphore->thread);
     f82:	8b 45 08             	mov    0x8(%ebp),%eax
     f85:	8b 40 04             	mov    0x4(%eax),%eax
     f88:	89 44 24 08          	mov    %eax,0x8(%esp)
     f8c:	c7 44 24 04 24 11 00 	movl   $0x1124,0x4(%esp)
     f93:	00 
     f94:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     f9b:	e8 87 f5 ff ff       	call   527 <printf>
    return;
     fa0:	eb 3a                	jmp    fdc <binary_semaphore_down+0x6a>
  }
  
  
  int i= uthread_self();
     fa2:	e8 59 ff ff ff       	call   f00 <uthread_self>
     fa7:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(semaphore->thread!=i)
     faa:	8b 45 08             	mov    0x8(%ebp),%eax
     fad:	8b 40 04             	mov    0x4(%eax),%eax
     fb0:	3b 45 f4             	cmp    -0xc(%ebp),%eax
     fb3:	74 27                	je     fdc <binary_semaphore_down+0x6a>
  {
    while(xchg(&semaphore->locked, 0) == 0) //means the semaphore is taken allready
     fb5:	eb 05                	jmp    fbc <binary_semaphore_down+0x4a>
    {
      uthread_yield();
     fb7:	e8 43 fe ff ff       	call   dff <uthread_yield>
  
  
  int i= uthread_self();
  if(semaphore->thread!=i)
  {
    while(xchg(&semaphore->locked, 0) == 0) //means the semaphore is taken allready
     fbc:	8b 45 08             	mov    0x8(%ebp),%eax
     fbf:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     fc6:	00 
     fc7:	89 04 24             	mov    %eax,(%esp)
     fca:	e8 3d ff ff ff       	call   f0c <xchg>
     fcf:	85 c0                	test   %eax,%eax
     fd1:	74 e4                	je     fb7 <binary_semaphore_down+0x45>
    {
      uthread_yield();
    }
    semaphore->thread = i;
     fd3:	8b 45 08             	mov    0x8(%ebp),%eax
     fd6:	8b 55 f4             	mov    -0xc(%ebp),%edx
     fd9:	89 50 04             	mov    %edx,0x4(%eax)
  }
  //semaphore_release(semaphore);
}
     fdc:	c9                   	leave  
     fdd:	c3                   	ret    

00000fde <binary_semaphore_up>:

void 
binary_semaphore_up(struct binary_semaphore* semaphore)
{
     fde:	55                   	push   %ebp
     fdf:	89 e5                	mov    %esp,%ebp
     fe1:	83 ec 28             	sub    $0x28,%esp
  //semaphore_acquire(semaphore);
    if(semaphore->init==0)
     fe4:	8b 45 08             	mov    0x8(%ebp),%eax
     fe7:	8b 40 08             	mov    0x8(%eax),%eax
     fea:	85 c0                	test   %eax,%eax
     fec:	75 20                	jne    100e <binary_semaphore_up+0x30>
    {
    printf(1,"(up)semaphore uninitialized yet (thread %d)\n",semaphore->thread);
     fee:	8b 45 08             	mov    0x8(%ebp),%eax
     ff1:	8b 40 04             	mov    0x4(%eax),%eax
     ff4:	89 44 24 08          	mov    %eax,0x8(%esp)
     ff8:	c7 44 24 04 54 11 00 	movl   $0x1154,0x4(%esp)
     fff:	00 
    1000:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1007:	e8 1b f5 ff ff       	call   527 <printf>
    return;
    100c:	eb 2f                	jmp    103d <binary_semaphore_up+0x5f>
    }
  
  int i= uthread_self();
    100e:	e8 ed fe ff ff       	call   f00 <uthread_self>
    1013:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if( semaphore->locked == 0 && semaphore->thread == i)
    1016:	8b 45 08             	mov    0x8(%ebp),%eax
    1019:	8b 00                	mov    (%eax),%eax
    101b:	85 c0                	test   %eax,%eax
    101d:	75 1e                	jne    103d <binary_semaphore_up+0x5f>
    101f:	8b 45 08             	mov    0x8(%ebp),%eax
    1022:	8b 40 04             	mov    0x4(%eax),%eax
    1025:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1028:	75 13                	jne    103d <binary_semaphore_up+0x5f>
  {
      semaphore->thread = -1;
    102a:	8b 45 08             	mov    0x8(%ebp),%eax
    102d:	c7 40 04 ff ff ff ff 	movl   $0xffffffff,0x4(%eax)
      semaphore->locked = 1;
    1034:	8b 45 08             	mov    0x8(%ebp),%eax
    1037:	c7 00 01 00 00 00    	movl   $0x1,(%eax)

  }
//semaphore_release(semaphore);
    103d:	c9                   	leave  
    103e:	c3                   	ret    
