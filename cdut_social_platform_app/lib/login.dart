import 'dart:convert';
import 'package:cdut_social_platform_app/model/User.dart';
import 'package:cdut_social_platform_app/register.dart';
import 'package:cdut_social_platform_app/color.dart';
import 'package:cdut_social_platform_app/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class LoginPage extends StatefulWidget {
  static const routeName = '/login';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var result=Map();
  final GlobalKey<ScaffoldState> _scaffoldKey=GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey=GlobalKey<FormState>();
  bool _autoValidate=false;
  Future<http.Response> _futureUser;
  String userName;
  @override
  void initState() {
    super.initState();
    //getUserState();
  }
  Future<String> getUserState() async{

  }
  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Builder(
        builder:(context)=> SafeArea(
            child: Form(
              key: _formKey,
              autovalidate: _autoValidate,
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
      ),
    );

  }

  _NavigateRegisterRoute(BuildContext context) async{

    result =await Navigator.push(context,
      MaterialPageRoute(builder: (context)=>RegisterPage()),
    );
    print(result);
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
              onPressed: () {
                _handleLogin(context);

                /*
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



                Future.delayed(Duration(seconds: 2),(){

                });
                */
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
                  text: result['userName']==null?'':result['userName']
              )
          ),
          onFieldSubmitted: (String value){
            result['userName']=value;
          },
        ),
        SizedBox(height: 10,),
        CdutSpTextField(
          hint: '密码',
          obscureText: true,
          iconData:  Icons.lock,
          validator: _ValidatePassword,
          controller: TextEditingController.fromValue(
              TextEditingValue(
                  text: result['password']==null?'':result['password']
              )
          ),
          onFieldSubmitted: (String value){
            result['password']=value;
          },
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
  void _handleLogin(BuildContext context){
    final FormState formState=_formKey.currentState;
    if(!formState.validate()){
      _autoValidate=true;
      //showInSnackBar('请更正提交之前的错误！');
    }else {
      formState.save();
      showInSnackBar("正在登录......");
      Future.delayed(Duration(seconds: 2),(){
        setState(() {
          _futureUser=userLogin(result['userName'], result['password']);
        });
        _futureUser.then((response){
          Map<String,dynamic> responseJson=json.decode(response.body);
          if(response.statusCode==200){
            showInSnackBar(responseJson['userName']+'登录成功');
            saveUserState(User.fromJson(responseJson)).then((_){
              Future.delayed(Duration(seconds: 2),(){
                Navigator.pushNamedAndRemoveUntil(context, HomePage.routeName,(route)=> route==null);
              });
            }).catchError((onError){
              print(onError);
            });
          }else{
            showInSnackBar(responseJson['message']);
          }

        });

      });
    }
  }
  Future<http.Response> userLogin(String userName,String password) async{
    final http.Response response=await http.Client().post(
      'http://10.0.2.2:8080/user/login',
      headers: <String,String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String,String>{
        'userName':userName,
        'password':password,
      }),
    );

    //Map<String,dynamic> responseJson=json.decode(response.body);
    /*
    if(response.statusCode==200){
      showInSnackBar(responseJson['userName']+'登录成功');
    }else{
      showInSnackBar(responseJson['message']);
    }

     */
    return response;
  }

  Future<String> saveUserState(User user) async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    prefs.setString('userName', user.userName);
    prefs.setString('email', user.email);
    prefs.setString('phoneNumber', user.phoneNumber);
    prefs.setString('sex', user.sex);
    prefs.setString('collage', user.collage);
  }

  void showInSnackBar(String value){
    _scaffoldKey.currentState..removeCurrentSnackBar()..showSnackBar(SnackBar(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
              value
          ),
          SizedBox(
            height: 25,
            width: 25,
            child: CircularProgressIndicator(
              backgroundColor: cdutSpBlue100,
              valueColor: new AlwaysStoppedAnimation(cdutSpOrange900),
            ),
          )
        ],
      ),duration: Duration(seconds: 2),
    ));
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
    this.validator,
    this.onFieldSubmitted
  }):super(key :key);

  final Color color;
  final bool obscureText;
  final FormFieldValidator<String> validator;
  final Widget child;
  final IconData iconData;
  final TextEditingController controller;
  final hint;
  final ValueChanged<String> onFieldSubmitted;

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
      onFieldSubmitted: onFieldSubmitted,
    );
  }
}







