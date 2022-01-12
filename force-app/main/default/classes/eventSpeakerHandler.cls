public with sharing class eventSpeakerHandler {
    
    public static void eventSpeakerHandler(List<Event_Speaker__c> newUpdateEventSpeaker) {

        /* Step-1: Add All Speaker Id(s) and Event Id(s) for the New Records Being Inserted/Updated in a Set to prevent Duplicates */
        Set<Id> newSpeaker = new Set<Id>();
        Set<Id> newEvent = new Set<Id>();
        for(Event_Speaker__c eventSpeakers: newUpdateEventSpeaker) {

            newSpeaker.add(eventSpeakers.Speaker__c);
            newEvent.add(eventSpeakers.Event__c);
        }

        /* Step-2: 
        * Creating a Map for storing Id and Event based on Events used in New Records
        * Querying Existing Record Based on Speaker used in New Records in Object Event Speaker */

        Map<Id, Event__c> myAllEventMap = new Map<Id, Event__c> ([SELECT Id, Name, Start_Date_Time__c from Event__c where Id IN: newEvent]);

        List<Event_Speaker__c> existingEventSpeakers = [SELECT Id, Event__r.Live__c, Event__r.End_Date_Time__c, Event__r.Start_Date_Time__c, Speaker__c from Event_Speaker__c 
                                                    where Speaker__c IN: newSpeaker ORDER BY Event__r.End_Date_Time__c DESC LIMIT 49999];

        //Step-3: Checking for Duplicates and throwing Error
        for(Event_Speaker__c newEventSpeaker : newUpdateEventSpeaker) {

            for(Event_Speaker__c duplicateEventSpeaker : existingEventSpeakers) {

                if(newEventSpeaker.Speaker__c == duplicateEventSpeaker.Speaker__c && myAllEventMap.get(newEventSpeaker.Event__c).Start_Date_Time__c <= duplicateEventSpeaker.Event__r.End_Date_Time__c) {

                    newEventSpeaker.addError('Speaker already have a Live Event between: "'+duplicateEventSpeaker.Event__r.Start_Date_Time__c + '" to "'+duplicateEventSpeaker.Event__r.End_Date_Time__c+'"');
                }
            }
        }
    }
}