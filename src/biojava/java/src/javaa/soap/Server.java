/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package javaa.soap;

import javax.xml.ws.Endpoint;

/**
 *
 * @author ayates
 */
public class Server {

    public static void main(String[] args) {
        int port = 9090;
        if(args.length > 0) {
            port = Integer.valueOf(args[0]);
        }
        Endpoint.publish(
         "http://localhost:"+port+"/translator",
         new SoapTranslator());
    }

}
