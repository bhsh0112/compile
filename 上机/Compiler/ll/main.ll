declare i32 @getint()
declare i32 @getchar()
declare void @putint(i32)
declare void @putch(i32)
declare void @putstr(i8*)

@MAX_SIZE = dso_local global i32 10
@global_var = dso_local global i32 zeroinitializer
@str = dso_local global [10 x i8] [i8 51,i8 92,i8 0,i8 0,i8 0,i8 0,i8 0,i8 0,i8 0,i8 0]
@.str = private unnamed_addr constant [2 x i8] c",\00", align 1
@.str.1 = private unnamed_addr constant [2 x i8] c",\00", align 1
@.str.2 = private unnamed_addr constant [2 x i8] c",\00", align 1
@.str.3 = private unnamed_addr constant [2 x i8] c",\00", align 1
@.str.4 = private unnamed_addr constant [2 x i8] c",\00", align 1
@.str.5 = private unnamed_addr constant [2 x i8] c",\00", align 1
@.str.6 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.7 = private unnamed_addr constant [7 x i8] c"b[0]: \00", align 1
@.str.8 = private unnamed_addr constant [8 x i8] c"truth: \00", align 1
@.str.9 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.10 = private unnamed_addr constant [10 x i8] c"22373040\0A\00", align 1
@.str.11 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.12 = private unnamed_addr constant [9 x i8] c"success:\00", align 1
@.str.13 = private unnamed_addr constant [16 x i8] c"Input integer: \00", align 1
@.str.14 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.15 = private unnamed_addr constant [18 x i8] c"Input character: \00", align 1
@.str.16 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.17 = private unnamed_addr constant [14 x i8] c"i is 4 or 9!\0A\00", align 1
@.str.18 = private unnamed_addr constant [10 x i8] c"j is 32!\0A\00", align 1
@.str.19 = private unnamed_addr constant [24 x i8] c"Sum of array elements: \00", align 1
@.str.20 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.21 = private unnamed_addr constant [16 x i8] c"Test finished!\0A\00", align 1
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
	store i32 %10, i32* %5
	%11 = alloca i32
	%12 = load i32*, i32** %4
	%13 = getelementptr inbounds i32, i32* %12, i32 1
	%14 = load i32, i32* %13
	%15 = load i32, i32* %3
	%16 = sub nsw i32 %15, %14
	store i32 %16, i32* %11
	%17 = alloca i32
	%18 = load i32*, i32** %4
	%19 = getelementptr inbounds i32, i32* %18, i32 2
	%20 = load i32, i32* %19
	store i32 %20, i32* %17
	%21 = alloca i32
	%22 = load i32, i32* %3
	store i32 %22, i32* %21
	%23 = alloca i32
	store i32 -3, i32* %23
	%24 = alloca i32
	store i32 6, i32* %24
	%25 = alloca i32
	%26 = load i32, i32* %5
	%27 = load i32, i32* %11
	%28 = mul nsw i32 %26, %27
	%29 = load i32, i32* %17
	%30 = sdiv i32 %28, %29
	%31 = load i32, i32* %21
	%32 = srem i32 %30, %31
	%33 = load i32, i32* %23
	%34 = sub nsw i32 %32, %33
	%35 = load i32, i32* %24
	%36 = add nsw i32 %34, %35
	store i32 %36, i32* %25
	%37 = alloca i32
	%38 = load i32, i32* %3
	%39 = load i32*, i32** %4
	%40 = getelementptr inbounds i32, i32* %39, i32 0
	%41 = load i32, i32* %40
	%42 = call i32 @add(i32 %38, i32 %41)
	%43 = load i32*, i32** %4
	%44 = getelementptr inbounds i32, i32* %43, i32 1
	%45 = load i32, i32* %44
	%46 = load i32*, i32** %4
	%47 = getelementptr inbounds i32, i32* %46, i32 2
	%48 = load i32, i32* %47
	%49 = load i32, i32* %3
	%50 = sub nsw i32 %49, %45
	%51 = mul nsw i32 %42, %50
	%52 = sdiv i32 %51, %48
	%53 = load i32, i32* %3
	%54 = srem i32 %52, %53
	%55 = sub nsw i32 %54, -3
	%56 = add nsw i32 %55, 6
	store i32 %56, i32* %37
	%57 = load i32, i32* %5
	%58 = load i32, i32* %11
	%59 = load i32, i32* %17
	%60 = load i32, i32* %21
	%61 = load i32, i32* %23
	%62 = load i32, i32* %24
	%63 = load i32, i32* %25
	call void @putint(i32 %57)
	call void @putstr(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str, i64 0, i64 0))
	call void @putint(i32 %58)
	call void @putstr(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.1, i64 0, i64 0))
	call void @putint(i32 %59)
	call void @putstr(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.2, i64 0, i64 0))
	call void @putint(i32 %60)
	call void @putstr(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.3, i64 0, i64 0))
	call void @putint(i32 %61)
	call void @putstr(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.4, i64 0, i64 0))
	call void @putint(i32 %62)
	call void @putstr(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.5, i64 0, i64 0))
	call void @putint(i32 %63)
	call void @putstr(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.6, i64 0, i64 0))
	%64 = load i32*, i32** %4
	%65 = getelementptr inbounds i32, i32* %64, i32 0
	%66 = load i32, i32* %65
	call void @putstr(i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.7, i64 0, i64 0))
	call void @putint(i32 %66)
	%67 = load i32, i32* %37
	call void @putstr(i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.8, i64 0, i64 0))
	call void @putint(i32 %67)
	call void @putstr(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.9, i64 0, i64 0))
	%68 = load i32, i32* %25
	%69 = icmp sle i32 %68, 5
	br i1 %69, label %70, label %71

