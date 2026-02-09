
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
  10000c:	bc 00 3d 10 00       	mov    $0x103d00,%esp

  # Jump to main(), and switch to executing at
  # high addresses. The indirect call is needed because
  # the assembler produces a PC-relative instruction
  # for a direct jump.
  mov $main, %eax
  100011:	b8 80 06 10 00       	mov    $0x100680,%eax
  jmp *%eax
  100016:	ff e0                	jmp    *%eax
  100018:	66 90                	xchg   %ax,%ax
  10001a:	66 90                	xchg   %ax,%ax
  10001c:	66 90                	xchg   %ax,%ax
  10001e:	66 90                	xchg   %ax,%ax

00100020 <printint>:
static void consputc(int);
static int panicked = 0;

static void
printint(int xx, int base, int sign)
{
  100020:	55                   	push   %ebp
  100021:	89 e5                	mov    %esp,%ebp
  100023:	57                   	push   %edi
  100024:	56                   	push   %esi
  100025:	53                   	push   %ebx
  100026:	89 d3                	mov    %edx,%ebx
  100028:	83 ec 2c             	sub    $0x2c,%esp
  static char digits[] = "0123456789abcdef";
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
  10002b:	85 c0                	test   %eax,%eax
  10002d:	79 05                	jns    100034 <printint+0x14>
  10002f:	83 e1 01             	and    $0x1,%ecx
  100032:	75 6c                	jne    1000a0 <printint+0x80>
    x = -xx;
  else
    x = xx;
  100034:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
  10003b:	89 c1                	mov    %eax,%ecx

  i = 0;
  10003d:	31 f6                	xor    %esi,%esi
  10003f:	90                   	nop
  do{
    buf[i++] = digits[x % base];
  100040:	89 c8                	mov    %ecx,%eax
  100042:	31 d2                	xor    %edx,%edx
  100044:	89 f7                	mov    %esi,%edi
  100046:	f7 f3                	div    %ebx
  100048:	8d 76 01             	lea    0x1(%esi),%esi
  10004b:	0f b6 92 f8 1d 10 00 	movzbl 0x101df8(%edx),%edx
  100052:	88 54 35 d7          	mov    %dl,-0x29(%ebp,%esi,1)
  }while((x /= base) != 0);
  100056:	89 ca                	mov    %ecx,%edx
  100058:	89 c1                	mov    %eax,%ecx
  10005a:	39 da                	cmp    %ebx,%edx
  10005c:	73 e2                	jae    100040 <printint+0x20>

  if(sign)
  10005e:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  100061:	85 c0                	test   %eax,%eax
  100063:	74 07                	je     10006c <printint+0x4c>
    buf[i++] = '-';
  100065:	c6 44 35 d8 2d       	movb   $0x2d,-0x28(%ebp,%esi,1)

  while(--i >= 0)
  10006a:	89 f7                	mov    %esi,%edi
  10006c:	8d 5d d8             	lea    -0x28(%ebp),%ebx
  10006f:	01 df                	add    %ebx,%edi
  100071:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    consputc(buf[i]);
  100078:	0f be 07             	movsbl (%edi),%eax
consputc(int c)
{
  if(c == BACKSPACE){
    uartputc('\b'); uartputc(' '); uartputc('\b');
  } else
    uartputc(c);
  10007b:	83 ec 0c             	sub    $0xc,%esp
  10007e:	50                   	push   %eax
  10007f:	e8 7c 0d 00 00       	call   100e00 <uartputc>
  while(--i >= 0)
  100084:	89 f8                	mov    %edi,%eax
  100086:	83 c4 10             	add    $0x10,%esp
  100089:	83 ef 01             	sub    $0x1,%edi
  10008c:	39 d8                	cmp    %ebx,%eax
  10008e:	75 e8                	jne    100078 <printint+0x58>
}
  100090:	8d 65 f4             	lea    -0xc(%ebp),%esp
  100093:	5b                   	pop    %ebx
  100094:	5e                   	pop    %esi
  100095:	5f                   	pop    %edi
  100096:	5d                   	pop    %ebp
  100097:	c3                   	ret
  100098:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  10009f:	00 
    x = -xx;
  1000a0:	f7 d8                	neg    %eax
  if(sign && (sign = xx < 0))
  1000a2:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%ebp)
    x = -xx;
  1000a9:	89 c1                	mov    %eax,%ecx
  1000ab:	eb 90                	jmp    10003d <printint+0x1d>
  1000ad:	8d 76 00             	lea    0x0(%esi),%esi

