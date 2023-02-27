@RestResource(urlMapping='/Contacts/*')

global with sharing class  ContactAPI {
  	@HttpPost
    global static Contact createContact (String firstName, String lastName, String email,String phone){
        List<Contact> contacts = [SELECT Id FROM Contact WHERE Email =:email];
        if (contacts.size()>0){
        	return contacts[0]; 
        }  
        Contact contact = new Contact (FirstName = firstName, LastName = lastName, Email = email, Active__c = true, MobilePhone = phone );
        insert contact;
        return contact;
        
    }
    @HttpPut
    global static Contact updateContact (String firstName, String lastName, String email, String phone){
        RestRequest req = RestContext.request;
        //RestResponse res = RestContext.response;
        String contactId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        Contact result = [SELECT Id, FirstName, LastName, Email FROM Contact WHERE Id = :contactId];
        result.FirstName = firstName;
        result.LastName = lastName;
        result.Email = email;
        result.MobilePhone = phone;
        
        update result;
        return result;
        
    }
    @HttpDelete
    global static Contact deactivateContact() {
       RestRequest req = RestContext.request;
       //RestResponse res = RestContext.response;
       String contactId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
       Contact contact = [SELECT Id FROM Contact WHERE Id = :contactId];
       contact.Active__c = false;
       update contact;
       return contact; 
    }
    
    @HttpGet
    global static Contact getContactInfo(){
		RestRequest req = RestContext.request;
		//RestResponse res = RestContext.response;
		String contactId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        system.debug('hello'+ contactId);
		Contact contact = [SELECT Id, FirstName, LastName, Email,Phone,Fax FROM Contact WHERE Id = :contactId];
    	return contact;
        
    }
    

}