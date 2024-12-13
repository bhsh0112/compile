; ModuleID = 'test.c'
source_filename = "test.c"
target datalayout = "e-m:o-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx13.3.0"

@MAX_SIZE = constant i32 10, align 4
@str = global <{ i8, i8, [8 x i8] }> <{ i8 51, i8 39, [8 x i8] zeroinitializer }>, align 1
@global_var = global i32 0, align 4
@.str = private unnamed_addr constant [10 x i8] c"22373040\0A\00", align 1
@.str.1 = private unnamed_addr constant [4 x i8] c"%c\0A\00", align 1
@.str.2 = private unnamed_addr constant [19 x i8] c"Input integer: %d\0A\00", align 1
@.str.3 = private unnamed_addr constant [21 x i8] c"Input character: %c\0A\00", align 1
@__const.main.str = private unnamed_addr constant [12 x i8] c"qwertyuiop\0A\00", align 1
@__const.main._str = private unnamed_addr constant [10 x i8] c"str\00\00\00\00\00\00\00", align 1
@.str.4 = private unnamed_addr constant [14 x i8] c"i is 4 or 9!\0A\00", align 1
@.str.5 = private unnamed_addr constant [10 x i8] c"j is 32!\0A\00", align 1
@.str.6 = private unnamed_addr constant [27 x i8] c"Sum of array elements: %d\0A\00", align 1
@.str.7 = private unnamed_addr constant [16 x i8] c"Test finished!\0A\00", align 1

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define i32 @add(i32 noundef %0, i32 noundef %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store i32 %0, ptr %3, align 4
  store i32 %1, ptr %4, align 4
  %5 = load i32, ptr %3, align 4
  %6 = load i32, ptr %4, align 4
  %7 = add nsw i32 %5, %6
  ret i32 %7
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define i32 @calculate(i32 noundef %0, ptr noundef %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca ptr, align 8
  %6 = alloca i32, align 4
  store i32 %0, ptr %4, align 4
  store ptr %1, ptr %5, align 8
  %7 = load i32, ptr %4, align 4
  %8 = load ptr, ptr %5, align 8
  %9 = getelementptr inbounds i32, ptr %8, i64 0
  %10 = load i32, ptr %9, align 4
  %11 = call i32 @add(i32 noundef %7, i32 noundef %10)
  %12 = load i32, ptr %4, align 4
  %13 = load ptr, ptr %5, align 8
  %14 = getelementptr inbounds i32, ptr %13, i64 1
  %15 = load i32, ptr %14, align 4
  %16 = sub nsw i32 %12, %15
  %17 = mul nsw i32 %11, %16
  %18 = load ptr, ptr %5, align 8
  %19 = getelementptr inbounds i32, ptr %18, i64 2
  %20 = load i32, ptr %19, align 4
  %21 = sdiv i32 %17, %20
  %22 = load i32, ptr %4, align 4
  %23 = srem i32 %21, %22
  %24 = sub nsw i32 %23, -3
  %25 = add nsw i32 %24, 6
  store i32 %25, ptr %6, align 4
  %26 = load i32, ptr %6, align 4
  %27 = icmp sle i32 %26, 5
  br i1 %27, label %28, label %29

28:                                               ; preds = %2
  store i32 1, ptr %3, align 4
  br label %30

29:                                               ; preds = %2
  store i32 0, ptr %3, align 4
  br label %30

30:                                               ; preds = %29, %28
  %31 = load i32, ptr %3, align 4
  ret i32 %31
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define void @printName() #0 {
  %1 = load i32, ptr @global_var, align 4
  %2 = add nsw i32 %1, 1
  store i32 %2, ptr @global_var, align 4
  %3 = load i32, ptr @global_var, align 4
  %4 = icmp ne i32 %3, 0
  br i1 %4, label %5, label %7

5:                                                ; preds = %0
  %6 = call i32 (ptr, ...) @printf(ptr noundef @.str)
  br label %7

7:                                                ; preds = %5, %0
  ret void
}

declare i32 @printf(ptr noundef, ...) #1

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define void @print(i8 noundef signext %0) #0 {
  %2 = alloca i8, align 1
  store i8 %0, ptr %2, align 1
  %3 = load i8, ptr %2, align 1
  %4 = sext i8 %3 to i32
  %5 = call i32 (ptr, ...) @printf(ptr noundef @.str.1, i32 noundef %4)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define signext i8 @get_first(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = getelementptr inbounds i8, ptr %3, i64 0
  %5 = load i8, ptr %4, align 1
  ret i8 %5
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i8, align 1
  %5 = alloca i32, align 4
  %6 = alloca [10 x i32], align 4
  %7 = alloca [12 x i8], align 1
  %8 = alloca [10 x i8], align 1
  %9 = alloca i32, align 4
  %10 = alloca [20 x i32], align 4
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  store i32 0, ptr %1, align 4
  call void @printName()
  store i32 0, ptr %2, align 4
  store i32 8, ptr %3, align 4
  %13 = call i32 @getint()
  store i32 %13, ptr %2, align 4
  %14 = call i32 @getchar()
  %15 = trunc i32 %14 to i8
  store i8 %15, ptr %4, align 1
  %16 = load i32, ptr %2, align 4
  %17 = call i32 (ptr, ...) @printf(ptr noundef @.str.2, i32 noundef %16)
  %18 = load i8, ptr %4, align 1
  %19 = sext i8 %18 to i32
  %20 = call i32 (ptr, ...) @printf(ptr noundef @.str.3, i32 noundef %19)
  store i32 5, ptr %5, align 4
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %7, ptr align 1 @__const.main.str, i64 12, i1 false)
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %8, ptr align 1 @__const.main._str, i64 10, i1 false)
  store i32 0, ptr %2, align 4
  br label %21

