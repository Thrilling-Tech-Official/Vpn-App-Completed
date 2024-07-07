import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vpn_app/Controlllers/homeProvider.dart';
import 'package:vpn_app/Controlllers/locationProvider.dart';
import 'package:vpn_app/Controlllers/services/vpn_engine.dart';
import 'package:vpn_app/Models/vpn.dart';
import 'package:vpn_app/Models/vpn_status.dart';
import 'package:vpn_app/Views/Screens/IPDetailsScreen.dart';
import 'package:vpn_app/Views/Screens/LocationScreen.dart';
import 'package:vpn_app/Views/Screens/SideNavigationBar.dart';
import 'package:vpn_app/Views/constant.dart';
import 'package:vpn_app/Views/customWidget/CountdownTimer.dart';
import 'package:vpn_app/Views/customWidget/homeCard.dart';
import 'package:vpn_app/Views/customWidget/ConnectionStatus.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<Vpn>  vpnList=[];
  List<String> countrtylist=[];
  List<String> flaglist=[];
  @override
  void initState() {
    super.initState();
    ///getting all server
    gettingServers();

  }
  ///getting all server

  void gettingServers(){
    final locationController = Provider.of<LocationProvider>(context, listen: false);
    locationController.getVpnData(); // Load data in initState
    locationController.getCountriesData();
    setState(() {
      vpnList=locationController.vpnList;
      countrtylist=locationController.countrylist;
      flaglist=locationController.flaglist;
    });

  }




  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<VpnProvider>(context);

    ///Add listener to update vpn state
    VpnEngine.vpnStageSnapshot().listen((event) {
      homeProvider.changevpnState(event);
    });
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      drawer: Container(width: 240, child: SideNavigationBar(),color: Colors.transparent,),
      appBar: AppBar(
        title: Text('SwiftShield'.toUpperCase(),
            style: logoText.copyWith(fontSize:22,color:white)),
        elevation: 0,
        leading: Builder(
            builder: (context) => // Ensure Scaffold is in context
                IconButton(
                    icon: Icon(Icons.menu,
                        color:white, size: 26),
                    onPressed: () => Scaffold.of(context).openDrawer())),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: ((context) => LocationScreen(serverList: vpnList,countries: countrtylist,flags: flaglist,))));
            },
            icon: Icon(CupertinoIcons.globe,
                color:white, size: 28),
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ///for Extra Space
          Expanded(child: Container()),

          ///Main  Connection Button
          Expanded(
              flex: 5,
              child: Container(
                child: vpnConnectButton(context),
              )),

          ///Connection status label
          Expanded(
              flex: 1,
              child: ConnectionStatusLabel(context)),
          SizedBox(height: 8,),

          ///Timer
          Expanded(
              flex: 1,
              child: CountDownTimer(
                startTimer: homeProvider.vpnState == VpnEngine.vpnConnected,
              )),

          ///Connected Vpn Server details
          Expanded(
              flex: 5,
              child: Container(
                child: ConnectedVpnDetails(context),
              )),

        ],
      )
    );
  }

  ///Connection Button

  Widget vpnConnectButton(context) {
    final homeProvider = Provider.of<VpnProvider>(context);
    return Semantics(
      button: true,
      child: InkWell(
        onTap: () {
          // homeProvider.changevpnState(VpnEngine.vpnDisconnected);
          homeProvider.connectToVpn(context);
        },
        borderRadius: BorderRadius.circular(100),
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
                begin: FractionalOffset.topRight,
                end: FractionalOffset.bottomLeft,
                colors:  homeProvider.getGradientWhiteColor ),
            boxShadow: [
              BoxShadow(
                color: homeProvider.getBoxShadowGradientColor,
                spreadRadius: 8,
                blurRadius: 8,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                  begin: FractionalOffset.topRight,
                  end: FractionalOffset.bottomLeft,
                  colors:  homeProvider.getGradientWhiteColor

              ),
              boxShadow: [
                BoxShadow(
                  color: homeProvider.getBoxShadowGradientColor,
                  spreadRadius: 6,
                  blurRadius: 6,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Container(
              padding: EdgeInsets.all(18),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                    begin: FractionalOffset.topRight,
                    end: FractionalOffset.bottomLeft,
                    colors: homeProvider.getButtonColor),
                boxShadow: [
                  BoxShadow(
                    color: homeProvider.getBoxShadowColor.withOpacity(0.1),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Container(
                padding: EdgeInsets.all(19),
                decoration: BoxDecoration(shape: BoxShape.circle, color: white),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ///icon
                      const Icon(
                        Icons.power_settings_new,
                        size: 30,
                        color: IconBluecolor,
                      ),
                      SizedBox(height: 4,),

                      ///text
                      Text(
                        homeProvider.getButtonText,
                        style: grayTextStyle,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  ///Connection Status
  Widget ConnectionStatusLabel(context) {
    final homeProvider = Provider.of<VpnProvider>(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 78, ),
      child: ConnectedStateText(
        btnText: homeProvider.vpnState == VpnEngine.vpnDisconnected
            ? 'Not Connected'
            : homeProvider.vpnState
                .toString()
                .replaceAll('_', ' ')
                .toUpperCase(),
      ),
    ); //connection status label
  }

  ///Connected VPN Details
  Widget ConnectedVpnDetails(context) {
    final homeProvider = Provider.of<VpnProvider>(context);
    return Padding(
      padding: const EdgeInsets.only(left: 10,right: 10),
      child: Column(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ///country flag
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => IPDetailsScreen())));
                    },

                    child: HomeCard(
                      title: homeProvider.vpn.countryLong.isEmpty
                          ? 'Country'
                          : homeProvider.vpn.countryLong,
                      subtitle: 'Free',
                      icon: Icons.vpn_lock_rounded,
                      iconColor: homeProvider.vpn.countryLong.isEmpty
                          ? Colors.white
                          : Colors.transparent,
                      image: homeProvider.vpn.countryLong.isEmpty
                          ? null
                          :  'assets/flags/${homeProvider.vpn.countryShort.toLowerCase()}.png',
                    ),
                  ),
                ),

                ///ping time
                Expanded(
                  child: HomeCard(
                    title: homeProvider.vpn.countryLong.isEmpty
                        ? '100 ms'
                        : '${homeProvider.vpn.ping} ms',
                    subtitle: 'PING',
                    icon:CupertinoIcons.chart_bar_alt_fill,

                  ),

                ),
              ],
            ),
          ),
          Expanded(
              child: StreamBuilder<VpnStatus?>(
                  initialData: VpnStatus(),
                  stream: VpnEngine.vpnStatusSnapshot(),
                  builder: (context, snapshot) {
                    final byteIn = (snapshot.data?.byteIn) ?? 0;
                    final byteOut = (snapshot.data?.byteOut) ?? 0;
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ///download
                        Expanded(
                          child: HomeCard(
                            title: byteIn == 0 ? '0 kbps' : '$byteIn kbps',
                            subtitle: 'Download',
                            icon: Icons.arrow_downward_rounded,
                          ),
                        ),

                        ///upload
                        Expanded(
                          child: HomeCard(
                            title: byteOut == 0 ? '0 kbps' : '$byteOut kbps',
                            subtitle: 'Upload',
                            icon: Icons.arrow_upward_rounded,
                          ),
                        ),
                      ],
                    );
                  }))
        ],
      ),
    );
  }
}
