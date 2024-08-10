part of 'splash_bloc.dart';

@immutable
class SplashState extends BaseState {
  final bool enableApiServer;
  final bool isCompleted;
  final String? onNavigateRouteName;

  const SplashState({
    bool isLoading = false,
    String? errorToastMessage,
    this.enableApiServer = true,
    this.isCompleted = false,
    this.onNavigateRouteName,
  }) : super(isLoading: isLoading, errorToastMessage: errorToastMessage ?? '');

  SplashState copyWith({
    bool? isLoading,
    String? errorToastMessage,
    bool? enableApiServer,
    bool? isCompleted,
    String? onNavigateRouteName,
  }) {
    return SplashState(
      isLoading: isLoading ?? this.isLoading,
      errorToastMessage: errorToastMessage ?? '',
      enableApiServer: enableApiServer ?? this.enableApiServer,
      isCompleted: isCompleted ?? this.isCompleted,
      onNavigateRouteName: onNavigateRouteName ?? this.onNavigateRouteName,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        errorToastMessage,
        enableApiServer,
        isCompleted,
        onNavigateRouteName,
      ];
}
