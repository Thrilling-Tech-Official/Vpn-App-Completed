import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:vpn_app/Controlllers/locationProvider.dart';
import 'package:vpn_app/Models/vpn.dart';
import 'package:vpn_app/Views/constant.dart';
import 'package:vpn_app/Views/customWidget/CountryCard.dart';
import 'package:vpn_app/Views/customWidget/VpnCard.dart';
import 'package:vpn_app/Views/customWidget/alertbox.dart';





class LocationScreen extends StatefulWidget {
   final List<Vpn>   serverList;
   final List<String> countries;
   final List<String> flags;

  LocationScreen({Key? key,required this.serverList,required this.flags,required this.countries}) : super(key: key);

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  final String apiURL = "http://www.vpngate.net/api/iphone";
  List<String> countries = [];
  String ? selectedCountry;
  List<Vpn> servers = [];
  List<String> flags = [];
  bool istap=false;
  String ?  expandedCountry;

  @override
  void initState() {
    super.initState();
    gettingServers();
  }



  void gettingServers() async {
    final locationController = Provider.of<LocationProvider>(context, listen: false);

    try {
      // Check if data has already been loaded
      if (widget.countries.isEmpty) {
        print(widget.countries.length);
        // Load VPN and countries data

        if(locationController.vpnList.isEmpty){
          await locationController.getVpnData();

        }
        if(locationController.countrylist.isEmpty ||  locationController.flaglist.isEmpty){
          await locationController.getCountriesData();

        }

        // Update state if component is still mounted
        if (mounted) {
          setState(() {
            servers = locationController.vpnList;
            countries = locationController.countrylist;
            flags = locationController.flaglist;
            print(servers.length);
          });
        }
      } else {
        // Use data already provided
        print(widget.countries.length);
        if (mounted) {
          setState(() {
            servers = widget.serverList;
            countries = widget.countries;
            flags = widget.flags;
          });
        }
      }
      // Debugging information
      print('Checking country ${countries.length}');
      print(flags.length);
    } catch (e) {
      print('Error in getting servers: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    final locationController = Provider.of<LocationProvider>(context, listen: false);
    return Scaffold(

      resizeToAvoidBottomInset: true,
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('Location',style: boldStyle,),
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back,color: Colors.white,size: 26,),
        ),
        elevation: 0,
      ),

      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///for Extra Space
              Expanded(flex: 2, child: Container()),

              Expanded(
                flex: 12,
                child: locationController.isLoading
                    ? _loadingWidget(context)
                    : locationController.vpnList.isEmpty
                    ? _noVPNFound(context)
                    : serversData(),

              )

            ],
          ),
        ),
      ),
    );
  }
  ///Loading Indicator
  _loadingWidget(context) => SizedBox(
    width: double.infinity,
    height: double.infinity,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ///lottie animation
        LottieBuilder.asset(
          'assets/animation/loading.json',
          width: 220,
        ),

        /// loading text
        Text(
          'Loading Servers ....',
          style: boldStyle.copyWith(
              fontSize: 17, color:white),
        ).animate().fade().slideX(curve: Curves.easeIn)
      ],
    ),
  );
  ///InCase there is no Data
  _noVPNFound(context) => alertBox(txt: ' Sorry ,VPNs Not Found! 😔', );

  serversData(){
    final locationController = Provider.of<LocationProvider>(context);




      return   ListView.builder(
        padding: EdgeInsets.only(top: 4.0),
        shrinkWrap: true,
        itemCount:  countries.length,
        itemBuilder: (context, index) {
          final country = countries[index];
          final flag = flags[index];
          return     locationCard(


              isExpanded: country == expandedCountry,
              countryName: country,
              flag: flag,
              tap: (istap) async {
                setState(() {
                  if(expandedCountry ==country){
                    expandedCountry= null;
                    istap =false;
                    servers=locationController.vpnList;

                  }
                  else{
                    expandedCountry=country;
                    istap=true;
                    List<Vpn> specificCountryServers= serversForSelectedCountry(country,context);
                    servers=specificCountryServers;
                  }
                });

              },
              servers:locationController.vpnList.isEmpty ?
              [ CircularProgressIndicator()] :
              servers.asMap().entries.map((MapEntry<int, Vpn> entry) {
            bool isLastElement = entry.key == servers.length - 1;

            return    VpnCard(vpn: entry.value

            );

          }

          ).toList()



          );
        },
      );
    }

  List<Vpn> serversForSelectedCountry(String country,context) {
    final locationController = Provider.of<LocationProvider>(context, listen: false);

    // Filter servers based on the selected country
    List<Vpn> data =  locationController.vpnList;
    for (Vpn server in data) {
      print('CountryLong: ${server.countryLong}');
    }
    List<Vpn>  myservers = data.where((server) => server.countryLong.toLowerCase() == country.toLowerCase()).toList();
    print('myservers.length ${myservers.length}');
    return myservers;

  }
}

