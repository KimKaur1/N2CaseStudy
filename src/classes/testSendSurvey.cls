/* Description : Test class for sendSurveyBatch
   Created By : N26 case study team
   Created On : 4/7/2019     */

@isTest(SeeAllData=false)
public class testSendSurvey {
   @testSetup
    static void setData(){
        KM_Product__c prod = new KM_Product__c();
        prod.name ='Sample';
        prod.KM_ATM_fee_in_other__c = 1;
        prod.KM_Card_Replacement_Cost__c = 1;
        prod.KM_Country__c='DE';
        insert prod;
        List<Contact> lstAccount= new List<Contact>();
        for(Integer i=0 ;i <2;i++)
        {
            Contact acc = new Contact();
            acc.LastName ='Name'+i;
            acc.survey_date__c = system.today().addDays(-1);
            acc.Languages__c = 'EN';
            acc.Product__c = prod.id;
            acc.Home_Country__c ='DE';
            acc.Email='test@test.com';
            lstAccount.add(acc);
        }
        
        insert lstAccount;
    }
    static testMethod void testMethod1() 
    {
      List<Contact>  conList =[select id,Survey_Date__c,Languages__c from Contact];
        
        
        Test.startTest();

            sendSurveyBatch obj = new sendSurveyBatch();
            DataBase.executeBatch(obj); 
            
        Test.stopTest();
    }
    static testmethod void testNegativeScenario(){
        List<Contact>  conList =[select id,Survey_Date__c,Languages__c from Contact limit 2];
        conList[0].email = '';        
        Test.startTest();
			update conList;
            sendSurveyBatch obj = new sendSurveyBatch();
            DataBase.executeBatch(obj); 
            
        Test.stopTest();
    }
}