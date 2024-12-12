declare i32 @getint()
declare i32 @getchar()
declare void @putint(i32)
declare void @putch(i32)
declare void @putstr(i8*)

@MAX_SIZE = dso_local global i32 10
@global_var = dso_local global i32 zeroinitializer
@str = dso_local global [10 x i8] [i8 51,i8 92,i8 0,i8 0,i8 0,i8 0,i8 0,i8 0,i8 0,i8 0]
@.str = private unnamed_addr constant [10 x i8] c"22373040\0A\00", align 1
@.str.1 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.2 = private unnamed_addr constant [16 x i8] c"Input integer: \00", align 1
@.str.3 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.4 = private unnamed_addr constant [18 x i8] c"Input character: \00", align 1
@.str.5 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.6 = private unnamed_addr constant [14 x i8] c"i is 4 or 9!\0A\00", align 1
@.str.7 = private unnamed_addr constant [10 x i8] c"j is 32!\0A\00", align 1
@.str.8 = private unnamed_addr constant [24 x i8] c"Sum of array elements: \00", align 1
@.str.9 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.10 = private unnamed_addr constant [16 x i8] c"Test finished!\0A\00", align 1
define dso_local i32 @add(i32 %0, i32 %1) {
	%3 = alloca i32
	store i32 %0, i32* %3
	%4 = alloca i32
	store i32 %1, i32* %4
	%5 = load i32, i32* %3
	%6 = load i32, i32* %4
	%7 = add nsw i32 %5, %6
	ret i32 %7
}
define dso_local i32 @calculate(i32 %0, i32* %1) {
	%3 = alloca i32
	store i32 %0, i32* %3
	%4 = alloca i32*
	store i32* %1, i32** %4
	%5 = alloca i32
	%6 = load i32, i32* %3
	%7 = load i32*, i32** %4
	%8 = getelementptr inbounds i32, i32* %7, i32 0
	%9 = load i32, i32* %8
	%10 = call i32 @add(i32 %6, i32 %9)
	%11 = load i32*, i32** %4
	%12 = getelementptr inbounds i32, i32* %11, i32 1
	%13 = load i32, i32* %12
	%14 = load i32*, i32** %4
	%15 = getelementptr inbounds i32, i32* %14, i32 2
	%16 = load i32, i32* %15
	%17 = load i32, i32* %3
	%18 = sub nsw i32 %17, %13
	%19 = mul nsw i32 %10, %18
	%20 = sdiv i32 %19, %16	%21 = load i32, i32* %3
	%22 = srem i32 %20, %21
	%23 = sub nsw i32 %22, -3
	%24 = add nsw i32 %23, 6
	store i32 %24, i32* %5
	%25 = load i32, i32* %5
	%26 = icmp sle i32 %25, 5
	br i1 %26, label %27, label %28

27:
	ret i32 1

28:
	ret i32 0

29:
	ret i32 -1
}
define dso_local void @printName() {
	%1 = load i32, i32* @global_var
	%2 = add nsw i32 %1, 1
	store i32 %2, i32* @global_var
	%3 = load i32, i32* @global_var
	%4 = icmp ne i32 %3, 0
	br i1 %4, label %5, label %6

5:
	call void @putstr(i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str, i64 0, i64 0))
	br label %6

6:
	ret void
}
define dso_local void @print(i8 %0) {
	%2 = alloca i8
	store i8 %0, i8* %2
	%3 = load i8, i8* %2
	%4 = zext i8 %3 to i32
	call void @putch(i32 %4)
	call void @putstr(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.1, i64 0, i64 0))
	ret void
}
define dso_local i8 @get_first(i8* %0) {
	%2 = alloca i8*
	store i8* %0, i8** %2
	%3 = load i8*, i8** %2
	%4 = getelementptr inbounds i8, i8* %3, i32 0
	%5 = load i8, i8* %4
	ret i8 %5
}
define dso_local i32 @main() {
	call void @printName()
	%1 = alloca i32
	store i32 0, i32* %1
	%2 = alloca i32
	store i32 8, i32* %2
	%3 = alloca i8
	%4 = call i32 @getint()
	store i32 %4, i32* %1
	%5 = call i32 @getchar()
	%6 = trunc i32 %5 to i8
	store i8 %6, i8* %3
	%7 = load i32, i32* %1
	call void @putstr(i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.2, i64 0, i64 0))
	call void @putint(i32 %7)
	call void @putstr(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.3, i64 0, i64 0))
	%8 = load i8, i8* %3
	call void @putstr(i8* getelementptr inbounds ([18 x i8], [18 x i8]* @.str.4, i64 0, i64 0))
	%109 = zext i8 %8 to i32
	call void @putch(i32 %109)
	call void @putstr(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.5, i64 0, i64 0))
	%9 = alloca i32
	store i32 5, i32* %9
	%10 = alloca [10 x i32]
	%11 = alloca [12 x i8]
	%12 = getelementptr inbounds [12 x i8], [12 x i8]* %11, i32 0, i32 1
	store i8 'q', i8* %12
	%13 = getelementptr inbounds [12 x i8], [12 x i8]* %12, i32 0, i32 2
	store i8 'w', i8* %13
	%14 = getelementptr inbounds [12 x i8], [12 x i8]* %13, i32 0, i32 3
	store i8 'e', i8* %14
	%15 = getelementptr inbounds [12 x i8], [12 x i8]* %14, i32 0, i32 4
	store i8 'r', i8* %15
	%16 = getelementptr inbounds [12 x i8], [12 x i8]* %15, i32 0, i32 5
	store i8 't', i8* %16
	%17 = getelementptr inbounds [12 x i8], [12 x i8]* %16, i32 0, i32 6
	store i8 'y', i8* %17
	%18 = getelementptr inbounds [12 x i8], [12 x i8]* %17, i32 0, i32 7
	store i8 'u', i8* %18
	%19 = getelementptr inbounds [12 x i8], [12 x i8]* %18, i32 0, i32 8
	store i8 'i', i8* %19
	%20 = getelementptr inbounds [12 x i8], [12 x i8]* %19, i32 0, i32 9
	store i8 'o', i8* %20
	%21 = getelementptr inbounds [12 x i8], [12 x i8]* %20, i32 0, i32 10
	store i8 'p', i8* %21
	%22 = getelementptr inbounds [12 x i8], [12 x i8]* %21, i32 0, i32 11
	store i8 '\', i8* %22
	%23 = getelementptr inbounds [12 x i8], [12 x i8]* %22, i32 0, i32 12
	store i8 'n', i8* %23
	%24 = alloca [10 x i8]
	%25 = getelementptr inbounds [10 x i8], [10 x i8]* %24, i32 0, i32 1
	store i8 's', i8* %25
	%26 = getelementptr inbounds [10 x i8], [10 x i8]* %25, i32 0, i32 2
	store i8 't', i8* %26
	%27 = getelementptr inbounds [10 x i8], [10 x i8]* %26, i32 0, i32 3
	store i8 'r', i8* %27
	store i32 0, i32* %1
	br label %28

