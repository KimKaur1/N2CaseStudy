({
    doInit : function(component, event, helper) {
        helper.doInitialLoad(component);
        
    },
    navigateToSObject :function(component, event, helper) {
        helper.navigateToRelatedProduct(component);
    }
})