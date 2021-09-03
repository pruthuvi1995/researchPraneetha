import 'package:flutter/material.dart';
import 'package:research_praneetha/database.dart';

import './body_home_screen.dart';
import '../../constants.dart';
import '../../size_config.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

//height
    final height = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: _isLoading
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Wait...',
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: getProportionateScreenWidth(15),
                    ),
                  ),
                  SizedBox(height: getProportionateScreenWidth(15)),
                  CircularProgressIndicator(),
                ],
              ),
            )
          : BodyHomeScreen(height),
    );
  }

  final appBar = AppBar(
    title: Text(
      'SMART Postal Service',
      style: TextStyle(
        color: kPrimaryColor,
        fontWeight: FontWeight.bold,
        // fontSize: getProportionateScreenHeight(17),
      ),
    ),
  );
}
