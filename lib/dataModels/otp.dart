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
