; ModuleID = 'llvm-link'
source_filename = "llvm-link"
target datalayout = "e-m:o-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx13.3.0"

@const_var1 = dso_local global i32 17
@const_var2 = dso_local global i32 3
@arr = dso_local global [3 x i32] [i32 1, i32 2, i32 3]
@const_var3 = dso_local global i8 99
@s = dso_local global [5 x i8] c"abcd\00"
@str = dso_local global [5 x i8] c"abcd\00"
@cot_var1 = dso_local global i32 20
@var1 = dso_local global i32 5
@var2 = dso_local global i32 2
@var3 = dso_local global i32 10
@var4 = dso_local global i8 7
@var5 = dso_local global i8 8
@.str = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.1 = private unnamed_addr constant [10 x i8] c"22371491\0A\00", align 1
@.str.2 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.3 = private unnamed_addr constant [6 x i8] c"pass\0A\00", align 1
@.str.4 = private unnamed_addr constant [8 x i8] c"failed\0A\00", align 1
@.str.5 = private unnamed_addr constant [3 x i8] c"%c\00", align 1
@.str.1.8 = private unnamed_addr constant [3 x i8] c"%d\00", align 1
@.str.2.11 = private unnamed_addr constant [4 x i8] c"%d:\00", align 1
@.str.3.12 = private unnamed_addr constant [4 x i8] c" %d\00", align 1
@.str.4.13 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.5.16 = private unnamed_addr constant [3 x i8] c"%s\00", align 1

define dso_local i32 @f3(ptr %0, ptr %1, i32 %2, i32 %3) {
  %5 = alloca ptr, align 8
  store ptr %0, ptr %5, align 8
  %6 = alloca ptr, align 8
  store ptr %1, ptr %6, align 8
  %7 = alloca i32, align 4
  store i32 %2, ptr %7, align 4
  %8 = alloca i32, align 4
  store i32 %3, ptr %8, align 4
  %9 = alloca i32, align 4
  store i32 0, ptr %9, align 4
  br label %10

10:                                               ; preds = %17, %4
  %11 = load i32, ptr %9, align 4
  %12 = icmp eq i32 %11, 0
  br i1 %12, label %13, label %20

13:                                               ; preds = %10
  %14 = load i32, ptr %7, align 4
  %15 = load i32, ptr %8, align 4
  %16 = add nsw i32 %14, %15
  store i32 %16, ptr %7, align 4
  br label %17

17:                                               ; preds = %13
  %18 = load i32, ptr %9, align 4
  %19 = add nsw i32 %18, 1
  store i32 %19, ptr %9, align 4
  br label %10

20:                                               ; preds = %10
  %21 = load i32, ptr %9, align 4
  %22 = load ptr, ptr %5, align 8
  %23 = getelementptr inbounds i32, ptr %22, i32 %21
  %24 = load i32, ptr %23, align 4
  %25 = load i32, ptr %9, align 4
  %26 = load ptr, ptr %6, align 8
  %27 = getelementptr inbounds i32, ptr %26, i32 %25
  %28 = load i32, ptr %27, align 4
  %29 = load i32, ptr %7, align 4
  %30 = add nsw i32 %28, %29
  %31 = mul nsw i32 %24, %30
  %32 = load i32, ptr %8, align 4
  %33 = sub nsw i32 %31, %32
  ret i32 %33
}

define dso_local i32 @f4(i32 %0, i32 %1) {
  %3 = alloca i32, align 4
  store i32 %0, ptr %3, align 4
  %4 = alloca i32, align 4
  store i32 %1, ptr %4, align 4
  %5 = load i32, ptr %3, align 4
  %6 = load i32, ptr %4, align 4
  %7 = add nsw i32 %5, %6
  ret i32 %7
}

define dso_local i8 @f5(i8 %0, i8 %1) {
  %3 = alloca i8, align 1
  store i8 %0, ptr %3, align 1
  %4 = alloca i8, align 1
  store i8 %1, ptr %4, align 1
  %5 = load i8, ptr %3, align 1
  %6 = load i8, ptr %4, align 1
  %7 = zext i8 %5 to i32
  %8 = zext i8 %6 to i32
  %9 = add nsw i32 %7, %8
  %10 = trunc i32 %9 to i8
  ret i8 %10
}

define dso_local i32 @f7(i32 %0) {
  %2 = alloca i32, align 4
  store i32 %0, ptr %2, align 4
  %3 = load i32, ptr %2, align 4
  ret i32 %3
}

