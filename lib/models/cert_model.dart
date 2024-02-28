class CertModel {
  String? serialNumber;
  String? status;
  String? active;
  String? expired;

  CertModel({
    this.serialNumber,
    this.status,
    this.active,
    this.expired,
  });

  CertModel.fromJson(Map<String, dynamic> json) {
    serialNumber = json['serialNumber'];
    status = json['status'];
    active = json['active'];
    expired = json['expired'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['serialNumber'] = serialNumber;
    data['status'] = status;
    data['active'] = active;
    data['expired'] = expired;
    return data;
  }
}
