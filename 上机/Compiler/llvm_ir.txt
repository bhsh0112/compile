declare i32 @getint()
declare i32 @getchar()
declare void @putint(i32)
declare void @putch(i32)
declare void @putstr(i8*)

@MAX_SIZE = dso_local global i32 10
@global_var = dso_local global i32 zeroinitializer
@str = dso_local global [10 x i8] [i8 51,i8 39,i8 92,i8 0,i8 0,i8 0,i8 0,i8 0,i8 0,i8 0]
@.str = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
define dso_local i32 @main() {
	%1 = getelementptr inbounds [10 x i8], [10 x i8]* @str, i32 0, i32 2
	%2 = load i8, i8* %1
	%3 = zext i8 %2 to i32
	call void @putch(i32 %3)
	call void @putstr(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str, i64 0, i64 0))
	ret i32 0
}
