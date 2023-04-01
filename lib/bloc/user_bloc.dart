import 'package:my_blog/models/default_response_model.dart';
import 'package:my_blog/models/login_request_model.dart';
import 'package:my_blog/models/register_request_model.dart';
import 'package:my_blog/models/user_response_model.dart';
import 'package:my_blog/resource/user_resource.dart';
import 'package:my_blog/services/web_services.dart';

class UserBloc {
  // register
  Future<DefaultResponseModel> register(
      RegisterRequestModel registerRequestModel) async {
    return await Webservice.post(UserResource.register(registerRequestModel));
  }

// login
  Future<UserResponseModel> login(LoginRequestModel loginRequestModel) async {
    return await Webservice.post(UserResource.login(loginRequestModel));
  }

// logout
  Future<DefaultResponseModel> logout() async {
    return await Webservice.get(UserResource.logout());
  }
}
