
_FSSP:     file format elf32-i386


Disassembly of section .text:

00000000 <initNext>:
static int print=0;
static int fire=0;
static int in=0;
void
initNext()
{
       0:	55                   	push   %ebp
       1:	89 e5                	mov    %esp,%ebp
  next[0][0][0]=0;
       3:	c7 05 20 1c 00 00 00 	movl   $0x0,0x1c20
       a:	00 00 00 
  next[0][0][1]=0;
       d:	c7 05 24 1c 00 00 00 	movl   $0x0,0x1c24
      14:	00 00 00 
  next[0][0][2]=2;
      17:	c7 05 28 1c 00 00 02 	movl   $0x2,0x1c28
      1e:	00 00 00 
  next[0][0][3]=0;
      21:	c7 05 2c 1c 00 00 00 	movl   $0x0,0x1c2c
      28:	00 00 00 
  next[0][0][4]=0;
      2b:	c7 05 30 1c 00 00 00 	movl   $0x0,0x1c30
      32:	00 00 00 
  next[0][1][0]=1;
      35:	c7 05 34 1c 00 00 01 	movl   $0x1,0x1c34
      3c:	00 00 00 
  next[0][1][1]=1;
      3f:	c7 05 38 1c 00 00 01 	movl   $0x1,0x1c38
      46:	00 00 00 
  next[0][1][2]=-1;
      49:	c7 05 3c 1c 00 00 ff 	movl   $0xffffffff,0x1c3c
      50:	ff ff ff 
  next[0][1][3]=-1;
      53:	c7 05 40 1c 00 00 ff 	movl   $0xffffffff,0x1c40
      5a:	ff ff ff 
  next[0][1][4]=1;
      5d:	c7 05 44 1c 00 00 01 	movl   $0x1,0x1c44
      64:	00 00 00 
  next[0][2][0]=0;
      67:	c7 05 48 1c 00 00 00 	movl   $0x0,0x1c48
      6e:	00 00 00 
  next[0][2][1]=-1;
      71:	c7 05 4c 1c 00 00 ff 	movl   $0xffffffff,0x1c4c
      78:	ff ff ff 
  next[0][2][2]=2;
      7b:	c7 05 50 1c 00 00 02 	movl   $0x2,0x1c50
      82:	00 00 00 
  next[0][2][3]=3;
      85:	c7 05 54 1c 00 00 03 	movl   $0x3,0x1c54
      8c:	00 00 00 
  next[0][2][4]=0;
      8f:	c7 05 58 1c 00 00 00 	movl   $0x0,0x1c58
      96:	00 00 00 
  next[0][3][0]=0;
      99:	c7 05 5c 1c 00 00 00 	movl   $0x0,0x1c5c
      a0:	00 00 00 
  next[0][3][1]=3;
      a3:	c7 05 60 1c 00 00 03 	movl   $0x3,0x1c60
      aa:	00 00 00 
  next[0][3][2]=-1;
      ad:	c7 05 64 1c 00 00 ff 	movl   $0xffffffff,0x1c64
      b4:	ff ff ff 
  next[0][3][3]=-1;
      b7:	c7 05 68 1c 00 00 ff 	movl   $0xffffffff,0x1c68
      be:	ff ff ff 
  next[0][3][4]=-1;
      c1:	c7 05 6c 1c 00 00 ff 	movl   $0xffffffff,0x1c6c
      c8:	ff ff ff 
  next[0][4][0]=0;
      cb:	c7 05 70 1c 00 00 00 	movl   $0x0,0x1c70
      d2:	00 00 00 
  next[0][4][1]=0;
      d5:	c7 05 74 1c 00 00 00 	movl   $0x0,0x1c74
      dc:	00 00 00 
  next[0][4][2]=2;
      df:	c7 05 78 1c 00 00 02 	movl   $0x2,0x1c78
      e6:	00 00 00 
  next[0][4][3]=0;
      e9:	c7 05 7c 1c 00 00 00 	movl   $0x0,0x1c7c
      f0:	00 00 00 
  next[0][4][4]=-1;
      f3:	c7 05 80 1c 00 00 ff 	movl   $0xffffffff,0x1c80
      fa:	ff ff ff 
  
  next[1][0][0]=1;
      fd:	c7 05 84 1c 00 00 01 	movl   $0x1,0x1c84
     104:	00 00 00 
  next[1][0][1]=1;
     107:	c7 05 88 1c 00 00 01 	movl   $0x1,0x1c88
     10e:	00 00 00 
  next[1][0][2]=0;
     111:	c7 05 8c 1c 00 00 00 	movl   $0x0,0x1c8c
     118:	00 00 00 
  next[1][0][3]=2;
     11b:	c7 05 90 1c 00 00 02 	movl   $0x2,0x1c90
     122:	00 00 00 
  next[1][0][4]=-1;
     125:	c7 05 94 1c 00 00 ff 	movl   $0xffffffff,0x1c94
     12c:	ff ff ff 
  next[1][1][0]=0;
     12f:	c7 05 98 1c 00 00 00 	movl   $0x0,0x1c98
     136:	00 00 00 
  next[1][1][1]=1;
     139:	c7 05 9c 1c 00 00 01 	movl   $0x1,0x1c9c
     140:	00 00 00 
  next[1][1][2]=2;
     143:	c7 05 a0 1c 00 00 02 	movl   $0x2,0x1ca0
     14a:	00 00 00 
  next[1][1][3]=-1;
     14d:	c7 05 a4 1c 00 00 ff 	movl   $0xffffffff,0x1ca4
     154:	ff ff ff 
  next[1][1][4]=2;
     157:	c7 05 a8 1c 00 00 02 	movl   $0x2,0x1ca8
     15e:	00 00 00 
  next[1][2][0]=3;
     161:	c7 05 ac 1c 00 00 03 	movl   $0x3,0x1cac
     168:	00 00 00 
  next[1][2][1]=-1;
     16b:	c7 05 b0 1c 00 00 ff 	movl   $0xffffffff,0x1cb0
     172:	ff ff ff 
  next[1][2][2]=0;
     175:	c7 05 b4 1c 00 00 00 	movl   $0x0,0x1cb4
     17c:	00 00 00 
  next[1][2][3]=5;
     17f:	c7 05 b8 1c 00 00 05 	movl   $0x5,0x1cb8
     186:	00 00 00 
  next[1][2][4]=-1;
     189:	c7 05 bc 1c 00 00 ff 	movl   $0xffffffff,0x1cbc
     190:	ff ff ff 
  next[1][3][0]=0;
     193:	c7 05 c0 1c 00 00 00 	movl   $0x0,0x1cc0
     19a:	00 00 00 
  next[1][3][1]=1;
     19d:	c7 05 c4 1c 00 00 01 	movl   $0x1,0x1cc4
     1a4:	00 00 00 
  next[1][3][2]=2;
     1a7:	c7 05 c8 1c 00 00 02 	movl   $0x2,0x1cc8
     1ae:	00 00 00 
  next[1][3][3]=-1;
     1b1:	c7 05 cc 1c 00 00 ff 	movl   $0xffffffff,0x1ccc
     1b8:	ff ff ff 
  next[1][3][4]=2;
     1bb:	c7 05 d0 1c 00 00 02 	movl   $0x2,0x1cd0
     1c2:	00 00 00 
  next[1][4][0]=3;
     1c5:	c7 05 d4 1c 00 00 03 	movl   $0x3,0x1cd4
     1cc:	00 00 00 
  next[1][4][1]=-1;
     1cf:	c7 05 d8 1c 00 00 ff 	movl   $0xffffffff,0x1cd8
     1d6:	ff ff ff 
  next[1][4][2]=0;
     1d9:	c7 05 dc 1c 00 00 00 	movl   $0x0,0x1cdc
     1e0:	00 00 00 
  next[1][4][3]=5;
     1e3:	c7 05 e0 1c 00 00 05 	movl   $0x5,0x1ce0
     1ea:	00 00 00 
  next[1][4][4]=-1;
     1ed:	c7 05 e4 1c 00 00 ff 	movl   $0xffffffff,0x1ce4
     1f4:	ff ff ff 
  
  
  next[2][0][0]=2;
     1f7:	c7 05 e8 1c 00 00 02 	movl   $0x2,0x1ce8
     1fe:	00 00 00 
  next[2][0][1]=3;
     201:	c7 05 ec 1c 00 00 03 	movl   $0x3,0x1cec
     208:	00 00 00 
  next[2][0][2]=0;
     20b:	c7 05 f0 1c 00 00 00 	movl   $0x0,0x1cf0
     212:	00 00 00 
  next[2][0][3]=0;
     215:	c7 05 f4 1c 00 00 00 	movl   $0x0,0x1cf4
     21c:	00 00 00 
  next[2][0][4]=-1;
     21f:	c7 05 f8 1c 00 00 ff 	movl   $0xffffffff,0x1cf8
     226:	ff ff ff 
  next[2][1][0]=0;
     229:	c7 05 fc 1c 00 00 00 	movl   $0x0,0x1cfc
     230:	00 00 00 
  next[2][1][1]=0;
     233:	c7 05 00 1d 00 00 00 	movl   $0x0,0x1d00
     23a:	00 00 00 
  next[2][1][2]=1;
     23d:	c7 05 04 1d 00 00 01 	movl   $0x1,0x1d04
     244:	00 00 00 
  next[2][1][3]=1;
     247:	c7 05 08 1d 00 00 01 	movl   $0x1,0x1d08
     24e:	00 00 00 
  next[2][1][4]=0;
     251:	c7 05 0c 1d 00 00 00 	movl   $0x0,0x1d0c
     258:	00 00 00 
  next[2][2][0]=2;
     25b:	c7 05 10 1d 00 00 02 	movl   $0x2,0x1d10
     262:	00 00 00 
  next[2][2][1]=-1;
     265:	c7 05 14 1d 00 00 ff 	movl   $0xffffffff,0x1d14
     26c:	ff ff ff 
  next[2][2][2]=2;
     26f:	c7 05 18 1d 00 00 02 	movl   $0x2,0x1d18
     276:	00 00 00 
  next[2][2][3]=2;
     279:	c7 05 1c 1d 00 00 02 	movl   $0x2,0x1d1c
     280:	00 00 00 
  next[2][2][4]=-1;
     283:	c7 05 20 1d 00 00 ff 	movl   $0xffffffff,0x1d20
     28a:	ff ff ff 
  next[2][3][0]=1;
     28d:	c7 05 24 1d 00 00 01 	movl   $0x1,0x1d24
     294:	00 00 00 
  next[2][3][1]=5;
     297:	c7 05 28 1d 00 00 05 	movl   $0x5,0x1d28
     29e:	00 00 00 
  next[2][3][2]=-1;
     2a1:	c7 05 2c 1d 00 00 ff 	movl   $0xffffffff,0x1d2c
     2a8:	ff ff ff 
  next[2][3][3]=-1;
     2ab:	c7 05 30 1d 00 00 ff 	movl   $0xffffffff,0x1d30
     2b2:	ff ff ff 
  next[2][3][4]=5;
     2b5:	c7 05 34 1d 00 00 05 	movl   $0x5,0x1d34
     2bc:	00 00 00 
  next[2][4][0]=-1;
     2bf:	c7 05 38 1d 00 00 ff 	movl   $0xffffffff,0x1d38
     2c6:	ff ff ff 
  next[2][4][1]=-1;
     2c9:	c7 05 3c 1d 00 00 ff 	movl   $0xffffffff,0x1d3c
     2d0:	ff ff ff 
  next[2][4][2]=1;
     2d3:	c7 05 40 1d 00 00 01 	movl   $0x1,0x1d40
     2da:	00 00 00 
  next[2][4][3]=1;
     2dd:	c7 05 44 1d 00 00 01 	movl   $0x1,0x1d44
     2e4:	00 00 00 
  next[2][4][4]=-1;
     2e7:	c7 05 48 1d 00 00 ff 	movl   $0xffffffff,0x1d48
     2ee:	ff ff ff 
  
  next[3][0][0]=0;
     2f1:	c7 05 4c 1d 00 00 00 	movl   $0x0,0x1d4c
     2f8:	00 00 00 
  next[3][0][1]=3;
     2fb:	c7 05 50 1d 00 00 03 	movl   $0x3,0x1d50
     302:	00 00 00 
  next[3][0][2]=2;
     305:	c7 05 54 1d 00 00 02 	movl   $0x2,0x1d54
     30c:	00 00 00 
  next[3][0][3]=0;
     30f:	c7 05 58 1d 00 00 00 	movl   $0x0,0x1d58
     316:	00 00 00 
  next[3][0][4]=-1;
     319:	c7 05 5c 1d 00 00 ff 	movl   $0xffffffff,0x1d5c
     320:	ff ff ff 
  next[3][1][0]=1;
     323:	c7 05 60 1d 00 00 01 	movl   $0x1,0x1d60
     32a:	00 00 00 
  next[3][1][1]=-1;
     32d:	c7 05 64 1d 00 00 ff 	movl   $0xffffffff,0x1d64
     334:	ff ff ff 
  next[3][1][2]=-1;
     337:	c7 05 68 1d 00 00 ff 	movl   $0xffffffff,0x1d68
     33e:	ff ff ff 
  next[3][1][3]=5;
     341:	c7 05 6c 1d 00 00 05 	movl   $0x5,0x1d6c
     348:	00 00 00 
  next[3][1][4]=-1;
     34b:	c7 05 70 1d 00 00 ff 	movl   $0xffffffff,0x1d70
     352:	ff ff ff 
  next[3][2][0]=3;
     355:	c7 05 74 1d 00 00 03 	movl   $0x3,0x1d74
     35c:	00 00 00 
  next[3][2][1]=-1;
     35f:	c7 05 78 1d 00 00 ff 	movl   $0xffffffff,0x1d78
     366:	ff ff ff 
  next[3][2][2]=-1;
     369:	c7 05 7c 1d 00 00 ff 	movl   $0xffffffff,0x1d7c
     370:	ff ff ff 
  next[3][2][3]=3;
     373:	c7 05 80 1d 00 00 03 	movl   $0x3,0x1d80
     37a:	00 00 00 
  next[3][2][4]=-1;
     37d:	c7 05 84 1d 00 00 ff 	movl   $0xffffffff,0x1d84
     384:	ff ff ff 
  next[3][3][0]=0;
     387:	c7 05 88 1d 00 00 00 	movl   $0x0,0x1d88
     38e:	00 00 00 
  next[3][3][1]=3;
     391:	c7 05 8c 1d 00 00 03 	movl   $0x3,0x1d8c
     398:	00 00 00 
  next[3][3][2]=5;
     39b:	c7 05 90 1d 00 00 05 	movl   $0x5,0x1d90
     3a2:	00 00 00 
  next[3][3][3]=-1;
     3a5:	c7 05 94 1d 00 00 ff 	movl   $0xffffffff,0x1d94
     3ac:	ff ff ff 
  next[3][3][4]=-1;
     3af:	c7 05 98 1d 00 00 ff 	movl   $0xffffffff,0x1d98
     3b6:	ff ff ff 
  next[3][4][0]=0;
     3b9:	c7 05 9c 1d 00 00 00 	movl   $0x0,0x1d9c
     3c0:	00 00 00 
  next[3][4][1]=3;
     3c3:	c7 05 a0 1d 00 00 03 	movl   $0x3,0x1da0
     3ca:	00 00 00 
  next[3][4][2]=5;
     3cd:	c7 05 a4 1d 00 00 05 	movl   $0x5,0x1da4
     3d4:	00 00 00 
  next[3][4][3]=-1;
     3d7:	c7 05 a8 1d 00 00 ff 	movl   $0xffffffff,0x1da8
     3de:	ff ff ff 
  next[3][4][4]=-1;
     3e1:	c7 05 ac 1d 00 00 ff 	movl   $0xffffffff,0x1dac
     3e8:	ff ff ff 
}
     3eb:	5d                   	pop    %ebp
     3ec:	c3                   	ret    

