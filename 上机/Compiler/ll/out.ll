; ModuleID = 'llvm-link'
source_filename = "llvm-link"
target datalayout = "e-m:o-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx13.3.0"

@c = dso_local global i32 10
@x = dso_local global i32 0
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
@.str.11 = private unnamed_addr constant [3 x i8] c"%c\00", align 1
@.str.1.14 = private unnamed_addr constant [3 x i8] c"%d\00", align 1
@.str.2.17 = private unnamed_addr constant [4 x i8] c"%d:\00", align 1
@.str.3.18 = private unnamed_addr constant [4 x i8] c" %d\00", align 1
@.str.4.19 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.5.22 = private unnamed_addr constant [3 x i8] c"%s\00", align 1

define dso_local void @f1() {
  %1 = alloca i32, align 4
  store i32 0, ptr %1, align 4
  br label %2

2:                                                ; preds = %8, %0
  %3 = load i32, ptr %1, align 4
  %4 = icmp slt i32 %3, 5
  br i1 %4, label %5, label %11

5:                                                ; preds = %2
  %6 = load i32, ptr @x, align 4
  %7 = add nsw i32 %6, 1
  store i32 %7, ptr @x, align 4
  br label %8

8:                                                ; preds = %5
  %9 = load i32, ptr %1, align 4
  %10 = add nsw i32 %9, 1
  store i32 %10, ptr %1, align 4
  br label %2

11:                                               ; preds = %2
  ret void
}

define dso_local i32 @f2() {
  %1 = load i32, ptr @x, align 4
  %2 = icmp sgt i32 %1, 0
  br i1 %2, label %3, label %4

3:                                                ; preds = %0
  ret i32 -1

4:                                                ; preds = %0
  ret i32 1

5:                                                ; No predecessors!
  %6 = load i32, ptr @x, align 4
  ret i32 %6
}

define dso_local void @f3(i32 %0) {
  %2 = alloca i32, align 4
  store i32 %0, ptr %2, align 4
  %3 = load i32, ptr %2, align 4
  store i32 %3, ptr @x, align 4
  ret void
}

define dso_local i32 @f4(i32 %0) {
  %2 = alloca i32, align 4
  store i32 %0, ptr %2, align 4
  %3 = load i32, ptr %2, align 4
  %4 = icmp sgt i32 %3, 0
  br i1 %4, label %5, label %8

5:                                                ; preds = %1
  %6 = load i32, ptr %2, align 4
  %7 = add nsw i32 0, %6
  ret i32 %7

8:                                                ; preds = %1
  %9 = load i32, ptr %2, align 4
  %10 = sub nsw i32 0, %9
  ret i32 %10
}

define dso_local i32 @f5(i32 %0, i32 %1, i32 %2) {
  %4 = alloca i32, align 4
  store i32 %0, ptr %4, align 4
  %5 = alloca i32, align 4
  store i32 %1, ptr %5, align 4
  %6 = alloca i32, align 4
  store i32 %2, ptr %6, align 4
  %7 = load i32, ptr %4, align 4
  %8 = load i32, ptr %5, align 4
  %9 = icmp sgt i32 %7, %8
  br i1 %9, label %10, label %19

10:                                               ; preds = %3
  %11 = load i32, ptr %4, align 4
  %12 = load i32, ptr %6, align 4
  %13 = icmp sgt i32 %11, %12
  br i1 %13, label %14, label %16

14:                                               ; preds = %10
  %15 = load i32, ptr %4, align 4
  ret i32 %15

16:                                               ; preds = %10
  %17 = load i32, ptr %6, align 4
  ret i32 %17

18:                                               ; No predecessors!
  br label %19

19:                                               ; preds = %18, %3
  %20 = load i32, ptr %5, align 4
  %21 = load i32, ptr %6, align 4
  %22 = icmp sgt i32 %20, %21
  br i1 %22, label %23, label %32

23:                                               ; preds = %19
  %24 = load i32, ptr %5, align 4
  %25 = load i32, ptr %4, align 4
  %26 = icmp sgt i32 %24, %25
  br i1 %26, label %27, label %29

27:                                               ; preds = %23
  %28 = load i32, ptr %5, align 4
  ret i32 %28

29:                                               ; preds = %23
  %30 = load i32, ptr %4, align 4
  ret i32 %30

31:                                               ; No predecessors!
  br label %32

32:                                               ; preds = %31, %19
  %33 = load i32, ptr %6, align 4
  %34 = load i32, ptr %4, align 4
  %35 = icmp sgt i32 %33, %34
  br i1 %35, label %36, label %45

36:                                               ; preds = %32
  %37 = load i32, ptr %6, align 4
  %38 = load i32, ptr %5, align 4
  %39 = icmp sgt i32 %37, %38
  br i1 %39, label %40, label %42

40:                                               ; preds = %36
  %41 = load i32, ptr %6, align 4
  ret i32 %41

42:                                               ; preds = %36
  %43 = load i32, ptr %5, align 4
  ret i32 %43

44:                                               ; No predecessors!
  br label %45

45:                                               ; preds = %44, %32
  %46 = load i32, ptr %4, align 4
  %47 = call i32 @f4(i32 %46)
  ret i32 %47
}

