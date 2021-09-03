import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../size_config.dart';
import 'body_send_post_screen.dart';

class SendPostScreen extends StatelessWidget {
  static const routeName = '/send-post';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Send Post',
          style: TextStyle(
            color: kPrimaryColor,
            fontWeight: FontWeight.bold,
            fontSize: getProportionateScreenHeight(20),
          ),
          textAlign: TextAlign.center,
        ),
      ),
      body: BodySendPostScreen(),
    );
  }
}
