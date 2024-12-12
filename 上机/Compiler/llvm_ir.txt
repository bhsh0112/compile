declare i32 @getint()
declare i32 @getchar()
declare void @putint(i32)
declare void @putch(i32)
declare void @putstr(i8*)

@singleConstDecl = dso_local global i32 23
@singleConstDecl_0 = dso_local global i32 13
@singleConstDecl_1 = dso_local global i32 3
@singleVarDecl = dso_local global i32 -10
@singleVarDecl_0 = dso_local global i32 23
@singleVarDecl_1 = dso_local global i32 10
@singleVarDecl_2 = dso_local global i32 zeroinitializer
@.str = private unnamed_addr constant [13 x i8] c"print int : \00", align 1
@.str.1 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.2 = private unnamed_addr constant [10 x i8] c"19373479\0A\00", align 1
define dso_local void @funcDef_void() {
	ret void
}
define dso_local i32 @funcDef_0(i32 %0) {
	%2 = alloca i32
	store i32 %0, i32* %2
	%3 = alloca i32
	%4 = load i32, i32* %2
	%5 = mul nsw i32 %4, 10
	store i32 %5, i32* %3
	%6 = load i32, i32* %3
	ret i32 %6
}
define dso_local i32 @funcDef_1(i32 %0, i32 %1) {
	%3 = alloca i32
	store i32 %0, i32* %3
	%4 = alloca i32
	store i32 %1, i32* %4
	%5 = alloca i32
	%6 = load i32, i32* %3
	%7 = load i32, i32* %4
	%8 = mul nsw i32 %6, %7
	store i32 %8, i32* %5
	%9 = alloca i32
	%10 = alloca i32
	%11 = load i32, i32* %4
	%12 = icmp ne i32 %11, 0
	br i1 %12, label %13, label %22

13:
	%14 = load i32, i32* %5
	%15 = load i32, i32* %3
	%16 = load i32, i32* %4
	%17 = srem i32 %15, %16
	%18 = add nsw i32 %14, %17
	store i32 %18, i32* %9
	%19 = load i32, i32* %3
	%20 = load i32, i32* %4
	%21 = sdiv i32 %19, %20
	store i32 %21, i32* %10
	br label %28

22:
	%23 = load i32, i32* %5
	%24 = load i32, i32* %3
	%25 = add nsw i32 %23, %24
	store i32 %25, i32* %9
	%26 = load i32, i32* %3
	%27 = sdiv i32 %26, 2
	store i32 %27, i32* %10
	br label %28

28:
	%29 = load i32, i32* %9
	%30 = load i32, i32* %5
	%31 = sub nsw i32 %29, %30
	store i32 %31, i32* %9
	%32 = load i32, i32* %5
	%33 = load i32, i32* %9
	%34 = add nsw i32 %32, %33
	%35 = load i32, i32* %5
	%36 = icmp slt i32 %35, 0
	br i1 %36, label %37, label %40

37:
	%38 = load i32, i32* %5
	%39 = sub nsw i32 0, %38
	store i32 %39, i32* %5
	br label %40

40:
	%41 = load i32, i32* %5
	%42 = add nsw i32 1, %41
	%43 = load i32, i32* %9
	%44 = load i32, i32* %10
	%45 = add nsw i32 %43, %44
	%46 = mul nsw i32 %42, %45
	ret i32 %46
}
define dso_local void @printInt(i32 %0) {
	%2 = alloca i32
	store i32 %0, i32* %2
	%3 = load i32, i32* %2
	call void @putstr(i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str, i64 0, i64 0))
	call void @putint(i32 %3)
	call void @putstr(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.1, i64 0, i64 0))
	ret void
}
define dso_local i32 @main() {
	call void @putstr(i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.2, i64 0, i64 0))
	%1 = alloca i32
	store i32 10, i32* %1
	%2 = alloca i32
	%3 = alloca i32
	%4 = alloca i32
	%5 = alloca i32
	%6 = call i32 @getint()
	store i32 %6, i32* %2
	%7 = call i32 @getint()
	store i32 %7, i32* %3
	%8 = call i32 @getint()
	store i32 %8, i32* %4
	%9 = call i32 @getint()
	store i32 %9, i32* %5
	%10 = load i32, i32* %2
	%11 = icmp sgt i32 %10, 5
	br i1 %11, label %12, label %13

