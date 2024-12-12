declare i32 @getint()
declare i32 @getchar()
declare void @putint(i32)
declare void @putch(i32)
declare void @putstr(i8*)

define dso_local i32 @calculate(i32 %0, i32* %1) {
	%3 = alloca i32
	store i32 %0, i32* %3
	%4 = alloca i32*
	store i32* %1, i32** %4
	%5 = alloca i32
	store i32 1, i32* %5
	%6 = load i32, i32* %5
	%7 = icmp sle i32 %6, 5
	br i1 %7, label %8, label %9

8:
	ret i32 1
	br label %10

9:
	ret i32 0
	br label %10

10:
	ret i32 -1
}
define dso_local i32 @main() {
	ret i32 0
}