21:                                               ; preds = %66, %0
  %22 = load i32, ptr %2, align 4
  %23 = icmp slt i32 %22, 10
  br i1 %23, label %24, label %69

24:                                               ; preds = %21
  %25 = load i32, ptr %2, align 4
  %26 = load i32, ptr %2, align 4
  %27 = sext i32 %26 to i64
  %28 = getelementptr inbounds [10 x i32], ptr %6, i64 0, i64 %27
  store i32 %25, ptr %28, align 4
  %29 = load i32, ptr %2, align 4
  %30 = icmp eq i32 %29, 4
  br i1 %30, label %31, label %36

31:                                               ; preds = %24
  %32 = load i32, ptr %2, align 4
  %33 = load i8, ptr %4, align 1
  %34 = sext i8 %33 to i32
  %35 = icmp slt i32 %32, %34
  br i1 %35, label %39, label %36

36:                                               ; preds = %31, %24
  %37 = load i32, ptr %2, align 4
  %38 = icmp sge i32 %37, 9
  br i1 %38, label %39, label %57

39:                                               ; preds = %36, %31
  %40 = call i32 (ptr, ...) @printf(ptr noundef @.str.4)
  store i32 1, ptr %9, align 4
  br label %41

41:                                               ; preds = %52, %39
  %42 = load i32, ptr %9, align 4
  %43 = icmp sgt i32 %42, 100
  br i1 %43, label %44, label %45

44:                                               ; preds = %41
  br label %56

45:                                               ; preds = %41
  %46 = load i32, ptr %9, align 4
  %47 = icmp ne i32 %46, 32
  br i1 %47, label %48, label %49

48:                                               ; preds = %45
  br label %52

49:                                               ; preds = %45
  br label %50

50:                                               ; preds = %49
  %51 = call i32 (ptr, ...) @printf(ptr noundef @.str.5)
  br label %52

52:                                               ; preds = %50, %48
  %53 = load i32, ptr %9, align 4
  %54 = load i32, ptr %9, align 4
  %55 = add nsw i32 %53, %54
  store i32 %55, ptr %9, align 4
  br label %41

56:                                               ; preds = %44
  br label %57

57:                                               ; preds = %56, %36
  %58 = load i32, ptr %2, align 4
  %59 = srem i32 %58, 2
  %60 = icmp eq i32 %59, 0
  br i1 %60, label %61, label %64

61:                                               ; preds = %57
  br label %62

62:                                               ; preds = %61
  br label %63

63:                                               ; preds = %62
  br label %65

