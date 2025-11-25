
// C_PUSH constant 0
	@0
	D=A
	@SP
	A=M
	M=D
	@SP
	M=M+1

// C_POP local 0
	@0
	D=A
	@LCL
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

// label LOOP_START
(BasicLoop$LOOP_START)

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

// C_PUSH local 0
	@0
	D=A
	@LCL
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

// C_POP local 0
	@0
	D=A
	@LCL
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

// if-goto LOOP_START
	@SP
	AM=M-1
	D=M
	@BasicLoop$LOOP_START
	D;JNE

// C_PUSH local 0
	@0
	D=A
	@LCL
	A=D+M
	D=M
	@SP
	A=M
	M=D
	@SP
	M=M+1
