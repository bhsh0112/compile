package llvm.ir.value.inst;

import java.io.BufferedWriter;
import java.io.IOException;

import llvm.ir.value.*;

public class CallInst extends Instruction {
    Function func;
    public Value lval;

    public CallInst(Value... operands){
        super(operands);
        this.func=(Function)operands[0];
        
        
    }
    public CallInst(Value lval,Value... operands){
        super(operands);
        this.lval=lval;
        this.func=(Function)operands[0];
        // lval.getName();
        // func.getName();
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
            writer.write("\tcall void @putint(i32 "+operands.get(1).getName()+")\n");
        }
        else if(func.name.equals("putch")){
            FunctionParam para=func.params.get(0);
            writer.write("\tcall void @putch(i32 "+operands.get(1).getName()+")\n");
        }
        else if(func.name.equals("putstr")){
            FunctionParam para=func.params.get(0);
            writer.write("\tcall void @putstr(i8* getelementptr inbounds (["+operands.get(1).getName()+" x i8], ["+operands.get(1).getName()+" x i8]* "+operands.get(2).getName()+", i64 0, i64 0))\n");
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
