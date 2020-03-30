#Xingyu Zhou, xzhou45@ucsc.edu
#Lab4 : DEADBEEF in MIPS
#2018/2/16
#01I, Eshan Hemmati
#The extra beq $s1, $s0, EXIT_Loop are used to eliminate the extra line

.data
  prompt1: .asciiz "DEAD"				#When the input integer is divisible by 4
  prompt2: .asciiz "BEEF"				#When the inout integer is divisible by 9
  prompt3: .asciiz "DEADBEEF"			#When the input integer is divisible by both 4 and 9
  prompt4: .asciiz "Please enter a number N: "
  Newline: .asciiz "\n" 
.text	
main:
  nop#print the first prompt
  li $v0, 4
  la $a0, prompt4
  syscall
  nop#takes the higher boundry value
  li $v0, 5
  syscall
  move $s1, $v0
		
 begin_loop:	
  nop#Exit if user inputs equal to counter  
  beq $s1, $s0, EXIT_loop
  nop#print integers based on user inputs
  li $v0, 1
  addi $s0, $s0, 1	#this is qeual to a0 = a0 + 1
    nop#Check remainders and store them to $s2-$s4
    rem $s2, $s0, 4
    rem $s3, $s0, 9
    or $s4, $s3, $s2
    nop#the IF part
      nop#Jump to DEADBEEF 
      beqz $s4, DEADBEEF
    nop#The ELSE Part
       nop#Jump to DEAD	
       beqz $s2, DEAD
    nop#The Else if Part
         nop#Jump to BEEF
         beqz $s3, BEEF
         	
  nop#assign $s0 to $a0 so that it can be printed out.		
  move $a0, $s0
  syscall 
  nop#To eliminate the extra blank.
  beq $s1, $s0, EXIT_loop 	
  nop#Make a newline
  li $v0, 4
  la $a0, Newline
  syscall
  b begin_loop
	
DEAD:	
  nop#print "DEAD"
  li $v0, 4
  la $a0, prompt1
  syscall  
  beq $s1, $s0, EXIT_loop  
  li $v0, 4
  la $a0, Newline
  syscall	
  b begin_loop
	
BEEF:	
  nop#print "BEEF"
  li $v0, 4
  la $a0, prompt2
  syscall 
  beq $s1, $s0, EXIT_loop 
  li $v0, 4
  la $a0, Newline
  syscall	
  b begin_loop
	
DEADBEEF: 
  nop#print "DEADBEEF"
  li $v0, 4
  la $a0, prompt3
  syscall 
  beq $s1, $s0, EXIT_loop  
  li $v0, 4
  la $a0, Newline
  syscall	
  b begin_loop
		
EXIT_loop:	
  nop#terminate the program
  li $v0, 10
  syscall
