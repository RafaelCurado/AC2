# int main(void)
#  {
#  char c;
#  do
#  {
#  c = getChar();
#  putChar( c );
#  } while( c != '\n' );
#  return 0;
#  } 
    .equ    getChar,2
    .equ    putChar,3
    .data
    .text
    .globl  main
main:

do:
    li      $v0,getChar
    syscall         
    move    $a0,$v0
    
    li      $v0,putChar
    syscall
while:
    bne    $a0,'\n',do
end:
    li     $v0,0            
    jr     $ra
