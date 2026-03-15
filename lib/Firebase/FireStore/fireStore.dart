import 'package:cloud_firestore/cloud_firestore.dart';

class fireStore {
  Future<void> saveUser(String uid, String email) async {
    await FirebaseFirestore.instance.collection("users").doc(uid).set({
      "uid": uid,
      "email": email,
      "createdAt": FieldValue.serverTimestamp(),
    });
  }
}
