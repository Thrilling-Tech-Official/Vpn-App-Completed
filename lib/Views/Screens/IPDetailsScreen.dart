
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:vpn_app/Controlllers/APIs/APIs.dart';
import 'package:vpn_app/Models/ip_Details.dart';
import 'package:vpn_app/Views/constant.dart';
import 'package:vpn_app/Views/customWidget/IPDetailCard.dart';
class IPDetailsScreen extends StatefulWidget {
  const IPDetailsScreen({Key? key}) : super(key: key);

  @override
  _IPDetailsScreenState createState() => _IPDetailsScreenState();
}

class _IPDetailsScreenState extends State<IPDetailsScreen> {
  var data;
  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }
  ///Getting IP Details
  getData()async{
    var  ipData = IPDetails.fromJson({});
    var d = await  APIs.getIPDetails(ipData: ipData);
    data=d;
    setState(() {

    });

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      extendBodyBehindAppBar: true,

      appBar: AppBar(
        title: Text('IP Address Details',style: boldStyle,),
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back,color: Colors.white,size: 26,),
        ),
        elevation: 0,
      ),


            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ///for Extra Space
                Expanded(flex:1,child: Container()),
                ///Main  Connection Button
                Expanded(flex:8,child: ListView(
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.only(
                        top: 15,
                        bottom: 1,
                        left: 12,
                        right: 12),
                    children: [
                      ///IP
                      IPDetailCard(title: 'IP Address', subtitle:  data?.query ?? 'Loading...',
                          child: Image.asset('assets/images/ipAddress.png',)),


                      ///isp
                      IPDetailCard(title: 'Internet Provider', subtitle:  data?.isp ?? 'Loading...', child: const Icon(CupertinoIcons.antenna_radiowaves_left_right,size: 22, color:Colors.white), ),

                      ///location
                      IPDetailCard(title: 'Location', subtitle:(data != null && data.country != null && data.country.isNotEmpty)
                          ? '${data.city}, ${data.regionName}, ${data.country}'
                          : 'Fetching ...', child: const Icon(CupertinoIcons.location_solid,
                          size: 22, color:Colors.white)),

                      ///pin code
                      IPDetailCard(title: 'Pin-code', subtitle: data?.zip??'Loading....',
                          child: Icon(Icons.lock_outlined,color: Colors.white,size: 22,)),


                      ///timezone
                      IPDetailCard(title: 'Timezone', subtitle: data?.timezone??'Loading...', child: const Icon(CupertinoIcons.time,
                          size: 22, color:Colors.white))

                    ]).animate().fade().slideX(curve: Curves.easeIn)),


              ],
            ),
    );
  }

}
