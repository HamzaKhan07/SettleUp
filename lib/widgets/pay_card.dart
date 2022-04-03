import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:settle_up/constants/constants.dart';
import 'package:provider/provider.dart';
import 'package:settle_up/models/settle_brain.dart';

class PayCard extends StatelessWidget {
  final String nameToName;
  final String nameToAmount;

  const PayCard(
      {Key? key, required this.nameToName, required this.nameToAmount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
      height: 12.h,
      child: Container(
        decoration: BoxDecoration(
          color: klightblackColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(20.0),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(right: 6.0),
                child: Text(
                  nameToName.trim(),
                  style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16.0,
                      color: Colors.white,
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
                    '${Provider.of<SettleBrain>(context).getCurrencySymbol()}$nameToAmount',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        color: kgreenColor,
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
