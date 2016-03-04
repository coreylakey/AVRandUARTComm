#line 1 "H:/2014-Winter/CS 161/TurninCLI/TurninCLI/execution.c"
#line 1 "h:/2014-winter/cs 161/turnincli/turnincli/execution.h"
#line 1 "h:/2014-winter/cs 161/turnincli/turnincli/command_parser.h"
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
#line 34 "h:/2014-winter/cs 161/turnincli/turnincli/command_parser.h"
typedef struct
{
 char command;
 uint16_t commands[3];
} command_t;
#line 43 "h:/2014-winter/cs 161/turnincli/turnincli/command_parser.h"
typedef enum
{
 COMMAND_INVALID = 0,
 COMMAND_VALID,
 COMMAND_NOT_FOUND
} command_status_t;
#line 62 "h:/2014-winter/cs 161/turnincli/turnincli/command_parser.h"
command_status_t command_parse( char* process_str, command_t* process );
#line 8 "h:/2014-winter/cs 161/turnincli/turnincli/execution.h"
void execute_command( command_t* execute_behavior );
#line 1 "h:/2014-winter/cs 161/turnincli/turnincli/terminal.h"
#line 1 "c:/users/public/documents/mikroelektronika/mikroc pro for avr/include/stdint.h"
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
#line 1 "h:/2014-winter/cs 161/turnincli/turnincli/help.h"
#line 1 "c:/users/public/documents/mikroelektronika/mikroc pro for avr/include/built_in.h"
#line 8 "H:/2014-Winter/CS 161/TurninCLI/TurninCLI/execution.c"
void execute_command( command_t* execute_behavior )
{
 int changed;
 direction thumbstick;


 switch( execute_behavior->command )
 {
 case 's':
 Sound_Play( execute_behavior->commands[0], execute_behavior->commands[1] );
#line 37 "H:/2014-Winter/CS 161/TurninCLI/TurninCLI/execution.c"
 break;
 case 'l':
#line 56 "H:/2014-Winter/CS 161/TurninCLI/TurninCLI/execution.c"
 while( execute_behavior->commands[0] )
 {
 terminal_put_string( "Lights\r\n" );
 PORTA ^= 0xff;
 VDelay_ms( execute_behavior->commands[1] );
 PORTA ^= 0xff;
 VDelay_ms(execute_behavior->commands[1] );
 execute_behavior->commands[0]--;
 }



 break;
 case 'a':
 {
 int adc_value;
 char tmp_txt[7];
#line 86 "H:/2014-Winter/CS 161/TurninCLI/TurninCLI/execution.c"
 DDRA &= ~( 1 << execute_behavior->commands[0] );
 ADC_Init();

 adc_value = ADC_Read( execute_behavior->commands[0] );
 DDRA |= ( 1 << execute_behavior->commands[0] );

 IntToStr( adc_value, tmp_txt );

 terminal_put_string( Ltrim( tmp_txt ) );
 terminal_put_string( "\r\n" );



 }
 break;
 case 't':
 {
 if( execute_behavior->commands[0] == 0 )
 {
 terminal_put_string("\r\n Press Button to excape. \r\n");
 led_play();

 DDRC = 0xFF;
 while(1)
 {
 thumbstick.left_right = GetADC(1);


 if( thumbstick.left_right <= 1 || thumbstick.left_right >= 2000 )
 PORTC |= 1 << 7;
 if( thumbstick.left_right <= 150 || thumbstick.left_right >= 2250 )
 PORTC |= 1 << 6;
 if( thumbstick.left_right <= 300 || thumbstick.left_right >= 2500 )
 PORTC |= 1 << 5;
 if( thumbstick.left_right <= 450 || thumbstick.left_right >= 2750 )
 PORTC |= 1 << 4;
 if( thumbstick.left_right <= 600 || thumbstick.left_right >= 3000 )
 PORTC |= 1 << 3;
 if( thumbstick.left_right <= 900 || thumbstick.left_right >= 3250 )
 PORTC |= 1 << 2;
 if( thumbstick.left_right <= 1200 || thumbstick.left_right >= 3500 )
 PORTC |= 1 << 1;
 if( thumbstick.left_right <= 1500 || thumbstick.left_right >= 4000 )
 PORTC |= 1 << 0;

 Delay_ms(30);

 PORTC = 0x00;

 if( Display_Button() )
 {
 terminal_put_string("\r\n");
 break;
 }
 }
 }
 }
 break;
 case 'H':
 {
 terminal_put_string("\r\n ***************************************");
 terminal_put_string("\r\n *                HELP                 *");
 terminal_put_string("\r\n * Command Requirements:               *");
 terminal_put_string("\r\n *   1. First character must be a      *");
 terminal_put_string("\r\n *   letter. (a,l,t,s...)              *");
 terminal_put_string("\r\n *   2. Command letter and arguments   *");
 terminal_put_string("\r\n *   must be seperated by a ':' (colon)*");
 terminal_put_string("\r\n *   3. Every command has different    *");
 terminal_put_string("\r\n *   parameters for arguments.         *");
 terminal_put_string("\r\n * -For help with specific commands:   *");

 terminal_put_string("\r\n * Sounds: s:[frequency],[time]        *");
 terminal_put_string("\r\n * Lights: l:[# of flashes],[delay]    *");
 terminal_put_string("\r\n * ADC:    a:[analog input pin]        *");
 terminal_put_string("\r\n * Thumb:  t:[0]                       *");
 terminal_put_string("\r\n *                                     *");
 terminal_put_string("\r\n ***************************************\r\n");
 }
 break;
 default:
 {
 terminal_put_string(" ERROR: not a valid command.");
 terminal_put_string("\n\r Type 'H:' for help. \n\r");
 terminal_put_string("\n\r");

 }

 }
}
