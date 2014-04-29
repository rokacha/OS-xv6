
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
      5f:	c7 04 24 40 18 00 00 	movl   $0x1840,(%esp)
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
      8a:	05 40 18 00 00       	add    $0x1840,%eax
      8f:	89 5c 24 08          	mov    %ebx,0x8(%esp)
      93:	c7 44 24 04 20 00 00 	movl   $0x20,0x4(%esp)
      9a:	00 
      9b:	89 04 24             	mov    %eax,(%esp)
      9e:	e8 70 03 00 00       	call   413 <memset>
  return buf;
      a3:	b8 40 18 00 00       	mov    $0x1840,%eax
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
      dd:	c7 44 24 04 80 12 00 	movl   $0x1280,0x4(%esp)
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
     116:	c7 44 24 04 94 12 00 	movl   $0x1294,0x4(%esp)
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
     181:	c7 44 24 04 a8 12 00 	movl   $0x12a8,0x4(%esp)
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
     1af:	c7 44 24 04 b5 12 00 	movl   $0x12b5,0x4(%esp)
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
     264:	c7 44 24 04 94 12 00 	movl   $0x1294,0x4(%esp)
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
     2ae:	c7 44 24 04 a8 12 00 	movl   $0x12a8,0x4(%esp)
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
     311:	c7 04 24 c8 12 00 00 	movl   $0x12c8,(%esp)
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
     6fe:	0f b6 90 18 18 00 00 	movzbl 0x1818(%eax),%edx
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
     85f:	c7 45 f4 ca 12 00 00 	movl   $0x12ca,-0xc(%ebp)
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
     92b:	a1 58 18 00 00       	mov    0x1858,%eax
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
     9ec:	a3 58 18 00 00       	mov    %eax,0x1858
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
     a44:	a1 58 18 00 00       	mov    0x1858,%eax
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
     a60:	a1 58 18 00 00       	mov    0x1858,%eax
     a65:	89 45 f0             	mov    %eax,-0x10(%ebp)
     a68:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     a6c:	75 23                	jne    a91 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     a6e:	c7 45 f0 50 18 00 00 	movl   $0x1850,-0x10(%ebp)
     a75:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a78:	a3 58 18 00 00       	mov    %eax,0x1858
     a7d:	a1 58 18 00 00       	mov    0x1858,%eax
     a82:	a3 50 18 00 00       	mov    %eax,0x1850
    base.s.size = 0;
     a87:	c7 05 54 18 00 00 00 	movl   $0x0,0x1854
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
     ae4:	a3 58 18 00 00       	mov    %eax,0x1858
      return (void*)(p + 1);
     ae9:	8b 45 f4             	mov    -0xc(%ebp),%eax
     aec:	83 c0 08             	add    $0x8,%eax
     aef:	eb 38                	jmp    b29 <malloc+0xde>
    }
    if(p == freep)
     af1:	a1 58 18 00 00       	mov    0x1858,%eax
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

00000b2c <print_stack>:
 * prints the stack of the currently running thread
 * DEBUGGING purposes
 */
