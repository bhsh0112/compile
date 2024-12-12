declare i32 @getint()
declare i32 @getchar()
declare void @putint(i32)
declare void @putch(i32)
declare void @putstr(i8*)

@MAXINT = dso_local global i32 2147483647
@MININT = dso_local global i32 -2147483647
@MAXCHAR = dso_local global i8 126
@MINCHAR = dso_local global i8 32
@ZERO = dso_local global i32 0
@ONE = dso_local global i32 1
@TWO = dso_local global i32 2
@THREE = dso_local global i32 3
@FOUR = dso_local global i32 4
@FIVE = dso_local global i32 5
@SIX = dso_local global i32 6
@SEVEN = dso_local global i32 7
@EIGHT = dso_local global i32 8
@NINE = dso_local global i32 9
@TEN = dso_local global i32 10
@ZERO_TO_TEN = dso_local global [11 x i32] [i32 0,i32 1,i32 2,i32 3,i32 4,i32 5,i32 6,i32 7,i32 8,i32 9,i32 10]
@NO_USE1 = dso_local global [11 x i32] zeroinitializer
@NO_USE2 = dso_local global [11 x i32] [i32 0,i32 1,i32 2,i32 3,i32 0,i32 0,i32 0,i32 0,i32 0,i32 0,i32 0]
@A = dso_local global i8 65
@B = dso_local global i8 66
@C = dso_local global i8 67
@D = dso_local global i8 68
@E = dso_local global i8 69
@F = dso_local global i8 70
@G = dso_local global i8 71
@H = dso_local global i8 72
@I = dso_local global i8 73
@J = dso_local global i8 74
@ABCDEFGHIJ = dso_local global [11 x i8] [i8 65,i8 66,i8 67,i8 68,i8 69,i8 70,i8 71,i8 72,i8 73,i8 74,i8 0]
@NO_USE3 = dso_local global [11 x i8] zeroinitializer
@NO_USE4 = dso_local global [11 x i8] [i8 78,i8 79,i8 95,i8 85,i8 83,i8 69,i8 52,i8 0,i8 0,i8 0,i8 0]
@fibonacci = dso_local global [15 x i32] zeroinitializer
@.str = private unnamed_addr constant [17 x i8] c"Fibonacci Array \00", align 1
@.str.1 = private unnamed_addr constant [4 x i8] c" : \00", align 1
@.str.2 = private unnamed_addr constant [3 x i8] c"  \00", align 1
@.str.3 = private unnamed_addr constant [4 x i8] c" : \00", align 1
@.str.4 = private unnamed_addr constant [3 x i8] c"  \00", align 1
@.str.5 = private unnamed_addr constant [4 x i8] c" : \00", align 1
@.str.6 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.7 = private unnamed_addr constant [10 x i8] c"22371298\0A\00", align 1
@.str.8 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.9 = private unnamed_addr constant [3 x i8] c"a\0A\00", align 1
@.str.10 = private unnamed_addr constant [3 x i8] c"a\0A\00", align 1
@.str.11 = private unnamed_addr constant [3 x i8] c"a\0A\00", align 1
@.str.12 = private unnamed_addr constant [3 x i8] c"a\0A\00", align 1
@.str.13 = private unnamed_addr constant [3 x i8] c"a\0A\00", align 1
@.str.14 = private unnamed_addr constant [3 x i8] c"a\0A\00", align 1
@.str.15 = private unnamed_addr constant [3 x i8] c"a\0A\00", align 1
define dso_local void @cal_fibonacci() {
	%1 = getelementptr inbounds i32, i32* @fibonacci, i32 1
	store i32 1, i32* @fibonacci
	%2 = alloca i32
	store i32 2, i32* %2
	br label %3

3:
	%4 = load i32, i32* %2
	%5 = icmp slt i32 %4, 15
	br i1 %5, label %6, label %21

6:
	%7 = load i32, i32* %2
	%8 = getelementptr inbounds i32, i32* @fibonacci, i32 %7
	%9 = load i32, i32* %2
	%10 = sub nsw i32 %9, 1
	%11 = getelementptr inbounds [15 x i32], [15 x i32]* @fibonacci, i32 0, i32 %10
	%12 = load i32, i32* %11
	%13 = load i32, i32* %2
	%14 = sub nsw i32 %13, 2
	%15 = getelementptr inbounds [15 x i32], [15 x i32]* @fibonacci, i32 0, i32 %14
	%16 = load i32, i32* %15
	%17 = add nsw i32 %12, %16
	store i32 %17, i32* @fibonacci
	br label %18

18:
	%19 = load i32, i32* %2
	%20 = add nsw i32 %19, 1
	store i32 %20, i32* %2
	br label %3

21:
	ret void
}
define dso_local void @print_fibonacci_n(i32 %0, i32 %1, i32 %2) {
	%4 = alloca i32
	store i32 %0, i32* %4
	%5 = alloca i32
	store i32 %1, i32* %5
	%6 = alloca i32
	store i32 %2, i32* %6
	%7 = load i32, i32* %4
	%8 = load i32, i32* %4
	%9 = getelementptr inbounds [15 x i32], [15 x i32]* @fibonacci, i32 0, i32 %8
	%10 = load i32, i32* %9
	%11 = load i32, i32* %5
	%12 = load i32, i32* %5
	%13 = getelementptr inbounds [15 x i32], [15 x i32]* @fibonacci, i32 0, i32 %12
	%14 = load i32, i32* %13
	%15 = load i32, i32* %6
	%16 = load i32, i32* %6
	%17 = getelementptr inbounds [15 x i32], [15 x i32]* @fibonacci, i32 0, i32 %16
	%18 = load i32, i32* %17
	call void @putstr(i8* getelementptr inbounds ([17 x i8], [17 x i8]* @.str, i64 0, i64 0))
	call void @putint(i32 %7)
	call void @putstr(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.1, i64 0, i64 0))
	call void @putint(i32 %10)
	call void @putstr(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.2, i64 0, i64 0))
	call void @putint(i32 %11)
	call void @putstr(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.3, i64 0, i64 0))
	call void @putint(i32 %14)
	call void @putstr(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.4, i64 0, i64 0))
	call void @putint(i32 %15)
	call void @putstr(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.5, i64 0, i64 0))
	call void @putint(i32 %18)
	call void @putstr(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.6, i64 0, i64 0))
	ret void
}
define dso_local i32 @main() {
	call void @putstr(i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.7, i64 0, i64 0))
	%1 = alloca i32
	%2 = call i32 @getint()
	store i32 %2, i32* %1
	%3 = alloca i32
	%4 = call i32 @getint()
	store i32 %4, i32* %3
	%5 = alloca i32
	%6 = call i32 @getint()
	store i32 %6, i32* %5
	call void @cal_fibonacci()
	%7 = load i32, i32* %1
	%8 = icmp sgt i32 %7, 14
	br i1 %8, label %15, label %9

