import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  String get errorMessage => 'Error : $message';

  @override
  List<Object?> get props => [message];
}

class HiveFailure extends Failure {
  const HiveFailure(super.message);

  @override
  List<Object?> get props => [super.message];
}
