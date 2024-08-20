import 'package:shield/core/base/base_controller.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/**
 * Created by Abdullah on 20/8/24.
 */

class SignUpController extends BaseController{
  final SupabaseClient _client = Supabase.instance.client;

  Future<User?> signIn(String email, String password) async {
    AuthResponse response = await _client.auth.signInWithPassword(
      email: email,
      password: password,
    );

    return response.user;
  }

  Future<User?> signUp(String email, String password) async {
    final response = await _client.auth.signUp(
      email: email,
      password: password,
    );

    return response.user;
  }

  Future<void> signOut() async {
    await _client.auth.signOut();
  }
}