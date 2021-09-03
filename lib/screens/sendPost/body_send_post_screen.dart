import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../size_config.dart';
import 'send_post_form.dart';

class BodySendPostScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(20),
          ),
          child: SingleChildScrollView(
            child: Column(children: <Widget>[
              SizedBox(height: getProportionateScreenHeight(30)),
              Text(
                'Let\'s send a mail.',
                style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: getProportionateScreenHeight(40),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Enter your following details',
                style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: getProportionateScreenHeight(20),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: getProportionateScreenHeight(70)),
              SendPostForm(),
            ]),
          ),
        ),
      ),
    );
  }
}
