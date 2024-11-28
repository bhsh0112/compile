package llvm.ir.value;

import java.io.BufferedWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import dataStructure.ASTNode.ASTNode;
import llvm.ir.value.Type.*;

public class GlobalValue extends Value{
    public VarType dataType;
    public GlobalVar var=null;
    public GlobalArray array=null;
    public FormatString formatString=null;
    public AddExp size=null;
    private ArrayList<InitVal> initvals;

    public GlobalValue(){}
    public GlobalValue(VarType type,String name) {
        super(name);
        this.dataType = type;
    }

    @Override
    public String getName() {
        return "@" + super.getName();
    }

    public GlobalVar createGlobalVar(){
        if(initvals!=null) var=new GlobalVar(dataType, name,this.initvals.get(0));
        else var=new GlobalVar(dataType, name);
        return var;
    }
    public GlobalArray createGlobalArray(){
        array=new GlobalArray(dataType, name);
        return array;
    }
    public FormatString createFormatString(String str){
        formatString=new FormatString(str);
        return formatString;
    }
    public ArrayList<InitVal> createInitVal(VarType type,ASTNode AddExp){
        InitVal newInitval=new InitVal(type, AddExp);
        initvals=new ArrayList<InitVal>();
        initvals.add(newInitval);
        return initvals;
    }

    

    public void output(BufferedWriter writer) throws IOException {
        if(var!=null){
            writer.write(getName()+" = dso_local global ");
            var.output(writer);
        } 
        else if(array!=null){
            writer.write(getName()+" = dso_local global ");
            String arraySize=null;
            arraySize=size.output(writer);
            writer.write("["+arraySize+" x "+dataType.Type2String()+"]");
            array.output(writer);
            
        } 
        else{
            formatString.output(writer);
        }
        writer.write("\n");
    }
}
