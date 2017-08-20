#include <stdio.h>

void func();

int main(){

	double x[5][5] = {
		{1,1,1,1,1},
		{1,1,1,1,1}
	};
	double y[5][5] = {
		{1,1,1,1,1},
		{1,1,1,1,1}
	};

	func(x,y,1,2);
	
	return 0;
}

void func(double x[5][5], double y[5][5], int i, int j){
	y[i][j] = (1 - x[i][j] / 8);
}


