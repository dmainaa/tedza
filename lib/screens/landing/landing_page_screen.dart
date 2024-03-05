import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app/app_utils.dart';
import '../../app/di/di.dart';
import '../common/color_manager.dart';
import '../common/style_manager.dart';


class LandingPageScreen extends StatefulWidget {
  const LandingPageScreen({Key? key}) : super(key: key);

  @override
  State<LandingPageScreen> createState() => _LandingPageScreenState();
}

class _LandingPageScreenState extends State<LandingPageScreen> {


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: _infoView(context),
        bottomNavigationBar: _buildBottomNavigationBar1(),
      ),
    );
  }

  late SharedPreferences sharedPreferences ;

  AppUtils get appUtils => instance<AppUtils>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
      const Duration(seconds: 3),
          () {
        checkIsLoggedIn();
      },
    );

  }




  Widget _infoView(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 400,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  'assets/images/1.jpg',
                ),
                fit: BoxFit.contain),
          ),
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text(
                'Tedza E-Commerce Shop!',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'bold', fontSize: 20, color: AppColors.primary),
              ),
            ),
            const Text(
              'Your number one online shopping app',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey, fontSize: 15),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSlide2(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 400,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  'assets/images/2.jpg',
                ),
                fit: BoxFit.contain),
          ),
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'Receive High Quality Cloths To You !',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'bold', fontSize: 20, color: AppColors.primary),
              ),
            ),
            const Text(
              'Lorem Ipsum is simply dummy text of the printing  and typesetting industry.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey, fontSize: 15),
            ),
          ],
        ),
      ],
    );
  }

  void checkIsLoggedIn()async{

    sharedPreferences = instance<SharedPreferences>();
    bool isLoggedIn =  sharedPreferences.getBool("isLoggedIn") ?? false;

    if(isLoggedIn){

      Get.offAndToNamed('/main');


    }
  }



  Widget _buildBottomNavigationBar1() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: InkWell(
        onTap: () {
          Get.offAllNamed('/login');
        },
        child: Container(
          height: 50,
          width: double.infinity,
          decoration: contentButtonStyle(),
          child: Center(
            child: Text(
              'Get Started !',
              style: TextStyle(fontFamily: 'bold', color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