define dso_local i8 @f8(i8 %0) {
  %2 = alloca i8, align 1
  store i8 %0, ptr %2, align 1
  %3 = load i8, ptr %2, align 1
  ret i8 %3
}

define dso_local i32 @f6() {
  ret i32 0
}

define dso_local void @f2(i32 %0) {
  %2 = alloca i32, align 4
  store i32 %0, ptr %2, align 4
  %3 = load i32, ptr %2, align 4
  call void @putint(i32 %3)
  call void @putstr(ptr @.str)
  ret void
}

define dso_local void @f9() {
  ret void
}

define dso_local i32 @main() {
  call void @putstr(ptr @.str.1)
  %1 = alloca i32, align 4
  store i32 0, ptr %1, align 4
  call void @f9()
  %2 = alloca i32, align 4
  store i32 1, ptr %2, align 4
  %3 = alloca [3 x i32], align 4
  %4 = alloca [3 x i32], align 4
  %5 = getelementptr inbounds [3 x i32], ptr %4, i32 0, i32 0
  store i32 1, ptr %5, align 4
  %6 = getelementptr inbounds i32, ptr %5, i32 1
  store i32 2, ptr %6, align 4
  %7 = getelementptr inbounds i32, ptr %6, i32 1
  store i32 3, ptr %7, align 4
  %8 = alloca [3 x i32], align 4
  %9 = getelementptr inbounds [3 x i32], ptr %8, i32 0, i32 0
  store i32 4, ptr %9, align 4
  %10 = getelementptr inbounds i32, ptr %9, i32 1
  store i32 5, ptr %10, align 4
  %11 = getelementptr inbounds i32, ptr %10, i32 1
  store i32 6, ptr %11, align 4
  %12 = alloca i32, align 4
  %13 = getelementptr inbounds [3 x i32], ptr %4, i32 0, i32 0
  %14 = getelementptr inbounds [3 x i32], ptr %8, i32 0, i32 0
  %15 = load i32, ptr %1, align 4
  %16 = load i32, ptr %2, align 4
  %17 = call i32 @f3(ptr %13, ptr %14, i32 %15, i32 %16)
  store i32 %17, ptr %12, align 4
  %18 = alloca i32, align 4
  store i32 1, ptr %18, align 4
  %19 = alloca i8, align 1
  store i8 99, ptr %19, align 1
  %20 = call i8 @f8(i8 99)
  store i8 %20, ptr %19, align 1
  %21 = load i32, ptr %1, align 4
  %22 = load i32, ptr %18, align 4
  %23 = add nsw i32 %21, %22
  %24 = load i32, ptr %18, align 4
  %25 = add nsw i32 %23, %24
  %26 = add nsw i32 %25, 10
  store i32 %26, ptr %1, align 4
  %27 = load i32, ptr %1, align 4
  %28 = sub nsw i32 0, %27
  store i32 %28, ptr %1, align 4
  %29 = load i32, ptr %1, align 4
  %30 = sub nsw i32 0, %29
  %31 = load i32, ptr %1, align 4
  %32 = load i32, ptr %1, align 4
  %33 = sdiv i32 %32, 2
  store i32 %33, ptr %1, align 4
  %34 = load i32, ptr %1, align 4
  %35 = srem i32 %34, 2
  store i32 %35, ptr %1, align 4
  %36 = load i32, ptr %1, align 4
  %37 = icmp ne i32 %36, 0
  br i1 %37, label %39, label %38

38:                                               ; preds = %0
  br label %39

39:                                               ; preds = %38, %0
  %40 = call i8 @f5(i8 103, i8 102)
  store i8 %40, ptr %19, align 1
  %41 = alloca i32, align 4
  %42 = load i32, ptr %1, align 4
  %43 = add nsw i32 %42, 1
  store i32 %43, ptr %41, align 4
  %44 = load i32, ptr %1, align 4
  store i32 %44, ptr %41, align 4
  %45 = call i32 @getchar()
  %46 = trunc i32 %45 to i8
  store i8 %46, ptr %19, align 1
  %47 = alloca i32, align 4
  store i32 4, ptr %47, align 4
  %48 = alloca i32, align 4
  store i32 1, ptr %48, align 4
  %49 = alloca i32, align 4
  %50 = call i32 @f7(i32 0)
  store i32 %50, ptr %49, align 4
  %51 = call i32 @getint()
  store i32 %51, ptr %48, align 4
  %52 = load i32, ptr %1, align 4
  %53 = load i32, ptr %47, align 4
  %54 = call i32 @f4(i32 %52, i32 %53)
  store i32 %54, ptr %48, align 4
  store i32 0, ptr %49, align 4
  br label %55

55:                                               ; preds = %82, %39
  %56 = load i32, ptr %49, align 4
  %57 = load i32, ptr %47, align 4
  %58 = icmp slt i32 %56, %57
  br i1 %58, label %59, label %85

59:                                               ; preds = %55
  %60 = load i32, ptr %1, align 4
  %61 = mul nsw i32 %60, -1
  %62 = load i32, ptr %47, align 4
  %63 = load i32, ptr %49, align 4
  %64 = add nsw i32 %63, 1
  %65 = sdiv i32 %62, %64
  %66 = srem i32 %65, 2
  %67 = add nsw i32 %61, %66
  %68 = load i32, ptr %18, align 4
  %69 = sdiv i32 %68, 3
  %70 = add nsw i32 %67, %69
  store i32 %70, ptr %48, align 4
  %71 = load i32, ptr %48, align 4
  call void @putint(i32 %71)
  call void @putstr(ptr @.str.2)
  %72 = load i32, ptr %48, align 4
  %73 = icmp sgt i32 %72, 0
  br i1 %73, label %74, label %75

74:                                               ; preds = %59
  call void @putstr(ptr @.str.3)
  br label %76

75:                                               ; preds = %59
  call void @putstr(ptr @.str.4)
  br label %76

76:                                               ; preds = %75, %74
  %77 = load i32, ptr %49, align 4
  %78 = icmp sge i32 %77, 0
  br i1 %78, label %79, label %80

79:                                               ; preds = %76
  br label %82

80:                                               ; preds = %76
  br label %85

81:                                               ; No predecessors!
  br label %82

82:                                               ; preds = %81, %79
  %83 = load i32, ptr %49, align 4
  %84 = add nsw i32 %83, 1
  store i32 %84, ptr %49, align 4
  br label %55

85:                                               ; preds = %80, %55
  store i32 0, ptr %49, align 4
  br label %86

86:                                               ; preds = %91, %85
  %87 = load i32, ptr %49, align 4
  %88 = load i32, ptr %47, align 4
  %89 = icmp slt i32 %87, %88
  br i1 %89, label %90, label %94

90:                                               ; preds = %86
  br label %94

91:                                               ; No predecessors!
  %92 = load i32, ptr %49, align 4
  %93 = add nsw i32 %92, 1
  store i32 %93, ptr %49, align 4
  br label %86

94:                                               ; preds = %90, %86
  store i32 0, ptr %49, align 4
  br label %95

95:                                               ; preds = %96, %94
  br label %99

96:                                               ; No predecessors!
  %97 = load i32, ptr %49, align 4
  %98 = add nsw i32 %97, 1
  store i32 %98, ptr %49, align 4
  br label %95

99:                                               ; preds = %95
  br label %100

100:                                              ; preds = %99
  br label %101

101:                                              ; preds = %100
  br label %102

102:                                              ; preds = %103, %101
  br label %106

103:                                              ; No predecessors!
  %104 = load i32, ptr %49, align 4
  %105 = add nsw i32 %104, 1
  store i32 %105, ptr %49, align 4
  br label %102

106:                                              ; preds = %102
  br label %107

107:                                              ; preds = %106
  %108 = load i32, ptr %49, align 4
  %109 = load i32, ptr %47, align 4
  %110 = icmp slt i32 %108, %109
  br i1 %110, label %111, label %112

111:                                              ; preds = %107
  br label %112

112:                                              ; preds = %111, %107
  store i32 0, ptr %49, align 4
  br label %113

113:                                              ; preds = %112
  br label %114

114:                                              ; preds = %113
  br label %115

115:                                              ; preds = %114
  br label %116

116:                                              ; preds = %115
  br label %117

117:                                              ; preds = %116
  br label %119

118:                                              ; No predecessors!
  br label %119

119:                                              ; preds = %118, %117
  %120 = load i32, ptr %47, align 4
  %121 = load i32, ptr %1, align 4
  %122 = icmp sge i32 %120, %121
  br i1 %122, label %123, label %124

123:                                              ; preds = %119
  br label %124

124:                                              ; preds = %123, %119
  %125 = load i32, ptr %47, align 4
  %126 = load i32, ptr %1, align 4
  %127 = icmp sle i32 %125, %126
  br i1 %127, label %128, label %129

128:                                              ; preds = %124
  br label %129

129:                                              ; preds = %128, %124
  %130 = load i32, ptr %47, align 4
  %131 = load i32, ptr %1, align 4
  %132 = icmp eq i32 %130, %131
  br i1 %132, label %133, label %134

133:                                              ; preds = %129
  br label %134

134:                                              ; preds = %133, %129
  %135 = load i32, ptr %47, align 4
  %136 = load i32, ptr %1, align 4
  %137 = icmp sgt i32 %135, %136
  br i1 %137, label %138, label %139

138:                                              ; preds = %134
  br label %139

139:                                              ; preds = %138, %134
  %140 = load i32, ptr %47, align 4
  %141 = load i32, ptr %1, align 4
  %142 = icmp slt i32 %140, %141
  br i1 %142, label %143, label %144

143:                                              ; preds = %139
  br label %144

144:                                              ; preds = %143, %139
  %145 = load i32, ptr %47, align 4
  %146 = load i32, ptr %1, align 4
  %147 = icmp ne i32 %145, %146
  br i1 %147, label %148, label %149

148:                                              ; preds = %144
  br label %149

149:                                              ; preds = %148, %144
  %150 = call i32 @f6()
  br label %151

151:                                              ; preds = %149
  call void @f2(i32 1)
  br label %152

152:                                              ; preds = %151
  br label %158

153:                                              ; No predecessors!
  %154 = load i32, ptr %47, align 4
  %155 = load i32, ptr %1, align 4
  %156 = icmp ne i32 %154, %155
  br i1 %156, label %157, label %158

157:                                              ; preds = %153
  br label %158

158:                                              ; preds = %157, %153, %152
  br label %162

159:                                              ; No predecessors!
  %160 = load i32, ptr %1, align 4
  %161 = icmp sgt i32 %160, 0
  br i1 %161, label %162, label %163

162:                                              ; preds = %159, %158
  br label %163

163:                                              ; preds = %162, %159
  %164 = load i32, ptr %47, align 4
  %165 = load i32, ptr %1, align 4
  %166 = icmp eq i32 %164, %165
  br i1 %166, label %178, label %167

167:                                              ; preds = %163
  %168 = load i32, ptr %1, align 4
  %169 = icmp sgt i32 %168, 0
  br i1 %169, label %170, label %179

170:                                              ; preds = %167
  %171 = icmp eq i32 1, 1
  br i1 %171, label %172, label %179

172:                                              ; preds = %170
  %173 = load i32, ptr %47, align 4
  %174 = add nsw i32 %173, 1
  %175 = srem i32 %174, 2
  %176 = sdiv i32 %175, 2
  %177 = icmp ne i32 %176, 0
  br i1 %177, label %178, label %179

178:                                              ; preds = %172, %163
  br label %179

179:                                              ; preds = %178, %172, %170, %167
  ret i32 0
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define i32 @getchar() #0 {
  %1 = alloca i8, align 1
  %2 = call i32 (ptr, ...) @scanf(ptr noundef @.str.5, ptr noundef %1)
  %3 = load i8, ptr %1, align 1
  %4 = sext i8 %3 to i32
  ret i32 %4
}

