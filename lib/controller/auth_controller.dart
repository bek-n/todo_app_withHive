import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../view/model/user_model.dart';

class AuthController extends ChangeNotifier {
   final FirebaseFirestore firestore = FirebaseFirestore.instance;


  loginGoogle(VoidCallback onSuccess) async {
    GoogleSignIn _googleSignIn = GoogleSignIn();

    GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    GoogleSignInAuthentication? googleAuth = await googleUser!.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final userObj =
        await FirebaseAuth.instance.signInWithCredential(credential);
    print(userObj.additionalUserInfo?.isNewUser);
    if (userObj.additionalUserInfo?.isNewUser ?? true) {
      // sing in
      firestore
          .collection("users")
          .add(UserModel(
                  username: userObj.user?.displayName ?? "",
                  password: userObj.user?.uid ?? "",
                  email: userObj.user?.email ?? "",
                  phone: userObj.user?.phoneNumber ?? "",
                  avatar: userObj.user?.photoURL ?? "")
              .toJson())
          .then((value) async {
        onSuccess();
        _googleSignIn.signOut();
      });
    } else {
      // sing up
       await firestore
          .collection("users")
          .where("email", isEqualTo: userObj.user?.email)
          .get();
            onSuccess();
    }
  }
}
