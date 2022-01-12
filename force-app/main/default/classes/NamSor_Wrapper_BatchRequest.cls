global class NamSor_Wrapper_BatchRequest {
    global class Person {
        global String name;
        global Person(String personName) {
            this.name = personName;
        }
    }

    global List<Person> personalNames;
    global NamSor_Wrapper_BatchRequest(List<String> names) {
        personalNames = new List<Person>();
        for(String name : names) {
            personalNames.add(new Person(name));
        }
    }
}