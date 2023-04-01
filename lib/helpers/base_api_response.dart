import 'dart:core';

import 'package:my_blog/helpers/http_response.dart';

// https://nhancv.com/flutter-base-model-approach/

abstract class BaseAPIResponse<Data, Errors> {
  bool isSuccess = false;
  String message = "";
  int statusCode = HttpResponse.HTTP_GONE;
  Data? data;
  Errors? errors;

  BaseAPIResponse(Map<String, dynamic> fullJson) {
    parsing(fullJson);
  }

  //Abstract json to data
  Data? jsonToData(Map<String, dynamic>? json);

  //Abstract json to errors
  Errors? jsonToError(Map<String, dynamic> json);

  //Abstract data to json
  dynamic dataToJson(Data? data);

  //Abstract errors to json
  dynamic errorsToJson(Errors? errors);

  //Parsing data to object
  parsing(Map<String, dynamic> fullJson) {
    isSuccess = fullJson["is_success"] ?? false;
    message = fullJson["message"] ?? "";
    statusCode =
        fullJson["status_code"] ?? HttpResponse.HTTP_INTERNAL_SERVER_ERROR;
    data = fullJson["data"] != null ? jsonToData(fullJson) : null;
    errors = fullJson["errors"] != null ? jsonToError(fullJson) : null;
  }

  // Data to json
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dataJson = new Map<String, dynamic>();
    dataJson['is_success'] = this.message;
    dataJson['message'] = this.message;
    dataJson['status_code'] = this.message;
    if (data != null) {
      dataJson['data'] = dataToJson(data);
    }
    if (errors != null) {
      dataJson['errors'] = errorsToJson(errors);
    }
    return dataJson;
  }
}
