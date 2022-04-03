import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'package:sizer/sizer.dart';
import 'package:provider/provider.dart';
import 'package:settle_up/models/settle_brain.dart';
import 'constants/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return ChangeNotifierProvider(
          create: (context) => SettleBrain(),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData.light().copyWith(
              colorScheme:
                  ColorScheme.fromSwatch().copyWith(secondary: kblackColor),
            ),
            home: const HomeScreen(),
          ),
        );
      },
    );
  }
}
