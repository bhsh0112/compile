package llvm.ir.value.Type;

import llvm.ir.value.Value;

public class Type extends Value{
    public String type;
    
    public Type(String type){
        this.type=type;
    }

    public String Type2String(){
        String ans;
        switch(type){
            case "int":
                return "i32";
            case "char":
                return "i8";
        }
        return null;
    }
}
