; ModuleID = 'llvm-link'
source_filename = "llvm-link"
target datalayout = "e-m:o-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx13.3.0"

@ig1 = dso_local global i32 0
@.str = private unnamed_addr constant [10 x i8] c"22371144\0A\00", align 1
@.str.1 = private unnamed_addr constant [2 x i8] c" \00", align 1
@.str.2 = private unnamed_addr constant [2 x i8] c" \00", align 1
@.str.3 = private unnamed_addr constant [2 x i8] c" \00", align 1
@.str.4 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.5 = private unnamed_addr constant [2 x i8] c" \00", align 1
@.str.6 = private unnamed_addr constant [2 x i8] c" \00", align 1
@.str.7 = private unnamed_addr constant [2 x i8] c" \00", align 1
@.str.8 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.9 = private unnamed_addr constant [2 x i8] c" \00", align 1
@.str.10 = private unnamed_addr constant [2 x i8] c" \00", align 1
@.str.11 = private unnamed_addr constant [2 x i8] c" \00", align 1
@.str.12 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.13 = private unnamed_addr constant [3 x i8] c"%c\00", align 1
@.str.1.16 = private unnamed_addr constant [3 x i8] c"%d\00", align 1
@.str.2.19 = private unnamed_addr constant [4 x i8] c"%d:\00", align 1
@.str.3.20 = private unnamed_addr constant [4 x i8] c" %d\00", align 1
@.str.4.21 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.5.24 = private unnamed_addr constant [3 x i8] c"%s\00", align 1

define dso_local i32 @fuc1() {
  ret i32 1
}

define dso_local i8 @fuc2() {
  ret i8 97
}

define dso_local void @fuc3() {
  ret void
}

define dso_local i32 @fuc4(i32 %0) {
  %2 = alloca i32, align 4
  store i32 %0, ptr %2, align 4
  ret i32 1
}

define dso_local i32 @fuc5(i32 %0, i32 %1) {
  %3 = alloca i32, align 4
  store i32 %0, ptr %3, align 4
  %4 = alloca i32, align 4
  store i32 %1, ptr %4, align 4
  ret i32 1
}

define dso_local i32 @fuc6(i32 %0, ptr %1) {
  %3 = alloca i32, align 4
  store i32 %0, ptr %3, align 4
  %4 = alloca ptr, align 8
  store ptr %1, ptr %4, align 8
  ret i32 1
}

