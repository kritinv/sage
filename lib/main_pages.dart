import 'package:flutter/material.dart';
import 'package:the_unnamed_startup/main_pages/completed.dart';
import 'package:the_unnamed_startup/main_pages/home.dart';
import 'package:the_unnamed_startup/main_pages/bookings.dart';
import 'package:the_unnamed_startup/data/data.dart';
import 'package:the_unnamed_startup/main_pages/user_profile.dart';
import 'meeting_confirmation.dart';
import 'package:provider/provider.dart';
import 'main.dart';
import 'login.dart';

class MainScreen extends StatefulWidget {
  static const routeName = '/mainscreen';
  int selectedIndex;
  MainScreen(this.selectedIndex);

  @override
  _MainScreenState createState() => _MainScreenState(selectedIndex);
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex;
  int count = 0;
  _MainScreenState(selectedIndex) {
    this.selectedIndex = selectedIndex;
  }

  Widget page = Home(filteredList: List<String>.from(names));
  List filteredNames = List<String>.from(names);

  void filterByCategory(category) {
    filteredNames = [];
    print(filteredNames);
    for (int i = 0; i < names.length; i++) {
      List list = cardID[names[i]]['specialty'];
      if (list.contains(category)) {
        filteredNames.add(names[i]);
      }
    }
    print(filteredNames);
  }

  void updateConsultantList() {
    setState(() {
      filteredNames = names;
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

    return Scaffold(
      body: page,
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.green[900],
      ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
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
                filteredNames = List<String>.from(names);
                setState(() {
                  page = Home(filteredList: filteredNames, key: UniqueKey());
                  Navigator.pop(context);
                });
              },
            ),
            ListTile(
                title: Text('Resume'),
                onTap: () {
                  filterByCategory('Resume');
                  setState(() {
                    page = Home(filteredList: filteredNames, key: UniqueKey());
                    Navigator.pop(context);
                  });
                }),
            ListTile(
              title: Text('Interview'),
              onTap: () {
                filterByCategory('Interview');
                setState(() {
                  page = Home(filteredList: filteredNames, key: UniqueKey());
                  Navigator.pop(context);
                });
              },
            ),
            ListTile(
              title: Text('Essays'),
              onTap: () {
                filterByCategory('Essays');
                setState(() {
                  page = Home(filteredList: filteredNames, key: UniqueKey());
                  Navigator.pop(context);
                });
              },
            ),
            ListTile(
              title: Text('Extracurriculars'),
              onTap: () {
                filterByCategory('Extracurriculars');
                setState(() {
                  page = Home(filteredList: filteredNames, key: UniqueKey());
                  Navigator.pop(context);
                });
              },
            ),
            ListTile(
              title: Text('Community Service'),
              onTap: () {
                filterByCategory('Community Service');
                setState(() {
                  page = Home(filteredList: filteredNames, key: UniqueKey());
                  Navigator.pop(context);
                });
              },
            ),
            ListTile(
              title: Text('Research'),
              onTap: () {
                filterByCategory('Research');
                setState(() {
                  page = Home(filteredList: filteredNames, key: UniqueKey());
                  Navigator.pop(context);
                });
              },
            ),
            ListTile(
              title: Text('General Advice'),
              onTap: () {
                filterByCategory('General Advice');
                setState(() {
                  page = Home(filteredList: filteredNames, key: UniqueKey());
                  Navigator.pop(context);
                });
              },
            ),
            SizedBox(
              height: 30.0,
            ),
            RaisedButton(
                child: Text(' Logout'),
                color: Color(0xffFF8F00),
                onPressed: () {
                  context.read<AuthenticationService>().signOut();
                }),
          ],
        ),
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
                page = Home(filteredList: filteredNames, key: UniqueKey());
              } else if (selectedIndex == 1) {
                page = Bookings();
              } else if (selectedIndex == 2) {
                page = Completed();
              } else if (selectedIndex == 3) {
                page = UserProfile(updateConsultantList);
              }
            },
          );
        },
      ),
    );
  }
}
