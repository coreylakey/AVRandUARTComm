#include "execution.h"
#include "terminal.h"
#include "thumbstick.h"
#include "help.h"
#include <built_in.h>


void execute_command( command_t* execute_behavior )
{
    int changed;
    direction thumbstick;
    

    switch( execute_behavior->command )
    {
         case 's':
              Sound_Play( execute_behavior->commands[0], execute_behavior->commands[1] );
              
             /*if( execute_behavior->commands[0] == 'h' )
             {
                 terminal_put_string("\r\n ***************************************");
                 terminal_put_string("\r\n *            Sounds HELP              *");
                 terminal_put_string("\r\n *   SYNOPSIS: s: [frequency],[time]   *");
                 terminal_put_string("\r\n *   DESCRIPTION: The sound command    *");
                 terminal_put_string("\r\n * plays a sounds for the frequency    *");
                 terminal_put_string("\r\n * you provide, for the ammount of time*");
                 terminal_put_string("\r\n * that you provide.                   *");
                 terminal_put_string("\r\n ***************************************");
                 
                 break;
             } */





         break;
         case 'l':

             /*if( execute_behavior->commands[0] == 'h' )
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

                 break;
             } */

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
             /*if( execute_behavior->commands[0] == 'h' )
             {
                 terminal_put_string("\r\n ***************************************");
                 terminal_put_string("\r\n *              ADC HELP               *");
                 terminal_put_string("\r\n *   SYNOPSIS: a: [analog input jumper]*");
                 terminal_put_string("\r\n *   DESCRIPTION: The ADC command      *");
                 terminal_put_string("\r\n * displays the ADC value at the       *");
                 terminal_put_string("\r\n * provided analog input port.         *");
                 terminal_put_string("\r\n ***************************************");

                 break;
             }  */

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
              //terminal_put_string("\r\n and got past ledplay! ");
              DDRC = 0xFF;
               while(1)
               {
                       thumbstick.left_right = GetADC(1);
               
               
                       if( thumbstick.left_right <= 1  || thumbstick.left_right >= 2000 )
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
         // terminal_put_string("\r\n *   enter: [command letter] : h       *");     *  used to have functions to have easy to read help menu, but not enough ram.  *
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




