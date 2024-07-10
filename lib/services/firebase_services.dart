import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:summarizer_app/model/user.dart';

class FirebaseServices {
  // 1. Register user
  // 2. Sigin user
  // 3. Save the summary
  // 4. Save user details
  static FirebaseAuth firebaseAuth =  FirebaseAuth.instance; // creating instance of FirebaseAuth
  static FirebaseFirestore firebasefirestore = FirebaseFirestore.instance;
  late Map<String, dynamic> userData;
  var userCredential;

  Future<String> registerUser(String email, String password) async {
    try {
         userCredential = await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
         saveUser(email, userCredential.user!.uid.toString());
         return "User registered";
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> signinUser(String email, String password) async{
      try {
        userCredential = await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
        return "User signed in";
      }
      catch(e) {
        return e.toString();
      }
  }

  void saveUser(String email, String userId) async {
    CollectionReference user = firebasefirestore.collection('user');
    userData = UserModel(userId: userId, email: email).toJson();
    await user.add({
      'email': email,
      'userId': userId
    }).then((value) => print("completed"));
  }

  Future<String> saveSummary(String summary, String title) async{
      CollectionReference post=firebasefirestore.collection('posts');
      User? user = FirebaseAuth.instance.currentUser;
      try {
          await post.add(
            {
              'summary': summary,
               'title': title,
               'userId': user?.uid
            }
          );
          return "Summary saved";
      }
      catch(e) {
        print(e);
        return "Could not save summary";
      }
  }

  void deleteSummary(String id) {
    CollectionReference post = firebasefirestore.collection('posts');
   post.doc(id).delete();
  }

  void logoutUser() {
    firebaseAuth.signOut();
  }
}
