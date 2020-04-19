import 'package:cdut_social_platform_app/home.dart';
import 'package:cdut_social_platform_app/login.dart';
import 'package:cdut_social_platform_app/register.dart';
import 'package:flutter/material.dart';
import 'package:cdut_social_platform_app/cdutSpApp.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';
import 'color.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs=await SharedPreferences.getInstance();
  String userName=prefs.getString('userName');
  debugPrint(userName);
  runApp(MaterialApp(
      home: userName == null ? LoginPage() : HomePage(),
      routes: {
        '/home':(context)=>HomePage(),
        '/login':(context)=>LoginPage(),
        '/register':(context)=>RegisterPage(),
      },
      //onGenerateRoute: _getRoute,
      theme: _cdutSpBlueTheme,
    )
  );
}
final ThemeData _cdutSpBlueTheme = _buildCdutSpTheme();


ThemeData _buildCdutSpTheme(){
  final ThemeData base=ThemeData.light();
  return base.copyWith(
      primaryColor: cdutSpBlue100,
      accentColor: cdutSpOrange900,
      buttonTheme: base.buttonTheme.copyWith(
          buttonColor: cdutSpBlue100,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)
          ),
          colorScheme: base.colorScheme.copyWith(
              secondary: cdutSpBlue100
          ),
          textTheme: ButtonTextTheme.primary
      ),
      buttonBarTheme: base.buttonBarTheme.copyWith(
        buttonTextTheme: ButtonTextTheme.primary,
      ),
      inputDecorationTheme: InputDecorationTheme(
          border:OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(width: 2)
          )
      ),
      //textSelectionColor: cdutSpBlack87,
      textTheme: _buildCdutSpTextTheme(base.textTheme),
      accentTextTheme: _buildCdutSpTextTheme(base.accentTextTheme),
      primaryTextTheme: _buildCdutSpTextTheme(base.primaryTextTheme),
      tabBarTheme: base.tabBarTheme.copyWith(
          labelColor: cdutSpWhite
      )
  );
}
TextTheme _buildCdutSpTextTheme(TextTheme base){
  //const textStyle = const TextStyle(fontFamily: 'ZCOOLXiaoWei',);
  return base.copyWith(
    headline: base.headline.copyWith(
      fontFamily:'ZCOOLXiaoWei',
      fontSize: 24,

    ),
    title: base.title.copyWith(
      fontSize: 18.0,
      fontFamily:'ZCOOLXiaoWei',

    ),
    body1: base.body1.copyWith(
        fontSize: 14.0
    ),
    body2: base.body2.copyWith(
        fontWeight: FontWeight.bold
    ),

  ).apply(
      displayColor: cdutSpWhite,
      bodyColor: cdutSpBlack87
  );
}
