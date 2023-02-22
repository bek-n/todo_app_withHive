import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo_app/view/model/note_model.dart';

class ToDoController extends ChangeNotifier {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<TodoModel> listOfNotes = [];
  bool isLoading = true;
  QuerySnapshot? res;
  Box<TodoModel>? boxTodo;

  createNote({
    required String name,
    required String date,
  }) async {
    isLoading = true;
    notifyListeners();

    var res = await firestore.collection("notes").add(TodoModel(
          title: name,
          date: date,
        ).toJson());

    boxTodo!.put(res.id, TodoModel(title: name, date: date));

    isLoading = false;
    notifyListeners();
  }

  getNote() async {
    isLoading = true;
    notifyListeners();
    var res;
    boxTodo = await Hive.openBox('todo');
    res = await firestore.collection("notes").get();
    for (var element in res.docs) {
      boxTodo!.put(element.id, TodoModel.fromJson(element.data()));
    }

   
    isLoading = false;
    notifyListeners();
  }
}
