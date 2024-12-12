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
	br i1 %12, label %13, label %18

13:
	%14 = load i32, i32* %7
	%15 = load i32, i32* %8
	%16 = add nsw i32 %14, %15
	store i32 %16, i32* %7
	br label %17

17:
	br label %10

18:
	%19 = load i32, i32* %9
	%20 = load i32*, i32** %5
	%21 = getelementptr inbounds i32, i32* %20, i32 %19
	%22 = load i32, i32* %21
	%23 = load i32, i32* %9
	%24 = load i32*, i32** %6
	%25 = getelementptr inbounds i32, i32* %24, i32 %23
	%26 = load i32, i32* %25
	%27 = load i32, i32* %7
	%28 = add nsw i32 %26, %27
	%29 = mul nsw i32 %22, %28
	%30 = load i32, i32* %8
	%31 = sub nsw i32 %29, %30
	ret i32 %31
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
	store i8 'c', i8* %19
	%20 = call i8 @f8(i8 'c')
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
	%40 = call i8 @f5(i8 'g', i8 'f')
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
	br label %81

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
	br i1 %89, label %90, label %92

90:
	br label %92

91:
	br label %86

92:
	store i32 0, i32* %49
	br label %93

93:
	br label %95

94:
	br label %93

95:
	br label %96

96:
	br label %97

97:
	br label %98

98:
	br label %102

99:
	%100 = load i32, i32* %49
	%101 = add nsw i32 %100, 1
	store i32 %101, i32* %49
	br label %98

102:
	br label %103

103:
	%104 = load i32, i32* %49
	%105 = load i32, i32* %47
	%106 = icmp slt i32 %104, %105
	br i1 %106, label %107, label %108

107:
	br label %108

108:
	store i32 0, i32* %49
	br label %109

109:
	br label %110

110:
	br label %111

111:
	br label %112

112:
	br label %113

113:
	br label %115

114:
	br label %115

115:
	%116 = load i32, i32* %47
	%117 = load i32, i32* %1
	%118 = icmp sge i32 %116, %117
	br i1 %118, label %119, label %120

119:
	br label %120

120:
	%121 = load i32, i32* %47
	%122 = load i32, i32* %1
	%123 = icmp sle i32 %121, %122
	br i1 %123, label %124, label %125

124:
	br label %125

125:
	%126 = load i32, i32* %47
	%127 = load i32, i32* %1
	%128 = icmp eq i32 %126, %127
	br i1 %128, label %129, label %130

129:
	br label %130

130:
	%131 = load i32, i32* %47
	%132 = load i32, i32* %1
	%133 = icmp sgt i32 %131, %132
	br i1 %133, label %134, label %135

134:
	br label %135

135:
	%136 = load i32, i32* %47
	%137 = load i32, i32* %1
	%138 = icmp slt i32 %136, %137
	br i1 %138, label %139, label %140

139:
	br label %140

140:
	%141 = load i32, i32* %47
	%142 = load i32, i32* %1
	%143 = icmp ne i32 %141, %142
	br i1 %143, label %144, label %145

144:
	br label %145

145:
	%146 = call i32 @f6()
	br label %147

147:
	call void @f2(i32 1)
	br label %148

148:
	br label %154

149:
	%150 = load i32, i32* %47
	%151 = load i32, i32* %1
	%152 = icmp ne i32 %150, %151
	br i1 %152, label %153, label %154

153:
	br label %154

154:
	br label %158

155:
	%156 = load i32, i32* %1
	%157 = icmp sgt i32 %156, 0
	br i1 %157, label %158, label %159

158:
	br label %159

159:
	%160 = load i32, i32* %47
	%161 = load i32, i32* %1
	%162 = icmp eq i32 %160, %161
	br i1 %162, label %174, label %163

163:
	%164 = load i32, i32* %1
	%165 = icmp sgt i32 %164, 0
	br i1 %165, label %166, label %175

166:
	%167 = icmp eq i32 1, 1
	br i1 %167, label %168, label %175

168:
	%169 = load i32, i32* %47
	%170 = add nsw i32 %169, 1
	%171 = srem i32 %170, 2
	%172 = sdiv i32 %171, 2	%173 = icmp ne i32 %172, 0
	br i1 %173, label %174, label %175

174:
	br label %175

175:
	ret i32 0
}
