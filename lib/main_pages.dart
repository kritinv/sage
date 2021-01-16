import 'package:flutter/material.dart';
import 'package:the_unnamed_startup/main_pages/completed.dart';
import 'package:the_unnamed_startup/main_pages/home.dart';
import 'package:the_unnamed_startup/main_pages/bookings.dart';
import 'package:the_unnamed_startup/main_pages/user_profile.dart';
import 'meeting_confirmation.dart';

class MainScreen extends StatefulWidget {
  static const routeName = '/mainscreen';
  int selectedIndex;
  Map userData;
  String currentUser;
  String imageURL;
  MainScreen(
      this.selectedIndex, this.currentUser, this.userData, this.imageURL);

  @override
  _MainScreenState createState() =>
      _MainScreenState(selectedIndex, currentUser, userData, imageURL);
}

class _MainScreenState extends State<MainScreen> {
  int count = 0;

  // variables initialized in constructor
  int selectedIndex;
  String imageURL;
  List names;
  String currentUser;

  // variables declared after stream is processed
  List filteredNames = [];
  Map cardID = {};
  Map userData = {};
  Widget page = Home(category: "All", key: UniqueKey());

  // constructor
  _MainScreenState(selectedIndex, currentUser, userData, imageURL) {
    this.imageURL = imageURL;
    this.selectedIndex = selectedIndex;
    this.currentUser = currentUser;
    this.userData = userData;
  }

  // filter cards by specialty category
  void filterByCategory(category) {
    filteredNames = [];
    for (int i = 0; i < names.length; i++) {
      List list = cardID[names[i]]['specialty'];
      if (list.contains(category)) {
        filteredNames.add(names[i]);
      }
    }
  }

  // callback for user profile becoming consultant
  void updateConsultantList() {
    setState(() {
      filteredNames = names;
    });
  }

  // callback for updating user profile image
  void updateDP(newImageURL) {
    setState(() {
      imageURL = newImageURL;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context).settings.arguments != null && count == 0) {
      BookingArguments args = ModalRoute.of(context).settings.arguments;
      page = args.page;
      selectedIndex = args.selectedIndex;
      count++;
    }
    print(imageURL);

    return Scaffold(
      body: page,
      backgroundColor: Colors.grey[200],
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              height: 100,
              child: DrawerHeader(
                child: Row(children: <Widget>[
                  CircleAvatar(backgroundImage: AssetImage('images/leaf.png')),
                  SizedBox(width: 10),
                  Container(
                    child: Text(
                      'Topics',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    alignment: Alignment.bottomLeft,
                    margin: EdgeInsets.only(bottom: 10),
                  ),
                ]),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment(
                        0.8, 0.0), // 10% of the width, so there are ten blinds.
                    colors: [
                      Colors.amber[800],
                      Colors.amber[900]
                    ], // red to yellow
                  ),
                ),
              ),
            ),
            ListTile(
              title: Text('All'),
              onTap: () {
                setState(() {
                  page = Home(category: 'All', key: UniqueKey());
                  Navigator.pop(context);
                });
              },
            ),
            ListTile(
                title: Text('Resume'),
                onTap: () {
                  setState(() {
                    page = Home(category: 'Resume', key: UniqueKey());
                    Navigator.pop(context);
                  });
                }),
            ListTile(
              title: Text('Interview'),
              onTap: () {
                setState(() {
                  page = Home(category: 'Interview', key: UniqueKey());
                  Navigator.pop(context);
                });
              },
            ),
            ListTile(
              title: Text('Essays'),
              onTap: () {
                setState(() {
                  page = Home(category: 'Essays', key: UniqueKey());
                  Navigator.pop(context);
                });
              },
            ),
            ListTile(
              title: Text('Extracurriculars'),
              onTap: () {
                setState(() {
                  page = Home(category: 'Extracurriculars', key: UniqueKey());
                  Navigator.pop(context);
                });
              },
            ),
            ListTile(
              title: Text('Community Service'),
              onTap: () {
                setState(() {
                  page = Home(category: "Community Service", key: UniqueKey());
                  Navigator.pop(context);
                });
              },
            ),
            ListTile(
              title: Text('Research'),
              onTap: () {
                setState(() {
                  page = Home(category: "Research", key: UniqueKey());
                  Navigator.pop(context);
                });
              },
            ),
            ListTile(
              title: Text('General Advice'),
              onTap: () {
                setState(() {
                  page = Home(category: 'General Advice', key: UniqueKey());
                  Navigator.pop(context);
                });
              },
            ),
            SizedBox(
              height: 30.0,
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.green[900],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: 'Bookings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle),
            label: 'Completed',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: selectedIndex,
        selectedItemColor: Colors.amber[800],
        unselectedItemColor: Colors.black45,
        unselectedLabelStyle: TextStyle(color: Colors.black45),
        onTap: (int index) {
          setState(
            () {
              selectedIndex = index;
              if (selectedIndex == 0) {
                page = Home(category: "All", key: UniqueKey());
              } else if (selectedIndex == 1) {
                page = Bookings();
              } else if (selectedIndex == 2) {
                page = Completed();
              } else if (selectedIndex == 3) {
                page = UserProfile(updateConsultantList, currentUser, userData,
                    imageURL, updateDP);
              }
            },
          );
        },
      ),
    );
  }
}
