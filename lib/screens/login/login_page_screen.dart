import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app/app_utils.dart';
import '../../app/di/di.dart';
import '../common/color_manager.dart';
import '../common/style_manager.dart';


class LoginPageScreen extends StatefulWidget {
  const LoginPageScreen({Key? key}) : super(key: key);

  @override
  State<LoginPageScreen> createState() => _LoginPageScreenState();
}

class _LoginPageScreenState extends State<LoginPageScreen> {

  AppUtils _appUtils  = instance<AppUtils>();
  TextEditingController emailEditingController = TextEditingController();
  TextEditingController passwordEditingConroller = TextEditingController();
  SharedPreferences preferences = instance<SharedPreferences>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: _buildAppBar(),
        body: _buildBody(),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      backgroundColor: Colors.white,

      title: Text(
        "Login",
        style: getRegularStyle(fontSize: 18),
      ),
      centerTitle: true,
    );
  }

  Widget _buildBody() {
    return Center(
      child: SingleChildScrollView(
        reverse: true,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 400,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 20.0,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildInputContent('Email', 'Enter email address.', emailEditingController),
                      _buildInputContent('Password', 'Enter Password.', passwordEditingConroller ),
                      _buildForgotButton(),
                      _buildLoginButton(),
                      _buildTitleNavigate(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputContent(txtttl, txt, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$txtttl',
            style:
            TextStyle(fontSize: 15, fontFamily: 'bold', color: Colors.grey),
          ),
          Container(
            width: double.infinity,
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey.shade50,
                hintText: '$txt',
                contentPadding:
                const EdgeInsets.only(bottom: 8.0, top: 14.0, left: 10),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueAccent),
                ),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildForgotButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        InkWell(
          onTap: () {

          },
          child: Text(
            'Forgot Password ?',
            style: TextStyle(color: AppColors.primary),
          ),
        ),
      ],
    );
  }

  Widget _buildLoginButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 40.0, bottom: 20),
      child: InkWell(
        onTap: () {
          if(emailEditingController.text.isNotEmpty && passwordEditingConroller.text.isNotEmpty){
            String savedEmail = preferences.getString("email") ?? "";
            String savedPassword = preferences.getString("password") ?? "";




            if(savedEmail == emailEditingController.text && savedPassword == passwordEditingConroller.text){
              preferences.setBool('isLoggedIn', true);
              Get.offAndToNamed('/main');
            }else{
              _appUtils.showToast(context, "Invalid Credentials");
            }

          }else{
            _appUtils.showToast(context, "Please enter all the fields");
          }
        },
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 13.0),
          decoration: contentButtonStyle(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Login',
                style: TextStyle(
                    color: Colors.white, fontSize: 17, fontFamily: 'bold'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitleNavigate() {
    return Padding(
      padding: EdgeInsets.only(top: 30),
      child: Wrap(
        children: [
          const Text(
            'Don\'t have an account?',
            style: TextStyle(
                fontFamily: 'medium', color: Colors.black, fontSize: 16),
          ),
          const SizedBox(
            width: 10,
          ),
          InkWell(
            onTap: () {
              Get.toNamed('/signup');
            },
            child: Text(
              'Sign Up',
              style: TextStyle(
                  fontFamily: 'medium', color: AppColors.primary, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
