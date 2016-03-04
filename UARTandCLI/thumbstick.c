#include "thumbstick.h"
#include "terminal.h"



// Thumbstick click module connections
sbit Chip_Select           at PORTA5_bit;
sbit Test                  at PORTB0_bit;
sbit Button                at PIND2_bit;
sbit Chip_Select_Direction at DDA5_bit;
sbit Test_Direction        at DDB0_bit;
sbit Button_Direction      at DDD2_bit;

unsigned int middle_left_right;


/*void interrupt_ISR () org IVT_ADDR_INT0
{

}
*/



// Get ADC values
unsigned int GetADC(unsigned short channel)     // Returns 0..4095
{
  unsigned int tmp;
  Chip_Select = 0;                               // Select MCP3204
  SPI1_Write(0x06);                              // SPI communication using 8-bit segments
  channel = channel << 6;                        // Bits 7 & 6 define ADC input
  tmp = SPI1_Read(channel) & 0x0F;               // Get first 8 bits of ADC value
  tmp = tmp << 8;                                // Shift ADC value by 8
  tmp = tmp | SPI1_Read(0);                      // Get remaining 4 bits of ADC value
                                                 // and form 12-bit ADC value
  Chip_Select= 1;                                // Deselect MCP3204
  return tmp;                                    // Returns 12-bit ADC value
}

int Display_Button()
{
if (Button  == 0) 
       {
         return 1;
       }
     return 0;
}



void led_play()
{



   // Set Chip Select pin as Output
  Chip_Select_Direction = 1;
  Test_Direction = 1;
  Button_Direction = 0;

  SPI1_Init();
  Delay_ms(500);

  //Set middle value
  middle_left_right = GetADC(1);

  /*GICR = 0x40;                                       // Set the Interrupts
  ISC01_bit = 1;
  ISC00_bit = 1;
  SREG_I_bit = 1;                                    // Enable Interrupts
  */

}

