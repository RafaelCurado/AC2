    .data
    .equ resetCoreTimer, 12
    .equ readCoreTimer, 11
    .equ printInt, 6
    .equ putChar, 3
    .text
    .globl main

main:
    addiu   $sp,$sp,-8          # 
    sw		$ra, 0($sp)		    # 
    sw      $s0, 4($sp)
    

    li      $s0,0               # counter = 0;

while1:
    li      $v0,resetCoreTimer
    syscall                     # resetCoreTimer();

while2:
    li      $v0,readCoreTimer
    syscall                     # readCoreTimer();
    bge		$v0, 20000000, endw2	
    j		while2				# jump to while2
endw2:
    move 	$a0,$s0		
    addiu   $s0,$s0,1           # counter++;
    li      $a1,4
    sll		$a1,$a1,16          # $a1 = 4 << 16;
    or	    $a1,$a1,10          # $a1 = $a1 | 10; 
    li      $v0,printInt
    syscall                     # printInt(counter++, 10 | 4 << 16);
    li      $a0,'\r'            # $a0 = '\r'
    li      $v0,putChar
    syscall     

    li 	    $a0,1000
    jal		delay				
    
    j		while1				# jump to while1
    li      $v0,0               # return 0;

    addiu   $sp,$sp,4           
    lw		$ra,0($sp)
    lw      $s0,4($sp)
    
    jr      $ra

##################################################

delay:                          # void delay(unsigned int ms) {
    li      $v0,resetCoreTimer
    syscall                     # resetCoreTimer();
    li      $t0,20000
    mul     $t0,$t0,$a0
while:
    li      $v0,readCoreTimer
    syscall                     # readCoreTimer();
    
    bge     $v0,$t0,endw     
    j		while				# jump to while

endw:
    jr      $ra

    


    
