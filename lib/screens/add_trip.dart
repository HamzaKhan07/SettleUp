import 'package:flutter/material.dart';
import 'package:settle_up/constants/constants.dart';
import 'package:settle_up/screens/trip_details.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:settle_up/models/currency_helper.dart';
import 'package:settle_up/models/settle_brain.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class AddTrip extends StatefulWidget {
  const AddTrip({Key? key}) : super(key: key);

  @override
  _AddTripState createState() => _AddTripState();
}

class _AddTripState extends State<AddTrip> {
  bool isLoading = false;
  bool isEmpty = false;
  Future<void> setHeadandCurrency(var tripName, var selectedCurrency) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('tripName', tripName);
    prefs.setString('selectedCurrency', selectedCurrency);
  }

  var controller = TextEditingController();
  List<DropdownMenuItem<String>> getItems() {
    List<DropdownMenuItem<String>> items = [];

    for (int i = 0; i < kcurrency.length; i++) {
      String item = kcurrency[i];
      var dropDownItem = DropdownMenuItem(
        child: Text(
          item,
        ),
        value: item,
      );
      items.add(dropDownItem);
    }
    return items;
  }

  var selected = 'AUD';
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
            'Add Trip',
            style: TextStyle(fontFamily: 'Poppins', color: Colors.black),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: controller,
                maxLength: 20,
                cursorColor: Colors.black,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.black,
                  fontSize: 18.0,
                ),
                decoration: InputDecoration(
                  errorText: isEmpty == true ? 'Field empty' : null,
                  errorStyle: const TextStyle(fontFamily: 'Poppins'),
                  contentPadding: const EdgeInsets.all(15.0),
                  isDense: true,
                  hintText: 'Ex. Roadtrip',
                  labelText: 'Trip Name',
                  labelStyle: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16.0,
                      color: Colors.black),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 2.0),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 2.0),
                  ),
                  prefixIcon: const Icon(
                    Icons.location_on,
                    size: 40.0,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(
                height: 40.0,
              ),
              const Text(
                'Select Currency',
                style: TextStyle(fontFamily: 'Poppins', fontSize: 18.0),
              ),
              const SizedBox(
                height: 20.0,
              ),
              DropdownButton<String>(
                isExpanded: true,
                value: selected,
                items: getItems(),
                onChanged: (value) {
                  setState(() {
                    selected = value!;
                  });
                },
              ),
              const SizedBox(height: 40.0),
              FlatButton(
                onPressed: () async {
                  if (controller.text.isEmpty) {
                    setState(() {
                      isEmpty = true;
                    });
                  } else if (controller.text.isNotEmpty &&
                      controller.text.length <= 20) {
                    //setLoading
                    setState(() {
                      isLoading = true;
                    });
                    await setHeadandCurrency('🌈 ' + controller.text.trim(),
                        selected.toString().trim());
                    print('data saved');

                    //set currency symbol globally
                    var symbol =
                        CurrencyHelper().getCurrencySymbol(selected.trim());
                    Provider.of<SettleBrain>(context, listen: false)
                        .setCurrencySymbol(symbol.trim());

                    //hideLoading
                    setState(() {
                      isLoading = false;
                    });
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const TripDetails()));
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
