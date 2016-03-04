
_main:
	LDI        R27, 255
	OUT        SPL+0, R27
	LDI        R27, 0
	OUT        SPL+1, R27
	IN         R28, SPL+0
	IN         R29, SPL+1
	SBIW       R28, 7
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	ADIW       R28, 1

;main.c,22 :: 		void main()
;main.c,26 :: 		system_init();      // Initialize the system
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	CALL       _system_init+0
;main.c,27 :: 		terminal_put_string( "Enter a Command\r\n" );
	LDI        R27, #lo_addr(?lstr1_main+0)
	MOV        R2, R27
	LDI        R27, hi_addr(?lstr1_main+0)
	MOV        R3, R27
	CALL       _terminal_put_string+0
;main.c,29 :: 		while( 1 )
L_main0:
;main.c,31 :: 		if( rx_flag == 1 )
	LDS        R16, _rx_flag+0
	CPI        R16, 1
	BREQ       L__main15
	JMP        L_main2
L__main15:
;main.c,34 :: 		if( command_parse( rx_buffer.buffer, &my_command ) == COMMAND_VALID )
	MOVW       R16, R28
	MOVW       R4, R16
	LDI        R27, #lo_addr(_rx_buffer+0)
	MOV        R2, R27
	LDI        R27, hi_addr(_rx_buffer+0)
	MOV        R3, R27
	CALL       _command_parse+0
	CPI        R16, 1
	BREQ       L__main16
	JMP        L_main3
L__main16:
;main.c,36 :: 		execute_command( &my_command );
	MOVW       R16, R28
	MOVW       R2, R16
	CALL       _execute_command+0
;main.c,37 :: 		}
L_main3:
;main.c,38 :: 		if( command_parse( rx_buffer.buffer, &my_command ) == COMMAND_INVALID )
	MOVW       R16, R28
	MOVW       R4, R16
	LDI        R27, #lo_addr(_rx_buffer+0)
	MOV        R2, R27
	LDI        R27, hi_addr(_rx_buffer+0)
	MOV        R3, R27
	CALL       _command_parse+0
	CPI        R16, 0
	BREQ       L__main17
	JMP        L_main4
L__main17:
;main.c,40 :: 		terminal_put_string(" ERROR: not a valid command.");
	LDI        R27, #lo_addr(?lstr2_main+0)
	MOV        R2, R27
	LDI        R27, hi_addr(?lstr2_main+0)
	MOV        R3, R27
	CALL       _terminal_put_string+0
;main.c,41 :: 		terminal_put_string("\n\r Type 'H:' for help. \n\r");
	LDI        R27, #lo_addr(?lstr3_main+0)
	MOV        R2, R27
	LDI        R27, hi_addr(?lstr3_main+0)
	MOV        R3, R27
	CALL       _terminal_put_string+0
;main.c,42 :: 		}
L_main4:
;main.c,44 :: 		terminal_put_string( "Enter a Command\r\n" );
	LDI        R27, #lo_addr(?lstr4_main+0)
	MOV        R2, R27
	LDI        R27, hi_addr(?lstr4_main+0)
	MOV        R3, R27
	CALL       _terminal_put_string+0
;main.c,45 :: 		rx_buffer.index = 0;
	LDI        R27, 0
	STS        _rx_buffer+100, R27
;main.c,46 :: 		rx_flag = 0;
	LDI        R27, 0
	STS        _rx_flag+0, R27
;main.c,47 :: 		}
L_main2:
;main.c,54 :: 		asm sleep;
	SLEEP
;main.c,55 :: 		}
	JMP        L_main0
;main.c,56 :: 		}
L_end_main:
	POP        R5
	POP        R4
	POP        R3
	POP        R2
L__main_end_loop:
	JMP        L__main_end_loop
; end of _main

_system_init:

;main.c,61 :: 		void system_init()
;main.c,63 :: 		terminal_init( 38400 );  // Initialize the UART RX and TX to 38400 baud
	PUSH       R2
	PUSH       R3
	PUSH       R4
	LDI        R27, 0
	MOV        R2, R27
	LDI        R27, 150
	MOV        R3, R27
	CALL       _terminal_init+0
