# EE271-Project

This was a project I did as part of my EE271 Coursework at SJSU where I designed a system to simulate the forward pass of a neural network in Verilog. 

The project requirements were as follows:
1) The user enters 16 16-bit values via a 4x4 Keypad matrix. 8 values are used as the inputs and 8 values are used to define the weights. 
2) After entering the data, the inputs should be stored in a SRAM that supports asynchronous read and write operations 
3) The forward pass is calculated via a 2-Staged MAC Pipeline
4) The inputs entered from the user, and the final result should be displayed on a seven segment display 
5) The state of the FPGA board should be displayed on an 16x2 LCD which is interfaced with an  Arduino Uno and the arduino in turn is interfaced with the FPGA board. 


Hardware used: 
- Intel DE10 Lite (Inbuilt Seven Segment Display)
- 16 x2 LCD 
- 4x4 Keypad Matrix 
- Arduino Uno 
