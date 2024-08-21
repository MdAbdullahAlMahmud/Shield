import 'package:supabase_flutter/supabase_flutter.dart';

/**
 * Created by Abdullah on 21/8/24.
 */

abstract class AuthRepository {
  Future<AuthResponse> signIn(String email, String password);
  Future<AuthResponse> signUp(String email, String password, String name);
}