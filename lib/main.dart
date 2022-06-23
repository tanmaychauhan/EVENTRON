import 'package:flutter/material.dart';
import 'task_status.dart';
import 'registrationScreen.dart';
import 'loginScreen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const appTitle = 'Freshers Admin';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        primaryColor: Color(0xFF121639),
        scaffoldBackgroundColor: Color(0xFF0A0E21),
      ),
      debugShowCheckedModeBanner: false,
      title: appTitle,
      home: MyHomePage(title: appTitle),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.teal,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CircleAvatar(
              radius: 100.0,
              backgroundImage: AssetImage('Assets/party.jpg'),
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              'EVENTRON',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 40.0,
                color: Colors.white,
                fontFamily: 'Pacifico',
                fontWeight: FontWeight.bold,
              ),
            ),
            // Text(
            //   'EVENTRON',
            //   style: TextStyle(
            //     fontSize: 30.0,
            //   ),
            //   textAlign: TextAlign.center,
            // ),
            SizedBox(
              height: 10.0,
            ),
            // CircleAvatar(
            //   radius: 80.0,
            //   child: Image.asset('Assets/party.jpg'),
            // ),
            SizedBox(
              height: 48.0,
            ),
            FlatButton(
              color: Color(0xFFEB1555),
              padding: EdgeInsets.all(8.0),
              child: Text('Login'),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
            ),
            SizedBox(
              height: 20.0,
            ),
            FlatButton(
              color: Color(0xFF8D8E98),
              padding: EdgeInsets.all(8.0),
              child: Text('Register'),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RegistrationScreen()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
