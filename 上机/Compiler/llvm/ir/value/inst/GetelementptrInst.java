package llvm.ir.value.inst;

import java.io.BufferedWriter;
import java.io.IOException;

import llvm.ir.value.Value;
import llvm.ir.value.Type.VarType;

public class GetelementptrInst extends Instruction {
    public VarType type;
    Value ptr;
    Value[] indexs;

    public GetelementptrInst(VarType type,Value ptr,Value[] indexs) {
        //TODO:super应加上ptr
        super(indexs);
        this.type=type;
        this.ptr=ptr;
        this.indexs=indexs;
        // ptr.getName();
        // super.getName();
    }
    
    public void output(BufferedWriter writer) throws IOException {
        // super.parentBasicBlock.getName();
        writer.write("\t"+getName()+" = getelementptr inbounds "+type.Type2String()+", "+type.Type2String()+"* "+ptr.getName());
        for(Value index:indexs){
            writer.write(", i32 "+index.getName());
        }
        writer.write("\n");
    }
}
