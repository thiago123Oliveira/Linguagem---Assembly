;-----------------------------------------------------
;PROGRAMA MOCHILEVE
;-----------------------------------------------------
               #INCLUDE <P16F877A.INC>
               ORG 0x00
;-----------------------------------------------------
;VARIÁVEIS 
;-----------------------------------------------------            
              cont0 EQU 0X20
              cont1 EQU 0X21
			  cont2 EQU 0X22 
              DADO  EQU 0X23
              PDEL0 EQU 0X24
              PDEL1 EQU 0X25
              RS    EQU 0X02
              E     EQU 0X03
			  RASC	EQU 0X30
;-----------------------------------------------------
;CONFIGURAÇOES DO PIC
;-----------------------------------------------------
              BCF STATUS,7
              BCF STATUS,6
              BSF STATUS,5
			  BSF TRISA,0
			  MOVLW B'01001110'
			  MOVWF ADCON1
			  CLRF INTCON
			  CLRF TRISD
			  CLRF TRISC
              BSF TRISB,1
			  BSF TRISB,2
			  BSF TRISB,4
              BCF STATUS,7
              BCF STATUS,6
              BCF STATUS,5
			  MOVLW B'10000001'
			  MOVWF ADCON0
      	      MOVLW	0x28	;INICIO
		   	  CALL	EE		;CONFIGURA PARA DUAS LINHAS
			  MOVLW	0x28	;5X7 PONTOS
			  CALL	EE		;16X2 CARACTERES
			  MOVLW	0x06	
			  CALL	EE		;4BITS
			  MOVLW	0x0C
			  CALL	EE
			  MOVLW	0x01
			  CALL	EE		;FIM
              
              
;-----------------------------------------------------
;PROGRAMA PRINCIPAL
;-----------------------------------------------------
		      BSF PORTD,1
			  CALL DELAY
			  BCF PORTD,1
			  MOVLW 0X80
			  CALL EE
			  MOVLW 'S'
			  CALL ED
			  MOVLW 'E'
			  CALL ED
			  MOVLW 'L'
			  CALL ED
			  MOVLW 'E'
			  CALL ED
			  MOVLW 'C'
			  CALL ED
			  MOVLW 'I'
			  CALL ED
			  MOVLW 'O'
			  CALL ED
			  MOVLW 'N'
			  CALL ED
			  MOVLW 'A'
			  CALL ED
			  MOVLW 'R'
			  CALL ED 
			  MOVLW ' '
			  CALL ED
			  MOVLW 'P'
			  CALL ED
			  MOVLW 'E'
			  CALL ED
			  MOVLW 'S'
			  CALL ED
			  MOVLW 'O'
			  CALL ED
			  MOVLW ' '
			  CALL ED
			  MOVLW ' '
			  CALL ED
			  CALL DELAY
VOLTA:	      CLRF PORTC
              BTFSC PORTB,1  ;TESTA SE O BOTÃO + FOI PRESSIONADO
              GOTO  MAIS
              BTFSC PORTB,2  ;TESTA SE O BOTÃO - FOI PRESSIONADO
              GOTO MENOS
              BTFSC PORTB,4  ;TESTA SE O BOTÃO OK FOI PRESSIONADO
              GOTO ERRO
              GOTO VOLTA     ;NENHUMA TECLA PRESSIONADA VOLTAR AO INICIO
ERRO:         MOVLW	0X80
		      CALL	EE
		      MOVLW	'S'
		      CALL	ED
              MOVLW	'E'
		      CALL	ED
              MOVLW	'L'
		      CALL	ED
			  MOVLW	'E'
		      CALL	ED
			  MOVLW	'C'
		      CALL	ED
			  MOVLW	'I'
		      CALL	ED
			  MOVLW	'O'
		      CALL	ED
			  MOVLW	'N'
		      CALL	ED
			  MOVLW	'A'
		      CALL	ED
			  MOVLW	'R'
		      CALL	ED
              MOVLW	' '
		      CALL	ED
              MOVLW	'P'
		      CALL	ED
			  MOVLW	'E'
		      CALL	ED
			  MOVLW	'S'
		      CALL	ED
			  MOVLW	'O'
		      CALL	ED
		      CALL	DELAY
		      GOTO	VOLTA
;-----------------------------------------------------
;ROTINA MENOS
;-----------------------------------------------------
MENOS:        CALL DELAY
              BTFSC PORTC,6  ;IDENTIFICAR O VALOR SALVO EM PORTC 
              GOTO TRINTA
              BTFSC PORTC,5  ;IDENTIFICAR O VALOR SALVO EM PORTC
              GOTO DEZ
              BTFSC PORTC,4  ;IDENTIFICAR O VALOR SALVO EM PORTC
              GOTO ZERO
;-----------------------------------------------------
              MOVLW 0X50      ;CARREGA O VALOR 50
              MOVWF PORTC    ;SALVA O VALOR 0 EM PORTC
              MOVLW 0X01
              CALL EE
		      MOVLW 0X80
              CALL EE
              MOVLW	'5'
		      CALL	ED	
			  MOVLW	'0'
		      CALL	ED
			  MOVLW	'k'
		      CALL	ED
			  MOVLW	'g'
		      CALL	ED
			  MOVLW	' '
		      CALL	ED
			  MOVLW	' '
		      CALL	ED
              CALL DELAY
VOLTA2:       BTFSC PORTB,1  ;TESTA SE O BOTÃO + FOI PRESSIONADO
              GOTO  MAIS
              BTFSC PORTB,2  ;TESTA SE O BOTÃO - FOI PRESSIONADO
              GOTO MENOS
              BTFSC PORTB,4  ;TESTA SE O BOTÃO OK FOI PRESSIONADO
              GOTO ROTINA50
              GOTO VOLTA2    ;NENHUMA TECLA PRESSIONADA VOLTAR AO VOLTA2
