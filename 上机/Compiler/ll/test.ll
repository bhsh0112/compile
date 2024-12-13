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
	%14 = getelementptr inbounds i8, i8* %13, i32 1
	store i8 119, i8* %14
	%15 = getelementptr inbounds i8, i8* %14, i32 2
	store i8 101, i8* %15
	%16 = getelementptr inbounds i8, i8* %15, i32 3
	store i8 114, i8* %16
	%17 = getelementptr inbounds i8, i8* %16, i32 4
	store i8 116, i8* %17
	%18 = getelementptr inbounds i8, i8* %17, i32 5
	store i8 121, i8* %18
	%19 = getelementptr inbounds i8, i8* %18, i32 6
	store i8 117, i8* %19
	%20 = getelementptr inbounds i8, i8* %19, i32 7
	store i8 105, i8* %20
	%21 = getelementptr inbounds i8, i8* %20, i32 8
	store i8 111, i8* %21
	%22 = getelementptr inbounds i8, i8* %21, i32 9
	store i8 112, i8* %22
	%23 = getelementptr inbounds i8, i8* %22, i32 10
	store i8 92, i8* %23
	%24 = getelementptr inbounds i8, i8* %23, i32 11
	store i8 110, i8* %24
	%25 = alloca [10 x i8]
	%26 = getelementptr inbounds [10 x i8], [10 x i8]* %25, i32 0, i32 0
	store i8 115, i8* %26
	%27 = getelementptr inbounds i8, i8* %26, i32 1
	store i8 116, i8* %27
	%28 = getelementptr inbounds i8, i8* %27, i32 2
	store i8 114, i8* %28
	store i32 0, i32* %1
	br label %29

29:
	%30 = load i32, i32* %1
	%31 = load i32, i32* @MAX_SIZE
	%32 = icmp slt i32 %30, %31
	br i1 %32, label %33, label %77

33:
	%34 = load i32, i32* %1
	%35 = getelementptr inbounds [10 x i32], [10 x i32]* %11, i32 0, i32 0
	%36 = getelementptr inbounds i32, i32* %35, i32 %34
	%37 = load i32, i32* %1
	store i32 %37, i32* %36
	%38 = load i32, i32* %1
	%39 = icmp eq i32 %38, 4
	br i1 %39, label %40, label %45

40:
	%41 = load i32, i32* %1
	%42 = load i8, i8* %3
	%43 = zext i8 %42 to i32
	%44 = icmp slt i32 %41, %43
	br i1 %44, label %48, label %45

45:
	%46 = load i32, i32* %1
	%47 = icmp sge i32 %46, 9
	br i1 %47, label %48, label %65

48:
	call void @putstr(i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.6, i64 0, i64 0))
	%49 = alloca i32
	store i32 1, i32* %49
	br label %50

50:
	%51 = load i32, i32* %49
	%52 = icmp sgt i32 %51, 100
	br i1 %52, label %53, label %54

53:
	br label %64

54:
	%55 = load i32, i32* %49
	%56 = icmp ne i32 %55, 32
	br i1 %56, label %57, label %58

57:
	br label %60

58:
	br label %59

59:
	call void @putstr(i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.7, i64 0, i64 0))
	br label %60

60:
	%61 = load i32, i32* %49
	%62 = load i32, i32* %49
	%63 = add nsw i32 %61, %62
	store i32 %63, i32* %49
	br label %50

64:
	br label %65

65:
	%66 = load i32, i32* %1
	%67 = srem i32 %66, 2
	%68 = icmp eq i32 %67, 0
	br i1 %68, label %69, label %72

69:
	br label %70

70:
	br label %71

71:
	br label %73

72:
	br label %73

73:
	br label %74

74:
	%75 = load i32, i32* %1
	%76 = add nsw i32 %75, 1
	store i32 %76, i32* %1
	br label %29

77:
	%78 = alloca [20 x i32]
	%79 = getelementptr inbounds [20 x i32], [20 x i32]* %78, i32 0, i32 0
	store i32 3, i32* %79
	%80 = getelementptr inbounds i32, i32* %79, i32 1
	store i32 2, i32* %80
	%81 = getelementptr inbounds i32, i32* %80, i32 1
	store i32 1, i32* %81
	%82 = alloca i32
	store i32 0, i32* %82
	%83 = alloca i32
	store i32 0, i32* %83
	br label %84

84:
	%85 = load i32, i32* %83
	%86 = load i32, i32* @MAX_SIZE
	%87 = icmp slt i32 %85, %86
	br i1 %87, label %88, label %101

88:
	%89 = load i32, i32* %83
	%90 = icmp slt i32 %89, 3
	br i1 %90, label %91, label %97

91:
	%92 = load i32, i32* %83
	%93 = getelementptr inbounds [20 x i32], [20 x i32]* %78, i32 0, i32 %92
	%94 = load i32, i32* %93
	%95 = load i32, i32* %82
	%96 = add nsw i32 %95, %94
	store i32 %96, i32* %82
	br label %97

97:
	br label %98

98:
	%99 = load i32, i32* %83
	%100 = add nsw i32 %99, 1
	store i32 %100, i32* %83
	br label %84

101:
	%102 = load i32, i32* %82
	call void @putstr(i8* getelementptr inbounds ([24 x i8], [24 x i8]* @.str.8, i64 0, i64 0))
	call void @putint(i32 %102)
	call void @putstr(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.9, i64 0, i64 0))
	%103 = load i32, i32* %1
	%104 = getelementptr inbounds [10 x i32], [10 x i32]* %11, i32 0, i32 0
	%105 = call i32 @calculate(i32 %103, i32* %104)
	%106 = icmp ne i32 %105, 0
	br i1 %106, label %110, label %107

107:
	%108 = getelementptr inbounds [12 x i8], [12 x i8]* %12, i32 0, i32 0
	%109 = call i8 @get_first(i8* %108)
	call void @print(i8 %109)
	br label %110

110:
	call void @putstr(i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.10, i64 0, i64 0))
	ret i32 0
}
