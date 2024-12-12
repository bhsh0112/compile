package llvm.ir.value.inst;

import java.io.BufferedWriter;
import java.io.IOException;
import java.util.ArrayList;

import dataStructure.ASTNode.ASTNode;
import llvm.ir.value.AddExp;
import llvm.ir.value.BasicBlock;
import llvm.ir.value.FormatString;
import llvm.ir.value.GlobalValue;
import llvm.ir.value.StringConst;
import llvm.ir.value.Value;
import llvm.ir.value.Type.ReturnType;
import llvm.ir.value.Type.VarType;
import llvm.ir.Module;
import llvm.ir.value.Function;

public class PrintfInst extends Instruction{
    BasicBlock basicBlock;
    StringConst format;
    ArrayList<AddExp> addExps=new ArrayList<>();
    ArrayList<String> strs=new ArrayList<>();
    ArrayList<String> varTypes=new ArrayList<>();
    ArrayList<FormatString> formatStrings=new ArrayList<FormatString>();
    public ArrayList<Instruction> zextInstructions=new ArrayList<>();



    public PrintfInst(BasicBlock basicBlock,Value... operands) throws IOException{
        super(operands);
        this.basicBlock=basicBlock;
        this.format=(StringConst)operands[0];
        for(int i=1;i<operands.length;i++){
            this.addExps.add((AddExp)operands[i]);
        }
        splitString();
        generateInstructions();
        // for(Value v:operands){
		// 	v.getName();
		// }
		// super.getName();
    }
    public void splitString() throws IOException{
        int start=1;
        for(int i=1;i<this.format.content.length()-1;i++){
            if(this.format.content.charAt(i)=='\\'){
                if(this.format.content.charAt(i+1)=='n'){
                    this.format.content=this.format.content.substring(0,i)+"\\0A"+this.format.content.substring(i+2,this.format.content.length());
                    i=i+2;
                }
            }
            
            
            if(this.format.content.charAt(i)=='%'&&(this.format.content.charAt(i+1)=='d'||this.format.content.charAt(i+1)=='c')){
                if(i>start){
                    varTypes.add("str");
                    String str=this.format.content.substring(start,i);
                    strs.add(str);
                    ASTNode _node=new ASTNode("null");
                    GlobalValue newGlobalValue=Module.createGlobalValue(new VarType("char"),name,_node);
                    formatStrings.add(newGlobalValue.createFormatString(str));
                } 
                
                if(this.format.content.charAt(i+1)=='d') varTypes.add("int");
                else varTypes.add("char");
                start=i+2;
            }
        }
        if(!(this.format.content.endsWith("%d\"")||this.format.content.endsWith("%c\""))){
            varTypes.add("str");
            String str=this.format.content.substring(start,this.format.content.length()-1);
            strs.add(str);
            ASTNode _node=new ASTNode("null");
            GlobalValue newGlobalValue=Module.createGlobalValue(new VarType("char"),name,_node);
            formatStrings.add(newGlobalValue.createFormatString(str));
        }
    }

