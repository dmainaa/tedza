

import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:tedza_ecommerce/app/app_constants.dart';
import 'package:tedza_ecommerce/domain/models/failure.dart';
import 'package:tedza_ecommerce/domain/usecases/base_usecase.dart';

import '../../app/di/di.dart';
import '../../data/network_service.dart';
import '../models/product.dart';

class TrendingProductsUsecase extends BaseUseCase{
  NetworkService  get networkService => instance<NetworkService>();

  @override
  Future<Either<Failure, RxList<Product>>> execute(input) async {
    RxList<Product> fetchedTrendingProducts = <Product>[].obs;
    final response = await networkService.makeStringGetRequest(
        {}, GET_TRENDING_PRODUCTS_URL);

    if (response.error) {
      return Left(Failure(message: response.errorMessage));
    } else {
      final jsonData = jsonDecode(response.data);

      final productsList = jsonData as List;

      productsList.forEach((product) {
        fetchedTrendingProducts.add(Product.fromJson(product));
      });

      return right(fetchedTrendingProducts);

    }
  }
}