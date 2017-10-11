/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package javaa.clike;

import java.util.HashMap;
import java.util.Map;
import org.biojava.nbio.core.sequence.compound.AminoAcidCompound;
import org.biojava.nbio.core.sequence.compound.NucleotideCompound;
import org.biojava.nbio.core.sequence.template.CompoundSet;
import org.biojava.nbio.core.sequence.template.Sequence;
import org.biojava.nbio.core.sequence.transcription.Table;

/**
 *
 * @author ayates
 */
public class CTranslator {

    private Table table;
    private CompoundSet<NucleotideCompound> rnaCompoundSet;
    private CompoundSet<AminoAcidCompound> aminoAcidCompoundSet;
    private String[] codonArray = new String[500];

    public CTranslator(Table table, CompoundSet<NucleotideCompound> rnaCompoundSet, CompoundSet<AminoAcidCompound> aminoAcidCompoundSet) {
        this.table = table;
        this.rnaCompoundSet = rnaCompoundSet;
        this.aminoAcidCompoundSet = aminoAcidCompoundSet;
        populateCodonArray();
    }

    public StringBuilder getProtein(Sequence<NucleotideCompound> dna) {
        String dnaString = dna.getSequenceAsString();
        return getProtein(dnaString);
    }

    public StringBuilder getProtein(CharSequence dna) {
        StringBuilder peptide = new StringBuilder();
        int length = dna.length();
        for (int i = 0; i < length - 3; i = i + 3) {
            int index = getIndex(dna.charAt(i), dna.charAt(i + 1),
                    dna.charAt(i + 2));
            String aminoAcid = codonArray[index];
            peptide.append(aminoAcid);
        }
        return peptide;
    }

    private void populateCodonArray() {
        for (Table.Codon c : table.getCodons(rnaCompoundSet, aminoAcidCompoundSet)) {
            int index = getIndex(c.getTriplet());
            String base = c.getAminoAcid().getBase();
            codonArray[index] = base;
        }
    }

    private int getIndex(Table.CaseInsensitiveTriplet key) {
        char v1 = key.getOne().getBase().charAt(0);
        char v2 = key.getTwo().getBase().charAt(0);
        char v3 = key.getThree().getBase().charAt(0);
        return getIndex(v1, v2, v3);
    }

    private int getIndex(String codon) {
        return getIndex(codon.charAt(0), codon.charAt(1), codon.charAt(2));
    }

    private int getIndex(char v1, char v2, char v3) {
        int index = 0;

        if (v1 == 'A' || v1 == 'a') {
            index += 100;
        }
        else if (v1 == 'T' || v1 == 't' || v1 == 'U'|| v1 == 'u') {
            index += 200;
        }
        else if (v1 == 'C' || v1 == 'c') {
            index += 300;
        }
        else if (v1 == 'G' || v1 == 'g') {
            index += 400;
        }

        if (v2 == 'A' || v2 == 'a') {
            index += 10;
        }
        else if (v2 == 'T' || v2 == 't' || v2 == 'U'|| v2 == 'u') {
            index += 20;
        }
        else if (v2 == 'C' || v2 == 'c') {
            index += 30;
        }
        else if (v2 == 'G' || v2 == 'g') {
            index += 40;
        }

        if (v3 == 'A' || v3 == 'a') {
            index += 1;
        }
        else if (v3 == 'T' || v3 == 't' || v3 == 'U'|| v3 == 'u') {
            index += 2;
        }
        else if (v3 == 'C' || v3 == 'c') {
            index += 3;
        }
        else if (v3 == 'G' || v3 == 'g') {
            index += 4;
        }

        return index;
    }

}
