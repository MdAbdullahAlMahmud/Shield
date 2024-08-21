import 'package:kiwi/kiwi.dart';
import 'package:shield/modules/authentication/data/repository/auth_repository.dart';
import 'package:shield/modules/authentication/data/repository_impl/auth_repository_impl.dart';
import 'package:shield/modules/authentication/features/login/controller/login_controller.dart';
import 'package:shield/modules/authentication/features/sign_up/controller/sign_up_controller.dart';

import 'injector.dart';

/**
 * Created by Abdullah on 20/8/24.
 */

part 'app_injector.g.dart';
abstract class AppInjector extends Injector {

  static configure() {
    Injector.container = KiwiContainer();
    Injector.resolve = Injector.container!.resolve;
    _$AppInjector()._components();
  }

  void _components(){
    _controllerComponents();
    _repositoryComponents();
  }


  @Register.factory(LoginController)
  @Register.factory(SignUpController)
  void _controllerComponents();

  @Register.singleton(AuthRepository, from: AuthRepositoryImpl)
  void _repositoryComponents();
}