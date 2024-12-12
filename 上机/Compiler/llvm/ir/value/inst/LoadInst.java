package llvm.ir.value.inst;

import java.io.BufferedWriter;
import java.io.IOException;

import llvm.ir.value.*;
import llvm.ir.value.Type.*;

public class LoadInst extends Instruction {
    Value value;
    public VarType dataType;

    public LoadInst(VarType dataType,Value... operands){
        super(operands);
        this.value=operands[0];
        this.dataType=dataType;
    }

    public void output(BufferedWriter writer) throws IOException{
        // super.parentBasicBlock.getName();
        String _value = this.value.getName();
		String _type = this.dataType.Type2String();
		writer.write("\t" + getName() + " = load " + _type + ", " + _type + "* " + _value+"\n");
    }

    
}
