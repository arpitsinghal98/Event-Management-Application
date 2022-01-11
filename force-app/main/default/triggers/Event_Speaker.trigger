trigger Event_Speaker on Event_Speaker__c (before insert, before update) {
    
    eventSpeakerHandler.eventSpeakerHandler(Trigger.New);
    System.debug('Arpit Trigger');
}