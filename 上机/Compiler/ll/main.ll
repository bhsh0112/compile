; ModuleID = 'test.c'
source_filename = "test.c"
target datalayout = "e-m:o-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx13.3.0"

@a1 = constant i32 1, align 4
@a2 = constant i32 3, align 4
@a3 = constant i32 8, align 4
@b1 = global i32 2, align 4
@b2 = global i32 -5, align 4
@b3 = global i32 6, align 4
@.str = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.1 = private unnamed_addr constant [15 x i8] c"+ is correct!\0A\00", align 1
@.str.2 = private unnamed_addr constant [13 x i8] c"+ is error!\0A\00", align 1
@.str.3 = private unnamed_addr constant [17 x i8] c"Break is error!\0A\00", align 1
@.str.4 = private unnamed_addr constant [20 x i8] c"Continue is error!\0A\00", align 1
@.str.5 = private unnamed_addr constant [13 x i8] c"a1+b1 is %d\0A\00", align 1
@.str.6 = private unnamed_addr constant [13 x i8] c"a2+b2 is %d\0A\00", align 1

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  store i32 0, ptr %1, align 4
  %3 = call i32 (ptr, ...) @printf(ptr noundef @.str)
  store i32 10, ptr %2, align 4
  br label %4

4:                                                ; preds = %30, %13, %0
  %5 = load i32, ptr %2, align 4
  %6 = icmp ne i32 %5, 0
  br i1 %6, label %7, label %31

7:                                                ; preds = %4
  %8 = load i32, ptr %2, align 4
  %9 = sub nsw i32 %8, 1
  store i32 %9, ptr %2, align 4
  %10 = load i32, ptr %2, align 4
  %11 = load i32, ptr @b3, align 4
  %12 = icmp slt i32 %10, %11
  br i1 %12, label %13, label %14

13:                                               ; preds = %7
  br label %4, !llvm.loop !6

14:                                               ; preds = %7
  %15 = load i32, ptr %2, align 4
  %16 = icmp slt i32 %15, 1
  br i1 %16, label %17, label %18

17:                                               ; preds = %14
  br label %31

18:                                               ; preds = %14
  %19 = load i32, ptr %2, align 4
  %20 = icmp eq i32 %19, 3
  br i1 %20, label %21, label %23

21:                                               ; preds = %18
  %22 = call i32 (ptr, ...) @printf(ptr noundef @.str.1)
  br label %25

23:                                               ; preds = %18
  %24 = call i32 (ptr, ...) @printf(ptr noundef @.str.2)
  br label %25

25:                                               ; preds = %23, %21
  %26 = load i32, ptr %2, align 4
  %27 = load i32, ptr @b1, align 4
  %28 = icmp eq i32 %26, %27
  br i1 %28, label %29, label %30

29:                                               ; preds = %25
  br label %31

30:                                               ; preds = %25
  br label %4, !llvm.loop !6

31:                                               ; preds = %29, %17, %4
  %32 = load i32, ptr %2, align 4
  %33 = load i32, ptr @b1, align 4
  %34 = icmp ne i32 %32, %33
  br i1 %34, label %35, label %43

35:                                               ; preds = %31
  %36 = load i32, ptr %2, align 4
  %37 = icmp eq i32 %36, 0
  br i1 %37, label %38, label %40

38:                                               ; preds = %35
  %39 = call i32 (ptr, ...) @printf(ptr noundef @.str.3)
  br label %42

40:                                               ; preds = %35
  %41 = call i32 (ptr, ...) @printf(ptr noundef @.str.4)
  br label %42

42:                                               ; preds = %40, %38
  br label %43

43:                                               ; preds = %42, %31
  %44 = load i32, ptr @b1, align 4
  %45 = add nsw i32 1, %44
  %46 = call i32 (ptr, ...) @printf(ptr noundef @.str.5, i32 noundef %45)
  %47 = load i32, ptr @b2, align 4
  %48 = add nsw i32 3, %47
  %49 = call i32 (ptr, ...) @printf(ptr noundef @.str.6, i32 noundef %48)
  ret i32 0
}

declare i32 @printf(ptr noundef, ...) #1

attributes #0 = { noinline nounwind optnone ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a,+zcm,+zcz" }
attributes #1 = { "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a,+zcm,+zcz" }

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
