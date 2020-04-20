import 'package:cdut_social_platform_app/model/User.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Global{
  static User localUser;
  static SharedPreferences preferences;
  static Future<Map> init() async{
    var map=Map<String,dynamic>();
    SharedPreferences prefs=await SharedPreferences.getInstance();
    map['userName']=prefs.getString('userName');
    map['email']=prefs.getString('email');
    map['sex']=prefs.getString('sex');
    map['collage']=prefs.getString('collage');
    map['phoneNumber']=prefs.getString('phoneNumber');
    localUser=User.fromJson(map);
    return map;
  }
}