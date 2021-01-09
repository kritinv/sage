import 'package:flutter/material.dart';

class ScreenArguments {
  final String firstName;
  final String lastName;
  final String bio;
  final String rating;
  final String image;
  ScreenArguments(
      this.firstName, this.lastName, this.bio, this.rating, this.image);
}

class BookingCard extends StatelessWidget {
  final firstName;
  final lastName;
  final bio;
  final rating;
  final image;

  BookingCard(
      {@required this.firstName,
      @required this.lastName,
      @required this.bio,
      @required this.rating,
      @required this.image});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: AssetImage(image),
                    radius: 35,
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              firstName + " " + lastName[0] + ".",
                              style: TextStyle(fontSize: 16.0),
                            ),
                            Text(
                              bio,
                              style: TextStyle(fontSize: 12.0),
                            ),
                          ]),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Divider(
                thickness: 2,
                color: Colors.grey[200],
              ),
              SizedBox(height: 15),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 5),
                      child: Text(
                        "20th March",
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.lightGreen[200],
                        borderRadius: BorderRadius.circular(5),
                      ),
                      padding: EdgeInsets.all(8),
                      margin: EdgeInsets.only(right: 5),
                      child: Text(
                        "16:00 - 16.30",
                        style: TextStyle(
                          fontSize: 12.0,
                        ),
                      ),
                    ),
                  ]),
            ]),
      ),
    );
  }
}
