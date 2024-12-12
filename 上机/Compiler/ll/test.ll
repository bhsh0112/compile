declare i32 @getint()
declare i32 @getchar()
declare void @putint(i32)
declare void @putch(i32)
declare void @putstr(i8*)

@a = dso_local global i32 10
@ty = dso_local global i32 90
@b = dso_local global [3 x i32] [i32 1,i32 2,i32 3]
@x = dso_local global i32 5
@z = dso_local global i32 114514
@y = dso_local global [3 x i32] zeroinitializer
@global_var = dso_local global i32 0
@buaa = dso_local global i8 92
@aa = dso_local global [5 x i8] [i8 97,i8 98,i8 99,i8 92,i8 48]
@aaa = dso_local global [6 x i8] [i8 120,i8 121,i8 122,i8 0,i8 0,i8 0]
@.str = private unnamed_addr constant [10 x i8] c"21374067\0A\00", align 1
@.str.1 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.2 = private unnamed_addr constant [4 x i8] c"i: \00", align 1
@.str.3 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.4 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.5 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
define dso_local i32 @g(i32* %0) {
	%2 = alloca i32*
	store i32* %0, i32** %2
	%3 = load i32*, i32** %2
	%4 = getelementptr inbounds i32, i32* %3, i32 0
	%5 = load i32, i32* %4
	%6 = load i32*, i32** %2
	%7 = getelementptr inbounds i32, i32* %6, i32 1
	%8 = load i32, i32* %7
	%9 = load i32*, i32** %2
	%10 = getelementptr inbounds i32, i32* %9, i32 0
	%11 = load i32, i32* %10
	%12 = sub nsw i32 0, %11
	%13 = add nsw i32 %8, %12
	%14 = load i32*, i32** %2
	%15 = getelementptr inbounds i32, i32* %14, i32 %13
	%16 = load i32, i32* %15
	%17 = add nsw i32 %5, %16
	ret i32 %17
}
define dso_local i8 @foo(i32 %0, i32 %1) {
	%3 = alloca i32
	store i32 %0, i32* %3
	%4 = alloca i32
	store i32 %1, i32* %4
	ret i8 111
}
define dso_local void @fooo(i32 %0, i32 %1) {
	%3 = alloca i32
	store i32 %0, i32* %3
	%4 = alloca i32
	store i32 %1, i32* %4
	ret void
}
define dso_local i32 @func() {
	%1 = load i32, i32* @global_var
	%2 = add nsw i32 %1, 1
	store i32 %2, i32* @global_var
	ret i32 1
}
define dso_local i32 @main() {
	call void @putstr(i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str, i64 0, i64 0))
	%1 = alloca i32
	store i32 0, i32* %1
	%2 = alloca i8
	store i8 97, i8* %2
	%3 = alloca i8
	store i8 98, i8* %3
	%4 = alloca i32
	store i32 -10, i32* %4
	%5 = alloca i32
	%6 = load i32, i32* %4
	%7 = add nsw i32 %6, 5
	%8 = mul nsw i32 %7, 2
	%9 = sdiv i32 %8, 1
	%10 = add nsw i32 %9, 0
	store i32 %10, i32* %5
	%11 = load i32, i32* %4
	%12 = icmp slt i32 %11, 20
	br i1 %12, label %16, label %13

13:
	%14 = call i32 @func()
	%15 = icmp ne i32 %14, 0
	br i1 %15, label %19, label %16

16:
	%17 = load i32, i32* %4
	%18 = sub nsw i32 %17, 1
	store i32 %18, i32* %4
	br label %31

19:
	%20 = load i32, i32* %4
	%21 = icmp sgt i32 %20, 0
	br i1 %21, label %22, label %30

22:
	%23 = call i32 @func()
	%24 = icmp ne i32 %23, 0
	br i1 %24, label %25, label %30

25:
	%26 = load i32, i32* %4
	%27 = add nsw i32 %26, 1
	store i32 %27, i32* %4
	%28 = load i32, i32* %4
	%29 = add nsw i32 %28, 1
	br label %30

30:
	br label %31

31:
	%32 = load i32, i32* %4
	call void @putint(i32 %32)
	call void @putstr(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.1, i64 0, i64 0))
	store i32 0, i32* %1
	br label %33

33:
	%34 = load i32, i32* %1
	%35 = icmp slt i32 %34, 6
	br i1 %35, label %36, label %41

36:
	%37 = load i32, i32* %1
	call void @putstr(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.2, i64 0, i64 0))
	call void @putint(i32 %37)
	call void @putstr(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.3, i64 0, i64 0))
	br label %38

38:
	%39 = load i32, i32* %1
	%40 = add nsw i32 %39, 1
	store i32 %40, i32* %1
	br label %33

41:
	%42 = alloca [3 x i32]
	%43 = getelementptr inbounds [3 x i32], [3 x i32]* %42, i32 0, i32 0
	store i32 1, i32* %43
	%44 = getelementptr inbounds i32, i32* %43, i32 1
	store i32 2, i32* %44
	%45 = getelementptr inbounds i32, i32* %44, i32 1
	store i32 3, i32* %45
	%46 = alloca i32
	%47 = call i32 @func()
	store i32 %47, i32* %46
	%48 = alloca i32
	%49 = call i32 @getint()
	store i32 %49, i32* %48
	%50 = getelementptr inbounds [3 x i32], [3 x i32]* %42, i32 0, i32 0
	%51 = call i32 @g(i32* %50)
	store i32 %51, i32* %1
	%52 = call i32 @getchar()
	%53 = trunc i32 %52 to i8
	store i8 %53, i8* %2
	store i8 97, i8* %2
	br label %54

