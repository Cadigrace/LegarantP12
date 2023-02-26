trigger OrderDeletion on Order (after delete) {
    
	for (Order od : Trigger.old){
        OrderService.checkOrderDeletion(od);

    }

}