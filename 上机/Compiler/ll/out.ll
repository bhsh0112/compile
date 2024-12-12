; ModuleID = 'llvm-link'
source_filename = "llvm-link"
target datalayout = "e-m:o-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx13.3.0"

@MAXINT = dso_local global i32 2147483647
@MININT = dso_local global i32 -2147483647
@MAXCHAR = dso_local global i8 126
@MINCHAR = dso_local global i8 32
@ZERO = dso_local global i32 0
@ONE = dso_local global i32 1
@TWO = dso_local global i32 2
@THREE = dso_local global i32 3
@FOUR = dso_local global i32 4
@FIVE = dso_local global i32 5
@SIX = dso_local global i32 6
@SEVEN = dso_local global i32 7
@EIGHT = dso_local global i32 8
@NINE = dso_local global i32 9
@TEN = dso_local global i32 10
@ZERO_TO_TEN = dso_local global [11 x i32] [i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10]
@NO_USE1 = dso_local global [11 x i32] zeroinitializer
@NO_USE2 = dso_local global [11 x i32] [i32 0, i32 1, i32 2, i32 3, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0]
@A = dso_local global i8 65
@B = dso_local global i8 66
@C = dso_local global i8 67
@D = dso_local global i8 68
@E = dso_local global i8 69
@F = dso_local global i8 70
@G = dso_local global i8 71
@H = dso_local global i8 72
@I = dso_local global i8 73
@J = dso_local global i8 74
@ABCDEFGHIJ = dso_local global [11 x i8] c"ABCDEFGHIJ\00"
@NO_USE3 = dso_local global [11 x i8] zeroinitializer
@NO_USE4 = dso_local global [11 x i8] c"NO_USE4\00\00\00\00"
@fibonacci = dso_local global [15 x i32] zeroinitializer
@.str = private unnamed_addr constant [17 x i8] c"Fibonacci Array \00", align 1
@.str.1 = private unnamed_addr constant [4 x i8] c" : \00", align 1
@.str.2 = private unnamed_addr constant [3 x i8] c"  \00", align 1
@.str.3 = private unnamed_addr constant [4 x i8] c" : \00", align 1
@.str.4 = private unnamed_addr constant [3 x i8] c"  \00", align 1
@.str.5 = private unnamed_addr constant [4 x i8] c" : \00", align 1
@.str.6 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.7 = private unnamed_addr constant [10 x i8] c"22371298\0A\00", align 1
@.str.8 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.9 = private unnamed_addr constant [3 x i8] c"a\0A\00", align 1
@.str.10 = private unnamed_addr constant [3 x i8] c"a\0A\00", align 1
@.str.11 = private unnamed_addr constant [3 x i8] c"a\0A\00", align 1
@.str.12 = private unnamed_addr constant [3 x i8] c"a\0A\00", align 1
@.str.13 = private unnamed_addr constant [3 x i8] c"a\0A\00", align 1
@.str.14 = private unnamed_addr constant [3 x i8] c"a\0A\00", align 1
@.str.15 = private unnamed_addr constant [3 x i8] c"a\0A\00", align 1
@.str.16 = private unnamed_addr constant [3 x i8] c"%c\00", align 1
@.str.1.19 = private unnamed_addr constant [3 x i8] c"%d\00", align 1
@.str.2.22 = private unnamed_addr constant [4 x i8] c"%d:\00", align 1
@.str.3.23 = private unnamed_addr constant [4 x i8] c" %d\00", align 1
@.str.4.24 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.5.27 = private unnamed_addr constant [3 x i8] c"%s\00", align 1

define dso_local void @cal_fibonacci() {
  %1 = getelementptr inbounds i32, ptr @fibonacci, i32 1
  store i32 1, ptr @fibonacci, align 4
  %2 = alloca i32, align 4
  store i32 2, ptr %2, align 4
  br label %3

3:                                                ; preds = %18, %0
  %4 = load i32, ptr %2, align 4
  %5 = icmp slt i32 %4, 15
  br i1 %5, label %6, label %21

6:                                                ; preds = %3
  %7 = load i32, ptr %2, align 4
  %8 = getelementptr inbounds i32, ptr @fibonacci, i32 %7
  %9 = load i32, ptr %2, align 4
  %10 = sub nsw i32 %9, 1
  %11 = getelementptr inbounds [15 x i32], ptr @fibonacci, i32 0, i32 %10
  %12 = load i32, ptr %11, align 4
  %13 = load i32, ptr %2, align 4
  %14 = sub nsw i32 %13, 2
  %15 = getelementptr inbounds [15 x i32], ptr @fibonacci, i32 0, i32 %14
  %16 = load i32, ptr %15, align 4
  %17 = add nsw i32 %12, %16
  store i32 %17, ptr @fibonacci, align 4
  br label %18

18:                                               ; preds = %6
  %19 = load i32, ptr %2, align 4
  %20 = add nsw i32 %19, 1
  store i32 %20, ptr %2, align 4
  br label %3

21:                                               ; preds = %3
  ret void
}

