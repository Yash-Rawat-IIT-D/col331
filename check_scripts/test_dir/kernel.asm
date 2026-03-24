
kernel:     file format elf32-i386


Disassembly of section .text:

00100000 <multiboot_header>:
  100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
  100006:	00 00                	add    %al,(%eax)
  100008:	fe 4f 52             	decb   0x52(%edi)
  10000b:	e4                   	.byte 0xe4

0010000c <_start>:

# Entering xv6 on boot processor, with paging off.
.globl entry
entry:
  # Set up the stack pointer.
  movl $(stack + KSTACKSIZE), %esp
  10000c:	bc f0 fa 10 00       	mov    $0x10faf0,%esp

  # Jump to main(), and switch to executing at
  # high addresses. The indirect call is needed because
  # the assembler produces a PC-relative instruction
  # for a direct jump.
  mov $main, %eax
  100011:	b8 79 08 10 00       	mov    $0x100879,%eax
  jmp *%eax
  100016:	ff e0                	jmp    *%eax

00100018 <outw>:
    x = -xx;
  else
    x = xx;

  i = 0;
  do{
  100018:	55                   	push   %ebp
  100019:	89 e5                	mov    %esp,%ebp
  10001b:	83 ec 08             	sub    $0x8,%esp
  10001e:	8b 55 08             	mov    0x8(%ebp),%edx
  100021:	8b 45 0c             	mov    0xc(%ebp),%eax
  100024:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
  100028:	66 89 45 f8          	mov    %ax,-0x8(%ebp)
    buf[i++] = digits[x % base];
  10002c:	0f b7 45 f8          	movzwl -0x8(%ebp),%eax
  100030:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
  100034:	66 ef                	out    %ax,(%dx)
  }while((x /= base) != 0);
  100036:	90                   	nop
  100037:	c9                   	leave
  100038:	c3                   	ret

00100039 <cli>:
{
  int i;
  uint pcs[10];

  cli();
  cprintf("lapicid %d: panic: ", lapicid());
  100039:	55                   	push   %ebp
  10003a:	89 e5                	mov    %esp,%ebp
  cprintf(s);
  10003c:	fa                   	cli
  cprintf("\n");
  10003d:	90                   	nop
  10003e:	5d                   	pop    %ebp
  10003f:	c3                   	ret

00100040 <printint>:
{
  100040:	55                   	push   %ebp
  100041:	89 e5                	mov    %esp,%ebp
  100043:	83 ec 28             	sub    $0x28,%esp
  if(sign && (sign = xx < 0))
  100046:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  10004a:	74 1c                	je     100068 <printint+0x28>
  10004c:	8b 45 08             	mov    0x8(%ebp),%eax
  10004f:	c1 e8 1f             	shr    $0x1f,%eax
  100052:	0f b6 c0             	movzbl %al,%eax
  100055:	89 45 10             	mov    %eax,0x10(%ebp)
  100058:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  10005c:	74 0a                	je     100068 <printint+0x28>
    x = -xx;
  10005e:	8b 45 08             	mov    0x8(%ebp),%eax
  100061:	f7 d8                	neg    %eax
  100063:	89 45 f0             	mov    %eax,-0x10(%ebp)
  100066:	eb 06                	jmp    10006e <printint+0x2e>
    x = xx;
  100068:	8b 45 08             	mov    0x8(%ebp),%eax
  10006b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  i = 0;
  10006e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    buf[i++] = digits[x % base];
  100075:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  100078:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10007b:	ba 00 00 00 00       	mov    $0x0,%edx
  100080:	f7 f1                	div    %ecx
  100082:	89 d1                	mov    %edx,%ecx
  100084:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100087:	8d 50 01             	lea    0x1(%eax),%edx
  10008a:	89 55 f4             	mov    %edx,-0xc(%ebp)
  10008d:	0f b6 91 00 60 10 00 	movzbl 0x106000(%ecx),%edx
  100094:	88 54 05 e0          	mov    %dl,-0x20(%ebp,%eax,1)
  }while((x /= base) != 0);
  100098:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  10009b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10009e:	ba 00 00 00 00       	mov    $0x0,%edx
  1000a3:	f7 f1                	div    %ecx
  1000a5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  1000a8:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  1000ac:	75 c7                	jne    100075 <printint+0x35>
  if(sign)
  1000ae:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  1000b2:	74 2a                	je     1000de <printint+0x9e>
    buf[i++] = '-';
  1000b4:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1000b7:	8d 50 01             	lea    0x1(%eax),%edx
  1000ba:	89 55 f4             	mov    %edx,-0xc(%ebp)
  1000bd:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%ebp,%eax,1)
  while(--i >= 0)
  1000c2:	eb 1a                	jmp    1000de <printint+0x9e>
    consputc(buf[i]);
  1000c4:	8d 55 e0             	lea    -0x20(%ebp),%edx
  1000c7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1000ca:	01 d0                	add    %edx,%eax
  1000cc:	0f b6 00             	movzbl (%eax),%eax
  1000cf:	0f be c0             	movsbl %al,%eax
  1000d2:	83 ec 0c             	sub    $0xc,%esp
  1000d5:	50                   	push   %eax
  1000d6:	e8 60 02 00 00       	call   10033b <consputc>
  1000db:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
  1000de:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
  1000e2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  1000e6:	79 dc                	jns    1000c4 <printint+0x84>
}
  1000e8:	90                   	nop
  1000e9:	90                   	nop
  1000ea:	c9                   	leave
  1000eb:	c3                   	ret

001000ec <cprintf>:
{
  1000ec:	55                   	push   %ebp
  1000ed:	89 e5                	mov    %esp,%ebp
  1000ef:	83 ec 18             	sub    $0x18,%esp
  if (fmt == 0)
  1000f2:	8b 45 08             	mov    0x8(%ebp),%eax
  1000f5:	85 c0                	test   %eax,%eax
  1000f7:	0f 84 63 01 00 00    	je     100260 <cprintf+0x174>
  argp = (uint*)(void*)(&fmt + 1);
  1000fd:	8d 45 0c             	lea    0xc(%ebp),%eax
  100100:	89 45 f0             	mov    %eax,-0x10(%ebp)
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
  100103:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  10010a:	e9 2f 01 00 00       	jmp    10023e <cprintf+0x152>
    if(c != '%'){
  10010f:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
  100113:	74 13                	je     100128 <cprintf+0x3c>
      consputc(c);
  100115:	83 ec 0c             	sub    $0xc,%esp
  100118:	ff 75 e8             	push   -0x18(%ebp)
  10011b:	e8 1b 02 00 00       	call   10033b <consputc>
  100120:	83 c4 10             	add    $0x10,%esp
      continue;
  100123:	e9 12 01 00 00       	jmp    10023a <cprintf+0x14e>
    c = fmt[++i] & 0xff;
  100128:	8b 55 08             	mov    0x8(%ebp),%edx
  10012b:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  10012f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100132:	01 d0                	add    %edx,%eax
  100134:	0f b6 00             	movzbl (%eax),%eax
  100137:	0f be c0             	movsbl %al,%eax
  10013a:	25 ff 00 00 00       	and    $0xff,%eax
  10013f:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(c == 0)
  100142:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  100146:	0f 84 17 01 00 00    	je     100263 <cprintf+0x177>
    switch(c){
  10014c:	83 7d e8 78          	cmpl   $0x78,-0x18(%ebp)
  100150:	74 5e                	je     1001b0 <cprintf+0xc4>
  100152:	83 7d e8 78          	cmpl   $0x78,-0x18(%ebp)
  100156:	0f 8f c2 00 00 00    	jg     10021e <cprintf+0x132>
  10015c:	83 7d e8 73          	cmpl   $0x73,-0x18(%ebp)
  100160:	74 6b                	je     1001cd <cprintf+0xe1>
  100162:	83 7d e8 73          	cmpl   $0x73,-0x18(%ebp)
  100166:	0f 8f b2 00 00 00    	jg     10021e <cprintf+0x132>
  10016c:	83 7d e8 70          	cmpl   $0x70,-0x18(%ebp)
  100170:	74 3e                	je     1001b0 <cprintf+0xc4>
  100172:	83 7d e8 70          	cmpl   $0x70,-0x18(%ebp)
  100176:	0f 8f a2 00 00 00    	jg     10021e <cprintf+0x132>
  10017c:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
  100180:	0f 84 89 00 00 00    	je     10020f <cprintf+0x123>
  100186:	83 7d e8 64          	cmpl   $0x64,-0x18(%ebp)
  10018a:	0f 85 8e 00 00 00    	jne    10021e <cprintf+0x132>
      printint(*argp++, 10, 1);
  100190:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100193:	8d 50 04             	lea    0x4(%eax),%edx
  100196:	89 55 f0             	mov    %edx,-0x10(%ebp)
  100199:	8b 00                	mov    (%eax),%eax
  10019b:	83 ec 04             	sub    $0x4,%esp
  10019e:	6a 01                	push   $0x1
  1001a0:	6a 0a                	push   $0xa
  1001a2:	50                   	push   %eax
  1001a3:	e8 98 fe ff ff       	call   100040 <printint>
  1001a8:	83 c4 10             	add    $0x10,%esp
      break;
  1001ab:	e9 8a 00 00 00       	jmp    10023a <cprintf+0x14e>
      printint(*argp++, 16, 0);
  1001b0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1001b3:	8d 50 04             	lea    0x4(%eax),%edx
  1001b6:	89 55 f0             	mov    %edx,-0x10(%ebp)
  1001b9:	8b 00                	mov    (%eax),%eax
  1001bb:	83 ec 04             	sub    $0x4,%esp
  1001be:	6a 00                	push   $0x0
  1001c0:	6a 10                	push   $0x10
  1001c2:	50                   	push   %eax
  1001c3:	e8 78 fe ff ff       	call   100040 <printint>
  1001c8:	83 c4 10             	add    $0x10,%esp
      break;
  1001cb:	eb 6d                	jmp    10023a <cprintf+0x14e>
      if((s = (char*)*argp++) == 0)
  1001cd:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1001d0:	8d 50 04             	lea    0x4(%eax),%edx
  1001d3:	89 55 f0             	mov    %edx,-0x10(%ebp)
  1001d6:	8b 00                	mov    (%eax),%eax
  1001d8:	89 45 ec             	mov    %eax,-0x14(%ebp)
  1001db:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  1001df:	75 22                	jne    100203 <cprintf+0x117>
        s = "(null)";
  1001e1:	c7 45 ec 54 56 10 00 	movl   $0x105654,-0x14(%ebp)
      for(; *s; s++)
  1001e8:	eb 19                	jmp    100203 <cprintf+0x117>
        consputc(*s);
  1001ea:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1001ed:	0f b6 00             	movzbl (%eax),%eax
  1001f0:	0f be c0             	movsbl %al,%eax
  1001f3:	83 ec 0c             	sub    $0xc,%esp
  1001f6:	50                   	push   %eax
  1001f7:	e8 3f 01 00 00       	call   10033b <consputc>
  1001fc:	83 c4 10             	add    $0x10,%esp
      for(; *s; s++)
  1001ff:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
  100203:	8b 45 ec             	mov    -0x14(%ebp),%eax
  100206:	0f b6 00             	movzbl (%eax),%eax
  100209:	84 c0                	test   %al,%al
  10020b:	75 dd                	jne    1001ea <cprintf+0xfe>
      break;
  10020d:	eb 2b                	jmp    10023a <cprintf+0x14e>
      consputc('%');
  10020f:	83 ec 0c             	sub    $0xc,%esp
  100212:	6a 25                	push   $0x25
  100214:	e8 22 01 00 00       	call   10033b <consputc>
  100219:	83 c4 10             	add    $0x10,%esp
      break;
  10021c:	eb 1c                	jmp    10023a <cprintf+0x14e>
      consputc('%');
  10021e:	83 ec 0c             	sub    $0xc,%esp
  100221:	6a 25                	push   $0x25
  100223:	e8 13 01 00 00       	call   10033b <consputc>
  100228:	83 c4 10             	add    $0x10,%esp
      consputc(c);
  10022b:	83 ec 0c             	sub    $0xc,%esp
  10022e:	ff 75 e8             	push   -0x18(%ebp)
  100231:	e8 05 01 00 00       	call   10033b <consputc>
  100236:	83 c4 10             	add    $0x10,%esp
      break;
  100239:	90                   	nop
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
  10023a:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  10023e:	8b 55 08             	mov    0x8(%ebp),%edx
  100241:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100244:	01 d0                	add    %edx,%eax
  100246:	0f b6 00             	movzbl (%eax),%eax
  100249:	0f be c0             	movsbl %al,%eax
  10024c:	25 ff 00 00 00       	and    $0xff,%eax
  100251:	89 45 e8             	mov    %eax,-0x18(%ebp)
  100254:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  100258:	0f 85 b1 fe ff ff    	jne    10010f <cprintf+0x23>
  10025e:	eb 04                	jmp    100264 <cprintf+0x178>
    return;
  100260:	90                   	nop
  100261:	eb 01                	jmp    100264 <cprintf+0x178>
      break;
  100263:	90                   	nop
}
  100264:	c9                   	leave
  100265:	c3                   	ret

00100266 <halt>:
{
  100266:	55                   	push   %ebp
  100267:	89 e5                	mov    %esp,%ebp
  100269:	83 ec 08             	sub    $0x8,%esp
  cprintf("Bye COL%d!\n\0", 331);
  10026c:	83 ec 08             	sub    $0x8,%esp
  10026f:	68 4b 01 00 00       	push   $0x14b
  100274:	68 5b 56 10 00       	push   $0x10565b
  100279:	e8 6e fe ff ff       	call   1000ec <cprintf>
  10027e:	83 c4 10             	add    $0x10,%esp
  outw(0x602, 0x2000);
  100281:	83 ec 08             	sub    $0x8,%esp
  100284:	68 00 20 00 00       	push   $0x2000
  100289:	68 02 06 00 00       	push   $0x602
  10028e:	e8 85 fd ff ff       	call   100018 <outw>
  100293:	83 c4 10             	add    $0x10,%esp
  outw(0xB002, 0x2000);
  100296:	83 ec 08             	sub    $0x8,%esp
  100299:	68 00 20 00 00       	push   $0x2000
  10029e:	68 02 b0 00 00       	push   $0xb002
  1002a3:	e8 70 fd ff ff       	call   100018 <outw>
  1002a8:	83 c4 10             	add    $0x10,%esp
  for(;;);
  1002ab:	90                   	nop
  1002ac:	eb fd                	jmp    1002ab <halt+0x45>

001002ae <panic>:
{
  1002ae:	55                   	push   %ebp
  1002af:	89 e5                	mov    %esp,%ebp
  1002b1:	83 ec 38             	sub    $0x38,%esp
  cli();
  1002b4:	e8 80 fd ff ff       	call   100039 <cli>
  cprintf("lapicid %d: panic: ", lapicid());
  1002b9:	e8 71 05 00 00       	call   10082f <lapicid>
  1002be:	83 ec 08             	sub    $0x8,%esp
  1002c1:	50                   	push   %eax
  1002c2:	68 68 56 10 00       	push   $0x105668
  1002c7:	e8 20 fe ff ff       	call   1000ec <cprintf>
  1002cc:	83 c4 10             	add    $0x10,%esp
  cprintf(s);
  1002cf:	8b 45 08             	mov    0x8(%ebp),%eax
  1002d2:	83 ec 0c             	sub    $0xc,%esp
  1002d5:	50                   	push   %eax
  1002d6:	e8 11 fe ff ff       	call   1000ec <cprintf>
  1002db:	83 c4 10             	add    $0x10,%esp
  cprintf("\n");
  1002de:	83 ec 0c             	sub    $0xc,%esp
  1002e1:	68 7c 56 10 00       	push   $0x10567c
  1002e6:	e8 01 fe ff ff       	call   1000ec <cprintf>
  1002eb:	83 c4 10             	add    $0x10,%esp
  getcallerpcs(&s, pcs);
  1002ee:	83 ec 08             	sub    $0x8,%esp
  1002f1:	8d 45 cc             	lea    -0x34(%ebp),%eax
  1002f4:	50                   	push   %eax
  1002f5:	8d 45 08             	lea    0x8(%ebp),%eax
  1002f8:	50                   	push   %eax
  1002f9:	e8 77 13 00 00       	call   101675 <getcallerpcs>
  1002fe:	83 c4 10             	add    $0x10,%esp
  for(i=0; i<10; i++)
  100301:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  100308:	eb 1c                	jmp    100326 <panic+0x78>
    cprintf(" %p", pcs[i]);
  10030a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10030d:	8b 44 85 cc          	mov    -0x34(%ebp,%eax,4),%eax
  100311:	83 ec 08             	sub    $0x8,%esp
  100314:	50                   	push   %eax
  100315:	68 7e 56 10 00       	push   $0x10567e
  10031a:	e8 cd fd ff ff       	call   1000ec <cprintf>
  10031f:	83 c4 10             	add    $0x10,%esp
  for(i=0; i<10; i++)
  100322:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  100326:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
  10032a:	7e de                	jle    10030a <panic+0x5c>
  panicked = 1; // freeze other CPU
  10032c:	c7 05 0c 65 10 00 01 	movl   $0x1,0x10650c
  100333:	00 00 00 
  halt();
  100336:	e8 2b ff ff ff       	call   100266 <halt>

0010033b <consputc>:

#define BACKSPACE 0x100

void
consputc(int c)
{
  10033b:	55                   	push   %ebp
  10033c:	89 e5                	mov    %esp,%ebp
  10033e:	83 ec 08             	sub    $0x8,%esp
  if(c == BACKSPACE){
  100341:	81 7d 08 00 01 00 00 	cmpl   $0x100,0x8(%ebp)
  100348:	75 29                	jne    100373 <consputc+0x38>
    uartputc('\b'); uartputc(' '); uartputc('\b');
  10034a:	83 ec 0c             	sub    $0xc,%esp
  10034d:	6a 08                	push   $0x8
  10034f:	e8 b4 0a 00 00       	call   100e08 <uartputc>
  100354:	83 c4 10             	add    $0x10,%esp
  100357:	83 ec 0c             	sub    $0xc,%esp
  10035a:	6a 20                	push   $0x20
  10035c:	e8 a7 0a 00 00       	call   100e08 <uartputc>
  100361:	83 c4 10             	add    $0x10,%esp
  100364:	83 ec 0c             	sub    $0xc,%esp
  100367:	6a 08                	push   $0x8
  100369:	e8 9a 0a 00 00       	call   100e08 <uartputc>
  10036e:	83 c4 10             	add    $0x10,%esp
  } else
    uartputc(c);
}
  100371:	eb 0e                	jmp    100381 <consputc+0x46>
    uartputc(c);
  100373:	83 ec 0c             	sub    $0xc,%esp
  100376:	ff 75 08             	push   0x8(%ebp)
  100379:	e8 8a 0a 00 00       	call   100e08 <uartputc>
  10037e:	83 c4 10             	add    $0x10,%esp
}
  100381:	90                   	nop
  100382:	c9                   	leave
  100383:	c3                   	ret

00100384 <consoleintr>:

#define C(x)  ((x)-'@')  // Control-x

void
consoleintr(int (*getc)(void))
{
  100384:	55                   	push   %ebp
  100385:	89 e5                	mov    %esp,%ebp
  100387:	83 ec 18             	sub    $0x18,%esp
  int c, doprocdump=0;
  10038a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

  while((c = getc()) >= 0){
  100391:	e9 44 01 00 00       	jmp    1004da <consoleintr+0x156>
    switch(c){
  100396:	83 7d f0 7f          	cmpl   $0x7f,-0x10(%ebp)
  10039a:	0f 84 81 00 00 00    	je     100421 <consoleintr+0x9d>
  1003a0:	83 7d f0 7f          	cmpl   $0x7f,-0x10(%ebp)
  1003a4:	0f 8f ac 00 00 00    	jg     100456 <consoleintr+0xd2>
  1003aa:	83 7d f0 15          	cmpl   $0x15,-0x10(%ebp)
  1003ae:	74 43                	je     1003f3 <consoleintr+0x6f>
  1003b0:	83 7d f0 15          	cmpl   $0x15,-0x10(%ebp)
  1003b4:	0f 8f 9c 00 00 00    	jg     100456 <consoleintr+0xd2>
  1003ba:	83 7d f0 08          	cmpl   $0x8,-0x10(%ebp)
  1003be:	74 61                	je     100421 <consoleintr+0x9d>
  1003c0:	83 7d f0 10          	cmpl   $0x10,-0x10(%ebp)
  1003c4:	0f 85 8c 00 00 00    	jne    100456 <consoleintr+0xd2>
    case C('P'):  // Process listing.
      // procdump() locks cons.lock indirectly; invoke later
      doprocdump = 1;
  1003ca:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
      break;
  1003d1:	e9 04 01 00 00       	jmp    1004da <consoleintr+0x156>
    case C('U'):  // Kill line.
      while(input.e != input.w &&
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
        input.e--;
  1003d6:	a1 08 65 10 00       	mov    0x106508,%eax
  1003db:	83 e8 01             	sub    $0x1,%eax
  1003de:	a3 08 65 10 00       	mov    %eax,0x106508
        consputc(BACKSPACE);
  1003e3:	83 ec 0c             	sub    $0xc,%esp
  1003e6:	68 00 01 00 00       	push   $0x100
  1003eb:	e8 4b ff ff ff       	call   10033b <consputc>
  1003f0:	83 c4 10             	add    $0x10,%esp
      while(input.e != input.w &&
  1003f3:	8b 15 08 65 10 00    	mov    0x106508,%edx
  1003f9:	a1 04 65 10 00       	mov    0x106504,%eax
  1003fe:	39 c2                	cmp    %eax,%edx
  100400:	0f 84 cd 00 00 00    	je     1004d3 <consoleintr+0x14f>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
  100406:	a1 08 65 10 00       	mov    0x106508,%eax
  10040b:	83 e8 01             	sub    $0x1,%eax
  10040e:	83 e0 7f             	and    $0x7f,%eax
  100411:	0f b6 80 80 64 10 00 	movzbl 0x106480(%eax),%eax
      while(input.e != input.w &&
  100418:	3c 0a                	cmp    $0xa,%al
  10041a:	75 ba                	jne    1003d6 <consoleintr+0x52>
      }
      break;
  10041c:	e9 b2 00 00 00       	jmp    1004d3 <consoleintr+0x14f>
    case C('H'): case '\x7f':  // Backspace
      if(input.e != input.w){
  100421:	8b 15 08 65 10 00    	mov    0x106508,%edx
  100427:	a1 04 65 10 00       	mov    0x106504,%eax
  10042c:	39 c2                	cmp    %eax,%edx
  10042e:	0f 84 a2 00 00 00    	je     1004d6 <consoleintr+0x152>
        input.e--;
  100434:	a1 08 65 10 00       	mov    0x106508,%eax
  100439:	83 e8 01             	sub    $0x1,%eax
  10043c:	a3 08 65 10 00       	mov    %eax,0x106508
        consputc(BACKSPACE);
  100441:	83 ec 0c             	sub    $0xc,%esp
  100444:	68 00 01 00 00       	push   $0x100
  100449:	e8 ed fe ff ff       	call   10033b <consputc>
  10044e:	83 c4 10             	add    $0x10,%esp
      }
      break;
  100451:	e9 80 00 00 00       	jmp    1004d6 <consoleintr+0x152>
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
  100456:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  10045a:	74 7d                	je     1004d9 <consoleintr+0x155>
  10045c:	8b 15 08 65 10 00    	mov    0x106508,%edx
  100462:	a1 00 65 10 00       	mov    0x106500,%eax
  100467:	29 c2                	sub    %eax,%edx
  100469:	83 fa 7f             	cmp    $0x7f,%edx
  10046c:	77 6b                	ja     1004d9 <consoleintr+0x155>
        c = (c == '\r') ? '\n' : c;
  10046e:	83 7d f0 0d          	cmpl   $0xd,-0x10(%ebp)
  100472:	74 05                	je     100479 <consoleintr+0xf5>
  100474:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100477:	eb 05                	jmp    10047e <consoleintr+0xfa>
  100479:	b8 0a 00 00 00       	mov    $0xa,%eax
  10047e:	89 45 f0             	mov    %eax,-0x10(%ebp)
        input.buf[input.e++ % INPUT_BUF] = c;
  100481:	a1 08 65 10 00       	mov    0x106508,%eax
  100486:	8d 50 01             	lea    0x1(%eax),%edx
  100489:	89 15 08 65 10 00    	mov    %edx,0x106508
  10048f:	83 e0 7f             	and    $0x7f,%eax
  100492:	8b 55 f0             	mov    -0x10(%ebp),%edx
  100495:	88 90 80 64 10 00    	mov    %dl,0x106480(%eax)
        consputc(c);
  10049b:	83 ec 0c             	sub    $0xc,%esp
  10049e:	ff 75 f0             	push   -0x10(%ebp)
  1004a1:	e8 95 fe ff ff       	call   10033b <consputc>
  1004a6:	83 c4 10             	add    $0x10,%esp
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
  1004a9:	83 7d f0 0a          	cmpl   $0xa,-0x10(%ebp)
  1004ad:	74 18                	je     1004c7 <consoleintr+0x143>
  1004af:	83 7d f0 04          	cmpl   $0x4,-0x10(%ebp)
  1004b3:	74 12                	je     1004c7 <consoleintr+0x143>
  1004b5:	8b 15 08 65 10 00    	mov    0x106508,%edx
  1004bb:	a1 00 65 10 00       	mov    0x106500,%eax
  1004c0:	83 e8 80             	sub    $0xffffff80,%eax
  1004c3:	39 c2                	cmp    %eax,%edx
  1004c5:	75 12                	jne    1004d9 <consoleintr+0x155>
          // call myproc with the buf
          input.w = input.e;
  1004c7:	a1 08 65 10 00       	mov    0x106508,%eax
  1004cc:	a3 04 65 10 00       	mov    %eax,0x106504
        }
      }
      break;
  1004d1:	eb 06                	jmp    1004d9 <consoleintr+0x155>
      break;
  1004d3:	90                   	nop
  1004d4:	eb 04                	jmp    1004da <consoleintr+0x156>
      break;
  1004d6:	90                   	nop
  1004d7:	eb 01                	jmp    1004da <consoleintr+0x156>
      break;
  1004d9:	90                   	nop
  while((c = getc()) >= 0){
  1004da:	8b 45 08             	mov    0x8(%ebp),%eax
  1004dd:	ff d0                	call   *%eax
  1004df:	89 45 f0             	mov    %eax,-0x10(%ebp)
  1004e2:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  1004e6:	0f 89 aa fe ff ff    	jns    100396 <consoleintr+0x12>
    }
  }
  if(doprocdump) {
  1004ec:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  1004f0:	74 05                	je     1004f7 <consoleintr+0x173>
    procdump();
  1004f2:	e8 d0 10 00 00       	call   1015c7 <procdump>
  }
}
  1004f7:	90                   	nop
  1004f8:	c9                   	leave
  1004f9:	c3                   	ret

001004fa <consoleread>:


int
consoleread(struct inode *ip, char *dst, int n)
{
  1004fa:	55                   	push   %ebp
  1004fb:	89 e5                	mov    %esp,%ebp
  1004fd:	83 ec 10             	sub    $0x10,%esp
  uint target;
  int c;

  target = n;
  100500:	8b 45 10             	mov    0x10(%ebp),%eax
  100503:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while(n > 0){
  100506:	eb 63                	jmp    10056b <consoleread+0x71>
    while(input.r == input.w);
  100508:	90                   	nop
  100509:	8b 15 00 65 10 00    	mov    0x106500,%edx
  10050f:	a1 04 65 10 00       	mov    0x106504,%eax
  100514:	39 c2                	cmp    %eax,%edx
  100516:	74 f1                	je     100509 <consoleread+0xf>
    c = input.buf[input.r++ % INPUT_BUF];
  100518:	a1 00 65 10 00       	mov    0x106500,%eax
  10051d:	8d 50 01             	lea    0x1(%eax),%edx
  100520:	89 15 00 65 10 00    	mov    %edx,0x106500
  100526:	83 e0 7f             	and    $0x7f,%eax
  100529:	0f b6 80 80 64 10 00 	movzbl 0x106480(%eax),%eax
  100530:	0f be c0             	movsbl %al,%eax
  100533:	89 45 f8             	mov    %eax,-0x8(%ebp)
    if(c == C('D')){  // EOF
  100536:	83 7d f8 04          	cmpl   $0x4,-0x8(%ebp)
  10053a:	75 17                	jne    100553 <consoleread+0x59>
      if(n < target){
  10053c:	8b 45 10             	mov    0x10(%ebp),%eax
  10053f:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  100542:	73 2f                	jae    100573 <consoleread+0x79>
        // Save ^D for next time, to make sure
        // caller gets a 0-byte result.
        input.r--;
  100544:	a1 00 65 10 00       	mov    0x106500,%eax
  100549:	83 e8 01             	sub    $0x1,%eax
  10054c:	a3 00 65 10 00       	mov    %eax,0x106500
      }
      break;
  100551:	eb 20                	jmp    100573 <consoleread+0x79>
    }
    *dst++ = c;
  100553:	8b 45 0c             	mov    0xc(%ebp),%eax
  100556:	8d 50 01             	lea    0x1(%eax),%edx
  100559:	89 55 0c             	mov    %edx,0xc(%ebp)
  10055c:	8b 55 f8             	mov    -0x8(%ebp),%edx
  10055f:	88 10                	mov    %dl,(%eax)
    --n;
  100561:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
    if(c == '\n')
  100565:	83 7d f8 0a          	cmpl   $0xa,-0x8(%ebp)
  100569:	74 0b                	je     100576 <consoleread+0x7c>
  while(n > 0){
  10056b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  10056f:	7f 97                	jg     100508 <consoleread+0xe>
  100571:	eb 04                	jmp    100577 <consoleread+0x7d>
      break;
  100573:	90                   	nop
  100574:	eb 01                	jmp    100577 <consoleread+0x7d>
      break;
  100576:	90                   	nop
  }

  return target - n;
  100577:	8b 45 10             	mov    0x10(%ebp),%eax
  10057a:	8b 55 fc             	mov    -0x4(%ebp),%edx
  10057d:	29 c2                	sub    %eax,%edx
  10057f:	89 d0                	mov    %edx,%eax
}
  100581:	c9                   	leave
  100582:	c3                   	ret

00100583 <consolewrite>:

int
consolewrite(struct inode *ip, char *buf, int n)
{
  100583:	55                   	push   %ebp
  100584:	89 e5                	mov    %esp,%ebp
  100586:	83 ec 18             	sub    $0x18,%esp
  int i;
  for(i = 0; i < n; i++)
  100589:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  100590:	eb 21                	jmp    1005b3 <consolewrite+0x30>
    consputc(buf[i] & 0xff);
  100592:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100595:	8b 45 0c             	mov    0xc(%ebp),%eax
  100598:	01 d0                	add    %edx,%eax
  10059a:	0f b6 00             	movzbl (%eax),%eax
  10059d:	0f be c0             	movsbl %al,%eax
  1005a0:	0f b6 c0             	movzbl %al,%eax
  1005a3:	83 ec 0c             	sub    $0xc,%esp
  1005a6:	50                   	push   %eax
  1005a7:	e8 8f fd ff ff       	call   10033b <consputc>
  1005ac:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < n; i++)
  1005af:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  1005b3:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1005b6:	3b 45 10             	cmp    0x10(%ebp),%eax
  1005b9:	7c d7                	jl     100592 <consolewrite+0xf>
  return n;
  1005bb:	8b 45 10             	mov    0x10(%ebp),%eax
}
  1005be:	c9                   	leave
  1005bf:	c3                   	ret

001005c0 <consoleinit>:

void
consoleinit(void)
{
  1005c0:	55                   	push   %ebp
  1005c1:	89 e5                	mov    %esp,%ebp
  devsw[CONSOLE].write = consolewrite;
  1005c3:	c7 05 2c e2 10 00 83 	movl   $0x100583,0x10e22c
  1005ca:	05 10 00 
  devsw[CONSOLE].read = consoleread;
  1005cd:	c7 05 28 e2 10 00 fa 	movl   $0x1004fa,0x10e228
  1005d4:	04 10 00 
  1005d7:	90                   	nop
  1005d8:	5d                   	pop    %ebp
  1005d9:	c3                   	ret

001005da <ioapicread>:
  uint data;
};

static uint
ioapicread(int reg)
{
  1005da:	55                   	push   %ebp
  1005db:	89 e5                	mov    %esp,%ebp
  ioapic->reg = reg;
  1005dd:	a1 10 65 10 00       	mov    0x106510,%eax
  1005e2:	8b 55 08             	mov    0x8(%ebp),%edx
  1005e5:	89 10                	mov    %edx,(%eax)
  return ioapic->data;
  1005e7:	a1 10 65 10 00       	mov    0x106510,%eax
  1005ec:	8b 40 10             	mov    0x10(%eax),%eax
}
  1005ef:	5d                   	pop    %ebp
  1005f0:	c3                   	ret

001005f1 <ioapicwrite>:

static void
ioapicwrite(int reg, uint data)
{
  1005f1:	55                   	push   %ebp
  1005f2:	89 e5                	mov    %esp,%ebp
  ioapic->reg = reg;
  1005f4:	a1 10 65 10 00       	mov    0x106510,%eax
  1005f9:	8b 55 08             	mov    0x8(%ebp),%edx
  1005fc:	89 10                	mov    %edx,(%eax)
  ioapic->data = data;
  1005fe:	a1 10 65 10 00       	mov    0x106510,%eax
  100603:	8b 55 0c             	mov    0xc(%ebp),%edx
  100606:	89 50 10             	mov    %edx,0x10(%eax)
}
  100609:	90                   	nop
  10060a:	5d                   	pop    %ebp
  10060b:	c3                   	ret

0010060c <ioapicinit>:

void
ioapicinit(void)
{
  10060c:	55                   	push   %ebp
  10060d:	89 e5                	mov    %esp,%ebp
  10060f:	83 ec 18             	sub    $0x18,%esp
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
  100612:	c7 05 10 65 10 00 00 	movl   $0xfec00000,0x106510
  100619:	00 c0 fe 
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  10061c:	6a 01                	push   $0x1
  10061e:	e8 b7 ff ff ff       	call   1005da <ioapicread>
  100623:	83 c4 04             	add    $0x4,%esp
  100626:	c1 e8 10             	shr    $0x10,%eax
  100629:	25 ff 00 00 00       	and    $0xff,%eax
  10062e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  id = ioapicread(REG_ID) >> 24;
  100631:	6a 00                	push   $0x0
  100633:	e8 a2 ff ff ff       	call   1005da <ioapicread>
  100638:	83 c4 04             	add    $0x4,%esp
  10063b:	c1 e8 18             	shr    $0x18,%eax
  10063e:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if(id != ioapicid)
  100641:	0f b6 05 84 6a 10 00 	movzbl 0x106a84,%eax
  100648:	0f b6 c0             	movzbl %al,%eax
  10064b:	39 45 ec             	cmp    %eax,-0x14(%ebp)
  10064e:	74 10                	je     100660 <ioapicinit+0x54>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
  100650:	83 ec 0c             	sub    $0xc,%esp
  100653:	68 84 56 10 00       	push   $0x105684
  100658:	e8 8f fa ff ff       	call   1000ec <cprintf>
  10065d:	83 c4 10             	add    $0x10,%esp

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
  100660:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  100667:	eb 3f                	jmp    1006a8 <ioapicinit+0x9c>
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
  100669:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10066c:	83 c0 20             	add    $0x20,%eax
  10066f:	0d 00 00 01 00       	or     $0x10000,%eax
  100674:	89 c2                	mov    %eax,%edx
  100676:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100679:	83 c0 08             	add    $0x8,%eax
  10067c:	01 c0                	add    %eax,%eax
  10067e:	83 ec 08             	sub    $0x8,%esp
  100681:	52                   	push   %edx
  100682:	50                   	push   %eax
  100683:	e8 69 ff ff ff       	call   1005f1 <ioapicwrite>
  100688:	83 c4 10             	add    $0x10,%esp
    ioapicwrite(REG_TABLE+2*i+1, 0);
  10068b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10068e:	83 c0 08             	add    $0x8,%eax
  100691:	01 c0                	add    %eax,%eax
  100693:	83 c0 01             	add    $0x1,%eax
  100696:	83 ec 08             	sub    $0x8,%esp
  100699:	6a 00                	push   $0x0
  10069b:	50                   	push   %eax
  10069c:	e8 50 ff ff ff       	call   1005f1 <ioapicwrite>
  1006a1:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i <= maxintr; i++){
  1006a4:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  1006a8:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1006ab:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  1006ae:	7e b9                	jle    100669 <ioapicinit+0x5d>
  }
}
  1006b0:	90                   	nop
  1006b1:	90                   	nop
  1006b2:	c9                   	leave
  1006b3:	c3                   	ret

001006b4 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
  1006b4:	55                   	push   %ebp
  1006b5:	89 e5                	mov    %esp,%ebp
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
  1006b7:	8b 45 08             	mov    0x8(%ebp),%eax
  1006ba:	83 c0 20             	add    $0x20,%eax
  1006bd:	89 c2                	mov    %eax,%edx
  1006bf:	8b 45 08             	mov    0x8(%ebp),%eax
  1006c2:	83 c0 08             	add    $0x8,%eax
  1006c5:	01 c0                	add    %eax,%eax
  1006c7:	52                   	push   %edx
  1006c8:	50                   	push   %eax
  1006c9:	e8 23 ff ff ff       	call   1005f1 <ioapicwrite>
  1006ce:	83 c4 08             	add    $0x8,%esp
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
  1006d1:	8b 45 0c             	mov    0xc(%ebp),%eax
  1006d4:	c1 e0 18             	shl    $0x18,%eax
  1006d7:	89 c2                	mov    %eax,%edx
  1006d9:	8b 45 08             	mov    0x8(%ebp),%eax
  1006dc:	83 c0 08             	add    $0x8,%eax
  1006df:	01 c0                	add    %eax,%eax
  1006e1:	83 c0 01             	add    $0x1,%eax
  1006e4:	52                   	push   %edx
  1006e5:	50                   	push   %eax
  1006e6:	e8 06 ff ff ff       	call   1005f1 <ioapicwrite>
  1006eb:	83 c4 08             	add    $0x8,%esp
}
  1006ee:	90                   	nop
  1006ef:	c9                   	leave
  1006f0:	c3                   	ret

001006f1 <lapicw>:

volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  1006f1:	55                   	push   %ebp
  1006f2:	89 e5                	mov    %esp,%ebp
  lapic[index] = value;
  1006f4:	a1 14 65 10 00       	mov    0x106514,%eax
  1006f9:	8b 55 08             	mov    0x8(%ebp),%edx
  1006fc:	c1 e2 02             	shl    $0x2,%edx
  1006ff:	01 c2                	add    %eax,%edx
  100701:	8b 45 0c             	mov    0xc(%ebp),%eax
  100704:	89 02                	mov    %eax,(%edx)
  lapic[ID];  // wait for write to finish, by reading
  100706:	a1 14 65 10 00       	mov    0x106514,%eax
  10070b:	83 c0 20             	add    $0x20,%eax
  10070e:	8b 00                	mov    (%eax),%eax
}
  100710:	90                   	nop
  100711:	5d                   	pop    %ebp
  100712:	c3                   	ret

00100713 <lapicinit>:

void
lapicinit(void)
{
  100713:	55                   	push   %ebp
  100714:	89 e5                	mov    %esp,%ebp
  if(!lapic)
  100716:	a1 14 65 10 00       	mov    0x106514,%eax
  10071b:	85 c0                	test   %eax,%eax
  10071d:	0f 84 09 01 00 00    	je     10082c <lapicinit+0x119>
    return;

  // Enable local APIC; set spurious interrupt vector.
  lapicw(SVR, ENABLE | (T_IRQ0 + IRQ_SPURIOUS));
  100723:	68 3f 01 00 00       	push   $0x13f
  100728:	6a 3c                	push   $0x3c
  10072a:	e8 c2 ff ff ff       	call   1006f1 <lapicw>
  10072f:	83 c4 08             	add    $0x8,%esp

  // The timer repeatedly counts down at bus frequency
  // from lapic[TICR] and then issues an interrupt.
  // If xv6 cared more about precise timekeeping,
  // TICR would be calibrated using an external time source.
  lapicw(TDCR, X1);
  100732:	6a 0b                	push   $0xb
  100734:	68 f8 00 00 00       	push   $0xf8
  100739:	e8 b3 ff ff ff       	call   1006f1 <lapicw>
  10073e:	83 c4 08             	add    $0x8,%esp
  lapicw(TIMER, PERIODIC | (T_IRQ0 + IRQ_TIMER));
  100741:	68 20 00 02 00       	push   $0x20020
  100746:	68 c8 00 00 00       	push   $0xc8
  10074b:	e8 a1 ff ff ff       	call   1006f1 <lapicw>
  100750:	83 c4 08             	add    $0x8,%esp
  lapicw(TICR, 10000000);
  100753:	68 80 96 98 00       	push   $0x989680
  100758:	68 e0 00 00 00       	push   $0xe0
  10075d:	e8 8f ff ff ff       	call   1006f1 <lapicw>
  100762:	83 c4 08             	add    $0x8,%esp

  // Disable logical interrupt lines.
  lapicw(LINT0, MASKED);
  100765:	68 00 00 01 00       	push   $0x10000
  10076a:	68 d4 00 00 00       	push   $0xd4
  10076f:	e8 7d ff ff ff       	call   1006f1 <lapicw>
  100774:	83 c4 08             	add    $0x8,%esp
  lapicw(LINT1, MASKED);
  100777:	68 00 00 01 00       	push   $0x10000
  10077c:	68 d8 00 00 00       	push   $0xd8
  100781:	e8 6b ff ff ff       	call   1006f1 <lapicw>
  100786:	83 c4 08             	add    $0x8,%esp

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
  100789:	a1 14 65 10 00       	mov    0x106514,%eax
  10078e:	83 c0 30             	add    $0x30,%eax
  100791:	8b 00                	mov    (%eax),%eax
  100793:	25 00 00 fc 00       	and    $0xfc0000,%eax
  100798:	85 c0                	test   %eax,%eax
  10079a:	74 12                	je     1007ae <lapicinit+0x9b>
    lapicw(PCINT, MASKED);
  10079c:	68 00 00 01 00       	push   $0x10000
  1007a1:	68 d0 00 00 00       	push   $0xd0
  1007a6:	e8 46 ff ff ff       	call   1006f1 <lapicw>
  1007ab:	83 c4 08             	add    $0x8,%esp

  // Map error interrupt to IRQ_ERROR.
  lapicw(ERROR, T_IRQ0 + IRQ_ERROR);
  1007ae:	6a 33                	push   $0x33
  1007b0:	68 dc 00 00 00       	push   $0xdc
  1007b5:	e8 37 ff ff ff       	call   1006f1 <lapicw>
  1007ba:	83 c4 08             	add    $0x8,%esp

  // Clear error status register (requires back-to-back writes).
  lapicw(ESR, 0);
  1007bd:	6a 00                	push   $0x0
  1007bf:	68 a0 00 00 00       	push   $0xa0
  1007c4:	e8 28 ff ff ff       	call   1006f1 <lapicw>
  1007c9:	83 c4 08             	add    $0x8,%esp
  lapicw(ESR, 0);
  1007cc:	6a 00                	push   $0x0
  1007ce:	68 a0 00 00 00       	push   $0xa0
  1007d3:	e8 19 ff ff ff       	call   1006f1 <lapicw>
  1007d8:	83 c4 08             	add    $0x8,%esp

  // Ack any outstanding interrupts.
  lapicw(EOI, 0);
  1007db:	6a 00                	push   $0x0
  1007dd:	6a 2c                	push   $0x2c
  1007df:	e8 0d ff ff ff       	call   1006f1 <lapicw>
  1007e4:	83 c4 08             	add    $0x8,%esp

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  1007e7:	6a 00                	push   $0x0
  1007e9:	68 c4 00 00 00       	push   $0xc4
  1007ee:	e8 fe fe ff ff       	call   1006f1 <lapicw>
  1007f3:	83 c4 08             	add    $0x8,%esp
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  1007f6:	68 00 85 08 00       	push   $0x88500
  1007fb:	68 c0 00 00 00       	push   $0xc0
  100800:	e8 ec fe ff ff       	call   1006f1 <lapicw>
  100805:	83 c4 08             	add    $0x8,%esp
  while(lapic[ICRLO] & DELIVS)
  100808:	90                   	nop
  100809:	a1 14 65 10 00       	mov    0x106514,%eax
  10080e:	05 00 03 00 00       	add    $0x300,%eax
  100813:	8b 00                	mov    (%eax),%eax
  100815:	25 00 10 00 00       	and    $0x1000,%eax
  10081a:	85 c0                	test   %eax,%eax
  10081c:	75 eb                	jne    100809 <lapicinit+0xf6>
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
  10081e:	6a 00                	push   $0x0
  100820:	6a 20                	push   $0x20
  100822:	e8 ca fe ff ff       	call   1006f1 <lapicw>
  100827:	83 c4 08             	add    $0x8,%esp
  10082a:	eb 01                	jmp    10082d <lapicinit+0x11a>
    return;
  10082c:	90                   	nop
}
  10082d:	c9                   	leave
  10082e:	c3                   	ret

0010082f <lapicid>:

int
lapicid(void)
{
  10082f:	55                   	push   %ebp
  100830:	89 e5                	mov    %esp,%ebp
  if (!lapic)
  100832:	a1 14 65 10 00       	mov    0x106514,%eax
  100837:	85 c0                	test   %eax,%eax
  100839:	75 07                	jne    100842 <lapicid+0x13>
    return 0;
  10083b:	b8 00 00 00 00       	mov    $0x0,%eax
  100840:	eb 0d                	jmp    10084f <lapicid+0x20>
  return lapic[ID] >> 24;
  100842:	a1 14 65 10 00       	mov    0x106514,%eax
  100847:	83 c0 20             	add    $0x20,%eax
  10084a:	8b 00                	mov    (%eax),%eax
  10084c:	c1 e8 18             	shr    $0x18,%eax
}
  10084f:	5d                   	pop    %ebp
  100850:	c3                   	ret

00100851 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
  100851:	55                   	push   %ebp
  100852:	89 e5                	mov    %esp,%ebp
  if(lapic)
  100854:	a1 14 65 10 00       	mov    0x106514,%eax
  100859:	85 c0                	test   %eax,%eax
  10085b:	74 0c                	je     100869 <lapiceoi+0x18>
    lapicw(EOI, 0);
  10085d:	6a 00                	push   $0x0
  10085f:	6a 2c                	push   $0x2c
  100861:	e8 8b fe ff ff       	call   1006f1 <lapicw>
  100866:	83 c4 08             	add    $0x8,%esp
}
  100869:	90                   	nop
  10086a:	c9                   	leave
  10086b:	c3                   	ret

0010086c <microdelay>:

// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
  10086c:	55                   	push   %ebp
  10086d:	89 e5                	mov    %esp,%ebp
  10086f:	90                   	nop
  100870:	5d                   	pop    %ebp
  100871:	c3                   	ret

00100872 <sti>:
  100872:	55                   	push   %ebp
  100873:	89 e5                	mov    %esp,%ebp
  100875:	fb                   	sti
  100876:	90                   	nop
  100877:	5d                   	pop    %ebp
  100878:	c3                   	ret

00100879 <main>:
{
  100879:	8d 4c 24 04          	lea    0x4(%esp),%ecx
  10087d:	83 e4 f0             	and    $0xfffffff0,%esp
  100880:	ff 71 fc             	push   -0x4(%ecx)
  100883:	55                   	push   %ebp
  100884:	89 e5                	mov    %esp,%ebp
  100886:	51                   	push   %ecx
  100887:	83 ec 54             	sub    $0x54,%esp
  kinit(end, P2V(PHYSTOP)); // phys page allocator
  10088a:	83 ec 08             	sub    $0x8,%esp
  10088d:	68 00 00 00 0e       	push   $0xe000000
  100892:	68 f0 fa 10 00       	push   $0x10faf0
  100897:	e8 41 43 00 00       	call   104bdd <kinit>
  10089c:	83 c4 10             	add    $0x10,%esp
  mpinit();        // detect other processors
  10089f:	e8 b5 02 00 00       	call   100b59 <mpinit>
  lapicinit();     // interrupt controller
  1008a4:	e8 6a fe ff ff       	call   100713 <lapicinit>
  picinit();       // disable pic
  1008a9:	e8 10 04 00 00       	call   100cbe <picinit>
  ioapicinit();    // another interrupt controller
  1008ae:	e8 59 fd ff ff       	call   10060c <ioapicinit>
  consoleinit();   // console hardware
  1008b3:	e8 08 fd ff ff       	call   1005c0 <consoleinit>
  uartinit();      // serial port
  1008b8:	e8 64 04 00 00       	call   100d21 <uartinit>
  ideinit();       // disk 
  1008bd:	e8 f8 1e 00 00       	call   1027ba <ideinit>
  tvinit();        // trap vectors
  1008c2:	e8 3d 0f 00 00       	call   101804 <tvinit>
  binit();         // buffer cache
  1008c7:	e8 3d 1c 00 00       	call   102509 <binit>
  idtinit();       // load idt register
  1008cc:	e8 94 10 00 00       	call   101965 <idtinit>
  sti();           // enable interrupts
  1008d1:	e8 9c ff ff ff       	call   100872 <sti>
  iinit(ROOTDEV);  // Read superblock to start reading inodes
  1008d6:	83 ec 0c             	sub    $0xc,%esp
  1008d9:	6a 01                	push   $0x1
  1008db:	e8 bc 24 00 00       	call   102d9c <iinit>
  1008e0:	83 c4 10             	add    $0x10,%esp
  initlog(ROOTDEV);  // Initialize log
  1008e3:	83 ec 0c             	sub    $0xc,%esp
  1008e6:	6a 01                	push   $0x1
  1008e8:	e8 26 3a 00 00       	call   104313 <initlog>
  1008ed:	83 c4 10             	add    $0x10,%esp
  mknod(&console, "console", CONSOLE, CONSOLE);
  1008f0:	6a 01                	push   $0x1
  1008f2:	6a 01                	push   $0x1
  1008f4:	68 b6 56 10 00       	push   $0x1056b6
  1008f9:	8d 45 a8             	lea    -0x58(%ebp),%eax
  1008fc:	50                   	push   %eax
  1008fd:	e8 73 39 00 00       	call   104275 <mknod>
  100902:	83 c4 10             	add    $0x10,%esp
  seginit();       // segment descriptors
  100905:	e8 06 3e 00 00       	call   104710 <seginit>
  pinit(0);        // first process
  10090a:	83 ec 0c             	sub    $0xc,%esp
  10090d:	6a 00                	push   $0x0
  10090f:	e8 f2 09 00 00       	call   101306 <pinit>
  100914:	83 c4 10             	add    $0x10,%esp
  pinit(1);        // second process 
  100917:	83 ec 0c             	sub    $0xc,%esp
  10091a:	6a 01                	push   $0x1
  10091c:	e8 e5 09 00 00       	call   101306 <pinit>
  100921:	83 c4 10             	add    $0x10,%esp
  scheduler();     // start running processes
  100924:	e8 ca 0a 00 00       	call   1013f3 <scheduler>

00100929 <inb>:
// Multiprocessor support
// Search memory for MP description structures.
// http://developer.intel.com/design/pentium/datashts/24201606.pdf

#include "types.h"
  100929:	55                   	push   %ebp
  10092a:	89 e5                	mov    %esp,%ebp
  10092c:	83 ec 14             	sub    $0x14,%esp
  10092f:	8b 45 08             	mov    0x8(%ebp),%eax
  100932:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
#include "defs.h"
#include "param.h"
// #include "memlayout.h"
  100936:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
  10093a:	89 c2                	mov    %eax,%edx
  10093c:	ec                   	in     (%dx),%al
  10093d:	88 45 ff             	mov    %al,-0x1(%ebp)
#include "mp.h"
  100940:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
#include "x86.h"
  100944:	c9                   	leave
  100945:	c3                   	ret

00100946 <outb>:
static uchar
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  100946:	55                   	push   %ebp
  100947:	89 e5                	mov    %esp,%ebp
  100949:	83 ec 08             	sub    $0x8,%esp
  10094c:	8b 55 08             	mov    0x8(%ebp),%edx
  10094f:	8b 45 0c             	mov    0xc(%ebp),%eax
  100952:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
  100956:	88 45 f8             	mov    %al,-0x8(%ebp)
  for(i=0; i<len; i++)
  100959:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
  10095d:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
  100961:	ee                   	out    %al,(%dx)
    sum += addr[i];
  100962:	90                   	nop
  100963:	c9                   	leave
  100964:	c3                   	ret

00100965 <sum>:
{
  100965:	55                   	push   %ebp
  100966:	89 e5                	mov    %esp,%ebp
  100968:	83 ec 10             	sub    $0x10,%esp
  sum = 0;
  10096b:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  for(i=0; i<len; i++)
  100972:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  100979:	eb 15                	jmp    100990 <sum+0x2b>
    sum += addr[i];
  10097b:	8b 55 fc             	mov    -0x4(%ebp),%edx
  10097e:	8b 45 08             	mov    0x8(%ebp),%eax
  100981:	01 d0                	add    %edx,%eax
  100983:	0f b6 00             	movzbl (%eax),%eax
  100986:	0f b6 c0             	movzbl %al,%eax
  100989:	01 45 f8             	add    %eax,-0x8(%ebp)
  for(i=0; i<len; i++)
  10098c:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  100990:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100993:	3b 45 0c             	cmp    0xc(%ebp),%eax
  100996:	7c e3                	jl     10097b <sum+0x16>
  return sum;
  100998:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  10099b:	c9                   	leave
  10099c:	c3                   	ret

0010099d <mpsearch1>:

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
  10099d:	55                   	push   %ebp
  10099e:	89 e5                	mov    %esp,%ebp
  1009a0:	83 ec 18             	sub    $0x18,%esp
  uchar *e, *p, *addr;

  // addr = P2V(a);
  addr = (uchar*) a;
  1009a3:	8b 45 08             	mov    0x8(%ebp),%eax
  1009a6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  e = addr+len;
  1009a9:	8b 55 0c             	mov    0xc(%ebp),%edx
  1009ac:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1009af:	01 d0                	add    %edx,%eax
  1009b1:	89 45 ec             	mov    %eax,-0x14(%ebp)
  for(p = addr; p < e; p += sizeof(struct mp))
  1009b4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1009b7:	89 45 f4             	mov    %eax,-0xc(%ebp)
  1009ba:	eb 36                	jmp    1009f2 <mpsearch1+0x55>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
  1009bc:	83 ec 04             	sub    $0x4,%esp
  1009bf:	6a 04                	push   $0x4
  1009c1:	68 c0 56 10 00       	push   $0x1056c0
  1009c6:	ff 75 f4             	push   -0xc(%ebp)
  1009c9:	e8 9b 05 00 00       	call   100f69 <memcmp>
  1009ce:	83 c4 10             	add    $0x10,%esp
  1009d1:	85 c0                	test   %eax,%eax
  1009d3:	75 19                	jne    1009ee <mpsearch1+0x51>
  1009d5:	83 ec 08             	sub    $0x8,%esp
  1009d8:	6a 10                	push   $0x10
  1009da:	ff 75 f4             	push   -0xc(%ebp)
  1009dd:	e8 83 ff ff ff       	call   100965 <sum>
  1009e2:	83 c4 10             	add    $0x10,%esp
  1009e5:	84 c0                	test   %al,%al
  1009e7:	75 05                	jne    1009ee <mpsearch1+0x51>
      return (struct mp*)p;
  1009e9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1009ec:	eb 11                	jmp    1009ff <mpsearch1+0x62>
  for(p = addr; p < e; p += sizeof(struct mp))
  1009ee:	83 45 f4 10          	addl   $0x10,-0xc(%ebp)
  1009f2:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1009f5:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  1009f8:	72 c2                	jb     1009bc <mpsearch1+0x1f>
  return 0;
  1009fa:	b8 00 00 00 00       	mov    $0x0,%eax
}
  1009ff:	c9                   	leave
  100a00:	c3                   	ret

00100a01 <mpsearch>:
// 1) in the first KB of the EBDA;
// 2) in the last KB of system base memory;
// 3) in the BIOS ROM between 0xE0000 and 0xFFFFF.
static struct mp*
mpsearch(void)
{
  100a01:	55                   	push   %ebp
  100a02:	89 e5                	mov    %esp,%ebp
  100a04:	83 ec 18             	sub    $0x18,%esp
  uchar *bda;
  uint p;
  struct mp *mp;

  // bda = (uchar *) P2V(0x400);
  bda = (uchar *) 0x400;
  100a07:	c7 45 f4 00 04 00 00 	movl   $0x400,-0xc(%ebp)
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
  100a0e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100a11:	83 c0 0f             	add    $0xf,%eax
  100a14:	0f b6 00             	movzbl (%eax),%eax
  100a17:	0f b6 c0             	movzbl %al,%eax
  100a1a:	c1 e0 08             	shl    $0x8,%eax
  100a1d:	89 c2                	mov    %eax,%edx
  100a1f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100a22:	83 c0 0e             	add    $0xe,%eax
  100a25:	0f b6 00             	movzbl (%eax),%eax
  100a28:	0f b6 c0             	movzbl %al,%eax
  100a2b:	09 d0                	or     %edx,%eax
  100a2d:	c1 e0 04             	shl    $0x4,%eax
  100a30:	89 45 f0             	mov    %eax,-0x10(%ebp)
  100a33:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  100a37:	74 21                	je     100a5a <mpsearch+0x59>
    if((mp = mpsearch1(p, 1024)))
  100a39:	83 ec 08             	sub    $0x8,%esp
  100a3c:	68 00 04 00 00       	push   $0x400
  100a41:	ff 75 f0             	push   -0x10(%ebp)
  100a44:	e8 54 ff ff ff       	call   10099d <mpsearch1>
  100a49:	83 c4 10             	add    $0x10,%esp
  100a4c:	89 45 ec             	mov    %eax,-0x14(%ebp)
  100a4f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  100a53:	74 51                	je     100aa6 <mpsearch+0xa5>
      return mp;
  100a55:	8b 45 ec             	mov    -0x14(%ebp),%eax
  100a58:	eb 61                	jmp    100abb <mpsearch+0xba>
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
  100a5a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100a5d:	83 c0 14             	add    $0x14,%eax
  100a60:	0f b6 00             	movzbl (%eax),%eax
  100a63:	0f b6 c0             	movzbl %al,%eax
  100a66:	c1 e0 08             	shl    $0x8,%eax
  100a69:	89 c2                	mov    %eax,%edx
  100a6b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100a6e:	83 c0 13             	add    $0x13,%eax
  100a71:	0f b6 00             	movzbl (%eax),%eax
  100a74:	0f b6 c0             	movzbl %al,%eax
  100a77:	09 d0                	or     %edx,%eax
  100a79:	c1 e0 0a             	shl    $0xa,%eax
  100a7c:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if((mp = mpsearch1(p-1024, 1024)))
  100a7f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100a82:	2d 00 04 00 00       	sub    $0x400,%eax
  100a87:	83 ec 08             	sub    $0x8,%esp
  100a8a:	68 00 04 00 00       	push   $0x400
  100a8f:	50                   	push   %eax
  100a90:	e8 08 ff ff ff       	call   10099d <mpsearch1>
  100a95:	83 c4 10             	add    $0x10,%esp
  100a98:	89 45 ec             	mov    %eax,-0x14(%ebp)
  100a9b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  100a9f:	74 05                	je     100aa6 <mpsearch+0xa5>
      return mp;
  100aa1:	8b 45 ec             	mov    -0x14(%ebp),%eax
  100aa4:	eb 15                	jmp    100abb <mpsearch+0xba>
  }
  return mpsearch1(0xF0000, 0x10000);
  100aa6:	83 ec 08             	sub    $0x8,%esp
  100aa9:	68 00 00 01 00       	push   $0x10000
  100aae:	68 00 00 0f 00       	push   $0xf0000
  100ab3:	e8 e5 fe ff ff       	call   10099d <mpsearch1>
  100ab8:	83 c4 10             	add    $0x10,%esp
}
  100abb:	c9                   	leave
  100abc:	c3                   	ret

00100abd <mpconfig>:
// Check for correct signature, calculate the checksum and,
// if correct, check the version.
// To do: check extended table checksum.
static struct mpconf*
mpconfig(struct mp **pmp)
{
  100abd:	55                   	push   %ebp
  100abe:	89 e5                	mov    %esp,%ebp
  100ac0:	83 ec 18             	sub    $0x18,%esp
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
  100ac3:	e8 39 ff ff ff       	call   100a01 <mpsearch>
  100ac8:	89 45 f4             	mov    %eax,-0xc(%ebp)
  100acb:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  100acf:	74 0a                	je     100adb <mpconfig+0x1e>
  100ad1:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100ad4:	8b 40 04             	mov    0x4(%eax),%eax
  100ad7:	85 c0                	test   %eax,%eax
  100ad9:	75 07                	jne    100ae2 <mpconfig+0x25>
    return 0;
  100adb:	b8 00 00 00 00       	mov    $0x0,%eax
  100ae0:	eb 75                	jmp    100b57 <mpconfig+0x9a>
  // conf = (struct mpconf*) P2V((uint) mp->physaddr);
  conf = (struct mpconf*) (uint) mp->physaddr;
  100ae2:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100ae5:	8b 40 04             	mov    0x4(%eax),%eax
  100ae8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(memcmp(conf, "PCMP", 4) != 0)
  100aeb:	83 ec 04             	sub    $0x4,%esp
  100aee:	6a 04                	push   $0x4
  100af0:	68 c5 56 10 00       	push   $0x1056c5
  100af5:	ff 75 f0             	push   -0x10(%ebp)
  100af8:	e8 6c 04 00 00       	call   100f69 <memcmp>
  100afd:	83 c4 10             	add    $0x10,%esp
  100b00:	85 c0                	test   %eax,%eax
  100b02:	74 07                	je     100b0b <mpconfig+0x4e>
    return 0;
  100b04:	b8 00 00 00 00       	mov    $0x0,%eax
  100b09:	eb 4c                	jmp    100b57 <mpconfig+0x9a>
  if(conf->version != 1 && conf->version != 4)
  100b0b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100b0e:	0f b6 40 06          	movzbl 0x6(%eax),%eax
  100b12:	3c 01                	cmp    $0x1,%al
  100b14:	74 12                	je     100b28 <mpconfig+0x6b>
  100b16:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100b19:	0f b6 40 06          	movzbl 0x6(%eax),%eax
  100b1d:	3c 04                	cmp    $0x4,%al
  100b1f:	74 07                	je     100b28 <mpconfig+0x6b>
    return 0;
  100b21:	b8 00 00 00 00       	mov    $0x0,%eax
  100b26:	eb 2f                	jmp    100b57 <mpconfig+0x9a>
  if(sum((uchar*)conf, conf->length) != 0)
  100b28:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100b2b:	0f b7 40 04          	movzwl 0x4(%eax),%eax
  100b2f:	0f b7 c0             	movzwl %ax,%eax
  100b32:	83 ec 08             	sub    $0x8,%esp
  100b35:	50                   	push   %eax
  100b36:	ff 75 f0             	push   -0x10(%ebp)
  100b39:	e8 27 fe ff ff       	call   100965 <sum>
  100b3e:	83 c4 10             	add    $0x10,%esp
  100b41:	84 c0                	test   %al,%al
  100b43:	74 07                	je     100b4c <mpconfig+0x8f>
    return 0;
  100b45:	b8 00 00 00 00       	mov    $0x0,%eax
  100b4a:	eb 0b                	jmp    100b57 <mpconfig+0x9a>
  *pmp = mp;
  100b4c:	8b 45 08             	mov    0x8(%ebp),%eax
  100b4f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100b52:	89 10                	mov    %edx,(%eax)
  return conf;
  100b54:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  100b57:	c9                   	leave
  100b58:	c3                   	ret

00100b59 <mpinit>:

void
mpinit(void)
{
  100b59:	55                   	push   %ebp
  100b5a:	89 e5                	mov    %esp,%ebp
  100b5c:	83 ec 28             	sub    $0x28,%esp
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
  100b5f:	83 ec 0c             	sub    $0xc,%esp
  100b62:	8d 45 dc             	lea    -0x24(%ebp),%eax
  100b65:	50                   	push   %eax
  100b66:	e8 52 ff ff ff       	call   100abd <mpconfig>
  100b6b:	83 c4 10             	add    $0x10,%esp
  100b6e:	89 45 ec             	mov    %eax,-0x14(%ebp)
  100b71:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  100b75:	75 0d                	jne    100b84 <mpinit+0x2b>
    panic("Expect to run on an SMP");
  100b77:	83 ec 0c             	sub    $0xc,%esp
  100b7a:	68 ca 56 10 00       	push   $0x1056ca
  100b7f:	e8 2a f7 ff ff       	call   1002ae <panic>
  ismp = 1;
  100b84:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
  lapic = (uint*)conf->lapicaddr;
  100b8b:	8b 45 ec             	mov    -0x14(%ebp),%eax
  100b8e:	8b 40 24             	mov    0x24(%eax),%eax
  100b91:	a3 14 65 10 00       	mov    %eax,0x106514
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
  100b96:	8b 45 ec             	mov    -0x14(%ebp),%eax
  100b99:	83 c0 2c             	add    $0x2c,%eax
  100b9c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  100b9f:	8b 45 ec             	mov    -0x14(%ebp),%eax
  100ba2:	0f b7 40 04          	movzwl 0x4(%eax),%eax
  100ba6:	0f b7 d0             	movzwl %ax,%edx
  100ba9:	8b 45 ec             	mov    -0x14(%ebp),%eax
  100bac:	01 d0                	add    %edx,%eax
  100bae:	89 45 e8             	mov    %eax,-0x18(%ebp)
  100bb1:	e9 8c 00 00 00       	jmp    100c42 <mpinit+0xe9>
    switch(*p){
  100bb6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100bb9:	0f b6 00             	movzbl (%eax),%eax
  100bbc:	0f b6 c0             	movzbl %al,%eax
  100bbf:	83 f8 04             	cmp    $0x4,%eax
  100bc2:	7f 76                	jg     100c3a <mpinit+0xe1>
  100bc4:	83 f8 03             	cmp    $0x3,%eax
  100bc7:	7d 6b                	jge    100c34 <mpinit+0xdb>
  100bc9:	83 f8 02             	cmp    $0x2,%eax
  100bcc:	74 4e                	je     100c1c <mpinit+0xc3>
  100bce:	83 f8 02             	cmp    $0x2,%eax
  100bd1:	7f 67                	jg     100c3a <mpinit+0xe1>
  100bd3:	85 c0                	test   %eax,%eax
  100bd5:	74 07                	je     100bde <mpinit+0x85>
  100bd7:	83 f8 01             	cmp    $0x1,%eax
  100bda:	74 58                	je     100c34 <mpinit+0xdb>
  100bdc:	eb 5c                	jmp    100c3a <mpinit+0xe1>
    case MPPROC:
      proc = (struct mpproc*)p;
  100bde:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100be1:	89 45 e0             	mov    %eax,-0x20(%ebp)
      if(ncpu < NCPU) {
  100be4:	a1 80 6a 10 00       	mov    0x106a80,%eax
  100be9:	83 f8 07             	cmp    $0x7,%eax
  100bec:	7f 28                	jg     100c16 <mpinit+0xbd>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
  100bee:	8b 15 80 6a 10 00    	mov    0x106a80,%edx
  100bf4:	8b 45 e0             	mov    -0x20(%ebp),%eax
  100bf7:	0f b6 40 01          	movzbl 0x1(%eax),%eax
  100bfb:	69 d2 ac 00 00 00    	imul   $0xac,%edx,%edx
  100c01:	81 c2 20 65 10 00    	add    $0x106520,%edx
  100c07:	88 02                	mov    %al,(%edx)
        ncpu++;
  100c09:	a1 80 6a 10 00       	mov    0x106a80,%eax
  100c0e:	83 c0 01             	add    $0x1,%eax
  100c11:	a3 80 6a 10 00       	mov    %eax,0x106a80
      }
      p += sizeof(struct mpproc);
  100c16:	83 45 f4 14          	addl   $0x14,-0xc(%ebp)
      continue;
  100c1a:	eb 26                	jmp    100c42 <mpinit+0xe9>
    case MPIOAPIC:
      ioapic = (struct mpioapic*)p;
  100c1c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100c1f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      ioapicid = ioapic->apicno;
  100c22:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  100c25:	0f b6 40 01          	movzbl 0x1(%eax),%eax
  100c29:	a2 84 6a 10 00       	mov    %al,0x106a84
      p += sizeof(struct mpioapic);
  100c2e:	83 45 f4 08          	addl   $0x8,-0xc(%ebp)
      continue;
  100c32:	eb 0e                	jmp    100c42 <mpinit+0xe9>
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
  100c34:	83 45 f4 08          	addl   $0x8,-0xc(%ebp)
      continue;
  100c38:	eb 08                	jmp    100c42 <mpinit+0xe9>
    default:
      ismp = 0;
  100c3a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
      break;
  100c41:	90                   	nop
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
  100c42:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100c45:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  100c48:	0f 82 68 ff ff ff    	jb     100bb6 <mpinit+0x5d>
    }
  }
  if(!ismp)
  100c4e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  100c52:	75 0d                	jne    100c61 <mpinit+0x108>
    panic("Didn't find a suitable machine");
  100c54:	83 ec 0c             	sub    $0xc,%esp
  100c57:	68 e4 56 10 00       	push   $0x1056e4
  100c5c:	e8 4d f6 ff ff       	call   1002ae <panic>

  if(mp->imcrp){
  100c61:	8b 45 dc             	mov    -0x24(%ebp),%eax
  100c64:	0f b6 40 0c          	movzbl 0xc(%eax),%eax
  100c68:	84 c0                	test   %al,%al
  100c6a:	74 30                	je     100c9c <mpinit+0x143>
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
  100c6c:	83 ec 08             	sub    $0x8,%esp
  100c6f:	6a 70                	push   $0x70
  100c71:	6a 22                	push   $0x22
  100c73:	e8 ce fc ff ff       	call   100946 <outb>
  100c78:	83 c4 10             	add    $0x10,%esp
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
  100c7b:	83 ec 0c             	sub    $0xc,%esp
  100c7e:	6a 23                	push   $0x23
  100c80:	e8 a4 fc ff ff       	call   100929 <inb>
  100c85:	83 c4 10             	add    $0x10,%esp
  100c88:	83 c8 01             	or     $0x1,%eax
  100c8b:	0f b6 c0             	movzbl %al,%eax
  100c8e:	83 ec 08             	sub    $0x8,%esp
  100c91:	50                   	push   %eax
  100c92:	6a 23                	push   $0x23
  100c94:	e8 ad fc ff ff       	call   100946 <outb>
  100c99:	83 c4 10             	add    $0x10,%esp
  }
}
  100c9c:	90                   	nop
  100c9d:	c9                   	leave
  100c9e:	c3                   	ret

00100c9f <outb>:
  100c9f:	55                   	push   %ebp
  100ca0:	89 e5                	mov    %esp,%ebp
  100ca2:	83 ec 08             	sub    $0x8,%esp
  100ca5:	8b 55 08             	mov    0x8(%ebp),%edx
  100ca8:	8b 45 0c             	mov    0xc(%ebp),%eax
  100cab:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
  100caf:	88 45 f8             	mov    %al,-0x8(%ebp)
  100cb2:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
  100cb6:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
  100cba:	ee                   	out    %al,(%dx)
  100cbb:	90                   	nop
  100cbc:	c9                   	leave
  100cbd:	c3                   	ret

00100cbe <picinit>:
{
  100cbe:	55                   	push   %ebp
  100cbf:	89 e5                	mov    %esp,%ebp
  outb(IO_PIC1+1, 0xFF);
  100cc1:	68 ff 00 00 00       	push   $0xff
  100cc6:	6a 21                	push   $0x21
  100cc8:	e8 d2 ff ff ff       	call   100c9f <outb>
  100ccd:	83 c4 08             	add    $0x8,%esp
  outb(IO_PIC2+1, 0xFF);
  100cd0:	68 ff 00 00 00       	push   $0xff
  100cd5:	68 a1 00 00 00       	push   $0xa1
  100cda:	e8 c0 ff ff ff       	call   100c9f <outb>
  100cdf:	83 c4 08             	add    $0x8,%esp
  100ce2:	90                   	nop
  100ce3:	c9                   	leave
  100ce4:	c3                   	ret

00100ce5 <inb>:
// Intel 8250 serial port (UART).

#include "types.h"
#include "defs.h"
#include "param.h"
  100ce5:	55                   	push   %ebp
  100ce6:	89 e5                	mov    %esp,%ebp
  100ce8:	83 ec 14             	sub    $0x14,%esp
  100ceb:	8b 45 08             	mov    0x8(%ebp),%eax
  100cee:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
#include "x86.h"
#include "traps.h"

  100cf2:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
  100cf6:	89 c2                	mov    %eax,%edx
  100cf8:	ec                   	in     (%dx),%al
  100cf9:	88 45 ff             	mov    %al,-0x1(%ebp)
#define COM1    0x3f8
  100cfc:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax

  100d00:	c9                   	leave
  100d01:	c3                   	ret

00100d02 <outb>:
  // Turn off the FIFO
  outb(COM1+2, 0);

  // 9600 baud, 8 data bits, 1 stop bit, parity off.
  outb(COM1+3, 0x80);    // Unlock divisor
  outb(COM1+0, 115200/9600);
  100d02:	55                   	push   %ebp
  100d03:	89 e5                	mov    %esp,%ebp
  100d05:	83 ec 08             	sub    $0x8,%esp
  100d08:	8b 55 08             	mov    0x8(%ebp),%edx
  100d0b:	8b 45 0c             	mov    0xc(%ebp),%eax
  100d0e:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
  100d12:	88 45 f8             	mov    %al,-0x8(%ebp)
  outb(COM1+1, 0);
  100d15:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
  100d19:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
  100d1d:	ee                   	out    %al,(%dx)
  outb(COM1+3, 0x03);    // Lock divisor, 8 data bits.
  100d1e:	90                   	nop
  100d1f:	c9                   	leave
  100d20:	c3                   	ret

00100d21 <uartinit>:
{
  100d21:	55                   	push   %ebp
  100d22:	89 e5                	mov    %esp,%ebp
  100d24:	83 ec 18             	sub    $0x18,%esp
  outb(COM1+2, 0);
  100d27:	6a 00                	push   $0x0
  100d29:	68 fa 03 00 00       	push   $0x3fa
  100d2e:	e8 cf ff ff ff       	call   100d02 <outb>
  100d33:	83 c4 08             	add    $0x8,%esp
  outb(COM1+3, 0x80);    // Unlock divisor
  100d36:	68 80 00 00 00       	push   $0x80
  100d3b:	68 fb 03 00 00       	push   $0x3fb
  100d40:	e8 bd ff ff ff       	call   100d02 <outb>
  100d45:	83 c4 08             	add    $0x8,%esp
  outb(COM1+0, 115200/9600);
  100d48:	6a 0c                	push   $0xc
  100d4a:	68 f8 03 00 00       	push   $0x3f8
  100d4f:	e8 ae ff ff ff       	call   100d02 <outb>
  100d54:	83 c4 08             	add    $0x8,%esp
  outb(COM1+1, 0);
  100d57:	6a 00                	push   $0x0
  100d59:	68 f9 03 00 00       	push   $0x3f9
  100d5e:	e8 9f ff ff ff       	call   100d02 <outb>
  100d63:	83 c4 08             	add    $0x8,%esp
  outb(COM1+3, 0x03);    // Lock divisor, 8 data bits.
  100d66:	6a 03                	push   $0x3
  100d68:	68 fb 03 00 00       	push   $0x3fb
  100d6d:	e8 90 ff ff ff       	call   100d02 <outb>
  100d72:	83 c4 08             	add    $0x8,%esp
  outb(COM1+4, 0);
  100d75:	6a 00                	push   $0x0
  100d77:	68 fc 03 00 00       	push   $0x3fc
  100d7c:	e8 81 ff ff ff       	call   100d02 <outb>
  100d81:	83 c4 08             	add    $0x8,%esp
  outb(COM1+1, 0x01);    // Enable receive interrupts.
  100d84:	6a 01                	push   $0x1
  100d86:	68 f9 03 00 00       	push   $0x3f9
  100d8b:	e8 72 ff ff ff       	call   100d02 <outb>
  100d90:	83 c4 08             	add    $0x8,%esp

  // If status is 0xFF, no serial port.
  if(inb(COM1+5) == 0xFF)
  100d93:	68 fd 03 00 00       	push   $0x3fd
  100d98:	e8 48 ff ff ff       	call   100ce5 <inb>
  100d9d:	83 c4 04             	add    $0x4,%esp
  100da0:	3c ff                	cmp    $0xff,%al
  100da2:	74 61                	je     100e05 <uartinit+0xe4>
    return;
  uart = 1;
  100da4:	c7 05 88 6a 10 00 01 	movl   $0x1,0x106a88
  100dab:	00 00 00 

  // Acknowledge pre-existing interrupt conditions;
  // enable interrupts.
  inb(COM1+2);
  100dae:	68 fa 03 00 00       	push   $0x3fa
  100db3:	e8 2d ff ff ff       	call   100ce5 <inb>
  100db8:	83 c4 04             	add    $0x4,%esp
  inb(COM1+0);
  100dbb:	68 f8 03 00 00       	push   $0x3f8
  100dc0:	e8 20 ff ff ff       	call   100ce5 <inb>
  100dc5:	83 c4 04             	add    $0x4,%esp
  ioapicenable(IRQ_COM1, 0);
  100dc8:	83 ec 08             	sub    $0x8,%esp
  100dcb:	6a 00                	push   $0x0
  100dcd:	6a 04                	push   $0x4
  100dcf:	e8 e0 f8 ff ff       	call   1006b4 <ioapicenable>
  100dd4:	83 c4 10             	add    $0x10,%esp

  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
  100dd7:	c7 45 f4 03 57 10 00 	movl   $0x105703,-0xc(%ebp)
  100dde:	eb 19                	jmp    100df9 <uartinit+0xd8>
    uartputc(*p);
  100de0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100de3:	0f b6 00             	movzbl (%eax),%eax
  100de6:	0f be c0             	movsbl %al,%eax
  100de9:	83 ec 0c             	sub    $0xc,%esp
  100dec:	50                   	push   %eax
  100ded:	e8 16 00 00 00       	call   100e08 <uartputc>
  100df2:	83 c4 10             	add    $0x10,%esp
  for(p="xv6...\n"; *p; p++)
  100df5:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  100df9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100dfc:	0f b6 00             	movzbl (%eax),%eax
  100dff:	84 c0                	test   %al,%al
  100e01:	75 dd                	jne    100de0 <uartinit+0xbf>
  100e03:	eb 01                	jmp    100e06 <uartinit+0xe5>
    return;
  100e05:	90                   	nop
}
  100e06:	c9                   	leave
  100e07:	c3                   	ret

00100e08 <uartputc>:

void
uartputc(int c)
{
  100e08:	55                   	push   %ebp
  100e09:	89 e5                	mov    %esp,%ebp
  100e0b:	83 ec 10             	sub    $0x10,%esp
  int i;

  if(!uart)
  100e0e:	a1 88 6a 10 00       	mov    0x106a88,%eax
  100e13:	85 c0                	test   %eax,%eax
  100e15:	74 40                	je     100e57 <uartputc+0x4f>
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++);
  100e17:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  100e1e:	eb 04                	jmp    100e24 <uartputc+0x1c>
  100e20:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  100e24:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%ebp)
  100e28:	7f 17                	jg     100e41 <uartputc+0x39>
  100e2a:	68 fd 03 00 00       	push   $0x3fd
  100e2f:	e8 b1 fe ff ff       	call   100ce5 <inb>
  100e34:	83 c4 04             	add    $0x4,%esp
  100e37:	0f b6 c0             	movzbl %al,%eax
  100e3a:	83 e0 20             	and    $0x20,%eax
  100e3d:	85 c0                	test   %eax,%eax
  100e3f:	74 df                	je     100e20 <uartputc+0x18>
  outb(COM1+0, c);
  100e41:	8b 45 08             	mov    0x8(%ebp),%eax
  100e44:	0f b6 c0             	movzbl %al,%eax
  100e47:	50                   	push   %eax
  100e48:	68 f8 03 00 00       	push   $0x3f8
  100e4d:	e8 b0 fe ff ff       	call   100d02 <outb>
  100e52:	83 c4 08             	add    $0x8,%esp
  100e55:	eb 01                	jmp    100e58 <uartputc+0x50>
    return;
  100e57:	90                   	nop
}
  100e58:	c9                   	leave
  100e59:	c3                   	ret

00100e5a <uartgetc>:


static int
uartgetc(void)
{
  100e5a:	55                   	push   %ebp
  100e5b:	89 e5                	mov    %esp,%ebp
  if(!uart)
  100e5d:	a1 88 6a 10 00       	mov    0x106a88,%eax
  100e62:	85 c0                	test   %eax,%eax
  100e64:	75 07                	jne    100e6d <uartgetc+0x13>
    return -1;
  100e66:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  100e6b:	eb 2e                	jmp    100e9b <uartgetc+0x41>
  if(!(inb(COM1+5) & 0x01))
  100e6d:	68 fd 03 00 00       	push   $0x3fd
  100e72:	e8 6e fe ff ff       	call   100ce5 <inb>
  100e77:	83 c4 04             	add    $0x4,%esp
  100e7a:	0f b6 c0             	movzbl %al,%eax
  100e7d:	83 e0 01             	and    $0x1,%eax
  100e80:	85 c0                	test   %eax,%eax
  100e82:	75 07                	jne    100e8b <uartgetc+0x31>
    return -1;
  100e84:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  100e89:	eb 10                	jmp    100e9b <uartgetc+0x41>
  return inb(COM1+0);
  100e8b:	68 f8 03 00 00       	push   $0x3f8
  100e90:	e8 50 fe ff ff       	call   100ce5 <inb>
  100e95:	83 c4 04             	add    $0x4,%esp
  100e98:	0f b6 c0             	movzbl %al,%eax
}
  100e9b:	c9                   	leave
  100e9c:	c3                   	ret

00100e9d <uartintr>:

void
uartintr(void)
{
  100e9d:	55                   	push   %ebp
  100e9e:	89 e5                	mov    %esp,%ebp
  100ea0:	83 ec 08             	sub    $0x8,%esp
  consoleintr(uartgetc);
  100ea3:	83 ec 0c             	sub    $0xc,%esp
  100ea6:	68 5a 0e 10 00       	push   $0x100e5a
  100eab:	e8 d4 f4 ff ff       	call   100384 <consoleintr>
  100eb0:	83 c4 10             	add    $0x10,%esp
  100eb3:	90                   	nop
  100eb4:	c9                   	leave
  100eb5:	c3                   	ret

00100eb6 <stosb>:
  if(s < d && s + n > d){
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
  100eb6:	55                   	push   %ebp
  100eb7:	89 e5                	mov    %esp,%ebp
  100eb9:	57                   	push   %edi
  100eba:	53                   	push   %ebx
    while(n-- > 0)
  100ebb:	8b 4d 08             	mov    0x8(%ebp),%ecx
  100ebe:	8b 55 10             	mov    0x10(%ebp),%edx
  100ec1:	8b 45 0c             	mov    0xc(%ebp),%eax
  100ec4:	89 cb                	mov    %ecx,%ebx
  100ec6:	89 df                	mov    %ebx,%edi
  100ec8:	89 d1                	mov    %edx,%ecx
  100eca:	fc                   	cld
  100ecb:	f3 aa                	rep stos %al,%es:(%edi)
  100ecd:	89 ca                	mov    %ecx,%edx
  100ecf:	89 fb                	mov    %edi,%ebx
  100ed1:	89 5d 08             	mov    %ebx,0x8(%ebp)
  100ed4:	89 55 10             	mov    %edx,0x10(%ebp)
      *d++ = *s++;

  return dst;
}
  100ed7:	90                   	nop
  100ed8:	5b                   	pop    %ebx
  100ed9:	5f                   	pop    %edi
  100eda:	5d                   	pop    %ebp
  100edb:	c3                   	ret

00100edc <stosl>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
  100edc:	55                   	push   %ebp
  100edd:	89 e5                	mov    %esp,%ebp
  100edf:	57                   	push   %edi
  100ee0:	53                   	push   %ebx
{
  100ee1:	8b 4d 08             	mov    0x8(%ebp),%ecx
  100ee4:	8b 55 10             	mov    0x10(%ebp),%edx
  100ee7:	8b 45 0c             	mov    0xc(%ebp),%eax
  100eea:	89 cb                	mov    %ecx,%ebx
  100eec:	89 df                	mov    %ebx,%edi
  100eee:	89 d1                	mov    %edx,%ecx
  100ef0:	fc                   	cld
  100ef1:	f3 ab                	rep stos %eax,%es:(%edi)
  100ef3:	89 ca                	mov    %ecx,%edx
  100ef5:	89 fb                	mov    %edi,%ebx
  100ef7:	89 5d 08             	mov    %ebx,0x8(%ebp)
  100efa:	89 55 10             	mov    %edx,0x10(%ebp)
  return memmove(dst, src, n);
}

int
  100efd:	90                   	nop
  100efe:	5b                   	pop    %ebx
  100eff:	5f                   	pop    %edi
  100f00:	5d                   	pop    %ebp
  100f01:	c3                   	ret

00100f02 <memset>:
{
  100f02:	55                   	push   %ebp
  100f03:	89 e5                	mov    %esp,%ebp
  if ((int)dst%4 == 0 && n%4 == 0){
  100f05:	8b 45 08             	mov    0x8(%ebp),%eax
  100f08:	83 e0 03             	and    $0x3,%eax
  100f0b:	85 c0                	test   %eax,%eax
  100f0d:	75 43                	jne    100f52 <memset+0x50>
  100f0f:	8b 45 10             	mov    0x10(%ebp),%eax
  100f12:	83 e0 03             	and    $0x3,%eax
  100f15:	85 c0                	test   %eax,%eax
  100f17:	75 39                	jne    100f52 <memset+0x50>
    c &= 0xFF;
  100f19:	81 65 0c ff 00 00 00 	andl   $0xff,0xc(%ebp)
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
  100f20:	8b 45 10             	mov    0x10(%ebp),%eax
  100f23:	c1 e8 02             	shr    $0x2,%eax
  100f26:	89 c1                	mov    %eax,%ecx
  100f28:	8b 45 0c             	mov    0xc(%ebp),%eax
  100f2b:	c1 e0 18             	shl    $0x18,%eax
  100f2e:	89 c2                	mov    %eax,%edx
  100f30:	8b 45 0c             	mov    0xc(%ebp),%eax
  100f33:	c1 e0 10             	shl    $0x10,%eax
  100f36:	09 c2                	or     %eax,%edx
  100f38:	8b 45 0c             	mov    0xc(%ebp),%eax
  100f3b:	c1 e0 08             	shl    $0x8,%eax
  100f3e:	09 d0                	or     %edx,%eax
  100f40:	0b 45 0c             	or     0xc(%ebp),%eax
  100f43:	51                   	push   %ecx
  100f44:	50                   	push   %eax
  100f45:	ff 75 08             	push   0x8(%ebp)
  100f48:	e8 8f ff ff ff       	call   100edc <stosl>
  100f4d:	83 c4 0c             	add    $0xc,%esp
  100f50:	eb 12                	jmp    100f64 <memset+0x62>
    stosb(dst, c, n);
  100f52:	8b 45 10             	mov    0x10(%ebp),%eax
  100f55:	50                   	push   %eax
  100f56:	ff 75 0c             	push   0xc(%ebp)
  100f59:	ff 75 08             	push   0x8(%ebp)
  100f5c:	e8 55 ff ff ff       	call   100eb6 <stosb>
  100f61:	83 c4 0c             	add    $0xc,%esp
  return dst;
  100f64:	8b 45 08             	mov    0x8(%ebp),%eax
}
  100f67:	c9                   	leave
  100f68:	c3                   	ret

00100f69 <memcmp>:
{
  100f69:	55                   	push   %ebp
  100f6a:	89 e5                	mov    %esp,%ebp
  100f6c:	83 ec 10             	sub    $0x10,%esp
  s1 = v1;
  100f6f:	8b 45 08             	mov    0x8(%ebp),%eax
  100f72:	89 45 fc             	mov    %eax,-0x4(%ebp)
  s2 = v2;
  100f75:	8b 45 0c             	mov    0xc(%ebp),%eax
  100f78:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0){
  100f7b:	eb 2e                	jmp    100fab <memcmp+0x42>
    if(*s1 != *s2)
  100f7d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100f80:	0f b6 10             	movzbl (%eax),%edx
  100f83:	8b 45 f8             	mov    -0x8(%ebp),%eax
  100f86:	0f b6 00             	movzbl (%eax),%eax
  100f89:	38 c2                	cmp    %al,%dl
  100f8b:	74 16                	je     100fa3 <memcmp+0x3a>
      return *s1 - *s2;
  100f8d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100f90:	0f b6 00             	movzbl (%eax),%eax
  100f93:	0f b6 d0             	movzbl %al,%edx
  100f96:	8b 45 f8             	mov    -0x8(%ebp),%eax
  100f99:	0f b6 00             	movzbl (%eax),%eax
  100f9c:	0f b6 c0             	movzbl %al,%eax
  100f9f:	29 c2                	sub    %eax,%edx
  100fa1:	eb 1a                	jmp    100fbd <memcmp+0x54>
    s1++, s2++;
  100fa3:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  100fa7:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
  while(n-- > 0){
  100fab:	8b 45 10             	mov    0x10(%ebp),%eax
  100fae:	8d 50 ff             	lea    -0x1(%eax),%edx
  100fb1:	89 55 10             	mov    %edx,0x10(%ebp)
  100fb4:	85 c0                	test   %eax,%eax
  100fb6:	75 c5                	jne    100f7d <memcmp+0x14>
  return 0;
  100fb8:	ba 00 00 00 00       	mov    $0x0,%edx
}
  100fbd:	89 d0                	mov    %edx,%eax
  100fbf:	c9                   	leave
  100fc0:	c3                   	ret

00100fc1 <memmove>:
{
  100fc1:	55                   	push   %ebp
  100fc2:	89 e5                	mov    %esp,%ebp
  100fc4:	83 ec 10             	sub    $0x10,%esp
  s = src;
  100fc7:	8b 45 0c             	mov    0xc(%ebp),%eax
  100fca:	89 45 fc             	mov    %eax,-0x4(%ebp)
  d = dst;
  100fcd:	8b 45 08             	mov    0x8(%ebp),%eax
  100fd0:	89 45 f8             	mov    %eax,-0x8(%ebp)
  if(s < d && s + n > d){
  100fd3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100fd6:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  100fd9:	73 54                	jae    10102f <memmove+0x6e>
  100fdb:	8b 55 fc             	mov    -0x4(%ebp),%edx
  100fde:	8b 45 10             	mov    0x10(%ebp),%eax
  100fe1:	01 d0                	add    %edx,%eax
  100fe3:	39 45 f8             	cmp    %eax,-0x8(%ebp)
  100fe6:	73 47                	jae    10102f <memmove+0x6e>
    s += n;
  100fe8:	8b 45 10             	mov    0x10(%ebp),%eax
  100feb:	01 45 fc             	add    %eax,-0x4(%ebp)
    d += n;
  100fee:	8b 45 10             	mov    0x10(%ebp),%eax
  100ff1:	01 45 f8             	add    %eax,-0x8(%ebp)
    while(n-- > 0)
  100ff4:	eb 13                	jmp    101009 <memmove+0x48>
      *--d = *--s;
  100ff6:	83 6d fc 01          	subl   $0x1,-0x4(%ebp)
  100ffa:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
  100ffe:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101001:	0f b6 10             	movzbl (%eax),%edx
  101004:	8b 45 f8             	mov    -0x8(%ebp),%eax
  101007:	88 10                	mov    %dl,(%eax)
    while(n-- > 0)
  101009:	8b 45 10             	mov    0x10(%ebp),%eax
  10100c:	8d 50 ff             	lea    -0x1(%eax),%edx
  10100f:	89 55 10             	mov    %edx,0x10(%ebp)
  101012:	85 c0                	test   %eax,%eax
  101014:	75 e0                	jne    100ff6 <memmove+0x35>
  if(s < d && s + n > d){
  101016:	eb 24                	jmp    10103c <memmove+0x7b>
      *d++ = *s++;
  101018:	8b 55 fc             	mov    -0x4(%ebp),%edx
  10101b:	8d 42 01             	lea    0x1(%edx),%eax
  10101e:	89 45 fc             	mov    %eax,-0x4(%ebp)
  101021:	8b 45 f8             	mov    -0x8(%ebp),%eax
  101024:	8d 48 01             	lea    0x1(%eax),%ecx
  101027:	89 4d f8             	mov    %ecx,-0x8(%ebp)
  10102a:	0f b6 12             	movzbl (%edx),%edx
  10102d:	88 10                	mov    %dl,(%eax)
    while(n-- > 0)
  10102f:	8b 45 10             	mov    0x10(%ebp),%eax
  101032:	8d 50 ff             	lea    -0x1(%eax),%edx
  101035:	89 55 10             	mov    %edx,0x10(%ebp)
  101038:	85 c0                	test   %eax,%eax
  10103a:	75 dc                	jne    101018 <memmove+0x57>
  return dst;
  10103c:	8b 45 08             	mov    0x8(%ebp),%eax
}
  10103f:	c9                   	leave
  101040:	c3                   	ret

00101041 <memcpy>:
{
  101041:	55                   	push   %ebp
  101042:	89 e5                	mov    %esp,%ebp
  return memmove(dst, src, n);
  101044:	ff 75 10             	push   0x10(%ebp)
  101047:	ff 75 0c             	push   0xc(%ebp)
  10104a:	ff 75 08             	push   0x8(%ebp)
  10104d:	e8 6f ff ff ff       	call   100fc1 <memmove>
  101052:	83 c4 0c             	add    $0xc,%esp
}
  101055:	c9                   	leave
  101056:	c3                   	ret

00101057 <strncmp>:
strncmp(const char *p, const char *q, uint n)
{
  101057:	55                   	push   %ebp
  101058:	89 e5                	mov    %esp,%ebp
  while(n > 0 && *p && *p == *q)
  10105a:	eb 0c                	jmp    101068 <strncmp+0x11>
    n--, p++, q++;
  10105c:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
  101060:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  101064:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  while(n > 0 && *p && *p == *q)
  101068:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  10106c:	74 1a                	je     101088 <strncmp+0x31>
  10106e:	8b 45 08             	mov    0x8(%ebp),%eax
  101071:	0f b6 00             	movzbl (%eax),%eax
  101074:	84 c0                	test   %al,%al
  101076:	74 10                	je     101088 <strncmp+0x31>
  101078:	8b 45 08             	mov    0x8(%ebp),%eax
  10107b:	0f b6 10             	movzbl (%eax),%edx
  10107e:	8b 45 0c             	mov    0xc(%ebp),%eax
  101081:	0f b6 00             	movzbl (%eax),%eax
  101084:	38 c2                	cmp    %al,%dl
  101086:	74 d4                	je     10105c <strncmp+0x5>
  if(n == 0)
  101088:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  10108c:	75 07                	jne    101095 <strncmp+0x3e>
    return 0;
  10108e:	ba 00 00 00 00       	mov    $0x0,%edx
  101093:	eb 14                	jmp    1010a9 <strncmp+0x52>
  return (uchar)*p - (uchar)*q;
  101095:	8b 45 08             	mov    0x8(%ebp),%eax
  101098:	0f b6 00             	movzbl (%eax),%eax
  10109b:	0f b6 d0             	movzbl %al,%edx
  10109e:	8b 45 0c             	mov    0xc(%ebp),%eax
  1010a1:	0f b6 00             	movzbl (%eax),%eax
  1010a4:	0f b6 c0             	movzbl %al,%eax
  1010a7:	29 c2                	sub    %eax,%edx
}
  1010a9:	89 d0                	mov    %edx,%eax
  1010ab:	5d                   	pop    %ebp
  1010ac:	c3                   	ret

001010ad <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
  1010ad:	55                   	push   %ebp
  1010ae:	89 e5                	mov    %esp,%ebp
  1010b0:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
  1010b3:	8b 45 08             	mov    0x8(%ebp),%eax
  1010b6:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while(n-- > 0 && (*s++ = *t++) != 0)
  1010b9:	90                   	nop
  1010ba:	8b 45 10             	mov    0x10(%ebp),%eax
  1010bd:	8d 50 ff             	lea    -0x1(%eax),%edx
  1010c0:	89 55 10             	mov    %edx,0x10(%ebp)
  1010c3:	85 c0                	test   %eax,%eax
  1010c5:	7e 2c                	jle    1010f3 <strncpy+0x46>
  1010c7:	8b 55 0c             	mov    0xc(%ebp),%edx
  1010ca:	8d 42 01             	lea    0x1(%edx),%eax
  1010cd:	89 45 0c             	mov    %eax,0xc(%ebp)
  1010d0:	8b 45 08             	mov    0x8(%ebp),%eax
  1010d3:	8d 48 01             	lea    0x1(%eax),%ecx
  1010d6:	89 4d 08             	mov    %ecx,0x8(%ebp)
  1010d9:	0f b6 12             	movzbl (%edx),%edx
  1010dc:	88 10                	mov    %dl,(%eax)
  1010de:	0f b6 00             	movzbl (%eax),%eax
  1010e1:	84 c0                	test   %al,%al
  1010e3:	75 d5                	jne    1010ba <strncpy+0xd>
    ;
  while(n-- > 0)
  1010e5:	eb 0c                	jmp    1010f3 <strncpy+0x46>
    *s++ = 0;
  1010e7:	8b 45 08             	mov    0x8(%ebp),%eax
  1010ea:	8d 50 01             	lea    0x1(%eax),%edx
  1010ed:	89 55 08             	mov    %edx,0x8(%ebp)
  1010f0:	c6 00 00             	movb   $0x0,(%eax)
  while(n-- > 0)
  1010f3:	8b 45 10             	mov    0x10(%ebp),%eax
  1010f6:	8d 50 ff             	lea    -0x1(%eax),%edx
  1010f9:	89 55 10             	mov    %edx,0x10(%ebp)
  1010fc:	85 c0                	test   %eax,%eax
  1010fe:	7f e7                	jg     1010e7 <strncpy+0x3a>
  return os;
  101100:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  101103:	c9                   	leave
  101104:	c3                   	ret

00101105 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
  101105:	55                   	push   %ebp
  101106:	89 e5                	mov    %esp,%ebp
  101108:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
  10110b:	8b 45 08             	mov    0x8(%ebp),%eax
  10110e:	89 45 fc             	mov    %eax,-0x4(%ebp)
  if(n <= 0)
  101111:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  101115:	7f 05                	jg     10111c <safestrcpy+0x17>
    return os;
  101117:	8b 45 fc             	mov    -0x4(%ebp),%eax
  10111a:	eb 32                	jmp    10114e <safestrcpy+0x49>
  while(--n > 0 && (*s++ = *t++) != 0)
  10111c:	90                   	nop
  10111d:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
  101121:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  101125:	7e 1e                	jle    101145 <safestrcpy+0x40>
  101127:	8b 55 0c             	mov    0xc(%ebp),%edx
  10112a:	8d 42 01             	lea    0x1(%edx),%eax
  10112d:	89 45 0c             	mov    %eax,0xc(%ebp)
  101130:	8b 45 08             	mov    0x8(%ebp),%eax
  101133:	8d 48 01             	lea    0x1(%eax),%ecx
  101136:	89 4d 08             	mov    %ecx,0x8(%ebp)
  101139:	0f b6 12             	movzbl (%edx),%edx
  10113c:	88 10                	mov    %dl,(%eax)
  10113e:	0f b6 00             	movzbl (%eax),%eax
  101141:	84 c0                	test   %al,%al
  101143:	75 d8                	jne    10111d <safestrcpy+0x18>
    ;
  *s = 0;
  101145:	8b 45 08             	mov    0x8(%ebp),%eax
  101148:	c6 00 00             	movb   $0x0,(%eax)
  return os;
  10114b:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  10114e:	c9                   	leave
  10114f:	c3                   	ret

00101150 <strlen>:

int
strlen(const char *s)
{
  101150:	55                   	push   %ebp
  101151:	89 e5                	mov    %esp,%ebp
  101153:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
  101156:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  10115d:	eb 04                	jmp    101163 <strlen+0x13>
  10115f:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  101163:	8b 55 fc             	mov    -0x4(%ebp),%edx
  101166:	8b 45 08             	mov    0x8(%ebp),%eax
  101169:	01 d0                	add    %edx,%eax
  10116b:	0f b6 00             	movzbl (%eax),%eax
  10116e:	84 c0                	test   %al,%al
  101170:	75 ed                	jne    10115f <strlen+0xf>
    ;
  return n;
  101172:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  101175:	c9                   	leave
  101176:	c3                   	ret

00101177 <readeflags>:

static int
find_runnable_index_by_policy(int policy, int last_index)
{
  int i;
  int index;
  101177:	55                   	push   %ebp
  101178:	89 e5                	mov    %esp,%ebp
  10117a:	83 ec 10             	sub    $0x10,%esp

  for(i = 1; i <= NPROC; i++){
  10117d:	9c                   	pushf
  10117e:	58                   	pop    %eax
  10117f:	89 45 fc             	mov    %eax,-0x4(%ebp)
    index = (last_index + i) % NPROC;
  101182:	8b 45 fc             	mov    -0x4(%ebp),%eax
    if(ptable.proc[index].state == RUNNABLE &&
  101185:	c9                   	leave
  101186:	c3                   	ret

00101187 <sti>:
}

// Set up first process.
void
pinit(int pol)
{
  101187:	55                   	push   %ebp
  101188:	89 e5                	mov    %esp,%ebp
  struct proc *p;
  10118a:	fb                   	sti
  extern char _binary_initcode_start[], _binary_initcode_size[];
  10118b:	90                   	nop
  10118c:	5d                   	pop    %ebp
  10118d:	c3                   	ret

0010118e <cpuid>:
cpuid() {
  10118e:	55                   	push   %ebp
  10118f:	89 e5                	mov    %esp,%ebp
  return 0;
  101191:	b8 00 00 00 00       	mov    $0x0,%eax
}
  101196:	5d                   	pop    %ebp
  101197:	c3                   	ret

00101198 <mycpu>:
{
  101198:	55                   	push   %ebp
  101199:	89 e5                	mov    %esp,%ebp
  return &cpus[0];
  10119b:	b8 20 65 10 00       	mov    $0x106520,%eax
}
  1011a0:	5d                   	pop    %ebp
  1011a1:	c3                   	ret

001011a2 <myproc>:
myproc(void) {
  1011a2:	55                   	push   %ebp
  1011a3:	89 e5                	mov    %esp,%ebp
  1011a5:	83 ec 10             	sub    $0x10,%esp
  struct cpu *c = mycpu();
  1011a8:	e8 eb ff ff ff       	call   101198 <mycpu>
  1011ad:	89 45 fc             	mov    %eax,-0x4(%ebp)
  return c->proc;
  1011b0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1011b3:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
}
  1011b9:	c9                   	leave
  1011ba:	c3                   	ret

001011bb <allocproc>:
{
  1011bb:	55                   	push   %ebp
  1011bc:	89 e5                	mov    %esp,%ebp
  1011be:	83 ec 18             	sub    $0x18,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
  1011c1:	c7 45 f4 a0 6a 10 00 	movl   $0x106aa0,-0xc(%ebp)
  1011c8:	eb 0e                	jmp    1011d8 <allocproc+0x1d>
    if(p->state == UNUSED)
  1011ca:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1011cd:	8b 40 0c             	mov    0xc(%eax),%eax
  1011d0:	85 c0                	test   %eax,%eax
  1011d2:	74 17                	je     1011eb <allocproc+0x30>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
  1011d4:	83 45 f4 78          	addl   $0x78,-0xc(%ebp)
  1011d8:	81 7d f4 a0 88 10 00 	cmpl   $0x1088a0,-0xc(%ebp)
  1011df:	72 e9                	jb     1011ca <allocproc+0xf>
  return 0;
  1011e1:	b8 00 00 00 00       	mov    $0x0,%eax
  1011e6:	e9 b6 00 00 00       	jmp    1012a1 <allocproc+0xe6>
      goto found;
  1011eb:	90                   	nop
  p->state = EMBRYO;
  1011ec:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1011ef:	c7 40 0c 01 00 00 00 	movl   $0x1,0xc(%eax)
  p->pid = nextpid++;
  1011f6:	a1 1c 60 10 00       	mov    0x10601c,%eax
  1011fb:	8d 50 01             	lea    0x1(%eax),%edx
  1011fe:	89 15 1c 60 10 00    	mov    %edx,0x10601c
  101204:	8b 55 f4             	mov    -0xc(%ebp),%edx
  101207:	89 42 10             	mov    %eax,0x10(%edx)
  if((p->offset = kalloc()) == 0){
  10120a:	e8 7f 3a 00 00       	call   104c8e <kalloc>
  10120f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  101212:	89 42 04             	mov    %eax,0x4(%edx)
  101215:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101218:	8b 40 04             	mov    0x4(%eax),%eax
  10121b:	85 c0                	test   %eax,%eax
  10121d:	75 11                	jne    101230 <allocproc+0x75>
    p->state = UNUSED;
  10121f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101222:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    return 0;
  101229:	b8 00 00 00 00       	mov    $0x0,%eax
  10122e:	eb 71                	jmp    1012a1 <allocproc+0xe6>
  p->sz = PGSIZE - KSTACKSIZE;
  101230:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101233:	c7 00 00 f0 0f 00    	movl   $0xff000,(%eax)
  sp = (char*)(p->offset + PGSIZE);
  101239:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10123c:	8b 40 04             	mov    0x4(%eax),%eax
  10123f:	05 00 00 10 00       	add    $0x100000,%eax
  101244:	89 45 f0             	mov    %eax,-0x10(%ebp)
  p->kstack = sp - KSTACKSIZE;
  101247:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10124a:	8d 90 00 f0 ff ff    	lea    -0x1000(%eax),%edx
  101250:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101253:	89 50 08             	mov    %edx,0x8(%eax)
  sp -= sizeof *p->tf;
  101256:	83 6d f0 4c          	subl   $0x4c,-0x10(%ebp)
  p->tf = (struct trapframe*)sp;
  10125a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10125d:	8b 55 f0             	mov    -0x10(%ebp),%edx
  101260:	89 50 18             	mov    %edx,0x18(%eax)
  sp -= sizeof *p->context;
  101263:	83 6d f0 14          	subl   $0x14,-0x10(%ebp)
  p->context = (struct context*)sp;
  101267:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10126a:	8b 55 f0             	mov    -0x10(%ebp),%edx
  10126d:	89 50 1c             	mov    %edx,0x1c(%eax)
  memset(p->context, 0, sizeof *p->context);
  101270:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101273:	8b 40 1c             	mov    0x1c(%eax),%eax
  101276:	83 ec 04             	sub    $0x4,%esp
  101279:	6a 14                	push   $0x14
  10127b:	6a 00                	push   $0x0
  10127d:	50                   	push   %eax
  10127e:	e8 7f fc ff ff       	call   100f02 <memset>
  101283:	83 c4 10             	add    $0x10,%esp
  p->context->eip = (uint)trapret;
  101286:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101289:	8b 40 1c             	mov    0x1c(%eax),%eax
  10128c:	ba be 17 10 00       	mov    $0x1017be,%edx
  101291:	89 50 10             	mov    %edx,0x10(%eax)
  p->policy = FG_POLICY;
  101294:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101297:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%eax)
  return p;
  10129e:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  1012a1:	c9                   	leave
  1012a2:	c3                   	ret

001012a3 <find_runnable_index_by_policy>:
{
  1012a3:	55                   	push   %ebp
  1012a4:	89 e5                	mov    %esp,%ebp
  1012a6:	83 ec 10             	sub    $0x10,%esp
  for(i = 1; i <= NPROC; i++){
  1012a9:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
  1012b0:	eb 47                	jmp    1012f9 <find_runnable_index_by_policy+0x56>
    index = (last_index + i) % NPROC;
  1012b2:	8b 55 0c             	mov    0xc(%ebp),%edx
  1012b5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1012b8:	01 c2                	add    %eax,%edx
  1012ba:	89 d0                	mov    %edx,%eax
  1012bc:	c1 f8 1f             	sar    $0x1f,%eax
  1012bf:	c1 e8 1a             	shr    $0x1a,%eax
  1012c2:	01 c2                	add    %eax,%edx
  1012c4:	83 e2 3f             	and    $0x3f,%edx
  1012c7:	29 c2                	sub    %eax,%edx
  1012c9:	89 55 f8             	mov    %edx,-0x8(%ebp)
    if(ptable.proc[index].state == RUNNABLE &&
  1012cc:	8b 45 f8             	mov    -0x8(%ebp),%eax
  1012cf:	6b c0 78             	imul   $0x78,%eax,%eax
  1012d2:	05 ac 6a 10 00       	add    $0x106aac,%eax
  1012d7:	8b 00                	mov    (%eax),%eax
  1012d9:	83 f8 02             	cmp    $0x2,%eax
  1012dc:	75 17                	jne    1012f5 <find_runnable_index_by_policy+0x52>
       ptable.proc[index].policy == policy)
  1012de:	8b 45 f8             	mov    -0x8(%ebp),%eax
  1012e1:	6b c0 78             	imul   $0x78,%eax,%eax
  1012e4:	05 14 6b 10 00       	add    $0x106b14,%eax
  1012e9:	8b 00                	mov    (%eax),%eax
    if(ptable.proc[index].state == RUNNABLE &&
  1012eb:	39 45 08             	cmp    %eax,0x8(%ebp)
  1012ee:	75 05                	jne    1012f5 <find_runnable_index_by_policy+0x52>
      return index;
  1012f0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  1012f3:	eb 0f                	jmp    101304 <find_runnable_index_by_policy+0x61>
  for(i = 1; i <= NPROC; i++){
  1012f5:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  1012f9:	83 7d fc 40          	cmpl   $0x40,-0x4(%ebp)
  1012fd:	7e b3                	jle    1012b2 <find_runnable_index_by_policy+0xf>
  return NO_PROC_INDEX;
  1012ff:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  101304:	c9                   	leave
  101305:	c3                   	ret

00101306 <pinit>:
{
  101306:	55                   	push   %ebp
  101307:	89 e5                	mov    %esp,%ebp
  101309:	83 ec 18             	sub    $0x18,%esp

  p = allocproc();
  10130c:	e8 aa fe ff ff       	call   1011bb <allocproc>
  101311:	89 45 f4             	mov    %eax,-0xc(%ebp)

  memmove(p->offset, _binary_initcode_start, (int)_binary_initcode_size);
  101314:	ba 15 00 00 00       	mov    $0x15,%edx
  101319:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10131c:	8b 40 04             	mov    0x4(%eax),%eax
  10131f:	83 ec 04             	sub    $0x4,%esp
  101322:	52                   	push   %edx
  101323:	68 4c 64 10 00       	push   $0x10644c
  101328:	50                   	push   %eax
  101329:	e8 93 fc ff ff       	call   100fc1 <memmove>
  10132e:	83 c4 10             	add    $0x10,%esp
  memset(p->tf, 0, sizeof(*p->tf));
  101331:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101334:	8b 40 18             	mov    0x18(%eax),%eax
  101337:	83 ec 04             	sub    $0x4,%esp
  10133a:	6a 4c                	push   $0x4c
  10133c:	6a 00                	push   $0x0
  10133e:	50                   	push   %eax
  10133f:	e8 be fb ff ff       	call   100f02 <memset>
  101344:	83 c4 10             	add    $0x10,%esp

  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
  101347:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10134a:	8b 40 18             	mov    0x18(%eax),%eax
  10134d:	66 c7 40 3c 1b 00    	movw   $0x1b,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
  101353:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101356:	8b 40 18             	mov    0x18(%eax),%eax
  101359:	66 c7 40 2c 23 00    	movw   $0x23,0x2c(%eax)
  p->tf->es = p->tf->ds;
  10135f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101362:	8b 50 18             	mov    0x18(%eax),%edx
  101365:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101368:	8b 40 18             	mov    0x18(%eax),%eax
  10136b:	0f b7 52 2c          	movzwl 0x2c(%edx),%edx
  10136f:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
  101373:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101376:	8b 50 18             	mov    0x18(%eax),%edx
  101379:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10137c:	8b 40 18             	mov    0x18(%eax),%eax
  10137f:	0f b7 52 2c          	movzwl 0x2c(%edx),%edx
  101383:	66 89 50 48          	mov    %dx,0x48(%eax)

  p->tf->eflags = FL_IF;
  101387:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10138a:	8b 40 18             	mov    0x18(%eax),%eax
  10138d:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE - KSTACKSIZE;
  101394:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101397:	8b 40 18             	mov    0x18(%eax),%eax
  10139a:	c7 40 44 00 f0 0f 00 	movl   $0xff000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
  1013a1:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1013a4:	8b 40 18             	mov    0x18(%eax),%eax
  1013a7:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)

  safestrcpy(p->name, "initcode", sizeof(p->name));
  1013ae:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1013b1:	83 c0 64             	add    $0x64,%eax
  1013b4:	83 ec 04             	sub    $0x4,%esp
  1013b7:	6a 10                	push   $0x10
  1013b9:	68 0b 57 10 00       	push   $0x10570b
  1013be:	50                   	push   %eax
  1013bf:	e8 41 fd ff ff       	call   101105 <safestrcpy>
  1013c4:	83 c4 10             	add    $0x10,%esp
  p->cwd = namei("/");
  1013c7:	83 ec 0c             	sub    $0xc,%esp
  1013ca:	68 14 57 10 00       	push   $0x105714
  1013cf:	e8 84 26 00 00       	call   103a58 <namei>
  1013d4:	83 c4 10             	add    $0x10,%esp
  1013d7:	8b 55 f4             	mov    -0xc(%ebp),%edx
  1013da:	89 42 60             	mov    %eax,0x60(%edx)
  p->policy = pol;
  1013dd:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1013e0:	8b 55 08             	mov    0x8(%ebp),%edx
  1013e3:	89 50 74             	mov    %edx,0x74(%eax)

  p->state = RUNNABLE;
  1013e6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1013e9:	c7 40 0c 02 00 00 00 	movl   $0x2,0xc(%eax)
}
  1013f0:	90                   	nop
  1013f1:	c9                   	leave
  1013f2:	c3                   	ret

001013f3 <scheduler>:
//  - swtch to start running that process
//  - eventually that process transfers control
//      via swtch back to the scheduler.
void
scheduler(void)
{
  1013f3:	55                   	push   %ebp
  1013f4:	89 e5                	mov    %esp,%ebp
  1013f6:	83 ec 18             	sub    $0x18,%esp
  int index;
  struct proc *p;
  struct cpu *c = mycpu();
  1013f9:	e8 9a fd ff ff       	call   101198 <mycpu>
  1013fe:	89 45 f0             	mov    %eax,-0x10(%ebp)
  int preferred_policy;

  c->proc = 0;
  101401:	8b 45 f0             	mov    -0x10(%ebp),%eax
  101404:	c7 80 a8 00 00 00 00 	movl   $0x0,0xa8(%eax)
  10140b:	00 00 00 
  
  for(;;){
    // Enable interrupts on this processor.
    sti();
  10140e:	e8 74 fd ff ff       	call   101187 <sti>

    preferred_policy = (sched_slot < FG_SLOTS) ? FG_POLICY : BG_POLICY;
  101413:	a1 a0 88 10 00       	mov    0x1088a0,%eax
  101418:	83 f8 08             	cmp    $0x8,%eax
  10141b:	0f 9f c0             	setg   %al
  10141e:	0f b6 c0             	movzbl %al,%eax
  101421:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(preferred_policy == FG_POLICY)
  101424:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  101428:	75 15                	jne    10143f <scheduler+0x4c>
      index = find_runnable_index_by_policy(FG_POLICY, last_fg_index);
  10142a:	a1 14 60 10 00       	mov    0x106014,%eax
  10142f:	50                   	push   %eax
  101430:	6a 00                	push   $0x0
  101432:	e8 6c fe ff ff       	call   1012a3 <find_runnable_index_by_policy>
  101437:	83 c4 08             	add    $0x8,%esp
  10143a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  10143d:	eb 13                	jmp    101452 <scheduler+0x5f>
    else
      index = find_runnable_index_by_policy(BG_POLICY, last_bg_index);
  10143f:	a1 18 60 10 00       	mov    0x106018,%eax
  101444:	50                   	push   %eax
  101445:	6a 01                	push   $0x1
  101447:	e8 57 fe ff ff       	call   1012a3 <find_runnable_index_by_policy>
  10144c:	83 c4 08             	add    $0x8,%esp
  10144f:	89 45 f4             	mov    %eax,-0xc(%ebp)

    if(index == NO_PROC_INDEX){
  101452:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
  101456:	75 2e                	jne    101486 <scheduler+0x93>
      if(preferred_policy == FG_POLICY)
  101458:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  10145c:	75 15                	jne    101473 <scheduler+0x80>
        index = find_runnable_index_by_policy(BG_POLICY, last_bg_index);
  10145e:	a1 18 60 10 00       	mov    0x106018,%eax
  101463:	50                   	push   %eax
  101464:	6a 01                	push   $0x1
  101466:	e8 38 fe ff ff       	call   1012a3 <find_runnable_index_by_policy>
  10146b:	83 c4 08             	add    $0x8,%esp
  10146e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  101471:	eb 13                	jmp    101486 <scheduler+0x93>
      else
        index = find_runnable_index_by_policy(FG_POLICY, last_fg_index);
  101473:	a1 14 60 10 00       	mov    0x106014,%eax
  101478:	50                   	push   %eax
  101479:	6a 00                	push   $0x0
  10147b:	e8 23 fe ff ff       	call   1012a3 <find_runnable_index_by_policy>
  101480:	83 c4 08             	add    $0x8,%esp
  101483:	89 45 f4             	mov    %eax,-0xc(%ebp)
    }

    if(index == NO_PROC_INDEX)
  101486:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
  10148a:	0f 84 9a 00 00 00    	je     10152a <scheduler+0x137>
      continue;

    p = &ptable.proc[index];
  101490:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101493:	6b c0 78             	imul   $0x78,%eax,%eax
  101496:	05 a0 6a 10 00       	add    $0x106aa0,%eax
  10149b:	89 45 e8             	mov    %eax,-0x18(%ebp)

    if(p->policy == FG_POLICY)
  10149e:	8b 45 e8             	mov    -0x18(%ebp),%eax
  1014a1:	8b 40 74             	mov    0x74(%eax),%eax
  1014a4:	85 c0                	test   %eax,%eax
  1014a6:	75 0a                	jne    1014b2 <scheduler+0xbf>
      last_fg_index = index;
  1014a8:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1014ab:	a3 14 60 10 00       	mov    %eax,0x106014
  1014b0:	eb 08                	jmp    1014ba <scheduler+0xc7>
    else
      last_bg_index = index;
  1014b2:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1014b5:	a3 18 60 10 00       	mov    %eax,0x106018

    sched_slot = (sched_slot + 1) % TOTAL_SLOTS;
  1014ba:	a1 a0 88 10 00       	mov    0x1088a0,%eax
  1014bf:	8d 48 01             	lea    0x1(%eax),%ecx
  1014c2:	ba 67 66 66 66       	mov    $0x66666667,%edx
  1014c7:	89 c8                	mov    %ecx,%eax
  1014c9:	f7 ea                	imul   %edx
  1014cb:	c1 fa 02             	sar    $0x2,%edx
  1014ce:	89 c8                	mov    %ecx,%eax
  1014d0:	c1 f8 1f             	sar    $0x1f,%eax
  1014d3:	29 c2                	sub    %eax,%edx
  1014d5:	89 d0                	mov    %edx,%eax
  1014d7:	c1 e0 02             	shl    $0x2,%eax
  1014da:	01 d0                	add    %edx,%eax
  1014dc:	01 c0                	add    %eax,%eax
  1014de:	29 c1                	sub    %eax,%ecx
  1014e0:	89 ca                	mov    %ecx,%edx
  1014e2:	89 15 a0 88 10 00    	mov    %edx,0x1088a0

    // Switch to chosen process.
    c->proc = p;
  1014e8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1014eb:	8b 55 e8             	mov    -0x18(%ebp),%edx
  1014ee:	89 90 a8 00 00 00    	mov    %edx,0xa8(%eax)
    p->state = RUNNING;
  1014f4:	8b 45 e8             	mov    -0x18(%ebp),%eax
  1014f7:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)

    switchuvm(p);
  1014fe:	83 ec 0c             	sub    $0xc,%esp
  101501:	ff 75 e8             	push   -0x18(%ebp)
  101504:	e8 a9 33 00 00       	call   1048b2 <switchuvm>
  101509:	83 c4 10             	add    $0x10,%esp
    swtch(&(c->scheduler), p->context);
  10150c:	8b 45 e8             	mov    -0x18(%ebp),%eax
  10150f:	8b 40 1c             	mov    0x1c(%eax),%eax
  101512:	8b 55 f0             	mov    -0x10(%ebp),%edx
  101515:	83 c2 04             	add    $0x4,%edx
  101518:	83 ec 08             	sub    $0x8,%esp
  10151b:	50                   	push   %eax
  10151c:	52                   	push   %edx
  10151d:	e8 98 31 00 00       	call   1046ba <swtch>
  101522:	83 c4 10             	add    $0x10,%esp
  101525:	e9 e4 fe ff ff       	jmp    10140e <scheduler+0x1b>
      continue;
  10152a:	90                   	nop
    sti();
  10152b:	e9 de fe ff ff       	jmp    10140e <scheduler+0x1b>

00101530 <sched>:
// be proc->intena and proc->ncli, but that would
// break in the few places where a lock is held but
// there's no process.
void
sched(void)
{
  101530:	55                   	push   %ebp
  101531:	89 e5                	mov    %esp,%ebp
  101533:	83 ec 18             	sub    $0x18,%esp
  int intena;
  struct cpu* c = mycpu();
  101536:	e8 5d fc ff ff       	call   101198 <mycpu>
  10153b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  struct proc *p = myproc();
  10153e:	e8 5f fc ff ff       	call   1011a2 <myproc>
  101543:	89 45 f0             	mov    %eax,-0x10(%ebp)

  if(p->state == RUNNING)
  101546:	8b 45 f0             	mov    -0x10(%ebp),%eax
  101549:	8b 40 0c             	mov    0xc(%eax),%eax
  10154c:	83 f8 03             	cmp    $0x3,%eax
  10154f:	75 0d                	jne    10155e <sched+0x2e>
    panic("sched running");
  101551:	83 ec 0c             	sub    $0xc,%esp
  101554:	68 16 57 10 00       	push   $0x105716
  101559:	e8 50 ed ff ff       	call   1002ae <panic>
  if(readeflags()&FL_IF)
  10155e:	e8 14 fc ff ff       	call   101177 <readeflags>
  101563:	25 00 02 00 00       	and    $0x200,%eax
  101568:	85 c0                	test   %eax,%eax
  10156a:	74 0d                	je     101579 <sched+0x49>
    panic("sched interruptible");
  10156c:	83 ec 0c             	sub    $0xc,%esp
  10156f:	68 24 57 10 00       	push   $0x105724
  101574:	e8 35 ed ff ff       	call   1002ae <panic>
  intena = c->intena;
  101579:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10157c:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
  101582:	89 45 ec             	mov    %eax,-0x14(%ebp)
  swtch(&p->context, c->scheduler);
  101585:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101588:	8b 40 04             	mov    0x4(%eax),%eax
  10158b:	8b 55 f0             	mov    -0x10(%ebp),%edx
  10158e:	83 c2 1c             	add    $0x1c,%edx
  101591:	83 ec 08             	sub    $0x8,%esp
  101594:	50                   	push   %eax
  101595:	52                   	push   %edx
  101596:	e8 1f 31 00 00       	call   1046ba <swtch>
  10159b:	83 c4 10             	add    $0x10,%esp
  c->intena = intena;
  10159e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1015a1:	8b 55 ec             	mov    -0x14(%ebp),%edx
  1015a4:	89 90 a4 00 00 00    	mov    %edx,0xa4(%eax)
}
  1015aa:	90                   	nop
  1015ab:	c9                   	leave
  1015ac:	c3                   	ret

001015ad <yield>:

// Give up the CPU for one scheduling round.
void
yield(void)
{
  1015ad:	55                   	push   %ebp
  1015ae:	89 e5                	mov    %esp,%ebp
  1015b0:	83 ec 08             	sub    $0x8,%esp
  myproc()->state = RUNNABLE;
  1015b3:	e8 ea fb ff ff       	call   1011a2 <myproc>
  1015b8:	c7 40 0c 02 00 00 00 	movl   $0x2,0xc(%eax)
  sched();
  1015bf:	e8 6c ff ff ff       	call   101530 <sched>
}
  1015c4:	90                   	nop
  1015c5:	c9                   	leave
  1015c6:	c3                   	ret

001015c7 <procdump>:

void
procdump(void)
{
  1015c7:	55                   	push   %ebp
  1015c8:	89 e5                	mov    %esp,%ebp
  1015ca:	83 ec 18             	sub    $0x18,%esp
  [RUNNING]   "run   ",
  };
  struct proc *p;
  char *state;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
  1015cd:	c7 45 f4 a0 6a 10 00 	movl   $0x106aa0,-0xc(%ebp)
  1015d4:	eb 74                	jmp    10164a <procdump+0x83>
    if(p->state == UNUSED)
  1015d6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1015d9:	8b 40 0c             	mov    0xc(%eax),%eax
  1015dc:	85 c0                	test   %eax,%eax
  1015de:	74 65                	je     101645 <procdump+0x7e>
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
  1015e0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1015e3:	8b 40 0c             	mov    0xc(%eax),%eax
  1015e6:	83 f8 03             	cmp    $0x3,%eax
  1015e9:	77 23                	ja     10160e <procdump+0x47>
  1015eb:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1015ee:	8b 40 0c             	mov    0xc(%eax),%eax
  1015f1:	8b 04 85 20 60 10 00 	mov    0x106020(,%eax,4),%eax
  1015f8:	85 c0                	test   %eax,%eax
  1015fa:	74 12                	je     10160e <procdump+0x47>
      state = states[p->state];
  1015fc:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1015ff:	8b 40 0c             	mov    0xc(%eax),%eax
  101602:	8b 04 85 20 60 10 00 	mov    0x106020(,%eax,4),%eax
  101609:	89 45 f0             	mov    %eax,-0x10(%ebp)
  10160c:	eb 07                	jmp    101615 <procdump+0x4e>
    else
      state = "???";
  10160e:	c7 45 f0 38 57 10 00 	movl   $0x105738,-0x10(%ebp)
    cprintf("%d %s %s", p->pid, state, p->name);
  101615:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101618:	8d 50 64             	lea    0x64(%eax),%edx
  10161b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10161e:	8b 40 10             	mov    0x10(%eax),%eax
  101621:	52                   	push   %edx
  101622:	ff 75 f0             	push   -0x10(%ebp)
  101625:	50                   	push   %eax
  101626:	68 3c 57 10 00       	push   $0x10573c
  10162b:	e8 bc ea ff ff       	call   1000ec <cprintf>
  101630:	83 c4 10             	add    $0x10,%esp
    cprintf("\n");
  101633:	83 ec 0c             	sub    $0xc,%esp
  101636:	68 45 57 10 00       	push   $0x105745
  10163b:	e8 ac ea ff ff       	call   1000ec <cprintf>
  101640:	83 c4 10             	add    $0x10,%esp
  101643:	eb 01                	jmp    101646 <procdump+0x7f>
      continue;
  101645:	90                   	nop
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
  101646:	83 45 f4 78          	addl   $0x78,-0xc(%ebp)
  10164a:	81 7d f4 a0 88 10 00 	cmpl   $0x1088a0,-0xc(%ebp)
  101651:	72 83                	jb     1015d6 <procdump+0xf>
  }
}
  101653:	90                   	nop
  101654:	90                   	nop
  101655:	c9                   	leave
  101656:	c3                   	ret

00101657 <readeflags>:
  101657:	55                   	push   %ebp
  101658:	89 e5                	mov    %esp,%ebp
  10165a:	83 ec 10             	sub    $0x10,%esp
  10165d:	9c                   	pushf
  10165e:	58                   	pop    %eax
  10165f:	89 45 fc             	mov    %eax,-0x4(%ebp)
  101662:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101665:	c9                   	leave
  101666:	c3                   	ret

00101667 <cli>:
  101667:	55                   	push   %ebp
  101668:	89 e5                	mov    %esp,%ebp
  10166a:	fa                   	cli
  10166b:	90                   	nop
  10166c:	5d                   	pop    %ebp
  10166d:	c3                   	ret

0010166e <sti>:
  10166e:	55                   	push   %ebp
  10166f:	89 e5                	mov    %esp,%ebp
  101671:	fb                   	sti
  101672:	90                   	nop
  101673:	5d                   	pop    %ebp
  101674:	c3                   	ret

00101675 <getcallerpcs>:
{
  101675:	55                   	push   %ebp
  101676:	89 e5                	mov    %esp,%ebp
  101678:	83 ec 10             	sub    $0x10,%esp
  ebp = (uint*)v - 2;
  10167b:	8b 45 08             	mov    0x8(%ebp),%eax
  10167e:	83 e8 08             	sub    $0x8,%eax
  101681:	89 45 fc             	mov    %eax,-0x4(%ebp)
  for(i = 0; i < 10; i++){
  101684:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  10168b:	eb 2f                	jmp    1016bc <getcallerpcs+0x47>
    if(ebp == 0 || ebp == (uint*)0xffffffff)
  10168d:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  101691:	74 4a                	je     1016dd <getcallerpcs+0x68>
  101693:	83 7d fc ff          	cmpl   $0xffffffff,-0x4(%ebp)
  101697:	74 44                	je     1016dd <getcallerpcs+0x68>
    pcs[i] = ebp[1];     // saved %eip
  101699:	8b 45 f8             	mov    -0x8(%ebp),%eax
  10169c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  1016a3:	8b 45 0c             	mov    0xc(%ebp),%eax
  1016a6:	01 c2                	add    %eax,%edx
  1016a8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1016ab:	8b 40 04             	mov    0x4(%eax),%eax
  1016ae:	89 02                	mov    %eax,(%edx)
    ebp = (uint*)ebp[0]; // saved %ebp
  1016b0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1016b3:	8b 00                	mov    (%eax),%eax
  1016b5:	89 45 fc             	mov    %eax,-0x4(%ebp)
  for(i = 0; i < 10; i++){
  1016b8:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
  1016bc:	83 7d f8 09          	cmpl   $0x9,-0x8(%ebp)
  1016c0:	7e cb                	jle    10168d <getcallerpcs+0x18>
  for(; i < 10; i++)
  1016c2:	eb 19                	jmp    1016dd <getcallerpcs+0x68>
    pcs[i] = 0;
  1016c4:	8b 45 f8             	mov    -0x8(%ebp),%eax
  1016c7:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  1016ce:	8b 45 0c             	mov    0xc(%ebp),%eax
  1016d1:	01 d0                	add    %edx,%eax
  1016d3:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
  1016d9:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
  1016dd:	83 7d f8 09          	cmpl   $0x9,-0x8(%ebp)
  1016e1:	7e e1                	jle    1016c4 <getcallerpcs+0x4f>
}
  1016e3:	90                   	nop
  1016e4:	90                   	nop
  1016e5:	c9                   	leave
  1016e6:	c3                   	ret

001016e7 <pushcli>:
{
  1016e7:	55                   	push   %ebp
  1016e8:	89 e5                	mov    %esp,%ebp
  1016ea:	83 ec 18             	sub    $0x18,%esp
  eflags = readeflags();
  1016ed:	e8 65 ff ff ff       	call   101657 <readeflags>
  1016f2:	89 45 f4             	mov    %eax,-0xc(%ebp)
  cli();
  1016f5:	e8 6d ff ff ff       	call   101667 <cli>
  if(mycpu()->ncli == 0)
  1016fa:	e8 99 fa ff ff       	call   101198 <mycpu>
  1016ff:	8b 80 a0 00 00 00    	mov    0xa0(%eax),%eax
  101705:	85 c0                	test   %eax,%eax
  101707:	75 14                	jne    10171d <pushcli+0x36>
    mycpu()->intena = eflags & FL_IF;
  101709:	e8 8a fa ff ff       	call   101198 <mycpu>
  10170e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  101711:	81 e2 00 02 00 00    	and    $0x200,%edx
  101717:	89 90 a4 00 00 00    	mov    %edx,0xa4(%eax)
  mycpu()->ncli += 1;
  10171d:	e8 76 fa ff ff       	call   101198 <mycpu>
  101722:	8b 90 a0 00 00 00    	mov    0xa0(%eax),%edx
  101728:	83 c2 01             	add    $0x1,%edx
  10172b:	89 90 a0 00 00 00    	mov    %edx,0xa0(%eax)
}
  101731:	90                   	nop
  101732:	c9                   	leave
  101733:	c3                   	ret

00101734 <popcli>:
{
  101734:	55                   	push   %ebp
  101735:	89 e5                	mov    %esp,%ebp
  101737:	83 ec 08             	sub    $0x8,%esp
  if(readeflags()&FL_IF)
  10173a:	e8 18 ff ff ff       	call   101657 <readeflags>
  10173f:	25 00 02 00 00       	and    $0x200,%eax
  101744:	85 c0                	test   %eax,%eax
  101746:	74 0d                	je     101755 <popcli+0x21>
    panic("popcli - interruptible");
  101748:	83 ec 0c             	sub    $0xc,%esp
  10174b:	68 63 57 10 00       	push   $0x105763
  101750:	e8 59 eb ff ff       	call   1002ae <panic>
  if(--mycpu()->ncli < 0)
  101755:	e8 3e fa ff ff       	call   101198 <mycpu>
  10175a:	8b 90 a0 00 00 00    	mov    0xa0(%eax),%edx
  101760:	83 ea 01             	sub    $0x1,%edx
  101763:	89 90 a0 00 00 00    	mov    %edx,0xa0(%eax)
  101769:	8b 80 a0 00 00 00    	mov    0xa0(%eax),%eax
  10176f:	85 c0                	test   %eax,%eax
  101771:	79 0d                	jns    101780 <popcli+0x4c>
    panic("popcli");
  101773:	83 ec 0c             	sub    $0xc,%esp
  101776:	68 7a 57 10 00       	push   $0x10577a
  10177b:	e8 2e eb ff ff       	call   1002ae <panic>
  if(mycpu()->ncli == 0 && mycpu()->intena)
  101780:	e8 13 fa ff ff       	call   101198 <mycpu>
  101785:	8b 80 a0 00 00 00    	mov    0xa0(%eax),%eax
  10178b:	85 c0                	test   %eax,%eax
  10178d:	75 14                	jne    1017a3 <popcli+0x6f>
  10178f:	e8 04 fa ff ff       	call   101198 <mycpu>
  101794:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
  10179a:	85 c0                	test   %eax,%eax
  10179c:	74 05                	je     1017a3 <popcli+0x6f>
    sti();
  10179e:	e8 cb fe ff ff       	call   10166e <sti>
}
  1017a3:	90                   	nop
  1017a4:	c9                   	leave
  1017a5:	c3                   	ret

001017a6 <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
  1017a6:	1e                   	push   %ds
  pushl %es
  1017a7:	06                   	push   %es
  pushl %fs
  1017a8:	0f a0                	push   %fs
  pushl %gs
  1017aa:	0f a8                	push   %gs
  pushal
  1017ac:	60                   	pusha

  # Set up data segments.
  movw $(SEG_KDATA<<3), %ax  
  1017ad:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
  1017b1:	8e d8                	mov    %eax,%ds
  movw %ax, %es
  1017b3:	8e c0                	mov    %eax,%es
  
  # Call trap(tf), where tf=%esp
  pushl %esp
  1017b5:	54                   	push   %esp
  call trap
  1017b6:	e8 c2 01 00 00       	call   10197d <trap>
  addl $4, %esp
  1017bb:	83 c4 04             	add    $0x4,%esp

001017be <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
  1017be:	61                   	popa
  popl %gs
  1017bf:	0f a9                	pop    %gs
  popl %fs
  1017c1:	0f a1                	pop    %fs
  popl %es
  1017c3:	07                   	pop    %es
  popl %ds
  1017c4:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
  1017c5:	83 c4 08             	add    $0x8,%esp
  iret
  1017c8:	cf                   	iret

001017c9 <lidt>:
  }
}
  1017c9:	55                   	push   %ebp
  1017ca:	89 e5                	mov    %esp,%ebp
  1017cc:	83 ec 10             	sub    $0x10,%esp
  1017cf:	8b 45 0c             	mov    0xc(%ebp),%eax
  1017d2:	83 e8 01             	sub    $0x1,%eax
  1017d5:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  1017d9:	8b 45 08             	mov    0x8(%ebp),%eax
  1017dc:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  1017e0:	8b 45 08             	mov    0x8(%ebp),%eax
  1017e3:	c1 e8 10             	shr    $0x10,%eax
  1017e6:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  1017ea:	8d 45 fa             	lea    -0x6(%ebp),%eax
  1017ed:	0f 01 18             	lidtl  (%eax)
  1017f0:	90                   	nop
  1017f1:	c9                   	leave
  1017f2:	c3                   	ret

001017f3 <rcr2>:
  1017f3:	55                   	push   %ebp
  1017f4:	89 e5                	mov    %esp,%ebp
  1017f6:	83 ec 10             	sub    $0x10,%esp
  1017f9:	0f 20 d0             	mov    %cr2,%eax
  1017fc:	89 45 fc             	mov    %eax,-0x4(%ebp)
  1017ff:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101802:	c9                   	leave
  101803:	c3                   	ret

00101804 <tvinit>:
{
  101804:	55                   	push   %ebp
  101805:	89 e5                	mov    %esp,%ebp
  101807:	83 ec 10             	sub    $0x10,%esp
  for(i = 0; i < 256; i++)
  10180a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  101811:	e9 c3 00 00 00       	jmp    1018d9 <tvinit+0xd5>
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  101816:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101819:	8b 04 85 30 60 10 00 	mov    0x106030(,%eax,4),%eax
  101820:	89 c2                	mov    %eax,%edx
  101822:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101825:	66 89 14 c5 c0 88 10 	mov    %dx,0x1088c0(,%eax,8)
  10182c:	00 
  10182d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101830:	66 c7 04 c5 c2 88 10 	movw   $0x8,0x1088c2(,%eax,8)
  101837:	00 08 00 
  10183a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  10183d:	0f b6 14 c5 c4 88 10 	movzbl 0x1088c4(,%eax,8),%edx
  101844:	00 
  101845:	83 e2 e0             	and    $0xffffffe0,%edx
  101848:	88 14 c5 c4 88 10 00 	mov    %dl,0x1088c4(,%eax,8)
  10184f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101852:	0f b6 14 c5 c4 88 10 	movzbl 0x1088c4(,%eax,8),%edx
  101859:	00 
  10185a:	83 e2 1f             	and    $0x1f,%edx
  10185d:	88 14 c5 c4 88 10 00 	mov    %dl,0x1088c4(,%eax,8)
  101864:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101867:	0f b6 14 c5 c5 88 10 	movzbl 0x1088c5(,%eax,8),%edx
  10186e:	00 
  10186f:	83 e2 f0             	and    $0xfffffff0,%edx
  101872:	83 ca 0e             	or     $0xe,%edx
  101875:	88 14 c5 c5 88 10 00 	mov    %dl,0x1088c5(,%eax,8)
  10187c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  10187f:	0f b6 14 c5 c5 88 10 	movzbl 0x1088c5(,%eax,8),%edx
  101886:	00 
  101887:	83 e2 ef             	and    $0xffffffef,%edx
  10188a:	88 14 c5 c5 88 10 00 	mov    %dl,0x1088c5(,%eax,8)
  101891:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101894:	0f b6 14 c5 c5 88 10 	movzbl 0x1088c5(,%eax,8),%edx
  10189b:	00 
  10189c:	83 e2 9f             	and    $0xffffff9f,%edx
  10189f:	88 14 c5 c5 88 10 00 	mov    %dl,0x1088c5(,%eax,8)
  1018a6:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1018a9:	0f b6 14 c5 c5 88 10 	movzbl 0x1088c5(,%eax,8),%edx
  1018b0:	00 
  1018b1:	83 ca 80             	or     $0xffffff80,%edx
  1018b4:	88 14 c5 c5 88 10 00 	mov    %dl,0x1088c5(,%eax,8)
  1018bb:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1018be:	8b 04 85 30 60 10 00 	mov    0x106030(,%eax,4),%eax
  1018c5:	c1 e8 10             	shr    $0x10,%eax
  1018c8:	89 c2                	mov    %eax,%edx
  1018ca:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1018cd:	66 89 14 c5 c6 88 10 	mov    %dx,0x1088c6(,%eax,8)
  1018d4:	00 
  for(i = 0; i < 256; i++)
  1018d5:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  1018d9:	81 7d fc ff 00 00 00 	cmpl   $0xff,-0x4(%ebp)
  1018e0:	0f 8e 30 ff ff ff    	jle    101816 <tvinit+0x12>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
  1018e6:	a1 30 61 10 00       	mov    0x106130,%eax
  1018eb:	66 a3 c0 8a 10 00    	mov    %ax,0x108ac0
  1018f1:	66 c7 05 c2 8a 10 00 	movw   $0x8,0x108ac2
  1018f8:	08 00 
  1018fa:	0f b6 05 c4 8a 10 00 	movzbl 0x108ac4,%eax
  101901:	83 e0 e0             	and    $0xffffffe0,%eax
  101904:	a2 c4 8a 10 00       	mov    %al,0x108ac4
  101909:	0f b6 05 c4 8a 10 00 	movzbl 0x108ac4,%eax
  101910:	83 e0 1f             	and    $0x1f,%eax
  101913:	a2 c4 8a 10 00       	mov    %al,0x108ac4
  101918:	0f b6 05 c5 8a 10 00 	movzbl 0x108ac5,%eax
  10191f:	83 c8 0f             	or     $0xf,%eax
  101922:	a2 c5 8a 10 00       	mov    %al,0x108ac5
  101927:	0f b6 05 c5 8a 10 00 	movzbl 0x108ac5,%eax
  10192e:	83 e0 ef             	and    $0xffffffef,%eax
  101931:	a2 c5 8a 10 00       	mov    %al,0x108ac5
  101936:	0f b6 05 c5 8a 10 00 	movzbl 0x108ac5,%eax
  10193d:	83 c8 60             	or     $0x60,%eax
  101940:	a2 c5 8a 10 00       	mov    %al,0x108ac5
  101945:	0f b6 05 c5 8a 10 00 	movzbl 0x108ac5,%eax
  10194c:	83 c8 80             	or     $0xffffff80,%eax
  10194f:	a2 c5 8a 10 00       	mov    %al,0x108ac5
  101954:	a1 30 61 10 00       	mov    0x106130,%eax
  101959:	c1 e8 10             	shr    $0x10,%eax
  10195c:	66 a3 c6 8a 10 00    	mov    %ax,0x108ac6
}
  101962:	90                   	nop
  101963:	c9                   	leave
  101964:	c3                   	ret

00101965 <idtinit>:
{
  101965:	55                   	push   %ebp
  101966:	89 e5                	mov    %esp,%ebp
  lidt(idt, sizeof(idt));
  101968:	68 00 08 00 00       	push   $0x800
  10196d:	68 c0 88 10 00       	push   $0x1088c0
  101972:	e8 52 fe ff ff       	call   1017c9 <lidt>
  101977:	83 c4 08             	add    $0x8,%esp
}
  10197a:	90                   	nop
  10197b:	c9                   	leave
  10197c:	c3                   	ret

0010197d <trap>:
{
  10197d:	55                   	push   %ebp
  10197e:	89 e5                	mov    %esp,%ebp
  101980:	56                   	push   %esi
  101981:	53                   	push   %ebx
  if(tf->trapno == T_SYSCALL){
  101982:	8b 45 08             	mov    0x8(%ebp),%eax
  101985:	8b 40 30             	mov    0x30(%eax),%eax
  101988:	83 f8 40             	cmp    $0x40,%eax
  10198b:	75 15                	jne    1019a2 <trap+0x25>
    myproc()->tf = tf;
  10198d:	e8 10 f8 ff ff       	call   1011a2 <myproc>
  101992:	8b 55 08             	mov    0x8(%ebp),%edx
  101995:	89 50 18             	mov    %edx,0x18(%eax)
    syscall();
  101998:	e8 a5 34 00 00       	call   104e42 <syscall>
    return;
  10199d:	e9 ee 00 00 00       	jmp    101a90 <trap+0x113>
  switch(tf->trapno){
  1019a2:	8b 45 08             	mov    0x8(%ebp),%eax
  1019a5:	8b 40 30             	mov    0x30(%eax),%eax
  1019a8:	83 e8 20             	sub    $0x20,%eax
  1019ab:	83 f8 1f             	cmp    $0x1f,%eax
  1019ae:	77 67                	ja     101a17 <trap+0x9a>
  1019b0:	8b 04 85 e0 57 10 00 	mov    0x1057e0(,%eax,4),%eax
  1019b7:	ff e0                	jmp    *%eax
    ticks++;
  1019b9:	a1 c0 90 10 00       	mov    0x1090c0,%eax
  1019be:	83 c0 01             	add    $0x1,%eax
  1019c1:	a3 c0 90 10 00       	mov    %eax,0x1090c0
    lapiceoi();
  1019c6:	e8 86 ee ff ff       	call   100851 <lapiceoi>
    break;
  1019cb:	e9 9a 00 00 00       	jmp    101a6a <trap+0xed>
    ideintr();
  1019d0:	e8 03 10 00 00       	call   1029d8 <ideintr>
    lapiceoi();
  1019d5:	e8 77 ee ff ff       	call   100851 <lapiceoi>
    break;
  1019da:	e9 8b 00 00 00       	jmp    101a6a <trap+0xed>
    uartintr();
  1019df:	e8 b9 f4 ff ff       	call   100e9d <uartintr>
    lapiceoi();
  1019e4:	e8 68 ee ff ff       	call   100851 <lapiceoi>
    break;
  1019e9:	eb 7f                	jmp    101a6a <trap+0xed>
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
  1019eb:	8b 45 08             	mov    0x8(%ebp),%eax
  1019ee:	8b 70 38             	mov    0x38(%eax),%esi
            cpuid(), tf->cs, tf->eip);
  1019f1:	8b 45 08             	mov    0x8(%ebp),%eax
  1019f4:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
  1019f8:	0f b7 d8             	movzwl %ax,%ebx
  1019fb:	e8 8e f7 ff ff       	call   10118e <cpuid>
  101a00:	56                   	push   %esi
  101a01:	53                   	push   %ebx
  101a02:	50                   	push   %eax
  101a03:	68 84 57 10 00       	push   $0x105784
  101a08:	e8 df e6 ff ff       	call   1000ec <cprintf>
  101a0d:	83 c4 10             	add    $0x10,%esp
    lapiceoi();
  101a10:	e8 3c ee ff ff       	call   100851 <lapiceoi>
    break;
  101a15:	eb 53                	jmp    101a6a <trap+0xed>
    if(myproc() == 0 || (tf->cs&3) == 0){
  101a17:	e8 86 f7 ff ff       	call   1011a2 <myproc>
  101a1c:	85 c0                	test   %eax,%eax
  101a1e:	74 11                	je     101a31 <trap+0xb4>
  101a20:	8b 45 08             	mov    0x8(%ebp),%eax
  101a23:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
  101a27:	0f b7 c0             	movzwl %ax,%eax
  101a2a:	83 e0 03             	and    $0x3,%eax
  101a2d:	85 c0                	test   %eax,%eax
  101a2f:	75 39                	jne    101a6a <trap+0xed>
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
  101a31:	e8 bd fd ff ff       	call   1017f3 <rcr2>
  101a36:	89 c3                	mov    %eax,%ebx
  101a38:	8b 45 08             	mov    0x8(%ebp),%eax
  101a3b:	8b 70 38             	mov    0x38(%eax),%esi
  101a3e:	e8 4b f7 ff ff       	call   10118e <cpuid>
  101a43:	8b 55 08             	mov    0x8(%ebp),%edx
  101a46:	8b 52 30             	mov    0x30(%edx),%edx
  101a49:	83 ec 0c             	sub    $0xc,%esp
  101a4c:	53                   	push   %ebx
  101a4d:	56                   	push   %esi
  101a4e:	50                   	push   %eax
  101a4f:	52                   	push   %edx
  101a50:	68 a8 57 10 00       	push   $0x1057a8
  101a55:	e8 92 e6 ff ff       	call   1000ec <cprintf>
  101a5a:	83 c4 20             	add    $0x20,%esp
      panic("trap");
  101a5d:	83 ec 0c             	sub    $0xc,%esp
  101a60:	68 da 57 10 00       	push   $0x1057da
  101a65:	e8 44 e8 ff ff       	call   1002ae <panic>
  if(myproc() && myproc()->state == RUNNING &&
  101a6a:	e8 33 f7 ff ff       	call   1011a2 <myproc>
  101a6f:	85 c0                	test   %eax,%eax
  101a71:	74 1d                	je     101a90 <trap+0x113>
  101a73:	e8 2a f7 ff ff       	call   1011a2 <myproc>
  101a78:	8b 40 0c             	mov    0xc(%eax),%eax
  101a7b:	83 f8 03             	cmp    $0x3,%eax
  101a7e:	75 10                	jne    101a90 <trap+0x113>
    tf->trapno == T_IRQ0+IRQ_TIMER) {
  101a80:	8b 45 08             	mov    0x8(%ebp),%eax
  101a83:	8b 40 30             	mov    0x30(%eax),%eax
  if(myproc() && myproc()->state == RUNNING &&
  101a86:	83 f8 20             	cmp    $0x20,%eax
  101a89:	75 05                	jne    101a90 <trap+0x113>
    yield();
  101a8b:	e8 1d fb ff ff       	call   1015ad <yield>
}
  101a90:	8d 65 f8             	lea    -0x8(%ebp),%esp
  101a93:	5b                   	pop    %ebx
  101a94:	5e                   	pop    %esi
  101a95:	5d                   	pop    %ebp
  101a96:	c3                   	ret

00101a97 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
  101a97:	6a 00                	push   $0x0
  pushl $0
  101a99:	6a 00                	push   $0x0
  jmp alltraps
  101a9b:	e9 06 fd ff ff       	jmp    1017a6 <alltraps>

00101aa0 <vector1>:
.globl vector1
vector1:
  pushl $0
  101aa0:	6a 00                	push   $0x0
  pushl $1
  101aa2:	6a 01                	push   $0x1
  jmp alltraps
  101aa4:	e9 fd fc ff ff       	jmp    1017a6 <alltraps>

00101aa9 <vector2>:
.globl vector2
vector2:
  pushl $0
  101aa9:	6a 00                	push   $0x0
  pushl $2
  101aab:	6a 02                	push   $0x2
  jmp alltraps
  101aad:	e9 f4 fc ff ff       	jmp    1017a6 <alltraps>

00101ab2 <vector3>:
.globl vector3
vector3:
  pushl $0
  101ab2:	6a 00                	push   $0x0
  pushl $3
  101ab4:	6a 03                	push   $0x3
  jmp alltraps
  101ab6:	e9 eb fc ff ff       	jmp    1017a6 <alltraps>

00101abb <vector4>:
.globl vector4
vector4:
  pushl $0
  101abb:	6a 00                	push   $0x0
  pushl $4
  101abd:	6a 04                	push   $0x4
  jmp alltraps
  101abf:	e9 e2 fc ff ff       	jmp    1017a6 <alltraps>

00101ac4 <vector5>:
.globl vector5
vector5:
  pushl $0
  101ac4:	6a 00                	push   $0x0
  pushl $5
  101ac6:	6a 05                	push   $0x5
  jmp alltraps
  101ac8:	e9 d9 fc ff ff       	jmp    1017a6 <alltraps>

00101acd <vector6>:
.globl vector6
vector6:
  pushl $0
  101acd:	6a 00                	push   $0x0
  pushl $6
  101acf:	6a 06                	push   $0x6
  jmp alltraps
  101ad1:	e9 d0 fc ff ff       	jmp    1017a6 <alltraps>

00101ad6 <vector7>:
.globl vector7
vector7:
  pushl $0
  101ad6:	6a 00                	push   $0x0
  pushl $7
  101ad8:	6a 07                	push   $0x7
  jmp alltraps
  101ada:	e9 c7 fc ff ff       	jmp    1017a6 <alltraps>

00101adf <vector8>:
.globl vector8
vector8:
  pushl $8
  101adf:	6a 08                	push   $0x8
  jmp alltraps
  101ae1:	e9 c0 fc ff ff       	jmp    1017a6 <alltraps>

00101ae6 <vector9>:
.globl vector9
vector9:
  pushl $0
  101ae6:	6a 00                	push   $0x0
  pushl $9
  101ae8:	6a 09                	push   $0x9
  jmp alltraps
  101aea:	e9 b7 fc ff ff       	jmp    1017a6 <alltraps>

00101aef <vector10>:
.globl vector10
vector10:
  pushl $10
  101aef:	6a 0a                	push   $0xa
  jmp alltraps
  101af1:	e9 b0 fc ff ff       	jmp    1017a6 <alltraps>

00101af6 <vector11>:
.globl vector11
vector11:
  pushl $11
  101af6:	6a 0b                	push   $0xb
  jmp alltraps
  101af8:	e9 a9 fc ff ff       	jmp    1017a6 <alltraps>

00101afd <vector12>:
.globl vector12
vector12:
  pushl $12
  101afd:	6a 0c                	push   $0xc
  jmp alltraps
  101aff:	e9 a2 fc ff ff       	jmp    1017a6 <alltraps>

00101b04 <vector13>:
.globl vector13
vector13:
  pushl $13
  101b04:	6a 0d                	push   $0xd
  jmp alltraps
  101b06:	e9 9b fc ff ff       	jmp    1017a6 <alltraps>

00101b0b <vector14>:
.globl vector14
vector14:
  pushl $14
  101b0b:	6a 0e                	push   $0xe
  jmp alltraps
  101b0d:	e9 94 fc ff ff       	jmp    1017a6 <alltraps>

00101b12 <vector15>:
.globl vector15
vector15:
  pushl $0
  101b12:	6a 00                	push   $0x0
  pushl $15
  101b14:	6a 0f                	push   $0xf
  jmp alltraps
  101b16:	e9 8b fc ff ff       	jmp    1017a6 <alltraps>

00101b1b <vector16>:
.globl vector16
vector16:
  pushl $0
  101b1b:	6a 00                	push   $0x0
  pushl $16
  101b1d:	6a 10                	push   $0x10
  jmp alltraps
  101b1f:	e9 82 fc ff ff       	jmp    1017a6 <alltraps>

00101b24 <vector17>:
.globl vector17
vector17:
  pushl $17
  101b24:	6a 11                	push   $0x11
  jmp alltraps
  101b26:	e9 7b fc ff ff       	jmp    1017a6 <alltraps>

00101b2b <vector18>:
.globl vector18
vector18:
  pushl $0
  101b2b:	6a 00                	push   $0x0
  pushl $18
  101b2d:	6a 12                	push   $0x12
  jmp alltraps
  101b2f:	e9 72 fc ff ff       	jmp    1017a6 <alltraps>

00101b34 <vector19>:
.globl vector19
vector19:
  pushl $0
  101b34:	6a 00                	push   $0x0
  pushl $19
  101b36:	6a 13                	push   $0x13
  jmp alltraps
  101b38:	e9 69 fc ff ff       	jmp    1017a6 <alltraps>

00101b3d <vector20>:
.globl vector20
vector20:
  pushl $0
  101b3d:	6a 00                	push   $0x0
  pushl $20
  101b3f:	6a 14                	push   $0x14
  jmp alltraps
  101b41:	e9 60 fc ff ff       	jmp    1017a6 <alltraps>

00101b46 <vector21>:
.globl vector21
vector21:
  pushl $0
  101b46:	6a 00                	push   $0x0
  pushl $21
  101b48:	6a 15                	push   $0x15
  jmp alltraps
  101b4a:	e9 57 fc ff ff       	jmp    1017a6 <alltraps>

00101b4f <vector22>:
.globl vector22
vector22:
  pushl $0
  101b4f:	6a 00                	push   $0x0
  pushl $22
  101b51:	6a 16                	push   $0x16
  jmp alltraps
  101b53:	e9 4e fc ff ff       	jmp    1017a6 <alltraps>

00101b58 <vector23>:
.globl vector23
vector23:
  pushl $0
  101b58:	6a 00                	push   $0x0
  pushl $23
  101b5a:	6a 17                	push   $0x17
  jmp alltraps
  101b5c:	e9 45 fc ff ff       	jmp    1017a6 <alltraps>

00101b61 <vector24>:
.globl vector24
vector24:
  pushl $0
  101b61:	6a 00                	push   $0x0
  pushl $24
  101b63:	6a 18                	push   $0x18
  jmp alltraps
  101b65:	e9 3c fc ff ff       	jmp    1017a6 <alltraps>

00101b6a <vector25>:
.globl vector25
vector25:
  pushl $0
  101b6a:	6a 00                	push   $0x0
  pushl $25
  101b6c:	6a 19                	push   $0x19
  jmp alltraps
  101b6e:	e9 33 fc ff ff       	jmp    1017a6 <alltraps>

00101b73 <vector26>:
.globl vector26
vector26:
  pushl $0
  101b73:	6a 00                	push   $0x0
  pushl $26
  101b75:	6a 1a                	push   $0x1a
  jmp alltraps
  101b77:	e9 2a fc ff ff       	jmp    1017a6 <alltraps>

00101b7c <vector27>:
.globl vector27
vector27:
  pushl $0
  101b7c:	6a 00                	push   $0x0
  pushl $27
  101b7e:	6a 1b                	push   $0x1b
  jmp alltraps
  101b80:	e9 21 fc ff ff       	jmp    1017a6 <alltraps>

00101b85 <vector28>:
.globl vector28
vector28:
  pushl $0
  101b85:	6a 00                	push   $0x0
  pushl $28
  101b87:	6a 1c                	push   $0x1c
  jmp alltraps
  101b89:	e9 18 fc ff ff       	jmp    1017a6 <alltraps>

00101b8e <vector29>:
.globl vector29
vector29:
  pushl $0
  101b8e:	6a 00                	push   $0x0
  pushl $29
  101b90:	6a 1d                	push   $0x1d
  jmp alltraps
  101b92:	e9 0f fc ff ff       	jmp    1017a6 <alltraps>

00101b97 <vector30>:
.globl vector30
vector30:
  pushl $0
  101b97:	6a 00                	push   $0x0
  pushl $30
  101b99:	6a 1e                	push   $0x1e
  jmp alltraps
  101b9b:	e9 06 fc ff ff       	jmp    1017a6 <alltraps>

00101ba0 <vector31>:
.globl vector31
vector31:
  pushl $0
  101ba0:	6a 00                	push   $0x0
  pushl $31
  101ba2:	6a 1f                	push   $0x1f
  jmp alltraps
  101ba4:	e9 fd fb ff ff       	jmp    1017a6 <alltraps>

00101ba9 <vector32>:
.globl vector32
vector32:
  pushl $0
  101ba9:	6a 00                	push   $0x0
  pushl $32
  101bab:	6a 20                	push   $0x20
  jmp alltraps
  101bad:	e9 f4 fb ff ff       	jmp    1017a6 <alltraps>

00101bb2 <vector33>:
.globl vector33
vector33:
  pushl $0
  101bb2:	6a 00                	push   $0x0
  pushl $33
  101bb4:	6a 21                	push   $0x21
  jmp alltraps
  101bb6:	e9 eb fb ff ff       	jmp    1017a6 <alltraps>

00101bbb <vector34>:
.globl vector34
vector34:
  pushl $0
  101bbb:	6a 00                	push   $0x0
  pushl $34
  101bbd:	6a 22                	push   $0x22
  jmp alltraps
  101bbf:	e9 e2 fb ff ff       	jmp    1017a6 <alltraps>

00101bc4 <vector35>:
.globl vector35
vector35:
  pushl $0
  101bc4:	6a 00                	push   $0x0
  pushl $35
  101bc6:	6a 23                	push   $0x23
  jmp alltraps
  101bc8:	e9 d9 fb ff ff       	jmp    1017a6 <alltraps>

00101bcd <vector36>:
.globl vector36
vector36:
  pushl $0
  101bcd:	6a 00                	push   $0x0
  pushl $36
  101bcf:	6a 24                	push   $0x24
  jmp alltraps
  101bd1:	e9 d0 fb ff ff       	jmp    1017a6 <alltraps>

00101bd6 <vector37>:
.globl vector37
vector37:
  pushl $0
  101bd6:	6a 00                	push   $0x0
  pushl $37
  101bd8:	6a 25                	push   $0x25
  jmp alltraps
  101bda:	e9 c7 fb ff ff       	jmp    1017a6 <alltraps>

00101bdf <vector38>:
.globl vector38
vector38:
  pushl $0
  101bdf:	6a 00                	push   $0x0
  pushl $38
  101be1:	6a 26                	push   $0x26
  jmp alltraps
  101be3:	e9 be fb ff ff       	jmp    1017a6 <alltraps>

00101be8 <vector39>:
.globl vector39
vector39:
  pushl $0
  101be8:	6a 00                	push   $0x0
  pushl $39
  101bea:	6a 27                	push   $0x27
  jmp alltraps
  101bec:	e9 b5 fb ff ff       	jmp    1017a6 <alltraps>

00101bf1 <vector40>:
.globl vector40
vector40:
  pushl $0
  101bf1:	6a 00                	push   $0x0
  pushl $40
  101bf3:	6a 28                	push   $0x28
  jmp alltraps
  101bf5:	e9 ac fb ff ff       	jmp    1017a6 <alltraps>

00101bfa <vector41>:
.globl vector41
vector41:
  pushl $0
  101bfa:	6a 00                	push   $0x0
  pushl $41
  101bfc:	6a 29                	push   $0x29
  jmp alltraps
  101bfe:	e9 a3 fb ff ff       	jmp    1017a6 <alltraps>

00101c03 <vector42>:
.globl vector42
vector42:
  pushl $0
  101c03:	6a 00                	push   $0x0
  pushl $42
  101c05:	6a 2a                	push   $0x2a
  jmp alltraps
  101c07:	e9 9a fb ff ff       	jmp    1017a6 <alltraps>

00101c0c <vector43>:
.globl vector43
vector43:
  pushl $0
  101c0c:	6a 00                	push   $0x0
  pushl $43
  101c0e:	6a 2b                	push   $0x2b
  jmp alltraps
  101c10:	e9 91 fb ff ff       	jmp    1017a6 <alltraps>

00101c15 <vector44>:
.globl vector44
vector44:
  pushl $0
  101c15:	6a 00                	push   $0x0
  pushl $44
  101c17:	6a 2c                	push   $0x2c
  jmp alltraps
  101c19:	e9 88 fb ff ff       	jmp    1017a6 <alltraps>

00101c1e <vector45>:
.globl vector45
vector45:
  pushl $0
  101c1e:	6a 00                	push   $0x0
  pushl $45
  101c20:	6a 2d                	push   $0x2d
  jmp alltraps
  101c22:	e9 7f fb ff ff       	jmp    1017a6 <alltraps>

00101c27 <vector46>:
.globl vector46
vector46:
  pushl $0
  101c27:	6a 00                	push   $0x0
  pushl $46
  101c29:	6a 2e                	push   $0x2e
  jmp alltraps
  101c2b:	e9 76 fb ff ff       	jmp    1017a6 <alltraps>

00101c30 <vector47>:
.globl vector47
vector47:
  pushl $0
  101c30:	6a 00                	push   $0x0
  pushl $47
  101c32:	6a 2f                	push   $0x2f
  jmp alltraps
  101c34:	e9 6d fb ff ff       	jmp    1017a6 <alltraps>

00101c39 <vector48>:
.globl vector48
vector48:
  pushl $0
  101c39:	6a 00                	push   $0x0
  pushl $48
  101c3b:	6a 30                	push   $0x30
  jmp alltraps
  101c3d:	e9 64 fb ff ff       	jmp    1017a6 <alltraps>

00101c42 <vector49>:
.globl vector49
vector49:
  pushl $0
  101c42:	6a 00                	push   $0x0
  pushl $49
  101c44:	6a 31                	push   $0x31
  jmp alltraps
  101c46:	e9 5b fb ff ff       	jmp    1017a6 <alltraps>

00101c4b <vector50>:
.globl vector50
vector50:
  pushl $0
  101c4b:	6a 00                	push   $0x0
  pushl $50
  101c4d:	6a 32                	push   $0x32
  jmp alltraps
  101c4f:	e9 52 fb ff ff       	jmp    1017a6 <alltraps>

00101c54 <vector51>:
.globl vector51
vector51:
  pushl $0
  101c54:	6a 00                	push   $0x0
  pushl $51
  101c56:	6a 33                	push   $0x33
  jmp alltraps
  101c58:	e9 49 fb ff ff       	jmp    1017a6 <alltraps>

00101c5d <vector52>:
.globl vector52
vector52:
  pushl $0
  101c5d:	6a 00                	push   $0x0
  pushl $52
  101c5f:	6a 34                	push   $0x34
  jmp alltraps
  101c61:	e9 40 fb ff ff       	jmp    1017a6 <alltraps>

00101c66 <vector53>:
.globl vector53
vector53:
  pushl $0
  101c66:	6a 00                	push   $0x0
  pushl $53
  101c68:	6a 35                	push   $0x35
  jmp alltraps
  101c6a:	e9 37 fb ff ff       	jmp    1017a6 <alltraps>

00101c6f <vector54>:
.globl vector54
vector54:
  pushl $0
  101c6f:	6a 00                	push   $0x0
  pushl $54
  101c71:	6a 36                	push   $0x36
  jmp alltraps
  101c73:	e9 2e fb ff ff       	jmp    1017a6 <alltraps>

00101c78 <vector55>:
.globl vector55
vector55:
  pushl $0
  101c78:	6a 00                	push   $0x0
  pushl $55
  101c7a:	6a 37                	push   $0x37
  jmp alltraps
  101c7c:	e9 25 fb ff ff       	jmp    1017a6 <alltraps>

00101c81 <vector56>:
.globl vector56
vector56:
  pushl $0
  101c81:	6a 00                	push   $0x0
  pushl $56
  101c83:	6a 38                	push   $0x38
  jmp alltraps
  101c85:	e9 1c fb ff ff       	jmp    1017a6 <alltraps>

00101c8a <vector57>:
.globl vector57
vector57:
  pushl $0
  101c8a:	6a 00                	push   $0x0
  pushl $57
  101c8c:	6a 39                	push   $0x39
  jmp alltraps
  101c8e:	e9 13 fb ff ff       	jmp    1017a6 <alltraps>

00101c93 <vector58>:
.globl vector58
vector58:
  pushl $0
  101c93:	6a 00                	push   $0x0
  pushl $58
  101c95:	6a 3a                	push   $0x3a
  jmp alltraps
  101c97:	e9 0a fb ff ff       	jmp    1017a6 <alltraps>

00101c9c <vector59>:
.globl vector59
vector59:
  pushl $0
  101c9c:	6a 00                	push   $0x0
  pushl $59
  101c9e:	6a 3b                	push   $0x3b
  jmp alltraps
  101ca0:	e9 01 fb ff ff       	jmp    1017a6 <alltraps>

00101ca5 <vector60>:
.globl vector60
vector60:
  pushl $0
  101ca5:	6a 00                	push   $0x0
  pushl $60
  101ca7:	6a 3c                	push   $0x3c
  jmp alltraps
  101ca9:	e9 f8 fa ff ff       	jmp    1017a6 <alltraps>

00101cae <vector61>:
.globl vector61
vector61:
  pushl $0
  101cae:	6a 00                	push   $0x0
  pushl $61
  101cb0:	6a 3d                	push   $0x3d
  jmp alltraps
  101cb2:	e9 ef fa ff ff       	jmp    1017a6 <alltraps>

00101cb7 <vector62>:
.globl vector62
vector62:
  pushl $0
  101cb7:	6a 00                	push   $0x0
  pushl $62
  101cb9:	6a 3e                	push   $0x3e
  jmp alltraps
  101cbb:	e9 e6 fa ff ff       	jmp    1017a6 <alltraps>

00101cc0 <vector63>:
.globl vector63
vector63:
  pushl $0
  101cc0:	6a 00                	push   $0x0
  pushl $63
  101cc2:	6a 3f                	push   $0x3f
  jmp alltraps
  101cc4:	e9 dd fa ff ff       	jmp    1017a6 <alltraps>

00101cc9 <vector64>:
.globl vector64
vector64:
  pushl $0
  101cc9:	6a 00                	push   $0x0
  pushl $64
  101ccb:	6a 40                	push   $0x40
  jmp alltraps
  101ccd:	e9 d4 fa ff ff       	jmp    1017a6 <alltraps>

00101cd2 <vector65>:
.globl vector65
vector65:
  pushl $0
  101cd2:	6a 00                	push   $0x0
  pushl $65
  101cd4:	6a 41                	push   $0x41
  jmp alltraps
  101cd6:	e9 cb fa ff ff       	jmp    1017a6 <alltraps>

00101cdb <vector66>:
.globl vector66
vector66:
  pushl $0
  101cdb:	6a 00                	push   $0x0
  pushl $66
  101cdd:	6a 42                	push   $0x42
  jmp alltraps
  101cdf:	e9 c2 fa ff ff       	jmp    1017a6 <alltraps>

00101ce4 <vector67>:
.globl vector67
vector67:
  pushl $0
  101ce4:	6a 00                	push   $0x0
  pushl $67
  101ce6:	6a 43                	push   $0x43
  jmp alltraps
  101ce8:	e9 b9 fa ff ff       	jmp    1017a6 <alltraps>

00101ced <vector68>:
.globl vector68
vector68:
  pushl $0
  101ced:	6a 00                	push   $0x0
  pushl $68
  101cef:	6a 44                	push   $0x44
  jmp alltraps
  101cf1:	e9 b0 fa ff ff       	jmp    1017a6 <alltraps>

00101cf6 <vector69>:
.globl vector69
vector69:
  pushl $0
  101cf6:	6a 00                	push   $0x0
  pushl $69
  101cf8:	6a 45                	push   $0x45
  jmp alltraps
  101cfa:	e9 a7 fa ff ff       	jmp    1017a6 <alltraps>

00101cff <vector70>:
.globl vector70
vector70:
  pushl $0
  101cff:	6a 00                	push   $0x0
  pushl $70
  101d01:	6a 46                	push   $0x46
  jmp alltraps
  101d03:	e9 9e fa ff ff       	jmp    1017a6 <alltraps>

00101d08 <vector71>:
.globl vector71
vector71:
  pushl $0
  101d08:	6a 00                	push   $0x0
  pushl $71
  101d0a:	6a 47                	push   $0x47
  jmp alltraps
  101d0c:	e9 95 fa ff ff       	jmp    1017a6 <alltraps>

00101d11 <vector72>:
.globl vector72
vector72:
  pushl $0
  101d11:	6a 00                	push   $0x0
  pushl $72
  101d13:	6a 48                	push   $0x48
  jmp alltraps
  101d15:	e9 8c fa ff ff       	jmp    1017a6 <alltraps>

00101d1a <vector73>:
.globl vector73
vector73:
  pushl $0
  101d1a:	6a 00                	push   $0x0
  pushl $73
  101d1c:	6a 49                	push   $0x49
  jmp alltraps
  101d1e:	e9 83 fa ff ff       	jmp    1017a6 <alltraps>

00101d23 <vector74>:
.globl vector74
vector74:
  pushl $0
  101d23:	6a 00                	push   $0x0
  pushl $74
  101d25:	6a 4a                	push   $0x4a
  jmp alltraps
  101d27:	e9 7a fa ff ff       	jmp    1017a6 <alltraps>

00101d2c <vector75>:
.globl vector75
vector75:
  pushl $0
  101d2c:	6a 00                	push   $0x0
  pushl $75
  101d2e:	6a 4b                	push   $0x4b
  jmp alltraps
  101d30:	e9 71 fa ff ff       	jmp    1017a6 <alltraps>

00101d35 <vector76>:
.globl vector76
vector76:
  pushl $0
  101d35:	6a 00                	push   $0x0
  pushl $76
  101d37:	6a 4c                	push   $0x4c
  jmp alltraps
  101d39:	e9 68 fa ff ff       	jmp    1017a6 <alltraps>

00101d3e <vector77>:
.globl vector77
vector77:
  pushl $0
  101d3e:	6a 00                	push   $0x0
  pushl $77
  101d40:	6a 4d                	push   $0x4d
  jmp alltraps
  101d42:	e9 5f fa ff ff       	jmp    1017a6 <alltraps>

00101d47 <vector78>:
.globl vector78
vector78:
  pushl $0
  101d47:	6a 00                	push   $0x0
  pushl $78
  101d49:	6a 4e                	push   $0x4e
  jmp alltraps
  101d4b:	e9 56 fa ff ff       	jmp    1017a6 <alltraps>

00101d50 <vector79>:
.globl vector79
vector79:
  pushl $0
  101d50:	6a 00                	push   $0x0
  pushl $79
  101d52:	6a 4f                	push   $0x4f
  jmp alltraps
  101d54:	e9 4d fa ff ff       	jmp    1017a6 <alltraps>

00101d59 <vector80>:
.globl vector80
vector80:
  pushl $0
  101d59:	6a 00                	push   $0x0
  pushl $80
  101d5b:	6a 50                	push   $0x50
  jmp alltraps
  101d5d:	e9 44 fa ff ff       	jmp    1017a6 <alltraps>

00101d62 <vector81>:
.globl vector81
vector81:
  pushl $0
  101d62:	6a 00                	push   $0x0
  pushl $81
  101d64:	6a 51                	push   $0x51
  jmp alltraps
  101d66:	e9 3b fa ff ff       	jmp    1017a6 <alltraps>

00101d6b <vector82>:
.globl vector82
vector82:
  pushl $0
  101d6b:	6a 00                	push   $0x0
  pushl $82
  101d6d:	6a 52                	push   $0x52
  jmp alltraps
  101d6f:	e9 32 fa ff ff       	jmp    1017a6 <alltraps>

00101d74 <vector83>:
.globl vector83
vector83:
  pushl $0
  101d74:	6a 00                	push   $0x0
  pushl $83
  101d76:	6a 53                	push   $0x53
  jmp alltraps
  101d78:	e9 29 fa ff ff       	jmp    1017a6 <alltraps>

00101d7d <vector84>:
.globl vector84
vector84:
  pushl $0
  101d7d:	6a 00                	push   $0x0
  pushl $84
  101d7f:	6a 54                	push   $0x54
  jmp alltraps
  101d81:	e9 20 fa ff ff       	jmp    1017a6 <alltraps>

00101d86 <vector85>:
.globl vector85
vector85:
  pushl $0
  101d86:	6a 00                	push   $0x0
  pushl $85
  101d88:	6a 55                	push   $0x55
  jmp alltraps
  101d8a:	e9 17 fa ff ff       	jmp    1017a6 <alltraps>

00101d8f <vector86>:
.globl vector86
vector86:
  pushl $0
  101d8f:	6a 00                	push   $0x0
  pushl $86
  101d91:	6a 56                	push   $0x56
  jmp alltraps
  101d93:	e9 0e fa ff ff       	jmp    1017a6 <alltraps>

00101d98 <vector87>:
.globl vector87
vector87:
  pushl $0
  101d98:	6a 00                	push   $0x0
  pushl $87
  101d9a:	6a 57                	push   $0x57
  jmp alltraps
  101d9c:	e9 05 fa ff ff       	jmp    1017a6 <alltraps>

00101da1 <vector88>:
.globl vector88
vector88:
  pushl $0
  101da1:	6a 00                	push   $0x0
  pushl $88
  101da3:	6a 58                	push   $0x58
  jmp alltraps
  101da5:	e9 fc f9 ff ff       	jmp    1017a6 <alltraps>

00101daa <vector89>:
.globl vector89
vector89:
  pushl $0
  101daa:	6a 00                	push   $0x0
  pushl $89
  101dac:	6a 59                	push   $0x59
  jmp alltraps
  101dae:	e9 f3 f9 ff ff       	jmp    1017a6 <alltraps>

00101db3 <vector90>:
.globl vector90
vector90:
  pushl $0
  101db3:	6a 00                	push   $0x0
  pushl $90
  101db5:	6a 5a                	push   $0x5a
  jmp alltraps
  101db7:	e9 ea f9 ff ff       	jmp    1017a6 <alltraps>

00101dbc <vector91>:
.globl vector91
vector91:
  pushl $0
  101dbc:	6a 00                	push   $0x0
  pushl $91
  101dbe:	6a 5b                	push   $0x5b
  jmp alltraps
  101dc0:	e9 e1 f9 ff ff       	jmp    1017a6 <alltraps>

00101dc5 <vector92>:
.globl vector92
vector92:
  pushl $0
  101dc5:	6a 00                	push   $0x0
  pushl $92
  101dc7:	6a 5c                	push   $0x5c
  jmp alltraps
  101dc9:	e9 d8 f9 ff ff       	jmp    1017a6 <alltraps>

00101dce <vector93>:
.globl vector93
vector93:
  pushl $0
  101dce:	6a 00                	push   $0x0
  pushl $93
  101dd0:	6a 5d                	push   $0x5d
  jmp alltraps
  101dd2:	e9 cf f9 ff ff       	jmp    1017a6 <alltraps>

00101dd7 <vector94>:
.globl vector94
vector94:
  pushl $0
  101dd7:	6a 00                	push   $0x0
  pushl $94
  101dd9:	6a 5e                	push   $0x5e
  jmp alltraps
  101ddb:	e9 c6 f9 ff ff       	jmp    1017a6 <alltraps>

00101de0 <vector95>:
.globl vector95
vector95:
  pushl $0
  101de0:	6a 00                	push   $0x0
  pushl $95
  101de2:	6a 5f                	push   $0x5f
  jmp alltraps
  101de4:	e9 bd f9 ff ff       	jmp    1017a6 <alltraps>

00101de9 <vector96>:
.globl vector96
vector96:
  pushl $0
  101de9:	6a 00                	push   $0x0
  pushl $96
  101deb:	6a 60                	push   $0x60
  jmp alltraps
  101ded:	e9 b4 f9 ff ff       	jmp    1017a6 <alltraps>

00101df2 <vector97>:
.globl vector97
vector97:
  pushl $0
  101df2:	6a 00                	push   $0x0
  pushl $97
  101df4:	6a 61                	push   $0x61
  jmp alltraps
  101df6:	e9 ab f9 ff ff       	jmp    1017a6 <alltraps>

00101dfb <vector98>:
.globl vector98
vector98:
  pushl $0
  101dfb:	6a 00                	push   $0x0
  pushl $98
  101dfd:	6a 62                	push   $0x62
  jmp alltraps
  101dff:	e9 a2 f9 ff ff       	jmp    1017a6 <alltraps>

00101e04 <vector99>:
.globl vector99
vector99:
  pushl $0
  101e04:	6a 00                	push   $0x0
  pushl $99
  101e06:	6a 63                	push   $0x63
  jmp alltraps
  101e08:	e9 99 f9 ff ff       	jmp    1017a6 <alltraps>

00101e0d <vector100>:
.globl vector100
vector100:
  pushl $0
  101e0d:	6a 00                	push   $0x0
  pushl $100
  101e0f:	6a 64                	push   $0x64
  jmp alltraps
  101e11:	e9 90 f9 ff ff       	jmp    1017a6 <alltraps>

00101e16 <vector101>:
.globl vector101
vector101:
  pushl $0
  101e16:	6a 00                	push   $0x0
  pushl $101
  101e18:	6a 65                	push   $0x65
  jmp alltraps
  101e1a:	e9 87 f9 ff ff       	jmp    1017a6 <alltraps>

00101e1f <vector102>:
.globl vector102
vector102:
  pushl $0
  101e1f:	6a 00                	push   $0x0
  pushl $102
  101e21:	6a 66                	push   $0x66
  jmp alltraps
  101e23:	e9 7e f9 ff ff       	jmp    1017a6 <alltraps>

00101e28 <vector103>:
.globl vector103
vector103:
  pushl $0
  101e28:	6a 00                	push   $0x0
  pushl $103
  101e2a:	6a 67                	push   $0x67
  jmp alltraps
  101e2c:	e9 75 f9 ff ff       	jmp    1017a6 <alltraps>

00101e31 <vector104>:
.globl vector104
vector104:
  pushl $0
  101e31:	6a 00                	push   $0x0
  pushl $104
  101e33:	6a 68                	push   $0x68
  jmp alltraps
  101e35:	e9 6c f9 ff ff       	jmp    1017a6 <alltraps>

00101e3a <vector105>:
.globl vector105
vector105:
  pushl $0
  101e3a:	6a 00                	push   $0x0
  pushl $105
  101e3c:	6a 69                	push   $0x69
  jmp alltraps
  101e3e:	e9 63 f9 ff ff       	jmp    1017a6 <alltraps>

00101e43 <vector106>:
.globl vector106
vector106:
  pushl $0
  101e43:	6a 00                	push   $0x0
  pushl $106
  101e45:	6a 6a                	push   $0x6a
  jmp alltraps
  101e47:	e9 5a f9 ff ff       	jmp    1017a6 <alltraps>

00101e4c <vector107>:
.globl vector107
vector107:
  pushl $0
  101e4c:	6a 00                	push   $0x0
  pushl $107
  101e4e:	6a 6b                	push   $0x6b
  jmp alltraps
  101e50:	e9 51 f9 ff ff       	jmp    1017a6 <alltraps>

00101e55 <vector108>:
.globl vector108
vector108:
  pushl $0
  101e55:	6a 00                	push   $0x0
  pushl $108
  101e57:	6a 6c                	push   $0x6c
  jmp alltraps
  101e59:	e9 48 f9 ff ff       	jmp    1017a6 <alltraps>

00101e5e <vector109>:
.globl vector109
vector109:
  pushl $0
  101e5e:	6a 00                	push   $0x0
  pushl $109
  101e60:	6a 6d                	push   $0x6d
  jmp alltraps
  101e62:	e9 3f f9 ff ff       	jmp    1017a6 <alltraps>

00101e67 <vector110>:
.globl vector110
vector110:
  pushl $0
  101e67:	6a 00                	push   $0x0
  pushl $110
  101e69:	6a 6e                	push   $0x6e
  jmp alltraps
  101e6b:	e9 36 f9 ff ff       	jmp    1017a6 <alltraps>

00101e70 <vector111>:
.globl vector111
vector111:
  pushl $0
  101e70:	6a 00                	push   $0x0
  pushl $111
  101e72:	6a 6f                	push   $0x6f
  jmp alltraps
  101e74:	e9 2d f9 ff ff       	jmp    1017a6 <alltraps>

00101e79 <vector112>:
.globl vector112
vector112:
  pushl $0
  101e79:	6a 00                	push   $0x0
  pushl $112
  101e7b:	6a 70                	push   $0x70
  jmp alltraps
  101e7d:	e9 24 f9 ff ff       	jmp    1017a6 <alltraps>

00101e82 <vector113>:
.globl vector113
vector113:
  pushl $0
  101e82:	6a 00                	push   $0x0
  pushl $113
  101e84:	6a 71                	push   $0x71
  jmp alltraps
  101e86:	e9 1b f9 ff ff       	jmp    1017a6 <alltraps>

00101e8b <vector114>:
.globl vector114
vector114:
  pushl $0
  101e8b:	6a 00                	push   $0x0
  pushl $114
  101e8d:	6a 72                	push   $0x72
  jmp alltraps
  101e8f:	e9 12 f9 ff ff       	jmp    1017a6 <alltraps>

00101e94 <vector115>:
.globl vector115
vector115:
  pushl $0
  101e94:	6a 00                	push   $0x0
  pushl $115
  101e96:	6a 73                	push   $0x73
  jmp alltraps
  101e98:	e9 09 f9 ff ff       	jmp    1017a6 <alltraps>

00101e9d <vector116>:
.globl vector116
vector116:
  pushl $0
  101e9d:	6a 00                	push   $0x0
  pushl $116
  101e9f:	6a 74                	push   $0x74
  jmp alltraps
  101ea1:	e9 00 f9 ff ff       	jmp    1017a6 <alltraps>

00101ea6 <vector117>:
.globl vector117
vector117:
  pushl $0
  101ea6:	6a 00                	push   $0x0
  pushl $117
  101ea8:	6a 75                	push   $0x75
  jmp alltraps
  101eaa:	e9 f7 f8 ff ff       	jmp    1017a6 <alltraps>

00101eaf <vector118>:
.globl vector118
vector118:
  pushl $0
  101eaf:	6a 00                	push   $0x0
  pushl $118
  101eb1:	6a 76                	push   $0x76
  jmp alltraps
  101eb3:	e9 ee f8 ff ff       	jmp    1017a6 <alltraps>

00101eb8 <vector119>:
.globl vector119
vector119:
  pushl $0
  101eb8:	6a 00                	push   $0x0
  pushl $119
  101eba:	6a 77                	push   $0x77
  jmp alltraps
  101ebc:	e9 e5 f8 ff ff       	jmp    1017a6 <alltraps>

00101ec1 <vector120>:
.globl vector120
vector120:
  pushl $0
  101ec1:	6a 00                	push   $0x0
  pushl $120
  101ec3:	6a 78                	push   $0x78
  jmp alltraps
  101ec5:	e9 dc f8 ff ff       	jmp    1017a6 <alltraps>

00101eca <vector121>:
.globl vector121
vector121:
  pushl $0
  101eca:	6a 00                	push   $0x0
  pushl $121
  101ecc:	6a 79                	push   $0x79
  jmp alltraps
  101ece:	e9 d3 f8 ff ff       	jmp    1017a6 <alltraps>

00101ed3 <vector122>:
.globl vector122
vector122:
  pushl $0
  101ed3:	6a 00                	push   $0x0
  pushl $122
  101ed5:	6a 7a                	push   $0x7a
  jmp alltraps
  101ed7:	e9 ca f8 ff ff       	jmp    1017a6 <alltraps>

00101edc <vector123>:
.globl vector123
vector123:
  pushl $0
  101edc:	6a 00                	push   $0x0
  pushl $123
  101ede:	6a 7b                	push   $0x7b
  jmp alltraps
  101ee0:	e9 c1 f8 ff ff       	jmp    1017a6 <alltraps>

00101ee5 <vector124>:
.globl vector124
vector124:
  pushl $0
  101ee5:	6a 00                	push   $0x0
  pushl $124
  101ee7:	6a 7c                	push   $0x7c
  jmp alltraps
  101ee9:	e9 b8 f8 ff ff       	jmp    1017a6 <alltraps>

00101eee <vector125>:
.globl vector125
vector125:
  pushl $0
  101eee:	6a 00                	push   $0x0
  pushl $125
  101ef0:	6a 7d                	push   $0x7d
  jmp alltraps
  101ef2:	e9 af f8 ff ff       	jmp    1017a6 <alltraps>

00101ef7 <vector126>:
.globl vector126
vector126:
  pushl $0
  101ef7:	6a 00                	push   $0x0
  pushl $126
  101ef9:	6a 7e                	push   $0x7e
  jmp alltraps
  101efb:	e9 a6 f8 ff ff       	jmp    1017a6 <alltraps>

00101f00 <vector127>:
.globl vector127
vector127:
  pushl $0
  101f00:	6a 00                	push   $0x0
  pushl $127
  101f02:	6a 7f                	push   $0x7f
  jmp alltraps
  101f04:	e9 9d f8 ff ff       	jmp    1017a6 <alltraps>

00101f09 <vector128>:
.globl vector128
vector128:
  pushl $0
  101f09:	6a 00                	push   $0x0
  pushl $128
  101f0b:	68 80 00 00 00       	push   $0x80
  jmp alltraps
  101f10:	e9 91 f8 ff ff       	jmp    1017a6 <alltraps>

00101f15 <vector129>:
.globl vector129
vector129:
  pushl $0
  101f15:	6a 00                	push   $0x0
  pushl $129
  101f17:	68 81 00 00 00       	push   $0x81
  jmp alltraps
  101f1c:	e9 85 f8 ff ff       	jmp    1017a6 <alltraps>

00101f21 <vector130>:
.globl vector130
vector130:
  pushl $0
  101f21:	6a 00                	push   $0x0
  pushl $130
  101f23:	68 82 00 00 00       	push   $0x82
  jmp alltraps
  101f28:	e9 79 f8 ff ff       	jmp    1017a6 <alltraps>

00101f2d <vector131>:
.globl vector131
vector131:
  pushl $0
  101f2d:	6a 00                	push   $0x0
  pushl $131
  101f2f:	68 83 00 00 00       	push   $0x83
  jmp alltraps
  101f34:	e9 6d f8 ff ff       	jmp    1017a6 <alltraps>

00101f39 <vector132>:
.globl vector132
vector132:
  pushl $0
  101f39:	6a 00                	push   $0x0
  pushl $132
  101f3b:	68 84 00 00 00       	push   $0x84
  jmp alltraps
  101f40:	e9 61 f8 ff ff       	jmp    1017a6 <alltraps>

00101f45 <vector133>:
.globl vector133
vector133:
  pushl $0
  101f45:	6a 00                	push   $0x0
  pushl $133
  101f47:	68 85 00 00 00       	push   $0x85
  jmp alltraps
  101f4c:	e9 55 f8 ff ff       	jmp    1017a6 <alltraps>

00101f51 <vector134>:
.globl vector134
vector134:
  pushl $0
  101f51:	6a 00                	push   $0x0
  pushl $134
  101f53:	68 86 00 00 00       	push   $0x86
  jmp alltraps
  101f58:	e9 49 f8 ff ff       	jmp    1017a6 <alltraps>

00101f5d <vector135>:
.globl vector135
vector135:
  pushl $0
  101f5d:	6a 00                	push   $0x0
  pushl $135
  101f5f:	68 87 00 00 00       	push   $0x87
  jmp alltraps
  101f64:	e9 3d f8 ff ff       	jmp    1017a6 <alltraps>

00101f69 <vector136>:
.globl vector136
vector136:
  pushl $0
  101f69:	6a 00                	push   $0x0
  pushl $136
  101f6b:	68 88 00 00 00       	push   $0x88
  jmp alltraps
  101f70:	e9 31 f8 ff ff       	jmp    1017a6 <alltraps>

00101f75 <vector137>:
.globl vector137
vector137:
  pushl $0
  101f75:	6a 00                	push   $0x0
  pushl $137
  101f77:	68 89 00 00 00       	push   $0x89
  jmp alltraps
  101f7c:	e9 25 f8 ff ff       	jmp    1017a6 <alltraps>

00101f81 <vector138>:
.globl vector138
vector138:
  pushl $0
  101f81:	6a 00                	push   $0x0
  pushl $138
  101f83:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
  101f88:	e9 19 f8 ff ff       	jmp    1017a6 <alltraps>

00101f8d <vector139>:
.globl vector139
vector139:
  pushl $0
  101f8d:	6a 00                	push   $0x0
  pushl $139
  101f8f:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
  101f94:	e9 0d f8 ff ff       	jmp    1017a6 <alltraps>

00101f99 <vector140>:
.globl vector140
vector140:
  pushl $0
  101f99:	6a 00                	push   $0x0
  pushl $140
  101f9b:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
  101fa0:	e9 01 f8 ff ff       	jmp    1017a6 <alltraps>

00101fa5 <vector141>:
.globl vector141
vector141:
  pushl $0
  101fa5:	6a 00                	push   $0x0
  pushl $141
  101fa7:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
  101fac:	e9 f5 f7 ff ff       	jmp    1017a6 <alltraps>

00101fb1 <vector142>:
.globl vector142
vector142:
  pushl $0
  101fb1:	6a 00                	push   $0x0
  pushl $142
  101fb3:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
  101fb8:	e9 e9 f7 ff ff       	jmp    1017a6 <alltraps>

00101fbd <vector143>:
.globl vector143
vector143:
  pushl $0
  101fbd:	6a 00                	push   $0x0
  pushl $143
  101fbf:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
  101fc4:	e9 dd f7 ff ff       	jmp    1017a6 <alltraps>

00101fc9 <vector144>:
.globl vector144
vector144:
  pushl $0
  101fc9:	6a 00                	push   $0x0
  pushl $144
  101fcb:	68 90 00 00 00       	push   $0x90
  jmp alltraps
  101fd0:	e9 d1 f7 ff ff       	jmp    1017a6 <alltraps>

00101fd5 <vector145>:
.globl vector145
vector145:
  pushl $0
  101fd5:	6a 00                	push   $0x0
  pushl $145
  101fd7:	68 91 00 00 00       	push   $0x91
  jmp alltraps
  101fdc:	e9 c5 f7 ff ff       	jmp    1017a6 <alltraps>

00101fe1 <vector146>:
.globl vector146
vector146:
  pushl $0
  101fe1:	6a 00                	push   $0x0
  pushl $146
  101fe3:	68 92 00 00 00       	push   $0x92
  jmp alltraps
  101fe8:	e9 b9 f7 ff ff       	jmp    1017a6 <alltraps>

00101fed <vector147>:
.globl vector147
vector147:
  pushl $0
  101fed:	6a 00                	push   $0x0
  pushl $147
  101fef:	68 93 00 00 00       	push   $0x93
  jmp alltraps
  101ff4:	e9 ad f7 ff ff       	jmp    1017a6 <alltraps>

00101ff9 <vector148>:
.globl vector148
vector148:
  pushl $0
  101ff9:	6a 00                	push   $0x0
  pushl $148
  101ffb:	68 94 00 00 00       	push   $0x94
  jmp alltraps
  102000:	e9 a1 f7 ff ff       	jmp    1017a6 <alltraps>

00102005 <vector149>:
.globl vector149
vector149:
  pushl $0
  102005:	6a 00                	push   $0x0
  pushl $149
  102007:	68 95 00 00 00       	push   $0x95
  jmp alltraps
  10200c:	e9 95 f7 ff ff       	jmp    1017a6 <alltraps>

00102011 <vector150>:
.globl vector150
vector150:
  pushl $0
  102011:	6a 00                	push   $0x0
  pushl $150
  102013:	68 96 00 00 00       	push   $0x96
  jmp alltraps
  102018:	e9 89 f7 ff ff       	jmp    1017a6 <alltraps>

0010201d <vector151>:
.globl vector151
vector151:
  pushl $0
  10201d:	6a 00                	push   $0x0
  pushl $151
  10201f:	68 97 00 00 00       	push   $0x97
  jmp alltraps
  102024:	e9 7d f7 ff ff       	jmp    1017a6 <alltraps>

00102029 <vector152>:
.globl vector152
vector152:
  pushl $0
  102029:	6a 00                	push   $0x0
  pushl $152
  10202b:	68 98 00 00 00       	push   $0x98
  jmp alltraps
  102030:	e9 71 f7 ff ff       	jmp    1017a6 <alltraps>

00102035 <vector153>:
.globl vector153
vector153:
  pushl $0
  102035:	6a 00                	push   $0x0
  pushl $153
  102037:	68 99 00 00 00       	push   $0x99
  jmp alltraps
  10203c:	e9 65 f7 ff ff       	jmp    1017a6 <alltraps>

00102041 <vector154>:
.globl vector154
vector154:
  pushl $0
  102041:	6a 00                	push   $0x0
  pushl $154
  102043:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
  102048:	e9 59 f7 ff ff       	jmp    1017a6 <alltraps>

0010204d <vector155>:
.globl vector155
vector155:
  pushl $0
  10204d:	6a 00                	push   $0x0
  pushl $155
  10204f:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
  102054:	e9 4d f7 ff ff       	jmp    1017a6 <alltraps>

00102059 <vector156>:
.globl vector156
vector156:
  pushl $0
  102059:	6a 00                	push   $0x0
  pushl $156
  10205b:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
  102060:	e9 41 f7 ff ff       	jmp    1017a6 <alltraps>

00102065 <vector157>:
.globl vector157
vector157:
  pushl $0
  102065:	6a 00                	push   $0x0
  pushl $157
  102067:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
  10206c:	e9 35 f7 ff ff       	jmp    1017a6 <alltraps>

00102071 <vector158>:
.globl vector158
vector158:
  pushl $0
  102071:	6a 00                	push   $0x0
  pushl $158
  102073:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
  102078:	e9 29 f7 ff ff       	jmp    1017a6 <alltraps>

0010207d <vector159>:
.globl vector159
vector159:
  pushl $0
  10207d:	6a 00                	push   $0x0
  pushl $159
  10207f:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
  102084:	e9 1d f7 ff ff       	jmp    1017a6 <alltraps>

00102089 <vector160>:
.globl vector160
vector160:
  pushl $0
  102089:	6a 00                	push   $0x0
  pushl $160
  10208b:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
  102090:	e9 11 f7 ff ff       	jmp    1017a6 <alltraps>

00102095 <vector161>:
.globl vector161
vector161:
  pushl $0
  102095:	6a 00                	push   $0x0
  pushl $161
  102097:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
  10209c:	e9 05 f7 ff ff       	jmp    1017a6 <alltraps>

001020a1 <vector162>:
.globl vector162
vector162:
  pushl $0
  1020a1:	6a 00                	push   $0x0
  pushl $162
  1020a3:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
  1020a8:	e9 f9 f6 ff ff       	jmp    1017a6 <alltraps>

001020ad <vector163>:
.globl vector163
vector163:
  pushl $0
  1020ad:	6a 00                	push   $0x0
  pushl $163
  1020af:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
  1020b4:	e9 ed f6 ff ff       	jmp    1017a6 <alltraps>

001020b9 <vector164>:
.globl vector164
vector164:
  pushl $0
  1020b9:	6a 00                	push   $0x0
  pushl $164
  1020bb:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
  1020c0:	e9 e1 f6 ff ff       	jmp    1017a6 <alltraps>

001020c5 <vector165>:
.globl vector165
vector165:
  pushl $0
  1020c5:	6a 00                	push   $0x0
  pushl $165
  1020c7:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
  1020cc:	e9 d5 f6 ff ff       	jmp    1017a6 <alltraps>

001020d1 <vector166>:
.globl vector166
vector166:
  pushl $0
  1020d1:	6a 00                	push   $0x0
  pushl $166
  1020d3:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
  1020d8:	e9 c9 f6 ff ff       	jmp    1017a6 <alltraps>

001020dd <vector167>:
.globl vector167
vector167:
  pushl $0
  1020dd:	6a 00                	push   $0x0
  pushl $167
  1020df:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
  1020e4:	e9 bd f6 ff ff       	jmp    1017a6 <alltraps>

001020e9 <vector168>:
.globl vector168
vector168:
  pushl $0
  1020e9:	6a 00                	push   $0x0
  pushl $168
  1020eb:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
  1020f0:	e9 b1 f6 ff ff       	jmp    1017a6 <alltraps>

001020f5 <vector169>:
.globl vector169
vector169:
  pushl $0
  1020f5:	6a 00                	push   $0x0
  pushl $169
  1020f7:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
  1020fc:	e9 a5 f6 ff ff       	jmp    1017a6 <alltraps>

00102101 <vector170>:
.globl vector170
vector170:
  pushl $0
  102101:	6a 00                	push   $0x0
  pushl $170
  102103:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
  102108:	e9 99 f6 ff ff       	jmp    1017a6 <alltraps>

0010210d <vector171>:
.globl vector171
vector171:
  pushl $0
  10210d:	6a 00                	push   $0x0
  pushl $171
  10210f:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
  102114:	e9 8d f6 ff ff       	jmp    1017a6 <alltraps>

00102119 <vector172>:
.globl vector172
vector172:
  pushl $0
  102119:	6a 00                	push   $0x0
  pushl $172
  10211b:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
  102120:	e9 81 f6 ff ff       	jmp    1017a6 <alltraps>

00102125 <vector173>:
.globl vector173
vector173:
  pushl $0
  102125:	6a 00                	push   $0x0
  pushl $173
  102127:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
  10212c:	e9 75 f6 ff ff       	jmp    1017a6 <alltraps>

00102131 <vector174>:
.globl vector174
vector174:
  pushl $0
  102131:	6a 00                	push   $0x0
  pushl $174
  102133:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
  102138:	e9 69 f6 ff ff       	jmp    1017a6 <alltraps>

0010213d <vector175>:
.globl vector175
vector175:
  pushl $0
  10213d:	6a 00                	push   $0x0
  pushl $175
  10213f:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
  102144:	e9 5d f6 ff ff       	jmp    1017a6 <alltraps>

00102149 <vector176>:
.globl vector176
vector176:
  pushl $0
  102149:	6a 00                	push   $0x0
  pushl $176
  10214b:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
  102150:	e9 51 f6 ff ff       	jmp    1017a6 <alltraps>

00102155 <vector177>:
.globl vector177
vector177:
  pushl $0
  102155:	6a 00                	push   $0x0
  pushl $177
  102157:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
  10215c:	e9 45 f6 ff ff       	jmp    1017a6 <alltraps>

00102161 <vector178>:
.globl vector178
vector178:
  pushl $0
  102161:	6a 00                	push   $0x0
  pushl $178
  102163:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
  102168:	e9 39 f6 ff ff       	jmp    1017a6 <alltraps>

0010216d <vector179>:
.globl vector179
vector179:
  pushl $0
  10216d:	6a 00                	push   $0x0
  pushl $179
  10216f:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
  102174:	e9 2d f6 ff ff       	jmp    1017a6 <alltraps>

00102179 <vector180>:
.globl vector180
vector180:
  pushl $0
  102179:	6a 00                	push   $0x0
  pushl $180
  10217b:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
  102180:	e9 21 f6 ff ff       	jmp    1017a6 <alltraps>

00102185 <vector181>:
.globl vector181
vector181:
  pushl $0
  102185:	6a 00                	push   $0x0
  pushl $181
  102187:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
  10218c:	e9 15 f6 ff ff       	jmp    1017a6 <alltraps>

00102191 <vector182>:
.globl vector182
vector182:
  pushl $0
  102191:	6a 00                	push   $0x0
  pushl $182
  102193:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
  102198:	e9 09 f6 ff ff       	jmp    1017a6 <alltraps>

0010219d <vector183>:
.globl vector183
vector183:
  pushl $0
  10219d:	6a 00                	push   $0x0
  pushl $183
  10219f:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
  1021a4:	e9 fd f5 ff ff       	jmp    1017a6 <alltraps>

001021a9 <vector184>:
.globl vector184
vector184:
  pushl $0
  1021a9:	6a 00                	push   $0x0
  pushl $184
  1021ab:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
  1021b0:	e9 f1 f5 ff ff       	jmp    1017a6 <alltraps>

001021b5 <vector185>:
.globl vector185
vector185:
  pushl $0
  1021b5:	6a 00                	push   $0x0
  pushl $185
  1021b7:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
  1021bc:	e9 e5 f5 ff ff       	jmp    1017a6 <alltraps>

001021c1 <vector186>:
.globl vector186
vector186:
  pushl $0
  1021c1:	6a 00                	push   $0x0
  pushl $186
  1021c3:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
  1021c8:	e9 d9 f5 ff ff       	jmp    1017a6 <alltraps>

001021cd <vector187>:
.globl vector187
vector187:
  pushl $0
  1021cd:	6a 00                	push   $0x0
  pushl $187
  1021cf:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
  1021d4:	e9 cd f5 ff ff       	jmp    1017a6 <alltraps>

001021d9 <vector188>:
.globl vector188
vector188:
  pushl $0
  1021d9:	6a 00                	push   $0x0
  pushl $188
  1021db:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
  1021e0:	e9 c1 f5 ff ff       	jmp    1017a6 <alltraps>

001021e5 <vector189>:
.globl vector189
vector189:
  pushl $0
  1021e5:	6a 00                	push   $0x0
  pushl $189
  1021e7:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
  1021ec:	e9 b5 f5 ff ff       	jmp    1017a6 <alltraps>

001021f1 <vector190>:
.globl vector190
vector190:
  pushl $0
  1021f1:	6a 00                	push   $0x0
  pushl $190
  1021f3:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
  1021f8:	e9 a9 f5 ff ff       	jmp    1017a6 <alltraps>

001021fd <vector191>:
.globl vector191
vector191:
  pushl $0
  1021fd:	6a 00                	push   $0x0
  pushl $191
  1021ff:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
  102204:	e9 9d f5 ff ff       	jmp    1017a6 <alltraps>

00102209 <vector192>:
.globl vector192
vector192:
  pushl $0
  102209:	6a 00                	push   $0x0
  pushl $192
  10220b:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
  102210:	e9 91 f5 ff ff       	jmp    1017a6 <alltraps>

00102215 <vector193>:
.globl vector193
vector193:
  pushl $0
  102215:	6a 00                	push   $0x0
  pushl $193
  102217:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
  10221c:	e9 85 f5 ff ff       	jmp    1017a6 <alltraps>

00102221 <vector194>:
.globl vector194
vector194:
  pushl $0
  102221:	6a 00                	push   $0x0
  pushl $194
  102223:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
  102228:	e9 79 f5 ff ff       	jmp    1017a6 <alltraps>

0010222d <vector195>:
.globl vector195
vector195:
  pushl $0
  10222d:	6a 00                	push   $0x0
  pushl $195
  10222f:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
  102234:	e9 6d f5 ff ff       	jmp    1017a6 <alltraps>

00102239 <vector196>:
.globl vector196
vector196:
  pushl $0
  102239:	6a 00                	push   $0x0
  pushl $196
  10223b:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
  102240:	e9 61 f5 ff ff       	jmp    1017a6 <alltraps>

00102245 <vector197>:
.globl vector197
vector197:
  pushl $0
  102245:	6a 00                	push   $0x0
  pushl $197
  102247:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
  10224c:	e9 55 f5 ff ff       	jmp    1017a6 <alltraps>

00102251 <vector198>:
.globl vector198
vector198:
  pushl $0
  102251:	6a 00                	push   $0x0
  pushl $198
  102253:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
  102258:	e9 49 f5 ff ff       	jmp    1017a6 <alltraps>

0010225d <vector199>:
.globl vector199
vector199:
  pushl $0
  10225d:	6a 00                	push   $0x0
  pushl $199
  10225f:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
  102264:	e9 3d f5 ff ff       	jmp    1017a6 <alltraps>

00102269 <vector200>:
.globl vector200
vector200:
  pushl $0
  102269:	6a 00                	push   $0x0
  pushl $200
  10226b:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
  102270:	e9 31 f5 ff ff       	jmp    1017a6 <alltraps>

00102275 <vector201>:
.globl vector201
vector201:
  pushl $0
  102275:	6a 00                	push   $0x0
  pushl $201
  102277:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
  10227c:	e9 25 f5 ff ff       	jmp    1017a6 <alltraps>

00102281 <vector202>:
.globl vector202
vector202:
  pushl $0
  102281:	6a 00                	push   $0x0
  pushl $202
  102283:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
  102288:	e9 19 f5 ff ff       	jmp    1017a6 <alltraps>

0010228d <vector203>:
.globl vector203
vector203:
  pushl $0
  10228d:	6a 00                	push   $0x0
  pushl $203
  10228f:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
  102294:	e9 0d f5 ff ff       	jmp    1017a6 <alltraps>

00102299 <vector204>:
.globl vector204
vector204:
  pushl $0
  102299:	6a 00                	push   $0x0
  pushl $204
  10229b:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
  1022a0:	e9 01 f5 ff ff       	jmp    1017a6 <alltraps>

001022a5 <vector205>:
.globl vector205
vector205:
  pushl $0
  1022a5:	6a 00                	push   $0x0
  pushl $205
  1022a7:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
  1022ac:	e9 f5 f4 ff ff       	jmp    1017a6 <alltraps>

001022b1 <vector206>:
.globl vector206
vector206:
  pushl $0
  1022b1:	6a 00                	push   $0x0
  pushl $206
  1022b3:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
  1022b8:	e9 e9 f4 ff ff       	jmp    1017a6 <alltraps>

001022bd <vector207>:
.globl vector207
vector207:
  pushl $0
  1022bd:	6a 00                	push   $0x0
  pushl $207
  1022bf:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
  1022c4:	e9 dd f4 ff ff       	jmp    1017a6 <alltraps>

001022c9 <vector208>:
.globl vector208
vector208:
  pushl $0
  1022c9:	6a 00                	push   $0x0
  pushl $208
  1022cb:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
  1022d0:	e9 d1 f4 ff ff       	jmp    1017a6 <alltraps>

001022d5 <vector209>:
.globl vector209
vector209:
  pushl $0
  1022d5:	6a 00                	push   $0x0
  pushl $209
  1022d7:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
  1022dc:	e9 c5 f4 ff ff       	jmp    1017a6 <alltraps>

001022e1 <vector210>:
.globl vector210
vector210:
  pushl $0
  1022e1:	6a 00                	push   $0x0
  pushl $210
  1022e3:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
  1022e8:	e9 b9 f4 ff ff       	jmp    1017a6 <alltraps>

001022ed <vector211>:
.globl vector211
vector211:
  pushl $0
  1022ed:	6a 00                	push   $0x0
  pushl $211
  1022ef:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
  1022f4:	e9 ad f4 ff ff       	jmp    1017a6 <alltraps>

001022f9 <vector212>:
.globl vector212
vector212:
  pushl $0
  1022f9:	6a 00                	push   $0x0
  pushl $212
  1022fb:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
  102300:	e9 a1 f4 ff ff       	jmp    1017a6 <alltraps>

00102305 <vector213>:
.globl vector213
vector213:
  pushl $0
  102305:	6a 00                	push   $0x0
  pushl $213
  102307:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
  10230c:	e9 95 f4 ff ff       	jmp    1017a6 <alltraps>

00102311 <vector214>:
.globl vector214
vector214:
  pushl $0
  102311:	6a 00                	push   $0x0
  pushl $214
  102313:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
  102318:	e9 89 f4 ff ff       	jmp    1017a6 <alltraps>

0010231d <vector215>:
.globl vector215
vector215:
  pushl $0
  10231d:	6a 00                	push   $0x0
  pushl $215
  10231f:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
  102324:	e9 7d f4 ff ff       	jmp    1017a6 <alltraps>

00102329 <vector216>:
.globl vector216
vector216:
  pushl $0
  102329:	6a 00                	push   $0x0
  pushl $216
  10232b:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
  102330:	e9 71 f4 ff ff       	jmp    1017a6 <alltraps>

00102335 <vector217>:
.globl vector217
vector217:
  pushl $0
  102335:	6a 00                	push   $0x0
  pushl $217
  102337:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
  10233c:	e9 65 f4 ff ff       	jmp    1017a6 <alltraps>

00102341 <vector218>:
.globl vector218
vector218:
  pushl $0
  102341:	6a 00                	push   $0x0
  pushl $218
  102343:	68 da 00 00 00       	push   $0xda
  jmp alltraps
  102348:	e9 59 f4 ff ff       	jmp    1017a6 <alltraps>

0010234d <vector219>:
.globl vector219
vector219:
  pushl $0
  10234d:	6a 00                	push   $0x0
  pushl $219
  10234f:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
  102354:	e9 4d f4 ff ff       	jmp    1017a6 <alltraps>

00102359 <vector220>:
.globl vector220
vector220:
  pushl $0
  102359:	6a 00                	push   $0x0
  pushl $220
  10235b:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
  102360:	e9 41 f4 ff ff       	jmp    1017a6 <alltraps>

00102365 <vector221>:
.globl vector221
vector221:
  pushl $0
  102365:	6a 00                	push   $0x0
  pushl $221
  102367:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
  10236c:	e9 35 f4 ff ff       	jmp    1017a6 <alltraps>

00102371 <vector222>:
.globl vector222
vector222:
  pushl $0
  102371:	6a 00                	push   $0x0
  pushl $222
  102373:	68 de 00 00 00       	push   $0xde
  jmp alltraps
  102378:	e9 29 f4 ff ff       	jmp    1017a6 <alltraps>

0010237d <vector223>:
.globl vector223
vector223:
  pushl $0
  10237d:	6a 00                	push   $0x0
  pushl $223
  10237f:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
  102384:	e9 1d f4 ff ff       	jmp    1017a6 <alltraps>

00102389 <vector224>:
.globl vector224
vector224:
  pushl $0
  102389:	6a 00                	push   $0x0
  pushl $224
  10238b:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
  102390:	e9 11 f4 ff ff       	jmp    1017a6 <alltraps>

00102395 <vector225>:
.globl vector225
vector225:
  pushl $0
  102395:	6a 00                	push   $0x0
  pushl $225
  102397:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
  10239c:	e9 05 f4 ff ff       	jmp    1017a6 <alltraps>

001023a1 <vector226>:
.globl vector226
vector226:
  pushl $0
  1023a1:	6a 00                	push   $0x0
  pushl $226
  1023a3:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
  1023a8:	e9 f9 f3 ff ff       	jmp    1017a6 <alltraps>

001023ad <vector227>:
.globl vector227
vector227:
  pushl $0
  1023ad:	6a 00                	push   $0x0
  pushl $227
  1023af:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
  1023b4:	e9 ed f3 ff ff       	jmp    1017a6 <alltraps>

001023b9 <vector228>:
.globl vector228
vector228:
  pushl $0
  1023b9:	6a 00                	push   $0x0
  pushl $228
  1023bb:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
  1023c0:	e9 e1 f3 ff ff       	jmp    1017a6 <alltraps>

001023c5 <vector229>:
.globl vector229
vector229:
  pushl $0
  1023c5:	6a 00                	push   $0x0
  pushl $229
  1023c7:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
  1023cc:	e9 d5 f3 ff ff       	jmp    1017a6 <alltraps>

001023d1 <vector230>:
.globl vector230
vector230:
  pushl $0
  1023d1:	6a 00                	push   $0x0
  pushl $230
  1023d3:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
  1023d8:	e9 c9 f3 ff ff       	jmp    1017a6 <alltraps>

001023dd <vector231>:
.globl vector231
vector231:
  pushl $0
  1023dd:	6a 00                	push   $0x0
  pushl $231
  1023df:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
  1023e4:	e9 bd f3 ff ff       	jmp    1017a6 <alltraps>

001023e9 <vector232>:
.globl vector232
vector232:
  pushl $0
  1023e9:	6a 00                	push   $0x0
  pushl $232
  1023eb:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
  1023f0:	e9 b1 f3 ff ff       	jmp    1017a6 <alltraps>

001023f5 <vector233>:
.globl vector233
vector233:
  pushl $0
  1023f5:	6a 00                	push   $0x0
  pushl $233
  1023f7:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
  1023fc:	e9 a5 f3 ff ff       	jmp    1017a6 <alltraps>

00102401 <vector234>:
.globl vector234
vector234:
  pushl $0
  102401:	6a 00                	push   $0x0
  pushl $234
  102403:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
  102408:	e9 99 f3 ff ff       	jmp    1017a6 <alltraps>

0010240d <vector235>:
.globl vector235
vector235:
  pushl $0
  10240d:	6a 00                	push   $0x0
  pushl $235
  10240f:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
  102414:	e9 8d f3 ff ff       	jmp    1017a6 <alltraps>

00102419 <vector236>:
.globl vector236
vector236:
  pushl $0
  102419:	6a 00                	push   $0x0
  pushl $236
  10241b:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
  102420:	e9 81 f3 ff ff       	jmp    1017a6 <alltraps>

00102425 <vector237>:
.globl vector237
vector237:
  pushl $0
  102425:	6a 00                	push   $0x0
  pushl $237
  102427:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
  10242c:	e9 75 f3 ff ff       	jmp    1017a6 <alltraps>

00102431 <vector238>:
.globl vector238
vector238:
  pushl $0
  102431:	6a 00                	push   $0x0
  pushl $238
  102433:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
  102438:	e9 69 f3 ff ff       	jmp    1017a6 <alltraps>

0010243d <vector239>:
.globl vector239
vector239:
  pushl $0
  10243d:	6a 00                	push   $0x0
  pushl $239
  10243f:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
  102444:	e9 5d f3 ff ff       	jmp    1017a6 <alltraps>

00102449 <vector240>:
.globl vector240
vector240:
  pushl $0
  102449:	6a 00                	push   $0x0
  pushl $240
  10244b:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
  102450:	e9 51 f3 ff ff       	jmp    1017a6 <alltraps>

00102455 <vector241>:
.globl vector241
vector241:
  pushl $0
  102455:	6a 00                	push   $0x0
  pushl $241
  102457:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
  10245c:	e9 45 f3 ff ff       	jmp    1017a6 <alltraps>

00102461 <vector242>:
.globl vector242
vector242:
  pushl $0
  102461:	6a 00                	push   $0x0
  pushl $242
  102463:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
  102468:	e9 39 f3 ff ff       	jmp    1017a6 <alltraps>

0010246d <vector243>:
.globl vector243
vector243:
  pushl $0
  10246d:	6a 00                	push   $0x0
  pushl $243
  10246f:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
  102474:	e9 2d f3 ff ff       	jmp    1017a6 <alltraps>

00102479 <vector244>:
.globl vector244
vector244:
  pushl $0
  102479:	6a 00                	push   $0x0
  pushl $244
  10247b:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
  102480:	e9 21 f3 ff ff       	jmp    1017a6 <alltraps>

00102485 <vector245>:
.globl vector245
vector245:
  pushl $0
  102485:	6a 00                	push   $0x0
  pushl $245
  102487:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
  10248c:	e9 15 f3 ff ff       	jmp    1017a6 <alltraps>

00102491 <vector246>:
.globl vector246
vector246:
  pushl $0
  102491:	6a 00                	push   $0x0
  pushl $246
  102493:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
  102498:	e9 09 f3 ff ff       	jmp    1017a6 <alltraps>

0010249d <vector247>:
.globl vector247
vector247:
  pushl $0
  10249d:	6a 00                	push   $0x0
  pushl $247
  10249f:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
  1024a4:	e9 fd f2 ff ff       	jmp    1017a6 <alltraps>

001024a9 <vector248>:
.globl vector248
vector248:
  pushl $0
  1024a9:	6a 00                	push   $0x0
  pushl $248
  1024ab:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
  1024b0:	e9 f1 f2 ff ff       	jmp    1017a6 <alltraps>

001024b5 <vector249>:
.globl vector249
vector249:
  pushl $0
  1024b5:	6a 00                	push   $0x0
  pushl $249
  1024b7:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
  1024bc:	e9 e5 f2 ff ff       	jmp    1017a6 <alltraps>

001024c1 <vector250>:
.globl vector250
vector250:
  pushl $0
  1024c1:	6a 00                	push   $0x0
  pushl $250
  1024c3:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
  1024c8:	e9 d9 f2 ff ff       	jmp    1017a6 <alltraps>

001024cd <vector251>:
.globl vector251
vector251:
  pushl $0
  1024cd:	6a 00                	push   $0x0
  pushl $251
  1024cf:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
  1024d4:	e9 cd f2 ff ff       	jmp    1017a6 <alltraps>

001024d9 <vector252>:
.globl vector252
vector252:
  pushl $0
  1024d9:	6a 00                	push   $0x0
  pushl $252
  1024db:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
  1024e0:	e9 c1 f2 ff ff       	jmp    1017a6 <alltraps>

001024e5 <vector253>:
.globl vector253
vector253:
  pushl $0
  1024e5:	6a 00                	push   $0x0
  pushl $253
  1024e7:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
  1024ec:	e9 b5 f2 ff ff       	jmp    1017a6 <alltraps>

001024f1 <vector254>:
.globl vector254
vector254:
  pushl $0
  1024f1:	6a 00                	push   $0x0
  pushl $254
  1024f3:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
  1024f8:	e9 a9 f2 ff ff       	jmp    1017a6 <alltraps>

001024fd <vector255>:
.globl vector255
vector255:
  pushl $0
  1024fd:	6a 00                	push   $0x0
  pushl $255
  1024ff:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
  102504:	e9 9d f2 ff ff       	jmp    1017a6 <alltraps>

00102509 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
  102509:	55                   	push   %ebp
  10250a:	89 e5                	mov    %esp,%ebp
  10250c:	83 ec 10             	sub    $0x10,%esp
  struct buf *b;

  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  10250f:	c7 05 38 d0 10 00 28 	movl   $0x10d028,0x10d038
  102516:	d0 10 00 
  bcache.head.next = &bcache.head;
  102519:	c7 05 3c d0 10 00 28 	movl   $0x10d028,0x10d03c
  102520:	d0 10 00 
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
  102523:	c7 45 fc e0 90 10 00 	movl   $0x1090e0,-0x4(%ebp)
  10252a:	eb 30                	jmp    10255c <binit+0x53>
    b->next = bcache.head.next;
  10252c:	8b 15 3c d0 10 00    	mov    0x10d03c,%edx
  102532:	8b 45 fc             	mov    -0x4(%ebp),%eax
  102535:	89 50 14             	mov    %edx,0x14(%eax)
    b->prev = &bcache.head;
  102538:	8b 45 fc             	mov    -0x4(%ebp),%eax
  10253b:	c7 40 10 28 d0 10 00 	movl   $0x10d028,0x10(%eax)
    bcache.head.next->prev = b;
  102542:	a1 3c d0 10 00       	mov    0x10d03c,%eax
  102547:	8b 55 fc             	mov    -0x4(%ebp),%edx
  10254a:	89 50 10             	mov    %edx,0x10(%eax)
    bcache.head.next = b;
  10254d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  102550:	a3 3c d0 10 00       	mov    %eax,0x10d03c
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
  102555:	81 45 fc 1c 02 00 00 	addl   $0x21c,-0x4(%ebp)
  10255c:	b8 28 d0 10 00       	mov    $0x10d028,%eax
  102561:	39 45 fc             	cmp    %eax,-0x4(%ebp)
  102564:	72 c6                	jb     10252c <binit+0x23>
  }
}
  102566:	90                   	nop
  102567:	90                   	nop
  102568:	c9                   	leave
  102569:	c3                   	ret

0010256a <bget>:
// Look through buffer cache for block on device dev.
// If not found, allocate a buffer.
// In either case, return locked buffer.
static struct buf*
bget(uint dev, uint blockno)
{
  10256a:	55                   	push   %ebp
  10256b:	89 e5                	mov    %esp,%ebp
  10256d:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // Is the block already cached?
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
  102570:	a1 3c d0 10 00       	mov    0x10d03c,%eax
  102575:	89 45 f4             	mov    %eax,-0xc(%ebp)
  102578:	eb 33                	jmp    1025ad <bget+0x43>
    if(b->dev == dev && b->blockno == blockno){
  10257a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10257d:	8b 40 04             	mov    0x4(%eax),%eax
  102580:	39 45 08             	cmp    %eax,0x8(%ebp)
  102583:	75 1f                	jne    1025a4 <bget+0x3a>
  102585:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102588:	8b 40 08             	mov    0x8(%eax),%eax
  10258b:	39 45 0c             	cmp    %eax,0xc(%ebp)
  10258e:	75 14                	jne    1025a4 <bget+0x3a>
      b->refcnt++;
  102590:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102593:	8b 40 0c             	mov    0xc(%eax),%eax
  102596:	8d 50 01             	lea    0x1(%eax),%edx
  102599:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10259c:	89 50 0c             	mov    %edx,0xc(%eax)
      return b;
  10259f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1025a2:	eb 7b                	jmp    10261f <bget+0xb5>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
  1025a4:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1025a7:	8b 40 14             	mov    0x14(%eax),%eax
  1025aa:	89 45 f4             	mov    %eax,-0xc(%ebp)
  1025ad:	81 7d f4 28 d0 10 00 	cmpl   $0x10d028,-0xc(%ebp)
  1025b4:	75 c4                	jne    10257a <bget+0x10>
  }

  // Not cached; recycle an unused buffer.
  // Even if refcnt==0, B_DIRTY indicates a buffer is in use
  // because log.c has modified it but not yet committed it.
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
  1025b6:	a1 38 d0 10 00       	mov    0x10d038,%eax
  1025bb:	89 45 f4             	mov    %eax,-0xc(%ebp)
  1025be:	eb 49                	jmp    102609 <bget+0x9f>
    if(b->refcnt == 0 && (b->flags & B_DIRTY) == 0) {
  1025c0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1025c3:	8b 40 0c             	mov    0xc(%eax),%eax
  1025c6:	85 c0                	test   %eax,%eax
  1025c8:	75 36                	jne    102600 <bget+0x96>
  1025ca:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1025cd:	8b 00                	mov    (%eax),%eax
  1025cf:	83 e0 04             	and    $0x4,%eax
  1025d2:	85 c0                	test   %eax,%eax
  1025d4:	75 2a                	jne    102600 <bget+0x96>
      b->dev = dev;
  1025d6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1025d9:	8b 55 08             	mov    0x8(%ebp),%edx
  1025dc:	89 50 04             	mov    %edx,0x4(%eax)
      b->blockno = blockno;
  1025df:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1025e2:	8b 55 0c             	mov    0xc(%ebp),%edx
  1025e5:	89 50 08             	mov    %edx,0x8(%eax)
      b->flags = 0;
  1025e8:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1025eb:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
      b->refcnt = 1;
  1025f1:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1025f4:	c7 40 0c 01 00 00 00 	movl   $0x1,0xc(%eax)
      return b;
  1025fb:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1025fe:	eb 1f                	jmp    10261f <bget+0xb5>
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
  102600:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102603:	8b 40 10             	mov    0x10(%eax),%eax
  102606:	89 45 f4             	mov    %eax,-0xc(%ebp)
  102609:	81 7d f4 28 d0 10 00 	cmpl   $0x10d028,-0xc(%ebp)
  102610:	75 ae                	jne    1025c0 <bget+0x56>
    }
  }
  panic("bget: no buffers");
  102612:	83 ec 0c             	sub    $0xc,%esp
  102615:	68 60 58 10 00       	push   $0x105860
  10261a:	e8 8f dc ff ff       	call   1002ae <panic>
}
  10261f:	c9                   	leave
  102620:	c3                   	ret

00102621 <bread>:

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
  102621:	55                   	push   %ebp
  102622:	89 e5                	mov    %esp,%ebp
  102624:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  b = bget(dev, blockno);
  102627:	83 ec 08             	sub    $0x8,%esp
  10262a:	ff 75 0c             	push   0xc(%ebp)
  10262d:	ff 75 08             	push   0x8(%ebp)
  102630:	e8 35 ff ff ff       	call   10256a <bget>
  102635:	83 c4 10             	add    $0x10,%esp
  102638:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if((b->flags & B_VALID) == 0) {
  10263b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10263e:	8b 00                	mov    (%eax),%eax
  102640:	83 e0 02             	and    $0x2,%eax
  102643:	85 c0                	test   %eax,%eax
  102645:	75 0e                	jne    102655 <bread+0x34>
    iderw(b);
  102647:	83 ec 0c             	sub    $0xc,%esp
  10264a:	ff 75 f4             	push   -0xc(%ebp)
  10264d:	e8 15 04 00 00       	call   102a67 <iderw>
  102652:	83 c4 10             	add    $0x10,%esp
  }
  return b;
  102655:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  102658:	c9                   	leave
  102659:	c3                   	ret

0010265a <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
  10265a:	55                   	push   %ebp
  10265b:	89 e5                	mov    %esp,%ebp
  10265d:	83 ec 08             	sub    $0x8,%esp
  b->flags |= B_DIRTY;
  102660:	8b 45 08             	mov    0x8(%ebp),%eax
  102663:	8b 00                	mov    (%eax),%eax
  102665:	83 c8 04             	or     $0x4,%eax
  102668:	89 c2                	mov    %eax,%edx
  10266a:	8b 45 08             	mov    0x8(%ebp),%eax
  10266d:	89 10                	mov    %edx,(%eax)
  iderw(b);
  10266f:	83 ec 0c             	sub    $0xc,%esp
  102672:	ff 75 08             	push   0x8(%ebp)
  102675:	e8 ed 03 00 00       	call   102a67 <iderw>
  10267a:	83 c4 10             	add    $0x10,%esp
}
  10267d:	90                   	nop
  10267e:	c9                   	leave
  10267f:	c3                   	ret

00102680 <brelse>:

// Release a buffer.
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
  102680:	55                   	push   %ebp
  102681:	89 e5                	mov    %esp,%ebp
  b->refcnt--;
  102683:	8b 45 08             	mov    0x8(%ebp),%eax
  102686:	8b 40 0c             	mov    0xc(%eax),%eax
  102689:	8d 50 ff             	lea    -0x1(%eax),%edx
  10268c:	8b 45 08             	mov    0x8(%ebp),%eax
  10268f:	89 50 0c             	mov    %edx,0xc(%eax)
  if (b->refcnt == 0) {
  102692:	8b 45 08             	mov    0x8(%ebp),%eax
  102695:	8b 40 0c             	mov    0xc(%eax),%eax
  102698:	85 c0                	test   %eax,%eax
  10269a:	75 47                	jne    1026e3 <brelse+0x63>
    // no one is waiting for it.
    b->next->prev = b->prev;
  10269c:	8b 45 08             	mov    0x8(%ebp),%eax
  10269f:	8b 40 14             	mov    0x14(%eax),%eax
  1026a2:	8b 55 08             	mov    0x8(%ebp),%edx
  1026a5:	8b 52 10             	mov    0x10(%edx),%edx
  1026a8:	89 50 10             	mov    %edx,0x10(%eax)
    b->prev->next = b->next;
  1026ab:	8b 45 08             	mov    0x8(%ebp),%eax
  1026ae:	8b 40 10             	mov    0x10(%eax),%eax
  1026b1:	8b 55 08             	mov    0x8(%ebp),%edx
  1026b4:	8b 52 14             	mov    0x14(%edx),%edx
  1026b7:	89 50 14             	mov    %edx,0x14(%eax)
    b->next = bcache.head.next;
  1026ba:	8b 15 3c d0 10 00    	mov    0x10d03c,%edx
  1026c0:	8b 45 08             	mov    0x8(%ebp),%eax
  1026c3:	89 50 14             	mov    %edx,0x14(%eax)
    b->prev = &bcache.head;
  1026c6:	8b 45 08             	mov    0x8(%ebp),%eax
  1026c9:	c7 40 10 28 d0 10 00 	movl   $0x10d028,0x10(%eax)
    bcache.head.next->prev = b;
  1026d0:	a1 3c d0 10 00       	mov    0x10d03c,%eax
  1026d5:	8b 55 08             	mov    0x8(%ebp),%edx
  1026d8:	89 50 10             	mov    %edx,0x10(%eax)
    bcache.head.next = b;
  1026db:	8b 45 08             	mov    0x8(%ebp),%eax
  1026de:	a3 3c d0 10 00       	mov    %eax,0x10d03c
  }
  1026e3:	90                   	nop
  1026e4:	5d                   	pop    %ebp
  1026e5:	c3                   	ret

001026e6 <inb>:
// Simple PIO-based (non-DMA) IDE driver code.

#include "types.h"
#include "defs.h"
#include "param.h"
  1026e6:	55                   	push   %ebp
  1026e7:	89 e5                	mov    %esp,%ebp
  1026e9:	83 ec 14             	sub    $0x14,%esp
  1026ec:	8b 45 08             	mov    0x8(%ebp),%eax
  1026ef:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
#include "mmu.h"
#include "proc.h"
#include "x86.h"
  1026f3:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
  1026f7:	89 c2                	mov    %eax,%edx
  1026f9:	ec                   	in     (%dx),%al
  1026fa:	88 45 ff             	mov    %al,-0x1(%ebp)
#include "traps.h"
  1026fd:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
#include "fs.h"
  102701:	c9                   	leave
  102702:	c3                   	ret

00102703 <insl>:
#include "buf.h"

#define SECTOR_SIZE   512
#define IDE_BSY       0x80
  102703:	55                   	push   %ebp
  102704:	89 e5                	mov    %esp,%ebp
  102706:	57                   	push   %edi
  102707:	53                   	push   %ebx
#define IDE_DRDY      0x40
  102708:	8b 55 08             	mov    0x8(%ebp),%edx
  10270b:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  10270e:	8b 45 10             	mov    0x10(%ebp),%eax
  102711:	89 cb                	mov    %ecx,%ebx
  102713:	89 df                	mov    %ebx,%edi
  102715:	89 c1                	mov    %eax,%ecx
  102717:	fc                   	cld
  102718:	f3 6d                	rep insl (%dx),%es:(%edi)
  10271a:	89 c8                	mov    %ecx,%eax
  10271c:	89 fb                	mov    %edi,%ebx
  10271e:	89 5d 0c             	mov    %ebx,0xc(%ebp)
  102721:	89 45 10             	mov    %eax,0x10(%ebp)
#define IDE_DF        0x20
#define IDE_ERR       0x01

#define IDE_CMD_READ  0x20
  102724:	90                   	nop
  102725:	5b                   	pop    %ebx
  102726:	5f                   	pop    %edi
  102727:	5d                   	pop    %ebp
  102728:	c3                   	ret

00102729 <outb>:
#define IDE_CMD_WRITE 0x30
#define IDE_CMD_RDMUL 0xc4
#define IDE_CMD_WRMUL 0xc5

  102729:	55                   	push   %ebp
  10272a:	89 e5                	mov    %esp,%ebp
  10272c:	83 ec 08             	sub    $0x8,%esp
  10272f:	8b 55 08             	mov    0x8(%ebp),%edx
  102732:	8b 45 0c             	mov    0xc(%ebp),%eax
  102735:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
  102739:	88 45 f8             	mov    %al,-0x8(%ebp)
// idequeue points to the buf now being read/written to the disk.
  10273c:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
  102740:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
  102744:	ee                   	out    %al,(%dx)
// idequeue->qnext points to the next buf to be processed.
  102745:	90                   	nop
  102746:	c9                   	leave
  102747:	c3                   	ret

00102748 <outsl>:
static int havedisk1;
static void idestart(struct buf*);

// Wait for IDE disk to become ready.
static int
idewait(int checkerr)
  102748:	55                   	push   %ebp
  102749:	89 e5                	mov    %esp,%ebp
  10274b:	56                   	push   %esi
  10274c:	53                   	push   %ebx
{
  10274d:	8b 55 08             	mov    0x8(%ebp),%edx
  102750:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  102753:	8b 45 10             	mov    0x10(%ebp),%eax
  102756:	89 cb                	mov    %ecx,%ebx
  102758:	89 de                	mov    %ebx,%esi
  10275a:	89 c1                	mov    %eax,%ecx
  10275c:	fc                   	cld
  10275d:	f3 6f                	rep outsl %ds:(%esi),(%dx)
  10275f:	89 c8                	mov    %ecx,%eax
  102761:	89 f3                	mov    %esi,%ebx
  102763:	89 5d 0c             	mov    %ebx,0xc(%ebp)
  102766:	89 45 10             	mov    %eax,0x10(%ebp)
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY);
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
  102769:	90                   	nop
  10276a:	5b                   	pop    %ebx
  10276b:	5e                   	pop    %esi
  10276c:	5d                   	pop    %ebp
  10276d:	c3                   	ret

0010276e <noop>:
{
  struct buf **pp;

  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
  10276e:	55                   	push   %ebp
  10276f:	89 e5                	mov    %esp,%ebp
    panic("iderw: ide disk 1 not present");
  102771:	90                   	nop

  102772:	90                   	nop
  102773:	5d                   	pop    %ebp
  102774:	c3                   	ret

00102775 <idewait>:
{
  102775:	55                   	push   %ebp
  102776:	89 e5                	mov    %esp,%ebp
  102778:	83 ec 10             	sub    $0x10,%esp
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY);
  10277b:	90                   	nop
  10277c:	68 f7 01 00 00       	push   $0x1f7
  102781:	e8 60 ff ff ff       	call   1026e6 <inb>
  102786:	83 c4 04             	add    $0x4,%esp
  102789:	0f b6 c0             	movzbl %al,%eax
  10278c:	89 45 fc             	mov    %eax,-0x4(%ebp)
  10278f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  102792:	25 c0 00 00 00       	and    $0xc0,%eax
  102797:	83 f8 40             	cmp    $0x40,%eax
  10279a:	75 e0                	jne    10277c <idewait+0x7>
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
  10279c:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  1027a0:	74 11                	je     1027b3 <idewait+0x3e>
  1027a2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1027a5:	83 e0 21             	and    $0x21,%eax
  1027a8:	85 c0                	test   %eax,%eax
  1027aa:	74 07                	je     1027b3 <idewait+0x3e>
    return -1;
  1027ac:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  1027b1:	eb 05                	jmp    1027b8 <idewait+0x43>
  return 0;
  1027b3:	b8 00 00 00 00       	mov    $0x0,%eax
}
  1027b8:	c9                   	leave
  1027b9:	c3                   	ret

001027ba <ideinit>:
{
  1027ba:	55                   	push   %ebp
  1027bb:	89 e5                	mov    %esp,%ebp
  1027bd:	83 ec 18             	sub    $0x18,%esp
  ioapicenable(IRQ_IDE, ncpu - 1);
  1027c0:	a1 80 6a 10 00       	mov    0x106a80,%eax
  1027c5:	83 e8 01             	sub    $0x1,%eax
  1027c8:	83 ec 08             	sub    $0x8,%esp
  1027cb:	50                   	push   %eax
  1027cc:	6a 0e                	push   $0xe
  1027ce:	e8 e1 de ff ff       	call   1006b4 <ioapicenable>
  1027d3:	83 c4 10             	add    $0x10,%esp
  idewait(0);
  1027d6:	83 ec 0c             	sub    $0xc,%esp
  1027d9:	6a 00                	push   $0x0
  1027db:	e8 95 ff ff ff       	call   102775 <idewait>
  1027e0:	83 c4 10             	add    $0x10,%esp
  outb(0x1f6, 0xe0 | (1<<4));
  1027e3:	83 ec 08             	sub    $0x8,%esp
  1027e6:	68 f0 00 00 00       	push   $0xf0
  1027eb:	68 f6 01 00 00       	push   $0x1f6
  1027f0:	e8 34 ff ff ff       	call   102729 <outb>
  1027f5:	83 c4 10             	add    $0x10,%esp
  for(i=0; i<1000; i++){
  1027f8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  1027ff:	eb 24                	jmp    102825 <ideinit+0x6b>
    if(inb(0x1f7) != 0){
  102801:	83 ec 0c             	sub    $0xc,%esp
  102804:	68 f7 01 00 00       	push   $0x1f7
  102809:	e8 d8 fe ff ff       	call   1026e6 <inb>
  10280e:	83 c4 10             	add    $0x10,%esp
  102811:	84 c0                	test   %al,%al
  102813:	74 0c                	je     102821 <ideinit+0x67>
      havedisk1 = 1;
  102815:	c7 05 48 d2 10 00 01 	movl   $0x1,0x10d248
  10281c:	00 00 00 
      break;
  10281f:	eb 0d                	jmp    10282e <ideinit+0x74>
  for(i=0; i<1000; i++){
  102821:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  102825:	81 7d f4 e7 03 00 00 	cmpl   $0x3e7,-0xc(%ebp)
  10282c:	7e d3                	jle    102801 <ideinit+0x47>
  outb(0x1f6, 0xe0 | (0<<4));
  10282e:	83 ec 08             	sub    $0x8,%esp
  102831:	68 e0 00 00 00       	push   $0xe0
  102836:	68 f6 01 00 00       	push   $0x1f6
  10283b:	e8 e9 fe ff ff       	call   102729 <outb>
  102840:	83 c4 10             	add    $0x10,%esp
}
  102843:	90                   	nop
  102844:	c9                   	leave
  102845:	c3                   	ret

00102846 <idestart>:
{
  102846:	55                   	push   %ebp
  102847:	89 e5                	mov    %esp,%ebp
  102849:	83 ec 18             	sub    $0x18,%esp
  if(b == 0)
  10284c:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  102850:	75 0d                	jne    10285f <idestart+0x19>
    panic("idestart");
  102852:	83 ec 0c             	sub    $0xc,%esp
  102855:	68 71 58 10 00       	push   $0x105871
  10285a:	e8 4f da ff ff       	call   1002ae <panic>
  if(b->blockno >= FSSIZE)
  10285f:	8b 45 08             	mov    0x8(%ebp),%eax
  102862:	8b 40 08             	mov    0x8(%eax),%eax
  102865:	3d e7 03 00 00       	cmp    $0x3e7,%eax
  10286a:	76 0d                	jbe    102879 <idestart+0x33>
    panic("incorrect blockno");
  10286c:	83 ec 0c             	sub    $0xc,%esp
  10286f:	68 7a 58 10 00       	push   $0x10587a
  102874:	e8 35 da ff ff       	call   1002ae <panic>
  int sector_per_block =  BSIZE/SECTOR_SIZE;
  102879:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
  int sector = b->blockno * sector_per_block;
  102880:	8b 45 08             	mov    0x8(%ebp),%eax
  102883:	8b 50 08             	mov    0x8(%eax),%edx
  102886:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102889:	0f af c2             	imul   %edx,%eax
  10288c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  int read_cmd = (sector_per_block == 1) ? IDE_CMD_READ :  IDE_CMD_RDMUL;
  10288f:	83 7d f4 01          	cmpl   $0x1,-0xc(%ebp)
  102893:	75 07                	jne    10289c <idestart+0x56>
  102895:	b8 20 00 00 00       	mov    $0x20,%eax
  10289a:	eb 05                	jmp    1028a1 <idestart+0x5b>
  10289c:	b8 c4 00 00 00       	mov    $0xc4,%eax
  1028a1:	89 45 ec             	mov    %eax,-0x14(%ebp)
  int write_cmd = (sector_per_block == 1) ? IDE_CMD_WRITE : IDE_CMD_WRMUL;
  1028a4:	83 7d f4 01          	cmpl   $0x1,-0xc(%ebp)
  1028a8:	75 07                	jne    1028b1 <idestart+0x6b>
  1028aa:	b8 30 00 00 00       	mov    $0x30,%eax
  1028af:	eb 05                	jmp    1028b6 <idestart+0x70>
  1028b1:	b8 c5 00 00 00       	mov    $0xc5,%eax
  1028b6:	89 45 e8             	mov    %eax,-0x18(%ebp)
  if (sector_per_block > 7) panic("idestart");
  1028b9:	83 7d f4 07          	cmpl   $0x7,-0xc(%ebp)
  1028bd:	7e 0d                	jle    1028cc <idestart+0x86>
  1028bf:	83 ec 0c             	sub    $0xc,%esp
  1028c2:	68 71 58 10 00       	push   $0x105871
  1028c7:	e8 e2 d9 ff ff       	call   1002ae <panic>
  idewait(0);
  1028cc:	83 ec 0c             	sub    $0xc,%esp
  1028cf:	6a 00                	push   $0x0
  1028d1:	e8 9f fe ff ff       	call   102775 <idewait>
  1028d6:	83 c4 10             	add    $0x10,%esp
  outb(0x3f6, 0);  // generate interrupt
  1028d9:	83 ec 08             	sub    $0x8,%esp
  1028dc:	6a 00                	push   $0x0
  1028de:	68 f6 03 00 00       	push   $0x3f6
  1028e3:	e8 41 fe ff ff       	call   102729 <outb>
  1028e8:	83 c4 10             	add    $0x10,%esp
  outb(0x1f2, sector_per_block);  // number of sectors
  1028eb:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1028ee:	0f b6 c0             	movzbl %al,%eax
  1028f1:	83 ec 08             	sub    $0x8,%esp
  1028f4:	50                   	push   %eax
  1028f5:	68 f2 01 00 00       	push   $0x1f2
  1028fa:	e8 2a fe ff ff       	call   102729 <outb>
  1028ff:	83 c4 10             	add    $0x10,%esp
  outb(0x1f3, sector & 0xff);
  102902:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102905:	0f b6 c0             	movzbl %al,%eax
  102908:	83 ec 08             	sub    $0x8,%esp
  10290b:	50                   	push   %eax
  10290c:	68 f3 01 00 00       	push   $0x1f3
  102911:	e8 13 fe ff ff       	call   102729 <outb>
  102916:	83 c4 10             	add    $0x10,%esp
  outb(0x1f4, (sector >> 8) & 0xff);
  102919:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10291c:	c1 f8 08             	sar    $0x8,%eax
  10291f:	0f b6 c0             	movzbl %al,%eax
  102922:	83 ec 08             	sub    $0x8,%esp
  102925:	50                   	push   %eax
  102926:	68 f4 01 00 00       	push   $0x1f4
  10292b:	e8 f9 fd ff ff       	call   102729 <outb>
  102930:	83 c4 10             	add    $0x10,%esp
  outb(0x1f5, (sector >> 16) & 0xff);
  102933:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102936:	c1 f8 10             	sar    $0x10,%eax
  102939:	0f b6 c0             	movzbl %al,%eax
  10293c:	83 ec 08             	sub    $0x8,%esp
  10293f:	50                   	push   %eax
  102940:	68 f5 01 00 00       	push   $0x1f5
  102945:	e8 df fd ff ff       	call   102729 <outb>
  10294a:	83 c4 10             	add    $0x10,%esp
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
  10294d:	8b 45 08             	mov    0x8(%ebp),%eax
  102950:	8b 40 04             	mov    0x4(%eax),%eax
  102953:	c1 e0 04             	shl    $0x4,%eax
  102956:	83 e0 10             	and    $0x10,%eax
  102959:	89 c2                	mov    %eax,%edx
  10295b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10295e:	c1 f8 18             	sar    $0x18,%eax
  102961:	83 e0 0f             	and    $0xf,%eax
  102964:	09 d0                	or     %edx,%eax
  102966:	83 c8 e0             	or     $0xffffffe0,%eax
  102969:	0f b6 c0             	movzbl %al,%eax
  10296c:	83 ec 08             	sub    $0x8,%esp
  10296f:	50                   	push   %eax
  102970:	68 f6 01 00 00       	push   $0x1f6
  102975:	e8 af fd ff ff       	call   102729 <outb>
  10297a:	83 c4 10             	add    $0x10,%esp
  if(b->flags & B_DIRTY){
  10297d:	8b 45 08             	mov    0x8(%ebp),%eax
  102980:	8b 00                	mov    (%eax),%eax
  102982:	83 e0 04             	and    $0x4,%eax
  102985:	85 c0                	test   %eax,%eax
  102987:	74 35                	je     1029be <idestart+0x178>
    outb(0x1f7, write_cmd);
  102989:	8b 45 e8             	mov    -0x18(%ebp),%eax
  10298c:	0f b6 c0             	movzbl %al,%eax
  10298f:	83 ec 08             	sub    $0x8,%esp
  102992:	50                   	push   %eax
  102993:	68 f7 01 00 00       	push   $0x1f7
  102998:	e8 8c fd ff ff       	call   102729 <outb>
  10299d:	83 c4 10             	add    $0x10,%esp
    outsl(0x1f0, b->data, BSIZE/4);
  1029a0:	8b 45 08             	mov    0x8(%ebp),%eax
  1029a3:	83 c0 1c             	add    $0x1c,%eax
  1029a6:	83 ec 04             	sub    $0x4,%esp
  1029a9:	68 80 00 00 00       	push   $0x80
  1029ae:	50                   	push   %eax
  1029af:	68 f0 01 00 00       	push   $0x1f0
  1029b4:	e8 8f fd ff ff       	call   102748 <outsl>
  1029b9:	83 c4 10             	add    $0x10,%esp
}
  1029bc:	eb 17                	jmp    1029d5 <idestart+0x18f>
    outb(0x1f7, read_cmd);
  1029be:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1029c1:	0f b6 c0             	movzbl %al,%eax
  1029c4:	83 ec 08             	sub    $0x8,%esp
  1029c7:	50                   	push   %eax
  1029c8:	68 f7 01 00 00       	push   $0x1f7
  1029cd:	e8 57 fd ff ff       	call   102729 <outb>
  1029d2:	83 c4 10             	add    $0x10,%esp
}
  1029d5:	90                   	nop
  1029d6:	c9                   	leave
  1029d7:	c3                   	ret

001029d8 <ideintr>:
{
  1029d8:	55                   	push   %ebp
  1029d9:	89 e5                	mov    %esp,%ebp
  1029db:	83 ec 18             	sub    $0x18,%esp
  if((b = idequeue) == 0){
  1029de:	a1 44 d2 10 00       	mov    0x10d244,%eax
  1029e3:	89 45 f4             	mov    %eax,-0xc(%ebp)
  1029e6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  1029ea:	74 78                	je     102a64 <ideintr+0x8c>
  idequeue = b->qnext;
  1029ec:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1029ef:	8b 40 18             	mov    0x18(%eax),%eax
  1029f2:	a3 44 d2 10 00       	mov    %eax,0x10d244
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
  1029f7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1029fa:	8b 00                	mov    (%eax),%eax
  1029fc:	83 e0 04             	and    $0x4,%eax
  1029ff:	85 c0                	test   %eax,%eax
  102a01:	75 27                	jne    102a2a <ideintr+0x52>
  102a03:	6a 01                	push   $0x1
  102a05:	e8 6b fd ff ff       	call   102775 <idewait>
  102a0a:	83 c4 04             	add    $0x4,%esp
  102a0d:	85 c0                	test   %eax,%eax
  102a0f:	78 19                	js     102a2a <ideintr+0x52>
    insl(0x1f0, b->data, BSIZE/4);
  102a11:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102a14:	83 c0 1c             	add    $0x1c,%eax
  102a17:	68 80 00 00 00       	push   $0x80
  102a1c:	50                   	push   %eax
  102a1d:	68 f0 01 00 00       	push   $0x1f0
  102a22:	e8 dc fc ff ff       	call   102703 <insl>
  102a27:	83 c4 0c             	add    $0xc,%esp
  b->flags |= B_VALID;
  102a2a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102a2d:	8b 00                	mov    (%eax),%eax
  102a2f:	83 c8 02             	or     $0x2,%eax
  102a32:	89 c2                	mov    %eax,%edx
  102a34:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102a37:	89 10                	mov    %edx,(%eax)
  b->flags &= ~B_DIRTY;
  102a39:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102a3c:	8b 00                	mov    (%eax),%eax
  102a3e:	83 e0 fb             	and    $0xfffffffb,%eax
  102a41:	89 c2                	mov    %eax,%edx
  102a43:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102a46:	89 10                	mov    %edx,(%eax)
  if(idequeue != 0)
  102a48:	a1 44 d2 10 00       	mov    0x10d244,%eax
  102a4d:	85 c0                	test   %eax,%eax
  102a4f:	74 14                	je     102a65 <ideintr+0x8d>
    idestart(idequeue);
  102a51:	a1 44 d2 10 00       	mov    0x10d244,%eax
  102a56:	83 ec 0c             	sub    $0xc,%esp
  102a59:	50                   	push   %eax
  102a5a:	e8 e7 fd ff ff       	call   102846 <idestart>
  102a5f:	83 c4 10             	add    $0x10,%esp
  102a62:	eb 01                	jmp    102a65 <ideintr+0x8d>
    return;
  102a64:	90                   	nop
}
  102a65:	c9                   	leave
  102a66:	c3                   	ret

00102a67 <iderw>:
{
  102a67:	55                   	push   %ebp
  102a68:	89 e5                	mov    %esp,%ebp
  102a6a:	83 ec 18             	sub    $0x18,%esp
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
  102a6d:	8b 45 08             	mov    0x8(%ebp),%eax
  102a70:	8b 00                	mov    (%eax),%eax
  102a72:	83 e0 06             	and    $0x6,%eax
  102a75:	83 f8 02             	cmp    $0x2,%eax
  102a78:	75 0d                	jne    102a87 <iderw+0x20>
    panic("iderw: nothing to do");
  102a7a:	83 ec 0c             	sub    $0xc,%esp
  102a7d:	68 8c 58 10 00       	push   $0x10588c
  102a82:	e8 27 d8 ff ff       	call   1002ae <panic>
  if(b->dev != 0 && !havedisk1)
  102a87:	8b 45 08             	mov    0x8(%ebp),%eax
  102a8a:	8b 40 04             	mov    0x4(%eax),%eax
  102a8d:	85 c0                	test   %eax,%eax
  102a8f:	74 16                	je     102aa7 <iderw+0x40>
  102a91:	a1 48 d2 10 00       	mov    0x10d248,%eax
  102a96:	85 c0                	test   %eax,%eax
  102a98:	75 0d                	jne    102aa7 <iderw+0x40>
    panic("iderw: ide disk 1 not present");
  102a9a:	83 ec 0c             	sub    $0xc,%esp
  102a9d:	68 a1 58 10 00       	push   $0x1058a1
  102aa2:	e8 07 d8 ff ff       	call   1002ae <panic>
  // Append b to idequeue.
  b->qnext = 0;
  102aa7:	8b 45 08             	mov    0x8(%ebp),%eax
  102aaa:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
  102ab1:	c7 45 f4 44 d2 10 00 	movl   $0x10d244,-0xc(%ebp)
  102ab8:	eb 0b                	jmp    102ac5 <iderw+0x5e>
  102aba:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102abd:	8b 00                	mov    (%eax),%eax
  102abf:	83 c0 18             	add    $0x18,%eax
  102ac2:	89 45 f4             	mov    %eax,-0xc(%ebp)
  102ac5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102ac8:	8b 00                	mov    (%eax),%eax
  102aca:	85 c0                	test   %eax,%eax
  102acc:	75 ec                	jne    102aba <iderw+0x53>
    ;
  *pp = b;
  102ace:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102ad1:	8b 55 08             	mov    0x8(%ebp),%edx
  102ad4:	89 10                	mov    %edx,(%eax)

  // Start disk if necessary.
  if(idequeue == b)
  102ad6:	a1 44 d2 10 00       	mov    0x10d244,%eax
  102adb:	39 45 08             	cmp    %eax,0x8(%ebp)
  102ade:	75 15                	jne    102af5 <iderw+0x8e>
    idestart(b);
  102ae0:	83 ec 0c             	sub    $0xc,%esp
  102ae3:	ff 75 08             	push   0x8(%ebp)
  102ae6:	e8 5b fd ff ff       	call   102846 <idestart>
  102aeb:	83 c4 10             	add    $0x10,%esp

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID)
  102aee:	eb 05                	jmp    102af5 <iderw+0x8e>
  {
    // Warning: If we do not call noop(), compiler generates code that does not
    // read "b->flags" again and therefore never come out of this while loop. 
    // "b->flags" is modified by the trap handler in ideintr().  
    noop();
  102af0:	e8 79 fc ff ff       	call   10276e <noop>
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID)
  102af5:	8b 45 08             	mov    0x8(%ebp),%eax
  102af8:	8b 00                	mov    (%eax),%eax
  102afa:	83 e0 06             	and    $0x6,%eax
  102afd:	83 f8 02             	cmp    $0x2,%eax
  102b00:	75 ee                	jne    102af0 <iderw+0x89>
  }
}
  102b02:	90                   	nop
  102b03:	90                   	nop
  102b04:	c9                   	leave
  102b05:	c3                   	ret

00102b06 <readsb>:
struct superblock sb; 

// Read the super block.
void
readsb(int dev, struct superblock *sb)
{
  102b06:	55                   	push   %ebp
  102b07:	89 e5                	mov    %esp,%ebp
  102b09:	83 ec 18             	sub    $0x18,%esp
  struct buf *bp;

  bp = bread(dev, 1);
  102b0c:	8b 45 08             	mov    0x8(%ebp),%eax
  102b0f:	83 ec 08             	sub    $0x8,%esp
  102b12:	6a 01                	push   $0x1
  102b14:	50                   	push   %eax
  102b15:	e8 07 fb ff ff       	call   102621 <bread>
  102b1a:	83 c4 10             	add    $0x10,%esp
  102b1d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memmove(sb, bp->data, sizeof(*sb));
  102b20:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102b23:	83 c0 1c             	add    $0x1c,%eax
  102b26:	83 ec 04             	sub    $0x4,%esp
  102b29:	6a 1c                	push   $0x1c
  102b2b:	50                   	push   %eax
  102b2c:	ff 75 0c             	push   0xc(%ebp)
  102b2f:	e8 8d e4 ff ff       	call   100fc1 <memmove>
  102b34:	83 c4 10             	add    $0x10,%esp
  brelse(bp);
  102b37:	83 ec 0c             	sub    $0xc,%esp
  102b3a:	ff 75 f4             	push   -0xc(%ebp)
  102b3d:	e8 3e fb ff ff       	call   102680 <brelse>
  102b42:	83 c4 10             	add    $0x10,%esp
}
  102b45:	90                   	nop
  102b46:	c9                   	leave
  102b47:	c3                   	ret

00102b48 <bzero>:

// Zero a block.
static void
bzero(int dev, int bno)
{
  102b48:	55                   	push   %ebp
  102b49:	89 e5                	mov    %esp,%ebp
  102b4b:	83 ec 18             	sub    $0x18,%esp
  struct buf *bp;

  bp = bread(dev, bno);
  102b4e:	8b 55 0c             	mov    0xc(%ebp),%edx
  102b51:	8b 45 08             	mov    0x8(%ebp),%eax
  102b54:	83 ec 08             	sub    $0x8,%esp
  102b57:	52                   	push   %edx
  102b58:	50                   	push   %eax
  102b59:	e8 c3 fa ff ff       	call   102621 <bread>
  102b5e:	83 c4 10             	add    $0x10,%esp
  102b61:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(bp->data, 0, BSIZE);
  102b64:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102b67:	83 c0 1c             	add    $0x1c,%eax
  102b6a:	83 ec 04             	sub    $0x4,%esp
  102b6d:	68 00 02 00 00       	push   $0x200
  102b72:	6a 00                	push   $0x0
  102b74:	50                   	push   %eax
  102b75:	e8 88 e3 ff ff       	call   100f02 <memset>
  102b7a:	83 c4 10             	add    $0x10,%esp
  log_write(bp);
  102b7d:	83 ec 0c             	sub    $0xc,%esp
  102b80:	ff 75 f4             	push   -0xc(%ebp)
  102b83:	e8 92 1a 00 00       	call   10461a <log_write>
  102b88:	83 c4 10             	add    $0x10,%esp
  brelse(bp);
  102b8b:	83 ec 0c             	sub    $0xc,%esp
  102b8e:	ff 75 f4             	push   -0xc(%ebp)
  102b91:	e8 ea fa ff ff       	call   102680 <brelse>
  102b96:	83 c4 10             	add    $0x10,%esp
}
  102b99:	90                   	nop
  102b9a:	c9                   	leave
  102b9b:	c3                   	ret

00102b9c <balloc>:
// Blocks.

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
  102b9c:	55                   	push   %ebp
  102b9d:	89 e5                	mov    %esp,%ebp
  102b9f:	83 ec 18             	sub    $0x18,%esp
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  102ba2:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(b = 0; b < sb.size; b += BPB){
  102ba9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  102bb0:	e9 0b 01 00 00       	jmp    102cc0 <balloc+0x124>
    bp = bread(dev, BBLOCK(b, sb));
  102bb5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102bb8:	8d 90 ff 0f 00 00    	lea    0xfff(%eax),%edx
  102bbe:	85 c0                	test   %eax,%eax
  102bc0:	0f 48 c2             	cmovs  %edx,%eax
  102bc3:	c1 f8 0c             	sar    $0xc,%eax
  102bc6:	89 c2                	mov    %eax,%edx
  102bc8:	a1 78 d2 10 00       	mov    0x10d278,%eax
  102bcd:	01 d0                	add    %edx,%eax
  102bcf:	83 ec 08             	sub    $0x8,%esp
  102bd2:	50                   	push   %eax
  102bd3:	ff 75 08             	push   0x8(%ebp)
  102bd6:	e8 46 fa ff ff       	call   102621 <bread>
  102bdb:	83 c4 10             	add    $0x10,%esp
  102bde:	89 45 ec             	mov    %eax,-0x14(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
  102be1:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  102be8:	e9 9e 00 00 00       	jmp    102c8b <balloc+0xef>
      m = 1 << (bi % 8);
  102bed:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102bf0:	83 e0 07             	and    $0x7,%eax
  102bf3:	ba 01 00 00 00       	mov    $0x1,%edx
  102bf8:	89 c1                	mov    %eax,%ecx
  102bfa:	d3 e2                	shl    %cl,%edx
  102bfc:	89 d0                	mov    %edx,%eax
  102bfe:	89 45 e8             	mov    %eax,-0x18(%ebp)
      if((bp->data[bi/8] & m) == 0){  // Is block free?
  102c01:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102c04:	8d 50 07             	lea    0x7(%eax),%edx
  102c07:	85 c0                	test   %eax,%eax
  102c09:	0f 48 c2             	cmovs  %edx,%eax
  102c0c:	c1 f8 03             	sar    $0x3,%eax
  102c0f:	89 c2                	mov    %eax,%edx
  102c11:	8b 45 ec             	mov    -0x14(%ebp),%eax
  102c14:	0f b6 44 10 1c       	movzbl 0x1c(%eax,%edx,1),%eax
  102c19:	0f b6 c0             	movzbl %al,%eax
  102c1c:	23 45 e8             	and    -0x18(%ebp),%eax
  102c1f:	85 c0                	test   %eax,%eax
  102c21:	75 64                	jne    102c87 <balloc+0xeb>
        bp->data[bi/8] |= m;  // Mark block in use.
  102c23:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102c26:	8d 50 07             	lea    0x7(%eax),%edx
  102c29:	85 c0                	test   %eax,%eax
  102c2b:	0f 48 c2             	cmovs  %edx,%eax
  102c2e:	c1 f8 03             	sar    $0x3,%eax
  102c31:	8b 55 ec             	mov    -0x14(%ebp),%edx
  102c34:	0f b6 54 02 1c       	movzbl 0x1c(%edx,%eax,1),%edx
  102c39:	89 d1                	mov    %edx,%ecx
  102c3b:	8b 55 e8             	mov    -0x18(%ebp),%edx
  102c3e:	09 ca                	or     %ecx,%edx
  102c40:	89 d1                	mov    %edx,%ecx
  102c42:	8b 55 ec             	mov    -0x14(%ebp),%edx
  102c45:	88 4c 02 1c          	mov    %cl,0x1c(%edx,%eax,1)
        log_write(bp);
  102c49:	83 ec 0c             	sub    $0xc,%esp
  102c4c:	ff 75 ec             	push   -0x14(%ebp)
  102c4f:	e8 c6 19 00 00       	call   10461a <log_write>
  102c54:	83 c4 10             	add    $0x10,%esp
        brelse(bp);
  102c57:	83 ec 0c             	sub    $0xc,%esp
  102c5a:	ff 75 ec             	push   -0x14(%ebp)
  102c5d:	e8 1e fa ff ff       	call   102680 <brelse>
  102c62:	83 c4 10             	add    $0x10,%esp
        bzero(dev, b + bi);
  102c65:	8b 55 f4             	mov    -0xc(%ebp),%edx
  102c68:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102c6b:	01 c2                	add    %eax,%edx
  102c6d:	8b 45 08             	mov    0x8(%ebp),%eax
  102c70:	83 ec 08             	sub    $0x8,%esp
  102c73:	52                   	push   %edx
  102c74:	50                   	push   %eax
  102c75:	e8 ce fe ff ff       	call   102b48 <bzero>
  102c7a:	83 c4 10             	add    $0x10,%esp
        return b + bi;
  102c7d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  102c80:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102c83:	01 d0                	add    %edx,%eax
  102c85:	eb 56                	jmp    102cdd <balloc+0x141>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
  102c87:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
  102c8b:	81 7d f0 ff 0f 00 00 	cmpl   $0xfff,-0x10(%ebp)
  102c92:	7f 17                	jg     102cab <balloc+0x10f>
  102c94:	8b 55 f4             	mov    -0xc(%ebp),%edx
  102c97:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102c9a:	01 d0                	add    %edx,%eax
  102c9c:	89 c2                	mov    %eax,%edx
  102c9e:	a1 60 d2 10 00       	mov    0x10d260,%eax
  102ca3:	39 c2                	cmp    %eax,%edx
  102ca5:	0f 82 42 ff ff ff    	jb     102bed <balloc+0x51>
      }
    }
    brelse(bp);
  102cab:	83 ec 0c             	sub    $0xc,%esp
  102cae:	ff 75 ec             	push   -0x14(%ebp)
  102cb1:	e8 ca f9 ff ff       	call   102680 <brelse>
  102cb6:	83 c4 10             	add    $0x10,%esp
  for(b = 0; b < sb.size; b += BPB){
  102cb9:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
  102cc0:	a1 60 d2 10 00       	mov    0x10d260,%eax
  102cc5:	8b 55 f4             	mov    -0xc(%ebp),%edx
  102cc8:	39 c2                	cmp    %eax,%edx
  102cca:	0f 82 e5 fe ff ff    	jb     102bb5 <balloc+0x19>
  }
  panic("balloc: out of blocks");
  102cd0:	83 ec 0c             	sub    $0xc,%esp
  102cd3:	68 c0 58 10 00       	push   $0x1058c0
  102cd8:	e8 d1 d5 ff ff       	call   1002ae <panic>
}
  102cdd:	c9                   	leave
  102cde:	c3                   	ret

00102cdf <bfree>:


// Free a disk block.
static void
bfree(int dev, uint b)
{
  102cdf:	55                   	push   %ebp
  102ce0:	89 e5                	mov    %esp,%ebp
  102ce2:	83 ec 18             	sub    $0x18,%esp
  struct buf *bp;
  int bi, m;

  bp = bread(dev, BBLOCK(b, sb));
  102ce5:	8b 45 0c             	mov    0xc(%ebp),%eax
  102ce8:	c1 e8 0c             	shr    $0xc,%eax
  102ceb:	89 c2                	mov    %eax,%edx
  102ced:	a1 78 d2 10 00       	mov    0x10d278,%eax
  102cf2:	01 c2                	add    %eax,%edx
  102cf4:	8b 45 08             	mov    0x8(%ebp),%eax
  102cf7:	83 ec 08             	sub    $0x8,%esp
  102cfa:	52                   	push   %edx
  102cfb:	50                   	push   %eax
  102cfc:	e8 20 f9 ff ff       	call   102621 <bread>
  102d01:	83 c4 10             	add    $0x10,%esp
  102d04:	89 45 f4             	mov    %eax,-0xc(%ebp)
  bi = b % BPB;
  102d07:	8b 45 0c             	mov    0xc(%ebp),%eax
  102d0a:	25 ff 0f 00 00       	and    $0xfff,%eax
  102d0f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  m = 1 << (bi % 8);
  102d12:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102d15:	83 e0 07             	and    $0x7,%eax
  102d18:	ba 01 00 00 00       	mov    $0x1,%edx
  102d1d:	89 c1                	mov    %eax,%ecx
  102d1f:	d3 e2                	shl    %cl,%edx
  102d21:	89 d0                	mov    %edx,%eax
  102d23:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((bp->data[bi/8] & m) == 0)
  102d26:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102d29:	8d 50 07             	lea    0x7(%eax),%edx
  102d2c:	85 c0                	test   %eax,%eax
  102d2e:	0f 48 c2             	cmovs  %edx,%eax
  102d31:	c1 f8 03             	sar    $0x3,%eax
  102d34:	89 c2                	mov    %eax,%edx
  102d36:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102d39:	0f b6 44 10 1c       	movzbl 0x1c(%eax,%edx,1),%eax
  102d3e:	0f b6 c0             	movzbl %al,%eax
  102d41:	23 45 ec             	and    -0x14(%ebp),%eax
  102d44:	85 c0                	test   %eax,%eax
  102d46:	75 0d                	jne    102d55 <bfree+0x76>
    panic("freeing free block");
  102d48:	83 ec 0c             	sub    $0xc,%esp
  102d4b:	68 d6 58 10 00       	push   $0x1058d6
  102d50:	e8 59 d5 ff ff       	call   1002ae <panic>
  bp->data[bi/8] &= ~m;
  102d55:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102d58:	8d 50 07             	lea    0x7(%eax),%edx
  102d5b:	85 c0                	test   %eax,%eax
  102d5d:	0f 48 c2             	cmovs  %edx,%eax
  102d60:	c1 f8 03             	sar    $0x3,%eax
  102d63:	8b 55 f4             	mov    -0xc(%ebp),%edx
  102d66:	0f b6 54 02 1c       	movzbl 0x1c(%edx,%eax,1),%edx
  102d6b:	89 d1                	mov    %edx,%ecx
  102d6d:	8b 55 ec             	mov    -0x14(%ebp),%edx
  102d70:	f7 d2                	not    %edx
  102d72:	21 ca                	and    %ecx,%edx
  102d74:	89 d1                	mov    %edx,%ecx
  102d76:	8b 55 f4             	mov    -0xc(%ebp),%edx
  102d79:	88 4c 02 1c          	mov    %cl,0x1c(%edx,%eax,1)
  log_write(bp);
  102d7d:	83 ec 0c             	sub    $0xc,%esp
  102d80:	ff 75 f4             	push   -0xc(%ebp)
  102d83:	e8 92 18 00 00       	call   10461a <log_write>
  102d88:	83 c4 10             	add    $0x10,%esp
  brelse(bp);
  102d8b:	83 ec 0c             	sub    $0xc,%esp
  102d8e:	ff 75 f4             	push   -0xc(%ebp)
  102d91:	e8 ea f8 ff ff       	call   102680 <brelse>
  102d96:	83 c4 10             	add    $0x10,%esp
}
  102d99:	90                   	nop
  102d9a:	c9                   	leave
  102d9b:	c3                   	ret

00102d9c <iinit>:
  struct inode inode[NINODE];
} icache;

void
iinit(int dev)
{
  102d9c:	55                   	push   %ebp
  102d9d:	89 e5                	mov    %esp,%ebp
  102d9f:	57                   	push   %edi
  102da0:	56                   	push   %esi
  102da1:	53                   	push   %ebx
  102da2:	83 ec 1c             	sub    $0x1c,%esp
  readsb(dev, &sb);
  102da5:	83 ec 08             	sub    $0x8,%esp
  102da8:	68 60 d2 10 00       	push   $0x10d260
  102dad:	ff 75 08             	push   0x8(%ebp)
  102db0:	e8 51 fd ff ff       	call   102b06 <readsb>
  102db5:	83 c4 10             	add    $0x10,%esp
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
  102db8:	a1 78 d2 10 00       	mov    0x10d278,%eax
  102dbd:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  102dc0:	8b 3d 74 d2 10 00    	mov    0x10d274,%edi
  102dc6:	8b 35 70 d2 10 00    	mov    0x10d270,%esi
  102dcc:	8b 1d 6c d2 10 00    	mov    0x10d26c,%ebx
  102dd2:	8b 0d 68 d2 10 00    	mov    0x10d268,%ecx
  102dd8:	8b 15 64 d2 10 00    	mov    0x10d264,%edx
  102dde:	a1 60 d2 10 00       	mov    0x10d260,%eax
  102de3:	ff 75 e4             	push   -0x1c(%ebp)
  102de6:	57                   	push   %edi
  102de7:	56                   	push   %esi
  102de8:	53                   	push   %ebx
  102de9:	51                   	push   %ecx
  102dea:	52                   	push   %edx
  102deb:	50                   	push   %eax
  102dec:	68 ec 58 10 00       	push   $0x1058ec
  102df1:	e8 f6 d2 ff ff       	call   1000ec <cprintf>
  102df6:	83 c4 20             	add    $0x20,%esp
 inodestart %d bmap start %d\n", sb.size, sb.nblocks,
          sb.ninodes, sb.nlog, sb.logstart, sb.inodestart,
          sb.bmapstart);
}
  102df9:	90                   	nop
  102dfa:	8d 65 f4             	lea    -0xc(%ebp),%esp
  102dfd:	5b                   	pop    %ebx
  102dfe:	5e                   	pop    %esi
  102dff:	5f                   	pop    %edi
  102e00:	5d                   	pop    %ebp
  102e01:	c3                   	ret

00102e02 <ialloc>:
// Allocate an inode on device dev.
// Mark it as allocated by  giving it type type.
// Returns an unlocked but allocated and referenced inode.
struct inode*
ialloc(uint dev, short type)
{
  102e02:	55                   	push   %ebp
  102e03:	89 e5                	mov    %esp,%ebp
  102e05:	83 ec 28             	sub    $0x28,%esp
  102e08:	8b 45 0c             	mov    0xc(%ebp),%eax
  102e0b:	66 89 45 e4          	mov    %ax,-0x1c(%ebp)
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
  102e0f:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
  102e16:	e9 9e 00 00 00       	jmp    102eb9 <ialloc+0xb7>
    bp = bread(dev, IBLOCK(inum, sb));
  102e1b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102e1e:	c1 e8 03             	shr    $0x3,%eax
  102e21:	89 c2                	mov    %eax,%edx
  102e23:	a1 74 d2 10 00       	mov    0x10d274,%eax
  102e28:	01 d0                	add    %edx,%eax
  102e2a:	83 ec 08             	sub    $0x8,%esp
  102e2d:	50                   	push   %eax
  102e2e:	ff 75 08             	push   0x8(%ebp)
  102e31:	e8 eb f7 ff ff       	call   102621 <bread>
  102e36:	83 c4 10             	add    $0x10,%esp
  102e39:	89 45 f0             	mov    %eax,-0x10(%ebp)
    dip = (struct dinode*)bp->data + inum%IPB;
  102e3c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102e3f:	8d 50 1c             	lea    0x1c(%eax),%edx
  102e42:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102e45:	83 e0 07             	and    $0x7,%eax
  102e48:	c1 e0 06             	shl    $0x6,%eax
  102e4b:	01 d0                	add    %edx,%eax
  102e4d:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(dip->type == 0){  // a free inode
  102e50:	8b 45 ec             	mov    -0x14(%ebp),%eax
  102e53:	0f b7 00             	movzwl (%eax),%eax
  102e56:	66 85 c0             	test   %ax,%ax
  102e59:	75 4c                	jne    102ea7 <ialloc+0xa5>
      memset(dip, 0, sizeof(*dip));
  102e5b:	83 ec 04             	sub    $0x4,%esp
  102e5e:	6a 40                	push   $0x40
  102e60:	6a 00                	push   $0x0
  102e62:	ff 75 ec             	push   -0x14(%ebp)
  102e65:	e8 98 e0 ff ff       	call   100f02 <memset>
  102e6a:	83 c4 10             	add    $0x10,%esp
      dip->type = type;
  102e6d:	8b 45 ec             	mov    -0x14(%ebp),%eax
  102e70:	0f b7 55 e4          	movzwl -0x1c(%ebp),%edx
  102e74:	66 89 10             	mov    %dx,(%eax)
      log_write(bp);   // mark it allocated on the disk
  102e77:	83 ec 0c             	sub    $0xc,%esp
  102e7a:	ff 75 f0             	push   -0x10(%ebp)
  102e7d:	e8 98 17 00 00       	call   10461a <log_write>
  102e82:	83 c4 10             	add    $0x10,%esp
      brelse(bp);
  102e85:	83 ec 0c             	sub    $0xc,%esp
  102e88:	ff 75 f0             	push   -0x10(%ebp)
  102e8b:	e8 f0 f7 ff ff       	call   102680 <brelse>
  102e90:	83 c4 10             	add    $0x10,%esp
      return iget(dev, inum);
  102e93:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102e96:	83 ec 08             	sub    $0x8,%esp
  102e99:	50                   	push   %eax
  102e9a:	ff 75 08             	push   0x8(%ebp)
  102e9d:	e8 63 01 00 00       	call   103005 <iget>
  102ea2:	83 c4 10             	add    $0x10,%esp
  102ea5:	eb 2f                	jmp    102ed6 <ialloc+0xd4>
    }
    brelse(bp);
  102ea7:	83 ec 0c             	sub    $0xc,%esp
  102eaa:	ff 75 f0             	push   -0x10(%ebp)
  102ead:	e8 ce f7 ff ff       	call   102680 <brelse>
  102eb2:	83 c4 10             	add    $0x10,%esp
  for(inum = 1; inum < sb.ninodes; inum++){
  102eb5:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  102eb9:	a1 68 d2 10 00       	mov    0x10d268,%eax
  102ebe:	8b 55 f4             	mov    -0xc(%ebp),%edx
  102ec1:	39 c2                	cmp    %eax,%edx
  102ec3:	0f 82 52 ff ff ff    	jb     102e1b <ialloc+0x19>
  }
  panic("ialloc: no inodes");
  102ec9:	83 ec 0c             	sub    $0xc,%esp
  102ecc:	68 3f 59 10 00       	push   $0x10593f
  102ed1:	e8 d8 d3 ff ff       	call   1002ae <panic>
}
  102ed6:	c9                   	leave
  102ed7:	c3                   	ret

00102ed8 <iput>:
// be recycled.
// If that was the last reference and the inode has no links
// to it, free the inode (and its content) on disk.
void
iput(struct inode *ip)
{
  102ed8:	55                   	push   %ebp
  102ed9:	89 e5                	mov    %esp,%ebp
  102edb:	83 ec 18             	sub    $0x18,%esp
  if(ip->valid && ip->nlink == 0){
  102ede:	8b 45 08             	mov    0x8(%ebp),%eax
  102ee1:	8b 40 0c             	mov    0xc(%eax),%eax
  102ee4:	85 c0                	test   %eax,%eax
  102ee6:	74 4a                	je     102f32 <iput+0x5a>
  102ee8:	8b 45 08             	mov    0x8(%ebp),%eax
  102eeb:	0f b7 40 16          	movzwl 0x16(%eax),%eax
  102eef:	66 85 c0             	test   %ax,%ax
  102ef2:	75 3e                	jne    102f32 <iput+0x5a>
    int r = ip->ref;
  102ef4:	8b 45 08             	mov    0x8(%ebp),%eax
  102ef7:	8b 40 08             	mov    0x8(%eax),%eax
  102efa:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(r == 1){
  102efd:	83 7d f4 01          	cmpl   $0x1,-0xc(%ebp)
  102f01:	75 2f                	jne    102f32 <iput+0x5a>
      // inode has no links and no other references: truncate and free.
      itrunc(ip);
  102f03:	83 ec 0c             	sub    $0xc,%esp
  102f06:	ff 75 08             	push   0x8(%ebp)
  102f09:	e8 c1 03 00 00       	call   1032cf <itrunc>
  102f0e:	83 c4 10             	add    $0x10,%esp
      ip->type = 0;
  102f11:	8b 45 08             	mov    0x8(%ebp),%eax
  102f14:	66 c7 40 10 00 00    	movw   $0x0,0x10(%eax)
      iupdate(ip);
  102f1a:	83 ec 0c             	sub    $0xc,%esp
  102f1d:	ff 75 08             	push   0x8(%ebp)
  102f20:	e8 1f 00 00 00       	call   102f44 <iupdate>
  102f25:	83 c4 10             	add    $0x10,%esp
      ip->valid = 0;
  102f28:	8b 45 08             	mov    0x8(%ebp),%eax
  102f2b:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    }
  }
  ip->ref--;
  102f32:	8b 45 08             	mov    0x8(%ebp),%eax
  102f35:	8b 40 08             	mov    0x8(%eax),%eax
  102f38:	8d 50 ff             	lea    -0x1(%eax),%edx
  102f3b:	8b 45 08             	mov    0x8(%ebp),%eax
  102f3e:	89 50 08             	mov    %edx,0x8(%eax)
}
  102f41:	90                   	nop
  102f42:	c9                   	leave
  102f43:	c3                   	ret

00102f44 <iupdate>:
// Copy a modified in-memory inode to disk.
// Must be called after every change to an ip->xxx field
// that lives on disk, since i-node cache is write-through.
void
iupdate(struct inode *ip)
{
  102f44:	55                   	push   %ebp
  102f45:	89 e5                	mov    %esp,%ebp
  102f47:	83 ec 18             	sub    $0x18,%esp
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
  102f4a:	8b 45 08             	mov    0x8(%ebp),%eax
  102f4d:	8b 40 04             	mov    0x4(%eax),%eax
  102f50:	c1 e8 03             	shr    $0x3,%eax
  102f53:	89 c2                	mov    %eax,%edx
  102f55:	a1 74 d2 10 00       	mov    0x10d274,%eax
  102f5a:	01 c2                	add    %eax,%edx
  102f5c:	8b 45 08             	mov    0x8(%ebp),%eax
  102f5f:	8b 00                	mov    (%eax),%eax
  102f61:	83 ec 08             	sub    $0x8,%esp
  102f64:	52                   	push   %edx
  102f65:	50                   	push   %eax
  102f66:	e8 b6 f6 ff ff       	call   102621 <bread>
  102f6b:	83 c4 10             	add    $0x10,%esp
  102f6e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  dip = (struct dinode*)bp->data + ip->inum%IPB;
  102f71:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102f74:	8d 50 1c             	lea    0x1c(%eax),%edx
  102f77:	8b 45 08             	mov    0x8(%ebp),%eax
  102f7a:	8b 40 04             	mov    0x4(%eax),%eax
  102f7d:	83 e0 07             	and    $0x7,%eax
  102f80:	c1 e0 06             	shl    $0x6,%eax
  102f83:	01 d0                	add    %edx,%eax
  102f85:	89 45 f0             	mov    %eax,-0x10(%ebp)
  dip->type = ip->type;
  102f88:	8b 45 08             	mov    0x8(%ebp),%eax
  102f8b:	0f b7 50 10          	movzwl 0x10(%eax),%edx
  102f8f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102f92:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
  102f95:	8b 45 08             	mov    0x8(%ebp),%eax
  102f98:	0f b7 50 12          	movzwl 0x12(%eax),%edx
  102f9c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102f9f:	66 89 50 02          	mov    %dx,0x2(%eax)
  dip->minor = ip->minor;
  102fa3:	8b 45 08             	mov    0x8(%ebp),%eax
  102fa6:	0f b7 50 14          	movzwl 0x14(%eax),%edx
  102faa:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102fad:	66 89 50 04          	mov    %dx,0x4(%eax)
  dip->nlink = ip->nlink;
  102fb1:	8b 45 08             	mov    0x8(%ebp),%eax
  102fb4:	0f b7 50 16          	movzwl 0x16(%eax),%edx
  102fb8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102fbb:	66 89 50 06          	mov    %dx,0x6(%eax)
  dip->size = ip->size;
  102fbf:	8b 45 08             	mov    0x8(%ebp),%eax
  102fc2:	8b 50 18             	mov    0x18(%eax),%edx
  102fc5:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102fc8:	89 50 08             	mov    %edx,0x8(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
  102fcb:	8b 45 08             	mov    0x8(%ebp),%eax
  102fce:	8d 50 1c             	lea    0x1c(%eax),%edx
  102fd1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102fd4:	83 c0 0c             	add    $0xc,%eax
  102fd7:	83 ec 04             	sub    $0x4,%esp
  102fda:	6a 34                	push   $0x34
  102fdc:	52                   	push   %edx
  102fdd:	50                   	push   %eax
  102fde:	e8 de df ff ff       	call   100fc1 <memmove>
  102fe3:	83 c4 10             	add    $0x10,%esp
  log_write(bp);
  102fe6:	83 ec 0c             	sub    $0xc,%esp
  102fe9:	ff 75 f4             	push   -0xc(%ebp)
  102fec:	e8 29 16 00 00       	call   10461a <log_write>
  102ff1:	83 c4 10             	add    $0x10,%esp
  brelse(bp);
  102ff4:	83 ec 0c             	sub    $0xc,%esp
  102ff7:	ff 75 f4             	push   -0xc(%ebp)
  102ffa:	e8 81 f6 ff ff       	call   102680 <brelse>
  102fff:	83 c4 10             	add    $0x10,%esp
}
  103002:	90                   	nop
  103003:	c9                   	leave
  103004:	c3                   	ret

00103005 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
struct inode*
iget(uint dev, uint inum)
{
  103005:	55                   	push   %ebp
  103006:	89 e5                	mov    %esp,%ebp
  103008:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip, *empty;

  // Is the inode already cached?
  empty = 0;
  10300b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
  103012:	c7 45 f4 80 d2 10 00 	movl   $0x10d280,-0xc(%ebp)
  103019:	eb 4d                	jmp    103068 <iget+0x63>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
  10301b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10301e:	8b 40 08             	mov    0x8(%eax),%eax
  103021:	85 c0                	test   %eax,%eax
  103023:	7e 29                	jle    10304e <iget+0x49>
  103025:	8b 45 f4             	mov    -0xc(%ebp),%eax
  103028:	8b 00                	mov    (%eax),%eax
  10302a:	39 45 08             	cmp    %eax,0x8(%ebp)
  10302d:	75 1f                	jne    10304e <iget+0x49>
  10302f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  103032:	8b 40 04             	mov    0x4(%eax),%eax
  103035:	39 45 0c             	cmp    %eax,0xc(%ebp)
  103038:	75 14                	jne    10304e <iget+0x49>
      ip->ref++;
  10303a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10303d:	8b 40 08             	mov    0x8(%eax),%eax
  103040:	8d 50 01             	lea    0x1(%eax),%edx
  103043:	8b 45 f4             	mov    -0xc(%ebp),%eax
  103046:	89 50 08             	mov    %edx,0x8(%eax)
      return ip;
  103049:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10304c:	eb 64                	jmp    1030b2 <iget+0xad>
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
  10304e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  103052:	75 10                	jne    103064 <iget+0x5f>
  103054:	8b 45 f4             	mov    -0xc(%ebp),%eax
  103057:	8b 40 08             	mov    0x8(%eax),%eax
  10305a:	85 c0                	test   %eax,%eax
  10305c:	75 06                	jne    103064 <iget+0x5f>
      empty = ip;
  10305e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  103061:	89 45 f0             	mov    %eax,-0x10(%ebp)
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
  103064:	83 45 f4 50          	addl   $0x50,-0xc(%ebp)
  103068:	81 7d f4 20 e2 10 00 	cmpl   $0x10e220,-0xc(%ebp)
  10306f:	72 aa                	jb     10301b <iget+0x16>
  }

  // Recycle an inode cache entry.
  if(empty == 0)
  103071:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  103075:	75 0d                	jne    103084 <iget+0x7f>
    panic("iget: no inodes");
  103077:	83 ec 0c             	sub    $0xc,%esp
  10307a:	68 51 59 10 00       	push   $0x105951
  10307f:	e8 2a d2 ff ff       	call   1002ae <panic>

  ip = empty;
  103084:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103087:	89 45 f4             	mov    %eax,-0xc(%ebp)
  ip->dev = dev;
  10308a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10308d:	8b 55 08             	mov    0x8(%ebp),%edx
  103090:	89 10                	mov    %edx,(%eax)
  ip->inum = inum;
  103092:	8b 45 f4             	mov    -0xc(%ebp),%eax
  103095:	8b 55 0c             	mov    0xc(%ebp),%edx
  103098:	89 50 04             	mov    %edx,0x4(%eax)
  ip->ref = 1;
  10309b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10309e:	c7 40 08 01 00 00 00 	movl   $0x1,0x8(%eax)
  ip->valid = 0;
  1030a5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1030a8:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)

  return ip;
  1030af:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  1030b2:	c9                   	leave
  1030b3:	c3                   	ret

001030b4 <iread>:

// Reads the inode from disk if necessary.
void
iread(struct inode *ip)
{
  1030b4:	55                   	push   %ebp
  1030b5:	89 e5                	mov    %esp,%ebp
  1030b7:	83 ec 18             	sub    $0x18,%esp
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
  1030ba:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  1030be:	74 0a                	je     1030ca <iread+0x16>
  1030c0:	8b 45 08             	mov    0x8(%ebp),%eax
  1030c3:	8b 40 08             	mov    0x8(%eax),%eax
  1030c6:	85 c0                	test   %eax,%eax
  1030c8:	7f 0d                	jg     1030d7 <iread+0x23>
    panic("iread");
  1030ca:	83 ec 0c             	sub    $0xc,%esp
  1030cd:	68 61 59 10 00       	push   $0x105961
  1030d2:	e8 d7 d1 ff ff       	call   1002ae <panic>

  if(ip->valid == 0){
  1030d7:	8b 45 08             	mov    0x8(%ebp),%eax
  1030da:	8b 40 0c             	mov    0xc(%eax),%eax
  1030dd:	85 c0                	test   %eax,%eax
  1030df:	0f 85 cd 00 00 00    	jne    1031b2 <iread+0xfe>
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
  1030e5:	8b 45 08             	mov    0x8(%ebp),%eax
  1030e8:	8b 40 04             	mov    0x4(%eax),%eax
  1030eb:	c1 e8 03             	shr    $0x3,%eax
  1030ee:	89 c2                	mov    %eax,%edx
  1030f0:	a1 74 d2 10 00       	mov    0x10d274,%eax
  1030f5:	01 c2                	add    %eax,%edx
  1030f7:	8b 45 08             	mov    0x8(%ebp),%eax
  1030fa:	8b 00                	mov    (%eax),%eax
  1030fc:	83 ec 08             	sub    $0x8,%esp
  1030ff:	52                   	push   %edx
  103100:	50                   	push   %eax
  103101:	e8 1b f5 ff ff       	call   102621 <bread>
  103106:	83 c4 10             	add    $0x10,%esp
  103109:	89 45 f4             	mov    %eax,-0xc(%ebp)
    dip = (struct dinode*)bp->data + ip->inum%IPB;
  10310c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10310f:	8d 50 1c             	lea    0x1c(%eax),%edx
  103112:	8b 45 08             	mov    0x8(%ebp),%eax
  103115:	8b 40 04             	mov    0x4(%eax),%eax
  103118:	83 e0 07             	and    $0x7,%eax
  10311b:	c1 e0 06             	shl    $0x6,%eax
  10311e:	01 d0                	add    %edx,%eax
  103120:	89 45 f0             	mov    %eax,-0x10(%ebp)
    ip->type = dip->type;
  103123:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103126:	0f b7 10             	movzwl (%eax),%edx
  103129:	8b 45 08             	mov    0x8(%ebp),%eax
  10312c:	66 89 50 10          	mov    %dx,0x10(%eax)
    ip->major = dip->major;
  103130:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103133:	0f b7 50 02          	movzwl 0x2(%eax),%edx
  103137:	8b 45 08             	mov    0x8(%ebp),%eax
  10313a:	66 89 50 12          	mov    %dx,0x12(%eax)
    ip->minor = dip->minor;
  10313e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103141:	0f b7 50 04          	movzwl 0x4(%eax),%edx
  103145:	8b 45 08             	mov    0x8(%ebp),%eax
  103148:	66 89 50 14          	mov    %dx,0x14(%eax)
    ip->nlink = dip->nlink;
  10314c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10314f:	0f b7 50 06          	movzwl 0x6(%eax),%edx
  103153:	8b 45 08             	mov    0x8(%ebp),%eax
  103156:	66 89 50 16          	mov    %dx,0x16(%eax)
    ip->size = dip->size;
  10315a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10315d:	8b 50 08             	mov    0x8(%eax),%edx
  103160:	8b 45 08             	mov    0x8(%ebp),%eax
  103163:	89 50 18             	mov    %edx,0x18(%eax)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
  103166:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103169:	8d 50 0c             	lea    0xc(%eax),%edx
  10316c:	8b 45 08             	mov    0x8(%ebp),%eax
  10316f:	83 c0 1c             	add    $0x1c,%eax
  103172:	83 ec 04             	sub    $0x4,%esp
  103175:	6a 34                	push   $0x34
  103177:	52                   	push   %edx
  103178:	50                   	push   %eax
  103179:	e8 43 de ff ff       	call   100fc1 <memmove>
  10317e:	83 c4 10             	add    $0x10,%esp
    brelse(bp);
  103181:	83 ec 0c             	sub    $0xc,%esp
  103184:	ff 75 f4             	push   -0xc(%ebp)
  103187:	e8 f4 f4 ff ff       	call   102680 <brelse>
  10318c:	83 c4 10             	add    $0x10,%esp
    ip->valid = 1;
  10318f:	8b 45 08             	mov    0x8(%ebp),%eax
  103192:	c7 40 0c 01 00 00 00 	movl   $0x1,0xc(%eax)
    if(ip->type == 0)
  103199:	8b 45 08             	mov    0x8(%ebp),%eax
  10319c:	0f b7 40 10          	movzwl 0x10(%eax),%eax
  1031a0:	66 85 c0             	test   %ax,%ax
  1031a3:	75 0d                	jne    1031b2 <iread+0xfe>
      panic("iread: no type");
  1031a5:	83 ec 0c             	sub    $0xc,%esp
  1031a8:	68 67 59 10 00       	push   $0x105967
  1031ad:	e8 fc d0 ff ff       	call   1002ae <panic>
  }
}
  1031b2:	90                   	nop
  1031b3:	c9                   	leave
  1031b4:	c3                   	ret

001031b5 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
  1031b5:	55                   	push   %ebp
  1031b6:	89 e5                	mov    %esp,%ebp
  1031b8:	83 ec 18             	sub    $0x18,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
  1031bb:	83 7d 0c 0b          	cmpl   $0xb,0xc(%ebp)
  1031bf:	77 42                	ja     103203 <bmap+0x4e>
    if((addr = ip->addrs[bn]) == 0)
  1031c1:	8b 45 08             	mov    0x8(%ebp),%eax
  1031c4:	8b 55 0c             	mov    0xc(%ebp),%edx
  1031c7:	83 c2 04             	add    $0x4,%edx
  1031ca:	8b 44 90 0c          	mov    0xc(%eax,%edx,4),%eax
  1031ce:	89 45 f4             	mov    %eax,-0xc(%ebp)
  1031d1:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  1031d5:	75 24                	jne    1031fb <bmap+0x46>
      ip->addrs[bn] = addr = balloc(ip->dev);
  1031d7:	8b 45 08             	mov    0x8(%ebp),%eax
  1031da:	8b 00                	mov    (%eax),%eax
  1031dc:	83 ec 0c             	sub    $0xc,%esp
  1031df:	50                   	push   %eax
  1031e0:	e8 b7 f9 ff ff       	call   102b9c <balloc>
  1031e5:	83 c4 10             	add    $0x10,%esp
  1031e8:	89 45 f4             	mov    %eax,-0xc(%ebp)
  1031eb:	8b 45 08             	mov    0x8(%ebp),%eax
  1031ee:	8b 55 0c             	mov    0xc(%ebp),%edx
  1031f1:	8d 4a 04             	lea    0x4(%edx),%ecx
  1031f4:	8b 55 f4             	mov    -0xc(%ebp),%edx
  1031f7:	89 54 88 0c          	mov    %edx,0xc(%eax,%ecx,4)
    return addr;
  1031fb:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1031fe:	e9 ca 00 00 00       	jmp    1032cd <bmap+0x118>
  }
  bn -= NDIRECT;
  103203:	83 6d 0c 0c          	subl   $0xc,0xc(%ebp)

  if(bn < NINDIRECT){
  103207:	83 7d 0c 7f          	cmpl   $0x7f,0xc(%ebp)
  10320b:	0f 87 af 00 00 00    	ja     1032c0 <bmap+0x10b>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
  103211:	8b 45 08             	mov    0x8(%ebp),%eax
  103214:	8b 40 4c             	mov    0x4c(%eax),%eax
  103217:	89 45 f4             	mov    %eax,-0xc(%ebp)
  10321a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  10321e:	75 1d                	jne    10323d <bmap+0x88>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
  103220:	8b 45 08             	mov    0x8(%ebp),%eax
  103223:	8b 00                	mov    (%eax),%eax
  103225:	83 ec 0c             	sub    $0xc,%esp
  103228:	50                   	push   %eax
  103229:	e8 6e f9 ff ff       	call   102b9c <balloc>
  10322e:	83 c4 10             	add    $0x10,%esp
  103231:	89 45 f4             	mov    %eax,-0xc(%ebp)
  103234:	8b 45 08             	mov    0x8(%ebp),%eax
  103237:	8b 55 f4             	mov    -0xc(%ebp),%edx
  10323a:	89 50 4c             	mov    %edx,0x4c(%eax)
    bp = bread(ip->dev, addr);
  10323d:	8b 45 08             	mov    0x8(%ebp),%eax
  103240:	8b 00                	mov    (%eax),%eax
  103242:	83 ec 08             	sub    $0x8,%esp
  103245:	ff 75 f4             	push   -0xc(%ebp)
  103248:	50                   	push   %eax
  103249:	e8 d3 f3 ff ff       	call   102621 <bread>
  10324e:	83 c4 10             	add    $0x10,%esp
  103251:	89 45 f0             	mov    %eax,-0x10(%ebp)
    a = (uint*)bp->data;
  103254:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103257:	83 c0 1c             	add    $0x1c,%eax
  10325a:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if((addr = a[bn]) == 0){
  10325d:	8b 45 0c             	mov    0xc(%ebp),%eax
  103260:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  103267:	8b 45 ec             	mov    -0x14(%ebp),%eax
  10326a:	01 d0                	add    %edx,%eax
  10326c:	8b 00                	mov    (%eax),%eax
  10326e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  103271:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  103275:	75 36                	jne    1032ad <bmap+0xf8>
      a[bn] = addr = balloc(ip->dev);
  103277:	8b 45 08             	mov    0x8(%ebp),%eax
  10327a:	8b 00                	mov    (%eax),%eax
  10327c:	83 ec 0c             	sub    $0xc,%esp
  10327f:	50                   	push   %eax
  103280:	e8 17 f9 ff ff       	call   102b9c <balloc>
  103285:	83 c4 10             	add    $0x10,%esp
  103288:	89 45 f4             	mov    %eax,-0xc(%ebp)
  10328b:	8b 45 0c             	mov    0xc(%ebp),%eax
  10328e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  103295:	8b 45 ec             	mov    -0x14(%ebp),%eax
  103298:	01 c2                	add    %eax,%edx
  10329a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10329d:	89 02                	mov    %eax,(%edx)
      log_write(bp);
  10329f:	83 ec 0c             	sub    $0xc,%esp
  1032a2:	ff 75 f0             	push   -0x10(%ebp)
  1032a5:	e8 70 13 00 00       	call   10461a <log_write>
  1032aa:	83 c4 10             	add    $0x10,%esp
    }
    brelse(bp);
  1032ad:	83 ec 0c             	sub    $0xc,%esp
  1032b0:	ff 75 f0             	push   -0x10(%ebp)
  1032b3:	e8 c8 f3 ff ff       	call   102680 <brelse>
  1032b8:	83 c4 10             	add    $0x10,%esp
    return addr;
  1032bb:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1032be:	eb 0d                	jmp    1032cd <bmap+0x118>
  }

  panic("bmap: out of range");
  1032c0:	83 ec 0c             	sub    $0xc,%esp
  1032c3:	68 76 59 10 00       	push   $0x105976
  1032c8:	e8 e1 cf ff ff       	call   1002ae <panic>
}
  1032cd:	c9                   	leave
  1032ce:	c3                   	ret

001032cf <itrunc>:
// to it (no directory entries referring to it)
// and has no in-memory reference to it (is
// not an open file or current directory).
static void
itrunc(struct inode *ip)
{
  1032cf:	55                   	push   %ebp
  1032d0:	89 e5                	mov    %esp,%ebp
  1032d2:	83 ec 18             	sub    $0x18,%esp
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
  1032d5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  1032dc:	eb 45                	jmp    103323 <itrunc+0x54>
    if(ip->addrs[i]){
  1032de:	8b 45 08             	mov    0x8(%ebp),%eax
  1032e1:	8b 55 f4             	mov    -0xc(%ebp),%edx
  1032e4:	83 c2 04             	add    $0x4,%edx
  1032e7:	8b 44 90 0c          	mov    0xc(%eax,%edx,4),%eax
  1032eb:	85 c0                	test   %eax,%eax
  1032ed:	74 30                	je     10331f <itrunc+0x50>
      bfree(ip->dev, ip->addrs[i]);
  1032ef:	8b 45 08             	mov    0x8(%ebp),%eax
  1032f2:	8b 55 f4             	mov    -0xc(%ebp),%edx
  1032f5:	83 c2 04             	add    $0x4,%edx
  1032f8:	8b 44 90 0c          	mov    0xc(%eax,%edx,4),%eax
  1032fc:	8b 55 08             	mov    0x8(%ebp),%edx
  1032ff:	8b 12                	mov    (%edx),%edx
  103301:	83 ec 08             	sub    $0x8,%esp
  103304:	50                   	push   %eax
  103305:	52                   	push   %edx
  103306:	e8 d4 f9 ff ff       	call   102cdf <bfree>
  10330b:	83 c4 10             	add    $0x10,%esp
      ip->addrs[i] = 0;
  10330e:	8b 45 08             	mov    0x8(%ebp),%eax
  103311:	8b 55 f4             	mov    -0xc(%ebp),%edx
  103314:	83 c2 04             	add    $0x4,%edx
  103317:	c7 44 90 0c 00 00 00 	movl   $0x0,0xc(%eax,%edx,4)
  10331e:	00 
  for(i = 0; i < NDIRECT; i++){
  10331f:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  103323:	83 7d f4 0b          	cmpl   $0xb,-0xc(%ebp)
  103327:	7e b5                	jle    1032de <itrunc+0xf>
    }
  }

  if(ip->addrs[NDIRECT]){
  103329:	8b 45 08             	mov    0x8(%ebp),%eax
  10332c:	8b 40 4c             	mov    0x4c(%eax),%eax
  10332f:	85 c0                	test   %eax,%eax
  103331:	0f 84 a1 00 00 00    	je     1033d8 <itrunc+0x109>
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
  103337:	8b 45 08             	mov    0x8(%ebp),%eax
  10333a:	8b 50 4c             	mov    0x4c(%eax),%edx
  10333d:	8b 45 08             	mov    0x8(%ebp),%eax
  103340:	8b 00                	mov    (%eax),%eax
  103342:	83 ec 08             	sub    $0x8,%esp
  103345:	52                   	push   %edx
  103346:	50                   	push   %eax
  103347:	e8 d5 f2 ff ff       	call   102621 <bread>
  10334c:	83 c4 10             	add    $0x10,%esp
  10334f:	89 45 ec             	mov    %eax,-0x14(%ebp)
    a = (uint*)bp->data;
  103352:	8b 45 ec             	mov    -0x14(%ebp),%eax
  103355:	83 c0 1c             	add    $0x1c,%eax
  103358:	89 45 e8             	mov    %eax,-0x18(%ebp)
    for(j = 0; j < NINDIRECT; j++){
  10335b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  103362:	eb 3c                	jmp    1033a0 <itrunc+0xd1>
      if(a[j])
  103364:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103367:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  10336e:	8b 45 e8             	mov    -0x18(%ebp),%eax
  103371:	01 d0                	add    %edx,%eax
  103373:	8b 00                	mov    (%eax),%eax
  103375:	85 c0                	test   %eax,%eax
  103377:	74 23                	je     10339c <itrunc+0xcd>
        bfree(ip->dev, a[j]);
  103379:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10337c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  103383:	8b 45 e8             	mov    -0x18(%ebp),%eax
  103386:	01 d0                	add    %edx,%eax
  103388:	8b 00                	mov    (%eax),%eax
  10338a:	8b 55 08             	mov    0x8(%ebp),%edx
  10338d:	8b 12                	mov    (%edx),%edx
  10338f:	83 ec 08             	sub    $0x8,%esp
  103392:	50                   	push   %eax
  103393:	52                   	push   %edx
  103394:	e8 46 f9 ff ff       	call   102cdf <bfree>
  103399:	83 c4 10             	add    $0x10,%esp
    for(j = 0; j < NINDIRECT; j++){
  10339c:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
  1033a0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1033a3:	83 f8 7f             	cmp    $0x7f,%eax
  1033a6:	76 bc                	jbe    103364 <itrunc+0x95>
    }
    brelse(bp);
  1033a8:	83 ec 0c             	sub    $0xc,%esp
  1033ab:	ff 75 ec             	push   -0x14(%ebp)
  1033ae:	e8 cd f2 ff ff       	call   102680 <brelse>
  1033b3:	83 c4 10             	add    $0x10,%esp
    bfree(ip->dev, ip->addrs[NDIRECT]);
  1033b6:	8b 45 08             	mov    0x8(%ebp),%eax
  1033b9:	8b 40 4c             	mov    0x4c(%eax),%eax
  1033bc:	8b 55 08             	mov    0x8(%ebp),%edx
  1033bf:	8b 12                	mov    (%edx),%edx
  1033c1:	83 ec 08             	sub    $0x8,%esp
  1033c4:	50                   	push   %eax
  1033c5:	52                   	push   %edx
  1033c6:	e8 14 f9 ff ff       	call   102cdf <bfree>
  1033cb:	83 c4 10             	add    $0x10,%esp
    ip->addrs[NDIRECT] = 0;
  1033ce:	8b 45 08             	mov    0x8(%ebp),%eax
  1033d1:	c7 40 4c 00 00 00 00 	movl   $0x0,0x4c(%eax)
  }

  ip->size = 0;
  1033d8:	8b 45 08             	mov    0x8(%ebp),%eax
  1033db:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)
  iupdate(ip);
  1033e2:	83 ec 0c             	sub    $0xc,%esp
  1033e5:	ff 75 08             	push   0x8(%ebp)
  1033e8:	e8 57 fb ff ff       	call   102f44 <iupdate>
  1033ed:	83 c4 10             	add    $0x10,%esp
}
  1033f0:	90                   	nop
  1033f1:	c9                   	leave
  1033f2:	c3                   	ret

001033f3 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
  1033f3:	55                   	push   %ebp
  1033f4:	89 e5                	mov    %esp,%ebp
  st->dev = ip->dev;
  1033f6:	8b 45 08             	mov    0x8(%ebp),%eax
  1033f9:	8b 00                	mov    (%eax),%eax
  1033fb:	89 c2                	mov    %eax,%edx
  1033fd:	8b 45 0c             	mov    0xc(%ebp),%eax
  103400:	89 50 04             	mov    %edx,0x4(%eax)
  st->ino = ip->inum;
  103403:	8b 45 08             	mov    0x8(%ebp),%eax
  103406:	8b 50 04             	mov    0x4(%eax),%edx
  103409:	8b 45 0c             	mov    0xc(%ebp),%eax
  10340c:	89 50 08             	mov    %edx,0x8(%eax)
  st->type = ip->type;
  10340f:	8b 45 08             	mov    0x8(%ebp),%eax
  103412:	0f b7 50 10          	movzwl 0x10(%eax),%edx
  103416:	8b 45 0c             	mov    0xc(%ebp),%eax
  103419:	66 89 10             	mov    %dx,(%eax)
  st->nlink = ip->nlink;
  10341c:	8b 45 08             	mov    0x8(%ebp),%eax
  10341f:	0f b7 50 16          	movzwl 0x16(%eax),%edx
  103423:	8b 45 0c             	mov    0xc(%ebp),%eax
  103426:	66 89 50 0c          	mov    %dx,0xc(%eax)
  st->size = ip->size;
  10342a:	8b 45 08             	mov    0x8(%ebp),%eax
  10342d:	8b 50 18             	mov    0x18(%eax),%edx
  103430:	8b 45 0c             	mov    0xc(%ebp),%eax
  103433:	89 50 10             	mov    %edx,0x10(%eax)
}
  103436:	90                   	nop
  103437:	5d                   	pop    %ebp
  103438:	c3                   	ret

00103439 <readi>:

// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
  103439:	55                   	push   %ebp
  10343a:	89 e5                	mov    %esp,%ebp
  10343c:	83 ec 18             	sub    $0x18,%esp
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
  10343f:	8b 45 08             	mov    0x8(%ebp),%eax
  103442:	0f b7 40 10          	movzwl 0x10(%eax),%eax
  103446:	66 83 f8 03          	cmp    $0x3,%ax
  10344a:	75 5c                	jne    1034a8 <readi+0x6f>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
  10344c:	8b 45 08             	mov    0x8(%ebp),%eax
  10344f:	0f b7 40 12          	movzwl 0x12(%eax),%eax
  103453:	66 85 c0             	test   %ax,%ax
  103456:	78 20                	js     103478 <readi+0x3f>
  103458:	8b 45 08             	mov    0x8(%ebp),%eax
  10345b:	0f b7 40 12          	movzwl 0x12(%eax),%eax
  10345f:	66 83 f8 09          	cmp    $0x9,%ax
  103463:	7f 13                	jg     103478 <readi+0x3f>
  103465:	8b 45 08             	mov    0x8(%ebp),%eax
  103468:	0f b7 40 12          	movzwl 0x12(%eax),%eax
  10346c:	98                   	cwtl
  10346d:	8b 04 c5 20 e2 10 00 	mov    0x10e220(,%eax,8),%eax
  103474:	85 c0                	test   %eax,%eax
  103476:	75 0a                	jne    103482 <readi+0x49>
      return -1;
  103478:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  10347d:	e9 16 01 00 00       	jmp    103598 <readi+0x15f>
    return devsw[ip->major].read(ip, dst, n);
  103482:	8b 45 08             	mov    0x8(%ebp),%eax
  103485:	0f b7 40 12          	movzwl 0x12(%eax),%eax
  103489:	98                   	cwtl
  10348a:	8b 04 c5 20 e2 10 00 	mov    0x10e220(,%eax,8),%eax
  103491:	8b 55 14             	mov    0x14(%ebp),%edx
  103494:	83 ec 04             	sub    $0x4,%esp
  103497:	52                   	push   %edx
  103498:	ff 75 0c             	push   0xc(%ebp)
  10349b:	ff 75 08             	push   0x8(%ebp)
  10349e:	ff d0                	call   *%eax
  1034a0:	83 c4 10             	add    $0x10,%esp
  1034a3:	e9 f0 00 00 00       	jmp    103598 <readi+0x15f>
  }

  if(off > ip->size || off + n < off || ip->nlink < 1)
  1034a8:	8b 45 08             	mov    0x8(%ebp),%eax
  1034ab:	8b 40 18             	mov    0x18(%eax),%eax
  1034ae:	3b 45 10             	cmp    0x10(%ebp),%eax
  1034b1:	72 19                	jb     1034cc <readi+0x93>
  1034b3:	8b 55 10             	mov    0x10(%ebp),%edx
  1034b6:	8b 45 14             	mov    0x14(%ebp),%eax
  1034b9:	01 d0                	add    %edx,%eax
  1034bb:	3b 45 10             	cmp    0x10(%ebp),%eax
  1034be:	72 0c                	jb     1034cc <readi+0x93>
  1034c0:	8b 45 08             	mov    0x8(%ebp),%eax
  1034c3:	0f b7 40 16          	movzwl 0x16(%eax),%eax
  1034c7:	66 85 c0             	test   %ax,%ax
  1034ca:	7f 0a                	jg     1034d6 <readi+0x9d>
    return -1;
  1034cc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  1034d1:	e9 c2 00 00 00       	jmp    103598 <readi+0x15f>
  if(off + n > ip->size)
  1034d6:	8b 55 10             	mov    0x10(%ebp),%edx
  1034d9:	8b 45 14             	mov    0x14(%ebp),%eax
  1034dc:	01 c2                	add    %eax,%edx
  1034de:	8b 45 08             	mov    0x8(%ebp),%eax
  1034e1:	8b 40 18             	mov    0x18(%eax),%eax
  1034e4:	39 d0                	cmp    %edx,%eax
  1034e6:	73 0c                	jae    1034f4 <readi+0xbb>
    n = ip->size - off;
  1034e8:	8b 45 08             	mov    0x8(%ebp),%eax
  1034eb:	8b 40 18             	mov    0x18(%eax),%eax
  1034ee:	2b 45 10             	sub    0x10(%ebp),%eax
  1034f1:	89 45 14             	mov    %eax,0x14(%ebp)

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
  1034f4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  1034fb:	e9 89 00 00 00       	jmp    103589 <readi+0x150>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
  103500:	8b 45 10             	mov    0x10(%ebp),%eax
  103503:	c1 e8 09             	shr    $0x9,%eax
  103506:	83 ec 08             	sub    $0x8,%esp
  103509:	50                   	push   %eax
  10350a:	ff 75 08             	push   0x8(%ebp)
  10350d:	e8 a3 fc ff ff       	call   1031b5 <bmap>
  103512:	83 c4 10             	add    $0x10,%esp
  103515:	8b 55 08             	mov    0x8(%ebp),%edx
  103518:	8b 12                	mov    (%edx),%edx
  10351a:	83 ec 08             	sub    $0x8,%esp
  10351d:	50                   	push   %eax
  10351e:	52                   	push   %edx
  10351f:	e8 fd f0 ff ff       	call   102621 <bread>
  103524:	83 c4 10             	add    $0x10,%esp
  103527:	89 45 f0             	mov    %eax,-0x10(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
  10352a:	8b 45 10             	mov    0x10(%ebp),%eax
  10352d:	25 ff 01 00 00       	and    $0x1ff,%eax
  103532:	ba 00 02 00 00       	mov    $0x200,%edx
  103537:	29 c2                	sub    %eax,%edx
  103539:	8b 45 14             	mov    0x14(%ebp),%eax
  10353c:	2b 45 f4             	sub    -0xc(%ebp),%eax
  10353f:	39 c2                	cmp    %eax,%edx
  103541:	0f 46 c2             	cmovbe %edx,%eax
  103544:	89 45 ec             	mov    %eax,-0x14(%ebp)
    memmove(dst, bp->data + off%BSIZE, m);
  103547:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10354a:	8d 50 1c             	lea    0x1c(%eax),%edx
  10354d:	8b 45 10             	mov    0x10(%ebp),%eax
  103550:	25 ff 01 00 00       	and    $0x1ff,%eax
  103555:	01 d0                	add    %edx,%eax
  103557:	83 ec 04             	sub    $0x4,%esp
  10355a:	ff 75 ec             	push   -0x14(%ebp)
  10355d:	50                   	push   %eax
  10355e:	ff 75 0c             	push   0xc(%ebp)
  103561:	e8 5b da ff ff       	call   100fc1 <memmove>
  103566:	83 c4 10             	add    $0x10,%esp
    brelse(bp);
  103569:	83 ec 0c             	sub    $0xc,%esp
  10356c:	ff 75 f0             	push   -0x10(%ebp)
  10356f:	e8 0c f1 ff ff       	call   102680 <brelse>
  103574:	83 c4 10             	add    $0x10,%esp
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
  103577:	8b 45 ec             	mov    -0x14(%ebp),%eax
  10357a:	01 45 f4             	add    %eax,-0xc(%ebp)
  10357d:	8b 45 ec             	mov    -0x14(%ebp),%eax
  103580:	01 45 10             	add    %eax,0x10(%ebp)
  103583:	8b 45 ec             	mov    -0x14(%ebp),%eax
  103586:	01 45 0c             	add    %eax,0xc(%ebp)
  103589:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10358c:	3b 45 14             	cmp    0x14(%ebp),%eax
  10358f:	0f 82 6b ff ff ff    	jb     103500 <readi+0xc7>
  }
  return n;
  103595:	8b 45 14             	mov    0x14(%ebp),%eax
}
  103598:	c9                   	leave
  103599:	c3                   	ret

0010359a <writei>:

// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
  10359a:	55                   	push   %ebp
  10359b:	89 e5                	mov    %esp,%ebp
  10359d:	83 ec 18             	sub    $0x18,%esp
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
  1035a0:	8b 45 08             	mov    0x8(%ebp),%eax
  1035a3:	0f b7 40 10          	movzwl 0x10(%eax),%eax
  1035a7:	66 83 f8 03          	cmp    $0x3,%ax
  1035ab:	75 5c                	jne    103609 <writei+0x6f>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
  1035ad:	8b 45 08             	mov    0x8(%ebp),%eax
  1035b0:	0f b7 40 12          	movzwl 0x12(%eax),%eax
  1035b4:	66 85 c0             	test   %ax,%ax
  1035b7:	78 20                	js     1035d9 <writei+0x3f>
  1035b9:	8b 45 08             	mov    0x8(%ebp),%eax
  1035bc:	0f b7 40 12          	movzwl 0x12(%eax),%eax
  1035c0:	66 83 f8 09          	cmp    $0x9,%ax
  1035c4:	7f 13                	jg     1035d9 <writei+0x3f>
  1035c6:	8b 45 08             	mov    0x8(%ebp),%eax
  1035c9:	0f b7 40 12          	movzwl 0x12(%eax),%eax
  1035cd:	98                   	cwtl
  1035ce:	8b 04 c5 24 e2 10 00 	mov    0x10e224(,%eax,8),%eax
  1035d5:	85 c0                	test   %eax,%eax
  1035d7:	75 0a                	jne    1035e3 <writei+0x49>
      return -1;
  1035d9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  1035de:	e9 3b 01 00 00       	jmp    10371e <writei+0x184>
    return devsw[ip->major].write(ip, src, n);
  1035e3:	8b 45 08             	mov    0x8(%ebp),%eax
  1035e6:	0f b7 40 12          	movzwl 0x12(%eax),%eax
  1035ea:	98                   	cwtl
  1035eb:	8b 04 c5 24 e2 10 00 	mov    0x10e224(,%eax,8),%eax
  1035f2:	8b 55 14             	mov    0x14(%ebp),%edx
  1035f5:	83 ec 04             	sub    $0x4,%esp
  1035f8:	52                   	push   %edx
  1035f9:	ff 75 0c             	push   0xc(%ebp)
  1035fc:	ff 75 08             	push   0x8(%ebp)
  1035ff:	ff d0                	call   *%eax
  103601:	83 c4 10             	add    $0x10,%esp
  103604:	e9 15 01 00 00       	jmp    10371e <writei+0x184>
  }

  if(off > ip->size || off + n < off)
  103609:	8b 45 08             	mov    0x8(%ebp),%eax
  10360c:	8b 40 18             	mov    0x18(%eax),%eax
  10360f:	3b 45 10             	cmp    0x10(%ebp),%eax
  103612:	72 0d                	jb     103621 <writei+0x87>
  103614:	8b 55 10             	mov    0x10(%ebp),%edx
  103617:	8b 45 14             	mov    0x14(%ebp),%eax
  10361a:	01 d0                	add    %edx,%eax
  10361c:	3b 45 10             	cmp    0x10(%ebp),%eax
  10361f:	73 0a                	jae    10362b <writei+0x91>
    return -1;
  103621:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  103626:	e9 f3 00 00 00       	jmp    10371e <writei+0x184>
  if(off + n > MAXFILE*BSIZE)
  10362b:	8b 55 10             	mov    0x10(%ebp),%edx
  10362e:	8b 45 14             	mov    0x14(%ebp),%eax
  103631:	01 d0                	add    %edx,%eax
  103633:	3d 00 18 01 00       	cmp    $0x11800,%eax
  103638:	76 0a                	jbe    103644 <writei+0xaa>
    return -1;
  10363a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  10363f:	e9 da 00 00 00       	jmp    10371e <writei+0x184>

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
  103644:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  10364b:	e9 97 00 00 00       	jmp    1036e7 <writei+0x14d>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
  103650:	8b 45 10             	mov    0x10(%ebp),%eax
  103653:	c1 e8 09             	shr    $0x9,%eax
  103656:	83 ec 08             	sub    $0x8,%esp
  103659:	50                   	push   %eax
  10365a:	ff 75 08             	push   0x8(%ebp)
  10365d:	e8 53 fb ff ff       	call   1031b5 <bmap>
  103662:	83 c4 10             	add    $0x10,%esp
  103665:	8b 55 08             	mov    0x8(%ebp),%edx
  103668:	8b 12                	mov    (%edx),%edx
  10366a:	83 ec 08             	sub    $0x8,%esp
  10366d:	50                   	push   %eax
  10366e:	52                   	push   %edx
  10366f:	e8 ad ef ff ff       	call   102621 <bread>
  103674:	83 c4 10             	add    $0x10,%esp
  103677:	89 45 f0             	mov    %eax,-0x10(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
  10367a:	8b 45 10             	mov    0x10(%ebp),%eax
  10367d:	25 ff 01 00 00       	and    $0x1ff,%eax
  103682:	ba 00 02 00 00       	mov    $0x200,%edx
  103687:	29 c2                	sub    %eax,%edx
  103689:	8b 45 14             	mov    0x14(%ebp),%eax
  10368c:	2b 45 f4             	sub    -0xc(%ebp),%eax
  10368f:	39 c2                	cmp    %eax,%edx
  103691:	0f 46 c2             	cmovbe %edx,%eax
  103694:	89 45 ec             	mov    %eax,-0x14(%ebp)
    memmove(bp->data + off%BSIZE, src, m);
  103697:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10369a:	8d 50 1c             	lea    0x1c(%eax),%edx
  10369d:	8b 45 10             	mov    0x10(%ebp),%eax
  1036a0:	25 ff 01 00 00       	and    $0x1ff,%eax
  1036a5:	01 d0                	add    %edx,%eax
  1036a7:	83 ec 04             	sub    $0x4,%esp
  1036aa:	ff 75 ec             	push   -0x14(%ebp)
  1036ad:	ff 75 0c             	push   0xc(%ebp)
  1036b0:	50                   	push   %eax
  1036b1:	e8 0b d9 ff ff       	call   100fc1 <memmove>
  1036b6:	83 c4 10             	add    $0x10,%esp
    log_write(bp);
  1036b9:	83 ec 0c             	sub    $0xc,%esp
  1036bc:	ff 75 f0             	push   -0x10(%ebp)
  1036bf:	e8 56 0f 00 00       	call   10461a <log_write>
  1036c4:	83 c4 10             	add    $0x10,%esp
    brelse(bp);
  1036c7:	83 ec 0c             	sub    $0xc,%esp
  1036ca:	ff 75 f0             	push   -0x10(%ebp)
  1036cd:	e8 ae ef ff ff       	call   102680 <brelse>
  1036d2:	83 c4 10             	add    $0x10,%esp
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
  1036d5:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1036d8:	01 45 f4             	add    %eax,-0xc(%ebp)
  1036db:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1036de:	01 45 10             	add    %eax,0x10(%ebp)
  1036e1:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1036e4:	01 45 0c             	add    %eax,0xc(%ebp)
  1036e7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1036ea:	3b 45 14             	cmp    0x14(%ebp),%eax
  1036ed:	0f 82 5d ff ff ff    	jb     103650 <writei+0xb6>
  }

  if(n > 0 && off > ip->size){
  1036f3:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
  1036f7:	74 22                	je     10371b <writei+0x181>
  1036f9:	8b 45 08             	mov    0x8(%ebp),%eax
  1036fc:	8b 40 18             	mov    0x18(%eax),%eax
  1036ff:	3b 45 10             	cmp    0x10(%ebp),%eax
  103702:	73 17                	jae    10371b <writei+0x181>
    ip->size = off;
  103704:	8b 45 08             	mov    0x8(%ebp),%eax
  103707:	8b 55 10             	mov    0x10(%ebp),%edx
  10370a:	89 50 18             	mov    %edx,0x18(%eax)
    iupdate(ip);
  10370d:	83 ec 0c             	sub    $0xc,%esp
  103710:	ff 75 08             	push   0x8(%ebp)
  103713:	e8 2c f8 ff ff       	call   102f44 <iupdate>
  103718:	83 c4 10             	add    $0x10,%esp
  }
  return n;
  10371b:	8b 45 14             	mov    0x14(%ebp),%eax
}
  10371e:	c9                   	leave
  10371f:	c3                   	ret

00103720 <namecmp>:

// Directories

int
namecmp(const char *s, const char *t)
{
  103720:	55                   	push   %ebp
  103721:	89 e5                	mov    %esp,%ebp
  103723:	83 ec 08             	sub    $0x8,%esp
  return strncmp(s, t, DIRSIZ);
  103726:	83 ec 04             	sub    $0x4,%esp
  103729:	6a 0e                	push   $0xe
  10372b:	ff 75 0c             	push   0xc(%ebp)
  10372e:	ff 75 08             	push   0x8(%ebp)
  103731:	e8 21 d9 ff ff       	call   101057 <strncmp>
  103736:	83 c4 10             	add    $0x10,%esp
}
  103739:	c9                   	leave
  10373a:	c3                   	ret

0010373b <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
  10373b:	55                   	push   %ebp
  10373c:	89 e5                	mov    %esp,%ebp
  10373e:	83 ec 28             	sub    $0x28,%esp
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
  103741:	8b 45 08             	mov    0x8(%ebp),%eax
  103744:	0f b7 40 10          	movzwl 0x10(%eax),%eax
  103748:	66 83 f8 01          	cmp    $0x1,%ax
  10374c:	74 0d                	je     10375b <dirlookup+0x20>
    panic("dirlookup not DIR");
  10374e:	83 ec 0c             	sub    $0xc,%esp
  103751:	68 89 59 10 00       	push   $0x105989
  103756:	e8 53 cb ff ff       	call   1002ae <panic>

  for(off = 0; off < dp->size; off += sizeof(de)){
  10375b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  103762:	eb 7b                	jmp    1037df <dirlookup+0xa4>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
  103764:	6a 10                	push   $0x10
  103766:	ff 75 f4             	push   -0xc(%ebp)
  103769:	8d 45 e0             	lea    -0x20(%ebp),%eax
  10376c:	50                   	push   %eax
  10376d:	ff 75 08             	push   0x8(%ebp)
  103770:	e8 c4 fc ff ff       	call   103439 <readi>
  103775:	83 c4 10             	add    $0x10,%esp
  103778:	83 f8 10             	cmp    $0x10,%eax
  10377b:	74 0d                	je     10378a <dirlookup+0x4f>
      panic("dirlookup read");
  10377d:	83 ec 0c             	sub    $0xc,%esp
  103780:	68 9b 59 10 00       	push   $0x10599b
  103785:	e8 24 cb ff ff       	call   1002ae <panic>
    if(de.inum == 0)
  10378a:	0f b7 45 e0          	movzwl -0x20(%ebp),%eax
  10378e:	66 85 c0             	test   %ax,%ax
  103791:	74 47                	je     1037da <dirlookup+0x9f>
      continue;
    if(namecmp(name, de.name) == 0){
  103793:	83 ec 08             	sub    $0x8,%esp
  103796:	8d 45 e0             	lea    -0x20(%ebp),%eax
  103799:	83 c0 02             	add    $0x2,%eax
  10379c:	50                   	push   %eax
  10379d:	ff 75 0c             	push   0xc(%ebp)
  1037a0:	e8 7b ff ff ff       	call   103720 <namecmp>
  1037a5:	83 c4 10             	add    $0x10,%esp
  1037a8:	85 c0                	test   %eax,%eax
  1037aa:	75 2f                	jne    1037db <dirlookup+0xa0>
      // entry matches path element
      if(poff)
  1037ac:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  1037b0:	74 08                	je     1037ba <dirlookup+0x7f>
        *poff = off;
  1037b2:	8b 45 10             	mov    0x10(%ebp),%eax
  1037b5:	8b 55 f4             	mov    -0xc(%ebp),%edx
  1037b8:	89 10                	mov    %edx,(%eax)
      inum = de.inum;
  1037ba:	0f b7 45 e0          	movzwl -0x20(%ebp),%eax
  1037be:	0f b7 c0             	movzwl %ax,%eax
  1037c1:	89 45 f0             	mov    %eax,-0x10(%ebp)
      return iget(dp->dev, inum);
  1037c4:	8b 45 08             	mov    0x8(%ebp),%eax
  1037c7:	8b 00                	mov    (%eax),%eax
  1037c9:	83 ec 08             	sub    $0x8,%esp
  1037cc:	ff 75 f0             	push   -0x10(%ebp)
  1037cf:	50                   	push   %eax
  1037d0:	e8 30 f8 ff ff       	call   103005 <iget>
  1037d5:	83 c4 10             	add    $0x10,%esp
  1037d8:	eb 19                	jmp    1037f3 <dirlookup+0xb8>
      continue;
  1037da:	90                   	nop
  for(off = 0; off < dp->size; off += sizeof(de)){
  1037db:	83 45 f4 10          	addl   $0x10,-0xc(%ebp)
  1037df:	8b 45 08             	mov    0x8(%ebp),%eax
  1037e2:	8b 40 18             	mov    0x18(%eax),%eax
  1037e5:	39 45 f4             	cmp    %eax,-0xc(%ebp)
  1037e8:	0f 82 76 ff ff ff    	jb     103764 <dirlookup+0x29>
    }
  }

  return 0;
  1037ee:	b8 00 00 00 00       	mov    $0x0,%eax
}
  1037f3:	c9                   	leave
  1037f4:	c3                   	ret

001037f5 <dirlink>:


// Write a new directory entry (name, inum) into the directory dp.
int
dirlink(struct inode *dp, char *name, uint inum)
{
  1037f5:	55                   	push   %ebp
  1037f6:	89 e5                	mov    %esp,%ebp
  1037f8:	83 ec 28             	sub    $0x28,%esp
  int off;
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
  1037fb:	83 ec 04             	sub    $0x4,%esp
  1037fe:	6a 00                	push   $0x0
  103800:	ff 75 0c             	push   0xc(%ebp)
  103803:	ff 75 08             	push   0x8(%ebp)
  103806:	e8 30 ff ff ff       	call   10373b <dirlookup>
  10380b:	83 c4 10             	add    $0x10,%esp
  10380e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  103811:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  103815:	74 18                	je     10382f <dirlink+0x3a>
    iput(ip);
  103817:	83 ec 0c             	sub    $0xc,%esp
  10381a:	ff 75 f0             	push   -0x10(%ebp)
  10381d:	e8 b6 f6 ff ff       	call   102ed8 <iput>
  103822:	83 c4 10             	add    $0x10,%esp
    return -1;
  103825:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  10382a:	e9 9c 00 00 00       	jmp    1038cb <dirlink+0xd6>
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
  10382f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  103836:	eb 39                	jmp    103871 <dirlink+0x7c>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
  103838:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10383b:	6a 10                	push   $0x10
  10383d:	50                   	push   %eax
  10383e:	8d 45 e0             	lea    -0x20(%ebp),%eax
  103841:	50                   	push   %eax
  103842:	ff 75 08             	push   0x8(%ebp)
  103845:	e8 ef fb ff ff       	call   103439 <readi>
  10384a:	83 c4 10             	add    $0x10,%esp
  10384d:	83 f8 10             	cmp    $0x10,%eax
  103850:	74 0d                	je     10385f <dirlink+0x6a>
      panic("dirlink read");
  103852:	83 ec 0c             	sub    $0xc,%esp
  103855:	68 aa 59 10 00       	push   $0x1059aa
  10385a:	e8 4f ca ff ff       	call   1002ae <panic>
    if(de.inum == 0)
  10385f:	0f b7 45 e0          	movzwl -0x20(%ebp),%eax
  103863:	66 85 c0             	test   %ax,%ax
  103866:	74 18                	je     103880 <dirlink+0x8b>
  for(off = 0; off < dp->size; off += sizeof(de)){
  103868:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10386b:	83 c0 10             	add    $0x10,%eax
  10386e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  103871:	8b 45 08             	mov    0x8(%ebp),%eax
  103874:	8b 40 18             	mov    0x18(%eax),%eax
  103877:	8b 55 f4             	mov    -0xc(%ebp),%edx
  10387a:	39 c2                	cmp    %eax,%edx
  10387c:	72 ba                	jb     103838 <dirlink+0x43>
  10387e:	eb 01                	jmp    103881 <dirlink+0x8c>
      break;
  103880:	90                   	nop
  }

  strncpy(de.name, name, DIRSIZ);
  103881:	83 ec 04             	sub    $0x4,%esp
  103884:	6a 0e                	push   $0xe
  103886:	ff 75 0c             	push   0xc(%ebp)
  103889:	8d 45 e0             	lea    -0x20(%ebp),%eax
  10388c:	83 c0 02             	add    $0x2,%eax
  10388f:	50                   	push   %eax
  103890:	e8 18 d8 ff ff       	call   1010ad <strncpy>
  103895:	83 c4 10             	add    $0x10,%esp
  de.inum = inum;
  103898:	8b 45 10             	mov    0x10(%ebp),%eax
  10389b:	66 89 45 e0          	mov    %ax,-0x20(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
  10389f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1038a2:	6a 10                	push   $0x10
  1038a4:	50                   	push   %eax
  1038a5:	8d 45 e0             	lea    -0x20(%ebp),%eax
  1038a8:	50                   	push   %eax
  1038a9:	ff 75 08             	push   0x8(%ebp)
  1038ac:	e8 e9 fc ff ff       	call   10359a <writei>
  1038b1:	83 c4 10             	add    $0x10,%esp
  1038b4:	83 f8 10             	cmp    $0x10,%eax
  1038b7:	74 0d                	je     1038c6 <dirlink+0xd1>
    panic("dirlink");
  1038b9:	83 ec 0c             	sub    $0xc,%esp
  1038bc:	68 b7 59 10 00       	push   $0x1059b7
  1038c1:	e8 e8 c9 ff ff       	call   1002ae <panic>

  return 0;
  1038c6:	b8 00 00 00 00       	mov    $0x0,%eax
}
  1038cb:	c9                   	leave
  1038cc:	c3                   	ret

001038cd <skipelem>:
//   skipelem("a", name) = "", setting name = "a"
//   skipelem("", name) = skipelem("////", name) = 0
//
static char*
skipelem(char *path, char *name)
{
  1038cd:	55                   	push   %ebp
  1038ce:	89 e5                	mov    %esp,%ebp
  1038d0:	83 ec 18             	sub    $0x18,%esp
  char *s;
  int len;

  while(*path == '/')
  1038d3:	eb 04                	jmp    1038d9 <skipelem+0xc>
    path++;
  1038d5:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  while(*path == '/')
  1038d9:	8b 45 08             	mov    0x8(%ebp),%eax
  1038dc:	0f b6 00             	movzbl (%eax),%eax
  1038df:	3c 2f                	cmp    $0x2f,%al
  1038e1:	74 f2                	je     1038d5 <skipelem+0x8>
  if(*path == 0)
  1038e3:	8b 45 08             	mov    0x8(%ebp),%eax
  1038e6:	0f b6 00             	movzbl (%eax),%eax
  1038e9:	84 c0                	test   %al,%al
  1038eb:	75 07                	jne    1038f4 <skipelem+0x27>
    return 0;
  1038ed:	b8 00 00 00 00       	mov    $0x0,%eax
  1038f2:	eb 77                	jmp    10396b <skipelem+0x9e>
  s = path;
  1038f4:	8b 45 08             	mov    0x8(%ebp),%eax
  1038f7:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(*path != '/' && *path != 0)
  1038fa:	eb 04                	jmp    103900 <skipelem+0x33>
    path++;
  1038fc:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  while(*path != '/' && *path != 0)
  103900:	8b 45 08             	mov    0x8(%ebp),%eax
  103903:	0f b6 00             	movzbl (%eax),%eax
  103906:	3c 2f                	cmp    $0x2f,%al
  103908:	74 0a                	je     103914 <skipelem+0x47>
  10390a:	8b 45 08             	mov    0x8(%ebp),%eax
  10390d:	0f b6 00             	movzbl (%eax),%eax
  103910:	84 c0                	test   %al,%al
  103912:	75 e8                	jne    1038fc <skipelem+0x2f>
  len = path - s;
  103914:	8b 45 08             	mov    0x8(%ebp),%eax
  103917:	2b 45 f4             	sub    -0xc(%ebp),%eax
  10391a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(len >= DIRSIZ)
  10391d:	83 7d f0 0d          	cmpl   $0xd,-0x10(%ebp)
  103921:	7e 15                	jle    103938 <skipelem+0x6b>
    memmove(name, s, DIRSIZ);
  103923:	83 ec 04             	sub    $0x4,%esp
  103926:	6a 0e                	push   $0xe
  103928:	ff 75 f4             	push   -0xc(%ebp)
  10392b:	ff 75 0c             	push   0xc(%ebp)
  10392e:	e8 8e d6 ff ff       	call   100fc1 <memmove>
  103933:	83 c4 10             	add    $0x10,%esp
  103936:	eb 26                	jmp    10395e <skipelem+0x91>
  else {
    memmove(name, s, len);
  103938:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10393b:	83 ec 04             	sub    $0x4,%esp
  10393e:	50                   	push   %eax
  10393f:	ff 75 f4             	push   -0xc(%ebp)
  103942:	ff 75 0c             	push   0xc(%ebp)
  103945:	e8 77 d6 ff ff       	call   100fc1 <memmove>
  10394a:	83 c4 10             	add    $0x10,%esp
    name[len] = 0;
  10394d:	8b 55 f0             	mov    -0x10(%ebp),%edx
  103950:	8b 45 0c             	mov    0xc(%ebp),%eax
  103953:	01 d0                	add    %edx,%eax
  103955:	c6 00 00             	movb   $0x0,(%eax)
  }
  while(*path == '/')
  103958:	eb 04                	jmp    10395e <skipelem+0x91>
    path++;
  10395a:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  while(*path == '/')
  10395e:	8b 45 08             	mov    0x8(%ebp),%eax
  103961:	0f b6 00             	movzbl (%eax),%eax
  103964:	3c 2f                	cmp    $0x2f,%al
  103966:	74 f2                	je     10395a <skipelem+0x8d>
  return path;
  103968:	8b 45 08             	mov    0x8(%ebp),%eax
}
  10396b:	c9                   	leave
  10396c:	c3                   	ret

0010396d <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
  10396d:	55                   	push   %ebp
  10396e:	89 e5                	mov    %esp,%ebp
  103970:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip, *next;

  ip = iget(ROOTDEV, ROOTINO);
  103973:	83 ec 08             	sub    $0x8,%esp
  103976:	6a 01                	push   $0x1
  103978:	6a 01                	push   $0x1
  10397a:	e8 86 f6 ff ff       	call   103005 <iget>
  10397f:	83 c4 10             	add    $0x10,%esp
  103982:	89 45 f4             	mov    %eax,-0xc(%ebp)

  while((path = skipelem(path, name)) != 0){
  103985:	e9 90 00 00 00       	jmp    103a1a <namex+0xad>
    iread(ip);
  10398a:	83 ec 0c             	sub    $0xc,%esp
  10398d:	ff 75 f4             	push   -0xc(%ebp)
  103990:	e8 1f f7 ff ff       	call   1030b4 <iread>
  103995:	83 c4 10             	add    $0x10,%esp
    if(ip->type != T_DIR){
  103998:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10399b:	0f b7 40 10          	movzwl 0x10(%eax),%eax
  10399f:	66 83 f8 01          	cmp    $0x1,%ax
  1039a3:	74 18                	je     1039bd <namex+0x50>
      iput(ip);
  1039a5:	83 ec 0c             	sub    $0xc,%esp
  1039a8:	ff 75 f4             	push   -0xc(%ebp)
  1039ab:	e8 28 f5 ff ff       	call   102ed8 <iput>
  1039b0:	83 c4 10             	add    $0x10,%esp
      return 0;
  1039b3:	b8 00 00 00 00       	mov    $0x0,%eax
  1039b8:	e9 99 00 00 00       	jmp    103a56 <namex+0xe9>
    }
    if(nameiparent && *path == '\0'){
  1039bd:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  1039c1:	74 12                	je     1039d5 <namex+0x68>
  1039c3:	8b 45 08             	mov    0x8(%ebp),%eax
  1039c6:	0f b6 00             	movzbl (%eax),%eax
  1039c9:	84 c0                	test   %al,%al
  1039cb:	75 08                	jne    1039d5 <namex+0x68>
      // Stop one level early.
      return ip;
  1039cd:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1039d0:	e9 81 00 00 00       	jmp    103a56 <namex+0xe9>
    }
    if((next = dirlookup(ip, name, 0)) == 0){
  1039d5:	83 ec 04             	sub    $0x4,%esp
  1039d8:	6a 00                	push   $0x0
  1039da:	ff 75 10             	push   0x10(%ebp)
  1039dd:	ff 75 f4             	push   -0xc(%ebp)
  1039e0:	e8 56 fd ff ff       	call   10373b <dirlookup>
  1039e5:	83 c4 10             	add    $0x10,%esp
  1039e8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  1039eb:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  1039ef:	75 15                	jne    103a06 <namex+0x99>
      iput(ip);
  1039f1:	83 ec 0c             	sub    $0xc,%esp
  1039f4:	ff 75 f4             	push   -0xc(%ebp)
  1039f7:	e8 dc f4 ff ff       	call   102ed8 <iput>
  1039fc:	83 c4 10             	add    $0x10,%esp
      return 0;
  1039ff:	b8 00 00 00 00       	mov    $0x0,%eax
  103a04:	eb 50                	jmp    103a56 <namex+0xe9>
    }
    iput(ip);
  103a06:	83 ec 0c             	sub    $0xc,%esp
  103a09:	ff 75 f4             	push   -0xc(%ebp)
  103a0c:	e8 c7 f4 ff ff       	call   102ed8 <iput>
  103a11:	83 c4 10             	add    $0x10,%esp
    ip = next;
  103a14:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103a17:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while((path = skipelem(path, name)) != 0){
  103a1a:	83 ec 08             	sub    $0x8,%esp
  103a1d:	ff 75 10             	push   0x10(%ebp)
  103a20:	ff 75 08             	push   0x8(%ebp)
  103a23:	e8 a5 fe ff ff       	call   1038cd <skipelem>
  103a28:	83 c4 10             	add    $0x10,%esp
  103a2b:	89 45 08             	mov    %eax,0x8(%ebp)
  103a2e:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  103a32:	0f 85 52 ff ff ff    	jne    10398a <namex+0x1d>
  }
  if(nameiparent){
  103a38:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  103a3c:	74 15                	je     103a53 <namex+0xe6>
    iput(ip);
  103a3e:	83 ec 0c             	sub    $0xc,%esp
  103a41:	ff 75 f4             	push   -0xc(%ebp)
  103a44:	e8 8f f4 ff ff       	call   102ed8 <iput>
  103a49:	83 c4 10             	add    $0x10,%esp
    return 0;
  103a4c:	b8 00 00 00 00       	mov    $0x0,%eax
  103a51:	eb 03                	jmp    103a56 <namex+0xe9>
  }
  return ip;
  103a53:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  103a56:	c9                   	leave
  103a57:	c3                   	ret

00103a58 <namei>:

struct inode*
namei(char *path)
{
  103a58:	55                   	push   %ebp
  103a59:	89 e5                	mov    %esp,%ebp
  103a5b:	83 ec 18             	sub    $0x18,%esp
  char name[DIRSIZ];
  return namex(path, 0, name);
  103a5e:	83 ec 04             	sub    $0x4,%esp
  103a61:	8d 45 ea             	lea    -0x16(%ebp),%eax
  103a64:	50                   	push   %eax
  103a65:	6a 00                	push   $0x0
  103a67:	ff 75 08             	push   0x8(%ebp)
  103a6a:	e8 fe fe ff ff       	call   10396d <namex>
  103a6f:	83 c4 10             	add    $0x10,%esp
}
  103a72:	c9                   	leave
  103a73:	c3                   	ret

00103a74 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
  103a74:	55                   	push   %ebp
  103a75:	89 e5                	mov    %esp,%ebp
  103a77:	83 ec 08             	sub    $0x8,%esp
  return namex(path, 1, name);
  103a7a:	83 ec 04             	sub    $0x4,%esp
  103a7d:	ff 75 0c             	push   0xc(%ebp)
  103a80:	6a 01                	push   $0x1
  103a82:	ff 75 08             	push   0x8(%ebp)
  103a85:	e8 e3 fe ff ff       	call   10396d <namex>
  103a8a:	83 c4 10             	add    $0x10,%esp
}
  103a8d:	c9                   	leave
  103a8e:	c3                   	ret

00103a8f <filealloc>:
} ftable;

// Allocate a file structure.
struct file*
filealloc(void)
{
  103a8f:	55                   	push   %ebp
  103a90:	89 e5                	mov    %esp,%ebp
  103a92:	83 ec 10             	sub    $0x10,%esp
  struct file *f;

  for(f = ftable.file; f < ftable.file + NFILE; f++){
  103a95:	c7 45 fc 80 e2 10 00 	movl   $0x10e280,-0x4(%ebp)
  103a9c:	eb 1d                	jmp    103abb <filealloc+0x2c>
    if(f->ref == 0){
  103a9e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  103aa1:	8b 40 04             	mov    0x4(%eax),%eax
  103aa4:	85 c0                	test   %eax,%eax
  103aa6:	75 0f                	jne    103ab7 <filealloc+0x28>
      f->ref = 1;
  103aa8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  103aab:	c7 40 04 01 00 00 00 	movl   $0x1,0x4(%eax)
      return f;
  103ab2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  103ab5:	eb 13                	jmp    103aca <filealloc+0x3b>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
  103ab7:	83 45 fc 14          	addl   $0x14,-0x4(%ebp)
  103abb:	b8 50 ea 10 00       	mov    $0x10ea50,%eax
  103ac0:	39 45 fc             	cmp    %eax,-0x4(%ebp)
  103ac3:	72 d9                	jb     103a9e <filealloc+0xf>
    }
  }
  return 0;
  103ac5:	b8 00 00 00 00       	mov    $0x0,%eax
}
  103aca:	c9                   	leave
  103acb:	c3                   	ret

00103acc <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
  103acc:	55                   	push   %ebp
  103acd:	89 e5                	mov    %esp,%ebp
  103acf:	83 ec 08             	sub    $0x8,%esp
  if(f->ref < 1)
  103ad2:	8b 45 08             	mov    0x8(%ebp),%eax
  103ad5:	8b 40 04             	mov    0x4(%eax),%eax
  103ad8:	85 c0                	test   %eax,%eax
  103ada:	7f 0d                	jg     103ae9 <filedup+0x1d>
    panic("filedup");
  103adc:	83 ec 0c             	sub    $0xc,%esp
  103adf:	68 bf 59 10 00       	push   $0x1059bf
  103ae4:	e8 c5 c7 ff ff       	call   1002ae <panic>
  f->ref++;
  103ae9:	8b 45 08             	mov    0x8(%ebp),%eax
  103aec:	8b 40 04             	mov    0x4(%eax),%eax
  103aef:	8d 50 01             	lea    0x1(%eax),%edx
  103af2:	8b 45 08             	mov    0x8(%ebp),%eax
  103af5:	89 50 04             	mov    %edx,0x4(%eax)
  return f;
  103af8:	8b 45 08             	mov    0x8(%ebp),%eax
}
  103afb:	c9                   	leave
  103afc:	c3                   	ret

00103afd <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
  103afd:	55                   	push   %ebp
  103afe:	89 e5                	mov    %esp,%ebp
  103b00:	83 ec 28             	sub    $0x28,%esp
  struct file ff;

  if(f->ref < 1)
  103b03:	8b 45 08             	mov    0x8(%ebp),%eax
  103b06:	8b 40 04             	mov    0x4(%eax),%eax
  103b09:	85 c0                	test   %eax,%eax
  103b0b:	7f 0d                	jg     103b1a <fileclose+0x1d>
    panic("fileclose");
  103b0d:	83 ec 0c             	sub    $0xc,%esp
  103b10:	68 c7 59 10 00       	push   $0x1059c7
  103b15:	e8 94 c7 ff ff       	call   1002ae <panic>
  if(--f->ref > 0){
  103b1a:	8b 45 08             	mov    0x8(%ebp),%eax
  103b1d:	8b 40 04             	mov    0x4(%eax),%eax
  103b20:	8d 50 ff             	lea    -0x1(%eax),%edx
  103b23:	8b 45 08             	mov    0x8(%ebp),%eax
  103b26:	89 50 04             	mov    %edx,0x4(%eax)
  103b29:	8b 45 08             	mov    0x8(%ebp),%eax
  103b2c:	8b 40 04             	mov    0x4(%eax),%eax
  103b2f:	85 c0                	test   %eax,%eax
  103b31:	7f 56                	jg     103b89 <fileclose+0x8c>
    return;
  }
  ff = *f;
  103b33:	8b 45 08             	mov    0x8(%ebp),%eax
  103b36:	8b 10                	mov    (%eax),%edx
  103b38:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  103b3b:	8b 50 04             	mov    0x4(%eax),%edx
  103b3e:	89 55 e8             	mov    %edx,-0x18(%ebp)
  103b41:	8b 50 08             	mov    0x8(%eax),%edx
  103b44:	89 55 ec             	mov    %edx,-0x14(%ebp)
  103b47:	8b 50 0c             	mov    0xc(%eax),%edx
  103b4a:	89 55 f0             	mov    %edx,-0x10(%ebp)
  103b4d:	8b 40 10             	mov    0x10(%eax),%eax
  103b50:	89 45 f4             	mov    %eax,-0xc(%ebp)
  f->ref = 0;
  103b53:	8b 45 08             	mov    0x8(%ebp),%eax
  103b56:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
  f->type = FD_NONE;
  103b5d:	8b 45 08             	mov    0x8(%ebp),%eax
  103b60:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

  if(ff.type == FD_INODE){
  103b66:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  103b69:	83 f8 01             	cmp    $0x1,%eax
  103b6c:	75 1c                	jne    103b8a <fileclose+0x8d>
    begin_op();
  103b6e:	e8 aa 09 00 00       	call   10451d <begin_op>
    iput(ff.ip);
  103b73:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103b76:	83 ec 0c             	sub    $0xc,%esp
  103b79:	50                   	push   %eax
  103b7a:	e8 59 f3 ff ff       	call   102ed8 <iput>
  103b7f:	83 c4 10             	add    $0x10,%esp
    end_op();
  103b82:	e8 9c 09 00 00       	call   104523 <end_op>
  103b87:	eb 01                	jmp    103b8a <fileclose+0x8d>
    return;
  103b89:	90                   	nop
  }
}
  103b8a:	c9                   	leave
  103b8b:	c3                   	ret

00103b8c <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
  103b8c:	55                   	push   %ebp
  103b8d:	89 e5                	mov    %esp,%ebp
  103b8f:	83 ec 08             	sub    $0x8,%esp
  if(f->type == FD_INODE){
  103b92:	8b 45 08             	mov    0x8(%ebp),%eax
  103b95:	8b 00                	mov    (%eax),%eax
  103b97:	83 f8 01             	cmp    $0x1,%eax
  103b9a:	75 2e                	jne    103bca <filestat+0x3e>
    iread(f->ip);
  103b9c:	8b 45 08             	mov    0x8(%ebp),%eax
  103b9f:	8b 40 0c             	mov    0xc(%eax),%eax
  103ba2:	83 ec 0c             	sub    $0xc,%esp
  103ba5:	50                   	push   %eax
  103ba6:	e8 09 f5 ff ff       	call   1030b4 <iread>
  103bab:	83 c4 10             	add    $0x10,%esp
    stati(f->ip, st);
  103bae:	8b 45 08             	mov    0x8(%ebp),%eax
  103bb1:	8b 40 0c             	mov    0xc(%eax),%eax
  103bb4:	83 ec 08             	sub    $0x8,%esp
  103bb7:	ff 75 0c             	push   0xc(%ebp)
  103bba:	50                   	push   %eax
  103bbb:	e8 33 f8 ff ff       	call   1033f3 <stati>
  103bc0:	83 c4 10             	add    $0x10,%esp
    return 0;
  103bc3:	b8 00 00 00 00       	mov    $0x0,%eax
  103bc8:	eb 05                	jmp    103bcf <filestat+0x43>
  }
  return -1;
  103bca:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  103bcf:	c9                   	leave
  103bd0:	c3                   	ret

00103bd1 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
  103bd1:	55                   	push   %ebp
  103bd2:	89 e5                	mov    %esp,%ebp
  103bd4:	83 ec 18             	sub    $0x18,%esp
  int r;

  if(f->readable == 0)
  103bd7:	8b 45 08             	mov    0x8(%ebp),%eax
  103bda:	0f b6 40 08          	movzbl 0x8(%eax),%eax
  103bde:	84 c0                	test   %al,%al
  103be0:	75 07                	jne    103be9 <fileread+0x18>
    return -1;
  103be2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  103be7:	eb 65                	jmp    103c4e <fileread+0x7d>
  if(f->type == FD_INODE){
  103be9:	8b 45 08             	mov    0x8(%ebp),%eax
  103bec:	8b 00                	mov    (%eax),%eax
  103bee:	83 f8 01             	cmp    $0x1,%eax
  103bf1:	75 4e                	jne    103c41 <fileread+0x70>
    iread(f->ip);
  103bf3:	8b 45 08             	mov    0x8(%ebp),%eax
  103bf6:	8b 40 0c             	mov    0xc(%eax),%eax
  103bf9:	83 ec 0c             	sub    $0xc,%esp
  103bfc:	50                   	push   %eax
  103bfd:	e8 b2 f4 ff ff       	call   1030b4 <iread>
  103c02:	83 c4 10             	add    $0x10,%esp
    if((r = readi(f->ip, addr, f->off, n)) > 0)
  103c05:	8b 4d 10             	mov    0x10(%ebp),%ecx
  103c08:	8b 45 08             	mov    0x8(%ebp),%eax
  103c0b:	8b 50 10             	mov    0x10(%eax),%edx
  103c0e:	8b 45 08             	mov    0x8(%ebp),%eax
  103c11:	8b 40 0c             	mov    0xc(%eax),%eax
  103c14:	51                   	push   %ecx
  103c15:	52                   	push   %edx
  103c16:	ff 75 0c             	push   0xc(%ebp)
  103c19:	50                   	push   %eax
  103c1a:	e8 1a f8 ff ff       	call   103439 <readi>
  103c1f:	83 c4 10             	add    $0x10,%esp
  103c22:	89 45 f4             	mov    %eax,-0xc(%ebp)
  103c25:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  103c29:	7e 11                	jle    103c3c <fileread+0x6b>
      f->off += r;
  103c2b:	8b 45 08             	mov    0x8(%ebp),%eax
  103c2e:	8b 50 10             	mov    0x10(%eax),%edx
  103c31:	8b 45 f4             	mov    -0xc(%ebp),%eax
  103c34:	01 c2                	add    %eax,%edx
  103c36:	8b 45 08             	mov    0x8(%ebp),%eax
  103c39:	89 50 10             	mov    %edx,0x10(%eax)
    return r;
  103c3c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  103c3f:	eb 0d                	jmp    103c4e <fileread+0x7d>
  }
  panic("fileread");
  103c41:	83 ec 0c             	sub    $0xc,%esp
  103c44:	68 d1 59 10 00       	push   $0x1059d1
  103c49:	e8 60 c6 ff ff       	call   1002ae <panic>
}
  103c4e:	c9                   	leave
  103c4f:	c3                   	ret

00103c50 <filewrite>:

// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
  103c50:	55                   	push   %ebp
  103c51:	89 e5                	mov    %esp,%ebp
  103c53:	53                   	push   %ebx
  103c54:	83 ec 14             	sub    $0x14,%esp
  int r;

  if(f->writable == 0)
  103c57:	8b 45 08             	mov    0x8(%ebp),%eax
  103c5a:	0f b6 40 09          	movzbl 0x9(%eax),%eax
  103c5e:	84 c0                	test   %al,%al
  103c60:	75 0a                	jne    103c6c <filewrite+0x1c>
    return -1;
  103c62:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  103c67:	e9 e2 00 00 00       	jmp    103d4e <filewrite+0xfe>
  if(f->type == FD_INODE){
  103c6c:	8b 45 08             	mov    0x8(%ebp),%eax
  103c6f:	8b 00                	mov    (%eax),%eax
  103c71:	83 f8 01             	cmp    $0x1,%eax
  103c74:	0f 85 c7 00 00 00    	jne    103d41 <filewrite+0xf1>
    // write a few blocks at a time
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
  103c7a:	c7 45 ec 00 06 00 00 	movl   $0x600,-0x14(%ebp)
    int i = 0;
  103c81:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    while(i < n){
  103c88:	e9 91 00 00 00       	jmp    103d1e <filewrite+0xce>
      int n1 = n - i;
  103c8d:	8b 45 10             	mov    0x10(%ebp),%eax
  103c90:	2b 45 f4             	sub    -0xc(%ebp),%eax
  103c93:	89 45 f0             	mov    %eax,-0x10(%ebp)
      if(n1 > max)
  103c96:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103c99:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  103c9c:	7e 06                	jle    103ca4 <filewrite+0x54>
        n1 = max;
  103c9e:	8b 45 ec             	mov    -0x14(%ebp),%eax
  103ca1:	89 45 f0             	mov    %eax,-0x10(%ebp)

			begin_op();
  103ca4:	e8 74 08 00 00       	call   10451d <begin_op>
      iread(f->ip);
  103ca9:	8b 45 08             	mov    0x8(%ebp),%eax
  103cac:	8b 40 0c             	mov    0xc(%eax),%eax
  103caf:	83 ec 0c             	sub    $0xc,%esp
  103cb2:	50                   	push   %eax
  103cb3:	e8 fc f3 ff ff       	call   1030b4 <iread>
  103cb8:	83 c4 10             	add    $0x10,%esp
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
  103cbb:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  103cbe:	8b 45 08             	mov    0x8(%ebp),%eax
  103cc1:	8b 50 10             	mov    0x10(%eax),%edx
  103cc4:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  103cc7:	8b 45 0c             	mov    0xc(%ebp),%eax
  103cca:	01 c3                	add    %eax,%ebx
  103ccc:	8b 45 08             	mov    0x8(%ebp),%eax
  103ccf:	8b 40 0c             	mov    0xc(%eax),%eax
  103cd2:	51                   	push   %ecx
  103cd3:	52                   	push   %edx
  103cd4:	53                   	push   %ebx
  103cd5:	50                   	push   %eax
  103cd6:	e8 bf f8 ff ff       	call   10359a <writei>
  103cdb:	83 c4 10             	add    $0x10,%esp
  103cde:	89 45 e8             	mov    %eax,-0x18(%ebp)
  103ce1:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  103ce5:	7e 11                	jle    103cf8 <filewrite+0xa8>
        f->off += r;
  103ce7:	8b 45 08             	mov    0x8(%ebp),%eax
  103cea:	8b 50 10             	mov    0x10(%eax),%edx
  103ced:	8b 45 e8             	mov    -0x18(%ebp),%eax
  103cf0:	01 c2                	add    %eax,%edx
  103cf2:	8b 45 08             	mov    0x8(%ebp),%eax
  103cf5:	89 50 10             	mov    %edx,0x10(%eax)
      end_op();
  103cf8:	e8 26 08 00 00       	call   104523 <end_op>

      if(r < 0)
  103cfd:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  103d01:	78 29                	js     103d2c <filewrite+0xdc>
        break;
      if(r != n1)
  103d03:	8b 45 e8             	mov    -0x18(%ebp),%eax
  103d06:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  103d09:	74 0d                	je     103d18 <filewrite+0xc8>
        panic("short filewrite");
  103d0b:	83 ec 0c             	sub    $0xc,%esp
  103d0e:	68 da 59 10 00       	push   $0x1059da
  103d13:	e8 96 c5 ff ff       	call   1002ae <panic>
      i += r;
  103d18:	8b 45 e8             	mov    -0x18(%ebp),%eax
  103d1b:	01 45 f4             	add    %eax,-0xc(%ebp)
    while(i < n){
  103d1e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  103d21:	3b 45 10             	cmp    0x10(%ebp),%eax
  103d24:	0f 8c 63 ff ff ff    	jl     103c8d <filewrite+0x3d>
  103d2a:	eb 01                	jmp    103d2d <filewrite+0xdd>
        break;
  103d2c:	90                   	nop
    }
    return i == n ? n : -1;
  103d2d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  103d30:	3b 45 10             	cmp    0x10(%ebp),%eax
  103d33:	75 05                	jne    103d3a <filewrite+0xea>
  103d35:	8b 45 10             	mov    0x10(%ebp),%eax
  103d38:	eb 14                	jmp    103d4e <filewrite+0xfe>
  103d3a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  103d3f:	eb 0d                	jmp    103d4e <filewrite+0xfe>
  }
  panic("filewrite");
  103d41:	83 ec 0c             	sub    $0xc,%esp
  103d44:	68 ea 59 10 00       	push   $0x1059ea
  103d49:	e8 60 c5 ff ff       	call   1002ae <panic>
}
  103d4e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  103d51:	c9                   	leave
  103d52:	c3                   	ret

00103d53 <isdirempty>:

// Is the directory dp empty except for "." and ".." ?
int
isdirempty(struct inode *dp)
{
  103d53:	55                   	push   %ebp
  103d54:	89 e5                	mov    %esp,%ebp
  103d56:	83 ec 28             	sub    $0x28,%esp
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
  103d59:	c7 45 f4 20 00 00 00 	movl   $0x20,-0xc(%ebp)
  103d60:	eb 40                	jmp    103da2 <isdirempty+0x4f>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
  103d62:	8b 45 f4             	mov    -0xc(%ebp),%eax
  103d65:	6a 10                	push   $0x10
  103d67:	50                   	push   %eax
  103d68:	8d 45 e4             	lea    -0x1c(%ebp),%eax
  103d6b:	50                   	push   %eax
  103d6c:	ff 75 08             	push   0x8(%ebp)
  103d6f:	e8 c5 f6 ff ff       	call   103439 <readi>
  103d74:	83 c4 10             	add    $0x10,%esp
  103d77:	83 f8 10             	cmp    $0x10,%eax
  103d7a:	74 0d                	je     103d89 <isdirempty+0x36>
      panic("isdirempty: readi");
  103d7c:	83 ec 0c             	sub    $0xc,%esp
  103d7f:	68 f4 59 10 00       	push   $0x1059f4
  103d84:	e8 25 c5 ff ff       	call   1002ae <panic>
    if(de.inum != 0)
  103d89:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
  103d8d:	66 85 c0             	test   %ax,%ax
  103d90:	74 07                	je     103d99 <isdirempty+0x46>
      return 0;
  103d92:	b8 00 00 00 00       	mov    $0x0,%eax
  103d97:	eb 1b                	jmp    103db4 <isdirempty+0x61>
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
  103d99:	8b 45 f4             	mov    -0xc(%ebp),%eax
  103d9c:	83 c0 10             	add    $0x10,%eax
  103d9f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  103da2:	8b 45 08             	mov    0x8(%ebp),%eax
  103da5:	8b 40 18             	mov    0x18(%eax),%eax
  103da8:	8b 55 f4             	mov    -0xc(%ebp),%edx
  103dab:	39 c2                	cmp    %eax,%edx
  103dad:	72 b3                	jb     103d62 <isdirempty+0xf>
  }
  return 1;
  103daf:	b8 01 00 00 00       	mov    $0x1,%eax
}
  103db4:	c9                   	leave
  103db5:	c3                   	ret

00103db6 <unlink>:

int
unlink(char* path, char* name)
{
  103db6:	55                   	push   %ebp
  103db7:	89 e5                	mov    %esp,%ebp
  103db9:	83 ec 28             	sub    $0x28,%esp
  struct inode *ip, *dp;
  struct dirent de;
  uint off;

	begin_op();
  103dbc:	e8 5c 07 00 00       	call   10451d <begin_op>
  if((dp = nameiparent(path, name)) == 0){
  103dc1:	83 ec 08             	sub    $0x8,%esp
  103dc4:	ff 75 0c             	push   0xc(%ebp)
  103dc7:	ff 75 08             	push   0x8(%ebp)
  103dca:	e8 a5 fc ff ff       	call   103a74 <nameiparent>
  103dcf:	83 c4 10             	add    $0x10,%esp
  103dd2:	89 45 f4             	mov    %eax,-0xc(%ebp)
  103dd5:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  103dd9:	75 0f                	jne    103dea <unlink+0x34>
    end_op();
  103ddb:	e8 43 07 00 00       	call   104523 <end_op>
    return -1;
  103de0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  103de5:	e9 8c 01 00 00       	jmp    103f76 <unlink+0x1c0>
  }

  iread(dp);
  103dea:	83 ec 0c             	sub    $0xc,%esp
  103ded:	ff 75 f4             	push   -0xc(%ebp)
  103df0:	e8 bf f2 ff ff       	call   1030b4 <iread>
  103df5:	83 c4 10             	add    $0x10,%esp

  // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
  103df8:	83 ec 08             	sub    $0x8,%esp
  103dfb:	68 06 5a 10 00       	push   $0x105a06
  103e00:	ff 75 0c             	push   0xc(%ebp)
  103e03:	e8 18 f9 ff ff       	call   103720 <namecmp>
  103e08:	83 c4 10             	add    $0x10,%esp
  103e0b:	85 c0                	test   %eax,%eax
  103e0d:	0f 84 47 01 00 00    	je     103f5a <unlink+0x1a4>
  103e13:	83 ec 08             	sub    $0x8,%esp
  103e16:	68 08 5a 10 00       	push   $0x105a08
  103e1b:	ff 75 0c             	push   0xc(%ebp)
  103e1e:	e8 fd f8 ff ff       	call   103720 <namecmp>
  103e23:	83 c4 10             	add    $0x10,%esp
  103e26:	85 c0                	test   %eax,%eax
  103e28:	0f 84 2c 01 00 00    	je     103f5a <unlink+0x1a4>
    goto bad;

  if((ip = dirlookup(dp, name, &off)) == 0)
  103e2e:	83 ec 04             	sub    $0x4,%esp
  103e31:	8d 45 dc             	lea    -0x24(%ebp),%eax
  103e34:	50                   	push   %eax
  103e35:	ff 75 0c             	push   0xc(%ebp)
  103e38:	ff 75 f4             	push   -0xc(%ebp)
  103e3b:	e8 fb f8 ff ff       	call   10373b <dirlookup>
  103e40:	83 c4 10             	add    $0x10,%esp
  103e43:	89 45 f0             	mov    %eax,-0x10(%ebp)
  103e46:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  103e4a:	0f 84 0d 01 00 00    	je     103f5d <unlink+0x1a7>
    goto bad;
  iread(ip);
  103e50:	83 ec 0c             	sub    $0xc,%esp
  103e53:	ff 75 f0             	push   -0x10(%ebp)
  103e56:	e8 59 f2 ff ff       	call   1030b4 <iread>
  103e5b:	83 c4 10             	add    $0x10,%esp

  if(ip->nlink < 1)
  103e5e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103e61:	0f b7 40 16          	movzwl 0x16(%eax),%eax
  103e65:	66 85 c0             	test   %ax,%ax
  103e68:	7f 0d                	jg     103e77 <unlink+0xc1>
    panic("unlink: nlink < 1");
  103e6a:	83 ec 0c             	sub    $0xc,%esp
  103e6d:	68 0b 5a 10 00       	push   $0x105a0b
  103e72:	e8 37 c4 ff ff       	call   1002ae <panic>
  if(ip->type == T_DIR && !isdirempty(ip)){
  103e77:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103e7a:	0f b7 40 10          	movzwl 0x10(%eax),%eax
  103e7e:	66 83 f8 01          	cmp    $0x1,%ax
  103e82:	75 25                	jne    103ea9 <unlink+0xf3>
  103e84:	83 ec 0c             	sub    $0xc,%esp
  103e87:	ff 75 f0             	push   -0x10(%ebp)
  103e8a:	e8 c4 fe ff ff       	call   103d53 <isdirempty>
  103e8f:	83 c4 10             	add    $0x10,%esp
  103e92:	85 c0                	test   %eax,%eax
  103e94:	75 13                	jne    103ea9 <unlink+0xf3>
    iput(ip);
  103e96:	83 ec 0c             	sub    $0xc,%esp
  103e99:	ff 75 f0             	push   -0x10(%ebp)
  103e9c:	e8 37 f0 ff ff       	call   102ed8 <iput>
  103ea1:	83 c4 10             	add    $0x10,%esp
    goto bad;
  103ea4:	e9 b5 00 00 00       	jmp    103f5e <unlink+0x1a8>
  }

  memset(&de, 0, sizeof(de));
  103ea9:	83 ec 04             	sub    $0x4,%esp
  103eac:	6a 10                	push   $0x10
  103eae:	6a 00                	push   $0x0
  103eb0:	8d 45 e0             	lea    -0x20(%ebp),%eax
  103eb3:	50                   	push   %eax
  103eb4:	e8 49 d0 ff ff       	call   100f02 <memset>
  103eb9:	83 c4 10             	add    $0x10,%esp
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
  103ebc:	8b 45 dc             	mov    -0x24(%ebp),%eax
  103ebf:	6a 10                	push   $0x10
  103ec1:	50                   	push   %eax
  103ec2:	8d 45 e0             	lea    -0x20(%ebp),%eax
  103ec5:	50                   	push   %eax
  103ec6:	ff 75 f4             	push   -0xc(%ebp)
  103ec9:	e8 cc f6 ff ff       	call   10359a <writei>
  103ece:	83 c4 10             	add    $0x10,%esp
  103ed1:	83 f8 10             	cmp    $0x10,%eax
  103ed4:	74 0d                	je     103ee3 <unlink+0x12d>
    panic("unlink: writei");
  103ed6:	83 ec 0c             	sub    $0xc,%esp
  103ed9:	68 1d 5a 10 00       	push   $0x105a1d
  103ede:	e8 cb c3 ff ff       	call   1002ae <panic>
  if(ip->type == T_DIR){
  103ee3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103ee6:	0f b7 40 10          	movzwl 0x10(%eax),%eax
  103eea:	66 83 f8 01          	cmp    $0x1,%ax
  103eee:	75 21                	jne    103f11 <unlink+0x15b>
    dp->nlink--;
  103ef0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  103ef3:	0f b7 40 16          	movzwl 0x16(%eax),%eax
  103ef7:	83 e8 01             	sub    $0x1,%eax
  103efa:	89 c2                	mov    %eax,%edx
  103efc:	8b 45 f4             	mov    -0xc(%ebp),%eax
  103eff:	66 89 50 16          	mov    %dx,0x16(%eax)
    iupdate(dp);
  103f03:	83 ec 0c             	sub    $0xc,%esp
  103f06:	ff 75 f4             	push   -0xc(%ebp)
  103f09:	e8 36 f0 ff ff       	call   102f44 <iupdate>
  103f0e:	83 c4 10             	add    $0x10,%esp
  }
  iput(dp);
  103f11:	83 ec 0c             	sub    $0xc,%esp
  103f14:	ff 75 f4             	push   -0xc(%ebp)
  103f17:	e8 bc ef ff ff       	call   102ed8 <iput>
  103f1c:	83 c4 10             	add    $0x10,%esp

  ip->nlink--;
  103f1f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103f22:	0f b7 40 16          	movzwl 0x16(%eax),%eax
  103f26:	83 e8 01             	sub    $0x1,%eax
  103f29:	89 c2                	mov    %eax,%edx
  103f2b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103f2e:	66 89 50 16          	mov    %dx,0x16(%eax)
  iupdate(ip);
  103f32:	83 ec 0c             	sub    $0xc,%esp
  103f35:	ff 75 f0             	push   -0x10(%ebp)
  103f38:	e8 07 f0 ff ff       	call   102f44 <iupdate>
  103f3d:	83 c4 10             	add    $0x10,%esp
  iput(ip);
  103f40:	83 ec 0c             	sub    $0xc,%esp
  103f43:	ff 75 f0             	push   -0x10(%ebp)
  103f46:	e8 8d ef ff ff       	call   102ed8 <iput>
  103f4b:	83 c4 10             	add    $0x10,%esp

  end_op();
  103f4e:	e8 d0 05 00 00       	call   104523 <end_op>
  return 0;
  103f53:	b8 00 00 00 00       	mov    $0x0,%eax
  103f58:	eb 1c                	jmp    103f76 <unlink+0x1c0>
    goto bad;
  103f5a:	90                   	nop
  103f5b:	eb 01                	jmp    103f5e <unlink+0x1a8>
    goto bad;
  103f5d:	90                   	nop

bad:
  iput(dp);
  103f5e:	83 ec 0c             	sub    $0xc,%esp
  103f61:	ff 75 f4             	push   -0xc(%ebp)
  103f64:	e8 6f ef ff ff       	call   102ed8 <iput>
  103f69:	83 c4 10             	add    $0x10,%esp
  end_op();
  103f6c:	e8 b2 05 00 00       	call   104523 <end_op>
  return -1;
  103f71:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  103f76:	c9                   	leave
  103f77:	c3                   	ret

00103f78 <create>:

static struct inode*
create(char *path, short type, short major, short minor)
{
  103f78:	55                   	push   %ebp
  103f79:	89 e5                	mov    %esp,%ebp
  103f7b:	83 ec 38             	sub    $0x38,%esp
  103f7e:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  103f81:	8b 55 10             	mov    0x10(%ebp),%edx
  103f84:	8b 45 14             	mov    0x14(%ebp),%eax
  103f87:	66 89 4d d4          	mov    %cx,-0x2c(%ebp)
  103f8b:	66 89 55 d0          	mov    %dx,-0x30(%ebp)
  103f8f:	66 89 45 cc          	mov    %ax,-0x34(%ebp)
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
  103f93:	83 ec 08             	sub    $0x8,%esp
  103f96:	8d 45 e2             	lea    -0x1e(%ebp),%eax
  103f99:	50                   	push   %eax
  103f9a:	ff 75 08             	push   0x8(%ebp)
  103f9d:	e8 d2 fa ff ff       	call   103a74 <nameiparent>
  103fa2:	83 c4 10             	add    $0x10,%esp
  103fa5:	89 45 f4             	mov    %eax,-0xc(%ebp)
  103fa8:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  103fac:	75 0a                	jne    103fb8 <create+0x40>
    return 0;
  103fae:	b8 00 00 00 00       	mov    $0x0,%eax
  103fb3:	e9 8e 01 00 00       	jmp    104146 <create+0x1ce>
  iread(dp);
  103fb8:	83 ec 0c             	sub    $0xc,%esp
  103fbb:	ff 75 f4             	push   -0xc(%ebp)
  103fbe:	e8 f1 f0 ff ff       	call   1030b4 <iread>
  103fc3:	83 c4 10             	add    $0x10,%esp

  if((ip = dirlookup(dp, name, 0)) != 0){
  103fc6:	83 ec 04             	sub    $0x4,%esp
  103fc9:	6a 00                	push   $0x0
  103fcb:	8d 45 e2             	lea    -0x1e(%ebp),%eax
  103fce:	50                   	push   %eax
  103fcf:	ff 75 f4             	push   -0xc(%ebp)
  103fd2:	e8 64 f7 ff ff       	call   10373b <dirlookup>
  103fd7:	83 c4 10             	add    $0x10,%esp
  103fda:	89 45 f0             	mov    %eax,-0x10(%ebp)
  103fdd:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  103fe1:	74 50                	je     104033 <create+0xbb>
    iput(dp);
  103fe3:	83 ec 0c             	sub    $0xc,%esp
  103fe6:	ff 75 f4             	push   -0xc(%ebp)
  103fe9:	e8 ea ee ff ff       	call   102ed8 <iput>
  103fee:	83 c4 10             	add    $0x10,%esp
    iread(ip);
  103ff1:	83 ec 0c             	sub    $0xc,%esp
  103ff4:	ff 75 f0             	push   -0x10(%ebp)
  103ff7:	e8 b8 f0 ff ff       	call   1030b4 <iread>
  103ffc:	83 c4 10             	add    $0x10,%esp
    if(type == T_FILE && ip->type == T_FILE)
  103fff:	66 83 7d d4 02       	cmpw   $0x2,-0x2c(%ebp)
  104004:	75 15                	jne    10401b <create+0xa3>
  104006:	8b 45 f0             	mov    -0x10(%ebp),%eax
  104009:	0f b7 40 10          	movzwl 0x10(%eax),%eax
  10400d:	66 83 f8 02          	cmp    $0x2,%ax
  104011:	75 08                	jne    10401b <create+0xa3>
      return ip;
  104013:	8b 45 f0             	mov    -0x10(%ebp),%eax
  104016:	e9 2b 01 00 00       	jmp    104146 <create+0x1ce>
    iput(ip);
  10401b:	83 ec 0c             	sub    $0xc,%esp
  10401e:	ff 75 f0             	push   -0x10(%ebp)
  104021:	e8 b2 ee ff ff       	call   102ed8 <iput>
  104026:	83 c4 10             	add    $0x10,%esp
    return 0;
  104029:	b8 00 00 00 00       	mov    $0x0,%eax
  10402e:	e9 13 01 00 00       	jmp    104146 <create+0x1ce>
  }

  if((ip = ialloc(dp->dev, type)) == 0)
  104033:	0f bf 55 d4          	movswl -0x2c(%ebp),%edx
  104037:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10403a:	8b 00                	mov    (%eax),%eax
  10403c:	83 ec 08             	sub    $0x8,%esp
  10403f:	52                   	push   %edx
  104040:	50                   	push   %eax
  104041:	e8 bc ed ff ff       	call   102e02 <ialloc>
  104046:	83 c4 10             	add    $0x10,%esp
  104049:	89 45 f0             	mov    %eax,-0x10(%ebp)
  10404c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  104050:	75 0d                	jne    10405f <create+0xe7>
    panic("create: ialloc");
  104052:	83 ec 0c             	sub    $0xc,%esp
  104055:	68 2c 5a 10 00       	push   $0x105a2c
  10405a:	e8 4f c2 ff ff       	call   1002ae <panic>

  iread(ip);
  10405f:	83 ec 0c             	sub    $0xc,%esp
  104062:	ff 75 f0             	push   -0x10(%ebp)
  104065:	e8 4a f0 ff ff       	call   1030b4 <iread>
  10406a:	83 c4 10             	add    $0x10,%esp
  ip->major = major;
  10406d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  104070:	0f b7 55 d0          	movzwl -0x30(%ebp),%edx
  104074:	66 89 50 12          	mov    %dx,0x12(%eax)
  ip->minor = minor;
  104078:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10407b:	0f b7 55 cc          	movzwl -0x34(%ebp),%edx
  10407f:	66 89 50 14          	mov    %dx,0x14(%eax)
  ip->nlink = 1;
  104083:	8b 45 f0             	mov    -0x10(%ebp),%eax
  104086:	66 c7 40 16 01 00    	movw   $0x1,0x16(%eax)
  iupdate(ip);
  10408c:	83 ec 0c             	sub    $0xc,%esp
  10408f:	ff 75 f0             	push   -0x10(%ebp)
  104092:	e8 ad ee ff ff       	call   102f44 <iupdate>
  104097:	83 c4 10             	add    $0x10,%esp

  if(type == T_DIR){  // Create . and .. entries.
  10409a:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
  10409f:	75 6a                	jne    10410b <create+0x193>
    dp->nlink++;  // for ".."
  1040a1:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1040a4:	0f b7 40 16          	movzwl 0x16(%eax),%eax
  1040a8:	83 c0 01             	add    $0x1,%eax
  1040ab:	89 c2                	mov    %eax,%edx
  1040ad:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1040b0:	66 89 50 16          	mov    %dx,0x16(%eax)
    iupdate(dp);
  1040b4:	83 ec 0c             	sub    $0xc,%esp
  1040b7:	ff 75 f4             	push   -0xc(%ebp)
  1040ba:	e8 85 ee ff ff       	call   102f44 <iupdate>
  1040bf:	83 c4 10             	add    $0x10,%esp
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
  1040c2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1040c5:	8b 40 04             	mov    0x4(%eax),%eax
  1040c8:	83 ec 04             	sub    $0x4,%esp
  1040cb:	50                   	push   %eax
  1040cc:	68 06 5a 10 00       	push   $0x105a06
  1040d1:	ff 75 f0             	push   -0x10(%ebp)
  1040d4:	e8 1c f7 ff ff       	call   1037f5 <dirlink>
  1040d9:	83 c4 10             	add    $0x10,%esp
  1040dc:	85 c0                	test   %eax,%eax
  1040de:	78 1e                	js     1040fe <create+0x186>
  1040e0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1040e3:	8b 40 04             	mov    0x4(%eax),%eax
  1040e6:	83 ec 04             	sub    $0x4,%esp
  1040e9:	50                   	push   %eax
  1040ea:	68 08 5a 10 00       	push   $0x105a08
  1040ef:	ff 75 f0             	push   -0x10(%ebp)
  1040f2:	e8 fe f6 ff ff       	call   1037f5 <dirlink>
  1040f7:	83 c4 10             	add    $0x10,%esp
  1040fa:	85 c0                	test   %eax,%eax
  1040fc:	79 0d                	jns    10410b <create+0x193>
      panic("create dots");
  1040fe:	83 ec 0c             	sub    $0xc,%esp
  104101:	68 3b 5a 10 00       	push   $0x105a3b
  104106:	e8 a3 c1 ff ff       	call   1002ae <panic>
  }

  if(dirlink(dp, name, ip->inum) < 0)
  10410b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10410e:	8b 40 04             	mov    0x4(%eax),%eax
  104111:	83 ec 04             	sub    $0x4,%esp
  104114:	50                   	push   %eax
  104115:	8d 45 e2             	lea    -0x1e(%ebp),%eax
  104118:	50                   	push   %eax
  104119:	ff 75 f4             	push   -0xc(%ebp)
  10411c:	e8 d4 f6 ff ff       	call   1037f5 <dirlink>
  104121:	83 c4 10             	add    $0x10,%esp
  104124:	85 c0                	test   %eax,%eax
  104126:	79 0d                	jns    104135 <create+0x1bd>
    panic("create: dirlink");
  104128:	83 ec 0c             	sub    $0xc,%esp
  10412b:	68 47 5a 10 00       	push   $0x105a47
  104130:	e8 79 c1 ff ff       	call   1002ae <panic>

  iput(dp);
  104135:	83 ec 0c             	sub    $0xc,%esp
  104138:	ff 75 f4             	push   -0xc(%ebp)
  10413b:	e8 98 ed ff ff       	call   102ed8 <iput>
  104140:	83 c4 10             	add    $0x10,%esp

  return ip;
  104143:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  104146:	c9                   	leave
  104147:	c3                   	ret

00104148 <open>:


struct file*
open(char* path, int omode)
{
  104148:	55                   	push   %ebp
  104149:	89 e5                	mov    %esp,%ebp
  10414b:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;

  begin_op();
  10414e:	e8 ca 03 00 00       	call   10451d <begin_op>

  if(omode & O_CREATE){
  104153:	8b 45 0c             	mov    0xc(%ebp),%eax
  104156:	25 00 02 00 00       	and    $0x200,%eax
  10415b:	85 c0                	test   %eax,%eax
  10415d:	74 29                	je     104188 <open+0x40>
    ip = create(path, T_FILE, 0, 0);
  10415f:	6a 00                	push   $0x0
  104161:	6a 00                	push   $0x0
  104163:	6a 02                	push   $0x2
  104165:	ff 75 08             	push   0x8(%ebp)
  104168:	e8 0b fe ff ff       	call   103f78 <create>
  10416d:	83 c4 10             	add    $0x10,%esp
  104170:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(ip == 0){
  104173:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  104177:	75 73                	jne    1041ec <open+0xa4>
      end_op();
  104179:	e8 a5 03 00 00       	call   104523 <end_op>
      return 0;
  10417e:	b8 00 00 00 00       	mov    $0x0,%eax
  104183:	e9 eb 00 00 00       	jmp    104273 <open+0x12b>
    }
  } else {
    if((ip = namei(path)) == 0){
  104188:	83 ec 0c             	sub    $0xc,%esp
  10418b:	ff 75 08             	push   0x8(%ebp)
  10418e:	e8 c5 f8 ff ff       	call   103a58 <namei>
  104193:	83 c4 10             	add    $0x10,%esp
  104196:	89 45 f4             	mov    %eax,-0xc(%ebp)
  104199:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  10419d:	75 0f                	jne    1041ae <open+0x66>
      end_op();
  10419f:	e8 7f 03 00 00       	call   104523 <end_op>
      return 0;
  1041a4:	b8 00 00 00 00       	mov    $0x0,%eax
  1041a9:	e9 c5 00 00 00       	jmp    104273 <open+0x12b>
    }
    iread(ip);
  1041ae:	83 ec 0c             	sub    $0xc,%esp
  1041b1:	ff 75 f4             	push   -0xc(%ebp)
  1041b4:	e8 fb ee ff ff       	call   1030b4 <iread>
  1041b9:	83 c4 10             	add    $0x10,%esp
    if(ip->type == T_DIR && omode != O_RDONLY){
  1041bc:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1041bf:	0f b7 40 10          	movzwl 0x10(%eax),%eax
  1041c3:	66 83 f8 01          	cmp    $0x1,%ax
  1041c7:	75 23                	jne    1041ec <open+0xa4>
  1041c9:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  1041cd:	74 1d                	je     1041ec <open+0xa4>
      iput(ip);
  1041cf:	83 ec 0c             	sub    $0xc,%esp
  1041d2:	ff 75 f4             	push   -0xc(%ebp)
  1041d5:	e8 fe ec ff ff       	call   102ed8 <iput>
  1041da:	83 c4 10             	add    $0x10,%esp
      end_op();
  1041dd:	e8 41 03 00 00       	call   104523 <end_op>
      return 0;
  1041e2:	b8 00 00 00 00       	mov    $0x0,%eax
  1041e7:	e9 87 00 00 00       	jmp    104273 <open+0x12b>
    }
  }

  struct file* f;
  if((f = filealloc()) == 0) { 
  1041ec:	e8 9e f8 ff ff       	call   103a8f <filealloc>
  1041f1:	89 45 f0             	mov    %eax,-0x10(%ebp)
  1041f4:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  1041f8:	75 1a                	jne    104214 <open+0xcc>
    iput(ip);
  1041fa:	83 ec 0c             	sub    $0xc,%esp
  1041fd:	ff 75 f4             	push   -0xc(%ebp)
  104200:	e8 d3 ec ff ff       	call   102ed8 <iput>
  104205:	83 c4 10             	add    $0x10,%esp
    end_op();
  104208:	e8 16 03 00 00       	call   104523 <end_op>
    return 0;
  10420d:	b8 00 00 00 00       	mov    $0x0,%eax
  104212:	eb 5f                	jmp    104273 <open+0x12b>
  }

  f->type = FD_INODE;
  104214:	8b 45 f0             	mov    -0x10(%ebp),%eax
  104217:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  f->ip = ip;
  10421d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  104220:	8b 55 f4             	mov    -0xc(%ebp),%edx
  104223:	89 50 0c             	mov    %edx,0xc(%eax)
  f->off = 0;
  104226:	8b 45 f0             	mov    -0x10(%ebp),%eax
  104229:	c7 40 10 00 00 00 00 	movl   $0x0,0x10(%eax)
  f->readable = !(omode & O_WRONLY);
  104230:	8b 45 0c             	mov    0xc(%ebp),%eax
  104233:	83 e0 01             	and    $0x1,%eax
  104236:	85 c0                	test   %eax,%eax
  104238:	0f 94 c0             	sete   %al
  10423b:	89 c2                	mov    %eax,%edx
  10423d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  104240:	88 50 08             	mov    %dl,0x8(%eax)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
  104243:	8b 45 0c             	mov    0xc(%ebp),%eax
  104246:	83 e0 01             	and    $0x1,%eax
  104249:	85 c0                	test   %eax,%eax
  10424b:	75 0a                	jne    104257 <open+0x10f>
  10424d:	8b 45 0c             	mov    0xc(%ebp),%eax
  104250:	83 e0 02             	and    $0x2,%eax
  104253:	85 c0                	test   %eax,%eax
  104255:	74 07                	je     10425e <open+0x116>
  104257:	b8 01 00 00 00       	mov    $0x1,%eax
  10425c:	eb 05                	jmp    104263 <open+0x11b>
  10425e:	b8 00 00 00 00       	mov    $0x0,%eax
  104263:	89 c2                	mov    %eax,%edx
  104265:	8b 45 f0             	mov    -0x10(%ebp),%eax
  104268:	88 50 09             	mov    %dl,0x9(%eax)
  end_op();
  10426b:	e8 b3 02 00 00       	call   104523 <end_op>
  return f;
  104270:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  104273:	c9                   	leave
  104274:	c3                   	ret

00104275 <mknod>:

int
mknod(struct inode *ip, char* path, int major, int minor)
{
  104275:	55                   	push   %ebp
  104276:	89 e5                	mov    %esp,%ebp
  104278:	83 ec 08             	sub    $0x8,%esp
  begin_op();
  10427b:	e8 9d 02 00 00       	call   10451d <begin_op>
  if((ip = create(path, T_DEV, major, minor)) == 0){
  104280:	8b 45 14             	mov    0x14(%ebp),%eax
  104283:	0f bf d0             	movswl %ax,%edx
  104286:	8b 45 10             	mov    0x10(%ebp),%eax
  104289:	98                   	cwtl
  10428a:	52                   	push   %edx
  10428b:	50                   	push   %eax
  10428c:	6a 03                	push   $0x3
  10428e:	ff 75 0c             	push   0xc(%ebp)
  104291:	e8 e2 fc ff ff       	call   103f78 <create>
  104296:	83 c4 10             	add    $0x10,%esp
  104299:	89 45 08             	mov    %eax,0x8(%ebp)
  10429c:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  1042a0:	75 0c                	jne    1042ae <mknod+0x39>
    end_op();
  1042a2:	e8 7c 02 00 00       	call   104523 <end_op>
    return -1;
  1042a7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  1042ac:	eb 18                	jmp    1042c6 <mknod+0x51>
  }
  iput(ip);
  1042ae:	83 ec 0c             	sub    $0xc,%esp
  1042b1:	ff 75 08             	push   0x8(%ebp)
  1042b4:	e8 1f ec ff ff       	call   102ed8 <iput>
  1042b9:	83 c4 10             	add    $0x10,%esp
  end_op();
  1042bc:	e8 62 02 00 00       	call   104523 <end_op>
  return 0;
  1042c1:	b8 00 00 00 00       	mov    $0x0,%eax
}
  1042c6:	c9                   	leave
  1042c7:	c3                   	ret

001042c8 <mkdir>:

int mkdir(char *path)
{
  1042c8:	55                   	push   %ebp
  1042c9:	89 e5                	mov    %esp,%ebp
  1042cb:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;

  begin_op();
  1042ce:	e8 4a 02 00 00       	call   10451d <begin_op>
  if((ip = create(path, T_DIR, 0, 0)) == 0){
  1042d3:	6a 00                	push   $0x0
  1042d5:	6a 00                	push   $0x0
  1042d7:	6a 01                	push   $0x1
  1042d9:	ff 75 08             	push   0x8(%ebp)
  1042dc:	e8 97 fc ff ff       	call   103f78 <create>
  1042e1:	83 c4 10             	add    $0x10,%esp
  1042e4:	89 45 f4             	mov    %eax,-0xc(%ebp)
  1042e7:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  1042eb:	75 0c                	jne    1042f9 <mkdir+0x31>
    end_op();
  1042ed:	e8 31 02 00 00       	call   104523 <end_op>
    return -1;
  1042f2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  1042f7:	eb 18                	jmp    104311 <mkdir+0x49>
  }
  iput(ip);
  1042f9:	83 ec 0c             	sub    $0xc,%esp
  1042fc:	ff 75 f4             	push   -0xc(%ebp)
  1042ff:	e8 d4 eb ff ff       	call   102ed8 <iput>
  104304:	83 c4 10             	add    $0x10,%esp
  end_op();
  104307:	e8 17 02 00 00       	call   104523 <end_op>
  return 0;
  10430c:	b8 00 00 00 00       	mov    $0x0,%eax
  104311:	c9                   	leave
  104312:	c3                   	ret

00104313 <initlog>:
static void recover_from_log(void);
static void commit();

void
initlog(int dev)
{
  104313:	55                   	push   %ebp
  104314:	89 e5                	mov    %esp,%ebp
  104316:	83 ec 28             	sub    $0x28,%esp
  if (sizeof(struct logheader) >= BSIZE)
    panic("initlog: too big logheader");

  struct superblock sb;
  readsb(dev, &sb);
  104319:	83 ec 08             	sub    $0x8,%esp
  10431c:	8d 45 dc             	lea    -0x24(%ebp),%eax
  10431f:	50                   	push   %eax
  104320:	ff 75 08             	push   0x8(%ebp)
  104323:	e8 de e7 ff ff       	call   102b06 <readsb>
  104328:	83 c4 10             	add    $0x10,%esp
  log.start = sb.logstart;
  10432b:	8b 45 ec             	mov    -0x14(%ebp),%eax
  10432e:	a3 60 ea 10 00       	mov    %eax,0x10ea60
  log.size = sb.nlog;
  104333:	8b 45 e8             	mov    -0x18(%ebp),%eax
  104336:	a3 64 ea 10 00       	mov    %eax,0x10ea64
  log.dev = dev;
  10433b:	8b 45 08             	mov    0x8(%ebp),%eax
  10433e:	a3 6c ea 10 00       	mov    %eax,0x10ea6c
  recover_from_log();
  104343:	e8 b3 01 00 00       	call   1044fb <recover_from_log>
}
  104348:	90                   	nop
  104349:	c9                   	leave
  10434a:	c3                   	ret

0010434b <install_trans>:

// Copy committed blocks from log to their home location
static void
install_trans(void)
{
  10434b:	55                   	push   %ebp
  10434c:	89 e5                	mov    %esp,%ebp
  10434e:	83 ec 18             	sub    $0x18,%esp
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
  104351:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  104358:	e9 95 00 00 00       	jmp    1043f2 <install_trans+0xa7>
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
  10435d:	8b 15 60 ea 10 00    	mov    0x10ea60,%edx
  104363:	8b 45 f4             	mov    -0xc(%ebp),%eax
  104366:	01 d0                	add    %edx,%eax
  104368:	83 c0 01             	add    $0x1,%eax
  10436b:	89 c2                	mov    %eax,%edx
  10436d:	a1 6c ea 10 00       	mov    0x10ea6c,%eax
  104372:	83 ec 08             	sub    $0x8,%esp
  104375:	52                   	push   %edx
  104376:	50                   	push   %eax
  104377:	e8 a5 e2 ff ff       	call   102621 <bread>
  10437c:	83 c4 10             	add    $0x10,%esp
  10437f:	89 45 f0             	mov    %eax,-0x10(%ebp)
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
  104382:	8b 45 f4             	mov    -0xc(%ebp),%eax
  104385:	83 c0 04             	add    $0x4,%eax
  104388:	8b 04 85 64 ea 10 00 	mov    0x10ea64(,%eax,4),%eax
  10438f:	89 c2                	mov    %eax,%edx
  104391:	a1 6c ea 10 00       	mov    0x10ea6c,%eax
  104396:	83 ec 08             	sub    $0x8,%esp
  104399:	52                   	push   %edx
  10439a:	50                   	push   %eax
  10439b:	e8 81 e2 ff ff       	call   102621 <bread>
  1043a0:	83 c4 10             	add    $0x10,%esp
  1043a3:	89 45 ec             	mov    %eax,-0x14(%ebp)
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
  1043a6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1043a9:	8d 50 1c             	lea    0x1c(%eax),%edx
  1043ac:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1043af:	83 c0 1c             	add    $0x1c,%eax
  1043b2:	83 ec 04             	sub    $0x4,%esp
  1043b5:	68 00 02 00 00       	push   $0x200
  1043ba:	52                   	push   %edx
  1043bb:	50                   	push   %eax
  1043bc:	e8 00 cc ff ff       	call   100fc1 <memmove>
  1043c1:	83 c4 10             	add    $0x10,%esp
    bwrite(dbuf);  // write dst to disk
  1043c4:	83 ec 0c             	sub    $0xc,%esp
  1043c7:	ff 75 ec             	push   -0x14(%ebp)
  1043ca:	e8 8b e2 ff ff       	call   10265a <bwrite>
  1043cf:	83 c4 10             	add    $0x10,%esp
    brelse(lbuf);
  1043d2:	83 ec 0c             	sub    $0xc,%esp
  1043d5:	ff 75 f0             	push   -0x10(%ebp)
  1043d8:	e8 a3 e2 ff ff       	call   102680 <brelse>
  1043dd:	83 c4 10             	add    $0x10,%esp
    brelse(dbuf);
  1043e0:	83 ec 0c             	sub    $0xc,%esp
  1043e3:	ff 75 ec             	push   -0x14(%ebp)
  1043e6:	e8 95 e2 ff ff       	call   102680 <brelse>
  1043eb:	83 c4 10             	add    $0x10,%esp
  for (tail = 0; tail < log.lh.n; tail++) {
  1043ee:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  1043f2:	a1 70 ea 10 00       	mov    0x10ea70,%eax
  1043f7:	39 45 f4             	cmp    %eax,-0xc(%ebp)
  1043fa:	0f 8c 5d ff ff ff    	jl     10435d <install_trans+0x12>
  }
}
  104400:	90                   	nop
  104401:	90                   	nop
  104402:	c9                   	leave
  104403:	c3                   	ret

00104404 <read_head>:

// Read the log header from disk into the in-memory log header
static void
read_head(void)
{
  104404:	55                   	push   %ebp
  104405:	89 e5                	mov    %esp,%ebp
  104407:	83 ec 18             	sub    $0x18,%esp
  struct buf *buf = bread(log.dev, log.start);
  10440a:	a1 60 ea 10 00       	mov    0x10ea60,%eax
  10440f:	89 c2                	mov    %eax,%edx
  104411:	a1 6c ea 10 00       	mov    0x10ea6c,%eax
  104416:	83 ec 08             	sub    $0x8,%esp
  104419:	52                   	push   %edx
  10441a:	50                   	push   %eax
  10441b:	e8 01 e2 ff ff       	call   102621 <bread>
  104420:	83 c4 10             	add    $0x10,%esp
  104423:	89 45 f0             	mov    %eax,-0x10(%ebp)
  struct logheader *lh = (struct logheader *) (buf->data);
  104426:	8b 45 f0             	mov    -0x10(%ebp),%eax
  104429:	83 c0 1c             	add    $0x1c,%eax
  10442c:	89 45 ec             	mov    %eax,-0x14(%ebp)
  int i;
  log.lh.n = lh->n;
  10442f:	8b 45 ec             	mov    -0x14(%ebp),%eax
  104432:	8b 00                	mov    (%eax),%eax
  104434:	a3 70 ea 10 00       	mov    %eax,0x10ea70
  for (i = 0; i < log.lh.n; i++) {
  104439:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  104440:	eb 1b                	jmp    10445d <read_head+0x59>
    log.lh.block[i] = lh->block[i];
  104442:	8b 45 ec             	mov    -0x14(%ebp),%eax
  104445:	8b 55 f4             	mov    -0xc(%ebp),%edx
  104448:	8b 44 90 04          	mov    0x4(%eax,%edx,4),%eax
  10444c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  10444f:	83 c2 04             	add    $0x4,%edx
  104452:	89 04 95 64 ea 10 00 	mov    %eax,0x10ea64(,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
  104459:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  10445d:	a1 70 ea 10 00       	mov    0x10ea70,%eax
  104462:	39 45 f4             	cmp    %eax,-0xc(%ebp)
  104465:	7c db                	jl     104442 <read_head+0x3e>
  }
  brelse(buf);
  104467:	83 ec 0c             	sub    $0xc,%esp
  10446a:	ff 75 f0             	push   -0x10(%ebp)
  10446d:	e8 0e e2 ff ff       	call   102680 <brelse>
  104472:	83 c4 10             	add    $0x10,%esp
}
  104475:	90                   	nop
  104476:	c9                   	leave
  104477:	c3                   	ret

00104478 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
  104478:	55                   	push   %ebp
  104479:	89 e5                	mov    %esp,%ebp
  10447b:	83 ec 18             	sub    $0x18,%esp
  struct buf *buf = bread(log.dev, log.start);
  10447e:	a1 60 ea 10 00       	mov    0x10ea60,%eax
  104483:	89 c2                	mov    %eax,%edx
  104485:	a1 6c ea 10 00       	mov    0x10ea6c,%eax
  10448a:	83 ec 08             	sub    $0x8,%esp
  10448d:	52                   	push   %edx
  10448e:	50                   	push   %eax
  10448f:	e8 8d e1 ff ff       	call   102621 <bread>
  104494:	83 c4 10             	add    $0x10,%esp
  104497:	89 45 f0             	mov    %eax,-0x10(%ebp)
  struct logheader *hb = (struct logheader *) (buf->data);
  10449a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10449d:	83 c0 1c             	add    $0x1c,%eax
  1044a0:	89 45 ec             	mov    %eax,-0x14(%ebp)
  int i;
  hb->n = log.lh.n;
  1044a3:	8b 15 70 ea 10 00    	mov    0x10ea70,%edx
  1044a9:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1044ac:	89 10                	mov    %edx,(%eax)
  for (i = 0; i < log.lh.n; i++) {
  1044ae:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  1044b5:	eb 1b                	jmp    1044d2 <write_head+0x5a>
    hb->block[i] = log.lh.block[i];
  1044b7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1044ba:	83 c0 04             	add    $0x4,%eax
  1044bd:	8b 0c 85 64 ea 10 00 	mov    0x10ea64(,%eax,4),%ecx
  1044c4:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1044c7:	8b 55 f4             	mov    -0xc(%ebp),%edx
  1044ca:	89 4c 90 04          	mov    %ecx,0x4(%eax,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
  1044ce:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  1044d2:	a1 70 ea 10 00       	mov    0x10ea70,%eax
  1044d7:	39 45 f4             	cmp    %eax,-0xc(%ebp)
  1044da:	7c db                	jl     1044b7 <write_head+0x3f>
  }
  bwrite(buf);
  1044dc:	83 ec 0c             	sub    $0xc,%esp
  1044df:	ff 75 f0             	push   -0x10(%ebp)
  1044e2:	e8 73 e1 ff ff       	call   10265a <bwrite>
  1044e7:	83 c4 10             	add    $0x10,%esp
  brelse(buf);
  1044ea:	83 ec 0c             	sub    $0xc,%esp
  1044ed:	ff 75 f0             	push   -0x10(%ebp)
  1044f0:	e8 8b e1 ff ff       	call   102680 <brelse>
  1044f5:	83 c4 10             	add    $0x10,%esp
}
  1044f8:	90                   	nop
  1044f9:	c9                   	leave
  1044fa:	c3                   	ret

001044fb <recover_from_log>:

static void
recover_from_log(void)
{
  1044fb:	55                   	push   %ebp
  1044fc:	89 e5                	mov    %esp,%ebp
  1044fe:	83 ec 08             	sub    $0x8,%esp
  read_head();
  104501:	e8 fe fe ff ff       	call   104404 <read_head>
  install_trans(); // if committed, copy from log to disk
  104506:	e8 40 fe ff ff       	call   10434b <install_trans>
  log.lh.n = 0;
  10450b:	c7 05 70 ea 10 00 00 	movl   $0x0,0x10ea70
  104512:	00 00 00 
  write_head(); // clear the log
  104515:	e8 5e ff ff ff       	call   104478 <write_head>
}
  10451a:	90                   	nop
  10451b:	c9                   	leave
  10451c:	c3                   	ret

0010451d <begin_op>:

// called at the start of each FS system call.
void
begin_op(void)
{
  10451d:	55                   	push   %ebp
  10451e:	89 e5                	mov    %esp,%ebp
  
}
  104520:	90                   	nop
  104521:	5d                   	pop    %ebp
  104522:	c3                   	ret

00104523 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
  104523:	55                   	push   %ebp
  104524:	89 e5                	mov    %esp,%ebp
  104526:	83 ec 08             	sub    $0x8,%esp
  // call commit w/o holding locks, since not allowed
  // to sleep with locks.
  commit();
  104529:	e8 bc 00 00 00       	call   1045ea <commit>
}
  10452e:	90                   	nop
  10452f:	c9                   	leave
  104530:	c3                   	ret

00104531 <write_log>:

// Copy modified blocks from cache to log.
static void
write_log(void)
{
  104531:	55                   	push   %ebp
  104532:	89 e5                	mov    %esp,%ebp
  104534:	83 ec 18             	sub    $0x18,%esp
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
  104537:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  10453e:	e9 95 00 00 00       	jmp    1045d8 <write_log+0xa7>
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
  104543:	8b 15 60 ea 10 00    	mov    0x10ea60,%edx
  104549:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10454c:	01 d0                	add    %edx,%eax
  10454e:	83 c0 01             	add    $0x1,%eax
  104551:	89 c2                	mov    %eax,%edx
  104553:	a1 6c ea 10 00       	mov    0x10ea6c,%eax
  104558:	83 ec 08             	sub    $0x8,%esp
  10455b:	52                   	push   %edx
  10455c:	50                   	push   %eax
  10455d:	e8 bf e0 ff ff       	call   102621 <bread>
  104562:	83 c4 10             	add    $0x10,%esp
  104565:	89 45 f0             	mov    %eax,-0x10(%ebp)
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
  104568:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10456b:	83 c0 04             	add    $0x4,%eax
  10456e:	8b 04 85 64 ea 10 00 	mov    0x10ea64(,%eax,4),%eax
  104575:	89 c2                	mov    %eax,%edx
  104577:	a1 6c ea 10 00       	mov    0x10ea6c,%eax
  10457c:	83 ec 08             	sub    $0x8,%esp
  10457f:	52                   	push   %edx
  104580:	50                   	push   %eax
  104581:	e8 9b e0 ff ff       	call   102621 <bread>
  104586:	83 c4 10             	add    $0x10,%esp
  104589:	89 45 ec             	mov    %eax,-0x14(%ebp)
    memmove(to->data, from->data, BSIZE);
  10458c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  10458f:	8d 50 1c             	lea    0x1c(%eax),%edx
  104592:	8b 45 f0             	mov    -0x10(%ebp),%eax
  104595:	83 c0 1c             	add    $0x1c,%eax
  104598:	83 ec 04             	sub    $0x4,%esp
  10459b:	68 00 02 00 00       	push   $0x200
  1045a0:	52                   	push   %edx
  1045a1:	50                   	push   %eax
  1045a2:	e8 1a ca ff ff       	call   100fc1 <memmove>
  1045a7:	83 c4 10             	add    $0x10,%esp
    bwrite(to);  // write the log
  1045aa:	83 ec 0c             	sub    $0xc,%esp
  1045ad:	ff 75 f0             	push   -0x10(%ebp)
  1045b0:	e8 a5 e0 ff ff       	call   10265a <bwrite>
  1045b5:	83 c4 10             	add    $0x10,%esp
    brelse(from);
  1045b8:	83 ec 0c             	sub    $0xc,%esp
  1045bb:	ff 75 ec             	push   -0x14(%ebp)
  1045be:	e8 bd e0 ff ff       	call   102680 <brelse>
  1045c3:	83 c4 10             	add    $0x10,%esp
    brelse(to);
  1045c6:	83 ec 0c             	sub    $0xc,%esp
  1045c9:	ff 75 f0             	push   -0x10(%ebp)
  1045cc:	e8 af e0 ff ff       	call   102680 <brelse>
  1045d1:	83 c4 10             	add    $0x10,%esp
  for (tail = 0; tail < log.lh.n; tail++) {
  1045d4:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  1045d8:	a1 70 ea 10 00       	mov    0x10ea70,%eax
  1045dd:	39 45 f4             	cmp    %eax,-0xc(%ebp)
  1045e0:	0f 8c 5d ff ff ff    	jl     104543 <write_log+0x12>
  }
}
  1045e6:	90                   	nop
  1045e7:	90                   	nop
  1045e8:	c9                   	leave
  1045e9:	c3                   	ret

001045ea <commit>:

static void
commit()
{
  1045ea:	55                   	push   %ebp
  1045eb:	89 e5                	mov    %esp,%ebp
  1045ed:	83 ec 08             	sub    $0x8,%esp
  if (log.lh.n > 0) {
  1045f0:	a1 70 ea 10 00       	mov    0x10ea70,%eax
  1045f5:	85 c0                	test   %eax,%eax
  1045f7:	7e 1e                	jle    104617 <commit+0x2d>
    write_log();     // Write modified blocks from cache to log
  1045f9:	e8 33 ff ff ff       	call   104531 <write_log>
    write_head();    // Write header to disk -- the real commit
  1045fe:	e8 75 fe ff ff       	call   104478 <write_head>
    install_trans(); // Now install writes to home locations
  104603:	e8 43 fd ff ff       	call   10434b <install_trans>
    log.lh.n = 0;
  104608:	c7 05 70 ea 10 00 00 	movl   $0x0,0x10ea70
  10460f:	00 00 00 
    write_head();    // Erase the transaction from the log
  104612:	e8 61 fe ff ff       	call   104478 <write_head>
  }
}
  104617:	90                   	nop
  104618:	c9                   	leave
  104619:	c3                   	ret

0010461a <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
  10461a:	55                   	push   %ebp
  10461b:	89 e5                	mov    %esp,%ebp
  10461d:	83 ec 18             	sub    $0x18,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
  104620:	a1 70 ea 10 00       	mov    0x10ea70,%eax
  104625:	83 f8 1d             	cmp    $0x1d,%eax
  104628:	7f 12                	jg     10463c <log_write+0x22>
  10462a:	8b 15 70 ea 10 00    	mov    0x10ea70,%edx
  104630:	a1 64 ea 10 00       	mov    0x10ea64,%eax
  104635:	83 e8 01             	sub    $0x1,%eax
  104638:	39 c2                	cmp    %eax,%edx
  10463a:	7c 0d                	jl     104649 <log_write+0x2f>
    panic("too big a transaction");
  10463c:	83 ec 0c             	sub    $0xc,%esp
  10463f:	68 57 5a 10 00       	push   $0x105a57
  104644:	e8 65 bc ff ff       	call   1002ae <panic>

  for (i = 0; i < log.lh.n; i++) {
  104649:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  104650:	eb 1d                	jmp    10466f <log_write+0x55>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
  104652:	8b 45 f4             	mov    -0xc(%ebp),%eax
  104655:	83 c0 04             	add    $0x4,%eax
  104658:	8b 04 85 64 ea 10 00 	mov    0x10ea64(,%eax,4),%eax
  10465f:	89 c2                	mov    %eax,%edx
  104661:	8b 45 08             	mov    0x8(%ebp),%eax
  104664:	8b 40 08             	mov    0x8(%eax),%eax
  104667:	39 c2                	cmp    %eax,%edx
  104669:	74 10                	je     10467b <log_write+0x61>
  for (i = 0; i < log.lh.n; i++) {
  10466b:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  10466f:	a1 70 ea 10 00       	mov    0x10ea70,%eax
  104674:	39 45 f4             	cmp    %eax,-0xc(%ebp)
  104677:	7c d9                	jl     104652 <log_write+0x38>
  104679:	eb 01                	jmp    10467c <log_write+0x62>
      break;
  10467b:	90                   	nop
  }
  log.lh.block[i] = b->blockno;
  10467c:	8b 45 08             	mov    0x8(%ebp),%eax
  10467f:	8b 40 08             	mov    0x8(%eax),%eax
  104682:	89 c2                	mov    %eax,%edx
  104684:	8b 45 f4             	mov    -0xc(%ebp),%eax
  104687:	83 c0 04             	add    $0x4,%eax
  10468a:	89 14 85 64 ea 10 00 	mov    %edx,0x10ea64(,%eax,4)
  if (i == log.lh.n)
  104691:	a1 70 ea 10 00       	mov    0x10ea70,%eax
  104696:	39 45 f4             	cmp    %eax,-0xc(%ebp)
  104699:	75 0d                	jne    1046a8 <log_write+0x8e>
    log.lh.n++;
  10469b:	a1 70 ea 10 00       	mov    0x10ea70,%eax
  1046a0:	83 c0 01             	add    $0x1,%eax
  1046a3:	a3 70 ea 10 00       	mov    %eax,0x10ea70
  b->flags |= B_DIRTY; // prevent eviction
  1046a8:	8b 45 08             	mov    0x8(%ebp),%eax
  1046ab:	8b 00                	mov    (%eax),%eax
  1046ad:	83 c8 04             	or     $0x4,%eax
  1046b0:	89 c2                	mov    %eax,%edx
  1046b2:	8b 45 08             	mov    0x8(%ebp),%eax
  1046b5:	89 10                	mov    %edx,(%eax)
  1046b7:	90                   	nop
  1046b8:	c9                   	leave
  1046b9:	c3                   	ret

001046ba <swtch>:
# a struct context, and save its address in *old.
# Switch stacks to new and pop previously-saved registers.

.globl swtch
swtch:
  movl 4(%esp), %eax
  1046ba:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
  1046be:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-saved registers
  pushl %ebp
  1046c2:	55                   	push   %ebp
  pushl %ebx
  1046c3:	53                   	push   %ebx
  pushl %esi
  1046c4:	56                   	push   %esi
  pushl %edi
  1046c5:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
  1046c6:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
  1046c8:	89 d4                	mov    %edx,%esp

  # Load new callee-saved registers
  popl %edi
  1046ca:	5f                   	pop    %edi
  popl %esi
  1046cb:	5e                   	pop    %esi
  popl %ebx
  1046cc:	5b                   	pop    %ebx
  popl %ebp
  1046cd:	5d                   	pop    %ebp
  ret
  1046ce:	c3                   	ret

001046cf <lgdt>:
  1046cf:	55                   	push   %ebp
  1046d0:	89 e5                	mov    %esp,%ebp
  1046d2:	83 ec 10             	sub    $0x10,%esp
  1046d5:	8b 45 0c             	mov    0xc(%ebp),%eax
  1046d8:	83 e8 01             	sub    $0x1,%eax
  1046db:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  1046df:	8b 45 08             	mov    0x8(%ebp),%eax
  1046e2:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  1046e6:	8b 45 08             	mov    0x8(%ebp),%eax
  1046e9:	c1 e8 10             	shr    $0x10,%eax
  1046ec:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  1046f0:	8d 45 fa             	lea    -0x6(%ebp),%eax
  1046f3:	0f 01 10             	lgdtl  (%eax)
  1046f6:	90                   	nop
  1046f7:	c9                   	leave
  1046f8:	c3                   	ret

001046f9 <ltr>:
  1046f9:	55                   	push   %ebp
  1046fa:	89 e5                	mov    %esp,%ebp
  1046fc:	83 ec 04             	sub    $0x4,%esp
  1046ff:	8b 45 08             	mov    0x8(%ebp),%eax
  104702:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  104706:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
  10470a:	0f 00 d8             	ltr    %eax
  10470d:	90                   	nop
  10470e:	c9                   	leave
  10470f:	c3                   	ret

00104710 <seginit>:
{
  104710:	55                   	push   %ebp
  104711:	89 e5                	mov    %esp,%ebp
  104713:	83 ec 18             	sub    $0x18,%esp
  c = &cpus[cpuid()];
  104716:	e8 73 ca ff ff       	call   10118e <cpuid>
  10471b:	69 c0 ac 00 00 00    	imul   $0xac,%eax,%eax
  104721:	05 20 65 10 00       	add    $0x106520,%eax
  104726:	89 45 f4             	mov    %eax,-0xc(%ebp)
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
  104729:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10472c:	66 c7 40 78 ff ff    	movw   $0xffff,0x78(%eax)
  104732:	8b 45 f4             	mov    -0xc(%ebp),%eax
  104735:	66 c7 40 7a 00 00    	movw   $0x0,0x7a(%eax)
  10473b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10473e:	c6 40 7c 00          	movb   $0x0,0x7c(%eax)
  104742:	8b 45 f4             	mov    -0xc(%ebp),%eax
  104745:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
  104749:	83 e2 f0             	and    $0xfffffff0,%edx
  10474c:	83 ca 0a             	or     $0xa,%edx
  10474f:	88 50 7d             	mov    %dl,0x7d(%eax)
  104752:	8b 45 f4             	mov    -0xc(%ebp),%eax
  104755:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
  104759:	83 ca 10             	or     $0x10,%edx
  10475c:	88 50 7d             	mov    %dl,0x7d(%eax)
  10475f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  104762:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
  104766:	83 e2 9f             	and    $0xffffff9f,%edx
  104769:	88 50 7d             	mov    %dl,0x7d(%eax)
  10476c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10476f:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
  104773:	83 ca 80             	or     $0xffffff80,%edx
  104776:	88 50 7d             	mov    %dl,0x7d(%eax)
  104779:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10477c:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
  104780:	83 ca 0f             	or     $0xf,%edx
  104783:	88 50 7e             	mov    %dl,0x7e(%eax)
  104786:	8b 45 f4             	mov    -0xc(%ebp),%eax
  104789:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
  10478d:	83 e2 ef             	and    $0xffffffef,%edx
  104790:	88 50 7e             	mov    %dl,0x7e(%eax)
  104793:	8b 45 f4             	mov    -0xc(%ebp),%eax
  104796:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
  10479a:	83 e2 df             	and    $0xffffffdf,%edx
  10479d:	88 50 7e             	mov    %dl,0x7e(%eax)
  1047a0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1047a3:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
  1047a7:	83 ca 40             	or     $0x40,%edx
  1047aa:	88 50 7e             	mov    %dl,0x7e(%eax)
  1047ad:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1047b0:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
  1047b4:	83 ca 80             	or     $0xffffff80,%edx
  1047b7:	88 50 7e             	mov    %dl,0x7e(%eax)
  1047ba:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1047bd:	c6 40 7f 00          	movb   $0x0,0x7f(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
  1047c1:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1047c4:	66 c7 80 80 00 00 00 	movw   $0xffff,0x80(%eax)
  1047cb:	ff ff 
  1047cd:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1047d0:	66 c7 80 82 00 00 00 	movw   $0x0,0x82(%eax)
  1047d7:	00 00 
  1047d9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1047dc:	c6 80 84 00 00 00 00 	movb   $0x0,0x84(%eax)
  1047e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1047e6:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
  1047ed:	83 e2 f0             	and    $0xfffffff0,%edx
  1047f0:	83 ca 02             	or     $0x2,%edx
  1047f3:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
  1047f9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1047fc:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
  104803:	83 ca 10             	or     $0x10,%edx
  104806:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
  10480c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10480f:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
  104816:	83 e2 9f             	and    $0xffffff9f,%edx
  104819:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
  10481f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  104822:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
  104829:	83 ca 80             	or     $0xffffff80,%edx
  10482c:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
  104832:	8b 45 f4             	mov    -0xc(%ebp),%eax
  104835:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
  10483c:	83 ca 0f             	or     $0xf,%edx
  10483f:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
  104845:	8b 45 f4             	mov    -0xc(%ebp),%eax
  104848:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
  10484f:	83 e2 ef             	and    $0xffffffef,%edx
  104852:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
  104858:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10485b:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
  104862:	83 e2 df             	and    $0xffffffdf,%edx
  104865:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
  10486b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10486e:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
  104875:	83 ca 40             	or     $0x40,%edx
  104878:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
  10487e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  104881:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
  104888:	83 ca 80             	or     $0xffffff80,%edx
  10488b:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
  104891:	8b 45 f4             	mov    -0xc(%ebp),%eax
  104894:	c6 80 87 00 00 00 00 	movb   $0x0,0x87(%eax)
  lgdt(c->gdt, sizeof(c->gdt));
  10489b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10489e:	83 c0 70             	add    $0x70,%eax
  1048a1:	83 ec 08             	sub    $0x8,%esp
  1048a4:	6a 30                	push   $0x30
  1048a6:	50                   	push   %eax
  1048a7:	e8 23 fe ff ff       	call   1046cf <lgdt>
  1048ac:	83 c4 10             	add    $0x10,%esp
}
  1048af:	90                   	nop
  1048b0:	c9                   	leave
  1048b1:	c3                   	ret

001048b2 <switchuvm>:
{
  1048b2:	55                   	push   %ebp
  1048b3:	89 e5                	mov    %esp,%ebp
  1048b5:	56                   	push   %esi
  1048b6:	53                   	push   %ebx
  1048b7:	83 ec 10             	sub    $0x10,%esp
  if(p == 0)
  1048ba:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  1048be:	75 0d                	jne    1048cd <switchuvm+0x1b>
    panic("switchuvm: no process");
  1048c0:	83 ec 0c             	sub    $0xc,%esp
  1048c3:	68 6d 5a 10 00       	push   $0x105a6d
  1048c8:	e8 e1 b9 ff ff       	call   1002ae <panic>
  if(p->kstack == 0)
  1048cd:	8b 45 08             	mov    0x8(%ebp),%eax
  1048d0:	8b 40 08             	mov    0x8(%eax),%eax
  1048d3:	85 c0                	test   %eax,%eax
  1048d5:	75 0d                	jne    1048e4 <switchuvm+0x32>
    panic("switchuvm: no kstack");
  1048d7:	83 ec 0c             	sub    $0xc,%esp
  1048da:	68 83 5a 10 00       	push   $0x105a83
  1048df:	e8 ca b9 ff ff       	call   1002ae <panic>
  pushcli();
  1048e4:	e8 fe cd ff ff       	call   1016e7 <pushcli>
  mycpu()->gdt[SEG_UCODE] = SEG(STA_X|STA_R, p->offset, (PROCSIZE << 12)-1, DPL_USER);
  1048e9:	e8 aa c8 ff ff       	call   101198 <mycpu>
  1048ee:	8b 55 08             	mov    0x8(%ebp),%edx
  1048f1:	8b 52 04             	mov    0x4(%edx),%edx
  1048f4:	89 d6                	mov    %edx,%esi
  1048f6:	8b 55 08             	mov    0x8(%ebp),%edx
  1048f9:	8b 52 04             	mov    0x4(%edx),%edx
  1048fc:	c1 ea 10             	shr    $0x10,%edx
  1048ff:	89 d3                	mov    %edx,%ebx
  104901:	8b 55 08             	mov    0x8(%ebp),%edx
  104904:	8b 52 04             	mov    0x4(%edx),%edx
  104907:	c1 ea 18             	shr    $0x18,%edx
  10490a:	89 d1                	mov    %edx,%ecx
  10490c:	66 c7 80 88 00 00 00 	movw   $0xff,0x88(%eax)
  104913:	ff 00 
  104915:	66 89 b0 8a 00 00 00 	mov    %si,0x8a(%eax)
  10491c:	88 98 8c 00 00 00    	mov    %bl,0x8c(%eax)
  104922:	0f b6 90 8d 00 00 00 	movzbl 0x8d(%eax),%edx
  104929:	83 e2 f0             	and    $0xfffffff0,%edx
  10492c:	83 ca 0a             	or     $0xa,%edx
  10492f:	88 90 8d 00 00 00    	mov    %dl,0x8d(%eax)
  104935:	0f b6 90 8d 00 00 00 	movzbl 0x8d(%eax),%edx
  10493c:	83 ca 10             	or     $0x10,%edx
  10493f:	88 90 8d 00 00 00    	mov    %dl,0x8d(%eax)
  104945:	0f b6 90 8d 00 00 00 	movzbl 0x8d(%eax),%edx
  10494c:	83 ca 60             	or     $0x60,%edx
  10494f:	88 90 8d 00 00 00    	mov    %dl,0x8d(%eax)
  104955:	0f b6 90 8d 00 00 00 	movzbl 0x8d(%eax),%edx
  10495c:	83 ca 80             	or     $0xffffff80,%edx
  10495f:	88 90 8d 00 00 00    	mov    %dl,0x8d(%eax)
  104965:	0f b6 90 8e 00 00 00 	movzbl 0x8e(%eax),%edx
  10496c:	83 e2 f0             	and    $0xfffffff0,%edx
  10496f:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
  104975:	0f b6 90 8e 00 00 00 	movzbl 0x8e(%eax),%edx
  10497c:	83 e2 ef             	and    $0xffffffef,%edx
  10497f:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
  104985:	0f b6 90 8e 00 00 00 	movzbl 0x8e(%eax),%edx
  10498c:	83 e2 df             	and    $0xffffffdf,%edx
  10498f:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
  104995:	0f b6 90 8e 00 00 00 	movzbl 0x8e(%eax),%edx
  10499c:	83 ca 40             	or     $0x40,%edx
  10499f:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
  1049a5:	0f b6 90 8e 00 00 00 	movzbl 0x8e(%eax),%edx
  1049ac:	83 ca 80             	or     $0xffffff80,%edx
  1049af:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
  1049b5:	88 88 8f 00 00 00    	mov    %cl,0x8f(%eax)
  mycpu()->gdt[SEG_UDATA] = SEG(STA_W, p->offset, (PROCSIZE << 12)-1, DPL_USER);
  1049bb:	e8 d8 c7 ff ff       	call   101198 <mycpu>
  1049c0:	8b 55 08             	mov    0x8(%ebp),%edx
  1049c3:	8b 52 04             	mov    0x4(%edx),%edx
  1049c6:	89 d6                	mov    %edx,%esi
  1049c8:	8b 55 08             	mov    0x8(%ebp),%edx
  1049cb:	8b 52 04             	mov    0x4(%edx),%edx
  1049ce:	c1 ea 10             	shr    $0x10,%edx
  1049d1:	89 d3                	mov    %edx,%ebx
  1049d3:	8b 55 08             	mov    0x8(%ebp),%edx
  1049d6:	8b 52 04             	mov    0x4(%edx),%edx
  1049d9:	c1 ea 18             	shr    $0x18,%edx
  1049dc:	89 d1                	mov    %edx,%ecx
  1049de:	66 c7 80 90 00 00 00 	movw   $0xff,0x90(%eax)
  1049e5:	ff 00 
  1049e7:	66 89 b0 92 00 00 00 	mov    %si,0x92(%eax)
  1049ee:	88 98 94 00 00 00    	mov    %bl,0x94(%eax)
  1049f4:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
  1049fb:	83 e2 f0             	and    $0xfffffff0,%edx
  1049fe:	83 ca 02             	or     $0x2,%edx
  104a01:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
  104a07:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
  104a0e:	83 ca 10             	or     $0x10,%edx
  104a11:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
  104a17:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
  104a1e:	83 ca 60             	or     $0x60,%edx
  104a21:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
  104a27:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
  104a2e:	83 ca 80             	or     $0xffffff80,%edx
  104a31:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
  104a37:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
  104a3e:	83 e2 f0             	and    $0xfffffff0,%edx
  104a41:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
  104a47:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
  104a4e:	83 e2 ef             	and    $0xffffffef,%edx
  104a51:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
  104a57:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
  104a5e:	83 e2 df             	and    $0xffffffdf,%edx
  104a61:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
  104a67:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
  104a6e:	83 ca 40             	or     $0x40,%edx
  104a71:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
  104a77:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
  104a7e:	83 ca 80             	or     $0xffffff80,%edx
  104a81:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
  104a87:	88 88 97 00 00 00    	mov    %cl,0x97(%eax)
  lgdt(mycpu()->gdt, sizeof(mycpu()->gdt));
  104a8d:	e8 06 c7 ff ff       	call   101198 <mycpu>
  104a92:	83 c0 70             	add    $0x70,%eax
  104a95:	83 ec 08             	sub    $0x8,%esp
  104a98:	6a 30                	push   $0x30
  104a9a:	50                   	push   %eax
  104a9b:	e8 2f fc ff ff       	call   1046cf <lgdt>
  104aa0:	83 c4 10             	add    $0x10,%esp
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
  104aa3:	e8 f0 c6 ff ff       	call   101198 <mycpu>
  104aa8:	89 c3                	mov    %eax,%ebx
  104aaa:	e8 e9 c6 ff ff       	call   101198 <mycpu>
  104aaf:	83 c0 08             	add    $0x8,%eax
  104ab2:	89 c6                	mov    %eax,%esi
  104ab4:	e8 df c6 ff ff       	call   101198 <mycpu>
  104ab9:	83 c0 08             	add    $0x8,%eax
  104abc:	c1 e8 10             	shr    $0x10,%eax
  104abf:	88 45 f7             	mov    %al,-0x9(%ebp)
  104ac2:	e8 d1 c6 ff ff       	call   101198 <mycpu>
  104ac7:	83 c0 08             	add    $0x8,%eax
  104aca:	c1 e8 18             	shr    $0x18,%eax
  104acd:	89 c2                	mov    %eax,%edx
  104acf:	66 c7 83 98 00 00 00 	movw   $0x67,0x98(%ebx)
  104ad6:	67 00 
  104ad8:	66 89 b3 9a 00 00 00 	mov    %si,0x9a(%ebx)
  104adf:	0f b6 45 f7          	movzbl -0x9(%ebp),%eax
  104ae3:	88 83 9c 00 00 00    	mov    %al,0x9c(%ebx)
  104ae9:	0f b6 83 9d 00 00 00 	movzbl 0x9d(%ebx),%eax
  104af0:	83 e0 f0             	and    $0xfffffff0,%eax
  104af3:	83 c8 09             	or     $0x9,%eax
  104af6:	88 83 9d 00 00 00    	mov    %al,0x9d(%ebx)
  104afc:	0f b6 83 9d 00 00 00 	movzbl 0x9d(%ebx),%eax
  104b03:	83 c8 10             	or     $0x10,%eax
  104b06:	88 83 9d 00 00 00    	mov    %al,0x9d(%ebx)
  104b0c:	0f b6 83 9d 00 00 00 	movzbl 0x9d(%ebx),%eax
  104b13:	83 e0 9f             	and    $0xffffff9f,%eax
  104b16:	88 83 9d 00 00 00    	mov    %al,0x9d(%ebx)
  104b1c:	0f b6 83 9d 00 00 00 	movzbl 0x9d(%ebx),%eax
  104b23:	83 c8 80             	or     $0xffffff80,%eax
  104b26:	88 83 9d 00 00 00    	mov    %al,0x9d(%ebx)
  104b2c:	0f b6 83 9e 00 00 00 	movzbl 0x9e(%ebx),%eax
  104b33:	83 e0 f0             	and    $0xfffffff0,%eax
  104b36:	88 83 9e 00 00 00    	mov    %al,0x9e(%ebx)
  104b3c:	0f b6 83 9e 00 00 00 	movzbl 0x9e(%ebx),%eax
  104b43:	83 e0 ef             	and    $0xffffffef,%eax
  104b46:	88 83 9e 00 00 00    	mov    %al,0x9e(%ebx)
  104b4c:	0f b6 83 9e 00 00 00 	movzbl 0x9e(%ebx),%eax
  104b53:	83 e0 df             	and    $0xffffffdf,%eax
  104b56:	88 83 9e 00 00 00    	mov    %al,0x9e(%ebx)
  104b5c:	0f b6 83 9e 00 00 00 	movzbl 0x9e(%ebx),%eax
  104b63:	83 c8 40             	or     $0x40,%eax
  104b66:	88 83 9e 00 00 00    	mov    %al,0x9e(%ebx)
  104b6c:	0f b6 83 9e 00 00 00 	movzbl 0x9e(%ebx),%eax
  104b73:	83 e0 7f             	and    $0x7f,%eax
  104b76:	88 83 9e 00 00 00    	mov    %al,0x9e(%ebx)
  104b7c:	88 93 9f 00 00 00    	mov    %dl,0x9f(%ebx)
  mycpu()->gdt[SEG_TSS].s = 0;
  104b82:	e8 11 c6 ff ff       	call   101198 <mycpu>
  104b87:	0f b6 90 9d 00 00 00 	movzbl 0x9d(%eax),%edx
  104b8e:	83 e2 ef             	and    $0xffffffef,%edx
  104b91:	88 90 9d 00 00 00    	mov    %dl,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
  104b97:	e8 fc c5 ff ff       	call   101198 <mycpu>
  104b9c:	66 c7 40 10 10 00    	movw   $0x10,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
  104ba2:	8b 45 08             	mov    0x8(%ebp),%eax
  104ba5:	8b 40 08             	mov    0x8(%eax),%eax
  104ba8:	89 c3                	mov    %eax,%ebx
  104baa:	e8 e9 c5 ff ff       	call   101198 <mycpu>
  104baf:	8d 93 00 10 00 00    	lea    0x1000(%ebx),%edx
  104bb5:	89 50 0c             	mov    %edx,0xc(%eax)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
  104bb8:	e8 db c5 ff ff       	call   101198 <mycpu>
  104bbd:	66 c7 40 6e ff ff    	movw   $0xffff,0x6e(%eax)
  ltr(SEG_TSS << 3);
  104bc3:	83 ec 0c             	sub    $0xc,%esp
  104bc6:	6a 28                	push   $0x28
  104bc8:	e8 2c fb ff ff       	call   1046f9 <ltr>
  104bcd:	83 c4 10             	add    $0x10,%esp
  popcli();
  104bd0:	e8 5f cb ff ff       	call   101734 <popcli>
  104bd5:	90                   	nop
  104bd6:	8d 65 f8             	lea    -0x8(%ebp),%esp
  104bd9:	5b                   	pop    %ebx
  104bda:	5e                   	pop    %esi
  104bdb:	5d                   	pop    %ebp
  104bdc:	c3                   	ret

00104bdd <kinit>:
  struct run *freelist;
} kmem;

void
kinit(void *vstart, void *vend)
{
  104bdd:	55                   	push   %ebp
  104bde:	89 e5                	mov    %esp,%ebp
  104be0:	83 ec 08             	sub    $0x8,%esp
  freerange(vstart, vend);
  104be3:	83 ec 08             	sub    $0x8,%esp
  104be6:	ff 75 0c             	push   0xc(%ebp)
  104be9:	ff 75 08             	push   0x8(%ebp)
  104bec:	e8 06 00 00 00       	call   104bf7 <freerange>
  104bf1:	83 c4 10             	add    $0x10,%esp
}
  104bf4:	90                   	nop
  104bf5:	c9                   	leave
  104bf6:	c3                   	ret

00104bf7 <freerange>:

void
freerange(void *vstart, void *vend)
{
  104bf7:	55                   	push   %ebp
  104bf8:	89 e5                	mov    %esp,%ebp
  104bfa:	83 ec 18             	sub    $0x18,%esp
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  104bfd:	8b 45 08             	mov    0x8(%ebp),%eax
  104c00:	05 ff ff 0f 00       	add    $0xfffff,%eax
  104c05:	25 00 00 f0 ff       	and    $0xfff00000,%eax
  104c0a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
  104c0d:	eb 15                	jmp    104c24 <freerange+0x2d>
    kfree(p);
  104c0f:	83 ec 0c             	sub    $0xc,%esp
  104c12:	ff 75 f4             	push   -0xc(%ebp)
  104c15:	e8 1b 00 00 00       	call   104c35 <kfree>
  104c1a:	83 c4 10             	add    $0x10,%esp
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
  104c1d:	81 45 f4 00 00 10 00 	addl   $0x100000,-0xc(%ebp)
  104c24:	8b 45 f4             	mov    -0xc(%ebp),%eax
  104c27:	05 00 00 10 00       	add    $0x100000,%eax
  104c2c:	39 45 0c             	cmp    %eax,0xc(%ebp)
  104c2f:	73 de                	jae    104c0f <freerange+0x18>
}
  104c31:	90                   	nop
  104c32:	90                   	nop
  104c33:	c9                   	leave
  104c34:	c3                   	ret

00104c35 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
  104c35:	55                   	push   %ebp
  104c36:	89 e5                	mov    %esp,%ebp
  104c38:	83 ec 18             	sub    $0x18,%esp
  struct run *r;

  if((uint)v % PGSIZE || v < end) // || V2P(v) >= PHYSTOP)
  104c3b:	8b 45 08             	mov    0x8(%ebp),%eax
  104c3e:	25 ff ff 0f 00       	and    $0xfffff,%eax
  104c43:	85 c0                	test   %eax,%eax
  104c45:	75 09                	jne    104c50 <kfree+0x1b>
  104c47:	81 7d 08 f0 fa 10 00 	cmpl   $0x10faf0,0x8(%ebp)
  104c4e:	73 0d                	jae    104c5d <kfree+0x28>
    panic("kfree");
  104c50:	83 ec 0c             	sub    $0xc,%esp
  104c53:	68 98 5a 10 00       	push   $0x105a98
  104c58:	e8 51 b6 ff ff       	call   1002ae <panic>

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
  104c5d:	83 ec 04             	sub    $0x4,%esp
  104c60:	68 00 00 10 00       	push   $0x100000
  104c65:	6a 01                	push   $0x1
  104c67:	ff 75 08             	push   0x8(%ebp)
  104c6a:	e8 93 c2 ff ff       	call   100f02 <memset>
  104c6f:	83 c4 10             	add    $0x10,%esp

  r = (struct run*)v;
  104c72:	8b 45 08             	mov    0x8(%ebp),%eax
  104c75:	89 45 f4             	mov    %eax,-0xc(%ebp)
  r->next = kmem.freelist;
  104c78:	8b 15 ec ea 10 00    	mov    0x10eaec,%edx
  104c7e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  104c81:	89 10                	mov    %edx,(%eax)
  kmem.freelist = r;
  104c83:	8b 45 f4             	mov    -0xc(%ebp),%eax
  104c86:	a3 ec ea 10 00       	mov    %eax,0x10eaec
}
  104c8b:	90                   	nop
  104c8c:	c9                   	leave
  104c8d:	c3                   	ret

00104c8e <kalloc>:
// Allocate one PGSIZE page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char*
kalloc(void)
{
  104c8e:	55                   	push   %ebp
  104c8f:	89 e5                	mov    %esp,%ebp
  104c91:	83 ec 10             	sub    $0x10,%esp
  struct run *r;

  r = kmem.freelist;
  104c94:	a1 ec ea 10 00       	mov    0x10eaec,%eax
  104c99:	89 45 fc             	mov    %eax,-0x4(%ebp)
  if(r)
  104c9c:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  104ca0:	74 0a                	je     104cac <kalloc+0x1e>
    kmem.freelist = r->next;
  104ca2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  104ca5:	8b 00                	mov    (%eax),%eax
  104ca7:	a3 ec ea 10 00       	mov    %eax,0x10eaec
  return (char*)r;
  104cac:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  104caf:	c9                   	leave
  104cb0:	c3                   	ret

00104cb1 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
  104cb1:	55                   	push   %ebp
  104cb2:	89 e5                	mov    %esp,%ebp
  104cb4:	83 ec 18             	sub    $0x18,%esp
  struct proc *curproc = myproc();
  104cb7:	e8 e6 c4 ff ff       	call   1011a2 <myproc>
  104cbc:	89 45 f4             	mov    %eax,-0xc(%ebp)

  if(addr >= curproc->sz || addr+4 > curproc->sz) {
  104cbf:	8b 45 f4             	mov    -0xc(%ebp),%eax
  104cc2:	8b 00                	mov    (%eax),%eax
  104cc4:	39 45 08             	cmp    %eax,0x8(%ebp)
  104cc7:	73 0f                	jae    104cd8 <fetchint+0x27>
  104cc9:	8b 45 08             	mov    0x8(%ebp),%eax
  104ccc:	8d 50 04             	lea    0x4(%eax),%edx
  104ccf:	8b 45 f4             	mov    -0xc(%ebp),%eax
  104cd2:	8b 00                	mov    (%eax),%eax
  104cd4:	39 d0                	cmp    %edx,%eax
  104cd6:	73 07                	jae    104cdf <fetchint+0x2e>
    return -1;
  104cd8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  104cdd:	eb 17                	jmp    104cf6 <fetchint+0x45>
  }
  *ip = *(int*)(addr + curproc->offset);
  104cdf:	8b 45 f4             	mov    -0xc(%ebp),%eax
  104ce2:	8b 50 04             	mov    0x4(%eax),%edx
  104ce5:	8b 45 08             	mov    0x8(%ebp),%eax
  104ce8:	01 d0                	add    %edx,%eax
  104cea:	8b 10                	mov    (%eax),%edx
  104cec:	8b 45 0c             	mov    0xc(%ebp),%eax
  104cef:	89 10                	mov    %edx,(%eax)
  return 0;
  104cf1:	b8 00 00 00 00       	mov    $0x0,%eax
}
  104cf6:	c9                   	leave
  104cf7:	c3                   	ret

00104cf8 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
  104cf8:	55                   	push   %ebp
  104cf9:	89 e5                	mov    %esp,%ebp
  104cfb:	83 ec 18             	sub    $0x18,%esp
  char *s, *ep;
  struct proc *curproc = myproc();
  104cfe:	e8 9f c4 ff ff       	call   1011a2 <myproc>
  104d03:	89 45 f0             	mov    %eax,-0x10(%ebp)

  if(addr >= curproc->sz)
  104d06:	8b 45 f0             	mov    -0x10(%ebp),%eax
  104d09:	8b 00                	mov    (%eax),%eax
  104d0b:	39 45 08             	cmp    %eax,0x8(%ebp)
  104d0e:	72 07                	jb     104d17 <fetchstr+0x1f>
    return -1;
  104d10:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  104d15:	eb 51                	jmp    104d68 <fetchstr+0x70>
  *pp = (char*)(addr + curproc->offset);
  104d17:	8b 45 f0             	mov    -0x10(%ebp),%eax
  104d1a:	8b 50 04             	mov    0x4(%eax),%edx
  104d1d:	8b 45 08             	mov    0x8(%ebp),%eax
  104d20:	01 c2                	add    %eax,%edx
  104d22:	8b 45 0c             	mov    0xc(%ebp),%eax
  104d25:	89 10                	mov    %edx,(%eax)
  ep = (char*)(curproc->sz + curproc->offset);
  104d27:	8b 45 f0             	mov    -0x10(%ebp),%eax
  104d2a:	8b 50 04             	mov    0x4(%eax),%edx
  104d2d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  104d30:	8b 00                	mov    (%eax),%eax
  104d32:	01 d0                	add    %edx,%eax
  104d34:	89 45 ec             	mov    %eax,-0x14(%ebp)
  for(s = *pp; s < ep; s++){
  104d37:	8b 45 0c             	mov    0xc(%ebp),%eax
  104d3a:	8b 00                	mov    (%eax),%eax
  104d3c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  104d3f:	eb 1a                	jmp    104d5b <fetchstr+0x63>
    if(*s == 0)
  104d41:	8b 45 f4             	mov    -0xc(%ebp),%eax
  104d44:	0f b6 00             	movzbl (%eax),%eax
  104d47:	84 c0                	test   %al,%al
  104d49:	75 0c                	jne    104d57 <fetchstr+0x5f>
      return s - *pp;
  104d4b:	8b 45 0c             	mov    0xc(%ebp),%eax
  104d4e:	8b 10                	mov    (%eax),%edx
  104d50:	8b 45 f4             	mov    -0xc(%ebp),%eax
  104d53:	29 d0                	sub    %edx,%eax
  104d55:	eb 11                	jmp    104d68 <fetchstr+0x70>
  for(s = *pp; s < ep; s++){
  104d57:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  104d5b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  104d5e:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  104d61:	72 de                	jb     104d41 <fetchstr+0x49>
  }
  return -1;
  104d63:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  104d68:	c9                   	leave
  104d69:	c3                   	ret

00104d6a <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  104d6a:	55                   	push   %ebp
  104d6b:	89 e5                	mov    %esp,%ebp
  104d6d:	83 ec 08             	sub    $0x8,%esp
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
  104d70:	e8 2d c4 ff ff       	call   1011a2 <myproc>
  104d75:	8b 40 18             	mov    0x18(%eax),%eax
  104d78:	8b 40 44             	mov    0x44(%eax),%eax
  104d7b:	8b 55 08             	mov    0x8(%ebp),%edx
  104d7e:	c1 e2 02             	shl    $0x2,%edx
  104d81:	01 d0                	add    %edx,%eax
  104d83:	83 c0 04             	add    $0x4,%eax
  104d86:	83 ec 08             	sub    $0x8,%esp
  104d89:	ff 75 0c             	push   0xc(%ebp)
  104d8c:	50                   	push   %eax
  104d8d:	e8 1f ff ff ff       	call   104cb1 <fetchint>
  104d92:	83 c4 10             	add    $0x10,%esp
}
  104d95:	c9                   	leave
  104d96:	c3                   	ret

00104d97 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
  104d97:	55                   	push   %ebp
  104d98:	89 e5                	mov    %esp,%ebp
  104d9a:	83 ec 18             	sub    $0x18,%esp
  int i;
  struct proc *curproc = myproc();
  104d9d:	e8 00 c4 ff ff       	call   1011a2 <myproc>
  104da2:	89 45 f4             	mov    %eax,-0xc(%ebp)
 
  if(argint(n, &i) < 0)
  104da5:	83 ec 08             	sub    $0x8,%esp
  104da8:	8d 45 f0             	lea    -0x10(%ebp),%eax
  104dab:	50                   	push   %eax
  104dac:	ff 75 08             	push   0x8(%ebp)
  104daf:	e8 b6 ff ff ff       	call   104d6a <argint>
  104db4:	83 c4 10             	add    $0x10,%esp
  104db7:	85 c0                	test   %eax,%eax
  104db9:	79 07                	jns    104dc2 <argptr+0x2b>
    return -1;
  104dbb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  104dc0:	eb 41                	jmp    104e03 <argptr+0x6c>
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
  104dc2:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  104dc6:	78 1f                	js     104de7 <argptr+0x50>
  104dc8:	8b 45 f4             	mov    -0xc(%ebp),%eax
  104dcb:	8b 00                	mov    (%eax),%eax
  104dcd:	8b 55 f0             	mov    -0x10(%ebp),%edx
  104dd0:	39 c2                	cmp    %eax,%edx
  104dd2:	73 13                	jae    104de7 <argptr+0x50>
  104dd4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  104dd7:	89 c2                	mov    %eax,%edx
  104dd9:	8b 45 10             	mov    0x10(%ebp),%eax
  104ddc:	01 c2                	add    %eax,%edx
  104dde:	8b 45 f4             	mov    -0xc(%ebp),%eax
  104de1:	8b 00                	mov    (%eax),%eax
  104de3:	39 d0                	cmp    %edx,%eax
  104de5:	73 07                	jae    104dee <argptr+0x57>
    return -1;
  104de7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  104dec:	eb 15                	jmp    104e03 <argptr+0x6c>
  *pp = (char*)(i + curproc->offset);
  104dee:	8b 45 f4             	mov    -0xc(%ebp),%eax
  104df1:	8b 40 04             	mov    0x4(%eax),%eax
  104df4:	8b 55 f0             	mov    -0x10(%ebp),%edx
  104df7:	01 c2                	add    %eax,%edx
  104df9:	8b 45 0c             	mov    0xc(%ebp),%eax
  104dfc:	89 10                	mov    %edx,(%eax)
  return 0;
  104dfe:	b8 00 00 00 00       	mov    $0x0,%eax
}
  104e03:	c9                   	leave
  104e04:	c3                   	ret

00104e05 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
  104e05:	55                   	push   %ebp
  104e06:	89 e5                	mov    %esp,%ebp
  104e08:	83 ec 18             	sub    $0x18,%esp
  int addr;
  if(argint(n, &addr) < 0)
  104e0b:	83 ec 08             	sub    $0x8,%esp
  104e0e:	8d 45 f0             	lea    -0x10(%ebp),%eax
  104e11:	50                   	push   %eax
  104e12:	ff 75 08             	push   0x8(%ebp)
  104e15:	e8 50 ff ff ff       	call   104d6a <argint>
  104e1a:	83 c4 10             	add    $0x10,%esp
  104e1d:	85 c0                	test   %eax,%eax
  104e1f:	79 07                	jns    104e28 <argstr+0x23>
    return -1;
  104e21:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  104e26:	eb 18                	jmp    104e40 <argstr+0x3b>
  int l = fetchstr(addr, pp);
  104e28:	8b 45 f0             	mov    -0x10(%ebp),%eax
  104e2b:	83 ec 08             	sub    $0x8,%esp
  104e2e:	ff 75 0c             	push   0xc(%ebp)
  104e31:	50                   	push   %eax
  104e32:	e8 c1 fe ff ff       	call   104cf8 <fetchstr>
  104e37:	83 c4 10             	add    $0x10,%esp
  104e3a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  return l;
  104e3d:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  104e40:	c9                   	leave
  104e41:	c3                   	ret

00104e42 <syscall>:
[SYS_get_sched_policy] sys_get_sched_policy,
};

void
syscall(void)
{
  104e42:	55                   	push   %ebp
  104e43:	89 e5                	mov    %esp,%ebp
  104e45:	83 ec 18             	sub    $0x18,%esp
  int num;
  struct proc *curproc = myproc();
  104e48:	e8 55 c3 ff ff       	call   1011a2 <myproc>
  104e4d:	89 45 f4             	mov    %eax,-0xc(%ebp)

  num = curproc->tf->eax;
  104e50:	8b 45 f4             	mov    -0xc(%ebp),%eax
  104e53:	8b 40 18             	mov    0x18(%eax),%eax
  104e56:	8b 40 1c             	mov    0x1c(%eax),%eax
  104e59:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
  104e5c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  104e60:	7e 2f                	jle    104e91 <syscall+0x4f>
  104e62:	8b 45 f0             	mov    -0x10(%ebp),%eax
  104e65:	83 f8 06             	cmp    $0x6,%eax
  104e68:	77 27                	ja     104e91 <syscall+0x4f>
  104e6a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  104e6d:	8b 04 85 30 64 10 00 	mov    0x106430(,%eax,4),%eax
  104e74:	85 c0                	test   %eax,%eax
  104e76:	74 19                	je     104e91 <syscall+0x4f>
    curproc->tf->eax = syscalls[num]();
  104e78:	8b 45 f0             	mov    -0x10(%ebp),%eax
  104e7b:	8b 04 85 30 64 10 00 	mov    0x106430(,%eax,4),%eax
  104e82:	ff d0                	call   *%eax
  104e84:	89 c2                	mov    %eax,%edx
  104e86:	8b 45 f4             	mov    -0xc(%ebp),%eax
  104e89:	8b 40 18             	mov    0x18(%eax),%eax
  104e8c:	89 50 1c             	mov    %edx,0x1c(%eax)
  104e8f:	eb 2c                	jmp    104ebd <syscall+0x7b>
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
  104e91:	8b 45 f4             	mov    -0xc(%ebp),%eax
  104e94:	8d 50 64             	lea    0x64(%eax),%edx
    cprintf("%d %s: unknown sys call %d\n",
  104e97:	8b 45 f4             	mov    -0xc(%ebp),%eax
  104e9a:	8b 40 10             	mov    0x10(%eax),%eax
  104e9d:	ff 75 f0             	push   -0x10(%ebp)
  104ea0:	52                   	push   %edx
  104ea1:	50                   	push   %eax
  104ea2:	68 9e 5a 10 00       	push   $0x105a9e
  104ea7:	e8 40 b2 ff ff       	call   1000ec <cprintf>
  104eac:	83 c4 10             	add    $0x10,%esp
    curproc->tf->eax = -1;
  104eaf:	8b 45 f4             	mov    -0xc(%ebp),%eax
  104eb2:	8b 40 18             	mov    0x18(%eax),%eax
  104eb5:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
  }
}
  104ebc:	90                   	nop
  104ebd:	90                   	nop
  104ebe:	c9                   	leave
  104ebf:	c3                   	ret

00104ec0 <argfd>:

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
{
  104ec0:	55                   	push   %ebp
  104ec1:	89 e5                	mov    %esp,%ebp
  104ec3:	83 ec 18             	sub    $0x18,%esp
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0) {
  104ec6:	83 ec 08             	sub    $0x8,%esp
  104ec9:	8d 45 f0             	lea    -0x10(%ebp),%eax
  104ecc:	50                   	push   %eax
  104ecd:	ff 75 08             	push   0x8(%ebp)
  104ed0:	e8 95 fe ff ff       	call   104d6a <argint>
  104ed5:	83 c4 10             	add    $0x10,%esp
  104ed8:	85 c0                	test   %eax,%eax
  104eda:	79 07                	jns    104ee3 <argfd+0x23>
    return -1;
  104edc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  104ee1:	eb 4e                	jmp    104f31 <argfd+0x71>
  }
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
  104ee3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  104ee6:	85 c0                	test   %eax,%eax
  104ee8:	78 1f                	js     104f09 <argfd+0x49>
  104eea:	8b 45 f0             	mov    -0x10(%ebp),%eax
  104eed:	83 f8 0f             	cmp    $0xf,%eax
  104ef0:	7f 17                	jg     104f09 <argfd+0x49>
  104ef2:	e8 ab c2 ff ff       	call   1011a2 <myproc>
  104ef7:	8b 55 f0             	mov    -0x10(%ebp),%edx
  104efa:	83 c2 08             	add    $0x8,%edx
  104efd:	8b 04 90             	mov    (%eax,%edx,4),%eax
  104f00:	89 45 f4             	mov    %eax,-0xc(%ebp)
  104f03:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  104f07:	75 07                	jne    104f10 <argfd+0x50>
    return -1;
  104f09:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  104f0e:	eb 21                	jmp    104f31 <argfd+0x71>
  if(pfd)
  104f10:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  104f14:	74 08                	je     104f1e <argfd+0x5e>
    *pfd = fd;
  104f16:	8b 55 f0             	mov    -0x10(%ebp),%edx
  104f19:	8b 45 0c             	mov    0xc(%ebp),%eax
  104f1c:	89 10                	mov    %edx,(%eax)
  if(pf)
  104f1e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  104f22:	74 08                	je     104f2c <argfd+0x6c>
    *pf = f;
  104f24:	8b 45 10             	mov    0x10(%ebp),%eax
  104f27:	8b 55 f4             	mov    -0xc(%ebp),%edx
  104f2a:	89 10                	mov    %edx,(%eax)
  return 0;
  104f2c:	b8 00 00 00 00       	mov    $0x0,%eax
}
  104f31:	c9                   	leave
  104f32:	c3                   	ret

00104f33 <fdalloc>:

// Allocate a file descriptor for the given file.
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
  104f33:	55                   	push   %ebp
  104f34:	89 e5                	mov    %esp,%ebp
  104f36:	83 ec 18             	sub    $0x18,%esp
  int fd;
  struct proc *curproc = myproc();
  104f39:	e8 64 c2 ff ff       	call   1011a2 <myproc>
  104f3e:	89 45 f0             	mov    %eax,-0x10(%ebp)

  for(fd = 0; fd < NOFILE; fd++){
  104f41:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  104f48:	eb 28                	jmp    104f72 <fdalloc+0x3f>
    if(curproc->ofile[fd] == 0){
  104f4a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  104f4d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  104f50:	83 c2 08             	add    $0x8,%edx
  104f53:	8b 04 90             	mov    (%eax,%edx,4),%eax
  104f56:	85 c0                	test   %eax,%eax
  104f58:	75 14                	jne    104f6e <fdalloc+0x3b>
      curproc->ofile[fd] = f;
  104f5a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  104f5d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  104f60:	8d 4a 08             	lea    0x8(%edx),%ecx
  104f63:	8b 55 08             	mov    0x8(%ebp),%edx
  104f66:	89 14 88             	mov    %edx,(%eax,%ecx,4)
      return fd;
  104f69:	8b 45 f4             	mov    -0xc(%ebp),%eax
  104f6c:	eb 0f                	jmp    104f7d <fdalloc+0x4a>
  for(fd = 0; fd < NOFILE; fd++){
  104f6e:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  104f72:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
  104f76:	7e d2                	jle    104f4a <fdalloc+0x17>
    }
  }
  return -1;
  104f78:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  104f7d:	c9                   	leave
  104f7e:	c3                   	ret

00104f7f <sys_read>:

int
sys_read(void)
{
  104f7f:	55                   	push   %ebp
  104f80:	89 e5                	mov    %esp,%ebp
  104f82:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
  104f85:	83 ec 04             	sub    $0x4,%esp
  104f88:	8d 45 f4             	lea    -0xc(%ebp),%eax
  104f8b:	50                   	push   %eax
  104f8c:	6a 00                	push   $0x0
  104f8e:	6a 00                	push   $0x0
  104f90:	e8 2b ff ff ff       	call   104ec0 <argfd>
  104f95:	83 c4 10             	add    $0x10,%esp
  104f98:	85 c0                	test   %eax,%eax
  104f9a:	78 2e                	js     104fca <sys_read+0x4b>
  104f9c:	83 ec 08             	sub    $0x8,%esp
  104f9f:	8d 45 f0             	lea    -0x10(%ebp),%eax
  104fa2:	50                   	push   %eax
  104fa3:	6a 02                	push   $0x2
  104fa5:	e8 c0 fd ff ff       	call   104d6a <argint>
  104faa:	83 c4 10             	add    $0x10,%esp
  104fad:	85 c0                	test   %eax,%eax
  104faf:	78 19                	js     104fca <sys_read+0x4b>
  104fb1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  104fb4:	83 ec 04             	sub    $0x4,%esp
  104fb7:	50                   	push   %eax
  104fb8:	8d 45 ec             	lea    -0x14(%ebp),%eax
  104fbb:	50                   	push   %eax
  104fbc:	6a 01                	push   $0x1
  104fbe:	e8 d4 fd ff ff       	call   104d97 <argptr>
  104fc3:	83 c4 10             	add    $0x10,%esp
  104fc6:	85 c0                	test   %eax,%eax
  104fc8:	79 07                	jns    104fd1 <sys_read+0x52>
    return -1;
  104fca:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  104fcf:	eb 17                	jmp    104fe8 <sys_read+0x69>
  return fileread(f, p, n);
  104fd1:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  104fd4:	8b 55 ec             	mov    -0x14(%ebp),%edx
  104fd7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  104fda:	83 ec 04             	sub    $0x4,%esp
  104fdd:	51                   	push   %ecx
  104fde:	52                   	push   %edx
  104fdf:	50                   	push   %eax
  104fe0:	e8 ec eb ff ff       	call   103bd1 <fileread>
  104fe5:	83 c4 10             	add    $0x10,%esp
}
  104fe8:	c9                   	leave
  104fe9:	c3                   	ret

00104fea <sys_write>:

int
sys_write(void)
{
  104fea:	55                   	push   %ebp
  104feb:	89 e5                	mov    %esp,%ebp
  104fed:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0) {
  104ff0:	83 ec 04             	sub    $0x4,%esp
  104ff3:	8d 45 f4             	lea    -0xc(%ebp),%eax
  104ff6:	50                   	push   %eax
  104ff7:	6a 00                	push   $0x0
  104ff9:	6a 00                	push   $0x0
  104ffb:	e8 c0 fe ff ff       	call   104ec0 <argfd>
  105000:	83 c4 10             	add    $0x10,%esp
  105003:	85 c0                	test   %eax,%eax
  105005:	78 2e                	js     105035 <sys_write+0x4b>
  105007:	83 ec 08             	sub    $0x8,%esp
  10500a:	8d 45 f0             	lea    -0x10(%ebp),%eax
  10500d:	50                   	push   %eax
  10500e:	6a 02                	push   $0x2
  105010:	e8 55 fd ff ff       	call   104d6a <argint>
  105015:	83 c4 10             	add    $0x10,%esp
  105018:	85 c0                	test   %eax,%eax
  10501a:	78 19                	js     105035 <sys_write+0x4b>
  10501c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10501f:	83 ec 04             	sub    $0x4,%esp
  105022:	50                   	push   %eax
  105023:	8d 45 ec             	lea    -0x14(%ebp),%eax
  105026:	50                   	push   %eax
  105027:	6a 01                	push   $0x1
  105029:	e8 69 fd ff ff       	call   104d97 <argptr>
  10502e:	83 c4 10             	add    $0x10,%esp
  105031:	85 c0                	test   %eax,%eax
  105033:	79 07                	jns    10503c <sys_write+0x52>
    return -1;
  105035:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  10503a:	eb 17                	jmp    105053 <sys_write+0x69>
  }
  return filewrite(f, p, n);
  10503c:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  10503f:	8b 55 ec             	mov    -0x14(%ebp),%edx
  105042:	8b 45 f4             	mov    -0xc(%ebp),%eax
  105045:	83 ec 04             	sub    $0x4,%esp
  105048:	51                   	push   %ecx
  105049:	52                   	push   %edx
  10504a:	50                   	push   %eax
  10504b:	e8 00 ec ff ff       	call   103c50 <filewrite>
  105050:	83 c4 10             	add    $0x10,%esp
}
  105053:	c9                   	leave
  105054:	c3                   	ret

00105055 <sys_close>:

int
sys_close(void)
{
  105055:	55                   	push   %ebp
  105056:	89 e5                	mov    %esp,%ebp
  105058:	83 ec 18             	sub    $0x18,%esp
  int fd;
  struct file *f;

  if(argfd(0, &fd, &f) < 0)
  10505b:	83 ec 04             	sub    $0x4,%esp
  10505e:	8d 45 f0             	lea    -0x10(%ebp),%eax
  105061:	50                   	push   %eax
  105062:	8d 45 f4             	lea    -0xc(%ebp),%eax
  105065:	50                   	push   %eax
  105066:	6a 00                	push   $0x0
  105068:	e8 53 fe ff ff       	call   104ec0 <argfd>
  10506d:	83 c4 10             	add    $0x10,%esp
  105070:	85 c0                	test   %eax,%eax
  105072:	79 07                	jns    10507b <sys_close+0x26>
    return -1;
  105074:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  105079:	eb 26                	jmp    1050a1 <sys_close+0x4c>
  myproc()->ofile[fd] = 0;
  10507b:	e8 22 c1 ff ff       	call   1011a2 <myproc>
  105080:	8b 55 f4             	mov    -0xc(%ebp),%edx
  105083:	83 c2 08             	add    $0x8,%edx
  105086:	c7 04 90 00 00 00 00 	movl   $0x0,(%eax,%edx,4)
  fileclose(f);
  10508d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  105090:	83 ec 0c             	sub    $0xc,%esp
  105093:	50                   	push   %eax
  105094:	e8 64 ea ff ff       	call   103afd <fileclose>
  105099:	83 c4 10             	add    $0x10,%esp
  return 0;
  10509c:	b8 00 00 00 00       	mov    $0x0,%eax
}
  1050a1:	c9                   	leave
  1050a2:	c3                   	ret

001050a3 <create>:

static struct inode*
create(char *path, short type, short major, short minor)
{
  1050a3:	55                   	push   %ebp
  1050a4:	89 e5                	mov    %esp,%ebp
  1050a6:	83 ec 38             	sub    $0x38,%esp
  1050a9:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  1050ac:	8b 55 10             	mov    0x10(%ebp),%edx
  1050af:	8b 45 14             	mov    0x14(%ebp),%eax
  1050b2:	66 89 4d d4          	mov    %cx,-0x2c(%ebp)
  1050b6:	66 89 55 d0          	mov    %dx,-0x30(%ebp)
  1050ba:	66 89 45 cc          	mov    %ax,-0x34(%ebp)
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
  1050be:	83 ec 08             	sub    $0x8,%esp
  1050c1:	8d 45 e2             	lea    -0x1e(%ebp),%eax
  1050c4:	50                   	push   %eax
  1050c5:	ff 75 08             	push   0x8(%ebp)
  1050c8:	e8 a7 e9 ff ff       	call   103a74 <nameiparent>
  1050cd:	83 c4 10             	add    $0x10,%esp
  1050d0:	89 45 f4             	mov    %eax,-0xc(%ebp)
  1050d3:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  1050d7:	75 0a                	jne    1050e3 <create+0x40>
    return 0;
  1050d9:	b8 00 00 00 00       	mov    $0x0,%eax
  1050de:	e9 8e 01 00 00       	jmp    105271 <create+0x1ce>
  iread(dp);
  1050e3:	83 ec 0c             	sub    $0xc,%esp
  1050e6:	ff 75 f4             	push   -0xc(%ebp)
  1050e9:	e8 c6 df ff ff       	call   1030b4 <iread>
  1050ee:	83 c4 10             	add    $0x10,%esp

  if((ip = dirlookup(dp, name, 0)) != 0){
  1050f1:	83 ec 04             	sub    $0x4,%esp
  1050f4:	6a 00                	push   $0x0
  1050f6:	8d 45 e2             	lea    -0x1e(%ebp),%eax
  1050f9:	50                   	push   %eax
  1050fa:	ff 75 f4             	push   -0xc(%ebp)
  1050fd:	e8 39 e6 ff ff       	call   10373b <dirlookup>
  105102:	83 c4 10             	add    $0x10,%esp
  105105:	89 45 f0             	mov    %eax,-0x10(%ebp)
  105108:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  10510c:	74 50                	je     10515e <create+0xbb>
    iput(dp);
  10510e:	83 ec 0c             	sub    $0xc,%esp
  105111:	ff 75 f4             	push   -0xc(%ebp)
  105114:	e8 bf dd ff ff       	call   102ed8 <iput>
  105119:	83 c4 10             	add    $0x10,%esp
    iread(ip);
  10511c:	83 ec 0c             	sub    $0xc,%esp
  10511f:	ff 75 f0             	push   -0x10(%ebp)
  105122:	e8 8d df ff ff       	call   1030b4 <iread>
  105127:	83 c4 10             	add    $0x10,%esp
    if(type == T_FILE && ip->type == T_FILE)
  10512a:	66 83 7d d4 02       	cmpw   $0x2,-0x2c(%ebp)
  10512f:	75 15                	jne    105146 <create+0xa3>
  105131:	8b 45 f0             	mov    -0x10(%ebp),%eax
  105134:	0f b7 40 10          	movzwl 0x10(%eax),%eax
  105138:	66 83 f8 02          	cmp    $0x2,%ax
  10513c:	75 08                	jne    105146 <create+0xa3>
      return ip;
  10513e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  105141:	e9 2b 01 00 00       	jmp    105271 <create+0x1ce>
    iput(ip);
  105146:	83 ec 0c             	sub    $0xc,%esp
  105149:	ff 75 f0             	push   -0x10(%ebp)
  10514c:	e8 87 dd ff ff       	call   102ed8 <iput>
  105151:	83 c4 10             	add    $0x10,%esp
    return 0;
  105154:	b8 00 00 00 00       	mov    $0x0,%eax
  105159:	e9 13 01 00 00       	jmp    105271 <create+0x1ce>
  }

  if((ip = ialloc(dp->dev, type)) == 0)
  10515e:	0f bf 55 d4          	movswl -0x2c(%ebp),%edx
  105162:	8b 45 f4             	mov    -0xc(%ebp),%eax
  105165:	8b 00                	mov    (%eax),%eax
  105167:	83 ec 08             	sub    $0x8,%esp
  10516a:	52                   	push   %edx
  10516b:	50                   	push   %eax
  10516c:	e8 91 dc ff ff       	call   102e02 <ialloc>
  105171:	83 c4 10             	add    $0x10,%esp
  105174:	89 45 f0             	mov    %eax,-0x10(%ebp)
  105177:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  10517b:	75 0d                	jne    10518a <create+0xe7>
    panic("create: ialloc");
  10517d:	83 ec 0c             	sub    $0xc,%esp
  105180:	68 ba 5a 10 00       	push   $0x105aba
  105185:	e8 24 b1 ff ff       	call   1002ae <panic>

  iread(ip);
  10518a:	83 ec 0c             	sub    $0xc,%esp
  10518d:	ff 75 f0             	push   -0x10(%ebp)
  105190:	e8 1f df ff ff       	call   1030b4 <iread>
  105195:	83 c4 10             	add    $0x10,%esp
  ip->major = major;
  105198:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10519b:	0f b7 55 d0          	movzwl -0x30(%ebp),%edx
  10519f:	66 89 50 12          	mov    %dx,0x12(%eax)
  ip->minor = minor;
  1051a3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1051a6:	0f b7 55 cc          	movzwl -0x34(%ebp),%edx
  1051aa:	66 89 50 14          	mov    %dx,0x14(%eax)
  ip->nlink = 1;
  1051ae:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1051b1:	66 c7 40 16 01 00    	movw   $0x1,0x16(%eax)
  iupdate(ip);
  1051b7:	83 ec 0c             	sub    $0xc,%esp
  1051ba:	ff 75 f0             	push   -0x10(%ebp)
  1051bd:	e8 82 dd ff ff       	call   102f44 <iupdate>
  1051c2:	83 c4 10             	add    $0x10,%esp

  if(type == T_DIR){  // Create . and .. entries.
  1051c5:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
  1051ca:	75 6a                	jne    105236 <create+0x193>
    dp->nlink++;  // for ".."
  1051cc:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1051cf:	0f b7 40 16          	movzwl 0x16(%eax),%eax
  1051d3:	83 c0 01             	add    $0x1,%eax
  1051d6:	89 c2                	mov    %eax,%edx
  1051d8:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1051db:	66 89 50 16          	mov    %dx,0x16(%eax)
    iupdate(dp);
  1051df:	83 ec 0c             	sub    $0xc,%esp
  1051e2:	ff 75 f4             	push   -0xc(%ebp)
  1051e5:	e8 5a dd ff ff       	call   102f44 <iupdate>
  1051ea:	83 c4 10             	add    $0x10,%esp
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
  1051ed:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1051f0:	8b 40 04             	mov    0x4(%eax),%eax
  1051f3:	83 ec 04             	sub    $0x4,%esp
  1051f6:	50                   	push   %eax
  1051f7:	68 c9 5a 10 00       	push   $0x105ac9
  1051fc:	ff 75 f0             	push   -0x10(%ebp)
  1051ff:	e8 f1 e5 ff ff       	call   1037f5 <dirlink>
  105204:	83 c4 10             	add    $0x10,%esp
  105207:	85 c0                	test   %eax,%eax
  105209:	78 1e                	js     105229 <create+0x186>
  10520b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10520e:	8b 40 04             	mov    0x4(%eax),%eax
  105211:	83 ec 04             	sub    $0x4,%esp
  105214:	50                   	push   %eax
  105215:	68 cb 5a 10 00       	push   $0x105acb
  10521a:	ff 75 f0             	push   -0x10(%ebp)
  10521d:	e8 d3 e5 ff ff       	call   1037f5 <dirlink>
  105222:	83 c4 10             	add    $0x10,%esp
  105225:	85 c0                	test   %eax,%eax
  105227:	79 0d                	jns    105236 <create+0x193>
      panic("create dots");
  105229:	83 ec 0c             	sub    $0xc,%esp
  10522c:	68 ce 5a 10 00       	push   $0x105ace
  105231:	e8 78 b0 ff ff       	call   1002ae <panic>
  }

  if(dirlink(dp, name, ip->inum) < 0)
  105236:	8b 45 f0             	mov    -0x10(%ebp),%eax
  105239:	8b 40 04             	mov    0x4(%eax),%eax
  10523c:	83 ec 04             	sub    $0x4,%esp
  10523f:	50                   	push   %eax
  105240:	8d 45 e2             	lea    -0x1e(%ebp),%eax
  105243:	50                   	push   %eax
  105244:	ff 75 f4             	push   -0xc(%ebp)
  105247:	e8 a9 e5 ff ff       	call   1037f5 <dirlink>
  10524c:	83 c4 10             	add    $0x10,%esp
  10524f:	85 c0                	test   %eax,%eax
  105251:	79 0d                	jns    105260 <create+0x1bd>
    panic("create: dirlink");
  105253:	83 ec 0c             	sub    $0xc,%esp
  105256:	68 da 5a 10 00       	push   $0x105ada
  10525b:	e8 4e b0 ff ff       	call   1002ae <panic>

  iput(dp);
  105260:	83 ec 0c             	sub    $0xc,%esp
  105263:	ff 75 f4             	push   -0xc(%ebp)
  105266:	e8 6d dc ff ff       	call   102ed8 <iput>
  10526b:	83 c4 10             	add    $0x10,%esp

  return ip;
  10526e:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  105271:	c9                   	leave
  105272:	c3                   	ret

00105273 <sys_open>:

int
sys_open(void)
{
  105273:	55                   	push   %ebp
  105274:	89 e5                	mov    %esp,%ebp
  105276:	83 ec 28             	sub    $0x28,%esp
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if((argstr(0, &path) < 0) || (argint(1, &omode) < 0)) {
  105279:	83 ec 08             	sub    $0x8,%esp
  10527c:	8d 45 e8             	lea    -0x18(%ebp),%eax
  10527f:	50                   	push   %eax
  105280:	6a 00                	push   $0x0
  105282:	e8 7e fb ff ff       	call   104e05 <argstr>
  105287:	83 c4 10             	add    $0x10,%esp
  10528a:	85 c0                	test   %eax,%eax
  10528c:	78 15                	js     1052a3 <sys_open+0x30>
  10528e:	83 ec 08             	sub    $0x8,%esp
  105291:	8d 45 e4             	lea    -0x1c(%ebp),%eax
  105294:	50                   	push   %eax
  105295:	6a 01                	push   $0x1
  105297:	e8 ce fa ff ff       	call   104d6a <argint>
  10529c:	83 c4 10             	add    $0x10,%esp
  10529f:	85 c0                	test   %eax,%eax
  1052a1:	79 0a                	jns    1052ad <sys_open+0x3a>
    return -1;
  1052a3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  1052a8:	e9 53 01 00 00       	jmp    105400 <sys_open+0x18d>
  }

  begin_op();
  1052ad:	e8 6b f2 ff ff       	call   10451d <begin_op>

  if(omode & O_CREATE){
  1052b2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  1052b5:	25 00 02 00 00       	and    $0x200,%eax
  1052ba:	85 c0                	test   %eax,%eax
  1052bc:	74 2a                	je     1052e8 <sys_open+0x75>
    ip = create(path, T_FILE, 0, 0);
  1052be:	8b 45 e8             	mov    -0x18(%ebp),%eax
  1052c1:	6a 00                	push   $0x0
  1052c3:	6a 00                	push   $0x0
  1052c5:	6a 02                	push   $0x2
  1052c7:	50                   	push   %eax
  1052c8:	e8 d6 fd ff ff       	call   1050a3 <create>
  1052cd:	83 c4 10             	add    $0x10,%esp
  1052d0:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(ip == 0){
  1052d3:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  1052d7:	75 75                	jne    10534e <sys_open+0xdb>
      end_op();
  1052d9:	e8 45 f2 ff ff       	call   104523 <end_op>
      return -1;
  1052de:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  1052e3:	e9 18 01 00 00       	jmp    105400 <sys_open+0x18d>
    }
  } else {
    if((ip = namei(path)) == 0){
  1052e8:	8b 45 e8             	mov    -0x18(%ebp),%eax
  1052eb:	83 ec 0c             	sub    $0xc,%esp
  1052ee:	50                   	push   %eax
  1052ef:	e8 64 e7 ff ff       	call   103a58 <namei>
  1052f4:	83 c4 10             	add    $0x10,%esp
  1052f7:	89 45 f4             	mov    %eax,-0xc(%ebp)
  1052fa:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  1052fe:	75 0f                	jne    10530f <sys_open+0x9c>
      end_op();
  105300:	e8 1e f2 ff ff       	call   104523 <end_op>
      return -1;
  105305:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  10530a:	e9 f1 00 00 00       	jmp    105400 <sys_open+0x18d>
    }
    iread(ip);
  10530f:	83 ec 0c             	sub    $0xc,%esp
  105312:	ff 75 f4             	push   -0xc(%ebp)
  105315:	e8 9a dd ff ff       	call   1030b4 <iread>
  10531a:	83 c4 10             	add    $0x10,%esp
    if(ip->type == T_DIR && omode != O_RDONLY){
  10531d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  105320:	0f b7 40 10          	movzwl 0x10(%eax),%eax
  105324:	66 83 f8 01          	cmp    $0x1,%ax
  105328:	75 24                	jne    10534e <sys_open+0xdb>
  10532a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  10532d:	85 c0                	test   %eax,%eax
  10532f:	74 1d                	je     10534e <sys_open+0xdb>
      iput(ip);
  105331:	83 ec 0c             	sub    $0xc,%esp
  105334:	ff 75 f4             	push   -0xc(%ebp)
  105337:	e8 9c db ff ff       	call   102ed8 <iput>
  10533c:	83 c4 10             	add    $0x10,%esp
      end_op();
  10533f:	e8 df f1 ff ff       	call   104523 <end_op>
      return -1;
  105344:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  105349:	e9 b2 00 00 00       	jmp    105400 <sys_open+0x18d>
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
  10534e:	e8 3c e7 ff ff       	call   103a8f <filealloc>
  105353:	89 45 f0             	mov    %eax,-0x10(%ebp)
  105356:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  10535a:	74 17                	je     105373 <sys_open+0x100>
  10535c:	83 ec 0c             	sub    $0xc,%esp
  10535f:	ff 75 f0             	push   -0x10(%ebp)
  105362:	e8 cc fb ff ff       	call   104f33 <fdalloc>
  105367:	83 c4 10             	add    $0x10,%esp
  10536a:	89 45 ec             	mov    %eax,-0x14(%ebp)
  10536d:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  105371:	79 2e                	jns    1053a1 <sys_open+0x12e>
    if(f)
  105373:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  105377:	74 0e                	je     105387 <sys_open+0x114>
      fileclose(f);
  105379:	83 ec 0c             	sub    $0xc,%esp
  10537c:	ff 75 f0             	push   -0x10(%ebp)
  10537f:	e8 79 e7 ff ff       	call   103afd <fileclose>
  105384:	83 c4 10             	add    $0x10,%esp
    iput(ip);
  105387:	83 ec 0c             	sub    $0xc,%esp
  10538a:	ff 75 f4             	push   -0xc(%ebp)
  10538d:	e8 46 db ff ff       	call   102ed8 <iput>
  105392:	83 c4 10             	add    $0x10,%esp
    end_op();
  105395:	e8 89 f1 ff ff       	call   104523 <end_op>
    return -1;
  10539a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  10539f:	eb 5f                	jmp    105400 <sys_open+0x18d>
  }
  end_op();
  1053a1:	e8 7d f1 ff ff       	call   104523 <end_op>

  f->type = FD_INODE;
  1053a6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1053a9:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  f->ip = ip;
  1053af:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1053b2:	8b 55 f4             	mov    -0xc(%ebp),%edx
  1053b5:	89 50 0c             	mov    %edx,0xc(%eax)
  f->off = 0;
  1053b8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1053bb:	c7 40 10 00 00 00 00 	movl   $0x0,0x10(%eax)
  f->readable = !(omode & O_WRONLY);
  1053c2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  1053c5:	83 e0 01             	and    $0x1,%eax
  1053c8:	85 c0                	test   %eax,%eax
  1053ca:	0f 94 c0             	sete   %al
  1053cd:	89 c2                	mov    %eax,%edx
  1053cf:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1053d2:	88 50 08             	mov    %dl,0x8(%eax)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
  1053d5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  1053d8:	83 e0 01             	and    $0x1,%eax
  1053db:	85 c0                	test   %eax,%eax
  1053dd:	75 0a                	jne    1053e9 <sys_open+0x176>
  1053df:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  1053e2:	83 e0 02             	and    $0x2,%eax
  1053e5:	85 c0                	test   %eax,%eax
  1053e7:	74 07                	je     1053f0 <sys_open+0x17d>
  1053e9:	b8 01 00 00 00       	mov    $0x1,%eax
  1053ee:	eb 05                	jmp    1053f5 <sys_open+0x182>
  1053f0:	b8 00 00 00 00       	mov    $0x0,%eax
  1053f5:	89 c2                	mov    %eax,%edx
  1053f7:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1053fa:	88 50 09             	mov    %dl,0x9(%eax)
  return fd;
  1053fd:	8b 45 ec             	mov    -0x14(%ebp),%eax
}
  105400:	c9                   	leave
  105401:	c3                   	ret

00105402 <sys_exec>:

int
sys_exec(void)
{
  105402:	55                   	push   %ebp
  105403:	89 e5                	mov    %esp,%ebp
  105405:	83 ec 18             	sub    $0x18,%esp
  char *path;
  if(argstr(0, &path) < 0){
  105408:	83 ec 08             	sub    $0x8,%esp
  10540b:	8d 45 f4             	lea    -0xc(%ebp),%eax
  10540e:	50                   	push   %eax
  10540f:	6a 00                	push   $0x0
  105411:	e8 ef f9 ff ff       	call   104e05 <argstr>
  105416:	83 c4 10             	add    $0x10,%esp
  105419:	85 c0                	test   %eax,%eax
  10541b:	79 07                	jns    105424 <sys_exec+0x22>
    return -1;
  10541d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  105422:	eb 0f                	jmp    105433 <sys_exec+0x31>
  }
  return exec(path);
  105424:	8b 45 f4             	mov    -0xc(%ebp),%eax
  105427:	83 ec 0c             	sub    $0xc,%esp
  10542a:	50                   	push   %eax
  10542b:	e8 5f 00 00 00       	call   10548f <exec>
  105430:	83 c4 10             	add    $0x10,%esp
}
  105433:	c9                   	leave
  105434:	c3                   	ret

00105435 <sys_set_sched_policy>:
#include "proc.h"

/* System Call Definitions */
int 
sys_set_sched_policy(void)
{
  105435:	55                   	push   %ebp
  105436:	89 e5                	mov    %esp,%ebp
  105438:	83 ec 18             	sub    $0x18,%esp
    int policy;

    if(argint(0, &policy) < 0)
  10543b:	83 ec 08             	sub    $0x8,%esp
  10543e:	8d 45 f4             	lea    -0xc(%ebp),%eax
  105441:	50                   	push   %eax
  105442:	6a 00                	push   $0x0
  105444:	e8 21 f9 ff ff       	call   104d6a <argint>
  105449:	83 c4 10             	add    $0x10,%esp
  10544c:	85 c0                	test   %eax,%eax
  10544e:	79 07                	jns    105457 <sys_set_sched_policy+0x22>
        return -22;
  105450:	b8 ea ff ff ff       	mov    $0xffffffea,%eax
  105455:	eb 26                	jmp    10547d <sys_set_sched_policy+0x48>
    if(policy != 0 && policy != 1)
  105457:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10545a:	85 c0                	test   %eax,%eax
  10545c:	74 0f                	je     10546d <sys_set_sched_policy+0x38>
  10545e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  105461:	83 f8 01             	cmp    $0x1,%eax
  105464:	74 07                	je     10546d <sys_set_sched_policy+0x38>
        return -22;
  105466:	b8 ea ff ff ff       	mov    $0xffffffea,%eax
  10546b:	eb 10                	jmp    10547d <sys_set_sched_policy+0x48>

    myproc()->policy = policy;
  10546d:	e8 30 bd ff ff       	call   1011a2 <myproc>
  105472:	8b 55 f4             	mov    -0xc(%ebp),%edx
  105475:	89 50 74             	mov    %edx,0x74(%eax)
    return 0;
  105478:	b8 00 00 00 00       	mov    $0x0,%eax
}
  10547d:	c9                   	leave
  10547e:	c3                   	ret

0010547f <sys_get_sched_policy>:

int 
sys_get_sched_policy(void)
{
  10547f:	55                   	push   %ebp
  105480:	89 e5                	mov    %esp,%ebp
  105482:	83 ec 08             	sub    $0x8,%esp
    return myproc()->policy;
  105485:	e8 18 bd ff ff       	call   1011a2 <myproc>
  10548a:	8b 40 74             	mov    0x74(%eax),%eax
}
  10548d:	c9                   	leave
  10548e:	c3                   	ret

0010548f <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path)
{
  10548f:	55                   	push   %ebp
  105490:	89 e5                	mov    %esp,%ebp
  105492:	53                   	push   %ebx
  105493:	83 ec 74             	sub    $0x74,%esp
  int i, off;
  uint sp;
  struct elfhdr elf;
  struct inode *ip;
  struct proc *curproc = myproc();
  105496:	e8 07 bd ff ff       	call   1011a2 <myproc>
  10549b:	89 45 ec             	mov    %eax,-0x14(%ebp)
  struct proghdr ph;

  begin_op();
  10549e:	e8 7a f0 ff ff       	call   10451d <begin_op>

  // cprintf("exec: path %s\n", path);
  if((ip = namei(path)) == 0){
  1054a3:	83 ec 0c             	sub    $0xc,%esp
  1054a6:	ff 75 08             	push   0x8(%ebp)
  1054a9:	e8 aa e5 ff ff       	call   103a58 <namei>
  1054ae:	83 c4 10             	add    $0x10,%esp
  1054b1:	89 45 e8             	mov    %eax,-0x18(%ebp)
  1054b4:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  1054b8:	75 0f                	jne    1054c9 <exec+0x3a>
    end_op();
  1054ba:	e8 64 f0 ff ff       	call   104523 <end_op>
    // cprintf("exec: fail\n");
    return -1;
  1054bf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  1054c4:	e9 86 01 00 00       	jmp    10564f <exec+0x1c0>
  }
  iread(ip);
  1054c9:	83 ec 0c             	sub    $0xc,%esp
  1054cc:	ff 75 e8             	push   -0x18(%ebp)
  1054cf:	e8 e0 db ff ff       	call   1030b4 <iread>
  1054d4:	83 c4 10             	add    $0x10,%esp

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
  1054d7:	6a 34                	push   $0x34
  1054d9:	6a 00                	push   $0x0
  1054db:	8d 45 b0             	lea    -0x50(%ebp),%eax
  1054de:	50                   	push   %eax
  1054df:	ff 75 e8             	push   -0x18(%ebp)
  1054e2:	e8 52 df ff ff       	call   103439 <readi>
  1054e7:	83 c4 10             	add    $0x10,%esp
  1054ea:	83 f8 34             	cmp    $0x34,%eax
  1054ed:	0f 85 2b 01 00 00    	jne    10561e <exec+0x18f>
    goto bad;
  if(elf.magic != ELF_MAGIC)
  1054f3:	8b 45 b0             	mov    -0x50(%ebp),%eax
  1054f6:	3d 7f 45 4c 46       	cmp    $0x464c457f,%eax
  1054fb:	0f 85 20 01 00 00    	jne    105621 <exec+0x192>
    goto bad;

  // Fill with junk
  memset(curproc->offset, 1, curproc->sz);
  105501:	8b 45 ec             	mov    -0x14(%ebp),%eax
  105504:	8b 10                	mov    (%eax),%edx
  105506:	8b 45 ec             	mov    -0x14(%ebp),%eax
  105509:	8b 40 04             	mov    0x4(%eax),%eax
  10550c:	83 ec 04             	sub    $0x4,%esp
  10550f:	52                   	push   %edx
  105510:	6a 01                	push   $0x1
  105512:	50                   	push   %eax
  105513:	e8 ea b9 ff ff       	call   100f02 <memset>
  105518:	83 c4 10             	add    $0x10,%esp

  // Load program into memory.
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
  10551b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  105522:	8b 45 cc             	mov    -0x34(%ebp),%eax
  105525:	89 45 f0             	mov    %eax,-0x10(%ebp)
  105528:	e9 93 00 00 00       	jmp    1055c0 <exec+0x131>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
  10552d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  105530:	6a 20                	push   $0x20
  105532:	50                   	push   %eax
  105533:	8d 45 90             	lea    -0x70(%ebp),%eax
  105536:	50                   	push   %eax
  105537:	ff 75 e8             	push   -0x18(%ebp)
  10553a:	e8 fa de ff ff       	call   103439 <readi>
  10553f:	83 c4 10             	add    $0x10,%esp
  105542:	83 f8 20             	cmp    $0x20,%eax
  105545:	0f 85 d9 00 00 00    	jne    105624 <exec+0x195>
      goto bad;
    if(ph.type != ELF_PROG_LOAD)
  10554b:	8b 45 90             	mov    -0x70(%ebp),%eax
  10554e:	83 f8 01             	cmp    $0x1,%eax
  105551:	75 5f                	jne    1055b2 <exec+0x123>
      continue;
    if(ph.memsz < ph.filesz)
  105553:	8b 55 a4             	mov    -0x5c(%ebp),%edx
  105556:	8b 45 a0             	mov    -0x60(%ebp),%eax
  105559:	39 c2                	cmp    %eax,%edx
  10555b:	0f 82 c6 00 00 00    	jb     105627 <exec+0x198>
      goto bad;
    if(ph.vaddr + ph.memsz < ph.vaddr)
  105561:	8b 55 98             	mov    -0x68(%ebp),%edx
  105564:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  105567:	01 c2                	add    %eax,%edx
  105569:	8b 45 98             	mov    -0x68(%ebp),%eax
  10556c:	39 c2                	cmp    %eax,%edx
  10556e:	0f 82 b6 00 00 00    	jb     10562a <exec+0x19b>
      goto bad;
    if(ph.vaddr % PGSIZE != 0)
  105574:	8b 45 98             	mov    -0x68(%ebp),%eax
  105577:	25 ff ff 0f 00       	and    $0xfffff,%eax
  10557c:	85 c0                	test   %eax,%eax
  10557e:	0f 85 a9 00 00 00    	jne    10562d <exec+0x19e>
      goto bad;
    if(readi(ip, (char*)(curproc->offset + ph.vaddr), ph.off, ph.filesz) != ph.filesz)
  105584:	8b 55 a0             	mov    -0x60(%ebp),%edx
  105587:	8b 45 94             	mov    -0x6c(%ebp),%eax
  10558a:	8b 4d ec             	mov    -0x14(%ebp),%ecx
  10558d:	8b 59 04             	mov    0x4(%ecx),%ebx
  105590:	8b 4d 98             	mov    -0x68(%ebp),%ecx
  105593:	01 d9                	add    %ebx,%ecx
  105595:	52                   	push   %edx
  105596:	50                   	push   %eax
  105597:	51                   	push   %ecx
  105598:	ff 75 e8             	push   -0x18(%ebp)
  10559b:	e8 99 de ff ff       	call   103439 <readi>
  1055a0:	83 c4 10             	add    $0x10,%esp
  1055a3:	89 c2                	mov    %eax,%edx
  1055a5:	8b 45 a0             	mov    -0x60(%ebp),%eax
  1055a8:	39 c2                	cmp    %eax,%edx
  1055aa:	0f 85 80 00 00 00    	jne    105630 <exec+0x1a1>
  1055b0:	eb 01                	jmp    1055b3 <exec+0x124>
      continue;
  1055b2:	90                   	nop
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
  1055b3:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  1055b7:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1055ba:	83 c0 20             	add    $0x20,%eax
  1055bd:	89 45 f0             	mov    %eax,-0x10(%ebp)
  1055c0:	0f b7 45 dc          	movzwl -0x24(%ebp),%eax
  1055c4:	0f b7 c0             	movzwl %ax,%eax
  1055c7:	39 45 f4             	cmp    %eax,-0xc(%ebp)
  1055ca:	0f 8c 5d ff ff ff    	jl     10552d <exec+0x9e>
      goto bad;
  }
  iput(ip);
  1055d0:	83 ec 0c             	sub    $0xc,%esp
  1055d3:	ff 75 e8             	push   -0x18(%ebp)
  1055d6:	e8 fd d8 ff ff       	call   102ed8 <iput>
  1055db:	83 c4 10             	add    $0x10,%esp
  end_op();
  1055de:	e8 40 ef ff ff       	call   104523 <end_op>
  ip = 0;
  1055e3:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)

  sp = curproc->sz;
  1055ea:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1055ed:	8b 00                	mov    (%eax),%eax
  1055ef:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  *(uint*)sp = 0xffffffff;
  1055f2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  1055f5:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)
  sp -= 4;
  1055fb:	83 6d e4 04          	subl   $0x4,-0x1c(%ebp)

  curproc->tf->eip = elf.entry;  // main
  1055ff:	8b 45 ec             	mov    -0x14(%ebp),%eax
  105602:	8b 40 18             	mov    0x18(%eax),%eax
  105605:	8b 55 c8             	mov    -0x38(%ebp),%edx
  105608:	89 50 38             	mov    %edx,0x38(%eax)
  curproc->tf->esp = sp;
  10560b:	8b 45 ec             	mov    -0x14(%ebp),%eax
  10560e:	8b 40 18             	mov    0x18(%eax),%eax
  105611:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  105614:	89 50 44             	mov    %edx,0x44(%eax)
  return 0;
  105617:	b8 00 00 00 00       	mov    $0x0,%eax
  10561c:	eb 31                	jmp    10564f <exec+0x1c0>
    goto bad;
  10561e:	90                   	nop
  10561f:	eb 10                	jmp    105631 <exec+0x1a2>
    goto bad;
  105621:	90                   	nop
  105622:	eb 0d                	jmp    105631 <exec+0x1a2>
      goto bad;
  105624:	90                   	nop
  105625:	eb 0a                	jmp    105631 <exec+0x1a2>
      goto bad;
  105627:	90                   	nop
  105628:	eb 07                	jmp    105631 <exec+0x1a2>
      goto bad;
  10562a:	90                   	nop
  10562b:	eb 04                	jmp    105631 <exec+0x1a2>
      goto bad;
  10562d:	90                   	nop
  10562e:	eb 01                	jmp    105631 <exec+0x1a2>
      goto bad;
  105630:	90                   	nop

 bad:
  if(ip){
  105631:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  105635:	74 13                	je     10564a <exec+0x1bb>
    iput(ip);
  105637:	83 ec 0c             	sub    $0xc,%esp
  10563a:	ff 75 e8             	push   -0x18(%ebp)
  10563d:	e8 96 d8 ff ff       	call   102ed8 <iput>
  105642:	83 c4 10             	add    $0x10,%esp
    end_op();
  105645:	e8 d9 ee ff ff       	call   104523 <end_op>
  }
  return -1;
  10564a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  10564f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  105652:	c9                   	leave
  105653:	c3                   	ret
