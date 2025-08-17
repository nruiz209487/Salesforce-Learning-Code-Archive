public with sharing class ContactController {
    @AuraEnabled(cacheable=true)
    //    throw new AuraHandledException('Forced error for testing');
    public static List<Contact> getContacts() {
        return [
            SELECT Id, FirstName, LastName, Email
            FROM Contact
            WITH SECURITY_ENFORCED
            ORDER BY LastName
        ];
    }
}
