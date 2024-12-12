; ModuleID = 'llvm-link'
source_filename = "llvm-link"
target datalayout = "e-m:o-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx13.3.0"

@constA = dso_local global i32 1
@constB = dso_local global i32 2
@constC = dso_local global i32 3
@constD = dso_local global [5 x i32] [i32 1, i32 2, i32 3, i32 4, i32 5]
@a1 = dso_local global i8 97
@a2 = dso_local global i8 98
@a3 = dso_local global i8 99
@a4 = dso_local global [6 x i8] c"abcde\00"
@.str = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.1 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.2 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.3 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.4 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.5 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.6 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.7 = private unnamed_addr constant [10 x i8] c"22372468\0A\00", align 1
@.str.8 = private unnamed_addr constant [2 x i8] c" \00", align 1
@.str.9 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.10 = private unnamed_addr constant [2 x i8] c" \00", align 1
@.str.11 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.12 = private unnamed_addr constant [3 x i8] c"%c\00", align 1
@.str.1.15 = private unnamed_addr constant [3 x i8] c"%d\00", align 1
@.str.2.20 = private unnamed_addr constant [4 x i8] c"%d:\00", align 1
@.str.3.21 = private unnamed_addr constant [4 x i8] c" %d\00", align 1
@.str.4.22 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.5.25 = private unnamed_addr constant [3 x i8] c"%s\00", align 1

define dso_local void @funcA() {
  ret void
}

define dso_local i32 @funcB() {
  %1 = alloca i32, align 4
  store i32 0, ptr %1, align 4
  %2 = alloca i32, align 4
  store i32 0, ptr %2, align 4
  store i32 0, ptr %2, align 4
  br label %3

3:                                                ; preds = %10, %0
  %4 = load i32, ptr %2, align 4
  %5 = icmp slt i32 %4, 5
  br i1 %5, label %6, label %13

6:                                                ; preds = %3
  %7 = load i32, ptr %1, align 4
  %8 = load i32, ptr %2, align 4
  %9 = add nsw i32 %7, %8
  store i32 %9, ptr %1, align 4
  br label %10

10:                                               ; preds = %6
  %11 = load i32, ptr %2, align 4
  %12 = add nsw i32 %11, 1
  store i32 %12, ptr %2, align 4
  br label %3

13:                                               ; preds = %3
  %14 = load i32, ptr %1, align 4
  call void @putint(i32 %14)
  call void @putstr(ptr @.str)
  store i32 0, ptr %2, align 4
  br label %15

15:                                               ; preds = %22, %13
  %16 = load i32, ptr %2, align 4
  %17 = icmp slt i32 %16, 5
  br i1 %17, label %18, label %25

18:                                               ; preds = %15
  %19 = load i32, ptr %1, align 4
  %20 = load i32, ptr %2, align 4
  %21 = add nsw i32 %19, %20
  store i32 %21, ptr %1, align 4
  br label %22

22:                                               ; preds = %18
  %23 = load i32, ptr %2, align 4
  %24 = add nsw i32 %23, 1
  store i32 %24, ptr %2, align 4
  br label %15

25:                                               ; preds = %15
  store i32 0, ptr %2, align 4
  br label %26

26:                                               ; preds = %35, %25
  %27 = load i32, ptr %1, align 4
  %28 = load i32, ptr %2, align 4
  %29 = add nsw i32 %27, %28
  store i32 %29, ptr %1, align 4
  %30 = load i32, ptr %1, align 4
  %31 = icmp sgt i32 %30, 25
  br i1 %31, label %32, label %33

32:                                               ; preds = %26
  br label %38

33:                                               ; preds = %26
  br label %35

34:                                               ; No predecessors!
  br label %35

35:                                               ; preds = %34, %33
  %36 = load i32, ptr %2, align 4
  %37 = add nsw i32 %36, 1
  store i32 %37, ptr %2, align 4
  br label %26

38:                                               ; preds = %32
  store i32 1, ptr %2, align 4
  br label %39

39:                                               ; preds = %49, %38
  %40 = load i32, ptr %2, align 4
  %41 = icmp slt i32 %40, 5
  br i1 %41, label %42, label %50

42:                                               ; preds = %39
  %43 = load i32, ptr %1, align 4
  %44 = load i32, ptr %2, align 4
  %45 = add nsw i32 %43, %44
  store i32 %45, ptr %1, align 4
  %46 = load i32, ptr %1, align 4
  %47 = icmp sgt i32 %46, 30
  br i1 %47, label %48, label %49

48:                                               ; preds = %42
  br label %50

49:                                               ; preds = %42
  br label %39

50:                                               ; preds = %48, %39
  %51 = load i32, ptr %1, align 4
  call void @putint(i32 %51)
  call void @putstr(ptr @.str.1)
  store i32 0, ptr %2, align 4
  br label %52

52:                                               ; preds = %60, %50
  %53 = load i32, ptr %1, align 4
  %54 = load i32, ptr %2, align 4
  %55 = add nsw i32 %53, %54
  store i32 %55, ptr %1, align 4
  %56 = load i32, ptr %1, align 4
  %57 = icmp sgt i32 %56, 35
  br i1 %57, label %58, label %59

58:                                               ; preds = %52
  br label %63

59:                                               ; preds = %52
  br label %60

60:                                               ; preds = %59
  %61 = load i32, ptr %2, align 4
  %62 = add nsw i32 %61, 1
  store i32 %62, ptr %2, align 4
  br label %52

63:                                               ; preds = %58
  br label %64

64:                                               ; preds = %73, %63
  %65 = load i32, ptr %2, align 4
  %66 = icmp slt i32 %65, 5
  br i1 %66, label %67, label %74

67:                                               ; preds = %64
  %68 = load i32, ptr %1, align 4
  %69 = add nsw i32 %68, 1
  store i32 %69, ptr %1, align 4
  %70 = load i32, ptr %1, align 4
  %71 = icmp sgt i32 %70, 40
  br i1 %71, label %72, label %73

72:                                               ; preds = %67
  br label %74

73:                                               ; preds = %67
  br label %64

74:                                               ; preds = %72, %64
  store i32 1, ptr %2, align 4
  br label %75

75:                                               ; preds = %82, %74
  %76 = load i32, ptr %1, align 4
  %77 = load i32, ptr %2, align 4
  %78 = add nsw i32 %76, %77
  store i32 %78, ptr %1, align 4
  %79 = load i32, ptr %1, align 4
  %80 = icmp sgt i32 %79, 45
  br i1 %80, label %81, label %82

81:                                               ; preds = %75
  br label %83

82:                                               ; preds = %75
  br label %75

83:                                               ; preds = %81
  %84 = load i32, ptr %1, align 4
  call void @putint(i32 %84)
  call void @putstr(ptr @.str.2)
  br label %85

85:                                               ; preds = %91, %83
  %86 = load i32, ptr %1, align 4
  %87 = add nsw i32 %86, 2
  store i32 %87, ptr %1, align 4
  %88 = load i32, ptr %1, align 4
  %89 = icmp sgt i32 %88, 50
  br i1 %89, label %90, label %91

90:                                               ; preds = %85
  br label %92

91:                                               ; preds = %85
  br label %85

92:                                               ; preds = %90
  %93 = load i32, ptr %1, align 4
  call void @putint(i32 %93)
  call void @putstr(ptr @.str.3)
  %94 = load i32, ptr %1, align 4
  ret i32 %94
}

