declare i32 @getint()
declare i32 @getchar()
declare void @putint(i32)
declare void @putch(i32)
declare void @putstr(i8*)

@a = dso_local global [6 x i32] [i32 1,i32 2,i32 3,i32 4,i32 5,i32 6]
@str = private unnamed_addr constant [4 x i8] c" - \00", align 1
@str.1 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
define dso_local i32 @foo(i32 %0, i32* %1) {
	%3 = alloca i32
	store i32 %0, i32* %3
	%4 = alloca i32*
	store i32* %1, i32** %4
	%5 = load i32*, i32** %4
	%6 = getelementptr inbounds i32, i32* %5, i32 2
	%7 = load i32, i32* %6
	%8 = load i32, i32* %3
	%9 = add nsw i32 %8, %7
	ret i32 %9
}
define dso_local i32 @main() {
	%1 = alloca [3 x i32]
	%2 = getelementptr inbounds [3 x i32], [3 x i32]* %1, i32 0, i32 0
	store i32 1, i32* %2
	%3 = getelementptr inbounds i32, i32* %2, i32 1
	store i32 2, i32* %3
	%4 = getelementptr inbounds i32, i32* %3, i32 1
	store i32 3, i32* %4
	%5 = alloca i32
	%6 = getelementptr inbounds [6 x i32], [6 x i32]* @a, i32 0, i32 4
	%7 = load i32, i32* %6
	%8 = getelementptr inbounds [6 x i32], [6 x i32]* @a, i32 0, i32 0
	%9 = call i32 @foo(i32 %7, i32* %8)
	store i32 %9, i32* %5
	%10 = load i32, i32* %5
	%11 = getelementptr inbounds [3 x i32], [3 x i32]* %1, i32 0, i32 0
	%12 = load i32, i32* %11
	%13 = getelementptr inbounds [3 x i32], [3 x i32]* %1, i32 0, i32 0
	%14 = call i32 @foo(i32 %12, i32* %13)
	call void @putint(i32 %10)
	call void @putstr(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @str, i64 0, i64 0))
	call void @putint(i32 %14)
	call void @putstr(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @str.1, i64 0, i64 0))
	ret i32 0
}
