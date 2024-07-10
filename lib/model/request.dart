class Request {
  late String text;
  late String type;

  Request({
    required this.text,
    required this.type
  });

    Map<String, String> toJson()  {
       Map<String,String> jsonObject = {
            'text': text,
            'sourcetype': type
      };
      return jsonObject;
      }
}