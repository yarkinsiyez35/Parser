%{
    #include <stdio.h>
    void yyerror(const char * msg)
    {
        return;
    }
%}

%token tMAIL tENDMAIL tSEND tTO tFROM tAT tCOMMA tCOLON tLPR tRPR tLBR tRBR tIDENT tSTRING tADDRESS tDATE tTIME tSCHEDULE tENDSCH tSET

%%

fullprogram: program
        | 
;

program: component
        | program component
;

component: mailBlock 
        | setStatement
;


mailBlock: tMAIL tFROM tADDRESS tCOLON mailStatements tENDMAIL
        | tMAIL tFROM tADDRESS tCOLON tENDMAIL
;

mailStatements: mailStatement 
        | mailStatements mailStatement
;

mailStatement: setStatement
        | sendStatement
        | scheduleStatement
;

setStatement: tSET tIDENT tLPR tSTRING tRPR
;

scheduleStatement: tSCHEDULE tAT tLBR tDATE tCOMMA tTIME tRBR tCOLON sendStatements tENDSCH
;

sendStatements: sendStatement 
        | sendStatements sendStatement
;

sendStatement: tSEND tLBR tIDENT tRBR tTO recipientList
        | tSEND tLBR tSTRING tRBR tTO recipientList
;

recipientList: tLBR recipients tRBR
;

recipients: recipient 
        | recipient tCOMMA recipients
;

recipient: tLPR tADDRESS tRPR
        | tLPR tIDENT tCOMMA tADDRESS tRPR
        | tLPR tSTRING tCOMMA tADDRESS tRPR
;

%%

int main()
{
    if (yyparse())       //unsuccessful parsing 
    {
        printf("ERROR\n");
        return 1;
    }
    else                //successful parsing 
    {
        printf("OK\n");
        return 0;
    }
}
