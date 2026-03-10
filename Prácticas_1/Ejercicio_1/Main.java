import java.util.Scanner;

public class Main{
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.print("Introduce el número inicial de jugadores (N): ");
        int n = scanner.nextInt();

        FactoriaPartidayJugador factoriaCompetitiva = new FactoriaCompetitiva();
        FactoriaPartidayJugador factoriaCasual = new FactoriaCasual();

        Partida partidaCompetitiva = factoriaCompetitiva.crearPartida();
        Partida partidaCasual = factoriaCasual.crearPartida();

        for (int i = 1; i <= n; i++) {
            partidaCompetitiva.agregarJugador(factoriaCompetitiva.crearJugador(i));
            partidaCasual.agregarJugador(factoriaCasual.crearJugador(i));
        }

        Thread hiloCompetitivo = new Thread(partidaCompetitiva);
        Thread hiloCasual = new Thread(partidaCasual);

        System.out.println("\n--- INICIANDO SIMULACIÓN DE 60 SEGUNDOS ---");

        hiloCompetitivo.start();
        hiloCasual.start();
        
        try {
            hiloCompetitivo.join();
            hiloCasual.join();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }

        System.out.println("--- AMBAS PARTIDAS HAN TERMINADO CORRECTAMENTE ---");
        scanner.close();
    }
}