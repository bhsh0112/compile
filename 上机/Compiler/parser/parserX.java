package parser;

import dataStructure.ASTNode.ASTNode;
import dataStructure.ASTNode.ENode;
import dataStructure.ASTNode.NNode;
import dataStructure.ASTNode.TNode;



public class parserX {
    // public static ASTNode ASTRoot;
    public static boolean forFlag=false;

    public static void main(){
        parser.get3Token();
        parserComunit();
        // return ASTRoot;
    }
    public static void parserComunit() {
        
        parser.ASTRoot=new NNode("CompUnit");
        if(isX.isDecl()){
            while(isX.isDecl()){
                parserDecl(parser.ASTRoot);
                parser.get3Token();
            } 
        }
        if(isX.isFuncDef()&&(!isX.isMainFuncDef())){
            while(isX.isFuncDef()&&(!isX.isMainFuncDef())){
                parserFuncDef(parser.ASTRoot);
                parser.get3Token();
            } 
        }
        if(isX.isMainFuncDef()){
            parserMainFuncDef(parser.ASTRoot);
        }
        
    }
    public static void parserDecl(ASTNode parent){
        ASTNode curNode = addNode(parent, new NNode("Decl"));
        if(isX.isConstDecl()) parserConstDecl(curNode);
        else parserVarDecl(curNode);
    }
    public static void parserConstDecl(ASTNode parent){
        ASTNode curNode = addNode(parent, new NNode("ConstDecl"));
        addNode(curNode, new TNode("const","leaf",parser.lineNumber));
        parser.get3Token();
        parserBType(curNode);
        parser.get3Token();
        parserConstDef(curNode);
        parser.get3Token();
        while(parser.currentToken.equals(",")){
            addNode(curNode, new TNode(",","leaf",parser.lineNumber));
            parser.get3Token();
            if(isX.isConstDef()) parserConstDef(curNode);
            else{
                parser.backToken();
                addNode(curNode, new ENode("i",parser.lineNumber,"error"));
            } 
            parser.get3Token();
        }
        
        if(parser.currentToken.equals(";")) addNode(curNode, new TNode(";","leaf",parser.lineNumber));
        else{
            parser.backToken();
            addNode(curNode, new ENode("i",parser.lineNumber,"error"));
        } 
    }
    public static void parserBType(ASTNode parent){
        ASTNode curNode = addNode(parent, new NNode("BType"));
        if(isX.isBType()) addNode(curNode, new TNode(parser.currentToken,parser.currentToken,parser.lineNumber));
        else{
            parser.backToken();
            addNode(curNode, new ENode("i",parser.lineNumber,"error"));
        } 
    }
    public static void parserConstDef(ASTNode parent){
        ASTNode curNode = addNode(parent, new NNode("ConstDef"));
        if(parser.isIdentifier(parser.currentToken)) parserIdent(curNode);
        else{
            parser.backToken();
            addNode(curNode, new ENode("k",parser.lineNumber,"error"));
        } 
        parser.get3Token();
        if(parser.currentToken.equals("[")){
            addNode(curNode, new TNode("[","leaf",parser.lineNumber));
            parser.get3Token();
            if(isX.isConstExp()) parserConstExp(curNode);
            else {
                parser.backToken();
                addNode(curNode, new ENode("k",parser.lineNumber,"error"));
            }
            parser.get3Token();
            if(parser.currentToken.equals("]")) addNode(curNode, new TNode("]","leaf",parser.lineNumber));
            else{
                parser.backToken();
                addNode(curNode, new ENode("k",parser.lineNumber,"error"));
            } 
            parser.get3Token();
        }
        if(parser.currentToken.equals("=")){
            addNode(curNode, new TNode("=","leaf",parser.lineNumber));
            parser.get3Token();
            
            parserConstInitVal(curNode);
        } 
        else{
            parser.backToken();
            addNode(curNode, new ENode("k",parser.lineNumber,"error"));
        } 
    }
    public static void parserConstInitVal(ASTNode parent){
        ASTNode curNode = addNode(parent, new NNode("ConstInitVal"));
        if(isX.isConstExp()) parserConstExp(curNode);
        else if(parser.isStringConst(parser.currentToken)) parserStringConst(curNode);
        else{
            if(parser.currentToken.equals("{")) addNode(curNode, new TNode("{","leaf",parser.lineNumber));
            else{
                parser.backToken();
                addNode(curNode, new ENode("noType",parser.lineNumber,"error"));
            } 
            parser.get3Token();
            if(parser.currentToken.equals("}")) addNode(curNode, new TNode("}","leaf",parser.lineNumber));
            else{
                parserConstExp(curNode);
                parser.get3Token();
                while(parser.currentToken.equals(",")){
                    addNode(curNode, new TNode(",","leaf",parser.lineNumber));
                    parser.get3Token();
                    if(isX.isConstExp()) parserConstExp(curNode);
                    else{
                        parser.backToken();
                        addNode(curNode, new ENode("noType",parser.lineNumber,"error"));
                    } 
                    parser.get3Token();
                }
                if(parser.currentToken.equals("}")) addNode(curNode, new TNode("}","leaf",parser.lineNumber));
                else{
                    parser.backToken();
                    addNode(curNode, new ENode("noType",parser.lineNumber,"error"));
                } 
            }
        }
    }
    public static void parserVarDecl(ASTNode parent){
        ASTNode curNode = addNode(parent, new NNode("VarDecl"));
        parserBType(curNode);
        parser.get3Token();
        parserVarDef(curNode);
        parser.get3Token();
        while(parser.currentToken.equals(",")){
            addNode(curNode, new TNode(",","leaf",parser.lineNumber));
            parser.get3Token();
            parserVarDef(curNode);
            parser.get3Token();
        }
        if(parser.currentToken.equals(";")) addNode(curNode, new TNode(";","leaf",parser.lineNumber));
        else{
            parser.backToken();
            addNode(curNode, new ENode("i",parser.lineNumber,"error"));
            
        }
    }
    public static void parserVarDef(ASTNode parent){
        ASTNode curNode = addNode(parent, new NNode("VarDef"));
        parserIdent(curNode);
        parser.get3Token();
        if(parser.currentToken.equals("[")){
            addNode(curNode, new TNode("[","leaf",parser.lineNumber));
            parser.get3Token();
            parserConstExp(curNode);
            parser.get3Token();
            if(parser.currentToken.equals("]")) addNode(curNode, new TNode("]","leaf",parser.lineNumber));
            else{
                parser.backToken();
                addNode(curNode, new ENode("k",parser.lineNumber,"error"));
            } 
            parser.get3Token();
        }
        
        if(parser.currentToken.equals("=")){
            addNode(curNode, new TNode("=","leaf",parser.lineNumber));
            parser.get3Token();
            parserInitVal(curNode);
        }
        else{
            parser.backToken();
        } 
    }
    public static void parserIdent(ASTNode parent){
        ASTNode curNode = addNode(parent, new NNode("Ident"));
        addNode(curNode, new TNode(parser.currentToken,"leaf",parser.lineNumber));
    }
    private static void parserStringConst(ASTNode parent){
        ASTNode curNode = addNode(parent, new NNode("StringConst"));
        addNode(curNode, new TNode(parser.currentToken,"leaf",parser.lineNumber));
    }
    private static void parserInitVal(ASTNode parent){
        ASTNode curNode = addNode(parent, new NNode("InitVal"));
        if(isX.isExp()) parserExp(curNode);
        else if(parser.isStringConst(parser.currentToken)) parserStringConst(curNode);
        else{
            if(parser.currentToken.equals("{")) addNode(curNode, new TNode("{","leaf",parser.lineNumber));
            else{
                parser.backToken();
                addNode(curNode, new ENode("noType",parser.lineNumber,"error"));
            } 
            parser.get3Token();
            if(isX.isExp()){
                parserExp(curNode);
                parser.get3Token();
                while(parser.currentToken.equals(",")){
                    addNode(curNode, new TNode(",","leaf",parser.lineNumber));
                    parser.get3Token();
                    parserExp(curNode);
                    parser.get3Token();
                }
            }
            if (parser.currentToken.equals("}")) addNode(curNode, new TNode("}","leaf",parser.lineNumber));
            else{
                parser.backToken();
                addNode(curNode, new ENode("noType",parser.lineNumber,"error"));
            } 
        }
    }
    public static void parserConstExp(ASTNode parent){
        ASTNode curNode = addNode(parent, new NNode("ConstExp"));
        parserAddExp(curNode);
    }
    public static void parserMainFuncDef(ASTNode parent){
        ASTNode curNode = addNode(parent, new NNode("MainFuncDef"));
        if(parser.currentToken.equals("int")) addNode(curNode, new TNode(parser.currentToken,"leaf",parser.lineNumber));
        else{
            parser.backToken();
            addNode(curNode, new ENode("j",parser.lineNumber,"error"));
        } 
        parser.get3Token();
        if(parser.currentToken.equals("main")) addNode(curNode, new TNode("main","leaf",parser.lineNumber));
        else{
            parser.backToken();
            addNode(curNode, new ENode("j",parser.lineNumber,"error"));
        } 
        parser.get3Token();
        if(parser.currentToken.equals("(")) addNode(curNode, new TNode("(","leaf",parser.lineNumber));
        else{
            parser.backToken();
            addNode(curNode, new ENode("j",parser.lineNumber,"error"));
        } 
        parser.get3Token();
        if(parser.currentToken.equals(")")) addNode(curNode, new TNode(")","leaf",parser.lineNumber));
        else{
            parser.backToken();
            addNode(curNode, new ENode("j",parser.lineNumber,"error"));
        } 
        parser.get3Token();
        parserBlock(curNode);
    }
    public static void parserFuncDef(ASTNode parent){
        ASTNode curNode = addNode(parent, new NNode("FuncDef"));
        if(isX.isFuncType()) parserFuncType(curNode);
        else{
            parser.backToken();
            addNode(curNode, new ENode("j",parser.lineNumber,"error"));
        } 
        parser.get3Token();
        if(parser.isIdentifier(parser.currentToken)) parserIdent(curNode);
        else{
            parser.backToken();
            addNode(curNode, new ENode("j",parser.lineNumber,"error"));
        } 
        parser.get3Token();
        if(parser.currentToken.equals("(")) addNode(curNode, new TNode("(","leaf",parser.lineNumber));
        else{
            parser.backToken();
            addNode(curNode, new ENode("j",parser.lineNumber,"error"));
        } 
        parser.get3Token();
        if(isX.isFuncFParams()) parserFuncFParams(curNode);
        else{
            parser.backToken();
        } 
        parser.get3Token();
        if(parser.currentToken.equals(")")) addNode(curNode, new TNode(")","leaf",parser.lineNumber));
        else{
            parser.backToken();
            addNode(curNode, new ENode("j",parser.lineNumber,"error"));
        } 
        parser.get3Token();
        parserBlock(curNode);
    }
    public static void parserFuncType(ASTNode parent){
        ASTNode curNode = addNode(parent, new NNode("FuncType"));
        if(parser.currentToken.equals("int")) addNode(curNode, new TNode(parser.currentToken,"leaf",parser.lineNumber));
        else if(parser.currentToken.equals("char")) addNode(curNode, new TNode(parser.currentToken,"leaf",parser.lineNumber));
        else if(parser.currentToken.equals("void")) addNode(curNode, new TNode(parser.currentToken,"leaf",parser.lineNumber));
        else{
            parser.backToken();
            addNode(curNode, new ENode("j",parser.lineNumber,"error"));
        } 
    }
    public static void parserFuncFParams(ASTNode parent){
        ASTNode curNode = addNode(parent, new NNode("FuncFParams"));
        parserFuncFParam(curNode);
        parser.get3Token();
        while(parser.currentToken.equals(",")){
            addNode(curNode, new TNode(",","leaf",parser.lineNumber));
            parser.get3Token();
            if(isX.isFuncFParams()){
                parserFuncFParam(curNode);
                parser.get3Token();
            } 
            else{
                addNode(curNode, new ENode("noType",parser.lineNumber,"error"));
            } 
        }
        parser.backToken();
    }
    public static void parserFuncFParam(ASTNode parent){
        ASTNode curNode = addNode(parent, new NNode("FuncFParam"));
        parserBType(curNode);
        parser.get3Token();
        parserIdent(curNode);
        parser.get3Token();
        if(parser.currentToken.equals("[")){
            addNode(curNode, new TNode("[","leaf",parser.lineNumber));
            parser.get3Token();
            if(parser.currentToken.equals("]")){
                addNode(curNode, new TNode("]","leaf",parser.lineNumber));
            }
            else{
                parser.backToken();
                addNode(curNode, new ENode("k",parser.lineNumber,"error"));
            } 
        }
        else{
            parser.backToken();
        } 
        
    }
    public static void parserBlock(ASTNode parent){
        ASTNode curNode = addNode(parent, new NNode("Block"));
        if(parser.currentToken.equals("{")) addNode(curNode, new TNode("{","leaf",parser.lineNumber));
        else{
            parser.backToken();
            addNode(curNode, new ENode("noType",parser.lineNumber,"error"));
        } 
        parser.get3Token();
        while(isX.isBlockItem()){
            parserBlockItem(curNode);
            parser.get3Token();
        }
        if(parser.currentToken.equals("}")) addNode(curNode, new TNode("}","leaf",parser.lineNumber));
        else{
            parser.backToken();
            addNode(curNode, new ENode("noType",parser.lineNumber,"error"));
        } 
    }
    public static void parserBlockItem(ASTNode parent){
        ASTNode curNode = addNode(parent, new NNode("BlockItem"));
        if(isX.isDecl()){
            parserDecl(curNode);
        } 
        else{

            parserStmt(curNode);
        } 
    }
    public static void parserStmt(ASTNode parent){
        
        ASTNode curNode = addNode(parent, new NNode("Stmt"));
        if(parser.currentToken.equals("if")&&parser.nextToken.equals("(")){
            addNode(curNode, new TNode("if","leaf",parser.lineNumber));
            parser.get3Token();
            addNode(curNode, new TNode("(","leaf",parser.lineNumber));
            parser.get3Token();
            parserCond(curNode);
            parser.get3Token();
            if(parser.currentToken.equals(")"))addNode(curNode, new TNode(")","leaf",parser.lineNumber));
            else{
                parser.backToken();
                addNode(curNode, new ENode("j",parser.lineNumber,"error"));
            } 
            parser.get3Token();
            parserStmt(curNode);
            parser.get3Token();
            if(parser.currentToken.equals("else")){
                addNode(curNode, new TNode("else","leaf",parser.lineNumber));
                parser.get3Token();
                parserStmt(curNode);
            } 
            else parser.backToken();
        }
        else if(parser.currentToken.equals("for")&&parser.nextToken.equals("(")){
            forFlag=true;
            addNode(curNode, new TNode("for","leaf",parser.lineNumber));
            parser.get3Token();
            addNode(curNode, new TNode("(","leaf",parser.lineNumber));
            parser.get3Token();
            if(isX.isForStmt()){
                parserForStmt(curNode);
                parser.get3Token();
            }
            
            if(parser.currentToken.equals(";"))addNode(curNode, new TNode(";","leaf",parser.lineNumber));
            else{
                parser.backToken();
                addNode(curNode, new ENode("noType",parser.lineNumber,"error"));
            } 
            parser.get3Token();
            if(isX.isCond()){
                parserCond(curNode);
                parser.get3Token();
            }
            
            if(parser.currentToken.equals(";"))addNode(curNode, new TNode(";","leaf",parser.lineNumber));
            else{
                parser.backToken();
                addNode(curNode, new ENode("noType",parser.lineNumber,"error"));
            } 
            parser.get3Token();
            if(isX.isForStmt()){
                parserForStmt(curNode);
                parser.get3Token();
            }
            if(parser.currentToken.equals(")"))addNode(curNode, new TNode(")","leaf",parser.lineNumber));
            else{
                parser.backToken();
                addNode(curNode, new ENode("noType",parser.lineNumber,"error"));
            } 
            parser.get3Token();
            parserStmt(curNode);
            forFlag=false;
        }
        else if(parser.currentToken.equals("break")){
            if(forFlag) addNode(curNode, new TNode("break","leaf",parser.lineNumber));
            else addNode(curNode, new TNode("break","errorleaf",parser.lineNumber));
            parser.get3Token();
            if(parser.currentToken.equals(";"))addNode(curNode, new TNode(";","leaf",parser.lineNumber));
            else{
                parser.backToken();
                addNode(curNode, new ENode("i",parser.lineNumber,"error"));
            }
        }
        else if(parser.currentToken.equals("continue")){
            if(forFlag) addNode(curNode, new TNode("continue","leaf",parser.lineNumber));
            else addNode(curNode, new TNode("continue","errorleaf",parser.lineNumber));
            parser.get3Token();
            if(parser.currentToken.equals(";"))addNode(curNode, new TNode(";","leaf",parser.lineNumber));
            else{
                parser.backToken();
                addNode(curNode, new ENode("i",parser.lineNumber,"error"));
            }
        }
        else if(parser.currentToken.equals("return")){
            addNode(curNode, new TNode("return","leaf",parser.lineNumber));
            parser.get3Token();
            if(isX.isExp()&&(!parser.totleTokens[parser.token_index-2].equals("\n"))){
                parserExp(curNode);
                parser.get3Token();
            }
            if(parser.currentToken.equals(";")) addNode(curNode, new TNode(";","leaf",parser.lineNumber));
            else{
                parser.backToken();
                addNode(curNode, new ENode("i",parser.lineNumber,"error"));
            } 
            
        }
        else if(parser.currentToken.equals("printf")&&parser.nextToken.equals("(")){
            addNode(curNode, new TNode("printf","leaf",parser.lineNumber));
            parser.get3Token();
            addNode(curNode, new TNode("(","leaf",parser.lineNumber));
            parser.get3Token();
            parserStringConst(curNode);
            parser.get3Token();
            while(parser.currentToken.equals(",")){
                addNode(curNode, new TNode(",","leaf",parser.lineNumber));
                parser.get3Token();
                parserExp(curNode);
                parser.get3Token();
            }
            if(parser.currentToken.equals(")"))addNode(curNode, new TNode(")","leaf",parser.lineNumber));
            else{
                parser.backToken();
                addNode(curNode, new ENode("j",parser.lineNumber,"error"));
            } 
            parser.get3Token();
            if(parser.currentToken.equals(";"))addNode(curNode, new TNode(";","leaf",parser.lineNumber));
            else{
                parser.backToken();
                addNode(curNode, new ENode("i",parser.lineNumber,"error"));
            } 
        }
        else if(parser.currentToken.equals("{")){//Block
            parserBlock(curNode);
        }
        else if(parser.currentToken.equals(";")){
            addNode(curNode, new TNode(";","leaf",parser.lineNumber));
        }
        
        else if(isX.isLVal()){
            parserLVal(curNode);
            parser.get3Token();
            if(parser.currentToken.equals("=")) addNode(curNode, new TNode("=", "leaf",parser.lineNumber));
            else{
                parser.backToken();
                addNode(curNode, new ENode("i",parser.lineNumber,"error"));
            } 
            parser.get3Token();
            if(isX.isExp()&&(!parser.currentToken.equals("getint"))&&(!parser.currentToken.equals("getchar"))){
                parserExp(curNode);
                parser.get3Token();
                if(parser.currentToken.equals(";"))addNode(curNode, new TNode(";","leaf",parser.lineNumber));
                else{
                    parser.backToken();
                    addNode(curNode, new ENode("i",parser.lineNumber,"error"));
                } 
            }
            else if(parser.currentToken.equals("getint")){
                addNode(curNode, new TNode("getint","leaf",parser.lineNumber));
                parser.get3Token();
                if(parser.currentToken.equals("("))addNode(curNode, new TNode("(","leaf",parser.lineNumber));
                else{
                    parser.backToken();
                    addNode(curNode, new ENode("j",parser.lineNumber,"error"));
                } 
                parser.get3Token();
                if(parser.currentToken.equals(")"))addNode(curNode, new TNode(")","leaf",parser.lineNumber));
                else{
                    parser.backToken();
                    addNode(curNode, new ENode("j",parser.lineNumber,"error"));
                } 
                parser.get3Token();
                if(parser.currentToken.equals(";"))addNode(curNode, new TNode(";","leaf",parser.lineNumber));
                else{
                    parser.backToken();
                    addNode(curNode, new ENode("i",parser.lineNumber,"error"));
                } 
            }
            else if(parser.currentToken.equals("getchar")){
                addNode(curNode, new TNode("getchar","leaf",parser.lineNumber));
                parser.get3Token();
                if(parser.currentToken.equals("("))addNode(curNode, new TNode("(","leaf",parser.lineNumber));
                else{
                    parser.backToken();
                    addNode(curNode, new ENode("j",parser.lineNumber,"error"));
                } 
                parser.get3Token();
                if(parser.currentToken.equals(")"))addNode(curNode, new TNode(")","leaf",parser.lineNumber));
                else{
                    parser.backToken();
                    addNode(curNode, new ENode("j",parser.lineNumber,"error"));
                } 
                parser.get3Token();
                if(parser.currentToken.equals(";"))addNode(curNode, new TNode(";","leaf",parser.lineNumber));
                else{
                    parser.backToken();
                    addNode(curNode, new ENode("i",parser.lineNumber,"error"));
                } 
            }
        }
        else{
            parserExp(curNode);
            parser.get3Token();
            if(parser.currentToken.equals(";"))addNode(curNode, new TNode(";","leaf",parser.lineNumber));
            else{
                parser.backToken();
                addNode(curNode, new ENode("i",parser.lineNumber,"error"));
            } 
        }
    }
    public static void parserForStmt(ASTNode parent){
        ASTNode curNode = addNode(parent, new NNode("ForStmt"));
        
        parserLVal(curNode);
        parser.get3Token();
        if(parser.currentToken.equals("=")) addNode(curNode, new TNode("=", "leaf",parser.lineNumber));
        else{
            parser.backToken();
            addNode(curNode, new ENode("i",parser.lineNumber,"error"));
        } 
        parser.get3Token();
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
        parser.get3Token();
        if(parser.currentToken.equals("[")){
            addNode(curNode, new TNode("[","leaf",parser.lineNumber));
            parser.get3Token();
            parserExp(curNode);
            parser.get3Token();
            if(parser.currentToken.equals("]")) addNode(curNode, new TNode("]","leaf",parser.lineNumber));
            else{
                parser.backToken();
                addNode(curNode, new ENode("k",parser.lineNumber,"error"));
            } 
        }
        else parser.backToken();
    }
    public static void parserPrimaryExp(ASTNode parent){
        ASTNode curNode = addNode(parent, new NNode("PrimaryExp"));
        if(parser.currentToken.equals("(")){
            addNode(curNode, new TNode("(","leaf",parser.lineNumber));
            parser.get3Token();
            parserExp(curNode);
            parser.get3Token();
            if(parser.currentToken.equals(")")) addNode(curNode, new TNode(")","leaf",parser.lineNumber));
            else{
                parser.backToken();
                addNode(curNode, new ENode("j",parser.lineNumber,"error"));
            } 
        }
        else if(parser.isCharConst(parser.currentToken)){
            parserCharacter(curNode);
            
        }
        else if(isX.isNumber()){
            parserNumber(curNode);
        }
        else{
            parserLVal(curNode);
        }
    }
    public static void parserNumber(ASTNode parent){
        ASTNode curNode = addNode(parent, new NNode("Number"));
        if(parser.isIntConst(parser.currentToken)) addNode(curNode, new TNode(parser.currentToken,"leaf",parser.lineNumber));
        else{
            parser.backToken();
            addNode(curNode, new ENode("noType",parser.lineNumber,"error"));
        } 
    }
    public static void parserCharacter(ASTNode parent){
        ASTNode curNode = addNode(parent, new NNode("Character"));
        if(parser.isCharConst(parser.currentToken)) addNode(curNode, new TNode(parser.currentToken,"leaf",parser.lineNumber));
        else{
            parser.backToken();
            addNode(curNode, new ENode("noType",parser.lineNumber,"error"));
        }
    }
    public static void parserUnaryExp(ASTNode parent){
        ASTNode curNode = addNode(parent, new NNode("UnaryExp"));
        if(isX.isUnaryOP()){
            parserUnaryOp(curNode);
            parser.get3Token();
            parserUnaryExp(curNode);
        }
        else if(parser.isIdentifier(parser.currentToken)&&parser.nextToken.equals("(")){
            parserIdent(curNode);
            
            parser.get3Token();
            if(parser.currentToken.equals("(")) addNode(curNode, new TNode("(","leaf",parser.lineNumber));
            else{
                parser.backToken();
                addNode(curNode, new ENode("j",parser.lineNumber,"error"));
            } 
            parser.get3Token();
            if(isX.isFuncRParams()&&(!parser.totleTokens[parser.token_index-2].equals("\n"))){
                parserFuncRParams(curNode);
                parser.get3Token();
            }
            if(parser.currentToken.equals(")")) addNode(curNode, new TNode(")","leaf",parser.lineNumber));
            else{
                parser.backToken();
                addNode(curNode, new ENode("j",parser.lineNumber,"error"));
            } 
        }
        else{
            parserPrimaryExp(curNode);
        }
    }
    public static void parserUnaryOp(ASTNode parent){
        ASTNode curNode = addNode(parent, new NNode("UnaryOp"));
        if(parser.currentToken.equals("-")) addNode(curNode, new TNode("-","leaf",parser.lineNumber));
        else if(parser.currentToken.equals("+")) addNode(curNode, new TNode("+","leaf",parser.lineNumber));
        else if(parser.currentToken.equals("!")) addNode(curNode, new TNode("!","leaf",parser.lineNumber));
        else{
            parser.backToken();
            addNode(curNode, new ENode("k",parser.lineNumber,"error"));
        } 
    }
    public static void parserFuncRParams(ASTNode parent){
        ASTNode curNode = addNode(parent, new NNode("FuncRParams"));
        parserExp(curNode);
        parser.get3Token();
        while(parser.currentToken.equals(",")){
            addNode(curNode, new TNode(",","leaf",parser.lineNumber));
            parser.get3Token();
            parserExp(curNode);
            parser.get3Token();
        }
        parser.backToken();
    }
    public static void parserMulExp(ASTNode parent){
        ASTNode curNode = addNode(parent, new NNode("MulExp"));
        parserUnaryExp(curNode);
        parser.get3Token();
        while(parser.currentToken.equals("*")||parser.currentToken.equals("/")||parser.currentToken.equals("%")){
            ASTNode newNode=insertNode(parent,curNode, new NNode("MulExp"));
            addNode(newNode, new TNode(parser.currentToken,"leaf",parser.lineNumber));
            parser.get3Token();
            parserUnaryExp(newNode);
            parser.get3Token();
            curNode = newNode;
        }
        parser.backToken();
    }
    public static void parserAddExp(ASTNode parent){
        ASTNode curNode = addNode(parent, new NNode("AddExp"));
        parserMulExp(curNode);
        
        parser.get3Token();
        while(parser.currentToken.equals("+")||parser.currentToken.equals("-")){
            ASTNode newNode=insertNode(parent,curNode, new NNode("AddExp"));
            addNode(newNode, new TNode(parser.currentToken,"leaf",parser.lineNumber));
            parser.get3Token();
            parserMulExp(newNode);
            parser.get3Token();
            curNode = newNode;
        }
        parser.backToken();
    }
    public static void parserRelExp(ASTNode parent){
        ASTNode curNode = addNode(parent, new NNode("RelExp"));
        parserAddExp(curNode);
        parser.get3Token();
        while(parser.currentToken.equals("<")||parser.currentToken.equals(">")||parser.currentToken.equals("<=")||parser.currentToken.equals(">=")){
            ASTNode newNode=insertNode(parent,curNode, new NNode("RelExp"));
            addNode(newNode, new TNode(parser.currentToken,"leaf",parser.lineNumber));
            parser.get3Token();
            parserAddExp(newNode);
            parser.get3Token();
            curNode = newNode;
        }
        parser.backToken();
    }
    public static void parserEqExp(ASTNode parent){
        ASTNode curNode = addNode(parent, new NNode("EqExp"));
        parserRelExp(curNode);
        parser.get3Token();
        while(parser.currentToken.equals("==")||parser.currentToken.equals("!=")){
            ASTNode newNode=insertNode(parent,curNode, new NNode("EqExp"));
            addNode(newNode, new TNode(parser.currentToken,"leaf",parser.lineNumber));
            parser.get3Token();
            parserRelExp(newNode);
            parser.get3Token();
            curNode = newNode;
        }
        parser.backToken();
    }
    public static void parserLAndExp(ASTNode parent){
        ASTNode curNode = addNode(parent, new NNode("LAndExp"));
        parserEqExp(curNode);
        parser.get3Token();
        while(parser.currentToken.equals("&&")||parser.currentToken.equals("&")){
            ASTNode newNode=insertNode(parent,curNode, new NNode("LAndExp"));
            if(parser.currentToken.equals("&")) addNode(newNode, new ENode("a",parser.lineNumber,"error"));
            else addNode(newNode, new TNode("&&","leaf",parser.lineNumber));
            parser.get3Token();
            parserEqExp(newNode);
            parser.get3Token();
            curNode = newNode;
        }
        parser.backToken();
    }
    public static void parserLOrExp(ASTNode parent){
        ASTNode curNode = addNode(parent, new NNode("LOrExp"));
        parserLAndExp(curNode);
        parser.get3Token();
        while(parser.currentToken.equals("||")||parser.currentToken.equals("|")){
            ASTNode newNode=insertNode(parent,curNode, new NNode("LOrExp"));
            if(parser.currentToken.equals("|")) addNode(newNode, new ENode("a",parser.lineNumber,"error"));
            else addNode(newNode, new TNode("||","leaf",parser.lineNumber));
            parser.get3Token();
            parserLAndExp(newNode);
            parser.get3Token();
            curNode = newNode;
        }
        parser.backToken();
    }
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
    
}

