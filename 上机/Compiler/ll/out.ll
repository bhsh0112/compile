; ModuleID = 'llvm-link'
source_filename = "llvm-link"
target datalayout = "e-m:o-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx13.3.0"

@singleConstDecl = dso_local global i32 23
@singleConstDecl_0 = dso_local global i32 13
@singleConstDecl_1 = dso_local global i32 3
@singleVarDecl = dso_local global i32 -10
@singleVarDecl_0 = dso_local global i32 23
@singleVarDecl_1 = dso_local global i32 10
@singleVarDecl_2 = dso_local global i32 0
@.str = private unnamed_addr constant [13 x i8] c"print int : \00", align 1
@.str.1 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.2 = private unnamed_addr constant [10 x i8] c"19373479\0A\00", align 1
@.str.3 = private unnamed_addr constant [3 x i8] c"%c\00", align 1
@.str.1.6 = private unnamed_addr constant [3 x i8] c"%d\00", align 1
@.str.2.9 = private unnamed_addr constant [4 x i8] c"%d:\00", align 1
@.str.3.10 = private unnamed_addr constant [4 x i8] c" %d\00", align 1
@.str.4 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.5 = private unnamed_addr constant [3 x i8] c"%s\00", align 1

define dso_local void @funcDef_void() {
  ret void
}

define dso_local i32 @funcDef_0(i32 %0) {
  %2 = alloca i32, align 4
  store i32 %0, ptr %2, align 4
  %3 = alloca i32, align 4
  %4 = load i32, ptr %2, align 4
  %5 = mul nsw i32 %4, 10
  store i32 %5, ptr %3, align 4
  %6 = load i32, ptr %3, align 4
  ret i32 %6
}

define dso_local i32 @funcDef_1(i32 %0, i32 %1) {
  %3 = alloca i32, align 4
  store i32 %0, ptr %3, align 4
  %4 = alloca i32, align 4
  store i32 %1, ptr %4, align 4
  %5 = alloca i32, align 4
  %6 = load i32, ptr %3, align 4
  %7 = load i32, ptr %4, align 4
  %8 = mul nsw i32 %6, %7
  store i32 %8, ptr %5, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = load i32, ptr %4, align 4
  %12 = icmp ne i32 %11, 0
  br i1 %12, label %13, label %22

13:                                               ; preds = %2
  %14 = load i32, ptr %5, align 4
  %15 = load i32, ptr %3, align 4
  %16 = load i32, ptr %4, align 4
  %17 = srem i32 %15, %16
  %18 = add nsw i32 %14, %17
  store i32 %18, ptr %9, align 4
  %19 = load i32, ptr %3, align 4
  %20 = load i32, ptr %4, align 4
  %21 = sdiv i32 %19, %20
  store i32 %21, ptr %10, align 4
  br label %28

22:                                               ; preds = %2
  %23 = load i32, ptr %5, align 4
  %24 = load i32, ptr %3, align 4
  %25 = add nsw i32 %23, %24
  store i32 %25, ptr %9, align 4
  %26 = load i32, ptr %3, align 4
  %27 = sdiv i32 %26, 2
  store i32 %27, ptr %10, align 4
  br label %28

28:                                               ; preds = %22, %13
  %29 = load i32, ptr %9, align 4
  %30 = load i32, ptr %5, align 4
  %31 = sub nsw i32 %29, %30
  store i32 %31, ptr %9, align 4
  %32 = load i32, ptr %5, align 4
  %33 = load i32, ptr %9, align 4
  %34 = add nsw i32 %32, %33
  %35 = load i32, ptr %5, align 4
  %36 = icmp slt i32 %35, 0
  br i1 %36, label %37, label %40

37:                                               ; preds = %28
  %38 = load i32, ptr %5, align 4
  %39 = sub nsw i32 0, %38
  store i32 %39, ptr %5, align 4
  br label %40

40:                                               ; preds = %37, %28
  %41 = load i32, ptr %5, align 4
  %42 = add nsw i32 1, %41
  %43 = load i32, ptr %9, align 4
  %44 = load i32, ptr %10, align 4
  %45 = add nsw i32 %43, %44
  %46 = mul nsw i32 %42, %45
  ret i32 %46
}

