declare i32 @getint()
declare i32 @getchar()
declare void @putint(i32)
declare void @putch(i32)
declare void @putstr(i8*)

@ZERO = dso_local global i32 0
@ONE = dso_local global i32 1
@var2 = dso_local global i32 2
@var3 = dso_local global i32 3
@str = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@str.1 = private unnamed_addr constant [10 x i8] c"21373457\0A\00", align 1
@str.2 = private unnamed_addr constant [8 x i8] c"ERROR!\0A\00", align 1
@str.3 = private unnamed_addr constant [14 x i8] c"And success!\0A\00", align 1
@str.4 = private unnamed_addr constant [10 x i8] c"Or pass!\0A\00", align 1
@str.5 = private unnamed_addr constant [15 x i8] c"Test1 Success!\00", align 1
define dso_local void @fun() {
	%1 = alloca i32
	store i32 1, i32* %1
	%2 = alloca i32
	store i32 1, i32* %2
	br label %3

3:
	%4 = load i32, i32* %2
	%5 = icmp slt i32 %4, 1000
	br i1 %5, label %6, label %9

6:
	%7 = load i32, i32* %2
	%8 = mul nsw i32 %7, 2
	store i32 %8, i32* %2
	br label %3

9:
	%10 = load i32, i32* %2
	call void @putstr(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @str, i64 0, i64 0))
	call void @putint(i32 %10)
	ret void
}
define dso_local i32 @main() {
	call void @putstr(i8* getelementptr inbounds ([10 x i8], [10 x i8]* @str.1, i64 0, i64 0))
	%1 = load i32, i32* @ZERO
	%2 = load i32, i32* @var2
	%3 = add nsw i32 %1, %2
	%4 = load i32, i32* @var3
	%5 = load i32, i32* @ONE
	%6 = sub nsw i32 %4, %5
	%7 = icmp eq i32 %3, %6
	br i1 %7, label %8, label %27

8:
	%9 = load i32, i32* @ONE
	%10 = icmp ne i32 %9, 0
	br i1 %10, label %11, label %27

11:
	%12 = load i32, i32* @ZERO
	%13 = icmp ne i32 %12, 0
	br i1 %13, label %24, label %14

14:
	%15 = load i32, i32* @ZERO
	%16 = sub nsw i32 1, %15
	%17 = icmp ne i32 %16, 0
	br i1 %17, label %18, label %25

18:
	%19 = load i32, i32* @ONE
	%20 = add nsw i32 %19, 1
	%21 = load i32, i32* @var2
	%22 = add nsw i32 %20, %21
	%23 = icmp slt i32 %22, 0
	br i1 %23, label %24, label %25

24:
	call void @putstr(i8* getelementptr inbounds ([8 x i8], [8 x i8]* @str.2, i64 0, i64 0))
	br label %26

25:
	call void @putstr(i8* getelementptr inbounds ([14 x i8], [14 x i8]* @str.3, i64 0, i64 0))
	br label %26

26:
	br label %27

27:
	%28 = load i32, i32* @var3
	%29 = icmp ne i32 %28, 3
	br i1 %29, label %34, label %30

30:
	%31 = load i32, i32* @var2
	%32 = sub nsw i32 %31, 22
	%33 = icmp eq i32 %32, -20
	br i1 %33, label %34, label %49

34:
	%35 = load i32, i32* @ONE
	%36 = srem i32 %35, 2
	%37 = add nsw i32 %36, 3
	%38 = sub nsw i32 %37, 8
	%39 = load i32, i32* @var3
	%40 = add nsw i32 %38, %39
	%41 = load i32, i32* @var2
	%42 = add nsw i32 %40, %41
	%43 = icmp sle i32 %42, 100
	br i1 %43, label %47, label %44

44:
	%45 = load i32, i32* @ONE
	%46 = icmp ne i32 %45, 0
	br i1 %46, label %47, label %48

47:
	call void @putstr(i8* getelementptr inbounds ([10 x i8], [10 x i8]* @str.4, i64 0, i64 0))
	br label %48

48:
	br label %49

49:
	call void @putstr(i8* getelementptr inbounds ([15 x i8], [15 x i8]* @str.5, i64 0, i64 0))
	call void @fun()
	call void @fun()
	call void @fun()
	call void @fun()
	call void @fun()
	call void @fun()
	ret i32 0
}
