package llvm.ir.value;

import java.io.BufferedWriter;
import java.io.IOException;

import dataStructure.ASTNode.ASTNode;
import llvm.ir.value.Type.VarType;

public class InitVal extends Value {
    VarType type;
    AddExp val;
    ASTNode valRoot;

    public InitVal(){}
    public InitVal(AddExp val){
        this.val=val;
    }
    public InitVal(VarType type,AddExp val){
        this.type=type;
        this.val=val;
    }

    public InitVal(VarType type,ASTNode valRoot) {
        this.type=type;
        this.valRoot=valRoot;
        val=new AddExp(valRoot);
    }

    // public AddExp createAddExp(){
    //     val=new AddExp(valRoot);
    //     return val;
    // }

    public String output(BufferedWriter writer) throws IOException{
        return val.output(writer);
    }
}
