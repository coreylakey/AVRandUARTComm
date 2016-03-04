
_execute_command:
	PUSH       R28
	PUSH       R29
	IN         R28, SPL+0
	IN         R29, SPL+1
	SBIW       R28, 13
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	ADIW       R28, 1

;execution.c,8 :: 		void execute_command( command_t* execute_behavior )
;execution.c,14 :: 		switch( execute_behavior->command )
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	MOVW       R16, R2
	STD        Y+11, R16
	STD        Y+12, R17
	JMP        L_execute_command0
;execution.c,16 :: 		case 's':
L_execute_command2:
;execution.c,17 :: 		Sound_Play( execute_behavior->commands[0], execute_behavior->commands[1] );
	MOVW       R16, R2
	SUBI       R16, 255
	SBCI       R17, 255
	MOVW       R30, R16
	ADIW       R30, 2
	LD         R18, Z+
	LD         R19, Z+
	MOVW       R30, R16
	LD         R16, Z+
	LD         R17, Z+
	MOVW       R4, R18
	MOVW       R2, R16
	CALL       _Sound_Play+0
;execution.c,37 :: 		break;
	JMP        L_execute_command1
;execution.c,38 :: 		case 'l':
L_execute_command3:
;execution.c,56 :: 		while( execute_behavior->commands[0] )
L_execute_command4:
	MOVW       R30, R2
	ADIW       R30, 1
	LD         R16, Z+
	LD         R17, Z+
	MOV        R27, R16
	OR         R27, R17
	BRNE       L__execute_command65
	JMP        L_execute_command5
L__execute_command65:
;execution.c,58 :: 		terminal_put_string( "Lights\r\n" );
	PUSH       R3
	PUSH       R2
	LDI        R27, #lo_addr(?lstr1_execution+0)
	MOV        R2, R27
	LDI        R27, hi_addr(?lstr1_execution+0)
	MOV        R3, R27
	CALL       _terminal_put_string+0
	POP        R2
	POP        R3
;execution.c,59 :: 		PORTA ^= 0xff;
	IN         R16, PORTA+0
	LDI        R27, 255
	EOR        R16, R27
	OUT        PORTA+0, R16
;execution.c,60 :: 		VDelay_ms( execute_behavior->commands[1] );
	MOVW       R16, R2
	SUBI       R16, 255
	SBCI       R17, 255
	MOVW       R30, R16
	ADIW       R30, 2
	LD         R16, Z+
	LD         R17, Z+
	PUSH       R3
	PUSH       R2
	MOVW       R2, R16
	CALL       _VDelay_ms+0
	POP        R2
	POP        R3
;execution.c,61 :: 		PORTA ^= 0xff;
	IN         R16, PORTA+0
	LDI        R27, 255
	EOR        R16, R27
	OUT        PORTA+0, R16
;execution.c,62 :: 		VDelay_ms(execute_behavior->commands[1] );
	MOVW       R16, R2
	SUBI       R16, 255
	SBCI       R17, 255
	MOVW       R30, R16
	ADIW       R30, 2
	LD         R16, Z+
	LD         R17, Z+
	PUSH       R3
	PUSH       R2
	MOVW       R2, R16
	CALL       _VDelay_ms+0
	POP        R2
	POP        R3
;execution.c,63 :: 		execute_behavior->commands[0]--;
	MOVW       R18, R2
	SUBI       R18, 255
	SBCI       R19, 255
	MOVW       R30, R18
	LD         R16, Z+
	LD         R17, Z+
	SUBI       R16, 1
	SBCI       R17, 0
	MOVW       R30, R18
	ST         Z+, R16
	ST         Z+, R17
;execution.c,64 :: 		}
	JMP        L_execute_command4
L_execute_command5:
;execution.c,68 :: 		break;
	JMP        L_execute_command1
;execution.c,69 :: 		case 'a':
L_execute_command6:
;execution.c,86 :: 		DDRA &= ~( 1 << execute_behavior->commands[0] );
	MOVW       R30, R2
	ADIW       R30, 1
	LD         R16, Z
	MOV        R27, R16
	LDI        R16, 1
	TST        R27
	BREQ       L__execute_command67
