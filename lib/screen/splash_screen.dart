import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';

class Splash_Screen extends StatefulWidget {
  @override
  Splash_Screen_State createState() => Splash_Screen_State();
}

class Splash_Screen_State extends State<Splash_Screen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 2200), () {
      setState(() {
        Navigator.of(context).pushReplacementNamed("/LoginScreen");
        print('navigation');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double _screen_height = MediaQuery.of(context).size.height;
    double _screen_width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        height: _screen_height,
        width: _screen_width,
        color: Colors.white,
        child: Column(
          children: [
            SizedBox(
              height: _screen_height / 4,
            ),
            Image.asset(
              'assets/images/logo.png',
              height: 250,
              width: 250,
            ),
            SizedBox(height: 50),
            CollectionSlideTransition(
              repeat: false,
              children: <Widget>[
                Image.asset(
                  'assets/images/kitty.png',
                  height: 40,
                  width: 40,
                ),
                Image.asset(
                  'assets/images/love3.png',
                  height: 30,
                  width: 30,
                ),
                Image.asset(
                  'assets/images/kitty.png',
                  height: 40,
                  width: 40,
                ),
                Image.asset(
                  'assets/images/love3.png',
                  height: 30,
                  width: 30,
                ),
                Image.asset(
                  'assets/images/kitty.png',
                  height: 40,
                  width: 40,
                ),
                Image.asset(
                  'assets/images/love3.png',
                  height: 30,
                  width: 30,
                ),
                Image.asset(
                  'assets/images/kitty.png',
                  height: 40,
                  width: 40,
                ),
              ],
            ),
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 10.0),
            //   child: Container(
            //     height: 5.0,
            //     width: 250.0,
            //     color: Colors.amberAccent,
            //   ),
            // ),
            SizedBox(height: 20),
            // Container(
            //   color: Colors.amberAccent,
            //   height: 210,
            //   width: 500,
            // )
          ],
        ),
      ),
    );
  }
}
