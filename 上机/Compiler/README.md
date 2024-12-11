# TODO：

- 文档从数组开始写

- char类型函数返回字符常量

  ![image-20241210093525607](/Users/shanhao/Library/Application Support/typora-user-images/image-20241210093525607.png)

- 执行下面代码出现冗余标签：(解决但不确定正确性)

  ```
  int main(){
      for(;0;){
          int a;
          if(a==1){
              break;
              printf("success");
          }
      }
      return 0;
  }
  ```

  问题：执行以下代码出现多余Br

  ```
  int main(){
      int i;
      for(;0;){
          int a=1;
          if(a==1){
              continue;
              printf("success");
          }
          int b=0;
      }
      return 0;
  }
  ```

  

- 解决冗余Br方法有误

  ①br指令错误

  ②以下代码仍存在冗余

  ```
  int main(){
      int i;
      for(;0;){
          //int a=1;
          if(1==1){
              //continue;
              printf("success");
          }
          //int b=0;
      }
      return 0;
  }
  ```

  ③执行以下代码少br指令

  ```
  int main(){
      int i;
      for(;0;){
          int a=1;
          if(a==1){
              break;
          }
          int b=0;
      }
      return 0;
  }
  ```

- Testcase4：数组index为变量名

### 1 文法解读

​		这一部分任务主要撰写测试样例，在构建样例的过程中，重点在于可以详细预读和理解文法的细节，才能够构建出具有充足覆盖度的样例

​		在这一部分，只需要详细阅读文法规则，设计语句遍历所有情况即可

### 2 词法分析

#### 2.1 任务分析

​		这一部分任务，主要将读到的代码内容划分为token，再判断每一个token的词法成分并输出

#### 2.2 token划分

​		我这里采用的token划分方式较为简单，但存在潜在风险

​		我构建出如下的匹配模式：

```java
String patternString = 
            "(\\b(main|const|int|char|break|continue|if|else|for|return|void|while)\\b)|" + // 关键字
            "(\\b(getint|getchar|printf)\\b)|"+//函数
            "(\\b[a-zA-Z_][a-zA-Z0-9_]*\\b)|" + // 标识符
            "(\\b\\d+\\b)|" + // 常量
            "(\".*?\")|" +
            "(//)|"+//单行注释
            "(==|!=|<=|>=|<|>|&&|\\|\\||=|\\+|-|/\\*|\\*/|/\\*|\\*/|\\*|/|%|\\{|\\}|\\(|\\)|\\[|\\]|;|,|&|!|\\|)|" + // 操作符
            "(\'(\\\\.|[^\\'])\')|"+
            "(\\s+)"; // 空白字符
```

​		并利用内置函数对所读文本进行token匹配

```java
Pattern pattern = Pattern.compile(patternString);
Matcher matcher = pattern.matcher(code);
```

​		经过如下简单处理后，即课输出一个完整的字符串数组用于存储所有token

```java
while (matcher.find()) {
            if(matcher.group().equals("/*")){
                zhuflag=true;
            }
            if(matcher.group().equals("*/")){
                zhuflag=false;
                continue;
            }
            if(matcher.group().equals("//")&&!zhuflag) break;
            if (!matcher.group().matches("\\s+")&&!zhuflag) { // 忽略空白字符
                tokens.add(matcher.group());
            }
        }
```

​			上述代码，即构成了我的tokenize函数

#### 2.3 词法成分分析

​		我把所有词法分析分为两类，关键字和其他其他成分(**Ident**,**IntConst**,**StringConst**,**CharConst**)

​		对于关键字，我建立了如下字典

```java
private static final Map<String, String> words = new HashMap<>();
static {
        words.put("main", "MAINTK");
        words.put("const", "CONSTTK");
        words.put("int", "INTTK");
        words.put("char", "CHARTK");
        words.put("break", "BREAKTK");
        words.put("continue", "CONTINUETK");
        words.put("if", "IFTK");
        words.put("else", "ELSETK");
        words.put("for", "FORTK");
        words.put("getint", "GETINTTK");
        words.put("getchar", "GETCHARTK");
        words.put("printf", "PRINTFTK");
        words.put("return", "RETURNTK");
        words.put("void", "VOIDTK");
        words.put(";", "SEMICN");
        words.put("!", "NOT");
        words.put("*", "MULT");
        words.put(",", "COMMA");
        words.put("&&", "AND");
        words.put("||", "OR");
        words.put("/", "DIV");
        words.put("%", "MOD");
        words.put("(", "LPARENT");
        words.put(")", "RPARENT");
        words.put("[", "LBRACK");
        words.put("]", "RBRACK");
        words.put("{", "LBRACE");
        words.put("}", "RBRACE");
        words.put("<", "LSS");
        words.put("<=", "LEQ");
        words.put(">", "GRE");
        words.put(">=", "GEQ");
        words.put("==", "EQL");
        words.put("!=", "NEQ");
        words.put("+", "PLUS");
        words.put("-", "MINU");
        words.put("=", "ASSIGN");
    }
```

