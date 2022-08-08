#Written by Rachel Vargo CS2340, NetID: rmv200000
#Started March 9th, 2022
#These are the functions for the palindrone. Here does all conversions for 
#non letter or digit characters, to uppercase, and comparison all subcalled
#to each other.
	.text
	.globl	compare
	
compare:	#FIRST
	sw	$a0, 0($sp)			#saves argument in stack
	sw	$ra, 4($sp)			#saves $ra in stack
	li	$t6, 0				#loads for conversion
	jal	conversion
compareLoop:
	beq	$t3, $t4, compare2		#for middle of string
	lb	$t0, 0($s3)			#start at beginning of string
	lb	$t2, 0($s1)			#start at end of string 
	addi	$t4, $t4, 1			#counter for middle of string
	bne	$t0, $t2, compare1		#branches out if they do not match
	addi	$s3, $s3, 1			#add counter up for beginning of string
	addi	$s1, $s1, -1			#subtract counter down for end of string
	b	compareLoop				#continues loop for whole word
compare1:					#NEED to check if middle of string
	li	$s2, 0				#is 0 if not a palindrone, 1 if is
compare2:	
	lw	$a0, 0($sp)			#loads in argument
	lw	$ra, 4($sp)			#load in last address 
	addi	$sp, $sp, 8			#go back to last in stack
	jr	$ra				#last jump register, does not need stack
	
	
conversion:	#SECOND				#loop to check whether a digit or letter
	lb	$t0, 0($a0)			#loads the first byte from the string
	beq	$t0, $s0, conversionFinish	#branches to end once newline is found
	blt	$t0, '0', remove		#is a symbol that needs to be removed
	blt	$t0, '9', saveConversion	#is a digit and saves it
	bgt	$t0, 'z', remove		#branches to remove if less than 'z' to remove it
	blt	$t0, 'A', remove		#branches to remove if greater than 'A' to remove it
	b	saveConversion			#saves the letter or digit
remove:						#removes the symbol
	li	$t5, 1				#flags for removal
	addi	$a0, $a0, 1			#moves to next byte, skips last one
	b	conversion
saveConversion:					#saves the characters and moves on to next one
	bne	$t5, 1, next
	addi	$a0, $a0, -1
	sb	$t0, ($s3)			#save the string thats no symbols
	addi	$s3, $s3, 1			#moves to next byte to save to
	addi	$a0, $a0, 2			#moves to next byte
	addi	$t1, $t1, 1			#adds to length of string counter
	b	conversion
next:
	sb	$t0, ($s3)			#save the string thats no symbols
	addi	$s3, $s3, 1			#moves to next byte to save to
	addi	$a0, $a0, 1			#moves to next byte
	addi	$t1, $t1, 1			#adds to length of string counter
	b	conversion			#branches back to continue the loop
conversionFinish:				#save $ra to stack
	sub	$s3, $s3, $t1
	addi	$sp, $sp, -8			#to save space in stack
	sw	$a0, 0($sp)			#saves argument in stack
	sw	$ra, 4($sp)			#saves $ra in stack
	jal	toUpper				#jumps to make uppercase
	lw	$a0, 0($sp)			#loads in argument
	lw	$ra, 4($sp)			#load in last address 
	addi	$sp, $sp, 8			#go back to last in stack
	jr	$ra
	
	
toUpper:	#THIRD
	lb	$t0, 0($s3)			#loads byte from string
	beq	$t1, $t6, toUpper2		#ends at length of string and branches toUpper2
	bgt	$t0, 'z', toUpper1		#if greater than 'z' branch to make uppercase 
	blt	$t0, 'a', toUpper1		#if less than 'a' it is uppercase 
	addi	$t0, $t0, -32			#subtracts 32 to make uppercase
toUpper1:
	sb	$t0, ($s3)			#saves the byte
	addi	$s3, $s3, 1			#moves to next byte
	addi	$t6, $t6, 1
	b	toUpper				#continues loop till all characters uppercase
toUpper2:					#NEED to save $ra to stack
	add	$s1, $s3, -1			#for end of string 
	sub	$s3, $s3, $t1			#reset string
	div	$t3, $t1, 2			#for middle of string
	li	$t4, 0				#for compare counter
	addi	$sp, $sp, -8			#to save space in stack
	sw	$a0, 0($sp)			#saves the argument
	sw	$ra, 4($sp)			#saves $ra in stack
	jal	compareLoop			#jumps to compare if the string is a palindrone
	lw	$a0, 0($sp)			#loads back in argument
	lw	$ra, 4($sp)			#load in last address 
	addi	$sp, $sp, 8			#go back to last in stack
	jr	$ra
	
	

	
		
