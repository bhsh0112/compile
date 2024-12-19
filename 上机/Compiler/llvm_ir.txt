declare i32 @getint()
declare i32 @getchar()
declare void @putint(i32)
declare void @putch(i32)
declare void @putstr(i8*)

define dso_local i8 @func() {
	ret i8 49
}
define dso_local i32 @main() {
	%1 = call i8 @func()
	%2 = zext i8 %1 to i32
	call void @putch(i32 %2)
	ret i32 0
}
