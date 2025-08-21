@isTest
private class AnimalLocatorTest {
    @isTest static void testGetAnimalNameByIdSuccess() {
        Test.setMock(HttpCalloutMock.class, new AnimalLocatorMock());
        String animalName = AnimalLocator.getAnimalNameById(1);
        System.assertEquals('mocked animal', animalName);
    }

    @isTest static void testGetAnimalNameByIdFailure() {
        Test.setMock(HttpCalloutMock.class, new AnimalLocatorMock());
        String animalName = AnimalLocator.getAnimalNameById(999);
        System.assertEquals(null, animalName);
    }
}
