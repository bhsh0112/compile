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
        System.out.println("Load:"+dataType.type+" "+this);
    }

    public void output(BufferedWriter writer) throws IOException{
        // super.parentBasicBlock.getName();
        String _value = this.value.getName();
		String _type = this.dataType.Type2String();
        System.out.println(_type+" "+this);
		writer.write("\t" + getName() + " = load " + _type + ", " + _type + "* " + _value+"\n");
    }

    
}
