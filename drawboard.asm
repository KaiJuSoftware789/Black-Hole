# File to display the board to the player

.include "notation.asm"
.data
horizontalborder: .asciiz "+--------+---------+\n"
verticalpad: .asciiz "|"
newline .asciiz "\n"

# Rows that start with element in triangle
rowStart: .byte 0, 1, 3, 6, 10, 15
                                    
  

.text
.globl displayGameBoard


# Updates the screen after modifications
displayGameBoard:

li $v0, 4
la $a0, horizontalborder
syscall 
li $v0, 4
la $a0, verticalpad
syscall 



li $v0, 4
la $a0, verticalpad
syscall 
li $v0, 4
la $a0, horizontalborder
syscall 