define dso_local void @printInt(i32 %0) {
  %2 = alloca i32, align 4
  store i32 %0, ptr %2, align 4
  %3 = load i32, ptr %2, align 4
  call void @putstr(ptr @.str)
  call void @putint(i32 %3)
  call void @putstr(ptr @.str.1)
  ret void
}

define dso_local i32 @main() {
  call void @putstr(ptr @.str.2)
  %1 = alloca i32, align 4
  store i32 10, ptr %1, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = call i32 @getint()
  store i32 %6, ptr %2, align 4
  %7 = call i32 @getint()
  store i32 %7, ptr %3, align 4
  %8 = call i32 @getint()
  store i32 %8, ptr %4, align 4
  %9 = call i32 @getint()
  store i32 %9, ptr %5, align 4
  %10 = load i32, ptr %2, align 4
  %11 = icmp sgt i32 %10, 5
  br i1 %11, label %12, label %13

12:                                               ; preds = %0
  store i32 5, ptr %2, align 4
  br label %13

13:                                               ; preds = %12, %0
  br label %14

14:                                               ; preds = %65, %13
  %15 = load i32, ptr %1, align 4
  %16 = icmp ne i32 %15, 0
  br i1 %16, label %17, label %66

17:                                               ; preds = %14
  %18 = load i32, ptr %1, align 4
  %19 = sub nsw i32 %18, 1
  store i32 %19, ptr %1, align 4
  %20 = load i32, ptr %3, align 4
  %21 = load i32, ptr %1, align 4
  %22 = icmp sge i32 %20, %21
  br i1 %22, label %23, label %30

23:                                               ; preds = %17
  %24 = load i32, ptr %3, align 4
  %25 = load i32, ptr %1, align 4
  %26 = add nsw i32 %25, 1
  %27 = sdiv i32 %24, %26
  %28 = load i32, ptr %1, align 4
  %29 = add nsw i32 %27, %28
  store i32 %29, ptr %3, align 4
  br label %30

30:                                               ; preds = %23, %17
  %31 = load i32, ptr %4, align 4
  %32 = load i32, ptr %1, align 4
  %33 = icmp sle i32 %31, %32
  br i1 %33, label %34, label %38

34:                                               ; preds = %30
  %35 = load i32, ptr %4, align 4
  %36 = load i32, ptr %1, align 4
  %37 = mul nsw i32 %35, %36
  store i32 %37, ptr %4, align 4
  br label %43

38:                                               ; preds = %30
  %39 = load i32, ptr %4, align 4
  %40 = load i32, ptr %1, align 4
  %41 = add nsw i32 %40, 3
  %42 = srem i32 %39, %41
  store i32 %42, ptr %4, align 4
  br label %43

43:                                               ; preds = %38, %34
  br label %44

44:                                               ; preds = %64, %60, %43
  %45 = load i32, ptr %5, align 4
  %46 = load i32, ptr %4, align 4
  %47 = icmp slt i32 %45, %46
  br i1 %47, label %48, label %65

48:                                               ; preds = %44
  %49 = load i32, ptr %5, align 4
  %50 = load i32, ptr %1, align 4
  %51 = add nsw i32 %49, %50
  store i32 %51, ptr %5, align 4
  %52 = load i32, ptr %5, align 4
  %53 = load i32, ptr %2, align 4
  %54 = icmp eq i32 %52, %53
  br i1 %54, label %55, label %56

55:                                               ; preds = %48
  br label %65

56:                                               ; preds = %48
  %57 = load i32, ptr %5, align 4
  %58 = load i32, ptr %3, align 4
  %59 = icmp ne i32 %57, %58
  br i1 %59, label %60, label %64

60:                                               ; preds = %56
  %61 = load i32, ptr %3, align 4
  %62 = load i32, ptr %5, align 4
  %63 = add nsw i32 %61, %62
  store i32 %63, ptr %5, align 4
  br label %44

64:                                               ; preds = %56
  br label %44

65:                                               ; preds = %55, %44
  br label %14

66:                                               ; preds = %14
  %67 = load i32, ptr %1, align 4
  %68 = icmp ne i32 %67, 0
  br i1 %68, label %71, label %69

69:                                               ; preds = %66
  %70 = load i32, ptr %1, align 4
  call void @printInt(i32 %70)
  br label %71

71:                                               ; preds = %69, %66
  %72 = load i32, ptr %2, align 4
  call void @printInt(i32 %72)
  %73 = load i32, ptr %3, align 4
  call void @printInt(i32 %73)
  %74 = load i32, ptr %4, align 4
  call void @printInt(i32 %74)
  %75 = load i32, ptr %5, align 4
  call void @printInt(i32 %75)
  %76 = alloca i32, align 4
  %77 = load i32, ptr %5, align 4
  %78 = load i32, ptr %4, align 4
  %79 = call i32 @funcDef_1(i32 %77, i32 %78)
  store i32 %79, ptr %76, align 4
  %80 = alloca i32, align 4
  %81 = load i32, ptr %76, align 4
  %82 = load i32, ptr %3, align 4
  %83 = call i32 @funcDef_0(i32 %82)
  %84 = call i32 @funcDef_1(i32 %81, i32 %83)
  store i32 %84, ptr %80, align 4
  call void @funcDef_void()
  %85 = load i32, ptr %76, align 4
  call void @printInt(i32 %85)
  %86 = load i32, ptr %80, align 4
  call void @printInt(i32 %86)
  %87 = load i32, ptr @singleVarDecl, align 4
  %88 = load i32, ptr @singleVarDecl_2, align 4
  %89 = call i32 @funcDef_1(i32 %87, i32 %88)
  %90 = load i32, ptr @singleConstDecl_0, align 4
  %91 = load i32, ptr @singleConstDecl_1, align 4
  %92 = call i32 @funcDef_1(i32 %90, i32 %91)
  %93 = call i32 @funcDef_1(i32 %89, i32 %92)
  store i32 %93, ptr @singleVarDecl_2, align 4
  %94 = load i32, ptr @singleVarDecl_2, align 4
  call void @printInt(i32 %94)
  ret i32 0
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define i32 @getchar() #0 {
  %1 = alloca i8, align 1
  %2 = call i32 (ptr, ...) @scanf(ptr noundef @.str.3, ptr noundef %1)
  %3 = load i8, ptr %1, align 1
  %4 = sext i8 %3 to i32
  ret i32 %4
}

