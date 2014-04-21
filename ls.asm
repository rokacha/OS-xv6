
_ls:     file format elf32-i386


Disassembly of section .text:

00000000 <fmtname>:
#include "user.h"
#include "fs.h"

char*
fmtname(char *path)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	53                   	push   %ebx
   4:	83 ec 24             	sub    $0x24,%esp
  static char buf[DIRSIZ+1];
  char *p;
  
  // Find first character after last slash.
  for(p=path+strlen(path); p >= path && *p != '/'; p--)
   7:	8b 45 08             	mov    0x8(%ebp),%eax
   a:	89 04 24             	mov    %eax,(%esp)
   d:	e8 dc 03 00 00       	call   3ee <strlen>
  12:	03 45 08             	add    0x8(%ebp),%eax
  15:	89 45 f4             	mov    %eax,-0xc(%ebp)
  18:	eb 04                	jmp    1e <fmtname+0x1e>
  1a:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
  1e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  21:	3b 45 08             	cmp    0x8(%ebp),%eax
  24:	72 0a                	jb     30 <fmtname+0x30>
  26:	8b 45 f4             	mov    -0xc(%ebp),%eax
  29:	0f b6 00             	movzbl (%eax),%eax
  2c:	3c 2f                	cmp    $0x2f,%al
  2e:	75 ea                	jne    1a <fmtname+0x1a>
    ;
  p++;
  30:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  
  // Return blank-padded name.
  if(strlen(p) >= DIRSIZ)
  34:	8b 45 f4             	mov    -0xc(%ebp),%eax
  37:	89 04 24             	mov    %eax,(%esp)
  3a:	e8 af 03 00 00       	call   3ee <strlen>
  3f:	83 f8 0d             	cmp    $0xd,%eax
  42:	76 05                	jbe    49 <fmtname+0x49>
    return p;
  44:	8b 45 f4             	mov    -0xc(%ebp),%eax
  47:	eb 5f                	jmp    a8 <fmtname+0xa8>
  memmove(buf, p, strlen(p));
  49:	8b 45 f4             	mov    -0xc(%ebp),%eax
  4c:	89 04 24             	mov    %eax,(%esp)
  4f:	e8 9a 03 00 00       	call   3ee <strlen>
  54:	89 44 24 08          	mov    %eax,0x8(%esp)
  58:	8b 45 f4             	mov    -0xc(%ebp),%eax
  5b:	89 44 24 04          	mov    %eax,0x4(%esp)
  5f:	c7 04 24 00 14 00 00 	movl   $0x1400,(%esp)
  66:	e8 07 05 00 00       	call   572 <memmove>
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  6b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  6e:	89 04 24             	mov    %eax,(%esp)
  71:	e8 78 03 00 00       	call   3ee <strlen>
  76:	ba 0e 00 00 00       	mov    $0xe,%edx
  7b:	89 d3                	mov    %edx,%ebx
  7d:	29 c3                	sub    %eax,%ebx
  7f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  82:	89 04 24             	mov    %eax,(%esp)
  85:	e8 64 03 00 00       	call   3ee <strlen>
  8a:	05 00 14 00 00       	add    $0x1400,%eax
  8f:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  93:	c7 44 24 04 20 00 00 	movl   $0x20,0x4(%esp)
  9a:	00 
  9b:	89 04 24             	mov    %eax,(%esp)
  9e:	e8 70 03 00 00       	call   413 <memset>
  return buf;
  a3:	b8 00 14 00 00       	mov    $0x1400,%eax
}
  a8:	83 c4 24             	add    $0x24,%esp
  ab:	5b                   	pop    %ebx
  ac:	5d                   	pop    %ebp
  ad:	c3                   	ret    

000000ae <ls>:

void
ls(char *path)
{
  ae:	55                   	push   %ebp
  af:	89 e5                	mov    %esp,%ebp
  b1:	57                   	push   %edi
  b2:	56                   	push   %esi
  b3:	53                   	push   %ebx
  b4:	81 ec 5c 02 00 00    	sub    $0x25c,%esp
  char buf[512], *p;
  int fd;
  struct dirent de;
  struct stat st;
  
  if((fd = open(path, 0)) < 0){
  ba:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  c1:	00 
  c2:	8b 45 08             	mov    0x8(%ebp),%eax
  c5:	89 04 24             	mov    %eax,(%esp)
  c8:	e8 2b 05 00 00       	call   5f8 <open>
  cd:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  d0:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  d4:	79 20                	jns    f6 <ls+0x48>
    printf(2, "ls: cannot open %s\n", path);
  d6:	8b 45 08             	mov    0x8(%ebp),%eax
  d9:	89 44 24 08          	mov    %eax,0x8(%esp)
  dd:	c7 44 24 04 90 0f 00 	movl   $0xf90,0x4(%esp)
  e4:	00 
  e5:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  ec:	e8 76 06 00 00       	call   767 <printf>
    return;
  f1:	e9 01 02 00 00       	jmp    2f7 <ls+0x249>
  }
  
  if(fstat(fd, &st) < 0){
  f6:	8d 85 bc fd ff ff    	lea    -0x244(%ebp),%eax
  fc:	89 44 24 04          	mov    %eax,0x4(%esp)
 100:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 103:	89 04 24             	mov    %eax,(%esp)
 106:	e8 05 05 00 00       	call   610 <fstat>
 10b:	85 c0                	test   %eax,%eax
 10d:	79 2b                	jns    13a <ls+0x8c>
    printf(2, "ls: cannot stat %s\n", path);
 10f:	8b 45 08             	mov    0x8(%ebp),%eax
 112:	89 44 24 08          	mov    %eax,0x8(%esp)
 116:	c7 44 24 04 a4 0f 00 	movl   $0xfa4,0x4(%esp)
 11d:	00 
 11e:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
 125:	e8 3d 06 00 00       	call   767 <printf>
    close(fd);
 12a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 12d:	89 04 24             	mov    %eax,(%esp)
 130:	e8 ab 04 00 00       	call   5e0 <close>
    return;
 135:	e9 bd 01 00 00       	jmp    2f7 <ls+0x249>
  }
  
  switch(st.type){
 13a:	0f b7 85 bc fd ff ff 	movzwl -0x244(%ebp),%eax
 141:	98                   	cwtl   
 142:	83 f8 01             	cmp    $0x1,%eax
 145:	74 53                	je     19a <ls+0xec>
 147:	83 f8 02             	cmp    $0x2,%eax
 14a:	0f 85 9c 01 00 00    	jne    2ec <ls+0x23e>
  case T_FILE:
    printf(1, "%s %d %d %d\n", fmtname(path), st.type, st.ino, st.size);
 150:	8b bd cc fd ff ff    	mov    -0x234(%ebp),%edi
 156:	8b b5 c4 fd ff ff    	mov    -0x23c(%ebp),%esi
 15c:	0f b7 85 bc fd ff ff 	movzwl -0x244(%ebp),%eax
 163:	0f bf d8             	movswl %ax,%ebx
 166:	8b 45 08             	mov    0x8(%ebp),%eax
 169:	89 04 24             	mov    %eax,(%esp)
 16c:	e8 8f fe ff ff       	call   0 <fmtname>
 171:	89 7c 24 14          	mov    %edi,0x14(%esp)
 175:	89 74 24 10          	mov    %esi,0x10(%esp)
 179:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
 17d:	89 44 24 08          	mov    %eax,0x8(%esp)
 181:	c7 44 24 04 b8 0f 00 	movl   $0xfb8,0x4(%esp)
 188:	00 
 189:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 190:	e8 d2 05 00 00       	call   767 <printf>
    break;
 195:	e9 52 01 00 00       	jmp    2ec <ls+0x23e>
  
  case T_DIR:
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
 19a:	8b 45 08             	mov    0x8(%ebp),%eax
 19d:	89 04 24             	mov    %eax,(%esp)
 1a0:	e8 49 02 00 00       	call   3ee <strlen>
 1a5:	83 c0 10             	add    $0x10,%eax
 1a8:	3d 00 02 00 00       	cmp    $0x200,%eax
 1ad:	76 19                	jbe    1c8 <ls+0x11a>
      printf(1, "ls: path too long\n");
 1af:	c7 44 24 04 c5 0f 00 	movl   $0xfc5,0x4(%esp)
 1b6:	00 
 1b7:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 1be:	e8 a4 05 00 00       	call   767 <printf>
      break;
 1c3:	e9 24 01 00 00       	jmp    2ec <ls+0x23e>
    }
    strcpy(buf, path);
 1c8:	8b 45 08             	mov    0x8(%ebp),%eax
 1cb:	89 44 24 04          	mov    %eax,0x4(%esp)
 1cf:	8d 85 e0 fd ff ff    	lea    -0x220(%ebp),%eax
 1d5:	89 04 24             	mov    %eax,(%esp)
 1d8:	e8 9c 01 00 00       	call   379 <strcpy>
    p = buf+strlen(buf);
 1dd:	8d 85 e0 fd ff ff    	lea    -0x220(%ebp),%eax
 1e3:	89 04 24             	mov    %eax,(%esp)
 1e6:	e8 03 02 00 00       	call   3ee <strlen>
 1eb:	8d 95 e0 fd ff ff    	lea    -0x220(%ebp),%edx
 1f1:	01 d0                	add    %edx,%eax
 1f3:	89 45 e0             	mov    %eax,-0x20(%ebp)
    *p++ = '/';
 1f6:	8b 45 e0             	mov    -0x20(%ebp),%eax
 1f9:	c6 00 2f             	movb   $0x2f,(%eax)
 1fc:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 200:	e9 c0 00 00 00       	jmp    2c5 <ls+0x217>
      if(de.inum == 0)
 205:	0f b7 85 d0 fd ff ff 	movzwl -0x230(%ebp),%eax
 20c:	66 85 c0             	test   %ax,%ax
 20f:	0f 84 af 00 00 00    	je     2c4 <ls+0x216>
        continue;
      memmove(p, de.name, DIRSIZ);
 215:	c7 44 24 08 0e 00 00 	movl   $0xe,0x8(%esp)
 21c:	00 
 21d:	8d 85 d0 fd ff ff    	lea    -0x230(%ebp),%eax
 223:	83 c0 02             	add    $0x2,%eax
 226:	89 44 24 04          	mov    %eax,0x4(%esp)
 22a:	8b 45 e0             	mov    -0x20(%ebp),%eax
 22d:	89 04 24             	mov    %eax,(%esp)
 230:	e8 3d 03 00 00       	call   572 <memmove>
      p[DIRSIZ] = 0;
 235:	8b 45 e0             	mov    -0x20(%ebp),%eax
 238:	83 c0 0e             	add    $0xe,%eax
 23b:	c6 00 00             	movb   $0x0,(%eax)
      if(stat(buf, &st) < 0){
 23e:	8d 85 bc fd ff ff    	lea    -0x244(%ebp),%eax
 244:	89 44 24 04          	mov    %eax,0x4(%esp)
 248:	8d 85 e0 fd ff ff    	lea    -0x220(%ebp),%eax
 24e:	89 04 24             	mov    %eax,(%esp)
 251:	e8 83 02 00 00       	call   4d9 <stat>
 256:	85 c0                	test   %eax,%eax
 258:	79 20                	jns    27a <ls+0x1cc>
        printf(1, "ls: cannot stat %s\n", buf);
 25a:	8d 85 e0 fd ff ff    	lea    -0x220(%ebp),%eax
 260:	89 44 24 08          	mov    %eax,0x8(%esp)
 264:	c7 44 24 04 a4 0f 00 	movl   $0xfa4,0x4(%esp)
 26b:	00 
 26c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 273:	e8 ef 04 00 00       	call   767 <printf>
        continue;
 278:	eb 4b                	jmp    2c5 <ls+0x217>
      }
      printf(1, "%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
 27a:	8b bd cc fd ff ff    	mov    -0x234(%ebp),%edi
 280:	8b b5 c4 fd ff ff    	mov    -0x23c(%ebp),%esi
 286:	0f b7 85 bc fd ff ff 	movzwl -0x244(%ebp),%eax
 28d:	0f bf d8             	movswl %ax,%ebx
 290:	8d 85 e0 fd ff ff    	lea    -0x220(%ebp),%eax
 296:	89 04 24             	mov    %eax,(%esp)
 299:	e8 62 fd ff ff       	call   0 <fmtname>
 29e:	89 7c 24 14          	mov    %edi,0x14(%esp)
 2a2:	89 74 24 10          	mov    %esi,0x10(%esp)
 2a6:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
 2aa:	89 44 24 08          	mov    %eax,0x8(%esp)
 2ae:	c7 44 24 04 b8 0f 00 	movl   $0xfb8,0x4(%esp)
 2b5:	00 
 2b6:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 2bd:	e8 a5 04 00 00       	call   767 <printf>
 2c2:	eb 01                	jmp    2c5 <ls+0x217>
    strcpy(buf, path);
    p = buf+strlen(buf);
    *p++ = '/';
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
      if(de.inum == 0)
        continue;
 2c4:	90                   	nop
      break;
    }
    strcpy(buf, path);
    p = buf+strlen(buf);
    *p++ = '/';
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 2c5:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 2cc:	00 
 2cd:	8d 85 d0 fd ff ff    	lea    -0x230(%ebp),%eax
 2d3:	89 44 24 04          	mov    %eax,0x4(%esp)
 2d7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 2da:	89 04 24             	mov    %eax,(%esp)
 2dd:	e8 ee 02 00 00       	call   5d0 <read>
 2e2:	83 f8 10             	cmp    $0x10,%eax
 2e5:	0f 84 1a ff ff ff    	je     205 <ls+0x157>
        printf(1, "ls: cannot stat %s\n", buf);
        continue;
      }
      printf(1, "%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
    }
    break;
 2eb:	90                   	nop
  }
  close(fd);
 2ec:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 2ef:	89 04 24             	mov    %eax,(%esp)
 2f2:	e8 e9 02 00 00       	call   5e0 <close>
}
 2f7:	81 c4 5c 02 00 00    	add    $0x25c,%esp
 2fd:	5b                   	pop    %ebx
 2fe:	5e                   	pop    %esi
 2ff:	5f                   	pop    %edi
 300:	5d                   	pop    %ebp
 301:	c3                   	ret    