;------------------------------------------------------
ZERO:         CLRF PORTC
              MOVLW 0X00
              MOVWF PORTC
              MOVLW 0X01
              CALL EE
			  MOVLW 0X80
              CALL EE	
			  MOVLW	'0'
		      CALL	ED
			  MOVLW	'k'
		      CALL	ED
			  MOVLW	'g'
		      CALL	ED
			  MOVLW	' '
		      CALL	ED
			  MOVLW	' '
		      CALL	ED
              CALL DELAY
VOLTA3:       BTFSC PORTB,1  ;TESTA SE O BOTÃO + FOI PRESSIONADO
              GOTO  MAIS
              BTFSC PORTB,2  ;TESTA SE O BOTÃO - FOI PRESSIONADO
              GOTO MENOS
              BTFSC PORTB,4  ;TESTA SE O BOTÃO OK FOI PRESSIONADO
              GOTO ERRO
              GOTO VOLTA3    ;NENHUMA TECLA PRESSIONADA VOLTAR AO VOLTA3
;-------------------------------------------------------
DEZ:          BTFSC PORTC,4
              GOTO VINTE
              CLRF PORTC
              MOVLW 0X10
              MOVWF PORTC
              MOVLW 0X01
              CALL EE
		      MOVLW 0X80
              CALL EE
              MOVLW	'1'
		      CALL	ED	
			  MOVLW	'0'
		      CALL	ED
			  MOVLW	'k'
		      CALL	ED
			  MOVLW	'g'
		      CALL	ED
			  MOVLW	' '
		      CALL	ED
			  MOVLW	' '
		      CALL	ED
              CALL DELAY
VOLTA4:       BTFSC PORTB,1  ;TESTA SE O BOTÃO + FOI PRESSIONADO
              GOTO  MAIS
              BTFSC PORTB,2  ;TESTA SE O BOTÃO - FOI PRESSIONADO
              GOTO MENOS
              BTFSC PORTB,4  ;TESTA SE O BOTÃO OK FOI PRESSIONADO
              GOTO ROTINA10
              GOTO VOLTA4    ;NENHUMA TECLA PRESSIONADA VOLTAR AO VOLTA4
;------------------------------------------------------
VINTE:        CLRF PORTC
              MOVLW 0X20
              MOVWF PORTC
              MOVLW 0X01
              CALL EE
			  MOVLW 0X80
              CALL EE
              MOVLW	'2'
		      CALL	ED	
			  MOVLW	'0'
		      CALL	ED
			  MOVLW	'k'
		      CALL	ED
			  MOVLW	'g'
		      CALL	ED
			  MOVLW	' '
		      CALL	ED
			  MOVLW	' '
		      CALL	ED
              CALL DELAY
VOLTA5:       BTFSC PORTB,1  ;TESTA SE O BOTÃO + FOI PRESSIONADO
              GOTO  MAIS
              BTFSC PORTB,2  ;TESTA SE O BOTÃO - FOI PRESSIONADO
              GOTO MENOS
              BTFSC PORTB,4  ;TESTA SE O BOTÃO OK FOI PRESSIONADO
              GOTO ROTINA20
              GOTO VOLTA5    ;NENHUMA TECLA PRESSIONADA VOLTAR AO VOLTA5
;--------------------------------------------------------
TRINTA:       BTFSC PORTC,5  
              GOTO  VOLTA
              BTFSC PORTC,4  
              GOTO  QUARENTA
              CLRF PORTC
              MOVLW 0X30
              MOVWF PORTC
              MOVLW 0X01
              CALL EE
			  MOVLW 0X80
              CALL EE
              MOVLW	'3'
		      CALL	ED	
			  MOVLW	'0'
		      CALL	ED
			  MOVLW	'k'
		      CALL	ED
			  MOVLW	'g'
		      CALL	ED
			  MOVLW	' '
		      CALL	ED
		      MOVLW	' '
		      CALL	ED
              CALL DELAY 
VOLTA6:       BTFSC PORTB,1  ;TESTA SE O BOTÃO + FOI PRESSIONADO
              GOTO  MAIS
              BTFSC PORTB,2  ;TESTA SE O BOTÃO - FOI PRESSIONADO
              GOTO MENOS
              BTFSC PORTB,4  ;TESTA SE O BOTÃO OK FOI PRESSIONADO
              GOTO ROTINA30
              GOTO VOLTA6    ;NENHUMA TECLA PRESSIONADA VOLTAR AO VOLTA6
;----------------------------------------------------------------------
QUARENTA:     CLRF PORTC
              MOVLW 0X40
              MOVWF PORTC
              MOVLW 0X01
              CALL EE
			  MOVLW 0X80
              CALL EE
              MOVLW	'4'
		      CALL	ED	
			  MOVLW	'0'
		      CALL	ED
			  MOVLW	'k'
		      CALL	ED
			  MOVLW	'g'
		      CALL	ED
			  MOVLW	' '
		      CALL	ED
			  MOVLW	' '
		      CALL	ED
              CALL DELAY
VOLTA7:       BTFSC PORTB,1  ;TESTA SE O BOTÃO + FOI PRESSIONADO
              GOTO  MAIS
              BTFSC PORTB,2  ;TESTA SE O BOTÃO - FOI PRESSIONADO
              GOTO MENOS
              BTFSC PORTB,4  ;TESTA SE O BOTÃO OK FOI PRESSIONADO
              GOTO ROTINA40
              GOTO VOLTA7    ;NENHUMA TECLA PRESSIONADA VOLTAR AO VOLTA7
;-----------------------------------------------------
;ROTINA MAIS
;-----------------------------------------------------
MAIS:         CALL DELAY
		      BTFSC PORTC,6  ;IDENTIFICAR O VALOR SALVO EM PORTC 
              GOTO CINQUENTA1
              BTFSC PORTC,5  ;IDENTIFICAR O VALOR SALVO EM PORTC
              GOTO TRINTA1
              BTFSC PORTC,4  ;IDENTIFICAR O VALOR SALVO EM PORTC
              GOTO VINTE1
