declare i32 @getint()
declare i32 @getchar()
declare void @putint(i32)
declare void @putch(i32)
declare void @putstr(i8*)

@c = dso_local global i32 10
@x = dso_local global i32 zeroinitializer
@.str = private unnamed_addr constant [10 x i8] c"21373457\0A\00", align 1
@.str.1 = private unnamed_addr constant [17 x i8] c"Empty for pass!\0A\00", align 1
@.str.2 = private unnamed_addr constant [20 x i8] c"One stmt for pass!\0A\00", align 1
@.str.3 = private unnamed_addr constant [40 x i8] c"Basic for and no params function pass!\0A\00", align 1
@.str.4 = private unnamed_addr constant [33 x i8] c"Please input 5 number (no zero)\0A\00", align 1
@.str.5 = private unnamed_addr constant [41 x i8] c"Basic for and one params function pass!\0A\00", align 1
@.str.6 = private unnamed_addr constant [46 x i8] c"Basic for and multiple params function pass!\0A\00", align 1
@.str.7 = private unnamed_addr constant [28 x i8] c"Recursive Success, count = \00", align 1
@.str.8 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.9 = private unnamed_addr constant [80 x i8] c"This C level file include decl, if, for ,continue, break, basic cond. No block\0A\00", align 1
@.str.10 = private unnamed_addr constant [14 x i8] c"Pass Success!\00", align 1
define dso_local void @f1() {
	%1 = alloca i32
	store i32 0, i32* %1
	br label %2

2:
	%3 = load i32, i32* %1
	%4 = icmp slt i32 %3, 5
	br i1 %4, label %5, label %11

5:
	%6 = load i32, i32* @x
	%7 = add nsw i32 %6, 1
	store i32 %7, i32* @x
	br label %8

8:
	%9 = load i32, i32* %1
	%10 = add nsw i32 %9, 1
	store i32 %10, i32* %1
	br label %2

11:
	ret void
}
define dso_local i32 @f2() {
	%1 = load i32, i32* @x
	%2 = icmp sgt i32 %1, 0
	br i1 %2, label %3, label %4

3:
	ret i32 -1

4:
	ret i32 1

5:
	%6 = load i32, i32* @x
	ret i32 %6
}
define dso_local void @f3(i32 %0) {
	%2 = alloca i32
	store i32 %0, i32* %2
	%3 = load i32, i32* %2
	store i32 %3, i32* @x
	ret void
}
define dso_local i32 @f4(i32 %0) {
	%2 = alloca i32
	store i32 %0, i32* %2
	%3 = load i32, i32* %2
	%4 = icmp sgt i32 %3, 0
	br i1 %4, label %5, label %8

5:
	%6 = load i32, i32* %2
	%7 = add nsw i32 0, %6
	ret i32 %7

8:
	%9 = load i32, i32* %2
	%10 = sub nsw i32 0, %9
	ret i32 %10
}
define dso_local i32 @f5(i32 %0, i32 %1, i32 %2) {
	%4 = alloca i32
	store i32 %0, i32* %4
	%5 = alloca i32
	store i32 %1, i32* %5
	%6 = alloca i32
	store i32 %2, i32* %6
	%7 = load i32, i32* %4
	%8 = load i32, i32* %5
	%9 = icmp sgt i32 %7, %8
	br i1 %9, label %10, label %19

10:
	%11 = load i32, i32* %4
	%12 = load i32, i32* %6
	%13 = icmp sgt i32 %11, %12
	br i1 %13, label %14, label %16

14:
	%15 = load i32, i32* %4
	ret i32 %15

16:
	%17 = load i32, i32* %6
	ret i32 %17

18:
	br label %19

19:
	%20 = load i32, i32* %5
	%21 = load i32, i32* %6
	%22 = icmp sgt i32 %20, %21
	br i1 %22, label %23, label %32

23:
	%24 = load i32, i32* %5
	%25 = load i32, i32* %4
	%26 = icmp sgt i32 %24, %25
	br i1 %26, label %27, label %29

27:
	%28 = load i32, i32* %5
	ret i32 %28

29:
	%30 = load i32, i32* %4
	ret i32 %30

31:
	br label %32

32:
	%33 = load i32, i32* %6
	%34 = load i32, i32* %4
	%35 = icmp sgt i32 %33, %34
	br i1 %35, label %36, label %45

36:
	%37 = load i32, i32* %6
	%38 = load i32, i32* %5
	%39 = icmp sgt i32 %37, %38
	br i1 %39, label %40, label %42

40:
	%41 = load i32, i32* %6
	ret i32 %41

42:
	%43 = load i32, i32* %5
	ret i32 %43

44:
	br label %45

45:
	%46 = load i32, i32* %4
	%47 = call i32 @f4(i32 %46)
	ret i32 %47
}
define dso_local i32 @f6(i32 %0) {
	%2 = alloca i32
	store i32 %0, i32* %2
	%3 = load i32, i32* @x
	%4 = load i32, i32* %2
	%5 = add nsw i32 %3, %4
	store i32 %5, i32* @x
	%6 = load i32, i32* %2
	%7 = icmp eq i32 %6, 0
	br i1 %7, label %8, label %9

8:
	ret i32 0

9:
	%10 = load i32, i32* %2
	%11 = sub nsw i32 %10, 1
	%12 = call i32 @f6(i32 %11)
	ret i32 %12
}
define dso_local i32 @main() {
	call void @putstr(i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str, i64 0, i64 0))
	%1 = alloca i32
	%2 = alloca i32
	store i32 5, i32* %2
	%3 = alloca i32
	store i32 0, i32* %1
	br label %4

