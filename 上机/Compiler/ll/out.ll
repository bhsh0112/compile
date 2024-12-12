; ModuleID = 'llvm-link'
source_filename = "llvm-link"
target datalayout = "e-m:o-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx13.3.0"

@.str = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.1 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.2 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.3 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.4 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.5 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.6 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.7 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.8 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.9 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.10 = private unnamed_addr constant [3 x i8] c"%c\00", align 1
@.str.1.11 = private unnamed_addr constant [3 x i8] c"%d\00", align 1
@.str.2.14 = private unnamed_addr constant [4 x i8] c"%d:\00", align 1
@.str.3.15 = private unnamed_addr constant [4 x i8] c" %d\00", align 1
@.str.4.16 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.5.19 = private unnamed_addr constant [3 x i8] c"%s\00", align 1

define dso_local i32 @getIndex(ptr %0, i32 %1) {
  %3 = alloca ptr, align 8
  store ptr %0, ptr %3, align 8
  %4 = alloca i32, align 4
  store i32 %1, ptr %4, align 4
  %5 = load i32, ptr %4, align 4
  %6 = load ptr, ptr %3, align 8
  %7 = getelementptr inbounds i32, ptr %6, i32 %5
  %8 = load i32, ptr %7, align 4
  ret i32 %8
}

define dso_local i32 @setIndex(ptr %0, i32 %1, i32 %2) {
  %4 = alloca ptr, align 8
  store ptr %0, ptr %4, align 8
  %5 = alloca i32, align 4
  store i32 %1, ptr %5, align 4
  %6 = alloca i32, align 4
  store i32 %2, ptr %6, align 4
  %7 = alloca i32, align 4
  %8 = load i32, ptr %5, align 4
  %9 = load ptr, ptr %4, align 8
  %10 = getelementptr inbounds i32, ptr %9, i32 %8
  %11 = load i32, ptr %10, align 4
  store i32 %11, ptr %7, align 4
  %12 = load i32, ptr %5, align 4
  %13 = load ptr, ptr %4, align 8
  %14 = getelementptr inbounds i32, ptr %13, i32 %12
  %15 = load i32, ptr %6, align 4
  store i32 %15, ptr %14, align 4
  %16 = load i32, ptr %7, align 4
  ret i32 %16
}

