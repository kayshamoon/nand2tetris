"""
This file is part of nand2tetris, as taught in The Hebrew University, and
was written by Aviv Yaish. It is an extension to the specifications given
[here](https://www.nand2tetris.org) (Shimon Schocken and Noam Nisan, 2017),
as allowed by the Creative Common Attribution-NonCommercial-ShareAlike 3.0
Unported [License](https://creativecommons.org/licenses/by-nc-sa/3.0/).
"""
import os
import sys
import typing
from SymbolTable import SymbolTable
from Parser import Parser
from Code import Code


def assemble_file(input_file: typing.TextIO,
                  output_file: typing.TextIO) -> None:
    """Assembles a single file.

    Args:
        input_file (typing.TextIO): the file to assemble.
        output_file (typing.TextIO): writes all output to this file.
    """
    # cleaning and parsing
    parser = Parser(input_file)
    # initializing symbol table
    symbol_table = SymbolTable()

    # -- first pass -- add labels to symbol table
    rom_address = 0
    while parser.has_more_commands():
        parser.advance() # next command (starts from -1 so needs to advance first)
        command_type = parser.command_type()

        if command_type == parser.L_COMMAND:
            symbol = parser.symbol()

            # if symbol is new add to symbol table
            if not symbol_table.contains(symbol):
                symbol_table.add_entry(symbol, rom_address)

        else: # if command isn't a symbol - update rom address
            rom_address += 1


    # -- second pass -- replace labels and variables with addresses
    # and convert commands to binary representation
    input_file.seek(0) # start from the beginning of the file
    parser = Parser(input_file) # new parser to start from the beginning
    var_address = 16 # addresses 0-15 are occupied

    while parser.has_more_commands():
        parser.advance()
        command_type = parser.command_type()

        if command_type == parser.A_COMMAND:
            symbol = parser.symbol()
            if not symbol.isdigit(): # if isn't an address

                if symbol_table.contains(symbol):
                    address = symbol_table.get_address(symbol)
                else: # add new symbol
                    address = var_address
                    symbol_table.add_entry(symbol, address)
                    var_address += 1
            else:
                address = int(symbol) # convert address to int

            # writes to file the address in binary
            line_in_binary = f"{address:016b}\n"
            output_file.write(line_in_binary)

        elif command_type == parser.C_COMMAND:
            dest = Code.dest(parser.dest())
            comp = Code.comp(parser.comp())
            jump = Code.jump(parser.jump())

            # writes to file the command in binary
            binary = f"1{comp}{dest}{jump}\n"
            output_file.write(binary)



if "__main__" == __name__:
    # Parses the input path and calls assemble_file on each input file.
    # This opens both the input and the output files!
    # Both are closed automatically when the code finishes running.
    # If the output file does not exist, it is created automatically in the
    # correct path, using the correct filename.
    if not len(sys.argv) == 2:
        sys.exit("Invalid usage, please use: Assembler <input path>")
    argument_path = os.path.abspath(sys.argv[1])
    if os.path.isdir(argument_path):
        files_to_assemble = [
            os.path.join(argument_path, filename)
            for filename in os.listdir(argument_path)]
    else:
        files_to_assemble = [argument_path]
    for input_path in files_to_assemble:
        filename, extension = os.path.splitext(input_path)
        if extension.lower() != ".asm":
            continue
        output_path = filename + ".hack"
        with open(input_path, 'r') as input_file, \
                open(output_path, 'w') as output_file:
            assemble_file(input_file, output_file)
