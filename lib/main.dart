import 'package:flutter/material.dart';
import 'package:the_unnamed_startup/consultant_signup.dart';
import 'package:the_unnamed_startup/login.dart';
import 'package:the_unnamed_startup/meeting_confirmation.dart';
import 'package:the_unnamed_startup/profile.dart';
import 'package:the_unnamed_startup/main_pages.dart';
import 'main_pages.dart';
import 'time_slot.dart';
import 'login.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
            create: (_) => AuthenticationService(FirebaseAuth.instance)),
        StreamProvider(
          create: (context) =>
              context.read<AuthenticationService>().authStateChanges,
        )
      ],
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => AuthenticationWrapper(),
          MainScreen.routeName: (context) => MainScreen(0),
          Profile.routeName: (context) => Profile(),
          TimeSlot.routeName: (context) => TimeSlot(),
          MeetingConfirmation.routeName: (context) => MeetingConfirmation(),
          ConsultantSignUp.routeName: (context) => ConsultantSignUp(),
        },
      ),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();
    if (firebaseUser != null) {
      return MainScreen(0);
    }
    return Login();
  }
}

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;
  AuthenticationService(this._firebaseAuth);
  Stream<User> get authStateChanges => _firebaseAuth.authStateChanges();
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<String> signIn({String email, String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return "Signed in";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<String> signUp({String email, String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return "Signed Up";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }
}
