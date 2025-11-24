// Bootstrap code
@256
D=A
@SP
M=D
@Sys.init
0;JMP

// function Main.fibonacci 0
(Main.fibonacci)

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

// lt
	@SP
	AM=M-1
	D=M
	@R14
	M=D
	@SP
	AM=M-1
	D=M
	@R13
	M=D
	@R13
	D=M
	@R14
	D=D-M
	@Main.fibonacci$TRUE_0
	D;JLT
	D=0
	@Main.fibonacci$END_0
	0;JMP
(Main.fibonacci$TRUE_0)
	D=-1
(Main.fibonacci$END_0)
	@SP
	A=M
	M=D
	@SP
	M=M+1

// if-goto IF_TRUE
	@SP
	AM=M-1
	D=M
	@Main.fibonacci$IF_TRUE
	D;JNE

// goto IF_FALSE
	@Main.fibonacci$IF_FALSE
	0;JMP
(Main.fibonacci$IF_TRUE)

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
(Main$IF_FALSE)

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

// call Main.fibonacci 1
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
	@6
	D=D-A
	@ARG
	M=D
	@SP
	D=M
	@LCL
	M=D
	@Main.fibonacci
	0;JMP
($ret.0)

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

// call Main.fibonacci 1
	@$ret.1
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
	@6
	D=D-A
	@ARG
	M=D
	@SP
	D=M
	@LCL
	M=D
	@Main.fibonacci
	0;JMP
($ret.1)

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

// function Sys.init 0
(Sys.init)

// C_PUSH constant 4
	@4
	D=A
	@SP
	A=M
	M=D
	@SP
	M=M+1

// call Main.fibonacci 1
	@Sys.init$ret.0
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
	@6
	D=D-A
	@ARG
	M=D
	@SP
	D=M
	@LCL
	M=D
	@Main.fibonacci
	0;JMP
(Sys.init$ret.0)
(Sys.init$WHILE)

// goto WHILE
	@Sys.init$WHILE
	0;JMP
