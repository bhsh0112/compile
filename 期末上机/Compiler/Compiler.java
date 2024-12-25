
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
        file = new File(errorFile);
        if (file.exists()) {
            file.delete();
        }

        totleTokens=lexer.main(inputFile,outputFile,errorFile);
        ASTRoot=parser.main(totleTokens,errorFile);
        STTRoot=symbol.main(ASTRoot,errorFile);
        if(!file.exists()){
            llvm.ir.Module.main(outputFile,ASTRoot);
        }
        
    }
    
}
