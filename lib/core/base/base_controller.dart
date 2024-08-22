/**
 * Created by Abdullah on 20/8/24.
 */

import 'package:get/get.dart';
import 'package:shield/core/exception/app_exceptions.dart';

import 'base_page_state.dart';
class BaseController extends GetxController{

  @override
  void onClose() {
    _pageSateController.close();
    super.onClose();
  }

  //Controls page state
  final _pageSateController = PageState.DEFAULT.obs;

  PageState get pageState => _pageSateController.value;
  updatePageState(PageState state) => _pageSateController(state);
  resetPageState() => _pageSateController(PageState.DEFAULT);
  showLoader() => updatePageState(PageState.LOADING);
  hideLoader() => resetPageState();

  // A method to automatically manage loading, success, and error states
  Future<T> execute<T>(
      Future<T>  asyncFunction,
      {Function(T response)? onSuccess,
        Function()? onError}) async {
    try {
      showLoader();  // Show loader before starting the operation

      T response = await callWithExceptionsHandler(
        asyncFunction,
        onError: (exception) {
          hideLoader();  // Hide loader if an error occurs
          if (onError != null) onError();
        },
        onSuccess: (response) {
          if (onSuccess != null) onSuccess(response);
        },
      );

      hideLoader();  // Hide loader after the operation is complete

      return response;  // Return the response
    } finally {
      hideLoader();  // Ensure loader is hidden if anything goes wrong
    }
  }

}