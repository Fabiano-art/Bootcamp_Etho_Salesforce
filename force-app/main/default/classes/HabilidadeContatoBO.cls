public class HabilidadeContatoBO {
	private static final HabilidadeContatoBO instance = new HabilidadeContatoBO();
    
    private HabilidadeContatoBO(){
        
    }
    
    public static HabilidadeContatoBO getInstance(){
        return instance;
    }
}