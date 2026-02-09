
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
  10000c:	bc e0 3c 10 00       	mov    $0x103ce0,%esp

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
  10004b:	0f b6 92 50 1c 10 00 	movzbl 0x101c50(%edx),%edx
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
  10007f:	e8 2c 0c 00 00       	call   100cb0 <uartputc>
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
  10012a:	e8 81 0b 00 00       	call   100cb0 <uartputc>
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
  10015a:	e8 51 0b 00 00       	call   100cb0 <uartputc>
  10015f:	89 3c 24             	mov    %edi,(%esp)
  100162:	e8 49 0b 00 00       	call   100cb0 <uartputc>
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
  100197:	e8 14 0b 00 00       	call   100cb0 <uartputc>
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
  1001b8:	e8 f3 0a 00 00       	call   100cb0 <uartputc>
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
  1001f5:	bf d0 1b 10 00       	mov    $0x101bd0,%edi
  1001fa:	eb 94                	jmp    100190 <cprintf+0xe0>
  1001fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00100200 <halt>:
{
  100200:	55                   	push   %ebp
  100201:	89 e5                	mov    %esp,%ebp
  100203:	83 ec 10             	sub    $0x10,%esp
  cprintf("Bye COL%d!\n\0", 331);
  100206:	68 4b 01 00 00       	push   $0x14b
  10020b:	68 40 1c 10 00       	push   $0x101c40
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
  100248:	68 d7 1b 10 00       	push   $0x101bd7
  10024d:	e8 5e fe ff ff       	call   1000b0 <cprintf>
  cprintf(s);
  100252:	58                   	pop    %eax
  100253:	ff 75 08             	push   0x8(%ebp)
  100256:	e8 55 fe ff ff       	call   1000b0 <cprintf>
  cprintf("\n");
  10025b:	c7 04 24 29 1c 10 00 	movl   $0x101c29,(%esp)
  100262:	e8 49 fe ff ff       	call   1000b0 <cprintf>
  getcallerpcs(&s, pcs);
  100267:	8d 45 08             	lea    0x8(%ebp),%eax
  10026a:	5a                   	pop    %edx
  10026b:	59                   	pop    %ecx
  10026c:	53                   	push   %ebx
  10026d:	50                   	push   %eax
  10026e:	e8 2d 0d 00 00       	call   100fa0 <getcallerpcs>
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
  100288:	68 eb 1b 10 00       	push   $0x101beb
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
  100317:	e8 94 09 00 00       	call   100cb0 <uartputc>
  10031c:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
  100323:	e8 88 09 00 00       	call   100cb0 <uartputc>
  100328:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
  10032f:	e8 7c 09 00 00       	call   100cb0 <uartputc>
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
  100382:	e8 29 09 00 00       	call   100cb0 <uartputc>
  100387:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
  10038e:	e8 1d 09 00 00       	call   100cb0 <uartputc>
  100393:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
  10039a:	e8 11 09 00 00       	call   100cb0 <uartputc>
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
  1003ee:	e8 bd 08 00 00       	call   100cb0 <uartputc>
  1003f3:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
  1003fa:	e8 b1 08 00 00       	call   100cb0 <uartputc>
  1003ff:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
  100406:	e8 a5 08 00 00       	call   100cb0 <uartputc>
  10040b:	83 c4 10             	add    $0x10,%esp
  10040e:	e9 9d fe ff ff       	jmp    1002b0 <consoleintr+0x10>
    uartputc(c);
  100413:	83 ec 0c             	sub    $0xc,%esp
        input.buf[input.e++ % INPUT_BUF] = c;
  100416:	c6 82 00 24 10 00 0a 	movb   $0xa,0x102400(%edx)
    uartputc(c);
  10041d:	6a 0a                	push   $0xa
  10041f:	e8 8c 08 00 00       	call   100cb0 <uartputc>
          input.w = input.e;
  100424:	a1 88 24 10 00       	mov    0x102488,%eax
  100429:	83 c4 10             	add    $0x10,%esp
  10042c:	a3 84 24 10 00       	mov    %eax,0x102484
  100431:	e9 7a fe ff ff       	jmp    1002b0 <consoleintr+0x10>
    uartputc(c);
  100436:	83 ec 0c             	sub    $0xc,%esp
  100439:	50                   	push   %eax
  10043a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  10043d:	e8 6e 08 00 00       	call   100cb0 <uartputc>
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
  10048e:	0f b6 15 9c 24 10 00 	movzbl 0x10249c,%edx
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
  1004aa:	68 64 1c 10 00       	push   $0x101c64
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
  100686:	e8 15 03 00 00       	call   1009a0 <mpinit>
  lapicinit();     // interrupt controller
  10068b:	e8 b0 fe ff ff       	call   100540 <lapicinit>
  picinit();       // disable pic
  100690:	e8 db 04 00 00       	call   100b70 <picinit>
  ioapicinit();    // another interrupt controller
  100695:	e8 c6 fd ff ff       	call   100460 <ioapicinit>
  uartinit();      // serial port
  10069a:	e8 21 05 00 00       	call   100bc0 <uartinit>

  // Initialize the PS/2 mouse before enabling interrupts so that
  // IRQ12 is routed and the device is ready to report events.
  mouseinit();     // mouse initialization
  10069f:	e8 8c 00 00 00       	call   100730 <mouseinit>

  tvinit();        // trap vectors
  1006a4:	e8 87 09 00 00       	call   101030 <tvinit>
  idtinit();       // load idt register
  1006a9:	e8 c2 09 00 00       	call   101070 <idtinit>


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
    // you’re ready, and delete the #if 0 fences.

    // Drain all available bytes from the controller buffer. Each mouse
    // packet is 3 bytes long; bit 3 of byte 0 is always 1 and helps us
    // resynchronize if we ever lose alignment.
    while(inb(MSSTATP) & 0x01){
  100846:	a8 01                	test   $0x1,%al
  100848:	0f 84 d2 00 00 00    	je     100920 <mouseintr+0xe0>
{
  10084e:	55                   	push   %ebp
  10084f:	89 e5                	mov    %esp,%ebp
  100851:	57                   	push   %edi
  100852:	56                   	push   %esi
  100853:	be 60 00 00 00       	mov    $0x60,%esi
  100858:	53                   	push   %ebx
  100859:	bb 64 00 00 00       	mov    $0x64,%ebx
  10085e:	83 ec 0c             	sub    $0xc,%esp
  100861:	eb 23                	jmp    100886 <mouseintr+0x46>
  100863:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        uchar data = inb(MSDATAP);

        // If this should be the first byte, enforce the "always 1" bit.
        if(idx == 0 && (data & 0x08) == 0)
  100868:	a8 08                	test   $0x8,%al
  10086a:	74 0f                	je     10087b <mouseintr+0x3b>
            continue;

        packet[idx++] = data;
  10086c:	c7 05 98 24 10 00 01 	movl   $0x1,0x102498
  100873:	00 00 00 
  100876:	a2 94 24 10 00       	mov    %al,0x102494
  10087b:	89 da                	mov    %ebx,%edx
  10087d:	ec                   	in     (%dx),%al
    while(inb(MSSTATP) & 0x01){
  10087e:	a8 01                	test   $0x1,%al
  100880:	0f 84 8a 00 00 00    	je     100910 <mouseintr+0xd0>
  100886:	89 f2                	mov    %esi,%edx
  100888:	ec                   	in     (%dx),%al
        if(idx == 0 && (data & 0x08) == 0)
  100889:	8b 15 98 24 10 00    	mov    0x102498,%edx
  10088f:	85 d2                	test   %edx,%edx
  100891:	74 d5                	je     100868 <mouseintr+0x28>
        packet[idx++] = data;
  100893:	8d 4a 01             	lea    0x1(%edx),%ecx
  100896:	88 82 94 24 10 00    	mov    %al,0x102494(%edx)
  10089c:	89 0d 98 24 10 00    	mov    %ecx,0x102498
        if(idx < 3)
  1008a2:	83 f9 02             	cmp    $0x2,%ecx
  1008a5:	7e d4                	jle    10087b <mouseintr+0x3b>
        #endif

        // Buttons are in the low three bits of the first byte.
        // Print on rising edges to avoid repeated prints while held.
        {
            uchar buttons = packet[0] & 0x07;
  1008a7:	0f b6 3d 94 24 10 00 	movzbl 0x102494,%edi
        idx = 0;
  1008ae:	c7 05 98 24 10 00 00 	movl   $0x0,0x102498
  1008b5:	00 00 00 

            if(buttons & 0x01)
  1008b8:	f7 c7 01 00 00 00    	test   $0x1,%edi
  1008be:	75 38                	jne    1008f8 <mouseintr+0xb8>
                cprintf("LEFT\n");
            if(buttons & 0x02)
  1008c0:	f7 c7 02 00 00 00    	test   $0x2,%edi
  1008c6:	75 18                	jne    1008e0 <mouseintr+0xa0>
                cprintf("RIGHT\n");
            if(buttons & 0x04)
  1008c8:	83 e7 04             	and    $0x4,%edi
  1008cb:	74 ae                	je     10087b <mouseintr+0x3b>
                cprintf("MID\n");
  1008cd:	83 ec 0c             	sub    $0xc,%esp
  1008d0:	68 fc 1b 10 00       	push   $0x101bfc
  1008d5:	e8 d6 f7 ff ff       	call   1000b0 <cprintf>
  1008da:	83 c4 10             	add    $0x10,%esp
  1008dd:	eb 9c                	jmp    10087b <mouseintr+0x3b>
  1008df:	90                   	nop
                cprintf("RIGHT\n");
  1008e0:	83 ec 0c             	sub    $0xc,%esp
  1008e3:	68 f5 1b 10 00       	push   $0x101bf5
  1008e8:	e8 c3 f7 ff ff       	call   1000b0 <cprintf>
  1008ed:	83 c4 10             	add    $0x10,%esp
  1008f0:	eb d6                	jmp    1008c8 <mouseintr+0x88>
  1008f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
                cprintf("LEFT\n");
  1008f8:	83 ec 0c             	sub    $0xc,%esp
  1008fb:	68 ef 1b 10 00       	push   $0x101bef
  100900:	e8 ab f7 ff ff       	call   1000b0 <cprintf>
  100905:	83 c4 10             	add    $0x10,%esp
  100908:	eb b6                	jmp    1008c0 <mouseintr+0x80>
  10090a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        }
    }

    return;
  100910:	8d 65 f4             	lea    -0xc(%ebp),%esp
  100913:	5b                   	pop    %ebx
  100914:	5e                   	pop    %esi
  100915:	5f                   	pop    %edi
  100916:	5d                   	pop    %ebp
  100917:	c3                   	ret
  100918:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  10091f:	00 
  100920:	c3                   	ret
  100921:	66 90                	xchg   %ax,%ax
  100923:	66 90                	xchg   %ax,%ax
  100925:	66 90                	xchg   %ax,%ax
  100927:	66 90                	xchg   %ax,%ax
  100929:	66 90                	xchg   %ax,%ax
  10092b:	66 90                	xchg   %ax,%ax
  10092d:	66 90                	xchg   %ax,%ax
  10092f:	90                   	nop

00100930 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
  100930:	55                   	push   %ebp
  100931:	89 e5                	mov    %esp,%ebp
  100933:	57                   	push   %edi
  100934:	56                   	push   %esi
  100935:	53                   	push   %ebx
  uchar *e, *p, *addr;

  // addr = P2V(a);
  addr = (uchar*) a;
  e = addr+len;
  100936:	8d 1c 10             	lea    (%eax,%edx,1),%ebx
{
  100939:	83 ec 0c             	sub    $0xc,%esp
  for(p = addr; p < e; p += sizeof(struct mp))
  10093c:	39 d8                	cmp    %ebx,%eax
  10093e:	73 50                	jae    100990 <mpsearch1+0x60>
  100940:	89 c6                	mov    %eax,%esi
  100942:	eb 0a                	jmp    10094e <mpsearch1+0x1e>
  100944:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  100948:	89 fe                	mov    %edi,%esi
  10094a:	39 df                	cmp    %ebx,%edi
  10094c:	73 42                	jae    100990 <mpsearch1+0x60>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
  10094e:	83 ec 04             	sub    $0x4,%esp
  100951:	8d 7e 10             	lea    0x10(%esi),%edi
  100954:	6a 04                	push   $0x4
  100956:	68 01 1c 10 00       	push   $0x101c01
  10095b:	56                   	push   %esi
  10095c:	e8 ef 03 00 00       	call   100d50 <memcmp>
  100961:	83 c4 10             	add    $0x10,%esp
  100964:	85 c0                	test   %eax,%eax
  100966:	75 e0                	jne    100948 <mpsearch1+0x18>
  100968:	89 f2                	mov    %esi,%edx
  10096a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    sum += addr[i];
  100970:	0f b6 0a             	movzbl (%edx),%ecx
  for(i=0; i<len; i++)
  100973:	83 c2 01             	add    $0x1,%edx
    sum += addr[i];
  100976:	01 c8                	add    %ecx,%eax
  for(i=0; i<len; i++)
  100978:	39 fa                	cmp    %edi,%edx
  10097a:	75 f4                	jne    100970 <mpsearch1+0x40>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
  10097c:	84 c0                	test   %al,%al
  10097e:	75 c8                	jne    100948 <mpsearch1+0x18>
      return (struct mp*)p;
  return 0;
}
  100980:	8d 65 f4             	lea    -0xc(%ebp),%esp
  100983:	89 f0                	mov    %esi,%eax
  100985:	5b                   	pop    %ebx
  100986:	5e                   	pop    %esi
  100987:	5f                   	pop    %edi
  100988:	5d                   	pop    %ebp
  100989:	c3                   	ret
  10098a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  100990:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
  100993:	31 f6                	xor    %esi,%esi
}
  100995:	5b                   	pop    %ebx
  100996:	89 f0                	mov    %esi,%eax
  100998:	5e                   	pop    %esi
  100999:	5f                   	pop    %edi
  10099a:	5d                   	pop    %ebp
  10099b:	c3                   	ret
  10099c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

001009a0 <mpinit>:
  return conf;
}

void
mpinit(void)
{
  1009a0:	55                   	push   %ebp
  1009a1:	89 e5                	mov    %esp,%ebp
  1009a3:	57                   	push   %edi
  1009a4:	56                   	push   %esi
  1009a5:	53                   	push   %ebx
  1009a6:	83 ec 2c             	sub    $0x2c,%esp
  volatile uint addr = 0x400; 
  1009a9:	c7 45 e4 00 04 00 00 	movl   $0x400,-0x1c(%ebp)
  bda = (uchar*)(uint)addr;
  1009b0:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
  1009b3:	0f b7 42 0e          	movzwl 0xe(%edx),%eax
  1009b7:	c1 e0 04             	shl    $0x4,%eax
  1009ba:	75 0c                	jne    1009c8 <mpinit+0x28>
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
  1009bc:	0f b7 42 13          	movzwl 0x13(%edx),%eax
  1009c0:	c1 e0 0a             	shl    $0xa,%eax
    if((mp = mpsearch1(p-1024, 1024)))
  1009c3:	2d 00 04 00 00       	sub    $0x400,%eax
    if((mp = mpsearch1(p, 1024)))
  1009c8:	ba 00 04 00 00       	mov    $0x400,%edx
  1009cd:	e8 5e ff ff ff       	call   100930 <mpsearch1>
  1009d2:	89 c6                	mov    %eax,%esi
  1009d4:	85 c0                	test   %eax,%eax
  1009d6:	0f 84 2c 01 00 00    	je     100b08 <mpinit+0x168>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
  1009dc:	8b 5e 04             	mov    0x4(%esi),%ebx
  1009df:	85 db                	test   %ebx,%ebx
  1009e1:	0f 84 11 01 00 00    	je     100af8 <mpinit+0x158>
  if(memcmp(conf, "PCMP", 4) != 0)
  1009e7:	83 ec 04             	sub    $0x4,%esp
  1009ea:	6a 04                	push   $0x4
  1009ec:	68 06 1c 10 00       	push   $0x101c06
  1009f1:	53                   	push   %ebx
  1009f2:	e8 59 03 00 00       	call   100d50 <memcmp>
  1009f7:	83 c4 10             	add    $0x10,%esp
  1009fa:	85 c0                	test   %eax,%eax
  1009fc:	0f 85 f6 00 00 00    	jne    100af8 <mpinit+0x158>
  if(conf->version != 1 && conf->version != 4)
  100a02:	0f b6 43 06          	movzbl 0x6(%ebx),%eax
  100a06:	3c 01                	cmp    $0x1,%al
  100a08:	74 08                	je     100a12 <mpinit+0x72>
  100a0a:	3c 04                	cmp    $0x4,%al
  100a0c:	0f 85 e6 00 00 00    	jne    100af8 <mpinit+0x158>
  if(sum((uchar*)conf, conf->length) != 0)
  100a12:	0f b7 53 04          	movzwl 0x4(%ebx),%edx
  for(i=0; i<len; i++)
  100a16:	31 c9                	xor    %ecx,%ecx
  100a18:	66 85 d2             	test   %dx,%dx
  100a1b:	74 2a                	je     100a47 <mpinit+0xa7>
  sum = 0;
  100a1d:	89 75 d4             	mov    %esi,-0x2c(%ebp)
  100a20:	0f b7 ca             	movzwl %dx,%ecx
  100a23:	89 d8                	mov    %ebx,%eax
  100a25:	31 d2                	xor    %edx,%edx
  100a27:	8d 3c 0b             	lea    (%ebx,%ecx,1),%edi
  100a2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    sum += addr[i];
  100a30:	0f b6 30             	movzbl (%eax),%esi
  for(i=0; i<len; i++)
  100a33:	83 c0 01             	add    $0x1,%eax
    sum += addr[i];
  100a36:	01 f2                	add    %esi,%edx
  for(i=0; i<len; i++)
  100a38:	39 c7                	cmp    %eax,%edi
  100a3a:	75 f4                	jne    100a30 <mpinit+0x90>
  if(sum((uchar*)conf, conf->length) != 0)
  100a3c:	8b 75 d4             	mov    -0x2c(%ebp),%esi
  100a3f:	84 d2                	test   %dl,%dl
  100a41:	0f 85 b1 00 00 00    	jne    100af8 <mpinit+0x158>
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
  100a47:	8b 43 24             	mov    0x24(%ebx),%eax
  100a4a:	a3 90 24 10 00       	mov    %eax,0x102490
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
  100a4f:	8d 43 2c             	lea    0x2c(%ebx),%eax
  100a52:	01 cb                	add    %ecx,%ebx
  ismp = 1;
  100a54:	b9 01 00 00 00       	mov    $0x1,%ecx
  100a59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
  100a60:	39 d8                	cmp    %ebx,%eax
  100a62:	73 15                	jae    100a79 <mpinit+0xd9>
    switch(*p){
  100a64:	0f b6 10             	movzbl (%eax),%edx
  100a67:	80 fa 02             	cmp    $0x2,%dl
  100a6a:	74 74                	je     100ae0 <mpinit+0x140>
  100a6c:	77 62                	ja     100ad0 <mpinit+0x130>
  100a6e:	84 d2                	test   %dl,%dl
  100a70:	74 36                	je     100aa8 <mpinit+0x108>
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
  100a72:	83 c0 08             	add    $0x8,%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
  100a75:	39 d8                	cmp    %ebx,%eax
  100a77:	72 eb                	jb     100a64 <mpinit+0xc4>
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp)
  100a79:	85 c9                	test   %ecx,%ecx
  100a7b:	0f 84 d4 00 00 00    	je     100b55 <mpinit+0x1b5>
    panic("Didn't find a suitable machine");

  if(mp->imcrp){
  100a81:	80 7e 0c 00          	cmpb   $0x0,0xc(%esi)
  100a85:	74 15                	je     100a9c <mpinit+0xfc>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  100a87:	b8 70 00 00 00       	mov    $0x70,%eax
  100a8c:	ba 22 00 00 00       	mov    $0x22,%edx
  100a91:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
  100a92:	ba 23 00 00 00       	mov    $0x23,%edx
  100a97:	ec                   	in     (%dx),%al
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
  100a98:	83 c8 01             	or     $0x1,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  100a9b:	ee                   	out    %al,(%dx)
  }
}
  100a9c:	8d 65 f4             	lea    -0xc(%ebp),%esp
  100a9f:	5b                   	pop    %ebx
  100aa0:	5e                   	pop    %esi
  100aa1:	5f                   	pop    %edi
  100aa2:	5d                   	pop    %ebp
  100aa3:	c3                   	ret
  100aa4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if(ncpu < NCPU) {
  100aa8:	8b 3d a0 24 10 00    	mov    0x1024a0,%edi
  100aae:	83 ff 07             	cmp    $0x7,%edi
  100ab1:	7f 13                	jg     100ac6 <mpinit+0x126>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
  100ab3:	0f b6 50 01          	movzbl 0x1(%eax),%edx
        ncpu++;
  100ab7:	83 c7 01             	add    $0x1,%edi
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
  100aba:	88 97 a3 24 10 00    	mov    %dl,0x1024a3(%edi)
        ncpu++;
  100ac0:	89 3d a0 24 10 00    	mov    %edi,0x1024a0
      p += sizeof(struct mpproc);
  100ac6:	83 c0 14             	add    $0x14,%eax
      continue;
  100ac9:	eb 95                	jmp    100a60 <mpinit+0xc0>
  100acb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    switch(*p){
  100ad0:	83 ea 03             	sub    $0x3,%edx
  100ad3:	80 fa 01             	cmp    $0x1,%dl
  100ad6:	76 9a                	jbe    100a72 <mpinit+0xd2>
  100ad8:	31 c9                	xor    %ecx,%ecx
  100ada:	eb 84                	jmp    100a60 <mpinit+0xc0>
  100adc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      ioapicid = ioapic->apicno;
  100ae0:	0f b6 50 01          	movzbl 0x1(%eax),%edx
      p += sizeof(struct mpioapic);
  100ae4:	83 c0 08             	add    $0x8,%eax
      ioapicid = ioapic->apicno;
  100ae7:	88 15 9c 24 10 00    	mov    %dl,0x10249c
      continue;
  100aed:	e9 6e ff ff ff       	jmp    100a60 <mpinit+0xc0>
  100af2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    panic("Expect to run on an SMP");
  100af8:	83 ec 0c             	sub    $0xc,%esp
  100afb:	68 0b 1c 10 00       	push   $0x101c0b
  100b00:	e8 2b f7 ff ff       	call   100230 <panic>
  100b05:	8d 76 00             	lea    0x0(%esi),%esi
{
  100b08:	be 00 00 0f 00       	mov    $0xf0000,%esi
  100b0d:	eb 0b                	jmp    100b1a <mpinit+0x17a>
  100b0f:	90                   	nop
  for(p = addr; p < e; p += sizeof(struct mp))
  100b10:	89 de                	mov    %ebx,%esi
  100b12:	81 fb 00 00 10 00    	cmp    $0x100000,%ebx
  100b18:	74 de                	je     100af8 <mpinit+0x158>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
  100b1a:	83 ec 04             	sub    $0x4,%esp
  100b1d:	8d 5e 10             	lea    0x10(%esi),%ebx
  100b20:	6a 04                	push   $0x4
  100b22:	68 01 1c 10 00       	push   $0x101c01
  100b27:	56                   	push   %esi
  100b28:	e8 23 02 00 00       	call   100d50 <memcmp>
  100b2d:	83 c4 10             	add    $0x10,%esp
  100b30:	85 c0                	test   %eax,%eax
  100b32:	75 dc                	jne    100b10 <mpinit+0x170>
  100b34:	89 f2                	mov    %esi,%edx
  100b36:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  100b3d:	00 
  100b3e:	66 90                	xchg   %ax,%ax
    sum += addr[i];
  100b40:	0f b6 0a             	movzbl (%edx),%ecx
  for(i=0; i<len; i++)
  100b43:	83 c2 01             	add    $0x1,%edx
    sum += addr[i];
  100b46:	01 c8                	add    %ecx,%eax
  for(i=0; i<len; i++)
  100b48:	39 d3                	cmp    %edx,%ebx
  100b4a:	75 f4                	jne    100b40 <mpinit+0x1a0>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
  100b4c:	84 c0                	test   %al,%al
  100b4e:	75 c0                	jne    100b10 <mpinit+0x170>
  100b50:	e9 87 fe ff ff       	jmp    1009dc <mpinit+0x3c>
    panic("Didn't find a suitable machine");
  100b55:	83 ec 0c             	sub    $0xc,%esp
  100b58:	68 98 1c 10 00       	push   $0x101c98
  100b5d:	e8 ce f6 ff ff       	call   100230 <panic>
  100b62:	66 90                	xchg   %ax,%ax
  100b64:	66 90                	xchg   %ax,%ax
  100b66:	66 90                	xchg   %ax,%ax
  100b68:	66 90                	xchg   %ax,%ax
  100b6a:	66 90                	xchg   %ax,%ax
  100b6c:	66 90                	xchg   %ax,%ax
  100b6e:	66 90                	xchg   %ax,%ax

00100b70 <picinit>:
  100b70:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  100b75:	ba 21 00 00 00       	mov    $0x21,%edx
  100b7a:	ee                   	out    %al,(%dx)
  100b7b:	ba a1 00 00 00       	mov    $0xa1,%edx
  100b80:	ee                   	out    %al,(%dx)
picinit(void)
{
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
  outb(IO_PIC2+1, 0xFF);
}
  100b81:	c3                   	ret
  100b82:	66 90                	xchg   %ax,%ax
  100b84:	66 90                	xchg   %ax,%ax
  100b86:	66 90                	xchg   %ax,%ax
  100b88:	66 90                	xchg   %ax,%ax
  100b8a:	66 90                	xchg   %ax,%ax
  100b8c:	66 90                	xchg   %ax,%ax
  100b8e:	66 90                	xchg   %ax,%ax

00100b90 <uartgetc>:


static int
uartgetc(void)
{
  if(!uart)
  100b90:	a1 ac 24 10 00       	mov    0x1024ac,%eax
  100b95:	85 c0                	test   %eax,%eax
  100b97:	74 17                	je     100bb0 <uartgetc+0x20>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
  100b99:	ba fd 03 00 00       	mov    $0x3fd,%edx
  100b9e:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
  100b9f:	a8 01                	test   $0x1,%al
  100ba1:	74 0d                	je     100bb0 <uartgetc+0x20>
  100ba3:	ba f8 03 00 00       	mov    $0x3f8,%edx
  100ba8:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
  100ba9:	0f b6 c0             	movzbl %al,%eax
  100bac:	c3                   	ret
  100bad:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
  100bb0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  100bb5:	c3                   	ret
  100bb6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  100bbd:	00 
  100bbe:	66 90                	xchg   %ax,%ax

00100bc0 <uartinit>:
{
  100bc0:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  100bc1:	31 c9                	xor    %ecx,%ecx
  100bc3:	89 c8                	mov    %ecx,%eax
  100bc5:	89 e5                	mov    %esp,%ebp
  100bc7:	57                   	push   %edi
  100bc8:	bf fa 03 00 00       	mov    $0x3fa,%edi
  100bcd:	56                   	push   %esi
  100bce:	89 fa                	mov    %edi,%edx
  100bd0:	53                   	push   %ebx
  100bd1:	83 ec 0c             	sub    $0xc,%esp
  100bd4:	ee                   	out    %al,(%dx)
  100bd5:	be fb 03 00 00       	mov    $0x3fb,%esi
  100bda:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
  100bdf:	89 f2                	mov    %esi,%edx
  100be1:	ee                   	out    %al,(%dx)
  100be2:	b8 0c 00 00 00       	mov    $0xc,%eax
  100be7:	ba f8 03 00 00       	mov    $0x3f8,%edx
  100bec:	ee                   	out    %al,(%dx)
  100bed:	bb f9 03 00 00       	mov    $0x3f9,%ebx
  100bf2:	89 c8                	mov    %ecx,%eax
  100bf4:	89 da                	mov    %ebx,%edx
  100bf6:	ee                   	out    %al,(%dx)
  100bf7:	b8 03 00 00 00       	mov    $0x3,%eax
  100bfc:	89 f2                	mov    %esi,%edx
  100bfe:	ee                   	out    %al,(%dx)
  100bff:	ba fc 03 00 00       	mov    $0x3fc,%edx
  100c04:	89 c8                	mov    %ecx,%eax
  100c06:	ee                   	out    %al,(%dx)
  100c07:	b8 01 00 00 00       	mov    $0x1,%eax
  100c0c:	89 da                	mov    %ebx,%edx
  100c0e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
  100c0f:	ba fd 03 00 00       	mov    $0x3fd,%edx
  100c14:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
  100c15:	3c ff                	cmp    $0xff,%al
  100c17:	74 3d                	je     100c56 <uartinit+0x96>
  uart = 1;
  100c19:	c7 05 ac 24 10 00 01 	movl   $0x1,0x1024ac
  100c20:	00 00 00 
  100c23:	89 fa                	mov    %edi,%edx
  100c25:	ec                   	in     (%dx),%al
  100c26:	ba f8 03 00 00       	mov    $0x3f8,%edx
  100c2b:	ec                   	in     (%dx),%al
  ioapicenable(IRQ_COM1, 0);
  100c2c:	83 ec 08             	sub    $0x8,%esp
  for(p="xv6...\n"; *p; p++)
  100c2f:	be 23 1c 10 00       	mov    $0x101c23,%esi
  100c34:	bf 78 00 00 00       	mov    $0x78,%edi
  ioapicenable(IRQ_COM1, 0);
  100c39:	6a 00                	push   $0x0
  100c3b:	6a 04                	push   $0x4
  100c3d:	e8 be f8 ff ff       	call   100500 <ioapicenable>
  if(!uart)
  100c42:	a1 ac 24 10 00       	mov    0x1024ac,%eax
  100c47:	83 c4 10             	add    $0x10,%esp
  100c4a:	85 c0                	test   %eax,%eax
  100c4c:	75 10                	jne    100c5e <uartinit+0x9e>
  for(p="xv6...\n"; *p; p++)
  100c4e:	83 c6 01             	add    $0x1,%esi
  100c51:	80 3e 00             	cmpb   $0x0,(%esi)
  100c54:	75 f8                	jne    100c4e <uartinit+0x8e>
}
  100c56:	8d 65 f4             	lea    -0xc(%ebp),%esp
  100c59:	5b                   	pop    %ebx
  100c5a:	5e                   	pop    %esi
  100c5b:	5f                   	pop    %edi
  100c5c:	5d                   	pop    %ebp
  100c5d:	c3                   	ret
  100c5e:	bb fd 03 00 00       	mov    $0x3fd,%ebx
  100c63:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  100c68:	89 da                	mov    %ebx,%edx
  100c6a:	ec                   	in     (%dx),%al
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++);
  100c6b:	a8 20                	test   $0x20,%al
  100c6d:	75 15                	jne    100c84 <uartinit+0xc4>
  100c6f:	b9 80 00 00 00       	mov    $0x80,%ecx
  100c74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  100c78:	83 e9 01             	sub    $0x1,%ecx
  100c7b:	74 07                	je     100c84 <uartinit+0xc4>
  100c7d:	89 da                	mov    %ebx,%edx
  100c7f:	ec                   	in     (%dx),%al
  100c80:	a8 20                	test   $0x20,%al
  100c82:	74 f4                	je     100c78 <uartinit+0xb8>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  100c84:	ba f8 03 00 00       	mov    $0x3f8,%edx
  100c89:	89 f8                	mov    %edi,%eax
  100c8b:	ee                   	out    %al,(%dx)
  for(p="xv6...\n"; *p; p++)
  100c8c:	0f b6 7e 01          	movzbl 0x1(%esi),%edi
  100c90:	83 c6 01             	add    $0x1,%esi
  100c93:	89 f8                	mov    %edi,%eax
  100c95:	84 c0                	test   %al,%al
  100c97:	75 cf                	jne    100c68 <uartinit+0xa8>
}
  100c99:	8d 65 f4             	lea    -0xc(%ebp),%esp
  100c9c:	5b                   	pop    %ebx
  100c9d:	5e                   	pop    %esi
  100c9e:	5f                   	pop    %edi
  100c9f:	5d                   	pop    %ebp
  100ca0:	c3                   	ret
  100ca1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  100ca8:	00 
  100ca9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00100cb0 <uartputc>:
  if(!uart)
  100cb0:	a1 ac 24 10 00       	mov    0x1024ac,%eax
  100cb5:	85 c0                	test   %eax,%eax
  100cb7:	74 2f                	je     100ce8 <uartputc+0x38>
{
  100cb9:	55                   	push   %ebp
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
  100cba:	ba fd 03 00 00       	mov    $0x3fd,%edx
  100cbf:	89 e5                	mov    %esp,%ebp
  100cc1:	ec                   	in     (%dx),%al
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++);
  100cc2:	a8 20                	test   $0x20,%al
  100cc4:	75 14                	jne    100cda <uartputc+0x2a>
  100cc6:	b9 80 00 00 00       	mov    $0x80,%ecx
  100ccb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  100cd0:	83 e9 01             	sub    $0x1,%ecx
  100cd3:	74 05                	je     100cda <uartputc+0x2a>
  100cd5:	ec                   	in     (%dx),%al
  100cd6:	a8 20                	test   $0x20,%al
  100cd8:	74 f6                	je     100cd0 <uartputc+0x20>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  100cda:	8b 45 08             	mov    0x8(%ebp),%eax
  100cdd:	ba f8 03 00 00       	mov    $0x3f8,%edx
  100ce2:	ee                   	out    %al,(%dx)
}
  100ce3:	5d                   	pop    %ebp
  100ce4:	c3                   	ret
  100ce5:	8d 76 00             	lea    0x0(%esi),%esi
  100ce8:	c3                   	ret
  100ce9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00100cf0 <uartintr>:

void
uartintr(void)
{
  100cf0:	55                   	push   %ebp
  100cf1:	89 e5                	mov    %esp,%ebp
  100cf3:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
  100cf6:	68 90 0b 10 00       	push   $0x100b90
  100cfb:	e8 a0 f5 ff ff       	call   1002a0 <consoleintr>
  100d00:	83 c4 10             	add    $0x10,%esp
  100d03:	c9                   	leave
  100d04:	c3                   	ret
  100d05:	66 90                	xchg   %ax,%ax
  100d07:	66 90                	xchg   %ax,%ax
  100d09:	66 90                	xchg   %ax,%ax
  100d0b:	66 90                	xchg   %ax,%ax
  100d0d:	66 90                	xchg   %ax,%ax
  100d0f:	90                   	nop

00100d10 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
  100d10:	55                   	push   %ebp
  100d11:	89 e5                	mov    %esp,%ebp
  100d13:	57                   	push   %edi
  100d14:	8b 55 08             	mov    0x8(%ebp),%edx
  100d17:	8b 4d 10             	mov    0x10(%ebp),%ecx
  if ((int)dst%4 == 0 && n%4 == 0){
  100d1a:	89 d0                	mov    %edx,%eax
  100d1c:	09 c8                	or     %ecx,%eax
  100d1e:	a8 03                	test   $0x3,%al
  100d20:	75 1e                	jne    100d40 <memset+0x30>
    c &= 0xFF;
  100d22:	0f b6 45 0c          	movzbl 0xc(%ebp),%eax
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
  100d26:	c1 e9 02             	shr    $0x2,%ecx
  asm volatile("cld; rep stosl" :
  100d29:	89 d7                	mov    %edx,%edi
  100d2b:	69 c0 01 01 01 01    	imul   $0x1010101,%eax,%eax
  100d31:	fc                   	cld
  100d32:	f3 ab                	rep stos %eax,%es:(%edi)
  } else
    stosb(dst, c, n);
  return dst;
}
  100d34:	8b 7d fc             	mov    -0x4(%ebp),%edi
  100d37:	89 d0                	mov    %edx,%eax
  100d39:	c9                   	leave
  100d3a:	c3                   	ret
  100d3b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  asm volatile("cld; rep stosb" :
  100d40:	8b 45 0c             	mov    0xc(%ebp),%eax
  100d43:	89 d7                	mov    %edx,%edi
  100d45:	fc                   	cld
  100d46:	f3 aa                	rep stos %al,%es:(%edi)
  100d48:	8b 7d fc             	mov    -0x4(%ebp),%edi
  100d4b:	89 d0                	mov    %edx,%eax
  100d4d:	c9                   	leave
  100d4e:	c3                   	ret
  100d4f:	90                   	nop

00100d50 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
  100d50:	55                   	push   %ebp
  100d51:	89 e5                	mov    %esp,%ebp
  100d53:	56                   	push   %esi
  100d54:	8b 75 10             	mov    0x10(%ebp),%esi
  100d57:	8b 45 08             	mov    0x8(%ebp),%eax
  100d5a:	53                   	push   %ebx
  100d5b:	8b 55 0c             	mov    0xc(%ebp),%edx
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
  100d5e:	85 f6                	test   %esi,%esi
  100d60:	74 2e                	je     100d90 <memcmp+0x40>
  100d62:	01 c6                	add    %eax,%esi
  100d64:	eb 14                	jmp    100d7a <memcmp+0x2a>
  100d66:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  100d6d:	00 
  100d6e:	66 90                	xchg   %ax,%ax
    if(*s1 != *s2)
      return *s1 - *s2;
    s1++, s2++;
  100d70:	83 c0 01             	add    $0x1,%eax
  100d73:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0){
  100d76:	39 f0                	cmp    %esi,%eax
  100d78:	74 16                	je     100d90 <memcmp+0x40>
    if(*s1 != *s2)
  100d7a:	0f b6 08             	movzbl (%eax),%ecx
  100d7d:	0f b6 1a             	movzbl (%edx),%ebx
  100d80:	38 d9                	cmp    %bl,%cl
  100d82:	74 ec                	je     100d70 <memcmp+0x20>
      return *s1 - *s2;
  100d84:	0f b6 c1             	movzbl %cl,%eax
  100d87:	29 d8                	sub    %ebx,%eax
  }

  return 0;
}
  100d89:	5b                   	pop    %ebx
  100d8a:	5e                   	pop    %esi
  100d8b:	5d                   	pop    %ebp
  100d8c:	c3                   	ret
  100d8d:	8d 76 00             	lea    0x0(%esi),%esi
  100d90:	5b                   	pop    %ebx
  return 0;
  100d91:	31 c0                	xor    %eax,%eax
}
  100d93:	5e                   	pop    %esi
  100d94:	5d                   	pop    %ebp
  100d95:	c3                   	ret
  100d96:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  100d9d:	00 
  100d9e:	66 90                	xchg   %ax,%ax

00100da0 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
  100da0:	55                   	push   %ebp
  100da1:	89 e5                	mov    %esp,%ebp
  100da3:	57                   	push   %edi
  100da4:	8b 55 08             	mov    0x8(%ebp),%edx
  100da7:	8b 45 10             	mov    0x10(%ebp),%eax
  100daa:	56                   	push   %esi
  100dab:	8b 75 0c             	mov    0xc(%ebp),%esi
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
  100dae:	39 d6                	cmp    %edx,%esi
  100db0:	73 26                	jae    100dd8 <memmove+0x38>
  100db2:	8d 0c 06             	lea    (%esi,%eax,1),%ecx
  100db5:	39 ca                	cmp    %ecx,%edx
  100db7:	73 1f                	jae    100dd8 <memmove+0x38>
    s += n;
    d += n;
    while(n-- > 0)
  100db9:	85 c0                	test   %eax,%eax
  100dbb:	74 0f                	je     100dcc <memmove+0x2c>
  100dbd:	83 e8 01             	sub    $0x1,%eax
      *--d = *--s;
  100dc0:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
  100dc4:	88 0c 02             	mov    %cl,(%edx,%eax,1)
    while(n-- > 0)
  100dc7:	83 e8 01             	sub    $0x1,%eax
  100dca:	73 f4                	jae    100dc0 <memmove+0x20>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
  100dcc:	5e                   	pop    %esi
  100dcd:	89 d0                	mov    %edx,%eax
  100dcf:	5f                   	pop    %edi
  100dd0:	5d                   	pop    %ebp
  100dd1:	c3                   	ret
  100dd2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    while(n-- > 0)
  100dd8:	8d 0c 06             	lea    (%esi,%eax,1),%ecx
  100ddb:	89 d7                	mov    %edx,%edi
  100ddd:	85 c0                	test   %eax,%eax
  100ddf:	74 eb                	je     100dcc <memmove+0x2c>
  100de1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      *d++ = *s++;
  100de8:	a4                   	movsb  %ds:(%esi),%es:(%edi)
    while(n-- > 0)
  100de9:	39 ce                	cmp    %ecx,%esi
  100deb:	75 fb                	jne    100de8 <memmove+0x48>
}
  100ded:	5e                   	pop    %esi
  100dee:	89 d0                	mov    %edx,%eax
  100df0:	5f                   	pop    %edi
  100df1:	5d                   	pop    %ebp
  100df2:	c3                   	ret
  100df3:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  100dfa:	00 
  100dfb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

