declare i32 @getint()
declare i32 @getchar()
declare void @putint(i32)
declare void @putch(i32)
declare void @putstr(i8*)

@str = private unnamed_addr constant [3 x i8] c"0\0A\00", align 1
@str.1 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@str.2 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@str.3 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@str.4 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@str.5 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@str.6 = private unnamed_addr constant [10 x i8] c"19182620\0A\00", align 1
@str.7 = private unnamed_addr constant [10 x i8] c"19182620\0A\00", align 1
@str.8 = private unnamed_addr constant [10 x i8] c"19182620\0A\00", align 1
define dso_local void @de() {
	ret void
}
define dso_local i32 @keke(i32 %0, i32 %1) {
	%3 = alloca i32
	store i32 %0, i32* %3
	%4 = alloca i32
	store i32 %1, i32* %4
	%5 = load i32, i32* %3
	%6 = load i32, i32* %4
	%7 = add nsw i32 %5, %6
	store i32 %7, i32* %3
	ret i32 0
}
define dso_local i32 @jian() {
	%1 = alloca i32
	%2 = alloca i32
	%3 = alloca i32
	%4 = call i32 @getint()
	store i32 %4, i32* %1
	%5 = call i32 @getint()
	store i32 %5, i32* %2
	%6 = load i32, i32* %1
	%7 = load i32, i32* %2
	%8 = sub nsw i32 %6, %7
	store i32 %8, i32* %3
	%9 = load i32, i32* %3
	ret i32 %9
}
define dso_local i32 @main() {
	%1 = alloca i32
	%2 = alloca i32
	%3 = alloca i32
	%4 = alloca i32
	%5 = alloca i32
	%6 = alloca i32
	%7 = alloca i32
	store i32 1, i32* %7
	%8 = alloca i32
	%9 = alloca i32
	%10 = alloca i32
	%11 = alloca i32
	%12 = alloca i32
	store i32 -1, i32* %12
	%13 = alloca i32
	store i32 2, i32* %13
	%14 = alloca i32
	%15 = alloca i32
	%16 = alloca i32
	store i32 0, i32* %16
	%17 = call i32 @getint()
	store i32 %17, i32* %14
	br label %18

18:
	%19 = load i32, i32* %13
	%20 = load i32, i32* %14
	%21 = icmp slt i32 %19, %20
	br i1 %21, label %22, label %32

22:
	%23 = load i32, i32* %14
	%24 = load i32, i32* %13
	%25 = srem i32 %23, %24
	store i32 %25, i32* %15
	%26 = load i32, i32* %15
	%27 = icmp eq i32 %26, 0
	br i1 %27, label %28, label %29

28:
	store i32 1, i32* %16
	call void @putstr(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @str, i64 0, i64 0))
	br label %29

29:
	%30 = load i32, i32* %13
	%31 = add nsw i32 %30, 1
	store i32 %31, i32* %13
	br label %18

32:
	%33 = call i32 @jian()
	store i32 %33, i32* %3
	%34 = load i32, i32* %3
	call void @putint(i32 %34)
	call void @putstr(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @str.1, i64 0, i64 0))
	%35 = load i32, i32* %3
	%36 = add nsw i32 %35, 1
	store i32 %36, i32* %4
	%37 = load i32, i32* %3
	%38 = mul nsw i32 %37, 2
	store i32 %38, i32* %5
	%39 = load i32, i32* %5
	%40 = icmp slt i32 %39, 5
	br i1 %40, label %41, label %44

41:
	%42 = load i32, i32* %3
	%43 = srem i32 %42, 2
	store i32 %43, i32* %6
	br label %47

44:
	%45 = load i32, i32* %3
	%46 = sdiv i32 %45, 2	store i32 %46, i32* %6
	br label %47

47:
	%48 = load i32, i32* %6
	%49 = icmp ne i32 %48, -2
	br i1 %49, label %50, label %53

50:
	%51 = load i32, i32* %7
	%52 = add nsw i32 %51, 1
	store i32 %52, i32* %7
	br label %53

53:
	%54 = load i32, i32* %13
	%55 = load i32, i32* %9
	%56 = add nsw i32 %55, 1
	%57 = add nsw i32 %54, %56
	store i32 %57, i32* %12
	br label %58

58:
	br label %60

59:
	br label %58
	br label %58

60:
	br label %61

61:
	br label %62

62:
	br label %63
	br label %61

63:
	%64 = load i32, i32* %3
	%65 = load i32, i32* %4
	%66 = icmp eq i32 %64, %65
	br i1 %66, label %67, label %87

67:
	%68 = load i32, i32* %4
	%69 = load i32, i32* %5
	%70 = icmp sge i32 %68, %69
	br i1 %70, label %71, label %86

71:
	%72 = load i32, i32* %5
	%73 = load i32, i32* %6
	%74 = icmp sle i32 %72, %73
	br i1 %74, label %75, label %85

75:
	%76 = load i32, i32* %6
	%77 = load i32, i32* %7
	%78 = icmp ne i32 %76, %77
	br i1 %78, label %79, label %84

79:
	%80 = load i32, i32* %3
	%81 = icmp sgt i32 %80, 1
	br i1 %81, label %82, label %83

82:
	store i32 1, i32* %1
	br label %83

83:
	br label %84

84:
	br label %85

85:
	br label %86

86:
	br label %87

87:
	%88 = load i32, i32* %1
	%89 = load i32, i32* %2
	%90 = call i32 @keke(i32 %88, i32 %89)
	%91 = load i32, i32* %4
	%92 = load i32, i32* %5
	%93 = load i32, i32* %6
	%94 = load i32, i32* %7
	call void @putint(i32 %91)
	call void @putstr(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @str.2, i64 0, i64 0))
	call void @putint(i32 %92)
	call void @putstr(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @str.3, i64 0, i64 0))
	call void @putint(i32 %93)
	call void @putstr(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @str.4, i64 0, i64 0))
	call void @putint(i32 %94)
	call void @putstr(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @str.5, i64 0, i64 0))
	call void @putstr(i8* getelementptr inbounds ([10 x i8], [10 x i8]* @str.6, i64 0, i64 0))
	call void @putstr(i8* getelementptr inbounds ([10 x i8], [10 x i8]* @str.7, i64 0, i64 0))
	call void @putstr(i8* getelementptr inbounds ([10 x i8], [10 x i8]* @str.8, i64 0, i64 0))
	ret i32 0
}
