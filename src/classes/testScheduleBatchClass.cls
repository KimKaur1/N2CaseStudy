/* Description : Test class for scheduleBatchClass
   Created By : N26 case study team
   Created On : 4/7/2019     */

@isTest(SeeAllData=false)
public class testScheduleBatchClass {
    
    static testmethod void testPositiveScenario(){
        Test.startTest();
        String jobId = scheduleBatchClass.scheduleMe();        
        Test.stopTest();
        
        
    }
}