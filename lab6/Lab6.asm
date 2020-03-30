# Xingyu Zhou xzhou45@ucsc.edu
# Lab6: VIGNERE CIPHER
# 2018/3/9
# 01I, Eshan Hemmati

# Pseudocode for lab6
# EncryptChar
# check the value of $a0
# if ( 65 <= $a0 <= 90 ) UPPER
#	$a0 = $a0 - 65
#	$a1 = $a1 - 65
#	add $a0 and $a1
#	take the result of ($a1 + $a0) mod 26
#	convert back to original asciivalue
#	by adding 65
#	jump back to main function
# elseif ( 97 <= $a0 <= 122) LOWER
#	$a0 = $a0 -97
#	$a1 = $a1 - 65
#	take the result of ($a1 + $a0) mod 26 
#	convert back to ascii value by adding
#	97
#	Jump back to main function
# else ( $a0 <= 64 || $a0 >= 123) Special Char
#	print the char directly
#	Jump back to main function

# DecryptChar
# check the value of $a0
# if ( 65 <= $a0 <= 90 ) UPPER
#	$a0 = $a0 - 65
#	$a1 = $a1 - 65
# 	subtract $a1 from $a0
#	add 26 to always stay positive
#	take the result of ($a0 - $a1) mod 26
#	convert back to original asciivalue
#	by adding 65
#	Jump back to main function
# elseif ( 97 <= $a0 <= 122) LOWER
#	$a0 = $a0 - 97
#	$a1 = $a1 - 65
# 	subtract $a1 from $a0
#	add 26 to always stay positive
#	take the result of ($a0 - $a1) mod 26
#	convert back to original asciivalue
#	by adding 97
#	Jump back to main function
#	else ( $a0 <= 64 || $a0 >= 123) Special Char
#	print the char directly
#	Jump back to main function

# EncryptString
# push $ra to stack and store it
# move $a0 to $t3, $a1 to $t4 and $t5, $a2 to $t9
# int $s0 = 0
# (Im not sure how to translate the following into appropriate languages)
# 	load byte into $a0 and $a1 for encryption.
# 	check conditions to make sure $a0 stays in the correct boundary.
#	if $a1 = 0 and $a0 is not equal to 0
#		reset $a1 and keep going
#		jump to encryptChar
#		store the result in $a2
#	elseif $a1 and $a0 both not equal to 0
#		advance both $a0 and $a1 by 1
#		jump to encryptChar
#		store the result in $a2
#	elseif $a0 is in specialchar range
#		stop advancing $a1
#		jump to encryptchar
#		store the result in $a2
#	elseif $a0 = 0
#		end the loop
#		pop $ra out of stack
#		reset $a2 and $s0
#		return to main function
#	else $s0 = 30 which is the counter
#		end the loop
#		pop $ra out of stack
#		reset $a2 and $s0
#		return to main function

# DecryptString
# push $ra to stack and store it
# move $a0 to $t6, $a1 to $t7 and $t8, $a2 to $t9
# int $s1 = 0
# (Im not sure how to translate the following into appropriate languages)
# 	load byte into $a0 and $a1 for encryption.
# 	check conditions to make sure $a0 stays in the correct boundary.
#	if $a1 = 0 and $a0 is not equal to 0
#		reset $a1 and keep going
#		jump to encryptChar
#		store the result in $a2
#	elseif $a1 and $a0 both not equal to 0
#		advance both $a0 and $a1 by 1
#		jump to decryptChar
#		store the result in $a2
#	elseif $a0 is in specialchar range
#		stop advancing $a1
#		jump to decryptchar
#		store the result in $a2
#	elseif $a0 = 0
#		end the loop
#		pop $ra out of stack
#		reset $a2 and $s0
#		return to main function
#	else $s1 = 30 which is the counter
#		end the loop
#		pop $ra out of stack
#		reset $a2 and $s1
#		return to main function

	
# Subroutine EncryptChar
# Encrypts a single character using a single key character.
# input: $a0 = ASCII character to encrypt
# $a1 = key ASCII character
# output: $v0 = Vigenere-encrypted ASCII character
# Side effects: None
# Notes: Plain and cipher will be in alphabet A-Z or a-z
# key will be in A-Z
.text	
EncryptChar:
	# In this subroutine, below registers other than $a0, $a1 and $v0 is used
	# $t0 and $t1 are used to save the character's value within the ciper's range (0-25)
	# $t2 is used to save the value from addition and the result of modulo.
		__Lower_Boundary_Check:
		bge $a0, 65, __Upper_Boundary_Check
		nop
		ble $a0, 64, __Special_Char
			__Upper_Boundary_Check:	
			ble $a0, 90, __Upper_Case
			nop
			ble $a0, 96, __Special_Char
			nop
			ble $a0, 122, __Lower_Case
			nop
			__Special_Char:
			move $v0, $a0		#print the original value if out of range.
			jr $ra
			#detect whether it's lower or upper case
			#if (65 <= $a0 <= 90), do upper case
			__Upper_Case:
			sub $t0, $a0, 65	#obtain the value in the range of o-25
			sub $t1, $a1, 65	
			add $t2, $t1, $t0	#add them together for the calculation
			rem $t2, $t2, 26	#(Mi+Ki)%26
			addi $t2, $t2, 65	#conver it back to the original ascii value so that it can be print out
			move $v0, $t2		#move the result back to $v0, as the manual requested.
			jr $ra
				#else, do lower case
				__Lower_Case:
				sub $t0, $a0, 97	#Comments same as __Upper_Case
				sub $t1, $a1, 65
				add $t2, $t1, $t0
				rem $t2, $t2, 26
				addi $t2, $t2, 97
				move $v0, $t2		#move teh result back to $v0, as the manual requested.
				jr $ra
			

