#include <stdio.h>
int modify_array(int arr[]) {
    int i=1;
    char op = '+';
    if (op == '+') {
       arr[i] = arr[i] + i;
    } else {
        arr[i] = arr[i] - i;
    }
    return 0;
}

int main() {
    int nums[5] = {1,2};
    int total = modify_array(nums);
    printf("%d\n",nums[1]);
    return 0;
}