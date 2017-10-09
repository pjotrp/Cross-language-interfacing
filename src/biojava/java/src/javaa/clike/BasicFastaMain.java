/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package javaa.clike;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import javaa.Args;
import org.biojava.nbio.core.sequence.compound.AminoAcidCompoundSet;
import org.biojava.nbio.core.sequence.compound.RNACompoundSet;
import org.biojava.nbio.core.sequence.io.IUPACParser;

/**
 *
 * @author ayates
 */
public class BasicFastaMain {

    private final CTranslator translator = new CTranslator(
            IUPACParser.getInstance().getTable(1),
            RNACompoundSet.getRNACompoundSet(),
            AminoAcidCompoundSet.getAminoAcidCompoundSet());

    public static void main(String[] args) throws Exception {
        new BasicFastaMain().run(args);
    }

    private void run(String[] args) throws Exception {
        Args a = getArgs(args);
        if (a.isVerbose()) {
          System.out.println("Reading Fasta file "+a.getLocation()+" x "+a.getTimes());
        }
        Map<String,String> m = parse(a);
        for(Map.Entry<String,String> e: m.entrySet()) {
            StringBuilder peptide = translator.getProtein(e.getValue());
            System.out.println(">"+e.getKey());
            System.out.append(peptide);
            System.out.println("");
        }
    }

    public Map<String, String> parse(Args a) throws IOException {
        Map<String, String> m = new HashMap<String, String>();
        BufferedReader br = new BufferedReader(new FileReader(a.getLocation()));
        String l;
        String id = null;
        StringBuilder dna = new StringBuilder();
        while( (l = br.readLine()) != null ) {
            String line = l.trim();
            if(line.startsWith(">")) {
                if(id != null) {
                    m.put(id, dna.toString());
                    dna.delete(0, dna.length());
                    id = null;
                }
                id = line.substring(1);
            }
            else {
                dna.append(line);
            }
        }
        if(id != null) {
            m.put(id, dna.toString());
        }
        br.close();
        return m;
    }

    private Args getArgs(String[] args) throws IOException {
        return Args.parse(args);
    }
}
