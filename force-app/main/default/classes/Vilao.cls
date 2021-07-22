public class Vilao extends Contato {
	
    private String nomeGuerra;
    private String habilidades;
    
    public Vilao(String nomeGuerra, String habilidades){
        super(nomeGuerra + ' Malvadão', nomeGuerra + '@email.com');
        this.nomeGuerra = nomeGuerra;
        this.habilidades = habilidades;
    }
}