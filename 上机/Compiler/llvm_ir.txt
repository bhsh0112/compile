declare i32 @getint()
declare i32 @getchar()
declare void @putint(i32)
declare void @putch(i32)
declare void @putstr(i8*)

@constA = dso_local global i32 1
@constB = dso_local global i32 2
@constC = dso_local global i32 3
@constD = dso_local global [5 x i32] [i32 1,i32 2,i32 3,i32 4,i32 5]
@a1 = dso_local global i8 97
@a2 = dso_local global i8 98
@a3 = dso_local global i8 99
@a4 = dso_local global [6 x i8] [i8 97,i8 98,i8 99,i8 100,i8 101,i8 0]
@.str = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.1 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.2 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.3 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.4 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.5 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.6 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.7 = private unnamed_addr constant [10 x i8] c"22372468\0A\00", align 1
@.str.8 = private unnamed_addr constant [2 x i8] c" \00", align 1
@.str.9 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.10 = private unnamed_addr constant [2 x i8] c" \00", align 1
@.str.11 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
define dso_local void @funcA() {
	ret void
}
define dso_local i32 @funcB() {
	%1 = alloca i32
	store i32 0, i32* %1
	%2 = alloca i32
	store i32 0, i32* %2
	store i32 0, i32* %2
	br label %3

3:
	%4 = load i32, i32* %2
	%5 = icmp slt i32 %4, 5
	br i1 %5, label %6, label %13

6:
	%7 = load i32, i32* %1
	%8 = load i32, i32* %2
	%9 = add nsw i32 %7, %8
	store i32 %9, i32* %1
	br label %10

10:
	%11 = load i32, i32* %2
	%12 = add nsw i32 %11, 1
	store i32 %12, i32* %2
	br label %3

13:
	%14 = load i32, i32* %1
	call void @putint(i32 %14)
	call void @putstr(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str, i64 0, i64 0))
	store i32 0, i32* %2
	br label %15

15:
	%16 = load i32, i32* %2
	%17 = icmp slt i32 %16, 5
	br i1 %17, label %18, label %25

18:
	%19 = load i32, i32* %1
	%20 = load i32, i32* %2
	%21 = add nsw i32 %19, %20
	store i32 %21, i32* %1
	br label %22

22:
	%23 = load i32, i32* %2
	%24 = add nsw i32 %23, 1
	store i32 %24, i32* %2
	br label %15

25:
	store i32 0, i32* %2
	br label %26

26:
	%27 = load i32, i32* %1
	%28 = load i32, i32* %2
	%29 = add nsw i32 %27, %28
	store i32 %29, i32* %1
	%30 = load i32, i32* %1
	%31 = icmp sgt i32 %30, 25
	br i1 %31, label %32, label %33

32:
	br label %38

33:
	br label %35

34:
	br label %35

35:
	%36 = load i32, i32* %2
	%37 = add nsw i32 %36, 1
	store i32 %37, i32* %2
	br label %26

38:
	store i32 1, i32* %2
	br label %39

39:
	%40 = load i32, i32* %2
	%41 = icmp slt i32 %40, 5
	br i1 %41, label %42, label %50

42:
	%43 = load i32, i32* %1
	%44 = load i32, i32* %2
	%45 = add nsw i32 %43, %44
	store i32 %45, i32* %1
	%46 = load i32, i32* %1
	%47 = icmp sgt i32 %46, 30
	br i1 %47, label %48, label %49

48:
	br label %50

49:
	br label %39

50:
	%51 = load i32, i32* %1
	call void @putint(i32 %51)
	call void @putstr(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.1, i64 0, i64 0))
	store i32 0, i32* %2
	br label %52

52:
	%53 = load i32, i32* %1
	%54 = load i32, i32* %2
	%55 = add nsw i32 %53, %54
	store i32 %55, i32* %1
	%56 = load i32, i32* %1
	%57 = icmp sgt i32 %56, 35
	br i1 %57, label %58, label %59

58:
	br label %63

59:
	br label %60

60:
	%61 = load i32, i32* %2
	%62 = add nsw i32 %61, 1
	store i32 %62, i32* %2
	br label %52

63:
	br label %64

64:
	%65 = load i32, i32* %2
	%66 = icmp slt i32 %65, 5
	br i1 %66, label %67, label %74

67:
	%68 = load i32, i32* %1
	%69 = add nsw i32 %68, 1
	store i32 %69, i32* %1
	%70 = load i32, i32* %1
	%71 = icmp sgt i32 %70, 40
	br i1 %71, label %72, label %73

72:
	br label %74

73:
	br label %64

74:
	store i32 1, i32* %2
	br label %75

75:
	%76 = load i32, i32* %1
	%77 = load i32, i32* %2
	%78 = add nsw i32 %76, %77
	store i32 %78, i32* %1
	%79 = load i32, i32* %1
	%80 = icmp sgt i32 %79, 45
	br i1 %80, label %81, label %82

81:
	br label %83

82:
	br label %75

83:
	%84 = load i32, i32* %1
	call void @putint(i32 %84)
	call void @putstr(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.2, i64 0, i64 0))
	br label %85

