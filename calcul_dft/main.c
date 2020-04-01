#include <stdio.h>
#include <stdlib.h>
int calculModule(short *,int);

extern short TabSig[];

int main(){
	int res[64];
	for (int k =1; k<65; k++){
		res[k-1] = calculModule(TabSig, k);
	}
	while(1){}
}
