#include <stdio.h>
int getint(void);
int getchar(void);
const int MAX_SIZE = 10;
int global_var;
char str[10] = {'3', '\''};

int add(int a, int b) {
    return a + b;
}

int calculate(int a, int b[]) {
    int res = add(a, b[0]) * (a - b[1]) / (b[2]) % a - (-(-(-3))) + (+ - + -6);
    if (res <= 5) {
        return 1;
    } else {
        return 0;
    }
    return -1;
}

void printName() {
    global_var = global_var + 1;
    if (global_var != 0) {
        printf("22373040\n");
    }
    return;
}

void print(char ch) {
    printf("%c\n", ch);
}

char get_first(char str[]) {
    return str[0];
}

//int getchar() {
//    char c;
//    scanf("%c", &c);
//    return (int) c;
//}
//
//int getint() {
//    int t;
//    scanf("%d", &t);
//    while (getchar() != '\n');
//    return t;
//}

int main() {
//    freopen("a.in", "r", stdin);
//    freopen("a.out", "w", stdout);
    printName();

    int i = 0, ii = 8;
    char c;

    i = getint();
    c = getchar();

    printf("Input integer: %d\n", i);
    printf("Input character: %c\n", c);

    const int local_const = 5;
    int arr[10];
    char str[12] = "qwertyuiop\n";
    const char _str[10] = "str";

    for (i = 0; i < MAX_SIZE; i = i + 1) {
        arr[i] = i;
        if (i == 4 && i < c || i >= 9) {
            printf("i is 4 or 9!\n");
            int j;
            for (j = 1;; j = j + j) {
                if (j > 100) {
                    break;
                } else if (j != 32) {
                    continue;
                }
                printf("j is 32!\n");
            }
        }
        if (i % 2 == 0) {
            for (;;) {
                break;
            }
        } else {
        }
    }

    {
        const int arr[20] = {3, 2, 1};
        int sum = 0, i = 0;
        {
            for (; i < MAX_SIZE; i = i + 1) {
                if (i < 3) {
                    sum = sum + arr[i];
                }
            }
        }
        printf("Sum of array elements: %d\n", sum);
    }

    if (!calculate(i, arr)) {
        print(get_first(str));
    }

    /*test*/
    printf("Test finished!\n");
    return 0;
}
