class Beneficiary {
  String name;
  String document;
  String birthDate;

  Beneficiary({this.name, this.document, this.birthDate});

  Beneficiary.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    document = json['document'];
    birthDate = json['birthDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['document'] = this.document;
    data['birthDate'] = this.birthDate;
    return data;
  }
}