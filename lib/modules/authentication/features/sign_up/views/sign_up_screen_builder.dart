import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shield/core/base/base_view.dart';
import 'package:shield/core/base/base_view_state.dart';
import 'package:shield/modules/authentication/features/sign_up/controller/sign_up_controller.dart';

/**
 * Created by Abdullah on 20/8/24.
 */

class SignUpScreenBuilder extends StatefulWidget {
  const SignUpScreenBuilder({super.key});

  @override
  State<SignUpScreenBuilder> createState() => _SignUpScreenBuilderState();
}

class _SignUpScreenBuilderState extends BaseViewState<SignUpScreenBuilder,SignUpController> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _signUp() async {
    /*final email = _emailController.text;
    final password = _passwordController.text;
    final user = await _authService.signUp(email, password);
    if (user != null) {
      // Navigate to login screen or show success message
    } else {
      // Show error message
    }*/
  }

  @override
  Widget body(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign Up')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _signUp,
              child: Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }

}