import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:research_praneetha/providers/auth.dart';

import '../../constants.dart';
import '../../database.dart';
import '../../size_config.dart';
import 'send_post_form.dart';

enum Mode { ConfirmDetails, Final }

class BodyConfirmReceiverDetailsScreen extends StatefulWidget {
  final userDetails;

  BodyConfirmReceiverDetailsScreen(this.userDetails);

  @override
  _BodyConfirmReceiverDetailsScreenState createState() =>
      _BodyConfirmReceiverDetailsScreenState();
}

class _BodyConfirmReceiverDetailsScreenState
    extends State<BodyConfirmReceiverDetailsScreen> {
  Mode _mode = Mode.ConfirmDetails;
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

  void _showErrorDialog(String title, String msg) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: Text(msg),
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

  @override
  Widget build(BuildContext context) {
    final firstName = widget.userDetails[0];
    final lastName = widget.userDetails[1];
    final email = widget.userDetails[2];
    final postBoxId = widget.userDetails[3];
    final address = widget.userDetails[4];
    final senderEmailAddress = Provider.of<Auth>(context).email;
    ;
    final placeId = '123456789';

    return SafeArea(
        child: _mode == Mode.ConfirmDetails
            ? SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: SingleChildScrollView(
                    child: Column(children: <Widget>[
                      // SizedBox(height:),
                      buildDetailsCard('First Name', firstName),
                      buildDetailsCard('Last Name', lastName),
                      buildDetailsCard('E-mail', email),
                      buildDetailsCard('Post Box Id', postBoxId),
                      buildDetailsCard('Address', address),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child: GestureDetector(
                              onTap: () {
                                _showErrorDialog(
                                    'Your details are not correct.',
                                    'Please check the details and try it again.');
                              },

                              // subscribeOnTap(navigation, isSubscribed, token);
                              // },
                              child: Container(
                                margin: EdgeInsets.only(
                                  left: 5,
                                  right: 5,
                                  bottom: 5,
                                ),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.red,
                                ),
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  'Not Correct',
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child: GestureDetector(
                              onTap: () async {
                                await db.createPost(senderEmailAddress, email,
                                    'Sender\'s home', placeId);
                                setState(() {
                                  _showErrorDialog(
                                      'You are successfully send the mail.',
                                      'Please inform the receiver.');
                                });
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                  left: 5,
                                  right: 5,
                                  bottom: 5,
                                ),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Color(0xFF14a96b),
                                ),
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  'Correct',
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ]),
                  ),
                ),
              )
            : Center(
                child: Card(
                  child: Column(
                    children: [
                      Text('You are successfully send the mail.'),
                      FlatButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            // Navigator.of(context).pop();
                            // Navigator.pushNamed(context, SendPostScreen.routeName);
                          },
                          child: Text('OK'))
                    ],
                  ),
                ),
              ));
  }

  Container buildDetailsCard(String title, String name) {
    return Container(
      margin: EdgeInsets.only(
        top: 10,
      ),
      width: 300,
      child: Card(
        elevation: 6,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              color: kPrimaryColor,
              padding: EdgeInsets.all(5),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(10),
              child: Text(
                name,
                style: TextStyle(
                  fontSize: 17,
                  color: kPrimaryColor,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