000003ed <func>:


void func(void* tid)
{
     3ed:	55                   	push   %ebp
     3ee:	89 e5                	mov    %esp,%ebp
     3f0:	83 ec 28             	sub    $0x28,%esp
  int nextstate,left, right;
 
  int currentstate=state[(int)tid];
     3f3:	a1 d0 1d 00 00       	mov    0x1dd0,%eax
     3f8:	8b 55 08             	mov    0x8(%ebp),%edx
     3fb:	c1 e2 02             	shl    $0x2,%edx
     3fe:	01 d0                	add    %edx,%eax
     400:	8b 00                	mov    (%eax),%eax
     402:	89 45 ec             	mov    %eax,-0x14(%ebp)
  while(currentstate!=5)
     405:	e9 0c 01 00 00       	jmp    516 <func+0x129>
  {
    binary_semaphore_down(&sem1);
     40a:	c7 04 24 b0 1d 00 00 	movl   $0x1db0,(%esp)
     411:	e8 bc 11 00 00       	call   15d2 <binary_semaphore_down>

    if((int)tid==0)
     416:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
     41a:	75 09                	jne    425 <func+0x38>
    {
      left=4;
     41c:	c7 45 f4 04 00 00 00 	movl   $0x4,-0xc(%ebp)
     423:	eb 15                	jmp    43a <func+0x4d>
    }
    else
    {
      left=state[(int)tid-1];
     425:	a1 d0 1d 00 00       	mov    0x1dd0,%eax
     42a:	8b 55 08             	mov    0x8(%ebp),%edx
     42d:	83 ea 01             	sub    $0x1,%edx
     430:	c1 e2 02             	shl    $0x2,%edx
     433:	01 d0                	add    %edx,%eax
     435:	8b 00                	mov    (%eax),%eax
     437:	89 45 f4             	mov    %eax,-0xc(%ebp)
    }
    if((int)tid==n-1)
     43a:	8b 45 08             	mov    0x8(%ebp),%eax
     43d:	8b 15 c8 1d 00 00    	mov    0x1dc8,%edx
     443:	83 ea 01             	sub    $0x1,%edx
     446:	39 d0                	cmp    %edx,%eax
     448:	75 09                	jne    453 <func+0x66>
    {
      right=4;
     44a:	c7 45 f0 04 00 00 00 	movl   $0x4,-0x10(%ebp)
     451:	eb 15                	jmp    468 <func+0x7b>
    }
    else
    {
      right=state[(int)tid+1];
     453:	a1 d0 1d 00 00       	mov    0x1dd0,%eax
     458:	8b 55 08             	mov    0x8(%ebp),%edx
     45b:	83 c2 01             	add    $0x1,%edx
     45e:	c1 e2 02             	shl    $0x2,%edx
     461:	01 d0                	add    %edx,%eax
     463:	8b 00                	mov    (%eax),%eax
     465:	89 45 f0             	mov    %eax,-0x10(%ebp)
    }

    nextstate=next[currentstate][left][right];
     468:	8b 45 f4             	mov    -0xc(%ebp),%eax
     46b:	8b 4d ec             	mov    -0x14(%ebp),%ecx
     46e:	89 c2                	mov    %eax,%edx
     470:	c1 e2 02             	shl    $0x2,%edx
     473:	01 c2                	add    %eax,%edx
     475:	89 c8                	mov    %ecx,%eax
     477:	c1 e0 02             	shl    $0x2,%eax
     47a:	01 c8                	add    %ecx,%eax
     47c:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
     483:	01 c8                	add    %ecx,%eax
     485:	01 d0                	add    %edx,%eax
     487:	03 45 f0             	add    -0x10(%ebp),%eax
     48a:	8b 04 85 20 1c 00 00 	mov    0x1c20(,%eax,4),%eax
     491:	89 45 e8             	mov    %eax,-0x18(%ebp)
    mone++;
     494:	a1 cc 1d 00 00       	mov    0x1dcc,%eax
     499:	83 c0 01             	add    $0x1,%eax
     49c:	a3 cc 1d 00 00       	mov    %eax,0x1dcc
    if(mone==n)
     4a1:	8b 15 cc 1d 00 00    	mov    0x1dcc,%edx
     4a7:	a1 c8 1d 00 00       	mov    0x1dc8,%eax
     4ac:	39 c2                	cmp    %eax,%edx
     4ae:	75 0a                	jne    4ba <func+0xcd>
      in=1;
     4b0:	c7 05 dc 1d 00 00 01 	movl   $0x1,0x1ddc
     4b7:	00 00 00 
    binary_semaphore_up(&sem1);
     4ba:	c7 04 24 b0 1d 00 00 	movl   $0x1db0,(%esp)
     4c1:	e8 78 11 00 00       	call   163e <binary_semaphore_up>
     // printf (1,"tid: %d  mone: %d\n",(int)tid,mone);
    binary_semaphore_down(&sem2);
     4c6:	c7 04 24 bc 1d 00 00 	movl   $0x1dbc,(%esp)
     4cd:	e8 00 11 00 00       	call   15d2 <binary_semaphore_down>
    mone--;
     4d2:	a1 cc 1d 00 00       	mov    0x1dcc,%eax
     4d7:	83 e8 01             	sub    $0x1,%eax
     4da:	a3 cc 1d 00 00       	mov    %eax,0x1dcc

    state[(int)tid]=nextstate;
     4df:	a1 d0 1d 00 00       	mov    0x1dd0,%eax
     4e4:	8b 55 08             	mov    0x8(%ebp),%edx
     4e7:	c1 e2 02             	shl    $0x2,%edx
     4ea:	01 c2                	add    %eax,%edx
     4ec:	8b 45 e8             	mov    -0x18(%ebp),%eax
     4ef:	89 02                	mov    %eax,(%edx)
    currentstate=nextstate;
     4f1:	8b 45 e8             	mov    -0x18(%ebp),%eax
     4f4:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(mone==0)
     4f7:	a1 cc 1d 00 00       	mov    0x1dcc,%eax
     4fc:	85 c0                	test   %eax,%eax
     4fe:	75 0a                	jne    50a <func+0x11d>
      print=1;
     500:	c7 05 d4 1d 00 00 01 	movl   $0x1,0x1dd4
     507:	00 00 00 
    binary_semaphore_up(&sem2);
     50a:	c7 04 24 bc 1d 00 00 	movl   $0x1dbc,(%esp)
     511:	e8 28 11 00 00       	call   163e <binary_semaphore_up>
void func(void* tid)
{
  int nextstate,left, right;
 
  int currentstate=state[(int)tid];
  while(currentstate!=5)
     516:	83 7d ec 05          	cmpl   $0x5,-0x14(%ebp)
     51a:	0f 85 ea fe ff ff    	jne    40a <func+0x1d>
    if(mone==0)
      print=1;
    binary_semaphore_up(&sem2);

  }
 fire++;
     520:	a1 d8 1d 00 00       	mov    0x1dd8,%eax
     525:	83 c0 01             	add    $0x1,%eax
     528:	a3 d8 1d 00 00       	mov    %eax,0x1dd8
   
}
     52d:	c9                   	leave  
     52e:	c3                   	ret    

0000052f <main>:

int
main(int argc, char *argv[])
{
     52f:	55                   	push   %ebp
     530:	89 e5                	mov    %esp,%ebp
     532:	83 e4 f0             	and    $0xfffffff0,%esp
     535:	83 ec 20             	sub    $0x20,%esp

  int i;
  if(argc!=2)
     538:	83 7d 08 02          	cmpl   $0x2,0x8(%ebp)
     53c:	74 19                	je     557 <main+0x28>
  {
    printf (1,"uncorrect use of FSSP, use FSSP <int>\n");
     53e:	c7 44 24 04 a0 16 00 	movl   $0x16a0,0x4(%esp)
     545:	00 
     546:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     54d:	e8 35 06 00 00       	call   b87 <printf>
    exit();
     552:	e8 81 04 00 00       	call   9d8 <exit>
  }
  n=atoi(argv[1]);
     557:	8b 45 0c             	mov    0xc(%ebp),%eax
     55a:	83 c0 04             	add    $0x4,%eax
     55d:	8b 00                	mov    (%eax),%eax
     55f:	89 04 24             	mov    %eax,(%esp)
     562:	e8 e0 03 00 00       	call   947 <atoi>
     567:	a3 c8 1d 00 00       	mov    %eax,0x1dc8
  state= (int *) malloc(sizeof(int) * n);
     56c:	a1 c8 1d 00 00       	mov    0x1dc8,%eax
     571:	c1 e0 02             	shl    $0x2,%eax
     574:	89 04 24             	mov    %eax,(%esp)
     577:	e8 ef 08 00 00       	call   e6b <malloc>
     57c:	a3 d0 1d 00 00       	mov    %eax,0x1dd0
  for (i=0;i<n;i++)
     581:	c7 44 24 1c 00 00 00 	movl   $0x0,0x1c(%esp)
     588:	00 
     589:	eb 19                	jmp    5a4 <main+0x75>
  {
    state[i]=0;
     58b:	a1 d0 1d 00 00       	mov    0x1dd0,%eax
     590:	8b 54 24 1c          	mov    0x1c(%esp),%edx
     594:	c1 e2 02             	shl    $0x2,%edx
     597:	01 d0                	add    %edx,%eax
     599:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    printf (1,"uncorrect use of FSSP, use FSSP <int>\n");
    exit();
  }
  n=atoi(argv[1]);
  state= (int *) malloc(sizeof(int) * n);
  for (i=0;i<n;i++)
     59f:	83 44 24 1c 01       	addl   $0x1,0x1c(%esp)
     5a4:	a1 c8 1d 00 00       	mov    0x1dc8,%eax
     5a9:	39 44 24 1c          	cmp    %eax,0x1c(%esp)
     5ad:	7c dc                	jl     58b <main+0x5c>
  {
    state[i]=0;
  }
  state[0]=1;
     5af:	a1 d0 1d 00 00       	mov    0x1dd0,%eax
     5b4:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  initNext();
     5ba:	e8 41 fa ff ff       	call   0 <initNext>
  uthread_init();
     5bf:	e8 61 0b 00 00       	call   1125 <uthread_init>
  binary_semaphore_init(&sem1,0);
     5c4:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     5cb:	00 
     5cc:	c7 04 24 b0 1d 00 00 	movl   $0x1db0,(%esp)
     5d3:	e8 b9 0f 00 00       	call   1591 <binary_semaphore_init>
  binary_semaphore_init(&sem2,1);
     5d8:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
     5df:	00 
     5e0:	c7 04 24 bc 1d 00 00 	movl   $0x1dbc,(%esp)
     5e7:	e8 a5 0f 00 00       	call   1591 <binary_semaphore_init>
  binary_semaphore_down(&sem2);
     5ec:	c7 04 24 bc 1d 00 00 	movl   $0x1dbc,(%esp)
     5f3:	e8 da 0f 00 00       	call   15d2 <binary_semaphore_down>
    for(i=0;i<n;i++)
     5f8:	c7 44 24 1c 00 00 00 	movl   $0x0,0x1c(%esp)
     5ff:	00 
     600:	eb 2d                	jmp    62f <main+0x100>
       {
        printf(1,"%d",state[i]);
     602:	a1 d0 1d 00 00       	mov    0x1dd0,%eax
     607:	8b 54 24 1c          	mov    0x1c(%esp),%edx
     60b:	c1 e2 02             	shl    $0x2,%edx
     60e:	01 d0                	add    %edx,%eax
     610:	8b 00                	mov    (%eax),%eax
     612:	89 44 24 08          	mov    %eax,0x8(%esp)
     616:	c7 44 24 04 c7 16 00 	movl   $0x16c7,0x4(%esp)
     61d:	00 
     61e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     625:	e8 5d 05 00 00       	call   b87 <printf>
  initNext();
  uthread_init();
  binary_semaphore_init(&sem1,0);
  binary_semaphore_init(&sem2,1);
  binary_semaphore_down(&sem2);
    for(i=0;i<n;i++)
     62a:	83 44 24 1c 01       	addl   $0x1,0x1c(%esp)
     62f:	a1 c8 1d 00 00       	mov    0x1dc8,%eax
     634:	39 44 24 1c          	cmp    %eax,0x1c(%esp)
     638:	7c c8                	jl     602 <main+0xd3>
       {
        printf(1,"%d",state[i]);
       }
       printf(1,"\n");
     63a:	c7 44 24 04 ca 16 00 	movl   $0x16ca,0x4(%esp)
     641:	00 
     642:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     649:	e8 39 05 00 00       	call   b87 <printf>
  
  for(i=0;i<n;i++)
     64e:	c7 44 24 1c 00 00 00 	movl   $0x0,0x1c(%esp)
     655:	00 
     656:	eb 19                	jmp    671 <main+0x142>
  {
    uthread_create(func,(void *)i);
     658:	8b 44 24 1c          	mov    0x1c(%esp),%eax
     65c:	89 44 24 04          	mov    %eax,0x4(%esp)
     660:	c7 04 24 ed 03 00 00 	movl   $0x3ed,(%esp)
     667:	e8 8f 0b 00 00       	call   11fb <uthread_create>
       {
        printf(1,"%d",state[i]);
       }
       printf(1,"\n");
  
  for(i=0;i<n;i++)
     66c:	83 44 24 1c 01       	addl   $0x1,0x1c(%esp)
     671:	a1 c8 1d 00 00       	mov    0x1dc8,%eax
     676:	39 44 24 1c          	cmp    %eax,0x1c(%esp)
     67a:	7c dc                	jl     658 <main+0x129>
  {
    uthread_create(func,(void *)i);
  }

  binary_semaphore_up(&sem1);
     67c:	c7 04 24 b0 1d 00 00 	movl   $0x1db0,(%esp)
     683:	e8 b6 0f 00 00       	call   163e <binary_semaphore_up>

  while(fire<n)
     688:	e9 bd 00 00 00       	jmp    74a <main+0x21b>
  {
    if(mone==n && in==1)
     68d:	8b 15 cc 1d 00 00    	mov    0x1dcc,%edx
     693:	a1 c8 1d 00 00       	mov    0x1dc8,%eax
     698:	39 c2                	cmp    %eax,%edx
     69a:	75 40                	jne    6dc <main+0x1ad>
     69c:	a1 dc 1d 00 00       	mov    0x1ddc,%eax
     6a1:	83 f8 01             	cmp    $0x1,%eax
     6a4:	75 36                	jne    6dc <main+0x1ad>
    {
      binary_semaphore_down(&sem1);
     6a6:	c7 04 24 b0 1d 00 00 	movl   $0x1db0,(%esp)
     6ad:	e8 20 0f 00 00       	call   15d2 <binary_semaphore_down>
        printf(1,"\n");
     6b2:	c7 44 24 04 ca 16 00 	movl   $0x16ca,0x4(%esp)
     6b9:	00 
     6ba:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     6c1:	e8 c1 04 00 00       	call   b87 <printf>
      binary_semaphore_up(&sem2);
     6c6:	c7 04 24 bc 1d 00 00 	movl   $0x1dbc,(%esp)
     6cd:	e8 6c 0f 00 00       	call   163e <binary_semaphore_up>
      in=0;
     6d2:	c7 05 dc 1d 00 00 00 	movl   $0x0,0x1ddc
     6d9:	00 00 00 
    }
    if(print==1)
     6dc:	a1 d4 1d 00 00       	mov    0x1dd4,%eax
     6e1:	83 f8 01             	cmp    $0x1,%eax
     6e4:	75 64                	jne    74a <main+0x21b>
    {
      binary_semaphore_down(&sem2);
     6e6:	c7 04 24 bc 1d 00 00 	movl   $0x1dbc,(%esp)
     6ed:	e8 e0 0e 00 00       	call   15d2 <binary_semaphore_down>
      binary_semaphore_up(&sem1);
     6f2:	c7 04 24 b0 1d 00 00 	movl   $0x1db0,(%esp)
     6f9:	e8 40 0f 00 00       	call   163e <binary_semaphore_up>
       for(i=0;i<n;i++)
     6fe:	c7 44 24 1c 00 00 00 	movl   $0x0,0x1c(%esp)
     705:	00 
     706:	eb 2d                	jmp    735 <main+0x206>
       {
        printf(1,"%d",state[i]);
     708:	a1 d0 1d 00 00       	mov    0x1dd0,%eax
     70d:	8b 54 24 1c          	mov    0x1c(%esp),%edx
     711:	c1 e2 02             	shl    $0x2,%edx
     714:	01 d0                	add    %edx,%eax
     716:	8b 00                	mov    (%eax),%eax
     718:	89 44 24 08          	mov    %eax,0x8(%esp)
     71c:	c7 44 24 04 c7 16 00 	movl   $0x16c7,0x4(%esp)
     723:	00 
     724:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     72b:	e8 57 04 00 00       	call   b87 <printf>
    }
    if(print==1)
    {
      binary_semaphore_down(&sem2);
      binary_semaphore_up(&sem1);
       for(i=0;i<n;i++)
     730:	83 44 24 1c 01       	addl   $0x1,0x1c(%esp)
     735:	a1 c8 1d 00 00       	mov    0x1dc8,%eax
     73a:	39 44 24 1c          	cmp    %eax,0x1c(%esp)
     73e:	7c c8                	jl     708 <main+0x1d9>
       {
        printf(1,"%d",state[i]);
       }
       //printf(1,"\n");
       print=0;
     740:	c7 05 d4 1d 00 00 00 	movl   $0x0,0x1dd4
     747:	00 00 00 
    uthread_create(func,(void *)i);
  }

  binary_semaphore_up(&sem1);

  while(fire<n)
     74a:	8b 15 d8 1d 00 00    	mov    0x1dd8,%edx
     750:	a1 c8 1d 00 00       	mov    0x1dc8,%eax
     755:	39 c2                	cmp    %eax,%edx
     757:	0f 8c 30 ff ff ff    	jl     68d <main+0x15e>
    }
     
  }
//printf (1,"333333\n");
  //uthread_yield();
   free(state);
     75d:	a1 d0 1d 00 00       	mov    0x1dd0,%eax
     762:	89 04 24             	mov    %eax,(%esp)
     765:	e8 d2 05 00 00       	call   d3c <free>
  uthread_exit();
     76a:	e8 f6 0a 00 00       	call   1265 <uthread_exit>
 
  exit();
     76f:	e8 64 02 00 00       	call   9d8 <exit>

00000774 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
     774:	55                   	push   %ebp
     775:	89 e5                	mov    %esp,%ebp
     777:	57                   	push   %edi
     778:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
     779:	8b 4d 08             	mov    0x8(%ebp),%ecx
     77c:	8b 55 10             	mov    0x10(%ebp),%edx
     77f:	8b 45 0c             	mov    0xc(%ebp),%eax
     782:	89 cb                	mov    %ecx,%ebx
     784:	89 df                	mov    %ebx,%edi
     786:	89 d1                	mov    %edx,%ecx
     788:	fc                   	cld    
     789:	f3 aa                	rep stos %al,%es:(%edi)
     78b:	89 ca                	mov    %ecx,%edx
     78d:	89 fb                	mov    %edi,%ebx
     78f:	89 5d 08             	mov    %ebx,0x8(%ebp)
     792:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
     795:	5b                   	pop    %ebx
     796:	5f                   	pop    %edi
     797:	5d                   	pop    %ebp
     798:	c3                   	ret    

00000799 <strcpy>:
#include "x86.h"


char*
strcpy(char *s, char *t)
{
     799:	55                   	push   %ebp
     79a:	89 e5                	mov    %esp,%ebp
     79c:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
     79f:	8b 45 08             	mov    0x8(%ebp),%eax
     7a2:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
     7a5:	90                   	nop
     7a6:	8b 45 0c             	mov    0xc(%ebp),%eax
     7a9:	0f b6 10             	movzbl (%eax),%edx
     7ac:	8b 45 08             	mov    0x8(%ebp),%eax
     7af:	88 10                	mov    %dl,(%eax)
     7b1:	8b 45 08             	mov    0x8(%ebp),%eax
     7b4:	0f b6 00             	movzbl (%eax),%eax
     7b7:	84 c0                	test   %al,%al
     7b9:	0f 95 c0             	setne  %al
     7bc:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     7c0:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
     7c4:	84 c0                	test   %al,%al
     7c6:	75 de                	jne    7a6 <strcpy+0xd>
    ;
  return os;
     7c8:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     7cb:	c9                   	leave  
     7cc:	c3                   	ret    

000007cd <strcmp>:

int
strcmp(const char *p, const char *q)
{
     7cd:	55                   	push   %ebp
     7ce:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
     7d0:	eb 08                	jmp    7da <strcmp+0xd>
    p++, q++;
     7d2:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     7d6:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
     7da:	8b 45 08             	mov    0x8(%ebp),%eax
     7dd:	0f b6 00             	movzbl (%eax),%eax
     7e0:	84 c0                	test   %al,%al
     7e2:	74 10                	je     7f4 <strcmp+0x27>
     7e4:	8b 45 08             	mov    0x8(%ebp),%eax
     7e7:	0f b6 10             	movzbl (%eax),%edx
     7ea:	8b 45 0c             	mov    0xc(%ebp),%eax
     7ed:	0f b6 00             	movzbl (%eax),%eax
     7f0:	38 c2                	cmp    %al,%dl
     7f2:	74 de                	je     7d2 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
     7f4:	8b 45 08             	mov    0x8(%ebp),%eax
     7f7:	0f b6 00             	movzbl (%eax),%eax
     7fa:	0f b6 d0             	movzbl %al,%edx
     7fd:	8b 45 0c             	mov    0xc(%ebp),%eax
     800:	0f b6 00             	movzbl (%eax),%eax
     803:	0f b6 c0             	movzbl %al,%eax
     806:	89 d1                	mov    %edx,%ecx
     808:	29 c1                	sub    %eax,%ecx
     80a:	89 c8                	mov    %ecx,%eax
}
     80c:	5d                   	pop    %ebp
     80d:	c3                   	ret    

0000080e <strlen>:

uint
strlen(char *s)
{
     80e:	55                   	push   %ebp
     80f:	89 e5                	mov    %esp,%ebp
     811:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
     814:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
     81b:	eb 04                	jmp    821 <strlen+0x13>
     81d:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     821:	8b 45 fc             	mov    -0x4(%ebp),%eax
     824:	03 45 08             	add    0x8(%ebp),%eax
     827:	0f b6 00             	movzbl (%eax),%eax
     82a:	84 c0                	test   %al,%al
     82c:	75 ef                	jne    81d <strlen+0xf>
    ;
  return n;
     82e:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     831:	c9                   	leave  
     832:	c3                   	ret    

00000833 <memset>:

void*
memset(void *dst, int c, uint n)
{
     833:	55                   	push   %ebp
     834:	89 e5                	mov    %esp,%ebp
     836:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
     839:	8b 45 10             	mov    0x10(%ebp),%eax
     83c:	89 44 24 08          	mov    %eax,0x8(%esp)
     840:	8b 45 0c             	mov    0xc(%ebp),%eax
     843:	89 44 24 04          	mov    %eax,0x4(%esp)
     847:	8b 45 08             	mov    0x8(%ebp),%eax
     84a:	89 04 24             	mov    %eax,(%esp)
     84d:	e8 22 ff ff ff       	call   774 <stosb>
  return dst;
     852:	8b 45 08             	mov    0x8(%ebp),%eax
}
     855:	c9                   	leave  
     856:	c3                   	ret    

00000857 <strchr>:

char*
strchr(const char *s, char c)
{
     857:	55                   	push   %ebp
     858:	89 e5                	mov    %esp,%ebp
     85a:	83 ec 04             	sub    $0x4,%esp
     85d:	8b 45 0c             	mov    0xc(%ebp),%eax
     860:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
     863:	eb 14                	jmp    879 <strchr+0x22>
    if(*s == c)
     865:	8b 45 08             	mov    0x8(%ebp),%eax
     868:	0f b6 00             	movzbl (%eax),%eax
     86b:	3a 45 fc             	cmp    -0x4(%ebp),%al
     86e:	75 05                	jne    875 <strchr+0x1e>
      return (char*)s;
     870:	8b 45 08             	mov    0x8(%ebp),%eax
     873:	eb 13                	jmp    888 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
     875:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     879:	8b 45 08             	mov    0x8(%ebp),%eax
     87c:	0f b6 00             	movzbl (%eax),%eax
     87f:	84 c0                	test   %al,%al
     881:	75 e2                	jne    865 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
     883:	b8 00 00 00 00       	mov    $0x0,%eax
}
     888:	c9                   	leave  
     889:	c3                   	ret    

0000088a <gets>:

char*
gets(char *buf, int max)
{
     88a:	55                   	push   %ebp
     88b:	89 e5                	mov    %esp,%ebp
     88d:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     890:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     897:	eb 44                	jmp    8dd <gets+0x53>
    cc = read(0, &c, 1);
     899:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
     8a0:	00 
     8a1:	8d 45 ef             	lea    -0x11(%ebp),%eax
     8a4:	89 44 24 04          	mov    %eax,0x4(%esp)
     8a8:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     8af:	e8 3c 01 00 00       	call   9f0 <read>
     8b4:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
     8b7:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     8bb:	7e 2d                	jle    8ea <gets+0x60>
      break;
    buf[i++] = c;
     8bd:	8b 45 f4             	mov    -0xc(%ebp),%eax
     8c0:	03 45 08             	add    0x8(%ebp),%eax
     8c3:	0f b6 55 ef          	movzbl -0x11(%ebp),%edx
     8c7:	88 10                	mov    %dl,(%eax)
     8c9:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    if(c == '\n' || c == '\r')
     8cd:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     8d1:	3c 0a                	cmp    $0xa,%al
     8d3:	74 16                	je     8eb <gets+0x61>
     8d5:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     8d9:	3c 0d                	cmp    $0xd,%al
     8db:	74 0e                	je     8eb <gets+0x61>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     8dd:	8b 45 f4             	mov    -0xc(%ebp),%eax
     8e0:	83 c0 01             	add    $0x1,%eax
     8e3:	3b 45 0c             	cmp    0xc(%ebp),%eax
     8e6:	7c b1                	jl     899 <gets+0xf>
     8e8:	eb 01                	jmp    8eb <gets+0x61>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
     8ea:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
     8eb:	8b 45 f4             	mov    -0xc(%ebp),%eax
     8ee:	03 45 08             	add    0x8(%ebp),%eax
     8f1:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
     8f4:	8b 45 08             	mov    0x8(%ebp),%eax
}
     8f7:	c9                   	leave  
     8f8:	c3                   	ret    

000008f9 <stat>:

int
stat(char *n, struct stat *st)
{
     8f9:	55                   	push   %ebp
     8fa:	89 e5                	mov    %esp,%ebp
     8fc:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     8ff:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     906:	00 
     907:	8b 45 08             	mov    0x8(%ebp),%eax
     90a:	89 04 24             	mov    %eax,(%esp)
     90d:	e8 06 01 00 00       	call   a18 <open>
     912:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
     915:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     919:	79 07                	jns    922 <stat+0x29>
    return -1;
     91b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     920:	eb 23                	jmp    945 <stat+0x4c>
  r = fstat(fd, st);
     922:	8b 45 0c             	mov    0xc(%ebp),%eax
     925:	89 44 24 04          	mov    %eax,0x4(%esp)
     929:	8b 45 f4             	mov    -0xc(%ebp),%eax
     92c:	89 04 24             	mov    %eax,(%esp)
     92f:	e8 fc 00 00 00       	call   a30 <fstat>
     934:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
     937:	8b 45 f4             	mov    -0xc(%ebp),%eax
     93a:	89 04 24             	mov    %eax,(%esp)
     93d:	e8 be 00 00 00       	call   a00 <close>
  return r;
     942:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     945:	c9                   	leave  
     946:	c3                   	ret    

00000947 <atoi>:

int
atoi(const char *s)
{
     947:	55                   	push   %ebp
     948:	89 e5                	mov    %esp,%ebp
     94a:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
     94d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
     954:	eb 23                	jmp    979 <atoi+0x32>
    n = n*10 + *s++ - '0';
     956:	8b 55 fc             	mov    -0x4(%ebp),%edx
     959:	89 d0                	mov    %edx,%eax
     95b:	c1 e0 02             	shl    $0x2,%eax
     95e:	01 d0                	add    %edx,%eax
     960:	01 c0                	add    %eax,%eax
     962:	89 c2                	mov    %eax,%edx
     964:	8b 45 08             	mov    0x8(%ebp),%eax
     967:	0f b6 00             	movzbl (%eax),%eax
     96a:	0f be c0             	movsbl %al,%eax
     96d:	01 d0                	add    %edx,%eax
     96f:	83 e8 30             	sub    $0x30,%eax
     972:	89 45 fc             	mov    %eax,-0x4(%ebp)
     975:	83 45 08 01          	addl   $0x1,0x8(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     979:	8b 45 08             	mov    0x8(%ebp),%eax
     97c:	0f b6 00             	movzbl (%eax),%eax
     97f:	3c 2f                	cmp    $0x2f,%al
     981:	7e 0a                	jle    98d <atoi+0x46>
     983:	8b 45 08             	mov    0x8(%ebp),%eax
     986:	0f b6 00             	movzbl (%eax),%eax
     989:	3c 39                	cmp    $0x39,%al
     98b:	7e c9                	jle    956 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
     98d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     990:	c9                   	leave  
     991:	c3                   	ret    

00000992 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
     992:	55                   	push   %ebp
     993:	89 e5                	mov    %esp,%ebp
     995:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
     998:	8b 45 08             	mov    0x8(%ebp),%eax
     99b:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
     99e:	8b 45 0c             	mov    0xc(%ebp),%eax
     9a1:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
     9a4:	eb 13                	jmp    9b9 <memmove+0x27>
    *dst++ = *src++;
     9a6:	8b 45 f8             	mov    -0x8(%ebp),%eax
     9a9:	0f b6 10             	movzbl (%eax),%edx
     9ac:	8b 45 fc             	mov    -0x4(%ebp),%eax
     9af:	88 10                	mov    %dl,(%eax)
     9b1:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     9b5:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
     9b9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     9bd:	0f 9f c0             	setg   %al
     9c0:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
     9c4:	84 c0                	test   %al,%al
     9c6:	75 de                	jne    9a6 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
     9c8:	8b 45 08             	mov    0x8(%ebp),%eax
}
     9cb:	c9                   	leave  
     9cc:	c3                   	ret    
     9cd:	90                   	nop
     9ce:	90                   	nop
     9cf:	90                   	nop

000009d0 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     9d0:	b8 01 00 00 00       	mov    $0x1,%eax
     9d5:	cd 40                	int    $0x40
     9d7:	c3                   	ret    

000009d8 <exit>:
SYSCALL(exit)
     9d8:	b8 02 00 00 00       	mov    $0x2,%eax
     9dd:	cd 40                	int    $0x40
     9df:	c3                   	ret    

000009e0 <wait>:
SYSCALL(wait)
     9e0:	b8 03 00 00 00       	mov    $0x3,%eax
     9e5:	cd 40                	int    $0x40
     9e7:	c3                   	ret    

000009e8 <pipe>:
SYSCALL(pipe)
     9e8:	b8 04 00 00 00       	mov    $0x4,%eax
     9ed:	cd 40                	int    $0x40
     9ef:	c3                   	ret    

000009f0 <read>:
SYSCALL(read)
     9f0:	b8 05 00 00 00       	mov    $0x5,%eax
     9f5:	cd 40                	int    $0x40
     9f7:	c3                   	ret    

000009f8 <write>:
SYSCALL(write)
     9f8:	b8 10 00 00 00       	mov    $0x10,%eax
     9fd:	cd 40                	int    $0x40
     9ff:	c3                   	ret    

00000a00 <close>:
SYSCALL(close)
     a00:	b8 15 00 00 00       	mov    $0x15,%eax
     a05:	cd 40                	int    $0x40
     a07:	c3                   	ret    

00000a08 <kill>:
SYSCALL(kill)
     a08:	b8 06 00 00 00       	mov    $0x6,%eax
     a0d:	cd 40                	int    $0x40
     a0f:	c3                   	ret    

00000a10 <exec>:
SYSCALL(exec)
     a10:	b8 07 00 00 00       	mov    $0x7,%eax
     a15:	cd 40                	int    $0x40
     a17:	c3                   	ret    

00000a18 <open>:
SYSCALL(open)
     a18:	b8 0f 00 00 00       	mov    $0xf,%eax
     a1d:	cd 40                	int    $0x40
     a1f:	c3                   	ret    

00000a20 <mknod>:
SYSCALL(mknod)
     a20:	b8 11 00 00 00       	mov    $0x11,%eax
     a25:	cd 40                	int    $0x40
     a27:	c3                   	ret    

00000a28 <unlink>:
SYSCALL(unlink)
     a28:	b8 12 00 00 00       	mov    $0x12,%eax
     a2d:	cd 40                	int    $0x40
     a2f:	c3                   	ret    

00000a30 <fstat>:
SYSCALL(fstat)
     a30:	b8 08 00 00 00       	mov    $0x8,%eax
     a35:	cd 40                	int    $0x40
     a37:	c3                   	ret    

00000a38 <link>:
SYSCALL(link)
     a38:	b8 13 00 00 00       	mov    $0x13,%eax
     a3d:	cd 40                	int    $0x40
     a3f:	c3                   	ret    

00000a40 <mkdir>:
SYSCALL(mkdir)
     a40:	b8 14 00 00 00       	mov    $0x14,%eax
     a45:	cd 40                	int    $0x40
     a47:	c3                   	ret    

00000a48 <chdir>:
SYSCALL(chdir)
     a48:	b8 09 00 00 00       	mov    $0x9,%eax
     a4d:	cd 40                	int    $0x40
     a4f:	c3                   	ret    

00000a50 <dup>:
SYSCALL(dup)
     a50:	b8 0a 00 00 00       	mov    $0xa,%eax
     a55:	cd 40                	int    $0x40
     a57:	c3                   	ret    

00000a58 <getpid>:
SYSCALL(getpid)
     a58:	b8 0b 00 00 00       	mov    $0xb,%eax
     a5d:	cd 40                	int    $0x40
     a5f:	c3                   	ret    

00000a60 <sbrk>:
SYSCALL(sbrk)
     a60:	b8 0c 00 00 00       	mov    $0xc,%eax
     a65:	cd 40                	int    $0x40
     a67:	c3                   	ret    

00000a68 <sleep>:
SYSCALL(sleep)
     a68:	b8 0d 00 00 00       	mov    $0xd,%eax
     a6d:	cd 40                	int    $0x40
     a6f:	c3                   	ret    

00000a70 <uptime>:
SYSCALL(uptime)
     a70:	b8 0e 00 00 00       	mov    $0xe,%eax
     a75:	cd 40                	int    $0x40
     a77:	c3                   	ret    

00000a78 <add_path>:
SYSCALL(add_path)
     a78:	b8 16 00 00 00       	mov    $0x16,%eax
     a7d:	cd 40                	int    $0x40
     a7f:	c3                   	ret    

00000a80 <wait2>:
SYSCALL(wait2)
     a80:	b8 17 00 00 00       	mov    $0x17,%eax
     a85:	cd 40                	int    $0x40
     a87:	c3                   	ret    

00000a88 <getquanta>:
SYSCALL(getquanta)
     a88:	b8 18 00 00 00       	mov    $0x18,%eax
     a8d:	cd 40                	int    $0x40
     a8f:	c3                   	ret    

00000a90 <getqueue>:
SYSCALL(getqueue)
     a90:	b8 19 00 00 00       	mov    $0x19,%eax
     a95:	cd 40                	int    $0x40
     a97:	c3                   	ret    

00000a98 <signal>:
SYSCALL(signal)
     a98:	b8 1a 00 00 00       	mov    $0x1a,%eax
     a9d:	cd 40                	int    $0x40
     a9f:	c3                   	ret    

00000aa0 <sigsend>:
SYSCALL(sigsend)
     aa0:	b8 1b 00 00 00       	mov    $0x1b,%eax
     aa5:	cd 40                	int    $0x40
     aa7:	c3                   	ret    

00000aa8 <alarm>:
SYSCALL(alarm)
     aa8:	b8 1c 00 00 00       	mov    $0x1c,%eax
     aad:	cd 40                	int    $0x40
     aaf:	c3                   	ret    

00000ab0 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
     ab0:	55                   	push   %ebp
     ab1:	89 e5                	mov    %esp,%ebp
     ab3:	83 ec 28             	sub    $0x28,%esp
     ab6:	8b 45 0c             	mov    0xc(%ebp),%eax
     ab9:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
     abc:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
     ac3:	00 
     ac4:	8d 45 f4             	lea    -0xc(%ebp),%eax
     ac7:	89 44 24 04          	mov    %eax,0x4(%esp)
     acb:	8b 45 08             	mov    0x8(%ebp),%eax
     ace:	89 04 24             	mov    %eax,(%esp)
     ad1:	e8 22 ff ff ff       	call   9f8 <write>
}
     ad6:	c9                   	leave  
     ad7:	c3                   	ret    

00000ad8 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     ad8:	55                   	push   %ebp
     ad9:	89 e5                	mov    %esp,%ebp
     adb:	83 ec 48             	sub    $0x48,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     ade:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
     ae5:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     ae9:	74 17                	je     b02 <printint+0x2a>
     aeb:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     aef:	79 11                	jns    b02 <printint+0x2a>
    neg = 1;
     af1:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
     af8:	8b 45 0c             	mov    0xc(%ebp),%eax
     afb:	f7 d8                	neg    %eax
     afd:	89 45 ec             	mov    %eax,-0x14(%ebp)
     b00:	eb 06                	jmp    b08 <printint+0x30>
  } else {
    x = xx;
     b02:	8b 45 0c             	mov    0xc(%ebp),%eax
     b05:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
     b08:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
     b0f:	8b 4d 10             	mov    0x10(%ebp),%ecx
     b12:	8b 45 ec             	mov    -0x14(%ebp),%eax
     b15:	ba 00 00 00 00       	mov    $0x0,%edx
     b1a:	f7 f1                	div    %ecx
     b1c:	89 d0                	mov    %edx,%eax
     b1e:	0f b6 90 04 1c 00 00 	movzbl 0x1c04(%eax),%edx
     b25:	8d 45 dc             	lea    -0x24(%ebp),%eax
     b28:	03 45 f4             	add    -0xc(%ebp),%eax
     b2b:	88 10                	mov    %dl,(%eax)
     b2d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  }while((x /= base) != 0);
     b31:	8b 55 10             	mov    0x10(%ebp),%edx
     b34:	89 55 d4             	mov    %edx,-0x2c(%ebp)
     b37:	8b 45 ec             	mov    -0x14(%ebp),%eax
     b3a:	ba 00 00 00 00       	mov    $0x0,%edx
     b3f:	f7 75 d4             	divl   -0x2c(%ebp)
     b42:	89 45 ec             	mov    %eax,-0x14(%ebp)
     b45:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     b49:	75 c4                	jne    b0f <printint+0x37>
  if(neg)
     b4b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     b4f:	74 2a                	je     b7b <printint+0xa3>
    buf[i++] = '-';
     b51:	8d 45 dc             	lea    -0x24(%ebp),%eax
     b54:	03 45 f4             	add    -0xc(%ebp),%eax
     b57:	c6 00 2d             	movb   $0x2d,(%eax)
     b5a:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)

  while(--i >= 0)
     b5e:	eb 1b                	jmp    b7b <printint+0xa3>
    putc(fd, buf[i]);
     b60:	8d 45 dc             	lea    -0x24(%ebp),%eax
     b63:	03 45 f4             	add    -0xc(%ebp),%eax
     b66:	0f b6 00             	movzbl (%eax),%eax
     b69:	0f be c0             	movsbl %al,%eax
     b6c:	89 44 24 04          	mov    %eax,0x4(%esp)
     b70:	8b 45 08             	mov    0x8(%ebp),%eax
     b73:	89 04 24             	mov    %eax,(%esp)
     b76:	e8 35 ff ff ff       	call   ab0 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
     b7b:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
     b7f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     b83:	79 db                	jns    b60 <printint+0x88>
    putc(fd, buf[i]);
}
     b85:	c9                   	leave  
     b86:	c3                   	ret    

00000b87 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     b87:	55                   	push   %ebp
     b88:	89 e5                	mov    %esp,%ebp
     b8a:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
     b8d:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
     b94:	8d 45 0c             	lea    0xc(%ebp),%eax
     b97:	83 c0 04             	add    $0x4,%eax
     b9a:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
     b9d:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     ba4:	e9 7d 01 00 00       	jmp    d26 <printf+0x19f>
    c = fmt[i] & 0xff;
     ba9:	8b 55 0c             	mov    0xc(%ebp),%edx
     bac:	8b 45 f0             	mov    -0x10(%ebp),%eax
     baf:	01 d0                	add    %edx,%eax
     bb1:	0f b6 00             	movzbl (%eax),%eax
     bb4:	0f be c0             	movsbl %al,%eax
     bb7:	25 ff 00 00 00       	and    $0xff,%eax
     bbc:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
     bbf:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     bc3:	75 2c                	jne    bf1 <printf+0x6a>
      if(c == '%'){
     bc5:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     bc9:	75 0c                	jne    bd7 <printf+0x50>
        state = '%';
     bcb:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
     bd2:	e9 4b 01 00 00       	jmp    d22 <printf+0x19b>
      } else {
        putc(fd, c);
     bd7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     bda:	0f be c0             	movsbl %al,%eax
     bdd:	89 44 24 04          	mov    %eax,0x4(%esp)
     be1:	8b 45 08             	mov    0x8(%ebp),%eax
     be4:	89 04 24             	mov    %eax,(%esp)
     be7:	e8 c4 fe ff ff       	call   ab0 <putc>
     bec:	e9 31 01 00 00       	jmp    d22 <printf+0x19b>
      }
    } else if(state == '%'){
     bf1:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
     bf5:	0f 85 27 01 00 00    	jne    d22 <printf+0x19b>
      if(c == 'd'){
     bfb:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
     bff:	75 2d                	jne    c2e <printf+0xa7>
        printint(fd, *ap, 10, 1);
     c01:	8b 45 e8             	mov    -0x18(%ebp),%eax
     c04:	8b 00                	mov    (%eax),%eax
     c06:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
     c0d:	00 
     c0e:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
     c15:	00 
     c16:	89 44 24 04          	mov    %eax,0x4(%esp)
     c1a:	8b 45 08             	mov    0x8(%ebp),%eax
     c1d:	89 04 24             	mov    %eax,(%esp)
     c20:	e8 b3 fe ff ff       	call   ad8 <printint>
        ap++;
     c25:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     c29:	e9 ed 00 00 00       	jmp    d1b <printf+0x194>
      } else if(c == 'x' || c == 'p'){
     c2e:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
     c32:	74 06                	je     c3a <printf+0xb3>
     c34:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
     c38:	75 2d                	jne    c67 <printf+0xe0>
        printint(fd, *ap, 16, 0);
     c3a:	8b 45 e8             	mov    -0x18(%ebp),%eax
     c3d:	8b 00                	mov    (%eax),%eax
     c3f:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
     c46:	00 
     c47:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
     c4e:	00 
     c4f:	89 44 24 04          	mov    %eax,0x4(%esp)
     c53:	8b 45 08             	mov    0x8(%ebp),%eax
     c56:	89 04 24             	mov    %eax,(%esp)
     c59:	e8 7a fe ff ff       	call   ad8 <printint>
        ap++;
     c5e:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     c62:	e9 b4 00 00 00       	jmp    d1b <printf+0x194>
      } else if(c == 's'){
     c67:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
     c6b:	75 46                	jne    cb3 <printf+0x12c>
        s = (char*)*ap;
     c6d:	8b 45 e8             	mov    -0x18(%ebp),%eax
     c70:	8b 00                	mov    (%eax),%eax
     c72:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
     c75:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
     c79:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     c7d:	75 27                	jne    ca6 <printf+0x11f>
          s = "(null)";
     c7f:	c7 45 f4 cc 16 00 00 	movl   $0x16cc,-0xc(%ebp)
        while(*s != 0){
     c86:	eb 1e                	jmp    ca6 <printf+0x11f>
          putc(fd, *s);
     c88:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c8b:	0f b6 00             	movzbl (%eax),%eax
     c8e:	0f be c0             	movsbl %al,%eax
     c91:	89 44 24 04          	mov    %eax,0x4(%esp)
     c95:	8b 45 08             	mov    0x8(%ebp),%eax
     c98:	89 04 24             	mov    %eax,(%esp)
     c9b:	e8 10 fe ff ff       	call   ab0 <putc>
          s++;
     ca0:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     ca4:	eb 01                	jmp    ca7 <printf+0x120>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
     ca6:	90                   	nop
     ca7:	8b 45 f4             	mov    -0xc(%ebp),%eax
     caa:	0f b6 00             	movzbl (%eax),%eax
     cad:	84 c0                	test   %al,%al
     caf:	75 d7                	jne    c88 <printf+0x101>
     cb1:	eb 68                	jmp    d1b <printf+0x194>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
     cb3:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
     cb7:	75 1d                	jne    cd6 <printf+0x14f>
        putc(fd, *ap);
     cb9:	8b 45 e8             	mov    -0x18(%ebp),%eax
     cbc:	8b 00                	mov    (%eax),%eax
     cbe:	0f be c0             	movsbl %al,%eax
     cc1:	89 44 24 04          	mov    %eax,0x4(%esp)
     cc5:	8b 45 08             	mov    0x8(%ebp),%eax
     cc8:	89 04 24             	mov    %eax,(%esp)
     ccb:	e8 e0 fd ff ff       	call   ab0 <putc>
        ap++;
     cd0:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     cd4:	eb 45                	jmp    d1b <printf+0x194>
      } else if(c == '%'){
     cd6:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     cda:	75 17                	jne    cf3 <printf+0x16c>
        putc(fd, c);
     cdc:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     cdf:	0f be c0             	movsbl %al,%eax
     ce2:	89 44 24 04          	mov    %eax,0x4(%esp)
     ce6:	8b 45 08             	mov    0x8(%ebp),%eax
     ce9:	89 04 24             	mov    %eax,(%esp)
     cec:	e8 bf fd ff ff       	call   ab0 <putc>
     cf1:	eb 28                	jmp    d1b <printf+0x194>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     cf3:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
     cfa:	00 
     cfb:	8b 45 08             	mov    0x8(%ebp),%eax
     cfe:	89 04 24             	mov    %eax,(%esp)
     d01:	e8 aa fd ff ff       	call   ab0 <putc>
        putc(fd, c);
     d06:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     d09:	0f be c0             	movsbl %al,%eax
     d0c:	89 44 24 04          	mov    %eax,0x4(%esp)
     d10:	8b 45 08             	mov    0x8(%ebp),%eax
     d13:	89 04 24             	mov    %eax,(%esp)
     d16:	e8 95 fd ff ff       	call   ab0 <putc>
      }
      state = 0;
     d1b:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     d22:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     d26:	8b 55 0c             	mov    0xc(%ebp),%edx
     d29:	8b 45 f0             	mov    -0x10(%ebp),%eax
     d2c:	01 d0                	add    %edx,%eax
     d2e:	0f b6 00             	movzbl (%eax),%eax
     d31:	84 c0                	test   %al,%al
     d33:	0f 85 70 fe ff ff    	jne    ba9 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
     d39:	c9                   	leave  
     d3a:	c3                   	ret    
     d3b:	90                   	nop

00000d3c <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     d3c:	55                   	push   %ebp
     d3d:	89 e5                	mov    %esp,%ebp
     d3f:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
     d42:	8b 45 08             	mov    0x8(%ebp),%eax
     d45:	83 e8 08             	sub    $0x8,%eax
     d48:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     d4b:	a1 e8 1d 00 00       	mov    0x1de8,%eax
     d50:	89 45 fc             	mov    %eax,-0x4(%ebp)
     d53:	eb 24                	jmp    d79 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     d55:	8b 45 fc             	mov    -0x4(%ebp),%eax
     d58:	8b 00                	mov    (%eax),%eax
     d5a:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     d5d:	77 12                	ja     d71 <free+0x35>
     d5f:	8b 45 f8             	mov    -0x8(%ebp),%eax
     d62:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     d65:	77 24                	ja     d8b <free+0x4f>
     d67:	8b 45 fc             	mov    -0x4(%ebp),%eax
     d6a:	8b 00                	mov    (%eax),%eax
     d6c:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     d6f:	77 1a                	ja     d8b <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     d71:	8b 45 fc             	mov    -0x4(%ebp),%eax
     d74:	8b 00                	mov    (%eax),%eax
     d76:	89 45 fc             	mov    %eax,-0x4(%ebp)
     d79:	8b 45 f8             	mov    -0x8(%ebp),%eax
     d7c:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     d7f:	76 d4                	jbe    d55 <free+0x19>
     d81:	8b 45 fc             	mov    -0x4(%ebp),%eax
     d84:	8b 00                	mov    (%eax),%eax
     d86:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     d89:	76 ca                	jbe    d55 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
     d8b:	8b 45 f8             	mov    -0x8(%ebp),%eax
     d8e:	8b 40 04             	mov    0x4(%eax),%eax
     d91:	c1 e0 03             	shl    $0x3,%eax
     d94:	89 c2                	mov    %eax,%edx
     d96:	03 55 f8             	add    -0x8(%ebp),%edx
     d99:	8b 45 fc             	mov    -0x4(%ebp),%eax
     d9c:	8b 00                	mov    (%eax),%eax
     d9e:	39 c2                	cmp    %eax,%edx
     da0:	75 24                	jne    dc6 <free+0x8a>
    bp->s.size += p->s.ptr->s.size;
     da2:	8b 45 f8             	mov    -0x8(%ebp),%eax
     da5:	8b 50 04             	mov    0x4(%eax),%edx
     da8:	8b 45 fc             	mov    -0x4(%ebp),%eax
     dab:	8b 00                	mov    (%eax),%eax
     dad:	8b 40 04             	mov    0x4(%eax),%eax
     db0:	01 c2                	add    %eax,%edx
     db2:	8b 45 f8             	mov    -0x8(%ebp),%eax
     db5:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
     db8:	8b 45 fc             	mov    -0x4(%ebp),%eax
     dbb:	8b 00                	mov    (%eax),%eax
     dbd:	8b 10                	mov    (%eax),%edx
     dbf:	8b 45 f8             	mov    -0x8(%ebp),%eax
     dc2:	89 10                	mov    %edx,(%eax)
     dc4:	eb 0a                	jmp    dd0 <free+0x94>
  } else
    bp->s.ptr = p->s.ptr;
     dc6:	8b 45 fc             	mov    -0x4(%ebp),%eax
     dc9:	8b 10                	mov    (%eax),%edx
     dcb:	8b 45 f8             	mov    -0x8(%ebp),%eax
     dce:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
     dd0:	8b 45 fc             	mov    -0x4(%ebp),%eax
     dd3:	8b 40 04             	mov    0x4(%eax),%eax
     dd6:	c1 e0 03             	shl    $0x3,%eax
     dd9:	03 45 fc             	add    -0x4(%ebp),%eax
     ddc:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     ddf:	75 20                	jne    e01 <free+0xc5>
    p->s.size += bp->s.size;
     de1:	8b 45 fc             	mov    -0x4(%ebp),%eax
     de4:	8b 50 04             	mov    0x4(%eax),%edx
     de7:	8b 45 f8             	mov    -0x8(%ebp),%eax
     dea:	8b 40 04             	mov    0x4(%eax),%eax
     ded:	01 c2                	add    %eax,%edx
     def:	8b 45 fc             	mov    -0x4(%ebp),%eax
     df2:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
     df5:	8b 45 f8             	mov    -0x8(%ebp),%eax
     df8:	8b 10                	mov    (%eax),%edx
     dfa:	8b 45 fc             	mov    -0x4(%ebp),%eax
     dfd:	89 10                	mov    %edx,(%eax)
     dff:	eb 08                	jmp    e09 <free+0xcd>
  } else
    p->s.ptr = bp;
     e01:	8b 45 fc             	mov    -0x4(%ebp),%eax
     e04:	8b 55 f8             	mov    -0x8(%ebp),%edx
     e07:	89 10                	mov    %edx,(%eax)
  freep = p;
     e09:	8b 45 fc             	mov    -0x4(%ebp),%eax
     e0c:	a3 e8 1d 00 00       	mov    %eax,0x1de8
}
     e11:	c9                   	leave  
     e12:	c3                   	ret    

00000e13 <morecore>:

static Header*
morecore(uint nu)
{
     e13:	55                   	push   %ebp
     e14:	89 e5                	mov    %esp,%ebp
     e16:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
     e19:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
     e20:	77 07                	ja     e29 <morecore+0x16>
    nu = 4096;
     e22:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
     e29:	8b 45 08             	mov    0x8(%ebp),%eax
     e2c:	c1 e0 03             	shl    $0x3,%eax
     e2f:	89 04 24             	mov    %eax,(%esp)
     e32:	e8 29 fc ff ff       	call   a60 <sbrk>
     e37:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
     e3a:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     e3e:	75 07                	jne    e47 <morecore+0x34>
    return 0;
     e40:	b8 00 00 00 00       	mov    $0x0,%eax
     e45:	eb 22                	jmp    e69 <morecore+0x56>
  hp = (Header*)p;
     e47:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e4a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
     e4d:	8b 45 f0             	mov    -0x10(%ebp),%eax
     e50:	8b 55 08             	mov    0x8(%ebp),%edx
     e53:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
     e56:	8b 45 f0             	mov    -0x10(%ebp),%eax
     e59:	83 c0 08             	add    $0x8,%eax
     e5c:	89 04 24             	mov    %eax,(%esp)
     e5f:	e8 d8 fe ff ff       	call   d3c <free>
  return freep;
     e64:	a1 e8 1d 00 00       	mov    0x1de8,%eax
}
     e69:	c9                   	leave  
     e6a:	c3                   	ret    

00000e6b <malloc>:

void*
malloc(uint nbytes)
{
     e6b:	55                   	push   %ebp
     e6c:	89 e5                	mov    %esp,%ebp
     e6e:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     e71:	8b 45 08             	mov    0x8(%ebp),%eax
     e74:	83 c0 07             	add    $0x7,%eax
     e77:	c1 e8 03             	shr    $0x3,%eax
     e7a:	83 c0 01             	add    $0x1,%eax
     e7d:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
     e80:	a1 e8 1d 00 00       	mov    0x1de8,%eax
     e85:	89 45 f0             	mov    %eax,-0x10(%ebp)
     e88:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     e8c:	75 23                	jne    eb1 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     e8e:	c7 45 f0 e0 1d 00 00 	movl   $0x1de0,-0x10(%ebp)
     e95:	8b 45 f0             	mov    -0x10(%ebp),%eax
     e98:	a3 e8 1d 00 00       	mov    %eax,0x1de8
     e9d:	a1 e8 1d 00 00       	mov    0x1de8,%eax
     ea2:	a3 e0 1d 00 00       	mov    %eax,0x1de0
    base.s.size = 0;
     ea7:	c7 05 e4 1d 00 00 00 	movl   $0x0,0x1de4
     eae:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     eb1:	8b 45 f0             	mov    -0x10(%ebp),%eax
     eb4:	8b 00                	mov    (%eax),%eax
     eb6:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
     eb9:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ebc:	8b 40 04             	mov    0x4(%eax),%eax
     ebf:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     ec2:	72 4d                	jb     f11 <malloc+0xa6>
      if(p->s.size == nunits)
     ec4:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ec7:	8b 40 04             	mov    0x4(%eax),%eax
     eca:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     ecd:	75 0c                	jne    edb <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
     ecf:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ed2:	8b 10                	mov    (%eax),%edx
     ed4:	8b 45 f0             	mov    -0x10(%ebp),%eax
     ed7:	89 10                	mov    %edx,(%eax)
     ed9:	eb 26                	jmp    f01 <malloc+0x96>
      else {
        p->s.size -= nunits;
     edb:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ede:	8b 40 04             	mov    0x4(%eax),%eax
     ee1:	89 c2                	mov    %eax,%edx
     ee3:	2b 55 ec             	sub    -0x14(%ebp),%edx
     ee6:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ee9:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
     eec:	8b 45 f4             	mov    -0xc(%ebp),%eax
     eef:	8b 40 04             	mov    0x4(%eax),%eax
     ef2:	c1 e0 03             	shl    $0x3,%eax
     ef5:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
     ef8:	8b 45 f4             	mov    -0xc(%ebp),%eax
     efb:	8b 55 ec             	mov    -0x14(%ebp),%edx
     efe:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
     f01:	8b 45 f0             	mov    -0x10(%ebp),%eax
     f04:	a3 e8 1d 00 00       	mov    %eax,0x1de8
      return (void*)(p + 1);
     f09:	8b 45 f4             	mov    -0xc(%ebp),%eax
     f0c:	83 c0 08             	add    $0x8,%eax
     f0f:	eb 38                	jmp    f49 <malloc+0xde>
    }
    if(p == freep)
     f11:	a1 e8 1d 00 00       	mov    0x1de8,%eax
     f16:	39 45 f4             	cmp    %eax,-0xc(%ebp)
     f19:	75 1b                	jne    f36 <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
     f1b:	8b 45 ec             	mov    -0x14(%ebp),%eax
     f1e:	89 04 24             	mov    %eax,(%esp)
     f21:	e8 ed fe ff ff       	call   e13 <morecore>
     f26:	89 45 f4             	mov    %eax,-0xc(%ebp)
     f29:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     f2d:	75 07                	jne    f36 <malloc+0xcb>
        return 0;
     f2f:	b8 00 00 00 00       	mov    $0x0,%eax
     f34:	eb 13                	jmp    f49 <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     f36:	8b 45 f4             	mov    -0xc(%ebp),%eax
     f39:	89 45 f0             	mov    %eax,-0x10(%ebp)
     f3c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     f3f:	8b 00                	mov    (%eax),%eax
     f41:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
     f44:	e9 70 ff ff ff       	jmp    eb9 <malloc+0x4e>
}
     f49:	c9                   	leave  
     f4a:	c3                   	ret    
     f4b:	90                   	nop

00000f4c <print_stack>:
 * prints the stack of the currently running thread
 * DEBUGGING purposes
 */
void
print_stack()
{
     f4c:	55                   	push   %ebp
     f4d:	89 e5                	mov    %esp,%ebp
     f4f:	83 ec 28             	sub    $0x28,%esp
  int *newesp = (int*)currentThread->esp;  
     f52:	a1 00 67 00 00       	mov    0x6700,%eax
     f57:	8b 40 04             	mov    0x4(%eax),%eax
     f5a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  printf(1,"stack for thread %d \n",currentThread->tid);
     f5d:	a1 00 67 00 00       	mov    0x6700,%eax
     f62:	8b 00                	mov    (%eax),%eax
     f64:	89 44 24 08          	mov    %eax,0x8(%esp)
     f68:	c7 44 24 04 d4 16 00 	movl   $0x16d4,0x4(%esp)
     f6f:	00 
     f70:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     f77:	e8 0b fc ff ff       	call   b87 <printf>
  while((newesp < (int *)currentThread->ebp))
     f7c:	eb 3c                	jmp    fba <print_stack+0x6e>
  {
    printf(1,"add:%x ",newesp);
     f7e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     f81:	89 44 24 08          	mov    %eax,0x8(%esp)
     f85:	c7 44 24 04 ea 16 00 	movl   $0x16ea,0x4(%esp)
     f8c:	00 
     f8d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     f94:	e8 ee fb ff ff       	call   b87 <printf>
      printf(1,"val:%x\n",*newesp);
     f99:	8b 45 f4             	mov    -0xc(%ebp),%eax
     f9c:	8b 00                	mov    (%eax),%eax
     f9e:	89 44 24 08          	mov    %eax,0x8(%esp)
     fa2:	c7 44 24 04 f2 16 00 	movl   $0x16f2,0x4(%esp)
     fa9:	00 
     faa:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     fb1:	e8 d1 fb ff ff       	call   b87 <printf>
    newesp++;
     fb6:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
void
print_stack()
{
  int *newesp = (int*)currentThread->esp;  
  printf(1,"stack for thread %d \n",currentThread->tid);
  while((newesp < (int *)currentThread->ebp))
     fba:	a1 00 67 00 00       	mov    0x6700,%eax
     fbf:	8b 40 08             	mov    0x8(%eax),%eax
     fc2:	3b 45 f4             	cmp    -0xc(%ebp),%eax
     fc5:	77 b7                	ja     f7e <print_stack+0x32>
    printf(1,"add:%x ",newesp);
      printf(1,"val:%x\n",*newesp);
    newesp++;
  }

}
     fc7:	c9                   	leave  
     fc8:	c3                   	ret    

00000fc9 <getNextThread>:
 * returns the next thread in line to run
 * if none exists it returns -1
 */
int
getNextThread(int j)
{
     fc9:	55                   	push   %ebp
     fca:	89 e5                	mov    %esp,%ebp
     fcc:	83 ec 10             	sub    $0x10,%esp
  int i=j+1;
     fcf:	8b 45 08             	mov    0x8(%ebp),%eax
     fd2:	83 c0 01             	add    $0x1,%eax
     fd5:	89 45 fc             	mov    %eax,-0x4(%ebp)
  if(i==MAX_THREAD)
     fd8:	83 7d fc 40          	cmpl   $0x40,-0x4(%ebp)
     fdc:	75 07                	jne    fe5 <getNextThread+0x1c>
    i=0;
     fde:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  uthread_p t=&tTable.table[i];
     fe5:	8b 45 fc             	mov    -0x4(%ebp),%eax
     fe8:	69 c0 24 01 00 00    	imul   $0x124,%eax,%eax
     fee:	05 00 1e 00 00       	add    $0x1e00,%eax
     ff3:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(i!=j)
     ff6:	eb 3b                	jmp    1033 <getNextThread+0x6a>
  {
    if(t->state==T_RUNNABLE)
     ff8:	8b 45 f8             	mov    -0x8(%ebp),%eax
     ffb:	8b 40 10             	mov    0x10(%eax),%eax
     ffe:	83 f8 03             	cmp    $0x3,%eax
    1001:	75 05                	jne    1008 <getNextThread+0x3f>
      return i;
    1003:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1006:	eb 38                	jmp    1040 <getNextThread+0x77>
    i++;
    1008:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    if(i==MAX_THREAD)
    100c:	83 7d fc 40          	cmpl   $0x40,-0x4(%ebp)
    1010:	75 1a                	jne    102c <getNextThread+0x63>
    {
     i=0;
    1012:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
     t=&tTable.table[i];
    1019:	8b 45 fc             	mov    -0x4(%ebp),%eax
    101c:	69 c0 24 01 00 00    	imul   $0x124,%eax,%eax
    1022:	05 00 1e 00 00       	add    $0x1e00,%eax
    1027:	89 45 f8             	mov    %eax,-0x8(%ebp)
    102a:	eb 07                	jmp    1033 <getNextThread+0x6a>
   }
   else
    t++;
    102c:	81 45 f8 24 01 00 00 	addl   $0x124,-0x8(%ebp)
{
  int i=j+1;
  if(i==MAX_THREAD)
    i=0;
  uthread_p t=&tTable.table[i];
  while(i!=j)
    1033:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1036:	3b 45 08             	cmp    0x8(%ebp),%eax
    1039:	75 bd                	jne    ff8 <getNextThread+0x2f>
   }
   else
    t++;

}
return -1;
    103b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
    1040:	c9                   	leave  
    1041:	c3                   	ret    

00001042 <allocThread>:
 * allocates a spot for a new thread
 * if none exist it returns NULL
 */
static uthread_p
allocThread()
{
    1042:	55                   	push   %ebp
    1043:	89 e5                	mov    %esp,%ebp
    1045:	83 ec 28             	sub    $0x28,%esp
  int i,j;
  uthread_p t;
  
  for (t=tTable.table,i=0 ; t < &tTable.table[MAX_THREAD]; t++,i++)
    1048:	c7 45 ec 00 1e 00 00 	movl   $0x1e00,-0x14(%ebp)
    104f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1056:	eb 15                	jmp    106d <allocThread+0x2b>
  {
    if(t->state==T_FREE)
    1058:	8b 45 ec             	mov    -0x14(%ebp),%eax
    105b:	8b 40 10             	mov    0x10(%eax),%eax
    105e:	85 c0                	test   %eax,%eax
    1060:	74 1e                	je     1080 <allocThread+0x3e>
allocThread()
{
  int i,j;
  uthread_p t;
  
  for (t=tTable.table,i=0 ; t < &tTable.table[MAX_THREAD]; t++,i++)
    1062:	81 45 ec 24 01 00 00 	addl   $0x124,-0x14(%ebp)
    1069:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    106d:	81 7d ec 00 67 00 00 	cmpl   $0x6700,-0x14(%ebp)
    1074:	72 e2                	jb     1058 <allocThread+0x16>
  {
    if(t->state==T_FREE)
      goto found;
  }
  return 0;
    1076:	b8 00 00 00 00       	mov    $0x0,%eax
    107b:	e9 a3 00 00 00       	jmp    1123 <allocThread+0xe1>
  uthread_p t;
  
  for (t=tTable.table,i=0 ; t < &tTable.table[MAX_THREAD]; t++,i++)
  {
    if(t->state==T_FREE)
      goto found;
    1080:	90                   	nop
  }
  return 0;
  
  found:
  //Init all fields
  t->tid=i;
    1081:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1084:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1087:	89 10                	mov    %edx,(%eax)
  if(i==0) //main thread init
    1089:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    108d:	75 1c                	jne    10ab <allocThread+0x69>
  {
    STORE_ESP(t->esp);
    108f:	89 e2                	mov    %esp,%edx
    1091:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1094:	89 50 04             	mov    %edx,0x4(%eax)
    STORE_EBP(t->ebp);
    1097:	89 ea                	mov    %ebp,%edx
    1099:	8b 45 ec             	mov    -0x14(%ebp),%eax
    109c:	89 50 08             	mov    %edx,0x8(%eax)
    t->firstTime=0;
    109f:	8b 45 ec             	mov    -0x14(%ebp),%eax
    10a2:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
    10a9:	eb 3b                	jmp    10e6 <allocThread+0xa4>
  }
  else
  {
    t->stack=(char*)malloc(STACK_SIZE);
    10ab:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
    10b2:	e8 b4 fd ff ff       	call   e6b <malloc>
    10b7:	8b 55 ec             	mov    -0x14(%ebp),%edx
    10ba:	89 42 0c             	mov    %eax,0xc(%edx)
    t->ebp=(int)t->stack+STACK_SIZE;
    10bd:	8b 45 ec             	mov    -0x14(%ebp),%eax
    10c0:	8b 40 0c             	mov    0xc(%eax),%eax
    10c3:	05 00 10 00 00       	add    $0x1000,%eax
    10c8:	89 c2                	mov    %eax,%edx
    10ca:	8b 45 ec             	mov    -0x14(%ebp),%eax
    10cd:	89 50 08             	mov    %edx,0x8(%eax)
    t->esp=t->ebp;
    10d0:	8b 45 ec             	mov    -0x14(%ebp),%eax
    10d3:	8b 50 08             	mov    0x8(%eax),%edx
    10d6:	8b 45 ec             	mov    -0x14(%ebp),%eax
    10d9:	89 50 04             	mov    %edx,0x4(%eax)
    t->firstTime=1;
    10dc:	8b 45 ec             	mov    -0x14(%ebp),%eax
    10df:	c7 40 14 01 00 00 00 	movl   $0x1,0x14(%eax)
  }
  
  t->waitingFor=-1;
    10e6:	8b 45 ec             	mov    -0x14(%ebp),%eax
    10e9:	c7 80 20 01 00 00 ff 	movl   $0xffffffff,0x120(%eax)
    10f0:	ff ff ff 
  
  for(j=0;j<MAX_THREAD;j++)
    10f3:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    10fa:	eb 14                	jmp    1110 <allocThread+0xce>
  {
    t->waitedOn[j]=-1;
    10fc:	8b 45 ec             	mov    -0x14(%ebp),%eax
    10ff:	8b 55 f0             	mov    -0x10(%ebp),%edx
    1102:	83 c2 08             	add    $0x8,%edx
    1105:	c7 04 90 ff ff ff ff 	movl   $0xffffffff,(%eax,%edx,4)
    t->firstTime=1;
  }
  
  t->waitingFor=-1;
  
  for(j=0;j<MAX_THREAD;j++)
    110c:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1110:	83 7d f0 3f          	cmpl   $0x3f,-0x10(%ebp)
    1114:	7e e6                	jle    10fc <allocThread+0xba>
  {
    t->waitedOn[j]=-1;
  }
   
  t->state=T_UNINIT;
    1116:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1119:	c7 40 10 01 00 00 00 	movl   $0x1,0x10(%eax)
  
    
  return t;
    1120:	8b 45 ec             	mov    -0x14(%ebp),%eax
}
    1123:	c9                   	leave  
    1124:	c3                   	ret    

00001125 <uthread_init>:
/*
 * initializes all the uthread structures
 */
int
uthread_init()
{   
    1125:	55                   	push   %ebp
    1126:	89 e5                	mov    %esp,%ebp
    1128:	83 ec 28             	sub    $0x28,%esp
  //Initialize table
  int i;
  
  for(i=0;i<MAX_THREAD;i++)
    112b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1132:	eb 18                	jmp    114c <uthread_init+0x27>
  {
    tTable.table[i].state=T_FREE;
    1134:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1137:	69 c0 24 01 00 00    	imul   $0x124,%eax,%eax
    113d:	05 10 1e 00 00       	add    $0x1e10,%eax
    1142:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
uthread_init()
{   
  //Initialize table
  int i;
  
  for(i=0;i<MAX_THREAD;i++)
    1148:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    114c:	83 7d f4 3f          	cmpl   $0x3f,-0xc(%ebp)
    1150:	7e e2                	jle    1134 <uthread_init+0xf>
  {
    tTable.table[i].state=T_FREE;
  }
  
 //allocate the main thread
  currentThread = allocThread();
    1152:	e8 eb fe ff ff       	call   1042 <allocThread>
    1157:	a3 00 67 00 00       	mov    %eax,0x6700
  if(currentThread==0)
    115c:	a1 00 67 00 00       	mov    0x6700,%eax
    1161:	85 c0                	test   %eax,%eax
    1163:	75 07                	jne    116c <uthread_init+0x47>
    return -1;
    1165:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    116a:	eb 6b                	jmp    11d7 <uthread_init+0xb2>
  
  currentThread->state = T_RUNNING;
    116c:	a1 00 67 00 00       	mov    0x6700,%eax
    1171:	c7 40 10 02 00 00 00 	movl   $0x2,0x10(%eax)
  //register uthread_yield as signal handler for alarm
  if(signal(SIGALRM,uthread_yield)<0)
    1178:	c7 44 24 04 5f 14 00 	movl   $0x145f,0x4(%esp)
    117f:	00 
    1180:	c7 04 24 0e 00 00 00 	movl   $0xe,(%esp)
    1187:	e8 0c f9 ff ff       	call   a98 <signal>
    118c:	85 c0                	test   %eax,%eax
    118e:	79 19                	jns    11a9 <uthread_init+0x84>
  {
    printf(1,"Cant register the alarm signal");
    1190:	c7 44 24 04 fc 16 00 	movl   $0x16fc,0x4(%esp)
    1197:	00 
    1198:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    119f:	e8 e3 f9 ff ff       	call   b87 <printf>
    exit();
    11a4:	e8 2f f8 ff ff       	call   9d8 <exit>
  }
  //set new alarm clock
  if(alarm(THREAD_QUANTA)<0)
    11a9:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
    11b0:	e8 f3 f8 ff ff       	call   aa8 <alarm>
    11b5:	85 c0                	test   %eax,%eax
    11b7:	79 19                	jns    11d2 <uthread_init+0xad>
  {
    printf(1,"Cant activate alarm system call");
    11b9:	c7 44 24 04 1c 17 00 	movl   $0x171c,0x4(%esp)
    11c0:	00 
    11c1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    11c8:	e8 ba f9 ff ff       	call   b87 <printf>
    exit();
    11cd:	e8 06 f8 ff ff       	call   9d8 <exit>
  }
  return 0;
    11d2:	b8 00 00 00 00       	mov    $0x0,%eax
}
    11d7:	c9                   	leave  
    11d8:	c3                   	ret    

000011d9 <wrap_func>:

void
wrap_func()
{
    11d9:	55                   	push   %ebp
    11da:	89 e5                	mov    %esp,%ebp
    11dc:	83 ec 18             	sub    $0x18,%esp
  currentThread->func(currentThread->arguments);
    11df:	a1 00 67 00 00       	mov    0x6700,%eax
    11e4:	8b 50 18             	mov    0x18(%eax),%edx
    11e7:	a1 00 67 00 00       	mov    0x6700,%eax
    11ec:	8b 40 1c             	mov    0x1c(%eax),%eax
    11ef:	89 04 24             	mov    %eax,(%esp)
    11f2:	ff d2                	call   *%edx
  uthread_exit();
    11f4:	e8 6c 00 00 00       	call   1265 <uthread_exit>
}
    11f9:	c9                   	leave  
    11fa:	c3                   	ret    

000011fb <uthread_create>:
 * to that function
 * if none can be created it returns -1;
 */
int  
uthread_create(void (*start_func)(void *), void* arg)
{
    11fb:	55                   	push   %ebp
    11fc:	89 e5                	mov    %esp,%ebp
    11fe:	53                   	push   %ebx
    11ff:	83 ec 14             	sub    $0x14,%esp
  uint local_esp;
  uthread_p t = allocThread();
    1202:	e8 3b fe ff ff       	call   1042 <allocThread>
    1207:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(t==0)
    120a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    120e:	75 07                	jne    1217 <uthread_create+0x1c>
    return -1;
    1210:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    1215:	eb 48                	jmp    125f <uthread_create+0x64>

  t->func=start_func;
    1217:	8b 45 f4             	mov    -0xc(%ebp),%eax
    121a:	8b 55 08             	mov    0x8(%ebp),%edx
    121d:	89 50 18             	mov    %edx,0x18(%eax)
  t->arguments=arg;
    1220:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1223:	8b 55 0c             	mov    0xc(%ebp),%edx
    1226:	89 50 1c             	mov    %edx,0x1c(%eax)
  
  //push starting func and return value on the right stack
  STORE_ESP(local_esp);
    1229:	89 e3                	mov    %esp,%ebx
    122b:	89 5d f0             	mov    %ebx,-0x10(%ebp)
  LOAD_ESP(t->esp);
    122e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1231:	8b 40 04             	mov    0x4(%eax),%eax
    1234:	89 c4                	mov    %eax,%esp
  PUSH_FUNC(t->esp,t->ebp,wrap_func);
    1236:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1239:	8b 50 08             	mov    0x8(%eax),%edx
    123c:	b8 d9 11 00 00       	mov    $0x11d9,%eax
    1241:	50                   	push   %eax
    1242:	52                   	push   %edx
    1243:	89 e2                	mov    %esp,%edx
    1245:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1248:	89 50 04             	mov    %edx,0x4(%eax)
  LOAD_ESP(local_esp);
    124b:	8b 45 f0             	mov    -0x10(%ebp),%eax
    124e:	89 c4                	mov    %eax,%esp
  
  t->state = T_RUNNABLE;
    1250:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1253:	c7 40 10 03 00 00 00 	movl   $0x3,0x10(%eax)
  
  return t->tid;
    125a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    125d:	8b 00                	mov    (%eax),%eax
}
    125f:	83 c4 14             	add    $0x14,%esp
    1262:	5b                   	pop    %ebx
    1263:	5d                   	pop    %ebp
    1264:	c3                   	ret    

00001265 <uthread_exit>:
 * closes the running thread, wakes up all
 * the threads waiting for this one (if they require waking up)
 */
void 
uthread_exit()
{
    1265:	55                   	push   %ebp
    1266:	89 e5                	mov    %esp,%ebp
    1268:	83 ec 28             	sub    $0x28,%esp
  alarm(0); //clear the alarm so as not to disturb running of function
    126b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1272:	e8 31 f8 ff ff       	call   aa8 <alarm>
  int new,i;
  //wakeup all threads waiting for this one
  for(i=0;i<MAX_THREAD;i++)
    1277:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    127e:	eb 51                	jmp    12d1 <uthread_exit+0x6c>
  {
   if(currentThread->waitedOn[i]==1)
    1280:	a1 00 67 00 00       	mov    0x6700,%eax
    1285:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1288:	83 c2 08             	add    $0x8,%edx
    128b:	8b 04 90             	mov    (%eax,%edx,4),%eax
    128e:	83 f8 01             	cmp    $0x1,%eax
    1291:	75 3a                	jne    12cd <uthread_exit+0x68>
   {
     tTable.table[i].waitingFor=-1; //release thread i from waiting
    1293:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1296:	69 c0 24 01 00 00    	imul   $0x124,%eax,%eax
    129c:	05 20 1f 00 00       	add    $0x1f20,%eax
    12a1:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)
     currentThread->waitedOn[i]=0; //not necessary maybe   
    12a7:	a1 00 67 00 00       	mov    0x6700,%eax
    12ac:	8b 55 f4             	mov    -0xc(%ebp),%edx
    12af:	83 c2 08             	add    $0x8,%edx
    12b2:	c7 04 90 00 00 00 00 	movl   $0x0,(%eax,%edx,4)
     tTable.table[i].state=T_RUNNABLE;
    12b9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    12bc:	69 c0 24 01 00 00    	imul   $0x124,%eax,%eax
    12c2:	05 10 1e 00 00       	add    $0x1e10,%eax
    12c7:	c7 00 03 00 00 00    	movl   $0x3,(%eax)
uthread_exit()
{
  alarm(0); //clear the alarm so as not to disturb running of function
  int new,i;
  //wakeup all threads waiting for this one
  for(i=0;i<MAX_THREAD;i++)
    12cd:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    12d1:	83 7d f4 3f          	cmpl   $0x3f,-0xc(%ebp)
    12d5:	7e a9                	jle    1280 <uthread_exit+0x1b>
     tTable.table[i].state=T_RUNNABLE;
   }
  }
  
  //pick next thread
  new=getNextThread(currentThread->tid);
    12d7:	a1 00 67 00 00       	mov    0x6700,%eax
    12dc:	8b 00                	mov    (%eax),%eax
    12de:	89 04 24             	mov    %eax,(%esp)
    12e1:	e8 e3 fc ff ff       	call   fc9 <getNextThread>
    12e6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  
  //release all resources and zero all fields
  if(currentThread->tid!=0)
    12e9:	a1 00 67 00 00       	mov    0x6700,%eax
    12ee:	8b 00                	mov    (%eax),%eax
    12f0:	85 c0                	test   %eax,%eax
    12f2:	74 10                	je     1304 <uthread_exit+0x9f>
    free(currentThread->stack);
    12f4:	a1 00 67 00 00       	mov    0x6700,%eax
    12f9:	8b 40 0c             	mov    0xc(%eax),%eax
    12fc:	89 04 24             	mov    %eax,(%esp)
    12ff:	e8 38 fa ff ff       	call   d3c <free>
  currentThread->tid=-1;
    1304:	a1 00 67 00 00       	mov    0x6700,%eax
    1309:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)
  currentThread->esp=-1;
    130f:	a1 00 67 00 00       	mov    0x6700,%eax
    1314:	c7 40 04 ff ff ff ff 	movl   $0xffffffff,0x4(%eax)
  currentThread->ebp=-1;
    131b:	a1 00 67 00 00       	mov    0x6700,%eax
    1320:	c7 40 08 ff ff ff ff 	movl   $0xffffffff,0x8(%eax)
  currentThread->func=0;
    1327:	a1 00 67 00 00       	mov    0x6700,%eax
    132c:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)
  currentThread->arguments=0;
    1333:	a1 00 67 00 00       	mov    0x6700,%eax
    1338:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
  currentThread->stack=0;
    133f:	a1 00 67 00 00       	mov    0x6700,%eax
    1344:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
  currentThread->firstTime=1;
    134b:	a1 00 67 00 00       	mov    0x6700,%eax
    1350:	c7 40 14 01 00 00 00 	movl   $0x1,0x14(%eax)
  currentThread->state=T_FREE;
    1357:	a1 00 67 00 00       	mov    0x6700,%eax
    135c:	c7 40 10 00 00 00 00 	movl   $0x0,0x10(%eax)
  
  //load new thread
  if(new>=0)
    1363:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1367:	78 7a                	js     13e3 <uthread_exit+0x17e>
  {
    currentThread=&tTable.table[new];
    1369:	8b 45 f0             	mov    -0x10(%ebp),%eax
    136c:	69 c0 24 01 00 00    	imul   $0x124,%eax,%eax
    1372:	05 00 1e 00 00       	add    $0x1e00,%eax
    1377:	a3 00 67 00 00       	mov    %eax,0x6700
    currentThread->state=T_RUNNING;
    137c:	a1 00 67 00 00       	mov    0x6700,%eax
    1381:	c7 40 10 02 00 00 00 	movl   $0x2,0x10(%eax)
    LOAD_ESP(currentThread->esp);
    1388:	a1 00 67 00 00       	mov    0x6700,%eax
    138d:	8b 40 04             	mov    0x4(%eax),%eax
    1390:	89 c4                	mov    %eax,%esp
    LOAD_EBP(currentThread->ebp);
    1392:	a1 00 67 00 00       	mov    0x6700,%eax
    1397:	8b 40 08             	mov    0x8(%eax),%eax
    139a:	89 c5                	mov    %eax,%ebp
    
    //set new alarm clock
    if(alarm(THREAD_QUANTA)<0)
    139c:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
    13a3:	e8 00 f7 ff ff       	call   aa8 <alarm>
    13a8:	85 c0                	test   %eax,%eax
    13aa:	79 19                	jns    13c5 <uthread_exit+0x160>
    {
      printf(1,"Cant activate alarm system call");
    13ac:	c7 44 24 04 1c 17 00 	movl   $0x171c,0x4(%esp)
    13b3:	00 
    13b4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    13bb:	e8 c7 f7 ff ff       	call   b87 <printf>
      exit();
    13c0:	e8 13 f6 ff ff       	call   9d8 <exit>
    }
    
    if(currentThread->firstTime==1)
    13c5:	a1 00 67 00 00       	mov    0x6700,%eax
    13ca:	8b 40 14             	mov    0x14(%eax),%eax
    13cd:	83 f8 01             	cmp    $0x1,%eax
    13d0:	75 10                	jne    13e2 <uthread_exit+0x17d>
    {
      currentThread->firstTime=0;
    13d2:	a1 00 67 00 00       	mov    0x6700,%eax
    13d7:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
      POP_AND_RET();
    13de:	5d                   	pop    %ebp
    13df:	c3                   	ret    
    13e0:	eb 01                	jmp    13e3 <uthread_exit+0x17e>
    }
    else
    {  
    POP_ALL_REGISTERS();
    13e2:	61                   	popa   
    }
  }
}
    13e3:	c9                   	leave  
    13e4:	c3                   	ret    

000013e5 <uthread_join>:
/*
 * causes this thread to wait for the finish of another thread
 */
int
uthread_join(int tid)
{
    13e5:	55                   	push   %ebp
    13e6:	89 e5                	mov    %esp,%ebp
    13e8:	83 ec 18             	sub    $0x18,%esp
  if((&tTable.table[tid])->state==T_FREE)
    13eb:	8b 45 08             	mov    0x8(%ebp),%eax
    13ee:	69 c0 24 01 00 00    	imul   $0x124,%eax,%eax
    13f4:	05 00 1e 00 00       	add    $0x1e00,%eax
    13f9:	8b 40 10             	mov    0x10(%eax),%eax
    13fc:	85 c0                	test   %eax,%eax
    13fe:	75 07                	jne    1407 <uthread_join+0x22>
    return -1;
    1400:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    1405:	eb 56                	jmp    145d <uthread_join+0x78>
  else
  {
    alarm(0); //clear the alarm so as not to disturb running of function
    1407:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    140e:	e8 95 f6 ff ff       	call   aa8 <alarm>
    currentThread->waitingFor=tid;
    1413:	a1 00 67 00 00       	mov    0x6700,%eax
    1418:	8b 55 08             	mov    0x8(%ebp),%edx
    141b:	89 90 20 01 00 00    	mov    %edx,0x120(%eax)
    tTable.table[tid].waitedOn[currentThread->tid]=1;
    1421:	a1 00 67 00 00       	mov    0x6700,%eax
    1426:	8b 08                	mov    (%eax),%ecx
    1428:	8b 55 08             	mov    0x8(%ebp),%edx
    142b:	89 d0                	mov    %edx,%eax
    142d:	c1 e0 03             	shl    $0x3,%eax
    1430:	01 d0                	add    %edx,%eax
    1432:	c1 e0 03             	shl    $0x3,%eax
    1435:	01 d0                	add    %edx,%eax
    1437:	01 c8                	add    %ecx,%eax
    1439:	83 c0 08             	add    $0x8,%eax
    143c:	c7 04 85 00 1e 00 00 	movl   $0x1,0x1e00(,%eax,4)
    1443:	01 00 00 00 
    currentThread->state=T_SLEEPING;
    1447:	a1 00 67 00 00       	mov    0x6700,%eax
    144c:	c7 40 10 04 00 00 00 	movl   $0x4,0x10(%eax)
    uthread_yield();
    1453:	e8 07 00 00 00       	call   145f <uthread_yield>
    return 1;
    1458:	b8 01 00 00 00       	mov    $0x1,%eax
  }
}
    145d:	c9                   	leave  
    145e:	c3                   	ret    

0000145f <uthread_yield>:
/*
 * yields the run-time of the current thread to another thread
 */
void 
uthread_yield()
{
    145f:	55                   	push   %ebp
    1460:	89 e5                	mov    %esp,%ebp
    1462:	83 ec 28             	sub    $0x28,%esp
  alarm(0); //clear the alarm so as not to disturb running of function
    1465:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    146c:	e8 37 f6 ff ff       	call   aa8 <alarm>
  int new=getNextThread(currentThread->tid);
    1471:	a1 00 67 00 00       	mov    0x6700,%eax
    1476:	8b 00                	mov    (%eax),%eax
    1478:	89 04 24             	mov    %eax,(%esp)
    147b:	e8 49 fb ff ff       	call   fc9 <getNextThread>
    1480:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(new==-1)
    1483:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
    1487:	75 2d                	jne    14b6 <uthread_yield+0x57>
  {
    if(alarm(THREAD_QUANTA)<0)
    1489:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
    1490:	e8 13 f6 ff ff       	call   aa8 <alarm>
    1495:	85 c0                	test   %eax,%eax
    1497:	0f 89 c1 00 00 00    	jns    155e <uthread_yield+0xff>
    {
      printf(1,"Cant activate alarm system call\n");
    149d:	c7 44 24 04 3c 17 00 	movl   $0x173c,0x4(%esp)
    14a4:	00 
    14a5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    14ac:	e8 d6 f6 ff ff       	call   b87 <printf>
      exit();
    14b1:	e8 22 f5 ff ff       	call   9d8 <exit>
    } 
  }
  else
  {
    //store all leaving thread registers and pointers
    PUSH_ALL_REGISTERS();
    14b6:	60                   	pusha  
    STORE_ESP(currentThread->esp);
    14b7:	a1 00 67 00 00       	mov    0x6700,%eax
    14bc:	89 e2                	mov    %esp,%edx
    14be:	89 50 04             	mov    %edx,0x4(%eax)
    STORE_EBP(currentThread->ebp);
    14c1:	a1 00 67 00 00       	mov    0x6700,%eax
    14c6:	89 ea                	mov    %ebp,%edx
    14c8:	89 50 08             	mov    %edx,0x8(%eax)
    
    //change thread state
    if(currentThread->state==T_RUNNING) //might be sleeping from join operation
    14cb:	a1 00 67 00 00       	mov    0x6700,%eax
    14d0:	8b 40 10             	mov    0x10(%eax),%eax
    14d3:	83 f8 02             	cmp    $0x2,%eax
    14d6:	75 0c                	jne    14e4 <uthread_yield+0x85>
      currentThread->state=T_RUNNABLE;
    14d8:	a1 00 67 00 00       	mov    0x6700,%eax
    14dd:	c7 40 10 03 00 00 00 	movl   $0x3,0x10(%eax)

    currentThread=&tTable.table[new];
    14e4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14e7:	69 c0 24 01 00 00    	imul   $0x124,%eax,%eax
    14ed:	05 00 1e 00 00       	add    $0x1e00,%eax
    14f2:	a3 00 67 00 00       	mov    %eax,0x6700

    //load all new thread registers and pointers
    LOAD_ESP(currentThread->esp);
    14f7:	a1 00 67 00 00       	mov    0x6700,%eax
    14fc:	8b 40 04             	mov    0x4(%eax),%eax
    14ff:	89 c4                	mov    %eax,%esp
    LOAD_EBP(currentThread->ebp);
    1501:	a1 00 67 00 00       	mov    0x6700,%eax
    1506:	8b 40 08             	mov    0x8(%eax),%eax
    1509:	89 c5                	mov    %eax,%ebp
    //set new alram clock
    if(alarm(THREAD_QUANTA)<0)
    150b:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
    1512:	e8 91 f5 ff ff       	call   aa8 <alarm>
    1517:	85 c0                	test   %eax,%eax
    1519:	79 19                	jns    1534 <uthread_yield+0xd5>
    {
      printf(1,"Cant activate alarm system call\n");
    151b:	c7 44 24 04 3c 17 00 	movl   $0x173c,0x4(%esp)
    1522:	00 
    1523:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    152a:	e8 58 f6 ff ff       	call   b87 <printf>
      exit();
    152f:	e8 a4 f4 ff ff       	call   9d8 <exit>
    }  
    currentThread->state=T_RUNNING;
    1534:	a1 00 67 00 00       	mov    0x6700,%eax
    1539:	c7 40 10 02 00 00 00 	movl   $0x2,0x10(%eax)
    
    if(currentThread->firstTime==1)
    1540:	a1 00 67 00 00       	mov    0x6700,%eax
    1545:	8b 40 14             	mov    0x14(%eax),%eax
    1548:	83 f8 01             	cmp    $0x1,%eax
    154b:	75 10                	jne    155d <uthread_yield+0xfe>
    {
    currentThread->firstTime=0;
    154d:	a1 00 67 00 00       	mov    0x6700,%eax
    1552:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
    POP_AND_RET();
    1559:	5d                   	pop    %ebp
    155a:	c3                   	ret    
    155b:	eb 01                	jmp    155e <uthread_yield+0xff>
    }
    else
    {
      POP_ALL_REGISTERS();
    155d:	61                   	popa   
    }
  }
}
    155e:	c9                   	leave  
    155f:	c3                   	ret    

00001560 <uthread_self>:

int
uthread_self(void)
{
    1560:	55                   	push   %ebp
    1561:	89 e5                	mov    %esp,%ebp
  return currentThread->tid;
    1563:	a1 00 67 00 00       	mov    0x6700,%eax
    1568:	8b 00                	mov    (%eax),%eax
    156a:	5d                   	pop    %ebp
    156b:	c3                   	ret    

0000156c <xchg>:
#include "fs.h"
#include "uthread.h"

static inline uint
xchg(volatile uint *addr, uint newval)
{
    156c:	55                   	push   %ebp
    156d:	89 e5                	mov    %esp,%ebp
    156f:	53                   	push   %ebx
    1570:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
               "+m" (*addr), "=a" (result) :
    1573:	8b 55 08             	mov    0x8(%ebp),%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
    1576:	8b 45 0c             	mov    0xc(%ebp),%eax
               "+m" (*addr), "=a" (result) :
    1579:	8b 4d 08             	mov    0x8(%ebp),%ecx
xchg(volatile uint *addr, uint newval)
{
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
    157c:	89 c3                	mov    %eax,%ebx
    157e:	89 d8                	mov    %ebx,%eax
    1580:	f0 87 02             	lock xchg %eax,(%edx)
    1583:	89 c3                	mov    %eax,%ebx
    1585:	89 5d f8             	mov    %ebx,-0x8(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
    1588:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
    158b:	83 c4 10             	add    $0x10,%esp
    158e:	5b                   	pop    %ebx
    158f:	5d                   	pop    %ebp
    1590:	c3                   	ret    

00001591 <binary_semaphore_init>:
semaphore->taken=0;
}*/

void
binary_semaphore_init(struct binary_semaphore* semaphore, int value)
{
    1591:	55                   	push   %ebp
    1592:	89 e5                	mov    %esp,%ebp
    1594:	83 ec 08             	sub    $0x8,%esp
  semaphore->init=0;
    1597:	8b 45 08             	mov    0x8(%ebp),%eax
    159a:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
  
  if(value!=0)
    15a1:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    15a5:	74 0c                	je     15b3 <binary_semaphore_init+0x22>
    semaphore->thread=-1;
    15a7:	8b 45 08             	mov    0x8(%ebp),%eax
    15aa:	c7 40 04 ff ff ff ff 	movl   $0xffffffff,0x4(%eax)
    15b1:	eb 0b                	jmp    15be <binary_semaphore_init+0x2d>
  else 
    semaphore->thread = uthread_self();
    15b3:	e8 a8 ff ff ff       	call   1560 <uthread_self>
    15b8:	8b 55 08             	mov    0x8(%ebp),%edx
    15bb:	89 42 04             	mov    %eax,0x4(%edx)
  
  semaphore->locked = value;
    15be:	8b 55 0c             	mov    0xc(%ebp),%edx
    15c1:	8b 45 08             	mov    0x8(%ebp),%eax
    15c4:	89 10                	mov    %edx,(%eax)
 // semaphore->taken=0;
  semaphore->init=1;
    15c6:	8b 45 08             	mov    0x8(%ebp),%eax
    15c9:	c7 40 08 01 00 00 00 	movl   $0x1,0x8(%eax)
  
}
    15d0:	c9                   	leave  
    15d1:	c3                   	ret    

000015d2 <binary_semaphore_down>:

void 
binary_semaphore_down(struct binary_semaphore* semaphore)
{
    15d2:	55                   	push   %ebp
    15d3:	89 e5                	mov    %esp,%ebp
    15d5:	83 ec 28             	sub    $0x28,%esp
  //semaphore_acquire(semaphore);
  if(semaphore->init==0)
    15d8:	8b 45 08             	mov    0x8(%ebp),%eax
    15db:	8b 40 08             	mov    0x8(%eax),%eax
    15de:	85 c0                	test   %eax,%eax
    15e0:	75 20                	jne    1602 <binary_semaphore_down+0x30>
  {
   printf(1,"(down)semaphore uninitialized yet (thread %d)\n",semaphore->thread);
    15e2:	8b 45 08             	mov    0x8(%ebp),%eax
    15e5:	8b 40 04             	mov    0x4(%eax),%eax
    15e8:	89 44 24 08          	mov    %eax,0x8(%esp)
    15ec:	c7 44 24 04 60 17 00 	movl   $0x1760,0x4(%esp)
    15f3:	00 
    15f4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    15fb:	e8 87 f5 ff ff       	call   b87 <printf>
    return;
    1600:	eb 3a                	jmp    163c <binary_semaphore_down+0x6a>
  }
  
  
  int i= uthread_self();
    1602:	e8 59 ff ff ff       	call   1560 <uthread_self>
    1607:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(semaphore->thread!=i)
    160a:	8b 45 08             	mov    0x8(%ebp),%eax
    160d:	8b 40 04             	mov    0x4(%eax),%eax
    1610:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1613:	74 27                	je     163c <binary_semaphore_down+0x6a>
  {
    while(xchg(&semaphore->locked, 0) == 0) //means the semaphore is taken allready
    1615:	eb 05                	jmp    161c <binary_semaphore_down+0x4a>
    {
      uthread_yield();
    1617:	e8 43 fe ff ff       	call   145f <uthread_yield>
  
  
  int i= uthread_self();
  if(semaphore->thread!=i)
  {
    while(xchg(&semaphore->locked, 0) == 0) //means the semaphore is taken allready
    161c:	8b 45 08             	mov    0x8(%ebp),%eax
    161f:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1626:	00 
    1627:	89 04 24             	mov    %eax,(%esp)
    162a:	e8 3d ff ff ff       	call   156c <xchg>
    162f:	85 c0                	test   %eax,%eax
    1631:	74 e4                	je     1617 <binary_semaphore_down+0x45>
    {
      uthread_yield();
    }
    semaphore->thread = i;
    1633:	8b 45 08             	mov    0x8(%ebp),%eax
    1636:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1639:	89 50 04             	mov    %edx,0x4(%eax)
  }
  //semaphore_release(semaphore);
}
    163c:	c9                   	leave  
    163d:	c3                   	ret    

0000163e <binary_semaphore_up>:

void 
binary_semaphore_up(struct binary_semaphore* semaphore)
{
    163e:	55                   	push   %ebp
    163f:	89 e5                	mov    %esp,%ebp
    1641:	83 ec 28             	sub    $0x28,%esp
  //semaphore_acquire(semaphore);
    if(semaphore->init==0)
    1644:	8b 45 08             	mov    0x8(%ebp),%eax
    1647:	8b 40 08             	mov    0x8(%eax),%eax
    164a:	85 c0                	test   %eax,%eax
    164c:	75 20                	jne    166e <binary_semaphore_up+0x30>
    {
    printf(1,"(up)semaphore uninitialized yet (thread %d)\n",semaphore->thread);
    164e:	8b 45 08             	mov    0x8(%ebp),%eax
    1651:	8b 40 04             	mov    0x4(%eax),%eax
    1654:	89 44 24 08          	mov    %eax,0x8(%esp)
    1658:	c7 44 24 04 90 17 00 	movl   $0x1790,0x4(%esp)
    165f:	00 
    1660:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1667:	e8 1b f5 ff ff       	call   b87 <printf>
    return;
    166c:	eb 2f                	jmp    169d <binary_semaphore_up+0x5f>
    }
  
  int i= uthread_self();
    166e:	e8 ed fe ff ff       	call   1560 <uthread_self>
    1673:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if( semaphore->locked == 0 && semaphore->thread == i)
    1676:	8b 45 08             	mov    0x8(%ebp),%eax
    1679:	8b 00                	mov    (%eax),%eax
    167b:	85 c0                	test   %eax,%eax
    167d:	75 1e                	jne    169d <binary_semaphore_up+0x5f>
    167f:	8b 45 08             	mov    0x8(%ebp),%eax
    1682:	8b 40 04             	mov    0x4(%eax),%eax
    1685:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1688:	75 13                	jne    169d <binary_semaphore_up+0x5f>
  {
      semaphore->thread = -1;
    168a:	8b 45 08             	mov    0x8(%ebp),%eax
    168d:	c7 40 04 ff ff ff ff 	movl   $0xffffffff,0x4(%eax)
      semaphore->locked = 1;
    1694:	8b 45 08             	mov    0x8(%ebp),%eax
    1697:	c7 00 01 00 00 00    	movl   $0x1,(%eax)

  }
//semaphore_release(semaphore);
    169d:	c9                   	leave  
    169e:	c3                   	ret    
