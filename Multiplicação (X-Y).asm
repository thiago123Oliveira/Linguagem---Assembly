;-------------------------------
;Configuações inicias
;-------------------------------
           
            include <p16f877a.inc>
            org 0x00
            bcf STATUS, 6
            bsf STATUS, 5
            movlw 06
            movwf ADCON1
            MOVLW 0
            MOVWF TRISD
            CLRF TRISB
            CLRF TRISC
            bsf TRISB,0
            bsf TRISB,1
            bsf TRISB,2
            bsf TRISB,3
            bsf TRISC,0
            bsf TRISC,1
            bsf TRISC,2
            bsf TRISC,3
            BCF STATUS,6
            BCF STATUS,5
            
            
;---------------------------------
;PROGRAMA PRINCIPAL
;---------------------------------
 
;PORTC (x)
;PORTB (Y)
;PORTD (Z)

           MOVLW 0
           MOVFW PORTD
           MOVF PORTC,1
           MOVWF 0X20
VOLTA:     MOVF 0X20,1
           ADDWF 0X20,1
           MOVWF 0X20
           DECF PORTB
           BTFSC PORTB,4
           GOTO VOLTA
           BTFSC PORTB,3
           GOTO VOLTA
           BTFSC PORTB,2
           GOTO VOLTA
           BTFSC PORTB,1
           GOTO VOLTA
           BTFSC PORTB,0
           GOTO VOLTA
           MOVF 0X20,1
           MOVLW PORTD
           END 