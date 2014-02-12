*-----------------------------------------------------------
* Title      : EE215 Lab03
* Written by : Jason Travis
* Date       : 2015.02.12
* Description: Prompts the user for 3 numbers: m, x, b
* Prints the result of x^2 + m*x + b
* The program exits when 0 is entered for the value of m
*-----------------------------------------------------------
    ORG    $1000
START:                  ; first instruction of program
    LEA     EnterValue,A1   ; Prompt value of m
    MOVE.B  #14,D0
    TRAP    #15
    LEA     M,A1
    TRAP    #15
    MOVE.B  #4,D0           ; Read value of m
    TRAP    #15
    MOVE.L  D1,D3           ; Save m in D3
    
    BEQ END                 ; if(m == 0) exit;
    
    LEA     EnterValue,A1   ; Prompt value of b
    MOVE.B  #14,D0
    TRAP    #15
    LEA     B,A1
    TRAP    #15
    MOVE.B  #4,D0           ; Read value of b
    TRAP    #15
    MOVE.L  D1,D4           ; Save b in D4
    
    LEA     EnterValue,A1   ; Prompt value of x
    MOVE.B  #14,D0
    TRAP    #15
    LEA     X,A1
    TRAP    #15
    MOVE.B  #4,D0           ; Read value of x
    TRAP    #15
    MOVE.L  D1,D5           ; Save x in D5
    
    BSR     XSQMXB          ; D7 = XSQMXB(D3,D4,D5)

    LEA     FOpen,A1        ; Print 'f('
    MOVE.B  #14,D0
    TRAP    #15
    MOVE.B  #3,D0           ; Print m
    MOVE.W  D3,D1
    TRAP    #15
    MOVE.B  #6,D0
    MOVE.B  Comma,D1        ; Print ','
    TRAP    #15
    MOVE.B  #3,D0           ; Print b
    MOVE.W  D4,D1
    TRAP    #15
    MOVE.B  #6,D0           ; Print ','
    MOVE.B  Comma,D1
    TRAP    #15
    MOVE.B  #3,D0           ; Print x
    MOVE.W  D5,D1
    TRAP    #15
    LEA     FCloseEq,A1     ; Print ') = '
    MOVE.B  #14,D0
    TRAP    #15
    MOVE.B  #3,D0           ; Print result
    MOVE.W  D7,D1
    TRAP    #15
    LEA     RNRN,A1           ; Print '\r\n\r\n'
    MOVE.B  #14,D0
    TRAP    #15

    BRA     START
END:
    LEA     ThatsAll,A1
    MOVE.B  #13,D0
    TRAP    #15
    STOP    #$2700

*------------------------------------------------------------------------------
* XSQMXB takes D3,D4,D5 as int16 parameters and returns D7 = D5^2 + D3*D5 + D4
*
* Uses: D3-D7
* Modifies: D6 and D7
*------------------------------------------------------------------------------
XSQMXB
    MOVE.W  D5,D6           ; D6 = m*x
    MULS.W  D3,D6
    MOVE.W  D5,D7           ; D7 = x^2 + m*x + b
    MULS.W  D7,D7
    ADD.W   D6,D7
    ADD.W   D4,D7
    RTS
    
* Variables and constants
EnterValue  DC.B    'Enter value of ',0
ThatsAll    DC.B    'That''s all folks',0
M           DC.B    'm: ',0
B           DC.B    'b: ',0
X           DC.B    'x: ',0
Comma       DC.B    ','
FOpen       DC.B    'f(',0
FCloseEq    DC.B    ') = ',0
RNRN          DC.B    $0D,$0A,$0D,$0A,0
    END    START        ; last line of source





*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
