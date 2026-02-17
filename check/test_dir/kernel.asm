
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
  10000c:	bc 40 05 11 00       	mov    $0x110540,%esp

  # Jump to main(), and switch to executing at
  # high addresses. The indirect call is needed because
  # the assembler produces a PC-relative instruction
  # for a direct jump.
  mov $main, %eax
  100011:	b8 5a 08 10 00       	mov    $0x10085a,%eax
  jmp *%eax
  100016:	ff e0                	jmp    *%eax

00100018 <outw>:
    x = xx;

  i = 0;
  do{
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  100018:	55                   	push   %ebp
  100019:	89 e5                	mov    %esp,%ebp
  10001b:	83 ec 08             	sub    $0x8,%esp
  10001e:	8b 55 08             	mov    0x8(%ebp),%edx
  100021:	8b 45 0c             	mov    0xc(%ebp),%eax
  100024:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
  100028:	66 89 45 f8          	mov    %ax,-0x8(%ebp)

  10002c:	0f b7 45 f8          	movzwl -0x8(%ebp),%eax
  100030:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
  100034:	66 ef                	out    %ax,(%dx)
  if(sign)
  100036:	90                   	nop
  100037:	c9                   	leave
  100038:	c3                   	ret

00100039 <cli>:
      consputc(c);
      break;
    }
  }
}

  100039:	55                   	push   %ebp
  10003a:	89 e5                	mov    %esp,%ebp
void
  10003c:	fa                   	cli
halt(void)
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
  10008d:	0f b6 91 00 50 10 00 	movzbl 0x105000(%ecx),%edx
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
  1001e1:	c7 45 ec 7c 41 10 00 	movl   $0x10417c,-0x14(%ebp)
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
  100274:	68 83 41 10 00       	push   $0x104183
  100279:	e8 6e fe ff ff       	call   1000ec <cprintf>
  10027e:	83 c4 10             	add    $0x10,%esp
  outw(0x602, 0x2000);
  100281:	83 ec 08             	sub    $0x8,%esp
  100284:	68 00 20 00 00       	push   $0x2000
  100289:	68 02 06 00 00       	push   $0x602
  10028e:	e8 85 fd ff ff       	call   100018 <outw>
  100293:	83 c4 10             	add    $0x10,%esp
  // For older versions of QEMU, 
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
}

void
panic(char *s)
{
  1002ae:	55                   	push   %ebp
  1002af:	89 e5                	mov    %esp,%ebp
  1002b1:	83 ec 38             	sub    $0x38,%esp
  int i;
  uint pcs[10];

  cli();
  1002b4:	e8 80 fd ff ff       	call   100039 <cli>
  cprintf("lapicid %d: panic: ", lapicid());
  1002b9:	e8 62 04 00 00       	call   100720 <lapicid>
  1002be:	83 ec 08             	sub    $0x8,%esp
  1002c1:	50                   	push   %eax
  1002c2:	68 90 41 10 00       	push   $0x104190
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
  1002e1:	68 a4 41 10 00       	push   $0x1041a4
  1002e6:	e8 01 fe ff ff       	call   1000ec <cprintf>
  1002eb:	83 c4 10             	add    $0x10,%esp
  getcallerpcs(&s, pcs);
  1002ee:	83 ec 08             	sub    $0x8,%esp
  1002f1:	8d 45 cc             	lea    -0x34(%ebp),%eax
  1002f4:	50                   	push   %eax
  1002f5:	8d 45 08             	lea    0x8(%ebp),%eax
  1002f8:	50                   	push   %eax
  1002f9:	e8 98 0e 00 00       	call   101196 <getcallerpcs>
  1002fe:	83 c4 10             	add    $0x10,%esp
  for(i=0; i<10; i++)
  100301:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  100308:	eb 1c                	jmp    100326 <panic+0x78>
    cprintf(" %p", pcs[i]);
  10030a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10030d:	8b 44 85 cc          	mov    -0x34(%ebp,%eax,4),%eax
  100311:	83 ec 08             	sub    $0x8,%esp
  100314:	50                   	push   %eax
  100315:	68 a6 41 10 00       	push   $0x1041a6
  10031a:	e8 cd fd ff ff       	call   1000ec <cprintf>
  10031f:	83 c4 10             	add    $0x10,%esp
  for(i=0; i<10; i++)
  100322:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  100326:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
  10032a:	7e de                	jle    10030a <panic+0x5c>
  panicked = 1; // freeze other CPU
  10032c:	c7 05 ac 54 10 00 01 	movl   $0x1,0x1054ac
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
  10034f:	e8 45 0a 00 00       	call   100d99 <uartputc>
  100354:	83 c4 10             	add    $0x10,%esp
  100357:	83 ec 0c             	sub    $0xc,%esp
  10035a:	6a 20                	push   $0x20
  10035c:	e8 38 0a 00 00       	call   100d99 <uartputc>
  100361:	83 c4 10             	add    $0x10,%esp
  100364:	83 ec 0c             	sub    $0xc,%esp
  100367:	6a 08                	push   $0x8
  100369:	e8 2b 0a 00 00       	call   100d99 <uartputc>
  10036e:	83 c4 10             	add    $0x10,%esp
  } else
    uartputc(c);
}
  100371:	eb 0e                	jmp    100381 <consputc+0x46>
    uartputc(c);
  100373:	83 ec 0c             	sub    $0xc,%esp
  100376:	ff 75 08             	push   0x8(%ebp)
  100379:	e8 1b 0a 00 00       	call   100d99 <uartputc>
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
  int c;

  while((c = getc()) >= 0){
  10038a:	e9 26 01 00 00       	jmp    1004b5 <consoleintr+0x131>
    switch(c){
  10038f:	83 7d f4 7f          	cmpl   $0x7f,-0xc(%ebp)
  100393:	74 67                	je     1003fc <consoleintr+0x78>
  100395:	83 7d f4 7f          	cmpl   $0x7f,-0xc(%ebp)
  100399:	0f 8f 92 00 00 00    	jg     100431 <consoleintr+0xad>
  10039f:	83 7d f4 08          	cmpl   $0x8,-0xc(%ebp)
  1003a3:	74 57                	je     1003fc <consoleintr+0x78>
  1003a5:	83 7d f4 15          	cmpl   $0x15,-0xc(%ebp)
  1003a9:	0f 85 82 00 00 00    	jne    100431 <consoleintr+0xad>
    case C('U'):  // Kill line.
      while(input.e != input.w &&
  1003af:	eb 1d                	jmp    1003ce <consoleintr+0x4a>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
        input.e--;
  1003b1:	a1 a8 54 10 00       	mov    0x1054a8,%eax
  1003b6:	83 e8 01             	sub    $0x1,%eax
  1003b9:	a3 a8 54 10 00       	mov    %eax,0x1054a8
        consputc(BACKSPACE);
  1003be:	83 ec 0c             	sub    $0xc,%esp
  1003c1:	68 00 01 00 00       	push   $0x100
  1003c6:	e8 70 ff ff ff       	call   10033b <consputc>
  1003cb:	83 c4 10             	add    $0x10,%esp
      while(input.e != input.w &&
  1003ce:	8b 15 a8 54 10 00    	mov    0x1054a8,%edx
  1003d4:	a1 a4 54 10 00       	mov    0x1054a4,%eax
  1003d9:	39 c2                	cmp    %eax,%edx
  1003db:	0f 84 cd 00 00 00    	je     1004ae <consoleintr+0x12a>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
  1003e1:	a1 a8 54 10 00       	mov    0x1054a8,%eax
  1003e6:	83 e8 01             	sub    $0x1,%eax
  1003e9:	83 e0 7f             	and    $0x7f,%eax
  1003ec:	0f b6 80 20 54 10 00 	movzbl 0x105420(%eax),%eax
      while(input.e != input.w &&
  1003f3:	3c 0a                	cmp    $0xa,%al
  1003f5:	75 ba                	jne    1003b1 <consoleintr+0x2d>
      }
      break;
  1003f7:	e9 b2 00 00 00       	jmp    1004ae <consoleintr+0x12a>
    case C('H'): case '\x7f':  // Backspace
      if(input.e != input.w){
  1003fc:	8b 15 a8 54 10 00    	mov    0x1054a8,%edx
  100402:	a1 a4 54 10 00       	mov    0x1054a4,%eax
  100407:	39 c2                	cmp    %eax,%edx
  100409:	0f 84 a2 00 00 00    	je     1004b1 <consoleintr+0x12d>
        input.e--;
  10040f:	a1 a8 54 10 00       	mov    0x1054a8,%eax
  100414:	83 e8 01             	sub    $0x1,%eax
  100417:	a3 a8 54 10 00       	mov    %eax,0x1054a8
        consputc(BACKSPACE);
  10041c:	83 ec 0c             	sub    $0xc,%esp
  10041f:	68 00 01 00 00       	push   $0x100
  100424:	e8 12 ff ff ff       	call   10033b <consputc>
  100429:	83 c4 10             	add    $0x10,%esp
      }
      break;
  10042c:	e9 80 00 00 00       	jmp    1004b1 <consoleintr+0x12d>
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
  100431:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  100435:	74 7d                	je     1004b4 <consoleintr+0x130>
  100437:	8b 15 a8 54 10 00    	mov    0x1054a8,%edx
  10043d:	a1 a0 54 10 00       	mov    0x1054a0,%eax
  100442:	29 c2                	sub    %eax,%edx
  100444:	83 fa 7f             	cmp    $0x7f,%edx
  100447:	77 6b                	ja     1004b4 <consoleintr+0x130>
        c = (c == '\r') ? '\n' : c;
  100449:	83 7d f4 0d          	cmpl   $0xd,-0xc(%ebp)
  10044d:	74 05                	je     100454 <consoleintr+0xd0>
  10044f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100452:	eb 05                	jmp    100459 <consoleintr+0xd5>
  100454:	b8 0a 00 00 00       	mov    $0xa,%eax
  100459:	89 45 f4             	mov    %eax,-0xc(%ebp)
        input.buf[input.e++ % INPUT_BUF] = c;
  10045c:	a1 a8 54 10 00       	mov    0x1054a8,%eax
  100461:	8d 50 01             	lea    0x1(%eax),%edx
  100464:	89 15 a8 54 10 00    	mov    %edx,0x1054a8
  10046a:	83 e0 7f             	and    $0x7f,%eax
  10046d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100470:	88 90 20 54 10 00    	mov    %dl,0x105420(%eax)
        consputc(c);
  100476:	83 ec 0c             	sub    $0xc,%esp
  100479:	ff 75 f4             	push   -0xc(%ebp)
  10047c:	e8 ba fe ff ff       	call   10033b <consputc>
  100481:	83 c4 10             	add    $0x10,%esp
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
  100484:	83 7d f4 0a          	cmpl   $0xa,-0xc(%ebp)
  100488:	74 18                	je     1004a2 <consoleintr+0x11e>
  10048a:	83 7d f4 04          	cmpl   $0x4,-0xc(%ebp)
  10048e:	74 12                	je     1004a2 <consoleintr+0x11e>
  100490:	8b 15 a8 54 10 00    	mov    0x1054a8,%edx
  100496:	a1 a0 54 10 00       	mov    0x1054a0,%eax
  10049b:	83 e8 80             	sub    $0xffffff80,%eax
  10049e:	39 c2                	cmp    %eax,%edx
  1004a0:	75 12                	jne    1004b4 <consoleintr+0x130>
          input.w = input.e;
  1004a2:	a1 a8 54 10 00       	mov    0x1054a8,%eax
  1004a7:	a3 a4 54 10 00       	mov    %eax,0x1054a4
        }
      }
      break;
  1004ac:	eb 06                	jmp    1004b4 <consoleintr+0x130>
      break;
  1004ae:	90                   	nop
  1004af:	eb 04                	jmp    1004b5 <consoleintr+0x131>
      break;
  1004b1:	90                   	nop
  1004b2:	eb 01                	jmp    1004b5 <consoleintr+0x131>
      break;
  1004b4:	90                   	nop
  while((c = getc()) >= 0){
  1004b5:	8b 45 08             	mov    0x8(%ebp),%eax
  1004b8:	ff d0                	call   *%eax
  1004ba:	89 45 f4             	mov    %eax,-0xc(%ebp)
  1004bd:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  1004c1:	0f 89 c8 fe ff ff    	jns    10038f <consoleintr+0xb>
    }
  }
  1004c7:	90                   	nop
  1004c8:	90                   	nop
  1004c9:	c9                   	leave
  1004ca:	c3                   	ret

001004cb <ioapicread>:
  uint data;
};

static uint
ioapicread(int reg)
{
  1004cb:	55                   	push   %ebp
  1004cc:	89 e5                	mov    %esp,%ebp
  ioapic->reg = reg;
  1004ce:	a1 b0 54 10 00       	mov    0x1054b0,%eax
  1004d3:	8b 55 08             	mov    0x8(%ebp),%edx
  1004d6:	89 10                	mov    %edx,(%eax)
  return ioapic->data;
  1004d8:	a1 b0 54 10 00       	mov    0x1054b0,%eax
  1004dd:	8b 40 10             	mov    0x10(%eax),%eax
}
  1004e0:	5d                   	pop    %ebp
  1004e1:	c3                   	ret

001004e2 <ioapicwrite>:

static void
ioapicwrite(int reg, uint data)
{
  1004e2:	55                   	push   %ebp
  1004e3:	89 e5                	mov    %esp,%ebp
  ioapic->reg = reg;
  1004e5:	a1 b0 54 10 00       	mov    0x1054b0,%eax
  1004ea:	8b 55 08             	mov    0x8(%ebp),%edx
  1004ed:	89 10                	mov    %edx,(%eax)
  ioapic->data = data;
  1004ef:	a1 b0 54 10 00       	mov    0x1054b0,%eax
  1004f4:	8b 55 0c             	mov    0xc(%ebp),%edx
  1004f7:	89 50 10             	mov    %edx,0x10(%eax)
}
  1004fa:	90                   	nop
  1004fb:	5d                   	pop    %ebp
  1004fc:	c3                   	ret

001004fd <ioapicinit>:

void
ioapicinit(void)
{
  1004fd:	55                   	push   %ebp
  1004fe:	89 e5                	mov    %esp,%ebp
  100500:	83 ec 18             	sub    $0x18,%esp
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
  100503:	c7 05 b0 54 10 00 00 	movl   $0xfec00000,0x1054b0
  10050a:	00 c0 fe 
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  10050d:	6a 01                	push   $0x1
  10050f:	e8 b7 ff ff ff       	call   1004cb <ioapicread>
  100514:	83 c4 04             	add    $0x4,%esp
  100517:	c1 e8 10             	shr    $0x10,%eax
  10051a:	25 ff 00 00 00       	and    $0xff,%eax
  10051f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  id = ioapicread(REG_ID) >> 24;
  100522:	6a 00                	push   $0x0
  100524:	e8 a2 ff ff ff       	call   1004cb <ioapicread>
  100529:	83 c4 04             	add    $0x4,%esp
  10052c:	c1 e8 18             	shr    $0x18,%eax
  10052f:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if(id != ioapicid)
  100532:	0f b6 05 c4 54 10 00 	movzbl 0x1054c4,%eax
  100539:	0f b6 c0             	movzbl %al,%eax
  10053c:	39 45 ec             	cmp    %eax,-0x14(%ebp)
  10053f:	74 10                	je     100551 <ioapicinit+0x54>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
  100541:	83 ec 0c             	sub    $0xc,%esp
  100544:	68 ac 41 10 00       	push   $0x1041ac
  100549:	e8 9e fb ff ff       	call   1000ec <cprintf>
  10054e:	83 c4 10             	add    $0x10,%esp

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
  100551:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  100558:	eb 3f                	jmp    100599 <ioapicinit+0x9c>
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
  10055a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10055d:	83 c0 20             	add    $0x20,%eax
  100560:	0d 00 00 01 00       	or     $0x10000,%eax
  100565:	89 c2                	mov    %eax,%edx
  100567:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10056a:	83 c0 08             	add    $0x8,%eax
  10056d:	01 c0                	add    %eax,%eax
  10056f:	83 ec 08             	sub    $0x8,%esp
  100572:	52                   	push   %edx
  100573:	50                   	push   %eax
  100574:	e8 69 ff ff ff       	call   1004e2 <ioapicwrite>
  100579:	83 c4 10             	add    $0x10,%esp
    ioapicwrite(REG_TABLE+2*i+1, 0);
  10057c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10057f:	83 c0 08             	add    $0x8,%eax
  100582:	01 c0                	add    %eax,%eax
  100584:	83 c0 01             	add    $0x1,%eax
  100587:	83 ec 08             	sub    $0x8,%esp
  10058a:	6a 00                	push   $0x0
  10058c:	50                   	push   %eax
  10058d:	e8 50 ff ff ff       	call   1004e2 <ioapicwrite>
  100592:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i <= maxintr; i++){
  100595:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  100599:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10059c:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  10059f:	7e b9                	jle    10055a <ioapicinit+0x5d>
  }
}
  1005a1:	90                   	nop
  1005a2:	90                   	nop
  1005a3:	c9                   	leave
  1005a4:	c3                   	ret

001005a5 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
  1005a5:	55                   	push   %ebp
  1005a6:	89 e5                	mov    %esp,%ebp
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
  1005a8:	8b 45 08             	mov    0x8(%ebp),%eax
  1005ab:	83 c0 20             	add    $0x20,%eax
  1005ae:	89 c2                	mov    %eax,%edx
  1005b0:	8b 45 08             	mov    0x8(%ebp),%eax
  1005b3:	83 c0 08             	add    $0x8,%eax
  1005b6:	01 c0                	add    %eax,%eax
  1005b8:	52                   	push   %edx
  1005b9:	50                   	push   %eax
  1005ba:	e8 23 ff ff ff       	call   1004e2 <ioapicwrite>
  1005bf:	83 c4 08             	add    $0x8,%esp
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
  1005c2:	8b 45 0c             	mov    0xc(%ebp),%eax
  1005c5:	c1 e0 18             	shl    $0x18,%eax
  1005c8:	89 c2                	mov    %eax,%edx
  1005ca:	8b 45 08             	mov    0x8(%ebp),%eax
  1005cd:	83 c0 08             	add    $0x8,%eax
  1005d0:	01 c0                	add    %eax,%eax
  1005d2:	83 c0 01             	add    $0x1,%eax
  1005d5:	52                   	push   %edx
  1005d6:	50                   	push   %eax
  1005d7:	e8 06 ff ff ff       	call   1004e2 <ioapicwrite>
  1005dc:	83 c4 08             	add    $0x8,%esp
}
  1005df:	90                   	nop
  1005e0:	c9                   	leave
  1005e1:	c3                   	ret

001005e2 <lapicw>:

volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  1005e2:	55                   	push   %ebp
  1005e3:	89 e5                	mov    %esp,%ebp
  lapic[index] = value;
  1005e5:	a1 b4 54 10 00       	mov    0x1054b4,%eax
  1005ea:	8b 55 08             	mov    0x8(%ebp),%edx
  1005ed:	c1 e2 02             	shl    $0x2,%edx
  1005f0:	01 c2                	add    %eax,%edx
  1005f2:	8b 45 0c             	mov    0xc(%ebp),%eax
  1005f5:	89 02                	mov    %eax,(%edx)
  lapic[ID];  // wait for write to finish, by reading
  1005f7:	a1 b4 54 10 00       	mov    0x1054b4,%eax
  1005fc:	83 c0 20             	add    $0x20,%eax
  1005ff:	8b 00                	mov    (%eax),%eax
}
  100601:	90                   	nop
  100602:	5d                   	pop    %ebp
  100603:	c3                   	ret

00100604 <lapicinit>:

void
lapicinit(void)
{
  100604:	55                   	push   %ebp
  100605:	89 e5                	mov    %esp,%ebp
  if(!lapic)
  100607:	a1 b4 54 10 00       	mov    0x1054b4,%eax
  10060c:	85 c0                	test   %eax,%eax
  10060e:	0f 84 09 01 00 00    	je     10071d <lapicinit+0x119>
    return;

  // Enable local APIC; set spurious interrupt vector.
  lapicw(SVR, ENABLE | (T_IRQ0 + IRQ_SPURIOUS));
  100614:	68 3f 01 00 00       	push   $0x13f
  100619:	6a 3c                	push   $0x3c
  10061b:	e8 c2 ff ff ff       	call   1005e2 <lapicw>
  100620:	83 c4 08             	add    $0x8,%esp

  // The timer repeatedly counts down at bus frequency
  // from lapic[TICR] and then issues an interrupt.
  // If xv6 cared more about precise timekeeping,
  // TICR would be calibrated using an external time source.
  lapicw(TDCR, X1);
  100623:	6a 0b                	push   $0xb
  100625:	68 f8 00 00 00       	push   $0xf8
  10062a:	e8 b3 ff ff ff       	call   1005e2 <lapicw>
  10062f:	83 c4 08             	add    $0x8,%esp
  lapicw(TIMER, PERIODIC | (T_IRQ0 + IRQ_TIMER));
  100632:	68 20 00 02 00       	push   $0x20020
  100637:	68 c8 00 00 00       	push   $0xc8
  10063c:	e8 a1 ff ff ff       	call   1005e2 <lapicw>
  100641:	83 c4 08             	add    $0x8,%esp
  lapicw(TICR, 10000000);
  100644:	68 80 96 98 00       	push   $0x989680
  100649:	68 e0 00 00 00       	push   $0xe0
  10064e:	e8 8f ff ff ff       	call   1005e2 <lapicw>
  100653:	83 c4 08             	add    $0x8,%esp

  // Disable logical interrupt lines.
  lapicw(LINT0, MASKED);
  100656:	68 00 00 01 00       	push   $0x10000
  10065b:	68 d4 00 00 00       	push   $0xd4
  100660:	e8 7d ff ff ff       	call   1005e2 <lapicw>
  100665:	83 c4 08             	add    $0x8,%esp
  lapicw(LINT1, MASKED);
  100668:	68 00 00 01 00       	push   $0x10000
  10066d:	68 d8 00 00 00       	push   $0xd8
  100672:	e8 6b ff ff ff       	call   1005e2 <lapicw>
  100677:	83 c4 08             	add    $0x8,%esp

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
  10067a:	a1 b4 54 10 00       	mov    0x1054b4,%eax
  10067f:	83 c0 30             	add    $0x30,%eax
  100682:	8b 00                	mov    (%eax),%eax
  100684:	25 00 00 fc 00       	and    $0xfc0000,%eax
  100689:	85 c0                	test   %eax,%eax
  10068b:	74 12                	je     10069f <lapicinit+0x9b>
    lapicw(PCINT, MASKED);
  10068d:	68 00 00 01 00       	push   $0x10000
  100692:	68 d0 00 00 00       	push   $0xd0
  100697:	e8 46 ff ff ff       	call   1005e2 <lapicw>
  10069c:	83 c4 08             	add    $0x8,%esp

  // Map error interrupt to IRQ_ERROR.
  lapicw(ERROR, T_IRQ0 + IRQ_ERROR);
  10069f:	6a 33                	push   $0x33
  1006a1:	68 dc 00 00 00       	push   $0xdc
  1006a6:	e8 37 ff ff ff       	call   1005e2 <lapicw>
  1006ab:	83 c4 08             	add    $0x8,%esp

  // Clear error status register (requires back-to-back writes).
  lapicw(ESR, 0);
  1006ae:	6a 00                	push   $0x0
  1006b0:	68 a0 00 00 00       	push   $0xa0
  1006b5:	e8 28 ff ff ff       	call   1005e2 <lapicw>
  1006ba:	83 c4 08             	add    $0x8,%esp
  lapicw(ESR, 0);
  1006bd:	6a 00                	push   $0x0
  1006bf:	68 a0 00 00 00       	push   $0xa0
  1006c4:	e8 19 ff ff ff       	call   1005e2 <lapicw>
  1006c9:	83 c4 08             	add    $0x8,%esp

  // Ack any outstanding interrupts.
  lapicw(EOI, 0);
  1006cc:	6a 00                	push   $0x0
  1006ce:	6a 2c                	push   $0x2c
  1006d0:	e8 0d ff ff ff       	call   1005e2 <lapicw>
  1006d5:	83 c4 08             	add    $0x8,%esp

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  1006d8:	6a 00                	push   $0x0
  1006da:	68 c4 00 00 00       	push   $0xc4
  1006df:	e8 fe fe ff ff       	call   1005e2 <lapicw>
  1006e4:	83 c4 08             	add    $0x8,%esp
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  1006e7:	68 00 85 08 00       	push   $0x88500
  1006ec:	68 c0 00 00 00       	push   $0xc0
  1006f1:	e8 ec fe ff ff       	call   1005e2 <lapicw>
  1006f6:	83 c4 08             	add    $0x8,%esp
  while(lapic[ICRLO] & DELIVS)
  1006f9:	90                   	nop
  1006fa:	a1 b4 54 10 00       	mov    0x1054b4,%eax
  1006ff:	05 00 03 00 00       	add    $0x300,%eax
  100704:	8b 00                	mov    (%eax),%eax
  100706:	25 00 10 00 00       	and    $0x1000,%eax
  10070b:	85 c0                	test   %eax,%eax
  10070d:	75 eb                	jne    1006fa <lapicinit+0xf6>
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
  10070f:	6a 00                	push   $0x0
  100711:	6a 20                	push   $0x20
  100713:	e8 ca fe ff ff       	call   1005e2 <lapicw>
  100718:	83 c4 08             	add    $0x8,%esp
  10071b:	eb 01                	jmp    10071e <lapicinit+0x11a>
    return;
  10071d:	90                   	nop
}
  10071e:	c9                   	leave
  10071f:	c3                   	ret

00100720 <lapicid>:

int
lapicid(void)
{
  100720:	55                   	push   %ebp
  100721:	89 e5                	mov    %esp,%ebp
  if (!lapic)
  100723:	a1 b4 54 10 00       	mov    0x1054b4,%eax
  100728:	85 c0                	test   %eax,%eax
  10072a:	75 07                	jne    100733 <lapicid+0x13>
    return 0;
  10072c:	b8 00 00 00 00       	mov    $0x0,%eax
  100731:	eb 0d                	jmp    100740 <lapicid+0x20>
  return lapic[ID] >> 24;
  100733:	a1 b4 54 10 00       	mov    0x1054b4,%eax
  100738:	83 c0 20             	add    $0x20,%eax
  10073b:	8b 00                	mov    (%eax),%eax
  10073d:	c1 e8 18             	shr    $0x18,%eax
}
  100740:	5d                   	pop    %ebp
  100741:	c3                   	ret

00100742 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
  100742:	55                   	push   %ebp
  100743:	89 e5                	mov    %esp,%ebp
  if(lapic)
  100745:	a1 b4 54 10 00       	mov    0x1054b4,%eax
  10074a:	85 c0                	test   %eax,%eax
  10074c:	74 0c                	je     10075a <lapiceoi+0x18>
    lapicw(EOI, 0);
  10074e:	6a 00                	push   $0x0
  100750:	6a 2c                	push   $0x2c
  100752:	e8 8b fe ff ff       	call   1005e2 <lapicw>
  100757:	83 c4 08             	add    $0x8,%esp
}
  10075a:	90                   	nop
  10075b:	c9                   	leave
  10075c:	c3                   	ret

0010075d <microdelay>:

// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
  10075d:	55                   	push   %ebp
  10075e:	89 e5                	mov    %esp,%ebp
  100760:	90                   	nop
  100761:	5d                   	pop    %ebp
  100762:	c3                   	ret

00100763 <sti>:
  100763:	55                   	push   %ebp
  100764:	89 e5                	mov    %esp,%ebp
  100766:	fb                   	sti
  100767:	90                   	nop
  100768:	5d                   	pop    %ebp
  100769:	c3                   	ret

0010076a <wfi>:
  10076a:	55                   	push   %ebp
  10076b:	89 e5                	mov    %esp,%ebp
  10076d:	f4                   	hlt
  10076e:	90                   	nop
  10076f:	5d                   	pop    %ebp
  100770:	c3                   	ret

00100771 <log_test>:
log_test(void) {
  100771:	55                   	push   %ebp
  100772:	89 e5                	mov    %esp,%ebp
  100774:	81 ec 18 02 00 00    	sub    $0x218,%esp
  if((gtxt=open("/hello.txt", O_RDONLY)) == 0) {
  10077a:	83 ec 08             	sub    $0x8,%esp
  10077d:	6a 00                	push   $0x0
  10077f:	68 de 41 10 00       	push   $0x1041de
  100784:	e8 08 33 00 00       	call   103a91 <open>
  100789:	83 c4 10             	add    $0x10,%esp
  10078c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  10078f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  100793:	75 0d                	jne    1007a2 <log_test+0x31>
    panic("Unable to open /hello.txt");
  100795:	83 ec 0c             	sub    $0xc,%esp
  100798:	68 e9 41 10 00       	push   $0x1041e9
  10079d:	e8 0c fb ff ff       	call   1002ae <panic>
  n = fileread(gtxt, buffer, 5);
  1007a2:	83 ec 04             	sub    $0x4,%esp
  1007a5:	6a 05                	push   $0x5
  1007a7:	8d 85 f0 fd ff ff    	lea    -0x210(%ebp),%eax
  1007ad:	50                   	push   %eax
  1007ae:	ff 75 f4             	push   -0xc(%ebp)
  1007b1:	e8 64 2d 00 00       	call   10351a <fileread>
  1007b6:	83 c4 10             	add    $0x10,%esp
  1007b9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  cprintf("[UNDOLOG] READ: %d %s\n", n, buffer);
  1007bc:	83 ec 04             	sub    $0x4,%esp
  1007bf:	8d 85 f0 fd ff ff    	lea    -0x210(%ebp),%eax
  1007c5:	50                   	push   %eax
  1007c6:	ff 75 f0             	push   -0x10(%ebp)
  1007c9:	68 03 42 10 00       	push   $0x104203
  1007ce:	e8 19 f9 ff ff       	call   1000ec <cprintf>
  1007d3:	83 c4 10             	add    $0x10,%esp
  fileclose(gtxt);
  1007d6:	83 ec 0c             	sub    $0xc,%esp
  1007d9:	ff 75 f4             	push   -0xc(%ebp)
  1007dc:	e8 65 2c 00 00       	call   103446 <fileclose>
  1007e1:	83 c4 10             	add    $0x10,%esp
  buffer[0] = '0' + PANIC_1;
  1007e4:	c6 85 f0 fd ff ff 30 	movb   $0x30,-0x210(%ebp)
  buffer[1] = '0' + PANIC_2;
  1007eb:	c6 85 f1 fd ff ff 30 	movb   $0x30,-0x20f(%ebp)
  buffer[2] = '0' + PANIC_3;
  1007f2:	c6 85 f2 fd ff ff 30 	movb   $0x30,-0x20e(%ebp)
  buffer[3] = '0' + PANIC_4;
  1007f9:	c6 85 f3 fd ff ff 30 	movb   $0x30,-0x20d(%ebp)
  buffer[4] = '0' + PANIC_5;
  100800:	c6 85 f4 fd ff ff 30 	movb   $0x30,-0x20c(%ebp)
  if((gtxt = open("/hello.txt", O_WRONLY)) == 0){
  100807:	83 ec 08             	sub    $0x8,%esp
  10080a:	6a 01                	push   $0x1
  10080c:	68 de 41 10 00       	push   $0x1041de
  100811:	e8 7b 32 00 00       	call   103a91 <open>
  100816:	83 c4 10             	add    $0x10,%esp
  100819:	89 45 f4             	mov    %eax,-0xc(%ebp)
  10081c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  100820:	75 0d                	jne    10082f <log_test+0xbe>
    panic("Failed to create /hello.txt");
  100822:	83 ec 0c             	sub    $0xc,%esp
  100825:	68 1a 42 10 00       	push   $0x10421a
  10082a:	e8 7f fa ff ff       	call   1002ae <panic>
  n = filewrite(gtxt, buffer, 5);
  10082f:	83 ec 04             	sub    $0x4,%esp
  100832:	6a 05                	push   $0x5
  100834:	8d 85 f0 fd ff ff    	lea    -0x210(%ebp),%eax
  10083a:	50                   	push   %eax
  10083b:	ff 75 f4             	push   -0xc(%ebp)
  10083e:	e8 56 2d 00 00       	call   103599 <filewrite>
  100843:	83 c4 10             	add    $0x10,%esp
  100846:	89 45 f0             	mov    %eax,-0x10(%ebp)
  fileclose(gtxt);
  100849:	83 ec 0c             	sub    $0xc,%esp
  10084c:	ff 75 f4             	push   -0xc(%ebp)
  10084f:	e8 f2 2b 00 00       	call   103446 <fileclose>
  100854:	83 c4 10             	add    $0x10,%esp
}
  100857:	90                   	nop
  100858:	c9                   	leave
  100859:	c3                   	ret

0010085a <main>:
{
  10085a:	8d 4c 24 04          	lea    0x4(%esp),%ecx
  10085e:	83 e4 f0             	and    $0xfffffff0,%esp
  100861:	ff 71 fc             	push   -0x4(%ecx)
  100864:	55                   	push   %ebp
  100865:	89 e5                	mov    %esp,%ebp
  100867:	51                   	push   %ecx
  100868:	83 ec 04             	sub    $0x4,%esp
  mpinit();        // detect other processors
  10086b:	e8 83 02 00 00       	call   100af3 <mpinit>
  lapicinit();     // interrupt controller
  100870:	e8 8f fd ff ff       	call   100604 <lapicinit>
  picinit();       // disable pic
  100875:	e8 d5 03 00 00       	call   100c4f <picinit>
  ioapicinit();    // another interrupt controller
  10087a:	e8 7e fc ff ff       	call   1004fd <ioapicinit>
  uartinit();      // serial port
  10087f:	e8 2e 04 00 00       	call   100cb2 <uartinit>
  ideinit();       // disk 
  100884:	e8 1f 19 00 00       	call   1021a8 <ideinit>
  tvinit();        // trap vectors
  100889:	e8 c4 09 00 00       	call   101252 <tvinit>
  binit();         // buffer cache
  10088e:	e8 30 16 00 00       	call   101ec3 <binit>
  idtinit();       // load idt register
  100893:	e8 a0 0a 00 00       	call   101338 <idtinit>
  sti();           // enable interrupts
  100898:	e8 c6 fe ff ff       	call   100763 <sti>
  iinit(ROOTDEV);  // Read superblock to start reading inodes
  10089d:	83 ec 0c             	sub    $0xc,%esp
  1008a0:	6a 01                	push   $0x1
  1008a2:	e8 fd 1e 00 00       	call   1027a4 <iinit>
  1008a7:	83 c4 10             	add    $0x10,%esp
  initlog(ROOTDEV);  // Initialize log
  1008aa:	83 ec 0c             	sub    $0xc,%esp
  1008ad:	6a 01                	push   $0x1
  1008af:	e8 55 33 00 00       	call   103c09 <initlog>
  1008b4:	83 c4 10             	add    $0x10,%esp
  log_test();
  1008b7:	e8 b5 fe ff ff       	call   100771 <log_test>
    wfi();
  1008bc:	e8 a9 fe ff ff       	call   10076a <wfi>
  1008c1:	eb f9                	jmp    1008bc <main+0x62>

001008c3 <inb>:
// Multiprocessor support
// Search memory for MP description structures.
// http://developer.intel.com/design/pentium/datashts/24201606.pdf

#include "types.h"
  1008c3:	55                   	push   %ebp
  1008c4:	89 e5                	mov    %esp,%ebp
  1008c6:	83 ec 14             	sub    $0x14,%esp
  1008c9:	8b 45 08             	mov    0x8(%ebp),%eax
  1008cc:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
#include "defs.h"
#include "param.h"
// #include "memlayout.h"
  1008d0:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
  1008d4:	89 c2                	mov    %eax,%edx
  1008d6:	ec                   	in     (%dx),%al
  1008d7:	88 45 ff             	mov    %al,-0x1(%ebp)
#include "mp.h"
  1008da:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
#include "x86.h"
  1008de:	c9                   	leave
  1008df:	c3                   	ret

001008e0 <outb>:
static uchar
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  1008e0:	55                   	push   %ebp
  1008e1:	89 e5                	mov    %esp,%ebp
  1008e3:	83 ec 08             	sub    $0x8,%esp
  1008e6:	8b 55 08             	mov    0x8(%ebp),%edx
  1008e9:	8b 45 0c             	mov    0xc(%ebp),%eax
  1008ec:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
  1008f0:	88 45 f8             	mov    %al,-0x8(%ebp)
  for(i=0; i<len; i++)
  1008f3:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
  1008f7:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
  1008fb:	ee                   	out    %al,(%dx)
    sum += addr[i];
  1008fc:	90                   	nop
  1008fd:	c9                   	leave
  1008fe:	c3                   	ret

001008ff <sum>:
{
  1008ff:	55                   	push   %ebp
  100900:	89 e5                	mov    %esp,%ebp
  100902:	83 ec 10             	sub    $0x10,%esp
  sum = 0;
  100905:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  for(i=0; i<len; i++)
  10090c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  100913:	eb 15                	jmp    10092a <sum+0x2b>
    sum += addr[i];
  100915:	8b 55 fc             	mov    -0x4(%ebp),%edx
  100918:	8b 45 08             	mov    0x8(%ebp),%eax
  10091b:	01 d0                	add    %edx,%eax
  10091d:	0f b6 00             	movzbl (%eax),%eax
  100920:	0f b6 c0             	movzbl %al,%eax
  100923:	01 45 f8             	add    %eax,-0x8(%ebp)
  for(i=0; i<len; i++)
  100926:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  10092a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  10092d:	3b 45 0c             	cmp    0xc(%ebp),%eax
  100930:	7c e3                	jl     100915 <sum+0x16>
  return sum;
  100932:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  100935:	c9                   	leave
  100936:	c3                   	ret

00100937 <mpsearch1>:

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
  100937:	55                   	push   %ebp
  100938:	89 e5                	mov    %esp,%ebp
  10093a:	83 ec 18             	sub    $0x18,%esp
  uchar *e, *p, *addr;

  // addr = P2V(a);
  addr = (uchar*) a;
  10093d:	8b 45 08             	mov    0x8(%ebp),%eax
  100940:	89 45 f0             	mov    %eax,-0x10(%ebp)
  e = addr+len;
  100943:	8b 55 0c             	mov    0xc(%ebp),%edx
  100946:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100949:	01 d0                	add    %edx,%eax
  10094b:	89 45 ec             	mov    %eax,-0x14(%ebp)
  for(p = addr; p < e; p += sizeof(struct mp))
  10094e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100951:	89 45 f4             	mov    %eax,-0xc(%ebp)
  100954:	eb 36                	jmp    10098c <mpsearch1+0x55>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
  100956:	83 ec 04             	sub    $0x4,%esp
  100959:	6a 04                	push   $0x4
  10095b:	68 38 42 10 00       	push   $0x104238
  100960:	ff 75 f4             	push   -0xc(%ebp)
  100963:	e8 92 05 00 00       	call   100efa <memcmp>
  100968:	83 c4 10             	add    $0x10,%esp
  10096b:	85 c0                	test   %eax,%eax
  10096d:	75 19                	jne    100988 <mpsearch1+0x51>
  10096f:	83 ec 08             	sub    $0x8,%esp
  100972:	6a 10                	push   $0x10
  100974:	ff 75 f4             	push   -0xc(%ebp)
  100977:	e8 83 ff ff ff       	call   1008ff <sum>
  10097c:	83 c4 10             	add    $0x10,%esp
  10097f:	84 c0                	test   %al,%al
  100981:	75 05                	jne    100988 <mpsearch1+0x51>
      return (struct mp*)p;
  100983:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100986:	eb 11                	jmp    100999 <mpsearch1+0x62>
  for(p = addr; p < e; p += sizeof(struct mp))
  100988:	83 45 f4 10          	addl   $0x10,-0xc(%ebp)
  10098c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10098f:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  100992:	72 c2                	jb     100956 <mpsearch1+0x1f>
  return 0;
  100994:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100999:	c9                   	leave
  10099a:	c3                   	ret

0010099b <mpsearch>:
// 1) in the first KB of the EBDA;
// 2) in the last KB of system base memory;
// 3) in the BIOS ROM between 0xE0000 and 0xFFFFF.
static struct mp*
mpsearch(void)
{
  10099b:	55                   	push   %ebp
  10099c:	89 e5                	mov    %esp,%ebp
  10099e:	83 ec 18             	sub    $0x18,%esp
  uchar *bda;
  uint p;
  struct mp *mp;

  // bda = (uchar *) P2V(0x400);
  bda = (uchar *) 0x400;
  1009a1:	c7 45 f4 00 04 00 00 	movl   $0x400,-0xc(%ebp)
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
  1009a8:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1009ab:	83 c0 0f             	add    $0xf,%eax
  1009ae:	0f b6 00             	movzbl (%eax),%eax
  1009b1:	0f b6 c0             	movzbl %al,%eax
  1009b4:	c1 e0 08             	shl    $0x8,%eax
  1009b7:	89 c2                	mov    %eax,%edx
  1009b9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1009bc:	83 c0 0e             	add    $0xe,%eax
  1009bf:	0f b6 00             	movzbl (%eax),%eax
  1009c2:	0f b6 c0             	movzbl %al,%eax
  1009c5:	09 d0                	or     %edx,%eax
  1009c7:	c1 e0 04             	shl    $0x4,%eax
  1009ca:	89 45 f0             	mov    %eax,-0x10(%ebp)
  1009cd:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  1009d1:	74 21                	je     1009f4 <mpsearch+0x59>
    if((mp = mpsearch1(p, 1024)))
  1009d3:	83 ec 08             	sub    $0x8,%esp
  1009d6:	68 00 04 00 00       	push   $0x400
  1009db:	ff 75 f0             	push   -0x10(%ebp)
  1009de:	e8 54 ff ff ff       	call   100937 <mpsearch1>
  1009e3:	83 c4 10             	add    $0x10,%esp
  1009e6:	89 45 ec             	mov    %eax,-0x14(%ebp)
  1009e9:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  1009ed:	74 51                	je     100a40 <mpsearch+0xa5>
      return mp;
  1009ef:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1009f2:	eb 61                	jmp    100a55 <mpsearch+0xba>
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
  1009f4:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1009f7:	83 c0 14             	add    $0x14,%eax
  1009fa:	0f b6 00             	movzbl (%eax),%eax
  1009fd:	0f b6 c0             	movzbl %al,%eax
  100a00:	c1 e0 08             	shl    $0x8,%eax
  100a03:	89 c2                	mov    %eax,%edx
  100a05:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100a08:	83 c0 13             	add    $0x13,%eax
  100a0b:	0f b6 00             	movzbl (%eax),%eax
  100a0e:	0f b6 c0             	movzbl %al,%eax
  100a11:	09 d0                	or     %edx,%eax
  100a13:	c1 e0 0a             	shl    $0xa,%eax
  100a16:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if((mp = mpsearch1(p-1024, 1024)))
  100a19:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100a1c:	2d 00 04 00 00       	sub    $0x400,%eax
  100a21:	83 ec 08             	sub    $0x8,%esp
  100a24:	68 00 04 00 00       	push   $0x400
  100a29:	50                   	push   %eax
  100a2a:	e8 08 ff ff ff       	call   100937 <mpsearch1>
  100a2f:	83 c4 10             	add    $0x10,%esp
  100a32:	89 45 ec             	mov    %eax,-0x14(%ebp)
  100a35:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  100a39:	74 05                	je     100a40 <mpsearch+0xa5>
      return mp;
  100a3b:	8b 45 ec             	mov    -0x14(%ebp),%eax
  100a3e:	eb 15                	jmp    100a55 <mpsearch+0xba>
  }
  return mpsearch1(0xF0000, 0x10000);
  100a40:	83 ec 08             	sub    $0x8,%esp
  100a43:	68 00 00 01 00       	push   $0x10000
  100a48:	68 00 00 0f 00       	push   $0xf0000
  100a4d:	e8 e5 fe ff ff       	call   100937 <mpsearch1>
  100a52:	83 c4 10             	add    $0x10,%esp
}
  100a55:	c9                   	leave
  100a56:	c3                   	ret

00100a57 <mpconfig>:
// Check for correct signature, calculate the checksum and,
// if correct, check the version.
// To do: check extended table checksum.
static struct mpconf*
mpconfig(struct mp **pmp)
{
  100a57:	55                   	push   %ebp
  100a58:	89 e5                	mov    %esp,%ebp
  100a5a:	83 ec 18             	sub    $0x18,%esp
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
  100a5d:	e8 39 ff ff ff       	call   10099b <mpsearch>
  100a62:	89 45 f4             	mov    %eax,-0xc(%ebp)
  100a65:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  100a69:	74 0a                	je     100a75 <mpconfig+0x1e>
  100a6b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100a6e:	8b 40 04             	mov    0x4(%eax),%eax
  100a71:	85 c0                	test   %eax,%eax
  100a73:	75 07                	jne    100a7c <mpconfig+0x25>
    return 0;
  100a75:	b8 00 00 00 00       	mov    $0x0,%eax
  100a7a:	eb 75                	jmp    100af1 <mpconfig+0x9a>
  // conf = (struct mpconf*) P2V((uint) mp->physaddr);
  conf = (struct mpconf*) (uint) mp->physaddr;
  100a7c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100a7f:	8b 40 04             	mov    0x4(%eax),%eax
  100a82:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(memcmp(conf, "PCMP", 4) != 0)
  100a85:	83 ec 04             	sub    $0x4,%esp
  100a88:	6a 04                	push   $0x4
  100a8a:	68 3d 42 10 00       	push   $0x10423d
  100a8f:	ff 75 f0             	push   -0x10(%ebp)
  100a92:	e8 63 04 00 00       	call   100efa <memcmp>
  100a97:	83 c4 10             	add    $0x10,%esp
  100a9a:	85 c0                	test   %eax,%eax
  100a9c:	74 07                	je     100aa5 <mpconfig+0x4e>
    return 0;
  100a9e:	b8 00 00 00 00       	mov    $0x0,%eax
  100aa3:	eb 4c                	jmp    100af1 <mpconfig+0x9a>
  if(conf->version != 1 && conf->version != 4)
  100aa5:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100aa8:	0f b6 40 06          	movzbl 0x6(%eax),%eax
  100aac:	3c 01                	cmp    $0x1,%al
  100aae:	74 12                	je     100ac2 <mpconfig+0x6b>
  100ab0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100ab3:	0f b6 40 06          	movzbl 0x6(%eax),%eax
  100ab7:	3c 04                	cmp    $0x4,%al
  100ab9:	74 07                	je     100ac2 <mpconfig+0x6b>
    return 0;
  100abb:	b8 00 00 00 00       	mov    $0x0,%eax
  100ac0:	eb 2f                	jmp    100af1 <mpconfig+0x9a>
  if(sum((uchar*)conf, conf->length) != 0)
  100ac2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100ac5:	0f b7 40 04          	movzwl 0x4(%eax),%eax
  100ac9:	0f b7 c0             	movzwl %ax,%eax
  100acc:	83 ec 08             	sub    $0x8,%esp
  100acf:	50                   	push   %eax
  100ad0:	ff 75 f0             	push   -0x10(%ebp)
  100ad3:	e8 27 fe ff ff       	call   1008ff <sum>
  100ad8:	83 c4 10             	add    $0x10,%esp
  100adb:	84 c0                	test   %al,%al
  100add:	74 07                	je     100ae6 <mpconfig+0x8f>
    return 0;
  100adf:	b8 00 00 00 00       	mov    $0x0,%eax
  100ae4:	eb 0b                	jmp    100af1 <mpconfig+0x9a>
  *pmp = mp;
  100ae6:	8b 45 08             	mov    0x8(%ebp),%eax
  100ae9:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100aec:	89 10                	mov    %edx,(%eax)
  return conf;
  100aee:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  100af1:	c9                   	leave
  100af2:	c3                   	ret

00100af3 <mpinit>:

void
mpinit(void)
{
  100af3:	55                   	push   %ebp
  100af4:	89 e5                	mov    %esp,%ebp
  100af6:	83 ec 28             	sub    $0x28,%esp
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
  100af9:	83 ec 0c             	sub    $0xc,%esp
  100afc:	8d 45 dc             	lea    -0x24(%ebp),%eax
  100aff:	50                   	push   %eax
  100b00:	e8 52 ff ff ff       	call   100a57 <mpconfig>
  100b05:	83 c4 10             	add    $0x10,%esp
  100b08:	89 45 ec             	mov    %eax,-0x14(%ebp)
  100b0b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  100b0f:	75 0d                	jne    100b1e <mpinit+0x2b>
    panic("Expect to run on an SMP");
  100b11:	83 ec 0c             	sub    $0xc,%esp
  100b14:	68 42 42 10 00       	push   $0x104242
  100b19:	e8 90 f7 ff ff       	call   1002ae <panic>
  ismp = 1;
  100b1e:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
  lapic = (uint*)conf->lapicaddr;
  100b25:	8b 45 ec             	mov    -0x14(%ebp),%eax
  100b28:	8b 40 24             	mov    0x24(%eax),%eax
  100b2b:	a3 b4 54 10 00       	mov    %eax,0x1054b4
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
  100b30:	8b 45 ec             	mov    -0x14(%ebp),%eax
  100b33:	83 c0 2c             	add    $0x2c,%eax
  100b36:	89 45 f4             	mov    %eax,-0xc(%ebp)
  100b39:	8b 45 ec             	mov    -0x14(%ebp),%eax
  100b3c:	0f b7 40 04          	movzwl 0x4(%eax),%eax
  100b40:	0f b7 d0             	movzwl %ax,%edx
  100b43:	8b 45 ec             	mov    -0x14(%ebp),%eax
  100b46:	01 d0                	add    %edx,%eax
  100b48:	89 45 e8             	mov    %eax,-0x18(%ebp)
  100b4b:	e9 83 00 00 00       	jmp    100bd3 <mpinit+0xe0>
    switch(*p){
  100b50:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100b53:	0f b6 00             	movzbl (%eax),%eax
  100b56:	0f b6 c0             	movzbl %al,%eax
  100b59:	83 f8 04             	cmp    $0x4,%eax
  100b5c:	7f 6d                	jg     100bcb <mpinit+0xd8>
  100b5e:	83 f8 03             	cmp    $0x3,%eax
  100b61:	7d 62                	jge    100bc5 <mpinit+0xd2>
  100b63:	83 f8 02             	cmp    $0x2,%eax
  100b66:	74 45                	je     100bad <mpinit+0xba>
  100b68:	83 f8 02             	cmp    $0x2,%eax
  100b6b:	7f 5e                	jg     100bcb <mpinit+0xd8>
  100b6d:	85 c0                	test   %eax,%eax
  100b6f:	74 07                	je     100b78 <mpinit+0x85>
  100b71:	83 f8 01             	cmp    $0x1,%eax
  100b74:	74 4f                	je     100bc5 <mpinit+0xd2>
  100b76:	eb 53                	jmp    100bcb <mpinit+0xd8>
    case MPPROC:
      proc = (struct mpproc*)p;
  100b78:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100b7b:	89 45 e0             	mov    %eax,-0x20(%ebp)
      if(ncpu < NCPU) {
  100b7e:	a1 c0 54 10 00       	mov    0x1054c0,%eax
  100b83:	83 f8 07             	cmp    $0x7,%eax
  100b86:	7f 1f                	jg     100ba7 <mpinit+0xb4>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
  100b88:	a1 c0 54 10 00       	mov    0x1054c0,%eax
  100b8d:	8b 55 e0             	mov    -0x20(%ebp),%edx
  100b90:	0f b6 52 01          	movzbl 0x1(%edx),%edx
  100b94:	88 90 b8 54 10 00    	mov    %dl,0x1054b8(%eax)
        ncpu++;
  100b9a:	a1 c0 54 10 00       	mov    0x1054c0,%eax
  100b9f:	83 c0 01             	add    $0x1,%eax
  100ba2:	a3 c0 54 10 00       	mov    %eax,0x1054c0
      }
      p += sizeof(struct mpproc);
  100ba7:	83 45 f4 14          	addl   $0x14,-0xc(%ebp)
      continue;
  100bab:	eb 26                	jmp    100bd3 <mpinit+0xe0>
    case MPIOAPIC:
      ioapic = (struct mpioapic*)p;
  100bad:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100bb0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      ioapicid = ioapic->apicno;
  100bb3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  100bb6:	0f b6 40 01          	movzbl 0x1(%eax),%eax
  100bba:	a2 c4 54 10 00       	mov    %al,0x1054c4
      p += sizeof(struct mpioapic);
  100bbf:	83 45 f4 08          	addl   $0x8,-0xc(%ebp)
      continue;
  100bc3:	eb 0e                	jmp    100bd3 <mpinit+0xe0>
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
  100bc5:	83 45 f4 08          	addl   $0x8,-0xc(%ebp)
      continue;
  100bc9:	eb 08                	jmp    100bd3 <mpinit+0xe0>
    default:
      ismp = 0;
  100bcb:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
      break;
  100bd2:	90                   	nop
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
  100bd3:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100bd6:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  100bd9:	0f 82 71 ff ff ff    	jb     100b50 <mpinit+0x5d>
    }
  }
  if(!ismp)
  100bdf:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  100be3:	75 0d                	jne    100bf2 <mpinit+0xff>
    panic("Didn't find a suitable machine");
  100be5:	83 ec 0c             	sub    $0xc,%esp
  100be8:	68 5c 42 10 00       	push   $0x10425c
  100bed:	e8 bc f6 ff ff       	call   1002ae <panic>

  if(mp->imcrp){
  100bf2:	8b 45 dc             	mov    -0x24(%ebp),%eax
  100bf5:	0f b6 40 0c          	movzbl 0xc(%eax),%eax
  100bf9:	84 c0                	test   %al,%al
  100bfb:	74 30                	je     100c2d <mpinit+0x13a>
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
  100bfd:	83 ec 08             	sub    $0x8,%esp
  100c00:	6a 70                	push   $0x70
  100c02:	6a 22                	push   $0x22
  100c04:	e8 d7 fc ff ff       	call   1008e0 <outb>
  100c09:	83 c4 10             	add    $0x10,%esp
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
  100c0c:	83 ec 0c             	sub    $0xc,%esp
  100c0f:	6a 23                	push   $0x23
  100c11:	e8 ad fc ff ff       	call   1008c3 <inb>
  100c16:	83 c4 10             	add    $0x10,%esp
  100c19:	83 c8 01             	or     $0x1,%eax
  100c1c:	0f b6 c0             	movzbl %al,%eax
  100c1f:	83 ec 08             	sub    $0x8,%esp
  100c22:	50                   	push   %eax
  100c23:	6a 23                	push   $0x23
  100c25:	e8 b6 fc ff ff       	call   1008e0 <outb>
  100c2a:	83 c4 10             	add    $0x10,%esp
  }
}
  100c2d:	90                   	nop
  100c2e:	c9                   	leave
  100c2f:	c3                   	ret

00100c30 <outb>:
  100c30:	55                   	push   %ebp
  100c31:	89 e5                	mov    %esp,%ebp
  100c33:	83 ec 08             	sub    $0x8,%esp
  100c36:	8b 55 08             	mov    0x8(%ebp),%edx
  100c39:	8b 45 0c             	mov    0xc(%ebp),%eax
  100c3c:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
  100c40:	88 45 f8             	mov    %al,-0x8(%ebp)
  100c43:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
  100c47:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
  100c4b:	ee                   	out    %al,(%dx)
  100c4c:	90                   	nop
  100c4d:	c9                   	leave
  100c4e:	c3                   	ret

00100c4f <picinit>:
{
  100c4f:	55                   	push   %ebp
  100c50:	89 e5                	mov    %esp,%ebp
  outb(IO_PIC1+1, 0xFF);
  100c52:	68 ff 00 00 00       	push   $0xff
  100c57:	6a 21                	push   $0x21
  100c59:	e8 d2 ff ff ff       	call   100c30 <outb>
  100c5e:	83 c4 08             	add    $0x8,%esp
  outb(IO_PIC2+1, 0xFF);
  100c61:	68 ff 00 00 00       	push   $0xff
  100c66:	68 a1 00 00 00       	push   $0xa1
  100c6b:	e8 c0 ff ff ff       	call   100c30 <outb>
  100c70:	83 c4 08             	add    $0x8,%esp
  100c73:	90                   	nop
  100c74:	c9                   	leave
  100c75:	c3                   	ret

00100c76 <inb>:
// Intel 8250 serial port (UART).

#include "types.h"
#include "defs.h"
#include "param.h"
  100c76:	55                   	push   %ebp
  100c77:	89 e5                	mov    %esp,%ebp
  100c79:	83 ec 14             	sub    $0x14,%esp
  100c7c:	8b 45 08             	mov    0x8(%ebp),%eax
  100c7f:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
#include "x86.h"
#include "traps.h"

  100c83:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
  100c87:	89 c2                	mov    %eax,%edx
  100c89:	ec                   	in     (%dx),%al
  100c8a:	88 45 ff             	mov    %al,-0x1(%ebp)
#define COM1    0x3f8
  100c8d:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax

  100c91:	c9                   	leave
  100c92:	c3                   	ret

00100c93 <outb>:
  // Turn off the FIFO
  outb(COM1+2, 0);

  // 9600 baud, 8 data bits, 1 stop bit, parity off.
  outb(COM1+3, 0x80);    // Unlock divisor
  outb(COM1+0, 115200/9600);
  100c93:	55                   	push   %ebp
  100c94:	89 e5                	mov    %esp,%ebp
  100c96:	83 ec 08             	sub    $0x8,%esp
  100c99:	8b 55 08             	mov    0x8(%ebp),%edx
  100c9c:	8b 45 0c             	mov    0xc(%ebp),%eax
  100c9f:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
  100ca3:	88 45 f8             	mov    %al,-0x8(%ebp)
  outb(COM1+1, 0);
  100ca6:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
  100caa:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
  100cae:	ee                   	out    %al,(%dx)
  outb(COM1+3, 0x03);    // Lock divisor, 8 data bits.
  100caf:	90                   	nop
  100cb0:	c9                   	leave
  100cb1:	c3                   	ret

00100cb2 <uartinit>:
{
  100cb2:	55                   	push   %ebp
  100cb3:	89 e5                	mov    %esp,%ebp
  100cb5:	83 ec 18             	sub    $0x18,%esp
  outb(COM1+2, 0);
  100cb8:	6a 00                	push   $0x0
  100cba:	68 fa 03 00 00       	push   $0x3fa
  100cbf:	e8 cf ff ff ff       	call   100c93 <outb>
  100cc4:	83 c4 08             	add    $0x8,%esp
  outb(COM1+3, 0x80);    // Unlock divisor
  100cc7:	68 80 00 00 00       	push   $0x80
  100ccc:	68 fb 03 00 00       	push   $0x3fb
  100cd1:	e8 bd ff ff ff       	call   100c93 <outb>
  100cd6:	83 c4 08             	add    $0x8,%esp
  outb(COM1+0, 115200/9600);
  100cd9:	6a 0c                	push   $0xc
  100cdb:	68 f8 03 00 00       	push   $0x3f8
  100ce0:	e8 ae ff ff ff       	call   100c93 <outb>
  100ce5:	83 c4 08             	add    $0x8,%esp
  outb(COM1+1, 0);
  100ce8:	6a 00                	push   $0x0
  100cea:	68 f9 03 00 00       	push   $0x3f9
  100cef:	e8 9f ff ff ff       	call   100c93 <outb>
  100cf4:	83 c4 08             	add    $0x8,%esp
  outb(COM1+3, 0x03);    // Lock divisor, 8 data bits.
  100cf7:	6a 03                	push   $0x3
  100cf9:	68 fb 03 00 00       	push   $0x3fb
  100cfe:	e8 90 ff ff ff       	call   100c93 <outb>
  100d03:	83 c4 08             	add    $0x8,%esp
  outb(COM1+4, 0);
  100d06:	6a 00                	push   $0x0
  100d08:	68 fc 03 00 00       	push   $0x3fc
  100d0d:	e8 81 ff ff ff       	call   100c93 <outb>
  100d12:	83 c4 08             	add    $0x8,%esp
  outb(COM1+1, 0x01);    // Enable receive interrupts.
  100d15:	6a 01                	push   $0x1
  100d17:	68 f9 03 00 00       	push   $0x3f9
  100d1c:	e8 72 ff ff ff       	call   100c93 <outb>
  100d21:	83 c4 08             	add    $0x8,%esp

  // If status is 0xFF, no serial port.
  if(inb(COM1+5) == 0xFF)
  100d24:	68 fd 03 00 00       	push   $0x3fd
  100d29:	e8 48 ff ff ff       	call   100c76 <inb>
  100d2e:	83 c4 04             	add    $0x4,%esp
  100d31:	3c ff                	cmp    $0xff,%al
  100d33:	74 61                	je     100d96 <uartinit+0xe4>
    return;
  uart = 1;
  100d35:	c7 05 c8 54 10 00 01 	movl   $0x1,0x1054c8
  100d3c:	00 00 00 

  // Acknowledge pre-existing interrupt conditions;
  // enable interrupts.
  inb(COM1+2);
  100d3f:	68 fa 03 00 00       	push   $0x3fa
  100d44:	e8 2d ff ff ff       	call   100c76 <inb>
  100d49:	83 c4 04             	add    $0x4,%esp
  inb(COM1+0);
  100d4c:	68 f8 03 00 00       	push   $0x3f8
  100d51:	e8 20 ff ff ff       	call   100c76 <inb>
  100d56:	83 c4 04             	add    $0x4,%esp
  ioapicenable(IRQ_COM1, 0);
  100d59:	83 ec 08             	sub    $0x8,%esp
  100d5c:	6a 00                	push   $0x0
  100d5e:	6a 04                	push   $0x4
  100d60:	e8 40 f8 ff ff       	call   1005a5 <ioapicenable>
  100d65:	83 c4 10             	add    $0x10,%esp

  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
  100d68:	c7 45 f4 7b 42 10 00 	movl   $0x10427b,-0xc(%ebp)
  100d6f:	eb 19                	jmp    100d8a <uartinit+0xd8>
    uartputc(*p);
  100d71:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100d74:	0f b6 00             	movzbl (%eax),%eax
  100d77:	0f be c0             	movsbl %al,%eax
  100d7a:	83 ec 0c             	sub    $0xc,%esp
  100d7d:	50                   	push   %eax
  100d7e:	e8 16 00 00 00       	call   100d99 <uartputc>
  100d83:	83 c4 10             	add    $0x10,%esp
  for(p="xv6...\n"; *p; p++)
  100d86:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  100d8a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100d8d:	0f b6 00             	movzbl (%eax),%eax
  100d90:	84 c0                	test   %al,%al
  100d92:	75 dd                	jne    100d71 <uartinit+0xbf>
  100d94:	eb 01                	jmp    100d97 <uartinit+0xe5>
    return;
  100d96:	90                   	nop
}
  100d97:	c9                   	leave
  100d98:	c3                   	ret

00100d99 <uartputc>:

void
uartputc(int c)
{
  100d99:	55                   	push   %ebp
  100d9a:	89 e5                	mov    %esp,%ebp
  100d9c:	83 ec 10             	sub    $0x10,%esp
  int i;

  if(!uart)
  100d9f:	a1 c8 54 10 00       	mov    0x1054c8,%eax
  100da4:	85 c0                	test   %eax,%eax
  100da6:	74 40                	je     100de8 <uartputc+0x4f>
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++);
  100da8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  100daf:	eb 04                	jmp    100db5 <uartputc+0x1c>
  100db1:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  100db5:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%ebp)
  100db9:	7f 17                	jg     100dd2 <uartputc+0x39>
  100dbb:	68 fd 03 00 00       	push   $0x3fd
  100dc0:	e8 b1 fe ff ff       	call   100c76 <inb>
  100dc5:	83 c4 04             	add    $0x4,%esp
  100dc8:	0f b6 c0             	movzbl %al,%eax
  100dcb:	83 e0 20             	and    $0x20,%eax
  100dce:	85 c0                	test   %eax,%eax
  100dd0:	74 df                	je     100db1 <uartputc+0x18>
  outb(COM1+0, c);
  100dd2:	8b 45 08             	mov    0x8(%ebp),%eax
  100dd5:	0f b6 c0             	movzbl %al,%eax
  100dd8:	50                   	push   %eax
  100dd9:	68 f8 03 00 00       	push   $0x3f8
  100dde:	e8 b0 fe ff ff       	call   100c93 <outb>
  100de3:	83 c4 08             	add    $0x8,%esp
  100de6:	eb 01                	jmp    100de9 <uartputc+0x50>
    return;
  100de8:	90                   	nop
}
  100de9:	c9                   	leave
  100dea:	c3                   	ret

00100deb <uartgetc>:


static int
uartgetc(void)
{
  100deb:	55                   	push   %ebp
  100dec:	89 e5                	mov    %esp,%ebp
  if(!uart)
  100dee:	a1 c8 54 10 00       	mov    0x1054c8,%eax
  100df3:	85 c0                	test   %eax,%eax
  100df5:	75 07                	jne    100dfe <uartgetc+0x13>
    return -1;
  100df7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  100dfc:	eb 2e                	jmp    100e2c <uartgetc+0x41>
  if(!(inb(COM1+5) & 0x01))
  100dfe:	68 fd 03 00 00       	push   $0x3fd
  100e03:	e8 6e fe ff ff       	call   100c76 <inb>
  100e08:	83 c4 04             	add    $0x4,%esp
  100e0b:	0f b6 c0             	movzbl %al,%eax
  100e0e:	83 e0 01             	and    $0x1,%eax
  100e11:	85 c0                	test   %eax,%eax
  100e13:	75 07                	jne    100e1c <uartgetc+0x31>
    return -1;
  100e15:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  100e1a:	eb 10                	jmp    100e2c <uartgetc+0x41>
  return inb(COM1+0);
  100e1c:	68 f8 03 00 00       	push   $0x3f8
  100e21:	e8 50 fe ff ff       	call   100c76 <inb>
  100e26:	83 c4 04             	add    $0x4,%esp
  100e29:	0f b6 c0             	movzbl %al,%eax
}
  100e2c:	c9                   	leave
  100e2d:	c3                   	ret

00100e2e <uartintr>:

void
uartintr(void)
{
  100e2e:	55                   	push   %ebp
  100e2f:	89 e5                	mov    %esp,%ebp
  100e31:	83 ec 08             	sub    $0x8,%esp
  consoleintr(uartgetc);
  100e34:	83 ec 0c             	sub    $0xc,%esp
  100e37:	68 eb 0d 10 00       	push   $0x100deb
  100e3c:	e8 43 f5 ff ff       	call   100384 <consoleintr>
  100e41:	83 c4 10             	add    $0x10,%esp
  100e44:	90                   	nop
  100e45:	c9                   	leave
  100e46:	c3                   	ret

00100e47 <stosb>:
  if(s < d && s + n > d){
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
  100e47:	55                   	push   %ebp
  100e48:	89 e5                	mov    %esp,%ebp
  100e4a:	57                   	push   %edi
  100e4b:	53                   	push   %ebx
    while(n-- > 0)
  100e4c:	8b 4d 08             	mov    0x8(%ebp),%ecx
  100e4f:	8b 55 10             	mov    0x10(%ebp),%edx
  100e52:	8b 45 0c             	mov    0xc(%ebp),%eax
  100e55:	89 cb                	mov    %ecx,%ebx
  100e57:	89 df                	mov    %ebx,%edi
  100e59:	89 d1                	mov    %edx,%ecx
  100e5b:	fc                   	cld
  100e5c:	f3 aa                	rep stos %al,%es:(%edi)
  100e5e:	89 ca                	mov    %ecx,%edx
  100e60:	89 fb                	mov    %edi,%ebx
  100e62:	89 5d 08             	mov    %ebx,0x8(%ebp)
  100e65:	89 55 10             	mov    %edx,0x10(%ebp)
      *d++ = *s++;

  return dst;
}
  100e68:	90                   	nop
  100e69:	5b                   	pop    %ebx
  100e6a:	5f                   	pop    %edi
  100e6b:	5d                   	pop    %ebp
  100e6c:	c3                   	ret

00100e6d <stosl>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
  100e6d:	55                   	push   %ebp
  100e6e:	89 e5                	mov    %esp,%ebp
  100e70:	57                   	push   %edi
  100e71:	53                   	push   %ebx
{
  100e72:	8b 4d 08             	mov    0x8(%ebp),%ecx
  100e75:	8b 55 10             	mov    0x10(%ebp),%edx
  100e78:	8b 45 0c             	mov    0xc(%ebp),%eax
  100e7b:	89 cb                	mov    %ecx,%ebx
  100e7d:	89 df                	mov    %ebx,%edi
  100e7f:	89 d1                	mov    %edx,%ecx
  100e81:	fc                   	cld
  100e82:	f3 ab                	rep stos %eax,%es:(%edi)
  100e84:	89 ca                	mov    %ecx,%edx
  100e86:	89 fb                	mov    %edi,%ebx
  100e88:	89 5d 08             	mov    %ebx,0x8(%ebp)
  100e8b:	89 55 10             	mov    %edx,0x10(%ebp)
  return memmove(dst, src, n);
}

int
  100e8e:	90                   	nop
  100e8f:	5b                   	pop    %ebx
  100e90:	5f                   	pop    %edi
  100e91:	5d                   	pop    %ebp
  100e92:	c3                   	ret

00100e93 <memset>:
{
  100e93:	55                   	push   %ebp
  100e94:	89 e5                	mov    %esp,%ebp
  if ((int)dst%4 == 0 && n%4 == 0){
  100e96:	8b 45 08             	mov    0x8(%ebp),%eax
  100e99:	83 e0 03             	and    $0x3,%eax
  100e9c:	85 c0                	test   %eax,%eax
  100e9e:	75 43                	jne    100ee3 <memset+0x50>
  100ea0:	8b 45 10             	mov    0x10(%ebp),%eax
  100ea3:	83 e0 03             	and    $0x3,%eax
  100ea6:	85 c0                	test   %eax,%eax
  100ea8:	75 39                	jne    100ee3 <memset+0x50>
    c &= 0xFF;
  100eaa:	81 65 0c ff 00 00 00 	andl   $0xff,0xc(%ebp)
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
  100eb1:	8b 45 10             	mov    0x10(%ebp),%eax
  100eb4:	c1 e8 02             	shr    $0x2,%eax
  100eb7:	89 c1                	mov    %eax,%ecx
  100eb9:	8b 45 0c             	mov    0xc(%ebp),%eax
  100ebc:	c1 e0 18             	shl    $0x18,%eax
  100ebf:	89 c2                	mov    %eax,%edx
  100ec1:	8b 45 0c             	mov    0xc(%ebp),%eax
  100ec4:	c1 e0 10             	shl    $0x10,%eax
  100ec7:	09 c2                	or     %eax,%edx
  100ec9:	8b 45 0c             	mov    0xc(%ebp),%eax
  100ecc:	c1 e0 08             	shl    $0x8,%eax
  100ecf:	09 d0                	or     %edx,%eax
  100ed1:	0b 45 0c             	or     0xc(%ebp),%eax
  100ed4:	51                   	push   %ecx
  100ed5:	50                   	push   %eax
  100ed6:	ff 75 08             	push   0x8(%ebp)
  100ed9:	e8 8f ff ff ff       	call   100e6d <stosl>
  100ede:	83 c4 0c             	add    $0xc,%esp
  100ee1:	eb 12                	jmp    100ef5 <memset+0x62>
    stosb(dst, c, n);
  100ee3:	8b 45 10             	mov    0x10(%ebp),%eax
  100ee6:	50                   	push   %eax
  100ee7:	ff 75 0c             	push   0xc(%ebp)
  100eea:	ff 75 08             	push   0x8(%ebp)
  100eed:	e8 55 ff ff ff       	call   100e47 <stosb>
  100ef2:	83 c4 0c             	add    $0xc,%esp
  return dst;
  100ef5:	8b 45 08             	mov    0x8(%ebp),%eax
}
  100ef8:	c9                   	leave
  100ef9:	c3                   	ret

00100efa <memcmp>:
{
  100efa:	55                   	push   %ebp
  100efb:	89 e5                	mov    %esp,%ebp
  100efd:	83 ec 10             	sub    $0x10,%esp
  s1 = v1;
  100f00:	8b 45 08             	mov    0x8(%ebp),%eax
  100f03:	89 45 fc             	mov    %eax,-0x4(%ebp)
  s2 = v2;
  100f06:	8b 45 0c             	mov    0xc(%ebp),%eax
  100f09:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0){
  100f0c:	eb 2e                	jmp    100f3c <memcmp+0x42>
    if(*s1 != *s2)
  100f0e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100f11:	0f b6 10             	movzbl (%eax),%edx
  100f14:	8b 45 f8             	mov    -0x8(%ebp),%eax
  100f17:	0f b6 00             	movzbl (%eax),%eax
  100f1a:	38 c2                	cmp    %al,%dl
  100f1c:	74 16                	je     100f34 <memcmp+0x3a>
      return *s1 - *s2;
  100f1e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100f21:	0f b6 00             	movzbl (%eax),%eax
  100f24:	0f b6 d0             	movzbl %al,%edx
  100f27:	8b 45 f8             	mov    -0x8(%ebp),%eax
  100f2a:	0f b6 00             	movzbl (%eax),%eax
  100f2d:	0f b6 c0             	movzbl %al,%eax
  100f30:	29 c2                	sub    %eax,%edx
  100f32:	eb 1a                	jmp    100f4e <memcmp+0x54>
    s1++, s2++;
  100f34:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  100f38:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
  while(n-- > 0){
  100f3c:	8b 45 10             	mov    0x10(%ebp),%eax
  100f3f:	8d 50 ff             	lea    -0x1(%eax),%edx
  100f42:	89 55 10             	mov    %edx,0x10(%ebp)
  100f45:	85 c0                	test   %eax,%eax
  100f47:	75 c5                	jne    100f0e <memcmp+0x14>
  return 0;
  100f49:	ba 00 00 00 00       	mov    $0x0,%edx
}
  100f4e:	89 d0                	mov    %edx,%eax
  100f50:	c9                   	leave
  100f51:	c3                   	ret

00100f52 <memmove>:
{
  100f52:	55                   	push   %ebp
  100f53:	89 e5                	mov    %esp,%ebp
  100f55:	83 ec 10             	sub    $0x10,%esp
  s = src;
  100f58:	8b 45 0c             	mov    0xc(%ebp),%eax
  100f5b:	89 45 fc             	mov    %eax,-0x4(%ebp)
  d = dst;
  100f5e:	8b 45 08             	mov    0x8(%ebp),%eax
  100f61:	89 45 f8             	mov    %eax,-0x8(%ebp)
  if(s < d && s + n > d){
  100f64:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100f67:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  100f6a:	73 54                	jae    100fc0 <memmove+0x6e>
  100f6c:	8b 55 fc             	mov    -0x4(%ebp),%edx
  100f6f:	8b 45 10             	mov    0x10(%ebp),%eax
  100f72:	01 d0                	add    %edx,%eax
  100f74:	39 45 f8             	cmp    %eax,-0x8(%ebp)
  100f77:	73 47                	jae    100fc0 <memmove+0x6e>
    s += n;
  100f79:	8b 45 10             	mov    0x10(%ebp),%eax
  100f7c:	01 45 fc             	add    %eax,-0x4(%ebp)
    d += n;
  100f7f:	8b 45 10             	mov    0x10(%ebp),%eax
  100f82:	01 45 f8             	add    %eax,-0x8(%ebp)
    while(n-- > 0)
  100f85:	eb 13                	jmp    100f9a <memmove+0x48>
      *--d = *--s;
  100f87:	83 6d fc 01          	subl   $0x1,-0x4(%ebp)
  100f8b:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
  100f8f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100f92:	0f b6 10             	movzbl (%eax),%edx
  100f95:	8b 45 f8             	mov    -0x8(%ebp),%eax
  100f98:	88 10                	mov    %dl,(%eax)
    while(n-- > 0)
  100f9a:	8b 45 10             	mov    0x10(%ebp),%eax
  100f9d:	8d 50 ff             	lea    -0x1(%eax),%edx
  100fa0:	89 55 10             	mov    %edx,0x10(%ebp)
  100fa3:	85 c0                	test   %eax,%eax
  100fa5:	75 e0                	jne    100f87 <memmove+0x35>
  if(s < d && s + n > d){
  100fa7:	eb 24                	jmp    100fcd <memmove+0x7b>
      *d++ = *s++;
  100fa9:	8b 55 fc             	mov    -0x4(%ebp),%edx
  100fac:	8d 42 01             	lea    0x1(%edx),%eax
  100faf:	89 45 fc             	mov    %eax,-0x4(%ebp)
  100fb2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  100fb5:	8d 48 01             	lea    0x1(%eax),%ecx
  100fb8:	89 4d f8             	mov    %ecx,-0x8(%ebp)
  100fbb:	0f b6 12             	movzbl (%edx),%edx
  100fbe:	88 10                	mov    %dl,(%eax)
    while(n-- > 0)
  100fc0:	8b 45 10             	mov    0x10(%ebp),%eax
  100fc3:	8d 50 ff             	lea    -0x1(%eax),%edx
  100fc6:	89 55 10             	mov    %edx,0x10(%ebp)
  100fc9:	85 c0                	test   %eax,%eax
  100fcb:	75 dc                	jne    100fa9 <memmove+0x57>
  return dst;
  100fcd:	8b 45 08             	mov    0x8(%ebp),%eax
}
  100fd0:	c9                   	leave
  100fd1:	c3                   	ret

00100fd2 <memcpy>:
{
  100fd2:	55                   	push   %ebp
  100fd3:	89 e5                	mov    %esp,%ebp
  return memmove(dst, src, n);
  100fd5:	ff 75 10             	push   0x10(%ebp)
  100fd8:	ff 75 0c             	push   0xc(%ebp)
  100fdb:	ff 75 08             	push   0x8(%ebp)
  100fde:	e8 6f ff ff ff       	call   100f52 <memmove>
  100fe3:	83 c4 0c             	add    $0xc,%esp
}
  100fe6:	c9                   	leave
  100fe7:	c3                   	ret

00100fe8 <strncmp>:
strncmp(const char *p, const char *q, uint n)
{
  100fe8:	55                   	push   %ebp
  100fe9:	89 e5                	mov    %esp,%ebp
  while(n > 0 && *p && *p == *q)
  100feb:	eb 0c                	jmp    100ff9 <strncmp+0x11>
    n--, p++, q++;
  100fed:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
  100ff1:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  100ff5:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  while(n > 0 && *p && *p == *q)
  100ff9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  100ffd:	74 1a                	je     101019 <strncmp+0x31>
  100fff:	8b 45 08             	mov    0x8(%ebp),%eax
  101002:	0f b6 00             	movzbl (%eax),%eax
  101005:	84 c0                	test   %al,%al
  101007:	74 10                	je     101019 <strncmp+0x31>
  101009:	8b 45 08             	mov    0x8(%ebp),%eax
  10100c:	0f b6 10             	movzbl (%eax),%edx
  10100f:	8b 45 0c             	mov    0xc(%ebp),%eax
  101012:	0f b6 00             	movzbl (%eax),%eax
  101015:	38 c2                	cmp    %al,%dl
  101017:	74 d4                	je     100fed <strncmp+0x5>
  if(n == 0)
  101019:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  10101d:	75 07                	jne    101026 <strncmp+0x3e>
    return 0;
  10101f:	ba 00 00 00 00       	mov    $0x0,%edx
  101024:	eb 14                	jmp    10103a <strncmp+0x52>
  return (uchar)*p - (uchar)*q;
  101026:	8b 45 08             	mov    0x8(%ebp),%eax
  101029:	0f b6 00             	movzbl (%eax),%eax
  10102c:	0f b6 d0             	movzbl %al,%edx
  10102f:	8b 45 0c             	mov    0xc(%ebp),%eax
  101032:	0f b6 00             	movzbl (%eax),%eax
  101035:	0f b6 c0             	movzbl %al,%eax
  101038:	29 c2                	sub    %eax,%edx
}
  10103a:	89 d0                	mov    %edx,%eax
  10103c:	5d                   	pop    %ebp
  10103d:	c3                   	ret

0010103e <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
  10103e:	55                   	push   %ebp
  10103f:	89 e5                	mov    %esp,%ebp
  101041:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
  101044:	8b 45 08             	mov    0x8(%ebp),%eax
  101047:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while(n-- > 0 && (*s++ = *t++) != 0)
  10104a:	90                   	nop
  10104b:	8b 45 10             	mov    0x10(%ebp),%eax
  10104e:	8d 50 ff             	lea    -0x1(%eax),%edx
  101051:	89 55 10             	mov    %edx,0x10(%ebp)
  101054:	85 c0                	test   %eax,%eax
  101056:	7e 2c                	jle    101084 <strncpy+0x46>
  101058:	8b 55 0c             	mov    0xc(%ebp),%edx
  10105b:	8d 42 01             	lea    0x1(%edx),%eax
  10105e:	89 45 0c             	mov    %eax,0xc(%ebp)
  101061:	8b 45 08             	mov    0x8(%ebp),%eax
  101064:	8d 48 01             	lea    0x1(%eax),%ecx
  101067:	89 4d 08             	mov    %ecx,0x8(%ebp)
  10106a:	0f b6 12             	movzbl (%edx),%edx
  10106d:	88 10                	mov    %dl,(%eax)
  10106f:	0f b6 00             	movzbl (%eax),%eax
  101072:	84 c0                	test   %al,%al
  101074:	75 d5                	jne    10104b <strncpy+0xd>
    ;
  while(n-- > 0)
  101076:	eb 0c                	jmp    101084 <strncpy+0x46>
    *s++ = 0;
  101078:	8b 45 08             	mov    0x8(%ebp),%eax
  10107b:	8d 50 01             	lea    0x1(%eax),%edx
  10107e:	89 55 08             	mov    %edx,0x8(%ebp)
  101081:	c6 00 00             	movb   $0x0,(%eax)
  while(n-- > 0)
  101084:	8b 45 10             	mov    0x10(%ebp),%eax
  101087:	8d 50 ff             	lea    -0x1(%eax),%edx
  10108a:	89 55 10             	mov    %edx,0x10(%ebp)
  10108d:	85 c0                	test   %eax,%eax
  10108f:	7f e7                	jg     101078 <strncpy+0x3a>
  return os;
  101091:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  101094:	c9                   	leave
  101095:	c3                   	ret

00101096 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
  101096:	55                   	push   %ebp
  101097:	89 e5                	mov    %esp,%ebp
  101099:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
  10109c:	8b 45 08             	mov    0x8(%ebp),%eax
  10109f:	89 45 fc             	mov    %eax,-0x4(%ebp)
  if(n <= 0)
  1010a2:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  1010a6:	7f 05                	jg     1010ad <safestrcpy+0x17>
    return os;
  1010a8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1010ab:	eb 32                	jmp    1010df <safestrcpy+0x49>
  while(--n > 0 && (*s++ = *t++) != 0)
  1010ad:	90                   	nop
  1010ae:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
  1010b2:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  1010b6:	7e 1e                	jle    1010d6 <safestrcpy+0x40>
  1010b8:	8b 55 0c             	mov    0xc(%ebp),%edx
  1010bb:	8d 42 01             	lea    0x1(%edx),%eax
  1010be:	89 45 0c             	mov    %eax,0xc(%ebp)
  1010c1:	8b 45 08             	mov    0x8(%ebp),%eax
  1010c4:	8d 48 01             	lea    0x1(%eax),%ecx
  1010c7:	89 4d 08             	mov    %ecx,0x8(%ebp)
  1010ca:	0f b6 12             	movzbl (%edx),%edx
  1010cd:	88 10                	mov    %dl,(%eax)
  1010cf:	0f b6 00             	movzbl (%eax),%eax
  1010d2:	84 c0                	test   %al,%al
  1010d4:	75 d8                	jne    1010ae <safestrcpy+0x18>
    ;
  *s = 0;
  1010d6:	8b 45 08             	mov    0x8(%ebp),%eax
  1010d9:	c6 00 00             	movb   $0x0,(%eax)
  return os;
  1010dc:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  1010df:	c9                   	leave
  1010e0:	c3                   	ret

001010e1 <strlen>:

int
strlen(const char *s)
{
  1010e1:	55                   	push   %ebp
  1010e2:	89 e5                	mov    %esp,%ebp
  1010e4:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
  1010e7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  1010ee:	eb 04                	jmp    1010f4 <strlen+0x13>
  1010f0:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  1010f4:	8b 55 fc             	mov    -0x4(%ebp),%edx
  1010f7:	8b 45 08             	mov    0x8(%ebp),%eax
  1010fa:	01 d0                	add    %edx,%eax
  1010fc:	0f b6 00             	movzbl (%eax),%eax
  1010ff:	84 c0                	test   %al,%al
  101101:	75 ed                	jne    1010f0 <strlen+0xf>
    ;
  return n;
  101103:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  101106:	c9                   	leave
  101107:	c3                   	ret

00101108 <readeflags>:
  101108:	55                   	push   %ebp
  101109:	89 e5                	mov    %esp,%ebp
  10110b:	83 ec 10             	sub    $0x10,%esp
  10110e:	9c                   	pushf
  10110f:	58                   	pop    %eax
  101110:	89 45 fc             	mov    %eax,-0x4(%ebp)
  101113:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101116:	c9                   	leave
  101117:	c3                   	ret

00101118 <cpuid>:
cpuid() {
  101118:	55                   	push   %ebp
  101119:	89 e5                	mov    %esp,%ebp
  10111b:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
  10111e:	e8 07 00 00 00       	call   10112a <mycpu>
  101123:	2d b8 54 10 00       	sub    $0x1054b8,%eax
}
  101128:	c9                   	leave
  101129:	c3                   	ret

0010112a <mycpu>:
{
  10112a:	55                   	push   %ebp
  10112b:	89 e5                	mov    %esp,%ebp
  10112d:	83 ec 18             	sub    $0x18,%esp
  if(readeflags()&FL_IF)
  101130:	e8 d3 ff ff ff       	call   101108 <readeflags>
  101135:	25 00 02 00 00       	and    $0x200,%eax
  10113a:	85 c0                	test   %eax,%eax
  10113c:	74 0d                	je     10114b <mycpu+0x21>
    panic("mycpu called with interrupts enabled\n");
  10113e:	83 ec 0c             	sub    $0xc,%esp
  101141:	68 84 42 10 00       	push   $0x104284
  101146:	e8 63 f1 ff ff       	call   1002ae <panic>
  apicid = lapicid();
  10114b:	e8 d0 f5 ff ff       	call   100720 <lapicid>
  101150:	89 45 f0             	mov    %eax,-0x10(%ebp)
  for (i = 0; i < ncpu; ++i) {
  101153:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  10115a:	eb 21                	jmp    10117d <mycpu+0x53>
    if (cpus[i].apicid == apicid)
  10115c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10115f:	05 b8 54 10 00       	add    $0x1054b8,%eax
  101164:	0f b6 00             	movzbl (%eax),%eax
  101167:	0f b6 c0             	movzbl %al,%eax
  10116a:	39 45 f0             	cmp    %eax,-0x10(%ebp)
  10116d:	75 0a                	jne    101179 <mycpu+0x4f>
      return &cpus[i];
  10116f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101172:	05 b8 54 10 00       	add    $0x1054b8,%eax
  101177:	eb 1b                	jmp    101194 <mycpu+0x6a>
  for (i = 0; i < ncpu; ++i) {
  101179:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  10117d:	a1 c0 54 10 00       	mov    0x1054c0,%eax
  101182:	39 45 f4             	cmp    %eax,-0xc(%ebp)
  101185:	7c d5                	jl     10115c <mycpu+0x32>
  panic("unknown apicid\n");
  101187:	83 ec 0c             	sub    $0xc,%esp
  10118a:	68 aa 42 10 00       	push   $0x1042aa
  10118f:	e8 1a f1 ff ff       	call   1002ae <panic>
  101194:	c9                   	leave
  101195:	c3                   	ret

00101196 <getcallerpcs>:
// #include "memlayout.h"

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
  101196:	55                   	push   %ebp
  101197:	89 e5                	mov    %esp,%ebp
  101199:	83 ec 10             	sub    $0x10,%esp
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  10119c:	8b 45 08             	mov    0x8(%ebp),%eax
  10119f:	83 e8 08             	sub    $0x8,%eax
  1011a2:	89 45 fc             	mov    %eax,-0x4(%ebp)
  for(i = 0; i < 10; i++){
  1011a5:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  1011ac:	eb 2f                	jmp    1011dd <getcallerpcs+0x47>
    // if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
    if(ebp == 0 || ebp == (uint*)0xffffffff)
  1011ae:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  1011b2:	74 4a                	je     1011fe <getcallerpcs+0x68>
  1011b4:	83 7d fc ff          	cmpl   $0xffffffff,-0x4(%ebp)
  1011b8:	74 44                	je     1011fe <getcallerpcs+0x68>
      break;
    pcs[i] = ebp[1];     // saved %eip
  1011ba:	8b 45 f8             	mov    -0x8(%ebp),%eax
  1011bd:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  1011c4:	8b 45 0c             	mov    0xc(%ebp),%eax
  1011c7:	01 c2                	add    %eax,%edx
  1011c9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1011cc:	8b 40 04             	mov    0x4(%eax),%eax
  1011cf:	89 02                	mov    %eax,(%edx)
    ebp = (uint*)ebp[0]; // saved %ebp
  1011d1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1011d4:	8b 00                	mov    (%eax),%eax
  1011d6:	89 45 fc             	mov    %eax,-0x4(%ebp)
  for(i = 0; i < 10; i++){
  1011d9:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
  1011dd:	83 7d f8 09          	cmpl   $0x9,-0x8(%ebp)
  1011e1:	7e cb                	jle    1011ae <getcallerpcs+0x18>
  }
  for(; i < 10; i++)
  1011e3:	eb 19                	jmp    1011fe <getcallerpcs+0x68>
    pcs[i] = 0;
  1011e5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  1011e8:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  1011ef:	8b 45 0c             	mov    0xc(%ebp),%eax
  1011f2:	01 d0                	add    %edx,%eax
  1011f4:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
  1011fa:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
  1011fe:	83 7d f8 09          	cmpl   $0x9,-0x8(%ebp)
  101202:	7e e1                	jle    1011e5 <getcallerpcs+0x4f>
  101204:	90                   	nop
  101205:	90                   	nop
  101206:	c9                   	leave
  101207:	c3                   	ret

00101208 <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushal
  101208:	60                   	pusha
  
  # Call trap(tf), where tf=%esp
  pushl %esp
  101209:	54                   	push   %esp
  call trap
  10120a:	e8 41 01 00 00       	call   101350 <trap>
  addl $4, %esp
  10120f:	83 c4 04             	add    $0x4,%esp

00101212 <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
  101212:	61                   	popa
  addl $0x8, %esp  # trapno and errcode
  101213:	83 c4 08             	add    $0x8,%esp
  iret
  101216:	cf                   	iret

00101217 <lidt>:
  101217:	55                   	push   %ebp
  101218:	89 e5                	mov    %esp,%ebp
  10121a:	83 ec 10             	sub    $0x10,%esp
  10121d:	8b 45 0c             	mov    0xc(%ebp),%eax
  101220:	83 e8 01             	sub    $0x1,%eax
  101223:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  101227:	8b 45 08             	mov    0x8(%ebp),%eax
  10122a:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  10122e:	8b 45 08             	mov    0x8(%ebp),%eax
  101231:	c1 e8 10             	shr    $0x10,%eax
  101234:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  101238:	8d 45 fa             	lea    -0x6(%ebp),%eax
  10123b:	0f 01 18             	lidtl  (%eax)
  10123e:	90                   	nop
  10123f:	c9                   	leave
  101240:	c3                   	ret

00101241 <rcr2>:
  101241:	55                   	push   %ebp
  101242:	89 e5                	mov    %esp,%ebp
  101244:	83 ec 10             	sub    $0x10,%esp
  101247:	0f 20 d0             	mov    %cr2,%eax
  10124a:	89 45 fc             	mov    %eax,-0x4(%ebp)
  10124d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101250:	c9                   	leave
  101251:	c3                   	ret

00101252 <tvinit>:
{
  101252:	55                   	push   %ebp
  101253:	89 e5                	mov    %esp,%ebp
  101255:	83 ec 10             	sub    $0x10,%esp
  for(i = 0; i < 256; i++)
  101258:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  10125f:	e9 c3 00 00 00       	jmp    101327 <tvinit+0xd5>
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  101264:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101267:	8b 04 85 11 50 10 00 	mov    0x105011(,%eax,4),%eax
  10126e:	89 c2                	mov    %eax,%edx
  101270:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101273:	66 89 14 c5 e0 54 10 	mov    %dx,0x1054e0(,%eax,8)
  10127a:	00 
  10127b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  10127e:	66 c7 04 c5 e2 54 10 	movw   $0x8,0x1054e2(,%eax,8)
  101285:	00 08 00 
  101288:	8b 45 fc             	mov    -0x4(%ebp),%eax
  10128b:	0f b6 14 c5 e4 54 10 	movzbl 0x1054e4(,%eax,8),%edx
  101292:	00 
  101293:	83 e2 e0             	and    $0xffffffe0,%edx
  101296:	88 14 c5 e4 54 10 00 	mov    %dl,0x1054e4(,%eax,8)
  10129d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1012a0:	0f b6 14 c5 e4 54 10 	movzbl 0x1054e4(,%eax,8),%edx
  1012a7:	00 
  1012a8:	83 e2 1f             	and    $0x1f,%edx
  1012ab:	88 14 c5 e4 54 10 00 	mov    %dl,0x1054e4(,%eax,8)
  1012b2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1012b5:	0f b6 14 c5 e5 54 10 	movzbl 0x1054e5(,%eax,8),%edx
  1012bc:	00 
  1012bd:	83 e2 f0             	and    $0xfffffff0,%edx
  1012c0:	83 ca 0e             	or     $0xe,%edx
  1012c3:	88 14 c5 e5 54 10 00 	mov    %dl,0x1054e5(,%eax,8)
  1012ca:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1012cd:	0f b6 14 c5 e5 54 10 	movzbl 0x1054e5(,%eax,8),%edx
  1012d4:	00 
  1012d5:	83 e2 ef             	and    $0xffffffef,%edx
  1012d8:	88 14 c5 e5 54 10 00 	mov    %dl,0x1054e5(,%eax,8)
  1012df:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1012e2:	0f b6 14 c5 e5 54 10 	movzbl 0x1054e5(,%eax,8),%edx
  1012e9:	00 
  1012ea:	83 e2 9f             	and    $0xffffff9f,%edx
  1012ed:	88 14 c5 e5 54 10 00 	mov    %dl,0x1054e5(,%eax,8)
  1012f4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1012f7:	0f b6 14 c5 e5 54 10 	movzbl 0x1054e5(,%eax,8),%edx
  1012fe:	00 
  1012ff:	83 ca 80             	or     $0xffffff80,%edx
  101302:	88 14 c5 e5 54 10 00 	mov    %dl,0x1054e5(,%eax,8)
  101309:	8b 45 fc             	mov    -0x4(%ebp),%eax
  10130c:	8b 04 85 11 50 10 00 	mov    0x105011(,%eax,4),%eax
  101313:	c1 e8 10             	shr    $0x10,%eax
  101316:	89 c2                	mov    %eax,%edx
  101318:	8b 45 fc             	mov    -0x4(%ebp),%eax
  10131b:	66 89 14 c5 e6 54 10 	mov    %dx,0x1054e6(,%eax,8)
  101322:	00 
  for(i = 0; i < 256; i++)
  101323:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  101327:	81 7d fc ff 00 00 00 	cmpl   $0xff,-0x4(%ebp)
  10132e:	0f 8e 30 ff ff ff    	jle    101264 <tvinit+0x12>
}
  101334:	90                   	nop
  101335:	90                   	nop
  101336:	c9                   	leave
  101337:	c3                   	ret

00101338 <idtinit>:
{
  101338:	55                   	push   %ebp
  101339:	89 e5                	mov    %esp,%ebp
  lidt(idt, sizeof(idt));
  10133b:	68 00 08 00 00       	push   $0x800
  101340:	68 e0 54 10 00       	push   $0x1054e0
  101345:	e8 cd fe ff ff       	call   101217 <lidt>
  10134a:	83 c4 08             	add    $0x8,%esp
}
  10134d:	90                   	nop
  10134e:	c9                   	leave
  10134f:	c3                   	ret

00101350 <trap>:
{
  101350:	55                   	push   %ebp
  101351:	89 e5                	mov    %esp,%ebp
  101353:	56                   	push   %esi
  101354:	53                   	push   %ebx
  switch(tf->trapno){
  101355:	8b 45 08             	mov    0x8(%ebp),%eax
  101358:	8b 40 20             	mov    0x20(%eax),%eax
  10135b:	83 e8 20             	sub    $0x20,%eax
  10135e:	83 f8 1f             	cmp    $0x1f,%eax
  101361:	77 61                	ja     1013c4 <trap+0x74>
  101363:	8b 04 85 18 43 10 00 	mov    0x104318(,%eax,4),%eax
  10136a:	ff e0                	jmp    *%eax
    ticks++;
  10136c:	a1 e0 5c 10 00       	mov    0x105ce0,%eax
  101371:	83 c0 01             	add    $0x1,%eax
  101374:	a3 e0 5c 10 00       	mov    %eax,0x105ce0
    lapiceoi();
  101379:	e8 c4 f3 ff ff       	call   100742 <lapiceoi>
    break;
  10137e:	eb 7d                	jmp    1013fd <trap+0xad>
    ideintr();
  101380:	e8 43 10 00 00       	call   1023c8 <ideintr>
    lapiceoi();
  101385:	e8 b8 f3 ff ff       	call   100742 <lapiceoi>
    break;
  10138a:	eb 71                	jmp    1013fd <trap+0xad>
    uartintr();
  10138c:	e8 9d fa ff ff       	call   100e2e <uartintr>
    lapiceoi();
  101391:	e8 ac f3 ff ff       	call   100742 <lapiceoi>
    break;
  101396:	eb 65                	jmp    1013fd <trap+0xad>
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
  101398:	8b 45 08             	mov    0x8(%ebp),%eax
  10139b:	8b 70 28             	mov    0x28(%eax),%esi
            cpuid(), tf->cs, tf->eip);
  10139e:	8b 45 08             	mov    0x8(%ebp),%eax
  1013a1:	0f b7 40 2c          	movzwl 0x2c(%eax),%eax
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
  1013a5:	0f b7 d8             	movzwl %ax,%ebx
  1013a8:	e8 6b fd ff ff       	call   101118 <cpuid>
  1013ad:	56                   	push   %esi
  1013ae:	53                   	push   %ebx
  1013af:	50                   	push   %eax
  1013b0:	68 bc 42 10 00       	push   $0x1042bc
  1013b5:	e8 32 ed ff ff       	call   1000ec <cprintf>
  1013ba:	83 c4 10             	add    $0x10,%esp
    lapiceoi();
  1013bd:	e8 80 f3 ff ff       	call   100742 <lapiceoi>
    break;
  1013c2:	eb 39                	jmp    1013fd <trap+0xad>
    cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
  1013c4:	e8 78 fe ff ff       	call   101241 <rcr2>
  1013c9:	89 c3                	mov    %eax,%ebx
  1013cb:	8b 45 08             	mov    0x8(%ebp),%eax
  1013ce:	8b 70 28             	mov    0x28(%eax),%esi
  1013d1:	e8 42 fd ff ff       	call   101118 <cpuid>
  1013d6:	8b 55 08             	mov    0x8(%ebp),%edx
  1013d9:	8b 52 20             	mov    0x20(%edx),%edx
  1013dc:	83 ec 0c             	sub    $0xc,%esp
  1013df:	53                   	push   %ebx
  1013e0:	56                   	push   %esi
  1013e1:	50                   	push   %eax
  1013e2:	52                   	push   %edx
  1013e3:	68 e0 42 10 00       	push   $0x1042e0
  1013e8:	e8 ff ec ff ff       	call   1000ec <cprintf>
  1013ed:	83 c4 20             	add    $0x20,%esp
    panic("trap");
  1013f0:	83 ec 0c             	sub    $0xc,%esp
  1013f3:	68 12 43 10 00       	push   $0x104312
  1013f8:	e8 b1 ee ff ff       	call   1002ae <panic>
}
  1013fd:	90                   	nop
  1013fe:	8d 65 f8             	lea    -0x8(%ebp),%esp
  101401:	5b                   	pop    %ebx
  101402:	5e                   	pop    %esi
  101403:	5d                   	pop    %ebp
  101404:	c3                   	ret

00101405 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
  101405:	6a 00                	push   $0x0
  pushl $0
  101407:	6a 00                	push   $0x0
  jmp alltraps
  101409:	e9 fa fd ff ff       	jmp    101208 <alltraps>

0010140e <vector1>:
.globl vector1
vector1:
  pushl $0
  10140e:	6a 00                	push   $0x0
  pushl $1
  101410:	6a 01                	push   $0x1
  jmp alltraps
  101412:	e9 f1 fd ff ff       	jmp    101208 <alltraps>

00101417 <vector2>:
.globl vector2
vector2:
  pushl $0
  101417:	6a 00                	push   $0x0
  pushl $2
  101419:	6a 02                	push   $0x2
  jmp alltraps
  10141b:	e9 e8 fd ff ff       	jmp    101208 <alltraps>

00101420 <vector3>:
.globl vector3
vector3:
  pushl $0
  101420:	6a 00                	push   $0x0
  pushl $3
  101422:	6a 03                	push   $0x3
  jmp alltraps
  101424:	e9 df fd ff ff       	jmp    101208 <alltraps>

00101429 <vector4>:
.globl vector4
vector4:
  pushl $0
  101429:	6a 00                	push   $0x0
  pushl $4
  10142b:	6a 04                	push   $0x4
  jmp alltraps
  10142d:	e9 d6 fd ff ff       	jmp    101208 <alltraps>

00101432 <vector5>:
.globl vector5
vector5:
  pushl $0
  101432:	6a 00                	push   $0x0
  pushl $5
  101434:	6a 05                	push   $0x5
  jmp alltraps
  101436:	e9 cd fd ff ff       	jmp    101208 <alltraps>

0010143b <vector6>:
.globl vector6
vector6:
  pushl $0
  10143b:	6a 00                	push   $0x0
  pushl $6
  10143d:	6a 06                	push   $0x6
  jmp alltraps
  10143f:	e9 c4 fd ff ff       	jmp    101208 <alltraps>

00101444 <vector7>:
.globl vector7
vector7:
  pushl $0
  101444:	6a 00                	push   $0x0
  pushl $7
  101446:	6a 07                	push   $0x7
  jmp alltraps
  101448:	e9 bb fd ff ff       	jmp    101208 <alltraps>

0010144d <vector8>:
.globl vector8
vector8:
  pushl $8
  10144d:	6a 08                	push   $0x8
  jmp alltraps
  10144f:	e9 b4 fd ff ff       	jmp    101208 <alltraps>

00101454 <vector9>:
.globl vector9
vector9:
  pushl $0
  101454:	6a 00                	push   $0x0
  pushl $9
  101456:	6a 09                	push   $0x9
  jmp alltraps
  101458:	e9 ab fd ff ff       	jmp    101208 <alltraps>

0010145d <vector10>:
.globl vector10
vector10:
  pushl $10
  10145d:	6a 0a                	push   $0xa
  jmp alltraps
  10145f:	e9 a4 fd ff ff       	jmp    101208 <alltraps>

00101464 <vector11>:
.globl vector11
vector11:
  pushl $11
  101464:	6a 0b                	push   $0xb
  jmp alltraps
  101466:	e9 9d fd ff ff       	jmp    101208 <alltraps>

0010146b <vector12>:
.globl vector12
vector12:
  pushl $12
  10146b:	6a 0c                	push   $0xc
  jmp alltraps
  10146d:	e9 96 fd ff ff       	jmp    101208 <alltraps>

00101472 <vector13>:
.globl vector13
vector13:
  pushl $13
  101472:	6a 0d                	push   $0xd
  jmp alltraps
  101474:	e9 8f fd ff ff       	jmp    101208 <alltraps>

00101479 <vector14>:
.globl vector14
vector14:
  pushl $14
  101479:	6a 0e                	push   $0xe
  jmp alltraps
  10147b:	e9 88 fd ff ff       	jmp    101208 <alltraps>

00101480 <vector15>:
.globl vector15
vector15:
  pushl $0
  101480:	6a 00                	push   $0x0
  pushl $15
  101482:	6a 0f                	push   $0xf
  jmp alltraps
  101484:	e9 7f fd ff ff       	jmp    101208 <alltraps>

00101489 <vector16>:
.globl vector16
vector16:
  pushl $0
  101489:	6a 00                	push   $0x0
  pushl $16
  10148b:	6a 10                	push   $0x10
  jmp alltraps
  10148d:	e9 76 fd ff ff       	jmp    101208 <alltraps>

00101492 <vector17>:
.globl vector17
vector17:
  pushl $17
  101492:	6a 11                	push   $0x11
  jmp alltraps
  101494:	e9 6f fd ff ff       	jmp    101208 <alltraps>

00101499 <vector18>:
.globl vector18
vector18:
  pushl $0
  101499:	6a 00                	push   $0x0
  pushl $18
  10149b:	6a 12                	push   $0x12
  jmp alltraps
  10149d:	e9 66 fd ff ff       	jmp    101208 <alltraps>

001014a2 <vector19>:
.globl vector19
vector19:
  pushl $0
  1014a2:	6a 00                	push   $0x0
  pushl $19
  1014a4:	6a 13                	push   $0x13
  jmp alltraps
  1014a6:	e9 5d fd ff ff       	jmp    101208 <alltraps>

001014ab <vector20>:
.globl vector20
vector20:
  pushl $0
  1014ab:	6a 00                	push   $0x0
  pushl $20
  1014ad:	6a 14                	push   $0x14
  jmp alltraps
  1014af:	e9 54 fd ff ff       	jmp    101208 <alltraps>

001014b4 <vector21>:
.globl vector21
vector21:
  pushl $0
  1014b4:	6a 00                	push   $0x0
  pushl $21
  1014b6:	6a 15                	push   $0x15
  jmp alltraps
  1014b8:	e9 4b fd ff ff       	jmp    101208 <alltraps>

001014bd <vector22>:
.globl vector22
vector22:
  pushl $0
  1014bd:	6a 00                	push   $0x0
  pushl $22
  1014bf:	6a 16                	push   $0x16
  jmp alltraps
  1014c1:	e9 42 fd ff ff       	jmp    101208 <alltraps>

001014c6 <vector23>:
.globl vector23
vector23:
  pushl $0
  1014c6:	6a 00                	push   $0x0
  pushl $23
  1014c8:	6a 17                	push   $0x17
  jmp alltraps
  1014ca:	e9 39 fd ff ff       	jmp    101208 <alltraps>

001014cf <vector24>:
.globl vector24
vector24:
  pushl $0
  1014cf:	6a 00                	push   $0x0
  pushl $24
  1014d1:	6a 18                	push   $0x18
  jmp alltraps
  1014d3:	e9 30 fd ff ff       	jmp    101208 <alltraps>

001014d8 <vector25>:
.globl vector25
vector25:
  pushl $0
  1014d8:	6a 00                	push   $0x0
  pushl $25
  1014da:	6a 19                	push   $0x19
  jmp alltraps
  1014dc:	e9 27 fd ff ff       	jmp    101208 <alltraps>

001014e1 <vector26>:
.globl vector26
vector26:
  pushl $0
  1014e1:	6a 00                	push   $0x0
  pushl $26
  1014e3:	6a 1a                	push   $0x1a
  jmp alltraps
  1014e5:	e9 1e fd ff ff       	jmp    101208 <alltraps>

001014ea <vector27>:
.globl vector27
vector27:
  pushl $0
  1014ea:	6a 00                	push   $0x0
  pushl $27
  1014ec:	6a 1b                	push   $0x1b
  jmp alltraps
  1014ee:	e9 15 fd ff ff       	jmp    101208 <alltraps>

001014f3 <vector28>:
.globl vector28
vector28:
  pushl $0
  1014f3:	6a 00                	push   $0x0
  pushl $28
  1014f5:	6a 1c                	push   $0x1c
  jmp alltraps
  1014f7:	e9 0c fd ff ff       	jmp    101208 <alltraps>

001014fc <vector29>:
.globl vector29
vector29:
  pushl $0
  1014fc:	6a 00                	push   $0x0
  pushl $29
  1014fe:	6a 1d                	push   $0x1d
  jmp alltraps
  101500:	e9 03 fd ff ff       	jmp    101208 <alltraps>

00101505 <vector30>:
.globl vector30
vector30:
  pushl $0
  101505:	6a 00                	push   $0x0
  pushl $30
  101507:	6a 1e                	push   $0x1e
  jmp alltraps
  101509:	e9 fa fc ff ff       	jmp    101208 <alltraps>

0010150e <vector31>:
.globl vector31
vector31:
  pushl $0
  10150e:	6a 00                	push   $0x0
  pushl $31
  101510:	6a 1f                	push   $0x1f
  jmp alltraps
  101512:	e9 f1 fc ff ff       	jmp    101208 <alltraps>

00101517 <vector32>:
.globl vector32
vector32:
  pushl $0
  101517:	6a 00                	push   $0x0
  pushl $32
  101519:	6a 20                	push   $0x20
  jmp alltraps
  10151b:	e9 e8 fc ff ff       	jmp    101208 <alltraps>

00101520 <vector33>:
.globl vector33
vector33:
  pushl $0
  101520:	6a 00                	push   $0x0
  pushl $33
  101522:	6a 21                	push   $0x21
  jmp alltraps
  101524:	e9 df fc ff ff       	jmp    101208 <alltraps>

00101529 <vector34>:
.globl vector34
vector34:
  pushl $0
  101529:	6a 00                	push   $0x0
  pushl $34
  10152b:	6a 22                	push   $0x22
  jmp alltraps
  10152d:	e9 d6 fc ff ff       	jmp    101208 <alltraps>

00101532 <vector35>:
.globl vector35
vector35:
  pushl $0
  101532:	6a 00                	push   $0x0
  pushl $35
  101534:	6a 23                	push   $0x23
  jmp alltraps
  101536:	e9 cd fc ff ff       	jmp    101208 <alltraps>

0010153b <vector36>:
.globl vector36
vector36:
  pushl $0
  10153b:	6a 00                	push   $0x0
  pushl $36
  10153d:	6a 24                	push   $0x24
  jmp alltraps
  10153f:	e9 c4 fc ff ff       	jmp    101208 <alltraps>

00101544 <vector37>:
.globl vector37
vector37:
  pushl $0
  101544:	6a 00                	push   $0x0
  pushl $37
  101546:	6a 25                	push   $0x25
  jmp alltraps
  101548:	e9 bb fc ff ff       	jmp    101208 <alltraps>

0010154d <vector38>:
.globl vector38
vector38:
  pushl $0
  10154d:	6a 00                	push   $0x0
  pushl $38
  10154f:	6a 26                	push   $0x26
  jmp alltraps
  101551:	e9 b2 fc ff ff       	jmp    101208 <alltraps>

00101556 <vector39>:
.globl vector39
vector39:
  pushl $0
  101556:	6a 00                	push   $0x0
  pushl $39
  101558:	6a 27                	push   $0x27
  jmp alltraps
  10155a:	e9 a9 fc ff ff       	jmp    101208 <alltraps>

0010155f <vector40>:
.globl vector40
vector40:
  pushl $0
  10155f:	6a 00                	push   $0x0
  pushl $40
  101561:	6a 28                	push   $0x28
  jmp alltraps
  101563:	e9 a0 fc ff ff       	jmp    101208 <alltraps>

00101568 <vector41>:
.globl vector41
vector41:
  pushl $0
  101568:	6a 00                	push   $0x0
  pushl $41
  10156a:	6a 29                	push   $0x29
  jmp alltraps
  10156c:	e9 97 fc ff ff       	jmp    101208 <alltraps>

00101571 <vector42>:
.globl vector42
vector42:
  pushl $0
  101571:	6a 00                	push   $0x0
  pushl $42
  101573:	6a 2a                	push   $0x2a
  jmp alltraps
  101575:	e9 8e fc ff ff       	jmp    101208 <alltraps>

0010157a <vector43>:
.globl vector43
vector43:
  pushl $0
  10157a:	6a 00                	push   $0x0
  pushl $43
  10157c:	6a 2b                	push   $0x2b
  jmp alltraps
  10157e:	e9 85 fc ff ff       	jmp    101208 <alltraps>

00101583 <vector44>:
.globl vector44
vector44:
  pushl $0
  101583:	6a 00                	push   $0x0
  pushl $44
  101585:	6a 2c                	push   $0x2c
  jmp alltraps
  101587:	e9 7c fc ff ff       	jmp    101208 <alltraps>

0010158c <vector45>:
.globl vector45
vector45:
  pushl $0
  10158c:	6a 00                	push   $0x0
  pushl $45
  10158e:	6a 2d                	push   $0x2d
  jmp alltraps
  101590:	e9 73 fc ff ff       	jmp    101208 <alltraps>

00101595 <vector46>:
.globl vector46
vector46:
  pushl $0
  101595:	6a 00                	push   $0x0
  pushl $46
  101597:	6a 2e                	push   $0x2e
  jmp alltraps
  101599:	e9 6a fc ff ff       	jmp    101208 <alltraps>

0010159e <vector47>:
.globl vector47
vector47:
  pushl $0
  10159e:	6a 00                	push   $0x0
  pushl $47
  1015a0:	6a 2f                	push   $0x2f
  jmp alltraps
  1015a2:	e9 61 fc ff ff       	jmp    101208 <alltraps>

001015a7 <vector48>:
.globl vector48
vector48:
  pushl $0
  1015a7:	6a 00                	push   $0x0
  pushl $48
  1015a9:	6a 30                	push   $0x30
  jmp alltraps
  1015ab:	e9 58 fc ff ff       	jmp    101208 <alltraps>

001015b0 <vector49>:
.globl vector49
vector49:
  pushl $0
  1015b0:	6a 00                	push   $0x0
  pushl $49
  1015b2:	6a 31                	push   $0x31
  jmp alltraps
  1015b4:	e9 4f fc ff ff       	jmp    101208 <alltraps>

001015b9 <vector50>:
.globl vector50
vector50:
  pushl $0
  1015b9:	6a 00                	push   $0x0
  pushl $50
  1015bb:	6a 32                	push   $0x32
  jmp alltraps
  1015bd:	e9 46 fc ff ff       	jmp    101208 <alltraps>

001015c2 <vector51>:
.globl vector51
vector51:
  pushl $0
  1015c2:	6a 00                	push   $0x0
  pushl $51
  1015c4:	6a 33                	push   $0x33
  jmp alltraps
  1015c6:	e9 3d fc ff ff       	jmp    101208 <alltraps>

001015cb <vector52>:
.globl vector52
vector52:
  pushl $0
  1015cb:	6a 00                	push   $0x0
  pushl $52
  1015cd:	6a 34                	push   $0x34
  jmp alltraps
  1015cf:	e9 34 fc ff ff       	jmp    101208 <alltraps>

001015d4 <vector53>:
.globl vector53
vector53:
  pushl $0
  1015d4:	6a 00                	push   $0x0
  pushl $53
  1015d6:	6a 35                	push   $0x35
  jmp alltraps
  1015d8:	e9 2b fc ff ff       	jmp    101208 <alltraps>

001015dd <vector54>:
.globl vector54
vector54:
  pushl $0
  1015dd:	6a 00                	push   $0x0
  pushl $54
  1015df:	6a 36                	push   $0x36
  jmp alltraps
  1015e1:	e9 22 fc ff ff       	jmp    101208 <alltraps>

001015e6 <vector55>:
.globl vector55
vector55:
  pushl $0
  1015e6:	6a 00                	push   $0x0
  pushl $55
  1015e8:	6a 37                	push   $0x37
  jmp alltraps
  1015ea:	e9 19 fc ff ff       	jmp    101208 <alltraps>

001015ef <vector56>:
.globl vector56
vector56:
  pushl $0
  1015ef:	6a 00                	push   $0x0
  pushl $56
  1015f1:	6a 38                	push   $0x38
  jmp alltraps
  1015f3:	e9 10 fc ff ff       	jmp    101208 <alltraps>

001015f8 <vector57>:
.globl vector57
vector57:
  pushl $0
  1015f8:	6a 00                	push   $0x0
  pushl $57
  1015fa:	6a 39                	push   $0x39
  jmp alltraps
  1015fc:	e9 07 fc ff ff       	jmp    101208 <alltraps>

00101601 <vector58>:
.globl vector58
vector58:
  pushl $0
  101601:	6a 00                	push   $0x0
  pushl $58
  101603:	6a 3a                	push   $0x3a
  jmp alltraps
  101605:	e9 fe fb ff ff       	jmp    101208 <alltraps>

0010160a <vector59>:
.globl vector59
vector59:
  pushl $0
  10160a:	6a 00                	push   $0x0
  pushl $59
  10160c:	6a 3b                	push   $0x3b
  jmp alltraps
  10160e:	e9 f5 fb ff ff       	jmp    101208 <alltraps>

00101613 <vector60>:
.globl vector60
vector60:
  pushl $0
  101613:	6a 00                	push   $0x0
  pushl $60
  101615:	6a 3c                	push   $0x3c
  jmp alltraps
  101617:	e9 ec fb ff ff       	jmp    101208 <alltraps>

0010161c <vector61>:
.globl vector61
vector61:
  pushl $0
  10161c:	6a 00                	push   $0x0
  pushl $61
  10161e:	6a 3d                	push   $0x3d
  jmp alltraps
  101620:	e9 e3 fb ff ff       	jmp    101208 <alltraps>

00101625 <vector62>:
.globl vector62
vector62:
  pushl $0
  101625:	6a 00                	push   $0x0
  pushl $62
  101627:	6a 3e                	push   $0x3e
  jmp alltraps
  101629:	e9 da fb ff ff       	jmp    101208 <alltraps>

0010162e <vector63>:
.globl vector63
vector63:
  pushl $0
  10162e:	6a 00                	push   $0x0
  pushl $63
  101630:	6a 3f                	push   $0x3f
  jmp alltraps
  101632:	e9 d1 fb ff ff       	jmp    101208 <alltraps>

00101637 <vector64>:
.globl vector64
vector64:
  pushl $0
  101637:	6a 00                	push   $0x0
  pushl $64
  101639:	6a 40                	push   $0x40
  jmp alltraps
  10163b:	e9 c8 fb ff ff       	jmp    101208 <alltraps>

00101640 <vector65>:
.globl vector65
vector65:
  pushl $0
  101640:	6a 00                	push   $0x0
  pushl $65
  101642:	6a 41                	push   $0x41
  jmp alltraps
  101644:	e9 bf fb ff ff       	jmp    101208 <alltraps>

00101649 <vector66>:
.globl vector66
vector66:
  pushl $0
  101649:	6a 00                	push   $0x0
  pushl $66
  10164b:	6a 42                	push   $0x42
  jmp alltraps
  10164d:	e9 b6 fb ff ff       	jmp    101208 <alltraps>

00101652 <vector67>:
.globl vector67
vector67:
  pushl $0
  101652:	6a 00                	push   $0x0
  pushl $67
  101654:	6a 43                	push   $0x43
  jmp alltraps
  101656:	e9 ad fb ff ff       	jmp    101208 <alltraps>

0010165b <vector68>:
.globl vector68
vector68:
  pushl $0
  10165b:	6a 00                	push   $0x0
  pushl $68
  10165d:	6a 44                	push   $0x44
  jmp alltraps
  10165f:	e9 a4 fb ff ff       	jmp    101208 <alltraps>

00101664 <vector69>:
.globl vector69
vector69:
  pushl $0
  101664:	6a 00                	push   $0x0
  pushl $69
  101666:	6a 45                	push   $0x45
  jmp alltraps
  101668:	e9 9b fb ff ff       	jmp    101208 <alltraps>

0010166d <vector70>:
.globl vector70
vector70:
  pushl $0
  10166d:	6a 00                	push   $0x0
  pushl $70
  10166f:	6a 46                	push   $0x46
  jmp alltraps
  101671:	e9 92 fb ff ff       	jmp    101208 <alltraps>

00101676 <vector71>:
.globl vector71
vector71:
  pushl $0
  101676:	6a 00                	push   $0x0
  pushl $71
  101678:	6a 47                	push   $0x47
  jmp alltraps
  10167a:	e9 89 fb ff ff       	jmp    101208 <alltraps>

0010167f <vector72>:
.globl vector72
vector72:
  pushl $0
  10167f:	6a 00                	push   $0x0
  pushl $72
  101681:	6a 48                	push   $0x48
  jmp alltraps
  101683:	e9 80 fb ff ff       	jmp    101208 <alltraps>

00101688 <vector73>:
.globl vector73
vector73:
  pushl $0
  101688:	6a 00                	push   $0x0
  pushl $73
  10168a:	6a 49                	push   $0x49
  jmp alltraps
  10168c:	e9 77 fb ff ff       	jmp    101208 <alltraps>

00101691 <vector74>:
.globl vector74
vector74:
  pushl $0
  101691:	6a 00                	push   $0x0
  pushl $74
  101693:	6a 4a                	push   $0x4a
  jmp alltraps
  101695:	e9 6e fb ff ff       	jmp    101208 <alltraps>

0010169a <vector75>:
.globl vector75
vector75:
  pushl $0
  10169a:	6a 00                	push   $0x0
  pushl $75
  10169c:	6a 4b                	push   $0x4b
  jmp alltraps
  10169e:	e9 65 fb ff ff       	jmp    101208 <alltraps>

001016a3 <vector76>:
.globl vector76
vector76:
  pushl $0
  1016a3:	6a 00                	push   $0x0
  pushl $76
  1016a5:	6a 4c                	push   $0x4c
  jmp alltraps
  1016a7:	e9 5c fb ff ff       	jmp    101208 <alltraps>

001016ac <vector77>:
.globl vector77
vector77:
  pushl $0
  1016ac:	6a 00                	push   $0x0
  pushl $77
  1016ae:	6a 4d                	push   $0x4d
  jmp alltraps
  1016b0:	e9 53 fb ff ff       	jmp    101208 <alltraps>

001016b5 <vector78>:
.globl vector78
vector78:
  pushl $0
  1016b5:	6a 00                	push   $0x0
  pushl $78
  1016b7:	6a 4e                	push   $0x4e
  jmp alltraps
  1016b9:	e9 4a fb ff ff       	jmp    101208 <alltraps>

001016be <vector79>:
.globl vector79
vector79:
  pushl $0
  1016be:	6a 00                	push   $0x0
  pushl $79
  1016c0:	6a 4f                	push   $0x4f
  jmp alltraps
  1016c2:	e9 41 fb ff ff       	jmp    101208 <alltraps>

001016c7 <vector80>:
.globl vector80
vector80:
  pushl $0
  1016c7:	6a 00                	push   $0x0
  pushl $80
  1016c9:	6a 50                	push   $0x50
  jmp alltraps
  1016cb:	e9 38 fb ff ff       	jmp    101208 <alltraps>

001016d0 <vector81>:
.globl vector81
vector81:
  pushl $0
  1016d0:	6a 00                	push   $0x0
  pushl $81
  1016d2:	6a 51                	push   $0x51
  jmp alltraps
  1016d4:	e9 2f fb ff ff       	jmp    101208 <alltraps>

001016d9 <vector82>:
.globl vector82
vector82:
  pushl $0
  1016d9:	6a 00                	push   $0x0
  pushl $82
  1016db:	6a 52                	push   $0x52
  jmp alltraps
  1016dd:	e9 26 fb ff ff       	jmp    101208 <alltraps>

001016e2 <vector83>:
.globl vector83
vector83:
  pushl $0
  1016e2:	6a 00                	push   $0x0
  pushl $83
  1016e4:	6a 53                	push   $0x53
  jmp alltraps
  1016e6:	e9 1d fb ff ff       	jmp    101208 <alltraps>

001016eb <vector84>:
.globl vector84
vector84:
  pushl $0
  1016eb:	6a 00                	push   $0x0
  pushl $84
  1016ed:	6a 54                	push   $0x54
  jmp alltraps
  1016ef:	e9 14 fb ff ff       	jmp    101208 <alltraps>

001016f4 <vector85>:
.globl vector85
vector85:
  pushl $0
  1016f4:	6a 00                	push   $0x0
  pushl $85
  1016f6:	6a 55                	push   $0x55
  jmp alltraps
  1016f8:	e9 0b fb ff ff       	jmp    101208 <alltraps>

001016fd <vector86>:
.globl vector86
vector86:
  pushl $0
  1016fd:	6a 00                	push   $0x0
  pushl $86
  1016ff:	6a 56                	push   $0x56
  jmp alltraps
  101701:	e9 02 fb ff ff       	jmp    101208 <alltraps>

00101706 <vector87>:
.globl vector87
vector87:
  pushl $0
  101706:	6a 00                	push   $0x0
  pushl $87
  101708:	6a 57                	push   $0x57
  jmp alltraps
  10170a:	e9 f9 fa ff ff       	jmp    101208 <alltraps>

0010170f <vector88>:
.globl vector88
vector88:
  pushl $0
  10170f:	6a 00                	push   $0x0
  pushl $88
  101711:	6a 58                	push   $0x58
  jmp alltraps
  101713:	e9 f0 fa ff ff       	jmp    101208 <alltraps>

00101718 <vector89>:
.globl vector89
vector89:
  pushl $0
  101718:	6a 00                	push   $0x0
  pushl $89
  10171a:	6a 59                	push   $0x59
  jmp alltraps
  10171c:	e9 e7 fa ff ff       	jmp    101208 <alltraps>

00101721 <vector90>:
.globl vector90
vector90:
  pushl $0
  101721:	6a 00                	push   $0x0
  pushl $90
  101723:	6a 5a                	push   $0x5a
  jmp alltraps
  101725:	e9 de fa ff ff       	jmp    101208 <alltraps>

0010172a <vector91>:
.globl vector91
vector91:
  pushl $0
  10172a:	6a 00                	push   $0x0
  pushl $91
  10172c:	6a 5b                	push   $0x5b
  jmp alltraps
  10172e:	e9 d5 fa ff ff       	jmp    101208 <alltraps>

00101733 <vector92>:
.globl vector92
vector92:
  pushl $0
  101733:	6a 00                	push   $0x0
  pushl $92
  101735:	6a 5c                	push   $0x5c
  jmp alltraps
  101737:	e9 cc fa ff ff       	jmp    101208 <alltraps>

0010173c <vector93>:
.globl vector93
vector93:
  pushl $0
  10173c:	6a 00                	push   $0x0
  pushl $93
  10173e:	6a 5d                	push   $0x5d
  jmp alltraps
  101740:	e9 c3 fa ff ff       	jmp    101208 <alltraps>

00101745 <vector94>:
.globl vector94
vector94:
  pushl $0
  101745:	6a 00                	push   $0x0
  pushl $94
  101747:	6a 5e                	push   $0x5e
  jmp alltraps
  101749:	e9 ba fa ff ff       	jmp    101208 <alltraps>

0010174e <vector95>:
.globl vector95
vector95:
  pushl $0
  10174e:	6a 00                	push   $0x0
  pushl $95
  101750:	6a 5f                	push   $0x5f
  jmp alltraps
  101752:	e9 b1 fa ff ff       	jmp    101208 <alltraps>

00101757 <vector96>:
.globl vector96
vector96:
  pushl $0
  101757:	6a 00                	push   $0x0
  pushl $96
  101759:	6a 60                	push   $0x60
  jmp alltraps
  10175b:	e9 a8 fa ff ff       	jmp    101208 <alltraps>

00101760 <vector97>:
.globl vector97
vector97:
  pushl $0
  101760:	6a 00                	push   $0x0
  pushl $97
  101762:	6a 61                	push   $0x61
  jmp alltraps
  101764:	e9 9f fa ff ff       	jmp    101208 <alltraps>

00101769 <vector98>:
.globl vector98
vector98:
  pushl $0
  101769:	6a 00                	push   $0x0
  pushl $98
  10176b:	6a 62                	push   $0x62
  jmp alltraps
  10176d:	e9 96 fa ff ff       	jmp    101208 <alltraps>

00101772 <vector99>:
.globl vector99
vector99:
  pushl $0
  101772:	6a 00                	push   $0x0
  pushl $99
  101774:	6a 63                	push   $0x63
  jmp alltraps
  101776:	e9 8d fa ff ff       	jmp    101208 <alltraps>

0010177b <vector100>:
.globl vector100
vector100:
  pushl $0
  10177b:	6a 00                	push   $0x0
  pushl $100
  10177d:	6a 64                	push   $0x64
  jmp alltraps
  10177f:	e9 84 fa ff ff       	jmp    101208 <alltraps>

00101784 <vector101>:
.globl vector101
vector101:
  pushl $0
  101784:	6a 00                	push   $0x0
  pushl $101
  101786:	6a 65                	push   $0x65
  jmp alltraps
  101788:	e9 7b fa ff ff       	jmp    101208 <alltraps>

0010178d <vector102>:
.globl vector102
vector102:
  pushl $0
  10178d:	6a 00                	push   $0x0
  pushl $102
  10178f:	6a 66                	push   $0x66
  jmp alltraps
  101791:	e9 72 fa ff ff       	jmp    101208 <alltraps>

00101796 <vector103>:
.globl vector103
vector103:
  pushl $0
  101796:	6a 00                	push   $0x0
  pushl $103
  101798:	6a 67                	push   $0x67
  jmp alltraps
  10179a:	e9 69 fa ff ff       	jmp    101208 <alltraps>

0010179f <vector104>:
.globl vector104
vector104:
  pushl $0
  10179f:	6a 00                	push   $0x0
  pushl $104
  1017a1:	6a 68                	push   $0x68
  jmp alltraps
  1017a3:	e9 60 fa ff ff       	jmp    101208 <alltraps>

001017a8 <vector105>:
.globl vector105
vector105:
  pushl $0
  1017a8:	6a 00                	push   $0x0
  pushl $105
  1017aa:	6a 69                	push   $0x69
  jmp alltraps
  1017ac:	e9 57 fa ff ff       	jmp    101208 <alltraps>

001017b1 <vector106>:
.globl vector106
vector106:
  pushl $0
  1017b1:	6a 00                	push   $0x0
  pushl $106
  1017b3:	6a 6a                	push   $0x6a
  jmp alltraps
  1017b5:	e9 4e fa ff ff       	jmp    101208 <alltraps>

001017ba <vector107>:
.globl vector107
vector107:
  pushl $0
  1017ba:	6a 00                	push   $0x0
  pushl $107
  1017bc:	6a 6b                	push   $0x6b
  jmp alltraps
  1017be:	e9 45 fa ff ff       	jmp    101208 <alltraps>

001017c3 <vector108>:
.globl vector108
vector108:
  pushl $0
  1017c3:	6a 00                	push   $0x0
  pushl $108
  1017c5:	6a 6c                	push   $0x6c
  jmp alltraps
  1017c7:	e9 3c fa ff ff       	jmp    101208 <alltraps>

001017cc <vector109>:
.globl vector109
vector109:
  pushl $0
  1017cc:	6a 00                	push   $0x0
  pushl $109
  1017ce:	6a 6d                	push   $0x6d
  jmp alltraps
  1017d0:	e9 33 fa ff ff       	jmp    101208 <alltraps>

001017d5 <vector110>:
.globl vector110
vector110:
  pushl $0
  1017d5:	6a 00                	push   $0x0
  pushl $110
  1017d7:	6a 6e                	push   $0x6e
  jmp alltraps
  1017d9:	e9 2a fa ff ff       	jmp    101208 <alltraps>

001017de <vector111>:
.globl vector111
vector111:
  pushl $0
  1017de:	6a 00                	push   $0x0
  pushl $111
  1017e0:	6a 6f                	push   $0x6f
  jmp alltraps
  1017e2:	e9 21 fa ff ff       	jmp    101208 <alltraps>

001017e7 <vector112>:
.globl vector112
vector112:
  pushl $0
  1017e7:	6a 00                	push   $0x0
  pushl $112
  1017e9:	6a 70                	push   $0x70
  jmp alltraps
  1017eb:	e9 18 fa ff ff       	jmp    101208 <alltraps>

001017f0 <vector113>:
.globl vector113
vector113:
  pushl $0
  1017f0:	6a 00                	push   $0x0
  pushl $113
  1017f2:	6a 71                	push   $0x71
  jmp alltraps
  1017f4:	e9 0f fa ff ff       	jmp    101208 <alltraps>

001017f9 <vector114>:
.globl vector114
vector114:
  pushl $0
  1017f9:	6a 00                	push   $0x0
  pushl $114
  1017fb:	6a 72                	push   $0x72
  jmp alltraps
  1017fd:	e9 06 fa ff ff       	jmp    101208 <alltraps>

00101802 <vector115>:
.globl vector115
vector115:
  pushl $0
  101802:	6a 00                	push   $0x0
  pushl $115
  101804:	6a 73                	push   $0x73
  jmp alltraps
  101806:	e9 fd f9 ff ff       	jmp    101208 <alltraps>

0010180b <vector116>:
.globl vector116
vector116:
  pushl $0
  10180b:	6a 00                	push   $0x0
  pushl $116
  10180d:	6a 74                	push   $0x74
  jmp alltraps
  10180f:	e9 f4 f9 ff ff       	jmp    101208 <alltraps>

00101814 <vector117>:
.globl vector117
vector117:
  pushl $0
  101814:	6a 00                	push   $0x0
  pushl $117
  101816:	6a 75                	push   $0x75
  jmp alltraps
  101818:	e9 eb f9 ff ff       	jmp    101208 <alltraps>

0010181d <vector118>:
.globl vector118
vector118:
  pushl $0
  10181d:	6a 00                	push   $0x0
  pushl $118
  10181f:	6a 76                	push   $0x76
  jmp alltraps
  101821:	e9 e2 f9 ff ff       	jmp    101208 <alltraps>

00101826 <vector119>:
.globl vector119
vector119:
  pushl $0
  101826:	6a 00                	push   $0x0
  pushl $119
  101828:	6a 77                	push   $0x77
  jmp alltraps
  10182a:	e9 d9 f9 ff ff       	jmp    101208 <alltraps>

0010182f <vector120>:
.globl vector120
vector120:
  pushl $0
  10182f:	6a 00                	push   $0x0
  pushl $120
  101831:	6a 78                	push   $0x78
  jmp alltraps
  101833:	e9 d0 f9 ff ff       	jmp    101208 <alltraps>

00101838 <vector121>:
.globl vector121
vector121:
  pushl $0
  101838:	6a 00                	push   $0x0
  pushl $121
  10183a:	6a 79                	push   $0x79
  jmp alltraps
  10183c:	e9 c7 f9 ff ff       	jmp    101208 <alltraps>

00101841 <vector122>:
.globl vector122
vector122:
  pushl $0
  101841:	6a 00                	push   $0x0
  pushl $122
  101843:	6a 7a                	push   $0x7a
  jmp alltraps
  101845:	e9 be f9 ff ff       	jmp    101208 <alltraps>

0010184a <vector123>:
.globl vector123
vector123:
  pushl $0
  10184a:	6a 00                	push   $0x0
  pushl $123
  10184c:	6a 7b                	push   $0x7b
  jmp alltraps
  10184e:	e9 b5 f9 ff ff       	jmp    101208 <alltraps>

00101853 <vector124>:
.globl vector124
vector124:
  pushl $0
  101853:	6a 00                	push   $0x0
  pushl $124
  101855:	6a 7c                	push   $0x7c
  jmp alltraps
  101857:	e9 ac f9 ff ff       	jmp    101208 <alltraps>

0010185c <vector125>:
.globl vector125
vector125:
  pushl $0
  10185c:	6a 00                	push   $0x0
  pushl $125
  10185e:	6a 7d                	push   $0x7d
  jmp alltraps
  101860:	e9 a3 f9 ff ff       	jmp    101208 <alltraps>

00101865 <vector126>:
.globl vector126
vector126:
  pushl $0
  101865:	6a 00                	push   $0x0
  pushl $126
  101867:	6a 7e                	push   $0x7e
  jmp alltraps
  101869:	e9 9a f9 ff ff       	jmp    101208 <alltraps>

0010186e <vector127>:
.globl vector127
vector127:
  pushl $0
  10186e:	6a 00                	push   $0x0
  pushl $127
  101870:	6a 7f                	push   $0x7f
  jmp alltraps
  101872:	e9 91 f9 ff ff       	jmp    101208 <alltraps>

00101877 <vector128>:
.globl vector128
vector128:
  pushl $0
  101877:	6a 00                	push   $0x0
  pushl $128
  101879:	68 80 00 00 00       	push   $0x80
  jmp alltraps
  10187e:	e9 85 f9 ff ff       	jmp    101208 <alltraps>

00101883 <vector129>:
.globl vector129
vector129:
  pushl $0
  101883:	6a 00                	push   $0x0
  pushl $129
  101885:	68 81 00 00 00       	push   $0x81
  jmp alltraps
  10188a:	e9 79 f9 ff ff       	jmp    101208 <alltraps>

0010188f <vector130>:
.globl vector130
vector130:
  pushl $0
  10188f:	6a 00                	push   $0x0
  pushl $130
  101891:	68 82 00 00 00       	push   $0x82
  jmp alltraps
  101896:	e9 6d f9 ff ff       	jmp    101208 <alltraps>

0010189b <vector131>:
.globl vector131
vector131:
  pushl $0
  10189b:	6a 00                	push   $0x0
  pushl $131
  10189d:	68 83 00 00 00       	push   $0x83
  jmp alltraps
  1018a2:	e9 61 f9 ff ff       	jmp    101208 <alltraps>

001018a7 <vector132>:
.globl vector132
vector132:
  pushl $0
  1018a7:	6a 00                	push   $0x0
  pushl $132
  1018a9:	68 84 00 00 00       	push   $0x84
  jmp alltraps
  1018ae:	e9 55 f9 ff ff       	jmp    101208 <alltraps>

001018b3 <vector133>:
.globl vector133
vector133:
  pushl $0
  1018b3:	6a 00                	push   $0x0
  pushl $133
  1018b5:	68 85 00 00 00       	push   $0x85
  jmp alltraps
  1018ba:	e9 49 f9 ff ff       	jmp    101208 <alltraps>

001018bf <vector134>:
.globl vector134
vector134:
  pushl $0
  1018bf:	6a 00                	push   $0x0
  pushl $134
  1018c1:	68 86 00 00 00       	push   $0x86
  jmp alltraps
  1018c6:	e9 3d f9 ff ff       	jmp    101208 <alltraps>

001018cb <vector135>:
.globl vector135
vector135:
  pushl $0
  1018cb:	6a 00                	push   $0x0
  pushl $135
  1018cd:	68 87 00 00 00       	push   $0x87
  jmp alltraps
  1018d2:	e9 31 f9 ff ff       	jmp    101208 <alltraps>

001018d7 <vector136>:
.globl vector136
vector136:
  pushl $0
  1018d7:	6a 00                	push   $0x0
  pushl $136
  1018d9:	68 88 00 00 00       	push   $0x88
  jmp alltraps
  1018de:	e9 25 f9 ff ff       	jmp    101208 <alltraps>

001018e3 <vector137>:
.globl vector137
vector137:
  pushl $0
  1018e3:	6a 00                	push   $0x0
  pushl $137
  1018e5:	68 89 00 00 00       	push   $0x89
  jmp alltraps
  1018ea:	e9 19 f9 ff ff       	jmp    101208 <alltraps>

001018ef <vector138>:
.globl vector138
vector138:
  pushl $0
  1018ef:	6a 00                	push   $0x0
  pushl $138
  1018f1:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
  1018f6:	e9 0d f9 ff ff       	jmp    101208 <alltraps>

001018fb <vector139>:
.globl vector139
vector139:
  pushl $0
  1018fb:	6a 00                	push   $0x0
  pushl $139
  1018fd:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
  101902:	e9 01 f9 ff ff       	jmp    101208 <alltraps>

00101907 <vector140>:
.globl vector140
vector140:
  pushl $0
  101907:	6a 00                	push   $0x0
  pushl $140
  101909:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
  10190e:	e9 f5 f8 ff ff       	jmp    101208 <alltraps>

00101913 <vector141>:
.globl vector141
vector141:
  pushl $0
  101913:	6a 00                	push   $0x0
  pushl $141
  101915:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
  10191a:	e9 e9 f8 ff ff       	jmp    101208 <alltraps>

0010191f <vector142>:
.globl vector142
vector142:
  pushl $0
  10191f:	6a 00                	push   $0x0
  pushl $142
  101921:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
  101926:	e9 dd f8 ff ff       	jmp    101208 <alltraps>

0010192b <vector143>:
.globl vector143
vector143:
  pushl $0
  10192b:	6a 00                	push   $0x0
  pushl $143
  10192d:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
  101932:	e9 d1 f8 ff ff       	jmp    101208 <alltraps>

00101937 <vector144>:
.globl vector144
vector144:
  pushl $0
  101937:	6a 00                	push   $0x0
  pushl $144
  101939:	68 90 00 00 00       	push   $0x90
  jmp alltraps
  10193e:	e9 c5 f8 ff ff       	jmp    101208 <alltraps>

00101943 <vector145>:
.globl vector145
vector145:
  pushl $0
  101943:	6a 00                	push   $0x0
  pushl $145
  101945:	68 91 00 00 00       	push   $0x91
  jmp alltraps
  10194a:	e9 b9 f8 ff ff       	jmp    101208 <alltraps>

0010194f <vector146>:
.globl vector146
vector146:
  pushl $0
  10194f:	6a 00                	push   $0x0
  pushl $146
  101951:	68 92 00 00 00       	push   $0x92
  jmp alltraps
  101956:	e9 ad f8 ff ff       	jmp    101208 <alltraps>

0010195b <vector147>:
.globl vector147
vector147:
  pushl $0
  10195b:	6a 00                	push   $0x0
  pushl $147
  10195d:	68 93 00 00 00       	push   $0x93
  jmp alltraps
  101962:	e9 a1 f8 ff ff       	jmp    101208 <alltraps>

00101967 <vector148>:
.globl vector148
vector148:
  pushl $0
  101967:	6a 00                	push   $0x0
  pushl $148
  101969:	68 94 00 00 00       	push   $0x94
  jmp alltraps
  10196e:	e9 95 f8 ff ff       	jmp    101208 <alltraps>

00101973 <vector149>:
.globl vector149
vector149:
  pushl $0
  101973:	6a 00                	push   $0x0
  pushl $149
  101975:	68 95 00 00 00       	push   $0x95
  jmp alltraps
  10197a:	e9 89 f8 ff ff       	jmp    101208 <alltraps>

0010197f <vector150>:
.globl vector150
vector150:
  pushl $0
  10197f:	6a 00                	push   $0x0
  pushl $150
  101981:	68 96 00 00 00       	push   $0x96
  jmp alltraps
  101986:	e9 7d f8 ff ff       	jmp    101208 <alltraps>

0010198b <vector151>:
.globl vector151
vector151:
  pushl $0
  10198b:	6a 00                	push   $0x0
  pushl $151
  10198d:	68 97 00 00 00       	push   $0x97
  jmp alltraps
  101992:	e9 71 f8 ff ff       	jmp    101208 <alltraps>

00101997 <vector152>:
.globl vector152
vector152:
  pushl $0
  101997:	6a 00                	push   $0x0
  pushl $152
  101999:	68 98 00 00 00       	push   $0x98
  jmp alltraps
  10199e:	e9 65 f8 ff ff       	jmp    101208 <alltraps>

001019a3 <vector153>:
.globl vector153
vector153:
  pushl $0
  1019a3:	6a 00                	push   $0x0
  pushl $153
  1019a5:	68 99 00 00 00       	push   $0x99
  jmp alltraps
  1019aa:	e9 59 f8 ff ff       	jmp    101208 <alltraps>

001019af <vector154>:
.globl vector154
vector154:
  pushl $0
  1019af:	6a 00                	push   $0x0
  pushl $154
  1019b1:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
  1019b6:	e9 4d f8 ff ff       	jmp    101208 <alltraps>

001019bb <vector155>:
.globl vector155
vector155:
  pushl $0
  1019bb:	6a 00                	push   $0x0
  pushl $155
  1019bd:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
  1019c2:	e9 41 f8 ff ff       	jmp    101208 <alltraps>

001019c7 <vector156>:
.globl vector156
vector156:
  pushl $0
  1019c7:	6a 00                	push   $0x0
  pushl $156
  1019c9:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
  1019ce:	e9 35 f8 ff ff       	jmp    101208 <alltraps>

001019d3 <vector157>:
.globl vector157
vector157:
  pushl $0
  1019d3:	6a 00                	push   $0x0
  pushl $157
  1019d5:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
  1019da:	e9 29 f8 ff ff       	jmp    101208 <alltraps>

001019df <vector158>:
.globl vector158
vector158:
  pushl $0
  1019df:	6a 00                	push   $0x0
  pushl $158
  1019e1:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
  1019e6:	e9 1d f8 ff ff       	jmp    101208 <alltraps>

001019eb <vector159>:
.globl vector159
vector159:
  pushl $0
  1019eb:	6a 00                	push   $0x0
  pushl $159
  1019ed:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
  1019f2:	e9 11 f8 ff ff       	jmp    101208 <alltraps>

001019f7 <vector160>:
.globl vector160
vector160:
  pushl $0
  1019f7:	6a 00                	push   $0x0
  pushl $160
  1019f9:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
  1019fe:	e9 05 f8 ff ff       	jmp    101208 <alltraps>

00101a03 <vector161>:
.globl vector161
vector161:
  pushl $0
  101a03:	6a 00                	push   $0x0
  pushl $161
  101a05:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
  101a0a:	e9 f9 f7 ff ff       	jmp    101208 <alltraps>

00101a0f <vector162>:
.globl vector162
vector162:
  pushl $0
  101a0f:	6a 00                	push   $0x0
  pushl $162
  101a11:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
  101a16:	e9 ed f7 ff ff       	jmp    101208 <alltraps>

00101a1b <vector163>:
.globl vector163
vector163:
  pushl $0
  101a1b:	6a 00                	push   $0x0
  pushl $163
  101a1d:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
  101a22:	e9 e1 f7 ff ff       	jmp    101208 <alltraps>

00101a27 <vector164>:
.globl vector164
vector164:
  pushl $0
  101a27:	6a 00                	push   $0x0
  pushl $164
  101a29:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
  101a2e:	e9 d5 f7 ff ff       	jmp    101208 <alltraps>

00101a33 <vector165>:
.globl vector165
vector165:
  pushl $0
  101a33:	6a 00                	push   $0x0
  pushl $165
  101a35:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
  101a3a:	e9 c9 f7 ff ff       	jmp    101208 <alltraps>

00101a3f <vector166>:
.globl vector166
vector166:
  pushl $0
  101a3f:	6a 00                	push   $0x0
  pushl $166
  101a41:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
  101a46:	e9 bd f7 ff ff       	jmp    101208 <alltraps>

00101a4b <vector167>:
.globl vector167
vector167:
  pushl $0
  101a4b:	6a 00                	push   $0x0
  pushl $167
  101a4d:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
  101a52:	e9 b1 f7 ff ff       	jmp    101208 <alltraps>

00101a57 <vector168>:
.globl vector168
vector168:
  pushl $0
  101a57:	6a 00                	push   $0x0
  pushl $168
  101a59:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
  101a5e:	e9 a5 f7 ff ff       	jmp    101208 <alltraps>

00101a63 <vector169>:
.globl vector169
vector169:
  pushl $0
  101a63:	6a 00                	push   $0x0
  pushl $169
  101a65:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
  101a6a:	e9 99 f7 ff ff       	jmp    101208 <alltraps>

00101a6f <vector170>:
.globl vector170
vector170:
  pushl $0
  101a6f:	6a 00                	push   $0x0
  pushl $170
  101a71:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
  101a76:	e9 8d f7 ff ff       	jmp    101208 <alltraps>

00101a7b <vector171>:
.globl vector171
vector171:
  pushl $0
  101a7b:	6a 00                	push   $0x0
  pushl $171
  101a7d:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
  101a82:	e9 81 f7 ff ff       	jmp    101208 <alltraps>

00101a87 <vector172>:
.globl vector172
vector172:
  pushl $0
  101a87:	6a 00                	push   $0x0
  pushl $172
  101a89:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
  101a8e:	e9 75 f7 ff ff       	jmp    101208 <alltraps>

00101a93 <vector173>:
.globl vector173
vector173:
  pushl $0
  101a93:	6a 00                	push   $0x0
  pushl $173
  101a95:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
  101a9a:	e9 69 f7 ff ff       	jmp    101208 <alltraps>

00101a9f <vector174>:
.globl vector174
vector174:
  pushl $0
  101a9f:	6a 00                	push   $0x0
  pushl $174
  101aa1:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
  101aa6:	e9 5d f7 ff ff       	jmp    101208 <alltraps>

00101aab <vector175>:
.globl vector175
vector175:
  pushl $0
  101aab:	6a 00                	push   $0x0
  pushl $175
  101aad:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
  101ab2:	e9 51 f7 ff ff       	jmp    101208 <alltraps>

00101ab7 <vector176>:
.globl vector176
vector176:
  pushl $0
  101ab7:	6a 00                	push   $0x0
  pushl $176
  101ab9:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
  101abe:	e9 45 f7 ff ff       	jmp    101208 <alltraps>

00101ac3 <vector177>:
.globl vector177
vector177:
  pushl $0
  101ac3:	6a 00                	push   $0x0
  pushl $177
  101ac5:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
  101aca:	e9 39 f7 ff ff       	jmp    101208 <alltraps>

00101acf <vector178>:
.globl vector178
vector178:
  pushl $0
  101acf:	6a 00                	push   $0x0
  pushl $178
  101ad1:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
  101ad6:	e9 2d f7 ff ff       	jmp    101208 <alltraps>

00101adb <vector179>:
.globl vector179
vector179:
  pushl $0
  101adb:	6a 00                	push   $0x0
  pushl $179
  101add:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
  101ae2:	e9 21 f7 ff ff       	jmp    101208 <alltraps>

00101ae7 <vector180>:
.globl vector180
vector180:
  pushl $0
  101ae7:	6a 00                	push   $0x0
  pushl $180
  101ae9:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
  101aee:	e9 15 f7 ff ff       	jmp    101208 <alltraps>

00101af3 <vector181>:
.globl vector181
vector181:
  pushl $0
  101af3:	6a 00                	push   $0x0
  pushl $181
  101af5:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
  101afa:	e9 09 f7 ff ff       	jmp    101208 <alltraps>

00101aff <vector182>:
.globl vector182
vector182:
  pushl $0
  101aff:	6a 00                	push   $0x0
  pushl $182
  101b01:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
  101b06:	e9 fd f6 ff ff       	jmp    101208 <alltraps>

00101b0b <vector183>:
.globl vector183
vector183:
  pushl $0
  101b0b:	6a 00                	push   $0x0
  pushl $183
  101b0d:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
  101b12:	e9 f1 f6 ff ff       	jmp    101208 <alltraps>

00101b17 <vector184>:
.globl vector184
vector184:
  pushl $0
  101b17:	6a 00                	push   $0x0
  pushl $184
  101b19:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
  101b1e:	e9 e5 f6 ff ff       	jmp    101208 <alltraps>

00101b23 <vector185>:
.globl vector185
vector185:
  pushl $0
  101b23:	6a 00                	push   $0x0
  pushl $185
  101b25:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
  101b2a:	e9 d9 f6 ff ff       	jmp    101208 <alltraps>

00101b2f <vector186>:
.globl vector186
vector186:
  pushl $0
  101b2f:	6a 00                	push   $0x0
  pushl $186
  101b31:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
  101b36:	e9 cd f6 ff ff       	jmp    101208 <alltraps>

00101b3b <vector187>:
.globl vector187
vector187:
  pushl $0
  101b3b:	6a 00                	push   $0x0
  pushl $187
  101b3d:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
  101b42:	e9 c1 f6 ff ff       	jmp    101208 <alltraps>

00101b47 <vector188>:
.globl vector188
vector188:
  pushl $0
  101b47:	6a 00                	push   $0x0
  pushl $188
  101b49:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
  101b4e:	e9 b5 f6 ff ff       	jmp    101208 <alltraps>

00101b53 <vector189>:
.globl vector189
vector189:
  pushl $0
  101b53:	6a 00                	push   $0x0
  pushl $189
  101b55:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
  101b5a:	e9 a9 f6 ff ff       	jmp    101208 <alltraps>

00101b5f <vector190>:
.globl vector190
vector190:
  pushl $0
  101b5f:	6a 00                	push   $0x0
  pushl $190
  101b61:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
  101b66:	e9 9d f6 ff ff       	jmp    101208 <alltraps>

00101b6b <vector191>:
.globl vector191
vector191:
  pushl $0
  101b6b:	6a 00                	push   $0x0
  pushl $191
  101b6d:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
  101b72:	e9 91 f6 ff ff       	jmp    101208 <alltraps>

00101b77 <vector192>:
.globl vector192
vector192:
  pushl $0
  101b77:	6a 00                	push   $0x0
  pushl $192
  101b79:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
  101b7e:	e9 85 f6 ff ff       	jmp    101208 <alltraps>

00101b83 <vector193>:
.globl vector193
vector193:
  pushl $0
  101b83:	6a 00                	push   $0x0
  pushl $193
  101b85:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
  101b8a:	e9 79 f6 ff ff       	jmp    101208 <alltraps>

00101b8f <vector194>:
.globl vector194
vector194:
  pushl $0
  101b8f:	6a 00                	push   $0x0
  pushl $194
  101b91:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
  101b96:	e9 6d f6 ff ff       	jmp    101208 <alltraps>

00101b9b <vector195>:
.globl vector195
vector195:
  pushl $0
  101b9b:	6a 00                	push   $0x0
  pushl $195
  101b9d:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
  101ba2:	e9 61 f6 ff ff       	jmp    101208 <alltraps>

00101ba7 <vector196>:
.globl vector196
vector196:
  pushl $0
  101ba7:	6a 00                	push   $0x0
  pushl $196
  101ba9:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
  101bae:	e9 55 f6 ff ff       	jmp    101208 <alltraps>

00101bb3 <vector197>:
.globl vector197
vector197:
  pushl $0
  101bb3:	6a 00                	push   $0x0
  pushl $197
  101bb5:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
  101bba:	e9 49 f6 ff ff       	jmp    101208 <alltraps>

00101bbf <vector198>:
.globl vector198
vector198:
  pushl $0
  101bbf:	6a 00                	push   $0x0
  pushl $198
  101bc1:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
  101bc6:	e9 3d f6 ff ff       	jmp    101208 <alltraps>

00101bcb <vector199>:
.globl vector199
vector199:
  pushl $0
  101bcb:	6a 00                	push   $0x0
  pushl $199
  101bcd:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
  101bd2:	e9 31 f6 ff ff       	jmp    101208 <alltraps>

00101bd7 <vector200>:
.globl vector200
vector200:
  pushl $0
  101bd7:	6a 00                	push   $0x0
  pushl $200
  101bd9:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
  101bde:	e9 25 f6 ff ff       	jmp    101208 <alltraps>

00101be3 <vector201>:
.globl vector201
vector201:
  pushl $0
  101be3:	6a 00                	push   $0x0
  pushl $201
  101be5:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
  101bea:	e9 19 f6 ff ff       	jmp    101208 <alltraps>

00101bef <vector202>:
.globl vector202
vector202:
  pushl $0
  101bef:	6a 00                	push   $0x0
  pushl $202
  101bf1:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
  101bf6:	e9 0d f6 ff ff       	jmp    101208 <alltraps>

00101bfb <vector203>:
.globl vector203
vector203:
  pushl $0
  101bfb:	6a 00                	push   $0x0
  pushl $203
  101bfd:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
  101c02:	e9 01 f6 ff ff       	jmp    101208 <alltraps>

00101c07 <vector204>:
.globl vector204
vector204:
  pushl $0
  101c07:	6a 00                	push   $0x0
  pushl $204
  101c09:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
  101c0e:	e9 f5 f5 ff ff       	jmp    101208 <alltraps>

00101c13 <vector205>:
.globl vector205
vector205:
  pushl $0
  101c13:	6a 00                	push   $0x0
  pushl $205
  101c15:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
  101c1a:	e9 e9 f5 ff ff       	jmp    101208 <alltraps>

00101c1f <vector206>:
.globl vector206
vector206:
  pushl $0
  101c1f:	6a 00                	push   $0x0
  pushl $206
  101c21:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
  101c26:	e9 dd f5 ff ff       	jmp    101208 <alltraps>

00101c2b <vector207>:
.globl vector207
vector207:
  pushl $0
  101c2b:	6a 00                	push   $0x0
  pushl $207
  101c2d:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
  101c32:	e9 d1 f5 ff ff       	jmp    101208 <alltraps>

00101c37 <vector208>:
.globl vector208
vector208:
  pushl $0
  101c37:	6a 00                	push   $0x0
  pushl $208
  101c39:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
  101c3e:	e9 c5 f5 ff ff       	jmp    101208 <alltraps>

00101c43 <vector209>:
.globl vector209
vector209:
  pushl $0
  101c43:	6a 00                	push   $0x0
  pushl $209
  101c45:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
  101c4a:	e9 b9 f5 ff ff       	jmp    101208 <alltraps>

00101c4f <vector210>:
.globl vector210
vector210:
  pushl $0
  101c4f:	6a 00                	push   $0x0
  pushl $210
  101c51:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
  101c56:	e9 ad f5 ff ff       	jmp    101208 <alltraps>

00101c5b <vector211>:
.globl vector211
vector211:
  pushl $0
  101c5b:	6a 00                	push   $0x0
  pushl $211
  101c5d:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
  101c62:	e9 a1 f5 ff ff       	jmp    101208 <alltraps>

00101c67 <vector212>:
.globl vector212
vector212:
  pushl $0
  101c67:	6a 00                	push   $0x0
  pushl $212
  101c69:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
  101c6e:	e9 95 f5 ff ff       	jmp    101208 <alltraps>

00101c73 <vector213>:
.globl vector213
vector213:
  pushl $0
  101c73:	6a 00                	push   $0x0
  pushl $213
  101c75:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
  101c7a:	e9 89 f5 ff ff       	jmp    101208 <alltraps>

00101c7f <vector214>:
.globl vector214
vector214:
  pushl $0
  101c7f:	6a 00                	push   $0x0
  pushl $214
  101c81:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
  101c86:	e9 7d f5 ff ff       	jmp    101208 <alltraps>

00101c8b <vector215>:
.globl vector215
vector215:
  pushl $0
  101c8b:	6a 00                	push   $0x0
  pushl $215
  101c8d:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
  101c92:	e9 71 f5 ff ff       	jmp    101208 <alltraps>

00101c97 <vector216>:
.globl vector216
vector216:
  pushl $0
  101c97:	6a 00                	push   $0x0
  pushl $216
  101c99:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
  101c9e:	e9 65 f5 ff ff       	jmp    101208 <alltraps>

00101ca3 <vector217>:
.globl vector217
vector217:
  pushl $0
  101ca3:	6a 00                	push   $0x0
  pushl $217
  101ca5:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
  101caa:	e9 59 f5 ff ff       	jmp    101208 <alltraps>

00101caf <vector218>:
.globl vector218
vector218:
  pushl $0
  101caf:	6a 00                	push   $0x0
  pushl $218
  101cb1:	68 da 00 00 00       	push   $0xda
  jmp alltraps
  101cb6:	e9 4d f5 ff ff       	jmp    101208 <alltraps>

00101cbb <vector219>:
.globl vector219
vector219:
  pushl $0
  101cbb:	6a 00                	push   $0x0
  pushl $219
  101cbd:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
  101cc2:	e9 41 f5 ff ff       	jmp    101208 <alltraps>

00101cc7 <vector220>:
.globl vector220
vector220:
  pushl $0
  101cc7:	6a 00                	push   $0x0
  pushl $220
  101cc9:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
  101cce:	e9 35 f5 ff ff       	jmp    101208 <alltraps>

00101cd3 <vector221>:
.globl vector221
vector221:
  pushl $0
  101cd3:	6a 00                	push   $0x0
  pushl $221
  101cd5:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
  101cda:	e9 29 f5 ff ff       	jmp    101208 <alltraps>

00101cdf <vector222>:
.globl vector222
vector222:
  pushl $0
  101cdf:	6a 00                	push   $0x0
  pushl $222
  101ce1:	68 de 00 00 00       	push   $0xde
  jmp alltraps
  101ce6:	e9 1d f5 ff ff       	jmp    101208 <alltraps>

00101ceb <vector223>:
.globl vector223
vector223:
  pushl $0
  101ceb:	6a 00                	push   $0x0
  pushl $223
  101ced:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
  101cf2:	e9 11 f5 ff ff       	jmp    101208 <alltraps>

00101cf7 <vector224>:
.globl vector224
vector224:
  pushl $0
  101cf7:	6a 00                	push   $0x0
  pushl $224
  101cf9:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
  101cfe:	e9 05 f5 ff ff       	jmp    101208 <alltraps>

00101d03 <vector225>:
.globl vector225
vector225:
  pushl $0
  101d03:	6a 00                	push   $0x0
  pushl $225
  101d05:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
  101d0a:	e9 f9 f4 ff ff       	jmp    101208 <alltraps>

00101d0f <vector226>:
.globl vector226
vector226:
  pushl $0
  101d0f:	6a 00                	push   $0x0
  pushl $226
  101d11:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
  101d16:	e9 ed f4 ff ff       	jmp    101208 <alltraps>

00101d1b <vector227>:
.globl vector227
vector227:
  pushl $0
  101d1b:	6a 00                	push   $0x0
  pushl $227
  101d1d:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
  101d22:	e9 e1 f4 ff ff       	jmp    101208 <alltraps>

00101d27 <vector228>:
.globl vector228
vector228:
  pushl $0
  101d27:	6a 00                	push   $0x0
  pushl $228
  101d29:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
  101d2e:	e9 d5 f4 ff ff       	jmp    101208 <alltraps>

00101d33 <vector229>:
.globl vector229
vector229:
  pushl $0
  101d33:	6a 00                	push   $0x0
  pushl $229
  101d35:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
  101d3a:	e9 c9 f4 ff ff       	jmp    101208 <alltraps>

00101d3f <vector230>:
.globl vector230
vector230:
  pushl $0
  101d3f:	6a 00                	push   $0x0
  pushl $230
  101d41:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
  101d46:	e9 bd f4 ff ff       	jmp    101208 <alltraps>

00101d4b <vector231>:
.globl vector231
vector231:
  pushl $0
  101d4b:	6a 00                	push   $0x0
  pushl $231
  101d4d:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
  101d52:	e9 b1 f4 ff ff       	jmp    101208 <alltraps>

00101d57 <vector232>:
.globl vector232
vector232:
  pushl $0
  101d57:	6a 00                	push   $0x0
  pushl $232
  101d59:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
  101d5e:	e9 a5 f4 ff ff       	jmp    101208 <alltraps>

00101d63 <vector233>:
.globl vector233
vector233:
  pushl $0
  101d63:	6a 00                	push   $0x0
  pushl $233
  101d65:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
  101d6a:	e9 99 f4 ff ff       	jmp    101208 <alltraps>

00101d6f <vector234>:
.globl vector234
vector234:
  pushl $0
  101d6f:	6a 00                	push   $0x0
  pushl $234
  101d71:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
  101d76:	e9 8d f4 ff ff       	jmp    101208 <alltraps>

00101d7b <vector235>:
.globl vector235
vector235:
  pushl $0
  101d7b:	6a 00                	push   $0x0
  pushl $235
  101d7d:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
  101d82:	e9 81 f4 ff ff       	jmp    101208 <alltraps>

00101d87 <vector236>:
.globl vector236
vector236:
  pushl $0
  101d87:	6a 00                	push   $0x0
  pushl $236
  101d89:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
  101d8e:	e9 75 f4 ff ff       	jmp    101208 <alltraps>

00101d93 <vector237>:
.globl vector237
vector237:
  pushl $0
  101d93:	6a 00                	push   $0x0
  pushl $237
  101d95:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
  101d9a:	e9 69 f4 ff ff       	jmp    101208 <alltraps>

00101d9f <vector238>:
.globl vector238
vector238:
  pushl $0
  101d9f:	6a 00                	push   $0x0
  pushl $238
  101da1:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
  101da6:	e9 5d f4 ff ff       	jmp    101208 <alltraps>

00101dab <vector239>:
.globl vector239
vector239:
  pushl $0
  101dab:	6a 00                	push   $0x0
  pushl $239
  101dad:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
  101db2:	e9 51 f4 ff ff       	jmp    101208 <alltraps>

00101db7 <vector240>:
.globl vector240
vector240:
  pushl $0
  101db7:	6a 00                	push   $0x0
  pushl $240
  101db9:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
  101dbe:	e9 45 f4 ff ff       	jmp    101208 <alltraps>

00101dc3 <vector241>:
.globl vector241
vector241:
  pushl $0
  101dc3:	6a 00                	push   $0x0
  pushl $241
  101dc5:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
  101dca:	e9 39 f4 ff ff       	jmp    101208 <alltraps>

00101dcf <vector242>:
.globl vector242
vector242:
  pushl $0
  101dcf:	6a 00                	push   $0x0
  pushl $242
  101dd1:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
  101dd6:	e9 2d f4 ff ff       	jmp    101208 <alltraps>

00101ddb <vector243>:
.globl vector243
vector243:
  pushl $0
  101ddb:	6a 00                	push   $0x0
  pushl $243
  101ddd:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
  101de2:	e9 21 f4 ff ff       	jmp    101208 <alltraps>

00101de7 <vector244>:
.globl vector244
vector244:
  pushl $0
  101de7:	6a 00                	push   $0x0
  pushl $244
  101de9:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
  101dee:	e9 15 f4 ff ff       	jmp    101208 <alltraps>

00101df3 <vector245>:
.globl vector245
vector245:
  pushl $0
  101df3:	6a 00                	push   $0x0
  pushl $245
  101df5:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
  101dfa:	e9 09 f4 ff ff       	jmp    101208 <alltraps>

00101dff <vector246>:
.globl vector246
vector246:
  pushl $0
  101dff:	6a 00                	push   $0x0
  pushl $246
  101e01:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
  101e06:	e9 fd f3 ff ff       	jmp    101208 <alltraps>

00101e0b <vector247>:
.globl vector247
vector247:
  pushl $0
  101e0b:	6a 00                	push   $0x0
  pushl $247
  101e0d:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
  101e12:	e9 f1 f3 ff ff       	jmp    101208 <alltraps>

00101e17 <vector248>:
.globl vector248
vector248:
  pushl $0
  101e17:	6a 00                	push   $0x0
  pushl $248
  101e19:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
  101e1e:	e9 e5 f3 ff ff       	jmp    101208 <alltraps>

00101e23 <vector249>:
.globl vector249
vector249:
  pushl $0
  101e23:	6a 00                	push   $0x0
  pushl $249
  101e25:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
  101e2a:	e9 d9 f3 ff ff       	jmp    101208 <alltraps>

00101e2f <vector250>:
.globl vector250
vector250:
  pushl $0
  101e2f:	6a 00                	push   $0x0
  pushl $250
  101e31:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
  101e36:	e9 cd f3 ff ff       	jmp    101208 <alltraps>

00101e3b <vector251>:
.globl vector251
vector251:
  pushl $0
  101e3b:	6a 00                	push   $0x0
  pushl $251
  101e3d:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
  101e42:	e9 c1 f3 ff ff       	jmp    101208 <alltraps>

00101e47 <vector252>:
.globl vector252
vector252:
  pushl $0
  101e47:	6a 00                	push   $0x0
  pushl $252
  101e49:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
  101e4e:	e9 b5 f3 ff ff       	jmp    101208 <alltraps>

00101e53 <vector253>:
.globl vector253
vector253:
  pushl $0
  101e53:	6a 00                	push   $0x0
  pushl $253
  101e55:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
  101e5a:	e9 a9 f3 ff ff       	jmp    101208 <alltraps>

00101e5f <vector254>:
.globl vector254
vector254:
  pushl $0
  101e5f:	6a 00                	push   $0x0
  pushl $254
  101e61:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
  101e66:	e9 9d f3 ff ff       	jmp    101208 <alltraps>

00101e6b <vector255>:
.globl vector255
vector255:
  pushl $0
  101e6b:	6a 00                	push   $0x0
  pushl $255
  101e6d:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
  101e72:	e9 91 f3 ff ff       	jmp    101208 <alltraps>

00101e77 <cache_undo_image>:

// Cache the current block image as the "old value" for undo logging.
// We only refresh this snapshot before a block is added to the active log.
static void
cache_undo_image(struct buf *b)
{
  101e77:	55                   	push   %ebp
  101e78:	89 e5                	mov    %esp,%ebp
  101e7a:	83 ec 08             	sub    $0x8,%esp
  if (log_has_block(b->blockno))
  101e7d:	8b 45 08             	mov    0x8(%ebp),%eax
  101e80:	8b 40 08             	mov    0x8(%eax),%eax
  101e83:	83 ec 0c             	sub    $0xc,%esp
  101e86:	50                   	push   %eax
  101e87:	e8 8c 21 00 00       	call   104018 <log_has_block>
  101e8c:	83 c4 10             	add    $0x10,%esp
  101e8f:	85 c0                	test   %eax,%eax
  101e91:	75 2d                	jne    101ec0 <cache_undo_image+0x49>
    return;
  memmove(b->undo_data, b->data, BSIZE);
  101e93:	8b 45 08             	mov    0x8(%ebp),%eax
  101e96:	8d 90 20 02 00 00    	lea    0x220(%eax),%edx
  101e9c:	8b 45 08             	mov    0x8(%ebp),%eax
  101e9f:	83 c0 20             	add    $0x20,%eax
  101ea2:	83 ec 04             	sub    $0x4,%esp
  101ea5:	68 00 02 00 00       	push   $0x200
  101eaa:	52                   	push   %edx
  101eab:	50                   	push   %eax
  101eac:	e8 a1 f0 ff ff       	call   100f52 <memmove>
  101eb1:	83 c4 10             	add    $0x10,%esp
  b->undo_cached = 1;
  101eb4:	8b 45 08             	mov    0x8(%ebp),%eax
  101eb7:	c7 40 1c 01 00 00 00 	movl   $0x1,0x1c(%eax)
  101ebe:	eb 01                	jmp    101ec1 <cache_undo_image+0x4a>
    return;
  101ec0:	90                   	nop
}
  101ec1:	c9                   	leave
  101ec2:	c3                   	ret

00101ec3 <binit>:

void
binit(void)
{
  101ec3:	55                   	push   %ebp
  101ec4:	89 e5                	mov    %esp,%ebp
  101ec6:	83 ec 10             	sub    $0x10,%esp
  struct buf *b;

  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  101ec9:	c7 05 d0 d8 10 00 c0 	movl   $0x10d8c0,0x10d8d0
  101ed0:	d8 10 00 
  bcache.head.next = &bcache.head;
  101ed3:	c7 05 d4 d8 10 00 c0 	movl   $0x10d8c0,0x10d8d4
  101eda:	d8 10 00 
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
  101edd:	c7 45 fc 00 5d 10 00 	movl   $0x105d00,-0x4(%ebp)
  101ee4:	eb 30                	jmp    101f16 <binit+0x53>
    b->next = bcache.head.next;
  101ee6:	8b 15 d4 d8 10 00    	mov    0x10d8d4,%edx
  101eec:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101eef:	89 50 14             	mov    %edx,0x14(%eax)
    b->prev = &bcache.head;
  101ef2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101ef5:	c7 40 10 c0 d8 10 00 	movl   $0x10d8c0,0x10(%eax)
    bcache.head.next->prev = b;
  101efc:	a1 d4 d8 10 00       	mov    0x10d8d4,%eax
  101f01:	8b 55 fc             	mov    -0x4(%ebp),%edx
  101f04:	89 50 10             	mov    %edx,0x10(%eax)
    bcache.head.next = b;
  101f07:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101f0a:	a3 d4 d8 10 00       	mov    %eax,0x10d8d4
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
  101f0f:	81 45 fc 20 04 00 00 	addl   $0x420,-0x4(%ebp)
  101f16:	b8 c0 d8 10 00       	mov    $0x10d8c0,%eax
  101f1b:	39 45 fc             	cmp    %eax,-0x4(%ebp)
  101f1e:	72 c6                	jb     101ee6 <binit+0x23>
  }
}
  101f20:	90                   	nop
  101f21:	90                   	nop
  101f22:	c9                   	leave
  101f23:	c3                   	ret

00101f24 <bget>:
// Look through buffer cache for block on device dev.
// If not found, allocate a buffer.
// In either case, return locked buffer.
static struct buf*
bget(uint dev, uint blockno)
{
  101f24:	55                   	push   %ebp
  101f25:	89 e5                	mov    %esp,%ebp
  101f27:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // Is the block already cached?
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
  101f2a:	a1 d4 d8 10 00       	mov    0x10d8d4,%eax
  101f2f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  101f32:	eb 36                	jmp    101f6a <bget+0x46>
    if(b->dev == dev && b->blockno == blockno){
  101f34:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101f37:	8b 40 04             	mov    0x4(%eax),%eax
  101f3a:	39 45 08             	cmp    %eax,0x8(%ebp)
  101f3d:	75 22                	jne    101f61 <bget+0x3d>
  101f3f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101f42:	8b 40 08             	mov    0x8(%eax),%eax
  101f45:	39 45 0c             	cmp    %eax,0xc(%ebp)
  101f48:	75 17                	jne    101f61 <bget+0x3d>
      b->refcnt++;
  101f4a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101f4d:	8b 40 0c             	mov    0xc(%eax),%eax
  101f50:	8d 50 01             	lea    0x1(%eax),%edx
  101f53:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101f56:	89 50 0c             	mov    %edx,0xc(%eax)
      return b;
  101f59:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101f5c:	e9 85 00 00 00       	jmp    101fe6 <bget+0xc2>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
  101f61:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101f64:	8b 40 14             	mov    0x14(%eax),%eax
  101f67:	89 45 f4             	mov    %eax,-0xc(%ebp)
  101f6a:	81 7d f4 c0 d8 10 00 	cmpl   $0x10d8c0,-0xc(%ebp)
  101f71:	75 c1                	jne    101f34 <bget+0x10>
  }

  // Not cached; recycle an unused buffer.
  // Even if refcnt==0, B_DIRTY indicates a buffer is in use
  // because log.c has modified it but not yet committed it.
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
  101f73:	a1 d0 d8 10 00       	mov    0x10d8d0,%eax
  101f78:	89 45 f4             	mov    %eax,-0xc(%ebp)
  101f7b:	eb 53                	jmp    101fd0 <bget+0xac>
    if(b->refcnt == 0 && (b->flags & B_DIRTY) == 0) {
  101f7d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101f80:	8b 40 0c             	mov    0xc(%eax),%eax
  101f83:	85 c0                	test   %eax,%eax
  101f85:	75 40                	jne    101fc7 <bget+0xa3>
  101f87:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101f8a:	8b 00                	mov    (%eax),%eax
  101f8c:	83 e0 04             	and    $0x4,%eax
  101f8f:	85 c0                	test   %eax,%eax
  101f91:	75 34                	jne    101fc7 <bget+0xa3>
      b->dev = dev;
  101f93:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101f96:	8b 55 08             	mov    0x8(%ebp),%edx
  101f99:	89 50 04             	mov    %edx,0x4(%eax)
      b->blockno = blockno;
  101f9c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101f9f:	8b 55 0c             	mov    0xc(%ebp),%edx
  101fa2:	89 50 08             	mov    %edx,0x8(%eax)
      b->flags = 0;
  101fa5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101fa8:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
      b->undo_cached = 0; // clear stale undo snapshot on buffer reuse
  101fae:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101fb1:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
      b->refcnt = 1;
  101fb8:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101fbb:	c7 40 0c 01 00 00 00 	movl   $0x1,0xc(%eax)
      return b;
  101fc2:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101fc5:	eb 1f                	jmp    101fe6 <bget+0xc2>
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
  101fc7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101fca:	8b 40 10             	mov    0x10(%eax),%eax
  101fcd:	89 45 f4             	mov    %eax,-0xc(%ebp)
  101fd0:	81 7d f4 c0 d8 10 00 	cmpl   $0x10d8c0,-0xc(%ebp)
  101fd7:	75 a4                	jne    101f7d <bget+0x59>
    }
  }
  panic("bget: no buffers");
  101fd9:	83 ec 0c             	sub    $0xc,%esp
  101fdc:	68 98 43 10 00       	push   $0x104398
  101fe1:	e8 c8 e2 ff ff       	call   1002ae <panic>
}
  101fe6:	c9                   	leave
  101fe7:	c3                   	ret

00101fe8 <bread>:

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
  101fe8:	55                   	push   %ebp
  101fe9:	89 e5                	mov    %esp,%ebp
  101feb:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  b = bget(dev, blockno);
  101fee:	83 ec 08             	sub    $0x8,%esp
  101ff1:	ff 75 0c             	push   0xc(%ebp)
  101ff4:	ff 75 08             	push   0x8(%ebp)
  101ff7:	e8 28 ff ff ff       	call   101f24 <bget>
  101ffc:	83 c4 10             	add    $0x10,%esp
  101fff:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if((b->flags & B_VALID) == 0) {
  102002:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102005:	8b 00                	mov    (%eax),%eax
  102007:	83 e0 02             	and    $0x2,%eax
  10200a:	85 c0                	test   %eax,%eax
  10200c:	75 0e                	jne    10201c <bread+0x34>
    iderw(b);
  10200e:	83 ec 0c             	sub    $0xc,%esp
  102011:	ff 75 f4             	push   -0xc(%ebp)
  102014:	e8 40 04 00 00       	call   102459 <iderw>
  102019:	83 c4 10             	add    $0x10,%esp
  }
  // Keep a pre-modify snapshot available with no extra disk read.
  cache_undo_image(b);
  10201c:	83 ec 0c             	sub    $0xc,%esp
  10201f:	ff 75 f4             	push   -0xc(%ebp)
  102022:	e8 50 fe ff ff       	call   101e77 <cache_undo_image>
  102027:	83 c4 10             	add    $0x10,%esp
  return b;
  10202a:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  10202d:	c9                   	leave
  10202e:	c3                   	ret

0010202f <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
  10202f:	55                   	push   %ebp
  102030:	89 e5                	mov    %esp,%ebp
  102032:	83 ec 08             	sub    $0x8,%esp
  b->flags |= B_DIRTY;
  102035:	8b 45 08             	mov    0x8(%ebp),%eax
  102038:	8b 00                	mov    (%eax),%eax
  10203a:	83 c8 04             	or     $0x4,%eax
  10203d:	89 c2                	mov    %eax,%edx
  10203f:	8b 45 08             	mov    0x8(%ebp),%eax
  102042:	89 10                	mov    %edx,(%eax)
  iderw(b);
  102044:	83 ec 0c             	sub    $0xc,%esp
  102047:	ff 75 08             	push   0x8(%ebp)
  10204a:	e8 0a 04 00 00       	call   102459 <iderw>
  10204f:	83 c4 10             	add    $0x10,%esp
}
  102052:	90                   	nop
  102053:	c9                   	leave
  102054:	c3                   	ret

00102055 <bread_wr>:

struct buf* 
bread_wr(uint dev, uint blockno)
{
  102055:	55                   	push   %ebp
  102056:	89 e5                	mov    %esp,%ebp
  102058:	83 ec 08             	sub    $0x8,%esp
  // A write-intended read uses the same buffer path and eagerly refreshes
  // the cached old image if this block is not already logged in the txn.
  return bread(dev, blockno);
  10205b:	83 ec 08             	sub    $0x8,%esp
  10205e:	ff 75 0c             	push   0xc(%ebp)
  102061:	ff 75 08             	push   0x8(%ebp)
  102064:	e8 7f ff ff ff       	call   101fe8 <bread>
  102069:	83 c4 10             	add    $0x10,%esp
}
  10206c:	c9                   	leave
  10206d:	c3                   	ret

0010206e <brelse>:

// Release a buffer.
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
  10206e:	55                   	push   %ebp
  10206f:	89 e5                	mov    %esp,%ebp
  b->refcnt--;
  102071:	8b 45 08             	mov    0x8(%ebp),%eax
  102074:	8b 40 0c             	mov    0xc(%eax),%eax
  102077:	8d 50 ff             	lea    -0x1(%eax),%edx
  10207a:	8b 45 08             	mov    0x8(%ebp),%eax
  10207d:	89 50 0c             	mov    %edx,0xc(%eax)
  if (b->refcnt == 0) {
  102080:	8b 45 08             	mov    0x8(%ebp),%eax
  102083:	8b 40 0c             	mov    0xc(%eax),%eax
  102086:	85 c0                	test   %eax,%eax
  102088:	75 47                	jne    1020d1 <brelse+0x63>
    // no one is waiting for it.
    b->next->prev = b->prev;
  10208a:	8b 45 08             	mov    0x8(%ebp),%eax
  10208d:	8b 40 14             	mov    0x14(%eax),%eax
  102090:	8b 55 08             	mov    0x8(%ebp),%edx
  102093:	8b 52 10             	mov    0x10(%edx),%edx
  102096:	89 50 10             	mov    %edx,0x10(%eax)
    b->prev->next = b->next;
  102099:	8b 45 08             	mov    0x8(%ebp),%eax
  10209c:	8b 40 10             	mov    0x10(%eax),%eax
  10209f:	8b 55 08             	mov    0x8(%ebp),%edx
  1020a2:	8b 52 14             	mov    0x14(%edx),%edx
  1020a5:	89 50 14             	mov    %edx,0x14(%eax)
    b->next = bcache.head.next;
  1020a8:	8b 15 d4 d8 10 00    	mov    0x10d8d4,%edx
  1020ae:	8b 45 08             	mov    0x8(%ebp),%eax
  1020b1:	89 50 14             	mov    %edx,0x14(%eax)
    b->prev = &bcache.head;
  1020b4:	8b 45 08             	mov    0x8(%ebp),%eax
  1020b7:	c7 40 10 c0 d8 10 00 	movl   $0x10d8c0,0x10(%eax)
    bcache.head.next->prev = b;
  1020be:	a1 d4 d8 10 00       	mov    0x10d8d4,%eax
  1020c3:	8b 55 08             	mov    0x8(%ebp),%edx
  1020c6:	89 50 10             	mov    %edx,0x10(%eax)
    bcache.head.next = b;
  1020c9:	8b 45 08             	mov    0x8(%ebp),%eax
  1020cc:	a3 d4 d8 10 00       	mov    %eax,0x10d8d4
  }
}
  1020d1:	90                   	nop
  1020d2:	5d                   	pop    %ebp
  1020d3:	c3                   	ret

001020d4 <inb>:
// Simple PIO-based (non-DMA) IDE driver code.

#include "types.h"
#include "defs.h"
#include "param.h"
  1020d4:	55                   	push   %ebp
  1020d5:	89 e5                	mov    %esp,%ebp
  1020d7:	83 ec 14             	sub    $0x14,%esp
  1020da:	8b 45 08             	mov    0x8(%ebp),%eax
  1020dd:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
#include "mmu.h"
#include "proc.h"
#include "x86.h"
  1020e1:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
  1020e5:	89 c2                	mov    %eax,%edx
  1020e7:	ec                   	in     (%dx),%al
  1020e8:	88 45 ff             	mov    %al,-0x1(%ebp)
#include "traps.h"
  1020eb:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
#include "fs.h"
  1020ef:	c9                   	leave
  1020f0:	c3                   	ret

001020f1 <insl>:
#include "buf.h"

#define SECTOR_SIZE   512
#define IDE_BSY       0x80
  1020f1:	55                   	push   %ebp
  1020f2:	89 e5                	mov    %esp,%ebp
  1020f4:	57                   	push   %edi
  1020f5:	53                   	push   %ebx
#define IDE_DRDY      0x40
  1020f6:	8b 55 08             	mov    0x8(%ebp),%edx
  1020f9:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  1020fc:	8b 45 10             	mov    0x10(%ebp),%eax
  1020ff:	89 cb                	mov    %ecx,%ebx
  102101:	89 df                	mov    %ebx,%edi
  102103:	89 c1                	mov    %eax,%ecx
  102105:	fc                   	cld
  102106:	f3 6d                	rep insl (%dx),%es:(%edi)
  102108:	89 c8                	mov    %ecx,%eax
  10210a:	89 fb                	mov    %edi,%ebx
  10210c:	89 5d 0c             	mov    %ebx,0xc(%ebp)
  10210f:	89 45 10             	mov    %eax,0x10(%ebp)
#define IDE_DF        0x20
#define IDE_ERR       0x01

#define IDE_CMD_READ  0x20
  102112:	90                   	nop
  102113:	5b                   	pop    %ebx
  102114:	5f                   	pop    %edi
  102115:	5d                   	pop    %ebp
  102116:	c3                   	ret

00102117 <outb>:
#define IDE_CMD_WRITE 0x30
#define IDE_CMD_RDMUL 0xc4
#define IDE_CMD_WRMUL 0xc5

  102117:	55                   	push   %ebp
  102118:	89 e5                	mov    %esp,%ebp
  10211a:	83 ec 08             	sub    $0x8,%esp
  10211d:	8b 55 08             	mov    0x8(%ebp),%edx
  102120:	8b 45 0c             	mov    0xc(%ebp),%eax
  102123:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
  102127:	88 45 f8             	mov    %al,-0x8(%ebp)
// idequeue points to the buf now being read/written to the disk.
  10212a:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
  10212e:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
  102132:	ee                   	out    %al,(%dx)
// idequeue->qnext points to the next buf to be processed.
  102133:	90                   	nop
  102134:	c9                   	leave
  102135:	c3                   	ret

00102136 <outsl>:
static int havedisk1;
static void idestart(struct buf*);

// Wait for IDE disk to become ready.
static int
idewait(int checkerr)
  102136:	55                   	push   %ebp
  102137:	89 e5                	mov    %esp,%ebp
  102139:	56                   	push   %esi
  10213a:	53                   	push   %ebx
{
  10213b:	8b 55 08             	mov    0x8(%ebp),%edx
  10213e:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  102141:	8b 45 10             	mov    0x10(%ebp),%eax
  102144:	89 cb                	mov    %ecx,%ebx
  102146:	89 de                	mov    %ebx,%esi
  102148:	89 c1                	mov    %eax,%ecx
  10214a:	fc                   	cld
  10214b:	f3 6f                	rep outsl %ds:(%esi),(%dx)
  10214d:	89 c8                	mov    %ecx,%eax
  10214f:	89 f3                	mov    %esi,%ebx
  102151:	89 5d 0c             	mov    %ebx,0xc(%ebp)
  102154:	89 45 10             	mov    %eax,0x10(%ebp)
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY);
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
  102157:	90                   	nop
  102158:	5b                   	pop    %ebx
  102159:	5e                   	pop    %esi
  10215a:	5d                   	pop    %ebp
  10215b:	c3                   	ret

0010215c <noop>:
  }
  idequeue = b->qnext;

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
    insl(0x1f0, b->data, BSIZE/4);
  10215c:	55                   	push   %ebp
  10215d:	89 e5                	mov    %esp,%ebp

  10215f:	90                   	nop
  b->flags |= B_VALID;
  102160:	90                   	nop
  102161:	5d                   	pop    %ebp
  102162:	c3                   	ret

00102163 <idewait>:
{
  102163:	55                   	push   %ebp
  102164:	89 e5                	mov    %esp,%ebp
  102166:	83 ec 10             	sub    $0x10,%esp
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY);
  102169:	90                   	nop
  10216a:	68 f7 01 00 00       	push   $0x1f7
  10216f:	e8 60 ff ff ff       	call   1020d4 <inb>
  102174:	83 c4 04             	add    $0x4,%esp
  102177:	0f b6 c0             	movzbl %al,%eax
  10217a:	89 45 fc             	mov    %eax,-0x4(%ebp)
  10217d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  102180:	25 c0 00 00 00       	and    $0xc0,%eax
  102185:	83 f8 40             	cmp    $0x40,%eax
  102188:	75 e0                	jne    10216a <idewait+0x7>
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
  10218a:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  10218e:	74 11                	je     1021a1 <idewait+0x3e>
  102190:	8b 45 fc             	mov    -0x4(%ebp),%eax
  102193:	83 e0 21             	and    $0x21,%eax
  102196:	85 c0                	test   %eax,%eax
  102198:	74 07                	je     1021a1 <idewait+0x3e>
    return -1;
  10219a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  10219f:	eb 05                	jmp    1021a6 <idewait+0x43>
  return 0;
  1021a1:	b8 00 00 00 00       	mov    $0x0,%eax
}
  1021a6:	c9                   	leave
  1021a7:	c3                   	ret

001021a8 <ideinit>:
{
  1021a8:	55                   	push   %ebp
  1021a9:	89 e5                	mov    %esp,%ebp
  1021ab:	83 ec 18             	sub    $0x18,%esp
  ioapicenable(IRQ_IDE, ncpu - 1);
  1021ae:	a1 c0 54 10 00       	mov    0x1054c0,%eax
  1021b3:	83 e8 01             	sub    $0x1,%eax
  1021b6:	83 ec 08             	sub    $0x8,%esp
  1021b9:	50                   	push   %eax
  1021ba:	6a 0e                	push   $0xe
  1021bc:	e8 e4 e3 ff ff       	call   1005a5 <ioapicenable>
  1021c1:	83 c4 10             	add    $0x10,%esp
  idewait(0);
  1021c4:	83 ec 0c             	sub    $0xc,%esp
  1021c7:	6a 00                	push   $0x0
  1021c9:	e8 95 ff ff ff       	call   102163 <idewait>
  1021ce:	83 c4 10             	add    $0x10,%esp
  outb(0x1f6, 0xe0 | (1<<4));
  1021d1:	83 ec 08             	sub    $0x8,%esp
  1021d4:	68 f0 00 00 00       	push   $0xf0
  1021d9:	68 f6 01 00 00       	push   $0x1f6
  1021de:	e8 34 ff ff ff       	call   102117 <outb>
  1021e3:	83 c4 10             	add    $0x10,%esp
  for(i=0; i<1000; i++){
  1021e6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  1021ed:	eb 24                	jmp    102213 <ideinit+0x6b>
    if(inb(0x1f7) != 0){
  1021ef:	83 ec 0c             	sub    $0xc,%esp
  1021f2:	68 f7 01 00 00       	push   $0x1f7
  1021f7:	e8 d8 fe ff ff       	call   1020d4 <inb>
  1021fc:	83 c4 10             	add    $0x10,%esp
  1021ff:	84 c0                	test   %al,%al
  102201:	74 0c                	je     10220f <ideinit+0x67>
      havedisk1 = 1;
  102203:	c7 05 e4 dc 10 00 01 	movl   $0x1,0x10dce4
  10220a:	00 00 00 
      break;
  10220d:	eb 0d                	jmp    10221c <ideinit+0x74>
  for(i=0; i<1000; i++){
  10220f:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  102213:	81 7d f4 e7 03 00 00 	cmpl   $0x3e7,-0xc(%ebp)
  10221a:	7e d3                	jle    1021ef <ideinit+0x47>
  outb(0x1f6, 0xe0 | (0<<4));
  10221c:	83 ec 08             	sub    $0x8,%esp
  10221f:	68 e0 00 00 00       	push   $0xe0
  102224:	68 f6 01 00 00       	push   $0x1f6
  102229:	e8 e9 fe ff ff       	call   102117 <outb>
  10222e:	83 c4 10             	add    $0x10,%esp
}
  102231:	90                   	nop
  102232:	c9                   	leave
  102233:	c3                   	ret

00102234 <idestart>:
{
  102234:	55                   	push   %ebp
  102235:	89 e5                	mov    %esp,%ebp
  102237:	83 ec 18             	sub    $0x18,%esp
  if(b == 0)
  10223a:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  10223e:	75 0d                	jne    10224d <idestart+0x19>
    panic("idestart");
  102240:	83 ec 0c             	sub    $0xc,%esp
  102243:	68 a9 43 10 00       	push   $0x1043a9
  102248:	e8 61 e0 ff ff       	call   1002ae <panic>
  if(b->blockno >= FSSIZE)
  10224d:	8b 45 08             	mov    0x8(%ebp),%eax
  102250:	8b 40 08             	mov    0x8(%eax),%eax
  102253:	3d e7 03 00 00       	cmp    $0x3e7,%eax
  102258:	76 0d                	jbe    102267 <idestart+0x33>
    panic("incorrect blockno");
  10225a:	83 ec 0c             	sub    $0xc,%esp
  10225d:	68 b2 43 10 00       	push   $0x1043b2
  102262:	e8 47 e0 ff ff       	call   1002ae <panic>
  int sector_per_block =  BSIZE/SECTOR_SIZE;
  102267:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
  int sector = b->blockno * sector_per_block;
  10226e:	8b 45 08             	mov    0x8(%ebp),%eax
  102271:	8b 50 08             	mov    0x8(%eax),%edx
  102274:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102277:	0f af c2             	imul   %edx,%eax
  10227a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  int read_cmd = (sector_per_block == 1) ? IDE_CMD_READ :  IDE_CMD_RDMUL;
  10227d:	83 7d f4 01          	cmpl   $0x1,-0xc(%ebp)
  102281:	75 07                	jne    10228a <idestart+0x56>
  102283:	b8 20 00 00 00       	mov    $0x20,%eax
  102288:	eb 05                	jmp    10228f <idestart+0x5b>
  10228a:	b8 c4 00 00 00       	mov    $0xc4,%eax
  10228f:	89 45 ec             	mov    %eax,-0x14(%ebp)
  int write_cmd = (sector_per_block == 1) ? IDE_CMD_WRITE : IDE_CMD_WRMUL;
  102292:	83 7d f4 01          	cmpl   $0x1,-0xc(%ebp)
  102296:	75 07                	jne    10229f <idestart+0x6b>
  102298:	b8 30 00 00 00       	mov    $0x30,%eax
  10229d:	eb 05                	jmp    1022a4 <idestart+0x70>
  10229f:	b8 c5 00 00 00       	mov    $0xc5,%eax
  1022a4:	89 45 e8             	mov    %eax,-0x18(%ebp)
  if (sector_per_block > 7) panic("idestart");
  1022a7:	83 7d f4 07          	cmpl   $0x7,-0xc(%ebp)
  1022ab:	7e 0d                	jle    1022ba <idestart+0x86>
  1022ad:	83 ec 0c             	sub    $0xc,%esp
  1022b0:	68 a9 43 10 00       	push   $0x1043a9
  1022b5:	e8 f4 df ff ff       	call   1002ae <panic>
  idewait(0);
  1022ba:	83 ec 0c             	sub    $0xc,%esp
  1022bd:	6a 00                	push   $0x0
  1022bf:	e8 9f fe ff ff       	call   102163 <idewait>
  1022c4:	83 c4 10             	add    $0x10,%esp
  outb(0x3f6, 0);  // generate interrupt
  1022c7:	83 ec 08             	sub    $0x8,%esp
  1022ca:	6a 00                	push   $0x0
  1022cc:	68 f6 03 00 00       	push   $0x3f6
  1022d1:	e8 41 fe ff ff       	call   102117 <outb>
  1022d6:	83 c4 10             	add    $0x10,%esp
  outb(0x1f2, sector_per_block);  // number of sectors
  1022d9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1022dc:	0f b6 c0             	movzbl %al,%eax
  1022df:	83 ec 08             	sub    $0x8,%esp
  1022e2:	50                   	push   %eax
  1022e3:	68 f2 01 00 00       	push   $0x1f2
  1022e8:	e8 2a fe ff ff       	call   102117 <outb>
  1022ed:	83 c4 10             	add    $0x10,%esp
  outb(0x1f3, sector & 0xff);
  1022f0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1022f3:	0f b6 c0             	movzbl %al,%eax
  1022f6:	83 ec 08             	sub    $0x8,%esp
  1022f9:	50                   	push   %eax
  1022fa:	68 f3 01 00 00       	push   $0x1f3
  1022ff:	e8 13 fe ff ff       	call   102117 <outb>
  102304:	83 c4 10             	add    $0x10,%esp
  outb(0x1f4, (sector >> 8) & 0xff);
  102307:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10230a:	c1 f8 08             	sar    $0x8,%eax
  10230d:	0f b6 c0             	movzbl %al,%eax
  102310:	83 ec 08             	sub    $0x8,%esp
  102313:	50                   	push   %eax
  102314:	68 f4 01 00 00       	push   $0x1f4
  102319:	e8 f9 fd ff ff       	call   102117 <outb>
  10231e:	83 c4 10             	add    $0x10,%esp
  outb(0x1f5, (sector >> 16) & 0xff);
  102321:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102324:	c1 f8 10             	sar    $0x10,%eax
  102327:	0f b6 c0             	movzbl %al,%eax
  10232a:	83 ec 08             	sub    $0x8,%esp
  10232d:	50                   	push   %eax
  10232e:	68 f5 01 00 00       	push   $0x1f5
  102333:	e8 df fd ff ff       	call   102117 <outb>
  102338:	83 c4 10             	add    $0x10,%esp
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
  10233b:	8b 45 08             	mov    0x8(%ebp),%eax
  10233e:	8b 40 04             	mov    0x4(%eax),%eax
  102341:	c1 e0 04             	shl    $0x4,%eax
  102344:	83 e0 10             	and    $0x10,%eax
  102347:	89 c2                	mov    %eax,%edx
  102349:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10234c:	c1 f8 18             	sar    $0x18,%eax
  10234f:	83 e0 0f             	and    $0xf,%eax
  102352:	09 d0                	or     %edx,%eax
  102354:	83 c8 e0             	or     $0xffffffe0,%eax
  102357:	0f b6 c0             	movzbl %al,%eax
  10235a:	83 ec 08             	sub    $0x8,%esp
  10235d:	50                   	push   %eax
  10235e:	68 f6 01 00 00       	push   $0x1f6
  102363:	e8 af fd ff ff       	call   102117 <outb>
  102368:	83 c4 10             	add    $0x10,%esp
  if(b->flags & B_DIRTY){
  10236b:	8b 45 08             	mov    0x8(%ebp),%eax
  10236e:	8b 00                	mov    (%eax),%eax
  102370:	83 e0 04             	and    $0x4,%eax
  102373:	85 c0                	test   %eax,%eax
  102375:	74 37                	je     1023ae <idestart+0x17a>
    outb(0x1f7, write_cmd);
  102377:	8b 45 e8             	mov    -0x18(%ebp),%eax
  10237a:	0f b6 c0             	movzbl %al,%eax
  10237d:	83 ec 08             	sub    $0x8,%esp
  102380:	50                   	push   %eax
  102381:	68 f7 01 00 00       	push   $0x1f7
  102386:	e8 8c fd ff ff       	call   102117 <outb>
  10238b:	83 c4 10             	add    $0x10,%esp
    outsl(0x1f0, b->data, BSIZE/4);
  10238e:	8b 45 08             	mov    0x8(%ebp),%eax
  102391:	05 20 02 00 00       	add    $0x220,%eax
  102396:	83 ec 04             	sub    $0x4,%esp
  102399:	68 80 00 00 00       	push   $0x80
  10239e:	50                   	push   %eax
  10239f:	68 f0 01 00 00       	push   $0x1f0
  1023a4:	e8 8d fd ff ff       	call   102136 <outsl>
  1023a9:	83 c4 10             	add    $0x10,%esp
}
  1023ac:	eb 17                	jmp    1023c5 <idestart+0x191>
    outb(0x1f7, read_cmd);
  1023ae:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1023b1:	0f b6 c0             	movzbl %al,%eax
  1023b4:	83 ec 08             	sub    $0x8,%esp
  1023b7:	50                   	push   %eax
  1023b8:	68 f7 01 00 00       	push   $0x1f7
  1023bd:	e8 55 fd ff ff       	call   102117 <outb>
  1023c2:	83 c4 10             	add    $0x10,%esp
}
  1023c5:	90                   	nop
  1023c6:	c9                   	leave
  1023c7:	c3                   	ret

001023c8 <ideintr>:
{
  1023c8:	55                   	push   %ebp
  1023c9:	89 e5                	mov    %esp,%ebp
  1023cb:	83 ec 18             	sub    $0x18,%esp
  if((b = idequeue) == 0){
  1023ce:	a1 e0 dc 10 00       	mov    0x10dce0,%eax
  1023d3:	89 45 f4             	mov    %eax,-0xc(%ebp)
  1023d6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  1023da:	74 7a                	je     102456 <ideintr+0x8e>
  idequeue = b->qnext;
  1023dc:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1023df:	8b 40 18             	mov    0x18(%eax),%eax
  1023e2:	a3 e0 dc 10 00       	mov    %eax,0x10dce0
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
  1023e7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1023ea:	8b 00                	mov    (%eax),%eax
  1023ec:	83 e0 04             	and    $0x4,%eax
  1023ef:	85 c0                	test   %eax,%eax
  1023f1:	75 29                	jne    10241c <ideintr+0x54>
  1023f3:	6a 01                	push   $0x1
  1023f5:	e8 69 fd ff ff       	call   102163 <idewait>
  1023fa:	83 c4 04             	add    $0x4,%esp
  1023fd:	85 c0                	test   %eax,%eax
  1023ff:	78 1b                	js     10241c <ideintr+0x54>
    insl(0x1f0, b->data, BSIZE/4);
  102401:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102404:	05 20 02 00 00       	add    $0x220,%eax
  102409:	68 80 00 00 00       	push   $0x80
  10240e:	50                   	push   %eax
  10240f:	68 f0 01 00 00       	push   $0x1f0
  102414:	e8 d8 fc ff ff       	call   1020f1 <insl>
  102419:	83 c4 0c             	add    $0xc,%esp
  b->flags |= B_VALID;
  10241c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10241f:	8b 00                	mov    (%eax),%eax
  102421:	83 c8 02             	or     $0x2,%eax
  102424:	89 c2                	mov    %eax,%edx
  102426:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102429:	89 10                	mov    %edx,(%eax)
  b->flags &= ~B_DIRTY;
  10242b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10242e:	8b 00                	mov    (%eax),%eax
  102430:	83 e0 fb             	and    $0xfffffffb,%eax
  102433:	89 c2                	mov    %eax,%edx
  102435:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102438:	89 10                	mov    %edx,(%eax)

  // Start disk on next buf in queue.
  if(idequeue != 0)
  10243a:	a1 e0 dc 10 00       	mov    0x10dce0,%eax
  10243f:	85 c0                	test   %eax,%eax
  102441:	74 14                	je     102457 <ideintr+0x8f>
    idestart(idequeue);
  102443:	a1 e0 dc 10 00       	mov    0x10dce0,%eax
  102448:	83 ec 0c             	sub    $0xc,%esp
  10244b:	50                   	push   %eax
  10244c:	e8 e3 fd ff ff       	call   102234 <idestart>
  102451:	83 c4 10             	add    $0x10,%esp
  102454:	eb 01                	jmp    102457 <ideintr+0x8f>
    return;
  102456:	90                   	nop
}
  102457:	c9                   	leave
  102458:	c3                   	ret

00102459 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
  102459:	55                   	push   %ebp
  10245a:	89 e5                	mov    %esp,%ebp
  10245c:	83 ec 18             	sub    $0x18,%esp
  struct buf **pp;

  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
  10245f:	8b 45 08             	mov    0x8(%ebp),%eax
  102462:	8b 00                	mov    (%eax),%eax
  102464:	83 e0 06             	and    $0x6,%eax
  102467:	83 f8 02             	cmp    $0x2,%eax
  10246a:	75 0d                	jne    102479 <iderw+0x20>
    panic("iderw: nothing to do");
  10246c:	83 ec 0c             	sub    $0xc,%esp
  10246f:	68 c4 43 10 00       	push   $0x1043c4
  102474:	e8 35 de ff ff       	call   1002ae <panic>
  if(b->dev != 0 && !havedisk1)
  102479:	8b 45 08             	mov    0x8(%ebp),%eax
  10247c:	8b 40 04             	mov    0x4(%eax),%eax
  10247f:	85 c0                	test   %eax,%eax
  102481:	74 16                	je     102499 <iderw+0x40>
  102483:	a1 e4 dc 10 00       	mov    0x10dce4,%eax
  102488:	85 c0                	test   %eax,%eax
  10248a:	75 0d                	jne    102499 <iderw+0x40>
    panic("iderw: ide disk 1 not present");
  10248c:	83 ec 0c             	sub    $0xc,%esp
  10248f:	68 d9 43 10 00       	push   $0x1043d9
  102494:	e8 15 de ff ff       	call   1002ae <panic>

  // Append b to idequeue.
  b->qnext = 0;
  102499:	8b 45 08             	mov    0x8(%ebp),%eax
  10249c:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
  1024a3:	c7 45 f4 e0 dc 10 00 	movl   $0x10dce0,-0xc(%ebp)
  1024aa:	eb 0b                	jmp    1024b7 <iderw+0x5e>
  1024ac:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1024af:	8b 00                	mov    (%eax),%eax
  1024b1:	83 c0 18             	add    $0x18,%eax
  1024b4:	89 45 f4             	mov    %eax,-0xc(%ebp)
  1024b7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1024ba:	8b 00                	mov    (%eax),%eax
  1024bc:	85 c0                	test   %eax,%eax
  1024be:	75 ec                	jne    1024ac <iderw+0x53>
    ;
  *pp = b;
  1024c0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1024c3:	8b 55 08             	mov    0x8(%ebp),%edx
  1024c6:	89 10                	mov    %edx,(%eax)

  // Start disk if necessary.
  if(idequeue == b)
  1024c8:	a1 e0 dc 10 00       	mov    0x10dce0,%eax
  1024cd:	39 45 08             	cmp    %eax,0x8(%ebp)
  1024d0:	75 15                	jne    1024e7 <iderw+0x8e>
    idestart(b);
  1024d2:	83 ec 0c             	sub    $0xc,%esp
  1024d5:	ff 75 08             	push   0x8(%ebp)
  1024d8:	e8 57 fd ff ff       	call   102234 <idestart>
  1024dd:	83 c4 10             	add    $0x10,%esp

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID)
  1024e0:	eb 05                	jmp    1024e7 <iderw+0x8e>
  {
    // Warning: If we do not call noop(), compiler generates code that does not
    // read "b->flags" again and therefore never come out of this while loop. 
    // "b->flags" is modified by the trap handler in ideintr().  
    noop();
  1024e2:	e8 75 fc ff ff       	call   10215c <noop>
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID)
  1024e7:	8b 45 08             	mov    0x8(%ebp),%eax
  1024ea:	8b 00                	mov    (%eax),%eax
  1024ec:	83 e0 06             	and    $0x6,%eax
  1024ef:	83 f8 02             	cmp    $0x2,%eax
  1024f2:	75 ee                	jne    1024e2 <iderw+0x89>
  }
}
  1024f4:	90                   	nop
  1024f5:	90                   	nop
  1024f6:	c9                   	leave
  1024f7:	c3                   	ret

001024f8 <readsb>:
struct superblock sb; 

// Read the super block.
void
readsb(int dev, struct superblock *sb)
{
  1024f8:	55                   	push   %ebp
  1024f9:	89 e5                	mov    %esp,%ebp
  1024fb:	83 ec 18             	sub    $0x18,%esp
  struct buf *bp;

  bp = bread(dev, 1);
  1024fe:	8b 45 08             	mov    0x8(%ebp),%eax
  102501:	83 ec 08             	sub    $0x8,%esp
  102504:	6a 01                	push   $0x1
  102506:	50                   	push   %eax
  102507:	e8 dc fa ff ff       	call   101fe8 <bread>
  10250c:	83 c4 10             	add    $0x10,%esp
  10250f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memmove(sb, bp->data, sizeof(*sb));
  102512:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102515:	05 20 02 00 00       	add    $0x220,%eax
  10251a:	83 ec 04             	sub    $0x4,%esp
  10251d:	6a 1c                	push   $0x1c
  10251f:	50                   	push   %eax
  102520:	ff 75 0c             	push   0xc(%ebp)
  102523:	e8 2a ea ff ff       	call   100f52 <memmove>
  102528:	83 c4 10             	add    $0x10,%esp
  brelse(bp);
  10252b:	83 ec 0c             	sub    $0xc,%esp
  10252e:	ff 75 f4             	push   -0xc(%ebp)
  102531:	e8 38 fb ff ff       	call   10206e <brelse>
  102536:	83 c4 10             	add    $0x10,%esp
}
  102539:	90                   	nop
  10253a:	c9                   	leave
  10253b:	c3                   	ret

0010253c <bzero>:

// Zero a block.
static void
bzero(int dev, int bno)
{
  10253c:	55                   	push   %ebp
  10253d:	89 e5                	mov    %esp,%ebp
  10253f:	83 ec 18             	sub    $0x18,%esp
  struct buf *bp;

  bp = bread_wr(dev, bno);
  102542:	8b 55 0c             	mov    0xc(%ebp),%edx
  102545:	8b 45 08             	mov    0x8(%ebp),%eax
  102548:	83 ec 08             	sub    $0x8,%esp
  10254b:	52                   	push   %edx
  10254c:	50                   	push   %eax
  10254d:	e8 03 fb ff ff       	call   102055 <bread_wr>
  102552:	83 c4 10             	add    $0x10,%esp
  102555:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(bp->data, 0, BSIZE);
  102558:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10255b:	05 20 02 00 00       	add    $0x220,%eax
  102560:	83 ec 04             	sub    $0x4,%esp
  102563:	68 00 02 00 00       	push   $0x200
  102568:	6a 00                	push   $0x0
  10256a:	50                   	push   %eax
  10256b:	e8 23 e9 ff ff       	call   100e93 <memset>
  102570:	83 c4 10             	add    $0x10,%esp
  log_write(bp);
  102573:	83 ec 0c             	sub    $0xc,%esp
  102576:	ff 75 f4             	push   -0xc(%ebp)
  102579:	e8 d7 1a 00 00       	call   104055 <log_write>
  10257e:	83 c4 10             	add    $0x10,%esp
  brelse(bp);
  102581:	83 ec 0c             	sub    $0xc,%esp
  102584:	ff 75 f4             	push   -0xc(%ebp)
  102587:	e8 e2 fa ff ff       	call   10206e <brelse>
  10258c:	83 c4 10             	add    $0x10,%esp
}
  10258f:	90                   	nop
  102590:	c9                   	leave
  102591:	c3                   	ret

00102592 <balloc>:
// Blocks.

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
  102592:	55                   	push   %ebp
  102593:	89 e5                	mov    %esp,%ebp
  102595:	83 ec 18             	sub    $0x18,%esp
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  102598:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(b = 0; b < sb.size; b += BPB){
  10259f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  1025a6:	e9 14 01 00 00       	jmp    1026bf <balloc+0x12d>
    bp = bread_wr(dev, BBLOCK(b, sb));
  1025ab:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1025ae:	8d 90 ff 0f 00 00    	lea    0xfff(%eax),%edx
  1025b4:	85 c0                	test   %eax,%eax
  1025b6:	0f 48 c2             	cmovs  %edx,%eax
  1025b9:	c1 f8 0c             	sar    $0xc,%eax
  1025bc:	89 c2                	mov    %eax,%edx
  1025be:	a1 18 dd 10 00       	mov    0x10dd18,%eax
  1025c3:	01 d0                	add    %edx,%eax
  1025c5:	83 ec 08             	sub    $0x8,%esp
  1025c8:	50                   	push   %eax
  1025c9:	ff 75 08             	push   0x8(%ebp)
  1025cc:	e8 84 fa ff ff       	call   102055 <bread_wr>
  1025d1:	83 c4 10             	add    $0x10,%esp
  1025d4:	89 45 ec             	mov    %eax,-0x14(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
  1025d7:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  1025de:	e9 a7 00 00 00       	jmp    10268a <balloc+0xf8>
      m = 1 << (bi % 8);
  1025e3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1025e6:	83 e0 07             	and    $0x7,%eax
  1025e9:	ba 01 00 00 00       	mov    $0x1,%edx
  1025ee:	89 c1                	mov    %eax,%ecx
  1025f0:	d3 e2                	shl    %cl,%edx
  1025f2:	89 d0                	mov    %edx,%eax
  1025f4:	89 45 e8             	mov    %eax,-0x18(%ebp)
      if((bp->data[bi/8] & m) == 0){  // Is block free?
  1025f7:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1025fa:	8d 50 07             	lea    0x7(%eax),%edx
  1025fd:	85 c0                	test   %eax,%eax
  1025ff:	0f 48 c2             	cmovs  %edx,%eax
  102602:	c1 f8 03             	sar    $0x3,%eax
  102605:	89 c2                	mov    %eax,%edx
  102607:	8b 45 ec             	mov    -0x14(%ebp),%eax
  10260a:	0f b6 84 10 20 02 00 	movzbl 0x220(%eax,%edx,1),%eax
  102611:	00 
  102612:	0f b6 c0             	movzbl %al,%eax
  102615:	23 45 e8             	and    -0x18(%ebp),%eax
  102618:	85 c0                	test   %eax,%eax
  10261a:	75 6a                	jne    102686 <balloc+0xf4>
        bp->data[bi/8] |= m;  // Mark block in use.
  10261c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10261f:	8d 50 07             	lea    0x7(%eax),%edx
  102622:	85 c0                	test   %eax,%eax
  102624:	0f 48 c2             	cmovs  %edx,%eax
  102627:	c1 f8 03             	sar    $0x3,%eax
  10262a:	8b 55 ec             	mov    -0x14(%ebp),%edx
  10262d:	0f b6 94 02 20 02 00 	movzbl 0x220(%edx,%eax,1),%edx
  102634:	00 
  102635:	89 d1                	mov    %edx,%ecx
  102637:	8b 55 e8             	mov    -0x18(%ebp),%edx
  10263a:	09 ca                	or     %ecx,%edx
  10263c:	89 d1                	mov    %edx,%ecx
  10263e:	8b 55 ec             	mov    -0x14(%ebp),%edx
  102641:	88 8c 02 20 02 00 00 	mov    %cl,0x220(%edx,%eax,1)
        log_write(bp);
  102648:	83 ec 0c             	sub    $0xc,%esp
  10264b:	ff 75 ec             	push   -0x14(%ebp)
  10264e:	e8 02 1a 00 00       	call   104055 <log_write>
  102653:	83 c4 10             	add    $0x10,%esp
        brelse(bp);
  102656:	83 ec 0c             	sub    $0xc,%esp
  102659:	ff 75 ec             	push   -0x14(%ebp)
  10265c:	e8 0d fa ff ff       	call   10206e <brelse>
  102661:	83 c4 10             	add    $0x10,%esp
        bzero(dev, b + bi);
  102664:	8b 55 f4             	mov    -0xc(%ebp),%edx
  102667:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10266a:	01 c2                	add    %eax,%edx
  10266c:	8b 45 08             	mov    0x8(%ebp),%eax
  10266f:	83 ec 08             	sub    $0x8,%esp
  102672:	52                   	push   %edx
  102673:	50                   	push   %eax
  102674:	e8 c3 fe ff ff       	call   10253c <bzero>
  102679:	83 c4 10             	add    $0x10,%esp
        return b + bi;
  10267c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  10267f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102682:	01 d0                	add    %edx,%eax
  102684:	eb 56                	jmp    1026dc <balloc+0x14a>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
  102686:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
  10268a:	81 7d f0 ff 0f 00 00 	cmpl   $0xfff,-0x10(%ebp)
  102691:	7f 17                	jg     1026aa <balloc+0x118>
  102693:	8b 55 f4             	mov    -0xc(%ebp),%edx
  102696:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102699:	01 d0                	add    %edx,%eax
  10269b:	89 c2                	mov    %eax,%edx
  10269d:	a1 00 dd 10 00       	mov    0x10dd00,%eax
  1026a2:	39 c2                	cmp    %eax,%edx
  1026a4:	0f 82 39 ff ff ff    	jb     1025e3 <balloc+0x51>
      }
    }
    brelse(bp);
  1026aa:	83 ec 0c             	sub    $0xc,%esp
  1026ad:	ff 75 ec             	push   -0x14(%ebp)
  1026b0:	e8 b9 f9 ff ff       	call   10206e <brelse>
  1026b5:	83 c4 10             	add    $0x10,%esp
  for(b = 0; b < sb.size; b += BPB){
  1026b8:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
  1026bf:	a1 00 dd 10 00       	mov    0x10dd00,%eax
  1026c4:	8b 55 f4             	mov    -0xc(%ebp),%edx
  1026c7:	39 c2                	cmp    %eax,%edx
  1026c9:	0f 82 dc fe ff ff    	jb     1025ab <balloc+0x19>
  }
  panic("balloc: out of blocks");
  1026cf:	83 ec 0c             	sub    $0xc,%esp
  1026d2:	68 f8 43 10 00       	push   $0x1043f8
  1026d7:	e8 d2 db ff ff       	call   1002ae <panic>
}
  1026dc:	c9                   	leave
  1026dd:	c3                   	ret

001026de <bfree>:


// Free a disk block.
static void
bfree(int dev, uint b)
{
  1026de:	55                   	push   %ebp
  1026df:	89 e5                	mov    %esp,%ebp
  1026e1:	83 ec 18             	sub    $0x18,%esp
  struct buf *bp;
  int bi, m;

  bp = bread_wr(dev, BBLOCK(b, sb));
  1026e4:	8b 45 0c             	mov    0xc(%ebp),%eax
  1026e7:	c1 e8 0c             	shr    $0xc,%eax
  1026ea:	89 c2                	mov    %eax,%edx
  1026ec:	a1 18 dd 10 00       	mov    0x10dd18,%eax
  1026f1:	01 c2                	add    %eax,%edx
  1026f3:	8b 45 08             	mov    0x8(%ebp),%eax
  1026f6:	83 ec 08             	sub    $0x8,%esp
  1026f9:	52                   	push   %edx
  1026fa:	50                   	push   %eax
  1026fb:	e8 55 f9 ff ff       	call   102055 <bread_wr>
  102700:	83 c4 10             	add    $0x10,%esp
  102703:	89 45 f4             	mov    %eax,-0xc(%ebp)
  bi = b % BPB;
  102706:	8b 45 0c             	mov    0xc(%ebp),%eax
  102709:	25 ff 0f 00 00       	and    $0xfff,%eax
  10270e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  m = 1 << (bi % 8);
  102711:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102714:	83 e0 07             	and    $0x7,%eax
  102717:	ba 01 00 00 00       	mov    $0x1,%edx
  10271c:	89 c1                	mov    %eax,%ecx
  10271e:	d3 e2                	shl    %cl,%edx
  102720:	89 d0                	mov    %edx,%eax
  102722:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((bp->data[bi/8] & m) == 0)
  102725:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102728:	8d 50 07             	lea    0x7(%eax),%edx
  10272b:	85 c0                	test   %eax,%eax
  10272d:	0f 48 c2             	cmovs  %edx,%eax
  102730:	c1 f8 03             	sar    $0x3,%eax
  102733:	89 c2                	mov    %eax,%edx
  102735:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102738:	0f b6 84 10 20 02 00 	movzbl 0x220(%eax,%edx,1),%eax
  10273f:	00 
  102740:	0f b6 c0             	movzbl %al,%eax
  102743:	23 45 ec             	and    -0x14(%ebp),%eax
  102746:	85 c0                	test   %eax,%eax
  102748:	75 0d                	jne    102757 <bfree+0x79>
    panic("freeing free block");
  10274a:	83 ec 0c             	sub    $0xc,%esp
  10274d:	68 0e 44 10 00       	push   $0x10440e
  102752:	e8 57 db ff ff       	call   1002ae <panic>
  bp->data[bi/8] &= ~m;
  102757:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10275a:	8d 50 07             	lea    0x7(%eax),%edx
  10275d:	85 c0                	test   %eax,%eax
  10275f:	0f 48 c2             	cmovs  %edx,%eax
  102762:	c1 f8 03             	sar    $0x3,%eax
  102765:	8b 55 f4             	mov    -0xc(%ebp),%edx
  102768:	0f b6 94 02 20 02 00 	movzbl 0x220(%edx,%eax,1),%edx
  10276f:	00 
  102770:	89 d1                	mov    %edx,%ecx
  102772:	8b 55 ec             	mov    -0x14(%ebp),%edx
  102775:	f7 d2                	not    %edx
  102777:	21 ca                	and    %ecx,%edx
  102779:	89 d1                	mov    %edx,%ecx
  10277b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  10277e:	88 8c 02 20 02 00 00 	mov    %cl,0x220(%edx,%eax,1)
  log_write(bp);
  102785:	83 ec 0c             	sub    $0xc,%esp
  102788:	ff 75 f4             	push   -0xc(%ebp)
  10278b:	e8 c5 18 00 00       	call   104055 <log_write>
  102790:	83 c4 10             	add    $0x10,%esp
  brelse(bp);
  102793:	83 ec 0c             	sub    $0xc,%esp
  102796:	ff 75 f4             	push   -0xc(%ebp)
  102799:	e8 d0 f8 ff ff       	call   10206e <brelse>
  10279e:	83 c4 10             	add    $0x10,%esp
}
  1027a1:	90                   	nop
  1027a2:	c9                   	leave
  1027a3:	c3                   	ret

001027a4 <iinit>:
  struct inode inode[NINODE];
} icache;

void
iinit(int dev)
{
  1027a4:	55                   	push   %ebp
  1027a5:	89 e5                	mov    %esp,%ebp
  1027a7:	57                   	push   %edi
  1027a8:	56                   	push   %esi
  1027a9:	53                   	push   %ebx
  1027aa:	83 ec 1c             	sub    $0x1c,%esp
  readsb(dev, &sb);
  1027ad:	83 ec 08             	sub    $0x8,%esp
  1027b0:	68 00 dd 10 00       	push   $0x10dd00
  1027b5:	ff 75 08             	push   0x8(%ebp)
  1027b8:	e8 3b fd ff ff       	call   1024f8 <readsb>
  1027bd:	83 c4 10             	add    $0x10,%esp
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
  1027c0:	a1 18 dd 10 00       	mov    0x10dd18,%eax
  1027c5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  1027c8:	8b 3d 14 dd 10 00    	mov    0x10dd14,%edi
  1027ce:	8b 35 10 dd 10 00    	mov    0x10dd10,%esi
  1027d4:	8b 1d 0c dd 10 00    	mov    0x10dd0c,%ebx
  1027da:	8b 0d 08 dd 10 00    	mov    0x10dd08,%ecx
  1027e0:	8b 15 04 dd 10 00    	mov    0x10dd04,%edx
  1027e6:	a1 00 dd 10 00       	mov    0x10dd00,%eax
  1027eb:	ff 75 e4             	push   -0x1c(%ebp)
  1027ee:	57                   	push   %edi
  1027ef:	56                   	push   %esi
  1027f0:	53                   	push   %ebx
  1027f1:	51                   	push   %ecx
  1027f2:	52                   	push   %edx
  1027f3:	50                   	push   %eax
  1027f4:	68 24 44 10 00       	push   $0x104424
  1027f9:	e8 ee d8 ff ff       	call   1000ec <cprintf>
  1027fe:	83 c4 20             	add    $0x20,%esp
 inodestart %d bmap start %d\n", sb.size, sb.nblocks,
          sb.ninodes, sb.nlog, sb.logstart, sb.inodestart,
          sb.bmapstart);
}
  102801:	90                   	nop
  102802:	8d 65 f4             	lea    -0xc(%ebp),%esp
  102805:	5b                   	pop    %ebx
  102806:	5e                   	pop    %esi
  102807:	5f                   	pop    %edi
  102808:	5d                   	pop    %ebp
  102809:	c3                   	ret

0010280a <ialloc>:
// Allocate an inode on device dev.
// Mark it as allocated by  giving it type type.
// Returns an unlocked but allocated and referenced inode.
struct inode*
ialloc(uint dev, short type)
{
  10280a:	55                   	push   %ebp
  10280b:	89 e5                	mov    %esp,%ebp
  10280d:	83 ec 28             	sub    $0x28,%esp
  102810:	8b 45 0c             	mov    0xc(%ebp),%eax
  102813:	66 89 45 e4          	mov    %ax,-0x1c(%ebp)
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
  102817:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
  10281e:	e9 a1 00 00 00       	jmp    1028c4 <ialloc+0xba>
    bp = bread_wr(dev, IBLOCK(inum, sb));
  102823:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102826:	c1 e8 03             	shr    $0x3,%eax
  102829:	89 c2                	mov    %eax,%edx
  10282b:	a1 14 dd 10 00       	mov    0x10dd14,%eax
  102830:	01 d0                	add    %edx,%eax
  102832:	83 ec 08             	sub    $0x8,%esp
  102835:	50                   	push   %eax
  102836:	ff 75 08             	push   0x8(%ebp)
  102839:	e8 17 f8 ff ff       	call   102055 <bread_wr>
  10283e:	83 c4 10             	add    $0x10,%esp
  102841:	89 45 f0             	mov    %eax,-0x10(%ebp)
    dip = (struct dinode*)bp->data + inum%IPB;
  102844:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102847:	8d 90 20 02 00 00    	lea    0x220(%eax),%edx
  10284d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102850:	83 e0 07             	and    $0x7,%eax
  102853:	c1 e0 06             	shl    $0x6,%eax
  102856:	01 d0                	add    %edx,%eax
  102858:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(dip->type == 0){  // a free inode
  10285b:	8b 45 ec             	mov    -0x14(%ebp),%eax
  10285e:	0f b7 00             	movzwl (%eax),%eax
  102861:	66 85 c0             	test   %ax,%ax
  102864:	75 4c                	jne    1028b2 <ialloc+0xa8>
      memset(dip, 0, sizeof(*dip));
  102866:	83 ec 04             	sub    $0x4,%esp
  102869:	6a 40                	push   $0x40
  10286b:	6a 00                	push   $0x0
  10286d:	ff 75 ec             	push   -0x14(%ebp)
  102870:	e8 1e e6 ff ff       	call   100e93 <memset>
  102875:	83 c4 10             	add    $0x10,%esp
      dip->type = type;
  102878:	8b 45 ec             	mov    -0x14(%ebp),%eax
  10287b:	0f b7 55 e4          	movzwl -0x1c(%ebp),%edx
  10287f:	66 89 10             	mov    %dx,(%eax)
      log_write(bp);   // mark it allocated on the disk
  102882:	83 ec 0c             	sub    $0xc,%esp
  102885:	ff 75 f0             	push   -0x10(%ebp)
  102888:	e8 c8 17 00 00       	call   104055 <log_write>
  10288d:	83 c4 10             	add    $0x10,%esp
      brelse(bp);
  102890:	83 ec 0c             	sub    $0xc,%esp
  102893:	ff 75 f0             	push   -0x10(%ebp)
  102896:	e8 d3 f7 ff ff       	call   10206e <brelse>
  10289b:	83 c4 10             	add    $0x10,%esp
      return iget(dev, inum);
  10289e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1028a1:	83 ec 08             	sub    $0x8,%esp
  1028a4:	50                   	push   %eax
  1028a5:	ff 75 08             	push   0x8(%ebp)
  1028a8:	e8 66 01 00 00       	call   102a13 <iget>
  1028ad:	83 c4 10             	add    $0x10,%esp
  1028b0:	eb 2f                	jmp    1028e1 <ialloc+0xd7>
    }
    brelse(bp);
  1028b2:	83 ec 0c             	sub    $0xc,%esp
  1028b5:	ff 75 f0             	push   -0x10(%ebp)
  1028b8:	e8 b1 f7 ff ff       	call   10206e <brelse>
  1028bd:	83 c4 10             	add    $0x10,%esp
  for(inum = 1; inum < sb.ninodes; inum++){
  1028c0:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  1028c4:	a1 08 dd 10 00       	mov    0x10dd08,%eax
  1028c9:	8b 55 f4             	mov    -0xc(%ebp),%edx
  1028cc:	39 c2                	cmp    %eax,%edx
  1028ce:	0f 82 4f ff ff ff    	jb     102823 <ialloc+0x19>
  }
  panic("ialloc: no inodes");
  1028d4:	83 ec 0c             	sub    $0xc,%esp
  1028d7:	68 77 44 10 00       	push   $0x104477
  1028dc:	e8 cd d9 ff ff       	call   1002ae <panic>
}
  1028e1:	c9                   	leave
  1028e2:	c3                   	ret

001028e3 <iput>:
// be recycled.
// If that was the last reference and the inode has no links
// to it, free the inode (and its content) on disk.
void
iput(struct inode *ip)
{
  1028e3:	55                   	push   %ebp
  1028e4:	89 e5                	mov    %esp,%ebp
  1028e6:	83 ec 18             	sub    $0x18,%esp
  if(ip->valid && ip->nlink == 0){
  1028e9:	8b 45 08             	mov    0x8(%ebp),%eax
  1028ec:	8b 40 0c             	mov    0xc(%eax),%eax
  1028ef:	85 c0                	test   %eax,%eax
  1028f1:	74 4a                	je     10293d <iput+0x5a>
  1028f3:	8b 45 08             	mov    0x8(%ebp),%eax
  1028f6:	0f b7 40 16          	movzwl 0x16(%eax),%eax
  1028fa:	66 85 c0             	test   %ax,%ax
  1028fd:	75 3e                	jne    10293d <iput+0x5a>
    int r = ip->ref;
  1028ff:	8b 45 08             	mov    0x8(%ebp),%eax
  102902:	8b 40 08             	mov    0x8(%eax),%eax
  102905:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(r == 1){
  102908:	83 7d f4 01          	cmpl   $0x1,-0xc(%ebp)
  10290c:	75 2f                	jne    10293d <iput+0x5a>
      // inode has no links and no other references: truncate and free.
      itrunc(ip);
  10290e:	83 ec 0c             	sub    $0xc,%esp
  102911:	ff 75 08             	push   0x8(%ebp)
  102914:	e8 c9 03 00 00       	call   102ce2 <itrunc>
  102919:	83 c4 10             	add    $0x10,%esp
      ip->type = 0;
  10291c:	8b 45 08             	mov    0x8(%ebp),%eax
  10291f:	66 c7 40 10 00 00    	movw   $0x0,0x10(%eax)
      iupdate(ip);
  102925:	83 ec 0c             	sub    $0xc,%esp
  102928:	ff 75 08             	push   0x8(%ebp)
  10292b:	e8 1f 00 00 00       	call   10294f <iupdate>
  102930:	83 c4 10             	add    $0x10,%esp
      ip->valid = 0;
  102933:	8b 45 08             	mov    0x8(%ebp),%eax
  102936:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    }
  }
  ip->ref--;
  10293d:	8b 45 08             	mov    0x8(%ebp),%eax
  102940:	8b 40 08             	mov    0x8(%eax),%eax
  102943:	8d 50 ff             	lea    -0x1(%eax),%edx
  102946:	8b 45 08             	mov    0x8(%ebp),%eax
  102949:	89 50 08             	mov    %edx,0x8(%eax)
}
  10294c:	90                   	nop
  10294d:	c9                   	leave
  10294e:	c3                   	ret

0010294f <iupdate>:
// Copy a modified in-memory inode to disk.
// Must be called after every change to an ip->xxx field
// that lives on disk, since i-node cache is write-through.
void
iupdate(struct inode *ip)
{
  10294f:	55                   	push   %ebp
  102950:	89 e5                	mov    %esp,%ebp
  102952:	83 ec 18             	sub    $0x18,%esp
  struct buf *bp;
  struct dinode *dip;

  bp = bread_wr(ip->dev, IBLOCK(ip->inum, sb));
  102955:	8b 45 08             	mov    0x8(%ebp),%eax
  102958:	8b 40 04             	mov    0x4(%eax),%eax
  10295b:	c1 e8 03             	shr    $0x3,%eax
  10295e:	89 c2                	mov    %eax,%edx
  102960:	a1 14 dd 10 00       	mov    0x10dd14,%eax
  102965:	01 c2                	add    %eax,%edx
  102967:	8b 45 08             	mov    0x8(%ebp),%eax
  10296a:	8b 00                	mov    (%eax),%eax
  10296c:	83 ec 08             	sub    $0x8,%esp
  10296f:	52                   	push   %edx
  102970:	50                   	push   %eax
  102971:	e8 df f6 ff ff       	call   102055 <bread_wr>
  102976:	83 c4 10             	add    $0x10,%esp
  102979:	89 45 f4             	mov    %eax,-0xc(%ebp)
  dip = (struct dinode*)bp->data + ip->inum%IPB;
  10297c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10297f:	8d 90 20 02 00 00    	lea    0x220(%eax),%edx
  102985:	8b 45 08             	mov    0x8(%ebp),%eax
  102988:	8b 40 04             	mov    0x4(%eax),%eax
  10298b:	83 e0 07             	and    $0x7,%eax
  10298e:	c1 e0 06             	shl    $0x6,%eax
  102991:	01 d0                	add    %edx,%eax
  102993:	89 45 f0             	mov    %eax,-0x10(%ebp)
  dip->type = ip->type;
  102996:	8b 45 08             	mov    0x8(%ebp),%eax
  102999:	0f b7 50 10          	movzwl 0x10(%eax),%edx
  10299d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1029a0:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
  1029a3:	8b 45 08             	mov    0x8(%ebp),%eax
  1029a6:	0f b7 50 12          	movzwl 0x12(%eax),%edx
  1029aa:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1029ad:	66 89 50 02          	mov    %dx,0x2(%eax)
  dip->minor = ip->minor;
  1029b1:	8b 45 08             	mov    0x8(%ebp),%eax
  1029b4:	0f b7 50 14          	movzwl 0x14(%eax),%edx
  1029b8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1029bb:	66 89 50 04          	mov    %dx,0x4(%eax)
  dip->nlink = ip->nlink;
  1029bf:	8b 45 08             	mov    0x8(%ebp),%eax
  1029c2:	0f b7 50 16          	movzwl 0x16(%eax),%edx
  1029c6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1029c9:	66 89 50 06          	mov    %dx,0x6(%eax)
  dip->size = ip->size;
  1029cd:	8b 45 08             	mov    0x8(%ebp),%eax
  1029d0:	8b 50 18             	mov    0x18(%eax),%edx
  1029d3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1029d6:	89 50 08             	mov    %edx,0x8(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
  1029d9:	8b 45 08             	mov    0x8(%ebp),%eax
  1029dc:	8d 50 1c             	lea    0x1c(%eax),%edx
  1029df:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1029e2:	83 c0 0c             	add    $0xc,%eax
  1029e5:	83 ec 04             	sub    $0x4,%esp
  1029e8:	6a 34                	push   $0x34
  1029ea:	52                   	push   %edx
  1029eb:	50                   	push   %eax
  1029ec:	e8 61 e5 ff ff       	call   100f52 <memmove>
  1029f1:	83 c4 10             	add    $0x10,%esp
  log_write(bp);
  1029f4:	83 ec 0c             	sub    $0xc,%esp
  1029f7:	ff 75 f4             	push   -0xc(%ebp)
  1029fa:	e8 56 16 00 00       	call   104055 <log_write>
  1029ff:	83 c4 10             	add    $0x10,%esp
  brelse(bp);
  102a02:	83 ec 0c             	sub    $0xc,%esp
  102a05:	ff 75 f4             	push   -0xc(%ebp)
  102a08:	e8 61 f6 ff ff       	call   10206e <brelse>
  102a0d:	83 c4 10             	add    $0x10,%esp
}
  102a10:	90                   	nop
  102a11:	c9                   	leave
  102a12:	c3                   	ret

00102a13 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
struct inode*
iget(uint dev, uint inum)
{
  102a13:	55                   	push   %ebp
  102a14:	89 e5                	mov    %esp,%ebp
  102a16:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip, *empty;

  // Is the inode already cached?
  empty = 0;
  102a19:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
  102a20:	c7 45 f4 20 dd 10 00 	movl   $0x10dd20,-0xc(%ebp)
  102a27:	eb 4d                	jmp    102a76 <iget+0x63>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
  102a29:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102a2c:	8b 40 08             	mov    0x8(%eax),%eax
  102a2f:	85 c0                	test   %eax,%eax
  102a31:	7e 29                	jle    102a5c <iget+0x49>
  102a33:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102a36:	8b 00                	mov    (%eax),%eax
  102a38:	39 45 08             	cmp    %eax,0x8(%ebp)
  102a3b:	75 1f                	jne    102a5c <iget+0x49>
  102a3d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102a40:	8b 40 04             	mov    0x4(%eax),%eax
  102a43:	39 45 0c             	cmp    %eax,0xc(%ebp)
  102a46:	75 14                	jne    102a5c <iget+0x49>
      ip->ref++;
  102a48:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102a4b:	8b 40 08             	mov    0x8(%eax),%eax
  102a4e:	8d 50 01             	lea    0x1(%eax),%edx
  102a51:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102a54:	89 50 08             	mov    %edx,0x8(%eax)
      return ip;
  102a57:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102a5a:	eb 64                	jmp    102ac0 <iget+0xad>
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
  102a5c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  102a60:	75 10                	jne    102a72 <iget+0x5f>
  102a62:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102a65:	8b 40 08             	mov    0x8(%eax),%eax
  102a68:	85 c0                	test   %eax,%eax
  102a6a:	75 06                	jne    102a72 <iget+0x5f>
      empty = ip;
  102a6c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102a6f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
  102a72:	83 45 f4 50          	addl   $0x50,-0xc(%ebp)
  102a76:	81 7d f4 c0 ec 10 00 	cmpl   $0x10ecc0,-0xc(%ebp)
  102a7d:	72 aa                	jb     102a29 <iget+0x16>
  }

  // Recycle an inode cache entry.
  if(empty == 0)
  102a7f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  102a83:	75 0d                	jne    102a92 <iget+0x7f>
    panic("iget: no inodes");
  102a85:	83 ec 0c             	sub    $0xc,%esp
  102a88:	68 89 44 10 00       	push   $0x104489
  102a8d:	e8 1c d8 ff ff       	call   1002ae <panic>

  ip = empty;
  102a92:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102a95:	89 45 f4             	mov    %eax,-0xc(%ebp)
  ip->dev = dev;
  102a98:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102a9b:	8b 55 08             	mov    0x8(%ebp),%edx
  102a9e:	89 10                	mov    %edx,(%eax)
  ip->inum = inum;
  102aa0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102aa3:	8b 55 0c             	mov    0xc(%ebp),%edx
  102aa6:	89 50 04             	mov    %edx,0x4(%eax)
  ip->ref = 1;
  102aa9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102aac:	c7 40 08 01 00 00 00 	movl   $0x1,0x8(%eax)
  ip->valid = 0;
  102ab3:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102ab6:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)

  return ip;
  102abd:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  102ac0:	c9                   	leave
  102ac1:	c3                   	ret

00102ac2 <iread>:

// Reads the inode from disk if necessary.
void
iread(struct inode *ip)
{
  102ac2:	55                   	push   %ebp
  102ac3:	89 e5                	mov    %esp,%ebp
  102ac5:	83 ec 18             	sub    $0x18,%esp
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
  102ac8:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  102acc:	74 0a                	je     102ad8 <iread+0x16>
  102ace:	8b 45 08             	mov    0x8(%ebp),%eax
  102ad1:	8b 40 08             	mov    0x8(%eax),%eax
  102ad4:	85 c0                	test   %eax,%eax
  102ad6:	7f 0d                	jg     102ae5 <iread+0x23>
    panic("iread");
  102ad8:	83 ec 0c             	sub    $0xc,%esp
  102adb:	68 99 44 10 00       	push   $0x104499
  102ae0:	e8 c9 d7 ff ff       	call   1002ae <panic>

  if(ip->valid == 0){
  102ae5:	8b 45 08             	mov    0x8(%ebp),%eax
  102ae8:	8b 40 0c             	mov    0xc(%eax),%eax
  102aeb:	85 c0                	test   %eax,%eax
  102aed:	0f 85 d0 00 00 00    	jne    102bc3 <iread+0x101>
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
  102af3:	8b 45 08             	mov    0x8(%ebp),%eax
  102af6:	8b 40 04             	mov    0x4(%eax),%eax
  102af9:	c1 e8 03             	shr    $0x3,%eax
  102afc:	89 c2                	mov    %eax,%edx
  102afe:	a1 14 dd 10 00       	mov    0x10dd14,%eax
  102b03:	01 c2                	add    %eax,%edx
  102b05:	8b 45 08             	mov    0x8(%ebp),%eax
  102b08:	8b 00                	mov    (%eax),%eax
  102b0a:	83 ec 08             	sub    $0x8,%esp
  102b0d:	52                   	push   %edx
  102b0e:	50                   	push   %eax
  102b0f:	e8 d4 f4 ff ff       	call   101fe8 <bread>
  102b14:	83 c4 10             	add    $0x10,%esp
  102b17:	89 45 f4             	mov    %eax,-0xc(%ebp)
    dip = (struct dinode*)bp->data + ip->inum%IPB;
  102b1a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102b1d:	8d 90 20 02 00 00    	lea    0x220(%eax),%edx
  102b23:	8b 45 08             	mov    0x8(%ebp),%eax
  102b26:	8b 40 04             	mov    0x4(%eax),%eax
  102b29:	83 e0 07             	and    $0x7,%eax
  102b2c:	c1 e0 06             	shl    $0x6,%eax
  102b2f:	01 d0                	add    %edx,%eax
  102b31:	89 45 f0             	mov    %eax,-0x10(%ebp)
    ip->type = dip->type;
  102b34:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102b37:	0f b7 10             	movzwl (%eax),%edx
  102b3a:	8b 45 08             	mov    0x8(%ebp),%eax
  102b3d:	66 89 50 10          	mov    %dx,0x10(%eax)
    ip->major = dip->major;
  102b41:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102b44:	0f b7 50 02          	movzwl 0x2(%eax),%edx
  102b48:	8b 45 08             	mov    0x8(%ebp),%eax
  102b4b:	66 89 50 12          	mov    %dx,0x12(%eax)
    ip->minor = dip->minor;
  102b4f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102b52:	0f b7 50 04          	movzwl 0x4(%eax),%edx
  102b56:	8b 45 08             	mov    0x8(%ebp),%eax
  102b59:	66 89 50 14          	mov    %dx,0x14(%eax)
    ip->nlink = dip->nlink;
  102b5d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102b60:	0f b7 50 06          	movzwl 0x6(%eax),%edx
  102b64:	8b 45 08             	mov    0x8(%ebp),%eax
  102b67:	66 89 50 16          	mov    %dx,0x16(%eax)
    ip->size = dip->size;
  102b6b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102b6e:	8b 50 08             	mov    0x8(%eax),%edx
  102b71:	8b 45 08             	mov    0x8(%ebp),%eax
  102b74:	89 50 18             	mov    %edx,0x18(%eax)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
  102b77:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102b7a:	8d 50 0c             	lea    0xc(%eax),%edx
  102b7d:	8b 45 08             	mov    0x8(%ebp),%eax
  102b80:	83 c0 1c             	add    $0x1c,%eax
  102b83:	83 ec 04             	sub    $0x4,%esp
  102b86:	6a 34                	push   $0x34
  102b88:	52                   	push   %edx
  102b89:	50                   	push   %eax
  102b8a:	e8 c3 e3 ff ff       	call   100f52 <memmove>
  102b8f:	83 c4 10             	add    $0x10,%esp
    brelse(bp);
  102b92:	83 ec 0c             	sub    $0xc,%esp
  102b95:	ff 75 f4             	push   -0xc(%ebp)
  102b98:	e8 d1 f4 ff ff       	call   10206e <brelse>
  102b9d:	83 c4 10             	add    $0x10,%esp
    ip->valid = 1;
  102ba0:	8b 45 08             	mov    0x8(%ebp),%eax
  102ba3:	c7 40 0c 01 00 00 00 	movl   $0x1,0xc(%eax)
    if(ip->type == 0)
  102baa:	8b 45 08             	mov    0x8(%ebp),%eax
  102bad:	0f b7 40 10          	movzwl 0x10(%eax),%eax
  102bb1:	66 85 c0             	test   %ax,%ax
  102bb4:	75 0d                	jne    102bc3 <iread+0x101>
      panic("iread: no type");
  102bb6:	83 ec 0c             	sub    $0xc,%esp
  102bb9:	68 9f 44 10 00       	push   $0x10449f
  102bbe:	e8 eb d6 ff ff       	call   1002ae <panic>
  }
}
  102bc3:	90                   	nop
  102bc4:	c9                   	leave
  102bc5:	c3                   	ret

00102bc6 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
  102bc6:	55                   	push   %ebp
  102bc7:	89 e5                	mov    %esp,%ebp
  102bc9:	83 ec 18             	sub    $0x18,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
  102bcc:	83 7d 0c 0b          	cmpl   $0xb,0xc(%ebp)
  102bd0:	77 42                	ja     102c14 <bmap+0x4e>
    if((addr = ip->addrs[bn]) == 0)
  102bd2:	8b 45 08             	mov    0x8(%ebp),%eax
  102bd5:	8b 55 0c             	mov    0xc(%ebp),%edx
  102bd8:	83 c2 04             	add    $0x4,%edx
  102bdb:	8b 44 90 0c          	mov    0xc(%eax,%edx,4),%eax
  102bdf:	89 45 f4             	mov    %eax,-0xc(%ebp)
  102be2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  102be6:	75 24                	jne    102c0c <bmap+0x46>
      ip->addrs[bn] = addr = balloc(ip->dev);
  102be8:	8b 45 08             	mov    0x8(%ebp),%eax
  102beb:	8b 00                	mov    (%eax),%eax
  102bed:	83 ec 0c             	sub    $0xc,%esp
  102bf0:	50                   	push   %eax
  102bf1:	e8 9c f9 ff ff       	call   102592 <balloc>
  102bf6:	83 c4 10             	add    $0x10,%esp
  102bf9:	89 45 f4             	mov    %eax,-0xc(%ebp)
  102bfc:	8b 45 08             	mov    0x8(%ebp),%eax
  102bff:	8b 55 0c             	mov    0xc(%ebp),%edx
  102c02:	8d 4a 04             	lea    0x4(%edx),%ecx
  102c05:	8b 55 f4             	mov    -0xc(%ebp),%edx
  102c08:	89 54 88 0c          	mov    %edx,0xc(%eax,%ecx,4)
    return addr;
  102c0c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102c0f:	e9 cc 00 00 00       	jmp    102ce0 <bmap+0x11a>
  }
  bn -= NDIRECT;
  102c14:	83 6d 0c 0c          	subl   $0xc,0xc(%ebp)

  if(bn < NINDIRECT){
  102c18:	83 7d 0c 7f          	cmpl   $0x7f,0xc(%ebp)
  102c1c:	0f 87 b1 00 00 00    	ja     102cd3 <bmap+0x10d>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
  102c22:	8b 45 08             	mov    0x8(%ebp),%eax
  102c25:	8b 40 4c             	mov    0x4c(%eax),%eax
  102c28:	89 45 f4             	mov    %eax,-0xc(%ebp)
  102c2b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  102c2f:	75 1d                	jne    102c4e <bmap+0x88>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
  102c31:	8b 45 08             	mov    0x8(%ebp),%eax
  102c34:	8b 00                	mov    (%eax),%eax
  102c36:	83 ec 0c             	sub    $0xc,%esp
  102c39:	50                   	push   %eax
  102c3a:	e8 53 f9 ff ff       	call   102592 <balloc>
  102c3f:	83 c4 10             	add    $0x10,%esp
  102c42:	89 45 f4             	mov    %eax,-0xc(%ebp)
  102c45:	8b 45 08             	mov    0x8(%ebp),%eax
  102c48:	8b 55 f4             	mov    -0xc(%ebp),%edx
  102c4b:	89 50 4c             	mov    %edx,0x4c(%eax)
    bp = bread(ip->dev, addr);
  102c4e:	8b 45 08             	mov    0x8(%ebp),%eax
  102c51:	8b 00                	mov    (%eax),%eax
  102c53:	83 ec 08             	sub    $0x8,%esp
  102c56:	ff 75 f4             	push   -0xc(%ebp)
  102c59:	50                   	push   %eax
  102c5a:	e8 89 f3 ff ff       	call   101fe8 <bread>
  102c5f:	83 c4 10             	add    $0x10,%esp
  102c62:	89 45 f0             	mov    %eax,-0x10(%ebp)
    a = (uint*)bp->data;
  102c65:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102c68:	05 20 02 00 00       	add    $0x220,%eax
  102c6d:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if((addr = a[bn]) == 0){
  102c70:	8b 45 0c             	mov    0xc(%ebp),%eax
  102c73:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  102c7a:	8b 45 ec             	mov    -0x14(%ebp),%eax
  102c7d:	01 d0                	add    %edx,%eax
  102c7f:	8b 00                	mov    (%eax),%eax
  102c81:	89 45 f4             	mov    %eax,-0xc(%ebp)
  102c84:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  102c88:	75 36                	jne    102cc0 <bmap+0xfa>
      a[bn] = addr = balloc(ip->dev);
  102c8a:	8b 45 08             	mov    0x8(%ebp),%eax
  102c8d:	8b 00                	mov    (%eax),%eax
  102c8f:	83 ec 0c             	sub    $0xc,%esp
  102c92:	50                   	push   %eax
  102c93:	e8 fa f8 ff ff       	call   102592 <balloc>
  102c98:	83 c4 10             	add    $0x10,%esp
  102c9b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  102c9e:	8b 45 0c             	mov    0xc(%ebp),%eax
  102ca1:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  102ca8:	8b 45 ec             	mov    -0x14(%ebp),%eax
  102cab:	01 c2                	add    %eax,%edx
  102cad:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102cb0:	89 02                	mov    %eax,(%edx)
      log_write(bp);
  102cb2:	83 ec 0c             	sub    $0xc,%esp
  102cb5:	ff 75 f0             	push   -0x10(%ebp)
  102cb8:	e8 98 13 00 00       	call   104055 <log_write>
  102cbd:	83 c4 10             	add    $0x10,%esp
    }
    brelse(bp);
  102cc0:	83 ec 0c             	sub    $0xc,%esp
  102cc3:	ff 75 f0             	push   -0x10(%ebp)
  102cc6:	e8 a3 f3 ff ff       	call   10206e <brelse>
  102ccb:	83 c4 10             	add    $0x10,%esp
    return addr;
  102cce:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102cd1:	eb 0d                	jmp    102ce0 <bmap+0x11a>
  }

  panic("bmap: out of range");
  102cd3:	83 ec 0c             	sub    $0xc,%esp
  102cd6:	68 ae 44 10 00       	push   $0x1044ae
  102cdb:	e8 ce d5 ff ff       	call   1002ae <panic>
}
  102ce0:	c9                   	leave
  102ce1:	c3                   	ret

00102ce2 <itrunc>:
// to it (no directory entries referring to it)
// and has no in-memory reference to it (is
// not an open file or current directory).
static void
itrunc(struct inode *ip)
{
  102ce2:	55                   	push   %ebp
  102ce3:	89 e5                	mov    %esp,%ebp
  102ce5:	83 ec 18             	sub    $0x18,%esp
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
  102ce8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  102cef:	eb 45                	jmp    102d36 <itrunc+0x54>
    if(ip->addrs[i]){
  102cf1:	8b 45 08             	mov    0x8(%ebp),%eax
  102cf4:	8b 55 f4             	mov    -0xc(%ebp),%edx
  102cf7:	83 c2 04             	add    $0x4,%edx
  102cfa:	8b 44 90 0c          	mov    0xc(%eax,%edx,4),%eax
  102cfe:	85 c0                	test   %eax,%eax
  102d00:	74 30                	je     102d32 <itrunc+0x50>
      bfree(ip->dev, ip->addrs[i]);
  102d02:	8b 45 08             	mov    0x8(%ebp),%eax
  102d05:	8b 55 f4             	mov    -0xc(%ebp),%edx
  102d08:	83 c2 04             	add    $0x4,%edx
  102d0b:	8b 44 90 0c          	mov    0xc(%eax,%edx,4),%eax
  102d0f:	8b 55 08             	mov    0x8(%ebp),%edx
  102d12:	8b 12                	mov    (%edx),%edx
  102d14:	83 ec 08             	sub    $0x8,%esp
  102d17:	50                   	push   %eax
  102d18:	52                   	push   %edx
  102d19:	e8 c0 f9 ff ff       	call   1026de <bfree>
  102d1e:	83 c4 10             	add    $0x10,%esp
      ip->addrs[i] = 0;
  102d21:	8b 45 08             	mov    0x8(%ebp),%eax
  102d24:	8b 55 f4             	mov    -0xc(%ebp),%edx
  102d27:	83 c2 04             	add    $0x4,%edx
  102d2a:	c7 44 90 0c 00 00 00 	movl   $0x0,0xc(%eax,%edx,4)
  102d31:	00 
  for(i = 0; i < NDIRECT; i++){
  102d32:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  102d36:	83 7d f4 0b          	cmpl   $0xb,-0xc(%ebp)
  102d3a:	7e b5                	jle    102cf1 <itrunc+0xf>
    }
  }

  if(ip->addrs[NDIRECT]){
  102d3c:	8b 45 08             	mov    0x8(%ebp),%eax
  102d3f:	8b 40 4c             	mov    0x4c(%eax),%eax
  102d42:	85 c0                	test   %eax,%eax
  102d44:	0f 84 a3 00 00 00    	je     102ded <itrunc+0x10b>
    bp = bread_wr(ip->dev, ip->addrs[NDIRECT]);
  102d4a:	8b 45 08             	mov    0x8(%ebp),%eax
  102d4d:	8b 50 4c             	mov    0x4c(%eax),%edx
  102d50:	8b 45 08             	mov    0x8(%ebp),%eax
  102d53:	8b 00                	mov    (%eax),%eax
  102d55:	83 ec 08             	sub    $0x8,%esp
  102d58:	52                   	push   %edx
  102d59:	50                   	push   %eax
  102d5a:	e8 f6 f2 ff ff       	call   102055 <bread_wr>
  102d5f:	83 c4 10             	add    $0x10,%esp
  102d62:	89 45 ec             	mov    %eax,-0x14(%ebp)
    a = (uint*)bp->data;
  102d65:	8b 45 ec             	mov    -0x14(%ebp),%eax
  102d68:	05 20 02 00 00       	add    $0x220,%eax
  102d6d:	89 45 e8             	mov    %eax,-0x18(%ebp)
    for(j = 0; j < NINDIRECT; j++){
  102d70:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  102d77:	eb 3c                	jmp    102db5 <itrunc+0xd3>
      if(a[j])
  102d79:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102d7c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  102d83:	8b 45 e8             	mov    -0x18(%ebp),%eax
  102d86:	01 d0                	add    %edx,%eax
  102d88:	8b 00                	mov    (%eax),%eax
  102d8a:	85 c0                	test   %eax,%eax
  102d8c:	74 23                	je     102db1 <itrunc+0xcf>
        bfree(ip->dev, a[j]);
  102d8e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102d91:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  102d98:	8b 45 e8             	mov    -0x18(%ebp),%eax
  102d9b:	01 d0                	add    %edx,%eax
  102d9d:	8b 00                	mov    (%eax),%eax
  102d9f:	8b 55 08             	mov    0x8(%ebp),%edx
  102da2:	8b 12                	mov    (%edx),%edx
  102da4:	83 ec 08             	sub    $0x8,%esp
  102da7:	50                   	push   %eax
  102da8:	52                   	push   %edx
  102da9:	e8 30 f9 ff ff       	call   1026de <bfree>
  102dae:	83 c4 10             	add    $0x10,%esp
    for(j = 0; j < NINDIRECT; j++){
  102db1:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
  102db5:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102db8:	83 f8 7f             	cmp    $0x7f,%eax
  102dbb:	76 bc                	jbe    102d79 <itrunc+0x97>
    }
    brelse(bp);
  102dbd:	83 ec 0c             	sub    $0xc,%esp
  102dc0:	ff 75 ec             	push   -0x14(%ebp)
  102dc3:	e8 a6 f2 ff ff       	call   10206e <brelse>
  102dc8:	83 c4 10             	add    $0x10,%esp
    bfree(ip->dev, ip->addrs[NDIRECT]);
  102dcb:	8b 45 08             	mov    0x8(%ebp),%eax
  102dce:	8b 40 4c             	mov    0x4c(%eax),%eax
  102dd1:	8b 55 08             	mov    0x8(%ebp),%edx
  102dd4:	8b 12                	mov    (%edx),%edx
  102dd6:	83 ec 08             	sub    $0x8,%esp
  102dd9:	50                   	push   %eax
  102dda:	52                   	push   %edx
  102ddb:	e8 fe f8 ff ff       	call   1026de <bfree>
  102de0:	83 c4 10             	add    $0x10,%esp
    ip->addrs[NDIRECT] = 0;
  102de3:	8b 45 08             	mov    0x8(%ebp),%eax
  102de6:	c7 40 4c 00 00 00 00 	movl   $0x0,0x4c(%eax)
  }

  ip->size = 0;
  102ded:	8b 45 08             	mov    0x8(%ebp),%eax
  102df0:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)
  iupdate(ip);
  102df7:	83 ec 0c             	sub    $0xc,%esp
  102dfa:	ff 75 08             	push   0x8(%ebp)
  102dfd:	e8 4d fb ff ff       	call   10294f <iupdate>
  102e02:	83 c4 10             	add    $0x10,%esp
}
  102e05:	90                   	nop
  102e06:	c9                   	leave
  102e07:	c3                   	ret

00102e08 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
  102e08:	55                   	push   %ebp
  102e09:	89 e5                	mov    %esp,%ebp
  st->dev = ip->dev;
  102e0b:	8b 45 08             	mov    0x8(%ebp),%eax
  102e0e:	8b 00                	mov    (%eax),%eax
  102e10:	89 c2                	mov    %eax,%edx
  102e12:	8b 45 0c             	mov    0xc(%ebp),%eax
  102e15:	89 50 04             	mov    %edx,0x4(%eax)
  st->ino = ip->inum;
  102e18:	8b 45 08             	mov    0x8(%ebp),%eax
  102e1b:	8b 50 04             	mov    0x4(%eax),%edx
  102e1e:	8b 45 0c             	mov    0xc(%ebp),%eax
  102e21:	89 50 08             	mov    %edx,0x8(%eax)
  st->type = ip->type;
  102e24:	8b 45 08             	mov    0x8(%ebp),%eax
  102e27:	0f b7 50 10          	movzwl 0x10(%eax),%edx
  102e2b:	8b 45 0c             	mov    0xc(%ebp),%eax
  102e2e:	66 89 10             	mov    %dx,(%eax)
  st->nlink = ip->nlink;
  102e31:	8b 45 08             	mov    0x8(%ebp),%eax
  102e34:	0f b7 50 16          	movzwl 0x16(%eax),%edx
  102e38:	8b 45 0c             	mov    0xc(%ebp),%eax
  102e3b:	66 89 50 0c          	mov    %dx,0xc(%eax)
  st->size = ip->size;
  102e3f:	8b 45 08             	mov    0x8(%ebp),%eax
  102e42:	8b 50 18             	mov    0x18(%eax),%edx
  102e45:	8b 45 0c             	mov    0xc(%ebp),%eax
  102e48:	89 50 10             	mov    %edx,0x10(%eax)
}
  102e4b:	90                   	nop
  102e4c:	5d                   	pop    %ebp
  102e4d:	c3                   	ret

00102e4e <readi>:

// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
  102e4e:	55                   	push   %ebp
  102e4f:	89 e5                	mov    %esp,%ebp
  102e51:	83 ec 18             	sub    $0x18,%esp
  uint tot, m;
  struct buf *bp;

  if(off > ip->size || off + n < off || ip->nlink < 1)
  102e54:	8b 45 08             	mov    0x8(%ebp),%eax
  102e57:	8b 40 18             	mov    0x18(%eax),%eax
  102e5a:	3b 45 10             	cmp    0x10(%ebp),%eax
  102e5d:	72 19                	jb     102e78 <readi+0x2a>
  102e5f:	8b 55 10             	mov    0x10(%ebp),%edx
  102e62:	8b 45 14             	mov    0x14(%ebp),%eax
  102e65:	01 d0                	add    %edx,%eax
  102e67:	3b 45 10             	cmp    0x10(%ebp),%eax
  102e6a:	72 0c                	jb     102e78 <readi+0x2a>
  102e6c:	8b 45 08             	mov    0x8(%ebp),%eax
  102e6f:	0f b7 40 16          	movzwl 0x16(%eax),%eax
  102e73:	66 85 c0             	test   %ax,%ax
  102e76:	7f 0a                	jg     102e82 <readi+0x34>
    return -1;
  102e78:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  102e7d:	e9 c5 00 00 00       	jmp    102f47 <readi+0xf9>
  if(off + n > ip->size)
  102e82:	8b 55 10             	mov    0x10(%ebp),%edx
  102e85:	8b 45 14             	mov    0x14(%ebp),%eax
  102e88:	01 c2                	add    %eax,%edx
  102e8a:	8b 45 08             	mov    0x8(%ebp),%eax
  102e8d:	8b 40 18             	mov    0x18(%eax),%eax
  102e90:	39 d0                	cmp    %edx,%eax
  102e92:	73 0c                	jae    102ea0 <readi+0x52>
    n = ip->size - off;
  102e94:	8b 45 08             	mov    0x8(%ebp),%eax
  102e97:	8b 40 18             	mov    0x18(%eax),%eax
  102e9a:	2b 45 10             	sub    0x10(%ebp),%eax
  102e9d:	89 45 14             	mov    %eax,0x14(%ebp)

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
  102ea0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  102ea7:	e9 8c 00 00 00       	jmp    102f38 <readi+0xea>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
  102eac:	8b 45 10             	mov    0x10(%ebp),%eax
  102eaf:	c1 e8 09             	shr    $0x9,%eax
  102eb2:	83 ec 08             	sub    $0x8,%esp
  102eb5:	50                   	push   %eax
  102eb6:	ff 75 08             	push   0x8(%ebp)
  102eb9:	e8 08 fd ff ff       	call   102bc6 <bmap>
  102ebe:	83 c4 10             	add    $0x10,%esp
  102ec1:	8b 55 08             	mov    0x8(%ebp),%edx
  102ec4:	8b 12                	mov    (%edx),%edx
  102ec6:	83 ec 08             	sub    $0x8,%esp
  102ec9:	50                   	push   %eax
  102eca:	52                   	push   %edx
  102ecb:	e8 18 f1 ff ff       	call   101fe8 <bread>
  102ed0:	83 c4 10             	add    $0x10,%esp
  102ed3:	89 45 f0             	mov    %eax,-0x10(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
  102ed6:	8b 45 10             	mov    0x10(%ebp),%eax
  102ed9:	25 ff 01 00 00       	and    $0x1ff,%eax
  102ede:	ba 00 02 00 00       	mov    $0x200,%edx
  102ee3:	29 c2                	sub    %eax,%edx
  102ee5:	8b 45 14             	mov    0x14(%ebp),%eax
  102ee8:	2b 45 f4             	sub    -0xc(%ebp),%eax
  102eeb:	39 c2                	cmp    %eax,%edx
  102eed:	0f 46 c2             	cmovbe %edx,%eax
  102ef0:	89 45 ec             	mov    %eax,-0x14(%ebp)
    memmove(dst, bp->data + off%BSIZE, m);
  102ef3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102ef6:	8d 90 20 02 00 00    	lea    0x220(%eax),%edx
  102efc:	8b 45 10             	mov    0x10(%ebp),%eax
  102eff:	25 ff 01 00 00       	and    $0x1ff,%eax
  102f04:	01 d0                	add    %edx,%eax
  102f06:	83 ec 04             	sub    $0x4,%esp
  102f09:	ff 75 ec             	push   -0x14(%ebp)
  102f0c:	50                   	push   %eax
  102f0d:	ff 75 0c             	push   0xc(%ebp)
  102f10:	e8 3d e0 ff ff       	call   100f52 <memmove>
  102f15:	83 c4 10             	add    $0x10,%esp
    brelse(bp);
  102f18:	83 ec 0c             	sub    $0xc,%esp
  102f1b:	ff 75 f0             	push   -0x10(%ebp)
  102f1e:	e8 4b f1 ff ff       	call   10206e <brelse>
  102f23:	83 c4 10             	add    $0x10,%esp
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
  102f26:	8b 45 ec             	mov    -0x14(%ebp),%eax
  102f29:	01 45 f4             	add    %eax,-0xc(%ebp)
  102f2c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  102f2f:	01 45 10             	add    %eax,0x10(%ebp)
  102f32:	8b 45 ec             	mov    -0x14(%ebp),%eax
  102f35:	01 45 0c             	add    %eax,0xc(%ebp)
  102f38:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102f3b:	3b 45 14             	cmp    0x14(%ebp),%eax
  102f3e:	0f 82 68 ff ff ff    	jb     102eac <readi+0x5e>
  }
  return n;
  102f44:	8b 45 14             	mov    0x14(%ebp),%eax
}
  102f47:	c9                   	leave
  102f48:	c3                   	ret

00102f49 <writei>:

// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
  102f49:	55                   	push   %ebp
  102f4a:	89 e5                	mov    %esp,%ebp
  102f4c:	83 ec 18             	sub    $0x18,%esp
  uint tot, m;
  struct buf *bp;

  if(off > ip->size || off + n < off)
  102f4f:	8b 45 08             	mov    0x8(%ebp),%eax
  102f52:	8b 40 18             	mov    0x18(%eax),%eax
  102f55:	3b 45 10             	cmp    0x10(%ebp),%eax
  102f58:	72 0d                	jb     102f67 <writei+0x1e>
  102f5a:	8b 55 10             	mov    0x10(%ebp),%edx
  102f5d:	8b 45 14             	mov    0x14(%ebp),%eax
  102f60:	01 d0                	add    %edx,%eax
  102f62:	3b 45 10             	cmp    0x10(%ebp),%eax
  102f65:	73 0a                	jae    102f71 <writei+0x28>
    return -1;
  102f67:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  102f6c:	e9 f6 00 00 00       	jmp    103067 <writei+0x11e>
  if(off + n > MAXFILE*BSIZE)
  102f71:	8b 55 10             	mov    0x10(%ebp),%edx
  102f74:	8b 45 14             	mov    0x14(%ebp),%eax
  102f77:	01 d0                	add    %edx,%eax
  102f79:	3d 00 18 01 00       	cmp    $0x11800,%eax
  102f7e:	76 0a                	jbe    102f8a <writei+0x41>
    return -1;
  102f80:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  102f85:	e9 dd 00 00 00       	jmp    103067 <writei+0x11e>

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
  102f8a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  102f91:	e9 9a 00 00 00       	jmp    103030 <writei+0xe7>
    bp = bread_wr(ip->dev, bmap(ip, off/BSIZE));
  102f96:	8b 45 10             	mov    0x10(%ebp),%eax
  102f99:	c1 e8 09             	shr    $0x9,%eax
  102f9c:	83 ec 08             	sub    $0x8,%esp
  102f9f:	50                   	push   %eax
  102fa0:	ff 75 08             	push   0x8(%ebp)
  102fa3:	e8 1e fc ff ff       	call   102bc6 <bmap>
  102fa8:	83 c4 10             	add    $0x10,%esp
  102fab:	8b 55 08             	mov    0x8(%ebp),%edx
  102fae:	8b 12                	mov    (%edx),%edx
  102fb0:	83 ec 08             	sub    $0x8,%esp
  102fb3:	50                   	push   %eax
  102fb4:	52                   	push   %edx
  102fb5:	e8 9b f0 ff ff       	call   102055 <bread_wr>
  102fba:	83 c4 10             	add    $0x10,%esp
  102fbd:	89 45 f0             	mov    %eax,-0x10(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
  102fc0:	8b 45 10             	mov    0x10(%ebp),%eax
  102fc3:	25 ff 01 00 00       	and    $0x1ff,%eax
  102fc8:	ba 00 02 00 00       	mov    $0x200,%edx
  102fcd:	29 c2                	sub    %eax,%edx
  102fcf:	8b 45 14             	mov    0x14(%ebp),%eax
  102fd2:	2b 45 f4             	sub    -0xc(%ebp),%eax
  102fd5:	39 c2                	cmp    %eax,%edx
  102fd7:	0f 46 c2             	cmovbe %edx,%eax
  102fda:	89 45 ec             	mov    %eax,-0x14(%ebp)
    memmove(bp->data + off%BSIZE, src, m);
  102fdd:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102fe0:	8d 90 20 02 00 00    	lea    0x220(%eax),%edx
  102fe6:	8b 45 10             	mov    0x10(%ebp),%eax
  102fe9:	25 ff 01 00 00       	and    $0x1ff,%eax
  102fee:	01 d0                	add    %edx,%eax
  102ff0:	83 ec 04             	sub    $0x4,%esp
  102ff3:	ff 75 ec             	push   -0x14(%ebp)
  102ff6:	ff 75 0c             	push   0xc(%ebp)
  102ff9:	50                   	push   %eax
  102ffa:	e8 53 df ff ff       	call   100f52 <memmove>
  102fff:	83 c4 10             	add    $0x10,%esp
    log_write(bp);
  103002:	83 ec 0c             	sub    $0xc,%esp
  103005:	ff 75 f0             	push   -0x10(%ebp)
  103008:	e8 48 10 00 00       	call   104055 <log_write>
  10300d:	83 c4 10             	add    $0x10,%esp
    brelse(bp);
  103010:	83 ec 0c             	sub    $0xc,%esp
  103013:	ff 75 f0             	push   -0x10(%ebp)
  103016:	e8 53 f0 ff ff       	call   10206e <brelse>
  10301b:	83 c4 10             	add    $0x10,%esp
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
  10301e:	8b 45 ec             	mov    -0x14(%ebp),%eax
  103021:	01 45 f4             	add    %eax,-0xc(%ebp)
  103024:	8b 45 ec             	mov    -0x14(%ebp),%eax
  103027:	01 45 10             	add    %eax,0x10(%ebp)
  10302a:	8b 45 ec             	mov    -0x14(%ebp),%eax
  10302d:	01 45 0c             	add    %eax,0xc(%ebp)
  103030:	8b 45 f4             	mov    -0xc(%ebp),%eax
  103033:	3b 45 14             	cmp    0x14(%ebp),%eax
  103036:	0f 82 5a ff ff ff    	jb     102f96 <writei+0x4d>
  }

  if(n > 0 && off > ip->size){
  10303c:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
  103040:	74 22                	je     103064 <writei+0x11b>
  103042:	8b 45 08             	mov    0x8(%ebp),%eax
  103045:	8b 40 18             	mov    0x18(%eax),%eax
  103048:	3b 45 10             	cmp    0x10(%ebp),%eax
  10304b:	73 17                	jae    103064 <writei+0x11b>
    ip->size = off;
  10304d:	8b 45 08             	mov    0x8(%ebp),%eax
  103050:	8b 55 10             	mov    0x10(%ebp),%edx
  103053:	89 50 18             	mov    %edx,0x18(%eax)
    iupdate(ip);
  103056:	83 ec 0c             	sub    $0xc,%esp
  103059:	ff 75 08             	push   0x8(%ebp)
  10305c:	e8 ee f8 ff ff       	call   10294f <iupdate>
  103061:	83 c4 10             	add    $0x10,%esp
  }
  return n;
  103064:	8b 45 14             	mov    0x14(%ebp),%eax
}
  103067:	c9                   	leave
  103068:	c3                   	ret

00103069 <namecmp>:

// Directories

int
namecmp(const char *s, const char *t)
{
  103069:	55                   	push   %ebp
  10306a:	89 e5                	mov    %esp,%ebp
  10306c:	83 ec 08             	sub    $0x8,%esp
  return strncmp(s, t, DIRSIZ);
  10306f:	83 ec 04             	sub    $0x4,%esp
  103072:	6a 0e                	push   $0xe
  103074:	ff 75 0c             	push   0xc(%ebp)
  103077:	ff 75 08             	push   0x8(%ebp)
  10307a:	e8 69 df ff ff       	call   100fe8 <strncmp>
  10307f:	83 c4 10             	add    $0x10,%esp
}
  103082:	c9                   	leave
  103083:	c3                   	ret

00103084 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
  103084:	55                   	push   %ebp
  103085:	89 e5                	mov    %esp,%ebp
  103087:	83 ec 28             	sub    $0x28,%esp
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
  10308a:	8b 45 08             	mov    0x8(%ebp),%eax
  10308d:	0f b7 40 10          	movzwl 0x10(%eax),%eax
  103091:	66 83 f8 01          	cmp    $0x1,%ax
  103095:	74 0d                	je     1030a4 <dirlookup+0x20>
    panic("dirlookup not DIR");
  103097:	83 ec 0c             	sub    $0xc,%esp
  10309a:	68 c1 44 10 00       	push   $0x1044c1
  10309f:	e8 0a d2 ff ff       	call   1002ae <panic>

  for(off = 0; off < dp->size; off += sizeof(de)){
  1030a4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  1030ab:	eb 7b                	jmp    103128 <dirlookup+0xa4>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
  1030ad:	6a 10                	push   $0x10
  1030af:	ff 75 f4             	push   -0xc(%ebp)
  1030b2:	8d 45 e0             	lea    -0x20(%ebp),%eax
  1030b5:	50                   	push   %eax
  1030b6:	ff 75 08             	push   0x8(%ebp)
  1030b9:	e8 90 fd ff ff       	call   102e4e <readi>
  1030be:	83 c4 10             	add    $0x10,%esp
  1030c1:	83 f8 10             	cmp    $0x10,%eax
  1030c4:	74 0d                	je     1030d3 <dirlookup+0x4f>
      panic("dirlookup read");
  1030c6:	83 ec 0c             	sub    $0xc,%esp
  1030c9:	68 d3 44 10 00       	push   $0x1044d3
  1030ce:	e8 db d1 ff ff       	call   1002ae <panic>
    if(de.inum == 0)
  1030d3:	0f b7 45 e0          	movzwl -0x20(%ebp),%eax
  1030d7:	66 85 c0             	test   %ax,%ax
  1030da:	74 47                	je     103123 <dirlookup+0x9f>
      continue;
    if(namecmp(name, de.name) == 0){
  1030dc:	83 ec 08             	sub    $0x8,%esp
  1030df:	8d 45 e0             	lea    -0x20(%ebp),%eax
  1030e2:	83 c0 02             	add    $0x2,%eax
  1030e5:	50                   	push   %eax
  1030e6:	ff 75 0c             	push   0xc(%ebp)
  1030e9:	e8 7b ff ff ff       	call   103069 <namecmp>
  1030ee:	83 c4 10             	add    $0x10,%esp
  1030f1:	85 c0                	test   %eax,%eax
  1030f3:	75 2f                	jne    103124 <dirlookup+0xa0>
      // entry matches path element
      if(poff)
  1030f5:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  1030f9:	74 08                	je     103103 <dirlookup+0x7f>
        *poff = off;
  1030fb:	8b 45 10             	mov    0x10(%ebp),%eax
  1030fe:	8b 55 f4             	mov    -0xc(%ebp),%edx
  103101:	89 10                	mov    %edx,(%eax)
      inum = de.inum;
  103103:	0f b7 45 e0          	movzwl -0x20(%ebp),%eax
  103107:	0f b7 c0             	movzwl %ax,%eax
  10310a:	89 45 f0             	mov    %eax,-0x10(%ebp)
      return iget(dp->dev, inum);
  10310d:	8b 45 08             	mov    0x8(%ebp),%eax
  103110:	8b 00                	mov    (%eax),%eax
  103112:	83 ec 08             	sub    $0x8,%esp
  103115:	ff 75 f0             	push   -0x10(%ebp)
  103118:	50                   	push   %eax
  103119:	e8 f5 f8 ff ff       	call   102a13 <iget>
  10311e:	83 c4 10             	add    $0x10,%esp
  103121:	eb 19                	jmp    10313c <dirlookup+0xb8>
      continue;
  103123:	90                   	nop
  for(off = 0; off < dp->size; off += sizeof(de)){
  103124:	83 45 f4 10          	addl   $0x10,-0xc(%ebp)
  103128:	8b 45 08             	mov    0x8(%ebp),%eax
  10312b:	8b 40 18             	mov    0x18(%eax),%eax
  10312e:	39 45 f4             	cmp    %eax,-0xc(%ebp)
  103131:	0f 82 76 ff ff ff    	jb     1030ad <dirlookup+0x29>
    }
  }

  return 0;
  103137:	b8 00 00 00 00       	mov    $0x0,%eax
}
  10313c:	c9                   	leave
  10313d:	c3                   	ret

0010313e <dirlink>:


// Write a new directory entry (name, inum) into the directory dp.
int
dirlink(struct inode *dp, char *name, uint inum)
{
  10313e:	55                   	push   %ebp
  10313f:	89 e5                	mov    %esp,%ebp
  103141:	83 ec 28             	sub    $0x28,%esp
  int off;
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
  103144:	83 ec 04             	sub    $0x4,%esp
  103147:	6a 00                	push   $0x0
  103149:	ff 75 0c             	push   0xc(%ebp)
  10314c:	ff 75 08             	push   0x8(%ebp)
  10314f:	e8 30 ff ff ff       	call   103084 <dirlookup>
  103154:	83 c4 10             	add    $0x10,%esp
  103157:	89 45 f0             	mov    %eax,-0x10(%ebp)
  10315a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  10315e:	74 18                	je     103178 <dirlink+0x3a>
    iput(ip);
  103160:	83 ec 0c             	sub    $0xc,%esp
  103163:	ff 75 f0             	push   -0x10(%ebp)
  103166:	e8 78 f7 ff ff       	call   1028e3 <iput>
  10316b:	83 c4 10             	add    $0x10,%esp
    return -1;
  10316e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  103173:	e9 9c 00 00 00       	jmp    103214 <dirlink+0xd6>
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
  103178:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  10317f:	eb 39                	jmp    1031ba <dirlink+0x7c>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
  103181:	8b 45 f4             	mov    -0xc(%ebp),%eax
  103184:	6a 10                	push   $0x10
  103186:	50                   	push   %eax
  103187:	8d 45 e0             	lea    -0x20(%ebp),%eax
  10318a:	50                   	push   %eax
  10318b:	ff 75 08             	push   0x8(%ebp)
  10318e:	e8 bb fc ff ff       	call   102e4e <readi>
  103193:	83 c4 10             	add    $0x10,%esp
  103196:	83 f8 10             	cmp    $0x10,%eax
  103199:	74 0d                	je     1031a8 <dirlink+0x6a>
      panic("dirlink read");
  10319b:	83 ec 0c             	sub    $0xc,%esp
  10319e:	68 e2 44 10 00       	push   $0x1044e2
  1031a3:	e8 06 d1 ff ff       	call   1002ae <panic>
    if(de.inum == 0)
  1031a8:	0f b7 45 e0          	movzwl -0x20(%ebp),%eax
  1031ac:	66 85 c0             	test   %ax,%ax
  1031af:	74 18                	je     1031c9 <dirlink+0x8b>
  for(off = 0; off < dp->size; off += sizeof(de)){
  1031b1:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1031b4:	83 c0 10             	add    $0x10,%eax
  1031b7:	89 45 f4             	mov    %eax,-0xc(%ebp)
  1031ba:	8b 45 08             	mov    0x8(%ebp),%eax
  1031bd:	8b 40 18             	mov    0x18(%eax),%eax
  1031c0:	8b 55 f4             	mov    -0xc(%ebp),%edx
  1031c3:	39 c2                	cmp    %eax,%edx
  1031c5:	72 ba                	jb     103181 <dirlink+0x43>
  1031c7:	eb 01                	jmp    1031ca <dirlink+0x8c>
      break;
  1031c9:	90                   	nop
  }

  strncpy(de.name, name, DIRSIZ);
  1031ca:	83 ec 04             	sub    $0x4,%esp
  1031cd:	6a 0e                	push   $0xe
  1031cf:	ff 75 0c             	push   0xc(%ebp)
  1031d2:	8d 45 e0             	lea    -0x20(%ebp),%eax
  1031d5:	83 c0 02             	add    $0x2,%eax
  1031d8:	50                   	push   %eax
  1031d9:	e8 60 de ff ff       	call   10103e <strncpy>
  1031de:	83 c4 10             	add    $0x10,%esp
  de.inum = inum;
  1031e1:	8b 45 10             	mov    0x10(%ebp),%eax
  1031e4:	66 89 45 e0          	mov    %ax,-0x20(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
  1031e8:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1031eb:	6a 10                	push   $0x10
  1031ed:	50                   	push   %eax
  1031ee:	8d 45 e0             	lea    -0x20(%ebp),%eax
  1031f1:	50                   	push   %eax
  1031f2:	ff 75 08             	push   0x8(%ebp)
  1031f5:	e8 4f fd ff ff       	call   102f49 <writei>
  1031fa:	83 c4 10             	add    $0x10,%esp
  1031fd:	83 f8 10             	cmp    $0x10,%eax
  103200:	74 0d                	je     10320f <dirlink+0xd1>
    panic("dirlink");
  103202:	83 ec 0c             	sub    $0xc,%esp
  103205:	68 ef 44 10 00       	push   $0x1044ef
  10320a:	e8 9f d0 ff ff       	call   1002ae <panic>

  return 0;
  10320f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  103214:	c9                   	leave
  103215:	c3                   	ret

00103216 <skipelem>:
//   skipelem("a", name) = "", setting name = "a"
//   skipelem("", name) = skipelem("////", name) = 0
//
static char*
skipelem(char *path, char *name)
{
  103216:	55                   	push   %ebp
  103217:	89 e5                	mov    %esp,%ebp
  103219:	83 ec 18             	sub    $0x18,%esp
  char *s;
  int len;

  while(*path == '/')
  10321c:	eb 04                	jmp    103222 <skipelem+0xc>
    path++;
  10321e:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  while(*path == '/')
  103222:	8b 45 08             	mov    0x8(%ebp),%eax
  103225:	0f b6 00             	movzbl (%eax),%eax
  103228:	3c 2f                	cmp    $0x2f,%al
  10322a:	74 f2                	je     10321e <skipelem+0x8>
  if(*path == 0)
  10322c:	8b 45 08             	mov    0x8(%ebp),%eax
  10322f:	0f b6 00             	movzbl (%eax),%eax
  103232:	84 c0                	test   %al,%al
  103234:	75 07                	jne    10323d <skipelem+0x27>
    return 0;
  103236:	b8 00 00 00 00       	mov    $0x0,%eax
  10323b:	eb 77                	jmp    1032b4 <skipelem+0x9e>
  s = path;
  10323d:	8b 45 08             	mov    0x8(%ebp),%eax
  103240:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(*path != '/' && *path != 0)
  103243:	eb 04                	jmp    103249 <skipelem+0x33>
    path++;
  103245:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  while(*path != '/' && *path != 0)
  103249:	8b 45 08             	mov    0x8(%ebp),%eax
  10324c:	0f b6 00             	movzbl (%eax),%eax
  10324f:	3c 2f                	cmp    $0x2f,%al
  103251:	74 0a                	je     10325d <skipelem+0x47>
  103253:	8b 45 08             	mov    0x8(%ebp),%eax
  103256:	0f b6 00             	movzbl (%eax),%eax
  103259:	84 c0                	test   %al,%al
  10325b:	75 e8                	jne    103245 <skipelem+0x2f>
  len = path - s;
  10325d:	8b 45 08             	mov    0x8(%ebp),%eax
  103260:	2b 45 f4             	sub    -0xc(%ebp),%eax
  103263:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(len >= DIRSIZ)
  103266:	83 7d f0 0d          	cmpl   $0xd,-0x10(%ebp)
  10326a:	7e 15                	jle    103281 <skipelem+0x6b>
    memmove(name, s, DIRSIZ);
  10326c:	83 ec 04             	sub    $0x4,%esp
  10326f:	6a 0e                	push   $0xe
  103271:	ff 75 f4             	push   -0xc(%ebp)
  103274:	ff 75 0c             	push   0xc(%ebp)
  103277:	e8 d6 dc ff ff       	call   100f52 <memmove>
  10327c:	83 c4 10             	add    $0x10,%esp
  10327f:	eb 26                	jmp    1032a7 <skipelem+0x91>
  else {
    memmove(name, s, len);
  103281:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103284:	83 ec 04             	sub    $0x4,%esp
  103287:	50                   	push   %eax
  103288:	ff 75 f4             	push   -0xc(%ebp)
  10328b:	ff 75 0c             	push   0xc(%ebp)
  10328e:	e8 bf dc ff ff       	call   100f52 <memmove>
  103293:	83 c4 10             	add    $0x10,%esp
    name[len] = 0;
  103296:	8b 55 f0             	mov    -0x10(%ebp),%edx
  103299:	8b 45 0c             	mov    0xc(%ebp),%eax
  10329c:	01 d0                	add    %edx,%eax
  10329e:	c6 00 00             	movb   $0x0,(%eax)
  }
  while(*path == '/')
  1032a1:	eb 04                	jmp    1032a7 <skipelem+0x91>
    path++;
  1032a3:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  while(*path == '/')
  1032a7:	8b 45 08             	mov    0x8(%ebp),%eax
  1032aa:	0f b6 00             	movzbl (%eax),%eax
  1032ad:	3c 2f                	cmp    $0x2f,%al
  1032af:	74 f2                	je     1032a3 <skipelem+0x8d>
  return path;
  1032b1:	8b 45 08             	mov    0x8(%ebp),%eax
}
  1032b4:	c9                   	leave
  1032b5:	c3                   	ret

001032b6 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
  1032b6:	55                   	push   %ebp
  1032b7:	89 e5                	mov    %esp,%ebp
  1032b9:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip, *next;

  ip = iget(ROOTDEV, ROOTINO);
  1032bc:	83 ec 08             	sub    $0x8,%esp
  1032bf:	6a 01                	push   $0x1
  1032c1:	6a 01                	push   $0x1
  1032c3:	e8 4b f7 ff ff       	call   102a13 <iget>
  1032c8:	83 c4 10             	add    $0x10,%esp
  1032cb:	89 45 f4             	mov    %eax,-0xc(%ebp)

  while((path = skipelem(path, name)) != 0){
  1032ce:	e9 90 00 00 00       	jmp    103363 <namex+0xad>
    iread(ip);
  1032d3:	83 ec 0c             	sub    $0xc,%esp
  1032d6:	ff 75 f4             	push   -0xc(%ebp)
  1032d9:	e8 e4 f7 ff ff       	call   102ac2 <iread>
  1032de:	83 c4 10             	add    $0x10,%esp
    if(ip->type != T_DIR){
  1032e1:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1032e4:	0f b7 40 10          	movzwl 0x10(%eax),%eax
  1032e8:	66 83 f8 01          	cmp    $0x1,%ax
  1032ec:	74 18                	je     103306 <namex+0x50>
      iput(ip);
  1032ee:	83 ec 0c             	sub    $0xc,%esp
  1032f1:	ff 75 f4             	push   -0xc(%ebp)
  1032f4:	e8 ea f5 ff ff       	call   1028e3 <iput>
  1032f9:	83 c4 10             	add    $0x10,%esp
      return 0;
  1032fc:	b8 00 00 00 00       	mov    $0x0,%eax
  103301:	e9 99 00 00 00       	jmp    10339f <namex+0xe9>
    }
    if(nameiparent && *path == '\0'){
  103306:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  10330a:	74 12                	je     10331e <namex+0x68>
  10330c:	8b 45 08             	mov    0x8(%ebp),%eax
  10330f:	0f b6 00             	movzbl (%eax),%eax
  103312:	84 c0                	test   %al,%al
  103314:	75 08                	jne    10331e <namex+0x68>
      // Stop one level early.
      return ip;
  103316:	8b 45 f4             	mov    -0xc(%ebp),%eax
  103319:	e9 81 00 00 00       	jmp    10339f <namex+0xe9>
    }
    if((next = dirlookup(ip, name, 0)) == 0){
  10331e:	83 ec 04             	sub    $0x4,%esp
  103321:	6a 00                	push   $0x0
  103323:	ff 75 10             	push   0x10(%ebp)
  103326:	ff 75 f4             	push   -0xc(%ebp)
  103329:	e8 56 fd ff ff       	call   103084 <dirlookup>
  10332e:	83 c4 10             	add    $0x10,%esp
  103331:	89 45 f0             	mov    %eax,-0x10(%ebp)
  103334:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  103338:	75 15                	jne    10334f <namex+0x99>
      iput(ip);
  10333a:	83 ec 0c             	sub    $0xc,%esp
  10333d:	ff 75 f4             	push   -0xc(%ebp)
  103340:	e8 9e f5 ff ff       	call   1028e3 <iput>
  103345:	83 c4 10             	add    $0x10,%esp
      return 0;
  103348:	b8 00 00 00 00       	mov    $0x0,%eax
  10334d:	eb 50                	jmp    10339f <namex+0xe9>
    }
    iput(ip);
  10334f:	83 ec 0c             	sub    $0xc,%esp
  103352:	ff 75 f4             	push   -0xc(%ebp)
  103355:	e8 89 f5 ff ff       	call   1028e3 <iput>
  10335a:	83 c4 10             	add    $0x10,%esp
    ip = next;
  10335d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103360:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while((path = skipelem(path, name)) != 0){
  103363:	83 ec 08             	sub    $0x8,%esp
  103366:	ff 75 10             	push   0x10(%ebp)
  103369:	ff 75 08             	push   0x8(%ebp)
  10336c:	e8 a5 fe ff ff       	call   103216 <skipelem>
  103371:	83 c4 10             	add    $0x10,%esp
  103374:	89 45 08             	mov    %eax,0x8(%ebp)
  103377:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  10337b:	0f 85 52 ff ff ff    	jne    1032d3 <namex+0x1d>
  }
  if(nameiparent){
  103381:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  103385:	74 15                	je     10339c <namex+0xe6>
    iput(ip);
  103387:	83 ec 0c             	sub    $0xc,%esp
  10338a:	ff 75 f4             	push   -0xc(%ebp)
  10338d:	e8 51 f5 ff ff       	call   1028e3 <iput>
  103392:	83 c4 10             	add    $0x10,%esp
    return 0;
  103395:	b8 00 00 00 00       	mov    $0x0,%eax
  10339a:	eb 03                	jmp    10339f <namex+0xe9>
  }
  return ip;
  10339c:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  10339f:	c9                   	leave
  1033a0:	c3                   	ret

001033a1 <namei>:

struct inode*
namei(char *path)
{
  1033a1:	55                   	push   %ebp
  1033a2:	89 e5                	mov    %esp,%ebp
  1033a4:	83 ec 18             	sub    $0x18,%esp
  char name[DIRSIZ];
  return namex(path, 0, name);
  1033a7:	83 ec 04             	sub    $0x4,%esp
  1033aa:	8d 45 ea             	lea    -0x16(%ebp),%eax
  1033ad:	50                   	push   %eax
  1033ae:	6a 00                	push   $0x0
  1033b0:	ff 75 08             	push   0x8(%ebp)
  1033b3:	e8 fe fe ff ff       	call   1032b6 <namex>
  1033b8:	83 c4 10             	add    $0x10,%esp
}
  1033bb:	c9                   	leave
  1033bc:	c3                   	ret

001033bd <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
  1033bd:	55                   	push   %ebp
  1033be:	89 e5                	mov    %esp,%ebp
  1033c0:	83 ec 08             	sub    $0x8,%esp
  return namex(path, 1, name);
  1033c3:	83 ec 04             	sub    $0x4,%esp
  1033c6:	ff 75 0c             	push   0xc(%ebp)
  1033c9:	6a 01                	push   $0x1
  1033cb:	ff 75 08             	push   0x8(%ebp)
  1033ce:	e8 e3 fe ff ff       	call   1032b6 <namex>
  1033d3:	83 c4 10             	add    $0x10,%esp
}
  1033d6:	c9                   	leave
  1033d7:	c3                   	ret

001033d8 <filealloc>:
} ftable;

// Allocate a file structure.
struct file*
filealloc(void)
{
  1033d8:	55                   	push   %ebp
  1033d9:	89 e5                	mov    %esp,%ebp
  1033db:	83 ec 10             	sub    $0x10,%esp
  struct file *f;

  for(f = ftable.file; f < ftable.file + NFILE; f++){
  1033de:	c7 45 fc c0 ec 10 00 	movl   $0x10ecc0,-0x4(%ebp)
  1033e5:	eb 1d                	jmp    103404 <filealloc+0x2c>
    if(f->ref == 0){
  1033e7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1033ea:	8b 40 04             	mov    0x4(%eax),%eax
  1033ed:	85 c0                	test   %eax,%eax
  1033ef:	75 0f                	jne    103400 <filealloc+0x28>
      f->ref = 1;
  1033f1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1033f4:	c7 40 04 01 00 00 00 	movl   $0x1,0x4(%eax)
      return f;
  1033fb:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1033fe:	eb 13                	jmp    103413 <filealloc+0x3b>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
  103400:	83 45 fc 14          	addl   $0x14,-0x4(%ebp)
  103404:	b8 90 f4 10 00       	mov    $0x10f490,%eax
  103409:	39 45 fc             	cmp    %eax,-0x4(%ebp)
  10340c:	72 d9                	jb     1033e7 <filealloc+0xf>
    }
  }
  return 0;
  10340e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  103413:	c9                   	leave
  103414:	c3                   	ret

00103415 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
  103415:	55                   	push   %ebp
  103416:	89 e5                	mov    %esp,%ebp
  103418:	83 ec 08             	sub    $0x8,%esp
  if(f->ref < 1)
  10341b:	8b 45 08             	mov    0x8(%ebp),%eax
  10341e:	8b 40 04             	mov    0x4(%eax),%eax
  103421:	85 c0                	test   %eax,%eax
  103423:	7f 0d                	jg     103432 <filedup+0x1d>
    panic("filedup");
  103425:	83 ec 0c             	sub    $0xc,%esp
  103428:	68 f7 44 10 00       	push   $0x1044f7
  10342d:	e8 7c ce ff ff       	call   1002ae <panic>
  f->ref++;
  103432:	8b 45 08             	mov    0x8(%ebp),%eax
  103435:	8b 40 04             	mov    0x4(%eax),%eax
  103438:	8d 50 01             	lea    0x1(%eax),%edx
  10343b:	8b 45 08             	mov    0x8(%ebp),%eax
  10343e:	89 50 04             	mov    %edx,0x4(%eax)
  return f;
  103441:	8b 45 08             	mov    0x8(%ebp),%eax
}
  103444:	c9                   	leave
  103445:	c3                   	ret

00103446 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
  103446:	55                   	push   %ebp
  103447:	89 e5                	mov    %esp,%ebp
  103449:	83 ec 28             	sub    $0x28,%esp
  struct file ff;

  if(f->ref < 1)
  10344c:	8b 45 08             	mov    0x8(%ebp),%eax
  10344f:	8b 40 04             	mov    0x4(%eax),%eax
  103452:	85 c0                	test   %eax,%eax
  103454:	7f 0d                	jg     103463 <fileclose+0x1d>
    panic("fileclose");
  103456:	83 ec 0c             	sub    $0xc,%esp
  103459:	68 ff 44 10 00       	push   $0x1044ff
  10345e:	e8 4b ce ff ff       	call   1002ae <panic>
  if(--f->ref > 0){
  103463:	8b 45 08             	mov    0x8(%ebp),%eax
  103466:	8b 40 04             	mov    0x4(%eax),%eax
  103469:	8d 50 ff             	lea    -0x1(%eax),%edx
  10346c:	8b 45 08             	mov    0x8(%ebp),%eax
  10346f:	89 50 04             	mov    %edx,0x4(%eax)
  103472:	8b 45 08             	mov    0x8(%ebp),%eax
  103475:	8b 40 04             	mov    0x4(%eax),%eax
  103478:	85 c0                	test   %eax,%eax
  10347a:	7f 56                	jg     1034d2 <fileclose+0x8c>
    return;
  }
  ff = *f;
  10347c:	8b 45 08             	mov    0x8(%ebp),%eax
  10347f:	8b 10                	mov    (%eax),%edx
  103481:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  103484:	8b 50 04             	mov    0x4(%eax),%edx
  103487:	89 55 e8             	mov    %edx,-0x18(%ebp)
  10348a:	8b 50 08             	mov    0x8(%eax),%edx
  10348d:	89 55 ec             	mov    %edx,-0x14(%ebp)
  103490:	8b 50 0c             	mov    0xc(%eax),%edx
  103493:	89 55 f0             	mov    %edx,-0x10(%ebp)
  103496:	8b 40 10             	mov    0x10(%eax),%eax
  103499:	89 45 f4             	mov    %eax,-0xc(%ebp)
  f->ref = 0;
  10349c:	8b 45 08             	mov    0x8(%ebp),%eax
  10349f:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
  f->type = FD_NONE;
  1034a6:	8b 45 08             	mov    0x8(%ebp),%eax
  1034a9:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

  if(ff.type == FD_INODE){
  1034af:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  1034b2:	83 f8 01             	cmp    $0x1,%eax
  1034b5:	75 1c                	jne    1034d3 <fileclose+0x8d>
    begin_op();
  1034b7:	e8 13 0b 00 00       	call   103fcf <begin_op>
    iput(ff.ip);
  1034bc:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1034bf:	83 ec 0c             	sub    $0xc,%esp
  1034c2:	50                   	push   %eax
  1034c3:	e8 1b f4 ff ff       	call   1028e3 <iput>
  1034c8:	83 c4 10             	add    $0x10,%esp
    end_op();
  1034cb:	e8 05 0b 00 00       	call   103fd5 <end_op>
  1034d0:	eb 01                	jmp    1034d3 <fileclose+0x8d>
    return;
  1034d2:	90                   	nop
  }
}
  1034d3:	c9                   	leave
  1034d4:	c3                   	ret

001034d5 <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
  1034d5:	55                   	push   %ebp
  1034d6:	89 e5                	mov    %esp,%ebp
  1034d8:	83 ec 08             	sub    $0x8,%esp
  if(f->type == FD_INODE){
  1034db:	8b 45 08             	mov    0x8(%ebp),%eax
  1034de:	8b 00                	mov    (%eax),%eax
  1034e0:	83 f8 01             	cmp    $0x1,%eax
  1034e3:	75 2e                	jne    103513 <filestat+0x3e>
    iread(f->ip);
  1034e5:	8b 45 08             	mov    0x8(%ebp),%eax
  1034e8:	8b 40 0c             	mov    0xc(%eax),%eax
  1034eb:	83 ec 0c             	sub    $0xc,%esp
  1034ee:	50                   	push   %eax
  1034ef:	e8 ce f5 ff ff       	call   102ac2 <iread>
  1034f4:	83 c4 10             	add    $0x10,%esp
    stati(f->ip, st);
  1034f7:	8b 45 08             	mov    0x8(%ebp),%eax
  1034fa:	8b 40 0c             	mov    0xc(%eax),%eax
  1034fd:	83 ec 08             	sub    $0x8,%esp
  103500:	ff 75 0c             	push   0xc(%ebp)
  103503:	50                   	push   %eax
  103504:	e8 ff f8 ff ff       	call   102e08 <stati>
  103509:	83 c4 10             	add    $0x10,%esp
    return 0;
  10350c:	b8 00 00 00 00       	mov    $0x0,%eax
  103511:	eb 05                	jmp    103518 <filestat+0x43>
  }
  return -1;
  103513:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  103518:	c9                   	leave
  103519:	c3                   	ret

0010351a <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
  10351a:	55                   	push   %ebp
  10351b:	89 e5                	mov    %esp,%ebp
  10351d:	83 ec 18             	sub    $0x18,%esp
  int r;

  if(f->readable == 0)
  103520:	8b 45 08             	mov    0x8(%ebp),%eax
  103523:	0f b6 40 08          	movzbl 0x8(%eax),%eax
  103527:	84 c0                	test   %al,%al
  103529:	75 07                	jne    103532 <fileread+0x18>
    return -1;
  10352b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  103530:	eb 65                	jmp    103597 <fileread+0x7d>
  if(f->type == FD_INODE){
  103532:	8b 45 08             	mov    0x8(%ebp),%eax
  103535:	8b 00                	mov    (%eax),%eax
  103537:	83 f8 01             	cmp    $0x1,%eax
  10353a:	75 4e                	jne    10358a <fileread+0x70>
    iread(f->ip);
  10353c:	8b 45 08             	mov    0x8(%ebp),%eax
  10353f:	8b 40 0c             	mov    0xc(%eax),%eax
  103542:	83 ec 0c             	sub    $0xc,%esp
  103545:	50                   	push   %eax
  103546:	e8 77 f5 ff ff       	call   102ac2 <iread>
  10354b:	83 c4 10             	add    $0x10,%esp
    if((r = readi(f->ip, addr, f->off, n)) > 0)
  10354e:	8b 4d 10             	mov    0x10(%ebp),%ecx
  103551:	8b 45 08             	mov    0x8(%ebp),%eax
  103554:	8b 50 10             	mov    0x10(%eax),%edx
  103557:	8b 45 08             	mov    0x8(%ebp),%eax
  10355a:	8b 40 0c             	mov    0xc(%eax),%eax
  10355d:	51                   	push   %ecx
  10355e:	52                   	push   %edx
  10355f:	ff 75 0c             	push   0xc(%ebp)
  103562:	50                   	push   %eax
  103563:	e8 e6 f8 ff ff       	call   102e4e <readi>
  103568:	83 c4 10             	add    $0x10,%esp
  10356b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  10356e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  103572:	7e 11                	jle    103585 <fileread+0x6b>
      f->off += r;
  103574:	8b 45 08             	mov    0x8(%ebp),%eax
  103577:	8b 50 10             	mov    0x10(%eax),%edx
  10357a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10357d:	01 c2                	add    %eax,%edx
  10357f:	8b 45 08             	mov    0x8(%ebp),%eax
  103582:	89 50 10             	mov    %edx,0x10(%eax)
    return r;
  103585:	8b 45 f4             	mov    -0xc(%ebp),%eax
  103588:	eb 0d                	jmp    103597 <fileread+0x7d>
  }
  panic("fileread");
  10358a:	83 ec 0c             	sub    $0xc,%esp
  10358d:	68 09 45 10 00       	push   $0x104509
  103592:	e8 17 cd ff ff       	call   1002ae <panic>
}
  103597:	c9                   	leave
  103598:	c3                   	ret

00103599 <filewrite>:

// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
  103599:	55                   	push   %ebp
  10359a:	89 e5                	mov    %esp,%ebp
  10359c:	53                   	push   %ebx
  10359d:	83 ec 14             	sub    $0x14,%esp
  int r;

  if(f->writable == 0)
  1035a0:	8b 45 08             	mov    0x8(%ebp),%eax
  1035a3:	0f b6 40 09          	movzbl 0x9(%eax),%eax
  1035a7:	84 c0                	test   %al,%al
  1035a9:	75 0a                	jne    1035b5 <filewrite+0x1c>
    return -1;
  1035ab:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  1035b0:	e9 e2 00 00 00       	jmp    103697 <filewrite+0xfe>
  if(f->type == FD_INODE){
  1035b5:	8b 45 08             	mov    0x8(%ebp),%eax
  1035b8:	8b 00                	mov    (%eax),%eax
  1035ba:	83 f8 01             	cmp    $0x1,%eax
  1035bd:	0f 85 c7 00 00 00    	jne    10368a <filewrite+0xf1>
    // write a few blocks at a time
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
  1035c3:	c7 45 ec 00 06 00 00 	movl   $0x600,-0x14(%ebp)
    int i = 0;
  1035ca:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    while(i < n){
  1035d1:	e9 91 00 00 00       	jmp    103667 <filewrite+0xce>
      int n1 = n - i;
  1035d6:	8b 45 10             	mov    0x10(%ebp),%eax
  1035d9:	2b 45 f4             	sub    -0xc(%ebp),%eax
  1035dc:	89 45 f0             	mov    %eax,-0x10(%ebp)
      if(n1 > max)
  1035df:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1035e2:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  1035e5:	7e 06                	jle    1035ed <filewrite+0x54>
        n1 = max;
  1035e7:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1035ea:	89 45 f0             	mov    %eax,-0x10(%ebp)

			begin_op();
  1035ed:	e8 dd 09 00 00       	call   103fcf <begin_op>
      iread(f->ip);
  1035f2:	8b 45 08             	mov    0x8(%ebp),%eax
  1035f5:	8b 40 0c             	mov    0xc(%eax),%eax
  1035f8:	83 ec 0c             	sub    $0xc,%esp
  1035fb:	50                   	push   %eax
  1035fc:	e8 c1 f4 ff ff       	call   102ac2 <iread>
  103601:	83 c4 10             	add    $0x10,%esp
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
  103604:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  103607:	8b 45 08             	mov    0x8(%ebp),%eax
  10360a:	8b 50 10             	mov    0x10(%eax),%edx
  10360d:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  103610:	8b 45 0c             	mov    0xc(%ebp),%eax
  103613:	01 c3                	add    %eax,%ebx
  103615:	8b 45 08             	mov    0x8(%ebp),%eax
  103618:	8b 40 0c             	mov    0xc(%eax),%eax
  10361b:	51                   	push   %ecx
  10361c:	52                   	push   %edx
  10361d:	53                   	push   %ebx
  10361e:	50                   	push   %eax
  10361f:	e8 25 f9 ff ff       	call   102f49 <writei>
  103624:	83 c4 10             	add    $0x10,%esp
  103627:	89 45 e8             	mov    %eax,-0x18(%ebp)
  10362a:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  10362e:	7e 11                	jle    103641 <filewrite+0xa8>
        f->off += r;
  103630:	8b 45 08             	mov    0x8(%ebp),%eax
  103633:	8b 50 10             	mov    0x10(%eax),%edx
  103636:	8b 45 e8             	mov    -0x18(%ebp),%eax
  103639:	01 c2                	add    %eax,%edx
  10363b:	8b 45 08             	mov    0x8(%ebp),%eax
  10363e:	89 50 10             	mov    %edx,0x10(%eax)
      end_op();
  103641:	e8 8f 09 00 00       	call   103fd5 <end_op>

      if(r < 0)
  103646:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  10364a:	78 29                	js     103675 <filewrite+0xdc>
        break;
      if(r != n1)
  10364c:	8b 45 e8             	mov    -0x18(%ebp),%eax
  10364f:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  103652:	74 0d                	je     103661 <filewrite+0xc8>
        panic("short filewrite");
  103654:	83 ec 0c             	sub    $0xc,%esp
  103657:	68 12 45 10 00       	push   $0x104512
  10365c:	e8 4d cc ff ff       	call   1002ae <panic>
      i += r;
  103661:	8b 45 e8             	mov    -0x18(%ebp),%eax
  103664:	01 45 f4             	add    %eax,-0xc(%ebp)
    while(i < n){
  103667:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10366a:	3b 45 10             	cmp    0x10(%ebp),%eax
  10366d:	0f 8c 63 ff ff ff    	jl     1035d6 <filewrite+0x3d>
  103673:	eb 01                	jmp    103676 <filewrite+0xdd>
        break;
  103675:	90                   	nop
    }
    return i == n ? n : -1;
  103676:	8b 45 f4             	mov    -0xc(%ebp),%eax
  103679:	3b 45 10             	cmp    0x10(%ebp),%eax
  10367c:	75 05                	jne    103683 <filewrite+0xea>
  10367e:	8b 45 10             	mov    0x10(%ebp),%eax
  103681:	eb 14                	jmp    103697 <filewrite+0xfe>
  103683:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  103688:	eb 0d                	jmp    103697 <filewrite+0xfe>
  }
  panic("filewrite");
  10368a:	83 ec 0c             	sub    $0xc,%esp
  10368d:	68 22 45 10 00       	push   $0x104522
  103692:	e8 17 cc ff ff       	call   1002ae <panic>
}
  103697:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  10369a:	c9                   	leave
  10369b:	c3                   	ret

0010369c <isdirempty>:

// Is the directory dp empty except for "." and ".." ?
int
isdirempty(struct inode *dp)
{
  10369c:	55                   	push   %ebp
  10369d:	89 e5                	mov    %esp,%ebp
  10369f:	83 ec 28             	sub    $0x28,%esp
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
  1036a2:	c7 45 f4 20 00 00 00 	movl   $0x20,-0xc(%ebp)
  1036a9:	eb 40                	jmp    1036eb <isdirempty+0x4f>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
  1036ab:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1036ae:	6a 10                	push   $0x10
  1036b0:	50                   	push   %eax
  1036b1:	8d 45 e4             	lea    -0x1c(%ebp),%eax
  1036b4:	50                   	push   %eax
  1036b5:	ff 75 08             	push   0x8(%ebp)
  1036b8:	e8 91 f7 ff ff       	call   102e4e <readi>
  1036bd:	83 c4 10             	add    $0x10,%esp
  1036c0:	83 f8 10             	cmp    $0x10,%eax
  1036c3:	74 0d                	je     1036d2 <isdirempty+0x36>
      panic("isdirempty: readi");
  1036c5:	83 ec 0c             	sub    $0xc,%esp
  1036c8:	68 2c 45 10 00       	push   $0x10452c
  1036cd:	e8 dc cb ff ff       	call   1002ae <panic>
    if(de.inum != 0)
  1036d2:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
  1036d6:	66 85 c0             	test   %ax,%ax
  1036d9:	74 07                	je     1036e2 <isdirempty+0x46>
      return 0;
  1036db:	b8 00 00 00 00       	mov    $0x0,%eax
  1036e0:	eb 1b                	jmp    1036fd <isdirempty+0x61>
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
  1036e2:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1036e5:	83 c0 10             	add    $0x10,%eax
  1036e8:	89 45 f4             	mov    %eax,-0xc(%ebp)
  1036eb:	8b 45 08             	mov    0x8(%ebp),%eax
  1036ee:	8b 40 18             	mov    0x18(%eax),%eax
  1036f1:	8b 55 f4             	mov    -0xc(%ebp),%edx
  1036f4:	39 c2                	cmp    %eax,%edx
  1036f6:	72 b3                	jb     1036ab <isdirempty+0xf>
  }
  return 1;
  1036f8:	b8 01 00 00 00       	mov    $0x1,%eax
}
  1036fd:	c9                   	leave
  1036fe:	c3                   	ret

001036ff <unlink>:

int
unlink(char* path, char* name)
{
  1036ff:	55                   	push   %ebp
  103700:	89 e5                	mov    %esp,%ebp
  103702:	83 ec 28             	sub    $0x28,%esp
  struct inode *ip, *dp;
  struct dirent de;
  uint off;

	begin_op();
  103705:	e8 c5 08 00 00       	call   103fcf <begin_op>
  if((dp = nameiparent(path, name)) == 0){
  10370a:	83 ec 08             	sub    $0x8,%esp
  10370d:	ff 75 0c             	push   0xc(%ebp)
  103710:	ff 75 08             	push   0x8(%ebp)
  103713:	e8 a5 fc ff ff       	call   1033bd <nameiparent>
  103718:	83 c4 10             	add    $0x10,%esp
  10371b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  10371e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  103722:	75 0f                	jne    103733 <unlink+0x34>
    end_op();
  103724:	e8 ac 08 00 00       	call   103fd5 <end_op>
    return -1;
  103729:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  10372e:	e9 8c 01 00 00       	jmp    1038bf <unlink+0x1c0>
  }

  iread(dp);
  103733:	83 ec 0c             	sub    $0xc,%esp
  103736:	ff 75 f4             	push   -0xc(%ebp)
  103739:	e8 84 f3 ff ff       	call   102ac2 <iread>
  10373e:	83 c4 10             	add    $0x10,%esp

  // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
  103741:	83 ec 08             	sub    $0x8,%esp
  103744:	68 3e 45 10 00       	push   $0x10453e
  103749:	ff 75 0c             	push   0xc(%ebp)
  10374c:	e8 18 f9 ff ff       	call   103069 <namecmp>
  103751:	83 c4 10             	add    $0x10,%esp
  103754:	85 c0                	test   %eax,%eax
  103756:	0f 84 47 01 00 00    	je     1038a3 <unlink+0x1a4>
  10375c:	83 ec 08             	sub    $0x8,%esp
  10375f:	68 40 45 10 00       	push   $0x104540
  103764:	ff 75 0c             	push   0xc(%ebp)
  103767:	e8 fd f8 ff ff       	call   103069 <namecmp>
  10376c:	83 c4 10             	add    $0x10,%esp
  10376f:	85 c0                	test   %eax,%eax
  103771:	0f 84 2c 01 00 00    	je     1038a3 <unlink+0x1a4>
    goto bad;

  if((ip = dirlookup(dp, name, &off)) == 0)
  103777:	83 ec 04             	sub    $0x4,%esp
  10377a:	8d 45 dc             	lea    -0x24(%ebp),%eax
  10377d:	50                   	push   %eax
  10377e:	ff 75 0c             	push   0xc(%ebp)
  103781:	ff 75 f4             	push   -0xc(%ebp)
  103784:	e8 fb f8 ff ff       	call   103084 <dirlookup>
  103789:	83 c4 10             	add    $0x10,%esp
  10378c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  10378f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  103793:	0f 84 0d 01 00 00    	je     1038a6 <unlink+0x1a7>
    goto bad;
  iread(ip);
  103799:	83 ec 0c             	sub    $0xc,%esp
  10379c:	ff 75 f0             	push   -0x10(%ebp)
  10379f:	e8 1e f3 ff ff       	call   102ac2 <iread>
  1037a4:	83 c4 10             	add    $0x10,%esp

  if(ip->nlink < 1)
  1037a7:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1037aa:	0f b7 40 16          	movzwl 0x16(%eax),%eax
  1037ae:	66 85 c0             	test   %ax,%ax
  1037b1:	7f 0d                	jg     1037c0 <unlink+0xc1>
    panic("unlink: nlink < 1");
  1037b3:	83 ec 0c             	sub    $0xc,%esp
  1037b6:	68 43 45 10 00       	push   $0x104543
  1037bb:	e8 ee ca ff ff       	call   1002ae <panic>
  if(ip->type == T_DIR && !isdirempty(ip)){
  1037c0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1037c3:	0f b7 40 10          	movzwl 0x10(%eax),%eax
  1037c7:	66 83 f8 01          	cmp    $0x1,%ax
  1037cb:	75 25                	jne    1037f2 <unlink+0xf3>
  1037cd:	83 ec 0c             	sub    $0xc,%esp
  1037d0:	ff 75 f0             	push   -0x10(%ebp)
  1037d3:	e8 c4 fe ff ff       	call   10369c <isdirempty>
  1037d8:	83 c4 10             	add    $0x10,%esp
  1037db:	85 c0                	test   %eax,%eax
  1037dd:	75 13                	jne    1037f2 <unlink+0xf3>
    iput(ip);
  1037df:	83 ec 0c             	sub    $0xc,%esp
  1037e2:	ff 75 f0             	push   -0x10(%ebp)
  1037e5:	e8 f9 f0 ff ff       	call   1028e3 <iput>
  1037ea:	83 c4 10             	add    $0x10,%esp
    goto bad;
  1037ed:	e9 b5 00 00 00       	jmp    1038a7 <unlink+0x1a8>
  }

  memset(&de, 0, sizeof(de));
  1037f2:	83 ec 04             	sub    $0x4,%esp
  1037f5:	6a 10                	push   $0x10
  1037f7:	6a 00                	push   $0x0
  1037f9:	8d 45 e0             	lea    -0x20(%ebp),%eax
  1037fc:	50                   	push   %eax
  1037fd:	e8 91 d6 ff ff       	call   100e93 <memset>
  103802:	83 c4 10             	add    $0x10,%esp
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
  103805:	8b 45 dc             	mov    -0x24(%ebp),%eax
  103808:	6a 10                	push   $0x10
  10380a:	50                   	push   %eax
  10380b:	8d 45 e0             	lea    -0x20(%ebp),%eax
  10380e:	50                   	push   %eax
  10380f:	ff 75 f4             	push   -0xc(%ebp)
  103812:	e8 32 f7 ff ff       	call   102f49 <writei>
  103817:	83 c4 10             	add    $0x10,%esp
  10381a:	83 f8 10             	cmp    $0x10,%eax
  10381d:	74 0d                	je     10382c <unlink+0x12d>
    panic("unlink: writei");
  10381f:	83 ec 0c             	sub    $0xc,%esp
  103822:	68 55 45 10 00       	push   $0x104555
  103827:	e8 82 ca ff ff       	call   1002ae <panic>
  if(ip->type == T_DIR){
  10382c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10382f:	0f b7 40 10          	movzwl 0x10(%eax),%eax
  103833:	66 83 f8 01          	cmp    $0x1,%ax
  103837:	75 21                	jne    10385a <unlink+0x15b>
    dp->nlink--;
  103839:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10383c:	0f b7 40 16          	movzwl 0x16(%eax),%eax
  103840:	83 e8 01             	sub    $0x1,%eax
  103843:	89 c2                	mov    %eax,%edx
  103845:	8b 45 f4             	mov    -0xc(%ebp),%eax
  103848:	66 89 50 16          	mov    %dx,0x16(%eax)
    iupdate(dp);
  10384c:	83 ec 0c             	sub    $0xc,%esp
  10384f:	ff 75 f4             	push   -0xc(%ebp)
  103852:	e8 f8 f0 ff ff       	call   10294f <iupdate>
  103857:	83 c4 10             	add    $0x10,%esp
  }
  iput(dp);
  10385a:	83 ec 0c             	sub    $0xc,%esp
  10385d:	ff 75 f4             	push   -0xc(%ebp)
  103860:	e8 7e f0 ff ff       	call   1028e3 <iput>
  103865:	83 c4 10             	add    $0x10,%esp

  ip->nlink--;
  103868:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10386b:	0f b7 40 16          	movzwl 0x16(%eax),%eax
  10386f:	83 e8 01             	sub    $0x1,%eax
  103872:	89 c2                	mov    %eax,%edx
  103874:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103877:	66 89 50 16          	mov    %dx,0x16(%eax)
  iupdate(ip);
  10387b:	83 ec 0c             	sub    $0xc,%esp
  10387e:	ff 75 f0             	push   -0x10(%ebp)
  103881:	e8 c9 f0 ff ff       	call   10294f <iupdate>
  103886:	83 c4 10             	add    $0x10,%esp
  iput(ip);
  103889:	83 ec 0c             	sub    $0xc,%esp
  10388c:	ff 75 f0             	push   -0x10(%ebp)
  10388f:	e8 4f f0 ff ff       	call   1028e3 <iput>
  103894:	83 c4 10             	add    $0x10,%esp

  end_op();
  103897:	e8 39 07 00 00       	call   103fd5 <end_op>
  return 0;
  10389c:	b8 00 00 00 00       	mov    $0x0,%eax
  1038a1:	eb 1c                	jmp    1038bf <unlink+0x1c0>
    goto bad;
  1038a3:	90                   	nop
  1038a4:	eb 01                	jmp    1038a7 <unlink+0x1a8>
    goto bad;
  1038a6:	90                   	nop

bad:
  iput(dp);
  1038a7:	83 ec 0c             	sub    $0xc,%esp
  1038aa:	ff 75 f4             	push   -0xc(%ebp)
  1038ad:	e8 31 f0 ff ff       	call   1028e3 <iput>
  1038b2:	83 c4 10             	add    $0x10,%esp
  end_op();
  1038b5:	e8 1b 07 00 00       	call   103fd5 <end_op>
  return -1;
  1038ba:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  1038bf:	c9                   	leave
  1038c0:	c3                   	ret

001038c1 <create>:

static struct inode*
create(char *path, short type, short major, short minor)
{
  1038c1:	55                   	push   %ebp
  1038c2:	89 e5                	mov    %esp,%ebp
  1038c4:	83 ec 38             	sub    $0x38,%esp
  1038c7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  1038ca:	8b 55 10             	mov    0x10(%ebp),%edx
  1038cd:	8b 45 14             	mov    0x14(%ebp),%eax
  1038d0:	66 89 4d d4          	mov    %cx,-0x2c(%ebp)
  1038d4:	66 89 55 d0          	mov    %dx,-0x30(%ebp)
  1038d8:	66 89 45 cc          	mov    %ax,-0x34(%ebp)
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
  1038dc:	83 ec 08             	sub    $0x8,%esp
  1038df:	8d 45 e2             	lea    -0x1e(%ebp),%eax
  1038e2:	50                   	push   %eax
  1038e3:	ff 75 08             	push   0x8(%ebp)
  1038e6:	e8 d2 fa ff ff       	call   1033bd <nameiparent>
  1038eb:	83 c4 10             	add    $0x10,%esp
  1038ee:	89 45 f4             	mov    %eax,-0xc(%ebp)
  1038f1:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  1038f5:	75 0a                	jne    103901 <create+0x40>
    return 0;
  1038f7:	b8 00 00 00 00       	mov    $0x0,%eax
  1038fc:	e9 8e 01 00 00       	jmp    103a8f <create+0x1ce>
  iread(dp);
  103901:	83 ec 0c             	sub    $0xc,%esp
  103904:	ff 75 f4             	push   -0xc(%ebp)
  103907:	e8 b6 f1 ff ff       	call   102ac2 <iread>
  10390c:	83 c4 10             	add    $0x10,%esp

  if((ip = dirlookup(dp, name, 0)) != 0){
  10390f:	83 ec 04             	sub    $0x4,%esp
  103912:	6a 00                	push   $0x0
  103914:	8d 45 e2             	lea    -0x1e(%ebp),%eax
  103917:	50                   	push   %eax
  103918:	ff 75 f4             	push   -0xc(%ebp)
  10391b:	e8 64 f7 ff ff       	call   103084 <dirlookup>
  103920:	83 c4 10             	add    $0x10,%esp
  103923:	89 45 f0             	mov    %eax,-0x10(%ebp)
  103926:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  10392a:	74 50                	je     10397c <create+0xbb>
    iput(dp);
  10392c:	83 ec 0c             	sub    $0xc,%esp
  10392f:	ff 75 f4             	push   -0xc(%ebp)
  103932:	e8 ac ef ff ff       	call   1028e3 <iput>
  103937:	83 c4 10             	add    $0x10,%esp
    iread(ip);
  10393a:	83 ec 0c             	sub    $0xc,%esp
  10393d:	ff 75 f0             	push   -0x10(%ebp)
  103940:	e8 7d f1 ff ff       	call   102ac2 <iread>
  103945:	83 c4 10             	add    $0x10,%esp
    if(type == T_FILE && ip->type == T_FILE)
  103948:	66 83 7d d4 02       	cmpw   $0x2,-0x2c(%ebp)
  10394d:	75 15                	jne    103964 <create+0xa3>
  10394f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103952:	0f b7 40 10          	movzwl 0x10(%eax),%eax
  103956:	66 83 f8 02          	cmp    $0x2,%ax
  10395a:	75 08                	jne    103964 <create+0xa3>
      return ip;
  10395c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10395f:	e9 2b 01 00 00       	jmp    103a8f <create+0x1ce>
    iput(ip);
  103964:	83 ec 0c             	sub    $0xc,%esp
  103967:	ff 75 f0             	push   -0x10(%ebp)
  10396a:	e8 74 ef ff ff       	call   1028e3 <iput>
  10396f:	83 c4 10             	add    $0x10,%esp
    return 0;
  103972:	b8 00 00 00 00       	mov    $0x0,%eax
  103977:	e9 13 01 00 00       	jmp    103a8f <create+0x1ce>
  }

  if((ip = ialloc(dp->dev, type)) == 0)
  10397c:	0f bf 55 d4          	movswl -0x2c(%ebp),%edx
  103980:	8b 45 f4             	mov    -0xc(%ebp),%eax
  103983:	8b 00                	mov    (%eax),%eax
  103985:	83 ec 08             	sub    $0x8,%esp
  103988:	52                   	push   %edx
  103989:	50                   	push   %eax
  10398a:	e8 7b ee ff ff       	call   10280a <ialloc>
  10398f:	83 c4 10             	add    $0x10,%esp
  103992:	89 45 f0             	mov    %eax,-0x10(%ebp)
  103995:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  103999:	75 0d                	jne    1039a8 <create+0xe7>
    panic("create: ialloc");
  10399b:	83 ec 0c             	sub    $0xc,%esp
  10399e:	68 64 45 10 00       	push   $0x104564
  1039a3:	e8 06 c9 ff ff       	call   1002ae <panic>

  iread(ip);
  1039a8:	83 ec 0c             	sub    $0xc,%esp
  1039ab:	ff 75 f0             	push   -0x10(%ebp)
  1039ae:	e8 0f f1 ff ff       	call   102ac2 <iread>
  1039b3:	83 c4 10             	add    $0x10,%esp
  ip->major = major;
  1039b6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1039b9:	0f b7 55 d0          	movzwl -0x30(%ebp),%edx
  1039bd:	66 89 50 12          	mov    %dx,0x12(%eax)
  ip->minor = minor;
  1039c1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1039c4:	0f b7 55 cc          	movzwl -0x34(%ebp),%edx
  1039c8:	66 89 50 14          	mov    %dx,0x14(%eax)
  ip->nlink = 1;
  1039cc:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1039cf:	66 c7 40 16 01 00    	movw   $0x1,0x16(%eax)
  iupdate(ip);
  1039d5:	83 ec 0c             	sub    $0xc,%esp
  1039d8:	ff 75 f0             	push   -0x10(%ebp)
  1039db:	e8 6f ef ff ff       	call   10294f <iupdate>
  1039e0:	83 c4 10             	add    $0x10,%esp

  if(type == T_DIR){  // Create . and .. entries.
  1039e3:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
  1039e8:	75 6a                	jne    103a54 <create+0x193>
    dp->nlink++;  // for ".."
  1039ea:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1039ed:	0f b7 40 16          	movzwl 0x16(%eax),%eax
  1039f1:	83 c0 01             	add    $0x1,%eax
  1039f4:	89 c2                	mov    %eax,%edx
  1039f6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1039f9:	66 89 50 16          	mov    %dx,0x16(%eax)
    iupdate(dp);
  1039fd:	83 ec 0c             	sub    $0xc,%esp
  103a00:	ff 75 f4             	push   -0xc(%ebp)
  103a03:	e8 47 ef ff ff       	call   10294f <iupdate>
  103a08:	83 c4 10             	add    $0x10,%esp
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
  103a0b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103a0e:	8b 40 04             	mov    0x4(%eax),%eax
  103a11:	83 ec 04             	sub    $0x4,%esp
  103a14:	50                   	push   %eax
  103a15:	68 3e 45 10 00       	push   $0x10453e
  103a1a:	ff 75 f0             	push   -0x10(%ebp)
  103a1d:	e8 1c f7 ff ff       	call   10313e <dirlink>
  103a22:	83 c4 10             	add    $0x10,%esp
  103a25:	85 c0                	test   %eax,%eax
  103a27:	78 1e                	js     103a47 <create+0x186>
  103a29:	8b 45 f4             	mov    -0xc(%ebp),%eax
  103a2c:	8b 40 04             	mov    0x4(%eax),%eax
  103a2f:	83 ec 04             	sub    $0x4,%esp
  103a32:	50                   	push   %eax
  103a33:	68 40 45 10 00       	push   $0x104540
  103a38:	ff 75 f0             	push   -0x10(%ebp)
  103a3b:	e8 fe f6 ff ff       	call   10313e <dirlink>
  103a40:	83 c4 10             	add    $0x10,%esp
  103a43:	85 c0                	test   %eax,%eax
  103a45:	79 0d                	jns    103a54 <create+0x193>
      panic("create dots");
  103a47:	83 ec 0c             	sub    $0xc,%esp
  103a4a:	68 73 45 10 00       	push   $0x104573
  103a4f:	e8 5a c8 ff ff       	call   1002ae <panic>
  }

  if(dirlink(dp, name, ip->inum) < 0)
  103a54:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103a57:	8b 40 04             	mov    0x4(%eax),%eax
  103a5a:	83 ec 04             	sub    $0x4,%esp
  103a5d:	50                   	push   %eax
  103a5e:	8d 45 e2             	lea    -0x1e(%ebp),%eax
  103a61:	50                   	push   %eax
  103a62:	ff 75 f4             	push   -0xc(%ebp)
  103a65:	e8 d4 f6 ff ff       	call   10313e <dirlink>
  103a6a:	83 c4 10             	add    $0x10,%esp
  103a6d:	85 c0                	test   %eax,%eax
  103a6f:	79 0d                	jns    103a7e <create+0x1bd>
    panic("create: dirlink");
  103a71:	83 ec 0c             	sub    $0xc,%esp
  103a74:	68 7f 45 10 00       	push   $0x10457f
  103a79:	e8 30 c8 ff ff       	call   1002ae <panic>

  iput(dp);
  103a7e:	83 ec 0c             	sub    $0xc,%esp
  103a81:	ff 75 f4             	push   -0xc(%ebp)
  103a84:	e8 5a ee ff ff       	call   1028e3 <iput>
  103a89:	83 c4 10             	add    $0x10,%esp

  return ip;
  103a8c:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  103a8f:	c9                   	leave
  103a90:	c3                   	ret

00103a91 <open>:


struct file*
open(char* path, int omode)
{
  103a91:	55                   	push   %ebp
  103a92:	89 e5                	mov    %esp,%ebp
  103a94:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;

  begin_op();
  103a97:	e8 33 05 00 00       	call   103fcf <begin_op>

  if(omode & O_CREATE){
  103a9c:	8b 45 0c             	mov    0xc(%ebp),%eax
  103a9f:	25 00 02 00 00       	and    $0x200,%eax
  103aa4:	85 c0                	test   %eax,%eax
  103aa6:	74 29                	je     103ad1 <open+0x40>
    ip = create(path, T_FILE, 0, 0);
  103aa8:	6a 00                	push   $0x0
  103aaa:	6a 00                	push   $0x0
  103aac:	6a 02                	push   $0x2
  103aae:	ff 75 08             	push   0x8(%ebp)
  103ab1:	e8 0b fe ff ff       	call   1038c1 <create>
  103ab6:	83 c4 10             	add    $0x10,%esp
  103ab9:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(ip == 0){
  103abc:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  103ac0:	75 73                	jne    103b35 <open+0xa4>
      end_op();
  103ac2:	e8 0e 05 00 00       	call   103fd5 <end_op>
      return 0;
  103ac7:	b8 00 00 00 00       	mov    $0x0,%eax
  103acc:	e9 eb 00 00 00       	jmp    103bbc <open+0x12b>
    }
  } else {
    if((ip = namei(path)) == 0){
  103ad1:	83 ec 0c             	sub    $0xc,%esp
  103ad4:	ff 75 08             	push   0x8(%ebp)
  103ad7:	e8 c5 f8 ff ff       	call   1033a1 <namei>
  103adc:	83 c4 10             	add    $0x10,%esp
  103adf:	89 45 f4             	mov    %eax,-0xc(%ebp)
  103ae2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  103ae6:	75 0f                	jne    103af7 <open+0x66>
      end_op();
  103ae8:	e8 e8 04 00 00       	call   103fd5 <end_op>
      return 0;
  103aed:	b8 00 00 00 00       	mov    $0x0,%eax
  103af2:	e9 c5 00 00 00       	jmp    103bbc <open+0x12b>
    }
    iread(ip);
  103af7:	83 ec 0c             	sub    $0xc,%esp
  103afa:	ff 75 f4             	push   -0xc(%ebp)
  103afd:	e8 c0 ef ff ff       	call   102ac2 <iread>
  103b02:	83 c4 10             	add    $0x10,%esp
    if(ip->type == T_DIR && omode != O_RDONLY){
  103b05:	8b 45 f4             	mov    -0xc(%ebp),%eax
  103b08:	0f b7 40 10          	movzwl 0x10(%eax),%eax
  103b0c:	66 83 f8 01          	cmp    $0x1,%ax
  103b10:	75 23                	jne    103b35 <open+0xa4>
  103b12:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  103b16:	74 1d                	je     103b35 <open+0xa4>
      iput(ip);
  103b18:	83 ec 0c             	sub    $0xc,%esp
  103b1b:	ff 75 f4             	push   -0xc(%ebp)
  103b1e:	e8 c0 ed ff ff       	call   1028e3 <iput>
  103b23:	83 c4 10             	add    $0x10,%esp
      end_op();
  103b26:	e8 aa 04 00 00       	call   103fd5 <end_op>
      return 0;
  103b2b:	b8 00 00 00 00       	mov    $0x0,%eax
  103b30:	e9 87 00 00 00       	jmp    103bbc <open+0x12b>
    }
  }

  struct file* f;
  if((f = filealloc()) == 0) { 
  103b35:	e8 9e f8 ff ff       	call   1033d8 <filealloc>
  103b3a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  103b3d:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  103b41:	75 1a                	jne    103b5d <open+0xcc>
    iput(ip);
  103b43:	83 ec 0c             	sub    $0xc,%esp
  103b46:	ff 75 f4             	push   -0xc(%ebp)
  103b49:	e8 95 ed ff ff       	call   1028e3 <iput>
  103b4e:	83 c4 10             	add    $0x10,%esp
    end_op();
  103b51:	e8 7f 04 00 00       	call   103fd5 <end_op>
    return 0;
  103b56:	b8 00 00 00 00       	mov    $0x0,%eax
  103b5b:	eb 5f                	jmp    103bbc <open+0x12b>
  }

  f->type = FD_INODE;
  103b5d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103b60:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  f->ip = ip;
  103b66:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103b69:	8b 55 f4             	mov    -0xc(%ebp),%edx
  103b6c:	89 50 0c             	mov    %edx,0xc(%eax)
  f->off = 0;
  103b6f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103b72:	c7 40 10 00 00 00 00 	movl   $0x0,0x10(%eax)
  f->readable = !(omode & O_WRONLY);
  103b79:	8b 45 0c             	mov    0xc(%ebp),%eax
  103b7c:	83 e0 01             	and    $0x1,%eax
  103b7f:	85 c0                	test   %eax,%eax
  103b81:	0f 94 c0             	sete   %al
  103b84:	89 c2                	mov    %eax,%edx
  103b86:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103b89:	88 50 08             	mov    %dl,0x8(%eax)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
  103b8c:	8b 45 0c             	mov    0xc(%ebp),%eax
  103b8f:	83 e0 01             	and    $0x1,%eax
  103b92:	85 c0                	test   %eax,%eax
  103b94:	75 0a                	jne    103ba0 <open+0x10f>
  103b96:	8b 45 0c             	mov    0xc(%ebp),%eax
  103b99:	83 e0 02             	and    $0x2,%eax
  103b9c:	85 c0                	test   %eax,%eax
  103b9e:	74 07                	je     103ba7 <open+0x116>
  103ba0:	b8 01 00 00 00       	mov    $0x1,%eax
  103ba5:	eb 05                	jmp    103bac <open+0x11b>
  103ba7:	b8 00 00 00 00       	mov    $0x0,%eax
  103bac:	89 c2                	mov    %eax,%edx
  103bae:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103bb1:	88 50 09             	mov    %dl,0x9(%eax)
  end_op();
  103bb4:	e8 1c 04 00 00       	call   103fd5 <end_op>
  return f;
  103bb9:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  103bbc:	c9                   	leave
  103bbd:	c3                   	ret

00103bbe <mkdir>:

int mkdir(char *path)
{
  103bbe:	55                   	push   %ebp
  103bbf:	89 e5                	mov    %esp,%ebp
  103bc1:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;

  begin_op();
  103bc4:	e8 06 04 00 00       	call   103fcf <begin_op>
  if((ip = create(path, T_DIR, 0, 0)) == 0){
  103bc9:	6a 00                	push   $0x0
  103bcb:	6a 00                	push   $0x0
  103bcd:	6a 01                	push   $0x1
  103bcf:	ff 75 08             	push   0x8(%ebp)
  103bd2:	e8 ea fc ff ff       	call   1038c1 <create>
  103bd7:	83 c4 10             	add    $0x10,%esp
  103bda:	89 45 f4             	mov    %eax,-0xc(%ebp)
  103bdd:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  103be1:	75 0c                	jne    103bef <mkdir+0x31>
    end_op();
  103be3:	e8 ed 03 00 00       	call   103fd5 <end_op>
    return -1;
  103be8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  103bed:	eb 18                	jmp    103c07 <mkdir+0x49>
  }
  iput(ip);
  103bef:	83 ec 0c             	sub    $0xc,%esp
  103bf2:	ff 75 f4             	push   -0xc(%ebp)
  103bf5:	e8 e9 ec ff ff       	call   1028e3 <iput>
  103bfa:	83 c4 10             	add    $0x10,%esp
  end_op();
  103bfd:	e8 d3 03 00 00       	call   103fd5 <end_op>
  return 0;
  103c02:	b8 00 00 00 00       	mov    $0x0,%eax
  103c07:	c9                   	leave
  103c08:	c3                   	ret

00103c09 <initlog>:
static void bump_recovery_undos(void);
static void print_stats(void);

void
initlog(int dev)
{
  103c09:	55                   	push   %ebp
  103c0a:	89 e5                	mov    %esp,%ebp
  103c0c:	83 ec 28             	sub    $0x28,%esp
  if (sizeof(struct logheader) >= BSIZE)
    panic("initlog: too big logheader");

  struct superblock sb;
  readsb(dev, &sb);
  103c0f:	83 ec 08             	sub    $0x8,%esp
  103c12:	8d 45 dc             	lea    -0x24(%ebp),%eax
  103c15:	50                   	push   %eax
  103c16:	ff 75 08             	push   0x8(%ebp)
  103c19:	e8 da e8 ff ff       	call   1024f8 <readsb>
  103c1e:	83 c4 10             	add    $0x10,%esp
  log.start = sb.logstart;
  103c21:	8b 45 ec             	mov    -0x14(%ebp),%eax
  103c24:	a3 a0 f4 10 00       	mov    %eax,0x10f4a0
  log.size = sb.nlog;
  103c29:	8b 45 e8             	mov    -0x18(%ebp),%eax
  103c2c:	a3 a4 f4 10 00       	mov    %eax,0x10f4a4
  log.dev = dev;
  103c31:	8b 45 08             	mov    0x8(%ebp),%eax
  103c34:	a3 ac f4 10 00       	mov    %eax,0x10f4ac
  load_stats();
  103c39:	e8 76 00 00 00       	call   103cb4 <load_stats>
  recover_from_log();
  103c3e:	e8 56 03 00 00       	call   103f99 <recover_from_log>
  print_stats();
  103c43:	e8 15 01 00 00       	call   103d5d <print_stats>
}
  103c48:	90                   	nop
  103c49:	c9                   	leave
  103c4a:	c3                   	ret

00103c4b <persist_stats>:

// Persist in-memory counters into block 0 of fs.img.
static void
persist_stats(void)
{
  103c4b:	55                   	push   %ebp
  103c4c:	89 e5                	mov    %esp,%ebp
  103c4e:	83 ec 18             	sub    $0x18,%esp
  struct buf *buf = bread(log.dev, LOGSTATS_BLOCKNO);
  103c51:	a1 ac f4 10 00       	mov    0x10f4ac,%eax
  103c56:	83 ec 08             	sub    $0x8,%esp
  103c59:	6a 00                	push   $0x0
  103c5b:	50                   	push   %eax
  103c5c:	e8 87 e3 ff ff       	call   101fe8 <bread>
  103c61:	83 c4 10             	add    $0x10,%esp
  103c64:	89 45 f4             	mov    %eax,-0xc(%ebp)
  struct logstats_disk *sd = (struct logstats_disk *)buf->data;
  103c67:	8b 45 f4             	mov    -0xc(%ebp),%eax
  103c6a:	05 20 02 00 00       	add    $0x220,%eax
  103c6f:	89 45 f0             	mov    %eax,-0x10(%ebp)

  sd->log_writes = stats.log_writes;
  103c72:	8b 15 30 f5 10 00    	mov    0x10f530,%edx
  103c78:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103c7b:	89 10                	mov    %edx,(%eax)
  sd->home_writes = stats.home_writes;
  103c7d:	8b 15 34 f5 10 00    	mov    0x10f534,%edx
  103c83:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103c86:	89 50 04             	mov    %edx,0x4(%eax)
  sd->recovery_undos = stats.recovery_undos;
  103c89:	8b 15 38 f5 10 00    	mov    0x10f538,%edx
  103c8f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103c92:	89 50 08             	mov    %edx,0x8(%eax)
  bwrite(buf);
  103c95:	83 ec 0c             	sub    $0xc,%esp
  103c98:	ff 75 f4             	push   -0xc(%ebp)
  103c9b:	e8 8f e3 ff ff       	call   10202f <bwrite>
  103ca0:	83 c4 10             	add    $0x10,%esp
  brelse(buf);
  103ca3:	83 ec 0c             	sub    $0xc,%esp
  103ca6:	ff 75 f4             	push   -0xc(%ebp)
  103ca9:	e8 c0 e3 ff ff       	call   10206e <brelse>
  103cae:	83 c4 10             	add    $0x10,%esp
}
  103cb1:	90                   	nop
  103cb2:	c9                   	leave
  103cb3:	c3                   	ret

00103cb4 <load_stats>:

// Load counters from block 0 of fs.img.
static void
load_stats(void)
{
  103cb4:	55                   	push   %ebp
  103cb5:	89 e5                	mov    %esp,%ebp
  103cb7:	83 ec 18             	sub    $0x18,%esp
  struct buf *buf = bread(log.dev, LOGSTATS_BLOCKNO);
  103cba:	a1 ac f4 10 00       	mov    0x10f4ac,%eax
  103cbf:	83 ec 08             	sub    $0x8,%esp
  103cc2:	6a 00                	push   $0x0
  103cc4:	50                   	push   %eax
  103cc5:	e8 1e e3 ff ff       	call   101fe8 <bread>
  103cca:	83 c4 10             	add    $0x10,%esp
  103ccd:	89 45 f4             	mov    %eax,-0xc(%ebp)
  struct logstats_disk *sd = (struct logstats_disk *)buf->data;
  103cd0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  103cd3:	05 20 02 00 00       	add    $0x220,%eax
  103cd8:	89 45 f0             	mov    %eax,-0x10(%ebp)

  stats.log_writes = sd->log_writes;
  103cdb:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103cde:	8b 00                	mov    (%eax),%eax
  103ce0:	a3 30 f5 10 00       	mov    %eax,0x10f530
  stats.home_writes = sd->home_writes;
  103ce5:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103ce8:	8b 40 04             	mov    0x4(%eax),%eax
  103ceb:	a3 34 f5 10 00       	mov    %eax,0x10f534
  stats.recovery_undos = sd->recovery_undos;
  103cf0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103cf3:	8b 40 08             	mov    0x8(%eax),%eax
  103cf6:	a3 38 f5 10 00       	mov    %eax,0x10f538
  brelse(buf);
  103cfb:	83 ec 0c             	sub    $0xc,%esp
  103cfe:	ff 75 f4             	push   -0xc(%ebp)
  103d01:	e8 68 e3 ff ff       	call   10206e <brelse>
  103d06:	83 c4 10             	add    $0x10,%esp
}
  103d09:	90                   	nop
  103d0a:	c9                   	leave
  103d0b:	c3                   	ret

00103d0c <bump_log_writes>:

// Keep these helpers tiny and explicit so each update is durable.
static void
bump_log_writes(void)
{
  103d0c:	55                   	push   %ebp
  103d0d:	89 e5                	mov    %esp,%ebp
  103d0f:	83 ec 08             	sub    $0x8,%esp
  stats.log_writes++;
  103d12:	a1 30 f5 10 00       	mov    0x10f530,%eax
  103d17:	83 c0 01             	add    $0x1,%eax
  103d1a:	a3 30 f5 10 00       	mov    %eax,0x10f530
  persist_stats();
  103d1f:	e8 27 ff ff ff       	call   103c4b <persist_stats>
}
  103d24:	90                   	nop
  103d25:	c9                   	leave
  103d26:	c3                   	ret

00103d27 <bump_home_writes>:

static void
bump_home_writes(void)
{
  103d27:	55                   	push   %ebp
  103d28:	89 e5                	mov    %esp,%ebp
  103d2a:	83 ec 08             	sub    $0x8,%esp
  stats.home_writes++;
  103d2d:	a1 34 f5 10 00       	mov    0x10f534,%eax
  103d32:	83 c0 01             	add    $0x1,%eax
  103d35:	a3 34 f5 10 00       	mov    %eax,0x10f534
  persist_stats();
  103d3a:	e8 0c ff ff ff       	call   103c4b <persist_stats>
}
  103d3f:	90                   	nop
  103d40:	c9                   	leave
  103d41:	c3                   	ret

00103d42 <bump_recovery_undos>:

static void
bump_recovery_undos(void)
{
  103d42:	55                   	push   %ebp
  103d43:	89 e5                	mov    %esp,%ebp
  103d45:	83 ec 08             	sub    $0x8,%esp
  stats.recovery_undos++;
  103d48:	a1 38 f5 10 00       	mov    0x10f538,%eax
  103d4d:	83 c0 01             	add    $0x1,%eax
  103d50:	a3 38 f5 10 00       	mov    %eax,0x10f538
  persist_stats();
  103d55:	e8 f1 fe ff ff       	call   103c4b <persist_stats>
}
  103d5a:	90                   	nop
  103d5b:	c9                   	leave
  103d5c:	c3                   	ret

00103d5d <print_stats>:

// Print once on boot so tests/manual runs can observe persisted counters.
static void
print_stats(void)
{
  103d5d:	55                   	push   %ebp
  103d5e:	89 e5                	mov    %esp,%ebp
  103d60:	83 ec 08             	sub    $0x8,%esp
  cprintf("[STATS] log_writes=%d home_writes=%d recovery_undos=%d\n",
  103d63:	8b 0d 38 f5 10 00    	mov    0x10f538,%ecx
  103d69:	8b 15 34 f5 10 00    	mov    0x10f534,%edx
  103d6f:	a1 30 f5 10 00       	mov    0x10f530,%eax
  103d74:	51                   	push   %ecx
  103d75:	52                   	push   %edx
  103d76:	50                   	push   %eax
  103d77:	68 90 45 10 00       	push   $0x104590
  103d7c:	e8 6b c3 ff ff       	call   1000ec <cprintf>
  103d81:	83 c4 10             	add    $0x10,%esp
          stats.log_writes, stats.home_writes, stats.recovery_undos);
}
  103d84:	90                   	nop
  103d85:	c9                   	leave
  103d86:	c3                   	ret

00103d87 <install_trans>:

// During recovery: restore old blocks from log to home locations (undo).
// During commit: flush the in-cache modified home blocks to disk (install new).
static void
install_trans(void)
{
  103d87:	55                   	push   %ebp
  103d88:	89 e5                	mov    %esp,%ebp
  103d8a:	83 ec 18             	sub    $0x18,%esp
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
  103d8d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  103d94:	e9 f3 00 00 00       	jmp    103e8c <install_trans+0x105>
    if (PANIC_5) {
      if (tail == log.lh.n/2) panic("[UNDOLOG] Panic in install_trans type 5");
    }
    if (recovering) {
  103d99:	a1 2c f5 10 00       	mov    0x10f52c,%eax
  103d9e:	85 c0                	test   %eax,%eax
  103da0:	0f 84 9d 00 00 00    	je     103e43 <install_trans+0xbc>
      // Recovery path: undo uncommitted writes with old values from the log.
      struct buf *lbuf = bread(log.dev, log.start+tail+1);
  103da6:	8b 15 a0 f4 10 00    	mov    0x10f4a0,%edx
  103dac:	8b 45 f4             	mov    -0xc(%ebp),%eax
  103daf:	01 d0                	add    %edx,%eax
  103db1:	83 c0 01             	add    $0x1,%eax
  103db4:	89 c2                	mov    %eax,%edx
  103db6:	a1 ac f4 10 00       	mov    0x10f4ac,%eax
  103dbb:	83 ec 08             	sub    $0x8,%esp
  103dbe:	52                   	push   %edx
  103dbf:	50                   	push   %eax
  103dc0:	e8 23 e2 ff ff       	call   101fe8 <bread>
  103dc5:	83 c4 10             	add    $0x10,%esp
  103dc8:	89 45 ec             	mov    %eax,-0x14(%ebp)
      struct buf *dbuf = bread(log.dev, log.lh.block[tail]);
  103dcb:	8b 45 f4             	mov    -0xc(%ebp),%eax
  103dce:	83 c0 04             	add    $0x4,%eax
  103dd1:	8b 04 85 a4 f4 10 00 	mov    0x10f4a4(,%eax,4),%eax
  103dd8:	89 c2                	mov    %eax,%edx
  103dda:	a1 ac f4 10 00       	mov    0x10f4ac,%eax
  103ddf:	83 ec 08             	sub    $0x8,%esp
  103de2:	52                   	push   %edx
  103de3:	50                   	push   %eax
  103de4:	e8 ff e1 ff ff       	call   101fe8 <bread>
  103de9:	83 c4 10             	add    $0x10,%esp
  103dec:	89 45 e8             	mov    %eax,-0x18(%ebp)
      memmove(dbuf->data, lbuf->data, BSIZE);
  103def:	8b 45 ec             	mov    -0x14(%ebp),%eax
  103df2:	8d 90 20 02 00 00    	lea    0x220(%eax),%edx
  103df8:	8b 45 e8             	mov    -0x18(%ebp),%eax
  103dfb:	05 20 02 00 00       	add    $0x220,%eax
  103e00:	83 ec 04             	sub    $0x4,%esp
  103e03:	68 00 02 00 00       	push   $0x200
  103e08:	52                   	push   %edx
  103e09:	50                   	push   %eax
  103e0a:	e8 43 d1 ff ff       	call   100f52 <memmove>
  103e0f:	83 c4 10             	add    $0x10,%esp
      bwrite(dbuf);
  103e12:	83 ec 0c             	sub    $0xc,%esp
  103e15:	ff 75 e8             	push   -0x18(%ebp)
  103e18:	e8 12 e2 ff ff       	call   10202f <bwrite>
  103e1d:	83 c4 10             	add    $0x10,%esp
      bump_recovery_undos();
  103e20:	e8 1d ff ff ff       	call   103d42 <bump_recovery_undos>
      brelse(lbuf);
  103e25:	83 ec 0c             	sub    $0xc,%esp
  103e28:	ff 75 ec             	push   -0x14(%ebp)
  103e2b:	e8 3e e2 ff ff       	call   10206e <brelse>
  103e30:	83 c4 10             	add    $0x10,%esp
      brelse(dbuf);
  103e33:	83 ec 0c             	sub    $0xc,%esp
  103e36:	ff 75 e8             	push   -0x18(%ebp)
  103e39:	e8 30 e2 ff ff       	call   10206e <brelse>
  103e3e:	83 c4 10             	add    $0x10,%esp
  103e41:	eb 45                	jmp    103e88 <install_trans+0x101>
    } else {
      // Commit path: write the already-modified home buffer to its disk block.
      struct buf *dbuf = bread(log.dev, log.lh.block[tail]);
  103e43:	8b 45 f4             	mov    -0xc(%ebp),%eax
  103e46:	83 c0 04             	add    $0x4,%eax
  103e49:	8b 04 85 a4 f4 10 00 	mov    0x10f4a4(,%eax,4),%eax
  103e50:	89 c2                	mov    %eax,%edx
  103e52:	a1 ac f4 10 00       	mov    0x10f4ac,%eax
  103e57:	83 ec 08             	sub    $0x8,%esp
  103e5a:	52                   	push   %edx
  103e5b:	50                   	push   %eax
  103e5c:	e8 87 e1 ff ff       	call   101fe8 <bread>
  103e61:	83 c4 10             	add    $0x10,%esp
  103e64:	89 45 f0             	mov    %eax,-0x10(%ebp)
      bwrite(dbuf);
  103e67:	83 ec 0c             	sub    $0xc,%esp
  103e6a:	ff 75 f0             	push   -0x10(%ebp)
  103e6d:	e8 bd e1 ff ff       	call   10202f <bwrite>
  103e72:	83 c4 10             	add    $0x10,%esp
      bump_home_writes();
  103e75:	e8 ad fe ff ff       	call   103d27 <bump_home_writes>
      brelse(dbuf);
  103e7a:	83 ec 0c             	sub    $0xc,%esp
  103e7d:	ff 75 f0             	push   -0x10(%ebp)
  103e80:	e8 e9 e1 ff ff       	call   10206e <brelse>
  103e85:	83 c4 10             	add    $0x10,%esp
  for (tail = 0; tail < log.lh.n; tail++) {
  103e88:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  103e8c:	a1 b0 f4 10 00       	mov    0x10f4b0,%eax
  103e91:	39 45 f4             	cmp    %eax,-0xc(%ebp)
  103e94:	0f 8c ff fe ff ff    	jl     103d99 <install_trans+0x12>
    }
  }
}
  103e9a:	90                   	nop
  103e9b:	90                   	nop
  103e9c:	c9                   	leave
  103e9d:	c3                   	ret

00103e9e <read_head>:

// Read the log header from disk into the in-memory log header
static void
read_head(void)
{
  103e9e:	55                   	push   %ebp
  103e9f:	89 e5                	mov    %esp,%ebp
  103ea1:	83 ec 18             	sub    $0x18,%esp
  struct buf *buf = bread(log.dev, log.start);
  103ea4:	a1 a0 f4 10 00       	mov    0x10f4a0,%eax
  103ea9:	89 c2                	mov    %eax,%edx
  103eab:	a1 ac f4 10 00       	mov    0x10f4ac,%eax
  103eb0:	83 ec 08             	sub    $0x8,%esp
  103eb3:	52                   	push   %edx
  103eb4:	50                   	push   %eax
  103eb5:	e8 2e e1 ff ff       	call   101fe8 <bread>
  103eba:	83 c4 10             	add    $0x10,%esp
  103ebd:	89 45 f0             	mov    %eax,-0x10(%ebp)
  struct logheader *lh = (struct logheader *) (buf->data);
  103ec0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103ec3:	05 20 02 00 00       	add    $0x220,%eax
  103ec8:	89 45 ec             	mov    %eax,-0x14(%ebp)
  int i;
  log.lh.n = lh->n;
  103ecb:	8b 45 ec             	mov    -0x14(%ebp),%eax
  103ece:	8b 00                	mov    (%eax),%eax
  103ed0:	a3 b0 f4 10 00       	mov    %eax,0x10f4b0
  for (i = 0; i < log.lh.n; i++) {
  103ed5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  103edc:	eb 1b                	jmp    103ef9 <read_head+0x5b>
    log.lh.block[i] = lh->block[i];
  103ede:	8b 45 ec             	mov    -0x14(%ebp),%eax
  103ee1:	8b 55 f4             	mov    -0xc(%ebp),%edx
  103ee4:	8b 44 90 04          	mov    0x4(%eax,%edx,4),%eax
  103ee8:	8b 55 f4             	mov    -0xc(%ebp),%edx
  103eeb:	83 c2 04             	add    $0x4,%edx
  103eee:	89 04 95 a4 f4 10 00 	mov    %eax,0x10f4a4(,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
  103ef5:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  103ef9:	a1 b0 f4 10 00       	mov    0x10f4b0,%eax
  103efe:	39 45 f4             	cmp    %eax,-0xc(%ebp)
  103f01:	7c db                	jl     103ede <read_head+0x40>
  }
  brelse(buf);
  103f03:	83 ec 0c             	sub    $0xc,%esp
  103f06:	ff 75 f0             	push   -0x10(%ebp)
  103f09:	e8 60 e1 ff ff       	call   10206e <brelse>
  103f0e:	83 c4 10             	add    $0x10,%esp
}
  103f11:	90                   	nop
  103f12:	c9                   	leave
  103f13:	c3                   	ret

00103f14 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
  103f14:	55                   	push   %ebp
  103f15:	89 e5                	mov    %esp,%ebp
  103f17:	83 ec 18             	sub    $0x18,%esp
  struct buf *buf = bread(log.dev, log.start);
  103f1a:	a1 a0 f4 10 00       	mov    0x10f4a0,%eax
  103f1f:	89 c2                	mov    %eax,%edx
  103f21:	a1 ac f4 10 00       	mov    0x10f4ac,%eax
  103f26:	83 ec 08             	sub    $0x8,%esp
  103f29:	52                   	push   %edx
  103f2a:	50                   	push   %eax
  103f2b:	e8 b8 e0 ff ff       	call   101fe8 <bread>
  103f30:	83 c4 10             	add    $0x10,%esp
  103f33:	89 45 f0             	mov    %eax,-0x10(%ebp)
  struct logheader *hb = (struct logheader *) (buf->data);
  103f36:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103f39:	05 20 02 00 00       	add    $0x220,%eax
  103f3e:	89 45 ec             	mov    %eax,-0x14(%ebp)
  int i;
  hb->n = log.lh.n;
  103f41:	8b 15 b0 f4 10 00    	mov    0x10f4b0,%edx
  103f47:	8b 45 ec             	mov    -0x14(%ebp),%eax
  103f4a:	89 10                	mov    %edx,(%eax)
  for (i = 0; i < log.lh.n; i++) {
  103f4c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  103f53:	eb 1b                	jmp    103f70 <write_head+0x5c>
    hb->block[i] = log.lh.block[i];
  103f55:	8b 45 f4             	mov    -0xc(%ebp),%eax
  103f58:	83 c0 04             	add    $0x4,%eax
  103f5b:	8b 0c 85 a4 f4 10 00 	mov    0x10f4a4(,%eax,4),%ecx
  103f62:	8b 45 ec             	mov    -0x14(%ebp),%eax
  103f65:	8b 55 f4             	mov    -0xc(%ebp),%edx
  103f68:	89 4c 90 04          	mov    %ecx,0x4(%eax,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
  103f6c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  103f70:	a1 b0 f4 10 00       	mov    0x10f4b0,%eax
  103f75:	39 45 f4             	cmp    %eax,-0xc(%ebp)
  103f78:	7c db                	jl     103f55 <write_head+0x41>
  }
  bwrite(buf);
  103f7a:	83 ec 0c             	sub    $0xc,%esp
  103f7d:	ff 75 f0             	push   -0x10(%ebp)
  103f80:	e8 aa e0 ff ff       	call   10202f <bwrite>
  103f85:	83 c4 10             	add    $0x10,%esp
  brelse(buf);
  103f88:	83 ec 0c             	sub    $0xc,%esp
  103f8b:	ff 75 f0             	push   -0x10(%ebp)
  103f8e:	e8 db e0 ff ff       	call   10206e <brelse>
  103f93:	83 c4 10             	add    $0x10,%esp
}
  103f96:	90                   	nop
  103f97:	c9                   	leave
  103f98:	c3                   	ret

00103f99 <recover_from_log>:

static void
recover_from_log(void)
{
  103f99:	55                   	push   %ebp
  103f9a:	89 e5                	mov    %esp,%ebp
  103f9c:	83 ec 08             	sub    $0x8,%esp
  read_head();
  103f9f:	e8 fa fe ff ff       	call   103e9e <read_head>
  // A non-empty header at boot means crash before commit completed.
  recovering = 1;
  103fa4:	c7 05 2c f5 10 00 01 	movl   $0x1,0x10f52c
  103fab:	00 00 00 
  install_trans();
  103fae:	e8 d4 fd ff ff       	call   103d87 <install_trans>
  recovering = 0;
  103fb3:	c7 05 2c f5 10 00 00 	movl   $0x0,0x10f52c
  103fba:	00 00 00 
  log.lh.n = 0;
  103fbd:	c7 05 b0 f4 10 00 00 	movl   $0x0,0x10f4b0
  103fc4:	00 00 00 
  write_head(); // clear the log
  103fc7:	e8 48 ff ff ff       	call   103f14 <write_head>
}
  103fcc:	90                   	nop
  103fcd:	c9                   	leave
  103fce:	c3                   	ret

00103fcf <begin_op>:

// called at the start of each FS system call.
void
begin_op(void)
{
  103fcf:	55                   	push   %ebp
  103fd0:	89 e5                	mov    %esp,%ebp
  // This lab setup commits at each end_op(), so begin_op() is a no-op.
}
  103fd2:	90                   	nop
  103fd3:	5d                   	pop    %ebp
  103fd4:	c3                   	ret

00103fd5 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
  103fd5:	55                   	push   %ebp
  103fd6:	89 e5                	mov    %esp,%ebp
  103fd8:	83 ec 08             	sub    $0x8,%esp
  // call commit w/o holding locks, since not allowed
  // to sleep with locks.
  recovering = 0; // commit path installs new data, not undo data
  103fdb:	c7 05 2c f5 10 00 00 	movl   $0x0,0x10f52c
  103fe2:	00 00 00 
  commit();
  103fe5:	e8 03 00 00 00       	call   103fed <commit>
}
  103fea:	90                   	nop
  103feb:	c9                   	leave
  103fec:	c3                   	ret

00103fed <commit>:

/* DO NOT MODIFY THIS FUNCTION*/
static void
commit()
{
  103fed:	55                   	push   %ebp
  103fee:	89 e5                	mov    %esp,%ebp
  103ff0:	83 ec 08             	sub    $0x8,%esp
  if (log.lh.n > 0) {
  103ff3:	a1 b0 f4 10 00       	mov    0x10f4b0,%eax
  103ff8:	85 c0                	test   %eax,%eax
  103ffa:	7e 19                	jle    104015 <commit+0x28>
    if (PANIC_1) {
      panic("[UNDOLOG] Panic in commit type 1");
    }
    write_head();    // Write header to disk 
  103ffc:	e8 13 ff ff ff       	call   103f14 <write_head>
    if (PANIC_2) {
      panic("[UNDOLOG] Panic in commit type 2");
    }
    install_trans(); // Now install writes to home locations    
  104001:	e8 81 fd ff ff       	call   103d87 <install_trans>
    if (PANIC_3) {
      panic("[UNDOLOG] Panic in commit type 3");
    }
    log.lh.n = 0;
  104006:	c7 05 b0 f4 10 00 00 	movl   $0x0,0x10f4b0
  10400d:	00 00 00 
    write_head();    // Erase the transaction from the log 
  104010:	e8 ff fe ff ff       	call   103f14 <write_head>
    if (PANIC_4) {
      panic("[UNDOLOG] Panic in commit type 4");
    }  
  }
}
  104015:	90                   	nop
  104016:	c9                   	leave
  104017:	c3                   	ret

00104018 <log_has_block>:

// Check if a home block is already part of the active in-memory transaction.
int
log_has_block(uint blockno)
{
  104018:	55                   	push   %ebp
  104019:	89 e5                	mov    %esp,%ebp
  10401b:	83 ec 10             	sub    $0x10,%esp
  int i;

  for (i = 0; i < log.lh.n; i++) {
  10401e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  104025:	eb 1d                	jmp    104044 <log_has_block+0x2c>
    if (log.lh.block[i] == blockno)
  104027:	8b 45 fc             	mov    -0x4(%ebp),%eax
  10402a:	83 c0 04             	add    $0x4,%eax
  10402d:	8b 04 85 a4 f4 10 00 	mov    0x10f4a4(,%eax,4),%eax
  104034:	39 45 08             	cmp    %eax,0x8(%ebp)
  104037:	75 07                	jne    104040 <log_has_block+0x28>
      return 1;
  104039:	b8 01 00 00 00       	mov    $0x1,%eax
  10403e:	eb 13                	jmp    104053 <log_has_block+0x3b>
  for (i = 0; i < log.lh.n; i++) {
  104040:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  104044:	a1 b0 f4 10 00       	mov    0x10f4b0,%eax
  104049:	39 45 fc             	cmp    %eax,-0x4(%ebp)
  10404c:	7c d9                	jl     104027 <log_has_block+0xf>
  }
  return 0;
  10404e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  104053:	c9                   	leave
  104054:	c3                   	ret

00104055 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
  104055:	55                   	push   %ebp
  104056:	89 e5                	mov    %esp,%ebp
  104058:	83 ec 18             	sub    $0x18,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
  10405b:	a1 b0 f4 10 00       	mov    0x10f4b0,%eax
  104060:	83 f8 1d             	cmp    $0x1d,%eax
  104063:	7f 12                	jg     104077 <log_write+0x22>
  104065:	8b 15 b0 f4 10 00    	mov    0x10f4b0,%edx
  10406b:	a1 a4 f4 10 00       	mov    0x10f4a4,%eax
  104070:	83 e8 01             	sub    $0x1,%eax
  104073:	39 c2                	cmp    %eax,%edx
  104075:	7c 0d                	jl     104084 <log_write+0x2f>
    panic("too big a transaction");
  104077:	83 ec 0c             	sub    $0xc,%esp
  10407a:	68 c8 45 10 00       	push   $0x1045c8
  10407f:	e8 2a c2 ff ff       	call   1002ae <panic>

  for (i = 0; i < log.lh.n; i++) {
  104084:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  10408b:	eb 1d                	jmp    1040aa <log_write+0x55>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
  10408d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  104090:	83 c0 04             	add    $0x4,%eax
  104093:	8b 04 85 a4 f4 10 00 	mov    0x10f4a4(,%eax,4),%eax
  10409a:	89 c2                	mov    %eax,%edx
  10409c:	8b 45 08             	mov    0x8(%ebp),%eax
  10409f:	8b 40 08             	mov    0x8(%eax),%eax
  1040a2:	39 c2                	cmp    %eax,%edx
  1040a4:	74 10                	je     1040b6 <log_write+0x61>
  for (i = 0; i < log.lh.n; i++) {
  1040a6:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  1040aa:	a1 b0 f4 10 00       	mov    0x10f4b0,%eax
  1040af:	39 45 f4             	cmp    %eax,-0xc(%ebp)
  1040b2:	7c d9                	jl     10408d <log_write+0x38>
  1040b4:	eb 01                	jmp    1040b7 <log_write+0x62>
      break;
  1040b6:	90                   	nop
  }

  if (i == log.lh.n) {
  1040b7:	a1 b0 f4 10 00       	mov    0x10f4b0,%eax
  1040bc:	39 45 f4             	cmp    %eax,-0xc(%ebp)
  1040bf:	0f 85 a4 00 00 00    	jne    104169 <log_write+0x114>
    struct buf *lbuf;

    // First write to this block in the transaction: assign log slot.
    log.lh.block[i] = b->blockno;
  1040c5:	8b 45 08             	mov    0x8(%ebp),%eax
  1040c8:	8b 40 08             	mov    0x8(%eax),%eax
  1040cb:	89 c2                	mov    %eax,%edx
  1040cd:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1040d0:	83 c0 04             	add    $0x4,%eax
  1040d3:	89 14 85 a4 f4 10 00 	mov    %edx,0x10f4a4(,%eax,4)

    // Old block image comes from bread/bread_wr snapshot without extra read.
    if (!b->undo_cached)
  1040da:	8b 45 08             	mov    0x8(%ebp),%eax
  1040dd:	8b 40 1c             	mov    0x1c(%eax),%eax
  1040e0:	85 c0                	test   %eax,%eax
  1040e2:	75 0d                	jne    1040f1 <log_write+0x9c>
      panic("log_write: missing undo cache");
  1040e4:	83 ec 0c             	sub    $0xc,%esp
  1040e7:	68 de 45 10 00       	push   $0x1045de
  1040ec:	e8 bd c1 ff ff       	call   1002ae <panic>

    // Eagerly persist old data into the log block.
    lbuf = bread(log.dev, log.start + i + 1);
  1040f1:	8b 15 a0 f4 10 00    	mov    0x10f4a0,%edx
  1040f7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1040fa:	01 d0                	add    %edx,%eax
  1040fc:	83 c0 01             	add    $0x1,%eax
  1040ff:	89 c2                	mov    %eax,%edx
  104101:	a1 ac f4 10 00       	mov    0x10f4ac,%eax
  104106:	83 ec 08             	sub    $0x8,%esp
  104109:	52                   	push   %edx
  10410a:	50                   	push   %eax
  10410b:	e8 d8 de ff ff       	call   101fe8 <bread>
  104110:	83 c4 10             	add    $0x10,%esp
  104113:	89 45 f0             	mov    %eax,-0x10(%ebp)
    memmove(lbuf->data, b->undo_data, BSIZE);
  104116:	8b 45 08             	mov    0x8(%ebp),%eax
  104119:	8d 50 20             	lea    0x20(%eax),%edx
  10411c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10411f:	05 20 02 00 00       	add    $0x220,%eax
  104124:	83 ec 04             	sub    $0x4,%esp
  104127:	68 00 02 00 00       	push   $0x200
  10412c:	52                   	push   %edx
  10412d:	50                   	push   %eax
  10412e:	e8 1f ce ff ff       	call   100f52 <memmove>
  104133:	83 c4 10             	add    $0x10,%esp
    bwrite(lbuf);
  104136:	83 ec 0c             	sub    $0xc,%esp
  104139:	ff 75 f0             	push   -0x10(%ebp)
  10413c:	e8 ee de ff ff       	call   10202f <bwrite>
  104141:	83 c4 10             	add    $0x10,%esp
    bump_log_writes();
  104144:	e8 c3 fb ff ff       	call   103d0c <bump_log_writes>
    brelse(lbuf);
  104149:	83 ec 0c             	sub    $0xc,%esp
  10414c:	ff 75 f0             	push   -0x10(%ebp)
  10414f:	e8 1a df ff ff       	call   10206e <brelse>
  104154:	83 c4 10             	add    $0x10,%esp

    // Publish the enlarged transaction eagerly in the on-disk header.
    log.lh.n++;
  104157:	a1 b0 f4 10 00       	mov    0x10f4b0,%eax
  10415c:	83 c0 01             	add    $0x1,%eax
  10415f:	a3 b0 f4 10 00       	mov    %eax,0x10f4b0
    write_head();
  104164:	e8 ab fd ff ff       	call   103f14 <write_head>
  }
  b->flags |= B_DIRTY; // prevent eviction
  104169:	8b 45 08             	mov    0x8(%ebp),%eax
  10416c:	8b 00                	mov    (%eax),%eax
  10416e:	83 c8 04             	or     $0x4,%eax
  104171:	89 c2                	mov    %eax,%edx
  104173:	8b 45 08             	mov    0x8(%ebp),%eax
  104176:	89 10                	mov    %edx,(%eax)
}
  104178:	90                   	nop
  104179:	c9                   	leave
  10417a:	c3                   	ret
