@IsTest
private class ContactSearchTest {
    @IsTest
    static void testGenerateList() {
        List<Contact> contacts = new List<Contact>();
        for (Integer i = 0; i < 5; i++) {
            contacts.add(new Contact(LastName='Name ' + i, MailingStreet='123 Test St', MailingPostalCode='9000' + i));
        }
        insert contacts;

        List<Contact> result = ContactSearch.searchForContacts(contacts[0].LastName, contacts[0].MailingPostalCode);
        System.assert(result.size() > 0, 'La lista de contactos debe tener al menos un elemento');
    }
}
