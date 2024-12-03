package llvm.ir.value.inst;

import java.io.BufferedWriter;
import java.io.IOException;

import llvm.ir.value.Value;

public class AddInst extends Instruction{
	public AddInst(Value... operands){
		super(operands);
	}

    // public AddInst(String name, Value... operands) {
	// 	super(name, operands);
	// }

	public void output(BufferedWriter writer) throws IOException {
		// super.parentBasicBlock.getName();
		// String lval=getName();
		String left = operands.get(0).getName();
		String right = operands.get(1).getName();
		writer.write("\t" + getName() + " = add nsw i32 " + left + ", " + right+"\n");
	}
}
