
_grep:     file format elf32-i386


Disassembly of section .text:

00000000 <grep>:
char buf[1024];
int match(char*, char*);

void
grep(char *pattern, int fd)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 ec 28             	sub    $0x28,%esp
  int n, m;
  char *p, *q;
  
  m = 0;
   6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  while((n = read(fd, buf+m, sizeof(buf)-m)) > 0){
   d:	e9 bf 00 00 00       	jmp    d1 <grep+0xd1>
    m += n;
  12:	8b 45 ec             	mov    -0x14(%ebp),%eax
  15:	01 45 f4             	add    %eax,-0xc(%ebp)
    p = buf;
  18:	c7 45 f0 60 5a 00 00 	movl   $0x5a60,-0x10(%ebp)
    while((q = strchr(p, '\n')) != 0){
  1f:	eb 53                	jmp    74 <grep+0x74>
      *q = 0;
  21:	8b 45 e8             	mov    -0x18(%ebp),%eax
  24:	c6 00 00             	movb   $0x0,(%eax)
      if(match(pattern, p)){
  27:	8b 45 f0             	mov    -0x10(%ebp),%eax
  2a:	89 44 24 04          	mov    %eax,0x4(%esp)
  2e:	8b 45 08             	mov    0x8(%ebp),%eax
  31:	89 04 24             	mov    %eax,(%esp)
  34:	e8 af 01 00 00       	call   1e8 <match>
  39:	85 c0                	test   %eax,%eax
  3b:	74 2e                	je     6b <grep+0x6b>
        *q = '\n';
  3d:	8b 45 e8             	mov    -0x18(%ebp),%eax
  40:	c6 00 0a             	movb   $0xa,(%eax)
        write(1, p, q+1 - p);
  43:	8b 45 e8             	mov    -0x18(%ebp),%eax
  46:	83 c0 01             	add    $0x1,%eax
  49:	89 c2                	mov    %eax,%edx
  4b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  4e:	89 d1                	mov    %edx,%ecx
  50:	29 c1                	sub    %eax,%ecx
  52:	89 c8                	mov    %ecx,%eax
  54:	89 44 24 08          	mov    %eax,0x8(%esp)
  58:	8b 45 f0             	mov    -0x10(%ebp),%eax
  5b:	89 44 24 04          	mov    %eax,0x4(%esp)
  5f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  66:	e8 69 05 00 00       	call   5d4 <write>
      }
      p = q+1;
  6b:	8b 45 e8             	mov    -0x18(%ebp),%eax
  6e:	83 c0 01             	add    $0x1,%eax
  71:	89 45 f0             	mov    %eax,-0x10(%ebp)
  
  m = 0;
  while((n = read(fd, buf+m, sizeof(buf)-m)) > 0){
    m += n;
    p = buf;
    while((q = strchr(p, '\n')) != 0){
  74:	c7 44 24 04 0a 00 00 	movl   $0xa,0x4(%esp)
  7b:	00 
  7c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  7f:	89 04 24             	mov    %eax,(%esp)
  82:	e8 ac 03 00 00       	call   433 <strchr>
  87:	89 45 e8             	mov    %eax,-0x18(%ebp)
  8a:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  8e:	75 91                	jne    21 <grep+0x21>
        *q = '\n';
        write(1, p, q+1 - p);
      }
      p = q+1;
    }
    if(p == buf)
  90:	81 7d f0 60 5a 00 00 	cmpl   $0x5a60,-0x10(%ebp)
  97:	75 07                	jne    a0 <grep+0xa0>
      m = 0;
  99:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(m > 0){
  a0:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  a4:	7e 2b                	jle    d1 <grep+0xd1>
      m -= p - buf;
  a6:	ba 60 5a 00 00       	mov    $0x5a60,%edx
  ab:	8b 45 f0             	mov    -0x10(%ebp),%eax
  ae:	89 d1                	mov    %edx,%ecx
  b0:	29 c1                	sub    %eax,%ecx
  b2:	89 c8                	mov    %ecx,%eax
  b4:	01 45 f4             	add    %eax,-0xc(%ebp)
      memmove(buf, p, m);
  b7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  ba:	89 44 24 08          	mov    %eax,0x8(%esp)
  be:	8b 45 f0             	mov    -0x10(%ebp),%eax
  c1:	89 44 24 04          	mov    %eax,0x4(%esp)
  c5:	c7 04 24 60 5a 00 00 	movl   $0x5a60,(%esp)
  cc:	e8 9d 04 00 00       	call   56e <memmove>
{
  int n, m;
  char *p, *q;
  
  m = 0;
  while((n = read(fd, buf+m, sizeof(buf)-m)) > 0){
  d1:	8b 45 f4             	mov    -0xc(%ebp),%eax
  d4:	ba 00 04 00 00       	mov    $0x400,%edx
  d9:	89 d1                	mov    %edx,%ecx
  db:	29 c1                	sub    %eax,%ecx
  dd:	89 c8                	mov    %ecx,%eax
  df:	8b 55 f4             	mov    -0xc(%ebp),%edx
  e2:	81 c2 60 5a 00 00    	add    $0x5a60,%edx
  e8:	89 44 24 08          	mov    %eax,0x8(%esp)
  ec:	89 54 24 04          	mov    %edx,0x4(%esp)
  f0:	8b 45 0c             	mov    0xc(%ebp),%eax
  f3:	89 04 24             	mov    %eax,(%esp)
  f6:	e8 d1 04 00 00       	call   5cc <read>
  fb:	89 45 ec             	mov    %eax,-0x14(%ebp)
  fe:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 102:	0f 8f 0a ff ff ff    	jg     12 <grep+0x12>
    if(m > 0){
      m -= p - buf;
      memmove(buf, p, m);
    }
  }
}
 108:	c9                   	leave  
 109:	c3                   	ret    

0000010a <main>:

int
main(int argc, char *argv[])
{
 10a:	55                   	push   %ebp
 10b:	89 e5                	mov    %esp,%ebp
 10d:	83 e4 f0             	and    $0xfffffff0,%esp
 110:	83 ec 20             	sub    $0x20,%esp
  int fd, i;
  char *pattern;
  
  if(argc <= 1){
 113:	83 7d 08 01          	cmpl   $0x1,0x8(%ebp)
 117:	7f 19                	jg     132 <main+0x28>
    printf(2, "usage: grep pattern [file ...]\n");
 119:	c7 44 24 04 8c 0f 00 	movl   $0xf8c,0x4(%esp)
 120:	00 
 121:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
 128:	e8 36 06 00 00       	call   763 <printf>
    exit();
 12d:	e8 82 04 00 00       	call   5b4 <exit>
  }
  pattern = argv[1];
 132:	8b 45 0c             	mov    0xc(%ebp),%eax
 135:	8b 40 04             	mov    0x4(%eax),%eax
 138:	89 44 24 18          	mov    %eax,0x18(%esp)
  
  if(argc <= 2){
 13c:	83 7d 08 02          	cmpl   $0x2,0x8(%ebp)
 140:	7f 19                	jg     15b <main+0x51>
    grep(pattern, 0);
 142:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 149:	00 
 14a:	8b 44 24 18          	mov    0x18(%esp),%eax
 14e:	89 04 24             	mov    %eax,(%esp)
 151:	e8 aa fe ff ff       	call   0 <grep>
    exit();
 156:	e8 59 04 00 00       	call   5b4 <exit>
  }

  for(i = 2; i < argc; i++){
 15b:	c7 44 24 1c 02 00 00 	movl   $0x2,0x1c(%esp)
 162:	00 
 163:	eb 75                	jmp    1da <main+0xd0>
    if((fd = open(argv[i], 0)) < 0){
 165:	8b 44 24 1c          	mov    0x1c(%esp),%eax
 169:	c1 e0 02             	shl    $0x2,%eax
 16c:	03 45 0c             	add    0xc(%ebp),%eax
 16f:	8b 00                	mov    (%eax),%eax
 171:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 178:	00 
 179:	89 04 24             	mov    %eax,(%esp)
 17c:	e8 73 04 00 00       	call   5f4 <open>
 181:	89 44 24 14          	mov    %eax,0x14(%esp)
 185:	83 7c 24 14 00       	cmpl   $0x0,0x14(%esp)
 18a:	79 29                	jns    1b5 <main+0xab>
      printf(1, "grep: cannot open %s\n", argv[i]);
 18c:	8b 44 24 1c          	mov    0x1c(%esp),%eax
 190:	c1 e0 02             	shl    $0x2,%eax
 193:	03 45 0c             	add    0xc(%ebp),%eax
 196:	8b 00                	mov    (%eax),%eax
 198:	89 44 24 08          	mov    %eax,0x8(%esp)
 19c:	c7 44 24 04 ac 0f 00 	movl   $0xfac,0x4(%esp)
 1a3:	00 
 1a4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 1ab:	e8 b3 05 00 00       	call   763 <printf>
      exit();
 1b0:	e8 ff 03 00 00       	call   5b4 <exit>
    }
    grep(pattern, fd);
 1b5:	8b 44 24 14          	mov    0x14(%esp),%eax
 1b9:	89 44 24 04          	mov    %eax,0x4(%esp)
 1bd:	8b 44 24 18          	mov    0x18(%esp),%eax
 1c1:	89 04 24             	mov    %eax,(%esp)
 1c4:	e8 37 fe ff ff       	call   0 <grep>
    close(fd);
 1c9:	8b 44 24 14          	mov    0x14(%esp),%eax
 1cd:	89 04 24             	mov    %eax,(%esp)
 1d0:	e8 07 04 00 00       	call   5dc <close>
  if(argc <= 2){
    grep(pattern, 0);
    exit();
  }

  for(i = 2; i < argc; i++){
 1d5:	83 44 24 1c 01       	addl   $0x1,0x1c(%esp)
 1da:	8b 44 24 1c          	mov    0x1c(%esp),%eax
 1de:	3b 45 08             	cmp    0x8(%ebp),%eax
 1e1:	7c 82                	jl     165 <main+0x5b>
      exit();
    }
    grep(pattern, fd);
    close(fd);
  }
  exit();
 1e3:	e8 cc 03 00 00       	call   5b4 <exit>

000001e8 <match>:
int matchhere(char*, char*);
int matchstar(int, char*, char*);

int
match(char *re, char *text)
{
 1e8:	55                   	push   %ebp
 1e9:	89 e5                	mov    %esp,%ebp
 1eb:	83 ec 18             	sub    $0x18,%esp
  if(re[0] == '^')
 1ee:	8b 45 08             	mov    0x8(%ebp),%eax
 1f1:	0f b6 00             	movzbl (%eax),%eax
 1f4:	3c 5e                	cmp    $0x5e,%al
 1f6:	75 17                	jne    20f <match+0x27>
    return matchhere(re+1, text);
 1f8:	8b 45 08             	mov    0x8(%ebp),%eax
 1fb:	8d 50 01             	lea    0x1(%eax),%edx
 1fe:	8b 45 0c             	mov    0xc(%ebp),%eax
 201:	89 44 24 04          	mov    %eax,0x4(%esp)
 205:	89 14 24             	mov    %edx,(%esp)
 208:	e8 39 00 00 00       	call   246 <matchhere>
 20d:	eb 35                	jmp    244 <match+0x5c>
  do{  // must look at empty string
    if(matchhere(re, text))
 20f:	8b 45 0c             	mov    0xc(%ebp),%eax
 212:	89 44 24 04          	mov    %eax,0x4(%esp)
 216:	8b 45 08             	mov    0x8(%ebp),%eax
 219:	89 04 24             	mov    %eax,(%esp)
 21c:	e8 25 00 00 00       	call   246 <matchhere>
 221:	85 c0                	test   %eax,%eax
 223:	74 07                	je     22c <match+0x44>
      return 1;
 225:	b8 01 00 00 00       	mov    $0x1,%eax
 22a:	eb 18                	jmp    244 <match+0x5c>
  }while(*text++ != '\0');
 22c:	8b 45 0c             	mov    0xc(%ebp),%eax
 22f:	0f b6 00             	movzbl (%eax),%eax
 232:	84 c0                	test   %al,%al
 234:	0f 95 c0             	setne  %al
 237:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
 23b:	84 c0                	test   %al,%al
 23d:	75 d0                	jne    20f <match+0x27>
  return 0;
 23f:	b8 00 00 00 00       	mov    $0x0,%eax
}
 244:	c9                   	leave  
 245:	c3                   	ret    

00000246 <matchhere>:

// matchhere: search for re at beginning of text
int matchhere(char *re, char *text)
{
 246:	55                   	push   %ebp
 247:	89 e5                	mov    %esp,%ebp
 249:	83 ec 18             	sub    $0x18,%esp
  if(re[0] == '\0')
 24c:	8b 45 08             	mov    0x8(%ebp),%eax
 24f:	0f b6 00             	movzbl (%eax),%eax
 252:	84 c0                	test   %al,%al
 254:	75 0a                	jne    260 <matchhere+0x1a>
    return 1;
 256:	b8 01 00 00 00       	mov    $0x1,%eax
 25b:	e9 9b 00 00 00       	jmp    2fb <matchhere+0xb5>
  if(re[1] == '*')
 260:	8b 45 08             	mov    0x8(%ebp),%eax
 263:	83 c0 01             	add    $0x1,%eax
 266:	0f b6 00             	movzbl (%eax),%eax
 269:	3c 2a                	cmp    $0x2a,%al
 26b:	75 24                	jne    291 <matchhere+0x4b>
    return matchstar(re[0], re+2, text);
 26d:	8b 45 08             	mov    0x8(%ebp),%eax
 270:	8d 48 02             	lea    0x2(%eax),%ecx
 273:	8b 45 08             	mov    0x8(%ebp),%eax
 276:	0f b6 00             	movzbl (%eax),%eax
 279:	0f be c0             	movsbl %al,%eax
 27c:	8b 55 0c             	mov    0xc(%ebp),%edx
 27f:	89 54 24 08          	mov    %edx,0x8(%esp)
 283:	89 4c 24 04          	mov    %ecx,0x4(%esp)
 287:	89 04 24             	mov    %eax,(%esp)
 28a:	e8 6e 00 00 00       	call   2fd <matchstar>
 28f:	eb 6a                	jmp    2fb <matchhere+0xb5>
  if(re[0] == '$' && re[1] == '\0')
 291:	8b 45 08             	mov    0x8(%ebp),%eax
 294:	0f b6 00             	movzbl (%eax),%eax
 297:	3c 24                	cmp    $0x24,%al
 299:	75 1d                	jne    2b8 <matchhere+0x72>
 29b:	8b 45 08             	mov    0x8(%ebp),%eax
 29e:	83 c0 01             	add    $0x1,%eax
 2a1:	0f b6 00             	movzbl (%eax),%eax
 2a4:	84 c0                	test   %al,%al
 2a6:	75 10                	jne    2b8 <matchhere+0x72>
    return *text == '\0';
 2a8:	8b 45 0c             	mov    0xc(%ebp),%eax
 2ab:	0f b6 00             	movzbl (%eax),%eax
 2ae:	84 c0                	test   %al,%al
 2b0:	0f 94 c0             	sete   %al
 2b3:	0f b6 c0             	movzbl %al,%eax
 2b6:	eb 43                	jmp    2fb <matchhere+0xb5>
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
 2b8:	8b 45 0c             	mov    0xc(%ebp),%eax
 2bb:	0f b6 00             	movzbl (%eax),%eax
 2be:	84 c0                	test   %al,%al
 2c0:	74 34                	je     2f6 <matchhere+0xb0>
 2c2:	8b 45 08             	mov    0x8(%ebp),%eax
 2c5:	0f b6 00             	movzbl (%eax),%eax
 2c8:	3c 2e                	cmp    $0x2e,%al
 2ca:	74 10                	je     2dc <matchhere+0x96>
 2cc:	8b 45 08             	mov    0x8(%ebp),%eax
 2cf:	0f b6 10             	movzbl (%eax),%edx
 2d2:	8b 45 0c             	mov    0xc(%ebp),%eax
 2d5:	0f b6 00             	movzbl (%eax),%eax
 2d8:	38 c2                	cmp    %al,%dl
 2da:	75 1a                	jne    2f6 <matchhere+0xb0>
    return matchhere(re+1, text+1);
 2dc:	8b 45 0c             	mov    0xc(%ebp),%eax
 2df:	8d 50 01             	lea    0x1(%eax),%edx
 2e2:	8b 45 08             	mov    0x8(%ebp),%eax
 2e5:	83 c0 01             	add    $0x1,%eax
 2e8:	89 54 24 04          	mov    %edx,0x4(%esp)
 2ec:	89 04 24             	mov    %eax,(%esp)
 2ef:	e8 52 ff ff ff       	call   246 <matchhere>
 2f4:	eb 05                	jmp    2fb <matchhere+0xb5>
  return 0;
 2f6:	b8 00 00 00 00       	mov    $0x0,%eax
}
 2fb:	c9                   	leave  
 2fc:	c3                   	ret    

000002fd <matchstar>:

// matchstar: search for c*re at beginning of text
int matchstar(int c, char *re, char *text)
{
 2fd:	55                   	push   %ebp
 2fe:	89 e5                	mov    %esp,%ebp
 300:	83 ec 18             	sub    $0x18,%esp
  do{  // a * matches zero or more instances
    if(matchhere(re, text))
 303:	8b 45 10             	mov    0x10(%ebp),%eax
 306:	89 44 24 04          	mov    %eax,0x4(%esp)
 30a:	8b 45 0c             	mov    0xc(%ebp),%eax
 30d:	89 04 24             	mov    %eax,(%esp)
 310:	e8 31 ff ff ff       	call   246 <matchhere>
 315:	85 c0                	test   %eax,%eax
 317:	74 07                	je     320 <matchstar+0x23>
      return 1;
 319:	b8 01 00 00 00       	mov    $0x1,%eax
 31e:	eb 2c                	jmp    34c <matchstar+0x4f>
  }while(*text!='\0' && (*text++==c || c=='.'));
 320:	8b 45 10             	mov    0x10(%ebp),%eax
 323:	0f b6 00             	movzbl (%eax),%eax
 326:	84 c0                	test   %al,%al
 328:	74 1d                	je     347 <matchstar+0x4a>
 32a:	8b 45 10             	mov    0x10(%ebp),%eax
 32d:	0f b6 00             	movzbl (%eax),%eax
 330:	0f be c0             	movsbl %al,%eax
 333:	3b 45 08             	cmp    0x8(%ebp),%eax
 336:	0f 94 c0             	sete   %al
 339:	83 45 10 01          	addl   $0x1,0x10(%ebp)
 33d:	84 c0                	test   %al,%al
 33f:	75 c2                	jne    303 <matchstar+0x6>
 341:	83 7d 08 2e          	cmpl   $0x2e,0x8(%ebp)
 345:	74 bc                	je     303 <matchstar+0x6>
  return 0;
 347:	b8 00 00 00 00       	mov    $0x0,%eax
}
 34c:	c9                   	leave  
 34d:	c3                   	ret    
 34e:	90                   	nop
 34f:	90                   	nop

00000350 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 350:	55                   	push   %ebp
 351:	89 e5                	mov    %esp,%ebp
 353:	57                   	push   %edi
 354:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
 355:	8b 4d 08             	mov    0x8(%ebp),%ecx
 358:	8b 55 10             	mov    0x10(%ebp),%edx
 35b:	8b 45 0c             	mov    0xc(%ebp),%eax
 35e:	89 cb                	mov    %ecx,%ebx
 360:	89 df                	mov    %ebx,%edi
 362:	89 d1                	mov    %edx,%ecx
 364:	fc                   	cld    
 365:	f3 aa                	rep stos %al,%es:(%edi)
 367:	89 ca                	mov    %ecx,%edx
 369:	89 fb                	mov    %edi,%ebx
 36b:	89 5d 08             	mov    %ebx,0x8(%ebp)
 36e:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 371:	5b                   	pop    %ebx
 372:	5f                   	pop    %edi
 373:	5d                   	pop    %ebp
 374:	c3                   	ret    

00000375 <strcpy>:
#include "x86.h"


char*
strcpy(char *s, char *t)
{
 375:	55                   	push   %ebp
 376:	89 e5                	mov    %esp,%ebp
 378:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
 37b:	8b 45 08             	mov    0x8(%ebp),%eax
 37e:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 381:	90                   	nop
 382:	8b 45 0c             	mov    0xc(%ebp),%eax
 385:	0f b6 10             	movzbl (%eax),%edx
 388:	8b 45 08             	mov    0x8(%ebp),%eax
 38b:	88 10                	mov    %dl,(%eax)
 38d:	8b 45 08             	mov    0x8(%ebp),%eax
 390:	0f b6 00             	movzbl (%eax),%eax
 393:	84 c0                	test   %al,%al
 395:	0f 95 c0             	setne  %al
 398:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 39c:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
 3a0:	84 c0                	test   %al,%al
 3a2:	75 de                	jne    382 <strcpy+0xd>
    ;
  return os;
 3a4:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 3a7:	c9                   	leave  
 3a8:	c3                   	ret    

000003a9 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 3a9:	55                   	push   %ebp
 3aa:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 3ac:	eb 08                	jmp    3b6 <strcmp+0xd>
    p++, q++;
 3ae:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 3b2:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 3b6:	8b 45 08             	mov    0x8(%ebp),%eax
 3b9:	0f b6 00             	movzbl (%eax),%eax
 3bc:	84 c0                	test   %al,%al
 3be:	74 10                	je     3d0 <strcmp+0x27>
 3c0:	8b 45 08             	mov    0x8(%ebp),%eax
 3c3:	0f b6 10             	movzbl (%eax),%edx
 3c6:	8b 45 0c             	mov    0xc(%ebp),%eax
 3c9:	0f b6 00             	movzbl (%eax),%eax
 3cc:	38 c2                	cmp    %al,%dl
 3ce:	74 de                	je     3ae <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 3d0:	8b 45 08             	mov    0x8(%ebp),%eax
 3d3:	0f b6 00             	movzbl (%eax),%eax
 3d6:	0f b6 d0             	movzbl %al,%edx
 3d9:	8b 45 0c             	mov    0xc(%ebp),%eax
 3dc:	0f b6 00             	movzbl (%eax),%eax
 3df:	0f b6 c0             	movzbl %al,%eax
 3e2:	89 d1                	mov    %edx,%ecx
 3e4:	29 c1                	sub    %eax,%ecx
 3e6:	89 c8                	mov    %ecx,%eax
}
 3e8:	5d                   	pop    %ebp
 3e9:	c3                   	ret    

000003ea <strlen>:

uint
strlen(char *s)
{
 3ea:	55                   	push   %ebp
 3eb:	89 e5                	mov    %esp,%ebp
 3ed:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 3f0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 3f7:	eb 04                	jmp    3fd <strlen+0x13>
 3f9:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 3fd:	8b 45 fc             	mov    -0x4(%ebp),%eax
 400:	03 45 08             	add    0x8(%ebp),%eax
 403:	0f b6 00             	movzbl (%eax),%eax
 406:	84 c0                	test   %al,%al
 408:	75 ef                	jne    3f9 <strlen+0xf>
    ;
  return n;
 40a:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 40d:	c9                   	leave  
 40e:	c3                   	ret    

0000040f <memset>:

void*
memset(void *dst, int c, uint n)
{
 40f:	55                   	push   %ebp
 410:	89 e5                	mov    %esp,%ebp
 412:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
 415:	8b 45 10             	mov    0x10(%ebp),%eax
 418:	89 44 24 08          	mov    %eax,0x8(%esp)
 41c:	8b 45 0c             	mov    0xc(%ebp),%eax
 41f:	89 44 24 04          	mov    %eax,0x4(%esp)
 423:	8b 45 08             	mov    0x8(%ebp),%eax
 426:	89 04 24             	mov    %eax,(%esp)
 429:	e8 22 ff ff ff       	call   350 <stosb>
  return dst;
 42e:	8b 45 08             	mov    0x8(%ebp),%eax
}
 431:	c9                   	leave  
 432:	c3                   	ret    

00000433 <strchr>:

char*
strchr(const char *s, char c)
{
 433:	55                   	push   %ebp
 434:	89 e5                	mov    %esp,%ebp
 436:	83 ec 04             	sub    $0x4,%esp
 439:	8b 45 0c             	mov    0xc(%ebp),%eax
 43c:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 43f:	eb 14                	jmp    455 <strchr+0x22>
    if(*s == c)
 441:	8b 45 08             	mov    0x8(%ebp),%eax
 444:	0f b6 00             	movzbl (%eax),%eax
 447:	3a 45 fc             	cmp    -0x4(%ebp),%al
 44a:	75 05                	jne    451 <strchr+0x1e>
      return (char*)s;
 44c:	8b 45 08             	mov    0x8(%ebp),%eax
 44f:	eb 13                	jmp    464 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 451:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 455:	8b 45 08             	mov    0x8(%ebp),%eax
 458:	0f b6 00             	movzbl (%eax),%eax
 45b:	84 c0                	test   %al,%al
 45d:	75 e2                	jne    441 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 45f:	b8 00 00 00 00       	mov    $0x0,%eax
}
 464:	c9                   	leave  
 465:	c3                   	ret    

00000466 <gets>:

char*
gets(char *buf, int max)
{
 466:	55                   	push   %ebp
 467:	89 e5                	mov    %esp,%ebp
 469:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 46c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 473:	eb 44                	jmp    4b9 <gets+0x53>
    cc = read(0, &c, 1);
 475:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 47c:	00 
 47d:	8d 45 ef             	lea    -0x11(%ebp),%eax
 480:	89 44 24 04          	mov    %eax,0x4(%esp)
 484:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 48b:	e8 3c 01 00 00       	call   5cc <read>
 490:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 493:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 497:	7e 2d                	jle    4c6 <gets+0x60>
      break;
    buf[i++] = c;
 499:	8b 45 f4             	mov    -0xc(%ebp),%eax
 49c:	03 45 08             	add    0x8(%ebp),%eax
 49f:	0f b6 55 ef          	movzbl -0x11(%ebp),%edx
 4a3:	88 10                	mov    %dl,(%eax)
 4a5:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    if(c == '\n' || c == '\r')
 4a9:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 4ad:	3c 0a                	cmp    $0xa,%al
 4af:	74 16                	je     4c7 <gets+0x61>
 4b1:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 4b5:	3c 0d                	cmp    $0xd,%al
 4b7:	74 0e                	je     4c7 <gets+0x61>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 4b9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 4bc:	83 c0 01             	add    $0x1,%eax
 4bf:	3b 45 0c             	cmp    0xc(%ebp),%eax
 4c2:	7c b1                	jl     475 <gets+0xf>
 4c4:	eb 01                	jmp    4c7 <gets+0x61>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
 4c6:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 4c7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 4ca:	03 45 08             	add    0x8(%ebp),%eax
 4cd:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 4d0:	8b 45 08             	mov    0x8(%ebp),%eax
}
 4d3:	c9                   	leave  
 4d4:	c3                   	ret    

000004d5 <stat>:

int
stat(char *n, struct stat *st)
{
 4d5:	55                   	push   %ebp
 4d6:	89 e5                	mov    %esp,%ebp
 4d8:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 4db:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 4e2:	00 
 4e3:	8b 45 08             	mov    0x8(%ebp),%eax
 4e6:	89 04 24             	mov    %eax,(%esp)
 4e9:	e8 06 01 00 00       	call   5f4 <open>
 4ee:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 4f1:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 4f5:	79 07                	jns    4fe <stat+0x29>
    return -1;
 4f7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 4fc:	eb 23                	jmp    521 <stat+0x4c>
  r = fstat(fd, st);
 4fe:	8b 45 0c             	mov    0xc(%ebp),%eax
 501:	89 44 24 04          	mov    %eax,0x4(%esp)
 505:	8b 45 f4             	mov    -0xc(%ebp),%eax
 508:	89 04 24             	mov    %eax,(%esp)
 50b:	e8 fc 00 00 00       	call   60c <fstat>
 510:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 513:	8b 45 f4             	mov    -0xc(%ebp),%eax
 516:	89 04 24             	mov    %eax,(%esp)
 519:	e8 be 00 00 00       	call   5dc <close>
  return r;
 51e:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 521:	c9                   	leave  
 522:	c3                   	ret    

00000523 <atoi>:

int
atoi(const char *s)
{
 523:	55                   	push   %ebp
 524:	89 e5                	mov    %esp,%ebp
 526:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 529:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 530:	eb 23                	jmp    555 <atoi+0x32>
    n = n*10 + *s++ - '0';
 532:	8b 55 fc             	mov    -0x4(%ebp),%edx
 535:	89 d0                	mov    %edx,%eax
 537:	c1 e0 02             	shl    $0x2,%eax
 53a:	01 d0                	add    %edx,%eax
 53c:	01 c0                	add    %eax,%eax
 53e:	89 c2                	mov    %eax,%edx
 540:	8b 45 08             	mov    0x8(%ebp),%eax
 543:	0f b6 00             	movzbl (%eax),%eax
 546:	0f be c0             	movsbl %al,%eax
 549:	01 d0                	add    %edx,%eax
 54b:	83 e8 30             	sub    $0x30,%eax
 54e:	89 45 fc             	mov    %eax,-0x4(%ebp)
 551:	83 45 08 01          	addl   $0x1,0x8(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 555:	8b 45 08             	mov    0x8(%ebp),%eax
 558:	0f b6 00             	movzbl (%eax),%eax
 55b:	3c 2f                	cmp    $0x2f,%al
 55d:	7e 0a                	jle    569 <atoi+0x46>
 55f:	8b 45 08             	mov    0x8(%ebp),%eax
 562:	0f b6 00             	movzbl (%eax),%eax
 565:	3c 39                	cmp    $0x39,%al
 567:	7e c9                	jle    532 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 569:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 56c:	c9                   	leave  
 56d:	c3                   	ret    

0000056e <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 56e:	55                   	push   %ebp
 56f:	89 e5                	mov    %esp,%ebp
 571:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 574:	8b 45 08             	mov    0x8(%ebp),%eax
 577:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 57a:	8b 45 0c             	mov    0xc(%ebp),%eax
 57d:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 580:	eb 13                	jmp    595 <memmove+0x27>
    *dst++ = *src++;
 582:	8b 45 f8             	mov    -0x8(%ebp),%eax
 585:	0f b6 10             	movzbl (%eax),%edx
 588:	8b 45 fc             	mov    -0x4(%ebp),%eax
 58b:	88 10                	mov    %dl,(%eax)
 58d:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 591:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 595:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
 599:	0f 9f c0             	setg   %al
 59c:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
 5a0:	84 c0                	test   %al,%al
 5a2:	75 de                	jne    582 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 5a4:	8b 45 08             	mov    0x8(%ebp),%eax
}
 5a7:	c9                   	leave  
 5a8:	c3                   	ret    
 5a9:	90                   	nop
 5aa:	90                   	nop
 5ab:	90                   	nop

000005ac <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 5ac:	b8 01 00 00 00       	mov    $0x1,%eax
 5b1:	cd 40                	int    $0x40
 5b3:	c3                   	ret    

000005b4 <exit>:
SYSCALL(exit)
 5b4:	b8 02 00 00 00       	mov    $0x2,%eax
 5b9:	cd 40                	int    $0x40
 5bb:	c3                   	ret    

000005bc <wait>:
SYSCALL(wait)
 5bc:	b8 03 00 00 00       	mov    $0x3,%eax
 5c1:	cd 40                	int    $0x40
 5c3:	c3                   	ret    

000005c4 <pipe>:
SYSCALL(pipe)
 5c4:	b8 04 00 00 00       	mov    $0x4,%eax
 5c9:	cd 40                	int    $0x40
 5cb:	c3                   	ret    

000005cc <read>:
SYSCALL(read)
 5cc:	b8 05 00 00 00       	mov    $0x5,%eax
 5d1:	cd 40                	int    $0x40
 5d3:	c3                   	ret    

000005d4 <write>:
SYSCALL(write)
 5d4:	b8 10 00 00 00       	mov    $0x10,%eax
 5d9:	cd 40                	int    $0x40
 5db:	c3                   	ret    

000005dc <close>:
SYSCALL(close)
 5dc:	b8 15 00 00 00       	mov    $0x15,%eax
 5e1:	cd 40                	int    $0x40
 5e3:	c3                   	ret    

000005e4 <kill>:
SYSCALL(kill)
 5e4:	b8 06 00 00 00       	mov    $0x6,%eax
 5e9:	cd 40                	int    $0x40
 5eb:	c3                   	ret    

000005ec <exec>:
SYSCALL(exec)
 5ec:	b8 07 00 00 00       	mov    $0x7,%eax
 5f1:	cd 40                	int    $0x40
 5f3:	c3                   	ret    

000005f4 <open>:
SYSCALL(open)
 5f4:	b8 0f 00 00 00       	mov    $0xf,%eax
 5f9:	cd 40                	int    $0x40
 5fb:	c3                   	ret    

000005fc <mknod>:
SYSCALL(mknod)
 5fc:	b8 11 00 00 00       	mov    $0x11,%eax
 601:	cd 40                	int    $0x40
 603:	c3                   	ret    

00000604 <unlink>:
SYSCALL(unlink)
 604:	b8 12 00 00 00       	mov    $0x12,%eax
 609:	cd 40                	int    $0x40
 60b:	c3                   	ret    

0000060c <fstat>:
SYSCALL(fstat)
 60c:	b8 08 00 00 00       	mov    $0x8,%eax
 611:	cd 40                	int    $0x40
 613:	c3                   	ret    

00000614 <link>:
SYSCALL(link)
 614:	b8 13 00 00 00       	mov    $0x13,%eax
 619:	cd 40                	int    $0x40
 61b:	c3                   	ret    

0000061c <mkdir>:
SYSCALL(mkdir)
 61c:	b8 14 00 00 00       	mov    $0x14,%eax
 621:	cd 40                	int    $0x40
 623:	c3                   	ret    

00000624 <chdir>:
SYSCALL(chdir)
 624:	b8 09 00 00 00       	mov    $0x9,%eax
 629:	cd 40                	int    $0x40
 62b:	c3                   	ret    

0000062c <dup>:
SYSCALL(dup)
 62c:	b8 0a 00 00 00       	mov    $0xa,%eax
 631:	cd 40                	int    $0x40
 633:	c3                   	ret    

00000634 <getpid>:
SYSCALL(getpid)
 634:	b8 0b 00 00 00       	mov    $0xb,%eax
 639:	cd 40                	int    $0x40
 63b:	c3                   	ret    

0000063c <sbrk>:
SYSCALL(sbrk)
 63c:	b8 0c 00 00 00       	mov    $0xc,%eax
 641:	cd 40                	int    $0x40
 643:	c3                   	ret    

00000644 <sleep>:
SYSCALL(sleep)
 644:	b8 0d 00 00 00       	mov    $0xd,%eax
 649:	cd 40                	int    $0x40
 64b:	c3                   	ret    

0000064c <uptime>:
SYSCALL(uptime)
 64c:	b8 0e 00 00 00       	mov    $0xe,%eax
 651:	cd 40                	int    $0x40
 653:	c3                   	ret    

00000654 <add_path>:
SYSCALL(add_path)
 654:	b8 16 00 00 00       	mov    $0x16,%eax
 659:	cd 40                	int    $0x40
 65b:	c3                   	ret    

0000065c <wait2>:
SYSCALL(wait2)
 65c:	b8 17 00 00 00       	mov    $0x17,%eax
 661:	cd 40                	int    $0x40
 663:	c3                   	ret    

00000664 <getquanta>:
SYSCALL(getquanta)
 664:	b8 18 00 00 00       	mov    $0x18,%eax
 669:	cd 40                	int    $0x40
 66b:	c3                   	ret    

0000066c <getqueue>:
SYSCALL(getqueue)
 66c:	b8 19 00 00 00       	mov    $0x19,%eax
 671:	cd 40                	int    $0x40
 673:	c3                   	ret    

00000674 <signal>:
SYSCALL(signal)
 674:	b8 1a 00 00 00       	mov    $0x1a,%eax
 679:	cd 40                	int    $0x40
 67b:	c3                   	ret    

0000067c <sigsend>:
SYSCALL(sigsend)
 67c:	b8 1b 00 00 00       	mov    $0x1b,%eax
 681:	cd 40                	int    $0x40
 683:	c3                   	ret    

00000684 <alarm>:
SYSCALL(alarm)
 684:	b8 1c 00 00 00       	mov    $0x1c,%eax
 689:	cd 40                	int    $0x40
 68b:	c3                   	ret    

0000068c <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 68c:	55                   	push   %ebp
 68d:	89 e5                	mov    %esp,%ebp
 68f:	83 ec 28             	sub    $0x28,%esp
 692:	8b 45 0c             	mov    0xc(%ebp),%eax
 695:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 698:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 69f:	00 
 6a0:	8d 45 f4             	lea    -0xc(%ebp),%eax
 6a3:	89 44 24 04          	mov    %eax,0x4(%esp)
 6a7:	8b 45 08             	mov    0x8(%ebp),%eax
 6aa:	89 04 24             	mov    %eax,(%esp)
 6ad:	e8 22 ff ff ff       	call   5d4 <write>
}
 6b2:	c9                   	leave  
 6b3:	c3                   	ret    

000006b4 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 6b4:	55                   	push   %ebp
 6b5:	89 e5                	mov    %esp,%ebp
 6b7:	83 ec 48             	sub    $0x48,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 6ba:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 6c1:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 6c5:	74 17                	je     6de <printint+0x2a>
 6c7:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 6cb:	79 11                	jns    6de <printint+0x2a>
    neg = 1;
 6cd:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 6d4:	8b 45 0c             	mov    0xc(%ebp),%eax
 6d7:	f7 d8                	neg    %eax
 6d9:	89 45 ec             	mov    %eax,-0x14(%ebp)
 6dc:	eb 06                	jmp    6e4 <printint+0x30>
  } else {
    x = xx;
 6de:	8b 45 0c             	mov    0xc(%ebp),%eax
 6e1:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 6e4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 6eb:	8b 4d 10             	mov    0x10(%ebp),%ecx
 6ee:	8b 45 ec             	mov    -0x14(%ebp),%eax
 6f1:	ba 00 00 00 00       	mov    $0x0,%edx
 6f6:	f7 f1                	div    %ecx
 6f8:	89 d0                	mov    %edx,%eax
 6fa:	0f b6 90 fc 13 00 00 	movzbl 0x13fc(%eax),%edx
 701:	8d 45 dc             	lea    -0x24(%ebp),%eax
 704:	03 45 f4             	add    -0xc(%ebp),%eax
 707:	88 10                	mov    %dl,(%eax)
 709:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  }while((x /= base) != 0);
 70d:	8b 55 10             	mov    0x10(%ebp),%edx
 710:	89 55 d4             	mov    %edx,-0x2c(%ebp)
 713:	8b 45 ec             	mov    -0x14(%ebp),%eax
 716:	ba 00 00 00 00       	mov    $0x0,%edx
 71b:	f7 75 d4             	divl   -0x2c(%ebp)
 71e:	89 45 ec             	mov    %eax,-0x14(%ebp)
 721:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 725:	75 c4                	jne    6eb <printint+0x37>
  if(neg)
 727:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 72b:	74 2a                	je     757 <printint+0xa3>
    buf[i++] = '-';
 72d:	8d 45 dc             	lea    -0x24(%ebp),%eax
 730:	03 45 f4             	add    -0xc(%ebp),%eax
 733:	c6 00 2d             	movb   $0x2d,(%eax)
 736:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)

  while(--i >= 0)
 73a:	eb 1b                	jmp    757 <printint+0xa3>
    putc(fd, buf[i]);
 73c:	8d 45 dc             	lea    -0x24(%ebp),%eax
 73f:	03 45 f4             	add    -0xc(%ebp),%eax
 742:	0f b6 00             	movzbl (%eax),%eax
 745:	0f be c0             	movsbl %al,%eax
 748:	89 44 24 04          	mov    %eax,0x4(%esp)
 74c:	8b 45 08             	mov    0x8(%ebp),%eax
 74f:	89 04 24             	mov    %eax,(%esp)
 752:	e8 35 ff ff ff       	call   68c <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 757:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 75b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 75f:	79 db                	jns    73c <printint+0x88>
    putc(fd, buf[i]);
}
 761:	c9                   	leave  
 762:	c3                   	ret    

00000763 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 763:	55                   	push   %ebp
 764:	89 e5                	mov    %esp,%ebp
 766:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 769:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 770:	8d 45 0c             	lea    0xc(%ebp),%eax
 773:	83 c0 04             	add    $0x4,%eax
 776:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 779:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 780:	e9 7d 01 00 00       	jmp    902 <printf+0x19f>
    c = fmt[i] & 0xff;
 785:	8b 55 0c             	mov    0xc(%ebp),%edx
 788:	8b 45 f0             	mov    -0x10(%ebp),%eax
 78b:	01 d0                	add    %edx,%eax
 78d:	0f b6 00             	movzbl (%eax),%eax
 790:	0f be c0             	movsbl %al,%eax
 793:	25 ff 00 00 00       	and    $0xff,%eax
 798:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 79b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 79f:	75 2c                	jne    7cd <printf+0x6a>
      if(c == '%'){
 7a1:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 7a5:	75 0c                	jne    7b3 <printf+0x50>
        state = '%';
 7a7:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 7ae:	e9 4b 01 00 00       	jmp    8fe <printf+0x19b>
      } else {
        putc(fd, c);
 7b3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 7b6:	0f be c0             	movsbl %al,%eax
 7b9:	89 44 24 04          	mov    %eax,0x4(%esp)
 7bd:	8b 45 08             	mov    0x8(%ebp),%eax
 7c0:	89 04 24             	mov    %eax,(%esp)
 7c3:	e8 c4 fe ff ff       	call   68c <putc>
 7c8:	e9 31 01 00 00       	jmp    8fe <printf+0x19b>
      }
    } else if(state == '%'){
 7cd:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 7d1:	0f 85 27 01 00 00    	jne    8fe <printf+0x19b>
      if(c == 'd'){
 7d7:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 7db:	75 2d                	jne    80a <printf+0xa7>
        printint(fd, *ap, 10, 1);
 7dd:	8b 45 e8             	mov    -0x18(%ebp),%eax
 7e0:	8b 00                	mov    (%eax),%eax
 7e2:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
 7e9:	00 
 7ea:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
 7f1:	00 
 7f2:	89 44 24 04          	mov    %eax,0x4(%esp)
 7f6:	8b 45 08             	mov    0x8(%ebp),%eax
 7f9:	89 04 24             	mov    %eax,(%esp)
 7fc:	e8 b3 fe ff ff       	call   6b4 <printint>
        ap++;
 801:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 805:	e9 ed 00 00 00       	jmp    8f7 <printf+0x194>
      } else if(c == 'x' || c == 'p'){
 80a:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 80e:	74 06                	je     816 <printf+0xb3>
 810:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 814:	75 2d                	jne    843 <printf+0xe0>
        printint(fd, *ap, 16, 0);
 816:	8b 45 e8             	mov    -0x18(%ebp),%eax
 819:	8b 00                	mov    (%eax),%eax
 81b:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 822:	00 
 823:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 82a:	00 
 82b:	89 44 24 04          	mov    %eax,0x4(%esp)
 82f:	8b 45 08             	mov    0x8(%ebp),%eax
 832:	89 04 24             	mov    %eax,(%esp)
 835:	e8 7a fe ff ff       	call   6b4 <printint>
        ap++;
 83a:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 83e:	e9 b4 00 00 00       	jmp    8f7 <printf+0x194>
      } else if(c == 's'){
 843:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 847:	75 46                	jne    88f <printf+0x12c>
        s = (char*)*ap;
 849:	8b 45 e8             	mov    -0x18(%ebp),%eax
 84c:	8b 00                	mov    (%eax),%eax
 84e:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 851:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 855:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 859:	75 27                	jne    882 <printf+0x11f>
          s = "(null)";
 85b:	c7 45 f4 c2 0f 00 00 	movl   $0xfc2,-0xc(%ebp)
        while(*s != 0){
 862:	eb 1e                	jmp    882 <printf+0x11f>
          putc(fd, *s);
 864:	8b 45 f4             	mov    -0xc(%ebp),%eax
 867:	0f b6 00             	movzbl (%eax),%eax
 86a:	0f be c0             	movsbl %al,%eax
 86d:	89 44 24 04          	mov    %eax,0x4(%esp)
 871:	8b 45 08             	mov    0x8(%ebp),%eax
 874:	89 04 24             	mov    %eax,(%esp)
 877:	e8 10 fe ff ff       	call   68c <putc>
          s++;
 87c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 880:	eb 01                	jmp    883 <printf+0x120>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 882:	90                   	nop
 883:	8b 45 f4             	mov    -0xc(%ebp),%eax
 886:	0f b6 00             	movzbl (%eax),%eax
 889:	84 c0                	test   %al,%al
 88b:	75 d7                	jne    864 <printf+0x101>
 88d:	eb 68                	jmp    8f7 <printf+0x194>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 88f:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 893:	75 1d                	jne    8b2 <printf+0x14f>
        putc(fd, *ap);
 895:	8b 45 e8             	mov    -0x18(%ebp),%eax
 898:	8b 00                	mov    (%eax),%eax
 89a:	0f be c0             	movsbl %al,%eax
 89d:	89 44 24 04          	mov    %eax,0x4(%esp)
 8a1:	8b 45 08             	mov    0x8(%ebp),%eax
 8a4:	89 04 24             	mov    %eax,(%esp)
 8a7:	e8 e0 fd ff ff       	call   68c <putc>
        ap++;
 8ac:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 8b0:	eb 45                	jmp    8f7 <printf+0x194>
      } else if(c == '%'){
 8b2:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 8b6:	75 17                	jne    8cf <printf+0x16c>
        putc(fd, c);
 8b8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 8bb:	0f be c0             	movsbl %al,%eax
 8be:	89 44 24 04          	mov    %eax,0x4(%esp)
 8c2:	8b 45 08             	mov    0x8(%ebp),%eax
 8c5:	89 04 24             	mov    %eax,(%esp)
 8c8:	e8 bf fd ff ff       	call   68c <putc>
 8cd:	eb 28                	jmp    8f7 <printf+0x194>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 8cf:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
 8d6:	00 
 8d7:	8b 45 08             	mov    0x8(%ebp),%eax
 8da:	89 04 24             	mov    %eax,(%esp)
 8dd:	e8 aa fd ff ff       	call   68c <putc>
        putc(fd, c);
 8e2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 8e5:	0f be c0             	movsbl %al,%eax
 8e8:	89 44 24 04          	mov    %eax,0x4(%esp)
 8ec:	8b 45 08             	mov    0x8(%ebp),%eax
 8ef:	89 04 24             	mov    %eax,(%esp)
 8f2:	e8 95 fd ff ff       	call   68c <putc>
      }
      state = 0;
 8f7:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 8fe:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 902:	8b 55 0c             	mov    0xc(%ebp),%edx
 905:	8b 45 f0             	mov    -0x10(%ebp),%eax
 908:	01 d0                	add    %edx,%eax
 90a:	0f b6 00             	movzbl (%eax),%eax
 90d:	84 c0                	test   %al,%al
 90f:	0f 85 70 fe ff ff    	jne    785 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 915:	c9                   	leave  
 916:	c3                   	ret    
 917:	90                   	nop

00000918 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 918:	55                   	push   %ebp
 919:	89 e5                	mov    %esp,%ebp
 91b:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 91e:	8b 45 08             	mov    0x8(%ebp),%eax
 921:	83 e8 08             	sub    $0x8,%eax
 924:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 927:	a1 28 14 00 00       	mov    0x1428,%eax
 92c:	89 45 fc             	mov    %eax,-0x4(%ebp)
 92f:	eb 24                	jmp    955 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 931:	8b 45 fc             	mov    -0x4(%ebp),%eax
 934:	8b 00                	mov    (%eax),%eax
 936:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 939:	77 12                	ja     94d <free+0x35>
 93b:	8b 45 f8             	mov    -0x8(%ebp),%eax
 93e:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 941:	77 24                	ja     967 <free+0x4f>
 943:	8b 45 fc             	mov    -0x4(%ebp),%eax
 946:	8b 00                	mov    (%eax),%eax
 948:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 94b:	77 1a                	ja     967 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 94d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 950:	8b 00                	mov    (%eax),%eax
 952:	89 45 fc             	mov    %eax,-0x4(%ebp)
 955:	8b 45 f8             	mov    -0x8(%ebp),%eax
 958:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 95b:	76 d4                	jbe    931 <free+0x19>
 95d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 960:	8b 00                	mov    (%eax),%eax
 962:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 965:	76 ca                	jbe    931 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 967:	8b 45 f8             	mov    -0x8(%ebp),%eax
 96a:	8b 40 04             	mov    0x4(%eax),%eax
 96d:	c1 e0 03             	shl    $0x3,%eax
 970:	89 c2                	mov    %eax,%edx
 972:	03 55 f8             	add    -0x8(%ebp),%edx
 975:	8b 45 fc             	mov    -0x4(%ebp),%eax
 978:	8b 00                	mov    (%eax),%eax
 97a:	39 c2                	cmp    %eax,%edx
 97c:	75 24                	jne    9a2 <free+0x8a>
    bp->s.size += p->s.ptr->s.size;
 97e:	8b 45 f8             	mov    -0x8(%ebp),%eax
 981:	8b 50 04             	mov    0x4(%eax),%edx
 984:	8b 45 fc             	mov    -0x4(%ebp),%eax
 987:	8b 00                	mov    (%eax),%eax
 989:	8b 40 04             	mov    0x4(%eax),%eax
 98c:	01 c2                	add    %eax,%edx
 98e:	8b 45 f8             	mov    -0x8(%ebp),%eax
 991:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 994:	8b 45 fc             	mov    -0x4(%ebp),%eax
 997:	8b 00                	mov    (%eax),%eax
 999:	8b 10                	mov    (%eax),%edx
 99b:	8b 45 f8             	mov    -0x8(%ebp),%eax
 99e:	89 10                	mov    %edx,(%eax)
 9a0:	eb 0a                	jmp    9ac <free+0x94>
  } else
    bp->s.ptr = p->s.ptr;
 9a2:	8b 45 fc             	mov    -0x4(%ebp),%eax
 9a5:	8b 10                	mov    (%eax),%edx
 9a7:	8b 45 f8             	mov    -0x8(%ebp),%eax
 9aa:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 9ac:	8b 45 fc             	mov    -0x4(%ebp),%eax
 9af:	8b 40 04             	mov    0x4(%eax),%eax
 9b2:	c1 e0 03             	shl    $0x3,%eax
 9b5:	03 45 fc             	add    -0x4(%ebp),%eax
 9b8:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 9bb:	75 20                	jne    9dd <free+0xc5>
    p->s.size += bp->s.size;
 9bd:	8b 45 fc             	mov    -0x4(%ebp),%eax
 9c0:	8b 50 04             	mov    0x4(%eax),%edx
 9c3:	8b 45 f8             	mov    -0x8(%ebp),%eax
 9c6:	8b 40 04             	mov    0x4(%eax),%eax
 9c9:	01 c2                	add    %eax,%edx
 9cb:	8b 45 fc             	mov    -0x4(%ebp),%eax
 9ce:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 9d1:	8b 45 f8             	mov    -0x8(%ebp),%eax
 9d4:	8b 10                	mov    (%eax),%edx
 9d6:	8b 45 fc             	mov    -0x4(%ebp),%eax
 9d9:	89 10                	mov    %edx,(%eax)
 9db:	eb 08                	jmp    9e5 <free+0xcd>
  } else
    p->s.ptr = bp;
 9dd:	8b 45 fc             	mov    -0x4(%ebp),%eax
 9e0:	8b 55 f8             	mov    -0x8(%ebp),%edx
 9e3:	89 10                	mov    %edx,(%eax)
  freep = p;
 9e5:	8b 45 fc             	mov    -0x4(%ebp),%eax
 9e8:	a3 28 14 00 00       	mov    %eax,0x1428
}
 9ed:	c9                   	leave  
 9ee:	c3                   	ret    

000009ef <morecore>:

static Header*
morecore(uint nu)
{
 9ef:	55                   	push   %ebp
 9f0:	89 e5                	mov    %esp,%ebp
 9f2:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 9f5:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 9fc:	77 07                	ja     a05 <morecore+0x16>
    nu = 4096;
 9fe:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 a05:	8b 45 08             	mov    0x8(%ebp),%eax
 a08:	c1 e0 03             	shl    $0x3,%eax
 a0b:	89 04 24             	mov    %eax,(%esp)
 a0e:	e8 29 fc ff ff       	call   63c <sbrk>
 a13:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 a16:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 a1a:	75 07                	jne    a23 <morecore+0x34>
    return 0;
 a1c:	b8 00 00 00 00       	mov    $0x0,%eax
 a21:	eb 22                	jmp    a45 <morecore+0x56>
  hp = (Header*)p;
 a23:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a26:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 a29:	8b 45 f0             	mov    -0x10(%ebp),%eax
 a2c:	8b 55 08             	mov    0x8(%ebp),%edx
 a2f:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 a32:	8b 45 f0             	mov    -0x10(%ebp),%eax
 a35:	83 c0 08             	add    $0x8,%eax
 a38:	89 04 24             	mov    %eax,(%esp)
 a3b:	e8 d8 fe ff ff       	call   918 <free>
  return freep;
 a40:	a1 28 14 00 00       	mov    0x1428,%eax
}
 a45:	c9                   	leave  
 a46:	c3                   	ret    

00000a47 <malloc>:

void*
malloc(uint nbytes)
{
 a47:	55                   	push   %ebp
 a48:	89 e5                	mov    %esp,%ebp
 a4a:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a4d:	8b 45 08             	mov    0x8(%ebp),%eax
 a50:	83 c0 07             	add    $0x7,%eax
 a53:	c1 e8 03             	shr    $0x3,%eax
 a56:	83 c0 01             	add    $0x1,%eax
 a59:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 a5c:	a1 28 14 00 00       	mov    0x1428,%eax
 a61:	89 45 f0             	mov    %eax,-0x10(%ebp)
 a64:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 a68:	75 23                	jne    a8d <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 a6a:	c7 45 f0 20 14 00 00 	movl   $0x1420,-0x10(%ebp)
 a71:	8b 45 f0             	mov    -0x10(%ebp),%eax
 a74:	a3 28 14 00 00       	mov    %eax,0x1428
 a79:	a1 28 14 00 00       	mov    0x1428,%eax
 a7e:	a3 20 14 00 00       	mov    %eax,0x1420
    base.s.size = 0;
 a83:	c7 05 24 14 00 00 00 	movl   $0x0,0x1424
 a8a:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a8d:	8b 45 f0             	mov    -0x10(%ebp),%eax
 a90:	8b 00                	mov    (%eax),%eax
 a92:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 a95:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a98:	8b 40 04             	mov    0x4(%eax),%eax
 a9b:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 a9e:	72 4d                	jb     aed <malloc+0xa6>
      if(p->s.size == nunits)
 aa0:	8b 45 f4             	mov    -0xc(%ebp),%eax
 aa3:	8b 40 04             	mov    0x4(%eax),%eax
 aa6:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 aa9:	75 0c                	jne    ab7 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 aab:	8b 45 f4             	mov    -0xc(%ebp),%eax
 aae:	8b 10                	mov    (%eax),%edx
 ab0:	8b 45 f0             	mov    -0x10(%ebp),%eax
 ab3:	89 10                	mov    %edx,(%eax)
 ab5:	eb 26                	jmp    add <malloc+0x96>
      else {
        p->s.size -= nunits;
 ab7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 aba:	8b 40 04             	mov    0x4(%eax),%eax
 abd:	89 c2                	mov    %eax,%edx
 abf:	2b 55 ec             	sub    -0x14(%ebp),%edx
 ac2:	8b 45 f4             	mov    -0xc(%ebp),%eax
 ac5:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 ac8:	8b 45 f4             	mov    -0xc(%ebp),%eax
 acb:	8b 40 04             	mov    0x4(%eax),%eax
 ace:	c1 e0 03             	shl    $0x3,%eax
 ad1:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 ad4:	8b 45 f4             	mov    -0xc(%ebp),%eax
 ad7:	8b 55 ec             	mov    -0x14(%ebp),%edx
 ada:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 add:	8b 45 f0             	mov    -0x10(%ebp),%eax
 ae0:	a3 28 14 00 00       	mov    %eax,0x1428
      return (void*)(p + 1);
 ae5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 ae8:	83 c0 08             	add    $0x8,%eax
 aeb:	eb 38                	jmp    b25 <malloc+0xde>
    }
    if(p == freep)
 aed:	a1 28 14 00 00       	mov    0x1428,%eax
 af2:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 af5:	75 1b                	jne    b12 <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
 af7:	8b 45 ec             	mov    -0x14(%ebp),%eax
 afa:	89 04 24             	mov    %eax,(%esp)
 afd:	e8 ed fe ff ff       	call   9ef <morecore>
 b02:	89 45 f4             	mov    %eax,-0xc(%ebp)
 b05:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 b09:	75 07                	jne    b12 <malloc+0xcb>
        return 0;
 b0b:	b8 00 00 00 00       	mov    $0x0,%eax
 b10:	eb 13                	jmp    b25 <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b12:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b15:	89 45 f0             	mov    %eax,-0x10(%ebp)
 b18:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b1b:	8b 00                	mov    (%eax),%eax
 b1d:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 b20:	e9 70 ff ff ff       	jmp    a95 <malloc+0x4e>
}
 b25:	c9                   	leave  
 b26:	c3                   	ret    
 b27:	90                   	nop

00000b28 <getNextThread>:
} tTable;


