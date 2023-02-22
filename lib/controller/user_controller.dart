import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '../view/model/user_model.dart';

class UserController extends ChangeNotifier {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  UserModel? user;
  bool isLoading = false;

  getUser() async {
    isLoading = true;
    notifyListeners();

    var res = await firestore.collection("users").doc('aXWrEjTsXA9kEMRGGlGK').get();
    user = UserModel.fromJson(res.data());
    isLoading = false;
    notifyListeners();
  }
}