L__execute_command66:
	LSL        R16
	DEC        R27
	BRNE       L__execute_command66
L__execute_command67:
	MOV        R17, R16
	COM        R17
	IN         R16, DDRA+0
	AND        R16, R17
	OUT        DDRA+0, R16
;execution.c,87 :: 		ADC_Init();
	CALL       _ADC_Init+0
;execution.c,89 :: 		adc_value = ADC_Read( execute_behavior->commands[0] );
	MOVW       R30, R2
	ADIW       R30, 1
	LD         R16, Z
	PUSH       R3
	PUSH       R2
	MOV        R2, R16
	CALL       _ADC_Read+0
	POP        R2
	POP        R3
;execution.c,90 :: 		DDRA |= ( 1 << execute_behavior->commands[0] );
	MOVW       R30, R2
	ADIW       R30, 1
	LD         R18, Z
	MOV        R27, R18
	LDI        R19, 1
	TST        R27
	BREQ       L__execute_command69
L__execute_command68:
	LSL        R19
	DEC        R27
	BRNE       L__execute_command68
L__execute_command69:
	IN         R18, DDRA+0
	OR         R18, R19
	OUT        DDRA+0, R18
;execution.c,92 :: 		IntToStr( adc_value, tmp_txt );
	MOVW       R18, R28
	MOVW       R4, R18
	MOVW       R2, R16
	CALL       _IntToStr+0
;execution.c,94 :: 		terminal_put_string( Ltrim( tmp_txt ) );
	MOVW       R16, R28
	MOVW       R2, R16
	CALL       _Ltrim+0
	MOVW       R2, R16
	CALL       _terminal_put_string+0
;execution.c,95 :: 		terminal_put_string( "\r\n" );
	LDI        R27, #lo_addr(?lstr2_execution+0)
	MOV        R2, R27
	LDI        R27, hi_addr(?lstr2_execution+0)
	MOV        R3, R27
	CALL       _terminal_put_string+0
;execution.c,100 :: 		break;
	JMP        L_execute_command1
;execution.c,101 :: 		case 't':
L_execute_command7:
;execution.c,103 :: 		if( execute_behavior->commands[0] == 0 )
	MOVW       R30, R2
	ADIW       R30, 1
	LD         R16, Z+
	LD         R17, Z+
	CPI        R17, 0
	BRNE       L__execute_command70
	CPI        R16, 0
L__execute_command70:
	BREQ       L__execute_command71
	JMP        L_execute_command8
L__execute_command71:
;execution.c,105 :: 		terminal_put_string("\r\n Press Button to excape. \r\n");
	LDI        R27, #lo_addr(?lstr3_execution+0)
	MOV        R2, R27
	LDI        R27, hi_addr(?lstr3_execution+0)
	MOV        R3, R27
	CALL       _terminal_put_string+0
;execution.c,106 :: 		led_play();
	CALL       _led_play+0
;execution.c,108 :: 		DDRC = 0xFF;
	LDI        R27, 255
	OUT        DDRC+0, R27
;execution.c,109 :: 		while(1)
L_execute_command9:
;execution.c,111 :: 		thumbstick.left_right = GetADC(1);
	PUSH       R3
	PUSH       R2
	LDI        R27, 1
	MOV        R2, R27
	CALL       _GetADC+0
	POP        R2
	POP        R3
	STD        Y+7, R16
	STD        Y+8, R17
;execution.c,114 :: 		if( thumbstick.left_right <= 1  || thumbstick.left_right >= 2000 )
	LDI        R18, 1
	LDI        R19, 0
	CP         R18, R16
	CPC        R19, R17
	BRLO       L__execute_command72
	JMP        L__execute_command49
L__execute_command72:
	LDD        R16, Y+7
	LDD        R17, Y+8
	CPI        R17, 7
	BRNE       L__execute_command73
	CPI        R16, 208
