import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tedza_ecommerce/screens/common/color_manager.dart';

import '../../app/app_utils.dart';
import '../../app/di/di.dart';
import '../common/style_manager.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  DateTime date = DateTime(2022, 12, 24);

  String gender = 'Male';

  String firstName = '';
  String lastName = '';
  String email = '';
  String password = '';

  SharedPreferences _preferences  = instance<SharedPreferences>();
  AppUtils _appUtils  = instance<AppUtils>();
  TextEditingController emailEditingController = TextEditingController();
  TextEditingController lastNameEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();
  TextEditingController firstNameEditingConroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: _buildBody(),
        appBar: _buildAppBar(),
        bottomNavigationBar: _buildBottomNavigationBar(),
      ),
    );
  }


  @override
  void initState() {
    super.initState();
    emailEditingController.text = _preferences.getString('email') ?? '';
    firstNameEditingConroller.text = _preferences.getString('firstName') ?? '';
    lastNameEditingController.text = _preferences.getString('lastName') ?? '';
    passwordEditingController.text = _preferences.getString('password') ?? '';

    setState(() {

    });
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
        'My Details',
        style: TextStyle(color: Colors.black, fontSize: 15),
      ),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            _buildInputContent('First Name', 'Enter your first name.', firstNameEditingConroller),
            _buildInputContent('Last Name', 'Enter your last name.', lastNameEditingController),
            _buildInputContent('Email Address', 'Enter your email address.', emailEditingController),
            _buildInputContent('Password', 'Enter your email address.', passwordEditingController),
            _buildDateAndTime(),

          ],
        ),
      ),
    );
  }

  Widget _buildInputContent(txtttl, txt, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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

  Widget _buildDateAndTime() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Date Of Birth',
              style: TextStyle(
                  fontSize: 15, fontFamily: 'bold', color: Colors.grey),
            ),
            SizedBox(
              width: double.infinity,
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton.icon(
                      icon: Icon(Icons.add),
                      onPressed: () async {
                        DateTime? newDate = await showDatePicker(
                          context: context,
                          initialDate: date,
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2100),
                          helpText: 'Select Your Birth Date',
                          builder: (context, child) {
                            return Theme(
                              data: Theme.of(context).copyWith(
                                colorScheme: ColorScheme.light(
                                  primary:
                                  AppColors.primary, // header background color
                                  onPrimary: Colors.black, // header text color
                                  onSurface: Colors.black, // body text color
                                ),
                                textButtonTheme: TextButtonThemeData(
                                  style: TextButton.styleFrom(
                                    primary:
                                    AppColors.primary, // button text color
                                  ),
                                ),
                              ),
                              child: child!,
                            );
                          },
                        );
                        if (newDate == null) return;
                        setState(() => date = newDate);
                      },
                      label: Text(
                        '${date.day}/${date.month}/${date.year}',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 13),
                      child: Icon(
                        Icons.calendar_today,
                        color: Colors.grey,
                      ),
                    )
                  ],
                ),
              ),
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
            _preferences.setString("dob", date.toString());


            _appUtils.showToast(context, "Saved Successfully");

          }else{
            _appUtils.showToast(context, "Please Enter All The Fields");
          }
          //
        },
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 13.0),
          decoration: contentButtonStyle(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Save Changes',
                style: TextStyle(
                    color: Colors.white, fontSize: 17, fontFamily: 'bold'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
