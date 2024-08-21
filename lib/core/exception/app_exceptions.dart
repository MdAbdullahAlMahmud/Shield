import 'package:shield/core/utils/custom_dialog.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/**
 * Created by Abdullah on 21/8/24.
 */

Future<T> callWithExceptionsHandler<T>(
    Future<T> future, {
      Function(Exception exception)? onError,
      Function(T response)? onSuccess,
    }) async {
  try {
    T response = await future;

    if (onSuccess != null) {
      onSuccess(response);
    }

    return response; // Ensure that the response is returned correctly
  } on AuthException catch (e) {
    print('AuthException::::::: ${e}');
    showCustomDialog(
        title: 'Error',
        e.message);
    if (onError != null) {
      onError(e);
    }
    rethrow; // Rethrow the exception so it can be handled further up the call stack
  } on Exception catch (e) {
    showCustomDialog(
        title: 'Error',
        e.toString());
    print('Exception::::::: ${e}');
    if (onError != null) {
      onError(e);
    }
    rethrow; // Rethrow the exception to maintain the Future's error state
  }
}


