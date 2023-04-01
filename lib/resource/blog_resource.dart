import 'dart:convert';

import 'package:my_blog/models/add_blog_request_model.dart';
import 'package:my_blog/models/blog_list_response_model.dart';
import 'package:my_blog/models/default_response_model.dart';
import 'package:my_blog/services/resource.dart';

class BlogResource {
  // Call Logout API to revoke the token
  static Resource getBlogsList() {
    return Resource(
        url: 'blog',
        parse: (response) {
          return BlogListResponseModel(json.decode(response.body));
        });
  }

  static Resource addNewBlogs(AddBlogRequestModel addBlogRequestModel) {
    return Resource(
        url: 'blog',
        data: addBlogRequestModel.toJson(),
        parse: (response) {
          return DefaultResponseModel(json.decode(response.body));
        });
  }
}
