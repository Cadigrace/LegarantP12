({
  changeStatus : function(component, event, helper) {
      console.log('init');
      
    var action = component.get('c.getLead');
      action.setParams({"leadId":component.get("v.recordId")});
      
      action.setCallback(this, function(response){
          var state = response.getState();      
          //alert('state ' + state);
          if(state == "SUCCESS"){
              var lead = response.getReturnValue();
              console.log('v.lead', lead);
              lead.Status = 'Working - Contacted'
              var saveAction = component.get('c.saveLead');
          saveAction.setParams({"lead": lead});
              
              saveAction.setCallback(this, function(resp){
                  $A.get("e.force:refreshView").fire();
                  $A.get("e.force:closeQuickAction").fire();
          });
          $A.enqueueAction(saveAction);
          }
      });
      $A.enqueueAction(action);
  }, 
  accept : function(component, event, helper) {
      $A.get("e.force:closeQuickAction").fire();
  }
})