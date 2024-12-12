declare i32 @getint()
declare i32 @getchar()
declare void @putint(i32)
declare void @putch(i32)
declare void @putstr(i8*)

@const_int_a = dso_local global i32 0
@const_int_b1 = dso_local global i32 1
@const_int_b2 = dso_local global [5 x i32] [i32 0,i32 1,i32 2,i32 3,i32 4]
@str = dso_local global [10 x i8] [i8 104,i8 101,i8 108,i8 108,i8 111,i8 33,i8 0,i8 0,i8 0,i8 0]
@char_a = dso_local global i8 97
@char_b1 = dso_local global i8 98
@char_b2 = dso_local global [5 x i8] [i8 97,i8 98,i8 99,i8 100,i8 101]
@char_b3 = dso_local global [10 x i8] [i8 119,i8 111,i8 114,i8 108,i8 100,i8 33,i8 0,i8 0,i8 0,i8 0]
@int_b2 = dso_local global [5 x i32] zeroinitializer
@.str = private unnamed_addr constant [2 x i8] c" \00", align 1
@.str.1 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.2 = private unnamed_addr constant [32 x i8] c"test_stmt_getint_getchar_printf\00", align 1
@.str.3 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.4 = private unnamed_addr constant [24 x i8] c"test_Lval_exp success!\0A\00", align 1
@.str.5 = private unnamed_addr constant [27 x i8] c"test_primary_exp success!\0A\00", align 1
@.str.6 = private unnamed_addr constant [25 x i8] c"test_unary_exp success!\0A\00", align 1
@.str.7 = private unnamed_addr constant [23 x i8] c"test_mul_exp success!\0A\00", align 1
@.str.8 = private unnamed_addr constant [23 x i8] c"test_add_exp_success!\0A\00", align 1
@.str.9 = private unnamed_addr constant [23 x i8] c"test_rel_exp success!\0A\00", align 1
@.str.10 = private unnamed_addr constant [21 x i8] c"test_Eqexp success!\0A\00", align 1
@.str.11 = private unnamed_addr constant [20 x i8] c"test_Lexp success!\0A\00", align 1
@.str.12 = private unnamed_addr constant [10 x i8] c"22371236\0A\00", align 1
define dso_local void @print_int_arr(i32* %0, i32 %1) {
	%3 = alloca i32*
	store i32* %0, i32** %3
	%4 = alloca i32
	store i32 %1, i32* %4
	%5 = alloca i32
	store i32 0, i32* %5
	store i32 0, i32* %5
	br label %6

6:
	%7 = load i32, i32* %5
	%8 = load i32, i32* %4
	%9 = icmp slt i32 %7, %8
	br i1 %9, label %10, label %18

10:
	%11 = load i32, i32* %5
	%12 = load i32*, i32** %3
	%13 = getelementptr inbounds i32, i32* %12, i32 %11
	%14 = load i32, i32* %13
	call void @putint(i32 %14)
	call void @putstr(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str, i64 0, i64 0))
	br label %15

15:
	%16 = load i32, i32* %5
	%17 = add nsw i32 %16, 1
	store i32 %17, i32* %5
	br label %6

