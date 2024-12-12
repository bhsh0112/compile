; ModuleID = 'llvm-link'
source_filename = "llvm-link"
target datalayout = "e-m:o-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx13.3.0"

@MAX_SIZE = dso_local global i32 10
@global_var = dso_local global i32 0
@str = dso_local global [10 x i8] c"3\\\00\00\00\00\00\00\00\00"
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
@.str.11 = private unnamed_addr constant [3 x i8] c"%c\00", align 1
@.str.1.14 = private unnamed_addr constant [3 x i8] c"%d\00", align 1
@.str.2.19 = private unnamed_addr constant [4 x i8] c"%d:\00", align 1
@.str.3.20 = private unnamed_addr constant [4 x i8] c" %d\00", align 1
@.str.4.21 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.5.24 = private unnamed_addr constant [3 x i8] c"%s\00", align 1

define dso_local i32 @add(i32 %0, i32 %1) {
  %3 = alloca i32, align 4
  store i32 %0, ptr %3, align 4
  %4 = alloca i32, align 4
  store i32 %1, ptr %4, align 4
  %5 = load i32, ptr %3, align 4
  %6 = load i32, ptr %4, align 4
  %7 = add nsw i32 %5, %6
  ret i32 %7
}

define dso_local i32 @calculate(i32 %0, ptr %1) {
  %3 = alloca i32, align 4
  store i32 %0, ptr %3, align 4
  %4 = alloca ptr, align 8
  store ptr %1, ptr %4, align 8
  %5 = alloca i32, align 4
  %6 = load i32, ptr %3, align 4
  %7 = load ptr, ptr %4, align 8
  %8 = getelementptr inbounds i32, ptr %7, i32 0
  %9 = load i32, ptr %8, align 4
  %10 = call i32 @add(i32 %6, i32 %9)
  %11 = load ptr, ptr %4, align 8
  %12 = getelementptr inbounds i32, ptr %11, i32 1
  %13 = load i32, ptr %12, align 4
  %14 = load ptr, ptr %4, align 8
  %15 = getelementptr inbounds i32, ptr %14, i32 2
  %16 = load i32, ptr %15, align 4
  %17 = load i32, ptr %3, align 4
  %18 = sub nsw i32 %17, %13
  %19 = mul nsw i32 %10, %18
  %20 = sdiv i32 %19, %16
  %21 = load i32, ptr %3, align 4
  %22 = srem i32 %20, %21
  %23 = sub nsw i32 %22, -3
  %24 = add nsw i32 %23, 6
  store i32 %24, ptr %5, align 4
  %25 = load i32, ptr %5, align 4
  %26 = icmp sle i32 %25, 5
  br i1 %26, label %27, label %28

27:                                               ; preds = %2
  ret i32 1

28:                                               ; preds = %2
  ret i32 0

29:                                               ; No predecessors!
  ret i32 -1
}

define dso_local void @printName() {
  %1 = load i32, ptr @global_var, align 4
  %2 = add nsw i32 %1, 1
  store i32 %2, ptr @global_var, align 4
  %3 = load i32, ptr @global_var, align 4
  %4 = icmp ne i32 %3, 0
  br i1 %4, label %5, label %6

5:                                                ; preds = %0
  call void @putstr(ptr @.str)
  br label %6

6:                                                ; preds = %5, %0
  ret void
}

define dso_local void @print(i8 %0) {
  %2 = alloca i8, align 1
  store i8 %0, ptr %2, align 1
  %3 = load i8, ptr %2, align 1
  %4 = zext i8 %3 to i32
  call void @putch(i32 %4)
  call void @putstr(ptr @.str.1)
  ret void
}

define dso_local i8 @get_first(ptr %0) {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = getelementptr inbounds i8, ptr %3, i32 0
  %5 = load i8, ptr %4, align 1
  ret i8 %5
}

