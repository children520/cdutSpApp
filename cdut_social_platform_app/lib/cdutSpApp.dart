import 'dart:ui';

import 'package:cdut_social_platform_app/Register.dart';
import 'package:cdut_social_platform_app/home.dart';
import 'package:cdut_social_platform_app/login.dart';
import 'package:cdut_social_platform_app/post.dart';
import 'package:flutter/material.dart';
import 'tools/cut_corners_border.dart';
import 'package:google_fonts/google_fonts.dart';
import 'color.dart';
class cdutSocialPlatformApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      initialRoute: '/login',
      onGenerateRoute: _getRoute,
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: cdutSpBlue100,
        accentColor: cdutSpBlue100
      ),
      //theme: _cdutSpBlueTheme,
    );
  }

  Route<dynamic> _getRoute(RouteSettings settings) {
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
    return ThemeData(
      primaryColor: cdutSpBlue100,
      accentColor: cdutSpOrange900,
      textTheme: TextTheme(
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
  TextTheme _buildCdutSpTextTheme(TextTheme base){
    return base.copyWith(
      headline: base.headline.copyWith(
        fontWeight: FontWeight.w500,
      ),
      title: base.title.copyWith(
        fontSize: 18.0
      ),
      caption: base.title.copyWith(
        fontSize: 14.0
      ),
      body1: base.body1.copyWith(
        fontSize: 16.0
      )
    ).apply(
      displayColor: cdutSpOrange900,
      bodyColor: cdutSpOrange900
    );
  }

 */



