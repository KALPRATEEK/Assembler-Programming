
  ;******************** (C) COPYRIGHT Prateek Kalra ********************************
;* File Name          : main.s
;* Author             : Prateek Kalra
;* Version            : V1.0
;* Date               : 21-11-2023
;* Description        : This is a main fuer Prime Sieb;					  :
;					 
;
; 
;
;
;     section .text
.global _start

_start:
       r0 ist mein Start register
       r1 ist mein current index
        r2 nutzt fuer Divisor method 

  Sieve_Loop:

    /* 

    The following block represents the Sieve of Eratosthenes algorithm:

    ; Check if the current index(r1) is less than 2 or 2 , then straight to end, if not true to go branch check_prime
    ; Check_prime using  Divisor, if divisor greater than or equal to number (go to branch is_prime)    
    ; If prime , perform actions like printing or storing the prime number and going back to branch Check_prime for continue checking.(zb in ein neue regiter mit LDRB speciherna auch dann in rheinfolge )
    ; Auch das Bit toggeln dann in R0 , mit hilfe Xor
    ; Increment the index (r1).
    ; Move to the next number.
    ; Check if the upper limit is reached.
    ; Continue the loop if not.
    ; speciher wir addresse  : und wenn as off set ist dann current adress-anfang
    ; wir mahcen das mit siev emthode, dabei machen wir bis 32 durch wenn es prime ist dass markieren das es ist rime ist . 
     

;*******************************************************************************

;Woche 5



_start:
  ; Main program execution starts here

  ; Part 1: Sieb (Sieve)


	
AREA MyData, DATA, align = 2
		
Prim 		FILL 1001,1,1  ; each byte represent the number and which is right now 1 for  the start , as we assume no number is prime. The offset from this address will give us the value of prime number. 
Tausend 	DCW 1000 ; A halfword declared 000. 

;********************************************
; Code section, aligned on 8-byte boundery
;********************************************

	AREA |.text|, CODE, READONLY, ALIGN = 3
		
		

;--------------------------------------------
; main subroutine
;--------------------------------------------
		EXPORT main
		EXTERN initITSboard
main	PROC
        BL initITSboard ; this branch with link (BL) instruction calls the initITSboard subroutine. The link instruction saves the return address in the link register (LR)

	
		
;------- Primzahlenfeld initinazieren

	LDR R0,=Prim ;loads the base address of Prim in r0
	mov R4,0x03E8; moves value of 1000 in r4 (hexa value 1000) 
	MOV R1,#0; copy 0 in r1
	STRB R1,[R0]; 
	STRB R1,[R0,#1]
	
for_1
	mov R2,#2	; i = R2  storing the index value in r2
	
until_1
	mul R5,R2,R2 ;     i*i = R5 ;using r5 for mutilples of each number till it reaches 1000
	cmp R5,R4	; i*i > 1000  checking if we already reach 1000 the upper limit.
	bhi enddo_1    ;  If r5 is more than 1000 go to branch enddo_1
	
do_1                      ; if not then do the following.
	
if_2
			ldrb R6,[R0,R2]   ; load the current byte , using offset r2 in r6
			cmp R6,#0    ; compare r6 with 0
			beq then_2   ; if equal go to then_2  ; this is when the number is prime  i.e 1 in prim array.
			b else_2     ; if not prime ,go to else_2

then_2

for_3
		mov R3, R5 ; j=R3    , the value of r3 holds the byte representing prime number.
							
until_3
		cmp R3, R4 ; if i*i >1000 ,quit 
		bhi enddo_3 ; wenn j>1000 end
do_3
		strb R1, [R0,R3] ; storing 0 at the adress given by r0+r3 effictevely marking it as non prime 
step_3
		add R3, R2 ; marking the mutiples of r2 to mark all of them as non prime
		b until_3
enddo_3 
			
else_2 
enif_2  ; using for continuing after each iteration
			
			
step_1
	add R2, #1  ; incrementing the index 
	b until_1 ; go to start branch again. 
enddo_1

forever	b	forever		; nowhere to retun if main ends		
	ENDP
       
	END




  
  ; Part 2: Abspeichern (Store)

  ; Comment: Store the primes in resultArray based on the marked information in sieveArray
  ; Code: StorePrimes()

  ; Comment: Exit the program
  ; Code: ExitProgram()