00000302 <main>:

int
main(int argc, char *argv[])
{
 302:	55                   	push   %ebp
 303:	89 e5                	mov    %esp,%ebp
 305:	83 e4 f0             	and    $0xfffffff0,%esp
 308:	83 ec 20             	sub    $0x20,%esp
  int i;

  if(argc < 2){
 30b:	83 7d 08 01          	cmpl   $0x1,0x8(%ebp)
 30f:	7f 11                	jg     322 <main+0x20>
    ls(".");
 311:	c7 04 24 d8 0f 00 00 	movl   $0xfd8,(%esp)
 318:	e8 91 fd ff ff       	call   ae <ls>
    exit();
 31d:	e8 96 02 00 00       	call   5b8 <exit>
  }
  for(i=1; i<argc; i++)
 322:	c7 44 24 1c 01 00 00 	movl   $0x1,0x1c(%esp)
 329:	00 
 32a:	eb 19                	jmp    345 <main+0x43>
    ls(argv[i]);
 32c:	8b 44 24 1c          	mov    0x1c(%esp),%eax
 330:	c1 e0 02             	shl    $0x2,%eax
 333:	03 45 0c             	add    0xc(%ebp),%eax
 336:	8b 00                	mov    (%eax),%eax
 338:	89 04 24             	mov    %eax,(%esp)
 33b:	e8 6e fd ff ff       	call   ae <ls>

  if(argc < 2){
    ls(".");
    exit();
  }
  for(i=1; i<argc; i++)
 340:	83 44 24 1c 01       	addl   $0x1,0x1c(%esp)
 345:	8b 44 24 1c          	mov    0x1c(%esp),%eax
 349:	3b 45 08             	cmp    0x8(%ebp),%eax
 34c:	7c de                	jl     32c <main+0x2a>
    ls(argv[i]);
  exit();
 34e:	e8 65 02 00 00       	call   5b8 <exit>
 353:	90                   	nop

00000354 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 354:	55                   	push   %ebp
 355:	89 e5                	mov    %esp,%ebp
 357:	57                   	push   %edi
 358:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
 359:	8b 4d 08             	mov    0x8(%ebp),%ecx
 35c:	8b 55 10             	mov    0x10(%ebp),%edx
 35f:	8b 45 0c             	mov    0xc(%ebp),%eax
 362:	89 cb                	mov    %ecx,%ebx
 364:	89 df                	mov    %ebx,%edi
 366:	89 d1                	mov    %edx,%ecx
 368:	fc                   	cld    
 369:	f3 aa                	rep stos %al,%es:(%edi)
 36b:	89 ca                	mov    %ecx,%edx
 36d:	89 fb                	mov    %edi,%ebx
 36f:	89 5d 08             	mov    %ebx,0x8(%ebp)
 372:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 375:	5b                   	pop    %ebx
 376:	5f                   	pop    %edi
 377:	5d                   	pop    %ebp
 378:	c3                   	ret    

00000379 <strcpy>:
#include "x86.h"


char*
strcpy(char *s, char *t)
{
 379:	55                   	push   %ebp
 37a:	89 e5                	mov    %esp,%ebp
 37c:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
 37f:	8b 45 08             	mov    0x8(%ebp),%eax
 382:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 385:	90                   	nop
 386:	8b 45 0c             	mov    0xc(%ebp),%eax
 389:	0f b6 10             	movzbl (%eax),%edx
 38c:	8b 45 08             	mov    0x8(%ebp),%eax
 38f:	88 10                	mov    %dl,(%eax)
 391:	8b 45 08             	mov    0x8(%ebp),%eax
 394:	0f b6 00             	movzbl (%eax),%eax
 397:	84 c0                	test   %al,%al
 399:	0f 95 c0             	setne  %al
 39c:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 3a0:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
 3a4:	84 c0                	test   %al,%al
 3a6:	75 de                	jne    386 <strcpy+0xd>
    ;
  return os;
 3a8:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 3ab:	c9                   	leave  
 3ac:	c3                   	ret    

000003ad <strcmp>:

int
strcmp(const char *p, const char *q)
{
 3ad:	55                   	push   %ebp
 3ae:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 3b0:	eb 08                	jmp    3ba <strcmp+0xd>
    p++, q++;
 3b2:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 3b6:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 3ba:	8b 45 08             	mov    0x8(%ebp),%eax
 3bd:	0f b6 00             	movzbl (%eax),%eax
 3c0:	84 c0                	test   %al,%al
 3c2:	74 10                	je     3d4 <strcmp+0x27>
 3c4:	8b 45 08             	mov    0x8(%ebp),%eax
 3c7:	0f b6 10             	movzbl (%eax),%edx
 3ca:	8b 45 0c             	mov    0xc(%ebp),%eax
 3cd:	0f b6 00             	movzbl (%eax),%eax
 3d0:	38 c2                	cmp    %al,%dl
 3d2:	74 de                	je     3b2 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 3d4:	8b 45 08             	mov    0x8(%ebp),%eax
 3d7:	0f b6 00             	movzbl (%eax),%eax
 3da:	0f b6 d0             	movzbl %al,%edx
 3dd:	8b 45 0c             	mov    0xc(%ebp),%eax
 3e0:	0f b6 00             	movzbl (%eax),%eax
 3e3:	0f b6 c0             	movzbl %al,%eax
 3e6:	89 d1                	mov    %edx,%ecx
 3e8:	29 c1                	sub    %eax,%ecx
 3ea:	89 c8                	mov    %ecx,%eax
}
 3ec:	5d                   	pop    %ebp
 3ed:	c3                   	ret    

000003ee <strlen>:

uint
strlen(char *s)
{
 3ee:	55                   	push   %ebp
 3ef:	89 e5                	mov    %esp,%ebp
 3f1:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 3f4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 3fb:	eb 04                	jmp    401 <strlen+0x13>
 3fd:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 401:	8b 45 fc             	mov    -0x4(%ebp),%eax
 404:	03 45 08             	add    0x8(%ebp),%eax
 407:	0f b6 00             	movzbl (%eax),%eax
 40a:	84 c0                	test   %al,%al
 40c:	75 ef                	jne    3fd <strlen+0xf>
    ;
  return n;
 40e:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 411:	c9                   	leave  
 412:	c3                   	ret    

00000413 <memset>:

void*
memset(void *dst, int c, uint n)
{
 413:	55                   	push   %ebp
 414:	89 e5                	mov    %esp,%ebp
 416:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
 419:	8b 45 10             	mov    0x10(%ebp),%eax
 41c:	89 44 24 08          	mov    %eax,0x8(%esp)
 420:	8b 45 0c             	mov    0xc(%ebp),%eax
 423:	89 44 24 04          	mov    %eax,0x4(%esp)
 427:	8b 45 08             	mov    0x8(%ebp),%eax
 42a:	89 04 24             	mov    %eax,(%esp)
 42d:	e8 22 ff ff ff       	call   354 <stosb>
  return dst;
 432:	8b 45 08             	mov    0x8(%ebp),%eax
}
 435:	c9                   	leave  
 436:	c3                   	ret    

00000437 <strchr>:

char*
strchr(const char *s, char c)
{
 437:	55                   	push   %ebp
 438:	89 e5                	mov    %esp,%ebp
 43a:	83 ec 04             	sub    $0x4,%esp
 43d:	8b 45 0c             	mov    0xc(%ebp),%eax
 440:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 443:	eb 14                	jmp    459 <strchr+0x22>
    if(*s == c)
 445:	8b 45 08             	mov    0x8(%ebp),%eax
 448:	0f b6 00             	movzbl (%eax),%eax
 44b:	3a 45 fc             	cmp    -0x4(%ebp),%al
 44e:	75 05                	jne    455 <strchr+0x1e>
      return (char*)s;
 450:	8b 45 08             	mov    0x8(%ebp),%eax
 453:	eb 13                	jmp    468 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 455:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 459:	8b 45 08             	mov    0x8(%ebp),%eax
 45c:	0f b6 00             	movzbl (%eax),%eax
 45f:	84 c0                	test   %al,%al
 461:	75 e2                	jne    445 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 463:	b8 00 00 00 00       	mov    $0x0,%eax
}
 468:	c9                   	leave  
 469:	c3                   	ret    

0000046a <gets>:

char*
gets(char *buf, int max)
{
 46a:	55                   	push   %ebp
 46b:	89 e5                	mov    %esp,%ebp
 46d:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 470:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 477:	eb 44                	jmp    4bd <gets+0x53>
    cc = read(0, &c, 1);
 479:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 480:	00 
 481:	8d 45 ef             	lea    -0x11(%ebp),%eax
 484:	89 44 24 04          	mov    %eax,0x4(%esp)
 488:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 48f:	e8 3c 01 00 00       	call   5d0 <read>
 494:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 497:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 49b:	7e 2d                	jle    4ca <gets+0x60>
      break;
    buf[i++] = c;
 49d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 4a0:	03 45 08             	add    0x8(%ebp),%eax
 4a3:	0f b6 55 ef          	movzbl -0x11(%ebp),%edx
 4a7:	88 10                	mov    %dl,(%eax)
 4a9:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    if(c == '\n' || c == '\r')
 4ad:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 4b1:	3c 0a                	cmp    $0xa,%al
 4b3:	74 16                	je     4cb <gets+0x61>
 4b5:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 4b9:	3c 0d                	cmp    $0xd,%al
 4bb:	74 0e                	je     4cb <gets+0x61>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 4bd:	8b 45 f4             	mov    -0xc(%ebp),%eax
 4c0:	83 c0 01             	add    $0x1,%eax
 4c3:	3b 45 0c             	cmp    0xc(%ebp),%eax
 4c6:	7c b1                	jl     479 <gets+0xf>
 4c8:	eb 01                	jmp    4cb <gets+0x61>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
 4ca:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 4cb:	8b 45 f4             	mov    -0xc(%ebp),%eax
 4ce:	03 45 08             	add    0x8(%ebp),%eax
 4d1:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 4d4:	8b 45 08             	mov    0x8(%ebp),%eax
}
 4d7:	c9                   	leave  
 4d8:	c3                   	ret    

000004d9 <stat>:

int
stat(char *n, struct stat *st)
{
 4d9:	55                   	push   %ebp
 4da:	89 e5                	mov    %esp,%ebp
 4dc:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 4df:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 4e6:	00 
 4e7:	8b 45 08             	mov    0x8(%ebp),%eax
 4ea:	89 04 24             	mov    %eax,(%esp)
 4ed:	e8 06 01 00 00       	call   5f8 <open>
 4f2:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 4f5:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 4f9:	79 07                	jns    502 <stat+0x29>
    return -1;
 4fb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 500:	eb 23                	jmp    525 <stat+0x4c>
  r = fstat(fd, st);
 502:	8b 45 0c             	mov    0xc(%ebp),%eax
 505:	89 44 24 04          	mov    %eax,0x4(%esp)
 509:	8b 45 f4             	mov    -0xc(%ebp),%eax
 50c:	89 04 24             	mov    %eax,(%esp)
 50f:	e8 fc 00 00 00       	call   610 <fstat>
 514:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 517:	8b 45 f4             	mov    -0xc(%ebp),%eax
 51a:	89 04 24             	mov    %eax,(%esp)
 51d:	e8 be 00 00 00       	call   5e0 <close>
  return r;
 522:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 525:	c9                   	leave  
 526:	c3                   	ret    

00000527 <atoi>:

int
atoi(const char *s)
{
 527:	55                   	push   %ebp
 528:	89 e5                	mov    %esp,%ebp
 52a:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 52d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 534:	eb 23                	jmp    559 <atoi+0x32>
    n = n*10 + *s++ - '0';
 536:	8b 55 fc             	mov    -0x4(%ebp),%edx
 539:	89 d0                	mov    %edx,%eax
 53b:	c1 e0 02             	shl    $0x2,%eax
 53e:	01 d0                	add    %edx,%eax
 540:	01 c0                	add    %eax,%eax
 542:	89 c2                	mov    %eax,%edx
 544:	8b 45 08             	mov    0x8(%ebp),%eax
 547:	0f b6 00             	movzbl (%eax),%eax
 54a:	0f be c0             	movsbl %al,%eax
 54d:	01 d0                	add    %edx,%eax
 54f:	83 e8 30             	sub    $0x30,%eax
 552:	89 45 fc             	mov    %eax,-0x4(%ebp)
 555:	83 45 08 01          	addl   $0x1,0x8(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 559:	8b 45 08             	mov    0x8(%ebp),%eax
 55c:	0f b6 00             	movzbl (%eax),%eax
 55f:	3c 2f                	cmp    $0x2f,%al
 561:	7e 0a                	jle    56d <atoi+0x46>
 563:	8b 45 08             	mov    0x8(%ebp),%eax
 566:	0f b6 00             	movzbl (%eax),%eax
 569:	3c 39                	cmp    $0x39,%al
 56b:	7e c9                	jle    536 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 56d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 570:	c9                   	leave  
 571:	c3                   	ret    

00000572 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 572:	55                   	push   %ebp
 573:	89 e5                	mov    %esp,%ebp
 575:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 578:	8b 45 08             	mov    0x8(%ebp),%eax
 57b:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 57e:	8b 45 0c             	mov    0xc(%ebp),%eax
 581:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 584:	eb 13                	jmp    599 <memmove+0x27>
    *dst++ = *src++;
 586:	8b 45 f8             	mov    -0x8(%ebp),%eax
 589:	0f b6 10             	movzbl (%eax),%edx
 58c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 58f:	88 10                	mov    %dl,(%eax)
 591:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 595:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 599:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
 59d:	0f 9f c0             	setg   %al
 5a0:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
 5a4:	84 c0                	test   %al,%al
 5a6:	75 de                	jne    586 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 5a8:	8b 45 08             	mov    0x8(%ebp),%eax
}
 5ab:	c9                   	leave  
 5ac:	c3                   	ret    
 5ad:	90                   	nop
 5ae:	90                   	nop
 5af:	90                   	nop

000005b0 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 5b0:	b8 01 00 00 00       	mov    $0x1,%eax
 5b5:	cd 40                	int    $0x40
 5b7:	c3                   	ret    

000005b8 <exit>:
SYSCALL(exit)
 5b8:	b8 02 00 00 00       	mov    $0x2,%eax
 5bd:	cd 40                	int    $0x40
 5bf:	c3                   	ret    

000005c0 <wait>:
SYSCALL(wait)
 5c0:	b8 03 00 00 00       	mov    $0x3,%eax
 5c5:	cd 40                	int    $0x40
 5c7:	c3                   	ret    

000005c8 <pipe>:
SYSCALL(pipe)
 5c8:	b8 04 00 00 00       	mov    $0x4,%eax
 5cd:	cd 40                	int    $0x40
 5cf:	c3                   	ret    

000005d0 <read>:
SYSCALL(read)
 5d0:	b8 05 00 00 00       	mov    $0x5,%eax
 5d5:	cd 40                	int    $0x40
 5d7:	c3                   	ret    

000005d8 <write>:
SYSCALL(write)
 5d8:	b8 10 00 00 00       	mov    $0x10,%eax
 5dd:	cd 40                	int    $0x40
 5df:	c3                   	ret    

000005e0 <close>:
SYSCALL(close)
 5e0:	b8 15 00 00 00       	mov    $0x15,%eax
 5e5:	cd 40                	int    $0x40
 5e7:	c3                   	ret    

000005e8 <kill>:
SYSCALL(kill)
 5e8:	b8 06 00 00 00       	mov    $0x6,%eax
 5ed:	cd 40                	int    $0x40
 5ef:	c3                   	ret    

000005f0 <exec>:
SYSCALL(exec)
 5f0:	b8 07 00 00 00       	mov    $0x7,%eax
 5f5:	cd 40                	int    $0x40
 5f7:	c3                   	ret    

000005f8 <open>:
SYSCALL(open)
 5f8:	b8 0f 00 00 00       	mov    $0xf,%eax
 5fd:	cd 40                	int    $0x40
 5ff:	c3                   	ret    

00000600 <mknod>:
SYSCALL(mknod)
 600:	b8 11 00 00 00       	mov    $0x11,%eax
 605:	cd 40                	int    $0x40
 607:	c3                   	ret    

00000608 <unlink>:
SYSCALL(unlink)
 608:	b8 12 00 00 00       	mov    $0x12,%eax
 60d:	cd 40                	int    $0x40
 60f:	c3                   	ret    

00000610 <fstat>:
SYSCALL(fstat)
 610:	b8 08 00 00 00       	mov    $0x8,%eax
 615:	cd 40                	int    $0x40
 617:	c3                   	ret    

00000618 <link>:
SYSCALL(link)
 618:	b8 13 00 00 00       	mov    $0x13,%eax
 61d:	cd 40                	int    $0x40
 61f:	c3                   	ret    

00000620 <mkdir>:
SYSCALL(mkdir)
 620:	b8 14 00 00 00       	mov    $0x14,%eax
 625:	cd 40                	int    $0x40
 627:	c3                   	ret    

00000628 <chdir>:
SYSCALL(chdir)
 628:	b8 09 00 00 00       	mov    $0x9,%eax
 62d:	cd 40                	int    $0x40
 62f:	c3                   	ret    

00000630 <dup>:
SYSCALL(dup)
 630:	b8 0a 00 00 00       	mov    $0xa,%eax
 635:	cd 40                	int    $0x40
 637:	c3                   	ret    

00000638 <getpid>:
SYSCALL(getpid)
 638:	b8 0b 00 00 00       	mov    $0xb,%eax
 63d:	cd 40                	int    $0x40
 63f:	c3                   	ret    

00000640 <sbrk>:
SYSCALL(sbrk)
 640:	b8 0c 00 00 00       	mov    $0xc,%eax
 645:	cd 40                	int    $0x40
 647:	c3                   	ret    

00000648 <sleep>:
SYSCALL(sleep)
 648:	b8 0d 00 00 00       	mov    $0xd,%eax
 64d:	cd 40                	int    $0x40
 64f:	c3                   	ret    

00000650 <uptime>:
SYSCALL(uptime)
 650:	b8 0e 00 00 00       	mov    $0xe,%eax
 655:	cd 40                	int    $0x40
 657:	c3                   	ret    

00000658 <add_path>:
SYSCALL(add_path)
 658:	b8 16 00 00 00       	mov    $0x16,%eax
 65d:	cd 40                	int    $0x40
 65f:	c3                   	ret    

00000660 <wait2>:
SYSCALL(wait2)
 660:	b8 17 00 00 00       	mov    $0x17,%eax
 665:	cd 40                	int    $0x40
 667:	c3                   	ret    

00000668 <getquanta>:
SYSCALL(getquanta)
 668:	b8 18 00 00 00       	mov    $0x18,%eax
 66d:	cd 40                	int    $0x40
 66f:	c3                   	ret    

00000670 <getqueue>:
SYSCALL(getqueue)
 670:	b8 19 00 00 00       	mov    $0x19,%eax
 675:	cd 40                	int    $0x40
 677:	c3                   	ret    

00000678 <signal>:
SYSCALL(signal)
 678:	b8 1a 00 00 00       	mov    $0x1a,%eax
 67d:	cd 40                	int    $0x40
 67f:	c3                   	ret    

00000680 <sigsend>:
SYSCALL(sigsend)
 680:	b8 1b 00 00 00       	mov    $0x1b,%eax
 685:	cd 40                	int    $0x40
 687:	c3                   	ret    

00000688 <alarm>:
SYSCALL(alarm)
 688:	b8 1c 00 00 00       	mov    $0x1c,%eax
 68d:	cd 40                	int    $0x40
 68f:	c3                   	ret    

00000690 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 690:	55                   	push   %ebp
 691:	89 e5                	mov    %esp,%ebp
 693:	83 ec 28             	sub    $0x28,%esp
 696:	8b 45 0c             	mov    0xc(%ebp),%eax
 699:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 69c:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 6a3:	00 
 6a4:	8d 45 f4             	lea    -0xc(%ebp),%eax
 6a7:	89 44 24 04          	mov    %eax,0x4(%esp)
 6ab:	8b 45 08             	mov    0x8(%ebp),%eax
 6ae:	89 04 24             	mov    %eax,(%esp)
 6b1:	e8 22 ff ff ff       	call   5d8 <write>
}
 6b6:	c9                   	leave  
 6b7:	c3                   	ret    

000006b8 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 6b8:	55                   	push   %ebp
 6b9:	89 e5                	mov    %esp,%ebp
 6bb:	83 ec 48             	sub    $0x48,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 6be:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 6c5:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 6c9:	74 17                	je     6e2 <printint+0x2a>
 6cb:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 6cf:	79 11                	jns    6e2 <printint+0x2a>
    neg = 1;
 6d1:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 6d8:	8b 45 0c             	mov    0xc(%ebp),%eax
 6db:	f7 d8                	neg    %eax
 6dd:	89 45 ec             	mov    %eax,-0x14(%ebp)
 6e0:	eb 06                	jmp    6e8 <printint+0x30>
  } else {
    x = xx;
 6e2:	8b 45 0c             	mov    0xc(%ebp),%eax
 6e5:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 6e8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 6ef:	8b 4d 10             	mov    0x10(%ebp),%ecx
 6f2:	8b 45 ec             	mov    -0x14(%ebp),%eax
 6f5:	ba 00 00 00 00       	mov    $0x0,%edx
 6fa:	f7 f1                	div    %ecx
 6fc:	89 d0                	mov    %edx,%eax
 6fe:	0f b6 90 e8 13 00 00 	movzbl 0x13e8(%eax),%edx
 705:	8d 45 dc             	lea    -0x24(%ebp),%eax
 708:	03 45 f4             	add    -0xc(%ebp),%eax
 70b:	88 10                	mov    %dl,(%eax)
 70d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  }while((x /= base) != 0);
 711:	8b 55 10             	mov    0x10(%ebp),%edx
 714:	89 55 d4             	mov    %edx,-0x2c(%ebp)
 717:	8b 45 ec             	mov    -0x14(%ebp),%eax
 71a:	ba 00 00 00 00       	mov    $0x0,%edx
 71f:	f7 75 d4             	divl   -0x2c(%ebp)
 722:	89 45 ec             	mov    %eax,-0x14(%ebp)
 725:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 729:	75 c4                	jne    6ef <printint+0x37>
  if(neg)
 72b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 72f:	74 2a                	je     75b <printint+0xa3>
    buf[i++] = '-';
 731:	8d 45 dc             	lea    -0x24(%ebp),%eax
 734:	03 45 f4             	add    -0xc(%ebp),%eax
 737:	c6 00 2d             	movb   $0x2d,(%eax)
 73a:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)

  while(--i >= 0)
 73e:	eb 1b                	jmp    75b <printint+0xa3>
    putc(fd, buf[i]);
 740:	8d 45 dc             	lea    -0x24(%ebp),%eax
 743:	03 45 f4             	add    -0xc(%ebp),%eax
 746:	0f b6 00             	movzbl (%eax),%eax
 749:	0f be c0             	movsbl %al,%eax
 74c:	89 44 24 04          	mov    %eax,0x4(%esp)
 750:	8b 45 08             	mov    0x8(%ebp),%eax
 753:	89 04 24             	mov    %eax,(%esp)
 756:	e8 35 ff ff ff       	call   690 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 75b:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 75f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 763:	79 db                	jns    740 <printint+0x88>
    putc(fd, buf[i]);
}
 765:	c9                   	leave  
 766:	c3                   	ret    

00000767 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 767:	55                   	push   %ebp
 768:	89 e5                	mov    %esp,%ebp
 76a:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 76d:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 774:	8d 45 0c             	lea    0xc(%ebp),%eax
 777:	83 c0 04             	add    $0x4,%eax
 77a:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 77d:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 784:	e9 7d 01 00 00       	jmp    906 <printf+0x19f>
    c = fmt[i] & 0xff;
 789:	8b 55 0c             	mov    0xc(%ebp),%edx
 78c:	8b 45 f0             	mov    -0x10(%ebp),%eax
 78f:	01 d0                	add    %edx,%eax
 791:	0f b6 00             	movzbl (%eax),%eax
 794:	0f be c0             	movsbl %al,%eax
 797:	25 ff 00 00 00       	and    $0xff,%eax
 79c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 79f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 7a3:	75 2c                	jne    7d1 <printf+0x6a>
      if(c == '%'){
 7a5:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 7a9:	75 0c                	jne    7b7 <printf+0x50>
        state = '%';
 7ab:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 7b2:	e9 4b 01 00 00       	jmp    902 <printf+0x19b>
      } else {
        putc(fd, c);
 7b7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 7ba:	0f be c0             	movsbl %al,%eax
 7bd:	89 44 24 04          	mov    %eax,0x4(%esp)
 7c1:	8b 45 08             	mov    0x8(%ebp),%eax
 7c4:	89 04 24             	mov    %eax,(%esp)
 7c7:	e8 c4 fe ff ff       	call   690 <putc>
 7cc:	e9 31 01 00 00       	jmp    902 <printf+0x19b>
      }
    } else if(state == '%'){
 7d1:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 7d5:	0f 85 27 01 00 00    	jne    902 <printf+0x19b>
      if(c == 'd'){
 7db:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 7df:	75 2d                	jne    80e <printf+0xa7>
        printint(fd, *ap, 10, 1);
 7e1:	8b 45 e8             	mov    -0x18(%ebp),%eax
 7e4:	8b 00                	mov    (%eax),%eax
 7e6:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
 7ed:	00 
 7ee:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
 7f5:	00 
 7f6:	89 44 24 04          	mov    %eax,0x4(%esp)
 7fa:	8b 45 08             	mov    0x8(%ebp),%eax
 7fd:	89 04 24             	mov    %eax,(%esp)
 800:	e8 b3 fe ff ff       	call   6b8 <printint>
        ap++;
 805:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 809:	e9 ed 00 00 00       	jmp    8fb <printf+0x194>
      } else if(c == 'x' || c == 'p'){
 80e:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 812:	74 06                	je     81a <printf+0xb3>
 814:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 818:	75 2d                	jne    847 <printf+0xe0>
        printint(fd, *ap, 16, 0);
 81a:	8b 45 e8             	mov    -0x18(%ebp),%eax
 81d:	8b 00                	mov    (%eax),%eax
 81f:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 826:	00 
 827:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 82e:	00 
 82f:	89 44 24 04          	mov    %eax,0x4(%esp)
 833:	8b 45 08             	mov    0x8(%ebp),%eax
 836:	89 04 24             	mov    %eax,(%esp)
 839:	e8 7a fe ff ff       	call   6b8 <printint>
        ap++;
 83e:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 842:	e9 b4 00 00 00       	jmp    8fb <printf+0x194>
      } else if(c == 's'){
 847:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 84b:	75 46                	jne    893 <printf+0x12c>
        s = (char*)*ap;
 84d:	8b 45 e8             	mov    -0x18(%ebp),%eax
 850:	8b 00                	mov    (%eax),%eax
 852:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 855:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 859:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 85d:	75 27                	jne    886 <printf+0x11f>
          s = "(null)";
 85f:	c7 45 f4 da 0f 00 00 	movl   $0xfda,-0xc(%ebp)
        while(*s != 0){
 866:	eb 1e                	jmp    886 <printf+0x11f>
          putc(fd, *s);
 868:	8b 45 f4             	mov    -0xc(%ebp),%eax
 86b:	0f b6 00             	movzbl (%eax),%eax
 86e:	0f be c0             	movsbl %al,%eax
 871:	89 44 24 04          	mov    %eax,0x4(%esp)
 875:	8b 45 08             	mov    0x8(%ebp),%eax
 878:	89 04 24             	mov    %eax,(%esp)
 87b:	e8 10 fe ff ff       	call   690 <putc>
          s++;
 880:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 884:	eb 01                	jmp    887 <printf+0x120>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 886:	90                   	nop
 887:	8b 45 f4             	mov    -0xc(%ebp),%eax
 88a:	0f b6 00             	movzbl (%eax),%eax
 88d:	84 c0                	test   %al,%al
 88f:	75 d7                	jne    868 <printf+0x101>
 891:	eb 68                	jmp    8fb <printf+0x194>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 893:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 897:	75 1d                	jne    8b6 <printf+0x14f>
        putc(fd, *ap);
 899:	8b 45 e8             	mov    -0x18(%ebp),%eax
 89c:	8b 00                	mov    (%eax),%eax
 89e:	0f be c0             	movsbl %al,%eax
 8a1:	89 44 24 04          	mov    %eax,0x4(%esp)
 8a5:	8b 45 08             	mov    0x8(%ebp),%eax
 8a8:	89 04 24             	mov    %eax,(%esp)
 8ab:	e8 e0 fd ff ff       	call   690 <putc>
        ap++;
 8b0:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 8b4:	eb 45                	jmp    8fb <printf+0x194>
      } else if(c == '%'){
 8b6:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 8ba:	75 17                	jne    8d3 <printf+0x16c>
        putc(fd, c);
 8bc:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 8bf:	0f be c0             	movsbl %al,%eax
 8c2:	89 44 24 04          	mov    %eax,0x4(%esp)
 8c6:	8b 45 08             	mov    0x8(%ebp),%eax
 8c9:	89 04 24             	mov    %eax,(%esp)
 8cc:	e8 bf fd ff ff       	call   690 <putc>
 8d1:	eb 28                	jmp    8fb <printf+0x194>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 8d3:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
 8da:	00 
 8db:	8b 45 08             	mov    0x8(%ebp),%eax
 8de:	89 04 24             	mov    %eax,(%esp)
 8e1:	e8 aa fd ff ff       	call   690 <putc>
        putc(fd, c);
 8e6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 8e9:	0f be c0             	movsbl %al,%eax
 8ec:	89 44 24 04          	mov    %eax,0x4(%esp)
 8f0:	8b 45 08             	mov    0x8(%ebp),%eax
 8f3:	89 04 24             	mov    %eax,(%esp)
 8f6:	e8 95 fd ff ff       	call   690 <putc>
      }
      state = 0;
 8fb:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 902:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 906:	8b 55 0c             	mov    0xc(%ebp),%edx
 909:	8b 45 f0             	mov    -0x10(%ebp),%eax
 90c:	01 d0                	add    %edx,%eax
 90e:	0f b6 00             	movzbl (%eax),%eax
 911:	84 c0                	test   %al,%al
 913:	0f 85 70 fe ff ff    	jne    789 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 919:	c9                   	leave  
 91a:	c3                   	ret    
 91b:	90                   	nop

0000091c <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 91c:	55                   	push   %ebp
 91d:	89 e5                	mov    %esp,%ebp
 91f:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 922:	8b 45 08             	mov    0x8(%ebp),%eax
 925:	83 e8 08             	sub    $0x8,%eax
 928:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 92b:	a1 18 14 00 00       	mov    0x1418,%eax
 930:	89 45 fc             	mov    %eax,-0x4(%ebp)
 933:	eb 24                	jmp    959 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 935:	8b 45 fc             	mov    -0x4(%ebp),%eax
 938:	8b 00                	mov    (%eax),%eax
 93a:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 93d:	77 12                	ja     951 <free+0x35>
 93f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 942:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 945:	77 24                	ja     96b <free+0x4f>
 947:	8b 45 fc             	mov    -0x4(%ebp),%eax
 94a:	8b 00                	mov    (%eax),%eax
 94c:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 94f:	77 1a                	ja     96b <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 951:	8b 45 fc             	mov    -0x4(%ebp),%eax
 954:	8b 00                	mov    (%eax),%eax
 956:	89 45 fc             	mov    %eax,-0x4(%ebp)
 959:	8b 45 f8             	mov    -0x8(%ebp),%eax
 95c:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 95f:	76 d4                	jbe    935 <free+0x19>
 961:	8b 45 fc             	mov    -0x4(%ebp),%eax
 964:	8b 00                	mov    (%eax),%eax
 966:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 969:	76 ca                	jbe    935 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 96b:	8b 45 f8             	mov    -0x8(%ebp),%eax
 96e:	8b 40 04             	mov    0x4(%eax),%eax
 971:	c1 e0 03             	shl    $0x3,%eax
 974:	89 c2                	mov    %eax,%edx
 976:	03 55 f8             	add    -0x8(%ebp),%edx
 979:	8b 45 fc             	mov    -0x4(%ebp),%eax
 97c:	8b 00                	mov    (%eax),%eax
 97e:	39 c2                	cmp    %eax,%edx
 980:	75 24                	jne    9a6 <free+0x8a>
    bp->s.size += p->s.ptr->s.size;
 982:	8b 45 f8             	mov    -0x8(%ebp),%eax
 985:	8b 50 04             	mov    0x4(%eax),%edx
 988:	8b 45 fc             	mov    -0x4(%ebp),%eax
 98b:	8b 00                	mov    (%eax),%eax
 98d:	8b 40 04             	mov    0x4(%eax),%eax
 990:	01 c2                	add    %eax,%edx
 992:	8b 45 f8             	mov    -0x8(%ebp),%eax
 995:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 998:	8b 45 fc             	mov    -0x4(%ebp),%eax
 99b:	8b 00                	mov    (%eax),%eax
 99d:	8b 10                	mov    (%eax),%edx
 99f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 9a2:	89 10                	mov    %edx,(%eax)
 9a4:	eb 0a                	jmp    9b0 <free+0x94>
  } else
    bp->s.ptr = p->s.ptr;
 9a6:	8b 45 fc             	mov    -0x4(%ebp),%eax
 9a9:	8b 10                	mov    (%eax),%edx
 9ab:	8b 45 f8             	mov    -0x8(%ebp),%eax
 9ae:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 9b0:	8b 45 fc             	mov    -0x4(%ebp),%eax
 9b3:	8b 40 04             	mov    0x4(%eax),%eax
 9b6:	c1 e0 03             	shl    $0x3,%eax
 9b9:	03 45 fc             	add    -0x4(%ebp),%eax
 9bc:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 9bf:	75 20                	jne    9e1 <free+0xc5>
    p->s.size += bp->s.size;
 9c1:	8b 45 fc             	mov    -0x4(%ebp),%eax
 9c4:	8b 50 04             	mov    0x4(%eax),%edx
 9c7:	8b 45 f8             	mov    -0x8(%ebp),%eax
 9ca:	8b 40 04             	mov    0x4(%eax),%eax
 9cd:	01 c2                	add    %eax,%edx
 9cf:	8b 45 fc             	mov    -0x4(%ebp),%eax
 9d2:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 9d5:	8b 45 f8             	mov    -0x8(%ebp),%eax
 9d8:	8b 10                	mov    (%eax),%edx
 9da:	8b 45 fc             	mov    -0x4(%ebp),%eax
 9dd:	89 10                	mov    %edx,(%eax)
 9df:	eb 08                	jmp    9e9 <free+0xcd>
  } else
    p->s.ptr = bp;
 9e1:	8b 45 fc             	mov    -0x4(%ebp),%eax
 9e4:	8b 55 f8             	mov    -0x8(%ebp),%edx
 9e7:	89 10                	mov    %edx,(%eax)
  freep = p;
 9e9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 9ec:	a3 18 14 00 00       	mov    %eax,0x1418
}
 9f1:	c9                   	leave  
 9f2:	c3                   	ret    

