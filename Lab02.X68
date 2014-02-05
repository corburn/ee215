*-----------------------------------------------------------
* Title      : EE215 Lab02
* Written by : Jason Travis
* Date       : 2014/01/29
* Description: Find prime numbers from Min to Max using
* Eratosthenes Sieve. Min should be a prime number.
*-----------------------------------------------------------
    ORG    $0000
START:
* Initialize an array of integers from Min to Max starting at DataAddress
    LEA     DataAddress,A0
    MOVE.L  #Min,D0
InitDataLoop
    MOVE.L  D0,(A0)+
    ADD.L   #1,D0
    CMP.L   #EndDataAddress,A0
    BEQ     EndInitDataLoop
    BRA     InitDataLoop
EndInitDataLoop
    LEA     DataAddress,A0  ; Reset A0 to the beginning of the array

PrimeLoop
    CMP.L   #EndDataAddress,A0
    BEQ     EndPrimeLoop
    MOVE.L  A0,A1            ; A1 is an iterator from the current prime A0 to the end of the array
    MOVE.L  (A0),D0          ; The prime A0 is the iterator step size, but needs to be scaled to the data size. 
    LSL     #(DataSize/2),D0 ; Scale step to data size
SieveLoop                    ; Zero multiple of the prime stored at A0
    ADD.L   D0,A1
    CMP.L   #EndDataAddress,A1
    BHS     NextPrimeLoop
    MOVE.L  #0,(A1)
    BRA     SieveLoop 
EndSieveLoop
NextPrimeLoop               ; Move A0 until it refers to a non-zero value which should be prime
    ADD.L   #DataSize,A0
    TST.L   (A0)
    BNE     PrimeLoop       ; Continue the Eratosthenes Sieve
    BRA     NextPrimeLoop
EndNextPrimeLoop
EndPrimeLoop

    STOP    #$2700

* Variables and constants
Min         EQU 2
Max         EQU 16
DataSize    EQU 4
DataAddress EQU $0060
EndDataAddress  EQU DataAddress+(Max-Min+1)*DataSize

    END    START        ; last line of source






    

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
