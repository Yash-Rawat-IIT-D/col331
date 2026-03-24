
_init:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "user.h"
#include "fcntl.h"

int
main(void)
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	push   -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	51                   	push   %ecx
   e:	83 ec 14             	sub    $0x14,%esp
  int fd = open("console", O_RDWR);
  11:	83 ec 08             	sub    $0x8,%esp
  14:	6a 02                	push   $0x2
  16:	68 7c 03 00 00       	push   $0x37c
  1b:	e8 dc 00 00 00       	call   fc <open>
  20:	83 c4 10             	add    $0x10,%esp
  23:	89 45 ec             	mov    %eax,-0x14(%ebp)
  printf(fd, "Hello COL%d from init.c!\n", 331);
  26:	83 ec 04             	sub    $0x4,%esp
  29:	68 4b 01 00 00       	push   $0x14b
  2e:	68 84 03 00 00       	push   $0x384
  33:	ff 75 ec             	push   -0x14(%ebp)
  36:	e8 ad 01 00 00       	call   1e8 <printf>
  3b:	83 c4 10             	add    $0x10,%esp
  
  int ret = get_sched_policy();
  3e:	e8 c9 00 00 00       	call   10c <get_sched_policy>
  43:	89 45 e8             	mov    %eax,-0x18(%ebp)
  printf(fd, "Set sched policy of process to : %d \n", ret);
  46:	83 ec 04             	sub    $0x4,%esp
  49:	ff 75 e8             	push   -0x18(%ebp)
  4c:	68 a0 03 00 00       	push   $0x3a0
  51:	ff 75 ec             	push   -0x14(%ebp)
  54:	e8 8f 01 00 00       	call   1e8 <printf>
  59:	83 c4 10             	add    $0x10,%esp

  for (int j = 0; j < 15; j++) {
  5c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  63:	eb 30                	jmp    95 <main+0x95>
    int i = 0;
  65:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    while(i < 100000000) {i++;}   
  6c:	eb 04                	jmp    72 <main+0x72>
  6e:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
  72:	81 7d f0 ff e0 f5 05 	cmpl   $0x5f5e0ff,-0x10(%ebp)
  79:	7e f3                	jle    6e <main+0x6e>
    printf(fd, "Task done by process with sched policy %d ... \n", ret);
  7b:	83 ec 04             	sub    $0x4,%esp
  7e:	ff 75 e8             	push   -0x18(%ebp)
  81:	68 c8 03 00 00       	push   $0x3c8
  86:	ff 75 ec             	push   -0x14(%ebp)
  89:	e8 5a 01 00 00       	call   1e8 <printf>
  8e:	83 c4 10             	add    $0x10,%esp
  for (int j = 0; j < 15; j++) {
  91:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  95:	83 7d f4 0e          	cmpl   $0xe,-0xc(%ebp)
  99:	7e ca                	jle    65 <main+0x65>
  }

  if (ret == 0) {
  9b:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  9f:	75 15                	jne    b6 <main+0xb6>
    printf(fd, "Hurray Foreground Process Exited\n");
  a1:	83 ec 08             	sub    $0x8,%esp
  a4:	68 f8 03 00 00       	push   $0x3f8
  a9:	ff 75 ec             	push   -0x14(%ebp)
  ac:	e8 37 01 00 00       	call   1e8 <printf>
  b1:	83 c4 10             	add    $0x10,%esp
  b4:	eb 13                	jmp    c9 <main+0xc9>
  } else {
    printf(fd, "Hurray Background Process Exited\n");
  b6:	83 ec 08             	sub    $0x8,%esp
  b9:	68 1c 04 00 00       	push   $0x41c
  be:	ff 75 ec             	push   -0x14(%ebp)
  c1:	e8 22 01 00 00       	call   1e8 <printf>
  c6:	83 c4 10             	add    $0x10,%esp
  }

  close(fd);
  c9:	83 ec 0c             	sub    $0xc,%esp
  cc:	ff 75 ec             	push   -0x14(%ebp)
  cf:	e8 18 00 00 00       	call   ec <close>
  d4:	83 c4 10             	add    $0x10,%esp
  d7:	b8 00 00 00 00       	mov    $0x0,%eax

  dc:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  df:	c9                   	leave
  e0:	8d 61 fc             	lea    -0x4(%ecx),%esp
  e3:	c3                   	ret

000000e4 <write>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(write)
  e4:	b8 02 00 00 00       	mov    $0x2,%eax
  e9:	cd 40                	int    $0x40
  eb:	c3                   	ret

000000ec <close>:
SYSCALL(close)
  ec:	b8 03 00 00 00       	mov    $0x3,%eax
  f1:	cd 40                	int    $0x40
  f3:	c3                   	ret

000000f4 <exec>:
SYSCALL(exec)
  f4:	b8 04 00 00 00       	mov    $0x4,%eax
  f9:	cd 40                	int    $0x40
  fb:	c3                   	ret

000000fc <open>:
SYSCALL(open)
  fc:	b8 01 00 00 00       	mov    $0x1,%eax
 101:	cd 40                	int    $0x40
 103:	c3                   	ret

00000104 <set_sched_policy>:
SYSCALL(set_sched_policy)
 104:	b8 05 00 00 00       	mov    $0x5,%eax
 109:	cd 40                	int    $0x40
 10b:	c3                   	ret

0000010c <get_sched_policy>:
SYSCALL(get_sched_policy)
 10c:	b8 06 00 00 00       	mov    $0x6,%eax
 111:	cd 40                	int    $0x40
 113:	c3                   	ret

00000114 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 114:	55                   	push   %ebp
 115:	89 e5                	mov    %esp,%ebp
 117:	83 ec 18             	sub    $0x18,%esp
 11a:	8b 45 0c             	mov    0xc(%ebp),%eax
 11d:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 120:	83 ec 04             	sub    $0x4,%esp
 123:	6a 01                	push   $0x1
 125:	8d 45 f4             	lea    -0xc(%ebp),%eax
 128:	50                   	push   %eax
 129:	ff 75 08             	push   0x8(%ebp)
 12c:	e8 b3 ff ff ff       	call   e4 <write>
 131:	83 c4 10             	add    $0x10,%esp
}
 134:	90                   	nop
 135:	c9                   	leave
 136:	c3                   	ret