00100e00 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
  return memmove(dst, src, n);
  100e00:	eb 9e                	jmp    100da0 <memmove>
  100e02:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  100e09:	00 
  100e0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00100e10 <strncmp>:
}

int
strncmp(const char *p, const char *q, uint n)
{
  100e10:	55                   	push   %ebp
  100e11:	89 e5                	mov    %esp,%ebp
  100e13:	53                   	push   %ebx
  100e14:	8b 55 10             	mov    0x10(%ebp),%edx
  100e17:	8b 45 08             	mov    0x8(%ebp),%eax
  100e1a:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(n > 0 && *p && *p == *q)
  100e1d:	85 d2                	test   %edx,%edx
  100e1f:	75 16                	jne    100e37 <strncmp+0x27>
  100e21:	eb 2d                	jmp    100e50 <strncmp+0x40>
  100e23:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  100e28:	3a 19                	cmp    (%ecx),%bl
  100e2a:	75 12                	jne    100e3e <strncmp+0x2e>
    n--, p++, q++;
  100e2c:	83 c0 01             	add    $0x1,%eax
  100e2f:	83 c1 01             	add    $0x1,%ecx
  while(n > 0 && *p && *p == *q)
  100e32:	83 ea 01             	sub    $0x1,%edx
  100e35:	74 19                	je     100e50 <strncmp+0x40>
  100e37:	0f b6 18             	movzbl (%eax),%ebx
  100e3a:	84 db                	test   %bl,%bl
  100e3c:	75 ea                	jne    100e28 <strncmp+0x18>
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
  100e3e:	0f b6 00             	movzbl (%eax),%eax
  100e41:	0f b6 11             	movzbl (%ecx),%edx
}
  100e44:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  100e47:	c9                   	leave
  return (uchar)*p - (uchar)*q;
  100e48:	29 d0                	sub    %edx,%eax
}
  100e4a:	c3                   	ret
  100e4b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  100e50:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return 0;
  100e53:	31 c0                	xor    %eax,%eax
}
  100e55:	c9                   	leave
  100e56:	c3                   	ret
  100e57:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  100e5e:	00 
  100e5f:	90                   	nop

