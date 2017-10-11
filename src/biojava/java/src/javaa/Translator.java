/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package javaa;

import org.biojava.nbio.core.exceptions.CompoundNotFoundException;
import org.biojava.nbio.core.sequence.DNASequence;
import org.biojava.nbio.core.sequence.ProteinSequence;
import org.biojava.nbio.core.sequence.RNASequence;
import org.biojava.nbio.core.sequence.transcription.TranscriptionEngine;

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
        try {
            return translate(new DNASequence(dnaString));
        }
        catch(CompoundNotFoundException e) {
            throw new RuntimeException("Cannot translate DNA sequence due to unknown compound error", e);
        }
    }

}