85:
	%86 = load i32, i32* %1
	%87 = add nsw i32 %86, 2
	store i32 %87, i32* %1
	%88 = load i32, i32* %1
	%89 = icmp sgt i32 %88, 50
	br i1 %89, label %90, label %91

90:
	br label %92

91:
	br label %85

92:
	%93 = load i32, i32* %1
	call void @putint(i32 %93)
	call void @putstr(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.3, i64 0, i64 0))
	%94 = load i32, i32* %1
	ret i32 %94
}
define dso_local i8 @funcC() {
	%1 = alloca i8
	store i8 92, i8* %1
	%2 = load i32, i32* @constB
	%3 = load i32, i32* @constA
	%4 = add nsw i32 %3, 1
	%5 = icmp sge i32 %2, %4
	br i1 %5, label %6, label %14

6:
	%7 = load i32, i32* @constC
	%8 = load i32, i32* @constB
	%9 = add nsw i32 %8, 1
	%10 = icmp sge i32 %7, %9
	br i1 %10, label %11, label %13

11:
	%12 = load i8, i8* @a1
	store i8 %12, i8* %1
	br label %13

13:
	br label %16

14:
	%15 = load i8, i8* @a2
	store i8 %15, i8* %1
	br label %16

16:
	%17 = load i32, i32* @constC
	%18 = icmp ne i32 %17, 3
	br i1 %18, label %19, label %25

19:
	%20 = load i32, i32* @constB
	%21 = icmp slt i32 %20, 3
	br i1 %21, label %22, label %24

22:
	%23 = load i8, i8* @a3
	store i8 %23, i8* %1
	br label %24

24:
	br label %25

25:
	%26 = load i8, i8* %1
	ret i8 %26
}
define dso_local void @funcD(i8* %0) {
	%2 = alloca i8*
	store i8* %0, i8** %2
	%3 = load i8*, i8** %2
	%4 = getelementptr inbounds i8, i8* %3, i32 0
	%5 = load i8, i8* %4
	%6 = zext i8 %5 to i32
	call void @putch(i32 %6)
	call void @putstr(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.4, i64 0, i64 0))
	ret void
}
define dso_local void @funcE(i32 %0, i32 %1) {
	%3 = alloca i32
	store i32 %0, i32* %3
	%4 = alloca i32
	store i32 %1, i32* %4
	%5 = load i32, i32* %3
	%6 = load i32, i32* %4
	%7 = icmp eq i32 %5, %6
	br i1 %7, label %8, label %12

8:
	%9 = load i32, i32* %3
	%10 = load i32, i32* %4
	%11 = add nsw i32 %9, %10
	call void @putint(i32 %11)
	call void @putstr(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.5, i64 0, i64 0))
	br label %12

12:
	%13 = load i32, i32* %3
	%14 = load i32, i32* %4
	%15 = icmp ne i32 %13, %14
	br i1 %15, label %16, label %20

16:
	%17 = load i32, i32* %3
	%18 = load i32, i32* %4
	%19 = mul nsw i32 %17, %18
	call void @putint(i32 %19)
	call void @putstr(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.6, i64 0, i64 0))
	br label %20

20:
	ret void
}
define dso_local i32 @main() {
	call void @putstr(i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.7, i64 0, i64 0))
	%1 = alloca i32
	store i32 0, i32* %1
	%2 = alloca i8
	store i8 92, i8* %2
	%3 = call i32 @getint()
	store i32 %3, i32* %1
	%4 = call i32 @getchar()
	%5 = trunc i32 %4 to i8
	store i8 %5, i8* %2
	%6 = load i32, i32* %1
	%7 = load i8, i8* %2
	call void @putint(i32 %6)
	call void @putstr(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.8, i64 0, i64 0))
	%8 = zext i8 %7 to i32
	call void @putch(i32 %8)
	call void @putstr(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.9, i64 0, i64 0))
	call void @funcA()
	%9 = alloca i32
	%10 = call i32 @funcB()
	%11 = load i32, i32* %1
	%12 = mul nsw i32 %11, 10
	%13 = sdiv i32 %10, 2
	%14 = add nsw i32 %12, %13
	%15 = sub nsw i32 %14, 1
	%16 = srem i32 %15, 7
	store i32 %16, i32* %9
	%17 = alloca i8
	%18 = call i8 @funcC()
	store i8 %18, i8* %17
	%19 = load i32, i32* %9
	%20 = load i8, i8* %17
	call void @putint(i32 %19)
	call void @putstr(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.10, i64 0, i64 0))
	%21 = zext i8 %20 to i32
	call void @putch(i32 %21)
	call void @putstr(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.11, i64 0, i64 0))
	%22 = getelementptr inbounds i8, i8* @a4, i32 0
	store i8 122, i8* %22
	call void @funcD(i8* @a4)
	%23 = load i32, i32* @constA
	%24 = load i32, i32* @constB
	call void @funcE(i32 %23, i32 %24)
	%25 = load i32, i32* @constA
	%26 = load i32, i32* @constB
	call void @funcE(i32 %25, i32 %26)
	ret i32 0
}
