    .equ SFR_BASE_HI, 0xBF88
    .equ TRISB, 0x6040
    .equ PORTB, 0X6050
    .equ PORTD, 0x60D0
    .equ TRISE, 0x6100
    .equ LATE, 0x6120
    
    .data
    .text
    .globl main

main:
    lui     $t0,SFR_BASE_HI # $t0 = 0xBF800000
    lw      $t1,TRISB($t0)  # Endereço 0xBF800000 + 0X00006040
    ori	    $t1,$t1,0x001   
    sw      $t1,TRISB($t0)  # RB0 configured as input
   
    lw      $t1,TRISE($t0)  #
    andi    $t1,$t1,0xFFFE  # reset bit0
    sw      $t1,TRISE($t0)  # RE0 configured as output

loop:
    lw      $t1, PORTB($t0)
    andi    $t1, $t1, 0x000F
    
    lw      $t2, LATE($t0)
    andi    $t2, $t2, 0xFFF0    # reset bit0
    or      $t2, $t2, $t1
    sw      $t2, LATE($t0)

    j       loop 

    jr      $ra

    