define dso_local i32 @main() {
  call void @printName()
  %1 = alloca i32, align 4
  store i32 0, ptr %1, align 4
  %2 = alloca i32, align 4
  store i32 8, ptr %2, align 4
  %3 = alloca i8, align 1
  %4 = call i32 @getint()
  store i32 %4, ptr %1, align 4
  %5 = call i32 @getchar()
  %6 = trunc i32 %5 to i8
  store i8 %6, ptr %3, align 1
  %7 = load i32, ptr %1, align 4
  call void @putstr(ptr @.str.2)
  call void @putint(i32 %7)
  call void @putstr(ptr @.str.3)
  %8 = load i8, ptr %3, align 1
  call void @putstr(ptr @.str.4)
  %9 = zext i8 %8 to i32
  call void @putch(i32 %9)
  call void @putstr(ptr @.str.5)
  %10 = alloca i32, align 4
  store i32 5, ptr %10, align 4
  %11 = alloca [10 x i32], align 4
  %12 = alloca [12 x i8], align 1
  %13 = getelementptr inbounds [12 x i8], ptr %12, i32 0, i32 1
  store i8 113, ptr %13, align 1
  %14 = getelementptr inbounds [12 x i8], ptr %13, i32 0, i32 2
  store i8 119, ptr %14, align 1
  %15 = getelementptr inbounds [12 x i8], ptr %14, i32 0, i32 3
  store i8 101, ptr %15, align 1
  %16 = getelementptr inbounds [12 x i8], ptr %15, i32 0, i32 4
  store i8 114, ptr %16, align 1
  %17 = getelementptr inbounds [12 x i8], ptr %16, i32 0, i32 5
  store i8 116, ptr %17, align 1
  %18 = getelementptr inbounds [12 x i8], ptr %17, i32 0, i32 6
  store i8 121, ptr %18, align 1
  %19 = getelementptr inbounds [12 x i8], ptr %18, i32 0, i32 7
  store i8 117, ptr %19, align 1
  %20 = getelementptr inbounds [12 x i8], ptr %19, i32 0, i32 8
  store i8 105, ptr %20, align 1
  %21 = getelementptr inbounds [12 x i8], ptr %20, i32 0, i32 9
  store i8 111, ptr %21, align 1
  %22 = getelementptr inbounds [12 x i8], ptr %21, i32 0, i32 10
  store i8 112, ptr %22, align 1
  %23 = getelementptr inbounds [12 x i8], ptr %22, i32 0, i32 11
  store i8 92, ptr %23, align 1
  %24 = getelementptr inbounds [12 x i8], ptr %23, i32 0, i32 12
  store i8 110, ptr %24, align 1
  %25 = alloca [10 x i8], align 1
  %26 = getelementptr inbounds [10 x i8], ptr %25, i32 0, i32 1
  store i8 115, ptr %26, align 1
  %27 = getelementptr inbounds [10 x i8], ptr %26, i32 0, i32 2
  store i8 116, ptr %27, align 1
  %28 = getelementptr inbounds [10 x i8], ptr %27, i32 0, i32 3
  store i8 114, ptr %28, align 1
  store i32 0, ptr %1, align 4
  br label %29

29:                                               ; preds = %73, %0
  %30 = load i32, ptr %1, align 4
  %31 = load i32, ptr @MAX_SIZE, align 4
  %32 = icmp slt i32 %30, %31
  br i1 %32, label %33, label %76

33:                                               ; preds = %29
  %34 = load i32, ptr %1, align 4
  %35 = getelementptr inbounds i32, ptr %11, i32 %34
  %36 = load i32, ptr %1, align 4
  store i32 %36, ptr %11, align 4
  %37 = load i32, ptr %1, align 4
  %38 = icmp eq i32 %37, 4
  br i1 %38, label %39, label %44

39:                                               ; preds = %33
  %40 = load i32, ptr %1, align 4
  %41 = load i8, ptr %3, align 1
  %42 = zext i8 %41 to i32
  %43 = icmp slt i32 %40, %42
  br i1 %43, label %47, label %44

44:                                               ; preds = %39, %33
  %45 = load i32, ptr %1, align 4
  %46 = icmp sge i32 %45, 9
  br i1 %46, label %47, label %64

47:                                               ; preds = %44, %39
  call void @putstr(ptr @.str.6)
  %48 = alloca i32, align 4
  store i32 1, ptr %48, align 4
  br label %49

49:                                               ; preds = %59, %47
  %50 = load i32, ptr %48, align 4
  %51 = icmp sgt i32 %50, 100
  br i1 %51, label %52, label %53

52:                                               ; preds = %49
  br label %63

53:                                               ; preds = %49
  %54 = load i32, ptr %48, align 4
  %55 = icmp ne i32 %54, 32
  br i1 %55, label %56, label %57

56:                                               ; preds = %53
  br label %59

57:                                               ; preds = %53
  br label %58

58:                                               ; preds = %57
  call void @putstr(ptr @.str.7)
  br label %59

59:                                               ; preds = %58, %56
  %60 = load i32, ptr %48, align 4
  %61 = load i32, ptr %48, align 4
  %62 = add nsw i32 %60, %61
  store i32 %62, ptr %48, align 4
  br label %49

63:                                               ; preds = %52
  br label %64

64:                                               ; preds = %63, %44
  %65 = load i32, ptr %1, align 4
  %66 = srem i32 %65, 2
  %67 = icmp eq i32 %66, 0
  br i1 %67, label %68, label %71

68:                                               ; preds = %64
  br label %69

69:                                               ; preds = %68
  br label %70

70:                                               ; preds = %69
  br label %72

71:                                               ; preds = %64
  br label %72

72:                                               ; preds = %71, %70
  br label %73

73:                                               ; preds = %72
  %74 = load i32, ptr %1, align 4
  %75 = add nsw i32 %74, 1
  store i32 %75, ptr %1, align 4
  br label %29

76:                                               ; preds = %29
  %77 = alloca [20 x i32], align 4
  %78 = getelementptr inbounds [20 x i32], ptr %77, i32 0, i32 0
  store i32 3, ptr %78, align 4
  %79 = getelementptr inbounds i32, ptr %78, i32 1
  store i32 2, ptr %79, align 4
  %80 = getelementptr inbounds i32, ptr %79, i32 1
  store i32 1, ptr %80, align 4
  %81 = alloca i32, align 4
  store i32 0, ptr %81, align 4
  %82 = alloca i32, align 4
  store i32 0, ptr %82, align 4
  br label %83

83:                                               ; preds = %97, %76
  %84 = load i32, ptr %82, align 4
  %85 = load i32, ptr @MAX_SIZE, align 4
  %86 = icmp slt i32 %84, %85
  br i1 %86, label %87, label %100

87:                                               ; preds = %83
  %88 = load i32, ptr %82, align 4
  %89 = icmp slt i32 %88, 3
  br i1 %89, label %90, label %96

90:                                               ; preds = %87
  %91 = load i32, ptr %82, align 4
  %92 = getelementptr inbounds [20 x i32], ptr %77, i32 0, i32 %91
  %93 = load i32, ptr %92, align 4
  %94 = load i32, ptr %81, align 4
  %95 = add nsw i32 %94, %93
  store i32 %95, ptr %81, align 4
  br label %96

96:                                               ; preds = %90, %87
  br label %97

97:                                               ; preds = %96
  %98 = load i32, ptr %82, align 4
  %99 = add nsw i32 %98, 1
  store i32 %99, ptr %82, align 4
  br label %83

100:                                              ; preds = %83
  %101 = load i32, ptr %81, align 4
  call void @putstr(ptr @.str.8)
  call void @putint(i32 %101)
  call void @putstr(ptr @.str.9)
  %102 = load i32, ptr %1, align 4
  %103 = getelementptr inbounds [10 x i32], ptr %11, i32 0, i32 0
  %104 = call i32 @calculate(i32 %102, ptr %103)
  %105 = icmp ne i32 %104, 0
  br i1 %105, label %109, label %106

106:                                              ; preds = %100
  %107 = getelementptr inbounds [12 x i8], ptr %12, i32 0, i32 0
  %108 = call i8 @get_first(ptr %107)
  call void @print(i8 %108)
  br label %109

109:                                              ; preds = %106, %100
  call void @putstr(ptr @.str.10)
  ret i32 0
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define i32 @getchar() #0 {
  %1 = alloca i8, align 1
  %2 = call i32 (ptr, ...) @scanf(ptr noundef @.str.11, ptr noundef %1)
  %3 = load i8, ptr %1, align 1
  %4 = sext i8 %3 to i32
  ret i32 %4
}