int
getNextThread(int j)
{
 b28:	55                   	push   %ebp
 b29:	89 e5                	mov    %esp,%ebp
 b2b:	83 ec 10             	sub    $0x10,%esp
  int i=j+1;
 b2e:	8b 45 08             	mov    0x8(%ebp),%eax
 b31:	83 c0 01             	add    $0x1,%eax
 b34:	89 45 fc             	mov    %eax,-0x4(%ebp)
  if(i==MAX_THREAD)
 b37:	83 7d fc 40          	cmpl   $0x40,-0x4(%ebp)
 b3b:	75 07                	jne    b44 <getNextThread+0x1c>
    i=0;
 b3d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  uthread_p t=&tTable.table[i];
 b44:	8b 45 fc             	mov    -0x4(%ebp),%eax
 b47:	69 c0 18 01 00 00    	imul   $0x118,%eax,%eax
 b4d:	05 40 14 00 00       	add    $0x1440,%eax
 b52:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(i!=j)
 b55:	eb 3b                	jmp    b92 <getNextThread+0x6a>
  {
    if(t->state==T_RUNNABLE)
 b57:	8b 45 f8             	mov    -0x8(%ebp),%eax
 b5a:	8b 40 10             	mov    0x10(%eax),%eax
 b5d:	83 f8 03             	cmp    $0x3,%eax
 b60:	75 05                	jne    b67 <getNextThread+0x3f>
      return i;
 b62:	8b 45 fc             	mov    -0x4(%ebp),%eax
 b65:	eb 38                	jmp    b9f <getNextThread+0x77>
    i++;
 b67:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    if(i==MAX_THREAD)
 b6b:	83 7d fc 40          	cmpl   $0x40,-0x4(%ebp)
 b6f:	75 1a                	jne    b8b <getNextThread+0x63>
    {
       i=0;
 b71:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
       t=&tTable.table[i];
 b78:	8b 45 fc             	mov    -0x4(%ebp),%eax
 b7b:	69 c0 18 01 00 00    	imul   $0x118,%eax,%eax
 b81:	05 40 14 00 00       	add    $0x1440,%eax
 b86:	89 45 f8             	mov    %eax,-0x8(%ebp)
 b89:	eb 07                	jmp    b92 <getNextThread+0x6a>
    }
    else
      t++;
 b8b:	81 45 f8 18 01 00 00 	addl   $0x118,-0x8(%ebp)
{
  int i=j+1;
  if(i==MAX_THREAD)
    i=0;
  uthread_p t=&tTable.table[i];
  while(i!=j)
 b92:	8b 45 fc             	mov    -0x4(%ebp),%eax
 b95:	3b 45 08             	cmp    0x8(%ebp),%eax
 b98:	75 bd                	jne    b57 <getNextThread+0x2f>
    }
    else
      t++;
    
  }
  return -1;
 b9a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
 b9f:	c9                   	leave  
 ba0:	c3                   	ret    

00000ba1 <allocThread>:


static uthread_p
allocThread()
{
 ba1:	55                   	push   %ebp
 ba2:	89 e5                	mov    %esp,%ebp
 ba4:	83 ec 28             	sub    $0x28,%esp
  int i,j;
  uthread_p t;
  
  for (t=tTable.table,i=0 ; t <= &tTable.table[MAX_THREAD]; t++,i++)// <= should be < ??
 ba7:	c7 45 ec 40 14 00 00 	movl   $0x1440,-0x14(%ebp)
 bae:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 bb5:	eb 15                	jmp    bcc <allocThread+0x2b>
  {
    if(t->state==T_FREE)
 bb7:	8b 45 ec             	mov    -0x14(%ebp),%eax
 bba:	8b 40 10             	mov    0x10(%eax),%eax
 bbd:	85 c0                	test   %eax,%eax
 bbf:	74 1e                	je     bdf <allocThread+0x3e>
allocThread()
{
  int i,j;
  uthread_p t;
  
  for (t=tTable.table,i=0 ; t <= &tTable.table[MAX_THREAD]; t++,i++)// <= should be < ??
 bc1:	81 45 ec 18 01 00 00 	addl   $0x118,-0x14(%ebp)
 bc8:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 bcc:	81 7d ec 40 5a 00 00 	cmpl   $0x5a40,-0x14(%ebp)
 bd3:	76 e2                	jbe    bb7 <allocThread+0x16>
  {
    if(t->state==T_FREE)
      goto found;
  }
  return 0;
 bd5:	b8 00 00 00 00       	mov    $0x0,%eax
 bda:	e9 88 00 00 00       	jmp    c67 <allocThread+0xc6>
  uthread_p t;
  
  for (t=tTable.table,i=0 ; t <= &tTable.table[MAX_THREAD]; t++,i++)// <= should be < ??
  {
    if(t->state==T_FREE)
      goto found;
 bdf:	90                   	nop
  }
  return 0;
  
  found:
  
  t->tid=i;
 be0:	8b 45 ec             	mov    -0x14(%ebp),%eax
 be3:	8b 55 f4             	mov    -0xc(%ebp),%edx
 be6:	89 10                	mov    %edx,(%eax)
  t->stack=(char*)malloc(STACK_SIZE);
 be8:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
 bef:	e8 53 fe ff ff       	call   a47 <malloc>
 bf4:	8b 55 ec             	mov    -0x14(%ebp),%edx
 bf7:	89 42 0c             	mov    %eax,0xc(%edx)
  t->esp=(int)t->stack;
 bfa:	8b 45 ec             	mov    -0x14(%ebp),%eax
 bfd:	8b 40 0c             	mov    0xc(%eax),%eax
 c00:	89 c2                	mov    %eax,%edx
 c02:	8b 45 ec             	mov    -0x14(%ebp),%eax
 c05:	89 50 04             	mov    %edx,0x4(%eax)
  t->ebp=(int)t->stack;
 c08:	8b 45 ec             	mov    -0x14(%ebp),%eax
 c0b:	8b 40 0c             	mov    0xc(%eax),%eax
 c0e:	89 c2                	mov    %eax,%edx
 c10:	8b 45 ec             	mov    -0x14(%ebp),%eax
 c13:	89 50 08             	mov    %edx,0x8(%eax)
  t->firstTime=0;
 c16:	8b 45 ec             	mov    -0x14(%ebp),%eax
 c19:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
  for(j=0;j<64;j++)
 c20:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 c27:	eb 15                	jmp    c3e <allocThread+0x9d>
  {
    t->waiting[j]=-1;
 c29:	8b 45 ec             	mov    -0x14(%ebp),%eax
 c2c:	8b 55 f0             	mov    -0x10(%ebp),%edx
 c2f:	83 c2 04             	add    $0x4,%edx
 c32:	c7 44 90 08 ff ff ff 	movl   $0xffffffff,0x8(%eax,%edx,4)
 c39:	ff 
  t->tid=i;
  t->stack=(char*)malloc(STACK_SIZE);
  t->esp=(int)t->stack;
  t->ebp=(int)t->stack;
  t->firstTime=0;
  for(j=0;j<64;j++)
 c3a:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 c3e:	83 7d f0 3f          	cmpl   $0x3f,-0x10(%ebp)
 c42:	7e e5                	jle    c29 <allocThread+0x88>
  {
    t->waiting[j]=-1;
  }
  asm("movl %1,%%esp;" "push %2;" "movl %%esp,%0;" //pushes the uthread_exit func as return address
    : "=r" (t->esp) 
    : "r" (t->ebp) , "r"(uthread_exit)
 c44:	8b 45 ec             	mov    -0x14(%ebp),%eax
 c47:	8b 40 08             	mov    0x8(%eax),%eax
  t->firstTime=0;
  for(j=0;j<64;j++)
  {
    t->waiting[j]=-1;
  }
  asm("movl %1,%%esp;" "push %2;" "movl %%esp,%0;" //pushes the uthread_exit func as return address
 c4a:	ba 66 0d 00 00       	mov    $0xd66,%edx
 c4f:	89 c4                	mov    %eax,%esp
 c51:	52                   	push   %edx
 c52:	89 e2                	mov    %esp,%edx
    : "=r" (t->esp) 
 c54:	8b 45 ec             	mov    -0x14(%ebp),%eax
  t->firstTime=0;
  for(j=0;j<64;j++)
  {
    t->waiting[j]=-1;
  }
  asm("movl %1,%%esp;" "push %2;" "movl %%esp,%0;" //pushes the uthread_exit func as return address
 c57:	89 50 04             	mov    %edx,0x4(%eax)
    : "=r" (t->esp) 
    : "r" (t->ebp) , "r"(uthread_exit)
  );
  t->state=T_UNINIT;
 c5a:	8b 45 ec             	mov    -0x14(%ebp),%eax
 c5d:	c7 40 10 01 00 00 00 	movl   $0x1,0x10(%eax)
  return t;
 c64:	8b 45 ec             	mov    -0x14(%ebp),%eax
}
 c67:	c9                   	leave  
 c68:	c3                   	ret    

00000c69 <uthread_init>:

void 
uthread_init()
{  
 c69:	55                   	push   %ebp
 c6a:	89 e5                	mov    %esp,%ebp
 c6c:	83 ec 28             	sub    $0x28,%esp
  tTable.length=0;
 c6f:	c7 05 40 5a 00 00 00 	movl   $0x0,0x5a40
 c76:	00 00 00 
  tTable.current=0;
 c79:	c7 05 44 5a 00 00 00 	movl   $0x0,0x5a44
 c80:	00 00 00 
  uthread_p mainT = allocThread(); //needed to allocate the main thread !!!!!!
 c83:	e8 19 ff ff ff       	call   ba1 <allocThread>
 c88:	89 45 f4             	mov    %eax,-0xc(%ebp)
  asm("movl %%ebp,%0;" "movl %%esp,%1;" //get current thread ebp and esp
 c8b:	89 e9                	mov    %ebp,%ecx
 c8d:	89 e2                	mov    %esp,%edx
    : "=r" (mainT->ebp) ,"=r"(mainT->esp)    
 c8f:	8b 45 f4             	mov    -0xc(%ebp),%eax
uthread_init()
{  
  tTable.length=0;
  tTable.current=0;
  uthread_p mainT = allocThread(); //needed to allocate the main thread !!!!!!
  asm("movl %%ebp,%0;" "movl %%esp,%1;" //get current thread ebp and esp
 c92:	89 48 08             	mov    %ecx,0x8(%eax)
    : "=r" (mainT->ebp) ,"=r"(mainT->esp)    
 c95:	8b 45 f4             	mov    -0xc(%ebp),%eax
uthread_init()
{  
  tTable.length=0;
  tTable.current=0;
  uthread_p mainT = allocThread(); //needed to allocate the main thread !!!!!!
  asm("movl %%ebp,%0;" "movl %%esp,%1;" //get current thread ebp and esp
 c98:	89 50 04             	mov    %edx,0x4(%eax)
    : "=r" (mainT->ebp) ,"=r"(mainT->esp)    
  );
  /*moves stack to mainT's stack
  /stacks grow backwards so we start from esp and finsh at ebp*/
  memmove(mainT->stack , (void*)mainT->esp , mainT->ebp - mainT->esp);
 c9b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 c9e:	8b 50 08             	mov    0x8(%eax),%edx
 ca1:	8b 45 f4             	mov    -0xc(%ebp),%eax
 ca4:	8b 40 04             	mov    0x4(%eax),%eax
 ca7:	89 d1                	mov    %edx,%ecx
 ca9:	29 c1                	sub    %eax,%ecx
 cab:	8b 45 f4             	mov    -0xc(%ebp),%eax
 cae:	8b 40 04             	mov    0x4(%eax),%eax
 cb1:	89 c2                	mov    %eax,%edx
 cb3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 cb6:	8b 40 0c             	mov    0xc(%eax),%eax
 cb9:	89 4c 24 08          	mov    %ecx,0x8(%esp)
 cbd:	89 54 24 04          	mov    %edx,0x4(%esp)
 cc1:	89 04 24             	mov    %eax,(%esp)
 cc4:	e8 a5 f8 ff ff       	call   56e <memmove>
  mainT->state = T_RUNNABLE;
 cc9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 ccc:	c7 40 10 03 00 00 00 	movl   $0x3,0x10(%eax)
  currentThread=mainT;
 cd3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 cd6:	a3 60 5e 00 00       	mov    %eax,0x5e60
  if(signal(SIGALRM,uthread_yield)<0)
 cdb:	c7 44 24 04 d6 0e 00 	movl   $0xed6,0x4(%esp)
 ce2:	00 
 ce3:	c7 04 24 0e 00 00 00 	movl   $0xe,(%esp)
 cea:	e8 85 f9 ff ff       	call   674 <signal>
 cef:	85 c0                	test   %eax,%eax
 cf1:	79 19                	jns    d0c <uthread_init+0xa3>
  {
    printf(1,"Cant register the alarm signal");
 cf3:	c7 44 24 04 cc 0f 00 	movl   $0xfcc,0x4(%esp)
 cfa:	00 
 cfb:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 d02:	e8 5c fa ff ff       	call   763 <printf>
    exit();
 d07:	e8 a8 f8 ff ff       	call   5b4 <exit>
  }
  if(alarm(THREAD_QUANTA)<0)
 d0c:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
 d13:	e8 6c f9 ff ff       	call   684 <alarm>
 d18:	85 c0                	test   %eax,%eax
 d1a:	79 19                	jns    d35 <uthread_init+0xcc>
  {
    printf(1,"Cant activate alarm system call");
 d1c:	c7 44 24 04 ec 0f 00 	movl   $0xfec,0x4(%esp)
 d23:	00 
 d24:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 d2b:	e8 33 fa ff ff       	call   763 <printf>
    exit();
 d30:	e8 7f f8 ff ff       	call   5b4 <exit>
  }
  
}
 d35:	c9                   	leave  
 d36:	c3                   	ret    

00000d37 <uthread_create>:

int  
uthread_create(void (*start_func)(void *), void* arg)
{
 d37:	55                   	push   %ebp
 d38:	89 e5                	mov    %esp,%ebp
 d3a:	83 ec 18             	sub    $0x18,%esp
  uthread_p t = allocThread();
 d3d:	e8 5f fe ff ff       	call   ba1 <allocThread>
 d42:	89 45 f4             	mov    %eax,-0xc(%ebp)
  
  asm("push %1;"  //stores the arguments to be used
 d45:	8b 45 0c             	mov    0xc(%ebp),%eax
 d48:	8b 55 08             	mov    0x8(%ebp),%edx
 d4b:	50                   	push   %eax
 d4c:	52                   	push   %edx
 d4d:	89 e2                	mov    %esp,%edx
      "push %2;"  //stores the start_func location
      "movl %%esp,%0;"
      : "=r" (t->esp)
 d4f:	8b 45 f4             	mov    -0xc(%ebp),%eax
int  
uthread_create(void (*start_func)(void *), void* arg)
{
  uthread_p t = allocThread();
  
  asm("push %1;"  //stores the arguments to be used
 d52:	89 50 04             	mov    %edx,0x4(%eax)
      "push %2;"  //stores the start_func location
      "movl %%esp,%0;"
      : "=r" (t->esp)
      : "r" (arg) , "r"(start_func)
  );
  t->state= T_RUNNABLE;
 d55:	8b 45 f4             	mov    -0xc(%ebp),%eax
 d58:	c7 40 10 03 00 00 00 	movl   $0x3,0x10(%eax)
  
  return t->tid;
 d5f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 d62:	8b 00                	mov    (%eax),%eax
}
 d64:	c9                   	leave  
 d65:	c3                   	ret    

00000d66 <uthread_exit>:

void 
uthread_exit()
{
 d66:	55                   	push   %ebp
 d67:	89 e5                	mov    %esp,%ebp
 d69:	83 ec 28             	sub    $0x28,%esp
  uthread_p newt;
  int old=currentThread->tid;
 d6c:	a1 60 5e 00 00       	mov    0x5e60,%eax
 d71:	8b 00                	mov    (%eax),%eax
 d73:	89 45 f0             	mov    %eax,-0x10(%ebp)
  
  int i=0;
 d76:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  while(currentThread->waiting[i]!=-1)
 d7d:	eb 25                	jmp    da4 <uthread_exit+0x3e>
  {
    (&tTable.table[currentThread->waiting[i]])->state=T_RUNNABLE;
 d7f:	a1 60 5e 00 00       	mov    0x5e60,%eax
 d84:	8b 55 f4             	mov    -0xc(%ebp),%edx
 d87:	83 c2 04             	add    $0x4,%edx
 d8a:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
 d8e:	69 c0 18 01 00 00    	imul   $0x118,%eax,%eax
 d94:	05 40 14 00 00       	add    $0x1440,%eax
 d99:	c7 40 10 03 00 00 00 	movl   $0x3,0x10(%eax)
    i++;
 da0:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
{
  uthread_p newt;
  int old=currentThread->tid;
  
  int i=0;
  while(currentThread->waiting[i]!=-1)
 da4:	a1 60 5e 00 00       	mov    0x5e60,%eax
 da9:	8b 55 f4             	mov    -0xc(%ebp),%edx
 dac:	83 c2 04             	add    $0x4,%edx
 daf:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
 db3:	83 f8 ff             	cmp    $0xffffffff,%eax
 db6:	75 c7                	jne    d7f <uthread_exit+0x19>
  {
    (&tTable.table[currentThread->waiting[i]])->state=T_RUNNABLE;
    i++;
  }
  currentThread->tid=-1;
 db8:	a1 60 5e 00 00       	mov    0x5e60,%eax
 dbd:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)
  currentThread->esp=-1;
 dc3:	a1 60 5e 00 00       	mov    0x5e60,%eax
 dc8:	c7 40 04 ff ff ff ff 	movl   $0xffffffff,0x4(%eax)
  currentThread->ebp=-1;
 dcf:	a1 60 5e 00 00       	mov    0x5e60,%eax
 dd4:	c7 40 08 ff ff ff ff 	movl   $0xffffffff,0x8(%eax)
  free(currentThread->stack);
 ddb:	a1 60 5e 00 00       	mov    0x5e60,%eax
 de0:	8b 40 0c             	mov    0xc(%eax),%eax
 de3:	89 04 24             	mov    %eax,(%esp)
 de6:	e8 2d fb ff ff       	call   918 <free>
  currentThread->state=T_FREE;
 deb:	a1 60 5e 00 00       	mov    0x5e60,%eax
 df0:	c7 40 10 00 00 00 00 	movl   $0x0,0x10(%eax)
  currentThread->firstTime=0;
 df7:	a1 60 5e 00 00       	mov    0x5e60,%eax
 dfc:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
  int new=getNextThread(old);
 e03:	8b 45 f0             	mov    -0x10(%ebp),%eax
 e06:	89 04 24             	mov    %eax,(%esp)
 e09:	e8 1a fd ff ff       	call   b28 <getNextThread>
 e0e:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if(new>=0)
 e11:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 e15:	78 36                	js     e4d <uthread_exit+0xe7>
          {
             newt=&tTable.table[new];
 e17:	8b 45 ec             	mov    -0x14(%ebp),%eax
 e1a:	69 c0 18 01 00 00    	imul   $0x118,%eax,%eax
 e20:	05 40 14 00 00       	add    $0x1440,%eax
 e25:	89 45 e8             	mov    %eax,-0x18(%ebp)
             newt->state=T_RUNNING;
 e28:	8b 45 e8             	mov    -0x18(%ebp),%eax
 e2b:	c7 40 10 02 00 00 00 	movl   $0x2,0x10(%eax)
             LOAD_ESP(newt->esp);
 e32:	8b 45 e8             	mov    -0x18(%ebp),%eax
 e35:	8b 40 04             	mov    0x4(%eax),%eax
 e38:	89 c4                	mov    %eax,%esp
             LOAD_EBP(newt->ebp);
 e3a:	8b 45 e8             	mov    -0x18(%ebp),%eax
 e3d:	8b 40 08             	mov    0x8(%eax),%eax
 e40:	89 c5                	mov    %eax,%ebp
             asm("popa");
 e42:	61                   	popa   
             currentThread=newt;
 e43:	8b 45 e8             	mov    -0x18(%ebp),%eax
 e46:	a3 60 5e 00 00       	mov    %eax,0x5e60
        {/////what if some thread state is sleeping?
             
             exit();
        }
     
}
 e4b:	c9                   	leave  
 e4c:	c3                   	ret    
             currentThread=newt;
          }
        else
        {/////what if some thread state is sleeping?
             
             exit();
 e4d:	e8 62 f7 ff ff       	call   5b4 <exit>

00000e52 <uthred_join>:
}


int
uthred_join(int tid)
{
 e52:	55                   	push   %ebp
 e53:	89 e5                	mov    %esp,%ebp
 e55:	83 ec 18             	sub    $0x18,%esp
  if((&tTable.table[tid])->state==T_FREE)
 e58:	8b 45 08             	mov    0x8(%ebp),%eax
 e5b:	69 c0 18 01 00 00    	imul   $0x118,%eax,%eax
 e61:	05 40 14 00 00       	add    $0x1440,%eax
 e66:	8b 40 10             	mov    0x10(%eax),%eax
 e69:	85 c0                	test   %eax,%eax
 e6b:	75 07                	jne    e74 <uthred_join+0x22>
    return -1;
 e6d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 e72:	eb 60                	jmp    ed4 <uthred_join+0x82>
  else
  {
      int i=0;
 e74:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
      while((&tTable.table[tid])->waiting[i]!=-1)
 e7b:	eb 04                	jmp    e81 <uthred_join+0x2f>
        i++;
 e7d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  if((&tTable.table[tid])->state==T_FREE)
    return -1;
  else
  {
      int i=0;
      while((&tTable.table[tid])->waiting[i]!=-1)
 e81:	8b 45 08             	mov    0x8(%ebp),%eax
 e84:	69 c0 18 01 00 00    	imul   $0x118,%eax,%eax
 e8a:	05 40 14 00 00       	add    $0x1440,%eax
 e8f:	8b 55 f4             	mov    -0xc(%ebp),%edx
 e92:	83 c2 04             	add    $0x4,%edx
 e95:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
 e99:	83 f8 ff             	cmp    $0xffffffff,%eax
 e9c:	75 df                	jne    e7d <uthred_join+0x2b>
        i++;
      (&tTable.table[tid])->waiting[i]=currentThread->tid;
 e9e:	8b 45 08             	mov    0x8(%ebp),%eax
 ea1:	69 c0 18 01 00 00    	imul   $0x118,%eax,%eax
 ea7:	8d 90 40 14 00 00    	lea    0x1440(%eax),%edx
 ead:	a1 60 5e 00 00       	mov    0x5e60,%eax
 eb2:	8b 00                	mov    (%eax),%eax
 eb4:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 eb7:	83 c1 04             	add    $0x4,%ecx
 eba:	89 44 8a 08          	mov    %eax,0x8(%edx,%ecx,4)
      currentThread->state=T_SLEEPING;
 ebe:	a1 60 5e 00 00       	mov    0x5e60,%eax
 ec3:	c7 40 10 04 00 00 00 	movl   $0x4,0x10(%eax)
      uthread_yield();
 eca:	e8 07 00 00 00       	call   ed6 <uthread_yield>
      return 1;
 ecf:	b8 01 00 00 00       	mov    $0x1,%eax
  }
}
 ed4:	c9                   	leave  
 ed5:	c3                   	ret    

00000ed6 <uthread_yield>:

void 
uthread_yield()
{
 ed6:	55                   	push   %ebp
 ed7:	89 e5                	mov    %esp,%ebp
 ed9:	83 ec 28             	sub    $0x28,%esp
  uthread_p newt;
  int old=currentThread->tid;
 edc:	a1 60 5e 00 00       	mov    0x5e60,%eax
 ee1:	8b 00                	mov    (%eax),%eax
 ee3:	89 45 f4             	mov    %eax,-0xc(%ebp)
  int new=getNextThread(old);
 ee6:	8b 45 f4             	mov    -0xc(%ebp),%eax
 ee9:	89 04 24             	mov    %eax,(%esp)
 eec:	e8 37 fc ff ff       	call   b28 <getNextThread>
 ef1:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(new<0)
 ef4:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 ef8:	79 19                	jns    f13 <uthread_yield+0x3d>
  {
     printf(1,"(fun uthread_yield)Cant find runnable thread");
 efa:	c7 44 24 04 0c 10 00 	movl   $0x100c,0x4(%esp)
 f01:	00 
 f02:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 f09:	e8 55 f8 ff ff       	call   763 <printf>
    exit();
 f0e:	e8 a1 f6 ff ff       	call   5b4 <exit>
  }
newt=&tTable.table[new];
 f13:	8b 45 f0             	mov    -0x10(%ebp),%eax
 f16:	69 c0 18 01 00 00    	imul   $0x118,%eax,%eax
 f1c:	05 40 14 00 00       	add    $0x1440,%eax
 f21:	89 45 ec             	mov    %eax,-0x14(%ebp)
  
    asm("pusha");
 f24:	60                   	pusha  
    STORE_ESP(currentThread->esp);
 f25:	a1 60 5e 00 00       	mov    0x5e60,%eax
 f2a:	89 e2                	mov    %esp,%edx
 f2c:	89 50 04             	mov    %edx,0x4(%eax)
    if(currentThread->state==T_RUNNING)
 f2f:	a1 60 5e 00 00       	mov    0x5e60,%eax
 f34:	8b 40 10             	mov    0x10(%eax),%eax
 f37:	83 f8 02             	cmp    $0x2,%eax
 f3a:	75 0c                	jne    f48 <uthread_yield+0x72>
      currentThread->state=T_RUNNABLE;
 f3c:	a1 60 5e 00 00       	mov    0x5e60,%eax
 f41:	c7 40 10 03 00 00 00 	movl   $0x3,0x10(%eax)
    LOAD_ESP(newt->esp);
 f48:	8b 45 ec             	mov    -0x14(%ebp),%eax
 f4b:	8b 40 04             	mov    0x4(%eax),%eax
 f4e:	89 c4                	mov    %eax,%esp
    
  
    newt->state=T_RUNNING;
 f50:	8b 45 ec             	mov    -0x14(%ebp),%eax
 f53:	c7 40 10 02 00 00 00 	movl   $0x2,0x10(%eax)

    asm("popa");
 f5a:	61                   	popa   
    if(currentThread->firstTime==0)
 f5b:	a1 60 5e 00 00       	mov    0x5e60,%eax
 f60:	8b 40 14             	mov    0x14(%eax),%eax
 f63:	85 c0                	test   %eax,%eax
 f65:	75 0d                	jne    f74 <uthread_yield+0x9e>
    {
       asm("ret");////only firest time
 f67:	c3                   	ret    
       currentThread->firstTime=1;
 f68:	a1 60 5e 00 00       	mov    0x5e60,%eax
 f6d:	c7 40 14 01 00 00 00 	movl   $0x1,0x14(%eax)
    }
   
currentThread=newt;
 f74:	8b 45 ec             	mov    -0x14(%ebp),%eax
 f77:	a3 60 5e 00 00       	mov    %eax,0x5e60

}
 f7c:	c9                   	leave  
 f7d:	c3                   	ret    

00000f7e <uthred_self>:

int  uthred_self(void)
{
 f7e:	55                   	push   %ebp
 f7f:	89 e5                	mov    %esp,%ebp
  return currentThread->tid;
 f81:	a1 60 5e 00 00       	mov    0x5e60,%eax
 f86:	8b 00                	mov    (%eax),%eax
}
 f88:	5d                   	pop    %ebp
 f89:	c3                   	ret    
