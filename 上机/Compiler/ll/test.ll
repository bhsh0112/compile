declare i32 @getint()
declare i32 @getchar()
declare void @putint(i32)
declare void @putch(i32)
declare void @putstr(i8*)

@.str = private unnamed_addr constant [6 x i8] c"error\00", align 1
@.str.1 = private unnamed_addr constant [7 x i8] c"sucess\00", align 1
define dso_local i8 @fun() {
	ret i8 97
}
define dso_local i32 @main() {
	%1 = icmp eq i32 5436, 0
	%2 = zext i1 %1 to i32
	%3 = icmp sge i32 %2, 2
	br i1 %3, label %4, label %5

4:
	call void @putstr(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str, i64 0, i64 0))
	br label %6

5:
	call void @putstr(i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.1, i64 0, i64 0))
	br label %6

6:
	ret i32 0
}
