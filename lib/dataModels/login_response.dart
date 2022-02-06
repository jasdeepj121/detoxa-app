import 'package:detoxa/dataModels/user.dart';

class LoginResponse {
  LoginResponse({
    this.success,
    this.token,
    this.user,
    this.isSubscribed,
  });

  bool success;
  String token;
  User user;
  bool isSubscribed;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        success: json["success"],
        token: json["Token"],
        user: User.fromJson(json["user"]),
        isSubscribed: json["is_subscribed"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "Token": token,
        "user": user.toJson(),
        "is_subscribed": isSubscribed,
      };
}
