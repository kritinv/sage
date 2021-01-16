import 'package:flutter/material.dart';
import 'package:the_unnamed_startup/time_slot.dart';
import 'package:the_unnamed_startup/main_pages/bookings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BookingArguments {
  final int selectedIndex;
  final Widget page;
  BookingArguments(this.selectedIndex, this.page);
}

class MeetingConfirmation extends StatelessWidget {
  static const routeName = '/meetingconfirmation';

  @override
  Widget build(BuildContext context) {
    final TimeSlotArguments args = ModalRoute.of(context).settings.arguments;
    final List<String> selectedSlots = args.timeSlots;
    selectedSlots.sort();
    final List<TimeCard> cardList =
        selectedSlots.map((time) => TimeCard(time)).toList();

    return Scaffold(
        appBar: AppBar(
          title: Text('Meeting Confirmation'),
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
        body: Column(children: [
          Expanded(
            child: ListView(
              children: [
                SizedBox(height: 30),
                Center(
                  child: Text(
                    'Note to Instructor',
                    //textAlign: TextAlign.start,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  child: TextFormField(
                    keyboardType: TextInputType.multiline,
                    minLines: 8,
                    maxLines: 20,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green))),
                  ),
                ),
                SizedBox(height: 20),
                Column(children: cardList),
                SizedBox(height: 40),
              ],
            ),
          ),
          ButtonTheme(
              minWidth: 150,
              height: 50,
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 30),
                child: RaisedButton(
                  onPressed: () {
                    // FirebaseFirestore.instance
                    //     .collection('users')
                    //     .doc(curentUser)
                    //     .add({})
                    //     .then((value) => print("User Added"))
                    //     .catchError(
                    //         (error) => print("Failed to add user: $error"));

                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pushNamed(context, "/",
                        arguments: BookingArguments(1, Bookings()));
                  },
                  textColor: Colors.white,
                  color: Colors.green,
                  onHighlightChanged: (boolValue) => print(boolValue),
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.green),
                  ),
                  child: new Text('Confirm'),
                ),
              ))
        ]));
  }
}

class TimeCard extends StatelessWidget {
  final String time;
  TimeCard(this.time);

  @override
  Widget build(BuildContext context) {
    return Center(
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
        "19 Oct 2050    ||    " + time,
        textAlign: TextAlign.center,
      ),
    ));
  }
}
