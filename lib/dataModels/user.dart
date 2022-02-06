class User {
  User({
    this.id,
    this.fullName,
    this.email,
    this.password,
    this.mobile,
    this.isActive,
    this.isTncAccepted,
    this.isAdmin,
    this.isDoctor,
    this.isSchoolAdmin,
    this.isSocietyAdmin,
    this.isCompanyAdmin,
    this.isHospitalAdmin,
    this.profilePicUrl,
    this.address,
  });

  int id;
  String fullName;
  String email;
  String password;
  String mobile;
  String profilePicUrl;
  bool isActive;
  bool isTncAccepted;
  bool isAdmin;
  bool isDoctor;
  bool isSchoolAdmin;
  bool isSocietyAdmin;
  bool isCompanyAdmin;
  bool isHospitalAdmin;
  String address;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        fullName: json["full_name"],
        email: json["email"],
        password: json["password"],
        mobile: json["mobile"],
        isActive: json["is_active"],
        isTncAccepted: json["is_tnc_accepted"],
        isAdmin: json["is_admin"],
        isDoctor: json["is_doctor"],
        isSchoolAdmin: json["is_school_admin"],
        isSocietyAdmin: json["is_society_admin"],
        isCompanyAdmin: json["is_company_admin"],
        isHospitalAdmin: json["is_hospital_admin"],
        profilePicUrl: json["profile_pic_url"],
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "full_name": fullName,
        "email": email,
        "password": password,
        "mobile": mobile,
        "is_active": isActive,
        "is_tnc_accepted": isTncAccepted,
        "is_admin": isAdmin,
        "is_doctor": isDoctor,
        "is_school_admin": isSchoolAdmin,
        "is_society_admin": isSocietyAdmin,
        "is_company_admin": isCompanyAdmin,
        "is_hospital_admin": isHospitalAdmin,
        "profile_pic_url": profilePicUrl,
        "address": address,
      };
}
