package llvm.ir.value.inst;

import java.io.BufferedWriter;
import java.io.IOException;

import llvm.ir.value.BasicBlock;
import llvm.ir.value.User;
import llvm.ir.value.Value;
// import llvm.ir.value.Type.*;

// 具体的User子类，例如Instruction
public abstract class Instruction extends User {
    // private InstructionType instructionType;
    public BasicBlock parentBasicBlock;
    
    public Instruction(){}
    public Instruction(Value[] operands) {
        super(operands);
    }
    public Instruction(String name,Value[] operands){
        super(name,operands);
    }

    // public Instruction(InstructionType instructionType,BasicBlock parentBasicBlock){
    //     this.instructionType=instructionType;
    //     this.parentBasicBlock=parentBasicBlock;
    // }

    public void setParentBasicBlock(BasicBlock basicBlock){
        this.parentBasicBlock=basicBlock;
    }
    public BasicBlock getBasicBlock() {
		return parentBasicBlock;
	}
    public abstract void output(BufferedWriter writer) throws IOException;
}
