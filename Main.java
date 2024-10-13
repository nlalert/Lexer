import java.io.FileReader;
import java.io.IOException;

public class Main {
    public static void main(String[] args) {
        if(args.length != 0){
            try {
                FileReader reader = new FileReader("errorInput.txt");
                TermProjectLexer lexer = new TermProjectLexer(reader);
                
                while (lexer.yylex() != -1) {
                    // Lexer จะอ่าน token ไปเรื่อยๆ จนกว่าจะสิ้นสุดไฟล์
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        else{
            try {
                FileReader reader = new FileReader("input.txt");
                TermProjectLexer lexer = new TermProjectLexer(reader);
                
                while (lexer.yylex() != -1) {
                    // Lexer จะอ่าน token ไปเรื่อยๆ จนกว่าจะสิ้นสุดไฟล์
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }
}
