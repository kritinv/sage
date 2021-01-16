import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:the_unnamed_startup/custom_widgets/name_card.dart';
import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatefulWidget {
  final String category;
  const Home({Key key, @required this.category}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController filter;
  String dropdownValue;
  Map cardID;
  List filteredNames;
  List names;
  Widget cardList;
  String category;

  // constructor
  @override
  void initState() {
    print("Home Page Object Created");
    filter = TextEditingController();
    dropdownValue = "Rating";
    // stream variables
    cardID = {};
    filteredNames = [];
    names = [];
    // category
    print("hi");
  }

  @override
  Widget build(BuildContext context) {
    category = widget.category;
    cardList = ClassList("", dropdownValue, category);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        // search bar
        Container(
            child: Container(
              width: double.infinity,
              margin: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(5.0))),
              child: Container(
                margin: EdgeInsets.only(left: 12),
                child: TextField(
                  textInputAction: TextInputAction.search,
                  controller: filter,
                  style: TextStyle(fontSize: 14.0),
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    border: InputBorder.none,
                    hintStyle: TextStyle(fontSize: 14.0),
                    contentPadding: EdgeInsets.only(bottom: 5.0),
                  ),
                  onChanged: (value) {
                    setState(() {
                      cardList =
                          ClassList(filter.text, dropdownValue, category);
                    });
                  },
                ),
              ),
            ),
            width: double.infinity,
            height: 80.0,
            color: Colors.lightGreen[300]),

        // filter
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: dropdownValue,
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.black54,
                      ),
                      iconSize: 24,
                      elevation: 16,
                      style: TextStyle(
                        color: Colors.black54,
                      ),
                      onChanged: (String newValue) {
                        setState(() {
                          dropdownValue = newValue;
                          cardList = ClassList(filter.text, newValue, category);
                        });
                      },
                      items: <String>[
                        'Rating',
                        'First Name',
                        'Last Name',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
              width: 120.0,
              height: 35.0,
              decoration: BoxDecoration(
                color: Colors.lightGreen[200],
                borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(10)),
              ),
            ),
          ],
        ),

        SizedBox(
          height: 20,
        ),

        // Card List
        cardList,
      ],
    );
  }
}

class ClassList extends StatefulWidget {
  String searchText;
  String sortBy;
  String category;
  ClassList(this.searchText, this.sortBy, this.category);
  @override
  _ClassListState createState() => _ClassListState();
}

class _ClassListState extends State<ClassList> {
  Map cardID = {};
  List filteredNames = [];
  List<NameCard> cardList = [];
  List names = []
  CollectionReference users;

  void sort(newValue) {
    String split = newValue.split(" ").join();
    String join = split[0].toLowerCase() + split.substring(1, split.length);
    List sortedList = filteredNames.map((name) => cardID[name][join]).toList();
    Map mappings = {
      for (int i = 0; i < sortedList.length; i++)
        filteredNames[i]: sortedList[i]
    };
    var sortedKeys = mappings.keys.toList(growable: false)
      ..sort((k1, k2) => mappings[k1].compareTo(mappings[k2]));
    LinkedHashMap sortedMap = new LinkedHashMap.fromIterable(sortedKeys,
        key: (k) => k, value: (k) => mappings[k]);
    if (join == 'rating') {
      filteredNames = sortedMap.keys.toList().reversed.toList();
    } else {
      filteredNames = sortedMap.keys.toList();
    }
  }

  void filterByCategory(category) {
    if (category != 'All') {
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
  }

  Future<String> downloadUserData() {
    users = FirebaseFirestore.instance.collection('mentors');

  }

  @override
  Widget build(BuildContext context) {

    Stopwatch watch = new Stopwatch();

    return StreamBuilder<QuerySnapshot>(
        stream: users.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Container();
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            if (watch.elapsedMilliseconds <= 100) {
              return Container();
            } else {
              return Expanded(
                child: Container(
                  child: ListView(
                    children: List.filled(10, LoadingScreen()),
                  ),
                ),
              );
            }
          }

          z

          names = cardID.keys.toList();
          filteredNames = cardID.keys.toList();
          filterByCategory(widget.category);

          if (widget.searchText.isNotEmpty || widget.searchText != "") {
            List tempList = List();
            for (int i = 0; i < filteredNames.length; i++) {
              if (filteredNames[i]
                  .toLowerCase()
                  .contains(widget.searchText.toLowerCase())) {
                tempList.add(filteredNames[i]);
              }
            }
            filteredNames = tempList;
          }

          sort(widget.sortBy);

          cardList = filteredNames
              .map((name) => NameCard(
                  firstName: cardID[name]['firstName'],
                  lastName: cardID[name]['lastName'],
                  rating: cardID[name]['rating'],
                  bio: cardID[name]['caption'],
                  imageURL: cardID[name]['image'],
                  availability: cardID[name]['availability']))
              .toList();

          return Expanded(
              child: Container(child: ListView(children: cardList)));
        });
  }
}

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Row(
          children: <Widget>[
            CircleAvatar(
              backgroundColor: Colors.lightGreen[200],
              radius: 35,
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 50,
                        height: 20,
                        decoration: BoxDecoration(
                            color: Colors.lightGreen[200],
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      Divider(
                        thickness: 3,
                        color: Colors.lightGreen[200],
                      ),
                      Container(
                        width: 80,
                        height: 15,
                        decoration: BoxDecoration(
                            color: Colors.lightGreen[200],
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ]),
              ),
            ),
            CircleAvatar(
              radius: 25,
              backgroundColor: Colors.lightGreen[200],
            ),
          ],
        ),
      ),
    );
  }
}
