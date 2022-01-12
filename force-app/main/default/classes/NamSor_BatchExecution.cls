global class NamSor_BatchExecution implements Database.Batchable<sObject>, Database.AllowsCallouts, Database.Stateful {
    global Boolean executeAll = false;
    global NamSor_BatchExecution(Boolean executeAllDatabase) {
        executeAll = executeAllDatabase;
    }
    
    global Database.QueryLocator start(Database.BatchableContext bc) {
        if(executeAll) {
            return Database.getQueryLocator([SELECT Id, Name, Namsor_Likely_Gender__c from Contact WHERE Namsor_Likely_Gender__c = null]);
        } else {
            return Database.getQueryLocator([SELECT Id, Name, Namsor_Likely_Gender__c from Contact WHERE Namsor_Likely_Gender__c = null AND CreatedDate = LAST_N_DAYS:2]);
        }
    }

    global void execute(Database.BatchableContext bc, List<Contact> listContacts) {
        NamSor_EnrichContact.execute(listContacts);
    }

    global void finish(Database.BatchableContext bc) {
        System.debug('Finished Namsor Batch Execution');
    }
}