28:
	%29 = load i32, i32* %1
	%30 = load i32, i32* @MAX_SIZE
	%31 = icmp slt i32 %29, %30
	br i1 %31, label %32, label %75

32:
	%33 = load i32, i32* %1
	%34 = getelementptr inbounds i32, i32* %10, i32 %33
	%35 = load i32, i32* %1
	store i32 %35, i32* %10
	%36 = load i32, i32* %1
	%37 = icmp eq i32 %36, 4
	br i1 %37, label %38, label %43

38:
	%39 = load i32, i32* %1
	%40 = load i8, i8* %3
	%41 = zext i8 %40 to i32
	%42 = icmp slt i32 %39, %41
	br i1 %42, label %46, label %43

43:
	%44 = load i32, i32* %1
	%45 = icmp sge i32 %44, 9
	br i1 %45, label %46, label %63

46:
	call void @putstr(i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.6, i64 0, i64 0))
	%47 = alloca i32
	store i32 1, i32* %47
	br label %48

48:
	%49 = load i32, i32* %47
	%50 = icmp sgt i32 %49, 100
	br i1 %50, label %51, label %52

51:
	br label %62

52:
	%53 = load i32, i32* %47
	%54 = icmp ne i32 %53, 32
	br i1 %54, label %55, label %56

55:
	br label %58

56:
	br label %57

57:
	call void @putstr(i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.7, i64 0, i64 0))
	br label %58

58:
	%59 = load i32, i32* %47
	%60 = load i32, i32* %47
	%61 = add nsw i32 %59, %60
	store i32 %61, i32* %47
	br label %48

62:
	br label %63

63:
	%64 = load i32, i32* %1
	%65 = srem i32 %64, 2
	%66 = icmp eq i32 %65, 0
	br i1 %66, label %67, label %70

67:
	br label %68

68:
	br label %69

69:
	br label %71

70:
	br label %71

71:
	br label %72

72:
	%73 = load i32, i32* %1
	%74 = add nsw i32 %73, 1
	store i32 %74, i32* %1
	br label %28

75:
	%76 = alloca [20 x i32]
	%77 = getelementptr inbounds [20 x i32], [20 x i32]* %76, i32 0, i32 0
	store i32 3, i32* %77
	%78 = getelementptr inbounds i32, i32* %77, i32 1
	store i32 2, i32* %78
	%79 = getelementptr inbounds i32, i32* %78, i32 1
	store i32 1, i32* %79
	%80 = alloca i32
	store i32 0, i32* %80
	%81 = alloca i32
	store i32 0, i32* %81
	br label %82

82:
	%83 = load i32, i32* %81
	%84 = load i32, i32* @MAX_SIZE
	%85 = icmp slt i32 %83, %84
	br i1 %85, label %86, label %99

86:
	%87 = load i32, i32* %81
	%88 = icmp slt i32 %87, 3
	br i1 %88, label %89, label %95

89:
	%90 = load i32, i32* %81
	%91 = getelementptr inbounds [20 x i32], [20 x i32]* %76, i32 0, i32 %90
	%92 = load i32, i32* %91
	%93 = load i32, i32* %80
	%94 = add nsw i32 %93, %92
	store i32 %94, i32* %80
	br label %95

95:
	br label %96

96:
	%97 = load i32, i32* %81
	%98 = add nsw i32 %97, 1
	store i32 %98, i32* %81
	br label %82

99:
	%100 = load i32, i32* %80
	call void @putstr(i8* getelementptr inbounds ([24 x i8], [24 x i8]* @.str.8, i64 0, i64 0))
	call void @putint(i32 %100)
	call void @putstr(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.9, i64 0, i64 0))
	%101 = load i32, i32* %1
	%102 = getelementptr inbounds [10 x i32], [10 x i32]* %10, i32 0, i32 0
	%103 = call i32 @calculate(i32 %101, i32* %102)
	%104 = icmp ne i32 %103, 0
	br i1 %104, label %108, label %105

105:
	%106 = getelementptr inbounds [12 x i8], [12 x i8]* %11, i32 0, i32 0
	%107 = call i8 @get_first(i8* %106)
	call void @print(i8 %107)
	br label %108

108:
	call void @putstr(i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.10, i64 0, i64 0))
	ret i32 0
}