L__execute_command73:
	BRLO       L__execute_command74
	JMP        L__execute_command48
L__execute_command74:
	JMP        L_execute_command13
L__execute_command49:
L__execute_command48:
;execution.c,115 :: 		PORTC |= 1 << 7;
	IN         R27, PORTC+0
	SBR        R27, 128
	OUT        PORTC+0, R27
L_execute_command13:
;execution.c,116 :: 		if( thumbstick.left_right <= 150 || thumbstick.left_right >= 2250 )
	LDD        R18, Y+7
	LDD        R19, Y+8
	LDI        R16, 150
	LDI        R17, 0
	CP         R16, R18
	CPC        R17, R19
	BRLO       L__execute_command75
	JMP        L__execute_command51
L__execute_command75:
	LDD        R16, Y+7
	LDD        R17, Y+8
	CPI        R17, 8
	BRNE       L__execute_command76
	CPI        R16, 202
L__execute_command76:
	BRLO       L__execute_command77
	JMP        L__execute_command50
L__execute_command77:
	JMP        L_execute_command16
L__execute_command51:
L__execute_command50:
;execution.c,117 :: 		PORTC |= 1 << 6;
	IN         R16, PORTC+0
	ORI        R16, 64
	OUT        PORTC+0, R16
L_execute_command16:
;execution.c,118 :: 		if( thumbstick.left_right <= 300 || thumbstick.left_right >= 2500 )
	LDD        R18, Y+7
	LDD        R19, Y+8
	LDI        R16, 44
	LDI        R17, 1
	CP         R16, R18
	CPC        R17, R19
	BRLO       L__execute_command78
	JMP        L__execute_command53
L__execute_command78:
	LDD        R16, Y+7
	LDD        R17, Y+8
	CPI        R17, 9
	BRNE       L__execute_command79
	CPI        R16, 196
L__execute_command79:
	BRLO       L__execute_command80
	JMP        L__execute_command52
L__execute_command80:
	JMP        L_execute_command19
L__execute_command53:
L__execute_command52:
;execution.c,119 :: 		PORTC |= 1 << 5;
	IN         R16, PORTC+0
	ORI        R16, 32
	OUT        PORTC+0, R16
L_execute_command19:
;execution.c,120 :: 		if( thumbstick.left_right <= 450 || thumbstick.left_right >= 2750 )
	LDD        R18, Y+7
	LDD        R19, Y+8
	LDI        R16, 194
	LDI        R17, 1
	CP         R16, R18
	CPC        R17, R19
	BRLO       L__execute_command81
	JMP        L__execute_command55
L__execute_command81:
	LDD        R16, Y+7
	LDD        R17, Y+8
	CPI        R17, 10
	BRNE       L__execute_command82
	CPI        R16, 190
L__execute_command82:
	BRLO       L__execute_command83
	JMP        L__execute_command54
L__execute_command83:
	JMP        L_execute_command22
L__execute_command55:
L__execute_command54:
;execution.c,121 :: 		PORTC |= 1 << 4;
	IN         R16, PORTC+0
	ORI        R16, 16
	OUT        PORTC+0, R16
L_execute_command22:
;execution.c,122 :: 		if( thumbstick.left_right <= 600 || thumbstick.left_right >= 3000 )
	LDD        R18, Y+7
	LDD        R19, Y+8
	LDI        R16, 88
	LDI        R17, 2
	CP         R16, R18
	CPC        R17, R19
	BRLO       L__execute_command84
	JMP        L__execute_command57
L__execute_command84:
	LDD        R16, Y+7
	LDD        R17, Y+8
	CPI        R17, 11
	BRNE       L__execute_command85
	CPI        R16, 184
L__execute_command85:
	BRLO       L__execute_command86
	JMP        L__execute_command56
L__execute_command86:
	JMP        L_execute_command25
L__execute_command57:
L__execute_command56:
;execution.c,123 :: 		PORTC |= 1 << 3;
	IN         R16, PORTC+0
	ORI        R16, 8
	OUT        PORTC+0, R16
