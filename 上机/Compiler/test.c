#include <stdio.h>
int a[3 + 3] = {1, 2, 3, 4, 5, 6};
int foo(int x, int y[]) {
    return x + y[2];
}

int main() {
    int c[3] = {1, 2, 3};
    int x = foo(a[4], a);
    printf("%d - %d\n", x, foo(c[0], c));
    return 0;
}