declare i32 @getint()
declare i32 @getchar()
declare void @putint(i32)
declare void @putch(i32)
declare void @putstr(i8*)

@.str = private unnamed_addr constant [9 x i8] c"success\0A\00", align 1
define dso_local i32 @main() {
	%1 = alloca i32
	store i32 0, i32* %1
	br label %2

2:
	%3 = load i32, i32* %1
	%4 = icmp slt i32 %3, 2
	br i1 %4, label %5, label %9

5:
	call void @putstr(i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str, i64 0, i64 0))
	br label %6

6:
	%7 = load i32, i32* %1
	%8 = add nsw i32 %7, 1
	store i32 %8, i32* %1
	br label %2

9:
	ret i32 0
}
