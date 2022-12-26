#include <avr/io.h>
#define F_CPU 1000000UL //1Mhz for CPU
//#define F_CPU 10000000
#include <util/delay.h>

#pragma region Var_for_display
bool onecheck = true;
int picture;
static char pos[] = {0b11111110, 0b11111101, 0b11111011, 0b11110111, 0b11101111, 0b11011111, 0b10111111, 0b01111111};
static char pol0[] = {0b00011000, 0b00111100, 0b01111110, 0b00011000, 0b00011000, 0b00011000, 0b00011000, 0b00011000};
static char pol1[] = {0b00000000, 0b00000100, 0b00000110, 0b11111111, 0b11111111, 0b00000110, 0b00000100, 0b00000000};
static char pol2[] = {0b00011000, 0b00011000, 0b00011000, 0b00011000, 0b00011000, 0b01111110, 0b00111100, 0b00011000};
static char pol3[] = {0b00000000, 0b00100000, 0b01100000, 0b11111111, 0b11111111, 0b01100000, 0b00100000, 0b00000000};
#pragma endregion Var_for_display

#pragma region Utils
void clear_display()
{
	_delay_ms(4); //1250
	PORTB = 0b00000000;
	PORTD = 0b00000000;
}

void select_picture(int i)
{
	if (picture == 0)
		PORTD = pol0[i];
	else if (picture == 1)
		PORTD = pol1[i];
	else if (picture == 2)
		PORTD = pol2[i];
	else if (picture == 3)
		PORTD = pol3[i];
}

void set_picture(int repeat)
{
	onecheck = false;
	for (int q = 0;q < repeat;q++)
	{
		for (int i=0; i < 8;i++)
		{
			PORTB = pos[i];
			select_picture(i);
			_delay_ms(2);
		}
		clear_display();
	}
}
#pragma endregion Utils

int main(void)
{
	//Configure PORTA as output
	DDRB = 0b11111111;
	DDRD = 0b11111111;
	DDRA = 0b00000000;
	while (true)
	{
		if ((PINA & 0b000000010) == 0)
		{
			while ((PINA & 0b000000010) == 0)
			{
				if (picture >= 4)
				{
					picture = 0;
				}
				else
				{
					set_picture(10);
					picture = picture+1;
				}
				//_delay_ms(250);
			}
		}
		else if ((PINA & 0b000000001) == 0)
		{
			while ((PINA & 0b000000001) == 0)
			{
				if (picture < 0)
				{
					picture = 3;
				}
				else
				{
					set_picture(10);
					picture = picture-1;
				}
				//_delay_ms(250);
			}
		}
		else if ((PINA & 0b000000100) == 0)
		{
			picture = 0;
			set_picture(1);
		}
		else if ((PINA & 0b000001000) == 0)
		{
			picture = 1;
			set_picture(1);
		}
		else if ((PINA & 0b000010000) == 0)
		{
			picture = 2;
			set_picture(1);
		}
		else if ((PINA & 0b000100000) == 0)
		{
			picture = 3;
			set_picture(1);
		}
		else
		{
			if(!onecheck)
			{
				if (picture < 0)
				{
					picture = 3;
				}
				else if (picture >= 4)
				{
					picture = 0;
				}
				set_picture(1);
				set_picture(1);
				set_picture(1);
			}
		}
		//_delay_ms(500);
	}
}