*-----------------------------------------------------------
* Title      : EE215 Lab01
* Written by : Jason Travis
* Date       : 2014/01/22
* Description: Demonstrate the ability to write a basic 68k
* assembly program from register transfer language instructions
*-----------------------------------------------------------
    ORG    $2000
START:                  ; First program instruction
    MOVE.L  X0,$C10     ; Copy bytes from constants X and Y to locations in memory between $C10 - $C40
    MOVE.W  X2,$C20
    MOVE.B  X3,$C28
    MOVE.B  X3,$C30
    MOVE.B  X2,$C34
    MOVE.B  X1,$C38
    MOVE.B  X0,$C3C
    MOVE.L  Y2,$C40
    
    MOVE.L  X0,D0       ; long M[$C50]<-M[X0]+M[Y0]
    ADD.L   Y0,D0
    MOVE.L  D0,$C50
    MOVE.W  X2,D0       ; word M[$C58]<-M[X2]+M[Y2]
    ADD.W   Y2,D0
    MOVE.W  D0,$C58
    MOVE.B  X3,D0       ; byte M[$C5C]<-M[X3]+M[Y3]
    ADD.B   Y3,D0
    MOVE.B  D0,$C58
    
    MOVE.L  Y0,D0       ; long M[$C70]<-M[Y0]-M[X0]
    SUB.L   X0,D0
    MOVE.L  D0,$C70
    MOVE.W  Y2,D0       ; word M[$C78]<-M[Y2]-M[X2]
    SUB.W   X2,D0
    MOVE.W  D0,$C78
    MOVE.B  Y3,D0       ; byte M[$C7C]<-M[Y3]-M[X3]
    SUB.B   Y3,D0
    MOVE.B  D0,$C7C
    
    MOVE.L  Y0,$C80     ; long M[C80]<-~M[Y0]
    NOT.L   $C80
    MOVE.L  Y2,$C88     ; word M[C88]<-~M[Y2]
    NOT.L   $C88
    MOVE.L  Y3,$C8C     ; byte M[C8C]<-~M[Y3]
    NOT.L   $C8C
    
    MOVE.L  X2,D0       ; long M[$CA0]<-M[X2]+M[Y2]
    ADD.L   Y2,D0
    MOVE.L  D0,$CA0
    MOVE.W  X0,D0       ; word M[$CA8]<-M[X0]+M[X0]
    ADD.W   Y0,D0
    MOVE.W  D0,$CA8
    
    MOVE.L  D0,$CB0     ; M[CB0]<-M[D0]
    
    STOP #$2700
    SIMHALT             ; halt simulator

    ORG     $C00        ; Define constants
X:  DC.L    $12345678
Y:  DC.L    $789ABCDE
X0: EQU     X           ; Define aliases to individual X bytes
X1: EQU     X+1
X2: EQU     X+2
X3: EQU     X+3
Y0: EQU     Y           ; Define aliases to individual Y bytes
Y1: EQU     Y+1
Y2: EQU     Y+2
Y3: EQU     Y+3

    END    START        ; last line of source

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
