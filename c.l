%{
#include <stdio.h>
#include <strings.h>
#include <stdlib.h>

/* keywords that rise indentation */
char *startindent[] = {"PROGRAM", "MODULE", "FUNCTION", "SUBROUTINE", "DO", "THEN"}; /* Don't let IF start indent, it should be done by THEN stmnt */
char *stopindent[] = {"ENDPROGRAM", "ENDMODULE", "ENDFUNCTION", "ENDSUBROUTINE", "ENDDO", "ENDIF", "END", "ELSEIF"};
char *stopstartindent[] = {"ELSE"}; 

int istartindent = 6;
int istopindent = 8;
int istopstartindent = 1;

int indent_level = 0;

int lineBegining = 1;

/* config */
int indent_spaces = 2;
int heavy_comment_length = 100 - 1;
int light_comment_length = 50 - 1;

/* prototypes */
void printIndent(void );
void printOneSpace(void );
int isStartIndent(char *);
int isStopIndent(char *);
int isStopStartIndent(char *);
%}

%%

\!\=+                    { printIndent(); printf("!"); for (int i=0; i<heavy_comment_length;i++) printf("="); }

\!\-+                    { printIndent(); printf("!"); for (int i=0; i<light_comment_length;i++) printf("-"); }

\!.+                     { printIndent(); ECHO; }

\!                       { printIndent(); ECHO; }

\#.+                     { ECHO; }

[ \t]+                   { ; }

\n                       { lineBegining = 1; printf("\n"); }

"\.AND\."                { ECHO; printOneSpace(); }

"\.NOT\."                { ECHO; printOneSpace(); }

"\.OR\."                 { ECHO; printOneSpace(); }

"\.TRUE\."               { ECHO; printOneSpace(); }

"\.FALSE\."              { ECHO; printOneSpace(); }

"\.EQ\."                { ECHO; printOneSpace(); }

"\.EQV\."                { ECHO; printOneSpace(); }

"\.NE\."                { ECHO; printOneSpace(); }

"\.GE\."                { ECHO; printOneSpace(); }

"\.GT\."                { ECHO; printOneSpace(); }

"\.LE\."                { ECHO; printOneSpace(); }

"\.LT\."                { ECHO; printOneSpace(); }

"\.and\."               { ECHO; printOneSpace(); }

"\.not\."               { ECHO; printOneSpace(); }

"\.or\."                { ECHO; printOneSpace(); }

"\.true\."              { ECHO; printOneSpace(); }

"\.false\."             { ECHO; printOneSpace(); }

"\.eq\."                { ECHO; printOneSpace(); }

"\.eqv\."                { ECHO; printOneSpace(); }

"\.ne\."                { ECHO; printOneSpace(); }

"\.ge\."                { ECHO; printOneSpace(); }

"\.gt\."                { ECHO; printOneSpace(); }

"\.le\."                { ECHO; printOneSpace(); }

"\.lt\."                { ECHO; printOneSpace(); }

[0-9]+"\.AND\."         { printIndent(); ECHO; printOneSpace(); }
[0-9]+"\.OR\."         { printIndent(); ECHO; printOneSpace(); }
[0-9]+"\.NOT\."         { printIndent(); ECHO; printOneSpace(); }
[0-9]+"\.TRUE\."         { printIndent(); ECHO; printOneSpace(); }
[0-9]+"\.FALSE\."         { printIndent(); ECHO; printOneSpace(); }
[0-9]+"\.EQ\."         { printIndent(); ECHO; printOneSpace(); }
[0-9]+"\.NE\."         { printIndent(); ECHO; printOneSpace(); }
[0-9]+"\.GE\."         { printIndent(); ECHO; printOneSpace(); }
[0-9]+"\.GT\."         { printIndent(); ECHO; printOneSpace(); }
[0-9]+"\.LE\."         { printIndent(); ECHO; printOneSpace(); }
[0-9]+"\.LT\."         { printIndent(); ECHO; printOneSpace(); }

