public class Heroi extends Contato{
	
    public String habilidade;
    public String nomeHeroi;
    
    public Heroi(String habilidade, String nomeHeroi){
        super(nomeHeroi + ' Bonzinho', nomeHeroi + '@heroi.com');
        this.habilidade = habilidade;
        this.nomeHeroi = nomeHeroi;
    }
}