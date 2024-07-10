import 'package:flutter/material.dart';
import 'package:summarizer_app/services/firebase_services.dart';

class SigninProvider extends ChangeNotifier {
   late String snackbarMessage;
  late bool isLoading = false;
  late bool isValid = false;

  void checkIfValid(String email, String password) {
    print("hello");
    if (email.isNotEmpty &&
        password.isNotEmpty ) {
      isValid = true;
    } else if (email.isEmpty) {
      snackbarMessage = "E-mail cannot be empty";
    } else if (password.isEmpty) {
      snackbarMessage = "Password cannot be empty";
    } 
    notifyListeners();
  }

  void toggleLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }
}
