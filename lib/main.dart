import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:provider/provider.dart';
import 'package:tedza_ecommerce/app/di/di.dart';

import 'package:tedza_ecommerce/screens/home/home_viewmodel.dart';
import 'package:tedza_ecommerce/screens/landing/landing_page_screen.dart';
import 'package:tedza_ecommerce/screens/login/login_page_screen.dart';
import 'package:tedza_ecommerce/screens/products/product/product_detail_screen.dart';
import 'package:tedza_ecommerce/screens/products/products_screen.dart';
import 'package:tedza_ecommerce/screens/signup/signup_screen.dart';
import 'package:tedza_ecommerce/screens/tabs/tab_view_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await initAppModule();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => const LandingPageScreen()),
        GetPage(
          name: '/login',
          page: () => const LoginPageScreen(),
        ),
        GetPage(
          name: '/signup',
          page: () => const SignUpScreen(),
        ),
        GetPage(
          name: '/main',
          page: () => const TabViewScreen(),
        ),
        GetPage(name: '/products', page: (){

          return ProductsScreen();
        }),
        GetPage(
            name: '/product',
            page: () => const ProductDetailsScreen()),
        // GetPage(
        //   name: '/facilitiesmanagement/facilities',
        //   page: () => const FacilitiesManagement(),
        // ),

      ],
      debugShowCheckedModeBanner: false,
      title: 'FM360',
    );
  }
}

