cd ll

# 分别导出 test.c 对应的的 .ll 文件
clang -emit-llvm -S test.c -o main.ll

# 使用 llvm-link 将两个文件链接，生成新的 IR 文件
llvm-link main.ll lib.ll -S -o out.ll

# 用 lli 解释运行
lli out.ll
