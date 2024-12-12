package llvm.ir.value;

import java.io.BufferedWriter;
import java.io.IOException;

import dataStructure.ASTNode.ASTNode;
import llvm.ir.value.Type.VarType;

public class InitVal extends Value {
    VarType type;
    public AddExp val;
    ASTNode valRoot;
    String ans;

    public InitVal(){}
    public InitVal(AddExp val){
        this.val=val;
    }
    public InitVal(VarType type,AddExp val){
        this.type=type;
        this.val=val;
    }

    public InitVal(VarType type,ASTNode valRoot,GlobalValue globalValue) {
        this.type=type;
        this.valRoot=valRoot;
        this.val=new AddExp(globalValue);
    }
    public InitVal(VarType type,String ans) {
        this.type=type;
        this.ans=ans;
        this.val=new AddExp(ans);
    }

    public void orderAddExp() throws IOException{
        this.val.llvmAddExp(valRoot, null);
    }


    public String output(BufferedWriter writer) throws IOException{
        Value finalValue=null;
        if (ans != null) {
            finalValue=new Value(ans);
        }
        else{
            // str=val.output(writer);
            finalValue=this.val.value;

        } 
        if(finalValue.name!=null&&finalValue.name.startsWith("\'")){
            // System
            finalValue.name=String.valueOf((int)(finalValue.name.charAt(1)));
        }
        //TODO:调价似乎需要更改
        else if(type.Type2String().equals("i8")&&finalValue.name!=null&&(!finalValue.name.startsWith("\'"))){
            finalValue.name=Integer.valueOf(finalValue.name).toString();
        }
        writer.write(type.Type2String()+" " +finalValue.getName());
        return finalValue.name;
    }
}
