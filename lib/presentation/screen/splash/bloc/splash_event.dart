part of 'splash_bloc.dart';

@immutable
abstract class SplashEvent {
  SplashEvent._();

  factory SplashEvent.initial() = SplashOnInitial;
}

class SplashOnInitial extends SplashEvent {
  SplashOnInitial() : super._();
}