4:
	%5 = load i32, i32* %1
	%6 = icmp slt i32 %5, 5
	br i1 %6, label %7, label %11

7:
	br label %8

8:
	%9 = load i32, i32* %1
	%10 = add nsw i32 %9, 1
	store i32 %10, i32* %1
	br label %4

11:
	%12 = load i32, i32* %1
	%13 = icmp eq i32 %12, 5
	br i1 %13, label %14, label %15

14:
	call void @putstr(i8* getelementptr inbounds ([17 x i8], [17 x i8]* @.str.1, i64 0, i64 0))
	br label %15

15:
	store i32 0, i32* %1
	br label %16

16:
	%17 = load i32, i32* %1
	%18 = icmp slt i32 %17, 2
	br i1 %18, label %19, label %22

19:
	%20 = load i32, i32* %1
	%21 = add nsw i32 %20, 1
	store i32 %21, i32* %1
	br label %16

22:
	store i32 2, i32* %1
	br label %23

23:
	%24 = load i32, i32* %1
	%25 = icmp eq i32 %24, 4
	br i1 %25, label %26, label %27

26:
	br label %31

27:
	br label %28

28:
	%29 = load i32, i32* %1
	%30 = add nsw i32 %29, 1
	store i32 %30, i32* %1
	br label %23

31:
	br label %32

32:
	%33 = load i32, i32* %1
	%34 = icmp slt i32 %33, 5
	br i1 %34, label %35, label %45

35:
	%36 = load i32, i32* %1
	%37 = icmp slt i32 %36, 5
	br i1 %37, label %38, label %39

38:
	br label %42

39:
	%40 = load i32, i32* %1
	%41 = add nsw i32 %40, 2
	store i32 %41, i32* %1
	br label %42

42:
	%43 = load i32, i32* %1
	%44 = add nsw i32 %43, 1
	store i32 %44, i32* %1
	br label %32

45:
	store i32 5, i32* %1
	br label %46

46:
	%47 = load i32, i32* %1
	%48 = add nsw i32 %47, 1
	store i32 %48, i32* %1
	%49 = load i32, i32* %1
	%50 = icmp eq i32 %49, 6
	br i1 %50, label %51, label %52

51:
	br label %53

52:
	br label %46

53:
	br label %54

54:
	%55 = load i32, i32* %1
	%56 = icmp slt i32 %55, 7
	br i1 %56, label %57, label %60

57:
	%58 = load i32, i32* %1
	%59 = add nsw i32 %58, 1
	store i32 %59, i32* %1
	br label %54

60:
	br label %61

