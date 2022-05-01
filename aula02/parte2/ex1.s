    .data
    .equ resetCoreTimer, 12
    .equ readCoreTimer, 11
    .equ printInt, 6
    .equ putChar, 3
    .text
    .globl main

main:
    addiu   $sp,$sp,-16
    sw      $ra,0($sp)
    sw      $s0,4($sp)
    sw      $s1,8($sp)
    sw      $s2,12($sp)

    li      $s0,0               # int cnt1 = 0;
    li      $s1,0               # int cnt5 = 0;
    li      $s2,0               # int cnt10 = 0;

while:
    li      $a0,100
    jal     delay               # delay(100);

    addiu   $s2,$s2,1           # cnt10++;
if1:
    rem     $t0,$s2,2           #
    bnez	$t0,if2             # if (cnt10 % 2 == 0) 
    addiu   $s1,$s1,1           #   cnt5++;
if2:  
    rem     $t0,$s2,10          #
    bnez	$t0,endif           # if (cnt10 % 10 == 0) 
    addiu   $s0,$s0,1           #   cnt1++;
endif:
    move    $a0,$s2
    li      $a1,5
    sll		$a1,$a1,16          # $a1 = 5 << 16;
    or	    $a1,$a1,10          # $a1 = $a1 | 10;
    li      $v0,printInt
    syscall

    li		$a0,' '		        # $a0,' '
    li      $v0,putChar
    syscall

    move    $a0,$s1
    li      $a1,5
    sll		$a1,$a1,16          # $a1 = 5 << 16;
    or	    $a1,$a1,10          # $a1 = $a1 | 10;
    li      $v0,printInt
    syscall

    li		$a0,' '		        # $a0,' '
    li      $v0,putChar
    syscall

    move    $a0,$s0
    li      $a1,5
    sll		$a1,$a1,16          # $a1 = 5 << 16;
    or	    $a1,$a1,10          # $a1 = $a1 | 10;
    li      $v0,printInt
    syscall

    li		$a0,'\r'		        # $a0,' '
    li      $v0,putChar
    syscall

    j		while				# jump to while

endw:
    addiu   $sp,$sp,16
    lw      $ra,0($sp)
    lw      $s0,4($sp)
    lw      $s1,0($sp)
    lw      $s2,4($sp)

    jr      $ra

##############################################################

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
