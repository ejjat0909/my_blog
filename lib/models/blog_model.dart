import 'package:my_blog/models/user_model.dart';

class BlogModel {
  int? id;
  String? title;
  String? body;
  UserModel? user;

  BlogModel({this.id, this.title, this.body, this.user});

  BlogModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    body = json['body'];
    user = json['user'] != null ? new UserModel.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['body'] = this.body;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}