​		用于判断其语法成分

​		对于其他成分，我则为每一成分写了一个判断函数，以正则匹配为原理，判断一个token是否属于该成分

​		以Ident为例：

```java
    private static boolean isIdentifier(String token) {
        return token.matches("[a-zA-Z_][a-zA-Z0-9_]*");
    }
```

#### 2.4 代码架构

​		结合上述两个部分，首先对读入文件进行逐行token划分，再遍历所有token，逐个判断其词法成分，即完成了这部分任务

### 3 语法分析

#### 3.1 任务分析

​		这一部分任务，主要根据词法分析结果，将阅读到的程序内容，按照题设语法规则，构建出一课语法树，并按照要求输出语法树存储的信息

#### 3.2 一次错误的尝试

​		由于题目阅读不清和自己的错误判断，我的第一次尝试，采用了一种有问题的思路。由于我认为其问题值得在日后借鉴，所以首先记录这种错误的思路。

​		在这种思路下，我并未直接构建语法树，而希望通过一系列函数去模拟语法树的构建，建立一套具有普适性的语法成分判断体系。

​		然而很快，我就发现了这种思路的问题：

第一，不能构建出语法树，这在之后的代码中需要使用

第二，这种“普适性的语法成分判断体系”并不存在或难以建立，语法成分判断依旧需要通过“预读”的方式，通过建立理论课中提到过的“first”串来判断语法成分

#### 3.3 思路矫正

​		通过回顾理论课知识，我的代码思路最终得到了矫正，整体思路如下：

- 对token进行依次遍历，依照语法，将代码构建为一个语法树
- 对于语法成分判断问题，采用“预读”的方式实现“first”串，依次对语法成分进行选择，在题设语法中，除去特殊情况，大部分判断可以被预读的2个token实现
- 后序遍历语法树，即可正确地按要求输出结果

#### 3.4 代码架构

​		代码主要可以分为以下几个部分：

- tokenize函数，用于将输入文本划分为token
- 词法分析判断函数，函数名为“is+词法成分”
- 主函数，主要是词法分析的部分，添加调用语法分析入口函数
- 语法分析的“建树”函数，函数名为”parser+语法成分“，主要是一系列相互调用的函数，用于构建语法树
- 语法分析的判断函数，函数名为“is+语法成分”，主要用于语法成分判断
- 与树结构本身相关的函数，主要有addNode,insertNode,deletNode和postTraversal四个函数，用于操作树结构本身

​		除此之外，为方便搭建语法树，我还定义了一个树节点的结构，定义源码存储在“dataStructure”文件夹下，定义了树节点的结果，主要定义了三种节点：ENode(错误节点)，NNode(非终结符节点，用于存语法成分)，TNode（终结符节点，用于存token）

### 期中考试

烂！！！！！！

**问题一**

​	debug思路有问题，不够清晰，导致debug方向错误，浪费大量时间做无用功。这或许是因为考试紧张导致的。

​	此能力日积月累形成，无法速成，多写代码！！！！



### 4 语义分析

​	改栈式更快一点

### 5 中间代码生成一（LLVMIR）

#### 5.1 文件结构

本次任务的代码主体在llvm文件夹下，**代码顶层接口为`llvm.ir.Module.main`**

llvm文件结构如下：

```
--llvm
	  |----AddTreeNode.java（特殊结构AddTree的结点定义）
	  |____ir
	  		  |----NameAllocator.java（Value编号）
	  		  |----StrNameAllocator.java（printf用字符串的名字编号）
	  		  |----Moudle.java（llvm的顶层模块）
	  		  |____value
	  		  			 |----AddExp.java（处理语法树中的AddExp结点）
	  		  			 |----BasicBlock.java（处理Block）
	  		  			 |----FormatString.java（处理printf定义的全局字符串）
	  		  			 |----Function.java（处理函数定义，包括main函数）
	  		  			 |----FunctionParam.java（处理函数参数）
	  		  			 |----GlobalArray.java（处理全局数组，继承自GlobalValue）
	  		  			 |----GlobalValue.java（处理全局变量）
	  		  			 |----GlobalVar.java（处理全局非数组变量，继承自GlobalValue）
	  		  			 |----ImmediateValue.java（处理立即数，包括数字常量和字符常量）
	  		  			 |----InitVal.java（处理变量定义的初值）
	  		  			 |----Label.java（处理标签）
	  		  			 |----StringConst.java（处理字符串常量）
	  		  			 |----Use.java
	  		  			 |----User.java
	  		  			 |----Value.java（一切皆Value，所有类的父类）
	  		  			 |----inst（LLVM的每种指令一个类）
	  		  			 |			|----AddInst.java
	  		  			 |			|----AllocaInst.java
	  		  			 |			……
	  		  			 |____Type
	  		  			 				|----Type.java（父类）
	  		  			 				|----ReturnType.java（返回值类型）
	  		  			 				|____VarType.java（变量类型）
```



