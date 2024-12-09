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
	br i1 %10, label %11, label %16
11:
	%12 = load i32, i32* @a
	call void @putint(i32 %12)
	call void @putstr(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @str, i64 0, i64 0))
	br label %16
16:
17:
	br label %21
18:
	%19 = call i32 @func3()
	%20 = icmp ne i32 %19, 0
	br i1 %20, label %21, label %26
21:
	%22 = load i32, i32* @a
	call void @putint(i32 %22)
	call void @putstr(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @str.1, i64 0, i64 0))
	br label %26
26:
27:
	br label %28
28:
	%29 = call i32 @func3()
	%30 = icmp ne i32 %29, 0
	br i1 %30, label %37, label %31
31:
	%32 = call i32 @func()
	%33 = icmp ne i32 %32, 0
	br i1 %33, label %34, label %42
34:
	%35 = call i32 @func2()
	%36 = icmp ne i32 %35, 0
	br i1 %36, label %37, label %42
37:
	%38 = load i32, i32* @a
	call void @putint(i32 %38)
	call void @putstr(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @str.2, i64 0, i64 0))
	br label %42
42:
	ret i32 0
}
