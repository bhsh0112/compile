package llvm.ir.value;

import java.io.BufferedWriter;
import java.io.IOException;

import dataStructure.ASTNode.ASTNode;
import llvm.ir.value.Type.VarType;

public class GlobalVar extends GlobalValue{
    public VarType dataType;
    private InitVal initval;

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
        String initVal=this.initval.output(writer);
        String value;
        if(dataType.Type2String().equals("i32")&&initVal.startsWith("\'")){
            value=String.valueOf((int)(initVal.charAt(1)));
        }
        else if(dataType.Type2String().equals("i8")&&(!initVal.startsWith("\'"))){
            value=Integer.valueOf(initVal).toString();
        }
        else value=initVal;
        writer.write(dataType.Type2String()+" " +value+"\n");
    }
}
