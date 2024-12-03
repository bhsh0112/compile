package llvm.ir.value.Type;

import llvm.ir.value.Value;

public class Type extends Value{
    public String type;
    public int size;
    
    public Type(String type){
        this.type=type;
    }
    public Type(String type,int size){
        this.type=type;
        this.size=size;
    }

    public String Type2String(){
        String ans;
        switch(type){
            case "int":
                return "i32";
            case "char":
                return "i8";
            case "intR":
                return "[i32 x"+size+ "]";
            case "charR":
                return "[i8 x"+size+ "]";
            case "void":
                return "void";
        }
        return null;
    }
}