define dso_local i8 @funcC() {
  %1 = alloca i8, align 1
  store i8 92, ptr %1, align 1
  %2 = load i32, ptr @constB, align 4
  %3 = load i32, ptr @constA, align 4
  %4 = add nsw i32 %3, 1
  %5 = icmp sge i32 %2, %4
  br i1 %5, label %6, label %14

6:                                                ; preds = %0
  %7 = load i32, ptr @constC, align 4
  %8 = load i32, ptr @constB, align 4
  %9 = add nsw i32 %8, 1
  %10 = icmp sge i32 %7, %9
  br i1 %10, label %11, label %13

11:                                               ; preds = %6
  %12 = load i8, ptr @a1, align 1
  store i8 %12, ptr %1, align 1
  br label %13

13:                                               ; preds = %11, %6
  br label %16

14:                                               ; preds = %0
  %15 = load i8, ptr @a2, align 1
  store i8 %15, ptr %1, align 1
  br label %16

16:                                               ; preds = %14, %13
  %17 = load i32, ptr @constC, align 4
  %18 = icmp ne i32 %17, 3
  br i1 %18, label %19, label %25

19:                                               ; preds = %16
  %20 = load i32, ptr @constB, align 4
  %21 = icmp slt i32 %20, 3
  br i1 %21, label %22, label %24

22:                                               ; preds = %19
  %23 = load i8, ptr @a3, align 1
  store i8 %23, ptr %1, align 1
  br label %24

24:                                               ; preds = %22, %19
  br label %25

25:                                               ; preds = %24, %16
  %26 = load i8, ptr %1, align 1
  ret i8 %26
}

define dso_local void @funcD(ptr %0) {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = getelementptr inbounds i8, ptr %3, i32 0
  %5 = load i8, ptr %4, align 1
  %6 = zext i8 %5 to i32
  call void @putch(i32 %6)
  call void @putstr(ptr @.str.4)
  ret void
}

