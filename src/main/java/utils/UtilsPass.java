package utils;

import de.mkammerer.argon2.Argon2;
import de.mkammerer.argon2.Argon2Factory;
import persistencia.Persistencia;

import java.util.Properties;

public class UtilsPass {
    private static final Argon2 argon2 = Argon2Factory.create();

    public static String hash(String password) {
        Properties pro = Persistencia.iniciaProperties();
        int iterador = Integer.parseInt(pro.getProperty("iteHash"));
        int memo = Integer.parseInt(pro.getProperty("memoHash"));
        int para = Integer.parseInt(pro.getProperty("paraHash"));
        /*Yo estas variables las tengo guardadas en el properties pero las variables son;
        * iterador = 3
        * memo = 65536
        * para = 1
        * Estos valores son para configurar el hash que realizas y se supone que son los más seguros*/
        return argon2.hash(iterador, memo, para, password.toCharArray());
    }

    public static boolean verify(String hash, String password) {
        return argon2.verify(hash, password.toCharArray());
    }
}
