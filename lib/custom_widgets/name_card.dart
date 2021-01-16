import 'package:flutter/material.dart';
import 'package:the_unnamed_startup/profile.dart';
import 'package:the_unnamed_startup/main_pages/home.dart';

class ScreenArguments {
  final String firstName;
  final String lastName;
  final String bio;
  final String rating;
  final String image;
  final List availability;
  ScreenArguments(this.firstName, this.lastName, this.bio, this.rating,
      this.image, this.availability);
}

class NameCard extends StatelessWidget {
  final firstName;
  final lastName;
  final bio;
  final rating;
  final imageURL;
  final availability;
  NetworkImage image;

  NameCard(
      {@required this.firstName,
      @required this.lastName,
      @required this.bio,
      @required this.rating,
      @required this.imageURL,
      @required this.availability});

  Future<String> downloadImage() async {
    image = NetworkImage(imageURL);
    image.resolve(ImageConfiguration()).addListener(
      ImageStreamListener(
        (info, call) {
          return 'image is fully loaded';
          // do something
        },
      ),
    );
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: downloadImage(),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasData) {
            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, Profile.routeName,
                    arguments: ScreenArguments(firstName, lastName, bio, rating,
                        imageURL, availability));
              },
              child: Card(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Row(
                    children: <Widget>[
                      CircleAvatar(
                        backgroundImage: NetworkImage(imageURL),
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
          } else {
            return LoadingScreen();
          }
        });
  }
}
