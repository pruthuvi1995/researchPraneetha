import 'package:flutter/material.dart';
import 'package:research_praneetha/screens/sendPost/send_post_screen.dart';
import '../../database.dart';
import '../../widgets/default_button.dart';
import '../../widgets/form_error.dart';

import '../../size_config.dart';
import 'confirm_receiver_details_screen.dart';

enum DetailsMode { Type, Email, Final }

class SendPostForm extends StatefulWidget {
  @override
  _SendPostFormState createState() => _SendPostFormState();
}

class _SendPostFormState extends State<SendPostForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];
  DetailsMode _detailsMode = DetailsMode.Type;
  var _isLoading = false;

  Database db;

  initialise() {
    db = Database();
    db.initiliase();
  }

  @override
  void initState() {
    super.initState();
    initialise();
  }

  Map<String, String> _detailsData = {
    "type": "",
    "email": "",
  };

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('There is an error.'),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
              onPressed: () {
                Navigator.of(ctx).pop();
                Navigator.of(ctx).pop();
                // Navigator.pushNamed(context, SendPostScreen.routeName);
              },
              child: Text('OK'))
        ],
      ),
    );
  }

  Future<void> _submit(BuildContext context) async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });

    _switchAuthMode();

    if (_detailsMode == DetailsMode.Final) {
      print('13331111');
      final userDetails =
          await db.getUserDetails(_detailsData['email'], context);

      if (userDetails == null) {
        _showErrorDialog(
            'Email does not exist on the database. Please check the email address and try it again.');
      } else {
        Navigator.popAndPushNamed(
            context, ConfirmReceiverDetailsScreen.routeName,
            arguments: [
              userDetails['firstName'],
              userDetails['lastName'],
              userDetails['email'],
              userDetails['postBoxId'],
              userDetails['address'],
            ]);
      }
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _switchAuthMode() {
    if (_detailsMode == DetailsMode.Type) {
      setState(() {
        _detailsMode = DetailsMode.Email;
      });
    } else if (_detailsMode == DetailsMode.Email) {
      setState(() {
        _detailsMode = DetailsMode.Final;
      });
    }
  }

  Container buildBigCard(String title1, Function press) {
    return Container(
      margin: EdgeInsets.only(
          top: getProportionateScreenHeight(20),
          right: getProportionateScreenHeight(10),
          left: getProportionateScreenHeight(10)),
      height: getProportionateScreenHeight(150),
      width: getProportionateScreenWidth(275),
      child: GestureDetector(
        onTap: press,
        child: Card(
          elevation: 6,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title1,
                style: TextStyle(fontSize: getProportionateScreenHeight(30)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.name,
      onSaved: (value) => _detailsData['email'] = value,
      decoration: InputDecoration(
        labelText: 'e-mail',
        hintText: 'E-mail of the receiver',
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'Input your e-mail address';
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Column(children: [
            if (_detailsMode == DetailsMode.Type)
              Container(
                child: Text('Select the type of the post.'),
              ),
            if (_detailsMode == DetailsMode.Email)
              Container(
                child: Text('Enter the email address of the receiver.'),
              ),
            SizedBox(
              height: getProportionateScreenHeight(30),
            ),
            Form(
                key: _formKey,
                child: Column(children: [
                  if (_detailsMode == DetailsMode.Type)
                    buildBigCard(
                      'Registered Post',
                      () => {
                        _detailsData['type'] = 'Registered',
                        _switchAuthMode()
                      },
                    ),
                  SizedBox(
                    height: getProportionateScreenHeight(20),
                  ),
                  if (_detailsMode == DetailsMode.Type)
                    buildBigCard(
                      'Normal Post',
                      () =>
                          {_detailsData['type'] = 'Normal', _switchAuthMode()},
                    ),
                  if (_detailsMode == DetailsMode.Email) buildEmailFormField(),
                  SizedBox(
                    height: getProportionateScreenHeight(30),
                  ),
                  FormError(errors: errors),
                  if (_detailsMode == DetailsMode.Email)
                    DefaultButton(
                      text: 'Next',
                      press: () => {
                        (_isLoading)
                            ? CircularProgressIndicator()
                            : _submit(context)
                      },
                    ),
                  SizedBox(
                    height: getProportionateScreenHeight(30),
                  ),
                ])),
          ]);
  }
}