000009f3 <morecore>:

static Header*
morecore(uint nu)
{
 9f3:	55                   	push   %ebp
 9f4:	89 e5                	mov    %esp,%ebp
 9f6:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 9f9:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 a00:	77 07                	ja     a09 <morecore+0x16>
    nu = 4096;
 a02:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 a09:	8b 45 08             	mov    0x8(%ebp),%eax
 a0c:	c1 e0 03             	shl    $0x3,%eax
 a0f:	89 04 24             	mov    %eax,(%esp)
 a12:	e8 29 fc ff ff       	call   640 <sbrk>
 a17:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 a1a:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 a1e:	75 07                	jne    a27 <morecore+0x34>
    return 0;
 a20:	b8 00 00 00 00       	mov    $0x0,%eax
 a25:	eb 22                	jmp    a49 <morecore+0x56>
  hp = (Header*)p;
 a27:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a2a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 a2d:	8b 45 f0             	mov    -0x10(%ebp),%eax
 a30:	8b 55 08             	mov    0x8(%ebp),%edx
 a33:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 a36:	8b 45 f0             	mov    -0x10(%ebp),%eax
 a39:	83 c0 08             	add    $0x8,%eax
 a3c:	89 04 24             	mov    %eax,(%esp)
 a3f:	e8 d8 fe ff ff       	call   91c <free>
  return freep;
 a44:	a1 18 14 00 00       	mov    0x1418,%eax
}
 a49:	c9                   	leave  
 a4a:	c3                   	ret    

