import java.io.*;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
public class Compiler {
    
    private static final Map<String, String> words = new HashMap<>();
    
    public static String tmp_token;
    public static boolean flag=false;

    //build the directory "words"
    static {
        words.put("main", "MAINTK");
        words.put("const", "CONSTTK");
        words.put("int", "INTTK");
        words.put("char", "CHARTK");
        words.put("break", "BREAKTK");
        words.put("continue", "CONTINUETK");
        words.put("if", "IFTK");
        words.put("else", "ELSETK");
        words.put("for", "FORTK");
        words.put("getint", "GETINTTK");
        words.put("getchar", "GETCHARTK");
        words.put("printf", "PRINTFTK");
        words.put("return", "RETURNTK");
        words.put("void", "VOIDTK");
        words.put(";", "SEMICN");
        words.put("!", "NOT");
        words.put("*", "MULT");
        words.put(",", "COMMA");
        words.put("&&", "AND");
        words.put("||", "OR");
        words.put("/", "DIV");
        words.put("%", "MOD");
        words.put("(", "LPARENT");
        words.put(")", "RPARENT");
        words.put("[", "LBRACK");
        words.put("]", "RBRACK");
        words.put("{", "LBRACE");
        words.put("}", "RBRACE");
        words.put("<", "LSS");
        words.put("<=", "LEQ");
        words.put(">", "GRE");
        words.put(">=", "GEQ");
        words.put("==", "EQL");
        words.put("!=", "NEQ");
        words.put("+", "PLUS");
        words.put("-", "MINU");
        words.put("=", "ASSIGN");
    }

    public static void main(String[] args) throws IOException{   
        File inputFile = new File("testfile.txt");

        BufferedReader reader = new BufferedReader(new FileReader(inputFile));
        BufferedWriter lexerWriter = new BufferedWriter(new FileWriter("lexer.txt"));
        BufferedWriter errorWriter = new BufferedWriter(new FileWriter("error.txt"));

        String line;
        int lineNumber = 1;
        while ((line = reader.readLine()) != null) {
            // StringBuilder content = new StringBuilder();
            // while ((line = reader.readLine()) != null) {
            //     content.append(line);
            //     content.append(System.lineSeparator()); // 保留换行符
            // }
            // String fileContent = content.toString(); // 将累积的内容转换为字符串
            String[] tokens = tokenize(line);
            //lexerWriter.write(tokens + "\n");
            for (String token : tokens) {
                // 遍历分词结果。
                //lexerWriter.write("11111\n");
                if (isWords(token)) {
                    lexerWriter.write(words.get(token) + " " + token + "\n");
                } else if (isIntConst(token)) {
                    lexerWriter.write("INTCON " + token + "\n");
                } else if (isStringConst(token)) {
                    lexerWriter.write("STRCON " + token + "\n");
                } else if (isCharConst(token)) {
                    lexerWriter.write("CHRCON " + token + "\n");
                }  else if (isIdentifier(token)) {
                    lexerWriter.write("IDENFR " + token + "\n");
                } else if (token.length()==0){
                    continue;
                } else {
                    String errortype=getErrorType(token);
                    errorWriter.write(lineNumber + " " + errortype +"\n");
                    //break;
                }
            }
            //lexerWriter.write("1\n");
            lineNumber++;
        }

        

        reader.close();
        lexerWriter.close();
        errorWriter.close();
    }
    private static boolean isWords(String token) {
        return words.containsKey(token);
    }
    private static boolean isIdentifier(String token) {
        // Implement identifier detection logic here
        return token.matches("[a-zA-Z_][a-zA-Z0-9_]*");
    }

    // 定义一个方法来检查一个token是否是标识符。
    private static boolean isIntConst(String token) {
        // Implement integer constant detection logic here
        return token.matches("-?\\d+");
    }

    // 定义一个方法来检查一个token是否是整数常量。
    private static boolean isStringConst(String token) {
        // Implement string constant detection logic here
        return token.matches("\".*?\"");
    }

    // 定义一个方法来检查一个token是否是字符串常量。
    private static boolean isCharConst(String token) {
        // Implement character constant detection logic here
        return token.matches("\'(\\\\.|[^\\'])\'");
    }
    public static String[] tokenize(String code) {
        List<String> tokens = new ArrayList<>();
        //String first_patteString="(\\s+[\\S ]{1,}\\s+)";// 左右均为空格的字符串
        // 定义正则表达式模式
        String patternString = 
            "(\\b(main|const|int|char|break|continue|if|else|for|return|void|while)\\b)|" + // 关键字
            "(\\b(getint|getchar|printf)\\b)|"+//函数
            "(\\b[a-zA-Z_][a-zA-Z0-9_]*\\b)|" + // 标识符
            "(\\b\\d+\\b)|" + // 常量
            "(\".*?\")|" +
            "(//.*$)|"+//单行注释
            "(==|!=|<=|>=|<|>|&&|\\|\\||=|\\+|-|/\\*|\\*/|/\\*|\\*/|\\*|/|%|\\{|\\}|\\(|\\)|\\[|\\]|;|,|&|!|\\|)|" + // 操作符
            "(\'(\\\\.|[^\\'])\')|"+ 
            "(\\s+)"; // 空白字符
        Pattern pattern = Pattern.compile(patternString);
        Matcher matcher = pattern.matcher(code);

        while (matcher.find()) {
            if(matcher.group().equals("/*")){
                flag=true;
            }
            if(matcher.group().equals("*/")){
                flag=false;
            }
            if(matcher.group().startsWith("//")) break;
            if (!matcher.group().matches("\\s+")&&!flag) { // 忽略空白字符
                tokens.add(matcher.group());
            }
        }
        return tokens.toArray(new String[0]);
    }
    public static String getErrorType(String token){
        if(token.equals("&")||token.equals("|")) return "a";
        // else if(){
            
        //     return "b";
        // }
        // else if(){

        //     return "c";
        // }
        // else if(){

        //     return "d";
        // }
        // else if(){

        //     return "e";
        // }
        else return "invalid error";
    }
    
}
