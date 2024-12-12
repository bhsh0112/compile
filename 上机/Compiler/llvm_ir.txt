declare i32 @getint()
declare i32 @getchar()
declare void @putint(i32)
declare void @putch(i32)
declare void @putstr(i8*)

@const_var1 = dso_local global i32 17
@const_var2 = dso_local global i32 3
@arr = dso_local global [3 x i32] [i32 1,i32 2,i32 3]
@const_var3 = dso_local global i8 99
@s = dso_local global [5 x i8] [i8 97,i8 98,i8 99,i8 100,i8 0]
@str = dso_local global [5 x i8] [i8 97,i8 98,i8 99,i8 100,i8 0]
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
define dso_local i32 @f3(i32* %0, i32* %1, i32 %2, i32 %3) {
	%5 = alloca i32*
	store i32* %0, i32** %5
	%6 = alloca i32*
	store i32* %1, i32** %6
	%7 = alloca i32
	store i32 %2, i32* %7
	%8 = alloca i32
	store i32 %3, i32* %8
	%9 = alloca i32
	store i32 0, i32* %9
	br label %10

10:
	%11 = load i32, i32* %9
	%12 = icmp eq i32 %11, 0
	br i1 %12, label %13, label %20

13:
	%14 = load i32, i32* %7
	%15 = load i32, i32* %8
	%16 = add nsw i32 %14, %15
	store i32 %16, i32* %7
	br label %17

17:
	%18 = load i32, i32* %9
	%19 = add nsw i32 %18, 1
	store i32 %19, i32* %9
	br label %10

20:
	%21 = load i32, i32* %9
	%22 = load i32*, i32** %5
	%23 = getelementptr inbounds i32, i32* %22, i32 %21
	%24 = load i32, i32* %23
	%25 = load i32, i32* %9
	%26 = load i32*, i32** %6
	%27 = getelementptr inbounds i32, i32* %26, i32 %25
	%28 = load i32, i32* %27
	%29 = load i32, i32* %7
	%30 = add nsw i32 %28, %29
	%31 = mul nsw i32 %24, %30
	%32 = load i32, i32* %8
	%33 = sub nsw i32 %31, %32
	ret i32 %33
}
define dso_local i32 @f4(i32 %0, i32 %1) {
	%3 = alloca i32
	store i32 %0, i32* %3
	%4 = alloca i32
	store i32 %1, i32* %4
	%5 = load i32, i32* %3
	%6 = load i32, i32* %4
	%7 = add nsw i32 %5, %6
	ret i32 %7
}
define dso_local i8 @f5(i8 %0, i8 %1) {
	%3 = alloca i8
	store i8 %0, i8* %3
	%4 = alloca i8
	store i8 %1, i8* %4
	%5 = load i8, i8* %3
	%6 = load i8, i8* %4
	%7 = zext i8 %5 to i32
	%8 = zext i8 %6 to i32
	%9 = add nsw i32 %7, %8
	%10 = trunc i32 %9 to i8
	ret i8 %10
}
define dso_local i32 @f7(i32 %0) {
	%2 = alloca i32
	store i32 %0, i32* %2
	%3 = load i32, i32* %2
	ret i32 %3
}
define dso_local i8 @f8(i8 %0) {
	%2 = alloca i8
	store i8 %0, i8* %2
	%3 = load i8, i8* %2
	ret i8 %3
}
define dso_local i32 @f6() {
	ret i32 0
}
define dso_local void @f2(i32 %0) {
	%2 = alloca i32
	store i32 %0, i32* %2
	%3 = load i32, i32* %2
	call void @putint(i32 %3)
	call void @putstr(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str, i64 0, i64 0))
	ret void
}
define dso_local void @f9() {
	ret void
}
define dso_local i32 @main() {
	call void @putstr(i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.1, i64 0, i64 0))
	%1 = alloca i32
	store i32 0, i32* %1
	call void @f9()
	%2 = alloca i32
	store i32 1, i32* %2
	%3 = alloca [3 x i32]
	%4 = alloca [3 x i32]
	%5 = getelementptr inbounds [3 x i32], [3 x i32]* %4, i32 0, i32 0
	store i32 1, i32* %5
	%6 = getelementptr inbounds i32, i32* %5, i32 1
	store i32 2, i32* %6
	%7 = getelementptr inbounds i32, i32* %6, i32 1
	store i32 3, i32* %7
	%8 = alloca [3 x i32]
	%9 = getelementptr inbounds [3 x i32], [3 x i32]* %8, i32 0, i32 0
	store i32 4, i32* %9
	%10 = getelementptr inbounds i32, i32* %9, i32 1
	store i32 5, i32* %10
	%11 = getelementptr inbounds i32, i32* %10, i32 1
	store i32 6, i32* %11
	%12 = alloca i32
	%13 = getelementptr inbounds [3 x i32], [3 x i32]* %4, i32 0, i32 0
	%14 = getelementptr inbounds [3 x i32], [3 x i32]* %8, i32 0, i32 0
	%15 = load i32, i32* %1
	%16 = load i32, i32* %2
	%17 = call i32 @f3(i32* %13, i32* %14, i32 %15, i32 %16)
	store i32 %17, i32* %12
	%18 = alloca i32
	store i32 1, i32* %18
	%19 = alloca i8
	store i8 99, i8* %19
	%20 = call i8 @f8(i8 99)
	store i8 %20, i8* %19
	%21 = load i32, i32* %1
	%22 = load i32, i32* %18
	%23 = add nsw i32 %21, %22
	%24 = load i32, i32* %18
	%25 = add nsw i32 %23, %24
	%26 = add nsw i32 %25, 10
	store i32 %26, i32* %1
	%27 = load i32, i32* %1
	%28 = sub nsw i32 0, %27
	store i32 %28, i32* %1
	%29 = load i32, i32* %1
	%30 = sub nsw i32 0, %29
	%31 = load i32, i32* %1
	%32 = load i32, i32* %1
	%33 = sdiv i32 %32, 2	store i32 %33, i32* %1
	%34 = load i32, i32* %1
	%35 = srem i32 %34, 2
	store i32 %35, i32* %1
	%36 = load i32, i32* %1
	%37 = icmp ne i32 %36, 0
	br i1 %37, label %39, label %38

