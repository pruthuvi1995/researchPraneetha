import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:research_praneetha/screens/sendPost/confirm_receiver_details_screen.dart';
// import 'package:research_praneetha/screens/postDetails/details_screen.dart';
import './screens/home/home_screen.dart';

import 'providers/auth.dart';

import './theme.dart';
import 'screens/register/register_screen.dart';
import 'screens/sendPost/send_post_screen.dart';
import 'screens/signIn/sign_in_screen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
            title: 'Praneetha',
            theme: theme(),
            // home: auth.isAuth ? HomeScreen() : SignInScreen(),
            home: HomeScreen(),
            routes: {
              RegisterScreen.routeName: (ctx) => RegisterScreen(),
              SendPostScreen.routeName: (ctx) => SendPostScreen(),
              ConfirmReceiverDetailsScreen.routeName: (ctx) =>
                  ConfirmReceiverDetailsScreen(),
            }),
      ),
    );
  }
}