9:
	%10 = load i32, i32* %3
	%11 = icmp sgt i32 %10, 14
	br i1 %11, label %15, label %12

12:
	%13 = load i32, i32* %5
	%14 = icmp sgt i32 %13, 14
	br i1 %14, label %15, label %16

15:
	br label %20

16:
	%17 = load i32, i32* %1
	%18 = load i32, i32* %3
	%19 = load i32, i32* %5
	call void @print_fibonacci_n(i32 %17, i32 %18, i32 %19)
	br label %20

20:
	%21 = alloca i32
	%22 = load i32, i32* @MAXINT
	store i32 %22, i32* %21
	%23 = alloca i32
	%24 = load i32, i32* @TEN
	%25 = getelementptr inbounds [11 x i32], [11 x i32]* @ZERO_TO_TEN, i32 0, i32 %24
	%26 = load i32, i32* %25
	store i32 %26, i32* %23
	%27 = alloca i32
	store i32 1, i32* %27
	br label %28

28:
	%29 = load i32, i32* %27
	%30 = icmp slt i32 %29, 2
	br i1 %30, label %31, label %36

31:
	%32 = load i32, i32* %27
	call void @putint(i32 %32)
	call void @putstr(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.8, i64 0, i64 0))
	br label %33

33:
	%34 = load i32, i32* %27
	%35 = add nsw i32 %34, 1
	store i32 %35, i32* %27
	br label %28

36:
	store i32 2, i32* %27
	br label %37

37:
	%38 = load i32, i32* %27
	%39 = icmp eq i32 %38, 5
	br i1 %39, label %52, label %40

40:
	%41 = load i32, i32* %27
	%42 = icmp sle i32 %41, 6
	br i1 %42, label %52, label %43

43:
	%44 = load i32, i32* %27
	%45 = icmp sge i32 %44, 90
	br i1 %45, label %52, label %46

46:
	%47 = load i32, i32* %27
	%48 = icmp eq i32 %47, 100
	br i1 %48, label %52, label %49

49:
	%50 = load i32, i32* %27
	%51 = icmp ne i32 %50, 80
	br i1 %51, label %52, label %53

52:
	br label %57

53:
	br label %54

54:
	%55 = load i32, i32* %27
	%56 = add nsw i32 %55, 1
	store i32 %56, i32* %27
	br label %37

57:
	br label %58

58:
	%59 = load i32, i32* %27
	%60 = icmp ne i32 %59, 90
	br i1 %60, label %61, label %62

61:
	br label %63

62:
	br label %58

63:
	store i32 100, i32* %27
	br label %64

64:
	%65 = load i32, i32* %27
	%66 = icmp sgt i32 %65, 10
	br i1 %66, label %67, label %68

67:
	br label %72

68:
	br label %69

69:
	%70 = load i32, i32* %27
	%71 = add nsw i32 %70, 1
	store i32 %71, i32* %27
	br label %64

72:
	br label %73

73:
	%74 = load i32, i32* %27
	%75 = icmp sgt i32 %74, 50
	br i1 %75, label %76, label %88

76:
	%77 = load i32, i32* %27
	%78 = icmp sgt i32 %77, 80
	br i1 %78, label %79, label %82

79:
	%80 = load i32, i32* %27
	%81 = icmp slt i32 %80, 120
	br i1 %81, label %85, label %82

82:
	%83 = load i32, i32* %27
	%84 = icmp eq i32 %83, 100
	br i1 %84, label %85, label %86

85:
	br label %88

86:
	br label %73

87:
	br label %73

88:
	store i32 100, i32* %27
	br label %89

89:
	%90 = load i32, i32* %27
	%91 = icmp eq i32 %90, 100
	br i1 %91, label %92, label %93

92:
	br label %95

93:
	br label %89

94:
	br label %89

95:
	br label %96

96:
	%97 = icmp ne i32 1, 0
	br i1 %97, label %98, label %99

98:
	br label %100

99:
	br label %96

100:
	%101 = alloca i8
	%102 = call i32 @getchar()
	%103 = trunc i32 %102 to i8
	store i8 %103, i8* %101
	call void @putstr(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.9, i64 0, i64 0))
	call void @putstr(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.10, i64 0, i64 0))
	call void @putstr(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.11, i64 0, i64 0))
	call void @putstr(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.12, i64 0, i64 0))
	call void @putstr(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.13, i64 0, i64 0))
	call void @putstr(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.14, i64 0, i64 0))
	call void @putstr(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.15, i64 0, i64 0))
	ret i32 0
}
