import 'package:flutter/cupertino.dart';
import 'package:gotrue/src/types/auth_response.dart';
import 'package:shield/core/base/base_controller.dart';
import 'package:shield/core/data/model/user.dart';
import 'package:shield/core/services/storage/secure_storage.dart';
import 'package:shield/modules/authentication/data/repository/auth_repository.dart';
import 'package:shield/router/app_routes.dart';
import 'package:shield/router/route_path.dart';

/**
 * Created by Abdullah on 20/8/24.
 */

class SignUpController extends BaseController {
  final GlobalKey<FormState> signUpKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthRepository _authRepository;

  SignUpController(this._authRepository);

  void signUp() {
    if (signUpKey.currentState!.validate()) {
      requestForSignUp();
    }
  }

  void onSignUpSuccess(AuthResponse response) {
    if (response.session?.accessToken != null) {
      SecureStorageService.saveToken(response.session?.accessToken ?? "");
      saveUserDataToDatabase(response);
    }
  }

  void requestForSignUp() async {
    String name = nameController.text;
    String email = emailController.text;
    String password = passwordController.text;
    final repo = _authRepository.signUp(email, password, name);

    execute(repo, onSuccess: (response) {
      onSignUpSuccess(response);
    }, onError: () {});
  }

  void saveUserDataToDatabase(AuthResponse response) {
    UserItem user = UserItem(
        uid: response.user?.id,
        name: nameController.text,
        email: emailController.text,
        password: passwordController.text);
    final repo = _authRepository.saveUser(user);

    execute(
      repo,
      onSuccess: (response) {
        AppRoutes.pushAndReplaceNamed(RoutePath.dashboard);
      },
      onError: () {},
    );
  }
}
