import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tedza_ecommerce/domain/usecases/categories_usecase.dart';
import 'package:tedza_ecommerce/domain/usecases/product_usecase.dart';
import 'package:tedza_ecommerce/domain/usecases/trending_products_usecase.dart';

import 'package:tedza_ecommerce/screens/home/home_viewmodel.dart';

import '../../data/network_service.dart';
import '../app_utils.dart';

final instance = GetIt.instance;
Future<void> initAppModule()async{

  final sharedPreferences =  await SharedPreferences.getInstance();

  //shared preferences instance
  instance.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  instance.registerLazySingleton<NetworkService>(() => NetworkService());

  instance.registerLazySingleton<AppUtils>(() => AppUtils());

  instance.registerLazySingleton<HomeViewProvider>(() => HomeViewProvider());


  instance.registerLazySingleton<CategoriesUseCase>(() => CategoriesUseCase());

  instance.registerLazySingleton<ProductUseCase>(() => ProductUseCase());

  instance.registerLazySingleton<TrendingProductsUsecase>(() => TrendingProductsUsecase());




}