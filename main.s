.section .init
.globl _start
.globl get_gpio_addr
.globl set_gpio_function

// B+ 35 & 47 LED

_start:
    bl get_gpio_addr

    mov r1, #1
    lsl r1, #21
    str r1, [r0, #16]
    
    mov r1, #1
    lsl r1, #15

    loop$:
        str r1, [r0, #32]

        mov r2, #0x3F0000
        wait1$:
            sub r2, #1
            cmp r2, #0
        bne wait1$

        str r1, [r0, #44]

        mov r2, #0x3F0000
        wait2$:
            sub r2, #1
            cmp r2, #0
        bne wait2$
    b loop$

get_gpio_addr:
    ldr r0, =0x20200000
    mov pc, lr

set_gpio_function:
    cmp r0, #53
    cmpls r1, #7
    movhi pc, lr

    push {lr}
    mov r2, r0 
    bl get_gpio_addr

    function_loop$:
        cmp r2, #9
        subhi r2, #10
        addhi r0, #4
    bhi function_loop$

    add r2, r2, lsl #1
    lsl r1, r2
    str r1, [r0]
    pop {pc}
