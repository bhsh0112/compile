package llvm;

// import llvm.AddTreeNode;
import dataStructure.ASTNode.ASTNode;

public class llvmX {
    public static int indexVar=1;
    public static void llvmMainFuncDef(ASTNode parent){
        llvm.writeFile(llvm.outputFile, "define dso_local i32 @main()");
    }    
    public static void llvmStmt(ASTNode parent){
        if(parent.parent.parent.parent.name.equals("<MainFuncDef>")){
            if(llvm.getASTNodeContent(parent,new int[] {0}).equals("return")){
                if(llvm.getASTNodeContent(parent,new int[] {1}).equals("<Exp>")){
                    AddTreeNode AddTreeRoot=llvmAddExp(parent.children.get(1).children.get(0));
                    llvm.writeFile(llvm.outputFile,"\tret i32 "+AddTreeRoot.value+"\n");
                }
                else llvm.writeFile(llvm.outputFile,"ret i32 0\n");
            }
        }
    }
    public static AddTreeNode llvmAddExp(ASTNode parent){
        AddTreeNode AddTreeRoot=buildAddTree(parent);
        orderAT(AddTreeRoot);
        return AddTreeRoot;
    }
    public static AddTreeNode buildAddTree(ASTNode parent){
        AddTreeNode ans=new AddTreeNode("head");
        buildTreeAddExp(ans,parent);
        return ans;
    }
    public static void buildTreeAddExp(AddTreeNode ATparent,ASTNode ASTparent){
        if(ASTparent.children.size()==3){
            ATparent.addChild(new AddTreeNode("tmp"));
            buildTreeAddExp(ATparent.children.get(0),ASTparent.children.get(0));
            ATparent.addChild(new AddTreeNode(llvm.getASTNodeContent(ASTparent,new int[] {1})));
            ATparent.addChild(new AddTreeNode("tmp"));
            buildTreeMulExp(ATparent.children.get(2),ASTparent.children.get(2));
        }
        else buildTreeMulExp(ATparent,ASTparent.children.get(0));
    }
    public static void buildTreeMulExp(AddTreeNode ATparent,ASTNode ASTparent){
        // System.out.println(ASTparent.children.size());
        // System.out.println(llvm.getASTNodeContent(ASTparent,new int[] {0}));
        if(ASTparent.children.size()==3){
            ATparent.addChild(new AddTreeNode("tmp"));
            buildTreeMulExp(ATparent.children.get(0),ASTparent.children.get(0));
            ATparent.addChild(new AddTreeNode(llvm.getASTNodeContent(ASTparent,new int[] {1})));
            ATparent.addChild(new AddTreeNode("tmp"));
            buildTreeUnaryExp(ATparent.children.get(2),ASTparent.children.get(2));
        }
        else buildTreeUnaryExp(ATparent,ASTparent.children.get(0));
    }
    public static void buildTreeUnaryExp(AddTreeNode ATparent,ASTNode ASTparent){
        
        if(ASTparent.children.size()==2){
            if(llvm.getASTNodeContent(ASTparent,new int[] {0,0}).equals("-")){
                ATparent.addChild(new AddTreeNode("0"));
                ATparent.addChild(new AddTreeNode("-"));
                // if(llvm.getASTNodeContent(ASTparent,new int[] {1,0,0}).equals("<Number>")) ATparent.addChild(new AddTreeNode(llvm.getASTNodeContent(ASTparent,new int[] {1,0,0,0})));
                // else ATparent.addChild(new AddTreeNode(String.valueOf((int)(llvm.getASTNodeContent(ASTparent,new int[] {1,0,0,0}).charAt(1)))));
                ATparent.addChild(new AddTreeNode(llvm.getASTNodeContent(ASTparent,new int[] {1,0,0,0})));
            }
            else if(llvm.getASTNodeContent(ASTparent,new int[] {0,0}).equals("+")){
                ATparent.addChild(new AddTreeNode("0"));
                ATparent.addChild(new AddTreeNode("+"));
                // if(llvm.getASTNodeContent(ASTparent,new int[] {1,0,0}).equals("<Number>")) ATparent.addChild(new AddTreeNode(llvm.getASTNodeContent(ASTparent,new int[] {1,0,0,0})));
                // else ATparent.addChild(new AddTreeNode(String.valueOf((int)(llvm.getASTNodeContent(ASTparent,new int[] {1,0,0,0}).charAt(1)))));
                ATparent.addChild(new AddTreeNode(llvm.getASTNodeContent(ASTparent,new int[] {1,0,0,0})));
            }
            else{
                System.out.println("error\n");
            }
        }
        else{
            ATparent.value=llvm.getASTNodeContent(ASTparent,new int[] {0,0,0});
        }   
    }
    public static void orderAT(AddTreeNode parent){
        if(parent.children.size()!=3||parent==null) return;
        for(AddTreeNode child:parent.children){
            orderAT(child);
        }
        System.out.println(parent.children.get(0).value+" "+parent.children.get(1).value+" "+parent.children.get(2).value);
        if(parent.children.get(0).value.startsWith("%")||parent.children.get(2).value.startsWith("%")){
            parent.value="%"+indexVar++;
            llvm.writeFile(llvm.outputFile,"\t"+parent.value+ " = ");
            switch(parent.children.get(1).value){
                case "+":
                    llvm.writeFile(llvm.outputFile,"add nsw ");
                    break;
                case "-":
                    llvm.writeFile(llvm.outputFile,"sub nsw ");
                    break;
                case "*":
                    llvm.writeFile(llvm.outputFile,"mul nsw ");
                    break;
                case "/":
                    llvm.writeFile(llvm.outputFile,"sdiv ");
                    break;
                case "%":
                    llvm.writeFile(llvm.outputFile,"srem ");
                    break;
            }
            llvm.writeFile(llvm.outputFile,parent.children.get(0).value+", "+parent.children.get(2).value+"\n");
        }
        else{
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

    public static void llvmGlobalConstDecl(ASTNode parent){
        String type=(llvm.getASTNodeContent(parent,new int[] {1,0}).equals("int"))?"i32":"i8";
        int varNum=(parent.children.size()-2)/2;
        for(int i=0;i<varNum;i++){
            if(llvm.getASTNode(parent,new int[] {2*i+2}).children.size()==3){//变量
                AddTreeNode AddTreeRoot=llvmAddExp(llvm.getASTNode(parent,new int[] {2*i+2,2,0,0}));
                llvm.writeFile(llvm.outputFile,"@");
                llvm.writeFile(llvm.outputFile,llvm.getASTNodeContent(parent,new int[] {2*i+2,0,0})+" = dso_local global ");
                llvm.writeFile(llvm.outputFile,type+" ");
                String value;
                if(type.equals("i32")&&AddTreeRoot.value.startsWith("\'")){
                    value=String.valueOf((int)(AddTreeRoot.value.charAt(1)));
                }
                else if(type.equals("i8")&&(!AddTreeRoot.value.startsWith("\'"))){
                    value=Integer.valueOf(AddTreeRoot.value).toString();
                }
                else value=AddTreeRoot.value;
                llvm.writeFile(llvm.outputFile,value+"\n");
            }
            else{//数组

            }
            
        }
    }
    public static void llvmGlobalVarDecl(ASTNode parent){
        String type=(llvm.getASTNodeContent(parent,new int[] {0,0}).equals("int"))?"i32":"i8";
        int varNum=(parent.children.size()-1)/2;
        for(int i=0;i<varNum;i++){
            ASTNode VarDef=llvm.getASTNode(parent,new int[] {2*i+1});
            if(VarDef.children.get(VarDef.children.size()-1).name.equals("<InitVal>")){//有初值
                if(llvm.getASTNode(parent,new int[] {2*i+1}).children.size()==3){//变量
                    AddTreeNode AddTreeRoot=llvmAddExp(llvm.getASTNode(parent,new int[] {2*i+1,2,0,0}));
                    llvm.writeFile(llvm.outputFile,"@");
                    llvm.writeFile(llvm.outputFile,llvm.getASTNodeContent(parent,new int[] {2*i+1,0,0})+" = dso_local global ");
                    llvm.writeFile(llvm.outputFile,type+" ");
                    String value;
                    if(type.equals("i32")&&AddTreeRoot.value.startsWith("\'")){
                        value=String.valueOf((int)(AddTreeRoot.value.charAt(1)));
                    }
                    else if(type.equals("i8")&&(!AddTreeRoot.value.startsWith("\'"))){
                        value=Integer.valueOf(AddTreeRoot.value).toString();
                    }
                    else value=AddTreeRoot.value;
                    llvm.writeFile(llvm.outputFile,value+"\n");
                }
                else{//数组
    
                }
            }
            else{//无初值
                if(llvm.getASTNode(parent,new int[] {2*i+1}).children.size()==1){//变量

                }
                else{//数组

                }
            }
            
        }
    }
    public static void llvmLocalConstDecl(ASTNode parent){
        String type=(llvm.getASTNodeContent(parent,new int[] {1,0}).equals("int"))?"i32":"i8";
        int varNum=(parent.children.size()-2)/2;
        for(int i=0;i<varNum;i++){
            if(llvm.getASTNode(parent,new int[] {2*i+2}).children.size()==3){//变量
                int addrIndex=indexVar;
                llvm.writeFile(llvm.outputFile, "\t"+"%"+indexVar+++"= alloca "+type+"\n");
                AddTreeNode AddTreeRoot=llvmAddExp(llvm.getASTNode(parent,new int[] {2*i+2,2,0,0}));
                String value;
                if(type.equals("i32")&&AddTreeRoot.value.startsWith("\'")){
                    value=String.valueOf((int)(AddTreeRoot.value.charAt(1)));
                }
                else if(type.equals("i8")&&(!AddTreeRoot.value.startsWith("\'"))){
                    value=Integer.valueOf(AddTreeRoot.value).toString();
                }
                else value=AddTreeRoot.value;
                
                llvm.writeFile(llvm.outputFile, "\tstore "+type+" "+value+", "+type+"* %"+addrIndex+"\n");
                
                
            }
            else{//数组

            }
            
        } 
    }
    public static void llvmLocalVarDecl(ASTNode parent){
        String type=(llvm.getASTNodeContent(parent,new int[] {0,0}).equals("int"))?"i32":"i8";
        int varNum=(parent.children.size()-1)/2;
        for(int i=0;i<varNum;i++){
            ASTNode VarDef=llvm.getASTNode(parent,new int[] {2*i+1});
            if(VarDef.children.get(VarDef.children.size()-1).name.equals("<InitVal>")){//有初值
                if(llvm.getASTNode(parent,new int[] {2*i+1}).children.size()==3){//变量
                    int addrIndex=indexVar;
                    llvm.writeFile(llvm.outputFile, "\t"+"%"+indexVar+++"= alloca "+type+"\n");
                    AddTreeNode AddTreeRoot=llvmAddExp(llvm.getASTNode(parent,new int[] {2*i+1,2,0,0}));
                    String value;
                    if(type.equals("i32")&&AddTreeRoot.value.startsWith("\'")){
                        value=String.valueOf((int)(AddTreeRoot.value.charAt(1)));
                    }
                    else if(type.equals("i8")&&(!AddTreeRoot.value.startsWith("\'"))){
                        value=Integer.valueOf(AddTreeRoot.value).toString();
                    }
                    else value=AddTreeRoot.value;
                    llvm.writeFile(llvm.outputFile, "\tstore "+type+" "+value+", "+type+"* %"+addrIndex+"\n");
                }
                else{//数组
    
                }
            }
            else{//无初值
                if(llvm.getASTNode(parent,new int[] {2*i+1}).children.size()==1){//变量

                }
                else{//数组

                }
            }
            
        }
    }
}