64:                                               ; preds = %57
  br label %65

65:                                               ; preds = %64, %63
  br label %66

66:                                               ; preds = %65
  %67 = load i32, ptr %2, align 4
  %68 = add nsw i32 %67, 1
  store i32 %68, ptr %2, align 4
  br label %21, !llvm.loop !6

69:                                               ; preds = %21
  call void @llvm.memset.p0.i64(ptr align 4 %10, i8 0, i64 80, i1 false)
  %70 = getelementptr inbounds <{ i32, i32, i32, [17 x i32] }>, ptr %10, i32 0, i32 0
  store i32 3, ptr %70, align 4
  %71 = getelementptr inbounds <{ i32, i32, i32, [17 x i32] }>, ptr %10, i32 0, i32 1
  store i32 2, ptr %71, align 4
  %72 = getelementptr inbounds <{ i32, i32, i32, [17 x i32] }>, ptr %10, i32 0, i32 2
  store i32 1, ptr %72, align 4
  store i32 0, ptr %11, align 4
  store i32 0, ptr %12, align 4
  br label %73

73:                                               ; preds = %87, %69
  %74 = load i32, ptr %12, align 4
  %75 = icmp slt i32 %74, 10
  br i1 %75, label %76, label %90

76:                                               ; preds = %73
  %77 = load i32, ptr %12, align 4
  %78 = icmp slt i32 %77, 3
  br i1 %78, label %79, label %86

79:                                               ; preds = %76
  %80 = load i32, ptr %11, align 4
  %81 = load i32, ptr %12, align 4
  %82 = sext i32 %81 to i64
  %83 = getelementptr inbounds [20 x i32], ptr %10, i64 0, i64 %82
  %84 = load i32, ptr %83, align 4
  %85 = add nsw i32 %80, %84
  store i32 %85, ptr %11, align 4
  br label %86

86:                                               ; preds = %79, %76
  br label %87

87:                                               ; preds = %86
  %88 = load i32, ptr %12, align 4
  %89 = add nsw i32 %88, 1
  store i32 %89, ptr %12, align 4
  br label %73, !llvm.loop !8

90:                                               ; preds = %73
  %91 = load i32, ptr %11, align 4
  %92 = call i32 (ptr, ...) @printf(ptr noundef @.str.6, i32 noundef %91)
  %93 = load i32, ptr %2, align 4
  %94 = getelementptr inbounds [10 x i32], ptr %6, i64 0, i64 0
  %95 = call i32 @calculate(i32 noundef %93, ptr noundef %94)
  %96 = icmp ne i32 %95, 0
  br i1 %96, label %100, label %97

97:                                               ; preds = %90
  %98 = getelementptr inbounds [12 x i8], ptr %7, i64 0, i64 0
  %99 = call signext i8 @get_first(ptr noundef %98)
  call void @print(i8 noundef signext %99)
  br label %100

100:                                              ; preds = %97, %90
  %101 = call i32 (ptr, ...) @printf(ptr noundef @.str.7)
  ret i32 0
}

declare i32 @getint() #1

declare i32 @getchar() #1

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p0.p0.i64(ptr noalias nocapture writeonly, ptr noalias nocapture readonly, i64, i1 immarg) #2

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: write)
declare void @llvm.memset.p0.i64(ptr nocapture writeonly, i8, i64, i1 immarg) #3

attributes #0 = { noinline nounwind optnone ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a,+zcm,+zcz" }
attributes #1 = { "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a,+zcm,+zcz" }
attributes #2 = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }
attributes #3 = { nocallback nofree nounwind willreturn memory(argmem: write) }

!llvm.module.flags = !{!0, !1, !2, !3, !4}
!llvm.ident = !{!5}

!0 = !{i32 2, !"SDK Version", [2 x i32] [i32 13, i32 3]}
!1 = !{i32 1, !"wchar_size", i32 4}
!2 = !{i32 8, !"PIC Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 1}
!4 = !{i32 7, !"frame-pointer", i32 1}
!5 = !{!"Homebrew clang version 19.1.5"}
!6 = distinct !{!6, !7}
!7 = !{!"llvm.loop.mustprogress"}
!8 = distinct !{!8, !7}
