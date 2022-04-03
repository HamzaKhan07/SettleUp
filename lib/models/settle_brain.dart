import 'package:flutter/foundation.dart';
import 'package:settle_up/models/person.dart';
import 'package:settle_up/models/settle_data.dart';

class SettleBrain extends ChangeNotifier {
  String currencySymbol = '';
  List<Person> people = [];
  List<SettleData> settleData = [];

  void addPerson(person) {
    people.add(person);
    notifyListeners();
  }

  void setPersonData(data) {
    people.clear();
    people = data;
    notifyListeners();
  }

  void setCurrencySymbol(symbol) {
    currencySymbol = symbol;
    notifyListeners();
  }

  String getCurrencySymbol() {
    return currencySymbol;
  }

  void clearData() {
    people.clear();
    notifyListeners();
  }

  void deleteEntry(int index) {
    people.removeAt(index);
    notifyListeners();
  }

  void deleteSettleEntry(int index) {
    settleData.removeAt(index);
    notifyListeners();
  }

  void setSettleData(data) {
    settleData = data;
    settleData = settleData.reversed.toList();
    notifyListeners();
  }

  String getExpenseName(int index) {
    return settleData[index].expenseName;
  }

  void clearSettleData() {
    settleData.clear();
    notifyListeners();
  }

  List<Person> getPeople() {
    return people;
  }
}
