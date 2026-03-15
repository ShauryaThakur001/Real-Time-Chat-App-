import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/Models/UserModel.dart';

class FireStoreService {

  Future<void> saveUser(UserModel user) async {

    await FirebaseFirestore.instance
        .collection("users")
        .doc(user.uid)
        .set(user.toMap());
  }
}