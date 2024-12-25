package llvm.ir.value.inst;

import java.io.BufferedWriter;
import java.io.Console;
import java.io.IOException;
import llvm.ir.value.Label;
import llvm.ir.value.Value;
import llvm.ir.value.BasicBlock;

public class BrInst extends Instruction {
    Value cmpInst;
    Value ifBasicBlock;
    Value elseBasicBloc;
    Value dst;

    public BrInst(Value... operands){
        super(operands);
        if(operands.length==3){
            cmpInst=operands[0];
            ifBasicBlock=operands[1];
            elseBasicBloc=operands[2];
        }
        else{
            dst=operands[0];
        }
    }
    
    public void output(BufferedWriter writer) throws IOException{
        // super.parentBasicBlock.getName();
        if(dst==null) writer.write("\tbr i1 "+cmpInst.getName()+", label "+ifBasicBlock.getName()+", label "+elseBasicBloc.getName()+"\n");
        else writer.write("\tbr label "+dst.getName()+"\n");
    }
}
