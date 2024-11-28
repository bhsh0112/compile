package llvm.ir.value.inst;

import java.io.BufferedWriter;
import java.io.IOException;
import java.util.ArrayList;

import dataStructure.ASTNode.ASTNode;
import llvm.CondTreeNode;
import llvm.ir.value.AddExp;
import llvm.ir.value.BasicBlock;
import llvm.ir.value.Label;
import llvm.ir.value.Value;
import symbol.symbol;

public class CondInst extends Instruction {
    BasicBlock basicBlock;
    ArrayList<Integer> labelIndexs=new ArrayList<>();//在每个labelIndex之后，输出一个cmo语句，一个label
    ArrayList<Label> labels=new ArrayList<>();
    ArrayList<CmpInst> cmpInstructions=new ArrayList<>();


    public CondInst(ASTNode condParent,Value... operands) throws IOException{
        super(operands);
        this.basicBlock=(BasicBlock)operands[0];
        orderCond(condParent);
    }

    public void orderCond(ASTNode parent) throws IOException{
        if(parent.children.size()!=3||parent==null) return;
        for(ASTNode child:parent.children){
            orderCond(child);
        }
        // if(parent.children.size()==3){
        //     if(parent.name.equals("LAndExp")){
        //         cmpInstructions.add(new CmpInst(labels.get(labels.size()-2),labels.get(labels.size()-1)));
        //     }
        // }
        // else if(parent.name.equals("<AddExp>")){
        //     AddExp tmpAddExp=new AddExp(basicBlock);
        //     tmpAddExp.llvmAddExp(parent, null);
        //     labels.add(new Label());
        //     labelIndexs.add(basicBlock.instructions.size()-1);
        // }

    }

    public void decideLabel(CondTreeNode parent){
        if(parent.parent.type.equals("and")){
            // parent.falseLabel=parent.parent.children.get(1).selfLabel;
        }
        for(CondTreeNode child:parent.children){
            decideLabel(child);
        }
    }
    
    @Override
    public void output(BufferedWriter writer){
        // super.parentBasicBlock.getName();

    }
}
