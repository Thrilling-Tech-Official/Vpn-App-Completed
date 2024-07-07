import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vpn_app/Controlllers/homeProvider.dart';
import 'package:vpn_app/Controlllers/locationProvider.dart';
import 'package:vpn_app/Controlllers/pref.dart';
import 'package:vpn_app/Views/Screens/Splash_Screen.dart';
import 'package:vpn_app/Views/Screens/onBoardingScreen.dart';
import 'package:vpn_app/Views/constant.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
   await Pref.initializeHive();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp());
  });
}
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

///For Checking the user is new or not
  bool newUser= false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WheretoGo();
  }

  Check() async{
    await  WheretoGo();
  }

  ///For checking if user is new or old user
  WheretoGo() async {
    var sharedpreference = await SharedPreferences.getInstance();
    var user = sharedpreference.getBool('newUser');
    print(user);
    if (user != null) {
      if (user) {
        setState(() {
          newUser = true;
        });
      } else {
        setState(() {
          newUser = false;

        });
      }
    } else {
      setState(() {
        newUser = false;

      });
    }

  }
  @override
  Widget build(BuildContext context) {
    return
      MultiProvider(
        providers: [
          ChangeNotifierProvider<VpnProvider>( create: (context) => VpnProvider()),
          ChangeNotifierProvider<LocationProvider>( create: (context) => LocationProvider()),

        ],
        child: Builder(
          builder: (context) {

            return MaterialApp(
              theme: ThemeData(
                textSelectionTheme: TextSelectionThemeData(
                  cursorColor: IconBluecolor,
                ),
                scaffoldBackgroundColor: primarycolor,
                appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent,centerTitle: true,
                    systemOverlayStyle: SystemUiOverlayStyle(statusBarColor:primarycolor, systemNavigationBarColor:primarycolor, )
                ),
                brightness: Brightness.light,
                unselectedWidgetColor: Colors.white,
                toggleableActiveColor: Colors.yellow,
                // canvasColor: Colors.transparent



              ),

              debugShowCheckedModeBanner: false,
              home: newUser ? Splash_Screen(): OnBoardingScreen()   ,
            );
          }
        ),
      );}




}

