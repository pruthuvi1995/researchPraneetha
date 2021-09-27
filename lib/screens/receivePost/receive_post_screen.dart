import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../size_config.dart';
import 'body_receive_post_screen.dart';

class ReceivePostScreen extends StatelessWidget {
  static const routeName = '/receive-post';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Receive Post',
          style: TextStyle(
            color: kPrimaryColor,
            fontWeight: FontWeight.bold,
            fontSize: getProportionateScreenHeight(20),
          ),
          textAlign: TextAlign.center,
        ),
      ),
      body: BodyReceivePostScreen(),
    );
  }
}
