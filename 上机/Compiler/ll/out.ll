; ModuleID = 'llvm-link'
source_filename = "llvm-link"
target datalayout = "e-m:o-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx13.3.0"

@const_int_a = dso_local global i32 0
@const_int_b1 = dso_local global i32 1
@const_int_b2 = dso_local global [5 x i32] [i32 0, i32 1, i32 2, i32 3, i32 4]
@str = dso_local global [10 x i8] c"hello!\00\00\00\00"
@char_a = dso_local global i8 97
@char_b1 = dso_local global i8 98
@char_b2 = dso_local global [5 x i8] c"abcde"
@char_b3 = dso_local global [10 x i8] c"world!\00\00\00\00"
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
@.str.13 = private unnamed_addr constant [3 x i8] c"%c\00", align 1
@.str.1.16 = private unnamed_addr constant [3 x i8] c"%d\00", align 1
@.str.2.21 = private unnamed_addr constant [4 x i8] c"%d:\00", align 1
@.str.3.22 = private unnamed_addr constant [4 x i8] c" %d\00", align 1
@.str.4.23 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.5.26 = private unnamed_addr constant [3 x i8] c"%s\00", align 1

define dso_local void @print_int_arr(ptr %0, i32 %1) {
  %3 = alloca ptr, align 8
  store ptr %0, ptr %3, align 8
  %4 = alloca i32, align 4
  store i32 %1, ptr %4, align 4
  %5 = alloca i32, align 4
  store i32 0, ptr %5, align 4
  store i32 0, ptr %5, align 4
  br label %6

6:                                                ; preds = %15, %2
  %7 = load i32, ptr %5, align 4
  %8 = load i32, ptr %4, align 4
  %9 = icmp slt i32 %7, %8
  br i1 %9, label %10, label %18

10:                                               ; preds = %6
  %11 = load i32, ptr %5, align 4
  %12 = load ptr, ptr %3, align 8
  %13 = getelementptr inbounds i32, ptr %12, i32 %11
  %14 = load i32, ptr %13, align 4
  call void @putint(i32 %14)
  call void @putstr(ptr @.str)
  br label %15

15:                                               ; preds = %10
  %16 = load i32, ptr %5, align 4
  %17 = add nsw i32 %16, 1
  store i32 %17, ptr %5, align 4
  br label %6

18:                                               ; preds = %6
  call void @putstr(ptr @.str.1)
  ret void
}

define dso_local void @test_stmt_1_3() {
  store i8 65, ptr @char_a, align 1
  ret void
}

define dso_local void @test_stmt_if_else() {
  %1 = icmp slt i32 1, 2
  br i1 %1, label %2, label %3

2:                                                ; preds = %0
  br label %3

3:                                                ; preds = %2, %0
  %4 = icmp sgt i32 1, 2
  br i1 %4, label %5, label %6

5:                                                ; preds = %3
  br label %7

6:                                                ; preds = %3
  br label %7

7:                                                ; preds = %6, %5
  ret void
}

