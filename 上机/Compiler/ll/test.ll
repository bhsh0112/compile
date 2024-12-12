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
	%20 = sdiv i32 %19, %16
	%21 = load i32, i32* %3
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
	%9 = zext i8 %8 to i32
	call void @putch(i32 %9)
	call void @putstr(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.5, i64 0, i64 0))
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
	call void @putstr(i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.6, i64 0, i64 0))
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
	call void @putstr(i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.7, i64 0, i64 0))
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
	call void @putstr(i8* getelementptr inbounds ([24 x i8], [24 x i8]* @.str.8, i64 0, i64 0))
	call void @putint(i32 %101)
	call void @putstr(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.9, i64 0, i64 0))
	%102 = load i32, i32* %1
	%103 = getelementptr inbounds [10 x i32], [10 x i32]* %11, i32 0, i32 0
	%104 = call i32 @calculate(i32 %102, i32* %103)
	%105 = icmp ne i32 %104, 0
	br i1 %105, label %109, label %106

106:
	%107 = getelementptr inbounds [12 x i8], [12 x i8]* %12, i32 0, i32 0
	%108 = call i8 @get_first(i8* %107)
	call void @print(i8 %108)
	br label %109

109:
	call void @putstr(i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.10, i64 0, i64 0))
	ret i32 0
}
