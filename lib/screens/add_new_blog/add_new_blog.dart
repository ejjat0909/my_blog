import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_blog/bloc/blog_bloc.dart';
import 'package:my_blog/models/add_blog_request_model.dart';
import 'package:my_blog/models/blog_model.dart';
import 'package:my_blog/models/default_response_model.dart';

class AddNewBlogPage extends StatefulWidget {
  final Function(BlogModel)? addNewBlog;
  const AddNewBlogPage({super.key, this.addNewBlog});

  @override
  State<AddNewBlogPage> createState() => _AddNewBlogPageState();
}

class _AddNewBlogPageState extends State<AddNewBlogPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  BlogBloc blogBloc = BlogBloc();
  AddBlogRequestModel addBlogRequestModel = AddBlogRequestModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: const BackButton(
          color: Colors.black,
        ),
        title: const Text(
          "Add New Blog",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(15),
          width: double.infinity,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              // dalam children  ade list of Widgets
              children: [
                TextFormField(
                  onSaved: (newValue) {
                    addBlogRequestModel.title = newValue;
                  },
                  decoration: const InputDecoration(
                    labelText: "Title",
                  ),
                ),
                TextFormField(
                  maxLines: 5,
                  onSaved: (newValue) {
                    addBlogRequestModel.body = newValue;
                  },
                  decoration: const InputDecoration(
                    hintText: "Body",
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (validateAndSave()) {
                      addNewBlogProcess(addBlogRequestModel);
                    }
                  },
                  child: Text("Add New Blog"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool validateAndSave() {
    final form = _formKey.currentState;

    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  Future<void> addNewBlogProcess(
      AddBlogRequestModel addBlogRequestModel) async {
    DefaultResponseModel responseModel =
        await blogBloc.addNewBlog(addBlogRequestModel);

    if (responseModel.isSuccess) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("add new blog success"),
          ),
        );
        print("add new blog success");

        Navigator.pop(context, responseModel.data);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(responseModel.message),
        ),
      );
    }
  }
}
