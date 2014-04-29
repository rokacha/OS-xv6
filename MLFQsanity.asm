
_MLFQsanity:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char *argv[])
{
       0:	55                   	push   %ebp
       1:	89 e5                	mov    %esp,%ebp
       3:	53                   	push   %ebx
       4:	83 e4 f0             	and    $0xfffffff0,%esp
       7:	81 ec 40 02 00 00    	sub    $0x240,%esp
  uint i,j,k=1,cid;
       d:	c7 84 24 34 02 00 00 	movl   $0x1,0x234(%esp)
      14:	01 00 00 00 
  int wtime[20],pid[20],rtime[20],iotime[20],ttime[20],acid[20];
 

  for(i=0 ; i<20 ; i++)
      18:	c7 84 24 3c 02 00 00 	movl   $0x0,0x23c(%esp)
      1f:	00 00 00 00 
      23:	eb 54                	jmp    79 <main+0x79>
  {
    if(k!=0)
      25:	83 bc 24 34 02 00 00 	cmpl   $0x0,0x234(%esp)
      2c:	00 
      2d:	74 28                	je     57 <main+0x57>
    {
      k=fork();
      2f:	e8 38 08 00 00       	call   86c <fork>
      34:	89 84 24 34 02 00 00 	mov    %eax,0x234(%esp)
      if(k!=0)
      3b:	83 bc 24 34 02 00 00 	cmpl   $0x0,0x234(%esp)
      42:	00 
      43:	74 12                	je     57 <main+0x57>
        acid[i]=k;  
      45:	8b 94 24 34 02 00 00 	mov    0x234(%esp),%edx
      4c:	8b 84 24 3c 02 00 00 	mov    0x23c(%esp),%eax
      53:	89 54 84 28          	mov    %edx,0x28(%esp,%eax,4)
    }
    if(k==0)
      57:	83 bc 24 34 02 00 00 	cmpl   $0x0,0x234(%esp)
      5e:	00 
      5f:	75 10                	jne    71 <main+0x71>
    {
      cid=i;
      61:	8b 84 24 3c 02 00 00 	mov    0x23c(%esp),%eax
      68:	89 84 24 30 02 00 00 	mov    %eax,0x230(%esp)
      break;
      6f:	eb 12                	jmp    83 <main+0x83>
{
  uint i,j,k=1,cid;
  int wtime[20],pid[20],rtime[20],iotime[20],ttime[20],acid[20];
 

  for(i=0 ; i<20 ; i++)
      71:	83 84 24 3c 02 00 00 	addl   $0x1,0x23c(%esp)
      78:	01 
      79:	83 bc 24 3c 02 00 00 	cmpl   $0x13,0x23c(%esp)
      80:	13 
      81:	76 a2                	jbe    25 <main+0x25>
      break;
    }
  }


if(k==0)
      83:	83 bc 24 34 02 00 00 	cmpl   $0x0,0x234(%esp)
      8a:	00 
      8b:	0f 85 c4 00 00 00    	jne    155 <main+0x155>
{
  if(cid%2==0)
      91:	8b 84 24 30 02 00 00 	mov    0x230(%esp),%eax
      98:	83 e0 01             	and    $0x1,%eax
      9b:	85 c0                	test   %eax,%eax
      9d:	75 59                	jne    f8 <main+0xf8>
    {
      int m=0;
      9f:	c7 84 24 2c 02 00 00 	movl   $0x0,0x22c(%esp)
      a6:	00 00 00 00 
      for(i=0;i<10000;i++)
      aa:	c7 84 24 3c 02 00 00 	movl   $0x0,0x23c(%esp)
      b1:	00 00 00 00 
      b5:	eb 32                	jmp    e9 <main+0xe9>
        for(j=0;j<10000;j++)
      b7:	c7 84 24 38 02 00 00 	movl   $0x0,0x238(%esp)
      be:	00 00 00 00 
      c2:	eb 10                	jmp    d4 <main+0xd4>
              m=m+1;
      c4:	83 84 24 2c 02 00 00 	addl   $0x1,0x22c(%esp)
      cb:	01 
{
  if(cid%2==0)
    {
      int m=0;
      for(i=0;i<10000;i++)
        for(j=0;j<10000;j++)
      cc:	83 84 24 38 02 00 00 	addl   $0x1,0x238(%esp)
      d3:	01 
      d4:	81 bc 24 38 02 00 00 	cmpl   $0x270f,0x238(%esp)
      db:	0f 27 00 00 
      df:	76 e3                	jbe    c4 <main+0xc4>
if(k==0)
{
  if(cid%2==0)
    {
      int m=0;
      for(i=0;i<10000;i++)
      e1:	83 84 24 3c 02 00 00 	addl   $0x1,0x23c(%esp)
      e8:	01 
      e9:	81 bc 24 3c 02 00 00 	cmpl   $0x270f,0x23c(%esp)
      f0:	0f 27 00 00 
      f4:	76 c1                	jbe    b7 <main+0xb7>
      f6:	eb 0c                	jmp    104 <main+0x104>
        for(j=0;j<10000;j++)
              m=m+1;
    }
    else
    {
      sleep(1);
      f8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
      ff:	e8 00 08 00 00       	call   904 <sleep>
      //printf(1,"io call\n");
    }
     for(j=0;j<500;j++)
     104:	c7 84 24 38 02 00 00 	movl   $0x0,0x238(%esp)
     10b:	00 00 00 00 
     10f:	eb 32                	jmp    143 <main+0x143>
      {
         printf(1,"cid is:%d time number:%d\n", cid, j);
     111:	8b 84 24 38 02 00 00 	mov    0x238(%esp),%eax
     118:	89 44 24 0c          	mov    %eax,0xc(%esp)
     11c:	8b 84 24 30 02 00 00 	mov    0x230(%esp),%eax
     123:	89 44 24 08          	mov    %eax,0x8(%esp)
     127:	c7 44 24 04 3c 15 00 	movl   $0x153c,0x4(%esp)
     12e:	00 
     12f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     136:	e8 e8 08 00 00       	call   a23 <printf>
    else
    {
      sleep(1);
      //printf(1,"io call\n");
    }
     for(j=0;j<500;j++)
     13b:	83 84 24 38 02 00 00 	addl   $0x1,0x238(%esp)
     142:	01 
     143:	81 bc 24 38 02 00 00 	cmpl   $0x1f3,0x238(%esp)
     14a:	f3 01 00 00 
     14e:	76 c1                	jbe    111 <main+0x111>
     150:	e9 b4 04 00 00       	jmp    609 <main+0x609>
         printf(1,"cid is:%d time number:%d\n", cid, j);
      }
  }
 else
  {
    int mwtime=0,mrtime=0,mttime=0;
     155:	c7 84 24 28 02 00 00 	movl   $0x0,0x228(%esp)
     15c:	00 00 00 00 
     160:	c7 84 24 24 02 00 00 	movl   $0x0,0x224(%esp)
     167:	00 00 00 00 
     16b:	c7 84 24 20 02 00 00 	movl   $0x0,0x220(%esp)
     172:	00 00 00 00 
    for(i=0;i<20;i++)
     176:	c7 84 24 3c 02 00 00 	movl   $0x0,0x23c(%esp)
     17d:	00 00 00 00 
     181:	e9 e1 00 00 00       	jmp    267 <main+0x267>
    {
      pid[i]=wait2(&wtime[i],&rtime[i],&iotime[i]);
     186:	8b 84 24 3c 02 00 00 	mov    0x23c(%esp),%eax
     18d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
     194:	8d 84 24 c8 00 00 00 	lea    0xc8(%esp),%eax
     19b:	8d 0c 10             	lea    (%eax,%edx,1),%ecx
     19e:	8b 84 24 3c 02 00 00 	mov    0x23c(%esp),%eax
     1a5:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
     1ac:	8d 84 24 18 01 00 00 	lea    0x118(%esp),%eax
     1b3:	01 c2                	add    %eax,%edx
     1b5:	8b 84 24 3c 02 00 00 	mov    0x23c(%esp),%eax
     1bc:	8d 1c 85 00 00 00 00 	lea    0x0(,%eax,4),%ebx
     1c3:	8d 84 24 b8 01 00 00 	lea    0x1b8(%esp),%eax
     1ca:	01 d8                	add    %ebx,%eax
     1cc:	89 4c 24 08          	mov    %ecx,0x8(%esp)
     1d0:	89 54 24 04          	mov    %edx,0x4(%esp)
     1d4:	89 04 24             	mov    %eax,(%esp)
     1d7:	e8 40 07 00 00       	call   91c <wait2>
     1dc:	8b 94 24 3c 02 00 00 	mov    0x23c(%esp),%edx
     1e3:	89 84 94 68 01 00 00 	mov    %eax,0x168(%esp,%edx,4)
      mwtime+=wtime[i];
     1ea:	8b 84 24 3c 02 00 00 	mov    0x23c(%esp),%eax
     1f1:	8b 84 84 b8 01 00 00 	mov    0x1b8(%esp,%eax,4),%eax
     1f8:	01 84 24 28 02 00 00 	add    %eax,0x228(%esp)
      mrtime+=rtime[i];
     1ff:	8b 84 24 3c 02 00 00 	mov    0x23c(%esp),%eax
     206:	8b 84 84 18 01 00 00 	mov    0x118(%esp,%eax,4),%eax
     20d:	01 84 24 24 02 00 00 	add    %eax,0x224(%esp)
      ttime[i]=wtime[i]+iotime[i]+rtime[i];
     214:	8b 84 24 3c 02 00 00 	mov    0x23c(%esp),%eax
     21b:	8b 94 84 b8 01 00 00 	mov    0x1b8(%esp,%eax,4),%edx
     222:	8b 84 24 3c 02 00 00 	mov    0x23c(%esp),%eax
     229:	8b 84 84 c8 00 00 00 	mov    0xc8(%esp,%eax,4),%eax
     230:	01 c2                	add    %eax,%edx
     232:	8b 84 24 3c 02 00 00 	mov    0x23c(%esp),%eax
     239:	8b 84 84 18 01 00 00 	mov    0x118(%esp,%eax,4),%eax
     240:	01 c2                	add    %eax,%edx
     242:	8b 84 24 3c 02 00 00 	mov    0x23c(%esp),%eax
     249:	89 54 84 78          	mov    %edx,0x78(%esp,%eax,4)
      mttime+=ttime[i];
     24d:	8b 84 24 3c 02 00 00 	mov    0x23c(%esp),%eax
     254:	8b 44 84 78          	mov    0x78(%esp,%eax,4),%eax
     258:	01 84 24 20 02 00 00 	add    %eax,0x220(%esp)
      }
  }
 else
  {
    int mwtime=0,mrtime=0,mttime=0;
    for(i=0;i<20;i++)
     25f:	83 84 24 3c 02 00 00 	addl   $0x1,0x23c(%esp)
     266:	01 
     267:	83 bc 24 3c 02 00 00 	cmpl   $0x13,0x23c(%esp)
     26e:	13 
     26f:	0f 86 11 ff ff ff    	jbe    186 <main+0x186>
      mwtime+=wtime[i];
      mrtime+=rtime[i];
      ttime[i]=wtime[i]+iotime[i]+rtime[i];
      mttime+=ttime[i];
    }
    mwtime=mwtime/20;
     275:	8b 8c 24 28 02 00 00 	mov    0x228(%esp),%ecx
     27c:	ba 67 66 66 66       	mov    $0x66666667,%edx
     281:	89 c8                	mov    %ecx,%eax
     283:	f7 ea                	imul   %edx
     285:	c1 fa 03             	sar    $0x3,%edx
     288:	89 c8                	mov    %ecx,%eax
     28a:	c1 f8 1f             	sar    $0x1f,%eax
     28d:	89 d1                	mov    %edx,%ecx
     28f:	29 c1                	sub    %eax,%ecx
     291:	89 c8                	mov    %ecx,%eax
     293:	89 84 24 28 02 00 00 	mov    %eax,0x228(%esp)
    mrtime=mrtime/20;
     29a:	8b 8c 24 24 02 00 00 	mov    0x224(%esp),%ecx
     2a1:	ba 67 66 66 66       	mov    $0x66666667,%edx
     2a6:	89 c8                	mov    %ecx,%eax
     2a8:	f7 ea                	imul   %edx
     2aa:	c1 fa 03             	sar    $0x3,%edx
     2ad:	89 c8                	mov    %ecx,%eax
     2af:	c1 f8 1f             	sar    $0x1f,%eax
     2b2:	89 d1                	mov    %edx,%ecx
     2b4:	29 c1                	sub    %eax,%ecx
     2b6:	89 c8                	mov    %ecx,%eax
     2b8:	89 84 24 24 02 00 00 	mov    %eax,0x224(%esp)
    mttime=mttime/20;
     2bf:	8b 8c 24 20 02 00 00 	mov    0x220(%esp),%ecx
     2c6:	ba 67 66 66 66       	mov    $0x66666667,%edx
     2cb:	89 c8                	mov    %ecx,%eax
     2cd:	f7 ea                	imul   %edx
     2cf:	c1 fa 03             	sar    $0x3,%edx
     2d2:	89 c8                	mov    %ecx,%eax
     2d4:	c1 f8 1f             	sar    $0x1f,%eax
     2d7:	89 d1                	mov    %edx,%ecx
     2d9:	29 c1                	sub    %eax,%ecx
     2db:	89 c8                	mov    %ecx,%eax
     2dd:	89 84 24 20 02 00 00 	mov    %eax,0x220(%esp)
    printf(1,"avg wtime:%davg rtime:%davg turnaround time:%d\n", mwtime, mrtime, mttime);
     2e4:	8b 84 24 20 02 00 00 	mov    0x220(%esp),%eax
     2eb:	89 44 24 10          	mov    %eax,0x10(%esp)
     2ef:	8b 84 24 24 02 00 00 	mov    0x224(%esp),%eax
     2f6:	89 44 24 0c          	mov    %eax,0xc(%esp)
     2fa:	8b 84 24 28 02 00 00 	mov    0x228(%esp),%eax
     301:	89 44 24 08          	mov    %eax,0x8(%esp)
     305:	c7 44 24 04 58 15 00 	movl   $0x1558,0x4(%esp)
     30c:	00 
     30d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     314:	e8 0a 07 00 00       	call   a23 <printf>
    int mwtime1=0,mrtime1=0,mttime1=0,mwtime2=0,mrtime2=0,mttime2=0;
     319:	c7 84 24 1c 02 00 00 	movl   $0x0,0x21c(%esp)
     320:	00 00 00 00 
     324:	c7 84 24 18 02 00 00 	movl   $0x0,0x218(%esp)
     32b:	00 00 00 00 
     32f:	c7 84 24 14 02 00 00 	movl   $0x0,0x214(%esp)
     336:	00 00 00 00 
     33a:	c7 84 24 10 02 00 00 	movl   $0x0,0x210(%esp)
     341:	00 00 00 00 
     345:	c7 84 24 0c 02 00 00 	movl   $0x0,0x20c(%esp)
     34c:	00 00 00 00 
     350:	c7 84 24 08 02 00 00 	movl   $0x0,0x208(%esp)
     357:	00 00 00 00 
    for(i=0;i<20;i++)
     35b:	c7 84 24 3c 02 00 00 	movl   $0x0,0x23c(%esp)
     362:	00 00 00 00 
     366:	e9 d7 00 00 00       	jmp    442 <main+0x442>
    {
      for(j=0;j<20;j++)
     36b:	c7 84 24 38 02 00 00 	movl   $0x0,0x238(%esp)
     372:	00 00 00 00 
     376:	e9 b1 00 00 00       	jmp    42c <main+0x42c>
      {
        if(pid[j]==acid[i])
     37b:	8b 84 24 38 02 00 00 	mov    0x238(%esp),%eax
     382:	8b 94 84 68 01 00 00 	mov    0x168(%esp,%eax,4),%edx
     389:	8b 84 24 3c 02 00 00 	mov    0x23c(%esp),%eax
     390:	8b 44 84 28          	mov    0x28(%esp,%eax,4),%eax
     394:	39 c2                	cmp    %eax,%edx
     396:	0f 85 88 00 00 00    	jne    424 <main+0x424>
        {
          if(i%2==0)
     39c:	8b 84 24 3c 02 00 00 	mov    0x23c(%esp),%eax
     3a3:	83 e0 01             	and    $0x1,%eax
     3a6:	85 c0                	test   %eax,%eax
     3a8:	75 3e                	jne    3e8 <main+0x3e8>
          {
            mwtime2+=wtime[j];
     3aa:	8b 84 24 38 02 00 00 	mov    0x238(%esp),%eax
     3b1:	8b 84 84 b8 01 00 00 	mov    0x1b8(%esp,%eax,4),%eax
     3b8:	01 84 24 10 02 00 00 	add    %eax,0x210(%esp)
            mrtime2+=rtime[j];
     3bf:	8b 84 24 38 02 00 00 	mov    0x238(%esp),%eax
     3c6:	8b 84 84 18 01 00 00 	mov    0x118(%esp,%eax,4),%eax
     3cd:	01 84 24 0c 02 00 00 	add    %eax,0x20c(%esp)
            mttime2+=ttime[j];
     3d4:	8b 84 24 38 02 00 00 	mov    0x238(%esp),%eax
     3db:	8b 44 84 78          	mov    0x78(%esp,%eax,4),%eax
     3df:	01 84 24 08 02 00 00 	add    %eax,0x208(%esp)
     3e6:	eb 3c                	jmp    424 <main+0x424>
          }
          else
          {
            mwtime1+=wtime[j];
     3e8:	8b 84 24 38 02 00 00 	mov    0x238(%esp),%eax
     3ef:	8b 84 84 b8 01 00 00 	mov    0x1b8(%esp,%eax,4),%eax
     3f6:	01 84 24 1c 02 00 00 	add    %eax,0x21c(%esp)
            mrtime1+=rtime[j];
     3fd:	8b 84 24 38 02 00 00 	mov    0x238(%esp),%eax
     404:	8b 84 84 18 01 00 00 	mov    0x118(%esp,%eax,4),%eax
     40b:	01 84 24 18 02 00 00 	add    %eax,0x218(%esp)
            mttime1+=ttime[j];
     412:	8b 84 24 38 02 00 00 	mov    0x238(%esp),%eax
     419:	8b 44 84 78          	mov    0x78(%esp,%eax,4),%eax
     41d:	01 84 24 14 02 00 00 	add    %eax,0x214(%esp)
    mttime=mttime/20;
    printf(1,"avg wtime:%davg rtime:%davg turnaround time:%d\n", mwtime, mrtime, mttime);
    int mwtime1=0,mrtime1=0,mttime1=0,mwtime2=0,mrtime2=0,mttime2=0;
    for(i=0;i<20;i++)
    {
      for(j=0;j<20;j++)
     424:	83 84 24 38 02 00 00 	addl   $0x1,0x238(%esp)
     42b:	01 
     42c:	83 bc 24 38 02 00 00 	cmpl   $0x13,0x238(%esp)
     433:	13 
     434:	0f 86 41 ff ff ff    	jbe    37b <main+0x37b>
    mwtime=mwtime/20;
    mrtime=mrtime/20;
    mttime=mttime/20;
    printf(1,"avg wtime:%davg rtime:%davg turnaround time:%d\n", mwtime, mrtime, mttime);
    int mwtime1=0,mrtime1=0,mttime1=0,mwtime2=0,mrtime2=0,mttime2=0;
    for(i=0;i<20;i++)
     43a:	83 84 24 3c 02 00 00 	addl   $0x1,0x23c(%esp)
     441:	01 
     442:	83 bc 24 3c 02 00 00 	cmpl   $0x13,0x23c(%esp)
     449:	13 
     44a:	0f 86 1b ff ff ff    	jbe    36b <main+0x36b>
            mttime1+=ttime[j];
          }
        }
      }
    }
    mwtime2=mwtime2/10;
     450:	8b 8c 24 10 02 00 00 	mov    0x210(%esp),%ecx
     457:	ba 67 66 66 66       	mov    $0x66666667,%edx
     45c:	89 c8                	mov    %ecx,%eax
     45e:	f7 ea                	imul   %edx
     460:	c1 fa 02             	sar    $0x2,%edx
     463:	89 c8                	mov    %ecx,%eax
     465:	c1 f8 1f             	sar    $0x1f,%eax
     468:	89 d1                	mov    %edx,%ecx
     46a:	29 c1                	sub    %eax,%ecx
     46c:	89 c8                	mov    %ecx,%eax
     46e:	89 84 24 10 02 00 00 	mov    %eax,0x210(%esp)
    mrtime2=mrtime2/10;
     475:	8b 8c 24 0c 02 00 00 	mov    0x20c(%esp),%ecx
     47c:	ba 67 66 66 66       	mov    $0x66666667,%edx
     481:	89 c8                	mov    %ecx,%eax
     483:	f7 ea                	imul   %edx
     485:	c1 fa 02             	sar    $0x2,%edx
     488:	89 c8                	mov    %ecx,%eax
     48a:	c1 f8 1f             	sar    $0x1f,%eax
     48d:	89 d1                	mov    %edx,%ecx
     48f:	29 c1                	sub    %eax,%ecx
     491:	89 c8                	mov    %ecx,%eax
     493:	89 84 24 0c 02 00 00 	mov    %eax,0x20c(%esp)
    mttime2=mttime2/10;
     49a:	8b 8c 24 08 02 00 00 	mov    0x208(%esp),%ecx
     4a1:	ba 67 66 66 66       	mov    $0x66666667,%edx
     4a6:	89 c8                	mov    %ecx,%eax
     4a8:	f7 ea                	imul   %edx
     4aa:	c1 fa 02             	sar    $0x2,%edx
     4ad:	89 c8                	mov    %ecx,%eax
     4af:	c1 f8 1f             	sar    $0x1f,%eax
     4b2:	89 d1                	mov    %edx,%ecx
     4b4:	29 c1                	sub    %eax,%ecx
     4b6:	89 c8                	mov    %ecx,%eax
     4b8:	89 84 24 08 02 00 00 	mov    %eax,0x208(%esp)
    mwtime1=mwtime1/10;
     4bf:	8b 8c 24 1c 02 00 00 	mov    0x21c(%esp),%ecx
     4c6:	ba 67 66 66 66       	mov    $0x66666667,%edx
     4cb:	89 c8                	mov    %ecx,%eax
     4cd:	f7 ea                	imul   %edx
     4cf:	c1 fa 02             	sar    $0x2,%edx
     4d2:	89 c8                	mov    %ecx,%eax
     4d4:	c1 f8 1f             	sar    $0x1f,%eax
     4d7:	89 d1                	mov    %edx,%ecx
     4d9:	29 c1                	sub    %eax,%ecx
     4db:	89 c8                	mov    %ecx,%eax
     4dd:	89 84 24 1c 02 00 00 	mov    %eax,0x21c(%esp)
    mrtime1=mrtime1/10;
     4e4:	8b 8c 24 18 02 00 00 	mov    0x218(%esp),%ecx
     4eb:	ba 67 66 66 66       	mov    $0x66666667,%edx
     4f0:	89 c8                	mov    %ecx,%eax
     4f2:	f7 ea                	imul   %edx
     4f4:	c1 fa 02             	sar    $0x2,%edx
     4f7:	89 c8                	mov    %ecx,%eax
     4f9:	c1 f8 1f             	sar    $0x1f,%eax
     4fc:	89 d1                	mov    %edx,%ecx
     4fe:	29 c1                	sub    %eax,%ecx
     500:	89 c8                	mov    %ecx,%eax
     502:	89 84 24 18 02 00 00 	mov    %eax,0x218(%esp)
    mttime1=mttime1/10;
     509:	8b 8c 24 14 02 00 00 	mov    0x214(%esp),%ecx
     510:	ba 67 66 66 66       	mov    $0x66666667,%edx
     515:	89 c8                	mov    %ecx,%eax
     517:	f7 ea                	imul   %edx
     519:	c1 fa 02             	sar    $0x2,%edx
     51c:	89 c8                	mov    %ecx,%eax
     51e:	c1 f8 1f             	sar    $0x1f,%eax
     521:	89 d1                	mov    %edx,%ecx
     523:	29 c1                	sub    %eax,%ecx
     525:	89 c8                	mov    %ecx,%eax
     527:	89 84 24 14 02 00 00 	mov    %eax,0x214(%esp)
    printf(1,"high priority: wtime:%d rtime:%d turnaround time:%d\n", mwtime1, mrtime1, mttime1);
     52e:	8b 84 24 14 02 00 00 	mov    0x214(%esp),%eax
     535:	89 44 24 10          	mov    %eax,0x10(%esp)
     539:	8b 84 24 18 02 00 00 	mov    0x218(%esp),%eax
     540:	89 44 24 0c          	mov    %eax,0xc(%esp)
     544:	8b 84 24 1c 02 00 00 	mov    0x21c(%esp),%eax
     54b:	89 44 24 08          	mov    %eax,0x8(%esp)
     54f:	c7 44 24 04 88 15 00 	movl   $0x1588,0x4(%esp)
     556:	00 
     557:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     55e:	e8 c0 04 00 00       	call   a23 <printf>
    printf(1,"low priority: wtime:%d rtime:%d turnaround time:%d\n", mwtime2, mrtime2, mttime2);
     563:	8b 84 24 08 02 00 00 	mov    0x208(%esp),%eax
     56a:	89 44 24 10          	mov    %eax,0x10(%esp)
     56e:	8b 84 24 0c 02 00 00 	mov    0x20c(%esp),%eax
     575:	89 44 24 0c          	mov    %eax,0xc(%esp)
     579:	8b 84 24 10 02 00 00 	mov    0x210(%esp),%eax
     580:	89 44 24 08          	mov    %eax,0x8(%esp)
     584:	c7 44 24 04 c0 15 00 	movl   $0x15c0,0x4(%esp)
     58b:	00 
     58c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     593:	e8 8b 04 00 00       	call   a23 <printf>
    for(i=0;i<20;i++)
     598:	c7 84 24 3c 02 00 00 	movl   $0x0,0x23c(%esp)
     59f:	00 00 00 00 
     5a3:	eb 5a                	jmp    5ff <main+0x5ff>
    {
      printf(1,"child:%d wtime:%d rtime:%d turnaround time:%d\n", i, wtime[i], rtime[i], ttime[i]);
     5a5:	8b 84 24 3c 02 00 00 	mov    0x23c(%esp),%eax
     5ac:	8b 4c 84 78          	mov    0x78(%esp,%eax,4),%ecx
     5b0:	8b 84 24 3c 02 00 00 	mov    0x23c(%esp),%eax
     5b7:	8b 94 84 18 01 00 00 	mov    0x118(%esp,%eax,4),%edx
     5be:	8b 84 24 3c 02 00 00 	mov    0x23c(%esp),%eax
     5c5:	8b 84 84 b8 01 00 00 	mov    0x1b8(%esp,%eax,4),%eax
     5cc:	89 4c 24 14          	mov    %ecx,0x14(%esp)
     5d0:	89 54 24 10          	mov    %edx,0x10(%esp)
     5d4:	89 44 24 0c          	mov    %eax,0xc(%esp)
     5d8:	8b 84 24 3c 02 00 00 	mov    0x23c(%esp),%eax
     5df:	89 44 24 08          	mov    %eax,0x8(%esp)
     5e3:	c7 44 24 04 f4 15 00 	movl   $0x15f4,0x4(%esp)
     5ea:	00 
     5eb:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     5f2:	e8 2c 04 00 00       	call   a23 <printf>
    mwtime1=mwtime1/10;
    mrtime1=mrtime1/10;
    mttime1=mttime1/10;
    printf(1,"high priority: wtime:%d rtime:%d turnaround time:%d\n", mwtime1, mrtime1, mttime1);
    printf(1,"low priority: wtime:%d rtime:%d turnaround time:%d\n", mwtime2, mrtime2, mttime2);
    for(i=0;i<20;i++)
     5f7:	83 84 24 3c 02 00 00 	addl   $0x1,0x23c(%esp)
     5fe:	01 
     5ff:	83 bc 24 3c 02 00 00 	cmpl   $0x13,0x23c(%esp)
     606:	13 
     607:	76 9c                	jbe    5a5 <main+0x5a5>
    {
      printf(1,"child:%d wtime:%d rtime:%d turnaround time:%d\n", i, wtime[i], rtime[i], ttime[i]);
    }
  }
  exit();
     609:	e8 66 02 00 00       	call   874 <exit>
     60e:	90                   	nop
     60f:	90                   	nop

00000610 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
     610:	55                   	push   %ebp
     611:	89 e5                	mov    %esp,%ebp
     613:	57                   	push   %edi
     614:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
     615:	8b 4d 08             	mov    0x8(%ebp),%ecx
     618:	8b 55 10             	mov    0x10(%ebp),%edx
     61b:	8b 45 0c             	mov    0xc(%ebp),%eax
     61e:	89 cb                	mov    %ecx,%ebx
     620:	89 df                	mov    %ebx,%edi
     622:	89 d1                	mov    %edx,%ecx
     624:	fc                   	cld    
     625:	f3 aa                	rep stos %al,%es:(%edi)
     627:	89 ca                	mov    %ecx,%edx
     629:	89 fb                	mov    %edi,%ebx
     62b:	89 5d 08             	mov    %ebx,0x8(%ebp)
     62e:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
     631:	5b                   	pop    %ebx
     632:	5f                   	pop    %edi
     633:	5d                   	pop    %ebp
     634:	c3                   	ret    

00000635 <strcpy>:
#include "x86.h"


char*
strcpy(char *s, char *t)
{
     635:	55                   	push   %ebp
     636:	89 e5                	mov    %esp,%ebp
     638:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
     63b:	8b 45 08             	mov    0x8(%ebp),%eax
     63e:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
     641:	90                   	nop
     642:	8b 45 0c             	mov    0xc(%ebp),%eax
     645:	0f b6 10             	movzbl (%eax),%edx
     648:	8b 45 08             	mov    0x8(%ebp),%eax
     64b:	88 10                	mov    %dl,(%eax)
     64d:	8b 45 08             	mov    0x8(%ebp),%eax
     650:	0f b6 00             	movzbl (%eax),%eax
     653:	84 c0                	test   %al,%al
     655:	0f 95 c0             	setne  %al
     658:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     65c:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
     660:	84 c0                	test   %al,%al
     662:	75 de                	jne    642 <strcpy+0xd>
    ;
  return os;
     664:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     667:	c9                   	leave  
     668:	c3                   	ret    

00000669 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     669:	55                   	push   %ebp
     66a:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
     66c:	eb 08                	jmp    676 <strcmp+0xd>
    p++, q++;
     66e:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     672:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
     676:	8b 45 08             	mov    0x8(%ebp),%eax
     679:	0f b6 00             	movzbl (%eax),%eax
     67c:	84 c0                	test   %al,%al
     67e:	74 10                	je     690 <strcmp+0x27>
     680:	8b 45 08             	mov    0x8(%ebp),%eax
     683:	0f b6 10             	movzbl (%eax),%edx
     686:	8b 45 0c             	mov    0xc(%ebp),%eax
     689:	0f b6 00             	movzbl (%eax),%eax
     68c:	38 c2                	cmp    %al,%dl
     68e:	74 de                	je     66e <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
     690:	8b 45 08             	mov    0x8(%ebp),%eax
     693:	0f b6 00             	movzbl (%eax),%eax
     696:	0f b6 d0             	movzbl %al,%edx
     699:	8b 45 0c             	mov    0xc(%ebp),%eax
     69c:	0f b6 00             	movzbl (%eax),%eax
     69f:	0f b6 c0             	movzbl %al,%eax
     6a2:	89 d1                	mov    %edx,%ecx
     6a4:	29 c1                	sub    %eax,%ecx
     6a6:	89 c8                	mov    %ecx,%eax
}
     6a8:	5d                   	pop    %ebp
     6a9:	c3                   	ret    

000006aa <strlen>:

uint
strlen(char *s)
{
     6aa:	55                   	push   %ebp
     6ab:	89 e5                	mov    %esp,%ebp
     6ad:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
     6b0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
     6b7:	eb 04                	jmp    6bd <strlen+0x13>
     6b9:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     6bd:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6c0:	03 45 08             	add    0x8(%ebp),%eax
     6c3:	0f b6 00             	movzbl (%eax),%eax
     6c6:	84 c0                	test   %al,%al
     6c8:	75 ef                	jne    6b9 <strlen+0xf>
    ;
  return n;
     6ca:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     6cd:	c9                   	leave  
     6ce:	c3                   	ret    

000006cf <memset>:

void*
memset(void *dst, int c, uint n)
{
     6cf:	55                   	push   %ebp
     6d0:	89 e5                	mov    %esp,%ebp
     6d2:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
     6d5:	8b 45 10             	mov    0x10(%ebp),%eax
     6d8:	89 44 24 08          	mov    %eax,0x8(%esp)
     6dc:	8b 45 0c             	mov    0xc(%ebp),%eax
     6df:	89 44 24 04          	mov    %eax,0x4(%esp)
     6e3:	8b 45 08             	mov    0x8(%ebp),%eax
     6e6:	89 04 24             	mov    %eax,(%esp)
     6e9:	e8 22 ff ff ff       	call   610 <stosb>
  return dst;
     6ee:	8b 45 08             	mov    0x8(%ebp),%eax
}
     6f1:	c9                   	leave  
     6f2:	c3                   	ret    

000006f3 <strchr>:

char*
strchr(const char *s, char c)
{
     6f3:	55                   	push   %ebp
     6f4:	89 e5                	mov    %esp,%ebp
     6f6:	83 ec 04             	sub    $0x4,%esp
     6f9:	8b 45 0c             	mov    0xc(%ebp),%eax
     6fc:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
     6ff:	eb 14                	jmp    715 <strchr+0x22>
    if(*s == c)
     701:	8b 45 08             	mov    0x8(%ebp),%eax
     704:	0f b6 00             	movzbl (%eax),%eax
     707:	3a 45 fc             	cmp    -0x4(%ebp),%al
     70a:	75 05                	jne    711 <strchr+0x1e>
      return (char*)s;
     70c:	8b 45 08             	mov    0x8(%ebp),%eax
     70f:	eb 13                	jmp    724 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
     711:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     715:	8b 45 08             	mov    0x8(%ebp),%eax
     718:	0f b6 00             	movzbl (%eax),%eax
     71b:	84 c0                	test   %al,%al
     71d:	75 e2                	jne    701 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
     71f:	b8 00 00 00 00       	mov    $0x0,%eax
}
     724:	c9                   	leave  
     725:	c3                   	ret    

00000726 <gets>:

char*
gets(char *buf, int max)
{
     726:	55                   	push   %ebp
     727:	89 e5                	mov    %esp,%ebp
     729:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     72c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     733:	eb 44                	jmp    779 <gets+0x53>
    cc = read(0, &c, 1);
     735:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
     73c:	00 
     73d:	8d 45 ef             	lea    -0x11(%ebp),%eax
     740:	89 44 24 04          	mov    %eax,0x4(%esp)
     744:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     74b:	e8 3c 01 00 00       	call   88c <read>
     750:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
     753:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     757:	7e 2d                	jle    786 <gets+0x60>
      break;
    buf[i++] = c;
     759:	8b 45 f4             	mov    -0xc(%ebp),%eax
     75c:	03 45 08             	add    0x8(%ebp),%eax
     75f:	0f b6 55 ef          	movzbl -0x11(%ebp),%edx
     763:	88 10                	mov    %dl,(%eax)
     765:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    if(c == '\n' || c == '\r')
     769:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     76d:	3c 0a                	cmp    $0xa,%al
     76f:	74 16                	je     787 <gets+0x61>
     771:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     775:	3c 0d                	cmp    $0xd,%al
     777:	74 0e                	je     787 <gets+0x61>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     779:	8b 45 f4             	mov    -0xc(%ebp),%eax
     77c:	83 c0 01             	add    $0x1,%eax
     77f:	3b 45 0c             	cmp    0xc(%ebp),%eax
     782:	7c b1                	jl     735 <gets+0xf>
     784:	eb 01                	jmp    787 <gets+0x61>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
     786:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
     787:	8b 45 f4             	mov    -0xc(%ebp),%eax
     78a:	03 45 08             	add    0x8(%ebp),%eax
     78d:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
     790:	8b 45 08             	mov    0x8(%ebp),%eax
}
     793:	c9                   	leave  
     794:	c3                   	ret    

00000795 <stat>:

int
stat(char *n, struct stat *st)
{
     795:	55                   	push   %ebp
     796:	89 e5                	mov    %esp,%ebp
     798:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     79b:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     7a2:	00 
     7a3:	8b 45 08             	mov    0x8(%ebp),%eax
     7a6:	89 04 24             	mov    %eax,(%esp)
     7a9:	e8 06 01 00 00       	call   8b4 <open>
     7ae:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
     7b1:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     7b5:	79 07                	jns    7be <stat+0x29>
    return -1;
     7b7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     7bc:	eb 23                	jmp    7e1 <stat+0x4c>
  r = fstat(fd, st);
     7be:	8b 45 0c             	mov    0xc(%ebp),%eax
     7c1:	89 44 24 04          	mov    %eax,0x4(%esp)
     7c5:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7c8:	89 04 24             	mov    %eax,(%esp)
     7cb:	e8 fc 00 00 00       	call   8cc <fstat>
     7d0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
     7d3:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7d6:	89 04 24             	mov    %eax,(%esp)
     7d9:	e8 be 00 00 00       	call   89c <close>
  return r;
     7de:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     7e1:	c9                   	leave  
     7e2:	c3                   	ret    

000007e3 <atoi>:

int
atoi(const char *s)
{
     7e3:	55                   	push   %ebp
     7e4:	89 e5                	mov    %esp,%ebp
     7e6:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
     7e9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
     7f0:	eb 23                	jmp    815 <atoi+0x32>
    n = n*10 + *s++ - '0';
     7f2:	8b 55 fc             	mov    -0x4(%ebp),%edx
     7f5:	89 d0                	mov    %edx,%eax
     7f7:	c1 e0 02             	shl    $0x2,%eax
     7fa:	01 d0                	add    %edx,%eax
     7fc:	01 c0                	add    %eax,%eax
     7fe:	89 c2                	mov    %eax,%edx
     800:	8b 45 08             	mov    0x8(%ebp),%eax
     803:	0f b6 00             	movzbl (%eax),%eax
     806:	0f be c0             	movsbl %al,%eax
     809:	01 d0                	add    %edx,%eax
     80b:	83 e8 30             	sub    $0x30,%eax
     80e:	89 45 fc             	mov    %eax,-0x4(%ebp)
     811:	83 45 08 01          	addl   $0x1,0x8(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     815:	8b 45 08             	mov    0x8(%ebp),%eax
     818:	0f b6 00             	movzbl (%eax),%eax
     81b:	3c 2f                	cmp    $0x2f,%al
     81d:	7e 0a                	jle    829 <atoi+0x46>
     81f:	8b 45 08             	mov    0x8(%ebp),%eax
     822:	0f b6 00             	movzbl (%eax),%eax
     825:	3c 39                	cmp    $0x39,%al
     827:	7e c9                	jle    7f2 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
     829:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     82c:	c9                   	leave  
     82d:	c3                   	ret    

0000082e <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
     82e:	55                   	push   %ebp
     82f:	89 e5                	mov    %esp,%ebp
     831:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
     834:	8b 45 08             	mov    0x8(%ebp),%eax
     837:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
     83a:	8b 45 0c             	mov    0xc(%ebp),%eax
     83d:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
     840:	eb 13                	jmp    855 <memmove+0x27>
    *dst++ = *src++;
     842:	8b 45 f8             	mov    -0x8(%ebp),%eax
     845:	0f b6 10             	movzbl (%eax),%edx
     848:	8b 45 fc             	mov    -0x4(%ebp),%eax
     84b:	88 10                	mov    %dl,(%eax)
     84d:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     851:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
     855:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     859:	0f 9f c0             	setg   %al
     85c:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
     860:	84 c0                	test   %al,%al
     862:	75 de                	jne    842 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
     864:	8b 45 08             	mov    0x8(%ebp),%eax
}
     867:	c9                   	leave  
     868:	c3                   	ret    
     869:	90                   	nop
     86a:	90                   	nop
     86b:	90                   	nop

0000086c <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     86c:	b8 01 00 00 00       	mov    $0x1,%eax
     871:	cd 40                	int    $0x40
     873:	c3                   	ret    

00000874 <exit>:
SYSCALL(exit)
     874:	b8 02 00 00 00       	mov    $0x2,%eax
     879:	cd 40                	int    $0x40
     87b:	c3                   	ret    

0000087c <wait>:
SYSCALL(wait)
     87c:	b8 03 00 00 00       	mov    $0x3,%eax
     881:	cd 40                	int    $0x40
     883:	c3                   	ret    

00000884 <pipe>:
SYSCALL(pipe)
     884:	b8 04 00 00 00       	mov    $0x4,%eax
     889:	cd 40                	int    $0x40
     88b:	c3                   	ret    

0000088c <read>:
SYSCALL(read)
     88c:	b8 05 00 00 00       	mov    $0x5,%eax
     891:	cd 40                	int    $0x40
     893:	c3                   	ret    

00000894 <write>:
SYSCALL(write)
     894:	b8 10 00 00 00       	mov    $0x10,%eax
     899:	cd 40                	int    $0x40
     89b:	c3                   	ret    

0000089c <close>:
SYSCALL(close)
     89c:	b8 15 00 00 00       	mov    $0x15,%eax
     8a1:	cd 40                	int    $0x40
     8a3:	c3                   	ret    

000008a4 <kill>:
SYSCALL(kill)
     8a4:	b8 06 00 00 00       	mov    $0x6,%eax
     8a9:	cd 40                	int    $0x40
     8ab:	c3                   	ret    

000008ac <exec>:
SYSCALL(exec)
     8ac:	b8 07 00 00 00       	mov    $0x7,%eax
     8b1:	cd 40                	int    $0x40
     8b3:	c3                   	ret    

000008b4 <open>:
SYSCALL(open)
     8b4:	b8 0f 00 00 00       	mov    $0xf,%eax
     8b9:	cd 40                	int    $0x40
     8bb:	c3                   	ret    

000008bc <mknod>:
SYSCALL(mknod)
     8bc:	b8 11 00 00 00       	mov    $0x11,%eax
     8c1:	cd 40                	int    $0x40
     8c3:	c3                   	ret    

000008c4 <unlink>:
SYSCALL(unlink)
     8c4:	b8 12 00 00 00       	mov    $0x12,%eax
     8c9:	cd 40                	int    $0x40
     8cb:	c3                   	ret    

000008cc <fstat>:
SYSCALL(fstat)
     8cc:	b8 08 00 00 00       	mov    $0x8,%eax
     8d1:	cd 40                	int    $0x40
     8d3:	c3                   	ret    

000008d4 <link>:
SYSCALL(link)
     8d4:	b8 13 00 00 00       	mov    $0x13,%eax
     8d9:	cd 40                	int    $0x40
     8db:	c3                   	ret    

000008dc <mkdir>:
SYSCALL(mkdir)
     8dc:	b8 14 00 00 00       	mov    $0x14,%eax
     8e1:	cd 40                	int    $0x40
     8e3:	c3                   	ret    

000008e4 <chdir>:
SYSCALL(chdir)
     8e4:	b8 09 00 00 00       	mov    $0x9,%eax
     8e9:	cd 40                	int    $0x40
     8eb:	c3                   	ret    

000008ec <dup>:
SYSCALL(dup)
     8ec:	b8 0a 00 00 00       	mov    $0xa,%eax
     8f1:	cd 40                	int    $0x40
     8f3:	c3                   	ret    

000008f4 <getpid>:
SYSCALL(getpid)
     8f4:	b8 0b 00 00 00       	mov    $0xb,%eax
     8f9:	cd 40                	int    $0x40
     8fb:	c3                   	ret    

000008fc <sbrk>:
SYSCALL(sbrk)
     8fc:	b8 0c 00 00 00       	mov    $0xc,%eax
     901:	cd 40                	int    $0x40
     903:	c3                   	ret    

00000904 <sleep>:
SYSCALL(sleep)
     904:	b8 0d 00 00 00       	mov    $0xd,%eax
     909:	cd 40                	int    $0x40
     90b:	c3                   	ret    

0000090c <uptime>:
SYSCALL(uptime)
     90c:	b8 0e 00 00 00       	mov    $0xe,%eax
     911:	cd 40                	int    $0x40
     913:	c3                   	ret    

00000914 <add_path>:
SYSCALL(add_path)
     914:	b8 16 00 00 00       	mov    $0x16,%eax
     919:	cd 40                	int    $0x40
     91b:	c3                   	ret    

0000091c <wait2>:
SYSCALL(wait2)
     91c:	b8 17 00 00 00       	mov    $0x17,%eax
     921:	cd 40                	int    $0x40
     923:	c3                   	ret    

00000924 <getquanta>:
SYSCALL(getquanta)
     924:	b8 18 00 00 00       	mov    $0x18,%eax
     929:	cd 40                	int    $0x40
     92b:	c3                   	ret    

0000092c <getqueue>:
SYSCALL(getqueue)
     92c:	b8 19 00 00 00       	mov    $0x19,%eax
     931:	cd 40                	int    $0x40
     933:	c3                   	ret    

00000934 <signal>:
SYSCALL(signal)
     934:	b8 1a 00 00 00       	mov    $0x1a,%eax
     939:	cd 40                	int    $0x40
     93b:	c3                   	ret    

0000093c <sigsend>:
SYSCALL(sigsend)
     93c:	b8 1b 00 00 00       	mov    $0x1b,%eax
     941:	cd 40                	int    $0x40
     943:	c3                   	ret    

00000944 <alarm>:
SYSCALL(alarm)
     944:	b8 1c 00 00 00       	mov    $0x1c,%eax
     949:	cd 40                	int    $0x40
     94b:	c3                   	ret    

0000094c <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
     94c:	55                   	push   %ebp
     94d:	89 e5                	mov    %esp,%ebp
     94f:	83 ec 28             	sub    $0x28,%esp
     952:	8b 45 0c             	mov    0xc(%ebp),%eax
     955:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
     958:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
     95f:	00 
     960:	8d 45 f4             	lea    -0xc(%ebp),%eax
     963:	89 44 24 04          	mov    %eax,0x4(%esp)
     967:	8b 45 08             	mov    0x8(%ebp),%eax
     96a:	89 04 24             	mov    %eax,(%esp)
     96d:	e8 22 ff ff ff       	call   894 <write>
}
     972:	c9                   	leave  
     973:	c3                   	ret    

00000974 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     974:	55                   	push   %ebp
     975:	89 e5                	mov    %esp,%ebp
     977:	83 ec 48             	sub    $0x48,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     97a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
     981:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     985:	74 17                	je     99e <printint+0x2a>
     987:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     98b:	79 11                	jns    99e <printint+0x2a>
    neg = 1;
     98d:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
     994:	8b 45 0c             	mov    0xc(%ebp),%eax
     997:	f7 d8                	neg    %eax
     999:	89 45 ec             	mov    %eax,-0x14(%ebp)
     99c:	eb 06                	jmp    9a4 <printint+0x30>
  } else {
    x = xx;
     99e:	8b 45 0c             	mov    0xc(%ebp),%eax
     9a1:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
     9a4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
     9ab:	8b 4d 10             	mov    0x10(%ebp),%ecx
     9ae:	8b 45 ec             	mov    -0x14(%ebp),%eax
     9b1:	ba 00 00 00 00       	mov    $0x0,%edx
     9b6:	f7 f1                	div    %ecx
     9b8:	89 d0                	mov    %edx,%eax
     9ba:	0f b6 90 1c 1b 00 00 	movzbl 0x1b1c(%eax),%edx
     9c1:	8d 45 dc             	lea    -0x24(%ebp),%eax
     9c4:	03 45 f4             	add    -0xc(%ebp),%eax
     9c7:	88 10                	mov    %dl,(%eax)
     9c9:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  }while((x /= base) != 0);
     9cd:	8b 55 10             	mov    0x10(%ebp),%edx
     9d0:	89 55 d4             	mov    %edx,-0x2c(%ebp)
     9d3:	8b 45 ec             	mov    -0x14(%ebp),%eax
     9d6:	ba 00 00 00 00       	mov    $0x0,%edx
     9db:	f7 75 d4             	divl   -0x2c(%ebp)
     9de:	89 45 ec             	mov    %eax,-0x14(%ebp)
     9e1:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     9e5:	75 c4                	jne    9ab <printint+0x37>
  if(neg)
     9e7:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     9eb:	74 2a                	je     a17 <printint+0xa3>
    buf[i++] = '-';
     9ed:	8d 45 dc             	lea    -0x24(%ebp),%eax
     9f0:	03 45 f4             	add    -0xc(%ebp),%eax
     9f3:	c6 00 2d             	movb   $0x2d,(%eax)
     9f6:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)

  while(--i >= 0)
     9fa:	eb 1b                	jmp    a17 <printint+0xa3>
    putc(fd, buf[i]);
     9fc:	8d 45 dc             	lea    -0x24(%ebp),%eax
     9ff:	03 45 f4             	add    -0xc(%ebp),%eax
     a02:	0f b6 00             	movzbl (%eax),%eax
     a05:	0f be c0             	movsbl %al,%eax
     a08:	89 44 24 04          	mov    %eax,0x4(%esp)
     a0c:	8b 45 08             	mov    0x8(%ebp),%eax
     a0f:	89 04 24             	mov    %eax,(%esp)
     a12:	e8 35 ff ff ff       	call   94c <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
     a17:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
     a1b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     a1f:	79 db                	jns    9fc <printint+0x88>
    putc(fd, buf[i]);
}
     a21:	c9                   	leave  
     a22:	c3                   	ret    

00000a23 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     a23:	55                   	push   %ebp
     a24:	89 e5                	mov    %esp,%ebp
     a26:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
     a29:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
     a30:	8d 45 0c             	lea    0xc(%ebp),%eax
     a33:	83 c0 04             	add    $0x4,%eax
     a36:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
     a39:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     a40:	e9 7d 01 00 00       	jmp    bc2 <printf+0x19f>
    c = fmt[i] & 0xff;
     a45:	8b 55 0c             	mov    0xc(%ebp),%edx
     a48:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a4b:	01 d0                	add    %edx,%eax
     a4d:	0f b6 00             	movzbl (%eax),%eax
     a50:	0f be c0             	movsbl %al,%eax
     a53:	25 ff 00 00 00       	and    $0xff,%eax
     a58:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
     a5b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     a5f:	75 2c                	jne    a8d <printf+0x6a>
      if(c == '%'){
     a61:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     a65:	75 0c                	jne    a73 <printf+0x50>
        state = '%';
     a67:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
     a6e:	e9 4b 01 00 00       	jmp    bbe <printf+0x19b>
      } else {
        putc(fd, c);
     a73:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     a76:	0f be c0             	movsbl %al,%eax
     a79:	89 44 24 04          	mov    %eax,0x4(%esp)
     a7d:	8b 45 08             	mov    0x8(%ebp),%eax
     a80:	89 04 24             	mov    %eax,(%esp)
     a83:	e8 c4 fe ff ff       	call   94c <putc>
     a88:	e9 31 01 00 00       	jmp    bbe <printf+0x19b>
      }
    } else if(state == '%'){
     a8d:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
     a91:	0f 85 27 01 00 00    	jne    bbe <printf+0x19b>
      if(c == 'd'){
     a97:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
     a9b:	75 2d                	jne    aca <printf+0xa7>
        printint(fd, *ap, 10, 1);
     a9d:	8b 45 e8             	mov    -0x18(%ebp),%eax
     aa0:	8b 00                	mov    (%eax),%eax
     aa2:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
     aa9:	00 
     aaa:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
     ab1:	00 
     ab2:	89 44 24 04          	mov    %eax,0x4(%esp)
     ab6:	8b 45 08             	mov    0x8(%ebp),%eax
     ab9:	89 04 24             	mov    %eax,(%esp)
     abc:	e8 b3 fe ff ff       	call   974 <printint>
        ap++;
     ac1:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     ac5:	e9 ed 00 00 00       	jmp    bb7 <printf+0x194>
      } else if(c == 'x' || c == 'p'){
     aca:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
     ace:	74 06                	je     ad6 <printf+0xb3>
     ad0:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
     ad4:	75 2d                	jne    b03 <printf+0xe0>
        printint(fd, *ap, 16, 0);
     ad6:	8b 45 e8             	mov    -0x18(%ebp),%eax
     ad9:	8b 00                	mov    (%eax),%eax
     adb:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
     ae2:	00 
     ae3:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
     aea:	00 
     aeb:	89 44 24 04          	mov    %eax,0x4(%esp)
     aef:	8b 45 08             	mov    0x8(%ebp),%eax
     af2:	89 04 24             	mov    %eax,(%esp)
     af5:	e8 7a fe ff ff       	call   974 <printint>
        ap++;
     afa:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     afe:	e9 b4 00 00 00       	jmp    bb7 <printf+0x194>
      } else if(c == 's'){
     b03:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
     b07:	75 46                	jne    b4f <printf+0x12c>
        s = (char*)*ap;
     b09:	8b 45 e8             	mov    -0x18(%ebp),%eax
     b0c:	8b 00                	mov    (%eax),%eax
     b0e:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
     b11:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
     b15:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     b19:	75 27                	jne    b42 <printf+0x11f>
          s = "(null)";
     b1b:	c7 45 f4 23 16 00 00 	movl   $0x1623,-0xc(%ebp)
        while(*s != 0){
     b22:	eb 1e                	jmp    b42 <printf+0x11f>
          putc(fd, *s);
     b24:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b27:	0f b6 00             	movzbl (%eax),%eax
     b2a:	0f be c0             	movsbl %al,%eax
     b2d:	89 44 24 04          	mov    %eax,0x4(%esp)
     b31:	8b 45 08             	mov    0x8(%ebp),%eax
     b34:	89 04 24             	mov    %eax,(%esp)
     b37:	e8 10 fe ff ff       	call   94c <putc>
          s++;
     b3c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     b40:	eb 01                	jmp    b43 <printf+0x120>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
     b42:	90                   	nop
     b43:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b46:	0f b6 00             	movzbl (%eax),%eax
     b49:	84 c0                	test   %al,%al
     b4b:	75 d7                	jne    b24 <printf+0x101>
     b4d:	eb 68                	jmp    bb7 <printf+0x194>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
     b4f:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
     b53:	75 1d                	jne    b72 <printf+0x14f>
        putc(fd, *ap);
     b55:	8b 45 e8             	mov    -0x18(%ebp),%eax
     b58:	8b 00                	mov    (%eax),%eax
     b5a:	0f be c0             	movsbl %al,%eax
     b5d:	89 44 24 04          	mov    %eax,0x4(%esp)
     b61:	8b 45 08             	mov    0x8(%ebp),%eax
     b64:	89 04 24             	mov    %eax,(%esp)
     b67:	e8 e0 fd ff ff       	call   94c <putc>
        ap++;
     b6c:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     b70:	eb 45                	jmp    bb7 <printf+0x194>
      } else if(c == '%'){
     b72:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     b76:	75 17                	jne    b8f <printf+0x16c>
        putc(fd, c);
     b78:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     b7b:	0f be c0             	movsbl %al,%eax
     b7e:	89 44 24 04          	mov    %eax,0x4(%esp)
     b82:	8b 45 08             	mov    0x8(%ebp),%eax
     b85:	89 04 24             	mov    %eax,(%esp)
     b88:	e8 bf fd ff ff       	call   94c <putc>
     b8d:	eb 28                	jmp    bb7 <printf+0x194>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     b8f:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
     b96:	00 
     b97:	8b 45 08             	mov    0x8(%ebp),%eax
     b9a:	89 04 24             	mov    %eax,(%esp)
     b9d:	e8 aa fd ff ff       	call   94c <putc>
        putc(fd, c);
     ba2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     ba5:	0f be c0             	movsbl %al,%eax
     ba8:	89 44 24 04          	mov    %eax,0x4(%esp)
     bac:	8b 45 08             	mov    0x8(%ebp),%eax
     baf:	89 04 24             	mov    %eax,(%esp)
     bb2:	e8 95 fd ff ff       	call   94c <putc>
      }
      state = 0;
     bb7:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     bbe:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     bc2:	8b 55 0c             	mov    0xc(%ebp),%edx
     bc5:	8b 45 f0             	mov    -0x10(%ebp),%eax
     bc8:	01 d0                	add    %edx,%eax
     bca:	0f b6 00             	movzbl (%eax),%eax
     bcd:	84 c0                	test   %al,%al
     bcf:	0f 85 70 fe ff ff    	jne    a45 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
     bd5:	c9                   	leave  
     bd6:	c3                   	ret    
     bd7:	90                   	nop

00000bd8 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     bd8:	55                   	push   %ebp
     bd9:	89 e5                	mov    %esp,%ebp
     bdb:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
     bde:	8b 45 08             	mov    0x8(%ebp),%eax
     be1:	83 e8 08             	sub    $0x8,%eax
     be4:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     be7:	a1 48 1b 00 00       	mov    0x1b48,%eax
     bec:	89 45 fc             	mov    %eax,-0x4(%ebp)
     bef:	eb 24                	jmp    c15 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     bf1:	8b 45 fc             	mov    -0x4(%ebp),%eax
     bf4:	8b 00                	mov    (%eax),%eax
     bf6:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     bf9:	77 12                	ja     c0d <free+0x35>
     bfb:	8b 45 f8             	mov    -0x8(%ebp),%eax
     bfe:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     c01:	77 24                	ja     c27 <free+0x4f>
     c03:	8b 45 fc             	mov    -0x4(%ebp),%eax
     c06:	8b 00                	mov    (%eax),%eax
     c08:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     c0b:	77 1a                	ja     c27 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     c0d:	8b 45 fc             	mov    -0x4(%ebp),%eax
     c10:	8b 00                	mov    (%eax),%eax
     c12:	89 45 fc             	mov    %eax,-0x4(%ebp)
     c15:	8b 45 f8             	mov    -0x8(%ebp),%eax
     c18:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     c1b:	76 d4                	jbe    bf1 <free+0x19>
     c1d:	8b 45 fc             	mov    -0x4(%ebp),%eax
     c20:	8b 00                	mov    (%eax),%eax
     c22:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     c25:	76 ca                	jbe    bf1 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
     c27:	8b 45 f8             	mov    -0x8(%ebp),%eax
     c2a:	8b 40 04             	mov    0x4(%eax),%eax
     c2d:	c1 e0 03             	shl    $0x3,%eax
     c30:	89 c2                	mov    %eax,%edx
     c32:	03 55 f8             	add    -0x8(%ebp),%edx
     c35:	8b 45 fc             	mov    -0x4(%ebp),%eax
     c38:	8b 00                	mov    (%eax),%eax
     c3a:	39 c2                	cmp    %eax,%edx
     c3c:	75 24                	jne    c62 <free+0x8a>
    bp->s.size += p->s.ptr->s.size;
     c3e:	8b 45 f8             	mov    -0x8(%ebp),%eax
     c41:	8b 50 04             	mov    0x4(%eax),%edx
     c44:	8b 45 fc             	mov    -0x4(%ebp),%eax
     c47:	8b 00                	mov    (%eax),%eax
     c49:	8b 40 04             	mov    0x4(%eax),%eax
     c4c:	01 c2                	add    %eax,%edx
     c4e:	8b 45 f8             	mov    -0x8(%ebp),%eax
     c51:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
     c54:	8b 45 fc             	mov    -0x4(%ebp),%eax
     c57:	8b 00                	mov    (%eax),%eax
     c59:	8b 10                	mov    (%eax),%edx
     c5b:	8b 45 f8             	mov    -0x8(%ebp),%eax
     c5e:	89 10                	mov    %edx,(%eax)
     c60:	eb 0a                	jmp    c6c <free+0x94>
  } else
    bp->s.ptr = p->s.ptr;
     c62:	8b 45 fc             	mov    -0x4(%ebp),%eax
     c65:	8b 10                	mov    (%eax),%edx
     c67:	8b 45 f8             	mov    -0x8(%ebp),%eax
     c6a:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
     c6c:	8b 45 fc             	mov    -0x4(%ebp),%eax
     c6f:	8b 40 04             	mov    0x4(%eax),%eax
     c72:	c1 e0 03             	shl    $0x3,%eax
     c75:	03 45 fc             	add    -0x4(%ebp),%eax
     c78:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     c7b:	75 20                	jne    c9d <free+0xc5>
    p->s.size += bp->s.size;
     c7d:	8b 45 fc             	mov    -0x4(%ebp),%eax
     c80:	8b 50 04             	mov    0x4(%eax),%edx
     c83:	8b 45 f8             	mov    -0x8(%ebp),%eax
     c86:	8b 40 04             	mov    0x4(%eax),%eax
     c89:	01 c2                	add    %eax,%edx
     c8b:	8b 45 fc             	mov    -0x4(%ebp),%eax
     c8e:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
     c91:	8b 45 f8             	mov    -0x8(%ebp),%eax
     c94:	8b 10                	mov    (%eax),%edx
     c96:	8b 45 fc             	mov    -0x4(%ebp),%eax
     c99:	89 10                	mov    %edx,(%eax)
     c9b:	eb 08                	jmp    ca5 <free+0xcd>
  } else
    p->s.ptr = bp;
     c9d:	8b 45 fc             	mov    -0x4(%ebp),%eax
     ca0:	8b 55 f8             	mov    -0x8(%ebp),%edx
     ca3:	89 10                	mov    %edx,(%eax)
  freep = p;
     ca5:	8b 45 fc             	mov    -0x4(%ebp),%eax
     ca8:	a3 48 1b 00 00       	mov    %eax,0x1b48
}
     cad:	c9                   	leave  
     cae:	c3                   	ret    

00000caf <morecore>:

static Header*
morecore(uint nu)
{
     caf:	55                   	push   %ebp
     cb0:	89 e5                	mov    %esp,%ebp
     cb2:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
     cb5:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
     cbc:	77 07                	ja     cc5 <morecore+0x16>
    nu = 4096;
     cbe:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
     cc5:	8b 45 08             	mov    0x8(%ebp),%eax
     cc8:	c1 e0 03             	shl    $0x3,%eax
     ccb:	89 04 24             	mov    %eax,(%esp)
     cce:	e8 29 fc ff ff       	call   8fc <sbrk>
     cd3:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
     cd6:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     cda:	75 07                	jne    ce3 <morecore+0x34>
    return 0;
     cdc:	b8 00 00 00 00       	mov    $0x0,%eax
     ce1:	eb 22                	jmp    d05 <morecore+0x56>
  hp = (Header*)p;
     ce3:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ce6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
     ce9:	8b 45 f0             	mov    -0x10(%ebp),%eax
     cec:	8b 55 08             	mov    0x8(%ebp),%edx
     cef:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
     cf2:	8b 45 f0             	mov    -0x10(%ebp),%eax
     cf5:	83 c0 08             	add    $0x8,%eax
     cf8:	89 04 24             	mov    %eax,(%esp)
     cfb:	e8 d8 fe ff ff       	call   bd8 <free>
  return freep;
     d00:	a1 48 1b 00 00       	mov    0x1b48,%eax
}
     d05:	c9                   	leave  
     d06:	c3                   	ret    

00000d07 <malloc>:

void*
malloc(uint nbytes)
{
     d07:	55                   	push   %ebp
     d08:	89 e5                	mov    %esp,%ebp
     d0a:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     d0d:	8b 45 08             	mov    0x8(%ebp),%eax
     d10:	83 c0 07             	add    $0x7,%eax
     d13:	c1 e8 03             	shr    $0x3,%eax
     d16:	83 c0 01             	add    $0x1,%eax
     d19:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
     d1c:	a1 48 1b 00 00       	mov    0x1b48,%eax
     d21:	89 45 f0             	mov    %eax,-0x10(%ebp)
     d24:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     d28:	75 23                	jne    d4d <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     d2a:	c7 45 f0 40 1b 00 00 	movl   $0x1b40,-0x10(%ebp)
     d31:	8b 45 f0             	mov    -0x10(%ebp),%eax
     d34:	a3 48 1b 00 00       	mov    %eax,0x1b48
     d39:	a1 48 1b 00 00       	mov    0x1b48,%eax
     d3e:	a3 40 1b 00 00       	mov    %eax,0x1b40
    base.s.size = 0;
     d43:	c7 05 44 1b 00 00 00 	movl   $0x0,0x1b44
     d4a:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     d4d:	8b 45 f0             	mov    -0x10(%ebp),%eax
     d50:	8b 00                	mov    (%eax),%eax
     d52:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
     d55:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d58:	8b 40 04             	mov    0x4(%eax),%eax
     d5b:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     d5e:	72 4d                	jb     dad <malloc+0xa6>
      if(p->s.size == nunits)
     d60:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d63:	8b 40 04             	mov    0x4(%eax),%eax
     d66:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     d69:	75 0c                	jne    d77 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
     d6b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d6e:	8b 10                	mov    (%eax),%edx
     d70:	8b 45 f0             	mov    -0x10(%ebp),%eax
     d73:	89 10                	mov    %edx,(%eax)
     d75:	eb 26                	jmp    d9d <malloc+0x96>
      else {
        p->s.size -= nunits;
     d77:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d7a:	8b 40 04             	mov    0x4(%eax),%eax
     d7d:	89 c2                	mov    %eax,%edx
     d7f:	2b 55 ec             	sub    -0x14(%ebp),%edx
     d82:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d85:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
     d88:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d8b:	8b 40 04             	mov    0x4(%eax),%eax
     d8e:	c1 e0 03             	shl    $0x3,%eax
     d91:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
     d94:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d97:	8b 55 ec             	mov    -0x14(%ebp),%edx
     d9a:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
     d9d:	8b 45 f0             	mov    -0x10(%ebp),%eax
     da0:	a3 48 1b 00 00       	mov    %eax,0x1b48
      return (void*)(p + 1);
     da5:	8b 45 f4             	mov    -0xc(%ebp),%eax
     da8:	83 c0 08             	add    $0x8,%eax
     dab:	eb 38                	jmp    de5 <malloc+0xde>
    }
    if(p == freep)
     dad:	a1 48 1b 00 00       	mov    0x1b48,%eax
     db2:	39 45 f4             	cmp    %eax,-0xc(%ebp)
     db5:	75 1b                	jne    dd2 <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
     db7:	8b 45 ec             	mov    -0x14(%ebp),%eax
     dba:	89 04 24             	mov    %eax,(%esp)
     dbd:	e8 ed fe ff ff       	call   caf <morecore>
     dc2:	89 45 f4             	mov    %eax,-0xc(%ebp)
     dc5:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     dc9:	75 07                	jne    dd2 <malloc+0xcb>
        return 0;
     dcb:	b8 00 00 00 00       	mov    $0x0,%eax
     dd0:	eb 13                	jmp    de5 <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     dd2:	8b 45 f4             	mov    -0xc(%ebp),%eax
     dd5:	89 45 f0             	mov    %eax,-0x10(%ebp)
     dd8:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ddb:	8b 00                	mov    (%eax),%eax
     ddd:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
     de0:	e9 70 ff ff ff       	jmp    d55 <malloc+0x4e>
}
     de5:	c9                   	leave  
     de6:	c3                   	ret    
     de7:	90                   	nop

00000de8 <print_stack>:
 * prints the stack of the currently running thread
 * DEBUGGING purposes
 */
void
print_stack()
{
     de8:	55                   	push   %ebp
     de9:	89 e5                	mov    %esp,%ebp
     deb:	83 ec 28             	sub    $0x28,%esp
  int *newesp = (int*)currentThread->esp;  
     dee:	a1 60 64 00 00       	mov    0x6460,%eax
     df3:	8b 40 04             	mov    0x4(%eax),%eax
     df6:	89 45 f4             	mov    %eax,-0xc(%ebp)
  printf(1,"stack for thread %d \n",currentThread->tid);
     df9:	a1 60 64 00 00       	mov    0x6460,%eax
     dfe:	8b 00                	mov    (%eax),%eax
     e00:	89 44 24 08          	mov    %eax,0x8(%esp)
     e04:	c7 44 24 04 2c 16 00 	movl   $0x162c,0x4(%esp)
     e0b:	00 
     e0c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     e13:	e8 0b fc ff ff       	call   a23 <printf>
  while((newesp < (int *)currentThread->ebp))
     e18:	eb 3c                	jmp    e56 <print_stack+0x6e>
  {
    printf(1,"add:%x ",newesp);
     e1a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e1d:	89 44 24 08          	mov    %eax,0x8(%esp)
     e21:	c7 44 24 04 42 16 00 	movl   $0x1642,0x4(%esp)
     e28:	00 
     e29:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     e30:	e8 ee fb ff ff       	call   a23 <printf>
      printf(1,"val:%x\n",*newesp);
     e35:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e38:	8b 00                	mov    (%eax),%eax
     e3a:	89 44 24 08          	mov    %eax,0x8(%esp)
     e3e:	c7 44 24 04 4a 16 00 	movl   $0x164a,0x4(%esp)
     e45:	00 
     e46:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     e4d:	e8 d1 fb ff ff       	call   a23 <printf>
    newesp++;
     e52:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
void
print_stack()
{
  int *newesp = (int*)currentThread->esp;  
  printf(1,"stack for thread %d \n",currentThread->tid);
  while((newesp < (int *)currentThread->ebp))
     e56:	a1 60 64 00 00       	mov    0x6460,%eax
     e5b:	8b 40 08             	mov    0x8(%eax),%eax
     e5e:	3b 45 f4             	cmp    -0xc(%ebp),%eax
     e61:	77 b7                	ja     e1a <print_stack+0x32>
    printf(1,"add:%x ",newesp);
      printf(1,"val:%x\n",*newesp);
    newesp++;
  }

}
     e63:	c9                   	leave  
     e64:	c3                   	ret    

00000e65 <getNextThread>:
 * returns the next thread in line to run
 * if none exists it returns -1
 */
int
getNextThread(int j)
{
     e65:	55                   	push   %ebp
     e66:	89 e5                	mov    %esp,%ebp
     e68:	83 ec 10             	sub    $0x10,%esp
  int i=j+1;
     e6b:	8b 45 08             	mov    0x8(%ebp),%eax
     e6e:	83 c0 01             	add    $0x1,%eax
     e71:	89 45 fc             	mov    %eax,-0x4(%ebp)
  if(i==MAX_THREAD)
     e74:	83 7d fc 40          	cmpl   $0x40,-0x4(%ebp)
     e78:	75 07                	jne    e81 <getNextThread+0x1c>
    i=0;
     e7a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  uthread_p t=&tTable.table[i];
     e81:	8b 45 fc             	mov    -0x4(%ebp),%eax
     e84:	69 c0 24 01 00 00    	imul   $0x124,%eax,%eax
     e8a:	05 60 1b 00 00       	add    $0x1b60,%eax
     e8f:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(i!=j)
     e92:	eb 3b                	jmp    ecf <getNextThread+0x6a>
  {
    if(t->state==T_RUNNABLE)
     e94:	8b 45 f8             	mov    -0x8(%ebp),%eax
     e97:	8b 40 10             	mov    0x10(%eax),%eax
     e9a:	83 f8 03             	cmp    $0x3,%eax
     e9d:	75 05                	jne    ea4 <getNextThread+0x3f>
      return i;
     e9f:	8b 45 fc             	mov    -0x4(%ebp),%eax
     ea2:	eb 38                	jmp    edc <getNextThread+0x77>
    i++;
     ea4:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    if(i==MAX_THREAD)
     ea8:	83 7d fc 40          	cmpl   $0x40,-0x4(%ebp)
     eac:	75 1a                	jne    ec8 <getNextThread+0x63>
    {
     i=0;
     eae:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
     t=&tTable.table[i];
     eb5:	8b 45 fc             	mov    -0x4(%ebp),%eax
     eb8:	69 c0 24 01 00 00    	imul   $0x124,%eax,%eax
     ebe:	05 60 1b 00 00       	add    $0x1b60,%eax
     ec3:	89 45 f8             	mov    %eax,-0x8(%ebp)
     ec6:	eb 07                	jmp    ecf <getNextThread+0x6a>
   }
   else
    t++;
     ec8:	81 45 f8 24 01 00 00 	addl   $0x124,-0x8(%ebp)
{
  int i=j+1;
  if(i==MAX_THREAD)
    i=0;
  uthread_p t=&tTable.table[i];
  while(i!=j)
     ecf:	8b 45 fc             	mov    -0x4(%ebp),%eax
     ed2:	3b 45 08             	cmp    0x8(%ebp),%eax
     ed5:	75 bd                	jne    e94 <getNextThread+0x2f>
   }
   else
    t++;

}
return -1;
     ed7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
     edc:	c9                   	leave  
     edd:	c3                   	ret    

00000ede <allocThread>:
 * allocates a spot for a new thread
 * if none exist it returns NULL
 */
static uthread_p
allocThread()
{
     ede:	55                   	push   %ebp
     edf:	89 e5                	mov    %esp,%ebp
     ee1:	83 ec 28             	sub    $0x28,%esp
  int i,j;
  uthread_p t;
  
  for (t=tTable.table,i=0 ; t < &tTable.table[MAX_THREAD]; t++,i++)
     ee4:	c7 45 ec 60 1b 00 00 	movl   $0x1b60,-0x14(%ebp)
     eeb:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     ef2:	eb 15                	jmp    f09 <allocThread+0x2b>
  {
    if(t->state==T_FREE)
     ef4:	8b 45 ec             	mov    -0x14(%ebp),%eax
     ef7:	8b 40 10             	mov    0x10(%eax),%eax
     efa:	85 c0                	test   %eax,%eax
     efc:	74 1e                	je     f1c <allocThread+0x3e>
allocThread()
{
  int i,j;
  uthread_p t;
  
  for (t=tTable.table,i=0 ; t < &tTable.table[MAX_THREAD]; t++,i++)
     efe:	81 45 ec 24 01 00 00 	addl   $0x124,-0x14(%ebp)
     f05:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     f09:	81 7d ec 60 64 00 00 	cmpl   $0x6460,-0x14(%ebp)
     f10:	72 e2                	jb     ef4 <allocThread+0x16>
  {
    if(t->state==T_FREE)
      goto found;
  }
  return 0;
     f12:	b8 00 00 00 00       	mov    $0x0,%eax
     f17:	e9 a3 00 00 00       	jmp    fbf <allocThread+0xe1>
  uthread_p t;
  
  for (t=tTable.table,i=0 ; t < &tTable.table[MAX_THREAD]; t++,i++)
  {
    if(t->state==T_FREE)
      goto found;
     f1c:	90                   	nop
  }
  return 0;
  
  found:
  //Init all fields
  t->tid=i;
     f1d:	8b 45 ec             	mov    -0x14(%ebp),%eax
     f20:	8b 55 f4             	mov    -0xc(%ebp),%edx
     f23:	89 10                	mov    %edx,(%eax)
  if(i==0) //main thread init
     f25:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     f29:	75 1c                	jne    f47 <allocThread+0x69>
  {
    STORE_ESP(t->esp);
     f2b:	89 e2                	mov    %esp,%edx
     f2d:	8b 45 ec             	mov    -0x14(%ebp),%eax
     f30:	89 50 04             	mov    %edx,0x4(%eax)
    STORE_EBP(t->ebp);
     f33:	89 ea                	mov    %ebp,%edx
     f35:	8b 45 ec             	mov    -0x14(%ebp),%eax
     f38:	89 50 08             	mov    %edx,0x8(%eax)
    t->firstTime=0;
     f3b:	8b 45 ec             	mov    -0x14(%ebp),%eax
     f3e:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
     f45:	eb 3b                	jmp    f82 <allocThread+0xa4>
  }
  else
  {
    t->stack=(char*)malloc(STACK_SIZE);
     f47:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
     f4e:	e8 b4 fd ff ff       	call   d07 <malloc>
     f53:	8b 55 ec             	mov    -0x14(%ebp),%edx
     f56:	89 42 0c             	mov    %eax,0xc(%edx)
    t->ebp=(int)t->stack+STACK_SIZE;
     f59:	8b 45 ec             	mov    -0x14(%ebp),%eax
     f5c:	8b 40 0c             	mov    0xc(%eax),%eax
     f5f:	05 00 10 00 00       	add    $0x1000,%eax
     f64:	89 c2                	mov    %eax,%edx
     f66:	8b 45 ec             	mov    -0x14(%ebp),%eax
     f69:	89 50 08             	mov    %edx,0x8(%eax)
    t->esp=t->ebp;
     f6c:	8b 45 ec             	mov    -0x14(%ebp),%eax
     f6f:	8b 50 08             	mov    0x8(%eax),%edx
     f72:	8b 45 ec             	mov    -0x14(%ebp),%eax
     f75:	89 50 04             	mov    %edx,0x4(%eax)
    t->firstTime=1;
     f78:	8b 45 ec             	mov    -0x14(%ebp),%eax
     f7b:	c7 40 14 01 00 00 00 	movl   $0x1,0x14(%eax)
  }
  
  t->waitingFor=-1;
     f82:	8b 45 ec             	mov    -0x14(%ebp),%eax
     f85:	c7 80 20 01 00 00 ff 	movl   $0xffffffff,0x120(%eax)
     f8c:	ff ff ff 
  
  for(j=0;j<MAX_THREAD;j++)
     f8f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     f96:	eb 14                	jmp    fac <allocThread+0xce>
  {
    t->waitedOn[j]=-1;
     f98:	8b 45 ec             	mov    -0x14(%ebp),%eax
     f9b:	8b 55 f0             	mov    -0x10(%ebp),%edx
     f9e:	83 c2 08             	add    $0x8,%edx
     fa1:	c7 04 90 ff ff ff ff 	movl   $0xffffffff,(%eax,%edx,4)
    t->firstTime=1;
  }
  
  t->waitingFor=-1;
  
  for(j=0;j<MAX_THREAD;j++)
     fa8:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     fac:	83 7d f0 3f          	cmpl   $0x3f,-0x10(%ebp)
     fb0:	7e e6                	jle    f98 <allocThread+0xba>
  {
    t->waitedOn[j]=-1;
  }
   
  t->state=T_UNINIT;
     fb2:	8b 45 ec             	mov    -0x14(%ebp),%eax
     fb5:	c7 40 10 01 00 00 00 	movl   $0x1,0x10(%eax)
  
    
  return t;
     fbc:	8b 45 ec             	mov    -0x14(%ebp),%eax
}
     fbf:	c9                   	leave  
     fc0:	c3                   	ret    

00000fc1 <uthread_init>:
/*
 * initializes all the uthread structures
 */
int
uthread_init()
{   
     fc1:	55                   	push   %ebp
     fc2:	89 e5                	mov    %esp,%ebp
     fc4:	83 ec 28             	sub    $0x28,%esp
  //Initialize table
  int i;
  
  for(i=0;i<MAX_THREAD;i++)
     fc7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     fce:	eb 18                	jmp    fe8 <uthread_init+0x27>
  {
    tTable.table[i].state=T_FREE;
     fd0:	8b 45 f4             	mov    -0xc(%ebp),%eax
     fd3:	69 c0 24 01 00 00    	imul   $0x124,%eax,%eax
     fd9:	05 70 1b 00 00       	add    $0x1b70,%eax
     fde:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
uthread_init()
{   
  //Initialize table
  int i;
  
  for(i=0;i<MAX_THREAD;i++)
     fe4:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     fe8:	83 7d f4 3f          	cmpl   $0x3f,-0xc(%ebp)
     fec:	7e e2                	jle    fd0 <uthread_init+0xf>
  {
    tTable.table[i].state=T_FREE;
  }
  
 //allocate the main thread
  currentThread = allocThread();
     fee:	e8 eb fe ff ff       	call   ede <allocThread>
     ff3:	a3 60 64 00 00       	mov    %eax,0x6460
  if(currentThread==0)
     ff8:	a1 60 64 00 00       	mov    0x6460,%eax
     ffd:	85 c0                	test   %eax,%eax
     fff:	75 07                	jne    1008 <uthread_init+0x47>
    return -1;
    1001:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    1006:	eb 6b                	jmp    1073 <uthread_init+0xb2>
  
  currentThread->state = T_RUNNING;
    1008:	a1 60 64 00 00       	mov    0x6460,%eax
    100d:	c7 40 10 02 00 00 00 	movl   $0x2,0x10(%eax)
  //register uthread_yield as signal handler for alarm
  if(signal(SIGALRM,uthread_yield)<0)
    1014:	c7 44 24 04 fb 12 00 	movl   $0x12fb,0x4(%esp)
    101b:	00 
    101c:	c7 04 24 0e 00 00 00 	movl   $0xe,(%esp)
    1023:	e8 0c f9 ff ff       	call   934 <signal>
    1028:	85 c0                	test   %eax,%eax
    102a:	79 19                	jns    1045 <uthread_init+0x84>
  {
    printf(1,"Cant register the alarm signal");
    102c:	c7 44 24 04 54 16 00 	movl   $0x1654,0x4(%esp)
    1033:	00 
    1034:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    103b:	e8 e3 f9 ff ff       	call   a23 <printf>
    exit();
    1040:	e8 2f f8 ff ff       	call   874 <exit>
  }
  //set new alarm clock
  if(alarm(THREAD_QUANTA)<0)
    1045:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
    104c:	e8 f3 f8 ff ff       	call   944 <alarm>
    1051:	85 c0                	test   %eax,%eax
    1053:	79 19                	jns    106e <uthread_init+0xad>
  {
    printf(1,"Cant activate alarm system call");
    1055:	c7 44 24 04 74 16 00 	movl   $0x1674,0x4(%esp)
    105c:	00 
    105d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1064:	e8 ba f9 ff ff       	call   a23 <printf>
    exit();
    1069:	e8 06 f8 ff ff       	call   874 <exit>
  }
  return 0;
    106e:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1073:	c9                   	leave  
    1074:	c3                   	ret    

00001075 <wrap_func>:

void
wrap_func()
{
    1075:	55                   	push   %ebp
    1076:	89 e5                	mov    %esp,%ebp
    1078:	83 ec 18             	sub    $0x18,%esp
  currentThread->func(currentThread->arguments);
    107b:	a1 60 64 00 00       	mov    0x6460,%eax
    1080:	8b 50 18             	mov    0x18(%eax),%edx
    1083:	a1 60 64 00 00       	mov    0x6460,%eax
    1088:	8b 40 1c             	mov    0x1c(%eax),%eax
    108b:	89 04 24             	mov    %eax,(%esp)
    108e:	ff d2                	call   *%edx
  uthread_exit();
    1090:	e8 6c 00 00 00       	call   1101 <uthread_exit>
}
    1095:	c9                   	leave  
    1096:	c3                   	ret    

00001097 <uthread_create>:
 * to that function
 * if none can be created it returns -1;
 */
int  
uthread_create(void (*start_func)(void *), void* arg)
{
    1097:	55                   	push   %ebp
    1098:	89 e5                	mov    %esp,%ebp
    109a:	53                   	push   %ebx
    109b:	83 ec 14             	sub    $0x14,%esp
  uint local_esp;
  uthread_p t = allocThread();
    109e:	e8 3b fe ff ff       	call   ede <allocThread>
    10a3:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(t==0)
    10a6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    10aa:	75 07                	jne    10b3 <uthread_create+0x1c>
    return -1;
    10ac:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    10b1:	eb 48                	jmp    10fb <uthread_create+0x64>

  t->func=start_func;
    10b3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    10b6:	8b 55 08             	mov    0x8(%ebp),%edx
    10b9:	89 50 18             	mov    %edx,0x18(%eax)
  t->arguments=arg;
    10bc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    10bf:	8b 55 0c             	mov    0xc(%ebp),%edx
    10c2:	89 50 1c             	mov    %edx,0x1c(%eax)
  
  //push starting func and return value on the right stack
  STORE_ESP(local_esp);
    10c5:	89 e3                	mov    %esp,%ebx
    10c7:	89 5d f0             	mov    %ebx,-0x10(%ebp)
  LOAD_ESP(t->esp);
    10ca:	8b 45 f4             	mov    -0xc(%ebp),%eax
    10cd:	8b 40 04             	mov    0x4(%eax),%eax
    10d0:	89 c4                	mov    %eax,%esp
  PUSH_FUNC(t->esp,t->ebp,wrap_func);
    10d2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    10d5:	8b 50 08             	mov    0x8(%eax),%edx
    10d8:	b8 75 10 00 00       	mov    $0x1075,%eax
    10dd:	50                   	push   %eax
    10de:	52                   	push   %edx
    10df:	89 e2                	mov    %esp,%edx
    10e1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    10e4:	89 50 04             	mov    %edx,0x4(%eax)
  LOAD_ESP(local_esp);
    10e7:	8b 45 f0             	mov    -0x10(%ebp),%eax
    10ea:	89 c4                	mov    %eax,%esp
  
  t->state = T_RUNNABLE;
    10ec:	8b 45 f4             	mov    -0xc(%ebp),%eax
    10ef:	c7 40 10 03 00 00 00 	movl   $0x3,0x10(%eax)
  
  return t->tid;
    10f6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    10f9:	8b 00                	mov    (%eax),%eax
}
    10fb:	83 c4 14             	add    $0x14,%esp
    10fe:	5b                   	pop    %ebx
    10ff:	5d                   	pop    %ebp
    1100:	c3                   	ret    

00001101 <uthread_exit>:
 * closes the running thread, wakes up all
 * the threads waiting for this one (if they require waking up)
 */
void 
uthread_exit()
{
    1101:	55                   	push   %ebp
    1102:	89 e5                	mov    %esp,%ebp
    1104:	83 ec 28             	sub    $0x28,%esp
  alarm(0); //clear the alarm so as not to disturb running of function
    1107:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    110e:	e8 31 f8 ff ff       	call   944 <alarm>
  int new,i;
  //wakeup all threads waiting for this one
  for(i=0;i<MAX_THREAD;i++)
    1113:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    111a:	eb 51                	jmp    116d <uthread_exit+0x6c>
  {
   if(currentThread->waitedOn[i]==1)
    111c:	a1 60 64 00 00       	mov    0x6460,%eax
    1121:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1124:	83 c2 08             	add    $0x8,%edx
    1127:	8b 04 90             	mov    (%eax,%edx,4),%eax
    112a:	83 f8 01             	cmp    $0x1,%eax
    112d:	75 3a                	jne    1169 <uthread_exit+0x68>
   {
     tTable.table[i].waitingFor=-1; //release thread i from waiting
    112f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1132:	69 c0 24 01 00 00    	imul   $0x124,%eax,%eax
    1138:	05 80 1c 00 00       	add    $0x1c80,%eax
    113d:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)
     currentThread->waitedOn[i]=0; //not necessary maybe   
    1143:	a1 60 64 00 00       	mov    0x6460,%eax
    1148:	8b 55 f4             	mov    -0xc(%ebp),%edx
    114b:	83 c2 08             	add    $0x8,%edx
    114e:	c7 04 90 00 00 00 00 	movl   $0x0,(%eax,%edx,4)
     tTable.table[i].state=T_RUNNABLE;
    1155:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1158:	69 c0 24 01 00 00    	imul   $0x124,%eax,%eax
    115e:	05 70 1b 00 00       	add    $0x1b70,%eax
    1163:	c7 00 03 00 00 00    	movl   $0x3,(%eax)
uthread_exit()
{
  alarm(0); //clear the alarm so as not to disturb running of function
  int new,i;
  //wakeup all threads waiting for this one
  for(i=0;i<MAX_THREAD;i++)
    1169:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    116d:	83 7d f4 3f          	cmpl   $0x3f,-0xc(%ebp)
    1171:	7e a9                	jle    111c <uthread_exit+0x1b>
     tTable.table[i].state=T_RUNNABLE;
   }
  }
  
  //pick next thread
  new=getNextThread(currentThread->tid);
    1173:	a1 60 64 00 00       	mov    0x6460,%eax
    1178:	8b 00                	mov    (%eax),%eax
    117a:	89 04 24             	mov    %eax,(%esp)
    117d:	e8 e3 fc ff ff       	call   e65 <getNextThread>
    1182:	89 45 f0             	mov    %eax,-0x10(%ebp)
  
  //release all resources and zero all fields
  if(currentThread->tid!=0)
    1185:	a1 60 64 00 00       	mov    0x6460,%eax
    118a:	8b 00                	mov    (%eax),%eax
    118c:	85 c0                	test   %eax,%eax
    118e:	74 10                	je     11a0 <uthread_exit+0x9f>
    free(currentThread->stack);
    1190:	a1 60 64 00 00       	mov    0x6460,%eax
    1195:	8b 40 0c             	mov    0xc(%eax),%eax
    1198:	89 04 24             	mov    %eax,(%esp)
    119b:	e8 38 fa ff ff       	call   bd8 <free>
  currentThread->tid=-1;
    11a0:	a1 60 64 00 00       	mov    0x6460,%eax
    11a5:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)
  currentThread->esp=-1;
    11ab:	a1 60 64 00 00       	mov    0x6460,%eax
    11b0:	c7 40 04 ff ff ff ff 	movl   $0xffffffff,0x4(%eax)
  currentThread->ebp=-1;
    11b7:	a1 60 64 00 00       	mov    0x6460,%eax
    11bc:	c7 40 08 ff ff ff ff 	movl   $0xffffffff,0x8(%eax)
  currentThread->func=0;
    11c3:	a1 60 64 00 00       	mov    0x6460,%eax
    11c8:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)
  currentThread->arguments=0;
    11cf:	a1 60 64 00 00       	mov    0x6460,%eax
    11d4:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
  currentThread->stack=0;
    11db:	a1 60 64 00 00       	mov    0x6460,%eax
    11e0:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
  currentThread->firstTime=1;
    11e7:	a1 60 64 00 00       	mov    0x6460,%eax
    11ec:	c7 40 14 01 00 00 00 	movl   $0x1,0x14(%eax)
  currentThread->state=T_FREE;
    11f3:	a1 60 64 00 00       	mov    0x6460,%eax
    11f8:	c7 40 10 00 00 00 00 	movl   $0x0,0x10(%eax)
  
  //load new thread
  if(new>=0)
    11ff:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1203:	78 7a                	js     127f <uthread_exit+0x17e>
  {
    currentThread=&tTable.table[new];
    1205:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1208:	69 c0 24 01 00 00    	imul   $0x124,%eax,%eax
    120e:	05 60 1b 00 00       	add    $0x1b60,%eax
    1213:	a3 60 64 00 00       	mov    %eax,0x6460
    currentThread->state=T_RUNNING;
    1218:	a1 60 64 00 00       	mov    0x6460,%eax
    121d:	c7 40 10 02 00 00 00 	movl   $0x2,0x10(%eax)
    LOAD_ESP(currentThread->esp);
    1224:	a1 60 64 00 00       	mov    0x6460,%eax
    1229:	8b 40 04             	mov    0x4(%eax),%eax
    122c:	89 c4                	mov    %eax,%esp
    LOAD_EBP(currentThread->ebp);
    122e:	a1 60 64 00 00       	mov    0x6460,%eax
    1233:	8b 40 08             	mov    0x8(%eax),%eax
    1236:	89 c5                	mov    %eax,%ebp
    
    //set new alarm clock
    if(alarm(THREAD_QUANTA)<0)
    1238:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
    123f:	e8 00 f7 ff ff       	call   944 <alarm>
    1244:	85 c0                	test   %eax,%eax
    1246:	79 19                	jns    1261 <uthread_exit+0x160>
    {
      printf(1,"Cant activate alarm system call");
    1248:	c7 44 24 04 74 16 00 	movl   $0x1674,0x4(%esp)
    124f:	00 
    1250:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1257:	e8 c7 f7 ff ff       	call   a23 <printf>
      exit();
    125c:	e8 13 f6 ff ff       	call   874 <exit>
    }
    
    if(currentThread->firstTime==1)
    1261:	a1 60 64 00 00       	mov    0x6460,%eax
    1266:	8b 40 14             	mov    0x14(%eax),%eax
    1269:	83 f8 01             	cmp    $0x1,%eax
    126c:	75 10                	jne    127e <uthread_exit+0x17d>
    {
      currentThread->firstTime=0;
    126e:	a1 60 64 00 00       	mov    0x6460,%eax
    1273:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
      POP_AND_RET();
    127a:	5d                   	pop    %ebp
    127b:	c3                   	ret    
    127c:	eb 01                	jmp    127f <uthread_exit+0x17e>
    }
    else
    {  
    POP_ALL_REGISTERS();
    127e:	61                   	popa   
    }
  }
}
    127f:	c9                   	leave  
    1280:	c3                   	ret    

00001281 <uthread_join>:
/*
 * causes this thread to wait for the finish of another thread
 */
int
uthread_join(int tid)
{
    1281:	55                   	push   %ebp
    1282:	89 e5                	mov    %esp,%ebp
    1284:	83 ec 18             	sub    $0x18,%esp
  if((&tTable.table[tid])->state==T_FREE)
    1287:	8b 45 08             	mov    0x8(%ebp),%eax
    128a:	69 c0 24 01 00 00    	imul   $0x124,%eax,%eax
    1290:	05 60 1b 00 00       	add    $0x1b60,%eax
    1295:	8b 40 10             	mov    0x10(%eax),%eax
    1298:	85 c0                	test   %eax,%eax
    129a:	75 07                	jne    12a3 <uthread_join+0x22>
    return -1;
    129c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    12a1:	eb 56                	jmp    12f9 <uthread_join+0x78>
  else
  {
    alarm(0); //clear the alarm so as not to disturb running of function
    12a3:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    12aa:	e8 95 f6 ff ff       	call   944 <alarm>
    currentThread->waitingFor=tid;
    12af:	a1 60 64 00 00       	mov    0x6460,%eax
    12b4:	8b 55 08             	mov    0x8(%ebp),%edx
    12b7:	89 90 20 01 00 00    	mov    %edx,0x120(%eax)
    tTable.table[tid].waitedOn[currentThread->tid]=1;
    12bd:	a1 60 64 00 00       	mov    0x6460,%eax
    12c2:	8b 08                	mov    (%eax),%ecx
    12c4:	8b 55 08             	mov    0x8(%ebp),%edx
    12c7:	89 d0                	mov    %edx,%eax
    12c9:	c1 e0 03             	shl    $0x3,%eax
    12cc:	01 d0                	add    %edx,%eax
    12ce:	c1 e0 03             	shl    $0x3,%eax
    12d1:	01 d0                	add    %edx,%eax
    12d3:	01 c8                	add    %ecx,%eax
    12d5:	83 c0 08             	add    $0x8,%eax
    12d8:	c7 04 85 60 1b 00 00 	movl   $0x1,0x1b60(,%eax,4)
    12df:	01 00 00 00 
    currentThread->state=T_SLEEPING;
    12e3:	a1 60 64 00 00       	mov    0x6460,%eax
    12e8:	c7 40 10 04 00 00 00 	movl   $0x4,0x10(%eax)
    uthread_yield();
    12ef:	e8 07 00 00 00       	call   12fb <uthread_yield>
    return 1;
    12f4:	b8 01 00 00 00       	mov    $0x1,%eax
  }
}
    12f9:	c9                   	leave  
    12fa:	c3                   	ret    

000012fb <uthread_yield>:
/*
 * yields the run-time of the current thread to another thread
 */
void 
uthread_yield()
{
    12fb:	55                   	push   %ebp
    12fc:	89 e5                	mov    %esp,%ebp
    12fe:	83 ec 28             	sub    $0x28,%esp
  alarm(0); //clear the alarm so as not to disturb running of function
    1301:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1308:	e8 37 f6 ff ff       	call   944 <alarm>
  int new=getNextThread(currentThread->tid);
    130d:	a1 60 64 00 00       	mov    0x6460,%eax
    1312:	8b 00                	mov    (%eax),%eax
    1314:	89 04 24             	mov    %eax,(%esp)
    1317:	e8 49 fb ff ff       	call   e65 <getNextThread>
    131c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(new==-1)
    131f:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
    1323:	75 2d                	jne    1352 <uthread_yield+0x57>
  {
    if(alarm(THREAD_QUANTA)<0)
    1325:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
    132c:	e8 13 f6 ff ff       	call   944 <alarm>
    1331:	85 c0                	test   %eax,%eax
    1333:	0f 89 c1 00 00 00    	jns    13fa <uthread_yield+0xff>
    {
      printf(1,"Cant activate alarm system call\n");
    1339:	c7 44 24 04 94 16 00 	movl   $0x1694,0x4(%esp)
    1340:	00 
    1341:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1348:	e8 d6 f6 ff ff       	call   a23 <printf>
      exit();
    134d:	e8 22 f5 ff ff       	call   874 <exit>
    } 
  }
  else
  {
    //store all leaving thread registers and pointers
    PUSH_ALL_REGISTERS();
    1352:	60                   	pusha  
    STORE_ESP(currentThread->esp);
    1353:	a1 60 64 00 00       	mov    0x6460,%eax
    1358:	89 e2                	mov    %esp,%edx
    135a:	89 50 04             	mov    %edx,0x4(%eax)
    STORE_EBP(currentThread->ebp);
    135d:	a1 60 64 00 00       	mov    0x6460,%eax
    1362:	89 ea                	mov    %ebp,%edx
    1364:	89 50 08             	mov    %edx,0x8(%eax)
    
    //change thread state
    if(currentThread->state==T_RUNNING) //might be sleeping from join operation
    1367:	a1 60 64 00 00       	mov    0x6460,%eax
    136c:	8b 40 10             	mov    0x10(%eax),%eax
    136f:	83 f8 02             	cmp    $0x2,%eax
    1372:	75 0c                	jne    1380 <uthread_yield+0x85>
      currentThread->state=T_RUNNABLE;
    1374:	a1 60 64 00 00       	mov    0x6460,%eax
    1379:	c7 40 10 03 00 00 00 	movl   $0x3,0x10(%eax)

    currentThread=&tTable.table[new];
    1380:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1383:	69 c0 24 01 00 00    	imul   $0x124,%eax,%eax
    1389:	05 60 1b 00 00       	add    $0x1b60,%eax
    138e:	a3 60 64 00 00       	mov    %eax,0x6460

    //load all new thread registers and pointers
    LOAD_ESP(currentThread->esp);
    1393:	a1 60 64 00 00       	mov    0x6460,%eax
    1398:	8b 40 04             	mov    0x4(%eax),%eax
    139b:	89 c4                	mov    %eax,%esp
    LOAD_EBP(currentThread->ebp);
    139d:	a1 60 64 00 00       	mov    0x6460,%eax
    13a2:	8b 40 08             	mov    0x8(%eax),%eax
    13a5:	89 c5                	mov    %eax,%ebp
    //set new alram clock
    if(alarm(THREAD_QUANTA)<0)
    13a7:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
    13ae:	e8 91 f5 ff ff       	call   944 <alarm>
    13b3:	85 c0                	test   %eax,%eax
    13b5:	79 19                	jns    13d0 <uthread_yield+0xd5>
    {
      printf(1,"Cant activate alarm system call\n");
    13b7:	c7 44 24 04 94 16 00 	movl   $0x1694,0x4(%esp)
    13be:	00 
    13bf:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    13c6:	e8 58 f6 ff ff       	call   a23 <printf>
      exit();
    13cb:	e8 a4 f4 ff ff       	call   874 <exit>
    }  
    currentThread->state=T_RUNNING;
    13d0:	a1 60 64 00 00       	mov    0x6460,%eax
    13d5:	c7 40 10 02 00 00 00 	movl   $0x2,0x10(%eax)
    
    if(currentThread->firstTime==1)
    13dc:	a1 60 64 00 00       	mov    0x6460,%eax
    13e1:	8b 40 14             	mov    0x14(%eax),%eax
    13e4:	83 f8 01             	cmp    $0x1,%eax
    13e7:	75 10                	jne    13f9 <uthread_yield+0xfe>
    {
    currentThread->firstTime=0;
    13e9:	a1 60 64 00 00       	mov    0x6460,%eax
    13ee:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
    POP_AND_RET();
    13f5:	5d                   	pop    %ebp
    13f6:	c3                   	ret    
    13f7:	eb 01                	jmp    13fa <uthread_yield+0xff>
    }
    else
    {
      POP_ALL_REGISTERS();
    13f9:	61                   	popa   
    }
  }
}
    13fa:	c9                   	leave  
    13fb:	c3                   	ret    

000013fc <uthread_self>:

int
uthread_self(void)
{
    13fc:	55                   	push   %ebp
    13fd:	89 e5                	mov    %esp,%ebp
  return currentThread->tid;
    13ff:	a1 60 64 00 00       	mov    0x6460,%eax
    1404:	8b 00                	mov    (%eax),%eax
    1406:	5d                   	pop    %ebp
    1407:	c3                   	ret    

00001408 <xchg>:
#include "fs.h"
#include "uthread.h"

static inline uint
xchg(volatile uint *addr, uint newval)
{
    1408:	55                   	push   %ebp
    1409:	89 e5                	mov    %esp,%ebp
    140b:	53                   	push   %ebx
    140c:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
               "+m" (*addr), "=a" (result) :
    140f:	8b 55 08             	mov    0x8(%ebp),%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
    1412:	8b 45 0c             	mov    0xc(%ebp),%eax
               "+m" (*addr), "=a" (result) :
    1415:	8b 4d 08             	mov    0x8(%ebp),%ecx
xchg(volatile uint *addr, uint newval)
{
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
    1418:	89 c3                	mov    %eax,%ebx
    141a:	89 d8                	mov    %ebx,%eax
    141c:	f0 87 02             	lock xchg %eax,(%edx)
    141f:	89 c3                	mov    %eax,%ebx
    1421:	89 5d f8             	mov    %ebx,-0x8(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
    1424:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
    1427:	83 c4 10             	add    $0x10,%esp
    142a:	5b                   	pop    %ebx
    142b:	5d                   	pop    %ebp
    142c:	c3                   	ret    

0000142d <binary_semaphore_init>:
semaphore->taken=0;
}*/

void
binary_semaphore_init(struct binary_semaphore* semaphore, int value)
{
    142d:	55                   	push   %ebp
    142e:	89 e5                	mov    %esp,%ebp
    1430:	83 ec 08             	sub    $0x8,%esp
  semaphore->init=0;
    1433:	8b 45 08             	mov    0x8(%ebp),%eax
    1436:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
  
  if(value!=0)
    143d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1441:	74 0c                	je     144f <binary_semaphore_init+0x22>
    semaphore->thread=-1;
    1443:	8b 45 08             	mov    0x8(%ebp),%eax
    1446:	c7 40 04 ff ff ff ff 	movl   $0xffffffff,0x4(%eax)
    144d:	eb 0b                	jmp    145a <binary_semaphore_init+0x2d>
  else 
    semaphore->thread = uthread_self();
    144f:	e8 a8 ff ff ff       	call   13fc <uthread_self>
    1454:	8b 55 08             	mov    0x8(%ebp),%edx
    1457:	89 42 04             	mov    %eax,0x4(%edx)
  
  semaphore->locked = value;
    145a:	8b 55 0c             	mov    0xc(%ebp),%edx
    145d:	8b 45 08             	mov    0x8(%ebp),%eax
    1460:	89 10                	mov    %edx,(%eax)
 // semaphore->taken=0;
  semaphore->init=1;
    1462:	8b 45 08             	mov    0x8(%ebp),%eax
    1465:	c7 40 08 01 00 00 00 	movl   $0x1,0x8(%eax)
  
}
    146c:	c9                   	leave  
    146d:	c3                   	ret    

0000146e <binary_semaphore_down>:

void 
binary_semaphore_down(struct binary_semaphore* semaphore)
{
    146e:	55                   	push   %ebp
    146f:	89 e5                	mov    %esp,%ebp
    1471:	83 ec 28             	sub    $0x28,%esp
  //semaphore_acquire(semaphore);
  if(semaphore->init==0)
    1474:	8b 45 08             	mov    0x8(%ebp),%eax
    1477:	8b 40 08             	mov    0x8(%eax),%eax
    147a:	85 c0                	test   %eax,%eax
    147c:	75 20                	jne    149e <binary_semaphore_down+0x30>
  {
   printf(1,"(down)semaphore uninitialized yet (thread %d)\n",semaphore->thread);
    147e:	8b 45 08             	mov    0x8(%ebp),%eax
    1481:	8b 40 04             	mov    0x4(%eax),%eax
    1484:	89 44 24 08          	mov    %eax,0x8(%esp)
    1488:	c7 44 24 04 b8 16 00 	movl   $0x16b8,0x4(%esp)
    148f:	00 
    1490:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1497:	e8 87 f5 ff ff       	call   a23 <printf>
    return;
    149c:	eb 3a                	jmp    14d8 <binary_semaphore_down+0x6a>
  }
  
  
  int i= uthread_self();
    149e:	e8 59 ff ff ff       	call   13fc <uthread_self>
    14a3:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(semaphore->thread!=i)
    14a6:	8b 45 08             	mov    0x8(%ebp),%eax
    14a9:	8b 40 04             	mov    0x4(%eax),%eax
    14ac:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    14af:	74 27                	je     14d8 <binary_semaphore_down+0x6a>
  {
    while(xchg(&semaphore->locked, 0) == 0) //means the semaphore is taken allready
    14b1:	eb 05                	jmp    14b8 <binary_semaphore_down+0x4a>
    {
      uthread_yield();
    14b3:	e8 43 fe ff ff       	call   12fb <uthread_yield>
  
  
  int i= uthread_self();
  if(semaphore->thread!=i)
  {
    while(xchg(&semaphore->locked, 0) == 0) //means the semaphore is taken allready
    14b8:	8b 45 08             	mov    0x8(%ebp),%eax
    14bb:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    14c2:	00 
    14c3:	89 04 24             	mov    %eax,(%esp)
    14c6:	e8 3d ff ff ff       	call   1408 <xchg>
    14cb:	85 c0                	test   %eax,%eax
    14cd:	74 e4                	je     14b3 <binary_semaphore_down+0x45>
    {
      uthread_yield();
    }
    semaphore->thread = i;
    14cf:	8b 45 08             	mov    0x8(%ebp),%eax
    14d2:	8b 55 f4             	mov    -0xc(%ebp),%edx
    14d5:	89 50 04             	mov    %edx,0x4(%eax)
  }
  //semaphore_release(semaphore);
}
    14d8:	c9                   	leave  
    14d9:	c3                   	ret    

000014da <binary_semaphore_up>:

void 
binary_semaphore_up(struct binary_semaphore* semaphore)
{
    14da:	55                   	push   %ebp
    14db:	89 e5                	mov    %esp,%ebp
    14dd:	83 ec 28             	sub    $0x28,%esp
  //semaphore_acquire(semaphore);
    if(semaphore->init==0)
    14e0:	8b 45 08             	mov    0x8(%ebp),%eax
    14e3:	8b 40 08             	mov    0x8(%eax),%eax
    14e6:	85 c0                	test   %eax,%eax
    14e8:	75 20                	jne    150a <binary_semaphore_up+0x30>
    {
    printf(1,"(up)semaphore uninitialized yet (thread %d)\n",semaphore->thread);
    14ea:	8b 45 08             	mov    0x8(%ebp),%eax
    14ed:	8b 40 04             	mov    0x4(%eax),%eax
    14f0:	89 44 24 08          	mov    %eax,0x8(%esp)
    14f4:	c7 44 24 04 e8 16 00 	movl   $0x16e8,0x4(%esp)
    14fb:	00 
    14fc:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1503:	e8 1b f5 ff ff       	call   a23 <printf>
    return;
    1508:	eb 2f                	jmp    1539 <binary_semaphore_up+0x5f>
    }
  
  int i= uthread_self();
    150a:	e8 ed fe ff ff       	call   13fc <uthread_self>
    150f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if( semaphore->locked == 0 && semaphore->thread == i)
    1512:	8b 45 08             	mov    0x8(%ebp),%eax
    1515:	8b 00                	mov    (%eax),%eax
    1517:	85 c0                	test   %eax,%eax
    1519:	75 1e                	jne    1539 <binary_semaphore_up+0x5f>
    151b:	8b 45 08             	mov    0x8(%ebp),%eax
    151e:	8b 40 04             	mov    0x4(%eax),%eax
    1521:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1524:	75 13                	jne    1539 <binary_semaphore_up+0x5f>
  {
      semaphore->thread = -1;
    1526:	8b 45 08             	mov    0x8(%ebp),%eax
    1529:	c7 40 04 ff ff ff ff 	movl   $0xffffffff,0x4(%eax)
      semaphore->locked = 1;
    1530:	8b 45 08             	mov    0x8(%ebp),%eax
    1533:	c7 00 01 00 00 00    	movl   $0x1,(%eax)

  }
//semaphore_release(semaphore);
    1539:	c9                   	leave  
    153a:	c3                   	ret    
