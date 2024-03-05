


import 'package:dartz/dartz.dart';
import '../models/failure.dart';


abstract class BaseUseCase<In, Out>{
  //You can create the usecase in anycase that you want
  Future<Either<Failure, Out>> execute(In input);
}