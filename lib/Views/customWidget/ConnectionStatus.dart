import 'package:flutter/material.dart';
import 'package:vpn_app/Views/constant.dart';


class ConnectedStateText extends StatelessWidget {
  final String btnText;
  const ConnectedStateText({super.key, required this.btnText});

  @override
  Widget build(BuildContext context) {
    return  Container(
      height:50,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: IconBluecolor,
          borderRadius: BorderRadius.circular(25),
      ),
      margin: EdgeInsets.symmetric(horizontal:5,vertical: 5 ),
      child: Center(child: Text(btnText,style: boldStyle.copyWith(fontSize: 16))) ,
    );
  }
}
