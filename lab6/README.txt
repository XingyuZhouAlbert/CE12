Xingyu Zhou, xzhou45@ucsc.edu
Lab6: VIGNERE CIPHER
2018/3/9
01I, Eshan Hemmati

Magic Numbers: 0b1100

For this lab I learned how to write an actual subroutine and how jal works. Also, I've seen the effectiveness of the $sp and got more familiar with it during my coding process. One thing that surprised me the most was that how store byte works. I thought that sb $a2, ($v0) means to grab whatever that's in $v0 and put it in $a2 but it turned out to be the opposite way. I got stuck on it for so long untill I accidentally read the explanation when I typed sb. Besides that, everything else seems to work fine. 

1. What additional test code did you write? Why? Did it work?
I didn't use the test_Lab6.asm untill I finish all four subroutines. Before that, I added a "main" to the top of my code, manually loaded characters to $a0 and $a1 to see how each subroutine works. The test code works fine and it was convenient since I was not clear how the test_Lab6.asm worked at first. Also I think that if my own test code works fine then the test_Lab6.asm should be working as well, and it turned out that I'm correct.

2. What happens when you attempt encryption with a keystring that has illegal characters (for example, “NotALegalKey”? Why?
I test my code with the message "Hello World!" and the key "GoodbYe". There's still an output but with different result from the example in lab manual. For example, the second output is "y" instead of "s". The reason is that I assume the keys are always uppercase so I always subtract 65 to fit them into the range of 0-25. When the key is lower case, it will not be fitted into the range and thus and I conver it back to the actual ascii value, the result will be different. 

3. How would you write a recursive subroutine (a subroutine that calls itself)?
I think it would probably be mostly the same as calling another subroutine inside a subroutine. Just use jal + the label of my subroutine. The difference should be the use of $sp. Since each time I call my subroutine the the values store in my register will probably be overwritten so in order to prevent that from happening, I need to add some codes to store my previous value in the stack. 


4. According to MIPS calling conventions, arguments should be passed in the $a registers. There are only 4 of these registers. What could you do to pass more than 4 arguments into a subroutine?
The solution I can think of right now is to push them into the stack. Say if there are already 4 arguments, then I should just push the 5th one into the stack with the offset of 16 and increment the number by 4 each time I need to pass more arguments. 




