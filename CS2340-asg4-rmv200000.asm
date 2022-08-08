# Written by Rachel Vargo, CS2340 NetId: rmv200000
# Started March 9th, 2022
# This program takes a user entered string and determines whether it is a palindrone. It does so
#by reading the user entered string, removes all not letter or number characters, converts all
#characters to uppercase, and compares the characters. It is terminated either by nothing entered
#for a string or after the result is determined. 	
	
	.data
	.include	"SysCalls.asm"
start:	.asciiz		"Enter a string: "
isPal:	.asciiz		"Palindrone.\n"
notPal:
	.asciiz		"Not a Palindrone.\n"
string:	.space		200			#user entered string, length in assignment
strcpy: .space		200			#to copy the nonalpha/digit characters to
	.globl main
	.text
main:
	li	$v0, SysPrintString
	la	$a0, start
	syscall					#asks for user entered string
	li	$v0, SysReadString
	la	$a0, string			#loads the space for the string
	li	$a1, 200			#assigned length
	syscall					#enters the users string
	li	$s0, '\n'			#put newline character in $s0 for checking
	li	$t1, 0				#for length checker
	li	$s2, 1				#for if or not palindrone
	lb	$t0, 0($a0)			#loads the first byte from the string
	beq	$t0, $s0, exit			#if first character newline, exits program
	la	$s3, strcpy			#loads address for compare function
	jal	compare
	li	$t0, 0				#reset counter
	beq	$s2, 0, notPalindrone		#if $s2 contains a 0 it is not a palindrone and branches
	li	$v0, SysPrintString	
	la	$a0, isPal			#prints out this is a palindrone
	syscall
	b	main				#continues the loop to ask for another string
notPalindrone:
	li	$v0, SysPrintString
	la	$a0, notPal			#prints out is not a palindrone
	syscall
	b	main				#continues the loop to ask for another string
exit:
	li	$v0, SysExit			#terminates the program
	syscall
