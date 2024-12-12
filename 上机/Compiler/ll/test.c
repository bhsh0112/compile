int fibonacci[15];
void cal_fibonacci()
{
	fibonacci[1] = 1;
	int i;
	for (i = 2; i < 15; i = i + 1)
	{
		fibonacci[i] = fibonacci[i - 1] + fibonacci[i - 2];
	}
	return;
}

int main()
{
	
    return 0;
}