# Subroutine DecryptChar
# Decrypts a single character using a single key character.
# input: $a0 = ASCII character to decrypt
# $a1 = key ASCII character
# output: $v0 = Vigenere-decrypted ASCII character
# Side effects: None
# Notes: Plain and cipher will be in alphabet A-Z or a-z
# key will be in A-Z
.text
DecryptChar:
	# In this subroutine, below registers other than $a0, $a1 and $v0 is used
	# $t0 and $t1 are used to save the character's value within the ciper's range (0-25)
	# $t2 is used to save the value from addition and the result of modulo.
	__Lower_Boundary_Check_Dec:
	bge $a0, 65, __Upper_Boundary_Check_Dec
	nop
	blt $a0, 64, __Special_Char_Dec
	nop
		__Upper_Boundary_Check_Dec:	
		ble $a0, 90, __Upper_Case_Dec
		nop
		ble $a0, 96, __Special_Char_Dec
		nop
		ble $a0, 122, __Lower_Case_Dec
		nop
		__Special_Char_Dec:
		move $v0, $a0		#print the original value if out of range.
		jr $ra
		#detect whether it's lower or upper case
		#if (65 <= $a0 <= 90), do upper case
		__Upper_Case_Dec:
		sub $t0, $a0, 65	#obtain the value in the range of o-25
		sub $t1, $a1, 65	
		sub $t2, $t0, $t1	#add them together for the calculation
		addi $t2, $t2, 26	#Make sure it's positive
		rem $t2, $t2, 26	#(Mi+Ki)%26
		addi $t2, $t2, 65	#conver it back to the original ascii value so that it can be print out
		move $v0, $t2		#move the result back to $v0, as the manual requested.
		jr $ra
			#else, do lower case
			__Lower_Case_Dec:
			sub $t0, $a0, 97	#Comments same as __Upper_Case
			sub $t1, $a1, 65
			sub $t2, $t0, $t1
			addi $t2, $t2, 26	#make sure it's positive
			rem $t2, $t2, 26
			addi $t2, $t2, 97
			move $v0, $t2		#move teh result back to $v0, as the manual requested.
			jr $ra

	
# Subroutine EncryptString
# Encrypts a null-terminated string of length 30 or less,
# using a keystring.
# input: $a0 = Address of plaintext string
# $a1 = Address of key string
# $a2 = Address to store ciphertext string
# output: None
# Side effects: String at $a2 will be changed to the
# Vigenere-encrypted ciphertext.
# $a0, $a1, and $a2 may be altered

