import java.io.*;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;


import dataStructure.ASTNode.ASTNode;
import dataStructure.ASTNode.ENode;
import dataStructure.ASTNode.NNode;
import dataStructure.ASTNode.TNode;

import dataStructure.STT.STTNode;
import dataStructure.STT.STTQue;
import dataStructure.STT.STTQue.Element;

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
    public static String symbolFile="symbol.txt";
    public static ASTNode ASTRoot;

    public static STTQue currentSTTQue;
    public static STTNode STTRoot;
    public static STTNode currentSTTNode;
    public static int currentLevel=1;
    public static ArrayList<STTQue> funcSymbolTable=new ArrayList<>();
    public static ArrayList<Element> constSymbolTable=new ArrayList<>();
    public static ArrayList<Element> varSymbolTable=new ArrayList<>();

    public static int funcDefineFlag=0;
    public static int ISNOTFUNC=0;
    public static int VOIDFUNC=1;
    public static int OTHERFUNC=2;

    public static boolean forFlag=false;
    public static boolean inMainFlag=false;
    public static boolean rightFuncDefine=true;
    public static int blockNum=0;

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
        funcSymbolType.put("int", "IntFunc");
        funcSymbolType.put("char", "CharFunc");
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
        file=new File(symbolFile);
        if(file.exists()) file.delete();

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
        STTRoot = new STTNode(new STTQue(1));
        STTRoot.parent=null;
        currentSTTNode = STTRoot;
        currentSTTQue=currentSTTNode.que;
        ASTPreorder(ASTRoot);  
        STTPreorder(STTRoot);     

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
        addNode(curNode, new TNode("const","leaf",lineNumber));
        get3Token();
        parserBType(curNode);
        get3Token();
        parserConstDef(curNode);
        get3Token();
        while(currentToken.equals(",")){
            addNode(curNode, new TNode(",","leaf",lineNumber));
            get3Token();
            if(isConstDef()) parserConstDef(curNode);
            else{
                backToken();
                addNode(curNode, new ENode("i",lineNumber,"error"));
            } 
            get3Token();
        }
        
        if(currentToken.equals(";")) addNode(curNode, new TNode(";","leaf",lineNumber));
        else{
            backToken();
            addNode(curNode, new ENode("i",lineNumber,"error"));
        } 
    }
    public static void parserBType(ASTNode parent){
        ASTNode curNode = addNode(parent, new NNode("BType"));
        if(isBType()) addNode(curNode, new TNode(currentToken,currentToken,lineNumber));
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
            addNode(curNode, new TNode("[","leaf",lineNumber));
            get3Token();
            if(isConstExp()) parserConstExp(curNode);
            else {
                backToken();
                addNode(curNode, new ENode("k",lineNumber,"error"));
            }
            get3Token();
            if(currentToken.equals("]")) addNode(curNode, new TNode("]","leaf",lineNumber));
            else{
                backToken();
                addNode(curNode, new ENode("k",lineNumber,"error"));
            } 
            get3Token();
        }
        if(currentToken.equals("=")){
            addNode(curNode, new TNode("=","leaf",lineNumber));
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
            if(currentToken.equals("{")) addNode(curNode, new TNode("{","leaf",lineNumber));
            else{
                backToken();
                addNode(curNode, new ENode("noType",lineNumber,"error"));
            } 
            get3Token();
            if(currentToken.equals("}")) addNode(curNode, new TNode("}","leaf",lineNumber));
            else{
                parserConstExp(curNode);
                get3Token();
                while(currentToken.equals(",")){
                    addNode(curNode, new TNode(",","leaf",lineNumber));
                    get3Token();
                    if(isConstExp()) parserConstExp(curNode);
                    else{
                        backToken();
                        addNode(curNode, new ENode("noType",lineNumber,"error"));
                    } 
                    get3Token();
                }
                if(currentToken.equals("}")) addNode(curNode, new TNode("}","leaf",lineNumber));
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
            addNode(curNode, new TNode(",","leaf",lineNumber));
            get3Token();
            parserVarDef(curNode);
            get3Token();
        }
        if(currentToken.equals(";")) addNode(curNode, new TNode(";","leaf",lineNumber));
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
            addNode(curNode, new TNode("[","leaf",lineNumber));
            get3Token();
            parserConstExp(curNode);
            get3Token();
            if(currentToken.equals("]")) addNode(curNode, new TNode("]","leaf",lineNumber));
            else{
                backToken();
                addNode(curNode, new ENode("k",lineNumber,"error"));
            } 
            get3Token();
        }
        
        if(currentToken.equals("=")){
            addNode(curNode, new TNode("=","leaf",lineNumber));
            get3Token();
            parserInitVal(curNode);
        }
        else{
            backToken();
        } 
    }
    public static void parserIdent(ASTNode parent){
        ASTNode curNode = addNode(parent, new NNode("Ident"));
        addNode(curNode, new TNode(currentToken,"leaf",lineNumber));
    }
    private static void parserStringConst(ASTNode parent){
        ASTNode curNode = addNode(parent, new NNode("StringConst"));
        addNode(curNode, new TNode(currentToken,"leaf",lineNumber));
    }
    private static void parserInitVal(ASTNode parent){
        ASTNode curNode = addNode(parent, new NNode("InitVal"));
        if(isExp()) parserExp(curNode);
        else if(isStringConst(currentToken)) parserStringConst(curNode);
        else{
            if(currentToken.equals("{")) addNode(curNode, new TNode("{","leaf",lineNumber));
            else{
                backToken();
                addNode(curNode, new ENode("noType",lineNumber,"error"));
            } 
            get3Token();
            if(isExp()){
                parserExp(curNode);
                get3Token();
                while(currentToken.equals(",")){
                    addNode(curNode, new TNode(",","leaf",lineNumber));
                    get3Token();
                    parserExp(curNode);
                    get3Token();
                }
            }
            if (currentToken.equals("}")) addNode(curNode, new TNode("}","leaf",lineNumber));
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
        if(currentToken.equals("int")) addNode(curNode, new TNode(currentToken,"leaf",lineNumber));
        else{
            backToken();
            addNode(curNode, new ENode("j",lineNumber,"error"));
        } 
        get3Token();
        if(currentToken.equals("main")) addNode(curNode, new TNode("main","leaf",lineNumber));
        else{
            backToken();
            addNode(curNode, new ENode("j",lineNumber,"error"));
        } 
        get3Token();
        if(currentToken.equals("(")) addNode(curNode, new TNode("(","leaf",lineNumber));
        else{
            backToken();
            addNode(curNode, new ENode("j",lineNumber,"error"));
        } 
        get3Token();
        if(currentToken.equals(")")) addNode(curNode, new TNode(")","leaf",lineNumber));
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
        if(currentToken.equals("(")) addNode(curNode, new TNode("(","leaf",lineNumber));
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
        if(currentToken.equals(")")) addNode(curNode, new TNode(")","leaf",lineNumber));
        else{
            backToken();
            addNode(curNode, new ENode("j",lineNumber,"error"));
        } 
        get3Token();
        parserBlock(curNode);
    }
    public static void parserFuncType(ASTNode parent){
        ASTNode curNode = addNode(parent, new NNode("FuncType"));
        if(currentToken.equals("int")) addNode(curNode, new TNode(currentToken,"leaf",lineNumber));
        else if(currentToken.equals("char")) addNode(curNode, new TNode(currentToken,"leaf",lineNumber));
        else if(currentToken.equals("void")) addNode(curNode, new TNode(currentToken,"leaf",lineNumber));
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
            addNode(curNode, new TNode(",","leaf",lineNumber));
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
            addNode(curNode, new TNode("[","leaf",lineNumber));
            get3Token();
            if(currentToken.equals("]")){
                addNode(curNode, new TNode("]","leaf",lineNumber));
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
        if(currentToken.equals("{")) addNode(curNode, new TNode("{","leaf",lineNumber));
        else{
            backToken();
            addNode(curNode, new ENode("noType",lineNumber,"error"));
        } 
        get3Token();
        while(isBlockItem()){
            parserBlockItem(curNode);
            get3Token();
        }
        if(currentToken.equals("}")) addNode(curNode, new TNode("}","leaf",lineNumber));
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
            addNode(curNode, new TNode("if","leaf",lineNumber));
            get3Token();
            addNode(curNode, new TNode("(","leaf",lineNumber));
            get3Token();
            parserCond(curNode);
            get3Token();
            if(currentToken.equals(")"))addNode(curNode, new TNode(")","leaf",lineNumber));
            else{
                backToken();
                addNode(curNode, new ENode("j",lineNumber,"error"));
            } 
            get3Token();
            parserStmt(curNode);
            get3Token();
            if(currentToken.equals("else")){
                addNode(curNode, new TNode("else","leaf",lineNumber));
                get3Token();
                parserStmt(curNode);
            } 
            else backToken();
        }
        else if(currentToken.equals("for")&&nextToken.equals("(")){
            forFlag=true;
            addNode(curNode, new TNode("for","leaf",lineNumber));
            get3Token();
            addNode(curNode, new TNode("(","leaf",lineNumber));
            get3Token();
            if(isForStmt()){
                parserForStmt(curNode);
                get3Token();
            }
            
            if(currentToken.equals(";"))addNode(curNode, new TNode(";","leaf",lineNumber));
            else{
                backToken();
                addNode(curNode, new ENode("noType",lineNumber,"error"));
            } 
            get3Token();
            if(isCond()){
                parserCond(curNode);
                get3Token();
            }
            
            if(currentToken.equals(";"))addNode(curNode, new TNode(";","leaf",lineNumber));
            else{
                backToken();
                addNode(curNode, new ENode("noType",lineNumber,"error"));
            } 
            get3Token();
            if(isForStmt()){
                parserForStmt(curNode);
                get3Token();
            }
            if(currentToken.equals(")"))addNode(curNode, new TNode(")","leaf",lineNumber));
            else{
                backToken();
                addNode(curNode, new ENode("noType",lineNumber,"error"));
            } 
            get3Token();
            parserStmt(curNode);
            forFlag=false;
        }
        else if(currentToken.equals("break")&&nextToken.equals(";")){
            if(forFlag) addNode(curNode, new TNode("break","leaf",lineNumber));
            else addNode(curNode, new TNode("break","errorleaf",lineNumber));
            get3Token();
            addNode(curNode, new TNode(";","leaf",lineNumber));
        }
        else if(currentToken.equals("continue")&&nextToken.equals(";")){
            if(forFlag) addNode(curNode, new TNode("continue","leaf",lineNumber));
            else addNode(curNode, new TNode("continue","errorleaf",lineNumber));
            get3Token();
            addNode(curNode, new TNode(";","leaf",lineNumber));
        }
        else if(currentToken.equals("return")){
            addNode(curNode, new TNode("return","leaf",lineNumber));
            get3Token();
            if(isExp()&&(!totleTokens[token_index-2].equals("\n"))){
                parserExp(curNode);
                get3Token();
            }
            if(currentToken.equals(";")) addNode(curNode, new TNode(";","leaf",lineNumber));
            else{
                backToken();
                addNode(curNode, new ENode("i",lineNumber,"error"));
            } 
            
        }
        else if(currentToken.equals("printf")&&nextToken.equals("(")){
            addNode(curNode, new TNode("printf","leaf",lineNumber));
            get3Token();
            addNode(curNode, new TNode("(","leaf",lineNumber));
            get3Token();
            parserStringConst(curNode);
            get3Token();
            while(currentToken.equals(",")){
                addNode(curNode, new TNode(",","leaf",lineNumber));
                get3Token();
                parserExp(curNode);
                get3Token();
            }
            if(currentToken.equals(")"))addNode(curNode, new TNode(")","leaf",lineNumber));
            else{
                backToken();
                addNode(curNode, new ENode("j",lineNumber,"error"));
            } 
            get3Token();
            if(currentToken.equals(";"))addNode(curNode, new TNode(";","leaf",lineNumber));
            else{
                backToken();
                addNode(curNode, new ENode("i",lineNumber,"error"));
            } 
        }
        else if(currentToken.equals("{")){//Block
            parserBlock(curNode);
        }
        else if(currentToken.equals(";")){
            addNode(curNode, new TNode(";","leaf",lineNumber));
        }
        
        else if(isLVal()){
            parserLVal(curNode);
            get3Token();
            if(currentToken.equals("=")) addNode(curNode, new TNode("=", "leaf",lineNumber));
            else{
                backToken();
                addNode(curNode, new ENode("i",lineNumber,"error"));
            } 
            get3Token();
            if(isExp()&&(!currentToken.equals("getint"))&&(!currentToken.equals("getchar"))){
                parserExp(curNode);
                get3Token();
                if(currentToken.equals(";"))addNode(curNode, new TNode(";","leaf",lineNumber));
                else{
                    backToken();
                    addNode(curNode, new ENode("i",lineNumber,"error"));
                } 
            }
            else if(currentToken.equals("getint")){
                addNode(curNode, new TNode("getint","leaf",lineNumber));
                get3Token();
                if(currentToken.equals("("))addNode(curNode, new TNode("(","leaf",lineNumber));
                else{
                    backToken();
                    addNode(curNode, new ENode("j",lineNumber,"error"));
                } 
                get3Token();
                if(currentToken.equals(")"))addNode(curNode, new TNode(")","leaf",lineNumber));
                else{
                    backToken();
                    addNode(curNode, new ENode("j",lineNumber,"error"));
                } 
                get3Token();
                if(currentToken.equals(";"))addNode(curNode, new TNode(";","leaf",lineNumber));
                else{
                    backToken();
                    addNode(curNode, new ENode("i",lineNumber,"error"));
                } 
            }
            else if(currentToken.equals("getchar")){
                addNode(curNode, new TNode("getchar","leaf",lineNumber));
                get3Token();
                if(currentToken.equals("("))addNode(curNode, new TNode("(","leaf",lineNumber));
                else{
                    backToken();
                    addNode(curNode, new ENode("j",lineNumber,"error"));
                } 
                get3Token();
                if(currentToken.equals(")"))addNode(curNode, new TNode(")","leaf",lineNumber));
                else{
                    backToken();
                    addNode(curNode, new ENode("j",lineNumber,"error"));
                } 
                get3Token();
                if(currentToken.equals(";"))addNode(curNode, new TNode(";","leaf",lineNumber));
                else{
                    backToken();
                    addNode(curNode, new ENode("i",lineNumber,"error"));
                } 
            }
        }
        else{
            parserExp(curNode);
            get3Token();
            if(currentToken.equals(";"))addNode(curNode, new TNode(";","leaf",lineNumber));
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
        if(currentToken.equals("=")) addNode(curNode, new TNode("=", "leaf",lineNumber));
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
            addNode(curNode, new TNode("[","leaf",lineNumber));
            get3Token();
            parserExp(curNode);
            get3Token();
            if(currentToken.equals("]")) addNode(curNode, new TNode("]","leaf",lineNumber));
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
            addNode(curNode, new TNode("(","leaf",lineNumber));
            get3Token();
            parserExp(curNode);
            get3Token();
            if(currentToken.equals(")")) addNode(curNode, new TNode(")","leaf",lineNumber));
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
        if(isIntConst(currentToken)) addNode(curNode, new TNode(currentToken,"leaf",lineNumber));
        else{
            backToken();
            addNode(curNode, new ENode("noType",lineNumber,"error"));
        } 
    }
    public static void parserCharacter(ASTNode parent){
        ASTNode curNode = addNode(parent, new NNode("Character"));
        if(isCharConst(currentToken)) addNode(curNode, new TNode(currentToken,"leaf",lineNumber));
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
            if(currentToken.equals("(")) addNode(curNode, new TNode("(","leaf",lineNumber));
            else{
                backToken();
                addNode(curNode, new ENode("j",lineNumber,"error"));
            } 
            get3Token();
            if(isFuncRParams()&&(!totleTokens[token_index-2].equals("\n"))){
                parserFuncRParams(curNode);
                get3Token();
            }
            if(currentToken.equals(")")) addNode(curNode, new TNode(")","leaf",lineNumber));
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
        if(currentToken.equals("-")) addNode(curNode, new TNode("-","leaf",lineNumber));
        else if(currentToken.equals("+")) addNode(curNode, new TNode("+","leaf",lineNumber));
        else if(currentToken.equals("!")) addNode(curNode, new TNode("!","leaf",lineNumber));
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
            addNode(curNode, new TNode(",","leaf",lineNumber));
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
            addNode(newNode, new TNode(currentToken,"leaf",lineNumber));
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
            addNode(newNode, new TNode(currentToken,"leaf",lineNumber));
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
            addNode(newNode, new TNode(currentToken,"leaf",lineNumber));
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
            addNode(newNode, new TNode(currentToken,"leaf",lineNumber));
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
            else addNode(newNode, new TNode("&&","leaf",lineNumber));
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
        while(currentToken.equals("||")||currentToken.equals("|")){
            ASTNode newNode=insertNode(parent,curNode, new NNode("LOrExp"));
            if(currentToken.equals("|")) addNode(newNode, new ENode("a",lineNumber,"error"));
            else addNode(newNode, new TNode("||","leaf",lineNumber));
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
            if(!(((ENode)parent).errorType.equals("noType"))){
                writeError(((ENode)parent).errorType,((ENode)parent).lineNumber);
            } 
        } 
        else{
            symbol(parent);
        }
        if(rightFuncDefine){
            for(ASTNode child:parent.children){
                ASTPreorder(child);
            }  
        }
        else rightFuncDefine=true;
        
    }
    private static void symbol(ASTNode parent){
        if(parent instanceof TNode){
            if(((TNode)parent).token.equals("printf")) {
                checkPrintf(parent.parent);
            }
            else if(((TNode)parent).token.equals("continue")||((TNode)parent).token.equals("break")) {
                if(parent.name.equals("errorleaf")){
                    writeFile(errorFile, ((TNode)parent).lineNumber+" m\n");
                }
            }
            else if(((TNode)parent).token.equals("return")) {
                if(funcDefineFlag==VOIDFUNC&&(!getASTNodeContent(parent.parent,new int[] {1}).equals(";"))){
                    writeFile(errorFile, ((TNode)parent).lineNumber+" f\n");
                }
                currentSTTNode.que.pushQue(currentSTTNode.que.level,"return","return","return");
            }
            else if(((TNode)parent).token.equals("}")&&parent.parent.name.equals("<Block>")) {
                if((parent.parent.parent.name.equals("<FuncDef>")&&funcDefineFlag==OTHERFUNC)||parent.parent.parent.name.equals("<MainFuncDef>")) {
                    boolean flag=false;
                    for(Element element:currentSTTNode.que.que){
                        if(element.name.equals("return")){
                            flag=true;
                        }
                    }
                    if(!flag) writeFile(errorFile, ((TNode)parent).lineNumber+" g\n");
                }
                blockNum--;
                if(blockNum==0)funcDefineFlag=ISNOTFUNC;
                forFlag=false;
                currentSTTNode=currentSTTNode.parent;
                currentSTTQue=currentSTTNode.que;
            }
            else if(((TNode)parent).token.equals("{")&&parent.parent.name.equals("<Block>")) {
                blockNum++;
            }
            
        }
        else{
            if(parent.name.equals("<VarDecl>")) {
                String ansVarType;
                String ansVarName;
                int childrenNum=parent.children.size();
                int varNum=(childrenNum-1)/2;
                String tmpVarType=getASTNodeContent(parent, new int[]{0,0});
                String tmpVarName=getASTNodeContent(parent, new int[]{1,0,0});
                ansVarName=tmpVarName;
                ansVarType=tmpVarType;
                if(checkReDefine(currentSTTQue,ansVarName, ((TNode)getASTNode(parent, new int[]{1,0,0})).lineNumber)){
                    checkNewDefine(ansVarName,false);
                    if((parent.children.get(1).children.size()>=2)&&(getASTNodeContent(parent, new int[] {1,1}).equals("["))) ansVarType=tmpVarType+"R";
                    currentSTTNode.que.pushQue(currentSTTNode.que.level,ansVarName,varSymbolType.get(ansVarType),"Var");
                    varSymbolTable.add(new Element(currentLevel,ansVarName,varSymbolType.get(ansVarType),"Var"));
                    // System.out.println(ansVarType+" "+ansVarName);
                }
                
                for(int i=2;i<=varNum;i++){
                    ansVarType=tmpVarType;
                    tmpVarName=getASTNodeContent(parent, new int[] {2*i-1,0,0});
                    ansVarName=tmpVarName;
                    if(checkReDefine(currentSTTQue,ansVarName,((TNode)getASTNode(parent, new int[]{2*i-1,0,0})).lineNumber )){
                        checkNewDefine(ansVarName,false);
                        if((parent.children.get(2*i-1).children.size()>=2)&&getASTNodeContent(parent, new int[] {2*i-1,1}).equals("[")) ansVarType=tmpVarType+"R";
                        currentSTTNode.que.pushQue(currentSTTNode.que.level,ansVarName,varSymbolType.get(ansVarType),"Var");
                        varSymbolTable.add(new Element(currentLevel,ansVarName,varSymbolType.get(ansVarType),"Var"));
                    }
                    
                }
            }
            else if(parent.name.equals("<ConstDecl>")) {
                String ansVarType;
                String ansVarName;
                int childrenNum=parent.children.size();
                int varNum=(childrenNum-2)/2;
                //String tmpVarType=((TNode)(((NNode)parent.children.get(1)).children.get(0))).token;
                String tmpVarType=getASTNodeContent(parent, new int[]{1,0});
                //String tmpVarName=((TNode)(((NNode)parent.children.get(2)).children.get(0).children.get(0))).token;
                String tmpVarName=getASTNodeContent(parent, new int[]{2,0,0});
                ansVarName=tmpVarName;
                ansVarType=tmpVarType;
                if(checkReDefine(currentSTTQue,ansVarName, ((TNode)getASTNode(parent, new int[]{2,0,0})).lineNumber)){
                    checkNewDefine(ansVarName,true);
                    if((parent.children.get(2).children.size()>=2)&&getASTNodeContent(parent, new int[]{2,1}).equals("[")) ansVarType=tmpVarType+"R";
                    currentSTTNode.que.pushQue(currentSTTNode.que.level,ansVarName,constSymbolType.get(ansVarType),"Const");
                    constSymbolTable.add(new Element(currentLevel,ansVarName,constSymbolType.get(ansVarType),"Const"));
                }
                
                for(int i=2;i<=varNum;i++){
                    ansVarType=tmpVarType;
                    tmpVarName=getASTNodeContent(parent, new int[]{2*i,0,0});
                    ansVarName=tmpVarName;
                    if(checkReDefine(currentSTTQue,ansVarName, ((TNode)getASTNode(parent, new int[]{2*i,0,0})).lineNumber)){
                        checkNewDefine(ansVarName,true);
                        if((parent.children.get(2*i).children.size()>=2)&&getASTNodeContent(parent, new int[]{2*i,1}).equals("[")) ansVarType=tmpVarType+"R";
                        currentSTTNode.que.pushQue(currentSTTNode.que.level,ansVarName,constSymbolType.get(ansVarType),"Const");
                        constSymbolTable.add(new Element(currentLevel,ansVarName,constSymbolType.get(ansVarType),"Const"));
                    }
                    
                }
            }
            else if(parent.name.equals("<FuncDef>")) {
                String tmpFuncName=getASTNodeContent(parent, new int[] {1,0});
                String tmpFuncType=funcSymbolType.get(getASTNodeContent(parent, new int[] {0,0}));
                if(tmpFuncType.equals("VoidFunc")){
                    funcDefineFlag=VOIDFUNC;
                }
                else{
                    funcDefineFlag=OTHERFUNC;
                }
                if(checkReDefine(STTRoot.que, tmpFuncName, ((TNode)getASTNode(parent, new int[] {1,0})).lineNumber)){
                    rightFuncDefine=true;
                    STTRoot.que.pushQue(1,tmpFuncName,tmpFuncType,"Func");
                    STTQue newQue=new STTQue(currentLevel+1);
                    newQue.pushQue(0,tmpFuncName,"numofparams","Func");
                    funcSymbolTable.add(newQue);
                }
                else{
                    rightFuncDefine=false;
                } 
            }
            else if(parent.name.equals("<MainFuncDef>")) {
                rightFuncDefine=true;
                funcDefineFlag=ISNOTFUNC;
            }
            else if(parent.name.equals("<FuncFParam>")) {
                String tmpName=getASTNodeContent(parent, new int[]{1,0});
                String tmpType=getASTNodeContent(parent, new int[]{0,0});
                if((parent.children.size()>2)&&getASTNodeContent(parent, new int[]{2}).equals("[")) tmpType=tmpType+"R";
                STTQue newQue=funcSymbolTable.get(funcSymbolTable.size()-1);
                newQue.peekQue(0).level++;
                checkReDefine(newQue,tmpName, ((TNode)getASTNode(parent, new int[]{1,0})).lineNumber);
                newQue.pushQue(currentLevel+1,tmpName,varSymbolType.get(tmpType),"Para");
                //funcSymbolTable.add(newQue);
            }
            else if(parent.name.equals("<Block>")) {
                currentLevel++;
                STTQue newQue=(funcDefineFlag!=ISNOTFUNC&&blockNum==0)?funcSymbolTable.get(funcSymbolTable.size()-1):new STTQue(currentLevel);
                currentSTTQue=newQue;
                STTNode newSTTNode=new STTNode(currentSTTQue);
                currentSTTNode.addChild(newSTTNode);
                currentSTTNode=newSTTNode;
                currentSTTNode.que=currentSTTQue;
                // if(getASTNodeContent(parent, new int[] {1}).equals("}")) {
                //     currentLevel--;
                // }
                // if(funcDefineFlag!=0){
                //     funcSymbolTable.add(currentSTTQue);
                // }
                //funcDefineFlag=0;
            }
            //函数调用
            else if(isFuncCall(parent)!=null) {
            //     String funcName=isFuncCall(parent);
            //     int len=funcSymbolTable.size();
            //     STTQue newQue=null;
            //     //在funcSymbolTable中查找符合函数名的栈
            //     for(int i=0;i<len;i++){
            //         if(funcSymbolTable.get(i).peekQue(0).name.equals(funcName)){
            //             newQue=funcSymbolTable.get(i);
            //             break;
            //         }
                    
            //     }
            //     //添加标识用于跳转
            //     // currentSTTQue.pushQue(currentLevel, "jumpChild", currentToken);
            //     //设置子树节点中添加返回指针
            //     STTQue.Element retElement=currentSTTQue.peekQue(currentSTTQue.front);
            //     newQue.setRet(retElement);
    
            //     //在当前栈中加入存有函数调用的栈元素
            //     currentSTTQue.pushQue(currentLevel, funcName, newQue.peekQue(0).type);
            //     //去掉存函数名的栈元素，并更新栈中所有元素的level
            //     newQue.que.remove(0);
            //     newQue.level=currentLevel+1;
            //     for(int i=0;i<newQue.que.size();i++){
            //         newQue.que.get(i).level=currentLevel+1;
            //     }
            //     //加入新的树节点
            //     STTNode newSTTNode=new STTNode(newQue);
            //     currentSTTNode.addChild(newSTTNode);
            //     currentSTTNode=newSTTNode;
            //     currentLevel++;
                int paraNum=0;
                if(getASTNode(parent, new int[] {0,0,0,getASTNode(parent,new int[] {0,0,0}).children.size()-1}).name.equals("error")) return;
                if(getASTNodeContent(parent, new int[] {0,0,0,2}).equals(")")) paraNum=0;
                else{
                    paraNum=getASTNode(parent, new int[] {0,0,0,2}).children.size()/2+1;
                }
                String[] paraNames=(paraNum==0)?null:new String[paraNum];
                for(int i=0;i<paraNum;i++){
                    String paraKind=getASTNodeContent(parent, new int[] {0,0,0,2,2*i,0,0,0,0,0});
                    if(paraKind.equals("<Number>")||paraKind.equals("<Character>")){
                        paraNames[i]=getASTNodeContent(parent, new int[] {0,0,0,2,2*i,0,0,0,0,0,0});
                    }
                    else if(paraKind.equals("<LVal>")){
                        paraNames[i]=getASTNodeContent(parent, new int[] {0,0,0,2,2*i,0,0,0,0,0,0,0});
                    } 
                    else return;
                }
                String[] paraTypes=(paraNum==0)?null:new String[paraNum];
                
                //确定稿参数类型
                for(int i=0;i<paraNum;i++){
                    STTNode tmpNode=currentSTTNode;
                    //如果是字符常量
                    if(isCharConst(paraNames[i])){
                        paraTypes[i]="Char";
                        continue;
                    } 
                    //如果是数字常量
                    else if(isIntConst(paraNames[i])){
                        paraTypes[i]="Int";
                    }
                    //如果是已有变量
                    else{
                        boolean flag=false;
                        while(tmpNode!=null){
                            for(Element element:tmpNode.que.que){
                                if(element.name.equals(paraNames[i])){
                                    paraTypes[i]=element.type;
                                    flag=true;
                                    break;
                                }
                            }
                            tmpNode=tmpNode.parent;
                        }
                        if(!flag) paraTypes[i]="errPara";
                    }
                }
                checkFuncCall(parent, getASTNodeContent(parent, new int[] {0,0,0,0,0}), paraNum, paraTypes);
            }
            
            else if(parent.name.equals("<Stmt>")) {
                if(getASTNodeContent(parent, new int[] {0}).equals("<LVal>")) checkChangeConst(getASTNode(parent, new int[] {0}));
            }
            else if(parent.name.equals("<LVal>")) {
                checkNoDefine(parent);
            }
            else if(parent.name.equals("<ForStmt>")) {
                checkChangeConst(getASTNode(parent,new int[] {0} ));
            }
            else if(parent.name.equals("<UnaryExp>")&&getASTNodeContent(parent, new int[] {0}).equals("<Ident>")) {
                checkNoDefine(parent);
            }

        }
        
        
    }
    
    private static void STTPreorder(STTNode parent){
        
        for(Element element:parent.que.que){
            if((!element.type.equals("numofparams"))&&(!element.type.equals("return"))) writeFile(symbolFile,element.level+" "+element.name+" "+element.type+"\n");
        }
        for(STTNode child:parent.children){
            STTPreorder(child);
        }
    }
    private static String isFuncCall(ASTNode parent){
        if(parent.name.equals("<Exp>")){
            if(getASTNodeContent(parent, new int[] {0}).equals("<AddExp>")&&getASTNodeContent(parent, new int[] {0,0}).equals("<MulExp>")&&getASTNodeContent(parent,new int[] {0,0,0}).equals("<UnaryExp>")&&getASTNodeContent(parent,new int[] {0,0,0,0}).equals("<Ident>")){
                return getASTNodeContent(parent,new int[] {0,0,0,0,0});
            }
        }
        return null;
    }
    public static ASTNode getASTNode(ASTNode node,int[] indexs){
        ASTNode ansNode=node;
        for(int index:indexs){
            ansNode=ansNode.children.get(index);
        }
        return ansNode;
    }
    private static String getASTNodeContent(ASTNode node,int[] indexs){ 
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
    private static boolean checkReDefine(STTQue que,String name,int lineNumber){
        if(que==null||que.isEmpty()) return true;
        for(Element element:que.que){
            if((element.type.equals("numofparams")&&element.kind.equals("Func"))||element.type.equals("return")){
                continue;
            }
            System.out.println(element.name+" "+name);
            if(element.name.equals(name)){
                writeFile(errorFile,lineNumber+" "+"b\n");
                return false;
            }
        }
        return true;
    }
    private static void checkNewDefine(String name,boolean isConst){
        // STTNode tmpNode=currentSTTNode.parent;
        // while(tmpNode!=null){
        //     for(Element element:tmpNode.que.que){
        //         if(element.name.equals(name)&&element.kind!="Para"){
        //             // //element.name="removed";
        //             // //如果新定义的量不是常量，且原量（上层）是常量，则删除常量表中的对应内容
        //             // if(element.kind.equals("Const")&&!isConst){
        //             //     for(Element constElement:constSymbolTable){
        //             //         if(constElement.name.equals(name)){
        //             //             constElement.name="removed";
        //             //         } 
        //             //     }
                        
        //             // }
        //             // tmpNode.que.removeQue(element);
        //             return;
        //         }
        //     }
        //     tmpNode=tmpNode.parent;
        // }
        return;
    }
    private static void checkChangeConst(ASTNode parent){//传入LVal
        String lvalName=getASTNodeContent(parent,new int[] {0,0});
        STTNode tmp=currentSTTNode;
        while(tmp!=STTRoot){
            for(Element element:tmp.que.que){
                if(element.name.equals(lvalName)&&(!element.kind.equals("Const"))){
                    return;
                }
            }
            tmp=tmp.parent;
        }
        for(Element element:constSymbolTable){
            if(element.name.equals(lvalName)){
                writeFile(errorFile, ((TNode)getASTNode(parent,new int[] {0,0})).lineNumber+" "+"h\n");
            }
        }
    }
    private static void checkPrintf(ASTNode parent){
        String stringConst=getASTNodeContent(parent, new int[] {2,0});
        int expNum=(parent.children.size()-5)/2;
        int formatNum=0;
        for(char ch:stringConst.toCharArray()){
            if(ch=='%') formatNum++;
        }
        if(expNum!=formatNum){
            writeFile(errorFile, ((TNode)getASTNode(parent, new int[] {2,0})).lineNumber+" "+"l\n");
        }
    }
    private static void checkNoDefine(ASTNode parent){
        String lvalName=getASTNodeContent(parent,new int[] {0,0});
        STTNode tmp=currentSTTNode;
        while(tmp!=null){
            STTQue que=tmp.que;
            for(Element element:que.que){
                if(element.name.equals(lvalName)){
                    return;
                }
            }
            tmp=tmp.parent;
        }
        writeFile(errorFile, ((TNode)getASTNode(parent,new int[] {0,0})).lineNumber+" "+"c\n");
    }
    private static void checkFuncCall(ASTNode parent,String funcName,int paraNum,String[] paraTypes){
        for(STTQue que:funcSymbolTable){
            if(que.peekQue(0).name.equals(funcName)){
                if(que.peekQue(0).level!=paraNum){
                    writeFile(errorFile,((TNode)getASTNode(parent,new int[] {0,0,0,0,0})).lineNumber+" "+"d\n");
                    return;
                } 
                if(paraTypes==null) return;
                int tmpIndex=1;
                for(String type:paraTypes){
                    if((!type.equals(que.peekQue(tmpIndex).type)&&(!type.equals("Const"+que.peekQue(tmpIndex).type)))){
                        writeFile(errorFile,((TNode)getASTNode(parent,new int[] {0,0,0,0,0})).lineNumber+" "+"e\n");
                        return;
                    } 
                    tmpIndex++;
                }
            }
        }
    }
    
}

