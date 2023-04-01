import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:my_blog/bloc/blog_bloc.dart';
import 'package:my_blog/bloc/user_bloc.dart';
import 'package:my_blog/models/blog_list_response_model.dart';
import 'package:my_blog/models/blog_model.dart';
import 'package:my_blog/models/default_response_model.dart';
import 'package:my_blog/models/user_model.dart';
import 'package:my_blog/screens/add_new_blog/add_new_blog.dart';
import 'package:my_blog/screens/login_page/login_page.dart';

class HomePage extends StatefulWidget {
  final UserModel userModel;
  const HomePage({super.key, required this.userModel});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<BlogModel> listBlog = [];

  void updateBlogList(BlogModel blogModel) {
    setState(() {
      listBlog.add(blogModel);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBlogs();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: BackButton(color: Colors.transparent),
          actions: [
            IconButton(
                onPressed: () async {
                  UserBloc userBloc = UserBloc();
                  DefaultResponseModel responseModel = await userBloc.logout();

                  if (responseModel.isSuccess) {
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Logged out"),
                        ),
                      );
                      print("Logged out");
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: ((context) => LoginPage()),
                          ),
                          (Route<dynamic> route) => false);
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(responseModel.message),
                      ),
                    );
                    print("cannot Log out");
                  }
                },
                icon: Icon(
                  Icons.logout,
                  color: Colors.black,
                ))
          ],
          title: Text(
            "Hi ${widget.userModel.name}",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          centerTitle: true,
        ),
        body: FutureBuilder<BlogListResponseModel>(
          future: getBlogs(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.isSuccess) {
                List<BlogModel> blogs = snapshot.data!.data!;
                return ListView.builder(
                    reverse: true,
                    physics: BouncingScrollPhysics(),
                    itemCount: blogs.length,
                    itemBuilder: (context, index) {
                      BlogModel blogModel = blogs[index];
                      return Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.all(10),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black, width: 2),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  radius: 21,
                                  backgroundColor: Colors.black,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    radius: 20,
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          "http://via.placeholder.com/350x150",
                                      placeholder: (context, url) =>
                                          new CircularProgressIndicator(),
                                      errorWidget: (context, url, error) =>
                                          new Icon(Icons.error),
                                    ),
                                  ),
                                ),
                                // for space
                                SizedBox(width: 10),
                                Text(blogModel.user!.name!)
                              ],
                            ),
                            CachedNetworkImage(
                              imageUrl: "http://via.placeholder.com/350x150",
                              placeholder: (context, url) =>
                                  new CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  new Icon(Icons.error),
                            ),
                            SizedBox(height: 10),
                            Text(
                              blogModel.title!,
                              style: TextStyle(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.start,
                            ),
                            SizedBox(height: 10),
                            Text(
                              blogModel.body!,
                              textAlign: TextAlign.justify,
                            )
                          ],
                        ),
                      );
                    });
              } else {
                return const Center(
                  child: Text("Something went wrong."),
                );
              }
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          child: Icon(Icons.add, color: Colors.white),
          onPressed: () async {
            // Perform action when button is pressed
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddNewBlogPage()),
            ).then((value) {
              getBlogs(); // Reload the data after adding a new item
            });
          },
        ),
      ),
    );
  }

  Future<BlogListResponseModel>? getBlogs() async {
    BlogBloc blogBloc = BlogBloc();
    // for auto update
    setState(() {});
    try {
      return await blogBloc.getListProducts();
    } catch (e) {
      print(e);
    }
    return BlogListResponseModel({'': ''});
  }
}
