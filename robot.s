.include "nios_macros.s"
.equ JP1, 0x10000060

.global _start

_start:

/* Initialization */
movia r8, JP1
movia r10, 0xFFFFFFFF
stwio r10, (r8)
movia r9, 0x07f557ff
stwio r9, 4(r8)

/* Polling */

/* Sensor 1 */
poll1:

movia r15, 0xFFFFFBFF
and r10, r10, r15
stwio r10, (r8)
ldwio r11, (r8)
srli r11, r11, 11
andi r11, r11, 0x1
bne r11, r0, poll1

ldwio r11, (r8)
srli r11, r11, 27
andi r11, r11, 0x000F
mov r12, r11

movia r15, 0x0000040F
or r10, r10, r15

/* Sensor 2 */
poll2:

movia r15, 0xFFFFEFFF
and r10, r10, r15
stwio r10, (r8)
ldwio r11, (r8)
srli r11, r11, 13
andi r11, r11, 0x1
bne r11, r0, poll2

ldwio r11, (r8)
srli r11, r11, 27
andi r11, r11, 0x000F
mov r13, r11

movia r15, 0x0000100F
or r10, r10, r15

/* s9 = s1 */
bne r12, r13, cmp
movia r10, 0xFFFFFFFF
stwio r10, (r8)


cmp:
bge r13, r12, rev

fwd:
movia r4, 50000
call PWM
movia r10, 0xFFFFFFE
stwio r10, (r8)
movia r4, 50000
call PWM
movia r10, 0xFFFFFFFF
stwio r10, (r8)

br poll1

rev:
movia r4, 50000
call PWM
movia r10, 0xFFFFFFC
stwio r10, (r8)
movia r4, 50000
call PWM
movia r10, 0xFFFFFFFF
stwio r10, (r8)

br poll1