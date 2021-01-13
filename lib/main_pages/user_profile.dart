import 'package:flutter/material.dart';
import 'package:the_unnamed_startup/consultant_signup.dart';
import 'package:the_unnamed_startup/data/data.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'dart:io';
import 'package:the_unnamed_startup/main_pages/editables/name_editable.dart';
import 'package:the_unnamed_startup/main_pages/editables/lastname_editable.dart';
import 'package:the_unnamed_startup/main_pages/editables/bio_editable.dart';

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
  String email = FirebaseAuth.instance.currentUser.email;
  String imageURL = "";
  File _image;

  _imgFromCamera() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);
    try {
      await firebase_storage.FirebaseStorage.instance
          .ref(email + ".png")
          .putFile(image);
      FirebaseFirestore.instance
          .collection('users')
          .doc(email)
          .update({'imageURL': email + ".png"});
    } on firebase_storage.FirebaseException catch (e) {
      print(e);
    }

    setState(() {
      _image = image;
    });
  }

  _imgFromGallery() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);
    try {
      await firebase_storage.FirebaseStorage.instance
          .ref(email + ".png")
          .putFile(image);
      FirebaseFirestore.instance
          .collection('users')
          .doc(email)
          .update({'imageURL': email + ".png"});
      print('updated');
    } on firebase_storage.FirebaseException catch (e) {
      print(e);
    }
    setState(() {
      _image = image;
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

  Future<String> downloadFileExample(email) async {
    imageURL = await firebase_storage.FirebaseStorage.instance
        .ref(email + ".png")
        .getDownloadURL();
    print(imageURL);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
        future: downloadFileExample(email),
        builder: (context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasData) {
            return Text(snapshot.data);
          } else {
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
                        child: (imageURL == "")
                            ? (_image != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: Image.file(
                                      _image,
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.fitHeight,
                                    ),
                                  )
                                : Container(
                                    decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    width: 100,
                                    height: 100,
                                    child: Icon(
                                      Icons.camera_alt,
                                      color: Colors.grey[800],
                                    ),
                                  ))
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.network(
                                  imageURL,
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                      ),
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
                      end: Alignment(0.8,
                          0.0), // 10% of the width, so there are ten blinds.
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
                      child: Text(widget.text,
                          style: TextStyle(color: Colors.white)),
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
                  title: Row(children: [
                    Expanded(
                        flex: 1,
                        child:
                            Text('First Name', style: TextStyle(fontSize: 13))),
                    Expanded(
                      flex: 2,
                      child: Container(
                          margin: EdgeInsets.only(right: 20),
                          child: Text('Ray', style: TextStyle(fontSize: 13))),
                    )
                  ]),
                  contentPadding: EdgeInsets.only(left: 25),
                  onTap: () {
                    Navigator.pushNamed(context, NameEditable.routeName);
                  },
                ),
                ListTile(
                  title: Row(children: [
                    Expanded(
                        flex: 1,
                        child:
                            Text('Last Name', style: TextStyle(fontSize: 13))),
                    Expanded(
                      flex: 2,
                      child: Container(
                          margin: EdgeInsets.only(right: 20),
                          child: Text('Doe', style: TextStyle(fontSize: 13))),
                    ),
                  ]),
                  contentPadding: EdgeInsets.only(left: 25),
                  onTap: () {
                    Navigator.pushNamed(context, LastNameEditable.routeName);
                  },
                ),
                ListTile(
                  title: Row(children: [
                    Expanded(
                        flex: 1,
                        child: Text('Bio', style: TextStyle(fontSize: 13))),
                    Expanded(
                      flex: 2,
                      child: Container(
                          margin: EdgeInsets.only(right: 20),
                          child: Text(
                              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed et mattis ante, et porta odio. Aenean convallis tincidunt sem, nec.',
                              style: TextStyle(fontSize: 13))),
                    ),
                  ]),
                  contentPadding: EdgeInsets.only(left: 25),
                  onTap: () {
                    Navigator.pushNamed(context, BioEditable.routeName);
                  },
                ),
              ],
            );
          }
        });
  }
}