70:
	ret i32 1

71:
	ret i32 0

72:
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
	call void @putstr(i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.10, i64 0, i64 0))
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
	call void @putstr(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.11, i64 0, i64 0))
	ret void
}
define dso_local i8 @get_first(i8* %0) {
	%2 = alloca i8*
	store i8* %0, i8** %2
	%3 = alloca i8
	store i8 49, i8* %3
	%4 = load i8*, i8** %2
	%5 = getelementptr inbounds i8, i8* %4, i32 0
	%6 = load i8, i8* %5
	%7 = load i8, i8* %3
	call void @putstr(i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.12, i64 0, i64 0))
	%8 = zext i8 %6 to i32
	call void @putch(i32 %8)
	%9 = zext i8 %7 to i32
	call void @putch(i32 %9)
	%10 = load i8*, i8** %2
	%11 = getelementptr inbounds i8, i8* %10, i32 0
	%12 = load i8, i8* %11
	ret i8 %12
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
	call void @putstr(i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.13, i64 0, i64 0))
	call void @putint(i32 %7)
	call void @putstr(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.14, i64 0, i64 0))
	%8 = load i8, i8* %3
	call void @putstr(i8* getelementptr inbounds ([18 x i8], [18 x i8]* @.str.15, i64 0, i64 0))
	%9 = zext i8 %8 to i32
	call void @putch(i32 %9)
	call void @putstr(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.16, i64 0, i64 0))
	%10 = alloca i32
	store i32 5, i32* %10
	%11 = alloca [10 x i32]
	%12 = alloca [12 x i8]
	%13 = getelementptr inbounds [12 x i8], [12 x i8]* %12, i32 0, i32 0
	store i8 113, i8* %13
	%14 = getelementptr inbounds [12 x i8], [12 x i8]* %13, i32 0, i32 1
	store i8 119, i8* %14
	%15 = getelementptr inbounds [12 x i8], [12 x i8]* %14, i32 0, i32 2
	store i8 101, i8* %15
	%16 = getelementptr inbounds [12 x i8], [12 x i8]* %15, i32 0, i32 3
	store i8 114, i8* %16
	%17 = getelementptr inbounds [12 x i8], [12 x i8]* %16, i32 0, i32 4
	store i8 116, i8* %17
	%18 = getelementptr inbounds [12 x i8], [12 x i8]* %17, i32 0, i32 5
	store i8 121, i8* %18
	%19 = getelementptr inbounds [12 x i8], [12 x i8]* %18, i32 0, i32 6
	store i8 117, i8* %19
	%20 = getelementptr inbounds [12 x i8], [12 x i8]* %19, i32 0, i32 7
	store i8 105, i8* %20
	%21 = getelementptr inbounds [12 x i8], [12 x i8]* %20, i32 0, i32 8
	store i8 111, i8* %21
	%22 = getelementptr inbounds [12 x i8], [12 x i8]* %21, i32 0, i32 9
	store i8 112, i8* %22
	%23 = getelementptr inbounds [12 x i8], [12 x i8]* %22, i32 0, i32 10
	store i8 92, i8* %23
	%24 = getelementptr inbounds [12 x i8], [12 x i8]* %23, i32 0, i32 11
	store i8 110, i8* %24
	%25 = alloca [10 x i8]
	%26 = getelementptr inbounds [10 x i8], [10 x i8]* %25, i32 0, i32 1
	store i8 115, i8* %26
	%27 = getelementptr inbounds [10 x i8], [10 x i8]* %26, i32 0, i32 2
	store i8 116, i8* %27
	%28 = getelementptr inbounds [10 x i8], [10 x i8]* %27, i32 0, i32 3
	store i8 114, i8* %28
	store i32 0, i32* %1
	br label %29

