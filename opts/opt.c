#include<stdio.h>

double add(double args[], int size){
    double x = 0;
    for (int i = 0; i<size ; i++){
       x+=args[i];
    }
    
    printf("%f", x);
    return x;
}

int main(){
    double nums[] = {5,6,7};
    add(nums, sizeof(nums)/sizeof(nums[0]));
    return 0;
}