00100e60 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
  100e60:	55                   	push   %ebp
  100e61:	89 e5                	mov    %esp,%ebp
  100e63:	57                   	push   %edi
  100e64:	56                   	push   %esi
  100e65:	8b 75 08             	mov    0x8(%ebp),%esi
  100e68:	53                   	push   %ebx
  100e69:	8b 55 10             	mov    0x10(%ebp),%edx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
  100e6c:	89 f0                	mov    %esi,%eax
  100e6e:	eb 15                	jmp    100e85 <strncpy+0x25>
  100e70:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  100e74:	8b 7d 0c             	mov    0xc(%ebp),%edi
  100e77:	83 c0 01             	add    $0x1,%eax
  100e7a:	0f b6 4f ff          	movzbl -0x1(%edi),%ecx
  100e7e:	88 48 ff             	mov    %cl,-0x1(%eax)
  100e81:	84 c9                	test   %cl,%cl
  100e83:	74 13                	je     100e98 <strncpy+0x38>
  100e85:	89 d3                	mov    %edx,%ebx
  100e87:	83 ea 01             	sub    $0x1,%edx
  100e8a:	85 db                	test   %ebx,%ebx
  100e8c:	7f e2                	jg     100e70 <strncpy+0x10>
    ;
  while(n-- > 0)
    *s++ = 0;
  return os;
}
  100e8e:	5b                   	pop    %ebx
  100e8f:	89 f0                	mov    %esi,%eax
  100e91:	5e                   	pop    %esi
  100e92:	5f                   	pop    %edi
  100e93:	5d                   	pop    %ebp
  100e94:	c3                   	ret
  100e95:	8d 76 00             	lea    0x0(%esi),%esi
  while(n-- > 0)
  100e98:	8d 0c 18             	lea    (%eax,%ebx,1),%ecx
  100e9b:	83 e9 01             	sub    $0x1,%ecx
  100e9e:	85 d2                	test   %edx,%edx
  100ea0:	74 ec                	je     100e8e <strncpy+0x2e>
  100ea2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    *s++ = 0;
  100ea8:	83 c0 01             	add    $0x1,%eax
  100eab:	89 ca                	mov    %ecx,%edx
  100ead:	c6 40 ff 00          	movb   $0x0,-0x1(%eax)
  while(n-- > 0)
  100eb1:	29 c2                	sub    %eax,%edx
  100eb3:	85 d2                	test   %edx,%edx
  100eb5:	7f f1                	jg     100ea8 <strncpy+0x48>
}
  100eb7:	5b                   	pop    %ebx
  100eb8:	89 f0                	mov    %esi,%eax
  100eba:	5e                   	pop    %esi
  100ebb:	5f                   	pop    %edi
  100ebc:	5d                   	pop    %ebp
  100ebd:	c3                   	ret
  100ebe:	66 90                	xchg   %ax,%ax

00100ec0 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
  100ec0:	55                   	push   %ebp
  100ec1:	89 e5                	mov    %esp,%ebp
  100ec3:	56                   	push   %esi
  100ec4:	8b 55 10             	mov    0x10(%ebp),%edx
  100ec7:	8b 75 08             	mov    0x8(%ebp),%esi
  100eca:	53                   	push   %ebx
  100ecb:	8b 45 0c             	mov    0xc(%ebp),%eax
  char *os;

  os = s;
  if(n <= 0)
  100ece:	85 d2                	test   %edx,%edx
  100ed0:	7e 25                	jle    100ef7 <safestrcpy+0x37>
  100ed2:	8d 5c 10 ff          	lea    -0x1(%eax,%edx,1),%ebx
  100ed6:	89 f2                	mov    %esi,%edx
  100ed8:	eb 16                	jmp    100ef0 <safestrcpy+0x30>
  100eda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
  100ee0:	0f b6 08             	movzbl (%eax),%ecx
  100ee3:	83 c0 01             	add    $0x1,%eax
  100ee6:	83 c2 01             	add    $0x1,%edx
  100ee9:	88 4a ff             	mov    %cl,-0x1(%edx)
  100eec:	84 c9                	test   %cl,%cl
  100eee:	74 04                	je     100ef4 <safestrcpy+0x34>
  100ef0:	39 d8                	cmp    %ebx,%eax
  100ef2:	75 ec                	jne    100ee0 <safestrcpy+0x20>
    ;
  *s = 0;
  100ef4:	c6 02 00             	movb   $0x0,(%edx)
  return os;
}
  100ef7:	89 f0                	mov    %esi,%eax
  100ef9:	5b                   	pop    %ebx
  100efa:	5e                   	pop    %esi
  100efb:	5d                   	pop    %ebp
  100efc:	c3                   	ret
  100efd:	8d 76 00             	lea    0x0(%esi),%esi

00100f00 <strlen>:

