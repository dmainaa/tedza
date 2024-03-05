

import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:tedza_ecommerce/app/app_constants.dart';
import 'package:tedza_ecommerce/domain/models/category.dart';
import 'package:tedza_ecommerce/domain/models/failure.dart';
import 'package:tedza_ecommerce/domain/usecases/base_usecase.dart';

import '../../app/di/di.dart';
import '../../data/network_service.dart';

class CategoriesUseCase extends BaseUseCase{



  NetworkService  get networkService => instance<NetworkService>();
  @override
  Future<Either<Failure, RxList<Category>>> execute(input) async{

    RxList<Category> fetchedCategories = <Category>[].obs;
    List<String> categoryImages = ["assets/images/p2.jpg", "assets/images/woman.jpg", "assets/images/man.jpg", "assets/images/woman.jpg", "assets/images/home.jpg"];
    final response = await networkService.makeStringGetRequest(
        {}, GET_CATEGORIES);

    if(response.error){
      //return left sided response with an error message

      return Left(Failure(message: response.errorMessage));
    }else{
      //decode the json response
      final jsonData = jsonDecode(response.data);

      final categoriesList = jsonData as List;
      int count = 0;
      categoriesList.forEach((c) {
        if(count > 4) count = 0;
        String category = c as String;
        fetchedCategories.add(Category(name: category.toUpperCase(), imageRef: categoryImages[count]));
        count++;
      });

      return Right(fetchedCategories);
    }
  }



}