00000137 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 137:	55                   	push   %ebp
 138:	89 e5                	mov    %esp,%ebp
 13a:	83 ec 28             	sub    $0x28,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 13d:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 144:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 148:	74 17                	je     161 <printint+0x2a>
 14a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 14e:	79 11                	jns    161 <printint+0x2a>
    neg = 1;
 150:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 157:	8b 45 0c             	mov    0xc(%ebp),%eax
 15a:	f7 d8                	neg    %eax
 15c:	89 45 ec             	mov    %eax,-0x14(%ebp)
 15f:	eb 06                	jmp    167 <printint+0x30>
  } else {
    x = xx;
 161:	8b 45 0c             	mov    0xc(%ebp),%eax
 164:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 167:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 16e:	8b 4d 10             	mov    0x10(%ebp),%ecx
 171:	8b 45 ec             	mov    -0x14(%ebp),%eax
 174:	ba 00 00 00 00       	mov    $0x0,%edx
 179:	f7 f1                	div    %ecx
 17b:	89 d1                	mov    %edx,%ecx
 17d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 180:	8d 50 01             	lea    0x1(%eax),%edx
 183:	89 55 f4             	mov    %edx,-0xc(%ebp)
 186:	0f b6 91 ec 04 00 00 	movzbl 0x4ec(%ecx),%edx
 18d:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
  }while((x /= base) != 0);
 191:	8b 4d 10             	mov    0x10(%ebp),%ecx
 194:	8b 45 ec             	mov    -0x14(%ebp),%eax
 197:	ba 00 00 00 00       	mov    $0x0,%edx
 19c:	f7 f1                	div    %ecx
 19e:	89 45 ec             	mov    %eax,-0x14(%ebp)
 1a1:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 1a5:	75 c7                	jne    16e <printint+0x37>
  if(neg)
 1a7:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 1ab:	74 2d                	je     1da <printint+0xa3>
    buf[i++] = '-';
 1ad:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1b0:	8d 50 01             	lea    0x1(%eax),%edx
 1b3:	89 55 f4             	mov    %edx,-0xc(%ebp)
 1b6:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 1bb:	eb 1d                	jmp    1da <printint+0xa3>
    putc(fd, buf[i]);
 1bd:	8d 55 dc             	lea    -0x24(%ebp),%edx
 1c0:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1c3:	01 d0                	add    %edx,%eax
 1c5:	0f b6 00             	movzbl (%eax),%eax
 1c8:	0f be c0             	movsbl %al,%eax
 1cb:	83 ec 08             	sub    $0x8,%esp
 1ce:	50                   	push   %eax
 1cf:	ff 75 08             	push   0x8(%ebp)
 1d2:	e8 3d ff ff ff       	call   114 <putc>
 1d7:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
 1da:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 1de:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 1e2:	79 d9                	jns    1bd <printint+0x86>
}
 1e4:	90                   	nop
 1e5:	90                   	nop
 1e6:	c9                   	leave
 1e7:	c3                   	ret

