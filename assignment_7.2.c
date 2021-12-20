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
  
  // Enable the clock to "all" GPIO Port you used
				// Enable the clock to GPIO Port A --> GPIO Port A Enable	
  RCC->AHB2ENR |= RCC_AHB2ENR_GPIOAEN;		
				// Enable the clock to GPIO Port B --> GPIO Port B Enable	
  RCC->AHB2ENR |= RCC_AHB2ENR_GPIOBEN;
				// Enable the clock to GPIO Port E --> GPIO Port E Enable	
  RCC->AHB2ENR |= RCC_AHB2ENR_GPIOEEN;  
		
	// Clear first, then select the mode in MODER, do this for all the outputs	// MODER has 32 bits 0 to 31 or 2 bits per pin i.e pin 2 --> bit 5 bit 4
				// MODE: 00: Input mode, 							01: General purpose output mode
				//       10: Alternate function mode, 11: Analog mode (reset state)
	GPIOA->MODER &= ~(3UL);       		 // e.g. Clear pin 0	--> setting mode of all GPIOA pins to Not(0b11) or 0b00 sets the inputs to "input mode"
	GPIOA->MODER &= ~(3UL<<(2));       // e.g. Clear pin 1	
	GPIOA->MODER &= ~(3UL<<(4));       // e.g. Clear pin 2	
	GPIOA->MODER &= ~(3UL<<(6));       // e.g. Clear pin 3	
	GPIOA->MODER &= ~(3UL<<(10));      // e.g. Clear pin 5	
		
  GPIOB->MODER &= ~(3UL<<(4));       // e.g. Clear bit 4 and bit 5			
  GPIOE->MODER &= ~(3UL<<(16));      // e.g. Clear bit 16 and bit 17
  GPIOB->MODER |= (1UL<<4);					 // set mode of GPIOB to output by shifting 0x01 = 0b01 to bit 4 and 5 which is pin 2
  GPIOE->MODER |= (1UL<<16);				 // set mode of GPIOE to output by shifting 0x01 = 0b01 to bit 16 and 17 which is pin 8
		
	// Clear first, then select the output type in OTYPER, do this for all the outputs	// OTYPER has 16 bits 0 to 15 or 1 bit per pin i.e pin 0 --> bit 0
  GPIOB->OTYPER &= ~(3UL<<(2));      // e.g. Clear bit 2 by shifting NOT(0b11) = 0b00 to bit 2			
  GPIOE->OTYPER &= ~(3UL<<(8));      // e.g. Clear bit 8 by shifting NOT(0b11) = 0b00 to bit 8	
	GPIOB->OTYPER |= ~(1UL<<2);			   // select push pull output by shifting NOT 0x01 = 0b10 to bit 2
	GPIOE->OTYPER |= ~(1UL<<8);			   // select push pull output by shifting NOT 0x01 = 0b10 to bit 8
		
	// Use the PUPDR to select pull-down for every button of the joystick except the center button	// pull-down is 10 = 0b10 = 0x02	// PUPDR has 32 bits | 2 bit per pin
	GPIOA->PUPDR |=  (0x02<<(2));	  // Pin 1																												// NOT(1UL) = NOT(0b01) = 0b10 = 0x02  	GPIOA->PUPDR &= ~(1UL<<(2));
	GPIOA->PUPDR |=  (0x02<<(4));	  // Pin 2
	GPIOA->PUPDR |=  (0x02<<(6));	  // Pin 3
	GPIOA->PUPDR |=  (0x02<<(10));	// Pin 5
	
	// begin main loop
  while(1){  
		// Toggle both LEDs when middle button is pushed    // middle button is controlled by bit 0 in the IDR or Input Data Register - IDR has 16 bits 0 to 15 | 1 bit per pin
		if((GPIOA->IDR & 1UL) != 0x00){                 		// Shift 0b01 or 1UL in place or just type 1UL    
			GPIOE->ODR ^= GPIO_ODR_ODR_8;
			GPIOB->ODR ^= GPIO_ODR_ODR_2;
			while((GPIOA->IDR & 1UL) != 0x00);
		}	
		// Toggle red LED when right button is pushed		    // right button is controlled by bit 2 in the IDR
		if((GPIOA->IDR & (1UL<<2)) != 0x00){								// Shift 0b01 or 1UL by 2 bits so that the 1 is on bit 2
			GPIOB->ODR ^= GPIO_ODR_ODR_2;
			while((GPIOA->IDR & (1UL<<2)) != 0x00);
		}			
		// Toggle green LED when left button is pushed	    // left button is controlled by bit 1 in the IDR
		if((GPIOA->IDR & (1UL<<1)) != 0x00){ 								// Shift 0b01 or 1UL by 1 bit so that the 1 is on bit 1
			GPIOE->ODR ^= GPIO_ODR_ODR_8;		
			while((GPIOA->IDR & (1UL<<1)) != 0x00);
		}		
		// Set both LEDs to on when up button is pushed	    // up button is controlled by bit 3 in the IDR
		if((GPIOA->IDR & (1UL<<3)) != 0x00){ 								// Shift 0b01 or 1UL by 3 bits so that the 1 is on bit 3
			GPIOE->ODR |=	1UL<<8;					// set output = 1 on pin 8 of ODR to turn ON green LED by shifting 0x01 = 0b01 = 1UL to bit 8																				
			GPIOB->ODR |= 1UL<<2;					// set output = 1 on pin 2 of ODR to turn ON red LED by shifting 0x01 = 0b01 = 1UL to bit 2
			while((GPIOA->IDR & (1UL<<3)) != 0x00);
		}				
		// Set both LEDs to off when down button is pushed	// right button is controlled by bit 5 in the IDR --> IDR AND (0x20 = 100000 = 1UL<<5) 
		if((GPIOA->IDR & (1UL<<5)) != 0x00){ 								// Shift 0b01 or 1UL by 5 bits so that the 1 is on bit 5
			GPIOE->ODR &=	~(3UL<<8);			// set output = 0 on pin 8 of ODR to turn OFF green LED by shifting 0x00 = 0b00 to bit 8																		 
			GPIOB->ODR &= ~(3UL<<2);		  // set output = 0 on pin 2 of ODR to turn OFF red LED by shifting 0x00 = 0b00 to bit 2	
			while((GPIOA->IDR & (1UL<<5)) != 0x00);
		}					
  }
}

