import 'package:flutter/material.dart';
import 'package:the_unnamed_startup/consultant_signup.dart';
import 'package:the_unnamed_startup/login.dart';
import 'package:the_unnamed_startup/meeting_confirmation.dart';
import 'package:the_unnamed_startup/profile.dart';
import 'package:the_unnamed_startup/main_pages.dart';
import 'main_pages.dart';
import 'time_slot.dart';
import 'login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => Login(0),
          MainScreen.routeName: (context) => MainScreen(0),
          Profile.routeName: (context) => Profile(),
          TimeSlot.routeName: (context) => TimeSlot(),
          MeetingConfirmation.routeName: (context) => MeetingConfirmation(),
          ConsultantSignUp.routeName: (context) => ConsultantSignUp(),
        },
      ),
    );
  }
}
