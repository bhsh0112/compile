package llvm.ir.value.inst;

import java.io.BufferedWriter;
import java.io.IOException;

import llvm.ir.value.FunctionParam;
import llvm.ir.value.Value;

public class TruncInst extends Instruction {
    Value value;

    public TruncInst(Value... operands){
        super(operands);
        value=operands[0];
        // for(Value v:operands){
		// 	v.getName();
		// }
		// super.getName();
    }
    

    public void output(BufferedWriter writer) throws IOException{
        // super.parentFunction.getName();
        writer.write("\t"+getName()+" = trunc i32 "+value.getName()+" to i8\n");
    }
}
