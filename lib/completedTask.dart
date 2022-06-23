import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'budgetTracker.dart';

class completedTask extends StatefulWidget {
  const completedTask({Key? key}) : super(key: key);

  @override
  _completedTaskState createState() => _completedTaskState();
}

class _completedTaskState extends State<completedTask> {
  final _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF121639),
        title: Text(
          'Completed Task',
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection('completedTaskData').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                } else {
                  final messages = snapshot.data!.docs;
                  List<FlatButton> taskDetails = [];
                  for (var task in messages) {
                    final messageText = (task.data() as dynamic)['taskName'];
                    final completedBy = (task.data() as dynamic)['completedBy'];
                    final cost = (task.data() as dynamic)['Budget'];
                    final taskWidget = FlatButton(
                      color: Color(0xFFEB1555),
                      focusColor: Colors.red,
                      height: 120.0,
                      onPressed: () {},
                      child: Column(
                        children: [
                          Text(
                            'Task Name: ' + messageText,
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            'Task Succefully done by  ' + completedBy,
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            'Budget:  ' + cost,
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                    );
                    taskDetails.add(taskWidget);
                  }
                  return Expanded(
                    child: ListView(
                      padding:
                          EdgeInsets.symmetric(vertical: 5.0, horizontal: 0.0),
                      children: taskDetails,
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.monetization_on,
          color: Colors.yellowAccent,
        ),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => budgetTracker()));
        },
        tooltip: 'Budget Tracker',
      ),
    );
  }
}
