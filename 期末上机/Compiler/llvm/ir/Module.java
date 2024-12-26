package llvm.ir;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;

import dataStructure.ASTNode.ASTNode;
import dataStructure.STT.STTStack;
import symbol.symbol;
import llvm.ir.value.Type.*;
import llvm.ir.value.inst.ReturnInst;
import llvm.ir.value.*;

public class Module {
    public static ArrayList<GlobalValue> globalValues = new ArrayList<>();
    public static ArrayList<Function> functions = new ArrayList<>();

    public static boolean globalFlag=true;

    public static int stackLevel=0;
    public static STTStack symbolStack=new STTStack(0);

    // BasicBlock globalBasicBlock;
    

    public ArrayList<GlobalValue> getGlobalValues() {
        return globalValues;
    }

    public ArrayList<Function> getFunctions() {
        return functions;
    }

    public static GlobalValue createGlobalValue(VarType type,String name,ASTNode InitVal) throws IOException {
            var newGlobalValue = new GlobalValue(type,name);
            if(InitVal!=null) newGlobalValue.createInitVal(type,InitVal);
            globalValues.add(newGlobalValue);
            return newGlobalValue;
        }
    
        public static Function createFunction(ReturnType retType,String name, ArrayList<VarType> argTypes) {
            var newFunction = new Function(retType,name, argTypes);
            functions.add(newFunction);
            return newFunction;
        }
    
