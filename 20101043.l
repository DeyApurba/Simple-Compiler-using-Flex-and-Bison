%{
	#include "20101043.tab.h"
    #include <stdio.h>
	#include <string.h>
	extern int yydebug;
	int yyparse();
	FILE *outfile;
%}

header [a][p][u][r][b][a][ ][a-z]+[.][h]

%%

{header}        {printf("Header file found\n\n");}
"main"			{return MAIN;}
"{"			    {return START;}
"}"			    {return END;}

"INTEGER"		{return T_INT;}
"DOUBLE"		{return T_DOUBLE;}
"STRING"		{return T_STRING;}

"IF"			{return IF;}
"ELSE"			{return ELSE;}
"while"			{return WHILE;}

"inc"		    {return INC;}

"from"			{return FROM;}
"to"			{return TO;}

[#]+[@].*			printf("\n A Single Line Comment is Found. \n\n");

"@@@"(.|\n)*?"@@@"		{printf("\n A Multi-line Comment is Found. \n\n");}

"++"			{return INCREMENT;}

"--"			{return DECREMENT;}
"=="			{return EQUAL;}
"!="			{return NT_EQUAL;}
">="			{return GT_EQUAL;}
"<="		    {return LS_EQUAL;}
                  
"print_koro"			{return PRINT;}

\"(\\.|[^"\\])*\"				{yylval.string = strdup(yytext);return STRING;}
[0-9]+			                            {yylval.integer = atoi(yytext);return INT;}
[-+]?[0-9]*[.][0-9]+([eE][+-]?[0-9]+)?   	{yylval.floating = atof(yytext);return DOUBLE;}
[A-Za-z0-9]+					{yylval.string = strdup(yytext);return ID;}

[-+/*<>=,();%^]					{return yytext[0];}
[\t]							{}
[\n]						        {}
.	                           {  }



%%

int yywrap(){
	return 1;
}

int main(int argc, char **argv){
	yyin = fopen("input.txt","r");
	outfile = fopen("output.txt","w");
	freopen("output.txt","w",stdout);
	yyparse();
	fclose(outfile);
	return 0;
}

int yyerror(char *s){
	fprintf(stderr,"error: %s\n", s);
}