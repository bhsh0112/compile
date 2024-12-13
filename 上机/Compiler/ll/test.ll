declare i32 @getint()
declare i32 @getchar()
declare void @putint(i32)
declare void @putch(i32)
declare void @putstr(i8*)

@a = dso_local global [10 x i32] zeroinitializer
@b = dso_local global [2 x i32] [i32 1,i32 2]
@aa = dso_local global [10 x i8] zeroinitializer
@bb = dso_local global [10 x i8] [i8 104,i8 101,i8 108,i8 108,i8 111,i8 0,i8 0,i8 0,i8 0,i8 0]
@.str = private unnamed_addr constant [2 x i8] c",\00", align 1
@.str.1 = private unnamed_addr constant [2 x i8] c",\00", align 1
@.str.2 = private unnamed_addr constant [2 x i8] c",\00", align 1
@.str.3 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.4 = private unnamed_addr constant [2 x i8] c",\00", align 1
@.str.5 = private unnamed_addr constant [2 x i8] c",\00", align 1
@.str.6 = private unnamed_addr constant [2 x i8] c",\00", align 1
@.str.7 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
define dso_local i32 @func1(i32* %0, i32 %1, i8* %2, i8 %3) {
	%5 = alloca i32*
	store i32* %0, i32** %5
	%6 = alloca i32
	store i32 %1, i32* %6
	%7 = alloca i8*
	store i8* %2, i8** %7
	%8 = alloca i8
	store i8 %3, i8* %8
	%9 = load i32*, i32** %5
	%10 = getelementptr inbounds i32, i32* %9, i32 1
	%11 = load i32, i32* %10
	%12 = load i32, i32* %6
	%13 = load i8*, i8** %7
	%14 = getelementptr inbounds i8, i8* %13, i32 1
	%15 = load i8, i8* %14
	%16 = load i8, i8* %8
	call void @putint(i32 %11)
	call void @putstr(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str, i64 0, i64 0))
	call void @putint(i32 %12)
	call void @putstr(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.1, i64 0, i64 0))
	%17 = zext i8 %15 to i32
	call void @putch(i32 %17)
	call void @putstr(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.2, i64 0, i64 0))
	%18 = zext i8 %16 to i32
	call void @putch(i32 %18)
	call void @putstr(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.3, i64 0, i64 0))
	%19 = load i32*, i32** %5
	%20 = getelementptr inbounds i32, i32* %19, i32 0
	%21 = load i8, i8* %8
	%22 = zext i8 %21 to i32
	store i32 %22, i32* %20
	%23 = load i32*, i32** %5
	%24 = getelementptr inbounds i32, i32* %23, i32 1
	%25 = load i32, i32* %6
	store i32 %25, i32* %24
	%26 = load i8*, i8** %7
	%27 = getelementptr inbounds i8, i8* %26, i32 1
	%28 = load i8, i8* %8
	store i8 %28, i8* %27
	ret i32 0
}
define dso_local i32 @func2(i32* %0, i32 %1, i8* %2, i8 %3) {
	%5 = alloca i32*
	store i32* %0, i32** %5
	%6 = alloca i32
	store i32 %1, i32* %6
	%7 = alloca i8*
	store i8* %2, i8** %7
	%8 = alloca i8
	store i8 %3, i8* %8
	%9 = load i32*, i32** %5
	%10 = load i32, i32* %6
	%11 = load i8*, i8** %7
	%12 = load i8, i8* %8
	%13 = call i32 @func1(i32* %9, i32 %10, i8* %11, i8 %12)
	%14 = load i32*, i32** %5
	%15 = getelementptr inbounds i32, i32* %14, i32 1
	%16 = load i32, i32* %15
	%17 = load i32, i32* %6
	%18 = load i8*, i8** %7
	%19 = getelementptr inbounds i8, i8* %18, i32 1
	%20 = load i8, i8* %19
	%21 = load i8, i8* %8
	call void @putint(i32 %16)
	call void @putstr(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.4, i64 0, i64 0))
	call void @putint(i32 %17)
	call void @putstr(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.5, i64 0, i64 0))
	%22 = zext i8 %20 to i32
	call void @putch(i32 %22)
	call void @putstr(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.6, i64 0, i64 0))
	%23 = zext i8 %21 to i32
	call void @putch(i32 %23)
	call void @putstr(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.7, i64 0, i64 0))
	ret i32 0
}
define dso_local i32 @main() {
	%1 = alloca [10 x i32]
	%2 = alloca [10 x i8]
	%3 = alloca [2 x i32]
	%4 = getelementptr inbounds [2 x i32], [2 x i32]* %3, i32 0, i32 0
	store i32 1, i32* %4
	%5 = getelementptr inbounds i32, i32* %4, i32 1
	store i32 2, i32* %5
	%6 = alloca [3 x i8]
	%7 = getelementptr inbounds [3 x i8], [3 x i8]* %6, i32 0, i32 0
	store i8 49, i8* %7
	%8 = getelementptr inbounds [10 x i32], [10 x i32]* @a, i32 0, i32 0
	%9 = getelementptr inbounds [10 x i32], [10 x i32]* @a, i32 0, i32 1
	%10 = load i32, i32* %9
	%11 = getelementptr inbounds [10 x i8], [10 x i8]* @aa, i32 0, i32 0
	%12 = getelementptr inbounds [10 x i8], [10 x i8]* @aa, i32 0, i32 1
	%13 = load i8, i8* %12
	%14 = call i32 @func2(i32* %8, i32 %10, i8* %11, i8 %13)
	%15 = getelementptr inbounds [10 x i32], [10 x i32]* %1, i32 0, i32 0
	%16 = getelementptr inbounds [10 x i32], [10 x i32]* %1, i32 0, i32 1
	%17 = load i32, i32* %16
	%18 = getelementptr inbounds [10 x i8], [10 x i8]* %2, i32 0, i32 0
	%19 = getelementptr inbounds [10 x i8], [10 x i8]* %2, i32 0, i32 1
	%20 = load i8, i8* %19
	%21 = call i32 @func2(i32* %15, i32 %17, i8* %18, i8 %20)
	%22 = getelementptr inbounds [2 x i32], [2 x i32]* %3, i32 0, i32 0
	%23 = getelementptr inbounds [2 x i32], [2 x i32]* %3, i32 0, i32 1
	%24 = load i32, i32* %23
	%25 = getelementptr inbounds [3 x i8], [3 x i8]* %6, i32 0, i32 0
	%26 = getelementptr inbounds [3 x i8], [3 x i8]* %6, i32 0, i32 1
	%27 = load i8, i8* %26
	%28 = call i32 @func2(i32* %22, i32 %24, i8* %25, i8 %27)
	ret i32 0
}