38:
	br label %39

39:
	%40 = call i8 @f5(i8 103, i8 102)
	store i8 %40, i8* %19
	%41 = alloca i32
	%42 = load i32, i32* %1
	%43 = add nsw i32 %42, 1
	store i32 %43, i32* %41
	%44 = load i32, i32* %1
	store i32 %44, i32* %41
	%45 = call i32 @getchar()
	%46 = trunc i32 %45 to i8
	store i8 %46, i8* %19
	%47 = alloca i32
	store i32 4, i32* %47
	%48 = alloca i32
	store i32 1, i32* %48
	%49 = alloca i32
	%50 = call i32 @f7(i32 0)
	store i32 %50, i32* %49
	%51 = call i32 @getint()
	store i32 %51, i32* %48
	%52 = load i32, i32* %1
	%53 = load i32, i32* %47
	%54 = call i32 @f4(i32 %52, i32 %53)
	store i32 %54, i32* %48
	store i32 0, i32* %49
	br label %55

55:
	%56 = load i32, i32* %49
	%57 = load i32, i32* %47
	%58 = icmp slt i32 %56, %57
	br i1 %58, label %59, label %85

59:
	%60 = load i32, i32* %1
	%61 = mul nsw i32 %60, -1
	%62 = load i32, i32* %47
	%63 = load i32, i32* %49
	%64 = add nsw i32 %63, 1
	%65 = sdiv i32 %62, %64	%66 = srem i32 %65, 2
	%67 = add nsw i32 %61, %66
	%68 = load i32, i32* %18
	%69 = sdiv i32 %68, 3	%70 = add nsw i32 %67, %69
	store i32 %70, i32* %48
	%71 = load i32, i32* %48
	call void @putint(i32 %71)
	call void @putstr(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.2, i64 0, i64 0))
	%72 = load i32, i32* %48
	%73 = icmp sgt i32 %72, 0
	br i1 %73, label %74, label %75

