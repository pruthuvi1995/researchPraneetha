import 'package:flutter/material.dart';
import '../sendPost/send_post_screen.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../constants.dart';
import '../../size_config.dart';

class BodyHomeScreen extends StatefulWidget {
  final double height;
  BodyHomeScreen(this.height);
  @override
  _BodyHomeScreenState createState() => _BodyHomeScreenState(height);
}

class _BodyHomeScreenState extends State<BodyHomeScreen> {
  var _page = 'Home';
  final double height;
  _BodyHomeScreenState(this.height);

  final name = 'Praneetha';

  final email = 'Praneetha@gmail.com';

  final address = 'Batti, Batti, Batti';

  final postBoxNo = '123';

  YoutubePlayerController _controller1 = YoutubePlayerController(
    initialVideoId: 'w8LfuX4BrOY',
    flags: YoutubePlayerFlags(
      autoPlay: false,
      mute: false,
    ),
  );

  YoutubePlayerController _controller2 = YoutubePlayerController(
    initialVideoId: 'OD69bEBZzRU',
    flags: YoutubePlayerFlags(
      autoPlay: false,
      mute: false,
    ),
  );

  YoutubePlayerController _controller3 = YoutubePlayerController(
    initialVideoId: 'Sa_4Ruu8cUM',
    flags: YoutubePlayerFlags(
      autoPlay: false,
      mute: false,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Container(
          height: height * .25,
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
                'Hi...........',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: height * .05,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              Text(
                'Have a nice day!',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: height * .05,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ],
          )),
      if (_page == 'Home')
        Container(
          padding: EdgeInsets.only(top: getProportionateScreenHeight(10)),
          height: height * .6,
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
                      onTap: () => {},
                      // Navigator.pushNamed(context, ReceivePostScreen.routeName),
                      child: buildBigCard('Receive', 'post'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
      else if (_page == 'Instructions')
        Container(
          height: height * .6,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(children: <Widget>[
                    Text(
                      'Before use the app please refer below instructions.',
                      style: TextStyle(
                        fontSize: getProportionateScreenWidth(17),
                        color: Colors.black,
                      ),
                    ),
                    Divider(),
                    Text(
                      'How to install the app?',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: getProportionateScreenWidth(15),
                        color: Colors.black,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    Divider(),
                    YoutubePlayer(
                      controller: _controller1,
                      bottomActions: [
                        CurrentPosition(),
                        ProgressBar(isExpanded: true),
                        PlayPauseButton(),
                        // FullScreenButton(),
                      ],
                      showVideoProgressIndicator: true,
                      progressIndicatorColor: Colors.redAccent,
                    ),
                    Divider(),
                    Text(
                      'How to create an account?',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: getProportionateScreenWidth(15),
                        color: Colors.black,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    Divider(),
                    YoutubePlayer(
                      controller: _controller2,
                      bottomActions: [
                        CurrentPosition(),
                        ProgressBar(isExpanded: true),
                        PlayPauseButton(),
                        // FullScreenButton(),
                      ],
                      showVideoProgressIndicator: true,
                      progressIndicatorColor: Colors.redAccent,
                    ),
                    Divider(),
                    Text(
                      'How to send a post?',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: getProportionateScreenWidth(15),
                        color: Colors.black,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    Divider(),
                    YoutubePlayer(
                      controller: _controller3,
                      bottomActions: [
                        CurrentPosition(),
                        ProgressBar(isExpanded: true),
                        PlayPauseButton(),
                        // FullScreenButton(),
                      ],
                      showVideoProgressIndicator: true,
                      progressIndicatorColor: Colors.redAccent,
                    ),
                  ]),
                ),
              ),
            ),
          ),
        )
      else if (_page == 'My Profile')
        Container(
          height: height * .6,
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
                  buildDetailsCard('PostalBoxNo', postBoxNo),
                ])),
              ],
            ),
          ),
        ),
      Container(
        height: height * .15,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            buildCircle('Instructions', height),
            buildCircle('Home', height),
            buildCircle('My Profile', height),
          ],
        ),
      ),
    ]);
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

  Widget buildCircle(String page, double height) {
    var iconStyle;
    if (page == 'Home')
      iconStyle = Icons.home;
    else if (page == 'Instructions')
      iconStyle = Icons.support_agent_outlined;
    else if (page == 'My Profile') iconStyle = Icons.people_outline;
    return Column(
      children: [
        Text(page),
        Container(
          width: getProportionateScreenWidth(height * .08),
          height: getProportionateScreenWidth(height * .08),
          decoration: new BoxDecoration(
            color: kPrimaryColor,
            shape: BoxShape.circle,
          ),
          padding: EdgeInsets.all(height * .001),
          margin: EdgeInsets.all(height * .01),
          child: GestureDetector(
            onTap: () {
              setState(() {
                _page = page;
              });
            },
            child: Icon(
              iconStyle,
              size: getProportionateScreenWidth(35),
              color: Colors.white,
            ),
          ),
        ),
      ],
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
}
