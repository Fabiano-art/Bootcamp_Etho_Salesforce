@IsTest
public class CallloutToMarvelTest {
	
    @IsTest
    public static void testaCalloutSuccess(){
        CallloutToMarvelMock mock = new CallloutToMarvelMock(200);
        Test.setMock(HttpCalloutMock.class, mock);
        CallloutToMarvel.getcharacters();
    }
    
    // Internal error code (500)
    public static void testaCalloutFailed(){
        CallloutToMarvelMock mock = new CallloutToMarvelMock(500);
        Test.setMock(HttpCalloutMock.class, mock);
        CallloutToMarvel.getcharacters();
    }
}