29:
	%30 = load i32, i32* %1
	%31 = load i32, i32* @MAX_SIZE
	%32 = icmp slt i32 %30, %31
	br i1 %32, label %33, label %76

33:
	%34 = load i32, i32* %1
	%35 = getelementptr inbounds i32, i32* %11, i32 %34
	%36 = load i32, i32* %1
	store i32 %36, i32* %35
	%37 = load i32, i32* %1
	%38 = icmp eq i32 %37, 4
	br i1 %38, label %39, label %44

39:
	%40 = load i32, i32* %1
	%41 = load i8, i8* %3
	%42 = zext i8 %41 to i32
	%43 = icmp slt i32 %40, %42
	br i1 %43, label %47, label %44

44:
	%45 = load i32, i32* %1
	%46 = icmp sge i32 %45, 9
	br i1 %46, label %47, label %64

47:
	call void @putstr(i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.17, i64 0, i64 0))
	%48 = alloca i32
	store i32 1, i32* %48
	br label %49

49:
	%50 = load i32, i32* %48
	%51 = icmp sgt i32 %50, 100
	br i1 %51, label %52, label %53

52:
	br label %63

53:
	%54 = load i32, i32* %48
	%55 = icmp ne i32 %54, 32
	br i1 %55, label %56, label %57

56:
	br label %59

57:
	br label %58

58:
	call void @putstr(i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.18, i64 0, i64 0))
	br label %59

59:
	%60 = load i32, i32* %48
	%61 = load i32, i32* %48
	%62 = add nsw i32 %60, %61
	store i32 %62, i32* %48
	br label %49

63:
	br label %64

64:
	%65 = load i32, i32* %1
	%66 = srem i32 %65, 2
	%67 = icmp eq i32 %66, 0
	br i1 %67, label %68, label %71

68:
	br label %69

69:
	br label %70

70:
	br label %72

71:
	br label %72

72:
	br label %73

73:
	%74 = load i32, i32* %1
	%75 = add nsw i32 %74, 1
	store i32 %75, i32* %1
	br label %29

76:
	%77 = alloca [20 x i32]
	%78 = getelementptr inbounds [20 x i32], [20 x i32]* %77, i32 0, i32 0
	store i32 3, i32* %78
	%79 = getelementptr inbounds i32, i32* %78, i32 1
	store i32 2, i32* %79
	%80 = getelementptr inbounds i32, i32* %79, i32 1
	store i32 1, i32* %80
	%81 = alloca i32
	store i32 0, i32* %81
	%82 = alloca i32
	store i32 0, i32* %82
	br label %83

83:
	%84 = load i32, i32* %82
	%85 = load i32, i32* @MAX_SIZE
	%86 = icmp slt i32 %84, %85
	br i1 %86, label %87, label %100

87:
	%88 = load i32, i32* %82
	%89 = icmp slt i32 %88, 3
	br i1 %89, label %90, label %96

90:
	%91 = load i32, i32* %82
	%92 = getelementptr inbounds [20 x i32], [20 x i32]* %77, i32 0, i32 %91
	%93 = load i32, i32* %92
	%94 = load i32, i32* %81
	%95 = add nsw i32 %94, %93
	store i32 %95, i32* %81
	br label %96

96:
	br label %97

97:
	%98 = load i32, i32* %82
	%99 = add nsw i32 %98, 1
	store i32 %99, i32* %82
	br label %83

100:
	%101 = load i32, i32* %81
	call void @putstr(i8* getelementptr inbounds ([24 x i8], [24 x i8]* @.str.19, i64 0, i64 0))
	call void @putint(i32 %101)
	call void @putstr(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.20, i64 0, i64 0))
	%102 = load i32, i32* %1
	%103 = getelementptr inbounds [10 x i32], [10 x i32]* %11, i32 0, i32 0
	%104 = call i32 @calculate(i32 %102, i32* %103)
	%105 = icmp ne i32 %104, 0
	br i1 %105, label %111, label %106

106:
	%107 = alloca i8
	%108 = getelementptr inbounds [12 x i8], [12 x i8]* %12, i32 0, i32 0
	%109 = call i8 @get_first(i8* %108)
	store i8 %109, i8* %107
	%110 = load i8, i8* %107
	call void @print(i8 %110)
	br label %111

111:
	call void @putstr(i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.21, i64 0, i64 0))
	ret i32 0
}
