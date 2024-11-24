package llvm.ir.value.inst;

import java.io.BufferedWriter;
import java.io.IOException;

import llvm.ir.value.Value;

public class ReturnInst extends Instruction{
    public ReturnInst(Value... operands) {
		super(operands);
	}
	public void output(BufferedWriter writer) throws IOException {
		if (operands.isEmpty()) {
			writer.write("\t" + "ret void");
		} else {
			String operand = operands.get(0).getName();
			writer.write("\t" + "ret i32 " + operand);
		}
		writer.newLine();
	}
}
