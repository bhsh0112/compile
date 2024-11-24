package llvm.ir.value;


public class Argument extends Value {
    private Function parentFunction;

    public void Value(Function parentFunction){
        this.parentFunction=parentFunction;
    }
}
