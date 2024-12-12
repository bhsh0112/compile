declare i32 @getint()
declare i32 @getchar()
declare void @putint(i32)
declare void @putch(i32)
declare void @putstr(i8*)

@constIntArray = dso_local global [3 x i32] [i32 10,i32 20,i32 30]
@constCharArray = dso_local global [5 x i8] [i8 65,i8 66,i8 67,i8 68,i8 69]
@constCharArray2 = dso_local global [5 x i8] [i8 97,i8 98,i8 99,i8 0,i8 0]
@intArray = dso_local global [5 x i32] zeroinitializer
@charArray = dso_local global [5 x i8] zeroinitializer
@.str = private unnamed_addr constant [31 x i8] c"Function with parameters: a = \00", align 1
@.str.1 = private unnamed_addr constant [7 x i8] c", b = \00", align 1
@.str.2 = private unnamed_addr constant [11 x i8] c" arr[0] = \00", align 1
@.str.3 = private unnamed_addr constant [12 x i8] c", str[0] = \00", align 1
@.str.4 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.5 = private unnamed_addr constant [25 x i8] c"Sum in func_with_param: \00", align 1
@.str.6 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.7 = private unnamed_addr constant [10 x i8] c"22373141\0A\00", align 1
@.str.8 = private unnamed_addr constant [23 x i8] c"Negative intArray[0]: \00", align 1
@.str.9 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.10 = private unnamed_addr constant [23 x i8] c"Positive intArray[0]: \00", align 1
@.str.11 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.12 = private unnamed_addr constant [11 x i8] c"Quotient: \00", align 1
@.str.13 = private unnamed_addr constant [14 x i8] c", Remainder: \00", align 1
@.str.14 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.15 = private unnamed_addr constant [22 x i8] c"Sum of ASCII codes1: \00", align 1
@.str.16 = private unnamed_addr constant [2 x i8] c" \00", align 1
@.str.17 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.18 = private unnamed_addr constant [22 x i8] c"Sum of ASCII codes2: \00", align 1
@.str.19 = private unnamed_addr constant [2 x i8] c" \00", align 1
@.str.20 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.21 = private unnamed_addr constant [6 x i8] c"x1 = \00", align 1
@.str.22 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.23 = private unnamed_addr constant [6 x i8] c"a1 = \00", align 1
@.str.24 = private unnamed_addr constant [12 x i8] c", as char: \00", align 1
@.str.25 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
define dso_local i32 @func_with_param(i32 %0, i8 %1, i32* %2, i8* %3) {
	%5 = alloca i32
	store i32 %0, i32* %5
	%6 = alloca i8
	store i8 %1, i8* %6
	%7 = alloca i32*
	store i32* %2, i32** %7
	%8 = alloca i8*
	store i8* %3, i8** %8
	%9 = load i32, i32* %5
	%10 = load i8, i8* %6
	%11 = load i32*, i32** %7
	%12 = getelementptr inbounds i32, i32* %11, i32 0
	%13 = load i32, i32* %12
	%14 = load i8*, i8** %8
	%15 = getelementptr inbounds i8, i8* %14, i32 0
	%16 = load i8, i8* %15
	call void @putstr(i8* getelementptr inbounds ([31 x i8], [31 x i8]* @.str, i64 0, i64 0))
	call void @putint(i32 %9)
	call void @putstr(i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.1, i64 0, i64 0))
	%17 = zext i8 %10 to i32
	call void @putch(i32 %17)
	call void @putstr(i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.2, i64 0, i64 0))
	call void @putint(i32 %13)
	call void @putstr(i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.3, i64 0, i64 0))
	%18 = zext i8 %16 to i32
	call void @putch(i32 %18)
	call void @putstr(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.4, i64 0, i64 0))
	%19 = alloca i32
	%20 = load i32*, i32** %7
	%21 = getelementptr inbounds i32, i32* %20, i32 0
	%22 = load i32, i32* %21
	%23 = load i8*, i8** %8
	%24 = getelementptr inbounds i8, i8* %23, i32 0
	%25 = load i8, i8* %24
	%26 = load i32, i32* %5
	%27 = load i8, i8* %6
	%28 = zext i8 %27 to i32
	%29 = add nsw i32 %26, %28
	%30 = add nsw i32 %29, %22
	%31 = zext i8 %25 to i32
	%32 = add nsw i32 %30, %31
	store i32 %32, i32* %19
	%33 = load i32, i32* %19
	call void @putstr(i8* getelementptr inbounds ([25 x i8], [25 x i8]* @.str.5, i64 0, i64 0))
	call void @putint(i32 %33)
	call void @putstr(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.6, i64 0, i64 0))
	%34 = load i32, i32* %19
	ret i32 %34
}
define dso_local i32 @main() {
	call void @putstr(i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.7, i64 0, i64 0))
	%1 = getelementptr inbounds i32, i32* @intArray, i32 0
	%2 = getelementptr inbounds [3 x i32], [3 x i32]* @constIntArray, i32 0, i32 0
	%3 = load i32, i32* %2
	store i32 %3, i32* %1
	%4 = getelementptr inbounds i32, i32* @intArray, i32 1
	%5 = getelementptr inbounds [3 x i32], [3 x i32]* @constIntArray, i32 0, i32 1
	%6 = load i32, i32* %5
	store i32 %6, i32* %4
	%7 = getelementptr inbounds i32, i32* @intArray, i32 2
	%8 = getelementptr inbounds [3 x i32], [3 x i32]* @constIntArray, i32 0, i32 2
	%9 = load i32, i32* %8
	store i32 %9, i32* %7
	%10 = getelementptr inbounds i32, i32* @intArray, i32 3
	%11 = getelementptr inbounds [5 x i32], [5 x i32]* @intArray, i32 0, i32 0
	%12 = load i32, i32* %11
	%13 = getelementptr inbounds [5 x i32], [5 x i32]* @intArray, i32 0, i32 1
	%14 = load i32, i32* %13
	%15 = add nsw i32 %12, %14
	store i32 %15, i32* %10
	%16 = getelementptr inbounds i32, i32* @intArray, i32 4
	%17 = getelementptr inbounds [5 x i32], [5 x i32]* @intArray, i32 0, i32 3
	%18 = load i32, i32* %17
	%19 = getelementptr inbounds [5 x i32], [5 x i32]* @intArray, i32 0, i32 2
	%20 = load i32, i32* %19
	%21 = add nsw i32 %18, %20
	store i32 %21, i32* %16
	%22 = getelementptr inbounds i32, i32* @intArray, i32 0
	%23 = getelementptr inbounds [5 x i32], [5 x i32]* @intArray, i32 0, i32 0
	%24 = load i32, i32* %23
	%25 = sub nsw i32 0, %24
	store i32 %25, i32* %22
	%26 = getelementptr inbounds [5 x i32], [5 x i32]* @intArray, i32 0, i32 0
	%27 = load i32, i32* %26
	call void @putstr(i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str.8, i64 0, i64 0))
	call void @putint(i32 %27)
	call void @putstr(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.9, i64 0, i64 0))
	%28 = getelementptr inbounds i32, i32* @intArray, i32 0
	%29 = getelementptr inbounds [5 x i32], [5 x i32]* @intArray, i32 0, i32 0
	%30 = load i32, i32* %29
	%31 = add nsw i32 0, %30
	store i32 %31, i32* %28
	%32 = getelementptr inbounds [5 x i32], [5 x i32]* @intArray, i32 0, i32 0
	%33 = load i32, i32* %32
	call void @putstr(i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str.10, i64 0, i64 0))
	call void @putint(i32 %33)
	call void @putstr(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.11, i64 0, i64 0))
	%34 = getelementptr inbounds i32, i32* @intArray, i32 1
	%35 = getelementptr inbounds [5 x i32], [5 x i32]* @intArray, i32 0, i32 3
	%36 = load i32, i32* %35
	%37 = getelementptr inbounds [5 x i32], [5 x i32]* @intArray, i32 0, i32 2
	%38 = load i32, i32* %37
	%39 = sdiv i32 %36, %38
	store i32 %39, i32* %34
	%40 = getelementptr inbounds i32, i32* @intArray, i32 2
	%41 = getelementptr inbounds [5 x i32], [5 x i32]* @intArray, i32 0, i32 3
	%42 = load i32, i32* %41
	%43 = getelementptr inbounds [5 x i32], [5 x i32]* @intArray, i32 0, i32 2
	%44 = load i32, i32* %43
	%45 = srem i32 %42, %44
	store i32 %45, i32* %40
	%46 = getelementptr inbounds [5 x i32], [5 x i32]* @intArray, i32 0, i32 1
	%47 = load i32, i32* %46
	%48 = getelementptr inbounds [5 x i32], [5 x i32]* @intArray, i32 0, i32 2
	%49 = load i32, i32* %48
	call void @putstr(i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.12, i64 0, i64 0))
	call void @putint(i32 %47)
	call void @putstr(i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.13, i64 0, i64 0))
	call void @putint(i32 %49)
	call void @putstr(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.14, i64 0, i64 0))
	%50 = getelementptr inbounds i8, i8* @charArray, i32 0
	%51 = getelementptr inbounds [5 x i8], [5 x i8]* @constCharArray, i32 0, i32 0
	%52 = load i8, i8* %51
	%53 = getelementptr inbounds [5 x i8], [5 x i8]* @constCharArray, i32 0, i32 1
	%54 = load i8, i8* %53
	%55 = getelementptr inbounds [5 x i8], [5 x i8]* @constCharArray, i32 0, i32 2
	%56 = load i8, i8* %55
	%57 = getelementptr inbounds [5 x i8], [5 x i8]* @constCharArray, i32 0, i32 3
	%58 = load i8, i8* %57
	%59 = getelementptr inbounds [5 x i8], [5 x i8]* @constCharArray, i32 0, i32 4
	%60 = load i8, i8* %59
	%61 = zext i8 %52 to i32
	%62 = zext i8 %54 to i32
	%63 = add nsw i32 %61, %62
	%64 = zext i8 %56 to i32
	%65 = add nsw i32 %63, %64
	%66 = zext i8 %58 to i32
	%67 = add nsw i32 %65, %66
	%68 = zext i8 %60 to i32
	%69 = add nsw i32 %67, %68
	%70 = trunc i32 %69 to i8
	store i8 %70, i8* %50
	%71 = getelementptr inbounds [5 x i8], [5 x i8]* @charArray, i32 0, i32 0
	%72 = load i8, i8* %71
	%73 = getelementptr inbounds [5 x i8], [5 x i8]* @charArray, i32 0, i32 0
	%74 = load i8, i8* %73
	call void @putstr(i8* getelementptr inbounds ([22 x i8], [22 x i8]* @.str.15, i64 0, i64 0))
	%75 = zext i8 %72 to i32
	call void @putint(i32 %75)
	call void @putstr(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.16, i64 0, i64 0))
	%76 = zext i8 %74 to i32
	call void @putch(i32 %76)
	call void @putstr(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.17, i64 0, i64 0))
	%77 = alloca i32
	%78 = getelementptr inbounds [5 x i32], [5 x i32]* @intArray, i32 0, i32 0
	%79 = load i32, i32* %78
	%80 = getelementptr inbounds [5 x i8], [5 x i8]* @charArray, i32 0, i32 0
	%81 = load i8, i8* %80
	%82 = getelementptr inbounds [5 x i32], [5 x i32]* @intArray, i32 0, i32 0
	%83 = getelementptr inbounds [5 x i8], [5 x i8]* @charArray, i32 0, i32 0
	%84 = call i32 @func_with_param(i32 %79, i8 %81, i32* %82, i8* %83)
	store i32 %84, i32* %77
	%85 = alloca i32
	%86 = getelementptr inbounds [5 x i8], [5 x i8]* @constCharArray2, i32 0, i32 0
	%87 = load i8, i8* %86
	%88 = getelementptr inbounds [5 x i8], [5 x i8]* @constCharArray2, i32 0, i32 1
	%89 = load i8, i8* %88
	%90 = getelementptr inbounds [5 x i8], [5 x i8]* @constCharArray2, i32 0, i32 2
	%91 = load i8, i8* %90
	%92 = getelementptr inbounds [5 x i8], [5 x i8]* @constCharArray2, i32 0, i32 3
	%93 = load i8, i8* %92
	%94 = getelementptr inbounds [5 x i8], [5 x i8]* @constCharArray2, i32 0, i32 4
	%95 = load i8, i8* %94
	%96 = zext i8 %87 to i32
	%97 = zext i8 %89 to i32
	%98 = add nsw i32 %96, %97
	%99 = zext i8 %91 to i32
	%100 = add nsw i32 %98, %99
	%101 = zext i8 %93 to i32
	%102 = add nsw i32 %100, %101
	%103 = zext i8 %95 to i32
	%104 = add nsw i32 %102, %103
	store i32 %104, i32* %85
	%105 = alloca i8
	%106 = getelementptr inbounds [5 x i8], [5 x i8]* @constCharArray2, i32 0, i32 0
	%107 = load i8, i8* %106
	%108 = getelementptr inbounds [5 x i8], [5 x i8]* @constCharArray2, i32 0, i32 1
	%109 = load i8, i8* %108
	%110 = getelementptr inbounds [5 x i8], [5 x i8]* @constCharArray2, i32 0, i32 2
	%111 = load i8, i8* %110
	%112 = getelementptr inbounds [5 x i8], [5 x i8]* @constCharArray2, i32 0, i32 3
	%113 = load i8, i8* %112
	%114 = getelementptr inbounds [5 x i8], [5 x i8]* @constCharArray2, i32 0, i32 4
	%115 = load i8, i8* %114
	%116 = zext i8 %107 to i32
	%117 = zext i8 %109 to i32
	%118 = add nsw i32 %116, %117
	%119 = zext i8 %111 to i32
	%120 = add nsw i32 %118, %119
	%121 = zext i8 %113 to i32
	%122 = add nsw i32 %120, %121
	%123 = zext i8 %115 to i32
	%124 = add nsw i32 %122, %123
	%125 = trunc i32 %124 to i8
	store i8 %125, i8* %105
	%126 = load i32, i32* %85
	%127 = load i8, i8* %105
	call void @putstr(i8* getelementptr inbounds ([22 x i8], [22 x i8]* @.str.18, i64 0, i64 0))
	call void @putint(i32 %126)
	call void @putstr(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.19, i64 0, i64 0))
	%128 = zext i8 %127 to i32
	call void @putch(i32 %128)
	call void @putstr(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.20, i64 0, i64 0))
	%129 = alloca i32
	store i32 107, i32* %129
	%130 = load i32, i32* %129
	call void @putstr(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.21, i64 0, i64 0))
	call void @putint(i32 %130)
	call void @putstr(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.22, i64 0, i64 0))
	%131 = alloca i8
	store i8 41, i8* %131
	%132 = load i8, i8* %131
	%133 = load i8, i8* %131
	call void @putstr(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.23, i64 0, i64 0))
	%134 = zext i8 %132 to i32
	call void @putint(i32 %134)
	call void @putstr(i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.24, i64 0, i64 0))
	%135 = zext i8 %133 to i32
	call void @putch(i32 %135)
	call void @putstr(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.25, i64 0, i64 0))
	ret i32 0
}