int
strlen(const char *s)
{
  100f00:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
  100f01:	31 c0                	xor    %eax,%eax
{
  100f03:	89 e5                	mov    %esp,%ebp
  100f05:	8b 55 08             	mov    0x8(%ebp),%edx
  for(n = 0; s[n]; n++)
  100f08:	80 3a 00             	cmpb   $0x0,(%edx)
  100f0b:	74 0c                	je     100f19 <strlen+0x19>
  100f0d:	8d 76 00             	lea    0x0(%esi),%esi
  100f10:	83 c0 01             	add    $0x1,%eax
  100f13:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
  100f17:	75 f7                	jne    100f10 <strlen+0x10>
    ;
  return n;
}
  100f19:	5d                   	pop    %ebp
  100f1a:	c3                   	ret
  100f1b:	66 90                	xchg   %ax,%ax
  100f1d:	66 90                	xchg   %ax,%ax
  100f1f:	90                   	nop

00100f20 <mycpu>:

// Must be called with interrupts disabled to avoid the caller being
// rescheduled between reading lapicid and running through the loop.
struct cpu*
mycpu(void)
{
  100f20:	55                   	push   %ebp
  100f21:	89 e5                	mov    %esp,%ebp
  100f23:	53                   	push   %ebx
  100f24:	83 ec 04             	sub    $0x4,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
  100f27:	9c                   	pushf
  100f28:	58                   	pop    %eax
  int apicid, i;
  
  if(readeflags()&FL_IF)
  100f29:	f6 c4 02             	test   $0x2,%ah
  100f2c:	75 44                	jne    100f72 <mycpu+0x52>
    panic("mycpu called with interrupts enabled\n");
  
  apicid = lapicid();
  100f2e:	e8 fd f6 ff ff       	call   100630 <lapicid>
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i) {
  100f33:	8b 1d a0 24 10 00    	mov    0x1024a0,%ebx
  100f39:	85 db                	test   %ebx,%ebx
  100f3b:	7e 28                	jle    100f65 <mycpu+0x45>
  100f3d:	31 d2                	xor    %edx,%edx
  100f3f:	eb 0e                	jmp    100f4f <mycpu+0x2f>
  100f41:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  100f48:	83 c2 01             	add    $0x1,%edx
  100f4b:	39 da                	cmp    %ebx,%edx
  100f4d:	74 16                	je     100f65 <mycpu+0x45>
    if (cpus[i].apicid == apicid)
  100f4f:	0f b6 8a a4 24 10 00 	movzbl 0x1024a4(%edx),%ecx
  100f56:	39 c1                	cmp    %eax,%ecx
  100f58:	75 ee                	jne    100f48 <mycpu+0x28>
      return &cpus[i];
  }
  panic("unknown apicid\n");
  100f5a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
      return &cpus[i];
  100f5d:	8d 82 a4 24 10 00    	lea    0x1024a4(%edx),%eax
  100f63:	c9                   	leave
  100f64:	c3                   	ret
  panic("unknown apicid\n");
  100f65:	83 ec 0c             	sub    $0xc,%esp
  100f68:	68 2b 1c 10 00       	push   $0x101c2b
  100f6d:	e8 be f2 ff ff       	call   100230 <panic>
    panic("mycpu called with interrupts enabled\n");
  100f72:	83 ec 0c             	sub    $0xc,%esp
  100f75:	68 b8 1c 10 00       	push   $0x101cb8
  100f7a:	e8 b1 f2 ff ff       	call   100230 <panic>
  100f7f:	90                   	nop

00100f80 <cpuid>:
cpuid() {
  100f80:	55                   	push   %ebp
  100f81:	89 e5                	mov    %esp,%ebp
  100f83:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
  100f86:	e8 95 ff ff ff       	call   100f20 <mycpu>
}
  100f8b:	c9                   	leave
  return mycpu()-cpus;
  100f8c:	2d a4 24 10 00       	sub    $0x1024a4,%eax
}
  100f91:	c3                   	ret
  100f92:	66 90                	xchg   %ax,%ax
  100f94:	66 90                	xchg   %ax,%ax
  100f96:	66 90                	xchg   %ax,%ax
  100f98:	66 90                	xchg   %ax,%ax
  100f9a:	66 90                	xchg   %ax,%ax
  100f9c:	66 90                	xchg   %ax,%ax
  100f9e:	66 90                	xchg   %ax,%ax

00100fa0 <getcallerpcs>:
// #include "memlayout.h"

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
  100fa0:	55                   	push   %ebp
  100fa1:	89 e5                	mov    %esp,%ebp
  100fa3:	53                   	push   %ebx
  100fa4:	8b 45 08             	mov    0x8(%ebp),%eax
  100fa7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
    // if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
    if(ebp == 0 || ebp == (uint*)0xffffffff)
  100faa:	83 f8 07             	cmp    $0x7,%eax
  100fad:	74 2e                	je     100fdd <getcallerpcs+0x3d>
  100faf:	8d 50 f8             	lea    -0x8(%eax),%edx
  for(i = 0; i < 10; i++){
  100fb2:	31 c0                	xor    %eax,%eax
  100fb4:	eb 12                	jmp    100fc8 <getcallerpcs+0x28>
  100fb6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  100fbd:	00 
  100fbe:	66 90                	xchg   %ax,%ax
    if(ebp == 0 || ebp == (uint*)0xffffffff)
  100fc0:	8d 5a ff             	lea    -0x1(%edx),%ebx
  100fc3:	83 fb fd             	cmp    $0xfffffffd,%ebx
  100fc6:	77 18                	ja     100fe0 <getcallerpcs+0x40>
      break;
    pcs[i] = ebp[1];     // saved %eip
  100fc8:	8b 5a 04             	mov    0x4(%edx),%ebx
  100fcb:	89 1c 81             	mov    %ebx,(%ecx,%eax,4)
  for(i = 0; i < 10; i++){
  100fce:	83 c0 01             	add    $0x1,%eax
    ebp = (uint*)ebp[0]; // saved %ebp
  100fd1:	8b 12                	mov    (%edx),%edx
  for(i = 0; i < 10; i++){
  100fd3:	83 f8 0a             	cmp    $0xa,%eax
  100fd6:	75 e8                	jne    100fc0 <getcallerpcs+0x20>
  }
  for(; i < 10; i++)
    pcs[i] = 0;
  100fd8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  100fdb:	c9                   	leave
  100fdc:	c3                   	ret
  for(i = 0; i < 10; i++){
  100fdd:	31 c0                	xor    %eax,%eax
  100fdf:	90                   	nop
  100fe0:	8d 04 81             	lea    (%ecx,%eax,4),%eax
  100fe3:	83 c1 28             	add    $0x28,%ecx
  100fe6:	89 ca                	mov    %ecx,%edx
  100fe8:	29 c2                	sub    %eax,%edx
  100fea:	83 e2 04             	and    $0x4,%edx
  100fed:	74 11                	je     101000 <getcallerpcs+0x60>
    pcs[i] = 0;
  100fef:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
  100ff5:	83 c0 04             	add    $0x4,%eax
  100ff8:	39 c1                	cmp    %eax,%ecx
  100ffa:	74 dc                	je     100fd8 <getcallerpcs+0x38>
  100ffc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    pcs[i] = 0;
  101000:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
  101006:	83 c0 08             	add    $0x8,%eax
    pcs[i] = 0;
  101009:	c7 40 fc 00 00 00 00 	movl   $0x0,-0x4(%eax)
  for(; i < 10; i++)
  101010:	39 c1                	cmp    %eax,%ecx
  101012:	75 ec                	jne    101000 <getcallerpcs+0x60>
  101014:	eb c2                	jmp    100fd8 <getcallerpcs+0x38>

00101016 <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushal
  101016:	60                   	pusha
  
  # Call trap(tf), where tf=%esp
  pushl %esp
  101017:	54                   	push   %esp
  call trap
  101018:	e8 83 00 00 00       	call   1010a0 <trap>
  addl $4, %esp
  10101d:	83 c4 04             	add    $0x4,%esp

00101020 <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
  101020:	61                   	popa
  addl $0x8, %esp  # trapno and errcode
  101021:	83 c4 08             	add    $0x8,%esp
  iret
  101024:	cf                   	iret
  101025:	66 90                	xchg   %ax,%ax
  101027:	66 90                	xchg   %ax,%ax
  101029:	66 90                	xchg   %ax,%ax
  10102b:	66 90                	xchg   %ax,%ax
  10102d:	66 90                	xchg   %ax,%ax
  10102f:	90                   	nop

00101030 <tvinit>:
void
tvinit(void)
{
  int i;

  for(i = 0; i < 256; i++)
  101030:	31 c0                	xor    %eax,%eax
  101032:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  101038:	8b 14 85 00 20 10 00 	mov    0x102000(,%eax,4),%edx
  10103f:	c7 04 c5 e2 24 10 00 	movl   $0x8e000008,0x1024e2(,%eax,8)
  101046:	08 00 00 8e 
  10104a:	66 89 14 c5 e0 24 10 	mov    %dx,0x1024e0(,%eax,8)
  101051:	00 
  101052:	c1 ea 10             	shr    $0x10,%edx
  101055:	66 89 14 c5 e6 24 10 	mov    %dx,0x1024e6(,%eax,8)
  10105c:	00 
  for(i = 0; i < 256; i++)
  10105d:	83 c0 01             	add    $0x1,%eax
  101060:	3d 00 01 00 00       	cmp    $0x100,%eax
  101065:	75 d1                	jne    101038 <tvinit+0x8>
}
  101067:	c3                   	ret
  101068:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  10106f:	00 

00101070 <idtinit>:

void
idtinit(void)
{
  101070:	55                   	push   %ebp
  pd[0] = size-1;
  101071:	b8 ff 07 00 00       	mov    $0x7ff,%eax
  101076:	89 e5                	mov    %esp,%ebp
  101078:	83 ec 10             	sub    $0x10,%esp
  10107b:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
  10107f:	b8 e0 24 10 00       	mov    $0x1024e0,%eax
  101084:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
  101088:	c1 e8 10             	shr    $0x10,%eax
  10108b:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
  10108f:	8d 45 fa             	lea    -0x6(%ebp),%eax
  101092:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
  101095:	c9                   	leave
  101096:	c3                   	ret
  101097:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  10109e:	00 
  10109f:	90                   	nop

001010a0 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
  1010a0:	55                   	push   %ebp
  1010a1:	89 e5                	mov    %esp,%ebp
  1010a3:	57                   	push   %edi
  1010a4:	56                   	push   %esi
  1010a5:	53                   	push   %ebx
  1010a6:	83 ec 0c             	sub    $0xc,%esp
  1010a9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  switch(tf->trapno){
  1010ac:	8b 43 20             	mov    0x20(%ebx),%eax
  1010af:	83 e8 20             	sub    $0x20,%eax
  1010b2:	83 f8 1f             	cmp    $0x1f,%eax
  1010b5:	77 7c                	ja     101133 <trap+0x93>
  1010b7:	ff 24 85 38 1d 10 00 	jmp    *0x101d38(,%eax,4)
  1010be:	66 90                	xchg   %ax,%ax
      uartintr();
      lapiceoi();
      break;
    case T_IRQ0 + 7:
    case T_IRQ0 + IRQ_SPURIOUS:
      cprintf("cpu%d: spurious interrupt at %x:%x\n",
  1010c0:	8b 73 28             	mov    0x28(%ebx),%esi
  1010c3:	0f b7 5b 2c          	movzwl 0x2c(%ebx),%ebx
  1010c7:	e8 b4 fe ff ff       	call   100f80 <cpuid>
  1010cc:	56                   	push   %esi
  1010cd:	53                   	push   %ebx
  1010ce:	50                   	push   %eax
  1010cf:	68 e0 1c 10 00       	push   $0x101ce0
  1010d4:	e8 d7 ef ff ff       	call   1000b0 <cprintf>
              cpuid(), tf->cs, tf->eip);
      lapiceoi();
  1010d9:	83 c4 10             	add    $0x10,%esp
    default:
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
  }
}
  1010dc:	8d 65 f4             	lea    -0xc(%ebp),%esp
  1010df:	5b                   	pop    %ebx
  1010e0:	5e                   	pop    %esi
  1010e1:	5f                   	pop    %edi
  1010e2:	5d                   	pop    %ebp
      lapiceoi();
  1010e3:	e9 68 f5 ff ff       	jmp    100650 <lapiceoi>
  1010e8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  1010ef:	00 
      mouseintr();
  1010f0:	e8 4b f7 ff ff       	call   100840 <mouseintr>
}
  1010f5:	8d 65 f4             	lea    -0xc(%ebp),%esp
  1010f8:	5b                   	pop    %ebx
  1010f9:	5e                   	pop    %esi
  1010fa:	5f                   	pop    %edi
  1010fb:	5d                   	pop    %ebp
      lapiceoi();
  1010fc:	e9 4f f5 ff ff       	jmp    100650 <lapiceoi>
  101101:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      uartintr();
  101108:	e8 e3 fb ff ff       	call   100cf0 <uartintr>
}
  10110d:	8d 65 f4             	lea    -0xc(%ebp),%esp
  101110:	5b                   	pop    %ebx
  101111:	5e                   	pop    %esi
  101112:	5f                   	pop    %edi
  101113:	5d                   	pop    %ebp
      lapiceoi();
  101114:	e9 37 f5 ff ff       	jmp    100650 <lapiceoi>
  101119:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      ticks++;
  101120:	83 05 c0 24 10 00 01 	addl   $0x1,0x1024c0
}
  101127:	8d 65 f4             	lea    -0xc(%ebp),%esp
  10112a:	5b                   	pop    %ebx
  10112b:	5e                   	pop    %esi
  10112c:	5f                   	pop    %edi
  10112d:	5d                   	pop    %ebp
      lapiceoi();
  10112e:	e9 1d f5 ff ff       	jmp    100650 <lapiceoi>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
  101133:	0f 20 d7             	mov    %cr2,%edi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
  101136:	8b 73 28             	mov    0x28(%ebx),%esi
  101139:	e8 42 fe ff ff       	call   100f80 <cpuid>
  10113e:	83 ec 0c             	sub    $0xc,%esp
  101141:	57                   	push   %edi
  101142:	56                   	push   %esi
  101143:	50                   	push   %eax
  101144:	ff 73 20             	push   0x20(%ebx)
  101147:	68 04 1d 10 00       	push   $0x101d04
  10114c:	e8 5f ef ff ff       	call   1000b0 <cprintf>
      panic("trap");
  101151:	83 c4 14             	add    $0x14,%esp
  101154:	68 3b 1c 10 00       	push   $0x101c3b
  101159:	e8 d2 f0 ff ff       	call   100230 <panic>

0010115e <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
  10115e:	6a 00                	push   $0x0
  pushl $0
  101160:	6a 00                	push   $0x0
  jmp alltraps
  101162:	e9 af fe ff ff       	jmp    101016 <alltraps>

00101167 <vector1>:
.globl vector1
vector1:
  pushl $0
  101167:	6a 00                	push   $0x0
  pushl $1
  101169:	6a 01                	push   $0x1
  jmp alltraps
  10116b:	e9 a6 fe ff ff       	jmp    101016 <alltraps>

00101170 <vector2>:
.globl vector2
vector2:
  pushl $0
  101170:	6a 00                	push   $0x0
  pushl $2
  101172:	6a 02                	push   $0x2
  jmp alltraps
  101174:	e9 9d fe ff ff       	jmp    101016 <alltraps>

00101179 <vector3>:
.globl vector3
vector3:
  pushl $0
  101179:	6a 00                	push   $0x0
  pushl $3
  10117b:	6a 03                	push   $0x3
  jmp alltraps
  10117d:	e9 94 fe ff ff       	jmp    101016 <alltraps>

00101182 <vector4>:
.globl vector4
vector4:
  pushl $0
  101182:	6a 00                	push   $0x0
  pushl $4
  101184:	6a 04                	push   $0x4
  jmp alltraps
  101186:	e9 8b fe ff ff       	jmp    101016 <alltraps>

0010118b <vector5>:
.globl vector5
vector5:
  pushl $0
  10118b:	6a 00                	push   $0x0
  pushl $5
  10118d:	6a 05                	push   $0x5
  jmp alltraps
  10118f:	e9 82 fe ff ff       	jmp    101016 <alltraps>

00101194 <vector6>:
.globl vector6
vector6:
  pushl $0
  101194:	6a 00                	push   $0x0
  pushl $6
  101196:	6a 06                	push   $0x6
  jmp alltraps
  101198:	e9 79 fe ff ff       	jmp    101016 <alltraps>

0010119d <vector7>:
.globl vector7
vector7:
  pushl $0
  10119d:	6a 00                	push   $0x0
  pushl $7
  10119f:	6a 07                	push   $0x7
  jmp alltraps
  1011a1:	e9 70 fe ff ff       	jmp    101016 <alltraps>

001011a6 <vector8>:
.globl vector8
vector8:
  pushl $8
  1011a6:	6a 08                	push   $0x8
  jmp alltraps
  1011a8:	e9 69 fe ff ff       	jmp    101016 <alltraps>

001011ad <vector9>:
.globl vector9
vector9:
  pushl $0
  1011ad:	6a 00                	push   $0x0
  pushl $9
  1011af:	6a 09                	push   $0x9
  jmp alltraps
  1011b1:	e9 60 fe ff ff       	jmp    101016 <alltraps>

001011b6 <vector10>:
.globl vector10
vector10:
  pushl $10
  1011b6:	6a 0a                	push   $0xa
  jmp alltraps
  1011b8:	e9 59 fe ff ff       	jmp    101016 <alltraps>

