package llvm;

import dataStructure.ASTNode.ASTNode;
import dataStructure.ASTNode.NNode;
import dataStructure.ASTNode.TNode;
import dataStructure.ASTNode.ENode;
import dataStructure.STT.STTNode;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;

public class llvm {
    public static STTNode STTRoot;
    public static String outputFile;
    public static boolean globalFlag=true;
    public static void main(ASTNode ASTRoot,STTNode inputSTTRoot,String inputOutputFile){


        STTRoot=inputSTTRoot;
        outputFile=inputOutputFile;
        preOrder(ASTRoot);
    }
    private static void preOrder(ASTNode parent){
        if(parent==null) return;
        if(visitASTNode(parent))for(ASTNode child:parent.children){
            preOrder(child);
        }
    }
    private static boolean visitASTNode(ASTNode parent){
        System.out.println(parent.name);
        if(parent instanceof NNode){
            if(parent.name.equals("<MainFuncDef>")){
                globalFlag=false;
                llvmX.llvmMainFuncDef(parent);
                return true;
            }
            else if(parent.name.equals("<Stmt>")){
                llvmX.llvmStmt(parent);
                return true;
            }
            else if(parent.name.equals("<BlockItem>")){
                // writeFile(outputFile, "\t");
                return true;
            }
            else if(parent.name.equals("<ConstDecl>")){
                if(globalFlag){
                    System.out.println("global\n");
                    llvmX.llvmGlobalConstDecl(parent);
                }
                else{
                    llvmX.llvmLocalConstDecl(parent);
                }
            }
            else if(parent.name.equals("<VarDecl>")){
                if(globalFlag){
                    llvmX.llvmGlobalVarDecl(parent);
                }
                else{
                    llvmX.llvmLocalVarDecl(parent);
                }
                return true;
            }
            // else if(parent.name.equals("<AddExp>")){
            //     llvmX.llvmAddExp(parent);
            //     return false;
            // }
            return true;
        }
        else{
            if(((TNode)parent).token.equals("{")||((TNode)parent).token.equals("}")){
                writeFile(outputFile,((TNode)parent).token+"\n");
                return true;
            }
            return true;
        }
        
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
