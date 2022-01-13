trigger Location_Trigger on Location__c (after insert) {

    List<Id> locationId = new List<Id>();

    for(Location__c recordId: Trigger.New) {

        locationId.add(recordId.Id);
        //locationTriggerHandler.verifyAddress(recordId.Id);
    }
    locationTriggerHandler.verifyAddress(locationId);
}