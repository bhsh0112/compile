; ModuleID = 'llvm-link'
source_filename = "llvm-link"
target datalayout = "e-m:o-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx13.3.0"

@a = dso_local global i32 10
@ty = dso_local global i32 90
@b = dso_local global [3 x i32] [i32 1, i32 2, i32 3]
@x = dso_local global i32 5
@z = dso_local global i32 114514
@y = dso_local global [3 x i32] zeroinitializer
@global_var = dso_local global i32 0
@buaa = dso_local global i8 92
@aa = dso_local global [5 x i8] c"abc\\0"
@aaa = dso_local global [6 x i8] c"xyz\00\00\00"
@.str = private unnamed_addr constant [10 x i8] c"21374067\0A\00", align 1
@.str.1 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.2 = private unnamed_addr constant [4 x i8] c"i: \00", align 1
@.str.3 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.4 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.5 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.6 = private unnamed_addr constant [3 x i8] c"%c\00", align 1
@.str.1.9 = private unnamed_addr constant [3 x i8] c"%d\00", align 1
@.str.2.14 = private unnamed_addr constant [4 x i8] c"%d:\00", align 1
@.str.3.15 = private unnamed_addr constant [4 x i8] c" %d\00", align 1
@.str.4.16 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.5.19 = private unnamed_addr constant [3 x i8] c"%s\00", align 1

define dso_local i32 @g(ptr %0) {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = getelementptr inbounds i32, ptr %3, i32 0
  %5 = load i32, ptr %4, align 4
  %6 = load ptr, ptr %2, align 8
  %7 = getelementptr inbounds i32, ptr %6, i32 1
  %8 = load i32, ptr %7, align 4
  %9 = load ptr, ptr %2, align 8
  %10 = getelementptr inbounds i32, ptr %9, i32 0
  %11 = load i32, ptr %10, align 4
  %12 = sub nsw i32 0, %11
  %13 = add nsw i32 %8, %12
  %14 = load ptr, ptr %2, align 8
  %15 = getelementptr inbounds i32, ptr %14, i32 %13
  %16 = load i32, ptr %15, align 4
  %17 = add nsw i32 %5, %16
  ret i32 %17
}

define dso_local i8 @foo(i32 %0, i32 %1) {
  %3 = alloca i32, align 4
  store i32 %0, ptr %3, align 4
  %4 = alloca i32, align 4
  store i32 %1, ptr %4, align 4
  ret i8 111
}

define dso_local void @fooo(i32 %0, i32 %1) {
  %3 = alloca i32, align 4
  store i32 %0, ptr %3, align 4
  %4 = alloca i32, align 4
  store i32 %1, ptr %4, align 4
  ret void
}

define dso_local i32 @func() {
  %1 = load i32, ptr @global_var, align 4
  %2 = add nsw i32 %1, 1
  store i32 %2, ptr @global_var, align 4
  ret i32 1
}

