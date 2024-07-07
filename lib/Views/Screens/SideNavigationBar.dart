import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:store_redirect/store_redirect.dart';
import 'package:vpn_app/Views/Screens/IPDetailsScreen.dart';
import 'package:vpn_app/Views/Screens/LocationScreen.dart';
import 'package:vpn_app/Views/constant.dart';
import 'package:vpn_app/Views/customWidget/DrawerItem.dart';


class SideNavigationBar extends StatefulWidget {
  const SideNavigationBar({Key? key}) : super(key: key);

  @override
  _SideNavigationBarState createState() => _SideNavigationBarState();
}

class _SideNavigationBarState extends State<SideNavigationBar> {

  @override
  Widget build(BuildContext context) {

    return Drawer(backgroundColor: primarycolor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child:ListView(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        children: <Widget>[
          ///Logo with Text
          Padding(
            padding:  EdgeInsets.only(top: 35),
            child: Container(
              height:120,
              width: 240,

              child:Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/images/logo.svg',width: 70,height: 70,),
                    SizedBox(height: 10,),
                    Text('SwiftShield'.toUpperCase() ,style: logoText.copyWith(fontSize:20,color:white),).animate().fade().slideX(curve: Curves.easeIn)

                  ]) ,

            ),
          ),

          ///Divider
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 15),
            child: Divider(color: dividerColor, thickness: 0.8,),
          ),
          SizedBox(height: 20,),
          ///IP Details Screen
          DrawerItem(
            leading: CupertinoIcons.info_circle,
            title: 'IP Details',myindex: 1,
            onTap: () {

              ///CLose Navigator drawer before
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context)=>IPDetailsScreen()));
            },
          ),

          ///Server Location Screen
          DrawerItem(
            leading:  CupertinoIcons.globe,
            title: 'Server List',
            myindex: 2,
            onTap: () {


              ///CLose Navigator drawer before
              ///CLose Navigator drawer before
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context)=>LocationScreen(serverList: [],countries: [],flags: [],)));
            },
          ),

          ///Divider
          Padding(
            padding:  EdgeInsets.symmetric(vertical: 15,horizontal: 5),
            // child: Divider(color: MidGray),
            child: Divider(color: dividerColor,endIndent: 5,indent: 5,),
          ),

          Padding(
            padding: EdgeInsets.symmetric(
                vertical: 5, horizontal: 20),
            child: Text('Communicate',
                style: boldStyle.copyWith(fontSize: 14,color: MidGray)),
          ),
          SizedBox(height: 8,),

          ///Share APP
          DrawerItem(
            leading: Icons.share,
            title: 'Share App',
            myindex: 3  ,
            onTap: () async {
              ///Share APP with other users

              /// Set the app link and the message to be shared
              final String appLink = 'https://play.google.com/store/apps/details?id=com.vpn.newProject';
              final String message = 'Check out Our app: $appLink';

              /// Share the app link and message using the share dialog
              await FlutterShare.share(title: 'Share App', text: message, linkUrl: appLink);

            },
          ),

          ///Rate App
          DrawerItem(
            leading: CupertinoIcons.star,
            title: 'Rate Us',
            myindex: 4,
            onTap: () {

              ///  dialog Box For Rating
              showDialog(
                context: context,
                barrierDismissible: true, // set to false if you want to force a rating
                builder: (context) => RateUS,
              );
            },
          ),


          SizedBox(height: 40,),


        ],
      ),
    );}
    ///Rating DialogBox
    final RateUS= RatingDialog(starColor: IconBluecolor,
      initialRating: 1.0,

      title: Text('Rate Us',),starSize: 35,
      /// encourage your user to leave a high rating?
      message: Text(
        'Rate your experience with a simple tap on the stars. Add extra details to share your feedback',
        textAlign: TextAlign.center,
        style: grayTextStyle,
      ),
      onCancelled: (){

      },

      onSubmitted: (response){
      ///  For Rating
      StoreRedirect.redirect(androidAppId: 'com.vpn.newProject',iOSAppId: 'com.vpn.newProject');
    },      submitButtonText: 'Submit',
      submitButtonTextStyle: boldStyle.copyWith(color: IconBluecolor,fontSize: 20 ),
    );
}