declare i32 @scanf(ptr noundef, ...) #1

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define i32 @getint() #0 {
  %1 = alloca i32, align 4
  %2 = call i32 (ptr, ...) @scanf(ptr noundef @.str.1.8, ptr noundef %1)
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
  %5 = call i32 (ptr, ...) @scanf(ptr noundef @.str.1.8, ptr noundef %3)
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
  %15 = call i32 (ptr, ...) @scanf(ptr noundef @.str.1.8, ptr noundef %14)
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
  %4 = call i32 (ptr, ...) @printf(ptr noundef @.str.1.8, i32 noundef %3)
  ret void
}

declare i32 @printf(ptr noundef, ...) #1

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define void @putch(i32 noundef %0) #0 {
  %2 = alloca i32, align 4
  store i32 %0, ptr %2, align 4
  %3 = load i32, ptr %2, align 4
  %4 = call i32 (ptr, ...) @printf(ptr noundef @.str.5, i32 noundef %3)
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
  %7 = call i32 (ptr, ...) @printf(ptr noundef @.str.2.11, i32 noundef %6)
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
  %18 = call i32 (ptr, ...) @printf(ptr noundef @.str.3.12, i32 noundef %17)
  br label %19

19:                                               ; preds = %12
  %20 = load i32, ptr %5, align 4
  %21 = add nsw i32 %20, 1
  store i32 %21, ptr %5, align 4
  br label %8, !llvm.loop !9

22:                                               ; preds = %8
  %23 = call i32 (ptr, ...) @printf(ptr noundef @.str.4.13)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define void @putstr(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = call i32 (ptr, ...) @printf(ptr noundef @.str.5.16, ptr noundef %3)
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
