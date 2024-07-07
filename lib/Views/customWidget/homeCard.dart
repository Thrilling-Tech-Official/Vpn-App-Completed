import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vpn_app/Views/constant.dart';


class HomeCard extends StatelessWidget {
  final String title, subtitle;
  final IconData icon;
  final   image;
  final Color iconColor;

  const HomeCard(
  {super.key,
  required this.title,
  required this.subtitle,
  required this.icon,this.image=null,this.iconColor=Colors.white});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Column(
          children: [
            ///icon
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Container(
                height: 50,
                width: 50,
                decoration:  image !=null ?  BoxDecoration(gradient:blueGradient,
                    shape: BoxShape.circle,
                 image: DecorationImage(image: AssetImage(image),fit: BoxFit.cover)
                ):
                BoxDecoration(gradient:blueGradient,
                    shape: BoxShape.circle,
                ) ,
                child: Icon(icon,
                    size: 26, color:iconColor),
              ),
            ),

            ///title
            Text(title,
                style:btntext.copyWith(fontSize: 13.5,color: white),overflow: TextOverflow.ellipsis),
           SizedBox(height: 2,),


           ///subtitle
            Text(
              subtitle,
              style: grayTextStyle.copyWith(color: lightGray),
            ),
          ],
        ));
  }
}