declare i32 @scanf(ptr noundef, ...) #1

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define i32 @getint() #0 {
  %1 = alloca i32, align 4
  %2 = call i32 (ptr, ...) @scanf(ptr noundef @.str.1.14, ptr noundef %1)
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
  %5 = call i32 (ptr, ...) @scanf(ptr noundef @.str.1.14, ptr noundef %3)
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
  %15 = call i32 (ptr, ...) @scanf(ptr noundef @.str.1.14, ptr noundef %14)
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
  %4 = call i32 (ptr, ...) @printf(ptr noundef @.str.1.14, i32 noundef %3)
  ret void
}

declare i32 @printf(ptr noundef, ...) #1

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define void @putch(i32 noundef %0) #0 {
  %2 = alloca i32, align 4
  store i32 %0, ptr %2, align 4
  %3 = load i32, ptr %2, align 4
  %4 = call i32 (ptr, ...) @printf(ptr noundef @.str.11, i32 noundef %3)
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
  %7 = call i32 (ptr, ...) @printf(ptr noundef @.str.2.19, i32 noundef %6)
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
  %18 = call i32 (ptr, ...) @printf(ptr noundef @.str.3.20, i32 noundef %17)
  br label %19

19:                                               ; preds = %12
  %20 = load i32, ptr %5, align 4
  %21 = add nsw i32 %20, 1
  store i32 %21, ptr %5, align 4
  br label %8, !llvm.loop !9

22:                                               ; preds = %8
  %23 = call i32 (ptr, ...) @printf(ptr noundef @.str.4.21)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define void @putstr(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = call i32 (ptr, ...) @printf(ptr noundef @.str.5.24, ptr noundef %3)
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
