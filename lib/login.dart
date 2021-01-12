import 'package:flutter/material.dart';
import 'package:the_unnamed_startup/main.dart';
import 'package:provider/provider.dart';
import 'main.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  Widget inputForm;
  Widget spacer = SizedBox(height: 20);

  @override
  void initState() {
    super.initState();
    inputForm = LoginForm(toSignUp);
  }

  void toLogIn() {
    setState(() {
      inputForm = LoginForm(toSignUp);
    });
  }

  void toSignUp() {
    setState(() {
      inputForm = SignUp(toLogIn);
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.all(50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            spacer,
            spacer,
            Container(
              padding: EdgeInsets.only(bottom: 20),
              child: Image.asset(
                'images/logo.PNG',
                fit: BoxFit.fitWidth,
                width: 160,
              ),
            ),
            SizedBox(height: 20),
            Container(child: inputForm),
          ],
        ),
      ),
    );
  }
}

class SignUp extends StatefulWidget {
  final Function stateChange;
  SignUp(this.stateChange);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final Widget inputSpacer = SizedBox(height: 20.0);
  String errorMessage = "";

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Input(textState: false, hintText: "First Name", controller: firstName),
      inputSpacer,
      Input(textState: false, hintText: "Last Name", controller: lastName),
      inputSpacer,
      Input(textState: false, hintText: "Email", controller: email),
      inputSpacer,
      Input(textState: true, hintText: "Password", controller: password),
      inputSpacer,
      Container(
        width: double.infinity,
        child: RaisedButton(
            child: Text(' Sign Up'),
            color: Color(0xffFF8F00),
            onPressed: () async {
              String a = await context.read<AuthenticationService>().signUp(
                    email: email.text.trim(),
                    password: password.text.trim(),
                  );
              setState(() {
                errorMessage = a;
              });
            }),
      ),
      Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(
          'Forget password?',
          style: TextStyle(fontSize: 12.0),
        ),
      ),
      SizedBox(height: 20.0),
      GestureDetector(
        onTap: () {
          widget.stateChange();
        },
        child: Text.rich(
          TextSpan(text: 'Already have an account', children: [
            TextSpan(
              text: ' Sign In',
              style: TextStyle(color: Color(0xffFF8F00)),
            ),
          ]),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(top: 30),
        child: Text(
          errorMessage,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.amber[800],
            fontSize: 10,
          ),
        ),
      )
    ]);
  }
}

class LoginForm extends StatefulWidget {
  final Function changeState;
  LoginForm(this.changeState);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final Widget spacer = SizedBox(height: 20.0);
  String errorMessage = "";

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Input(textState: false, hintText: "Email", controller: email),
      spacer,
      Input(textState: true, hintText: "Password", controller: password),
      spacer,
      Container(
        width: double.infinity,
        child: RaisedButton(
          child: Text('Login'),
          color: Color(0xffFF8F00),
          onPressed: () async {
            String a = await context.read<AuthenticationService>().signIn(
                  email: email.text.trim(),
                  password: password.text.trim(),
                );
            setState(() {
              errorMessage = a;
            });
          },
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(
          'Forget password?',
          style: TextStyle(fontSize: 12.0),
        ),
      ),
      spacer,
      GestureDetector(
        onTap: () {
          widget.changeState();
        },
        child: Text.rich(
          TextSpan(text: 'Don\'t have an account', children: [
            TextSpan(
              text: ' Sign Up',
              style: TextStyle(color: Color(0xffFF8F00)),
            ),
          ]),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(top: 30),
        child: Text(
          errorMessage,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.amber[800],
            fontSize: 10,
          ),
        ),
      )
    ]);
  }
}

class Input extends StatelessWidget {
  final bool textState;
  final String hintText;
  final TextEditingController controller;
  Input({this.textState, this.hintText, this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      child: TextField(
        controller: controller,
        obscureText: textState,
        decoration: InputDecoration(
          fillColor: Colors.grey[50],
          filled: true,
          contentPadding: EdgeInsets.all(10.0),
          hintText: hintText,
          hintStyle: TextStyle(fontSize: 14),
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
