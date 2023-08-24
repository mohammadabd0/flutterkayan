import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_task1/model/users.dart';

class APIs {
  static FirebaseAuth auth = FirebaseAuth.instance;

 // static FirebaseFirestore firestore = FirebaseFirestore.instance;

  static User get user => auth.currentUser!;

  static Future<void> createUser({ required String name, required String email}) async {
    final newUser = Users(
      id: user.uid,
      username: name.toString(),
      email: email.toString(),
    );

   // return await firestore.collection('users').doc(user.uid).set(newUser.toJson());
  }
}
