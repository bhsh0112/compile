package llvm.ir.value.inst;

import java.io.BufferedWriter;
import java.io.IOException;

import llvm.ir.value.Value;

public class SdivInst extends Instruction{
    public SdivInst(Value... operands) {
		super(operands);
	}

	public void output(BufferedWriter writer) throws IOException {
		// super.parentBasicBlock.getName();
		String lval=getName();
		String left = operands.get(0).getName();
		String right = operands.get(1).getName();
		writer.write("\t" + lval + " = sdiv i32 " + left + ", " + right);
	}
}
