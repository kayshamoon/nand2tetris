// Bootstrap code
@256
D=A
@SP
M=D

// call Sys.init 0
	@$ret.0
	D=A
	@SP
	A=M
	M=D
	@SP
	M=M+1
	@LCL
	D=M
	@SP
	A=M
	M=D
	@SP
	M=M+1
	@ARG
	D=M
	@SP
	A=M
	M=D
	@SP
	M=M+1
	@THIS
	D=M
	@SP
	A=M
	M=D
	@SP
	M=M+1
	@THAT
	D=M
	@SP
	A=M
	M=D
	@SP
	M=M+1
	@SP
	D=M
	@5
	D=D-A
	@ARG
	M=D
	@SP
	D=M
	@LCL
	M=D
	@Sys.init
	0;JMP
($ret.0)

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

// label LOOP_START
(BasicLoop$LOOP_START)

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
	A=M+D
	D=M
	@SP
	A=M
	M=D
	@SP
	M=M+1
