import 'package:detoxa/dataModels/gender.dart';

class NewGrowthTrackerReport {
  int id;
  String name;
  int age;
  int height;
  int weight;
  Gender gender;
  int parent;
  double bmi;
  String bmiResult;
  int childId;

  NewGrowthTrackerReport({
    this.age,
    this.bmi,
    this.bmiResult,
    this.childId,
    this.gender,
    this.height,
    this.id,
    this.name,
    this.parent,
    this.weight,
  });

  factory NewGrowthTrackerReport.fromJson(Map<String, dynamic> json) =>
      NewGrowthTrackerReport(
        age: json["age"],
        bmi: json["bmi"],
        bmiResult: json["bmi_result"],
        childId: json["child_id"],
        height: json["height"],
        id: json["id"],
        name: json["name"],
        parent: json["parent"],
        weight: json["weight"],
        gender: json["gender"] == "Male"
            ? Gender.male
            : json["gender"] == "Female"
                ? Gender.female
                : Gender.others,
      );
}
