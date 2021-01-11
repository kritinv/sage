import 'package:flutter/material.dart';
import '../custom_widgets/booking_card.dart';
import 'package:the_unnamed_startup/data/data.dart';

class Bookings extends StatefulWidget {
  Bookings() {
    print("Bookings Object Created");
  }

  @override
  _BookingsState createState() => _BookingsState();
}

class _BookingsState extends State<Bookings> {
  List cardList;

  void reload() {
    setState(() {
      this.cardList = userId
          .map((name) => BookingCard(
              firstName: cardID[name]['firstName'],
              lastName: cardID[name]['lastName'],
              rating: cardID[name]['rating'],
              bio: cardID[name]['bio'],
              image: cardID[name]['image'],
              reload: reload))
          .toList();
      print(userId);
    });
  }

  _BookingsState() {
    print(cardID);
    print(userId);
    print(names);
    this.cardList = userId
        .map((name) => BookingCard(
            firstName: cardID[name]['firstName'],
            lastName: cardID[name]['lastName'],
            rating: cardID[name]['rating'],
            bio: cardID[name]['bio'],
            image: cardID[name]['image'],
            reload: reload))
        .toList();
    print(userId);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        SizedBox(
          height: 20,
        ),
        // Card List
        Expanded(
          child: Container(
            child: ListView(children: cardList),
          ),
        ),
      ],
    );
  }
}
