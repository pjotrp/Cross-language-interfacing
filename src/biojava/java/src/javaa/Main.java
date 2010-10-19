package javaa;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.Writer;
import java.util.Map;
import org.biojava3.core.sequence.DNASequence;
import org.biojava3.core.sequence.ProteinSequence;
import org.biojava3.core.sequence.io.FastaReaderHelper;
import org.biojava3.core.sequence.template.SequenceMixin;

/**
 * Basic program used for translating sequences
 *
 * @author ayates
 */
public class Main {

    public static void main(String[] args) throws Exception {
        new Main().run(args);
    }

    private final Translator translator = new Translator();

    private void run(String[] args) throws Exception {
        Args a = getArgs(args);
        if (a.isVerbose()) {
          System.out.println("Reading Fasta file "+a.getLocation()+" x "+a.getTimes());

        }
        Map<String, DNASequence> seqMap =
                FastaReaderHelper.readFastaDNASequence(a.getLocation());
        Writer w = new PrintWriter(System.out);
        for(int i=0; i<a.getTimes(); i++) {
            for(Map.Entry<String, DNASequence> entry: seqMap.entrySet()) {
                DNASequence dna = entry.getValue();
                ProteinSequence ps = translator.translate(dna);
                System.out.println(">"+dna.getAccession());
                System.out.flush();
                SequenceMixin.write(w, ps);
                w.flush();
                System.out.println("");
                System.out.flush();
            }
        }
    }

    private Args getArgs(String[] args) throws IOException {
        return Args.parse(args);
    }

    
}