;-----------------------------------------------------
              MOVLW 0X10     ;CARREGA O VALOR 10
              MOVWF PORTC    ;SALVA O VALOR 0 EM PORTC
              MOVLW 0X01
              CALL EE
			  MOVLW 0X80
              CALL EE
              MOVLW	'1'
		      CALL	ED	
			  MOVLW	'0'
		      CALL	ED
			  MOVLW	'k'
		      CALL	ED
			  MOVLW	'g'
		      CALL	ED
			  MOVLW	' '
		      CALL	ED
			  MOVLW	' '
		      CALL	ED
              CALL DELAY
VOLTA8:       BTFSC PORTB,1  ;TESTA SE O BOTÃO + FOI PRESSIONADO
              GOTO  MAIS
              BTFSC PORTB,2  ;TESTA SE O BOTÃO - FOI PRESSIONADO
              GOTO MENOS
              BTFSC PORTB,4  ;TESTA SE O BOTÃO OK FOI PRESSIONADO
              GOTO ROTINA10
              GOTO VOLTA8    ;NENHUMA TECLA PRESSIONADA VOLTAR AO VOLTA8
;------------------------------------------------------
VINTE1:       CLRF PORTC
		      MOVLW 0X20
			  MOVWF PORTC
              MOVLW 0X01
              CALL EE
	          MOVLW 0X80
              CALL EE
              MOVLW	'2'
		      CALL	ED	
			  MOVLW	'0'
		      CALL	ED
			  MOVLW	'k'
		      CALL	ED
			  MOVLW	'g'
		      CALL	ED
			  MOVLW	' '
		      CALL	ED
			  MOVLW	' '
		      CALL	ED
              CALL DELAY
VOLTA9:       BTFSC PORTB,1  ;TESTA SE O BOTÃO + FOI PRESSIONADO
              GOTO  MAIS
              BTFSC PORTB,2  ;TESTA SE O BOTÃO - FOI PRESSIONADO
              GOTO MENOS
              BTFSC PORTB,4  ;TESTA SE O BOTÃO OK FOI PRESSIONADO
              GOTO ROTINA20
              GOTO VOLTA9    ;NENHUMA TECLA PRESSIONADA VOLTAR AO VOLTA9
;-------------------------------------------------------
TRINTA1:      BTFSC PORTC,4
              GOTO QUARENTA
              CLRF PORTC
              MOVLW 0X30
              MOVWF PORTC
              MOVLW 0X01
              CALL EE
			  MOVLW 0X80
              CALL EE
              MOVLW	'3'
		      CALL	ED	
			  MOVLW	'0'
		      CALL	ED
			  MOVLW	'k'
		      CALL	ED
			  MOVLW	'g'
		      CALL	ED
			  MOVLW	' '
		      CALL	ED
			  MOVLW	' '
		      CALL	ED
              CALL DELAY
VOLTA10:      BTFSC PORTB,1  ;TESTA SE O BOTÃO + FOI PRESSIONADO
              GOTO  MAIS
              BTFSC PORTB,2  ;TESTA SE O BOTÃO - FOI PRESSIONADO
              GOTO MENOS
              BTFSC PORTB,4  ;TESTA SE O BOTÃO OK FOI PRESSIONADO
              GOTO ROTINA30
              GOTO VOLTA10    ;NENHUMA TECLA PRESSIONADA VOLTAR AO VOLTA10
;------------------------------------------------------
QUARENTA1:    CLRF PORTC
              MOVLW 0X40
              MOVWF PORTC
              MOVLW 0X01
              CALL EE
	  	      MOVLW 0X80
              CALL EE
              MOVLW	'4'
		      CALL	ED	
			  MOVLW	'0'
		      CALL	ED
			  MOVLW	'k'
		      CALL	ED
			  MOVLW	'g'
		      CALL	ED
			  MOVLW	' '
		      CALL	ED
			  MOVLW	' '
		      CALL	ED
              CALL DELAY
VOLTA11:      BTFSC PORTB,1  ;TESTA SE O BOTÃO + FOI PRESSIONADO
              GOTO  MAIS
              BTFSC PORTB,2  ;TESTA SE O BOTÃO - FOI PRESSIONADO
              GOTO MENOS
              BTFSC PORTB,4  ;TESTA SE O BOTÃO OK FOI PRESSIONADO
              GOTO ROTINA40
              GOTO VOLTA11    ;NENHUMA TECLA PRESSIONADA VOLTAR AO VOLTA11
;--------------------------------------------------------
CINQUENTA1:   BTFSC PORTC,5  
              GOTO  VOLTA
              BTFSC PORTC,4  
              GOTO  ZERO1
              CLRF PORTC
              MOVLW 0X50
              MOVWF PORTC
              MOVLW 0X01
              CALL EE
			  MOVLW 0X80
              CALL EE
              MOVLW	'5'
		      CALL	ED	
			  MOVLW	'0'
		      CALL	ED
			  MOVLW	'k'
		      CALL	ED
			  MOVLW	'g'
		      CALL	ED
			  MOVLW	' '
		      CALL	ED
			  MOVLW	' '
		      CALL	ED
              CALL DELAY 
VOLTA12:      BTFSC PORTB,1  ;TESTA SE O BOTÃO + FOI PRESSIONADO
              GOTO  MAIS
              BTFSC PORTB,2  ;TESTA SE O BOTÃO - FOI PRESSIONADO
              GOTO MENOS
              BTFSC PORTB,4  ;TESTA SE O BOTÃO OK FOI PRESSIONADO
              GOTO ROTINA50
              GOTO VOLTA12    ;NENHUMA TECLA PRESSIONADA VOLTAR AO VOLTA12
;----------------------------------------------------------------------
ZERO1:        CLRF PORTC
              MOVLW 0X01
              CALL EE
			  MOVLW 0X80
              CALL EE	
			  MOVLW	'0'
		      CALL	ED
			  MOVLW	'k'
		      CALL	ED
			  MOVLW	'g'
		      CALL	ED
			  MOVLW	' '
		      CALL	ED
			  MOVLW	' '
		      CALL	ED
              CALL DELAY
