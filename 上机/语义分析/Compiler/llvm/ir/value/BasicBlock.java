package llvm.ir.value;

import java.io.BufferedWriter;
import java.io.IOException;
import java.util.ArrayList;

import llvm.ir.value.inst.*;

public class BasicBlock extends Value{
    private static ArrayList<Instruction> instructionList; // 该基本块中的指令
    private static Function parentFunction; // 该基本块所属的函数
    
    public BasicBlock(String name){
        super(name);
    }
    public BasicBlock(Function parentFunction){
        this.instructionList=new ArrayList<>();
        this.parentFunction=parentFunction;
    }

    public void addInstruction(Instruction value) {
		value.setParentBasicBlock(this);
		instructionList.add(value);
	}
    public ArrayList<Instruction> getInstructions() {
		return instructionList;
	}

    public void output(BufferedWriter writer) throws IOException {
		if (!useList.isEmpty()) {
			writer.write(name + ":");
			writer.newLine();
		}
		for (Value value : instructionList) {
			// value.output(writer);
		}
	}
}
