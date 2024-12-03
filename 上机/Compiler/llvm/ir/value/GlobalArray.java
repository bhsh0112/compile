package llvm.ir.value;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;

import javax.swing.text.html.StyleSheet;

import dataStructure.ASTNode.ASTNode;
import llvm.ir.value.Type.VarType;
import symbol.symbol;

public class GlobalArray extends GlobalValue{
    VarType dataType;
    public int size;
    ArrayList<InitVal> initVals;
    public boolean StrConstFlag=false;

    public GlobalArray(VarType type,String name) {
        super(type,name);
        this.dataType = type;
    }

    public AddExp createSize(ASTNode ASTRoot) throws NumberFormatException, IOException{
        AddExp tmpSize=new AddExp(ASTRoot);
        BufferedWriter nousewriter=new BufferedWriter(new FileWriter("null"));
        size=Integer.valueOf(tmpSize.output(nousewriter));
        return tmpSize;
    }

    public ArrayList<InitVal> createInitVal(ASTNode InitRoot){
        initVals=new ArrayList<>();
        if(InitRoot.children.size()>0){
            if(InitRoot.children.get(0).name.equals("<StringConst>")){
                StrConstFlag=true;
                String str=symbol.getASTNodeContent(InitRoot,new int[] {0,0});
                str=str.substring(0, str.length() - 1);
                int length=str.length();
                for(int i=0;i<(size-length+1);i++){
                    str=str+"\\00";
                }
                str="c"+str+"\", align 1";//TODO:align1的含义
                initVals.add(new InitVal(new AddExp(str)));
            }
            else if(symbol.getASTNodeContent(InitRoot,new int[] {0}).equals("{")){
                for(int i=0;i<(InitRoot.children.size()-2)/2+1;i++){
                    initVals.add(new InitVal(dataType,new AddExp(symbol.getASTNode(InitRoot,new int[] {2*i+1,0}))));
                }
            }
        }
        else{
            String str=InitRoot.name;
            // str=str.substring(0, str.length());
            // int length=str.length();
            // for(int i=0;i<(size-length+1);i++){
            //     str=str+"\\00";
            // }
            // str="c"+str+"\\00\", align 1";//TODO:align1的含义
            initVals.add(new InitVal(new VarType("char"),new AddExp(str)));
        }
        return initVals;
    }
    public void output(BufferedWriter writer) throws IOException{
        if(StrConstFlag){
            writer.write(" "+initVals.get(0).val.ans);
        }
        else{
            writer.write("[");
            boolean firstFlag=true;
            for(InitVal initVal:initVals){
                if(firstFlag){
                    firstFlag=false;
                }
                else{
                    writer.write(",");
                }
                initVal.output(writer);
            }
            writer.write("]");
        }
        
    }
}