001011bd <vector11>:
.globl vector11
vector11:
  pushl $11
  1011bd:	6a 0b                	push   $0xb
  jmp alltraps
  1011bf:	e9 52 fe ff ff       	jmp    101016 <alltraps>

001011c4 <vector12>:
.globl vector12
vector12:
  pushl $12
  1011c4:	6a 0c                	push   $0xc
  jmp alltraps
  1011c6:	e9 4b fe ff ff       	jmp    101016 <alltraps>

001011cb <vector13>:
.globl vector13
vector13:
  pushl $13
  1011cb:	6a 0d                	push   $0xd
  jmp alltraps
  1011cd:	e9 44 fe ff ff       	jmp    101016 <alltraps>

001011d2 <vector14>:
.globl vector14
vector14:
  pushl $14
  1011d2:	6a 0e                	push   $0xe
  jmp alltraps
  1011d4:	e9 3d fe ff ff       	jmp    101016 <alltraps>

001011d9 <vector15>:
.globl vector15
vector15:
  pushl $0
  1011d9:	6a 00                	push   $0x0
  pushl $15
  1011db:	6a 0f                	push   $0xf
  jmp alltraps
  1011dd:	e9 34 fe ff ff       	jmp    101016 <alltraps>

001011e2 <vector16>:
.globl vector16
vector16:
  pushl $0
  1011e2:	6a 00                	push   $0x0
  pushl $16
  1011e4:	6a 10                	push   $0x10
  jmp alltraps
  1011e6:	e9 2b fe ff ff       	jmp    101016 <alltraps>

001011eb <vector17>:
.globl vector17
vector17:
  pushl $17
  1011eb:	6a 11                	push   $0x11
  jmp alltraps
  1011ed:	e9 24 fe ff ff       	jmp    101016 <alltraps>

001011f2 <vector18>:
.globl vector18
vector18:
  pushl $0
  1011f2:	6a 00                	push   $0x0
  pushl $18
  1011f4:	6a 12                	push   $0x12
  jmp alltraps
  1011f6:	e9 1b fe ff ff       	jmp    101016 <alltraps>

001011fb <vector19>:
.globl vector19
vector19:
  pushl $0
  1011fb:	6a 00                	push   $0x0
  pushl $19
  1011fd:	6a 13                	push   $0x13
  jmp alltraps
  1011ff:	e9 12 fe ff ff       	jmp    101016 <alltraps>

00101204 <vector20>:
.globl vector20
vector20:
  pushl $0
  101204:	6a 00                	push   $0x0
  pushl $20
  101206:	6a 14                	push   $0x14
  jmp alltraps
  101208:	e9 09 fe ff ff       	jmp    101016 <alltraps>

0010120d <vector21>:
.globl vector21
vector21:
  pushl $0
  10120d:	6a 00                	push   $0x0
  pushl $21
  10120f:	6a 15                	push   $0x15
  jmp alltraps
  101211:	e9 00 fe ff ff       	jmp    101016 <alltraps>

00101216 <vector22>:
.globl vector22
vector22:
  pushl $0
  101216:	6a 00                	push   $0x0
  pushl $22
  101218:	6a 16                	push   $0x16
  jmp alltraps
  10121a:	e9 f7 fd ff ff       	jmp    101016 <alltraps>

0010121f <vector23>:
.globl vector23
vector23:
  pushl $0
  10121f:	6a 00                	push   $0x0
  pushl $23
  101221:	6a 17                	push   $0x17
  jmp alltraps
  101223:	e9 ee fd ff ff       	jmp    101016 <alltraps>

00101228 <vector24>:
.globl vector24
vector24:
  pushl $0
  101228:	6a 00                	push   $0x0
  pushl $24
  10122a:	6a 18                	push   $0x18
  jmp alltraps
  10122c:	e9 e5 fd ff ff       	jmp    101016 <alltraps>

00101231 <vector25>:
.globl vector25
vector25:
  pushl $0
  101231:	6a 00                	push   $0x0
  pushl $25
  101233:	6a 19                	push   $0x19
  jmp alltraps
  101235:	e9 dc fd ff ff       	jmp    101016 <alltraps>

0010123a <vector26>:
.globl vector26
vector26:
  pushl $0
  10123a:	6a 00                	push   $0x0
  pushl $26
  10123c:	6a 1a                	push   $0x1a
  jmp alltraps
  10123e:	e9 d3 fd ff ff       	jmp    101016 <alltraps>

00101243 <vector27>:
.globl vector27
vector27:
  pushl $0
  101243:	6a 00                	push   $0x0
  pushl $27
  101245:	6a 1b                	push   $0x1b
  jmp alltraps
  101247:	e9 ca fd ff ff       	jmp    101016 <alltraps>

0010124c <vector28>:
.globl vector28
vector28:
  pushl $0
  10124c:	6a 00                	push   $0x0
  pushl $28
  10124e:	6a 1c                	push   $0x1c
  jmp alltraps
  101250:	e9 c1 fd ff ff       	jmp    101016 <alltraps>

00101255 <vector29>:
.globl vector29
vector29:
  pushl $0
  101255:	6a 00                	push   $0x0
  pushl $29
  101257:	6a 1d                	push   $0x1d
  jmp alltraps
  101259:	e9 b8 fd ff ff       	jmp    101016 <alltraps>

0010125e <vector30>:
.globl vector30
vector30:
  pushl $0
  10125e:	6a 00                	push   $0x0
  pushl $30
  101260:	6a 1e                	push   $0x1e
  jmp alltraps
  101262:	e9 af fd ff ff       	jmp    101016 <alltraps>

00101267 <vector31>:
.globl vector31
vector31:
  pushl $0
  101267:	6a 00                	push   $0x0
  pushl $31
  101269:	6a 1f                	push   $0x1f
  jmp alltraps
  10126b:	e9 a6 fd ff ff       	jmp    101016 <alltraps>

00101270 <vector32>:
.globl vector32
vector32:
  pushl $0
  101270:	6a 00                	push   $0x0
  pushl $32
  101272:	6a 20                	push   $0x20
  jmp alltraps
  101274:	e9 9d fd ff ff       	jmp    101016 <alltraps>

00101279 <vector33>:
.globl vector33
vector33:
  pushl $0
  101279:	6a 00                	push   $0x0
  pushl $33
  10127b:	6a 21                	push   $0x21
  jmp alltraps
  10127d:	e9 94 fd ff ff       	jmp    101016 <alltraps>

00101282 <vector34>:
.globl vector34
vector34:
  pushl $0
  101282:	6a 00                	push   $0x0
  pushl $34
  101284:	6a 22                	push   $0x22
  jmp alltraps
  101286:	e9 8b fd ff ff       	jmp    101016 <alltraps>

0010128b <vector35>:
.globl vector35
vector35:
  pushl $0
  10128b:	6a 00                	push   $0x0
  pushl $35
  10128d:	6a 23                	push   $0x23
  jmp alltraps
  10128f:	e9 82 fd ff ff       	jmp    101016 <alltraps>

00101294 <vector36>:
.globl vector36
vector36:
  pushl $0
  101294:	6a 00                	push   $0x0
  pushl $36
  101296:	6a 24                	push   $0x24
  jmp alltraps
  101298:	e9 79 fd ff ff       	jmp    101016 <alltraps>

0010129d <vector37>:
.globl vector37
vector37:
  pushl $0
  10129d:	6a 00                	push   $0x0
  pushl $37
  10129f:	6a 25                	push   $0x25
  jmp alltraps
  1012a1:	e9 70 fd ff ff       	jmp    101016 <alltraps>

001012a6 <vector38>:
.globl vector38
vector38:
  pushl $0
  1012a6:	6a 00                	push   $0x0
  pushl $38
  1012a8:	6a 26                	push   $0x26
  jmp alltraps
  1012aa:	e9 67 fd ff ff       	jmp    101016 <alltraps>

001012af <vector39>:
.globl vector39
vector39:
  pushl $0
  1012af:	6a 00                	push   $0x0
  pushl $39
  1012b1:	6a 27                	push   $0x27
  jmp alltraps
  1012b3:	e9 5e fd ff ff       	jmp    101016 <alltraps>

001012b8 <vector40>:
.globl vector40
vector40:
  pushl $0
  1012b8:	6a 00                	push   $0x0
  pushl $40
  1012ba:	6a 28                	push   $0x28
  jmp alltraps
  1012bc:	e9 55 fd ff ff       	jmp    101016 <alltraps>

001012c1 <vector41>:
.globl vector41
vector41:
  pushl $0
  1012c1:	6a 00                	push   $0x0
  pushl $41
  1012c3:	6a 29                	push   $0x29
  jmp alltraps
  1012c5:	e9 4c fd ff ff       	jmp    101016 <alltraps>

001012ca <vector42>:
.globl vector42
vector42:
  pushl $0
  1012ca:	6a 00                	push   $0x0
  pushl $42
  1012cc:	6a 2a                	push   $0x2a
  jmp alltraps
  1012ce:	e9 43 fd ff ff       	jmp    101016 <alltraps>

001012d3 <vector43>:
.globl vector43
vector43:
  pushl $0
  1012d3:	6a 00                	push   $0x0
  pushl $43
  1012d5:	6a 2b                	push   $0x2b
  jmp alltraps
  1012d7:	e9 3a fd ff ff       	jmp    101016 <alltraps>

001012dc <vector44>:
.globl vector44
vector44:
  pushl $0
  1012dc:	6a 00                	push   $0x0
  pushl $44
  1012de:	6a 2c                	push   $0x2c
  jmp alltraps
  1012e0:	e9 31 fd ff ff       	jmp    101016 <alltraps>

001012e5 <vector45>:
.globl vector45
vector45:
  pushl $0
  1012e5:	6a 00                	push   $0x0
  pushl $45
  1012e7:	6a 2d                	push   $0x2d
  jmp alltraps
  1012e9:	e9 28 fd ff ff       	jmp    101016 <alltraps>

001012ee <vector46>:
.globl vector46
vector46:
  pushl $0
  1012ee:	6a 00                	push   $0x0
  pushl $46
  1012f0:	6a 2e                	push   $0x2e
  jmp alltraps
  1012f2:	e9 1f fd ff ff       	jmp    101016 <alltraps>

001012f7 <vector47>:
.globl vector47
vector47:
  pushl $0
  1012f7:	6a 00                	push   $0x0
  pushl $47
  1012f9:	6a 2f                	push   $0x2f
  jmp alltraps
  1012fb:	e9 16 fd ff ff       	jmp    101016 <alltraps>

00101300 <vector48>:
.globl vector48
vector48:
  pushl $0
  101300:	6a 00                	push   $0x0
  pushl $48
  101302:	6a 30                	push   $0x30
  jmp alltraps
  101304:	e9 0d fd ff ff       	jmp    101016 <alltraps>

00101309 <vector49>:
.globl vector49
vector49:
  pushl $0
  101309:	6a 00                	push   $0x0
  pushl $49
  10130b:	6a 31                	push   $0x31
  jmp alltraps
  10130d:	e9 04 fd ff ff       	jmp    101016 <alltraps>

00101312 <vector50>:
.globl vector50
vector50:
  pushl $0
  101312:	6a 00                	push   $0x0
  pushl $50
  101314:	6a 32                	push   $0x32
  jmp alltraps
  101316:	e9 fb fc ff ff       	jmp    101016 <alltraps>

0010131b <vector51>:
.globl vector51
vector51:
  pushl $0
  10131b:	6a 00                	push   $0x0
  pushl $51
  10131d:	6a 33                	push   $0x33
  jmp alltraps
  10131f:	e9 f2 fc ff ff       	jmp    101016 <alltraps>

00101324 <vector52>:
.globl vector52
vector52:
  pushl $0
  101324:	6a 00                	push   $0x0
  pushl $52
  101326:	6a 34                	push   $0x34
  jmp alltraps
  101328:	e9 e9 fc ff ff       	jmp    101016 <alltraps>

0010132d <vector53>:
.globl vector53
vector53:
  pushl $0
  10132d:	6a 00                	push   $0x0
  pushl $53
  10132f:	6a 35                	push   $0x35
  jmp alltraps
  101331:	e9 e0 fc ff ff       	jmp    101016 <alltraps>

00101336 <vector54>:
.globl vector54
vector54:
  pushl $0
  101336:	6a 00                	push   $0x0
  pushl $54
  101338:	6a 36                	push   $0x36
  jmp alltraps
  10133a:	e9 d7 fc ff ff       	jmp    101016 <alltraps>

0010133f <vector55>:
.globl vector55
vector55:
  pushl $0
  10133f:	6a 00                	push   $0x0
  pushl $55
  101341:	6a 37                	push   $0x37
  jmp alltraps
  101343:	e9 ce fc ff ff       	jmp    101016 <alltraps>

00101348 <vector56>:
.globl vector56
vector56:
  pushl $0
  101348:	6a 00                	push   $0x0
  pushl $56
  10134a:	6a 38                	push   $0x38
  jmp alltraps
  10134c:	e9 c5 fc ff ff       	jmp    101016 <alltraps>

00101351 <vector57>:
.globl vector57
vector57:
  pushl $0
  101351:	6a 00                	push   $0x0
  pushl $57
  101353:	6a 39                	push   $0x39
  jmp alltraps
  101355:	e9 bc fc ff ff       	jmp    101016 <alltraps>

0010135a <vector58>:
.globl vector58
vector58:
  pushl $0
  10135a:	6a 00                	push   $0x0
  pushl $58
  10135c:	6a 3a                	push   $0x3a
  jmp alltraps
  10135e:	e9 b3 fc ff ff       	jmp    101016 <alltraps>

00101363 <vector59>:
.globl vector59
vector59:
  pushl $0
  101363:	6a 00                	push   $0x0
  pushl $59
  101365:	6a 3b                	push   $0x3b
  jmp alltraps
  101367:	e9 aa fc ff ff       	jmp    101016 <alltraps>

0010136c <vector60>:
.globl vector60
vector60:
  pushl $0
  10136c:	6a 00                	push   $0x0
  pushl $60
  10136e:	6a 3c                	push   $0x3c
  jmp alltraps
  101370:	e9 a1 fc ff ff       	jmp    101016 <alltraps>

00101375 <vector61>:
.globl vector61
vector61:
  pushl $0
  101375:	6a 00                	push   $0x0
  pushl $61
  101377:	6a 3d                	push   $0x3d
  jmp alltraps
  101379:	e9 98 fc ff ff       	jmp    101016 <alltraps>

0010137e <vector62>:
.globl vector62
vector62:
  pushl $0
  10137e:	6a 00                	push   $0x0
  pushl $62
  101380:	6a 3e                	push   $0x3e
  jmp alltraps
  101382:	e9 8f fc ff ff       	jmp    101016 <alltraps>

00101387 <vector63>:
.globl vector63
vector63:
  pushl $0
  101387:	6a 00                	push   $0x0
  pushl $63
  101389:	6a 3f                	push   $0x3f
  jmp alltraps
  10138b:	e9 86 fc ff ff       	jmp    101016 <alltraps>

00101390 <vector64>:
.globl vector64
vector64:
  pushl $0
  101390:	6a 00                	push   $0x0
  pushl $64
  101392:	6a 40                	push   $0x40
  jmp alltraps
  101394:	e9 7d fc ff ff       	jmp    101016 <alltraps>

00101399 <vector65>:
.globl vector65
vector65:
  pushl $0
  101399:	6a 00                	push   $0x0
  pushl $65
  10139b:	6a 41                	push   $0x41
  jmp alltraps
  10139d:	e9 74 fc ff ff       	jmp    101016 <alltraps>

001013a2 <vector66>:
.globl vector66
vector66:
  pushl $0
  1013a2:	6a 00                	push   $0x0
  pushl $66
  1013a4:	6a 42                	push   $0x42
  jmp alltraps
  1013a6:	e9 6b fc ff ff       	jmp    101016 <alltraps>

001013ab <vector67>:
.globl vector67
vector67:
  pushl $0
  1013ab:	6a 00                	push   $0x0
  pushl $67
  1013ad:	6a 43                	push   $0x43
  jmp alltraps
  1013af:	e9 62 fc ff ff       	jmp    101016 <alltraps>

001013b4 <vector68>:
.globl vector68
vector68:
  pushl $0
  1013b4:	6a 00                	push   $0x0
  pushl $68
  1013b6:	6a 44                	push   $0x44
  jmp alltraps
  1013b8:	e9 59 fc ff ff       	jmp    101016 <alltraps>