#### 5.2 体系结构

- Module

  - 全局量（Global Value）
    - 常量
    - 变量

  - 函数定义（Function，包括其他函数和main函数）
    - Block（BasicBlock）
      - 各类指令



​		因此，全局量和函数定义在顶层类Moudle中处理，函数定义中只处理BasicBlock，各类指令在BasicBlock中处理。

#### 5.3 具体实现

​		由上可知，顶层module模块中只需要实现对全局变量和函数定义的处理即可。因此在module中设置两个ArrayList属性，分别记录全局变量和函数定义

```java
public static ArrayList<GlobalValue> globalValues = new ArrayList<>();
public static ArrayList<Function> functions = new ArrayList<>();
```

##### 5.3.1 全局变量

​		根据sysy语法，为module添加正确的GlobalValue实例即可

##### 5.3.2 函数定义

​		与上面类似的，根据sysy语法，为module添加正确的Function实例即可，这里不同前面，需要对参数进行分析，主要过程如下：

```java
ReturnType retType=new ReturnType(symbol.getASTNodeContent(parent, new int[] {0,0}));
String funcName=symbol.getASTNodeContent(parent, new int[] {1,0});
int paraNum=(parent.children.size()==5)?0:symbol.getASTNode(parent, new int[] {3}).children.size()/2+1;
ArrayList<VarType> paraTypes=new ArrayList<VarType>();
if (paraNum==0) paraTypes=null;
String[] paraNames=new String[paraNum];
for(int i=0;i<paraNum;i++){
  VarType paraType=new VarType(symbol.getASTNodeContent(parent, new int[] {3,2*i,0,0}));
  paraNames[i]=symbol.getASTNodeContent(parent, new int[] {3,2*i,1,0});
  paraTypes.add(paraType);
// symbolStack.pushStack(1,symbol.getASTNodeContent(parent, new int[] {3,2*i,0,0})+"Para",paraName,paraType);
}
Function newFunction=createFunction(retType,funcName, paraTypes);
symbolStack.pushStack(0,retType+"Func",funcName,newFunction);
```

​		同时，我们需要继续处理函数定义的Block内部的代码：

​		这里在参数处理方面，第一版采用了较蠢的处理方法，即在block的一开始，先对所有参数进行Alloca和Store，这实际上是一个很轻松就可以优化的点。

​		另外，之所以在这里才将参数推进栈式符号表，是为了保证在符号表中先推入函数再推入对应参数。

```java
BasicBlock newbasicblock=functions.get(functions.size()-1).createBasicBlock(newFunction,parent.children.get(parent.children.size()-1),1,null);
//TODO：可优化，这样时间消耗比较大
for(int i=0;i<paraNum;i++){ 
  Value ptr=newbasicblock.createAllocaInst(paraTypes.get(i));
  newbasicblock.createStoreInst(newFunction.params.get(i), ptr, paraTypes.get(i));
  symbolStack.pushStack(1,paraTypes.get(i).type,paraNames[i],ptr);
}
newbasicblock.orderAST(parent.children.get(parent.children.size()-1));
symbolStack.rmCurLevel(1);
```

##### 5.3.3 局部变量定义

```
Module->basicBlock->AddExp->xxInst
```

​	**需要添加的指令：`alloca+处理AddExp+store`**

##### 5.3.4 赋值语句(不包含函数调用)

​	**需要添加的指令：`load+处理AddExp+store`**

##### 5.3.5 函数调用

###### 库函数

​	**需要添加的指令：`getint/getchar:左值相关指令+call`**

​									**`printf:全局formatstring+处理AddExp{+putint}{+putch`}**

###### 自定义函数

​	**需要添加的指令：`[左值相关指令+][处理AddExp+]call`**

##### 5.3.6 返回

​	**需要添加的指令：`处理AddExp+return`**

##### 5.3.7 数组

##### 5.3.8 if语句

##### 5.3.9 for语句

为缕清思路，首先列出所有缺省情况的流程图

![image-20241210105721900](/Users/shanhao/Library/Application Support/typora-user-images/image-20241210105721900.png)

设控制流入口基本块为entranceBasicBlock，每个子基本块(上述每个方框的基本块是子基本块，其中Cond可能为多个基本块)存在一个nextBasicBlock

