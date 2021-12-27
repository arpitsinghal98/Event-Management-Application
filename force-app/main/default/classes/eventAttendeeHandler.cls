public with sharing class eventAttendeeHandler {
    
    public static void eventAttendee(List<Event_Attendee__c> ea) {

        //Step-1: Run SOQL on the list of Event-Attendee received to fetch the required data
        List<Event_Attendee__c> eventAttendees = [SELECT Id, Attendee_Name__c, Event_Location__c, Event_Name__c, Attendee__r.Email__c, Event_Organizer_Name__c, Event_Start_Date_Time__c
                                                FROM Event_Attendee__c WHERE Id IN: ea];

        //Step-2: Initiate te the Send Email Process
        List<Messaging.SingleEmailMessage> mail = new List<Messaging.SingleEmailMessage>();

        OrgWideEmailAddress owa = [SELECT Id, DisplayName, Address from OrgWideEmailAddress LIMIT 1];
        //Step 2.1: Initialize a Contact to use in targetObjectId in Send Email Method
        Contact c = [SELECT id, Email from Contact where email <> NULL LIMIT 1];
        for(Event_Attendee__c eAttendee: eventAttendees) {

            Messaging.SingleEmailMessage emails = new Messaging.SingleEmailMessage();
            String[] emailAddress = new String[0];
            emailAddress.add(eAttendee.Attendee__r.Email__c);
            emails.setToAddresses(emailAddress);                
            emails.setOrgWideEmailAddressId(owa.Id);
            emails.setTemplateId('00X5j000001ik65EAA');
            emails.setWhatId(eAttendee.Id); //WhatId Contains the record id on which action is performed
            emails.settargetobjectid(c.Id); //targetobjectid is mandatory is we are using whatID and should be only on Contact Object Record
            emails.setTreatTargetObjectAsRecipient(false); //preventing the email sent to contact
            mail.add(emails);
        }
        
        //Step-3: check if SingleEmailMessage List is not Empty and then send the required emails
        if(!mail.isEmpty()) {

            Messaging.sendEmail(mail);
        }
    }
}