class UserSubscription {
  String subscriptionType;
  DateTime renewalDate;
  String membership;

  UserSubscription({
    this.membership,
    this.renewalDate,
    this.subscriptionType,
  });

  factory UserSubscription.fromJson(Map<String, dynamic> json) =>
      UserSubscription(
        membership: json["membership"],
        renewalDate: DateTime.tryParse(json["renewal_date"]),
        subscriptionType: json["subscription_type"],
      );

  Map<String, dynamic> toMap() => {
        "membership": membership,
        "renewal_date": renewalDate?.toIso8601String(),
        "subscription_type": subscriptionType,
      };
}