汇总不难看出，

```
对于缺省：

- 缺省forStmt1对控制流无影响，因此我们可以把forStmt划在控制流之外，即forStmt1不可以作为entranceBasicBlock
- 缺省Cond只影响entranceBasicBlock，若不缺省，则entranceBasicBlock为Cond，否则为Stmt
- 缺省forStmt2只影响Stmt的nextBasicBlock，若不缺省，则Stmt的nextBasicBlock为forStmt2，否则为entranceBasicBlock

对于break和continue的作用

- break永远直接跳到BasicBlock
- continue让Stmt直接跳到它的nextBasicBlock
```



#### 5.4 对AddExp的处理

​	由于代码中涉及广泛的对AddExp处理的需求，所以我建立了一个AddExp类，专门用于处理AddExp

​	处理思路如下：

- 把语法树转为特定结构AddTree，结点定义如下：

  ```java
  public class AddTreeNode {
      public String value; // 节点存储的字符串
      public List<AddTreeNode> children; // 子节点列表
      public Value exp;
      public String type;
  
      public AddTreeNode(String value) {
          this.value = value;
          this.children = new ArrayList<>();
      }
  
      // 添加子节点的方法
      public void addChild(AddTreeNode child) {
          children.add(child);
      }
  }
  ```

​		在处理过程中，会面临四种情况：立即数、变量、函数调用前三者的运算式

​		立即数直接求值（对立即数间的运算，直接算出结果），变量遍历符号表，函数调用遍历函数表

​		最终得到一个三叉树，每个父节点保证有三个子节点，其中中间的为操作符，两侧的为操作数，操作数可能为以上四种的任意一种，具体解释如下：

​		1.立即数：value为立即数的值，exp为对应value

​		2.变量：value为变量名，exp为Load指令对应value

​		3.函数调用：value为func，exp为call指令对应的value

​		4.运算式：value初始为tmpp，在遍历AddTree的过程中，根据子节点情况生成

​		同时，所有结点的数据会被分为：int、char、intimm、charimm用于

- 遍历AddTree

  后序遍历，根据操作符、操作数进行指定输出即可

  每次遍历通过`flashType()`函数刷新AddExp的type属性：

  ```java
  public void flashType(AddTreeNode parent){
  		type=parent.type;
  }
  ```

​		需要注意的是，一旦涉及字符运算，就可以将字符立即数转为整形，如果是字符变量，进行类型转换

​		这里处理的逻辑，只要进入运算，先把所有字符常量（charImm）转为整形常量（intImm），如果左右两个节点类型都为intImm，

则直接计算得到父结点value，否则父结点一定为运算式，进行类型判断、计算指令添加即可：

```java
AddTreeNode left,right;
left=parent.children.get(0);
right=parent.children.get(2);
if(left.type.equals("charImm")){
  left.value=String.valueOf((int)(left.value.charAt(1)));
  left.exp=new Value(left.value);
  left.type="intImm";
}
if(right.type.equals("charImm")){
  right.value=String.valueOf((int)(right.value.charAt(1)));
  right.exp=new Value(right.value);
  right.type="intImm";
}
System.out.println(left.value+" "+right.value);
if(left.type.equals("intImm")&&right.type.equals("intImm")){
  switch(parent.children.get(1).value){
    case "+":
      value=new Value(String.valueOf(Integer.valueOf(left.value)+Integer.valueOf(right.value)));
      parent.exp=value;
      parent.value=value.name;
      parent.type="intImm";
      break;
    //...
  }
}
else{
  switch(parent.children.get(1).value){
    case "+":
      value=basicBlock.createAddInst((left.type.equals("char"))?basicBlock.createZextInst(left.exp):left.exp, (right.type.equals("char"))?basicBlock.createZextInst(right.exp):right.exp);
      parent.exp=value;
      parent.type="int";
      break;
    //...
  }
}
```



#### 5.5 类型转换问题

##### 5.5.1 转换逻辑

​	变量类型存在：int、char、intImm、charImm四种可能

​	以下为例：

```java
if(((VarType)tmpType).type.equals("int")&&tmpAddExp.type.equals("char")) from=createZextInst(from);
else if(((VarType)tmpType).type.equals("char")&&tmpAddExp.type.equals("int")) from=createTruncInst(from);
else if(((VarType)tmpType).type.equals("int")&&tmpAddExp.type.equals("charImm")){
	from.name=String.valueOf((int)(from.name.charAt(1)));
}
```

​	只存在以上三种类型转换可能，其中字符立即数和整形立即数间可以相互转换，不必进行立即数

##### 5.5.2 可能出现的场景

​	变量声明、AddExp处理、赋值语句、Printf、Return

# 
