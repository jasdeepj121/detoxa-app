class NetworkUrls {
  static String baseUrlProd =
      "https://django-rest-python.herokuapp.com/detoxa-services/";

  //auth
  static String generateSignInOtp = "auth/user/generateSignInOtp";
  static String loginWithoutPassword = "auth/user/login/passwordless";
  static String loginWithPassword = "auth/user/login/withpassword";
  static String register = "auth/user/register";
  static String signout = "auth/user/signout";
  static String updatePassword = "auth/user/update/password";
  static String update = "auth/user/update";
}
