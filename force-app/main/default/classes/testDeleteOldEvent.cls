@isTest
public with sharing class testDeleteOldEvent {

    @isTest
    static void testDeleteOldEvent() {

        List<Event_Organizer__c> eventOrganizer = testGenericData.createEventOrganizer(1);
        insert eventOrganizer;

        List<Event__c> event = testGenericData.createEvent(1, eventOrganizer);
        insert event;
        
        Event__c updateEvent = [SELECT Id, Name, Live__c, End_Date_Time__c from Event__c WHERE Id =: event[0].Id];
        updateEvent.Live__c = TRUE;
        updateEvent.Start_Date_Time__c = System.now().addDays(-80);
        updateEvent.End_Date_Time__c = System.now().addDays(-70);
        update updateEvent;

        Test.startTest();

        deleteOldEvents doe = new deleteOldEvents();
        System.schedule('deleteOldEvents', '0 0 23 * * ?', doe);

        Test.stopTest();
    }
}
