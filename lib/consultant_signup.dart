import 'package:flutter/material.dart';
import 'package:the_unnamed_startup/time_slot.dart';
import 'package:the_unnamed_startup/main_pages/user_profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ConsultantSignUp extends StatefulWidget {
  static const routeName = "/consultantsignup";
  final String title;
  ConsultantSignUp({Key key, this.title}) : super(key: key);
  @override
  _ConsultantSignUpState createState() => _ConsultantSignUpState();
}

class _ConsultantSignUpState extends State<ConsultantSignUp> {
  TextEditingController controller = TextEditingController();
  String time;
  String skill;
  String state;
  String skillState;
  List<String> times = [];
  List<String> skills = [];
  List<Widget> slots = [];
  List<Widget> specialties = [];
  List<String> selectedTimes = [];
  List<String> selectedSkills = [];

  void updateTime(String selected) {
    setState(() {
      time = selected;
    });
  }

  void updateSkill(String selected) {
    setState(() {
      skill = selected;
    });
  }

  void updateState(String selected) {
    setState(() {
      state = selected;
    });
  }

  void updateSkillState(String selected) {
    setState(() {
      skillState = selected;
    });
  }

  void updateSelected(String time, String state) {
    if (state == 'Selected') {
      selectedTimes.add(time);
    } else {
      selectedTimes.remove(time);
    }
  }

  void updateSelectedSkills(String skill, String state) {
    if (state == 'Selected') {
      selectedSkills.add(skill);
    } else {
      selectedSkills.remove(skill);
    }
  }

  _ConsultantSignUpState() {
    for (int i = 0; i < 24; i++) {
      if (i == 23) {
        times.add("23.00 - 0.00");
      } else {
        times.add(i.toString() + ".00 - " + i.toString() + ".30");
      }
    }

    for (int i = 0; i < times.length - 1; i += 2) {
      slots.add(
        SlotDouble(
          times[i],
          times[i + 1],
          (String time) {
            updateTime(time);
            updateSelected(time, state);
            print(selectedTimes);
          },
          (String state) {
            updateState(state);
          },
        ),
      );
    }

    skills = [
      'Resume',
      'Interview',
      'Essays',
      'Extracurriculars',
      'Community Service',
      'Research',
    ];

    for (int i = 0; i < 6 - 1; i += 2) {
      specialties.add(
        SlotDouble(
          skills[i],
          skills[i + 1],
          (String skill) {
            updateSkill(skill);
            updateSelectedSkills(skill, skillState);
            print(selectedSkills);
          },
          (String skill) {
            updateSkillState(skill);
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final UserData currentUserData = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios_rounded,
            ),
          ),
        ),
        body: Container(
          margin: const EdgeInsets.only(
              left: 20.0, right: 20.0, top: 20, bottom: 20),
          child: ListView(children: [
            SizedBox(
              height: 20.0,
            ),
            Text(
              'Available Times',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(height: 250, child: ListView(children: slots)),
            SizedBox(height: 40),
            Text(
              'Specialty',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(height: 250, child: Column(children: specialties)),
            SizedBox(
              height: 40.0,
            ),
            Text(
              'Caption',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20.0,
            ),
            TextFormField(
              controller: controller,
              keyboardType: TextInputType.multiline,
              minLines: 1,
              maxLines: 1,
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green))),
            ),
            SizedBox(height: 40),
            Center(
              child: ButtonTheme(
                  minWidth: 150,
                  height: 50,
                  child: RaisedButton(
                    onPressed: () async {
                      await FirebaseFirestore.instance
                          .collection('mentors')
                          .doc(currentUserData.currentUser)
                          .set({
                        "firstName": currentUserData.userData['firstName'],
                        'lastName': currentUserData.userData['lastName'],
                        'caption': controller.text,
                        'image': currentUserData.userData['imageURL'],
                        'rating': 'U',
                        'specialty': selectedSkills,
                        "availability": selectedTimes
                      });
                      Navigator.pop(context);
                    },
                    textColor: Colors.white,
                    color: Colors.green,
                    onHighlightChanged: (boolValue) => print(boolValue),
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.green),
                    ),
                    child: new Text('Join'),
                  )),
            ),
            SizedBox(height: 20)
          ]),
        ));
  }
}
