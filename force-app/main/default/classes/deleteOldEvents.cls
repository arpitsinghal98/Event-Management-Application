global class deleteOldEvents implements Database.Batchable<SObject>, Schedulable, Database.Stateful {

    List<String> eventName = new List<String>();
    global Database.QueryLocator start (Database.BatchableContext bc) {

        return Database.getQueryLocator([SELECT Id, Name, Live__c, End_Date_Time__c from Event__c]);
    }

    global void execute (Database.BatchableContext bc, List<Event__c> event) {

        List<Event__c> deleteEvents = eventHandler.deleteOldEventsExecute(event);
        
        for (Event__c finishEvents: deleteEvents) {
            eventName.add(finishEvents.Name);
        }
        delete deleteEvents;
    }

    global void finish (Database.BatchableContext bc) {

        eventHandler.deleteOldEventsFinish(eventName);
    }

    global void execute(SchedulableContext sc) {

        deleteOldEvents doe = new deleteOldEvents();
        Database.executeBatch(doe);
    }
}