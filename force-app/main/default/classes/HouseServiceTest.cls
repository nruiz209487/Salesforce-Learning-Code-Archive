@IsTest
private class HouseServiceTest {
    @IsTest
    static void testGenerateList() {
        List<House__c> houses = new List<House__c>();
        for (Integer i = 0; i < 5; i++) {
            houses.add(new House__c(Name='Test House ' + i, Address__c='123 Test St', State__c='CA', City__c='Testville', Zip__c='90000'));
        }
        insert houses;
        List<House__c> result = HouseService.getRecords();
        System.assert(result.size() > 0, 'La lista de casas debe tener al menos un elemento');
    }
}
