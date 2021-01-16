import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Select a time slot',
      home: MyHomePage(title: 'Open an Appointment'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DateTime selectedDate = DateTime.now();
  final DateTime nowTime = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  TimeOfDay selectedendTime = TimeOfDay.now();
  _selectendTime(BuildContext context) async {
    final TimeOfDay pickedTime = await showTimePicker(
        context: context,
        initialTime: selectedendTime,
        builder: (BuildContext context, Widget child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
            child: child,
          );
        });

    if (pickedTime != null && pickedTime != selectedTime)
      setState(() {
        selectedTime = pickedTime;
      });
  }

  _selectTime(BuildContext context) async {
    final TimeOfDay pickedTime = await showTimePicker(
        context: context,
        initialTime: selectedTime,
        builder: (BuildContext context, Widget child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
            child: child,
          );
        });

    if (pickedTime != null && pickedTime != selectedTime)
      setState(() {
        selectedTime = pickedTime;
      });
  }

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: nowTime,
      lastDate: selectedDate.add(Duration(days: 365)),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Open Appointment Slot"),
          backgroundColor: Colors.green,
          leading: Icon(
            Icons.arrow_back_ios_rounded,
          ),
        ),
        body: Container(
            margin: const EdgeInsets.only(
                left: 20.0, right: 20.0, top: 20, bottom: 20),
            child: ListView(children: [
              Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                        child: Column(children: [
                      Text(
                        "${"${selectedDate.toLocal().day.toString()}-${selectedDate.toLocal().month.toString().padLeft(2, '0')}-${selectedDate.toLocal().year.toString().padLeft(2, '0')}"}"
                            .split(' ')[0],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 6.0,
                      ),
                      RaisedButton(
                        onPressed: () => _selectDate(context), // Refer step 3
                        child: Text(
                          'Select date',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        color: Colors.greenAccent,
                      ),
                    ])),
                    SizedBox(
                      height: 30.0,
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Center(
                          child: Column(children: [
                        Text(
                          "${selectedTime.format(context)}".split(' ')[0],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 6.0,
                        ),
                        RaisedButton(
                          onPressed: () => _selectTime(context), // Refer step 3
                          child: Text(
                            'Select Start Time',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          color: Colors.greenAccent,
                        ),
                      ])),
                      SizedBox(
                        width: 20.0,
                      ),
                      Center(
                          child: Column(children: [
                        Text(
                          "${selectedendTime.format(context)}".split(' ')[0],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 6.0,
                        ),
                        RaisedButton(
                          onPressed: () =>
                              _selectendTime(context), // Refer step 3
                          child: Text(
                            'Select End Time',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          color: Colors.greenAccent,
                        ),
                      ]))
                    ]),
                    SizedBox(
                      height: 30.0,
                    ),
                    Text(
                      'Subject',
                      textAlign: TextAlign.start,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.green)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.green))),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      'Special Note',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextFormField(
                      keyboardType: TextInputType.multiline,
                      minLines: 1,
                      maxLines: 10,
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
                          child: new Text('Open Appointment'),
                        ))
                  ]),
            ])));
  }
}
