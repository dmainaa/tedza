import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:tedza_ecommerce/app/di/di.dart';
import 'package:tedza_ecommerce/domain/models/app_state.dart';
import 'package:tedza_ecommerce/screens/common/color_manager.dart';
import 'package:tedza_ecommerce/screens/common/error_widget.dart';
import 'package:tedza_ecommerce/screens/common/style_manager.dart';
import 'package:tedza_ecommerce/screens/home/home_viewmodel.dart';

import '../../domain/models/category.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {



 final _provider = Get.put(HomeViewProvider());

 int _current = 0;

 final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: _buildAppbar(),
      body: StreamBuilder(
        stream: _provider.appStateController.stream,
        builder: (context, snapshot){
          AppState appState = snapshot.data ?? AppState.loading;
          if(appState == AppState.loading){
            return Center(child: CircularProgressIndicator(color: AppColors.primary,),);
          }else if(appState == AppState.error){
            return MErrorWidget(errorMessage: _provider.errorMessage, onRetry: _provider.getTrendingProducts(), buttonLabel: "Retry");
          }else {
            return _buildBody();
          }
        }),

    );
  }


  @override
  void initState() {
    super.initState();
    _provider.getTrendingProducts();
  }

  Widget _buildBody() {
    return SingleChildScrollView(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(padding: EdgeInsets.only(left: 10), child: Text(
                    'TRENDING PRODUCTS',
                    style: getSemiBoldStyle(fontSize: 18.0),
                  ),),
                ),
                _itemCarausl(),
                Container(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'SHOP BY PRODUCT',
                            style: getSemiBoldStyle(fontSize: 18.0),
                          ),

                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Obx(
                        () => Container(
                          child: GridView.count(
                            shrinkWrap: true,
                            crossAxisCount: 2,
                            childAspectRatio: 70 / 100,
                            physics: ScrollPhysics(),
                            children: _provider.productCategories.map((e) {
                              return InkWell(
                                onTap: () {
                                  Get.toNamed("/products", arguments: {
                                    "category": e.name
                                  });

                                },
                                child: Card(

                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.only(top: 10),
                                        height: 150,
                                        width: 150,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage(e.imageRef),
                                                fit: BoxFit.fill)),

                                      ),
                                      Container(
                                        padding: EdgeInsets.all(5),
                                        child: Column(
                                          children: [
                                            Text(
                                              (e.name),
                                              style: TextStyle(fontSize: 14),
                                            ),

                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );

  }

  PreferredSizeWidget _buildAppbar() {
    return AppBar(
      elevation: 0,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.black),
      centerTitle: true,

      title: Text(
        'Tedza Ecommerce',
        style: getRegularStyle(fontSize: 22, color: AppColors.primary),
      ),

    );
  }

 Widget _itemCarausl() {
   return Builder(
     builder: (context) {
       return Obx( () =>
         Column(
           children: [
             CarouselSlider(
               options: CarouselOptions(
                   height: 450,
                   viewportFraction: 1.0,
                   enlargeCenterPage: false,
                   onPageChanged: (index, reason) {
                     setState(() {
                       _current = index;
                     });
                   }
                 // autoPlay: true,
               ),
               items: _provider.trendingProducts
                   .map((product) => Container(
                 padding: EdgeInsets.all(16),
                 child: Center(
                     child: Image.network(
                       product.image,
                       fit: BoxFit.cover,
                       width: MediaQuery.of(context).size.width * 1,
                       height: MediaQuery.of(context).size.height * .8,
                     )),
               ))
                   .toList(),
               carouselController: _controller,
             ),
             Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: _provider.trendingProducts.asMap().entries.map((entry) {
                 return GestureDetector(
                   onTap: () => _controller.animateToPage(entry.key),
                   child: Container(
                     width: 8.0,
                     height: 8.0,
                     margin:
                     const EdgeInsets.symmetric(vertical: 0.0, horizontal: 4.0),
                     decoration: BoxDecoration(
                         shape: BoxShape.circle,
                         color: (Theme.of(context).brightness == Brightness.dark
                             ? Colors.white
                             : Colors.black)
                             .withOpacity(_current == entry.key ? 0.4 : 0.2)),
                   ),
                 );
               }).toList(),
             )
           ],
         ),
       );
     },
   );
 }
}


