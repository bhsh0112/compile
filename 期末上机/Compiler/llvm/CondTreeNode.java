package llvm;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import dataStructure.ASTNode.ASTNode;
import llvm.ir.value.AddExp;
import llvm.ir.value.BasicBlock;
import llvm.ir.value.Label;
import llvm.ir.value.Value;
import llvm.ir.value.Type.VarType;

public class CondTreeNode {
    public String childType;
    public String type;
    public CondTreeNode parent;
    public Value cmpInst;
    public BasicBlock trueBasicBlock;
    public BasicBlock falseBasicBlock;
    public BasicBlock nowBasicBlock;
    public BasicBlock newBasicBlock;
    public CondTreeNode leftChildren;
    public CondTreeNode rightChildren;

    public ASTNode ASTNode;
    public Value value;
    public String varType;

    public String ans=null;

    public CondTreeNode(CondTreeNode parent) {
        this.parent = parent;  
    }
    public CondTreeNode(BasicBlock trueBasicBlock,BasicBlock falseBasicBlock) {
        this.trueBasicBlock=trueBasicBlock;
        this.falseBasicBlock=falseBasicBlock;
    }
    // 添加子节点的方法
    public void addLeftChild(CondTreeNode child) {
        child.childType = "left";
        leftChildren = child;
    }
    public void addRightChild(CondTreeNode child) {
        child.childType = "right";
        rightChildren = child;
    }
    public void removeChildren(){
        leftChildren=null;
        rightChildren=null;
    }

    // public BasicBlock createBasicBlock(ASTNode addExp) throws IOException{
    //     //TODO：当前不可解决判等等问题
    //     this.nowBasicBlock=new BasicBlock();
    //     AddExp newAddExp=new AddExp(this.nowBasicBlock);
    //     newAddExp.llvmAddExp(addExp, null);
    //     if(newAddExp.value!=null){
    //         if(newAddExp.value.name!=null) {
    //             if(newAddExp.value.name.equals("0")) this.ans="false";
    //             else this.ans="true";
    //         }
    //         else this.cmpInst=this.nowBasicBlock.createCmpInst("ne",newAddExp.type,newAddExp.value);
    //     } 
    //     return this.nowBasicBlock;
    // }
    public BasicBlock createBasicBlock(){
        this.nowBasicBlock=new BasicBlock();
        return this.nowBasicBlock;
    }

    public void judgeTrueBasicBlock(){
        if(parent.type.equals("and")){
            if(this.childType.equals("left")&&parent.rightChildren!=null) this.trueBasicBlock=parent.rightChildren.nowBasicBlock;
            else this.trueBasicBlock=parent.trueBasicBlock;
        }
        else if(parent.type.equals("or")){
            this.trueBasicBlock=parent.trueBasicBlock;
        }
    }
    public void judgeFalseBasicBlock(){
        if(parent.type.equals("and")){
            this.falseBasicBlock=parent.falseBasicBlock;
        }
        else if(parent.type.equals("or")){
            if(this.childType.equals("left")&&parent.rightChildren!=null) this.falseBasicBlock=parent.rightChildren.nowBasicBlock;
            else this.falseBasicBlock=parent.falseBasicBlock;
        }
    }
    public void judgeNowBasicBlock(){
        // if(childType.equals("left")) this.nowBasicBlock=parent.nowBasicBlock;
        // else this.nowBasicBlock=parent.newBasicBlock;
        if(leftChildren!=null) this.nowBasicBlock=leftChildren.nowBasicBlock;
    }
    public void judgeNewBasicBlock(){
        if(this.rightChildren!=null) this.newBasicBlock=this.rightChildren.nowBasicBlock;
    }
    public void judgeBasicBlocks(){
        judgeTrueBasicBlock();
        judgeFalseBasicBlock();
        judgeNowBasicBlock();
        judgeNewBasicBlock();
    }
}
