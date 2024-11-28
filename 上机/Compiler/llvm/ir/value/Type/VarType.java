package llvm.ir.value.Type;

public class VarType extends Type{
    public VarType(String type){
        super(type);
        this.type=type;
    }
    public VarType(String type,int size){
        super(type,size);
    }
}
