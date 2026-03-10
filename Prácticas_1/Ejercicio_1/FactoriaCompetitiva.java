public class FactoriaCompetitiva implements FactoriaPartidayJugador{
    @Override
    public Partida crearPartida(){
        return new PartidaCompetitiva();
    }

    @Override
    public Jugador crearJugador(int id){
        return new JugadorCompetitivo(id);
    }
}

class JugadorCompetitivo extends Jugador{
    public JugadorCompetitivo(int id){
        super(id);
    }
}

class PartidaCompetitiva extends Partida{
    @Override
    protected void simularAbandonos(){
        int abandonos = (int) (jugadores.size() * 0.20);
        for(int i = 0; i < abandonos; i++){
            if(!jugadores.isEmpty()){
                jugadores.remove(jugadores.size() - 1);
            }
        }
        System.out.println(" [Partida competitiva] " + abandonos + " jugadores han abandonado la partida");
    }
}