define dso_local void @funcE(i32 %0, i32 %1) {
  %3 = alloca i32, align 4
  store i32 %0, ptr %3, align 4
  %4 = alloca i32, align 4
  store i32 %1, ptr %4, align 4
  %5 = load i32, ptr %3, align 4
  %6 = load i32, ptr %4, align 4
  %7 = icmp eq i32 %5, %6
  br i1 %7, label %8, label %12

8:                                                ; preds = %2
  %9 = load i32, ptr %3, align 4
  %10 = load i32, ptr %4, align 4
  %11 = add nsw i32 %9, %10
  call void @putint(i32 %11)
  call void @putstr(ptr @.str.5)
  br label %12

12:                                               ; preds = %8, %2
  %13 = load i32, ptr %3, align 4
  %14 = load i32, ptr %4, align 4
  %15 = icmp ne i32 %13, %14
  br i1 %15, label %16, label %20

16:                                               ; preds = %12
  %17 = load i32, ptr %3, align 4
  %18 = load i32, ptr %4, align 4
  %19 = mul nsw i32 %17, %18
  call void @putint(i32 %19)
  call void @putstr(ptr @.str.6)
  br label %20

20:                                               ; preds = %16, %12
  ret void
}

define dso_local i32 @main() {
  call void @putstr(ptr @.str.7)
  %1 = alloca i32, align 4
  store i32 0, ptr %1, align 4
  %2 = alloca i8, align 1
  store i8 92, ptr %2, align 1
  %3 = call i32 @getint()
  store i32 %3, ptr %1, align 4
  %4 = call i32 @getchar()
  %5 = trunc i32 %4 to i8
  store i8 %5, ptr %2, align 1
  %6 = load i32, ptr %1, align 4
  %7 = load i8, ptr %2, align 1
  call void @putint(i32 %6)
  call void @putstr(ptr @.str.8)
  %8 = zext i8 %7 to i32
  call void @putch(i32 %8)
  call void @putstr(ptr @.str.9)
  call void @funcA()
  %9 = alloca i32, align 4
  %10 = call i32 @funcB()
  %11 = load i32, ptr %1, align 4
  %12 = mul nsw i32 %11, 10
  %13 = sdiv i32 %10, 2
  %14 = add nsw i32 %12, %13
  %15 = sub nsw i32 %14, 1
  %16 = srem i32 %15, 7
  store i32 %16, ptr %9, align 4
  %17 = alloca i8, align 1
  %18 = call i8 @funcC()
  store i8 %18, ptr %17, align 1
  %19 = load i32, ptr %9, align 4
  %20 = load i8, ptr %17, align 1
  call void @putint(i32 %19)
  call void @putstr(ptr @.str.10)
  %21 = zext i8 %20 to i32
  call void @putch(i32 %21)
  call void @putstr(ptr @.str.11)
  %22 = getelementptr inbounds i8, ptr @a4, i32 0
  store i8 122, ptr %22, align 1
  call void @funcD(ptr @a4)
  %23 = load i32, ptr @constA, align 4
  %24 = load i32, ptr @constB, align 4
  call void @funcE(i32 %23, i32 %24)
  %25 = load i32, ptr @constA, align 4
  %26 = load i32, ptr @constB, align 4
  call void @funcE(i32 %25, i32 %26)
  ret i32 0
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define i32 @getchar() #0 {
  %1 = alloca i8, align 1
  %2 = call i32 (ptr, ...) @scanf(ptr noundef @.str.12, ptr noundef %1)
  %3 = load i8, ptr %1, align 1
  %4 = sext i8 %3 to i32
  ret i32 %4
}

declare i32 @scanf(ptr noundef, ...) #1

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define i32 @getint() #0 {
  %1 = alloca i32, align 4
  %2 = call i32 (ptr, ...) @scanf(ptr noundef @.str.1.15, ptr noundef %1)
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
  %5 = call i32 (ptr, ...) @scanf(ptr noundef @.str.1.15, ptr noundef %3)
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
  %15 = call i32 (ptr, ...) @scanf(ptr noundef @.str.1.15, ptr noundef %14)
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
  %4 = call i32 (ptr, ...) @printf(ptr noundef @.str.1.15, i32 noundef %3)
  ret void
}

declare i32 @printf(ptr noundef, ...) #1

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define void @putch(i32 noundef %0) #0 {
  %2 = alloca i32, align 4
  store i32 %0, ptr %2, align 4
  %3 = load i32, ptr %2, align 4
  %4 = call i32 (ptr, ...) @printf(ptr noundef @.str.12, i32 noundef %3)
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
  %7 = call i32 (ptr, ...) @printf(ptr noundef @.str.2.20, i32 noundef %6)
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
  %18 = call i32 (ptr, ...) @printf(ptr noundef @.str.3.21, i32 noundef %17)
  br label %19

19:                                               ; preds = %12
  %20 = load i32, ptr %5, align 4
  %21 = add nsw i32 %20, 1
  store i32 %21, ptr %5, align 4
  br label %8, !llvm.loop !9

22:                                               ; preds = %8
  %23 = call i32 (ptr, ...) @printf(ptr noundef @.str.4.22)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define void @putstr(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = call i32 (ptr, ...) @printf(ptr noundef @.str.5.25, ptr noundef %3)
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
