// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:vpn_app/Controlllers/ThemeChanger.dart';
// import 'package:vpn_app/Views/constant.dart';
//
// class AppTheme {
//   static Color getColor(BuildContext context) {
//     final themeChanger = Provider.of<ThemeChanger>(context, listen: false);
//     return themeChanger.themeMode == ThemeMode.dark ? black : white;
//   }
//   static Color getBackgroundColor(BuildContext context){
//     return Provider.of<ThemeChanger>(context, listen: false).themeMode==ThemeMode.dark  ? white : primarycolor ;
//   }
//   static Color getCardColor(BuildContext context){
//     return Provider.of<ThemeChanger>(context, listen: false).themeMode==ThemeMode.dark  ?  white :primarycolor  ;
//   }
//   static Color getGrayColor(BuildContext context){
//     return Provider.of<ThemeChanger>(context, listen: false).themeMode==ThemeMode.dark  ?  lightGray :  darkGray ;
//   }
//   static Color getMediumGrayColor(BuildContext context){
//     return Provider.of<ThemeChanger>(context, listen: false).themeMode==ThemeMode.dark  ?  MediumGray :  MidGray ;
//   }
// }