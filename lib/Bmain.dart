import 'package:flutter/material.dart';
import 'package:the_unnamed_startup/Chome.dart';
import 'package:the_unnamed_startup/Eprofile.dart';

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
          '/': (context) => Scaffold(
                backgroundColor: Colors.grey[200],
                appBar: AppBar(
                  backgroundColor: Colors.green[900],
                ),
                body: Home(),
              ),
          Profile.routeName: (context) => Profile(),
        },
      ),
    );
  }
}
