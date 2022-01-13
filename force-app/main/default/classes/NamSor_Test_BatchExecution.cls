@isTest
public class NamSor_Test_BatchExecution {
    class Mock_success implements HttpCalloutMock {
		public HttpResponse respond(HttpRequest request) {
			HttpResponse res = new HttpResponse();
			res.setBody('{"personalNames":[{"script":"LATIN","id":"00000000-0000-0000-0000-000000000000","name":"Test1 Test1","likelyGender":"male","genderScale":-0.9896729987179604,"score":21.921192868770223,"probabilityCalibrated":0.9948364993589802},{"script":"LATIN","id":"00000000-0000-0000-1111-000000000000","name":"Test2 Test2","likelyGender":"female","genderScale":0.9813901233450275,"score":18.90505939119905,"probabilityCalibrated":0.9906950616725138}]}');
			res.setStatusCode(200);
			return res;
		}
	}

	@isTest
	public static void execute_daily() {
		Test.setMock(HttpCalloutMock.class, new Mock_success());

        Contact ctc1 = new Contact(FirstName='Test1', LastName='Test1');
        insert ctc1;

        Contact ctc2 = new Contact(FirstName='Test2', LastName='Test2');
        insert ctc2;

        Test.startTest();

        NamSor_BatchExecution batchExecution = new NamSor_BatchExecution();
        Database.executeBatch(batchExecution, 100);

        Test.stopTest();

        Map<String, String> mapExpected = new Map<String, String>();
        mapExpected.put('Test1 Test1', 'male');
        mapExpected.put('Test2 Test2', 'female');

        List<Contact> lstResults = [SELECT Name, Namsor_Likely_gender__c FROM Contact WHERE Namsor_Likely_gender__c != null];

        Map<String, String> mapResults = new Map<String, String>();
        for(Contact ctc : lstResults) {
            mapResults.put(ctc.Name, ctc.Namsor_Likely_gender__c);
        }

        System.assertEquals(2, lstResults.size(), 'There should be 2 enriched Contacts.');

        for(String name : mapResults.keySet()) {
            System.assertEquals(mapExpected.get(name), mapResults.get(name), 'The likely gender of the Contact should be the same as the expected gender.');
        }
    }
}
