import 'package:flutter/material.dart';
import 'package:the_unnamed_startup/consultant_signup.dart';
import 'package:the_unnamed_startup/data/data.dart';

class UserProfile extends StatefulWidget {
  String text = 'Become a Consultant';
  Color color = Colors.amber[800];
  final callback;

  UserProfile(this.callback) {
    if (status == 'consultant') {
      text = 'Cancel Status';
      color = Colors.redAccent;
    }
  }

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  void become(context) {
    if (status == "normal") {
      Navigator.pushNamed(context, ConsultantSignUp.routeName).then((value) {
        setState(() {
          if (status == 'consultant') {
            widget.text = 'Cancel Status';
            widget.color = Colors.redAccent;
          }
        });
      });
    } else {
      setState(() {
        status = "normal";
        names.remove("Ray Doe");
        cardID.remove('Ray Doe');
        userId.remove('Ray Doe');
        widget.text = 'Become a Consultant';
        widget.color = Colors.amber[800];
        widget.callback();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          child: Column(children: [
            SizedBox(height: 80),
            CircleAvatar(
              backgroundImage: AssetImage('images/ray.png'),
              radius: 50,
            ),
            Container(
              child: Text(
                "Ray D.",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              margin: EdgeInsets.all(20),
            )
          ]),
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment(
                  0.8, 0.0), // 10% of the width, so there are ten blinds.
              colors: [
                Colors.lightGreen[200],
                Colors.lightGreen[300]
              ], // red to yellow
            ),
          ),
        ),
        SizedBox(height: 35),
        GestureDetector(
          onTap: () {
            setState(() {
              become(context);
            });
          },
          child: Container(
            child: Center(
              child: Text(widget.text, style: TextStyle(color: Colors.white)),
            ),
            margin: EdgeInsets.symmetric(horizontal: 100),
            height: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: widget.color,
            ),
          ),
        ),
        SizedBox(height: 20),
        ListTile(
          title: Text('Name: Ray D.', style: TextStyle(fontSize: 13)),
          contentPadding: EdgeInsets.only(left: 25),
          onTap: () {},
        ),
        ListTile(
          title: Text('Username: ilikenorman', style: TextStyle(fontSize: 13)),
          contentPadding: EdgeInsets.only(left: 25),
          onTap: () {},
        ),
        ListTile(
          title: Text('Age: 6', style: TextStyle(fontSize: 13)),
          contentPadding: EdgeInsets.only(left: 25),
          onTap: () {},
        ),
      ],
    );
  }
}
