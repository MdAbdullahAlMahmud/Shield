import 'package:shield/core/exception/app_exceptions.dart';
import 'package:shield/modules/authentication/data/repository/auth_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/**
 * Created by Abdullah on 21/8/24.
 */

class AuthRepositoryImpl extends AuthRepository {
  final SupabaseClient _client = Supabase.instance.client;

  @override
  Future<AuthResponse> signIn(String email, String password) async {
    return _client.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<AuthResponse> signUp(String email, String password, String name) async {
    return callWithExceptionsHandler<AuthResponse>(
      _client.auth.signUp(
        email: email,
        password: password,
        data: {"name": name},
      ),
      onSuccess: (response) {
        return response; // Optional, as it's already returned from callWithExceptionsHandler
      },
      onError: (exception) {
        // Handle any additional error-specific logic here if needed
      },
    );
  }

}
