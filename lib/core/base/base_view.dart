/**
 * Created by Abdullah on 20/8/24.
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shield/core/base/base_controller.dart';
import 'package:shield/core/di/injector.dart';
import 'package:shield/flavors/app_properties.dart';

/// A base class for all views/screens in the app.
abstract class BaseView<B extends BaseController> extends StatelessWidget {
  B controller = Injector.resolve<B>();

   BaseView({Key? key}) : super(key: key);

  /// Creates the view's widget.
  Widget body(BuildContext context);

  @override
  Widget build(BuildContext context) {
    // Use GetBuilder or Obx based on your requirement
    return Scaffold(
      appBar: AppBar(
        title: Text(AppProperties.title),
      ),
      body: body(context),
    );
  }

}