54:
	%55 = load i8, i8* %2
	%56 = zext i8 %55 to i32
	%57 = icmp slt i32 %56, 127
	br i1 %57, label %61, label %58

58:
	%59 = load i32, i32* %1
	%60 = icmp ne i32 %59, 0
	br i1 %60, label %61, label %76

61:
	%62 = load i8, i8* %2
	%63 = zext i8 %62 to i32
	%64 = add nsw i32 %63, 1
	%65 = trunc i32 %64 to i8
	store i8 %65, i8* %2
	%66 = load i8, i8* %2
	%67 = zext i8 %66 to i32
	%68 = icmp eq i32 %67, 120
	br i1 %68, label %69, label %70

69:
	br label %76

70:
	br label %71

71:
	%72 = load i8, i8* %2
	%73 = zext i8 %72 to i32
	%74 = add nsw i32 %73, 1
	%75 = trunc i32 %74 to i8
	store i8 %75, i8* %2
	br label %54

76:
	store i8 97, i8* %2
	br label %77

77:
	%78 = load i8, i8* %2
	%79 = zext i8 %78 to i32
	%80 = add nsw i32 %79, 1
	%81 = trunc i32 %80 to i8
	store i8 %81, i8* %2
	%82 = load i8, i8* %2
	%83 = zext i8 %82 to i32
	%84 = icmp eq i32 %83, 120
	br i1 %84, label %85, label %86

85:
	br label %92

86:
	br label %87

87:
	%88 = load i8, i8* %2
	%89 = zext i8 %88 to i32
	%90 = add nsw i32 %89, 1
	%91 = trunc i32 %90 to i8
	store i8 %91, i8* %2
	br label %77

92:
	%93 = load i8, i8* %2
	%94 = zext i8 %93 to i32
	call void @putch(i32 %94)
	call void @putstr(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.4, i64 0, i64 0))
	%95 = load i8, i8* %2
	%96 = zext i8 %95 to i32
	call void @putint(i32 %96)
	call void @putstr(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.5, i64 0, i64 0))
	%97 = load i8, i8* %2
	%98 = zext i8 %97 to i32
	%99 = icmp sgt i32 %98, 0
	br i1 %99, label %100, label %174

100:
	%101 = load i8, i8* %2
	%102 = zext i8 %101 to i32
	%103 = icmp slt i32 %102, 0
	br i1 %103, label %104, label %174

104:
	%105 = load i8, i8* %2
	%106 = zext i8 %105 to i32
	%107 = icmp sle i32 %106, 0
	br i1 %107, label %108, label %174

108:
	%109 = load i8, i8* %2
	%110 = zext i8 %109 to i32
	%111 = icmp sge i32 %110, 0
	br i1 %111, label %112, label %174

112:
	%113 = load i8, i8* %2
	%114 = zext i8 %113 to i32
	%115 = icmp ne i32 %114, 0
	br i1 %115, label %116, label %174

116:
	%117 = load i8, i8* %2
	%118 = zext i8 %117 to i32
	%119 = icmp eq i32 %118, 0
	br i1 %119, label %120, label %174

120:
	br label %121

121:
	%122 = load i8, i8* %2
	%123 = icmp ne i8 %122, 0
	br i1 %123, label %139, label %124

124:
	%125 = load i8, i8* %2
	%126 = zext i8 %125 to i32
	%127 = add nsw i32 %126, 1
	%128 = trunc i32 %127 to i8
	store i8 %128, i8* %2
	%129 = load i8, i8* %2
	%130 = zext i8 %129 to i32
	%131 = icmp eq i32 %130, 120
	br i1 %131, label %132, label %133

132:
	br label %139

133:
	br label %134

134:
	%135 = load i8, i8* %2
	%136 = zext i8 %135 to i32
	%137 = add nsw i32 %136, 1
	%138 = trunc i32 %137 to i8
	store i8 %138, i8* %2
	br label %121

139:
	br label %140

140:
	store i8 97, i8* %2
	br label %140

141:
	%142 = load i8, i8* %2
	store i8 %142, i8* %2
	br label %143

143:
	store i8 98, i8* %2
	br label %143

144:
	br label %145

145:
	store i8 99, i8* %2
	br label %146

146:
	%147 = load i8, i8* %2
	store i8 %147, i8* %2
	br label %145

148:
	br label %149

149:
	%150 = load i8, i8* %2
	%151 = load i8, i8* %2
	%152 = zext i8 %150 to i32
	%153 = zext i8 %151 to i32
	%154 = icmp ne i32 %152, %153
	br i1 %154, label %155, label %156

155:
	store i8 100, i8* %2
	br label %149

156:
	br label %157

157:
	store i8 101, i8* %2
	br label %157

158:
	%159 = load i8, i8* %2
	store i8 %159, i8* %2
	br label %160

160:
	store i8 102, i8* %2
	br label %161

161:
	%162 = load i8, i8* %2
	store i8 %162, i8* %2
	br label %160

163:
	br label %164

164:
	%165 = load i8, i8* %2
	%166 = load i8, i8* %2
	%167 = zext i8 %165 to i32
	%168 = zext i8 %166 to i32
	%169 = icmp ne i32 %167, %168
	br i1 %169, label %170, label %173

170:
	store i8 103, i8* %2
	br label %171

171:
	%172 = load i8, i8* %2
	store i8 %172, i8* %2
	br label %164

173:
	br label %174

174:
	ret i32 0
}
