import 'package:flutter/material.dart';
import '../custom_widgets/booking_card.dart';

class Completed extends StatelessWidget {
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
                  firstName: 'Nam',
                  lastName: 'San',
                  bio: 'Data Scientist',
                  rating: '2.6',
                  image: 'images/namdosan_is_lucky.jpg'),
              BookingCard(
                  firstName: 'Sasuke',
                  lastName: 'Uchida',
                  bio: 'Traitor',
                  rating: '3.4',
                  image: 'images/sasuke.jpg')
            ]),
          ),
        ),
      ],
    );
  }
}