define dso_local void @test_stmt_for_break_continue() {
  %1 = alloca i32, align 4
  store i32 0, ptr %1, align 4
  %2 = alloca i32, align 4
  store i32 1, ptr %2, align 4
  store i32 0, ptr %1, align 4
  br label %3

3:                                                ; preds = %10, %0
  %4 = load i32, ptr %1, align 4
  %5 = load i32, ptr %2, align 4
  %6 = icmp slt i32 %4, %5
  br i1 %6, label %7, label %13

7:                                                ; preds = %3
  %8 = load i32, ptr %1, align 4
  %9 = add nsw i32 %8, 1
  store i32 %9, ptr %1, align 4
  br label %10

10:                                               ; preds = %7
  %11 = load i32, ptr %1, align 4
  %12 = add nsw i32 %11, 1
  store i32 %12, ptr %1, align 4
  br label %3

13:                                               ; preds = %3
  store i32 0, ptr %1, align 4
  br label %14

14:                                               ; preds = %19, %13
  %15 = load i32, ptr %1, align 4
  %16 = load i32, ptr %2, align 4
  %17 = icmp slt i32 %15, %16
  br i1 %17, label %18, label %22

18:                                               ; preds = %14
  br label %19

19:                                               ; preds = %18
  %20 = load i32, ptr %1, align 4
  %21 = add nsw i32 %20, 1
  store i32 %21, ptr %1, align 4
  br label %14

22:                                               ; preds = %14
  store i32 0, ptr %1, align 4
  br label %23

23:                                               ; preds = %24, %22
  br label %27

24:                                               ; No predecessors!
  %25 = load i32, ptr %1, align 4
  %26 = add nsw i32 %25, 1
  store i32 %26, ptr %1, align 4
  br label %23

27:                                               ; preds = %23
  store i32 0, ptr %1, align 4
  br label %28

28:                                               ; preds = %32, %27
  %29 = load i32, ptr %1, align 4
  %30 = load i32, ptr %2, align 4
  %31 = icmp slt i32 %29, %30
  br i1 %31, label %32, label %35

32:                                               ; preds = %28
  %33 = load i32, ptr %1, align 4
  %34 = add nsw i32 %33, 1
  store i32 %34, ptr %1, align 4
  br label %28

35:                                               ; preds = %28
  br label %36

36:                                               ; preds = %37, %35
  br label %40

37:                                               ; No predecessors!
  %38 = load i32, ptr %1, align 4
  %39 = add nsw i32 %38, 1
  store i32 %39, ptr %1, align 4
  br label %36

40:                                               ; preds = %36
  store i32 0, ptr %1, align 4
  br label %41

41:                                               ; preds = %40
  %42 = load i32, ptr %1, align 4
  %43 = load i32, ptr %2, align 4
  %44 = icmp slt i32 %42, %43
  br i1 %44, label %45, label %46

45:                                               ; preds = %41
  br label %46

46:                                               ; preds = %45, %41
  store i32 0, ptr %1, align 4
  br label %47

47:                                               ; preds = %46
  br label %48

48:                                               ; preds = %47
  br label %49

49:                                               ; preds = %48
  br label %50

50:                                               ; preds = %49
  ret void
}

define dso_local void @test_stmt_return_null() {
  ret void
}

define dso_local i32 @test_stmt_return_exp() {
  ret i32 1
}

define dso_local void @test_stmt_getint_getchar_printf() {
  %1 = alloca i32, align 4
  store i32 1, ptr %1, align 4
  %2 = alloca i8, align 1
  store i8 97, ptr %2, align 1
  %3 = call i32 @getint()
  store i32 %3, ptr %1, align 4
  %4 = call i32 @getchar()
  %5 = trunc i32 %4 to i8
  store i8 %5, ptr %2, align 1
  call void @putstr(ptr @.str.2)
  call void @putch(i32 115)
  call void @putch(i32 117)
  call void @putch(i32 99)
  call void @putch(i32 99)
  call void @putch(i32 101)
  call void @putch(i32 115)
  call void @putch(i32 115)
  call void @putstr(ptr @.str.3)
  ret void
}

define dso_local void @test_block() {
  ret void
}

define dso_local i32 @add_int(i32 %0, i32 %1) {
  %3 = alloca i32, align 4
  store i32 %0, ptr %3, align 4
  %4 = alloca i32, align 4
  store i32 %1, ptr %4, align 4
  %5 = load i32, ptr %3, align 4
  %6 = load i32, ptr %4, align 4
  %7 = add nsw i32 %5, %6
  ret i32 %7
}

define dso_local i8 @read_char(i8 %0) {
  %2 = alloca i8, align 1
  store i8 %0, ptr %2, align 1
  %3 = load i8, ptr %2, align 1
  ret i8 %3
}

define dso_local void @test_Lval_exp() {
  %1 = load i32, ptr @const_int_a, align 4
  %2 = load i8, ptr @char_a, align 1
  %3 = getelementptr inbounds [5 x i8], ptr @char_b2, i32 0, i32 0
  %4 = load i8, ptr %3, align 1
  call void @putstr(ptr @.str.4)
  ret void
}

