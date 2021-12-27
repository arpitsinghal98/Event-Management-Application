trigger Event_Speaker on Event_Speaker__c (before insert, before update) {
    
    //Step-1: Getting All Records Being Inserted/Updated
    List<Event_Speaker__c> espeaker = new List<Event_Speaker__c>(Trigger.New);
    
    //Step-2: Add All Speaker Id(s) for the New Records Being Inserted/Updated in a Set to prevent Duplicates
    Set<Id> newEventSpeaker = new Set<Id>();
    for(Event_Speaker__c eventSpeakers: espeaker) {

        newEventSpeaker.add(eventSpeakers.Speaker__c);
    }
    //Step-3: Querying Existing Record Based on Live Event and Speaker used in New Records
    List<Event_Speaker__c> existingEventSpeakers = [SELECT Id, Event__r.Live__c, Event__r.End_Date_Time__c, Event__r.Start_Date_Time__c, Speaker__c from Event_Speaker__c 
                                                where Speaker__c IN: newEventSpeaker ORDER BY Event__r.End_Date_Time__c DESC LIMIT 49999];

    //Step-4: Adding the Id of Speakers present in Existing Event Speaker Records
    Set<Id> existingEventSpeakersId = new Set<Id>();
    for(Event_Speaker__c tempEventSpeaker: existingEventSpeakers) {

        existingEventSpeakersId.add(tempEventSpeaker.Speaker__c);
    }

    //Step-5: Checking for Duplicates and throwing Error
    for(Event_Speaker__c duplicateEventSpeaker : espeaker) {

        if(existingEventSpeakersId.contains(duplicateEventSpeaker.Speaker__c)) {
            
            duplicateEventSpeaker.addError('Speaker already have a Live Event');
        }
    }
}