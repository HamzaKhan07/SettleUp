import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:settle_up/widgets/entry_card.dart';
import 'package:settle_up/screens/settle_screen.dart';
import 'package:provider/provider.dart';
import 'package:settle_up/models/settle_brain.dart';
import 'package:settle_up/models/settle_logic.dart';

class EntryDetails extends StatelessWidget {
  final String expenseName;
  final String category;
  const EntryDetails(
      {Key? key, required this.expenseName, required this.category})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String getCategorySymbol(String category) {
      if (category == 'food') {
        return '🥘';
      } else if (category == 'fun') {
        return '⚽';
      } else if (category == 'travel') {
        return '🚖';
      } else if (category == 'shop') {
        return '🛒';
      } else if (category == 'rent') {
        return '🏠';
      } else {
        return '🎁';
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.black,
        icon: const Icon(
          Icons.shuffle,
          color: Colors.white,
        ),
        label: const Text(
          'Split',
          style: TextStyle(fontFamily: 'Poppins', color: Colors.white),
        ),
        onPressed: () {
          List<String> settledData = SettleLogic().settle(
              Provider.of<SettleBrain>(context, listen: false).getPeople());
          print(settledData);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SettleScreen(
                        settleData: settledData,
                        expenseName: expenseName,
                      )));
        },
      ),
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.white,
        title: const Text(
          'Expense Details',
          style: TextStyle(fontFamily: 'Poppins', color: Colors.black),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 12.h,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 7,
                    blurRadius: 5,
                    offset: const Offset(0, 4), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                    child: Text(
                      'Expense Name: $expenseName ${getCategorySymbol(category)}',
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40.0),
            const Text(
              'Pay',
              style: TextStyle(fontFamily: 'Poppins', fontSize: 20.0),
            ),
            const SizedBox(height: 20.0),
            Expanded(
              child: Container(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return EntryCard(
                      onPressCallback: () {},
                      name:
                          Provider.of<SettleBrain>(context).people[index].name,
                      amount: Provider.of<SettleBrain>(context)
                          .people[index]
                          .amount,
                    );
                  },
                  itemCount: Provider.of<SettleBrain>(context).people.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