define dso_local i32 @main() {
  %1 = alloca i32, align 4
  store i32 1, ptr %1, align 4
  %2 = alloca i32, align 4
  store i32 1, ptr %2, align 4
  %3 = alloca i32, align 4
  store i32 1, ptr %3, align 4
  %4 = alloca [5 x i32], align 4
  %5 = getelementptr inbounds [5 x i32], ptr %4, i32 0, i32 0
  store i32 1, ptr %5, align 4
  %6 = getelementptr inbounds i32, ptr %5, i32 1
  store i32 2, ptr %6, align 4
  %7 = getelementptr inbounds i32, ptr %6, i32 1
  store i32 3, ptr %7, align 4
  %8 = getelementptr inbounds i32, ptr %7, i32 1
  store i32 4, ptr %8, align 4
  %9 = getelementptr inbounds i32, ptr %8, i32 1
  store i32 5, ptr %9, align 4
  %10 = alloca [3 x i32], align 4
  %11 = getelementptr inbounds [3 x i32], ptr %10, i32 0, i32 0
  store i32 1, ptr %11, align 4
  %12 = getelementptr inbounds i32, ptr %11, i32 1
  store i32 2, ptr %12, align 4
  %13 = getelementptr inbounds i32, ptr %12, i32 1
  store i32 3, ptr %13, align 4
  %14 = alloca i32, align 4
  store i32 2, ptr %14, align 4
  %15 = alloca i8, align 1
  store i8 97, ptr %15, align 1
  %16 = alloca i8, align 1
  store i8 97, ptr %16, align 1
  %17 = alloca i8, align 1
  store i8 98, ptr %17, align 1
  %18 = alloca [5 x i8], align 1
  %19 = getelementptr inbounds [5 x i8], ptr %18, i32 0, i32 1
  store i8 97, ptr %19, align 1
  %20 = getelementptr inbounds [5 x i8], ptr %19, i32 0, i32 2
  store i8 98, ptr %20, align 1
  %21 = getelementptr inbounds [5 x i8], ptr %20, i32 0, i32 3
  store i8 99, ptr %21, align 1
  %22 = getelementptr inbounds [5 x i8], ptr %21, i32 0, i32 4
  store i8 100, ptr %22, align 1
  %23 = alloca [5 x i8], align 1
  %24 = getelementptr inbounds [5 x i8], ptr %23, i32 0, i32 1
  store i8 97, ptr %24, align 1
  %25 = getelementptr inbounds [5 x i8], ptr %24, i32 0, i32 2
  store i8 98, ptr %25, align 1
  %26 = getelementptr inbounds [5 x i8], ptr %25, i32 0, i32 3
  store i8 99, ptr %26, align 1
  %27 = getelementptr inbounds [5 x i8], ptr %26, i32 0, i32 4
  store i8 100, ptr %27, align 1
  %28 = alloca i8, align 1
  store i8 97, ptr %28, align 1
  %29 = alloca i32, align 4
  %30 = alloca i32, align 4
  %31 = alloca i32, align 4
  %32 = alloca [5 x i32], align 4
  %33 = alloca i32, align 4
  store i32 1, ptr %33, align 4
  %34 = alloca [5 x i32], align 4
  %35 = getelementptr inbounds [5 x i32], ptr %34, i32 0, i32 0
  store i32 1, ptr %35, align 4
  %36 = getelementptr inbounds i32, ptr %35, i32 1
  store i32 2, ptr %36, align 4
  %37 = getelementptr inbounds i32, ptr %36, i32 1
  store i32 3, ptr %37, align 4
  %38 = getelementptr inbounds i32, ptr %37, i32 1
  store i32 4, ptr %38, align 4
  %39 = getelementptr inbounds i32, ptr %38, i32 1
  store i32 5, ptr %39, align 4
  %40 = alloca i8, align 1
  %41 = alloca i8, align 1
  store i8 97, ptr %41, align 1
  %42 = alloca i8, align 1
  %43 = alloca i8, align 1
  store i8 97, ptr %43, align 1
  %44 = alloca [5 x i8], align 1
  %45 = alloca [5 x i8], align 1
  %46 = getelementptr inbounds [5 x i8], ptr %45, i32 0, i32 0
  store i8 97, ptr %46, align 1
  %47 = getelementptr inbounds [5 x i8], ptr %46, i32 0, i32 1
  store i8 98, ptr %47, align 1
  %48 = getelementptr inbounds [5 x i8], ptr %47, i32 0, i32 2
  store i8 99, ptr %48, align 1
  %49 = getelementptr inbounds [5 x i8], ptr %48, i32 0, i32 3
  store i8 100, ptr %49, align 1
  call void @putstr(ptr @.str)
  %50 = alloca i32, align 4
  store i32 0, ptr %50, align 4
  %51 = alloca i8, align 1
  store i8 0, ptr %51, align 1
  %52 = call i32 @getint()
  store i32 %52, ptr %50, align 4
  %53 = call i32 @getchar()
  %54 = trunc i32 %53 to i8
  store i8 %54, ptr %51, align 1
  %55 = alloca i32, align 4
  store i32 6, ptr %55, align 4
  %56 = alloca i32, align 4
  store i32 4, ptr %56, align 4
  %57 = alloca i32, align 4
  store i32 4, ptr %57, align 4
  %58 = alloca i32, align 4
  store i32 9, ptr %58, align 4
  %59 = load i32, ptr %55, align 4
  %60 = load i32, ptr %56, align 4
  %61 = load i32, ptr %57, align 4
  %62 = load i32, ptr %58, align 4
  call void @putint(i32 %59)
  call void @putstr(ptr @.str.1)
  call void @putint(i32 %60)
  call void @putstr(ptr @.str.2)
  call void @putint(i32 %61)
  call void @putstr(ptr @.str.3)
  call void @putint(i32 %62)
  call void @putstr(ptr @.str.4)
  %63 = alloca i32, align 4
  store i32 1, ptr %63, align 4
  %64 = alloca i32, align 4
  store i32 1, ptr %64, align 4
  %65 = alloca i32, align 4
  store i32 1, ptr %65, align 4
  %66 = load i32, ptr %63, align 4
  %67 = load i32, ptr %64, align 4
  %68 = add nsw i32 %66, %67
  %69 = load i32, ptr %65, align 4
  %70 = sub nsw i32 %68, %69
  store i32 %70, ptr %55, align 4
  %71 = load i32, ptr %63, align 4
  %72 = load i32, ptr %64, align 4
  %73 = mul nsw i32 %71, %72
  %74 = load i32, ptr %65, align 4
  %75 = add nsw i32 %73, %74
  store i32 %75, ptr %56, align 4
  %76 = load i32, ptr %65, align 4
  %77 = load i32, ptr %63, align 4
  %78 = load i32, ptr %64, align 4
  %79 = mul nsw i32 %77, %78
  %80 = add nsw i32 %76, %79
  store i32 %80, ptr %57, align 4
  %81 = load i32, ptr %55, align 4
  %82 = load i32, ptr %56, align 4
  %83 = load i32, ptr %57, align 4
  %84 = load i32, ptr %58, align 4
  call void @putint(i32 %81)
  call void @putstr(ptr @.str.5)
  call void @putint(i32 %82)
  call void @putstr(ptr @.str.6)
  call void @putint(i32 %83)
  call void @putstr(ptr @.str.7)
  call void @putint(i32 %84)
  call void @putstr(ptr @.str.8)
  %85 = load i32, ptr %63, align 4
  %86 = srem i32 %85, 4
  %87 = add nsw i32 %86, 1
  store i32 %87, ptr %55, align 4
  %88 = load i32, ptr %63, align 4
  %89 = sdiv i32 %88, 1
  %90 = add nsw i32 %89, 0
  store i32 %90, ptr %56, align 4
  %91 = load i32, ptr %63, align 4
  %92 = load i32, ptr %64, align 4
  %93 = mul nsw i32 %91, %92
  %94 = load i32, ptr %65, align 4
  %95 = sdiv i32 %93, %94
  store i32 %95, ptr %57, align 4
  %96 = load i32, ptr %63, align 4
  %97 = load i32, ptr %64, align 4
  %98 = load i32, ptr %65, align 4
  %99 = add nsw i32 %97, %98
  %100 = mul nsw i32 %96, %99
  store i32 %100, ptr %58, align 4
  %101 = load i32, ptr %55, align 4
  %102 = load i32, ptr %56, align 4
  %103 = load i32, ptr %57, align 4
  %104 = load i32, ptr %58, align 4
  call void @putint(i32 %101)
  call void @putstr(ptr @.str.9)
  call void @putint(i32 %102)
  call void @putstr(ptr @.str.10)
  call void @putint(i32 %103)
  call void @putstr(ptr @.str.11)
  call void @putint(i32 %104)
  call void @putstr(ptr @.str.12)
  %105 = load i32, ptr %55, align 4
  %106 = add nsw i32 0, %105
  store i32 %106, ptr %55, align 4
  %107 = load i32, ptr %56, align 4
  %108 = call i32 @fuc4(i32 %107)
  store i32 %108, ptr %55, align 4
  %109 = load i32, ptr %55, align 4
  %110 = load i32, ptr %56, align 4
  %111 = call i32 @fuc5(i32 %109, i32 %110)
  store i32 %111, ptr %55, align 4
  %112 = call i32 @fuc1()
  store i32 %112, ptr %55, align 4
  %113 = load i32, ptr %55, align 4
  %114 = sub nsw i32 0, %113
  store i32 %114, ptr %55, align 4
  %115 = load i32, ptr %55, align 4
  %116 = sub nsw i32 0, %115
  store i32 %116, ptr %55, align 4
  %117 = getelementptr inbounds i32, ptr %34, i32 0
  store i32 1, ptr %117, align 4
  %118 = load i32, ptr %63, align 4
  %119 = icmp eq i32 %118, 1
  br i1 %119, label %120, label %121

120:                                              ; preds = %0
  br label %121

121:                                              ; preds = %120, %0
  %122 = load i32, ptr %64, align 4
  %123 = icmp eq i32 %122, 0
  br i1 %123, label %124, label %125

124:                                              ; preds = %121
  br label %126

125:                                              ; preds = %121
  br label %126

126:                                              ; preds = %125, %124
  store i32 1, ptr %55, align 4
  br label %127

127:                                              ; preds = %131, %126
  %128 = load i32, ptr %55, align 4
  %129 = icmp slt i32 %128, 10
  br i1 %129, label %130, label %134

130:                                              ; preds = %127
  br label %131

131:                                              ; preds = %130
  %132 = load i32, ptr %55, align 4
  %133 = add nsw i32 %132, 1
  store i32 %133, ptr %55, align 4
  br label %127

134:                                              ; preds = %127
  store i32 1, ptr %55, align 4
  br label %135

135:                                              ; preds = %139, %134
  %136 = load i32, ptr %55, align 4
  %137 = icmp slt i32 %136, 10
  br i1 %137, label %138, label %142

138:                                              ; preds = %135
  br label %139

139:                                              ; preds = %138
  %140 = load i32, ptr %55, align 4
  %141 = add nsw i32 %140, 1
  store i32 %141, ptr %55, align 4
  br label %135

142:                                              ; preds = %135
  store i32 1, ptr %55, align 4
  store i32 1, ptr %55, align 4
  br label %143

143:                                              ; preds = %148, %142
  %144 = load i32, ptr %55, align 4
  %145 = icmp eq i32 %144, 10
  br i1 %145, label %146, label %147

146:                                              ; preds = %143
  br label %151

147:                                              ; preds = %143
  br label %148

148:                                              ; preds = %147
  %149 = load i32, ptr %55, align 4
  %150 = add nsw i32 %149, 1
  store i32 %150, ptr %55, align 4
  br label %143

151:                                              ; preds = %146
  store i32 1, ptr %55, align 4
  br label %152

152:                                              ; preds = %156, %151
  %153 = load i32, ptr %55, align 4
  %154 = icmp slt i32 %153, 10
  br i1 %154, label %155, label %159

155:                                              ; preds = %152
  br label %156

156:                                              ; preds = %155
  %157 = load i32, ptr %55, align 4
  %158 = add nsw i32 %157, 1
  store i32 %158, ptr %55, align 4
  br label %152

159:                                              ; preds = %152
  store i32 1, ptr %55, align 4
  br label %160

160:                                              ; preds = %163, %159
  %161 = load i32, ptr %55, align 4
  %162 = icmp slt i32 %161, 10
  br i1 %162, label %163, label %166

163:                                              ; preds = %160
  %164 = load i32, ptr %55, align 4
  %165 = add nsw i32 %164, 1
  store i32 %165, ptr %55, align 4
  br label %160

166:                                              ; preds = %160
  store i32 1, ptr %55, align 4
  store i32 1, ptr %55, align 4
  br label %167

167:                                              ; preds = %174, %173, %166
  %168 = load i32, ptr %55, align 4
  %169 = add nsw i32 %168, 1
  store i32 %169, ptr %55, align 4
  %170 = load i32, ptr %55, align 4
  %171 = icmp eq i32 %170, 10
  br i1 %171, label %172, label %173

172:                                              ; preds = %167
  br label %175

173:                                              ; preds = %167
  br label %167

174:                                              ; No predecessors!
  br label %167

175:                                              ; preds = %172
  store i32 1, ptr %55, align 4
  br label %176

176:                                              ; preds = %181, %175
  %177 = load i32, ptr %55, align 4
  %178 = icmp eq i32 %177, 10
  br i1 %178, label %179, label %180

179:                                              ; preds = %176
  br label %184

180:                                              ; preds = %176
  br label %181

181:                                              ; preds = %180
  %182 = load i32, ptr %55, align 4
  %183 = add nsw i32 %182, 1
  store i32 %183, ptr %55, align 4
  br label %176

184:                                              ; preds = %179
  store i32 1, ptr %55, align 4
  br label %185

185:                                              ; preds = %191, %184
  %186 = load i32, ptr %55, align 4
  %187 = add nsw i32 %186, 1
  store i32 %187, ptr %55, align 4
  %188 = load i32, ptr %55, align 4
  %189 = icmp eq i32 %188, 10
  br i1 %189, label %190, label %191

190:                                              ; preds = %185
  br label %192

191:                                              ; preds = %185
  br label %185

192:                                              ; preds = %190
  store i32 1, ptr %55, align 4
  store i32 1, ptr %55, align 4
  br label %193

193:                                              ; preds = %196, %192
  %194 = load i32, ptr %55, align 4
  %195 = icmp slt i32 %194, 10
  br i1 %195, label %196, label %199

196:                                              ; preds = %193
  %197 = load i32, ptr %55, align 4
  %198 = add nsw i32 %197, 1
  store i32 %198, ptr %55, align 4
  br label %193

199:                                              ; preds = %193
  %200 = load i32, ptr %55, align 4
  %201 = load i32, ptr %56, align 4
  %202 = add nsw i32 %200, %201
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
  %2 = call i32 (ptr, ...) @scanf(ptr noundef @.str.1.16, ptr noundef %1)
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
  %5 = call i32 (ptr, ...) @scanf(ptr noundef @.str.1.16, ptr noundef %3)
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
  %15 = call i32 (ptr, ...) @scanf(ptr noundef @.str.1.16, ptr noundef %14)
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
  %4 = call i32 (ptr, ...) @printf(ptr noundef @.str.1.16, i32 noundef %3)
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
