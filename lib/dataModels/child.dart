import 'package:detoxa/dataModels/gender.dart';

class Child {
  int id;
  String fullName;
  String age;
  Gender gender;
  bool active;
  DateTime dob;
  String profilePic;

  Child({
    this.active,
    this.age,
    this.dob,
    this.fullName,
    this.gender,
    this.id,
    this.profilePic,
  });

  factory Child.fromJson(Map<String, dynamic> json) => Child(
        active: json["active"],
        age: json["age"],
        dob: DateTime.tryParse(json["dob"]),
        fullName: json["full_name"],
        gender: json["gender"] == "Male" ? Gender.male : Gender.female,
        id: json["id"],
        profilePic: json["profile_pic_url"],
      );

  Map<String, dynamic> toJson() => {
        "active": active,
        "age": age,
        "profile_pic_url": profilePic,
        "id": id,
        "full_name": fullName,
        "gender": gender == Gender.male ? "Male" : "Female",
        "dob": dob?.toIso8601String(),
      };
}
