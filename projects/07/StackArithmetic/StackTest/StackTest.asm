
// C_PUSH constant 17
	@17
	D=A
	@SP
	A=M
	M=D
	@SP
	M=M+1

// C_PUSH constant 17
	@17
	D=A
	@SP
	A=M
	M=D
	@SP
	M=M+1

// eq
	@SP
	AM=M-1
	D=M
	A=A-1
	D=M-D
	@$FALSE.0
	D;JNE
	@SP
	A=M-1
	M=-1
	@$END.0
	0;JMP
($FALSE.0)
	@SP
	A=M-1
	M=0
($END.0)

// C_PUSH constant 17
	@17
	D=A
	@SP
	A=M
	M=D
	@SP
	M=M+1

// C_PUSH constant 16
	@16
	D=A
	@SP
	A=M
	M=D
	@SP
	M=M+1

// eq
	@SP
	AM=M-1
	D=M
	A=A-1
	D=M-D
	@$FALSE.1
	D;JNE
	@SP
	A=M-1
	M=-1
	@$END.1
	0;JMP
($FALSE.1)
	@SP
	A=M-1
	M=0
($END.1)

// C_PUSH constant 16
	@16
	D=A
	@SP
	A=M
	M=D
	@SP
	M=M+1

// C_PUSH constant 17
	@17
	D=A
	@SP
	A=M
	M=D
	@SP
	M=M+1

// eq
	@SP
	AM=M-1
	D=M
	A=A-1
	D=M-D
	@$FALSE.2
	D;JNE
	@SP
	A=M-1
	M=-1
	@$END.2
	0;JMP
($FALSE.2)
	@SP
	A=M-1
	M=0
($END.2)

// C_PUSH constant 892
	@892
	D=A
	@SP
	A=M
	M=D
	@SP
	M=M+1

// C_PUSH constant 891
	@891
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
	A=A-1
	D=M-D
	@$FALSE.3
	D;JGE
	@SP
	A=M-1
	M=-1
	@$END.3
	0;JMP
($FALSE.3)
	@SP
	A=M-1
	M=0
($END.3)

// C_PUSH constant 891
	@891
	D=A
	@SP
	A=M
	M=D
	@SP
	M=M+1

// C_PUSH constant 892
	@892
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
	A=A-1
	D=M-D
	@$FALSE.4
	D;JGE
	@SP
	A=M-1
	M=-1
	@$END.4
	0;JMP
($FALSE.4)
	@SP
	A=M-1
	M=0
($END.4)

// C_PUSH constant 891
	@891
	D=A
	@SP
	A=M
	M=D
	@SP
	M=M+1

// C_PUSH constant 891
	@891
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
	A=A-1
	D=M-D
	@$FALSE.5
	D;JGE
	@SP
	A=M-1
	M=-1
	@$END.5
	0;JMP
($FALSE.5)
	@SP
	A=M-1
	M=0
($END.5)

// C_PUSH constant 32767
	@32767
	D=A
	@SP
	A=M
	M=D
	@SP
	M=M+1

// C_PUSH constant 32766
	@32766
	D=A
	@SP
	A=M
	M=D
	@SP
	M=M+1

// gt
	@SP
	AM=M-1
	D=M
	A=A-1
	D=M-D
	@$FALSE.6
	D;JLE
	@SP
	A=M-1
	M=-1
	@$END.6
	0;JMP
($FALSE.6)
	@SP
	A=M-1
	M=0
($END.6)

// C_PUSH constant 32766
	@32766
	D=A
	@SP
	A=M
	M=D
	@SP
	M=M+1

// C_PUSH constant 32767
	@32767
	D=A
	@SP
	A=M
	M=D
	@SP
	M=M+1

// gt
	@SP
	AM=M-1
	D=M
	A=A-1
	D=M-D
	@$FALSE.7
	D;JLE
	@SP
	A=M-1
	M=-1
	@$END.7
	0;JMP
($FALSE.7)
	@SP
	A=M-1
	M=0
($END.7)

// C_PUSH constant 32766
	@32766
	D=A
	@SP
	A=M
	M=D
	@SP
	M=M+1

// C_PUSH constant 32766
	@32766
	D=A
	@SP
	A=M
	M=D
	@SP
	M=M+1

// gt
	@SP
	AM=M-1
	D=M
	A=A-1
	D=M-D
	@$FALSE.8
	D;JLE
	@SP
	A=M-1
	M=-1
	@$END.8
	0;JMP
($FALSE.8)
	@SP
	A=M-1
	M=0
($END.8)

// C_PUSH constant 57
	@57
	D=A
	@SP
	A=M
	M=D
	@SP
	M=M+1

// C_PUSH constant 31
	@31
	D=A
	@SP
	A=M
	M=D
	@SP
	M=M+1

// C_PUSH constant 53
	@53
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

// C_PUSH constant 112
	@112
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

// neg
	@SP
	A=M-1
	M=-M

// and
	@SP
	AM=M-1
	D=M
	A=A-1
	M=D&M

// C_PUSH constant 82
	@82
	D=A
	@SP
	A=M
	M=D
	@SP
	M=M+1

// or
	@SP
	AM=M-1
	D=M
	A=A-1
	M=D|M

// not
	@SP
	A=M-1
	M=!M
