/**
*  @file thumbstick.h
*
*  @brief This library moves the LED lights on PORTA left and right with the thumbstick.
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



#ifndef _THUMBSTICK_H
#define _THUMBSTICK_H
 /**
 *  @struct Holds ADC values from thumbstick.
 *
 */
typedef struct{
            unsigned int left_right;
            unsigned int old_left_right;
} direction;
 /**
 *  @brief Gets ADC Value
 *
 *  @param unsigned short - choose between vertical or horizontal channel on thumbstick.
 *
 *  @return unsigned int - ADC value on channel sent.
 *
 */
unsigned int GetADC(unsigned short channel);
/**
 *  @brief Checks if the thumbstick button is pushed
 *
 *  @return int - 1 means its pushed. 0 means it isn't
 *
 */
int Display_Button();
/**
 *  @brief Sets up pins for output / initializes ADC for thumbstick.
 *
 */
void led_play();










#endif