package dataStructure.STT;

import java.util.ArrayList;

import llvm.ir.value.*;

public class STTStack {
    public ArrayList<Element> stack; // 使用Element类存储栈的元素
    public int top; // 栈顶索引
    public int level=0; // 栈的层级
    

    // 内部类Element，用于存储栈的每个元素
    public static class Element {
        public int level;
        public String name;
        public String type;
        public Value value;
        public String kind;
        public int size;

        public Element(int level, String type,String kind,String name,Value value,int size) {
            this.level = level;
            this.type = type;
            this.value=value;
            this.name=name;
            this.kind=kind;
            this.size=size;
        }
    }

    public STTStack(int level) {
        this.stack = new ArrayList<>();
        this.top = -1;
        this.level=level;
    }

    public Element pushStack(int level, String type,String kind,String name,Value value,int size) {
        Element element = new Element(level, type,kind,name,value,size);
        stack.add(element);
        top++;
        return element;
    }

    public Element popStack() {
        if (isEmpty()) {
            throw new IllegalStateException("Stack is empty.");
        }
        Element element = stack.get(top);
        stack.remove(top);
        top--;
        return element;
    }

    public Element peekStack(int index) {
        if (isEmpty()) {
            throw new IllegalStateException("Stack is empty.");
        }
        return stack.get(index);
    }

    public boolean isEmpty() {
        return top == -1;
    }

    public void rmCurLevel(int level){
        while(stack.get(top).level==level){
            popStack();
        } 
    }
}