



import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tedza_ecommerce/app/app_utils.dart';


import '../../../app/di/di.dart';
import '../../../domain/models/product.dart';

class ProductDetailViewModel extends GetxController{



  Rx<bool> isFavourite = false.obs;

  AppUtils appUtils = instance<AppUtils>();


  addProduct(Product product, BuildContext context){

    if(isFavourite.value){


      isFavourite.value = false;
      appUtils.showToast(context, "Removed from favourites");
    }else{

      isFavourite.value = true;
      appUtils.showToast(context, "Added to favourites");
    }
  }

}