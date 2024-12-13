int arr[15];
int func2(int a[]){
    int i=1;
    a[i]=i;
    return 1;
}
void func(int a[]){
    func2(a);
}

int main()
{
    int i=0;
    func(arr);
    return 0;
}
