import 'package:flutter/material.dart';
import 'package:the_unnamed_startup/time_slot.dart';
import 'custom_widgets/name_card.dart';

class Profile extends StatelessWidget {
  static const routeName = '/profile';

  @override
  Widget build(BuildContext context) {
    final ScreenArguments args = ModalRoute.of(context).settings.arguments;
    Future<void> showMyDialog() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('AlertDialog Title'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Cannot meet with yourself!'),
                  Text('Click ok to continue'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green[900],
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios_rounded,
            ),
          ),
        ),
        body: Stack(
          children: [
            Container(
                alignment: Alignment.center,
                child: ListView(children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      new Container(
                        padding: EdgeInsets.fromLTRB(0, 40, 0, 20),
                        child: new Container(
                          child: new CircleAvatar(
                              radius: 100,
                              backgroundImage: AssetImage(args.image)),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: new Border.all(
                                width: 8, color: Colors.lightGreen[300]),
                          ),
                        ),
                      ),
                      new Container(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: new Text(
                          args.firstName + " " + args.lastName[0] + ".",
                          style: new TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      new Container(
                        height: 3.0,
                        width: 270.0,
                        decoration: BoxDecoration(
                          color: Colors.lightGreen[200],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Rating: " + args.rating,
                              ),
                              SizedBox(width: 15),
                              Text("|"),
                              SizedBox(width: 15),
                              Text("Price: " +
                                  new String.fromCharCodes(
                                      new Runes('\u0024')) +
                                  "5000 /hr"),
                            ]),
                      ),
                      new Container(
                        height: 3.0,
                        width: 270.0,
                        decoration: BoxDecoration(
                          color: Colors.lightGreen[200],
                        ),
                      ),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            new Container(
                              padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                              height: 250,
                              child: ListView(
                                  physics: NeverScrollableScrollPhysics(),
                                  children: [
                                    Text("Credentials:",
                                        style: new TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        )),
                                    Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(0, 0, 0, 10)),
                                    Text(args.bio),
                                  ]),
                            )
                          ]),
                      new Container(
                        height: 3.0,
                        width: 270.0,
                        decoration: BoxDecoration(
                          color: Colors.lightGreen[300],
                        ),
                      ),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            new Container(
                              padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                              height: 300,
                              child: ListView(
                                  physics: NeverScrollableScrollPhysics(),
                                  children: [
                                    Text("Special Note:",
                                        style: new TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        )),
                                    Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(0, 0, 0, 10)),
                                    Text("Sample"),
                                  ]),
                            )
                          ]),
                    ],
                  )
                ])),
            Positioned.directional(
                textDirection: TextDirection.rtl,
                bottom: 20,
                start: 20,
                child: new RaisedButton(
                  onPressed: () {
                    if (args.firstName + " " + args.lastName == "Ray Doe") {
                      showMyDialog();
                    } else {
                      Navigator.pushNamed(
                        context,
                        TimeSlot.routeName,
                        arguments: args,
                      );
                    }
                  },
                  textColor: Colors.green,
                  color: Colors.white,
                  onHighlightChanged: (boolValue) => print(boolValue),
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.green),
                  ),
                  child: new Text('meet'),
                )),
          ],
        ),
      ),
    );
  }
}
