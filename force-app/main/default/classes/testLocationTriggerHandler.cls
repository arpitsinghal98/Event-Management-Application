@isTest
public with sharing class testLocationTriggerHandler {

    @isTest
    static void testLocationTriggerHandler() {

        List<Location__c> location = testGenericData.createLocation(2);
        insert location;
    }
}