package dataStructure.ASTNode;

public class TNode extends ASTNode {
    public String token;
    public int lineNumber;
    public TNode(String token, String name,int lineNumber) {
        super(name);
        this.token = token;
        this.lineNumber = lineNumber;
    }
}
