; ModuleID = 'llvm-link'
source_filename = "llvm-link"
target datalayout = "e-m:o-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx13.3.0"

@a1 = dso_local global [10 x i32] zeroinitializer
@a2 = dso_local global [5 x i32] zeroinitializer
@a3 = dso_local global [5 x i32] zeroinitializer
@a4 = dso_local global [5 x i32] [i32 1, i32 2, i32 3, i32 0, i32 0]
@c1 = dso_local global [10 x i8] zeroinitializer
@c2 = dso_local global [5 x i8] zeroinitializer
@c3 = dso_local global [5 x i8] zeroinitializer
@c4 = dso_local global [5 x i8] c"hey\00\00"
@c5 = dso_local global [10 x i8] c"hello\\\00\00\00\00"
@.str = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.1 = private unnamed_addr constant [10 x i8] c"21374275\0A\00", align 1
@.str.2 = private unnamed_addr constant [7 x i8] c"sum = \00", align 1
@.str.3 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.4 = private unnamed_addr constant [9 x i8] c"c4[0] = \00", align 1
@.str.5 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.6 = private unnamed_addr constant [9 x i8] c"c5[0] = \00", align 1
@.str.7 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.8 = private unnamed_addr constant [5 x i8] c"t = \00", align 1
@.str.9 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.10 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.11 = private unnamed_addr constant [11 x i8] c"sum + 1 = \00", align 1
@.str.12 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.13 = private unnamed_addr constant [3 x i8] c"%c\00", align 1
@.str.1.14 = private unnamed_addr constant [3 x i8] c"%d\00", align 1
@.str.2.19 = private unnamed_addr constant [4 x i8] c"%d:\00", align 1
@.str.3.20 = private unnamed_addr constant [4 x i8] c" %d\00", align 1
@.str.4.21 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.5.24 = private unnamed_addr constant [3 x i8] c"%s\00", align 1

define dso_local i32 @f1(ptr %0, i32 %1) {
  %3 = alloca ptr, align 8
  store ptr %0, ptr %3, align 8
  %4 = alloca i32, align 4
  store i32 %1, ptr %4, align 4
  %5 = alloca i32, align 4
  store i32 0, ptr %5, align 4
  %6 = alloca i32, align 4
  store i32 0, ptr %6, align 4
  br label %7

7:                                                ; preds = %18, %2
  %8 = load i32, ptr %6, align 4
  %9 = load i32, ptr %4, align 4
  %10 = icmp slt i32 %8, %9
  br i1 %10, label %11, label %21

11:                                               ; preds = %7
  %12 = load i32, ptr %6, align 4
  %13 = load ptr, ptr %3, align 8
  %14 = getelementptr inbounds i32, ptr %13, i32 %12
  %15 = load i32, ptr %14, align 4
  %16 = load i32, ptr %5, align 4
  %17 = add nsw i32 %16, %15
  store i32 %17, ptr %5, align 4
  br label %18

18:                                               ; preds = %11
  %19 = load i32, ptr %6, align 4
  %20 = add nsw i32 %19, 1
  store i32 %20, ptr %6, align 4
  br label %7

21:                                               ; preds = %7
  %22 = load i32, ptr %5, align 4
  ret i32 %22
}

define dso_local i32 @f2(i32 %0) {
  %2 = alloca i32, align 4
  store i32 %0, ptr %2, align 4
  %3 = load i32, ptr %2, align 4
  %4 = icmp eq i32 %3, 1
  br i1 %4, label %5, label %6

5:                                                ; preds = %1
  ret i32 1

6:                                                ; preds = %1
  %7 = load i32, ptr %2, align 4
  %8 = icmp eq i32 %7, 2
  br i1 %8, label %9, label %10

9:                                                ; preds = %6
  ret i32 1

10:                                               ; preds = %6
  %11 = load i32, ptr %2, align 4
  %12 = sub nsw i32 %11, 1
  %13 = call i32 @f2(i32 %12)
  %14 = load i32, ptr %2, align 4
  %15 = sub nsw i32 %14, 2
  %16 = call i32 @f2(i32 %15)
  %17 = add nsw i32 %13, %16
  ret i32 %17

18:                                               ; No predecessors!
  br label %19

19:                                               ; preds = %18
  ret i32 -1
}

define dso_local void @f3(ptr %0) {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = getelementptr inbounds i8, ptr %3, i32 0
  %5 = load i8, ptr %4, align 1
  %6 = zext i8 %5 to i32
  call void @putch(i32 %6)
  call void @putstr(ptr @.str)
  ret void
}

