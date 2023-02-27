@RestResource(urlMapping='/Products/*')

global with sharing class ProductAPI {
    
    @HttpGet
    global static Product2 productViewing (){
        RestRequest req = RestContext.request;
        String productId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        Product2 product = [SELECT Id, Name, Family, ProductCode, Description FROM Product2 WHERE Id =:productId];
        return product;
		
    }
}