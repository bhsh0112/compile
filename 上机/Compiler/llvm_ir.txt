declare i32 @getint()
declare i32 @getchar()
declare void @putint(i32)
declare void @putch(i32)
declare void @putstr(i8*)

@a = dso_local global i32 1
@str = private unnamed_addr constant [8 x i8] c"success\00", align 1
@str.1 = private unnamed_addr constant [9 x i8] c"success2\00", align 1
@str.2 = private unnamed_addr constant [8 x i8] c"success\00", align 1
@str.3 = private unnamed_addr constant [9 x i8] c"success2\00", align 1
define dso_local i8 @func() {
	store i32 2, i32* @a
	ret i8 '1'
}
define dso_local i32 @func2() {
	store i32 4, i32* @a
	ret i32 10
}
define dso_local i32 @main() {
1:
	%2 = call i32 @func2()
	%3 = icmp ne i32 %2, 0
	br i1 %3, label %4, label %6
4:
	%5 = alloca i32
	store i32 0, i32* %5
	call void @putstr(i8* getelementptr inbounds ([8 x i8], [8 x i8]* @str, i64 0, i64 0))
	br label %7
6:
	call void @putstr(i8* getelementptr inbounds ([9 x i8], [9 x i8]* @str.1, i64 0, i64 0))
7:
	%8 = call i8 @func()
	%9 = icmp ne i8 %8, 0
	br i1 %9, label %10, label %11
10:
	call void @putstr(i8* getelementptr inbounds ([8 x i8], [8 x i8]* @str.2, i64 0, i64 0))
	br label %12
11:
	call void @putstr(i8* getelementptr inbounds ([9 x i8], [9 x i8]* @str.3, i64 0, i64 0))
12:
	ret i32 0
}
