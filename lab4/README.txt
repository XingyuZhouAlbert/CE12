Xingyu Zhou, xzhou45@ucsc.edu
Lab4: DEADBEEF IN MIPS
2018/2/16
01I, Eshan Hemmati

Magic Number: 0b0111, 9671, 3333

1. In theory, how large can N be before your program fails? What determines this limit?
In Thurday's class, the professor says the limit is 4Gb. I think it depends on the bytes that the registers can store in toall.

2. The text of your prompt ("Please enter a number:") is stored in the processor's memory. After assembling your program, what is the range of addresses in which this string is stored?
it's 25.

3. Of the instructions you used, which were pseudo-ops (instructions that are not part of the MIPS instruction language, that were translated into other instructions by the assembler)? How do the assembled instructions produce the appropriate result?

A lot actually. There are branches, addition, remainder and list immediate. Pseudocodes will make the program easier for the programmer to read. For example, I use a pseudo-op "move". When I'm running the program, the "move" will be expanded to the actual assembly language "addi $s0, $s1, $s2". In my opinion, for each pseudocode there will be a corresponding expansion, and that's how the assembled instructions produce the appropriate result.


4. How many registers did you use in writing this program? Could you have used fewer registers? Describe how, or explain why you cannot.
For the $s registers, I use 5 of them ($s0, $s4). I also repeatedly use $a0 and $v0 in this program, so that would be 19 in total. (some of the registers shares the same value so I didn't count them in). 

It's possible to use fewer registers. For example, when I'm printing the new line. Instead of loading my Newline command in to $a0 and have it print out each time, I can just add "\n" after my message. However, doing so will result in a blank line at the bottom if the last thing I print is "DEAD" or "BEEF" or "DEADBEEF". The only way I can think of to eliminate the blank line is to insert a condition branch between print the word and print a newline. 
For the division part, I could use "div" but I have to assign value "4" and "9" to different registers first, and then I can perform the division correctly. With the "rem" command, I can directly use the numbers without putting them into registers first.
