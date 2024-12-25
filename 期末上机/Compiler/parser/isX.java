package parser;

public class isX {
    public static boolean isDecl(){
        return isConstDecl()||isVarDecl();
    }
    public static boolean isVarDecl(){
        return ((parser.currentToken.equals("int")||parser.currentToken.equals("char"))&&(parser.isIdentifier(parser.nextToken))&&(!parser.nnextToken.equals("(")));
    }
    public static boolean isFuncDef(){
        return (parser.currentToken.equals("int")||parser.currentToken.equals("char")||parser.currentToken.equals("void"))&&parser.isIdentifier(parser.nextToken)&&parser.nnextToken.equals("(");
    }
    public static boolean isMainFuncDef(){
        return (parser.currentToken.equals("int"))&&parser.nextToken.equals("main")&&parser.nnextToken.equals("(");
    }
    public static boolean isBType(){
        return (parser.currentToken.equals("int")||parser.currentToken.equals("char"));
    }
    public static boolean isConstDecl(){
        return (parser.currentToken.equals("const"));
    }
    public static boolean isConstDef(){
        return parser.isIdentifier(parser.currentToken)&&(parser.nextToken.equals("=")||parser.nextToken.equals("["));
    }
    public static boolean isPrimaryExp(){
        int flag=0;
        if(parser.currentToken.equals("(")){
            parser.get3Token();
            
            if(isExp()){
                flag=1;
            }
            parser.backToken();
        }
        else if(parser.isIdentifier(parser.currentToken)) flag=1;
        else if(isNumber()) flag=1;
        else if(parser.isCharConst(parser.currentToken)) flag=1;
        return flag==1;
        
    }
    public static boolean isConstExp(){
        return isUnaryExp();   
    }
    public static boolean isExp(){
        return isUnaryExp();
    }
    public static boolean isUnaryExp(){
        return isPrimaryExp()||(parser.isIdentifier(parser.currentToken)&&parser.nextToken.equals("("))||isUnaryOP();
    }
    public static boolean isUnaryOP(){
        return parser.currentToken.equals("+")||parser.currentToken.equals("-")||parser.currentToken.equals("!");
    }
    public static boolean isFuncType(){
        return (parser.currentToken.equals("int")||parser.currentToken.equals("char")||parser.currentToken.equals("void"));
    }
    public static boolean isFuncFParams(){
        return ((parser.currentToken.equals("int")||parser.currentToken.equals("char"))&&(parser.isIdentifier(parser.nextToken)));
    }
    public static boolean isInitVal(){
        return (isExp()||parser.isStringConst(parser.currentToken)||(parser.currentToken.equals("{")));
    }
    public static boolean isBlockItem(){
        return isDecl()||isStmt();
    }
    public static boolean isStmt(){
        return parser.currentToken.equals("if")||parser.currentToken.equals("for")||parser.currentToken.equals("break")||parser.currentToken.equals("continue")||parser.currentToken.equals("return")||parser.currentToken.equals("printf")||parser.currentToken.equals("{")||parser.currentToken.equals(";")||isExp()||isLVal();
    }
    public static boolean isLVal(){
        int flag=0;
        for(int i=parser.token_index-1;;i++){
            if(parser.totleTokens[i].equals("\n")) break;
            if(parser.totleTokens[i].equals("=")){
                flag=1;
                break;
            } 
        }
        return flag==1&&parser.isIdentifier(parser.currentToken);
    }
    public static boolean isCond(){
        return isUnaryExp();
    }
    public static boolean isForStmt(){
        return isVarDecl()||isLVal();
    }
    public static boolean isNumber(){
        return parser.isIntConst(parser.currentToken);
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
}
