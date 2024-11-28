package dataStructure.ASTNode;

public class ENode extends ASTNode {
    public String errorType;
    public int lineNumber;

    public ENode(String errorType, int lineNumber, String name) {
        super(name);
        this.errorType = errorType;
        this.lineNumber = lineNumber;
    }
}
