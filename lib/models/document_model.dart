class DocumentModel {
  String? documentId;
  String? documentName;
  String? uploadDate;
  dynamic expiredDate;
  String? signingType;
  String? status;
  bool? canSign;
  bool? owner;
  String? base64Document;
  List<SignerList>? signerList;
  dynamic sign;

  DocumentModel({
    this.documentId,
    this.documentName,
    this.uploadDate,
    this.expiredDate,
    this.signingType,
    this.status,
    this.canSign,
    this.owner,
    this.base64Document,
    this.signerList,
    this.sign,
  });

  DocumentModel.fromJson(Map<String, dynamic> json) {
    documentId = json['documentId'];
    documentName = json['documentName'];
    uploadDate = json['uploadDate'];
    expiredDate = json['expiredDate'];
    signingType = json['signingType'];
    status = json['status'];
    canSign = json['canSign'];
    owner = json['owner'];
    base64Document = json['base64Document'];
    if (json['signerList'] != null) {
      signerList = <SignerList>[];
      json['signerList'].forEach((v) {
        signerList!.add(SignerList.fromJson(v));
      });
    }
    sign = json['sign'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['documentId'] = documentId;
    data['documentName'] = documentName;
    data['uploadDate'] = uploadDate;
    data['expiredDate'] = expiredDate;
    data['signingType'] = signingType;
    data['status'] = status;
    data['canSign'] = canSign;
    data['owner'] = owner;
    data['base64Document'] = base64Document;
    if (signerList != null) {
      data['signerList'] = signerList!.map((v) => v.toJson()).toList();
    }
    data['sign'] = sign;
    return data;
  }
}

class SignerList {
  String? name;
  String? status;
  String? signedDate;

  SignerList({this.name, this.status, this.signedDate});

  SignerList.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    status = json['status'];
    signedDate = json['signedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['status'] = status;
    data['signedDate'] = signedDate;
    return data;
  }
}
