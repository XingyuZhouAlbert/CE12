Xingyu Zhou, xzhou45@ucsc.edu
Lab3: Ripple Adder With Memory
2018/2/7
01I, Eshan Hemmati

Magic numbers:0234, 0x6010,0b0111

FYI: If my circuit is not working properly, i.e: the output only shows 1,8,9 and 0, try reconnect the RESET part of the register. I'm not sure what caused this problem but I managed to fix it this way.

1.Describe what you learned, what was surprising, what worked well and what did not
To me, the most surprising part should be the signal extender and inverter. Using the ground/plus (the ground always gives 0, and plus always gives 1) components as signal extenders are much more efficient than using the switches. Switches are working properly in some ways but in this lab they are not supposed to be there. Also, the MUX is such a magic thing. It can choose between two outputs autimatically depending on the given situation which saves me a lot of time designing a (maybe) much more complex circuit.

2.Discuss issues you had building the circuit.
The first one should definitely be the signal extenders. As I mentioned in question 1, I used two switches to convert 4-bit to 6-bit but the question was that I had to manually flip the switches everytime, so I switched to ground/plus instead to avoid this problem.
The next one is the randomly disconnected wires. This bothers me a lot, especially for some parts that need a tons of wire connection (Ripple Adder, for example). Luckily, the existence of signal senders/receivers help me deal with that problem.

3.Describe what you added to each module to make debugging easier.
I'll go part by part.
For signal extender and inverter part, after adding an inverter to the 1 input of the MUX, I connected a LED to the output. When the add/sub switch is flip to 0, and my enter 1 on the keypad, the LED should light up, since it's in "add" mode and there's nothing to invert. When I flip to 1, which is subtract, the input "1" should be inverted to "0" and the LED should go dark. 
For the ripple adder and register part, I didn't really add anything to debug.

4.What happens when you subtract a larger number from a smaller number? Does the result make sense? What happens when you add two numbers that won¡¯t fit in 6 bits?
It makes sense to me. For example, I subtract 6 from 4. By performing this calculation on paper, the result I get is 111110 which is 62. On the calculator, the display shows 3E, which stands for 62 as well (I did this by adding 1 each time). Also, negative numbers start with leading 1, so in hexadecimal it can be really big.

When I add two numbers that won't fit in 6 bits, the display will just give me 0.