define dso_local i32 @f6(i32 %0) {
  %2 = alloca i32, align 4
  store i32 %0, ptr %2, align 4
  %3 = load i32, ptr @x, align 4
  %4 = load i32, ptr %2, align 4
  %5 = add nsw i32 %3, %4
  store i32 %5, ptr @x, align 4
  %6 = load i32, ptr %2, align 4
  %7 = icmp eq i32 %6, 0
  br i1 %7, label %8, label %9

8:                                                ; preds = %1
  ret i32 0

9:                                                ; preds = %1
  %10 = load i32, ptr %2, align 4
  %11 = sub nsw i32 %10, 1
  %12 = call i32 @f6(i32 %11)
  ret i32 %12
}

define dso_local i32 @main() {
  call void @putstr(ptr @.str)
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  store i32 5, ptr %2, align 4
  %3 = alloca i32, align 4
  store i32 0, ptr %1, align 4
  br label %4

4:                                                ; preds = %8, %0
  %5 = load i32, ptr %1, align 4
  %6 = icmp slt i32 %5, 5
  br i1 %6, label %7, label %11

7:                                                ; preds = %4
  br label %8

8:                                                ; preds = %7
  %9 = load i32, ptr %1, align 4
  %10 = add nsw i32 %9, 1
  store i32 %10, ptr %1, align 4
  br label %4

11:                                               ; preds = %4
  %12 = load i32, ptr %1, align 4
  %13 = icmp eq i32 %12, 5
  br i1 %13, label %14, label %15

14:                                               ; preds = %11
  call void @putstr(ptr @.str.1)
  br label %15

15:                                               ; preds = %14, %11
  store i32 0, ptr %1, align 4
  br label %16

16:                                               ; preds = %19, %15
  %17 = load i32, ptr %1, align 4
  %18 = icmp slt i32 %17, 2
  br i1 %18, label %19, label %22

19:                                               ; preds = %16
  %20 = load i32, ptr %1, align 4
  %21 = add nsw i32 %20, 1
  store i32 %21, ptr %1, align 4
  br label %16

22:                                               ; preds = %16
  store i32 2, ptr %1, align 4
  br label %23

23:                                               ; preds = %28, %22
  %24 = load i32, ptr %1, align 4
  %25 = icmp eq i32 %24, 4
  br i1 %25, label %26, label %27

26:                                               ; preds = %23
  br label %31

27:                                               ; preds = %23
  br label %28

28:                                               ; preds = %27
  %29 = load i32, ptr %1, align 4
  %30 = add nsw i32 %29, 1
  store i32 %30, ptr %1, align 4
  br label %23

31:                                               ; preds = %26
  br label %32

32:                                               ; preds = %42, %31
  %33 = load i32, ptr %1, align 4
  %34 = icmp slt i32 %33, 5
  br i1 %34, label %35, label %45

35:                                               ; preds = %32
  %36 = load i32, ptr %1, align 4
  %37 = icmp slt i32 %36, 5
  br i1 %37, label %38, label %39

38:                                               ; preds = %35
  br label %42

39:                                               ; preds = %35
  %40 = load i32, ptr %1, align 4
  %41 = add nsw i32 %40, 2
  store i32 %41, ptr %1, align 4
  br label %42

42:                                               ; preds = %39, %38
  %43 = load i32, ptr %1, align 4
  %44 = add nsw i32 %43, 1
  store i32 %44, ptr %1, align 4
  br label %32

45:                                               ; preds = %32
  store i32 5, ptr %1, align 4
  br label %46

46:                                               ; preds = %52, %45
  %47 = load i32, ptr %1, align 4
  %48 = add nsw i32 %47, 1
  store i32 %48, ptr %1, align 4
  %49 = load i32, ptr %1, align 4
  %50 = icmp eq i32 %49, 6
  br i1 %50, label %51, label %52

51:                                               ; preds = %46
  br label %53

52:                                               ; preds = %46
  br label %46

53:                                               ; preds = %51
  br label %54

54:                                               ; preds = %57, %53
  %55 = load i32, ptr %1, align 4
  %56 = icmp slt i32 %55, 7
  br i1 %56, label %57, label %60

57:                                               ; preds = %54
  %58 = load i32, ptr %1, align 4
  %59 = add nsw i32 %58, 1
  store i32 %59, ptr %1, align 4
  br label %54

60:                                               ; preds = %54
  br label %61

61:                                               ; preds = %66, %60
  %62 = load i32, ptr %1, align 4
  %63 = icmp eq i32 %62, 8
  br i1 %63, label %64, label %65

64:                                               ; preds = %61
  br label %69

65:                                               ; preds = %61
  br label %66

66:                                               ; preds = %65
  %67 = load i32, ptr %1, align 4
  %68 = add nsw i32 %67, 1
  store i32 %68, ptr %1, align 4
  br label %61

69:                                               ; preds = %64
  br label %70

70:                                               ; preds = %76, %69
  %71 = load i32, ptr %1, align 4
  %72 = add nsw i32 %71, 1
  store i32 %72, ptr %1, align 4
  %73 = load i32, ptr %1, align 4
  %74 = icmp eq i32 %73, 10
  br i1 %74, label %75, label %76

75:                                               ; preds = %70
  call void @putstr(ptr @.str.2)
  br label %77

76:                                               ; preds = %70
  br label %70

77:                                               ; preds = %75
  call void @f1()
  %78 = load i32, ptr @x, align 4
  %79 = icmp eq i32 %78, 5
  br i1 %79, label %80, label %85

80:                                               ; preds = %77
  %81 = call i32 @f2()
  %82 = icmp eq i32 %81, -1
  br i1 %82, label %83, label %84

83:                                               ; preds = %80
  call void @putstr(ptr @.str.3)
  br label %84

84:                                               ; preds = %83, %80
  br label %85

85:                                               ; preds = %84, %77
  call void @putstr(ptr @.str.4)
  store i32 -1, ptr @x, align 4
  store i32 0, ptr %1, align 4
  br label %86

86:                                               ; preds = %109, %85
  %87 = load i32, ptr %1, align 4
  %88 = load i32, ptr %1, align 4
  %89 = mul nsw i32 %87, %88
  %90 = load i32, ptr %2, align 4
  %91 = load i32, ptr %2, align 4
  %92 = mul nsw i32 %90, %91
  %93 = sdiv i32 %92, 1
  %94 = icmp slt i32 %89, %93
  br i1 %94, label %95, label %112

95:                                               ; preds = %86
  %96 = call i32 @getint()
  store i32 %96, ptr %3, align 4
  %97 = load i32, ptr %3, align 4
  %98 = call i32 @f4(i32 %97)
  call void @f3(i32 %98)
  %99 = load i32, ptr @x, align 4
  %100 = icmp slt i32 %99, 0
  br i1 %100, label %101, label %102

101:                                              ; preds = %95
  br label %112

102:                                              ; preds = %95
  %103 = load i32, ptr @x, align 4
  %104 = icmp sgt i32 %103, 0
  br i1 %104, label %105, label %106

105:                                              ; preds = %102
  br label %109

106:                                              ; preds = %102
  %107 = load i32, ptr %1, align 4
  %108 = add nsw i32 %107, 1
  store i32 %108, ptr %1, align 4
  br label %109

109:                                              ; preds = %106, %105
  %110 = load i32, ptr %1, align 4
  %111 = add nsw i32 %110, 1
  store i32 %111, ptr %1, align 4
  br label %86

112:                                              ; preds = %101, %86
  %113 = load i32, ptr @x, align 4
  %114 = icmp sge i32 %113, 0
  br i1 %114, label %115, label %116

115:                                              ; preds = %112
  call void @putstr(ptr @.str.5)
  br label %116

116:                                              ; preds = %115, %112
  store i32 10, ptr %1, align 4
  store i32 5, ptr %2, align 4
  store i32 7, ptr %3, align 4
  %117 = load i32, ptr %1, align 4
  %118 = load i32, ptr %2, align 4
  %119 = load i32, ptr %3, align 4
  %120 = call i32 @f5(i32 %117, i32 %118, i32 %119)
  %121 = load i32, ptr %1, align 4
  %122 = icmp eq i32 %120, %121
  br i1 %122, label %123, label %124

123:                                              ; preds = %116
  call void @putstr(ptr @.str.6)
  br label %124

124:                                              ; preds = %123, %116
  store i32 0, ptr @x, align 4
  %125 = load i32, ptr @c, align 4
  %126 = call i32 @f6(i32 %125)
  %127 = load i32, ptr @x, align 4
  call void @putstr(ptr @.str.7)
  call void @putint(i32 %127)
  call void @putstr(ptr @.str.8)
  call void @putstr(ptr @.str.9)
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
  %7 = call i32 (ptr, ...) @printf(ptr noundef @.str.2.17, i32 noundef %6)
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
  %18 = call i32 (ptr, ...) @printf(ptr noundef @.str.3.18, i32 noundef %17)
  br label %19

19:                                               ; preds = %12
  %20 = load i32, ptr %5, align 4
  %21 = add nsw i32 %20, 1
  store i32 %21, ptr %5, align 4
  br label %8, !llvm.loop !9

22:                                               ; preds = %8
  %23 = call i32 (ptr, ...) @printf(ptr noundef @.str.4.19)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define void @putstr(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = call i32 (ptr, ...) @printf(ptr noundef @.str.5.22, ptr noundef %3)
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
