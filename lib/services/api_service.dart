import 'dart:convert';
import 'package:summarizer_app/model/request.dart';
import 'package:http/http.dart' as http;

class APIService {

  Future<String> getSummary(String inputText,String inputType) async{
    String apiUrl = 'https://sum-2.onrender.com/';
    print("mai hoon don");
    try {
      Map<String,String> requestData=Request(text: inputText,type: inputType).toJson();

      final response = await http.post(Uri.parse(apiUrl),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
             'text': inputText, 
             'sourcetype': inputType
          })
          );
          if(response.statusCode==200) {
            return response.body;
          } else {
            return "Sorry, could not summarize!";
          }
    }
    catch(e) {
      return "Sorry, could not summarize!";
    }
  }
}