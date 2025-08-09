@IsTest
private class StringListMiTest {
    @IsTest
    static void testGenerateList() {
        List<String> result = StringListTest.generateStringList(3);
        System.assertEquals(3, result.size(), 'La lista debe tener 3 elementos');
        System.assertEquals('test 0', result[0]);
        System.assertEquals('test 1', result[1]);
        System.assertEquals('test 2', result[2]);
    }
}
