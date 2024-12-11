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
	br i1 %7, label %8, label %24

8:
	%9 = load i32, i32* @ONE
	%10 = icmp ne i32 %9, 0
	br i1 %10, label %11, label %24

11:
	%12 = load i32, i32* @ZERO
	%13 = icmp ne i32 %12, 0
	br i1 %13, label %21, label %14

14:

15:
	%16 = load i32, i32* @ONE
	%17 = add nsw i32 %16, 1
	%18 = load i32, i32* @var2
	%19 = add nsw i32 %17, %18
	%20 = icmp slt i32 %19, 0
	br i1 %20, label %21, label %22

21:
	call void @putstr(i8* getelementptr inbounds ([8 x i8], [8 x i8]* @str.2, i64 0, i64 0))
	br label %23

22:
	call void @putstr(i8* getelementptr inbounds ([14 x i8], [14 x i8]* @str.3, i64 0, i64 0))

23:
	br label %24

24:
	%25 = load i32, i32* @var3
	%26 = icmp ne i32 %25, 3
	br i1 %26, label %31, label %27

27:
	%28 = load i32, i32* @var2
	%29 = sub nsw i32 %28, 22
	%30 = icmp eq i32 %29, -20
	br i1 %30, label %31, label %46

31:
	%32 = load i32, i32* @ONE
	%33 = srem i32 %32, 2
	%34 = add nsw i32 %33, 3
	%35 = sub nsw i32 %34, 8
	%36 = load i32, i32* @var3
	%37 = add nsw i32 %35, %36
	%38 = load i32, i32* @var2
	%39 = add nsw i32 %37, %38
	%40 = icmp sle i32 %39, 100
	br i1 %40, label %44, label %41

41:
	%42 = load i32, i32* @ONE
	%43 = icmp ne i32 %42, 0
	br i1 %43, label %44, label %45

44:
	call void @putstr(i8* getelementptr inbounds ([10 x i8], [10 x i8]* @str.4, i64 0, i64 0))
	br label %45

45:
	br label %46

46:
	call void @putstr(i8* getelementptr inbounds ([15 x i8], [15 x i8]* @str.5, i64 0, i64 0))
	call void @fun()
	call void @fun()
	call void @fun()
	call void @fun()
	call void @fun()
	call void @fun()
	ret i32 0
}
