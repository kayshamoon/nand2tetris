"""
This file is part of nand2tetris, as taught in The Hebrew University, and
was written by Aviv Yaish. It is an extension to the specifications given
[here](https://www.nand2tetris.org) (Shimon Schocken and Noam Nisan, 2017),
as allowed by the Creative Common Attribution-NonCommercial-ShareAlike 3.0
Unported [License](https://creativecommons.org/licenses/by-nc-sa/3.0/).
"""
import typing

class Parser:
    """Encapsulates access to the input code. Reads an assembly program
    by reading each command line-by-line, parses the current command,
    and provides convenient access to the commands components (fields
    and symbols). In addition, removes all white space and comments.
    """



    def __init__(self, input_file: typing.TextIO) -> None:
        """Opens the input file and gets ready to parse it.

        Args:
            input_file (typing.TextIO): input file.
        """

        self.A_COMMAND = "A_COMMAND"
        self.C_COMMAND = "C_COMMAND"
        self.L_COMMAND = "L_COMMAND"
        self.NULL = "null"

        self.commands = []

        input_lines = input_file.read().splitlines() # list of strings

        for line in input_lines:
            line_without_comment = line.split("//")[0]
            command = "".join(line_without_comment.split()) # deletes white spaces
            if command != "": # empty line
                self.commands.append(command)

        # initialize to before first command to avoid error with empty file
        self.cur_command = None
        self.cur_idx = -1

    def has_more_commands(self) -> bool:
        """Are there more commands in the input?

        Returns:
            bool: True if there are more commands, False otherwise.
        """
        return len(self.commands) > self.cur_idx + 1

    def advance(self) -> None:
        """Reads the next command from the input and makes it the current command.
        Should be called only if has_more_commands() is true.
        """
        if self.has_more_commands():
            # sets cur_command to the next command using cur_idx
            self.cur_idx += 1
            self.cur_command = self.commands[self.cur_idx]

    def command_type(self) -> str:
        """
        Returns:
            str: the type of the current command:
            "A_COMMAND" for @Xxx where Xxx is either a symbol or a decimal number
            "C_COMMAND" for dest=comp;jump
            "L_COMMAND" (actually, pseudo-command) for (Xxx) where Xxx is a symbol
        """
        if self.cur_command[0] == "@":
            return self.A_COMMAND
        # if starts with "(" and ends with ")"
        elif (self.cur_command[0] == "(") & (self.cur_command[-1] == ")"):
            return self.L_COMMAND
        else: # could be a problem with wrong syntax
            return self.C_COMMAND

    def symbol(self) -> str:
        """
        Returns:
            str: the symbol or decimal Xxx of the current command @Xxx or
            (Xxx). Should be called only when command_type() is "A_COMMAND" or 
            "L_COMMAND".
        """
        if self.command_type() == self.A_COMMAND:
            return self.cur_command[1:]  # without @
        elif self.command_type() == self.L_COMMAND:
            return self.cur_command[1:-1]  # without ( and )
        else:
            return self.cur_command

    def dest(self) -> str:
        """
        Returns:
            str: the dest mnemonic in the current C-command. Should be called 
            only when commandType() is "C_COMMAND".
        """
        if self.command_type() == self.C_COMMAND:
            if "=" in self.cur_command:
                dest = self.cur_command.split("=")[0]
            else:
                dest = self.NULL
            return dest
        else:
            return "" # no dest in non c commands


    def comp(self) -> str:
        """
        Returns:
            str: the comp mnemonic in the current C-command. Should be called 
            only when commandType() is "C_COMMAND".
        """
        if self.command_type() == self.C_COMMAND:
            if "=" in self.cur_command:
                comp_and_jump = self.cur_command.split("=")[1]

                if ";" in comp_and_jump:
                    comp = comp_and_jump.split(";")[0]

                else: # no jump
                    comp = comp_and_jump

            elif ";" in self.cur_command:
                comp = self.cur_command.split(";")[0]

            else:
                comp = self.cur_command

            return comp

        else:
            return "" # no comp in non c commands

    def jump(self) -> str:
        """
        Returns:
            str: the jump mnemonic in the current C-command. Should be called 
            only when commandType() is "C_COMMAND".
        """
        if self.command_type() == self.C_COMMAND:
            if ";" in self.cur_command:
                jump = self.cur_command.split(";")[1]
            else:
                jump = self.NULL
            return jump

        else:
            return "" # no jump in non c commands
