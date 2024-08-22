import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shield/core/di/injector.dart';
import 'package:shield/core/widgets/app_loader.dart';
import 'package:shield/flavors/app_properties.dart';
import 'package:get/get.dart';
import 'base_controller.dart';
import 'base_page_state.dart';

/**
 * Created by Abdullah on 20/8/24.
 */

abstract class BaseViewState<S extends StatefulWidget, B extends BaseController>
    extends State<S> {
  B controller = Injector.resolve<B>();

  var isShowBackButton = true;

  Widget body(BuildContext context);

  GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();

  PreferredSizeWidget? appBar() {}

  bool resizeToAvoidBottomInset() {
    return true;
  }

  EdgeInsets setPagePadding() {
    return EdgeInsets.zero;
  }

  Widget setBackground() {
    return const SizedBox();
  }

  late BuildContext context;

  @override
  Widget build(BuildContext context) {
    this.context = context;

    return GestureDetector(
      child: MediaQuery(
          data: MediaQueryData.fromView(View.of(context)).copyWith(
              boldText: false, textScaler: const TextScaler.linear(1.0)),
          child: pageScaffold(
            context,
          )),
    );
  }

  Widget pageScaffold(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      drawerEnableOpenDragGesture: false,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset(),
      key: globalKey,
      appBar: appBar(),
      floatingActionButton: floatingActionButton(),
      body: Stack(
        children: [
          setBackground(),
          SafeArea(child: _getPageContent()),
          Obx(() => controller.pageState == PageState.LOADING
              ? _showLoader()
              : const SizedBox()),
        ],
      ),
      bottomNavigationBar: bottomNavigationBar(),
      bottomSheet: bottomSheet(),
      drawer: drawer(),
    );
  }

  Widget _showLoader() {
    return const AppLoader();
  }

  _getPageContent() {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
      child: Padding(
        padding: setPagePadding(),
        child: body(context),
      ),
    );
  }

  Widget? floatingActionButton() {
    return null;
  }

  Widget? bottomNavigationBar() {
    return null;
  }

  Widget? bottomSheet() {
    return null;
  }

  Widget? drawer() {
    return null;
  }

  void closeNavDrawer() {
    if (globalKey.currentState?.isDrawerOpen == true) {
      globalKey.currentState?.openEndDrawer();
    }
  }

  void openNavDrawer() {
    if (controller.pageState != PageState.LOADING) {
      if (globalKey.currentState?.isDrawerOpen ?? false) {
        Get.back();
      } else {
        globalKey.currentState?.openDrawer();
      }
    }
  }

  void onPressedBackButton() {
    if (Get.rawRoute?.isFirst == false) {
      Get.off((route) => route.isFirst);
    } else {
      Get.back();
    }
  }
}
