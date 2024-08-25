import 'package:flutter/cupertino.dart';

/**
 * Created by Abdullah on 25/8/24.
 */

class HeaderWidget extends StatelessWidget {
  String content;

  HeaderWidget(this.content);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Text(
        content,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
