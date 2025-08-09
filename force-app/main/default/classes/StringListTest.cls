public class StringListTest {
    public static list<String> generateStringList(Integer n) {
        list<String> res = new List<String>();
        if (n < 0) {
            throw new IllegalArgumentException('The number of strings must be non-negative.');
        }
        for (Integer i = 0  ; i < n ; i++){
            res.add('Test ' + i);
        }
        return  res;
    }
}