000001e8 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 1e8:	55                   	push   %ebp
 1e9:	89 e5                	mov    %esp,%ebp
 1eb:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 1ee:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 1f5:	8d 45 0c             	lea    0xc(%ebp),%eax
 1f8:	83 c0 04             	add    $0x4,%eax
 1fb:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 1fe:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 205:	e9 59 01 00 00       	jmp    363 <printf+0x17b>
    c = fmt[i] & 0xff;
 20a:	8b 55 0c             	mov    0xc(%ebp),%edx
 20d:	8b 45 f0             	mov    -0x10(%ebp),%eax
 210:	01 d0                	add    %edx,%eax
 212:	0f b6 00             	movzbl (%eax),%eax
 215:	0f be c0             	movsbl %al,%eax
 218:	25 ff 00 00 00       	and    $0xff,%eax
 21d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 220:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 224:	75 2c                	jne    252 <printf+0x6a>
      if(c == '%'){
 226:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 22a:	75 0c                	jne    238 <printf+0x50>
        state = '%';
 22c:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 233:	e9 27 01 00 00       	jmp    35f <printf+0x177>
      } else {
        putc(fd, c);
 238:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 23b:	0f be c0             	movsbl %al,%eax
 23e:	83 ec 08             	sub    $0x8,%esp
 241:	50                   	push   %eax
 242:	ff 75 08             	push   0x8(%ebp)
 245:	e8 ca fe ff ff       	call   114 <putc>
 24a:	83 c4 10             	add    $0x10,%esp
 24d:	e9 0d 01 00 00       	jmp    35f <printf+0x177>
      }
    } else if(state == '%'){
 252:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 256:	0f 85 03 01 00 00    	jne    35f <printf+0x177>
      if(c == 'd'){
 25c:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 260:	75 1e                	jne    280 <printf+0x98>
        printint(fd, *ap, 10, 1);
 262:	8b 45 e8             	mov    -0x18(%ebp),%eax
 265:	8b 00                	mov    (%eax),%eax
 267:	6a 01                	push   $0x1
 269:	6a 0a                	push   $0xa
 26b:	50                   	push   %eax
 26c:	ff 75 08             	push   0x8(%ebp)
 26f:	e8 c3 fe ff ff       	call   137 <printint>
 274:	83 c4 10             	add    $0x10,%esp
        ap++;
 277:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 27b:	e9 d8 00 00 00       	jmp    358 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
 280:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 284:	74 06                	je     28c <printf+0xa4>
 286:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 28a:	75 1e                	jne    2aa <printf+0xc2>
        printint(fd, *ap, 16, 0);
 28c:	8b 45 e8             	mov    -0x18(%ebp),%eax
 28f:	8b 00                	mov    (%eax),%eax
 291:	6a 00                	push   $0x0
 293:	6a 10                	push   $0x10
 295:	50                   	push   %eax
 296:	ff 75 08             	push   0x8(%ebp)
 299:	e8 99 fe ff ff       	call   137 <printint>
 29e:	83 c4 10             	add    $0x10,%esp
        ap++;
 2a1:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 2a5:	e9 ae 00 00 00       	jmp    358 <printf+0x170>
      } else if(c == 's'){
 2aa:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 2ae:	75 43                	jne    2f3 <printf+0x10b>
        s = (char*)*ap;
 2b0:	8b 45 e8             	mov    -0x18(%ebp),%eax
 2b3:	8b 00                	mov    (%eax),%eax
 2b5:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 2b8:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 2bc:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 2c0:	75 25                	jne    2e7 <printf+0xff>
          s = "(null)";
 2c2:	c7 45 f4 3e 04 00 00 	movl   $0x43e,-0xc(%ebp)
        while(*s != 0){
 2c9:	eb 1c                	jmp    2e7 <printf+0xff>
          putc(fd, *s);
 2cb:	8b 45 f4             	mov    -0xc(%ebp),%eax
 2ce:	0f b6 00             	movzbl (%eax),%eax
 2d1:	0f be c0             	movsbl %al,%eax
 2d4:	83 ec 08             	sub    $0x8,%esp
 2d7:	50                   	push   %eax
 2d8:	ff 75 08             	push   0x8(%ebp)
 2db:	e8 34 fe ff ff       	call   114 <putc>
 2e0:	83 c4 10             	add    $0x10,%esp
          s++;
 2e3:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        while(*s != 0){
 2e7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 2ea:	0f b6 00             	movzbl (%eax),%eax
 2ed:	84 c0                	test   %al,%al
 2ef:	75 da                	jne    2cb <printf+0xe3>
 2f1:	eb 65                	jmp    358 <printf+0x170>
        }
      } else if(c == 'c'){
 2f3:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 2f7:	75 1d                	jne    316 <printf+0x12e>
        putc(fd, *ap);
 2f9:	8b 45 e8             	mov    -0x18(%ebp),%eax
 2fc:	8b 00                	mov    (%eax),%eax
 2fe:	0f be c0             	movsbl %al,%eax
 301:	83 ec 08             	sub    $0x8,%esp
 304:	50                   	push   %eax
 305:	ff 75 08             	push   0x8(%ebp)
 308:	e8 07 fe ff ff       	call   114 <putc>
 30d:	83 c4 10             	add    $0x10,%esp
        ap++;
 310:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 314:	eb 42                	jmp    358 <printf+0x170>
      } else if(c == '%'){
 316:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 31a:	75 17                	jne    333 <printf+0x14b>
        putc(fd, c);
 31c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 31f:	0f be c0             	movsbl %al,%eax
 322:	83 ec 08             	sub    $0x8,%esp
 325:	50                   	push   %eax
 326:	ff 75 08             	push   0x8(%ebp)
 329:	e8 e6 fd ff ff       	call   114 <putc>
 32e:	83 c4 10             	add    $0x10,%esp
 331:	eb 25                	jmp    358 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 333:	83 ec 08             	sub    $0x8,%esp
 336:	6a 25                	push   $0x25
 338:	ff 75 08             	push   0x8(%ebp)
 33b:	e8 d4 fd ff ff       	call   114 <putc>
 340:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 343:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 346:	0f be c0             	movsbl %al,%eax
 349:	83 ec 08             	sub    $0x8,%esp
 34c:	50                   	push   %eax
 34d:	ff 75 08             	push   0x8(%ebp)
 350:	e8 bf fd ff ff       	call   114 <putc>
 355:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 358:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(i = 0; fmt[i]; i++){
 35f:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 363:	8b 55 0c             	mov    0xc(%ebp),%edx
 366:	8b 45 f0             	mov    -0x10(%ebp),%eax
 369:	01 d0                	add    %edx,%eax
 36b:	0f b6 00             	movzbl (%eax),%eax
 36e:	84 c0                	test   %al,%al
 370:	0f 85 94 fe ff ff    	jne    20a <printf+0x22>
    }
  }
}
 376:	90                   	nop
 377:	90                   	nop
 378:	c9                   	leave
 379:	c3                   	ret