;main.c,69 :: 		UCSRB |= ( 1 << RXCIE );  // Enable RX Interrupts
	IN         R27, UCSRB+0
	SBR        R27, 128
	OUT        UCSRB+0, R27
;main.c,70 :: 		asm sei;                  // Enable global interrupts
	SEI
;main.c,72 :: 		Delay_ms( 100 );          // Optional, but gives our UART time to stabilize
	LDI        R18, 5
	LDI        R17, 15
	LDI        R16, 242
L_system_init5:
	DEC        R16
	BRNE       L_system_init5
	DEC        R17
	BRNE       L_system_init5
	DEC        R18
	BRNE       L_system_init5
;main.c,74 :: 		Sound_Init( &PORTD,4 );   // Initialize sound pin
	LDI        R27, 4
	MOV        R4, R27
	LDI        R27, #lo_addr(PORTD+0)
	MOV        R2, R27
	LDI        R27, hi_addr(PORTD+0)
	MOV        R3, R27
	CALL       _Sound_Init+0
;main.c,75 :: 		DDRA = 0xff;              // Port A for LED Outputs
	LDI        R27, 255
	OUT        DDRA+0, R27
;main.c,76 :: 		}
L_end_system_init:
	POP        R4
	POP        R3
	POP        R2
	RET
; end of _system_init

_rxc_isr:
	PUSH       R30
	PUSH       R31
	PUSH       R27
	IN         R27, SREG+0
	PUSH       R27

;main.c,82 :: 		void rxc_isr() iv IVT_ADDR_USART__RXC ics ICS_AUTO
;main.c,84 :: 		char tmp_char = UDR;
; tmp_char start address is: 19 (R19)
	IN         R19, UDR+0
;main.c,86 :: 		if( tmp_char == '\n' || rx_buffer.index == MAX_BUFFER - 1 )
	CPI        R19, 10
	BRNE       L__rxc_isr21
	JMP        L__rxc_isr13
L__rxc_isr21:
	LDS        R16, _rx_buffer+100
	CPI        R16, 99
	BRNE       L__rxc_isr22
	JMP        L__rxc_isr12
L__rxc_isr22:
	JMP        L_rxc_isr9
; tmp_char end address is: 19 (R19)
L__rxc_isr13:
L__rxc_isr12:
;main.c,88 :: 		rx_flag = 1;                              // Set the flag
	LDI        R27, 1
	STS        _rx_flag+0, R27
;main.c,89 :: 		rx_buffer.buffer[rx_buffer.index] = '\0'; // Terminate the string
	LDI        R17, #lo_addr(_rx_buffer+0)
	LDI        R18, hi_addr(_rx_buffer+0)
	LDS        R16, _rx_buffer+100
	MOV        R30, R16
	LDI        R31, 0
	ADD        R30, R17
	ADC        R31, R18
	LDI        R27, 0
	ST         Z, R27
;main.c,90 :: 		rx_buffer.index = 0;                      // Reset the index
	LDI        R27, 0
	STS        _rx_buffer+100, R27
;main.c,91 :: 		}
	JMP        L_rxc_isr10
L_rxc_isr9:
;main.c,94 :: 		rx_buffer.buffer[rx_buffer.index++] = tmp_char;
; tmp_char start address is: 19 (R19)
	LDI        R17, #lo_addr(_rx_buffer+0)
	LDI        R18, hi_addr(_rx_buffer+0)
	LDS        R16, _rx_buffer+100
	MOV        R30, R16
	LDI        R31, 0
	ADD        R30, R17
	ADC        R31, R18
	ST         Z, R19
; tmp_char end address is: 19 (R19)
	LDS        R16, _rx_buffer+100
	SUBI       R16, 255
	STS        _rx_buffer+100, R16
;main.c,95 :: 		}
L_rxc_isr10:
;main.c,97 :: 		}
L_end_rxc_isr:
	POP        R27
	OUT        SREG+0, R27
	POP        R27
	POP        R31
	POP        R30
	RETI
; end of _rxc_isr
