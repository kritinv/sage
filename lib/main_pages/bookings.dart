import 'package:flutter/material.dart';
import 'custom_widgets/booking_card.dart';

class Bookings extends StatelessWidget {
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
            child: ListView(children: <Widget>[
              BookingCard(
                  firstName: 'Katsuki',
                  lastName: 'Bakugo',
                  bio: 'Dumbass',
                  rating: '2.4',
                  image: 'images/bakugo.jpg'),
              BookingCard(
                  firstName: 'Jotaro',
                  lastName: 'Kujo',
                  bio: 'Muda',
                  rating: '5.6',
                  image: 'images/jotaro.jpg')
            ]),
          ),
        ),
      ],
    );
  }
}
