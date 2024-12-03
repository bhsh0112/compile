package dataStructure;

public class TNode extends ASTNode {
    public String token;
    public TNode(String token, String name) {
        super(name);
        this.token = token;
    }
}