VOLTA13:      BTFSC PORTB,1  ;TESTA SE O BOTÃO + FOI PRESSIONADO
              GOTO  MAIS
              BTFSC PORTB,2  ;TESTA SE O BOTÃO - FOI PRESSIONADO
              GOTO MENOS
              BTFSC PORTB,4  ;TESTA SE O BOTÃO OK FOI PRESSIONADO
              GOTO ERRO
              GOTO VOLTA13    ;NENHUMA TECLA PRESSIONADA VOLTAR AO VOLTA13
    
;-------------------------------------------------------
;CONVERSOR A/D
;-------------------------------------------------------
ROTINA10:     BSF ADCON0,0
			  CLRF ADRESH	  
              CLRF RASC
              BSF ADCON0,2   ;INICIA A CONVERSÃO
RETORNA:      BTFSC ADCON0,2
              GOTO RETORNA
			  MOVF ADRESH,0  ;CARREGA O VALOR DA CONVERSÃO
			  BCF ADCON0,0   ;DESLIGA O CONVERSOR ANALÓGICO
			  MOVWF RASC     ;SALVA O VALOR DA CONVERSÃO EM RASC
			  BTFSC RASC,7   ;TESTE BIT 7,SE 1 VAI PARA TESTE1,SE 0 IGUAL A 1KG
			  GOTO TESTE1
			  MOVLW 0X01	  ;0XXXXXXX = IGUAL A 1KG
              CALL EE
			  MOVLW 0X80
              CALL EE	
			  MOVLW	'O'
		      CALL	ED
			  MOVLW	'K'
			  CALL  ED
			  MOVLW	' '
		      CALL	ED
			  MOVLW	' '
		      CALL	ED
              CALL DELAY
			  GOTO VOLTA
TESTE1:		  BTFSC RASC,4    ;TESTA BIT 4,SE 1 VAI PARA TESTE2,SE 0 IGUAL A 1KG
			  GOTO TESTE2
			  MOVLW 0X01	  ;1XX0XXX = IGUAL A 1KG
              CALL EE
			  MOVLW 0X80
              CALL EE	
			  MOVLW	'O'
		      CALL	ED
			  MOVLW	'K'
			  CALL  ED
			  MOVLW	' '
		      CALL	ED
			  MOVLW	' '
		      CALL	ED
              CALL DELAY
			  GOTO VOLTA
TESTE2:		  BTFSC RASC,2    ;1XX1XXXX = TESTA BIT 2,SE 1 VAI PARA TESTE3,SE 0 TESTA BIT
			  GOTO TESTE3
			  BTFSC RASC,0    ;1XX1X0XX = TESTA BIT 0,SE 1 IGUAL A 3KG,SE 0 IGUAL A 2KG
			  GOTO TRES0
			  BSF PORTD,1     ;ACIONA BUZZER
			  CALL DELAY
			  BCF PORTD,1	  ;DESATIVA BUZZER
		      MOVLW 0X01	  ;1XX1X0X0 = IGUAL A 2KG
              CALL EE
			  MOVLW 0X80
              CALL EE	
			  MOVLW	'E'
		      CALL	ED
			  MOVLW	'X'
		      CALL	ED
			  MOVLW	'C'
		      CALL	ED
			  MOVLW	'E'
		      CALL	ED
			  MOVLW	'D'
		      CALL	ED
		      MOVLW	'E'
		      CALL	ED
			  MOVLW	'U'
		      CALL	ED
			  MOVLW	' '
		      CALL	ED
			  MOVLW	'1'
		      CALL	ED
			  MOVLW	'K'
		      CALL	ED
			  MOVLW	'G'
		      CALL	ED
		      MOVLW	' '
		      CALL	ED
			  MOVLW	' '
		      CALL	ED
              CALL DELAY
			  GOTO VOLTA
TRES0:		  BSF PORTD,1    ;ACIONA BUZZER
			  CALL DELAY
			  BCF PORTD,1	 ;DESATIVA BUZZER
		      MOVLW 0X01	 ;1XX1X0X1 = IGUAL A 3KG
              CALL EE
			  MOVLW 0X80
              CALL EE	
			  MOVLW	'E'
		      CALL	ED
			  MOVLW	'X'
		      CALL	ED
			  MOVLW	'C'
		      CALL	ED
			  MOVLW	'E'
		      CALL	ED
			  MOVLW	'D'
		      CALL	ED
		      MOVLW	'E'
		      CALL	ED
			  MOVLW	'U'
		      CALL	ED
			  MOVLW	' '
		      CALL	ED
			  MOVLW	'2'
		      CALL	ED
			  MOVLW	'K'
		      CALL	ED
			  MOVLW	'G'
		      CALL	ED
		      MOVLW	' '
		      CALL	ED
			  MOVLW	' '
		      CALL	ED
              CALL DELAY
			  GOTO VOLTA
TESTE3:		  BTFSC RASC,1   ;1XX1X1XX = TESTA BIT 1,SE 1 IGUAL A 5KG,SE 0 IGUAL 4KG
		      GOTO CINCO0
			  BSF PORTD,1    ;ACIONA BUZZER
			  CALL DELAY
			  BCF PORTD,1	 ;DESATIVA BUZZER
		      MOVLW 0X01	 ;1XX1X10X = IGUAL A 4KG
              CALL EE
			  MOVLW 0X80
              CALL EE	
			  MOVLW	'E'
		      CALL	ED
			  MOVLW	'X'
		      CALL	ED
			  MOVLW	'C'
		      CALL	ED
			  MOVLW	'E'
		      CALL	ED
			  MOVLW	'D'
		      CALL	ED
		      MOVLW	'E'
		      CALL	ED
			  MOVLW	'U'
		      CALL	ED
			  MOVLW	' '
		      CALL	ED
			  MOVLW	'3'
		      CALL	ED
			  MOVLW	'K'
		      CALL	ED
			  MOVLW	'G'
		      CALL	ED
		      MOVLW	' '
		      CALL	ED
			  MOVLW	' '
		      CALL	ED
              CALL DELAY
			  GOTO VOLTA