    public void generateInstructions(){
        int indexStr=0,indexValue=0;
        for(int i=0;i<varTypes.size();i++){
            if(varTypes.get(i).equals("char")){
                System.out.println(((AddExp)addExps.get(indexValue)).type);
                if(((AddExp)addExps.get(indexValue)).type.equals("char")){
                    // System.out.println("success");
                    Value tmpZextInst=basicBlock.createZextInst(addExps.get(indexValue).value);
                    Value [] operands=new Value[2];
                    ArrayList<VarType> paraTypeList=new ArrayList<>();
                    paraTypeList.add(new VarType("char"));
                    Function tmpFunction=new Function(new ReturnType("void"), "putch", paraTypeList);
                    operands[0]=tmpFunction;
                    operands[1]=tmpZextInst;
                    basicBlock.createCallInst(tmpFunction,operands);
                    
                }
                else if(addExps.get(indexValue).type.equals("charImm")){
                    //TODO:理论上不会再出现
                    Value [] operands=new Value[2];
                    ArrayList<VarType> paraTypeList=new ArrayList<>();
                    paraTypeList.add(new VarType("int"));
                    Function tmpFunction=new Function(new ReturnType("void"), "putint", paraTypeList);
                    operands[0]=tmpFunction;
                    operands[1]=new Value(String.valueOf(((int)addExps.get(indexValue).value.name.charAt(1))));
                    basicBlock.createCallInst(tmpFunction,operands);
                }
                else{
                    //TODO
                    Value [] operands=new Value[2];
                    ArrayList<VarType> paraTypeList=new ArrayList<>();
                    paraTypeList.add(new VarType("char"));
                    Function tmpFunction=new Function(new ReturnType("void"), "putch", paraTypeList);
                    operands[0]=tmpFunction;
                    operands[1]=addExps.get(indexValue).value;
                    basicBlock.createCallInst(tmpFunction,operands);
                }
                indexValue++;
            }
            else if(varTypes.get(i).equals("int")){
                if(addExps.get(indexValue).type.equals("char")){
                    Value tmpZextInst=basicBlock.createZextInst(addExps.get(indexValue).value);
                    Value [] operands=new Value[2];
                    ArrayList<VarType> paraTypeList=new ArrayList<>();
                    paraTypeList.add(new VarType("int"));
                    Function tmpFunction=new Function(new ReturnType("void"), "putint", paraTypeList);
                    operands[0]=tmpFunction;
                    operands[1]=tmpZextInst;
                    basicBlock.createCallInst(tmpFunction,operands);
                } 
                else if(addExps.get(indexValue).type.equals("charImm")){
                    //TODO:理论上不会再出现
                    Value [] operands=new Value[2];
                    ArrayList<VarType> paraTypeList=new ArrayList<>();
                    paraTypeList.add(new VarType("int"));
                    Function tmpFunction=new Function(new ReturnType("void"), "putint", paraTypeList);
                    operands[0]=tmpFunction;
                    operands[1]=new Value(String.valueOf(((int)addExps.get(indexValue).value.name.charAt(1))));
                    basicBlock.createCallInst(tmpFunction,operands);
                }
                else{
                    //TODO
                    Value [] operands=new Value[2];
                    ArrayList<VarType> paraTypeList=new ArrayList<>();
                    paraTypeList.add(new VarType("int"));
                    Function tmpFunction=new Function(new ReturnType("void"), "putint", paraTypeList);
                    operands[0]=tmpFunction;
                    operands[1]=addExps.get(indexValue).value;
                    basicBlock.createCallInst(tmpFunction,operands);
                }
                indexValue++;
            }
            else if(varTypes.get(i).equals("str")){
                //TODO
                Value [] operands=new Value[3];
                ArrayList<VarType> paraTypeList=new ArrayList<>();
                paraTypeList.add(new VarType("str"));
                Function tmpFunction=new Function(new ReturnType("void"), "putstr", paraTypeList);
                operands[0]=tmpFunction;
                operands[1]=new Value(String.valueOf((formatStrings.get(indexStr).getLength(formatStrings.get(indexStr).content)+1)));
                operands[2]=formatStrings.get(indexStr);
                basicBlock.createCallInst(tmpFunction,operands);
                indexStr++;
            }
            
            
        }
    }

   

    public void output(BufferedWriter writer) throws IOException{
        // super.parentBasicBlock.getName();
        // int indexStr=0,indexValue=0;
        // for(int i=0;i<varTypes.size();i++){
        //     if(varTypes.get(i).equals("char")){
        //         if(((AddExp)addExps.get(indexValue)).type.equals("char")){
        //             zextInstructions.get(indexZext).output(writer);
        //             writer.write("\tcall void @putch(i32 "+zextInstructions.get(indexZext++).getName()+")\n");
                    
        //         }
        //         else writer.write("\tcall void @putch(i32 "+addExps.get(indexValue).value.getName()+")\n");
        //         indexValue++;
        //     }
        //     else if(varTypes.get(i).equals("int")){
        //         if(addExps.get(indexValue).type.equals("char")){
        //             zextInstructions.get(indexZext).output(writer);
        //             writer.write("\tcall void @putint(i32 "+zextInstructions.get(indexZext++).getName()+")\n");
        //         } 
        //         else if(addExps.get(indexValue).type.equals("charImm")){
        //             String str=String.valueOf((int)(addExps.get(indexValue).value.name.charAt(1)));
        //             writer.write("\tcall void @putint(i32 "+str+")\n");
        //         }
        //         else writer.write("\tcall void @putint(i32 "+addExps.get(indexValue).value.getName()+")\n");
        //         indexValue++;
        //     }
        //     else if(varTypes.get(i).equals("str")){
        //         String str=formatStrings.get(indexStr).content;
        //         int length=(formatStrings.get(indexStr).getLength(str)+1);
        //         writer.write("\tcall void @putstr(i8* getelementptr inbounds (["+length+" x i8], ["+length+" x i8]* "+formatStrings.get(indexStr).getName()+", i64 0, i64 0))\n");
        //         indexStr++;
        //     }
            
            
        // }
    }

}
