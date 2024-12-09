package llvm.ir.value;

import java.io.BufferedWriter;
import java.io.IOException;

import dataStructure.ASTNode.ASTNode;
import llvm.CondTreeNode;
import symbol.symbol;

public class LOrExp extends Value {
    ASTNode lorExp;
    BasicBlock parentBasicBlock;
    public CondTreeNode CTRoot;
    public int numBasicBlock; 

    public LOrExp(BasicBlock parentBasicBlock,ASTNode lorExp) {
        this.parentBasicBlock=parentBasicBlock;
        this.lorExp = lorExp;
    }

    public CondTreeNode buildTree() throws IOException{
        CondTreeNode CTparent=new CondTreeNode(null);
        buildTreeLOrExp(CTparent,lorExp);
        return CTparent;
    }
    public void buildTreeLOrExp(CondTreeNode CTparent,ASTNode ASTparent) throws IOException{
        if(ASTparent.children.size()==3){
            CTparent.addLeftChild(new CondTreeNode(CTparent));
            buildTreeLOrExp(CTparent.leftChildren,ASTparent.children.get(0));
            CTparent.type="or";
            CTparent.addRightChild(new CondTreeNode(CTparent));
            buildTreeLAndExp(CTparent.rightChildren,ASTparent.children.get(2));
        }
        else{
            //TODO
            // CTparent.type="or";
            // CTparent.addLeftChild(new CondTreeNode(CTparent));
            buildTreeLAndExp(CTparent,ASTparent.children.get(0));
        }
    }
    public void buildTreeLAndExp(CondTreeNode CTparent,ASTNode ASTparent) throws IOException{
        if(ASTparent.children.size()==3){
            CTparent.addLeftChild(new CondTreeNode(CTparent));
            buildTreeLAndExp(CTparent.leftChildren,ASTparent.children.get(0));
            CTparent.type="and";
            CTparent.addRightChild(new CondTreeNode(CTparent));
            buildTreeEqExp(CTparent.rightChildren,ASTparent.children.get(2));
        }
        else{
            //TODO
            // CTparent.type="and";
            // CTparent.addLeftChild(new CondTreeNode(CTparent));
            buildTreeEqExp(CTparent,ASTparent.children.get(0));
        }
    }
    public void buildTreeEqExp(CondTreeNode CTparent,ASTNode ASTparent) throws IOException{
        BasicBlock basicBlock=CTparent.createBasicBlock();
        basicBlock.label=new Label(basicBlock);
        if(ASTparent.children.size()==3){
            CTparent.addLeftChild(new CondTreeNode(CTparent));
            CTparent.leftChildren.nowBasicBlock=basicBlock;
            buildTreeEqExp(CTparent.leftChildren,ASTparent.children.get(0));
            //TODO
            CTparent.type=symbol.getASTNodeContent(ASTparent, new int[] {1});
            CTparent.addRightChild(new CondTreeNode(CTparent));
            CTparent.rightChildren.nowBasicBlock=basicBlock;
            buildTreeRelExp(CTparent.rightChildren,ASTparent.children.get(2));
        }
        else{
            //TODO
            // CTparent.type=symbol.getASTNodeContent(ASTparent, new int[] {1});
            // CTparent.addLeftChild(new CondTreeNode(CTparent));
            buildTreeRelExp(CTparent,ASTparent.children.get(0));
        }
    }
    public void buildTreeRelExp(CondTreeNode CTparent,ASTNode ASTparent) throws IOException{
        if(ASTparent.children.size()==3){
            CTparent.addLeftChild(new CondTreeNode(CTparent));
            CTparent.leftChildren.nowBasicBlock=CTparent.nowBasicBlock;
            buildTreeRelExp(CTparent.leftChildren,ASTparent.children.get(0));
            //TODO
            CTparent.type=symbol.getASTNodeContent(ASTparent, new int[] {1});
            CTparent.addRightChild(new CondTreeNode(CTparent));
            CTparent.rightChildren.nowBasicBlock=CTparent.nowBasicBlock;
            buildTreeAddExp(CTparent.rightChildren,ASTparent.children.get(2));
        }
        else{
            //TODO
            // CTparent.type=symbol.getASTNodeContent(ASTparent, new int[] {1});
            // CTparent.addLeftChild(new CondTreeNode(CTparent));
            buildTreeAddExp(CTparent,ASTparent.children.get(0));
        }
    }
    public void buildTreeAddExp(CondTreeNode CTparent,ASTNode ASTparent) throws IOException{  
        // BasicBlock basicBlock=CTparent.createBasicBlock(ASTparent);
        // basicBlock.label=new Label(basicBlock);
        CTparent.type="addExp";
        CTparent.ASTNode=ASTparent;
    }

