package dataStructure.STT;
import java.util.ArrayList;
public class STTQue {

    public ArrayList<Element> que;
    public int front;
    public int rear;
    public int level; // 队列的层级
    public Element ret;

    public static class Element {
        public int level;
        public String name;
        public String type;

        public Element(int level, String name, String type) {
            this.level = level;
            this.name = name;
            this.type = type;
        }
    }
    public STTQue(int level) {
        this.que = new ArrayList<>();
        this.front = -1;
        this.rear = 0;
        this.level=level;
        this.ret = null;
    }

    public void pushQue(int level, String name, String type) {
        Element element = new Element(level, name, type);
        que.add(element);
        front++;
    }

    public Element popQue() {
        if (isEmpty()) {
            throw new IllegalStateException("Que is empty.");
        }
        Element element = que.get(rear);
        //que.remove(rear);
        rear++;
        return element;
    }

    public Element peekQue(int index) {
        if (isEmpty()) {
            throw new IllegalStateException("Que is empty.");
        }
        return que.get(index);
    }

    public boolean isEmpty() {
        return rear>front;
    }
    public void removeQue(Element element) {
        if (isEmpty()) {
            throw new IllegalStateException("Que is empty.");
        }
        que.remove(element);
    }

    public void setRet(Element element) {
        ret = element;
    }
}
