#include <stdio.h>

int main(){
 printf("numIn(should be 8): %d", numIn("Shervin was in i n ininin iiiiiiini the garden in the morning."));
 return 0;
}

int numIn(char sentence[]){
 int count = 0;
 int check = 0;
 int i = 0;
 
 char c = sentence[i++];
 
 while (c != NULL){
	 if(c == 'i'){
		 check = 1;
	 } else if (c == 'n' && check == 1){
		 count++;
		 check = 0;
	 } else {
		 check = 0;
	 }
	 c = sentence[i++];
 }

 return count;
}