import 'package:flutter/material.dart';
import 'package:the_unnamed_startup/main_pages/user_profile.dart';
import 'package:the_unnamed_startup/time_slot.dart';
import 'package:the_unnamed_startup/meeting_confirmation.dart';
import 'package:the_unnamed_startup/main_pages/home.dart';
import 'package:the_unnamed_startup/data/data.dart';

class ConsultantSignUp extends StatefulWidget {
  static const routeName = "/consultantsignup";
  ConsultantSignUp({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _ConsultantSignUpState createState() => _ConsultantSignUpState();
}

class _ConsultantSignUpState extends State<ConsultantSignUp> {
  String time;
  String state;
  List<String> times = [];
  List<Widget> slots = [];
  List<String> selected = [];

  void updateTime(String selected) {
    setState(() {
      time = selected;
    });
  }

  void updateState(String selected) {
    setState(() {
      state = selected;
    });
  }

  void updateSelected(String time, String state) {
    if (state == 'Selected') {
      selected.add(time);
    } else {
      selected.remove(time);
    }
  }

  _ConsultantSignUpState() {
    for (int i = 0; i < 24; i++) {
      if (i == 23) {
        times.add("23.00 - 0.00");
      } else {
        times.add(i.toString() + ".00 - " + i.toString() + ".30");
      }
    }

    for (int i = 0; i < times.length - 1; i += 2) {
      slots.add(
        SlotDouble(
          times[i],
          times[i + 1],
          (String time) {
            updateTime(time);
            updateSelected(time, state);
            print(selected);
          },
          (String state) {
            updateState(state);
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios_rounded,
            ),
          ),
        ),
        body: Container(
          margin: const EdgeInsets.only(
              left: 20.0, right: 20.0, top: 20, bottom: 20),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: Container(child: ListView(children: slots))),
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
                Center(
                  child: ButtonTheme(
                      minWidth: 150,
                      height: 50,
                      child: RaisedButton(
                        onPressed: () {
                          names.add("Ray Doe");
                          cardID["Ray Doe"] = {
                            'firstName': 'Ray',
                            'lastName': 'Doe',
                            'bio': 'Genius Child',
                            'rating': '4.2',
                            'image': 'images/ray.png',
                            'specialty': [
                              'Extracurriculars',
                              'Community Service',
                            ],
                            "availability": selected
                          };
                          status = "consultant";
                          Navigator.pop(context);
                        },
                        textColor: Colors.white,
                        color: Colors.green,
                        onHighlightChanged: (boolValue) => print(boolValue),
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.green),
                        ),
                        child: new Text('Join'),
                      )),
                ),
                SizedBox(height: 20)
              ]),
        ));
  }
}
