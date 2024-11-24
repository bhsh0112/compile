
import java.io.File;
import java.io.IOException;

import dataStructure.ASTNode.ASTNode;
import dataStructure.STT.STTNode;
import lex.lexer;
import parser.parser;
import symbol.symbol;
import llvm.ir.*;


public class Compiler {
    public static String inputFile = "testfile.txt";
    public static String outputFile = "llvm_ir.txt";
    public static String errorFile = "error.txt";
    public static String[] totleTokens;
    public static ASTNode ASTRoot;
    public static STTNode STTRoot;

    public static void main(String[] args) throws IOException {
        File file = new File(outputFile);
        if (file.exists()) {
            file.delete();
        }

        totleTokens=lexer.main(inputFile,outputFile,errorFile);
        ASTRoot=parser.main(totleTokens,errorFile);
        STTRoot=symbol.main(ASTRoot,errorFile);
        // llvm.main(ASTRoot,STTRoot,outputFile);
        llvm.ir.Module.main(outputFile,ASTRoot);
        // STTPreorder(STTRoot);
    }
    // private static void STTPreorder(STTNode parent){
        
    //     for(Element element:parent.que.que){
    //         if((!element.type.equals("numofparams"))&&(!element.type.equals("return"))) symbol.writeFile(outputFile,element.level+" "+element.name+" "+element.type+"\n");
    //     }
    //     for(STTNode child:parent.children){
    //         STTPreorder(child);
    //     }
    // }
}