define dso_local void @test_primary_exp() {
  %1 = load i8, ptr @char_a, align 1
  call void @putstr(ptr @.str.5)
  ret void
}

define dso_local void @test_func_int(i32 %0) {
  %2 = alloca i32, align 4
  store i32 %0, ptr %2, align 4
  ret void
}

define dso_local void @test_func_int_arr(ptr %0) {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  ret void
}

define dso_local void @test_func_mul_int(i32 %0, i32 %1) {
  %3 = alloca i32, align 4
  store i32 %0, ptr %3, align 4
  %4 = alloca i32, align 4
  store i32 %1, ptr %4, align 4
  ret void
}

define dso_local void @test_unary_exp() {
  call void @test_func_int(i32 0)
  %1 = getelementptr inbounds [5 x i32], ptr @int_b2, i32 0, i32 0
  %2 = load i32, ptr %1, align 4
  call void @test_func_int(i32 %2)
  call void @test_func_int_arr(ptr @int_b2)
  call void @test_func_mul_int(i32 0, i32 1)
  br label %4

3:                                                ; No predecessors!
  br label %4

4:                                                ; preds = %3, %0
  call void @putstr(ptr @.str.6)
  ret void
}

define dso_local void @test_mul_exp() {
  call void @putstr(ptr @.str.7)
  ret void
}

define dso_local void @test_add_exp() {
  call void @putstr(ptr @.str.8)
  ret void
}

define dso_local void @test_rel_exp() {
  %1 = icmp slt i32 1, 2
  br i1 %1, label %2, label %3

2:                                                ; preds = %0
  br label %3

3:                                                ; preds = %2, %0
  %4 = icmp sgt i32 1, 2
  br i1 %4, label %5, label %6

5:                                                ; preds = %3
  br label %6

6:                                                ; preds = %5, %3
  %7 = icmp sle i32 1, 2
  br i1 %7, label %8, label %9

8:                                                ; preds = %6
  br label %9

9:                                                ; preds = %8, %6
  %10 = icmp sge i32 1, 2
  br i1 %10, label %11, label %12

11:                                               ; preds = %9
  br label %12

12:                                               ; preds = %11, %9
  call void @putstr(ptr @.str.9)
  ret void
}

define dso_local void @test_Eqexp() {
  %1 = icmp eq i32 1, 1
  br i1 %1, label %2, label %3

2:                                                ; preds = %0
  br label %3

3:                                                ; preds = %2, %0
  %4 = icmp ne i32 1, 1
  br i1 %4, label %5, label %6

5:                                                ; preds = %3
  br label %6

6:                                                ; preds = %5, %3
  call void @putstr(ptr @.str.10)
  ret void
}

define dso_local void @test_Lexp() {
  br label %1

1:                                                ; preds = %0
  br label %2

2:                                                ; preds = %1
  br label %3

3:                                                ; preds = %2
  br label %5

4:                                                ; No predecessors!
  br label %5

5:                                                ; preds = %4, %3
  br label %6

6:                                                ; preds = %5
  call void @putstr(ptr @.str.11)
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
  call void @putstr(ptr @.str.12)
  call void @test()
  ret i32 0
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define i32 @getchar() #0 {
  %1 = alloca i8, align 1
  %2 = call i32 (ptr, ...) @scanf(ptr noundef @.str.13, ptr noundef %1)
  %3 = load i8, ptr %1, align 1
  %4 = sext i8 %3 to i32
  ret i32 %4
}

declare i32 @scanf(ptr noundef, ...) #1

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define i32 @getint() #0 {
  %1 = alloca i32, align 4
  %2 = call i32 (ptr, ...) @scanf(ptr noundef @.str.1.16, ptr noundef %1)
  br label %3

3:                                                ; preds = %6, %0
  %4 = call i32 @getchar()
  %5 = icmp ne i32 %4, 10
  br i1 %5, label %6, label %7

6:                                                ; preds = %3
  br label %3, !llvm.loop !6

