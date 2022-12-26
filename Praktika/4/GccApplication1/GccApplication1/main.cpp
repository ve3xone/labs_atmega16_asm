#include <avr/io.h>

int i = 0; // определяем переменную типа integer чтобы хранить в ней значение АЦП
int OCR;

unsigned int ADC_read(unsigned char chnl)	
{
	chnl= chnl & 0b00000111;  // выбор канала АЦП от 0 до 7
	ADMUX = 0b01000011;       //выбран канал A0
	ADCSRA|=(1<<ADSC);        // старт преобразования
	while(!(ADCSRA & (1<<ADIF)));   // ждем окончания преобразования
	ADCSRA|=(1<<ADIF);        // очистим ADIF когда преобразование закончится
	return (ADC);             //возвращаем рассчитанное значение АЦП
}

void set(int ocr){
	OCR1AL = ocr;
	OCR1BL = ocr;
}

int main(void)
{
	DDRA = 0b00000000;
	DDRD = 0b11111111;         //устанавливаем на всех контактах PORTC логические "1"
	ADMUX=(1<<REFS0);          // выбор внутреннего опорного напряжения
	ADCSRA=(1<<ADEN)|(1<<ADPS2)|(1<<ADPS1)|(1<<ADPS0);     // разрешаем АЦП и устанавливаем коэффициент деления предделителя = 128
	TCCR1A = 0b10100010; //ШИМ
	TCCR1B = 0b00011010;
	ICR1H = 0x09;
	ICR1L = 0xc3;

	OCR1AH = 0;	//для более точного положения импульсов
	OCR1BH = 0;
	
	while (1)
	{
		i = (int) ADC_read(0);  // сохраняем рассчитанное значение АЦП в переменной i
		OCR = (float)(((float)193/1024)*(float)i)+(int)62; //181
		set(OCR);
	}
}