[0-9]+"\.and\."         { printIndent(); ECHO; printOneSpace(); }
[0-9]+"\.or\."         { printIndent(); ECHO; printOneSpace(); }
[0-9]+"\.not\."         { printIndent(); ECHO; printOneSpace(); }
[0-9]+"\.true\."         { printIndent(); ECHO; printOneSpace(); }
[0-9]+"\.false\."         { printIndent(); ECHO; printOneSpace(); }
[0-9]+"\.eq\."         { printIndent(); ECHO; printOneSpace(); }
[0-9]+"\.ne\."         { printIndent(); ECHO; printOneSpace(); }
[0-9]+"\.ge\."         { printIndent(); ECHO; printOneSpace(); }
[0-9]+"\.gt\."         { printIndent(); ECHO; printOneSpace(); }
[0-9]+"\.le\."         { printIndent(); ECHO; printOneSpace(); }
[0-9]+"\.lt\."         { printIndent(); ECHO; printOneSpace(); }

[0-9]+\.[0-9]+e[\+\-][0-9]+    { printIndent(); ECHO; printOneSpace(); }

[0-9]+\.e[\+\-][0-9]+    { printIndent(); ECHO; printOneSpace(); }

[0-9]+\.[0-9]+D[0-9]+    { printIndent(); ECHO; printOneSpace(); }

[0-9]+\.[0-9]+d[0-9]+    { printIndent(); ECHO; printOneSpace(); }

[0-9]+\.d[0-9]+    { printIndent(); ECHO; printOneSpace(); }

[0-9]+\.[0-9]+           { printIndent(); ECHO; printOneSpace(); }

[0-9]+\.                 { printIndent(); ECHO; printOneSpace(); }

\.[0-9]+                 { printIndent(); ECHO; printOneSpace(); }

[0-9]+                   { printIndent(); ECHO; printOneSpace(); }

"::"                     { ECHO; printOneSpace(); }

":"                      { ECHO; printOneSpace(); }

\".*\"                   { /* string */
                            printIndent(); ECHO;
                         }

\'.*\'                   { /* string */
                            printIndent(); ECHO;
                         }

[a-zA-Z][a-zA-Z0-9_]*    {   /* WORD */

                            if (isStartIndent(yytext)) {
                                printIndent();
                                ECHO;
                                printOneSpace(); 
                                indent_level++;
                            } else if (isStopIndent(yytext)) {
                                indent_level--;
                                printIndent();
                                ECHO; 
                                printOneSpace(); 
                            } else if (isStopStartIndent(yytext)) {
                                indent_level--;
                                printIndent();
                                ECHO;
                                printOneSpace(); 
                                indent_level++;
                            } else {
                                printIndent();
                                ECHO;
                                printOneSpace(); 
                            }
                         }

","                      { printf(", "); }

"+"                      { printf("+ "); }

"-"                      { printf("- "); }

"*"                      { printf("* "); }

"/"                      { printf("/ "); }

">"                      { printf("> "); }

"<"                      { printf("< "); }

"("                      { printIndent(); ECHO; printOneSpace(); }

")"                      { printIndent(); ECHO; printOneSpace(); }

"="                      { printf("= "); }

">="                     { printf(">= "); }

"<="                     { printf("<= "); }

"=>"                     { printf("=> "); }

"/="                     { printf("/= "); }

"=="                     { printf("== "); }

"**"                     { printf("** "); }

"//"                     { printf("// "); }

"(/"                     { printf("(/ "); }

"/)"                     { printf("/) "); }

%%
 
int isStartIndent(char *yytext) {
    int i;
    for (i=0;i<istartindent;i++) {
        if (strcasecmp(yytext, startindent[i])==0) return 1;    
    }
    return 0;
}

int isStopIndent(char *yytext) {
    int i;
    for (i=0;i<istopindent;i++) {
        if (strcasecmp(yytext, stopindent[i])==0) return 1;    
    }
    return 0;
}

int isStopStartIndent(char *yytext) {
    int i;
    for (i=0;i<istopstartindent;i++) {
        if (strcasecmp(yytext, stopstartindent[i])==0) return 1;    
    }
    return 0;
}

void printIndent(void ) {
    if (lineBegining) {
        for (int i=0;i<indent_level;i++) {
            for (int j=0;j<indent_spaces;j++) 
                printf(" ");
        }
        lineBegining = 0;
    }
}

void printOneSpace(void ) {
  printf(" ");
}