7:                                                ; preds = %3
  %8 = load i32, ptr %1, align 4
  ret i32 %8
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define i32 @getarray(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store ptr %0, ptr %2, align 8
  %5 = call i32 (ptr, ...) @scanf(ptr noundef @.str.1.16, ptr noundef %3)
  store i32 0, ptr %4, align 4
  br label %6

6:                                                ; preds = %16, %1
  %7 = load i32, ptr %4, align 4
  %8 = load i32, ptr %3, align 4
  %9 = icmp slt i32 %7, %8
  br i1 %9, label %10, label %19

10:                                               ; preds = %6
  %11 = load ptr, ptr %2, align 8
  %12 = load i32, ptr %4, align 4
  %13 = sext i32 %12 to i64
  %14 = getelementptr inbounds i32, ptr %11, i64 %13
  %15 = call i32 (ptr, ...) @scanf(ptr noundef @.str.1.16, ptr noundef %14)
  br label %16

16:                                               ; preds = %10
  %17 = load i32, ptr %4, align 4
  %18 = add nsw i32 %17, 1
  store i32 %18, ptr %4, align 4
  br label %6, !llvm.loop !8

19:                                               ; preds = %6
  %20 = load i32, ptr %3, align 4
  ret i32 %20
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define void @putint(i32 noundef %0) #0 {
  %2 = alloca i32, align 4
  store i32 %0, ptr %2, align 4
  %3 = load i32, ptr %2, align 4
  %4 = call i32 (ptr, ...) @printf(ptr noundef @.str.1.16, i32 noundef %3)
  ret void
}

declare i32 @printf(ptr noundef, ...) #1

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define void @putch(i32 noundef %0) #0 {
  %2 = alloca i32, align 4
  store i32 %0, ptr %2, align 4
  %3 = load i32, ptr %2, align 4
  %4 = call i32 (ptr, ...) @printf(ptr noundef @.str.13, i32 noundef %3)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define void @putarray(i32 noundef %0, ptr noundef %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca ptr, align 8
  %5 = alloca i32, align 4
  store i32 %0, ptr %3, align 4
  store ptr %1, ptr %4, align 8
  %6 = load i32, ptr %3, align 4
  %7 = call i32 (ptr, ...) @printf(ptr noundef @.str.2.21, i32 noundef %6)
  store i32 0, ptr %5, align 4
  br label %8

8:                                                ; preds = %19, %2
  %9 = load i32, ptr %5, align 4
  %10 = load i32, ptr %3, align 4
  %11 = icmp slt i32 %9, %10
  br i1 %11, label %12, label %22

12:                                               ; preds = %8
  %13 = load ptr, ptr %4, align 8
  %14 = load i32, ptr %5, align 4
  %15 = sext i32 %14 to i64
  %16 = getelementptr inbounds i32, ptr %13, i64 %15
  %17 = load i32, ptr %16, align 4
  %18 = call i32 (ptr, ...) @printf(ptr noundef @.str.3.22, i32 noundef %17)
  br label %19

19:                                               ; preds = %12
  %20 = load i32, ptr %5, align 4
  %21 = add nsw i32 %20, 1
  store i32 %21, ptr %5, align 4
  br label %8, !llvm.loop !9

22:                                               ; preds = %8
  %23 = call i32 (ptr, ...) @printf(ptr noundef @.str.4.23)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define void @putstr(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = call i32 (ptr, ...) @printf(ptr noundef @.str.5.26, ptr noundef %3)
  ret void
}

attributes #0 = { noinline nounwind optnone ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a,+zcm,+zcz" }
attributes #1 = { "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a,+zcm,+zcz" }

!llvm.ident = !{!0}
!llvm.module.flags = !{!1, !2, !3, !4, !5}

!0 = !{!"Homebrew clang version 19.1.5"}
!1 = !{i32 2, !"SDK Version", [2 x i32] [i32 13, i32 3]}
!2 = !{i32 1, !"wchar_size", i32 4}
!3 = !{i32 8, !"PIC Level", i32 2}
!4 = !{i32 7, !"uwtable", i32 1}
!5 = !{i32 7, !"frame-pointer", i32 1}
!6 = distinct !{!6, !7}
!7 = !{!"llvm.loop.mustprogress"}
!8 = distinct !{!8, !7}
!9 = distinct !{!9, !7}
