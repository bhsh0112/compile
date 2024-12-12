; ModuleID = 'test.c'
source_filename = "test.c"
target datalayout = "e-m:o-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx13.3.0"

@fibonacci = global [15 x i32] zeroinitializer, align 4

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define void @cal_fibonacci() #0 {
  %1 = alloca i32, align 4
  store i32 1, ptr getelementptr inbounds ([15 x i32], ptr @fibonacci, i64 0, i64 1), align 4
  store i32 2, ptr %1, align 4
  br label %2

2:                                                ; preds = %20, %0
  %3 = load i32, ptr %1, align 4
  %4 = icmp slt i32 %3, 15
  br i1 %4, label %5, label %23

5:                                                ; preds = %2
  %6 = load i32, ptr %1, align 4
  %7 = sub nsw i32 %6, 1
  %8 = sext i32 %7 to i64
  %9 = getelementptr inbounds [15 x i32], ptr @fibonacci, i64 0, i64 %8
  %10 = load i32, ptr %9, align 4
  %11 = load i32, ptr %1, align 4
  %12 = sub nsw i32 %11, 2
  %13 = sext i32 %12 to i64
  %14 = getelementptr inbounds [15 x i32], ptr @fibonacci, i64 0, i64 %13
  %15 = load i32, ptr %14, align 4
  %16 = add nsw i32 %10, %15
  %17 = load i32, ptr %1, align 4
  %18 = sext i32 %17 to i64
  %19 = getelementptr inbounds [15 x i32], ptr @fibonacci, i64 0, i64 %18
  store i32 %16, ptr %19, align 4
  br label %20

20:                                               ; preds = %5
  %21 = load i32, ptr %1, align 4
  %22 = add nsw i32 %21, 1
  store i32 %22, ptr %1, align 4
  br label %2, !llvm.loop !6

23:                                               ; preds = %2
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define i32 @main() #0 {
  %1 = alloca i32, align 4
  store i32 0, ptr %1, align 4
  ret i32 0
}

attributes #0 = { noinline nounwind optnone ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a,+zcm,+zcz" }

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
