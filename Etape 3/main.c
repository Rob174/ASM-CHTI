#include <stdio.h>
#include <stdlib.h>
#include "gassp72.h"
int calculModule(unsigned short ** TabSig,int k);


int res[64];
int res_verif;
int k;
unsigned short * dma_buf;
int nb_occ[6] = {0,0,0,0,0,0};//ne prendre ne compte un tir que s'il est détecté sur plusieurs fenêtres consécutives (par exemple 3)
int M2Tir = (int)(0xffffff);
void sys_callback(){
	// Démarrage DMA pour 64 points
	Start_DMA1(64);
	Wait_On_End_Of_DMA1();
	Stop_DMA1;
	for (k =1; k<65; k++){//1 à 64 ? Ici je changerais bien par 0 à 64
		res[k-1] = calculModule(&dma_buf, k);
	}
}
int main(){
	
	dma_buf = malloc(64*sizeof(unsigned short));
	// activation de la PLL qui multiplie la fréquence du quartz par 9
	CLOCK_Configure();
	// PA2 (ADC voie 2) = entrée analog
	GPIO_Configure(GPIOA, 2, INPUT, ANALOG);
	// PB1 = sortie pour profilage à l'oscillo
	GPIO_Configure(GPIOB, 1, OUTPUT, OUTPUT_PPULL);
	// PB14 = sortie pour LED
	GPIO_Configure(GPIOB, 14, OUTPUT, OUTPUT_PPULL);

	// activation ADC, sampling time 1us
	Init_TimingADC_ActiveADC_ff( ADC1, 51 );
	Single_Channel_ADC( ADC1, 2 );
	// Déclenchement ADC par timer2, periode (72MHz/320kHz)ticks
	Init_Conversion_On_Trig_Timer_ff( ADC1, TIM2_CC2, 225 );
	// Config DMA pour utilisation du buffer dma_buf (a créér)
	Init_ADC1_DMA1( 0, dma_buf );

	// Config Timer, période exprimée en périodes horloge CPU (72 MHz)
	Systick_Period_ff( 360000 );//période du traitement sera de 5 m
	// enregistrement de la fonction de traitement de l'interruption timer
	// ici le 3 est la priorité, sys_callback est l'adresse de cette fonction, a créér en C
	Systick_Prio_IT( 3, sys_callback );
	SysTick_On;
	SysTick_Enable_IT;
	
	while(1){}
}
