@isTest
private class TestRestrictContactByName {
    
    @isTest 
    static void testInsertSingleInvalidContact() {
        Contact c = new Contact(LastName='INVALIDNAME');
        Test.startTest();
        try {
            insert c;
            System.assert(false, 'Insert should have failed for INVALIDNAME');
        } catch (DmlException e) {
            System.assert(e.getMessage().contains('INVALIDNAME'), 'Error message should contain INVALIDNAME');
            System.assert(e.getMessage().contains('not allowed for DML'), 'Error message should contain expected text');
        }
        Test.stopTest();
    }
    
    @isTest
    static void testInsertSingleValidContact() {
        Contact c = new Contact(LastName='ValidName');
        Test.startTest();
        insert c;
        Test.stopTest();
        System.assertNotEquals(null, c.Id, 'Valid contact should have been inserted');
    }
    
    @isTest
    static void testUpdateSingleInvalidContact() {
        // First insert a valid contact
        Contact c = new Contact(LastName='ValidName');
        insert c;
        
        // Then try to update to invalid name
        c.LastName = 'INVALIDNAME';
        Test.startTest();
        try {
            update c;
            System.assert(false, 'Update should have failed for INVALIDNAME');
        } catch (DmlException e) {
            System.assert(e.getMessage().contains('INVALIDNAME'), 'Error message should contain INVALIDNAME');
            System.assert(e.getMessage().contains('not allowed for DML'), 'Error message should contain expected text');
        }
        Test.stopTest();
    }
    
    @isTest
    static void testUpdateSingleValidContact() {
        Contact c = new Contact(LastName='OriginalName');
        insert c;
        
        c.LastName = 'UpdatedValidName';
        Test.startTest();
        update c;
        Test.stopTest();
        
        Contact updatedContact = [SELECT LastName FROM Contact WHERE Id = :c.Id];
        System.assertEquals('UpdatedValidName', updatedContact.LastName, 'Contact should have been updated');
    }
    
    @isTest
    static void testBulkInsertMixedContacts() {
        List<Contact> contacts = new List<Contact>();
        
        // Add some valid contacts
        contacts.add(new Contact(LastName='ValidName1'));
        contacts.add(new Contact(LastName='ValidName2'));
        
        // Add an invalid contact
        contacts.add(new Contact(LastName='INVALIDNAME'));
        
        // Add more valid contacts
        contacts.add(new Contact(LastName='ValidName3'));
        
        Test.startTest();
        try {
            insert contacts;
            System.assert(false, 'Bulk insert should have failed due to invalid contact');
        } catch (DmlException e) {
            System.assert(e.getMessage().contains('INVALIDNAME'), 'Error should mention INVALIDNAME');
        }
        Test.stopTest();
    }
    
    @isTest
    static void testBulkInsertAllValid() {
        List<Contact> contacts = new List<Contact>();
        
        for(Integer i = 0; i < 5; i++) {
            contacts.add(new Contact(LastName='ValidName' + i));
        }
        
        Test.startTest();
        insert contacts;
        Test.stopTest();
        
        System.assertEquals(5, [SELECT COUNT() FROM Contact WHERE LastName LIKE 'ValidName%'], 
                           'All valid contacts should have been inserted');
    }
    
    @isTest
    static void testBulkUpdateMixedContacts() {
        // First insert valid contacts
        List<Contact> contacts = new List<Contact>();
        for(Integer i = 0; i < 5; i++) {
            contacts.add(new Contact(LastName='OriginalName' + i));
        }
        insert contacts;
        
        // Now update them - make one invalid
        contacts[0].LastName = 'UpdatedValid1';
        contacts[1].LastName = 'UpdatedValid2';
        contacts[2].LastName = 'INVALIDNAME'; // This one should cause failure
        contacts[3].LastName = 'UpdatedValid3';
        contacts[4].LastName = 'UpdatedValid4';
        
        Test.startTest();
        try {
            update contacts;
            System.assert(false, 'Bulk update should have failed due to invalid contact');
        } catch (DmlException e) {
            System.assert(e.getMessage().contains('INVALIDNAME'), 'Error should mention INVALIDNAME');
        }
        Test.stopTest();
    }
    
    @isTest
    static void testMultipleInvalidNamesInBulk() {
        List<Contact> contacts = new List<Contact>();
        
        // Add multiple invalid contacts
        contacts.add(new Contact(LastName='INVALIDNAME'));
        contacts.add(new Contact(LastName='ValidName1'));
        contacts.add(new Contact(LastName='INVALIDNAME'));
        contacts.add(new Contact(LastName='ValidName2'));
        
        Test.startTest();
        try {
            insert contacts;
            System.assert(false, 'Insert should have failed due to multiple invalid contacts');
        } catch (DmlException e) {
            System.assert(e.getMessage().contains('INVALIDNAME'), 'Error should mention INVALIDNAME');
        }
        Test.stopTest();
    }
}