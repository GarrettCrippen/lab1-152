%{
int currPos = 1;
int currLine =1;

%}

ID [A-Za-z]+([A-Za-z0-9_]*[A-Za-z0-9]+)*
NUMBER [0-9]

%%

"##".*"\n" {currPos+=yyleng;}

"function" {printf("FUNCTION\n"); currPos+=yyleng;}
"beginparams" {printf("BEGIN_PARAMS\n"); currPos+=yyleng;}
"endparams" {printf("END_PARAMS\n"); currPos+=yyleng;}
"beginlocals" {printf("BEGIN_LOCALS\n"); currPos+=yyleng;}
"endlocals" {printf("END_LOCALS\n"); currPos+=yyleng;}
"beginbody" {printf("BEGIN_BODY\n"); currPos+=yyleng;}
"endbody" {printf("END_BODY\n"); currPos+=yyleng;}
"integer" {printf("INTEGER\n"); currPos+=yyleng;}
"array" {printf("ARRAY\n"); currPos+=yyleng;}
"of" {printf("OF\n"); currPos+=yyleng;} 
"if" {printf("IF\n"); currPos+=yyleng;}
"then" {printf("THEN\n"); currPos+=yyleng;}
"endif" {printf("ENDIF\n"); currPos+=yyleng;}
"else" {printf("ELSE\n"); currPos+=yyleng;} 
"while" {printf("WHILE\n"); currPos+=yyleng;}
"do" {printf("DO\n"); currPos+=yyleng;} 
"beginloop" {printf("BEGINLOOP\n"); currPos+=yyleng;}
"endloop" {printf("ENDLOOP\n"); currPos+=yyleng;}
"break" {printf("BREAK\n"); currPos+=yyleng;}
"read" {printf("READ\n"); currPos+=yyleng;}
"write" {printf("WRITE\n"); currPos+=yyleng;}
"and" {printf("AND\n"); currPos+=yyleng;}
"or" {printf("OR\n"); currPos+=yyleng;}
"not" {printf("NOT\n"); currPos+=yyleng;}
"true" {printf("TRUE\n"); currPos+=yyleng;}
"false" {printf("FALSE\n"); currPos+=yyleng;}
"return" {printf("RETURN\n"); currPos+=yyleng;}


"(" {printf("L_PAREN\n"); currPos+=yyleng;} 
")" {printf("R_PAREN\n"); currPos+=yyleng;} 

"[" {printf("L_SQUARE_BRACKET\n"); currPos+=yyleng;}
"]" {printf("R_SQUARE_BRACKET\n"); currPos+=yyleng;} 

"*" {printf("MULT\n"); currPos+=yyleng;}
"/" {printf("DIV\n"); currPos+=yyleng;}
"%" {printf("MOD\n"); currPos+=yyleng;}

"-" {printf("SUB\n"); currPos+=yyleng;}
"+" {printf("ADD\n"); currPos+=yyleng;}

"==" {printf("EQ\n"); currPos+=yyleng;}
"<>" {printf("NEQ\n"); currPos+=yyleng;}
"<" {printf("LT\n"); currPos+=yyleng;}
">" {printf("GT\n"); currPos+=yyleng;}
"<=" {printf("LTE\n"); currPos+=yyleng;}
">=" {printf("GTE\n"); currPos+=yyleng;}

":=" {printf("ASSIGN\n"); currPos+=yyleng;}
	

{NUMBER}+ {printf("NUMBER %s\n",yytext); currPos+=yyleng;}
([0-9_])+([A-Za-z0-9])* {printf("Error at line %d , column %d: identifier: \"%s\" must begin with a letter\n",currLine,currPos,yytext); exit(0);}
([A-Za-z])+([A-Za-z0-9_])*"_" {printf("Error at line %d , column %d: identifier: \"%s\" cannot end with an underscore\n",currLine,currPos,yytext); exit(0);}
{ID} {printf("IDENT %s\n",yytext); currPos+=yyleng;}


";" {printf("SEMICOLON\n"); currPos+=yyleng;}
":" {printf("COLON\n"); currPos+=yyleng;}

"," {printf("COMMA\n"); currPos+=yyleng;} 

[ \t]+ { currPos += yyleng;}
"\n" {currPos =1; currLine++;}
. {printf("Error at line %d: unrecoginized symbol \"%s\"\n",currLine,yytext); exit(0);}

%%
int main(int argc, char** argv){
++argv, --argc;
if(argc > 0) yyin = fopen(argv[0], "r");
else yyin = stdin;
yylex();

}