define dso_local i32 @f4(ptr %0, ptr %1, i32 %2) {
  %4 = alloca ptr, align 8
  store ptr %0, ptr %4, align 8
  %5 = alloca ptr, align 8
  store ptr %1, ptr %5, align 8
  %6 = alloca i32, align 4
  store i32 %2, ptr %6, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  store i32 0, ptr %8, align 4
  store i32 0, ptr %7, align 4
  br label %9

9:                                                ; preds = %25, %3
  %10 = load i32, ptr %7, align 4
  %11 = load i32, ptr %6, align 4
  %12 = icmp slt i32 %10, %11
  br i1 %12, label %13, label %28

13:                                               ; preds = %9
  %14 = load i32, ptr %7, align 4
  %15 = load ptr, ptr %4, align 8
  %16 = getelementptr inbounds i32, ptr %15, i32 %14
  %17 = load i32, ptr %16, align 4
  %18 = load i32, ptr %7, align 4
  %19 = load ptr, ptr %5, align 8
  %20 = getelementptr inbounds i32, ptr %19, i32 %18
  %21 = load i32, ptr %20, align 4
  %22 = load i32, ptr %8, align 4
  %23 = mul nsw i32 %17, %21
  %24 = add nsw i32 %22, %23
  store i32 %24, ptr %8, align 4
  br label %25

25:                                               ; preds = %13
  %26 = load i32, ptr %7, align 4
  %27 = add nsw i32 %26, 1
  store i32 %27, ptr %7, align 4
  br label %9

28:                                               ; preds = %9
  %29 = load i32, ptr %8, align 4
  ret i32 %29
}

define dso_local i32 @main() {
  %1 = alloca i32, align 4
  call void @putstr(ptr @.str.1)
  %2 = getelementptr inbounds i32, ptr @a4, i32 3
  store i32 4, ptr %2, align 4
  %3 = getelementptr inbounds i32, ptr @a4, i32 4
  store i32 5, ptr %3, align 4
  %4 = alloca i32, align 4
  %5 = call i32 @f1(ptr @a4, i32 5)
  store i32 %5, ptr %4, align 4
  %6 = load i32, ptr %4, align 4
  call void @putstr(ptr @.str.2)
  call void @putint(i32 %6)
  call void @putstr(ptr @.str.3)
  %7 = getelementptr inbounds [5 x i8], ptr @c4, i32 0, i32 0
  %8 = load i8, ptr %7, align 1
  call void @putstr(ptr @.str.4)
  %9 = zext i8 %8 to i32
  call void @putch(i32 %9)
  call void @putstr(ptr @.str.5)
  %10 = getelementptr inbounds [10 x i8], ptr @c5, i32 0, i32 0
  %11 = load i8, ptr %10, align 1
  call void @putstr(ptr @.str.6)
  %12 = zext i8 %11 to i32
  call void @putch(i32 %12)
  call void @putstr(ptr @.str.7)
  %13 = alloca i32, align 4
  store i32 100, ptr %13, align 4
  %14 = load i32, ptr %13, align 4
  %15 = add nsw i32 %14, 1
  %16 = srem i32 %15, 25
  %17 = mul nsw i32 %16, 5
  %18 = sub nsw i32 %17, 1
  store i32 %18, ptr %13, align 4
  %19 = load i32, ptr %13, align 4
  call void @putstr(ptr @.str.8)
  call void @putint(i32 %19)
  call void @putstr(ptr @.str.9)
  %20 = call i32 @f2(i32 10)
  store i32 %20, ptr %13, align 4
  %21 = load i32, ptr %13, align 4
  call void @putint(i32 %21)
  call void @putstr(ptr @.str.10)
  %22 = alloca [10 x i8], align 1
  %23 = getelementptr inbounds [10 x i8], ptr %22, i32 0, i32 0
  store i8 49, ptr %23, align 1
  %24 = getelementptr inbounds [10 x i8], ptr %23, i32 0, i32 1
  store i8 50, ptr %24, align 1
  %25 = getelementptr inbounds [10 x i8], ptr %24, i32 0, i32 2
  store i8 51, ptr %25, align 1
  %26 = getelementptr inbounds [10 x i8], ptr %25, i32 0, i32 3
  store i8 52, ptr %26, align 1
  %27 = getelementptr inbounds [10 x i8], ptr %26, i32 0, i32 4
  store i8 53, ptr %27, align 1
  %28 = getelementptr inbounds [10 x i8], ptr %27, i32 0, i32 5
  store i8 54, ptr %28, align 1
  %29 = getelementptr inbounds [10 x i8], ptr %22, i32 0, i32 0
  call void @f3(ptr %29)
  call void @f3(ptr @c4)
  call void @f3(ptr @c5)
  %30 = alloca [3 x i32], align 4
  %31 = getelementptr inbounds [3 x i32], ptr %30, i32 0, i32 0
  store i32 2, ptr %31, align 4
  %32 = getelementptr inbounds i32, ptr %31, i32 1
  store i32 3, ptr %32, align 4
  %33 = getelementptr inbounds i32, ptr %32, i32 1
  store i32 4, ptr %33, align 4
  %34 = alloca [3 x i32], align 4
  %35 = getelementptr inbounds [3 x i32], ptr %34, i32 0, i32 0
  store i32 1, ptr %35, align 4
  %36 = getelementptr inbounds i32, ptr %35, i32 1
  store i32 5, ptr %36, align 4
  %37 = getelementptr inbounds i32, ptr %36, i32 1
  store i32 7, ptr %37, align 4
  %38 = getelementptr inbounds [3 x i32], ptr %30, i32 0, i32 0
  %39 = getelementptr inbounds [3 x i32], ptr %34, i32 0, i32 0
  %40 = getelementptr inbounds [3 x i32], ptr %30, i32 0, i32 1
  %41 = load i32, ptr %40, align 4
  %42 = call i32 @f4(ptr %38, ptr %39, i32 %41)
  %43 = add nsw i32 %42, 1
  call void @putstr(ptr @.str.11)
  call void @putint(i32 %43)
  call void @putstr(ptr @.str.12)
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
