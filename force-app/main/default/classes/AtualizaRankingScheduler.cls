public class AtualizaRankingScheduler implements Schedulable{

    public Integer minutes;
    public Boolean runOnlyOnce;
    
    public AtualizaRankingScheduler(){
        this.minutes = 60; //default value - it runs every hour
        this.runOnlyOnce = false;
    }

    public AtualizaRankingScheduler(Integer minutes, Boolean runOnlyOnce){
        this.minutes = minutes;
        this.runOnlyOnce = runOnlyOnce;
    }
    
    public void reeschedule() {
        Datetime nextMinute = System.now().addMinutes(minutes);

        Integer year = nextMinute.year();
        Integer month = nextMinute.month();
        Integer day = nextMinute.day();
        Integer hour = nextMinute.hour();
        Integer min = nextMinute.minute(); 
        Integer ss = nextMinute.second();
        
        //parse to cron expression
        String nextFireTime = ss + ' ' + min + ' ' + hour + ' ' + day + ' ' + month + ' ? ' + year;
        
        AtualizaRankingScheduler scheduler = new AtualizaRankingScheduler(minutes, runOnlyOnce); 
        
        String jobId = '';
        
        if(runOnlyOnce){
            System.schedule('AtualizaRankingScheduler - Started: ' + String.valueOf(Datetime.now()), nextFireTime, scheduler);
        }else{
			System.schedule('AtualizaRankingScheduler AUTOMATIC - it runs every '+minutes+' minute(s)', nextFireTime, scheduler);            
        }
    }
    
    public void execute(SchedulableContext sc) {
       // Abort the current job
       Id jobId = sc.getTriggerId(); 
         
       //runOnlyOnce => true = executa uma vez
       //runOnlyOnce => false = reagenda a próxima execução
        
       if(!runOnlyOnce){
          System.abortJob(jobId); 
       	  reeschedule(); 
       } 
        
       run();
    }
    
    public void run(){
       AtualizaRankingBatchable ranking = new AtualizaRankingBatchable();
       Database.executeBatch(ranking); 
       Id batchId = Database.executeBatch(ranking, 10); 
       system.debug('BATCH ID : ' + batchId) ;
    }
    
    public static void startJob(Integer minutes, Boolean runOnlyOnce){
       new AtualizaRankingScheduler(minutes, runOnlyOnce).reeschedule();
    }
}