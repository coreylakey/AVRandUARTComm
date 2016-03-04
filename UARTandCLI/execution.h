/**
*  @file execution.h
*
*  @brief This file holds the functions to execute the code after being parsed by the command_parser.
*
*  @author Corey Lakey
*
*  @date 2/14/2015
*
*
*  @note
*     - Set J12 and J23 jumpers on EasyPIC7 board on right for USB UART.
*     - Turn on SW10.1 and SW10.2 (USB UART).
*     - Turn on SW5.4, SW5.5 and SW5.6 (SPI).
*
*/
#ifndef _EXECUTION_H
#define _EXECUTION_H

#include "command_parser.h"


void execute_command( command_t* execute_behavior );

#endif