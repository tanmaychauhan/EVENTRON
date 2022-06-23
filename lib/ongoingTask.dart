import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ongoingTask extends StatefulWidget {
  const ongoingTask({Key? key}) : super(key: key);

  @override
  _ongoingTaskState createState() => _ongoingTaskState();
}

class _ongoingTaskState extends State<ongoingTask> {
  late TextEditingController controller;
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  var loggedInUser;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    getCurrentUser();
  }

  void getCurrentUser() {
    loggedInUser = _auth.currentUser?.email;
  }

  void submit() {
    Navigator.of(context).pop(controller.text);
    controller.clear();
  }

  Future warningDialog() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
            title: Text('Warning!!'),
            content: Text('You cannot De-assign other people Task'),
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

  Future<String?> openDialog(var docId, var deasignTaskName) =>
      showDialog<String>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Task Status'),
          content: TextField(
            autofocus: true,
            decoration: InputDecoration(hintText: 'Budget for the Task'),
            controller: controller,
            onSubmitted: (_) => submit,
          ),
          actions: [
            Row(
              children: [
                TextButton(
                  child: Text('De-assign'),
                  onPressed: () async {
                    await _firestore
                        .collection('ongoingTaskData')
                        .doc(docId)
                        .delete();
                    Navigator.of(context).pop();
                    await _firestore.collection('pendingTaskData').add({
                      'taskName': deasignTaskName,
                    });
                  },
                ),
                SizedBox(
                  width: 85.0,
                ),
                TextButton(
                  child: Text('Completed'),
                  onPressed: () async {
                    submit();
                  },
                ),
              ],
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF121639),
        title: Text(
          'Ongoing Task',
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection('ongoingTaskData').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                } else {
                  final messages = snapshot.data!.docs;
                  List<FlatButton> taskDetails = [];
                  for (var task in messages) {
                    final messageText =
                        (task.data() as dynamic)['ongoingTaskName'];
                    final assignedTo = (task.data() as dynamic)['assignedTo'];
                    final taskWidget = FlatButton(
                      color: Color(0xFFEB1555),
                      focusColor: Colors.red,
                      height: 80.0,
                      onPressed: () async {
                        if (loggedInUser == assignedTo) {
                          final budget = await openDialog(
                            task.id,
                            messageText,
                          );
                          if (budget != null) {
                            await _firestore
                                .collection('completedTaskData')
                                .add({
                              'Budget': budget,
                              'completedBy': loggedInUser,
                              'taskName': messageText,
                            });
                            print('data succesfully saved');
                            await _firestore
                                .collection('ongoingTaskData')
                                .doc(task.id)
                                .delete();
                            print(
                                'data successfully deleted from ongoing Task Database');
                          }
                        } else {
                          warningDialog();
                        }
                      },
                      child: Column(
                        children: [
                          Text(
                            messageText,
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            'Task Assigned To  ' + assignedTo,
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
    );
  }
}
