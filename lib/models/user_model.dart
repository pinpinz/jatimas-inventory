class UserModel {
  String? name;
  String? pid;
  String? pidType;
  String? phone;
  String? birthDate;
  String? country;
  String? email;
  dynamic department;
  dynamic company;

  UserModel({
    this.name,
    this.pid,
    this.pidType,
    this.phone,
    this.birthDate,
    this.country,
    this.email,
    this.department,
    this.company,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    pid = json['pid'];
    pidType = json['pidType'];
    phone = json['phone'];
    birthDate = json['birthDate'];
    country = json['country'];
    email = json['email'];
    department = json['department'];
    company = json['company'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['pid'] = pid;
    data['pidType'] = pidType;
    data['phone'] = phone;
    data['birthDate'] = birthDate;
    data['country'] = country;
    data['email'] = email;
    data['department'] = department;
    data['company'] = company;
    return data;
  }
}
