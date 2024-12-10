declare i32 @getint()
declare i32 @getchar()
declare void @putint(i32)
declare void @putch(i32)
declare void @putstr(i8*)

@str = private unnamed_addr constant [7 x i8] c"round \00", align 1
@str.1 = private unnamed_addr constant [3 x i8] c": \00", align 1
@str.2 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
define dso_local i32 @main() {
	%1 = alloca i32
	store i32 1, i32* %1
	%2 = alloca i32
	%3 = load i32, i32* %1
	store i32 %3, i32* %2
	%4 = alloca i32
	%5 = alloca i32
	%6 = alloca i32
	%7 = call i32 @getint()
	store i32 %7, i32* %5
	%9 = load i32, i32* %1
	%10 = load i32, i32* %1
	%11 = mul nsw i32 %9, %10
	store i32 %11, i32* %6
	br label %12

12:
	%13 = load i32, i32* %6
	%14 = load i32, i32* %5
	%15 = add nsw i32 %14, 1
	%16 = icmp slt i32 %13, %15
	br i1 %16, label %17, label %34

17:
	%19 = load i32, i32* %2
	store i32 %19, i32* %4
	%20 = load i32, i32* %1
	%21 = load i32, i32* %2
	%22 = add nsw i32 %20, %21
	store i32 %22, i32* %2
	%23 = load i32, i32* %4
	store i32 %23, i32* %1

24:
	%25 = load i32, i32* %6
	%26 = srem i32 %25, 2
	%27 = icmp eq i32 %26, 1
	br i1 %27, label %28, label %35

28:
	br label %31
	br label %35
	%29 = load i32, i32* %6
	%30 = load i32, i32* %1
	call void @putstr(i8* getelementptr inbounds ([7 x i8], [7 x i8]* @str, i64 0, i64 0))
	call void @putint(i32 %29)
	call void @putstr(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @str.1, i64 0, i64 0))
	call void @putint(i32 %30)
	call void @putstr(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @str.2, i64 0, i64 0))
	br label %31

31:
	%32 = load i32, i32* %6
	%33 = add nsw i32 %32, 1
	store i32 %33, i32* %6
	br label %12

34:
	ret i32 0
}
