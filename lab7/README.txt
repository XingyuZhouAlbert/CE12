Xingyu Zhou, xzhou45@ucsc.edu
Lab7: Floating Point Calculations
2018/3/17
01I, Eshan Hemmati

In this lab I learned how to do floating point calculations.One thing that worked surprisingly well was that instead of converting the exponent bits to decimal then perform the calculation, I can just directly subtract the binary value of 127 from the exponent bits and then convert the result to decimal to get the real exponent factor, that way is much more efficient. Everything else works fine.

1.What are the largest and smallest positive numbers IEEE 745 SP floating point can express? Describe them in IEEE 745 SP and in decimal base-10 scientific notation.
The smallest number will be 0 00000000 00000000000000000000001 and this number in decimal is 2^(-150). The Largest number is 0 11111111 follow by 23 1s. In decimal form this number is (2-(2^-23) * 2^(128).

2.IEEE 745 SP uses bias representation in the exponents to speed up floating point addition and subtraction. Why is this faster than using 2SC representation?
I think it's because of the content that the computer needs to process. Say in 2SC, it has to compare not only the exponent bits but significand bits (mantisa) as well. It's already a lot of work since there are 32 bits. However if it's in bias representation, the comparison will be much simplier since it's comparing two intergers. 

3.Imagine you are using a MIPS processor which does not contain specialized hardware for floating point operations. You must instead code these yourself. Write some pseudocode for subroutines called FL_add and FL_mult, which will perform floating point addition and multiplication on two IEEE 745 SP numbers. Don¡¯t forget to check for zero! 
FL_add: 
# Convert both FL number to binary
# Load and read the first bit, determine the sign.
# Store the sign.
# Set up a counter for a for loop
# This for loop will run 8 times to grab the exponent bits.
# Subtract the bias from this exponent bits.
# Obtain the real exponent factor.
# Check if both exponent factor are equal.
# If not, use srl.
# Add the significand together. Store in a $t regester.(I'm not sure how to express the "1." in Mars)
# Add 127 to obtain the new exponent bits.
# Combine the sign, the exponent bits and the significand together. 
# Read this binary number again, convert back to hex.

FL_mult:
# Same as above.
# Change the ADD part to MUL.
# Instead of shifting the radix
# I'm going to add the real expo factor together.

