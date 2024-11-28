package llvm.ir.value.inst;

import java.io.BufferedWriter;
import java.io.IOException;

import llvm.ir.value.Label;
import llvm.ir.value.Value;

public class CmpInst extends Instruction {
    String type;
    Value value1;
    Value value2;
    Label labelSameLevel;
    Label labelParentLevl;
    
    public CmpInst(String type,Value... operands){
        super(operands);
        value1=operands[0];
        value2=operands[1];
        labelSameLevel=(Label)operands[2];
        labelParentLevl=(Label)operands[3];
    }
    
    public void output(BufferedWriter writer) throws IOException{
        // super.parentBasicBlock.getName();
        Value newValue=new Value();
        writer.write("\t"+newValue.getName()+" = icmp "+type+" "+value1.getName()+", "+value2.getName());
        writer.write("\tbr i1 "+newValue.getName()+", Label "+labelSameLevel.getName()+", Label "+labelSameLevel.getName());
    }
}
