#include <stdio.h>
#include <stdlib.h>
int calculModule(short ** TabSig,int k);

extern short * TabSig;
int res[64];
int res_verif;
int k;

int main(){
	for (k =1; k<65; k++){
		res[k-1] = calculModule(&TabSig, k);
		if (k == 23){
			res_verif = res[k-1];
		}
	}
	k = 0;
	while(1){}
}
