import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:get/get.dart';
import 'package:tedza_ecommerce/app/di/di.dart';
import 'package:tedza_ecommerce/domain/models/product.dart';
import 'package:tedza_ecommerce/screens/common/color_manager.dart';
import 'package:tedza_ecommerce/screens/common/common_button.dart';

import 'package:tedza_ecommerce/screens/products/product/product_detail_viewmodel.dart';

import '../../common/style_manager.dart';


class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({Key? key}) : super(key: key);

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {

  final product = Get.arguments['product'] as Product;



  var productDetailController = Get.put(ProductDetailViewModel());


  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppbar(),
        backgroundColor: Colors.white,
        body: _buildBody(),
        bottomNavigationBar: _buildBottomNavigationBar(),

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
        icon:  const Icon(Icons.arrow_back, ),
      ),
      title: Text(
        product.title,
        maxLines: 1,
        style:
        TextStyle(fontFamily: 'semi-bold', fontSize: 20, ),
      ),

    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Stack(
        children: [
          _buildProfile(),
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(top: 210, left: 10, right: 10, bottom: 10),
            decoration: BoxDecoration(
              color: Colors.transparent,
            ),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  _buildContent(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildBottomNavigationBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: InkWell(
        onTap: () {

        },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 13.0),
          decoration: contentButtonStyle(),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Add to Cart',
                style: TextStyle(
                    color: Colors.white, fontSize: 17, fontFamily: 'bold'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfile() {
    return Container(
      height: 250,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: NetworkImage(product.image), fit: BoxFit.cover),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.transparent,
                  child: IconButton(
                    icon: Icon(
                      Icons.chevron_left,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),

            ],
          ),
          SizedBox(
            height: 40,
          ),
          Column(
            children: [
               Padding(
                padding: const EdgeInsets.all(10.0),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Obx(
                      ()=> IconButton(
                      onPressed:(){
                        productDetailController.addProduct(product, context);
                      },
                      icon: const Icon(Icons.favorite),
                      color: productDetailController.isFavourite.value ?  Colors.red : Colors.grey,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {


                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.start,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          margin: EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                blurRadius: 20.0,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Text(
                  product.title,
                  textAlign: TextAlign.left,
                  style: const TextStyle(fontFamily: 'bold', fontSize: 17),
                ),
              ),

              Padding(
                padding:
                const EdgeInsets.symmetric( horizontal: 20),
                child: Text(
                  "\$"+product.price.toString(),
                  textAlign: TextAlign.left,
                  style:  TextStyle(fontSize: 17, color: AppColors.primary),
                ),
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: RatingStars(
                  value: product.rate,
                ),
              ),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          margin: EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                blurRadius: 20.0,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Description',
                  style: TextStyle(fontFamily: 'bold', fontSize: 18),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  product.description,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(color: Colors.grey))),
                  ),
                ),

              ],
            ),
          ),
        ),
      ],
    );
  }

}
