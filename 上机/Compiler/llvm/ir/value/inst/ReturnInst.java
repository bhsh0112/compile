package llvm.ir.value.inst;

import java.io.BufferedWriter;
import java.io.IOException;

import llvm.ir.value.Value;
import llvm.ir.value.Type.ReturnType;

public class ReturnInst extends Instruction{
	Value value;
	ReturnType retType;
    public ReturnInst(ReturnType returnType,Value... operands) {
		super(operands);
		if(operands.length!=0) value=operands[0];
		retType=returnType;
	}
	public void output(BufferedWriter writer) throws IOException {
		// super.parentBasicBlock.getName();
		if (operands.isEmpty()) {
			writer.write("\t" + "ret void");
		} else {
			writer.write("\t" + "ret "+retType.Type2String()+" " + value.getName());
		}
		writer.newLine();
	}
}
