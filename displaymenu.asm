# Displays menu for the player to look at to select mode

.data

menu_prompt:	.asciiz "********Black Hole********\n\t(1)Start\n\t(2)Tutorial\n\t(3)Quit\nPress respective number to command.\n\n"

.text

display_menu_prompt:

li $v0, 4
la $a0, menu_prompt
syscall

jr $ra