12:
	store i32 5, i32* %2
	br label %13

13:
	br label %14

14:
	%15 = load i32, i32* %1
	%16 = icmp ne i32 %15, 0
	br i1 %16, label %17, label %66

17:
	%18 = load i32, i32* %1
	%19 = sub nsw i32 %18, 1
	store i32 %19, i32* %1
	%20 = load i32, i32* %3
	%21 = load i32, i32* %1
	%22 = icmp sge i32 %20, %21
	br i1 %22, label %23, label %30

23:
	%24 = load i32, i32* %3
	%25 = load i32, i32* %1
	%26 = add nsw i32 %25, 1
	%27 = sdiv i32 %24, %26
	%28 = load i32, i32* %1
	%29 = add nsw i32 %27, %28
	store i32 %29, i32* %3
	br label %30

30:
	%31 = load i32, i32* %4
	%32 = load i32, i32* %1
	%33 = icmp sle i32 %31, %32
	br i1 %33, label %34, label %38

34:
	%35 = load i32, i32* %4
	%36 = load i32, i32* %1
	%37 = mul nsw i32 %35, %36
	store i32 %37, i32* %4
	br label %43

38:
	%39 = load i32, i32* %4
	%40 = load i32, i32* %1
	%41 = add nsw i32 %40, 3
	%42 = srem i32 %39, %41
	store i32 %42, i32* %4
	br label %43

43:
	br label %44

44:
	%45 = load i32, i32* %5
	%46 = load i32, i32* %4
	%47 = icmp slt i32 %45, %46
	br i1 %47, label %48, label %65

48:
	%49 = load i32, i32* %5
	%50 = load i32, i32* %1
	%51 = add nsw i32 %49, %50
	store i32 %51, i32* %5
	%52 = load i32, i32* %5
	%53 = load i32, i32* %2
	%54 = icmp eq i32 %52, %53
	br i1 %54, label %55, label %56

55:
	br label %65

56:
	%57 = load i32, i32* %5
	%58 = load i32, i32* %3
	%59 = icmp ne i32 %57, %58
	br i1 %59, label %60, label %64

60:
	%61 = load i32, i32* %3
	%62 = load i32, i32* %5
	%63 = add nsw i32 %61, %62
	store i32 %63, i32* %5
	br label %44

64:
	br label %44

65:
	br label %14

66:
	%67 = load i32, i32* %1
	%68 = icmp ne i32 %67, 0
	br i1 %68, label %71, label %69

69:
	%70 = load i32, i32* %1
	call void @printInt(i32 %70)
	br label %71

71:
	%72 = load i32, i32* %2
	call void @printInt(i32 %72)
	%73 = load i32, i32* %3
	call void @printInt(i32 %73)
	%74 = load i32, i32* %4
	call void @printInt(i32 %74)
	%75 = load i32, i32* %5
	call void @printInt(i32 %75)
	%76 = alloca i32
	%77 = load i32, i32* %5
	%78 = load i32, i32* %4
	%79 = call i32 @funcDef_1(i32 %77, i32 %78)
	store i32 %79, i32* %76
	%80 = alloca i32
	%81 = load i32, i32* %76
	%82 = load i32, i32* %3
	%83 = call i32 @funcDef_0(i32 %82)
	%84 = call i32 @funcDef_1(i32 %81, i32 %83)
	store i32 %84, i32* %80
	call void @funcDef_void()
	%85 = load i32, i32* %76
	call void @printInt(i32 %85)
	%86 = load i32, i32* %80
	call void @printInt(i32 %86)
	%87 = load i32, i32* @singleVarDecl
	%88 = load i32, i32* @singleVarDecl_2
	%89 = call i32 @funcDef_1(i32 %87, i32 %88)
	%90 = load i32, i32* @singleConstDecl_0
	%91 = load i32, i32* @singleConstDecl_1
	%92 = call i32 @funcDef_1(i32 %90, i32 %91)
	%93 = call i32 @funcDef_1(i32 %89, i32 %92)
	store i32 %93, i32* @singleVarDecl_2
	%94 = load i32, i32* @singleVarDecl_2
	call void @printInt(i32 %94)
	ret i32 0
}
