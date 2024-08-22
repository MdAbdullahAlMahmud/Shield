import 'package:flutter/material.dart';
import 'package:shield/core/base/base_view_state.dart';
import 'package:shield/modules/authentication/features/sign_up/controller/sign_up_controller.dart';
import 'package:shield/router/app_routes.dart';
import 'package:shield/router/route_path.dart';

/**
 * Created by Abdullah on 20/8/24.
 */

class SignUpScreenBuilder extends StatefulWidget {
  const SignUpScreenBuilder({super.key});

  @override
  State<SignUpScreenBuilder> createState() => _SignUpScreenBuilderState();
}

class _SignUpScreenBuilderState extends BaseViewState<SignUpScreenBuilder, SignUpController> {

  @override
  Widget body(BuildContext context) {
    return  Center(
        child: Form(
          key: controller.signUpKey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                // Logo and Welcome Text
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Create your account',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 20),

                // Name Field
                TextField(
                controller: controller.nameController,
                decoration: InputDecoration(
                    labelText: 'Full Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                SizedBox(height: 20),

                // Email Field
                TextField(
                controller: controller.emailController,
                decoration: InputDecoration(
                    labelText: 'Email Address',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                SizedBox(height: 20),

                // Password Field
                TextField(
                controller: controller.passwordController,
                obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    suffixIcon: Icon(Icons.visibility_off),
                  ),
                ),
                SizedBox(height: 20),

                // Sign Up Button
                ElevatedButton(
                  onPressed: () {
                    controller.signUp();
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: Text('Sign Up', style: TextStyle(fontSize: 18)),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
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
                  label: Text('Sign up with Google', style: TextStyle(fontSize: 16)),
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
                  label: Text('Sign up with Apple', style: TextStyle(fontSize: 16)),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.white,
                    side: BorderSide(color: Colors.grey),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),

                SizedBox(height: 20),

                // Sign In Link
                Center(
                  child: GestureDetector(
                    onTap: () {
                     AppRoutes.pushNamed(RoutePath.login);
                    },
                    child: Text(
                      "Already have an account? Sign In",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.blue,
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