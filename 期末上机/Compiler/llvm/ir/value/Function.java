package llvm.ir.value;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.LinkedList;

import dataStructure.ASTNode.ASTNode;
import dataStructure.STT.STTQue;

// import dataStructure.STT.STTQue;

import llvm.ir.value.Type.*;
import symbol.symbol;

public class Function extends Value {
	public ReturnType retType;
	public ArrayList<FunctionParam> params = new ArrayList<>();
	public ArrayList<BasicBlock> basicBlocks = new ArrayList<>();
	public ArrayList<Value> values = new ArrayList<>();

	public Function(ReturnType retType, String name,ArrayList<VarType> argTypes) {
		super(name);
		this.retType = retType;
		if(argTypes!=null){
			for (var argType : argTypes) {
				params.add(new FunctionParam(argType));
			}
		}
		
	}

	public BasicBlock getFirstBasicBlock() {
		if (basicBlocks.isEmpty()) {
			return null;
		} else {
			return basicBlocks.get(0);
		}
	}

	public ReturnType getRetType() {
		return retType;
	}

	public ArrayList<FunctionParam> getArguments() {
		return params;
	}

	public ArrayList<BasicBlock> getBasicBlocks() {
		return basicBlocks;
	}

	public BasicBlock createBasicBlock(Function parentFunction,ASTNode BlockRoot,int level,BasicBlock parentBasicBlock) {
		// getName();
		var newBlock = new BasicBlock(parentFunction,BlockRoot,level,parentBasicBlock);
		basicBlocks.add(newBlock);
		values.add(newBlock);
		return newBlock;
	}

	@Override
	public String getName() {
		return "@" + super.getName();
	}

	public void output(BufferedWriter writer) throws IOException {

		
		
        writer.write("define dso_local "+ retType.Type2String()+" " + getName()+"(");

        boolean isFirst = true;
        for (var para : params) {
            if (isFirst) {
                isFirst = false;
            } else {
                writer.write(", ");
            }
            para.output(writer);
        }

        writer.write(") {\n");

        for (var block : basicBlocks) {
			block.getName();
			block.flash();
            block.output(writer);
        }

        writer.write("}\n");
    }

    public int calcParamSpace() {
        return params.size() * 4;
    }
}
