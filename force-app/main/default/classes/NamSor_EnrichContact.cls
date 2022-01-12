public class NamSor_EnrichContact {

    public static void execute(List<Contact> contactsToUpdate) {
        Map<String, List<Contact>> mapNameContacts = getNamesContactsMap(contactsToUpdate);
        String jsonBody = serializeJsonBody(new List<String>(mapNameContacts.keySet()));
        try {
            String jsonResponse = makeNamsorCall(jsonBody);
            NamSor_Wrapper_BatchResponse namsorResponse = deserializeResponse(jsonResponse);
            Map<String,String> mapNameGender = getNameGenderMap(namsorResponse);
            updateContacts(mapNameContacts, mapNameGender);
        } catch (Exception exc) {
            System.debug('Something went wrong calling the Namsor API!');
            System.debug('Message: ' + exc.getMessage());
        }
    }

    public static String makeNamsorCall(String jsonBody) {
        HttpRequest req = new HttpRequest();
        req.setMethod('POST');
        req.setEndpoint('callout:Namsor_API/api2/json/genderFullBatch');
        req.setHeader('X-API-KEY', '{!$Credential.Password}');
        req.setHeader('Content-Type', 'application/json');
        req.setHeader('Accept', 'application/json');
        req.setBody(jsonBody);
        Http http = new Http();
        HTTPResponse res = http.send(req);
        return res.getBody();
    }

    public static Map<String, List<Contact>> getNamesContactsMap(List<Contact> contactsToUpdate) {
        Map<String, List<Contact>> mapUniqueNameContacts = new Map<String, List<Contact>>();

        for(Contact ctc : contactsToUpdate) {
            if(mapUniqueNameContacts.containsKey(ctc.Name)) {
                mapUniqueNameContacts.get(ctc.Name).add(ctc);
            }
            else {
                mapUniqueNameContacts.put(ctc.Name, new List<Contact>{ctc});
            }
        }

        return mapUniqueNameContacts;
    }

    public static String serializeJsonBody(List<String> namesList) {
        String jsonBody = System.JSON.serialize(new NamSor_Wrapper_BatchRequest(namesList));
        return jsonBody;
    }

    public static NamSor_Wrapper_BatchResponse deserializeResponse(String jsonResponse) {
        NamSor_Wrapper_BatchResponse response = (NamSor_Wrapper_BatchResponse)JSON.deserialize(jsonResponse, NamSor_Wrapper_BatchResponse.class);
        return response;
    }

    public static Map<String, String> getNameGenderMap(NamSor_Wrapper_BatchResponse namsorResponse) {
        Map<String, String> mapNameGender = new Map<String, String>();
        for(NamSor_Wrapper_BatchResponse.Person person : namsorResponse.personalNames) {
            mapNameGender.put(person.name, person.likelyGender);
        }
        return mapNameGender;
    }

    public static void updateContacts(Map<String, List<Contact>> mapNameContact, Map<String, String> mapNameGender) {
        List<Contact> contactsToUpdate = new List<Contact>();
        for(String name : mapNameGender.keySet()) {
            String namsorGender = mapNameGender.get(name);
            List<Contact> contactsWithSameName = mapNameContact.get(name);
            for(Contact ctc : contactsWithSameName) {
                ctc.Namsor_Likely_Gender__c = namsorGender;
                contactsToUpdate.add(ctc);
            }
        }
        update contactsToUpdate;
    }
}