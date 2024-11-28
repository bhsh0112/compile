package llvm.ir.value.inst;

import java.io.BufferedWriter;
import java.io.IOException;

import llvm.ir.value.*;
import llvm.ir.value.Type.*;

public class LoadInst extends Instruction {
    Value value;
    VarType dataType;

    public LoadInst(Value... operands){
        super(operands);
        this.value=operands[0];
        dataType=(VarType)operands[1];
    }

    public void output(BufferedWriter writer) throws IOException{
        // super.parentBasicBlock.getName();
        String _value = value.getName();
		String _type = dataType.Type2String();
		writer.write("\t" + getName() + " = load " + _type + ", " + _type + "* " + _value+"\n");
    }

    
}
