package llvm.ir.value;

import java.io.BufferedWriter;
import java.io.IOException;
import java.nio.Buffer;

public class Label extends Value{
    
    public Label(){

    }
    public String getName(){
        return super.getName().substring(1);
    }
    public void output(BufferedWriter writer) throws IOException{
        writer.write(getName()+":\n");
    }
}
