import 'package:flutter/material.dart';
import 'package:the_unnamed_startup/consultant_signup.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:the_unnamed_startup/main_pages/editables/name_editable.dart';
import 'package:the_unnamed_startup/main_pages/editables/lastname_editable.dart';
import 'package:the_unnamed_startup/main_pages/editables/bio_editable.dart';
import 'package:the_unnamed_startup/main.dart';
import 'package:provider/provider.dart';

class Input {
  Function callback;
  String firstName;
  String lastName;
  String bio;
  String currentUser;
  Input({this.callback, this.firstName, this.lastName, this.bio});
}

class UserData {
  Map userData;
  String currentUser;
  UserData(this.userData, this.currentUser);
}

class UserProfile extends StatefulWidget {
  String text = 'Become a Consultant';
  Color color = Colors.amber[800];
  String currentUser;
  String imageURL;
  Map userData;
  final callback;
  final imageCallBack;

  UserProfile(this.callback, this.currentUser, this.userData, this.imageURL,
      this.imageCallBack) {
    if (userData['status'] == 'consultant') {
      text = 'Cancel Status';
      color = Colors.redAccent;
    }
    print(imageURL);
  }
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  void changeFirstName(String newFirstName) {
    setState(() {
      widget.userData['firstName'] = newFirstName;
      FirebaseFirestore.instance
          .collection('users')
          .doc(widget.currentUser)
          .update({'firstName': newFirstName});
      print(widget.userData['firstName']);
    });
  }

  void changeLastName(String newLastName) {
    setState(() {
      widget.userData['lastName'] = newLastName;
      print(widget.userData['lastName']);
    });
    FirebaseFirestore.instance
        .collection('users')
        .doc(widget.userData['lastName'])
        .update({'lastName': newLastName});
    print(widget.userData['lastName']);
    print(widget.imageURL);
  }

  void changeBio(String newBio) {
    setState(() {
      widget.userData['bio'] = newBio;
      print(widget.userData['bio']);
    });
    FirebaseFirestore.instance
        .collection('users')
        .doc(widget.currentUser)
        .update({'bio': newBio});
  }

  _imgFromCamera() async {
    PickedFile pickedImage = await ImagePicker()
        .getImage(source: ImageSource.camera, imageQuality: 50);
    File image = File(pickedImage.path);
    await firebase_storage.FirebaseStorage.instance
        .ref(widget.currentUser + ".png")
        .putFile(image);
    print('done');
    await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.currentUser)
        .update({'imageURL': widget.currentUser + ".png"});
    widget.userData['imageURL'] = widget.currentUser + ".png";
    print('done');
    widget.imageURL = await firebase_storage.FirebaseStorage.instance
        .ref(widget.currentUser + ".png")
        .getDownloadURL();
    widget.imageCallBack(widget.imageURL);
    setState(() {
      widget.imageURL = widget.imageURL;
      print(widget.imageURL);
    });
  }

  _imgFromGallery() async {
    // pick image from camera roll
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    final File image = File(pickedFile.path);

    // upload image to firebase storage with file name as user id
    await firebase_storage.FirebaseStorage.instance
        .ref(widget.currentUser + ".png")
        .putFile(image);
    print(widget.currentUser);
    print("ok");

    // update image URL in firestore (for first time with ray dp)
    await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.currentUser)
        .update({'imageURL': widget.currentUser + ".png"});

    // get image network URL from firebase storage
    widget.imageURL = await firebase_storage.FirebaseStorage.instance
        .ref(widget.currentUser + ".png")
        .getDownloadURL();

    // update imageURL value in main page
    widget.imageCallBack(widget.imageURL);
    print(widget.imageURL);

    // set picture state of current userprofile
    setState(() {
      widget.imageURL = widget.imageURL;
    });
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: [
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  void become(context) {
    if (widget.userData['status'] == "normal") {
      Navigator.pushNamed(context, ConsultantSignUp.routeName,
              arguments: UserData(widget.userData, widget.currentUser))
          .then((value) {
        setState(() {
          if (widget.userData['status'] == 'consultant') {
            widget.text = 'Cancel Status';
            widget.color = Colors.redAccent;
          }
        });
      });
    } else {
      setState(() async {
        widget.userData['status'] = "normal";
        widget.text = 'Become a Consultant';
        widget.color = Colors.amber[800];
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
            GestureDetector(
              onTap: () {
                _showPicker(context);
              },
              child: CircleAvatar(
                radius: 55,
                backgroundColor: Color(0xffFDCF09),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.network(
                    widget.imageURL,
                    width: 100,
                    height: 100,
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
            ),
            Container(
              child: Text(
                '${widget.userData['firstName'][0].toUpperCase()}${widget.userData['firstName'].substring(1)}' +
                    " ${widget.userData['lastName'][0].toUpperCase()}.",
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
          title: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                    flex: 1,
                    child: Text('First Name', style: TextStyle(fontSize: 13))),
                Expanded(
                  flex: 2,
                  child: Container(
                      margin: EdgeInsets.only(right: 20),
                      child: Text(widget.userData['firstName'],
                          style: TextStyle(fontSize: 13))),
                )
              ]),
          contentPadding: EdgeInsets.only(left: 25),
          onTap: () {
            Navigator.pushNamed(context, NameEditable.routeName,
                arguments: Input(
                    callback: changeFirstName,
                    firstName: widget.userData['firstName']));
          },
        ),
        ListTile(
          title: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                    flex: 1,
                    child: Text('Last Name', style: TextStyle(fontSize: 13))),
                Expanded(
                  flex: 2,
                  child: Container(
                      margin: EdgeInsets.only(right: 20),
                      child: Text(widget.userData['lastName'],
                          style: TextStyle(fontSize: 13))),
                ),
              ]),
          contentPadding: EdgeInsets.only(left: 25),
          onTap: () {
            Navigator.pushNamed(context, LastNameEditable.routeName,
                arguments: Input(
                    callback: changeLastName,
                    lastName: widget.userData['lastName']));
          },
        ),
        ListTile(
          title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    flex: 1,
                    child: Text('Bio', style: TextStyle(fontSize: 13))),
                Expanded(
                  flex: 2,
                  child: Container(
                      margin: EdgeInsets.only(right: 20),
                      child: Text(widget.userData['bio'],
                          style: TextStyle(fontSize: 13))),
                ),
              ]),
          contentPadding: EdgeInsets.only(left: 25),
          onTap: () {
            Navigator.pushNamed(context, BioEditable.routeName,
                arguments:
                    Input(callback: changeBio, bio: widget.userData['bio']));
          },
        ),
        SizedBox(height: 40),
        GestureDetector(
          onTap: () {
            context.read<AuthenticationService>().signOut();
          },
          child: Container(
            child: Center(
              child: Text("Sign Out", style: TextStyle(color: Colors.white)),
            ),
            margin: EdgeInsets.symmetric(horizontal: 120),
            height: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.green[800],
            ),
          ),
        ),
        SizedBox(height: 40),
      ],
    );
  }
}
