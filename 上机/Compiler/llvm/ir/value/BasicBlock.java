package llvm.ir.value;

import java.io.BufferedWriter;
import java.io.IOException;
import java.util.ArrayList;

import javax.lang.model.element.Element;

import dataStructure.ASTNode.ASTNode;
import dataStructure.ASTNode.ENode;
import dataStructure.ASTNode.TNode;
import dataStructure.STT.STTNode;
import dataStructure.STT.STTStack;
import llvm.ir.value.Type.ReturnType;
import llvm.ir.value.Type.VarType;
import llvm.ir.value.inst.*;
import llvm.ir.Module;
import symbol.symbol;

public class BasicBlock extends Value{
	public Label label;
    public ArrayList<Instruction> instructions=new ArrayList<>(); // 该基本块中的指令
    public Function parentFunction; // 该基本块所属的函数
	public int level;
	public ASTNode BlockRoot; 
	public ArrayList<Integer> jumpIndexs=new ArrayList<>();
	public ArrayList<BasicBlock> children=new ArrayList<>();
	public BasicBlock parent;
	public BasicBlock nextBasicBlock;//仅控制语句使用
	public BasicBlock afterBasicBlock;//仅for循环用到

	public boolean isStmt=false;
    
	public BasicBlock(){

	}
    public BasicBlock(String name){
        super(name);
    }
    public BasicBlock(Function parentFunction,ASTNode BlockRoot,int level,BasicBlock parent){
        this.instructions=new ArrayList<>();
        this.parentFunction=parentFunction;
		this.BlockRoot=BlockRoot;
		this.level=level;
		this.parent=parent;
    }

    public void addInstruction(Instruction value) {
		value.setParentBasicBlock(this);
		instructions.add(value);
	}
    public ArrayList<Instruction> getInstructions() {
		return instructions;
	}

