import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:settle_up/models/settle_brain.dart';
import 'package:settle_up/models/settle_data.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({Key? key}) : super(key: key);

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          iconTheme: const IconThemeData(
            color: Colors.black, //change your color here
          ),
          backgroundColor: Colors.transparent,
          title: const Text(
            'More',
            style: TextStyle(fontFamily: 'Poppins', color: Colors.black),
          ),
        ),
        body: SafeArea(
          child: Container(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
            child: GestureDetector(
              onTap: () async {
                //show loading
                setState(() {
                  isLoading = true;
                });
                final prefs = await SharedPreferences.getInstance();
                prefs.remove('tripName');
                prefs.remove('selectedCurrency');
                print('data deleted');

                //delete temp data
                Provider.of<SettleBrain>(context, listen: false).clearData();
                Provider.of<SettleBrain>(context, listen: false)
                    .clearSettleData();

                //delete database data

                await SettleData().deleteAll();
                //hide loading
                setState(() {
                  isLoading = false;
                });
                //pop screen
                Navigator.pop(context);
              },
              child: const Card(
                color: Color(0xFFFCFCFC),
                child: ListTile(
                  contentPadding: EdgeInsets.all(10.0),
                  leading: Icon(
                    Icons.delete,
                    color: Colors.black,
                    size: 30.0,
                  ),
                  title: Text(
                    'Delete Current Trip',
                    style: TextStyle(fontFamily: 'Poppins', fontSize: 18.0),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
