trigger OrderActivationV2 on Order (before update) {
    
    for (Order o : Trigger.new){
		OrderService.checkOrderActivation(o);
    }
}