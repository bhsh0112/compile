package llvm.ir.value;

import java.io.BufferedWriter;
import java.io.IOException;

import dataStructure.ASTNode.ASTNode;
import llvm.AddTreeNode;
import symbol.symbol;

public class AddExp extends InitVal{
    String ans;
    Value parentValue;
    ASTNode AddExp;

    public AddExp(ASTNode AddExp){
        this.AddExp=AddExp;
    }

    public String llvmAddExp(ASTNode parent,BufferedWriter writer) throws IOException{
        AddTreeNode AddTreeRoot=buildAddTree(parent);
        orderAT(AddTreeRoot,writer);
        return AddTreeRoot.value;
    }
    public AddTreeNode buildAddTree(ASTNode parent){
        AddTreeNode ans=new AddTreeNode("head");
        buildTreeAddExp(ans,parent);
        return ans;
    }
    public void buildTreeAddExp(AddTreeNode ATparent,ASTNode ASTparent){
        if(ASTparent.children.size()==3){
            ATparent.addChild(new AddTreeNode("tmp"));
            buildTreeAddExp(ATparent.children.get(0),ASTparent.children.get(0));
            ATparent.addChild(new AddTreeNode(symbol.getASTNodeContent(ASTparent,new int[] {1})));
            ATparent.addChild(new AddTreeNode("tmp"));
            buildTreeMulExp(ATparent.children.get(2),ASTparent.children.get(2));
        }
        else buildTreeMulExp(ATparent,ASTparent.children.get(0));
    }
    public static void buildTreeMulExp(AddTreeNode ATparent,ASTNode ASTparent){
        // System.out.println(ASTparent.children.size());
        // System.out.println(llvm.getASTNodeContent(ASTparent,new int[] {0}));
        if(ASTparent.children.size()==3){
            ATparent.addChild(new AddTreeNode("tmp"));
            buildTreeMulExp(ATparent.children.get(0),ASTparent.children.get(0));
            ATparent.addChild(new AddTreeNode(symbol.getASTNodeContent(ASTparent,new int[] {1})));
            ATparent.addChild(new AddTreeNode("tmp"));
            buildTreeUnaryExp(ATparent.children.get(2),ASTparent.children.get(2));
        }
        else buildTreeUnaryExp(ATparent,ASTparent.children.get(0));
    }
    public static void buildTreeUnaryExp(AddTreeNode ATparent,ASTNode ASTparent){
        
        if(ASTparent.children.size()==2){
            if(symbol.getASTNodeContent(ASTparent,new int[] {0,0}).equals("-")){
                ATparent.addChild(new AddTreeNode("0"));
                ATparent.addChild(new AddTreeNode("-"));
                // if(llvm.getASTNodeContent(ASTparent,new int[] {1,0,0}).equals("<Number>")) ATparent.addChild(new AddTreeNode(llvm.getASTNodeContent(ASTparent,new int[] {1,0,0,0})));
                // else ATparent.addChild(new AddTreeNode(String.valueOf((int)(llvm.getASTNodeContent(ASTparent,new int[] {1,0,0,0}).charAt(1)))));
                ATparent.addChild(new AddTreeNode(symbol.getASTNodeContent(ASTparent,new int[] {1,0,0,0})));
            }
            else if(symbol.getASTNodeContent(ASTparent,new int[] {0,0}).equals("+")){
                ATparent.addChild(new AddTreeNode("0"));
                ATparent.addChild(new AddTreeNode("+"));
                // if(llvm.getASTNodeContent(ASTparent,new int[] {1,0,0}).equals("<Number>")) ATparent.addChild(new AddTreeNode(llvm.getASTNodeContent(ASTparent,new int[] {1,0,0,0})));
                // else ATparent.addChild(new AddTreeNode(String.valueOf((int)(llvm.getASTNodeContent(ASTparent,new int[] {1,0,0,0}).charAt(1)))));
                ATparent.addChild(new AddTreeNode(symbol.getASTNodeContent(ASTparent,new int[] {1,0,0,0})));
            }
            else{
                System.out.println("error\n");
            }
        }
        else{
            ATparent.value=symbol.getASTNodeContent(ASTparent,new int[] {0,0,0});
        }   
    }
    public void orderAT(AddTreeNode parent,BufferedWriter writer) throws IOException{
        if(parent.children.size()!=3||parent==null) return;
        for(AddTreeNode child:parent.children){
            orderAT(child,writer);
        }
        // System.out.println(parent.children.get(0).value+" "+parent.children.get(1).value+" "+parent.children.get(2).value);
        if(parent.children.get(0).value.startsWith("%")||parent.children.get(2).value.startsWith("%")){
            parent.value=this.getName();
            writer.write("\t"+parent.value+ " = ");
            switch(parent.children.get(1).value){
                case "+":
                    writer.write("add nsw ");
                    break;
                case "-":
                    writer.write("sub nsw ");
                    break;
                case "*":
                    writer.write("mul nsw ");
                    break;
                case "/":
                    writer.write("sdiv ");
                    break;
                case "%":
                    writer.write("srem ");
                    break;
            }
            writer.write(parent.children.get(0).value+", "+parent.children.get(2).value+"\n");
        }
        else{
            int num1=Integer.parseInt(parent.children.get(0).value);
            int num2=Integer.parseInt(parent.children.get(2).value);
            switch(parent.children.get(1).value){
                case "+":
                    parent.value=String.valueOf(num1+num2);
                    break;
                case "-":
                    parent.value=String.valueOf(num1-num2);
                    break;
                case "*":
                    parent.value=String.valueOf(num1*num2);
                    break;
                case "/":
                    parent.value=String.valueOf(num1/num2);
                    break;
                case "%":
                    parent.value=String.valueOf(num1%num2);
                    break;
            }
        }
    }
    public String output(BufferedWriter writer) throws IOException{
        return llvmAddExp(this.AddExp, writer);
    }
}
