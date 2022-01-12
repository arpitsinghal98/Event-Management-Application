@isTest
public with sharing class testGenericData {

    public static List<Attendee__c> createAttendee(Integer n) {
        
        List<Attendee__c> testAttendee = new List<Attendee__c>();

        for(Integer i=0; i<n; i++) {

            Attendee__c attendee = new Attendee__c();
            attendee.Name = 'Attendee: '+i;
            attendee.Email__c = 'attendee'+i+'@attendee.com';
            attendee.Phone__c = '987654321'+i;
            testAttendee.add(attendee);
        }
        return testAttendee;
    }

    public static List<Speaker__c> createSpeaker(Integer n) {
        
        List<Speaker__c> testSpeaker = new List<Speaker__c>();

        for(Integer i=0; i<n; i++) {

            Speaker__c speaker = new Speaker__c();
            speaker.Name = 'Speaker: '+i;
            speaker.Email__c = 'speaker'+i+'@speaker.com';
            speaker.Phone__c = '987654321'+i;
            testSpeaker.add(speaker);
        }
        return testSpeaker;
    }

    public static List<Event_Organizer__c> createEventOrganizer(Integer n) {
        
        List<Event_Organizer__c> testEventOrganizer = new List<Event_Organizer__c>();

        for(Integer i=0; i<n; i++) {

            Event_Organizer__c eventOrganizer = new Event_Organizer__c();
            eventOrganizer.Name = 'EventOrganizer: '+i;
            eventOrganizer.Email__c = 'eventorganizer'+i+'@eventOrganizer.com';
            eventOrganizer.Phone__c = '987654321'+i;
            testEventOrganizer.add(eventOrganizer);
        }
        return testEventOrganizer;
    }

    public static List<Event__c> createEvent(Integer n, List<Event_Organizer__c> eventOrganizer) {
        
        List<Event__c> testEvent = new List<Event__c>();

        for(Integer i=0; i<n; i++) {

            Event__c event = new Event__c();
            event.Name = 'Event: '+i;
            if(eventOrganizer.size() !=1) {
                event.Event_Organizer__c = eventOrganizer[i].Id;
            }
            else {
                event.Event_Organizer__c = eventOrganizer[0].Id;
            }
            event.Start_Date_Time__c = System.now().addDays(i);
            event.End_Date_Time__c = System.now().addDays(i+7);
            event.Max_Seats__c = 40;
            event.Live__c = TRUE;
            event.Event_Type__c = 'Virtual';
            testEvent.add(event);
        }
        return testEvent;
    }

    public static List<Event_Attendee__c> createEventAttendee(Integer n, List<Attendee__c> attendee, List<Event__c> event) {
        
        List<Event_Attendee__c> testEventAttendee = new List<Event_Attendee__c>();

        for(Integer i=0; i<n; i++) {

            Event_Attendee__c eventAttendee = new Event_Attendee__c();
            eventAttendee.Name = 'EventAttendee: '+i;
            if(attendee.size() !=1) {
                eventAttendee.Attendee__c = attendee[i].Id;
            }
            else {
                eventAttendee.Attendee__c = attendee[0].Id;
            }
            if(event.size() !=1) {
                eventAttendee.Event__c = event[i].Id;
            }
            else {
                eventAttendee.Event__c = event[0].Id;
            }
            testEventAttendee.add(eventAttendee);
        }
        return testEventAttendee;
    }

    public static List<Event_Speaker__c> createEventSpeaker(Integer n, List<Speaker__c> speaker, List<Event__c> event) {
        
        List<Event_Speaker__c> testEventSpeaker = new List<Event_Speaker__c>();

        for(Integer i=0; i<n; i++) {

            Event_Speaker__c eventSpeaker = new Event_Speaker__c();
            eventSpeaker.Name = 'EventSpeaker: '+i;
            if(speaker.size() !=1) {
                eventSpeaker.Speaker__c = speaker[i].Id;
            }
            else {
                eventSpeaker.Speaker__c = speaker[0].Id;
            }
            if(event.size() !=1) {
                eventSpeaker.Event__c = event[i].Id;
            }
            else {
                eventSpeaker.Event__c = event[0].Id;
            }
            testEventSpeaker.add(eventSpeaker);
        }
        return testEventSpeaker;
    }
}