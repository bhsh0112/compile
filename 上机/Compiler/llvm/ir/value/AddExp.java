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

public class AddExp extends InitVal{
    String ans=null;
    Value parentValue;
    ASTNode AddExp;
    BasicBlock basicBlock=null;
    public Value value;
    public String type;

    public AddExp(String ans){
        this.ans=ans;
    }
    public AddExp(ASTNode AddExp){
        this.AddExp=AddExp;
    }
    public AddExp(BasicBlock block){
        this.basicBlock=block;
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
                // if(llvm.getASTNodeContent(ASTparent,new int[] {1,0,0}).equals("<Number>")) ATparent.addChild(new AddTreeNode(llvm.getASTNodeContent(ASTparent,new int[] {1,0,0,0})));
                // else ATparent.addChild(new AddTreeNode(String.valueOf((int)(llvm.getASTNodeContent(ASTparent,new int[] {1,0,0,0}).charAt(1)))));
                //ATparent.addChild(new AddTreeNode(symbol.getASTNodeContent(ASTparent,new int[] {1,0,0,0})));
                ATparent.addChild(new AddTreeNode("tmp"));
                buildTreeUnaryExp(ATparent.children.get(2),ASTparent.children.get(1));
            }
            else if(symbol.getASTNodeContent(ASTparent,new int[] {0,0}).equals("+")){
                ATparent.addChild(new AddTreeNode("0"));
                ATparent.addChild(new AddTreeNode("+"));
                // if(llvm.getASTNodeContent(ASTparent,new int[] {1,0,0}).equals("<Number>")) ATparent.addChild(new AddTreeNode(llvm.getASTNodeContent(ASTparent,new int[] {1,0,0,0})));
                // else ATparent.addChild(new AddTreeNode(String.valueOf((int)(llvm.getASTNodeContent(ASTparent,new int[] {1,0,0,0}).charAt(1)))));
                // ATparent.addChild(new AddTreeNode(symbol.getASTNodeContent(ASTparent,new int[] {1,0,0,0})));
                ATparent.addChild(new AddTreeNode("tmp"));
                buildTreeUnaryExp(ATparent.children.get(2),ASTparent.children.get(1));
            }
            else{
                System.out.println("error\n");
            }
        }
        else if(ASTparent.children.size()==1){
            //变量名
            if(symbol.getASTNodeContent(ASTparent,new int[] {0,0}).equals("<LVal>")){
                if(symbol.getASTNode(ASTparent, new int[] {0,0}).children.size()==1){
                    ATparent.value=symbol.getASTNodeContent(ASTparent,new int[] {0,0,0,0});//普通变量
                    // ATparent.kind="Var";
                }
                else{//数组元素
                    ATparent.value="ArrayElement";
                    ATparent.kind="ArrayElement";
                    String arrayName=symbol.getASTNodeContent(ASTparent,new int[] {0,0,0,0});//数组名
                    AddExp newAddExp=new AddExp("tmpAddExp");
				    int index=Integer.valueOf(newAddExp.llvmAddExp(symbol.getASTNode(ASTparent,new int[] {0,0,2,0}), null));
                    int stackSize=Module.symbolStack.stack.size();
                    for(int i=stackSize-1;i>=0;i--){
                        STTStack.Element element=Module.symbolStack.stack.get(i);
                        if(element.level==0){
                            if(element.value.getName().substring(1).equals(arrayName)){
                                // Value newLoadInst=basicBlock.createLoadInst(element.value, newVarType);
                                // VarType LoadType=new VarType(element.type.substring(0,element.type.length()-3));
                                Value newGetElementPtrInst=basicBlock.createGetElementPtrInst(new VarType(element.type+"R",element.size), element.value, new int[] {0,index});
                                ATparent.exp=basicBlock.createLoadInst(new VarType(element.type),newGetElementPtrInst);
                                ATparent.type=element.type;
                                break;
                            } 
                        }
                        else{
                            if(element.name.equals(arrayName)){
                                Value ptrValue=null;
                                VarType ptrType=null;
                                Value newGetElementPtrInst=null;
                                if(element.type.endsWith("Ptr")){
                                    VarType newVarType=new VarType(element.type);
                                    ptrValue=basicBlock.createLoadInst(newVarType,element.value);
                                    ptrType=new VarType(element.type.substring(0,element.type.length()-3));
                                    newGetElementPtrInst=basicBlock.createGetElementPtrInst(ptrType, ptrValue, new int[] {index});
                                }
                                else{
                                    ptrType=new VarType(element.type+"R",element.size);
                                    ptrValue=element.value;
                                    newGetElementPtrInst=basicBlock.createGetElementPtrInst(ptrType, ptrValue, new int[] {0,index});
                                    ptrType=new VarType(element.type);
                                }
                                
                                ATparent.exp=basicBlock.createLoadInst(ptrType,newGetElementPtrInst);
                                ATparent.type=element.type;
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
            if(parent.children.size()==0){

            }
            else{
                if(parent.children.get(0).value.startsWith("%")||parent.children.get(2).value.startsWith("%")){
                    parent.value=this.getName();
                    writer.write("\t"+parent.value+ " = ");
                    switch(parent.children.get(1).value){
                        case "+":
                            writer.write("add nsw ");
                            break;
                        case "-":
                            writer.write("sub nsw ");
                            break;
                        case "*":
                            writer.write("mul nsw ");
                            break;
                        case "/":
                            writer.write("sdiv ");
                            break;
                        case "%":
                            writer.write("srem ");
                            break;
                    }
                    writer.write(parent.children.get(0).value+", "+parent.children.get(2).value+"\n");
                }
                else{
                    //TODO：数字加字符情况未解决
                    if(parent.children.get(0).value.startsWith("\'")){
                        parent.children.get(0).value=String.valueOf((int)(parent.children.get(0).value.charAt(1)));
                    }
                    if(parent.children.get(2).value.startsWith("\'")){
                        parent.children.get(2).value=String.valueOf((int)(parent.children.get(2).value.charAt(1)));
                    }
                    int num1=Integer.parseInt(parent.children.get(0).value);
                    int num2=Integer.parseInt(parent.children.get(2).value);
                    switch(parent.children.get(1).value){
                        case "+":
                            parent.value=String.valueOf(num1+num2);
                            break;
                        case "-":
                            parent.value=String.valueOf(num1-num2);
                            break;
                        case "*":
                            parent.value=String.valueOf(num1*num2);
                            break;
                        case "/":
                            parent.value=String.valueOf(num1/num2);
                            break;
                        case "%":
                            parent.value=String.valueOf(num1%num2);
                            break;
                    }
                }
            }
            
        }
        else{//局部
            if(parent.value.equals("+")||parent.value.equals("-")||parent.value.equals("*")||parent.value.equals("/")||parent.value.equals("%")) return;
            if(parent.children.size()==0){
                if(parent.value.matches("\\d+")){
                    // flashType("intImm");
                    parent.type="intImm";
                    value=new ImmediateValue(parent.value);
                    parent.exp=value;
                }
                else if(parent.value.matches("\\'.\\'")){
                    // flashType("charImm");
                    parent.type="charImm";
                    value=new ImmediateValue(parent.value);
                    parent.exp=value;
                }
                else if(parent.value.equals("FuncCall")&&parent.kind.equals("FuncCall")){
                    
                }
                else if(parent.value.equals("ArrayElement")&&parent.kind.equals("ArrayElement")){

                }
                else{
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
                                if(element.kind.equals("Array")){
                                    parent.exp=basicBlock.createGetElementPtrInst(new VarType(element.type+"R",element.size), tmpValue, new int[]{0,0});
                                    parent.kind="ArrayElement";
                                }
                                else{
                                    parent.exp=basicBlock.createLoadInst((VarType)tmpType,tmpValue);
                                    parent.kind="Var";
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
                                    parent.exp=basicBlock.createGetElementPtrInst(new VarType(element.type+"R",element.size), tmpValue, new int[]{0,0});
                                    parent.kind="ArrayElement";
                                }
                                else{
                                    parent.exp=basicBlock.createLoadInst((VarType)tmpType,tmpValue);
                                    parent.kind="Var";
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
                    left.value=String.valueOf((int)(left.value.charAt(1)));
                    left.exp=new Value(left.value);
                    left.type="intImm";
                }
                if(right.type.equals("charImm")){
                    right.value=String.valueOf((int)(right.value.charAt(1)));
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
