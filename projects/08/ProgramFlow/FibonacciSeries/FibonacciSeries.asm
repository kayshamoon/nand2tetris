
// C_PUSH argument 1
	@1
	D=A
	@ARG
	A=D+M
	D=M
	@SP
	A=M
	M=D
	@SP
	M=M+1

// C_POP pointer 1
	@4
	D=A
	@R13
	M=D
	@SP
	AM=M-1
	D=M
	@R13
	A=M
	M=D

// C_PUSH constant 0
	@0
	D=A
	@SP
	A=M
	M=D
	@SP
	M=M+1

// C_POP that 0
	@0
	D=A
	@THAT
	A=D+M
	D=A
	@R13
	M=D
	@SP
	AM=M-1
	D=M
	@R13
	A=M
	M=D

// C_PUSH constant 1
	@1
	D=A
	@SP
	A=M
	M=D
	@SP
	M=M+1

// C_POP that 1
	@1
	D=A
	@THAT
	A=D+M
	D=A
	@R13
	M=D
	@SP
	AM=M-1
	D=M
	@R13
	A=M
	M=D

// C_PUSH argument 0
	@0
	D=A
	@ARG
	A=D+M
	D=M
	@SP
	A=M
	M=D
	@SP
	M=M+1

// C_PUSH constant 2
	@2
	D=A
	@SP
	A=M
	M=D
	@SP
	M=M+1

// sub
	@SP
	AM=M-1
	D=M
	A=A-1
	M=M-D

// C_POP argument 0
	@0
	D=A
	@ARG
	A=D+M
	D=A
	@R13
	M=D
	@SP
	AM=M-1
	D=M
	@R13
	A=M
	M=D

// label MAIN_LOOP_START
(FibonacciSeries$MAIN_LOOP_START)

// C_PUSH argument 0
	@0
	D=A
	@ARG
	A=D+M
	D=M
	@SP
	A=M
	M=D
	@SP
	M=M+1

// if-goto COMPUTE_ELEMENT
	@SP
	AM=M-1
	D=M
	@FibonacciSeries$COMPUTE_ELEMENT
	D;JNE

// goto END_PROGRAM
	@FibonacciSeries$END_PROGRAM
	0;JMP

// label COMPUTE_ELEMENT
(FibonacciSeries$COMPUTE_ELEMENT)

// C_PUSH that 0
	@0
	D=A
	@THAT
	A=D+M
	D=M
	@SP
	A=M
	M=D
	@SP
	M=M+1

// C_PUSH that 1
	@1
	D=A
	@THAT
	A=D+M
	D=M
	@SP
	A=M
	M=D
	@SP
	M=M+1

// add
	@SP
	AM=M-1
	D=M
	A=A-1
	M=M+D

// C_POP that 2
	@2
	D=A
	@THAT
	A=D+M
	D=A
	@R13
	M=D
	@SP
	AM=M-1
	D=M
	@R13
	A=M
	M=D

// C_PUSH pointer 1
	@4
	D=M
	@SP
	A=M
	M=D
	@SP
	M=M+1

// C_PUSH constant 1
	@1
	D=A
	@SP
	A=M
	M=D
	@SP
	M=M+1

// add
	@SP
	AM=M-1
	D=M
	A=A-1
	M=M+D

// C_POP pointer 1
	@4
	D=A
	@R13
	M=D
	@SP
	AM=M-1
	D=M
	@R13
	A=M
	M=D

// C_PUSH argument 0
	@0
	D=A
	@ARG
	A=D+M
	D=M
	@SP
	A=M
	M=D
	@SP
	M=M+1

// C_PUSH constant 1
	@1
	D=A
	@SP
	A=M
	M=D
	@SP
	M=M+1

// sub
	@SP
	AM=M-1
	D=M
	A=A-1
	M=M-D

// C_POP argument 0
	@0
	D=A
	@ARG
	A=D+M
	D=A
	@R13
	M=D
	@SP
	AM=M-1
	D=M
	@R13
	A=M
	M=D

// goto MAIN_LOOP_START
	@FibonacciSeries$MAIN_LOOP_START
	0;JMP

// label END_PROGRAM
(FibonacciSeries$END_PROGRAM)
