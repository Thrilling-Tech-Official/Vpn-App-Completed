import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vpn_app/Views/Screens/HomeScreen.dart';
import 'package:vpn_app/Views/constant.dart';
class Splash_Screen extends StatefulWidget {
  const Splash_Screen({Key? key}) : super(key: key);

  @override
  _Splash_ScreenState createState() => _Splash_ScreenState();
}

class _Splash_ScreenState extends State<Splash_Screen> {

  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(milliseconds: 1500),
            () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => HomeScreen()))

    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(flex:4,child: Container()),
            Expanded(
              flex: 5,
              child: Padding(
                padding:  EdgeInsets.only(top: 20.0,bottom: 60),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(flex:2,
                        child: SvgPicture.asset(
                          'assets/images/logo.svg',).animate().fade().shake()
                    ),
                    // SizedBox(height: 20.h,),
                    Expanded(child: Padding(
                      padding:  EdgeInsets.only(top: 15.0),
                      child: Text(' SwiftShield '.toUpperCase(),
                        style: logoText.copyWith(color: white,fontSize: 25),).animate().fade().slideX(),
                    )),
                    // Expanded(child: Text('Secure. Fast. Stable  ',style: grayTextStyle.copyWith(fontSize: 16,color: halfWhite),).animate().fade().slideY()),

                  ],),
              ),
            ),
           Expanded(flex:3,child: Center(
              child: Container(height: 50,width:50,child: CircularProgressIndicator(color: IconBluecolor,),),
            )),

          ],


        )
    );
  }

}
