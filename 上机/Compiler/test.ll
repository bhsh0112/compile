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
13:
	br label %17
14:
	%15 = call i32 @func3()
	%16 = icmp ne i32 %15, 0
	br i1 %16, label %17, label %19
17:
	%18 = load i32, i32* @a
	call void @putint(i32 %18)
	call void @putstr(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @str.1, i64 0, i64 0))
	br label %19
19:
	br label %20
20:
	%21 = call i32 @func3()
	%22 = icmp ne i32 %21, 0
	br i1 %22, label %27, label %23
23:
	%24 = call i32 @func()
	%25 = call i32 @func2()
	%26 = icmp slt i32 %24, %25
	br i1 %26, label %27, label %29
27:
	%28 = load i32, i32* @a
	call void @putint(i32 %28)
	call void @putstr(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @str.2, i64 0, i64 0))
	br label %29
29:
	ret i32 0
}
