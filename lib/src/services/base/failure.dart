import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  final String message;
  final String devMessage;
  const Failure({required this.message, required this.devMessage});

  @override
  List<Object?> get props => [message, devMessage];
}
