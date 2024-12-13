package llvm;

public class CharConst2Int {
    public CharConst2Int() {
        

    }
    public static String main(String str){
        if(str.charAt(1)=='\\'){
            switch (str.charAt(2)) {
                case '0':
                    return "0";
                case 'a':
                    return "7";
                case 'b':
                    return "8";
                case 't':
                    return "9";
                case 'n':
                    return "10";
                case 'v':
                    return "11";
                case 'f':
                    return "12";
                case 'r':
                    return "13";
                default:
                    return String.valueOf((int)(str.charAt(2)));
            }
        }
        else return String.valueOf((int)(str.charAt(1)));
    }
}
