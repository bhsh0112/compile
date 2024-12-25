## 允许`for(int i=0;;)`

假设是ForStmt允许有BType

- 语法

  - forStmt判断条件

    ![image-20241225201125490](/Users/shanhao/Library/Application Support/typora-user-images/image-20241225201125490.png)

  - 解析forStmt加入

    ![image-20241225201320874](/Users/shanhao/Library/Application Support/typora-user-images/image-20241225201320874.png)

    else后跟原本的部分

- 语义

  ## 

  - 添加一个全局变量forStmtElement用于存储forStmt中声明的变量

  - 对block的处理中添加

    ![image-20241225203657852](/Users/shanhao/Library/Application Support/typora-user-images/image-20241225203657852.png)

  - 对ForStmt的处理中添加

    ![image-20241225203657852](/Users/shanhao/Library/Application Support/typora-user-images/image-20241225203657852.png)

    

    

- 代码生成

  - BasicBlock类加入属性`isForStmt1`

  - 遍历ForStmst1时该属性置为true

  - 对于for后无Block的情况，特殊的删除符号表内容

    ![image-20241225210541145](/Users/shanhao/Library/Application Support/typora-user-images/image-20241225210541145.png)

  - 在解析VarDecl时，加入如下代码，以特殊处理ForStmt中声明变量的符号表层级

    ![image-20241225210838455](/Users/shanhao/Library/Application Support/typora-user-images/image-20241225210838455.png)