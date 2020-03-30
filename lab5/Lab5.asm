# Xingyu Zhou, xzhou45@ucsc.edu
# Lab5: Decimal to Binary Converter
# 2018/2/28
# 01I, Eshan Hemmati

#This is my very first coding class so I'll try my best to produce pseudo code.
# Pseudocode for Lab5
# Treat the input string as a number
# print the number and prompts
# int $s1 = 0, int $s2 = 0, $s4 = 0x80000000.
  # sign check
  # if $s0 = 45, jump to negative number conversion
    # else proceed to positive number conversion.
# Positive conversion loop
# load the first byte into $s0
# perform a series of calculations, store in $s1
# if $s0 = 0, goto data transfer
  # else loop back
    # move $s1 to $s0 as requested.
    #proceed to bit masking
# Negative conversion loop
# load the first byte into $s0
# perform a series of calculations, store in $s2
  # if $s0 = 0, perform 2SC
  # else loop back
    # 2SC
    # $s3 = !$s2
    # $s3 = $s3 + 1
    # proceed to bit masking
# Bitmasking loop
# $s6 = $s4 AND $s0
  # if $s0 is not equal to = 0
    #print 1
      #else
      	#print 0
  # if $s4 = 0
    # Exit the program
    # else
      # loop back.
    
  
.data
 input_prompt:  .asciiz "User input number:\n"
 output_prompt: .asciiz "This number in binary is:\n"
 newline: 	.asciiz "\n"

.text
main:
	lw $a1, ($a1)		#load user input into register
	la $a0, input_prompt	#user input prompt
	li $v0, 4
	syscall		#do the syscall
	la $a0, ($a1)		#print the user input number
	syscall
	la $a0, newline	#print newline after the user input number
	syscall
	la $a0, output_prompt	#print the output prompt
	syscall
	addi $s1, $0, 0		#initialize $s1
	addi $s2, $0, 0		#initialize $s2
	addi $s4, $0, 0x80000000	#initialize $s4 for Bitmasking
 
		Sign_Check:
  		lb $s0, ($a1)					#load the user input into register for sign check
  		beq $s0, 45, Negative_decimal_conversion	#if the ascii value of the first bit equal to the ascii value of "-", jump to negative
  
		Positive_decimal_conversion:
  		lb $s0, ($a1)		#load btyes into $s0 again for decimal conversion
  		beqz $s0, Data_transfer	#Exit the loop when the decimal conversion is finished.
  		mul $s1, $s1, 10	
  		subi $s0, $s0, 48	#subtract the ascii value of 0 from the original value to change it to decimal representation.
  		add $s1, $s0, $s1	#add each number together		
  		addi $a1, $a1, 1	#advance to the next bit
 		b Positive_decimal_conversion
    		
			Data_transfer:	#To store the binary number in $s0, as lab manual requested
    			move $s0, $s1
    			b Bitmasking

		Negative_decimal_conversion:
  		addi $a1, $a1, 1	#get pass the ascii value of the nagative sign at the beginning.
  		lb $s0, ($a1)		#load btyes into $s0 again for decimal conversion
  		beqz $s0, twos_complement	#branch to 2SC to obtain the negative number. 
  		mul $s2, $s2, 10
  		subi $s0, $s0, 48	#subtract the ascii value of 0 from the original value to change it to decimal representation.
  		add $s2, $s0, $s2	#add each number together
  		b Negative_decimal_conversion
  
			twos_complement:	#Flip the bits and add 1
    			not $s3, $s2	#flip the bits store in $s2 and put it into $s3
    			addi $s3, $s3, 1	#add 1 to complete the 2's complement
    			move $s0, $s3	#Store the binary number in $s0, as lab manual requested
 
	Bitmasking:
	beqz $s4, Exit		#exit the program when srl move pass the last bit.
 	and $s6, $s0, $s4	#AND my binary number with mask for printing, and puyt the result into $s6
 	bnez $s6, if		
 	beqz $s6, else
		if:		#if the first bit of $s6 = 1, print 1
   		li $v0, 1
   		li $a0, 1
   		syscall
   		srl $s4, $s4, 1	#Shift Right 1 bit each time.
   		b Bitmasking
			else:		#if $s6 = 0, print 0
     			li $v0, 1
     			li $a0, 0
     			syscall
     			srl $s4, $s4, 1	#Shift Right 1 bit each time.
     			b Bitmasking
 
	Exit:
	li $v0, 10
	syscall
