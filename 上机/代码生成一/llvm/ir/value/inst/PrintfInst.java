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
    StringConst format;
    ArrayList<AddExp> addExps=new ArrayList<>();
    ArrayList<String> strs=new ArrayList<>();
    ArrayList<String> varTypes=new ArrayList<>();
    ArrayList<FormatString> formatStrings=new ArrayList<FormatString>();



    public PrintfInst(Value... operands){
        super(operands);
        this.format=(StringConst)operands[0];
        for(int i=1;i<operands.length;i++){
            this.addExps.add((AddExp)operands[i]);
        }
        splitString();
    }
    public void splitString(){
        int start=1;
        for(int i=1;i<this.format.content.length()-1;i++){
            if(this.format.content.charAt(i)=='\\'){
                if(this.format.content.charAt(i+1)=='n'){
                    this.format.content=this.format.content.substring(0,i)+"\\0A"+this.format.content.substring(i+2,this.format.content.length());
                    i=i+2;
                }
                // else if(this.format.content.charAt(i+1)=='a'){
                //     this.format.content=this.format.content.substring(0,i)+"\\07"+this.format.content.substring(i+2,this.format.content.length());
                //     i=i+2;
                // }
                // else if(this.format.content.charAt(i+1)=='b'){
                //     this.format.content=this.format.content.substring(0,i)+"\\08"+this.format.content.substring(i+2,this.format.content.length());
                //     i=i+2;
                // }
                // else if(this.format.content.charAt(i+1)=='t'){
                //     this.format.content=this.format.content.substring(0,i)+"\\09"+this.format.content.substring(i+2,this.format.content.length());
                //     i=i+2;
                // }
                // else if(this.format.content.charAt(i+1)=='v'){
                //     this.format.content=this.format.content.substring(0,i)+"\\0B"+this.format.content.substring(i+2,this.format.content.length());
                //     i=i+2;
                // }
                // else if(this.format.content.charAt(i+1)=='f'){
                //     this.format.content=this.format.content.substring(0,i)+"\\0C"+this.format.content.substring(i+2,this.format.content.length());
                //     i=i+2;
                // }
                // else if(this.format.content.charAt(i+1)=='\"'){
                //     this.format.content=this.format.content.substring(0,i)+"\\22"+this.format.content.substring(i+2,this.format.content.length());
                //     i=i+2;
                // }
                // else if(this.format.content.charAt(i+1)=='\''){
                //     this.format.content=this.format.content.substring(0,i)+"\\27"+this.format.content.substring(i+2,this.format.content.length());
                //     i=i+2;
                // }
                // else if(this.format.content.charAt(i+1)=='\\'){
                //     this.format.content=this.format.content.substring(0,i)+"\\5C"+this.format.content.substring(i+2,this.format.content.length());
                //     i=i+2;
                // }
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

   

    public void output(BufferedWriter writer) throws IOException{
        // super.parentBasicBlock.getName();
        int indexStr=0,indexValue=0;
        for(int i=0;i<varTypes.size();i++){
            if(varTypes.get(i).equals("char")){
                if(((AddExp)addExps.get(indexValue)).type.equals("char")){
                    ZextInst newZextInst=new ZextInst(addExps.get(indexValue).value);
                    newZextInst.output(writer);
                    writer.write("\tcall void @putch(i32 "+newZextInst.getName()+")\n");
                    
                }
                else writer.write("\tcall void @putch(i32 "+addExps.get(indexValue).value.getName()+")\n");
                indexValue++;
            }
            else if(varTypes.get(i).equals("int")){
                if(addExps.get(indexValue).type.equals("char")){
                    ZextInst newZextInst=new ZextInst(addExps.get(indexValue).value);
                    newZextInst.output(writer);
                    writer.write("\tcall void @putint(i32 "+newZextInst.getName()+")\n");
                } 
                else if(addExps.get(indexValue).type.equals("charImm")){
                    String str=String.valueOf((int)(addExps.get(indexValue).value.name.charAt(1)));
                    writer.write("\tcall void @putint(i32 "+str+")\n");
                }
                else writer.write("\tcall void @putint(i32 "+addExps.get(indexValue).value.getName()+")\n");
                indexValue++;
            }
            else if(varTypes.get(i).equals("str")){
                String str=formatStrings.get(indexStr).content;
                int length=(formatStrings.get(indexStr).getLength(str)+1);
                writer.write("\tcall void @putstr(i8* getelementptr inbounds (["+length+" x i8], ["+length+" x i8]* "+formatStrings.get(indexStr).getName()+", i64 0, i64 0))\n");
                indexStr++;
            }
            
            
        }
    }

}
