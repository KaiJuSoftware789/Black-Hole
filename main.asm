# Game will flow like this:
# 1. Player starts up game
# 2. 3 different options pop up:
	# - Play
	# - Tutorial
	# - Quit
	
# 3. If player chooses one, that option will start their portion of the program.
	# - Play: start the game
	# - Tutorial: loads steps at player's pace to teach player how to play
	# - Quit: Quits the game with some type of system exit

.include "displaymenu.asm"
.include "game.asm"
.include "tutorial.asm"

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
    beq $t0, 2, run_tutorial
    beq $t0, 3, quit
    j default_case

start:
    jal game
    j main

run_tutorial:
    jal tutorial
    j main

quit:
    li $v0, 10
    syscall

default_case:
    li $v0, 4
    la $a0, error_msg
    syscall
    j main
	
	






	
	
   

