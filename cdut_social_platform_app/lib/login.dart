import 'package:cdut_social_platform_app/register.dart';
import 'package:cdut_social_platform_app/color.dart';
import 'package:cdut_social_platform_app/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class LoginPage extends StatefulWidget {
  static const routeName = '/login';
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String result='';
  @override
  void initState() {
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder:(context)=> SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: ListView(
                children: <Widget>[
                  SizedBox(height: 30),
                  _BuildTitle(),
                  SizedBox(height: 40,),
                  _BuildTextFormField(),
                  SizedBox(height: 10,),
                  _BuildButtonBar(context)
                ],
              ),
            ),
          ),
      ),
    );

  }
  _NavigateRegisterRoute(BuildContext context) async{
    result =await Navigator.push(context,
      MaterialPageRoute(builder: (context)=>RegisterPage()),
    );
  }

  Widget _BuildButtonBar(BuildContext context){
    return ButtonBar(
      alignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        FlatButton(
          padding: EdgeInsets.symmetric(vertical:5,horizontal: 5),
          child: Text('忘记密码'),
          onPressed: (){
            //Navigator.push(context, MaterialPageRoute(builder: (context)=> RegisterPage()));
          },
        ),
        Row(
          children: <Widget>[
            FlatButton(
              padding: EdgeInsets.symmetric(vertical:5,horizontal: 10),
              child: Text('新用户注册'),
              onPressed: (){
                _NavigateRegisterRoute(context);
              },
            ),
            RaisedButton(
              padding: EdgeInsets.symmetric(vertical:5,horizontal: 20),
              elevation: 8,
              child: Text(
                '登录',
              ),
              onPressed: (){
                Scaffold.of(context).showSnackBar(
                    SnackBar(content: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('正在登录......'),
                        SizedBox(
                            width: 25,
                            height: 25,
                            child: CircularProgressIndicator(
                              backgroundColor: cdutSpBlue100,
                              valueColor: new AlwaysStoppedAnimation(cdutSpOrange900),
                            )
                        )
                      ],
                    ),duration: Duration(seconds: 2),)
                );
                /*
                Scaffold.of(context)
                  ..removeCurrentSnackBar()
                      ..showSnackBar(
                    SnackBar(content: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('登录成功'),
                        SizedBox(
                            width: 25,
                            height: 25,
                            child: CircularProgressIndicator(
                              backgroundColor: cdutSpBlue100,
                              valueColor: new AlwaysStoppedAnimation(cdutSpOrange900),
                            )
                        )
                      ],
                    ),duration: Duration(seconds: 4),)
                );

                 */
                Future.delayed(Duration(seconds: 2),(){
                  Navigator.pushNamed(context, HomePage.routeName);
                });
              },
            )
          ],
        ),
      ],
    );
  }

  Widget _BuildTextFormField(){
    return Column(
      children: <Widget>[
        CdutSpTextField(
          hint: '用户名',
          iconData:  Icons.account_circle,
          validator: _ValidateUserName,
          controller: TextEditingController.fromValue(
              TextEditingValue(
                  text: result==null?'':result
              )
          ),
        ),
        SizedBox(height: 10,),
        CdutSpTextField(
          hint: '密码',
          obscureText: true,
          iconData:  Icons.lock,
          validator: _ValidatePassword,
          controller: TextEditingController.fromValue(
              TextEditingValue(
                  text: result==null?'':result
              )
          ),
        ),
      ],
    );
  }
  Widget _BuildTitle(){
    return Padding(
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
              style: Theme.of(context).textTheme.headline
          ),
        ],
      ),
    );
  }

  String _ValidateUserName(String value) {
    if(value.isEmpty){
      return '用户名不能为空';
    }
    return null;
  }

  String _ValidatePassword(String value) {
    if(value.isEmpty){
      return '密码不能为空';
    }
    return null;
  }
}
class CdutSpTextField extends StatelessWidget {
  CdutSpTextField({
    Key key,
    this.child,
    this.color,
    this.hint,
    this.obscureText,
    this.iconData,
    this.controller,
    this.validator
  }):super(key :key);

  final Color color;
  final bool obscureText;
  final FormFieldValidator<String> validator;
  final Widget child;
  final IconData iconData;
  final TextEditingController controller;
  final hint;


  @override
  Widget build(BuildContext context) {

    return TextFormField(
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
      controller: controller,
      validator: validator,
      obscureText: obscureText==null?false:obscureText,
    );
  }
}







