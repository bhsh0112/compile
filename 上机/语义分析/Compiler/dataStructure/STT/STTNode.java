package dataStructure.STT;

import java.util.ArrayList;

public class STTNode {
    public STTStack stack;
    public STTNode parent;
    public ArrayList<STTNode> children;

    public STTNode(STTStack stack) {
        this.stack = stack;
        this.children = new ArrayList<>();
    }

    public void addChild(STTNode child) {
        this.children.add(child);
        child.parent = this;
    }

    public void removeChild(Object child) {
        children.remove(child);
    }
}
