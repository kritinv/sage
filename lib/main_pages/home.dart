import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:the_unnamed_startup/custom_widgets/name_card.dart';
import 'package:the_unnamed_startup/data/data.dart';
import 'dart:collection';

class Home extends StatefulWidget {
  const Home({Key key, this.filteredList}) : super(key: key);
  final List filteredList;
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // search bar variables
  final TextEditingController _filter = TextEditingController();
  String _searchText = '';
  String dropdownValue = 'Rating';
  List filteredNames;
  List<Widget> cardList;

  @override
  void initState() {
    filteredNames = widget.filteredList;
    sort('Rating');
    this.cardList = filteredNames
        .map((name) => NameCard(
            firstName: cardID[name]['firstName'],
            lastName: cardID[name]['lastName'],
            rating: cardID[name]['rating'],
            bio: cardID[name]['bio'],
            image: cardID[name]['image'],
            availability: cardID[name]['availability']))
        .toList();
    super.initState();
  }

  // search bar functions
  _HomeState() {
    print("new home object created");
    if (filteredNames == null) {
      filteredNames = List<String>.from(names);
    }
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
          filteredNames = names;
        });
      } else {
        setState(() {
          _searchText = _filter.text;
        });
      }
    });
  }

  void _buildList() {
    if (_searchText.isNotEmpty) {
      List tempList = List();
      for (int i = 0; i < filteredNames.length; i++) {
        if (filteredNames[i]
            .toLowerCase()
            .contains(_searchText.toLowerCase())) {
          tempList.add(filteredNames[i]);
        }
      }
      filteredNames = tempList;
    }
  }

  void _search(value) {
    _searchText = value;
    _buildList();
    setState(() {
      buildCardList();
    });
  }

  // filter function
  void sort(newValue) {
    dropdownValue = newValue;
    String split = newValue.split(" ").join();
    String join = split[0].toLowerCase() + split.substring(1, split.length);
    print(filteredNames);

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

  // card list functions
  void buildCardList() {
    cardList = filteredNames
        .map((name) => NameCard(
              firstName: cardID[name]['firstName'],
              lastName: cardID[name]['lastName'],
              rating: cardID[name]['rating'],
              bio: cardID[name]['bio'],
              image: cardID[name]['image'],
              availability: cardID[name]['availability'],
            ))
        .toList();
  }

  //***************************************************************************

  @override
  Widget build(BuildContext context) {
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
                  controller: _filter,
                  style: TextStyle(fontSize: 14.0),
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    border: InputBorder.none,
                    hintStyle: TextStyle(fontSize: 14.0),
                    contentPadding: EdgeInsets.only(bottom: 5.0),
                  ),
                  onChanged: (value) {
                    _search(value);
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
                          sort(newValue);
                          buildCardList();
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
        Expanded(
          child: Container(
            child: ListView(children: cardList),
          ),
        ),
      ],
    );
  }
}