CINCO0:		  BSF PORTD,1    ;ACIONA BUZZER
			  CALL DELAY
			  BCF PORTD,1	 ;DESATIVA BUZZER
		      MOVLW 0X01	 ;1XX1X11X = IGUAL A 5KG
              CALL EE
			  MOVLW 0X80
              CALL EE	
			  MOVLW	'E'
		      CALL	ED
			  MOVLW	'X'
		      CALL	ED
			  MOVLW	'C'
		      CALL	ED
			  MOVLW	'E'
		      CALL	ED
			  MOVLW	'D'
		      CALL	ED
		      MOVLW	'E'
		      CALL	ED
			  MOVLW	'U'
		      CALL	ED
			  MOVLW	' '
		      CALL	ED
			  MOVLW	'4'
		      CALL	ED
			  MOVLW	'K'
		      CALL	ED
			  MOVLW	'G'
		      CALL	ED
		      MOVLW	' '
		      CALL	ED
			  MOVLW	' '
		      CALL	ED
              CALL DELAY
			  GOTO VOLTA
			
			  
              
;-------------------------------------------------------
ROTINA20:     BSF ADCON0,0
			  CLRF ADRESH	  
              CLRF RASC
              BSF ADCON0,2   ;INICIA A CONVERSÃO
RETORNA1:     BTFSC ADCON0,2
              GOTO RETORNA1
			  MOVF ADRESH,0  ;CARREGA O VALOR DA CONVERSÃO
			  BCF ADCON0,0   ;DESLIGA O CONVERSOR ANALÓGICO
			  MOVWF RASC     ;SALVA O VALOR DA CONVERSÃO EM RASC
			  BTFSC RASC,7   ;TESTE BIT 7,SE 1 VAI PARA TESTE1,SE 0 IGUAL A 1KG
			  GOTO TESTE11
			  MOVLW 0X01	  ;0XXXXXXX = IGUAL A 1KG
              CALL EE
			  MOVLW 0X80
              CALL EE	
			  MOVLW	'O'
		      CALL	ED
			  MOVLW	'K'
			  CALL  ED
			  MOVLW	' '
		      CALL	ED
			  MOVLW	' '
		      CALL	ED
              CALL DELAY
			  GOTO VOLTA
TESTE11:	  BTFSC RASC,4    ;TESTA BIT 4,SE 1 VAI PARA TESTE2,SE 0 IGUAL A 1KG
			  GOTO TESTE21
			  MOVLW 0X01	  ;1XX0XXX = IGUAL A 1KG
              CALL EE
			  MOVLW 0X80
              CALL EE	
			  MOVLW	'O'
		      CALL	ED
			  MOVLW	'K'
			  CALL  ED
			  MOVLW	' '
		      CALL	ED
			  MOVLW	' '
		      CALL	ED
              CALL DELAY
			  GOTO VOLTA
TESTE21:	  BTFSC RASC,2    ;1XX1XXXX = TESTA BIT 2,SE 1 VAI PARA TESTE3,SE 0 TESTA BIT
			  GOTO TESTE31
			  BTFSC RASC,0    ;1XX1X0XX = TESTA BIT 0,SE 1 IGUAL A 3KG,SE 0 IGUAL A 2KG
			  GOTO TRES01
		      MOVLW 0X01	  ;1XX0XXX = IGUAL A 2KG
              CALL EE
			  MOVLW 0X80
              CALL EE	
			  MOVLW	'O'
		      CALL	ED
			  MOVLW	'K'
		      CALL  ED
			  MOVLW	' '
		      CALL	ED
			  MOVLW	' '
		      CALL	ED
              CALL DELAY
			  GOTO VOLTA
TRES01:		  BSF PORTD,1    ;ACIONA BUZZER
			  CALL DELAY
			  BCF PORTD,1	 ;DESATIVA BUZZER
		      MOVLW 0X01	 ;1XX1X0X1 = IGUAL A 3KG
              CALL EE
			  MOVLW 0X80
              CALL EE	
			  MOVLW	'E'
		      CALL	ED
			  MOVLW	'X'
		      CALL	ED
			  MOVLW	'C'
		      CALL	ED
			  MOVLW	'E'
		      CALL	ED
			  MOVLW	'D'
		      CALL	ED
		      MOVLW	'E'
		      CALL	ED
			  MOVLW	'U'
		      CALL	ED
			  MOVLW	' '
		      CALL	ED
			  MOVLW	'1'
		      CALL	ED
			  MOVLW	'K'
		      CALL	ED
			  MOVLW	'G'
		      CALL	ED
		      MOVLW	' '
		      CALL	ED
			  MOVLW	' '
		      CALL	ED
              CALL DELAY
			  GOTO VOLTA
TESTE31:	  BTFSC RASC,1   ;1XX1X1XX = TESTA BIT 1,SE 1 IGUAL A 5KG,SE 0 IGUAL 4KG
		      GOTO CINCO01
			  BSF PORTD,1    ;ACIONA BUZZER
			  CALL DELAY
			  BCF PORTD,1	 ;DESATIVA BUZZER
		      MOVLW 0X01	 ;1XX1X10X = IGUAL A 4KG
              CALL EE
			  MOVLW 0X80
              CALL EE	
			  MOVLW	'E'
		      CALL	ED
			  MOVLW	'X'
		      CALL	ED
			  MOVLW	'C'
		      CALL	ED
			  MOVLW	'E'
		      CALL	ED
			  MOVLW	'D'
		      CALL	ED
		      MOVLW	'E'
		      CALL	ED
			  MOVLW	'U'
		      CALL	ED
			  MOVLW	' '
		      CALL	ED
			  MOVLW	'2'
		      CALL	ED
			  MOVLW	'K'
		      CALL	ED
			  MOVLW	'G'
		      CALL	ED
		      MOVLW	' '
		      CALL	ED
			  MOVLW	' '
		      CALL	ED
              CALL DELAY
			  GOTO VOLTA
