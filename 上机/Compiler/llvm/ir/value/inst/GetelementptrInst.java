package llvm.ir.value.inst;

import java.io.BufferedWriter;
import java.io.IOException;

import llvm.ir.value.Value;
import llvm.ir.value.Type.VarType;

public class GetelementptrInst extends Instruction {
    VarType type;
    Value ptr;
    int[] indexs;

    public GetelementptrInst(VarType type,Value ptr,int[] indexs) {
        this.type=type;
        this.ptr=ptr;
        this.indexs=indexs;

    }
    
    public void output(BufferedWriter writer) throws IOException {
        // super.parentBasicBlock.getName();
        writer.write("\t"+getName()+" = getelementptr inbounds "+type.Type2String()+", "+type.Type2String()+"* "+ptr.getName());
        for(int index:indexs){
            writer.write(", i32 "+index);
        }
        writer.write("\n");
    }
}
