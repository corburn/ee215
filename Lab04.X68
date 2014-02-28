*-----------------------------------------------------------
* Title      : Lab04
* Written by : Jason Travis
* Date       : 2014.02.26
* Description:
*-----------------------------------------------------------   
    ORG    $1000
START:                      ; first instruction of program
    MOVE.L  #$0,SP
    LINK    A4,#-4*4        ; Create initial Stack Frame allocating space for n, x, y, and the result
    MOVE.L  #$56,(-12,A4)   ; y
    MOVE.L  #$34,(-8,A4)    ; x
    MOVE.L  #$12,(-4,A4)    ; n
    BSR ACK
    UNLK    A4
    STOP    #$2700

PROMPT
    MOVEM.L D0-A6,-(SP)    
    MOVE.L  #18,D0
    LEA     PromptN,A1
    TRAP    #15
    MOVE.L  D1,D2
    LEA     PromptX,A1
    TRAP    #15
    MOVE.L  D1,D3
    LEA     PromptY,A1
    TRAP    #15
    MOVE.L  D1,D4
    MOVEM.L (SP)+,D0-A6
    RTS
    
ANSWER    
    MOVE.L  #17,D0
    MOVE.L  D2,D1
    LEA     AnswerOpen,A1
    TRAP    #15
    MOVE.L  D3,D1
    LEA     Comma,A1
    TRAP    #15
    MOVE.L  D4,D1
    LEA     Comma,A1
    TRAP    #15
    MOVE.L  D5,D1
    LEA     AnswerClose,A1
    TRAP    #15
    RTS
    
ACK
    MOVEM.L D0-D2,-(SP) ; Push registers on Stack
    * Retrieve parameters
    MOVE.L  (-12,A4),D2 ; D2 = y
    MOVE.L  (-8,A4),D1  ; D1 = x
    MOVE.L  (-4,A4),D0  ; D0 = n
    * Base cases
    CMP.L   #0,D2
    BNE     YNOT0       ; if y != 0 goto YNOT0
    CMP.L   #3,D0
    BEQ     NIS3        ; if n == 3 goto NIS3
    BHI     NGT3        ; if n > 3 goto NGT3
    CMP.L   #1,D0
    BHI     NIS2        ; if n > 1 goto NIS2
    BEQ     NIS1        ; if n == 1 goto NIS1
NIS1
    MOVE.L  D1,(20,A4)  ; result = x
    BRA DONE
NIS2
    MOVE.L  #0,(20,A4)  ; result = 0
    BRA DONE
NIS3
    MOVE.L  #1,(20,A4)  ; result = 1
    BRA DONE
NGT3
    MOVE.L  #2,(20,A4)  ; result = 2
    BRA DONE
YNOT0
    CMP.L   #0,D0
    BNE     RECURSE     ; if y != 0 && n != 0
    ADDI.L  #1,D1
    MOVE.L  D1,(20,A4)  ; result = x + 1
    BRA DONE
    * Recursive call
RECURSE
    LINK    A4,#-4*4    ; Create a new Stack Frame allocating space for n,x,y, and the result
    * Put the necessary values of n,x,and y into the new Stack Frame
    MOVE.L  D1,(-12,A4) ; y = x
    MOVE.L  D1,(-8,A4)  ; x = A(n,x,y-1)
    SUBI.L  #1,D0       ; D0 = n - 1
    MOVE.L  D0,(-4,A4)  ; n = n - 1
    BSR     ACK
    UNLK    A4          ; Collapse Stack Frame
DONE
    MOVEM.L (SP)+,D0-D2 ; Pop registers off Stack
    RTS
    
* Variables and constants
PromptN     DC.B 'Please enter a value for n: ',0
PromptX     DC.B 'Please enter a value for x: ',0
PromptY     DC.B 'Please enter a value for y: ',0
AnswerOpen  DC.B 'Answer: A(',0
Comma       DC.B ',',0
AnswerClose DC.B ') = ',0
    END    START

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
