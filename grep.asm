
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
      18:	c7 45 f0 60 61 00 00 	movl   $0x6160,-0x10(%ebp)
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
      90:	81 7d f0 60 61 00 00 	cmpl   $0x6160,-0x10(%ebp)
      97:	75 07                	jne    a0 <grep+0xa0>
      m = 0;
      99:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(m > 0){
      a0:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
      a4:	7e 2b                	jle    d1 <grep+0xd1>
      m -= p - buf;
      a6:	ba 60 61 00 00       	mov    $0x6160,%edx
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
      c5:	c7 04 24 60 61 00 00 	movl   $0x6160,(%esp)
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
      e2:	81 c2 60 61 00 00    	add    $0x6160,%edx
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
     119:	c7 44 24 04 7c 12 00 	movl   $0x127c,0x4(%esp)
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
     19c:	c7 44 24 04 9c 12 00 	movl   $0x129c,0x4(%esp)
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
     6fa:	0f b6 90 2c 18 00 00 	movzbl 0x182c(%eax),%edx
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
     85b:	c7 45 f4 b2 12 00 00 	movl   $0x12b2,-0xc(%ebp)
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
     927:	a1 48 18 00 00       	mov    0x1848,%eax
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
     9e8:	a3 48 18 00 00       	mov    %eax,0x1848
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
     a40:	a1 48 18 00 00       	mov    0x1848,%eax
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
     a5c:	a1 48 18 00 00       	mov    0x1848,%eax
     a61:	89 45 f0             	mov    %eax,-0x10(%ebp)
     a64:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     a68:	75 23                	jne    a8d <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     a6a:	c7 45 f0 40 18 00 00 	movl   $0x1840,-0x10(%ebp)
     a71:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a74:	a3 48 18 00 00       	mov    %eax,0x1848
     a79:	a1 48 18 00 00       	mov    0x1848,%eax
     a7e:	a3 40 18 00 00       	mov    %eax,0x1840
    base.s.size = 0;
     a83:	c7 05 44 18 00 00 00 	movl   $0x0,0x1844
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
     ae0:	a3 48 18 00 00       	mov    %eax,0x1848
      return (void*)(p + 1);
     ae5:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ae8:	83 c0 08             	add    $0x8,%eax
     aeb:	eb 38                	jmp    b25 <malloc+0xde>
    }
    if(p == freep)
     aed:	a1 48 18 00 00       	mov    0x1848,%eax
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

00000b28 <print_stack>:
 * prints the stack of the currently running thread
 * DEBUGGING purposes
 */
