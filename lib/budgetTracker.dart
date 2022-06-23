import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'completedTask.dart';
import 'pendingTask.dart';

class budgetTracker extends StatefulWidget {
  const budgetTracker({Key? key}) : super(key: key);

  @override
  _budgetTrackerState createState() => _budgetTrackerState();
}

class _budgetTrackerState extends State<budgetTracker> {
  final _firestore = FirebaseFirestore.instance;
  int _totalAmount = 200000;
  int _remainingAmount = 200000;
  int _totalExpenditure = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0A0E21),
      appBar: AppBar(
        backgroundColor: Color(0xFF121639),
        title: Text(
          'Budget Tracker',
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              StreamBuilder<QuerySnapshot>(
                stream: _firestore.collection('completedTaskData').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return CircularProgressIndicator();
                  } else {
                    final messages = snapshot.data!.docs;
                    for (var task in messages) {
                      final amountSpend = (task.data() as dynamic)['Budget'];
                      _totalExpenditure =
                          _totalExpenditure + int.parse(amountSpend);
                      _remainingAmount =
                          _remainingAmount - int.parse(amountSpend);
                    }
                    return Column(
                      children: [
                        Text(
                          'Total Amount:',
                          style: TextStyle(
                            fontSize: 28.0,
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          _totalAmount.toString(),
                          style: TextStyle(fontSize: 25.0),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          'Total Expenditure:',
                          style: TextStyle(
                            fontSize: 28.0,
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          _totalExpenditure.toString(),
                          style: TextStyle(fontSize: 25.0),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          'Remaining Amount:',
                          style: TextStyle(
                            fontSize: 28.0,
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          _remainingAmount.toString(),
                          style: TextStyle(fontSize: 25.0),
                        ),
                        SizedBox(
                          height: 180.0,
                        ),
                        FlatButton(
                          child: Text(
                            'See where the Money is been spend. Have a Eye on expenses !! ',
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.blueGrey,
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => completedTask()));
                          },
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        FlatButton(
                          child: Text(
                            'Have a look on the task Remaining.We dont want to lose some events  ',
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.red,
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => pendingTask()));
                          },
                        ),
                      ],
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
