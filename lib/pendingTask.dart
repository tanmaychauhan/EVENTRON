import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class pendingTask extends StatefulWidget {
  const pendingTask({Key? key}) : super(key: key);

  @override
  _pendingTaskState createState() => _pendingTaskState();
}

class _pendingTaskState extends State<pendingTask> {
  @override
  late TextEditingController controller;
  var loggedInUser;
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    getCurrentUser();
  }

  void getCurrentUser() {
    loggedInUser = _auth.currentUser?.email;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void submit() {
    Navigator.of(context).pop(controller.text);
    controller.clear();
  }

  Future assignDialog(var DocId, var assignTaskName) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Assign Task'),
          content: Text(
            'Do you Want to do this task?',
          ),
          actions: [
            Row(
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Cancel',
                  ),
                ),
                SizedBox(
                  width: 140.0,
                ),
                TextButton(
                  child: Text(
                    'Assign',
                  ),
                  onPressed: () async {
                    await _firestore
                        .collection('pendingTaskData')
                        .doc(DocId)
                        .delete();
                    Navigator.of(context).pop();
                    await _firestore.collection('ongoingTaskData').add({
                      'ongoingTaskName': assignTaskName,
                      'assignedTo': loggedInUser,
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      );

  Future<String?> openDialog() => showDialog<String>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Add Task'),
          content: TextField(
            autofocus: true,
            controller: controller,
            decoration: InputDecoration(hintText: 'Enter New Task'),
            onSubmitted: (_) => submit(),
          ),
          actions: [
            TextButton(
              child: Text('Add'),
              onPressed: submit,
            ),
          ],
        ),
      );

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF121639),
        title: Text(
          'Pending Task',
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection('pendingTaskData').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                } else {
                  final messages = snapshot.data!.docs;
                  List<FlatButton> taskDetails = [];
                  for (var task in messages) {
                    final messageText = (task.data() as dynamic)['taskName'];
                    final taskWidget = FlatButton(
                      color: Color(0xFFEB1555),
                      focusColor: Colors.red,
                      height: 80.0,
                      onPressed: () {
                        assignDialog(task.id, messageText);
                      },
                      child: Text(
                        messageText,
                        textAlign: TextAlign.left,
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
        backgroundColor: Colors.green,
        tooltip: 'Add New Task',
        onPressed: () async {
          final addTaskName = await openDialog();
          if (addTaskName == null || addTaskName.isEmpty) {
            print('Entered Name is Empty');
          } else {
            try {
              _firestore.collection('pendingTaskData').add({
                'taskName': addTaskName,
              });
            } catch (e) {
              print(e);
            }
          }
        },
        child: Icon(
          Icons.add,
          size: 30.0,
          semanticLabel: 'Add New Task',
        ),
      ),
    );
  }
}
