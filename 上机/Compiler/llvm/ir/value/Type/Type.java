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
                return "["+size+" x i32"+ "]";
            case "charR":
                return "["+size+" x i8"+ "]";
            case "void":
                return "void";
            case "intPtr":
                return "i32*";
            case "charPtr":
                return "i8*";
        }
        return null;
    }
}
