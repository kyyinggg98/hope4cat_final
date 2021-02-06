import 'package:flutter/material.dart';
import 'global_state.dart';
import 'screen/splash_screen.dart';
import 'screen/login_screen.dart';
import 'screen/register_screen.dart';
import 'screen/forgot_account_screen.dart';
import 'screen/home_screen.dart';
import 'screen/upload_cat_screen.dart';
import 'screen/profile_screen.dart';
import 'screen/cat_detail_screen.dart';
import 'screen/map_screen.dart';
import 'screen/posted_screen.dart';
import 'screen/edit_profile_screen.dart';
import 'screen/bill_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Global_State _global_key = Global_State.instance;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        "/LoginScreen": (BuildContext context) => Login_Screen(),
        "/RegisterScreen": (BuildContext context) => Register_Screen(),
        "/ForgotAccountScreen": (BuildContext context) => Forgot_Account(),
        "/HomeScreen": (BuildContext context) => Home_Screen(),
        "/UploadCatScreen": (BuildContext context) => Upload_Cat_Screen(),
        "/PostedScreen": (BuildContext context) => Posted_Screen(),
        "/ProfileScreen": (BuildContext context) => Profile_Screen(),
        "/MapScreen": (BuildContext context) => Map_Screen(),
        "/EditProfileScreen": (BuildContext context) => Edit_Profile_Screen(),
        "/BillScreen": (BuildContext context) => Bill_Screen(),
      },
      home: Splash_Screen(),
    );
  }
}
