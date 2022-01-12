public with sharing class eventHandler {

    public static List<Event__c> deleteOldEventsExecute(List<Event__c> event) {

        List<Event__c> eventToDelete = new List<Event__c>();
        
        for(Event__c deleteEvent: event) {
            if(deleteEvent.Live__c == true && deleteEvent.End_Date_Time__c <= System.now().addDays(-60)) {

                eventToDelete.add(deleteEvent);
            }
        }
        return eventToDelete;
    }

    public static void deleteOldEventsFinish(List<String> eventName) {

        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        String[] toAddress = new String[0];
        toAddress.add('singhalarpit.jpr@gmail.com');
        mail.setSubject('Delete Old Event Batch Finished');
        mail.setToAddresses(toAddress);

        String body = 'Hi Arpit, <br><br> Delete Old Event Batch Class is Processed and below are the Processed Event Name. <br><br>'+eventName;
        body = body+'<br><br> Thank You, <br> MaxFit';
        mail.setHtmlBody(body);

        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
    }
}