declare i32 @scanf(ptr noundef, ...) #1

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define i32 @getint() #0 {
  %1 = alloca i32, align 4
  %2 = call i32 (ptr, ...) @scanf(ptr noundef @.str.1.6, ptr noundef %1)
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
  %5 = call i32 (ptr, ...) @scanf(ptr noundef @.str.1.6, ptr noundef %3)
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
  %15 = call i32 (ptr, ...) @scanf(ptr noundef @.str.1.6, ptr noundef %14)
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
  %4 = call i32 (ptr, ...) @printf(ptr noundef @.str.1.6, i32 noundef %3)
  ret void
}

declare i32 @printf(ptr noundef, ...) #1

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define void @putch(i32 noundef %0) #0 {
  %2 = alloca i32, align 4
  store i32 %0, ptr %2, align 4
  %3 = load i32, ptr %2, align 4
  %4 = call i32 (ptr, ...) @printf(ptr noundef @.str.3, i32 noundef %3)
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
  %7 = call i32 (ptr, ...) @printf(ptr noundef @.str.2.9, i32 noundef %6)
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
  %18 = call i32 (ptr, ...) @printf(ptr noundef @.str.3.10, i32 noundef %17)
  br label %19

19:                                               ; preds = %12
  %20 = load i32, ptr %5, align 4
  %21 = add nsw i32 %20, 1
  store i32 %21, ptr %5, align 4
  br label %8, !llvm.loop !9

22:                                               ; preds = %8
  %23 = call i32 (ptr, ...) @printf(ptr noundef @.str.4)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define void @putstr(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = call i32 (ptr, ...) @printf(ptr noundef @.str.5, ptr noundef %3)
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
