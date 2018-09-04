global class LeadProcessor implements Database.Batchable<sObject>, Database.Stateful {

    global integer recordsProcessed = 1;
    
    global Database.QueryLocator start(Database.BatchableContext bc){
       return Database.getQueryLocator('SELECT ID, LeadSource from Lead where LeadSource = \'Dreamforce\'');
    }
        
    
    global void execute(Database.BatchableContext bc, List<Lead> scope){
        for(Lead l : scope){      
            l.LeadSource = 'Web';
        }
        update scope;        
    }
          
	global void finish(Database.BatchableContext bc){
     System.debug(recordsProcessed + ' records processed. Shazam!');
        AsyncApexJob job = [SELECT Id, Status, NumberOfErrors,  
            JobItemsProcessed,
            TotalJobItems, CreatedBy.Email
            FROM AsyncApexJob
            WHERE Id = :bc.getJobId()];
        // call some utility to send email
       // EmailUtils.sendMessage(a, recordsProcessed);
    }     
}