void
print_stack()
{
     b28:	55                   	push   %ebp
     b29:	89 e5                	mov    %esp,%ebp
     b2b:	83 ec 28             	sub    $0x28,%esp
  int *newesp = (int*)currentThread->esp;  
     b2e:	a1 60 65 00 00       	mov    0x6560,%eax
     b33:	8b 40 04             	mov    0x4(%eax),%eax
     b36:	89 45 f4             	mov    %eax,-0xc(%ebp)
  printf(1,"stack for thread %d \n",currentThread->tid);
     b39:	a1 60 65 00 00       	mov    0x6560,%eax
     b3e:	8b 00                	mov    (%eax),%eax
     b40:	89 44 24 08          	mov    %eax,0x8(%esp)
     b44:	c7 44 24 04 bc 12 00 	movl   $0x12bc,0x4(%esp)
     b4b:	00 
     b4c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     b53:	e8 0b fc ff ff       	call   763 <printf>
  while((newesp < (int *)currentThread->ebp))
     b58:	eb 3c                	jmp    b96 <print_stack+0x6e>
  {
    printf(1,"add:%x ",newesp);
     b5a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b5d:	89 44 24 08          	mov    %eax,0x8(%esp)
     b61:	c7 44 24 04 d2 12 00 	movl   $0x12d2,0x4(%esp)
     b68:	00 
     b69:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     b70:	e8 ee fb ff ff       	call   763 <printf>
      printf(1,"val:%x\n",*newesp);
     b75:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b78:	8b 00                	mov    (%eax),%eax
     b7a:	89 44 24 08          	mov    %eax,0x8(%esp)
     b7e:	c7 44 24 04 da 12 00 	movl   $0x12da,0x4(%esp)
     b85:	00 
     b86:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     b8d:	e8 d1 fb ff ff       	call   763 <printf>
    newesp++;
     b92:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
void
print_stack()
{
  int *newesp = (int*)currentThread->esp;  
  printf(1,"stack for thread %d \n",currentThread->tid);
  while((newesp < (int *)currentThread->ebp))
     b96:	a1 60 65 00 00       	mov    0x6560,%eax
     b9b:	8b 40 08             	mov    0x8(%eax),%eax
     b9e:	3b 45 f4             	cmp    -0xc(%ebp),%eax
     ba1:	77 b7                	ja     b5a <print_stack+0x32>
    printf(1,"add:%x ",newesp);
      printf(1,"val:%x\n",*newesp);
    newesp++;
  }

}
     ba3:	c9                   	leave  
     ba4:	c3                   	ret    

00000ba5 <getNextThread>:
 * returns the next thread in line to run
 * if none exists it returns -1
 */
int
getNextThread(int j)
{
     ba5:	55                   	push   %ebp
     ba6:	89 e5                	mov    %esp,%ebp
     ba8:	83 ec 10             	sub    $0x10,%esp
  int i=j+1;
     bab:	8b 45 08             	mov    0x8(%ebp),%eax
     bae:	83 c0 01             	add    $0x1,%eax
     bb1:	89 45 fc             	mov    %eax,-0x4(%ebp)
  if(i==MAX_THREAD)
     bb4:	83 7d fc 40          	cmpl   $0x40,-0x4(%ebp)
     bb8:	75 07                	jne    bc1 <getNextThread+0x1c>
    i=0;
     bba:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  uthread_p t=&tTable.table[i];
     bc1:	8b 45 fc             	mov    -0x4(%ebp),%eax
     bc4:	69 c0 24 01 00 00    	imul   $0x124,%eax,%eax
     bca:	05 60 18 00 00       	add    $0x1860,%eax
     bcf:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(i!=j)
     bd2:	eb 3b                	jmp    c0f <getNextThread+0x6a>
  {
    if(t->state==T_RUNNABLE)
     bd4:	8b 45 f8             	mov    -0x8(%ebp),%eax
     bd7:	8b 40 10             	mov    0x10(%eax),%eax
     bda:	83 f8 03             	cmp    $0x3,%eax
     bdd:	75 05                	jne    be4 <getNextThread+0x3f>
      return i;
     bdf:	8b 45 fc             	mov    -0x4(%ebp),%eax
     be2:	eb 38                	jmp    c1c <getNextThread+0x77>
    i++;
     be4:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    if(i==MAX_THREAD)
     be8:	83 7d fc 40          	cmpl   $0x40,-0x4(%ebp)
     bec:	75 1a                	jne    c08 <getNextThread+0x63>
    {
     i=0;
     bee:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
     t=&tTable.table[i];
     bf5:	8b 45 fc             	mov    -0x4(%ebp),%eax
     bf8:	69 c0 24 01 00 00    	imul   $0x124,%eax,%eax
     bfe:	05 60 18 00 00       	add    $0x1860,%eax
     c03:	89 45 f8             	mov    %eax,-0x8(%ebp)
     c06:	eb 07                	jmp    c0f <getNextThread+0x6a>
   }
   else
    t++;
     c08:	81 45 f8 24 01 00 00 	addl   $0x124,-0x8(%ebp)
{
  int i=j+1;
  if(i==MAX_THREAD)
    i=0;
  uthread_p t=&tTable.table[i];
  while(i!=j)
     c0f:	8b 45 fc             	mov    -0x4(%ebp),%eax
     c12:	3b 45 08             	cmp    0x8(%ebp),%eax
     c15:	75 bd                	jne    bd4 <getNextThread+0x2f>
   }
   else
    t++;

}
return -1;
     c17:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
     c1c:	c9                   	leave  
     c1d:	c3                   	ret    

00000c1e <allocThread>:
 * allocates a spot for a new thread
 * if none exist it returns NULL
 */
static uthread_p
allocThread()
{
     c1e:	55                   	push   %ebp
     c1f:	89 e5                	mov    %esp,%ebp
     c21:	83 ec 28             	sub    $0x28,%esp
  int i,j;
  uthread_p t;
  
  for (t=tTable.table,i=0 ; t < &tTable.table[MAX_THREAD]; t++,i++)
     c24:	c7 45 ec 60 18 00 00 	movl   $0x1860,-0x14(%ebp)
     c2b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     c32:	eb 15                	jmp    c49 <allocThread+0x2b>
  {
    if(t->state==T_FREE)
     c34:	8b 45 ec             	mov    -0x14(%ebp),%eax
     c37:	8b 40 10             	mov    0x10(%eax),%eax
     c3a:	85 c0                	test   %eax,%eax
     c3c:	74 1e                	je     c5c <allocThread+0x3e>
allocThread()
{
  int i,j;
  uthread_p t;
  
  for (t=tTable.table,i=0 ; t < &tTable.table[MAX_THREAD]; t++,i++)
     c3e:	81 45 ec 24 01 00 00 	addl   $0x124,-0x14(%ebp)
     c45:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     c49:	81 7d ec 60 61 00 00 	cmpl   $0x6160,-0x14(%ebp)
     c50:	72 e2                	jb     c34 <allocThread+0x16>
  {
    if(t->state==T_FREE)
      goto found;
  }
  return 0;
     c52:	b8 00 00 00 00       	mov    $0x0,%eax
     c57:	e9 a3 00 00 00       	jmp    cff <allocThread+0xe1>
  uthread_p t;
  
  for (t=tTable.table,i=0 ; t < &tTable.table[MAX_THREAD]; t++,i++)
  {
    if(t->state==T_FREE)
      goto found;
     c5c:	90                   	nop
  }
  return 0;
  
  found:
  //Init all fields
  t->tid=i;
     c5d:	8b 45 ec             	mov    -0x14(%ebp),%eax
     c60:	8b 55 f4             	mov    -0xc(%ebp),%edx
     c63:	89 10                	mov    %edx,(%eax)
  if(i==0) //main thread init
     c65:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     c69:	75 1c                	jne    c87 <allocThread+0x69>
  {
    STORE_ESP(t->esp);
     c6b:	89 e2                	mov    %esp,%edx
     c6d:	8b 45 ec             	mov    -0x14(%ebp),%eax
     c70:	89 50 04             	mov    %edx,0x4(%eax)
    STORE_EBP(t->ebp);
     c73:	89 ea                	mov    %ebp,%edx
     c75:	8b 45 ec             	mov    -0x14(%ebp),%eax
     c78:	89 50 08             	mov    %edx,0x8(%eax)
    t->firstTime=0;
     c7b:	8b 45 ec             	mov    -0x14(%ebp),%eax
     c7e:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
     c85:	eb 3b                	jmp    cc2 <allocThread+0xa4>
  }
  else
  {
    t->stack=(char*)malloc(STACK_SIZE);
     c87:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
     c8e:	e8 b4 fd ff ff       	call   a47 <malloc>
     c93:	8b 55 ec             	mov    -0x14(%ebp),%edx
     c96:	89 42 0c             	mov    %eax,0xc(%edx)
    t->ebp=(int)t->stack+STACK_SIZE;
     c99:	8b 45 ec             	mov    -0x14(%ebp),%eax
     c9c:	8b 40 0c             	mov    0xc(%eax),%eax
     c9f:	05 00 10 00 00       	add    $0x1000,%eax
     ca4:	89 c2                	mov    %eax,%edx
     ca6:	8b 45 ec             	mov    -0x14(%ebp),%eax
     ca9:	89 50 08             	mov    %edx,0x8(%eax)
    t->esp=t->ebp;
     cac:	8b 45 ec             	mov    -0x14(%ebp),%eax
     caf:	8b 50 08             	mov    0x8(%eax),%edx
     cb2:	8b 45 ec             	mov    -0x14(%ebp),%eax
     cb5:	89 50 04             	mov    %edx,0x4(%eax)
    t->firstTime=1;
     cb8:	8b 45 ec             	mov    -0x14(%ebp),%eax
     cbb:	c7 40 14 01 00 00 00 	movl   $0x1,0x14(%eax)
  }
  
  t->waitingFor=-1;
     cc2:	8b 45 ec             	mov    -0x14(%ebp),%eax
     cc5:	c7 80 20 01 00 00 ff 	movl   $0xffffffff,0x120(%eax)
     ccc:	ff ff ff 
  
  for(j=0;j<MAX_THREAD;j++)
     ccf:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     cd6:	eb 14                	jmp    cec <allocThread+0xce>
  {
    t->waitedOn[j]=-1;
     cd8:	8b 45 ec             	mov    -0x14(%ebp),%eax
     cdb:	8b 55 f0             	mov    -0x10(%ebp),%edx
     cde:	83 c2 08             	add    $0x8,%edx
     ce1:	c7 04 90 ff ff ff ff 	movl   $0xffffffff,(%eax,%edx,4)
    t->firstTime=1;
  }
  
  t->waitingFor=-1;
  
  for(j=0;j<MAX_THREAD;j++)
     ce8:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     cec:	83 7d f0 3f          	cmpl   $0x3f,-0x10(%ebp)
     cf0:	7e e6                	jle    cd8 <allocThread+0xba>
  {
    t->waitedOn[j]=-1;
  }
   
  t->state=T_UNINIT;
     cf2:	8b 45 ec             	mov    -0x14(%ebp),%eax
     cf5:	c7 40 10 01 00 00 00 	movl   $0x1,0x10(%eax)
  
    
  return t;
     cfc:	8b 45 ec             	mov    -0x14(%ebp),%eax
}
     cff:	c9                   	leave  
     d00:	c3                   	ret    

00000d01 <uthread_init>:
/*
 * initializes all the uthread structures
 */
int
uthread_init()
{   
     d01:	55                   	push   %ebp
     d02:	89 e5                	mov    %esp,%ebp
     d04:	83 ec 28             	sub    $0x28,%esp
  //Initialize table
  int i;
  
  for(i=0;i<MAX_THREAD;i++)
     d07:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     d0e:	eb 18                	jmp    d28 <uthread_init+0x27>
  {
    tTable.table[i].state=T_FREE;
     d10:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d13:	69 c0 24 01 00 00    	imul   $0x124,%eax,%eax
     d19:	05 70 18 00 00       	add    $0x1870,%eax
     d1e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
uthread_init()
{   
  //Initialize table
  int i;
  
  for(i=0;i<MAX_THREAD;i++)
     d24:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     d28:	83 7d f4 3f          	cmpl   $0x3f,-0xc(%ebp)
     d2c:	7e e2                	jle    d10 <uthread_init+0xf>
  {
    tTable.table[i].state=T_FREE;
  }
  
 //allocate the main thread
  currentThread = allocThread();
     d2e:	e8 eb fe ff ff       	call   c1e <allocThread>
     d33:	a3 60 65 00 00       	mov    %eax,0x6560
  if(currentThread==0)
     d38:	a1 60 65 00 00       	mov    0x6560,%eax
     d3d:	85 c0                	test   %eax,%eax
     d3f:	75 07                	jne    d48 <uthread_init+0x47>
    return -1;
     d41:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     d46:	eb 6b                	jmp    db3 <uthread_init+0xb2>
  
  currentThread->state = T_RUNNING;
     d48:	a1 60 65 00 00       	mov    0x6560,%eax
     d4d:	c7 40 10 02 00 00 00 	movl   $0x2,0x10(%eax)
  //register uthread_yield as signal handler for alarm
  if(signal(SIGALRM,uthread_yield)<0)
     d54:	c7 44 24 04 3b 10 00 	movl   $0x103b,0x4(%esp)
     d5b:	00 
     d5c:	c7 04 24 0e 00 00 00 	movl   $0xe,(%esp)
     d63:	e8 0c f9 ff ff       	call   674 <signal>
     d68:	85 c0                	test   %eax,%eax
     d6a:	79 19                	jns    d85 <uthread_init+0x84>
  {
    printf(1,"Cant register the alarm signal");
     d6c:	c7 44 24 04 e4 12 00 	movl   $0x12e4,0x4(%esp)
     d73:	00 
     d74:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     d7b:	e8 e3 f9 ff ff       	call   763 <printf>
    exit();
     d80:	e8 2f f8 ff ff       	call   5b4 <exit>
  }
  //set new alarm clock
  if(alarm(THREAD_QUANTA)<0)
     d85:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
     d8c:	e8 f3 f8 ff ff       	call   684 <alarm>
     d91:	85 c0                	test   %eax,%eax
     d93:	79 19                	jns    dae <uthread_init+0xad>
  {
    printf(1,"Cant activate alarm system call");
     d95:	c7 44 24 04 04 13 00 	movl   $0x1304,0x4(%esp)
     d9c:	00 
     d9d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     da4:	e8 ba f9 ff ff       	call   763 <printf>
    exit();
     da9:	e8 06 f8 ff ff       	call   5b4 <exit>
  }
  return 0;
     dae:	b8 00 00 00 00       	mov    $0x0,%eax
}
     db3:	c9                   	leave  
     db4:	c3                   	ret    

00000db5 <wrap_func>:

void
wrap_func()
{
     db5:	55                   	push   %ebp
     db6:	89 e5                	mov    %esp,%ebp
     db8:	83 ec 18             	sub    $0x18,%esp
  currentThread->func(currentThread->arguments);
     dbb:	a1 60 65 00 00       	mov    0x6560,%eax
     dc0:	8b 50 18             	mov    0x18(%eax),%edx
     dc3:	a1 60 65 00 00       	mov    0x6560,%eax
     dc8:	8b 40 1c             	mov    0x1c(%eax),%eax
     dcb:	89 04 24             	mov    %eax,(%esp)
     dce:	ff d2                	call   *%edx
  uthread_exit();
     dd0:	e8 6c 00 00 00       	call   e41 <uthread_exit>
}
     dd5:	c9                   	leave  
     dd6:	c3                   	ret    

00000dd7 <uthread_create>:
 * to that function
 * if none can be created it returns -1;
 */
int  
uthread_create(void (*start_func)(void *), void* arg)
{
     dd7:	55                   	push   %ebp
     dd8:	89 e5                	mov    %esp,%ebp
     dda:	53                   	push   %ebx
     ddb:	83 ec 14             	sub    $0x14,%esp
  uint local_esp;
  uthread_p t = allocThread();
     dde:	e8 3b fe ff ff       	call   c1e <allocThread>
     de3:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(t==0)
     de6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     dea:	75 07                	jne    df3 <uthread_create+0x1c>
    return -1;
     dec:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     df1:	eb 48                	jmp    e3b <uthread_create+0x64>

  t->func=start_func;
     df3:	8b 45 f4             	mov    -0xc(%ebp),%eax
     df6:	8b 55 08             	mov    0x8(%ebp),%edx
     df9:	89 50 18             	mov    %edx,0x18(%eax)
  t->arguments=arg;
     dfc:	8b 45 f4             	mov    -0xc(%ebp),%eax
     dff:	8b 55 0c             	mov    0xc(%ebp),%edx
     e02:	89 50 1c             	mov    %edx,0x1c(%eax)
  
  //push starting func and return value on the right stack
  STORE_ESP(local_esp);
     e05:	89 e3                	mov    %esp,%ebx
     e07:	89 5d f0             	mov    %ebx,-0x10(%ebp)
  LOAD_ESP(t->esp);
     e0a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e0d:	8b 40 04             	mov    0x4(%eax),%eax
     e10:	89 c4                	mov    %eax,%esp
  PUSH_FUNC(t->esp,t->ebp,wrap_func);
     e12:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e15:	8b 50 08             	mov    0x8(%eax),%edx
     e18:	b8 b5 0d 00 00       	mov    $0xdb5,%eax
     e1d:	50                   	push   %eax
     e1e:	52                   	push   %edx
     e1f:	89 e2                	mov    %esp,%edx
     e21:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e24:	89 50 04             	mov    %edx,0x4(%eax)
  LOAD_ESP(local_esp);
     e27:	8b 45 f0             	mov    -0x10(%ebp),%eax
     e2a:	89 c4                	mov    %eax,%esp
  
  t->state = T_RUNNABLE;
     e2c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e2f:	c7 40 10 03 00 00 00 	movl   $0x3,0x10(%eax)
  
  return t->tid;
     e36:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e39:	8b 00                	mov    (%eax),%eax
}
     e3b:	83 c4 14             	add    $0x14,%esp
     e3e:	5b                   	pop    %ebx
     e3f:	5d                   	pop    %ebp
     e40:	c3                   	ret    

00000e41 <uthread_exit>:
 * closes the running thread, wakes up all
 * the threads waiting for this one (if they require waking up)
 */
void 
uthread_exit()
{
     e41:	55                   	push   %ebp
     e42:	89 e5                	mov    %esp,%ebp
     e44:	83 ec 28             	sub    $0x28,%esp
  alarm(0); //clear the alarm so as not to disturb running of function
     e47:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     e4e:	e8 31 f8 ff ff       	call   684 <alarm>
  int new,i;
  //wakeup all threads waiting for this one
  for(i=0;i<MAX_THREAD;i++)
     e53:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     e5a:	eb 51                	jmp    ead <uthread_exit+0x6c>
  {
   if(currentThread->waitedOn[i]==1)
     e5c:	a1 60 65 00 00       	mov    0x6560,%eax
     e61:	8b 55 f4             	mov    -0xc(%ebp),%edx
     e64:	83 c2 08             	add    $0x8,%edx
     e67:	8b 04 90             	mov    (%eax,%edx,4),%eax
     e6a:	83 f8 01             	cmp    $0x1,%eax
     e6d:	75 3a                	jne    ea9 <uthread_exit+0x68>
   {
     tTable.table[i].waitingFor=-1; //release thread i from waiting
     e6f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e72:	69 c0 24 01 00 00    	imul   $0x124,%eax,%eax
     e78:	05 80 19 00 00       	add    $0x1980,%eax
     e7d:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)
     currentThread->waitedOn[i]=0; //not necessary maybe   
     e83:	a1 60 65 00 00       	mov    0x6560,%eax
     e88:	8b 55 f4             	mov    -0xc(%ebp),%edx
     e8b:	83 c2 08             	add    $0x8,%edx
     e8e:	c7 04 90 00 00 00 00 	movl   $0x0,(%eax,%edx,4)
     tTable.table[i].state=T_RUNNABLE;
     e95:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e98:	69 c0 24 01 00 00    	imul   $0x124,%eax,%eax
     e9e:	05 70 18 00 00       	add    $0x1870,%eax
     ea3:	c7 00 03 00 00 00    	movl   $0x3,(%eax)
uthread_exit()
{
  alarm(0); //clear the alarm so as not to disturb running of function
  int new,i;
  //wakeup all threads waiting for this one
  for(i=0;i<MAX_THREAD;i++)
     ea9:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     ead:	83 7d f4 3f          	cmpl   $0x3f,-0xc(%ebp)
     eb1:	7e a9                	jle    e5c <uthread_exit+0x1b>
     tTable.table[i].state=T_RUNNABLE;
   }
  }
  
  //pick next thread
  new=getNextThread(currentThread->tid);
     eb3:	a1 60 65 00 00       	mov    0x6560,%eax
     eb8:	8b 00                	mov    (%eax),%eax
     eba:	89 04 24             	mov    %eax,(%esp)
     ebd:	e8 e3 fc ff ff       	call   ba5 <getNextThread>
     ec2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  
  //release all resources and zero all fields
  if(currentThread->tid!=0)
     ec5:	a1 60 65 00 00       	mov    0x6560,%eax
     eca:	8b 00                	mov    (%eax),%eax
     ecc:	85 c0                	test   %eax,%eax
     ece:	74 10                	je     ee0 <uthread_exit+0x9f>
    free(currentThread->stack);
     ed0:	a1 60 65 00 00       	mov    0x6560,%eax
     ed5:	8b 40 0c             	mov    0xc(%eax),%eax
     ed8:	89 04 24             	mov    %eax,(%esp)
     edb:	e8 38 fa ff ff       	call   918 <free>
  currentThread->tid=-1;
     ee0:	a1 60 65 00 00       	mov    0x6560,%eax
     ee5:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)
  currentThread->esp=-1;
     eeb:	a1 60 65 00 00       	mov    0x6560,%eax
     ef0:	c7 40 04 ff ff ff ff 	movl   $0xffffffff,0x4(%eax)
  currentThread->ebp=-1;
     ef7:	a1 60 65 00 00       	mov    0x6560,%eax
     efc:	c7 40 08 ff ff ff ff 	movl   $0xffffffff,0x8(%eax)
  currentThread->func=0;
     f03:	a1 60 65 00 00       	mov    0x6560,%eax
     f08:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)
  currentThread->arguments=0;
     f0f:	a1 60 65 00 00       	mov    0x6560,%eax
     f14:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
  currentThread->stack=0;
     f1b:	a1 60 65 00 00       	mov    0x6560,%eax
     f20:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
  currentThread->firstTime=1;
     f27:	a1 60 65 00 00       	mov    0x6560,%eax
     f2c:	c7 40 14 01 00 00 00 	movl   $0x1,0x14(%eax)
  currentThread->state=T_FREE;
     f33:	a1 60 65 00 00       	mov    0x6560,%eax
     f38:	c7 40 10 00 00 00 00 	movl   $0x0,0x10(%eax)
  
  //load new thread
  if(new>=0)
     f3f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     f43:	78 7a                	js     fbf <uthread_exit+0x17e>
  {
    currentThread=&tTable.table[new];
     f45:	8b 45 f0             	mov    -0x10(%ebp),%eax
     f48:	69 c0 24 01 00 00    	imul   $0x124,%eax,%eax
     f4e:	05 60 18 00 00       	add    $0x1860,%eax
     f53:	a3 60 65 00 00       	mov    %eax,0x6560
    currentThread->state=T_RUNNING;
     f58:	a1 60 65 00 00       	mov    0x6560,%eax
     f5d:	c7 40 10 02 00 00 00 	movl   $0x2,0x10(%eax)
    LOAD_ESP(currentThread->esp);
     f64:	a1 60 65 00 00       	mov    0x6560,%eax
     f69:	8b 40 04             	mov    0x4(%eax),%eax
     f6c:	89 c4                	mov    %eax,%esp
    LOAD_EBP(currentThread->ebp);
     f6e:	a1 60 65 00 00       	mov    0x6560,%eax
     f73:	8b 40 08             	mov    0x8(%eax),%eax
     f76:	89 c5                	mov    %eax,%ebp
    
    //set new alarm clock
    if(alarm(THREAD_QUANTA)<0)
     f78:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
     f7f:	e8 00 f7 ff ff       	call   684 <alarm>
     f84:	85 c0                	test   %eax,%eax
     f86:	79 19                	jns    fa1 <uthread_exit+0x160>
    {
      printf(1,"Cant activate alarm system call");
     f88:	c7 44 24 04 04 13 00 	movl   $0x1304,0x4(%esp)
     f8f:	00 
     f90:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     f97:	e8 c7 f7 ff ff       	call   763 <printf>
      exit();
     f9c:	e8 13 f6 ff ff       	call   5b4 <exit>
    }
    
    if(currentThread->firstTime==1)
     fa1:	a1 60 65 00 00       	mov    0x6560,%eax
     fa6:	8b 40 14             	mov    0x14(%eax),%eax
     fa9:	83 f8 01             	cmp    $0x1,%eax
     fac:	75 10                	jne    fbe <uthread_exit+0x17d>
    {
      currentThread->firstTime=0;
     fae:	a1 60 65 00 00       	mov    0x6560,%eax
     fb3:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
      POP_AND_RET();
     fba:	5d                   	pop    %ebp
     fbb:	c3                   	ret    
     fbc:	eb 01                	jmp    fbf <uthread_exit+0x17e>
    }
    else
    {  
    POP_ALL_REGISTERS();
     fbe:	61                   	popa   
    }
  }
}
     fbf:	c9                   	leave  
     fc0:	c3                   	ret    

00000fc1 <uthread_join>:
/*
 * causes this thread to wait for the finish of another thread
 */
int
uthread_join(int tid)
{
     fc1:	55                   	push   %ebp
     fc2:	89 e5                	mov    %esp,%ebp
     fc4:	83 ec 18             	sub    $0x18,%esp
  if((&tTable.table[tid])->state==T_FREE)
     fc7:	8b 45 08             	mov    0x8(%ebp),%eax
     fca:	69 c0 24 01 00 00    	imul   $0x124,%eax,%eax
     fd0:	05 60 18 00 00       	add    $0x1860,%eax
     fd5:	8b 40 10             	mov    0x10(%eax),%eax
     fd8:	85 c0                	test   %eax,%eax
     fda:	75 07                	jne    fe3 <uthread_join+0x22>
    return -1;
     fdc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     fe1:	eb 56                	jmp    1039 <uthread_join+0x78>
  else
  {
    alarm(0); //clear the alarm so as not to disturb running of function
     fe3:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     fea:	e8 95 f6 ff ff       	call   684 <alarm>
    currentThread->waitingFor=tid;
     fef:	a1 60 65 00 00       	mov    0x6560,%eax
     ff4:	8b 55 08             	mov    0x8(%ebp),%edx
     ff7:	89 90 20 01 00 00    	mov    %edx,0x120(%eax)
    tTable.table[tid].waitedOn[currentThread->tid]=1;
     ffd:	a1 60 65 00 00       	mov    0x6560,%eax
    1002:	8b 08                	mov    (%eax),%ecx
    1004:	8b 55 08             	mov    0x8(%ebp),%edx
    1007:	89 d0                	mov    %edx,%eax
    1009:	c1 e0 03             	shl    $0x3,%eax
    100c:	01 d0                	add    %edx,%eax
    100e:	c1 e0 03             	shl    $0x3,%eax
    1011:	01 d0                	add    %edx,%eax
    1013:	01 c8                	add    %ecx,%eax
    1015:	83 c0 08             	add    $0x8,%eax
    1018:	c7 04 85 60 18 00 00 	movl   $0x1,0x1860(,%eax,4)
    101f:	01 00 00 00 
    currentThread->state=T_SLEEPING;
    1023:	a1 60 65 00 00       	mov    0x6560,%eax
    1028:	c7 40 10 04 00 00 00 	movl   $0x4,0x10(%eax)
    uthread_yield();
    102f:	e8 07 00 00 00       	call   103b <uthread_yield>
    return 1;
    1034:	b8 01 00 00 00       	mov    $0x1,%eax
  }
}
    1039:	c9                   	leave  
    103a:	c3                   	ret    

0000103b <uthread_yield>:
/*
 * yields the run-time of the current thread to another thread
 */
void 
uthread_yield()
{
    103b:	55                   	push   %ebp
    103c:	89 e5                	mov    %esp,%ebp
    103e:	83 ec 28             	sub    $0x28,%esp
  alarm(0); //clear the alarm so as not to disturb running of function
    1041:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1048:	e8 37 f6 ff ff       	call   684 <alarm>
  int new=getNextThread(currentThread->tid);
    104d:	a1 60 65 00 00       	mov    0x6560,%eax
    1052:	8b 00                	mov    (%eax),%eax
    1054:	89 04 24             	mov    %eax,(%esp)
    1057:	e8 49 fb ff ff       	call   ba5 <getNextThread>
    105c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(new==-1)
    105f:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
    1063:	75 2d                	jne    1092 <uthread_yield+0x57>
  {
    if(alarm(THREAD_QUANTA)<0)
    1065:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
    106c:	e8 13 f6 ff ff       	call   684 <alarm>
    1071:	85 c0                	test   %eax,%eax
    1073:	0f 89 c1 00 00 00    	jns    113a <uthread_yield+0xff>
    {
      printf(1,"Cant activate alarm system call\n");
    1079:	c7 44 24 04 24 13 00 	movl   $0x1324,0x4(%esp)
    1080:	00 
    1081:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1088:	e8 d6 f6 ff ff       	call   763 <printf>
      exit();
    108d:	e8 22 f5 ff ff       	call   5b4 <exit>
    } 
  }
  else
  {
    //store all leaving thread registers and pointers
    PUSH_ALL_REGISTERS();
    1092:	60                   	pusha  
    STORE_ESP(currentThread->esp);
    1093:	a1 60 65 00 00       	mov    0x6560,%eax
    1098:	89 e2                	mov    %esp,%edx
    109a:	89 50 04             	mov    %edx,0x4(%eax)
    STORE_EBP(currentThread->ebp);
    109d:	a1 60 65 00 00       	mov    0x6560,%eax
    10a2:	89 ea                	mov    %ebp,%edx
    10a4:	89 50 08             	mov    %edx,0x8(%eax)
    
    //change thread state
    if(currentThread->state==T_RUNNING) //might be sleeping from join operation
    10a7:	a1 60 65 00 00       	mov    0x6560,%eax
    10ac:	8b 40 10             	mov    0x10(%eax),%eax
    10af:	83 f8 02             	cmp    $0x2,%eax
    10b2:	75 0c                	jne    10c0 <uthread_yield+0x85>
      currentThread->state=T_RUNNABLE;
    10b4:	a1 60 65 00 00       	mov    0x6560,%eax
    10b9:	c7 40 10 03 00 00 00 	movl   $0x3,0x10(%eax)

    currentThread=&tTable.table[new];
    10c0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    10c3:	69 c0 24 01 00 00    	imul   $0x124,%eax,%eax
    10c9:	05 60 18 00 00       	add    $0x1860,%eax
    10ce:	a3 60 65 00 00       	mov    %eax,0x6560

    //load all new thread registers and pointers
    LOAD_ESP(currentThread->esp);
    10d3:	a1 60 65 00 00       	mov    0x6560,%eax
    10d8:	8b 40 04             	mov    0x4(%eax),%eax
    10db:	89 c4                	mov    %eax,%esp
    LOAD_EBP(currentThread->ebp);
    10dd:	a1 60 65 00 00       	mov    0x6560,%eax
    10e2:	8b 40 08             	mov    0x8(%eax),%eax
    10e5:	89 c5                	mov    %eax,%ebp
    //set new alram clock
    if(alarm(THREAD_QUANTA)<0)
    10e7:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
    10ee:	e8 91 f5 ff ff       	call   684 <alarm>
    10f3:	85 c0                	test   %eax,%eax
    10f5:	79 19                	jns    1110 <uthread_yield+0xd5>
    {
      printf(1,"Cant activate alarm system call\n");
    10f7:	c7 44 24 04 24 13 00 	movl   $0x1324,0x4(%esp)
    10fe:	00 
    10ff:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1106:	e8 58 f6 ff ff       	call   763 <printf>
      exit();
    110b:	e8 a4 f4 ff ff       	call   5b4 <exit>
    }  
    currentThread->state=T_RUNNING;
    1110:	a1 60 65 00 00       	mov    0x6560,%eax
    1115:	c7 40 10 02 00 00 00 	movl   $0x2,0x10(%eax)
    
    if(currentThread->firstTime==1)
    111c:	a1 60 65 00 00       	mov    0x6560,%eax
    1121:	8b 40 14             	mov    0x14(%eax),%eax
    1124:	83 f8 01             	cmp    $0x1,%eax
    1127:	75 10                	jne    1139 <uthread_yield+0xfe>
    {
    currentThread->firstTime=0;
    1129:	a1 60 65 00 00       	mov    0x6560,%eax
    112e:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
    POP_AND_RET();
    1135:	5d                   	pop    %ebp
    1136:	c3                   	ret    
    1137:	eb 01                	jmp    113a <uthread_yield+0xff>
    }
    else
    {
      POP_ALL_REGISTERS();
    1139:	61                   	popa   
    }
  }
}
    113a:	c9                   	leave  
    113b:	c3                   	ret    

0000113c <uthread_self>:

int
uthread_self(void)
{
    113c:	55                   	push   %ebp
    113d:	89 e5                	mov    %esp,%ebp
  return currentThread->tid;
    113f:	a1 60 65 00 00       	mov    0x6560,%eax
    1144:	8b 00                	mov    (%eax),%eax
    1146:	5d                   	pop    %ebp
    1147:	c3                   	ret    

00001148 <xchg>:
#include "fs.h"
#include "uthread.h"

static inline uint
xchg(volatile uint *addr, uint newval)
{
    1148:	55                   	push   %ebp
    1149:	89 e5                	mov    %esp,%ebp
    114b:	53                   	push   %ebx
    114c:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
               "+m" (*addr), "=a" (result) :
    114f:	8b 55 08             	mov    0x8(%ebp),%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
    1152:	8b 45 0c             	mov    0xc(%ebp),%eax
               "+m" (*addr), "=a" (result) :
    1155:	8b 4d 08             	mov    0x8(%ebp),%ecx
xchg(volatile uint *addr, uint newval)
{
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
    1158:	89 c3                	mov    %eax,%ebx
    115a:	89 d8                	mov    %ebx,%eax
    115c:	f0 87 02             	lock xchg %eax,(%edx)
    115f:	89 c3                	mov    %eax,%ebx
    1161:	89 5d f8             	mov    %ebx,-0x8(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
    1164:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
    1167:	83 c4 10             	add    $0x10,%esp
    116a:	5b                   	pop    %ebx
    116b:	5d                   	pop    %ebp
    116c:	c3                   	ret    

0000116d <binary_semaphore_init>:
semaphore->taken=0;
}*/

void
binary_semaphore_init(struct binary_semaphore* semaphore, int value)
{
    116d:	55                   	push   %ebp
    116e:	89 e5                	mov    %esp,%ebp
    1170:	83 ec 08             	sub    $0x8,%esp
  semaphore->init=0;
    1173:	8b 45 08             	mov    0x8(%ebp),%eax
    1176:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
  
  if(value!=0)
    117d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1181:	74 0c                	je     118f <binary_semaphore_init+0x22>
    semaphore->thread=-1;
    1183:	8b 45 08             	mov    0x8(%ebp),%eax
    1186:	c7 40 04 ff ff ff ff 	movl   $0xffffffff,0x4(%eax)
    118d:	eb 0b                	jmp    119a <binary_semaphore_init+0x2d>
  else 
    semaphore->thread = uthread_self();
    118f:	e8 a8 ff ff ff       	call   113c <uthread_self>
    1194:	8b 55 08             	mov    0x8(%ebp),%edx
    1197:	89 42 04             	mov    %eax,0x4(%edx)
  
  semaphore->locked = value;
    119a:	8b 55 0c             	mov    0xc(%ebp),%edx
    119d:	8b 45 08             	mov    0x8(%ebp),%eax
    11a0:	89 10                	mov    %edx,(%eax)
 // semaphore->taken=0;
  semaphore->init=1;
    11a2:	8b 45 08             	mov    0x8(%ebp),%eax
    11a5:	c7 40 08 01 00 00 00 	movl   $0x1,0x8(%eax)
  
}
    11ac:	c9                   	leave  
    11ad:	c3                   	ret    

000011ae <binary_semaphore_down>:

void 
binary_semaphore_down(struct binary_semaphore* semaphore)
{
    11ae:	55                   	push   %ebp
    11af:	89 e5                	mov    %esp,%ebp
    11b1:	83 ec 28             	sub    $0x28,%esp
  //semaphore_acquire(semaphore);
  if(semaphore->init==0)
    11b4:	8b 45 08             	mov    0x8(%ebp),%eax
    11b7:	8b 40 08             	mov    0x8(%eax),%eax
    11ba:	85 c0                	test   %eax,%eax
    11bc:	75 20                	jne    11de <binary_semaphore_down+0x30>
  {
   printf(1,"(down)semaphore uninitialized yet (thread %d)\n",semaphore->thread);
    11be:	8b 45 08             	mov    0x8(%ebp),%eax
    11c1:	8b 40 04             	mov    0x4(%eax),%eax
    11c4:	89 44 24 08          	mov    %eax,0x8(%esp)
    11c8:	c7 44 24 04 48 13 00 	movl   $0x1348,0x4(%esp)
    11cf:	00 
    11d0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    11d7:	e8 87 f5 ff ff       	call   763 <printf>
    return;
    11dc:	eb 3a                	jmp    1218 <binary_semaphore_down+0x6a>
  }
  
  
  int i= uthread_self();
    11de:	e8 59 ff ff ff       	call   113c <uthread_self>
    11e3:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(semaphore->thread!=i)
    11e6:	8b 45 08             	mov    0x8(%ebp),%eax
    11e9:	8b 40 04             	mov    0x4(%eax),%eax
    11ec:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    11ef:	74 27                	je     1218 <binary_semaphore_down+0x6a>
  {
    while(xchg(&semaphore->locked, 0) == 0) //means the semaphore is taken allready
    11f1:	eb 05                	jmp    11f8 <binary_semaphore_down+0x4a>
    {
      uthread_yield();
    11f3:	e8 43 fe ff ff       	call   103b <uthread_yield>
  
  
  int i= uthread_self();
  if(semaphore->thread!=i)
  {
    while(xchg(&semaphore->locked, 0) == 0) //means the semaphore is taken allready
    11f8:	8b 45 08             	mov    0x8(%ebp),%eax
    11fb:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1202:	00 
    1203:	89 04 24             	mov    %eax,(%esp)
    1206:	e8 3d ff ff ff       	call   1148 <xchg>
    120b:	85 c0                	test   %eax,%eax
    120d:	74 e4                	je     11f3 <binary_semaphore_down+0x45>
    {
      uthread_yield();
    }
    semaphore->thread = i;
    120f:	8b 45 08             	mov    0x8(%ebp),%eax
    1212:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1215:	89 50 04             	mov    %edx,0x4(%eax)
  }
  //semaphore_release(semaphore);
}
    1218:	c9                   	leave  
    1219:	c3                   	ret    

0000121a <binary_semaphore_up>:

void 
binary_semaphore_up(struct binary_semaphore* semaphore)
{
    121a:	55                   	push   %ebp
    121b:	89 e5                	mov    %esp,%ebp
    121d:	83 ec 28             	sub    $0x28,%esp
  //semaphore_acquire(semaphore);
    if(semaphore->init==0)
    1220:	8b 45 08             	mov    0x8(%ebp),%eax
    1223:	8b 40 08             	mov    0x8(%eax),%eax
    1226:	85 c0                	test   %eax,%eax
    1228:	75 20                	jne    124a <binary_semaphore_up+0x30>
    {
    printf(1,"(up)semaphore uninitialized yet (thread %d)\n",semaphore->thread);
    122a:	8b 45 08             	mov    0x8(%ebp),%eax
    122d:	8b 40 04             	mov    0x4(%eax),%eax
    1230:	89 44 24 08          	mov    %eax,0x8(%esp)
    1234:	c7 44 24 04 78 13 00 	movl   $0x1378,0x4(%esp)
    123b:	00 
    123c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1243:	e8 1b f5 ff ff       	call   763 <printf>
    return;
    1248:	eb 2f                	jmp    1279 <binary_semaphore_up+0x5f>
    }
  
  int i= uthread_self();
    124a:	e8 ed fe ff ff       	call   113c <uthread_self>
    124f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if( semaphore->locked == 0 && semaphore->thread == i)
    1252:	8b 45 08             	mov    0x8(%ebp),%eax
    1255:	8b 00                	mov    (%eax),%eax
    1257:	85 c0                	test   %eax,%eax
    1259:	75 1e                	jne    1279 <binary_semaphore_up+0x5f>
    125b:	8b 45 08             	mov    0x8(%ebp),%eax
    125e:	8b 40 04             	mov    0x4(%eax),%eax
    1261:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1264:	75 13                	jne    1279 <binary_semaphore_up+0x5f>
  {
      semaphore->thread = -1;
    1266:	8b 45 08             	mov    0x8(%ebp),%eax
    1269:	c7 40 04 ff ff ff ff 	movl   $0xffffffff,0x4(%eax)
      semaphore->locked = 1;
    1270:	8b 45 08             	mov    0x8(%ebp),%eax
    1273:	c7 00 01 00 00 00    	movl   $0x1,(%eax)

  }
//semaphore_release(semaphore);
    1279:	c9                   	leave  
    127a:	c3                   	ret    
