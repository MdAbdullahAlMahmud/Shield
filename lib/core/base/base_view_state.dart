import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shield/flavors/app_properties.dart';

import 'base_controller.dart';

/**
 * Created by Abdullah on 20/8/24.
 */


abstract class BaseViewState<S extends StatefulWidget, B extends BaseController> extends State<S> {

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
