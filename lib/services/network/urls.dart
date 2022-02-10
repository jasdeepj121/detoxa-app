class NetworkUrls {
  static String baseUrlProd = "https://dev.detoxa.in/detoxa-services/";
  //auth
  static String generateSignInOtp = "auth/user/generateSignInOtp";
  static String loginWithoutPassword = "auth/user/login/passwordless";
  static String loginWithPassword = "auth/user/login/withpassword";
  static String register = "auth/user/register";
  static String signout = "auth/user/signout";
  static String updatePassword = "auth/user/update/password";
  static String update = "auth/user/update";

  static String getChildList = "/user/child";
  static String createChild = "/user/child";
  static String deleteChild = "/user/child/delete";
  static String getChildDetails = "/user/child/details";
  static String updateChildDetails = "/user/child/update";

  //trackers
  static String createGrowthTracker = "/growth-tracker/user/growth-tracker";
  static String getGrowthTrackerList =
      "/growth-tracker/user/get-growth-tracker";
  // static String a = "";
  // static String a = "";
  // static String a = "";  // static String a = "";
  // static String a = "";
  // static String a = "";
  // static String a = "";

  //reports
  static String downloadGrowthReport = "/report/download-growth-report";
}
