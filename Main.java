import java.io.FileReader;
import java.io.IOException;

public class Main {
    public static void main(String[] args) {
        // String n = "Hi\n\x";
        try {
            FileReader reader = new FileReader("input.txt");
            // FileReader reader = new FileReader("errorInput.txt");
            TermProjectLexer lexer = new TermProjectLexer(reader);
            
            while (true) {
                int token = lexer.yylex();
                if (token == -1) {
                    break; // End of input
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
