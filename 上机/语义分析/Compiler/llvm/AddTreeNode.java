package llvm;

import java.util.ArrayList;
import java.util.List;

public class AddTreeNode {
    public String value; // 节点存储的字符串
    public List<AddTreeNode> children; // 子节点列表

    public AddTreeNode(String value) {
        this.value = value;
        this.children = new ArrayList<>();
    }

    // 添加子节点的方法
    public void addChild(AddTreeNode child) {
        children.add(child);
    }
}