61:
	%62 = load i32, i32* %1
	%63 = icmp eq i32 %62, 8
	br i1 %63, label %64, label %65

64:
	br label %69

65:
	br label %66

66:
	%67 = load i32, i32* %1
	%68 = add nsw i32 %67, 1
	store i32 %68, i32* %1
	br label %61

69:
	br label %70

70:
	%71 = load i32, i32* %1
	%72 = add nsw i32 %71, 1
	store i32 %72, i32* %1
	%73 = load i32, i32* %1
	%74 = icmp eq i32 %73, 10
	br i1 %74, label %75, label %76

75:
	call void @putstr(i8* getelementptr inbounds ([20 x i8], [20 x i8]* @.str.2, i64 0, i64 0))
	br label %77

76:
	br label %70

77:
	call void @f1()
	%78 = load i32, i32* @x
	%79 = icmp eq i32 %78, 5
	br i1 %79, label %80, label %85

80:
	%81 = call i32 @f2()
	%82 = icmp eq i32 %81, -1
	br i1 %82, label %83, label %84

83:
	call void @putstr(i8* getelementptr inbounds ([40 x i8], [40 x i8]* @.str.3, i64 0, i64 0))
	br label %84

84:
	br label %85

85:
	call void @putstr(i8* getelementptr inbounds ([33 x i8], [33 x i8]* @.str.4, i64 0, i64 0))
	store i32 -1, i32* @x
	store i32 0, i32* %1
	br label %86

86:
	%87 = load i32, i32* %1
	%88 = load i32, i32* %1
	%89 = mul nsw i32 %87, %88
	%90 = load i32, i32* %2
	%91 = load i32, i32* %2
	%92 = mul nsw i32 %90, %91
	%93 = sdiv i32 %92, 1
	%94 = icmp slt i32 %89, %93
	br i1 %94, label %95, label %112

95:
	%96 = call i32 @getint()
	store i32 %96, i32* %3
	%97 = load i32, i32* %3
	%98 = call i32 @f4(i32 %97)
	call void @f3(i32 %98)
	%99 = load i32, i32* @x
	%100 = icmp slt i32 %99, 0
	br i1 %100, label %101, label %102

101:
	br label %112

102:
	%103 = load i32, i32* @x
	%104 = icmp sgt i32 %103, 0
	br i1 %104, label %105, label %106

105:
	br label %109

106:
	%107 = load i32, i32* %1
	%108 = add nsw i32 %107, 1
	store i32 %108, i32* %1
	br label %109

109:
	%110 = load i32, i32* %1
	%111 = add nsw i32 %110, 1
	store i32 %111, i32* %1
	br label %86

112:
	%113 = load i32, i32* @x
	%114 = icmp sge i32 %113, 0
	br i1 %114, label %115, label %116

115:
	call void @putstr(i8* getelementptr inbounds ([41 x i8], [41 x i8]* @.str.5, i64 0, i64 0))
	br label %116

116:
	store i32 10, i32* %1
	store i32 5, i32* %2
	store i32 7, i32* %3
	%117 = load i32, i32* %1
	%118 = load i32, i32* %2
	%119 = load i32, i32* %3
	%120 = call i32 @f5(i32 %117, i32 %118, i32 %119)
	%121 = load i32, i32* %1
	%122 = icmp eq i32 %120, %121
	br i1 %122, label %123, label %124

123:
	call void @putstr(i8* getelementptr inbounds ([46 x i8], [46 x i8]* @.str.6, i64 0, i64 0))
	br label %124

124:
	store i32 0, i32* @x
	%125 = load i32, i32* @c
	%126 = call i32 @f6(i32 %125)
	%127 = load i32, i32* @x
	call void @putstr(i8* getelementptr inbounds ([28 x i8], [28 x i8]* @.str.7, i64 0, i64 0))
	call void @putint(i32 %127)
	call void @putstr(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.8, i64 0, i64 0))
	call void @putstr(i8* getelementptr inbounds ([80 x i8], [80 x i8]* @.str.9, i64 0, i64 0))
	call void @putstr(i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.10, i64 0, i64 0))
	ret i32 0
}
