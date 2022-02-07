class Otp {
  String status;
  String details;

  Otp({
    this.details,
    this.status,
  });

  factory Otp.fromJson(Map<String, dynamic> json) => Otp(
        details: json["Details"],
        status: json["Status"],
      );
}

class OtpResponse {
  String mobile;
  Otp otp;

  OtpResponse({this.mobile, this.otp});

  factory OtpResponse.fromJson(Map<String, dynamic> json) => OtpResponse(
      mobile: json["mobile_no"],
      otp: Otp.fromJson(
        json["otp"],
      ));
}
