package DAO;

import persistencia.Persistencia;

import java.io.*;
import java.nio.file.Path;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.Properties;

public class DAOManager implements Serializable {

    private transient Connection conn;
    private final String URL;
    private final String USER;
    private final String PASS;
    private static DAOManager singlenton; //Atributo estatico que guarda una referencia al DAO

    private DAOManager() { //Constructor privado para que no se pueda llamar las veces que se quiera
        Properties pro = Persistencia.iniciaProperties();
        this.conn = null;
        this.URL = pro.getProperty("URLDB"); //Enlazo la dirección del servidor y de la base de datos a usar
        this.USER = pro.getProperty("UserDB"); //Usuario de la BBDD
        this.PASS = pro.getProperty("PassDB"); //Clave de la BBDD
    }

    public static DAOManager getSinglentonInstance(){ //Metodo que devuelve el DAO, si el atributo estatico ya ha sido
                                                      // inicializado no devuelve nada
        if (singlenton == null) singlenton = new DAOManager();

        return singlenton;
    }

    public Connection getConn() {
        return conn;
    }

    public void open() throws Exception {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver"); //Cargo el driver de conexión jdbc
            conn = DriverManager.getConnection(URL, USER, PASS); //Uso la clase DriverManager para crear la conexión
        } catch (Exception e) {
            throw e;
        }
    }

    public void close() throws SQLException {
        try
        {
            if(this.conn!=null)
                this.conn.close();
        }
        catch(Exception e) { throw e; }
    }

    public File hacerBackup(String rutaDestino) {
        if(rutaDestino.isEmpty()){
            Properties pro = Persistencia.iniciaProperties();
            rutaDestino = pro.getProperty("rutaBackUp");
            rutaDestino = String.valueOf(Path.of(rutaDestino).toAbsolutePath());
            File rutaDestinoBackup = new File(rutaDestino);
            if (!rutaDestinoBackup.exists()) rutaDestinoBackup.mkdirs();
        }
        String nombreBD = obtenerNombreBaseDeDatos(URL);
        String nombreArchivo = "backup_" + LocalDate.now() + ".sql";
        String rutaCompleta = rutaDestino + File.separator + nombreArchivo;

        String comando = String.format("mysqldump -u%s -P 3307 -p%s --databases %s", USER, PASS, nombreBD);

        try {
            ProcessBuilder pb = new ProcessBuilder("cmd.exe", "/c", comando);
            pb.redirectOutput(new File(rutaCompleta));
            Process proceso = pb.start();

            int exitCode = proceso.waitFor();

            return new File(rutaCompleta);

        } catch (Exception e) {

            return null;
        }
    }

    public boolean restaurarBackup(String rutaArchivoSQL) {
        String nombreBD = obtenerNombreBaseDeDatos(URL);

        try {
            ProcessBuilder pb = new ProcessBuilder(
                    "mysql",
                    "-u" + USER,
                    "-h", "127.0.0.1",
                    "-P", "3307",
                    "-p" + PASS,
                    nombreBD
            );

            // Hereda errores para diagnóstico en consola
            pb.redirectErrorStream(true);

            Process proceso = pb.start();

            try (
                    BufferedReader fileReader = new BufferedReader(new FileReader(rutaArchivoSQL));
                    BufferedWriter procesoWriter = new BufferedWriter(new OutputStreamWriter(proceso.getOutputStream()));
                    BufferedReader procesoOutput = new BufferedReader(new InputStreamReader(proceso.getInputStream()))
            ) {
                String linea;
                while ((linea = fileReader.readLine()) != null) {
                    try {
                        procesoWriter.write(linea);
                        procesoWriter.newLine();
                    } catch (IOException ioEx) {
                        System.err.println("Error escribiendo al proceso: " + ioEx.getMessage());
                        break;
                    }
                }

                procesoWriter.flush();
                procesoWriter.close(); // Asegura que MySQL reciba EOF

                // Lee salida del proceso (útil para detectar errores)
                String salida;
                while ((salida = procesoOutput.readLine()) != null) {
                    System.out.println("[mysql] " + salida);
                }

                int exitCode = proceso.waitFor();
                System.out.println("MySQL terminó con código: " + exitCode);

                return exitCode == 0;
            }

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    private String obtenerNombreBaseDeDatos(String url) {
        // Elimina parámetros si existen
        int inicio = url.indexOf("/", url.indexOf("//") + 2) + 1;
        int fin = url.indexOf("?", inicio);
        if (fin == -1) {
            return url.substring(inicio);
        } else {
            return url.substring(inicio, fin);
        }
    }

}


