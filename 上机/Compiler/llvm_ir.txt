declare i32 @getint()
declare i32 @getchar()
declare void @putint(i32)
declare void @putch(i32)
declare void @putstr(i8*)

@next = dso_local global [8 x i32] [i32 1,i32 0,i32 0,i32 -1,i32 -1,i32 0,i32 0,i32 1]
@len = dso_local global i32 3
@xxx = dso_local global [2 x i32] [i32 1,i32 2]
@ans = dso_local global i32 0
@arr = dso_local global [2 x i32] [i32 3,i32 1]
@.str = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.1 = private unnamed_addr constant [7 x i8] c"Hello \00", align 1
@.str.2 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.3 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.4 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.5 = private unnamed_addr constant [14 x i8] c"judgeB 2,3 = \00", align 1
@.str.6 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
define dso_local i32 @getDif3N(i32 %0, i32 %1) {
	%3 = alloca i32
	store i32 %0, i32* %3
	%4 = alloca i32
	store i32 %1, i32* %4
	%5 = alloca i32
	store i32 1, i32* %5
	%6 = alloca i32
	store i32 1, i32* %6
	%7 = alloca i32
	store i32 1, i32* %7
	%8 = alloca i32
	store i32 0, i32* %8
	%9 = alloca [2 x i32]
	%10 = getelementptr inbounds [2 x i32], [2 x i32]* %9, i32 0, i32 0
	store i32 1, i32* %10
	%11 = getelementptr inbounds i32, i32* %10, i32 1
	store i32 2, i32* %11
	br label %12

12:
	%13 = load i32, i32* %5
	%14 = icmp sle i32 %13, 3
	br i1 %14, label %15, label %47

15:
	store i32 1, i32* %6
	br label %16

16:
	%17 = load i32, i32* %6
	%18 = icmp sle i32 %17, 3
	br i1 %18, label %19, label %44

19:
	store i32 1, i32* %7
	br label %20

20:
	%21 = load i32, i32* %7
	%22 = icmp sle i32 %21, 3
	br i1 %22, label %23, label %41

23:
	%24 = load i32, i32* %5
	%25 = load i32, i32* %6
	%26 = icmp ne i32 %24, %25
	br i1 %26, label %27, label %38

27:
	%28 = load i32, i32* %5
	%29 = load i32, i32* %7
	%30 = icmp ne i32 %28, %29
	br i1 %30, label %31, label %38

31:
	%32 = load i32, i32* %6
	%33 = load i32, i32* %7
	%34 = icmp ne i32 %32, %33
	br i1 %34, label %35, label %38

35:
	%36 = load i32, i32* %8
	%37 = add nsw i32 %36, 1
	store i32 %37, i32* %8
	br label %38

38:
	%39 = load i32, i32* %7
	%40 = add nsw i32 %39, 1
	store i32 %40, i32* %7
	br label %20

41:
	%42 = load i32, i32* %6
	%43 = add nsw i32 %42, 1
	store i32 %43, i32* %6
	br label %16

44:
	%45 = load i32, i32* %5
	%46 = add nsw i32 %45, 1
	store i32 %46, i32* %5
	br label %12

47:
	%48 = load i32, i32* %8
	ret i32 %48
}
define dso_local i32 @judgeB(i32 %0, i32 %1) {
	%3 = alloca i32
	store i32 %0, i32* %3
	%4 = alloca i32
	store i32 %1, i32* %4
	%5 = load i32, i32* %3
	%6 = load i32, i32* %4
	%7 = icmp sle i32 %5, %6
	br i1 %7, label %8, label %23

8:
	%9 = load i32, i32* %3
	%10 = load i32, i32* %4
	%11 = icmp slt i32 %9, %10
	br i1 %11, label %12, label %16

12:
	%13 = load i32, i32* %3
	%14 = load i32, i32* %4
	%15 = sub nsw i32 %13, %14
	ret i32 %15

16:
	%17 = load i32, i32* %3
	%18 = load i32, i32* %4
	%19 = icmp eq i32 %17, %18
	br i1 %19, label %20, label %21

20:
	ret i32 0

21:
	br label %22

22:
	br label %43

23:
	%24 = load i32, i32* %3
	%25 = load i32, i32* %4
	%26 = icmp sge i32 %24, %25
	br i1 %26, label %27, label %42

27:
	%28 = load i32, i32* %3
	%29 = load i32, i32* %4
	%30 = icmp sgt i32 %28, %29
	br i1 %30, label %31, label %35

31:
	%32 = load i32, i32* %3
	%33 = load i32, i32* %4
	%34 = sub nsw i32 %32, %33
	ret i32 %34

35:
	%36 = load i32, i32* %3
	%37 = load i32, i32* %4
	%38 = icmp eq i32 %36, %37
	br i1 %38, label %39, label %40

39:
	ret i32 0

40:
	br label %41

41:
	br label %42

42:
	br label %43

43:
	ret i32 0
}
define dso_local void @printArr(i32* %0) {
	%2 = alloca i32*
	store i32* %0, i32** %2
	%3 = alloca i32
	store i32 0, i32* %3
	br label %4

4:
	%5 = load i32, i32* %3
	%6 = icmp slt i32 %5, 2
	br i1 %6, label %7, label %14

7:
	%8 = load i32, i32* %3
	%9 = load i32*, i32** %2
	%10 = getelementptr inbounds i32, i32* %9, i32 %8
	%11 = load i32, i32* %10
	call void @putint(i32 %11)
	%12 = load i32, i32* %3
	%13 = add nsw i32 %12, 1
	store i32 %13, i32* %3
	br label %4

14:
	call void @putstr(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str, i64 0, i64 0))
	ret void
}
define dso_local void @printHello() {
	%1 = alloca i32
	%2 = call i32 @getint()
	store i32 %2, i32* %1
	%3 = load i32, i32* %1
	call void @putstr(i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.1, i64 0, i64 0))
	call void @putint(i32 %3)
	call void @putstr(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.2, i64 0, i64 0))
	ret void
}
define dso_local i32 @add(i32 %0) {
	%2 = alloca i32
	store i32 %0, i32* %2
	%3 = alloca i32
	%4 = load i32, i32* %2
	%5 = add nsw i32 %4, 3
	store i32 %5, i32* %3
	%6 = load i32, i32* %3
	ret i32 %6
}
define dso_local void @opp() {
	ret void
}
define dso_local i32 @main() {
	%1 = alloca i32
	store i32 3, i32* %1
	%2 = alloca i32
	store i32 0, i32* %2
	%3 = alloca i32
	store i32 1, i32* %3
	%4 = load i32, i32* %3
	%5 = icmp ne i32 %4, 0
	br i1 %5, label %7, label %6

6:
	store i32 0, i32* %3
	br label %7

7:
	store i32 1, i32* %3
	store i32 -1, i32* %3
	%8 = alloca i32
	%9 = getelementptr inbounds [8 x i32], [8 x i32]* @next, i32 0, i32 0
	%10 = load i32, i32* %9
	%11 = load i32, i32* %2
	%12 = add nsw i32 %11, 1
	%13 = sdiv i32 18, %12
	%14 = sub nsw i32 %13, 14
	%15 = add nsw i32 %14, %10
	store i32 %15, i32* %8
	br label %16

16:
	%17 = load i32, i32* %2
	%18 = icmp sle i32 %17, 5
	br i1 %18, label %19, label %35

19:
	%20 = load i32, i32* %2
	%21 = icmp eq i32 %20, 3
	br i1 %21, label %22, label %25

22:
	%23 = load i32, i32* %2
	%24 = add nsw i32 %23, 1
	store i32 %24, i32* %2
	br label %16

25:
	%26 = load i32, i32* %2
	%27 = icmp eq i32 %26, 5
	br i1 %27, label %28, label %29

28:
	br label %35

29:
	%30 = alloca i32
	%31 = load i32, i32* %2
	store i32 %31, i32* %30
	br label %32

32:
	%33 = load i32, i32* %2
	%34 = add nsw i32 %33, 1
	store i32 %34, i32* %2
	br label %16

35:
	%36 = call i32 @getint()
	store i32 %36, i32* %1
	%37 = load i32, i32* %1
	%38 = call i32 @add(i32 %37)
	call void @putint(i32 %38)
	call void @putstr(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.3, i64 0, i64 0))
	%39 = call i32 @getDif3N(i32 1, i32 999)
	store i32 %39, i32* %1
	%40 = load i32, i32* %1
	call void @putint(i32 %40)
	call void @putstr(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.4, i64 0, i64 0))
	%41 = call i32 @judgeB(i32 2, i32 3)
	store i32 %41, i32* %1
	%42 = load i32, i32* %1
	call void @putstr(i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.5, i64 0, i64 0))
	call void @putint(i32 %42)
	call void @putstr(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.6, i64 0, i64 0))
	call void @printHello()
	%43 = getelementptr inbounds [2 x i32], [2 x i32]* @arr, i32 0, i32 0
	call void @printArr(i32* %43)
	ret i32 0
}
