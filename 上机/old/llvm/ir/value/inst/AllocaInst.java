package llvm.ir.value.inst;

import java.io.BufferedWriter;
import java.io.IOException;

import llvm.ir.value.Type.*;
import llvm.ir.value.*;

public class AllocaInst extends Instruction {
    Type dataType;

    public AllocaInst(Value... operands) {
        super(operands);
        this.dataType=(Type)operands[operands.length-1];
    }

    public Value getDataType() {
        return dataType;
    }

    public void output(BufferedWriter writer) throws IOException {
        // super.parentBasicBlock.getName();
        writer.write("\t"+getName()+" = alloca "+dataType.Type2String()+"\n");
    }

    // @Override
    // public String Type2String() {
    //     // TODO Auto-generated method stub
    //     throw new UnsupportedOperationException("Unimplemented method 'Type2String'");
    // }

    

    // public void replaceOperand(int pos, Value newOperand) {
    //     super.replaceOperand(pos, newOperand);
    // }
}
