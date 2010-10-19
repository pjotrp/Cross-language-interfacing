package javaa.rest;

import java.io.IOException;
import java.io.PrintStream;
import java.io.PrintWriter;
import java.net.InetSocketAddress;
import java.net.SocketAddress;
import javaa.Translator;
import org.biojava3.core.sequence.ProteinSequence;
import org.biojava3.core.sequence.template.SequenceMixin;
import org.simpleframework.http.Request;
import org.simpleframework.http.Response;
import org.simpleframework.http.core.Container;
import org.simpleframework.transport.connect.Connection;
import org.simpleframework.transport.connect.SocketConnection;

/**
 * The following code is not a true rest server. It does not represent any
 * of the true concepts of REST i.e. a representational transfer of information
 * to a client by use of HTTP methods. What it does demonstrate is the ease
 * at which one can develop a server which can send results to a user over
 * HTTP.
 *
 * This is the basis of what REST aims to achieve however better examples of
 * what a REST service should provide are available.
 *
 * @author ayates
 */
public class Server {

    public static void main(String[] args) throws IOException {
      Container container = new TranslateContainer();
      Connection connection = new SocketConnection(container);
      SocketAddress address = new InetSocketAddress(9091);
      connection.connect(address);
    } 

    public static class TranslateContainer implements Container {

        private final Translator translator = new Translator();

        @Override
        public void handle(Request request, Response response) {

            try {
                PrintStream body = response.getPrintStream();
                PrintWriter w = new PrintWriter(body);

                Object dnaP = request.getForm().get("dna");
                if(dnaP != null) {
                    String dna = String.valueOf(dnaP);
                    ProteinSequence ps = translator.translate(dna);
                    long time = System.currentTimeMillis();

                    response.set("Content-Type", "text/plain");
                    response.set("Server", "TranslateServer/1.0 (Simple 4.0)");
                    response.setDate("Date", time);
                    response.setDate("Last-Modified", time);

                    SequenceMixin.write(w, ps);
                }
                else {
                    w.println("Cannot translate nothing");
                }

                w.close();
            }
            catch(IOException e) {
                throw new RuntimeException("Arrgh", e);
            }
        }
    }
}