define dso_local void @print_fibonacci_n(i32 %0, i32 %1, i32 %2) {
  %4 = alloca i32, align 4
  store i32 %0, ptr %4, align 4
  %5 = alloca i32, align 4
  store i32 %1, ptr %5, align 4
  %6 = alloca i32, align 4
  store i32 %2, ptr %6, align 4
  %7 = load i32, ptr %4, align 4
  %8 = load i32, ptr %4, align 4
  %9 = getelementptr inbounds [15 x i32], ptr @fibonacci, i32 0, i32 %8
  %10 = load i32, ptr %9, align 4
  %11 = load i32, ptr %5, align 4
  %12 = load i32, ptr %5, align 4
  %13 = getelementptr inbounds [15 x i32], ptr @fibonacci, i32 0, i32 %12
  %14 = load i32, ptr %13, align 4
  %15 = load i32, ptr %6, align 4
  %16 = load i32, ptr %6, align 4
  %17 = getelementptr inbounds [15 x i32], ptr @fibonacci, i32 0, i32 %16
  %18 = load i32, ptr %17, align 4
  call void @putstr(ptr @.str)
  call void @putint(i32 %7)
  call void @putstr(ptr @.str.1)
  call void @putint(i32 %10)
  call void @putstr(ptr @.str.2)
  call void @putint(i32 %11)
  call void @putstr(ptr @.str.3)
  call void @putint(i32 %14)
  call void @putstr(ptr @.str.4)
  call void @putint(i32 %15)
  call void @putstr(ptr @.str.5)
  call void @putint(i32 %18)
  call void @putstr(ptr @.str.6)
  ret void
}

define dso_local i32 @main() {
  call void @putstr(ptr @.str.7)
  %1 = alloca i32, align 4
  %2 = call i32 @getint()
  store i32 %2, ptr %1, align 4
  %3 = alloca i32, align 4
  %4 = call i32 @getint()
  store i32 %4, ptr %3, align 4
  %5 = alloca i32, align 4
  %6 = call i32 @getint()
  store i32 %6, ptr %5, align 4
  call void @cal_fibonacci()
  %7 = load i32, ptr %1, align 4
  %8 = icmp sgt i32 %7, 14
  br i1 %8, label %15, label %9

9:                                                ; preds = %0
  %10 = load i32, ptr %3, align 4
  %11 = icmp sgt i32 %10, 14
  br i1 %11, label %15, label %12

12:                                               ; preds = %9
  %13 = load i32, ptr %5, align 4
  %14 = icmp sgt i32 %13, 14
  br i1 %14, label %15, label %16

15:                                               ; preds = %12, %9, %0
  br label %20

16:                                               ; preds = %12
  %17 = load i32, ptr %1, align 4
  %18 = load i32, ptr %3, align 4
  %19 = load i32, ptr %5, align 4
  call void @print_fibonacci_n(i32 %17, i32 %18, i32 %19)
  br label %20

20:                                               ; preds = %16, %15
  %21 = alloca i32, align 4
  %22 = load i32, ptr @MAXINT, align 4
  store i32 %22, ptr %21, align 4
  %23 = alloca i32, align 4
  %24 = load i32, ptr @TEN, align 4
  %25 = getelementptr inbounds [11 x i32], ptr @ZERO_TO_TEN, i32 0, i32 %24
  %26 = load i32, ptr %25, align 4
  store i32 %26, ptr %23, align 4
  %27 = alloca i32, align 4
  store i32 1, ptr %27, align 4
  br label %28

28:                                               ; preds = %33, %20
  %29 = load i32, ptr %27, align 4
  %30 = icmp slt i32 %29, 2
  br i1 %30, label %31, label %36

31:                                               ; preds = %28
  %32 = load i32, ptr %27, align 4
  call void @putint(i32 %32)
  call void @putstr(ptr @.str.8)
  br label %33

33:                                               ; preds = %31
  %34 = load i32, ptr %27, align 4
  %35 = add nsw i32 %34, 1
  store i32 %35, ptr %27, align 4
  br label %28

36:                                               ; preds = %28
  store i32 2, ptr %27, align 4
  br label %37

37:                                               ; preds = %54, %36
  %38 = load i32, ptr %27, align 4
  %39 = icmp eq i32 %38, 5
  br i1 %39, label %52, label %40

40:                                               ; preds = %37
  %41 = load i32, ptr %27, align 4
  %42 = icmp sle i32 %41, 6
  br i1 %42, label %52, label %43

43:                                               ; preds = %40
  %44 = load i32, ptr %27, align 4
  %45 = icmp sge i32 %44, 90
  br i1 %45, label %52, label %46

46:                                               ; preds = %43
  %47 = load i32, ptr %27, align 4
  %48 = icmp eq i32 %47, 100
  br i1 %48, label %52, label %49

49:                                               ; preds = %46
  %50 = load i32, ptr %27, align 4
  %51 = icmp ne i32 %50, 80
  br i1 %51, label %52, label %53

52:                                               ; preds = %49, %46, %43, %40, %37
  br label %57

53:                                               ; preds = %49
  br label %54

54:                                               ; preds = %53
  %55 = load i32, ptr %27, align 4
  %56 = add nsw i32 %55, 1
  store i32 %56, ptr %27, align 4
  br label %37

57:                                               ; preds = %52
  br label %58

58:                                               ; preds = %62, %57
  %59 = load i32, ptr %27, align 4
  %60 = icmp ne i32 %59, 90
  br i1 %60, label %61, label %62

61:                                               ; preds = %58
  br label %63

62:                                               ; preds = %58
  br label %58

63:                                               ; preds = %61
  store i32 100, ptr %27, align 4
  br label %64

64:                                               ; preds = %69, %63
  %65 = load i32, ptr %27, align 4
  %66 = icmp sgt i32 %65, 10
  br i1 %66, label %67, label %68

67:                                               ; preds = %64
  br label %72

68:                                               ; preds = %64
  br label %69

69:                                               ; preds = %68
  %70 = load i32, ptr %27, align 4
  %71 = add nsw i32 %70, 1
  store i32 %71, ptr %27, align 4
  br label %64

72:                                               ; preds = %67
  br label %73

73:                                               ; preds = %87, %86, %72
  %74 = load i32, ptr %27, align 4
  %75 = icmp sgt i32 %74, 50
  br i1 %75, label %76, label %88

76:                                               ; preds = %73
  %77 = load i32, ptr %27, align 4
  %78 = icmp sgt i32 %77, 80
  br i1 %78, label %79, label %82

79:                                               ; preds = %76
  %80 = load i32, ptr %27, align 4
  %81 = icmp slt i32 %80, 120
  br i1 %81, label %85, label %82

82:                                               ; preds = %79, %76
  %83 = load i32, ptr %27, align 4
  %84 = icmp eq i32 %83, 100
  br i1 %84, label %85, label %86

85:                                               ; preds = %82, %79
  br label %88

86:                                               ; preds = %82
  br label %73

87:                                               ; No predecessors!
  br label %73

88:                                               ; preds = %85, %73
  store i32 100, ptr %27, align 4
  br label %89

89:                                               ; preds = %94, %93, %88
  %90 = load i32, ptr %27, align 4
  %91 = icmp eq i32 %90, 100
  br i1 %91, label %92, label %93

92:                                               ; preds = %89
  br label %95

93:                                               ; preds = %89
  br label %89

94:                                               ; No predecessors!
  br label %89

95:                                               ; preds = %92
  br label %96

96:                                               ; preds = %99, %95
  %97 = icmp ne i32 1, 0
  br i1 %97, label %98, label %99

98:                                               ; preds = %96
  br label %100

99:                                               ; preds = %96
  br label %96

100:                                              ; preds = %98
  %101 = alloca i8, align 1
  %102 = call i32 @getchar()
  %103 = trunc i32 %102 to i8
  store i8 %103, ptr %101, align 1
  call void @putstr(ptr @.str.9)
  call void @putstr(ptr @.str.10)
  call void @putstr(ptr @.str.11)
  call void @putstr(ptr @.str.12)
  call void @putstr(ptr @.str.13)
  call void @putstr(ptr @.str.14)
  call void @putstr(ptr @.str.15)
  ret i32 0
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define i32 @getchar() #0 {
  %1 = alloca i8, align 1
  %2 = call i32 (ptr, ...) @scanf(ptr noundef @.str.16, ptr noundef %1)
  %3 = load i8, ptr %1, align 1
  %4 = sext i8 %3 to i32
  ret i32 %4
}

