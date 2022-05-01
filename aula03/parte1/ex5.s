    .equ SFR_BASE_HI, 0xBF88
    .equ TRISB, 0x6040
    .equ PORTB, 0X6050
    .equ PORTD, 0x60D0
    .equ TRISE, 0x6100
    .equ TRISD, 0x60C0
    .equ LATE, 0x6120
    .equ LATD, 0x60E0
    .equ resetCoreTimer, 12
    .equ readCoreTimer, 11
    
    .data
    .text
    .globl main

main:
    addiu   $sp, $sp, -20
    sw      $ra, 0($sp) 
    sw      $s0, 4($sp)
    sw      $s1, 8($sp)
    sw      $s2, 12($sp)
    sw      $s3, 16($sp)    

    lw      $s1,TRISE($s0)  #
    andi    $s1,$s1,0xFFFE  # reset bit0
    sw      $s1,TRISE($s0)  # RE0 configured as output

    lw      $s1,TRISD($s0)  #
    andi    $s1,$s1,0xFFFE  # reset bit0
    sw      $s1,TRISD($s0)  # RD0 configured as output

    li      $s3, 0x0     # $t3 = 0;
loop:
    lw      $s1, PORTB($s0)
    andi    $s1, $s1, 0x000F

    lw      $s2, LATE($s0)
    andi    $s2, $s2, 0xFFFE    # reset bit0
    or      $s2, $s2, $s3
    sw      $s2, LATE($s0)

    lw      $s2, LATD($s0)
    andi    $s2, $s2, 0xFFFE    # reset bit0
    or      $s2, $s2, $s3
    sw      $s2, LATD($s0)

    li      $a0, 50            
    jal		delay				# jump to delay and save position to $ra
    
    xor     $s3,$s3,0x0001

    j       loop 

    addiu   $sp, $sp, 20
    lw      $ra, 0($sp) 
    lw      $s0, 4($sp)
    lw      $s1, 8($sp)
    lw      $s2, 12($sp)
    lw      $s3, 16($sp)     

    jr      $ra

#####################################################
delay:                          # void delay(unsigned int ms) {
    li      $v0,resetCoreTimer
    syscall                     # resetCoreTimer();
    li      $t0,20000
    mul     $t0,$t0,$a0
d_while:
    li      $v0,readCoreTimer
    syscall                     # readCoreTimer();
    
    bge     $v0,$t0,d_endw     
    j		d_while				# jump to while

d_endw:
    jr      $ra


