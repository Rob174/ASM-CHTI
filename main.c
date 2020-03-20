#include <stdio.h>
#include <stdlib.h>

int * angle;

int calcul(int angle, int * res);


int main(){
		*angle = 50;
		int res;
		angle = malloc(sizeof(int));
		calcul(*angle,&res);
		printf("Resultat : %d\n", res);
		while(1){}
}
