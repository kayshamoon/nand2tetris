// This file is part of nand2tetris, as taught in The Hebrew University, and
// was written by Aviv Yaish. It is an extension to the specifications given
// [here](https://www.nand2tetris.org) (Shimon Schocken and Noam Nisan, 2017),
// as allowed by the Creative Common Attribution-NonCommercial-ShareAlike 3.0
// Unported [License](https://creativecommons.org/licenses/by-nc-sa/3.0/).

// Multiplies R0 and R1 and stores the result in R2.
//
// Assumptions:
// - R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.
// - You can assume that you will only receive arguments that satisfy:
//   R0 >= 0, R1 >= 0, and R0*R1 < 32768.
// - Your program does not need to test these conditions.
//
// Requirements:
// - Your program should not change the values stored in R0 and R1.
// - You can implement any multiplication algorithm you want.

// pseudo code

// i=0
// sum=0
// loop
// if i=R0 jump endloop
// sum=sum+R1
// i++
// jump loop

// endloop
// R2=sum

  @i  // i=0 , sum=0
  M=0
  @sum
  M=0

(LOOP)
  @R0  // if i=R0 jump endloop
  D=M
  @i
  D=D-M
  @ENDLOOP
  D; JEQ
  
  @R1  // sum=sum+R1
  D=M
  @sum
  M=M+D

  @i  // i++
  M=M+1

  @LOOP
  0; JMP   // jmp loop

(ENDLOOP)
  @sum  // R2=sum
  D=M
  @R2
  M=D
  
(END)
  @END
  0; JMP
