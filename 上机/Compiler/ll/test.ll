
declare i32 @getint()
declare i32 @getchar()
declare void @putint(i32)
declare void @putch(i32)
declare void @putstr(i8*)

@a1 = dso_local global i32 1
@a2 = dso_local global i32 3
@a3 = dso_local global i32 8
@b1 = dso_local global i32 2
@b2 = dso_local global i32 -5
@b3 = dso_local global i32 6
@str = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@str.1 = private unnamed_addr constant [15 x i8] c"+ is correct!\0A\00", align 1
@str.2 = private unnamed_addr constant [13 x i8] c"+ is error!\0A\00", align 1
@str.3 = private unnamed_addr constant [17 x i8] c"Break is error!\0A\00", align 1
@str.4 = private unnamed_addr constant [20 x i8] c"Continue is error!\0A\00", align 1
@str.5 = private unnamed_addr constant [10 x i8] c"a1+b1 is \00", align 1
@str.6 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@str.7 = private unnamed_addr constant [10 x i8] c"a2+b2 is \00", align 1
@str.8 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
define dso_local i32 @main() {
	call void @putstr(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @str, i64 0, i64 0))
	%1 = alloca i32
	store i32 10, i32* %1
	br label %2

2:
	%3 = load i32, i32* %1
	%4 = icmp ne i32 %3, 0
	br i1 %4, label %5, label %29

5:
	%6 = load i32, i32* %1
	%7 = sub nsw i32 %6, 1
	store i32 %7, i32* %1
	%8 = load i32, i32* %1
	%9 = load i32, i32* @b3
	%10 = icmp slt i32 %8, %9
	br i1 %10, label %11, label %12

11:
	br label %2

12:
	%13 = load i32, i32* %1
	%14 = load i32, i32* @a1
	%15 = icmp slt i32 %13, %14
	br i1 %15, label %16, label %17

16:
	br label %29

17:
	%18 = load i32, i32* %1
	%19 = load i32, i32* @a2
	%20 = icmp eq i32 %18, %19
	br i1 %20, label %21, label %22

21:
	call void @putstr(i8* getelementptr inbounds ([15 x i8], [15 x i8]* @str.1, i64 0, i64 0))
	br label %23

22:
	call void @putstr(i8* getelementptr inbounds ([13 x i8], [13 x i8]* @str.2, i64 0, i64 0))
	br label %23

23:
	%24 = load i32, i32* %1
	%25 = load i32, i32* @b1
	%26 = icmp eq i32 %24, %25
	br i1 %26, label %27, label %28

27:
	br label %29

28:
	br label %2

29:
	%30 = load i32, i32* %1
	%31 = load i32, i32* @b1
	%32 = icmp ne i32 %30, %31
	br i1 %32, label %33, label %39

33:
	%34 = load i32, i32* %1
	%35 = icmp eq i32 %34, 0
	br i1 %35, label %36, label %37

36:
	call void @putstr(i8* getelementptr inbounds ([17 x i8], [17 x i8]* @str.3, i64 0, i64 0))
	br label %38

37:
	call void @putstr(i8* getelementptr inbounds ([20 x i8], [20 x i8]* @str.4, i64 0, i64 0))
	br label %38

38:
	br label %39

39:
	%40 = load i32, i32* @a1
	%41 = load i32, i32* @b1
	%42 = add nsw i32 %40, %41
	call void @putstr(i8* getelementptr inbounds ([10 x i8], [10 x i8]* @str.5, i64 0, i64 0))
	call void @putint(i32 %42)
	call void @putstr(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @str.6, i64 0, i64 0))
	%43 = load i32, i32* @a2
	%44 = load i32, i32* @b2
	%45 = add nsw i32 %43, %44
	call void @putstr(i8* getelementptr inbounds ([10 x i8], [10 x i8]* @str.7, i64 0, i64 0))
	call void @putint(i32 %45)
	call void @putstr(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @str.8, i64 0, i64 0))
	ret i32 0
}
