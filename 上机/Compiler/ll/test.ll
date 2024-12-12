declare i32 @getint()
declare i32 @getchar()
declare void @putint(i32)
declare void @putch(i32)
declare void @putstr(i8*)

@a1 = dso_local global [10 x i32] zeroinitializer
@a2 = dso_local global [5 x i32] zeroinitializer
@a3 = dso_local global [5 x i32] zeroinitializer
@a4 = dso_local global [5 x i32] [i32 1,i32 2,i32 3,i32 0,i32 0]
@c1 = dso_local global [10 x i8] zeroinitializer
@c2 = dso_local global [5 x i8] zeroinitializer
@c3 = dso_local global [5 x i8] zeroinitializer
@c4 = dso_local global [5 x i8] [i8 104,i8 101,i8 121,i8 0,i8 0]
@c5 = dso_local global [10 x i8] [i8 104,i8 101,i8 108,i8 108,i8 111,i8 92,i8 0,i8 0,i8 0,i8 0]
@.str = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.1 = private unnamed_addr constant [10 x i8] c"21374275\0A\00", align 1
@.str.2 = private unnamed_addr constant [7 x i8] c"sum = \00", align 1
@.str.3 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.4 = private unnamed_addr constant [9 x i8] c"c4[0] = \00", align 1
@.str.5 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.6 = private unnamed_addr constant [9 x i8] c"c5[0] = \00", align 1
@.str.7 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.8 = private unnamed_addr constant [5 x i8] c"t = \00", align 1
@.str.9 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.10 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.11 = private unnamed_addr constant [11 x i8] c"sum + 1 = \00", align 1
@.str.12 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
define dso_local i32 @f1(i32* %0, i32 %1) {
	%3 = alloca i32*
	store i32* %0, i32** %3
	%4 = alloca i32
	store i32 %1, i32* %4
	%5 = alloca i32
	store i32 0, i32* %5
	%6 = alloca i32
	store i32 0, i32* %6
	br label %7

7:
	%8 = load i32, i32* %6
	%9 = load i32, i32* %4
	%10 = icmp slt i32 %8, %9
	br i1 %10, label %11, label %21

11:
	%12 = load i32, i32* %6
	%13 = load i32*, i32** %3
	%14 = getelementptr inbounds i32, i32* %13, i32 %12
	%15 = load i32, i32* %14
	%16 = load i32, i32* %5
	%17 = add nsw i32 %16, %15
	store i32 %17, i32* %5
	br label %18

18:
	%19 = load i32, i32* %6
	%20 = add nsw i32 %19, 1
	store i32 %20, i32* %6
	br label %7

21:
	%22 = load i32, i32* %5
	ret i32 %22
}
define dso_local i32 @f2(i32 %0) {
	%2 = alloca i32
	store i32 %0, i32* %2
	%3 = load i32, i32* %2
	%4 = icmp eq i32 %3, 1
	br i1 %4, label %5, label %6

5:
	ret i32 1

6:
	%7 = load i32, i32* %2
	%8 = icmp eq i32 %7, 2
	br i1 %8, label %9, label %10

9:
	ret i32 1

10:
	%11 = load i32, i32* %2
	%12 = sub nsw i32 %11, 1
	%13 = call i32 @f2(i32 %12)
	%14 = load i32, i32* %2
	%15 = sub nsw i32 %14, 2
	%16 = call i32 @f2(i32 %15)
	%17 = add nsw i32 %13, %16
	ret i32 %17

18:
	br label %19

19:
	ret i32 -1
}
define dso_local void @f3(i8* %0) {
	%2 = alloca i8*
	store i8* %0, i8** %2
	%3 = load i8*, i8** %2
	%4 = getelementptr inbounds i8, i8* %3, i32 0
	%5 = load i8, i8* %4
	%6 = zext i8 %5 to i32
	call void @putch(i32 %6)
	call void @putstr(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str, i64 0, i64 0))
	ret void
}
define dso_local i32 @f4(i32* %0, i32* %1, i32 %2) {
	%4 = alloca i32*
	store i32* %0, i32** %4
	%5 = alloca i32*
	store i32* %1, i32** %5
	%6 = alloca i32
	store i32 %2, i32* %6
	%7 = alloca i32
	%8 = alloca i32
	store i32 0, i32* %8
	store i32 0, i32* %7
	br label %9

9:
	%10 = load i32, i32* %7
	%11 = load i32, i32* %6
	%12 = icmp slt i32 %10, %11
	br i1 %12, label %13, label %28

13:
	%14 = load i32, i32* %7
	%15 = load i32*, i32** %4
	%16 = getelementptr inbounds i32, i32* %15, i32 %14
	%17 = load i32, i32* %16
	%18 = load i32, i32* %7
	%19 = load i32*, i32** %5
	%20 = getelementptr inbounds i32, i32* %19, i32 %18
	%21 = load i32, i32* %20
	%22 = load i32, i32* %8
	%23 = mul nsw i32 %17, %21
	%24 = add nsw i32 %22, %23
	store i32 %24, i32* %8
	br label %25

25:
	%26 = load i32, i32* %7
	%27 = add nsw i32 %26, 1
	store i32 %27, i32* %7
	br label %9

28:
	%29 = load i32, i32* %8
	ret i32 %29
}
define dso_local i32 @main() {
	%1 = alloca i32
	call void @putstr(i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.1, i64 0, i64 0))
	%2 = getelementptr inbounds i32, i32* @a4, i32 3
	store i32 4, i32* %2
	%3 = getelementptr inbounds i32, i32* @a4, i32 4
	store i32 5, i32* %3
	%4 = alloca i32
	%5 = call i32 @f1(i32* @a4, i32 5)
	store i32 %5, i32* %4
	%6 = load i32, i32* %4
	call void @putstr(i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.2, i64 0, i64 0))
	call void @putint(i32 %6)
	call void @putstr(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.3, i64 0, i64 0))
	%7 = getelementptr inbounds [5 x i8], [5 x i8]* @c4, i32 0, i32 0
	%8 = load i8, i8* %7
	call void @putstr(i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.4, i64 0, i64 0))
	%9 = zext i8 %8 to i32
	call void @putch(i32 %9)
	call void @putstr(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.5, i64 0, i64 0))
	%10 = getelementptr inbounds [10 x i8], [10 x i8]* @c5, i32 0, i32 0
	%11 = load i8, i8* %10
	call void @putstr(i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.6, i64 0, i64 0))
	%12 = zext i8 %11 to i32
	call void @putch(i32 %12)
	call void @putstr(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.7, i64 0, i64 0))
	%13 = alloca i32
	store i32 100, i32* %13
	%14 = load i32, i32* %13
	%15 = add nsw i32 %14, 1
	%16 = srem i32 %15, 25
	%17 = mul nsw i32 %16, 5
	%18 = sub nsw i32 %17, 1
	store i32 %18, i32* %13
	%19 = load i32, i32* %13
	call void @putstr(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.8, i64 0, i64 0))
	call void @putint(i32 %19)
	call void @putstr(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.9, i64 0, i64 0))
	%20 = call i32 @f2(i32 10)
	store i32 %20, i32* %13
	%21 = load i32, i32* %13
	call void @putint(i32 %21)
	call void @putstr(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.10, i64 0, i64 0))
	%22 = alloca [10 x i8]
	%23 = getelementptr inbounds [10 x i8], [10 x i8]* %22, i32 0, i32 0
	store i8 49, i8* %23
	%24 = getelementptr inbounds [10 x i8], [10 x i8]* %23, i32 0, i32 1
	store i8 50, i8* %24
	%25 = getelementptr inbounds [10 x i8], [10 x i8]* %24, i32 0, i32 2
	store i8 51, i8* %25
	%26 = getelementptr inbounds [10 x i8], [10 x i8]* %25, i32 0, i32 3
	store i8 52, i8* %26
	%27 = getelementptr inbounds [10 x i8], [10 x i8]* %26, i32 0, i32 4
	store i8 53, i8* %27
	%28 = getelementptr inbounds [10 x i8], [10 x i8]* %27, i32 0, i32 5
	store i8 54, i8* %28
	%29 = getelementptr inbounds [10 x i8], [10 x i8]* %22, i32 0, i32 0
	call void @f3(i8* %29)
	call void @f3(i8* @c4)
	call void @f3(i8* @c5)
	%30 = alloca [3 x i32]
	%31 = getelementptr inbounds [3 x i32], [3 x i32]* %30, i32 0, i32 0
	store i32 2, i32* %31
	%32 = getelementptr inbounds i32, i32* %31, i32 1
	store i32 3, i32* %32
	%33 = getelementptr inbounds i32, i32* %32, i32 1
	store i32 4, i32* %33
	%34 = alloca [3 x i32]
	%35 = getelementptr inbounds [3 x i32], [3 x i32]* %34, i32 0, i32 0
	store i32 1, i32* %35
	%36 = getelementptr inbounds i32, i32* %35, i32 1
	store i32 5, i32* %36
	%37 = getelementptr inbounds i32, i32* %36, i32 1
	store i32 7, i32* %37
	%38 = getelementptr inbounds [3 x i32], [3 x i32]* %30, i32 0, i32 0
	%39 = getelementptr inbounds [3 x i32], [3 x i32]* %34, i32 0, i32 0
	%40 = getelementptr inbounds [3 x i32], [3 x i32]* %30, i32 0, i32 1
	%41 = load i32, i32* %40
	%42 = call i32 @f4(i32* %38, i32* %39, i32 %41)
	%43 = add nsw i32 %42, 1
	call void @putstr(i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.11, i64 0, i64 0))
	call void @putint(i32 %43)
	call void @putstr(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.12, i64 0, i64 0))
	ret i32 0
}
