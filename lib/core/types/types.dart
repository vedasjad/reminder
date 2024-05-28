import 'package:dartz/dartz.dart';

import '../failures/failures.dart';

typedef ResultFuture<T> = Future<Either<Failure, T>>;

typedef ResultVoid = ResultFuture<void>;

typedef DataMap = Map<String, dynamic>;

typedef DynamicRouteCreator<T> = String Function(T value);
