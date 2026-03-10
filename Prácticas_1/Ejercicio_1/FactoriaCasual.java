public class FactoriaCasual implements FactoriaPartidayJugador{
    @Override
    public Partida crearPartida(){
        return new PartidaCasual();
    }

    @Override
    public Jugador crearJugador(int id){
        return new JugadorCasual(id);
    }
}

class JugadorCasual extends Jugador{
    public JugadorCasual(int id){
        super(id);
    }
}

class PartidaCasual extends Partida{
    @Override
    protected void simularAbandonos(){
        int abandonos = (int) (jugadores.size() * 0.10);
        for(int i = 0; i < abandonos; i++){
            if(!jugadores.isEmpty()){
                jugadores.remove(jugadores.size() - 1);
            }
        }
        System.out.println(" [Partida casual] " + abandonos + " jugadores han abandonado la partida");
    }
}