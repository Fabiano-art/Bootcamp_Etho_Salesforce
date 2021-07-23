public class ContactTriggerHelper {
	
    public ContactTriggerHelper(){}

    public static void noDeleteTask(List<Contact> oldRecords, Map<id, Contact> mapOld){
        List<Task> tarefas = [SELECT id, status, whoid from task where whoId = :oldRecords and status != 'completed'];
        
        for (Task tar : tarefas){
            mapOld.get(tar.whoid).addError('Não é possivel deletar um heroi com tarefas em aberto');
        }
    }
    
    public void formataCelular(List<Contact> newRecords){
        Map<Id, Contact> mapContatos = new Map<Id, Contact>();
        for(Contact contato : newRecords){
            mapContatos.put(contato.Id, contato);
        }

        Contact actualContact;

        try {            
            for (Contact contato : newRecords){
                actualContact = contato;

                if(Pattern.matches('^\\([1-9]{2}\\)(?:[2-8]|9[1-9])[0-9]{3}\\-[0-9]{4}$', contato.MobilePhone)) {
                    continue;
                    //system.debug('true dentro do if');
                }
                String telefoneAjustado = ajustaString(contato.MobilePhone);

                String doisPrimeiros = telefoneAjustado.substring(0, 2);
                
                // 11 912345678
                String formatted = '('+doisPrimeiros+') '+telefoneAjustado.substring(2, 7)+'-'+telefoneAjustado.substring(7, 11);
                contato.MobilePhone = formatted;
            }
        } 
        catch (System.NullPointerException e) {
            mapContatos.get(actualContact.Id).addError('O campo celular deve ser preenchido corretamente');
        }
        
    }

    private String ajustaString(String str){
        return str.remove('(').remove(')').remove('-').deleteWhitespace();
    }
}