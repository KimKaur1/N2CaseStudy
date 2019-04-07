({
    //init method
    doInitialLoad: function(component, event, helper) {        
        
        //check if the country of contact matches country of Product
        if(!$A.util.isUndefinedOrNull(component.get("v.SobjectRecord.Contact.Home_Country__c")) && !$A.util.isEmpty(component.get("v.SobjectRecord.Contact.Home_Country__c"))&&
           component.get("v.SobjectRecord.Contact.Home_Country__c") == component.get("v.SobjectRecord.Contact.Product__r.KM_Country__c"))
        {
            component.set('v.finalCaseRecord',component.get("v.SobjectRecord"));
            
            //logic to remove extra 2 zeroes on percentage fields
            var percentval =(component.get('v.finalCaseRecord.Contact.Product__r.KM_ATM_fee_in_other__c')/100);
            component.set('v.percentValue',percentval);
            
            component.set("v.noProductError",false);
        }
        else{
            component.set("v.noProductError",true);
        }
        
        
    },
    // method to navigate to Product record from hyperlink on Name
    navigateToRelatedProduct : function(component,event,helper){
        var productId = component.get('v.finalCaseRecord.Contact.Product__c');
        var navEvent = $A.get("e.force:navigateToSObject");
        if(navEvent){
            navEvent.setParams({
                recordId: productId,
                slideDevName: "detail"
            });
            navEvent.fire(); 
        }
        
        
    }
})