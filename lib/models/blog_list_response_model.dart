import 'package:my_blog/helpers/base_api_response.dart';
import 'package:my_blog/models/blog_model.dart';

class BlogListResponseModel
    extends BaseAPIResponse<List<BlogModel>, Null> {
  BlogListResponseModel(fullJson) : super(fullJson);

  @override
  dataToJson(List<BlogModel>? data) {
    if (this.data != null) {
      return this.data?.map((v) => v.toJson()).toList();
    }
    return null;
  }

  @override
  errorsToJson(Null errors) {
    return null;
  }

  @override
  List<BlogModel>? jsonToData(Map<String, dynamic>? json) {
    if (json != null) {
      data = [];

      json["data"].forEach((v) {
        data!.add(BlogModel.fromJson(v));
      });

      return data!;
    }

    return null;
  }

  @override
  Null jsonToError(Map<String, dynamic> json) {
    return null;
  }
}