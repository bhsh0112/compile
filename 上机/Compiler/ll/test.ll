declare i32 @getint()
declare i32 @getchar()
declare void @putint(i32)
declare void @putch(i32)
declare void @putstr(i8*)

define dso_local i8 @fun() {
	ret i8 97
}
define dso_local i32 @main() {
	%1 = alloca i32
	store i32 1, i32* %1
	%2 = alloca i32
	store i32 1, i32* %2
	%3 = alloca i32
	store i32 1, i32* %3
	%4 = load i32, i32* %1
	%5 = load i32, i32* %2
	%6 = load i32, i32* %3
	%7 = icmp sle i32 %5, %6
	
	%8 = icmp eq i32 %4, %7
	br i1 %8, label %9, label %10

9:
	br label %10

10:
	%11 = load i32, i32* %1
	ret i32 %11
}
