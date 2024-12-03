package llvm.ir.value;

import java.io.BufferedWriter;
import java.io.IOException;

import dataStructure.ASTNode.ASTNode;
import llvm.ir.value.Type.VarType;

public class GlobalVar extends GlobalValue{
    public VarType dataType;
    private InitVal initval;

    public GlobalVar(VarType type,String name){
        super(type,name);
        this.dataType = type;
    }
    public GlobalVar(VarType type,String name,InitVal initVal) {
        super(type,name);
        this.dataType = type;
        this.initval=initVal;
    }

    // public InitVal createInitVal(InitVal AddExp){
    //     initval = AddExp;
    //     initval.createAddExp();
    //     return initval;
    // }


    public void output(BufferedWriter writer) throws IOException{
        if(initval!=null)this.initval.output(writer);
        else writer.write("zeroinitializer");
    }
}
