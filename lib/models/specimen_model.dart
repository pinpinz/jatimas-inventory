class SpecimenModel {
  String? id;
  String? type;
  bool? defaultStatus;
  bool? addDescription;
  String? base64Specimen;

  SpecimenModel({
    this.id,
    this.type,
    this.defaultStatus,
    this.addDescription,
    this.base64Specimen,
  });

  SpecimenModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    defaultStatus = json['defaultStatus'];
    addDescription = json['addDescription'];
    base64Specimen = json['base64Specimen'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['type'] = type;
    data['defaultStatus'] = defaultStatus;
    data['addDescription'] = addDescription;
    data['base64Specimen'] = base64Specimen;
    return data;
  }
}
