    .equ printStr,8
    .equ readInt10,5
    .equ printInt10,7
    .equ printInt,6
    .data
s1: .asciiz "\nIntroduza um inteiro (sinal e módulo): "
s2: .asciiz "\nValor em base 10 (signed): "
s3: .asciiz "\nValor em base 2: "
s4: .asciiz "\nValor em base 16: "
s5: .asciiz "\nValor em base 10(unsigned): "
s6: .asciiz "\nValor em base 10 (unsigned), formatado: "
    .text
    .globl main 

main:
    la      $a0,s1              
    li      $v0,printStr    
    syscall                     # printStr("\nIntroduza um inteiro (sinal e módulo): ");

    li      $v0,readInt10
    syscall                     # read_Int10() ;

    move    $t0,$v0             # value = readInt10();

    la      $a0,s2
    li      $v0,printStr
    syscall                     # printStr("\nValor em base 10 (signed): ");
    move    $a0,$t0             
    li      $v0,printInt10
    syscall                     # printInt10(value)

    la      $a0,s3              
    li      $v0,printStr    
    syscall                     # printStr("\nValor em base 2: ");

    move    $a0,$t0
    li      $a1,2       
    li      $v0,printInt
    syscall                     # printInt(value, 2);
    
    la      $a0,s4              
    li      $v0,printStr    
    syscall                     # printStr("\nValor em base 16: ");

    move    $a0,$t0
    li      $a1,16       
    li      $v0,printInt
    syscall                     # printInt(value, 16);

    la      $a0,s5              
    li      $v0,printStr    
    syscall                     # printStr("\nValor em base 10 (unsigned): ");

    move    $a0,$t0
    li      $a1,10       
    li      $v0,printInt
    syscall                     # printInt(value, 10);

    la      $a0,s6              
    li      $v0,printStr    
    syscall                     # printStr("\nValor em base 10 (unsigned), formatado: "); 

    

    jr      $ra