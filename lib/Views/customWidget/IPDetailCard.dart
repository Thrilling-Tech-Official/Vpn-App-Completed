import 'package:flutter/material.dart';
import 'package:vpn_app/Views/constant.dart';
class IPDetailCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget child;

  const IPDetailCard({Key? key,required this.title,required this.subtitle,required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Container(
        height: 78,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color:primarycolor.withOpacity(0.8),
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(0, 1), // changes position of shadow
            ),
          ],
        ),
        child: Card(
            elevation: 5,
            color: primarycolor,
            // margin: EdgeInsets.symmetric(vertical: 8.h,horizontal: 10.h),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            child: ListTile(
              shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),

              /// flag
              leading: Container(
                decoration: const BoxDecoration(gradient:blueGradient,
                    shape: BoxShape.circle),
                child: CircleAvatar(
                  radius: 21,
                  backgroundColor: Colors.transparent,
                  child:
                  Center(
                    child: child
                  ),
                ),
              ),

              ///title
              title: Text(title,style: boldStyle.copyWith(fontSize: 16,color: white),),

              ///subtitle
              subtitle: Text(subtitle, style: MediumStyle.copyWith(color: MediumGray,fontSize: 13))

            )),
      ),
    );
  }
}
