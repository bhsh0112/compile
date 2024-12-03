package llvm;

import java.util.ArrayList;
import java.util.List;

import llvm.ir.value.AddExp;
import llvm.ir.value.Label;
import llvm.ir.value.Value;

public class CondTreeNode {
    public Label selfLabel;
    public Label falseLabel;
    public Label trueLabel;
    public AddExp addExp;
    public String type;
    public CondTreeNode parent;
    public ArrayList<CondTreeNode> children;

    public CondTreeNode(Label selfLabel,AddExp addExp,String type,CondTreeNode parent) {
        this.selfLabel=selfLabel;
        this.addExp=addExp;
        this.type=type;
        this.parent=parent;
    }
    // public Label findFalseLabel(){
    //     if(parent.type.equals("and")){
    //         return this.parent.selfLabel;
    //     }
    //     else if(type.equals("or")){

    //     }
    // }

    // 添加子节点的方法
    public void addChild(CondTreeNode child) {
        children.add(child);
    }
}
