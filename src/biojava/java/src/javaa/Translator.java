/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package javaa;

import org.biojava3.core.sequence.DNASequence;
import org.biojava3.core.sequence.ProteinSequence;
import org.biojava3.core.sequence.RNASequence;
import org.biojava3.core.sequence.transcription.TranscriptionEngine;

/**
 * Contains the logic for translation so all implementations will use the
 * same
 *
 * @author ayates
 */
public class Translator {

    private final TranscriptionEngine e =
                new TranscriptionEngine.Builder().decorateRna(true).build();

    public ProteinSequence translate(DNASequence dna) {
        RNASequence r = dna.getRNASequence(e);
        return r.getProteinSequence(e);
    }

    public ProteinSequence translate(String dnaString) {
        return translate(new DNASequence(dnaString));
    }

}
