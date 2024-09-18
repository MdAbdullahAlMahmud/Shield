import 'package:flutter/cupertino.dart';
import 'package:shield/core/base/base_controller.dart';
import 'package:shield/core/services/storage/secure_storage.dart';
import 'package:shield/core/utils/custom_dialog.dart';
import 'package:shield/modules/authentication/data/repository/auth_repository.dart';
import 'package:shield/router/app_routes.dart';
import 'package:shield/router/route_path.dart';

/**
 * Created by Abdullah on 21/8/24.
 */

class LoginController extends BaseController {
  AuthRepository authRepository;
  final GlobalKey<FormState> loginKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginController(this.authRepository);

  void onLoginPressed() {
    if (loginKey.currentState!.validate()) {
      requestForLogin(emailController.text, passwordController.text);
    }
  }

  void requestForLogin(String email, String password) async {
    final repo = authRepository.signIn(email, password);
    execute(
      repo,
      onSuccess: (response) {
        if (response.session?.accessToken != null) {
          SecureStorageService.saveToken(response.session?.accessToken ?? "");

          AppRoutes.pushAndReplaceNamed(
            RoutePath.chatUserList,
          );
        }
        showCustomDialog(
            "Login Success: ${response.session?.accessToken ?? ""}");
      },
    );
    // Handle error
  }
}
