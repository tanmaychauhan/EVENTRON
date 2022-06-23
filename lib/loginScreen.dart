import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'ongoingTask.dart';
import 'welcomeScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email = '';
  String password = '';
  final _auth = FirebaseAuth.instance;

  Future warningDialog() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
            title: Text('Warning!!'),
            content: Text('Invalid Credentials!!'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Ok',
                  )),
            ]),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0A0E21),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Text(
            //   'Login',
            //   style: TextStyle(
            //     fontSize: 30.0,
            //   ),
            //   textAlign: TextAlign.center,
            // ),
            SizedBox(
              height: 10.0,
            ),
            CircleAvatar(
              radius: 100.0,
              backgroundImage: AssetImage('Assets/login.jpeg'),
            ),
            // Hero(
            //   tag: 'Login',
            //   child: Container(
            //     height: 130.0,
            //     child: Image.asset('Assets/login.jpeg'),
            //   ),
            // ),
            SizedBox(
              height: 48.0,
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'Enter your Email',
              ),
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) {
                email = value;
              },
            ),
            SizedBox(
              height: 8.0,
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'Enter your password',
              ),
              obscureText: true,
              onChanged: (value) {
                password = value;
              },
            ),
            SizedBox(
              height: 24.0,
            ),
            FlatButton(
              color: Color(0xFFEB1555),
              padding: EdgeInsets.all(8.0),
              onPressed: () async {
                try {
                  await _auth.signInWithEmailAndPassword(
                      email: email, password: password);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => welcomeScreen()));
                } catch (e) {
                  warningDialog();
                }
              },
              child: Text(
                'Login',
              ),
            )
          ],
        ),
      ),
    );
  }
}
