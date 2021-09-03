import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../size_config.dart';
import 'body_confirm_receiver_details_screen.dart';
import 'body_send_post_screen.dart';

class ConfirmReceiverDetailsScreen extends StatelessWidget {
  static const routeName = '/confirm-receiver-details';

  @override
  Widget build(BuildContext context) {
    final userDetails = ModalRoute.of(context).settings.arguments as List;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'confirm receiver details',
          style: TextStyle(
            color: kPrimaryColor,
            fontWeight: FontWeight.bold,
            fontSize: getProportionateScreenHeight(20),
          ),
          textAlign: TextAlign.center,
        ),
      ),
      body: BodyConfirmReceiverDetailsScreen(userDetails),
    );
  }
}
