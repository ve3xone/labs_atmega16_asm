/*
 * GccApplication1.cpp
 *
 * Created: 09.12.2022 9:04:17
 * Author : ve3xone
 */ 

#include <avr/io.h>
#define F_CPU 1000000UL //1Mhz for CPU
#include <util/delay.h>
#include <string.h>
#include "LCD.h"
#include <stdlib.h>
#include <stdio.h>
#include "DHT.c"
//#define DHT11_PIN 1


int main(void)
{
	double temperature[1];
	double humidity[1];

	//Setup
	DHT_Setup();
		
	//DDRD = 0b11111111;
	char buff[3];                    // Буфер для дисплея
	
	char data_dht11[5];
	char text[17];
	lcdInit();
	lcdClear();
	lcdSetCursor(LCD_CURSOR_OFF);
	lcdGotoXY(0, 0);		/* Enter column and row position */
	lcdPuts("H=");
	lcdGotoXY(1,0);
	lcdPuts("T=");
	
	while(1)
	{
		//Read from sensor
		DHT_Read(temperature, humidity);
		
		//Check status
		//switch (DHT_GetStatus())
		//{
			//case (DHT_Ok):
				lcdClear();
				lcdGotoXY(0, 0);		/* Enter column and row position */
				lcdPuts("H=");
				lcdGotoXY(1,0);
				lcdPuts("T=");
				itoa(humidity[0],data_dht11,10);
				lcdGotoXY(0,2);
				lcdPuts(data_dht11);
			    strcpy(text, "%");
			    lcdPuts(text);
				itoa(temperature[0],data_dht11,10);
				lcdGotoXY(1,2);
				lcdPuts(data_dht11);
			    lcdRawSendByte(0xDF,1 ); //Градус
			    strcpy(text, "C"); //Цельсия
				lcdPuts(text);
				//break;
			//case (DHT_Error_Checksum):
				//lcdClear();
				//strcpy(text, "Error Checksum");
				//lcdPuts(text);
				//Do something
				//break;
			//case (DHT_Error_Timeout):
				//lcdClear();
				//strcpy(text, "Error Timeout");
				//lcdPuts(text);
				//break;
		}
		_delay_ms(2000);
	}
}