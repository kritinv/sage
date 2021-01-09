import 'package:flutter/material.dart';
import 'package:the_unnamed_startup/Eprofile.dart';

class ScreenArguments {
  final String firstName;
  final String lastName;
  final String bio;
  final String rating;
  final String image;
  ScreenArguments(
      this.firstName, this.lastName, this.bio, this.rating, this.image);
}

class NameCard extends StatelessWidget {
  final firstName;
  final lastName;
  final bio;
  final rating;
  final image;

  NameCard(
      {@required this.firstName,
      @required this.lastName,
      @required this.bio,
      @required this.rating,
      @required this.image});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, Profile.routeName,
            arguments:
                ScreenArguments(firstName, lastName, bio, rating, image));
      },
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Row(
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
                        Divider(
                          thickness: 3,
                          color: Colors.lightGreen,
                        ),
                        Text(
                          bio,
                          style: TextStyle(fontSize: 12.0),
                        ),
                      ]),
                ),
              ),
              CircleAvatar(
                radius: 25,
                backgroundColor: Colors.lightGreen,
                child: CircleAvatar(
                  radius: 22,
                  backgroundColor: Colors.white,
                  child: Text(rating.toString(),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
