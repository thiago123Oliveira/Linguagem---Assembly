;-----------------------------------------------
; PROGRAMA DE CONVERSÃO ADC
;----------------------------------------------

		#INCLUDE <P16F877A.INC>
		org 0x00
		cont0 equ 0x20
		cont1 equ 0x21
		cont2 equ 0x22
				
;----------------------------------------------
;CONFIGURAÇÕES DO PIC
;----------------------------------------------
	BCF STATUS,7
	BCF STATUS,5
	BCF STATUS,6
	MOVLW B'00000001'
	MOVWF ADCON0
	BSF STATUS,5
	BCF STATUS,6
	BSF TRISA,0
    CLRF TRISD
	MOVLW B'01001110'
	MOVWF ADCON1
	BCF STATUS,7
	BCF STATUS,5
	BCF STATUS,6
	
;------------------------------------------------
;PROGRAMA PRINCIPAL
;------------------------------------------------

		
		CLRF ADRESH
MAIN:	BSF ADCON0,2
CONT:	BTFSC ADCON0,2	
		GOTO CONT		
		MOVF ADRESH, 0
		BCF ADCON0,0
		MOVWF PORTD
        CALL DELAY
		GOTO MAIN	

;-------------------------------
;SUBROTINA DE ATRASO
;-------------------------------
DELAY:  movlw     .22       ; 1 set number of repetitions (C)
        movwf     cont0     ; 1 |
PLoop0  movlw     .134      ; 1 set number of repetitions (B)
        movwf     cont1     ; 1 |
PLoop1  movlw     .211      ; 1 set number of repetitions (A)
        movwf     cont2     ; 1 |
PLoop2  clrwdt              ; 1 clear watchdog
        decfsz    cont2, 1  ; 1 + (1) is the time over? (A)
        goto      PLoop2    ; 2 no, loop
        decfsz    cont1,  1 ; 1 + (1) is the time over? (B)
        goto      PLoop1    ; 2 no, loop
        decfsz    cont0,  1 ; 1 + (1) is the time over? (C)
        goto      PLoop0    ; 2 no, loop
PDelL1  goto 	  PDelL2         ; 2 cycles delay
PDelL2  clrwdt              ; 1 cycle delay
        return              ; 2+2 Done
        
        END             

		 
		
	
	