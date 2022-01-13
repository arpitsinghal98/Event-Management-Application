@isTest(SeeAllData=true)
public with sharing class testEventAttendeeHandler {
    
    @isTest
    static void testEventAttendeeHandler(){
        
        List<Attendee__c> attendee =  testGenericData.createAttendee(50);
        insert attendee;

        List<Event_Organizer__c> eventOrganizer = testGenericData.createEventOrganizer(50);
        insert eventOrganizer;

        List<Event__c> event = testGenericData.createEvent(50, eventOrganizer);
        insert event;

        List<Event_Attendee__c> eventAttendee = testGenericData.createEventAttendee(50, attendee, event);
        insert eventAttendee;
    }
}
