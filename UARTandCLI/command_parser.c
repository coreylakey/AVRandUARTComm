#include "command_parser.h"
#include <stddef.h>
/**
*
*     @brief Processes parsed command from USART.

*
*/
command_status_t command_parse( char* process_str, command_t* process )
{
    char *p_tmp = NULL;
    int i = 0;
    
    if( !isalpha( process_str[0] ) || !strchr( process_str, ':' ) )             // if first letter from parsed USART input is a character followed by a ':'
    {
        return COMMAND_INVALID;                                                 // the command is valid, enum value = 1
    }
    
    process->command = process_str[0];
    
    p_tmp = strtok( &process_str[2], "," );
    
    while( p_tmp != NULL && i < 3 )
    {
        process->commands[i++] = atoi( p_tmp );
        p_tmp = strtok( 0, "," );
    }

   return COMMAND_VALID;                                                        // returns enum value = 0
}