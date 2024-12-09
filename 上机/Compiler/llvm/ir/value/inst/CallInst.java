package llvm.ir.value.inst;

import java.io.BufferedWriter;
import java.io.IOException;

import llvm.ir.value.*;

public class CallInst extends Instruction {
    Function func;
    Value lval;

    public CallInst(Value... operands){
        super(operands);
        this.func=(Function)operands[0];
    }
    public CallInst(Value lval,Value... operands){
        super(operands);
        
        this.func=(Function)operands[0];
        this.lval=lval;
    }

    public void output(BufferedWriter writer) throws IOException{
        // super.parentBasicBlock.getName();
        if(func.name.equals("getint")){
            writer.write("\t"+lval.getName()+" = call i32 @getint()\n");
        }
        else if(func.name.equals("getchar")){
            writer.write("\t"+lval.getName()+" = call i32 @getchar()\n");
        }
        else if(func.name.equals("putint")){
            FunctionParam para=func.params.get(0);
            writer.write("\tcall void @putint(i32 "+para.getName()+")\n");
        }
        else if(func.name.equals("putch")){
            FunctionParam para=func.params.get(0);
            writer.write("\tcall void @putch(i32 "+para.getName()+")\n");
        }
        else{
            if(lval==null){
                writer.write("\tcall void "+func.getName()+"(");
                for(int i=1;i<operands.size();i++){
                    if(i!=1){
                        writer.write(", ");
                    }
                    writer.write(func.params.get(i-1).paraType.Type2String()+" "+operands.get(i).getName());
                }
                writer.write(")\n");
            }
            else{
                writer.write("\t"+lval.getName()+" = call "+func.retType.Type2String()+" "+func.getName()+"(");
                for(int i=1;i<operands.size();i++){
                    if(i!=1){
                        writer.write(", ");
                    }
                    writer.write(func.params.get(i-1).paraType.Type2String()+" "+operands.get(i).getName());
                }
                writer.write(")\n");
            }
            
        }
        // else if(func.name.equals("putstr")){
        //     //TODO:解决了数组问题之后
        // }
    }
    
}
