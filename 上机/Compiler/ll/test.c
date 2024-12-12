#include<stdio.h> 
int setIndex(int arr[], int index, int val) {
    int temp = arr[index];
    arr[index] = val;
    return temp;
}

int main() {
    int arr[1];
    printf("%d\n",setIndex(arr,0,1));
    printf("%d",arr[0]);

    return 0;
}