CINCO01:	  BSF PORTD,1    ;ACIONA BUZZER
			  CALL DELAY
			  BCF PORTD,1	 ;DESATIVA BUZZER
		      MOVLW 0X01	 ;1XX1X11X = IGUAL A 5KG
              CALL EE
			  MOVLW 0X80
              CALL EE	
			  MOVLW	'E'
		      CALL	ED
			  MOVLW	'X'
		      CALL	ED
			  MOVLW	'C'
		      CALL	ED
			  MOVLW	'E'
		      CALL	ED
			  MOVLW	'D'
		      CALL	ED
		      MOVLW	'E'
		      CALL	ED
			  MOVLW	'U'
		      CALL	ED
			  MOVLW	' '
		      CALL	ED
			  MOVLW	'3'
		      CALL	ED
			  MOVLW	'K'
		      CALL	ED
			  MOVLW	'G'
		      CALL	ED
		      MOVLW	' '
		      CALL	ED
			  MOVLW	' '
		      CALL	ED
              CALL DELAY
			  GOTO VOLTA
              
;---------------------------------------------------------
ROTINA30:     BSF ADCON0,0
			  CLRF ADRESH	  
              CLRF RASC
              BSF ADCON0,2   ;INICIA A CONVERSÃO
RETORNA2:     BTFSC ADCON0,2
              GOTO RETORNA2
			  MOVF ADRESH,0  ;CARREGA O VALOR DA CONVERSÃO
			  BCF ADCON0,0   ;DESLIGA O CONVERSOR ANALÓGICO
			  MOVWF RASC     ;SALVA O VALOR DA CONVERSÃO EM RASC
			  BTFSC RASC,7   ;TESTE BIT 7,SE 1 VAI PARA TESTE1,SE 0 IGUAL A 1KG
			  GOTO TESTE12
			  MOVLW 0X01	  ;0XXXXXXX = IGUAL A 1KG
              CALL EE
			  MOVLW 0X80
              CALL EE	
			  MOVLW	'O'
		      CALL	ED
			  MOVLW	'K'
			  CALL  ED
			  MOVLW	' '
		      CALL	ED
			  MOVLW	' '
		      CALL	ED
              CALL DELAY
			  GOTO VOLTA
TESTE12:	  BTFSC RASC,4    ;TESTA BIT 4,SE 1 VAI PARA TESTE2,SE 0 IGUAL A 1KG
			  GOTO TESTE22
			  MOVLW 0X01	  ;1XX0XXX = IGUAL A 1KG
              CALL EE
			  MOVLW 0X80
              CALL EE	
			  MOVLW	'O'
		      CALL	ED
			  MOVLW	'K'
			  CALL  ED
			  MOVLW	' '
		      CALL	ED
			  MOVLW	' '
		      CALL	ED
              CALL DELAY
			  GOTO VOLTA
TESTE22:	  BTFSC RASC,2    ;1XX1XXXX = TESTA BIT 2,SE 1 VAI PARA TESTE3,SE 0 TESTA BIT
			  GOTO TESTE32
			  BTFSC RASC,0    ;1XX1X0XX = TESTA BIT 0,SE 1 IGUAL A 3KG,SE 0 IGUAL A 2KG
			  GOTO TRES02
		      MOVLW 0X01	  ;1XX0XXX = IGUAL A 2KG
              CALL EE
			  MOVLW 0X80
              CALL EE	
			  MOVLW	'O'
		      CALL	ED
			  MOVLW	'K'
			  CALL  ED
			  MOVLW	' '
		      CALL	ED
			  MOVLW	' '
		      CALL	ED
              CALL DELAY
			  GOTO VOLTA
TRES02:		  MOVLW 0X01	  ;1XX0XXX = IGUAL A 2KG
              CALL EE
			  MOVLW 0X80
              CALL EE	
			  MOVLW	'O'
		      CALL	ED
			  MOVLW	'K'
			  CALL ED
			  MOVLW	' '
		      CALL	ED
			  MOVLW	' '
		      CALL	ED
              CALL DELAY
			  GOTO VOLTA
TESTE32:	  BTFSC RASC,1   ;1XX1X1XX = TESTA BIT 1,SE 1 IGUAL A 5KG,SE 0 IGUAL 4KG
		      GOTO CINCO02
			  BSF PORTD,1    ;ACIONA BUZZER
			  CALL DELAY
			  BCF PORTD,1	 ;DESATIVA BUZZER
		      MOVLW 0X01	 ;1XX1X11X = IGUAL A 5KG
              CALL EE
			  MOVLW 0X80
              CALL EE	
			  MOVLW	'E'
		      CALL	ED
			  MOVLW	'X'
		      CALL	ED
			  MOVLW	'C'
		      CALL	ED
			  MOVLW	'E'
		      CALL	ED
			  MOVLW	'D'
		      CALL	ED
		      MOVLW	'E'
		      CALL	ED
			  MOVLW	'U'
		      CALL	ED
			  MOVLW	' '
		      CALL	ED
			  MOVLW	'1'
		      CALL	ED
			  MOVLW	'K'
		      CALL	ED
			  MOVLW	'G'
		      CALL	ED
		      MOVLW	' '
		      CALL	ED
			  MOVLW	' '
		      CALL	ED
              CALL DELAY
			  GOTO VOLTA
CINCO02:	  BSF PORTD,1    ;ACIONA BUZZER
			  CALL DELAY
			  BCF PORTD,1	 ;DESATIVA BUZZER
		      MOVLW 0X01	 ;1XX1X11X = IGUAL A 5KG
              CALL EE
			  MOVLW 0X80
              CALL EE	
			  MOVLW	'E'
		      CALL	ED
			  MOVLW	'X'
		      CALL	ED
			  MOVLW	'C'
		      CALL	ED
			  MOVLW	'E'
		      CALL	ED
			  MOVLW	'D'
		      CALL	ED
		      MOVLW	'E'
		      CALL	ED
			  MOVLW	'U'
		      CALL	ED
			  MOVLW	' '
		      CALL	ED
			  MOVLW	'2'
		      CALL	ED
			  MOVLW	'K'
		      CALL	ED
			  MOVLW	'G'
		      CALL	ED
		      MOVLW	' '
		      CALL	ED
			  MOVLW	' '
		      CALL	ED
              CALL DELAY
			  GOTO VOLTA
              
