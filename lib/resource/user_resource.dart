import 'dart:convert';

import 'package:my_blog/models/default_response_model.dart';
import 'package:my_blog/models/login_request_model.dart';
import 'package:my_blog/models/register_request_model.dart';
import 'package:my_blog/models/user_response_model.dart';
import 'package:my_blog/services/resource.dart';

class UserResource {
  // post register

  static Resource register(RegisterRequestModel registerRequestModel) {
    return Resource(
      url: 'register',
      data: registerRequestModel.toJson(),
      parse: (response) {
        // return response model
        return DefaultResponseModel(
          json.decode(response.body),
        );
      },
    );
  }

  static Resource login(LoginRequestModel loginRequestModel) {
    return Resource(
      url: 'login',
      data: loginRequestModel.toJson(),
      parse: (response) {
        // return user response model
        return UserResponseModel(
          json.decode(response.body),
        );
      },
    );
  }

    static Resource logout() {
    return Resource(
      url: 'logout',
      parse: (response) {
        // return response model
        return DefaultResponseModel(
          json.decode(response.body),
        );
      },
    );
  }
}
