package llvm.ir.value.Type;

public class ReturnType extends Type {
    public String type;

    public ReturnType(String type){
        super(type);
        this.type=type;
    }

}
