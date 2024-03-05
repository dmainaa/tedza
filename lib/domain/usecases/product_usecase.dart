

import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:tedza_ecommerce/app/app_constants.dart';
import 'package:tedza_ecommerce/domain/models/failure.dart';
import 'package:tedza_ecommerce/domain/usecases/base_usecase.dart';

import '../../app/di/di.dart';
import '../../data/network_service.dart';
import '../models/product.dart';

class ProductUseCase extends BaseUseCase{

  NetworkService  get networkService => instance<NetworkService>();

  @override
  Future<Either<Failure, RxList<Product>>> execute(input) async {
    RxList<Product> fetchedProducts = <Product>[].obs;
    String url = GET_PRODUCTS_URL + input;
    print(url);
    final response = await networkService.makeStringGetRequest(
        {}, url);

    if(response.error){
      return Left(Failure(message: response.errorMessage));
    }else{
      final jsonData = jsonDecode(response.data);

      final productsList = jsonData as List;

      productsList.forEach((product) {
        fetchedProducts.add(Product.fromJson(product));
      });

      return Right(fetchedProducts);
    }

  }
}