001013bd <vector69>:
.globl vector69
vector69:
  pushl $0
  1013bd:	6a 00                	push   $0x0
  pushl $69
  1013bf:	6a 45                	push   $0x45
  jmp alltraps
  1013c1:	e9 50 fc ff ff       	jmp    101016 <alltraps>

001013c6 <vector70>:
.globl vector70
vector70:
  pushl $0
  1013c6:	6a 00                	push   $0x0
  pushl $70
  1013c8:	6a 46                	push   $0x46
  jmp alltraps
  1013ca:	e9 47 fc ff ff       	jmp    101016 <alltraps>

001013cf <vector71>:
.globl vector71
vector71:
  pushl $0
  1013cf:	6a 00                	push   $0x0
  pushl $71
  1013d1:	6a 47                	push   $0x47
  jmp alltraps
  1013d3:	e9 3e fc ff ff       	jmp    101016 <alltraps>

001013d8 <vector72>:
.globl vector72
vector72:
  pushl $0
  1013d8:	6a 00                	push   $0x0
  pushl $72
  1013da:	6a 48                	push   $0x48
  jmp alltraps
  1013dc:	e9 35 fc ff ff       	jmp    101016 <alltraps>

001013e1 <vector73>:
.globl vector73
vector73:
  pushl $0
  1013e1:	6a 00                	push   $0x0
  pushl $73
  1013e3:	6a 49                	push   $0x49
  jmp alltraps
  1013e5:	e9 2c fc ff ff       	jmp    101016 <alltraps>

001013ea <vector74>:
.globl vector74
vector74:
  pushl $0
  1013ea:	6a 00                	push   $0x0
  pushl $74
  1013ec:	6a 4a                	push   $0x4a
  jmp alltraps
  1013ee:	e9 23 fc ff ff       	jmp    101016 <alltraps>

001013f3 <vector75>:
.globl vector75
vector75:
  pushl $0
  1013f3:	6a 00                	push   $0x0
  pushl $75
  1013f5:	6a 4b                	push   $0x4b
  jmp alltraps
  1013f7:	e9 1a fc ff ff       	jmp    101016 <alltraps>

001013fc <vector76>:
.globl vector76
vector76:
  pushl $0
  1013fc:	6a 00                	push   $0x0
  pushl $76
  1013fe:	6a 4c                	push   $0x4c
  jmp alltraps
  101400:	e9 11 fc ff ff       	jmp    101016 <alltraps>

00101405 <vector77>:
.globl vector77
vector77:
  pushl $0
  101405:	6a 00                	push   $0x0
  pushl $77
  101407:	6a 4d                	push   $0x4d
  jmp alltraps
  101409:	e9 08 fc ff ff       	jmp    101016 <alltraps>

0010140e <vector78>:
.globl vector78
vector78:
  pushl $0
  10140e:	6a 00                	push   $0x0
  pushl $78
  101410:	6a 4e                	push   $0x4e
  jmp alltraps
  101412:	e9 ff fb ff ff       	jmp    101016 <alltraps>

00101417 <vector79>:
.globl vector79
vector79:
  pushl $0
  101417:	6a 00                	push   $0x0
  pushl $79
  101419:	6a 4f                	push   $0x4f
  jmp alltraps
  10141b:	e9 f6 fb ff ff       	jmp    101016 <alltraps>

00101420 <vector80>:
.globl vector80
vector80:
  pushl $0
  101420:	6a 00                	push   $0x0
  pushl $80
  101422:	6a 50                	push   $0x50
  jmp alltraps
  101424:	e9 ed fb ff ff       	jmp    101016 <alltraps>

00101429 <vector81>:
.globl vector81
vector81:
  pushl $0
  101429:	6a 00                	push   $0x0
  pushl $81
  10142b:	6a 51                	push   $0x51
  jmp alltraps
  10142d:	e9 e4 fb ff ff       	jmp    101016 <alltraps>

00101432 <vector82>:
.globl vector82
vector82:
  pushl $0
  101432:	6a 00                	push   $0x0
  pushl $82
  101434:	6a 52                	push   $0x52
  jmp alltraps
  101436:	e9 db fb ff ff       	jmp    101016 <alltraps>

0010143b <vector83>:
.globl vector83
vector83:
  pushl $0
  10143b:	6a 00                	push   $0x0
  pushl $83
  10143d:	6a 53                	push   $0x53
  jmp alltraps
  10143f:	e9 d2 fb ff ff       	jmp    101016 <alltraps>

00101444 <vector84>:
.globl vector84
vector84:
  pushl $0
  101444:	6a 00                	push   $0x0
  pushl $84
  101446:	6a 54                	push   $0x54
  jmp alltraps
  101448:	e9 c9 fb ff ff       	jmp    101016 <alltraps>

0010144d <vector85>:
.globl vector85
vector85:
  pushl $0
  10144d:	6a 00                	push   $0x0
  pushl $85
  10144f:	6a 55                	push   $0x55
  jmp alltraps
  101451:	e9 c0 fb ff ff       	jmp    101016 <alltraps>

00101456 <vector86>:
.globl vector86
vector86:
  pushl $0
  101456:	6a 00                	push   $0x0
  pushl $86
  101458:	6a 56                	push   $0x56
  jmp alltraps
  10145a:	e9 b7 fb ff ff       	jmp    101016 <alltraps>

0010145f <vector87>:
.globl vector87
vector87:
  pushl $0
  10145f:	6a 00                	push   $0x0
  pushl $87
  101461:	6a 57                	push   $0x57
  jmp alltraps
  101463:	e9 ae fb ff ff       	jmp    101016 <alltraps>

00101468 <vector88>:
.globl vector88
vector88:
  pushl $0
  101468:	6a 00                	push   $0x0
  pushl $88
  10146a:	6a 58                	push   $0x58
  jmp alltraps
  10146c:	e9 a5 fb ff ff       	jmp    101016 <alltraps>

00101471 <vector89>:
.globl vector89
vector89:
  pushl $0
  101471:	6a 00                	push   $0x0
  pushl $89
  101473:	6a 59                	push   $0x59
  jmp alltraps
  101475:	e9 9c fb ff ff       	jmp    101016 <alltraps>

0010147a <vector90>:
.globl vector90
vector90:
  pushl $0
  10147a:	6a 00                	push   $0x0
  pushl $90
  10147c:	6a 5a                	push   $0x5a
  jmp alltraps
  10147e:	e9 93 fb ff ff       	jmp    101016 <alltraps>

00101483 <vector91>:
.globl vector91
vector91:
  pushl $0
  101483:	6a 00                	push   $0x0
  pushl $91
  101485:	6a 5b                	push   $0x5b
  jmp alltraps
  101487:	e9 8a fb ff ff       	jmp    101016 <alltraps>

0010148c <vector92>:
.globl vector92
vector92:
  pushl $0
  10148c:	6a 00                	push   $0x0
  pushl $92
  10148e:	6a 5c                	push   $0x5c
  jmp alltraps
  101490:	e9 81 fb ff ff       	jmp    101016 <alltraps>

00101495 <vector93>:
.globl vector93
vector93:
  pushl $0
  101495:	6a 00                	push   $0x0
  pushl $93
  101497:	6a 5d                	push   $0x5d
  jmp alltraps
  101499:	e9 78 fb ff ff       	jmp    101016 <alltraps>

0010149e <vector94>:
.globl vector94
vector94:
  pushl $0
  10149e:	6a 00                	push   $0x0
  pushl $94
  1014a0:	6a 5e                	push   $0x5e
  jmp alltraps
  1014a2:	e9 6f fb ff ff       	jmp    101016 <alltraps>

001014a7 <vector95>:
.globl vector95
vector95:
  pushl $0
  1014a7:	6a 00                	push   $0x0
  pushl $95
  1014a9:	6a 5f                	push   $0x5f
  jmp alltraps
  1014ab:	e9 66 fb ff ff       	jmp    101016 <alltraps>

001014b0 <vector96>:
.globl vector96
vector96:
  pushl $0
  1014b0:	6a 00                	push   $0x0
  pushl $96
  1014b2:	6a 60                	push   $0x60
  jmp alltraps
  1014b4:	e9 5d fb ff ff       	jmp    101016 <alltraps>

001014b9 <vector97>:
.globl vector97
vector97:
  pushl $0
  1014b9:	6a 00                	push   $0x0
  pushl $97
  1014bb:	6a 61                	push   $0x61
  jmp alltraps
  1014bd:	e9 54 fb ff ff       	jmp    101016 <alltraps>

001014c2 <vector98>:
.globl vector98
vector98:
  pushl $0
  1014c2:	6a 00                	push   $0x0
  pushl $98
  1014c4:	6a 62                	push   $0x62
  jmp alltraps
  1014c6:	e9 4b fb ff ff       	jmp    101016 <alltraps>

001014cb <vector99>:
.globl vector99
vector99:
  pushl $0
  1014cb:	6a 00                	push   $0x0
  pushl $99
  1014cd:	6a 63                	push   $0x63
  jmp alltraps
  1014cf:	e9 42 fb ff ff       	jmp    101016 <alltraps>

001014d4 <vector100>:
.globl vector100
vector100:
  pushl $0
  1014d4:	6a 00                	push   $0x0
  pushl $100
  1014d6:	6a 64                	push   $0x64
  jmp alltraps
  1014d8:	e9 39 fb ff ff       	jmp    101016 <alltraps>

001014dd <vector101>:
.globl vector101
vector101:
  pushl $0
  1014dd:	6a 00                	push   $0x0
  pushl $101
  1014df:	6a 65                	push   $0x65
  jmp alltraps
  1014e1:	e9 30 fb ff ff       	jmp    101016 <alltraps>

001014e6 <vector102>:
.globl vector102
vector102:
  pushl $0
  1014e6:	6a 00                	push   $0x0
  pushl $102
  1014e8:	6a 66                	push   $0x66
  jmp alltraps
  1014ea:	e9 27 fb ff ff       	jmp    101016 <alltraps>

001014ef <vector103>:
.globl vector103
vector103:
  pushl $0
  1014ef:	6a 00                	push   $0x0
  pushl $103
  1014f1:	6a 67                	push   $0x67
  jmp alltraps
  1014f3:	e9 1e fb ff ff       	jmp    101016 <alltraps>

001014f8 <vector104>:
.globl vector104
vector104:
  pushl $0
  1014f8:	6a 00                	push   $0x0
  pushl $104
  1014fa:	6a 68                	push   $0x68
  jmp alltraps
  1014fc:	e9 15 fb ff ff       	jmp    101016 <alltraps>

00101501 <vector105>:
.globl vector105
vector105:
  pushl $0
  101501:	6a 00                	push   $0x0
  pushl $105
  101503:	6a 69                	push   $0x69
  jmp alltraps
  101505:	e9 0c fb ff ff       	jmp    101016 <alltraps>

0010150a <vector106>:
.globl vector106
vector106:
  pushl $0
  10150a:	6a 00                	push   $0x0
  pushl $106
  10150c:	6a 6a                	push   $0x6a
  jmp alltraps
  10150e:	e9 03 fb ff ff       	jmp    101016 <alltraps>

00101513 <vector107>:
.globl vector107
vector107:
  pushl $0
  101513:	6a 00                	push   $0x0
  pushl $107
  101515:	6a 6b                	push   $0x6b
  jmp alltraps
  101517:	e9 fa fa ff ff       	jmp    101016 <alltraps>

0010151c <vector108>:
.globl vector108
vector108:
  pushl $0
  10151c:	6a 00                	push   $0x0
  pushl $108
  10151e:	6a 6c                	push   $0x6c
  jmp alltraps
  101520:	e9 f1 fa ff ff       	jmp    101016 <alltraps>

00101525 <vector109>:
.globl vector109
vector109:
  pushl $0
  101525:	6a 00                	push   $0x0
  pushl $109
  101527:	6a 6d                	push   $0x6d
  jmp alltraps
  101529:	e9 e8 fa ff ff       	jmp    101016 <alltraps>

0010152e <vector110>:
.globl vector110
vector110:
  pushl $0
  10152e:	6a 00                	push   $0x0
  pushl $110
  101530:	6a 6e                	push   $0x6e
  jmp alltraps
  101532:	e9 df fa ff ff       	jmp    101016 <alltraps>

00101537 <vector111>:
.globl vector111
vector111:
  pushl $0
  101537:	6a 00                	push   $0x0
  pushl $111
  101539:	6a 6f                	push   $0x6f
  jmp alltraps
  10153b:	e9 d6 fa ff ff       	jmp    101016 <alltraps>

00101540 <vector112>:
.globl vector112
vector112:
  pushl $0
  101540:	6a 00                	push   $0x0
  pushl $112
  101542:	6a 70                	push   $0x70
  jmp alltraps
  101544:	e9 cd fa ff ff       	jmp    101016 <alltraps>

00101549 <vector113>:
.globl vector113
vector113:
  pushl $0
  101549:	6a 00                	push   $0x0
  pushl $113
  10154b:	6a 71                	push   $0x71
  jmp alltraps
  10154d:	e9 c4 fa ff ff       	jmp    101016 <alltraps>

00101552 <vector114>:
.globl vector114
vector114:
  pushl $0
  101552:	6a 00                	push   $0x0
  pushl $114
  101554:	6a 72                	push   $0x72
  jmp alltraps
  101556:	e9 bb fa ff ff       	jmp    101016 <alltraps>

0010155b <vector115>:
.globl vector115
vector115:
  pushl $0
  10155b:	6a 00                	push   $0x0
  pushl $115
  10155d:	6a 73                	push   $0x73
  jmp alltraps
  10155f:	e9 b2 fa ff ff       	jmp    101016 <alltraps>

00101564 <vector116>:
.globl vector116
vector116:
  pushl $0
  101564:	6a 00                	push   $0x0
  pushl $116
  101566:	6a 74                	push   $0x74
  jmp alltraps
  101568:	e9 a9 fa ff ff       	jmp    101016 <alltraps>

0010156d <vector117>:
.globl vector117
vector117:
  pushl $0
  10156d:	6a 00                	push   $0x0
  pushl $117
  10156f:	6a 75                	push   $0x75
  jmp alltraps
  101571:	e9 a0 fa ff ff       	jmp    101016 <alltraps>

00101576 <vector118>:
.globl vector118
vector118:
  pushl $0
  101576:	6a 00                	push   $0x0
  pushl $118
  101578:	6a 76                	push   $0x76
  jmp alltraps
  10157a:	e9 97 fa ff ff       	jmp    101016 <alltraps>

0010157f <vector119>:
.globl vector119
vector119:
  pushl $0
  10157f:	6a 00                	push   $0x0
  pushl $119
  101581:	6a 77                	push   $0x77
  jmp alltraps
  101583:	e9 8e fa ff ff       	jmp    101016 <alltraps>

00101588 <vector120>:
.globl vector120
vector120:
  pushl $0
  101588:	6a 00                	push   $0x0
  pushl $120
  10158a:	6a 78                	push   $0x78
  jmp alltraps
  10158c:	e9 85 fa ff ff       	jmp    101016 <alltraps>

00101591 <vector121>:
.globl vector121
vector121:
  pushl $0
  101591:	6a 00                	push   $0x0
  pushl $121
  101593:	6a 79                	push   $0x79
  jmp alltraps
  101595:	e9 7c fa ff ff       	jmp    101016 <alltraps>

0010159a <vector122>:
.globl vector122
vector122:
  pushl $0
  10159a:	6a 00                	push   $0x0
  pushl $122
  10159c:	6a 7a                	push   $0x7a
  jmp alltraps
  10159e:	e9 73 fa ff ff       	jmp    101016 <alltraps>

001015a3 <vector123>:
.globl vector123
vector123:
  pushl $0
  1015a3:	6a 00                	push   $0x0
  pushl $123
  1015a5:	6a 7b                	push   $0x7b
  jmp alltraps
  1015a7:	e9 6a fa ff ff       	jmp    101016 <alltraps>

001015ac <vector124>:
.globl vector124
vector124:
  pushl $0
  1015ac:	6a 00                	push   $0x0
  pushl $124
  1015ae:	6a 7c                	push   $0x7c
  jmp alltraps
  1015b0:	e9 61 fa ff ff       	jmp    101016 <alltraps>

001015b5 <vector125>:
.globl vector125
vector125:
  pushl $0
  1015b5:	6a 00                	push   $0x0
  pushl $125
  1015b7:	6a 7d                	push   $0x7d
  jmp alltraps
  1015b9:	e9 58 fa ff ff       	jmp    101016 <alltraps>

