/* Description : A SCHEDULE CLASS required to schedule the run of JN_SendSurvey at 9:00 AM everyday
Created By : N26 case study team
Created On : 4/7/2019   
Test Coverage : 100%      */
global class scheduleBatchClass implements Schedulable {
    public static String sched = '0 00 09 * * ?';  //Every Day at 9 AM 
    
    //method to instantiate Schedule class
    global static String scheduleMe() {
        scheduleBatchClass SC = new scheduleBatchClass(); 
        return System.schedule('My batch Job', sched, SC);
    }
    
    //implementing interface method
    global void execute(SchedulableContext sc) {
        sendSurveyBatch b1 = new sendSurveyBatch();
        ID batchprocessid = Database.executeBatch(b1,200);           
    }
    
    
}