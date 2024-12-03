package symbol;

import dataStructure.ASTNode.ASTNode;
import dataStructure.ASTNode.TNode;
import dataStructure.STT.STTNode;
import dataStructure.STT.STTQue;
import dataStructure.STT.STTQue.Element;

public class checkX {
    public static String isFuncCall(ASTNode parent){
        if(parent.name.equals("<Exp>")){
            if(symbol.getASTNodeContent(parent, new int[] {0}).equals("<AddExp>")&&symbol.getASTNodeContent(parent, new int[] {0,0}).equals("<MulExp>")&&symbol.getASTNodeContent(parent,new int[] {0,0,0}).equals("<UnaryExp>")&&symbol.getASTNodeContent(parent,new int[] {0,0,0,0}).equals("<Ident>")){
                return symbol.getASTNodeContent(parent,new int[] {0,0,0,0,0});
            }
        }
        return null;
    }
    
    public static boolean checkReDefine(STTQue que,String name,int lineNumber){
        if(que==null||que.isEmpty()) return true;
        for(Element element:que.que){
            if((element.type.equals("numofparams")&&element.kind.equals("Func"))||element.type.equals("return")){
                continue;
            }
            if(element.name.equals(name)){
                symbol.writeFile(symbol.errorFile,lineNumber+" "+"b\n");
                return false;
            }
        }
        return true;
    }
    public static void checkNewDefine(String name,boolean isConst){
        return;
    }
    public static void checkChangeConst(ASTNode parent){//传入LVal
        String lvalName=symbol.getASTNodeContent(parent,new int[] {0,0});
        STTNode tmp=symbol.currentSTTNode;
        while(tmp!=symbol.STTRoot){
            for(Element element:tmp.que.que){
                if(element.name.equals(lvalName)&&(!element.kind.equals("Const"))){
                    return;
                }
            }
            tmp=tmp.parent;
        }
        for(Element element:symbol.constSymbolTable){
            if(element.name.equals(lvalName)){
                symbol.writeFile(symbol.errorFile, ((TNode)symbol.getASTNode(parent,new int[] {0,0})).lineNumber+" "+"h\n");
            }
        }
    }
    public static void checkPrintf(ASTNode parent){
        String stringConst=symbol.getASTNodeContent(parent, new int[] {2,0});
        int expNum=(parent.children.size()-5)/2;
        int formatNum=0;
        for(int i=0;i<stringConst.length()-1;i++){
            if(stringConst.charAt(i)=='%'){
                if(stringConst.charAt(i+1)=='c'||stringConst.charAt(i+1)=='d') formatNum++;
                else if(stringConst.charAt(i+1)=='%') i++;
            } 
        }
        if(expNum!=formatNum){
            symbol.writeFile(symbol.errorFile, ((TNode)symbol.getASTNode(parent, new int[] {2,0})).lineNumber+" "+"l\n");
        }
    }
    public static void checkNoDefine(ASTNode parent){
        String lvalName=symbol.getASTNodeContent(parent,new int[] {0,0});
        STTNode tmp=symbol.currentSTTNode;
        while(tmp!=null){
            STTQue que=tmp.que;
            for(Element element:que.que){
                if((element.type.equals("numofparams")&&element.kind.equals("Func"))||element.type.equals("return")){
                    continue;
                }
                if(element.name.equals(lvalName)){
                    return;
                }
            }
            tmp=tmp.parent;
        }
        symbol.writeFile(symbol.errorFile, ((TNode)symbol.getASTNode(parent,new int[] {0,0})).lineNumber+" "+"c\n");
    }
    public static void checkFuncCall(ASTNode parent,String funcName,int paraNum,String[] paraTypes){
        for(STTQue que:symbol.funcSymbolTable){
            if(que.peekQue(0).name.equals(funcName)){
                if(que.peekQue(0).level!=paraNum){
                    symbol.writeFile(symbol.errorFile,((TNode)symbol.getASTNode(parent,new int[] {0,0,0,0,0})).lineNumber+" "+"d\n");
                    return;
                } 
                if(paraTypes==null) return;
                int tmpIndex=1;
                for(String type:paraTypes){
                    if(type.endsWith("Array")&&(!que.peekQue(tmpIndex).type.endsWith("Array"))){
                        symbol.writeFile(symbol.errorFile,((TNode)symbol.getASTNode(parent,new int[] {0,0,0,0,0})).lineNumber+" "+"e\n");
                        return;
                    }
                    else if(que.peekQue(tmpIndex).type.endsWith("Array")&&(!type.endsWith("Array"))){
                        symbol.writeFile(symbol.errorFile,((TNode)symbol.getASTNode(parent,new int[] {0,0,0,0,0})).lineNumber+" "+"e\n");
                        return;
                    }
                    else if(type.endsWith("Array")&&que.peekQue(tmpIndex).type.endsWith("Array")){
                        if((type.startsWith("Char")||(type.startsWith("ConstChar")))&&que.peekQue(tmpIndex).type.startsWith("Int")){
                            symbol.writeFile(symbol.errorFile,((TNode)symbol.getASTNode(parent,new int[] {0,0,0,0,0})).lineNumber+" "+"e\n");
                            return;
                        }
                        else if((type.startsWith("Int")||(type.startsWith("ConstInt")))&&que.peekQue(tmpIndex).type.startsWith("Char")){
                            symbol.writeFile(symbol.errorFile,((TNode)symbol.getASTNode(parent,new int[] {0,0,0,0,0})).lineNumber+" "+"e\n");
                            return;
                        }
                    }
                    tmpIndex++;
                }
            }
        }
    }
}
