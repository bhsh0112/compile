package llvm.ir.value.inst;

import java.io.BufferedWriter;
import java.io.IOException;

import llvm.ir.value.Label;
import llvm.ir.value.Value;
import llvm.ir.value.Type.VarType;

public class CmpInst extends Instruction {
    String type;
    String varType;
    Value value1;
    Value value2;
    Label labelSameLevel;
    Label labelParentLevl;
    
    public CmpInst(String type,String varType,Value... operands){
        super(operands);
        this.type=type;
        this.varType=varType;
        this.value1=operands[0];
        if(operands.length>1)value2=operands[1];
        // for(Value v:operands){
		// 	v.getName();
		// }
		// super.getName();
        // labelSameLevel=(Label)operands[2];
        // labelParentLevl=(Label)operands[3];
    }
    
    public void output(BufferedWriter writer) throws IOException{
        // super.parentBasicBlock.getName();
        if(value2==null){
            String tmpType=(varType.equals("char")||varType.equals("charImm"))?"i8":"i32";
            writer.write("\t"+getName()+" = icmp "+type+" "+tmpType+" "+value1.getName()+", 0\n");
        }
        else{
            writer.write("\t"+getName()+" = icmp "+type+" "+value1.getName()+", "+value2.getName()+"\n");
        }
        
    }
}
