# Code where the game actually starts and plays till finished.
# Player and AI will go back and forth until the triangle of holes gets filled up numbers
# Winner is determined by least sum amounts from the numbers players put on the black hole board

.data 
game_msg: .asciiz "You have gone to the game portion of the program\n\n"


.text
game:

li $v0, 4
la $a0, game_msg
syscall

jr $ra

