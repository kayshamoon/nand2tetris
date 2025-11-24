// Bootstrap code
@256
D=A
@SP
M=D
@Sys.init
0;JMP

// function SimpleFunction.test 2
(SimpleFunction.test)
	@0
	D=A
	@SP
	A=M
	M=D
	@SP
	M=M+1
	@0
	D=A
	@SP
	A=M
	M=D
	@SP
	M=M+1

// C_PUSH local 0
	@0
	D=A
	@LCL
	A=M+D
	D=M
	@SP
	A=M
	M=D
	@SP
	M=M+1

// C_PUSH local 1
	@1
	D=A
	@LCL
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

// not
	@SP
	A=M-1
	M=!M

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

// return
	@LCL
	D=M
	@R13
	M=D
	@5
	A=D-A
	D=M
	@R14
	M=D
	@SP
	AM=M-1
	D=M
	@ARG
	A=M
	M=D
	@ARG
	D=M+1
	@SP
	M=D
	@R13
	AM=M-1
	D=M
	@THAT
	M=D
	@R13
	AM=M-1
	D=M
	@THIS
	M=D
	@R13
	AM=M-1
	D=M
	@ARG
	M=D
	@R13
	AM=M-1
	D=M
	@LCL
	M=D
	@R14
	A=M
	0;JMP