L_execute_command25:
;execution.c,124 :: 		if( thumbstick.left_right <= 900 || thumbstick.left_right >= 3250 )
	LDD        R18, Y+7
	LDD        R19, Y+8
	LDI        R16, 132
	LDI        R17, 3
	CP         R16, R18
	CPC        R17, R19
	BRLO       L__execute_command87
	JMP        L__execute_command59
L__execute_command87:
	LDD        R16, Y+7
	LDD        R17, Y+8
	CPI        R17, 12
	BRNE       L__execute_command88
	CPI        R16, 178
L__execute_command88:
	BRLO       L__execute_command89
	JMP        L__execute_command58
L__execute_command89:
	JMP        L_execute_command28
L__execute_command59:
L__execute_command58:
;execution.c,125 :: 		PORTC |= 1 << 2;
	IN         R16, PORTC+0
	ORI        R16, 4
	OUT        PORTC+0, R16
L_execute_command28:
;execution.c,126 :: 		if( thumbstick.left_right <= 1200 || thumbstick.left_right >= 3500 )
	LDD        R18, Y+7
	LDD        R19, Y+8
	LDI        R16, 176
	LDI        R17, 4
	CP         R16, R18
	CPC        R17, R19
	BRLO       L__execute_command90
	JMP        L__execute_command61
L__execute_command90:
	LDD        R16, Y+7
	LDD        R17, Y+8
	CPI        R17, 13
	BRNE       L__execute_command91
	CPI        R16, 172
L__execute_command91:
	BRLO       L__execute_command92
	JMP        L__execute_command60
L__execute_command92:
	JMP        L_execute_command31
L__execute_command61:
L__execute_command60:
;execution.c,127 :: 		PORTC |= 1 << 1;
	IN         R16, PORTC+0
	ORI        R16, 2
	OUT        PORTC+0, R16
L_execute_command31:
;execution.c,128 :: 		if( thumbstick.left_right <= 1500 || thumbstick.left_right >= 4000 )
	LDD        R18, Y+7
	LDD        R19, Y+8
	LDI        R16, 220
	LDI        R17, 5
	CP         R16, R18
	CPC        R17, R19
	BRLO       L__execute_command93
	JMP        L__execute_command63
L__execute_command93:
	LDD        R16, Y+7
	LDD        R17, Y+8
	CPI        R17, 15
	BRNE       L__execute_command94
	CPI        R16, 160
L__execute_command94:
	BRLO       L__execute_command95
	JMP        L__execute_command62
L__execute_command95:
	JMP        L_execute_command34
L__execute_command63:
L__execute_command62:
;execution.c,129 :: 		PORTC |= 1 << 0;
	IN         R16, PORTC+0
	ORI        R16, 1
	OUT        PORTC+0, R16
L_execute_command34:
;execution.c,131 :: 		Delay_ms(30);
	LDI        R18, 2
	LDI        R17, 56
	LDI        R16, 174
L_execute_command35:
	DEC        R16
	BRNE       L_execute_command35
	DEC        R17
	BRNE       L_execute_command35
	DEC        R18
	BRNE       L_execute_command35
;execution.c,133 :: 		PORTC = 0x00;
	LDI        R27, 0
	OUT        PORTC+0, R27
;execution.c,135 :: 		if( Display_Button() )
	PUSH       R3
	PUSH       R2
	CALL       _Display_Button+0
	POP        R2
	POP        R3
	MOV        R27, R16
	OR         R27, R17
	BRNE       L__execute_command96
	JMP        L_execute_command37
L__execute_command96:
;execution.c,137 :: 		terminal_put_string("\r\n");
	LDI        R27, #lo_addr(?lstr4_execution+0)
	MOV        R2, R27
	LDI        R27, hi_addr(?lstr4_execution+0)
	MOV        R3, R27
	CALL       _terminal_put_string+0
;execution.c,138 :: 		break;
	JMP        L_execute_command10
;execution.c,139 :: 		}
L_execute_command37:
;execution.c,140 :: 		}
	JMP        L_execute_command9
