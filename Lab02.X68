*-----------------------------------------------------------
* Title      : EE215 Lab02
* Written by : Jason Travis
* Date       : 2014/01/29
* Description: Find prime numbers from Min to Max using
* Eratosthenes Sieve. Min should be a prime number.
*-----------------------------------------------------------
    ORG    $1000
START:
* Initialize an array of integers from Min to Max starting at DataAddress
    LEA     DataAddress,A0
    MOVE.L  #Min,D0
    MOVE.L  #Count,D1
InitDataLoop
    MOVE.L  D0,(A0)+
    ADD.L   #1,D0           ; Increment value
    SUB.L   #1,D1           ; Decrement loop count
    BEQ     EndInitDataLoop ; Exit when count is 0
    JMP     InitDataLoop
EndInitDataLoop

    LEA     DataAddress,A0  ; Initialize Sieve by moving A0 to the first prime number in the array
PrimeLoop
    CMP     #(DataAddress+Count*DataSize),A1
    BGT     EndPrimeLoop
    MOVE.L  A0,A1            ; A1 is an iterator from the current prime A0 to the end of the array
    MOVE.L  (A0),D0          ; The prime A0 is the iterator step size, but needs to be scaled to the data size. 
    LSL     #(DataSize/2),D0 ; Scale step to data size
SieveLoop                    ; Zero multiple of the prime stored at A0
    ADD.L   D0,A1
    CMP     #(DataAddress+Count*DataSize),A1
    BGT     NextPrimeLoop
    MOVE.L  #0,(A1)
    JMP     SieveLoop 
EndSieveLoop
NextPrimeLoop               ; Move A0 until it refers to a non-zero value which should be prime
    ADD.L   #DataSize,A0
    TST.L   (A0)
    BNE     PrimeLoop       ; Continue the Eratosthenes Sieve
    JMP     NextPrimeLoop
EndNextPrimeLoop
EndPrimeLoop

    STOP    #$2700
    SIMHALT             ; halt simulator

* Variables and constants
DataAddress EQU 0
DataSize    EQU 4
Min         EQU 2
Max         EQU 16
Count       EQU Max-Min+1

    END    START        ; last line of source




*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
