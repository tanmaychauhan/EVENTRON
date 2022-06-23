import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'task_status.dart';
import 'welcomeScreen.dart';
import 'loginScreen.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
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
        //backgroundColor: Colors.white,
        body: Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Text(
          //   'Register',
          //   style: TextStyle(
          //     fontSize: 30.0,
          //   ),
          //   textAlign: TextAlign.center,
          // ),
          // SizedBox(
          //   height: 10.0,
          // ),
          CircleAvatar(
            radius: 100.0,
            backgroundImage: AssetImage('Assets/register.jpeg'),
          ),
          // Expanded(
          //   child: Hero(
          //     tag: 'Freshers 2K21',
          //     child: Container(
          //       height: 130.0,
          //       child: Image.asset('Assets/register.jpeg'),
          //     ),
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
                final newUser = _auth.createUserWithEmailAndPassword(
                    email: email, password: password);
                if (newUser != null) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                }
              } catch (e) {
                warningDialog();
              }
            },
            child: Text(
              'Register',
            ),
          )
        ],
      ),
    ));
  }
}
