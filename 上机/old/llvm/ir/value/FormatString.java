package llvm.ir.value;

import java.io.BufferedWriter;
import java.io.IOException;

import llvm.ir.StrNameAllocator;

public class FormatString extends GlobalValue{
    public String content;
    public FormatString(String str){
        this.content=str;
    }
    public String getName(){
        return StrNameAllocator.getInstance().alloc();
    }

    public int getLength(String content){
        int length=content.length();
        for(int i=0;i<content.length()-2;i++){
            if(content.charAt(i)=='\\'&&content.charAt(i+1)=='0'&&content.charAt(i+2)=='A') length-=2;
        }
        return length;
    }

    public void output(BufferedWriter writer) throws IOException{
        int length=getLength(content);
        // System.out.println(newContent);
        writer.write(getName()+" = private unnamed_addr constant ["+(length+1)+" x i8] c\""+content+"\\00\", align 1");
    }
}
