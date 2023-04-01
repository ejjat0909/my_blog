import 'package:my_blog/models/add_blog_request_model.dart';
import 'package:my_blog/models/blog_list_response_model.dart';
import 'package:my_blog/models/default_response_model.dart';
import 'package:my_blog/resource/blog_resource.dart';
import 'package:my_blog/services/web_services.dart';

class BlogBloc {
  Future<BlogListResponseModel> getListProducts() async {
    return await Webservice.get(BlogResource.getBlogsList());
  }

   Future<DefaultResponseModel> addNewBlog(AddBlogRequestModel addBlogRequestModel) async {
    return await Webservice.post(BlogResource.addNewBlogs(addBlogRequestModel));
  }
}