void
print_stack()
{
     b2c:	55                   	push   %ebp
     b2d:	89 e5                	mov    %esp,%ebp
     b2f:	83 ec 28             	sub    $0x28,%esp
  int *newesp = (int*)currentThread->esp;  
     b32:	a1 60 61 00 00       	mov    0x6160,%eax
     b37:	8b 40 04             	mov    0x4(%eax),%eax
     b3a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  printf(1,"stack for thread %d \n",currentThread->tid);
     b3d:	a1 60 61 00 00       	mov    0x6160,%eax
     b42:	8b 00                	mov    (%eax),%eax
     b44:	89 44 24 08          	mov    %eax,0x8(%esp)
     b48:	c7 44 24 04 d4 12 00 	movl   $0x12d4,0x4(%esp)
     b4f:	00 
     b50:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     b57:	e8 0b fc ff ff       	call   767 <printf>
  while((newesp < (int *)currentThread->ebp))
     b5c:	eb 3c                	jmp    b9a <print_stack+0x6e>
  {
    printf(1,"add:%x ",newesp);
     b5e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b61:	89 44 24 08          	mov    %eax,0x8(%esp)
     b65:	c7 44 24 04 ea 12 00 	movl   $0x12ea,0x4(%esp)
     b6c:	00 
     b6d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     b74:	e8 ee fb ff ff       	call   767 <printf>
      printf(1,"val:%x\n",*newesp);
     b79:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b7c:	8b 00                	mov    (%eax),%eax
     b7e:	89 44 24 08          	mov    %eax,0x8(%esp)
     b82:	c7 44 24 04 f2 12 00 	movl   $0x12f2,0x4(%esp)
     b89:	00 
     b8a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     b91:	e8 d1 fb ff ff       	call   767 <printf>
    newesp++;
     b96:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
void
print_stack()
{
  int *newesp = (int*)currentThread->esp;  
  printf(1,"stack for thread %d \n",currentThread->tid);
  while((newesp < (int *)currentThread->ebp))
     b9a:	a1 60 61 00 00       	mov    0x6160,%eax
     b9f:	8b 40 08             	mov    0x8(%eax),%eax
     ba2:	3b 45 f4             	cmp    -0xc(%ebp),%eax
     ba5:	77 b7                	ja     b5e <print_stack+0x32>
    printf(1,"add:%x ",newesp);
      printf(1,"val:%x\n",*newesp);
    newesp++;
  }

}
     ba7:	c9                   	leave  
     ba8:	c3                   	ret    

00000ba9 <getNextThread>:
 * returns the next thread in line to run
 * if none exists it returns -1
 */
int
getNextThread(int j)
{
     ba9:	55                   	push   %ebp
     baa:	89 e5                	mov    %esp,%ebp
     bac:	83 ec 10             	sub    $0x10,%esp
  int i=j+1;
     baf:	8b 45 08             	mov    0x8(%ebp),%eax
     bb2:	83 c0 01             	add    $0x1,%eax
     bb5:	89 45 fc             	mov    %eax,-0x4(%ebp)
  if(i==MAX_THREAD)
     bb8:	83 7d fc 40          	cmpl   $0x40,-0x4(%ebp)
     bbc:	75 07                	jne    bc5 <getNextThread+0x1c>
    i=0;
     bbe:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  uthread_p t=&tTable.table[i];
     bc5:	8b 45 fc             	mov    -0x4(%ebp),%eax
     bc8:	69 c0 24 01 00 00    	imul   $0x124,%eax,%eax
     bce:	05 60 18 00 00       	add    $0x1860,%eax
     bd3:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(i!=j)
     bd6:	eb 3b                	jmp    c13 <getNextThread+0x6a>
  {
    if(t->state==T_RUNNABLE)
     bd8:	8b 45 f8             	mov    -0x8(%ebp),%eax
     bdb:	8b 40 10             	mov    0x10(%eax),%eax
     bde:	83 f8 03             	cmp    $0x3,%eax
     be1:	75 05                	jne    be8 <getNextThread+0x3f>
      return i;
     be3:	8b 45 fc             	mov    -0x4(%ebp),%eax
     be6:	eb 38                	jmp    c20 <getNextThread+0x77>
    i++;
     be8:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    if(i==MAX_THREAD)
     bec:	83 7d fc 40          	cmpl   $0x40,-0x4(%ebp)
     bf0:	75 1a                	jne    c0c <getNextThread+0x63>
    {
     i=0;
     bf2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
     t=&tTable.table[i];
     bf9:	8b 45 fc             	mov    -0x4(%ebp),%eax
     bfc:	69 c0 24 01 00 00    	imul   $0x124,%eax,%eax
     c02:	05 60 18 00 00       	add    $0x1860,%eax
     c07:	89 45 f8             	mov    %eax,-0x8(%ebp)
     c0a:	eb 07                	jmp    c13 <getNextThread+0x6a>
   }
   else
    t++;
     c0c:	81 45 f8 24 01 00 00 	addl   $0x124,-0x8(%ebp)
{
  int i=j+1;
  if(i==MAX_THREAD)
    i=0;
  uthread_p t=&tTable.table[i];
  while(i!=j)
     c13:	8b 45 fc             	mov    -0x4(%ebp),%eax
     c16:	3b 45 08             	cmp    0x8(%ebp),%eax
     c19:	75 bd                	jne    bd8 <getNextThread+0x2f>
   }
   else
    t++;

}
return -1;
     c1b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
     c20:	c9                   	leave  
     c21:	c3                   	ret    

00000c22 <allocThread>:
 * allocates a spot for a new thread
 * if none exist it returns NULL
 */
static uthread_p
allocThread()
{
     c22:	55                   	push   %ebp
     c23:	89 e5                	mov    %esp,%ebp
     c25:	83 ec 28             	sub    $0x28,%esp
  int i,j;
  uthread_p t;
  
  for (t=tTable.table,i=0 ; t < &tTable.table[MAX_THREAD]; t++,i++)
     c28:	c7 45 ec 60 18 00 00 	movl   $0x1860,-0x14(%ebp)
     c2f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     c36:	eb 15                	jmp    c4d <allocThread+0x2b>
  {
    if(t->state==T_FREE)
     c38:	8b 45 ec             	mov    -0x14(%ebp),%eax
     c3b:	8b 40 10             	mov    0x10(%eax),%eax
     c3e:	85 c0                	test   %eax,%eax
     c40:	74 1e                	je     c60 <allocThread+0x3e>
allocThread()
{
  int i,j;
  uthread_p t;
  
  for (t=tTable.table,i=0 ; t < &tTable.table[MAX_THREAD]; t++,i++)
     c42:	81 45 ec 24 01 00 00 	addl   $0x124,-0x14(%ebp)
     c49:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     c4d:	81 7d ec 60 61 00 00 	cmpl   $0x6160,-0x14(%ebp)
     c54:	72 e2                	jb     c38 <allocThread+0x16>
  {
    if(t->state==T_FREE)
      goto found;
  }
  return 0;
     c56:	b8 00 00 00 00       	mov    $0x0,%eax
     c5b:	e9 a3 00 00 00       	jmp    d03 <allocThread+0xe1>
  uthread_p t;
  
  for (t=tTable.table,i=0 ; t < &tTable.table[MAX_THREAD]; t++,i++)
  {
    if(t->state==T_FREE)
      goto found;
     c60:	90                   	nop
  }
  return 0;
  
  found:
  //Init all fields
  t->tid=i;
     c61:	8b 45 ec             	mov    -0x14(%ebp),%eax
     c64:	8b 55 f4             	mov    -0xc(%ebp),%edx
     c67:	89 10                	mov    %edx,(%eax)
  if(i==0) //main thread init
     c69:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     c6d:	75 1c                	jne    c8b <allocThread+0x69>
  {
    STORE_ESP(t->esp);
     c6f:	89 e2                	mov    %esp,%edx
     c71:	8b 45 ec             	mov    -0x14(%ebp),%eax
     c74:	89 50 04             	mov    %edx,0x4(%eax)
    STORE_EBP(t->ebp);
     c77:	89 ea                	mov    %ebp,%edx
     c79:	8b 45 ec             	mov    -0x14(%ebp),%eax
     c7c:	89 50 08             	mov    %edx,0x8(%eax)
    t->firstTime=0;
     c7f:	8b 45 ec             	mov    -0x14(%ebp),%eax
     c82:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
     c89:	eb 3b                	jmp    cc6 <allocThread+0xa4>
  }
  else
  {
    t->stack=(char*)malloc(STACK_SIZE);
     c8b:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
     c92:	e8 b4 fd ff ff       	call   a4b <malloc>
     c97:	8b 55 ec             	mov    -0x14(%ebp),%edx
     c9a:	89 42 0c             	mov    %eax,0xc(%edx)
    t->ebp=(int)t->stack+STACK_SIZE;
     c9d:	8b 45 ec             	mov    -0x14(%ebp),%eax
     ca0:	8b 40 0c             	mov    0xc(%eax),%eax
     ca3:	05 00 10 00 00       	add    $0x1000,%eax
     ca8:	89 c2                	mov    %eax,%edx
     caa:	8b 45 ec             	mov    -0x14(%ebp),%eax
     cad:	89 50 08             	mov    %edx,0x8(%eax)
    t->esp=t->ebp;
     cb0:	8b 45 ec             	mov    -0x14(%ebp),%eax
     cb3:	8b 50 08             	mov    0x8(%eax),%edx
     cb6:	8b 45 ec             	mov    -0x14(%ebp),%eax
     cb9:	89 50 04             	mov    %edx,0x4(%eax)
    t->firstTime=1;
     cbc:	8b 45 ec             	mov    -0x14(%ebp),%eax
     cbf:	c7 40 14 01 00 00 00 	movl   $0x1,0x14(%eax)
  }
  
  t->waitingFor=-1;
     cc6:	8b 45 ec             	mov    -0x14(%ebp),%eax
     cc9:	c7 80 20 01 00 00 ff 	movl   $0xffffffff,0x120(%eax)
     cd0:	ff ff ff 
  
  for(j=0;j<MAX_THREAD;j++)
     cd3:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     cda:	eb 14                	jmp    cf0 <allocThread+0xce>
  {
    t->waitedOn[j]=-1;
     cdc:	8b 45 ec             	mov    -0x14(%ebp),%eax
     cdf:	8b 55 f0             	mov    -0x10(%ebp),%edx
     ce2:	83 c2 08             	add    $0x8,%edx
     ce5:	c7 04 90 ff ff ff ff 	movl   $0xffffffff,(%eax,%edx,4)
    t->firstTime=1;
  }
  
  t->waitingFor=-1;
  
  for(j=0;j<MAX_THREAD;j++)
     cec:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     cf0:	83 7d f0 3f          	cmpl   $0x3f,-0x10(%ebp)
     cf4:	7e e6                	jle    cdc <allocThread+0xba>
  {
    t->waitedOn[j]=-1;
  }
   
  t->state=T_UNINIT;
     cf6:	8b 45 ec             	mov    -0x14(%ebp),%eax
     cf9:	c7 40 10 01 00 00 00 	movl   $0x1,0x10(%eax)
  
    
  return t;
     d00:	8b 45 ec             	mov    -0x14(%ebp),%eax
}
     d03:	c9                   	leave  
     d04:	c3                   	ret    

00000d05 <uthread_init>:
/*
 * initializes all the uthread structures
 */
int
uthread_init()
{   
     d05:	55                   	push   %ebp
     d06:	89 e5                	mov    %esp,%ebp
     d08:	83 ec 28             	sub    $0x28,%esp
  //Initialize table
  int i;
  
  for(i=0;i<MAX_THREAD;i++)
     d0b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     d12:	eb 18                	jmp    d2c <uthread_init+0x27>
  {
    tTable.table[i].state=T_FREE;
     d14:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d17:	69 c0 24 01 00 00    	imul   $0x124,%eax,%eax
     d1d:	05 70 18 00 00       	add    $0x1870,%eax
     d22:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
uthread_init()
{   
  //Initialize table
  int i;
  
  for(i=0;i<MAX_THREAD;i++)
     d28:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     d2c:	83 7d f4 3f          	cmpl   $0x3f,-0xc(%ebp)
     d30:	7e e2                	jle    d14 <uthread_init+0xf>
  {
    tTable.table[i].state=T_FREE;
  }
  
 //allocate the main thread
  currentThread = allocThread();
     d32:	e8 eb fe ff ff       	call   c22 <allocThread>
     d37:	a3 60 61 00 00       	mov    %eax,0x6160
  if(currentThread==0)
     d3c:	a1 60 61 00 00       	mov    0x6160,%eax
     d41:	85 c0                	test   %eax,%eax
     d43:	75 07                	jne    d4c <uthread_init+0x47>
    return -1;
     d45:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     d4a:	eb 6b                	jmp    db7 <uthread_init+0xb2>
  
  currentThread->state = T_RUNNING;
     d4c:	a1 60 61 00 00       	mov    0x6160,%eax
     d51:	c7 40 10 02 00 00 00 	movl   $0x2,0x10(%eax)
  //register uthread_yield as signal handler for alarm
  if(signal(SIGALRM,uthread_yield)<0)
     d58:	c7 44 24 04 3f 10 00 	movl   $0x103f,0x4(%esp)
     d5f:	00 
     d60:	c7 04 24 0e 00 00 00 	movl   $0xe,(%esp)
     d67:	e8 0c f9 ff ff       	call   678 <signal>
     d6c:	85 c0                	test   %eax,%eax
     d6e:	79 19                	jns    d89 <uthread_init+0x84>
  {
    printf(1,"Cant register the alarm signal");
     d70:	c7 44 24 04 fc 12 00 	movl   $0x12fc,0x4(%esp)
     d77:	00 
     d78:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     d7f:	e8 e3 f9 ff ff       	call   767 <printf>
    exit();
     d84:	e8 2f f8 ff ff       	call   5b8 <exit>
  }
  //set new alarm clock
  if(alarm(THREAD_QUANTA)<0)
     d89:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
     d90:	e8 f3 f8 ff ff       	call   688 <alarm>
     d95:	85 c0                	test   %eax,%eax
     d97:	79 19                	jns    db2 <uthread_init+0xad>
  {
    printf(1,"Cant activate alarm system call");
     d99:	c7 44 24 04 1c 13 00 	movl   $0x131c,0x4(%esp)
     da0:	00 
     da1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     da8:	e8 ba f9 ff ff       	call   767 <printf>
    exit();
     dad:	e8 06 f8 ff ff       	call   5b8 <exit>
  }
  return 0;
     db2:	b8 00 00 00 00       	mov    $0x0,%eax
}
     db7:	c9                   	leave  
     db8:	c3                   	ret    

00000db9 <wrap_func>:

void
wrap_func()
{
     db9:	55                   	push   %ebp
     dba:	89 e5                	mov    %esp,%ebp
     dbc:	83 ec 18             	sub    $0x18,%esp
  currentThread->func(currentThread->arguments);
     dbf:	a1 60 61 00 00       	mov    0x6160,%eax
     dc4:	8b 50 18             	mov    0x18(%eax),%edx
     dc7:	a1 60 61 00 00       	mov    0x6160,%eax
     dcc:	8b 40 1c             	mov    0x1c(%eax),%eax
     dcf:	89 04 24             	mov    %eax,(%esp)
     dd2:	ff d2                	call   *%edx
  uthread_exit();
     dd4:	e8 6c 00 00 00       	call   e45 <uthread_exit>
}
     dd9:	c9                   	leave  
     dda:	c3                   	ret    

00000ddb <uthread_create>:
 * to that function
 * if none can be created it returns -1;
 */
int  
uthread_create(void (*start_func)(void *), void* arg)
{
     ddb:	55                   	push   %ebp
     ddc:	89 e5                	mov    %esp,%ebp
     dde:	53                   	push   %ebx
     ddf:	83 ec 14             	sub    $0x14,%esp
  uint local_esp;
  uthread_p t = allocThread();
     de2:	e8 3b fe ff ff       	call   c22 <allocThread>
     de7:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(t==0)
     dea:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     dee:	75 07                	jne    df7 <uthread_create+0x1c>
    return -1;
     df0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     df5:	eb 48                	jmp    e3f <uthread_create+0x64>

  t->func=start_func;
     df7:	8b 45 f4             	mov    -0xc(%ebp),%eax
     dfa:	8b 55 08             	mov    0x8(%ebp),%edx
     dfd:	89 50 18             	mov    %edx,0x18(%eax)
  t->arguments=arg;
     e00:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e03:	8b 55 0c             	mov    0xc(%ebp),%edx
     e06:	89 50 1c             	mov    %edx,0x1c(%eax)
  
  //push starting func and return value on the right stack
  STORE_ESP(local_esp);
     e09:	89 e3                	mov    %esp,%ebx
     e0b:	89 5d f0             	mov    %ebx,-0x10(%ebp)
  LOAD_ESP(t->esp);
     e0e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e11:	8b 40 04             	mov    0x4(%eax),%eax
     e14:	89 c4                	mov    %eax,%esp
  PUSH_FUNC(t->esp,t->ebp,wrap_func);
     e16:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e19:	8b 50 08             	mov    0x8(%eax),%edx
     e1c:	b8 b9 0d 00 00       	mov    $0xdb9,%eax
     e21:	50                   	push   %eax
     e22:	52                   	push   %edx
     e23:	89 e2                	mov    %esp,%edx
     e25:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e28:	89 50 04             	mov    %edx,0x4(%eax)
  LOAD_ESP(local_esp);
     e2b:	8b 45 f0             	mov    -0x10(%ebp),%eax
     e2e:	89 c4                	mov    %eax,%esp
  
  t->state = T_RUNNABLE;
     e30:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e33:	c7 40 10 03 00 00 00 	movl   $0x3,0x10(%eax)
  
  return t->tid;
     e3a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e3d:	8b 00                	mov    (%eax),%eax
}
     e3f:	83 c4 14             	add    $0x14,%esp
     e42:	5b                   	pop    %ebx
     e43:	5d                   	pop    %ebp
     e44:	c3                   	ret    

00000e45 <uthread_exit>:
 * closes the running thread, wakes up all
 * the threads waiting for this one (if they require waking up)
 */
void 
uthread_exit()
{
     e45:	55                   	push   %ebp
     e46:	89 e5                	mov    %esp,%ebp
     e48:	83 ec 28             	sub    $0x28,%esp
  alarm(0); //clear the alarm so as not to disturb running of function
     e4b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     e52:	e8 31 f8 ff ff       	call   688 <alarm>
  int new,i;
  //wakeup all threads waiting for this one
  for(i=0;i<MAX_THREAD;i++)
     e57:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     e5e:	eb 51                	jmp    eb1 <uthread_exit+0x6c>
  {
   if(currentThread->waitedOn[i]==1)
     e60:	a1 60 61 00 00       	mov    0x6160,%eax
     e65:	8b 55 f4             	mov    -0xc(%ebp),%edx
     e68:	83 c2 08             	add    $0x8,%edx
     e6b:	8b 04 90             	mov    (%eax,%edx,4),%eax
     e6e:	83 f8 01             	cmp    $0x1,%eax
     e71:	75 3a                	jne    ead <uthread_exit+0x68>
   {
     tTable.table[i].waitingFor=-1; //release thread i from waiting
     e73:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e76:	69 c0 24 01 00 00    	imul   $0x124,%eax,%eax
     e7c:	05 80 19 00 00       	add    $0x1980,%eax
     e81:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)
     currentThread->waitedOn[i]=0; //not necessary maybe   
     e87:	a1 60 61 00 00       	mov    0x6160,%eax
     e8c:	8b 55 f4             	mov    -0xc(%ebp),%edx
     e8f:	83 c2 08             	add    $0x8,%edx
     e92:	c7 04 90 00 00 00 00 	movl   $0x0,(%eax,%edx,4)
     tTable.table[i].state=T_RUNNABLE;
     e99:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e9c:	69 c0 24 01 00 00    	imul   $0x124,%eax,%eax
     ea2:	05 70 18 00 00       	add    $0x1870,%eax
     ea7:	c7 00 03 00 00 00    	movl   $0x3,(%eax)
uthread_exit()
{
  alarm(0); //clear the alarm so as not to disturb running of function
  int new,i;
  //wakeup all threads waiting for this one
  for(i=0;i<MAX_THREAD;i++)
     ead:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     eb1:	83 7d f4 3f          	cmpl   $0x3f,-0xc(%ebp)
     eb5:	7e a9                	jle    e60 <uthread_exit+0x1b>
     tTable.table[i].state=T_RUNNABLE;
   }
  }
  
  //pick next thread
  new=getNextThread(currentThread->tid);
     eb7:	a1 60 61 00 00       	mov    0x6160,%eax
     ebc:	8b 00                	mov    (%eax),%eax
     ebe:	89 04 24             	mov    %eax,(%esp)
     ec1:	e8 e3 fc ff ff       	call   ba9 <getNextThread>
     ec6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  
  //release all resources and zero all fields
  if(currentThread->tid!=0)
     ec9:	a1 60 61 00 00       	mov    0x6160,%eax
     ece:	8b 00                	mov    (%eax),%eax
     ed0:	85 c0                	test   %eax,%eax
     ed2:	74 10                	je     ee4 <uthread_exit+0x9f>
    free(currentThread->stack);
     ed4:	a1 60 61 00 00       	mov    0x6160,%eax
     ed9:	8b 40 0c             	mov    0xc(%eax),%eax
     edc:	89 04 24             	mov    %eax,(%esp)
     edf:	e8 38 fa ff ff       	call   91c <free>
  currentThread->tid=-1;
     ee4:	a1 60 61 00 00       	mov    0x6160,%eax
     ee9:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)
  currentThread->esp=-1;
     eef:	a1 60 61 00 00       	mov    0x6160,%eax
     ef4:	c7 40 04 ff ff ff ff 	movl   $0xffffffff,0x4(%eax)
  currentThread->ebp=-1;
     efb:	a1 60 61 00 00       	mov    0x6160,%eax
     f00:	c7 40 08 ff ff ff ff 	movl   $0xffffffff,0x8(%eax)
  currentThread->func=0;
     f07:	a1 60 61 00 00       	mov    0x6160,%eax
     f0c:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)
  currentThread->arguments=0;
     f13:	a1 60 61 00 00       	mov    0x6160,%eax
     f18:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
  currentThread->stack=0;
     f1f:	a1 60 61 00 00       	mov    0x6160,%eax
     f24:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
  currentThread->firstTime=1;
     f2b:	a1 60 61 00 00       	mov    0x6160,%eax
     f30:	c7 40 14 01 00 00 00 	movl   $0x1,0x14(%eax)
  currentThread->state=T_FREE;
     f37:	a1 60 61 00 00       	mov    0x6160,%eax
     f3c:	c7 40 10 00 00 00 00 	movl   $0x0,0x10(%eax)
  
  //load new thread
  if(new>=0)
     f43:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     f47:	78 7a                	js     fc3 <uthread_exit+0x17e>
  {
    currentThread=&tTable.table[new];
     f49:	8b 45 f0             	mov    -0x10(%ebp),%eax
     f4c:	69 c0 24 01 00 00    	imul   $0x124,%eax,%eax
     f52:	05 60 18 00 00       	add    $0x1860,%eax
     f57:	a3 60 61 00 00       	mov    %eax,0x6160
    currentThread->state=T_RUNNING;
     f5c:	a1 60 61 00 00       	mov    0x6160,%eax
     f61:	c7 40 10 02 00 00 00 	movl   $0x2,0x10(%eax)
    LOAD_ESP(currentThread->esp);
     f68:	a1 60 61 00 00       	mov    0x6160,%eax
     f6d:	8b 40 04             	mov    0x4(%eax),%eax
     f70:	89 c4                	mov    %eax,%esp
    LOAD_EBP(currentThread->ebp);
     f72:	a1 60 61 00 00       	mov    0x6160,%eax
     f77:	8b 40 08             	mov    0x8(%eax),%eax
     f7a:	89 c5                	mov    %eax,%ebp
    
    //set new alarm clock
    if(alarm(THREAD_QUANTA)<0)
     f7c:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
     f83:	e8 00 f7 ff ff       	call   688 <alarm>
     f88:	85 c0                	test   %eax,%eax
     f8a:	79 19                	jns    fa5 <uthread_exit+0x160>
    {
      printf(1,"Cant activate alarm system call");
     f8c:	c7 44 24 04 1c 13 00 	movl   $0x131c,0x4(%esp)
     f93:	00 
     f94:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     f9b:	e8 c7 f7 ff ff       	call   767 <printf>
      exit();
     fa0:	e8 13 f6 ff ff       	call   5b8 <exit>
    }
    
    if(currentThread->firstTime==1)
     fa5:	a1 60 61 00 00       	mov    0x6160,%eax
     faa:	8b 40 14             	mov    0x14(%eax),%eax
     fad:	83 f8 01             	cmp    $0x1,%eax
     fb0:	75 10                	jne    fc2 <uthread_exit+0x17d>
    {
      currentThread->firstTime=0;
     fb2:	a1 60 61 00 00       	mov    0x6160,%eax
     fb7:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
      POP_AND_RET();
     fbe:	5d                   	pop    %ebp
     fbf:	c3                   	ret    
     fc0:	eb 01                	jmp    fc3 <uthread_exit+0x17e>
    }
    else
    {  
    POP_ALL_REGISTERS();
     fc2:	61                   	popa   
    }
  }
}
     fc3:	c9                   	leave  
     fc4:	c3                   	ret    

00000fc5 <uthread_join>:
/*
 * causes this thread to wait for the finish of another thread
 */
int
uthread_join(int tid)
{
     fc5:	55                   	push   %ebp
     fc6:	89 e5                	mov    %esp,%ebp
     fc8:	83 ec 18             	sub    $0x18,%esp
  if((&tTable.table[tid])->state==T_FREE)
     fcb:	8b 45 08             	mov    0x8(%ebp),%eax
     fce:	69 c0 24 01 00 00    	imul   $0x124,%eax,%eax
     fd4:	05 60 18 00 00       	add    $0x1860,%eax
     fd9:	8b 40 10             	mov    0x10(%eax),%eax
     fdc:	85 c0                	test   %eax,%eax
     fde:	75 07                	jne    fe7 <uthread_join+0x22>
    return -1;
     fe0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     fe5:	eb 56                	jmp    103d <uthread_join+0x78>
  else
  {
    alarm(0); //clear the alarm so as not to disturb running of function
     fe7:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     fee:	e8 95 f6 ff ff       	call   688 <alarm>
    currentThread->waitingFor=tid;
     ff3:	a1 60 61 00 00       	mov    0x6160,%eax
     ff8:	8b 55 08             	mov    0x8(%ebp),%edx
     ffb:	89 90 20 01 00 00    	mov    %edx,0x120(%eax)
    tTable.table[tid].waitedOn[currentThread->tid]=1;
    1001:	a1 60 61 00 00       	mov    0x6160,%eax
    1006:	8b 08                	mov    (%eax),%ecx
    1008:	8b 55 08             	mov    0x8(%ebp),%edx
    100b:	89 d0                	mov    %edx,%eax
    100d:	c1 e0 03             	shl    $0x3,%eax
    1010:	01 d0                	add    %edx,%eax
    1012:	c1 e0 03             	shl    $0x3,%eax
    1015:	01 d0                	add    %edx,%eax
    1017:	01 c8                	add    %ecx,%eax
    1019:	83 c0 08             	add    $0x8,%eax
    101c:	c7 04 85 60 18 00 00 	movl   $0x1,0x1860(,%eax,4)
    1023:	01 00 00 00 
    currentThread->state=T_SLEEPING;
    1027:	a1 60 61 00 00       	mov    0x6160,%eax
    102c:	c7 40 10 04 00 00 00 	movl   $0x4,0x10(%eax)
    uthread_yield();
    1033:	e8 07 00 00 00       	call   103f <uthread_yield>
    return 1;
    1038:	b8 01 00 00 00       	mov    $0x1,%eax
  }
}
    103d:	c9                   	leave  
    103e:	c3                   	ret    

0000103f <uthread_yield>:
/*
 * yields the run-time of the current thread to another thread
 */
void 
uthread_yield()
{
    103f:	55                   	push   %ebp
    1040:	89 e5                	mov    %esp,%ebp
    1042:	83 ec 28             	sub    $0x28,%esp
  alarm(0); //clear the alarm so as not to disturb running of function
    1045:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    104c:	e8 37 f6 ff ff       	call   688 <alarm>
  int new=getNextThread(currentThread->tid);
    1051:	a1 60 61 00 00       	mov    0x6160,%eax
    1056:	8b 00                	mov    (%eax),%eax
    1058:	89 04 24             	mov    %eax,(%esp)
    105b:	e8 49 fb ff ff       	call   ba9 <getNextThread>
    1060:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(new==-1)
    1063:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
    1067:	75 2d                	jne    1096 <uthread_yield+0x57>
  {
    if(alarm(THREAD_QUANTA)<0)
    1069:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
    1070:	e8 13 f6 ff ff       	call   688 <alarm>
    1075:	85 c0                	test   %eax,%eax
    1077:	0f 89 c1 00 00 00    	jns    113e <uthread_yield+0xff>
    {
      printf(1,"Cant activate alarm system call\n");
    107d:	c7 44 24 04 3c 13 00 	movl   $0x133c,0x4(%esp)
    1084:	00 
    1085:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    108c:	e8 d6 f6 ff ff       	call   767 <printf>
      exit();
    1091:	e8 22 f5 ff ff       	call   5b8 <exit>
    } 
  }
  else
  {
    //store all leaving thread registers and pointers
    PUSH_ALL_REGISTERS();
    1096:	60                   	pusha  
    STORE_ESP(currentThread->esp);
    1097:	a1 60 61 00 00       	mov    0x6160,%eax
    109c:	89 e2                	mov    %esp,%edx
    109e:	89 50 04             	mov    %edx,0x4(%eax)
    STORE_EBP(currentThread->ebp);
    10a1:	a1 60 61 00 00       	mov    0x6160,%eax
    10a6:	89 ea                	mov    %ebp,%edx
    10a8:	89 50 08             	mov    %edx,0x8(%eax)
    
    //change thread state
    if(currentThread->state==T_RUNNING) //might be sleeping from join operation
    10ab:	a1 60 61 00 00       	mov    0x6160,%eax
    10b0:	8b 40 10             	mov    0x10(%eax),%eax
    10b3:	83 f8 02             	cmp    $0x2,%eax
    10b6:	75 0c                	jne    10c4 <uthread_yield+0x85>
      currentThread->state=T_RUNNABLE;
    10b8:	a1 60 61 00 00       	mov    0x6160,%eax
    10bd:	c7 40 10 03 00 00 00 	movl   $0x3,0x10(%eax)

    currentThread=&tTable.table[new];
    10c4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    10c7:	69 c0 24 01 00 00    	imul   $0x124,%eax,%eax
    10cd:	05 60 18 00 00       	add    $0x1860,%eax
    10d2:	a3 60 61 00 00       	mov    %eax,0x6160

    //load all new thread registers and pointers
    LOAD_ESP(currentThread->esp);
    10d7:	a1 60 61 00 00       	mov    0x6160,%eax
    10dc:	8b 40 04             	mov    0x4(%eax),%eax
    10df:	89 c4                	mov    %eax,%esp
    LOAD_EBP(currentThread->ebp);
    10e1:	a1 60 61 00 00       	mov    0x6160,%eax
    10e6:	8b 40 08             	mov    0x8(%eax),%eax
    10e9:	89 c5                	mov    %eax,%ebp
    //set new alram clock
    if(alarm(THREAD_QUANTA)<0)
    10eb:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
    10f2:	e8 91 f5 ff ff       	call   688 <alarm>
    10f7:	85 c0                	test   %eax,%eax
    10f9:	79 19                	jns    1114 <uthread_yield+0xd5>
    {
      printf(1,"Cant activate alarm system call\n");
    10fb:	c7 44 24 04 3c 13 00 	movl   $0x133c,0x4(%esp)
    1102:	00 
    1103:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    110a:	e8 58 f6 ff ff       	call   767 <printf>
      exit();
    110f:	e8 a4 f4 ff ff       	call   5b8 <exit>
    }  
    currentThread->state=T_RUNNING;
    1114:	a1 60 61 00 00       	mov    0x6160,%eax
    1119:	c7 40 10 02 00 00 00 	movl   $0x2,0x10(%eax)
    
    if(currentThread->firstTime==1)
    1120:	a1 60 61 00 00       	mov    0x6160,%eax
    1125:	8b 40 14             	mov    0x14(%eax),%eax
    1128:	83 f8 01             	cmp    $0x1,%eax
    112b:	75 10                	jne    113d <uthread_yield+0xfe>
    {
    currentThread->firstTime=0;
    112d:	a1 60 61 00 00       	mov    0x6160,%eax
    1132:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
    POP_AND_RET();
    1139:	5d                   	pop    %ebp
    113a:	c3                   	ret    
    113b:	eb 01                	jmp    113e <uthread_yield+0xff>
    }
    else
    {
      POP_ALL_REGISTERS();
    113d:	61                   	popa   
    }
  }
}
    113e:	c9                   	leave  
    113f:	c3                   	ret    

00001140 <uthread_self>:

int
uthread_self(void)
{
    1140:	55                   	push   %ebp
    1141:	89 e5                	mov    %esp,%ebp
  return currentThread->tid;
    1143:	a1 60 61 00 00       	mov    0x6160,%eax
    1148:	8b 00                	mov    (%eax),%eax
    114a:	5d                   	pop    %ebp
    114b:	c3                   	ret    

0000114c <xchg>:
#include "fs.h"
#include "uthread.h"

static inline uint
xchg(volatile uint *addr, uint newval)
{
    114c:	55                   	push   %ebp
    114d:	89 e5                	mov    %esp,%ebp
    114f:	53                   	push   %ebx
    1150:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
               "+m" (*addr), "=a" (result) :
    1153:	8b 55 08             	mov    0x8(%ebp),%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
    1156:	8b 45 0c             	mov    0xc(%ebp),%eax
               "+m" (*addr), "=a" (result) :
    1159:	8b 4d 08             	mov    0x8(%ebp),%ecx
xchg(volatile uint *addr, uint newval)
{
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
    115c:	89 c3                	mov    %eax,%ebx
    115e:	89 d8                	mov    %ebx,%eax
    1160:	f0 87 02             	lock xchg %eax,(%edx)
    1163:	89 c3                	mov    %eax,%ebx
    1165:	89 5d f8             	mov    %ebx,-0x8(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
    1168:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
    116b:	83 c4 10             	add    $0x10,%esp
    116e:	5b                   	pop    %ebx
    116f:	5d                   	pop    %ebp
    1170:	c3                   	ret    

00001171 <binary_semaphore_init>:
semaphore->taken=0;
}*/

void
binary_semaphore_init(struct binary_semaphore* semaphore, int value)
{
    1171:	55                   	push   %ebp
    1172:	89 e5                	mov    %esp,%ebp
    1174:	83 ec 08             	sub    $0x8,%esp
  semaphore->init=0;
    1177:	8b 45 08             	mov    0x8(%ebp),%eax
    117a:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
  
  if(value!=0)
    1181:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1185:	74 0c                	je     1193 <binary_semaphore_init+0x22>
    semaphore->thread=-1;
    1187:	8b 45 08             	mov    0x8(%ebp),%eax
    118a:	c7 40 04 ff ff ff ff 	movl   $0xffffffff,0x4(%eax)
    1191:	eb 0b                	jmp    119e <binary_semaphore_init+0x2d>
  else 
    semaphore->thread = uthread_self();
    1193:	e8 a8 ff ff ff       	call   1140 <uthread_self>
    1198:	8b 55 08             	mov    0x8(%ebp),%edx
    119b:	89 42 04             	mov    %eax,0x4(%edx)
  
  semaphore->locked = value;
    119e:	8b 55 0c             	mov    0xc(%ebp),%edx
    11a1:	8b 45 08             	mov    0x8(%ebp),%eax
    11a4:	89 10                	mov    %edx,(%eax)
 // semaphore->taken=0;
  semaphore->init=1;
    11a6:	8b 45 08             	mov    0x8(%ebp),%eax
    11a9:	c7 40 08 01 00 00 00 	movl   $0x1,0x8(%eax)
  
}
    11b0:	c9                   	leave  
    11b1:	c3                   	ret    

000011b2 <binary_semaphore_down>:

void 
binary_semaphore_down(struct binary_semaphore* semaphore)
{
    11b2:	55                   	push   %ebp
    11b3:	89 e5                	mov    %esp,%ebp
    11b5:	83 ec 28             	sub    $0x28,%esp
  //semaphore_acquire(semaphore);
  if(semaphore->init==0)
    11b8:	8b 45 08             	mov    0x8(%ebp),%eax
    11bb:	8b 40 08             	mov    0x8(%eax),%eax
    11be:	85 c0                	test   %eax,%eax
    11c0:	75 20                	jne    11e2 <binary_semaphore_down+0x30>
  {
   printf(1,"(down)semaphore uninitialized yet (thread %d)\n",semaphore->thread);
    11c2:	8b 45 08             	mov    0x8(%ebp),%eax
    11c5:	8b 40 04             	mov    0x4(%eax),%eax
    11c8:	89 44 24 08          	mov    %eax,0x8(%esp)
    11cc:	c7 44 24 04 60 13 00 	movl   $0x1360,0x4(%esp)
    11d3:	00 
    11d4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    11db:	e8 87 f5 ff ff       	call   767 <printf>
    return;
    11e0:	eb 3a                	jmp    121c <binary_semaphore_down+0x6a>
  }
  
  
  int i= uthread_self();
    11e2:	e8 59 ff ff ff       	call   1140 <uthread_self>
    11e7:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(semaphore->thread!=i)
    11ea:	8b 45 08             	mov    0x8(%ebp),%eax
    11ed:	8b 40 04             	mov    0x4(%eax),%eax
    11f0:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    11f3:	74 27                	je     121c <binary_semaphore_down+0x6a>
  {
    while(xchg(&semaphore->locked, 0) == 0) //means the semaphore is taken allready
    11f5:	eb 05                	jmp    11fc <binary_semaphore_down+0x4a>
    {
      uthread_yield();
    11f7:	e8 43 fe ff ff       	call   103f <uthread_yield>
  
  
  int i= uthread_self();
  if(semaphore->thread!=i)
  {
    while(xchg(&semaphore->locked, 0) == 0) //means the semaphore is taken allready
    11fc:	8b 45 08             	mov    0x8(%ebp),%eax
    11ff:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1206:	00 
    1207:	89 04 24             	mov    %eax,(%esp)
    120a:	e8 3d ff ff ff       	call   114c <xchg>
    120f:	85 c0                	test   %eax,%eax
    1211:	74 e4                	je     11f7 <binary_semaphore_down+0x45>
    {
      uthread_yield();
    }
    semaphore->thread = i;
    1213:	8b 45 08             	mov    0x8(%ebp),%eax
    1216:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1219:	89 50 04             	mov    %edx,0x4(%eax)
  }
  //semaphore_release(semaphore);
}
    121c:	c9                   	leave  
    121d:	c3                   	ret    

0000121e <binary_semaphore_up>:

void 
binary_semaphore_up(struct binary_semaphore* semaphore)
{
    121e:	55                   	push   %ebp
    121f:	89 e5                	mov    %esp,%ebp
    1221:	83 ec 28             	sub    $0x28,%esp
  //semaphore_acquire(semaphore);
    if(semaphore->init==0)
    1224:	8b 45 08             	mov    0x8(%ebp),%eax
    1227:	8b 40 08             	mov    0x8(%eax),%eax
    122a:	85 c0                	test   %eax,%eax
    122c:	75 20                	jne    124e <binary_semaphore_up+0x30>
    {
    printf(1,"(up)semaphore uninitialized yet (thread %d)\n",semaphore->thread);
    122e:	8b 45 08             	mov    0x8(%ebp),%eax
    1231:	8b 40 04             	mov    0x4(%eax),%eax
    1234:	89 44 24 08          	mov    %eax,0x8(%esp)
    1238:	c7 44 24 04 90 13 00 	movl   $0x1390,0x4(%esp)
    123f:	00 
    1240:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1247:	e8 1b f5 ff ff       	call   767 <printf>
    return;
    124c:	eb 2f                	jmp    127d <binary_semaphore_up+0x5f>
    }
  
  int i= uthread_self();
    124e:	e8 ed fe ff ff       	call   1140 <uthread_self>
    1253:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if( semaphore->locked == 0 && semaphore->thread == i)
    1256:	8b 45 08             	mov    0x8(%ebp),%eax
    1259:	8b 00                	mov    (%eax),%eax
    125b:	85 c0                	test   %eax,%eax
    125d:	75 1e                	jne    127d <binary_semaphore_up+0x5f>
    125f:	8b 45 08             	mov    0x8(%ebp),%eax
    1262:	8b 40 04             	mov    0x4(%eax),%eax
    1265:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1268:	75 13                	jne    127d <binary_semaphore_up+0x5f>
  {
      semaphore->thread = -1;
    126a:	8b 45 08             	mov    0x8(%ebp),%eax
    126d:	c7 40 04 ff ff ff ff 	movl   $0xffffffff,0x4(%eax)
      semaphore->locked = 1;
    1274:	8b 45 08             	mov    0x8(%ebp),%eax
    1277:	c7 00 01 00 00 00    	movl   $0x1,(%eax)

  }
//semaphore_release(semaphore);
    127d:	c9                   	leave  
    127e:	c3                   	ret    
