import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:settle_up/constants/constants.dart';
import 'package:provider/provider.dart';
import 'package:settle_up/models/settle_brain.dart';

class EntryCard extends StatelessWidget {
  final String name;
  final double amount;
  final VoidCallback onPressCallback;

  const EntryCard(
      {Key? key,
      required this.name,
      required this.amount,
      required this.onPressCallback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: onPressCallback,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        height: 10.h,
        decoration: BoxDecoration(
          color: ksilverColor,
          borderRadius: const BorderRadius.all(Radius.circular(15.0)),
        ),
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(right: 6.0),
                child: Text(
                  name,
                  style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              flex: 2,
            ),
            Expanded(
              child: Container(
                child: Center(
                  child: Text(
                    '${Provider.of<SettleBrain>(context).getCurrencySymbol()}$amount',
                    style: const TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              flex: 1,
            ),
          ],
        ),
      ),
    );
  }
}
