#line 1 "H:/2014-Winter/CS 161/TurninCLI/TurninCLI/command_parser.c"
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
#line 1 "c:/users/public/documents/mikroelektronika/mikroc pro for avr/include/stddef.h"



typedef int ptrdiff_t;
typedef unsigned int size_t;
typedef unsigned int wchar_t;
#line 4 "H:/2014-Winter/CS 161/TurninCLI/TurninCLI/command_parser.c"
command_status_t command_parse( char* process_str, command_t* process )
{
 char *p_tmp =  ((void *)0) ;
 int i = 0;

 if( !isalpha( process_str[0] ) || !strchr( process_str, ':' ) )
 {
 return COMMAND_INVALID;
 }

 process->command = process_str[0];

 p_tmp = strtok( &process_str[2], "," );

 while( p_tmp !=  ((void *)0)  && i < 3 )
 {
 process->commands[i++] = atoi( p_tmp );
 p_tmp = strtok( 0, "," );
 }

 return COMMAND_VALID;
}
