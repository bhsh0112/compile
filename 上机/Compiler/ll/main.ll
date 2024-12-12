; ModuleID = 'test.c'
source_filename = "test.c"
target datalayout = "e-m:o-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx13.3.0"

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store i32 0, ptr %1, align 4
  store i32 1, ptr %2, align 4
  store i32 1, ptr %3, align 4
  store i32 0, ptr %4, align 4
  br label %5

5:                                                ; preds = %10, %0
  %6 = load i32, ptr %4, align 4
  %7 = load i32, ptr %2, align 4
  %8 = icmp slt i32 %6, %7
  br i1 %8, label %9, label %13

9:                                                ; preds = %5
  br label %13

10:                                               ; No predecessors!
  %11 = load i32, ptr %4, align 4
  %12 = add nsw i32 %11, 1
  store i32 %12, ptr %4, align 4
  br label %5, !llvm.loop !6

13:                                               ; preds = %9, %5
  store i32 0, ptr %4, align 4
  br label %14

14:                                               ; preds = %15, %13
  br label %18

15:                                               ; No predecessors!
  %16 = load i32, ptr %4, align 4
  %17 = add nsw i32 %16, 1
  store i32 %17, ptr %4, align 4
  br label %14

18:                                               ; preds = %14
  store i32 0, ptr %4, align 4
  br label %19

19:                                               ; preds = %18
  %20 = load i32, ptr %4, align 4
  %21 = load i32, ptr %2, align 4
  %22 = icmp slt i32 %20, %21
  br i1 %22, label %23, label %24

23:                                               ; preds = %19
  br label %24

24:                                               ; preds = %23, %19
  br label %25

25:                                               ; preds = %26, %24
  br label %29

26:                                               ; No predecessors!
  %27 = load i32, ptr %4, align 4
  %28 = add nsw i32 %27, 1
  store i32 %28, ptr %4, align 4
  br label %25

29:                                               ; preds = %25
  br label %30

30:                                               ; preds = %29
  %31 = load i32, ptr %4, align 4
  %32 = load i32, ptr %2, align 4
  %33 = icmp slt i32 %31, %32
  br i1 %33, label %34, label %35

34:                                               ; preds = %30
  br label %35

35:                                               ; preds = %34, %30
  store i32 0, ptr %4, align 4
  br label %36

36:                                               ; preds = %35
  br label %37

37:                                               ; preds = %36
  br label %38

38:                                               ; preds = %37
  br label %39

39:                                               ; preds = %38
  %40 = load i32, ptr %2, align 4
  %41 = load i32, ptr %3, align 4
  %42 = icmp sge i32 %40, %41
  br i1 %42, label %43, label %44

43:                                               ; preds = %39
  br label %44

44:                                               ; preds = %43, %39
  %45 = load i32, ptr %2, align 4
  %46 = load i32, ptr %3, align 4
  %47 = icmp sle i32 %45, %46
  br i1 %47, label %48, label %49

48:                                               ; preds = %44
  br label %49

49:                                               ; preds = %48, %44
  %50 = load i32, ptr %2, align 4
  %51 = load i32, ptr %3, align 4
  %52 = icmp eq i32 %50, %51
  br i1 %52, label %53, label %54

53:                                               ; preds = %49
  br label %54

54:                                               ; preds = %53, %49
  %55 = load i32, ptr %2, align 4
  %56 = load i32, ptr %3, align 4
  %57 = icmp sgt i32 %55, %56
  br i1 %57, label %58, label %59

58:                                               ; preds = %54
  br label %59

59:                                               ; preds = %58, %54
  %60 = load i32, ptr %2, align 4
  %61 = load i32, ptr %3, align 4
  %62 = icmp slt i32 %60, %61
  br i1 %62, label %63, label %64

63:                                               ; preds = %59
  br label %64

64:                                               ; preds = %63, %59
  %65 = load i32, ptr %2, align 4
  %66 = load i32, ptr %3, align 4
  %67 = icmp ne i32 %65, %66
  br i1 %67, label %68, label %69

68:                                               ; preds = %64
  br label %69

69:                                               ; preds = %68, %64
  %70 = load i32, ptr %2, align 4
  %71 = icmp ne i32 %70, 0
  %72 = xor i1 %71, true
  %73 = zext i1 %72 to i32
  %74 = load i32, ptr %3, align 4
  %75 = icmp eq i32 %73, %74
  br i1 %75, label %85, label %76

76:                                               ; preds = %69
  %77 = load i32, ptr %3, align 4
  %78 = icmp sgt i32 %77, 0
  br i1 %78, label %79, label %86

79:                                               ; preds = %76
  %80 = load i32, ptr %2, align 4
  %81 = add nsw i32 %80, 1
  %82 = srem i32 %81, 2
  %83 = sdiv i32 %82, 2
  %84 = icmp ne i32 %83, 0
  br i1 %84, label %85, label %86

85:                                               ; preds = %79, %69
  br label %86

86:                                               ; preds = %85, %79, %76
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
