@RestResource(urlMapping='/Contracts/*')

global with sharing class ContractAPI{
    
    @HttpPost
    global static Contract createContract(Id accountId, Date startDate, Integer contractTerm){
        //Account acc = new Account (Name ='Test Account');
        Contract ctrt = new Contract(AccountId = accountId,Status ='Draft', StartDate = startDate, ContractTerm = contractTerm);
        insert ctrt;
        return ctrt;
    }
    
    @HttpPut
    global static Contract updateContract ( Date startDate, Integer contractTerm, String status){
        RestRequest req = RestContext.request;
        //RestResponse res = RestContext.response;
        String contractId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        Contract result = [SELECT Id,Status,StartDate,ContractTerm FROM Contract WHERE Id = :contractId];
        //result.BillingAddress = billingAddress;
        result.StartDate = startDate;
        result.ContractTerm = contractTerm;
        result.Status = status;
        update result;
        return result;
    }
    
    @HttpGet
    global static Contract getContractInfo(){
        RestRequest req = RestContext.request;
        String contractId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        Contract contract = [SELECT Id, SpecialTerms FROM Contract WHERE Id =:contractId];
        return contract;
    }
}