package llvm.ir.value;

import java.io.BufferedWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import dataStructure.ASTNode.ASTNode;
import llvm.ir.value.Type.*;
import llvm.ir.value.inst.AddInst;
import llvm.ir.value.inst.Instruction;
import llvm.ir.value.inst.LoadInst;
import llvm.ir.value.inst.MulInst;
import llvm.ir.value.inst.SdivInst;
import llvm.ir.value.inst.SremInst;
import llvm.ir.value.inst.StoreInst;
import llvm.ir.value.inst.SubInst;
import llvm.ir.value.inst.TruncInst;
import llvm.ir.value.inst.ZextInst;

public class GlobalValue extends Value{
    public VarType dataType;
    public GlobalVar var=null;
    public GlobalArray array=null;
    public FormatString formatString=null;
    public AddExp size=null;
    public ArrayList<InitVal> initvals;
    public ArrayList<Instruction> instructions=new ArrayList<>();

    public GlobalValue(){}
    public GlobalValue(VarType type,String name) {
        super(name);

        this.dataType = type;
    }

    @Override
    public String getName() {
        return "@" + super.getName();
    }

    public GlobalVar createGlobalVar(){
        if(initvals!=null) var=new GlobalVar(dataType, name,this.initvals.get(0));
        else var=new GlobalVar(dataType, name);
        return var;
    }
    public GlobalArray createGlobalArray(){
        array=new GlobalArray(dataType, name);
        return array;
    }
    public FormatString createFormatString(String str){
        formatString=new FormatString(str);
        return formatString;
    }
    public ArrayList<InitVal> createInitVal(VarType type,ASTNode AddExp){
        InitVal newInitval=new InitVal(type, AddExp);
        initvals=new ArrayList<InitVal>();
        initvals.add(newInitval);
        return initvals;
    }

    public Value createSubInst(Value left,Value right){
		SubInst newSubInst=new SubInst(left,right);
		instructions.add(newSubInst);
		return newSubInst;

	}

	public Value createMulInst(Value left,Value right){
		MulInst newMulInst=new MulInst(left,right);
		instructions.add(newMulInst);
		return newMulInst;

	}
	public Value createSdivInst(Value left,Value right){
		SdivInst newSdivInst=new SdivInst(left,right);
		instructions.add(newSdivInst);
		return newSdivInst;

	}
	public Value createSremInst(Value left,Value right){
		SremInst newSremInst=new SremInst(left,right);
		instructions.add(newSremInst);
		return newSremInst;

	}
	public Value createAddInst(Value left,Value right){
		AddInst newAddInst=new AddInst(left,right);
		instructions.add(newAddInst);
		return newAddInst;

	}
	public Value createLoadInst(Value value,Value type){
		LoadInst newLoadInst=new LoadInst(value,type);
		instructions.add(newLoadInst);
		return newLoadInst;
	}
    public Value createZextInst(Value... operands){
		// if(operands[0].name.matches("\\d+")||operands[0].name.matches("\\'.\\'")){

		// }
		ZextInst newZextInst=new ZextInst(operands);
		instructions.add(newZextInst);
		return newZextInst;
	}
	public Value createTruncInst(Value... operands){
		TruncInst newTruncInst=new TruncInst(operands);
		instructions.add(newTruncInst);
		return newTruncInst;
	}

    

    public void output(BufferedWriter writer) throws IOException {
        for(Instruction instruction:instructions){
            System.out.println("success");
            instruction.output(writer);
        }
        if(var!=null){
            writer.write(getName()+" = dso_local global ");
            var.output(writer);
        } 
        else if(array!=null){
            writer.write(getName()+" = dso_local global ");
            String arraySize=null;
            arraySize=size.output(writer);
            writer.write("["+arraySize+" x "+dataType.Type2String()+"]");
            array.output(writer);
            
        } 
        else{
            formatString.output(writer);
        }
        writer.write("\n");
    }
}
