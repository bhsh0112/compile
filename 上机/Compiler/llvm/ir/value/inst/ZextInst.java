package llvm.ir.value.inst;

import java.io.BufferedWriter;
import java.io.IOException;

import llvm.ir.value.FunctionParam;
import llvm.ir.value.Value;
import llvm.ir.value.Type.VarType;


public class ZextInst extends Instruction{
    Value value;

    public ZextInst(Value... operands){
        super(operands);
        value=operands[0];
        // for(Value v:operands){
		// 	v.getName();
		// }
		// super.getName();
    }
    

    public void output(BufferedWriter writer) throws IOException{
        writer.write("\t"+getName()+" = zext i8 "+value.getName()+" to i32\n");
    }
}
