class AuthModel {
  String? name;
  String? email;
  String? phone;
  String? token;
  String? regisStatus;
  List<dynamic>? otherAccount;
  List<dynamic>? unlinkedAccount;
  bool? corporate;
  bool? sysadmin;

  AuthModel({
    this.name,
    this.email,
    this.phone,
    this.token,
    this.regisStatus,
    this.otherAccount,
    this.unlinkedAccount,
    this.corporate,
    this.sysadmin,
  });

  AuthModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    token = json['token'];
    regisStatus = json['regisStatus'];
    if (json['otherAccount'] != null) {
      otherAccount = <dynamic>[];
      json['otherAccount'].forEach((v) {
        otherAccount!.add(v);
      });
    }
    if (json['unlinkedAccount'] != null) {
      unlinkedAccount = <dynamic>[];
      json['unlinkedAccount'].forEach((v) {
        unlinkedAccount!.add(v);
      });
    }
    corporate = json['corporate'];
    sysadmin = json['sysadmin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['token'] = token;
    data['regisStatus'] = regisStatus;
    if (otherAccount != null) {
      data['otherAccount'] = otherAccount!.map((v) => v.toString()).toList();
    }
    if (unlinkedAccount != null) {
      data['unlinkedAccount'] =
          unlinkedAccount!.map((v) => v.toString()).toList();
    }
    data['corporate'] = corporate;
    data['sysadmin'] = sysadmin;
    return data;
  }
}
