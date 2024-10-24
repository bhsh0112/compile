package dataStructure;

import java.util.ArrayList;

public class ASTNode {
    public String name;
    public ASTNode parent;
    public ArrayList<ASTNode> children;

    public ASTNode(String name) {
        this.name = name;
        this.children = new ArrayList<>();
    }

    public void addChild(ASTNode child) {
        this.children.add(child);
        child.parent = this;
    }

    public void removeChild(Object child) {
        children.remove(child);
    }
}
