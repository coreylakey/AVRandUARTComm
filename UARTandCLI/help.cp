#line 1 "H:/2014-Winter/CS 161/TurninCLI/TurninCLI/help.c"
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
#line 1 "h:/2014-winter/cs 161/turnincli/turnincli/help.h"
