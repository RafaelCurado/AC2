    .equ    inkey,  1
    .equ    putChar,    3
    .data
    .text
    .globl  main

main:                   # int main(void) {

do:
    li      $v0,inkey       #   inkey();
    syscall         
    move    $t0,$v0         #   
if: 
    beqz    $t0,else
    move    $a0,$t0
    li      $v0,putChar
    syscall
    j		while				# jump to while
else:
    li      $a0,'.'             
    li      $v0,putChar
    syscall
while:
    bne     $t0,'\n',do
    li      $v0,0
    jr      $ra 