001015be <vector126>:
.globl vector126
vector126:
  pushl $0
  1015be:	6a 00                	push   $0x0
  pushl $126
  1015c0:	6a 7e                	push   $0x7e
  jmp alltraps
  1015c2:	e9 4f fa ff ff       	jmp    101016 <alltraps>

001015c7 <vector127>:
.globl vector127
vector127:
  pushl $0
  1015c7:	6a 00                	push   $0x0
  pushl $127
  1015c9:	6a 7f                	push   $0x7f
  jmp alltraps
  1015cb:	e9 46 fa ff ff       	jmp    101016 <alltraps>

001015d0 <vector128>:
.globl vector128
vector128:
  pushl $0
  1015d0:	6a 00                	push   $0x0
  pushl $128
  1015d2:	68 80 00 00 00       	push   $0x80
  jmp alltraps
  1015d7:	e9 3a fa ff ff       	jmp    101016 <alltraps>

001015dc <vector129>:
.globl vector129
vector129:
  pushl $0
  1015dc:	6a 00                	push   $0x0
  pushl $129
  1015de:	68 81 00 00 00       	push   $0x81
  jmp alltraps
  1015e3:	e9 2e fa ff ff       	jmp    101016 <alltraps>

001015e8 <vector130>:
.globl vector130
vector130:
  pushl $0
  1015e8:	6a 00                	push   $0x0
  pushl $130
  1015ea:	68 82 00 00 00       	push   $0x82
  jmp alltraps
  1015ef:	e9 22 fa ff ff       	jmp    101016 <alltraps>

001015f4 <vector131>:
.globl vector131
vector131:
  pushl $0
  1015f4:	6a 00                	push   $0x0
  pushl $131
  1015f6:	68 83 00 00 00       	push   $0x83
  jmp alltraps
  1015fb:	e9 16 fa ff ff       	jmp    101016 <alltraps>

00101600 <vector132>:
.globl vector132
vector132:
  pushl $0
  101600:	6a 00                	push   $0x0
  pushl $132
  101602:	68 84 00 00 00       	push   $0x84
  jmp alltraps
  101607:	e9 0a fa ff ff       	jmp    101016 <alltraps>

0010160c <vector133>:
.globl vector133
vector133:
  pushl $0
  10160c:	6a 00                	push   $0x0
  pushl $133
  10160e:	68 85 00 00 00       	push   $0x85
  jmp alltraps
  101613:	e9 fe f9 ff ff       	jmp    101016 <alltraps>

00101618 <vector134>:
.globl vector134
vector134:
  pushl $0
  101618:	6a 00                	push   $0x0
  pushl $134
  10161a:	68 86 00 00 00       	push   $0x86
  jmp alltraps
  10161f:	e9 f2 f9 ff ff       	jmp    101016 <alltraps>

00101624 <vector135>:
.globl vector135
vector135:
  pushl $0
  101624:	6a 00                	push   $0x0
  pushl $135
  101626:	68 87 00 00 00       	push   $0x87
  jmp alltraps
  10162b:	e9 e6 f9 ff ff       	jmp    101016 <alltraps>

00101630 <vector136>:
.globl vector136
vector136:
  pushl $0
  101630:	6a 00                	push   $0x0
  pushl $136
  101632:	68 88 00 00 00       	push   $0x88
  jmp alltraps
  101637:	e9 da f9 ff ff       	jmp    101016 <alltraps>

0010163c <vector137>:
.globl vector137
vector137:
  pushl $0
  10163c:	6a 00                	push   $0x0
  pushl $137
  10163e:	68 89 00 00 00       	push   $0x89
  jmp alltraps
  101643:	e9 ce f9 ff ff       	jmp    101016 <alltraps>

00101648 <vector138>:
.globl vector138
vector138:
  pushl $0
  101648:	6a 00                	push   $0x0
  pushl $138
  10164a:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
  10164f:	e9 c2 f9 ff ff       	jmp    101016 <alltraps>

00101654 <vector139>:
.globl vector139
vector139:
  pushl $0
  101654:	6a 00                	push   $0x0
  pushl $139
  101656:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
  10165b:	e9 b6 f9 ff ff       	jmp    101016 <alltraps>

00101660 <vector140>:
.globl vector140
vector140:
  pushl $0
  101660:	6a 00                	push   $0x0
  pushl $140
  101662:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
  101667:	e9 aa f9 ff ff       	jmp    101016 <alltraps>

0010166c <vector141>:
.globl vector141
vector141:
  pushl $0
  10166c:	6a 00                	push   $0x0
  pushl $141
  10166e:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
  101673:	e9 9e f9 ff ff       	jmp    101016 <alltraps>

00101678 <vector142>:
.globl vector142
vector142:
  pushl $0
  101678:	6a 00                	push   $0x0
  pushl $142
  10167a:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
  10167f:	e9 92 f9 ff ff       	jmp    101016 <alltraps>

00101684 <vector143>:
.globl vector143
vector143:
  pushl $0
  101684:	6a 00                	push   $0x0
  pushl $143
  101686:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
  10168b:	e9 86 f9 ff ff       	jmp    101016 <alltraps>

00101690 <vector144>:
.globl vector144
vector144:
  pushl $0
  101690:	6a 00                	push   $0x0
  pushl $144
  101692:	68 90 00 00 00       	push   $0x90
  jmp alltraps
  101697:	e9 7a f9 ff ff       	jmp    101016 <alltraps>

0010169c <vector145>:
.globl vector145
vector145:
  pushl $0
  10169c:	6a 00                	push   $0x0
  pushl $145
  10169e:	68 91 00 00 00       	push   $0x91
  jmp alltraps
  1016a3:	e9 6e f9 ff ff       	jmp    101016 <alltraps>

001016a8 <vector146>:
.globl vector146
vector146:
  pushl $0
  1016a8:	6a 00                	push   $0x0
  pushl $146
  1016aa:	68 92 00 00 00       	push   $0x92
  jmp alltraps
  1016af:	e9 62 f9 ff ff       	jmp    101016 <alltraps>

001016b4 <vector147>:
.globl vector147
vector147:
  pushl $0
  1016b4:	6a 00                	push   $0x0
  pushl $147
  1016b6:	68 93 00 00 00       	push   $0x93
  jmp alltraps
  1016bb:	e9 56 f9 ff ff       	jmp    101016 <alltraps>

001016c0 <vector148>:
.globl vector148
vector148:
  pushl $0
  1016c0:	6a 00                	push   $0x0
  pushl $148
  1016c2:	68 94 00 00 00       	push   $0x94
  jmp alltraps
  1016c7:	e9 4a f9 ff ff       	jmp    101016 <alltraps>

001016cc <vector149>:
.globl vector149
vector149:
  pushl $0
  1016cc:	6a 00                	push   $0x0
  pushl $149
  1016ce:	68 95 00 00 00       	push   $0x95
  jmp alltraps
  1016d3:	e9 3e f9 ff ff       	jmp    101016 <alltraps>

001016d8 <vector150>:
.globl vector150
vector150:
  pushl $0
  1016d8:	6a 00                	push   $0x0
  pushl $150
  1016da:	68 96 00 00 00       	push   $0x96
  jmp alltraps
  1016df:	e9 32 f9 ff ff       	jmp    101016 <alltraps>

001016e4 <vector151>:
.globl vector151
vector151:
  pushl $0
  1016e4:	6a 00                	push   $0x0
  pushl $151
  1016e6:	68 97 00 00 00       	push   $0x97
  jmp alltraps
  1016eb:	e9 26 f9 ff ff       	jmp    101016 <alltraps>

001016f0 <vector152>:
.globl vector152
vector152:
  pushl $0
  1016f0:	6a 00                	push   $0x0
  pushl $152
  1016f2:	68 98 00 00 00       	push   $0x98
  jmp alltraps
  1016f7:	e9 1a f9 ff ff       	jmp    101016 <alltraps>

001016fc <vector153>:
.globl vector153
vector153:
  pushl $0
  1016fc:	6a 00                	push   $0x0
  pushl $153
  1016fe:	68 99 00 00 00       	push   $0x99
  jmp alltraps
  101703:	e9 0e f9 ff ff       	jmp    101016 <alltraps>

00101708 <vector154>:
.globl vector154
vector154:
  pushl $0
  101708:	6a 00                	push   $0x0
  pushl $154
  10170a:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
  10170f:	e9 02 f9 ff ff       	jmp    101016 <alltraps>

00101714 <vector155>:
.globl vector155
vector155:
  pushl $0
  101714:	6a 00                	push   $0x0
  pushl $155
  101716:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
  10171b:	e9 f6 f8 ff ff       	jmp    101016 <alltraps>

00101720 <vector156>:
.globl vector156
vector156:
  pushl $0
  101720:	6a 00                	push   $0x0
  pushl $156
  101722:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
  101727:	e9 ea f8 ff ff       	jmp    101016 <alltraps>

0010172c <vector157>:
.globl vector157
vector157:
  pushl $0
  10172c:	6a 00                	push   $0x0
  pushl $157
  10172e:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
  101733:	e9 de f8 ff ff       	jmp    101016 <alltraps>

00101738 <vector158>:
.globl vector158
vector158:
  pushl $0
  101738:	6a 00                	push   $0x0
  pushl $158
  10173a:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
  10173f:	e9 d2 f8 ff ff       	jmp    101016 <alltraps>

00101744 <vector159>:
.globl vector159
vector159:
  pushl $0
  101744:	6a 00                	push   $0x0
  pushl $159
  101746:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
  10174b:	e9 c6 f8 ff ff       	jmp    101016 <alltraps>

00101750 <vector160>:
.globl vector160
vector160:
  pushl $0
  101750:	6a 00                	push   $0x0
  pushl $160
  101752:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
  101757:	e9 ba f8 ff ff       	jmp    101016 <alltraps>

0010175c <vector161>:
.globl vector161
vector161:
  pushl $0
  10175c:	6a 00                	push   $0x0
  pushl $161
  10175e:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
  101763:	e9 ae f8 ff ff       	jmp    101016 <alltraps>

00101768 <vector162>:
.globl vector162
vector162:
  pushl $0
  101768:	6a 00                	push   $0x0
  pushl $162
  10176a:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
  10176f:	e9 a2 f8 ff ff       	jmp    101016 <alltraps>

00101774 <vector163>:
.globl vector163
vector163:
  pushl $0
  101774:	6a 00                	push   $0x0
  pushl $163
  101776:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
  10177b:	e9 96 f8 ff ff       	jmp    101016 <alltraps>

00101780 <vector164>:
.globl vector164
vector164:
  pushl $0
  101780:	6a 00                	push   $0x0
  pushl $164
  101782:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
  101787:	e9 8a f8 ff ff       	jmp    101016 <alltraps>

0010178c <vector165>:
.globl vector165
vector165:
  pushl $0
  10178c:	6a 00                	push   $0x0
  pushl $165
  10178e:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
  101793:	e9 7e f8 ff ff       	jmp    101016 <alltraps>

00101798 <vector166>:
.globl vector166
vector166:
  pushl $0
  101798:	6a 00                	push   $0x0
  pushl $166
  10179a:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
  10179f:	e9 72 f8 ff ff       	jmp    101016 <alltraps>

001017a4 <vector167>:
.globl vector167
vector167:
  pushl $0
  1017a4:	6a 00                	push   $0x0
  pushl $167
  1017a6:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
  1017ab:	e9 66 f8 ff ff       	jmp    101016 <alltraps>

001017b0 <vector168>:
.globl vector168
vector168:
  pushl $0
  1017b0:	6a 00                	push   $0x0
  pushl $168
  1017b2:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
  1017b7:	e9 5a f8 ff ff       	jmp    101016 <alltraps>

001017bc <vector169>:
.globl vector169
vector169:
  pushl $0
  1017bc:	6a 00                	push   $0x0
  pushl $169
  1017be:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
  1017c3:	e9 4e f8 ff ff       	jmp    101016 <alltraps>

001017c8 <vector170>:
.globl vector170
vector170:
  pushl $0
  1017c8:	6a 00                	push   $0x0
  pushl $170
  1017ca:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
  1017cf:	e9 42 f8 ff ff       	jmp    101016 <alltraps>

001017d4 <vector171>:
.globl vector171
vector171:
  pushl $0
  1017d4:	6a 00                	push   $0x0
  pushl $171
  1017d6:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
  1017db:	e9 36 f8 ff ff       	jmp    101016 <alltraps>

001017e0 <vector172>:
.globl vector172
vector172:
  pushl $0
  1017e0:	6a 00                	push   $0x0
  pushl $172
  1017e2:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
  1017e7:	e9 2a f8 ff ff       	jmp    101016 <alltraps>

001017ec <vector173>:
.globl vector173
vector173:
  pushl $0
  1017ec:	6a 00                	push   $0x0
  pushl $173
  1017ee:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
  1017f3:	e9 1e f8 ff ff       	jmp    101016 <alltraps>

001017f8 <vector174>:
.globl vector174
vector174:
  pushl $0
  1017f8:	6a 00                	push   $0x0
  pushl $174
  1017fa:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
  1017ff:	e9 12 f8 ff ff       	jmp    101016 <alltraps>

00101804 <vector175>:
.globl vector175
vector175:
  pushl $0
  101804:	6a 00                	push   $0x0
  pushl $175
  101806:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
  10180b:	e9 06 f8 ff ff       	jmp    101016 <alltraps>

00101810 <vector176>:
.globl vector176
vector176:
  pushl $0
  101810:	6a 00                	push   $0x0
  pushl $176
  101812:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
  101817:	e9 fa f7 ff ff       	jmp    101016 <alltraps>

0010181c <vector177>:
.globl vector177
vector177:
  pushl $0
  10181c:	6a 00                	push   $0x0
  pushl $177
  10181e:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
  101823:	e9 ee f7 ff ff       	jmp    101016 <alltraps>

00101828 <vector178>:
.globl vector178
vector178:
  pushl $0
  101828:	6a 00                	push   $0x0
  pushl $178
  10182a:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
  10182f:	e9 e2 f7 ff ff       	jmp    101016 <alltraps>

00101834 <vector179>:
.globl vector179
vector179:
  pushl $0
  101834:	6a 00                	push   $0x0
  pushl $179
  101836:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
  10183b:	e9 d6 f7 ff ff       	jmp    101016 <alltraps>

00101840 <vector180>:
.globl vector180
vector180:
  pushl $0
  101840:	6a 00                	push   $0x0
  pushl $180
  101842:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
  101847:	e9 ca f7 ff ff       	jmp    101016 <alltraps>

0010184c <vector181>:
.globl vector181
vector181:
  pushl $0
  10184c:	6a 00                	push   $0x0
  pushl $181
  10184e:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
  101853:	e9 be f7 ff ff       	jmp    101016 <alltraps>

00101858 <vector182>:
.globl vector182
vector182:
  pushl $0
  101858:	6a 00                	push   $0x0
  pushl $182
  10185a:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
  10185f:	e9 b2 f7 ff ff       	jmp    101016 <alltraps>

00101864 <vector183>:
.globl vector183
vector183:
  pushl $0
  101864:	6a 00                	push   $0x0
  pushl $183
  101866:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
  10186b:	e9 a6 f7 ff ff       	jmp    101016 <alltraps>

00101870 <vector184>:
.globl vector184
vector184:
  pushl $0
  101870:	6a 00                	push   $0x0
  pushl $184
  101872:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
  101877:	e9 9a f7 ff ff       	jmp    101016 <alltraps>

0010187c <vector185>:
.globl vector185
vector185:
  pushl $0
  10187c:	6a 00                	push   $0x0
  pushl $185
  10187e:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
  101883:	e9 8e f7 ff ff       	jmp    101016 <alltraps>

00101888 <vector186>:
.globl vector186
vector186:
  pushl $0
  101888:	6a 00                	push   $0x0
  pushl $186
  10188a:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
  10188f:	e9 82 f7 ff ff       	jmp    101016 <alltraps>

00101894 <vector187>:
.globl vector187
vector187:
  pushl $0
  101894:	6a 00                	push   $0x0
  pushl $187
  101896:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
  10189b:	e9 76 f7 ff ff       	jmp    101016 <alltraps>

001018a0 <vector188>:
.globl vector188
vector188:
  pushl $0
  1018a0:	6a 00                	push   $0x0
  pushl $188
  1018a2:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
  1018a7:	e9 6a f7 ff ff       	jmp    101016 <alltraps>