L_execute_command10:
;execution.c,141 :: 		}
L_execute_command8:
;execution.c,143 :: 		break;
	JMP        L_execute_command1
;execution.c,144 :: 		case 'H':
L_execute_command38:
;execution.c,146 :: 		terminal_put_string("\r\n ***************************************");
	LDI        R27, #lo_addr(?lstr5_execution+0)
	MOV        R2, R27
	LDI        R27, hi_addr(?lstr5_execution+0)
	MOV        R3, R27
	CALL       _terminal_put_string+0
;execution.c,147 :: 		terminal_put_string("\r\n *                HELP                 *");
	LDI        R27, #lo_addr(?lstr6_execution+0)
	MOV        R2, R27
	LDI        R27, hi_addr(?lstr6_execution+0)
	MOV        R3, R27
	CALL       _terminal_put_string+0
;execution.c,148 :: 		terminal_put_string("\r\n * Command Requirements:               *");
	LDI        R27, #lo_addr(?lstr7_execution+0)
	MOV        R2, R27
	LDI        R27, hi_addr(?lstr7_execution+0)
	MOV        R3, R27
	CALL       _terminal_put_string+0
;execution.c,149 :: 		terminal_put_string("\r\n *   1. First character must be a      *");
	LDI        R27, #lo_addr(?lstr8_execution+0)
	MOV        R2, R27
	LDI        R27, hi_addr(?lstr8_execution+0)
	MOV        R3, R27
	CALL       _terminal_put_string+0
;execution.c,150 :: 		terminal_put_string("\r\n *   letter. (a,l,t,s...)              *");
	LDI        R27, #lo_addr(?lstr9_execution+0)
	MOV        R2, R27
	LDI        R27, hi_addr(?lstr9_execution+0)
	MOV        R3, R27
	CALL       _terminal_put_string+0
;execution.c,151 :: 		terminal_put_string("\r\n *   2. Command letter and arguments   *");
	LDI        R27, #lo_addr(?lstr10_execution+0)
	MOV        R2, R27
	LDI        R27, hi_addr(?lstr10_execution+0)
	MOV        R3, R27
	CALL       _terminal_put_string+0
;execution.c,152 :: 		terminal_put_string("\r\n *   must be seperated by a ':' (colon)*");
	LDI        R27, #lo_addr(?lstr11_execution+0)
	MOV        R2, R27
	LDI        R27, hi_addr(?lstr11_execution+0)
	MOV        R3, R27
	CALL       _terminal_put_string+0
;execution.c,153 :: 		terminal_put_string("\r\n *   3. Every command has different    *");
	LDI        R27, #lo_addr(?lstr12_execution+0)
	MOV        R2, R27
	LDI        R27, hi_addr(?lstr12_execution+0)
	MOV        R3, R27
	CALL       _terminal_put_string+0
;execution.c,154 :: 		terminal_put_string("\r\n *   parameters for arguments.         *");
	LDI        R27, #lo_addr(?lstr13_execution+0)
	MOV        R2, R27
	LDI        R27, hi_addr(?lstr13_execution+0)
	MOV        R3, R27
	CALL       _terminal_put_string+0
;execution.c,155 :: 		terminal_put_string("\r\n * -For help with specific commands:   *");
	LDI        R27, #lo_addr(?lstr14_execution+0)
	MOV        R2, R27
	LDI        R27, hi_addr(?lstr14_execution+0)
	MOV        R3, R27
	CALL       _terminal_put_string+0
;execution.c,157 :: 		terminal_put_string("\r\n * Sounds: s:[frequency],[time]        *");
	LDI        R27, #lo_addr(?lstr15_execution+0)
	MOV        R2, R27
	LDI        R27, hi_addr(?lstr15_execution+0)
	MOV        R3, R27
	CALL       _terminal_put_string+0
