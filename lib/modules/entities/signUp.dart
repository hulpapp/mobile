class SignUp {
  String email;
  String password;
  String passwordConfirmation;
  String name;
  String telephone;
  String cpf;
  String identity;
  String cep;
  String street;
  int number;
  String city;
  String state;

  SignUp({this.email,
    this.password,
    this.passwordConfirmation,
    this.name,
    this.telephone,
    this.cpf,
    this.identity,
    this.cep,
    this.street,
    this.number,
    this.city,
    this.state,});

  SignUp.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
    passwordConfirmation = json['password_confirmation'];
    name = json['name'];
    telephone = json['telephone'];
    cpf = json['cpf'];
    identity = json['identity'];
    cep = json['cep'];
    street = json['street'];
    number = json['number'];
    city = json['city'];
    state = json['state'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['password'] = this.password;
    data['password_confirmation'] = this.passwordConfirmation;
    data['name'] = this.name;
    data['telephone'] = this.telephone;
    data['cpf'] = this.cpf;
    data['identity'] = this.identity;
    data['cep'] = this.cep;
    data['street'] = this.street;
    data['number'] = this.number;
    data['city'] = this.city;
    data['state'] = this.state;
    return data;
  }
}