001018ac <vector189>:
.globl vector189
vector189:
  pushl $0
  1018ac:	6a 00                	push   $0x0
  pushl $189
  1018ae:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
  1018b3:	e9 5e f7 ff ff       	jmp    101016 <alltraps>

001018b8 <vector190>:
.globl vector190
vector190:
  pushl $0
  1018b8:	6a 00                	push   $0x0
  pushl $190
  1018ba:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
  1018bf:	e9 52 f7 ff ff       	jmp    101016 <alltraps>

001018c4 <vector191>:
.globl vector191
vector191:
  pushl $0
  1018c4:	6a 00                	push   $0x0
  pushl $191
  1018c6:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
  1018cb:	e9 46 f7 ff ff       	jmp    101016 <alltraps>

001018d0 <vector192>:
.globl vector192
vector192:
  pushl $0
  1018d0:	6a 00                	push   $0x0
  pushl $192
  1018d2:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
  1018d7:	e9 3a f7 ff ff       	jmp    101016 <alltraps>

001018dc <vector193>:
.globl vector193
vector193:
  pushl $0
  1018dc:	6a 00                	push   $0x0
  pushl $193
  1018de:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
  1018e3:	e9 2e f7 ff ff       	jmp    101016 <alltraps>

001018e8 <vector194>:
.globl vector194
vector194:
  pushl $0
  1018e8:	6a 00                	push   $0x0
  pushl $194
  1018ea:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
  1018ef:	e9 22 f7 ff ff       	jmp    101016 <alltraps>

001018f4 <vector195>:
.globl vector195
vector195:
  pushl $0
  1018f4:	6a 00                	push   $0x0
  pushl $195
  1018f6:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
  1018fb:	e9 16 f7 ff ff       	jmp    101016 <alltraps>

00101900 <vector196>:
.globl vector196
vector196:
  pushl $0
  101900:	6a 00                	push   $0x0
  pushl $196
  101902:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
  101907:	e9 0a f7 ff ff       	jmp    101016 <alltraps>

0010190c <vector197>:
.globl vector197
vector197:
  pushl $0
  10190c:	6a 00                	push   $0x0
  pushl $197
  10190e:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
  101913:	e9 fe f6 ff ff       	jmp    101016 <alltraps>

00101918 <vector198>:
.globl vector198
vector198:
  pushl $0
  101918:	6a 00                	push   $0x0
  pushl $198
  10191a:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
  10191f:	e9 f2 f6 ff ff       	jmp    101016 <alltraps>

00101924 <vector199>:
.globl vector199
vector199:
  pushl $0
  101924:	6a 00                	push   $0x0
  pushl $199
  101926:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
  10192b:	e9 e6 f6 ff ff       	jmp    101016 <alltraps>

00101930 <vector200>:
.globl vector200
vector200:
  pushl $0
  101930:	6a 00                	push   $0x0
  pushl $200
  101932:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
  101937:	e9 da f6 ff ff       	jmp    101016 <alltraps>

0010193c <vector201>:
.globl vector201
vector201:
  pushl $0
  10193c:	6a 00                	push   $0x0
  pushl $201
  10193e:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
  101943:	e9 ce f6 ff ff       	jmp    101016 <alltraps>

00101948 <vector202>:
.globl vector202
vector202:
  pushl $0
  101948:	6a 00                	push   $0x0
  pushl $202
  10194a:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
  10194f:	e9 c2 f6 ff ff       	jmp    101016 <alltraps>

00101954 <vector203>:
.globl vector203
vector203:
  pushl $0
  101954:	6a 00                	push   $0x0
  pushl $203
  101956:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
  10195b:	e9 b6 f6 ff ff       	jmp    101016 <alltraps>

00101960 <vector204>:
.globl vector204
vector204:
  pushl $0
  101960:	6a 00                	push   $0x0
  pushl $204
  101962:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
  101967:	e9 aa f6 ff ff       	jmp    101016 <alltraps>

0010196c <vector205>:
.globl vector205
vector205:
  pushl $0
  10196c:	6a 00                	push   $0x0
  pushl $205
  10196e:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
  101973:	e9 9e f6 ff ff       	jmp    101016 <alltraps>

00101978 <vector206>:
.globl vector206
vector206:
  pushl $0
  101978:	6a 00                	push   $0x0
  pushl $206
  10197a:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
  10197f:	e9 92 f6 ff ff       	jmp    101016 <alltraps>

00101984 <vector207>:
.globl vector207
vector207:
  pushl $0
  101984:	6a 00                	push   $0x0
  pushl $207
  101986:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
  10198b:	e9 86 f6 ff ff       	jmp    101016 <alltraps>

00101990 <vector208>:
.globl vector208
vector208:
  pushl $0
  101990:	6a 00                	push   $0x0
  pushl $208
  101992:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
  101997:	e9 7a f6 ff ff       	jmp    101016 <alltraps>

0010199c <vector209>:
.globl vector209
vector209:
  pushl $0
  10199c:	6a 00                	push   $0x0
  pushl $209
  10199e:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
  1019a3:	e9 6e f6 ff ff       	jmp    101016 <alltraps>

001019a8 <vector210>:
.globl vector210
vector210:
  pushl $0
  1019a8:	6a 00                	push   $0x0
  pushl $210
  1019aa:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
  1019af:	e9 62 f6 ff ff       	jmp    101016 <alltraps>

001019b4 <vector211>:
.globl vector211
vector211:
  pushl $0
  1019b4:	6a 00                	push   $0x0
  pushl $211
  1019b6:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
  1019bb:	e9 56 f6 ff ff       	jmp    101016 <alltraps>

001019c0 <vector212>:
.globl vector212
vector212:
  pushl $0
  1019c0:	6a 00                	push   $0x0
  pushl $212
  1019c2:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
  1019c7:	e9 4a f6 ff ff       	jmp    101016 <alltraps>

001019cc <vector213>:
.globl vector213
vector213:
  pushl $0
  1019cc:	6a 00                	push   $0x0
  pushl $213
  1019ce:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
  1019d3:	e9 3e f6 ff ff       	jmp    101016 <alltraps>

001019d8 <vector214>:
.globl vector214
vector214:
  pushl $0
  1019d8:	6a 00                	push   $0x0
  pushl $214
  1019da:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
  1019df:	e9 32 f6 ff ff       	jmp    101016 <alltraps>

001019e4 <vector215>:
.globl vector215
vector215:
  pushl $0
  1019e4:	6a 00                	push   $0x0
  pushl $215
  1019e6:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
  1019eb:	e9 26 f6 ff ff       	jmp    101016 <alltraps>

001019f0 <vector216>:
.globl vector216
vector216:
  pushl $0
  1019f0:	6a 00                	push   $0x0
  pushl $216
  1019f2:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
  1019f7:	e9 1a f6 ff ff       	jmp    101016 <alltraps>

001019fc <vector217>:
.globl vector217
vector217:
  pushl $0
  1019fc:	6a 00                	push   $0x0
  pushl $217
  1019fe:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
  101a03:	e9 0e f6 ff ff       	jmp    101016 <alltraps>

00101a08 <vector218>:
.globl vector218
vector218:
  pushl $0
  101a08:	6a 00                	push   $0x0
  pushl $218
  101a0a:	68 da 00 00 00       	push   $0xda
  jmp alltraps
  101a0f:	e9 02 f6 ff ff       	jmp    101016 <alltraps>

00101a14 <vector219>:
.globl vector219
vector219:
  pushl $0
  101a14:	6a 00                	push   $0x0
  pushl $219
  101a16:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
  101a1b:	e9 f6 f5 ff ff       	jmp    101016 <alltraps>

00101a20 <vector220>:
.globl vector220
vector220:
  pushl $0
  101a20:	6a 00                	push   $0x0
  pushl $220
  101a22:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
  101a27:	e9 ea f5 ff ff       	jmp    101016 <alltraps>

00101a2c <vector221>:
.globl vector221
vector221:
  pushl $0
  101a2c:	6a 00                	push   $0x0
  pushl $221
  101a2e:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
  101a33:	e9 de f5 ff ff       	jmp    101016 <alltraps>

00101a38 <vector222>:
.globl vector222
vector222:
  pushl $0
  101a38:	6a 00                	push   $0x0
  pushl $222
  101a3a:	68 de 00 00 00       	push   $0xde
  jmp alltraps
  101a3f:	e9 d2 f5 ff ff       	jmp    101016 <alltraps>

00101a44 <vector223>:
.globl vector223
vector223:
  pushl $0
  101a44:	6a 00                	push   $0x0
  pushl $223
  101a46:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
  101a4b:	e9 c6 f5 ff ff       	jmp    101016 <alltraps>

00101a50 <vector224>:
.globl vector224
vector224:
  pushl $0
  101a50:	6a 00                	push   $0x0
  pushl $224
  101a52:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
  101a57:	e9 ba f5 ff ff       	jmp    101016 <alltraps>

00101a5c <vector225>:
.globl vector225
vector225:
  pushl $0
  101a5c:	6a 00                	push   $0x0
  pushl $225
  101a5e:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
  101a63:	e9 ae f5 ff ff       	jmp    101016 <alltraps>

00101a68 <vector226>:
.globl vector226
vector226:
  pushl $0
  101a68:	6a 00                	push   $0x0
  pushl $226
  101a6a:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
  101a6f:	e9 a2 f5 ff ff       	jmp    101016 <alltraps>

00101a74 <vector227>:
.globl vector227
vector227:
  pushl $0
  101a74:	6a 00                	push   $0x0
  pushl $227
  101a76:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
  101a7b:	e9 96 f5 ff ff       	jmp    101016 <alltraps>

00101a80 <vector228>:
.globl vector228
vector228:
  pushl $0
  101a80:	6a 00                	push   $0x0
  pushl $228
  101a82:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
  101a87:	e9 8a f5 ff ff       	jmp    101016 <alltraps>

00101a8c <vector229>:
.globl vector229
vector229:
  pushl $0
  101a8c:	6a 00                	push   $0x0
  pushl $229
  101a8e:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
  101a93:	e9 7e f5 ff ff       	jmp    101016 <alltraps>

00101a98 <vector230>:
.globl vector230
vector230:
  pushl $0
  101a98:	6a 00                	push   $0x0
  pushl $230
  101a9a:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
  101a9f:	e9 72 f5 ff ff       	jmp    101016 <alltraps>

00101aa4 <vector231>:
.globl vector231
vector231:
  pushl $0
  101aa4:	6a 00                	push   $0x0
  pushl $231
  101aa6:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
  101aab:	e9 66 f5 ff ff       	jmp    101016 <alltraps>

00101ab0 <vector232>:
.globl vector232
vector232:
  pushl $0
  101ab0:	6a 00                	push   $0x0
  pushl $232
  101ab2:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
  101ab7:	e9 5a f5 ff ff       	jmp    101016 <alltraps>

00101abc <vector233>:
.globl vector233
vector233:
  pushl $0
  101abc:	6a 00                	push   $0x0
  pushl $233
  101abe:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
  101ac3:	e9 4e f5 ff ff       	jmp    101016 <alltraps>

00101ac8 <vector234>:
.globl vector234
vector234:
  pushl $0
  101ac8:	6a 00                	push   $0x0
  pushl $234
  101aca:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
  101acf:	e9 42 f5 ff ff       	jmp    101016 <alltraps>

00101ad4 <vector235>:
.globl vector235
vector235:
  pushl $0
  101ad4:	6a 00                	push   $0x0
  pushl $235
  101ad6:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
  101adb:	e9 36 f5 ff ff       	jmp    101016 <alltraps>

00101ae0 <vector236>:
.globl vector236
vector236:
  pushl $0
  101ae0:	6a 00                	push   $0x0
  pushl $236
  101ae2:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
  101ae7:	e9 2a f5 ff ff       	jmp    101016 <alltraps>

00101aec <vector237>:
.globl vector237
vector237:
  pushl $0
  101aec:	6a 00                	push   $0x0
  pushl $237
  101aee:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
  101af3:	e9 1e f5 ff ff       	jmp    101016 <alltraps>

00101af8 <vector238>:
.globl vector238
vector238:
  pushl $0
  101af8:	6a 00                	push   $0x0
  pushl $238
  101afa:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
  101aff:	e9 12 f5 ff ff       	jmp    101016 <alltraps>

00101b04 <vector239>:
.globl vector239
vector239:
  pushl $0
  101b04:	6a 00                	push   $0x0
  pushl $239
  101b06:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
  101b0b:	e9 06 f5 ff ff       	jmp    101016 <alltraps>

00101b10 <vector240>:
.globl vector240
vector240:
  pushl $0
  101b10:	6a 00                	push   $0x0
  pushl $240
  101b12:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
  101b17:	e9 fa f4 ff ff       	jmp    101016 <alltraps>

00101b1c <vector241>:
.globl vector241
vector241:
  pushl $0
  101b1c:	6a 00                	push   $0x0
  pushl $241
  101b1e:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
  101b23:	e9 ee f4 ff ff       	jmp    101016 <alltraps>

00101b28 <vector242>:
.globl vector242
vector242:
  pushl $0
  101b28:	6a 00                	push   $0x0
  pushl $242
  101b2a:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
  101b2f:	e9 e2 f4 ff ff       	jmp    101016 <alltraps>

00101b34 <vector243>:
.globl vector243
vector243:
  pushl $0
  101b34:	6a 00                	push   $0x0
  pushl $243
  101b36:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
  101b3b:	e9 d6 f4 ff ff       	jmp    101016 <alltraps>

00101b40 <vector244>:
.globl vector244
vector244:
  pushl $0
  101b40:	6a 00                	push   $0x0
  pushl $244
  101b42:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
  101b47:	e9 ca f4 ff ff       	jmp    101016 <alltraps>

00101b4c <vector245>:
.globl vector245
vector245:
  pushl $0
  101b4c:	6a 00                	push   $0x0
  pushl $245
  101b4e:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
  101b53:	e9 be f4 ff ff       	jmp    101016 <alltraps>

00101b58 <vector246>:
.globl vector246
vector246:
  pushl $0
  101b58:	6a 00                	push   $0x0
  pushl $246
  101b5a:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
  101b5f:	e9 b2 f4 ff ff       	jmp    101016 <alltraps>

00101b64 <vector247>:
.globl vector247
vector247:
  pushl $0
  101b64:	6a 00                	push   $0x0
  pushl $247
  101b66:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
  101b6b:	e9 a6 f4 ff ff       	jmp    101016 <alltraps>

00101b70 <vector248>:
.globl vector248
vector248:
  pushl $0
  101b70:	6a 00                	push   $0x0
  pushl $248
  101b72:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
  101b77:	e9 9a f4 ff ff       	jmp    101016 <alltraps>

00101b7c <vector249>:
.globl vector249
vector249:
  pushl $0
  101b7c:	6a 00                	push   $0x0
  pushl $249
  101b7e:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
  101b83:	e9 8e f4 ff ff       	jmp    101016 <alltraps>

00101b88 <vector250>:
.globl vector250
vector250:
  pushl $0
  101b88:	6a 00                	push   $0x0
  pushl $250
  101b8a:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
  101b8f:	e9 82 f4 ff ff       	jmp    101016 <alltraps>

00101b94 <vector251>:
.globl vector251
vector251:
  pushl $0
  101b94:	6a 00                	push   $0x0
  pushl $251
  101b96:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
  101b9b:	e9 76 f4 ff ff       	jmp    101016 <alltraps>

00101ba0 <vector252>:
.globl vector252
vector252:
  pushl $0
  101ba0:	6a 00                	push   $0x0
  pushl $252
  101ba2:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
  101ba7:	e9 6a f4 ff ff       	jmp    101016 <alltraps>

00101bac <vector253>:
.globl vector253
vector253:
  pushl $0
  101bac:	6a 00                	push   $0x0
  pushl $253
  101bae:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
  101bb3:	e9 5e f4 ff ff       	jmp    101016 <alltraps>

00101bb8 <vector254>:
.globl vector254
vector254:
  pushl $0
  101bb8:	6a 00                	push   $0x0
  pushl $254
  101bba:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
  101bbf:	e9 52 f4 ff ff       	jmp    101016 <alltraps>

00101bc4 <vector255>:
.globl vector255
vector255:
  pushl $0
  101bc4:	6a 00                	push   $0x0
  pushl $255
  101bc6:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
  101bcb:	e9 46 f4 ff ff       	jmp    101016 <alltraps>
