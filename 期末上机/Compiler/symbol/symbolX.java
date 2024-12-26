package symbol;

import dataStructure.ASTNode.ASTNode;
import dataStructure.ASTNode.TNode;
import dataStructure.STT.STTNode;
import dataStructure.STT.STTQue;
import dataStructure.STT.STTQue.Element;

import parser.parser;

public class symbolX {
    public static void symbol(ASTNode parent){
        if(parent instanceof TNode){
            if(((TNode)parent).token.equals("printf")) {
                checkX.checkPrintf(parent.parent);
            }
            else if(((TNode)parent).token.equals("continue")||((TNode)parent).token.equals("break")) {
                if(parent.name.equals("errorleaf")){
                    symbol.writeFile(symbol.errorFile, ((TNode)parent).lineNumber+" m\n");
                }
            }
            else if(((TNode)parent).token.equals("return")) {
                // if(funcDefineFlag==VOIDFUNC&&(!symbol.getASTNodeContent(parent.parent,new int[] {1}).equals(";"))){
                //     symbol.writeFile(symbol.errorFile, ((TNode)parent).lineNumber+" f\n");
                // }

                String tmpFuncType=null;
                for(int i=symbol.STTRoot.que.que.size()-1;i>=0;i--){
                    if(symbol.STTRoot.que.que.get(i).kind.equals("Func")){
                        tmpFuncType=symbol.STTRoot.que.que.get(i).type;
                        break;
                    }
                }
                if(tmpFuncType!=null&&(!symbol.inMainFlag)&&tmpFuncType.equals("VoidFunc")&&(!symbol.getASTNodeContent(parent.parent,new int[] {1}).equals(";"))) {
                    
                    symbol.writeFile(symbol.errorFile, ((TNode)parent).lineNumber+" f\n");
                }
                
                symbol.currentSTTNode.que.pushQue(symbol.currentSTTNode.que.level,"return","return","return");
            }
            else if(((TNode)parent).token.equals("}")&&parent.parent.name.equals("<Block>")) {
                if(parent.parent.parent.name.equals("<FuncDef>")||parent.parent.parent.name.equals("<MainFuncDef>")) {
                    
                    if(symbol.gErrorFlag){
                        if(parent.parent.children.size()<3){
                            symbol.writeFile(symbol.errorFile, ((TNode)parent).lineNumber+" g\n");
                        }
                        else if(!symbol.getASTNodeContent(parent.parent, new int[] {parent.parent.children.size()-2,0,0}).equals("return")){
                            symbol.writeFile(symbol.errorFile, ((TNode)parent).lineNumber+" g\n");
                        }
                    }
                }
                symbol.forFlag=false;
                symbol.currentSTTNode=symbol.currentSTTNode.parent;
                symbol.currentSTTQue=symbol.currentSTTNode.que;
            }
            else if(((TNode)parent).token.equals("{")&&parent.parent.name.equals("<Block>")) {
                
            }
            
        }
        else{
            if(parent.name.equals("<VarDecl>")) {
                
                String ansVarType;
                String ansVarName;
                int childrenNum=parent.children.size();
                int varNum=(childrenNum-1)/2;
                String tmpVarType=symbol.getASTNodeContent(parent, new int[]{0,0});
                String tmpVarName=symbol.getASTNodeContent(parent, new int[]{1,0,0});
                System.out.println(tmpVarName);
                ansVarName=tmpVarName;
                ansVarType=tmpVarType;
                if(checkX.checkReDefine(symbol.currentSTTQue,ansVarName, ((TNode)symbol.getASTNode(parent, new int[]{1,0,0})).lineNumber)){
                    checkX.checkNewDefine(ansVarName,false);
                    if((parent.children.get(1).children.size()>=2)&&(symbol.getASTNodeContent(parent, new int[] {1,1}).equals("["))) ansVarType=tmpVarType+"R";
                    symbol.currentSTTNode.que.pushQue(symbol.currentSTTNode.que.level,ansVarName,symbol.varSymbolType.get(ansVarType),"Var");
                    
                }
                
                for(int i=2;i<=varNum;i++){
                    ansVarType=tmpVarType;
                    tmpVarName=symbol.getASTNodeContent(parent, new int[] {2*i-1,0,0});
                    ansVarName=tmpVarName;
                    if(checkX.checkReDefine(symbol.currentSTTQue,ansVarName,((TNode)symbol.getASTNode(parent, new int[]{2*i-1,0,0})).lineNumber )){
                        checkX.checkNewDefine(ansVarName,false);
                        if((parent.children.get(2*i-1).children.size()>=2)&&symbol.getASTNodeContent(parent, new int[] {2*i-1,1}).equals("[")) ansVarType=tmpVarType+"R";
                        symbol.currentSTTNode.que.pushQue(symbol.currentSTTNode.que.level,ansVarName,symbol.varSymbolType.get(ansVarType),"Var");
                    }
                    
                }
            }
            else if(parent.name.equals("<ConstDecl>")) {
                String ansVarType;
                String ansVarName;
                int childrenNum=parent.children.size();
                int varNum=(childrenNum-2)/2;
                String tmpVarType=symbol.getASTNodeContent(parent, new int[]{1,0});
                String tmpVarName=symbol.getASTNodeContent(parent, new int[]{2,0,0});
                ansVarName=tmpVarName;
                ansVarType=tmpVarType;
                if(checkX.checkReDefine(symbol.currentSTTQue,ansVarName, ((TNode)symbol.getASTNode(parent, new int[]{2,0,0})).lineNumber)){
                    checkX.checkNewDefine(ansVarName,true);
                    if((parent.children.get(2).children.size()>=2)&&symbol.getASTNodeContent(parent, new int[]{2,1}).equals("[")) ansVarType=tmpVarType+"R";
                    symbol.currentSTTNode.que.pushQue(symbol.currentSTTNode.que.level,ansVarName,symbol.constSymbolType.get(ansVarType),"Const");
                    symbol.constSymbolTable.add(new Element(symbol.currentLevel,ansVarName,symbol.constSymbolType.get(ansVarType),"Const"));
                }
                
                for(int i=2;i<=varNum;i++){
                    ansVarType=tmpVarType;
                    tmpVarName=symbol.getASTNodeContent(parent, new int[]{2*i,0,0});
                    ansVarName=tmpVarName;
                    if(checkX.checkReDefine(symbol.currentSTTQue,ansVarName, ((TNode)symbol.getASTNode(parent, new int[]{2*i,0,0})).lineNumber)){
                        checkX.checkNewDefine(ansVarName,true);
                        if((parent.children.get(2*i).children.size()>=2)&&symbol.getASTNodeContent(parent, new int[]{2*i,1}).equals("[")) ansVarType=tmpVarType+"R";
                        symbol.currentSTTNode.que.pushQue(symbol.currentSTTNode.que.level,ansVarName,symbol.constSymbolType.get(ansVarType),"Const");
                        symbol.constSymbolTable.add(new Element(symbol.currentLevel,ansVarName,symbol.constSymbolType.get(ansVarType),"Const"));
                    }
                    
                }
            }
            else if(parent.name.equals("<FuncDef>")) {
                String tmpFuncName=symbol.getASTNodeContent(parent, new int[] {1,0});
                String tmpFuncType=symbol.funcSymbolType.get(symbol.getASTNodeContent(parent, new int[] {0,0}));
                if(tmpFuncType.equals("VoidFunc")){
                    symbol.gErrorFlag=false;
                }
                else{
                    symbol.gErrorFlag=true;
                }
                if(checkX.checkReDefine(symbol.STTRoot.que, tmpFuncName, ((TNode)symbol.getASTNode(parent, new int[] {1,0})).lineNumber)){
                    symbol.rightFuncDefine=true;
                    symbol.STTRoot.que.pushQue(1,tmpFuncName,tmpFuncType,"Func");
                    STTQue newQue=new STTQue(symbol.currentLevel+1);
                    newQue.pushQue(0,tmpFuncName,"numofparams","Func");
                    symbol.funcSymbolTable.add(newQue);
                    symbol.addNewNodeFlag=false;
                }
                else{
                    symbol.rightFuncDefine=false;
                } 
            }
            else if(parent.name.equals("<MainFuncDef>")) {
                symbol.gErrorFlag=true;
                symbol.rightFuncDefine=true;
                symbol.inMainFlag=true;
            }
            else if(parent.name.equals("<FuncFParam>")) {
                String tmpName=symbol.getASTNodeContent(parent, new int[]{1,0});
                String tmpType=symbol.getASTNodeContent(parent, new int[]{0,0});
                if((parent.children.size()>2)&&symbol.getASTNodeContent(parent, new int[]{2}).equals("[")) tmpType=tmpType+"R";
                STTQue newQue=symbol.funcSymbolTable.get(symbol.funcSymbolTable.size()-1);
                newQue.peekQue(0).level++;
                if(checkX.checkReDefine(newQue,tmpName, ((TNode)symbol.getASTNode(parent, new int[]{1,0})).lineNumber)){
                    newQue.pushQue(symbol.currentLevel+1,tmpName,symbol.varSymbolType.get(tmpType),"Para");
                }
                
                //symbol.funcSymbolTable.add(newQue);
            }
            else if(parent.name.equals("<Block>")) {
                symbol.currentLevel++;
                STTQue newQue=(!symbol.addNewNodeFlag)?symbol.funcSymbolTable.get(symbol.funcSymbolTable.size()-1):new STTQue(symbol.currentLevel);
                symbol.addNewNodeFlag=true;
                symbol.currentSTTQue=newQue;
                STTNode newSTTNode=new STTNode(symbol.currentSTTQue);
                symbol.currentSTTNode.addChild(newSTTNode);
                symbol.currentSTTNode=newSTTNode;
                symbol.currentSTTNode.que=symbol.currentSTTQue;
                //funcDefineFlag=0;
            }
            //函数调用
            else if(checkX.isFuncCall(parent)!=null) {
                int paraNum=0;
                if(symbol.getASTNode(parent, new int[] {0,0,0,symbol.getASTNode(parent,new int[] {0,0,0}).children.size()-1}).name.equals("error")) return;
                if(symbol.getASTNodeContent(parent, new int[] {0,0,0,2}).equals(")")) paraNum=0;
                else{
                    paraNum=symbol.getASTNode(parent, new int[] {0,0,0,2}).children.size()/2+1;
                }
                String[] paraNames=(paraNum==0)?null:new String[paraNum];

                //获取变量名，一坨狗屎
                for(int i=0;i<paraNum;i++){
                    String paraKind=symbol.getASTNodeContent(parent, new int[] {0,0,0,2,2*i,0,0,0,0,0});
                    if(paraKind.equals("<Number>")||paraKind.equals("<Character>")){
                        paraNames[i]=symbol.getASTNodeContent(parent, new int[] {0,0,0,2,2*i,0,0,0,0,0,0});
                    }
                    else if(paraKind.equals("<LVal>")){//变量
                        paraNames[i]=symbol.getASTNodeContent(parent, new int[] {0,0,0,2,2*i,0,0,0,0,0,0,0});
                        if(symbol.getASTNode(parent, new int[] {0,0,0,2,2*i,0,0,0,0,0}).children.size()>1&&symbol.getASTNodeContent(parent, new int[] {0,0,0,2,2*i,0,0,0,0,0,1}).equals("[")){
                            paraNames[i]=paraNames[i]+"\'s element";
                        }
                    } 
                    else{//不是变量的前提下，不会是数组，因为in、char可互传，这里统一制成数字1就可以
                        paraNames[i]="1";
                    }
                    
                }
                String[] paraTypes=(paraNum==0)?null:new String[paraNum];
                
                //确定参数类型
                for(int i=0;i<paraNum;i++){
                    
    
                    //如果是字符常量
                    if(parser.isCharConst(paraNames[i])){
                        paraTypes[i]="Char";
                    } 
                    //如果是数字常量
                    else if(parser.isIntConst(paraNames[i])){
                        paraTypes[i]="Int";
                    }
                    else if(paraNames[i].endsWith(" func")&&paraNames[i].startsWith("a ")){
                        String returnType=paraNames[i].substring(2, paraNames[i].length()-5);
                        if(returnType.equals("VoidFunc")) paraTypes[i]="void";
                        else if(returnType.equals("IntFunc")) paraTypes[i]="int";
                        else if(returnType.equals("CharFunc")) paraTypes[i]="char";
                    }
                    //如果是已有变量
                    else{
                        boolean flag=false;
                        STTNode tmpNode=symbol.currentSTTNode;
                        while(tmpNode!=null){
                            for(Element element:tmpNode.que.que){
                                if(element.name.equals(paraNames[i])){
                                    paraTypes[i]=element.type;
                                    flag=true;
                                    break;
                                }
                                else if((element.name+"\'s element").equals(paraNames[i])){
                                    if(element.type.equals("IntArray")||element.type.equals("ConstIntArray")){
                                        paraTypes[i]="Int";
                                    }
                                    else if(element.type.equals("CharArray")||element.type.equals("ConstCharArray")){
                                        paraTypes[i]="Char";
                                    }
                                    flag=true;
                                    break;
                                }
                            }
                            tmpNode=tmpNode.parent;
                        }
                        if(!flag) return;
                    }
                }
                
                checkX.checkFuncCall(parent, symbol.getASTNodeContent(parent, new int[] {0,0,0,0,0}), paraNum, paraTypes);
            }
            
            else if(parent.name.equals("<Stmt>")) {
                if(symbol.getASTNodeContent(parent, new int[] {0}).equals("<LVal>")) checkX.checkChangeConst(symbol.getASTNode(parent, new int[] {0}));
            }
            else if(parent.name.equals("<LVal>")) {
                // System.out.println("error");
                checkX.checkNoDefine(parent);
            }
            else if(parent.name.equals("<ForStmt>")) {
                checkX.checkChangeConst(symbol.getASTNode(parent,new int[] {0} ));
            }
            else if(parent.name.equals("<UnaryExp>")&&symbol.getASTNodeContent(parent, new int[] {0}).equals("<Ident>")) {
                checkX.checkNoDefine(parent);
            }

        }
        
        
    }
}