00000a4b <malloc>:

void*
malloc(uint nbytes)
{
 a4b:	55                   	push   %ebp
 a4c:	89 e5                	mov    %esp,%ebp
 a4e:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a51:	8b 45 08             	mov    0x8(%ebp),%eax
 a54:	83 c0 07             	add    $0x7,%eax
 a57:	c1 e8 03             	shr    $0x3,%eax
 a5a:	83 c0 01             	add    $0x1,%eax
 a5d:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 a60:	a1 18 14 00 00       	mov    0x1418,%eax
 a65:	89 45 f0             	mov    %eax,-0x10(%ebp)
 a68:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 a6c:	75 23                	jne    a91 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 a6e:	c7 45 f0 10 14 00 00 	movl   $0x1410,-0x10(%ebp)
 a75:	8b 45 f0             	mov    -0x10(%ebp),%eax
 a78:	a3 18 14 00 00       	mov    %eax,0x1418
 a7d:	a1 18 14 00 00       	mov    0x1418,%eax
 a82:	a3 10 14 00 00       	mov    %eax,0x1410
    base.s.size = 0;
 a87:	c7 05 14 14 00 00 00 	movl   $0x0,0x1414
 a8e:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a91:	8b 45 f0             	mov    -0x10(%ebp),%eax
 a94:	8b 00                	mov    (%eax),%eax
 a96:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 a99:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a9c:	8b 40 04             	mov    0x4(%eax),%eax
 a9f:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 aa2:	72 4d                	jb     af1 <malloc+0xa6>
      if(p->s.size == nunits)
 aa4:	8b 45 f4             	mov    -0xc(%ebp),%eax
 aa7:	8b 40 04             	mov    0x4(%eax),%eax
 aaa:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 aad:	75 0c                	jne    abb <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 aaf:	8b 45 f4             	mov    -0xc(%ebp),%eax
 ab2:	8b 10                	mov    (%eax),%edx
 ab4:	8b 45 f0             	mov    -0x10(%ebp),%eax
 ab7:	89 10                	mov    %edx,(%eax)
 ab9:	eb 26                	jmp    ae1 <malloc+0x96>
      else {
        p->s.size -= nunits;
 abb:	8b 45 f4             	mov    -0xc(%ebp),%eax
 abe:	8b 40 04             	mov    0x4(%eax),%eax
 ac1:	89 c2                	mov    %eax,%edx
 ac3:	2b 55 ec             	sub    -0x14(%ebp),%edx
 ac6:	8b 45 f4             	mov    -0xc(%ebp),%eax
 ac9:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 acc:	8b 45 f4             	mov    -0xc(%ebp),%eax
 acf:	8b 40 04             	mov    0x4(%eax),%eax
 ad2:	c1 e0 03             	shl    $0x3,%eax
 ad5:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 ad8:	8b 45 f4             	mov    -0xc(%ebp),%eax
 adb:	8b 55 ec             	mov    -0x14(%ebp),%edx
 ade:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 ae1:	8b 45 f0             	mov    -0x10(%ebp),%eax
 ae4:	a3 18 14 00 00       	mov    %eax,0x1418
      return (void*)(p + 1);
 ae9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 aec:	83 c0 08             	add    $0x8,%eax
 aef:	eb 38                	jmp    b29 <malloc+0xde>
    }
    if(p == freep)
 af1:	a1 18 14 00 00       	mov    0x1418,%eax
 af6:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 af9:	75 1b                	jne    b16 <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
 afb:	8b 45 ec             	mov    -0x14(%ebp),%eax
 afe:	89 04 24             	mov    %eax,(%esp)
 b01:	e8 ed fe ff ff       	call   9f3 <morecore>
 b06:	89 45 f4             	mov    %eax,-0xc(%ebp)
 b09:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 b0d:	75 07                	jne    b16 <malloc+0xcb>
        return 0;
 b0f:	b8 00 00 00 00       	mov    $0x0,%eax
 b14:	eb 13                	jmp    b29 <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b16:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b19:	89 45 f0             	mov    %eax,-0x10(%ebp)
 b1c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b1f:	8b 00                	mov    (%eax),%eax
 b21:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 b24:	e9 70 ff ff ff       	jmp    a99 <malloc+0x4e>
}
 b29:	c9                   	leave  
 b2a:	c3                   	ret    
 b2b:	90                   	nop

