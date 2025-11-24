"""
This file is part of nand2tetris, as taught in The Hebrew University, and
was written by Aviv Yaish. It is an extension to the specifications given
[here](https://www.nand2tetris.org) (Shimon Schocken and Noam Nisan, 2017),
as allowed by the Creative Common Attribution-NonCommercial-ShareAlike 3.0
Unported [License](https://creativecommons.org/licenses/by-nc-sa/3.0/).
"""
import typing
from os import write


class CodeWriter:
    """Translates VM commands into Hack assembly code."""

    def __init__(self, output_stream: typing.TextIO) -> None:
        """Initializes the CodeWriter.

        Args:
            output_stream (typing.TextIO): output stream.
        """
        self.output_stream = output_stream
        self.current_file = ""
        self.label_counter = 0
        self.return_address_counter = 0

    def set_file_name(self, filename: str) -> None:
        """Informs the code writer that the translation of a new VM file is 
        started.

        Args:
            filename (str): The name of the VM file.
        """
        # Your code goes here!
        # This function is useful when translating code that handles the
        # static segment. For example, in order to prevent collisions between two
        # .vm files which push/pop to the static segment, one can use the current
        # file's name in the assembly variable's name and thus differentiate between
        # static variables belonging to different files.
        # To avoid problems with Linux/Windows/macOS differences with regards
        # to filenames and paths, you are advised to parse the filename in
        # the function "translate_file" in Main.py using python's os library,
        # For example, using code similar to:
        # input_filename, input_extension = os.path.splitext(os.path.basename(input_file.name))
        self.current_file = filename

    def write_arithmetic(self, command: str) -> None:
        """Writes assembly code that is the translation of the given 
        arithmetic command. For the commands eq, lt, gt, you should correctly
        compare between all numbers our computer supports, and we define the
        value "true" to be -1, and "false" to be 0.

        Args:
            command (str): an arithmetic command.
        """
        valid_arithmetic_commands = {
            "add", "sub", "neg", "eq", "gt", "lt", "and", "or", "not",
            "shiftleft", "shiftright"}

        if command not in valid_arithmetic_commands:
            raise ValueError(f"invalid arithmetic command: {command}")

        self.write_comment(command)

        if command == "add":
            self.output_stream.write(
                "\t@SP\n" #top of the stack -> R13 
                "\tA=M-1\n"
                "\tD=M\n"
                "\t@R13\n"
                "\tM=D\n"
                "\t@SP\n"   #SP--
                "\tM=M-1\n"
                "\t@SP\n"   #top of the stack -> D
                "\tA=M-1\n"
                "\tD=M\n"
                "\t@R13\n"  #add the numbers and save to D
                "\tM=D+M\n"
                "\tD=M\n"
                "\t@SP\n"   #result -> top of the stack
                "\tA=M-1\n"
                "\tM=D\n"
            )

        if command == "sub":
            self.output_stream.write(
                "\t@SP\n"  # top of the stack -> R13 
                "\tA=M-1\n"
                "\tD=M\n"
                "\t@R13\n"
                "\tM=D\n"
                "\t@SP\n"  # SP--
                "\tM=M-1\n"
                "\t@SP\n"  # top of the stack -> D
                "\tA=M-1\n"
                "\tD=M\n"
                "\t@R13\n"  # sub the numbers and save to D
                "\tM=D-M\n"
                "\tD=M\n"
                "\t@SP\n"  # result -> top of the stack
                "\tA=M-1\n"
                "\tM=D\n"
            )

        if command == "neg":
            self.output_stream.write(
                "\t@SP\n"
                "\tA=M-1\n"
                "\tM=-M\n"
            )

        if command == "and":
            self.output_stream.write(
                "\t@SP\n"  # top of the stack -> R13 
                "\tA=M-1\n"
                "\tD=M\n"
                "\t@R13\n"
                "\tM=D\n"
                "\t@SP\n"  # SP--
                "\tM=M-1\n"
                "\t@SP\n"  # top of the stack -> D
                "\tA=M-1\n"
                "\tD=M\n"
                "\t@R13\n"  # "and" the numbers and save to D
                "\tM=D&M\n"
                "\tD=M\n"
                "\t@SP\n"  # result -> top of the stack
                "\tA=M-1\n"
                "\tM=D\n"
            )
        if command == "or":
            self.output_stream.write(
                "\t@SP\n"  # top of the stack -> R13 
                "\tA=M-1\n"
                "\tD=M\n"
                "\t@R13\n"
                "\tM=D\n"
                "\t@SP\n"  # SP--
                "\tM=M-1\n"
                "\t@SP\n"  # top of the stack -> D
                "\tA=M-1\n"
                "\tD=M\n"
                "\t@R13\n"  # "or" the numbers and save to D
                "\tM=D|M\n"
                "\tD=M\n"
                "\t@SP\n"  # result -> top of the stack
                "\tA=M-1\n"
                "\tM=D\n"
            )
        if command == "not":
            self.output_stream.write(
                "\t@SP\n"
                "\tA=M-1\n"
                "\tM=!M\n"
            )
        if command == "shiftleft":
            self.output_stream.write(
                "\t@SP\n"
                "\tA=M-1\n"
                "\tM=M<<\n"
            )
        if command == "shiftright":
            self.output_stream.write(
                "\t@SP\n"
                "\tA=M-1\n"
                "\tM=M>>\n"
            )

        if command in {"eq", "gt", "lt"}:
            # read arguments from stack to R13 and R14
            self.output_stream.write(
                "\t@SP\n"
                "\tAM=M-1\n"   # SP--; A=SP
                "\tD=M\n"      # D = *SP
                "\t@R14\n"
                "\tM=D\n"      # R14 = arg2
                
                "\t@SP\n"
                "\tAM=M-1\n"   # SP--; A=SP
                "\tD=M\n"      # D = *SP
                "\t@R13\n"
                "\tM=D\n"      # R13 = arg1
            )
            # calc x-y and store in D
            self.output_stream.write(
                "\t@R13\n"
                "\tD=M\n"      # D = arg1
                "\t@R14\n"
                "\tD=D-M\n"    # D = arg1 - arg2
            )

            if command == "eq":
                jump_command = "JEQ"
            elif command == "gt":
                jump_command = "JGT"
            else:
                jump_command = "JLT"

            # set D to -1 (true) or 0 (false)
            self.output_stream.write(
                f"\t@TRUE{self.label_counter}\n"
                f"\tD;{jump_command}\n"  # if condition is met, jump to TRUE
                 "\tD=0\n"                # D = false
                f"\t@END{self.label_counter}\n"
                 "\t0;JMP\n"
                f"(TRUE{self.label_counter})\n"
                 "\tD=-1\n"               # D = true
                f"(END{self.label_counter})\n"
            )
            self.label_counter += 1

            # push D to stack
            self.output_stream.write(
                "\t@SP\n"
                "\tA=M\n"      # A = SP
                "\tM=D\n"      # *SP = D
                "\t@SP\n"
                "\tM=M+1\n"    # SP++
            )



    def write_push_pop(self, command: str, segment: str, index: int) -> None:
        """Writes assembly code that is the translation of the given
        command, where command is either C_PUSH or C_POP.

        Args:
            command (str): "C_PUSH" or "C_POP".
            segment (str): the memory segment to operate on.
            index (int): the index in the memory segment.
        """
        # Your code goes here!
        # Note: each reference to "static i" appearing in the file Xxx.vm should
        # be translated to the assembly symbol "Xxx.i". In the subsequent
        # assembly process, the Hack assembler will allocate these symbolic
        # variables to the RAM, starting at address 16.
        if command not in {"C_PUSH", "C_POP"}:
            raise ValueError(f"invalid command: {command} {segment} {index}")

        if command == "C_POP" and segment == "constant":
            raise ValueError(f"cannot pop to constant segment: {command} {segment} {index}")

        self.write_comment(f"{command} {segment} {index}")

        # read address of segment[index] to A register

        if segment == "constant":
            # simply load index to A
            self.output_stream.write(
                f"\t@{index}\n"
                 "\tD=A\n"  # D = index
                 "\t@SP\n"
                 "\tA=M\n"  # A = SP
                 "\tM=D\n"  # *SP = D
                 "\t@SP\n"
                 "\tM=M+1\n"  # SP++
            )
        else:
            if segment == "static":
                # creates new variable named current_file.index
                self.output_stream.write(
                    f"\t@{self.current_file}.{index}\n"
                )
            elif segment == "pointer":
                # pointer 0 is THIS (RAM[3]), pointer 1 is THAT (RAM[4])
                if index not in {0, 1}:
                    raise ValueError(f"invalid pointer index: {index}")

                self.output_stream.write(
                    f"\t@{3 + index}\n"
                )
            elif segment == "temp":
                # temp segment is mapped to RAM[5]-RAM[12]
                self.output_stream.write(
                    f"\t@{5 + index}\n"
                )

            elif segment in {"argument", "local", "this", "that"}:
                self.output_stream.write(
                    f"\t@{index}\n"
                     "\tD=A\n"

                )
                if segment == "argument":
                    self.output_stream.write(
                        "\t@ARG\n"
                    )
                elif segment == "local":
                    self.output_stream.write(
                        "\t@LCL\n"
                    )
                elif segment == "this":
                    self.output_stream.write(
                        "\t@THIS\n"
                    )
                elif segment == "that":
                    self.output_stream.write(
                        "\t@THAT\n"
                    )

                self.output_stream.write(
                    "\tA=M+D\n"
                )

            # now A register has the address of segment[index]

            if command == "C_PUSH":
                # push the value at D into the stack
                self.output_stream.write(
                    "\tD=M\n"      # D = segment[index]
                    "\t@SP\n"
                    "\tA=M\n"      # A = SP
                    "\tM=D\n"      # *SP = D
                    "\t@SP\n"
                    "\tM=M+1\n"    # SP++
                )
            elif command == "C_POP":
                # pop the topmost stack value into segment[index]
                self.output_stream.write(
                    "\tD=A\n"      # D = address of segment[index]
                    "\t@R13\n"     # use R13 as a temp variable
                    "\tM=D\n"      # R13 = address of segment[index]
                    "\t@SP\n"
                    "\tAM=M-1\n"   # SP--; A=SP
                    "\tD=M\n"      # D = *SP
                    "\t@R13\n"
                    "\tA=M\n"      # A = segment[index] address
                    "\tM=D\n"      # segment[index] = D
                )




    def write_label(self, label: str) -> None:
        """Writes assembly code that affects the label command.
        Let "Xxx.foo" be a function within the file Xxx.vm. The handling of
        each "label bar" command within "Xxx.foo" generates and injects the symbol
        "Xxx.foo$bar" into the assembly code stream.
        When translating "goto bar" and "if-goto bar" commands within "foo",
        the label "Xxx.foo$bar" must be used instead of "bar".

        Args:
            label (str): the label to write.
        """
        # This is irrelevant for project 7,
        # you will implement this in project 8!
        self.output_stream.write(
            f"({label})\n"
        )

    def write_goto(self, label: str) -> None:
        """Writes assembly code that affects the goto command.

        Args:
            label (str): the label to go to.
        """
        # This is irrelevant for project 7,
        # you will implement this in project 8!
        self.output_stream.write(
            f"@{label}\n"
            "0;JPM\n"
        )
    
    def write_if(self, label: str) -> None:
        """Writes assembly code that affects the if-goto command.

        Args:
            label (str): the label to go to.
        """
        # This is irrelevant for project 7,
        # you will implement this in project 8!
        self.output_stream.write(
            "@SP\n"#top->D
            "A=M-1\n"
            "D=M\n"
            "@SP\n"#SP--
            "M=M-1\n"
            f"@{label}\n"
            "0;JLT\n"
        )
    
    def write_function(self, function_name: str, n_vars: int) -> None:
        """Writes assembly code that affects the function command.
        The handling of each "function Xxx.foo" command within the file Xxx.vm
        generates and injects a symbol "Xxx.foo" into the assembly code stream,
        that labels the entry-point to the function's code.
        In the subsequent assembly process, the assembler translates this
        symbol into the physical address where the function code starts.

        Args:
            function_name (str): the name of the function.
            n_vars (int): the number of local variables of the function.
        """
        # This is irrelevant for project 7,
        # you will implement this in project 8!
        # The pseudo-code of "function function_name n_vars" is:
        # (function_name)       // injects a function entry label into the code
        # repeat n_vars times:  // n_vars = number of local variables
        #   push constant 0     // initializes the local variables to 0
        this.write_label(function_name)
        for i in range(n_vars):
            this.write_push_pop("C_PUSH", "constant", 0)
    
    def write_call(self, function_name: str, n_args: int) -> None:
        """Writes assembly code that affects the call command.
        Let "Xxx.foo" be a function within the file Xxx.vm.
        The handling of each "call" command within Xxx.foo's code generates and
        injects a symbol "Xxx.foo$ret.i" into the assembly code stream, where
        "i" is a running integer (one such symbol is generated for each "call"
        command within "Xxx.foo").
        This symbol is used to mark the return address within the caller's
        code. In the subsequent assembly process, the assembler translates this
        symbol into the physical memory address of the command immediately
        following the "call" command.

        Args:
            function_name (str): the name of the function to call.
            n_args (int): the number of arguments of the function.
        """
        # This is irrelevant for project 7,
        # you will implement this in project 8!
        # The pseudo-code of "call function_name n_args" is:
        # push return_address   // generates a label and pushes it to the stack
        # push LCL              // saves LCL of the caller
        # push ARG              // saves ARG of the caller
        # push THIS             // saves THIS of the caller
        # push THAT             // saves THAT of the caller
        # ARG = SP-5-n_args     // repositions ARG
        # LCL = SP              // repositions LCL
        # goto function_name    // transfers control to the callee
        # (return_address)      // injects the return address label into the code

        self.write_comment(f"call {function_name} {n_args}")

        # push return_address
        self.output_stream.write(
            f"\t@RETURN_ADDRESS_{self.return_address_counter}\n"
             "\tD=A\n"         # D = return address
             "\t@SP\n"
             "\tA=M\n"         # A = SP
             "\tM=D\n"         # *SP = return address
             "\t@SP\n"
             "\tM=M+1\n"       # SP++
        )

        # push LCL, ARG, THIS, THAT
        for segment in ["LCL", "ARG", "THIS", "THAT"]:
            self.output_stream.write(
                f"\t@{segment}\n"
                 "\tD=M\n"         # D = segment
                 "\t@SP\n"
                 "\tA=M\n"         # A = SP
                 "\tM=D\n"         # *SP = segment
                 "\t@SP\n"
                 "\tM=M+1\n"       # SP++
            )

        # ARG = SP - (5 + n_args)
        self.output_stream.write(
             "\t@SP\n"
             "\tD=M\n"         # D = SP
            f"\t@{5+n_args}\n"
             "\tD=D-A\n"       # D = SP - 5 - n_args
             "\t@ARG\n"
             "\tM=D\n"         # ARG = D
        )

        # LCL = SP
        self.output_stream.write(
             "\t@SP\n"
             "\tD=M\n"         # D = SP
             "\t@LCL\n"
             "\tM=D\n"         # LCL = D
        )

        # goto function_name
        self.output_stream.write(
            f"\t@{function_name}\n"
             "\t0;JMP\n"       # goto function_name
        )

        # (return_address)
        self.output_stream.write(
            f"(RETURN_ADDRESS_{self.return_address_counter})\n"
        )
        self.return_address_counter += 1

    
    def write_return(self) -> None:
        """Writes assembly code that affects the return command."""
        # This is irrelevant for project 7,
        # you will implement this in project 8!
        # The pseudo-code of "return" is:
        # frame = LCL                   // frame is a temporary variable
        # return_address = *(frame-5)   // puts the return address in a temp var
        # *ARG = pop()                  // repositions the return value for the caller
        # SP = ARG + 1                  // repositions SP for the caller
        # THAT = *(frame-1)             // restores THAT for the caller
        # THIS = *(frame-2)             // restores THIS for the caller
        # ARG = *(frame-3)              // restores ARG for the caller
        # LCL = *(frame-4)              // restores LCL for the caller
        # goto return_address           // go to the return address

        self.write_comment("return")

        # frame = LCL
        self.output_stream.write(
             "\t@LCL\n"
             "\tD=M\n"         # D = LCL
             "\t@R13\n"
             "\tM=D\n"         # R13 (frame) = LCL
        )

        # return_address = *(frame-5)
        self.output_stream.write(
             "\t@5\n"
             "\tA=D-A\n"       # A = D (frame) - 5
             "\tD=M\n"         # D = *(frame - 5)
             "\t@R14\n"
             "\tM=D\n"         # R14 (return_address) = *(frame - 5)
        )

        # *ARG = pop()
        self.output_stream.write(
             "\t@SP\n"
             "\tAM=M-1\n"      # SP--; A=SP
             "\tD=M\n"         # D = *SP
             "\t@ARG\n"
             "\tA=M\n"         # A = ARG
             "\tM=D\n"         # *ARG = D (*SP)
        )

        # SP = ARG + 1
        self.output_stream.write(
             "\t@ARG\n"
             "\tD=M+1\n"       # D = ARG + 1
             "\t@SP\n"
             "\tM=D\n"         # SP = D (ARG + 1)
        )

        # restore THAT, THIS, ARG, LCL of the caller
        for segment in ["THAT", "THIS", "ARG", "LCL"]:
            self.output_stream.write(
                 "\t@R13\n"
                 "\tAM=M-1\n"      # frame--; A=frame
                 "\tD=M\n"         # D = *frame
                f"\t@{segment}\n"
                 "\tM=D\n"         # segment = D (*frame)
            )

        # goto return_address
        self.output_stream.write(
             "\t@R14\n"        # (R14 = return_address)
             "\tA=M\n"         # A = return_address
             "\t0;JMP\n"       # goto return_address
        )



    def write_comment(self, comment: str) -> None:
        """Writes a comment line in the output assembly file.

        Args:
            comment (str): the comment to write.
        """
        self.output_stream.write(f"\n// {comment}\n")