;-------------------------------------------------------
ROTINA40:     BSF ADCON0,0
			  CLRF ADRESH	  
              CLRF RASC
              BSF ADCON0,2   ;INICIA A CONVERSÃO
RETORNA3:     BTFSC ADCON0,2
              GOTO RETORNA3
			  MOVF ADRESH,0  ;CARREGA O VALOR DA CONVERSÃO
			  BCF ADCON0,0   ;DESLIGA O CONVERSOR ANALÓGICO
			  MOVWF RASC     ;SALVA O VALOR DA CONVERSÃO EM RASC
			  BTFSC RASC,7   ;TESTE BIT 7,SE 1 VAI PARA TESTE1,SE 0 IGUAL A 1KG
			  GOTO TESTE13
			  MOVLW 0X01	  ;0XXXXXXX = IGUAL A 1KG
              CALL EE
			  MOVLW 0X80
              CALL EE	
			  MOVLW	'O'
		      CALL	ED
			  MOVLW	'K'
			  CALL  ED
			  MOVLW	' '
		      CALL	ED
			  MOVLW	' '
		      CALL	ED
              CALL DELAY
			  GOTO VOLTA
TESTE13:	  BTFSC RASC,4    ;TESTA BIT 4,SE 1 VAI PARA TESTE2,SE 0 IGUAL A 1KG
			  GOTO TESTE23
			  MOVLW 0X01	  ;1XX0XXX = IGUAL A 1KG
              CALL EE
			  MOVLW 0X80
              CALL EE	
			  MOVLW	'O'
		      CALL	ED
			  MOVLW	'K'
			  CALL ED
			  MOVLW	' '
		      CALL	ED
			  MOVLW	' '
		      CALL	ED
              CALL DELAY
			  GOTO VOLTA
TESTE23:	  BTFSC RASC,2    ;1XX1XXXX = TESTA BIT 2,SE 1 VAI PARA TESTE3,SE 0 TESTA BIT
			  GOTO TESTE33
			  BTFSC RASC,0    ;1XX1X0XX = TESTA BIT 0,SE 1 IGUAL A 3KG,SE 0 IGUAL A 2KG
			  GOTO TRES03
		      MOVLW 0X01	  ;1XX0XXX = IGUAL A 2KG
              CALL EE
			  MOVLW 0X80
              CALL EE	
			  MOVLW	'O'
		      CALL	ED
			  MOVLW	'K'
			  CALL ED
			  MOVLW	' '
		      CALL	ED
			  MOVLW	' '
		      CALL	ED
              CALL DELAY
			  GOTO VOLTA
TRES03:		  MOVLW 0X01	  ;1XX0XXX = IGUAL A 2KG
              CALL EE
			  MOVLW 0X80
              CALL EE	
			  MOVLW	'O'
		      CALL	ED
			  MOVLW	'K'
			  CALL ED
			  MOVLW	' '
		      CALL	ED
			  MOVLW	' '
		      CALL	ED
              CALL DELAY
			  GOTO VOLTA
TESTE33:	  BTFSC RASC,1   ;1XX1X1XX = TESTA BIT 1,SE 1 IGUAL A 5KG,SE 0 IGUAL 4KG
		      GOTO CINCO03
			  MOVLW 0X01	  ;1XX0XXX = IGUAL A 2KG
              CALL EE
			  MOVLW 0X80
              CALL EE	
			  MOVLW	'O'
		      CALL	ED
			  MOVLW	'K'
		      CALL ED
			  MOVLW	' '
		      CALL	ED
			  MOVLW	' '
		      CALL	ED
              CALL DELAY
			  GOTO VOLTA
CINCO03:	  BSF PORTD,1    ;ACIONA BUZZER
			  CALL DELAY
			  BCF PORTD,1	 ;DESATIVA BUZZER
		      MOVLW 0X01	 ;1XX1X11X = IGUAL A 5KG
              CALL EE
			  MOVLW 0X80
              CALL EE	
			  MOVLW	'E'
		      CALL	ED
			  MOVLW	'X'
		      CALL	ED
			  MOVLW	'C'
		      CALL	ED
			  MOVLW	'E'
		      CALL	ED
			  MOVLW	'D'
		      CALL	ED
		      MOVLW	'E'
		      CALL	ED
			  MOVLW	'U'
		      CALL	ED
			  MOVLW	' '
		      CALL	ED
			  MOVLW	'1'
		      CALL	ED
			  MOVLW	'K'
		      CALL	ED
			  MOVLW	'G'
		      CALL	ED
		      MOVLW	' '
		      CALL	ED
			  MOVLW	' '
		      CALL	ED
              CALL DELAY
			  GOTO VOLTA
              
;-------------------------------------------------------
ROTINA50:     BSF ADCON0,0
			  CLRF ADRESH	  
              CLRF RASC
              BSF ADCON0,2   ;INICIA A CONVERSÃO
RETORNA4:     BTFSC ADCON0,2
              GOTO RETORNA4
			  MOVF ADRESH,0  ;CARREGA O VALOR DA CONVERSÃO
			  BCF ADCON0,0   ;DESLIGA O CONVERSOR ANALÓGICO
			  MOVWF RASC     ;SALVA O VALOR DA CONVERSÃO EM RASC
			  BTFSC RASC,7   ;TESTE BIT 7,SE 1 VAI PARA TESTE1,SE 0 IGUAL A 1KG
			  GOTO TESTE14
			  MOVLW 0X01	  ;0XXXXXXX = IGUAL A 1KG
              CALL EE
			  MOVLW 0X80
              CALL EE	
			  MOVLW	'O'
		      CALL	ED
			  MOVLW	'K'
			  CALL ED
			  MOVLW	' '
		      CALL	ED
			  MOVLW	' '
		      CALL	ED
              CALL DELAY
			  GOTO VOLTA
