declare i32 @getint()
declare i32 @getchar()
declare void @putint(i32)
declare void @putch(i32)
declare void @putstr(i8*)

@ZERO = dso_local global i32 0
@ONE = dso_local global i32 1
@var2 = dso_local global i32 2
@var3 = dso_local global i32 3
@.str = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.1 = private unnamed_addr constant [10 x i8] c"21373457\0A\00", align 1
@.str.2 = private unnamed_addr constant [8 x i8] c"ERROR!\0A\00", align 1
@.str.3 = private unnamed_addr constant [14 x i8] c"And success!\0A\00", align 1
@.str.4 = private unnamed_addr constant [10 x i8] c"Or pass!\0A\00", align 1
@.str.5 = private unnamed_addr constant [15 x i8] c"Test1 Success!\00", align 1
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
	call void @putstr(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str, i64 0, i64 0))
	call void @putint(i32 %10)
	ret void
}
define dso_local i32 @main() {
	call void @putstr(i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.1, i64 0, i64 0))
	%1 = load i32, i32* @ZERO
	%2 = load i32, i32* @var2
	%3 = add nsw i32 %1, %2
	%4 = load i32, i32* @var3
	%5 = load i32, i32* @ONE
	%6 = sub nsw i32 %4, %5
	%7 = icmp eq i32 %3, %6
	br i1 %7, label %8, label %28

8:
	%9 = load i32, i32* @ONE
	%10 = icmp ne i32 %9, 0
	br i1 %10, label %11, label %28

11:
	%12 = load i32, i32* @ZERO
	%13 = icmp ne i32 %12, 0
	br i1 %13, label %25, label %14

14:
	%15 = load i32, i32* @ZERO
	%16 = icmp eq i32 %15, 0
	%17 = zext i1 %16 to i32
	%18 = icmp ne i32 %17, 0
	br i1 %18, label %19, label %26

19:
	%20 = load i32, i32* @ONE
	%21 = add nsw i32 %20, 1
	%22 = load i32, i32* @var2
	%23 = add nsw i32 %21, %22
	%24 = icmp slt i32 %23, 0
	br i1 %24, label %25, label %26

25:
	call void @putstr(i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.2, i64 0, i64 0))
	br label %27

26:
	call void @putstr(i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.3, i64 0, i64 0))
	br label %27

27:
	br label %28

28:
	%29 = load i32, i32* @var3
	%30 = icmp ne i32 %29, 3
	br i1 %30, label %35, label %31

31:
	%32 = load i32, i32* @var2
	%33 = sub nsw i32 %32, 22
	%34 = icmp eq i32 %33, -20
	br i1 %34, label %35, label %50

35:
	%36 = load i32, i32* @ONE
	%37 = srem i32 %36, 2
	%38 = add nsw i32 %37, 3
	%39 = sub nsw i32 %38, 8
	%40 = load i32, i32* @var3
	%41 = add nsw i32 %39, %40
	%42 = load i32, i32* @var2
	%43 = add nsw i32 %41, %42
	%44 = icmp sle i32 %43, 100
	br i1 %44, label %48, label %45

45:
	%46 = load i32, i32* @ONE
	%47 = icmp ne i32 %46, 0
	br i1 %47, label %48, label %49

48:
	call void @putstr(i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.4, i64 0, i64 0))
	br label %49

49:
	br label %50

50:
	call void @putstr(i8* getelementptr inbounds ([15 x i8], [15 x i8]* @.str.5, i64 0, i64 0))
	call void @fun()
	call void @fun()
	call void @fun()
	call void @fun()
	call void @fun()
	call void @fun()
	ret i32 0
}
