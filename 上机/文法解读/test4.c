#include <stdio.h>
const int num1=10;
const int num2=1,num3=1,num4=1;
const char cha='a';
int num5=100;
int num6,num7,num8;
const char chb='b';



int getchar(){
    char c;
    scanf("%c",&c);
    return (int)c;
}
int getint(){
    int t;
    scanf("%d",&t);
    while(getchar()!='\n');
    return t;
}


void print_id(){
    printf("22182608\n");
}

void my_print_int(int a){
    printf("%d\n",a);
    return;
}

void my_print_char(char a){
    printf("%c\n",a);
    return;
}

int my_add_two(int num1,int num2){
    int ans=num1+num2;
    return ans;
}



int main(){
    int input1;
    input1=getint();
    int input2;
    input2=getint();
    int i=0;
    print_id();
    if(input1>input2){
        int answer;
        answer=my_add_two(input2,input1);
        my_print_int(answer);
    }
    else{
        char answer;
        answer='2';
        my_print_char(answer);
    }
    char answer2;
    answer2=cha;
    if(input1>100){

    }
    for(i=0;i<input2;i=i+1){
        if(i<2){
            continue;
        }
        else{
            break;
        }
    }
    int mul_ans;
    mul_ans=input1*input2;
    printf("output3:%d\n",mul_ans);
    if(input1==input2){
        printf("output4\n");
    }
    else{
        printf("output4\n");
    }
    printf("output5\n");
    if(input1==input2){
        printf("output6\n");
    }
    int div_ans;
    div_ans=input1/input2;
    printf("output7:%d\n",div_ans);
    int mod_ans;
    mod_ans=input1%input2;
    printf("output8:%d\n",mod_ans);
    int add1=0,add2=0;
    if(input1>input2){
        add1=2;
        add2=2;
    }
    if(input1<=input2){
        add1=3;
        add2=2;
    }
    if(input1+1<input2-1){
        add1=2;
        add2=2;
    }
    if(input1+1>=input2-1){
        add1=3;
        add2=2;
    }
    add1=+add1;
    add2=-add2;
    printf("output9:%d\n",add1+add2);
    int ans10;
    ans10=1+2;
    printf("output10:%d\n",ans10);
    int sum=0;
    for(;i<10;i=i+1){
        sum=sum+i;
    }
    for(i=0;;i=i+1){
        sum=sum+i;
        if(i==10){
            break;
        }
    }
    for(i=0;i<10;){
        sum=sum+i;
        i=i+1;
    }
    i=0;
    for(;;i=i+1){
        sum=sum+i;
        if(i==10){
            break;
        }
    }
    i=0;
    for(;i<10;){
        sum=sum+i;
        i=i+1;
    }
    for(i=0;;){
        sum=sum+i;
        if(i==10){
            break;
        }
        i=i+1;
    }
    i=0;
    for(;;){
        sum=sum+i;
        if(i==10){
            break;
        }
        i=i+1;
    }
    if(!input1){
        i=i+1;
    }
    i=(i*i)+i;
    return 0;
}