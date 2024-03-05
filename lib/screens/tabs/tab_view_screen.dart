import 'package:flutter/material.dart';
import 'package:tedza_ecommerce/main.dart';
import 'package:tedza_ecommerce/screens/common/color_manager.dart';

import 'package:tedza_ecommerce/screens/home/home_screen.dart';
import 'package:tedza_ecommerce/screens/settings/settings.dart';

class TabViewScreen extends StatefulWidget {
  const TabViewScreen({Key? key}) : super(key: key);

  @override
  State<TabViewScreen> createState() => _TabViewScreenState();
}

class _TabViewScreenState extends State<TabViewScreen> {

  int _currentIndex = 0;
  var radius = Radius.circular(10);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: (TabBar(
              unselectedLabelColor: Color.fromARGB(255, 185, 196, 207),
              indicatorSize: TabBarIndicatorSize.label,
              indicator: BoxDecoration(
                border: Border(
                  top: BorderSide(color: AppColors.primary, width: 3.0),
                ),
              ),
              labelPadding: const EdgeInsets.symmetric(horizontal: 0),
              labelStyle: const TextStyle(
                fontFamily: 'regular',
                fontSize: 12,
              ),
              onTap: (int index) => setState(() => _currentIndex = index),
              tabs: [
                Tab(
                  icon: Icon(
                    Icons.home,
                    color: _currentIndex == 0
                        ? AppColors.primary
                        : AppColors.greyColor,
                    size: _currentIndex == 0 ? 30 : 20,
                  ),
                ),
                Tab(
                  icon: Icon(
                    Icons.person,
                    color: _currentIndex == 1
                        ? AppColors.primary
                        : AppColors.greyColor,
                    size: _currentIndex == 1 ? 30 : 20,
                  ),
                ),

              ],
            )),
          ),
        ),
        body: const TabBarView(
          physics:  NeverScrollableScrollPhysics(),
          children: [
             HomeScreen(),
             SettingsScreen(),

          ],
        ),
      ),
    );
  }
}
