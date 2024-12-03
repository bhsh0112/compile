package llvm.ir.value;

import java.io.BufferedWriter;
import java.io.IOException;

import llvm.ir.value.Type.*;

public class FunctionParam extends Value{
	public VarType paraType;

	public FunctionParam(){

	}
	public FunctionParam(VarType type) {
	    this.paraType=type;
	}

	public String getName() {
		return super.getName();
	}

	public String getType(){
		return paraType.Type2String();
	}

	public void output(BufferedWriter writer) throws IOException {
        writer.write(getType()+" "+getName());
    }
}
