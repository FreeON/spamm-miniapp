%{
%}

%token COMMENT_TOKEN

%start input

%%

input: /* empty */
     input comment
     ;

comment:
       COMMENT_TOKEN .* '\n'
       ;

%%
