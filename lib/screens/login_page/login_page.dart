import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:my_blog/bloc/user_bloc.dart';
import 'package:my_blog/models/login_request_model.dart';
import 'package:my_blog/models/user_response_model.dart';
import 'package:my_blog/screens/home_page/home_page.dart';
import 'package:my_blog/screens/register_page/register_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  UserBloc loginBloc = UserBloc();
  LoginRequestModel loginRequestModel = LoginRequestModel();

  @override
  Widget build(BuildContext context) {
    // scaffold means canvas
    return Scaffold(
      backgroundColor: Colors.white,
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
                const Text(
                  "MyBlog",
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  "Design Own Blog",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                TextFormField(
                  onSaved: (newValue) {
                    loginRequestModel.email = newValue;
                  },
                  decoration: const InputDecoration(
                    labelText: "Email",
                    icon: Icon(Icons.email),
                  ),
                ),
                TextFormField(
                  onSaved: (newValue) {
                    loginRequestModel.password = newValue;
                  },
                  decoration: const InputDecoration(
                    labelText: "Password",
                    icon: Icon(Icons.lock),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (validateAndSave()) {
                      loginProcess(loginRequestModel);
                    }
                    // navigate to home page
                  },
                  child: Text("Login"),
                ),
                RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Dont have any account? ',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      TextSpan(
                          text: 'Sign Up',
                          style: TextStyle(
                            color: Colors.blue,
                          ),
                          // text recognzier rich text flutter
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              // navigation
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const RegisterPage(),
                                ),
                              );
                              print('Sign Up Page');
                            }),
                    ],
                  ),
                )
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

  Future<void> loginProcess(LoginRequestModel loginRequestModel) async {
    UserResponseModel responseModel = await loginBloc.login(loginRequestModel);

    if (responseModel.isSuccess) {
      // untuk set access token
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString("access_token", responseModel.data!.accessToken!);

      // what to do when success?
      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(userModel: responseModel.data!),
          ),
        );
      }
    } else {
      // not successful
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(responseModel.message),
        ),
      );
    }
  }
}
