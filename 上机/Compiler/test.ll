declare i32 @getint()
declare i32 @getchar()
declare void @putint(i32)
declare void @putch(i32)
declare void @putstr(i8*)

@a = dso_local global i32 1
@str = private unnamed_addr constant [4 x i8] c"--3\00", align 1
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
	%2 = call i32 @func()
	%3 = icmp ne i32 %2, 0
	br i1 %3, label %4, label %5
4:
	%6 = load i32, i32* @a
	call void @putint(i32 %6)
	call void @putstr(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @str, i64 0, i64 0))
	br label %5
5:
	ret i32 0
}
