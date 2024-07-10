class UserModel {
  late String userId;
  late String email;

  UserModel({
    required this.userId, 
    required this.email
    }); // constructor

     Map<String, String> toJson()  {
      Map<String,String> jsonObject = {
        "userId": userId,
        "email": email
      };
      return jsonObject;
      }
}