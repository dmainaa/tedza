


import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:tedza_ecommerce/domain/usecases/product_usecase.dart';

import '../../domain/models/app_state.dart';
import '../../domain/models/category.dart';
import '../../domain/models/product.dart';

class AllProductsController extends GetxController{

  final ProductUseCase _productsUseCase = GetIt.instance<ProductUseCase>();

  StreamController<AppState> appStateController = StreamController.broadcast();

  Stream<List<Category>>? outputCategory;
  Rx<AppState> appState =  AppState.loading.obs;

  Rx<bool> showTitle =  true.obs;
  
  

  RxList<Product> categoryProducts = <Product>[].obs;
   List<Product> fetchedProducts = [];
  RxList<Product> filteredcategoryProducts = <Product>[].obs;
  

  String errorMessage = "";

  void toggleSearch(){
    showTitle.value = !showTitle.value;
  }
  
  getCategoryProducts(String category) async{
    final  response = await _productsUseCase.execute(category.toLowerCase());

    response.fold((error){
      errorMessage = errorMessage;
      appStateController.add(AppState.error);



    }, (products){
      fetchedProducts = products.value;
      categoryProducts = products;
      filteredcategoryProducts = categoryProducts;
      appStateController.add(AppState.fetchComplete);

    });
    
  }


   resetSearch(){

    filteredcategoryProducts.value = fetchedProducts;
    showTitle.value = true;
  }

   applyFilter(String name){
    var filteredProducts = categoryProducts;
     filteredcategoryProducts.value = filteredProducts.value.where((product) => product.title.contains(name)).toList();
   }






}