package llvm.ir.value.inst;

import java.io.BufferedWriter;
import java.io.IOException;

import llvm.ir.value.Value;

public class SremInst extends Instruction{
    public SremInst(Value... operands) {
		super(operands);
		// for(Value v:operands){
		// 	v.getName();
		// }
		// super.getName();
	}

	public void output(BufferedWriter writer) throws IOException {
		// super.parentBasicBlock.getName();
		String lval=getName();
		String left = operands.get(0).getName();
		String right = operands.get(1).getName();
		writer.write("\t" + lval + " = srem i32 " + left + ", " + right+"\n");
	}
}