	public Value createAllocaInst(Value Type){
		AllocaInst newAllocaInst=new AllocaInst(Type);
		instructions.add(newAllocaInst);
		return newAllocaInst;
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
	public Value createStoreInst(VarType type,Value value,Value ptr){
		StoreInst newStoreInst=new StoreInst(type,value, ptr);
		instructions.add(newStoreInst);
		return newStoreInst;
	}
	public Value createLoadInst(VarType dataType,Value value){
		LoadInst newLoadInst=new LoadInst(dataType,value);
		instructions.add(newLoadInst);
		return newLoadInst;
	}
	public Value createReturnInst(ReturnType retType,Value value){
		ReturnInst newReturnInst;
		if(value==null) newReturnInst=new ReturnInst(retType,new Value[]{});
		else newReturnInst=new ReturnInst(retType,value);
		instructions.add(newReturnInst);
		return newReturnInst;
	}
	public Value createCallInst(Value lval,Value... operands){//operands为一个Function和若干的FunctionParam
		CallInst newCallInst=new CallInst(lval,operands);
		instructions.add(newCallInst);
		return newCallInst;
	}
	public Value createPrintfInst(Value... operands){
		PrintfInst newPrintfInst=new PrintfInst(operands);
		instructions.add(newPrintfInst);
		return newPrintfInst;
	}
	public Value createBrInst(Value... operands){
		BrInst newBrInst=new BrInst(operands);
		instructions.add(newBrInst);
		return newBrInst;
	}
	public Value createCmpInst(String type,String varType,Value... operands){
		CmpInst newCmpInst=new CmpInst(type,varType,operands);
		instructions.add(newCmpInst);
		return newCmpInst;
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
	public Value createGetElementPtrInst(VarType type,Value ptr,int[] indexs){
		GetelementptrInst newGetelementptrInst=new GetelementptrInst(type, ptr, indexs);
		instructions.add(newGetelementptrInst);
		return newGetelementptrInst;
	}

	public void orderAST(ASTNode parent) throws IOException{
		if(parent.name.equals("<ConstDecl>")){
			String declType=symbol.getASTNodeContent(parent,new int[]{1,0});
			int declNum=(parent.children.size()-2)/2;
			for(int i=0;i<declNum;i++){
				String declName=symbol.getASTNodeContent(parent,new int[]{2*i+2,0,0});
				if(symbol.getASTNode(parent, new int[]{2*i+2}).children.size()==3){//变量
					Value ptr=createAllocaInst(new VarType(declType));
					AddExp tmpAddExp=new AddExp(this);
					tmpAddExp.llvmAddExp(symbol.getASTNode(parent, new int[]{2*i+2,2,0,0}), null);
					Value from=tmpAddExp.value;
					if(declType.equals("int")&&tmpAddExp.type.equals("char")) from=createZextInst(from);
					else if(declType.equals("char")&&tmpAddExp.type.equals("int")) from=createTruncInst(from);
					else if(declType.equals("int")&&tmpAddExp.type.equals("charImm")){
						from.name=String.valueOf((int)(from.name.charAt(1)));
					}
					createStoreInst(new VarType(declType),from,ptr);
					Module.symbolStack.pushStack(this.level,declType,"Var",declName,ptr,0);
				}
				else{//数组
					AddExp newAddExp=new AddExp("tmpAddExp");
                    int size=Integer.valueOf(newAddExp.llvmAddExp(symbol.getASTNode(parent,new int[] {2*i+2,2,0}), null));
					Value ptr=createAllocaInst(new VarType(declType+"R",size));
					Value originPtr=ptr;
					int initNum=(symbol.getASTNode(parent, new int[]{2*i+2,5}).children.size()-2)/2+1;
					if(initNum>=1){
						for(int j=0;j<initNum;j++){
							if(j==0){
								ptr=createGetElementPtrInst(new VarType(declType+"R",size),ptr,new int[]{0,j});
							}
							else{
								ptr=createGetElementPtrInst(new VarType(declType),ptr,new int[]{1});
							}
							ASTNode AddExp=symbol.getASTNode(parent, new int[]{2*i+2,5,2*j+1,0});
							AddExp tmpAddExp=new AddExp(this);
							tmpAddExp.llvmAddExp(AddExp, null);
							Value from=tmpAddExp.value;
							createStoreInst(new VarType(declType),from,ptr);
						}
					}
					else{
						//TODO:是否存在？
					}
					//TODO:如何推入符号栈？
					Module.symbolStack.pushStack(this.level,declType,"Array",declName,originPtr,size);
					//TODO:类型转换？
				}
			}

			
		}
		else if(parent.name.equals("<VarDecl>")){
			String declType=symbol.getASTNodeContent(parent,new int[]{0,0});
			int declNum=(parent.children.size()-1)/2;
			for(int i=0;i<declNum;i++){
				String declName=symbol.getASTNodeContent(parent,new int[]{2*i+1,0,0});
				if(symbol.getASTNodeContent(parent,new int[] {2*i+1,symbol.getASTNode(parent,new int[] {2*i+1}).children.size()-1}).equals("<InitVal>")){//有初值
					if(symbol.getASTNode(parent,new int[] {2*i+1}).children.size()==6){//数组
						AddExp newAddExp=new AddExp("tmpAddExp");
						int size=Integer.valueOf(newAddExp.llvmAddExp(symbol.getASTNode(parent,new int[] {2*i+1,2,0}), null));
						Value ptr=createAllocaInst(new VarType(declType+"R",size));
						Value originPtr=ptr;
						int initNum=(symbol.getASTNode(parent, new int[]{2*i+1,5}).children.size()-2)/2+1;
						if(initNum>=1){
							for(int j=0;j<initNum;j++){
								if(j==0){
									ptr=createGetElementPtrInst(new VarType(declType+"R",size),ptr,new int[]{0,j});
								}
								else{
									ptr=createGetElementPtrInst(new VarType(declType),ptr,new int[]{1});
								}
								ASTNode AddExp=symbol.getASTNode(parent, new int[]{2*i+1,5,2*j+1,0});
								AddExp tmpAddExp=new AddExp(this);
								tmpAddExp.llvmAddExp(AddExp, null);
								Value from=tmpAddExp.value;
								createStoreInst(new VarType(declType),from,ptr);
							}
						}
						else{
							//TODO:是否存在？
						}
						//TODO:如何推入符号栈？
						Module.symbolStack.pushStack(this.level,declType,"Array",declName,originPtr,size);
						//TODO:类型转换？
					}
					else{//变量
						Value ptr=createAllocaInst(new VarType(declType));
						AddExp tmpAddExp=new AddExp(this);
						tmpAddExp.llvmAddExp(symbol.getASTNode(parent, new int[]{2*i+1,2,0,0}), null);
						Value from=tmpAddExp.value;
						if(declType.equals("int")&&tmpAddExp.type.equals("char")) from=createZextInst(from);
						else if(declType.equals("char")&&tmpAddExp.type.equals("int")) from=createTruncInst(from);
						else if(declType.equals("int")&&tmpAddExp.type.equals("charImm")){
							from.name=String.valueOf((int)(from.name.charAt(1)));
						}
						createStoreInst(new VarType(declType),from,ptr);
						Module.symbolStack.pushStack(this.level,declType,"Var",declName,ptr,0);
					}
				}
				else{//无初值
					if(symbol.getASTNode(parent,new int[] {2*i+1}).children.size()==4){//数组
						AddExp newAddExp=new AddExp("tmpAddExp");
						int size=Integer.valueOf(newAddExp.llvmAddExp(symbol.getASTNode(parent,new int[] {2*i+1,2,0}), null));
						Value ptr=createAllocaInst(new VarType(declType+"R",size));
						//TODO:如何推入符号栈？
						Module.symbolStack.pushStack(this.level,declType,"Array",declName,ptr,size);
					}
					else{//变量
						Value ptr=createAllocaInst(new VarType(declType));
						Module.symbolStack.pushStack(this.level,declType,"Var",declName,ptr,0);
					}
					
				}
			}
			
		}
		else if(parent.name.equals("<Stmt>")){
			if(symbol.getASTNode(parent,new int[]{0}) instanceof TNode){
				if(((TNode)(symbol.getASTNode(parent,new int[]{0}))).token.equals("return")){
					if(parent.children.size()==2){//无返回值
						createReturnInst(parentFunction.retType,null);
					}
					else{//有返回值
						AddExp tmpAddExp=new AddExp(this);
						tmpAddExp.llvmAddExp(symbol.getASTNode(parent, new int[]{1,0}), null);
						// if(tmpAddExp.type.equals("int")&&this.parentFunction.retType.type.equals("char")){
						// 	createReturnInst(createTruncInst(tmpAddExp.value));
						// }
						if(tmpAddExp.type.equals("char")&&this.parentFunction.retType.type.equals("int")){
							createReturnInst(parentFunction.retType,createZextInst(tmpAddExp.value));
						}
						else if((tmpAddExp.type.equals("charImm")&&this.parentFunction.retType.type.equals("int"))){
							Value newValue=new Value(String.valueOf((int)(tmpAddExp.value.name.charAt(1))));
							createReturnInst(parentFunction.retType,newValue);
						}
						else if((tmpAddExp.type.equals("int")&&this.parentFunction.retType.type.equals("char"))){
							createReturnInst(parentFunction.retType,createTruncInst(tmpAddExp.value));
						}
						else createReturnInst(parentFunction.retType,tmpAddExp.value);
					}
				}
				else if(((TNode)(symbol.getASTNode(parent,new int[]{0}))).token.equals("printf")){
					int valueNum=(parent.children.size()-5)/2+1;
					Value[] operands=new Value[valueNum];
					operands[0]=new StringConst(symbol.getASTNodeContent(parent, new int[] {2,0}));
					for(int i=1;i<valueNum;i++){
						ASTNode addExp=symbol.getASTNode(parent, new int[]{2*i+2,0});
						AddExp tmpAddExp=new AddExp(this);
						tmpAddExp.llvmAddExp(addExp, null);
						operands[i]=tmpAddExp;
					}
					createPrintfInst(operands);
				}
				else if(((TNode)(symbol.getASTNode(parent,new int[]{0}))).token.equals("if")){
					LOrExp newLOrExp=new LOrExp(this,symbol.getASTNode(parent, new int[]{2,0}));
					BasicBlock ifBasicBlock=null,elseBasicBlock=null;
					// this.nextBasicBlock=new BasicBlock(parentFunction, null, level+1, this);
					//ifBasicBlock
					if(symbol.getASTNodeContent(parent, new int[]{4,0}).equals("<Block>")){
						ifBasicBlock=new BasicBlock(parentFunction,symbol.getASTNode(parent, new int[]{4,0}),this.level+1,this);
						ifBasicBlock.orderAST(symbol.getASTNode(parent, new int[]{4,0}));
						// ifBasicBlock.createBrInst(this.nextBasicBlock);
						Module.symbolStack.rmCurLevel(ifBasicBlock.level);
						ifBasicBlock.label=new Label(ifBasicBlock);
					}
					else{//TODO：单一语句
						ifBasicBlock=new BasicBlock(parentFunction,symbol.getASTNode(parent, new int[]{4,0}),this.level+1,this);
						ifBasicBlock.orderAST(symbol.getASTNode(parent, new int[]{4}));
						// ifBasicBlock.createBrInst(this.nextBasicBlock);
						Module.symbolStack.rmCurLevel(ifBasicBlock.level);
						ifBasicBlock.label=new Label(ifBasicBlock);
					}
					//elseBasicBlock
					if(parent.children.size()>5){
						if(symbol.getASTNodeContent(parent, new int[]{6,0}).equals("<Block>")){
							elseBasicBlock=new BasicBlock(parentFunction,symbol.getASTNode(parent, new int[]{6,0}),this.level+1,this);
							elseBasicBlock.orderAST(symbol.getASTNode(parent, new int[]{6,0}));
							Module.symbolStack.rmCurLevel(elseBasicBlock.level);
							elseBasicBlock.label=new Label(elseBasicBlock);
						}
						else{//TODO：单一语句
							elseBasicBlock=new BasicBlock(parentFunction,symbol.getASTNode(parent, new int[]{6}),this.level+1,this);
							elseBasicBlock.orderAST(symbol.getASTNode(parent, new int[]{6}));
							Module.symbolStack.rmCurLevel(elseBasicBlock.level);
							elseBasicBlock.label=new Label(elseBasicBlock);
						}
					}
					if(elseBasicBlock!=null){//有else
						newLOrExp.main(ifBasicBlock,elseBasicBlock,false);
						ifBasicBlock.createBrInst(this.nextBasicBlock);
						for(int i=0;i<newLOrExp.numBasicBlock;i++){
							jumpIndexs.add(instructions.size());
						}

						jumpIndexs.add(instructions.size());
						jumpIndexs.add(instructions.size());
						jumpIndexs.add(instructions.size());
						children.add(ifBasicBlock);
						children.add(elseBasicBlock);
						children.add(this.nextBasicBlock);
					}
					else{//TODO:无else
						newLOrExp.main(ifBasicBlock,this.nextBasicBlock,true);
						ifBasicBlock.createBrInst(this.nextBasicBlock);
						for(int i=0;i<newLOrExp.numBasicBlock;i++){
							jumpIndexs.add(instructions.size());
						}

						jumpIndexs.add(instructions.size());
						jumpIndexs.add(instructions.size());
						children.add(ifBasicBlock);
						children.add(this.nextBasicBlock);
					}
					return;
				}
				else if(((TNode)(symbol.getASTNode(parent,new int[]{0}))).token.equals("for")){
					BasicBlock ForStmt1=null,Cond=null,ForStmt2=null,Stmt=new BasicBlock(this.parentFunction,null,this.level,this);
					Stmt.isStmt=true;
					BasicBlock entranceBasicBlock=null;
					this.afterBasicBlock=new BasicBlock();
					this.afterBasicBlock.label=new Label(this.afterBasicBlock);
					//判断缺省情况
					if(parent.children.size()==9){//无缺省
						ForStmt1=new BasicBlock();
						ForStmt1.orderAST(symbol.getASTNode(parent, new int[]{2}));
						jumpIndexs.add(instructions.size());
						children.add(ForStmt1);
						//TODO:处理LOrExp
						LOrExp newLOrExp=new LOrExp(this,symbol.getASTNode(parent, new int[]{4,0}));
						newLOrExp.main(Stmt,this.afterBasicBlock,false);//TODO:noElseFlag?
						for(int i=0;i<newLOrExp.numBasicBlock;i++){
							jumpIndexs.add(instructions.size());
						}
						Cond=children.get(children.size()-newLOrExp.numBasicBlock);
						Cond.parentFunction=this.parentFunction;
						Cond.parent=this;
						
						ForStmt2=new BasicBlock();
						ForStmt2.orderAST(parent.children.get(6));
					}
					//TODO:只完成了没缺省的情况
					else if(parent.children.size()==8){//一个缺省
						if(symbol.getASTNodeContent(parent, new int[]{2}).equals(";")){//缺省ForStmt1
							LOrExp newLOrExp=new LOrExp(this,symbol.getASTNode(parent, new int[]{3,0}));
							newLOrExp.main(Stmt,this.afterBasicBlock,true);//TODO:noElseFlag?
							for(int i=0;i<newLOrExp.numBasicBlock;i++){
								jumpIndexs.add(instructions.size());
							}
							Cond=children.get(children.size()-newLOrExp.numBasicBlock);
							ForStmt2=new BasicBlock(this.parentFunction,null,this.level+1,this);
							ForStmt2.orderAST(parent.children.get(5));
						}
						else if(symbol.getASTNodeContent(parent, new int[]{4}).equals(";")){//缺省cond
							ForStmt1=new BasicBlock(this.parentFunction,null,this.level+1,this);
							ForStmt1.orderAST(parent.children.get(2));
							ForStmt2=new BasicBlock(this.parentFunction,null,this.level+1,this);
							ForStmt2.orderAST(parent.children.get(5));
						}
						else if(symbol.getASTNodeContent(parent, new int[]{6}).equals(";")){//缺省ForStmt2
							ForStmt1=new BasicBlock(this.parentFunction,null,this.level+1,this);
							ForStmt1.orderAST(parent.children.get(2));
							Cond=new BasicBlock(this.parentFunction,null,this.level+1,this);
							//TODO:处理LOrExp
						}
					}
					else if(parent.children.size()==7){//两个缺省
						if(symbol.getASTNodeContent(parent, new int[]{2}).equals("<ForStmt>")){//留ForStmt1
							ForStmt1=new BasicBlock(this.parentFunction,null,this.level+1,this);
							ForStmt1.orderAST(parent.children.get(2));
						}
						else if(symbol.getASTNodeContent(parent, new int[]{3}).equals("<Cond>")){//留Cond
							Cond=new BasicBlock(this.parentFunction,null,this.level+1,this);
							//TODO:处理LOrExp
						}
						else if(symbol.getASTNodeContent(parent, new int[]{4}).equals("<ForStmt>")){//留ForStmt2 
							ForStmt2=new BasicBlock(this.parentFunction,null,this.level+1,this);
							ForStmt2.orderAST(parent.children.get(4));
						}
					}
					else if(parent.children.size()==6){//三个缺省
						
					}
					
					Stmt.label=new Label(Stmt);
					jumpIndexs.add(instructions.size());
					children.add(Stmt);
					
					if(ForStmt2!=null){
						jumpIndexs.add(instructions.size());
						children.add(ForStmt2);
						ForStmt2.label=new Label(ForStmt2);
					} 
					jumpIndexs.add(instructions.size());
					children.add(this.afterBasicBlock);
					
					//根据缺省情况调整控制流
					//TODO:break,continue
					if(Cond==null){
						entranceBasicBlock=Stmt;
					}
					else{
						entranceBasicBlock=Cond;
					}
					
					if(ForStmt1!=null) ForStmt1.createBrInst(entranceBasicBlock);
					
					if(ForStmt2==null){
						Stmt.nextBasicBlock=entranceBasicBlock;
						
					}
					else{
						Stmt.nextBasicBlock=ForStmt2;
						ForStmt2.nextBasicBlock=entranceBasicBlock;
						ForStmt2.createBrInst(entranceBasicBlock);
					}
					System.out.println("befor: "+Stmt.instructions.size());
					Stmt.orderAST(parent.children.get(parent.children.size()-1));
					System.out.println("after: "+Stmt.instructions.size());
					Stmt.createBrInst(Stmt.nextBasicBlock);
					return;
				}
				else if(symbol.getASTNodeContent(parent, new int[]{0}).equals("break")){
					BasicBlock tmp=this;
					while(tmp.afterBasicBlock==null) tmp=tmp.parent;
					this.createBrInst(tmp.afterBasicBlock);
				}
				else if(symbol.getASTNodeContent(parent, new int[]{0}).equals("continue")){
					BasicBlock tmp=this;
					
					while(tmp.isStmt==false){
						tmp=tmp.parent;
					} 
					this.createBrInst(tmp.nextBasicBlock);
				}
			}
			else{
				if(parent.children.get(0).name.equals("<Exp>")){
					AddExp tmpAddExp=new AddExp(this);
					tmpAddExp.llvmAddExp(symbol.getASTNode(parent, new int[]{0,0}), null);
				}
			}
		}
		else if(parent.name.equals("<LVal>")&&(parent.parent.name.equals("<Stmt>")||parent.parent.name.equals("<ForStmt>"))){
			ASTNode father=parent.parent;//Stmt 或 ForStmt
			//处理LVal
			String ident=symbol.getASTNodeContent(parent, new int[] {0,0});
			int index=0;
			if(parent.children.size()==3){
				AddExp newAddExp=new AddExp("tmpAddExp");
				index=Integer.valueOf(newAddExp.llvmAddExp(symbol.getASTNode(parent,new int[] {2,0}), null));
			}
			Value tmpValue=null,tmpType=null;
			if(parent.children.size()==1){//变量
				boolean tmpFlag=false;
				int stackSize=Module.symbolStack.stack.size();
				for(int i=stackSize-1;i>=0;i--){
					STTStack.Element element=Module.symbolStack.stack.get(i);
					if(element.level==0){
						if(element.value.getName().substring(1).equals(ident)){
							tmpFlag=true;
							tmpValue=element.value;
							VarType ttType=new VarType(element.type);
							tmpType=ttType;
							if(element.kind.equals("Array")){
								createGetElementPtrInst(ttType, element.value, new int[] {index});
							}
							break;
						} 
					}
					else{
						if(element.name.equals(ident)){
							tmpFlag=true;
							tmpValue=element.value;
							VarType ttType=new VarType(element.type);
							tmpType=ttType;
							if(element.kind.equals("Array")){
								createGetElementPtrInst(ttType, element.value, new int[] {index});
							}
							break;
						} 
					}
					
				}
				if(tmpFlag){
					// createLoadInst(tmpValue,tmpType);
				}
				else{
					
				}
			}
			else{

			}
			// Module.symbolStack.pushStack(this.level, ((VarType)tmpType).Type2String(), tmpValue.name, tmpValue);
			//处理等号右侧
			if(father.children.get(2).name.equals("<Exp>"))	{
				AddExp tmpAddExp=new AddExp(this);
				tmpAddExp.llvmAddExp(symbol.getASTNode(father, new int[]{2,0}), null);
				Value from=tmpAddExp.value;
				if(((VarType)tmpType).type.equals("int")&&tmpAddExp.type.equals("char")) from=createZextInst(from);
				else if(((VarType)tmpType).type.equals("char")&&tmpAddExp.type.equals("int")) from=createTruncInst(from);
				else if(((VarType)tmpType).type.equals("int")&&tmpAddExp.type.equals("charImm")){
					from.name=String.valueOf((int)(from.name.charAt(1)));
				}
				createStoreInst((VarType)tmpType,from,tmpValue);
			}
			else if(((TNode)(father.children.get(2))).token.equals("getint")){
				Value newValue=new Value();
				Value newCallInst=createCallInst(newValue,new Function(new ReturnType("int"), "getint", null));
				if(((VarType)tmpType).type.equals("char")){
					Value newTruncInst=createTruncInst(newValue);
					createStoreInst((VarType)tmpType,newTruncInst,tmpValue);
				} 
				else createStoreInst((VarType)tmpType,newValue,tmpValue);
			}
			else if(((TNode)(father.children.get(2))).token.equals("getchar")){
				Value newValue=new Value();
				Value newCallInst=createCallInst(newValue,new Function(new ReturnType("int"), "getchar", null));
				if(((VarType)tmpType).type.equals("char")){
					Value newTruncInst=createTruncInst(newValue);
					createStoreInst((VarType)tmpType,newTruncInst,tmpValue);
				} 
				else createStoreInst((VarType)tmpType,newValue,tmpValue);
			}
			
		}
		// else if(parent.name.equals("<Block>")){
		// 	BasicBlock newbasicblock=parentFunction.createBasicBlock(parentFunction, parent, level+1, null);
		// 	newbasicblock.orderAST(parent);
		// 	Module.symbolStack.rmCurLevel(newbasicblock.level);
		// }
		
		
		for(ASTNode child:parent.children){
			if(child.name.equals("<Block>")){
				Function tmpFunction=new Function(null, name, null);
				BasicBlock newbasicblock=tmpFunction.createBasicBlock(parentFunction,child,this.level+1,this);
				newbasicblock.orderAST(child);
				Module.symbolStack.rmCurLevel(newbasicblock.level);
				jumpIndexs.add(instructions.size());
				children.add(newbasicblock);
			}
			else orderAST(child);
		}
	}

	public void flash(){
		
		int jumpindex=0;
		int cnt=0;
		while(jumpindex<jumpIndexs.size()&&cnt==jumpIndexs.get(jumpindex)){//先输出子block
			children.get(jumpindex).getName();
			children.get(jumpindex).flash();
			jumpindex++;
		} 
		for (Instruction ins : instructions) {
			if(jumpindex<=(jumpIndexs.size()-1)){
				while(jumpindex<jumpIndexs.size()&&cnt==jumpIndexs.get(jumpindex)){//先输出子block
					children.get(jumpindex).getName();
					children.get(jumpindex).flash();
					// if(jumpIndexs.get(jumpindex)==jumpIndexs.get(jumpindex+1)) children.get(jumpindex).nextBasicBlock=children.get(jumpindex+1);
					// else{
					// 	children.get(jumpindex).nextBasicBlock=parentFunction.createBasicBlock(parentFunction, null, level+1, this);
					// 	children.get(jumpindex).nextBasicBlock.label=new Label(children.get(jumpindex).nextBasicBlock);
					// } 
					jumpindex++;
				} 
			}
			if(!(ins instanceof BrInst)){
				if(!(ins instanceof ReturnInst||ins instanceof CallInst||ins instanceof StoreInst||ins instanceof PrintfInst)){
					ins.getName();
				}
				if(ins instanceof CallInst && ((CallInst)ins).lval!=null){
					((CallInst)ins).lval.getName();
				}
				for(Value value:ins.operands){
					// if(ins instanceof CallInst){
					// 	System.out.print(value.getName()+" ");
					// } 
					if(!(ins instanceof PrintfInst)) value.getName();
				}
				// System.out.println();
				
			}
			
			cnt++;
		}
	}

    public void output(BufferedWriter writer) throws IOException {
		
		if (label!=null) {
			label.output(writer);
		}
		int jumpindex=0;
		int cnt=0;
		while(jumpindex<jumpIndexs.size()&&cnt==jumpIndexs.get(jumpindex)){//先输出子block
			children.get(jumpindex).output(writer);
			jumpindex++;
		} 
		for (Instruction ins : instructions) {
			if(jumpindex<=(jumpIndexs.size()-1)){
				while(jumpindex<jumpIndexs.size()&&cnt==jumpIndexs.get(jumpindex)){//先输出子block
					children.get(jumpindex).output(writer);
					jumpindex++;
				} 
			}
			ins.output(writer);
			cnt++;
		}
	}
}
