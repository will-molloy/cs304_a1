#include <stdio.h>

int main(){
	printf("result: %d\n", compute(4,4096,5)); // 20,865
	
	// 0's
	printf("result: %d\n", compute(0,0,0)); 
	printf("result: %d\n", compute(4,4096,11)); 
	printf("result: %d\n", compute(-1,4096,5)); 
	printf("result: %d\n", compute(10,4096,5));
	printf("result: %d\n", compute(10,4096,7));
	
	printf("result: %d\n", compute(9,2147483647,6));
}

int compute(int x, int y, int n){
	int z;
	if (x >= 10 || x <= 0 || n >= 7 || n <= 0){
		z = 0;
	} else {
		z = 1 + pow(3*x, 4) + (y / pow(2, n));
	} 
	return z;
}

int pow(int n, int exp){
	int prod = n;
	while (--exp){
		prod *= n;
	}
	return prod;
}