define dso_local i32 @main() {
  %1 = alloca [5 x i32], align 4
  %2 = getelementptr inbounds [5 x i32], ptr %1, i32 0, i32 0
  store i32 0, ptr %2, align 4
  %3 = getelementptr inbounds i32, ptr %2, i32 1
  store i32 1, ptr %3, align 4
  %4 = getelementptr inbounds i32, ptr %3, i32 1
  store i32 2, ptr %4, align 4
  %5 = getelementptr inbounds i32, ptr %4, i32 1
  store i32 3, ptr %5, align 4
  %6 = getelementptr inbounds i32, ptr %5, i32 1
  store i32 4, ptr %6, align 4
  %7 = alloca [5 x i32], align 4
  %8 = getelementptr inbounds [5 x i32], ptr %7, i32 0, i32 0
  store i32 0, ptr %8, align 4
  %9 = getelementptr inbounds i32, ptr %8, i32 1
  store i32 0, ptr %9, align 4
  %10 = getelementptr inbounds i32, ptr %9, i32 1
  store i32 0, ptr %10, align 4
  %11 = getelementptr inbounds i32, ptr %10, i32 1
  store i32 0, ptr %11, align 4
  %12 = getelementptr inbounds i32, ptr %11, i32 1
  store i32 0, ptr %12, align 4
  %13 = getelementptr inbounds [5 x i32], ptr %7, i32 0, i32 0
  %14 = getelementptr inbounds [5 x i32], ptr %1, i32 0, i32 0
  %15 = call i32 @getIndex(ptr %14, i32 0)
  %16 = add nsw i32 %15, 0
  %17 = call i32 @setIndex(ptr %13, i32 0, i32 %16)
  call void @putint(i32 %17)
  call void @putstr(ptr @.str)
  %18 = getelementptr inbounds [5 x i32], ptr %7, i32 0, i32 0
  %19 = getelementptr inbounds [5 x i32], ptr %1, i32 0, i32 0
  %20 = call i32 @getIndex(ptr %19, i32 1)
  %21 = add nsw i32 %20, 1
  %22 = call i32 @setIndex(ptr %18, i32 1, i32 %21)
  call void @putint(i32 %22)
  call void @putstr(ptr @.str.1)
  %23 = getelementptr inbounds [5 x i32], ptr %7, i32 0, i32 0
  %24 = getelementptr inbounds [5 x i32], ptr %1, i32 0, i32 0
  %25 = call i32 @getIndex(ptr %24, i32 2)
  %26 = add nsw i32 %25, 2
  %27 = call i32 @setIndex(ptr %23, i32 2, i32 %26)
  call void @putint(i32 %27)
  call void @putstr(ptr @.str.2)
  %28 = getelementptr inbounds [5 x i32], ptr %7, i32 0, i32 0
  %29 = getelementptr inbounds [5 x i32], ptr %1, i32 0, i32 0
  %30 = call i32 @getIndex(ptr %29, i32 3)
  %31 = add nsw i32 %30, 3
  %32 = call i32 @setIndex(ptr %28, i32 3, i32 %31)
  call void @putint(i32 %32)
  call void @putstr(ptr @.str.3)
  %33 = getelementptr inbounds [5 x i32], ptr %7, i32 0, i32 0
  %34 = getelementptr inbounds [5 x i32], ptr %1, i32 0, i32 0
  %35 = call i32 @getIndex(ptr %34, i32 4)
  %36 = add nsw i32 %35, 4
  %37 = call i32 @setIndex(ptr %33, i32 4, i32 %36)
  call void @putint(i32 %37)
  call void @putstr(ptr @.str.4)
  %38 = getelementptr inbounds [5 x i32], ptr %7, i32 0, i32 0
  %39 = call i32 @getIndex(ptr %38, i32 0)
  call void @putint(i32 %39)
  call void @putstr(ptr @.str.5)
  %40 = getelementptr inbounds [5 x i32], ptr %7, i32 0, i32 0
  %41 = call i32 @getIndex(ptr %40, i32 1)
  call void @putint(i32 %41)
  call void @putstr(ptr @.str.6)
  %42 = getelementptr inbounds [5 x i32], ptr %7, i32 0, i32 0
  %43 = call i32 @getIndex(ptr %42, i32 2)
  call void @putint(i32 %43)
  call void @putstr(ptr @.str.7)
  %44 = getelementptr inbounds [5 x i32], ptr %7, i32 0, i32 0
  %45 = call i32 @getIndex(ptr %44, i32 3)
  call void @putint(i32 %45)
  call void @putstr(ptr @.str.8)
  %46 = getelementptr inbounds [5 x i32], ptr %7, i32 0, i32 0
  %47 = call i32 @getIndex(ptr %46, i32 4)
  call void @putint(i32 %47)
  call void @putstr(ptr @.str.9)
  ret i32 0
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define i32 @getchar() #0 {
  %1 = alloca i8, align 1
  %2 = call i32 (ptr, ...) @scanf(ptr noundef @.str.10, ptr noundef %1)
  %3 = load i8, ptr %1, align 1
  %4 = sext i8 %3 to i32
  ret i32 %4
}

declare i32 @scanf(ptr noundef, ...) #1

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define i32 @getint() #0 {
  %1 = alloca i32, align 4
  %2 = call i32 (ptr, ...) @scanf(ptr noundef @.str.1.11, ptr noundef %1)
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
  %5 = call i32 (ptr, ...) @scanf(ptr noundef @.str.1.11, ptr noundef %3)
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
  %15 = call i32 (ptr, ...) @scanf(ptr noundef @.str.1.11, ptr noundef %14)
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
  %4 = call i32 (ptr, ...) @printf(ptr noundef @.str.1.11, i32 noundef %3)
  ret void
}

declare i32 @printf(ptr noundef, ...) #1

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define void @putch(i32 noundef %0) #0 {
  %2 = alloca i32, align 4
  store i32 %0, ptr %2, align 4
  %3 = load i32, ptr %2, align 4
  %4 = call i32 (ptr, ...) @printf(ptr noundef @.str.10, i32 noundef %3)
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
  %7 = call i32 (ptr, ...) @printf(ptr noundef @.str.2.14, i32 noundef %6)
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
  %18 = call i32 (ptr, ...) @printf(ptr noundef @.str.3.15, i32 noundef %17)
  br label %19

19:                                               ; preds = %12
  %20 = load i32, ptr %5, align 4
  %21 = add nsw i32 %20, 1
  store i32 %21, ptr %5, align 4
  br label %8, !llvm.loop !9

22:                                               ; preds = %8
  %23 = call i32 (ptr, ...) @printf(ptr noundef @.str.4.16)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define void @putstr(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = call i32 (ptr, ...) @printf(ptr noundef @.str.5.19, ptr noundef %3)
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
