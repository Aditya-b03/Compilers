%{
    #include<stdio.h>
    #include<stdlib.h>
    #include<string.h>
    void yyerror(char *);
    #include "y.tab.h"
    extern FILE *tf;
    extern int for_loop;
    extern int nested_call;
%}

/* definations */
digits [0-9]+
letter [A-Za-z]
whitespace [ \t]+
char_string \'[^\']\'
string \"[^\"]*\"
bool "true"|"false"
constant {digits}+
punctuation [;:,]
special_symbol [\[\]\(\)\{\}]
/* removed = - */
operator_keywords "add"|"sub"|"mul"|"div"|"postincr"|"postdecr"|"neg"|"="|"->"
conditional "in case that"|"otherwise"|"do"
loops "for"|"loop"|"while"
prefix "local"|"global"|"declare"|"expr"|"call"|"class"|"return"|"this"
comparision "geq"|"gt"|"leq"|"lt"|"ne"|"eq"
conj "and"|"or"
reserved {conditional}|{loops}|{prefix}|{comparision}|{conj}|{bool}
operator_symbol [+\*@\\/:_#]
datatype "int"|"char"|"bool"|"string"|"void"
identifier [a-zA-Z_][a-zA-Z0-9_]*
class_identifier "class_"{identifier}
/* rules */
%%


"\n"      {
    yylineno++;     //increament the line no.
    fprintf(yyout,"%s", yytext);
    }
{whitespace} {
    fprintf(yyout,"%s", yytext);
    ;} /* Skip whitespace */
{punctuation}   { 
    fprintf(tf,"punctuation: %s\n", yytext);
    fprintf(yyout,"%s", yytext);
    if(strcmp(yytext,";")==0) return SEMICOLON;
    else if(strcmp(yytext,",")==0) return COMMA;
    else if(strcmp(yytext,":")==0) return COLON;
    }

{char_string}    {
    int len = strlen(yytext);
    fprintf(yyout,"%s", yytext);
    if(len >= 4){printf("Error: string in \'^^\'");}
    else{
        fprintf(tf,"punctuation: %c\n",yytext[0]);
        fprintf(tf,"constant: ");
        for(int i = 1; i < len-1;i++){
        fprintf(tf,"%c",yytext[i]);
        }
        fprintf(tf,"\npunctuation: %c\n",yytext[len-1]);
    }
    return CHAR_LITERAL;
}
{string}    {
    int len = strlen(yytext); 
    fprintf(yyout,"%s", yytext);
    fprintf(tf,"punctuation: %c\n",yytext[0]);
    fprintf(tf,"constant: ");
    for(int i = 1; i < len-1;i++){
       fprintf(tf,"%c",yytext[i]);
    }
    fprintf(tf,"\npunctuation: %c\n",yytext[len-1]);

    return STRING_LITERAL;
}
{special_symbol}    {
    fprintf(yyout,"%s", yytext);
    fprintf(tf,"special symbol: %s\n", yytext);
    if(strcmp("[",yytext)==0) return LSB;
    else if(strcmp("]",yytext)==0) return RSB;
    else if(strcmp("(",yytext)==0) return LPB;
    else if(strcmp(")",yytext)==0) return RPB;
    else if(strcmp("{",yytext)==0) return LCB;
    else if(strcmp("}",yytext)==0) return RCB;
    }
{operator_keywords}   {
    fprintf(yyout,"%s", yytext);
    fprintf(tf,"operator: %s\n", yytext);
    if(strcmp("add",yytext)==0) return ADD;
    else if(strcmp("sub",yytext)==0) return SUB;
    else if(strcmp("mul",yytext)==0) return MUL;
    else if(strcmp("div",yytext)==0) return DIV;
    else if(strcmp("postincr",yytext)==0) return INCR;
    else if(strcmp("postdecr",yytext)==0) return DECR;
    else if(strcmp("neg",yytext)==0) return NEG;
    else if(strcmp("=",yytext)==0) return ASSIGN;
    else if(strcmp("->",yytext)==0) return ARROW;
    }
{reserved}  {
    fprintf(yyout,"%s", yytext);
    fprintf(tf,"reserved keyword: %s\n", yytext);
    if(strcmp("in case that",yytext)==0){nested_call = 1; return IF;}
    else if(strcmp("otherwise",yytext)==0) return ELSE;
    else if(strcmp("do",yytext)==0) return DO;
    else if(strcmp("for",yytext)==0){ for_loop = 1; return FOR;}
    else if(strcmp("while",yytext)==0) return WHILE;
    else if(strcmp("local",yytext)==0 || strcmp("global",yytext)==0) return FUNCTION;
    else if(strcmp("declare",yytext)==0) return DECLARE;
    else if(strcmp("expr",yytext)==0) { nested_call = 1;return EXPR; }
    else if(strcmp("call",yytext)==0) return CALL;
    else if(strcmp("class",yytext)==0) return CLASS;
    else if(strcmp("return",yytext)==0){ nested_call = 1; return RETURN; }
    else if(strcmp("this",yytext)==0) return THIS;
    else if(strcmp("loop",yytext)==0) return LOOP;
    else if(strcmp("true",yytext)==0 || strcmp("false",yytext)==0) return BOOL_LITERAL;
    else if(strcmp("geq",yytext)==0 
            || strcmp("gt",yytext)==0
            || strcmp("leq",yytext)==0
            || strcmp("lt",yytext)==0
            || strcmp("ne",yytext)==0
            || strcmp("eq",yytext)==0
            ) return CONDITIONAL;

    else if(strcmp("and",yytext)==0 || strcmp("or",yytext)==0) return CONJ;
    }
{datatype}  {
    fprintf(yyout,"%s", yytext);
    fprintf(tf,"datatype: %s\n", yytext);
    if(strcmp("int",yytext)==0) return INT;
    else if(strcmp("char",yytext)==0) return CHAR;
    else if(strcmp("bool",yytext)==0) return BOOL;
    else if(strcmp("string",yytext)==0) return STRING;
    else if(strcmp("void",yytext)==0) return VOID;
    }
{constant} {
    fprintf(yyout,"%s", yytext);
    fprintf(tf,"constant: %s\n", yytext);
    return DIGITS; 
    }
{class_identifier}  {
    fprintf(yyout,"%s", yytext);
    fprintf(tf,"ID: %s\n", yytext);
    return CLASS_IDENTIFIER;
    }   
{identifier}    {
    fprintf(yyout,"%s", yytext);
    fprintf(tf,"ID: %s\n", yytext);
    return IDENTIFIER;
    }



.       {
        // for all other invalid tokens
        printf("Lexical Error: Error at lineNo: %d",yylineno);
        printf("Invalid Token: %s\n",yytext);
        yyterminate();
    }


%%

int yywrap(void){
    return 1;
}