import 'package:TODO/BackEnd/HelperFunctions.dart';
import 'package:TODO/BackEnd/authentication.dart';
import 'package:TODO/BackEnd/database.dart';
import 'package:TODO/date.dart';
import 'package:TODO/signInScreen.dart';
import 'package:flutter/material.dart';
import 'BackEnd/authentication.dart';

class WorkPlace extends StatefulWidget {
  final String userName;
  final String userEmail;
  WorkPlace({this.userName, this.userEmail});

  @override
  _WorkpalceState createState() => _WorkpalceState();
}

class _WorkpalceState extends State<WorkPlace> {
  String date;
  TextEditingController taskETC = new TextEditingController();
  Stream userTaskStream;
  String uid;

  @override
  void initState() {
    var current = DateTime.now();
    date = "${DateFunction().getDay(current.weekday)} "
        "${DateFunction().getMonth(current.month)} "
        "${current.day}";
    getUserTasks();
    super.initState();
  }

  getUserTasks() async {
    await SharedPreferenceFunction.getUserId().then((value) {
      uid = value;
      BackendServices().getUserTask(uid).then((value) {
        userTaskStream = value;
        setState(() {});
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Make this Happen",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        centerTitle: true,
        elevation: 0.0,
        actions: [
          GestureDetector(
            onTap: () {
              Authentication().signOut();
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => SignIn()));
            },
            child: Container(
              padding: EdgeInsets.only(right: 10),
              child: Icon(Icons.exit_to_app),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
            alignment: Alignment.center,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 26, vertical: 34),
              width: 600,
              child: Column(
                children: [
                  Text(
                    "Me Time",
                    style: TextStyle(fontSize: 16),
                  ),
                  Text("${date}"),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: taskETC,
                          decoration: InputDecoration(hintText: "Add task"),
                          onChanged: (value) {
                            //taskETC.text = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      taskETC.text.isNotEmpty
                          ? GestureDetector(
                              onTap: () {
                                Map<String, dynamic> taskMap = {
                                  "task": taskETC.text,
                                  "isCompleted": false
                                };
                                BackendServices()
                                    .createTask(uid.toString(), taskMap);
                                taskETC.text = "";
                              },
                              child: Text("Add"))
                          : Container()
                    ],
                  ),
                  taskListView()
                ],
              ),
            )),
      ),
    );
  }

  Widget taskListView() {
    return StreamBuilder(
      stream: userTaskStream,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                padding: EdgeInsets.only(top: 16),
                itemCount: snapshot.data.documents.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return userTaskTile(
                    isTaskCompleted:
                        snapshot.data.documents[index].data["isCompleted"],
                    userTask: snapshot.data.documents[index].data["task"],
                    documentId: snapshot.data.documents[index].documentID,
                  );
                })
            : Container();
      },
    );
  }

  Widget userTaskTile(
      {bool isTaskCompleted, String userTask, String documentId}) {
    return Container(
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Map<String, dynamic> userTaskMap = {
                "isCompleted": !isTaskCompleted
              };
              BackendServices().updateTask(uid, userTaskMap, documentId);
            },
            child: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black87, width: 1),
                    borderRadius: BorderRadius.circular(30)),
                child: isTaskCompleted
                    ? Icon(
                        Icons.check,
                        color: Colors.green,
                      )
                    : Container()),
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            userTask,
            style: TextStyle(
                color: isTaskCompleted
                    ? Colors.black87
                    : Colors.black87.withOpacity(0.8),
                fontSize: 16,
                decoration: isTaskCompleted
                    ? TextDecoration.lineThrough
                    : TextDecoration.none),
          ),
          Spacer(),
          GestureDetector(
            onTap: () {
              BackendServices().deleteUserTask(uid, documentId);
            },
            child: Icon(
              Icons.close_sharp,
              size: 14,
              color: Colors.black87.withOpacity(0.8),
            ),
          )
        ],
      ),
    );
  }
}
