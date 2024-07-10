import 'package:flutter/material.dart';

class SummaryProvider extends ChangeNotifier {
  late String summary="";
  late bool isLoading=false;
  late bool showSave=false;

  void toggleLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }

  void show() {
    if(summary!="Sorry, could not summarize!")
    showSave=true;
    notifyListeners();
  }
}