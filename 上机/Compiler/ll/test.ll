declare i32 @getint()
declare i32 @getchar()
declare void @putint(i32)
declare void @putch(i32)
declare void @putstr(i8*)

@global = dso_local global i32 0
@.str = private unnamed_addr constant [10 x i8] c"21376218\0A\00", align 1
@.str.1 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.2 = private unnamed_addr constant [14 x i8] c"Finish test1\0A\00", align 1
define dso_local i32 @func_cond() {
	%1 = load i32, i32* @global
	%2 = add nsw i32 %1, 1
	store i32 %2, i32* @global
	%3 = load i32, i32* @global
	ret i32 %3
}
define dso_local void @test_if() {
	br label %5

1:
	%2 = call i32 @func_cond()
	%3 = icmp ne i32 %2, 0
	br i1 %3, label %4, label %5

4:
	br label %5

5:
	br label %9

6:
	%7 = call i32 @func_cond()
	%8 = icmp ne i32 %7, 0
	br i1 %8, label %9, label %10

9:
	br label %10

10:
	br label %11

11:
	%12 = call i32 @func_cond()
	%13 = icmp ne i32 %12, 0
	br i1 %13, label %14, label %19

14:
	br label %19

15:
	%16 = call i32 @func_cond()
	%17 = icmp ne i32 %16, 0
	br i1 %17, label %18, label %19

18:
	br label %19

19:
	br label %20

20:
	%21 = call i32 @func_cond()
	%22 = icmp ne i32 %21, 0
	br i1 %22, label %23, label %27

23:
	br label %27

24:
	%25 = call i32 @func_cond()
	%26 = icmp ne i32 %25, 0
	br i1 %26, label %28, label %27

27:
	br label %28

28:
	br label %32

29:
	%30 = call i32 @func_cond()
	%31 = icmp ne i32 %30, 0
	br i1 %31, label %36, label %32

32:
	%33 = call i32 @func_cond()
	%34 = icmp ne i32 %33, 0
	br i1 %34, label %35, label %37

35:
	br label %36

36:
	br label %37

37:
	br label %38

38:
	%39 = call i32 @func_cond()
	%40 = icmp ne i32 %39, 0
	br i1 %40, label %46, label %41

41:
	%42 = call i32 @func_cond()
	%43 = icmp ne i32 %42, 0
	br i1 %43, label %44, label %46

44:
	br label %45

45:
	br label %46

46:
	br label %50

47:
	%48 = call i32 @func_cond()
	%49 = icmp ne i32 %48, 0
	br i1 %49, label %53, label %50

50:
	%51 = call i32 @func_cond()
	%52 = icmp ne i32 %51, 0
	br i1 %52, label %53, label %54

53:
	br label %54

54:
	%55 = call i32 @func_cond()
	%56 = icmp ne i32 %55, 0
	br i1 %56, label %57, label %61

57:
	br label %58

58:
	%59 = call i32 @func_cond()
	%60 = icmp ne i32 %59, 0
	br i1 %60, label %61, label %62

61:
	br label %62

62:
	%63 = call i32 @func_cond()
	%64 = icmp eq i32 1, %63
	br i1 %64, label %65, label %66

65:
	br label %66

66:
	%67 = call i32 @func_cond()
	%68 = icmp ne i32 1, %67
	br i1 %68, label %69, label %70

69:
	br label %70

70:
	ret void
}
define dso_local i32 @main() {
	call void @putstr(i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str, i64 0, i64 0))
	call void @test_if()
	%1 = load i32, i32* @global
	call void @putint(i32 %1)
	call void @putstr(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.1, i64 0, i64 0))
	call void @putstr(i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.2, i64 0, i64 0))
	ret i32 0
}
