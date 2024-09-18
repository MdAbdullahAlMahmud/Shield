import 'package:kiwi/kiwi.dart';
import 'package:shield/modules/authentication/data/repository/auth_repository.dart';
import 'package:shield/modules/authentication/data/repository_impl/auth_repository_impl.dart';
import 'package:shield/modules/authentication/features/login/controller/login_controller.dart';
import 'package:shield/modules/authentication/features/sign_up/controller/sign_up_controller.dart';
import 'package:shield/modules/dashboard/features/dahboard/controller/dashboard_controller.dart';
import 'package:shield/modules/messaging/data/repository/chat_repository.dart';
import 'package:shield/modules/messaging/data/repository_impl/chat_repository_impl.dart';
import 'package:shield/modules/messaging/features/chat_users_list/controller/chat_users_list_controller.dart';

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

  @Register.factory(ChatUsersListController)
  @Register.factory(DashboardController)
  @Register.factory(LoginController)
  @Register.factory(SignUpController)
  void _controllerComponents();

  @Register.singleton(ChatRepository, from: ChatRepositoryImpl)
  @Register.singleton(AuthRepository, from: AuthRepositoryImpl)
  void _repositoryComponents();
}