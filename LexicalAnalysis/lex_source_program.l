%{
    #include<stdio.h>
    #include<stdlib.h>
    #include<string.h>
    FILE* C_out;
    void removeSpaces(char *str)
   
{
    // To keep track of non-space character count
    int count = 0;
    // Traverse the provided string. If the current character is not a space,
    //move it to index 'count++'.
    for (int i = 0; str[i]; i++)
        if (str[i] != ' ')
            str[count++] = str[i]; // here count is incremented
    str[count] = '\0';
}
    int scope_count = 0;
    int conditional_count = 0;
    int jump_count =0;
%}

%option noyywrap
/* definitions*/
digits [0-9]+
letter [A-Za-z]
whitespace [ \t\n]+
label "pp"{digits}+
char_string \'[^\']\'
string \"[^\"]*\"
punctuation [;:,]
special_symbol [\[\]\(\)]
special_operator_symbol [+\-\*@\\/:_=#]
operator_symbol [+\-\*/_=]
operator (" "{operator_symbol}" ")
reserved "gteq"|"gt"|"lteq"|"lt"|"and"|"neq"|"or"|"jump to"|"eq"|"otherwise"|"in case that"|"do"|"return"
datatype "integer_2 "|"string "|"character_1 "|"null "
identifier {special_operator_symbol}({letter}|{digits})+|{digits}*{letter}+({digits}|{letter})*
/* rules */
%%

"\n"      {
    //handle newine
    yylineno++;     //increament the line no.
    fprintf(C_out,"\n");
    }
{whitespace} {
    fprintf(C_out,"%s", yytext);
    } /* Skip whitespace */
{label}    { 
    if(jump_count == 1){
        jump_count = 0;
        fprintf(C_out,"%s",yytext);
    }
    fprintf(yyout,"label: %s\n", yytext); 
    }
{punctuation}   { 
    fprintf(yyout,"punctuation: %s\n", yytext);
    if(strcmp(";",yytext)==0){
        fprintf(C_out,"%s",yytext);
    }
    else if(strcmp(",",yytext)==0){
        fprintf(C_out,"%s",yytext);
    }

}
{char_string}    {
    int len = strlen(yytext);
    fprintf(C_out , "%s", yytext);
    if(len >= 4){printf("Error: string in \'^^\'");}
    else{
        fprintf(yyout,"punctuation: %c\n",yytext[0]);
        fprintf(yyout,"constant: ");
        for(int i = 1; i < len-1;i++){
        fprintf(yyout,"%c",yytext[i]);
        }
        fprintf(yyout,"\npunctuation: %c\n",yytext[len-1]);
    }
}
{string}    {
    int len = strlen(yytext); 
    fprintf(C_out , "%s", yytext);
    fprintf(yyout,"punctuation: %c\n",yytext[0]);
    fprintf(yyout,"constant: ");
    for(int i = 1; i < len-1;i++){
       fprintf(yyout,"%c",yytext[i]);
    }
    fprintf(yyout,"\npunctuation: %c\n",yytext[len-1]);
}
{special_symbol}    {
    if(strcmp(yytext ,"(")==0) fprintf(C_out,"%s",yytext);
    else if(strcmp(yytext ,")")==0) fprintf(C_out,"%s",yytext);
    else if(strcmp(yytext ,"]")==0&&conditional_count==0) fprintf(C_out,"}");
    else if(strcmp(yytext ,"]")==0&&conditional_count==1) fprintf(C_out,")");
    else if(strcmp(yytext ,"[")==0&&conditional_count==0) fprintf(C_out,"{");
    else if(strcmp(yytext ,"[")==0&&conditional_count==1) fprintf(C_out,"(");
    else{
        printf("Error at pp%d",yylineno);
        yyterminate();
    }
    fprintf(yyout,"special symbol: %s\n", yytext);
    }
{operator}   {
    fprintf(C_out, "%s" , yytext);
    removeSpaces(yytext);
    fprintf(yyout,"operator: %s\n", yytext);
    }
{reserved}  { 

    // handling reserved keyword cases
    if(strcmp("gteq",yytext)==0) fprintf(C_out ,">=");
    else if(strcmp("lteq",yytext)==0) fprintf(C_out ,"<=");
    else if(strcmp("eq",yytext)==0) fprintf(C_out ,"==");
    else if(strcmp("neq",yytext)==0) fprintf(C_out ,"!=");
    else if(strcmp("lt",yytext)==0) fprintf(C_out ,"<");
    else if(strcmp("gt",yytext)==0) fprintf(C_out ,">");
    else if(strcmp("and",yytext)==0) fprintf(C_out ,"&&");
    else if(strcmp("or",yytext)==0) fprintf(C_out ,"||");
    else if(strcmp("jump to",yytext)==0){ 
        jump_count=1;
        fprintf(C_out ,"goto");
        }
    else if(strcmp("in case that",yytext)==0){
        //printf("ConCount = %d\n", conditional_count);
        fprintf(C_out ,"if");
        conditional_count = 1;
    }
    else if(strcmp("do",yytext)==0){
        conditional_count = 0;
    }
    else if(strcmp("otherwise",yytext)==0){
        fprintf(C_out ,"else");
    }
    else if(strcmp("return",yytext)==0){
        fprintf(C_out ,"return");
    }
    else{
        printf("Error at pp%d",yylineno);
        yyterminate();
    }
    fprintf(yyout,"reserved keyword: %s\n", yytext);
    }
{datatype}  {
    if(strcmp(yytext,"integer_2 ")==0){
        fprintf(C_out,"int ");
    }
    else if(strcmp(yytext,"character_1 ")==0){
        fprintf(C_out,"char ");
    }
    else if(strcmp("string ",yytext)==0){
        fprintf(C_out,"string ");
    }
    else if(strcmp("null ", yytext)==0){
        fprintf(C_out,"null ");
    }
    removeSpaces(yytext);
    fprintf(yyout,"datatype: %s\n", yytext);
    }
{digits} {
    fprintf(C_out,"%s",yytext);
    fprintf(yyout,"constant: %s\n", yytext); 
    }
{identifier}    {
    fprintf(C_out,"%s",yytext);
    fprintf(yyout,"ID: %s\n", yytext); 
    }

.       {
        // for all other invalid tokens
        printf("Error at pp%d",yylineno);
        yyterminate();
    }

%%

int main(int argc, char* argv[]){

    //check for input file aurgument
    if(argc < 2){
        printf("Missing Argument:./lex_source_program < \"test case path\"");
        return -1;
    }
    else{
        //printf("%d\n" , argc);

        // InFile and Outfile path and Name Handling
        yyin = fopen(argv[1],"r");
        int len = strlen(argv[1]);
        int i = 0;
        int filestart=0;
        while(argv[1][i] != '\0'){
            if(argv[1][i] == '/'){
                filestart = i+1;
            }
            i++;
        }

        // get the file Name in suffix
        char suffix[100];
        i = filestart;
        while(argv[1][i] != '\0'){
            suffix[i-filestart] = argv[1][i];
            i++;
        }

        // append suffix to outfile and C_outfile name
        char outfile[100] = "TK/seq_tokens_";
        char C_outflie[100] = "TC/C_";
        strcat(outfile , suffix);
        strcat(C_outflie,suffix);

        // open the respective files
        C_out = fopen(C_outflie, "w+");
        yyout = fopen(outfile , "w+");

        fprintf(yyout,"Name : Aditya Bacharwar\n");
        fprintf(yyout,"ID : Es21btech11003\n");
        fprintf(yyout,"Input File: %s\n\n", suffix);
    }

    //call lex
    yylex();

    return 0;
}
