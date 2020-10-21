import 'package:cloud_firestore/cloud_firestore.dart';

class BackendServices{
  
  uploadUserData(String userID, Map userDataMap){
    Firestore.instance.collection("users")
        .document(userID)
        .setData(userDataMap)
        .catchError((e){
          print(e.toString());
    });
  }
  
  updateTask(String userID, Map userTaskMap, String documentId){
    Firestore.instance.collection("users")
        .document(userID)
        .collection("tasks")
        .document(documentId)
        .setData(userTaskMap, merge: true);
  }

  createTask(String userID, Map userTaskMap){
    Firestore.instance.collection("users")
        .document(userID)
        .collection("tasks")
        .add(userTaskMap);
  }
  
  getUserTask(String userID) async{
    return await Firestore.instance.collection("users")
        .document(userID)
        .collection("tasks")
        .snapshots();
  }

  deleteUserTask(String userID, String documentID){
    Firestore.instance.collection("users")
        .document(userID)
        .collection("tasks")
        .document(documentID)
        .delete().catchError((e){
          print(e.toString());
    });
  }
}