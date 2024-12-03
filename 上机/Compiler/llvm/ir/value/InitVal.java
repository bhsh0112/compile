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


    public String output(BufferedWriter writer) throws IOException{
        String str=val.output(writer);
        String value;
        if(type.Type2String().equals("i32")&&str.startsWith("\'")){
            value=String.valueOf((int)(str.charAt(1)));
        }
        else if(type.Type2String().equals("i8")&&(!str.startsWith("\'"))){
            value=Integer.valueOf(str).toString();
        }
        else value=str;
        writer.write(type.Type2String()+" " +value);
        return str;
    }
}
