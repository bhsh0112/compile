package llvm.ir.value;

import java.io.BufferedWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import dataStructure.ASTNode.ASTNode;
import llvm.ir.value.Type.*;

public class GlobalValue extends Value{
    private final VarType dataType;
    public GlobalVar var=null;
    public GlobalArray array=null;
    private InitVal initval;

    public GlobalValue(VarType type,String name) {
        super(name);
        this.dataType = type;
    }

    @Override
    public String getName() {
        return "@" + super.getName();
    }

    public GlobalVar createGlobalVar(){
        var=new GlobalVar(dataType, name,this.initval);
        return var;
    }
    public GlobalArray createGlobalArray(){
        array=new GlobalArray(dataType, name);
        return array;
    }
    public InitVal createInitVal(VarType type,ASTNode AddExp){
        initval=new InitVal(type, AddExp);
        return initval;
    }

    

    public void output(BufferedWriter writer) throws IOException {
        writer.write(getName()+" = dso_local global ");
        if(var!=null) var.output(writer);
        else array.output(writer);
    }
}
