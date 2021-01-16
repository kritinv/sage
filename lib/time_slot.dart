import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:the_unnamed_startup/custom_widgets/name_card.dart';
import 'package:the_unnamed_startup/meeting_confirmation.dart';

typedef void StringCallBack(String time);
typedef void StateCallBack(String state);

class TimeSlotArguments {
  List<String> timeSlots;
  ScreenArguments arg;
  TimeSlotArguments(this.timeSlots, this.arg);
}

class TimeSlot extends StatefulWidget {
  static const routeName = '/timeslot';
  @override
  _TimeSlot createState() => _TimeSlot();
}

class _TimeSlot extends State<TimeSlot> {
  String time;
  String state;
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

  //***************************************************************************
  @override
  Widget build(BuildContext context) {
    final ScreenArguments args = ModalRoute.of(context).settings.arguments;
    if (args.availability.length == 0) {
      slots.add(Text('No Available Spots Today'));
    } else if (args.availability.length % 2 == 0) {
      for (int i = 0; i < args.availability.length - 1; i += 2) {
        slots.add(SlotDouble(args.availability[i], args.availability[i + 1],
            (String time) {
          updateTime(time);
          updateSelected(time, state);
          print(selected);
        }, (String state) {
          updateState(state);
        }));
      }
    } else {
      for (int i = 0; i < args.availability.length - 2; i += 2) {
        slots.add(
          SlotDouble(args.availability[i], args.availability[i + 1],
              (String time) {
            updateTime(time);
            updateSelected(time, state);
            print(selected);
          }, (String state) {
            updateState(state);
          }),
        );
      }
      slots.add(SlotSingle(args.availability[args.availability.length - 1],
          (String time) {
        updateTime(time);
        updateSelected(time, state);
        print(selected);
      }, (String state) {
        updateState(state);
      }));
    }

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green[900],
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios_rounded,
            ),
          ),
        ),
        body: Column(children: [
          Expanded(
            child: ListView(
              children: slots,
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, MeetingConfirmation.routeName,
                  arguments: TimeSlotArguments(selected, args));
            },
            child: Container(
              child: Center(
                child: Text("Book Now", style: TextStyle(color: Colors.white)),
              ),
              margin: EdgeInsets.symmetric(horizontal: 50, vertical: 50),
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.amber[800],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

//ListView(children: cardList)
class SlotDouble extends StatefulWidget {
  final String text1;
  final String text2;
  final StringCallBack onSonChanged;
  final StateCallBack onStateChanged;

  SlotDouble(this.text1, this.text2, this.onSonChanged, this.onStateChanged);

  @override
  _SlotDoubleState createState() => _SlotDoubleState();
}

class _SlotDoubleState extends State<SlotDouble> {
  double radiusOne = 0;
  double radiusTwo = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: GestureDetector(
              onTap: () {
                if (radiusOne == 0) {
                  setState(() {
                    radiusOne = 2;
                    widget.onStateChanged('Selected');
                    widget.onSonChanged(widget.text1);
                  });
                } else {
                  setState(() {
                    radiusOne = 0;
                    widget.onStateChanged('Canceled');
                    widget.onSonChanged(widget.text1);
                  });
                }
              },
              child: Container(
                height: 60,
                child: Card(
                  child: Center(child: Text(widget.text1)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: BorderSide(
                      color: Colors.blue,
                      width: radiusOne,
                    ),
                  ),
                  color: Colors.lightGreen[200],
                ),
                margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                if (radiusTwo == 0) {
                  setState(() {
                    radiusTwo = 2;
                    widget.onStateChanged('Selected');
                    widget.onSonChanged(widget.text2);
                  });
                } else {
                  setState(() {
                    radiusTwo = 0;
                    widget.onStateChanged('Canceled');
                    widget.onSonChanged(widget.text2);
                  });
                }
              },
              child: Container(
                height: 60,
                child: Card(
                  child: Center(child: Text(widget.text2)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: BorderSide(
                      color: Colors.blue,
                      width: radiusTwo,
                    ),
                  ),
                  color: Colors.lightGreen[200],
                ),
                margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
              ),
            ),
          ),
        ]);
  }
}

class SlotSingle extends StatefulWidget {
  final String text;
  final StringCallBack onSonChanged;
  final StateCallBack onStateChanged;
  SlotSingle(this.text, this.onSonChanged, this.onStateChanged);

  @override
  _SlotSingleState createState() => _SlotSingleState();
}

class _SlotSingleState extends State<SlotSingle> {
  double radius = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: GestureDetector(
              onTap: () {
                if (radius == 0) {
                  setState(() {
                    radius = 2;
                    widget.onStateChanged('Selected');
                    widget.onSonChanged(widget.text);
                  });
                } else {
                  setState(() {
                    radius = 0;
                    widget.onStateChanged('Cancelled');
                    widget.onSonChanged(widget.text);
                  });
                }
              },
              child: Container(
                height: 60,
                child: Card(
                  child: Center(child: Text(widget.text)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: BorderSide(
                      color: Colors.blue,
                      width: radius,
                    ),
                  ),
                  color: Colors.lightGreen[200],
                ),
                margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
              ),
            ),
          ),
          Expanded(
            child: Opacity(
              opacity: 0.0,
              child: Container(
                height: 60,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  color: Colors.grey[200],
                ),
                margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
              ),
            ),
          ),
        ]);
  }
}
