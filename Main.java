import java.io.FileReader;
import java.io.IOException;

public class Main {
    public static void main(String[] args) {
        try {
            FileReader reader = new FileReader(args[0]);
            TermProjectLexer lexer = new TermProjectLexer(reader);
            
            while (lexer.yylex() != -1) {
                // Lexer จะอ่าน token ไปเรื่อยๆ จนกว่าจะสิ้นสุดไฟล์
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
