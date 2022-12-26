#include <avr/io.h>
#define F_CPU 1000000UL //1Mhz for CPU
//#define F_CPU 10000000
#include <util/delay.h>

int ok;

static char POSITION[] = {0b11111110, 0b11111101, 0b11111011, 0b11110111, 0b11101111, 0b11011111, 0b10111111, 0b01111111};
static char pol0[] = {0b00000000, 0b00000000, 0b00011000, 0b00111100, 0b01111110, 0b11111111, 0b00000000, 0b00000000};
static char pol1[] = {0b00000100, 0b00001100, 0b00011100, 0b00111100, 0b00111100, 0b00011100, 0b00001100, 0b00000100};
static char pol2[] = {0b00000000, 0b00000000, 0b11111111, 0b01111110, 0b00111100, 0b00011000, 0b00000000, 0b00000000};
static char pol3[] = {0b00100000, 0b00110000, 0b00111000, 0b00111100, 0b00111100, 0b00111000, 0b00110000, 0b00100000};

void ClearDisplay(){
	//_delay_us(150); /1250
	PORTB = 0b00000000;
	PORTD = 0b00000000;
}

void SetPicture(){
	for (int i=0; i < 8;i++){
		PORTB = POSITION[i];
		if (ok == 0){
			PORTD = pol0[i];
		}
		else if (ok == 1){
			PORTD = pol1[i];
		}
		else if (ok == 2){
			PORTD = pol2[i];
		}
		else if (ok == 3){
			PORTD = pol3[i];
		}
		_delay_ms(2);
	}
	ClearDisplay();
}

int main(void)
{
	//Configure PORTA as output
	DDRB = 0b11111111;
	DDRD = 0b11111111;
	DDRA = 0b00000000;
    while (true) 
    {
		//PORTB = 0b00000000;
		//PORTD = 0b11111111;
		if ((PINA & 0b000000010) == 0)
		{
			while ((PINA & 0b000000010) == 0){
			if (ok >= 4){
				ok = 0;
			}
			else{
				SetPicture();
				SetPicture();
				SetPicture();
				ok =ok+1;
			}
			}
		}
		else if ((PINA & 0b000000001) == 0)
		{
			while ((PINA & 0b000000001) == 0){
			if (ok < 0){
				ok = 3;
			}
			else{
				SetPicture();
				SetPicture();
				SetPicture();
				ok = ok-1;
			}
			}
		}
		else{
			ClearDisplay();
		}
		_delay_ms(500);
    }
}