declare i32 @scanf(ptr noundef, ...) #1

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define i32 @getint() #0 {
  %1 = alloca i32, align 4
  %2 = call i32 (ptr, ...) @scanf(ptr noundef @.str.1.19, ptr noundef %1)
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
  %5 = call i32 (ptr, ...) @scanf(ptr noundef @.str.1.19, ptr noundef %3)
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
  %15 = call i32 (ptr, ...) @scanf(ptr noundef @.str.1.19, ptr noundef %14)
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
  %4 = call i32 (ptr, ...) @printf(ptr noundef @.str.1.19, i32 noundef %3)
  ret void
}

declare i32 @printf(ptr noundef, ...) #1

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define void @putch(i32 noundef %0) #0 {
  %2 = alloca i32, align 4
  store i32 %0, ptr %2, align 4
  %3 = load i32, ptr %2, align 4
  %4 = call i32 (ptr, ...) @printf(ptr noundef @.str.16, i32 noundef %3)
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
  %7 = call i32 (ptr, ...) @printf(ptr noundef @.str.2.22, i32 noundef %6)
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
  %18 = call i32 (ptr, ...) @printf(ptr noundef @.str.3.23, i32 noundef %17)
  br label %19

19:                                               ; preds = %12
  %20 = load i32, ptr %5, align 4
  %21 = add nsw i32 %20, 1
  store i32 %21, ptr %5, align 4
  br label %8, !llvm.loop !9

22:                                               ; preds = %8
  %23 = call i32 (ptr, ...) @printf(ptr noundef @.str.4.24)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define void @putstr(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = call i32 (ptr, ...) @printf(ptr noundef @.str.5.27, ptr noundef %3)
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
