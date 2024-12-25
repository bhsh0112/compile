package llvm.ir.value;

import llvm.ir.value.*;

public class ImmediateValue extends Value{
    String val;
    public ImmediateValue(String val){
        super(val);
        this.val=val;
    }
}
