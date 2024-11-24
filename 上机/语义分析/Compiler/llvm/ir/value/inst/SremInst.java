package llvm.ir.value.inst;

import java.io.BufferedWriter;
import java.io.IOException;

import llvm.ir.value.Value;

public class SremInst extends Instruction{
    public SremInst(String name, Value... operands) {
		super(name, operands);
	}

	public void output(BufferedWriter writer) throws IOException {
		String left = operands.get(0).getName();
		String right = operands.get(1).getName();
		writer.write("\t" + name + " = srem i32 " + left + ", " + right);
		writer.newLine();
	}
}