74:
	call void @putstr(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.3, i64 0, i64 0))
	br label %76

75:
	call void @putstr(i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.4, i64 0, i64 0))
	br label %76

76:
	%77 = load i32, i32* %49
	%78 = icmp sge i32 %77, 0
	br i1 %78, label %79, label %80

79:
	br label %82

80:
	br label %85

81:
	br label %82

82:
	%83 = load i32, i32* %49
	%84 = add nsw i32 %83, 1
	store i32 %84, i32* %49
	br label %55

85:
	store i32 0, i32* %49
	br label %86

86:
	%87 = load i32, i32* %49
	%88 = load i32, i32* %47
	%89 = icmp slt i32 %87, %88
	br i1 %89, label %90, label %94

90:
	br label %94

91:
	%92 = load i32, i32* %49
	%93 = add nsw i32 %92, 1
	store i32 %93, i32* %49
	br label %86

94:
	store i32 0, i32* %49
	br label %95

95:
	br label %99

96:
	%97 = load i32, i32* %49
	%98 = add nsw i32 %97, 1
	store i32 %98, i32* %49
	br label %95

99:
	br label %100

100:
	br label %101

101:
	br label %102

102:
	br label %106

103:
	%104 = load i32, i32* %49
	%105 = add nsw i32 %104, 1
	store i32 %105, i32* %49
	br label %102

106:
	br label %107

107:
	%108 = load i32, i32* %49
	%109 = load i32, i32* %47
	%110 = icmp slt i32 %108, %109
	br i1 %110, label %111, label %112

111:
	br label %112

112:
	store i32 0, i32* %49
	br label %113

113:
	br label %114

114:
	br label %115

115:
	br label %116

116:
	br label %117

117:
	br label %119

118:
	br label %119

119:
	%120 = load i32, i32* %47
	%121 = load i32, i32* %1
	%122 = icmp sge i32 %120, %121
	br i1 %122, label %123, label %124

123:
	br label %124

124:
	%125 = load i32, i32* %47
	%126 = load i32, i32* %1
	%127 = icmp sle i32 %125, %126
	br i1 %127, label %128, label %129

128:
	br label %129

129:
	%130 = load i32, i32* %47
	%131 = load i32, i32* %1
	%132 = icmp eq i32 %130, %131
	br i1 %132, label %133, label %134

133:
	br label %134

134:
	%135 = load i32, i32* %47
	%136 = load i32, i32* %1
	%137 = icmp sgt i32 %135, %136
	br i1 %137, label %138, label %139

138:
	br label %139

139:
	%140 = load i32, i32* %47
	%141 = load i32, i32* %1
	%142 = icmp slt i32 %140, %141
	br i1 %142, label %143, label %144

143:
	br label %144

144:
	%145 = load i32, i32* %47
	%146 = load i32, i32* %1
	%147 = icmp ne i32 %145, %146
	br i1 %147, label %148, label %149

148:
	br label %149

149:
	%150 = call i32 @f6()
	br label %151

151:
	call void @f2(i32 1)
	br label %152

152:
	br label %158

153:
	%154 = load i32, i32* %47
	%155 = load i32, i32* %1
	%156 = icmp ne i32 %154, %155
	br i1 %156, label %157, label %158

157:
	br label %158

158:
	br label %162

159:
	%160 = load i32, i32* %1
	%161 = icmp sgt i32 %160, 0
	br i1 %161, label %162, label %163

162:
	br label %163

163:
	%164 = load i32, i32* %47
	%165 = load i32, i32* %1
	%166 = icmp eq i32 %164, %165
	br i1 %166, label %178, label %167

167:
	%168 = load i32, i32* %1
	%169 = icmp sgt i32 %168, 0
	br i1 %169, label %170, label %179

170:
	%171 = icmp eq i32 1, 1
	br i1 %171, label %172, label %179

172:
	%173 = load i32, i32* %47
	%174 = add nsw i32 %173, 1
	%175 = srem i32 %174, 2
	%176 = sdiv i32 %175, 2	%177 = icmp ne i32 %176, 0
	br i1 %177, label %178, label %179

178:
	br label %179

179:
	ret i32 0
}
