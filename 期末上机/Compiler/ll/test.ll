declare i32 @getint()
declare i32 @getchar()
declare void @putint(i32)
declare void @putch(i32)
declare void @putstr(i8*)

@.str = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
define dso_local i32 @main() {
	%1 = alloca i32
	%2 = call i32 @getint()
	store i32 %2, i32* %1
	%3 = load i32, i32* %1
	call void @putint(i32 %3)
	call void @putstr(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str, i64 0, i64 0))
	ret i32 0
}
