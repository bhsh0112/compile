package llvm.ir.value.Type;

public class VarType extends Type{
    String type;
    public VarType(String type){
        super(type);
        this.type=type;
    }
}
