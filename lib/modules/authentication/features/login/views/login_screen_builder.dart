import 'package:flutter/material.dart';
import 'package:shield/core/base/base_view_state.dart';
import 'package:shield/core/constants/app_spaces.dart';
import 'package:shield/core/theme/color_palettes.dart';
import 'package:shield/core/widgets/text_filed/input_field.dart';
import 'package:shield/core/widgets/text_filed/input_regex.dart';
import 'package:shield/modules/authentication/features/login/controller/login_controller.dart';
import 'package:shield/router/app_routes.dart';
import 'package:shield/router/route_path.dart';

/**
 * Created by Abdullah on 21/8/24.
 */

class LoginScreenBuilder extends StatefulWidget {
  const LoginScreenBuilder({super.key});

  @override
  State<LoginScreenBuilder> createState() => _LoginScreenBuilderState();
}

class _LoginScreenBuilderState
    extends BaseViewState<LoginScreenBuilder, LoginController> {
  @override
  Widget body(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: controller.loginKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // Logo and Welcome Text
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Welcome Back!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              AppSpaces.spaceBetweenItem,
              InputField(
                controller: controller.emailController,
                regex: InputRegex.NOT_EMPTY,
                label: 'Email',
              ),

              AppSpaces.spaceBetweenItem,

              InputField(
                controller: controller.passwordController,
                label: 'Password',
                obscureText: true,
                suffixIcon: Icon(Icons.visibility_off),
                regex: InputRegex.NOT_EMPTY,
              ),

              AppSpaces.spaceBetweenItem,

              // Login Button
              ElevatedButton(
                onPressed: () {
                  controller.onLoginPressed();
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: Text('Log In', style: TextStyle(fontSize: 18)),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorPalettes.colorPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Or Divider
              Row(
                children: <Widget>[
                  Expanded(child: Divider(thickness: 1)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text("or"),
                  ),
                  Expanded(child: Divider(thickness: 1)),
                ],
              ),
              SizedBox(height: 20),

              // Google Sign-In Button
              ElevatedButton.icon(
                onPressed: () {},
                icon: Icon(Icons.g_mobiledata_outlined, size: 20),
                label: Text('Log in with Google', style: TextStyle(fontSize: 16)),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.white,
                  side: BorderSide(color: Colors.grey),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              SizedBox(height: 10),

              // Apple Sign-In Button
              ElevatedButton.icon(
                onPressed: () {},
                icon: Icon(Icons.apple, size: 20),
                label: Text('Log in with Apple', style: TextStyle(fontSize: 16)),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),

              SizedBox(height: 20),

              // Sign Up Link
              Center(
                child: GestureDetector(
                  onTap: () {
                    AppRoutes.pushNamed(RoutePath.signUp);
                  },
                  child: Text(
                    "Don't have an account? Sign Up",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
