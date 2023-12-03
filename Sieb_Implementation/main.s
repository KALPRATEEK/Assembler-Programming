;******************** (C) COPYRIGHT Prateek Kalra ********************************
;* File Name          : main.s
;* Author             : Prateek Kalra
;* Version            : beta
;* Date               : 02.12.2023
;* Description        : 
;
<<<<<<< HEAD
=======
; 
;
;
;     section .text
.global _start
;
;_start:
 ;      r0 ist mein Start register
  ;     r1 ist mein current index
   ;     r2 nutzt fuer Divisor method 

  ;Sieve_Loop:

   ; The following block represents the Sieve of Eratosthenes algorithm:

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
     

>>>>>>> 1e40c5a032a9f407c2b3fdeab703e44677808d34
;*******************************************************************************

;********************************************
; Data section
;********************************************
	
	AREA MyData, DATA, align = 2
		
prim 	FILL 1001,1,1	; Feld von 0 bis 1000 mit 1 gefüllt (jeweils 1 Byte)
zahl	FILL 500,0,4	; Feld Von 500 für Zahlen 

; Variablen
null	DCB	0			; null
eins	DCB	1			; eins
zaehler	DCB	0			; Zähler fängt bei null an

;********************************************
; Code section, aligned on 8-byte boundary
;********************************************

	AREA MYCODE, CODE, READONLY, ALIGN = 2

;--------------------------------------------
; main subroutine
;--------------------------------------------
	EXPORT main
	EXTERN initITSboard
main	PROC
    BL initITSboard

; *************Primzahlfeld*************
    ; Primzahlenfeld initialisieren
    ldr R0, =prim    ; R0 = Anfangsadresse prim
    ldr R4, =0x03E8   ; R4 = 1000

    ldr R1, =null     ; R1 = 0, wird für das Überschreiben der 1 in prim benötigt
    STRB R1, [R0]     ; setzt prim[0] auf 0, da keine Primzahl
    STRB R1, [R0, #1] ; prim[1] auf 0

    ; ************for
for_1
    mov R2, #2        ; i = R2
until_1
    mul R5, R2, R2    ; i*i = R5
    cmp R5, R4        ; i*i > 1000
    bhi enddo_1       ; wenn i*i > 1000, beende Schleife
do_1
    ; ************if
if_2
<<<<<<< HEAD
    ldrb R6, [R0, R2] ; R6 = prim[i], (Anfang R0, geht um i(R2)-Byte weiter)
    cmp R6, #1        ; vergleicht mit der 1
    beq then_2        ; wenn 1 dann springe zu then_2
    b else_2          ; sonst zu else_2
=======
			ldrb R6,[R0,R2]   ; load the current byte , using offset r2 in r6
			cmp R6,#0    ; compare r6 with 0
			beq then_2   ; if equal go to then_2  ; this is when the number is prime  i.e 1 in prim array.
			b else_2     ; if not prime ,go to else_2

>>>>>>> 1e40c5a032a9f407c2b3fdeab703e44677808d34
then_2
    ; **********for
for_3
    mov R3, R5        ; j= R3                    
until_3
    cmp R3, R4        ; vergleicht j mit 1000
    bhi enddo_3       ; wenn j > 1000, beende Schleife
do_3
    strb R1, [R0, R3] ; setzt 0 in prim[j]
step_3
    add R3, R2        ; j += i
    b until_3
enddo_3
            
else_2
endif_2
            
step_1
    add R2, #1        ; i++
    b until_1
enddo_1

; ************Primzahlen speichern***************************
    ldr R7, =zahl     ; Speicherort für Zahlen
    ldr R2, =null     ; Start von Zahlenwert

for_4
    mov R2, #0        ; (R2, i = 0)
until_4
    cmp R2, R4        ; solange (R2) i < 1000 (R4)
    bgt enddo_4

if_5
    ldrb R6, [R0, R2] ; Prüft, ob die Zahl in prim eindeutig eine Primzahl repräsentiert
    cmp R6, #1
    beq then_5
    b endif_5
then_5
 ; mov r9,#1  
  ;strb R2, [R7,#1]     ; speichert die Primzahl in Zahlen
 str R2, [R7],#1    ; Store the value of r2 in zahl Array ,into the memory location pointed by R7 
 ;add R7, R7, r9  ; Increment R7 by 1 to move to the next position in the array

endif_5

do_4
    add R2, #1        ; (R2) i+1
    b until_4
enddo_4

; ****************************************************************
forever b forever ; nowhere to return if main ends
    ENDP
    END
