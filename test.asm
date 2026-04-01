# test file
.data

test_msg .asciiz "This is a test message"

.text
main: 

li $v0, 4
la $a0, test_msg
syscall