Xingyu Zhou, xzhou45@ucsc.edu
Lab5: Decimal to Binary Converter
2018/2/28
01I, Eshan Hemmati

Magic number:0b1010, 0x0745, 0123


1. What happens if the user inputs a number that is too large to fit in a 32-bit 2SC number?
What will happen is that the program will terminate with error arithmetic overflow. The input number is 2^31. However, when I add 2 to 2^31, my program works properly again. I'm not sure how does this happen. 

2. What happens if the user inputs a number that is too small (large magnitude, but negative) to fit in a 32-bit 2SC number?
The situation is the same as what I have in question 1.

3. What is the difference between the mult and the multu instructions? Which one did you use, and why?
Mult and Multu are both doing multiplications with 64-bits and there will be no arithmetic exceptions for both instructions. Multu is the unsigned multiplication.Both mult and multu store their result in LO and HI registers. 
I use neither of them. The one I use is mul since the lab manual says that I can assume the input is always within the range of 32-bits and that this is the first instruction that came up in my mind.


4. Consider how you might write a binary-to-decimal converter, in which the user inputs a string of ASCII "0"s and "1"s and your code prints an equivalent decimal string. How would you write your code? How is the BDC like the DBC, and how is it different?
I think most of the codes will be besically the same as decimal to binary converter. The differences will be: 
1.In DBC, I multiply the converted number by 10 and add them together. While in BDC, I think what I need to do is to multiply the number by 2 and add them together instead.
2.When printing the binary, I use bitmasking to detect the digit and print out 1 or 0 accordingly, but now all I need to do is to use syscall 1 to print out my number directly, without using bitmasking.