;execution.c,158 :: 		terminal_put_string("\r\n * Lights: l:[# of flashes],[delay]    *");
	LDI        R27, #lo_addr(?lstr16_execution+0)
	MOV        R2, R27
	LDI        R27, hi_addr(?lstr16_execution+0)
	MOV        R3, R27
	CALL       _terminal_put_string+0
;execution.c,159 :: 		terminal_put_string("\r\n * ADC:    a:[analog input pin]        *");
	LDI        R27, #lo_addr(?lstr17_execution+0)
	MOV        R2, R27
	LDI        R27, hi_addr(?lstr17_execution+0)
	MOV        R3, R27
	CALL       _terminal_put_string+0
;execution.c,160 :: 		terminal_put_string("\r\n * Thumb:  t:[0]                       *");
	LDI        R27, #lo_addr(?lstr18_execution+0)
	MOV        R2, R27
	LDI        R27, hi_addr(?lstr18_execution+0)
	MOV        R3, R27
	CALL       _terminal_put_string+0
;execution.c,161 :: 		terminal_put_string("\r\n *                                     *");
	LDI        R27, #lo_addr(?lstr19_execution+0)
	MOV        R2, R27
	LDI        R27, hi_addr(?lstr19_execution+0)
	MOV        R3, R27
	CALL       _terminal_put_string+0
;execution.c,162 :: 		terminal_put_string("\r\n ***************************************\r\n");
	LDI        R27, #lo_addr(?lstr20_execution+0)
	MOV        R2, R27
	LDI        R27, hi_addr(?lstr20_execution+0)
	MOV        R3, R27
	CALL       _terminal_put_string+0
;execution.c,164 :: 		break;
	JMP        L_execute_command1
;execution.c,165 :: 		default:
L_execute_command39:
;execution.c,167 :: 		terminal_put_string(" ERROR: not a valid command.");
	LDI        R27, #lo_addr(?lstr21_execution+0)
	MOV        R2, R27
	LDI        R27, hi_addr(?lstr21_execution+0)
	MOV        R3, R27
	CALL       _terminal_put_string+0
;execution.c,168 :: 		terminal_put_string("\n\r Type 'H:' for help. \n\r");
	LDI        R27, #lo_addr(?lstr22_execution+0)
	MOV        R2, R27
	LDI        R27, hi_addr(?lstr22_execution+0)
	MOV        R3, R27
	CALL       _terminal_put_string+0
;execution.c,169 :: 		terminal_put_string("\n\r");
	LDI        R27, #lo_addr(?lstr23_execution+0)
	MOV        R2, R27
	LDI        R27, hi_addr(?lstr23_execution+0)
	MOV        R3, R27
	CALL       _terminal_put_string+0
;execution.c,173 :: 		}
	JMP        L_execute_command1
L_execute_command0:
	LDD        R17, Y+11
	LDD        R18, Y+12
	MOV        R30, R17
	MOV        R31, R18
	LD         R16, Z
	CPI        R16, 115
	BRNE       L__execute_command97
	JMP        L_execute_command2
L__execute_command97:
	MOV        R30, R17
	MOV        R31, R18
	LD         R16, Z
	CPI        R16, 108
	BRNE       L__execute_command98
	JMP        L_execute_command3
L__execute_command98:
	MOV        R30, R17
	MOV        R31, R18
	LD         R16, Z
	CPI        R16, 97
	BRNE       L__execute_command99
	JMP        L_execute_command6
L__execute_command99:
	MOV        R30, R17
	MOV        R31, R18
	LD         R16, Z
	CPI        R16, 116
	BRNE       L__execute_command100
	JMP        L_execute_command7
L__execute_command100:
	MOV        R30, R17
	MOV        R31, R18
	LD         R16, Z
	CPI        R16, 72
	BRNE       L__execute_command101
	JMP        L_execute_command38
L__execute_command101:
	JMP        L_execute_command39
L_execute_command1:
;execution.c,174 :: 		}
L_end_execute_command:
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	ADIW       R28, 12
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	POP        R29
	POP        R28
	RET
; end of _execute_command

execution____?ag:

L_end_execution___?ag:
	RET
; end of execution____?ag
