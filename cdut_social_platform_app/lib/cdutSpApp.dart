import 'dart:ui';

import 'package:cdut_social_platform_app/Overscroll.dart';
import 'package:cdut_social_platform_app/register.dart';
import 'package:cdut_social_platform_app/home.dart';
import 'package:cdut_social_platform_app/login.dart';
import 'package:cdut_social_platform_app/post.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'tools/cut_corners_border.dart';
import 'package:google_fonts/google_fonts.dart';
import 'color.dart';
class cdutSocialPlatformApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/login',
      routes: {
        '/home':(context)=>HomePage(),
        '/login':(context)=>LoginPage(),
        '/register':(context)=>RegisterPage(),
        '/overscroll':(context)=>OverscrollDemo(),
      },
      //onGenerateRoute: _getRoute,
      theme: _cdutSpBlueTheme,
    );
  }

  Route<dynamic> _getRoute(RouteSettings settings) {
    print(settings.name);
    if (settings.name != '/login') {
      return null;
    }
    return MaterialPageRoute<void>(
        settings: settings,
        builder: (BuildContext context) => HomePage(),
        fullscreenDialog: true
    );
  }


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

/*
  ThemeData _buildCdutSpTheme() {
    final ThemeData base = ThemeData.light();
    return base.copyWith(
      accentColor: cdutSpBlue100,
      primaryColor: cdutSpBlue100,
      scaffoldBackgroundColor: cdutSpBlueBackgroundWhite,
      cardColor: cdutSpBlueBackgroundWhite,
      textSelectionColor: cdutSpOrange900,
      errorColor: cdutSpRed,
      primaryIconTheme: base.iconTheme.copyWith(
          color: cdutSpOrange900
      ),
      buttonTheme: base.buttonTheme.copyWith(
        buttonColor: cdutSpBlue100,
        textTheme: ButtonTextTheme.normal,
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: CutCornersBorder(),
      ),
      textTheme: _buildCdutSpTextTheme(base.textTheme),
      primaryTextTheme: _buildCdutSpTextTheme(base.primaryTextTheme),
      accentTextTheme: _buildCdutSpTextTheme(base.accentTextTheme),
    );
  }

  TextTheme(
      headline: GoogleFonts.zCOOLXiaoWei(
        fontSize: 30
      ),
      title: GoogleFonts.zCOOLKuaiLe(
        fontSize: 20,
        letterSpacing: 5
      ),
      body1: TextStyle(
        fontSize: 16
      )
    ).apply(
      bodyColor: cdutSpWhite
    )
 */



