import 'dart:math';

import 'package:flutter/material.dart';
import 'package:settle_up/constants/constants.dart';
import 'package:sizer/sizer.dart';
import 'package:settle_up/widgets/pay_card.dart';
import 'package:settle_up/widgets/legend_card.dart';
import 'package:settle_up/models/settle_brain.dart';
import 'package:provider/provider.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SettleScreen extends StatefulWidget {
  final List<String> settleData;
  final String expenseName;
  const SettleScreen(
      {Key? key, required this.settleData, required this.expenseName})
      : super(key: key);

  @override
  State<SettleScreen> createState() => _SettleScreenState();
}

class _SettleScreenState extends State<SettleScreen> {
  List<String> nameToName = [];
  List<String> nameToAmount = [];
  Map<String, double> map = {};
  bool isLoading = false;
  var random = Random();

  Future<String> getTripName() async {
    final prefs = await SharedPreferences.getInstance();
    String tripName = prefs.getString('tripName') ?? '';

    return tripName;
  }

  void shareDetails() async {
    //set loading
    setState(() {
      isLoading = true;
    });
    String expenseName = widget.expenseName;
    String tripName = await getTripName();
    String text = 'Trip: $tripName \nExpense: $expenseName \n\n';

    if (nameToName.isEmpty) {
      text = text + 'Everything is Settled';
    } else {
      for (int i = 0; i < nameToName.length; i++) {
        text = text + nameToName[i] + ' = ' + nameToAmount[i] + '\n';
      }
    }

    print(text);
    //unset loading
    setState(() {
      isLoading = false;
    });

    //share details
    await Share.share(text);
  }

  @override
  void initState() {
    super.initState();
    if (widget.settleData.isEmpty) {
      //logic for empty
      print('data already settled');
      setChartData();
      setState(() {});
    } else {
      for (int i = 0; i < widget.settleData.length; i++) {
        var data = widget.settleData[i].split(' ');
        nameToName
            .add(data[0].trim() + ' ' + data[1].trim() + ' ' + data[2].trim());
        nameToAmount.add(data[data.length - 1]);
      }
      // print(nameToName);
      // print(nameToAmount);

      setChartData();
      setState(() {});
    }
  }

  void setChartData() {
    //convert person to map for pie chart
    for (int i = 0;
        i < Provider.of<SettleBrain>(context, listen: false).people.length;
        i++) {
      String name =
          Provider.of<SettleBrain>(context, listen: false).people[i].name;
      double amount =
          Provider.of<SettleBrain>(context, listen: false).people[i].amount;
      map[name.trim()] = amount;
    }
    print(map);
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: kblackColor,
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                //capture screenshot here
                shareDetails();
              },
              icon: const Icon(Icons.share),
            ),
          ],
          iconTheme: const IconThemeData(
            color: Colors.white, //change your color here
          ),
          backgroundColor: kblackColor,
          title: const Text(
            'Settle',
            style: TextStyle(fontFamily: 'Poppins', color: Colors.white),
          ),
          elevation: 0,
        ),
        body: ListView(
          children: [
            const SizedBox(
              height: 12.0,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20.0),
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              decoration: BoxDecoration(
                color: klightblackColor,
                borderRadius: const BorderRadius.all(Radius.circular(25.0)),
              ),
              height: 38.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Contribution of Each',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(10.0),
                              child: PieChart(
                                colorList: klegendColors,
                                dataMap: map,
                                legendOptions: const LegendOptions(
                                  showLegends: false,
                                ),
                                chartValuesOptions: const ChartValuesOptions(
                                  showChartValueBackground: true,
                                  showChartValues: false,
                                  showChartValuesInPercentage: false,
                                  showChartValuesOutside: false,
                                ),
                              ),
                            ),
                            flex: 2,
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              physics: const ScrollPhysics(),
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ListView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount:
                                          Provider.of<SettleBrain>(context)
                                              .people
                                              .length,
                                      itemBuilder: (context, index) {
                                        return LegendCard(
                                          name:
                                              Provider.of<SettleBrain>(context)
                                                  .people[index]
                                                  .name,
                                          color: index <= 41
                                              ? klegendColors[index]
                                              : klegendColors[
                                                  random.nextInt(41)],
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            flex: 1,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
              color: kblackColor,
              child: widget.settleData.length > 0
                  ? ListView.builder(
                      physics: const ScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return PayCard(
                          nameToName: nameToName[index],
                          nameToAmount: nameToAmount[index],
                        );
                      },
                      itemCount: nameToName.length,
                    )
                  : Column(
                      children: const [
                        SizedBox(height: 30.0),
                        Text(
                          '👍',
                          style: TextStyle(fontSize: 50.0),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          'Everything is Settled',
                          style: TextStyle(
                              fontSize: 20.0,
                              fontFamily: 'Poppins',
                              color: Colors.white),
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}



// Column(
//         children: [
//           Container(
//             margin: const EdgeInsets.symmetric(horizontal: 20.0),
//             decoration: BoxDecoration(
//               color: ksilverColor,
//               borderRadius: const BorderRadius.all(Radius.circular(15.0)),
//             ),
//             height: 25.h,
//             child: const Center(
//               child: Text('Pie Chart'),
//             ),
//           ),
//           const SizedBox(
//             height: 30.0,
//           ),
//           Expanded(
//             child: Container(
//               color: Colors.red,
//               child: ListView.builder(
//                 shrinkWrap: true,
//                 itemBuilder: (context, index) {
//                   return const PayCard();
//                 },
//                 itemCount: 5,
//               ),
//             ),
//           ),
//         ],
//       ),
