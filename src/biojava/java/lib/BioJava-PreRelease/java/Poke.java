
import java.io.InputStream;
import org.biojava3.core.sequence.DNASequence;
import org.biojava3.core.sequence.RNASequence;
import org.biojava3.core.sequence.compound.AminoAcidCompound;
import org.biojava3.core.sequence.compound.DNACompoundSet;
import org.biojava3.core.sequence.compound.NucleotideCompound;
import org.biojava3.core.sequence.io.DNASequenceCreator;
import org.biojava3.core.sequence.io.FastaReader;
import org.biojava3.core.sequence.io.GenericFastaHeaderParser;
import org.biojava3.core.sequence.io.util.ClasspathResource;
import org.biojava3.core.sequence.io.util.IOUtils;
import org.biojava3.core.sequence.template.Sequence;
import org.biojava3.core.sequence.transcription.RNAToAminoAcidTranslator;
import org.biojava3.core.sequence.transcription.TranscriptionEngine;

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 *
 * @author ayates
 */
public class Poke {

    public static void main(String[] args) throws Exception {
        new Poke().translateBrca2();
    }

    private final int iterations = 25000;

    private static DNACompoundSet dnaCs = DNACompoundSet.getDNACompoundSet();

    public DNASequence parseSequence() throws Exception {
        DNASequence brca2Dna;
        InputStream cdsIs = new ClasspathResource(
                "org/biojava3/core/sequence/BRCA2-cds.fasta").getInputStream();

        try {
            FastaReader<DNASequence, NucleotideCompound> dnaReader = new FastaReader<DNASequence, NucleotideCompound>(cdsIs,
                    new GenericFastaHeaderParser<DNASequence, NucleotideCompound>(), new DNASequenceCreator(dnaCs));
            brca2Dna = dnaReader.process().values().iterator().next();
        }
        finally {
            IOUtils.close(cdsIs);
        }
        return brca2Dna;
    }

    public void translateBrca2() throws Exception {
        DNASequence brca2Dna = parseSequence();
        
        long time = System.currentTimeMillis();
        TranscriptionEngine e = TranscriptionEngine.getDefault();
        RNAToAminoAcidTranslator t = e.getRnaAminoAcidTranslator();
        for (int i = 0; i < iterations; i++) {
            RNASequence rna = brca2Dna.getRNASequence();
            Sequence<AminoAcidCompound> peptide = t.createSequence(rna);
        }
        long took = System.currentTimeMillis();
        long duration = (took-time);
        double perTrans = ((double)duration / (double)iterations);
        System.out.println(duration+" milliseconds");
        System.out.println(perTrans+" milliseconds per translation");
    }
}
