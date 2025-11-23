// This file is part of nand2tetris, as taught in The Hebrew University, and
// was written by Aviv Yaish. It is an extension to the specifications given
// [here](https://www.nand2tetris.org) (Shimon Schocken and Noam Nisan, 2017),
// as allowed by the Creative Common Attribution-NonCommercial-ShareAlike 3.0
// Unported [License](https://creativecommons.org/licenses/by-nc-sa/3.0/).

// The program should swap between the max. and min. elements of an array.
// Assumptions:
// - The array's start address is stored in R14, and R15 contains its length
// - Each array value x is between -16384 < x < 16384
// - The address in R14 is at least >= 2048
// - R14 + R15 <= 16383
//
// Requirements:
// - Changing R14, R15 is not allowed.


  @R14  // maxptr=minptr=R14
  D=M
  @maxptr
  M=D
  @minptr
  M=D

  @currentptr  // currentptr=R14, i=1
  M=D
  @i
  M=1

(LOOP)
  @R15  // if i=R15 jump to ENDLOOP
  D=M
  @i
  D=D-M
  @ENDLOOP
  D;JEQ

  @i  // i++, currentptr++, D=currentval=*currentptr
  M=M+1
  @currentptr
  M=M+1
  A=M
  D=M
  @currentval
  M=D

  @maxptr  // if currenval>max jump to UPDATEMAX
  A=M
  D=D-M
  @UPDATEMAX
  D;JGT
(RETMAX)

  @currentval  // D=currentval
  D=M

  @minptr  // if currenval<min jump to UPDATEMIN
  A=M
  D=D-M
  @UPDATEMIN
  D;JLT
(RETMIN)
  
  @LOOP  // jump to start of loop
  0;JMP

(UPDATEMAX)
  @currentptr  // maxptr=currentptr
  D=M
  @maxptr
  M=D
  @RETMAX
  0;JMP

(UPDATEMIN)
  @currentptr  // minptr=currentptr
  D=M
  @minptr
  M=D
  @RETMIN
  0;JMP

(ENDLOOP)

//swap max and min

  @maxptr  // temp=max
  A=M
  D=M
  @temp
  M=D
  
  @minptr  // max=min
  A=M
  D=M
  @maxptr
  A=M
  M=D

  @temp  // min=temp
  D=M
  @minptr
  A=M
  M=D

(END)
  @END
  0;JMP
  
  

  
  