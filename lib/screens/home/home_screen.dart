import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:research_praneetha/database.dart';
import 'package:research_praneetha/providers/auth.dart';
import 'package:research_praneetha/screens/receivePost/receive_post_screen.dart';
import 'package:research_praneetha/screens/sendPost/send_post_screen.dart';

import '../../constants.dart';
import '../../size_config.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _isLoading = false;
  int index = 1;
  var _isInit = true;
  var userDetails;

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

  // void didChangeDependencies() {
  //   print(_isInit);
  //   if (_isInit) {
  //     print('555555');
  //     setState(() {
  //       _isLoading = true;
  //     });
  //     print('222222');
  //     final email = Provider.of<Auth>(context, listen: false).email;
  //     userDetails = db.getUserDetails(email, context).then((_) {
  //       setState(() {
  //         _isLoading = false;
  //       });
  //     });

  //     _isInit = false;
  //   }

  //   super.didChangeDependencies();
  // }

  Widget buildBottomNavigationBar() {
    final inactiveColor = Colors.grey;
    return BottomNavyBar(
      backgroundColor: Colors.black,
      selectedIndex: index,
      onItemSelected: (index) => setState(() => this.index = index),
      items: <BottomNavyBarItem>[
        BottomNavyBarItem(
          icon: Icon(Icons.people),
          title: Text('My Profile'),
          textAlign: TextAlign.center,
          inactiveColor: inactiveColor,
        ),
        BottomNavyBarItem(
          icon: Icon(Icons.home),
          title: Text('Home'),
          textAlign: TextAlign.center,
          inactiveColor: inactiveColor,
        ),
        BottomNavyBarItem(
          icon: Icon(Icons.message),
          title: Text('Notifications'),
          textAlign: TextAlign.center,
          inactiveColor: inactiveColor,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var name = ' ';
    var email = ' ';
    var address = ' ';
    var postBoxId = ' ';

    // if (userDetails != null) {
    //   name = '${userDetails['firstName']} ${userDetails['lastName']}';
    //   email = userDetails['email'];
    //   postBoxId = userDetails['postBoxId'];
    //   address = userDetails['address'];
    // }

//height
    final height = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;
    print(index);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      bottomNavigationBar: buildBottomNavigationBar(),
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
          : Column(children: <Widget>[
              Container(
                  height: height * .2,
                  width: double.infinity,
                  decoration: new BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Smart',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: height * .05,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        'Postal Service',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: height * .05,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  )),
              if (index == 1)
                Container(
                  padding:
                      EdgeInsets.only(top: getProportionateScreenHeight(10)),
                  height: height * .8,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Text(
                          'Our services',
                          style: TextStyle(
                              fontSize: getProportionateScreenWidth(15),
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () => Navigator.pushNamed(
                                  context, SendPostScreen.routeName),
                              child: buildBigCard('Send', 'post'),
                            ),
                            GestureDetector(
                              onTap: () => Navigator.pushNamed(
                                  context, ReceivePostScreen.routeName),
                              // Navigator.pushNamed(context, ReceivePostScreen.routeName),
                              child: buildBigCard('Receive', 'post'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              else if (index == 2)
                Container(
                  height: height * .8,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: SingleChildScrollView(
                          child: Column(children: <Widget>[]),
                        ),
                      ),
                    ),
                  ),
                )
              else if (index == 0)
                Container(
                  height: height * .8,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Text(
                          'My details',
                          style: TextStyle(
                              fontSize: getProportionateScreenWidth(15),
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        Container(
                            child: Column(children: [
                          buildDetailsCard('Name', name),
                          buildDetailsCard('Email', email),
                          buildDetailsCard('Address', address),
                          buildDetailsCard('PostalBoxNo', postBoxId),
                        ])),
                      ],
                    ),
                  ),
                ),
            ]),
    );
  }

  Container buildBigCard(String title1, String title2) {
    return Container(
      margin: EdgeInsets.only(
          top: getProportionateScreenHeight(20),
          right: getProportionateScreenHeight(10),
          left: getProportionateScreenHeight(10)),
      height: getProportionateScreenHeight(250),
      width: getProportionateScreenWidth(150),
      child: Card(
        elevation: 6,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title1,
              style: TextStyle(fontSize: getProportionateScreenHeight(35)),
            ),
            Text(
              title2,
              style: TextStyle(fontSize: getProportionateScreenHeight(17)),
            ),
          ],
        ),
      ),
    );
  }

  Container buildDetailsCard(String title, String name) {
    return Container(
      margin: EdgeInsets.only(
        top: getProportionateScreenHeight(10),
      ),
      width: getProportionateScreenWidth(300),
      child: Card(
        elevation: 6,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              color: kPrimaryColor,
              padding: EdgeInsets.all(getProportionateScreenHeight(10)),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: getProportionateScreenHeight(17),
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(getProportionateScreenHeight(10)),
              child: Text(
                name,
                style: TextStyle(
                  fontSize: getProportionateScreenHeight(17),
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
