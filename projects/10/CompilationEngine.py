"""
This file is part of nand2tetris, as taught in The Hebrew University, and
was written by Aviv Yaish. It is an extension to the specifications given
[here](https://www.nand2tetris.org) (Shimon Schocken and Noam Nisan, 2017),
as allowed by the Creative Common Attribution-NonCommercial-ShareAlike 3.0
Unported [License](https://creativecommons.org/licenses/by-nc-sa/3.0/).
"""
import typing


class CompilationEngine:
    """Gets input from a JackTokenizer and emits its parsed structure into an
    output stream.
    """

    def __init__(self, input_stream: "JackTokenizer", output_stream) -> None:
        """
        Creates a new compilation engine with the given input and output. The
        next routine called must be compileClass()
        :param input_stream: The input stream.
        :param output_stream: The output stream.
        """
        # Your code goes here!
        # Note that you can write to output_stream like so:
        # output_stream.write("Hello world! \n")
        self.indents = 0
        self.input_stream = input_stream
        self.input_stream.advance()
        self.output_stream = output_stream
        self.compile_class()


    def compile_class(self) -> None:
        """Compiles a complete class."""
        self.write_line("<class>\n")

        self.eat(["class"])
        self.eat([self.input_stream.current_token])  # name of the class
        self.eat(["{"])

        while self.input_stream.current_token in ("static", "field"):
            self.compile_class_var_dec()
        while self.input_stream.current_token in ("constructor", "function", "method"):
            self.compile_subroutine()

        self.eat(["}"])

        self.write_line("</class>\n")


    def compile_class_var_dec(self) -> None:
        """Compiles a static declaration or a field declaration."""
        self.write_line("<classVarDec>\n")

        self.eat(["static", "field"])
        self.eat(["int", "char", "boolean", self.input_stream.current_token])
        self.eat([self.input_stream.current_token]) # var name
        while self.input_stream.current_token == ",":
            self.eat([","])
            self.eat([self.input_stream.current_token])
        self.eat([";"])

        self.write_line("</classVarDec>\n")

    def compile_subroutine(self) -> None:
        """
        Compiles a complete method, function, or constructor.
        You can assume that classes with constructors have at least one field,
        you will understand why this is necessary in project 11.
        """
        self.write_line("<subroutineDec>\n")

        self.eat(["constructor", "function", "method"])
        self.eat(["void", "int", "char", "boolean", self.input_stream.current_token])
        self.eat([self.input_stream.current_token])  # subroutine name
        self.eat(["("])
        self.compile_parameter_list()
        self.eat([")"])

        self.write_line("<subroutineBody>\n")
        self.eat(["{"])
        while self.input_stream.current_token == "var":
            self.compile_var_dec()

        self.compile_statements()
        self.eat(["}"])
        self.write_line("</subroutineBody>\n")

        self.write_line("</subroutineDec>\n")

    def compile_parameter_list(self) -> None:
        """Compiles a (possibly empty) parameter list, not including the 
        enclosing "()".
        """
        self.write_line("<parameterList>\n")

        if self.input_stream.current_token in ("int", "char", "boolean") or self.input_stream.token_type() == "IDENTIFIER":
            self.eat(["int", "char", "boolean", self.input_stream.current_token])
            self.eat([self.input_stream.current_token]) # var name
            while self.input_stream.current_token == ",":
                self.eat([","])
                self.eat(["int", "char", "boolean", self.input_stream.current_token])
                self.eat([self.input_stream.current_token])

        self.write_line("</parameterList>\n")

    def compile_var_dec(self) -> None:
        """Compiles a var declaration."""
        self.write_line("<varDec>\n")

        self.eat(["var"])
        self.eat(["int", "char", "boolean", self.input_stream.current_token])
        self.eat([self.input_stream.current_token]) # var name

        while self.input_stream.current_token == ",":
            self.eat([","])
            self.eat([self.input_stream.current_token]) # var name

        self.eat([";"])

        self.write_line("</varDec>\n")

    def compile_statements(self) -> None:
        """Compiles a sequence of statements, not including the enclosing 
        "{}".
        """
        self.write_line("<statements>\n")

        while self.input_stream.current_token in ("let", "if", "while", "do", "return"):
            if self.input_stream.current_token == "let":
                self.compile_let()
            elif self.input_stream.current_token == "if":
                self.compile_if()
            elif self.input_stream.current_token == "while":
                self.compile_while()
            elif self.input_stream.current_token == "do":
                self.compile_do()
            elif self.input_stream.current_token == "return":
                self.compile_return()

        self.write_line("</statements>\n")

    def compile_do(self) -> None:
        """Compiles a do statement."""
        self.write_line("<doStatement>\n")

        self.eat(["do"])
        self.eat([self.input_stream.current_token])  # subroutine name or class/var name

        if self.input_stream.current_token == ".": # call with class/var name
            self.eat(["."])
            self.eat([self.input_stream.current_token])  # subroutine name

        self.eat(["("])
        self.compile_expression_list()
        self.eat([")"])
        self.eat([";"])

        self.write_line("</doStatement>\n")


    def compile_let(self) -> None:
        """Compiles a let statement."""
        self.write_line("<letStatement>\n")

        self.eat(["let"])
        self.eat([self.input_stream.current_token])  # var name

        if self.input_stream.current_token == "[":  # in array
            self.eat(["["])
            self.compile_expression()
            self.eat(["]"])

        self.eat(["="])
        self.compile_expression()
        self.eat([";"])

        self.write_line("</letStatement>\n")

    def compile_while(self) -> None:
        """Compiles a while statement."""
        self.write_line("<whileStatement>\n")

        self.eat(["while"])
        self.eat(["("])
        self.compile_expression()
        self.eat([")"])
        self.eat(["{"])
        self.compile_statements()
        self.eat(["}"])

        self.write_line("</whileStatement>\n")

    def compile_return(self) -> None:
        """Compiles a return statement."""
        self.write_line("<returnStatement>\n")

        self.eat(["return"])

        if self.input_stream.current_token != ";":
            self.compile_expression()

        self.eat([";"])

        self.write_line("</returnStatement>\n")

    def compile_if(self) -> None:
        """Compiles a if statement, possibly with a trailing else clause."""
        self.write_line("<ifStatement>\n")

        self.eat(["if"])
        self.eat(["("])
        self.compile_expression()
        self.eat([")"])
        self.eat(["{"])
        self.compile_statements()
        self.eat(["}"])

        if self.input_stream.current_token == "else":
            self.eat(["else"])
            self.eat(["{"])
            self.compile_statements()
            self.eat(["}"])

        self.write_line("</ifStatement>\n")

    def compile_expression(self) -> None:
        """Compiles an expression."""
        self.write_line("<expression>\n")

        self.compile_term()

        while self.input_stream.current_token in ("+", "-", "*", "/", "&", "|", "<", ">", "="):
            self.eat(["+", "-", "*", "/", "&", "|", "<", ">", "="])
            self.compile_term()

        self.write_line("</expression>\n")

    def compile_term(self) -> None:
        """Compiles a term. 
        This routine is faced with a slight difficulty when
        trying to decide between some of the alternative parsing rules.
        Specifically, if the current token is an identifier, the routing must
        distinguish between a variable, an array entry, and a subroutine call.
        A single look-ahead token, which may be one of "[", "(", or "." suffices
        to distinguish between the three possibilities. Any other token is not
        part of this term and should not be advanced over.
        """
        self.write_line("<term>\n")

        token_type = self.input_stream.token_type()

        if token_type == "INT_CONST":
            self.eat([self.input_stream.current_token])

        elif token_type == "STRING_CONST":
            self.eat([self.input_stream.current_token])  # remove quotes


        elif token_type == "KEYWORD" and self.input_stream.current_token in ("true", "false", "null", "this"):
            self.eat(["true", "false", "null", "this"])

        elif token_type == "SYMBOL" and self.input_stream.symbol() == "(":
            self.eat(["("])
            self.compile_expression()
            self.eat([")"])

        elif token_type == "SYMBOL" and self.input_stream.symbol() in ("-", "~", "^", "#"):
            self.eat(["-", "~", "^", "#"])
            self.compile_term()

        elif token_type == "IDENTIFIER": # var name or array or subroutine call
            self.eat([self.input_stream.current_token])  # var name or subroutine name

            if self.input_stream.current_token == "[":  # array
                self.eat(["["])
                self.compile_expression()
                self.eat(["]"])

            elif self.input_stream.current_token == "(":  # subroutine call
                self.eat(["("])
                self.compile_expression_list()
                self.eat([")"])

            elif self.input_stream.current_token == ".":  # subroutine call on var
                self.eat(["."])
                self.eat([self.input_stream.current_token])  # subroutine name
                self.eat(["("])
                self.compile_expression_list()
                self.eat([")"])
        else:
            raise ValueError("Unexpected token in term")

        self.write_line("</term>\n")

    def compile_expression_list(self) -> None:
        """Compiles a (possibly empty) comma-separated list of expressions."""
        self.write_line("<expressionList>\n")

        if self.input_stream.current_token != ")":
            self.compile_expression()
            while self.input_stream.current_token == ",":
                self.eat([","])
                self.compile_expression()

        self.write_line("</expressionList>\n")

    def xml_fixes(self, token: str) -> str:
        token = token.replace("&", "&amp;")
        token = token.replace("<", "&lt;")
        token = token.replace(">","&gt;")
        return token

    def token_type_fixes(self, token_type: str) -> str:
        if token_type == "INT_CONST":
            return "integerConstant"
        elif token_type == "STRING_CONST":
            return "stringConstant"
        else:
            return token_type.lower()


    def eat(self, expected_tokens: list[str]) -> None:
        actual_token = self.input_stream.current_token

        if actual_token not in expected_tokens:
            raise ValueError(
                f"Expected one of {expected_tokens}, but got {actual_token}")

        if self.input_stream.token_type() == "STRING_CONST":
            actual_token = actual_token[1:-1]

        actual_token = self.xml_fixes(actual_token)
        token_type = self.token_type_fixes(self.input_stream.token_type())


        self.output_stream.write("  " * self.indents +
                                 f"<{token_type}> "
                                 f"{actual_token} "
                                 f"</{token_type}>\n")

        self.input_stream.advance()

    def write_line(self, line: str) -> None:
        if line[1] == "/":
            self.indents -= 1
            self.output_stream.write("  " * self.indents + line)
        else:
            self.output_stream.write("  " * self.indents + line)
            self.indents += 1

