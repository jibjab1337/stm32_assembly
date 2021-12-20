#include "stm32l476xx.h"

int main(void){
	
	// Enable High Speed Internal Clock (HSI = 16 MHz)
  RCC->CR |= ((uint32_t)RCC_CR_HSION);
	
  // wait until HSI is ready
  while ( (RCC->CR & (uint32_t) RCC_CR_HSIRDY) == 0 ) {;}
	
  // Select HSI as system clock source 
  RCC->CFGR &= (uint32_t)((uint32_t)~(RCC_CFGR_SW));
  RCC->CFGR |= (uint32_t)RCC_CFGR_SW_HSI;  //01: HSI16 oscillator used as system clock

  // Wait till HSI is used as system clock source 
  while ((RCC->CFGR & (uint32_t)RCC_CFGR_SWS) == 0 ) {;}
  
  // Enable the clock to GPIO Port E --> GPIO Port E Enable	
  RCC->AHB2ENR |= RCC_AHB2ENR_GPIOEEN;   

		
		
	// Lab 7	
	// Assignment 7.1 - Lab 7.1: Turn on the Green LED (PE8)	
		
		
		
		
	// MODE: 00: Input mode, 01: General purpose output mode
  //       10: Alternate function mode, 11: Analog mode (reset state)	
	// GPIOE->MODER &= ~(0x03<<(2*6)) ;   // Clear bit 13 and bit 12
		
	GPIOE->MODER &= ~(3UL<<16); 		   // Clear bit 16 and bit 17 with NOT mask of 0x03 = 0b11 = 3UL because that is location for Pin 8 which controls green LED
	GPIOE->MODER |= (1UL<<16);			   // set mode to output by moving 0x01 = 0b01 = 1UL to bit 16 --> (17,16) = 01 = General purpose output mode
	
		
	GPIOE->OTYPER &= ~(1UL<<8);			   // select push pull output by clearing bit 8 of OTYPE register using a NOT bit mask with 0x01 = 0b01 = 1UL
																		 // for OTYPE, there are 16 bits with bit 1 representing pin 1, bit 2 representing pin 2 etc
																		 // so for green LED, we look at pin 8, therefore we clear bit 8 with a NOT mask of NOT(0x01)
		
	GPIOE->ODR	|=	1UL<<8;						 // set output = 1 on pin 8 of ODR to turn on green LED by shifting 0x01 = 0b01 = 1UL to bit 8
																		 // ODR pins follow same logic as OTYPE pins so bit 8 of ODR controls pin 8 which turns on green LED
	GPIOB->ODR |= GPIO_ODR_ODR_2;
  // Dead loop & program hangs here
	while(1);
}
