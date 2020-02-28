import 'package:cdut_social_platform_app/Register.dart';
import 'package:cdut_social_platform_app/color.dart';
import 'package:cdut_social_platform_app/home.dart';
import 'package:flutter/material.dart';
import 'package:cdut_social_platform_app/CdutSpVar.dart';
import 'package:google_fonts/google_fonts.dart';
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Builder(
        builder:(context)=> SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: ListView(
                children: <Widget>[
                  SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          'assets/logo.png',
                          width: 100,
                          height: 100,
                          fit: BoxFit.fill,
                        ),
                      ),
                      SizedBox(height: 15,),
                      Text(
                        '成理表白墙',
                        style: GoogleFonts.zCOOLXiaoWei(
                            fontSize: 24
                        ),
                      ),
                    ],
                    ),
                ),
                  SizedBox(height: 40,),
                  Column(
                    children: <Widget>[
                      CdutSpTextField(
                        hint: '用户名',
                        iconData: Icons.account_circle,
                      ),
                      SizedBox(height: 10,),
                      CdutSpTextField(
                        iconData: Icons.lock,
                        hint: '密码',
                      )
                    ],
                  ),
                  SizedBox(height: 10,),
                  ButtonBar(
                    children: <Widget>[
                      FlatButton(
                        padding: EdgeInsets.symmetric(vertical:5,horizontal: 10),
                        child: Text('新用户注册'),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                        ),
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> RegisterPage()));
                        },
                      ),
                      RaisedButton(
                        color: cdutSpBlue100,
                        padding: EdgeInsets.symmetric(vertical:5,horizontal: 20),
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: Text(
                            '登录',
                        ),
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> HomePage()));
                          /*
                          final LoginSnackBar=SnackBar(
                            content: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                '登录成功',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 18,
                                  letterSpacing: 5
                                ),
                              ),
                            ),
                            action: SnackBarAction(
                              label: '确 认',
                              textColor: cdutSpBlue100,
                              onPressed: (){},
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)
                            ),
                            backgroundColor: cdutSpOrange900,
                            behavior: SnackBarBehavior.floating,
                          );
                          Scaffold.of(context).showSnackBar(LoginSnackBar);

                           */

                        },
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
      ),
    );

  }
}
class CdutSpTextField extends StatelessWidget {
  const CdutSpTextField({Key key, this.child,this.color,this.hint,this.iconData}) :super(key:key);
  final Color color;
  final Widget child;
  final IconData iconData;
  final hint;
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
          hintText: hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(width: 2)
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: cdutSpBlue100,width: 2),
              borderRadius: BorderRadius.circular(10)
          ),
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 10,right: 2),
          child: Icon(
            iconData,
            //color: cdutSpOrange900,
          ),
        ),
      ),
      autofocus: false,
    );
  }
}





