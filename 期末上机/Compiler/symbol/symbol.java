package symbol;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import dataStructure.ASTNode.ASTNode;
import dataStructure.ASTNode.ENode;
import dataStructure.ASTNode.TNode;
import dataStructure.STT.STTNode;
import dataStructure.STT.STTQue;
import dataStructure.STT.STTQue.Element;

public class symbol {
    public static final Map<String, String> constSymbolType = new HashMap<>();
    public static final Map<String, String> varSymbolType = new HashMap<>();
    public static final Map<String, String> funcSymbolType = new HashMap<>();

    static{
        constSymbolType.put("int", "ConstInt");
        constSymbolType.put("char", "ConstChar");
        constSymbolType.put("intR", "ConstIntArray");
        constSymbolType.put("charR", "ConstCharArray");
        varSymbolType.put("int", "Int");
        varSymbolType.put("char", "Char");
        varSymbolType.put("intR", "IntArray");
        varSymbolType.put("charR", "CharArray");
        funcSymbolType.put("int", "IntFunc");
        funcSymbolType.put("char", "CharFunc");
        funcSymbolType.put("void", "VoidFunc");
    }

    public static String errorFile;
    public static STTQue currentSTTQue;
    public static STTNode STTRoot;
    public static STTNode currentSTTNode;
    public static int currentLevel=1;
    public static ArrayList<STTQue> funcSymbolTable=new ArrayList<>();
    public static ArrayList<Element> constSymbolTable=new ArrayList<>();


    public static int ISNOTFUNC=0;
    public static int VOIDFUNC=1;
    public static int OTHERFUNC=2;

    public static boolean forFlag=false;
    public static boolean inMainFlag=false;
    public static boolean rightFuncDefine=true;
    public static boolean addNewNodeFlag=true;
    public static boolean gErrorFlag=false;

    public static STTNode main(ASTNode ASTRoot,String inputErrorFile){
        errorFile=inputErrorFile;
        STTRoot = new STTNode(new STTQue(1));
        STTRoot.parent=null;
        currentSTTNode = STTRoot;
        currentSTTQue=currentSTTNode.que;
        ASTPreorder(ASTRoot);
        return STTRoot;
    }
    private static void ASTPreorder(ASTNode parent){
        
        if(parent instanceof ENode){
            if(!(((ENode)parent).errorType.equals("noType"))){
                writeError(((ENode)parent).errorType,((ENode)parent).lineNumber);
            } 
        } 
        else{
            symbolX.symbol(parent);
        }
        if(rightFuncDefine){
            for(ASTNode child:parent.children){
                ASTPreorder(child);
            }  
        }
        else rightFuncDefine=true;
        
    }
    
    public static void writeFile(String fileName, String content) {
        try{
            BufferedWriter writer = new BufferedWriter(new FileWriter(fileName, true));
            writer.write(content);
            writer.close();
        }catch (IOException e){
            e.printStackTrace();
        }
        
    }
    public static void writeError(String Type, int tmpLineNumber) {
        writeFile(errorFile, tmpLineNumber+" "+Type+"\n");
    } 
    public static ASTNode getASTNode(ASTNode node,int[] indexs){
        ASTNode ansNode=node;
        for(int index:indexs){
            ansNode=ansNode.children.get(index);
        }
        return ansNode;
    }
    public static String getASTNodeContent(ASTNode node,int[] indexs){ 
        int len=indexs.length;
        if(node instanceof ENode) return "error";
        else {
            ASTNode tmpNode=node;
            for(int i=0;i<len;i++){
                tmpNode=tmpNode.children.get(indexs[i]);
            }
            if(tmpNode instanceof TNode) return ((TNode)tmpNode).token;
            else return tmpNode.name;
        }
    }
}
