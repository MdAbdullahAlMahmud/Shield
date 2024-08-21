import 'package:flutter/cupertino.dart';
import 'package:shield/core/base/base_controller.dart';
import 'package:shield/core/utils/custom_dialog.dart';
import 'package:shield/modules/authentication/data/repository/auth_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/**
 * Created by Abdullah on 20/8/24.
 */

class SignUpController extends BaseController{
  final SupabaseClient _client = Supabase.instance.client;
  final GlobalKey<FormState> signUpKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthRepository _authRepository;

  SignUpController(this._authRepository);


  void signUp(){
    if(signUpKey.currentState!.validate()){
      //requestForSignUp();

    }


  }



  void requestForSignUp() async {

    showCustomDialog("Sign Up Success");

    /*String name = nameController.text;
    String email = emailController.text;
    String password = passwordController.text;
    final response = await _authRepository.signUp(email, password, name);
    if(response.session != null){
      print('Sign Up Success');
    }
    */

  }

}