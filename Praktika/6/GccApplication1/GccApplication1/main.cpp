#include <avr/io.h>
#define F_CPU 1000000UL //1Mhz for CPU
#include <util/delay.h>

int ok;
int x;
int matrix_display;
int y;
int x_cal;
int y_cal;
bool lastrun = true;

#pragma region Static Chars (Display binnary)
static char POSITION[] = {0b11111110, 0b11111101, 0b11111011, 0b11110111, 0b11101111, 0b11011111, 0b10111111, 0b01111111};
static char osnov[] = {0, 0, 0, 0b00011000, 0b00011000, 0, 0, 0};
static char pos_1[] = {0, 0, 0, 0b11000000, 0b11000000, 0, 0, 0};
static char pos_minus1[] = {0, 0, 0, 0b00000011, 0b00000011, 0, 0, 0};
static char pos_2[] = {0b00011000, 0b00011000, 0, 0, 0, 0, 0, 0};
static char pos_minus2[] = {0, 0, 0, 0, 0, 0, 0b00011000, 0b00011000};
static char pos_3[] = {0b11000000, 0b11000000, 0, 0, 0, 0, 0, 0};
static char pos_minus3[] = {0, 0, 0, 0, 0, 0, 0b00000011, 0b00000011};
static char pos_4[] = {0b00000011, 0b00000011, 0, 0, 0, 0, 0, 0};
static char pos_minus4[] = {0, 0, 0, 0, 0, 0, 0b11000000, 0b11000000};
#pragma endregion Static Chars (Display binnary)

unsigned int ADC_read(unsigned char chnl, unsigned char admux)
{
	chnl= chnl & 0b00000111;  // выбор канала АЦП от 0 до 7
	ADMUX = admux;       //выбран канал A0
	ADCSRA|=(1<<ADSC);        // старт преобразования
	while(!(ADCSRA & (1<<ADIF)));   // ждем окончания преобразования
	ADCSRA|=(1<<ADIF);        // очистим ADIF когда преобразование закончится
	return (ADC);             //возвращаем рассчитанное значение АЦП
}

#pragma region Control_Display

void cleardisplay(){
	//_delay_us(150); /1250
	PORTB = 0b00000000;
	PORTD = 0b00000000;
}

void select_picture(int i){
	switch (matrix_display){
		case 0:	PORTD = osnov[i]; break;
		case 1: PORTD = pos_1[i]; break;
		case -1: PORTD = pos_minus1[i]; break;
		case 2: PORTD = pos_2[i]; break;
		case -2: PORTD = pos_minus2[i]; break;
		case 3: PORTD = pos_3[i]; break;
		case -3: PORTD = pos_minus3[i]; break;
		case 4: PORTD = pos_4[i]; break;
		case -4: PORTD = pos_minus4[i]; break;
	}
}

void SetPicture()
{
	for (int i=0; i < 8;i++)
	{
		PORTB = POSITION[i];
		select_picture(i);
		_delay_ms(2);
	}
	cleardisplay();		//может быть не видна в протеусе последния строка
}

#pragma endregion Control_Display

#pragma region Control gamepad

void cailbration()
{
	if (lastrun){
		x_cal = x;
		y_cal = y;
		lastrun	= false;
	}
}

void getmatrixdisplay(){
	if (x == x_cal && y == y_cal)
	matrix_display = 0;
	else if (x >= 800 && y == y_cal)
	matrix_display = 1;
	else if (x >= 800 && y >= 800)
	matrix_display = 3;
	else if (x >= 800 && y <= 128)
	matrix_display = -4;
	else if (x < 128 && y == y_cal)
	matrix_display = -1;
	else if(x < 128 && y < 128)
	matrix_display = -3;
	else if (y >= 800 && x < 128)
	matrix_display = 4;
	else if (y >= 800 && x == x_cal)
	matrix_display = 2;
	else if (y <= 128 && x == x_cal)
	matrix_display = -2;
}

void Get_X_and_Y_matrix_display(){
	x = ADC_read(0, 0b01000011);
	y = ADC_read(0, 0b01000100);
	cailbration();
	if (!lastrun)
		getmatrixdisplay();
}

#pragma endregion Control gamepad

int main(void)
{
	DDRB = 0b11111111;
	DDRD = 0b11111111;
	DDRA = 0b00000000;
	
	ADMUX=(1<<REFS0);          // выбор внутреннего опорного напряжения
	ADCSRA=(1<<ADEN)|(1<<ADPS2)|(1<<ADPS1)|(1<<ADPS0);     // разрешаем АЦП и устанавливаем коэффициент деления предделителя = 128
	
	while (true)
	{
		Get_X_and_Y_matrix_display();
		SetPicture();
	}
}