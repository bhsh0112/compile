; ModuleID = 'llvm-link'
source_filename = "llvm-link"
target datalayout = "e-m:o-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx13.3.0"

@constIntArray = dso_local global [3 x i32] [i32 10, i32 20, i32 30]
@constCharArray = dso_local global [5 x i8] c"ABCDE"
@constCharArray2 = dso_local global [5 x i8] c"abc\00\00"
@intArray = dso_local global [5 x i32] zeroinitializer
@charArray = dso_local global [5 x i8] zeroinitializer
@.str = private unnamed_addr constant [31 x i8] c"Function with parameters: a = \00", align 1
@.str.1 = private unnamed_addr constant [7 x i8] c", b = \00", align 1
@.str.2 = private unnamed_addr constant [11 x i8] c" arr[0] = \00", align 1
@.str.3 = private unnamed_addr constant [12 x i8] c", str[0] = \00", align 1
@.str.4 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.5 = private unnamed_addr constant [25 x i8] c"Sum in func_with_param: \00", align 1
@.str.6 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.7 = private unnamed_addr constant [10 x i8] c"22373141\0A\00", align 1
@.str.8 = private unnamed_addr constant [23 x i8] c"Negative intArray[0]: \00", align 1
@.str.9 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.10 = private unnamed_addr constant [23 x i8] c"Positive intArray[0]: \00", align 1
@.str.11 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.12 = private unnamed_addr constant [11 x i8] c"Quotient: \00", align 1
@.str.13 = private unnamed_addr constant [14 x i8] c", Remainder: \00", align 1
@.str.14 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.15 = private unnamed_addr constant [22 x i8] c"Sum of ASCII codes1: \00", align 1
@.str.16 = private unnamed_addr constant [2 x i8] c" \00", align 1
@.str.17 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.18 = private unnamed_addr constant [22 x i8] c"Sum of ASCII codes2: \00", align 1
@.str.19 = private unnamed_addr constant [2 x i8] c" \00", align 1
@.str.20 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.21 = private unnamed_addr constant [6 x i8] c"x1 = \00", align 1
@.str.22 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.23 = private unnamed_addr constant [6 x i8] c"a1 = \00", align 1
@.str.24 = private unnamed_addr constant [12 x i8] c", as char: \00", align 1
@.str.25 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.26 = private unnamed_addr constant [3 x i8] c"%c\00", align 1
@.str.1.27 = private unnamed_addr constant [3 x i8] c"%d\00", align 1
@.str.2.32 = private unnamed_addr constant [4 x i8] c"%d:\00", align 1
@.str.3.33 = private unnamed_addr constant [4 x i8] c" %d\00", align 1
@.str.4.34 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.5.37 = private unnamed_addr constant [3 x i8] c"%s\00", align 1

define dso_local i32 @func_with_param(i32 %0, i8 %1, ptr %2, ptr %3) {
  %5 = alloca i32, align 4
  store i32 %0, ptr %5, align 4
  %6 = alloca i8, align 1
  store i8 %1, ptr %6, align 1
  %7 = alloca ptr, align 8
  store ptr %2, ptr %7, align 8
  %8 = alloca ptr, align 8
  store ptr %3, ptr %8, align 8
  %9 = load i32, ptr %5, align 4
  %10 = load i8, ptr %6, align 1
  %11 = load ptr, ptr %7, align 8
  %12 = getelementptr inbounds i32, ptr %11, i32 0
  %13 = load i32, ptr %12, align 4
  %14 = load ptr, ptr %8, align 8
  %15 = getelementptr inbounds i8, ptr %14, i32 0
  %16 = load i8, ptr %15, align 1
  call void @putstr(ptr @.str)
  call void @putint(i32 %9)
  call void @putstr(ptr @.str.1)
  %17 = zext i8 %10 to i32
  call void @putch(i32 %17)
  call void @putstr(ptr @.str.2)
  call void @putint(i32 %13)
  call void @putstr(ptr @.str.3)
  %18 = zext i8 %16 to i32
  call void @putch(i32 %18)
  call void @putstr(ptr @.str.4)
  %19 = alloca i32, align 4
  %20 = load ptr, ptr %7, align 8
  %21 = getelementptr inbounds i32, ptr %20, i32 0
  %22 = load i32, ptr %21, align 4
  %23 = load ptr, ptr %8, align 8
  %24 = getelementptr inbounds i8, ptr %23, i32 0
  %25 = load i8, ptr %24, align 1
  %26 = load i32, ptr %5, align 4
  %27 = load i8, ptr %6, align 1
  %28 = zext i8 %27 to i32
  %29 = add nsw i32 %26, %28
  %30 = add nsw i32 %29, %22
  %31 = zext i8 %25 to i32
  %32 = add nsw i32 %30, %31
  store i32 %32, ptr %19, align 4
  %33 = load i32, ptr %19, align 4
  call void @putstr(ptr @.str.5)
  call void @putint(i32 %33)
  call void @putstr(ptr @.str.6)
  %34 = load i32, ptr %19, align 4
  ret i32 %34
}