001000b0 <cprintf>:
{
  1000b0:	55                   	push   %ebp
  1000b1:	89 e5                	mov    %esp,%ebp
  1000b3:	57                   	push   %edi
  1000b4:	56                   	push   %esi
  1000b5:	53                   	push   %ebx
  1000b6:	83 ec 1c             	sub    $0x1c,%esp
  if (fmt == 0)
  1000b9:	8b 75 08             	mov    0x8(%ebp),%esi
  1000bc:	85 f6                	test   %esi,%esi
  1000be:	74 7d                	je     10013d <cprintf+0x8d>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
  1000c0:	0f b6 06             	movzbl (%esi),%eax
  1000c3:	85 c0                	test   %eax,%eax
  1000c5:	74 76                	je     10013d <cprintf+0x8d>
  argp = (uint*)(void*)(&fmt + 1);
  1000c7:	8d 4d 0c             	lea    0xc(%ebp),%ecx
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
  1000ca:	31 db                	xor    %ebx,%ebx
  1000cc:	eb 4d                	jmp    10011b <cprintf+0x6b>
  1000ce:	66 90                	xchg   %ax,%ax
    c = fmt[++i] & 0xff;
  1000d0:	83 c3 01             	add    $0x1,%ebx
  1000d3:	0f b6 3c 1e          	movzbl (%esi,%ebx,1),%edi
    if(c == 0)
  1000d7:	85 ff                	test   %edi,%edi
  1000d9:	74 62                	je     10013d <cprintf+0x8d>
    switch(c){
  1000db:	83 ff 70             	cmp    $0x70,%edi
  1000de:	0f 84 ec 00 00 00    	je     1001d0 <cprintf+0x120>
  1000e4:	7f 62                	jg     100148 <cprintf+0x98>
  1000e6:	83 ff 25             	cmp    $0x25,%edi
  1000e9:	0f 84 c1 00 00 00    	je     1001b0 <cprintf+0x100>
  1000ef:	83 ff 64             	cmp    $0x64,%edi
  1000f2:	75 5e                	jne    100152 <cprintf+0xa2>
      printint(*argp++, 10, 1);
  1000f4:	8b 01                	mov    (%ecx),%eax
  1000f6:	8d 79 04             	lea    0x4(%ecx),%edi
  1000f9:	ba 0a 00 00 00       	mov    $0xa,%edx
  1000fe:	b9 01 00 00 00       	mov    $0x1,%ecx
  100103:	e8 18 ff ff ff       	call   100020 <printint>
  100108:	89 f9                	mov    %edi,%ecx
  10010a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
  100110:	83 c3 01             	add    $0x1,%ebx
  100113:	0f b6 04 1e          	movzbl (%esi,%ebx,1),%eax
  100117:	85 c0                	test   %eax,%eax
  100119:	74 22                	je     10013d <cprintf+0x8d>
    if(c != '%'){
  10011b:	83 f8 25             	cmp    $0x25,%eax
  10011e:	74 b0                	je     1000d0 <cprintf+0x20>
    uartputc(c);
  100120:	83 ec 0c             	sub    $0xc,%esp
  100123:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
  100126:	83 c3 01             	add    $0x1,%ebx
    uartputc(c);
  100129:	50                   	push   %eax
  10012a:	e8 d1 0c 00 00       	call   100e00 <uartputc>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
  10012f:	0f b6 04 1e          	movzbl (%esi,%ebx,1),%eax
      continue;
  100133:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
  100136:	83 c4 10             	add    $0x10,%esp
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
  100139:	85 c0                	test   %eax,%eax
  10013b:	75 de                	jne    10011b <cprintf+0x6b>
}
  10013d:	8d 65 f4             	lea    -0xc(%ebp),%esp
  100140:	5b                   	pop    %ebx
  100141:	5e                   	pop    %esi
  100142:	5f                   	pop    %edi
  100143:	5d                   	pop    %ebp
  100144:	c3                   	ret
  100145:	8d 76 00             	lea    0x0(%esi),%esi
    switch(c){
  100148:	83 ff 73             	cmp    $0x73,%edi
  10014b:	74 23                	je     100170 <cprintf+0xc0>
  10014d:	83 ff 78             	cmp    $0x78,%edi
  100150:	74 7e                	je     1001d0 <cprintf+0x120>
    uartputc(c);
  100152:	83 ec 0c             	sub    $0xc,%esp
  100155:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
  100158:	6a 25                	push   $0x25
  10015a:	e8 a1 0c 00 00       	call   100e00 <uartputc>
  10015f:	89 3c 24             	mov    %edi,(%esp)
  100162:	e8 99 0c 00 00       	call   100e00 <uartputc>
  100167:	83 c4 10             	add    $0x10,%esp
  10016a:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
  10016d:	eb a1                	jmp    100110 <cprintf+0x60>
  10016f:	90                   	nop
      if((s = (char*)*argp++) == 0)
  100170:	8b 11                	mov    (%ecx),%edx
  100172:	8d 41 04             	lea    0x4(%ecx),%eax
  100175:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  100178:	85 d2                	test   %edx,%edx
  10017a:	74 74                	je     1001f0 <cprintf+0x140>
      for(; *s; s++)
  10017c:	0f be 02             	movsbl (%edx),%eax
      if((s = (char*)*argp++) == 0)
  10017f:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
  100182:	89 d7                	mov    %edx,%edi
      for(; *s; s++)
  100184:	84 c0                	test   %al,%al
  100186:	74 88                	je     100110 <cprintf+0x60>
  100188:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  10018f:	00 
    uartputc(c);
  100190:	83 ec 0c             	sub    $0xc,%esp
      for(; *s; s++)
  100193:	83 c7 01             	add    $0x1,%edi
    uartputc(c);
  100196:	50                   	push   %eax
  100197:	e8 64 0c 00 00       	call   100e00 <uartputc>
      for(; *s; s++)
  10019c:	0f be 07             	movsbl (%edi),%eax
  10019f:	83 c4 10             	add    $0x10,%esp
  1001a2:	84 c0                	test   %al,%al
  1001a4:	75 ea                	jne    100190 <cprintf+0xe0>
  1001a6:	eb c2                	jmp    10016a <cprintf+0xba>
  1001a8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  1001af:	00 
    uartputc(c);
  1001b0:	83 ec 0c             	sub    $0xc,%esp
  1001b3:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
  1001b6:	6a 25                	push   $0x25
  1001b8:	e8 43 0c 00 00       	call   100e00 <uartputc>
}
  1001bd:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
  1001c0:	83 c4 10             	add    $0x10,%esp
  1001c3:	e9 48 ff ff ff       	jmp    100110 <cprintf+0x60>
  1001c8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  1001cf:	00 
      printint(*argp++, 16, 0);
  1001d0:	8b 01                	mov    (%ecx),%eax
  1001d2:	8d 79 04             	lea    0x4(%ecx),%edi
  1001d5:	ba 10 00 00 00       	mov    $0x10,%edx
  1001da:	31 c9                	xor    %ecx,%ecx
  1001dc:	e8 3f fe ff ff       	call   100020 <printint>
  1001e1:	89 f9                	mov    %edi,%ecx
      break;
  1001e3:	e9 28 ff ff ff       	jmp    100110 <cprintf+0x60>
  1001e8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  1001ef:	00 
  1001f0:	b8 28 00 00 00       	mov    $0x28,%eax
        s = "(null)";
  1001f5:	bf 20 1d 10 00       	mov    $0x101d20,%edi
  1001fa:	eb 94                	jmp    100190 <cprintf+0xe0>
  1001fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00100200 <halt>:
{
  100200:	55                   	push   %ebp
  100201:	89 e5                	mov    %esp,%ebp
  100203:	83 ec 10             	sub    $0x10,%esp
  cprintf("Bye COL%d!\n\0", 331);
  100206:	68 4b 01 00 00       	push   $0x14b
  10020b:	68 e8 1d 10 00       	push   $0x101de8
  100210:	e8 9b fe ff ff       	call   1000b0 <cprintf>
}

static inline void
outw(ushort port, ushort data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  100215:	b8 00 20 00 00       	mov    $0x2000,%eax
  10021a:	ba 02 06 00 00       	mov    $0x602,%edx
  10021f:	66 ef                	out    %ax,(%dx)
  100221:	ba 02 b0 ff ff       	mov    $0xffffb002,%edx
  100226:	66 ef                	out    %ax,(%dx)
}
  100228:	83 c4 10             	add    $0x10,%esp
  for(;;);
  10022b:	eb fe                	jmp    10022b <halt+0x2b>
  10022d:	8d 76 00             	lea    0x0(%esi),%esi

00100230 <panic>:
{
  100230:	55                   	push   %ebp
  100231:	89 e5                	mov    %esp,%ebp
  100233:	56                   	push   %esi
  100234:	53                   	push   %ebx
  100235:	83 ec 30             	sub    $0x30,%esp
}

static inline void
cli(void)
{
  asm volatile("cli");
  100238:	fa                   	cli
  cprintf("lapicid %d: panic: ", lapicid());
  100239:	e8 f2 03 00 00       	call   100630 <lapicid>
  10023e:	83 ec 08             	sub    $0x8,%esp
  getcallerpcs(&s, pcs);
  100241:	8d 5d d0             	lea    -0x30(%ebp),%ebx
  100244:	8d 75 f8             	lea    -0x8(%ebp),%esi
  cprintf("lapicid %d: panic: ", lapicid());
  100247:	50                   	push   %eax
  100248:	68 27 1d 10 00       	push   $0x101d27
  10024d:	e8 5e fe ff ff       	call   1000b0 <cprintf>
  cprintf(s);
  100252:	58                   	pop    %eax
  100253:	ff 75 08             	push   0x8(%ebp)
  100256:	e8 55 fe ff ff       	call   1000b0 <cprintf>
  cprintf("\n");
  10025b:	c7 04 24 72 1d 10 00 	movl   $0x101d72,(%esp)
  100262:	e8 49 fe ff ff       	call   1000b0 <cprintf>
  getcallerpcs(&s, pcs);
  100267:	8d 45 08             	lea    0x8(%ebp),%eax
  10026a:	5a                   	pop    %edx
  10026b:	59                   	pop    %ecx
  10026c:	53                   	push   %ebx
  10026d:	50                   	push   %eax
  10026e:	e8 7d 0e 00 00       	call   1010f0 <getcallerpcs>
  for(i=0; i<10; i++)
  100273:	83 c4 10             	add    $0x10,%esp
  100276:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  10027d:	00 
  10027e:	66 90                	xchg   %ax,%ax
    cprintf(" %p", pcs[i]);
  100280:	83 ec 08             	sub    $0x8,%esp
  100283:	ff 33                	push   (%ebx)
  for(i=0; i<10; i++)
  100285:	83 c3 04             	add    $0x4,%ebx
    cprintf(" %p", pcs[i]);
  100288:	68 3b 1d 10 00       	push   $0x101d3b
  10028d:	e8 1e fe ff ff       	call   1000b0 <cprintf>
  for(i=0; i<10; i++)
  100292:	83 c4 10             	add    $0x10,%esp
  100295:	39 f3                	cmp    %esi,%ebx
  100297:	75 e7                	jne    100280 <panic+0x50>
  halt();
  100299:	e8 62 ff ff ff       	call   100200 <halt>
  10029e:	66 90                	xchg   %ax,%ax

001002a0 <consoleintr>:

#define C(x)  ((x)-'@')  // Control-x

void
consoleintr(int (*getc)(void))
{
  1002a0:	55                   	push   %ebp
  1002a1:	89 e5                	mov    %esp,%ebp
  1002a3:	53                   	push   %ebx
  1002a4:	83 ec 14             	sub    $0x14,%esp
  1002a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int c;

  while((c = getc()) >= 0){
  1002aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  1002b0:	ff d3                	call   *%ebx
  1002b2:	85 c0                	test   %eax,%eax
  1002b4:	0f 88 9b 00 00 00    	js     100355 <consoleintr+0xb5>
    switch(c){
  1002ba:	83 f8 15             	cmp    $0x15,%eax
  1002bd:	0f 84 9d 00 00 00    	je     100360 <consoleintr+0xc0>
  1002c3:	83 f8 7f             	cmp    $0x7f,%eax
  1002c6:	0f 84 04 01 00 00    	je     1003d0 <consoleintr+0x130>
  1002cc:	83 f8 08             	cmp    $0x8,%eax
  1002cf:	0f 84 fb 00 00 00    	je     1003d0 <consoleintr+0x130>
        input.e--;
        consputc(BACKSPACE);
      }
      break;
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
  1002d5:	85 c0                	test   %eax,%eax
  1002d7:	74 d7                	je     1002b0 <consoleintr+0x10>
  1002d9:	8b 15 88 24 10 00    	mov    0x102488,%edx
  1002df:	89 d1                	mov    %edx,%ecx
  1002e1:	2b 0d 80 24 10 00    	sub    0x102480,%ecx
  1002e7:	83 f9 7f             	cmp    $0x7f,%ecx
  1002ea:	77 c4                	ja     1002b0 <consoleintr+0x10>
        c = (c == '\r') ? '\n' : c;
        input.buf[input.e++ % INPUT_BUF] = c;
  1002ec:	8d 4a 01             	lea    0x1(%edx),%ecx
  1002ef:	83 e2 7f             	and    $0x7f,%edx
  1002f2:	89 0d 88 24 10 00    	mov    %ecx,0x102488
        c = (c == '\r') ? '\n' : c;
  1002f8:	83 f8 0d             	cmp    $0xd,%eax
  1002fb:	0f 84 12 01 00 00    	je     100413 <consoleintr+0x173>
        input.buf[input.e++ % INPUT_BUF] = c;
  100301:	88 82 00 24 10 00    	mov    %al,0x102400(%edx)
  if(c == BACKSPACE){
  100307:	3d 00 01 00 00       	cmp    $0x100,%eax
  10030c:	0f 85 24 01 00 00    	jne    100436 <consoleintr+0x196>
    uartputc('\b'); uartputc(' '); uartputc('\b');
  100312:	83 ec 0c             	sub    $0xc,%esp
  100315:	6a 08                	push   $0x8
  100317:	e8 e4 0a 00 00       	call   100e00 <uartputc>
  10031c:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
  100323:	e8 d8 0a 00 00       	call   100e00 <uartputc>
  100328:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
  10032f:	e8 cc 0a 00 00       	call   100e00 <uartputc>
  100334:	83 c4 10             	add    $0x10,%esp
        consputc(c);
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
  100337:	a1 80 24 10 00       	mov    0x102480,%eax
  10033c:	83 e8 80             	sub    $0xffffff80,%eax
  10033f:	39 05 88 24 10 00    	cmp    %eax,0x102488
  100345:	0f 84 e1 00 00 00    	je     10042c <consoleintr+0x18c>
  while((c = getc()) >= 0){
  10034b:	ff d3                	call   *%ebx
  10034d:	85 c0                	test   %eax,%eax
  10034f:	0f 89 65 ff ff ff    	jns    1002ba <consoleintr+0x1a>
        }
      }
      break;
    }
  }
  100355:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  100358:	c9                   	leave
  100359:	c3                   	ret
  10035a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      while(input.e != input.w &&
  100360:	a1 88 24 10 00       	mov    0x102488,%eax
  100365:	39 05 84 24 10 00    	cmp    %eax,0x102484
  10036b:	75 46                	jne    1003b3 <consoleintr+0x113>
  10036d:	e9 3e ff ff ff       	jmp    1002b0 <consoleintr+0x10>
  100372:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    uartputc('\b'); uartputc(' '); uartputc('\b');
  100378:	83 ec 0c             	sub    $0xc,%esp
        input.e--;
  10037b:	a3 88 24 10 00       	mov    %eax,0x102488
    uartputc('\b'); uartputc(' '); uartputc('\b');
  100380:	6a 08                	push   $0x8
  100382:	e8 79 0a 00 00       	call   100e00 <uartputc>
  100387:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
  10038e:	e8 6d 0a 00 00       	call   100e00 <uartputc>
  100393:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
  10039a:	e8 61 0a 00 00       	call   100e00 <uartputc>
      while(input.e != input.w &&
  10039f:	a1 88 24 10 00       	mov    0x102488,%eax
  1003a4:	83 c4 10             	add    $0x10,%esp
  1003a7:	3b 05 84 24 10 00    	cmp    0x102484,%eax
  1003ad:	0f 84 fd fe ff ff    	je     1002b0 <consoleintr+0x10>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
  1003b3:	83 e8 01             	sub    $0x1,%eax
  1003b6:	89 c2                	mov    %eax,%edx
  1003b8:	83 e2 7f             	and    $0x7f,%edx
      while(input.e != input.w &&
  1003bb:	80 ba 00 24 10 00 0a 	cmpb   $0xa,0x102400(%edx)
  1003c2:	75 b4                	jne    100378 <consoleintr+0xd8>
  1003c4:	e9 e7 fe ff ff       	jmp    1002b0 <consoleintr+0x10>
  1003c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(input.e != input.w){
  1003d0:	a1 88 24 10 00       	mov    0x102488,%eax
  1003d5:	3b 05 84 24 10 00    	cmp    0x102484,%eax
  1003db:	0f 84 cf fe ff ff    	je     1002b0 <consoleintr+0x10>
    uartputc('\b'); uartputc(' '); uartputc('\b');
  1003e1:	83 ec 0c             	sub    $0xc,%esp
        input.e--;
  1003e4:	83 e8 01             	sub    $0x1,%eax
    uartputc('\b'); uartputc(' '); uartputc('\b');
  1003e7:	6a 08                	push   $0x8
        input.e--;
  1003e9:	a3 88 24 10 00       	mov    %eax,0x102488
    uartputc('\b'); uartputc(' '); uartputc('\b');
  1003ee:	e8 0d 0a 00 00       	call   100e00 <uartputc>
  1003f3:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
  1003fa:	e8 01 0a 00 00       	call   100e00 <uartputc>
  1003ff:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
  100406:	e8 f5 09 00 00       	call   100e00 <uartputc>
  10040b:	83 c4 10             	add    $0x10,%esp
  10040e:	e9 9d fe ff ff       	jmp    1002b0 <consoleintr+0x10>
    uartputc(c);
  100413:	83 ec 0c             	sub    $0xc,%esp
        input.buf[input.e++ % INPUT_BUF] = c;
  100416:	c6 82 00 24 10 00 0a 	movb   $0xa,0x102400(%edx)
    uartputc(c);
  10041d:	6a 0a                	push   $0xa
  10041f:	e8 dc 09 00 00       	call   100e00 <uartputc>
          input.w = input.e;
  100424:	a1 88 24 10 00       	mov    0x102488,%eax
  100429:	83 c4 10             	add    $0x10,%esp
  10042c:	a3 84 24 10 00       	mov    %eax,0x102484
  100431:	e9 7a fe ff ff       	jmp    1002b0 <consoleintr+0x10>
    uartputc(c);
  100436:	83 ec 0c             	sub    $0xc,%esp
  100439:	50                   	push   %eax
  10043a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  10043d:	e8 be 09 00 00       	call   100e00 <uartputc>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
  100442:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100445:	83 c4 10             	add    $0x10,%esp
  100448:	83 f8 0a             	cmp    $0xa,%eax
  10044b:	74 09                	je     100456 <consoleintr+0x1b6>
  10044d:	83 f8 04             	cmp    $0x4,%eax
  100450:	0f 85 e1 fe ff ff    	jne    100337 <consoleintr+0x97>
          input.w = input.e;
  100456:	a1 88 24 10 00       	mov    0x102488,%eax
  10045b:	eb cf                	jmp    10042c <consoleintr+0x18c>
  10045d:	66 90                	xchg   %ax,%ax
  10045f:	90                   	nop

00100460 <ioapicinit>:
  ioapic->data = data;
}

void
ioapicinit(void)
{
  100460:	55                   	push   %ebp
  100461:	89 e5                	mov    %esp,%ebp
  100463:	56                   	push   %esi
  100464:	53                   	push   %ebx
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
  100465:	c7 05 8c 24 10 00 00 	movl   $0xfec00000,0x10248c
  10046c:	00 c0 fe 
  ioapic->reg = reg;
  10046f:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
  100476:	00 00 00 
  return ioapic->data;
  100479:	8b 15 8c 24 10 00    	mov    0x10248c,%edx
  10047f:	8b 72 10             	mov    0x10(%edx),%esi
  ioapic->reg = reg;
  100482:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
  return ioapic->data;
  100488:	8b 1d 8c 24 10 00    	mov    0x10248c,%ebx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
  10048e:	0f b6 15 c0 24 10 00 	movzbl 0x1024c0,%edx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  100495:	c1 ee 10             	shr    $0x10,%esi
  100498:	89 f0                	mov    %esi,%eax
  10049a:	0f b6 f0             	movzbl %al,%esi
  return ioapic->data;
  10049d:	8b 43 10             	mov    0x10(%ebx),%eax
  id = ioapicread(REG_ID) >> 24;
  1004a0:	c1 e8 18             	shr    $0x18,%eax
  if(id != ioapicid)
  1004a3:	39 c2                	cmp    %eax,%edx
  1004a5:	74 16                	je     1004bd <ioapicinit+0x5d>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
  1004a7:	83 ec 0c             	sub    $0xc,%esp
  1004aa:	68 0c 1e 10 00       	push   $0x101e0c
  1004af:	e8 fc fb ff ff       	call   1000b0 <cprintf>
  ioapic->reg = reg;
  1004b4:	8b 1d 8c 24 10 00    	mov    0x10248c,%ebx
  1004ba:	83 c4 10             	add    $0x10,%esp
{
  1004bd:	ba 10 00 00 00       	mov    $0x10,%edx
  1004c2:	31 c0                	xor    %eax,%eax
  1004c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  ioapic->reg = reg;
  1004c8:	89 13                	mov    %edx,(%ebx)
  1004ca:	8d 48 20             	lea    0x20(%eax),%ecx
  ioapic->data = data;
  1004cd:	8b 1d 8c 24 10 00    	mov    0x10248c,%ebx

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
  1004d3:	83 c0 01             	add    $0x1,%eax
  1004d6:	81 c9 00 00 01 00    	or     $0x10000,%ecx
  ioapic->data = data;
  1004dc:	89 4b 10             	mov    %ecx,0x10(%ebx)
  ioapic->reg = reg;
  1004df:	8d 4a 01             	lea    0x1(%edx),%ecx
  for(i = 0; i <= maxintr; i++){
  1004e2:	83 c2 02             	add    $0x2,%edx
  ioapic->reg = reg;
  1004e5:	89 0b                	mov    %ecx,(%ebx)
  ioapic->data = data;
  1004e7:	8b 1d 8c 24 10 00    	mov    0x10248c,%ebx
  1004ed:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
  for(i = 0; i <= maxintr; i++){
  1004f4:	39 c6                	cmp    %eax,%esi
  1004f6:	7d d0                	jge    1004c8 <ioapicinit+0x68>
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
  1004f8:	8d 65 f8             	lea    -0x8(%ebp),%esp
  1004fb:	5b                   	pop    %ebx
  1004fc:	5e                   	pop    %esi
  1004fd:	5d                   	pop    %ebp
  1004fe:	c3                   	ret
  1004ff:	90                   	nop

00100500 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
  100500:	55                   	push   %ebp
  ioapic->reg = reg;
  100501:	8b 0d 8c 24 10 00    	mov    0x10248c,%ecx
{
  100507:	89 e5                	mov    %esp,%ebp
  100509:	8b 45 08             	mov    0x8(%ebp),%eax
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
  10050c:	8d 50 20             	lea    0x20(%eax),%edx
  10050f:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
  ioapic->reg = reg;
  100513:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
  100515:	8b 0d 8c 24 10 00    	mov    0x10248c,%ecx
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
  10051b:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
  10051e:	89 51 10             	mov    %edx,0x10(%ecx)
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
  100521:	8b 55 0c             	mov    0xc(%ebp),%edx
  ioapic->reg = reg;
  100524:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
  100526:	a1 8c 24 10 00       	mov    0x10248c,%eax
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
  10052b:	c1 e2 18             	shl    $0x18,%edx
  ioapic->data = data;
  10052e:	89 50 10             	mov    %edx,0x10(%eax)
}
  100531:	5d                   	pop    %ebp
  100532:	c3                   	ret
  100533:	66 90                	xchg   %ax,%ax
  100535:	66 90                	xchg   %ax,%ax
  100537:	66 90                	xchg   %ax,%ax
  100539:	66 90                	xchg   %ax,%ax
  10053b:	66 90                	xchg   %ax,%ax
  10053d:	66 90                	xchg   %ax,%ax
  10053f:	90                   	nop

00100540 <lapicinit>:
}

void
lapicinit(void)
{
  if(!lapic)
  100540:	a1 90 24 10 00       	mov    0x102490,%eax
  100545:	85 c0                	test   %eax,%eax
  100547:	0f 84 c3 00 00 00    	je     100610 <lapicinit+0xd0>
  lapic[index] = value;
  10054d:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
  100554:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
  100557:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
  10055a:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
  100561:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
  100564:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
  100567:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
  10056e:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
  100571:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
  100574:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
  10057b:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
  10057e:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
  100581:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
  100588:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
  10058b:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
  10058e:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
  100595:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
  100598:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
  10059b:	8b 50 30             	mov    0x30(%eax),%edx
  10059e:	81 e2 00 00 fc 00    	and    $0xfc0000,%edx
  1005a4:	75 72                	jne    100618 <lapicinit+0xd8>
  lapic[index] = value;
  1005a6:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
  1005ad:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
  1005b0:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
  1005b3:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
  1005ba:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
  1005bd:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
  1005c0:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
  1005c7:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
  1005ca:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
  1005cd:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
  1005d4:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
  1005d7:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
  1005da:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
  1005e1:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
  1005e4:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
  1005e7:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
  1005ee:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
  1005f1:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
  1005f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  1005f8:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
  1005fe:	80 e6 10             	and    $0x10,%dh
  100601:	75 f5                	jne    1005f8 <lapicinit+0xb8>
  lapic[index] = value;
  100603:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
  10060a:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
  10060d:	8b 40 20             	mov    0x20(%eax),%eax
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
  100610:	c3                   	ret
  100611:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  lapic[index] = value;
  100618:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
  10061f:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
  100622:	8b 50 20             	mov    0x20(%eax),%edx
}
  100625:	e9 7c ff ff ff       	jmp    1005a6 <lapicinit+0x66>
  10062a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00100630 <lapicid>:

int
lapicid(void)
{
  if (!lapic)
  100630:	a1 90 24 10 00       	mov    0x102490,%eax
  100635:	85 c0                	test   %eax,%eax
  100637:	74 07                	je     100640 <lapicid+0x10>
    return 0;
  return lapic[ID] >> 24;
  100639:	8b 40 20             	mov    0x20(%eax),%eax
  10063c:	c1 e8 18             	shr    $0x18,%eax
  10063f:	c3                   	ret
    return 0;
  100640:	31 c0                	xor    %eax,%eax
}
  100642:	c3                   	ret
  100643:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  10064a:	00 
  10064b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

00100650 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
  if(lapic)
  100650:	a1 90 24 10 00       	mov    0x102490,%eax
  100655:	85 c0                	test   %eax,%eax
  100657:	74 0d                	je     100666 <lapiceoi+0x16>
  lapic[index] = value;
  100659:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
  100660:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
  100663:	8b 40 20             	mov    0x20(%eax),%eax
    lapicw(EOI, 0);
}
  100666:	c3                   	ret
  100667:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  10066e:	00 
  10066f:	90                   	nop

00100670 <microdelay>:
// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
  100670:	c3                   	ret
  100671:	66 90                	xchg   %ax,%ax
  100673:	66 90                	xchg   %ax,%ax
  100675:	66 90                	xchg   %ax,%ax
  100677:	66 90                	xchg   %ax,%ax
  100679:	66 90                	xchg   %ax,%ax
  10067b:	66 90                	xchg   %ax,%ax
  10067d:	66 90                	xchg   %ax,%ax
  10067f:	90                   	nop

00100680 <main>:
// Bootstrap processor starts running C code here.
// Allocate a real stack and switch to it, first
// doing some setup required for memory allocator to work.
int
main(void)
{
  100680:	55                   	push   %ebp
  100681:	89 e5                	mov    %esp,%ebp
  100683:	83 e4 f0             	and    $0xfffffff0,%esp
  mpinit();        // detect other processors
  100686:	e8 65 04 00 00       	call   100af0 <mpinit>
  lapicinit();     // interrupt controller
  10068b:	e8 b0 fe ff ff       	call   100540 <lapicinit>
  picinit();       // disable pic
  100690:	e8 2b 06 00 00       	call   100cc0 <picinit>
  ioapicinit();    // another interrupt controller
  100695:	e8 c6 fd ff ff       	call   100460 <ioapicinit>
  uartinit();      // serial port
  10069a:	e8 71 06 00 00       	call   100d10 <uartinit>

  // Initialize the PS/2 mouse before enabling interrupts so that
  // IRQ12 is routed and the device is ready to report events.
  mouseinit();     // mouse initialization
  10069f:	e8 8c 00 00 00       	call   100730 <mouseinit>

  tvinit();        // trap vectors
  1006a4:	e8 d7 0a 00 00       	call   101180 <tvinit>
  idtinit();       // load idt register
  1006a9:	e8 12 0b 00 00       	call   1011c0 <idtinit>


static inline void
sti(void)
{
  asm volatile("sti");
  1006ae:	fb                   	sti
  1006af:	90                   	nop
}

static inline void
wfi(void)
{
  asm volatile("hlt");
  1006b0:	f4                   	hlt
  sti();
  for(;;)
  1006b1:	eb fd                	jmp    1006b0 <main+0x30>
  1006b3:	66 90                	xchg   %ax,%ax
  1006b5:	66 90                	xchg   %ax,%ax
  1006b7:	66 90                	xchg   %ax,%ax
  1006b9:	66 90                	xchg   %ax,%ax
  1006bb:	66 90                	xchg   %ax,%ax
  1006bd:	66 90                	xchg   %ax,%ax
  1006bf:	90                   	nop

001006c0 <mousewait_send>:
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
  1006c0:	ba 64 00 00 00       	mov    $0x64,%edx
  1006c5:	8d 76 00             	lea    0x0(%esi),%esi
  1006c8:	ec                   	in     (%dx),%al

    // Keep reading status register (port 0x64)
    // Loop while bit 1 is SET (value & 0x02 != 0)
    // Exit when bit 1 is CLEAR (value & 0x02 == 0)

    while(inb(MSSTATP) & 0x02);
  1006c9:	a8 02                	test   $0x2,%al
  1006cb:	75 fb                	jne    1006c8 <mousewait_send+0x8>
    return;
}
  1006cd:	c3                   	ret
  1006ce:	66 90                	xchg   %ax,%ax

001006d0 <mousewait_recv>:
  1006d0:	ba 64 00 00 00       	mov    $0x64,%edx
  1006d5:	8d 76 00             	lea    0x0(%esi),%esi
  1006d8:	ec                   	in     (%dx),%al
    // Implement your code here
    // Keep reading status register (port 0x64)
    // Loop while bit 0 is CLEAR (value & 0x01 == 0)
    // Exit when bit 0 is SET (value & 0x01 != 0)

    while((inb(MSSTATP) & 0x01) == 0);
  1006d9:	a8 01                	test   $0x1,%al
  1006db:	74 fb                	je     1006d8 <mousewait_recv+0x8>
    return;
}
  1006dd:	c3                   	ret
  1006de:	66 90                	xchg   %ax,%ax

001006e0 <mousecmd>:

// Send a one-byte command to the mouse controller, and wait for it
// to be properly acknowledged
void 
mousecmd(uchar cmd) 
{
  1006e0:	55                   	push   %ebp
  1006e1:	ba 64 00 00 00       	mov    $0x64,%edx
  1006e6:	89 e5                	mov    %esp,%ebp
  1006e8:	0f b6 4d 08          	movzbl 0x8(%ebp),%ecx
  1006ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  1006f0:	ec                   	in     (%dx),%al
    while(inb(MSSTATP) & 0x02);
  1006f1:	a8 02                	test   $0x2,%al
  1006f3:	75 fb                	jne    1006f0 <mousecmd+0x10>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  1006f5:	b8 d4 ff ff ff       	mov    $0xffffffd4,%eax
  1006fa:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
  1006fb:	ba 64 00 00 00       	mov    $0x64,%edx
  100700:	ec                   	in     (%dx),%al
  100701:	a8 02                	test   $0x2,%al
  100703:	75 fb                	jne    100700 <mousecmd+0x20>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  100705:	ba 60 00 00 00       	mov    $0x60,%edx
  10070a:	89 c8                	mov    %ecx,%eax
  10070c:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
  10070d:	ba 64 00 00 00       	mov    $0x64,%edx
  100712:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  100718:	ec                   	in     (%dx),%al
    while((inb(MSSTATP) & 0x01) == 0);
  100719:	a8 01                	test   $0x1,%al
  10071b:	74 fb                	je     100718 <mousecmd+0x38>
  10071d:	ba 60 00 00 00       	mov    $0x60,%edx
  100722:	ec                   	in     (%dx),%al
    // Ack Check Maybe ??
    // if(ack != 0xFA)
    //     cprintf("mouse: command 0x%x not acknowledged (got 0x%x)\n", cmd, ack);
    (void)ack; // prevent unused variable warning   
    return;
}
  100723:	5d                   	pop    %ebp
  100724:	c3                   	ret
  100725:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  10072c:	00 
  10072d:	8d 76 00             	lea    0x0(%esi),%esi

00100730 <mouseinit>:

void
mouseinit(void)
{
  100730:	55                   	push   %ebp
  100731:	ba 64 00 00 00       	mov    $0x64,%edx
  100736:	89 e5                	mov    %esp,%ebp
  100738:	83 ec 08             	sub    $0x8,%esp
  10073b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  100740:	ec                   	in     (%dx),%al
    while(inb(MSSTATP) & 0x02);
  100741:	a8 02                	test   $0x2,%al
  100743:	75 fb                	jne    100740 <mouseinit+0x10>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  100745:	b8 a8 ff ff ff       	mov    $0xffffffa8,%eax
  10074a:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
  10074b:	ba 64 00 00 00       	mov    $0x64,%edx
  100750:	ec                   	in     (%dx),%al
  100751:	a8 02                	test   $0x2,%al
  100753:	75 fb                	jne    100750 <mouseinit+0x20>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  100755:	b8 20 00 00 00       	mov    $0x20,%eax
  10075a:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
  10075b:	ba 64 00 00 00       	mov    $0x64,%edx
  100760:	ec                   	in     (%dx),%al
    while((inb(MSSTATP) & 0x01) == 0);
  100761:	a8 01                	test   $0x1,%al
  100763:	74 fb                	je     100760 <mouseinit+0x30>
  100765:	ba 60 00 00 00       	mov    $0x60,%edx
  10076a:	ec                   	in     (%dx),%al
    mousewait_send();
    outb(MSSTATP, 0x20);      // command: read status byte
    
    mousewait_recv();
    status = inb(MSDATAP);
    status |= 0x02;           // set bit 1 to enable IRQ12
  10076b:	83 c8 02             	or     $0x2,%eax
  10076e:	ba 64 00 00 00       	mov    $0x64,%edx
  100773:	89 c1                	mov    %eax,%ecx
    while(inb(MSSTATP) & 0x02);
  100775:	8d 76 00             	lea    0x0(%esi),%esi
  100778:	ec                   	in     (%dx),%al
  100779:	a8 02                	test   $0x2,%al
  10077b:	75 fb                	jne    100778 <mouseinit+0x48>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  10077d:	b8 60 00 00 00       	mov    $0x60,%eax
  100782:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
  100783:	ba 64 00 00 00       	mov    $0x64,%edx
  100788:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  10078f:	00 
  100790:	ec                   	in     (%dx),%al
  100791:	a8 02                	test   $0x2,%al
  100793:	75 fb                	jne    100790 <mouseinit+0x60>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  100795:	ba 60 00 00 00       	mov    $0x60,%edx
  10079a:	89 c8                	mov    %ecx,%eax
  10079c:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
  10079d:	ba 64 00 00 00       	mov    $0x64,%edx
  1007a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  1007a8:	ec                   	in     (%dx),%al
  1007a9:	a8 02                	test   $0x2,%al
  1007ab:	75 fb                	jne    1007a8 <mouseinit+0x78>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  1007ad:	b8 d4 ff ff ff       	mov    $0xffffffd4,%eax
  1007b2:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
  1007b3:	ba 64 00 00 00       	mov    $0x64,%edx
  1007b8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  1007bf:	00 
  1007c0:	ec                   	in     (%dx),%al
  1007c1:	a8 02                	test   $0x2,%al
  1007c3:	75 fb                	jne    1007c0 <mouseinit+0x90>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  1007c5:	b8 f6 ff ff ff       	mov    $0xfffffff6,%eax
  1007ca:	ba 60 00 00 00       	mov    $0x60,%edx
  1007cf:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
  1007d0:	ba 64 00 00 00       	mov    $0x64,%edx
  1007d5:	8d 76 00             	lea    0x0(%esi),%esi
  1007d8:	ec                   	in     (%dx),%al
    while((inb(MSSTATP) & 0x01) == 0);
  1007d9:	a8 01                	test   $0x1,%al
  1007db:	74 fb                	je     1007d8 <mouseinit+0xa8>
  1007dd:	ba 60 00 00 00       	mov    $0x60,%edx
  1007e2:	ec                   	in     (%dx),%al
  1007e3:	ba 64 00 00 00       	mov    $0x64,%edx
  1007e8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  1007ef:	00 
  1007f0:	ec                   	in     (%dx),%al
    while(inb(MSSTATP) & 0x02);
  1007f1:	a8 02                	test   $0x2,%al
  1007f3:	75 fb                	jne    1007f0 <mouseinit+0xc0>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  1007f5:	b8 d4 ff ff ff       	mov    $0xffffffd4,%eax
  1007fa:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
  1007fb:	ba 64 00 00 00       	mov    $0x64,%edx
  100800:	ec                   	in     (%dx),%al
  100801:	a8 02                	test   $0x2,%al
  100803:	75 fb                	jne    100800 <mouseinit+0xd0>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  100805:	b8 f4 ff ff ff       	mov    $0xfffffff4,%eax
  10080a:	ba 60 00 00 00       	mov    $0x60,%edx
  10080f:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
  100810:	ba 64 00 00 00       	mov    $0x64,%edx
  100815:	8d 76 00             	lea    0x0(%esi),%esi
  100818:	ec                   	in     (%dx),%al
    while((inb(MSSTATP) & 0x01) == 0);
  100819:	a8 01                	test   $0x1,%al
  10081b:	74 fb                	je     100818 <mouseinit+0xe8>
  10081d:	ba 60 00 00 00       	mov    $0x60,%edx
  100822:	ec                   	in     (%dx),%al
    // Step 4-5: set default mouse settings and start sending packets.
    mousecmd(0xF6);        // defaults
    mousecmd(0xF4);        // enable data reporting

    // Step 6: route IRQ12 to CPU 0 via the I/O APIC.
    ioapicenable(IRQ_MOUSE, 0);
  100823:	83 ec 08             	sub    $0x8,%esp
  100826:	6a 00                	push   $0x0
  100828:	6a 0c                	push   $0xc
  10082a:	e8 d1 fc ff ff       	call   100500 <ioapicenable>
    // cprintf("Mouse initialization completed\n");

    return;
  10082f:	83 c4 10             	add    $0x10,%esp
}
  100832:	c9                   	leave
  100833:	c3                   	ret
  100834:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  10083b:	00 
  10083c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00100840 <mouseintr>:
  100840:	ba 64 00 00 00       	mov    $0x64,%edx
  100845:	ec                   	in     (%dx),%al

    // Drain all available bytes from the controller buffer. Each mouse
    // packet is 3 bytes long; bit 3 of byte 0 is always 1 and helps us
    // resynchronize if we ever lose alignment.

    while(inb(MSSTATP) & 0x01){
  100846:	a8 01                	test   $0x1,%al
  100848:	0f 84 22 02 00 00    	je     100a70 <mouseintr+0x230>
{
  10084e:	55                   	push   %ebp
  10084f:	89 e5                	mov    %esp,%ebp
  100851:	57                   	push   %edi
  100852:	56                   	push   %esi
  100853:	53                   	push   %ebx
  100854:	83 ec 1c             	sub    $0x1c,%esp
  100857:	eb 29                	jmp    100882 <mouseintr+0x42>
  100859:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

        // Note that one Packet consists of 3 bytes so we process them byte by byte
        // Once a packet is complete (3 bytes), we can process it

        // If this should be the first byte, enforce the "always 1" bit.
        if(idx == 0 && (data & 0x08) == 0)
  100860:	a8 08                	test   $0x8,%al
  100862:	74 10                	je     100874 <mouseintr+0x34>
        if(idx >= 3) {
            cprintf("Error: idx corrupted to %d\n", idx);
            idx = 0;
        }
        
        packet[idx++] = data;
  100864:	c7 05 bc 24 10 00 01 	movl   $0x1,0x1024bc
  10086b:	00 00 00 
  10086e:	88 1d b8 24 10 00    	mov    %bl,0x1024b8
  100874:	ba 64 00 00 00       	mov    $0x64,%edx
  100879:	ec                   	in     (%dx),%al
    while(inb(MSSTATP) & 0x01){
  10087a:	a8 01                	test   $0x1,%al
  10087c:	0f 84 66 01 00 00    	je     1009e8 <mouseintr+0x1a8>
  100882:	ba 60 00 00 00       	mov    $0x60,%edx
  100887:	ec                   	in     (%dx),%al
        if(idx == 0 && (data & 0x08) == 0)
  100888:	8b 15 bc 24 10 00    	mov    0x1024bc,%edx
  10088e:	89 c3                	mov    %eax,%ebx
  100890:	85 d2                	test   %edx,%edx
  100892:	74 cc                	je     100860 <mouseintr+0x20>
        if(idx >= 3) {
  100894:	83 fa 02             	cmp    $0x2,%edx
  100897:	7e 13                	jle    1008ac <mouseintr+0x6c>
            cprintf("Error: idx corrupted to %d\n", idx);
  100899:	83 ec 08             	sub    $0x8,%esp
  10089c:	52                   	push   %edx
  10089d:	68 3f 1d 10 00       	push   $0x101d3f
  1008a2:	e8 09 f8 ff ff       	call   1000b0 <cprintf>
  1008a7:	83 c4 10             	add    $0x10,%esp
  1008aa:	eb b8                	jmp    100864 <mouseintr+0x24>
        packet[idx++] = data;
  1008ac:	8d 42 01             	lea    0x1(%edx),%eax
  1008af:	88 9a b8 24 10 00    	mov    %bl,0x1024b8(%edx)
  1008b5:	a3 bc 24 10 00       	mov    %eax,0x1024bc
        if(idx < 3)
  1008ba:	83 f8 03             	cmp    $0x3,%eax
  1008bd:	75 b5                	jne    100874 <mouseintr+0x34>
        //
        // This is intentionally placed before we use the movement bytes.
        int dx = (int)(signed char)packet[1];
        int dy = (int)(signed char)packet[2];

        if(packet[0] & 0xC0) {
  1008bf:	0f b6 05 b8 24 10 00 	movzbl 0x1024b8,%eax
        int dx = (int)(signed char)packet[1];
  1008c6:	0f b6 0d b9 24 10 00 	movzbl 0x1024b9,%ecx
        idx = 0;
  1008cd:	c7 05 bc 24 10 00 00 	movl   $0x0,0x1024bc
  1008d4:	00 00 00 
        int dy = (int)(signed char)packet[2];
  1008d7:	0f b6 15 ba 24 10 00 	movzbl 0x1024ba,%edx
        if(packet[0] & 0xC0) {
  1008de:	89 c3                	mov    %eax,%ebx
  1008e0:	3c 3f                	cmp    $0x3f,%al
  1008e2:	77 90                	ja     100874 <mouseintr+0x34>
        int dx = (int)(signed char)packet[1];
  1008e4:	0f be f1             	movsbl %cl,%esi
            continue;
        }


        // Update the cursor position (example bounds omitted).
        cursor_x += dx;
  1008e7:	03 35 b4 24 10 00    	add    0x1024b4,%esi
  1008ed:	89 75 e4             	mov    %esi,-0x1c(%ebp)
  1008f0:	89 35 b4 24 10 00    	mov    %esi,0x1024b4
        int dy = (int)(signed char)packet[2];
  1008f6:	0f be f2             	movsbl %dl,%esi
  1008f9:	89 f7                	mov    %esi,%edi
        cursor_y -= dy; // flip sign to make "up" decrease on screen coords
  1008fb:	8b 35 b0 24 10 00    	mov    0x1024b0,%esi
  100901:	29 fe                	sub    %edi,%esi

        if(dx != 0 || dy != 0) {
  100903:	08 ca                	or     %cl,%dl
        cursor_y -= dy; // flip sign to make "up" decrease on screen coords
  100905:	89 35 b0 24 10 00    	mov    %esi,0x1024b0
        if(dx != 0 || dy != 0) {
  10090b:	0f 85 af 00 00 00    	jne    1009c0 <mouseintr+0x180>
        if((buttons & 0x01) && (dx != 0 || dy != 0)) {
            // Left-button drag event.
        }

        if(pressed & 0x01) {  // Left button pressed
            if(state == 0) {  // IDLE
  100911:	8b 15 ac 24 10 00    	mov    0x1024ac,%edx
        if(pressed & 0x01) {  // Left button pressed
  100917:	a8 01                	test   $0x1,%al
  100919:	74 45                	je     100960 <mouseintr+0x120>
            if(state == 0) {  // IDLE
  10091b:	85 d2                	test   %edx,%edx
  10091d:	0f 85 cd 00 00 00    	jne    1009f0 <mouseintr+0x1b0>
                // First click - start waiting
                state = 1;  // WAITING_SECOND
  100923:	c7 05 ac 24 10 00 01 	movl   $0x1,0x1024ac
  10092a:	00 00 00 
                last_click_ticks[0] = ticks;
  10092d:	8b 15 e0 24 10 00    	mov    0x1024e0,%edx
            else if(state == 2) {  // CONFIRMED_SINGLE
                // New click after single was confirmed
                cprintf("SINGLE LEFT CLICK\n");
                click_count[0]++;
                state = 1;  // WAITING_SECOND
                last_click_ticks[0] = ticks;
  100933:	89 15 a0 24 10 00    	mov    %edx,0x1024a0
        // #endif

        // Buttons are in the low three bits of the first byte.
        // Print on rising edges to avoid repeated prints while held.
        {
            uchar buttons = packet[0] & 0x07;
  100939:	89 c3                	mov    %eax,%ebx
            // if(buttons & 0x01)
            //     cprintf("LEFT\n");
            if(buttons & 0x02)
  10093b:	f6 c3 02             	test   $0x2,%bl
  10093e:	75 68                	jne    1009a8 <mouseintr+0x168>
                cprintf("RIGHT\n");
            if(buttons & 0x04)
  100940:	83 e3 04             	and    $0x4,%ebx
  100943:	0f 84 2b ff ff ff    	je     100874 <mouseintr+0x34>
                cprintf("MID\n");
  100949:	83 ec 0c             	sub    $0xc,%esp
  10094c:	68 a1 1d 10 00       	push   $0x101da1
  100951:	e8 5a f7 ff ff       	call   1000b0 <cprintf>
  100956:	83 c4 10             	add    $0x10,%esp
  100959:	e9 16 ff ff ff       	jmp    100874 <mouseintr+0x34>
  10095e:	66 90                	xchg   %ax,%ax
        if(state == 1 && (ticks - last_click_ticks[0]) > double_click_window) {
  100960:	83 fa 01             	cmp    $0x1,%edx
  100963:	75 d6                	jne    10093b <mouseintr+0xfb>
  100965:	8b 15 e0 24 10 00    	mov    0x1024e0,%edx
  10096b:	2b 15 a0 24 10 00    	sub    0x1024a0,%edx
  100971:	83 fa 0f             	cmp    $0xf,%edx
  100974:	76 c3                	jbe    100939 <mouseintr+0xf9>
            cprintf("SINGLE LEFT CLICK\n");
  100976:	83 ec 0c             	sub    $0xc,%esp
  100979:	68 87 1d 10 00       	push   $0x101d87
  10097e:	e8 2d f7 ff ff       	call   1000b0 <cprintf>
            uchar buttons = packet[0] & 0x07;
  100983:	0f b6 1d b8 24 10 00 	movzbl 0x1024b8,%ebx
            click_count[0]++;
  10098a:	83 05 94 24 10 00 01 	addl   $0x1,0x102494
            uchar buttons = packet[0] & 0x07;
  100991:	83 c4 10             	add    $0x10,%esp
            state = 0;  // IDLE
  100994:	c7 05 ac 24 10 00 00 	movl   $0x0,0x1024ac
  10099b:	00 00 00 
            if(buttons & 0x02)
  10099e:	f6 c3 02             	test   $0x2,%bl
  1009a1:	74 9d                	je     100940 <mouseintr+0x100>
  1009a3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
                cprintf("RIGHT\n");
  1009a8:	83 ec 0c             	sub    $0xc,%esp
  1009ab:	68 9a 1d 10 00       	push   $0x101d9a
  1009b0:	e8 fb f6 ff ff       	call   1000b0 <cprintf>
  1009b5:	83 c4 10             	add    $0x10,%esp
  1009b8:	eb 86                	jmp    100940 <mouseintr+0x100>
  1009ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
            cprintf("MOUSE MOVED TO (%d, %d)\n", cursor_x, cursor_y);
  1009c0:	83 ec 04             	sub    $0x4,%esp
  1009c3:	56                   	push   %esi
  1009c4:	ff 75 e4             	push   -0x1c(%ebp)
  1009c7:	68 5b 1d 10 00       	push   $0x101d5b
  1009cc:	e8 df f6 ff ff       	call   1000b0 <cprintf>
        uchar buttons = packet[0] & 0x07;    // bits: 0=L,1=R,2=M
  1009d1:	0f b6 05 b8 24 10 00 	movzbl 0x1024b8,%eax
  1009d8:	83 c4 10             	add    $0x10,%esp
  1009db:	89 c3                	mov    %eax,%ebx
  1009dd:	e9 2f ff ff ff       	jmp    100911 <mouseintr+0xd1>
  1009e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    
        
    }

    return;
  1009e8:	8d 65 f4             	lea    -0xc(%ebp),%esp
  1009eb:	5b                   	pop    %ebx
  1009ec:	5e                   	pop    %esi
  1009ed:	5f                   	pop    %edi
  1009ee:	5d                   	pop    %ebp
  1009ef:	c3                   	ret
            else if(state == 1) {  // WAITING_SECOND
  1009f0:	83 fa 01             	cmp    $0x1,%edx
  1009f3:	74 43                	je     100a38 <mouseintr+0x1f8>
            else if(state == 2) {  // CONFIRMED_SINGLE
  1009f5:	83 fa 02             	cmp    $0x2,%edx
  1009f8:	0f 85 3d ff ff ff    	jne    10093b <mouseintr+0xfb>
                cprintf("SINGLE LEFT CLICK\n");
  1009fe:	83 ec 0c             	sub    $0xc,%esp
  100a01:	68 87 1d 10 00       	push   $0x101d87
  100a06:	e8 a5 f6 ff ff       	call   1000b0 <cprintf>
                click_count[0]++;
  100a0b:	83 05 94 24 10 00 01 	addl   $0x1,0x102494
                last_click_ticks[0] = ticks;
  100a12:	8b 15 e0 24 10 00    	mov    0x1024e0,%edx
  100a18:	83 c4 10             	add    $0x10,%esp
                state = 1;  // WAITING_SECOND
  100a1b:	c7 05 ac 24 10 00 01 	movl   $0x1,0x1024ac
  100a22:	00 00 00 
                last_click_ticks[0] = ticks;
  100a25:	0f b6 05 b8 24 10 00 	movzbl 0x1024b8,%eax
  100a2c:	e9 02 ff ff ff       	jmp    100933 <mouseintr+0xf3>
  100a31:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
                cprintf("DOUBLE LEFT CLICK\n");
  100a38:	83 ec 0c             	sub    $0xc,%esp
  100a3b:	68 74 1d 10 00       	push   $0x101d74
  100a40:	e8 6b f6 ff ff       	call   1000b0 <cprintf>
                last_click_ticks[0] = ticks;
  100a45:	a1 e0 24 10 00       	mov    0x1024e0,%eax
                click_count[0]++;
  100a4a:	83 05 94 24 10 00 01 	addl   $0x1,0x102494
                last_click_ticks[0] = ticks;
  100a51:	83 c4 10             	add    $0x10,%esp
                state = 0;  // IDLE
  100a54:	c7 05 ac 24 10 00 00 	movl   $0x0,0x1024ac
  100a5b:	00 00 00 
            uchar buttons = packet[0] & 0x07;
  100a5e:	0f b6 1d b8 24 10 00 	movzbl 0x1024b8,%ebx
                last_click_ticks[0] = ticks;
  100a65:	a3 a0 24 10 00       	mov    %eax,0x1024a0
                state = 0;  // IDLE
  100a6a:	e9 cc fe ff ff       	jmp    10093b <mouseintr+0xfb>
  100a6f:	90                   	nop
  100a70:	c3                   	ret
  100a71:	66 90                	xchg   %ax,%ax
  100a73:	66 90                	xchg   %ax,%ax
  100a75:	66 90                	xchg   %ax,%ax
  100a77:	66 90                	xchg   %ax,%ax
  100a79:	66 90                	xchg   %ax,%ax
  100a7b:	66 90                	xchg   %ax,%ax
  100a7d:	66 90                	xchg   %ax,%ax
  100a7f:	90                   	nop

00100a80 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
  100a80:	55                   	push   %ebp
  100a81:	89 e5                	mov    %esp,%ebp
  100a83:	57                   	push   %edi
  100a84:	56                   	push   %esi
  100a85:	53                   	push   %ebx
  uchar *e, *p, *addr;

  // addr = P2V(a);
  addr = (uchar*) a;
  e = addr+len;
  100a86:	8d 1c 10             	lea    (%eax,%edx,1),%ebx
{
  100a89:	83 ec 0c             	sub    $0xc,%esp
  for(p = addr; p < e; p += sizeof(struct mp))
  100a8c:	39 d8                	cmp    %ebx,%eax
  100a8e:	73 50                	jae    100ae0 <mpsearch1+0x60>
  100a90:	89 c6                	mov    %eax,%esi
  100a92:	eb 0a                	jmp    100a9e <mpsearch1+0x1e>
  100a94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  100a98:	89 fe                	mov    %edi,%esi
  100a9a:	39 df                	cmp    %ebx,%edi
  100a9c:	73 42                	jae    100ae0 <mpsearch1+0x60>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
  100a9e:	83 ec 04             	sub    $0x4,%esp
  100aa1:	8d 7e 10             	lea    0x10(%esi),%edi
  100aa4:	6a 04                	push   $0x4
  100aa6:	68 a6 1d 10 00       	push   $0x101da6
  100aab:	56                   	push   %esi
  100aac:	e8 ef 03 00 00       	call   100ea0 <memcmp>
  100ab1:	83 c4 10             	add    $0x10,%esp
  100ab4:	85 c0                	test   %eax,%eax
  100ab6:	75 e0                	jne    100a98 <mpsearch1+0x18>
  100ab8:	89 f2                	mov    %esi,%edx
  100aba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    sum += addr[i];
  100ac0:	0f b6 0a             	movzbl (%edx),%ecx
  for(i=0; i<len; i++)
  100ac3:	83 c2 01             	add    $0x1,%edx
    sum += addr[i];
  100ac6:	01 c8                	add    %ecx,%eax
  for(i=0; i<len; i++)
  100ac8:	39 fa                	cmp    %edi,%edx
  100aca:	75 f4                	jne    100ac0 <mpsearch1+0x40>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
  100acc:	84 c0                	test   %al,%al
  100ace:	75 c8                	jne    100a98 <mpsearch1+0x18>
      return (struct mp*)p;
  return 0;
}
  100ad0:	8d 65 f4             	lea    -0xc(%ebp),%esp
  100ad3:	89 f0                	mov    %esi,%eax
  100ad5:	5b                   	pop    %ebx
  100ad6:	5e                   	pop    %esi
  100ad7:	5f                   	pop    %edi
  100ad8:	5d                   	pop    %ebp
  100ad9:	c3                   	ret
  100ada:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  100ae0:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
  100ae3:	31 f6                	xor    %esi,%esi
}
  100ae5:	5b                   	pop    %ebx
  100ae6:	89 f0                	mov    %esi,%eax
  100ae8:	5e                   	pop    %esi
  100ae9:	5f                   	pop    %edi
  100aea:	5d                   	pop    %ebp
  100aeb:	c3                   	ret
  100aec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00100af0 <mpinit>:
  return conf;
}

void
mpinit(void)
{
  100af0:	55                   	push   %ebp
  100af1:	89 e5                	mov    %esp,%ebp
  100af3:	57                   	push   %edi
  100af4:	56                   	push   %esi
  100af5:	53                   	push   %ebx
  100af6:	83 ec 2c             	sub    $0x2c,%esp
  volatile uint addr = 0x400; 
  100af9:	c7 45 e4 00 04 00 00 	movl   $0x400,-0x1c(%ebp)
  bda = (uchar*)(uint)addr;
  100b00:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
  100b03:	0f b7 42 0e          	movzwl 0xe(%edx),%eax
  100b07:	c1 e0 04             	shl    $0x4,%eax
  100b0a:	75 0c                	jne    100b18 <mpinit+0x28>
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
  100b0c:	0f b7 42 13          	movzwl 0x13(%edx),%eax
  100b10:	c1 e0 0a             	shl    $0xa,%eax
    if((mp = mpsearch1(p-1024, 1024)))
  100b13:	2d 00 04 00 00       	sub    $0x400,%eax
    if((mp = mpsearch1(p, 1024)))
  100b18:	ba 00 04 00 00       	mov    $0x400,%edx
  100b1d:	e8 5e ff ff ff       	call   100a80 <mpsearch1>
  100b22:	89 c6                	mov    %eax,%esi
  100b24:	85 c0                	test   %eax,%eax
  100b26:	0f 84 2c 01 00 00    	je     100c58 <mpinit+0x168>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
  100b2c:	8b 5e 04             	mov    0x4(%esi),%ebx
  100b2f:	85 db                	test   %ebx,%ebx
  100b31:	0f 84 11 01 00 00    	je     100c48 <mpinit+0x158>
  if(memcmp(conf, "PCMP", 4) != 0)
  100b37:	83 ec 04             	sub    $0x4,%esp
  100b3a:	6a 04                	push   $0x4
  100b3c:	68 ab 1d 10 00       	push   $0x101dab
  100b41:	53                   	push   %ebx
  100b42:	e8 59 03 00 00       	call   100ea0 <memcmp>
  100b47:	83 c4 10             	add    $0x10,%esp
  100b4a:	85 c0                	test   %eax,%eax
  100b4c:	0f 85 f6 00 00 00    	jne    100c48 <mpinit+0x158>
  if(conf->version != 1 && conf->version != 4)
  100b52:	0f b6 43 06          	movzbl 0x6(%ebx),%eax
  100b56:	3c 01                	cmp    $0x1,%al
  100b58:	74 08                	je     100b62 <mpinit+0x72>
  100b5a:	3c 04                	cmp    $0x4,%al
  100b5c:	0f 85 e6 00 00 00    	jne    100c48 <mpinit+0x158>
  if(sum((uchar*)conf, conf->length) != 0)
  100b62:	0f b7 53 04          	movzwl 0x4(%ebx),%edx
  for(i=0; i<len; i++)
  100b66:	31 c9                	xor    %ecx,%ecx
  100b68:	66 85 d2             	test   %dx,%dx
  100b6b:	74 2a                	je     100b97 <mpinit+0xa7>
  sum = 0;
  100b6d:	89 75 d4             	mov    %esi,-0x2c(%ebp)
  100b70:	0f b7 ca             	movzwl %dx,%ecx
  100b73:	89 d8                	mov    %ebx,%eax
  100b75:	31 d2                	xor    %edx,%edx
  100b77:	8d 3c 0b             	lea    (%ebx,%ecx,1),%edi
  100b7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    sum += addr[i];
  100b80:	0f b6 30             	movzbl (%eax),%esi
  for(i=0; i<len; i++)
  100b83:	83 c0 01             	add    $0x1,%eax
    sum += addr[i];
  100b86:	01 f2                	add    %esi,%edx
  for(i=0; i<len; i++)
  100b88:	39 c7                	cmp    %eax,%edi
  100b8a:	75 f4                	jne    100b80 <mpinit+0x90>
  if(sum((uchar*)conf, conf->length) != 0)
  100b8c:	8b 75 d4             	mov    -0x2c(%ebp),%esi
  100b8f:	84 d2                	test   %dl,%dl
  100b91:	0f 85 b1 00 00 00    	jne    100c48 <mpinit+0x158>
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
  100b97:	8b 43 24             	mov    0x24(%ebx),%eax
  100b9a:	a3 90 24 10 00       	mov    %eax,0x102490
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
  100b9f:	8d 43 2c             	lea    0x2c(%ebx),%eax
  100ba2:	01 cb                	add    %ecx,%ebx
  ismp = 1;
  100ba4:	b9 01 00 00 00       	mov    $0x1,%ecx
  100ba9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
  100bb0:	39 d8                	cmp    %ebx,%eax
  100bb2:	73 15                	jae    100bc9 <mpinit+0xd9>
    switch(*p){
  100bb4:	0f b6 10             	movzbl (%eax),%edx
  100bb7:	80 fa 02             	cmp    $0x2,%dl
  100bba:	74 74                	je     100c30 <mpinit+0x140>
  100bbc:	77 62                	ja     100c20 <mpinit+0x130>
  100bbe:	84 d2                	test   %dl,%dl
  100bc0:	74 36                	je     100bf8 <mpinit+0x108>
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
  100bc2:	83 c0 08             	add    $0x8,%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
  100bc5:	39 d8                	cmp    %ebx,%eax
  100bc7:	72 eb                	jb     100bb4 <mpinit+0xc4>
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp)
  100bc9:	85 c9                	test   %ecx,%ecx
  100bcb:	0f 84 d4 00 00 00    	je     100ca5 <mpinit+0x1b5>
    panic("Didn't find a suitable machine");

  if(mp->imcrp){
  100bd1:	80 7e 0c 00          	cmpb   $0x0,0xc(%esi)
  100bd5:	74 15                	je     100bec <mpinit+0xfc>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  100bd7:	b8 70 00 00 00       	mov    $0x70,%eax
  100bdc:	ba 22 00 00 00       	mov    $0x22,%edx
  100be1:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
  100be2:	ba 23 00 00 00       	mov    $0x23,%edx
  100be7:	ec                   	in     (%dx),%al
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
  100be8:	83 c8 01             	or     $0x1,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  100beb:	ee                   	out    %al,(%dx)
  }
}
  100bec:	8d 65 f4             	lea    -0xc(%ebp),%esp
  100bef:	5b                   	pop    %ebx
  100bf0:	5e                   	pop    %esi
  100bf1:	5f                   	pop    %edi
  100bf2:	5d                   	pop    %ebp
  100bf3:	c3                   	ret
  100bf4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if(ncpu < NCPU) {
  100bf8:	8b 3d c4 24 10 00    	mov    0x1024c4,%edi
  100bfe:	83 ff 07             	cmp    $0x7,%edi
  100c01:	7f 13                	jg     100c16 <mpinit+0x126>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
  100c03:	0f b6 50 01          	movzbl 0x1(%eax),%edx
        ncpu++;
  100c07:	83 c7 01             	add    $0x1,%edi
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
  100c0a:	88 97 c7 24 10 00    	mov    %dl,0x1024c7(%edi)
        ncpu++;
  100c10:	89 3d c4 24 10 00    	mov    %edi,0x1024c4
      p += sizeof(struct mpproc);
  100c16:	83 c0 14             	add    $0x14,%eax
      continue;
  100c19:	eb 95                	jmp    100bb0 <mpinit+0xc0>
  100c1b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    switch(*p){
  100c20:	83 ea 03             	sub    $0x3,%edx
  100c23:	80 fa 01             	cmp    $0x1,%dl
  100c26:	76 9a                	jbe    100bc2 <mpinit+0xd2>
  100c28:	31 c9                	xor    %ecx,%ecx
  100c2a:	eb 84                	jmp    100bb0 <mpinit+0xc0>
  100c2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      ioapicid = ioapic->apicno;
  100c30:	0f b6 50 01          	movzbl 0x1(%eax),%edx
      p += sizeof(struct mpioapic);
  100c34:	83 c0 08             	add    $0x8,%eax
      ioapicid = ioapic->apicno;
  100c37:	88 15 c0 24 10 00    	mov    %dl,0x1024c0
      continue;
  100c3d:	e9 6e ff ff ff       	jmp    100bb0 <mpinit+0xc0>
  100c42:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    panic("Expect to run on an SMP");
  100c48:	83 ec 0c             	sub    $0xc,%esp
  100c4b:	68 b0 1d 10 00       	push   $0x101db0
  100c50:	e8 db f5 ff ff       	call   100230 <panic>
  100c55:	8d 76 00             	lea    0x0(%esi),%esi
{
  100c58:	be 00 00 0f 00       	mov    $0xf0000,%esi
  100c5d:	eb 0b                	jmp    100c6a <mpinit+0x17a>
  100c5f:	90                   	nop
  for(p = addr; p < e; p += sizeof(struct mp))
  100c60:	89 de                	mov    %ebx,%esi
  100c62:	81 fb 00 00 10 00    	cmp    $0x100000,%ebx
  100c68:	74 de                	je     100c48 <mpinit+0x158>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
  100c6a:	83 ec 04             	sub    $0x4,%esp
  100c6d:	8d 5e 10             	lea    0x10(%esi),%ebx
  100c70:	6a 04                	push   $0x4
  100c72:	68 a6 1d 10 00       	push   $0x101da6
  100c77:	56                   	push   %esi
  100c78:	e8 23 02 00 00       	call   100ea0 <memcmp>
  100c7d:	83 c4 10             	add    $0x10,%esp
  100c80:	85 c0                	test   %eax,%eax
  100c82:	75 dc                	jne    100c60 <mpinit+0x170>
  100c84:	89 f2                	mov    %esi,%edx
  100c86:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  100c8d:	00 
  100c8e:	66 90                	xchg   %ax,%ax
    sum += addr[i];
  100c90:	0f b6 0a             	movzbl (%edx),%ecx
  for(i=0; i<len; i++)
  100c93:	83 c2 01             	add    $0x1,%edx
    sum += addr[i];
  100c96:	01 c8                	add    %ecx,%eax
  for(i=0; i<len; i++)
  100c98:	39 d3                	cmp    %edx,%ebx
  100c9a:	75 f4                	jne    100c90 <mpinit+0x1a0>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
  100c9c:	84 c0                	test   %al,%al
  100c9e:	75 c0                	jne    100c60 <mpinit+0x170>
  100ca0:	e9 87 fe ff ff       	jmp    100b2c <mpinit+0x3c>
    panic("Didn't find a suitable machine");
  100ca5:	83 ec 0c             	sub    $0xc,%esp
  100ca8:	68 40 1e 10 00       	push   $0x101e40
  100cad:	e8 7e f5 ff ff       	call   100230 <panic>
  100cb2:	66 90                	xchg   %ax,%ax
  100cb4:	66 90                	xchg   %ax,%ax
  100cb6:	66 90                	xchg   %ax,%ax
  100cb8:	66 90                	xchg   %ax,%ax
  100cba:	66 90                	xchg   %ax,%ax
  100cbc:	66 90                	xchg   %ax,%ax
  100cbe:	66 90                	xchg   %ax,%ax

00100cc0 <picinit>:
  100cc0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  100cc5:	ba 21 00 00 00       	mov    $0x21,%edx
  100cca:	ee                   	out    %al,(%dx)
  100ccb:	ba a1 00 00 00       	mov    $0xa1,%edx
  100cd0:	ee                   	out    %al,(%dx)
picinit(void)
{
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
  outb(IO_PIC2+1, 0xFF);
}
  100cd1:	c3                   	ret
  100cd2:	66 90                	xchg   %ax,%ax
  100cd4:	66 90                	xchg   %ax,%ax
  100cd6:	66 90                	xchg   %ax,%ax
  100cd8:	66 90                	xchg   %ax,%ax
  100cda:	66 90                	xchg   %ax,%ax
  100cdc:	66 90                	xchg   %ax,%ax
  100cde:	66 90                	xchg   %ax,%ax

00100ce0 <uartgetc>:


static int
uartgetc(void)
{
  if(!uart)
  100ce0:	a1 d0 24 10 00       	mov    0x1024d0,%eax
  100ce5:	85 c0                	test   %eax,%eax
  100ce7:	74 17                	je     100d00 <uartgetc+0x20>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
  100ce9:	ba fd 03 00 00       	mov    $0x3fd,%edx
  100cee:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
  100cef:	a8 01                	test   $0x1,%al
  100cf1:	74 0d                	je     100d00 <uartgetc+0x20>
  100cf3:	ba f8 03 00 00       	mov    $0x3f8,%edx
  100cf8:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
  100cf9:	0f b6 c0             	movzbl %al,%eax
  100cfc:	c3                   	ret
  100cfd:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
  100d00:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  100d05:	c3                   	ret
  100d06:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  100d0d:	00 
  100d0e:	66 90                	xchg   %ax,%ax

00100d10 <uartinit>:
{
  100d10:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  100d11:	31 c9                	xor    %ecx,%ecx
  100d13:	89 c8                	mov    %ecx,%eax
  100d15:	89 e5                	mov    %esp,%ebp
  100d17:	57                   	push   %edi
  100d18:	bf fa 03 00 00       	mov    $0x3fa,%edi
  100d1d:	56                   	push   %esi
  100d1e:	89 fa                	mov    %edi,%edx
  100d20:	53                   	push   %ebx
  100d21:	83 ec 0c             	sub    $0xc,%esp
  100d24:	ee                   	out    %al,(%dx)
  100d25:	be fb 03 00 00       	mov    $0x3fb,%esi
  100d2a:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
  100d2f:	89 f2                	mov    %esi,%edx
  100d31:	ee                   	out    %al,(%dx)
  100d32:	b8 0c 00 00 00       	mov    $0xc,%eax
  100d37:	ba f8 03 00 00       	mov    $0x3f8,%edx
  100d3c:	ee                   	out    %al,(%dx)
  100d3d:	bb f9 03 00 00       	mov    $0x3f9,%ebx
  100d42:	89 c8                	mov    %ecx,%eax
  100d44:	89 da                	mov    %ebx,%edx
  100d46:	ee                   	out    %al,(%dx)
  100d47:	b8 03 00 00 00       	mov    $0x3,%eax
  100d4c:	89 f2                	mov    %esi,%edx
  100d4e:	ee                   	out    %al,(%dx)
  100d4f:	ba fc 03 00 00       	mov    $0x3fc,%edx
  100d54:	89 c8                	mov    %ecx,%eax
  100d56:	ee                   	out    %al,(%dx)
  100d57:	b8 01 00 00 00       	mov    $0x1,%eax
  100d5c:	89 da                	mov    %ebx,%edx
  100d5e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
  100d5f:	ba fd 03 00 00       	mov    $0x3fd,%edx
  100d64:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
  100d65:	3c ff                	cmp    $0xff,%al
  100d67:	74 3d                	je     100da6 <uartinit+0x96>
  uart = 1;
  100d69:	c7 05 d0 24 10 00 01 	movl   $0x1,0x1024d0
  100d70:	00 00 00 
  100d73:	89 fa                	mov    %edi,%edx
  100d75:	ec                   	in     (%dx),%al
  100d76:	ba f8 03 00 00       	mov    $0x3f8,%edx
  100d7b:	ec                   	in     (%dx),%al
  ioapicenable(IRQ_COM1, 0);
  100d7c:	83 ec 08             	sub    $0x8,%esp
  for(p="xv6...\n"; *p; p++)
  100d7f:	be c8 1d 10 00       	mov    $0x101dc8,%esi
  100d84:	bf 78 00 00 00       	mov    $0x78,%edi
  ioapicenable(IRQ_COM1, 0);
  100d89:	6a 00                	push   $0x0
  100d8b:	6a 04                	push   $0x4
  100d8d:	e8 6e f7 ff ff       	call   100500 <ioapicenable>
  if(!uart)
  100d92:	a1 d0 24 10 00       	mov    0x1024d0,%eax
  100d97:	83 c4 10             	add    $0x10,%esp
  100d9a:	85 c0                	test   %eax,%eax
  100d9c:	75 10                	jne    100dae <uartinit+0x9e>
  for(p="xv6...\n"; *p; p++)
  100d9e:	83 c6 01             	add    $0x1,%esi
  100da1:	80 3e 00             	cmpb   $0x0,(%esi)
  100da4:	75 f8                	jne    100d9e <uartinit+0x8e>
}
  100da6:	8d 65 f4             	lea    -0xc(%ebp),%esp
  100da9:	5b                   	pop    %ebx
  100daa:	5e                   	pop    %esi
  100dab:	5f                   	pop    %edi
  100dac:	5d                   	pop    %ebp
  100dad:	c3                   	ret
  100dae:	bb fd 03 00 00       	mov    $0x3fd,%ebx
  100db3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  100db8:	89 da                	mov    %ebx,%edx
  100dba:	ec                   	in     (%dx),%al
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++);
  100dbb:	a8 20                	test   $0x20,%al
  100dbd:	75 15                	jne    100dd4 <uartinit+0xc4>
  100dbf:	b9 80 00 00 00       	mov    $0x80,%ecx
  100dc4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  100dc8:	83 e9 01             	sub    $0x1,%ecx
  100dcb:	74 07                	je     100dd4 <uartinit+0xc4>
  100dcd:	89 da                	mov    %ebx,%edx
  100dcf:	ec                   	in     (%dx),%al
  100dd0:	a8 20                	test   $0x20,%al
  100dd2:	74 f4                	je     100dc8 <uartinit+0xb8>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  100dd4:	ba f8 03 00 00       	mov    $0x3f8,%edx
  100dd9:	89 f8                	mov    %edi,%eax
  100ddb:	ee                   	out    %al,(%dx)
  for(p="xv6...\n"; *p; p++)
  100ddc:	0f b6 7e 01          	movzbl 0x1(%esi),%edi
  100de0:	83 c6 01             	add    $0x1,%esi
  100de3:	89 f8                	mov    %edi,%eax
  100de5:	84 c0                	test   %al,%al
  100de7:	75 cf                	jne    100db8 <uartinit+0xa8>
}
  100de9:	8d 65 f4             	lea    -0xc(%ebp),%esp
  100dec:	5b                   	pop    %ebx
  100ded:	5e                   	pop    %esi
  100dee:	5f                   	pop    %edi
  100def:	5d                   	pop    %ebp
  100df0:	c3                   	ret
  100df1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  100df8:	00 
  100df9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00100e00 <uartputc>:
  if(!uart)
  100e00:	a1 d0 24 10 00       	mov    0x1024d0,%eax
  100e05:	85 c0                	test   %eax,%eax
  100e07:	74 2f                	je     100e38 <uartputc+0x38>
{
  100e09:	55                   	push   %ebp
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
  100e0a:	ba fd 03 00 00       	mov    $0x3fd,%edx
  100e0f:	89 e5                	mov    %esp,%ebp
  100e11:	ec                   	in     (%dx),%al
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++);
  100e12:	a8 20                	test   $0x20,%al
  100e14:	75 14                	jne    100e2a <uartputc+0x2a>
  100e16:	b9 80 00 00 00       	mov    $0x80,%ecx
  100e1b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  100e20:	83 e9 01             	sub    $0x1,%ecx
  100e23:	74 05                	je     100e2a <uartputc+0x2a>
  100e25:	ec                   	in     (%dx),%al
  100e26:	a8 20                	test   $0x20,%al
  100e28:	74 f6                	je     100e20 <uartputc+0x20>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  100e2a:	8b 45 08             	mov    0x8(%ebp),%eax
  100e2d:	ba f8 03 00 00       	mov    $0x3f8,%edx
  100e32:	ee                   	out    %al,(%dx)
}
  100e33:	5d                   	pop    %ebp
  100e34:	c3                   	ret
  100e35:	8d 76 00             	lea    0x0(%esi),%esi
  100e38:	c3                   	ret
  100e39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00100e40 <uartintr>:

void
uartintr(void)
{
  100e40:	55                   	push   %ebp
  100e41:	89 e5                	mov    %esp,%ebp
  100e43:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
  100e46:	68 e0 0c 10 00       	push   $0x100ce0
  100e4b:	e8 50 f4 ff ff       	call   1002a0 <consoleintr>
  100e50:	83 c4 10             	add    $0x10,%esp
  100e53:	c9                   	leave
  100e54:	c3                   	ret
  100e55:	66 90                	xchg   %ax,%ax
  100e57:	66 90                	xchg   %ax,%ax
  100e59:	66 90                	xchg   %ax,%ax
  100e5b:	66 90                	xchg   %ax,%ax
  100e5d:	66 90                	xchg   %ax,%ax
  100e5f:	90                   	nop

00100e60 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
  100e60:	55                   	push   %ebp
  100e61:	89 e5                	mov    %esp,%ebp
  100e63:	57                   	push   %edi
  100e64:	8b 55 08             	mov    0x8(%ebp),%edx
  100e67:	8b 4d 10             	mov    0x10(%ebp),%ecx
  if ((int)dst%4 == 0 && n%4 == 0){
  100e6a:	89 d0                	mov    %edx,%eax
  100e6c:	09 c8                	or     %ecx,%eax
  100e6e:	a8 03                	test   $0x3,%al
  100e70:	75 1e                	jne    100e90 <memset+0x30>
    c &= 0xFF;
  100e72:	0f b6 45 0c          	movzbl 0xc(%ebp),%eax
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
  100e76:	c1 e9 02             	shr    $0x2,%ecx
  asm volatile("cld; rep stosl" :
  100e79:	89 d7                	mov    %edx,%edi
  100e7b:	69 c0 01 01 01 01    	imul   $0x1010101,%eax,%eax
  100e81:	fc                   	cld
  100e82:	f3 ab                	rep stos %eax,%es:(%edi)
  } else
    stosb(dst, c, n);
  return dst;
}
  100e84:	8b 7d fc             	mov    -0x4(%ebp),%edi
  100e87:	89 d0                	mov    %edx,%eax
  100e89:	c9                   	leave
  100e8a:	c3                   	ret
  100e8b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  asm volatile("cld; rep stosb" :
  100e90:	8b 45 0c             	mov    0xc(%ebp),%eax
  100e93:	89 d7                	mov    %edx,%edi
  100e95:	fc                   	cld
  100e96:	f3 aa                	rep stos %al,%es:(%edi)
  100e98:	8b 7d fc             	mov    -0x4(%ebp),%edi
  100e9b:	89 d0                	mov    %edx,%eax
  100e9d:	c9                   	leave
  100e9e:	c3                   	ret
  100e9f:	90                   	nop

00100ea0 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
  100ea0:	55                   	push   %ebp
  100ea1:	89 e5                	mov    %esp,%ebp
  100ea3:	56                   	push   %esi
  100ea4:	8b 75 10             	mov    0x10(%ebp),%esi
  100ea7:	8b 45 08             	mov    0x8(%ebp),%eax
  100eaa:	53                   	push   %ebx
  100eab:	8b 55 0c             	mov    0xc(%ebp),%edx
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
  100eae:	85 f6                	test   %esi,%esi
  100eb0:	74 2e                	je     100ee0 <memcmp+0x40>
  100eb2:	01 c6                	add    %eax,%esi
  100eb4:	eb 14                	jmp    100eca <memcmp+0x2a>
  100eb6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  100ebd:	00 
  100ebe:	66 90                	xchg   %ax,%ax
    if(*s1 != *s2)
      return *s1 - *s2;
    s1++, s2++;
  100ec0:	83 c0 01             	add    $0x1,%eax
  100ec3:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0){
  100ec6:	39 f0                	cmp    %esi,%eax
  100ec8:	74 16                	je     100ee0 <memcmp+0x40>
    if(*s1 != *s2)
  100eca:	0f b6 08             	movzbl (%eax),%ecx
  100ecd:	0f b6 1a             	movzbl (%edx),%ebx
  100ed0:	38 d9                	cmp    %bl,%cl
  100ed2:	74 ec                	je     100ec0 <memcmp+0x20>
      return *s1 - *s2;
  100ed4:	0f b6 c1             	movzbl %cl,%eax
  100ed7:	29 d8                	sub    %ebx,%eax
  }

  return 0;
}
  100ed9:	5b                   	pop    %ebx
  100eda:	5e                   	pop    %esi
  100edb:	5d                   	pop    %ebp
  100edc:	c3                   	ret
  100edd:	8d 76 00             	lea    0x0(%esi),%esi
  100ee0:	5b                   	pop    %ebx
  return 0;
  100ee1:	31 c0                	xor    %eax,%eax
}
  100ee3:	5e                   	pop    %esi
  100ee4:	5d                   	pop    %ebp
  100ee5:	c3                   	ret
  100ee6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  100eed:	00 
  100eee:	66 90                	xchg   %ax,%ax

00100ef0 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
  100ef0:	55                   	push   %ebp
  100ef1:	89 e5                	mov    %esp,%ebp
  100ef3:	57                   	push   %edi
  100ef4:	8b 55 08             	mov    0x8(%ebp),%edx
  100ef7:	8b 45 10             	mov    0x10(%ebp),%eax
  100efa:	56                   	push   %esi
  100efb:	8b 75 0c             	mov    0xc(%ebp),%esi
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
  100efe:	39 d6                	cmp    %edx,%esi
  100f00:	73 26                	jae    100f28 <memmove+0x38>
  100f02:	8d 0c 06             	lea    (%esi,%eax,1),%ecx
  100f05:	39 ca                	cmp    %ecx,%edx
  100f07:	73 1f                	jae    100f28 <memmove+0x38>
    s += n;
    d += n;
    while(n-- > 0)
  100f09:	85 c0                	test   %eax,%eax
  100f0b:	74 0f                	je     100f1c <memmove+0x2c>
  100f0d:	83 e8 01             	sub    $0x1,%eax
      *--d = *--s;
  100f10:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
  100f14:	88 0c 02             	mov    %cl,(%edx,%eax,1)
    while(n-- > 0)
  100f17:	83 e8 01             	sub    $0x1,%eax
  100f1a:	73 f4                	jae    100f10 <memmove+0x20>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
  100f1c:	5e                   	pop    %esi
  100f1d:	89 d0                	mov    %edx,%eax
  100f1f:	5f                   	pop    %edi
  100f20:	5d                   	pop    %ebp
  100f21:	c3                   	ret
  100f22:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    while(n-- > 0)
  100f28:	8d 0c 06             	lea    (%esi,%eax,1),%ecx
  100f2b:	89 d7                	mov    %edx,%edi
  100f2d:	85 c0                	test   %eax,%eax
  100f2f:	74 eb                	je     100f1c <memmove+0x2c>
  100f31:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      *d++ = *s++;
  100f38:	a4                   	movsb  %ds:(%esi),%es:(%edi)
    while(n-- > 0)
  100f39:	39 ce                	cmp    %ecx,%esi
  100f3b:	75 fb                	jne    100f38 <memmove+0x48>
}
  100f3d:	5e                   	pop    %esi
  100f3e:	89 d0                	mov    %edx,%eax
  100f40:	5f                   	pop    %edi
  100f41:	5d                   	pop    %ebp
  100f42:	c3                   	ret
  100f43:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  100f4a:	00 
  100f4b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

00100f50 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
  return memmove(dst, src, n);
  100f50:	eb 9e                	jmp    100ef0 <memmove>
  100f52:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  100f59:	00 
  100f5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00100f60 <strncmp>:
}

int
strncmp(const char *p, const char *q, uint n)
{
  100f60:	55                   	push   %ebp
  100f61:	89 e5                	mov    %esp,%ebp
  100f63:	53                   	push   %ebx
  100f64:	8b 55 10             	mov    0x10(%ebp),%edx
  100f67:	8b 45 08             	mov    0x8(%ebp),%eax
  100f6a:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(n > 0 && *p && *p == *q)
  100f6d:	85 d2                	test   %edx,%edx
  100f6f:	75 16                	jne    100f87 <strncmp+0x27>
  100f71:	eb 2d                	jmp    100fa0 <strncmp+0x40>
  100f73:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  100f78:	3a 19                	cmp    (%ecx),%bl
  100f7a:	75 12                	jne    100f8e <strncmp+0x2e>
    n--, p++, q++;
  100f7c:	83 c0 01             	add    $0x1,%eax
  100f7f:	83 c1 01             	add    $0x1,%ecx
  while(n > 0 && *p && *p == *q)
  100f82:	83 ea 01             	sub    $0x1,%edx
  100f85:	74 19                	je     100fa0 <strncmp+0x40>
  100f87:	0f b6 18             	movzbl (%eax),%ebx
  100f8a:	84 db                	test   %bl,%bl
  100f8c:	75 ea                	jne    100f78 <strncmp+0x18>
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
  100f8e:	0f b6 00             	movzbl (%eax),%eax
  100f91:	0f b6 11             	movzbl (%ecx),%edx
}
  100f94:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  100f97:	c9                   	leave
  return (uchar)*p - (uchar)*q;
  100f98:	29 d0                	sub    %edx,%eax
}
  100f9a:	c3                   	ret
  100f9b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  100fa0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return 0;
  100fa3:	31 c0                	xor    %eax,%eax
}
  100fa5:	c9                   	leave
  100fa6:	c3                   	ret
  100fa7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  100fae:	00 
  100faf:	90                   	nop

00100fb0 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
  100fb0:	55                   	push   %ebp
  100fb1:	89 e5                	mov    %esp,%ebp
  100fb3:	57                   	push   %edi
  100fb4:	56                   	push   %esi
  100fb5:	8b 75 08             	mov    0x8(%ebp),%esi
  100fb8:	53                   	push   %ebx
  100fb9:	8b 55 10             	mov    0x10(%ebp),%edx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
  100fbc:	89 f0                	mov    %esi,%eax
  100fbe:	eb 15                	jmp    100fd5 <strncpy+0x25>
  100fc0:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  100fc4:	8b 7d 0c             	mov    0xc(%ebp),%edi
  100fc7:	83 c0 01             	add    $0x1,%eax
  100fca:	0f b6 4f ff          	movzbl -0x1(%edi),%ecx
  100fce:	88 48 ff             	mov    %cl,-0x1(%eax)
  100fd1:	84 c9                	test   %cl,%cl
  100fd3:	74 13                	je     100fe8 <strncpy+0x38>
  100fd5:	89 d3                	mov    %edx,%ebx
  100fd7:	83 ea 01             	sub    $0x1,%edx
  100fda:	85 db                	test   %ebx,%ebx
  100fdc:	7f e2                	jg     100fc0 <strncpy+0x10>
    ;
  while(n-- > 0)
    *s++ = 0;
  return os;
}
  100fde:	5b                   	pop    %ebx
  100fdf:	89 f0                	mov    %esi,%eax
  100fe1:	5e                   	pop    %esi
  100fe2:	5f                   	pop    %edi
  100fe3:	5d                   	pop    %ebp
  100fe4:	c3                   	ret
  100fe5:	8d 76 00             	lea    0x0(%esi),%esi
  while(n-- > 0)
  100fe8:	8d 0c 18             	lea    (%eax,%ebx,1),%ecx
  100feb:	83 e9 01             	sub    $0x1,%ecx
  100fee:	85 d2                	test   %edx,%edx
  100ff0:	74 ec                	je     100fde <strncpy+0x2e>
  100ff2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    *s++ = 0;
  100ff8:	83 c0 01             	add    $0x1,%eax
  100ffb:	89 ca                	mov    %ecx,%edx
  100ffd:	c6 40 ff 00          	movb   $0x0,-0x1(%eax)
  while(n-- > 0)
  101001:	29 c2                	sub    %eax,%edx
  101003:	85 d2                	test   %edx,%edx
  101005:	7f f1                	jg     100ff8 <strncpy+0x48>
}
  101007:	5b                   	pop    %ebx
  101008:	89 f0                	mov    %esi,%eax
  10100a:	5e                   	pop    %esi
  10100b:	5f                   	pop    %edi
  10100c:	5d                   	pop    %ebp
  10100d:	c3                   	ret
  10100e:	66 90                	xchg   %ax,%ax

00101010 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
  101010:	55                   	push   %ebp
  101011:	89 e5                	mov    %esp,%ebp
  101013:	56                   	push   %esi
  101014:	8b 55 10             	mov    0x10(%ebp),%edx
  101017:	8b 75 08             	mov    0x8(%ebp),%esi
  10101a:	53                   	push   %ebx
  10101b:	8b 45 0c             	mov    0xc(%ebp),%eax
  char *os;

  os = s;
  if(n <= 0)
  10101e:	85 d2                	test   %edx,%edx
  101020:	7e 25                	jle    101047 <safestrcpy+0x37>
  101022:	8d 5c 10 ff          	lea    -0x1(%eax,%edx,1),%ebx
  101026:	89 f2                	mov    %esi,%edx
  101028:	eb 16                	jmp    101040 <safestrcpy+0x30>
  10102a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
  101030:	0f b6 08             	movzbl (%eax),%ecx
  101033:	83 c0 01             	add    $0x1,%eax
  101036:	83 c2 01             	add    $0x1,%edx
  101039:	88 4a ff             	mov    %cl,-0x1(%edx)
  10103c:	84 c9                	test   %cl,%cl
  10103e:	74 04                	je     101044 <safestrcpy+0x34>
  101040:	39 d8                	cmp    %ebx,%eax
  101042:	75 ec                	jne    101030 <safestrcpy+0x20>
    ;
  *s = 0;
  101044:	c6 02 00             	movb   $0x0,(%edx)
  return os;
}
  101047:	89 f0                	mov    %esi,%eax
  101049:	5b                   	pop    %ebx
  10104a:	5e                   	pop    %esi
  10104b:	5d                   	pop    %ebp
  10104c:	c3                   	ret
  10104d:	8d 76 00             	lea    0x0(%esi),%esi

00101050 <strlen>:

int
strlen(const char *s)
{
  101050:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
  101051:	31 c0                	xor    %eax,%eax
{
  101053:	89 e5                	mov    %esp,%ebp
  101055:	8b 55 08             	mov    0x8(%ebp),%edx
  for(n = 0; s[n]; n++)
  101058:	80 3a 00             	cmpb   $0x0,(%edx)
  10105b:	74 0c                	je     101069 <strlen+0x19>
  10105d:	8d 76 00             	lea    0x0(%esi),%esi
  101060:	83 c0 01             	add    $0x1,%eax
  101063:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
  101067:	75 f7                	jne    101060 <strlen+0x10>
    ;
  return n;
}
  101069:	5d                   	pop    %ebp
  10106a:	c3                   	ret
  10106b:	66 90                	xchg   %ax,%ax
  10106d:	66 90                	xchg   %ax,%ax
  10106f:	90                   	nop

00101070 <mycpu>:

// Must be called with interrupts disabled to avoid the caller being
// rescheduled between reading lapicid and running through the loop.
struct cpu*
mycpu(void)
{
  101070:	55                   	push   %ebp
  101071:	89 e5                	mov    %esp,%ebp
  101073:	53                   	push   %ebx
  101074:	83 ec 04             	sub    $0x4,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
  101077:	9c                   	pushf
  101078:	58                   	pop    %eax
  int apicid, i;
  
  if(readeflags()&FL_IF)
  101079:	f6 c4 02             	test   $0x2,%ah
  10107c:	75 44                	jne    1010c2 <mycpu+0x52>
    panic("mycpu called with interrupts enabled\n");
  
  apicid = lapicid();
  10107e:	e8 ad f5 ff ff       	call   100630 <lapicid>
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i) {
  101083:	8b 1d c4 24 10 00    	mov    0x1024c4,%ebx
  101089:	85 db                	test   %ebx,%ebx
  10108b:	7e 28                	jle    1010b5 <mycpu+0x45>
  10108d:	31 d2                	xor    %edx,%edx
  10108f:	eb 0e                	jmp    10109f <mycpu+0x2f>
  101091:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  101098:	83 c2 01             	add    $0x1,%edx
  10109b:	39 da                	cmp    %ebx,%edx
  10109d:	74 16                	je     1010b5 <mycpu+0x45>
    if (cpus[i].apicid == apicid)
  10109f:	0f b6 8a c8 24 10 00 	movzbl 0x1024c8(%edx),%ecx
  1010a6:	39 c1                	cmp    %eax,%ecx
  1010a8:	75 ee                	jne    101098 <mycpu+0x28>
      return &cpus[i];
  }
  panic("unknown apicid\n");
  1010aa:	8b 5d fc             	mov    -0x4(%ebp),%ebx
      return &cpus[i];
  1010ad:	8d 82 c8 24 10 00    	lea    0x1024c8(%edx),%eax
  1010b3:	c9                   	leave
  1010b4:	c3                   	ret
  panic("unknown apicid\n");
  1010b5:	83 ec 0c             	sub    $0xc,%esp
  1010b8:	68 d0 1d 10 00       	push   $0x101dd0
  1010bd:	e8 6e f1 ff ff       	call   100230 <panic>
    panic("mycpu called with interrupts enabled\n");
  1010c2:	83 ec 0c             	sub    $0xc,%esp
  1010c5:	68 60 1e 10 00       	push   $0x101e60
  1010ca:	e8 61 f1 ff ff       	call   100230 <panic>
  1010cf:	90                   	nop

001010d0 <cpuid>:
cpuid() {
  1010d0:	55                   	push   %ebp
  1010d1:	89 e5                	mov    %esp,%ebp
  1010d3:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
  1010d6:	e8 95 ff ff ff       	call   101070 <mycpu>
}
  1010db:	c9                   	leave
  return mycpu()-cpus;
  1010dc:	2d c8 24 10 00       	sub    $0x1024c8,%eax
}
  1010e1:	c3                   	ret
  1010e2:	66 90                	xchg   %ax,%ax
  1010e4:	66 90                	xchg   %ax,%ax
  1010e6:	66 90                	xchg   %ax,%ax
  1010e8:	66 90                	xchg   %ax,%ax
  1010ea:	66 90                	xchg   %ax,%ax
  1010ec:	66 90                	xchg   %ax,%ax
  1010ee:	66 90                	xchg   %ax,%ax

001010f0 <getcallerpcs>:
// #include "memlayout.h"

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
  1010f0:	55                   	push   %ebp
  1010f1:	89 e5                	mov    %esp,%ebp
  1010f3:	53                   	push   %ebx
  1010f4:	8b 45 08             	mov    0x8(%ebp),%eax
  1010f7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
    // if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
    if(ebp == 0 || ebp == (uint*)0xffffffff)
  1010fa:	83 f8 07             	cmp    $0x7,%eax
  1010fd:	74 2e                	je     10112d <getcallerpcs+0x3d>
  1010ff:	8d 50 f8             	lea    -0x8(%eax),%edx
  for(i = 0; i < 10; i++){
  101102:	31 c0                	xor    %eax,%eax
  101104:	eb 12                	jmp    101118 <getcallerpcs+0x28>
  101106:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  10110d:	00 
  10110e:	66 90                	xchg   %ax,%ax
    if(ebp == 0 || ebp == (uint*)0xffffffff)
  101110:	8d 5a ff             	lea    -0x1(%edx),%ebx
  101113:	83 fb fd             	cmp    $0xfffffffd,%ebx
  101116:	77 18                	ja     101130 <getcallerpcs+0x40>
      break;
    pcs[i] = ebp[1];     // saved %eip
  101118:	8b 5a 04             	mov    0x4(%edx),%ebx
  10111b:	89 1c 81             	mov    %ebx,(%ecx,%eax,4)
  for(i = 0; i < 10; i++){
  10111e:	83 c0 01             	add    $0x1,%eax
    ebp = (uint*)ebp[0]; // saved %ebp
  101121:	8b 12                	mov    (%edx),%edx
  for(i = 0; i < 10; i++){
  101123:	83 f8 0a             	cmp    $0xa,%eax
  101126:	75 e8                	jne    101110 <getcallerpcs+0x20>
  }
  for(; i < 10; i++)
    pcs[i] = 0;
  101128:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  10112b:	c9                   	leave
  10112c:	c3                   	ret
  for(i = 0; i < 10; i++){
  10112d:	31 c0                	xor    %eax,%eax
  10112f:	90                   	nop
  101130:	8d 04 81             	lea    (%ecx,%eax,4),%eax
  101133:	83 c1 28             	add    $0x28,%ecx
  101136:	89 ca                	mov    %ecx,%edx
  101138:	29 c2                	sub    %eax,%edx
  10113a:	83 e2 04             	and    $0x4,%edx
  10113d:	74 11                	je     101150 <getcallerpcs+0x60>
    pcs[i] = 0;
  10113f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
  101145:	83 c0 04             	add    $0x4,%eax
  101148:	39 c1                	cmp    %eax,%ecx
  10114a:	74 dc                	je     101128 <getcallerpcs+0x38>
  10114c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    pcs[i] = 0;
  101150:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
  101156:	83 c0 08             	add    $0x8,%eax
    pcs[i] = 0;
  101159:	c7 40 fc 00 00 00 00 	movl   $0x0,-0x4(%eax)
  for(; i < 10; i++)
  101160:	39 c1                	cmp    %eax,%ecx
  101162:	75 ec                	jne    101150 <getcallerpcs+0x60>
  101164:	eb c2                	jmp    101128 <getcallerpcs+0x38>

00101166 <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushal
  101166:	60                   	pusha
  
  # Call trap(tf), where tf=%esp
  pushl %esp
  101167:	54                   	push   %esp
  call trap
  101168:	e8 83 00 00 00       	call   1011f0 <trap>
  addl $4, %esp
  10116d:	83 c4 04             	add    $0x4,%esp

00101170 <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
  101170:	61                   	popa
  addl $0x8, %esp  # trapno and errcode
  101171:	83 c4 08             	add    $0x8,%esp
  iret
  101174:	cf                   	iret
  101175:	66 90                	xchg   %ax,%ax
  101177:	66 90                	xchg   %ax,%ax
  101179:	66 90                	xchg   %ax,%ax
  10117b:	66 90                	xchg   %ax,%ax
  10117d:	66 90                	xchg   %ax,%ax
  10117f:	90                   	nop

00101180 <tvinit>:
void
tvinit(void)
{
  int i;

  for(i = 0; i < 256; i++)
  101180:	31 c0                	xor    %eax,%eax
  101182:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  101188:	8b 14 85 00 20 10 00 	mov    0x102000(,%eax,4),%edx
  10118f:	c7 04 c5 02 25 10 00 	movl   $0x8e000008,0x102502(,%eax,8)
  101196:	08 00 00 8e 
  10119a:	66 89 14 c5 00 25 10 	mov    %dx,0x102500(,%eax,8)
  1011a1:	00 
  1011a2:	c1 ea 10             	shr    $0x10,%edx
  1011a5:	66 89 14 c5 06 25 10 	mov    %dx,0x102506(,%eax,8)
  1011ac:	00 
  for(i = 0; i < 256; i++)
  1011ad:	83 c0 01             	add    $0x1,%eax
  1011b0:	3d 00 01 00 00       	cmp    $0x100,%eax
  1011b5:	75 d1                	jne    101188 <tvinit+0x8>
}
  1011b7:	c3                   	ret
  1011b8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  1011bf:	00 

001011c0 <idtinit>:

void
idtinit(void)
{
  1011c0:	55                   	push   %ebp
  pd[0] = size-1;
  1011c1:	b8 ff 07 00 00       	mov    $0x7ff,%eax
  1011c6:	89 e5                	mov    %esp,%ebp
  1011c8:	83 ec 10             	sub    $0x10,%esp
  1011cb:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
  1011cf:	b8 00 25 10 00       	mov    $0x102500,%eax
  1011d4:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
  1011d8:	c1 e8 10             	shr    $0x10,%eax
  1011db:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
  1011df:	8d 45 fa             	lea    -0x6(%ebp),%eax
  1011e2:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
  1011e5:	c9                   	leave
  1011e6:	c3                   	ret
  1011e7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  1011ee:	00 
  1011ef:	90                   	nop

001011f0 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
  1011f0:	55                   	push   %ebp
  1011f1:	89 e5                	mov    %esp,%ebp
  1011f3:	57                   	push   %edi
  1011f4:	56                   	push   %esi
  1011f5:	53                   	push   %ebx
  1011f6:	83 ec 0c             	sub    $0xc,%esp
  1011f9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  switch(tf->trapno){
  1011fc:	8b 43 20             	mov    0x20(%ebx),%eax
  1011ff:	83 e8 20             	sub    $0x20,%eax
  101202:	83 f8 1f             	cmp    $0x1f,%eax
  101205:	77 7c                	ja     101283 <trap+0x93>
  101207:	ff 24 85 e0 1e 10 00 	jmp    *0x101ee0(,%eax,4)
  10120e:	66 90                	xchg   %ax,%ax
      uartintr();
      lapiceoi();
      break;
    case T_IRQ0 + 7:
    case T_IRQ0 + IRQ_SPURIOUS:
      cprintf("cpu%d: spurious interrupt at %x:%x\n",
  101210:	8b 73 28             	mov    0x28(%ebx),%esi
  101213:	0f b7 5b 2c          	movzwl 0x2c(%ebx),%ebx
  101217:	e8 b4 fe ff ff       	call   1010d0 <cpuid>
  10121c:	56                   	push   %esi
  10121d:	53                   	push   %ebx
  10121e:	50                   	push   %eax
  10121f:	68 88 1e 10 00       	push   $0x101e88
  101224:	e8 87 ee ff ff       	call   1000b0 <cprintf>
              cpuid(), tf->cs, tf->eip);
      lapiceoi();
  101229:	83 c4 10             	add    $0x10,%esp
    default:
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
  }
}
  10122c:	8d 65 f4             	lea    -0xc(%ebp),%esp
  10122f:	5b                   	pop    %ebx
  101230:	5e                   	pop    %esi
  101231:	5f                   	pop    %edi
  101232:	5d                   	pop    %ebp
      lapiceoi();
  101233:	e9 18 f4 ff ff       	jmp    100650 <lapiceoi>
  101238:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  10123f:	00 
      mouseintr();
  101240:	e8 fb f5 ff ff       	call   100840 <mouseintr>
}
  101245:	8d 65 f4             	lea    -0xc(%ebp),%esp
  101248:	5b                   	pop    %ebx
  101249:	5e                   	pop    %esi
  10124a:	5f                   	pop    %edi
  10124b:	5d                   	pop    %ebp
      lapiceoi();
  10124c:	e9 ff f3 ff ff       	jmp    100650 <lapiceoi>
  101251:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      uartintr();
  101258:	e8 e3 fb ff ff       	call   100e40 <uartintr>
}
  10125d:	8d 65 f4             	lea    -0xc(%ebp),%esp
  101260:	5b                   	pop    %ebx
  101261:	5e                   	pop    %esi
  101262:	5f                   	pop    %edi
  101263:	5d                   	pop    %ebp
      lapiceoi();
  101264:	e9 e7 f3 ff ff       	jmp    100650 <lapiceoi>
  101269:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      ticks++;
  101270:	83 05 e0 24 10 00 01 	addl   $0x1,0x1024e0
}
  101277:	8d 65 f4             	lea    -0xc(%ebp),%esp
  10127a:	5b                   	pop    %ebx
  10127b:	5e                   	pop    %esi
  10127c:	5f                   	pop    %edi
  10127d:	5d                   	pop    %ebp
      lapiceoi();
  10127e:	e9 cd f3 ff ff       	jmp    100650 <lapiceoi>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
  101283:	0f 20 d7             	mov    %cr2,%edi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
  101286:	8b 73 28             	mov    0x28(%ebx),%esi
  101289:	e8 42 fe ff ff       	call   1010d0 <cpuid>
  10128e:	83 ec 0c             	sub    $0xc,%esp
  101291:	57                   	push   %edi
  101292:	56                   	push   %esi
  101293:	50                   	push   %eax
  101294:	ff 73 20             	push   0x20(%ebx)
  101297:	68 ac 1e 10 00       	push   $0x101eac
  10129c:	e8 0f ee ff ff       	call   1000b0 <cprintf>
      panic("trap");
  1012a1:	83 c4 14             	add    $0x14,%esp
  1012a4:	68 e0 1d 10 00       	push   $0x101de0
  1012a9:	e8 82 ef ff ff       	call   100230 <panic>

001012ae <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
  1012ae:	6a 00                	push   $0x0
  pushl $0
  1012b0:	6a 00                	push   $0x0
  jmp alltraps
  1012b2:	e9 af fe ff ff       	jmp    101166 <alltraps>

001012b7 <vector1>:
.globl vector1
vector1:
  pushl $0
  1012b7:	6a 00                	push   $0x0
  pushl $1
  1012b9:	6a 01                	push   $0x1
  jmp alltraps
  1012bb:	e9 a6 fe ff ff       	jmp    101166 <alltraps>

001012c0 <vector2>:
.globl vector2
vector2:
  pushl $0
  1012c0:	6a 00                	push   $0x0
  pushl $2
  1012c2:	6a 02                	push   $0x2
  jmp alltraps
  1012c4:	e9 9d fe ff ff       	jmp    101166 <alltraps>

001012c9 <vector3>:
.globl vector3
vector3:
  pushl $0
  1012c9:	6a 00                	push   $0x0
  pushl $3
  1012cb:	6a 03                	push   $0x3
  jmp alltraps
  1012cd:	e9 94 fe ff ff       	jmp    101166 <alltraps>

001012d2 <vector4>:
.globl vector4
vector4:
  pushl $0
  1012d2:	6a 00                	push   $0x0
  pushl $4
  1012d4:	6a 04                	push   $0x4
  jmp alltraps
  1012d6:	e9 8b fe ff ff       	jmp    101166 <alltraps>

001012db <vector5>:
.globl vector5
vector5:
  pushl $0
  1012db:	6a 00                	push   $0x0
  pushl $5
  1012dd:	6a 05                	push   $0x5
  jmp alltraps
  1012df:	e9 82 fe ff ff       	jmp    101166 <alltraps>

001012e4 <vector6>:
.globl vector6
vector6:
  pushl $0
  1012e4:	6a 00                	push   $0x0
  pushl $6
  1012e6:	6a 06                	push   $0x6
  jmp alltraps
  1012e8:	e9 79 fe ff ff       	jmp    101166 <alltraps>

001012ed <vector7>:
.globl vector7
vector7:
  pushl $0
  1012ed:	6a 00                	push   $0x0
  pushl $7
  1012ef:	6a 07                	push   $0x7
  jmp alltraps
  1012f1:	e9 70 fe ff ff       	jmp    101166 <alltraps>

001012f6 <vector8>:
.globl vector8
vector8:
  pushl $8
  1012f6:	6a 08                	push   $0x8
  jmp alltraps
  1012f8:	e9 69 fe ff ff       	jmp    101166 <alltraps>

001012fd <vector9>:
.globl vector9
vector9:
  pushl $0
  1012fd:	6a 00                	push   $0x0
  pushl $9
  1012ff:	6a 09                	push   $0x9
  jmp alltraps
  101301:	e9 60 fe ff ff       	jmp    101166 <alltraps>

00101306 <vector10>:
.globl vector10
vector10:
  pushl $10
  101306:	6a 0a                	push   $0xa
  jmp alltraps
  101308:	e9 59 fe ff ff       	jmp    101166 <alltraps>

0010130d <vector11>:
.globl vector11
vector11:
  pushl $11
  10130d:	6a 0b                	push   $0xb
  jmp alltraps
  10130f:	e9 52 fe ff ff       	jmp    101166 <alltraps>

00101314 <vector12>:
.globl vector12
vector12:
  pushl $12
  101314:	6a 0c                	push   $0xc
  jmp alltraps
  101316:	e9 4b fe ff ff       	jmp    101166 <alltraps>

0010131b <vector13>:
.globl vector13
vector13:
  pushl $13
  10131b:	6a 0d                	push   $0xd
  jmp alltraps
  10131d:	e9 44 fe ff ff       	jmp    101166 <alltraps>

00101322 <vector14>:
.globl vector14
vector14:
  pushl $14
  101322:	6a 0e                	push   $0xe
  jmp alltraps
  101324:	e9 3d fe ff ff       	jmp    101166 <alltraps>

00101329 <vector15>:
.globl vector15
vector15:
  pushl $0
  101329:	6a 00                	push   $0x0
  pushl $15
  10132b:	6a 0f                	push   $0xf
  jmp alltraps
  10132d:	e9 34 fe ff ff       	jmp    101166 <alltraps>

00101332 <vector16>:
.globl vector16
vector16:
  pushl $0
  101332:	6a 00                	push   $0x0
  pushl $16
  101334:	6a 10                	push   $0x10
  jmp alltraps
  101336:	e9 2b fe ff ff       	jmp    101166 <alltraps>

0010133b <vector17>:
.globl vector17
vector17:
  pushl $17
  10133b:	6a 11                	push   $0x11
  jmp alltraps
  10133d:	e9 24 fe ff ff       	jmp    101166 <alltraps>

00101342 <vector18>:
.globl vector18
vector18:
  pushl $0
  101342:	6a 00                	push   $0x0
  pushl $18
  101344:	6a 12                	push   $0x12
  jmp alltraps
  101346:	e9 1b fe ff ff       	jmp    101166 <alltraps>

0010134b <vector19>:
.globl vector19
vector19:
  pushl $0
  10134b:	6a 00                	push   $0x0
  pushl $19
  10134d:	6a 13                	push   $0x13
  jmp alltraps
  10134f:	e9 12 fe ff ff       	jmp    101166 <alltraps>

00101354 <vector20>:
.globl vector20
vector20:
  pushl $0
  101354:	6a 00                	push   $0x0
  pushl $20
  101356:	6a 14                	push   $0x14
  jmp alltraps
  101358:	e9 09 fe ff ff       	jmp    101166 <alltraps>

0010135d <vector21>:
.globl vector21
vector21:
  pushl $0
  10135d:	6a 00                	push   $0x0
  pushl $21
  10135f:	6a 15                	push   $0x15
  jmp alltraps
  101361:	e9 00 fe ff ff       	jmp    101166 <alltraps>

00101366 <vector22>:
.globl vector22
vector22:
  pushl $0
  101366:	6a 00                	push   $0x0
  pushl $22
  101368:	6a 16                	push   $0x16
  jmp alltraps
  10136a:	e9 f7 fd ff ff       	jmp    101166 <alltraps>

0010136f <vector23>:
.globl vector23
vector23:
  pushl $0
  10136f:	6a 00                	push   $0x0
  pushl $23
  101371:	6a 17                	push   $0x17
  jmp alltraps
  101373:	e9 ee fd ff ff       	jmp    101166 <alltraps>

00101378 <vector24>:
.globl vector24
vector24:
  pushl $0
  101378:	6a 00                	push   $0x0
  pushl $24
  10137a:	6a 18                	push   $0x18
  jmp alltraps
  10137c:	e9 e5 fd ff ff       	jmp    101166 <alltraps>

00101381 <vector25>:
.globl vector25
vector25:
  pushl $0
  101381:	6a 00                	push   $0x0
  pushl $25
  101383:	6a 19                	push   $0x19
  jmp alltraps
  101385:	e9 dc fd ff ff       	jmp    101166 <alltraps>

0010138a <vector26>:
.globl vector26
vector26:
  pushl $0
  10138a:	6a 00                	push   $0x0
  pushl $26
  10138c:	6a 1a                	push   $0x1a
  jmp alltraps
  10138e:	e9 d3 fd ff ff       	jmp    101166 <alltraps>

00101393 <vector27>:
.globl vector27
vector27:
  pushl $0
  101393:	6a 00                	push   $0x0
  pushl $27
  101395:	6a 1b                	push   $0x1b
  jmp alltraps
  101397:	e9 ca fd ff ff       	jmp    101166 <alltraps>

0010139c <vector28>:
.globl vector28
vector28:
  pushl $0
  10139c:	6a 00                	push   $0x0
  pushl $28
  10139e:	6a 1c                	push   $0x1c
  jmp alltraps
  1013a0:	e9 c1 fd ff ff       	jmp    101166 <alltraps>

001013a5 <vector29>:
.globl vector29
vector29:
  pushl $0
  1013a5:	6a 00                	push   $0x0
  pushl $29
  1013a7:	6a 1d                	push   $0x1d
  jmp alltraps
  1013a9:	e9 b8 fd ff ff       	jmp    101166 <alltraps>

001013ae <vector30>:
.globl vector30
vector30:
  pushl $0
  1013ae:	6a 00                	push   $0x0
  pushl $30
  1013b0:	6a 1e                	push   $0x1e
  jmp alltraps
  1013b2:	e9 af fd ff ff       	jmp    101166 <alltraps>

001013b7 <vector31>:
.globl vector31
vector31:
  pushl $0
  1013b7:	6a 00                	push   $0x0
  pushl $31
  1013b9:	6a 1f                	push   $0x1f
  jmp alltraps
  1013bb:	e9 a6 fd ff ff       	jmp    101166 <alltraps>

001013c0 <vector32>:
.globl vector32
vector32:
  pushl $0
  1013c0:	6a 00                	push   $0x0
  pushl $32
  1013c2:	6a 20                	push   $0x20
  jmp alltraps
  1013c4:	e9 9d fd ff ff       	jmp    101166 <alltraps>

001013c9 <vector33>:
.globl vector33
vector33:
  pushl $0
  1013c9:	6a 00                	push   $0x0
  pushl $33
  1013cb:	6a 21                	push   $0x21
  jmp alltraps
  1013cd:	e9 94 fd ff ff       	jmp    101166 <alltraps>

001013d2 <vector34>:
.globl vector34
vector34:
  pushl $0
  1013d2:	6a 00                	push   $0x0
  pushl $34
  1013d4:	6a 22                	push   $0x22
  jmp alltraps
  1013d6:	e9 8b fd ff ff       	jmp    101166 <alltraps>

001013db <vector35>:
.globl vector35
vector35:
  pushl $0
  1013db:	6a 00                	push   $0x0
  pushl $35
  1013dd:	6a 23                	push   $0x23
  jmp alltraps
  1013df:	e9 82 fd ff ff       	jmp    101166 <alltraps>

001013e4 <vector36>:
.globl vector36
vector36:
  pushl $0
  1013e4:	6a 00                	push   $0x0
  pushl $36
  1013e6:	6a 24                	push   $0x24
  jmp alltraps
  1013e8:	e9 79 fd ff ff       	jmp    101166 <alltraps>

001013ed <vector37>:
.globl vector37
vector37:
  pushl $0
  1013ed:	6a 00                	push   $0x0
  pushl $37
  1013ef:	6a 25                	push   $0x25
  jmp alltraps
  1013f1:	e9 70 fd ff ff       	jmp    101166 <alltraps>

001013f6 <vector38>:
.globl vector38
vector38:
  pushl $0
  1013f6:	6a 00                	push   $0x0
  pushl $38
  1013f8:	6a 26                	push   $0x26
  jmp alltraps
  1013fa:	e9 67 fd ff ff       	jmp    101166 <alltraps>

001013ff <vector39>:
.globl vector39
vector39:
  pushl $0
  1013ff:	6a 00                	push   $0x0
  pushl $39
  101401:	6a 27                	push   $0x27
  jmp alltraps
  101403:	e9 5e fd ff ff       	jmp    101166 <alltraps>

00101408 <vector40>:
.globl vector40
vector40:
  pushl $0
  101408:	6a 00                	push   $0x0
  pushl $40
  10140a:	6a 28                	push   $0x28
  jmp alltraps
  10140c:	e9 55 fd ff ff       	jmp    101166 <alltraps>

00101411 <vector41>:
.globl vector41
vector41:
  pushl $0
  101411:	6a 00                	push   $0x0
  pushl $41
  101413:	6a 29                	push   $0x29
  jmp alltraps
  101415:	e9 4c fd ff ff       	jmp    101166 <alltraps>

0010141a <vector42>:
.globl vector42
vector42:
  pushl $0
  10141a:	6a 00                	push   $0x0
  pushl $42
  10141c:	6a 2a                	push   $0x2a
  jmp alltraps
  10141e:	e9 43 fd ff ff       	jmp    101166 <alltraps>

00101423 <vector43>:
.globl vector43
vector43:
  pushl $0
  101423:	6a 00                	push   $0x0
  pushl $43
  101425:	6a 2b                	push   $0x2b
  jmp alltraps
  101427:	e9 3a fd ff ff       	jmp    101166 <alltraps>

0010142c <vector44>:
.globl vector44
vector44:
  pushl $0
  10142c:	6a 00                	push   $0x0
  pushl $44
  10142e:	6a 2c                	push   $0x2c
  jmp alltraps
  101430:	e9 31 fd ff ff       	jmp    101166 <alltraps>

00101435 <vector45>:
.globl vector45
vector45:
  pushl $0
  101435:	6a 00                	push   $0x0
  pushl $45
  101437:	6a 2d                	push   $0x2d
  jmp alltraps
  101439:	e9 28 fd ff ff       	jmp    101166 <alltraps>

0010143e <vector46>:
.globl vector46
vector46:
  pushl $0
  10143e:	6a 00                	push   $0x0
  pushl $46
  101440:	6a 2e                	push   $0x2e
  jmp alltraps
  101442:	e9 1f fd ff ff       	jmp    101166 <alltraps>

00101447 <vector47>:
.globl vector47
vector47:
  pushl $0
  101447:	6a 00                	push   $0x0
  pushl $47
  101449:	6a 2f                	push   $0x2f
  jmp alltraps
  10144b:	e9 16 fd ff ff       	jmp    101166 <alltraps>

00101450 <vector48>:
.globl vector48
vector48:
  pushl $0
  101450:	6a 00                	push   $0x0
  pushl $48
  101452:	6a 30                	push   $0x30
  jmp alltraps
  101454:	e9 0d fd ff ff       	jmp    101166 <alltraps>

00101459 <vector49>:
.globl vector49
vector49:
  pushl $0
  101459:	6a 00                	push   $0x0
  pushl $49
  10145b:	6a 31                	push   $0x31
  jmp alltraps
  10145d:	e9 04 fd ff ff       	jmp    101166 <alltraps>

00101462 <vector50>:
.globl vector50
vector50:
  pushl $0
  101462:	6a 00                	push   $0x0
  pushl $50
  101464:	6a 32                	push   $0x32
  jmp alltraps
  101466:	e9 fb fc ff ff       	jmp    101166 <alltraps>

0010146b <vector51>:
.globl vector51
vector51:
  pushl $0
  10146b:	6a 00                	push   $0x0
  pushl $51
  10146d:	6a 33                	push   $0x33
  jmp alltraps
  10146f:	e9 f2 fc ff ff       	jmp    101166 <alltraps>

00101474 <vector52>:
.globl vector52
vector52:
  pushl $0
  101474:	6a 00                	push   $0x0
  pushl $52
  101476:	6a 34                	push   $0x34
  jmp alltraps
  101478:	e9 e9 fc ff ff       	jmp    101166 <alltraps>

0010147d <vector53>:
.globl vector53
vector53:
  pushl $0
  10147d:	6a 00                	push   $0x0
  pushl $53
  10147f:	6a 35                	push   $0x35
  jmp alltraps
  101481:	e9 e0 fc ff ff       	jmp    101166 <alltraps>

00101486 <vector54>:
.globl vector54
vector54:
  pushl $0
  101486:	6a 00                	push   $0x0
  pushl $54
  101488:	6a 36                	push   $0x36
  jmp alltraps
  10148a:	e9 d7 fc ff ff       	jmp    101166 <alltraps>

0010148f <vector55>:
.globl vector55
vector55:
  pushl $0
  10148f:	6a 00                	push   $0x0
  pushl $55
  101491:	6a 37                	push   $0x37
  jmp alltraps
  101493:	e9 ce fc ff ff       	jmp    101166 <alltraps>

00101498 <vector56>:
.globl vector56
vector56:
  pushl $0
  101498:	6a 00                	push   $0x0
  pushl $56
  10149a:	6a 38                	push   $0x38
  jmp alltraps
  10149c:	e9 c5 fc ff ff       	jmp    101166 <alltraps>

001014a1 <vector57>:
.globl vector57
vector57:
  pushl $0
  1014a1:	6a 00                	push   $0x0
  pushl $57
  1014a3:	6a 39                	push   $0x39
  jmp alltraps
  1014a5:	e9 bc fc ff ff       	jmp    101166 <alltraps>

001014aa <vector58>:
.globl vector58
vector58:
  pushl $0
  1014aa:	6a 00                	push   $0x0
  pushl $58
  1014ac:	6a 3a                	push   $0x3a
  jmp alltraps
  1014ae:	e9 b3 fc ff ff       	jmp    101166 <alltraps>

001014b3 <vector59>:
.globl vector59
vector59:
  pushl $0
  1014b3:	6a 00                	push   $0x0
  pushl $59
  1014b5:	6a 3b                	push   $0x3b
  jmp alltraps
  1014b7:	e9 aa fc ff ff       	jmp    101166 <alltraps>

001014bc <vector60>:
.globl vector60
vector60:
  pushl $0
  1014bc:	6a 00                	push   $0x0
  pushl $60
  1014be:	6a 3c                	push   $0x3c
  jmp alltraps
  1014c0:	e9 a1 fc ff ff       	jmp    101166 <alltraps>

001014c5 <vector61>:
.globl vector61
vector61:
  pushl $0
  1014c5:	6a 00                	push   $0x0
  pushl $61
  1014c7:	6a 3d                	push   $0x3d
  jmp alltraps
  1014c9:	e9 98 fc ff ff       	jmp    101166 <alltraps>

001014ce <vector62>:
.globl vector62
vector62:
  pushl $0
  1014ce:	6a 00                	push   $0x0
  pushl $62
  1014d0:	6a 3e                	push   $0x3e
  jmp alltraps
  1014d2:	e9 8f fc ff ff       	jmp    101166 <alltraps>

001014d7 <vector63>:
.globl vector63
vector63:
  pushl $0
  1014d7:	6a 00                	push   $0x0
  pushl $63
  1014d9:	6a 3f                	push   $0x3f
  jmp alltraps
  1014db:	e9 86 fc ff ff       	jmp    101166 <alltraps>

001014e0 <vector64>:
.globl vector64
vector64:
  pushl $0
  1014e0:	6a 00                	push   $0x0
  pushl $64
  1014e2:	6a 40                	push   $0x40
  jmp alltraps
  1014e4:	e9 7d fc ff ff       	jmp    101166 <alltraps>

001014e9 <vector65>:
.globl vector65
vector65:
  pushl $0
  1014e9:	6a 00                	push   $0x0
  pushl $65
  1014eb:	6a 41                	push   $0x41
  jmp alltraps
  1014ed:	e9 74 fc ff ff       	jmp    101166 <alltraps>

001014f2 <vector66>:
.globl vector66
vector66:
  pushl $0
  1014f2:	6a 00                	push   $0x0
  pushl $66
  1014f4:	6a 42                	push   $0x42
  jmp alltraps
  1014f6:	e9 6b fc ff ff       	jmp    101166 <alltraps>

001014fb <vector67>:
.globl vector67
vector67:
  pushl $0
  1014fb:	6a 00                	push   $0x0
  pushl $67
  1014fd:	6a 43                	push   $0x43
  jmp alltraps
  1014ff:	e9 62 fc ff ff       	jmp    101166 <alltraps>

00101504 <vector68>:
.globl vector68
vector68:
  pushl $0
  101504:	6a 00                	push   $0x0
  pushl $68
  101506:	6a 44                	push   $0x44
  jmp alltraps
  101508:	e9 59 fc ff ff       	jmp    101166 <alltraps>

0010150d <vector69>:
.globl vector69
vector69:
  pushl $0
  10150d:	6a 00                	push   $0x0
  pushl $69
  10150f:	6a 45                	push   $0x45
  jmp alltraps
  101511:	e9 50 fc ff ff       	jmp    101166 <alltraps>

00101516 <vector70>:
.globl vector70
vector70:
  pushl $0
  101516:	6a 00                	push   $0x0
  pushl $70
  101518:	6a 46                	push   $0x46
  jmp alltraps
  10151a:	e9 47 fc ff ff       	jmp    101166 <alltraps>

0010151f <vector71>:
.globl vector71
vector71:
  pushl $0
  10151f:	6a 00                	push   $0x0
  pushl $71
  101521:	6a 47                	push   $0x47
  jmp alltraps
  101523:	e9 3e fc ff ff       	jmp    101166 <alltraps>

00101528 <vector72>:
.globl vector72
vector72:
  pushl $0
  101528:	6a 00                	push   $0x0
  pushl $72
  10152a:	6a 48                	push   $0x48
  jmp alltraps
  10152c:	e9 35 fc ff ff       	jmp    101166 <alltraps>

00101531 <vector73>:
.globl vector73
vector73:
  pushl $0
  101531:	6a 00                	push   $0x0
  pushl $73
  101533:	6a 49                	push   $0x49
  jmp alltraps
  101535:	e9 2c fc ff ff       	jmp    101166 <alltraps>

0010153a <vector74>:
.globl vector74
vector74:
  pushl $0
  10153a:	6a 00                	push   $0x0
  pushl $74
  10153c:	6a 4a                	push   $0x4a
  jmp alltraps
  10153e:	e9 23 fc ff ff       	jmp    101166 <alltraps>

00101543 <vector75>:
.globl vector75
vector75:
  pushl $0
  101543:	6a 00                	push   $0x0
  pushl $75
  101545:	6a 4b                	push   $0x4b
  jmp alltraps
  101547:	e9 1a fc ff ff       	jmp    101166 <alltraps>

0010154c <vector76>:
.globl vector76
vector76:
  pushl $0
  10154c:	6a 00                	push   $0x0
  pushl $76
  10154e:	6a 4c                	push   $0x4c
  jmp alltraps
  101550:	e9 11 fc ff ff       	jmp    101166 <alltraps>

00101555 <vector77>:
.globl vector77
vector77:
  pushl $0
  101555:	6a 00                	push   $0x0
  pushl $77
  101557:	6a 4d                	push   $0x4d
  jmp alltraps
  101559:	e9 08 fc ff ff       	jmp    101166 <alltraps>

0010155e <vector78>:
.globl vector78
vector78:
  pushl $0
  10155e:	6a 00                	push   $0x0
  pushl $78
  101560:	6a 4e                	push   $0x4e
  jmp alltraps
  101562:	e9 ff fb ff ff       	jmp    101166 <alltraps>

00101567 <vector79>:
.globl vector79
vector79:
  pushl $0
  101567:	6a 00                	push   $0x0
  pushl $79
  101569:	6a 4f                	push   $0x4f
  jmp alltraps
  10156b:	e9 f6 fb ff ff       	jmp    101166 <alltraps>

00101570 <vector80>:
.globl vector80
vector80:
  pushl $0
  101570:	6a 00                	push   $0x0
  pushl $80
  101572:	6a 50                	push   $0x50
  jmp alltraps
  101574:	e9 ed fb ff ff       	jmp    101166 <alltraps>

00101579 <vector81>:
.globl vector81
vector81:
  pushl $0
  101579:	6a 00                	push   $0x0
  pushl $81
  10157b:	6a 51                	push   $0x51
  jmp alltraps
  10157d:	e9 e4 fb ff ff       	jmp    101166 <alltraps>

00101582 <vector82>:
.globl vector82
vector82:
  pushl $0
  101582:	6a 00                	push   $0x0
  pushl $82
  101584:	6a 52                	push   $0x52
  jmp alltraps
  101586:	e9 db fb ff ff       	jmp    101166 <alltraps>

0010158b <vector83>:
.globl vector83
vector83:
  pushl $0
  10158b:	6a 00                	push   $0x0
  pushl $83
  10158d:	6a 53                	push   $0x53
  jmp alltraps
  10158f:	e9 d2 fb ff ff       	jmp    101166 <alltraps>

00101594 <vector84>:
.globl vector84
vector84:
  pushl $0
  101594:	6a 00                	push   $0x0
  pushl $84
  101596:	6a 54                	push   $0x54
  jmp alltraps
  101598:	e9 c9 fb ff ff       	jmp    101166 <alltraps>

0010159d <vector85>:
.globl vector85
vector85:
  pushl $0
  10159d:	6a 00                	push   $0x0
  pushl $85
  10159f:	6a 55                	push   $0x55
  jmp alltraps
  1015a1:	e9 c0 fb ff ff       	jmp    101166 <alltraps>

001015a6 <vector86>:
.globl vector86
vector86:
  pushl $0
  1015a6:	6a 00                	push   $0x0
  pushl $86
  1015a8:	6a 56                	push   $0x56
  jmp alltraps
  1015aa:	e9 b7 fb ff ff       	jmp    101166 <alltraps>

001015af <vector87>:
.globl vector87
vector87:
  pushl $0
  1015af:	6a 00                	push   $0x0
  pushl $87
  1015b1:	6a 57                	push   $0x57
  jmp alltraps
  1015b3:	e9 ae fb ff ff       	jmp    101166 <alltraps>

001015b8 <vector88>:
.globl vector88
vector88:
  pushl $0
  1015b8:	6a 00                	push   $0x0
  pushl $88
  1015ba:	6a 58                	push   $0x58
  jmp alltraps
  1015bc:	e9 a5 fb ff ff       	jmp    101166 <alltraps>

001015c1 <vector89>:
.globl vector89
vector89:
  pushl $0
  1015c1:	6a 00                	push   $0x0
  pushl $89
  1015c3:	6a 59                	push   $0x59
  jmp alltraps
  1015c5:	e9 9c fb ff ff       	jmp    101166 <alltraps>

001015ca <vector90>:
.globl vector90
vector90:
  pushl $0
  1015ca:	6a 00                	push   $0x0
  pushl $90
  1015cc:	6a 5a                	push   $0x5a
  jmp alltraps
  1015ce:	e9 93 fb ff ff       	jmp    101166 <alltraps>

001015d3 <vector91>:
.globl vector91
vector91:
  pushl $0
  1015d3:	6a 00                	push   $0x0
  pushl $91
  1015d5:	6a 5b                	push   $0x5b
  jmp alltraps
  1015d7:	e9 8a fb ff ff       	jmp    101166 <alltraps>

001015dc <vector92>:
.globl vector92
vector92:
  pushl $0
  1015dc:	6a 00                	push   $0x0
  pushl $92
  1015de:	6a 5c                	push   $0x5c
  jmp alltraps
  1015e0:	e9 81 fb ff ff       	jmp    101166 <alltraps>

001015e5 <vector93>:
.globl vector93
vector93:
  pushl $0
  1015e5:	6a 00                	push   $0x0
  pushl $93
  1015e7:	6a 5d                	push   $0x5d
  jmp alltraps
  1015e9:	e9 78 fb ff ff       	jmp    101166 <alltraps>

001015ee <vector94>:
.globl vector94
vector94:
  pushl $0
  1015ee:	6a 00                	push   $0x0
  pushl $94
  1015f0:	6a 5e                	push   $0x5e
  jmp alltraps
  1015f2:	e9 6f fb ff ff       	jmp    101166 <alltraps>

001015f7 <vector95>:
.globl vector95
vector95:
  pushl $0
  1015f7:	6a 00                	push   $0x0
  pushl $95
  1015f9:	6a 5f                	push   $0x5f
  jmp alltraps
  1015fb:	e9 66 fb ff ff       	jmp    101166 <alltraps>

00101600 <vector96>:
.globl vector96
vector96:
  pushl $0
  101600:	6a 00                	push   $0x0
  pushl $96
  101602:	6a 60                	push   $0x60
  jmp alltraps
  101604:	e9 5d fb ff ff       	jmp    101166 <alltraps>

00101609 <vector97>:
.globl vector97
vector97:
  pushl $0
  101609:	6a 00                	push   $0x0
  pushl $97
  10160b:	6a 61                	push   $0x61
  jmp alltraps
  10160d:	e9 54 fb ff ff       	jmp    101166 <alltraps>

00101612 <vector98>:
.globl vector98
vector98:
  pushl $0
  101612:	6a 00                	push   $0x0
  pushl $98
  101614:	6a 62                	push   $0x62
  jmp alltraps
  101616:	e9 4b fb ff ff       	jmp    101166 <alltraps>

0010161b <vector99>:
.globl vector99
vector99:
  pushl $0
  10161b:	6a 00                	push   $0x0
  pushl $99
  10161d:	6a 63                	push   $0x63
  jmp alltraps
  10161f:	e9 42 fb ff ff       	jmp    101166 <alltraps>

00101624 <vector100>:
.globl vector100
vector100:
  pushl $0
  101624:	6a 00                	push   $0x0
  pushl $100
  101626:	6a 64                	push   $0x64
  jmp alltraps
  101628:	e9 39 fb ff ff       	jmp    101166 <alltraps>

0010162d <vector101>:
.globl vector101
vector101:
  pushl $0
  10162d:	6a 00                	push   $0x0
  pushl $101
  10162f:	6a 65                	push   $0x65
  jmp alltraps
  101631:	e9 30 fb ff ff       	jmp    101166 <alltraps>

00101636 <vector102>:
.globl vector102
vector102:
  pushl $0
  101636:	6a 00                	push   $0x0
  pushl $102
  101638:	6a 66                	push   $0x66
  jmp alltraps
  10163a:	e9 27 fb ff ff       	jmp    101166 <alltraps>

0010163f <vector103>:
.globl vector103
vector103:
  pushl $0
  10163f:	6a 00                	push   $0x0
  pushl $103
  101641:	6a 67                	push   $0x67
  jmp alltraps
  101643:	e9 1e fb ff ff       	jmp    101166 <alltraps>

00101648 <vector104>:
.globl vector104
vector104:
  pushl $0
  101648:	6a 00                	push   $0x0
  pushl $104
  10164a:	6a 68                	push   $0x68
  jmp alltraps
  10164c:	e9 15 fb ff ff       	jmp    101166 <alltraps>

00101651 <vector105>:
.globl vector105
vector105:
  pushl $0
  101651:	6a 00                	push   $0x0
  pushl $105
  101653:	6a 69                	push   $0x69
  jmp alltraps
  101655:	e9 0c fb ff ff       	jmp    101166 <alltraps>

0010165a <vector106>:
.globl vector106
vector106:
  pushl $0
  10165a:	6a 00                	push   $0x0
  pushl $106
  10165c:	6a 6a                	push   $0x6a
  jmp alltraps
  10165e:	e9 03 fb ff ff       	jmp    101166 <alltraps>

00101663 <vector107>:
.globl vector107
vector107:
  pushl $0
  101663:	6a 00                	push   $0x0
  pushl $107
  101665:	6a 6b                	push   $0x6b
  jmp alltraps
  101667:	e9 fa fa ff ff       	jmp    101166 <alltraps>

0010166c <vector108>:
.globl vector108
vector108:
  pushl $0
  10166c:	6a 00                	push   $0x0
  pushl $108
  10166e:	6a 6c                	push   $0x6c
  jmp alltraps
  101670:	e9 f1 fa ff ff       	jmp    101166 <alltraps>

00101675 <vector109>:
.globl vector109
vector109:
  pushl $0
  101675:	6a 00                	push   $0x0
  pushl $109
  101677:	6a 6d                	push   $0x6d
  jmp alltraps
  101679:	e9 e8 fa ff ff       	jmp    101166 <alltraps>

0010167e <vector110>:
.globl vector110
vector110:
  pushl $0
  10167e:	6a 00                	push   $0x0
  pushl $110
  101680:	6a 6e                	push   $0x6e
  jmp alltraps
  101682:	e9 df fa ff ff       	jmp    101166 <alltraps>

00101687 <vector111>:
.globl vector111
vector111:
  pushl $0
  101687:	6a 00                	push   $0x0
  pushl $111
  101689:	6a 6f                	push   $0x6f
  jmp alltraps
  10168b:	e9 d6 fa ff ff       	jmp    101166 <alltraps>

00101690 <vector112>:
.globl vector112
vector112:
  pushl $0
  101690:	6a 00                	push   $0x0
  pushl $112
  101692:	6a 70                	push   $0x70
  jmp alltraps
  101694:	e9 cd fa ff ff       	jmp    101166 <alltraps>

00101699 <vector113>:
.globl vector113
vector113:
  pushl $0
  101699:	6a 00                	push   $0x0
  pushl $113
  10169b:	6a 71                	push   $0x71
  jmp alltraps
  10169d:	e9 c4 fa ff ff       	jmp    101166 <alltraps>

001016a2 <vector114>:
.globl vector114
vector114:
  pushl $0
  1016a2:	6a 00                	push   $0x0
  pushl $114
  1016a4:	6a 72                	push   $0x72
  jmp alltraps
  1016a6:	e9 bb fa ff ff       	jmp    101166 <alltraps>

001016ab <vector115>:
.globl vector115
vector115:
  pushl $0
  1016ab:	6a 00                	push   $0x0
  pushl $115
  1016ad:	6a 73                	push   $0x73
  jmp alltraps
  1016af:	e9 b2 fa ff ff       	jmp    101166 <alltraps>

001016b4 <vector116>:
.globl vector116
vector116:
  pushl $0
  1016b4:	6a 00                	push   $0x0
  pushl $116
  1016b6:	6a 74                	push   $0x74
  jmp alltraps
  1016b8:	e9 a9 fa ff ff       	jmp    101166 <alltraps>

001016bd <vector117>:
.globl vector117
vector117:
  pushl $0
  1016bd:	6a 00                	push   $0x0
  pushl $117
  1016bf:	6a 75                	push   $0x75
  jmp alltraps
  1016c1:	e9 a0 fa ff ff       	jmp    101166 <alltraps>

001016c6 <vector118>:
.globl vector118
vector118:
  pushl $0
  1016c6:	6a 00                	push   $0x0
  pushl $118
  1016c8:	6a 76                	push   $0x76
  jmp alltraps
  1016ca:	e9 97 fa ff ff       	jmp    101166 <alltraps>

001016cf <vector119>:
.globl vector119
vector119:
  pushl $0
  1016cf:	6a 00                	push   $0x0
  pushl $119
  1016d1:	6a 77                	push   $0x77
  jmp alltraps
  1016d3:	e9 8e fa ff ff       	jmp    101166 <alltraps>

001016d8 <vector120>:
.globl vector120
vector120:
  pushl $0
  1016d8:	6a 00                	push   $0x0
  pushl $120
  1016da:	6a 78                	push   $0x78
  jmp alltraps
  1016dc:	e9 85 fa ff ff       	jmp    101166 <alltraps>

001016e1 <vector121>:
.globl vector121
vector121:
  pushl $0
  1016e1:	6a 00                	push   $0x0
  pushl $121
  1016e3:	6a 79                	push   $0x79
  jmp alltraps
  1016e5:	e9 7c fa ff ff       	jmp    101166 <alltraps>

001016ea <vector122>:
.globl vector122
vector122:
  pushl $0
  1016ea:	6a 00                	push   $0x0
  pushl $122
  1016ec:	6a 7a                	push   $0x7a
  jmp alltraps
  1016ee:	e9 73 fa ff ff       	jmp    101166 <alltraps>

001016f3 <vector123>:
.globl vector123
vector123:
  pushl $0
  1016f3:	6a 00                	push   $0x0
  pushl $123
  1016f5:	6a 7b                	push   $0x7b
  jmp alltraps
  1016f7:	e9 6a fa ff ff       	jmp    101166 <alltraps>

001016fc <vector124>:
.globl vector124
vector124:
  pushl $0
  1016fc:	6a 00                	push   $0x0
  pushl $124
  1016fe:	6a 7c                	push   $0x7c
  jmp alltraps
  101700:	e9 61 fa ff ff       	jmp    101166 <alltraps>

00101705 <vector125>:
.globl vector125
vector125:
  pushl $0
  101705:	6a 00                	push   $0x0
  pushl $125
  101707:	6a 7d                	push   $0x7d
  jmp alltraps
  101709:	e9 58 fa ff ff       	jmp    101166 <alltraps>

0010170e <vector126>:
.globl vector126
vector126:
  pushl $0
  10170e:	6a 00                	push   $0x0
  pushl $126
  101710:	6a 7e                	push   $0x7e
  jmp alltraps
  101712:	e9 4f fa ff ff       	jmp    101166 <alltraps>

00101717 <vector127>:
.globl vector127
vector127:
  pushl $0
  101717:	6a 00                	push   $0x0
  pushl $127
  101719:	6a 7f                	push   $0x7f
  jmp alltraps
  10171b:	e9 46 fa ff ff       	jmp    101166 <alltraps>

00101720 <vector128>:
.globl vector128
vector128:
  pushl $0
  101720:	6a 00                	push   $0x0
  pushl $128
  101722:	68 80 00 00 00       	push   $0x80
  jmp alltraps
  101727:	e9 3a fa ff ff       	jmp    101166 <alltraps>

0010172c <vector129>:
.globl vector129
vector129:
  pushl $0
  10172c:	6a 00                	push   $0x0
  pushl $129
  10172e:	68 81 00 00 00       	push   $0x81
  jmp alltraps
  101733:	e9 2e fa ff ff       	jmp    101166 <alltraps>

00101738 <vector130>:
.globl vector130
vector130:
  pushl $0
  101738:	6a 00                	push   $0x0
  pushl $130
  10173a:	68 82 00 00 00       	push   $0x82
  jmp alltraps
  10173f:	e9 22 fa ff ff       	jmp    101166 <alltraps>

00101744 <vector131>:
.globl vector131
vector131:
  pushl $0
  101744:	6a 00                	push   $0x0
  pushl $131
  101746:	68 83 00 00 00       	push   $0x83
  jmp alltraps
  10174b:	e9 16 fa ff ff       	jmp    101166 <alltraps>

00101750 <vector132>:
.globl vector132
vector132:
  pushl $0
  101750:	6a 00                	push   $0x0
  pushl $132
  101752:	68 84 00 00 00       	push   $0x84
  jmp alltraps
  101757:	e9 0a fa ff ff       	jmp    101166 <alltraps>

0010175c <vector133>:
.globl vector133
vector133:
  pushl $0
  10175c:	6a 00                	push   $0x0
  pushl $133
  10175e:	68 85 00 00 00       	push   $0x85
  jmp alltraps
  101763:	e9 fe f9 ff ff       	jmp    101166 <alltraps>

00101768 <vector134>:
.globl vector134
vector134:
  pushl $0
  101768:	6a 00                	push   $0x0
  pushl $134
  10176a:	68 86 00 00 00       	push   $0x86
  jmp alltraps
  10176f:	e9 f2 f9 ff ff       	jmp    101166 <alltraps>

00101774 <vector135>:
.globl vector135
vector135:
  pushl $0
  101774:	6a 00                	push   $0x0
  pushl $135
  101776:	68 87 00 00 00       	push   $0x87
  jmp alltraps
  10177b:	e9 e6 f9 ff ff       	jmp    101166 <alltraps>

00101780 <vector136>:
.globl vector136
vector136:
  pushl $0
  101780:	6a 00                	push   $0x0
  pushl $136
  101782:	68 88 00 00 00       	push   $0x88
  jmp alltraps
  101787:	e9 da f9 ff ff       	jmp    101166 <alltraps>

0010178c <vector137>:
.globl vector137
vector137:
  pushl $0
  10178c:	6a 00                	push   $0x0
  pushl $137
  10178e:	68 89 00 00 00       	push   $0x89
  jmp alltraps
  101793:	e9 ce f9 ff ff       	jmp    101166 <alltraps>

00101798 <vector138>:
.globl vector138
vector138:
  pushl $0
  101798:	6a 00                	push   $0x0
  pushl $138
  10179a:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
  10179f:	e9 c2 f9 ff ff       	jmp    101166 <alltraps>

001017a4 <vector139>:
.globl vector139
vector139:
  pushl $0
  1017a4:	6a 00                	push   $0x0
  pushl $139
  1017a6:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
  1017ab:	e9 b6 f9 ff ff       	jmp    101166 <alltraps>

001017b0 <vector140>:
.globl vector140
vector140:
  pushl $0
  1017b0:	6a 00                	push   $0x0
  pushl $140
  1017b2:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
  1017b7:	e9 aa f9 ff ff       	jmp    101166 <alltraps>

001017bc <vector141>:
.globl vector141
vector141:
  pushl $0
  1017bc:	6a 00                	push   $0x0
  pushl $141
  1017be:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
  1017c3:	e9 9e f9 ff ff       	jmp    101166 <alltraps>

001017c8 <vector142>:
.globl vector142
vector142:
  pushl $0
  1017c8:	6a 00                	push   $0x0
  pushl $142
  1017ca:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
  1017cf:	e9 92 f9 ff ff       	jmp    101166 <alltraps>

001017d4 <vector143>:
.globl vector143
vector143:
  pushl $0
  1017d4:	6a 00                	push   $0x0
  pushl $143
  1017d6:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
  1017db:	e9 86 f9 ff ff       	jmp    101166 <alltraps>

001017e0 <vector144>:
.globl vector144
vector144:
  pushl $0
  1017e0:	6a 00                	push   $0x0
  pushl $144
  1017e2:	68 90 00 00 00       	push   $0x90
  jmp alltraps
  1017e7:	e9 7a f9 ff ff       	jmp    101166 <alltraps>

001017ec <vector145>:
.globl vector145
vector145:
  pushl $0
  1017ec:	6a 00                	push   $0x0
  pushl $145
  1017ee:	68 91 00 00 00       	push   $0x91
  jmp alltraps
  1017f3:	e9 6e f9 ff ff       	jmp    101166 <alltraps>

001017f8 <vector146>:
.globl vector146
vector146:
  pushl $0
  1017f8:	6a 00                	push   $0x0
  pushl $146
  1017fa:	68 92 00 00 00       	push   $0x92
  jmp alltraps
  1017ff:	e9 62 f9 ff ff       	jmp    101166 <alltraps>

00101804 <vector147>:
.globl vector147
vector147:
  pushl $0
  101804:	6a 00                	push   $0x0
  pushl $147
  101806:	68 93 00 00 00       	push   $0x93
  jmp alltraps
  10180b:	e9 56 f9 ff ff       	jmp    101166 <alltraps>

00101810 <vector148>:
.globl vector148
vector148:
  pushl $0
  101810:	6a 00                	push   $0x0
  pushl $148
  101812:	68 94 00 00 00       	push   $0x94
  jmp alltraps
  101817:	e9 4a f9 ff ff       	jmp    101166 <alltraps>

0010181c <vector149>:
.globl vector149
vector149:
  pushl $0
  10181c:	6a 00                	push   $0x0
  pushl $149
  10181e:	68 95 00 00 00       	push   $0x95
  jmp alltraps
  101823:	e9 3e f9 ff ff       	jmp    101166 <alltraps>

00101828 <vector150>:
.globl vector150
vector150:
  pushl $0
  101828:	6a 00                	push   $0x0
  pushl $150
  10182a:	68 96 00 00 00       	push   $0x96
  jmp alltraps
  10182f:	e9 32 f9 ff ff       	jmp    101166 <alltraps>

00101834 <vector151>:
.globl vector151
vector151:
  pushl $0
  101834:	6a 00                	push   $0x0
  pushl $151
  101836:	68 97 00 00 00       	push   $0x97
  jmp alltraps
  10183b:	e9 26 f9 ff ff       	jmp    101166 <alltraps>

00101840 <vector152>:
.globl vector152
vector152:
  pushl $0
  101840:	6a 00                	push   $0x0
  pushl $152
  101842:	68 98 00 00 00       	push   $0x98
  jmp alltraps
  101847:	e9 1a f9 ff ff       	jmp    101166 <alltraps>

0010184c <vector153>:
.globl vector153
vector153:
  pushl $0
  10184c:	6a 00                	push   $0x0
  pushl $153
  10184e:	68 99 00 00 00       	push   $0x99
  jmp alltraps
  101853:	e9 0e f9 ff ff       	jmp    101166 <alltraps>

00101858 <vector154>:
.globl vector154
vector154:
  pushl $0
  101858:	6a 00                	push   $0x0
  pushl $154
  10185a:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
  10185f:	e9 02 f9 ff ff       	jmp    101166 <alltraps>

00101864 <vector155>:
.globl vector155
vector155:
  pushl $0
  101864:	6a 00                	push   $0x0
  pushl $155
  101866:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
  10186b:	e9 f6 f8 ff ff       	jmp    101166 <alltraps>

00101870 <vector156>:
.globl vector156
vector156:
  pushl $0
  101870:	6a 00                	push   $0x0
  pushl $156
  101872:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
  101877:	e9 ea f8 ff ff       	jmp    101166 <alltraps>

0010187c <vector157>:
.globl vector157
vector157:
  pushl $0
  10187c:	6a 00                	push   $0x0
  pushl $157
  10187e:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
  101883:	e9 de f8 ff ff       	jmp    101166 <alltraps>

00101888 <vector158>:
.globl vector158
vector158:
  pushl $0
  101888:	6a 00                	push   $0x0
  pushl $158
  10188a:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
  10188f:	e9 d2 f8 ff ff       	jmp    101166 <alltraps>

00101894 <vector159>:
.globl vector159
vector159:
  pushl $0
  101894:	6a 00                	push   $0x0
  pushl $159
  101896:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
  10189b:	e9 c6 f8 ff ff       	jmp    101166 <alltraps>

001018a0 <vector160>:
.globl vector160
vector160:
  pushl $0
  1018a0:	6a 00                	push   $0x0
  pushl $160
  1018a2:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
  1018a7:	e9 ba f8 ff ff       	jmp    101166 <alltraps>

001018ac <vector161>:
.globl vector161
vector161:
  pushl $0
  1018ac:	6a 00                	push   $0x0
  pushl $161
  1018ae:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
  1018b3:	e9 ae f8 ff ff       	jmp    101166 <alltraps>

001018b8 <vector162>:
.globl vector162
vector162:
  pushl $0
  1018b8:	6a 00                	push   $0x0
  pushl $162
  1018ba:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
  1018bf:	e9 a2 f8 ff ff       	jmp    101166 <alltraps>

001018c4 <vector163>:
.globl vector163
vector163:
  pushl $0
  1018c4:	6a 00                	push   $0x0
  pushl $163
  1018c6:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
  1018cb:	e9 96 f8 ff ff       	jmp    101166 <alltraps>

001018d0 <vector164>:
.globl vector164
vector164:
  pushl $0
  1018d0:	6a 00                	push   $0x0
  pushl $164
  1018d2:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
  1018d7:	e9 8a f8 ff ff       	jmp    101166 <alltraps>

001018dc <vector165>:
.globl vector165
vector165:
  pushl $0
  1018dc:	6a 00                	push   $0x0
  pushl $165
  1018de:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
  1018e3:	e9 7e f8 ff ff       	jmp    101166 <alltraps>

001018e8 <vector166>:
.globl vector166
vector166:
  pushl $0
  1018e8:	6a 00                	push   $0x0
  pushl $166
  1018ea:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
  1018ef:	e9 72 f8 ff ff       	jmp    101166 <alltraps>

001018f4 <vector167>:
.globl vector167
vector167:
  pushl $0
  1018f4:	6a 00                	push   $0x0
  pushl $167
  1018f6:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
  1018fb:	e9 66 f8 ff ff       	jmp    101166 <alltraps>

00101900 <vector168>:
.globl vector168
vector168:
  pushl $0
  101900:	6a 00                	push   $0x0
  pushl $168
  101902:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
  101907:	e9 5a f8 ff ff       	jmp    101166 <alltraps>

0010190c <vector169>:
.globl vector169
vector169:
  pushl $0
  10190c:	6a 00                	push   $0x0
  pushl $169
  10190e:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
  101913:	e9 4e f8 ff ff       	jmp    101166 <alltraps>

00101918 <vector170>:
.globl vector170
vector170:
  pushl $0
  101918:	6a 00                	push   $0x0
  pushl $170
  10191a:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
  10191f:	e9 42 f8 ff ff       	jmp    101166 <alltraps>

00101924 <vector171>:
.globl vector171
vector171:
  pushl $0
  101924:	6a 00                	push   $0x0
  pushl $171
  101926:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
  10192b:	e9 36 f8 ff ff       	jmp    101166 <alltraps>

00101930 <vector172>:
.globl vector172
vector172:
  pushl $0
  101930:	6a 00                	push   $0x0
  pushl $172
  101932:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
  101937:	e9 2a f8 ff ff       	jmp    101166 <alltraps>

0010193c <vector173>:
.globl vector173
vector173:
  pushl $0
  10193c:	6a 00                	push   $0x0
  pushl $173
  10193e:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
  101943:	e9 1e f8 ff ff       	jmp    101166 <alltraps>

00101948 <vector174>:
.globl vector174
vector174:
  pushl $0
  101948:	6a 00                	push   $0x0
  pushl $174
  10194a:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
  10194f:	e9 12 f8 ff ff       	jmp    101166 <alltraps>

00101954 <vector175>:
.globl vector175
vector175:
  pushl $0
  101954:	6a 00                	push   $0x0
  pushl $175
  101956:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
  10195b:	e9 06 f8 ff ff       	jmp    101166 <alltraps>

00101960 <vector176>:
.globl vector176
vector176:
  pushl $0
  101960:	6a 00                	push   $0x0
  pushl $176
  101962:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
  101967:	e9 fa f7 ff ff       	jmp    101166 <alltraps>

0010196c <vector177>:
.globl vector177
vector177:
  pushl $0
  10196c:	6a 00                	push   $0x0
  pushl $177
  10196e:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
  101973:	e9 ee f7 ff ff       	jmp    101166 <alltraps>

00101978 <vector178>:
.globl vector178
vector178:
  pushl $0
  101978:	6a 00                	push   $0x0
  pushl $178
  10197a:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
  10197f:	e9 e2 f7 ff ff       	jmp    101166 <alltraps>

00101984 <vector179>:
.globl vector179
vector179:
  pushl $0
  101984:	6a 00                	push   $0x0
  pushl $179
  101986:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
  10198b:	e9 d6 f7 ff ff       	jmp    101166 <alltraps>

00101990 <vector180>:
.globl vector180
vector180:
  pushl $0
  101990:	6a 00                	push   $0x0
  pushl $180
  101992:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
  101997:	e9 ca f7 ff ff       	jmp    101166 <alltraps>

0010199c <vector181>:
.globl vector181
vector181:
  pushl $0
  10199c:	6a 00                	push   $0x0
  pushl $181
  10199e:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
  1019a3:	e9 be f7 ff ff       	jmp    101166 <alltraps>

001019a8 <vector182>:
.globl vector182
vector182:
  pushl $0
  1019a8:	6a 00                	push   $0x0
  pushl $182
  1019aa:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
  1019af:	e9 b2 f7 ff ff       	jmp    101166 <alltraps>

001019b4 <vector183>:
.globl vector183
vector183:
  pushl $0
  1019b4:	6a 00                	push   $0x0
  pushl $183
  1019b6:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
  1019bb:	e9 a6 f7 ff ff       	jmp    101166 <alltraps>

001019c0 <vector184>:
.globl vector184
vector184:
  pushl $0
  1019c0:	6a 00                	push   $0x0
  pushl $184
  1019c2:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
  1019c7:	e9 9a f7 ff ff       	jmp    101166 <alltraps>

001019cc <vector185>:
.globl vector185
vector185:
  pushl $0
  1019cc:	6a 00                	push   $0x0
  pushl $185
  1019ce:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
  1019d3:	e9 8e f7 ff ff       	jmp    101166 <alltraps>

001019d8 <vector186>:
.globl vector186
vector186:
  pushl $0
  1019d8:	6a 00                	push   $0x0
  pushl $186
  1019da:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
  1019df:	e9 82 f7 ff ff       	jmp    101166 <alltraps>

001019e4 <vector187>:
.globl vector187
vector187:
  pushl $0
  1019e4:	6a 00                	push   $0x0
  pushl $187
  1019e6:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
  1019eb:	e9 76 f7 ff ff       	jmp    101166 <alltraps>

001019f0 <vector188>:
.globl vector188
vector188:
  pushl $0
  1019f0:	6a 00                	push   $0x0
  pushl $188
  1019f2:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
  1019f7:	e9 6a f7 ff ff       	jmp    101166 <alltraps>

001019fc <vector189>:
.globl vector189
vector189:
  pushl $0
  1019fc:	6a 00                	push   $0x0
  pushl $189
  1019fe:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
  101a03:	e9 5e f7 ff ff       	jmp    101166 <alltraps>

00101a08 <vector190>:
.globl vector190
vector190:
  pushl $0
  101a08:	6a 00                	push   $0x0
  pushl $190
  101a0a:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
  101a0f:	e9 52 f7 ff ff       	jmp    101166 <alltraps>

00101a14 <vector191>:
.globl vector191
vector191:
  pushl $0
  101a14:	6a 00                	push   $0x0
  pushl $191
  101a16:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
  101a1b:	e9 46 f7 ff ff       	jmp    101166 <alltraps>

00101a20 <vector192>:
.globl vector192
vector192:
  pushl $0
  101a20:	6a 00                	push   $0x0
  pushl $192
  101a22:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
  101a27:	e9 3a f7 ff ff       	jmp    101166 <alltraps>

00101a2c <vector193>:
.globl vector193
vector193:
  pushl $0
  101a2c:	6a 00                	push   $0x0
  pushl $193
  101a2e:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
  101a33:	e9 2e f7 ff ff       	jmp    101166 <alltraps>

00101a38 <vector194>:
.globl vector194
vector194:
  pushl $0
  101a38:	6a 00                	push   $0x0
  pushl $194
  101a3a:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
  101a3f:	e9 22 f7 ff ff       	jmp    101166 <alltraps>

00101a44 <vector195>:
.globl vector195
vector195:
  pushl $0
  101a44:	6a 00                	push   $0x0
  pushl $195
  101a46:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
  101a4b:	e9 16 f7 ff ff       	jmp    101166 <alltraps>

00101a50 <vector196>:
.globl vector196
vector196:
  pushl $0
  101a50:	6a 00                	push   $0x0
  pushl $196
  101a52:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
  101a57:	e9 0a f7 ff ff       	jmp    101166 <alltraps>

00101a5c <vector197>:
.globl vector197
vector197:
  pushl $0
  101a5c:	6a 00                	push   $0x0
  pushl $197
  101a5e:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
  101a63:	e9 fe f6 ff ff       	jmp    101166 <alltraps>

00101a68 <vector198>:
.globl vector198
vector198:
  pushl $0
  101a68:	6a 00                	push   $0x0
  pushl $198
  101a6a:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
  101a6f:	e9 f2 f6 ff ff       	jmp    101166 <alltraps>

00101a74 <vector199>:
.globl vector199
vector199:
  pushl $0
  101a74:	6a 00                	push   $0x0
  pushl $199
  101a76:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
  101a7b:	e9 e6 f6 ff ff       	jmp    101166 <alltraps>

00101a80 <vector200>:
.globl vector200
vector200:
  pushl $0
  101a80:	6a 00                	push   $0x0
  pushl $200
  101a82:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
  101a87:	e9 da f6 ff ff       	jmp    101166 <alltraps>

00101a8c <vector201>:
.globl vector201
vector201:
  pushl $0
  101a8c:	6a 00                	push   $0x0
  pushl $201
  101a8e:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
  101a93:	e9 ce f6 ff ff       	jmp    101166 <alltraps>

00101a98 <vector202>:
.globl vector202
vector202:
  pushl $0
  101a98:	6a 00                	push   $0x0
  pushl $202
  101a9a:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
  101a9f:	e9 c2 f6 ff ff       	jmp    101166 <alltraps>

00101aa4 <vector203>:
.globl vector203
vector203:
  pushl $0
  101aa4:	6a 00                	push   $0x0
  pushl $203
  101aa6:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
  101aab:	e9 b6 f6 ff ff       	jmp    101166 <alltraps>

00101ab0 <vector204>:
.globl vector204
vector204:
  pushl $0
  101ab0:	6a 00                	push   $0x0
  pushl $204
  101ab2:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
  101ab7:	e9 aa f6 ff ff       	jmp    101166 <alltraps>

00101abc <vector205>:
.globl vector205
vector205:
  pushl $0
  101abc:	6a 00                	push   $0x0
  pushl $205
  101abe:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
  101ac3:	e9 9e f6 ff ff       	jmp    101166 <alltraps>

00101ac8 <vector206>:
.globl vector206
vector206:
  pushl $0
  101ac8:	6a 00                	push   $0x0
  pushl $206
  101aca:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
  101acf:	e9 92 f6 ff ff       	jmp    101166 <alltraps>

00101ad4 <vector207>:
.globl vector207
vector207:
  pushl $0
  101ad4:	6a 00                	push   $0x0
  pushl $207
  101ad6:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
  101adb:	e9 86 f6 ff ff       	jmp    101166 <alltraps>

00101ae0 <vector208>:
.globl vector208
vector208:
  pushl $0
  101ae0:	6a 00                	push   $0x0
  pushl $208
  101ae2:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
  101ae7:	e9 7a f6 ff ff       	jmp    101166 <alltraps>

00101aec <vector209>:
.globl vector209
vector209:
  pushl $0
  101aec:	6a 00                	push   $0x0
  pushl $209
  101aee:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
  101af3:	e9 6e f6 ff ff       	jmp    101166 <alltraps>

00101af8 <vector210>:
.globl vector210
vector210:
  pushl $0
  101af8:	6a 00                	push   $0x0
  pushl $210
  101afa:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
  101aff:	e9 62 f6 ff ff       	jmp    101166 <alltraps>

00101b04 <vector211>:
.globl vector211
vector211:
  pushl $0
  101b04:	6a 00                	push   $0x0
  pushl $211
  101b06:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
  101b0b:	e9 56 f6 ff ff       	jmp    101166 <alltraps>

00101b10 <vector212>:
.globl vector212
vector212:
  pushl $0
  101b10:	6a 00                	push   $0x0
  pushl $212
  101b12:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
  101b17:	e9 4a f6 ff ff       	jmp    101166 <alltraps>

00101b1c <vector213>:
.globl vector213
vector213:
  pushl $0
  101b1c:	6a 00                	push   $0x0
  pushl $213
  101b1e:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
  101b23:	e9 3e f6 ff ff       	jmp    101166 <alltraps>

00101b28 <vector214>:
.globl vector214
vector214:
  pushl $0
  101b28:	6a 00                	push   $0x0
  pushl $214
  101b2a:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
  101b2f:	e9 32 f6 ff ff       	jmp    101166 <alltraps>

00101b34 <vector215>:
.globl vector215
vector215:
  pushl $0
  101b34:	6a 00                	push   $0x0
  pushl $215
  101b36:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
  101b3b:	e9 26 f6 ff ff       	jmp    101166 <alltraps>

00101b40 <vector216>:
.globl vector216
vector216:
  pushl $0
  101b40:	6a 00                	push   $0x0
  pushl $216
  101b42:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
  101b47:	e9 1a f6 ff ff       	jmp    101166 <alltraps>

00101b4c <vector217>:
.globl vector217
vector217:
  pushl $0
  101b4c:	6a 00                	push   $0x0
  pushl $217
  101b4e:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
  101b53:	e9 0e f6 ff ff       	jmp    101166 <alltraps>

00101b58 <vector218>:
.globl vector218
vector218:
  pushl $0
  101b58:	6a 00                	push   $0x0
  pushl $218
  101b5a:	68 da 00 00 00       	push   $0xda
  jmp alltraps
  101b5f:	e9 02 f6 ff ff       	jmp    101166 <alltraps>

00101b64 <vector219>:
.globl vector219
vector219:
  pushl $0
  101b64:	6a 00                	push   $0x0
  pushl $219
  101b66:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
  101b6b:	e9 f6 f5 ff ff       	jmp    101166 <alltraps>

00101b70 <vector220>:
.globl vector220
vector220:
  pushl $0
  101b70:	6a 00                	push   $0x0
  pushl $220
  101b72:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
  101b77:	e9 ea f5 ff ff       	jmp    101166 <alltraps>

00101b7c <vector221>:
.globl vector221
vector221:
  pushl $0
  101b7c:	6a 00                	push   $0x0
  pushl $221
  101b7e:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
  101b83:	e9 de f5 ff ff       	jmp    101166 <alltraps>

00101b88 <vector222>:
.globl vector222
vector222:
  pushl $0
  101b88:	6a 00                	push   $0x0
  pushl $222
  101b8a:	68 de 00 00 00       	push   $0xde
  jmp alltraps
  101b8f:	e9 d2 f5 ff ff       	jmp    101166 <alltraps>

00101b94 <vector223>:
.globl vector223
vector223:
  pushl $0
  101b94:	6a 00                	push   $0x0
  pushl $223
  101b96:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
  101b9b:	e9 c6 f5 ff ff       	jmp    101166 <alltraps>

00101ba0 <vector224>:
.globl vector224
vector224:
  pushl $0
  101ba0:	6a 00                	push   $0x0
  pushl $224
  101ba2:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
  101ba7:	e9 ba f5 ff ff       	jmp    101166 <alltraps>

00101bac <vector225>:
.globl vector225
vector225:
  pushl $0
  101bac:	6a 00                	push   $0x0
  pushl $225
  101bae:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
  101bb3:	e9 ae f5 ff ff       	jmp    101166 <alltraps>

00101bb8 <vector226>:
.globl vector226
vector226:
  pushl $0
  101bb8:	6a 00                	push   $0x0
  pushl $226
  101bba:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
  101bbf:	e9 a2 f5 ff ff       	jmp    101166 <alltraps>

00101bc4 <vector227>:
.globl vector227
vector227:
  pushl $0
  101bc4:	6a 00                	push   $0x0
  pushl $227
  101bc6:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
  101bcb:	e9 96 f5 ff ff       	jmp    101166 <alltraps>

00101bd0 <vector228>:
.globl vector228
vector228:
  pushl $0
  101bd0:	6a 00                	push   $0x0
  pushl $228
  101bd2:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
  101bd7:	e9 8a f5 ff ff       	jmp    101166 <alltraps>

00101bdc <vector229>:
.globl vector229
vector229:
  pushl $0
  101bdc:	6a 00                	push   $0x0
  pushl $229
  101bde:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
  101be3:	e9 7e f5 ff ff       	jmp    101166 <alltraps>

00101be8 <vector230>:
.globl vector230
vector230:
  pushl $0
  101be8:	6a 00                	push   $0x0
  pushl $230
  101bea:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
  101bef:	e9 72 f5 ff ff       	jmp    101166 <alltraps>

00101bf4 <vector231>:
.globl vector231
vector231:
  pushl $0
  101bf4:	6a 00                	push   $0x0
  pushl $231
  101bf6:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
  101bfb:	e9 66 f5 ff ff       	jmp    101166 <alltraps>

00101c00 <vector232>:
.globl vector232
vector232:
  pushl $0
  101c00:	6a 00                	push   $0x0
  pushl $232
  101c02:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
  101c07:	e9 5a f5 ff ff       	jmp    101166 <alltraps>

00101c0c <vector233>:
.globl vector233
vector233:
  pushl $0
  101c0c:	6a 00                	push   $0x0
  pushl $233
  101c0e:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
  101c13:	e9 4e f5 ff ff       	jmp    101166 <alltraps>

00101c18 <vector234>:
.globl vector234
vector234:
  pushl $0
  101c18:	6a 00                	push   $0x0
  pushl $234
  101c1a:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
  101c1f:	e9 42 f5 ff ff       	jmp    101166 <alltraps>

00101c24 <vector235>:
.globl vector235
vector235:
  pushl $0
  101c24:	6a 00                	push   $0x0
  pushl $235
  101c26:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
  101c2b:	e9 36 f5 ff ff       	jmp    101166 <alltraps>

00101c30 <vector236>:
.globl vector236
vector236:
  pushl $0
  101c30:	6a 00                	push   $0x0
  pushl $236
  101c32:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
  101c37:	e9 2a f5 ff ff       	jmp    101166 <alltraps>

00101c3c <vector237>:
.globl vector237
vector237:
  pushl $0
  101c3c:	6a 00                	push   $0x0
  pushl $237
  101c3e:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
  101c43:	e9 1e f5 ff ff       	jmp    101166 <alltraps>

00101c48 <vector238>:
.globl vector238
vector238:
  pushl $0
  101c48:	6a 00                	push   $0x0
  pushl $238
  101c4a:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
  101c4f:	e9 12 f5 ff ff       	jmp    101166 <alltraps>

00101c54 <vector239>:
.globl vector239
vector239:
  pushl $0
  101c54:	6a 00                	push   $0x0
  pushl $239
  101c56:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
  101c5b:	e9 06 f5 ff ff       	jmp    101166 <alltraps>

00101c60 <vector240>:
.globl vector240
vector240:
  pushl $0
  101c60:	6a 00                	push   $0x0
  pushl $240
  101c62:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
  101c67:	e9 fa f4 ff ff       	jmp    101166 <alltraps>

00101c6c <vector241>:
.globl vector241
vector241:
  pushl $0
  101c6c:	6a 00                	push   $0x0
  pushl $241
  101c6e:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
  101c73:	e9 ee f4 ff ff       	jmp    101166 <alltraps>

00101c78 <vector242>:
.globl vector242
vector242:
  pushl $0
  101c78:	6a 00                	push   $0x0
  pushl $242
  101c7a:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
  101c7f:	e9 e2 f4 ff ff       	jmp    101166 <alltraps>

00101c84 <vector243>:
.globl vector243
vector243:
  pushl $0
  101c84:	6a 00                	push   $0x0
  pushl $243
  101c86:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
  101c8b:	e9 d6 f4 ff ff       	jmp    101166 <alltraps>

00101c90 <vector244>:
.globl vector244
vector244:
  pushl $0
  101c90:	6a 00                	push   $0x0
  pushl $244
  101c92:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
  101c97:	e9 ca f4 ff ff       	jmp    101166 <alltraps>

00101c9c <vector245>:
.globl vector245
vector245:
  pushl $0
  101c9c:	6a 00                	push   $0x0
  pushl $245
  101c9e:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
  101ca3:	e9 be f4 ff ff       	jmp    101166 <alltraps>

00101ca8 <vector246>:
.globl vector246
vector246:
  pushl $0
  101ca8:	6a 00                	push   $0x0
  pushl $246
  101caa:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
  101caf:	e9 b2 f4 ff ff       	jmp    101166 <alltraps>

00101cb4 <vector247>:
.globl vector247
vector247:
  pushl $0
  101cb4:	6a 00                	push   $0x0
  pushl $247
  101cb6:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
  101cbb:	e9 a6 f4 ff ff       	jmp    101166 <alltraps>

00101cc0 <vector248>:
.globl vector248
vector248:
  pushl $0
  101cc0:	6a 00                	push   $0x0
  pushl $248
  101cc2:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
  101cc7:	e9 9a f4 ff ff       	jmp    101166 <alltraps>

00101ccc <vector249>:
.globl vector249
vector249:
  pushl $0
  101ccc:	6a 00                	push   $0x0
  pushl $249
  101cce:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
  101cd3:	e9 8e f4 ff ff       	jmp    101166 <alltraps>

00101cd8 <vector250>:
.globl vector250
vector250:
  pushl $0
  101cd8:	6a 00                	push   $0x0
  pushl $250
  101cda:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
  101cdf:	e9 82 f4 ff ff       	jmp    101166 <alltraps>

00101ce4 <vector251>:
.globl vector251
vector251:
  pushl $0
  101ce4:	6a 00                	push   $0x0
  pushl $251
  101ce6:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
  101ceb:	e9 76 f4 ff ff       	jmp    101166 <alltraps>

00101cf0 <vector252>:
.globl vector252
vector252:
  pushl $0
  101cf0:	6a 00                	push   $0x0
  pushl $252
  101cf2:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
  101cf7:	e9 6a f4 ff ff       	jmp    101166 <alltraps>

00101cfc <vector253>:
.globl vector253
vector253:
  pushl $0
  101cfc:	6a 00                	push   $0x0
  pushl $253
  101cfe:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
  101d03:	e9 5e f4 ff ff       	jmp    101166 <alltraps>

00101d08 <vector254>:
.globl vector254
vector254:
  pushl $0
  101d08:	6a 00                	push   $0x0
  pushl $254
  101d0a:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
  101d0f:	e9 52 f4 ff ff       	jmp    101166 <alltraps>

00101d14 <vector255>:
.globl vector255
vector255:
  pushl $0
  101d14:	6a 00                	push   $0x0
  pushl $255
  101d16:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
  101d1b:	e9 46 f4 ff ff       	jmp    101166 <alltraps>
