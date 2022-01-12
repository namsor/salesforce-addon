@isTest
public class NamSor_Test_EnrichContact {

    @TestSetup
    static void createSetup(){
        List<String> letters = new List<String>{'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z'};
        List<Contact> lstContacts = new List<Contact>();
        for(String firstLetter : letters) {
            for(String lastLetter : letters) {
                Contact ctc = new Contact();
                ctc.FirstName = firstLetter;
                ctc.LastName = lastLetter;
                lstContacts.add(ctc);
            }
        }

        insert lstContacts;
    }

    @isTest
    public static void getNamesContactsMap() {
        Contact duplicateNameContact1 = new Contact(FirstName='Test', LastName='Test');
        insert duplicateNameContact1;

        Contact duplicateNameContact2 = new Contact(FirstName='Test', LastName='Test');
        insert duplicateNameContact2;

        List<Contact> lstContacts = [SELECT Id, Name, Namsor_Likely_Gender__c from Contact];

        Test.startTest();

        Map<String, List<Contact>> resultMap = NamSor_EnrichContact.getNamesContactsMap(lstContacts);

        Test.stopTest();

        Integer totalContacts = lstContacts.size();

        // Counts the Duplicated Contact added
        Integer totalUniqueNames = totalContacts - 1;

        System.assertEquals(totalUniqueNames, resultMap.keySet().size(), 'The result should have the correct number of keys.');
        System.assertEquals(2, resultMap.get('Test Test').size(), 'The duplicated name key should have a list containing the 2 duplicated Contacts.');
    }

    @isTest
    public static void serializeJsonBody() {
        List<String> lstNames = new List<String>();
        lstNames.add('Test1 Test1');
        lstNames.add('Test2 Test2');
        lstNames.add('Test3 Test3');
        lstNames.add('Test4 Test4');
        lstNames.add('Test5 Test5');

        Test.startTest();

        String resultString = NamSor_EnrichContact.serializeJsonBody(lstNames);

        Test.stopTest();

        String expectedResult = '{"personalNames":[{"name":"Test1 Test1"},{"name":"Test2 Test2"},{"name":"Test3 Test3"},{"name":"Test4 Test4"},{"name":"Test5 Test5"}]}';

        System.assertEquals(expectedResult, resultString, 'The result String should have the desired JSON structure.');
    }

    @isTest
    public static void deserializeResponse() {
        String testResponse = '{"personalNames":[{"script":"LATIN","id":"00000000-0000-0000-0000-000000000000","name":"Test1 Test1","likelyGender":"male","genderScale":-0.9896729987179604,"score":21.921192868770223,"probabilityCalibrated":0.9948364993589802},{"script":"LATIN","id":"00000000-0000-0000-1111-000000000000","name":"Test2 Test2","likelyGender":"female","genderScale":0.9813901233450275,"score":18.90505939119905,"probabilityCalibrated":0.9906950616725138}]}';

        Test.startTest();

        NamSor_Wrapper_BatchResponse resultDeserialized = NamSor_EnrichContact.deserializeResponse(testResponse);

        Test.stopTest();

        System.assertEquals(2, resultDeserialized.personalNames.size(), 'The deserialized result should have 2 records.');
        System.assertEquals('Test1 Test1', resultDeserialized.personalNames.get(0).name, 'The first record should have the correct name.');
        System.assertEquals('male', resultDeserialized.personalNames.get(0).likelyGender, 'The first record should have the correct gender.');
        System.assertEquals('Test2 Test2', resultDeserialized.personalNames.get(1).name, 'The second record should have the correct name.');
        System.assertEquals('female', resultDeserialized.personalNames.get(1).likelyGender, 'The second record should have the correct gender.');
    }

    @isTest
    public static void getNameGenderMap() {
        NamSor_Wrapper_BatchResponse testResponse = new NamSor_Wrapper_BatchResponse();
        testResponse.personalNames = new List<NamSor_Wrapper_BatchResponse.Person>();
        NamSor_Wrapper_BatchResponse.Person person1 = new NamSor_Wrapper_BatchResponse.Person();
        person1.name = 'Test1 Test1';
        person1.likelyGender = 'male';
        testResponse.personalNames.add(person1);
        NamSor_Wrapper_BatchResponse.Person person2 = new NamSor_Wrapper_BatchResponse.Person();
        person2.name = 'Test2 Test2';
        person2.likelyGender = 'female';
        testResponse.personalNames.add(person2);

        Test.startTest();

        Map<String, String> resultMap = NamSor_EnrichContact.getNameGenderMap(testResponse);

        Test.stopTest();

        System.assertEquals(2, resultMap.keySet().size(), 'The result map should have 2 keys.');
        System.assert(resultMap.containsKey('Test1 Test1'), 'The result map should have the first person\'s name as a key.');
        System.assertEquals('male', resultMap.get('Test1 Test1'), 'The likely gender for the first person should be correct.');
        System.assert(resultMap.containsKey('Test2 Test2'), 'The result map should have the second person\'s name as a key.');
        System.assertEquals('female', resultMap.get('Test2 Test2'), 'The likely gender for the second person should be correct.');
    }

    @isTest
    public static void updateContacts() {
        Map<String, List<Contact>> testMapNameContact = new Map<String, List<Contact>>();
        Map<String, String> testMapNameGender = new Map<String, String>();

        Contact ctc1 = new Contact(FirstName='update_Test1', LastName='Test1');
        insert ctc1;
        ctc1 = [SELECT Name, Namsor_Likely_Gender__c FROM Contact WHERE Id = :ctc1.Id];
        
        Contact ctc1dup = new Contact(FirstName='update_Test1', LastName='Test1');
        insert ctc1dup;
        ctc1dup = [SELECT Name, Namsor_Likely_Gender__c FROM Contact WHERE Id = :ctc1dup.Id];
        
        Contact ctc2 = new Contact(FirstName='update_Test2', LastName='Test2');
        insert ctc2;
        ctc2 = [SELECT Name, Namsor_Likely_Gender__c FROM Contact WHERE Id = :ctc2.Id];
        
        Contact ctc3 = new Contact(FirstName='update_Test3', LastName='Test3');
        insert ctc3;
        ctc3 = [SELECT Name, Namsor_Likely_Gender__c FROM Contact WHERE Id = :ctc3.Id];

        testMapNameContact.put(ctc1.Name, new List<Contact>{ctc1, ctc1dup});
        testMapNameContact.put(ctc2.Name, new List<Contact>{ctc2});
        testMapNameContact.put(ctc3.Name, new List<Contact>{ctc3});

        testMapNameGender.put('update_Test1 Test1', 'male');
        testMapNameGender.put('update_Test2 Test2', 'female');
        testMapNameGender.put('update_Test3 Test3', 'female');

        Test.startTest();

        NamSor_EnrichContact.updateContacts(testMapNameContact, testMapNameGender);

        Test.stopTest();

        List<Contact> result = [SELECT Id, Name, Namsor_Likely_Gender__c from Contact WHERE Name LIKE 'update_%'];

        System.assertEquals(4, result.size(), 'The result list should have the correct number of records.');

        for(Contact ctc : result) {
            System.assertEquals(testMapNameGender.get(ctc.Name), ctc.Namsor_Likely_Gender__c, 'The Contact gender should have been correctly updated! Contact: ' + ctc.Name);
        }
    }
}