
_GetADC:

;thumbstick.c,26 :: 		unsigned int GetADC(unsigned short channel)     // Returns 0..4095
;thumbstick.c,29 :: 		Chip_Select = 0;                               // Select MCP3204
	PUSH       R2
	IN         R27, PORTA5_bit+0
	CBR        R27, BitMask(PORTA5_bit+0)
	OUT        PORTA5_bit+0, R27
;thumbstick.c,30 :: 		SPI1_Write(0x06);                              // SPI communication using 8-bit segments
	PUSH       R2
	LDI        R27, 6
	MOV        R2, R27
	CALL       _SPI1_Write+0
	POP        R2
;thumbstick.c,31 :: 		channel = channel << 6;                        // Bits 7 & 6 define ADC input
	LDI        R27, 6
	MOV        R16, R2
L__GetADC4:
	LSL        R16
	DEC        R27
	BRNE       L__GetADC4
L__GetADC5:
	MOV        R2, R16
;thumbstick.c,32 :: 		tmp = SPI1_Read(channel) & 0x0F;               // Get first 8 bits of ADC value
	MOV        R2, R16
	CALL       _SPI1_Read+0
	ANDI       R16, 15
; tmp start address is: 18 (R18)
	MOV        R18, R16
	LDI        R19, 0
;thumbstick.c,33 :: 		tmp = tmp << 8;                                // Shift ADC value by 8
	MOV        R17, R18
	CLR        R16
	MOVW       R18, R16
;thumbstick.c,34 :: 		tmp = tmp | SPI1_Read(0);                      // Get remaining 4 bits of ADC value
	CLR        R2
	CALL       _SPI1_Read+0
	LDI        R17, 0
	OR         R16, R18
	OR         R17, R19
; tmp end address is: 18 (R18)
;thumbstick.c,36 :: 		Chip_Select= 1;                                // Deselect MCP3204
	IN         R27, PORTA5_bit+0
	SBR        R27, BitMask(PORTA5_bit+0)
	OUT        PORTA5_bit+0, R27
;thumbstick.c,37 :: 		return tmp;                                    // Returns 12-bit ADC value
;thumbstick.c,38 :: 		}
;thumbstick.c,37 :: 		return tmp;                                    // Returns 12-bit ADC value
;thumbstick.c,38 :: 		}
L_end_GetADC:
	POP        R2
	RET
; end of _GetADC

_Display_Button:

;thumbstick.c,40 :: 		int Display_Button()
;thumbstick.c,42 :: 		if (Button  == 0)
	IN         R27, PIND2_bit+0
	SBRC       R27, BitPos(PIND2_bit+0)
	JMP        L_Display_Button0
;thumbstick.c,44 :: 		return 1;
	LDI        R16, 1
	LDI        R17, 0
	JMP        L_end_Display_Button
;thumbstick.c,45 :: 		}
L_Display_Button0:
;thumbstick.c,46 :: 		return 0;
	LDI        R16, 0
	LDI        R17, 0
;thumbstick.c,47 :: 		}
L_end_Display_Button:
	RET
; end of _Display_Button

_led_play:

;thumbstick.c,51 :: 		void led_play()
;thumbstick.c,57 :: 		Chip_Select_Direction = 1;
	PUSH       R2
	IN         R27, DDA5_bit+0
	SBR        R27, BitMask(DDA5_bit+0)
	OUT        DDA5_bit+0, R27
;thumbstick.c,58 :: 		Test_Direction = 1;
	IN         R27, DDB0_bit+0
	SBR        R27, BitMask(DDB0_bit+0)
	OUT        DDB0_bit+0, R27
;thumbstick.c,59 :: 		Button_Direction = 0;
	IN         R27, DDD2_bit+0
	CBR        R27, BitMask(DDD2_bit+0)
	OUT        DDD2_bit+0, R27
;thumbstick.c,61 :: 		SPI1_Init();
	CALL       _SPI1_Init+0
;thumbstick.c,62 :: 		Delay_ms(500);
	LDI        R18, 21
	LDI        R17, 75
	LDI        R16, 191
L_led_play1:
	DEC        R16
	BRNE       L_led_play1
	DEC        R17
	BRNE       L_led_play1
	DEC        R18
	BRNE       L_led_play1
	NOP
;thumbstick.c,65 :: 		middle_left_right = GetADC(1);
	LDI        R27, 1
	MOV        R2, R27
	CALL       _GetADC+0
	STS        _middle_left_right+0, R16
	STS        _middle_left_right+1, R17
;thumbstick.c,73 :: 		}
L_end_led_play:
	POP        R2
	RET
; end of _led_play

thumbstick____?ag:

L_end_thumbstick___?ag:
	RET
; end of thumbstick____?ag
