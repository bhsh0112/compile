package llvm.ir.value;

import java.io.BufferedWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import dataStructure.ASTNode.ASTNode;
import llvm.ir.value.Type.*;
import llvm.ir.value.inst.AddInst;
import llvm.ir.value.inst.GetelementptrInst;
import llvm.ir.value.inst.Instruction;
import llvm.ir.value.inst.LoadInst;
import llvm.ir.value.inst.MulInst;
import llvm.ir.value.inst.SdivInst;
import llvm.ir.value.inst.SremInst;
import llvm.ir.value.inst.StoreInst;
import llvm.ir.value.inst.SubInst;
import llvm.ir.value.inst.TruncInst;
import llvm.ir.value.inst.ZextInst;
import symbol.symbol;

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
    public ArrayList<InitVal> createInitVal(VarType type,ASTNode InitVal) throws IOException{
        initvals=new ArrayList<InitVal>();
        int initSize=InitVal.children.size();
        int initNum=0;
        boolean stringConstFlag=false;
        if(initSize==1){
            initNum=1;
            if(symbol.getASTNodeContent(InitVal,new int[] {0}).equals("<Exp>")){
                InitVal newInitval=new InitVal(type, symbol.getASTNode(InitVal,new int[] {0,0}),this);
                initvals.add(newInitval);
            } 
            else if(symbol.getASTNodeContent(InitVal,new int[] {0}).equals("<ConstExp>")){
                InitVal newInitval=new InitVal(type, symbol.getASTNode(InitVal,new int[] {0,0}),this);
                initvals.add(newInitval);
            }
            else{//字符串常量
                stringConstFlag=true;
                String str=symbol.getASTNodeContent(InitVal,new int[] {0,0});
                for(int i=1;i<str.length()-1;i++){
                    InitVal newInitval=new InitVal(new VarType("char"),new AddExp("\'"+str.charAt(i)+"\'"));
                    initvals.add(newInitval);
                }
            }
        }
        else if(initSize==2){
            initNum=0;
        }
        else{
            initNum=(initSize-2)/2+1;
            for(int i=0;i<initNum;i++){
                InitVal newInitval=new InitVal(new VarType(type.type.substring(0, type.type.length()-1)), symbol.getASTNode(InitVal, new int[] {2*i+1,0}),this);
                initvals.add(newInitval);
            }
        }
        if(!stringConstFlag){
            for(InitVal initVal:initvals){
                initVal.orderAddExp();
            }
        }
        
        
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
	public Value createLoadInst(VarType dataType,Value value){
		LoadInst newLoadInst=new LoadInst(dataType,value);
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
    public Value createGetElementPtrInst(VarType type,Value ptr,Value[] indexs){
		GetelementptrInst newGetelementptrInst=new GetelementptrInst(type, ptr, indexs);
		instructions.add(newGetelementptrInst);
		return newGetelementptrInst;
	}

    

    public void output(BufferedWriter writer) throws IOException {
        // for(InitVal initVal:initvals){
        //     initVal.orderAddExp();
        // }
        for(Instruction instruction:instructions){
            instruction.output(writer);
        }
        if(formatString!=null) formatString.output(writer);
        else{
            int indexInitVal=0;
            writer.write(getName()+" = dso_local global ");
            if(initvals==null||initvals.size()==0) writer.write(this.dataType.Type2String()+" zeroinitializer");
            else if(initvals.size()==1) initvals.get(0).output(writer);
            else{
                writer.write(this.dataType.Type2String()+" ");
                writer.write("[");
                boolean firstFlag=true;
                for(InitVal initVal:initvals){
                    indexInitVal++;
                    if(firstFlag){
                        firstFlag=false;
                    }
                    else{
                        writer.write(",");
                    }
                    initVal.output(writer);
                }
                //局部变量的数组声明也需要类似补充
                while(indexInitVal<this.dataType.size){//不足未指明元素
                    if(firstFlag){
                        firstFlag=false;
                    }
                    else{
                        writer.write(",");
                    }
                    Type tmpType=new Type(this.dataType.type.substring(0,this.dataType.type.length()-1));
                    writer.write(tmpType.Type2String()+" "+"0");
                    indexInitVal++;
                }
                writer.write("]");
            }

        }
        writer.write("\n");
    }
}
