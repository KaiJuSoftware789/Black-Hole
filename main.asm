# Game will flow like this:
# 1. Player starts up game
# 2. 2 different options pop up:
	# - Play
	# - Quit
	
# 3. If player chooses one, that option will start their portion of the program.
	# - Play: start the game
	# - Quit: quits the game with some type of system exit

.include "displaymenu.asm"
.include "game.asm"

.data
error_msg: .asciiz "Invalid number. Please try again.\n"

.text
.globl main

main:
    jal display_menu_prompt

    li $v0, 5
    syscall
    move $t0, $v0

    beq $t0, 1, start
    beq $t0, 2, quit
    j default_case

start:
    jal game
    j main

quit:
    li $v0, 10
    syscall

default_case:
    li $v0, 4
    la $a0, error_msg
    syscall
    j main
	
	






	
	
   

