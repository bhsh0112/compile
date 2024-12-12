declare i32 @getint()
declare i32 @getchar()
declare void @putint(i32)
declare void @putch(i32)
declare void @putstr(i8*)

@ig1 = dso_local global i32 zeroinitializer
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
	%2 = alloca i32
	store i32 %0, i32* %2
	ret i32 1
}
define dso_local i32 @fuc5(i32 %0, i32 %1) {
	%3 = alloca i32
	store i32 %0, i32* %3
	%4 = alloca i32
	store i32 %1, i32* %4
	ret i32 1
}
define dso_local i32 @fuc6(i32 %0, i32* %1) {
	%3 = alloca i32
	store i32 %0, i32* %3
	%4 = alloca i32*
	store i32* %1, i32** %4
	ret i32 1
}
define dso_local i32 @main() {
	%1 = alloca i32
	store i32 1, i32* %1
	%2 = alloca i32
	store i32 1, i32* %2
	%3 = alloca i32
	store i32 1, i32* %3
	%4 = alloca [5 x i32]
	%5 = getelementptr inbounds [5 x i32], [5 x i32]* %4, i32 0, i32 0
	store i32 1, i32* %5
	%6 = getelementptr inbounds i32, i32* %5, i32 1
	store i32 2, i32* %6
	%7 = getelementptr inbounds i32, i32* %6, i32 1
	store i32 3, i32* %7
	%8 = getelementptr inbounds i32, i32* %7, i32 1
	store i32 4, i32* %8
	%9 = getelementptr inbounds i32, i32* %8, i32 1
	store i32 5, i32* %9
	%10 = alloca [3 x i32]
	%11 = getelementptr inbounds [3 x i32], [3 x i32]* %10, i32 0, i32 0
	store i32 1, i32* %11
	%12 = getelementptr inbounds i32, i32* %11, i32 1
	store i32 2, i32* %12
	%13 = getelementptr inbounds i32, i32* %12, i32 1
	store i32 3, i32* %13
	%14 = alloca i32
	store i32 2, i32* %14
	%15 = alloca i8
	store i8 97, i8* %15
	%16 = alloca i8
	store i8 97, i8* %16
	%17 = alloca i8
	store i8 98, i8* %17
	%18 = alloca [5 x i8]
	%19 = getelementptr inbounds [5 x i8], [5 x i8]* %18, i32 0, i32 1
	store i8 97, i8* %19
	%20 = getelementptr inbounds [5 x i8], [5 x i8]* %19, i32 0, i32 2
	store i8 98, i8* %20
	%21 = getelementptr inbounds [5 x i8], [5 x i8]* %20, i32 0, i32 3
	store i8 99, i8* %21
	%22 = getelementptr inbounds [5 x i8], [5 x i8]* %21, i32 0, i32 4
	store i8 100, i8* %22
	%23 = alloca [5 x i8]
	%24 = getelementptr inbounds [5 x i8], [5 x i8]* %23, i32 0, i32 1
	store i8 97, i8* %24
	%25 = getelementptr inbounds [5 x i8], [5 x i8]* %24, i32 0, i32 2
	store i8 98, i8* %25
	%26 = getelementptr inbounds [5 x i8], [5 x i8]* %25, i32 0, i32 3
	store i8 99, i8* %26
	%27 = getelementptr inbounds [5 x i8], [5 x i8]* %26, i32 0, i32 4
	store i8 100, i8* %27
	%28 = alloca i8
	store i8 97, i8* %28
	%29 = alloca i32
	%30 = alloca i32
	%31 = alloca i32
	%32 = alloca [5 x i32]
	%33 = alloca i32
	store i32 1, i32* %33
	%34 = alloca [5 x i32]
	%35 = getelementptr inbounds [5 x i32], [5 x i32]* %34, i32 0, i32 0
	store i32 1, i32* %35
	%36 = getelementptr inbounds i32, i32* %35, i32 1
	store i32 2, i32* %36
	%37 = getelementptr inbounds i32, i32* %36, i32 1
	store i32 3, i32* %37
	%38 = getelementptr inbounds i32, i32* %37, i32 1
	store i32 4, i32* %38
	%39 = getelementptr inbounds i32, i32* %38, i32 1
	store i32 5, i32* %39
	%40 = alloca i8
	%41 = alloca i8
	store i8 97, i8* %41
	%42 = alloca i8
	%43 = alloca i8
	store i8 97, i8* %43
	%44 = alloca [5 x i8]
	%45 = alloca [5 x i8]
	%46 = getelementptr inbounds [5 x i8], [5 x i8]* %45, i32 0, i32 0
	store i8 97, i8* %46
	%47 = getelementptr inbounds [5 x i8], [5 x i8]* %46, i32 0, i32 1
	store i8 98, i8* %47
	%48 = getelementptr inbounds [5 x i8], [5 x i8]* %47, i32 0, i32 2
	store i8 99, i8* %48
	%49 = getelementptr inbounds [5 x i8], [5 x i8]* %48, i32 0, i32 3
	store i8 100, i8* %49
	call void @putstr(i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str, i64 0, i64 0))
	%50 = alloca i32
	store i32 0, i32* %50
	%51 = alloca i8
	store i8 0, i8* %51
	%52 = call i32 @getint()
	store i32 %52, i32* %50
	%53 = call i32 @getchar()
	%54 = trunc i32 %53 to i8
	store i8 %54, i8* %51
	%55 = alloca i32
	store i32 6, i32* %55
	%56 = alloca i32
	store i32 4, i32* %56
	%57 = alloca i32
	store i32 4, i32* %57
	%58 = alloca i32
	store i32 9, i32* %58
	%59 = load i32, i32* %55
	%60 = load i32, i32* %56
	%61 = load i32, i32* %57
	%62 = load i32, i32* %58
	call void @putint(i32 %59)
	call void @putstr(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.1, i64 0, i64 0))
	call void @putint(i32 %60)
	call void @putstr(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.2, i64 0, i64 0))
	call void @putint(i32 %61)
	call void @putstr(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.3, i64 0, i64 0))
	call void @putint(i32 %62)
	call void @putstr(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.4, i64 0, i64 0))
	%63 = alloca i32
	store i32 1, i32* %63
	%64 = alloca i32
	store i32 1, i32* %64
	%65 = alloca i32
	store i32 1, i32* %65
	%66 = load i32, i32* %63
	%67 = load i32, i32* %64
	%68 = add nsw i32 %66, %67
	%69 = load i32, i32* %65
	%70 = sub nsw i32 %68, %69
	store i32 %70, i32* %55
	%71 = load i32, i32* %63
	%72 = load i32, i32* %64
	%73 = mul nsw i32 %71, %72
	%74 = load i32, i32* %65
	%75 = add nsw i32 %73, %74
	store i32 %75, i32* %56
	%76 = load i32, i32* %65
	%77 = load i32, i32* %63
	%78 = load i32, i32* %64
	%79 = mul nsw i32 %77, %78
	%80 = add nsw i32 %76, %79
	store i32 %80, i32* %57
	%81 = load i32, i32* %55
	%82 = load i32, i32* %56
	%83 = load i32, i32* %57
	%84 = load i32, i32* %58
	call void @putint(i32 %81)
	call void @putstr(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.5, i64 0, i64 0))
	call void @putint(i32 %82)
	call void @putstr(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.6, i64 0, i64 0))
	call void @putint(i32 %83)
	call void @putstr(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.7, i64 0, i64 0))
	call void @putint(i32 %84)
	call void @putstr(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.8, i64 0, i64 0))
	%85 = load i32, i32* %63
	%86 = srem i32 %85, 4
	%87 = add nsw i32 %86, 1
	store i32 %87, i32* %55
	%88 = load i32, i32* %63
	%89 = sdiv i32 %88, 1
	%90 = add nsw i32 %89, 0
	store i32 %90, i32* %56
	%91 = load i32, i32* %63
	%92 = load i32, i32* %64
	%93 = mul nsw i32 %91, %92
	%94 = load i32, i32* %65
	%95 = sdiv i32 %93, %94
	store i32 %95, i32* %57
	%96 = load i32, i32* %63
	%97 = load i32, i32* %64
	%98 = load i32, i32* %65
	%99 = add nsw i32 %97, %98
	%100 = mul nsw i32 %96, %99
	store i32 %100, i32* %58
	%101 = load i32, i32* %55
	%102 = load i32, i32* %56
	%103 = load i32, i32* %57
	%104 = load i32, i32* %58
	call void @putint(i32 %101)
	call void @putstr(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.9, i64 0, i64 0))
	call void @putint(i32 %102)
	call void @putstr(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.10, i64 0, i64 0))
	call void @putint(i32 %103)
	call void @putstr(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.11, i64 0, i64 0))
	call void @putint(i32 %104)
	call void @putstr(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.12, i64 0, i64 0))
	%105 = load i32, i32* %55
	%106 = add nsw i32 0, %105
	store i32 %106, i32* %55
	%107 = load i32, i32* %56
	%108 = call i32 @fuc4(i32 %107)
	store i32 %108, i32* %55
	%109 = load i32, i32* %55
	%110 = load i32, i32* %56
	%111 = call i32 @fuc5(i32 %109, i32 %110)
	store i32 %111, i32* %55
	%112 = call i32 @fuc1()
	store i32 %112, i32* %55
	%113 = load i32, i32* %55
	%114 = sub nsw i32 0, %113
	store i32 %114, i32* %55
	%115 = load i32, i32* %55
	%116 = sub nsw i32 0, %115
	store i32 %116, i32* %55
	%117 = getelementptr inbounds i32, i32* %34, i32 0
	store i32 1, i32* %117
	%118 = load i32, i32* %63
	%119 = icmp eq i32 %118, 1
	br i1 %119, label %120, label %121

