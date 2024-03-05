

import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:tedza_ecommerce/app/app_state.dart';
import 'package:tedza_ecommerce/domain/models/app_state.dart';
import 'package:tedza_ecommerce/domain/usecases/categories_usecase.dart';
import 'package:tedza_ecommerce/domain/usecases/trending_products_usecase.dart';

import '../../domain/models/category.dart';
import '../../domain/models/product.dart';



class HomeViewProvider extends GetxController{



  final TrendingProductsUsecase _trendingProductsUseCase = GetIt.instance<TrendingProductsUsecase>();
  final CategoriesUseCase _categoryProductsUseCase = GetIt.instance<CategoriesUseCase>();
  StreamController<AppState> appStateController = StreamController.broadcast();

  Stream<List<Category>>? outputCategory;
  Rx<AppState> appState =  AppState.loading.obs;

  RxList<Product> trendingProducts = <Product>[].obs;
  RxList<Category> productCategories = <Category>[].obs;

  String errorMessage = "";

  HomeViewProvider(){
    appStateController.stream.map((appState) => appState);
  }

  getTrendingProducts()async{
    final  response = await _trendingProductsUseCase.execute(null);

    response.fold((error){
      errorMessage = errorMessage;
      appStateController.add(AppState.error);



    }, (products){
        trendingProducts = products;
        print("Product Length ${trendingProducts.length}");
        getProductCategories();
    });
  }

  getProductCategories()async{

    final  response = await _categoryProductsUseCase.execute(null);

    response.fold((error){
      //handle serverside error
      errorMessage = errorMessage;
      appStateController.add(AppState.error);

    }, (categories){

      productCategories = categories;
      appStateController.add(AppState.fetchComplete);
    });


  }

  getTrendingProduct()async{

    final  response = await _categoryProductsUseCase.execute(null);

    response.fold((error){
      //handle serverside error
      errorMessage = errorMessage;
      appStateController.add(AppState.error);

    }, (categories){

      productCategories = categories;
      appStateController.add(AppState.fetchComplete);
    });


  }









}



