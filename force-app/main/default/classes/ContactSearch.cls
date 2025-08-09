public class ContactSearch {
    public static List<Contact> searchForContacts(String lastName, String mailing) {
        List<Contact> res = new List<Contact>();
        try {
            res = [SELECT Id, Name FROM Contact WHERE LastName LIKE :('%' + lastName + '%') AND MailingPostalCode LIKE :('%' + mailing + '%')];
        } catch (Exception e) {
            System.debug('Error executing query: ' + e.getMessage());
        }
        return res;
    }
}
