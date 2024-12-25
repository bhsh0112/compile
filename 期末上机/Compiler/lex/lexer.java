package lex;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class lexer {
    public static final Map<String, String> words = new HashMap<>();

    public static String[] totleTokens;
    public static boolean zhuflag=false;

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
    public static String[] main(String inputFile,String outputFile,String errorFile) throws IOException{   
        File fileInputFile=new File(inputFile);

        BufferedReader reader = new BufferedReader(new FileReader(fileInputFile));

        StringBuilder sb = new StringBuilder();

        String line;
        while ((line = reader.readLine()) != null) {
            if(line.isEmpty()){
                sb.append("\n").append("~_");
                continue;
            }
            String[] tokens = tokenize(line);
            for (String s : tokens) {
                sb.append(s).append("~_");
                
            }
            sb.append("\n").append("~_");
        }
        totleTokens=sb.toString().split("~_");
        reader.close();
        return totleTokens;
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
            "(//)|"+//单行注释
            "(==|!=|<=|>=|<|>|&&|\\|\\||=|\\+|-|/\\*|\\*/|/\\*|\\*/|\\*|/|%|\\{|\\}|\\(|\\)|\\[|\\]|;|,|&|!|\\|)|" + // 操作符
            "(\'(\\\\.|[^\\'])\')|"+
            "(\\s+)"; // 空白字符
        Pattern pattern = Pattern.compile(patternString);
        Matcher matcher = pattern.matcher(code);

        while (matcher.find()) {
            if(matcher.group().equals("/*")){
                zhuflag=true;
            }
            if(matcher.group().equals("*/")){
                zhuflag=false;
                continue;
            }
            if(matcher.group().equals("//")&&!zhuflag) break;
            if (!matcher.group().matches("\\s+")&&!zhuflag) { // 忽略空白字符
                tokens.add(matcher.group());
            }
        }
        return tokens.toArray(new String[0]);
    }
}
