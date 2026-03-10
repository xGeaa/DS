import java.util.ArrayList;

public abstract class Partida implements Runnable {

    protected ArrayList<Jugador> jugadores;

    public Partida() {
        this.jugadores = new ArrayList<>();
    }

    public void agregarJugador(Jugador j){
        this.jugadores.add(j);
    }

    protected abstract void simularAbandonos();

    @Override
    public void run(){ 
        String tipoPartida = this.getClass().getSimpleName();
        System.out.println(" [ " + tipoPartida + " ] Iniciada con: " + jugadores.size() + " jugadores" );

        try {

            Thread.sleep(30000);
            simularAbandonos();
            Thread.sleep(30000);

        } catch (InterruptedException e) {
            System.err.println("La partida " + tipoPartida + " fue interrumpida.");
            Thread.currentThread().interrupt();
        }

        System.out.println(" [ " + tipoPartida + " ] Finalizada. Jugadores restantes " + jugadores.size());
    }
}