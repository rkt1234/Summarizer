import 'package:flutter/material.dart';
import 'package:summarizer_app/services/firebase_services.dart';

class SignupProvider extends ChangeNotifier {
  late String snackbarMessage;
  late bool isLoading=false;
  late bool isValid=false;

  void checkIfValid(String email, String password, String confirmPassword) {
    print("hello");
    if (email.isNotEmpty && password.isNotEmpty && confirmPassword.isNotEmpty && confirmPassword==password) {
      isValid=true;
    }
    else if(email.isEmpty)
    {snackbarMessage="E-mail cannot be empty";}
    else if(password.isEmpty)
    {snackbarMessage="Password cannot be empty";}
    else if(confirmPassword != password)
    {snackbarMessage="Passwords do not match";}
    notifyListeners();
  }
  
  void toggleLoading() {
    print("yaha aya hai");
    isLoading=!isLoading;
    notifyListeners();
  }
}