define dso_local i32 @main() {
  call void @putstr(ptr @.str.7)
  %1 = getelementptr inbounds i32, ptr @intArray, i32 0
  %2 = getelementptr inbounds [3 x i32], ptr @constIntArray, i32 0, i32 0
  %3 = load i32, ptr %2, align 4
  store i32 %3, ptr %1, align 4
  %4 = getelementptr inbounds i32, ptr @intArray, i32 1
  %5 = getelementptr inbounds [3 x i32], ptr @constIntArray, i32 0, i32 1
  %6 = load i32, ptr %5, align 4
  store i32 %6, ptr %4, align 4
  %7 = getelementptr inbounds i32, ptr @intArray, i32 2
  %8 = getelementptr inbounds [3 x i32], ptr @constIntArray, i32 0, i32 2
  %9 = load i32, ptr %8, align 4
  store i32 %9, ptr %7, align 4
  %10 = getelementptr inbounds i32, ptr @intArray, i32 3
  %11 = getelementptr inbounds [5 x i32], ptr @intArray, i32 0, i32 0
  %12 = load i32, ptr %11, align 4
  %13 = getelementptr inbounds [5 x i32], ptr @intArray, i32 0, i32 1
  %14 = load i32, ptr %13, align 4
  %15 = add nsw i32 %12, %14
  store i32 %15, ptr %10, align 4
  %16 = getelementptr inbounds i32, ptr @intArray, i32 4
  %17 = getelementptr inbounds [5 x i32], ptr @intArray, i32 0, i32 3
  %18 = load i32, ptr %17, align 4
  %19 = getelementptr inbounds [5 x i32], ptr @intArray, i32 0, i32 2
  %20 = load i32, ptr %19, align 4
  %21 = add nsw i32 %18, %20
  store i32 %21, ptr %16, align 4
  %22 = getelementptr inbounds i32, ptr @intArray, i32 0
  %23 = getelementptr inbounds [5 x i32], ptr @intArray, i32 0, i32 0
  %24 = load i32, ptr %23, align 4
  %25 = sub nsw i32 0, %24
  store i32 %25, ptr %22, align 4
  %26 = getelementptr inbounds [5 x i32], ptr @intArray, i32 0, i32 0
  %27 = load i32, ptr %26, align 4
  call void @putstr(ptr @.str.8)
  call void @putint(i32 %27)
  call void @putstr(ptr @.str.9)
  %28 = getelementptr inbounds i32, ptr @intArray, i32 0
  %29 = getelementptr inbounds [5 x i32], ptr @intArray, i32 0, i32 0
  %30 = load i32, ptr %29, align 4
  %31 = add nsw i32 0, %30
  store i32 %31, ptr %28, align 4
  %32 = getelementptr inbounds [5 x i32], ptr @intArray, i32 0, i32 0
  %33 = load i32, ptr %32, align 4
  call void @putstr(ptr @.str.10)
  call void @putint(i32 %33)
  call void @putstr(ptr @.str.11)
  %34 = getelementptr inbounds i32, ptr @intArray, i32 1
  %35 = getelementptr inbounds [5 x i32], ptr @intArray, i32 0, i32 3
  %36 = load i32, ptr %35, align 4
  %37 = getelementptr inbounds [5 x i32], ptr @intArray, i32 0, i32 2
  %38 = load i32, ptr %37, align 4
  %39 = sdiv i32 %36, %38
  store i32 %39, ptr %34, align 4
  %40 = getelementptr inbounds i32, ptr @intArray, i32 2
  %41 = getelementptr inbounds [5 x i32], ptr @intArray, i32 0, i32 3
  %42 = load i32, ptr %41, align 4
  %43 = getelementptr inbounds [5 x i32], ptr @intArray, i32 0, i32 2
  %44 = load i32, ptr %43, align 4
  %45 = srem i32 %42, %44
  store i32 %45, ptr %40, align 4
  %46 = getelementptr inbounds [5 x i32], ptr @intArray, i32 0, i32 1
  %47 = load i32, ptr %46, align 4
  %48 = getelementptr inbounds [5 x i32], ptr @intArray, i32 0, i32 2
  %49 = load i32, ptr %48, align 4
  call void @putstr(ptr @.str.12)
  call void @putint(i32 %47)
  call void @putstr(ptr @.str.13)
  call void @putint(i32 %49)
  call void @putstr(ptr @.str.14)
  %50 = getelementptr inbounds i8, ptr @charArray, i32 0
  %51 = getelementptr inbounds [5 x i8], ptr @constCharArray, i32 0, i32 0
  %52 = load i8, ptr %51, align 1
  %53 = getelementptr inbounds [5 x i8], ptr @constCharArray, i32 0, i32 1
  %54 = load i8, ptr %53, align 1
  %55 = getelementptr inbounds [5 x i8], ptr @constCharArray, i32 0, i32 2
  %56 = load i8, ptr %55, align 1
  %57 = getelementptr inbounds [5 x i8], ptr @constCharArray, i32 0, i32 3
  %58 = load i8, ptr %57, align 1
  %59 = getelementptr inbounds [5 x i8], ptr @constCharArray, i32 0, i32 4
  %60 = load i8, ptr %59, align 1
  %61 = zext i8 %52 to i32
  %62 = zext i8 %54 to i32
  %63 = add nsw i32 %61, %62
  %64 = zext i8 %56 to i32
  %65 = add nsw i32 %63, %64
  %66 = zext i8 %58 to i32
  %67 = add nsw i32 %65, %66
  %68 = zext i8 %60 to i32
  %69 = add nsw i32 %67, %68
  %70 = trunc i32 %69 to i8
  store i8 %70, ptr %50, align 1
  %71 = getelementptr inbounds [5 x i8], ptr @charArray, i32 0, i32 0
  %72 = load i8, ptr %71, align 1
  %73 = getelementptr inbounds [5 x i8], ptr @charArray, i32 0, i32 0
  %74 = load i8, ptr %73, align 1
  call void @putstr(ptr @.str.15)
  %75 = zext i8 %72 to i32
  call void @putint(i32 %75)
  call void @putstr(ptr @.str.16)
  %76 = zext i8 %74 to i32
  call void @putch(i32 %76)
  call void @putstr(ptr @.str.17)
  %77 = alloca i32, align 4
  %78 = getelementptr inbounds [5 x i32], ptr @intArray, i32 0, i32 0
  %79 = load i32, ptr %78, align 4
  %80 = getelementptr inbounds [5 x i8], ptr @charArray, i32 0, i32 0
  %81 = load i8, ptr %80, align 1
  %82 = getelementptr inbounds [5 x i32], ptr @intArray, i32 0, i32 0
  %83 = getelementptr inbounds [5 x i8], ptr @charArray, i32 0, i32 0
  %84 = call i32 @func_with_param(i32 %79, i8 %81, ptr %82, ptr %83)
  store i32 %84, ptr %77, align 4
  %85 = alloca i32, align 4
  %86 = getelementptr inbounds [5 x i8], ptr @constCharArray2, i32 0, i32 0
  %87 = load i8, ptr %86, align 1
  %88 = getelementptr inbounds [5 x i8], ptr @constCharArray2, i32 0, i32 1
  %89 = load i8, ptr %88, align 1
  %90 = getelementptr inbounds [5 x i8], ptr @constCharArray2, i32 0, i32 2
  %91 = load i8, ptr %90, align 1
  %92 = getelementptr inbounds [5 x i8], ptr @constCharArray2, i32 0, i32 3
  %93 = load i8, ptr %92, align 1
  %94 = getelementptr inbounds [5 x i8], ptr @constCharArray2, i32 0, i32 4
  %95 = load i8, ptr %94, align 1
  %96 = zext i8 %87 to i32
  %97 = zext i8 %89 to i32
  %98 = add nsw i32 %96, %97
  %99 = zext i8 %91 to i32
  %100 = add nsw i32 %98, %99
  %101 = zext i8 %93 to i32
  %102 = add nsw i32 %100, %101
  %103 = zext i8 %95 to i32
  %104 = add nsw i32 %102, %103
  store i32 %104, ptr %85, align 4
  %105 = alloca i8, align 1
  %106 = getelementptr inbounds [5 x i8], ptr @constCharArray2, i32 0, i32 0
  %107 = load i8, ptr %106, align 1
  %108 = getelementptr inbounds [5 x i8], ptr @constCharArray2, i32 0, i32 1
  %109 = load i8, ptr %108, align 1
  %110 = getelementptr inbounds [5 x i8], ptr @constCharArray2, i32 0, i32 2
  %111 = load i8, ptr %110, align 1
  %112 = getelementptr inbounds [5 x i8], ptr @constCharArray2, i32 0, i32 3
  %113 = load i8, ptr %112, align 1
  %114 = getelementptr inbounds [5 x i8], ptr @constCharArray2, i32 0, i32 4
  %115 = load i8, ptr %114, align 1
  %116 = zext i8 %107 to i32
  %117 = zext i8 %109 to i32
  %118 = add nsw i32 %116, %117
  %119 = zext i8 %111 to i32
  %120 = add nsw i32 %118, %119
  %121 = zext i8 %113 to i32
  %122 = add nsw i32 %120, %121
  %123 = zext i8 %115 to i32
  %124 = add nsw i32 %122, %123
  %125 = trunc i32 %124 to i8
  store i8 %125, ptr %105, align 1
  %126 = load i32, ptr %85, align 4
  %127 = load i8, ptr %105, align 1
  call void @putstr(ptr @.str.18)
  call void @putint(i32 %126)
  call void @putstr(ptr @.str.19)
  %128 = zext i8 %127 to i32
  call void @putch(i32 %128)
  call void @putstr(ptr @.str.20)
  %129 = alloca i32, align 4
  store i32 107, ptr %129, align 4
  %130 = load i32, ptr %129, align 4
  call void @putstr(ptr @.str.21)
  call void @putint(i32 %130)
  call void @putstr(ptr @.str.22)
  %131 = alloca i8, align 1
  store i8 41, ptr %131, align 1
  %132 = load i8, ptr %131, align 1
  %133 = load i8, ptr %131, align 1
  call void @putstr(ptr @.str.23)
  %134 = zext i8 %132 to i32
  call void @putint(i32 %134)
  call void @putstr(ptr @.str.24)
  %135 = zext i8 %133 to i32
  call void @putch(i32 %135)
  call void @putstr(ptr @.str.25)
  ret i32 0
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define i32 @getchar() #0 {
  %1 = alloca i8, align 1
  %2 = call i32 (ptr, ...) @scanf(ptr noundef @.str.26, ptr noundef %1)
  %3 = load i8, ptr %1, align 1
  %4 = sext i8 %3 to i32
  ret i32 %4
}

