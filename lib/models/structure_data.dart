import 'package:settle_up/models/person.dart';

class StructureData {
  List<Person> structure(String data) {
    List<Person> people = [];
    List<String> entries = data.split(',');

    for (int i = 0; i < entries.length - 1; i++) {
      List<String> entry = entries[i].split('-');
      String name = entry[0].trim();
      double amount = double.parse(entry[1].trim());

      people.add(Person(name: name, amount: amount));
    }
    return people;
  }
}
