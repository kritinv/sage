import 'package:flutter/material.dart';
import 'package:the_unnamed_startup/main_pages/user_profile.dart';

class NameEditable extends StatelessWidget {
  static const routeName = '/nameeditable';
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Input args = ModalRoute.of(context).settings.arguments;
    controller.text = args.firstName;
    print(args);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green[900],
          actions: <Widget>[
            GestureDetector(
              child: Container(
                margin: EdgeInsets.fromLTRB(0, 20, 20, 0),
                child: Text("Done", style: TextStyle(fontSize: 16)),
              ),
              onTap: () {
                args.callback(controller.text);
                Navigator.pop(context);
              },
            )
          ],
        ),
        body: Column(
          children: [
            Container(
              width: double.infinity,
              color: Colors.grey[200],
              margin: EdgeInsets.only(left: 13),
              padding: EdgeInsets.only(top: 4),
              height: 15,
              child: Text('First Name',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  )),
            ),
            Container(
                child: TextField(
              controller: controller,
              decoration: new InputDecoration(
                filled: true,
                fillColor: Colors.grey[200],
              ),
            )),
          ],
        ));
  }
}
