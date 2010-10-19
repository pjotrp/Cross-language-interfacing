/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package javaa.soap;

import javaa.Translator;
import javax.jws.WebMethod;
import javax.jws.WebParam;
import javax.jws.WebService;
import org.biojava3.core.sequence.ProteinSequence;

/**
 *
 * @author ayates
 */

@WebService
public class SoapTranslator {

    private static final boolean VERBOSE = false;

    private final Translator translator = new Translator();

    @WebMethod
    public String translate(@WebParam(name="dna")String inputDna) {
        if(VERBOSE)
            System.out.println("Translating: "+inputDna);
        ProteinSequence protein = translator.translate(inputDna);
        if(VERBOSE)
            System.out.println("Got back: "+protein);
        return protein.toString();
    }
}
