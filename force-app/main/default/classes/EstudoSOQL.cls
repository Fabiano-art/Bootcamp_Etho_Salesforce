public class EstudoSOQL {
	
    public static void getAll(){
        List<Contact> contatos = [select id, Name from Contact];
        
    }
}