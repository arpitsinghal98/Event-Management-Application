@isTest
public with sharing class testEventSpeakerHandler {

    @isTest
    static void makeData() {

        List<Speaker__c> speaker = testGenericData.createSpeaker(1);
        insert speaker;

        List<Event_Organizer__c> eventOrganizer = testGenericData.createEventOrganizer(2);
        insert eventOrganizer;

        List<Event__c> event = testGenericData.createEvent(2, eventOrganizer);
        insert event;   
           
        List<Event_Speaker__c> eventSpeaker = testGenericData.createEventSpeaker(2,  speaker, event);
        insert eventSpeaker;
    }
}