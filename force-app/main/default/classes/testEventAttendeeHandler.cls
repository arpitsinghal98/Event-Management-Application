@isTest(SeeAllData=true)
public with sharing class testEventAttendeeHandler {
    
    @isTest
    static void testEventAttendeeHandler(){
        
        List<Attendee__c> attendee =  testGenericData.createAttendee(2);
        insert attendee;

        List<Event_Organizer__c> eventOrganizer = testGenericData.createEventOrganizer(2);
        insert eventOrganizer;

        List<Event__c> event = testGenericData.createEvent(2, eventOrganizer);
        insert event;

        List<Event_Attendee__c> eventAttendee = testGenericData.createEventAttendee(2, attendee, event);
        insert eventAttendee;
    }
}