00000b2c <getNextThread>:
} tTable;


int
getNextThread(int j)
{
 b2c:	55                   	push   %ebp
 b2d:	89 e5                	mov    %esp,%ebp
 b2f:	83 ec 10             	sub    $0x10,%esp
  int i=j+1;
 b32:	8b 45 08             	mov    0x8(%ebp),%eax
 b35:	83 c0 01             	add    $0x1,%eax
 b38:	89 45 fc             	mov    %eax,-0x4(%ebp)
  if(i==MAX_THREAD)
 b3b:	83 7d fc 40          	cmpl   $0x40,-0x4(%ebp)
 b3f:	75 07                	jne    b48 <getNextThread+0x1c>
    i=0;
 b41:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  uthread_p t=&tTable.table[i];
 b48:	8b 45 fc             	mov    -0x4(%ebp),%eax
 b4b:	69 c0 18 01 00 00    	imul   $0x118,%eax,%eax
 b51:	05 20 14 00 00       	add    $0x1420,%eax
 b56:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(i!=j)
 b59:	eb 3b                	jmp    b96 <getNextThread+0x6a>
  {
    if(t->state==T_RUNNABLE)
 b5b:	8b 45 f8             	mov    -0x8(%ebp),%eax
 b5e:	8b 40 10             	mov    0x10(%eax),%eax
 b61:	83 f8 03             	cmp    $0x3,%eax
 b64:	75 05                	jne    b6b <getNextThread+0x3f>
      return i;
 b66:	8b 45 fc             	mov    -0x4(%ebp),%eax
 b69:	eb 38                	jmp    ba3 <getNextThread+0x77>
    i++;
 b6b:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    if(i==MAX_THREAD)
 b6f:	83 7d fc 40          	cmpl   $0x40,-0x4(%ebp)
 b73:	75 1a                	jne    b8f <getNextThread+0x63>
    {
       i=0;
 b75:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
       t=&tTable.table[i];
 b7c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 b7f:	69 c0 18 01 00 00    	imul   $0x118,%eax,%eax
 b85:	05 20 14 00 00       	add    $0x1420,%eax
 b8a:	89 45 f8             	mov    %eax,-0x8(%ebp)
 b8d:	eb 07                	jmp    b96 <getNextThread+0x6a>
    }
    else
      t++;
 b8f:	81 45 f8 18 01 00 00 	addl   $0x118,-0x8(%ebp)
{
  int i=j+1;
  if(i==MAX_THREAD)
    i=0;
  uthread_p t=&tTable.table[i];
  while(i!=j)
 b96:	8b 45 fc             	mov    -0x4(%ebp),%eax
 b99:	3b 45 08             	cmp    0x8(%ebp),%eax
 b9c:	75 bd                	jne    b5b <getNextThread+0x2f>
    }
    else
      t++;
    
  }
  return -1;
 b9e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
 ba3:	c9                   	leave  
 ba4:	c3                   	ret    

00000ba5 <allocThread>:


static uthread_p
allocThread()
{
 ba5:	55                   	push   %ebp
 ba6:	89 e5                	mov    %esp,%ebp
 ba8:	83 ec 28             	sub    $0x28,%esp
  int i,j;
  uthread_p t;
  
  for (t=tTable.table,i=0 ; t <= &tTable.table[MAX_THREAD]; t++,i++)// <= should be < ??
 bab:	c7 45 ec 20 14 00 00 	movl   $0x1420,-0x14(%ebp)
 bb2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 bb9:	eb 15                	jmp    bd0 <allocThread+0x2b>
  {
    if(t->state==T_FREE)
 bbb:	8b 45 ec             	mov    -0x14(%ebp),%eax
 bbe:	8b 40 10             	mov    0x10(%eax),%eax
 bc1:	85 c0                	test   %eax,%eax
 bc3:	74 1e                	je     be3 <allocThread+0x3e>
allocThread()
{
  int i,j;
  uthread_p t;
  
  for (t=tTable.table,i=0 ; t <= &tTable.table[MAX_THREAD]; t++,i++)// <= should be < ??
 bc5:	81 45 ec 18 01 00 00 	addl   $0x118,-0x14(%ebp)
 bcc:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 bd0:	81 7d ec 20 5a 00 00 	cmpl   $0x5a20,-0x14(%ebp)
 bd7:	76 e2                	jbe    bbb <allocThread+0x16>
  {
    if(t->state==T_FREE)
      goto found;
  }
  return 0;
 bd9:	b8 00 00 00 00       	mov    $0x0,%eax
 bde:	e9 88 00 00 00       	jmp    c6b <allocThread+0xc6>
  uthread_p t;
  
  for (t=tTable.table,i=0 ; t <= &tTable.table[MAX_THREAD]; t++,i++)// <= should be < ??
  {
    if(t->state==T_FREE)
      goto found;
 be3:	90                   	nop
  }
  return 0;
  
  found:
  
  t->tid=i;
 be4:	8b 45 ec             	mov    -0x14(%ebp),%eax
 be7:	8b 55 f4             	mov    -0xc(%ebp),%edx
 bea:	89 10                	mov    %edx,(%eax)
  t->stack=(char*)malloc(STACK_SIZE);
 bec:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
 bf3:	e8 53 fe ff ff       	call   a4b <malloc>
 bf8:	8b 55 ec             	mov    -0x14(%ebp),%edx
 bfb:	89 42 0c             	mov    %eax,0xc(%edx)
  t->esp=(int)t->stack;
 bfe:	8b 45 ec             	mov    -0x14(%ebp),%eax
 c01:	8b 40 0c             	mov    0xc(%eax),%eax
 c04:	89 c2                	mov    %eax,%edx
 c06:	8b 45 ec             	mov    -0x14(%ebp),%eax
 c09:	89 50 04             	mov    %edx,0x4(%eax)
  t->ebp=(int)t->stack;
 c0c:	8b 45 ec             	mov    -0x14(%ebp),%eax
 c0f:	8b 40 0c             	mov    0xc(%eax),%eax
 c12:	89 c2                	mov    %eax,%edx
 c14:	8b 45 ec             	mov    -0x14(%ebp),%eax
 c17:	89 50 08             	mov    %edx,0x8(%eax)
  t->firstTime=0;
 c1a:	8b 45 ec             	mov    -0x14(%ebp),%eax
 c1d:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
  for(j=0;j<64;j++)
 c24:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 c2b:	eb 15                	jmp    c42 <allocThread+0x9d>
  {
    t->waiting[j]=-1;
 c2d:	8b 45 ec             	mov    -0x14(%ebp),%eax
 c30:	8b 55 f0             	mov    -0x10(%ebp),%edx
 c33:	83 c2 04             	add    $0x4,%edx
 c36:	c7 44 90 08 ff ff ff 	movl   $0xffffffff,0x8(%eax,%edx,4)
 c3d:	ff 
  t->tid=i;
  t->stack=(char*)malloc(STACK_SIZE);
  t->esp=(int)t->stack;
  t->ebp=(int)t->stack;
  t->firstTime=0;
  for(j=0;j<64;j++)
 c3e:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 c42:	83 7d f0 3f          	cmpl   $0x3f,-0x10(%ebp)
 c46:	7e e5                	jle    c2d <allocThread+0x88>
  {
    t->waiting[j]=-1;
  }
  asm("movl %1,%%esp;" "push %2;" "movl %%esp,%0;" //pushes the uthread_exit func as return address
    : "=r" (t->esp) 
    : "r" (t->ebp) , "r"(uthread_exit)
 c48:	8b 45 ec             	mov    -0x14(%ebp),%eax
 c4b:	8b 40 08             	mov    0x8(%eax),%eax
  t->firstTime=0;
  for(j=0;j<64;j++)
  {
    t->waiting[j]=-1;
  }
  asm("movl %1,%%esp;" "push %2;" "movl %%esp,%0;" //pushes the uthread_exit func as return address
 c4e:	ba 6a 0d 00 00       	mov    $0xd6a,%edx
 c53:	89 c4                	mov    %eax,%esp
 c55:	52                   	push   %edx
 c56:	89 e2                	mov    %esp,%edx
    : "=r" (t->esp) 
 c58:	8b 45 ec             	mov    -0x14(%ebp),%eax
  t->firstTime=0;
  for(j=0;j<64;j++)
  {
    t->waiting[j]=-1;
  }
  asm("movl %1,%%esp;" "push %2;" "movl %%esp,%0;" //pushes the uthread_exit func as return address
 c5b:	89 50 04             	mov    %edx,0x4(%eax)
    : "=r" (t->esp) 
    : "r" (t->ebp) , "r"(uthread_exit)
  );
  t->state=T_UNINIT;
 c5e:	8b 45 ec             	mov    -0x14(%ebp),%eax
 c61:	c7 40 10 01 00 00 00 	movl   $0x1,0x10(%eax)
  return t;
 c68:	8b 45 ec             	mov    -0x14(%ebp),%eax
}
 c6b:	c9                   	leave  
 c6c:	c3                   	ret    

00000c6d <uthread_init>:

void 
uthread_init()
{  
 c6d:	55                   	push   %ebp
 c6e:	89 e5                	mov    %esp,%ebp
 c70:	83 ec 28             	sub    $0x28,%esp
  tTable.length=0;
 c73:	c7 05 20 5a 00 00 00 	movl   $0x0,0x5a20
 c7a:	00 00 00 
  tTable.current=0;
 c7d:	c7 05 24 5a 00 00 00 	movl   $0x0,0x5a24
 c84:	00 00 00 
  uthread_p mainT = allocThread(); //needed to allocate the main thread !!!!!!
 c87:	e8 19 ff ff ff       	call   ba5 <allocThread>
 c8c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  asm("movl %%ebp,%0;" "movl %%esp,%1;" //get current thread ebp and esp
 c8f:	89 e9                	mov    %ebp,%ecx
 c91:	89 e2                	mov    %esp,%edx
    : "=r" (mainT->ebp) ,"=r"(mainT->esp)    
 c93:	8b 45 f4             	mov    -0xc(%ebp),%eax
uthread_init()
{  
  tTable.length=0;
  tTable.current=0;
  uthread_p mainT = allocThread(); //needed to allocate the main thread !!!!!!
  asm("movl %%ebp,%0;" "movl %%esp,%1;" //get current thread ebp and esp
 c96:	89 48 08             	mov    %ecx,0x8(%eax)
    : "=r" (mainT->ebp) ,"=r"(mainT->esp)    
 c99:	8b 45 f4             	mov    -0xc(%ebp),%eax
uthread_init()
{  
  tTable.length=0;
  tTable.current=0;
  uthread_p mainT = allocThread(); //needed to allocate the main thread !!!!!!
  asm("movl %%ebp,%0;" "movl %%esp,%1;" //get current thread ebp and esp
 c9c:	89 50 04             	mov    %edx,0x4(%eax)
    : "=r" (mainT->ebp) ,"=r"(mainT->esp)    
  );
  /*moves stack to mainT's stack
  /stacks grow backwards so we start from esp and finsh at ebp*/
  memmove(mainT->stack , (void*)mainT->esp , mainT->ebp - mainT->esp);
 c9f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 ca2:	8b 50 08             	mov    0x8(%eax),%edx
 ca5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 ca8:	8b 40 04             	mov    0x4(%eax),%eax
 cab:	89 d1                	mov    %edx,%ecx
 cad:	29 c1                	sub    %eax,%ecx
 caf:	8b 45 f4             	mov    -0xc(%ebp),%eax
 cb2:	8b 40 04             	mov    0x4(%eax),%eax
 cb5:	89 c2                	mov    %eax,%edx
 cb7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 cba:	8b 40 0c             	mov    0xc(%eax),%eax
 cbd:	89 4c 24 08          	mov    %ecx,0x8(%esp)
 cc1:	89 54 24 04          	mov    %edx,0x4(%esp)
 cc5:	89 04 24             	mov    %eax,(%esp)
 cc8:	e8 a5 f8 ff ff       	call   572 <memmove>
  mainT->state = T_RUNNABLE;
 ccd:	8b 45 f4             	mov    -0xc(%ebp),%eax
 cd0:	c7 40 10 03 00 00 00 	movl   $0x3,0x10(%eax)
  currentThread=mainT;
 cd7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 cda:	a3 28 5a 00 00       	mov    %eax,0x5a28
  if(signal(SIGALRM,uthread_yield)<0)
 cdf:	c7 44 24 04 da 0e 00 	movl   $0xeda,0x4(%esp)
 ce6:	00 
 ce7:	c7 04 24 0e 00 00 00 	movl   $0xe,(%esp)
 cee:	e8 85 f9 ff ff       	call   678 <signal>
 cf3:	85 c0                	test   %eax,%eax
 cf5:	79 19                	jns    d10 <uthread_init+0xa3>
  {
    printf(1,"Cant register the alarm signal");
 cf7:	c7 44 24 04 e4 0f 00 	movl   $0xfe4,0x4(%esp)
 cfe:	00 
 cff:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 d06:	e8 5c fa ff ff       	call   767 <printf>
    exit();
 d0b:	e8 a8 f8 ff ff       	call   5b8 <exit>
  }
  if(alarm(THREAD_QUANTA)<0)
 d10:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
 d17:	e8 6c f9 ff ff       	call   688 <alarm>
 d1c:	85 c0                	test   %eax,%eax
 d1e:	79 19                	jns    d39 <uthread_init+0xcc>
  {
    printf(1,"Cant activate alarm system call");
 d20:	c7 44 24 04 04 10 00 	movl   $0x1004,0x4(%esp)
 d27:	00 
 d28:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 d2f:	e8 33 fa ff ff       	call   767 <printf>
    exit();
 d34:	e8 7f f8 ff ff       	call   5b8 <exit>
  }
  
}
 d39:	c9                   	leave  
 d3a:	c3                   	ret    

00000d3b <uthread_create>:

int  
uthread_create(void (*start_func)(void *), void* arg)
{
 d3b:	55                   	push   %ebp
 d3c:	89 e5                	mov    %esp,%ebp
 d3e:	83 ec 18             	sub    $0x18,%esp
  uthread_p t = allocThread();
 d41:	e8 5f fe ff ff       	call   ba5 <allocThread>
 d46:	89 45 f4             	mov    %eax,-0xc(%ebp)
  
  asm("push %1;"  //stores the arguments to be used
 d49:	8b 45 0c             	mov    0xc(%ebp),%eax
 d4c:	8b 55 08             	mov    0x8(%ebp),%edx
 d4f:	50                   	push   %eax
 d50:	52                   	push   %edx
 d51:	89 e2                	mov    %esp,%edx
      "push %2;"  //stores the start_func location
      "movl %%esp,%0;"
      : "=r" (t->esp)
 d53:	8b 45 f4             	mov    -0xc(%ebp),%eax
int  
uthread_create(void (*start_func)(void *), void* arg)
{
  uthread_p t = allocThread();
  
  asm("push %1;"  //stores the arguments to be used
 d56:	89 50 04             	mov    %edx,0x4(%eax)
      "push %2;"  //stores the start_func location
      "movl %%esp,%0;"
      : "=r" (t->esp)
      : "r" (arg) , "r"(start_func)
  );
  t->state= T_RUNNABLE;
 d59:	8b 45 f4             	mov    -0xc(%ebp),%eax
 d5c:	c7 40 10 03 00 00 00 	movl   $0x3,0x10(%eax)
  
  return t->tid;
 d63:	8b 45 f4             	mov    -0xc(%ebp),%eax
 d66:	8b 00                	mov    (%eax),%eax
}
 d68:	c9                   	leave  
 d69:	c3                   	ret    

00000d6a <uthread_exit>:

void 
uthread_exit()
{
 d6a:	55                   	push   %ebp
 d6b:	89 e5                	mov    %esp,%ebp
 d6d:	83 ec 28             	sub    $0x28,%esp
  uthread_p newt;
  int old=currentThread->tid;
 d70:	a1 28 5a 00 00       	mov    0x5a28,%eax
 d75:	8b 00                	mov    (%eax),%eax
 d77:	89 45 f0             	mov    %eax,-0x10(%ebp)
  
  int i=0;
 d7a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  while(currentThread->waiting[i]!=-1)
 d81:	eb 25                	jmp    da8 <uthread_exit+0x3e>
  {
    (&tTable.table[currentThread->waiting[i]])->state=T_RUNNABLE;
 d83:	a1 28 5a 00 00       	mov    0x5a28,%eax
 d88:	8b 55 f4             	mov    -0xc(%ebp),%edx
 d8b:	83 c2 04             	add    $0x4,%edx
 d8e:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
 d92:	69 c0 18 01 00 00    	imul   $0x118,%eax,%eax
 d98:	05 20 14 00 00       	add    $0x1420,%eax
 d9d:	c7 40 10 03 00 00 00 	movl   $0x3,0x10(%eax)
    i++;
 da4:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
{
  uthread_p newt;
  int old=currentThread->tid;
  
  int i=0;
  while(currentThread->waiting[i]!=-1)
 da8:	a1 28 5a 00 00       	mov    0x5a28,%eax
 dad:	8b 55 f4             	mov    -0xc(%ebp),%edx
 db0:	83 c2 04             	add    $0x4,%edx
 db3:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
 db7:	83 f8 ff             	cmp    $0xffffffff,%eax
 dba:	75 c7                	jne    d83 <uthread_exit+0x19>
  {
    (&tTable.table[currentThread->waiting[i]])->state=T_RUNNABLE;
    i++;
  }
  currentThread->tid=-1;
 dbc:	a1 28 5a 00 00       	mov    0x5a28,%eax
 dc1:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)
  currentThread->esp=-1;
 dc7:	a1 28 5a 00 00       	mov    0x5a28,%eax
 dcc:	c7 40 04 ff ff ff ff 	movl   $0xffffffff,0x4(%eax)
  currentThread->ebp=-1;
 dd3:	a1 28 5a 00 00       	mov    0x5a28,%eax
 dd8:	c7 40 08 ff ff ff ff 	movl   $0xffffffff,0x8(%eax)
  free(currentThread->stack);
 ddf:	a1 28 5a 00 00       	mov    0x5a28,%eax
 de4:	8b 40 0c             	mov    0xc(%eax),%eax
 de7:	89 04 24             	mov    %eax,(%esp)
 dea:	e8 2d fb ff ff       	call   91c <free>
  currentThread->state=T_FREE;
 def:	a1 28 5a 00 00       	mov    0x5a28,%eax
 df4:	c7 40 10 00 00 00 00 	movl   $0x0,0x10(%eax)
  currentThread->firstTime=0;
 dfb:	a1 28 5a 00 00       	mov    0x5a28,%eax
 e00:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
  int new=getNextThread(old);
 e07:	8b 45 f0             	mov    -0x10(%ebp),%eax
 e0a:	89 04 24             	mov    %eax,(%esp)
 e0d:	e8 1a fd ff ff       	call   b2c <getNextThread>
 e12:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if(new>=0)
 e15:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 e19:	78 36                	js     e51 <uthread_exit+0xe7>
          {
             newt=&tTable.table[new];
 e1b:	8b 45 ec             	mov    -0x14(%ebp),%eax
 e1e:	69 c0 18 01 00 00    	imul   $0x118,%eax,%eax
 e24:	05 20 14 00 00       	add    $0x1420,%eax
 e29:	89 45 e8             	mov    %eax,-0x18(%ebp)
             newt->state=T_RUNNING;
 e2c:	8b 45 e8             	mov    -0x18(%ebp),%eax
 e2f:	c7 40 10 02 00 00 00 	movl   $0x2,0x10(%eax)
             LOAD_ESP(newt->esp);
 e36:	8b 45 e8             	mov    -0x18(%ebp),%eax
 e39:	8b 40 04             	mov    0x4(%eax),%eax
 e3c:	89 c4                	mov    %eax,%esp
             LOAD_EBP(newt->ebp);
 e3e:	8b 45 e8             	mov    -0x18(%ebp),%eax
 e41:	8b 40 08             	mov    0x8(%eax),%eax
 e44:	89 c5                	mov    %eax,%ebp
             asm("popa");
 e46:	61                   	popa   
             currentThread=newt;
 e47:	8b 45 e8             	mov    -0x18(%ebp),%eax
 e4a:	a3 28 5a 00 00       	mov    %eax,0x5a28
        {/////what if some thread state is sleeping?
             
             exit();
        }
     
}
 e4f:	c9                   	leave  
 e50:	c3                   	ret    
             currentThread=newt;
          }
        else
        {/////what if some thread state is sleeping?
             
             exit();
 e51:	e8 62 f7 ff ff       	call   5b8 <exit>

00000e56 <uthred_join>:
}


int
uthred_join(int tid)
{
 e56:	55                   	push   %ebp
 e57:	89 e5                	mov    %esp,%ebp
 e59:	83 ec 18             	sub    $0x18,%esp
  if((&tTable.table[tid])->state==T_FREE)
 e5c:	8b 45 08             	mov    0x8(%ebp),%eax
 e5f:	69 c0 18 01 00 00    	imul   $0x118,%eax,%eax
 e65:	05 20 14 00 00       	add    $0x1420,%eax
 e6a:	8b 40 10             	mov    0x10(%eax),%eax
 e6d:	85 c0                	test   %eax,%eax
 e6f:	75 07                	jne    e78 <uthred_join+0x22>
    return -1;
 e71:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 e76:	eb 60                	jmp    ed8 <uthred_join+0x82>
  else
  {
      int i=0;
 e78:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
      while((&tTable.table[tid])->waiting[i]!=-1)
 e7f:	eb 04                	jmp    e85 <uthred_join+0x2f>
        i++;
 e81:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  if((&tTable.table[tid])->state==T_FREE)
    return -1;
  else
  {
      int i=0;
      while((&tTable.table[tid])->waiting[i]!=-1)
 e85:	8b 45 08             	mov    0x8(%ebp),%eax
 e88:	69 c0 18 01 00 00    	imul   $0x118,%eax,%eax
 e8e:	05 20 14 00 00       	add    $0x1420,%eax
 e93:	8b 55 f4             	mov    -0xc(%ebp),%edx
 e96:	83 c2 04             	add    $0x4,%edx
 e99:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
 e9d:	83 f8 ff             	cmp    $0xffffffff,%eax
 ea0:	75 df                	jne    e81 <uthred_join+0x2b>
        i++;
      (&tTable.table[tid])->waiting[i]=currentThread->tid;
 ea2:	8b 45 08             	mov    0x8(%ebp),%eax
 ea5:	69 c0 18 01 00 00    	imul   $0x118,%eax,%eax
 eab:	8d 90 20 14 00 00    	lea    0x1420(%eax),%edx
 eb1:	a1 28 5a 00 00       	mov    0x5a28,%eax
 eb6:	8b 00                	mov    (%eax),%eax
 eb8:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 ebb:	83 c1 04             	add    $0x4,%ecx
 ebe:	89 44 8a 08          	mov    %eax,0x8(%edx,%ecx,4)
      currentThread->state=T_SLEEPING;
 ec2:	a1 28 5a 00 00       	mov    0x5a28,%eax
 ec7:	c7 40 10 04 00 00 00 	movl   $0x4,0x10(%eax)
      uthread_yield();
 ece:	e8 07 00 00 00       	call   eda <uthread_yield>
      return 1;
 ed3:	b8 01 00 00 00       	mov    $0x1,%eax
  }
}
 ed8:	c9                   	leave  
 ed9:	c3                   	ret    

00000eda <uthread_yield>:

void 
uthread_yield()
{
 eda:	55                   	push   %ebp
 edb:	89 e5                	mov    %esp,%ebp
 edd:	83 ec 28             	sub    $0x28,%esp
  uthread_p newt;
  int old=currentThread->tid;
 ee0:	a1 28 5a 00 00       	mov    0x5a28,%eax
 ee5:	8b 00                	mov    (%eax),%eax
 ee7:	89 45 f4             	mov    %eax,-0xc(%ebp)
  int new=getNextThread(old);
 eea:	8b 45 f4             	mov    -0xc(%ebp),%eax
 eed:	89 04 24             	mov    %eax,(%esp)
 ef0:	e8 37 fc ff ff       	call   b2c <getNextThread>
 ef5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(new<0)
 ef8:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 efc:	79 19                	jns    f17 <uthread_yield+0x3d>
  {
     printf(1,"(fun uthread_yield)Cant find runnable thread");
 efe:	c7 44 24 04 24 10 00 	movl   $0x1024,0x4(%esp)
 f05:	00 
 f06:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 f0d:	e8 55 f8 ff ff       	call   767 <printf>
    exit();
 f12:	e8 a1 f6 ff ff       	call   5b8 <exit>
  }
newt=&tTable.table[new];
 f17:	8b 45 f0             	mov    -0x10(%ebp),%eax
 f1a:	69 c0 18 01 00 00    	imul   $0x118,%eax,%eax
 f20:	05 20 14 00 00       	add    $0x1420,%eax
 f25:	89 45 ec             	mov    %eax,-0x14(%ebp)
  
    asm("pusha");
 f28:	60                   	pusha  
    STORE_ESP(currentThread->esp);
 f29:	a1 28 5a 00 00       	mov    0x5a28,%eax
 f2e:	89 e2                	mov    %esp,%edx
 f30:	89 50 04             	mov    %edx,0x4(%eax)
    if(currentThread->state==T_RUNNING)
 f33:	a1 28 5a 00 00       	mov    0x5a28,%eax
 f38:	8b 40 10             	mov    0x10(%eax),%eax
 f3b:	83 f8 02             	cmp    $0x2,%eax
 f3e:	75 0c                	jne    f4c <uthread_yield+0x72>
      currentThread->state=T_RUNNABLE;
 f40:	a1 28 5a 00 00       	mov    0x5a28,%eax
 f45:	c7 40 10 03 00 00 00 	movl   $0x3,0x10(%eax)
    LOAD_ESP(newt->esp);
 f4c:	8b 45 ec             	mov    -0x14(%ebp),%eax
 f4f:	8b 40 04             	mov    0x4(%eax),%eax
 f52:	89 c4                	mov    %eax,%esp
    
  
    newt->state=T_RUNNING;
 f54:	8b 45 ec             	mov    -0x14(%ebp),%eax
 f57:	c7 40 10 02 00 00 00 	movl   $0x2,0x10(%eax)

    asm("popa");
 f5e:	61                   	popa   
    if(currentThread->firstTime==0)
 f5f:	a1 28 5a 00 00       	mov    0x5a28,%eax
 f64:	8b 40 14             	mov    0x14(%eax),%eax
 f67:	85 c0                	test   %eax,%eax
 f69:	75 0d                	jne    f78 <uthread_yield+0x9e>
    {
       asm("ret");////only firest time
 f6b:	c3                   	ret    
       currentThread->firstTime=1;
 f6c:	a1 28 5a 00 00       	mov    0x5a28,%eax
 f71:	c7 40 14 01 00 00 00 	movl   $0x1,0x14(%eax)
    }
   
currentThread=newt;
 f78:	8b 45 ec             	mov    -0x14(%ebp),%eax
 f7b:	a3 28 5a 00 00       	mov    %eax,0x5a28

}
 f80:	c9                   	leave  
 f81:	c3                   	ret    

00000f82 <uthred_self>:

int  uthred_self(void)
{
 f82:	55                   	push   %ebp
 f83:	89 e5                	mov    %esp,%ebp
  return currentThread->tid;
 f85:	a1 28 5a 00 00       	mov    0x5a28,%eax
 f8a:	8b 00                	mov    (%eax),%eax
}
 f8c:	5d                   	pop    %ebp
 f8d:	c3                   	ret    
