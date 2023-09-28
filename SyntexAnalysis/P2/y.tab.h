/* A Bison parser, made by GNU Bison 2.3.  */

/* Skeleton interface for Bison's Yacc-like parsers in C

   Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2, or (at your option)
   any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 51 Franklin Street, Fifth Floor,
   Boston, MA 02110-1301, USA.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     DIGITS = 258,
     STRING_LITERAL = 259,
     CHAR_LITERAL = 260,
     BOOL_LITERAL = 261,
     FUNCTION = 262,
     CLASS = 263,
     RETURN = 264,
     DECLARE = 265,
     EXPR = 266,
     CALL = 267,
     THIS = 268,
     INT = 269,
     CHAR = 270,
     STRING = 271,
     VOID = 272,
     BOOL = 273,
     ADD = 274,
     SUB = 275,
     MUL = 276,
     DIV = 277,
     INCR = 278,
     DECR = 279,
     ASSIGN = 280,
     ARROW = 281,
     NEG = 282,
     FOR = 283,
     WHILE = 284,
     DO = 285,
     IF = 286,
     ELSE = 287,
     LOOP = 288,
     CONDITIONAL = 289,
     CONJ = 290,
     IDENTIFIER = 291,
     CLASS_IDENTIFIER = 292,
     LSB = 293,
     RSB = 294,
     LCB = 295,
     RCB = 296,
     LPB = 297,
     RPB = 298,
     SEMICOLON = 299,
     COMMA = 300,
     COLON = 301
   };
#endif
/* Tokens.  */
#define DIGITS 258
#define STRING_LITERAL 259
#define CHAR_LITERAL 260
#define BOOL_LITERAL 261
#define FUNCTION 262
#define CLASS 263
#define RETURN 264
#define DECLARE 265
#define EXPR 266
#define CALL 267
#define THIS 268
#define INT 269
#define CHAR 270
#define STRING 271
#define VOID 272
#define BOOL 273
#define ADD 274
#define SUB 275
#define MUL 276
#define DIV 277
#define INCR 278
#define DECR 279
#define ASSIGN 280
#define ARROW 281
#define NEG 282
#define FOR 283
#define WHILE 284
#define DO 285
#define IF 286
#define ELSE 287
#define LOOP 288
#define CONDITIONAL 289
#define CONJ 290
#define IDENTIFIER 291
#define CLASS_IDENTIFIER 292
#define LSB 293
#define RSB 294
#define LCB 295
#define RCB 296
#define LPB 297
#define RPB 298
#define SEMICOLON 299
#define COMMA 300
#define COLON 301




#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
# define YYSTYPE_IS_TRIVIAL 1
#endif

extern YYSTYPE yylval;

