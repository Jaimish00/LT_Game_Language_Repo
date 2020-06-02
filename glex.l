%{
    #include<stdio.h>
    #include "y.tab.h"
    #define YYSTYPE char *
%}

%%
get return TOKGET;
aglist  return TOKAGLIST;
rglist  return TOKRGLIST;
glist   return TOKGLIST;
dglist  return TOKDGLIST;
delete  return TOKDELETE;
close   return TOKCLOSE;
install return TOKINSTALL;
play    return TOKPLAY;
clear   return TOKCLEAR;
swap    return TOKSWAP;
total   return TOKTOTAL;
cache   return TOKCACHE;
ram return TOKRAM;
help    return TOKHELP;
current return TOKCURR;
storage return TOKSTORAGE;

[a-zA-Z][a-zA-Z0-9_]+   {yylval = strdup(yytext); return GAMENAME;}
\n  ;
[ \t]   ;
.   yyerror("Invalid Command");
%%

int yywrap(void){
    return 1;
}

  