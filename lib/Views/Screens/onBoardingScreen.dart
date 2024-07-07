import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vpn_app/Models/splashScreenContent.dart';
import 'package:vpn_app/Views/Screens/Splash_Screen.dart';
import 'package:vpn_app/Views/constant.dart';
import 'package:vpn_app/Views/customWidget/SimpleButton.dart';
class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  OnBoardingScreenState createState() => OnBoardingScreenState();
}

class OnBoardingScreenState extends State<OnBoardingScreen> {


  int currentIndex = 0;
  PageController? _pagecontroller;

  @override
  void initState() {
    _pagecontroller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pagecontroller!.dispose();
    super.dispose();
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ///Images along text
          Expanded(
            flex: 7,
            child: PageView.builder(
              controller: _pagecontroller,
              itemCount: contents.length,
              onPageChanged: (int index) {
                if(index > 0)
                  setState(() {
                    currentIndex = index;
                  });
                else{
                  return null;
                }
              },
              itemBuilder: (context, i) {
                return Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 30),


                  child: Column(
                    children: [
                      Expanded(flex:1,child: Container()),
                      Expanded(
                          flex:4,
                          child: Padding(
                            padding:  EdgeInsets.symmetric(vertical: 8.0,horizontal:12),
                            child: SvgPicture.asset(
                              contents[i].image,
                              fit: BoxFit.fill,
                            ).animate().fade().slideY(curve: Curves.easeIn),
                          )
                      ),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding:  EdgeInsets.only(top:25),
                          child: Text(
                            contents[i].title,
                            style: boldStyle.copyWith(color: white),
                            textAlign: TextAlign.center,
                          ).animate().fade().slideX(curve: Curves.easeInCirc),
                        ),
                      ),
                      Expanded(
                        flex:2,
                        child: Center(
                          child: Text(
                            contents[i].discription,
                            textAlign: TextAlign.center,
                            style: MediumStyle.copyWith(
                                fontSize: 12, color:halfWhite),
                          ).animate().fade().slideX(curve: Curves.easeInOutBack),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
          ///Dot show Current PAge
          Expanded(
            flex: 1,
            child: Container(
              height: 8,
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  contents.length,
                      (index) => buildDot(index, context),
                ),
              ),
            ),
          ),
          ///Buttons
          Expanded(
              flex: 2,
              child: Padding(
                padding:  EdgeInsets.only(left: 20,right:20,bottom: 5,),
                child: Column(
                  children: [
                    Expanded(
                      flex:2,
                      child: Padding(
                        padding: EdgeInsets.only(left: 3,right: 3,top: 8,bottom: 8),
                        child: SimpleButton(
                          tap: () async {
                            if (currentIndex == contents.length - 1) {
                              var sharedprefernce= await SharedPreferences.getInstance();
                              sharedprefernce.setBool('newUser', true);

                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>  Splash_Screen(),
                                ),
                              );
                            }
                            _pagecontroller?.nextPage(
                              duration: const Duration(milliseconds: 100),
                              curve: Curves.bounceInOut,
                            );
                          },
                          btnText:
                          "Next",
                        ),
                      ),
                    ),
                    Expanded(
                        flex:1,child: Padding(
                      padding:  EdgeInsets.only(bottom: 10,top: 5),
                      child: InkWell(
                          onTap:() async {
                            var sharedprefernce= await SharedPreferences.getInstance();
                            sharedprefernce.setBool('newUser', true);
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Splash_Screen(),
                              ),
                            );
                          },child: Text(' Skip ',style: boldStyle.copyWith(fontSize: 16),).animate().fade()),
                    ))
                  ],
                ),
              ))
        ],
      ),
    );
  }
  ///dot for showing current Page
  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 8,
      width: 8,
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: currentIndex == index
              ? blueGradient
              : const LinearGradient(
              begin: FractionalOffset.topRight,
              end: FractionalOffset.bottomLeft,
              colors:  [Colors.white, Colors.white]



          )),
    );
  }


}
