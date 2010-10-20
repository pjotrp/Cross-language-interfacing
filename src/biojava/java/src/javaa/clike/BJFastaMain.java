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
import org.biojava3.core.sequence.DNASequence;
import org.biojava3.core.sequence.compound.AminoAcidCompoundSet;
import org.biojava3.core.sequence.compound.RNACompoundSet;
import org.biojava3.core.sequence.io.FastaReaderHelper;
import org.biojava3.core.sequence.io.IUPACParser;
import org.biojava3.core.sequence.io.IUPACParser.IUPACTable;

/**
 *
 * @author ayates
 */
public class BJFastaMain {

    private final CTranslator translator = new CTranslator(
            IUPACParser.getInstance().getTable(1),
            RNACompoundSet.getRNACompoundSet(),
            AminoAcidCompoundSet.getAminoAcidCompoundSet());

    public static void main(String[] args) throws Exception {
        new BJFastaMain().run(args);
    }

    private void run(String[] args) throws Exception {
        Args a = getArgs(args);
        if (a.isVerbose()) {
          System.out.println("Reading Fasta file "+a.getLocation()+" x "+a.getTimes());
        }
        Map<String, DNASequence> seqMap =
                FastaReaderHelper.readFastaDNASequence(a.getLocation());
        for(Map.Entry<String, DNASequence> entry: seqMap.entrySet()) {
            DNASequence dna = entry.getValue();
            StringBuilder peptide = translator.getProtein(dna);
            System.out.println(">"+dna.getAccession());
            System.out.append(peptide);
            System.out.println("");
        }
    }

    private Args getArgs(String[] args) throws IOException {
        return Args.parse(args);
    }
}