    public void buildFinalTree(CondTreeNode CTparent) throws IOException{
        if(CTparent==null) return;
        buildFinalTree(CTparent.leftChildren);
        buildFinalTree(CTparent.rightChildren);

        if(CTparent.type.equals("addExp")){
            AddExp newAddExp=new AddExp(CTparent.nowBasicBlock);
            newAddExp.llvmAddExp(CTparent.ASTNode, null);
            CTparent.value=newAddExp.value;
            CTparent.varType=newAddExp.type;
            if(CTparent.parent==null){
                if(newAddExp.value!=null){
                    if(newAddExp.value.name!=null) {
                        if(newAddExp.value.name.equals("0")) CTparent.ans="false";
                        else CTparent.ans="true";
                    }
                    else CTparent.cmpInst=CTparent.nowBasicBlock.createCmpInst("ne",newAddExp.type,newAddExp.value);
                }
            }
            else if(CTparent.parent.type.equals("and")||CTparent.parent.type.equals("or")){
                if(newAddExp.value!=null){
                    if(newAddExp.value.name!=null) {
                        if(newAddExp.value.name.equals("0")) CTparent.ans="false";
                        else CTparent.ans="true";
                    }
                    else CTparent.cmpInst=CTparent.nowBasicBlock.createCmpInst("ne",newAddExp.type,newAddExp.value);
                }
            }
        }
        //TODO:类型转换
        else if(CTparent.type.equals("<")){
            Value[] operands=new Value[2];
            operands[0]=CTparent.leftChildren.value;
            operands[1]=CTparent.rightChildren.value;
            CTparent.value=CTparent.nowBasicBlock.createCmpInst("slt",CTparent.leftChildren.varType, operands);
            CTparent.varType="int";
            CTparent.cmpInst=CTparent.value;
            CTparent.removeChildren();
        }
        else if(CTparent.type.equals(">")){
            Value[] operands=new Value[2];
            operands[0]=CTparent.leftChildren.value;
            operands[1]=CTparent.rightChildren.value;
            CTparent.value=CTparent.nowBasicBlock.createCmpInst("sgt",CTparent.leftChildren.varType, operands);
            CTparent.varType="int";
            CTparent.cmpInst=CTparent.value;
            CTparent.removeChildren();
        }
        else if(CTparent.type.equals("<=")){
            Value[] operands=new Value[2];
            operands[0]=CTparent.leftChildren.value;
            operands[1]=CTparent.rightChildren.value;
            CTparent.value=CTparent.nowBasicBlock.createCmpInst("sle",CTparent.leftChildren.varType, operands);
            CTparent.varType="int";
            CTparent.cmpInst=CTparent.value;
            CTparent.removeChildren();
        }
        else if(CTparent.type.equals(">=")){
            Value[] operands=new Value[2];
            operands[0]=CTparent.leftChildren.value;
            operands[1]=CTparent.rightChildren.value;
            CTparent.value=CTparent.nowBasicBlock.createCmpInst("sge",CTparent.leftChildren.varType, operands);
            CTparent.varType="int";
            CTparent.cmpInst=CTparent.value;
            CTparent.removeChildren();
        }
        else if(CTparent.type.equals("==")){
            Value[] operands=new Value[2];
            operands[0]=CTparent.leftChildren.value;
            operands[1]=CTparent.rightChildren.value;
            CTparent.value=CTparent.nowBasicBlock.createCmpInst("eq",CTparent.leftChildren.varType, operands);
            CTparent.varType="int";
            CTparent.cmpInst=CTparent.value;
            CTparent.removeChildren();
        }
        else if(CTparent.type.equals("!=")){
            Value[] operands=new Value[2];
            operands[0]=CTparent.leftChildren.value;
            operands[1]=CTparent.rightChildren.value;
            CTparent.value=CTparent.nowBasicBlock.createCmpInst("ne",CTparent.leftChildren.varType, operands);
            CTparent.varType="int";
            CTparent.cmpInst=CTparent.value;
            CTparent.removeChildren();
        }
    }

    public void preJudgeBasicBlocks(CondTreeNode CTparent){
        if(CTparent==null) return;
        if(CTparent.parent!=null){
            CTparent.judgeTrueBasicBlock();
            CTparent.judgeFalseBasicBlock();
        }
        if(CTparent.rightChildren!=null) preJudgeBasicBlocks(CTparent.rightChildren);
        preJudgeBasicBlocks(CTparent.leftChildren);
        
    }
    public void ostJudgeBasicBlocks(CondTreeNode CTparent){
        if(CTparent==null) return;
        ostJudgeBasicBlocks(CTparent.leftChildren);
        if(CTparent.rightChildren!=null) ostJudgeBasicBlocks(CTparent.rightChildren);
        CTparent.judgeNowBasicBlock();
    }
    public void judgeBasicBlocks(CondTreeNode CTparent){
        ostJudgeBasicBlocks(CTparent);
        preJudgeBasicBlocks(CTparent);
    }

    public void generateBrInst(CondTreeNode CTparent){
        if(CTparent.cmpInst!=null) CTparent.nowBasicBlock.createBrInst(CTparent.cmpInst,CTparent.trueBasicBlock,CTparent.falseBasicBlock);
        else if(CTparent.ans!=null){
            if(CTparent.ans.equals("true")) CTparent.nowBasicBlock.createBrInst(CTparent.trueBasicBlock);
            else CTparent.nowBasicBlock.createBrInst(CTparent.falseBasicBlock);
        } 
        // else CTparent.nowBasicBlock.createBrInst(CTparent.trueBasicBlock);
    }

    public void orderCT(CondTreeNode CTparent){
        if(CTparent==null) return;
        if(CTparent.leftChildren==null) {
            generateBrInst(CTparent);
            parentBasicBlock.children.add(CTparent.nowBasicBlock);
            numBasicBlock++;
        }
        orderCT(CTparent.leftChildren);
        orderCT(CTparent.rightChildren);
    }

    public void main(BasicBlock ifBasicBlock,BasicBlock elseBasicBlock) throws IOException{
        CTRoot=this.buildTree();
        buildFinalTree(CTRoot);
        CTRoot.trueBasicBlock=ifBasicBlock;
        CTRoot.falseBasicBlock=elseBasicBlock;
        this.judgeBasicBlocks(CTRoot);
        orderCT(CTRoot);
    }


    public void output(BufferedWriter writer) throws IOException{  
        
    }
}
