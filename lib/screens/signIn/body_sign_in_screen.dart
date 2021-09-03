import 'package:flutter/material.dart';
import './sign_form.dart';

import '../../size_config.dart';
import '../../constants.dart';
import 'no_account_text.dart';

class BodySignInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenHeight(20),
          ),
          child: SingleChildScrollView(
            child: Column(children: <Widget>[
              SizedBox(
                height: getProportionateScreenHeight(30),
              ),
              Text(
                'SMART',
                style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: getProportionateScreenHeight(40),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Postal Service',
                style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: getProportionateScreenHeight(40),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Please enter your email address and password to login.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: getProportionateScreenHeight(20),
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(70)),
              SignForm(),
              SizedBox(height: getProportionateScreenHeight(20)),
              NoAccountText()
            ]),
          ),
        ),
      ),
    );
  }
}
