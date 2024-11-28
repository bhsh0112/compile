package parser;




import dataStructure.ASTNode.ASTNode;
import dataStructure.STT.STTQue;
import lex.lexer;

import symbol.symbol;

public class parser {
    public static ASTNode ASTRoot;
    public static String currentToken;
    public static String nextToken;
    public static String nnextToken;
    public static int token_index=0;
    public static int storedTokenIndex=0;
    public static int lineNumber=1;
    public static String[] totleTokens;
    public static String errorFile; 

    public static ASTNode main(String[] inputTotleTokens,String inputErrorFile) {
        totleTokens=inputTotleTokens;
        errorFile=inputErrorFile;
        parserX.main();
        return ASTRoot;
    }
    
    
    public static boolean isWords(String token) {
        return lexer.words.containsKey(token);
    }
    public static boolean isIdentifier(String token) {
        // Implement identifier detection logic here
        return token.matches("[a-zA-Z_][a-zA-Z0-9_]*");
    }

    // 定义一个方法来检查一个token是否是标识符。
    public static boolean isIntConst(String token) {
        // Implement integer constant detection logic here
        return token.matches("-?\\d+");
    }

    // 定义一个方法来检查一个token是否是整数常量。
    public static boolean isStringConst(String token) {
        // Implement string constant detection logic here
        return token.matches("\".*?\"");
    }

    // 定义一个方法来检查一个token是否是字符串常量。
    public static boolean isCharConst(String token) {
        // Implement character constant detection logic here
        return token.matches("\'(\\\\.|[^\\'])\'");
    }
    public static void get3Token(){
        currentToken=totleTokens[token_index];
        while(currentToken.equals("\n")&&token_index<totleTokens.length-1){
            lineNumber++;
            token_index++;
            currentToken=totleTokens[token_index];
        }
        if (token_index<totleTokens.length-1) nextToken=totleTokens[token_index+1];
        if(token_index<totleTokens.length-2) nnextToken=totleTokens[token_index+2];
        token_index++;
    }
    public static void backToken(){
        token_index--;
        currentToken=totleTokens[token_index-1];
        while(currentToken.equals("\n")){
            lineNumber--;
            token_index--;
            currentToken=totleTokens[token_index-1];
        }
        if (token_index<totleTokens.length-1) nextToken=totleTokens[token_index];
        if(token_index<totleTokens.length-2) nnextToken=totleTokens[token_index+1];

    }
    
}

