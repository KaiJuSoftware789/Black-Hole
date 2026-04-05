.data
tutorial_msg: .asciiz "Tutorial not implemented yet. \n\n"

.text
tutorial:

	li $v0, 4
	la $a0, tutorial_msg
	syscall
	jr $ra

