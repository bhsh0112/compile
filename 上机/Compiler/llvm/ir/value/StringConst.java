package llvm.ir.value;

public class StringConst extends Value{
    public String content;

    public StringConst(String content){
        this.content=content;
    }
}
