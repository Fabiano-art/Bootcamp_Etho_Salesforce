public class ContactTriggerHelper {
	
    public static void noDeleteTask(List<Contact> oldRecords, Map<id, Contact> mapOld){
        List<Task> tarefas = [SELECT id, status, whoid from task where whoId = :oldRecords and status != 'completed'];
        
        for (Task tar : tarefas){
            mapOld.get(tar.whoid).addError('Não é possivel deletar um heroi com tarefas em aberto');
        }
    }
    
    public static void formataCelular(List<Contact> newRecords, Map<id, Contact> mapOld){
        Pattern myPattern = Pattern.compile('!REGEX(Phone,"^((\\+\\d{2}\\s)?\\(\\d{2}\\)\\s?\\d{4}\\d?\\-\\d{4})?$")');
        List<Contact> contatos = new List<Contact>();
        
        for (Contact contato : newRecords){
            Matcher MyMatcher = MyPattern.matcher(contato.MobilePhone);
            if(MyMatcher.matches()){
                continue;
            }
            Contact cont = contato;
            String numContato = contato.MobilePhone;
            
            String doisPrimeiros = numContato.substring(0, 2);
            
            // 11 912345678
           	String formatted = '('+doisPrimeiros+') '+numContato.substring(2, 7)+'-'+numContato.substring(7, 11);
            contato.MobilePhone = formatted;
        }
    }
}