18:
	call void @putstr(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.1, i64 0, i64 0))
	ret void
}
define dso_local void @test_stmt_1_3() {
	store i8 65, i8* @char_a
	ret void
}
define dso_local void @test_stmt_if_else() {
	%1 = icmp slt i32 1, 2
	br i1 %1, label %2, label %3

2:
	br label %3

3:
	%4 = icmp sgt i32 1, 2
	br i1 %4, label %5, label %6

5:
	br label %7

6:
	br label %7

7:
	ret void
}
define dso_local void @test_stmt_for_break_continue() {
	%1 = alloca i32
	store i32 0, i32* %1
	%2 = alloca i32
	store i32 1, i32* %2
	store i32 0, i32* %1
	br label %3

3:
	%4 = load i32, i32* %1
	%5 = load i32, i32* %2
	%6 = icmp slt i32 %4, %5
	br i1 %6, label %7, label %13

7:
	%8 = load i32, i32* %1
	%9 = add nsw i32 %8, 1
	store i32 %9, i32* %1
	br label %10

10:
	%11 = load i32, i32* %1
	%12 = add nsw i32 %11, 1
	store i32 %12, i32* %1
	br label %3

13:
	store i32 0, i32* %1
	br label %14

14:
	%15 = load i32, i32* %1
	%16 = load i32, i32* %2
	%17 = icmp slt i32 %15, %16
	br i1 %17, label %18, label %22

18:
	br label %19

19:
	%20 = load i32, i32* %1
	%21 = add nsw i32 %20, 1
	store i32 %21, i32* %1
	br label %14

22:
	store i32 0, i32* %1
	br label %23

23:
	br label %27

24:
	%25 = load i32, i32* %1
	%26 = add nsw i32 %25, 1
	store i32 %26, i32* %1
	br label %23

27:
	store i32 0, i32* %1
	br label %28

28:
	%29 = load i32, i32* %1
	%30 = load i32, i32* %2
	%31 = icmp slt i32 %29, %30
	br i1 %31, label %32, label %35

32:
	%33 = load i32, i32* %1
	%34 = add nsw i32 %33, 1
	store i32 %34, i32* %1
	br label %28

35:
	br label %36

36:
	br label %40

37:
	%38 = load i32, i32* %1
	%39 = add nsw i32 %38, 1
	store i32 %39, i32* %1
	br label %36

40:
	store i32 0, i32* %1
	br label %41

41:
	%42 = load i32, i32* %1
	%43 = load i32, i32* %2
	%44 = icmp slt i32 %42, %43
	br i1 %44, label %45, label %46

45:
	br label %46

46:
	store i32 0, i32* %1
	br label %47

47:
	br label %48

48:
	br label %49

49:
	br label %50

50:
	ret void
}
define dso_local void @test_stmt_return_null() {
	ret void
}
define dso_local i32 @test_stmt_return_exp() {
	ret i32 1
}
define dso_local void @test_stmt_getint_getchar_printf() {
	%1 = alloca i32
	store i32 1, i32* %1
	%2 = alloca i8
	store i8 97, i8* %2
	%3 = call i32 @getint()
	store i32 %3, i32* %1
	%4 = call i32 @getchar()
	%5 = trunc i32 %4 to i8
	store i8 %5, i8* %2
	call void @putstr(i8* getelementptr inbounds ([32 x i8], [32 x i8]* @.str.2, i64 0, i64 0))
	call void @putch(i32 115)
	call void @putch(i32 117)
	call void @putch(i32 99)
	call void @putch(i32 99)
	call void @putch(i32 101)
	call void @putch(i32 115)
	call void @putch(i32 115)
	call void @putstr(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.3, i64 0, i64 0))
	ret void
}
define dso_local void @test_block() {
	ret void
}
define dso_local i32 @add_int(i32 %0, i32 %1) {
	%3 = alloca i32
	store i32 %0, i32* %3
	%4 = alloca i32
	store i32 %1, i32* %4
	%5 = load i32, i32* %3
	%6 = load i32, i32* %4
	%7 = add nsw i32 %5, %6
	ret i32 %7
}
define dso_local i8 @read_char(i8 %0) {
	%2 = alloca i8
	store i8 %0, i8* %2
	%3 = load i8, i8* %2
	ret i8 %3
}
define dso_local void @test_Lval_exp() {
	%1 = load i32, i32* @const_int_a
	%2 = load i8, i8* @char_a
	%3 = getelementptr inbounds [5 x i8], [5 x i8]* @char_b2, i32 0, i32 0
	%4 = load i8, i8* %3
	call void @putstr(i8* getelementptr inbounds ([24 x i8], [24 x i8]* @.str.4, i64 0, i64 0))
	ret void
}
define dso_local void @test_primary_exp() {
	%1 = load i8, i8* @char_a
	call void @putstr(i8* getelementptr inbounds ([27 x i8], [27 x i8]* @.str.5, i64 0, i64 0))
	ret void
}
define dso_local void @test_func_int(i32 %0) {
	%2 = alloca i32
	store i32 %0, i32* %2
	ret void
}
define dso_local void @test_func_int_arr(i32* %0) {
	%2 = alloca i32*
	store i32* %0, i32** %2
	ret void
}
define dso_local void @test_func_mul_int(i32 %0, i32 %1) {
	%3 = alloca i32
	store i32 %0, i32* %3
	%4 = alloca i32
	store i32 %1, i32* %4
	ret void
}
define dso_local void @test_unary_exp() {
	call void @test_func_int(i32 0)
	%1 = getelementptr inbounds [5 x i32], [5 x i32]* @int_b2, i32 0, i32 0
	%2 = load i32, i32* %1
	call void @test_func_int(i32 %2)
	call void @test_func_int_arr(i32* @int_b2)
	call void @test_func_mul_int(i32 0, i32 1)
	br label %4

3:
	br label %4

4:
	call void @putstr(i8* getelementptr inbounds ([25 x i8], [25 x i8]* @.str.6, i64 0, i64 0))
	ret void
}
define dso_local void @test_mul_exp() {
	call void @putstr(i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str.7, i64 0, i64 0))
	ret void
}
define dso_local void @test_add_exp() {
	call void @putstr(i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str.8, i64 0, i64 0))
	ret void
}
define dso_local void @test_rel_exp() {
	%1 = icmp slt i32 1, 2
	br i1 %1, label %2, label %3

2:
	br label %3

3:
	%4 = icmp sgt i32 1, 2
	br i1 %4, label %5, label %6

5:
	br label %6

6:
	%7 = icmp sle i32 1, 2
	br i1 %7, label %8, label %9

8:
	br label %9

9:
	%10 = icmp sge i32 1, 2
	br i1 %10, label %11, label %12

11:
	br label %12

12:
	call void @putstr(i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str.9, i64 0, i64 0))
	ret void
}
define dso_local void @test_Eqexp() {
	%1 = icmp eq i32 1, 1
	br i1 %1, label %2, label %3

2:
	br label %3

3:
	%4 = icmp ne i32 1, 1
	br i1 %4, label %5, label %6

5:
	br label %6

6:
	call void @putstr(i8* getelementptr inbounds ([21 x i8], [21 x i8]* @.str.10, i64 0, i64 0))
	ret void
}
define dso_local void @test_Lexp() {
	br label %1

1:
	br label %2

2:
	br label %3

3:
	br label %5

4:
	br label %5

5:
	br label %6

6:
	call void @putstr(i8* getelementptr inbounds ([20 x i8], [20 x i8]* @.str.11, i64 0, i64 0))
	ret void
}
define dso_local void @test() {
	call void @test_stmt_1_3()
	call void @test_stmt_for_break_continue()
	call void @test_stmt_getint_getchar_printf()
	call void @test_stmt_if_else()
	%1 = call i32 @test_stmt_return_exp()
	call void @test_stmt_return_null()
	call void @test_Eqexp()
	call void @test_Lval_exp()
	call void @test_add_exp()
	call void @test_mul_exp()
	call void @test_primary_exp()
	call void @test_rel_exp()
	call void @test_unary_exp()
	ret void
}
define dso_local i32 @main() {
	call void @putstr(i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.12, i64 0, i64 0))
	call void @test()
	ret i32 0
}
