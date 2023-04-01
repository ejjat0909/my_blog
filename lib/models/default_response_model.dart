import 'package:my_blog/helpers/base_api_response.dart';

// To handle basic response
class DefaultResponseModel extends BaseAPIResponse<dynamic, Null> {
  DefaultResponseModel(fullJson) : super(fullJson);

  @override
  dataToJson(data) {
    return null;
  }

  @override
  errorsToJson(errors) {
    return null;
  }

  @override
  jsonToData(Map<String, dynamic>? json) {
    if (json != null) {
      return json["data"];
    }
  }

  @override
  jsonToError(Map<String, dynamic> json) {
    return null;
  }
}
