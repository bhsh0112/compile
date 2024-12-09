declare i32 @getint()
declare i32 @getchar()
declare void @putint(i32)
declare void @putch(i32)
declare void @putstr(i8*)

@a = dso_local global i32 1
@str = private unnamed_addr constant [4 x i8] c"--1\00", align 1
@str.1 = private unnamed_addr constant [4 x i8] c"--2\00", align 1
@str.2 = private unnamed_addr constant [4 x i8] c"--3\00", align 1
define dso_local i32 @func() {
	store i32 2, i32* @a
	ret i32 1
}
define dso_local i32 @func2() {
	store i32 4, i32* @a
	ret i32 10
}
define dso_local i32 @func3() {
	store i32 3, i32* @a
	ret i32 0
}
define dso_local i32 @main() {
1:
	br label %2
2:
	%3 = call i32 @func()
	%4 = icmp ne i32 %3, 0
	br i1 %4, label %5, label %8
5:
	%6 = call i32 @func3()
	%7 = icmp ne i32 %6, 0
	br i1 %7, label %11, label %8
8:
	%9 = call i32 @func2()
	%10 = icmp ne i32 %9, 0
	br i1 %10, label %11, label %13
11:
	%12 = load i32, i32* @a
	call void @putint(i32 %12)
	call void @putstr(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @str, i64 0, i64 0))
	br label %13
14:
	br label %18
15:
	%16 = call i32 @func3()
	%17 = icmp ne i32 %16, 0
	br i1 %17, label %18, label %20
18:
	%19 = load i32, i32* @a
	call void @putint(i32 %19)
	call void @putstr(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @str.1, i64 0, i64 0))
	br label %20
21:
	br label %22
22:
	%23 = call i32 @func3()
	%24 = icmp ne i32 %23, 0
	br i1 %24, label %29, label %25
25:
	%26 = call i32 @func()
	%27 = call i32 @func2()
	%28 = icmp slt i32 %26, %27
	br i1 %28, label %29, label %31
29:
	%30 = load i32, i32* @a
	call void @putint(i32 %30)
	call void @putstr(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @str.2, i64 0, i64 0))
	br label %31
	ret i32 0
}
