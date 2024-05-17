import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_sun_c9/models/todo_dm.dart';
import '../../models/app_user.dart';

class ListProvider extends ChangeNotifier{
  List<TodoDM> todos = [];
  DateTime selectedDate = DateTime.now();

  refreshTodosList() async {
    print("Getting todos");
    todos = [];
    CollectionReference<TodoDM> todosCollection =
    FirebaseFirestore.instance.collection(TodoDM.collectionName).
    withConverter<TodoDM>(
        fromFirestore: (docSnapShot, _) {
          Map json = docSnapShot.data() as Map;
          TodoDM todo = TodoDM.fromJson(json);
          return todo;
        },
        toFirestore: (todoDm, _){
          return todoDm.toJson();
        });
    QuerySnapshot<TodoDM> todosSnapshot = await todosCollection.
    orderBy("date").get();
    List<QueryDocumentSnapshot<TodoDM>> docs = todosSnapshot.docs;
    todos = docs.map( (docSnapshot){
      return docSnapshot.data();
    }).toList();
    todos = todos.where((todo){
        if(todo.date.day != selectedDate.day ||
            todo.date.month != selectedDate.month ||
           todo.date.year != selectedDate.year){
          return false;
        }else {
          return true;
        }
    }).toList();
    notifyListeners();
  }

  Future<void> clickOnIsDone(TodoDM todoDM)async {
    FirebaseFirestore.instance
        .collection(TodoDM.collectionName)
        .doc(todoDM.id)
        .set(todoDM.toJson());

    refreshTodosList();
  }
  clickOnDelete(String taskId)async {
    FirebaseFirestore.instance
        .collection(TodoDM.collectionName)
        .doc(taskId).delete().timeout(const Duration(milliseconds: 500), onTimeout: (){
      refreshTodosList();

    });
  }
}