TESTE14:	  BTFSC RASC,4    ;TESTA BIT 4,SE 1 VAI PARA TESTE2,SE 0 IGUAL A 1KG
			  GOTO TESTE24
			  MOVLW 0X01	  ;1XX0XXX = IGUAL A 1KG
              CALL EE
			  MOVLW 0X80
              CALL EE	
			  MOVLW	'O'
		      CALL	ED
			  MOVLW	'K'
			  CALL ED
			  MOVLW	' '
		      CALL	ED
			  MOVLW	' '
		      CALL	ED
              CALL DELAY
			  GOTO VOLTA
TESTE24:	  BTFSC RASC,2    ;1XX1XXXX = TESTA BIT 2,SE 1 VAI PARA TESTE3,SE 0 TESTA BIT
			  GOTO TESTE34
			  BTFSC RASC,0    ;1XX1X0XX = TESTA BIT 0,SE 1 IGUAL A 3KG,SE 0 IGUAL A 2KG
			  GOTO TRES04
		      MOVLW 0X01	  ;1XX0XXX = IGUAL A 2KG
              CALL EE
			  MOVLW 0X80
              CALL EE	
			  MOVLW	'O'
		      CALL	ED
			  MOVLW	'K'
			  CALL ED
			  MOVLW	' '
		      CALL	ED
			  MOVLW	' '
		      CALL	ED
              CALL DELAY
			  GOTO VOLTA
TRES04:		  MOVLW 0X01	  ;1XX0XXX = IGUAL A 2KG
              CALL EE
			  MOVLW 0X80
              CALL EE	
			  MOVLW	'O'
		      CALL	ED
			  MOVLW	'K'
			  CALL ED
			  MOVLW	' '
		      CALL	ED
			  MOVLW	' '
		      CALL	ED
              CALL DELAY
			  GOTO VOLTA
TESTE34:	  BTFSC RASC,1   ;1XX1X1XX = TESTA BIT 1,SE 1 IGUAL A 5KG,SE 0 IGUAL 4KG
		      GOTO CINCO04
			  MOVLW 0X01	  ;1XX0XXX = IGUAL A 2KG
              CALL EE
			  MOVLW 0X80
              CALL EE	
			  MOVLW	'O'
		      CALL	ED
			  MOVLW	'K'
			  CALL ED
			  MOVLW	' '
		      CALL	ED
			  MOVLW	' '
		      CALL	ED
              CALL DELAY
			  GOTO VOLTA
CINCO04:	  MOVLW 0X01	  ;1XX0XXX = IGUAL A 2KG
              CALL EE
			  MOVLW 0X80
              CALL EE	
			  MOVLW	'O'
		      CALL	ED
			  MOVLW	'K'
			  CALL ED
			  MOVLW	' '
		      CALL	ED
			  MOVLW	' '
		      CALL	ED
              CALL DELAY
			  GOTO VOLTA
  
;------------------------------------------------------------   
;DELAY
;------------------------------------------------------------

DELAY: 		  movlw     .18       ; 1 set number of repetitions (C)
        	  movwf     cont0     ; 1 |
PLoop0  	  movlw     .70       ; 1 set number of repetitions (B)
        	  movwf     cont1     ; 1 |
PLoop1  	  movlw     .247      ; 1 set number of repetitions (A)
        	  movwf     cont2     ; 1 |
PLoop2  	  clrwdt              ; 1 clear watchdog
        	  decfsz    cont2, 1  ; 1 + (1) is the time over? (A)
        	  goto      PLoop2    ; 2 no, loop
        	  decfsz    cont1,  1 ; 1 + (1) is the time over? (B)
        	  goto      PLoop1    ; 2 no, loop
        	  decfsz    cont0,  1 ; 1 + (1) is the time over? (C)
        	  goto      PLoop0    ; 2 no, loop
PDelL1  	  goto      PDelL2         ; 2 cycles delay
PDelL2  	  clrwdt              ; 1 cycle delay
        	  return              ; 2+2 Done
;--------------------------------------------------------------
;ROTINAS LCD
;-------------------------------------------------------------
ED:			BSF	PORTD,RS	;ESCREVE DADO
		    GOTO ENVIABYTE	;QUE ESTA COM W
EE:			BCF	PORTD,RS	;ESCREVE O ENDEREÇO OU COMANDO QUE ESTA EM W
			GOTO ENVIABYTE
		
ENVIABYTE:	BSF		PORTD,E
	    	MOVWF	DADO
			MOVLW	0x0F
			ANDWF	PORTD,F
			MOVLW	0xF0
			ANDWF	DADO,W
			IORWF	PORTD,F
			BCF		PORTD,E
			BSF		PORTD,E
			SWAPF	DADO,F
			MOVLW	0x0F
			ANDWF	PORTD,F
			MOVLW	0xF0
			ANDWF	DADO,W
			IORWF	PORTD,F
			BCF		PORTD,E
			CALL	ATRASO_3MS
			RETURN
		

;----------------------------------------------------
;DELAY LCD
;----------------------------------------------------

ATRASO_3MS: movlw     .6        ; 1 set number of repetitions (B)
            movwf     PDEL0     ; 1 |
PLoop11  	movlw     .249      ; 1 set number of repetitions (A)
        	movwf     PDEL1     ; 1 |
PLoop21  	clrwdt              ; 1 clear watchdog
        	clrwdt              ; 1 cycle delay
        	decfsz    PDEL1, 1  ; 1 + (1) is the time over? (A)
        	goto      PLoop21    ; 2 no, loop
        	decfsz    PDEL0,  1 ; 1 + (1) is the time over? (B)
        	goto      PLoop11    ; 2 no, loop
        	clrwdt              ; 1 cycle delay
        	return              ; 2+2 Done
		     
		
        	 END 