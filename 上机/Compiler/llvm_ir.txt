declare i32 @getint()
declare i32 @getchar()
declare void @putint(i32)
declare void @putch(i32)
declare void @putstr(i8*)

@.str = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.1 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.2 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.3 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.4 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.5 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.6 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.7 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.8 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.9 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
define dso_local i32 @getIndex(i32* %0, i32 %1) {
	%3 = alloca i32*
	store i32* %0, i32** %3
	%4 = alloca i32
	store i32 %1, i32* %4
	%5 = load i32, i32* %4
	%6 = load i32*, i32** %3
	%7 = getelementptr inbounds i32, i32* %6, i32 %5
	%8 = load i32, i32* %7
	ret i32 %8
}
define dso_local i32 @setIndex(i32* %0, i32 %1, i32 %2) {
	%4 = alloca i32*
	store i32* %0, i32** %4
	%5 = alloca i32
	store i32 %1, i32* %5
	%6 = alloca i32
	store i32 %2, i32* %6
	%7 = alloca i32
	%8 = load i32, i32* %5
	%9 = load i32*, i32** %4
	%10 = getelementptr inbounds i32, i32* %9, i32 %8
	%11 = load i32, i32* %10
	store i32 %11, i32* %7
	%12 = load i32, i32* %5
	%13 = load i32, i32* %6
	store i32* %13, i32** %4
	%14 = load i32, i32* %7
	ret i32 %14
}
define dso_local i32 @main() {
	%1 = alloca [5 x i32]
	%2 = getelementptr inbounds [5 x i32], [5 x i32]* %1, i32 0, i32 0
	store i32 0, i32* %2
	%3 = getelementptr inbounds i32, i32* %2, i32 1
	store i32 1, i32* %3
	%4 = getelementptr inbounds i32, i32* %3, i32 1
	store i32 2, i32* %4
	%5 = getelementptr inbounds i32, i32* %4, i32 1
	store i32 3, i32* %5
	%6 = getelementptr inbounds i32, i32* %5, i32 1
	store i32 4, i32* %6
	%7 = alloca [5 x i32]
	%8 = getelementptr inbounds [5 x i32], [5 x i32]* %7, i32 0, i32 0
	store i32 0, i32* %8
	%9 = getelementptr inbounds i32, i32* %8, i32 1
	store i32 0, i32* %9
	%10 = getelementptr inbounds i32, i32* %9, i32 1
	store i32 0, i32* %10
	%11 = getelementptr inbounds i32, i32* %10, i32 1
	store i32 0, i32* %11
	%12 = getelementptr inbounds i32, i32* %11, i32 1
	store i32 0, i32* %12
	%13 = getelementptr inbounds [5 x i32], [5 x i32]* %7, i32 0, i32 0
	%14 = getelementptr inbounds [5 x i32], [5 x i32]* %1, i32 0, i32 0
	%15 = call i32 @getIndex(i32* %14, i32 0)
	%16 = add nsw i32 %15, 0
	%17 = call i32 @setIndex(i32* %13, i32 0, i32 %16)
	call void @putint(i32 %17)
	call void @putstr(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str, i64 0, i64 0))
	%18 = getelementptr inbounds [5 x i32], [5 x i32]* %7, i32 0, i32 0
	%19 = getelementptr inbounds [5 x i32], [5 x i32]* %1, i32 0, i32 0
	%20 = call i32 @getIndex(i32* %19, i32 1)
	%21 = add nsw i32 %20, 1
	%22 = call i32 @setIndex(i32* %18, i32 1, i32 %21)
	call void @putint(i32 %22)
	call void @putstr(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.1, i64 0, i64 0))
	%23 = getelementptr inbounds [5 x i32], [5 x i32]* %7, i32 0, i32 0
	%24 = getelementptr inbounds [5 x i32], [5 x i32]* %1, i32 0, i32 0
	%25 = call i32 @getIndex(i32* %24, i32 2)
	%26 = add nsw i32 %25, 2
	%27 = call i32 @setIndex(i32* %23, i32 2, i32 %26)
	call void @putint(i32 %27)
	call void @putstr(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.2, i64 0, i64 0))
	%28 = getelementptr inbounds [5 x i32], [5 x i32]* %7, i32 0, i32 0
	%29 = getelementptr inbounds [5 x i32], [5 x i32]* %1, i32 0, i32 0
	%30 = call i32 @getIndex(i32* %29, i32 3)
	%31 = add nsw i32 %30, 3
	%32 = call i32 @setIndex(i32* %28, i32 3, i32 %31)
	call void @putint(i32 %32)
	call void @putstr(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.3, i64 0, i64 0))
	%33 = getelementptr inbounds [5 x i32], [5 x i32]* %7, i32 0, i32 0
	%34 = getelementptr inbounds [5 x i32], [5 x i32]* %1, i32 0, i32 0
	%35 = call i32 @getIndex(i32* %34, i32 4)
	%36 = add nsw i32 %35, 4
	%37 = call i32 @setIndex(i32* %33, i32 4, i32 %36)
	call void @putint(i32 %37)
	call void @putstr(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.4, i64 0, i64 0))
	%38 = getelementptr inbounds [5 x i32], [5 x i32]* %7, i32 0, i32 0
	%39 = call i32 @getIndex(i32* %38, i32 0)
	call void @putint(i32 %39)
	call void @putstr(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.5, i64 0, i64 0))
	%40 = getelementptr inbounds [5 x i32], [5 x i32]* %7, i32 0, i32 0
	%41 = call i32 @getIndex(i32* %40, i32 1)
	call void @putint(i32 %41)
	call void @putstr(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.6, i64 0, i64 0))
	%42 = getelementptr inbounds [5 x i32], [5 x i32]* %7, i32 0, i32 0
	%43 = call i32 @getIndex(i32* %42, i32 2)
	call void @putint(i32 %43)
	call void @putstr(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.7, i64 0, i64 0))
	%44 = getelementptr inbounds [5 x i32], [5 x i32]* %7, i32 0, i32 0
	%45 = call i32 @getIndex(i32* %44, i32 3)
	call void @putint(i32 %45)
	call void @putstr(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.8, i64 0, i64 0))
	%46 = getelementptr inbounds [5 x i32], [5 x i32]* %7, i32 0, i32 0
	%47 = call i32 @getIndex(i32* %46, i32 4)
	call void @putint(i32 %47)
	call void @putstr(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.9, i64 0, i64 0))
	ret i32 0
}
