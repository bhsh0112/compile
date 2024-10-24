def compare_files(file1, file2):
    with open(file1, 'r') as f1, open(file2, 'r') as f2:
        lines1 = f1.readlines()
        lines2 = f2.readlines()

    # 确保两个文件的行数相同
    min_len = min(len(lines1), len(lines2))

    for i in range(min_len):
        if lines1[i] != lines2[i]:
            print(f"第一个不同的行号是：{i + 1}")
            print(f"文件 {file1} 的内容：{lines1[i].strip()}")
            print(f"文件 {file2} 的内容：{lines2[i].strip()}")
            return
    # 如果所有行都相同，或者一个文件比另一个文件短
    if len(lines1) != len(lines2):
        print("文件长度不同，第一个不同的行号是：", min_len + 1)

if __name__ == "__main__":
    compare_files("Compiler/parser.txt", "Compiler/ans.txt")