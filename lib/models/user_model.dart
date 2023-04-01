class UserModel {
  int? id;
  String? name;
  String? email;
  String? accessToken;

  UserModel({this.id, this.name, this.email, this.accessToken});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    accessToken = json['access_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['access_token'] = this.accessToken;
    return data;
  }
}
