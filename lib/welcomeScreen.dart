import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'task_status.dart';
import 'About_Us.dart';
import 'registrationScreen.dart';
import 'loginScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'budgetTracker.dart';

class welcomeScreen extends StatefulWidget {
  const welcomeScreen({Key? key}) : super(key: key);

  @override
  _welcomeScreenState createState() => _welcomeScreenState();
}

class _welcomeScreenState extends State<welcomeScreen> {
  var loggedInUser;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    loggedInUser = _auth.currentUser?.email;
  }

  @override
  final _auth = FirebaseAuth.instance;

  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Freshers Admin'),
            TextButton(
              onPressed: () {
                _auth.signOut();
                Navigator.of(context).pop();
              },
              child: Icon(
                Icons.logout,
                color: Colors.white,
              ),
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF121639),
        // leading: FloatingActionButton(
        //   backgroundColor: Color(0xFF121639),
        //   onPressed: () {
        //     _auth.signOut();
        //     Navigator.of(context).pop();
        //   },
        // ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Hi , ' + loggedInUser,
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Text(
              'Lets,Get Started there is lot do!',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              child: Image.asset('Assets/party.jpg'),
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              height: 200.0,
              child: Image.asset('Assets/register.jpeg'),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              'Lets make un-forgottable moment to turn back and say we have done it!!',
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
            SizedBox(
              height: 50.0,
            ),
            FlatButton(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              minWidth: Checkbox.width,
              color: Color(0xFFEB1555),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => taskStatus()));
              },
              child: Text(
                'Let\'s Start',
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
            )
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF121639),
              ),
              child: Column(
                children: [
                  Text(
                    'EVENTRON',
                    style: TextStyle(
                      fontSize: 25.0,
                    ),
                  ),
                  CircleAvatar(
                    radius: 50.0,
                    backgroundImage: AssetImage('Assets/party.jpg'),
                  ),
                  // CircleAvatar(
                  //   backgroundColor: Colors.blueGrey,
                  //   radius: 50.0,
                  //   child: Text(
                  //     'Start!!',
                  //     style: TextStyle(
                  //       color: Colors.black,
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
            ListTile(
              title: const Text('Task'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => taskStatus()));
              },
            ),
            ListTile(
              title: const Text('Budget Tracker'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => budgetTracker()));
              },
            ),
            ListTile(
              title: const Text('Event Management'),
              onTap: () {},
            ),
            ListTile(
              title: const Text('Participant Details'),
              onTap: () {},
            ),
            ListTile(
              title: const Text('About Us'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => aboutUs()));
              },
            ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Color(0xFF121639),
      //   onPressed: () {
      //     _auth.signOut();
      //     Navigator.of(context).pop();
      //   },
      //   child: Icon(
      //     Icons.logout,
      //     color: Colors.black,
      //     semanticLabel: 'LogOut',
      //   ),
      //   tooltip: 'LogOut',
      // ),
    );
  }
}
