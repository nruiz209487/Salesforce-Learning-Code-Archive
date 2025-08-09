public class AccountHandler {
    public static Account insertNewAccount(String text) {
        Account res = new Account(Name = text);
        try {
            insert res;
        } catch (Exception e) {
            res = null;
        }
        return res;
    }
}
