cd ll

# 使用 llvm-link 将两个文件链接，生成新的 IR 文件
llvm-link test.ll lib.ll -S -o out.ll

# 用 lli 解释运行
lli out.ll
