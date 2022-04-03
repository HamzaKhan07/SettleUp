import 'package:flutter/material.dart';
import 'package:settle_up/screens/trip_details.dart';
import 'package:settle_up/widgets/home_card.dart';
import 'package:settle_up/screens/add_trip.dart';
import 'package:settle_up/screens/entry_details.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:settle_up/screens/more_screen.dart';
import 'package:provider/provider.dart';
import 'package:settle_up/models/settle_brain.dart';
import 'package:settle_up/models/currency_helper.dart';
import 'package:settle_up/models/settle_data.dart';
import 'package:settle_up/models/structure_data.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var head = '';
  var currency = '';
  var startHead = 'Settle \nUp 🔥';
  var tripHead = '🌈 Trip to Hyderabad';
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    //show loading
    setState(() {
      isLoading = true;
    });

    setHead();
    startDatabase();
    addSettleData();
    //hide loading
    setState(() {
      isLoading = false;
    });
  }

  void startDatabase() async {
    await SettleData().createDatabase();
  }

  void addSettleData() async {
    var data = await SettleData().getData();
    //add data
    Provider.of<SettleBrain>(context, listen: false).setSettleData(data);
  }

  void setHead() async {
    print('in set head');
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      head = prefs.getString('tripName') ?? startHead;
      currency = prefs.getString('selectedCurrency') ?? '';
      print('Head: $head');
      print('Currency: $currency');

      //set currency symbol globally
      var symbol = CurrencyHelper().getCurrencySymbol(currency.trim());
      Provider.of<SettleBrain>(context, listen: false)
          .setCurrencySymbol(symbol.trim());

      //Clear temp data
      Provider.of<SettleBrain>(context, listen: false).clearData();
      print('data cleared');
    });
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          child: const Icon(Icons.add),
          onPressed: () {
            //delete temp person data
            Provider.of<SettleBrain>(context, listen: false).clearData();

            if (head == startHead) {
              Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const AddTrip()))
                  .then((value) => setHead());
            } else {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const TripDetails()));
            }
          },
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 40.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const MoreScreen()))
                            .then((value) => setHead());
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.grey[400],
                        radius: 14.0,
                        child: const Icon(
                          Icons.more_horiz,
                          size: 24.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                head,
                style: const TextStyle(
                  height: 1.4,
                  fontFamily: 'Poppins',
                  fontSize: 40.0,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 2,
              ),
              Expanded(
                child: head != startHead
                    ? ListView.builder(
                        itemBuilder: (context, index) {
                          return HomeCard(
                            onLongTap: () async {
                              //show loading
                              setState(() {
                                isLoading = true;
                              });
                              //delete from database
                              String expenseName = Provider.of<SettleBrain>(
                                      context,
                                      listen: false)
                                  .getExpenseName(index);
                              print(expenseName);
                              List data = [expenseName.trim()];

                              //delete from ui
                              try {
                                Provider.of<SettleBrain>(context, listen: false)
                                    .deleteSettleEntry(index);
                              } catch (error) {
                                print(error.toString());
                              }

                              await SettleData().deleteData(data);

                              //hide loading
                              setState(() {
                                isLoading = false;
                              });
                            },
                            onPress: () {
                              print('on tap');
                              String expenseName = Provider.of<SettleBrain>(
                                      context,
                                      listen: false)
                                  .settleData[index]
                                  .expenseName;
                              String category = Provider.of<SettleBrain>(
                                      context,
                                      listen: false)
                                  .settleData[index]
                                  .category;
                              String data = Provider.of<SettleBrain>(context,
                                      listen: false)
                                  .settleData[index]
                                  .details;

                              //set temp data
                              var personData = StructureData().structure(data);
                              Provider.of<SettleBrain>(context, listen: false)
                                  .setPersonData(personData);

                              //Go to next screen
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EntryDetails(
                                          expenseName: expenseName,
                                          category: category)));
                            },
                            expenseName: Provider.of<SettleBrain>(context)
                                .settleData[index]
                                .expenseName,
                            category: Provider.of<SettleBrain>(context)
                                .settleData[index]
                                .category,
                            date: Provider.of<SettleBrain>(context)
                                .settleData[index]
                                .date,
                          );
                        },
                        itemCount:
                            Provider.of<SettleBrain>(context).settleData.length,
                      )
                    : Center(
                        child: Column(
                          children: const [
                            SizedBox(
                              height: 70.0,
                            ),
                            Text(
                              '😎',
                              style: TextStyle(fontSize: 50.0),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Text(
                              'Start New Trip',
                              style: TextStyle(
                                  fontSize: 20.0,
                                  fontFamily: 'Poppins',
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
