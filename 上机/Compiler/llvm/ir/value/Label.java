package llvm.ir.value;

import java.io.BufferedWriter;
import java.io.IOException;
import java.nio.Buffer;

public class Label extends Value{
    BasicBlock basicBlock;
    public Label(BasicBlock basicBlock){
        this.basicBlock=basicBlock;
    }
    public String getName(){
        return name.substring(1);
    }
    public void output(BufferedWriter writer) throws IOException{
        writer.write(basicBlock.getName().substring(1)+":\n");
    }
}
