package llvm.ir.value;

import java.io.BufferedWriter;
import java.util.ArrayList;

import dataStructure.ASTNode.ASTNode;
import llvm.ir.value.Type.VarType;

public class GlobalArray extends GlobalValue{
    VarType dataType;
    AddExp size;
    ArrayList<AddExp> initVal;

    public GlobalArray(VarType type,String name) {
        super(type,name);
        this.dataType = type;
    }

    public AddExp createSize(ASTNode ASTRoot){
        size=new AddExp(ASTRoot);
        return size;
    }
    public ArrayList<AddExp> createInitVal(ASTNode InitRoot){
        if(InitRoot.children.get(0).name.equals("<StringConst>")){

        }
        return null;
    }
    public void output(BufferedWriter writer){

    }
}
