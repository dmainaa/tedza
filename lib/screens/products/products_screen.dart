import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tedza_ecommerce/domain/models/app_state.dart';
import 'package:tedza_ecommerce/screens/common/color_manager.dart';
import 'package:tedza_ecommerce/screens/products/products_viewmodel.dart';

import '../common/error_widget.dart';

class ProductsScreen extends StatefulWidget {



  ProductsScreen({Key? key}) : super(key: key);

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final category = Get.arguments['category'];

  final _productContoller = Get.put(AllProductsController());


  TextEditingController _searchController = TextEditingController();


  @override
  void initState() {
    super.initState();
    _productContoller.getCategoryProducts(category);

    _searchController.addListener(() {
      _productContoller.applyFilter(_searchController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      body: StreamBuilder<AppState>(
        stream: _productContoller.appStateController.stream,
        builder: (context, snapshot){
          AppState appState = snapshot.data ?? AppState.loading;
          if(appState == AppState.loading){
            return Center(child: CircularProgressIndicator(color: AppColors.primary,),);
          }else if(appState == AppState.error){
            return MErrorWidget(errorMessage: _productContoller.errorMessage, onRetry: _productContoller.getCategoryProducts(category), buttonLabel: "Retry");
          }else {
            return _buildBody();
          }

        },
      ),
    );
  }

  PreferredSizeWidget _buildAppbar() {
    return AppBar(
      elevation: 0,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      iconTheme: const IconThemeData(color: Colors.black),
      centerTitle: true,
      leading: IconButton(
        onPressed: (){
        Navigator.of(context).pop(true);
        },
        icon: const Icon(Icons.arrow_back),
      ),
      title: Obx(
        ()=> _productContoller.showTitle.value ?  Text(
          '$category',
          style:
          TextStyle(fontFamily: 'semi-bold', fontSize: 22, color: AppColors.primary),
        ) : Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30), color: Color(0xFF4946DB)),
          child:  TextField(
            style: const TextStyle(color: Colors.white),
            controller: _searchController,
            decoration:  InputDecoration(
                border: InputBorder.none,
                contentPadding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                hintText: 'Search',
                hintStyle: const TextStyle(color: Colors.white),
                suffixIcon: IconButton(
                  onPressed: (){
                    _searchController.text = "";
                    _productContoller.resetSearch();
                  },
                  icon: const Icon(Icons.cancel_outlined),
                  color: Colors.white,
                )),
          ),
        ),
      ),
      actions: [
        Row(
          children: [

            IconButton(
              onPressed: () {
                _productContoller.toggleSearch();
              },
              icon: const Icon(Icons.search_outlined),
            )
          ],
        )
      ],
    );
  }

  Widget _buildBody() {
    return Obx(
        ()=> SingleChildScrollView(

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              shrinkWrap: true,
              childAspectRatio: 55 / 100,
              physics: const ScrollPhysics(),
              children: _productContoller.filteredcategoryProducts.map((e) {
                return InkWell(
                  onTap: () {
                    Get.toNamed("/product", arguments: {
                      "product": e
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 220,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(e.image), fit: BoxFit.cover),
                          ),

                        ),
                        SizedBox(height: 8),
                        Text(e.title,
                            style: const TextStyle(
                              fontSize: 14,
                              fontFamily: 'medium',
                              color: Colors.black,
                            ), maxLines: 2, overflow: TextOverflow.ellipsis,),

                        Text( "\$"+e.price.toString(),
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'medium',
                              color: AppColors.primary,
                            )),
                      ],
                    ),
                  ),
                );
              }).toList(),
            )
          ],
        ),
      ),
    );
  }
}
