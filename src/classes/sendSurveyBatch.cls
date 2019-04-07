/* Description : A BATCH CLASS which will send out survey email if the survey date is before now and also will clear out survey date from suceeded records
   Created By : N26 case study team
   Created On : 4/6/2019    
   Test Coverage : 89%       */
global class sendSurveyBatch implements Database.Batchable<sObject> {
    global Database.queryLocator start(Database.BatchableContext bc){
        Date nowDate = system.today();
        String query = 'Select id, Name,Email,FirstName,Languages__c from Contact where survey_date__c < :nowDate';
        return Database.getQueryLocator(query); 
    }
    
    global void execute (Database.BatchableContext BC, List<Contact> conList){
        Map<Id,Contact> conMap = new Map<Id,Contact>();
        List<Id> conId = new List<Id>();
        EmailTemplate et=new EmailTemplate();
        List<Messaging.SingleEmailMessage> msgListToBeSend = new List<Messaging.SingleEmailMessage>();
        try {
            //getting visualforce email template
            et = [SELECT id,HtmlValue FROM EmailTemplate WHERE developerName = 'Send_out_survey'];            
            for(Contact con:conList){                
                // creating map
                conMap.put(con.id,con);                
                //invoking singleEmailMessage
                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage(); 
                mail.setTemplateId(et.id);
                mail.setTargetObjectId(con.id);
                msgListToBeSend.add(mail);
            }
            
            // this will prevent limit from being hit and will throw system exception
            Messaging.reserveSingleEmailCapacity(msgListToBeSend.size());
            Messaging.SendEmailResult [] r = Messaging.sendEmail(msgListToBeSend);
            
            //evaluating the errors
            for(Messaging.SendEmailResult rr:r){
                if(!rr.IsSuccess())
                {
                    Messaging.SendEmailError[] errArr = rr.getErrors(); 
                    if(conMap.containsKey(Id.valueOf(errArr[0].getTargetObjectId()))){
                        
                        //if the contact id exists in the error array, delete it from map
                        conMap.remove(Id.valueOf(errArr[0].getTargetObjectId()));
                    }
                }
            }
            
            //this map will only have contacts with email status = succeeded hence making survey date null
            for(Contact cc :conMap.Values()){
                    cc.survey_date__c = null;                        
                }
            
            //updating the contact records
            Database.update(conMap.values());
        } 
        catch (Exception e) {
            // hold will come here if Email limit is hit            
        }
        
        
    }
    
    global void finish(Database.BatchableContext BC){      
        
    }
    
}