#include "types.h"
#include "defs.h"
#include "x86.h"
#include "mouse.h"
#include "traps.h"

// Wait until the mouse controller is ready for us to send a packet
void 
mousewait_send(void) 
{
    // Implement your code here

    // Keep reading status register (port 0x64)
    // Loop while bit 1 is SET (value & 0x02 != 0)
    // Exit when bit 1 is CLEAR (value & 0x02 == 0)

    while(inb(MSSTATP) & 0x02);
    return;
}

// Wait until the mouse controller has data for us to receive
void 
mousewait_recv(void) 
{
    // Implement your code here
    // Keep reading status register (port 0x64)
    // Loop while bit 0 is CLEAR (value & 0x01 == 0)
    // Exit when bit 0 is SET (value & 0x01 != 0)

    while((inb(MSSTATP) & 0x01) == 0);
    return;
}

// Send a one-byte command to the mouse controller, and wait for it
// to be properly acknowledged
void 
mousecmd(uchar cmd) 
{
    // Implement your code here
    
    uchar ack;
    // Wait until ready to send
    mousewait_send();

    // Send the command to be prepared for a mouse command
    outb(MSSTATP, PS2MS);
    
    // Wait until ready to send
    mousewait_send();

    outb(MSDATAP, cmd);

    // Wait to receive ACK
    mousewait_recv();

    // Read ACK from mouse data port
    ack = inb(MSDATAP);

    // Ack Check Maybe ??
    // if(ack != 0xFA)
    //     cprintf("mouse: command 0x%x not acknowledged (got 0x%x)\n", cmd, ack);
    (void)ack; // prevent unused variable warning   
    return;
}

void
mouseinit(void)
{
    // Implement your code here
    uchar status;
    // Step 1-2: enable the auxiliary (mouse) device on the controller.
    mousewait_send();
    outb(MSSTATP, MSEN);

    // Step 3: read, modify, and write the controller "Compaq Status Byte"
    // so that mouse interrupts (IRQ12) are enabled.

    mousewait_send();
    outb(MSSTATP, 0x20);      // command: read status byte
    
    mousewait_recv();
    status = inb(MSDATAP);
    status |= 0x02;           // set bit 1 to enable IRQ12
    
    mousewait_send();
    outb(MSSTATP, 0x60);   // command: write status byte
    mousewait_send();         
    outb(MSDATAP, status);

    // Step 4-5: set default mouse settings and start sending packets.
    mousecmd(0xF6);        // defaults
    mousecmd(0xF4);        // enable data reporting

    // Step 6: route IRQ12 to CPU 0 via the I/O APIC.
    ioapicenable(IRQ_MOUSE, 0);
    // cprintf("Mouse initialization completed\n");

    return;
}

void
mouseintr(void)
{
    // Implement your code here
    static uchar packet[3];
    static int idx;
    // NOTE: The advanced features below (movement tracking, overflow
    // handling, and button state machine) are provided as commented
    // reference code. They show how to extend the driver safely without
    // changing the lab’s required behavior. Enable selectively when
    // you’re ready, and delete the #if 0 fences.

    // Drain all available bytes from the controller buffer. Each mouse
    // packet is 3 bytes long; bit 3 of byte 0 is always 1 and helps us
    // resynchronize if we ever lose alignment.
    while(inb(MSSTATP) & 0x01){
        uchar data = inb(MSDATAP);

        // If this should be the first byte, enforce the "always 1" bit.
        if(idx == 0 && (data & 0x08) == 0)
            continue;

        packet[idx++] = data;
        if(idx < 3)
            continue;

        // We have a full packet; reset index for the next one.
        idx = 0;

        #if 0
        // ---- Overflow handling ------------------------------------------------
        // Bits 6 and 7 of the first byte indicate X/Y overflow. If either
        // is set, the movement values are unreliable (the device moved
        // too far between reports), so we discard the packet to avoid
        // corrupting cursor state.
        //
        // This is intentionally placed before we use the movement bytes.
        if(packet[0] & 0xC0) {
            // 0x40 = X overflow, 0x80 = Y overflow
            continue;
        }

        // ---- Movement tracking -----------------------------------------------
        // The second byte is X delta, third byte is Y delta.
        // They are 8-bit two's-complement values. The sign bits are
        // duplicated in byte0 (bit4 for X, bit5 for Y), but the standard
        // way is to sign-extend the 8-bit value into a 32-bit int.
        //
        // Note: PS/2 Y deltas are typically "up is negative". If you want
        // screen coordinates where Y grows downward, you invert dy.
        static int cursor_x;
        static int cursor_y;
        int dx = (int)(signed char)packet[1];
        int dy = (int)(signed char)packet[2];

        // Update the cursor position (example bounds omitted).
        cursor_x += dx;
        cursor_y -= dy; // flip sign to make "up" decrease on screen coords

        // ---- Button state machine --------------------------------------------
        // Track press/release events and derive higher-level gestures.
        // We keep previous button state, detect edges, and optionally
        // classify drags and double-clicks using the global timer tick.
        static uchar prev_buttons;
        static uint last_click_ticks[3]; // per-button last click time
        const uint double_click_window = 15; // ~15 ticks; tune as needed
        uchar buttons = packet[0] & 0x07;    // bits: 0=L,1=R,2=M
        uchar pressed = buttons & ~prev_buttons;  // 0->1 transitions
        uchar released = prev_buttons & ~buttons; // 1->0 transitions

        // Example: detect drag if movement occurs while button held.
        if((buttons & 0x01) && (dx != 0 || dy != 0)) {
            // Left-button drag event.
        }

        // Example: detect double-clicks.
        if(pressed & 0x01) {
            if(ticks - last_click_ticks[0] <= double_click_window) {
                // Double-click detected for left button.
            }
            last_click_ticks[0] = ticks;
        }

        // Example: handle releases.
        if(released & 0x01) {
            // Left button released.
        }

        prev_buttons = buttons;
        #endif

        // Buttons are in the low three bits of the first byte.
        // Print on rising edges to avoid repeated prints while held.
        {
            uchar buttons = packet[0] & 0x07;

            if(buttons & 0x01)
                cprintf("LEFT\n");
            if(buttons & 0x02)
                cprintf("RIGHT\n");
            if(buttons & 0x04)
                cprintf("MID\n");
        }
    }

    return;
}