declare i32 @scanf(ptr noundef, ...) #1

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define i32 @getint() #0 {
  %1 = alloca i32, align 4
  %2 = call i32 (ptr, ...) @scanf(ptr noundef @.str.1.27, ptr noundef %1)
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
  %5 = call i32 (ptr, ...) @scanf(ptr noundef @.str.1.27, ptr noundef %3)
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
  %15 = call i32 (ptr, ...) @scanf(ptr noundef @.str.1.27, ptr noundef %14)
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
  %4 = call i32 (ptr, ...) @printf(ptr noundef @.str.1.27, i32 noundef %3)
  ret void
}

declare i32 @printf(ptr noundef, ...) #1

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define void @putch(i32 noundef %0) #0 {
  %2 = alloca i32, align 4
  store i32 %0, ptr %2, align 4
  %3 = load i32, ptr %2, align 4
  %4 = call i32 (ptr, ...) @printf(ptr noundef @.str.26, i32 noundef %3)
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
  %7 = call i32 (ptr, ...) @printf(ptr noundef @.str.2.32, i32 noundef %6)
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
  %18 = call i32 (ptr, ...) @printf(ptr noundef @.str.3.33, i32 noundef %17)
  br label %19

19:                                               ; preds = %12
  %20 = load i32, ptr %5, align 4
  %21 = add nsw i32 %20, 1
  store i32 %21, ptr %5, align 4
  br label %8, !llvm.loop !9

22:                                               ; preds = %8
  %23 = call i32 (ptr, ...) @printf(ptr noundef @.str.4.34)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define void @putstr(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = call i32 (ptr, ...) @printf(ptr noundef @.str.5.37, ptr noundef %3)
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
