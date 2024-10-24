import java.io.*;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;


import dataStructure.ASTNode.ASTNode;
import dataStructure.ASTNode.ENode;
import dataStructure.ASTNode.NNode;
import dataStructure.ASTNode.TNode;

import dataStructure.STT.STTNode;
import dataStructure.STT.STTStack;

public class Compiler {
    
    private static final Map<String, String> words = new HashMap<>();
    private static final Map<String, String> constSymbolType = new HashMap<>();
    private static final Map<String, String> varSymbolType = new HashMap<>();
    private static final Map<String, String> funcSymbolType = new HashMap<>();

    
    public static String currentToken;
    public static String nextToken;
    public static String nnextToken;
    public static int token_index=0;
    public static int storedTokenIndex=0;
    public static int lineNumber=1;
    public static String[] totleTokens;
    public static boolean zhuflag=false;
    public static String parserFile="parser.txt";
    public static String errorFile="error.txt";
    public static ASTNode ASTRoot;

    public static STTStack currentSTTStack;
    public static STTNode STTRoot;
    public static STTNode currentSTTNode;
    public static int currentLevel=0;
    public static ArrayList<STTStack> funcSymbolTable=new ArrayList<>();

    //build the directory "words"
    static {
        words.put("main", "MAINTK");
        words.put("const", "CONSTTK");
        words.put("int", "INTTK");
        words.put("char", "CHARTK");
        words.put("break", "BREAKTK");
        words.put("continue", "CONTINUETK");
        words.put("if", "IFTK");
        words.put("else", "ELSETK");
        words.put("for", "FORTK");
        words.put("getint", "GETINTTK");
        words.put("getchar", "GETCHARTK");
        words.put("printf", "PRINTFTK");
        words.put("return", "RETURNTK");
        words.put("void", "VOIDTK");
        words.put(";", "SEMICN");
        words.put("!", "NOT");
        words.put("*", "MULT");
        words.put(",", "COMMA");
        words.put("&&", "AND");
        words.put("||", "OR");
        words.put("/", "DIV");
        words.put("%", "MOD");
        words.put("(", "LPARENT");
        words.put(")", "RPARENT");
        words.put("[", "LBRACK");
        words.put("]", "RBRACK");
        words.put("{", "LBRACE");
        words.put("}", "RBRACE");
        words.put("<", "LSS");
        words.put("<=", "LEQ");
        words.put(">", "GRE");
        words.put(">=", "GEQ");
        words.put("==", "EQL");
        words.put("!=", "NEQ");
        words.put("+", "PLUS");
        words.put("-", "MINU");
        words.put("=", "ASSIGN");
    }
    //build the directory "SymbolType"
    static{
        constSymbolType.put("int", "ConstInt");
        constSymbolType.put("char", "ConstChar");
        constSymbolType.put("intR", "ConstIntArray");
        constSymbolType.put("charR", "ConstCharArray");
        varSymbolType.put("int", "Int");
        varSymbolType.put("char", "Char");
        varSymbolType.put("intR", "IntArray");
        varSymbolType.put("charR", "CharArray");
        funcSymbolType.put("int", "FuncInt");
        funcSymbolType.put("char", "FuncChar");
        funcSymbolType.put("void", "VoidFunc");
    }
    public static void main(String[] args) throws IOException{   
        File inputFile = new File("testfile.txt");

        BufferedReader reader = new BufferedReader(new FileReader(inputFile));

        StringBuilder sb = new StringBuilder();

        File file = new File(parserFile);
        if (file.exists()) {
            file.delete();
        }
        file = new File(errorFile);
        if (file.exists()) {
            file.delete();
        }

        String line;
        while ((line = reader.readLine()) != null) {
            if(line.isEmpty()){
                sb.append("\n").append("~_");
                continue;
            }
            String[] tokens = tokenize(line);
            for (String s : tokens) {
                sb.append(s).append("~_");
                
            }
            sb.append("\n").append("~_");
        }
        totleTokens=sb.toString().split("~_");
        reader.close();

        get3Token();
        parserComunit(); 
        STTRoot = new STTNode(new STTStack(-1));
        currentSTTNode = STTRoot;
        ASTPreorder(ASTRoot);       

    }
    private static void get3Token(){
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
    private static void backToken(){
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
    private static void writeFile(String fileName, String content) {
        try{
            BufferedWriter writer = new BufferedWriter(new FileWriter(fileName, true));
            writer.write(content);
            writer.close();
        }catch (IOException e){
            e.printStackTrace();
        }
        
    }
    private static void writeError(String Type, int tmpLineNumber) {
        writeFile(errorFile, tmpLineNumber+" "+Type+"\n");
    } 
    private static boolean isWords(String token) {
        return words.containsKey(token);
    }
    private static boolean isIdentifier(String token) {
        // Implement identifier detection logic here
        return token.matches("[a-zA-Z_][a-zA-Z0-9_]*");
    }

    // 定义一个方法来检查一个token是否是标识符。
    private static boolean isIntConst(String token) {
        // Implement integer constant detection logic here
        return token.matches("-?\\d+");
    }

    // 定义一个方法来检查一个token是否是整数常量。
    private static boolean isStringConst(String token) {
        // Implement string constant detection logic here
        return token.matches("\".*?\"");
    }

    // 定义一个方法来检查一个token是否是字符串常量。
    private static boolean isCharConst(String token) {
        // Implement character constant detection logic here
        return token.matches("\'(\\\\.|[^\\'])\'");
    }
    public static String[] tokenize(String code) {
        List<String> tokens = new ArrayList<>();
        //String first_patteString="(\\s+[\\S ]{1,}\\s+)";// 左右均为空格的字符串
        // 定义正则表达式模式
        String patternString = 
            "(\\b(main|const|int|char|break|continue|if|else|for|return|void|while)\\b)|" + // 关键字
            "(\\b(getint|getchar|printf)\\b)|"+//函数
            "(\\b[a-zA-Z_][a-zA-Z0-9_]*\\b)|" + // 标识符
            "(\\b\\d+\\b)|" + // 常量
            "(\".*?\")|" +
            "(//)|"+//单行注释
            "(==|!=|<=|>=|<|>|&&|\\|\\||=|\\+|-|/\\*|\\*/|/\\*|\\*/|\\*|/|%|\\{|\\}|\\(|\\)|\\[|\\]|;|,|&|!|\\|)|" + // 操作符
            "(\'(\\\\.|[^\\'])\')|"+
            "(\\s+)"; // 空白字符
        Pattern pattern = Pattern.compile(patternString);
        Matcher matcher = pattern.matcher(code);

        while (matcher.find()) {
            if(matcher.group().equals("/*")){
                zhuflag=true;
            }
            if(matcher.group().equals("*/")){
                zhuflag=false;
                continue;
            }
            if(matcher.group().equals("//")&&!zhuflag) break;
            if (!matcher.group().matches("\\s+")&&!zhuflag) { // 忽略空白字符
                tokens.add(matcher.group());
            }
        }
        return tokens.toArray(new String[0]);
    }
    public static String getErrorType(String token){
        if(token.equals("&")||token.equals("|")) return "a";
        else return "invalid error";
    }

    public static void parserComunit() {
        
        ASTRoot=new NNode("CompUnit");
        if(isDecl()){
            System.out.println(currentToken+" "+lineNumber);
            while(isDecl()){
                parserDecl(ASTRoot);
                get3Token();
            } 
        }
        if(isFuncDef()&&(!isMainFuncDef())){
            while(isFuncDef()&&(!isMainFuncDef())){
                parserFuncDef(ASTRoot);
                get3Token();
            } 
        }
        if(isMainFuncDef()){
            parserMainFuncDef(ASTRoot);
        }
        
    }
    public static void parserDecl(ASTNode parent){
        ASTNode curNode = addNode(parent, new NNode("Decl"));
        if(isConstDecl()) parserConstDecl(curNode);
        else parserVarDecl(curNode);
    }
    public static void parserConstDecl(ASTNode parent){
        ASTNode curNode = addNode(parent, new NNode("ConstDecl"));
        addNode(curNode, new TNode("const","leaf"));
        get3Token();
        parserBType(curNode);
        get3Token();
        parserConstDef(curNode);
        get3Token();
        while(currentToken.equals(",")){
            addNode(curNode, new TNode(",","leaf"));
            get3Token();
            if(isConstDef()) parserConstDef(curNode);
            else{
                backToken();
                addNode(curNode, new ENode("i",lineNumber,"error"));
            } 
            get3Token();
        }
        
        if(currentToken.equals(";")) addNode(curNode, new TNode(";","leaf"));
        else{
            backToken();
            addNode(curNode, new ENode("i",lineNumber,"error"));
        } 
    }
    public static void parserBType(ASTNode parent){
        ASTNode curNode = addNode(parent, new NNode("BType"));
        if(isBType()) addNode(curNode, new TNode(currentToken,currentToken));
        else{
            backToken();
            addNode(curNode, new ENode("i",lineNumber,"error"));
        } 
    }
    public static void parserConstDef(ASTNode parent){
        ASTNode curNode = addNode(parent, new NNode("ConstDef"));
        if(isIdentifier(currentToken)) parserIdent(curNode);
        else{
            backToken();
            addNode(curNode, new ENode("k",lineNumber,"error"));
        } 
        get3Token();
        if(currentToken.equals("[")){
            addNode(curNode, new TNode("[","leaf"));
            get3Token();
            if(isConstExp()) parserConstExp(curNode);
            else {
                backToken();
                addNode(curNode, new ENode("k",lineNumber,"error"));
            }
            get3Token();
            if(currentToken.equals("]")) addNode(curNode, new TNode("]","leaf"));
            else{
                backToken();
                addNode(curNode, new ENode("k",lineNumber,"error"));
            } 
            get3Token();
        }
        if(currentToken.equals("=")){
            addNode(curNode, new TNode("=","leaf"));
            get3Token();
            
            parserConstInitVal(curNode);
        } 
        else{
            backToken();
            addNode(curNode, new ENode("k",lineNumber,"error"));
        } 
    }
    public static void parserConstInitVal(ASTNode parent){
        ASTNode curNode = addNode(parent, new NNode("ConstInitVal"));
        if(isConstExp()) parserConstExp(curNode);
        else if(isStringConst(currentToken)) parserStringConst(curNode);
        else{
            if(currentToken.equals("{")) addNode(curNode, new TNode("{","leaf"));
            else{
                backToken();
                addNode(curNode, new ENode("noType",lineNumber,"error"));
            } 
            get3Token();
            if(currentToken.equals("}")) addNode(curNode, new TNode("}","leaf"));
            else{
                parserConstExp(curNode);
                get3Token();
                while(currentToken.equals(",")){
                    addNode(curNode, new TNode(",","leaf"));
                    get3Token();
                    if(isConstExp()) parserConstExp(curNode);
                    else{
                        backToken();
                        addNode(curNode, new ENode("noType",lineNumber,"error"));
                    } 
                    get3Token();
                }
                if(currentToken.equals("}")) addNode(curNode, new TNode("}","leaf"));
                else{
                    backToken();
                    addNode(curNode, new ENode("noType",lineNumber,"error"));
                } 
            }
        }
    }
    public static void parserVarDecl(ASTNode parent){
        ASTNode curNode = addNode(parent, new NNode("VarDecl"));
        parserBType(curNode);
        get3Token();
        parserVarDef(curNode);
        get3Token();
        while(currentToken.equals(",")){
            addNode(curNode, new TNode(",","leaf"));
            get3Token();
            parserVarDef(curNode);
            get3Token();
        }
        if(currentToken.equals(";")) addNode(curNode, new TNode(";","leaf"));
        else{
            backToken();
            addNode(curNode, new ENode("i",lineNumber,"error"));
            
        }
    }
    public static void parserVarDef(ASTNode parent){
        ASTNode curNode = addNode(parent, new NNode("VarDef"));
        parserIdent(curNode);
        get3Token();
        if(currentToken.equals("[")){
            addNode(curNode, new TNode("[","leaf"));
            get3Token();
            parserConstExp(curNode);
            get3Token();
            if(currentToken.equals("]")) addNode(curNode, new TNode("]","leaf"));
            else{
                backToken();
                addNode(curNode, new ENode("k",lineNumber,"error"));
            } 
            get3Token();
        }
        
        if(currentToken.equals("=")){
            addNode(curNode, new TNode("=","leaf"));
            get3Token();
            parserInitVal(curNode);
        }
        else{
            backToken();
        } 
    }
    public static void parserIdent(ASTNode parent){
        ASTNode curNode = addNode(parent, new NNode("Ident"));
        addNode(curNode, new TNode(currentToken,"leaf"));
    }
    private static void parserStringConst(ASTNode parent){
        ASTNode curNode = addNode(parent, new NNode("StringConst"));
        addNode(curNode, new TNode(currentToken,"leaf"));
    }
    private static void parserInitVal(ASTNode parent){
        ASTNode curNode = addNode(parent, new NNode("InitVal"));
        if(isExp()) parserExp(curNode);
        else if(isStringConst(currentToken)) parserStringConst(curNode);
        else{
            if(currentToken.equals("{")) addNode(curNode, new TNode("{","leaf"));
            else{
                backToken();
                addNode(curNode, new ENode("noType",lineNumber,"error"));
            } 
            get3Token();
            if(isExp()){
                parserExp(curNode);
                get3Token();
                while(currentToken.equals(",")){
                    addNode(curNode, new TNode(",","leaf"));
                    get3Token();
                    parserExp(curNode);
                    get3Token();
                }
            }
            if (currentToken.equals("}")) addNode(curNode, new TNode("}","leaf"));
            else{
                backToken();
                addNode(curNode, new ENode("noType",lineNumber,"error"));
            } 
        }
    }
    public static void parserConstExp(ASTNode parent){
        ASTNode curNode = addNode(parent, new NNode("ConstExp"));
        parserAddExp(curNode);
    }
    public static void parserMainFuncDef(ASTNode parent){
        ASTNode curNode = addNode(parent, new NNode("MainFuncDef"));
        if(currentToken.equals("int")) addNode(curNode, new TNode(currentToken,"leaf"));
        else{
            backToken();
            addNode(curNode, new ENode("j",lineNumber,"error"));
        } 
        get3Token();
        if(currentToken.equals("main")) addNode(curNode, new TNode("main","leaf"));
        else{
            backToken();
            addNode(curNode, new ENode("j",lineNumber,"error"));
        } 
        get3Token();
        if(currentToken.equals("(")) addNode(curNode, new TNode("(","leaf"));
        else{
            backToken();
            addNode(curNode, new ENode("j",lineNumber,"error"));
        } 
        get3Token();
        if(currentToken.equals(")")) addNode(curNode, new TNode(")","leaf"));
        else{
            backToken();
            addNode(curNode, new ENode("j",lineNumber,"error"));
        } 
        get3Token();
        parserBlock(curNode);
    }
    public static void parserFuncDef(ASTNode parent){
        ASTNode curNode = addNode(parent, new NNode("FuncDef"));
        if(isFuncType()) parserFuncType(curNode);
        else{
            backToken();
            addNode(curNode, new ENode("j",lineNumber,"error"));
        } 
        get3Token();
        if(isIdentifier(currentToken)) parserIdent(curNode);
        else{
            backToken();
            addNode(curNode, new ENode("j",lineNumber,"error"));
        } 
        get3Token();
        if(currentToken.equals("(")) addNode(curNode, new TNode("(","leaf"));
        else{
            backToken();
            addNode(curNode, new ENode("j",lineNumber,"error"));
        } 
        get3Token();
        if(isFuncFParams()) parserFuncFParams(curNode);
        else{
            backToken();
        } 
        get3Token();
        if(currentToken.equals(")")) addNode(curNode, new TNode(")","leaf"));
        else{
            backToken();
            addNode(curNode, new ENode("j",lineNumber,"error"));
        } 
        get3Token();
        parserBlock(curNode);
    }
    public static void parserFuncType(ASTNode parent){
        ASTNode curNode = addNode(parent, new NNode("FuncType"));
        if(currentToken.equals("int")) addNode(curNode, new TNode(currentToken,"leaf"));
        else if(currentToken.equals("char")) addNode(curNode, new TNode(currentToken,"leaf"));
        else if(currentToken.equals("void")) addNode(curNode, new TNode(currentToken,"leaf"));
        else{
            backToken();
            addNode(curNode, new ENode("j",lineNumber,"error"));
        } 
    }
    public static void parserFuncFParams(ASTNode parent){
        ASTNode curNode = addNode(parent, new NNode("FuncFParams"));
        parserFuncFParam(curNode);
        get3Token();
        while(currentToken.equals(",")){
            addNode(curNode, new TNode(",","leaf"));
            get3Token();
            if(isFuncFParams()){
                parserFuncFParam(curNode);
                get3Token();
            } 
            else{
                addNode(curNode, new ENode("noType",lineNumber,"error"));
            } 
        }
        backToken();
    }
    public static void parserFuncFParam(ASTNode parent){
        ASTNode curNode = addNode(parent, new NNode("FuncFParam"));
        parserBType(curNode);
        get3Token();
        parserIdent(curNode);
        get3Token();
        if(currentToken.equals("[")){
            addNode(curNode, new TNode("[","leaf"));
            get3Token();
            if(currentToken.equals("]")){
                addNode(curNode, new TNode("]","leaf"));
            }
            else{
                backToken();
                addNode(curNode, new ENode("k",lineNumber,"error"));
            } 
        }
        else{
            backToken();
        } 
        
    }
    public static void parserBlock(ASTNode parent){
        ASTNode curNode = addNode(parent, new NNode("Block"));
        if(currentToken.equals("{")) addNode(curNode, new TNode("{","leaf"));
        else{
            backToken();
            addNode(curNode, new ENode("noType",lineNumber,"error"));
        } 
        get3Token();
        while(isBlockItem()){
            parserBlockItem(curNode);
            get3Token();
        }
        if(currentToken.equals("}")) addNode(curNode, new TNode("}","leaf"));
        else{
            backToken();
            addNode(curNode, new ENode("noType",lineNumber,"error"));
        } 
    }
    public static void parserBlockItem(ASTNode parent){
        ASTNode curNode = addNode(parent, new NNode("BlockItem"));
        if(isDecl()){
            parserDecl(curNode);
        } 
        else{

            parserStmt(curNode);
        } 
    }
    public static void parserStmt(ASTNode parent){
        
        ASTNode curNode = addNode(parent, new NNode("Stmt"));
        if(currentToken.equals("if")&&nextToken.equals("(")){
            addNode(curNode, new TNode("if","leaf"));
            get3Token();
            addNode(curNode, new TNode("(","leaf"));
            get3Token();
            parserCond(curNode);
            get3Token();
            if(currentToken.equals(")"))addNode(curNode, new TNode(")","leaf"));
            else{
                backToken();
                addNode(curNode, new ENode("j",lineNumber,"error"));
            } 
            get3Token();
            parserStmt(curNode);
            get3Token();
            if(currentToken.equals("else")){
                addNode(curNode, new TNode("else","leaf"));
                get3Token();
                parserStmt(curNode);
            } 
            else backToken();
        }
        else if(currentToken.equals("for")&&nextToken.equals("(")){
            addNode(curNode, new TNode("for","leaf"));
            get3Token();
            addNode(curNode, new TNode("(","leaf"));
            get3Token();
            if(isForStmt()){
                parserForStmt(curNode);
                get3Token();
            }
            
            if(currentToken.equals(";"))addNode(curNode, new TNode(";","leaf"));
            else{
                backToken();
                addNode(curNode, new ENode("noType",lineNumber,"error"));
            } 
            get3Token();
            if(isCond()){
                parserCond(curNode);
                get3Token();
            }
            
            if(currentToken.equals(";"))addNode(curNode, new TNode(";","leaf"));
            else{
                backToken();
                addNode(curNode, new ENode("noType",lineNumber,"error"));
            } 
            get3Token();
            if(isForStmt()){
                parserForStmt(curNode);
                get3Token();
            }
            if(currentToken.equals(")"))addNode(curNode, new TNode(")","leaf"));
            else{
                backToken();
                addNode(curNode, new ENode("noType",lineNumber,"error"));
            } 
            get3Token();
            parserStmt(curNode);
        }
        else if(currentToken.equals("break")&&nextToken.equals(";")){
            addNode(curNode, new TNode("break","leaf"));
            get3Token();
            addNode(curNode, new TNode(";","leaf"));
        }
        else if(currentToken.equals("continue")&&nextToken.equals(";")){
            addNode(curNode, new TNode("continue","leaf"));
            get3Token();
            addNode(curNode, new TNode(";","leaf"));
        }
        else if(currentToken.equals("return")){
            addNode(curNode, new TNode("return","leaf"));
            get3Token();
            System.out.println(currentToken+" "+lineNumber);
            if(isExp()&&(!totleTokens[token_index-2].equals("\n"))){
                parserExp(curNode);
                get3Token();
            }
            System.out.println(currentToken+" "+lineNumber);
            if(currentToken.equals(";")) addNode(curNode, new TNode(";","leaf"));
            else{
                backToken();
                addNode(curNode, new ENode("i",lineNumber,"error"));
            } 
            
        }
        else if(currentToken.equals("printf")&&nextToken.equals("(")){
            addNode(curNode, new TNode("printf","leaf"));
            get3Token();
            addNode(curNode, new TNode("(","leaf"));
            get3Token();
            parserStringConst(curNode);
            get3Token();
            while(currentToken.equals(",")){
                addNode(curNode, new TNode(",","leaf"));
                get3Token();
                parserExp(curNode);
                get3Token();
            }
            if(currentToken.equals(")"))addNode(curNode, new TNode(")","leaf"));
            else{
                backToken();
                addNode(curNode, new ENode("j",lineNumber,"error"));
            } 
            get3Token();
            if(currentToken.equals(";"))addNode(curNode, new TNode(";","leaf"));
            else{
                backToken();
                addNode(curNode, new ENode("i",lineNumber,"error"));
            } 
        }
        else if(currentToken.equals("{")){//Block
            parserBlock(curNode);
        }
        else if(currentToken.equals(";")){
            addNode(curNode, new TNode(";","leaf"));
        }
        
        else if(isLVal()){
            parserLVal(curNode);
            get3Token();
            if(currentToken.equals("=")) addNode(curNode, new TNode("=", "leaf"));
            else{
                backToken();
                addNode(curNode, new ENode("i",lineNumber,"error"));
            } 
            get3Token();
            if(isExp()&&(!currentToken.equals("getint"))&&(!currentToken.equals("getchar"))){
                parserExp(curNode);
                get3Token();
                if(currentToken.equals(";"))addNode(curNode, new TNode(";","leaf"));
                else{
                    backToken();
                    addNode(curNode, new ENode("i",lineNumber,"error"));
                } 
            }
            else if(currentToken.equals("getint")){
                addNode(curNode, new TNode("getint","leaf"));
                get3Token();
                if(currentToken.equals("("))addNode(curNode, new TNode("(","leaf"));
                else{
                    backToken();
                    addNode(curNode, new ENode("j",lineNumber,"error"));
                } 
                get3Token();
                if(currentToken.equals(")"))addNode(curNode, new TNode(")","leaf"));
                else{
                    backToken();
                    addNode(curNode, new ENode("j",lineNumber,"error"));
                } 
                get3Token();
                if(currentToken.equals(";"))addNode(curNode, new TNode(";","leaf"));
                else{
                    backToken();
                    addNode(curNode, new ENode("i",lineNumber,"error"));
                } 
            }
            else if(currentToken.equals("getchar")){
                addNode(curNode, new TNode("getchar","leaf"));
                get3Token();
                if(currentToken.equals("("))addNode(curNode, new TNode("(","leaf"));
                else{
                    backToken();
                    addNode(curNode, new ENode("j",lineNumber,"error"));
                } 
                get3Token();
                if(currentToken.equals(")"))addNode(curNode, new TNode(")","leaf"));
                else{
                    backToken();
                    addNode(curNode, new ENode("j",lineNumber,"error"));
                } 
                get3Token();
                if(currentToken.equals(";"))addNode(curNode, new TNode(";","leaf"));
                else{
                    backToken();
                    addNode(curNode, new ENode("i",lineNumber,"error"));
                } 
            }
        }
        else{
            parserExp(curNode);
            get3Token();
            if(currentToken.equals(";"))addNode(curNode, new TNode(";","leaf"));
            else{
                backToken();
                addNode(curNode, new ENode("i",lineNumber,"error"));
            } 
        }
    }
    public static void parserForStmt(ASTNode parent){
        ASTNode curNode = addNode(parent, new NNode("ForStmt"));
        
        parserLVal(curNode);
        get3Token();
        if(currentToken.equals("=")) addNode(curNode, new TNode("=", "leaf"));
        else{
            backToken();
            addNode(curNode, new ENode("i",lineNumber,"error"));
        } 
        get3Token();
        parserExp(curNode);
    }
    public static void parserExp(ASTNode parent){
        ASTNode curNode = addNode(parent, new NNode("Exp"));
        parserAddExp(curNode);
    }
    public static void parserCond(ASTNode parent){
        ASTNode curNode = addNode(parent, new NNode("Cond"));
        parserLOrExp(curNode);
    }
    public static void parserLVal(ASTNode parent){
        ASTNode curNode = addNode(parent, new NNode("LVal"));
        parserIdent(curNode);
        get3Token();
        if(currentToken.equals("[")){
            addNode(curNode, new TNode("[","leaf"));
            get3Token();
            parserExp(curNode);
            get3Token();
            if(currentToken.equals("]")) addNode(curNode, new TNode("]","leaf"));
            else{
                backToken();
                addNode(curNode, new ENode("k",lineNumber,"error"));
            } 
        }
        else backToken();
    }
    public static void parserPrimaryExp(ASTNode parent){
        ASTNode curNode = addNode(parent, new NNode("PrimaryExp"));
        if(currentToken.equals("(")){
            addNode(curNode, new TNode("(","leaf"));
            get3Token();
            parserExp(curNode);
            get3Token();
            if(currentToken.equals(")")) addNode(curNode, new TNode(")","leaf"));
            else{
                backToken();
                addNode(curNode, new ENode("j",lineNumber,"error"));
            } 
        }
        else if(isCharConst(currentToken)){
            parserCharacter(curNode);
            
        }
        else if(isNumber()){
            parserNumber(curNode);
        }
        else{
            parserLVal(curNode);
        }
    }
    public static void parserNumber(ASTNode parent){
        ASTNode curNode = addNode(parent, new NNode("Number"));
        if(isIntConst(currentToken)) addNode(curNode, new TNode(currentToken,"leaf"));
        else{
            backToken();
            addNode(curNode, new ENode("noType",lineNumber,"error"));
        } 
    }
    public static void parserCharacter(ASTNode parent){
        ASTNode curNode = addNode(parent, new NNode("Character"));
        if(isCharConst(currentToken)) addNode(curNode, new TNode(currentToken,"leaf"));
        else{
            backToken();
            addNode(curNode, new ENode("noType",lineNumber,"error"));
        }
    }
    public static void parserUnaryExp(ASTNode parent){
        ASTNode curNode = addNode(parent, new NNode("UnaryExp"));
        if(isUnaryOP()){
            parserUnaryOp(curNode);
            get3Token();
            parserUnaryExp(curNode);
        }
        else if(isIdentifier(currentToken)&&nextToken.equals("(")){
            parserIdent(curNode);
            
            get3Token();
            if(currentToken.equals("(")) addNode(curNode, new TNode("(","leaf"));
            else{
                backToken();
                addNode(curNode, new ENode("j",lineNumber,"error"));
            } 
            get3Token();
            if(isFuncRParams()&&(!totleTokens[token_index-2].equals("\n"))){
                parserFuncRParams(curNode);
                get3Token();
            }
            if(currentToken.equals(")")) addNode(curNode, new TNode(")","leaf"));
            else{
                backToken();
                addNode(curNode, new ENode("j",lineNumber,"error"));
            } 
        }
        else{
            parserPrimaryExp(curNode);
        }
    }
    public static void parserUnaryOp(ASTNode parent){
        ASTNode curNode = addNode(parent, new NNode("UnaryOp"));
        if(currentToken.equals("-")) addNode(curNode, new TNode("-","leaf"));
        else if(currentToken.equals("+")) addNode(curNode, new TNode("+","leaf"));
        else if(currentToken.equals("!")) addNode(curNode, new TNode("!","leaf"));
        else{
            backToken();
            addNode(curNode, new ENode("k",lineNumber,"error"));
        } 
    }
    public static void parserFuncRParams(ASTNode parent){
        ASTNode curNode = addNode(parent, new NNode("FuncRParams"));
        parserExp(curNode);
        get3Token();
        while(currentToken.equals(",")){
            addNode(curNode, new TNode(",","leaf"));
            get3Token();
            parserExp(curNode);
            get3Token();
        }
        backToken();
    }
    public static void parserMulExp(ASTNode parent){
        ASTNode curNode = addNode(parent, new NNode("MulExp"));
        parserUnaryExp(curNode);
        get3Token();
        while(currentToken.equals("*")||currentToken.equals("/")||currentToken.equals("%")){
            ASTNode newNode=insertNode(parent,curNode, new NNode("MulExp"));
            addNode(newNode, new TNode(currentToken,"leaf"));
            get3Token();
            parserUnaryExp(newNode);
            get3Token();
            curNode = newNode;
        }
        backToken();
    }
    public static void parserAddExp(ASTNode parent){
        ASTNode curNode = addNode(parent, new NNode("AddExp"));
        parserMulExp(curNode);
        
        get3Token();
        while(currentToken.equals("+")||currentToken.equals("-")){
            ASTNode newNode=insertNode(parent,curNode, new NNode("AddExp"));
            addNode(newNode, new TNode(currentToken,"leaf"));
            get3Token();
            parserMulExp(newNode);
            get3Token();
            curNode = newNode;
        }
        backToken();
    }
    public static void parserRelExp(ASTNode parent){
        ASTNode curNode = addNode(parent, new NNode("RelExp"));
        parserAddExp(curNode);
        get3Token();
        while(currentToken.equals("<")||currentToken.equals(">")||currentToken.equals("<=")||currentToken.equals(">=")){
            ASTNode newNode=insertNode(parent,curNode, new NNode("RelExp"));
            addNode(newNode, new TNode(currentToken,"leaf"));
            get3Token();
            parserAddExp(newNode);
            get3Token();
            curNode = newNode;
        }
        backToken();
    }
    public static void parserEqExp(ASTNode parent){
        ASTNode curNode = addNode(parent, new NNode("EqExp"));
        parserRelExp(curNode);
        get3Token();
        while(currentToken.equals("==")||currentToken.equals("!=")){
            ASTNode newNode=insertNode(parent,curNode, new NNode("EqExp"));
            addNode(newNode, new TNode(currentToken,"leaf"));
            get3Token();
            parserRelExp(newNode);
            get3Token();
            curNode = newNode;
        }
        backToken();
    }
    public static void parserLAndExp(ASTNode parent){
        ASTNode curNode = addNode(parent, new NNode("LAndExp"));
        parserEqExp(curNode);
        get3Token();
        while(currentToken.equals("&&")||currentToken.equals("&")){
            ASTNode newNode=insertNode(parent,curNode, new NNode("LAndExp"));
            if(currentToken.equals("&")) addNode(newNode, new ENode("a",lineNumber,"error"));
            else addNode(newNode, new TNode("&&","leaf"));
            get3Token();
            parserEqExp(newNode);
            get3Token();
            curNode = newNode;
        }
        backToken();
    }
    public static void parserLOrExp(ASTNode parent){
        ASTNode curNode = addNode(parent, new NNode("LOrExp"));
        parserLAndExp(curNode);
        get3Token();
        while(currentToken.equals("||")){
            ASTNode newNode=insertNode(parent,curNode, new NNode("LOrExp"));
            addNode(newNode, new TNode(currentToken,"leaf"));
            get3Token();
            parserLAndExp(newNode);
            get3Token();
            curNode = newNode;
        }
        backToken();
    }


    //isX-parser 以下判断仅满足X在所在语句中与其他有歧义语法成分的区分，不能作为X的判定标志
    public static boolean isDecl(){
        return isConstDecl()||isVarDecl();
    }
    public static boolean isVarDecl(){
        return ((currentToken.equals("int")||currentToken.equals("char"))&&(isIdentifier(nextToken))&&(!nnextToken.equals("(")));
    }
    public static boolean isFuncDef(){
        return (currentToken.equals("int")||currentToken.equals("char")||currentToken.equals("void"))&&isIdentifier(nextToken)&&nnextToken.equals("(");
    }
    public static boolean isMainFuncDef(){
        return (currentToken.equals("int"))&&nextToken.equals("main")&&nnextToken.equals("(");
    }
    public static boolean isBType(){
        return (currentToken.equals("int")||currentToken.equals("char"));
    }
    public static boolean isConstDecl(){
        return (currentToken.equals("const"));
    }
    public static boolean isConstDef(){
        return isIdentifier(currentToken)&&(nextToken.equals("=")||nextToken.equals("["));
    }
    public static boolean isPrimaryExp(){
        int flag=0;
        if(currentToken.equals("(")){
            get3Token();
            
            if(isExp()){
                flag=1;
            }
            backToken();
        }
        else if(isIdentifier(currentToken)) flag=1;
        else if(isNumber()) flag=1;
        else if(isCharConst(currentToken)) flag=1;
        return flag==1;
        
    }
    public static boolean isConstExp(){
        return isUnaryExp();   
    }
    public static boolean isExp(){
        return isUnaryExp();
    }
    public static boolean isUnaryExp(){
        return isPrimaryExp()||(isIdentifier(currentToken)&&nextToken.equals("("))||isUnaryOP();
    }
    public static boolean isUnaryOP(){
        return currentToken.equals("+")||currentToken.equals("-")||currentToken.equals("!");
    }
    public static boolean isFuncType(){
        return (currentToken.equals("int")||currentToken.equals("char")||currentToken.equals("void"));
    }
    public static boolean isFuncFParams(){
        return ((currentToken.equals("int")||currentToken.equals("char"))&&(isIdentifier(nextToken)));
    }
    public static boolean isInitVal(){
        return (isExp()||isStringConst(currentToken)||(currentToken.equals("{")));
    }
    public static boolean isBlockItem(){
        return isDecl()||isStmt();
    }
    public static boolean isStmt(){
        return currentToken.equals("if")||currentToken.equals("for")||currentToken.equals("break")||currentToken.equals("continue")||currentToken.equals("return")||currentToken.equals("printf")||currentToken.equals("{")||currentToken.equals(";")||isExp()||isLVal();
    }
    public static boolean isLVal(){
        int flag=0;
        for(int i=token_index-1;;i++){
            if(totleTokens[i].equals("\n")) break;
            if(totleTokens[i].equals("=")){
                flag=1;
                break;
            } 
        }
        return flag==1&&isIdentifier(currentToken);
    }
    public static boolean isCond(){
        return isUnaryExp();
    }
    public static boolean isForStmt(){
        return isLVal();
    }
    public static boolean isNumber(){
        return isIntConst(currentToken);
    }
    public static boolean isFuncRParams(){
        return isExp();
    }
    public static boolean isMulExp(){
        return isUnaryExp();
    }
    public static boolean isAddExp(){
        return isMulExp();
    }
    public static boolean isRelExp(){
        return isAddExp();
    }
    public static boolean isEqExp(){
        return isRelExp();
    }
    public static boolean isLAndExp(){
        return isEqExp();
    }
    public static boolean isLOrExp(){
        return isLAndExp();
    }

    //tree node
    private static ASTNode addNode(ASTNode Parent,ASTNode Child){
        if(Child instanceof TNode){
            Parent.addChild(Child);
        } else if (Child instanceof NNode){
            Parent.addChild(Child);
            return Child;
        } else if (Child instanceof ENode){
            Parent.addChild(Child);
        }
        return null;
    }
    private static ASTNode insertNode(ASTNode Parent, ASTNode Child, ASTNode Insert){
        delNode(Parent, Child);
        Insert.addChild(Child);
        Parent.addChild(Insert);
        return Insert;
    }
    private static void delNode(ASTNode Parent, ASTNode Child){
        Parent.removeChild(Child);
    }
    
    private static void ASTPreorder(ASTNode parent){
        if(parent instanceof ENode){
            if(!(((ENode)parent).errorType.equals("noType"))) writeError(((ENode)parent).errorType,((ENode)parent).lineNumber);
        } 
        // else if(parent instanceof TNode){
        //     String tmp_token=((TNode)parent).token;
        //     if (isWords(tmp_token)) {
        //         writeFile(parserFile, words.get(tmp_token) + " " + tmp_token + "\n");
        //     } else if (isIntConst(tmp_token)) {
        //         writeFile(parserFile, "INTCON"+ " " + tmp_token + "\n");
        //     } else if (isStringConst(tmp_token)) {
        //         writeFile(parserFile, "STRCON"+" " + tmp_token + "\n");
        //     } else if (isCharConst(tmp_token)) {
        //         writeFile(parserFile, "CHRCON " + tmp_token + "\n");
        //     }  else if (isIdentifier(tmp_token)) {
        //         writeFile(parserFile, "IDENFR " + tmp_token + "\n");
        //     } 
        // }
        // else{
        //     if(parent.name.equals("<StringConst>")||parent.name.equals("<Ident>")||parent.name.equals("<BType>")||parent.name.equals("<Decl>")||parent.name.equals("<BlockItem>")){

        //     }
        //     else writeFile(parserFile, parent.name + "\n");
        // }
        else{
            symbol(parent);
        }
        for(ASTNode child:parent.children){
            ASTPreorder(child);
        }
        
        
        
    }
    private static void symbol(ASTNode parent){
        if(parent.name.equals("<VarDecl>")) {
            int childrenNum=parent.children.size();
            int varNum=(childrenNum-1)/2;
            String tmpVarType=((TNode)(((NNode)parent.children.get(0)).children.get(0))).token;
            String tmpVarName=((TNode)(((NNode)parent.children.get(1)).children.get(0).children.get(0))).token;
            if(((TNode)(((NNode)parent.children.get(1)).children.get(0).children.get(1))).token.equals("[")) tmpVarType=tmpVarType+"R";
            currentSTTNode.stack.pushStack(currentLevel,tmpVarName,varSymbolType.get(tmpVarType));
            for(int i=2;i<=varNum;i++){
                tmpVarName=((TNode)(((NNode)parent.children.get(2*i-1)).children.get(0).children.get(0))).token;
                if(((TNode)(((NNode)parent.children.get(2*i-1)).children.get(0).children.get(1))).token.equals("[")) tmpVarType=tmpVarType+"R";
                currentSTTNode.stack.pushStack(currentLevel,tmpVarName,varSymbolType.get(tmpVarType));
            }
        }
        else if(parent.name.equals("<ConstDecl>")) {
            int childrenNum=parent.children.size();
            int varNum=(childrenNum-2)/2;
            String tmpVarType=((TNode)(((NNode)parent.children.get(1)).children.get(0))).token;
            String tmpVarName=((TNode)(((NNode)parent.children.get(2)).children.get(0).children.get(0))).token;
            if(((TNode)(((NNode)parent.children.get(2)).children.get(0).children.get(1))).token.equals("[")) tmpVarType=tmpVarType+"R";
            currentSTTNode.stack.pushStack(currentLevel,tmpVarName,constSymbolType.get(tmpVarType));
            for(int i=2;i<=varNum;i++){
                tmpVarName=((TNode)(((NNode)parent.children.get(2*i)).children.get(0).children.get(0))).token;
                if(((TNode)(((NNode)parent.children.get(2*i)).children.get(0).children.get(1))).token.equals("[")) tmpVarType=tmpVarType+"R";
                currentSTTNode.stack.pushStack(currentLevel,tmpVarName,constSymbolType.get(tmpVarType));
            }
        }
        else if(parent.name.equals("<FuncDef>")) {
            STTStack newStack=new STTStack(-1);
            newStack.pushStack(-1,((TNode)((NNode)parent.children.get(1)).children.get(0)).token,((TNode)((NNode)parent.children.get(0)).children.get(0)).token);
            currentSTTStack=newStack;
        }
        else if(parent.name.equals("<FuncFParam>")) {
            String tmpName=((TNode)(((NNode)parent.children.get(0)).children.get(0))).token;
            String tmpType=((TNode)(((NNode)parent.children.get(1)).children.get(0))).token;
            if((parent.children.size()>2)&&(((TNode)(((NNode)parent.children.get(3)).children.get(1))).token.equals("["))) tmpType=tmpType+"R";
            currentSTTStack.pushStack(-1,tmpName,funcSymbolType.get(tmpType));
        }
        else if(parent.name.equals("<Block>")) {
            if(currentSTTStack.level!=-1){//若不是函数定义内容，正常新建栈，新建树节点
                STTStack newStack=new STTStack(currentLevel);
                currentSTTStack=newStack;
                STTNode newSTTNode=new STTNode(currentSTTStack);
                currentSTTNode.addChild(newSTTNode);
                currentSTTNode=newSTTNode;
                currentLevel++;
            }
            else{//若是函数定义内容，将当前STTStack压入funcSymbolTable
                funcSymbolTable.add(currentSTTStack);
            }
        }
        //函数调用
        else if(isFuncCall(parent)!=null) {
            String funcName=isFuncCall(parent);
            int len=funcSymbolTable.size();
            STTStack newStack=null;
            for(int i=0;i<len;i++){
                if(funcSymbolTable.get(i).peekStack(0).name.equals(funcName)){
                    newStack=funcSymbolTable.get(i);
                    break;
                }
                
            }
            //在当前栈中加入存有函数调用的栈元素
            currentSTTStack.pushStack(currentLevel, funcName, newStack.peekStack(0).type);
            //去掉存函数名的栈元素，并更新栈中所有元素的level
            newStack.stack.remove(0);
            newStack.level=currentLevel+1;
            for(int i=0;i<newStack.stack.size();i++){
                newStack.stack.get(i).level=currentLevel+1;
            }
            STTNode newSTTNode=new STTNode(newStack);
            currentSTTNode.addChild(newSTTNode);
            currentSTTNode=newSTTNode;
            currentLevel++;
        }
        else if(parent.name.equals("}")) {
            if(currentSTTStack.level!=-1) currentLevel=0; //若是函数定义的结束，currentLevel回归0
        }
    }
    private static String isFuncCall(ASTNode parent){
        if(parent.name.equals("<Stmt>")){
            if(((NNode)parent.children.get(0)).name.equals("<LVal>")&&((TNode)parent.children.get(1)).token.equals("=")){
                if(((TNode)parent.children.get(2)).token.equals("getint")) return "getint";
                else if(((TNode)parent.children.get(2)).token.equals("getchar")) return "getchar";
                else if(((NNode)parent.children.get(2).children.get(0).children.get(0).children.get(0).children.get(0)).name.equals("<Ident>")){
                    return ((TNode)(((NNode)parent.children.get(2)).children.get(0).children.get(0).children.get(0).children.get(0).children.get(0))).token;
                }
            }
        }
        return null;
    }
}

