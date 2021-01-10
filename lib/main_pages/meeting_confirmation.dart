import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
          appBar: AppBar(
            title: Text('Meeting Confirmation'),
            backgroundColor: Colors.green,
            leading: Icon(
              Icons.arrow_back_ios_rounded,
            ),
          ),
          body: Container(
              margin: const EdgeInsets.only(
                  left: 20.0, right: 20.0, top: 20, bottom: 20),
              child: ListView(children: [
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Center(
                      child: Container(
                    alignment: Alignment.center,
                    height: 60,
                    width: 280,
                    margin: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.green,
                        width: 4,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      "19 Oct 2050    ||    14:00 - 16:00",
                      textAlign: TextAlign.center,
                    ),
                  )),
                  SizedBox(height: 20),
                  Text(
                    'Note to Instructor',
                    //textAlign: TextAlign.start,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.multiline,
                    minLines: 15,
                    maxLines: 20,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green))),
                  ),
                  SizedBox(height: 40),
                  ButtonTheme(
                      minWidth: 150,
                      height: 50,
                      child: RaisedButton(
                        onPressed: () => print("Button Pressed"),
                        textColor: Colors.white,
                        color: Colors.green,
                        onHighlightChanged: (boolValue) => print(boolValue),
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.green),
                        ),
                        child: new Text('Book'),
                      ))
                ]),
              ]))),
    );
  }
}
