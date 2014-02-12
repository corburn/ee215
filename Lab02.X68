*-----------------------------------------------------------
* Title      : EE215 Lab02
* Written by : Jason Travis
* Date       : 2014/01/29
* Description: Find prime numbers from Min to Max using
* Eratosthenes Sieve. Min should be a prime number.
*-----------------------------------------------------------
    ORG    $0000
START:
* Initialize an array of long integers from Min to Max starting at DataAddress
    LEA     DataAddress,A0
    MOVE.L  #Min,D3
InitDataLoop
    MOVE.L  D3,(A0)+
    ADD.L   #1,D3
    CMP.L   #EndDataAddress,A0
    BEQ     EndInitDataLoop
    BRA     InitDataLoop
EndInitDataLoop
    LEA     DataAddress,A0     ; Reset A0 to the beginning of the array
    MOVE.L  #0,D4              ; Prime counter variable
    
PrimeLoop
    CMP.L   #EndDataAddress,A0 ; Main loop for each element in the array
    BEQ     EndPrimeLoop
    MOVE.L  A0,A1              ; A1 is an iterator from the current prime A0 to the end of the array
    MOVE.L  (A0),D3
    LSL     #(DataSize/2),D3   ; Scale the current prime by the data size for the iterator memory step size
    
    * Print the current prime as a decimal
    MOVE.B  #15,D0
    MOVE.L  (A0),D1
    MOVE.B  #10,D2
    TRAP    #15
    * Print \r\n
    MOVE.B  #6,D0
    MOVE.B  #$0D,D1
    TRAP    #15
    MOVE.B  #$0A,D1
    TRAP    #15
    
    ADDI.L  #1,D4            ; Increment prime counter
    
SieveLoop                    ; Zero multiples of the current prime
    ADD.L   D3,A1
    CMP.L   #EndDataAddress,A1
    BHS     NextPrimeLoop
    MOVE.L  #0,(A1)
    BRA     SieveLoop 
EndSieveLoop
NextPrimeLoop               ; Advance to the next prime
    ADD.L   #DataSize,A0
    TST.L   (A0)
    BNE     PrimeLoop       ; Continue the Eratosthenes Sieve
    BRA     NextPrimeLoop
EndNextPrimeLoop
EndPrimeLoop

    MOVE.B  #14,D0          ; Print prime total
    LEA     Total,A1
    TRAP    #15
    MOVE.B  #15,D0
    MOVE.L  D4,D1
    MOVE.B  #10,D2
    TRAP    #15

    STOP    #$2700

* Variables and constants
Min         EQU 2
Max         EQU 1000
DataSize    EQU 4
DataAddress EQU $00A0
EndDataAddress  EQU DataAddress+(Max-Min+1)*DataSize
Total       DC.B    'Total Primes: ',0

    END    START        ; last line of source
*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
