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
	@TRUE0
	D;JLT
	D=0
	@END0
	0;JMP
(TRUE0)
	D=-1
(END0)
	@SP
	A=M
	M=D
	@SP
	M=M+1

// if-goto IF_TRUE
	@SP
	AM=M-1
	D=M
	@IF_TRUE
	D;JNE

// goto IF_FALSE
	@IF_FALSE
	0;JMP

(IF_TRUE)

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

(IF_FALSE)

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
	@RETURN_ADDRESS_0
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
(RETURN_ADDRESS_0)

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
	@RETURN_ADDRESS_1
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
(RETURN_ADDRESS_1)

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
	@RETURN_ADDRESS_0
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
(RETURN_ADDRESS_0)

(WHILE)

// goto WHILE
	@WHILE
	0;JMP
