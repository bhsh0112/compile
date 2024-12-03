package llvm.ir;

public class StrNameAllocator {
    private int count = 0;
   private static final StrNameAllocator instance = new StrNameAllocator();

   public StrNameAllocator() {
   }

   public static StrNameAllocator getInstance() {
      return instance;
   }

   public void reset() {
      this.count = 0;
   }

   public String alloc() {
      String var1 = "@str" ;
      if(this.count>0) var1=var1+ "."+Integer.toString(this.count);
      ++this.count;
      return var1;
   }
}
