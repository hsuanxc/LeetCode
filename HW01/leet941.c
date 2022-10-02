#include <stdio.h>
#include <stdlib.h>
typedef enum{false,true}bool;

bool  validMountainArray(int* arr, int arrSize){
    if (arrSize < 2) return false;
    int i = 0, status = 0;
    char *result = "";

    while(i < arrSize){
        if (arr[i] == arr[i+1]) 
            return false;
        if(arr[i] < arr[i+1]){
            status = 1;
        }
        else if(arr[i] > arr[i+1]){
            if(status == 0) return false;
        }
        ++i;
    }
    return true;
}

int main(){
    int arrSize = 3;
    int a[3] = {0, 3, 1};
    int *arr = (int *)malloc(sizeof(int)*arrSize);
    arr = a;
    if (validMountainArray(arr, arrSize-1) == true)
        printf("true\n");
    else
        printf("false\n");
}