
_command_parse:
	PUSH       R28
	PUSH       R29
	IN         R28, SPL+0
	IN         R29, SPL+1
	SBIW       R28, 2
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	ADIW       R28, 1

;command_parser.c,4 :: 		command_status_t command_parse( char* process_str, command_t* process )
;command_parser.c,6 :: 		char *p_tmp = NULL;
	PUSH       R2
	PUSH       R3
;command_parser.c,7 :: 		int i = 0;
; i start address is: 22 (R22)
	LDI        R22, 0
	LDI        R23, 0
;command_parser.c,9 :: 		if( !isalpha( process_str[0] ) || !strchr( process_str, ':' ) )
	MOVW       R30, R2
	LD         R16, Z
	PUSH       R3
	PUSH       R2
	MOV        R2, R16
	CALL       _isalpha+0
	POP        R2
	POP        R3
	TST        R16
	BRNE       L__command_parse14
	JMP        L__command_parse10
L__command_parse14:
	PUSH       R5
	PUSH       R4
	PUSH       R3
	PUSH       R2
	LDI        R27, 58
	MOV        R4, R27
	CALL       _strchr+0
	POP        R2
	POP        R3
	POP        R4
	POP        R5
	MOV        R27, R16
	OR         R27, R17
	BRNE       L__command_parse15
	JMP        L__command_parse9
L__command_parse15:
	JMP        L_command_parse2
; i end address is: 22 (R22)
L__command_parse10:
L__command_parse9:
;command_parser.c,11 :: 		return COMMAND_INVALID;
	LDI        R16, 0
	JMP        L_end_command_parse
;command_parser.c,12 :: 		}
L_command_parse2:
;command_parser.c,14 :: 		process->command = process_str[0];
; i start address is: 22 (R22)
	MOVW       R30, R2
	LD         R16, Z
	MOVW       R30, R4
	ST         Z, R16
;command_parser.c,16 :: 		p_tmp = strtok( &process_str[2], "," );
	MOVW       R16, R2
	SUBI       R16, 254
	SBCI       R17, 255
	PUSH       R5
	PUSH       R4
	LDI        R27, #lo_addr(?lstr1_command_parser+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr1_command_parser+0)
	MOV        R5, R27
	MOVW       R2, R16
	CALL       _strtok+0
	POP        R4
	POP        R5
; p_tmp start address is: 20 (R20)
	MOVW       R20, R16
; i end address is: 22 (R22)
; p_tmp end address is: 20 (R20)
;command_parser.c,18 :: 		while( p_tmp != NULL && i < 3 )
L_command_parse3:
; p_tmp start address is: 20 (R20)
; i start address is: 22 (R22)
	CPI        R21, 0
	BRNE       L__command_parse16
	CPI        R20, 0
L__command_parse16:
	BRNE       L__command_parse17
	JMP        L__command_parse12
L__command_parse17:
	LDI        R16, 3
	LDI        R17, 0
	CP         R22, R16
	CPC        R23, R17
	BRLT       L__command_parse18
	JMP        L__command_parse11
L__command_parse18:
L__command_parse7:
;command_parser.c,20 :: 		process->commands[i++] = atoi( p_tmp );
	MOVW       R18, R4
	SUBI       R18, 255
	SBCI       R19, 255
	MOVW       R16, R22
	LSL        R16
	ROL        R17
	ADD        R16, R18
	ADC        R17, R19
	STD        Y+0, R16
	STD        Y+1, R17
	PUSH       R23
	PUSH       R22
; p_tmp end address is: 20 (R20)
	PUSH       R5
	PUSH       R4
	PUSH       R3
	PUSH       R2
	MOVW       R2, R20
	CALL       _atoi+0
	POP        R2
	POP        R3
	POP        R4
	POP        R5
	POP        R22
	POP        R23
	LDD        R18, Y+0
	LDD        R19, Y+1
	MOVW       R30, R18
	ST         Z+, R16
	ST         Z+, R17
	MOVW       R16, R22
	SUBI       R16, 255
	SBCI       R17, 255
	MOVW       R22, R16
;command_parser.c,21 :: 		p_tmp = strtok( 0, "," );
	PUSH       R5
	PUSH       R4
	PUSH       R3
	PUSH       R2
	LDI        R27, #lo_addr(?lstr2_command_parser+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr2_command_parser+0)
	MOV        R5, R27
	CLR        R2
	CLR        R3
	CALL       _strtok+0
	POP        R2
	POP        R3
	POP        R4
	POP        R5
; p_tmp start address is: 20 (R20)
	MOVW       R20, R16
;command_parser.c,22 :: 		}
; i end address is: 22 (R22)
; p_tmp end address is: 20 (R20)
	JMP        L_command_parse3
;command_parser.c,18 :: 		while( p_tmp != NULL && i < 3 )
L__command_parse12:
L__command_parse11:
;command_parser.c,24 :: 		return COMMAND_VALID;
	LDI        R16, 1
;command_parser.c,25 :: 		}
;command_parser.c,24 :: 		return COMMAND_VALID;
;command_parser.c,25 :: 		}
L_end_command_parse:
	POP        R3
	POP        R2
	ADIW       R28, 1
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	POP        R29
	POP        R28
	RET
; end of _command_parse

command_parser____?ag:

L_end_command_parser___?ag:
	RET
; end of command_parser____?ag
