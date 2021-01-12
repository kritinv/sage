import 'package:flutter/material.dart';
import 'package:the_unnamed_startup/main.dart';
import 'main_pages.dart';
import 'package:provider/provider.dart';

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

class SignUp extends StatelessWidget {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirm = TextEditingController();
  final Widget inputSpacer = SizedBox(height: 20.0);
  final Function stateChange;
  SignUp(this.stateChange);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Input(textState: false, hintText: "First Name"),
      inputSpacer,
      Input(textState: false, hintText: "Last Name"),
      inputSpacer,
      Input(textState: false, hintText: "Email"),
      inputSpacer,
      Input(textState: true, hintText: "Password"),
      inputSpacer,
      Container(
        width: double.infinity,
        child: RaisedButton(
            child: Text(' Sign Up'),
            color: Color(0xffFF8F00),
            onPressed: () {
              context.read<AuthenticationService>().signUp(
                    email: email.text.trim(),
                    password: password.text.trim(),
                  );
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
          stateChange();
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
    ]);
  }
}

class LoginForm extends StatelessWidget {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final Widget spacer = SizedBox(height: 20.0);
  final Function changeState;
  LoginForm(this.changeState);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Input(textState: false, hintText: "Email"),
      spacer,
      Input(textState: true, hintText: "Password"),
      spacer,
      Container(
        width: double.infinity,
        child: RaisedButton(
          child: Text('Login'),
          color: Color(0xffFF8F00),
          onPressed: () {
            context.read<AuthenticationService>().signIn(
                  email: email.text.trim(),
                  password: password.text.trim(),
                );
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
          changeState();
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
    ]);
  }
}

class Input extends StatelessWidget {
  final bool textState;
  final String hintText;
  Input({this.textState, this.hintText});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      child: TextField(
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
