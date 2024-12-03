package llvm.ir.value.inst;

import java.io.BufferedWriter;
import java.io.Console;
import java.io.IOException;
import llvm.ir.value.Label;
import llvm.ir.value.Value;
import llvm.ir.value.BasicBlock;

public class BrInst extends Instruction {
    CondInst cond;
    Label labelIf;
    Label labelElse;
    BasicBlock stmtIf;
    BasicBlock stmtElse;

    public BrInst(Value... operands){
        super(operands);
        cond=(CondInst)operands[0];
        labelIf=(Label)operands[1];
        labelElse=(Label)operands[2];
        stmtIf=(BasicBlock)operands[3];
        stmtElse=(BasicBlock)operands[4];
    }
    
    public void output(BufferedWriter writer) throws IOException{
        // super.parentBasicBlock.getName();
        cond.output(writer);
        if(stmtElse!=null) stmtElse.output(writer);
        writer.write("\tbr label "+labelElse.getName()+"\n");
        labelElse.output(writer);
        writer.write("\tbr label "+labelIf.getName()+"\n");
        labelIf.output(writer);
        stmtIf.output(writer);
        labelElse.output(writer);

    }
}
