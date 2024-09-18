// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_injector.dart';

// **************************************************************************
// KiwiInjectorGenerator
// **************************************************************************

class _$AppInjector extends AppInjector {
  @override
  void _controllerComponents() {
    final KiwiContainer container = KiwiContainer();
    container
      ..registerFactory(
          (c) => ChatUsersListController(c.resolve<ChatRepository>()))
      ..registerFactory((c) => DashboardController())
      ..registerFactory((c) => LoginController(c.resolve<AuthRepository>()))
      ..registerFactory((c) => SignUpController(c.resolve<AuthRepository>()));
  }

  @override
  void _repositoryComponents() {
    final KiwiContainer container = KiwiContainer();
    container
      ..registerSingleton<ChatRepository>((c) => ChatRepositoryImpl())
      ..registerSingleton<AuthRepository>((c) => AuthRepositoryImpl());
  }
}
