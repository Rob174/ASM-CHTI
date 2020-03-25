#include <stdio.h>
#include <stdlib.h>

void calculIm(int * resIm, int k);
void calculRe(int * resRe, int k);
void calculModule(int resRe, int resIm, int * module);
int * resRe;
int * resIm;
int * module;

int main(){
		resRe = malloc(sizeof(int));
		resIm = malloc(sizeof(int));
		module = malloc(sizeof(int));
		calculIm(resIm, 1);
		calculRe(resRe, 1);
		calculModule(*resRe, *resIm, module);
		while(1){}
}
