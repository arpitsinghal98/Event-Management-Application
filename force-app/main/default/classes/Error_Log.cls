public with sharing class Error_Log {

    public static void Error_Log(System.Exception ex, String Name) {

        Error_Log__c el = new Error_Log__c();
        el.Name = Name;
        el.Log_Details__c = ex.getStackTraceString();
        el.Log_Date_Time__c = System.now();

        insert el;
    }
}