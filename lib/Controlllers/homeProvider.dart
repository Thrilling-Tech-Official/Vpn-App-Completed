import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:vpn_app/Controlllers/pref.dart';
import 'package:vpn_app/Controlllers/services/vpn_engine.dart';
import 'package:vpn_app/Models/vpn.dart';
import 'package:vpn_app/Models/vpn_Configuration.dart';
import 'package:vpn_app/Views/constant.dart';

enum VpnState { disconnected, connected, connecting }


class VpnProvider extends ChangeNotifier {
  Vpn vpn = Pref.vpn;
  var vpnState = VpnEngine.vpnDisconnected;
  String selectedVpnId = '';
  void changevpnState(vpnV){
    vpnState=vpnV;
    notifyListeners();
  }
  void setSelectedVpn(String vpnId) {
    selectedVpnId = vpnId;
    notifyListeners() ;
  }

///For Connection
   connectToVpn(context) async {
    if (vpn.openVPNConfigDataBase64.isEmpty) {
      return  ;
    }

   else  if (vpnState == VpnEngine.vpnDisconnected) {

      final data = Base64Decoder().convert(vpn.openVPNConfigDataBase64);
      final config = Utf8Decoder().convert(data);
      final vpnConfig = VpnConfig(
          country: vpn.countryLong,
          username: 'vpn',
          password: 'vpn',
          config: config);


      await VpnEngine.startVpn(vpnConfig);
      notifyListeners();

    }

    else if (vpnState == VpnEngine.vpnDenied)  {

      final data = Base64Decoder().convert(vpn.openVPNConfigDataBase64);
      final config = Utf8Decoder().convert(data);
      final vpnConfig = VpnConfig(
          country: vpn.countryLong,
          username: 'vpn',
          password: 'vpn',
          config: config);


      await VpnEngine.startVpn(vpnConfig);
      notifyListeners();

    }
    else {
      VpnEngine.stopVpn();
      notifyListeners();

    }
  }


///Get Box Shadow Gradient Color
  Color get getBoxShadowGradientColor {
    switch (vpnState) {
      case VpnEngine.vpnDisconnected:
        return lightGradientblue.withOpacity(0.08);

      case VpnEngine.vpnConnected:
        return gradientgreen.withOpacity(0.09);

      default:
        return gradientyellow.withOpacity(0.09);
    }
  }
  /// for getting Box shadow color
 Color get getBoxShadowColor {
    switch (vpnState) {
      case VpnEngine.vpnDisconnected:
        return blue;

      case VpnEngine.vpnConnected:
        return green;

      default:
        return yellow;
    }
  }
    ///Outer gradient Color
  List<Color> get getGradientDarkColor{
    switch(vpnState){
      case VpnEngine.vpnDisconnected:
        return [

          lightblue.withOpacity(.04),
          lightGradientblue.withOpacity(.03),

        ];
      case VpnEngine.vpnConnected:
        return [

          gradientgreen.withOpacity(.03),
          gradientgreen.withOpacity(.03),
        ];

      default:
        return [

          gradientyellow.withOpacity(.03),
          gradientyellow.withOpacity(.03),
        ];


    }
  }
  List<Color> get getGradientWhiteColor{
    switch(vpnState){
      case VpnEngine.vpnDisconnected:
        return [

          lightblue.withOpacity(.08),
          lightGradientblue.withOpacity(.08),

        ];
      case VpnEngine.vpnConnected:
        return [

          gradientgreen.withOpacity(.08),
          gradientgreen.withOpacity(.08),
        ];

      default:
        return [

          gradientyellow.withOpacity(.08),
          gradientyellow.withOpacity(.08),
        ];


    }
  }
///Button Gradient Color
  List<Color> get getButtonColor {
    switch (vpnState) {
      case VpnEngine.vpnDisconnected:
        return [

          blue,
          gradientblue,
        ];

      case VpnEngine.vpnConnected:
        return [

         green,
          gradientgreen,
          gradientgreen
        ];

      default:
        return [

          yellow,
          gradientyellow,
          gradientyellow
        ];
    }
  }

  /// vpn button text
  String get getButtonText {
    switch (vpnState) {
      case VpnEngine.vpnDisconnected:
        return 'Tap to Connect';

      case VpnEngine.vpnConnected:
        return '  Disconnect   ';

      default:
        return '  Connecting...';
    }
  }


}