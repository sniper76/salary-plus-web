import 'package:equatable/equatable.dart';

abstract class BaseState extends Equatable {
  final bool isLoading;
  final String errorToastMessage;
  final String notiToastMessage;

  const BaseState({
    this.isLoading = false,
    this.errorToastMessage = '',
    this.notiToastMessage = '',
  });

  @override
  List<Object?> get props => [isLoading, errorToastMessage, notiToastMessage];
}
