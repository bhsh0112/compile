package llvm.ir.value;

import java.io.BufferedWriter;
import java.io.IOException;

import dataStructure.ASTNode.ASTNode;
import dataStructure.STT.STTStack;
import llvm.AddTreeNode;
import symbol.symbol;

import llvm.ir.Module;

import llvm.ir.value.Value;
import llvm.ir.value.Type.ReturnType;
import llvm.ir.value.Type.Type;
import llvm.ir.value.Type.VarType;
import llvm.ir.value.inst.GetelementptrInst;

public class AddExp extends InitVal{
    String ans=null;
    Value parentValue;
    ASTNode AddExp;
    BasicBlock basicBlock=null;
    GlobalValue globalValue=null;
    public Value value;
    public String type;
    public boolean notFlag=false;

    public AddExp(String ans){
        this.ans=ans;
        //TODO:后加，是否会有其他影响？
        this.value=new Value(ans);
    }
    public AddExp(ASTNode AddExp){
        this.AddExp=AddExp;
    }
    public AddExp(BasicBlock block){
        this.basicBlock=block;
    }
    public AddExp(GlobalValue globalValue){
        this.globalValue=globalValue;
    }

    public String llvmAddExp(ASTNode parent,BufferedWriter writer) throws IOException{
        AddTreeNode AddTreeRoot=buildAddTree(parent);
        orderAT(AddTreeRoot,writer);
        value=AddTreeRoot.exp;
        return AddTreeRoot.value;
    }
    public AddTreeNode buildAddTree(ASTNode parent) throws IOException{
        AddTreeNode ans=new AddTreeNode("head");
        buildTreeAddExp(ans,parent);
        return ans;
    }
    public void buildTreeAddExp(AddTreeNode ATparent,ASTNode ASTparent) throws IOException{
        if(ASTparent.children.size()==3){
            ATparent.addChild(new AddTreeNode("tmp"));
            buildTreeAddExp(ATparent.children.get(0),ASTparent.children.get(0));
            ATparent.addChild(new AddTreeNode(symbol.getASTNodeContent(ASTparent,new int[] {1})));
            ATparent.addChild(new AddTreeNode("tmp"));
            buildTreeMulExp(ATparent.children.get(2),ASTparent.children.get(2));
        }
        else buildTreeMulExp(ATparent,ASTparent.children.get(0));
    }
    public void buildTreeMulExp(AddTreeNode ATparent,ASTNode ASTparent) throws IOException{
        if(ASTparent.children.size()==3){
            ATparent.addChild(new AddTreeNode("tmp"));
            buildTreeMulExp(ATparent.children.get(0),ASTparent.children.get(0));
            ATparent.addChild(new AddTreeNode(symbol.getASTNodeContent(ASTparent,new int[] {1})));
            ATparent.addChild(new AddTreeNode("tmp"));
            buildTreeUnaryExp(ATparent.children.get(2),ASTparent.children.get(2));
        }
        else buildTreeUnaryExp(ATparent,ASTparent.children.get(0));
    }
    public void buildTreeUnaryExp(AddTreeNode ATparent,ASTNode ASTparent) throws IOException{
        if(ASTparent.children.size()==2){
            if(symbol.getASTNodeContent(ASTparent,new int[] {0,0}).equals("-")){
                ATparent.addChild(new AddTreeNode("0"));
                ATparent.addChild(new AddTreeNode("-"));
                ATparent.addChild(new AddTreeNode("tmp"));
                buildTreeUnaryExp(ATparent.children.get(2),ASTparent.children.get(1));
            }
            else if(symbol.getASTNodeContent(ASTparent,new int[] {0,0}).equals("+")){
                ATparent.addChild(new AddTreeNode("0"));
                ATparent.addChild(new AddTreeNode("+"));
                ATparent.addChild(new AddTreeNode("tmp"));
                buildTreeUnaryExp(ATparent.children.get(2),ASTparent.children.get(1));
            }
            else if(symbol.getASTNodeContent(ASTparent,new int[] {0,0}).equals("!")){
                //TODO:是否正确地实现！的功能？
                this.notFlag=true;
                // ATparent.addChild(new AddTreeNode("tmp"));
                buildTreeUnaryExp(ATparent,ASTparent.children.get(1));
            }
            else{
                System.out.println("error\n");
            }
        }
        else if(ASTparent.children.size()==1){
            //变量名
            if(symbol.getASTNodeContent(ASTparent,new int[] {0,0}).equals("<LVal>")){//普通变量+数组名
                if(symbol.getASTNode(ASTparent, new int[] {0,0}).children.size()==1){
                    ATparent.value=symbol.getASTNodeContent(ASTparent,new int[] {0,0,0,0});
                    // ATparent.kind="Var";
                }
                else{//数组元素
                    System.out.println("success");
                    ATparent.value="ArrayElement";
                    ATparent.kind="ArrayElement";
                    String arrayName=symbol.getASTNodeContent(ASTparent,new int[] {0,0,0,0});//数组名
                    AddExp newAddExp=new AddExp(this.basicBlock);
                    newAddExp.llvmAddExp(symbol.getASTNode(ASTparent,new int[] {0,0,2,0}), null);
				    Value index=newAddExp.value;
                    int stackSize=Module.symbolStack.stack.size();
                    for(int i=stackSize-1;i>=0;i--){
                        STTStack.Element element=Module.symbolStack.stack.get(i);
                        if(element.level==0){
                            if(element.value.getName().substring(1).equals(arrayName)){
                                    Value tmpValue=new Value("0");
                                    Value newGetElementPtrInst=basicBlock.createGetElementPtrInst(new VarType(element.type.substring(0,element.type.length()-3)+"R",element.size), element.value, new Value[] {tmpValue,index});
                                    ATparent.exp=basicBlock.createLoadInst(new VarType(element.type.substring(0,element.type.length()-3)),newGetElementPtrInst);
                                    ATparent.type=element.type.substring(0,element.type.length()-3);
                                
                                
                                break;
                            } 
                        }
                        else{
                            if(element.name.equals(arrayName)){
                                if(element.size==0){//函数参数
                                    System.out.println(element.type);
                                    Value newLoadInst=basicBlock.createLoadInst(new VarType(element.type),element.value);
                                    Value newGetElementPtrInst=basicBlock.createGetElementPtrInst(new VarType(element.type.substring(0,element.type.length()-3)), newLoadInst, new Value[] {index});
                                    ATparent.exp=basicBlock.createLoadInst(new VarType(element.type.substring(0,element.type.length()-3)),newGetElementPtrInst);
                                    
                                    ATparent.type=element.type.substring(0,element.type.length()-3);
                                }
                                else{//内部变量
                                    Value tmpValue=new Value("0");
                                    Value newGetElementPtrInst=basicBlock.createGetElementPtrInst(new VarType(element.type.substring(0,element.type.length()-3)+"R",element.size), element.value, new Value[] {tmpValue,index});
                                    ATparent.exp=basicBlock.createLoadInst(new VarType(element.type.substring(0,element.type.length()-3)),newGetElementPtrInst);
                                    // Value tmpValue=new Value("0");
                                    // Value newGetElementPtrInst=basicBlock.createGetElementPtrInst(new VarType(element.type.substring(0,element.type.length()-3)+"R",element.size), element.value, new Value[] {tmpValue,tmpValue});
                                    // ATparent.exp=basicBlock.createGetElementPtrInst(new VarType(element.type.substring(0,element.type.length()-3)), newGetElementPtrInst, new Value[] {index});
                                    ATparent.type=element.type.substring(0,element.type.length()-3);
                                }
                                break;
                            } 
                        }
                        
                    }
                }
            } 
            //TODO:子表达式
            else if(symbol.getASTNodeContent(ASTparent,new int[] {0,0}).equals("(")){
                buildTreeAddExp(ATparent,symbol.getASTNode(ASTparent, new int[] {0,1,0}));
            }
            //数字、字符
            else{
                ATparent.kind="Imm";
                ATparent.value=symbol.getASTNodeContent(ASTparent,new int[] {0,0,0});
                if(ATparent.value.matches("\\d+")){
                    ATparent.value=ATparent.value;
                }
                else{
                    if(ATparent.value.charAt(1)=='\\') ATparent.value=String.valueOf((int)(ATparent.value.charAt(2)));
                    else ATparent.value=String.valueOf((int)(ATparent.value.charAt(1)));
                }
                //消除字符常量
                ATparent.type="intImm";
                ATparent.exp=new Value(ATparent.value);
            } 
        }
        else if(symbol.getASTNodeContent(ASTparent,new int[] {0}).equals("<Ident>")){//函数调用
            ATparent.value="FuncCall";
            ATparent.kind="FuncCall";
            String funcName=symbol.getASTNodeContent(ASTparent,new int[] {0,0});
            int paraNum=0;
            if(ASTparent.children.size()==3) paraNum=0;
            else paraNum=symbol.getASTNode(ASTparent,new int[] {2}).children.size()/2+1;
            Value[] operands=new Value[paraNum+1];
            if(funcName.equals("getint")){
                Value newValue=new Value();
                basicBlock.createCallInst(newValue, new Function(new ReturnType("int"), "getint", null));
                ATparent.exp=newValue;
                ATparent.type="int";
            }
            else if(funcName.equals("getchar")){
                Value newValue=new Value();
                basicBlock.createCallInst(newValue, new Function(new ReturnType("int"), "getchar", null));
                ATparent.exp=newValue;
                ATparent.type="int";
            }
            else{
                for(Function function:Module.functions){
                    if(function.name.equals(funcName)){
                        operands[0]=function;
                        break;
                    }
                }
                for(int i=0;i<paraNum;i++){
                    ASTNode paraAddExp=symbol.getASTNode(ASTparent,new int[] {2,2*i,0});
                    AddExp tmpAddExp=new AddExp(this.basicBlock);
                    tmpAddExp.llvmAddExp(paraAddExp,null);
                    operands[i+1]=tmpAddExp.value;
                }
                if(((Function)operands[0]).retType.Type2String().equals("void")){
                    ATparent.exp=basicBlock.createCallInst(null,operands);
                }
                else{
                    // Value tmpValue=new Value(((Type)((Function)operands[0]).retType).type);
                    Value newValue=new Value();
                    basicBlock.createCallInst(newValue, operands);
                    // flashType(((Type)((Function)operands[0]).retType).type);
                    ATparent.exp=newValue;
                    ATparent.type=((Type)((Function)operands[0]).retType).type;
                } 
            }
            
        }
        
         
    }
    public void flashType(AddTreeNode parent){
        type=parent.type;
    }
    public void orderAT(AddTreeNode parent,BufferedWriter writer) throws IOException{
        if(parent==null) return;
        for(AddTreeNode child:parent.children){
            orderAT(child,writer);
        }
        if(this.basicBlock==null){//全局
            if(parent.value.equals("+")||parent.value.equals("-")||parent.value.equals("*")||parent.value.equals("/")||parent.value.equals("%")) return;
            if(parent.children.size()==0){
                if(parent.value.matches("\\d+")){//数字常量
                    // flashType("intImm");
                    parent.type="intImm";
                    value=new ImmediateValue(parent.value);
                    parent.exp=value;
                }
                else if(parent.value.matches("\\'.\\'")){//字符常量
                    // flashType("charImm");

                    //TODO:这是否会有消极影响
                    // parent.type="charImm";
                    // value=new ImmediateValue(parent.value);
                    parent.type="intImm";
                    if(parent.value.charAt(1)=='\\') value=new ImmediateValue(String.valueOf((int)(parent.value.charAt(2))));
                    else value=new ImmediateValue(String.valueOf((int)(parent.value.charAt(1))));
                    parent.exp=value;
                }
                else if(parent.value.equals("FuncCall")&&parent.kind.equals("FuncCall")){
                    
                }
                else if(parent.value.equals("ArrayElement")&&parent.kind.equals("ArrayElement")){
                    //在buildtree过程中实现
                }
                else{//变量名+数组名
                    Value tmpValue=null,tmpType=null;
                    boolean tmpFlag=false;
                    // for(STTStack.Element element:Module.symbolStack.stack){
                    int stackSize=Module.symbolStack.stack.size();
                    for(int i=stackSize-1;i>=0;i--){
                        STTStack.Element element=Module.symbolStack.stack.get(i);
                        if(element.level==0){
                            if(element.value.getName().substring(1).equals(parent.value)){
                                tmpFlag=true;
                                tmpValue=element.value;
                                VarType ttType=new VarType(element.type);
                                tmpType=ttType;
                                if(element.kind.equals("Array")){//数组名
                                    Value tmptmpValue=new Value("0");
                                    parent.exp=globalValue.createGetElementPtrInst(new VarType(element.type.substring(0,element.type.length()-3)+"R",element.size), tmpValue, new Value[]{tmptmpValue,tmptmpValue});
                                    // parent.exp=basicBlock.createLoadInst(ttType, tmpValue);
                                    // parent.exp=tmpValue;
                                    parent.kind="Var";
                                    parent.type=((VarType)tmpType).type;
                                }
                                else if(element.kind.equals("Const")){
                                    parent.exp=new Value(element.immValue);
                                    parent.value=element.immValue;
                                    parent.type=(element.immValue.matches("\\d+"))?"intImm":"charImm";

                                    // System.out.println(element.immValue+" "+)
                                }
                                else{
                                    parent.exp=globalValue.createLoadInst((VarType)tmpType,tmpValue);
                                    parent.kind="Var";
                                    parent.type=((VarType)tmpType).type;
                                } 
                                
                                value=tmpValue;
                                break;
                            } 
                        }
                        else{
                            if(element.name.equals(parent.value)){
                                tmpFlag=true;
                                tmpValue=element.value;
                                VarType ttType=new VarType(element.type);
                                tmpType=ttType;
                                if(element.kind.equals("Array")){
                                    if(element.size==0){//作用域内参数
                                        parent.exp=globalValue.createLoadInst(ttType, tmpValue);
                                        parent.kind="Var";
                                    }
                                    else{//作用域内定义的数组
                                        Value tmptmpValue=new Value("0");
                                        parent.exp=globalValue.createGetElementPtrInst(new VarType(element.type.substring(0,element.type.length()-3)+"R",element.size), tmpValue, new Value[]{tmptmpValue,tmptmpValue});
                                        parent.kind="Var";
                                    }
                                    
                                    //TODO:不确定正确性
                                    // parent.type=element.type.substring(0,element.type.length()-3);
                                }
                                
                                else{
                                    parent.exp=globalValue.createLoadInst((VarType)tmpType,tmpValue);
                                    parent.kind="Var";
                                    //不确定正确性
                                    // parent.type=element.type;
                                } 
                                parent.type=((VarType)tmpType).type;
                                value=tmpValue;
                                break;
                            } 
                        }
                        
                    }
                    if(tmpFlag){
                        
                        
                    }
                    else{

                    }
                }
                
            }
            else{
                AddTreeNode left,right;
                left=parent.children.get(0);
                right=parent.children.get(2);
                if(left.type.equals("charImm")){
                    if(left.value.charAt(1)=='\\') left.value=String.valueOf((int)(left.value.charAt(2)));
                    else left.value=String.valueOf((int)(left.value.charAt(1)));
                    left.exp=new Value(left.value);
                    left.type="intImm";
                }
                if(right.type.equals("charImm")){
                    if(right.value.charAt(1)=='\\') right.value=String.valueOf((int)(right.value.charAt(2)));
                    else right.value=String.valueOf((int)(right.value.charAt(1)));
                    right.exp=new Value(right.value);
                    right.type="intImm";
                }
                if(left.type.equals("intImm")&&right.type.equals("intImm")){
                    switch(parent.children.get(1).value){
                        case "+":
                            value=new Value(String.valueOf(Integer.valueOf(left.value)+Integer.valueOf(right.value)));
                            parent.exp=value;
                            parent.value=value.name;
                            parent.type="intImm";
                            break;
                        case "-":
                            value=new Value(String.valueOf(Integer.valueOf(left.value)-Integer.valueOf(right.value)));
                            parent.exp=value;
                            parent.value=value.name;
                            parent.type="intImm";
                            break;
                        case "*": 
                            value=new Value(String.valueOf(Integer.valueOf(left.value)*Integer.valueOf(right.value)));
                            parent.exp=value;
                            parent.value=value.name;
                            parent.type="intImm";
                            break;
                        case "/":
                            value=new Value(String.valueOf(Integer.valueOf(left.value)/Integer.valueOf(right.value)));
                            parent.exp=value;
                            parent.value=value.name;
                            parent.type="intImm";
                            break;
                        case "%":
                            value=new Value(String.valueOf(Integer.valueOf(left.value)%Integer.valueOf(right.value)));
                            parent.exp=value;
                            parent.value=value.name;
                            parent.type="intImm";
                            break;
                    }
                }
                else{
                    switch(parent.children.get(1).value){
                        case "+":
                            value=globalValue.createAddInst((left.type.equals("char"))?basicBlock.createZextInst(left.exp):left.exp, (right.type.equals("char"))?basicBlock.createZextInst(right.exp):right.exp);
                            parent.exp=value;
                            parent.type="int";
                            break;
                        case "-":
                            value=globalValue.createSubInst((left.type.equals("char"))?basicBlock.createZextInst(left.exp):left.exp, (right.type.equals("char"))?basicBlock.createZextInst(right.exp):right.exp);
                            parent.exp=value;
                            parent.type="int";
                            break;
                        case "*": 
                            value=globalValue.createMulInst((left.type.equals("char"))?basicBlock.createZextInst(left.exp):left.exp, (right.type.equals("char"))?basicBlock.createZextInst(right.exp):right.exp);
                            parent.exp=value;
                            parent.type="int";
                            break;
                        case "/":
                            value=globalValue.createSdivInst((left.type.equals("char"))?basicBlock.createZextInst(left.exp):left.exp, (right.type.equals("char"))?basicBlock.createZextInst(right.exp):right.exp);    
                            parent.exp=value;
                            parent.type="int";
                            break;
                        case "%":
                            value=globalValue.createSremInst((left.type.equals("char"))?basicBlock.createZextInst(left.exp):left.exp, (right.type.equals("char"))?basicBlock.createZextInst(right.exp):right.exp);
                            parent.exp=value;
                            parent.type="int";
                            break;
                    }
                }
            }
            flashType(parent);
        }
        else{//局部
            if(parent.value.equals("+")||parent.value.equals("-")||parent.value.equals("*")||parent.value.equals("/")||parent.value.equals("%")) return;
            if(parent.children.size()==0){
                if(parent.value.matches("\\d+")){//数字常量
                    // flashType("intImm");
                    parent.type="intImm";
                    value=new ImmediateValue(parent.value);
                    parent.exp=value;
                }
                else if(parent.value.matches("\\'.\\'")){//字符常量
                    // flashType("charImm");
                    
                    //TODO:这是否会有消极影响
                    // parent.type="charImm";
                    // value=new ImmediateValue(parent.value);
                    parent.type="intImm";
                    if(parent.value.charAt(1)=='\\') value=new ImmediateValue(String.valueOf((int)(parent.value.charAt(2))));
                    else value=new ImmediateValue(String.valueOf((int)(parent.value.charAt(1))));
                    parent.exp=value;
                }
                else if(parent.value.equals("FuncCall")&&parent.kind.equals("FuncCall")){
                    
                }
                else if(parent.value.equals("ArrayElement")&&parent.kind.equals("ArrayElement")){
                    //在buildtree过程中已经处理
                }
                else{//变量名+数组名
                    Value tmpValue=null,tmpType=null;
                    boolean tmpFlag=false;
                    // for(STTStack.Element element:Module.symbolStack.stack){
                    int stackSize=Module.symbolStack.stack.size();
                    for(int i=stackSize-1;i>=0;i--){
                        STTStack.Element element=Module.symbolStack.stack.get(i);
                        if(element.level==0){
                            if(element.value.getName().substring(1).equals(parent.value)){
                                tmpFlag=true;
                                tmpValue=element.value;
                                VarType ttType=new VarType(element.type);
                                tmpType=ttType;
                                if(element.kind.equals("Array")){//数组名
                                    System.out.println(element.type);
                                    Value tmptmpValue=new Value("0");
                                    parent.exp=basicBlock.createGetElementPtrInst(new VarType(element.type.substring(0,element.type.length()-3)+"R",element.size), tmpValue, new Value[]{tmptmpValue,tmptmpValue});
                                    // parent.exp=basicBlock.createLoadInst(ttType, tmpValue);
                                    // parent.exp=tmpValue;
                                    parent.kind="Var";
                                     //TODO:不确定正确性
                                    //  parent.type=element.type.substring(0,element.type.length()-3);
                                }
                                else{
                                    
                                    parent.exp=basicBlock.createLoadInst((VarType)tmpType,tmpValue);
                                    parent.kind="Var";
                                    //不确定正确性
                                    // parent.type=element.type;
                                } 
                                parent.type=((VarType)tmpType).type;
                                value=tmpValue;
                                break;
                            } 
                        }
                        else{
                            if(element.name.equals(parent.value)){
                                tmpFlag=true;
                                tmpValue=element.value;
                                VarType ttType=new VarType(element.type);
                                tmpType=ttType;
                                if(element.kind.equals("Array")){
                                    if(element.size==0){//作用域内参数
                                        parent.exp=basicBlock.createLoadInst(ttType, tmpValue);
                                        parent.kind="Var";
                                    }
                                    else{//作用域内定义的数组
                                        Value tmptmpValue=new Value("0");
                                        System.out.println("faild:"+element.type);
                                        parent.exp=basicBlock.createGetElementPtrInst(new VarType(element.type.substring(0,element.type.length()-3)+"R",element.size), tmpValue, new Value[]{tmptmpValue,tmptmpValue});
                                        parent.kind="Var";
                                    }
                                    //TODO:不确定正确性
                                    // parent.type=element.type.substring(0,element.type.length()-3);
                                }
                                else{
                                    parent.exp=basicBlock.createLoadInst((VarType)tmpType,tmpValue);
                                    parent.kind="Var";
                                    //TODO:不确定正确性
                                    // parent.type=element.type;
                                } 
                                parent.type=((VarType)tmpType).type;
                                value=tmpValue;
                                break;
                            } 
                        }
                        
                    }
                }
                
            }
            else{
                AddTreeNode left,right;
                left=parent.children.get(0);
                right=parent.children.get(2);
                if(left.type.equals("charImm")){
                    if(left.value.charAt(1)=='\\') left.value=String.valueOf((int)(left.value.charAt(2)));
                    else left.value=String.valueOf((int)(left.value.charAt(1)));
                    left.exp=new Value(left.value);
                    left.type="intImm";
                }
                if(right.type.equals("charImm")){
                    if(right.value.charAt(1)=='\\') right.value=String.valueOf((int)(right.value.charAt(2)));
                    else right.value=String.valueOf((int)(right.value.charAt(1)));
                    right.exp=new Value(right.value);
                    right.type="intImm";
                }
                if(left.type.equals("intImm")&&right.type.equals("intImm")){
                    switch(parent.children.get(1).value){
                        case "+":
                            value=new Value(String.valueOf(Integer.valueOf(left.value)+Integer.valueOf(right.value)));
                            parent.exp=value;
                            parent.value=value.name;
                            parent.type="intImm";
                            break;
                        case "-":
                            value=new Value(String.valueOf(Integer.valueOf(left.value)-Integer.valueOf(right.value)));
                            parent.exp=value;
                            parent.value=value.name;
                            parent.type="intImm";
                            break;
                        case "*": 
                            value=new Value(String.valueOf(Integer.valueOf(left.value)*Integer.valueOf(right.value)));
                            parent.exp=value;
                            parent.value=value.name;
                            parent.type="intImm";
                            break;
                        case "/":
                            value=new Value(String.valueOf(Integer.valueOf(left.value)/Integer.valueOf(right.value)));
                            parent.exp=value;
                            parent.value=value.name;
                            parent.type="intImm";
                            break;
                        case "%":
                            value=new Value(String.valueOf(Integer.valueOf(left.value)%Integer.valueOf(right.value)));
                            parent.exp=value;
                            parent.value=value.name;
                            parent.type="intImm";
                            break;
                    }
                }
                else{
                    switch(parent.children.get(1).value){
                        case "+":
                            value=basicBlock.createAddInst((left.type.equals("char"))?basicBlock.createZextInst(left.exp):left.exp, (right.type.equals("char"))?basicBlock.createZextInst(right.exp):right.exp);
                            parent.exp=value;
                            parent.type="int";
                            break;
                        case "-":
                            value=basicBlock.createSubInst((left.type.equals("char"))?basicBlock.createZextInst(left.exp):left.exp, (right.type.equals("char"))?basicBlock.createZextInst(right.exp):right.exp);
                            parent.exp=value;
                            parent.type="int";
                            break;
                        case "*": 
                            value=basicBlock.createMulInst((left.type.equals("char"))?basicBlock.createZextInst(left.exp):left.exp, (right.type.equals("char"))?basicBlock.createZextInst(right.exp):right.exp);
                            parent.exp=value;
                            parent.type="int";
                            break;
                        case "/":
                            value=basicBlock.createSdivInst((left.type.equals("char"))?basicBlock.createZextInst(left.exp):left.exp, (right.type.equals("char"))?basicBlock.createZextInst(right.exp):right.exp);    
                            parent.exp=value;
                            parent.type="int";
                            break;
                        case "%":
                            value=basicBlock.createSremInst((left.type.equals("char"))?basicBlock.createZextInst(left.exp):left.exp, (right.type.equals("char"))?basicBlock.createZextInst(right.exp):right.exp);
                            parent.exp=value;
                            parent.type="int";
                            break;
                    }
                }
            }
            flashType(parent); 
        }
        
    }
    public String output(BufferedWriter writer) throws IOException{
        if(ans!=null) return ans;
        else{
            ans=llvmAddExp(this.AddExp, writer);
            return ans;
        }
    }
}
