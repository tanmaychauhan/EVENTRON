import 'package:flutter/material.dart';
import 'pendingTask.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'ongoingTask.dart';
import 'completedTask.dart';

class aboutUs extends StatefulWidget {
  const aboutUs({Key? key}) : super(key: key);

  @override
  _aboutUsState createState() => _aboutUsState();
}

class _aboutUsState extends State<aboutUs> {
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'About Us',
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF121639),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 30, 10, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('Assets/Tanmay.JPG'),
                  //backgroundColor: Colors.red,
                  radius: 45,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Tanmay Chauhan",
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "19U02054",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            Column(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('Assets/Divyansh.jpg'),
                  radius: 45,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Divyansh Gupta",
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "19U02067",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            Column(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('Assets/Bunty.jpeg'),
                  //backgroundColor: Colors.red,
                  radius: 45,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Himanshu Kumar",
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "19U02066",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            Column(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('Assets/Rahul.jpg'),
                  radius: 45,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Rahul Sharma",
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "19U02077",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
