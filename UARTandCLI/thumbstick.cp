#line 1 "H:/2014-Winter/CS 161/TurninCLI/TurninCLI/thumbstick.c"
#line 1 "h:/2014-winter/cs 161/turnincli/turnincli/thumbstick.h"
#line 26 "h:/2014-winter/cs 161/turnincli/turnincli/thumbstick.h"
typedef struct{
 unsigned int left_right;
 unsigned int old_left_right;
} direction;
#line 38 "h:/2014-winter/cs 161/turnincli/turnincli/thumbstick.h"
unsigned int GetADC(unsigned short channel);
#line 45 "h:/2014-winter/cs 161/turnincli/turnincli/thumbstick.h"
int Display_Button();
#line 50 "h:/2014-winter/cs 161/turnincli/turnincli/thumbstick.h"
void led_play();
#line 1 "h:/2014-winter/cs 161/turnincli/turnincli/terminal.h"
#line 1 "c:/users/public/documents/mikroelektronika/mikroc pro for avr/include/stdint.h"




typedef signed char int8_t;
typedef signed int int16_t;
typedef signed long int int32_t;


typedef unsigned char uint8_t;
typedef unsigned int uint16_t;
typedef unsigned long int uint32_t;


typedef signed char int_least8_t;
typedef signed int int_least16_t;
typedef signed long int int_least32_t;


typedef unsigned char uint_least8_t;
typedef unsigned int uint_least16_t;
typedef unsigned long int uint_least32_t;



typedef signed char int_fast8_t;
typedef signed int int_fast16_t;
typedef signed long int int_fast32_t;


typedef unsigned char uint_fast8_t;
typedef unsigned int uint_fast16_t;
typedef unsigned long int uint_fast32_t;


typedef signed int intptr_t;
typedef unsigned int uintptr_t;


typedef signed long int intmax_t;
typedef unsigned long int uintmax_t;
#line 39 "h:/2014-winter/cs 161/turnincli/turnincli/terminal.h"
void terminal_init( uint16_t baud );
#line 49 "h:/2014-winter/cs 161/turnincli/turnincli/terminal.h"
void terminal_putc( unsigned char c );
#line 57 "h:/2014-winter/cs 161/turnincli/turnincli/terminal.h"
void terminal_put_string( unsigned char* s );
#line 68 "h:/2014-winter/cs 161/turnincli/turnincli/terminal.h"
uint8_t terminal_has_data( void );
#line 79 "h:/2014-winter/cs 161/turnincli/turnincli/terminal.h"
unsigned char terminal_getc( void );
#line 7 "H:/2014-Winter/CS 161/TurninCLI/TurninCLI/thumbstick.c"
sbit Chip_Select at PORTA5_bit;
sbit Test at PORTB0_bit;
sbit Button at PIND2_bit;
sbit Chip_Select_Direction at DDA5_bit;
sbit Test_Direction at DDB0_bit;
sbit Button_Direction at DDD2_bit;

unsigned int middle_left_right;
#line 26 "H:/2014-Winter/CS 161/TurninCLI/TurninCLI/thumbstick.c"
unsigned int GetADC(unsigned short channel)
{
 unsigned int tmp;
 Chip_Select = 0;
 SPI1_Write(0x06);
 channel = channel << 6;
 tmp = SPI1_Read(channel) & 0x0F;
 tmp = tmp << 8;
 tmp = tmp | SPI1_Read(0);

 Chip_Select= 1;
 return tmp;
}

int Display_Button()
{
if (Button == 0)
 {
 return 1;
 }
 return 0;
}



void led_play()
{




 Chip_Select_Direction = 1;
 Test_Direction = 1;
 Button_Direction = 0;

 SPI1_Init();
 Delay_ms(500);


 middle_left_right = GetADC(1);
#line 73 "H:/2014-Winter/CS 161/TurninCLI/TurninCLI/thumbstick.c"
}
