
_terminal_init:

;terminal.c,9 :: 		void terminal_init( uint16_t baud )
;terminal.c,12 :: 		uint32_t baud_pre = ( ( Get_Fosc_kHz() * 1000 ) / ( baud * 16UL ) ) -1;
	CALL       _Get_Fosc_kHz+0
	LDI        R20, 232
	LDI        R21, 3
	LDI        R22, 0
	LDI        R23, 0
	CALL       _HWMul_32x32+0
	LDI        R27, 4
	MOVW       R20, R2
	LDI        R22, 0
	MOV        R23, R22
L__terminal_init9:
	LSL        R20
	ROL        R21
	ROL        R22
	ROL        R23
	DEC        R27
	BRNE       L__terminal_init9
L__terminal_init10:
	CALL       _Div_32x32_U+0
	MOVW       R16, R22
	MOVW       R18, R24
	MOVW       R20, R16
	MOVW       R22, R18
	SUBI       R20, 1
	SBCI       R21, 0
	SBCI       R22, 0
	SBCI       R23, 0
;terminal.c,14 :: 		UCSRB |= ( 1 << RXEN ) | ( 1 << TXEN );
	IN         R16, UCSRB+0
	ORI        R16, 24
	OUT        UCSRB+0, R16
;terminal.c,16 :: 		UCSRC |= ( 1 << URSEL ) | ( 1 << UCSZ0 ) | ( 1 << UCSZ1 );
	IN         R16, UCSRC+0
	ORI        R16, 134
	OUT        UCSRC+0, R16
;terminal.c,18 :: 		UBRRH = ( baud_pre >> 8 );
	MOV        R16, R21
	MOV        R17, R22
	MOV        R18, R23
	LDI        R19, 0
	OUT        UBRRH+0, R16
;terminal.c,20 :: 		UBRRL = baud_pre;
	OUT        UBRRL+0, R20
;terminal.c,24 :: 		}
L_end_terminal_init:
	RET
; end of _terminal_init

_terminal_putc:

;terminal.c,34 :: 		void terminal_putc( unsigned char c )
;terminal.c,37 :: 		while( !( UCSRA & ( 1 << UDRE ) ) );
L_terminal_putc0:
	IN         R16, UCSRA+0
	SBRC       R16, 5
	JMP        L_terminal_putc1
	JMP        L_terminal_putc0
L_terminal_putc1:
;terminal.c,39 :: 		UDR = c;
	OUT        UDR+0, R2
;terminal.c,40 :: 		}
L_end_terminal_putc:
	RET
; end of _terminal_putc

_terminal_put_string:

;terminal.c,48 :: 		void terminal_put_string( unsigned char *s )
;terminal.c,50 :: 		while( *s != '\0' )
L_terminal_put_string2:
	MOVW       R30, R2
	LD         R16, Z
	CPI        R16, 0
	BRNE       L__terminal_put_string13
	JMP        L_terminal_put_string3
L__terminal_put_string13:
;terminal.c,52 :: 		terminal_putc( *s++ );
	MOVW       R30, R2
	LD         R16, Z
	PUSH       R3
	PUSH       R2
	MOV        R2, R16
	CALL       _terminal_putc+0
	POP        R2
	POP        R3
	MOVW       R16, R2
	SUBI       R16, 255
	SBCI       R17, 255
	MOVW       R2, R16
;terminal.c,53 :: 		}
	JMP        L_terminal_put_string2
L_terminal_put_string3:
;terminal.c,54 :: 		}
L_end_terminal_put_string:
	RET
; end of _terminal_put_string

_terminal_has_data:

;terminal.c,65 :: 		uint8_t terminal_has_data()
;terminal.c,67 :: 		return ( UCSRA & ( 1 << RXC ) ) ? 1 : 0;
	IN         R16, UCSRA+0
	SBRS       R16, 7
	JMP        L_terminal_has_data4
	LDI        R16, 1
	JMP        L_terminal_has_data5
L_terminal_has_data4:
	LDI        R16, 0
L_terminal_has_data5:
;terminal.c,68 :: 		}
L_end_terminal_has_data:
	RET
; end of _terminal_has_data

_terminal_getc:

;terminal.c,79 :: 		unsigned char terminal_getc()
;terminal.c,82 :: 		while( !( UCSRA & ( 1 << RXC ) ) );
L_terminal_getc6:
	IN         R16, UCSRA+0
	SBRC       R16, 7
	JMP        L_terminal_getc7
	JMP        L_terminal_getc6
L_terminal_getc7:
;terminal.c,84 :: 		return UDR;
	IN         R16, UDR+0
;terminal.c,85 :: 		}
L_end_terminal_getc:
	RET
; end of _terminal_getc

terminal____?ag:

L_end_terminal___?ag:
	RET
; end of terminal____?ag
