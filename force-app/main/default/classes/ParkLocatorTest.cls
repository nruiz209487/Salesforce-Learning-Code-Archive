@isTest
public class ParkLocatorTest {
    @isTest static void testCountry() {
        ParkServiceMock mock = new ParkServiceMock();
        Test.setMock(WebServiceMock.class, mock);
        Test.startTest();
        List<String> result = ParkLocator.country('US'); // <-- List<String> aquí
        Test.stopTest();
        
        System.assertEquals(2, result.size()); // <-- size() de List
        System.assertEquals('Yellowstone', result[0]);
        System.assertEquals('Yosemite', result[1]);
    }
}
