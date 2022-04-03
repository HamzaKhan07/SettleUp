import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:settle_up/constants/constants.dart';
import 'package:settle_up/widgets/entry_card.dart';
import 'package:provider/provider.dart';
import 'package:settle_up/models/settle_brain.dart';
import 'package:settle_up/models/person.dart';
import 'package:intl/intl.dart';
import 'package:settle_up/models/settle_data.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class PayScreen extends StatefulWidget {
  final String expense;
  final String category;

  const PayScreen({Key? key, required this.expense, required this.category})
      : super(key: key);

  @override
  State<PayScreen> createState() => _PayScreenState();
}

class _PayScreenState extends State<PayScreen> {
  @override
  Widget build(BuildContext context) {
    Future<void> addSettleData() async {
      var data = await SettleData().getData();
      //add data
      Provider.of<SettleBrain>(context, listen: false).setSettleData(data);
    }

    String getDate() {
      final DateTime now = DateTime.now();
      final DateFormat formatter = DateFormat('MMM d');
      final String formatted = formatter.format(now);
      return formatted;
    }

    List<String> dataToAdd = [];
    String dataToAddString = '';
    var nameControlller = TextEditingController();
    var expenseController = TextEditingController();
    bool isLoading = false;

    return WillPopScope(
      onWillPop: () async {
        print('screen pop');
        //clear temp data
        Provider.of<SettleBrain>(context, listen: false).clearData();
        return true;
      },
      child: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Scaffold(
          backgroundColor: kblackColor,
          appBar: AppBar(
            elevation: 0,
            actions: [
              IconButton(
                onPressed: () async {
                  //setup data to add in database
                  var length = Provider.of<SettleBrain>(context, listen: false)
                      .people
                      .length;

                  if (length > 1) {
                    for (int i = 0; i < length; i++) {
                      String name =
                          Provider.of<SettleBrain>(context, listen: false)
                              .people[i]
                              .name;
                      double amount =
                          Provider.of<SettleBrain>(context, listen: false)
                              .people[i]
                              .amount;

                      String data = '$name - $amount ,';
                      dataToAdd.add(data);
                    }
                    dataToAddString = dataToAdd.join('');
                    print(dataToAddString);
                    String date = getDate();

                    //insert into database
                    List<String> data = [
                      dataToAddString,
                      widget.expense.trim(),
                      widget.category.trim(),
                      date.trim()
                    ];
                    //show loading
                    setState(() {
                      isLoading = true;
                    });
                    await SettleData().insertData(data);
                    print(SettleData().getData());
                    await addSettleData();

                    //hide loading
                    setState(() {
                      isLoading = false;
                    });
                    //pop until first screen
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  } else {
                    //show snackbar
                    final snackBar = SnackBar(
                      content: const Text('Add 2 or more Entries.'),
                      action: SnackBarAction(
                        label: 'OK',
                        textColor: Colors.white,
                        onPressed: () {
                          // Some code to undo the change.
                        },
                      ),
                    );
                  }
                },
                icon: Icon(Icons.check_circle_rounded, color: kgreenColor),
              ),
            ],
            iconTheme: const IconThemeData(
              color: Colors.white, //change your color here
            ),
            backgroundColor: kblackColor,
            title: const Text(
              'Enter Pay',
              style: TextStyle(fontFamily: 'Poppins', color: Colors.white),
            ),
          ),
          body: Container(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 25.0, vertical: 20.0),
                  child: Column(
                    children: [
                      TextField(
                        controller: nameControlller,
                        cursorColor: Colors.white,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.white,
                          fontSize: 18.0,
                        ),
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(5.0),
                          isDense: true,
                          hintText: 'Ex. Ram',
                          hintStyle: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Poppins',
                          ),
                          labelText: 'Person Name',
                          labelStyle: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16.0,
                              color: Colors.white),
                          enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 2.0),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 2.0),
                          ),
                          prefixIcon: Icon(
                            Icons.note_add,
                            size: 30.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 30.0),
                      TextField(
                        controller: expenseController,
                        cursorColor: Colors.white,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.white,
                          fontSize: 18.0,
                        ),
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(5.0),
                          isDense: true,
                          hintText: 'Ex. 50',
                          hintStyle: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Poppins',
                          ),
                          labelText: 'Expense',
                          labelStyle: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16.0,
                              color: Colors.white),
                          enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 2.0),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 2.0),
                          ),
                          prefixIcon: Icon(
                            Icons.attach_money,
                            size: 30.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 30.0),
                      FlatButton(
                        minWidth: 200.0,
                        onPressed: () {
                          if (nameControlller.text.isNotEmpty &&
                              expenseController.text.isNotEmpty) {
                            String name = nameControlller.text.trim();
                            double exp =
                                double.parse(expenseController.text.trim());
                            double expense =
                                double.parse(exp.toStringAsFixed(2));

                            print('name: $name');
                            print('expense: $expense');

                            //add data
                            Provider.of<SettleBrain>(context, listen: false)
                                .addPerson(Person(name: name, amount: expense));
                            print('data added');

                            //display delete snackbar
                            if (Provider.of<SettleBrain>(context, listen: false)
                                    .people
                                    .length ==
                                1) {
                              final snackBar = SnackBar(
                                content:
                                    const Text('Tap and hold entry to delete'),
                                action: SnackBarAction(
                                  label: 'OK',
                                  textColor: Colors.white,
                                  onPressed: () {
                                    // Some code to undo the change.
                                  },
                                ),
                              );

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            } else {}
                          } else {
                            print('field empty');

                            //show snackbar
                            const snackBar =
                                SnackBar(content: Text('Fill all the fields'));

                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        },
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.all(12.0),
                        child: const Text(
                          'Add',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0)),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 20.0),
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return EntryCard(
                          name: Provider.of<SettleBrain>(context)
                              .people[index]
                              .name,
                          amount: Provider.of<SettleBrain>(context)
                              .people[index]
                              .amount,
                          onPressCallback: () {
                            Provider.of<SettleBrain>(context, listen: false)
                                .deleteEntry(index);
                            print('entry deleted');
                          },
                        );
                      },
                      itemCount:
                          Provider.of<SettleBrain>(context).people.length,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
