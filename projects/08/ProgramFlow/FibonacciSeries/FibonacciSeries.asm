// Bootstrap code
	@256
	D=A
	@SP
	M=D

// C_PUSH argument 1
	@1
	D=A
	@ARG
	A=M+D
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
	A=M+D
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
	A=M+D
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
	A=M+D
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
	A=M-1
	D=M
	@R13
	M=D
	@SP
	M=M-1
	@SP
	A=M-1
	D=M
	@R13
	M=D-M
	D=M
	@SP
	A=M-1
	M=D

// C_POP argument 0
	@0
	D=A
	@ARG
	A=M+D
	D=A
	@R13
	M=D
	@SP
	AM=M-1
	D=M
	@R13
	A=M
	M=D

(MAIN_LOOP_START)

// C_PUSH argument 0
	@0
	D=A
	@ARG
	A=M+D
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
	@COMPUTE_ELEMENT
	D;JNE

// goto END_PROGRAM
	@END_PROGRAM
	0;JMP

(COMPUTE_ELEMENT)

// C_PUSH that 0
	@0
	D=A
	@THAT
	A=M+D
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
	A=M+D
	D=M
	@SP
	A=M
	M=D
	@SP
	M=M+1

// add
	@SP
	A=M-1
	D=M
	@R13
	M=D
	@SP
	M=M-1
	@SP
	A=M-1
	D=M
	@R13
	M=D+M
	D=M
	@SP
	A=M-1
	M=D

// C_POP that 2
	@2
	D=A
	@THAT
	A=M+D
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
	A=M-1
	D=M
	@R13
	M=D
	@SP
	M=M-1
	@SP
	A=M-1
	D=M
	@R13
	M=D+M
	D=M
	@SP
	A=M-1
	M=D

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
	A=M+D
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
	A=M-1
	D=M
	@R13
	M=D
	@SP
	M=M-1
	@SP
	A=M-1
	D=M
	@R13
	M=D-M
	D=M
	@SP
	A=M-1
	M=D

// C_POP argument 0
	@0
	D=A
	@ARG
	A=M+D
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
	@MAIN_LOOP_START
	0;JMP

(END_PROGRAM)
