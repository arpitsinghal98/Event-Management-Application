trigger Event_Attendee on Event_Attendee__c (after insert) {

    eventAttendeeHandler.eventAttendee(Trigger.New);

}