import 'package:flutter/material.dart';
import 'package:settle_up/constants/constants.dart';
import 'package:settle_up/screens/pay_screen.dart';
import 'package:settle_up/models/settle_data.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

enum selectedCategory { food, fun, travel, shop, rent, others }

class TripDetails extends StatefulWidget {
  const TripDetails({Key? key}) : super(key: key);

  @override
  _TripDetailsState createState() => _TripDetailsState();
}

class _TripDetailsState extends State<TripDetails> {
  String getCategory(category) {
    if (category == selectedCategory.food) {
      return 'food';
    } else if (category == selectedCategory.fun) {
      return 'fun';
    } else if (category == selectedCategory.travel) {
      return 'travel';
    } else if (category == selectedCategory.shop) {
      return 'shop';
    } else if (category == selectedCategory.rent) {
      return 'rent';
    } else {
      return 'others';
    }
  }

  var expenseController = TextEditingController();
  var selected = selectedCategory.fun;
  bool isEmpty = false;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 0,
          iconTheme: const IconThemeData(
            color: Colors.black, //change your color here
          ),
          backgroundColor: Colors.white,
          title: const Text(
            'Enter Details',
            style: TextStyle(fontFamily: 'Poppins', color: Colors.black),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 20.0,
            horizontal: 30.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                onChanged: (value) {
                  if (value.isEmpty) {
                    setState(() {
                      isEmpty = true;
                    });
                  } else {
                    setState(() {
                      isEmpty = false;
                    });
                  }
                },
                controller: expenseController,
                cursorColor: Colors.black,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.black,
                  fontSize: 20.0,
                ),
                decoration: InputDecoration(
                  errorText: isEmpty == true ? 'Field empty' : null,
                  errorStyle: const TextStyle(
                    fontFamily: 'Poppins',
                  ),
                  contentPadding: const EdgeInsets.all(15.0),
                  isDense: true,
                  hintText: 'Ex. Lunch',
                  labelText: 'Expense Name',
                  labelStyle: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 18.0,
                      color: Colors.black),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 2.0),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 2.0),
                  ),
                  prefixIcon: const Icon(
                    Icons.note_add,
                    size: 40.0,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 40.0),
              const Text(
                'Select Category',
                style: TextStyle(fontFamily: 'Poppins', fontSize: 18.0),
              ),
              const SizedBox(
                height: 40.0,
              ),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selected = selectedCategory.food;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: selected == selectedCategory.food
                              ? klightgreenColor
                              : klightsilverColor,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10.0)),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        margin: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Text(
                              '🥘',
                              style: TextStyle(fontSize: 35.0),
                            ),
                            SizedBox(
                              height: 13.0,
                            ),
                            Text(
                              'Food',
                              style: TextStyle(
                                  fontSize: 14.0,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selected = selectedCategory.fun;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: selected == selectedCategory.fun
                              ? klightgreenColor
                              : klightsilverColor,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10.0)),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        margin: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Text(
                              '⚽',
                              style: TextStyle(fontSize: 35.0),
                            ),
                            SizedBox(
                              height: 13.0,
                            ),
                            Text(
                              'Fun',
                              style: TextStyle(
                                fontSize: 14.0,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selected = selectedCategory.travel;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: selected == selectedCategory.travel
                              ? klightgreenColor
                              : klightsilverColor,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10.0)),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        margin: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Text(
                              '🚖',
                              style: TextStyle(fontSize: 35.0),
                            ),
                            SizedBox(
                              height: 13.0,
                            ),
                            Text(
                              'Travel',
                              style: TextStyle(
                                  fontSize: 14.0,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selected = selectedCategory.shop;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: selected == selectedCategory.shop
                              ? klightgreenColor
                              : klightsilverColor,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10.0)),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        margin: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Text(
                              '🛒',
                              style: TextStyle(fontSize: 35.0),
                            ),
                            SizedBox(
                              height: 13.0,
                            ),
                            Text(
                              'Shop',
                              style: TextStyle(
                                fontSize: 14.0,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selected = selectedCategory.rent;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: selected == selectedCategory.rent
                              ? klightgreenColor
                              : klightsilverColor,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10.0)),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        margin: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Text(
                              '🏠',
                              style: TextStyle(fontSize: 35.0),
                            ),
                            SizedBox(
                              height: 13.0,
                            ),
                            Text(
                              'Rent',
                              style: TextStyle(
                                fontSize: 14.0,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selected = selectedCategory.others;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: selected == selectedCategory.others
                              ? klightgreenColor
                              : klightsilverColor,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10.0)),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        margin: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Text(
                              '🎁',
                              style: TextStyle(fontSize: 35.0),
                            ),
                            SizedBox(
                              height: 13.0,
                            ),
                            Text(
                              'Others',
                              style: TextStyle(
                                fontSize: 14.0,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 40.0,
              ),
              FlatButton(
                onPressed: () async {
                  if (expenseController.text.isNotEmpty) {
                    var expense = expenseController.text.trim();
                    var category = getCategory(selected);
                    print('expense: $expense');
                    print('category: $category');

                    //check if expense already exists
                    setState(() {
                      isLoading = true;
                    });
                    bool isExists = await SettleData().searchData(expense);
                    print('isExists: $isExists');
                    setState(() {
                      isLoading = false;
                    });

                    if (isExists == true) {
                      //show dialog error
                      _onAlertButtonPressed(context);
                    } else {
                      //Next screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PayScreen(
                            expense: expense,
                            category: category,
                          ),
                        ),
                      );
                    }
                  } else {
                    //show snackbar
                    print('field empty');
                    setState(() {
                      isEmpty = true;
                    });
                  }
                },
                color: kblackColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(15.0),
                child: const Text(
                  'Next',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

_onAlertButtonPressed(context) {
  Alert(
    context: context,
    type: AlertType.error,
    title: "Expense Already Exists",
    desc: "Try changing the name of Expense",
    buttons: [
      DialogButton(
        color: kblackColor,
        child: const Text(
          "OK",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () {
          Navigator.pop(context);
        },
        width: 120,
      )
    ],
  ).show();
}