120:
	br label %121

121:
	%122 = load i32, i32* %64
	%123 = icmp eq i32 %122, 0
	br i1 %123, label %124, label %125

124:
	br label %126

125:
	br label %126

126:
	store i32 1, i32* %55
	br label %127

127:
	%128 = load i32, i32* %55
	%129 = icmp slt i32 %128, 10
	br i1 %129, label %130, label %134

130:
	br label %131

131:
	%132 = load i32, i32* %55
	%133 = add nsw i32 %132, 1
	store i32 %133, i32* %55
	br label %127

134:
	store i32 1, i32* %55
	br label %135

135:
	%136 = load i32, i32* %55
	%137 = icmp slt i32 %136, 10
	br i1 %137, label %138, label %142

138:
	br label %139

139:
	%140 = load i32, i32* %55
	%141 = add nsw i32 %140, 1
	store i32 %141, i32* %55
	br label %135

142:
	store i32 1, i32* %55
	store i32 1, i32* %55
	br label %143

143:
	%144 = load i32, i32* %55
	%145 = icmp eq i32 %144, 10
	br i1 %145, label %146, label %147

146:
	br label %151

147:
	br label %148

148:
	%149 = load i32, i32* %55
	%150 = add nsw i32 %149, 1
	store i32 %150, i32* %55
	br label %143

