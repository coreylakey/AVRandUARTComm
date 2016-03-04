#include "terminal.h"
#include "help.h"

/*void lights_help()
{
                 terminal_put_string("\r\n ***************************************");
                 terminal_put_string("\r\n *             Lights HELP             *");
                 terminal_put_string("\r\n *   SYNOPSIS: l: [# of flashes],[time]*");
                 terminal_put_string("\r\n *   DESCRIPTION: The lights command   *");
                 terminal_put_string("\r\n * flashes the leds on Port A for the  *");
                 terminal_put_string("\r\n * amount of time you provide in the   *");
                 terminal_put_string("\r\n * second argument, and the amount of  *");
                 terminal_put_string("\r\n * times that you supply in the first  *");
                 terminal_put_string("\r\n * argument.                           *");
                 terminal_put_string("\r\n ***************************************");
}

void sound_help()
{
                 terminal_put_string("\r\n ***************************************");
                 terminal_put_string("\r\n *            Sounds HELP              *");
                 terminal_put_string("\r\n *   SYNOPSIS: s: [frequency],[time]   *");
                 terminal_put_string("\r\n *   DESCRIPTION: The sound command    *");
                 terminal_put_string("\r\n * plays a sounds for the frequency    *");
                 terminal_put_string("\r\n * you provide, for the ammount of time*");
                 terminal_put_string("\r\n * that you provide.                   *");
                 terminal_put_string("\r\n ***************************************");
                 
}

void thumb_help()
{
                 terminal_put_string("\r\n ***************************************");
                 terminal_put_string("\r\n *            Thumbstick HELP          *");
                 terminal_put_string("\r\n *   SYNOPSIS: t:0                     *");
                 terminal_put_string("\r\n *   DESCRIPTION: The thumbstick       *");
                 terminal_put_string("\r\n * command allows you to control the   *");
                 terminal_put_string("\r\n * leds on Port C with a thumbstick    *");
                 terminal_put_string("\r\n * until the thumbstick click is       *");
                 terminal_put_string("\r\n * pressed down.                       *");
                 terminal_put_string("\r\n ***************************************");
}

void adc_help()
{
                 terminal_put_string("\r\n ***************************************");
                 terminal_put_string("\r\n *              ADC HELP               *");
                 terminal_put_string("\r\n *   SYNOPSIS: a: [analog input jumper]*");
                 terminal_put_string("\r\n *   DESCRIPTION: The ADC command      *");
                 terminal_put_string("\r\n * displays the ADC value at the       *");
                 terminal_put_string("\r\n * provided analog input port.         *");
                 terminal_put_string("\r\n ***************************************");
}


void help_menu()
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
          terminal_put_string("\r\n *   enter: [command letter] : h       *");
          terminal_put_string("\r\n ***************************************");
}

void error_message()
{
          terminal_put_string(" ERROR: not a valid command.");
          terminal_put_string("\n\r Type 'H:' for help. \n\r");
}
*/