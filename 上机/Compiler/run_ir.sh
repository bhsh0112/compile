# 分别导出 libsysy 和 main.c 对应的的 .ll 文件
#clang -emit-llvm -S libsysy/libsysy.c -o lib.ll

# 使用 llvm-link 将两个文件链接，生成新的 IR 文件
llvm-link test.ll lib.ll -S -o out.ll

# 用 lli 解释运行
lli out.ll
