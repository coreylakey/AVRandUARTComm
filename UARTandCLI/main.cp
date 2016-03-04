#line 1 "H:/2014-Winter/CS 161/TurninCLI/TurninCLI/main.c"
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
#line 1 "h:/2014-winter/cs 161/turnincli/turnincli/command_parser.h"
#line 1 "c:/users/public/documents/mikroelektronika/mikroc pro for avr/include/stdint.h"
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
#line 1 "h:/2014-winter/cs 161/turnincli/turnincli/execution.h"
#line 1 "h:/2014-winter/cs 161/turnincli/turnincli/command_parser.h"
#line 8 "h:/2014-winter/cs 161/turnincli/turnincli/execution.h"
void execute_command( command_t* execute_behavior );
#line 10 "H:/2014-Winter/CS 161/TurninCLI/TurninCLI/main.c"
typedef struct {
 char buffer[ 100 ];
 uint8_t index;
} uart_buffer_t;

volatile uart_buffer_t rx_buffer;
volatile uint8_t rx_flag;


void system_init( void );


void main()
{
 command_t my_command;

 system_init();
 terminal_put_string( "Enter a Command\r\n" );

 while( 1 )
 {
 if( rx_flag == 1 )
 {

 if( command_parse( rx_buffer.buffer, &my_command ) == COMMAND_VALID )
 {
 execute_command( &my_command );
 }
 if( command_parse( rx_buffer.buffer, &my_command ) == COMMAND_INVALID )
 {
 terminal_put_string(" ERROR: not a valid command.");
 terminal_put_string("\n\r Type 'H:' for help. \n\r");
 }

 terminal_put_string( "Enter a Command\r\n" );
 rx_buffer.index = 0;
 rx_flag = 0;
 }
#line 54 "H:/2014-Winter/CS 161/TurninCLI/TurninCLI/main.c"
 asm sleep;
 }
}




void system_init()
{
 terminal_init( 38400 );
#line 69 "H:/2014-Winter/CS 161/TurninCLI/TurninCLI/main.c"
 UCSRB |= ( 1 << RXCIE );
 asm sei;

 Delay_ms( 100 );

 Sound_Init( &PORTD,4 );
 DDRA = 0xff;
}
#line 82 "H:/2014-Winter/CS 161/TurninCLI/TurninCLI/main.c"
void rxc_isr() iv IVT_ADDR_USART__RXC ics ICS_AUTO
{
 char tmp_char = UDR;

 if( tmp_char == '\n' || rx_buffer.index ==  100  - 1 )
 {
 rx_flag = 1;
 rx_buffer.buffer[rx_buffer.index] = '\0';
 rx_buffer.index = 0;
 }
 else
 {
 rx_buffer.buffer[rx_buffer.index++] = tmp_char;
 }

}
