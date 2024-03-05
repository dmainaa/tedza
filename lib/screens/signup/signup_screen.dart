import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tedza_ecommerce/app/app_utils.dart';

import '../../app/di/di.dart';
import '../common/color_manager.dart';
import '../common/style_manager.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String DateValue = '1';
  String MonthValue = 'January';
  String YearValue = '2000';
  bool isChecked = false;

  Map<String, bool> List = {
    'Discount And Sales': false,
    'New Stuff': false,
    'Your Exclusives': false,
    'App Partners': false,
  };

  SharedPreferences _preferences  = instance<SharedPreferences>();
  AppUtils _appUtils  = instance<AppUtils>();
  TextEditingController emailEditingController = TextEditingController();
  TextEditingController lastNameEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();
  TextEditingController firstNameEditingConroller = TextEditingController();


  var holder_1 = [];

  getItems() {
    List.forEach((key, value) {
      if (value == true) {
        holder_1.add(key);
      }
    });

    // Printing all selected items on Terminal screen.
    print(holder_1);
    // Here you will get all your selected Checkbox items.

    // Clear array after use.
    holder_1.clear();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: _buildAppBar(),
        body: _buildBody(),
        bottomNavigationBar: _buildBottomNavigationBar(),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      backgroundColor: Colors.white,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(
          Icons.chevron_left,
          color: Colors.black,
        ),
      ),
      title: Text(
        "Sign Up",
        style: TextStyle(color: Colors.black, fontFamily: 'bold', fontSize: 15),
      ),
      centerTitle: true,
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildInputContent('Email', 'Enter email address.', emailEditingController),
            _buildTitle('We\'ll send your order confirmation here.'),
            _buildInputContent('First Name', 'Enter Your First Name.', firstNameEditingConroller),
            _buildInputContent('Last Name', 'Enter Your Last Name.', lastNameEditingController),
            _buildInputContent('Password', 'Enter Your Password.', passwordEditingController),
            _buildTitle('Must be 10 or more characters.'),
            _buildSecondTitle('Date of Birth'),
            _build1DropDownButton()

          ],
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

  Widget _buildTitle(txt) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Wrap(
          children: [
            Text(
              '$txt',
              style: TextStyle(fontSize: 17),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSecondTitle(txt) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Wrap(
          children: [
            Text(
              '$txt',
              style: TextStyle(
                  fontSize: 17, color: Colors.grey, fontFamily: 'bold'),
            ),
          ],
        ),
      ),
    );
  }



  Widget _buildThirdTitle(txt) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Wrap(
          children: [
            Text(
              '$txt',
              style: TextStyle(fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }



  Widget _buildBottomNavigationBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: InkWell(
        onTap: () {

          if(firstNameEditingConroller.text.isNotEmpty
              && lastNameEditingController.text.isNotEmpty
              && emailEditingController.text.isNotEmpty
              && passwordEditingController.text.isNotEmpty
          ){
            _preferences.setString("email", emailEditingController.text.toString());
            _preferences.setString("firstName", firstNameEditingConroller.text.toString());
            _preferences.setString("lastName", lastNameEditingController.text.toString());
            _preferences.setString("password", passwordEditingController.text.toString());
            _preferences.setString("dob", DateValue);

            Get.offAndToNamed('/login');

          }else{
            _appUtils.showToast(context, "Please Enter All The Fields");
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
                'Register',
                style: TextStyle(
                    color: Colors.white, fontSize: 17, fontFamily: 'bold'),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget _build1DropDownButton() {
    return Wrap(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              border: Border.all(color: Colors.grey, style: BorderStyle.solid),
            ),
            child: DropdownButton<String>(
              value: DateValue,
              icon: const Icon(Icons.arrow_drop_down),
              elevation: 16,
              style:  TextStyle(color: AppColors.primary),
              onChanged: (String? newValue) {
                setState(() {
                  DateValue = newValue!;
                });
              },
              items: <String>['1', '2', '3', '4']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              border: Border.all(color: Colors.grey, style: BorderStyle.solid),
            ),
            child: DropdownButton<String>(
              value: MonthValue,
              icon: const Icon(Icons.arrow_drop_down),
              elevation: 16,
              style:  TextStyle(color: AppColors.primary),
              onChanged: (String? newValue) {
                setState(() {
                  MonthValue = newValue!;
                });
              },
              items: <String>[
                'January',
                'February',
                'March',
                'April',
                'May',
                'June'
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              border: Border.all(color: Colors.grey, style: BorderStyle.solid),
            ),
            child: DropdownButton<String>(
              value: YearValue,
              icon: const Icon(Icons.arrow_drop_down),
              elevation: 16,
              style:  TextStyle(color: AppColors.primary),
              onChanged: (String? newValue) {
                setState(() {
                  YearValue = newValue!;
                });
              },
              items: <String>['2000', '2001', '2002', '2003']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