define dso_local i32 @main() {
  call void @putstr(ptr @.str)
  %1 = alloca i32, align 4
  store i32 0, ptr %1, align 4
  %2 = alloca i8, align 1
  store i8 97, ptr %2, align 1
  %3 = alloca i8, align 1
  store i8 98, ptr %3, align 1
  %4 = alloca i32, align 4
  store i32 -10, ptr %4, align 4
  %5 = alloca i32, align 4
  %6 = load i32, ptr %4, align 4
  %7 = add nsw i32 %6, 5
  %8 = mul nsw i32 %7, 2
  %9 = sdiv i32 %8, 1
  %10 = add nsw i32 %9, 0
  store i32 %10, ptr %5, align 4
  %11 = load i32, ptr %4, align 4
  %12 = icmp slt i32 %11, 20
  br i1 %12, label %16, label %13

13:                                               ; preds = %0
  %14 = call i32 @func()
  %15 = icmp ne i32 %14, 0
  br i1 %15, label %19, label %16

16:                                               ; preds = %13, %0
  %17 = load i32, ptr %4, align 4
  %18 = sub nsw i32 %17, 1
  store i32 %18, ptr %4, align 4
  br label %31

19:                                               ; preds = %13
  %20 = load i32, ptr %4, align 4
  %21 = icmp sgt i32 %20, 0
  br i1 %21, label %22, label %30

22:                                               ; preds = %19
  %23 = call i32 @func()
  %24 = icmp ne i32 %23, 0
  br i1 %24, label %25, label %30

25:                                               ; preds = %22
  %26 = load i32, ptr %4, align 4
  %27 = add nsw i32 %26, 1
  store i32 %27, ptr %4, align 4
  %28 = load i32, ptr %4, align 4
  %29 = add nsw i32 %28, 1
  br label %30

30:                                               ; preds = %25, %22, %19
  br label %31

31:                                               ; preds = %30, %16
  %32 = load i32, ptr %4, align 4
  call void @putint(i32 %32)
  call void @putstr(ptr @.str.1)
  store i32 0, ptr %1, align 4
  br label %33

33:                                               ; preds = %38, %31
  %34 = load i32, ptr %1, align 4
  %35 = icmp slt i32 %34, 6
  br i1 %35, label %36, label %41

36:                                               ; preds = %33
  %37 = load i32, ptr %1, align 4
  call void @putstr(ptr @.str.2)
  call void @putint(i32 %37)
  call void @putstr(ptr @.str.3)
  br label %38

38:                                               ; preds = %36
  %39 = load i32, ptr %1, align 4
  %40 = add nsw i32 %39, 1
  store i32 %40, ptr %1, align 4
  br label %33

41:                                               ; preds = %33
  %42 = alloca [3 x i32], align 4
  %43 = getelementptr inbounds [3 x i32], ptr %42, i32 0, i32 0
  store i32 1, ptr %43, align 4
  %44 = getelementptr inbounds i32, ptr %43, i32 1
  store i32 2, ptr %44, align 4
  %45 = getelementptr inbounds i32, ptr %44, i32 1
  store i32 3, ptr %45, align 4
  %46 = alloca i32, align 4
  %47 = call i32 @func()
  store i32 %47, ptr %46, align 4
  %48 = alloca i32, align 4
  %49 = call i32 @getint()
  store i32 %49, ptr %48, align 4
  %50 = getelementptr inbounds [3 x i32], ptr %42, i32 0, i32 0
  %51 = call i32 @g(ptr %50)
  store i32 %51, ptr %1, align 4
  %52 = call i32 @getchar()
  %53 = trunc i32 %52 to i8
  store i8 %53, ptr %2, align 1
  store i8 97, ptr %2, align 1
  br label %54

54:                                               ; preds = %71, %41
  %55 = load i8, ptr %2, align 1
  %56 = zext i8 %55 to i32
  %57 = icmp slt i32 %56, 127
  br i1 %57, label %61, label %58

58:                                               ; preds = %54
  %59 = load i32, ptr %1, align 4
  %60 = icmp ne i32 %59, 0
  br i1 %60, label %61, label %76

61:                                               ; preds = %58, %54
  %62 = load i8, ptr %2, align 1
  %63 = zext i8 %62 to i32
  %64 = add nsw i32 %63, 1
  %65 = trunc i32 %64 to i8
  store i8 %65, ptr %2, align 1
  %66 = load i8, ptr %2, align 1
  %67 = zext i8 %66 to i32
  %68 = icmp eq i32 %67, 120
  br i1 %68, label %69, label %70

69:                                               ; preds = %61
  br label %76

70:                                               ; preds = %61
  br label %71

71:                                               ; preds = %70
  %72 = load i8, ptr %2, align 1
  %73 = zext i8 %72 to i32
  %74 = add nsw i32 %73, 1
  %75 = trunc i32 %74 to i8
  store i8 %75, ptr %2, align 1
  br label %54

76:                                               ; preds = %69, %58
  store i8 97, ptr %2, align 1
  br label %77

77:                                               ; preds = %87, %76
  %78 = load i8, ptr %2, align 1
  %79 = zext i8 %78 to i32
  %80 = add nsw i32 %79, 1
  %81 = trunc i32 %80 to i8
  store i8 %81, ptr %2, align 1
  %82 = load i8, ptr %2, align 1
  %83 = zext i8 %82 to i32
  %84 = icmp eq i32 %83, 120
  br i1 %84, label %85, label %86

85:                                               ; preds = %77
  br label %92

86:                                               ; preds = %77
  br label %87

87:                                               ; preds = %86
  %88 = load i8, ptr %2, align 1
  %89 = zext i8 %88 to i32
  %90 = add nsw i32 %89, 1
  %91 = trunc i32 %90 to i8
  store i8 %91, ptr %2, align 1
  br label %77

92:                                               ; preds = %85
  %93 = load i8, ptr %2, align 1
  %94 = zext i8 %93 to i32
  call void @putch(i32 %94)
  call void @putstr(ptr @.str.4)
  %95 = load i8, ptr %2, align 1
  %96 = zext i8 %95 to i32
  call void @putint(i32 %96)
  call void @putstr(ptr @.str.5)
  %97 = load i8, ptr %2, align 1
  %98 = zext i8 %97 to i32
  %99 = icmp sgt i32 %98, 0
  br i1 %99, label %100, label %174

100:                                              ; preds = %92
  %101 = load i8, ptr %2, align 1
  %102 = zext i8 %101 to i32
  %103 = icmp slt i32 %102, 0
  br i1 %103, label %104, label %174

104:                                              ; preds = %100
  %105 = load i8, ptr %2, align 1
  %106 = zext i8 %105 to i32
  %107 = icmp sle i32 %106, 0
  br i1 %107, label %108, label %174

108:                                              ; preds = %104
  %109 = load i8, ptr %2, align 1
  %110 = zext i8 %109 to i32
  %111 = icmp sge i32 %110, 0
  br i1 %111, label %112, label %174

112:                                              ; preds = %108
  %113 = load i8, ptr %2, align 1
  %114 = zext i8 %113 to i32
  %115 = icmp ne i32 %114, 0
  br i1 %115, label %116, label %174

116:                                              ; preds = %112
  %117 = load i8, ptr %2, align 1
  %118 = zext i8 %117 to i32
  %119 = icmp eq i32 %118, 0
  br i1 %119, label %120, label %174

120:                                              ; preds = %116
  br label %121

121:                                              ; preds = %134, %120
  %122 = load i8, ptr %2, align 1
  %123 = icmp ne i8 %122, 0
  br i1 %123, label %139, label %124

124:                                              ; preds = %121
  %125 = load i8, ptr %2, align 1
  %126 = zext i8 %125 to i32
  %127 = add nsw i32 %126, 1
  %128 = trunc i32 %127 to i8
  store i8 %128, ptr %2, align 1
  %129 = load i8, ptr %2, align 1
  %130 = zext i8 %129 to i32
  %131 = icmp eq i32 %130, 120
  br i1 %131, label %132, label %133

132:                                              ; preds = %124
  br label %139

133:                                              ; preds = %124
  br label %134

134:                                              ; preds = %133
  %135 = load i8, ptr %2, align 1
  %136 = zext i8 %135 to i32
  %137 = add nsw i32 %136, 1
  %138 = trunc i32 %137 to i8
  store i8 %138, ptr %2, align 1
  br label %121

139:                                              ; preds = %132, %121
  br label %140

140:                                              ; preds = %140, %139
  store i8 97, ptr %2, align 1
  br label %140

141:                                              ; No predecessors!
  %142 = load i8, ptr %2, align 1
  store i8 %142, ptr %2, align 1
  br label %143

143:                                              ; preds = %143, %141
  store i8 98, ptr %2, align 1
  br label %143

144:                                              ; No predecessors!
  br label %145

145:                                              ; preds = %146, %144
  store i8 99, ptr %2, align 1
  br label %146

146:                                              ; preds = %145
  %147 = load i8, ptr %2, align 1
  store i8 %147, ptr %2, align 1
  br label %145

148:                                              ; No predecessors!
  br label %149

149:                                              ; preds = %155, %148
  %150 = load i8, ptr %2, align 1
  %151 = load i8, ptr %2, align 1
  %152 = zext i8 %150 to i32
  %153 = zext i8 %151 to i32
  %154 = icmp ne i32 %152, %153
  br i1 %154, label %155, label %156

155:                                              ; preds = %149
  store i8 100, ptr %2, align 1
  br label %149

156:                                              ; preds = %149
  br label %157

157:                                              ; preds = %157, %156
  store i8 101, ptr %2, align 1
  br label %157

158:                                              ; No predecessors!
  %159 = load i8, ptr %2, align 1
  store i8 %159, ptr %2, align 1
  br label %160

160:                                              ; preds = %161, %158
  store i8 102, ptr %2, align 1
  br label %161

161:                                              ; preds = %160
  %162 = load i8, ptr %2, align 1
  store i8 %162, ptr %2, align 1
  br label %160

163:                                              ; No predecessors!
  br label %164

164:                                              ; preds = %171, %163
  %165 = load i8, ptr %2, align 1
  %166 = load i8, ptr %2, align 1
  %167 = zext i8 %165 to i32
  %168 = zext i8 %166 to i32
  %169 = icmp ne i32 %167, %168
  br i1 %169, label %170, label %173

170:                                              ; preds = %164
  store i8 103, ptr %2, align 1
  br label %171

171:                                              ; preds = %170
  %172 = load i8, ptr %2, align 1
  store i8 %172, ptr %2, align 1
  br label %164

173:                                              ; preds = %164
  br label %174

174:                                              ; preds = %173, %116, %112, %108, %104, %100, %92
  ret i32 0
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define i32 @getchar() #0 {
  %1 = alloca i8, align 1
  %2 = call i32 (ptr, ...) @scanf(ptr noundef @.str.6, ptr noundef %1)
  %3 = load i8, ptr %1, align 1
  %4 = sext i8 %3 to i32
  ret i32 %4
}

declare i32 @scanf(ptr noundef, ...) #1

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define i32 @getint() #0 {
  %1 = alloca i32, align 4
  %2 = call i32 (ptr, ...) @scanf(ptr noundef @.str.1.9, ptr noundef %1)
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
  %5 = call i32 (ptr, ...) @scanf(ptr noundef @.str.1.9, ptr noundef %3)
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
  %15 = call i32 (ptr, ...) @scanf(ptr noundef @.str.1.9, ptr noundef %14)
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
  %4 = call i32 (ptr, ...) @printf(ptr noundef @.str.1.9, i32 noundef %3)
  ret void
}

declare i32 @printf(ptr noundef, ...) #1

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define void @putch(i32 noundef %0) #0 {
  %2 = alloca i32, align 4
  store i32 %0, ptr %2, align 4
  %3 = load i32, ptr %2, align 4
  %4 = call i32 (ptr, ...) @printf(ptr noundef @.str.6, i32 noundef %3)
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
