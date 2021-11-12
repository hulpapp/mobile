class Volunteer {
  int id;
  String name;
  String email;
  String telephone;
  String cpf;
  String identity;
  int addressId;
  int userId;

  Volunteer(
      {this.id,
        this.name,
        this.email,
        this.telephone,
        this.cpf,
        this.identity,
        this.addressId,
        this.userId});

  Volunteer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    telephone = json['telephone'];
    cpf = json['cpf'];
    identity = json['identity'];
    addressId = json['address_id'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['telephone'] = this.telephone;
    data['cpf'] = this.cpf;
    data['identity'] = this.identity;
    data['address_id'] = this.addressId;
    data['user_id'] = this.userId;
    return data;
  }
}