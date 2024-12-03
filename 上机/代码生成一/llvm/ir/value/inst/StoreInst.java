package llvm.ir.value.inst;

import java.io.BufferedWriter;
import java.io.IOException;

import llvm.ir.value.*;
import llvm.ir.value.Type.VarType;

public class StoreInst extends Instruction {
    Value value;
    Value ptr;
    VarType type;

    public StoreInst(Value... operands) {
        super(operands);
        this.value = operands[0];
        this.ptr = operands[1];
        this.type=(VarType)operands[2];
    }

    public Value getValue() {
        return value;
    }

    public Value getPtr() {
        return ptr;
    }

    public void output(BufferedWriter writer) throws IOException {
        // super.parentBasicBlock.getName();
        writer.write("\tstore "+type.Type2String()+" "+value.getName()+", "+type.Type2String()+"* "+ptr.getName()+"\n");
    }

}
