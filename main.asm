# Focus on movement recording and implementation for game
.data
prompt: .asciiz "Press movement key: \n"

key_press: .asciiz "Movement key: "

nl: .asciiz "\n"

.text
main:
loop:

	# Loads the system call 4 to immediate variable $v0 to be used.
	# Loads the address of prompt into variable $a0
	# System call 4 prints out the data of the address prompt.
	li $v0, 4
	la $a0, prompt
	syscall
	
	
	# Loads the system call 12 to read a character that is pressed from keyboard
	# System call 12 tells system to read a character because of reading the number 12 in $v0
	li $v0, 12
	syscall
	
	# Adds a newline to after keyboard has recorded character
	li $v0, 4
	la $a0, nl
	syscall
	
	# Moves $v0 to $t0 to be stored for later use so $v0 can be used for other cases
	move $t0, $v0
	
	# Loads immediate value 4 into $v0 for system call and loads address of key_press string to
	# to display the character key typed into the keyboard.
	# System call 4 prints out string to display before showing the key pressed.
	li $v0, 4
	la $a0, key_press
	syscall
	
	# Loads immediate value 11 into $v0 to store for system call
	# Moves the recorded key $a0 into $t0 to be used to print out as the character pressed on the keyboard.
	li $v0, 11
	move $a0, $t0
	syscall
	
	li $v0, 4
	la $a0, nl
	syscall
	
	j loop
	
	
   

