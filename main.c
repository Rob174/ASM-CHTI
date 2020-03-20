#include <stdio.h>
#include <stdlib.h>

int * angle;
int res;
int calcul2(int angle, int * res);
int min;
int max;


int main(){
		angle = malloc(sizeof(int));
		*angle = 0;
		calcul2(*angle,&res);
		min = res;
		max = res;
		for (int j = 1; j<64; j++){
			*angle = j;
			calcul2(*angle,&res);
			if (max < res){
				max = res;
			}
			if (min > res){
				min = res;
			}
		}
		while(1){}
}
