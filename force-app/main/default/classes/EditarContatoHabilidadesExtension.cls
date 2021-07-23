public with sharing class EditarContatoHabilidadesExtension {

    private Contact contato;
    public List<Habilidadecontato__c> habilidades {get; private set;}

    public EditarContatoHabilidadesExtension(ApexPages.StandardController controller) {
        this.contato = (Contact) controller.getRecord();
        this.habilidades = [select id, habilidade__r.name, level__c from Habilidadecontato__c where contato__c = :this.contato.Id];
    }

    public PageReference cancelar(){
        PageReference pg = new PageReference('/'+this.contato.Id);
        pg.setRedirect(true);
        return pg;
    }

    public void salvar(){
        try {
            update this.contato;
            update this.habilidades;

            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.CONFIRM, 'Salvo !!!'));
        }
        catch(Exception e){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, e.getMessage()));
            system.debug('Error: '+e.getMessage());
        }
    }

    public PageReference seeHeroDetails(){
        //https://www.marvel.com/characters/{{first hero name}}-{{last hero name}}-{{name}}-{{lastname}}
        List<String> heroName = contato.NomeGuerra__c.split(' ');
        PageReference pg = new PageReference('https://www.marvel.com/characters/'+heroName.get(0)+'-'+heroName.get(1)+'-'+contato.firstName.toLowerCase()+'-'+contato.lastName.toLowerCase());
        pg.setRedirect(true);
        return pg;

        //System.debug('Nome de guerra: '+contato.NomeGuerra__c);
    }
}
