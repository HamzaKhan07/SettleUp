import 'package:flutter/material.dart';
import 'package:settle_up/constants/constants.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';

class HomeCard extends StatelessWidget {
  final String expenseName;
  final String category;
  final String date;
  final VoidCallback onPress;
  final VoidCallback onLongTap;

  const HomeCard(
      {Key? key,
      required this.expenseName,
      required this.category,
      required this.date,
      required this.onPress,
      required this.onLongTap})
      : super(key: key);

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

  bool checkDate(date) {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('MMM d');
    final String formatted = formatter.format(now);
    if (date.toString().trim() == formatted) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: onLongTap,
      onTap: onPress,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        decoration: BoxDecoration(
          color: ksilverColor,
          borderRadius: const BorderRadius.all(Radius.circular(15.0)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 12.h,
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      child: Center(
                        child: Text(
                          getCategorySymbol(category.trim()),
                          style: const TextStyle(
                            fontSize: 32,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            expenseName.trim(),
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 18.0,
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: const EdgeInsets.only(right: 12.0),
                      child: Center(
                        child: Text(
                          checkDate(date) == true
                              ? 'Today'
                              : date.toString().trim(),
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
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
