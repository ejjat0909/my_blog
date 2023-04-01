class RegisterRequestModel {
  String? name;
  String? password;
  String? email;
  String? passwordConfirmation;

  RegisterRequestModel(
      {this.name, this.password, this.email, this.passwordConfirmation});

  RegisterRequestModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    password = json['password'];
    email = json['email'];
    passwordConfirmation = json['password_confirmation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['password'] = this.password;
    data['email'] = this.email;
    data['password_confirmation'] = this.passwordConfirmation;
    return data;
  }
}
