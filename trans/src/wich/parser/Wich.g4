/*
The MIT License (MIT)

Copyright (c) 2015 Terence Parr, Hanzhou Shi, Shuai Yuan, Yuanyuan Zhang

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
*/

grammar Wich;

@header {
import wich.semantics.symbols.*;
import org.antlr.symtab.*;
}

file : script ;

script returns [GlobalScope scope]
	: (outer_statement | vardef | function)* EOF
	;

function returns [WFunctionSymbol scope]
	:	'func' ID '(' formal_args? ')' (':' type)? block
	;

formal_args : formal_arg (',' formal_arg)* ;

formal_arg : ID ':' type ;

type:	'int'
	|	'float'
	|	'string'
	|   'boolean'
	|	'[' ']'
	;

block returns [Scope scope]
	:  '{' statement* '}';

outer_statement
	:	'if' '(' expr ')' statement ('else' statement)?		# If
	|	'while' '(' expr ')' statement						# While
	|	ID '=' expr											# Assign
	|	ID '[' expr ']' '=' expr							# ElementAssign
	|	call_expr											# CallStatement
	|	'print' '(' expr? ')'								# Print
	;

statement
	:	outer_statement                                     # OuterStuff
	|   vardef									            # VarDefStatement
	|	'return' expr										# Return
	|	block				 								# BlockStatement
	;

vardef : 'var' ID '=' expr ;

expr returns [Type exprType, Type promoteToType]
	:	expr operator expr									# Op
	|	'-' expr											# Negate
	|	'!' expr											# Not
	|	call_expr											# Call
	|	ID '[' expr ']'										# Index
	|	'(' expr ')'										# Parens
	|	primary												# Atom
	;

operator  : MUL|DIV|ADD|SUB|GT|LE|EQUAL_EQUAL|NOT_EQUAL|GT|GE|OR|AND|DOT ; // no precedence

call_expr returns [Type exprType, Type promoteToType]
	: ID '(' expr_list? ')' ;

expr_list : expr (',' expr)* ;

primary returns [Type exprType]
	:	ID													# Identifier
	|	INT													# Integer
	|	FLOAT												# Float
	|	STRING												# String
	|	'[' expr_list ']'									# Vector
	;

LPAREN : '(' ;
RPAREN : ')' ;
COLON : ':' ;
COMMA : ',' ;
LBRACK : '[' ;
RBRACK : ']' ;
LBRACE : '{' ;
RBRACE : '}' ;
IF : 'if' ;
ELSE : 'else' ;
WHILE : 'while' ;
VAR : 'var' ;
EQUAL : '=' ;
RETURN : 'return' ;
PRINT : 'print' ;
SUB : '-' ;
BANG : '!' ;
MUL : '*' ;
DIV : '/' ;
ADD : '+' ;
LT : '<' ;
LE : '<=' ;
EQUAL_EQUAL : '==' ;
NOT_EQUAL : '!=' ;
GT : '>' ;
GE : '>=' ;
OR : '||' ;
AND : '&&' ;
DOT : ' . ' ;

LINE_COMMENT : '//' .*? ('\n'|EOF)	-> channel(HIDDEN) ;
COMMENT      : '/*' .*? '*/'    	-> channel(HIDDEN) ;

ID  : [a-zA-Z_] [a-zA-Z0-9_]* ;
INT : [0-9]+ ;
FLOAT
	:   '-'? INT '.' INT EXP?   // 1.35, 1.35E-9, 0.3, -4.5
	|   '-'? INT EXP            // 1e10 -3e4
	;
fragment EXP :   [Ee] [+\-]? INT ;

STRING :  '"' (ESC | ~["\\])* '"' ;
fragment ESC :   '\\' ["\bfnrt] ;

WS : [ \t\n\r]+ -> channel(HIDDEN) ;