        public static void output(BufferedWriter writer) throws IOException {
            writer.write("declare i32 @getint()\n" + //
                                "declare i32 @getchar()\n" + //
                                "declare void @putint(i32)\n" + //
                                "declare void @putch(i32)\n" + //
                                "declare void @putstr(i8*)\n\n");
            for (var globalVal : globalValues) {
                globalVal.output(writer);
            }
    
            for (var func : functions) {
                
                func.output(writer);
                NameAllocator.getInstance().reset();
            }
        }
        public static void main(String outputFile,ASTNode ASTRoot) throws IOException{
            orderAST(ASTRoot);
            FileWriter filewriter = new FileWriter(outputFile);
            BufferedWriter writer=new BufferedWriter(filewriter); 
            output(writer);
            writer.close();
        }
        public static void orderAST(ASTNode parent) throws NumberFormatException, IOException{
            if(parent==null) return;
            if(parent.name.equals("<MainFuncDef>")){
                // System.out.println("success");
                globalFlag=false;
                Function newFunction=createFunction(new ReturnType("int"),"main", null);
                BasicBlock newbasicblock=functions.get(functions.size()-1).createBasicBlock(newFunction,parent.children.get(4),1,null);
                newbasicblock.orderAST(parent.children.get(4));
                // System.out.println(newbasicblock.jumpIndexs.size()+" "+newbasicblock.children.size());
                symbolStack.pushStack(0, "MainFunc","Func", "main", newbasicblock,0,null);
                symbolStack.rmCurLevel(1);
                return;
            }
            else if(parent.name.equals("<Block>")){
            }
            else if(parent.name.equals("<ConstDecl>")){
                String originType=symbol.getASTNodeContent(parent,new int[] {1,0});
                int num=(parent.children.size()-2)/2;
                //Todo:globalFlag应当可以去掉
                if(globalFlag){
                    for(int i=0;i<num;i++){
                        String declName=symbol.getASTNodeContent(parent,new int[]{2*i+2,0,0});
                        if(symbol.getASTNode(parent,new int[] {2*i+2}).children.size()==3){//变量
                            // System.out.println("success");
                            VarType type=new VarType(originType);
                            String name=symbol.getASTNodeContent(parent,new int[] {2*i+2,0,0});
                            GlobalValue newGlobalValue=createGlobalValue(type,name,symbol.getASTNode(parent,new int[] {2*i+2,2}));
                            String immValue=newGlobalValue.initvals.get(0).val.value.name;
                            symbolStack.pushStack(0,originType,"Const",declName,newGlobalValue,0,immValue);
                        }
                        else{//数组
                            //TODO:数组是否需要把每个元素推入栈
                            AddExp newAddExp=new AddExp("tmpAddExp");
                            int size=Integer.valueOf(newAddExp.llvmAddExp(symbol.getASTNode(parent,new int[] {2*i+2,2,0}), null));
                            VarType type=new VarType(originType+"R",size);
                            String name=symbol.getASTNodeContent(parent,new int[] {2*i+2,0,0});
                            GlobalValue newGlobalValue=createGlobalValue(type,name,symbol.getASTNode(parent,new int[] {2*i+2,5}));
                            symbolStack.pushStack(0,originType+"Ptr","Array",declName,newGlobalValue,size,null);
                        }
                        
                    }
                }
                else{
                    
                }
                return;
            }
            else if(parent.name.equals("<VarDecl>")){
                
                String originType=symbol.getASTNodeContent(parent,new int[] {0,0});
                
                int num=(parent.children.size()-1)/2;
                if(globalFlag){
                    for(int i=0;i<num;i++){
                        String declName=symbol.getASTNodeContent(parent,new int[]{2*i+1,0,0});
                        if(symbol.getASTNodeContent(parent,new int[] {2*i+1,symbol.getASTNode(parent,new int[] {2*i+1}).children.size()-1}).equals("<InitVal>")){//有初值
                            if(symbol.getASTNode(parent,new int[] {2*i+1}).children.size()==6){//数组
                                AddExp newAddExp=new AddExp("tmpAddExp");
                                int size=Integer.valueOf(newAddExp.llvmAddExp(symbol.getASTNode(parent,new int[] {2*i+1,2,0}), null));
                                VarType type=new VarType(originType+"R",size);
                                String name=symbol.getASTNodeContent(parent,new int[] {2*i+1,0,0});
                                GlobalValue newGlobalValue=createGlobalValue(type,name,symbol.getASTNode(parent,new int[] {2*i+1,5}));
                                symbolStack.pushStack(0,originType+"Ptr","Array",declName,newGlobalValue,size,null);
                            }
                            else{//变量
                                VarType type=new VarType(originType);
                                String name=symbol.getASTNodeContent(parent,new int[] {2*i+1,0,0});
                                GlobalValue newGlobalValue=createGlobalValue(type,name,symbol.getASTNode(parent,new int[] {2*i+1,2}));
                                symbolStack.pushStack(0,originType,"Var",declName,newGlobalValue,0,null);
                            }
                        }
                        else{//无初值
                            if(symbol.getASTNode(parent,new int[] {2*i+1}).children.size()==4){//数组
                                AddExp newAddExp=new AddExp("tmpAddExp");
                                int size=Integer.valueOf(newAddExp.llvmAddExp(symbol.getASTNode(parent,new int[] {2*i+1,2,0}), null));
                                VarType type=new VarType(originType+"R",size);
                                String name=symbol.getASTNodeContent(parent,new int[] {2*i+1,0,0});
                                GlobalValue newGlobalValue=createGlobalValue(type,name,null);
                                symbolStack.pushStack(0,originType+"Ptr","Array",declName,newGlobalValue,size,null);
                            }
                            else{//变量
                                VarType type=new VarType(originType);
                                String name=symbol.getASTNodeContent(parent,new int[] {2*i+1,0,0});
                                GlobalValue newGlobalValue=createGlobalValue(type,name,null);
                                symbolStack.pushStack(0,originType,"Var",declName,newGlobalValue,0,"0");
                            }
                            
                        }
                        
                    }
                }
                else{

                }
                return;
            }
            else if(parent.name.equals("<FuncDef>")){
                ReturnType retType=new ReturnType(symbol.getASTNodeContent(parent, new int[] {0,0}));
                String funcName=symbol.getASTNodeContent(parent, new int[] {1,0});
                int paraNum=(parent.children.size()==5)?0:symbol.getASTNode(parent, new int[] {3}).children.size()/2+1;
                ArrayList<VarType> paraTypes=new ArrayList<VarType>();
                if (paraNum==0) paraTypes=null;
                String[] paraNames=new String[paraNum];
                for(int i=0;i<paraNum;i++){
                    VarType paraType=null;
                    if(symbol.getASTNode(parent, new int[] {3,2*i}).children.size()==2){
                        paraType=new VarType(symbol.getASTNodeContent(parent, new int[] {3,2*i,0,0}));
                    } 
                    else{
                        paraType=new VarType(symbol.getASTNodeContent(parent, new int[] {3,2*i,0,0})+"Ptr");
                    }
                    paraNames[i]=symbol.getASTNodeContent(parent, new int[] {3,2*i,1,0});
                    paraTypes.add(paraType);
                    // symbolStack.pushStack(1,symbol.getASTNodeContent(parent, new int[] {3,2*i,0,0})+"Para",paraName,paraType);
                }
                Function newFunction=createFunction(retType,funcName, paraTypes);
                symbolStack.pushStack(0,retType.type,"Func",funcName,newFunction,0,null);
                BasicBlock newbasicblock=functions.get(functions.size()-1).createBasicBlock(newFunction,parent.children.get(parent.children.size()-1),1,null);
                //TODO：可优化，这样时间消耗比较大
                for(int i=0;i<paraNum;i++){ 
                    Value ptr=newbasicblock.createAllocaInst(paraTypes.get(i));
                    newbasicblock.createStoreInst(paraTypes.get(i),newFunction.params.get(i), ptr);
                    symbolStack.pushStack(1,paraTypes.get(i).type,(paraTypes.get(i).type.endsWith("Ptr"))?"Array":"Var",paraNames[i],ptr,0,null);
                }
                newbasicblock.orderAST(parent.children.get(parent.children.size()-1));
                if(((newbasicblock.instructions.size()==0)||!(newbasicblock.instructions.get(newbasicblock.instructions.size()-1) instanceof ReturnInst))&&retType.type.equals("void")){
                    newbasicblock.createReturnInst(new ReturnType("void"),null);
                }
                symbolStack.rmCurLevel(1);
                return;
            }
            else if(parent.name.equals("<AddExp>")){

            }
            for(ASTNode child:parent.children){
                orderAST(child);
            }
            
        }


}