151:
	store i32 1, i32* %55
	br label %152

152:
	%153 = load i32, i32* %55
	%154 = icmp slt i32 %153, 10
	br i1 %154, label %155, label %159

155:
	br label %156

156:
	%157 = load i32, i32* %55
	%158 = add nsw i32 %157, 1
	store i32 %158, i32* %55
	br label %152

159:
	store i32 1, i32* %55
	br label %160

160:
	%161 = load i32, i32* %55
	%162 = icmp slt i32 %161, 10
	br i1 %162, label %163, label %166

163:
	%164 = load i32, i32* %55
	%165 = add nsw i32 %164, 1
	store i32 %165, i32* %55
	br label %160

166:
	store i32 1, i32* %55
	store i32 1, i32* %55
	br label %167

167:
	%168 = load i32, i32* %55
	%169 = add nsw i32 %168, 1
	store i32 %169, i32* %55
	%170 = load i32, i32* %55
	%171 = icmp eq i32 %170, 10
	br i1 %171, label %172, label %173

172:
	br label %175

173:
	br label %167

174:
	br label %167

175:
	store i32 1, i32* %55
	br label %176

176:
	%177 = load i32, i32* %55
	%178 = icmp eq i32 %177, 10
	br i1 %178, label %179, label %180

179:
	br label %184

180:
	br label %181

181:
	%182 = load i32, i32* %55
	%183 = add nsw i32 %182, 1
	store i32 %183, i32* %55
	br label %176

184:
	store i32 1, i32* %55
	br label %185

185:
	%186 = load i32, i32* %55
	%187 = add nsw i32 %186, 1
	store i32 %187, i32* %55
	%188 = load i32, i32* %55
	%189 = icmp eq i32 %188, 10
	br i1 %189, label %190, label %191

190:
	br label %192

191:
	br label %185

192:
	store i32 1, i32* %55
	store i32 1, i32* %55
	br label %193

193:
	%194 = load i32, i32* %55
	%195 = icmp slt i32 %194, 10
	br i1 %195, label %196, label %199

196:
	%197 = load i32, i32* %55
	%198 = add nsw i32 %197, 1
	store i32 %198, i32* %55
	br label %193

199:
	%200 = load i32, i32* %55
	%201 = load i32, i32* %56
	%202 = add nsw i32 %200, %201
	ret i32 0
}
