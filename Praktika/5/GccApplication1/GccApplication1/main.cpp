#include <avr/io.h>
#include "avr/delay.h"

#define BitSet(Port,Bit) (Port|=(1<<Bit))
#define BitClear(Port,Bit) (Port&=~(1<<Bit))
#define BitToggle(Port,Bit) (Port^=(1<<Bit))

#define SetBits(Port,BitMask) (Port|=BitMask)
#define ClearBits(Port,BitMask) (Port&=~BitMask)
#define ToggleBits(Port,BitMask) (Port^=BitMask)

int i = 0; // ���������� ���������� ���� integer ����� ������� � ��� �������� ���
int OCR;

unsigned int ADC_read(unsigned char chnl)
{
	chnl= chnl & 0b00000111;  // ����� ������ ��� �� 0 �� 7
	ADMUX = 0b01000100;       //������ ����� A0
	ADCSRA|=(1<<ADSC);        // ����� ��������������
	while(!(ADCSRA & (1<<ADIF)));   // ���� ��������� ��������������
	ADCSRA|=(1<<ADIF);        // ������� ADIF ����� �������������� ����������
	return (ADC);             //���������� ������������ �������� ���
}

void set(int ocr){
	OCR1AL = ocr;
	OCR1BL = ocr;
}

int main(void)
{
	
	DDRA = 0b00000000;
	DDRB = 0b11111111;         //������������� �� ���� ��������� PORTB ���������� "1"
	DDRD = 0b11111111;         //������������� �� ���� ��������� PORTd ���������� "1"
	ADMUX=(1<<REFS0);          // ����� ����������� �������� ����������
	ADCSRA=(1<<ADEN)|(0<<ADPS2)|(1<<ADPS1)|(1<<ADPS0);     // ��������� ��� � ������������� ����������� ������� ������������ = 128
	TCCR1A = 0b10100001; //���
	TCCR1B = 0b00001010;
	ICR1H = 0x09;
	ICR1L = 0xc3;

	OCR1AH = 0;
	OCR1BH = 0;
	
	while (1)
	{
		i = ADC_read(0);  // ��������� ������������ �������� ��� � ���������� i
		OCR = (float)(((float)512/1024)*(float)i-256);
		if (OCR < 0)
		{
			BitSet(PORTB,6);
			BitClear(PORTB,7);
			OCR = ~OCR;
		}
		else
		{
			BitSet(PORTB,7);
			BitClear(PORTB,6);
		}
		set(OCR);
	}
}