# In the following subroutine, $t3, $t4
# $t5 and $t9 are used to storethe value 
# of $a0, $a1. $t5 is used as RESET
# $s0 is used as counter, which will be 
# reset to it's original value as the program 
# exits.
.text
EncryptString:
	sw $ra, ($sp)		#store the address of $ra for the loop
	subi $sp, $sp, 4	#push the stack	
	move $t3, $a0		#move $a0 to $t3
	move $t4, $a1		#move $a1 to $t4
	move $t5, $t4		#store the key string address in two different register
	move $t9, $a2
	addi $s0, $0, 0		#set up a counter
		__Read_String_Loop:
		lb $a0, ($t3)			#reload the value back to $a0 for encryption
		lb $a1, ($t4)			#reload the value back to $a1 for encryption
		beqz $a0, __Exit_loop		#exit the loop when the input string ends.
		nop
		bge $s0, 30, __Exit_loop 	#Limited the range to 30 characters
		nop
		__Lower_Bound_Check_Str:
		bgt $a0, 65, __Upper_Bound_Check_Str
		nop
		ble $a0, 64, __Proceed1		#Skip the special char
		nop
		__Upper_Bound_Check_Str:
		ble $a0, 90, __Advance_Key
		nop
		ble $a0, 96, __Proceed1	#Skip the special char
		nop
		ble $a0, 122, __Advance_Key
		nop
		__Proceed1:
		addi $t3, $t3, 1	#move to the next char
		beqz $a1, __Repeat_Key_Loop
		nop
		__Proceed2:
		jal EncryptChar
		nop
		sb $v0, ($a2)		#store the output to the $a2.
		addi $a2, $a2, 1 	#increment the $a2.
		addi $s0, $s0, 1	#increment counter.
		b __Read_String_Loop
		nop
			__Repeat_Key_Loop:
			move $t4, $t5	#Reset the value of $t4, so that it can go back to the first char.
			lb $a1, ($t4)	#load the rested value back to a1.
			addi $t4, $t4, 1	
			b __Proceed2
			nop
			__Advance_Key:
			addi $t4, $t4, 1	#move to the next key	
			b __Proceed1
			nop
	__Exit_loop:
	addi $sp, $sp, 4	#pop the stack
	lw $ra, ($sp)		#reload the address of $ra
	move $a2, $t9
	sub $s0, $s0, $s0	#reset the value of $s0
	jr $ra
	nop


# Subroutine DecryptString
# Decrypts a null-terminated string of length 30 or less,
# using a keystring.
# input: $a0 = Address of ciphertext string
# $a1 = Address of key string
# $a2 = Address to store plaintext string
# output: None
# Side effects: String at $a2 will be changed to the
# Vigenere-decrypted plaintext
# $a0, $a1, and $a2 may be altered

# In this section, $t6, $t7 and $t8 are used
# to store the value of $a0, $a1 as well as
# the RESET buttom for Key string.
# $s1 is used as a counter which will be reseted
# to the original value at the time program exirs.
.text
DecryptString:
	move $t6, $a0		#move $a0 to $t3
	move $t7, $a1		#move $a1 to $t4
	move $t8, $t7		#store the key string address in two different registers
	sw $ra, ($sp)		#store the address of $ra for the loop
	subi $sp, $sp, 4	#push the stack	
	move $t9, $a2		#store the address in $t9
	addi $s1,$0, 0		#initialize counter
	
		__Read_String_Loop_Dc:
		lb $a0, ($t6)			#reload the value back to $a0 for encryption
		lb $a1, ($t7)			#reload the value back to $a1 for encryption
		beqz $a0, __Exit_loop_Dc	#exit the loop when the input string ends.
		nop
		bge $s1, 30, __Exit_loop_Dc		#limit the range to 30 char.
		nop
		__Lower_Bound_Check_Str_Dc:
		bgt $a0, 65, __Upper_Bound_Check_Str_Dc
		nop
		ble $a0, 64, __Proceed1_Dc		#Skip the special char
		nop
			__Upper_Bound_Check_Str_Dc:
			ble $a0, 90, __Advance_Key_Dc
			nop
			ble $a0, 96, __Proceed1_Dc	#Skip the special char
			nop
			ble $a0, 122, __Advance_Key_Dc
			nop
		__Proceed1_Dc:
		addi $t6, $t6, 1	#move to the next char
		beqz $a1, __Repeat_Key_Loop_Dc
		nop
		__Proceed2_Dc:
		jal DecryptChar
		sb $v0, ($a2)		#store the output to the $a2.
		addi $a2, $a2, 1 	#increment the $a2.
		addi $s1, $s1, 1	#increment $s1
		b __Read_String_Loop_Dc
		nop
			__Repeat_Key_Loop_Dc:
			move $t7, $t8	#Reset the value of $t4, so that it can go back to the first char.
			lb $a1, ($t7)	#load the rested value back to a1.
			addi $t7, $t7, 1	
			b __Proceed2_Dc
			nop
			__Advance_Key_Dc:
			addi $t7, $t7, 1	#move to the next key	
			b __Proceed1_Dc
			nop
	__Exit_loop_Dc:
	addi $sp, $sp, 4	#pop the stack
	lw $ra, ($sp)		#reload the address of $ra
	move $a2, $t9 		#move the address back
	sub $s1, $s1, $s1	#obtain the original value
	jr $ra
