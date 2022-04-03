import 'package:settle_up/models/person.dart';

class SettleLogic {
  List<String> settle(List<Person> people) {
    List<String> settledData = [];
    List<Person> extra = [];
    List<Person> less = [];
    double total = 0;
    double share = 0;

    //getTotal
    for (int i = 0; i < people.length; i++) {
      total = total + double.parse(people[i].amount.toStringAsFixed(2));
    }
    total = double.parse(total.toStringAsFixed(2));

    //getShare
    share = double.parse((total / people.length).toStringAsFixed(2));
    print(share);

    //seperating amounts logic
    for (int i = 0; i < people.length; i++) {
      double amt = double.parse((people[i].amount - share).toStringAsFixed(2));
      String name = people[i].name;

      //paid extra
      if (amt > 0) {
        extra.add(Person(name: name, amount: amt));
      } else {
        amt = amt * -1;
        less.add(Person(name: name, amount: amt));
      }
    }

    //main logic
    for (int i = 0; i < less.length; i++) {
      for (int j = 0; j < extra.length; j++) {
        if (i == -1) {
          i = 0;
        }

        if (less[i].amount >= extra[j].amount) {
          if (extra[j].amount > 0) {
            //add to list
            settledData.add(less[i].name +
                ' to ' +
                extra[j].name +
                ' = ' +
                (extra[j].amount).toStringAsFixed(1));
          }

          less[i].amount = double.parse(less[i].amount.toStringAsFixed(2)) -
              double.parse(extra[j].amount.toStringAsFixed(2));
          extra.removeAt(j);
          j--;
        } else if (less[i].amount <= extra[j].amount) {
          if (less[i].amount > 0) {
            //add to list
            settledData.add(less[i].name +
                ' to ' +
                extra[j].name +
                ' = ' +
                (less[i].amount).toStringAsFixed(1));
          }

          extra[j].amount = double.parse(extra[j].amount.toStringAsFixed(2)) -
              double.parse(less[i].amount.toStringAsFixed(2));
          less.removeAt(i);
          i--;
          break;
        }

        if (i != -1 && less[i].amount <= 0) {
          break;
        }
      }
    }
    return settledData;
  }
}
