#include <avr/io.h>

int i = 0; // ���������� ���������� ���� integer ����� ������� � ��� �������� ���
int OCR;

unsigned int ADC_read(unsigned char chnl)	
{
	chnl= chnl & 0b00000111;  // ����� ������ ��� �� 0 �� 7
	ADMUX = 0b01000011;       //������ ����� A0
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
	DDRD = 0b11111111;         //������������� �� ���� ��������� PORTC ���������� "1"
	ADMUX=(1<<REFS0);          // ����� ����������� �������� ����������
	ADCSRA=(1<<ADEN)|(1<<ADPS2)|(1<<ADPS1)|(1<<ADPS0);     // ��������� ��� � ������������� ����������� ������� ������������ = 128
	TCCR1A = 0b10100010; //���
	TCCR1B = 0b00011010;
	ICR1H = 0x09;
	ICR1L = 0xc3;

	OCR1AH = 0;	//��� ����� ������� ��������� ���������
	OCR1BH = 0;
	
	while (1)
	{
		i = (int) ADC_read(0);  // ��������� ������������ �������� ��� � ���������� i
		OCR = (float)(((float)193/1024)*(float)i)+(int)62; //181
		set(OCR);
	}
}
